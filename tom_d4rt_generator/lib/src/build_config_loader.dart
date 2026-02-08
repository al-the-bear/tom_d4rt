// Copyright (c) 2024. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Build configuration loader for D4rt bridge generator.
///
/// Provides utilities for loading D4rt bridge configuration from
/// tom_build.yaml files (d4rtgen: section).
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tom_build_base/tom_build_base.dart';
import 'package:yaml/yaml.dart';

import 'bridge_config.dart';

/// Loads D4rt bridge configuration from a tom_build.yaml file.
///
/// Reads the `d4rtgen:` section from the project's tom_build.yaml,
/// which contains the bridge configuration (modules, paths, etc.).
class BuildConfigLoader {
  /// Loads bridge configuration from a tom_build.yaml file.
  ///
  /// The [projectPath] is the directory containing tom_build.yaml.
  /// Returns null if tom_build.yaml doesn't exist or has no d4rtgen section.
  static BridgeConfig? loadFromTomBuildYaml(String projectPath) {
    final tomBuildYamlPath = p.join(projectPath, 'tom_build.yaml');
    final tomBuildYamlFile = File(tomBuildYamlPath);

    if (!tomBuildYamlFile.existsSync()) {
      return null;
    }

    final content = tomBuildYamlFile.readAsStringSync();
    final yaml = loadYaml(content) as YamlMap?;

    if (yaml == null) return null;

    final d4rtgenSection = yaml['d4rtgen'] as YamlMap?;
    if (d4rtgenSection == null || d4rtgenSection.isEmpty) {
      return null;
    }

    // Convert YamlMap to regular Map for BridgeConfig.fromJson
    return BridgeConfig.fromJson(yamlToMap(d4rtgenSection));
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
