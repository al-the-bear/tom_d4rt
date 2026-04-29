import 'dart:math' as math;
import 'dart:ui' show DisplayFeature, DisplayFeatureState, DisplayFeatureType;

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _DisplayFeatureSubScreenDeepDemoApp();
}

class _DisplayFeatureSubScreenDeepDemoApp extends StatelessWidget {
  const _DisplayFeatureSubScreenDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1F4E77)),
        useMaterial3: true,
      ),
      home: const _DisplayFeatureSubScreenDemoPage(),
    );
  }
}

enum _FeatureMode {
  none,
  verticalHinge,
  horizontalFold,
  dualVertical,
  topCutout,
}

class _DisplayFeatureSubScreenDemoPage extends StatefulWidget {
  const _DisplayFeatureSubScreenDemoPage();

  @override
  State<_DisplayFeatureSubScreenDemoPage> createState() => _DisplayFeatureSubScreenDemoPageState();
}

class _DisplayFeatureSubScreenDemoPageState extends State<_DisplayFeatureSubScreenDemoPage> {
  static const Size _simulatedSize = Size(640, 360);

  bool _rtl = false;
  bool _useAnchorPoint = true;
  bool _halfOpened = false;
  bool _showGuides = true;
  bool _compactCards = false;

  _FeatureMode _featureMode = _FeatureMode.verticalHinge;

  double _featurePosition = 0.5;
  double _featureThickness = 18;
  Offset _anchorPoint = const Offset(120, 140);

  @override
  Widget build(BuildContext context) {
    const cNavy = Color(0xFF1F4E77);
    const cAmber = Color(0xFFC57C37);
    const cTeal = Color(0xFF2A7A71);
    const cRose = Color(0xFF96476B);
    const cIndigo = Color(0xFF5855A2);
    const cOlive = Color(0xFF6C682E);

    final parentQuery = MediaQuery.of(context);
    final simulatedQuery = parentQuery.copyWith(
      size: _simulatedSize,
      displayFeatures: _buildDisplayFeatures(_simulatedSize, _featureMode),
    );

    return Directionality(
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F5F8),
        appBar: AppBar(
          backgroundColor: cNavy,
          foregroundColor: Colors.white,
          toolbarHeight: 76,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('DisplayFeatureSubScreen Deep Demo'),
              const SizedBox(height: 2),
              Text(
                _rtl
                    ? 'Directionality: RTL (fallback anchor defaults to top-right)'
                    : 'Directionality: LTR (fallback anchor defaults to top-left)',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HeroControlDeck(
                rtl: _rtl,
                useAnchorPoint: _useAnchorPoint,
                halfOpened: _halfOpened,
                showGuides: _showGuides,
                compactCards: _compactCards,
                featureMode: _featureMode,
                featurePosition: _featurePosition,
                featureThickness: _featureThickness,
                anchorPoint: _anchorPoint,
                onRtlChanged: (v) => setState(() => _rtl = v),
                onUseAnchorChanged: (v) => setState(() => _useAnchorPoint = v),
                onHalfOpenedChanged: (v) => setState(() => _halfOpened = v),
                onShowGuidesChanged: (v) => setState(() => _showGuides = v),
                onCompactChanged: (v) => setState(() => _compactCards = v),
                onFeatureModeChanged: (v) => setState(() => _featureMode = v),
                onFeaturePositionChanged: (v) => setState(() => _featurePosition = v),
                onFeatureThicknessChanged: (v) => setState(() => _featureThickness = v),
              ),
              const SizedBox(height: 12),
              const _ScenePanel(
                index: 1,
                accent: cNavy,
                title: 'Concept and Selection Rules',
                subtitle:
                    'DisplayFeatureSubScreen chooses the nearest split sub-screen to an anchor point and wraps child with adjusted MediaQuery data.',
                child: _ConceptScene(),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 2,
                accent: cAmber,
                title: 'Live Anchor Playground',
                subtitle:
                    'Tap the preview to move anchor point. The selected sub-screen updates immediately and avoids splitting display features.',
                child: _AnchorPlaygroundScene(
                  query: simulatedQuery,
                  anchorPoint: _anchorPoint,
                  useAnchorPoint: _useAnchorPoint,
                  showGuides: _showGuides,
                  compactCards: _compactCards,
                  onAnchorChanged: (p) => setState(() => _anchorPoint = p),
                ),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 3,
                accent: cTeal,
                title: 'Directionality Fallback Behavior',
                subtitle:
                    'When anchorPoint is null, DisplayFeatureSubScreen uses Directionality fallback: top-left in LTR, top-right in RTL.',
                child: _DirectionalityFallbackScene(
                  query: simulatedQuery,
                  compactCards: _compactCards,
                ),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 4,
                accent: cRose,
                title: 'Feature Type Comparisons',
                subtitle:
                    'Compare hinge, fold, cutout, and dual-hinge maps to see when sub-screen partitioning occurs and when it does not.',
                child: _FeatureComparisonScene(
                  baseQuery: parentQuery,
                  anchorPoint: _anchorPoint,
                  useAnchorPoint: _useAnchorPoint,
                  halfOpened: _halfOpened,
                  showGuides: _showGuides,
                ),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 5,
                accent: cIndigo,
                title: 'Static API Inspection',
                subtitle:
                    'Visualize avoidBounds(mediaQuery) and subScreensInBounds(...) results with calculated rectangles and nearest-screen selection.',
                child: _ApiInspectionScene(
                  query: simulatedQuery,
                  anchorPoint: _anchorPoint,
                  useAnchorPoint: _useAnchorPoint,
                ),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 6,
                accent: cOlive,
                title: 'Practical Placement Patterns',
                subtitle:
                    'Pattern demos for pane-constrained overlays and dialogs; includes before/after MediaQuery displayFeature counts in child subtree.',
                child: _PracticalPatternsScene(
                  query: simulatedQuery,
                  anchorPoint: _anchorPoint,
                  compactCards: _compactCards,
                ),
              ),
              const SizedBox(height: 12),
              const _RecapCard(),
              const SizedBox(height: 22),
            ],
          ),
        ),
      ),
    );
  }

  List<DisplayFeature> _buildDisplayFeatures(Size size, _FeatureMode mode) {
    final p = _featurePosition.clamp(0.1, 0.9);
    final t = _featureThickness.clamp(4.0, 56.0);
    final halfState = _halfOpened ? DisplayFeatureState.postureHalfOpened : DisplayFeatureState.postureFlat;

    switch (mode) {
      case _FeatureMode.none:
        return const <DisplayFeature>[];
      case _FeatureMode.verticalHinge:
        return <DisplayFeature>[
          DisplayFeature(
            bounds: Rect.fromLTWH(size.width * p - t / 2, 0, t, size.height),
            type: DisplayFeatureType.hinge,
            state: halfState,
          ),
        ];
      case _FeatureMode.horizontalFold:
        return <DisplayFeature>[
          DisplayFeature(
            bounds: Rect.fromLTWH(0, size.height * p - t / 2, size.width, t),
            type: DisplayFeatureType.fold,
            state: halfState,
          ),
        ];
      case _FeatureMode.dualVertical:
        return <DisplayFeature>[
          DisplayFeature(
            bounds: Rect.fromLTWH(size.width * 0.33 - t / 2, 0, t, size.height),
            type: DisplayFeatureType.hinge,
            state: halfState,
          ),
          DisplayFeature(
            bounds: Rect.fromLTWH(size.width * 0.67 - t / 2, 0, t, size.height),
            type: DisplayFeatureType.hinge,
            state: halfState,
          ),
        ];
      case _FeatureMode.topCutout:
        return <DisplayFeature>[
          DisplayFeature(
            bounds: Rect.fromLTWH(size.width * 0.45, 0, size.width * 0.1, size.height * 0.1),
            type: DisplayFeatureType.cutout,
            state: DisplayFeatureState.unknown,
          ),
        ];
    }
  }
}

