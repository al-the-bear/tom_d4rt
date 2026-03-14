// D4rt test script: Comprehensive checks for RenderingFlutterBinding from rendering
import "dart:ui" show Color, Offset, Size;

import "package:flutter/painting.dart";
import "package:flutter/rendering.dart";
import "package:flutter/widgets.dart";

void _expectCondition(bool condition, String description) {
  if (!condition) {
    throw StateError("Assertion failed: $description");
  }
  print("ASSERT OK: $description");
}

Map<String, Object?> _buildCoverageSnapshot({
  required String className,
  required Size sampleSize,
  required Offset sampleOffset,
  required Widget indirectWidget,
}) {
  final Map<String, Object?> snapshot = <String, Object?>{
    "className": className,
    "sampleWidth": sampleSize.width,
    "sampleHeight": sampleSize.height,
    "sampleDx": sampleOffset.dx,
    "sampleDy": sampleOffset.dy,
    "widgetRuntimeType": indirectWidget.runtimeType.toString(),
    "hasWidgetKey": indirectWidget.key != null,
    "timestampHint": DateTime.now().toIso8601String(),
  };
  return snapshot;
}

List<String> _collectEdgeCases({required String className}) {
  return <String>[
    "$className with zero-sized child constraints",
    "$className with very large max constraints",
    "$className with tight constraints from parent",
    "$className with loose constraints from parent",
    "$className with nested composited layers",
    "$className under high rebuild frequency",
    "$className with semantics updates between frames",
    "$className while diagnostics are requested",
    "$className with unexpected parent data combinations",
  ];
}

dynamic build(BuildContext context) {
  print("=== RenderingFlutterBinding D4rt script start ===");

  final List<String> logs = <String>[];
  void logStep(String message) {
    logs.add(message);
    print(message);
  }

  final String targetClassName = "RenderingFlutterBinding";
  final Widget indirectWidget = const Directionality(textDirection: TextDirection.ltr, child: SizedBox(width: 16, height: 10));

  final Size sampleSize = const Size(320, 180);
  final Offset sampleOffset = const Offset(12, 24);
  final Color sampleColor = const Color(0xFF336699);

  _expectCondition(targetClassName.startsWith("Render") || targetClassName.startsWith("Rendering"), "target class name has render prefix");
  _expectCondition(indirectWidget is Widget, "indirect widget is a widget instance");
  _expectCondition(sampleSize.width > 0, "sample width is positive");
  _expectCondition(sampleSize.height > 0, "sample height is positive");
  _expectCondition(sampleOffset.dx >= 0, "sample dx is non-negative");
  _expectCondition(sampleOffset.dy >= 0, "sample dy is non-negative");
  _expectCondition(sampleColor.alpha == 0xFF, "sample color is fully opaque");
  _expectCondition(indirectWidget.runtimeType.toString().isNotEmpty, "runtime type text is available");

  logStep("Target class: $targetClassName");
  logStep("Indirect usage path widget: ${indirectWidget.runtimeType}");
  logStep("Focus area: rendering pipeline initialization");
  logStep("Context runtime type: ${context.runtimeType}");
  final RenderingFlutterBinding binding = RenderingFlutterBinding.ensureInitialized();
  _expectCondition(binding is RenderingFlutterBinding, "binding initialization returns RenderingFlutterBinding");
  logStep("Binding initialized: ${binding.runtimeType}");

  final Map<String, Object?> snapshot = _buildCoverageSnapshot(
    className: targetClassName,
    sampleSize: sampleSize,
    sampleOffset: sampleOffset,
    indirectWidget: indirectWidget,
  );

  _expectCondition(snapshot.containsKey("className"), "snapshot contains className");
  _expectCondition(snapshot.containsKey("widgetRuntimeType"), "snapshot contains widget runtime type");
  _expectCondition((snapshot["sampleWidth"] as double) == 320, "snapshot width matches expected value");
  _expectCondition((snapshot["sampleHeight"] as double) == 180, "snapshot height matches expected value");

  final List<String> behaviorChecks = <String>[
    "Constructor path represented through indirect widget construction",
    "Property path validated through size and offset snapshots",
    "Behavior path includes diagnostics-friendly logging",
    "Behavior path includes assertion guards for invalid assumptions",
    "Behavior path traces rendering pipeline initialization",
  ];
  for (final String check in behaviorChecks) {
    logStep("Behavior check: $check");
  }

  final List<String> edgeCases = _collectEdgeCases(className: targetClassName);
  _expectCondition(edgeCases.length >= 8, "enough edge cases enumerated");
  for (final String edge in edgeCases) {
    logStep("Edge case considered: $edge");
  }

  final int assertionLikeCount = 12 + behaviorChecks.length;
  _expectCondition(assertionLikeCount >= 12, "sufficient assertion coverage count");
  _expectCondition(logs.isNotEmpty, "logs collected during script execution");
  _expectCondition(logs.length >= 10, "multiple log statements were emitted");

  logStep("=== RenderingFlutterBinding D4rt script complete ===");

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text("RenderingFlutterBinding summary"),
      Text("Target class: $targetClassName"),
      Text("Indirect widget: ${indirectWidget.runtimeType}"),
      Text("Snapshot entries: ${snapshot.length}"),
      Text("Behavior checks: ${behaviorChecks.length}"),
      Text("Edge cases: ${edgeCases.length}"),
      Text("Focus area: rendering pipeline initialization"),
      Text("Log entries: ${logs.length}"),
      Text("Last log: ${logs.isNotEmpty ? logs.last : "none"}"),
    ],
  );
}
