import 'dart:io';

import 'package:yaml/yaml.dart';

import 'file.dart';

const String defaultConfig = """\
# Available themes: arcticPetrol, electricSolarized, nordicFrost, wikipediaClassic
theme: wikipediaClassic
language: en
""";

class Config {
  final String? configFilePath;
  late final YamlMap content;

  Config([this.configFilePath]) {
    final File file;
    if (configFilePath != null) {
      file = File(expandHome(configFilePath!));
    } else {
      file = File(expandHome('~/.dartpedia/config.yaml'));
    }
    if (file.existsSync()) {
      content = loadYaml(file.readAsStringSync());
    } else {
      file.writeAsStringSync(defaultConfig);
      content = loadYaml(defaultConfig);
    }
  }
}
