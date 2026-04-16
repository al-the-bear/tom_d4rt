// Deep visual demo: MatrixTransition — explicitly-animated Matrix4 transform widget.
// Authored manually. STATELESS ONLY. Top-level ValueNotifiers drive interactivity.
// Entry point: dynamic build(BuildContext context)

import 'dart:math' as math;
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// Top-level ValueNotifiers (stateless interactivity)
// ═══════════════════════════════════════════════════════════════════════════════

/// Playground slider: 0..1 drives the rotation demo on the Playground tab.
final ValueNotifier<double> _playgroundT = ValueNotifier<double>(0.0);

/// Compound tab slider: drives rotate + scale + translate simultaneously.
final ValueNotifier<double> _compoundT = ValueNotifier<double>(0.3);

/// Curves tab: selected curve index 0..5.
final ValueNotifier<int> _curveIndex = ValueNotifier<int>(0);

/// Diagram tab: selected highlight category (0=rotation, 1=scale, 2=translation, 3=perspective).
final ValueNotifier<int> _diagramCategory = ValueNotifier<int>(0);

// ═══════════════════════════════════════════════════════════════════════════════
// Constants
// ═══════════════════════════════════════════════════════════════════════════════

const Color _seedColor = Color(0xFF5B4FCF);

const List<String> _curveNames = <String>[
  'linear',
  'easeIn',
  'easeOut',
  'easeInOut',
  'bounceOut',
  'elasticOut',
];

final List<Curve> _curves = <Curve>[
  Curves.linear,
  Curves.easeIn,
  Curves.easeOut,
  Curves.easeInOut,
  Curves.bounceOut,
  Curves.elasticOut,
];

const List<String> _diagramCategories = <String>[
  'Rotation',
  'Scale',
  'Translation',
  'Perspective',
];

// ═══════════════════════════════════════════════════════════════════════════════
// Entry point
// ═══════════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) => const _DemoApp();

// ═══════════════════════════════════════════════════════════════════════════════
// App shell
// ═══════════════════════════════════════════════════════════════════════════════

class _DemoApp extends StatelessWidget {
  const _DemoApp();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = ColorScheme.fromSeed(seedColor: _seedColor);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.w700),
          titleMedium: TextStyle(fontWeight: FontWeight.w600),
          bodyMedium: TextStyle(height: 1.4),
        ),
      ),
      home: const _Home(),
    );
  }
}

class _Home extends StatelessWidget {
  const _Home();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: 11,
      child: Scaffold(
        backgroundColor: scheme.surface,
        appBar: AppBar(
          title: const Text('MatrixTransition — Deep Visual Demo'),
          backgroundColor: scheme.primaryContainer,
          foregroundColor: scheme.onPrimaryContainer,
          bottom: const TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: <Tab>[
              Tab(icon: Icon(Icons.rocket_launch_outlined), text: 'Hero'),
              Tab(icon: Icon(Icons.tune), text: 'Playground'),
              Tab(icon: Icon(Icons.rotate_90_degrees_ccw_outlined), text: 'Rotation'),
              Tab(icon: Icon(Icons.zoom_in_outlined), text: 'Scale'),
              Tab(icon: Icon(Icons.transform_outlined), text: 'Skew'),
              Tab(icon: Icon(Icons.flip_outlined), text: 'Flip'),
              Tab(icon: Icon(Icons.blur_on_outlined), text: 'Compound'),
              Tab(icon: Icon(Icons.show_chart_outlined), text: 'Curves'),
              Tab(icon: Icon(Icons.grid_3x3_outlined), text: 'Diagram'),
              Tab(icon: Icon(Icons.compare_arrows_outlined), text: 'Compare'),
              Tab(icon: Icon(Icons.menu_book_outlined), text: 'API'),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _HeroTab(),
            _PlaygroundTab(),
            _RotationTab(),
            _ScaleTab(),
            _SkewTab(),
            _FlipTab(),
            _CompoundTab(),
            _CurvesTab(),
            _DiagramTab(),
            _CompareTab(),
            _ApiTab(),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Shared helpers
// ═══════════════════════════════════════════════════════════════════════════════

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.subtitle, required this.child});
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w700, color: scheme.onSurface),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.icon, required this.title, required this.body});
  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: scheme.onSecondaryContainer),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: scheme.onSecondaryContainer),
                ),
                const SizedBox(height: 4),
                Text(body, style: TextStyle(color: scheme.onSecondaryContainer, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeChip extends StatelessWidget {
  const _CodeChip(this.code);
  final String code;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Text(
        code,
        style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
      ),
    );
  }
}

