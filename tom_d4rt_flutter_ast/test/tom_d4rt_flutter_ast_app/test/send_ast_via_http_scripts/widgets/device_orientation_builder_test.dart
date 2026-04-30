import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _DeviceOrientationBuilderDemoApp();
}

class _DeviceOrientationBuilderDemoApp extends StatelessWidget {
  const _DeviceOrientationBuilderDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0E6177)),
        useMaterial3: true,
      ),
      home: const _DeviceOrientationBuilderDemoPage(),
    );
  }
}

class _DeviceOrientationBuilderDemoPage extends StatefulWidget {
  const _DeviceOrientationBuilderDemoPage();

  @override
  State<_DeviceOrientationBuilderDemoPage> createState() => _DeviceOrientationBuilderDemoPageState();
}

class _DeviceOrientationBuilderDemoPageState extends State<_DeviceOrientationBuilderDemoPage> {
  bool _simulateLandscape = false;
  bool _denseCards = false;
  double _cardScale = 1.0;

  @override
  Widget build(BuildContext context) {
    const cOcean = Color(0xFF0E6177);
    const cCoral = Color(0xFFE07054);
    const cForest = Color(0xFF2F7A66);
    const cViolet = Color(0xFF6C5AA3);
    const cSlate = Color(0xFF344955);
    const cSand = Color(0xFFF6F3EB);

    final baseQuery = MediaQuery.of(context);
    final simulatedSize = _simulateLandscape ? const Size(980, 540) : const Size(540, 980);
    final simulatedQuery = baseQuery.copyWith(size: simulatedSize);

    return MediaQuery(
      data: simulatedQuery,
      child: Scaffold(
        backgroundColor: cSand,
        appBar: AppBar(
          backgroundColor: cOcean,
          foregroundColor: Colors.white,
          toolbarHeight: 74,
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('DeviceOrientationBuilder Deep Demo'),
              SizedBox(height: 2),
              Text(
                'Device orientation aware UI via MediaQuery.orientationOf(context)',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HeroBanner(
                isLandscape: _simulateLandscape,
                denseCards: _denseCards,
                cardScale: _cardScale,
                onLandscapeToggle: (value) => setState(() => _simulateLandscape = value),
                onDenseToggle: (value) => setState(() => _denseCards = value),
                onScaleChanged: (value) => setState(() => _cardScale = value),
              ),
              const SizedBox(height: 14),
              const _ScenePanel(
                index: 1,
                title: 'Concept and API Scope',
                subtitle:
                    'DeviceOrientationBuilder reads MediaQuery orientation (physical device orientation), unlike OrientationBuilder which uses parent constraints.',
                accent: cOcean,
                child: _ConceptScene(),
              ),
              const SizedBox(height: 12),
              const _ScenePanel(
                index: 2,
                title: 'Device vs Layout Orientation',
                subtitle:
                    'Intentional mismatch examples show why DeviceOrientationBuilder and OrientationBuilder are not interchangeable.',
                accent: cCoral,
                child: _MismatchScene(),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 3,
                title: 'Adaptive Dashboard by Device Orientation',
                subtitle:
                    'Dashboard structure changes at device-level orientation while keeping consistent content modules.',
                accent: cForest,
                child: _DashboardScene(
                  denseCards: _denseCards,
                  cardScale: _cardScale,
                ),
              ),
              const SizedBox(height: 12),
              const _ScenePanel(
                index: 4,
                title: 'Parallel Preview Scopes',
                subtitle:
                    'Two side-by-side MediaQuery scopes emulate portrait and landscape so both states are visible simultaneously.',
                accent: cViolet,
                child: _ParallelPreviewScene(),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 5,
                title: 'Interactive Orientation Lab',
                subtitle:
                    'Toggle controls and inspect how orientation-specific panes, spacing, and action placement update under DeviceOrientationBuilder.',
                accent: cSlate,
                child: _InteractiveLabScene(
                  denseCards: _denseCards,
                  cardScale: _cardScale,
                  onDenseToggle: (value) => setState(() => _denseCards = value),
                  onScaleChanged: (value) => setState(() => _cardScale = value),
                ),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 6,
                title: 'Practical Architecture Pattern',
                subtitle:
                    'Reusable feature modules react to device orientation via a local policy layer, avoiding duplicate UI trees.',
                accent: const Color(0xFF7A5B3E),
                child: _ArchitectureScene(
                  denseCards: _denseCards,
                  cardScale: _cardScale,
                ),
              ),
              const SizedBox(height: 16),
              const _RecapCard(),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({
    required this.isLandscape,
    required this.denseCards,
    required this.cardScale,
    required this.onLandscapeToggle,
    required this.onDenseToggle,
    required this.onScaleChanged,
  });

  final bool isLandscape;
  final bool denseCards;
  final double cardScale;
  final ValueChanged<bool> onLandscapeToggle;
  final ValueChanged<bool> onDenseToggle;
  final ValueChanged<double> onScaleChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0E6177),
            Color(0xFF3A879B),
            Color(0xFF6C5AA3),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'DeviceOrientationBuilder',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white),
          ),
          const SizedBox(height: 8),
          const Text(
            'Build orientation-specific widget trees from MediaQuery device orientation. '
            'Great for device posture policies and foldable-friendly adaptation that should not depend solely on local constraints.',
            style: TextStyle(fontSize: 13, height: 1.45, color: Color(0xFFF1FAFF)),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: SwitchListTile(
                  value: isLandscape,
                  onChanged: onLandscapeToggle,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Simulate Landscape', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SwitchListTile(
                  value: denseCards,
                  onChanged: onDenseToggle,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Dense Cards', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Card scale: ${cardScale.toStringAsFixed(2)}x',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          Slider(
            value: cardScale,
            min: 0.85,
            max: 1.35,
            divisions: 10,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.3),
            onChanged: onScaleChanged,
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              _HeroTag(label: 'MediaQuery.orientationOf'),
              _HeroTag(label: 'Device posture aware'),
              _HeroTag(label: 'Different from OrientationBuilder'),
              _HeroTag(label: 'Scope-based previews'),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroTag extends StatelessWidget {
  const _HeroTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.45)),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11),
      ),
    );
  }
}

