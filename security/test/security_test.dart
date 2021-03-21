import 'dart:convert';

import 'package:squarealfa_security/squarealfa_security.dart';
import 'package:test/test.dart';

void main() {
  var secret = '62zb8Sky_i_2kNAKFkORRa42XlQK09Bdtl_GHkTN';

  group('Token generation', () {
    var claims = JwtPayload(
        name: 'John Doe',
        email: 'user@domain.com',
        subject: '5f35bd0489d72e2cd430f78d',
        issuer: 'Our Server',
        audience: 'Our Server',
        notBefore: DateTime.now(),
        expires: DateTime.now().add(Duration(seconds: 300)));

    var tokenGenerator = JsonWebTokenHandler(secret);

    var jwt = tokenGenerator.generate(claims);

    test('token should have 3 parts', () {
      var parts = jwt.split('.');
      expect(parts.length, 3);
    });
    test('header type should be JWT', () {
      var parts = jwt.split('.');

      var header = utf8.decode(base64Decode(parts[0]));
      var map = jsonDecode(header) as Map<String, dynamic>;

      expect(map['typ'], 'JWT');
    });

    test('body should contain claims', () {
      var parts = jwt.split('.');

      var body = decodePayload(parts[1]);
      var map = jsonDecode(body) as Map<String, dynamic>;

      expect(map['name'], 'John Doe');
      expect(map['email'], 'user@domain.com');
    });
  });

  group('Token loading', () {
    test('Subject is correct', () {
      var tokenGenerator = JsonWebTokenHandler(secret);
      var jwt =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiSm9obiBEb2UiLCJzdWIiOiI1ZjM1YmQwNDg5ZDcyZTJjZDQzMGY3OGQiLCJlbWFpbCI6InVzZXJAZG9tYWluLmNvbSIsImlzcyI6Ik91ciBTZXJ2ZXIiLCJhdWQiOiJPdXIgU2VydmVyIiwibmJmIjoiMTYwNTMyNjEyOCIsImV4cCI6IjE2MDUzMjY0MjgiLCJyb2xlcyI6bnVsbCwidWlkIjpudWxsLCJ0aWQiOm51bGx9.d9+mbsXtv5Xv2yAwaD1X4zOLM5aYa3edmQcYSSCP+II';
      var payload = tokenGenerator.load(jwt);
      expect(payload.subject, '5f35bd0489d72e2cd430f78d');
    });

    test('Subject is correct', () {
      var tokenGenerator = JsonWebTokenHandler(secret);
      var jwt =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiSm9obiBEb2UiLCJzdWIiOiI1ZjM1YmQwNDg5ZDcyZTJjZDQzMGY3OGQiLCJlbWFpbCI6InVzZXJAZG9tYWluLmNvbSIsImlzcyI6Ik91ciBTZXJ2ZXIiLCJhdWQiOiJPdXIgU2VydmVyIiwibmJmIjoiMTYwNTMyNjEyOCIsImV4cCI6IjE2MDUzMjY0MjgiLCJyb2xlcyI6bnVsbCwidWlkIjpudWxsLCJ0aWQiOm51bGx9.d9+mbsXtv5Xv2yAwaD1X4zOLM5aYa3edmQcYSSCP+II';
      var payload = tokenGenerator.load(jwt);
      expect(payload.subject, '5f35bd0489d72e2cd430f78d');
    });
  });
}
