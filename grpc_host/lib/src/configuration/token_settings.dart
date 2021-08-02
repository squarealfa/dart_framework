import 'package:yaml/yaml.dart';

class TokenSettings {
  final String key;
  final String issuer;
  final String audience;
  final int secondsToLive;

  const TokenSettings({
    this.key = '',
    this.issuer = '',
    this.audience = '',
    this.secondsToLive = 3600,
  });

  factory TokenSettings.fromYaml(YamlMap yaml) {
    final key = yaml['key'];
    final issuer = yaml['issuer'];
    final audience = yaml['audience'];
    final secondsToLive = yaml['secondsToLive'] ?? 3600;
    final ret = TokenSettings(
      key: key,
      issuer: issuer,
      audience: audience,
      secondsToLive: secondsToLive,
    );
    return ret;
  }
}