class _ScenePanel extends StatelessWidget {
  const _ScenePanel({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.child,
  });

  final int index;
  final String title;
  final String subtitle;
  final Color accent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.28)),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('$index', style: TextStyle(color: accent, fontWeight: FontWeight.w900)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: accent),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12, height: 1.45, color: accent.withValues(alpha: 0.8)),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _ConceptScene extends StatelessWidget {
  const _ConceptScene();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _InfoLine(
          'DeviceOrientationBuilder uses MediaQuery.orientationOf(context), so it reflects device orientation, not just width-vs-height constraints of the immediate parent.',
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            _ConceptCard(
              title: 'DeviceOrientationBuilder',
              accent: Color(0xFF0E6177),
              line1: 'Reads MediaQuery orientation.',
              line2: 'Best for device-posture policies and foldables.',
              line3: 'Needs MediaQuery ancestor.',
            ),
            _ConceptCard(
              title: 'OrientationBuilder',
              accent: Color(0xFFE07054),
              line1: 'Uses parent constraints (LayoutBuilder).',
              line2: 'Great for local responsive layout decisions.',
              line3: 'Can differ from physical device orientation.',
            ),
            _ConceptCard(
              title: 'Policy layering',
              accent: Color(0xFF2F7A66),
              line1: 'Use DeviceOrientationBuilder for top-level structure.',
              line2: 'Use OrientationBuilder deeper for local breakpoints.',
              line3: 'Combining both improves adaptability.',
            ),
            _ConceptCard(
              title: 'Testing strategy',
              accent: Color(0xFF6C5AA3),
              line1: 'Inject custom MediaQuery sizes in scoped previews.',
              line2: 'Render both orientations side-by-side.',
              line3: 'Validate visual policy quickly without rotating device.',
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F7FA),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFBCD2DD)),
          ),
          child: const SelectableText(
            'DeviceOrientationBuilder(\n'
            '  builder: (context, orientation) {\n'
            '    return orientation == Orientation.landscape\n'
            '      ? WideScaffold()\n'
            '      : TallScaffold();\n'
            '  },\n'
            ')',
            style: TextStyle(fontFamily: 'monospace', fontSize: 11, height: 1.4),
          ),
        ),
      ],
    );
  }
}

