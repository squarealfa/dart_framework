import 'dart:convert';

import 'package:jose/jose.dart';
import 'package:http/http.dart' as http;
import 'package:squarealfa_security/squarealfa_security.dart';

import 'invalid_signature_exception.dart';

class FirebaseTokenHandler {
  static Future<JwtPayload> getJwtPayload(String firebaseIdToken) async {
    final idToken = firebaseIdToken.startsWith('Bearer ')
        ? firebaseIdToken.substring(7)
        : firebaseIdToken;
    final b64Header = idToken.split('.')[0];
//    var jsonHeader = utf8.decode(base64Decode(header));
    var jsonHeader = decodeB64Json(b64Header);
    final map = jsonDecode(jsonHeader);
    final keyId = map['kid'];

    final ks = await _getKeyStore(keyId);
    final jwt = await JsonWebToken.decodeAndVerify(idToken, ks);
    if (!(jwt.isVerified ?? false)) {
      throw InvalidSignatureException();
    }

    final claims = jwt.claims;

    final payload = JwtPayload(
      audience: claims.audience?.first ?? '',
      expires: claims.expiry ?? DateTime.now(),
      issuer: claims.issuer?.toString() ?? '',
      name: claims.getTyped('name'),
      notBefore:
          claims.notBefore ?? DateTime.now().subtract(Duration(seconds: 1)),
      subject: claims.getTyped('sub'),
      username: claims.getTyped('email'),
      emailVerified: claims.getTyped('email_verified'),
      isVerified: true,
    );
    return payload;
  }
}

var _keyStores = <String, JsonWebKeyStore>{};

Future<JsonWebKeyStore> _getKeyStore(String keyId) async {
  if (!_keyStores.containsKey(keyId)) {
    await _updateKeyCache();
  }
  final key = _keyStores[keyId];
  return key!;
}

Future<void> _updateKeyCache() async {
  final response = await http.get(Uri.parse(
      'https://www.googleapis.com/robot/v1/metadata/x509/securetoken@system.gserviceaccount.com'));
  final rkeys = response.body;
  final jKeys = jsonDecode(rkeys) as Map<String, dynamic>;

  _keyStores = jKeys.map((kid, v) {
    final existing = _keyStores[kid];
    if (existing != null) {
      return MapEntry<String, JsonWebKeyStore>(kid, existing);
    }
    final newKeyStore = JsonWebKeyStore()
      ..addKey(JsonWebKey.fromPem(v, keyId: kid));
    return MapEntry<String, JsonWebKeyStore>(kid, newKeyStore);
  });
}
