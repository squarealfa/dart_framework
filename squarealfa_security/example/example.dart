import 'package:squarealfa_security/squarealfa_security.dart';

void main(List<String> args) async {
  var secret = '62zb8Sky_i_2kNAKFkORRa42XlQK09Bdtl_GHkTN';

  // the JsonWebTokenHandler handles the generation and parsing of JWT tokens.
  var tokenGenerator = JsonWebTokenHandler(secret);

  // create the payload
  var claims = JwtPayload(
      name: 'John Doe',
      username: 'user@domain.com',
      subject: '5f35bd0489d72e2cd430f78d',
      issuer: 'Our Server',
      audience: 'Our Server',
      notBefore: DateTime.now(),
      expires: DateTime.now().add(Duration(seconds: 300)));

  // finally, generate the JWT token.
  var jwt = tokenGenerator.generate(claims);
  print('''The generated token is:
$jwt''');

  var payload = tokenGenerator.load(jwt);

  print('Name is ${payload.name}');
}