class _ConceptCard extends StatelessWidget {
  const _ConceptCard({
    required this.title,
    required this.accent,
    required this.line1,
    required this.line2,
    required this.line3,
  });

  final String title;
  final Color accent;
  final String line1;
  final String line2;
  final String line3;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 298,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: accent.withValues(alpha: 0.27)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 13)),
            const SizedBox(height: 6),
            Text(line1, style: const TextStyle(fontSize: 11.6, height: 1.35)),
            const SizedBox(height: 3),
            Text(line2, style: const TextStyle(fontSize: 11.6, height: 1.35)),
            const SizedBox(height: 3),
            Text(line3, style: const TextStyle(fontSize: 11.6, height: 1.35)),
          ],
        ),
      ),
    );
  }
}

class _MismatchScene extends StatelessWidget {
  const _MismatchScene();

  @override
  Widget build(BuildContext context) {
    final base = MediaQuery.of(context);

    final portraitDevice = base.copyWith(size: const Size(420, 840));
    final landscapeDevice = base.copyWith(size: const Size(920, 480));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _InfoLine(
          'Each panel below shows DeviceOrientationBuilder and OrientationBuilder resolving potentially different orientation values.',
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            MediaQuery(
              data: portraitDevice,
              child: _MismatchCard(
                title: 'Portrait device + wide local constraints',
                accent: const Color(0xFFE07054),
                localSize: const Size(280, 120),
              ),
            ),
            MediaQuery(
              data: landscapeDevice,
              child: _MismatchCard(
                title: 'Landscape device + tall local constraints',
                accent: const Color(0xFFE07054),
                localSize: const Size(130, 240),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MismatchCard extends StatelessWidget {
  const _MismatchCard({
    required this.title,
    required this.accent,
    required this.localSize,
  });

  final String title;
  final Color accent;
  final Size localSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: accent.withValues(alpha: 0.28)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 13)),
            const SizedBox(height: 8),
            DeviceOrientationBuilder(
              builder: (context, deviceOrientation) {
                return OrientationBuilder(
                  builder: (context, layoutOrientation) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: accent.withValues(alpha: 0.2)),
                          ),
                          child: Text(
                            'Device: $deviceOrientation\nLayout: $layoutOrientation',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 10.8,
                              color: accent.withValues(alpha: 0.85),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: SizedBox(
                            width: localSize.width,
                            height: localSize.height,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: accent.withValues(alpha: 0.25)),
                              ),
                              child: Center(
                                child: Text(
                                  '${localSize.width.toInt()} x ${localSize.height.toInt()}',
                                  style: TextStyle(color: accent, fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardScene extends StatelessWidget {
  const _DashboardScene({required this.denseCards, required this.cardScale});

  final bool denseCards;
  final double cardScale;

  @override
  Widget build(BuildContext context) {
    return DeviceOrientationBuilder(
      builder: (context, orientation) {
        final isLandscape = orientation == Orientation.landscape;
        final gap = denseCards ? 8.0 : 14.0;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InfoLine(
              isLandscape
                  ? 'Landscape mode: navigation rail + multi-column content panels.'
                  : 'Portrait mode: stacked sections with full-width content flow.',
            ),
            const SizedBox(height: 10),
            isLandscape
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _NavRailCard(scale: cardScale),
                      SizedBox(width: gap),
                      Expanded(child: _DashboardGrid(scale: cardScale, columns: 2, dense: denseCards)),
                    ],
                  )
                : Column(
                    children: [
                      _TopNavStrip(scale: cardScale),
                      SizedBox(height: gap),
                      _DashboardGrid(scale: cardScale, columns: 1, dense: denseCards),
                    ],
                  ),
          ],
        );
      },
    );
  }
}

class _NavRailCard extends StatelessWidget {
  const _NavRailCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 96 * scale,
      child: Container(
        padding: EdgeInsets.all(10 * scale),
        decoration: BoxDecoration(
          color: const Color(0xFFF2FBF8),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFC6E7DC)),
        ),
        child: Column(
          children: [
            Icon(Icons.dashboard_rounded, color: const Color(0xFF2F7A66), size: 22 * scale),
            SizedBox(height: 8 * scale),
            Icon(Icons.map_rounded, color: const Color(0xFF2F7A66), size: 20 * scale),
            SizedBox(height: 8 * scale),
            Icon(Icons.analytics_rounded, color: const Color(0xFF2F7A66), size: 20 * scale),
            SizedBox(height: 8 * scale),
            Icon(Icons.settings_rounded, color: const Color(0xFF2F7A66), size: 20 * scale),
          ],
        ),
      ),
    );
  }
}

