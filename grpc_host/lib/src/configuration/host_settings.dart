import 'dart:io';

import 'package:grpc_host/grpc_host.dart';
import 'package:yaml/yaml.dart';

class HostSettings {
  static const defaultNumberIsolates = 25;

  final String dbConnectionString;
  final int numberIsolates;
  final int port;
  final TokenSettings tokenSettings;

  HostSettings({
    this.dbConnectionString = '',
    this.numberIsolates = defaultNumberIsolates,
    this.port = 8080,
    this.tokenSettings = const TokenSettings(),
  });

  factory HostSettings.fromYamlFile(
      {String filename = 'appsettings.yaml'}) {
    var yamlDocument = _loadConfig(filename);
    if (yamlDocument == null) return HostSettings();

    final ret = HostSettings.fromYaml(yamlDocument);

    return ret;
  }

  factory HostSettings.fromYaml(YamlMap yamlDocument) {
    final connString = yamlDocument['dbserver']['connectionString'];
    final server = yamlDocument['server'];
    final numberIsolates = server != null
        ? server['numberIsolates'] ?? defaultNumberIsolates
        : defaultNumberIsolates;
    final tokenSettingsYaml = yamlDocument['tokenSettings'];
    final tokenSettings = tokenSettingsYaml == null
        ? TokenSettings()
        : TokenSettings.fromYaml(tokenSettingsYaml);

    var ret = HostSettings(
        dbConnectionString: connString,
        tokenSettings: tokenSettings,
        numberIsolates: numberIsolates);
    return ret;
  }

  static YamlMap? _loadConfig(String filename) {
    try {
      var file = File(filename);
      if (!file.existsSync()) {
        return null;
      }

      final text = File(filename).readAsStringSync();
      var map = loadYaml(text) as YamlMap?;
      return map;
    } catch (ex) {
      // Would be logging
      return null;
    }
  }
}