class _HeroControlDeck extends StatelessWidget {
  const _HeroControlDeck({
    required this.rtl,
    required this.useAnchorPoint,
    required this.halfOpened,
    required this.showGuides,
    required this.compactCards,
    required this.featureMode,
    required this.featurePosition,
    required this.featureThickness,
    required this.anchorPoint,
    required this.onRtlChanged,
    required this.onUseAnchorChanged,
    required this.onHalfOpenedChanged,
    required this.onShowGuidesChanged,
    required this.onCompactChanged,
    required this.onFeatureModeChanged,
    required this.onFeaturePositionChanged,
    required this.onFeatureThicknessChanged,
  });

  final bool rtl;
  final bool useAnchorPoint;
  final bool halfOpened;
  final bool showGuides;
  final bool compactCards;
  final _FeatureMode featureMode;
  final double featurePosition;
  final double featureThickness;
  final Offset anchorPoint;

  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<bool> onUseAnchorChanged;
  final ValueChanged<bool> onHalfOpenedChanged;
  final ValueChanged<bool> onShowGuidesChanged;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<_FeatureMode> onFeatureModeChanged;
  final ValueChanged<double> onFeaturePositionChanged;
  final ValueChanged<double> onFeatureThicknessChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF1F4E77), Color(0xFF426A8A), Color(0xFF7A4A65)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'DisplayFeatureSubScreen Control Deck',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 27),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tune simulated foldable display features and anchor policies, then inspect how sub-screen selection adapts under each scene.',
            style: TextStyle(color: Color(0xFFF2F8FF), fontSize: 13, height: 1.45),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: SwitchListTile(
                  value: rtl,
                  onChanged: onRtlChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('RTL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SwitchListTile(
                  value: useAnchorPoint,
                  onChanged: onUseAnchorChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Use anchorPoint', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SwitchListTile(
                  value: halfOpened,
                  onChanged: onHalfOpenedChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Half-open posture', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SwitchListTile(
                  value: showGuides,
                  onChanged: onShowGuidesChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Show guides', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SwitchListTile(
                  value: compactCards,
                  onChanged: onCompactChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Compact cards', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final mode in _FeatureMode.values)
                _ModeChip(
                  selected: featureMode == mode,
                  onTap: () => onFeatureModeChanged(mode),
                  label: _modeLabel(mode),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Feature position: ${featurePosition.toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          Slider(
            value: featurePosition,
            min: 0.15,
            max: 0.85,
            divisions: 14,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.25),
            onChanged: onFeaturePositionChanged,
          ),
          Text(
            'Feature thickness: ${featureThickness.toStringAsFixed(0)}',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          Slider(
            value: featureThickness,
            min: 6,
            max: 48,
            divisions: 14,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.25),
            onChanged: onFeatureThicknessChanged,
          ),
          Text(
            'Anchor: (${anchorPoint.dx.toStringAsFixed(1)}, ${anchorPoint.dy.toStringAsFixed(1)})',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _HeroBadge(label: rtl ? 'Fallback anchor: top-right' : 'Fallback anchor: top-left'),
              _HeroBadge(label: useAnchorPoint ? 'Explicit anchor active' : 'Directionality fallback active'),
              const _HeroBadge(label: 'MediaQuery.removeDisplayFeatures'),
              const _HeroBadge(label: 'avoidBounds + subScreensInBounds'),
              const _HeroBadge(label: 'Nearest sub-screen selection'),
            ],
          ),
        ],
      ),
    );
  }

  static String _modeLabel(_FeatureMode mode) {
    switch (mode) {
      case _FeatureMode.none:
        return 'No feature';
      case _FeatureMode.verticalHinge:
        return 'Vertical hinge';
      case _FeatureMode.horizontalFold:
        return 'Horizontal fold';
      case _FeatureMode.dualVertical:
        return 'Dual vertical';
      case _FeatureMode.topCutout:
        return 'Top cutout';
    }
  }
}