class _TopNavStrip extends StatelessWidget {
  const _TopNavStrip({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF2FBF8),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFC6E7DC)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.dashboard_rounded, color: const Color(0xFF2F7A66), size: 20 * scale),
          Icon(Icons.map_rounded, color: const Color(0xFF2F7A66), size: 20 * scale),
          Icon(Icons.analytics_rounded, color: const Color(0xFF2F7A66), size: 20 * scale),
          Icon(Icons.settings_rounded, color: const Color(0xFF2F7A66), size: 20 * scale),
        ],
      ),
    );
  }
}

class _DashboardGrid extends StatelessWidget {
  const _DashboardGrid({required this.scale, required this.columns, required this.dense});

  final double scale;
  final int columns;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final spacing = dense ? 8.0 : 12.0;

    return GridView.count(
      crossAxisCount: columns,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: spacing,
      mainAxisSpacing: spacing,
      childAspectRatio: columns == 1 ? 2.9 : 1.55,
      children: [
        _MetricCard(scale: scale, title: 'Active Routes', value: '18', accent: const Color(0xFF0E6177), icon: Icons.route),
        _MetricCard(scale: scale, title: 'On-time Delivery', value: '96%', accent: const Color(0xFF2F7A66), icon: Icons.timer),
        _MetricCard(scale: scale, title: 'Alerts', value: '4', accent: const Color(0xFFE07054), icon: Icons.warning_amber),
        _MetricCard(scale: scale, title: 'Fuel Index', value: '71', accent: const Color(0xFF6C5AA3), icon: Icons.local_gas_station),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.scale,
    required this.title,
    required this.value,
    required this.accent,
    required this.icon,
  });

  final double scale;
  final String title;
  final String value;
  final Color accent;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 34 * scale,
            height: 34 * scale,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: accent, size: 18 * scale),
          ),
          SizedBox(width: 10 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: TextStyle(fontSize: 11 * scale, color: accent.withValues(alpha: 0.8))),
                const SizedBox(height: 4),
                Text(value, style: TextStyle(fontSize: 19 * scale, fontWeight: FontWeight.w800, color: accent)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ParallelPreviewScene extends StatelessWidget {
  const _ParallelPreviewScene();

  @override
  Widget build(BuildContext context) {
    final base = MediaQuery.of(context);
    final portraitScope = base.copyWith(size: const Size(420, 860));
    final landscapeScope = base.copyWith(size: const Size(860, 420));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _InfoLine(
          'Preview both device orientations in one screen by applying scoped MediaQuery data around each module preview card.',
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            MediaQuery(
              data: portraitScope,
              child: const _PreviewScopeCard(label: 'Portrait Preview', accent: Color(0xFF6C5AA3)),
            ),
            MediaQuery(
              data: landscapeScope,
              child: const _PreviewScopeCard(label: 'Landscape Preview', accent: Color(0xFF6C5AA3)),
            ),
          ],
        ),
      ],
    );
  }
}

