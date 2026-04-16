// Deep visual demo: FractionalTranslation - translate a child by a fraction
// of its own size instead of a pixel distance. Authored manually.
// STATELESS ONLY. Top-level ValueNotifiers drive interactivity without any
// StatefulWidget in this file.

import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// Top-level state. Read by the stateless widget tree below.
// ═══════════════════════════════════════════════════════════════════════════

final ValueNotifier<double> _playgroundX = ValueNotifier<double>(0.25);
final ValueNotifier<double> _playgroundY = ValueNotifier<double>(-0.15);
final ValueNotifier<bool> _playgroundShowRuler = ValueNotifier<bool>(true);
final ValueNotifier<bool> _playgroundShowBounds = ValueNotifier<bool>(true);

final ValueNotifier<int> _anchorIndex = ValueNotifier<int>(4);

final ValueNotifier<int> _hitTestTrueTaps = ValueNotifier<int>(0);
final ValueNotifier<int> _hitTestFalseTaps = ValueNotifier<int>(0);

final ValueNotifier<bool> _peekActive = ValueNotifier<bool>(false);

final ValueNotifier<int> _shakeEpoch = ValueNotifier<int>(0);
final ValueNotifier<double> _shakeAmplitude = ValueNotifier<double>(0.15);

final ValueNotifier<int> _badgeCount = ValueNotifier<int>(3);

final ValueNotifier<int> _comparisonMode = ValueNotifier<int>(0);

// ═══════════════════════════════════════════════════════════════════════════
// Entry point
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) => const _DemoApp();

class _DemoApp extends StatelessWidget {
  const _DemoApp();
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D8F));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.w700),
          titleMedium: TextStyle(fontWeight: FontWeight.w600),
          bodyMedium: TextStyle(height: 1.35),
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
      length: 9,
      child: Scaffold(
        backgroundColor: scheme.surface,
        appBar: AppBar(
          title: const Text('FractionalTranslation - Deep Visual Demo'),
          backgroundColor: scheme.primaryContainer,
          foregroundColor: scheme.onPrimaryContainer,
          bottom: const TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: <Tab>[
              Tab(icon: Icon(Icons.rocket_launch_outlined), text: 'Hero'),
              Tab(icon: Icon(Icons.tune), text: 'Playground'),
              Tab(icon: Icon(Icons.grid_3x3), text: 'Anchors'),
              Tab(icon: Icon(Icons.touch_app_outlined), text: 'Hit Tests'),
              Tab(icon: Icon(Icons.layers_outlined), text: 'Peek'),
              Tab(icon: Icon(Icons.vibration), text: 'Shake'),
              Tab(icon: Icon(Icons.notifications_active_outlined), text: 'Badge'),
              Tab(icon: Icon(Icons.compare_arrows), text: 'Compare'),
              Tab(icon: Icon(Icons.menu_book_outlined), text: 'API'),
            ],
          ),
        ),
        body: const TabBarView(children: <Widget>[
          _HeroTab(),
          _PlaygroundTab(),
          _AnchorsTab(),
          _HitTestsTab(),
          _PeekTab(),
          _ShakeTab(),
          _BadgeTab(),
          _CompareTab(),
          _ApiTab(),
        ]),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Shared helpers
// ═══════════════════════════════════════════════════════════════════════════

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.subtitle, required this.child});
  final String title;
  final String subtitle;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text(subtitle, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant)),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}

class _Explainer extends StatelessWidget {
  const _Explainer({required this.icon, required this.title, required this.body});
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
                Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: scheme.onSecondaryContainer)),
                const SizedBox(height: 4),
                Text(body, style: TextStyle(color: scheme.onSecondaryContainer, height: 1.35)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChipLine extends StatelessWidget {
  const _ChipLine({required this.entries});
  final List<(IconData, String)> entries;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: <Widget>[
        for (final (IconData icon, String label) in entries)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: scheme.surfaceContainer,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: scheme.outlineVariant),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(icon, size: 16, color: scheme.primary),
                const SizedBox(width: 6),
                Text(label, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
      ],
    );
  }
}

class _BoundedStage extends StatelessWidget {
  const _BoundedStage({required this.width, required this.height, required this.child});
  final double width;
  final double height;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outlineVariant, width: 1.2),
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text, required this.accent});
  final String text;
  final Color accent;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: accent.withAlpha(40), borderRadius: BorderRadius.circular(999), border: Border.all(color: accent.withAlpha(120))),
      child: Text(text, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: accent)),
    );
  }
}

