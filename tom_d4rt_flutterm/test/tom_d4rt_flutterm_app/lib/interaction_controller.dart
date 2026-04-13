// Programmatic interaction support for the D4rt Flutter test app.
//
// Provides gesture simulation using Flutter's gesture binding,
// allowing tests to interact with dialogs, menus, bottom sheets, etc.
//
// Usage via HTTP endpoint `/interact`:
// ```json
// {
//   "actions": [
//     {"type": "waitFrames", "frames": 10},
//     {"type": "tapText", "text": "OK"},
//     {"type": "tapAt", "x": 100, "y": 200},
//     {"type": "dismiss"},
//     {"type": "enterText", "finder": {"type": "type", "name": "TextField"}, "text": "hello"},
//     {"type": "drag", "startX": 100, "startY": 100, "endX": 100, "endY": 300}
//   ]
// }
// ```
library;

import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

/// Interaction controller for programmatic gesture simulation.
class InteractionController {
  /// Captured output from interactions (e.g., print statements triggered).
  final List<String> output = [];

  /// Error messages from failed interactions.
  final List<String> errors = [];

  /// Execute a list of interaction actions.
  Future<InteractionResult> execute(List<InteractionAction> actions) async {
    output.clear();
    errors.clear();

    for (var i = 0; i < actions.length; i++) {
      final action = actions[i];
      try {
        await _executeAction(action);
      } catch (e, st) {
        errors.add('Action ${i + 1} (${action.type}) failed: $e');
        debugPrint('[InteractionController] Error: $e\n$st');
        // Continue with remaining actions unless critical
        if (action.stopOnError) {
          return InteractionResult(
            success: false,
            output: List.from(output),
            errors: List.from(errors),
          );
        }
      }
    }

    return InteractionResult(
      success: errors.isEmpty,
      output: List.from(output),
      errors: List.from(errors),
    );
  }

  Future<void> _executeAction(InteractionAction action) async {
    switch (action.type) {
      case 'waitFrames':
        await _waitFrames(action.frames ?? 1);
      case 'waitMillis':
        await Future<void>.delayed(
          Duration(milliseconds: action.millis ?? 100),
        );
      case 'tapAt':
        await _tapAt(Offset(action.x ?? 0, action.y ?? 0));
      case 'tapText':
        await _tapText(action.text!);
      case 'tapType':
        await _tapType(action.widgetType!);
      case 'tapIcon':
        await _tapIcon(action.icon!);
      case 'dismiss':
        await _dismiss();
      case 'dragVertical':
        await _dragVertical(action.distance ?? 200, action.duration ?? 300);
      case 'drag':
        await _drag(
          Offset(action.startX ?? 0, action.startY ?? 0),
          Offset(action.endX ?? 0, action.endY ?? 0),
          Duration(milliseconds: action.duration ?? 300),
        );
      case 'enterText':
        // Text entry not yet implemented - needs TextInput service mocking
        errors.add('enterText not yet implemented');
      case 'back':
        await _pressBack();
      default:
        errors.add('Unknown action type: ${action.type}');
    }
  }

  /// Wait for N frames to be rendered.
  Future<void> _waitFrames(int count) async {
    for (var i = 0; i < count; i++) {
      await SchedulerBinding.instance.endOfFrame;
    }
  }

  /// Simulate a tap at a specific screen position.
  Future<void> _tapAt(Offset position) async {
    final binding = GestureBinding.instance;
    final pointer = TestPointer(1, PointerDeviceKind.touch);

    // Create pointer events
    final downEvent = pointer.down(position);
    final upEvent = pointer.up();

    // Dispatch through the gesture binding
    binding.handlePointerEvent(downEvent);
    await _waitFrames(1);
    binding.handlePointerEvent(upEvent);
    await _waitFrames(2);
  }

  /// Find and tap a widget containing the specified text.
  Future<void> _tapText(String text) async {
    final position = _findTextPosition(text);
    if (position == null) {
      throw StateError('Could not find text "$text" on screen');
    }
    await _tapAt(position);
  }