class _PreviewScopeCard extends StatelessWidget {
  const _PreviewScopeCard({required this.label, required this.accent});

  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: accent.withValues(alpha: 0.28)),
        ),
        child: DeviceOrientationBuilder(
          builder: (context, orientation) {
            final isLandscape = orientation == Orientation.landscape;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 13.5)),
                const SizedBox(height: 6),
                Text(
                  'Resolved device orientation: $orientation',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.5,
                    color: accent.withValues(alpha: 0.84),
                  ),
                ),
                const SizedBox(height: 8),
                isLandscape
                    ? Row(
                        children: [
                          Expanded(child: _MiniPanel(title: 'Rail', accent: accent)),
                          const SizedBox(width: 8),
                          Expanded(child: _MiniPanel(title: 'Content', accent: accent)),
                        ],
                      )
                    : Column(
                        children: [
                          _MiniPanel(title: 'Top Nav', accent: accent),
                          const SizedBox(height: 8),
                          _MiniPanel(title: 'Content', accent: accent),
                        ],
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _MiniPanel extends StatelessWidget {
  const _MiniPanel({required this.title, required this.accent});

  final String title;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.2)),
      ),
      child: Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w700)),
    );
  }
}

class _InteractiveLabScene extends StatelessWidget {
  const _InteractiveLabScene({
    required this.denseCards,
    required this.cardScale,
    required this.onDenseToggle,
    required this.onScaleChanged,
  });

  final bool denseCards;
  final double cardScale;
  final ValueChanged<bool> onDenseToggle;
  final ValueChanged<double> onScaleChanged;

  @override
  Widget build(BuildContext context) {
    return DeviceOrientationBuilder(
      builder: (context, orientation) {
        final isLandscape = orientation == Orientation.landscape;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InfoLine(
              isLandscape
                  ? 'Landscape lab: controls float beside content for faster side-by-side adjustments.'
                  : 'Portrait lab: controls stack above content for one-handed tuning flow.',
            ),
            const SizedBox(height: 10),
            isLandscape
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 260,
                        child: _ControlPanel(
                          denseCards: denseCards,
                          cardScale: cardScale,
                          onDenseToggle: onDenseToggle,
                          onScaleChanged: onScaleChanged,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _DashboardGrid(scale: cardScale, columns: 2, dense: denseCards),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      _ControlPanel(
                        denseCards: denseCards,
                        cardScale: cardScale,
                        onDenseToggle: onDenseToggle,
                        onScaleChanged: onScaleChanged,
                      ),
                      const SizedBox(height: 12),
                      _DashboardGrid(scale: cardScale, columns: 1, dense: denseCards),
                    ],
                  ),
          ],
        );
      },
    );
  }
}

class _ControlPanel extends StatelessWidget {
  const _ControlPanel({
    required this.denseCards,
    required this.cardScale,
    required this.onDenseToggle,
    required this.onScaleChanged,
  });

  final bool denseCards;
  final double cardScale;
  final ValueChanged<bool> onDenseToggle;
  final ValueChanged<double> onScaleChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F8),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFC8D4DB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Lab Controls', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5)),
          const SizedBox(height: 8),
          SwitchListTile(
            value: denseCards,
            onChanged: onDenseToggle,
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: const Text('Dense cards'),
          ),
          const SizedBox(height: 6),
          Text('Scale: ${cardScale.toStringAsFixed(2)}x', style: const TextStyle(fontWeight: FontWeight.w700)),
          Slider(
            value: cardScale,
            min: 0.85,
            max: 1.35,
            divisions: 10,
            onChanged: onScaleChanged,
          ),
          const SizedBox(height: 4),
          const Text(
            'Tip: combine DeviceOrientationBuilder for major structure and LayoutBuilder for fine-grained card breakpoints.',
            style: TextStyle(fontSize: 11.5, height: 1.35),
          ),
        ],
      ),
    );
  }
}

