import 'dart:io';

import 'package:yaml/yaml.dart';

class AppSettings {
  static const defaultNumberIsolates = 1;

  final String dbConnectionString;
  final String jwtKey;
  final int numberIsolates;
  final int port;

  AppSettings._({
    this.dbConnectionString = '',
    this.jwtKey = '',
    this.numberIsolates = defaultNumberIsolates,
    this.port = 8080,
  });

  factory AppSettings() {
    var yamlDocument = _loadConfig();
    if (yamlDocument == null) return AppSettings();

    var connString = yamlDocument['dbserver']['connectionString'];
    var jwtKey = yamlDocument['jwt']['key'];
    var server = yamlDocument['server'];
    var numberIsolates = server != null
        ? server['numberIsolates'] ?? defaultNumberIsolates
        : defaultNumberIsolates;

    var ret = AppSettings._(
        dbConnectionString: connString,
        jwtKey: jwtKey,
        numberIsolates: numberIsolates);

    return ret;
  }

  static YamlMap? _loadConfig() {
    final filename = 'appsettings.yaml';

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
