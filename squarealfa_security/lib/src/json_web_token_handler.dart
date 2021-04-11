import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'invalid_signature_exception.dart';
import 'invalid_token_exception.dart';
import 'jwt_payload.dart';

/// Generates and parses JWT tokens
class JsonWebTokenHandler {
  final Hmac _hmac;

  /// Constructs a [JsonWebTokenHandler] with the specified [key] for
  /// signing the generated tokens and validating the tokens to be parsed.
  JsonWebTokenHandler(String key) : _hmac = Hmac(sha256, utf8.encode(key));

  /// Creates a new JWT token with a payload represented by [payload].
  String generate(JwtPayload payload) {
    var headerBase64 = _serializeHeader();
    var payloadBase64 = _serializePayload(payload);

    var signature = _sign(headerBase64, payloadBase64);

    var ret = '$headerBase64.$payloadBase64.$signature';
    return ret;
  }

  /// Parses a JWT token, validating it, and returns a [JwtPayload] representing
  /// its contents.
  JwtPayload load(String token) {
    if (token.startsWith('Bearer ')) {
      token = token.substring('Bearer '.length);
    }
    var parts = token.split('.');
    if (parts.length != 3) {
      throw InvalidTokenException(reason: 'Token should have 3 sections.');
    }

    var headerBase64 = parts[0];
    var payloadBase64 = parts[1];

    var checkSignature = _sign(headerBase64, payloadBase64);

    var signature = parts[2];

    if (checkSignature != signature) {
      throw InvalidSignatureException();
    }

    var payload = _deserializePayload(payloadBase64);
    return payload;
  }

  String _sign(String headerBase64, String payloadBase64) {
    var content = '$headerBase64.$payloadBase64';
    var digest = _hmac.convert(utf8.encode(content));

    var signature = base64Encode(digest.bytes);
    signature = _adjustBase64(signature);
    return signature;
  }

  JwtPayload _deserializePayload(String payloadBase64) {
    var json = decodePayload(payloadBase64);
    var map = jsonDecode(json);

    var ret = JwtPayload.fromMap(map);
    return ret;
  }

  String _serializePayload(JwtPayload payload) {
    var map = payload.claimsMap;

    var json = jsonEncode(map);
    var base64 = base64Encode(utf8.encode(json));
    base64 = _adjustBase64(base64);
    return base64;
  }

  String _serializeHeader() {
    var headerMap = <String, dynamic>{'alg': 'HS256', 'typ': 'JWT'};

    var headerJson = jsonEncode(headerMap);
    var headerBase64 = base64Encode(utf8.encode(headerJson));
    headerBase64 = _adjustBase64(headerBase64);
    return headerBase64;
  }

  String _adjustBase64(String base64Content) {
    base64Content = Uri.encodeFull(base64Content);
    while (base64Content.endsWith('=')) {
      base64Content = base64Content.substring(0, base64Content.length - 1);
    }

    return base64Content;
  }
}

String decodePayload(String payloadBase64) {
  var delta4 = payloadBase64.length % 4;
  if (delta4 > 0 && delta4 < 4) {
    payloadBase64 =
        payloadBase64.padRight(payloadBase64.length + (4 - delta4), '=');
  }

  var json = utf8.decode(base64Decode(payloadBase64));
  return json;
}