class _ModeChip extends StatelessWidget {
  const _ModeChip({
    required this.selected,
    required this.onTap,
    required this.label,
  });

  final bool selected;
  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: Colors.white.withValues(alpha: 0.45)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? const Color(0xFF1F4E77) : Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}

class _HeroBadge extends StatelessWidget {
  const _HeroBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
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
    required this.accent,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final int index;
  final Color accent;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.25)),
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
                  color: accent.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('$index', style: TextStyle(color: accent, fontWeight: FontWeight.w900)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(color: accent, fontSize: 19, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12, height: 1.45, color: accent.withValues(alpha: 0.84)),
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
          'DisplayFeatureSubScreen helps foldable-safe layouts: it chooses one logical pane and positions child there, rather than drawing across hinges or folds.',
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            _ConceptCard(
              title: 'Selection inputs',
              accent: Color(0xFF1F4E77),
              line1: '1) Screen bounds from MediaQuery.size',
              line2: '2) Splitting obstacles from displayFeatures',
              line3: '3) anchorPoint or Directionality fallback',
            ),
            _ConceptCard(
              title: 'Split conditions',
              accent: Color(0xFF1F4E77),
              line1: 'Feature must obstruct the surface.',
              line2: 'Feature must span full height or full width of pane.',
              line3: 'Otherwise, no pane split occurs.',
            ),
            _ConceptCard(
              title: 'Anchor fallback',
              accent: Color(0xFF1F4E77),
              line1: 'anchorPoint null + LTR -> top-left pane.',
              line2: 'anchorPoint null + RTL -> top-right pane.',
              line3: 'Without Directionality, debug assert occurs.',
            ),
            _ConceptCard(
              title: 'Child MediaQuery',
              accent: Color(0xFF1F4E77),
              line1: 'removeDisplayFeatures(selectedPane) is applied.',
              line2: 'Padding gets adjusted to selected pane offsets.',
              line3: 'Child sees local pane-relative coordinates.',
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF4F7FA),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFCBD7E1)),
          ),
          child: const SelectableText(
            'DisplayFeatureSubScreen(\n'
            '  anchorPoint: const Offset(520, 24),\n'
            '  child: PaneContent(),\n'
            ')\n\n'
            'If anchorPoint is null:\n'
            '- LTR => Offset.zero\n'
            '- RTL => Offset(double.maxFinite, 0)',
            style: TextStyle(fontSize: 11.1, height: 1.4),
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
      width: 300,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: accent.withValues(alpha: 0.24)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 13.2)),
            const SizedBox(height: 6),
            Text(line1, style: const TextStyle(fontSize: 11.2, height: 1.35)),
            const SizedBox(height: 3),
            Text(line2, style: const TextStyle(fontSize: 11.2, height: 1.35)),
            const SizedBox(height: 3),
            Text(line3, style: const TextStyle(fontSize: 11.2, height: 1.35)),
          ],
        ),
      ),
    );
  }
}

