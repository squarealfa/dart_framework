import 'dart:async';
import 'dart:typed_data';
import 'dart:convert';
import 'package:cryptography/cryptography.dart';

/// Generates salts and password hashes
class Password {
  /// Creates a random salt.
  static Future<Uint8List> generateSalt() async {
    var keyData = await SecretKeyData.random(length: 40).extract();
    var ret = Uint8List.fromList(keyData.bytes);

    return ret;
  }

  static List<int> _getCodeUnitBytes(List<int> codeUnits) {
    var ret = List<int>.filled(codeUnits.length * 2 + 2, 0, growable: true);
    ret[0] = 255;
    ret[1] = 254;
    for (var i = 0; i < codeUnits.length; i++) {
      var value = codeUnits[i];
      var high = value >> 8;
      var low = value - (high << 8);
      ret[i * 2 + 2] = low;
      ret[i * 2 + 3] = high;
    }
    return ret;
  }

  /// Hashes a password and its salt.
  static Future<String> getSaltedPasswordHash(
    String salt,
    String password,
  ) async {
    var saltBytes = base64Decode(salt);

    var cub = _getCodeUnitBytes(password.codeUnits);
    var bytes = [...cub, ...saltBytes];
    var hash = await Sha256().hash(bytes);
    var encoded = base64Encode(hash.bytes);
    return encoded;
  }
}
