import 'package:yaml/yaml.dart';

class TokenSettings {
  final String key;
  final String issuer;
  final String audience;

  const TokenSettings({
    this.key = '',
    this.issuer = '',
    this.audience = '',
  });

  factory TokenSettings.fromYaml(YamlMap yaml) {
    final key = yaml['key'];
    final issuer = yaml['issuer'];
    final audience = yaml['audience'];
    final ret = TokenSettings(key: key, issuer: issuer, audience: audience);
    return ret;
  }
}
