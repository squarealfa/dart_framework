import 'package:yaml/yaml.dart';

class SslSettings {
  final String certificatePath;
  final String privateKeyPath;

  const SslSettings({
    this.certificatePath = '',
    this.privateKeyPath = '',
  });

  factory SslSettings.fromYaml(YamlMap yaml) {
    final certificatePath = yaml['certificatePath'];
    final privateKeyPath = yaml['privateKeyPath'];
    final ret = SslSettings(
      certificatePath: certificatePath,
      privateKeyPath: privateKeyPath,
    );
    return ret;
  }
}
