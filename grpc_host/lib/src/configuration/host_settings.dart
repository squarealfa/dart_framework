import 'dart:io';

import 'package:grpc_host/grpc_host.dart';
import 'package:grpc_host/src/configuration/smtp_settings.dart';
import 'package:grpc_host/src/configuration/ssl_settings.dart';
import 'package:yaml/yaml.dart';

class HostSettings {
  static const defaultIsolatesMultiplier = 1;
  static const defaultExtraIsolates = 0;

  final String dbConnectionString;
  final int isolatesMultiplier;
  final int extraIsolates;
  final int port;
  final TokenSettings tokenSettings;
  final SslSettings sslSettings;
  final SmtpSettings smtpSettings;

  HostSettings({
    this.dbConnectionString = '',
    this.isolatesMultiplier = defaultIsolatesMultiplier,
    this.extraIsolates = defaultExtraIsolates,
    this.port = 8080,
    this.tokenSettings = const TokenSettings(),
    this.sslSettings = const SslSettings(),
    this.smtpSettings = const SmtpSettings(),
  });

  factory HostSettings.fromYamlFile({String filename = 'appsettings.yaml'}) {
    var yamlDocument = _loadConfig(filename);
    if (yamlDocument == null) return HostSettings();

    final ret = HostSettings.fromYaml(yamlDocument);

    return ret;
  }

  factory HostSettings.fromYaml(YamlMap yamlDocument) {
    final connString = yamlDocument['dbserver']['connectionString'];
    final port = yamlDocument['port'] as int? ?? 8080;
    final server = yamlDocument['server'];
    final isolatesMultiplier = server != null
        ? server['isolatesMultiplier'] ?? defaultIsolatesMultiplier
        : defaultIsolatesMultiplier;
    final extraIsolates = server != null
        ? server['extraIsolates'] ?? defaultExtraIsolates
        : defaultIsolatesMultiplier;
    final tokenSettingsYaml = yamlDocument['tokenSettings'];
    final tokenSettings = tokenSettingsYaml == null
        ? TokenSettings()
        : TokenSettings.fromYaml(tokenSettingsYaml);
    final sslSettingsYaml = yamlDocument['ssl'];
    final sslSettings = sslSettingsYaml == null
        ? SslSettings()
        : SslSettings.fromYaml(sslSettingsYaml);
    final smtpSettingsYaml = yamlDocument['smtp'];
    final smtpSettings = smtpSettingsYaml == null
        ? SmtpSettings()
        : SmtpSettings.fromYaml(smtpSettingsYaml);

    var ret = HostSettings(
      dbConnectionString: connString,
      port: port,
      tokenSettings: tokenSettings,
      isolatesMultiplier: isolatesMultiplier,
      extraIsolates: extraIsolates,
      sslSettings: sslSettings,
      smtpSettings: smtpSettings,
    );

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
