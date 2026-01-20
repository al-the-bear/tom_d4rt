// Copyright (c) 2024. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Build configuration loader for D4rt bridge generator.
///
/// Provides utilities for loading D4rt bridge configuration from
/// build.yaml files, supporting both build_runner and CLI usage.
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

import 'bridge_config.dart';

/// Loads D4rt bridge configuration from a build.yaml file.
///
/// This class supports the standard build_runner configuration format,
/// allowing both the builder and CLI to use the same configuration source.
class BuildConfigLoader {
  /// The builder name in build.yaml.
  static const String builderName = 'tom_d4rt_generator:d4rt_bridge_builder';

  /// Loads configuration from a build.yaml file.
  ///
  /// The [projectPath] is the directory containing build.yaml.
  /// Returns null if build.yaml doesn't exist or has no D4rt config.
  static BridgeConfig? loadFromBuildYaml(String projectPath) {
    final buildYamlPath = p.join(projectPath, 'build.yaml');
    final buildYamlFile = File(buildYamlPath);

    if (!buildYamlFile.existsSync()) {
      return null;
    }

    final content = buildYamlFile.readAsStringSync();
    final yaml = loadYaml(content) as YamlMap?;

    if (yaml == null) return null;

    return _extractConfig(yaml, projectPath);
  }

  /// Extracts D4rt bridge config from parsed build.yaml content.
  static BridgeConfig? _extractConfig(YamlMap yaml, String projectPath) {
    // Look for config in targets.$default.builders
    final targets = yaml['targets'] as YamlMap?;
    if (targets == null) return null;

    final defaultTarget = targets[r'$default'] as YamlMap?;
    if (defaultTarget == null) return null;

    final builders = defaultTarget['builders'] as YamlMap?;
    if (builders == null) return null;

    final builderConfig = builders[builderName] as YamlMap?;
    if (builderConfig == null) return null;

    final options = builderConfig['options'] as YamlMap?;
    if (options == null || options.isEmpty) {
      // Try to load from d4rt_bridging.json as fallback
      return _loadFromJsonFallback(projectPath);
    }

    // Convert YamlMap to regular Map for BridgeConfig.fromJson
    return BridgeConfig.fromJson(_yamlToJson(options));
  }

  /// Fallback: load from d4rt_bridging.json if build.yaml has no options.
  static BridgeConfig? _loadFromJsonFallback(String projectPath) {
    final jsonPath = p.join(projectPath, 'd4rt_bridging.json');
    final jsonFile = File(jsonPath);

    if (jsonFile.existsSync()) {
      return BridgeConfig.fromFile(jsonPath);
    }

    return null;
  }

  /// Converts a YamlMap to a regular Dart Map.
  static Map<String, dynamic> _yamlToJson(YamlMap yaml) {
    final result = <String, dynamic>{};
    for (final entry in yaml.entries) {
      final key = entry.key.toString();
      final value = entry.value;
      if (value is YamlMap) {
        result[key] = _yamlToJson(value);
      } else if (value is YamlList) {
        result[key] = _yamlListToJson(value);
      } else {
        result[key] = value;
      }
    }
    return result;
  }

  /// Converts a YamlList to a regular Dart List.
  static List<dynamic> _yamlListToJson(YamlList yaml) {
    return yaml.map((item) {
      if (item is YamlMap) {
        return _yamlToJson(item);
      } else if (item is YamlList) {
        return _yamlListToJson(item);
      } else {
        return item;
      }
    }).toList();
  }

  /// Gets the package name from pubspec.yaml.
  static String? getPackageName(String projectPath) {
    final pubspecPath = p.join(projectPath, 'pubspec.yaml');
    final pubspecFile = File(pubspecPath);

    if (!pubspecFile.existsSync()) {
      return null;
    }

    final content = pubspecFile.readAsStringSync();
    final yaml = loadYaml(content) as YamlMap?;

    return yaml?['name'] as String?;
  }
}