class _AnchorPlaygroundScene extends StatelessWidget {
  const _AnchorPlaygroundScene({
    required this.query,
    required this.anchorPoint,
    required this.useAnchorPoint,
    required this.showGuides,
    required this.compactCards,
    required this.onAnchorChanged,
  });

  final MediaQueryData query;
  final Offset anchorPoint;
  final bool useAnchorPoint;
  final bool showGuides;
  final bool compactCards;
  final ValueChanged<Offset> onAnchorChanged;

  @override
  Widget build(BuildContext context) {
    final avoidBounds = DisplayFeatureSubScreen.avoidBounds(query).toList();
    final subScreens = DisplayFeatureSubScreen.subScreensInBounds(Offset.zero & query.size, avoidBounds).toList();
    final effectiveAnchor = useAnchorPoint ? anchorPoint : _fallbackByDirection(Directionality.of(context), query.size);
    final selected = _closestRect(subScreens, effectiveAnchor);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _InfoLine(
          'Tap anywhere on the canvas to set anchor point. The selected pane is the nearest sub-screen from that anchor.',
        ),
        const SizedBox(height: 10),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: query.size.width,
              height: query.size.height,
              child: GestureDetector(
                onTapDown: (details) {
                  onAnchorChanged(details.localPosition);
                },
                child: MediaQuery(
                  data: query,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFEAF2F8), Color(0xFFF8EFE9)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            border: Border.all(color: const Color(0xFFB8C8D8), width: 1.2),
                          ),
                        ),
                      ),
                      if (showGuides)
                        Positioned.fill(
                          child: CustomPaint(
                            painter: _GridPainter(
                              color: const Color(0xFF7E93A8).withValues(alpha: 0.25),
                              step: 40,
                            ),
                          ),
                        ),
                      for (final f in query.displayFeatures)
                        Positioned.fromRect(
                          rect: f.bounds,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: const Color(0xFF4E5967).withValues(alpha: 0.58),
                              border: Border.all(color: Colors.black.withValues(alpha: 0.35)),
                            ),
                          ),
                        ),
                      if (showGuides)
                        for (final rect in subScreens)
                          Positioned.fromRect(
                            rect: rect,
                            child: IgnorePointer(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xFF1F4E77).withValues(alpha: 0.45), width: 1.2),
                                ),
                              ),
                            ),
                          ),
                      Positioned.fromRect(
                        rect: selected,
                        child: IgnorePointer(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFC57C37), width: 2),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: effectiveAnchor.dx - 7,
                        top: effectiveAnchor.dy - 7,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: useAnchorPoint ? const Color(0xFFC57C37) : const Color(0xFF1F4E77),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.25),
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                      DisplayFeatureSubScreen(
                        anchorPoint: useAnchorPoint ? anchorPoint : null,
                        child: _PaneDemoOverlay(
                          compactCards: compactCards,
                          title: 'Selected Pane Content',
                          subtitle: useAnchorPoint
                              ? 'anchorPoint is explicit'
                              : 'anchorPoint from Directionality fallback',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _TelemetryCard(
              label: 'Anchor used',
              value: '(${effectiveAnchor.dx.toStringAsFixed(1)}, ${effectiveAnchor.dy.toStringAsFixed(1)})',
              accent: const Color(0xFFC57C37),
            ),
            _TelemetryCard(
              label: 'Sub-screens',
              value: '${subScreens.length}',
              accent: const Color(0xFF1F4E77),
            ),
            _TelemetryCard(
              label: 'Display features',
              value: '${query.displayFeatures.length}',
              accent: const Color(0xFF1F4E77),
            ),
            _TelemetryCard(
              label: 'Selected rect',
              value: _fmtRect(selected),
              accent: const Color(0xFF2A7A71),
            ),
          ],
        ),
      ],
    );
  }

  static Offset _fallbackByDirection(TextDirection direction, Size size) {
    return direction == TextDirection.rtl ? Offset(size.width, 0) : Offset.zero;
  }

  static Rect _closestRect(List<Rect> subScreens, Offset anchor) {
    if (subScreens.isEmpty) {
      return Rect.zero;
    }
    Rect closest = subScreens.first;
    var best = _distanceToRect(anchor, closest);
    for (final rect in subScreens.skip(1)) {
      final d = _distanceToRect(anchor, rect);
      if (d < best) {
        best = d;
        closest = rect;
      }
    }
    return closest;
  }

  static double _distanceToRect(Offset point, Rect rect) {
    final dx = point.dx < rect.left
        ? rect.left - point.dx
        : point.dx > rect.right
            ? point.dx - rect.right
            : 0.0;
    final dy = point.dy < rect.top
        ? rect.top - point.dy
        : point.dy > rect.bottom
            ? point.dy - rect.bottom
            : 0.0;
    return math.sqrt(dx * dx + dy * dy);
  }

  static String _fmtRect(Rect rect) {
    return '(${rect.left.toStringAsFixed(0)}, ${rect.top.toStringAsFixed(0)}) '
        '${rect.width.toStringAsFixed(0)}x${rect.height.toStringAsFixed(0)}';
  }
}

