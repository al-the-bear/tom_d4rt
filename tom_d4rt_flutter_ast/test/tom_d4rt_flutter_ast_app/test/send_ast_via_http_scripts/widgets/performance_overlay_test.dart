import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// PerformanceOverlay option mask constants
// (Flutter uses PerformanceOverlayOption enum; mask = 1 << option.index)
// ---------------------------------------------------------------------------
const int _kDisplayRasterizerStatistics =
    1 << 0; // PerformanceOverlayOption.displayRasterizerStatistics
const int _kVisualizeRasterizerStatistics =
    1 << 1; // PerformanceOverlayOption.visualizeRasterizerStatistics
const int _kDisplayEngineStatistics =
    1 << 2; // PerformanceOverlayOption.displayEngineStatistics
const int _kVisualizeEngineStatistics =
    1 << 3; // PerformanceOverlayOption.visualizeEngineStatistics

// ---------------------------------------------------------------------------
// Top-level ValueNotifiers (STATELESS constraint: no StatefulWidget)
// ---------------------------------------------------------------------------
final ValueNotifier<bool> _showOverlay = ValueNotifier<bool>(false);
final ValueNotifier<int> _optionsMask = ValueNotifier<int>(
  _kDisplayRasterizerStatistics | _kDisplayEngineStatistics,
);
final ValueNotifier<bool> _jankEnabled = ValueNotifier<bool>(false);
final ValueNotifier<double> _budgetSlider = ValueNotifier<double>(16.6);

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
    ),
    home: const _PerformanceOverlayDemo(),
  );
}

// ---------------------------------------------------------------------------
// Root scaffold with DefaultTabController (9 tabs)
// ---------------------------------------------------------------------------
class _PerformanceOverlayDemo extends StatelessWidget {
  const _PerformanceOverlayDemo();