  /// Find and tap a widget of the specified type.
  Future<void> _tapType(String typeName) async {
    final position = _findTypePosition(typeName);
    if (position == null) {
      throw StateError('Could not find widget of type "$typeName" on screen');
    }
    await _tapAt(position);
  }

  /// Find and tap an Icon widget with the specified icon name.
  Future<void> _tapIcon(String iconName) async {
    final position = _findIconPosition(iconName);
    if (position == null) {
      throw StateError('Could not find icon "$iconName" on screen');
    }
    await _tapAt(position);
  }

  /// Dismiss a modal by tapping outside it (on the barrier).
  Future<void> _dismiss() async {
    // Tap in the top-left corner which should be modal barrier area
    await _tapAt(const Offset(10, 10));
  }

  /// Drag vertically from center of screen.
  Future<void> _dragVertical(double distance, int durationMs) async {
    final view = ui.PlatformDispatcher.instance.implicitView;
    if (view == null) return;

    final size = view.physicalSize / view.devicePixelRatio;
    final center = Offset(size.width / 2, size.height / 2);
    await _drag(
      center,
      center + Offset(0, distance),
      Duration(milliseconds: durationMs),
    );
  }

  /// Simulate a drag gesture from start to end over the given duration.
  Future<void> _drag(Offset start, Offset end, Duration duration) async {
    final binding = GestureBinding.instance;
    final pointer = TestPointer(1, PointerDeviceKind.touch);

    // Calculate intermediate points
    const steps = 10;
    final dx = (end.dx - start.dx) / steps;
    final dy = (end.dy - start.dy) / steps;
    final stepDurationMs = duration.inMilliseconds ~/ steps;

    // Down
    binding.handlePointerEvent(pointer.down(start));
    await _waitFrames(1);

    // Move in steps
    var current = start;
    for (var i = 0; i < steps; i++) {
      current = Offset(current.dx + dx, current.dy + dy);
      binding.handlePointerEvent(pointer.move(current));
      await Future<void>.delayed(Duration(milliseconds: stepDurationMs));
    }

    // Up
    binding.handlePointerEvent(pointer.up());
    await _waitFrames(2);
  }

  /// Simulate back button press.
  Future<void> _pressBack() async {
    // Pop the current route using the navigator
    final context = _findContext();
    if (context != null && Navigator.canPop(context)) {
      Navigator.pop(context);
      await _waitFrames(5);
    }
  }

  /// Find a BuildContext from the widget tree.
  BuildContext? _findContext() {
    BuildContext? result;
    void visitor(Element element) {
      result ??= element;
    }

    _visitElements(visitor);
    return result;
  }

  /// Find the center position of a Text widget containing the given string.
  Offset? _findTextPosition(String text) {
    Offset? result;

    void visitor(Element element) {
      if (result != null) return;

      final widget = element.widget;
      if (widget is Text) {
        final data = widget.data;
        if (data != null && data.contains(text)) {
          result = _getElementCenter(element);
        }
      } else if (widget is RichText) {
        final plainText = widget.text.toPlainText();
        if (plainText.contains(text)) {
          result = _getElementCenter(element);
        }
      }
    }

    _visitElements(visitor);
    return result;
  }

  /// Find the center position of a widget by type name.
  Offset? _findTypePosition(String typeName) {
    Offset? result;

    void visitor(Element element) {
      if (result != null) return;

      final widget = element.widget;
      final runtimeType = widget.runtimeType.toString();
      if (runtimeType == typeName || runtimeType.contains(typeName)) {
        result = _getElementCenter(element);
      }
    }

    _visitElements(visitor);
    return result;
  }

  /// Find the center position of an Icon widget by icon name.
  Offset? _findIconPosition(String iconName) {
    Offset? result;

    void visitor(Element element) {
      if (result != null) return;

      final widget = element.widget;
      if (widget is Icon) {
        final iconData = widget.icon;
        if (iconData != null) {
          final iconString = iconData.toString();
          if (iconString.contains(iconName)) {
            result = _getElementCenter(element);
          }
        }
      }
    }

    _visitElements(visitor);
    return result;
  }