class _PaneDemoOverlay extends StatelessWidget {
  const _PaneDemoOverlay({
    required this.compactCards,
    required this.title,
    required this.subtitle,
  });

  final bool compactCards;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final local = MediaQuery.of(context);
    final height = compactCards ? 30.0 : 40.0;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.88),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF1F4E77).withValues(alpha: 0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF1F4E77), fontSize: 13)),
              const SizedBox(height: 2),
              Text(subtitle, style: const TextStyle(fontSize: 11, color: Color(0xFF365C80))),
              const SizedBox(height: 6),
              Text(
                'Child MediaQuery.size: ${local.size.width.toStringAsFixed(0)} x ${local.size.height.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 10.4),
              ),
              Text(
                'Child displayFeatures count: ${local.displayFeatures.length}',
                style: const TextStyle(fontSize: 10.4),
              ),
              const SizedBox(height: 6),
              _MiniLane(color: const Color(0xFF2A7A71), label: 'Pane-safe chart lane', height: height),
              const SizedBox(height: 6),
              _MiniLane(color: const Color(0xFFC57C37), label: 'Pane-safe controls lane', height: height),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniLane extends StatelessWidget {
  const _MiniLane({required this.color, required this.label, required this.height});

  final Color color;
  final String label;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.32)),
      ),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(start: 10),
          child: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 11.3)),
        ),
      ),
    );
  }
}

class _TelemetryCard extends StatelessWidget {
  const _TelemetryCard({
    required this.label,
    required this.value,
    required this.accent,
  });

  final String label;
  final String value;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: accent.withValues(alpha: 0.25)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: TextStyle(color: accent, fontWeight: FontWeight.w700, fontSize: 11.2)),
                  const SizedBox(height: 3),
                  Text(value, style: TextStyle(color: accent.withValues(alpha: 0.9), fontSize: 10.6)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DirectionalityFallbackScene extends StatelessWidget {
  const _DirectionalityFallbackScene({
    required this.query,
    required this.compactCards,
  });

  final MediaQueryData query;
  final bool compactCards;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _FallbackCard(
          title: 'LTR fallback',
          direction: TextDirection.ltr,
          query: query,
          compactCards: compactCards,
        ),
        _FallbackCard(
          title: 'RTL fallback',
          direction: TextDirection.rtl,
          query: query,
          compactCards: compactCards,
        ),
      ],
    );
  }
}

class _FallbackCard extends StatelessWidget {
  const _FallbackCard({
    required this.title,
    required this.direction,
    required this.query,
    required this.compactCards,
  });

