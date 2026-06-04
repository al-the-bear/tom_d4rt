// DrawingPadHome — the state-bearing host that owns the stroke
// history, the in-progress stroke, and the current tool settings.
//
// State ownership:
//   • `_strokes`         — completed strokes, capped at `_maxUndoDepth`
//                          via a ring-buffer cull so memory stays
//                          bounded under long drawing sessions
//   • `_redoStack`       — strokes popped by Undo, ready for Redo;
//                          any new pan-down clears this list
//                          (Photoshop-style "branch the timeline")
//   • `_inProgress`      — the stroke currently under the user's
//                          pointer, `null` when no drag is active
//   • `_currentColor`    — selected swatch
//   • `_brushSize`       — current Slider value
//
// Every public action runs inside `setState(...)` so the
// `CustomPainter`'s host widget gets the rebuild — the painter
// itself signals "always repaint" via `shouldRepaint`. All state
// changes emit a one-line `print()` so tests can observe the
// timeline via `_printLog` capture.
//
// The `GestureDetector` uses `HitTestBehavior.opaque` so the full
// canvas Rect receives pan events even where the painter hasn't
// drawn anything yet.
//
// ignore_for_file: avoid_print — print() lines are the test trail.
import 'package:flutter/material.dart';

import 'canvas_painter.dart';
import 'stroke.dart';
import 'tool_bar.dart';

class DrawingPadHome extends StatefulWidget {
  const DrawingPadHome({super.key});

  @override
  State<DrawingPadHome> createState() => _DrawingPadHomeState();
}

class _DrawingPadHomeState extends State<DrawingPadHome> {
  /// Ring-buffer cap on the completed-strokes list. Picked large
  /// enough that normal use never trips it but small enough that
  /// pathological "draw forever" still has a bounded footprint.
  static const int _maxUndoDepth = 50;

  /// Brush-width slider bounds in logical pixels.
  static const double _minBrush = 1.5;
  static const double _maxBrush = 24.0;

  /// Initial brush width — a comfortable medium for the default
  /// canvas size.
  static const double _initialBrush = 4.0;

  /// Six-colour pen rack. Order is deliberate — dark slate first so
  /// it's the default, then warm to cool around the wheel.
  static const List<Color> _palette = <Color>[
    Color(0xFF1F2937), // dark slate
    Color(0xFFDC2626), // red
    Color(0xFFD97706), // amber
    Color(0xFF059669), // emerald
    Color(0xFF2563EB), // blue
    Color(0xFF7C3AED), // purple
  ];

  final List<Stroke> _strokes = <Stroke>[];
  final List<Stroke> _redoStack = <Stroke>[];
  Stroke? _inProgress;
  Color _currentColor = _palette[0];
  double _brushSize = _initialBrush;

  bool get _canUndo => _strokes.isNotEmpty;
  bool get _canRedo => _redoStack.isNotEmpty;

  // ── Pan handlers ────────────────────────────────────────────────

  void _onPanStart(DragStartDetails details) {
    print('drawingpad.panStart at ${details.localPosition}');
    setState(() {
      _inProgress = Stroke(
        color: _currentColor,
        width: _brushSize,
        initialPoints: <Offset>[details.localPosition],
      );
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (_inProgress == null) return;
    setState(() {
      _inProgress!.addPoint(details.localPosition);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (_inProgress == null) return;
    final committed = _inProgress!;
    setState(() {
      _strokes.add(committed);
      // Ring-buffer cap — drop the oldest when we exceed the depth.
      while (_strokes.length > _maxUndoDepth) {
        _strokes.removeAt(0);
      }
      _inProgress = null;
      // New stroke branches the timeline — redo history dies.
      _redoStack.clear();
    });
    print('drawingpad.panEnd: commit ${committed.length} points; '
        'strokes=${_strokes.length} redo=${_redoStack.length}');
  }

  // ── Toolbar handlers ────────────────────────────────────────────

  void _undo() {
    if (_strokes.isEmpty) return;
    setState(() {
      final popped = _strokes.removeLast();
      _redoStack.add(popped);
    });
    print('drawingpad.undo: strokes=${_strokes.length} '
        'redo=${_redoStack.length}');
  }

  void _redo() {
    if (_redoStack.isEmpty) return;
    setState(() {
      final restored = _redoStack.removeLast();
      _strokes.add(restored);
    });
    print('drawingpad.redo: strokes=${_strokes.length} '
        'redo=${_redoStack.length}');
  }

  void _clearAll() {
    setState(() {
      _strokes.clear();
      _redoStack.clear();
      _inProgress = null;
    });
    print('drawingpad.clear');
  }

  void _selectColor(Color color) {
    setState(() {
      _currentColor = color;
    });
    print('drawingpad.color=$color');
  }

  void _setBrushSize(double size) {
    setState(() {
      _brushSize = size;
    });
    // The slider fires this every frame while dragging; emit a
    // single print per setState so the trail stays useful.
    print('drawingpad.brush=$size');
  }

  // ── Build ───────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        title: const Text('Drawing Pad'),
        backgroundColor: scheme.surface,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: scheme.outlineVariant,
                      width: 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: GestureDetector(
                      key: const ValueKey<String>('canvas-area'),
                      behavior: HitTestBehavior.opaque,
                      onPanStart: _onPanStart,
                      onPanUpdate: _onPanUpdate,
                      onPanEnd: _onPanEnd,
                      child: CustomPaint(
                        key: const ValueKey<String>('canvas-paint'),
                        size: Size.infinite,
                        painter: CanvasPainter(
                          strokes: _strokes,
                          inProgress: _inProgress,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            DrawingToolBar(
              palette: _palette,
              selectedColor: _currentColor,
              onColorSelected: _selectColor,
              brushSize: _brushSize,
              minBrush: _minBrush,
              maxBrush: _maxBrush,
              onBrushSizeChanged: _setBrushSize,
              canUndo: _canUndo,
              canRedo: _canRedo,
              onUndo: _undo,
              onRedo: _redo,
              onClear: _clearAll,
            ),
          ],
        ),
      ),
    );
  }
}