class _KeyValue extends StatelessWidget {
  const _KeyValue({required this.k, required this.v, this.mono = false});
  final String k;
  final String v;
  final bool mono;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 120,
            child: Text(k, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
          ),
          Expanded(
            child: Text(
              v,
              style: TextStyle(
                fontFamily: mono ? 'monospace' : null,
                fontSize: 12.5,
                color: scheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DemoCard extends StatelessWidget {
  const _DemoCard({required this.title, this.subtitle, required this.child, this.accent});
  final String title;
  final String? subtitle;
  final Widget child;
  final Color? accent;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Color a = accent ?? scheme.primary;
    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outlineVariant),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 6, offset: const Offset(0, 3)),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(width: 6, height: 22, decoration: BoxDecoration(color: a, borderRadius: BorderRadius.circular(3))),
              const SizedBox(width: 10),
              Expanded(child: Text(title, style: Theme.of(context).textTheme.titleMedium)),
            ],
          ),
          if (subtitle != null) ...<Widget>[
            const SizedBox(height: 4),
            Text(subtitle!, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
          ],
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 1 - Hero
// ═══════════════════════════════════════════════════════════════════════════

class _HeroTab extends StatelessWidget {
  const _HeroTab();
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return _Section(
      title: 'Meet FractionalTranslation',
      subtitle: 'A widget that translates its child by an Offset expressed as a fraction of the child size, not a pixel distance.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[scheme.primary, scheme.tertiary],
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(color: scheme.primary.withAlpha(60), blurRadius: 22, offset: const Offset(0, 12)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: scheme.onPrimary.withAlpha(40), borderRadius: BorderRadius.circular(14)),
                      child: Icon(Icons.open_with, color: scheme.onPrimary, size: 36),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('FractionalTranslation',
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: scheme.onPrimary, fontWeight: FontWeight.w800)),
                          const SizedBox(height: 4),
                          Text('Self-relative movement. No pixels needed.',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: scheme.onPrimary.withAlpha(220))),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  'Give it an Offset like Offset(0.5, 0.25) and the child slides by 50% of its own width plus 25% of its own height. No MediaQuery, no LayoutBuilder, no hard-coded numbers. The pixels are computed from the child\'s rendered size.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: scheme.onPrimary.withAlpha(235), height: 1.45),
                ),
                const SizedBox(height: 18),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: <Widget>[
                    _Pill(text: 'fraction of SELF size', accent: scheme.onPrimary),
                    _Pill(text: 'no pixel math', accent: scheme.onPrimary),
                    _Pill(text: 'hit-test aware', accent: scheme.onPrimary),
                    _Pill(text: 'stateless', accent: scheme.onPrimary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Text('Quick preview', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _HeroSample(
                  label: 'Offset.zero',
                  translation: Offset.zero,
                  accent: scheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _HeroSample(
                  label: 'Offset(0.5, 0)',
                  translation: const Offset(0.5, 0),
                  accent: scheme.secondary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _HeroSample(
                  label: 'Offset(-0.25, -0.5)',
                  translation: const Offset(-0.25, -0.5),
                  accent: scheme.tertiary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const _Explainer(
            icon: Icons.lightbulb_outline,
            title: 'Mental model',
            body: 'Transform.translate moves by pixels you compute yourself. FractionalTranslation moves by a multiple of the child\'s own size. It is the positional sibling of FractionallySizedBox.',
          ),
          const SizedBox(height: 12),
          const _Explainer(
            icon: Icons.science_outlined,
            title: 'When you want it',
            body: 'Tooltip anchors, badge overlays, peek/hover micro-interactions, shake animations, off-screen staging of cards, and anywhere you want layout to remain sized by the parent while the paint position slides around.',
          ),
          const SizedBox(height: 12),
          const _Explainer(
            icon: Icons.warning_amber_outlined,
            title: 'Key property - transformHitTests',
            body: 'When transformHitTests is true (default) the hit-test region follows the painted child. When false, taps register where the child would have been without translation. Pick the one that matches your visual intent.',
          ),
          const SizedBox(height: 22),
          Text('What is in this demo', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          const _ChipLine(entries: <(IconData, String)>[
            (Icons.tune, 'Live playground'),
            (Icons.grid_3x3, '3x3 anchor gallery'),
            (Icons.touch_app, 'Hit-test A/B'),
            (Icons.layers, 'Peek stack'),
            (Icons.vibration, 'Shake loop'),
            (Icons.notifications, 'Badge overlay'),
            (Icons.compare_arrows, 'Compare alternatives'),
            (Icons.brush_outlined, 'Painter diagram'),
            (Icons.menu_book, 'API cheat sheet'),
          ]),
        ],
      ),
    );
  }
}

class _HeroSample extends StatelessWidget {
  const _HeroSample({required this.label, required this.translation, required this.accent});
  final String label;
  final Offset translation;
  final Color accent;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _BoundedStage(
          width: double.infinity,
          height: 150,
          child: Center(
            child: FractionalTranslation(
              translation: translation,
              child: Container(
                width: 64,
                height: 64,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: accent.withAlpha(100), blurRadius: 12, offset: const Offset(0, 6)),
                  ],
                ),
                child: Icon(Icons.drag_indicator, color: scheme.onPrimary),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: 'monospace')),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 2 - Playground
// ═══════════════════════════════════════════════════════════════════════════

class _PlaygroundTab extends StatelessWidget {
  const _PlaygroundTab();
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return _Section(
      title: 'Interactive playground',
      subtitle: 'Drag the sliders to build an Offset and watch the orange card translate inside the bounded stage. A painted ruler marks the 0.0 and 1.0 reference lines.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ValueListenableBuilder<double>(
            valueListenable: _playgroundX,
            builder: (BuildContext ctx, double dx, Widget? _) {
              return ValueListenableBuilder<double>(
                valueListenable: _playgroundY,
                builder: (BuildContext ctx2, double dy, Widget? _) {
                  return ValueListenableBuilder<bool>(
                    valueListenable: _playgroundShowRuler,
                    builder: (BuildContext ctx3, bool ruler, Widget? _) {
                      return ValueListenableBuilder<bool>(
                        valueListenable: _playgroundShowBounds,
                        builder: (BuildContext ctx4, bool bounds, Widget? _) {
                          return _PlaygroundBody(dx: dx, dy: dy, ruler: ruler, bounds: bounds);
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
          const SizedBox(height: 22),
          const _Explainer(
            icon: Icons.info_outline,
            title: 'How to read the ruler',
            body: 'The bold lines mark where the card edge reaches when translation.dx or translation.dy equals 1.0. Crossing a bold line means the child has shifted by a full self-size in that axis.',
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: scheme.outlineVariant),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Try these presets', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    _PresetButton(label: 'Center (0, 0)', dx: 0, dy: 0),
                    _PresetButton(label: 'Right (1, 0)', dx: 1, dy: 0),
                    _PresetButton(label: 'Down (0, 1)', dx: 0, dy: 1),
                    _PresetButton(label: 'Diag (0.5, 0.5)', dx: 0.5, dy: 0.5),
                    _PresetButton(label: 'Anti-diag (-0.5, -0.5)', dx: -0.5, dy: -0.5),
                    _PresetButton(label: 'Peek (0, -0.1)', dx: 0, dy: -0.1),
                    _PresetButton(label: 'Offstage right (1.5, 0)', dx: 1.5, dy: 0),
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

class _PresetButton extends StatelessWidget {
  const _PresetButton({required this.label, required this.dx, required this.dy});
  final String label;
  final double dx;
  final double dy;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        _playgroundX.value = dx;
        _playgroundY.value = dy;
      },
      child: Text(label),
    );
  }
}

class _PlaygroundBody extends StatelessWidget {
  const _PlaygroundBody({required this.dx, required this.dy, required this.ruler, required this.bounds});
  final double dx;
  final double dy;
  final bool ruler;
  final bool bounds;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Offset current = Offset(dx, dy);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: scheme.surfaceContainer,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const SizedBox(width: 20, child: Text('x', style: TextStyle(fontWeight: FontWeight.w700))),
                  Expanded(
                    child: Slider(
                      value: dx,
                      min: -1.5,
                      max: 1.5,
                      divisions: 60,
                      label: dx.toStringAsFixed(2),
                      onChanged: (double v) => _playgroundX.value = v,
                    ),
                  ),
                  SizedBox(width: 56, child: Text(dx.toStringAsFixed(2), textAlign: TextAlign.end, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: 'monospace'))),
                ],
              ),
              Row(
                children: <Widget>[
                  const SizedBox(width: 20, child: Text('y', style: TextStyle(fontWeight: FontWeight.w700))),
                  Expanded(
                    child: Slider(
                      value: dy,
                      min: -1.5,
                      max: 1.5,
                      divisions: 60,
                      label: dy.toStringAsFixed(2),
                      onChanged: (double v) => _playgroundY.value = v,
                    ),
                  ),
                  SizedBox(width: 56, child: Text(dy.toStringAsFixed(2), textAlign: TextAlign.end, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontFamily: 'monospace'))),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 14,
                runSpacing: 6,
                children: <Widget>[
                  Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Checkbox(value: ruler, onChanged: (bool? v) => _playgroundShowRuler.value = v ?? false),
                    const Text('Show ruler'),
                  ]),
                  Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Checkbox(value: bounds, onChanged: (bool? v) => _playgroundShowBounds.value = v ?? false),
                    const Text('Show bounds'),
                  ]),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Center(
          child: _BoundedStage(
            width: 380,
            height: 260,
            child: Stack(
              children: <Widget>[
                if (ruler) Positioned.fill(child: CustomPaint(painter: _RulerPainter(color: scheme.outline, highlight: scheme.primary))),
                Center(
                  child: FractionalTranslation(
                    translation: current,
                    child: Container(
                      width: 96,
                      height: 72,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF6C00),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: <BoxShadow>[
                          BoxShadow(color: Colors.black.withAlpha(60), blurRadius: 10, offset: const Offset(0, 6)),
                        ],
                      ),
                      child: Text(
                        '(${dx.toStringAsFixed(2)},\n${dy.toStringAsFixed(2)})',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white, fontFamily: 'monospace', fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                if (bounds)
                  Center(
                    child: IgnorePointer(
                      child: Container(
                        width: 96,
                        height: 72,
                        decoration: BoxDecoration(
                          border: Border.all(color: scheme.primary.withAlpha(120), width: 1.4, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: scheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Live values', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: scheme.onTertiaryContainer)),
              const SizedBox(height: 8),
              _KeyValue(k: 'translation', v: 'Offset(${dx.toStringAsFixed(2)}, ${dy.toStringAsFixed(2)})', mono: true),
              _KeyValue(k: 'pixel offset*', v: 'dx * width + dy * height = visual shift', mono: true),
              _KeyValue(k: 'child size', v: '96 x 72 logical px', mono: true),
              _KeyValue(k: 'computed shift', v: '(${(dx * 96).toStringAsFixed(1)}, ${(dy * 72).toStringAsFixed(1)}) px', mono: true),
              const SizedBox(height: 6),
              Text('* The actual math is separable: translation.dx * child.width, translation.dy * child.height.',
                  style: TextStyle(fontSize: 11, color: scheme.onTertiaryContainer.withAlpha(200))),
            ],
          ),
        ),
      ],
    );
  }
}

class _RulerPainter extends CustomPainter {
  _RulerPainter({required this.color, required this.highlight});
  final Color color;
  final Color highlight;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint thin = Paint()
      ..color = color.withAlpha(70)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    final Paint bold = Paint()
      ..color = highlight.withAlpha(140)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    for (int i = 1; i <= 10; i++) {
      final double step = i / 10.0;
      canvas.drawLine(Offset(cx + step * 48, 0), Offset(cx + step * 48, size.height), thin);
      canvas.drawLine(Offset(cx - step * 48, 0), Offset(cx - step * 48, size.height), thin);
      canvas.drawLine(Offset(0, cy + step * 36), Offset(size.width, cy + step * 36), thin);
      canvas.drawLine(Offset(0, cy - step * 36), Offset(size.width, cy - step * 36), thin);
    }
    canvas.drawLine(Offset(cx + 48, 0), Offset(cx + 48, size.height), bold);
    canvas.drawLine(Offset(cx - 48, 0), Offset(cx - 48, size.height), bold);
    canvas.drawLine(Offset(0, cy + 36), Offset(size.width, cy + 36), bold);
    canvas.drawLine(Offset(0, cy - 36), Offset(size.width, cy - 36), bold);
    final Paint center = Paint()
      ..color = highlight
      ..strokeWidth = 1.2;
    canvas.drawLine(Offset(cx, 0), Offset(cx, size.height), center);
    canvas.drawLine(Offset(0, cy), Offset(size.width, cy), center);
    final TextPainter tp = TextPainter(
      text: TextSpan(text: '0.0', style: TextStyle(color: highlight, fontSize: 10, fontWeight: FontWeight.w700)),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(cx + 3, cy + 3));
    final TextPainter tp1 = TextPainter(
      text: TextSpan(text: '1.0', style: TextStyle(color: highlight, fontSize: 10, fontWeight: FontWeight.w700)),
      textDirection: TextDirection.ltr,
    )..layout();
    tp1.paint(canvas, Offset(cx + 51, cy + 3));
  }

  @override
  bool shouldRepaint(covariant _RulerPainter oldDelegate) => oldDelegate.color != color || oldDelegate.highlight != highlight;
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 3 - Anchor gallery
// ═══════════════════════════════════════════════════════════════════════════

class _AnchorsTab extends StatelessWidget {
  const _AnchorsTab();
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    const List<(String, Offset, IconData)> presets = <(String, Offset, IconData)>[
      ('Top-left', Offset(-0.5, -0.5), Icons.north_west),
      ('Top', Offset(0.0, -0.5), Icons.north),
      ('Top-right', Offset(0.5, -0.5), Icons.north_east),
      ('Left', Offset(-0.5, 0.0), Icons.west),
      ('Center', Offset(0.0, 0.0), Icons.center_focus_strong),
      ('Right', Offset(0.5, 0.0), Icons.east),
      ('Bottom-left', Offset(-0.5, 0.5), Icons.south_west),
      ('Bottom', Offset(0.0, 0.5), Icons.south),
      ('Bottom-right', Offset(0.5, 0.5), Icons.south_east),
    ];
    return _Section(
      title: '3x3 anchor gallery',
      subtitle: 'Each tile contains a bordered anchor box (where layout placed the child) and a painted chip offset by a different self-fraction. This is the classic anchor-pin pattern done without pixel math.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ValueListenableBuilder<int>(
            valueListenable: _anchorIndex,
            builder: (BuildContext ctx, int selected, Widget? _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 1.05,
                    children: <Widget>[
                      for (int i = 0; i < presets.length; i++)
                        _AnchorTile(
                          label: presets[i].$1,
                          translation: presets[i].$2,
                          icon: presets[i].$3,
                          selected: i == selected,
                          onTap: () => _anchorIndex.value = i,
                        ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: scheme.outlineVariant),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Selected preset', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 8),
                        _KeyValue(k: 'name', v: presets[selected].$1),
                        _KeyValue(k: 'translation', v: 'Offset(${presets[selected].$2.dx.toStringAsFixed(2)}, ${presets[selected].$2.dy.toStringAsFixed(2)})', mono: true),
                        _KeyValue(k: 'reads as', v: 'Move by ${(presets[selected].$2.dx * 100).toStringAsFixed(0)}% of self width and ${(presets[selected].$2.dy * 100).toStringAsFixed(0)}% of self height.'),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 22),
          const _Explainer(
            icon: Icons.menu_book_outlined,
            title: 'Why these nine offsets',
            body: 'Offsets of -0.5, 0.0, and 0.5 reproduce the anchor points of Alignment.topLeft through Alignment.bottomRight. Combined with a centered layout, they reproduce the nine principal alignment positions using only self-relative math.',
          ),
          const SizedBox(height: 12),
          const _Explainer(
            icon: Icons.build_outlined,
            title: 'Practical usage',
            body: 'Use this pattern when you already have a layout slot for the child but want the painted result to pin to a corner of that slot. Examples: dropdown menus anchored below a chip, picture-in-picture thumbnails, card tails.',
          ),
        ],
      ),
    );
  }
}

class _AnchorTile extends StatelessWidget {
  const _AnchorTile({required this.label, required this.translation, required this.icon, required this.selected, required this.onTap});
  final String label;
  final Offset translation;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        decoration: BoxDecoration(
          color: selected ? scheme.primaryContainer : scheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: selected ? scheme.primary : scheme.outlineVariant, width: selected ? 1.6 : 1),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, size: 18, color: selected ? scheme.primary : scheme.onSurfaceVariant),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: selected ? scheme.onPrimaryContainer : scheme.onSurface),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      width: 42,
                      height: 32,
                      decoration: BoxDecoration(
                        border: Border.all(color: scheme.outlineVariant),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  Center(
                    child: FractionalTranslation(
                      translation: translation,
                      child: Container(
                        width: 42,
                        height: 32,
                        decoration: BoxDecoration(
                          color: scheme.primary,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '(${translation.dx}, ${translation.dy})',
              style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 4 - Hit tests comparison
// ═══════════════════════════════════════════════════════════════════════════

class _HitTestsTab extends StatelessWidget {
  const _HitTestsTab();
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return _Section(
      title: 'transformHitTests: true vs false',
      subtitle: 'The flag controls whether pointer events follow the painted position. Tap the orange chip in each panel. The counter only increments if the chip\'s hit region is actually where you tapped.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _HitTestPanel(
                  title: 'transformHitTests: true',
                  subtitle: 'Default. Hit area follows paint. Taps on the visible chip count.',
                  accent: scheme.primary,
                  transformHitTests: true,
                  counter: _hitTestTrueTaps,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _HitTestPanel(
                  title: 'transformHitTests: false',
                  subtitle: 'Hit area stays at the original slot. Taps on the visible chip miss; ghost slot catches them.',
                  accent: scheme.tertiary,
                  transformHitTests: false,
                  counter: _hitTestFalseTaps,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: scheme.errorContainer.withAlpha(120),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: scheme.error.withAlpha(140)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.priority_high, color: scheme.onErrorContainer),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Most common bug', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: scheme.onErrorContainer)),
                      const SizedBox(height: 4),
                      Text(
                        'Leaving transformHitTests: false while expecting taps on the visible widget. The paint moves; the hit region does not. This is why a hovering badge that uses FractionalTranslation(transformHitTests: false) looks clickable but is not.',
                        style: TextStyle(color: scheme.onErrorContainer, height: 1.35),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: <Widget>[
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    _hitTestTrueTaps.value = 0;
                    _hitTestFalseTaps.value = 0;
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset counters'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const _Explainer(
            icon: Icons.architecture,
            title: 'How the hit-test flag works',
            body: 'RenderFractionalTranslation applies a translate in its hitTest method only when transformHitTests is true. If false, the child receives events at its original pre-translation position.',
          ),
          const SizedBox(height: 12),
          const _Explainer(
            icon: Icons.hub_outlined,
            title: 'Matching paint and hit for nested cases',
            body: 'When FractionalTranslation contains interactive children (buttons, gestures) keep transformHitTests: true. Only set it false for purely decorative overlays that should not catch events.',
          ),
        ],
      ),
    );
  }
}

class _HitTestPanel extends StatelessWidget {
  const _HitTestPanel({required this.title, required this.subtitle, required this.accent, required this.transformHitTests, required this.counter});
  final String title;
  final String subtitle;
  final Color accent;
  final bool transformHitTests;
  final ValueNotifier<int> counter;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return _DemoCard(
      title: title,
      subtitle: subtitle,
      accent: accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _BoundedStage(
            width: double.infinity,
            height: 180,
            child: Stack(
              children: <Widget>[
                Center(
                  child: Container(
                    width: 110,
                    height: 46,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: scheme.outlineVariant.withAlpha(90),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: scheme.outlineVariant),
                    ),
                    child: Text('ghost slot', style: TextStyle(fontSize: 11, color: scheme.onSurfaceVariant)),
                  ),
                ),
                Center(
                  child: FractionalTranslation(
                    translation: const Offset(0.5, -0.6),
                    transformHitTests: transformHitTests,
                    child: InkWell(
                      onTap: () => counter.value = counter.value + 1,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 110,
                        height: 46,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: accent,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: <BoxShadow>[
                            BoxShadow(color: accent.withAlpha(120), blurRadius: 8, offset: const Offset(0, 4)),
                          ],
                        ),
                        child: const Text('Tap me', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ValueListenableBuilder<int>(
            valueListenable: counter,
            builder: (BuildContext ctx, int v, Widget? _) {
              return Row(
                children: <Widget>[
                  Icon(Icons.touch_app, color: accent, size: 18),
                  const SizedBox(width: 6),
                  Text('taps registered: ', style: Theme.of(context).textTheme.bodyMedium),
                  Text('$v', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: accent, fontWeight: FontWeight.w800)),
                ],
              );
            },
          ),
          const SizedBox(height: 4),
          Text(
            transformHitTests
                ? 'Tap the orange box -> hits'
                : 'Tap the orange box -> misses. Tap the ghost slot -> hits.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 5 - Peek / hover
// ═══════════════════════════════════════════════════════════════════════════

class _PeekTab extends StatelessWidget {
  const _PeekTab();
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return _Section(
      title: 'Peek and hover effects',
      subtitle: 'A classic micro-interaction: a stack of cards where the top one lifts by a small negative-y fraction. FractionalTranslation keeps the lift proportional to the card size, so scaling the stack does not break the motion.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ValueListenableBuilder<bool>(
            valueListenable: _peekActive,
            builder: (BuildContext ctx, bool active, Widget? _) {
              return Row(
                children: <Widget>[
                  FilledButton.icon(
                    onPressed: () => _peekActive.value = !active,
                    icon: Icon(active ? Icons.south : Icons.north),
                    label: Text(active ? 'Lower' : 'Peek'),
                  ),
                  const SizedBox(width: 12),
                  _Pill(text: active ? 'PEEK ACTIVE' : 'AT REST', accent: active ? scheme.primary : scheme.outline),
                ],
              );
            },
          ),
          const SizedBox(height: 20),
          Center(
            child: _BoundedStage(
              width: 420,
              height: 280,
              child: ValueListenableBuilder<bool>(
                valueListenable: _peekActive,
                builder: (BuildContext ctx, bool active, Widget? _) {
                  final Offset target = active ? const Offset(0, -0.18) : Offset.zero;
                  return Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      _PeekCard(index: 2, accent: scheme.tertiary, offsetY: 30, scale: 0.86),
                      _PeekCard(index: 1, accent: scheme.secondary, offsetY: 14, scale: 0.93),
                      TweenAnimationBuilder<Offset>(
                        key: ValueKey<bool>(active),
                        tween: Tween<Offset>(begin: Offset.zero, end: target),
                        duration: const Duration(milliseconds: 380),
                        curve: Curves.easeOutCubic,
                        builder: (BuildContext ctx2, Offset value, Widget? child) {
                          return FractionalTranslation(
                            translation: value,
                            child: child,
                          );
                        },
                        child: _PeekCard(index: 0, accent: scheme.primary, offsetY: 0, scale: 1.0),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 22),
          const _Explainer(
            icon: Icons.design_services_outlined,
            title: 'Why FractionalTranslation here',
            body: 'The lift amount is defined in terms of the card itself. If the stack shrinks or the design system scales the entire deck, the motion still reads correctly without recomputing pixels.',
          ),
          const SizedBox(height: 12),
          const _Explainer(
            icon: Icons.swap_vert,
            title: 'Comparison with Transform.translate',
            body: 'Doing this with Transform.translate would need LayoutBuilder to measure the child first, then compute a pixel offset. FractionalTranslation skips that step entirely.',
          ),
          const SizedBox(height: 22),
          Text('Hover-style mini grid', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            'Static snapshots of different peek intensities. Imagine each one as the end state of a hover gesture.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              for (final double p in <double>[0.0, -0.05, -0.1, -0.18, -0.3])
                _PeekSnapshot(peek: p),
            ],
          ),
        ],
      ),
    );
  }
}

class _PeekCard extends StatelessWidget {
  const _PeekCard({required this.index, required this.accent, required this.offsetY, required this.scale});
  final int index;
  final Color accent;
  final double offsetY;
  final double scale;
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, offsetY),
      child: Transform.scale(
        scale: scale,
        child: Container(
          width: 220,
          height: 150,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(18),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Colors.black.withAlpha(50), blurRadius: 14, offset: const Offset(0, 8)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Icon(Icons.bookmark, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text('Card #$index', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                ],
              ),
              const Spacer(),
              Text(
                index == 0 ? 'Lifts on peek' : 'Stays in place',
                style: TextStyle(color: Colors.white.withAlpha(220), fontSize: 12),
              ),
              const SizedBox(height: 4),
              Container(height: 4, decoration: BoxDecoration(color: Colors.white.withAlpha(80), borderRadius: BorderRadius.circular(2))),
            ],
          ),
        ),
      ),
    );
  }
}

class _PeekSnapshot extends StatelessWidget {
  const _PeekSnapshot({required this.peek});
  final double peek;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Column(
      children: <Widget>[
        _BoundedStage(
          width: 120,
          height: 120,
          child: Center(
            child: FractionalTranslation(
              translation: Offset(0, peek),
              child: Container(
                width: 70,
                height: 50,
                decoration: BoxDecoration(
                  color: scheme.primary,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: scheme.primary.withAlpha(120), blurRadius: 10, offset: const Offset(0, 6)),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text('dy=${peek.toStringAsFixed(2)}', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontFamily: 'monospace')),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 6 - Shake animation
// ═══════════════════════════════════════════════════════════════════════════

class _ShakeTab extends StatelessWidget {
  const _ShakeTab();
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return _Section(
      title: 'Shake animation',
      subtitle: 'FractionalTranslation driven by TweenAnimationBuilder. The tween oscillates through a handful of anchor values over one run, producing a classic input-error shake without needing any State in this file.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ValueListenableBuilder<int>(
            valueListenable: _shakeEpoch,
            builder: (BuildContext ctx, int epoch, Widget? _) {
              return ValueListenableBuilder<double>(
                valueListenable: _shakeAmplitude,
                builder: (BuildContext ctx2, double amp, Widget? _) {
                  return _ShakeBody(epoch: epoch, amplitude: amp);
                },
              );
            },
          ),
          const SizedBox(height: 22),
          const _Explainer(
            icon: Icons.auto_fix_high,
            title: 'How the shake is built',
            body: 'A single TweenAnimationBuilder<double> animates a phase from 0 to 1. The builder turns phase into a damped sinusoidal x-fraction. FractionalTranslation consumes it. Restarting the animation is just bumping a ValueNotifier-backed key.',
          ),
          const SizedBox(height: 12),
          const _Explainer(
            icon: Icons.tune,
            title: 'Why fraction not pixels',
            body: 'Input fields of different sizes share the same shake feel: a 0.08 fractional shake reads identically on a 200px chip or a 600px banner.',
          ),
          const SizedBox(height: 22),
          Text('Static snapshots along the curve', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              for (final double phase in <double>[0.0, 0.15, 0.3, 0.5, 0.7, 0.9, 1.0])
                Expanded(
                  child: _ShakeFrame(
                    phase: phase,
                    color: scheme.tertiary,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ShakeBody extends StatelessWidget {
  const _ShakeBody({required this.epoch, required this.amplitude});
  final int epoch;
  final double amplitude;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            FilledButton.icon(
              onPressed: () => _shakeEpoch.value = epoch + 1,
              icon: const Icon(Icons.vibration),
              label: const Text('Shake!'),
            ),
            const SizedBox(width: 12),
            _Pill(text: 'epoch $epoch', accent: scheme.secondary),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            const SizedBox(width: 70, child: Text('amplitude')),
            Expanded(
              child: Slider(
                value: amplitude,
                min: 0.02,
                max: 0.4,
                divisions: 38,
                label: amplitude.toStringAsFixed(2),
                onChanged: (double v) => _shakeAmplitude.value = v,
              ),
            ),
            SizedBox(width: 54, child: Text(amplitude.toStringAsFixed(2), textAlign: TextAlign.end, style: const TextStyle(fontFamily: 'monospace'))),
          ],
        ),
        const SizedBox(height: 10),
        Center(
          child: _BoundedStage(
            width: 420,
            height: 160,
            child: Center(
              child: TweenAnimationBuilder<double>(
                key: ValueKey<int>(epoch),
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 650),
                curve: Curves.linear,
                builder: (BuildContext ctx, double t, Widget? child) {
                  final double damp = (1 - t).clamp(0.0, 1.0);
                  final double phase = t * 6.0;
                  final double dx = _fastSin(phase) * amplitude * damp;
                  return FractionalTranslation(
                    translation: Offset(dx, 0),
                    child: child,
                  );
                },
                child: Container(
                  width: 260,
                  height: 58,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: scheme.error, width: 1.5),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.error_outline, color: scheme.error),
                      const SizedBox(width: 10),
                      Text('Wrong password', style: TextStyle(color: scheme.error, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

double _fastSin(double x) {
  // Approximation avoiding dart:math to keep imports minimal. Valid in |x|<=2pi.
  // Uses Taylor-ish polynomial; good enough for visual oscillation.
  const double twoPi = 6.283185307179586;
  double t = x % twoPi;
  if (t > 3.141592653589793) t -= twoPi;
  final double t2 = t * t;
  final double t3 = t2 * t;
  final double t5 = t3 * t2;
  final double t7 = t5 * t2;
  return t - t3 / 6.0 + t5 / 120.0 - t7 / 5040.0;
}

class _ShakeFrame extends StatelessWidget {
  const _ShakeFrame({required this.phase, required this.color});
  final double phase;
  final Color color;
  @override
  Widget build(BuildContext context) {
    final double damp = (1 - phase).clamp(0.0, 1.0);
    final double dx = _fastSin(phase * 6.0) * 0.15 * damp;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Column(
        children: <Widget>[
          _BoundedStage(
            width: double.infinity,
            height: 60,
            child: Center(
              child: FractionalTranslation(
                translation: Offset(dx, 0),
                child: Container(
                  width: 42,
                  height: 22,
                  decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text('t=${phase.toStringAsFixed(2)}', style: const TextStyle(fontSize: 10, fontFamily: 'monospace')),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 7 - Badge on icon
// ═══════════════════════════════════════════════════════════════════════════

class _BadgeTab extends StatelessWidget {
  const _BadgeTab();
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return _Section(
      title: 'Floating badge on an icon',
      subtitle: 'The classic notification badge: a Stack of an Icon with a counter overlay. The badge is positioned by FractionalTranslation with Offset(0.5, -0.5), pinning it to the corner of its layout slot.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ValueListenableBuilder<int>(
            valueListenable: _badgeCount,
            builder: (BuildContext ctx, int count, Widget? _) {
              return Row(
                children: <Widget>[
                  OutlinedButton.icon(
                    onPressed: () => _badgeCount.value = (count - 1).clamp(0, 99),
                    icon: const Icon(Icons.remove),
                    label: const Text('Clear one'),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    onPressed: () => _badgeCount.value = (count + 1).clamp(0, 99),
                    icon: const Icon(Icons.add),
                    label: const Text('Add one'),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    onPressed: () => _badgeCount.value = 12,
                    icon: const Icon(Icons.all_inbox),
                    label: const Text('Set 12'),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 18),
          Center(
            child: _BoundedStage(
              width: 420,
              height: 260,
              child: ValueListenableBuilder<int>(
                valueListenable: _badgeCount,
                builder: (BuildContext ctx, int count, Widget? _) {
                  return Center(
                    child: _BadgedIcon(count: count),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text('Positioning variants', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: <Widget>[
              _BadgeVariant(label: '(0.5, -0.5)\ndefault', translation: const Offset(0.5, -0.5), count: 3, color: scheme.primary),
              _BadgeVariant(label: '(-0.5, -0.5)\ntop-left', translation: const Offset(-0.5, -0.5), count: 7, color: scheme.secondary),
              _BadgeVariant(label: '(0.5, 0.5)\nbottom-right', translation: const Offset(0.5, 0.5), count: 1, color: scheme.tertiary),
              _BadgeVariant(label: '(0, -1)\ncrown', translation: const Offset(0, -1.0), count: 99, color: scheme.error),
              _BadgeVariant(label: '(1, 0)\noff to side', translation: const Offset(1.0, 0.0), count: 42, color: scheme.primary),
            ],
          ),
          const SizedBox(height: 22),
          const _Explainer(
            icon: Icons.fit_screen,
            title: 'Why FractionalTranslation is ideal for badges',
            body: 'The badge size is unknown at design time (a 1-digit count looks different from a "99+"), yet the paint offset should always land at the same visual corner. Self-fraction math solves this without LayoutBuilder or Positioned calculations.',
          ),
          const SizedBox(height: 12),
          const _Explainer(
            icon: Icons.block,
            title: 'Pitfall - transformHitTests on decorative badges',
            body: 'If the badge is pure decoration over an already-interactive icon, keep transformHitTests: true so a tap on the visual badge also reaches the icon\'s gesture detector. Only set false when you intend the badge to be unreachable.',
          ),
        ],
      ),
    );
  }
}

class _BadgedIcon extends StatelessWidget {
  const _BadgedIcon({required this.count});
  final int count;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          width: 96,
          height: 96,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: scheme.primaryContainer,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Icon(Icons.notifications, size: 52, color: scheme.onPrimaryContainer),
        ),
        if (count > 0)
          Positioned(
            right: 4,
            top: 4,
            child: FractionalTranslation(
              translation: const Offset(0.5, -0.5),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                constraints: const BoxConstraints(minWidth: 22, minHeight: 22),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: scheme.error,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: scheme.surface, width: 2),
                ),
                child: Text(
                  count > 99 ? '99+' : '$count',
                  style: TextStyle(color: scheme.onError, fontSize: 12, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _BadgeVariant extends StatelessWidget {
  const _BadgeVariant({required this.label, required this.translation, required this.count, required this.color});
  final String label;
  final Offset translation;
  final int count;
  final Color color;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 80,
            child: Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Container(
                    width: 56,
                    height: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: scheme.surfaceContainerHigh, borderRadius: BorderRadius.circular(14)),
                    child: Icon(Icons.mail_outline, color: scheme.onSurface),
                  ),
                  Positioned(
                    right: 2,
                    top: 2,
                    child: FractionalTranslation(
                      translation: translation,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
                        child: Text('$count', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, fontFamily: 'monospace')),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 8 - Comparison with alternatives
// ═══════════════════════════════════════════════════════════════════════════

class _CompareTab extends StatelessWidget {
  const _CompareTab();
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return _Section(
      title: 'FractionalTranslation vs its cousins',
      subtitle: 'Four widgets can "shift" a child. Each chooses a different reference frame. Switch tabs below to see identical input handled four ways.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ValueListenableBuilder<int>(
            valueListenable: _comparisonMode,
            builder: (BuildContext ctx, int mode, Widget? _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: <Widget>[
                      for (int i = 0; i < 4; i++)
                        ChoiceChip(
                          label: Text(<String>['FractionalTranslation', 'Transform.translate', 'Transform.translate + FractionalOffset', 'Align + alignment'][i]),
                          selected: mode == i,
                          onSelected: (bool v) { if (v) _comparisonMode.value = i; },
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _CompareStage(mode: mode),
                  const SizedBox(height: 16),
                  _CompareExplanation(mode: mode),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          Text('Side-by-side results', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: _CompareMini(title: 'FractionalTranslation', subtitle: 'fraction of SELF size', child: Center(child: FractionalTranslation(translation: const Offset(0.5, 0), child: _MiniBox(color: scheme.primary))))),
              const SizedBox(width: 10),
              Expanded(child: _CompareMini(title: 'Transform.translate', subtitle: 'absolute pixels', child: Center(child: Transform.translate(offset: const Offset(40, 0), child: _MiniBox(color: scheme.secondary))))),
              const SizedBox(width: 10),
              Expanded(child: _CompareMini(title: 'FractionalOffset + Stack', subtitle: 'resolved against parent', child: Stack(children: <Widget>[Align(alignment: FractionalOffset.center, child: _MiniBox(color: scheme.outlineVariant)), Align(alignment: const FractionalOffset(0.75, 0.5), child: _MiniBox(color: scheme.tertiary))]))),
              const SizedBox(width: 10),
              Expanded(child: _CompareMini(title: 'Align(alignment)', subtitle: 'parent-relative', child: Align(alignment: const Alignment(0.5, 0), child: _MiniBox(color: scheme.error)))),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: scheme.surfaceContainer,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: scheme.outlineVariant),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Reference frame cheat sheet', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 10),
                _CompareRow(
                  widget: 'FractionalTranslation',
                  unit: 'fraction of CHILD size',
                  handles: 'Paint-only shift, hit-test-aware',
                  pick: 'Anchor, peek, badge, shake',
                ),
                const Divider(),
                _CompareRow(
                  widget: 'Transform.translate',
                  unit: 'absolute pixels',
                  handles: 'Paint-only shift',
                  pick: 'Known pixel distances',
                ),
                const Divider(),
                _CompareRow(
                  widget: 'Align(alignment:)',
                  unit: 'fraction of free space in PARENT',
                  handles: 'Affects layout',
                  pick: 'Position inside a parent slot',
                ),
                const Divider(),
                _CompareRow(
                  widget: 'Positioned',
                  unit: 'absolute inside Stack',
                  handles: 'Requires a Stack',
                  pick: 'Absolute placement',
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const _Explainer(
            icon: Icons.schema_outlined,
            title: 'Rule of thumb',
            body: 'Ask: "Do I know the child\'s size?" - If yes, use Transform.translate. "Does the shift read as a fraction of the child?" - FractionalTranslation. "Does the shift reference the parent slot?" - Align. "Do I want absolute placement in a Stack?" - Positioned.',
          ),
        ],
      ),
    );
  }
}

class _CompareMini extends StatelessWidget {
  const _CompareMini({required this.title, required this.subtitle, required this.child});
  final String title;
  final String subtitle;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.titleSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 2),
          Text(subtitle, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
          const SizedBox(height: 8),
          SizedBox(
            height: 96,
            child: _BoundedStage(width: double.infinity, height: 96, child: child),
          ),
        ],
      ),
    );
  }
}

class _MiniBox extends StatelessWidget {
  const _MiniBox({required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 28,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
    );
  }
}

class _CompareRow extends StatelessWidget {
  const _CompareRow({required this.widget, required this.unit, required this.handles, required this.pick});
  final String widget;
  final String unit;
  final String handles;
  final String pick;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: scheme.primary)),
          const SizedBox(height: 2),
          _KeyValue(k: 'units', v: unit),
          _KeyValue(k: 'behavior', v: handles),
          _KeyValue(k: 'pick when', v: pick),
        ],
      ),
    );
  }
}

class _CompareStage extends StatelessWidget {
  const _CompareStage({required this.mode});
  final int mode;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    Widget target;
    final Widget box = Container(
      width: 90,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: scheme.primary, borderRadius: BorderRadius.circular(10)),
      child: const Text('child', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
    );
    switch (mode) {
      case 0:
        target = FractionalTranslation(translation: const Offset(0.5, 0), child: box);
        break;
      case 1:
        target = Transform.translate(offset: const Offset(45, 0), child: box);
        break;
      case 2:
        target = FractionalTranslation(translation: const Offset(0.5, 0), child: box);
        break;
      case 3:
      default:
        target = Align(alignment: const Alignment(0.5, 0), child: box);
        break;
    }
    return _BoundedStage(
      width: double.infinity,
      height: 160,
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              width: 90,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(color: scheme.outlineVariant, width: 1.2, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Center(child: target),
        ],
      ),
    );
  }
}

class _CompareExplanation extends StatelessWidget {
  const _CompareExplanation({required this.mode});
  final int mode;
  @override
  Widget build(BuildContext context) {
    const List<(String, String)> notes = <(String, String)>[
      (
        'FractionalTranslation',
        'Offset(0.5, 0) means shift by 50% of the child width. Here 50% of 90 = 45 logical pixels. The layout slot (outlined) stays put; only paint moves.',
      ),
      (
        'Transform.translate',
        'Offset(45, 0) is an absolute 45 pixels. It is numerically equivalent here, but you had to know the child width.',
      ),
      (
        'Transform + FractionalOffset',
        'FractionalOffset is a resolved alignment; to translate by a fraction of the child you still reach for FractionalTranslation. There is no symmetric "Transform.translateFraction".',
      ),
      (
        'Align(alignment)',
        'Alignment(0.5, 0) positions the child inside the parent slot. This changes layout: the child moves and everything downstream sees the new position.',
      ),
    ];
    final (String t, String b) = notes[mode];
    return _Explainer(icon: Icons.chat_bubble_outline, title: t, body: b);
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 9 - API cheat sheet + diagram + use cases + pitfalls
// ═══════════════════════════════════════════════════════════════════════════

class _ApiTab extends StatelessWidget {
  const _ApiTab();
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return _Section(
      title: 'API, diagram, use cases, pitfalls',
      subtitle: 'Everything you need to keep within reach when reaching for FractionalTranslation: its signature, the math it performs, six solid use cases, and three traps.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Diagram', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          _BoundedStage(
            width: double.infinity,
            height: 260,
            child: CustomPaint(
              painter: _DiagramPainter(
                scheme: scheme,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text('Offset(0.5, -0.25) applied to a 200x120 child -> paint shifts by (100, -30) logical pixels.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
          const SizedBox(height: 24),
          Text('Constructor', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: scheme.outlineVariant),
            ),
            child: const Text(
              'FractionalTranslation({\n'
              '  Key? key,\n'
              '  required Offset translation,\n'
              '  bool transformHitTests = true,\n'
              '  Widget? child,\n'
              '})',
              style: TextStyle(fontFamily: 'monospace', fontSize: 13, height: 1.45),
            ),
          ),
          const SizedBox(height: 14),
          Text('Property table', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          _PropertyTable(),
          const SizedBox(height: 24),
          Text('Use cases', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          const _UseCasesGrid(),
          const SizedBox(height: 24),
          Text('Pitfalls', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          Column(
            children: const <Widget>[
              _PitfallTile(
                icon: Icons.touch_app,
                title: 'transformHitTests confusion',
                body: 'Forgetting the flag produces widgets that look clickable but are not (or vice versa). Default is true. Flip only for decorative overlays.',
              ),
              SizedBox(height: 10),
              _PitfallTile(
                icon: Icons.straighten,
                title: 'Parent-size assumptions',
                body: 'Units are the CHILD size, never the parent. Offset(1, 0) shifts by a full child width, not a full parent width. If you need parent-relative movement, use Align or Fractional* positioning inside a Stack.',
              ),
              SizedBox(height: 10),
              _PitfallTile(
                icon: Icons.crop_free,
                title: 'Overflow and clipping',
                body: 'FractionalTranslation only affects paint. The child can paint outside its parent. Wrap in ClipRect or a container with clipBehavior if you do not want spill-over, especially for offsets beyond -1 or +1.',
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('Quick recap', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: scheme.primaryContainer,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('FractionalTranslation in one sentence',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: scheme.onPrimaryContainer)),
                const SizedBox(height: 8),
                Text(
                  'Paint-layer shift of a child by an Offset measured in multiples of the child\'s own rendered size, with optional hit-test translation matching the visual result.',
                  style: TextStyle(color: scheme.onPrimaryContainer, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PropertyTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    const List<(String, String, String, String)> rows = <(String, String, String, String)>[
      (
        'translation',
        'Offset',
        'required',
        'Offset whose dx and dy are multiplied by the child\'s own width and height to compute the paint-time shift.'
      ),
      (
        'transformHitTests',
        'bool',
        'true',
        'Whether the hit-test region moves with the painted child. False keeps events at the original layout slot.'
      ),
      (
        'child',
        'Widget?',
        'null',
        'The widget to translate. May be any widget. Sized by its own constraints, independent of this widget.'
      ),
      (
        'key',
        'Key?',
        'null',
        'Standard Widget.key. Useful for preserving a subtree across rebuilds when translation values change dramatically.'
      ),
    ];
    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: scheme.secondaryContainer,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: const <Widget>[
                SizedBox(width: 140, child: Text('Property', style: TextStyle(fontWeight: FontWeight.w800))),
                SizedBox(width: 90, child: Text('Type', style: TextStyle(fontWeight: FontWeight.w800))),
                SizedBox(width: 90, child: Text('Default', style: TextStyle(fontWeight: FontWeight.w800))),
                Expanded(child: Text('Description', style: TextStyle(fontWeight: FontWeight.w800))),
              ],
            ),
          ),
          for (int i = 0; i < rows.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: i.isEven ? Colors.transparent : scheme.surfaceContainerLow,
                border: Border(top: BorderSide(color: scheme.outlineVariant)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 140, child: Text(rows[i].$1, style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w700))),
                  SizedBox(width: 90, child: Text(rows[i].$2, style: const TextStyle(fontFamily: 'monospace'))),
                  SizedBox(width: 90, child: Text(rows[i].$3, style: const TextStyle(fontFamily: 'monospace'))),
                  Expanded(child: Text(rows[i].$4, style: Theme.of(context).textTheme.bodySmall)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _UseCasesGrid extends StatelessWidget {
  const _UseCasesGrid();
  @override
  Widget build(BuildContext context) {
    const List<(IconData, String, String)> cases = <(IconData, String, String)>[
      (Icons.notifications_active, 'Notification badge', 'Pin a count chip to the corner of an icon without knowing either size in advance.'),
      (Icons.auto_awesome, 'Peek preview', 'Lift the top card of a deck by a consistent fraction on hover or selection.'),
      (Icons.vibration, 'Shake on error', 'Jitter an input by a tiny fraction of its width when validation fails.'),
      (Icons.chat_bubble_outline, 'Tooltip tail', 'Anchor a speech-bubble tail at 50% of the bubble\'s width regardless of text length.'),
      (Icons.layers_outlined, 'Stacked staging', 'Slide an off-screen card by 1.0+ fractions to enter from beyond its own bounds.'),
      (Icons.touch_app_outlined, 'Thumb zone highlight', 'Offset an interactive hint by a self-fraction over a button to draw the eye without moving the button.'),
    ];
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2.6,
      children: <Widget>[
        for (final (IconData icon, String title, String body) in cases) _UseCaseCard(icon: icon, title: title, body: body),
      ],
    );
  }
}

class _UseCaseCard extends StatelessWidget {
  const _UseCaseCard({required this.icon, required this.title, required this.body});
  final IconData icon;
  final String title;
  final String body;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: scheme.onPrimaryContainer, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 4),
                Text(body, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PitfallTile extends StatelessWidget {
  const _PitfallTile({required this.icon, required this.title, required this.body});
  final IconData icon;
  final String title;
  final String body;
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.errorContainer.withAlpha(100),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.error.withAlpha(140)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: scheme.error),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: scheme.onErrorContainer)),
                const SizedBox(height: 4),
                Text(body, style: TextStyle(color: scheme.onErrorContainer, height: 1.35)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DiagramPainter extends CustomPainter {
  _DiagramPainter({required this.scheme});
  final ColorScheme scheme;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = scheme.surfaceContainerLow;
    canvas.drawRect(Offset.zero & size, bg);
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    const double boxW = 200;
    const double boxH = 120;
    // Original layout slot (dashed-like using outline var).
    final Rect slot = Rect.fromCenter(center: Offset(cx, cy), width: boxW, height: boxH);
    final Paint slotStroke = Paint()
      ..color = scheme.outline.withAlpha(160)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawRRect(RRect.fromRectAndRadius(slot, const Radius.circular(8)), slotStroke);
    _dashedBorder(canvas, slot, scheme.outline.withAlpha(220));
    _label(canvas, 'layout slot', Offset(slot.left + 4, slot.top - 16), scheme.onSurfaceVariant);

    // Painted child after FractionalTranslation(Offset(0.5, -0.25)).
    final double tx = 0.5 * boxW;
    final double ty = -0.25 * boxH;
    final Rect painted = slot.shift(Offset(tx, ty));
    final Paint paintedFill = Paint()..color = scheme.primary.withAlpha(220);
    canvas.drawRRect(RRect.fromRectAndRadius(painted, const Radius.circular(10)), paintedFill);
    _label(canvas, 'painted child', Offset(painted.left + 6, painted.top + 6), scheme.onPrimary);
    _label(canvas, 'Offset(0.5, -0.25)', Offset(painted.left + 6, painted.top + 24), scheme.onPrimary.withAlpha(220));

    // Arrow from slot center to painted center.
    final Offset arrowStart = slot.center;
    final Offset arrowEnd = painted.center;
    final Paint arrow = Paint()
      ..color = scheme.tertiary
      ..strokeWidth = 2.4
      ..style = PaintingStyle.stroke;
    canvas.drawLine(arrowStart, arrowEnd, arrow);
    _arrowHead(canvas, arrowStart, arrowEnd, scheme.tertiary);

    // Side brackets showing width and height of child, with the fractional amounts.
    final Paint bracket = Paint()
      ..color = scheme.onSurfaceVariant
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    final double bw = slot.top - 28;
    canvas.drawLine(Offset(slot.left, bw), Offset(slot.right, bw), bracket);
    canvas.drawLine(Offset(slot.left, bw - 4), Offset(slot.left, bw + 4), bracket);
    canvas.drawLine(Offset(slot.right, bw - 4), Offset(slot.right, bw + 4), bracket);
    _label(canvas, 'width = child.width', Offset(slot.left + 20, bw - 16), scheme.onSurfaceVariant);

    final double bh = slot.right + 20;
    canvas.drawLine(Offset(bh, slot.top), Offset(bh, slot.bottom), bracket);
    canvas.drawLine(Offset(bh - 4, slot.top), Offset(bh + 4, slot.top), bracket);
    canvas.drawLine(Offset(bh - 4, slot.bottom), Offset(bh + 4, slot.bottom), bracket);
    _label(canvas, 'height', Offset(bh + 4, slot.top + (slot.height - 18) / 2), scheme.onSurfaceVariant);

    // Caption under everything.
    _label(
      canvas,
      'shift = (dx * width, dy * height) = (0.5*200, -0.25*120) = (100, -30)',
      Offset(16, size.height - 24),
      scheme.onSurface,
      size: 12,
      bold: true,
    );
  }

  void _dashedBorder(Canvas canvas, Rect r, Color c) {
    final Paint p = Paint()
      ..color = c
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;
    const double dash = 6;
    const double gap = 4;
    double x = r.left;
    while (x < r.right) {
      final double next = (x + dash).clamp(r.left, r.right);
      canvas.drawLine(Offset(x, r.top), Offset(next, r.top), p);
      canvas.drawLine(Offset(x, r.bottom), Offset(next, r.bottom), p);
      x += dash + gap;
    }
    double y = r.top;
    while (y < r.bottom) {
      final double next = (y + dash).clamp(r.top, r.bottom);
      canvas.drawLine(Offset(r.left, y), Offset(r.left, next), p);
      canvas.drawLine(Offset(r.right, y), Offset(r.right, next), p);
      y += dash + gap;
    }
  }

  void _arrowHead(Canvas canvas, Offset from, Offset to, Color color) {
    final double angle = _atan2(to.dy - from.dy, to.dx - from.dx);
    const double size = 10;
    final Offset p1 = Offset(
      to.dx - size * _cos(angle - 0.4),
      to.dy - size * _sin(angle - 0.4),
    );
    final Offset p2 = Offset(
      to.dx - size * _cos(angle + 0.4),
      to.dy - size * _sin(angle + 0.4),
    );
    final Path path = Path()
      ..moveTo(to.dx, to.dy)
      ..lineTo(p1.dx, p1.dy)
      ..lineTo(p2.dx, p2.dy)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  void _label(Canvas canvas, String text, Offset at, Color color, {double size = 11, bool bold = false}) {
    final TextPainter tp = TextPainter(
      text: TextSpan(text: text, style: TextStyle(color: color, fontSize: size, fontWeight: bold ? FontWeight.w800 : FontWeight.w600, fontFamily: 'monospace')),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, at);
  }

  @override
  bool shouldRepaint(covariant _DiagramPainter oldDelegate) => oldDelegate.scheme != scheme;
}

double _atan2(double y, double x) {
  // Minimal atan2 without dart:math.
  if (x > 0) return _atan(y / x);
  if (x < 0 && y >= 0) return _atan(y / x) + 3.141592653589793;
  if (x < 0 && y < 0) return _atan(y / x) - 3.141592653589793;
  if (x == 0 && y > 0) return 3.141592653589793 / 2;
  if (x == 0 && y < 0) return -3.141592653589793 / 2;
  return 0.0;
}

double _atan(double z) {
  // 5th order Taylor approximation around 0; acceptable for diagram arrows.
  final double a = z / (1 + 0.28 * z * z);
  return a;
}

double _cos(double x) => _fastSin(x + 1.5707963267948966);
double _sin(double x) => _fastSin(x);