  final String title;
  final TextDirection direction;
  final MediaQueryData query;
  final bool compactCards;

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF2A7A71);

    return SizedBox(
      width: 300,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: accent.withValues(alpha: 0.24)),
        ),
        child: Directionality(
          textDirection: direction,
          child: MediaQuery(
            data: query,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$title (${direction.name})', style: const TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 13.2)),
                const SizedBox(height: 6),
                const Text(
                  'anchorPoint: null\nDisplayFeatureSubScreen chooses fallback from Directionality.',
                  style: TextStyle(fontSize: 10.4),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: 170,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF6FAF8),
                              border: Border.all(color: accent.withValues(alpha: 0.25)),
                            ),
                          ),
                        ),
                        for (final f in query.displayFeatures)
                          Positioned.fromRect(
                            rect: Rect.fromLTWH(
                              f.bounds.left * 170 / query.size.height,
                              f.bounds.top * 170 / query.size.height,
                              math.max(2, f.bounds.width * 170 / query.size.height),
                              math.max(2, f.bounds.height * 170 / query.size.height),
                            ),
                            child: ColoredBox(color: Colors.black.withValues(alpha: 0.4)),
                          ),
                        DisplayFeatureSubScreen(
                          child: _PaneDemoOverlay(
                            compactCards: compactCards,
                            title: 'Fallback-selected pane',
                            subtitle: direction == TextDirection.ltr
                                ? 'Expected near top-left'
                                : 'Expected near top-right',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureComparisonScene extends StatelessWidget {
  const _FeatureComparisonScene({
    required this.baseQuery,
    required this.anchorPoint,
    required this.useAnchorPoint,
    required this.halfOpened,
    required this.showGuides,
  });

  final MediaQueryData baseQuery;
  final Offset anchorPoint;
  final bool useAnchorPoint;
  final bool halfOpened;
  final bool showGuides;

  @override
  Widget build(BuildContext context) {
    final cards = <_ComparisonSpec>[
      _ComparisonSpec(
        title: 'Vertical hinge',
        mode: _FeatureMode.verticalHinge,
        color: const Color(0xFF96476B),
      ),
      _ComparisonSpec(
        title: 'Horizontal fold',
        mode: _FeatureMode.horizontalFold,
        color: const Color(0xFF96476B),
      ),
      _ComparisonSpec(
        title: 'Dual vertical hinges',
        mode: _FeatureMode.dualVertical,
        color: const Color(0xFF96476B),
      ),
      _ComparisonSpec(
        title: 'Top cutout',
        mode: _FeatureMode.topCutout,
        color: const Color(0xFF96476B),
      ),
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        for (final spec in cards)
          _ComparisonCard(
            spec: spec,
            baseQuery: baseQuery,
            anchorPoint: anchorPoint,
            useAnchorPoint: useAnchorPoint,
            halfOpened: halfOpened,
            showGuides: showGuides,
          ),
      ],
    );
  }
}

class _ComparisonSpec {
  const _ComparisonSpec({
    required this.title,
    required this.mode,
    required this.color,
  });

  final String title;
  final _FeatureMode mode;
  final Color color;
}

class _ComparisonCard extends StatelessWidget {
  const _ComparisonCard({
    required this.spec,
    required this.baseQuery,
    required this.anchorPoint,
    required this.useAnchorPoint,
    required this.halfOpened,
    required this.showGuides,
  });

  final _ComparisonSpec spec;
  final MediaQueryData baseQuery;
  final Offset anchorPoint;
  final bool useAnchorPoint;
  final bool halfOpened;
  final bool showGuides;

  @override
  Widget build(BuildContext context) {
    // Preview canvas dimensions. The MediaQuery size MUST match the
    // surrounding SizedBox: DisplayFeatureSubScreen positions its child via
    // a Padding whose insets are computed from `mediaQuery.size − closest
    // sub-screen edges` (see flutter/lib/src/widgets/display_feature_sub_screen.dart
    // line 111-118). When MQ size > parent box, the top/bottom padding can
    // exceed the available height (e.g. horizontalFold's bottom sub-screen
    // pushed content 40 px below the box), triggering a `RenderFlex
    // overflowed by 40 px on the bottom` framework error from `_MiniPaneCard`.
    // Keeping MQ size == SizedBox size means DFSS Padding fits exactly and
    // each sub-screen has enough room for the card's intrinsic Column height.
    const Size canvas = Size(300, 220);
    final query = baseQuery.copyWith(
      size: canvas,
      displayFeatures: _featuresForMode(spec.mode, canvas, halfOpened),
    );

    final avoid = DisplayFeatureSubScreen.avoidBounds(query).toList();
    final subScreens = DisplayFeatureSubScreen.subScreensInBounds(Offset.zero & query.size, avoid).toList();

    return SizedBox(
      width: 324, // canvas.width (300) + Container padding (12 × 2) so the
                  // inner SizedBox fits its declared 300 px without clamping
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: spec.color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: spec.color.withValues(alpha: 0.24)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(spec.title, style: TextStyle(color: spec.color, fontWeight: FontWeight.w800, fontSize: 13.1)),
            const SizedBox(height: 4),
            Text(
              'avoidBounds=${avoid.length} | subScreens=${subScreens.length}',
              style: TextStyle(color: spec.color.withValues(alpha: 0.86), fontSize: 10.2),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: canvas.width,
                height: canvas.height,
                child: MediaQuery(
                  data: query,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: spec.color.withValues(alpha: 0.2)),
                          ),
                        ),
                      ),
                      if (showGuides)
                        for (final rect in subScreens)
                          Positioned.fromRect(
                            rect: rect,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(color: spec.color.withValues(alpha: 0.28)),
                              ),
                            ),
                          ),
                      for (final feature in query.displayFeatures)
                        Positioned.fromRect(
                          rect: feature.bounds,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.45),
                              border: Border.all(color: Colors.black.withValues(alpha: 0.65)),
                            ),
                          ),
                        ),
                      DisplayFeatureSubScreen(
                        anchorPoint: useAnchorPoint
                            ? Offset(
                                math.min(anchorPoint.dx, query.size.width),
                                math.min(anchorPoint.dy, query.size.height),
                              )
                            : null,
                        child: _MiniPaneCard(title: spec.title, accent: spec.color),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static List<DisplayFeature> _featuresForMode(_FeatureMode mode, Size size, bool halfOpened) {
    final posture = halfOpened ? DisplayFeatureState.postureHalfOpened : DisplayFeatureState.postureFlat;

    switch (mode) {
      case _FeatureMode.none:
        return const <DisplayFeature>[];
      case _FeatureMode.verticalHinge:
        return <DisplayFeature>[
          DisplayFeature(
            bounds: Rect.fromLTWH(size.width / 2 - 8, 0, 16, size.height),
            type: DisplayFeatureType.hinge,
            state: posture,
          ),
        ];
      case _FeatureMode.horizontalFold:
        return <DisplayFeature>[
          DisplayFeature(
            bounds: Rect.fromLTWH(0, size.height / 2 - 8, size.width, 16),
            type: DisplayFeatureType.fold,
            state: posture,
          ),
        ];
      case _FeatureMode.dualVertical:
        return <DisplayFeature>[
          DisplayFeature(
            bounds: Rect.fromLTWH(size.width * 0.33 - 6, 0, 12, size.height),
            type: DisplayFeatureType.hinge,
            state: posture,
          ),
          DisplayFeature(
            bounds: Rect.fromLTWH(size.width * 0.66 - 6, 0, 12, size.height),
            type: DisplayFeatureType.hinge,
            state: posture,
          ),
        ];
      case _FeatureMode.topCutout:
        return <DisplayFeature>[
          DisplayFeature(
            bounds: Rect.fromLTWH(size.width * 0.44, 0, size.width * 0.12, 24),
            type: DisplayFeatureType.cutout,
            state: DisplayFeatureState.unknown,
          ),
        ];
    }
  }
}