  static const List<Tab> _tabs = <Tab>[
    Tab(icon: Icon(Icons.star_outline), text: 'Hero'),
    Tab(icon: Icon(Icons.layers_outlined), text: 'Real API'),
    Tab(icon: Icon(Icons.bar_chart), text: 'Frame Graph'),
    Tab(icon: Icon(Icons.tune), text: 'Flags'),
    Tab(icon: Icon(Icons.toggle_on_outlined), text: 'showOverlay'),
    Tab(icon: Icon(Icons.timeline), text: '60fps Budget'),
    Tab(icon: Icon(Icons.warning_amber_outlined), text: 'Jank'),
    Tab(icon: Icon(Icons.device_hub), text: 'Threads'),
    Tab(icon: Icon(Icons.checklist), text: 'Cheat Sheet'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('PerformanceOverlay Deep Demo'),
          centerTitle: true,
          bottom: const TabBar(
            isScrollable: true,
            tabs: _tabs,
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _HeroBannerTab(),
            _RealApiTab(),
            _FrameGraphTab(),
            _FlagsTab(),
            _ShowOverlayTab(),
            _BudgetDiagramTab(),
            _JankSimTab(),
            _ThreadsTab(),
            _CheatSheetTab(),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// TAB 1 — Hero Banner
// ===========================================================================
class _HeroBannerTab extends StatelessWidget {
  const _HeroBannerTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        // ---- gradient hero card ----
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: <Color>[cs.primary, cs.tertiary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.speed, size: 56, color: cs.onPrimary),
              const SizedBox(height: 16),
              Text(
                'PerformanceOverlay',
                style: tt.headlineLarge?.copyWith(
                  color: cs.onPrimary,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Real-time frame-timing graphs painted directly on top of your running Flutter app.',
                style: tt.bodyLarge?.copyWith(color: cs.onPrimary.withAlpha(220)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        // ---- 16ms budget card ----
        _SectionCard(
          icon: Icons.timer_outlined,
          title: 'The 16 ms Budget',
          color: cs.errorContainer,
          iconColor: cs.error,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'To achieve a smooth 60 frames per second, each frame must complete in under 16.6 ms. Miss this deadline and Flutter drops a frame — users feel the "jank".',
                style: tt.bodyMedium,
              ),
              const SizedBox(height: 12),
              _BudgetRow(label: '60 fps', ms: 16.6, color: cs.error),
              _BudgetRow(label: '30 fps', ms: 33.3, color: cs.secondary),
              _BudgetRow(label: '120 fps', ms: 8.3, color: cs.tertiary),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // ---- why it matters ----
        _SectionCard(
          icon: Icons.lightbulb_outline,
          title: 'Why Frame Timing Matters',
          color: cs.secondaryContainer,
          iconColor: cs.secondary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _BulletItem(
                text: 'Every visible stutter erodes user trust and perceived quality.',
                icon: Icons.sentiment_dissatisfied_outlined,
              ),
              _BulletItem(
                text: 'Two threads drive rendering: UI thread (Dart) and Raster thread (GPU/Skia).',
                icon: Icons.device_hub,
              ),
              _BulletItem(
                text: 'PerformanceOverlay exposes both thread timelines simultaneously.',
                icon: Icons.bar_chart,
              ),
              _BulletItem(
                text: 'Spike detection is instant — no DevTools connection needed.',
                icon: Icons.bolt_outlined,
              ),
              _BulletItem(
                text: 'Must be used in profile or release builds for accurate numbers.',
                icon: Icons.build_outlined,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // ---- constructor signature ----
        _SectionCard(
          icon: Icons.code,
          title: 'Constructor Signature',
          color: cs.tertiaryContainer,
          iconColor: cs.tertiary,
          child: _MonoBox(
            text: 'PerformanceOverlay({\n'
                '  Key? key,\n'
                '  int optionsMask = 0,\n'
                '})',
          ),
        ),
        const SizedBox(height: 20),
        // ---- widget hierarchy note ----
        _SectionCard(
          icon: Icons.account_tree_outlined,
          title: 'Widget Hierarchy',
          color: cs.primaryContainer,
          iconColor: cs.primary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'PerformanceOverlay renders as a separate layer drawn over all other content. '
                'The typical integration is via Stack or via MaterialApp.showPerformanceOverlay.',
                style: tt.bodyMedium,
              ),
              const SizedBox(height: 12),
              _MonoBox(
                text: 'Stack(\n'
                    '  children: [\n'
                    '    MyApp(),\n'
                    '    PerformanceOverlay(optionsMask: ...) // on top\n'
                    '  ],\n'
                    ')',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BudgetRow extends StatelessWidget {
  const _BudgetRow({
    required this.label,
    required this.ms,
    required this.color,
  });
  final String label;
  final double ms;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontFamily: 'monospace'),
          ),
          const SizedBox(width: 8),
          Text('$ms ms per frame', style: TextStyle(color: color, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 2 — Real PerformanceOverlay API
// ===========================================================================
class _RealApiTab extends StatelessWidget {
  const _RealApiTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _HeaderChip(label: 'Live Widget Instance', icon: Icons.layers),
        const SizedBox(height: 16),
        Text(
          'The yellow/green box below is a real PerformanceOverlay widget embedded in a Stack. '
          'In the D4rt sandbox / debug mode it renders as blank or a thin coloured bar. '
          'On a real device in profile/release build, you will see live bar graphs.',
          style: tt.bodyMedium,
        ),
        const SizedBox(height: 16),
        // ---- Actual PerformanceOverlay in a Stack ----
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cs.outline),
          ),
          clipBehavior: Clip.antiAlias,
          height: 220,
          child: Stack(
            children: <Widget>[
              Container(
                color: cs.surfaceContainerHighest,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.play_arrow_outlined, size: 40, color: cs.primary),
                      const SizedBox(height: 8),
                      Text(
                        'App content layer',
                        style: tt.bodyLarge?.copyWith(color: cs.primary),
                      ),
                      Text(
                        'PerformanceOverlay renders above this',
                        style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ),
              ValueListenableBuilder<int>(
                valueListenable: _optionsMask,
                builder: (BuildContext ctx, int mask, Widget? _) {
                  return PerformanceOverlay(optionsMask: mask);
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Note: blank in sandbox — real graphs appear in profile/release.',
          style: tt.bodySmall?.copyWith(
            color: cs.onSurfaceVariant,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 20),
        // ---- static constants ----
        _SectionCard(
          icon: Icons.flag_outlined,
          title: 'Static Int Constants',
          color: cs.primaryContainer,
          iconColor: cs.primary,
          child: Column(
            children: <Widget>[
              _ConstantRow(
                name: 'kDisplayRasterizerStatistics',
                value: _kDisplayRasterizerStatistics,
                description: 'Show raster thread numeric text stats',
              ),
              _ConstantRow(
                name: 'kVisualizeRasterizerStatistics',
                value: _kVisualizeRasterizerStatistics,
                description: 'Show raster thread bar graph',
              ),
              _ConstantRow(
                name: 'kDisplayEngineStatistics',
                value: _kDisplayEngineStatistics,
                description: 'Show UI thread numeric text stats',
              ),
              _ConstantRow(
                name: 'kVisualizeEngineStatistics',
                value: _kVisualizeEngineStatistics,
                description: 'Show UI thread bar graph',
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // ---- optionsMask selector ----
        _SectionCard(
          icon: Icons.tune,
          title: 'Live optionsMask: adjust above overlay',
          color: cs.secondaryContainer,
          iconColor: cs.secondary,
          child: ValueListenableBuilder<int>(
            valueListenable: _optionsMask,
            builder: (BuildContext ctx, int mask, Widget? _) {
              return Column(
                children: <Widget>[
                  _MaskToggle(
                    label: 'kDisplayRasterizerStatistics',
                    bit: _kDisplayRasterizerStatistics,
                    mask: mask,
                    onChanged: (int newMask) => _optionsMask.value = newMask,
                  ),
                  _MaskToggle(
                    label: 'kVisualizeRasterizerStatistics',
                    bit: _kVisualizeRasterizerStatistics,
                    mask: mask,
                    onChanged: (int newMask) => _optionsMask.value = newMask,
                  ),
                  _MaskToggle(
                    label: 'kDisplayEngineStatistics',
                    bit: _kDisplayEngineStatistics,
                    mask: mask,
                    onChanged: (int newMask) => _optionsMask.value = newMask,
                  ),
                  _MaskToggle(
                    label: 'kVisualizeEngineStatistics',
                    bit: _kVisualizeEngineStatistics,
                    mask: mask,
                    onChanged: (int newMask) => _optionsMask.value = newMask,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      const Text('optionsMask = ', style: TextStyle(fontFamily: 'monospace')),
                      Text(
                        '$mask  (0x${mask.toRadixString(16).toUpperCase().padLeft(2, "0")})',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w700,
                          color: Theme.of(ctx).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ConstantRow extends StatelessWidget {
  const _ConstantRow({
    required this.name,
    required this.value,
    required this.description,
  });
  final String name;
  final int value;
  final String description;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: cs.primary,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '$value',
              style: TextStyle(
                color: cs.onPrimary,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(name,
                    style: const TextStyle(
                        fontFamily: 'monospace', fontWeight: FontWeight.w600, fontSize: 12)),
                Text(description, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MaskToggle extends StatelessWidget {
  const _MaskToggle({
    required this.label,
    required this.bit,
    required this.mask,
    required this.onChanged,
  });
  final String label;
  final int bit;
  final int mask;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final bool active = (mask & bit) != 0;
    return SwitchListTile(
      dense: true,
      title: Text(label, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
      subtitle: Text('bit value: $bit'),
      value: active,
      onChanged: (bool v) => onChanged(v ? mask | bit : mask & ~bit),
    );
  }
}

// ===========================================================================
// TAB 3 — Simulated Frame Time Graph (CustomPainter)
// ===========================================================================
class _FrameGraphTab extends StatelessWidget {
  const _FrameGraphTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _HeaderChip(label: 'Simulated Frame Time Graph', icon: Icons.bar_chart),
        const SizedBox(height: 12),
        Text(
          'A realistic simulation of what PerformanceOverlay displays: '
          'two rows of bars — top row for the GPU/Raster thread, bottom row for the UI thread. '
          'The red horizontal line marks the 16.6 ms budget.',
          style: tt.bodyMedium,
        ),
        const SizedBox(height: 16),
        // GPU thread graph
        _GraphCard(
          title: 'GPU / Raster Thread',
          color: cs.tertiary,
          budgetColor: cs.error,
          frameTimes: const <double>[
            4.2, 5.1, 6.3, 14.8, 18.2, 5.6, 7.1, 4.9,
            6.2, 22.4, 5.3, 4.8, 6.9, 7.2, 5.1, 4.5,
            13.1, 6.4, 5.8, 5.0, 4.7, 6.1, 7.3, 19.5,
            5.2, 4.9, 6.0, 5.7, 4.3, 5.5,
          ],
        ),
        const SizedBox(height: 16),
        // UI thread graph
        _GraphCard(
          title: 'UI Thread (Dart)',
          color: cs.secondary,
          budgetColor: cs.error,
          frameTimes: const <double>[
            3.1, 3.8, 4.2, 3.9, 4.5, 12.3, 3.7, 4.0,
            3.5, 4.1, 20.1, 3.9, 3.6, 4.3, 4.0, 3.8,
            4.2, 3.5, 3.9, 4.6, 3.7, 4.0, 3.8, 11.2,
            3.6, 4.1, 3.9, 4.4, 3.8, 4.0,
          ],
        ),
        const SizedBox(height: 20),
        // Legend
        _SectionCard(
          icon: Icons.legend_toggle,
          title: 'Legend',
          color: cs.primaryContainer,
          iconColor: cs.primary,
          child: Column(
            children: <Widget>[
              _LegendRow(color: cs.tertiary, label: 'GPU/Raster thread bar'),
              _LegendRow(color: cs.secondary, label: 'UI thread bar'),
              _LegendRow(color: cs.error, label: '16.6 ms budget line (60 fps)'),
              _LegendRow(color: cs.error.withAlpha(80), label: 'Bars above budget line = jank!'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _SectionCard(
          icon: Icons.info_outline,
          title: 'Reading the Graph',
          color: cs.secondaryContainer,
          iconColor: cs.secondary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _BulletItem(
                text: 'Each bar = one frame\'s work on that thread.',
                icon: Icons.view_column_outlined,
              ),
              _BulletItem(
                text: 'Bar height proportional to milliseconds taken.',
                icon: Icons.height,
              ),
              _BulletItem(
                text: 'Bars touching or crossing the red line = dropped frame.',
                icon: Icons.warning_amber_outlined,
              ),
              _BulletItem(
                text: 'Both threads must finish within 16.6 ms for a smooth frame.',
                icon: Icons.timer_outlined,
              ),
              _BulletItem(
                text: 'Occasional spikes are normal; sustained spikes need investigation.',
                icon: Icons.trending_up,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GraphCard extends StatelessWidget {
  const _GraphCard({
    required this.title,
    required this.color,
    required this.budgetColor,
    required this.frameTimes,
  });
  final String title;
  final Color color;
  final Color budgetColor;
  final List<double> frameTimes;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outline.withAlpha(100)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(fontWeight: FontWeight.w700, color: color)),
          const SizedBox(height: 8),
          SizedBox(
            height: 100,
            child: CustomPaint(
              painter: _FrameBarPainter(
                frameTimes: frameTimes,
                barColor: color,
                budgetColor: budgetColor,
                maxMs: 30.0,
                budgetMs: 16.6,
              ),
              child: const SizedBox.expand(),
            ),
          ),
        ],
      ),
    );
  }
}

class _FrameBarPainter extends CustomPainter {
  const _FrameBarPainter({
    required this.frameTimes,
    required this.barColor,
    required this.budgetColor,
    required this.maxMs,
    required this.budgetMs,
  });
  final List<double> frameTimes;
  final Color barColor;
  final Color budgetColor;
  final double maxMs;
  final double budgetMs;

  @override
  void paint(Canvas canvas, Size size) {
    final int count = frameTimes.length;
    if (count == 0) return;
    final double barWidth = (size.width / count) * 0.75;
    final double gap = (size.width / count) * 0.25;
    final double budgetY = size.height * (1.0 - budgetMs / maxMs);

    // Draw bars
    for (int i = 0; i < count; i++) {
      final double t = frameTimes[i].clamp(0.0, maxMs);
      final double barHeight = size.height * (t / maxMs);
      final double x = i * (barWidth + gap);
      final double y = size.height - barHeight;
      final bool overBudget = frameTimes[i] > budgetMs;
      final Paint barPaint = Paint()
        ..color = overBudget ? budgetColor.withAlpha(200) : barColor.withAlpha(200)
        ..style = PaintingStyle.fill;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, barWidth, barHeight),
          const Radius.circular(2),
        ),
        barPaint,
      );
    }

    // Draw budget line
    final Paint linePaint = Paint()
      ..color = budgetColor
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(0, budgetY), Offset(size.width, budgetY), linePaint);

    // Label for budget line
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: '16.6 ms',
        style: TextStyle(
          color: budgetColor,
          fontSize: 9,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(4, budgetY - tp.height - 1));
  }

  @override
  bool shouldRepaint(_FrameBarPainter old) =>
      old.frameTimes != frameTimes ||
      old.barColor != barColor ||
      old.budgetMs != budgetMs;
}

class _LegendRow extends StatelessWidget {
  const _LegendRow({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: <Widget>[
          Container(width: 16, height: 16, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3))),
          const SizedBox(width: 10),
          Expanded(child: Text(label, style: Theme.of(context).textTheme.bodySmall)),
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 4 — optionsMask Bit Flags
// ===========================================================================
class _FlagsTab extends StatelessWidget {
  const _FlagsTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _HeaderChip(label: 'optionsMask Bit Flags', icon: Icons.tune),
        const SizedBox(height: 12),
        Text(
          'The four static integer constants can be combined with bitwise OR (|) to produce '
          'the optionsMask. Each flag independently enables one aspect of the overlay.',
          style: tt.bodyMedium,
        ),
        const SizedBox(height: 16),
        // 4 flag cards
        _FlagCard(
          constant: 'kDisplayRasterizerStatistics',
          value: _kDisplayRasterizerStatistics,
          hex: '0x01',
          enables: 'Numeric text display for the GPU/Raster thread. Shows the 90th and 99th percentile frame times in milliseconds.',
          color: cs.primaryContainer,
          iconColor: cs.primary,
        ),
        const SizedBox(height: 12),
        _FlagCard(
          constant: 'kVisualizeRasterizerStatistics',
          value: _kVisualizeRasterizerStatistics,
          hex: '0x02',
          enables: 'Bar graph visualization for the GPU/Raster thread. Each bar represents one frame rendered to the GPU.',
          color: cs.secondaryContainer,
          iconColor: cs.secondary,
        ),
        const SizedBox(height: 12),
        _FlagCard(
          constant: 'kDisplayEngineStatistics',
          value: _kDisplayEngineStatistics,
          hex: '0x04',
          enables: 'Numeric text display for the UI/Engine thread. Shows how long Dart code and layout took for each frame.',
          color: cs.tertiaryContainer,
          iconColor: cs.tertiary,
        ),
        const SizedBox(height: 12),
        _FlagCard(
          constant: 'kVisualizeEngineStatistics',
          value: _kVisualizeEngineStatistics,
          hex: '0x08',
          enables: 'Bar graph visualization for the UI/Engine thread. Mirrors the raster graph but for Dart/layout work.',
          color: cs.errorContainer,
          iconColor: cs.error,
        ),
        const SizedBox(height: 20),
        // Bitmask calculator
        _SectionCard(
          icon: Icons.calculate_outlined,
          title: 'Bitmask Calculator',
          color: cs.primaryContainer,
          iconColor: cs.primary,
          child: ValueListenableBuilder<int>(
            valueListenable: _optionsMask,
            builder: (BuildContext ctx, int mask, Widget? _) {
              final List<_BitFlagInfo> flags = <_BitFlagInfo>[
                _BitFlagInfo(
                  name: 'kDisplayRasterizerStatistics',
                  bit: _kDisplayRasterizerStatistics,
                ),
                _BitFlagInfo(
                  name: 'kVisualizeRasterizerStatistics',
                  bit: _kVisualizeRasterizerStatistics,
                ),
                _BitFlagInfo(
                  name: 'kDisplayEngineStatistics',
                  bit: _kDisplayEngineStatistics,
                ),
                _BitFlagInfo(
                  name: 'kVisualizeEngineStatistics',
                  bit: _kVisualizeEngineStatistics,
                ),
              ];
              final List<String> active = flags
                  .where((f) => (mask & f.bit) != 0)
                  .map((f) => 'PerformanceOverlay.${f.name}')
                  .toList();
              final String expr = active.isEmpty ? '0' : active.join('\n  | ');
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Toggle flags in the "Real API" tab to update:',
                    style: tt.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  _MonoBox(text: 'optionsMask:\n  $expr\n= $mask (0x${mask.toRadixString(16).toUpperCase().padLeft(2, "0")})'),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        _SectionCard(
          icon: Icons.insights,
          title: 'Common Presets',
          color: cs.secondaryContainer,
          iconColor: cs.secondary,
          child: Column(
            children: <Widget>[
              _PresetRow(
                label: 'Everything (text + graphs)',
                mask: _kDisplayRasterizerStatistics |
                    _kVisualizeRasterizerStatistics |
                    _kDisplayEngineStatistics |
                    _kVisualizeEngineStatistics,
              ),
              _PresetRow(
                label: 'Text stats only',
                mask: _kDisplayRasterizerStatistics |
                    _kDisplayEngineStatistics,
              ),
              _PresetRow(
                label: 'Graphs only',
                mask: _kVisualizeRasterizerStatistics |
                    _kVisualizeEngineStatistics,
              ),
              _PresetRow(label: 'GPU raster only', mask: _kDisplayRasterizerStatistics),
              _PresetRow(label: 'UI thread only', mask: _kDisplayEngineStatistics),
              const _PresetRow(label: 'Off / no overlay', mask: 0),
            ],
          ),
        ),
      ],
    );
  }
}

class _BitFlagInfo {
  const _BitFlagInfo({required this.name, required this.bit});
  final String name;
  final int bit;
}

class _FlagCard extends StatelessWidget {
  const _FlagCard({
    required this.constant,
    required this.value,
    required this.hex,
    required this.enables,
    required this.color,
    required this.iconColor,
  });
  final String constant;
  final int value;
  final String hex;
  final String enables;
  final Color color;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$value  $hex',
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'PerformanceOverlay.$constant',
            style: tt.labelMedium?.copyWith(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              color: iconColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(enables, style: tt.bodySmall),
        ],
      ),
    );
  }
}

class _PresetRow extends StatelessWidget {
  const _PresetRow({required this.label, required this.mask});
  final String label;
  final int mask;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: cs.primary.withAlpha(30),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'mask=$mask',
              style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(label, style: Theme.of(context).textTheme.bodySmall)),
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 5 — MaterialApp showPerformanceOverlay
// ===========================================================================
class _ShowOverlayTab extends StatelessWidget {
  const _ShowOverlayTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _HeaderChip(label: 'MaterialApp.showPerformanceOverlay', icon: Icons.toggle_on_outlined),
        const SizedBox(height: 12),
        Text(
          'The easiest way to enable PerformanceOverlay globally is via the MaterialApp '
          'constructor parameter showPerformanceOverlay. When true, Flutter wraps the '
          'entire app in a PerformanceOverlay with full statistics enabled.',
          style: tt.bodyMedium,
        ),
        const SizedBox(height: 16),
        _SectionCard(
          icon: Icons.code,
          title: 'Minimal Integration Snippet',
          color: cs.primaryContainer,
          iconColor: cs.primary,
          child: _MonoBox(
            text: 'MaterialApp(\n'
                '  title: \'My App\',\n'
                '  showPerformanceOverlay: true, // <-- enable\n'
                '  theme: ThemeData(useMaterial3: true),\n'
                '  home: const MyHomePage(),\n'
                ')',
          ),
        ),
        const SizedBox(height: 16),
        _SectionCard(
          icon: Icons.toggle_on_outlined,
          title: 'Runtime Toggle via ValueNotifier',
          color: cs.secondaryContainer,
          iconColor: cs.secondary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'In development it\'s useful to toggle the overlay without restarting. '
                'Using a top-level ValueNotifier fed into showPerformanceOverlay achieves this:',
                style: tt.bodySmall,
              ),
              const SizedBox(height: 10),
              _MonoBox(
                text: '// top-level\n'
                    'final ValueNotifier<bool> showOverlay =\n'
                    '    ValueNotifier(false);\n\n'
                    '// in your build\n'
                    'ValueListenableBuilder<bool>(\n'
                    '  valueListenable: showOverlay,\n'
                    '  builder: (ctx, show, _) => MaterialApp(\n'
                    '    showPerformanceOverlay: show,\n'
                    '    home: const MyHome(),\n'
                    '  ),\n'
                    ')',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Live toggle demo
        _SectionCard(
          icon: Icons.play_arrow_outlined,
          title: 'Live Toggle Demo',
          color: cs.tertiaryContainer,
          iconColor: cs.tertiary,
          child: ValueListenableBuilder<bool>(
            valueListenable: _showOverlay,
            builder: (BuildContext ctx, bool show, Widget? _) {
              return Column(
                children: <Widget>[
                  SwitchListTile(
                    title: const Text('showPerformanceOverlay'),
                    subtitle: Text(show ? 'enabled — overlay active' : 'disabled — overlay hidden'),
                    value: show,
                    onChanged: (bool v) => _showOverlay.value = v,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: cs.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: cs.outline.withAlpha(80)),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: Text(
                            show ? 'Overlay ON' : 'Overlay OFF',
                            style: tt.bodyLarge?.copyWith(
                              color: show ? cs.tertiary : cs.onSurfaceVariant,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (show)
                          PerformanceOverlay(
                            optionsMask:
                                _kDisplayRasterizerStatistics |
                                _kDisplayEngineStatistics,
                          ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        _SectionCard(
          icon: Icons.compare_outlined,
          title: 'showPerformanceOverlay vs Manual Stack',
          color: cs.primaryContainer,
          iconColor: cs.primary,
          child: Table(
            border: TableBorder.all(color: cs.outline.withAlpha(80)),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(3),
            },
            children: <TableRow>[
              TableRow(
                decoration: BoxDecoration(color: cs.primary.withAlpha(30)),
                children: <Widget>[
                  _TableCell(text: 'Aspect', header: true),
                  _TableCell(text: 'showPerformanceOverlay', header: true),
                  _TableCell(text: 'Manual Stack', header: true),
                ],
              ),
              const TableRow(children: <Widget>[
                _TableCell(text: 'Scope'),
                _TableCell(text: 'Entire app'),
                _TableCell(text: 'Specific subtree'),
              ]),
              const TableRow(children: <Widget>[
                _TableCell(text: 'optionsMask'),
                _TableCell(text: 'All flags enabled'),
                _TableCell(text: 'Fully customizable'),
              ]),
              const TableRow(children: <Widget>[
                _TableCell(text: 'Use case'),
                _TableCell(text: 'Quick global check'),
                _TableCell(text: 'Targeted debugging'),
              ]),
              const TableRow(children: <Widget>[
                _TableCell(text: 'Lines of code'),
                _TableCell(text: '1 param'),
                _TableCell(text: '~5 lines'),
              ]),
            ],
          ),
        ),
      ],
    );
  }
}

class _TableCell extends StatelessWidget {
  const _TableCell({required this.text, this.header = false});
  final String text;
  final bool header;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: header ? FontWeight.w700 : FontWeight.normal,
            ),
      ),
    );
  }
}

// ===========================================================================
// TAB 6 — 60fps Budget Diagram (CustomPainter)
// ===========================================================================
class _BudgetDiagramTab extends StatelessWidget {
  const _BudgetDiagramTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _HeaderChip(label: '60fps Budget Timeline', icon: Icons.timeline),
        const SizedBox(height: 12),
        Text(
          'A horizontal timeline from 0 to 33 ms showing the 60fps and 30fps budget thresholds. '
          'The slider below adjusts a "current frame time" bar to explore different scenarios.',
          style: tt.bodyMedium,
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cs.outline.withAlpha(80)),
          ),
          padding: const EdgeInsets.all(16),
          child: ValueListenableBuilder<double>(
            valueListenable: _budgetSlider,
            builder: (BuildContext ctx, double ms, Widget? _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Frame time: ', style: tt.labelMedium),
                      Text(
                        '${ms.toStringAsFixed(1)} ms',
                        style: tt.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: ms > 33.3
                              ? cs.error
                              : ms > 16.6
                                  ? cs.secondary
                                  : cs.tertiary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        ms > 33.3
                            ? '(sub 30fps — very janky!)'
                            : ms > 16.6
                                ? '(30–60fps — somewhat janky)'
                                : '(60fps — smooth!)',
                        style: tt.bodySmall?.copyWith(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 80,
                    child: CustomPaint(
                      painter: _BudgetTimelinePainter(
                        currentMs: ms,
                        colorScheme: cs,
                      ),
                      child: const SizedBox.expand(),
                    ),
                  ),
                  Slider(
                    value: ms,
                    min: 1.0,
                    max: 40.0,
                    divisions: 390,
                    label: '${ms.toStringAsFixed(1)} ms',
                    onChanged: (double v) => _budgetSlider.value = v,
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        _SectionCard(
          icon: Icons.speed,
          title: 'Frame Rate Reference',
          color: cs.primaryContainer,
          iconColor: cs.primary,
          child: Column(
            children: <Widget>[
              _FrameRateRow(fps: 120, ms: 8.3, color: cs.tertiary),
              _FrameRateRow(fps: 90, ms: 11.1, color: cs.primary),
              _FrameRateRow(fps: 60, ms: 16.6, color: cs.secondary),
              _FrameRateRow(fps: 30, ms: 33.3, color: cs.error),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _SectionCard(
          icon: Icons.devices_outlined,
          title: 'Device Refresh Rates',
          color: cs.secondaryContainer,
          iconColor: cs.secondary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _BulletItem(
                text: 'Standard LCD phones: 60 Hz → 16.6 ms budget.',
                icon: Icons.phone_android,
              ),
              _BulletItem(
                text: 'High-end phones (ProMotion, LTPO): up to 120 Hz → 8.3 ms budget.',
                icon: Icons.phone_iphone,
              ),
              _BulletItem(
                text: 'Budget phones may cap at 60 Hz or lower.',
                icon: Icons.smartphone_outlined,
              ),
              _BulletItem(
                text: 'Flutter auto-adapts to device\'s vsync via Ticker.',
                icon: Icons.sync,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _SectionCard(
          icon: Icons.architecture,
          title: 'Frame Pipeline: Anatomy of 16.6 ms',
          color: cs.tertiaryContainer,
          iconColor: cs.tertiary,
          child: Column(
            children: <Widget>[
              _PipelineStep(step: '1', label: 'Vsync signal', ms: '~0 ms', color: cs.primary),
              _PipelineStep(step: '2', label: 'Build (Dart widgets)', ms: '~2–4 ms', color: cs.secondary),
              _PipelineStep(step: '3', label: 'Layout (constraints)', ms: '~1–3 ms', color: cs.tertiary),
              _PipelineStep(step: '4', label: 'Paint (layer tree)', ms: '~1–2 ms', color: cs.primary),
              _PipelineStep(step: '5', label: 'Composite & rasterize', ms: '~4–8 ms', color: cs.secondary),
              _PipelineStep(step: '6', label: 'GPU submit & display', ms: '~1–2 ms', color: cs.tertiary),
            ],
          ),
        ),
      ],
    );
  }
}

class _BudgetTimelinePainter extends CustomPainter {
  const _BudgetTimelinePainter({
    required this.currentMs,
    required this.colorScheme,
  });
  final double currentMs;
  final ColorScheme colorScheme;

  @override
  void paint(Canvas canvas, Size size) {
    const double maxMs = 40.0;
    final double ms60 = 16.6 / maxMs;
    final double ms30 = 33.3 / maxMs;
    final double current = (currentMs / maxMs).clamp(0.0, 1.0);

    // Background track
    final Paint trackPaint = Paint()
      ..color = colorScheme.surfaceContainerHighest
      ..style = PaintingStyle.fill;
    final double trackY = size.height * 0.5;
    final double trackH = 24.0;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, trackY - trackH / 2, size.width, trackH),
        const Radius.circular(6),
      ),
      trackPaint,
    );

    // Current frame fill
    final Color fillColor = currentMs > 33.3
        ? colorScheme.error
        : currentMs > 16.6
            ? colorScheme.secondary
            : colorScheme.tertiary;
    final Paint fillPaint = Paint()
      ..color = fillColor.withAlpha(180)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, trackY - trackH / 2, size.width * current, trackH),
        const Radius.circular(6),
      ),
      fillPaint,
    );

    // 16.6ms line
    final Paint line60Paint = Paint()
      ..color = colorScheme.error
      ..strokeWidth = 2.0;
    final double x60 = size.width * ms60;
    canvas.drawLine(Offset(x60, 0), Offset(x60, size.height), line60Paint);

    // 33.3ms line
    final Paint line30Paint = Paint()
      ..color = colorScheme.secondary
      ..strokeWidth = 2.0;
    final double x30 = size.width * ms30;
    canvas.drawLine(Offset(x30, 0), Offset(x30, size.height), line30Paint);

    // Labels
    void drawLabel(String text, double x, Color color, bool above) {
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.w700),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      final double y = above ? 2 : size.height - tp.height - 2;
      tp.paint(canvas, Offset(x + 3, y));
    }

    drawLabel('60fps\n16.6ms', x60, colorScheme.error, true);
    drawLabel('30fps\n33.3ms', x30, colorScheme.secondary, true);

    // Tick marks 0,10,20,30,40
    final Paint tickPaint = Paint()
      ..color = colorScheme.onSurfaceVariant.withAlpha(100)
      ..strokeWidth = 1.0;
    for (int t = 0; t <= 40; t += 10) {
      final double x = size.width * (t / maxMs);
      canvas.drawLine(Offset(x, trackY + trackH / 2), Offset(x, trackY + trackH / 2 + 6), tickPaint);
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: '${t}ms',
          style: TextStyle(
            color: colorScheme.onSurfaceVariant.withAlpha(160),
            fontSize: 8,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(x - tp.width / 2, trackY + trackH / 2 + 8));
    }
  }

  @override
  bool shouldRepaint(_BudgetTimelinePainter old) => old.currentMs != currentMs;
}

class _FrameRateRow extends StatelessWidget {
  const _FrameRateRow({required this.fps, required this.ms, required this.color});
  final int fps;
  final double ms;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 60,
            child: Text(
              '$fps Hz',
              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: ms / 40.0,
                color: color,
                backgroundColor: color.withAlpha(30),
                minHeight: 12,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 50,
            child: Text(
              '$ms ms',
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _PipelineStep extends StatelessWidget {
  const _PipelineStep({
    required this.step,
    required this.label,
    required this.ms,
    required this.color,
  });
  final String step;
  final String label;
  final String ms;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 12,
            backgroundColor: color,
            child: Text(
              step,
              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodySmall),
          ),
          Text(
            ms,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 7 — Jank Simulation
// ===========================================================================
class _JankSimTab extends StatelessWidget {
  const _JankSimTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _HeaderChip(label: 'Jank Simulation', icon: Icons.warning_amber_outlined),
        const SizedBox(height: 12),
        Text(
          'A deliberately heavy CustomPainter simulates the kind of work that causes frame drops. '
          'PerformanceOverlay is placed on top to capture the raster spike. '
          'Toggle "Enable jank" to see the simulated graph bars grow.',
          style: tt.bodyMedium,
        ),
        const SizedBox(height: 16),
        ValueListenableBuilder<bool>(
          valueListenable: _jankEnabled,
          builder: (BuildContext ctx, bool janky, Widget? _) {
            return Column(
              children: <Widget>[
                SwitchListTile.adaptive(
                  title: const Text('Enable jank simulation'),
                  subtitle: Text(janky
                      ? 'Heavy painter active — expect spikes'
                      : 'Light painter — smooth frames'),
                  value: janky,
                  onChanged: (bool v) => _jankEnabled.value = v,
                ),
                const SizedBox(height: 12),
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: cs.outline),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: <Widget>[
                      SizedBox.expand(
                        child: CustomPaint(
                          painter: _JankPainter(janky: janky, colorScheme: cs),
                        ),
                      ),
                      PerformanceOverlay(
                        optionsMask:
                            _kDisplayRasterizerStatistics |
                            _kVisualizeRasterizerStatistics |
                            _kDisplayEngineStatistics |
                            _kVisualizeEngineStatistics,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  janky
                      ? 'Heavy computation is running — PerformanceOverlay above shows the spike.'
                      : 'Smooth mode — PerformanceOverlay above shows near-zero bars.',
                  style: tt.bodySmall?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: janky ? cs.error : cs.tertiary,
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 20),
        // Simulated jank graph comparison
        _SectionCard(
          icon: Icons.compare,
          title: 'Simulated: Smooth vs Janky Frame Profile',
          color: cs.primaryContainer,
          iconColor: cs.primary,
          child: Column(
            children: <Widget>[
              Text('Smooth — all bars below 16.6ms budget line:', style: tt.labelMedium),
              const SizedBox(height: 6),
              SizedBox(
                height: 70,
                child: CustomPaint(
                  painter: _FrameBarPainter(
                    frameTimes: const <double>[
                      3.1, 3.8, 4.2, 3.9, 4.5, 3.7, 4.0, 3.5,
                      4.1, 3.9, 3.6, 4.3, 4.0, 3.8, 4.2, 3.5,
                    ],
                    barColor: cs.tertiary,
                    budgetColor: cs.error,
                    maxMs: 30,
                    budgetMs: 16.6,
                  ),
                  child: const SizedBox.expand(),
                ),
              ),
              const SizedBox(height: 16),
              Text('Janky — multiple bars exceed budget:', style: tt.labelMedium),
              const SizedBox(height: 6),
              SizedBox(
                height: 70,
                child: CustomPaint(
                  painter: _FrameBarPainter(
                    frameTimes: const <double>[
                      3.8, 4.2, 24.1, 4.5, 3.9, 32.5, 4.0, 3.5,
                      18.3, 4.1, 3.9, 28.4, 4.0, 3.8, 4.2, 22.7,
                    ],
                    barColor: cs.tertiary,
                    budgetColor: cs.error,
                    maxMs: 40,
                    budgetMs: 16.6,
                  ),
                  child: const SizedBox.expand(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _SectionCard(
          icon: Icons.search,
          title: 'Common Jank Sources',
          color: cs.errorContainer,
          iconColor: cs.error,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _BulletItem(
                text: 'Synchronous network/file I/O on the UI thread.',
                icon: Icons.wifi_off_outlined,
              ),
              _BulletItem(
                text: 'Excessive widget rebuilds (unnecessary setState).',
                icon: Icons.refresh,
              ),
              _BulletItem(
                text: 'Heavy CustomPainter computations not cached.',
                icon: Icons.brush_outlined,
              ),
              _BulletItem(
                text: 'Large image decode on raster thread (unsized images).',
                icon: Icons.image_outlined,
              ),
              _BulletItem(
                text: 'Complex path/shadow rendering on GPU thread.',
                icon: Icons.blur_on_outlined,
              ),
              _BulletItem(
                text: 'Unoptimized animation curves (many objects).',
                icon: Icons.animation,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _JankPainter extends CustomPainter {
  const _JankPainter({required this.janky, required this.colorScheme});
  final bool janky;
  final ColorScheme colorScheme;

  @override
  void paint(Canvas canvas, Size size) {
    if (janky) {
      // Intentionally heavy loop to simulate work
      double sum = 0;
      for (int i = 0; i < 50000; i++) {
        sum += i * 0.001;
      }
      final Paint p = Paint()
        ..color = colorScheme.errorContainer
        ..style = PaintingStyle.fill;
      canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), p);
      final Paint lp = Paint()
        ..color = colorScheme.error.withAlpha(80)
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;
      for (int i = 0; i < 60; i++) {
        final double x = (size.width / 60) * i + sum * 0;
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), lp);
      }
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: 'JANK — heavy computation active',
          style: TextStyle(
            color: colorScheme.error,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(size.width / 2 - tp.width / 2, size.height / 2 - tp.height / 2));
    } else {
      final Paint p = Paint()
        ..color = colorScheme.tertiaryContainer
        ..style = PaintingStyle.fill;
      canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), p);
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: 'Smooth — minimal work',
          style: TextStyle(
            color: colorScheme.tertiary,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(size.width / 2 - tp.width / 2, size.height / 2 - tp.height / 2));
    }
  }

  @override
  bool shouldRepaint(_JankPainter old) => old.janky != janky;
}

// ===========================================================================
// TAB 8 — GPU vs UI Threads
// ===========================================================================
class _ThreadsTab extends StatelessWidget {
  const _ThreadsTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _HeaderChip(label: 'GPU vs UI Threads', icon: Icons.device_hub),
        const SizedBox(height: 12),
        Text(
          'Flutter uses two primary threads for rendering. '
          'Understanding them is essential for diagnosing which bottleneck is causing jank.',
          style: tt.bodyMedium,
        ),
        const SizedBox(height: 16),
        // Thread diagram custom painter
        Container(
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cs.outline.withAlpha(80)),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Text('Frame Rendering Pipeline — Two-Thread Model',
                  style: tt.labelLarge?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 16),
              SizedBox(
                height: 160,
                child: CustomPaint(
                  painter: _ThreadDiagramPainter(colorScheme: cs),
                  child: const SizedBox.expand(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // UI thread card
        _SectionCard(
          icon: Icons.code,
          title: 'UI Thread (Engine / Dart Thread)',
          color: cs.secondaryContainer,
          iconColor: cs.secondary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _BulletItem(text: 'Runs all Dart code: build(), layout, paint calls.', icon: Icons.terminal),
              _BulletItem(text: 'Executes setState, notifyListeners, streams.', icon: Icons.refresh),
              _BulletItem(text: 'Produces a layer tree (RenderObject scene).', icon: Icons.account_tree_outlined),
              _BulletItem(text: 'Sends scene to raster thread when done.', icon: Icons.send_outlined),
              _BulletItem(text: 'Blocked by: heavy Dart computation, synchronous I/O.', icon: Icons.block_outlined),
              const SizedBox(height: 8),
              _MonoBox(text: '// PerformanceOverlay top row = UI thread\n'
                  'kDisplayEngineStatistics\nkVisualizeEngineStatistics'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Raster thread card
        _SectionCard(
          icon: Icons.memory_outlined,
          title: 'GPU / Raster Thread',
          color: cs.tertiaryContainer,
          iconColor: cs.tertiary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _BulletItem(text: 'Receives scene from UI thread.', icon: Icons.download_outlined),
              _BulletItem(text: 'Runs Skia (or Impeller) rasterization commands.', icon: Icons.brush_outlined),
              _BulletItem(text: 'Uploads textures and issues draw calls to GPU.', icon: Icons.graphic_eq),
              _BulletItem(text: 'Blocked by: shader compilation, heavy paint, big images.', icon: Icons.block_outlined),
              _BulletItem(text: 'Shader jank: first frame after cold start often spikes.', icon: Icons.bolt_outlined),
              const SizedBox(height: 8),
              _MonoBox(text: '// PerformanceOverlay bottom row = raster thread\n'
                  'kDisplayRasterizerStatistics\nkVisualizeRasterizerStatistics'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _SectionCard(
          icon: Icons.compare_arrows,
          title: 'Thread Interaction',
          color: cs.primaryContainer,
          iconColor: cs.primary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Both threads must finish within the frame budget. '
                'If either thread takes longer than 16.6 ms, the frame is dropped — '
                'regardless of how fast the other thread is.',
                style: tt.bodySmall,
              ),
              const SizedBox(height: 8),
              _MonoBox(
                text: 'frame_time = max(ui_thread_time, raster_thread_time)\n'
                    'smooth     = frame_time < 16.6ms',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Impeller note
        _SectionCard(
          icon: Icons.rocket_launch_outlined,
          title: 'Skia vs Impeller',
          color: cs.secondaryContainer,
          iconColor: cs.secondary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _BulletItem(
                text: 'Skia: classic GPU backend, requires runtime shader compilation.',
                icon: Icons.layers_outlined,
              ),
              _BulletItem(
                text: 'Impeller: Flutter\'s new backend, pre-compiles shaders at build time → no jank spikes.',
                icon: Icons.rocket_launch_outlined,
              ),
              _BulletItem(
                text: 'Impeller is default on iOS (Flutter 3.10+), opt-in on Android.',
                icon: Icons.phone_iphone,
              ),
              _BulletItem(
                text: 'PerformanceOverlay works with both backends.',
                icon: Icons.check_circle_outline,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ThreadDiagramPainter extends CustomPainter {
  const _ThreadDiagramPainter({required this.colorScheme});
  final ColorScheme colorScheme;

  @override
  void paint(Canvas canvas, Size size) {
    final double rowH = 40.0;
    final double rowPad = 20.0;
    final double uiY = rowPad;
    final double rasterY = uiY + rowH + rowPad;
    final double arrowY = rasterY + rowH + 10;

    // Lane backgrounds
    final Paint uiPaint = Paint()
      ..color = colorScheme.secondary.withAlpha(40)
      ..style = PaintingStyle.fill;
    final Paint rasterPaint = Paint()
      ..color = colorScheme.tertiary.withAlpha(40)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(0, uiY, size.width, rowH), const Radius.circular(8)),
      uiPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(0, rasterY, size.width, rowH), const Radius.circular(8)),
      rasterPaint,
    );

    // Lane labels
    void drawLane(String label, double y, Color color) {
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: label,
          style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w700),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(8, y + rowH / 2 - tp.height / 2));
    }

    drawLane('UI Thread', uiY, colorScheme.secondary);
    drawLane('Raster Thread', rasterY, colorScheme.tertiary);

    // Frame blocks
    final List<double> blockWidths = <double>[50, 55, 48, 60, 52, 58, 46];
    double x = 120;
    for (final double w in blockWidths) {
      if (x + w > size.width - 8) break;
      final Paint uiBlock = Paint()..color = colorScheme.secondary.withAlpha(180);
      final Paint rasterBlock = Paint()..color = colorScheme.tertiary.withAlpha(180);
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(x + 2, uiY + 4, w - 4, rowH - 8), const Radius.circular(4)),
        uiBlock,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(x + 2, rasterY + 4, w - 4, rowH - 8), const Radius.circular(4)),
        rasterBlock,
      );
      // Arrow from UI to Raster
      final Paint arrowPaint = Paint()
        ..color = colorScheme.onSurface.withAlpha(80)
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke;
      final double midX = x + w / 2;
      canvas.drawLine(
        Offset(midX, uiY + rowH - 4),
        Offset(midX, rasterY + 4),
        arrowPaint,
      );
      x += w + 4;
    }

    // Bottom label
    final TextPainter bottomTp = TextPainter(
      text: TextSpan(
        text: 'Each block = one frame. UI completes → sends scene to Raster.',
        style: TextStyle(
          color: colorScheme.onSurfaceVariant,
          fontSize: 10,
          fontStyle: FontStyle.italic,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    bottomTp.paint(canvas, Offset(0, arrowY));
  }

  @override
  bool shouldRepaint(_ThreadDiagramPainter old) => false;
}

// ===========================================================================
// TAB 9 — API Cheat Sheet
// ===========================================================================
class _CheatSheetTab extends StatelessWidget {
  const _CheatSheetTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _HeaderChip(label: 'API Cheat Sheet', icon: Icons.checklist),
        const SizedBox(height: 12),
        // All constants
        _SectionCard(
          icon: Icons.flag_outlined,
          title: 'All Static Constants',
          color: cs.primaryContainer,
          iconColor: cs.primary,
          child: _MonoBox(
            text: 'displayRasterizerStatistics  (mask bit 0) = $_kDisplayRasterizerStatistics\n'
                'visualizeRasterizerStatistics (mask bit 1) = $_kVisualizeRasterizerStatistics\n'
                'displayEngineStatistics       (mask bit 2) = $_kDisplayEngineStatistics\n'
                'visualizeEngineStatistics     (mask bit 3) = $_kVisualizeEngineStatistics',
          ),
        ),
        const SizedBox(height: 16),
        // optionsMask patterns
        _SectionCard(
          icon: Icons.tune,
          title: 'optionsMask Patterns',
          color: cs.secondaryContainer,
          iconColor: cs.secondary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _MonoBox(
                text: '// Show everything\n'
                    'PerformanceOverlay(\n'
                    '  optionsMask:\n'
                    '    _kDisplayRasterizerStatistics\n'
                    '    | _kVisualizeRasterizerStatistics\n'
                    '    | _kDisplayEngineStatistics\n'
                    '    | _kVisualizeEngineStatistics,  // = 15\n'
                    ')',
              ),
              const SizedBox(height: 12),
              _MonoBox(
                text: '// Text stats only (no bar graphs)\n'
                    'PerformanceOverlay(\n'
                    '  optionsMask:\n'
                    '    _kDisplayRasterizerStatistics  // 1\n'
                    '    | _kDisplayEngineStatistics,   // 4\n'
                    ')  // mask = 5',
              ),
              const SizedBox(height: 12),
              _MonoBox(
                text: '// Via MaterialApp (all flags, full app)\n'
                    'MaterialApp(\n'
                    '  showPerformanceOverlay: true,\n'
                    '  ...\n'
                    ')',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // flutter run --profile
        _SectionCard(
          icon: Icons.terminal,
          title: 'flutter run --profile vs PerformanceOverlay',
          color: cs.tertiaryContainer,
          iconColor: cs.tertiary,
          child: Table(
            border: TableBorder.all(color: cs.outline.withAlpha(80)),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(3),
            },
            children: <TableRow>[
              TableRow(
                decoration: BoxDecoration(color: cs.tertiary.withAlpha(30)),
                children: <Widget>[
                  _TableCell(text: '', header: true),
                  _TableCell(text: '--profile mode', header: true),
                  _TableCell(text: 'PerformanceOverlay', header: true),
                ],
              ),
              const TableRow(children: <Widget>[
                _TableCell(text: 'Build type'),
                _TableCell(text: 'Profile build'),
                _TableCell(text: 'Any (accurate in profile)'),
              ]),
              const TableRow(children: <Widget>[
                _TableCell(text: 'Graphs shown'),
                _TableCell(text: 'Yes, in overlay'),
                _TableCell(text: 'Yes (if flags set)'),
              ]),
              const TableRow(children: <Widget>[
                _TableCell(text: 'DevTools'),
                _TableCell(text: 'Enabled'),
                _TableCell(text: 'Not required'),
              ]),
              const TableRow(children: <Widget>[
                _TableCell(text: 'Accuracy'),
                _TableCell(text: 'Near-production'),
                _TableCell(text: 'Profile: accurate. Debug: low'),
              ]),
              const TableRow(children: <Widget>[
                _TableCell(text: 'Use case'),
                _TableCell(text: 'Full perf audit'),
                _TableCell(text: 'Quick on-device check'),
              ]),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Profiling workflow mini-cards
        _SectionCard(
          icon: Icons.receipt_long_outlined,
          title: 'Profiling Workflow — 6 Steps',
          color: cs.primaryContainer,
          iconColor: cs.primary,
          child: Column(
            children: <Widget>[
              _WorkflowCard(
                step: '1',
                title: 'flutter run --profile',
                body: 'Build and run in profile mode. Dart AOT-compiled, DevTools socket open, minimal overhead.',
                color: cs.primary,
              ),
              _WorkflowCard(
                step: '2',
                title: 'DevTools Timeline',
                body: 'Connect via flutter pub global run devtools. Flame chart shows each frame\'s build/layout/paint/composite.',
                color: cs.secondary,
              ),
              _WorkflowCard(
                step: '3',
                title: 'CPU Profiler',
                body: 'Sample CPU call stacks. Identify hot paths in Dart code consuming UI thread time.',
                color: cs.tertiary,
              ),
              _WorkflowCard(
                step: '4',
                title: 'Memory Profiler',
                body: 'Detect allocation storms and leaks. Excessive GC can cause UI thread pauses.',
                color: cs.primary,
              ),
              _WorkflowCard(
                step: '5',
                title: 'Widget Rebuilds',
                body: 'Enable debugPrintRebuildDirtyWidgets or use DevTools\'s widget inspector rebuild counter.',
                color: cs.secondary,
              ),
              _WorkflowCard(
                step: '6',
                title: 'Repaint Rainbows',
                body: 'Set debugRepaintRainbowEnabled = true. Widgets that repaint flash random colors — spot unnecessary repaints instantly.',
                color: cs.tertiary,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Quick reference
        _SectionCard(
          icon: Icons.library_books_outlined,
          title: 'Quick Reference',
          color: cs.secondaryContainer,
          iconColor: cs.secondary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _QuickRefRow(label: 'Widget class', value: 'PerformanceOverlay'),
              _QuickRefRow(label: 'Package', value: 'package:flutter/widgets.dart'),
              _QuickRefRow(label: 'Constructor param', value: 'optionsMask: int'),
              _QuickRefRow(label: 'All flags OR', value: 'optionsMask: 15'),
              _QuickRefRow(label: 'MaterialApp param', value: 'showPerformanceOverlay: bool'),
              _QuickRefRow(label: 'Profile build cmd', value: 'flutter run --profile'),
              _QuickRefRow(label: 'Budget (60fps)', value: '16.6 ms per frame'),
              _QuickRefRow(label: 'Budget (120fps)', value: '8.3 ms per frame'),
              _QuickRefRow(label: 'GPU thread flag', value: 'kDisplayRasterizerStatistics'),
              _QuickRefRow(label: 'UI thread flag', value: 'kDisplayEngineStatistics'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Sandbox note
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cs.errorContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.info_outline, color: cs.error),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Sandbox Note',
                      style: tt.labelLarge?.copyWith(
                        color: cs.error,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'In the D4rt interpreted sandbox the PerformanceOverlay widget is instantiated '
                      'and placed in the widget tree, but renders as blank or a thin sliver. '
                      'On a real device running in profile or release mode the full GPU/UI thread '
                      'bar graphs appear. All constructor parameters and static constants demonstrated '
                      'here are accurate to the real Flutter API.',
                      style: tt.bodySmall?.copyWith(color: cs.onErrorContainer),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _WorkflowCard extends StatelessWidget {
  const _WorkflowCard({
    required this.step,
    required this.title,
    required this.body,
    required this.color,
  });
  final String step;
  final String title;
  final String body;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 14,
            backgroundColor: color,
            child: Text(
              step,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(fontWeight: FontWeight.w700, color: color)),
                Text(body, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickRefRow extends StatelessWidget {
  const _QuickRefRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SHARED WIDGETS
// ===========================================================================

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.iconColor,
    required this.child,
  });
  final IconData icon;
  final String title;
  final Color color;
  final Color iconColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, size: 20, color: iconColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: tt.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: iconColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _MonoBox extends StatelessWidget {
  const _MonoBox({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cs.outline.withAlpha(80)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: cs.onSurface,
          height: 1.6,
        ),
      ),
    );
  }
}

class _HeaderChip extends StatelessWidget {
  const _HeaderChip({required this.label, required this.icon});
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: cs.primaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 16, color: cs.primary),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: cs.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BulletItem extends StatelessWidget {
  const _BulletItem({required this.text, required this.icon});
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, size: 16, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: Theme.of(context).textTheme.bodySmall)),
        ],
      ),
    );
  }
}