  /// Get the center position of an element's render box.
  Offset? _getElementCenter(Element element) {
    final renderObject = element.renderObject;
    if (renderObject is RenderBox && renderObject.hasSize) {
      final transform = renderObject.getTransformTo(null);
      final size = renderObject.size;
      final center = size.center(Offset.zero);
      return MatrixUtils.transformPoint(transform, center);
    }
    return null;
  }

  /// Visit all elements in the widget tree.
  void _visitElements(void Function(Element) visitor) {
    void visit(Element element) {
      visitor(element);
      element.visitChildren(visit);
    }

    // Get the root element from the binding
    final rootElement = WidgetsBinding.instance.rootElement;
    if (rootElement != null) {
      visit(rootElement);
    }
  }
}

/// Result of executing interaction actions.
class InteractionResult {
  final bool success;
  final List<String> output;
  final List<String> errors;

  const InteractionResult({
    required this.success,
    required this.output,
    required this.errors,
  });

  Map<String, dynamic> toJson() => {
    'success': success,
    'output': output,
    'errors': errors,
  };
}

/// A single interaction action to execute.
class InteractionAction {
  final String type;
  final double? x;
  final double? y;
  final double? startX;
  final double? startY;
  final double? endX;
  final double? endY;
  final double? distance;
  final String? text;
  final String? widgetType;
  final String? icon;
  final int? frames;
  final int? millis;
  final int? duration;
  final bool stopOnError;

  const InteractionAction({
    required this.type,
    this.x,
    this.y,
    this.startX,
    this.startY,
    this.endX,
    this.endY,
    this.distance,
    this.text,
    this.widgetType,
    this.icon,
    this.frames,
    this.millis,
    this.duration,
    this.stopOnError = false,
  });

  factory InteractionAction.fromJson(Map<String, dynamic> json) {
    return InteractionAction(
      type: json['type'] as String,
      x: (json['x'] as num?)?.toDouble(),
      y: (json['y'] as num?)?.toDouble(),
      startX: (json['startX'] as num?)?.toDouble(),
      startY: (json['startY'] as num?)?.toDouble(),
      endX: (json['endX'] as num?)?.toDouble(),
      endY: (json['endY'] as num?)?.toDouble(),
      distance: (json['distance'] as num?)?.toDouble(),
      text: json['text'] as String?,
      widgetType: json['widgetType'] as String?,
      icon: json['icon'] as String?,
      frames: json['frames'] as int?,
      millis: json['millis'] as int?,
      duration: json['duration'] as int?,
      stopOnError: json['stopOnError'] as bool? ?? false,
    );
  }
}

/// Test pointer for gesture simulation.
///
/// This is a simplified version of Flutter's TestPointer for runtime use.
class TestPointer {
  final int pointer;
  final PointerDeviceKind kind;
  Offset _location = Offset.zero;
  bool _isDown = false;

  TestPointer(this.pointer, this.kind);

  PointerDownEvent down(Offset position, {Duration timeStamp = Duration.zero}) {
    _location = position;
    _isDown = true;
    return PointerDownEvent(
      pointer: pointer,
      position: position,
      kind: kind,
      timeStamp: timeStamp,
    );
  }

  PointerMoveEvent move(Offset position, {Duration timeStamp = Duration.zero}) {
    final delta = position - _location;
    _location = position;
    return PointerMoveEvent(
      pointer: pointer,
      position: position,
      delta: delta,
      kind: kind,
      timeStamp: timeStamp,
    );
  }

  PointerUpEvent up({Duration timeStamp = Duration.zero}) {
    _isDown = false;
    return PointerUpEvent(
      pointer: pointer,
      position: _location,
      kind: kind,
      timeStamp: timeStamp,
    );
  }
}