class _MiniPaneCard extends StatelessWidget {
  const _MiniPaneCard({required this.title, required this.accent});

  final String title;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final local = MediaQuery.of(context);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: accent.withValues(alpha: 0.24)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Selected pane', style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 11.8)),
              const SizedBox(height: 2),
              Text(title, style: TextStyle(color: accent.withValues(alpha: 0.82), fontSize: 10.8)),
              const SizedBox(height: 6),
              Text(
                'size ${local.size.width.toStringAsFixed(0)}x${local.size.height.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 9.8),
              ),
              Text(
                'features in child ${local.displayFeatures.length}',
                style: const TextStyle(fontSize: 9.8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ApiInspectionScene extends StatelessWidget {
  const _ApiInspectionScene({
    required this.query,
    required this.anchorPoint,
    required this.useAnchorPoint,
  });

  final MediaQueryData query;
  final Offset anchorPoint;
  final bool useAnchorPoint;

  @override
  Widget build(BuildContext context) {
    final avoid = DisplayFeatureSubScreen.avoidBounds(query).toList();
    final subScreens = DisplayFeatureSubScreen.subScreensInBounds(Offset.zero & query.size, avoid).toList();

    final resolvedAnchor = useAnchorPoint
        ? anchorPoint
        : (Directionality.of(context) == TextDirection.rtl ? Offset(query.size.width, 0) : Offset.zero);

    final selected = _AnchorPlaygroundScene._closestRect(subScreens, resolvedAnchor);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _InfoLine(
          'This scene computes exact static API outputs from current MediaQueryData and shows how closest pane is chosen from those results.',
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _RectTableCard(
                title: 'avoidBounds(mediaQuery)',
                accent: const Color(0xFF5855A2),
                rects: avoid,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _RectTableCard(
                title: 'subScreensInBounds(...)',
                accent: const Color(0xFF5855A2),
                rects: subScreens,
                highlighted: selected,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F1FC),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFC9C8EA)),
          ),
          child: SelectableText(
            'Resolved anchor: (${resolvedAnchor.dx.toStringAsFixed(1)}, ${resolvedAnchor.dy.toStringAsFixed(1)})\n'
            'Selected pane: ${_AnchorPlaygroundScene._fmtRect(selected)}\n\n'
            'Distance rule:\n'
            'DisplayFeatureSubScreen chooses the pane with minimum point-to-rect distance from anchor.',
            style: const TextStyle(fontSize: 10.9, height: 1.4),
          ),
        ),
      ],
    );
  }
}

class _RectTableCard extends StatelessWidget {
  const _RectTableCard({
    required this.title,
    required this.accent,
    required this.rects,
    this.highlighted,
  });

