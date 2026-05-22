// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
//
// Deep visual demo for the flutter/gestures.dart class taxonomy.
//
// Design plan:
//   This script renders an inline, scrollable visual survey of the gesture
//   class taxonomy exposed by package:flutter/gestures.dart. It is consumed
//   by the d4rt AST test runner which evaluates the program statically: no
//   pointer events will fire, so every "preview" GestureDetector is wired
//   only for shape and structure. The narrative is split into the following
//   numbered visual sections:
//     1. Class hierarchy banner (GestureRecognizer subtree)
//     2. GestureDetector facade (the widget that owns recognizers)
//     3. Recognizer catalogue (Tap, DoubleTap, LongPress, Pan, Scale,
//        ForcePress, VerticalDrag, HorizontalDrag) with mini diagrams
//     4. Pointer event hierarchy (Down, Move, Up, Cancel, Scroll)
//     5. GestureArenaManager and arena resolution diagram
//     6. Velocity and VelocityTracker visual model
//     7. DragStartBehavior comparison panel
//     8. Decision matrix: which recognizer for which interaction
//     9. Recipe cards: common gesture composition patterns
//    10. Glossary and key takeaways
//   The root widget is a StatelessWidget returning MaterialApp -> Scaffold
//   -> SingleChildScrollView -> Column. Material 3 ColorScheme accents are
//   used throughout (primaryContainer / secondaryContainer / etc.).
//   No timers, no async, no navigation. Pure declarative tree.

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

void main() => runApp(const GestureClassDemoApp());

// ---------------------------------------------------------------------------
// Root application
// ---------------------------------------------------------------------------