class _ArchitectureScene extends StatelessWidget {
  const _ArchitectureScene({required this.denseCards, required this.cardScale});

  final bool denseCards;
  final double cardScale;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _FeatureModuleCard(
          title: 'Operations Module',
          accent: const Color(0xFF0E6177),
          denseCards: denseCards,
          cardScale: cardScale,
          policy: 'Landscape: split map + queue. Portrait: stacked queue then map.',
        ),
        _FeatureModuleCard(
          title: 'Creative Module',
          accent: const Color(0xFFE07054),
          denseCards: denseCards,
          cardScale: cardScale,
          policy: 'Landscape: side-by-side asset board. Portrait: sequential storyboard.',
        ),
        _FeatureModuleCard(
          title: 'Research Module',
          accent: const Color(0xFF2F7A66),
          denseCards: denseCards,
          cardScale: cardScale,
          policy: 'Landscape: table + chart columns. Portrait: chart-first narrative blocks.',
        ),
      ],
    );
  }
}

class _FeatureModuleCard extends StatelessWidget {
  const _FeatureModuleCard({
    required this.title,
    required this.accent,
    required this.denseCards,
    required this.cardScale,
    required this.policy,
  });

  final String title;
  final Color accent;
  final bool denseCards;
  final double cardScale;
  final String policy;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: DeviceOrientationBuilder(
        builder: (context, orientation) {
          final isLandscape = orientation == Orientation.landscape;
          final tileHeight = denseCards ? 38.0 : 50.0;

          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: accent.withValues(alpha: 0.28)),
              boxShadow: [
                BoxShadow(
                  color: accent.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.w800, color: accent, fontSize: 14)),
                const SizedBox(height: 4),
                Text(policy, style: TextStyle(fontSize: 11.2, color: accent.withValues(alpha: 0.82), height: 1.35)),
                const SizedBox(height: 8),
                Text(
                  'Resolved orientation: $orientation',
                  style: TextStyle(fontFamily: 'monospace', fontSize: 10.2, color: accent.withValues(alpha: 0.82)),
                ),
                const SizedBox(height: 8),
                isLandscape
                    ? Row(
                        children: [
                          Expanded(child: _ModuleTile(accent: accent, title: 'Panel A', height: tileHeight * cardScale)),
                          const SizedBox(width: 8),
                          Expanded(child: _ModuleTile(accent: accent, title: 'Panel B', height: tileHeight * cardScale)),
                        ],
                      )
                    : Column(
                        children: [
                          _ModuleTile(accent: accent, title: 'Panel A', height: tileHeight * cardScale),
                          const SizedBox(height: 8),
                          _ModuleTile(accent: accent, title: 'Panel B', height: tileHeight * cardScale),
                        ],
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ModuleTile extends StatelessWidget {
  const _ModuleTile({required this.accent, required this.title, required this.height});

  final Color accent;
  final String title;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.22)),
      ),
      child: Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w700)),
    );
  }
}

class _RecapCard extends StatelessWidget {
  const _RecapCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFFE9F3F8), Color(0xFFF7ECE3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFFB9CBD8)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deep Demo Recap',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF314B5B)),
          ),
          SizedBox(height: 8),
          Text(
            '1) DeviceOrientationBuilder uses MediaQuery.orientationOf for device orientation decisions.\n'
            '2) It can differ from OrientationBuilder when local constraints and device posture diverge.\n'
            '3) Scoped MediaQuery previews are effective for testing both orientations simultaneously.\n'
            '4) Orientation policies can drive major layout structure while shared modules stay reusable.\n'
            '5) Combining orientation policy with local breakpoint logic yields robust responsive UIs.',
            style: TextStyle(fontSize: 12.4, height: 1.45),
          ),
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontSize: 12.5, height: 1.45));
  }
}