  final String title;
  final Color accent;
  final List<Rect> rects;
  final Rect? highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 12.9)),
          const SizedBox(height: 8),
          if (rects.isEmpty)
            const Text('No rectangles'),
          if (rects.isNotEmpty)
            for (var i = 0; i < rects.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: (highlighted != null && highlighted == rects[i])
                          ? const Color(0xFFC57C37)
                          : accent.withValues(alpha: 0.2),
                      width: (highlighted != null && highlighted == rects[i]) ? 1.8 : 1,
                    ),
                  ),
                  child: Text(
                    '#$i  ${_AnchorPlaygroundScene._fmtRect(rects[i])}',
                    style: TextStyle(
                      fontSize: 10.5,
                      color: accent.withValues(alpha: 0.9),
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

class _PracticalPatternsScene extends StatelessWidget {
  const _PracticalPatternsScene({
    required this.query,
    required this.anchorPoint,
    required this.compactCards,
  });

  final MediaQueryData query;
  final Offset anchorPoint;
  final bool compactCards;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _PracticalCard(
          title: 'Anchor near left workflow pane',
          accent: const Color(0xFF6C682E),
          child: _PatternPreview(
            query: query,
            anchorPoint: const Offset(60, 120),
            compactCards: compactCards,
            title: 'Task board pane',
            subtitle: 'Primary list and quick actions',
          ),
        ),
        _PracticalCard(
          title: 'Anchor near right details pane',
          accent: const Color(0xFF6C682E),
          child: _PatternPreview(
            query: query,
            anchorPoint: Offset(query.size.width - 60, 80),
            compactCards: compactCards,
            title: 'Inspector pane',
            subtitle: 'Contextual details and controls',
          ),
        ),
        _PracticalCard(
          title: 'Anchor from interactive selection',
          accent: const Color(0xFF6C682E),
          child: _PatternPreview(
            query: query,
            anchorPoint: anchorPoint,
            compactCards: compactCards,
            title: 'User-selected pane',
            subtitle: 'Anchored from last playground tap',
          ),
        ),
      ],
    );
  }
}

class _PracticalCard extends StatelessWidget {
  const _PracticalCard({
    required this.title,
    required this.accent,
    required this.child,
  });

  final String title;
  final Color accent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: accent.withValues(alpha: 0.24)),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 13.1)),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}

class _PatternPreview extends StatelessWidget {
  const _PatternPreview({
    required this.query,
    required this.anchorPoint,
    required this.compactCards,
    required this.title,
    required this.subtitle,
  });

  final MediaQueryData query;
  final Offset anchorPoint;
  final bool compactCards;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF6C682E);
    final laneHeight = compactCards ? 30.0 : 40.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: 300,
        height: 180,
        child: MediaQuery(
          data: query,
          child: Stack(
            children: [
              Positioned.fill(
                child: ColoredBox(color: const Color(0xFFFBFAF1)),
              ),
              for (final f in query.displayFeatures)
                Positioned.fromRect(
                  rect: f.bounds,
                  child: ColoredBox(color: Colors.black.withValues(alpha: 0.35)),
                ),
              Positioned(
                left: anchorPoint.dx - 5,
                top: anchorPoint.dy - 5,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: const Color(0xFFC57C37),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white),
                  ),
                ),
              ),
              DisplayFeatureSubScreen(
                anchorPoint: anchorPoint,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.92),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: accent.withValues(alpha: 0.24)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: const TextStyle(fontWeight: FontWeight.w800, color: accent, fontSize: 11.8)),
                          Text(subtitle, style: const TextStyle(fontSize: 10.4, color: Color(0xFF7B7542))),
                          const SizedBox(height: 6),
                          _MiniLane(color: const Color(0xFF2A7A71), label: 'Module A', height: laneHeight),
                          const SizedBox(height: 6),
                          _MiniLane(color: const Color(0xFF1F4E77), label: 'Module B', height: laneHeight),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecapCard extends StatelessWidget {
  const _RecapCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFFEAF0F6), Color(0xFFF7ECE4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFFC1CCD8)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deep Demo Recap',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF31495B)),
          ),
          SizedBox(height: 8),
          Text(
            '1) DisplayFeatureSubScreen chooses a split-safe pane from MediaQuery displayFeatures.\n'
            '2) Explicit anchorPoint gives deterministic pane targeting; null uses Directionality fallback.\n'
            '3) avoidBounds() and subScreensInBounds() reveal the exact geometry used for pane selection.\n'
            '4) removeDisplayFeatures(...) modifies child MediaQuery so pane content renders with local-safe constraints.\n'
            '5) Hinge/fold features that span width/height split panes; small cutouts typically do not split panes.\n'
            '6) Pattern-based placement helps dialogs, panels, and modules remain foldable-aware without custom geometry code.',
            style: TextStyle(fontSize: 12.4, height: 1.45),
          ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  _GridPainter({required this.color, required this.step});

  final Color color;
  final double step;

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = color
      ..strokeWidth = 1;

    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.step != step;
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontSize: 12.4, height: 1.45));
  }
}
