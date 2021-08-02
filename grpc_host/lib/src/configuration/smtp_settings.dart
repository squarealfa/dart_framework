import 'package:yaml/yaml.dart';

class SmtpSettings {
  final String hostname;
  final String username;
  final String password;

  const SmtpSettings({
    this.hostname = '',
    this.username = '',
    this.password = '',
  });

  factory SmtpSettings.fromYaml(YamlMap yaml) {
    final hostname = yaml['hostname'];
    final username = yaml['username'];
    final password = yaml['password'];
    final ret = SmtpSettings(
      hostname: hostname,
      username: username,
      password: password,
    );
    return ret;
  }
}