class GestureClassDemoApp extends StatelessWidget {
  const GestureClassDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    );
    final ThemeData theme =
        ThemeData(colorScheme: colorScheme, useMaterial3: true);
    print('GestureClassDemo: building root MaterialApp');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestures Class Taxonomy Demo',
      theme: theme,
      home: Scaffold(
        backgroundColor: colorScheme.surface,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _GradientBanner(colorScheme: colorScheme),
              const SizedBox(height: 24.0),
              _SectionHeading(
                number: 1,
                title: 'Class hierarchy at a glance',
                colorScheme: colorScheme,
              ),
              _HierarchySection(colorScheme: colorScheme),
              const SizedBox(height: 28.0),
              _SectionHeading(
                number: 2,
                title: 'GestureDetector: the widget facade',
                colorScheme: colorScheme,
              ),
              _GestureDetectorFacadeSection(colorScheme: colorScheme),
              const SizedBox(height: 28.0),
              _SectionHeading(
                number: 3,
                title: 'Recognizer catalogue',
                colorScheme: colorScheme,
              ),
              _RecognizerCatalogueSection(colorScheme: colorScheme),
              const SizedBox(height: 28.0),
              _SectionHeading(
                number: 4,
                title: 'PointerEvent hierarchy',
                colorScheme: colorScheme,
              ),
              _PointerEventSection(colorScheme: colorScheme),
              const SizedBox(height: 28.0),
              _SectionHeading(
                number: 5,
                title: 'GestureArenaManager and arena resolution',
                colorScheme: colorScheme,
              ),
              _ArenaSection(colorScheme: colorScheme),
              const SizedBox(height: 28.0),
              _SectionHeading(
                number: 6,
                title: 'Velocity and VelocityTracker',
                colorScheme: colorScheme,
              ),
              _VelocitySection(colorScheme: colorScheme),
              const SizedBox(height: 28.0),
              _SectionHeading(
                number: 7,
                title: 'DragStartBehavior comparison',
                colorScheme: colorScheme,
              ),
              _DragStartBehaviorSection(colorScheme: colorScheme),
              const SizedBox(height: 28.0),
              _SectionHeading(
                number: 8,
                title: 'Decision matrix',
                colorScheme: colorScheme,
              ),
              _DecisionMatrixSection(colorScheme: colorScheme),
              const SizedBox(height: 28.0),
              _SectionHeading(
                number: 9,
                title: 'Recipes: common composition patterns',
                colorScheme: colorScheme,
              ),
              _RecipeSection(colorScheme: colorScheme),
              const SizedBox(height: 28.0),
              _SectionHeading(
                number: 10,
                title: 'Glossary and key takeaways',
                colorScheme: colorScheme,
              ),
              _GlossarySection(colorScheme: colorScheme),
              const SizedBox(height: 40.0),
              _Footer(colorScheme: colorScheme),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Top gradient banner
// ---------------------------------------------------------------------------

class _GradientBanner extends StatelessWidget {
  final ColorScheme colorScheme;
  const _GradientBanner({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    print('=== Section 0: Banner ===');
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            colorScheme.primary,
            colorScheme.tertiary,
            colorScheme.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.25),
            blurRadius: 18.0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary.withValues(alpha: 0.18),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.touch_app,
                  size: 36.0,
                  color: colorScheme.onPrimary,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'flutter/gestures.dart',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 14.0,
                        color: colorScheme.onPrimary.withValues(alpha: 0.85),
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      'Class taxonomy: deep visual demo',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Text(
            'A survey of the recognizer, pointer, arena, and velocity classes '
            'exposed by the gestures library. Static previews only - callbacks '
            'are declared for shape but will not fire in this AST run.',
            style: TextStyle(
              fontSize: 13.5,
              height: 1.4,
              color: colorScheme.onPrimary.withValues(alpha: 0.92),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Reusable section heading
// ---------------------------------------------------------------------------

class _SectionHeading extends StatelessWidget {
  final int number;
  final String title;
  final ColorScheme colorScheme;

  const _SectionHeading({
    required this.number,
    required this.title,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    print('=== Section $number: $title ===');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 36.0,
            height: 36.0,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              shape: BoxShape.circle,
              border: Border.all(color: colorScheme.primary, width: 1.5),
            ),
            child: Center(
              child: Text(
                '$number',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: colorScheme.outlineVariant,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 1: Hierarchy tree
// ---------------------------------------------------------------------------

class _HierarchySection extends StatelessWidget {
  final ColorScheme colorScheme;
  const _HierarchySection({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final _HierNode root = _HierNode(
      'GestureRecognizer',
      Icons.account_tree,
      colorScheme.primary,
      <_HierNode>[
        _HierNode(
          'OneSequenceGestureRecognizer',
          Icons.linear_scale,
          colorScheme.secondary,
          <_HierNode>[
            _HierNode(
              'PrimaryPointerGestureRecognizer',
              Icons.adjust,
              colorScheme.tertiary,
              <_HierNode>[
                _HierNode('TapGestureRecognizer', Icons.touch_app,
                    colorScheme.primary, const <_HierNode>[]),
                _HierNode('LongPressGestureRecognizer', Icons.timer,
                    colorScheme.secondary, const <_HierNode>[]),
                _HierNode('ForcePressGestureRecognizer', Icons.compress,
                    colorScheme.error, const <_HierNode>[]),
              ],
            ),
            _HierNode(
              'DragGestureRecognizer',
              Icons.swipe,
              colorScheme.tertiary,
              <_HierNode>[
                _HierNode('VerticalDragGestureRecognizer', Icons.swap_vert,
                    colorScheme.primary, const <_HierNode>[]),
                _HierNode('HorizontalDragGestureRecognizer', Icons.swap_horiz,
                    colorScheme.secondary, const <_HierNode>[]),
                _HierNode('PanGestureRecognizer', Icons.open_with,
                    colorScheme.tertiary, const <_HierNode>[]),
              ],
            ),
            _HierNode('ScaleGestureRecognizer', Icons.zoom_out_map,
                colorScheme.error, const <_HierNode>[]),
            _HierNode('DoubleTapGestureRecognizer', Icons.touch_app_outlined,
                colorScheme.primary, const <_HierNode>[]),
          ],
        ),
      ],
    );

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Indentation reflects subclass depth. Leaves are the concrete '
            'recognizers you instantiate in widgets.',
            style: TextStyle(
              fontSize: 12.5,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12.0),
          ..._renderHier(root, 0),
        ],
      ),
    );
  }

  List<Widget> _renderHier(_HierNode node, int depth) {
    final List<Widget> out = <Widget>[];
    out.add(
      Padding(
        padding: EdgeInsets.only(left: depth * 18.0, top: 4.0, bottom: 4.0),
        child: Row(
          children: <Widget>[
            Icon(node.icon, size: 18.0, color: node.color),
            const SizedBox(width: 8.0),
            Text(
              node.name,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13.0,
                color: node.color,
                fontWeight: depth <= 1 ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
    for (final _HierNode c in node.children) {
      out.addAll(_renderHier(c, depth + 1));
    }
    return out;
  }
}

class _HierNode {
  final String name;
  final IconData icon;
  final Color color;
  final List<_HierNode> children;
  const _HierNode(this.name, this.icon, this.color, this.children);
}

// ---------------------------------------------------------------------------
// Section 2: GestureDetector facade
// ---------------------------------------------------------------------------

class _GestureDetectorFacadeSection extends StatelessWidget {
  final ColorScheme colorScheme;
  const _GestureDetectorFacadeSection({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.widgets, color: colorScheme.onSecondaryContainer),
                  const SizedBox(width: 8.0),
                  Text(
                    'GestureDetector',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSecondaryContainer,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6.0),
              Text(
                'A widget that bundles a set of gesture recognizers and exposes '
                'them through a single declarative API. Internally it creates '
                'recognizers in a RawGestureDetector and forwards pointer events '
                'to them via the global gesture binding.',
                style: TextStyle(
                  fontSize: 12.5,
                  color: colorScheme.onSecondaryContainer,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        // Preview tiles - GestureDetector callbacks are inert under AST run.
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          alignment: WrapAlignment.center,
          children: <Widget>[
            _buildPreviewTile(
              Icons.touch_app,
              'onTap',
              colorScheme.primary,
              GestureDetector(
                onTap: () {
                  print('preview onTap');
                },
                child: _previewBox(
                  colorScheme.primary,
                  'Tap me',
                  Icons.adjust,
                ),
              ),
            ),
            _buildPreviewTile(
              Icons.touch_app_outlined,
              'onDoubleTap',
              colorScheme.secondary,
              GestureDetector(
                onDoubleTap: () {
                  print('preview onDoubleTap');
                },
                child: _previewBox(
                  colorScheme.secondary,
                  '2x Tap',
                  Icons.repeat,
                ),
              ),
            ),
            _buildPreviewTile(
              Icons.timer,
              'onLongPress',
              colorScheme.tertiary,
              GestureDetector(
                onLongPress: () {
                  print('preview onLongPress');
                },
                child: _previewBox(
                  colorScheme.tertiary,
                  'Hold',
                  Icons.timer,
                ),
              ),
            ),
            _buildPreviewTile(
              Icons.open_with,
              'onPanUpdate',
              colorScheme.error,
              GestureDetector(
                onPanUpdate: (DragUpdateDetails d) {
                  print('preview onPanUpdate ${d.delta}');
                },
                child: _previewBox(
                  colorScheme.error,
                  'Drag',
                  Icons.open_with,
                ),
              ),
            ),
            _buildPreviewTile(
              Icons.zoom_out_map,
              'onScaleUpdate',
              colorScheme.primary,
              GestureDetector(
                onScaleUpdate: (ScaleUpdateDetails d) {
                  print('preview onScaleUpdate ${d.scale}');
                },
                child: _previewBox(
                  colorScheme.primary,
                  'Pinch',
                  Icons.zoom_out_map,
                ),
              ),
            ),
            _buildPreviewTile(
              Icons.swap_vert,
              'onVerticalDrag',
              colorScheme.secondary,
              GestureDetector(
                onVerticalDragUpdate: (DragUpdateDetails d) {
                  print('preview onVerticalDragUpdate ${d.primaryDelta}');
                },
                child: _previewBox(
                  colorScheme.secondary,
                  'V drag',
                  Icons.swap_vert,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _previewBox(Color color, String label, IconData icon) {
    return Container(
      width: 96.0,
      height: 72.0,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, color: color, size: 22.0),
          const SizedBox(height: 4.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewTile(
    IconData icon,
    String label,
    Color color,
    Widget child,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        child,
        const SizedBox(height: 6.0),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 14.0, color: color),
            const SizedBox(width: 4.0),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Section 3: Recognizer catalogue
// ---------------------------------------------------------------------------

class _RecognizerCatalogueSection extends StatelessWidget {
  final ColorScheme colorScheme;
  const _RecognizerCatalogueSection({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final List<_RecognizerEntry> entries = <_RecognizerEntry>[
      _RecognizerEntry(
        name: 'TapGestureRecognizer',
        purpose:
            'Detect a single confirmed tap. Fires onTap once the pointer is '
            'released within the slop radius and no other recognizer claims '
            'the gesture.',
        callbacks: const <String>[
          'onTapDown',
          'onTapUp',
          'onTap',
          'onTapCancel',
        ],
        accent: colorScheme.primary,
        icon: Icons.touch_app,
        diagram: _TapDiagram(color: colorScheme.primary),
      ),
      _RecognizerEntry(
        name: 'DoubleTapGestureRecognizer',
        purpose:
            'Detect two taps in quick succession within kDoubleTapTimeout and '
            'kDoubleTapSlop. Single tap is reported separately if the second '
            'never arrives.',
        callbacks: const <String>[
          'onDoubleTapDown',
          'onDoubleTap',
          'onDoubleTapCancel',
        ],
        accent: colorScheme.secondary,
        icon: Icons.touch_app_outlined,
        diagram: _DoubleTapDiagram(color: colorScheme.secondary),
      ),
      _RecognizerEntry(
        name: 'LongPressGestureRecognizer',
        purpose:
            'Detect a stationary press that exceeds kLongPressTimeout (500 ms '
            'by default). Supports start/move/up callbacks for press-and-hold '
            'interactions.',
        callbacks: const <String>[
          'onLongPress',
          'onLongPressStart',
          'onLongPressMoveUpdate',
          'onLongPressEnd',
        ],
        accent: colorScheme.tertiary,
        icon: Icons.timer,
        diagram: _LongPressDiagram(color: colorScheme.tertiary),
      ),
      _RecognizerEntry(
        name: 'PanGestureRecognizer',
        purpose:
            'Two-dimensional drag. Wins the arena once the pointer moves past '
            'kTouchSlop in any direction. Emits incremental delta updates.',
        callbacks: const <String>[
          'onPanStart',
          'onPanUpdate',
          'onPanEnd',
          'onPanCancel',
        ],
        accent: colorScheme.error,
        icon: Icons.open_with,
        diagram: _PanDiagram(color: colorScheme.error),
      ),
      _RecognizerEntry(
        name: 'ScaleGestureRecognizer',
        purpose:
            'Multi-pointer pinch / spread / rotate. Reports scale, rotation, '
            'focal point and pointerCount through ScaleUpdateDetails.',
        callbacks: const <String>[
          'onScaleStart',
          'onScaleUpdate',
          'onScaleEnd',
        ],
        accent: colorScheme.primary,
        icon: Icons.zoom_out_map,
        diagram: _ScaleDiagram(color: colorScheme.primary),
      ),
      _RecognizerEntry(
        name: 'ForcePressGestureRecognizer',
        purpose:
            'Pressure-sensitive press, available on platforms with a force '
            'channel (3D Touch, stylus). Triggers above startPressure and '
            'peakPressure thresholds.',
        callbacks: const <String>[
          'onStart',
          'onPeak',
          'onUpdate',
          'onEnd',
        ],
        accent: colorScheme.error,
        icon: Icons.compress,
        diagram: _ForceDiagram(color: colorScheme.error),
      ),
      _RecognizerEntry(
        name: 'VerticalDragGestureRecognizer',
        purpose:
            'One-axis drag. Wins the arena when vertical motion exceeds slop. '
            'Used by Scrollable for vertical scroll views.',
        callbacks: const <String>[
          'onStart',
          'onUpdate',
          'onEnd',
          'onCancel',
        ],
        accent: colorScheme.secondary,
        icon: Icons.swap_vert,
        diagram: _VerticalDragDiagram(color: colorScheme.secondary),
      ),
      _RecognizerEntry(
        name: 'HorizontalDragGestureRecognizer',
        purpose:
            'One-axis drag. Wins the arena when horizontal motion exceeds '
            'slop. Used by Dismissible and PageView for horizontal motion.',
        callbacks: const <String>[
          'onStart',
          'onUpdate',
          'onEnd',
          'onCancel',
        ],
        accent: colorScheme.tertiary,
        icon: Icons.swap_horiz,
        diagram: _HorizontalDragDiagram(color: colorScheme.tertiary),
      ),
    ];

    return Column(
      children: <Widget>[
        for (final _RecognizerEntry e in entries) _buildEntry(e),
      ],
    );
  }

  Widget _buildEntry(_RecognizerEntry e) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: e.accent.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: e.accent.withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 96.0,
            height: 96.0,
            decoration: BoxDecoration(
              color: e.accent.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: e.accent.withValues(alpha: 0.4)),
            ),
            child: e.diagram,
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(e.icon, color: e.accent, size: 20.0),
                    const SizedBox(width: 6.0),
                    Expanded(
                      child: Text(
                        e.name,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0,
                          color: e.accent,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6.0),
                Text(
                  e.purpose,
                  style: const TextStyle(fontSize: 12.5, height: 1.4),
                ),
                const SizedBox(height: 8.0),
                Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0,
                  children: <Widget>[
                    for (final String cb in e.callbacks)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 3.0,
                        ),
                        decoration: BoxDecoration(
                          color: e.accent.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: e.accent.withValues(alpha: 0.4),
                          ),
                        ),
                        child: Text(
                          cb,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 10.5,
                            color: e.accent,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RecognizerEntry {
  final String name;
  final String purpose;
  final List<String> callbacks;
  final Color accent;
  final IconData icon;
  final Widget diagram;
  _RecognizerEntry({
    required this.name,
    required this.purpose,
    required this.callbacks,
    required this.accent,
    required this.icon,
    required this.diagram,
  });
}

// ---- mini-diagrams used inside recognizer cards ---------------------------

class _TapDiagram extends StatelessWidget {
  final Color color;
  const _TapDiagram({required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 26.0,
        height: 26.0,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: color.withValues(alpha: 0.4),
              blurRadius: 10.0,
              spreadRadius: 3.0,
            ),
          ],
        ),
      ),
    );
  }
}

class _DoubleTapDiagram extends StatelessWidget {
  final Color color;
  const _DoubleTapDiagram({required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 18.0,
            height: 18.0,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 4.0),
          Icon(Icons.east, size: 14.0, color: color.withValues(alpha: 0.7)),
          const SizedBox(width: 4.0),
          Container(
            width: 18.0,
            height: 18.0,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }
}

class _LongPressDiagram extends StatelessWidget {
  final Color color;
  const _LongPressDiagram({required this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: 60.0,
          height: 60.0,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
            border:
                Border.all(color: color.withValues(alpha: 0.5), width: 2.0),
          ),
        ),
        Icon(Icons.timer, size: 32.0, color: color),
      ],
    );
  }
}

class _PanDiagram extends StatelessWidget {
  final Color color;
  const _PanDiagram({required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: CustomPaint(
        painter: _PanPainter(color: color),
        size: const Size.square(84.0),
      ),
    );
  }
}

class _PanPainter extends CustomPainter {
  final Color color;
  _PanPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint stroke = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    final Path path = Path()
      ..moveTo(8, size.height - 8)
      ..quadraticBezierTo(
        size.width / 2,
        4,
        size.width - 8,
        size.height / 2,
      );
    canvas.drawPath(path, stroke);
    final Paint dot = Paint()..color = color;
    canvas.drawCircle(Offset(8, size.height - 8), 4.0, dot);
    canvas.drawCircle(Offset(size.width - 8, size.height / 2), 4.0, dot);
  }

  @override
  bool shouldRepaint(covariant _PanPainter oldDelegate) =>
      oldDelegate.color != color;
}

class _ScaleDiagram extends StatelessWidget {
  final Color color;
  const _ScaleDiagram({required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.arrow_back, color: color, size: 18.0),
          Container(
            width: 16.0,
            height: 16.0,
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          Container(
            width: 16.0,
            height: 16.0,
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          Icon(Icons.arrow_forward, color: color, size: 18.0),
        ],
      ),
    );
  }
}

class _ForceDiagram extends StatelessWidget {
  final Color color;
  const _ForceDiagram({required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.arrow_downward, color: color, size: 18.0),
          Container(
            width: 30.0,
            height: 30.0,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.3),
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 2.0),
            ),
          ),
        ],
      ),
    );
  }
}

class _VerticalDragDiagram extends StatelessWidget {
  final Color color;
  const _VerticalDragDiagram({required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.arrow_upward, color: color, size: 18.0),
          Container(width: 3.0, height: 24.0, color: color),
          Icon(Icons.arrow_downward, color: color, size: 18.0),
        ],
      ),
    );
  }
}

class _HorizontalDragDiagram extends StatelessWidget {
  final Color color;
  const _HorizontalDragDiagram({required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.arrow_back, color: color, size: 18.0),
          Container(width: 30.0, height: 3.0, color: color),
          Icon(Icons.arrow_forward, color: color, size: 18.0),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 4: PointerEvent hierarchy
// ---------------------------------------------------------------------------

class _PointerEventSection extends StatelessWidget {
  final ColorScheme colorScheme;
  const _PointerEventSection({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final List<_PointerEntry> events = <_PointerEntry>[
      _PointerEntry(
        'PointerDownEvent',
        'Fired when a finger / mouse button engages the screen.',
        Icons.south,
        colorScheme.primary,
      ),
      _PointerEntry(
        'PointerMoveEvent',
        'Fired while a pressed pointer moves. Carries delta and position.',
        Icons.timeline,
        colorScheme.tertiary,
      ),
      _PointerEntry(
        'PointerUpEvent',
        'Fired when the pointer is released. Closes the active sequence.',
        Icons.north,
        colorScheme.secondary,
      ),
      _PointerEntry(
        'PointerCancelEvent',
        'Fired when the system aborts a sequence (e.g. interruption).',
        Icons.cancel,
        colorScheme.error,
      ),
      _PointerEntry(
        'PointerScrollEvent',
        'Fired for trackpad / wheel scroll deltas (signal event).',
        Icons.mouse,
        colorScheme.primary,
      ),
      _PointerEntry(
        'PointerHoverEvent',
        'Fired for unpressed motion (mouse / stylus hover).',
        Icons.cloud,
        colorScheme.secondary,
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'All gesture recognition begins with a stream of PointerEvent '
            'instances delivered by the PointerRouter.',
            style: TextStyle(
              fontSize: 12.5,
              color: colorScheme.onSurface,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 12.0),
          ...events.map(_buildEventTile),
          const SizedBox(height: 8.0),
          _PointerLifelineDiagram(colorScheme: colorScheme),
        ],
      ),
    );
  }

  Widget _buildEventTile(_PointerEntry e) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: e.color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: e.color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 32.0,
            height: 32.0,
            decoration: BoxDecoration(
              color: e.color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(e.icon, color: e.color, size: 18.0),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  e.name,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                    color: e.color,
                    fontSize: 13.0,
                  ),
                ),
                Text(
                  e.description,
                  style: const TextStyle(fontSize: 11.5, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PointerEntry {
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  _PointerEntry(this.name, this.description, this.icon, this.color);
}

class _PointerLifelineDiagram extends StatelessWidget {
  final ColorScheme colorScheme;
  const _PointerLifelineDiagram({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: <Widget>[
          _step('Down', Icons.south, colorScheme.primary),
          _connector(colorScheme),
          _step('Move', Icons.timeline, colorScheme.tertiary),
          _connector(colorScheme),
          _step('Move', Icons.timeline, colorScheme.tertiary),
          _connector(colorScheme),
          _step('Up', Icons.north, colorScheme.secondary),
        ],
      ),
    );
  }

  Widget _step(String label, IconData icon, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Icon(icon, color: Colors.white, size: 18.0),
        ),
        const SizedBox(height: 4.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.0,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _connector(ColorScheme cs) {
    return Expanded(
      child: Container(
        height: 2.0,
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        color: cs.outlineVariant,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 5: Gesture arena
// ---------------------------------------------------------------------------

class _ArenaSection extends StatelessWidget {
  final ColorScheme colorScheme;
  const _ArenaSection({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: colorScheme.tertiaryContainer.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: colorScheme.tertiary.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.balance, color: colorScheme.tertiary),
              const SizedBox(width: 8.0),
              Text(
                'GestureArenaManager',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  color: colorScheme.tertiary,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          const Text(
            'When multiple recognizers want the same pointer sequence, they '
            'register in the arena. Each recognizer may accept, reject, or '
            'remain undecided. The first member to accept wins; the last one '
            'standing wins by default if all others reject.',
            style: TextStyle(fontSize: 12.5, height: 1.4),
          ),
          const SizedBox(height: 12.0),
          _ArenaDiagram(colorScheme: colorScheme),
          const SizedBox(height: 12.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: <Widget>[
              _arenaToken('accept', colorScheme.primary, Icons.check),
              _arenaToken('reject', colorScheme.error, Icons.close),
              _arenaToken('hold', colorScheme.secondary, Icons.pause),
              _arenaToken(
                  'sweep', colorScheme.tertiary, Icons.cleaning_services),
              _arenaToken('resolve', colorScheme.primary, Icons.gavel),
            ],
          ),
        ],
      ),
    );
  }

  Widget _arenaToken(String label, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 14.0, color: color),
          const SizedBox(width: 4.0),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 11.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _ArenaDiagram extends StatelessWidget {
  final ColorScheme colorScheme;
  const _ArenaDiagram({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        children: <Widget>[
          Text(
            'Arena resolution (illustrative)',
            style: TextStyle(
              fontSize: 12.0,
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _participant('Tap', colorScheme.primary, Icons.touch_app, false),
              _participant('Pan', colorScheme.tertiary, Icons.open_with, true),
              _participant(
                  'Scale', colorScheme.secondary, Icons.zoom_out_map, false),
              _participant('Drag-V', colorScheme.error, Icons.swap_vert, false),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.gavel, color: colorScheme.primary, size: 18.0),
              const SizedBox(width: 6.0),
              Text(
                'winner: Pan (moved past slop first)',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 12.0,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _participant(String label, Color color, IconData icon, bool winner) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 48.0,
          height: 48.0,
          decoration: BoxDecoration(
            color: winner ? color : color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: winner ? 3.0 : 1.5),
          ),
          child: Icon(
            icon,
            color: winner ? Colors.white : color,
            size: 22.0,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.0,
            color: color,
            fontWeight: winner ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        if (winner)
          Text(
            'WIN',
            style: TextStyle(
              fontSize: 9.0,
              color: color,
              fontWeight: FontWeight.w900,
            ),
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Section 6: Velocity and VelocityTracker
// ---------------------------------------------------------------------------

class _VelocitySection extends StatelessWidget {
  final ColorScheme colorScheme;
  const _VelocitySection({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    // Construct a few illustrative Velocity instances. These are real
    // gesture library objects; we render them statically.
    final List<Velocity> sample = <Velocity>[
      const Velocity(pixelsPerSecond: Offset(120.0, 0.0)),
      const Velocity(pixelsPerSecond: Offset(0.0, 240.0)),
      const Velocity(pixelsPerSecond: Offset(-180.0, -90.0)),
      const Velocity(pixelsPerSecond: Offset(300.0, 300.0)),
    ];
    for (final Velocity v in sample) {
      print('Velocity sample: ${v.pixelsPerSecond}');
    }

    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Velocity describes a 2D motion vector in pixelsPerSecond. '
            'VelocityTracker.withKind feeds it pointer samples and computes a '
            'best-fit fling velocity used to drive scroll physics.',
            style: TextStyle(fontSize: 12.5, height: 1.4),
          ),
          const SizedBox(height: 12.0),
          Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            children: <Widget>[
              for (final Velocity v in sample) _buildVelocityCard(v),
            ],
          ),
          const SizedBox(height: 12.0),
          _VelocityTrackerSchematic(colorScheme: colorScheme),
        ],
      ),
    );
  }

  Widget _buildVelocityCard(Velocity v) {
    final double mag = v.pixelsPerSecond.distance;
    final String dir = _label(v.pixelsPerSecond);
    return Container(
      width: 140.0,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            dir,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12.0,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            'dx ${v.pixelsPerSecond.dx.toStringAsFixed(1)}\n'
            'dy ${v.pixelsPerSecond.dy.toStringAsFixed(1)}',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
            ),
          ),
          const SizedBox(height: 6.0),
          LinearProgressIndicator(
            value: (mag / 600.0).clamp(0.0, 1.0),
            color: colorScheme.primary,
            backgroundColor: colorScheme.primary.withValues(alpha: 0.15),
          ),
          const SizedBox(height: 4.0),
          Text(
            '|v| ${mag.toStringAsFixed(1)} px/s',
            style: TextStyle(
              fontSize: 10.0,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  String _label(Offset o) {
    if (o.dx.abs() > o.dy.abs()) {
      return o.dx > 0 ? 'eastbound' : 'westbound';
    }
    return o.dy > 0 ? 'southbound' : 'northbound';
  }
}

class _VelocityTrackerSchematic extends StatelessWidget {
  final ColorScheme colorScheme;
  const _VelocityTrackerSchematic({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.speed, color: colorScheme.primary),
              const SizedBox(width: 8.0),
              Text(
                'VelocityTracker pipeline',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: <Widget>[
              _pipeStep('pointer\nsamples', Icons.touch_app, colorScheme),
              _pipeArrow(colorScheme),
              _pipeStep('least-squares\nfit', Icons.functions, colorScheme),
              _pipeArrow(colorScheme),
              _pipeStep('Velocity\nestimate', Icons.timeline, colorScheme),
              _pipeArrow(colorScheme),
              _pipeStep('fling\nsimulation', Icons.bolt, colorScheme),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pipeStep(String label, IconData icon, ColorScheme cs) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2.0),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: cs.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: cs.primary.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: <Widget>[
            Icon(icon, color: cs.primary, size: 20.0),
            const SizedBox(height: 4.0),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 9.5,
                color: cs.primary,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pipeArrow(ColorScheme cs) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Icon(Icons.east, color: cs.onSurfaceVariant, size: 18.0),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 7: DragStartBehavior comparison
// ---------------------------------------------------------------------------

class _DragStartBehaviorSection extends StatelessWidget {
  final ColorScheme colorScheme;
  const _DragStartBehaviorSection({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    // Reference real enum values from the gestures library
    const DragStartBehavior dsbStart = DragStartBehavior.start;
    const DragStartBehavior dsbDown = DragStartBehavior.down;
    print('DragStartBehavior values: $dsbStart $dsbDown');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: _behaviorCard(
            title: 'DragStartBehavior.down',
            value: dsbDown,
            accent: colorScheme.primary,
            description:
                'Drag begins as soon as the pointer goes down. Reduces input '
                'latency but may report start position before the user has '
                'expressed intent.',
            visualBuilder: (Color c) => _DownDiagram(color: c),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: _behaviorCard(
            title: 'DragStartBehavior.start',
            value: dsbStart,
            accent: colorScheme.secondary,
            description:
                'Drag begins only after the pointer has moved past slop. The '
                'reported start position reflects the moment of intent.',
            visualBuilder: (Color c) => _StartDiagram(color: c),
          ),
        ),
      ],
    );
  }

  Widget _behaviorCard({
    required String title,
    required DragStartBehavior value,
    required Color accent,
    required String description,
    required Widget Function(Color) visualBuilder,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: accent.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.flag, color: accent, size: 18.0),
              const SizedBox(width: 6.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                    color: accent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            height: 60.0,
            child: visualBuilder(accent),
          ),
          const SizedBox(height: 8.0),
          Text(
            description,
            style: const TextStyle(fontSize: 11.5, height: 1.4),
          ),
          const SizedBox(height: 6.0),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'enum: ${value.toString()}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: accent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DownDiagram extends StatelessWidget {
  final Color color;
  const _DownDiagram({required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _label('DOWN', color, true),
        const SizedBox(width: 4.0),
        Icon(Icons.east, color: color, size: 14.0),
        const SizedBox(width: 4.0),
        _label('move', color.withValues(alpha: 0.5), false),
        const SizedBox(width: 4.0),
        Icon(Icons.east, color: color, size: 14.0),
        const SizedBox(width: 4.0),
        _label('up', color.withValues(alpha: 0.5), false),
      ],
    );
  }

  Widget _label(String text, Color c, bool highlight) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
      decoration: BoxDecoration(
        color: highlight ? c : c.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 10.0,
          color: highlight ? Colors.white : c,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _StartDiagram extends StatelessWidget {
  final Color color;
  const _StartDiagram({required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _label('down', color.withValues(alpha: 0.5), false),
        const SizedBox(width: 4.0),
        Icon(Icons.east, color: color, size: 14.0),
        const SizedBox(width: 4.0),
        _label('MOVE', color, true),
        const SizedBox(width: 4.0),
        Icon(Icons.east, color: color, size: 14.0),
        const SizedBox(width: 4.0),
        _label('up', color.withValues(alpha: 0.5), false),
      ],
    );
  }

  Widget _label(String text, Color c, bool highlight) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
      decoration: BoxDecoration(
        color: highlight ? c : c.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 10.0,
          color: highlight ? Colors.white : c,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 8: Decision matrix
// ---------------------------------------------------------------------------

class _DecisionMatrixSection extends StatelessWidget {
  final ColorScheme colorScheme;
  const _DecisionMatrixSection({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final List<List<String>> rows = <List<String>>[
      <String>['Quick activate button', 'TapGestureRecognizer'],
      <String>['Reveal context menu', 'LongPressGestureRecognizer'],
      <String>['Zoom-to-fit on tap', 'DoubleTapGestureRecognizer'],
      <String>['Move a draggable card', 'PanGestureRecognizer'],
      <String>['Pinch to scale photo', 'ScaleGestureRecognizer'],
      <String>['Vertical scroll view', 'VerticalDragGestureRecognizer'],
      <String>['Swipe-to-dismiss row', 'HorizontalDragGestureRecognizer'],
      <String>['Pressure-sensitive draw', 'ForcePressGestureRecognizer'],
      <String>['Custom multi-finger combo', 'RawGestureDetector + custom'],
    ];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget>[
          Container(
            color: colorScheme.primary,
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Text(
                    'When you need to...',
                    style: TextStyle(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Text(
                    'Pick this recognizer',
                    style: TextStyle(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          for (int i = 0; i < rows.length; i++)
            Container(
              color: i.isEven
                  ? colorScheme.surfaceContainerHigh
                  : colorScheme.surface,
              padding: const EdgeInsets.symmetric(
                  horizontal: 12.0, vertical: 8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Text(
                      rows[i][0],
                      style: const TextStyle(fontSize: 12.5),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      rows[i][1],
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 9: Recipes
// ---------------------------------------------------------------------------

class _RecipeSection extends StatelessWidget {
  final ColorScheme colorScheme;
  const _RecipeSection({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final List<_Recipe> recipes = <_Recipe>[
      _Recipe(
        title: 'Tap + LongPress + DoubleTap together',
        body:
            'Use a single GestureDetector and supply onTap, onLongPress and '
            'onDoubleTap callbacks. The framework wires them into separate '
            'recognizers and resolves the arena for you.',
        icon: Icons.layers,
        accent: colorScheme.primary,
      ),
      _Recipe(
        title: 'Pan over a scrollable',
        body:
            'When a Pan should win over the parent scroll, wrap with '
            'RawGestureDetector and provide a PanGestureRecognizer through '
            'the gestures map so it competes in the same arena.',
        icon: Icons.layers_outlined,
        accent: colorScheme.secondary,
      ),
      _Recipe(
        title: 'Scale that also pans',
        body:
            'ScaleGestureRecognizer reports focalPointDelta. You can implement '
            'both pinch-zoom and pan in a single recognizer without composing '
            'a separate Pan.',
        icon: Icons.zoom_out_map,
        accent: colorScheme.tertiary,
      ),
      _Recipe(
        title: 'Fling-based dismiss',
        body:
            'Use HorizontalDragGestureRecognizer; in onEnd inspect '
            'DragEndDetails.velocity.pixelsPerSecond.dx and trigger dismiss '
            'when |dx| exceeds your threshold.',
        icon: Icons.swipe,
        accent: colorScheme.error,
      ),
      _Recipe(
        title: 'Custom team via GestureArenaTeam',
        body:
            'Group multiple recognizers under one team so they cooperate '
            'rather than fight. The team picks one captain that competes '
            'against outside recognizers.',
        icon: Icons.groups,
        accent: colorScheme.primary,
      ),
    ];

    return Column(
      children: <Widget>[
        for (final _Recipe r in recipes)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 6.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: r.accent.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: r.accent.withValues(alpha: 0.3)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: r.accent.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(r.icon, color: r.accent, size: 20.0),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        r.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: r.accent,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        r.body,
                        style:
                            const TextStyle(fontSize: 12.0, height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Recipe {
  final String title;
  final String body;
  final IconData icon;
  final Color accent;
  _Recipe({
    required this.title,
    required this.body,
    required this.icon,
    required this.accent,
  });
}

// ---------------------------------------------------------------------------
// Section 10: Glossary and key takeaways
// ---------------------------------------------------------------------------

class _GlossarySection extends StatelessWidget {
  final ColorScheme colorScheme;
  const _GlossarySection({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final List<List<String>> glossary = <List<String>>[
      <String>[
        'kTouchSlop',
        'Distance a pointer must travel before a drag is considered intent.',
      ],
      <String>[
        'kDoubleTapTimeout',
        'Maximum gap between two taps to be a double tap.',
      ],
      <String>[
        'kLongPressTimeout',
        'Press duration before a long-press fires (500 ms default).',
      ],
      <String>[
        'PointerRouter',
        'Routes raw pointer events to interested recognizers per pointer id.',
      ],
      <String>[
        'GestureBinding',
        'Singleton that owns the pointer router and arena manager.',
      ],
      <String>[
        'Arena',
        'Bookkeeping for competing recognizers on a single pointer sequence.',
      ],
      <String>[
        'Sweep',
        'Final arena resolution when no recognizer has yet accepted.',
      ],
      <String>[
        'OneSequenceGestureRecognizer',
        'Base class for recognizers that track a single pointer sequence.',
      ],
      <String>[
        'PrimaryPointerGestureRecognizer',
        'Sequence recognizer that locks onto the first pointer.',
      ],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                colorScheme.primaryContainer,
                colorScheme.tertiaryContainer,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.menu_book,
                      color: colorScheme.onPrimaryContainer),
                  const SizedBox(width: 8.0),
                  Text(
                    'Glossary',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              for (final List<String> row in glossary)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 170.0,
                        child: Text(
                          row[0],
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w700,
                            color: colorScheme.onPrimaryContainer,
                            fontSize: 12.5,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          row[1],
                          style: TextStyle(
                            fontSize: 12.0,
                            color: colorScheme.onPrimaryContainer
                                .withValues(alpha: 0.85),
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        _Takeaways(colorScheme: colorScheme),
      ],
    );
  }
}

class _Takeaways extends StatelessWidget {
  final ColorScheme colorScheme;
  const _Takeaways({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final List<_Takeaway> items = <_Takeaway>[
      _Takeaway(
        icon: Icons.touch_app,
        title: 'GestureDetector is a facade',
        body:
            'It only declares the callbacks; recognizers do the actual work '
            'inside a RawGestureDetector.',
        color: colorScheme.primary,
      ),
      _Takeaway(
        icon: Icons.account_tree,
        title: 'Recognizers form a tree',
        body:
            'All concrete recognizers descend from '
            'OneSequenceGestureRecognizer or PrimaryPointerGestureRecognizer.',
        color: colorScheme.secondary,
      ),
      _Takeaway(
        icon: Icons.balance,
        title: 'The arena decides ties',
        body:
            'When recognizers compete, the GestureArenaManager picks a winner '
            'based on accept/reject votes and sweeps.',
        color: colorScheme.tertiary,
      ),
      _Takeaway(
        icon: Icons.speed,
        title: 'Velocity drives fling',
        body:
            'VelocityTracker turns a stream of pointer samples into a '
            'pixels-per-second vector consumed by scroll physics.',
        color: colorScheme.error,
      ),
      _Takeaway(
        icon: Icons.flag,
        title: 'DragStartBehavior shapes UX',
        body:
            '"down" minimises latency; "start" preserves intent. Choose '
            'consciously per interaction.',
        color: colorScheme.primary,
      ),
    ];

    return Column(
      children: <Widget>[
        for (final _Takeaway t in items)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: t.color.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: t.color.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 38.0,
                  height: 38.0,
                  decoration: BoxDecoration(
                    color: t.color.withValues(alpha: 0.18),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(t.icon, color: t.color, size: 20.0),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        t.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: t.color,
                        ),
                      ),
                      Text(
                        t.body,
                        style:
                            const TextStyle(fontSize: 12.0, height: 1.35),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Takeaway {
  final IconData icon;
  final String title;
  final String body;
  final Color color;
  _Takeaway({
    required this.icon,
    required this.title,
    required this.body,
    required this.color,
  });
}

// ---------------------------------------------------------------------------
// Footer
// ---------------------------------------------------------------------------

class _Footer extends StatelessWidget {
  final ColorScheme colorScheme;
  const _Footer({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    print('GestureClassDemo: footer rendered');
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.info_outline, color: colorScheme.primary),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'End of deep visual demo. All recognizer previews are static under '
              'AST execution: callbacks are wired for shape only and do not '
              'fire because no pointer events are routed.',
              style: TextStyle(
                fontSize: 12.0,
                color: colorScheme.onSurfaceVariant,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