/// A card that frames a demo widget inside a clipped stage.
class _DemoFrame extends StatelessWidget {
  const _DemoFrame({required this.label, required this.child, this.height = 140});
  final String label;
  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Container(
              height: height,
              width: double.infinity,
              color: scheme.surfaceContainerLowest,
              child: Center(child: child),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

/// A simple colourful card shown as the subject of transforms.
class _SubjectCard extends StatelessWidget {
  const _SubjectCard({this.label = 'Card', this.width = 80, this.height = 56});
  final String label;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Color bg = scheme.primaryContainer;
    final Color fg = scheme.onPrimaryContainer;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black.withAlpha(40), blurRadius: 6, offset: const Offset(0, 3)),
        ],
      ),
      child: Center(
        child: Text(label, style: TextStyle(color: fg, fontWeight: FontWeight.w600, fontSize: 11)),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Tab 1 — Hero
// ═══════════════════════════════════════════════════════════════════════════════

class _HeroTab extends StatelessWidget {
  const _HeroTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return _Section(
      title: 'MatrixTransition',
      subtitle:
          'An explicitly-animated widget that applies a Matrix4 transform via an onTransform callback. '
          'Unlike RotationTransition or ScaleTransition, MatrixTransition exposes the full 4×4 affine matrix, '
          'enabling rotation, scale, skew, translation, and perspective in a single pass.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Live banner demo: auto-animated rotation
          _BannerRotator(),
          const SizedBox(height: 28),
          const _InfoCard(
            icon: Icons.info_outline,
            title: 'What is MatrixTransition?',
            body:
                'MatrixTransition extends AnimatedWidget. It wraps an Animation<double> and calls '
                'onTransform(animationValue) on each frame, passing the resulting Matrix4 to a '
                'Transform widget. You supply the mapping from double progress to Matrix4.',
          ),
          const SizedBox(height: 16),
          const _InfoCard(
            icon: Icons.compare_outlined,
            title: 'vs. RotationTransition / ScaleTransition',
            body:
                'RotationTransition and ScaleTransition handle only one axis of transform each. '
                'MatrixTransition accepts any Matrix4, so you can combine rotation, non-uniform scale, '
                'shear, translation, and even perspective projection into one widget and one animation.',
          ),
          const SizedBox(height: 16),
          const _InfoCard(
            icon: Icons.warning_amber_outlined,
            title: 'Stateless driving strategy (used in this demo)',
            body:
                'Because we are STATELESS, animations are driven either by TweenAnimationBuilder<double> '
                '(wrapping a fixed duration) or by wrapping a ValueNotifier<double> slider value in '
                'AlwaysStoppedAnimation<double>(t). Both yield an Animation<double> for MatrixTransition.',
          ),
          const SizedBox(height: 24),
          Text('Constructor signature', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: scheme.outlineVariant),
            ),
            child: const Text(
              'MatrixTransition({\n'
              '  Key? key,\n'
              '  required Animation<double> animation,\n'
              '  required TransformCallback onTransform,\n'
              '  Alignment alignment = Alignment.center,\n'
              '  FilterQuality? filterQuality,\n'
              '  Widget? child,\n'
              '})\n\n'
              'typedef TransformCallback = Matrix4 Function(double animationValue);',
              style: TextStyle(fontFamily: 'monospace', fontSize: 12.5, height: 1.6),
            ),
          ),
          const SizedBox(height: 24),
          Text('Key concepts', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              for (final String chip in <String>[
                'Animation<double>',
                'TransformCallback',
                'Matrix4.rotationZ()',
                'Matrix4.diagonal3Values()',
                'Matrix4.skewX()',
                'AlwaysStoppedAnimation',
                'TweenAnimationBuilder',
                'FilterQuality',
                'Alignment pivot',
              ])
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: scheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    chip,
                    style: TextStyle(
                      fontSize: 12,
                      color: scheme.onPrimaryContainer,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Banner that uses TweenAnimationBuilder to spin a card 0→360° in 4 s.
class _BannerRotator extends StatelessWidget {
  const _BannerRotator();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[scheme.primaryContainer, scheme.secondaryContainer],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(seconds: 4),
            builder: (BuildContext ctx, double t, Widget? child) {
              return MatrixTransition(
                animation: AlwaysStoppedAnimation<double>(t),
                onTransform: (double v) => Matrix4.rotationZ(v * 2 * math.pi),
                child: child,
              );
            },
            child: Container(
              width: 90,
              height: 60,
              decoration: BoxDecoration(
                color: scheme.primary,
                borderRadius: BorderRadius.circular(12),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withAlpha(60),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Matrix\nTransition',
                  style: TextStyle(
                    color: scheme.onPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            child: Text(
              'Rotating 0 → 360° via TweenAnimationBuilder',
              style: TextStyle(color: scheme.onPrimaryContainer, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Tab 2 — Playground
// ═══════════════════════════════════════════════════════════════════════════════

class _PlaygroundTab extends StatelessWidget {
  const _PlaygroundTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return _Section(
      title: 'Slider Playground',
      subtitle:
          'Drag the slider to set t (0→1). The card is wrapped in MatrixTransition with '
          'AlwaysStoppedAnimation<double>(t) driving rotation from 0° to 360°. '
          'The current Matrix4 values update below.',
      child: ValueListenableBuilder<double>(
        valueListenable: _playgroundT,
        builder: (BuildContext ctx, double t, Widget? _) {
          final Matrix4 m = Matrix4.rotationZ(t * 2 * math.pi);
          final double degrees = t * 360.0;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Stage
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: Center(
                  child: MatrixTransition(
                    animation: AlwaysStoppedAnimation<double>(t),
                    onTransform: (double v) => Matrix4.rotationZ(v * 2 * math.pi),
                    child: const _SubjectCard(label: 'Rotate me', width: 90, height: 60),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Slider
              Row(
                children: <Widget>[
                  Text(
                    't = ${t.toStringAsFixed(3)}',
                    style: const TextStyle(fontFamily: 'monospace'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Slider(
                      value: t,
                      onChanged: (double v) => _playgroundT.value = v,
                    ),
                  ),
                  Text(
                    '${degrees.toStringAsFixed(1)}°',
                    style: const TextStyle(fontFamily: 'monospace'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Matrix display
              Text('Current Matrix4 (column-major)', style: Theme.of(ctx).textTheme.titleSmall),
              const SizedBox(height: 8),
              _Matrix4Grid(matrix: m),
              const SizedBox(height: 20),
              // Code snippet
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'MatrixTransition(\n'
                  '  animation: AlwaysStoppedAnimation<double>(t),\n'
                  '  onTransform: (double v) =>\n'
                  '      Matrix4.rotationZ(v * 2 * pi),\n'
                  '  child: myCard,\n'
                  ')',
                  style: TextStyle(fontFamily: 'monospace', fontSize: 12, height: 1.6),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Renders a Matrix4 as a 4×4 labelled grid.
class _Matrix4Grid extends StatelessWidget {
  const _Matrix4Grid({required this.matrix});
  final Matrix4 matrix;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final List<double> s = matrix.storage.toList();
    // Column-major: s[col*4+row]
    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Table(
        border: TableBorder.all(color: scheme.outlineVariant, width: 0.5),
        defaultColumnWidth: const FlexColumnWidth(),
        children: List<TableRow>.generate(4, (int row) {
          return TableRow(
            children: List<Widget>.generate(4, (int col) {
              final double val = s[col * 4 + row];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                child: Text(
                  val.toStringAsFixed(3),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: val.abs() > 0.001 && (val - 1.0).abs() > 0.001
                        ? scheme.primary
                        : scheme.onSurface,
                  ),
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Tab 3 — Rotation showcase
// ═══════════════════════════════════════════════════════════════════════════════

class _RotationTab extends StatelessWidget {
  const _RotationTab();

  @override
  Widget build(BuildContext context) {
    const List<(double, String)> angles = <(double, String)>[
      (0.0, '0° — identity'),
      (45.0, '45° — eighth turn'),
      (90.0, '90° — quarter turn'),
      (135.0, '135° — three-eighths'),
      (180.0, '180° — half turn'),
      (225.0, '225° — five-eighths'),
      (270.0, '270° — three-quarters'),
      (315.0, '315° — seven-eighths'),
    ];
    return _Section(
      title: 'Rotation Showcase',
      subtitle:
          'Eight cards frozen at fixed rotation angles via AlwaysStoppedAnimation. '
          'onTransform: (double v) => Matrix4.rotationZ(v * 2 * pi)',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _InfoCard(
            icon: Icons.rotate_right_outlined,
            title: 'How rotation works',
            body:
                'Matrix4.rotationZ(radians) produces a 2-D rotation matrix. The angle is in radians; '
                'multiply by 2π to map a 0→1 progress value onto a full revolution. '
                'The alignment property sets the pivot point (default: Alignment.center).',
          ),
          const SizedBox(height: 20),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.4,
            children: <Widget>[
              for (final (double deg, String label) in angles)
                _DemoFrame(
                  label: label,
                  child: MatrixTransition(
                    animation: AlwaysStoppedAnimation<double>(deg / 360.0),
                    onTransform: (double v) => Matrix4.rotationZ(v * 2 * math.pi),
                    child: const _SubjectCard(label: '★', width: 56, height: 40),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),
          Text('X and Y axis rotations', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                child: _DemoFrame(
                  label: 'rotationX 45°',
                  child: MatrixTransition(
                    animation: const AlwaysStoppedAnimation<double>(0.125),
                    onTransform: (double v) => Matrix4.rotationX(v * 2 * math.pi),
                    child: const _SubjectCard(label: 'Flip X', width: 80, height: 52),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _DemoFrame(
                  label: 'rotationY 45°',
                  child: MatrixTransition(
                    animation: const AlwaysStoppedAnimation<double>(0.125),
                    onTransform: (double v) => Matrix4.rotationY(v * 2 * math.pi),
                    child: const _SubjectCard(label: 'Flip Y', width: 80, height: 52),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const _InfoCard(
            icon: Icons.lightbulb_outline,
            title: 'Alignment as pivot',
            body:
                'By default the pivot is Alignment.center. Set alignment: Alignment.topLeft to rotate '
                'around the top-left corner, like a door hinge. This differs from wrapping a '
                'RotationTransition, which always rotates around the widget\'s center.',
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              Expanded(
                child: _DemoFrame(
                  label: 'pivot: center (default)',
                  child: MatrixTransition(
                    animation: const AlwaysStoppedAnimation<double>(0.083),
                    onTransform: (double v) => Matrix4.rotationZ(v * 2 * math.pi),
                    child: const _SubjectCard(label: 'Center', width: 72, height: 48),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _DemoFrame(
                  label: 'pivot: topLeft',
                  child: MatrixTransition(
                    animation: const AlwaysStoppedAnimation<double>(0.083),
                    onTransform: (double v) => Matrix4.rotationZ(v * 2 * math.pi),
                    alignment: Alignment.topLeft,
                    child: const _SubjectCard(label: 'TopLeft', width: 72, height: 48),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Tab 4 — Scale showcase
// ═══════════════════════════════════════════════════════════════════════════════

class _ScaleTab extends StatelessWidget {
  const _ScaleTab();

  @override
  Widget build(BuildContext context) {
    const List<(double, String)> uniformScales = <(double, String)>[
      (0.4, 'scale 0.4 — very small'),
      (0.7, 'scale 0.7 — reduced'),
      (1.0, 'scale 1.0 — identity'),
      (1.4, 'scale 1.4 — enlarged'),
      (1.7, 'scale 1.7 — large'),
      (2.0, 'scale 2.0 — double'),
    ];
    const List<(double, double, String)> nonUniform = <(double, double, String)>[
      (2.0, 0.5, 'scaleX×2, scaleY×0.5'),
      (0.5, 2.0, 'scaleX×0.5, scaleY×2'),
      (1.5, 0.8, 'scaleX×1.5, scaleY×0.8'),
      (0.8, 1.5, 'scaleX×0.8, scaleY×1.5'),
    ];
    return _Section(
      title: 'Scale Showcase',
      subtitle:
          'Uses Matrix4.diagonal3Values(sx, sy, 1) for uniform and non-uniform scaling. '
          'The third diagonal entry is 1 to preserve the Z axis.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _InfoCard(
            icon: Icons.zoom_in_outlined,
            title: 'Matrix4.diagonal3Values(sx, sy, 1)',
            body:
                'Creates a scale matrix. Uniform: pass the same value for sx and sy. '
                'Non-uniform: different values stretch or squash on each axis independently. '
                'Unlike ScaleTransition, you can scale X and Y independently in a single widget.',
          ),
          const SizedBox(height: 20),
          Text('Uniform scale', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.1,
            children: <Widget>[
              for (final (double s, String label) in uniformScales)
                _DemoFrame(
                  label: label,
                  height: 110,
                  child: MatrixTransition(
                    animation: AlwaysStoppedAnimation<double>(s),
                    onTransform: (double v) => Matrix4.diagonal3Values(v, v, 1),
                    child: const _SubjectCard(label: 'Scale', width: 54, height: 38),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),
          Text('Non-uniform scale (stretch)', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.4,
            children: <Widget>[
              for (final (double sx, double sy, String label) in nonUniform)
                _DemoFrame(
                  label: label,
                  child: MatrixTransition(
                    animation: const AlwaysStoppedAnimation<double>(1),
                    onTransform: (double _) => Matrix4.diagonal3Values(sx, sy, 1),
                    child: const _SubjectCard(label: 'Stretch', width: 60, height: 40),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),
          const _InfoCard(
            icon: Icons.compare_arrows_outlined,
            title: 'vs. ScaleTransition',
            body:
                'ScaleTransition only supports uniform scale via a single Animation<double>. '
                'MatrixTransition with diagonal3Values gives independent X/Y scale. '
                'You can also animate the scale in only one axis by holding the other constant.',
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Tab 5 — Skew showcase
// ═══════════════════════════════════════════════════════════════════════════════

class _SkewTab extends StatelessWidget {
  const _SkewTab();

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'Skew Showcase',
      subtitle:
          'Skew (shear) transforms slant the widget along an axis. '
          'Matrix4.skewX(a) shears horizontally; Matrix4.skewY(a) shears vertically. '
          'Combined and perspective variants shown below.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _InfoCard(
            icon: Icons.transform_outlined,
            title: 'What is a skew transform?',
            body:
                'A skew (shear) keeps one axis fixed and tilts the other. '
                'Matrix4.skewX(a) maps point (x,y) to (x + a*y, y). '
                'Matrix4.skewY(a) maps (x,y) to (x, y + a*x). '
                'Combined skew applies both simultaneously.',
          ),
          const SizedBox(height: 20),
          Row(
            children: <Widget>[
              Expanded(
                child: _DemoFrame(
                  label: 'skewX(0.3)\nhorizontal shear',
                  height: 150,
                  child: MatrixTransition(
                    animation: const AlwaysStoppedAnimation<double>(0.3),
                    onTransform: (double v) => Matrix4.skewX(v),
                    child: const _SubjectCard(label: 'SkewX', width: 70, height: 48),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _DemoFrame(
                  label: 'skewY(0.3)\nvertical shear',
                  height: 150,
                  child: MatrixTransition(
                    animation: const AlwaysStoppedAnimation<double>(0.3),
                    onTransform: (double v) => Matrix4.skewY(v),
                    child: const _SubjectCard(label: 'SkewY', width: 70, height: 48),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                child: _DemoFrame(
                  label: 'skewX(0.3) + skewY(0.2)\ncombined shear',
                  height: 150,
                  child: MatrixTransition(
                    animation: const AlwaysStoppedAnimation<double>(1),
                    onTransform: (double _) {
                      final Matrix4 m = Matrix4.skewX(0.3);
                      m.multiply(Matrix4.skewY(0.2));
                      return m;
                    },
                    child: const _SubjectCard(label: 'Combined', width: 70, height: 48),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _DemoFrame(
                  label: 'perspective(0.002)\nvanishing-point depth',
                  height: 150,
                  child: MatrixTransition(
                    animation: const AlwaysStoppedAnimation<double>(1),
                    onTransform: (double _) {
                      final Matrix4 m = Matrix4.identity();
                      m.setEntry(3, 2, 0.002);
                      return m;
                    },
                    child: const _SubjectCard(label: 'Persp', width: 70, height: 48),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('Varying skewX angles', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.4,
            children: <Widget>[
              for (final (double angle, String label) in <(double, String)>[
                (-0.5, 'skewX(−0.5)'),
                (-0.25, 'skewX(−0.25)'),
                (0.25, 'skewX(0.25)'),
                (0.5, 'skewX(0.5)'),
              ])
                _DemoFrame(
                  label: label,
                  child: MatrixTransition(
                    animation: AlwaysStoppedAnimation<double>(angle),
                    onTransform: (double v) => Matrix4.skewX(v),
                    child: const _SubjectCard(label: 'Card', width: 64, height: 44),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          const _InfoCard(
            icon: Icons.lightbulb_outline,
            title: 'Matrix entry spotlight: skewX',
            body:
                'skewX(a) sets entry [0,1] = a (row 0, col 1 in row-major notation, '
                'or storage index 4 in Flutter\'s column-major Float64List). '
                'All other off-diagonal entries remain 0.',
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Tab 6 — Flip demo
// ═══════════════════════════════════════════════════════════════════════════════

class _FlipTab extends StatelessWidget {
  const _FlipTab();

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'Flip Demo',
      subtitle:
          'Flipping is a special case of scale: negate one axis. '
          'scaleY=−1 flips on the X axis (mirrors top↔bottom). '
          'scaleX=−1 flips on the Y axis (mirrors left↔right).',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _InfoCard(
            icon: Icons.flip_outlined,
            title: 'Flip via diagonal3Values',
            body:
                'Flip on X axis: Matrix4.diagonal3Values(1, -1, 1).\n'
                'Flip on Y axis: Matrix4.diagonal3Values(-1, 1, 1).\n'
                'Diagonal flip: Matrix4.diagonal3Values(-1, -1, 1) — equivalent to 180° rotation.',
          ),
          const SizedBox(height: 20),
          Row(
            children: <Widget>[
              Expanded(
                child: _DemoFrame(
                  label: 'Original',
                  height: 160,
                  child: const _AsymCard(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _DemoFrame(
                  label: 'Flip on X axis\n(scaleY = −1)',
                  height: 160,
                  child: MatrixTransition(
                    animation: const AlwaysStoppedAnimation<double>(1),
                    onTransform: (double _) => Matrix4.diagonal3Values(1, -1, 1),
                    child: const _AsymCard(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                child: _DemoFrame(
                  label: 'Flip on Y axis\n(scaleX = −1)',
                  height: 160,
                  child: MatrixTransition(
                    animation: const AlwaysStoppedAnimation<double>(1),
                    onTransform: (double _) => Matrix4.diagonal3Values(-1, 1, 1),
                    child: const _AsymCard(),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _DemoFrame(
                  label: 'Diagonal flip\n(scaleX=−1, scaleY=−1)',
                  height: 160,
                  child: MatrixTransition(
                    animation: const AlwaysStoppedAnimation<double>(1),
                    onTransform: (double _) => Matrix4.diagonal3Values(-1, -1, 1),
                    child: const _AsymCard(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('Partial flip (0 → 180° on Y axis)', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          const _InfoCard(
            icon: Icons.info_outline,
            title: 'Animating a card flip',
            body:
                'Drive a continuous 0→1 value and use Matrix4.rotationY(t * pi) to get a '
                'smooth 180° flip on the Y axis. At t=0.5 the card is edge-on (invisible). '
                'Often you swap child content at t=0.5 to simulate front/back faces.',
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              for (final (double t, String label) in <(double, String)>[
                (0.0, '0° front'),
                (0.25, '45° tilted'),
                (0.5, '90° edge-on'),
                (0.75, '135° back-tilt'),
                (1.0, '180° back'),
              ])
                Column(
                  children: <Widget>[
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Center(
                        child: MatrixTransition(
                          animation: AlwaysStoppedAnimation<double>(t),
                          onTransform: (double v) => Matrix4.rotationY(v * math.pi),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.tertiaryContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                '▶',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(label, style: const TextStyle(fontSize: 10), textAlign: TextAlign.center),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// An asymmetric card to make flips visually obvious.
class _AsymCard extends StatelessWidget {
  const _AsymCard();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      width: 90,
      height: 60,
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: scheme.primary, width: 2),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 6,
            left: 8,
            child: Icon(Icons.star, size: 14, color: scheme.primary),
          ),
          Center(
            child: Text(
              'Flip',
              style: TextStyle(fontWeight: FontWeight.w700, color: scheme.onPrimaryContainer),
            ),
          ),
          Positioned(
            bottom: 4,
            right: 6,
            child: Text(
              '→',
              style: TextStyle(fontSize: 10, color: scheme.primary),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Tab 7 — Compound transform
// ═══════════════════════════════════════════════════════════════════════════════

class _CompoundTab extends StatelessWidget {
  const _CompoundTab();

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'Compound Transform',
      subtitle:
          'Rotate + scale + translate driven simultaneously by a single slider value t (0→1). '
          'All three transforms are composed by matrix multiplication.',
      child: ValueListenableBuilder<double>(
        valueListenable: _compoundT,
        builder: (BuildContext ctx, double t, Widget? _) {
          // Compose: translate → scale → rotate
          final Matrix4 rotate = Matrix4.rotationZ(t * 2 * math.pi);
          final double scale = 0.6 + t * 0.8; // 0.6 → 1.4
          final Matrix4 scaleM = Matrix4.diagonal3Values(scale, scale, 1);
          final Matrix4 translateM = Matrix4.identity()
            ..setTranslationRaw(t * 30 - 15, t * 20 - 10, 0);
          final Matrix4 compound = translateM * scaleM * rotate;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _InfoCard(
                icon: Icons.blur_on_outlined,
                title: 'Composing transforms via matrix multiplication',
                body:
                    'Matrix multiplication is the standard way to combine affine transforms. '
                    'The order matters: rotate then scale is NOT the same as scale then rotate. '
                    'MatrixTransition passes the double animation value to onTransform, '
                    'which can build any Matrix4 — including composed ones.',
              ),
              const SizedBox(height: 20),
              // Stage
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(ctx).colorScheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Theme.of(ctx).colorScheme.outlineVariant),
                ),
                child: Center(
                  child: MatrixTransition(
                    animation: AlwaysStoppedAnimation<double>(t),
                    onTransform: (double v) {
                      final Matrix4 r = Matrix4.rotationZ(v * 2 * math.pi);
                      final double s = 0.6 + v * 0.8;
                      final Matrix4 sc = Matrix4.diagonal3Values(s, s, 1);
                      final Matrix4 tr = Matrix4.identity()
                        ..setTranslationRaw(v * 30 - 15, v * 20 - 10, 0);
                      return tr * sc * r;
                    },
                    child: const _SubjectCard(label: 'Compound', width: 80, height: 56),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Text('t = ${t.toStringAsFixed(3)}', style: const TextStyle(fontFamily: 'monospace')),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Slider(
                      value: t,
                      onChanged: (double v) => _compoundT.value = v,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Breakdown
              _CompoundBreakdown(t: t),
              const SizedBox(height: 20),
              Text('Resulting compound matrix', style: Theme.of(ctx).textTheme.titleSmall),
              const SizedBox(height: 8),
              _Matrix4Grid(matrix: compound),
            ],
          );
        },
      ),
    );
  }
}

class _CompoundBreakdown extends StatelessWidget {
  const _CompoundBreakdown({required this.t});
  final double t;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final double degrees = t * 360;
    final double scale = 0.6 + t * 0.8;
    final double tx = t * 30 - 15;
    final double ty = t * 20 - 10;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Transform breakdown (t=${t.toStringAsFixed(3)})',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 10),
          _BreakdownRow(
            label: 'Rotation',
            value: '${degrees.toStringAsFixed(1)}°',
            icon: Icons.rotate_right_outlined,
          ),
          _BreakdownRow(
            label: 'Uniform scale',
            value: scale.toStringAsFixed(3),
            icon: Icons.zoom_in_outlined,
          ),
          _BreakdownRow(
            label: 'Translate X',
            value: '${tx.toStringAsFixed(1)} px',
            icon: Icons.swap_horiz_outlined,
          ),
          _BreakdownRow(
            label: 'Translate Y',
            value: '${ty.toStringAsFixed(1)} px',
            icon: Icons.swap_vert_outlined,
          ),
        ],
      ),
    );
  }
}

class _BreakdownRow extends StatelessWidget {
  const _BreakdownRow({required this.label, required this.value, required this.icon});
  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 16, color: scheme.primary),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 13)),
          const Spacer(),
          Text(value, style: const TextStyle(fontFamily: 'monospace', fontSize: 13)),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Tab 8 — Curves showcase
// ═══════════════════════════════════════════════════════════════════════════════

class _CurvesTab extends StatelessWidget {
  const _CurvesTab();

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'Curves Showcase',
      subtitle:
          'The same MatrixTransition (rotation 0→360°) driven by TweenAnimationBuilder with 6 '
          'different Curve values. Each box completes a 4-second animation and restarts. '
          'Select a curve to highlight.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _InfoCard(
            icon: Icons.show_chart_outlined,
            title: 'How curves affect MatrixTransition',
            body:
                'TweenAnimationBuilder outputs a 0→1 double. Applying a curve inside the tween '
                'changes the rate of change. MatrixTransition receives the curved value via '
                'onTransform(v) and applies the corresponding Matrix4, producing eased, bouncy, '
                'or elastic motion.',
          ),
          const SizedBox(height: 20),
          ValueListenableBuilder<int>(
            valueListenable: _curveIndex,
            builder: (BuildContext ctx, int selected, Widget? _) {
              return Column(
                children: <Widget>[
                  // Curve selector chips
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: <Widget>[
                      for (int i = 0; i < _curveNames.length; i++)
                        GestureDetector(
                          onTap: () => _curveIndex.value = i,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: i == selected
                                  ? Theme.of(ctx).colorScheme.primary
                                  : Theme.of(ctx).colorScheme.surfaceContainerHigh,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Theme.of(ctx).colorScheme.outlineVariant),
                            ),
                            child: Text(
                              _curveNames[i],
                              style: TextStyle(
                                fontSize: 12,
                                color: i == selected
                                    ? Theme.of(ctx).colorScheme.onPrimary
                                    : Theme.of(ctx).colorScheme.onSurface,
                                fontWeight: i == selected ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // 2×3 grid of curve demos
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.0,
                    children: <Widget>[
                      for (int i = 0; i < _curves.length; i++)
                        _CurveCard(
                          curveName: _curveNames[i],
                          curve: _curves[i],
                          highlighted: i == selected,
                        ),
                    ],
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          const _InfoCard(
            icon: Icons.lightbulb_outline,
            title: 'Tip: Apply a curve inside onTransform',
            body:
                'You can curve the output inside onTransform itself:\n'
                '  onTransform: (double v) {\n'
                '    final curved = Curves.easeInOut.transform(v);\n'
                '    return Matrix4.rotationZ(curved * 2 * pi);\n'
                '  }\n'
                'This keeps the curve logic inside the builder instead of wrapping the animation.',
          ),
        ],
      ),
    );
  }
}

class _CurveCard extends StatelessWidget {
  const _CurveCard({
    required this.curveName,
    required this.curve,
    required this.highlighted,
  });
  final String curveName;
  final Curve curve;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: highlighted ? scheme.primaryContainer : scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: highlighted ? scheme.primary : scheme.outlineVariant,
          width: highlighted ? 2 : 1,
        ),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(seconds: 4),
                curve: curve,
                builder: (BuildContext ctx, double t, Widget? child) {
                  return MatrixTransition(
                    animation: AlwaysStoppedAnimation<double>(t),
                    onTransform: (double v) => Matrix4.rotationZ(v * 2 * math.pi),
                    child: child,
                  );
                },
                child: Container(
                  width: 36,
                  height: 26,
                  decoration: BoxDecoration(
                    color: highlighted ? scheme.primary : scheme.primaryContainer,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              curveName,
              style: TextStyle(
                fontSize: 10,
                fontWeight: highlighted ? FontWeight.w700 : FontWeight.normal,
                color: highlighted ? scheme.primary : scheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Tab 9 — Diagram (CustomPainter)
// ═══════════════════════════════════════════════════════════════════════════════

class _DiagramTab extends StatelessWidget {
  const _DiagramTab();

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'Matrix4 Structure Diagram',
      subtitle:
          'A 4×4 matrix visualisation. Tap a category to highlight which cells are affected '
          'by each transform type. Flutter stores Matrix4 in column-major order.',
      child: ValueListenableBuilder<int>(
        valueListenable: _diagramCategory,
        builder: (BuildContext ctx, int cat, Widget? _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Category selector
              Row(
                children: <Widget>[
                  for (int i = 0; i < _diagramCategories.length; i++)
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _diagramCategory.value = i,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: i == cat
                                ? Theme.of(ctx).colorScheme.primary
                                : Theme.of(ctx).colorScheme.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            _diagramCategories[i],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11,
                              color: i == cat
                                  ? Theme.of(ctx).colorScheme.onPrimary
                                  : Theme.of(ctx).colorScheme.onSurface,
                              fontWeight: i == cat ? FontWeight.w700 : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              // Custom painter diagram
              SizedBox(
                height: 300,
                width: double.infinity,
                child: CustomPaint(
                  painter: _MatrixDiagramPainter(
                    category: cat,
                    scheme: Theme.of(ctx).colorScheme,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Legend
              _DiagramLegend(category: cat),
              const SizedBox(height: 20),
              const _InfoCard(
                icon: Icons.info_outline,
                title: 'Column-major storage',
                body:
                    'Flutter\'s Matrix4 stores values column by column. Index 0 is column 0 row 0, '
                    'index 1 is column 0 row 1, etc. So storage[12], [13], [14] are the translation '
                    'components (column 3, rows 0-2) and storage[15] is the homogeneous W entry.',
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DiagramLegend extends StatelessWidget {
  const _DiagramLegend({required this.category});
  final int category;

  static const List<String> _descriptions = <String>[
    'Rotation: cells (0,0), (0,1), (1,0), (1,1) — the 2D rotation sub-matrix. '
        'For rotationZ(θ): [cos θ, sin θ, 0, 0 / -sin θ, cos θ, 0, 0 / 0, 0, 1, 0 / 0, 0, 0, 1].',
    'Scale: diagonal cells (0,0), (1,1), (2,2). '
        'diagonal3Values(sx, sy, sz) writes sx→(0,0), sy→(1,1), sz→(2,2). '
        'The homogeneous (3,3) entry stays 1.',
    'Translation: column 3, rows 0-2: storage indices 12, 13, 14. '
        'setTranslationRaw(tx, ty, tz) writes directly to these positions. '
        'These add a pixel offset after all other transforms.',
    'Perspective: row 3, columns 0-2 (storage 3, 7, 11). '
        'setEntry(3, 2, p) sets storage[11] = p, creating a vanishing-point depth effect. '
        'Non-zero values here make parallel lines converge.',
  ];

  @override
  Widget build(BuildContext context) {
    return _InfoCard(
      icon: Icons.grid_3x3_outlined,
      title: _diagramCategories[category],
      body: _descriptions[category],
    );
  }
}

/// Paints a 4×4 Matrix4 cell grid highlighting relevant cells per category.
class _MatrixDiagramPainter extends CustomPainter {
  const _MatrixDiagramPainter({required this.category, required this.scheme});
  final int category;
  final ColorScheme scheme;

  // Returns true if cell (row, col) is highlighted for the given category.
  bool _highlighted(int row, int col) {
    switch (category) {
      case 0: // Rotation: top-left 2×2
        return row < 2 && col < 2;
      case 1: // Scale: diagonal
        return row == col && row < 3;
      case 2: // Translation: col 3, rows 0-2
        return col == 3 && row < 3;
      case 3: // Perspective: row 3, cols 0-2
        return row == 3 && col < 3;
      default:
        return false;
    }
  }

  // Column-major label for position (row, col)
  String _label(int row, int col) {
    const List<List<String>> labels = <List<String>>[
      <String>['m00', 'm10', 'm20', 'm30'],
      <String>['m01', 'm11', 'm21', 'm31'],
      <String>['m02', 'm12', 'm22', 'm32'],
      <String>['m03', 'm13', 'm23', 'm33'],
    ];
    return labels[col][row];
  }

  @override
  void paint(Canvas canvas, Size size) {
    const int gridSize = 4;
    final double cellW = size.width / gridSize;
    final double cellH = size.height / gridSize;

    final Paint bgPaint = Paint()..color = scheme.surfaceContainerLow;
    final Paint highlightPaint = Paint()..color = scheme.primaryContainer;
    final Paint borderPaint = Paint()
      ..color = scheme.outlineVariant
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    final Paint highlightBorderPaint = Paint()
      ..color = scheme.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (int row = 0; row < gridSize; row++) {
      for (int col = 0; col < gridSize; col++) {
        final Rect rect = Rect.fromLTWH(col * cellW, row * cellH, cellW, cellH);
        final RRect rRect = RRect.fromRectAndRadius(rect.deflate(2), const Radius.circular(6));
        final bool hi = _highlighted(row, col);

        canvas.drawRRect(rRect, hi ? highlightPaint : bgPaint);
        canvas.drawRRect(rRect, hi ? highlightBorderPaint : borderPaint);

        // Cell label
        final TextPainter labelPainter = TextPainter(
          text: TextSpan(
            text: _label(row, col),
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: hi ? scheme.primary : scheme.onSurfaceVariant,
              fontWeight: hi ? FontWeight.w700 : FontWeight.normal,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        labelPainter.paint(
          canvas,
          Offset(
            col * cellW + (cellW - labelPainter.width) / 2,
            row * cellH + cellH * 0.28,
          ),
        );

        // Storage index
        final int storageIndex = col * 4 + row;
        final TextPainter indexPainter = TextPainter(
          text: TextSpan(
            text: '[$storageIndex]',
            style: TextStyle(
              fontSize: 9,
              color: hi ? scheme.primary : scheme.outline,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        indexPainter.paint(
          canvas,
          Offset(
            col * cellW + (cellW - indexPainter.width) / 2,
            row * cellH + cellH * 0.62,
          ),
        );
      }
    }
  }

  @override
  bool shouldRepaint(_MatrixDiagramPainter old) => old.category != category;
}

// ═══════════════════════════════════════════════════════════════════════════════
// Tab 10 — Comparison table
// ═══════════════════════════════════════════════════════════════════════════════

class _CompareTab extends StatelessWidget {
  const _CompareTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    const List<List<String>> rows = <List<String>>[
      <String>['Widget', 'Transform type', 'Animation', 'Axes', 'Skew', 'Perspective', 'Compose'],
      <String>['MatrixTransition', 'Any Matrix4', 'Animation<double>', 'X/Y/Z', '✓', '✓', '✓'],
      <String>['RotationTransition', 'rotationZ only', 'Animation<double>', 'Z only', '✗', '✗', '✗'],
      <String>['ScaleTransition', 'uniform scale', 'Animation<double>', 'uniform', '✗', '✗', '✗'],
      <String>['SlideTransition', 'translation', 'Animation<Offset>', 'X/Y', '✗', '✗', '✗'],
      <String>['Transform (static)', 'Any Matrix4', 'none (static)', 'X/Y/Z', '✓', '✓', '✓'],
      <String>['AnimatedContainer', 'layout only', 'implicit', 'layout', '✗', '✗', '✗'],
    ];

    return _Section(
      title: 'Widget Comparison',
      subtitle:
          'MatrixTransition vs. the standard transition widgets. '
          'Use the right tool: MatrixTransition is the most powerful but requires you '
          'to supply the full Matrix4 mapping.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(scheme.primaryContainer),
              dataRowColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) return scheme.secondaryContainer;
                return null;
              }),
              columnSpacing: 20,
              columns: <DataColumn>[
                for (final String header in rows[0])
                  DataColumn(
                    label: Text(
                      header,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: scheme.onPrimaryContainer,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
              rows: <DataRow>[
                for (int i = 1; i < rows.length; i++)
                  DataRow(
                    selected: i == 1, // highlight MatrixTransition row
                    cells: <DataCell>[
                      for (final String cell in rows[i])
                        DataCell(Text(
                          cell,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: i == 1 ? 'monospace' : null,
                            fontWeight: i == 1 ? FontWeight.w600 : FontWeight.normal,
                          ),
                        )),
                    ],
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const _InfoCard(
            icon: Icons.help_outline,
            title: 'When to choose MatrixTransition',
            body:
                '• You need rotation on X or Y axes (card flip, 3D tilt)\n'
                '• You need skew or shear effects\n'
                '• You need to combine multiple transforms in one pass\n'
                '• You need perspective projection\n'
                '• You are driving the animation with an explicit AnimationController',
          ),
          const SizedBox(height: 16),
          const _InfoCard(
            icon: Icons.lightbulb_outline,
            title: 'When to prefer RotationTransition / ScaleTransition',
            body:
                '• You only need simple 2D rotation (Z axis) or uniform scale\n'
                '• You want a simpler API with less boilerplate\n'
                '• Performance is critical and you want the framework to optimise the common case\n'
                '• You are composing via a widget tree (multiple wrappers) rather than one matrix',
          ),
          const SizedBox(height: 24),
          // Side-by-side live demo
          Text('Side-by-side live comparison', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                child: _DemoFrame(
                  label: 'MatrixTransition\nrotationZ(45°)',
                  height: 160,
                  child: MatrixTransition(
                    animation: const AlwaysStoppedAnimation<double>(0.125),
                    onTransform: (double v) => Matrix4.rotationZ(v * 2 * math.pi),
                    child: const _SubjectCard(label: 'Matrix\nTrans.', width: 70, height: 48),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _DemoFrame(
                  label: 'RotationTransition\n(turns: 0.125)',
                  height: 160,
                  child: RotationTransition(
                    turns: const AlwaysStoppedAnimation<double>(0.125),
                    child: const _SubjectCard(label: 'Rotation\nTrans.', width: 70, height: 48),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _DemoFrame(
                  label: 'Transform\n(static, same angle)',
                  height: 160,
                  child: Transform(
                    transform: Matrix4.rotationZ(0.125 * 2 * math.pi),
                    alignment: Alignment.center,
                    child: const _SubjectCard(label: 'Transform\n(static)', width: 70, height: 48),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Tab 11 — API cheat sheet
// ═══════════════════════════════════════════════════════════════════════════════

class _ApiTab extends StatelessWidget {
  const _ApiTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return _Section(
      title: 'API Cheat Sheet',
      subtitle:
          'Quick reference for MatrixTransition constructor, types, and common Matrix4 factory methods.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Constructor
          Text('Constructor', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          _ApiRow(
            param: 'animation',
            type: 'Animation<double>',
            note:
                'Required. Drives the widget (0→1). Typically a CurvedAnimation wrapping an '
                'AnimationController, or AlwaysStoppedAnimation<double>(t) for stateless use.',
          ),
          _ApiRow(
            param: 'onTransform',
            type: 'TransformCallback',
            note:
                'Required. Alias: Matrix4 Function(double animationValue). Called on each frame '
                'with the raw double value from the animation. Must return the Matrix4 to apply.',
          ),
          _ApiRow(
            param: 'alignment',
            type: 'Alignment',
            note:
                'Pivot point for the transform. Default: Alignment.center. '
                'Alignment.topLeft gives a door-hinge effect.',
          ),
          _ApiRow(
            param: 'filterQuality',
            type: 'FilterQuality?',
            note:
                'Rendering quality for the transform. null (default) = nearest-neighbour. '
                'FilterQuality.low / .medium / .high improve smoothness at a rendering cost. '
                'Only active while the animation is running.',
          ),
          _ApiRow(
            param: 'child',
            type: 'Widget?',
            note:
                'The widget to transform. Supplied last as is idiomatic in Flutter. '
                'Passed through AnimatedWidget\'s listenable rebuild chain.',
          ),
          const SizedBox(height: 24),
          // TransformCallback type
          Text('TransformCallback type alias', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'typedef TransformCallback = Matrix4 Function(\n'
              '  double animationValue,\n'
              ');\n\n'
              '// animationValue is the raw double from the animation (0.0→1.0).\n'
              '// You are responsible for converting it to a Matrix4.\n'
              '// Example:\n'
              '//   onTransform: (v) => Matrix4.rotationZ(v * 2 * pi)',
              style: TextStyle(fontFamily: 'monospace', fontSize: 12, height: 1.6),
            ),
          ),
          const SizedBox(height: 24),
          // Common Matrix4 factories
          Text('Common Matrix4 factory methods', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          const _FactoryRow('Matrix4.identity()', 'Identity — no transform'),
          const _FactoryRow('Matrix4.rotationZ(radians)', 'Rotate around Z axis (screen normal)'),
          const _FactoryRow('Matrix4.rotationX(radians)', 'Rotate around X axis (horizontal flip depth)'),
          const _FactoryRow('Matrix4.rotationY(radians)', 'Rotate around Y axis (vertical flip depth)'),
          const _FactoryRow('Matrix4.diagonal3Values(sx, sy, sz)', 'Non-uniform scale on each axis'),
          const _FactoryRow('Matrix4.skewX(angle)', 'Horizontal shear'),
          const _FactoryRow('Matrix4.skewY(angle)', 'Vertical shear'),
          const _FactoryRow('Matrix4.translationValues(tx, ty, tz)', 'Pixel translation'),
          const _FactoryRow('m.multiply(other)', 'Compose (multiply) two transforms'),
          const _FactoryRow('m.setEntry(row, col, val)', 'Set an individual cell (e.g. perspective)'),
          const _FactoryRow('m.setTranslationRaw(tx, ty, tz)', 'Set translation in-place'),
          const SizedBox(height: 24),
          // Driving strategies
          Text('Driving strategies (stateless)', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              '// Strategy A: TweenAnimationBuilder (auto-plays)\n'
              'TweenAnimationBuilder<double>(\n'
              '  tween: Tween<double>(begin: 0, end: 1),\n'
              '  duration: const Duration(seconds: 2),\n'
              '  curve: Curves.easeInOut,\n'
              '  builder: (ctx, t, child) => MatrixTransition(\n'
              '    animation: AlwaysStoppedAnimation<double>(t),\n'
              '    onTransform: (double v) =>\n'
              '        Matrix4.rotationZ(v * 2 * pi),\n'
              '    child: child,\n'
              '  ),\n'
              '  child: myWidget,\n'
              ');\n\n'
              '// Strategy B: ValueNotifier slider\n'
              'final _t = ValueNotifier<double>(0.0);\n'
              '// ...\n'
              'ValueListenableBuilder<double>(\n'
              '  valueListenable: _t,\n'
              '  builder: (ctx, t, _) => MatrixTransition(\n'
              '    animation: AlwaysStoppedAnimation<double>(t),\n'
              '    onTransform: (double v) =>\n'
              '        Matrix4.rotationZ(v * 2 * pi),\n'
              '    child: myWidget,\n'
              '  ),\n'
              ');\n\n'
              '// Strategy C: AnimationController (StatefulWidget)\n'
              '// Pass the controller directly as animation.\n'
              '// onTransform receives controller.value each frame.',
              style: TextStyle(fontFamily: 'monospace', fontSize: 11.5, height: 1.7),
            ),
          ),
          const SizedBox(height: 24),
          const _InfoCard(
            icon: Icons.warning_amber_outlined,
            title: 'onTransform receives a plain double, not Animation<double>',
            body:
                'The animation constructor parameter is Animation<double>. '
                'However, onTransform is a TransformCallback = Matrix4 Function(double). '
                'MatrixTransition calls it with animation.value on every rebuild. '
                'You do NOT get the animation object inside onTransform.',
          ),
          const SizedBox(height: 16),
          const _InfoCard(
            icon: Icons.accessibility_new_outlined,
            title: 'filterQuality and performance',
            body:
                'For large transforms (high rotation or scale) or text children, '
                'set filterQuality: FilterQuality.medium or .high to enable anti-aliasing. '
                'For simple icon/colour children at moderate scales, null is fine and faster.',
          ),
        ],
      ),
    );
  }
}

class _ApiRow extends StatelessWidget {
  const _ApiRow({required this.param, required this.type, required this.note});
  final String param;
  final String type;
  final String note;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _CodeChip(param),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  type,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'monospace',
                    color: scheme.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            note,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _FactoryRow extends StatelessWidget {
  const _FactoryRow(this.signature, this.description);
  final String signature;
  final String description;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Text(
              signature,
              style: TextStyle(fontFamily: 'monospace', fontSize: 12, color: scheme.primary),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 4,
            child: Text(
              description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ),
        ],
      ),
    );
  }
}
