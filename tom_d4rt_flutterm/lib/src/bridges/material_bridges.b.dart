// D4rt Bridge - Generated file, do not edit
// Dartscript registration for flutter_material_bridges
// Generated: 2026-02-28T12:34:26.764144

/// D4rt Bridge Registration for flutter_material_bridges
library;

import 'package:tom_d4rt_exec/d4rt.dart';
import 'painting_bridges.b.dart' as flutter_painting_bridges;
import 'foundation_bridges.b.dart' as flutter_foundation_bridges;
import 'animation_bridges.b.dart' as flutter_animation_bridges;
import 'physics_bridges.b.dart' as flutter_physics_bridges;
import 'scheduler_bridges.b.dart' as flutter_scheduler_bridges;
import 'semantics_bridges.b.dart' as flutter_semantics_bridges;
import 'services_bridges.b.dart' as flutter_services_bridges;
import 'gestures_bridges.b.dart' as flutter_gestures_bridges;
import 'rendering_bridges.b.dart' as flutter_rendering_bridges;
import 'widgets_bridges.b.dart' as flutter_widgets_bridges;
import 'material_widgets_bridges.b.dart' as flutter_material_bridges;
import 'cupertino_bridges.b.dart' as flutter_cupertino_bridges;

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
    flutter_animation_bridges.FlutterAnimationBridge.registerBridges(
      d4rt,
      'package:flutter/animation.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in flutter_animation_bridges.FlutterAnimationBridge.subPackageBarrels()) {
      flutter_animation_bridges.FlutterAnimationBridge.registerBridges(d4rt, barrel);
    }
    flutter_physics_bridges.FlutterPhysicsBridge.registerBridges(
      d4rt,
      'package:flutter/physics.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in flutter_physics_bridges.FlutterPhysicsBridge.subPackageBarrels()) {
      flutter_physics_bridges.FlutterPhysicsBridge.registerBridges(d4rt, barrel);
    }
    flutter_scheduler_bridges.FlutterSchedulerBridge.registerBridges(
      d4rt,
      'package:flutter/scheduler.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in flutter_scheduler_bridges.FlutterSchedulerBridge.subPackageBarrels()) {
      flutter_scheduler_bridges.FlutterSchedulerBridge.registerBridges(d4rt, barrel);
    }
    flutter_semantics_bridges.FlutterSemanticsBridge.registerBridges(
      d4rt,
      'package:flutter/semantics.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in flutter_semantics_bridges.FlutterSemanticsBridge.subPackageBarrels()) {
      flutter_semantics_bridges.FlutterSemanticsBridge.registerBridges(d4rt, barrel);
    }
    flutter_services_bridges.FlutterServicesBridge.registerBridges(
      d4rt,
      'package:flutter/services.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in flutter_services_bridges.FlutterServicesBridge.subPackageBarrels()) {
      flutter_services_bridges.FlutterServicesBridge.registerBridges(d4rt, barrel);
    }
    flutter_gestures_bridges.FlutterGesturesBridge.registerBridges(
      d4rt,
      'package:flutter/gestures.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in flutter_gestures_bridges.FlutterGesturesBridge.subPackageBarrels()) {
      flutter_gestures_bridges.FlutterGesturesBridge.registerBridges(d4rt, barrel);
    }
    flutter_rendering_bridges.FlutterRenderingBridge.registerBridges(
      d4rt,
      'package:flutter/rendering.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in flutter_rendering_bridges.FlutterRenderingBridge.subPackageBarrels()) {
      flutter_rendering_bridges.FlutterRenderingBridge.registerBridges(d4rt, barrel);
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
    flutter_cupertino_bridges.FlutterCupertinoBridge.registerBridges(
      d4rt,
      'package:flutter/cupertino.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in flutter_cupertino_bridges.FlutterCupertinoBridge.subPackageBarrels()) {
      flutter_cupertino_bridges.FlutterCupertinoBridge.registerBridges(d4rt, barrel);
    }
  }

  /// Get import block for all modules.
  static String getImportBlock() {
    final buffer = StringBuffer();
    buffer.writeln(flutter_painting_bridges.FlutterPaintingBridge.getImportBlock());
    buffer.writeln(flutter_foundation_bridges.FlutterFoundationBridge.getImportBlock());
    buffer.writeln(flutter_animation_bridges.FlutterAnimationBridge.getImportBlock());
    buffer.writeln(flutter_physics_bridges.FlutterPhysicsBridge.getImportBlock());
    buffer.writeln(flutter_scheduler_bridges.FlutterSchedulerBridge.getImportBlock());
    buffer.writeln(flutter_semantics_bridges.FlutterSemanticsBridge.getImportBlock());
    buffer.writeln(flutter_services_bridges.FlutterServicesBridge.getImportBlock());
    buffer.writeln(flutter_gestures_bridges.FlutterGesturesBridge.getImportBlock());
    buffer.writeln(flutter_rendering_bridges.FlutterRenderingBridge.getImportBlock());
    buffer.writeln(flutter_widgets_bridges.FlutterWidgetsBridge.getImportBlock());
    buffer.writeln(flutter_material_bridges.FlutterMaterialBridge.getImportBlock());
    buffer.writeln(flutter_cupertino_bridges.FlutterCupertinoBridge.getImportBlock());
    return buffer.toString();
  }
}
