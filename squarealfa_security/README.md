# SquareAlfa Security Package

## JWT

The following example shows how to generate a JWT token.

```dart
    
    var secret = '62zb8Sky_i_2kNAKFkORRa42XlQK09Bdtl_GHkTN';

    // the JsonWebTokenHandler handles the generation and parsing of JWT tokens.
    var tokenGenerator = JsonWebTokenHandler(secret);

    // create the payload
    var claims = JwtPayload(
        name: 'John Doe',
        email: 'user@domain.com',
        subject: '5f35bd0489d72e2cd430f78d',
        issuer: 'Our Server',
        audience: 'Our Server',
        notBefore: DateTime.now(),
        expires: DateTime.now().add(Duration(seconds: 300)));

    // finally, generate the JWT token.
    var jwt = tokenGenerator.generate(claims);


```

The following code parses a JWT token:

```dart

      var tokenGenerator = JsonWebTokenHandler(secret);
      var jwt =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiSm9obiBEb2UiLCJzdWIiOiI1ZjM1YmQwNDg5ZDcyZTJjZDQzMGY3OGQiLCJlbWFpbCI6InVzZXJAZG9tYWluLmNvbSIsImlzcyI6Ik91ciBTZXJ2ZXIiLCJhdWQiOiJPdXIgU2VydmVyIiwibmJmIjoiMTYwNTMyNjEyOCIsImV4cCI6IjE2MDUzMjY0MjgiLCJyb2xlcyI6bnVsbCwidWlkIjpudWxsLCJ0aWQiOm51bGx9.d9+mbsXtv5Xv2yAwaD1X4zOLM5aYa3edmQcYSSCP+II';
      var payload = tokenGenerator.load(jwt);

```


## Context

This package is part of a set of losely integrated packages that constitute the [SquareAlfa Dart Framework](https://github.com/squarealfa/dart_framework#squarealfa-dart-framework).
