// D4rt Bridge - Generated file, do not edit
// Dartscript registration for flutter_material_bridges
// Generated: 2026-02-27T07:32:12.643836

/// D4rt Bridge Registration for flutter_material_bridges
library;

import 'package:tom_d4rt/d4rt.dart';
import 'painting_bridges.b.dart' as flutter_painting_bridges;
import 'foundation_bridges.b.dart' as flutter_foundation_bridges;
import 'widgets_bridges.b.dart' as flutter_widgets_bridges;
import 'material_widgets_bridges.b.dart' as flutter_material_bridges;

/// Combined bridge registration for flutter_material_bridges.
class FlutterMaterialBridges {
  /// Register all bridges with D4rt interpreter.
  static void register([D4rt? interpreter]) {
    final d4rt = interpreter ?? D4rt();

    flutter_painting_bridges.FlutterPaintingBridge.registerBridges(
      d4rt,
      'package:flutter/painting.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in flutter_painting_bridges.FlutterPaintingBridge.subPackageBarrels()) {
      flutter_painting_bridges.FlutterPaintingBridge.registerBridges(d4rt, barrel);
    }
    flutter_foundation_bridges.FlutterFoundationBridge.registerBridges(
      d4rt,
      'package:flutter/foundation.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in flutter_foundation_bridges.FlutterFoundationBridge.subPackageBarrels()) {
      flutter_foundation_bridges.FlutterFoundationBridge.registerBridges(d4rt, barrel);
    }
    flutter_widgets_bridges.FlutterWidgetsBridge.registerBridges(
      d4rt,
      'package:flutter/widgets.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in flutter_widgets_bridges.FlutterWidgetsBridge.subPackageBarrels()) {
      flutter_widgets_bridges.FlutterWidgetsBridge.registerBridges(d4rt, barrel);
    }
    flutter_material_bridges.FlutterMaterialBridge.registerBridges(
      d4rt,
      'package:flutter/material.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in flutter_material_bridges.FlutterMaterialBridge.subPackageBarrels()) {
      flutter_material_bridges.FlutterMaterialBridge.registerBridges(d4rt, barrel);
    }
  }

  /// Get import block for all modules.
  static String getImportBlock() {
    final buffer = StringBuffer();
    buffer.writeln(flutter_painting_bridges.FlutterPaintingBridge.getImportBlock());
    buffer.writeln(flutter_foundation_bridges.FlutterFoundationBridge.getImportBlock());
    buffer.writeln(flutter_widgets_bridges.FlutterWidgetsBridge.getImportBlock());
    buffer.writeln(flutter_material_bridges.FlutterMaterialBridge.getImportBlock());
    return buffer.toString();
  }
}
