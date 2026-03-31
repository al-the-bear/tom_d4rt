import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

const _cNight = Color(0xFF172C40);
const _cBlue = Color(0xFF2D6A96);
const _cTeal = Color(0xFF2E8D7B);
const _cCoral = Color(0xFFB96C5D);
const _cViolet = Color(0xFF6A63AC);
const _cOlive = Color(0xFF6E7643);

dynamic build(BuildContext context) {
  return const _ImageFilteredDeepDemoApp();
}

class _ImageFilteredDeepDemoApp extends StatelessWidget {
  const _ImageFilteredDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _cBlue),
        scaffoldBackgroundColor: const Color(0xFFF2F6FA),
      ),
      home: const _ImageFilteredLabPage(),
    );
  }
}

class _ImageFilteredLabPage extends StatefulWidget {
  const _ImageFilteredLabPage();

  @override
  State<_ImageFilteredLabPage> createState() => _ImageFilteredLabPageState();
}

class _ImageFilteredLabPageState extends State<_ImageFilteredLabPage> {
  bool _compact = false;
  bool _showGrid = true;
  bool _showCaption = true;
  bool _rtl = false;
  double _globalScale = 1.0;

  @override
  Widget build(BuildContext context) {
    final config = _LabConfig(
      compact: _compact,
      showGrid: _showGrid,
      showCaption: _showCaption,
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      globalScale: _globalScale,
    );

    return Directionality(
      textDirection: config.textDirection,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _cNight,
          foregroundColor: Colors.white,
          toolbarHeight: 84,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('ImageFiltered Deep Demo'),
              const SizedBox(height: 2),
              Text(
                'Scale ${_globalScale.toStringAsFixed(2)} | Direction ${_rtl ? 'RTL' : 'LTR'} | Grid ${_showGrid ? 'on' : 'off'}',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ControlDeck(
                compact: _compact,
                showGrid: _showGrid,
                showCaption: _showCaption,
                rtl: _rtl,
                scale: _globalScale,
                onCompactChanged: (v) => setState(() => _compact = v),
                onGridChanged: (v) => setState(() => _showGrid = v),
                onCaptionChanged: (v) => setState(() => _showCaption = v),
                onRtlChanged: (v) => setState(() => _rtl = v),
                onScaleChanged: (v) => setState(() => _globalScale = v),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 1,
                accent: _cBlue,
                title: 'Filter Fundamentals',
                subtitle:
                    'Explains ImageFiltered basics, enabled behavior, and how child-only filtering differs from backdrop-oriented effects.',
                child: _FundamentalsScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 2,
                accent: _cTeal,
                title: 'Blur and Matrix Playground',
                subtitle:
                    'Interactive blur and geometric matrix transforms with matrix diagnostics and side-by-side previews.',
                child: _BlurMatrixScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 3,
                accent: _cCoral,
                title: 'Dilate and Erode Morphology Lab',
                subtitle:
                    'Demonstrates edge growth/shrink filters to visualize morphology operations on icons, text, and layered art.',
                child: _MorphologyScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 4,
                accent: _cViolet,
                title: 'Compose and Animation Studio',
                subtitle:
                    'Builds composed filter pipelines and animates transitions to showcase expressive visual storytelling with ImageFiltered.',
                child: _ComposeAnimationScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 5,
                accent: _cOlive,
                title: 'Scope and Placement Patterns',
                subtitle:
                    'Shows practical placement decisions: filter narrow subtrees, avoid over-filtering, and toggle enabled for cheap bypass.',
                child: _ScopePatternScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 6,
                accent: _cNight,
                title: 'Practical Creative Operations Board',
                subtitle:
                    'A realistic multipanel board with localized filter styles per zone and interaction logs for operational usage patterns.',
                child: _PracticalBoardScene(config: config),
              ),
              const SizedBox(height: 12),
              const _RecapCard(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _LabConfig {
  const _LabConfig({
    required this.compact,
    required this.showGrid,
    required this.showCaption,
    required this.textDirection,
    required this.globalScale,
  });

  final bool compact;
  final bool showGrid;
  final bool showCaption;
  final TextDirection textDirection;
  final double globalScale;
}

class _ControlDeck extends StatelessWidget {
  const _ControlDeck({
    required this.compact,
    required this.showGrid,
    required this.showCaption,
    required this.rtl,
    required this.scale,
    required this.onCompactChanged,
    required this.onGridChanged,
    required this.onCaptionChanged,
    required this.onRtlChanged,
    required this.onScaleChanged,
  });

  final bool compact;
  final bool showGrid;
  final bool showCaption;
  final bool rtl;
  final double scale;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onGridChanged;
  final ValueChanged<bool> onCaptionChanged;
  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<double> onScaleChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF17334B), Color(0xFF2E637B), Color(0xFF654E7D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ImageFiltered Control Deck',
              style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            const Text(
              'ImageFiltered applies a ui.ImageFilter to its child subtree only. Use enabled for efficient bypass rather than relying on no-op filters.',
              style: TextStyle(color: Color(0xFFEAF2F9), height: 1.36),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: SwitchListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    value: compact,
                    onChanged: onCompactChanged,
                    title: const Text('Compact', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    value: showGrid,
                    onChanged: onGridChanged,
                    title: const Text('Guide grid', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    value: showCaption,
                    onChanged: onCaptionChanged,
                    title: const Text('Show captions', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    value: rtl,
                    onChanged: onRtlChanged,
                    title: const Text('RTL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text('Global scale: ${scale.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            Slider(
              value: scale,
              min: 0.75,
              max: 1.5,
              divisions: 15,
              label: scale.toStringAsFixed(2),
              activeColor: Colors.white,
              inactiveColor: Colors.white.withValues(alpha: 0.3),
              onChanged: onScaleChanged,
            ),
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _DeckTag(label: 'enabled toggle behavior'),
                _DeckTag(label: 'blur / matrix / morphology'),
                _DeckTag(label: 'compose pipelines'),
                _DeckTag(label: 'scoped real-world placement'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DeckTag extends StatelessWidget {
  const _DeckTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
    );
  }
}

class _SceneCard extends StatelessWidget {
  const _SceneCard({
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
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 14, offset: const Offset(0, 6)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: accent,
                  foregroundColor: Colors.white,
                  child: Text('$index', style: const TextStyle(fontWeight: FontWeight.w800)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 18)),
                      const SizedBox(height: 4),
                      Text(subtitle, style: const TextStyle(color: Color(0xFF304454), height: 1.36)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}

class _FundamentalsScene extends StatefulWidget {
  const _FundamentalsScene({required this.config});

  final _LabConfig config;

  @override
  State<_FundamentalsScene> createState() => _FundamentalsSceneState();
}

class _FundamentalsSceneState extends State<_FundamentalsScene> {
  bool _enabled = true;
  double _sigma = 6;
  double _rotation = 0;
  bool _showOverlayText = true;
  bool _heavyChild = false;

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final filter = ui.ImageFilter.blur(sigmaX: _sigma, sigmaY: _sigma);

    return SizedBox(
      height: config.compact ? 520 : 620,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _GuideStage(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Fundamental controls', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _enabled,
                      onChanged: (v) => setState(() => _enabled = v),
                      title: const Text('ImageFiltered.enabled'),
                    ),
                    _LabeledSlider(
                      label: 'Blur sigma',
                      value: _sigma,
                      min: 0,
                      max: 20,
                      onChanged: (v) => setState(() => _sigma = v),
                    ),
                    _LabeledSlider(
                      label: 'Art rotation',
                      value: _rotation,
                      min: -math.pi,
                      max: math.pi,
                      onChanged: (v) => setState(() => _rotation = v),
                    ),
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _showOverlayText,
                      onChanged: (v) => setState(() => _showOverlayText = v),
                      title: const Text('Overlay labels'),
                    ),
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _heavyChild,
                      onChanged: (v) => setState(() => _heavyChild = v),
                      title: const Text('Complex child subtree'),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: _panelBox(),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Principles', style: TextStyle(fontWeight: FontWeight.w800)),
                            SizedBox(height: 6),
                            _Bullet(text: 'ImageFiltered affects only its child rendering output.'),
                            _Bullet(text: 'enabled=false bypasses filtering without replacing the widget.'),
                            _Bullet(text: 'No-op filters are still treated as active filters by design.'),
                            _Bullet(text: 'Use localized placement around only the visual subtree you need.'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _GuideStage(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Unfiltered vs filtered child', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: _artPanel(
                              title: 'Original child',
                              child: _DecorativeArt(
                                rotation: _rotation,
                                heavy: _heavyChild,
                                showOverlayText: _showOverlayText,
                              ),
                              tone: _cBlue,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _artPanel(
                              title: 'ImageFiltered child',
                              child: ImageFiltered(
                                imageFilter: filter,
                                enabled: _enabled,
                                child: _DecorativeArt(
                                  rotation: _rotation,
                                  heavy: _heavyChild,
                                  showOverlayText: _showOverlayText,
                                ),
                              ),
                              tone: _cTeal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: _panelBox(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _InfoLine(label: 'enabled', value: '$_enabled'),
                          _InfoLine(label: 'blur sigma', value: _sigma.toStringAsFixed(2)),
                          _InfoLine(label: 'rotation(rad)', value: _rotation.toStringAsFixed(3)),
                          _InfoLine(label: 'complex child', value: '$_heavyChild'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _artPanel({required String title, required Widget child, required Color tone}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _BlurMatrixScene extends StatefulWidget {
  const _BlurMatrixScene({required this.config});

  final _LabConfig config;

  @override
  State<_BlurMatrixScene> createState() => _BlurMatrixSceneState();
}

class _BlurMatrixSceneState extends State<_BlurMatrixScene> {
  bool _enabled = true;
  bool _matrixMode = false;
  bool _highQuality = true;
  double _sigmaX = 8;
  double _sigmaY = 2;
  double _scaleX = 1.0;
  double _scaleY = 1.0;
  double _skewX = 0.0;
  double _skewY = 0.0;
  double _rotation = 0.0;

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final filter = _matrixMode
        ? _matrixFilter(
            scaleX: _scaleX,
            scaleY: _scaleY,
            skewX: _skewX,
            skewY: _skewY,
            rotation: _rotation,
            highQuality: _highQuality,
          )
        : ui.ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY);

    return SizedBox(
      height: config.compact ? 610 : 720,
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: _GuideStage(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Mode controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: _enabled,
                        onChanged: (v) => setState(() => _enabled = v),
                        title: const Text('enabled'),
                      ),
                      FilterChip(
                        selected: _matrixMode,
                        label: const Text('Matrix mode (off = blur mode)'),
                        onSelected: (v) => setState(() => _matrixMode = v),
                      ),
                      const SizedBox(height: 6),
                      if (!_matrixMode) ...[
                        _LabeledSlider(label: 'sigmaX', value: _sigmaX, min: 0, max: 24, onChanged: (v) => setState(() => _sigmaX = v)),
                        _LabeledSlider(label: 'sigmaY', value: _sigmaY, min: 0, max: 24, onChanged: (v) => setState(() => _sigmaY = v)),
                      ] else ...[
                        SwitchListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          value: _highQuality,
                          onChanged: (v) => setState(() => _highQuality = v),
                          title: const Text('High filter quality'),
                        ),
                        _LabeledSlider(label: 'scaleX', value: _scaleX, min: 0.6, max: 1.8, onChanged: (v) => setState(() => _scaleX = v)),
                        _LabeledSlider(label: 'scaleY', value: _scaleY, min: 0.6, max: 1.8, onChanged: (v) => setState(() => _scaleY = v)),
                        _LabeledSlider(label: 'skewX', value: _skewX, min: -0.7, max: 0.7, onChanged: (v) => setState(() => _skewX = v)),
                        _LabeledSlider(label: 'skewY', value: _skewY, min: -0.7, max: 0.7, onChanged: (v) => setState(() => _skewY = v)),
                        _LabeledSlider(label: 'rotation', value: _rotation, min: -math.pi, max: math.pi, onChanged: (v) => setState(() => _rotation = v)),
                      ],
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: _panelBox(),
                        child: Text(
                          _matrixMode
                              ? 'Matrix filter active: ${_matrixDebug(_scaleX, _scaleY, _skewX, _skewY, _rotation)}'
                              : 'Blur filter active: sigmaX=${_sigmaX.toStringAsFixed(2)}, sigmaY=${_sigmaY.toStringAsFixed(2)}',
                          style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _GuideStage(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_matrixMode ? 'Matrix output' : 'Blur output', style: const TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: _filterShowcase(
                              title: 'Gallery strip',
                              child: _galleryStrip(),
                              filter: filter,
                              enabled: _enabled,
                              accent: _cBlue,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _filterShowcase(
                              title: 'Painter card',
                              child: _PainterCard(seed: 8, accent: _cCoral),
                              filter: filter,
                              enabled: _enabled,
                              accent: _cTeal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: _panelBox(),
                      child: const Text(
                        'Blur softens details; matrix warps sampling geometry. Use matrix filters intentionally because aggressive transforms can degrade readability.',
                        style: TextStyle(height: 1.34),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _galleryStrip() {
    const items = [
      _IconLabel(Icons.query_stats, 'Metrics'),
      _IconLabel(Icons.task_alt, 'Checks'),
      _IconLabel(Icons.route, 'Routing'),
      _IconLabel(Icons.cloud_upload, 'Deploy'),
      _IconLabel(Icons.radar, 'Signals'),
      _IconLabel(Icons.palette, 'Design'),
      _IconLabel(Icons.lock, 'Policy'),
      _IconLabel(Icons.auto_awesome, 'Refine'),
    ];

    return GridView.builder(
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1.1,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF7FBFF),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFD5E2ED)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.icon, color: _cNight),
              const SizedBox(height: 4),
              Text(item.label, style: const TextStyle(fontSize: 11)),
            ],
          ),
        );
      },
    );
  }

  Widget _filterShowcase({
    required String title,
    required Widget child,
    required ui.ImageFilter filter,
    required bool enabled,
    required Color accent,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Expanded(
            child: ImageFiltered(
              imageFilter: filter,
              enabled: enabled,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  ui.ImageFilter _matrixFilter({
    required double scaleX,
    required double scaleY,
    required double skewX,
    required double skewY,
    required double rotation,
    required bool highQuality,
  }) {
    final m = Matrix4.identity()
      ..rotateZ(rotation)
      ..scaleByDouble(scaleX, scaleY, 1.0, 1)
      ..setEntry(0, 1, skewX)
      ..setEntry(1, 0, skewY);
    return ui.ImageFilter.matrix(
      m.storage,
      filterQuality: highQuality ? FilterQuality.high : FilterQuality.low,
    );
  }

  String _matrixDebug(double sx, double sy, double kx, double ky, double r) {
    return 'sx=${sx.toStringAsFixed(2)} sy=${sy.toStringAsFixed(2)} kx=${kx.toStringAsFixed(2)} ky=${ky.toStringAsFixed(2)} rot=${r.toStringAsFixed(2)}';
  }
}

class _MorphologyScene extends StatefulWidget {
  const _MorphologyScene({required this.config});

  final _LabConfig config;

  @override
  State<_MorphologyScene> createState() => _MorphologySceneState();
}

class _MorphologySceneState extends State<_MorphologyScene> {
  bool _enabled = true;
  bool _dilateMode = true;
  bool _applyToText = true;
  bool _applyToIcons = true;
  double _radiusX = 4;
  double _radiusY = 4;

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final filter = _dilateMode
        ? ui.ImageFilter.dilate(radiusX: _radiusX, radiusY: _radiusY)
        : ui.ImageFilter.erode(radiusX: _radiusX, radiusY: _radiusY);

    return SizedBox(
      height: config.compact ? 560 : 670,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _GuideStage(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Morphology controls', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _enabled,
                      onChanged: (v) => setState(() => _enabled = v),
                      title: const Text('enabled'),
                    ),
                    FilterChip(
                      selected: _dilateMode,
                      label: Text(_dilateMode ? 'Dilate mode' : 'Erode mode'),
                      onSelected: (v) => setState(() => _dilateMode = v),
                    ),
                    const SizedBox(height: 6),
                    _LabeledSlider(label: 'radiusX', value: _radiusX, min: 0, max: 16, onChanged: (v) => setState(() => _radiusX = v)),
                    _LabeledSlider(label: 'radiusY', value: _radiusY, min: 0, max: 16, onChanged: (v) => setState(() => _radiusY = v)),
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _applyToText,
                      onChanged: (v) => setState(() => _applyToText = v),
                      title: const Text('Target text area'),
                    ),
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _applyToIcons,
                      onChanged: (v) => setState(() => _applyToIcons = v),
                      title: const Text('Target icon area'),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: _panelBox(),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Interpretation', style: TextStyle(fontWeight: FontWeight.w800)),
                            SizedBox(height: 6),
                            _Bullet(text: 'Dilate expands bright/opaque regions.'),
                            _Bullet(text: 'Erode contracts bright/opaque regions.'),
                            _Bullet(text: 'Morphology can create stylized emphasis or erosion effects.'),
                            _Bullet(text: 'Apply selectively: overuse can reduce readability.'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _GuideStage(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: _morphTile(
                              title: 'Text composition',
                              tone: _cCoral,
                              filter: filter,
                              enabled: _enabled && _applyToText,
                              child: _textComposition(),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _morphTile(
                              title: 'Icon composition',
                              tone: _cTeal,
                              filter: filter,
                              enabled: _enabled && _applyToIcons,
                              child: _iconComposition(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: _panelBox(),
                      child: Text(
                        'Mode: ${_dilateMode ? 'dilate' : 'erode'} | radiusX=${_radiusX.toStringAsFixed(2)} radiusY=${_radiusY.toStringAsFixed(2)}',
                        style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _morphTile({
    required String title,
    required Color tone,
    required ui.ImageFilter filter,
    required bool enabled,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Expanded(
            child: ImageFiltered(
              imageFilter: filter,
              enabled: enabled,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  Widget _textComposition() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFEBF5FF), Color(0xFFF8EEF5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('MORPH', style: TextStyle(fontSize: 42, fontWeight: FontWeight.w900, color: _cNight)),
            SizedBox(height: 4),
            Text('Visual edge sculpting with ImageFilter morphology.', style: TextStyle(fontSize: 13, color: Color(0xFF42586A))),
            Spacer(),
            Text('Use for stylization, not for primary legibility paths.', style: TextStyle(fontSize: 12, color: Color(0xFF5C7080))),
          ],
        ),
      ),
    );
  }

  Widget _iconComposition() {
    const icons = [
      Icons.rocket_launch,
      Icons.radar,
      Icons.shield,
      Icons.cloud_upload,
      Icons.query_stats,
      Icons.auto_awesome,
      Icons.route,
      Icons.check_circle,
      Icons.light_mode,
    ];

    return GridView.builder(
      itemCount: icons.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8FBFF),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFD5E2ED)),
          ),
          child: Icon(icons[index], size: 30, color: _cNight),
        );
      },
    );
  }
}

class _ComposeAnimationScene extends StatefulWidget {
  const _ComposeAnimationScene({required this.config});

  final _LabConfig config;

  @override
  State<_ComposeAnimationScene> createState() => _ComposeAnimationSceneState();
}

class _ComposeAnimationSceneState extends State<_ComposeAnimationScene> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _animate = false;
  bool _enabled = true;
  double _t = 0.35;
  int _pipeline = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2600));
    _controller.addListener(() {
      setState(() => _t = _controller.value);
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed && _animate) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final filter = _composedFilter(_pipeline, _t);

    return SizedBox(
      height: config.compact ? 560 : 680,
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: _GuideStage(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Compose controls', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List<Widget>.generate(
                        _pipelines.length,
                        (index) => ChoiceChip(
                          selected: _pipeline == index,
                          label: Text(_pipelines[index]),
                          onSelected: (_) => setState(() => _pipeline = index),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        FilledButton(
                          onPressed: () {
                            setState(() => _animate = !_animate);
                            if (_animate) {
                              _controller.forward(from: _t);
                            } else {
                              _controller.stop();
                            }
                          },
                          child: Text(_animate ? 'Pause' : 'Animate'),
                        ),
                        const SizedBox(width: 8),
                        FilledButton(
                          onPressed: () {
                            setState(() => _t = 0);
                            _controller.value = 0;
                          },
                          child: const Text('Reset'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _enabled,
                      onChanged: (v) => setState(() => _enabled = v),
                      title: const Text('enabled'),
                    ),
                    _LabeledSlider(
                      label: 'transition t',
                      value: _t,
                      min: 0,
                      max: 1,
                      onChanged: (v) {
                        setState(() => _t = v);
                        _controller.value = v;
                      },
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: _panelBox(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Pipeline details', style: TextStyle(fontWeight: FontWeight.w800)),
                            const SizedBox(height: 6),
                            Text(_pipelineDescription(_pipeline), style: const TextStyle(height: 1.34)),
                            const SizedBox(height: 8),
                            _InfoLine(label: 'animate', value: '$_animate'),
                            _InfoLine(label: 'enabled', value: '$_enabled'),
                            _InfoLine(label: 't', value: _t.toStringAsFixed(3)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _GuideStage(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: _cBlue.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: _cBlue.withValues(alpha: 0.3)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Original', style: TextStyle(fontWeight: FontWeight.w800, color: _cBlue)),
                                  const SizedBox(height: 6),
                                  const Expanded(child: _ComposeCanvas()),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: _cViolet.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: _cViolet.withValues(alpha: 0.3)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Composed filter result', style: TextStyle(fontWeight: FontWeight.w800, color: _cViolet)),
                                  const SizedBox(height: 6),
                                  Expanded(
                                    child: ImageFiltered(
                                      imageFilter: filter,
                                      enabled: _enabled,
                                      child: const _ComposeCanvas(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: _panelBox(),
                      child: const Text(
                        'compose lets you stack filters into an intentional pipeline. Start with simple blur/matrix components and tune each stage incrementally.',
                        style: TextStyle(height: 1.34),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ui.ImageFilter _composedFilter(int pipeline, double t) {
    final blur = ui.ImageFilter.blur(sigmaX: 2 + (t * 12), sigmaY: 2 + (t * 12));
    final m = Matrix4.identity()
      ..rotateZ((t - 0.5) * 0.5)
      ..scaleByDouble(1 + (t * 0.25), 1 - (t * 0.2), 1.0, 1)
      ..setEntry(0, 1, 0.2 * (t - 0.5));
    final matrix = ui.ImageFilter.matrix(m.storage, filterQuality: FilterQuality.high);
    final dilate = ui.ImageFilter.dilate(radiusX: 1 + (t * 4), radiusY: 1 + (t * 4));
    final erode = ui.ImageFilter.erode(radiusX: 1 + (t * 2), radiusY: 1 + (t * 2));

    if (pipeline == 0) {
      return ui.ImageFilter.compose(outer: blur, inner: matrix);
    }
    if (pipeline == 1) {
      return ui.ImageFilter.compose(outer: dilate, inner: blur);
    }
    return ui.ImageFilter.compose(outer: matrix, inner: erode);
  }

  String _pipelineDescription(int pipeline) {
    if (pipeline == 0) {
      return 'Pipeline A: matrix warping inside, blur outside. Good for cinematic motion softening.';
    }
    if (pipeline == 1) {
      return 'Pipeline B: blur first, then dilate edges. Creates bold glow-like silhouettes.';
    }
    return 'Pipeline C: erode inner details then matrix transform outer result. Useful for stylized degradation.';
  }
}

const _pipelines = <String>[
  'A: matrix -> blur',
  'B: blur -> dilate',
  'C: erode -> matrix',
];

class _ScopePatternScene extends StatefulWidget {
  const _ScopePatternScene({required this.config});

  final _LabConfig config;

  @override
  State<_ScopePatternScene> createState() => _ScopePatternSceneState();
}

class _ScopePatternSceneState extends State<_ScopePatternScene> {
  bool _filterCardOnly = true;
  bool _filterWholeSection = false;
  bool _enabled = true;
  double _sigma = 5;
  int _focusCard = 0;

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final filter = ui.ImageFilter.blur(sigmaX: _sigma, sigmaY: _sigma);

    return SizedBox(
      height: config.compact ? 620 : 740,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _GuideStage(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Placement controls', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _enabled,
                      onChanged: (v) => setState(() => _enabled = v),
                      title: const Text('enabled'),
                    ),
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _filterCardOnly,
                      onChanged: (v) => setState(() => _filterCardOnly = v),
                      title: const Text('Filter focused card only'),
                    ),
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _filterWholeSection,
                      onChanged: (v) => setState(() => _filterWholeSection = v),
                      title: const Text('Filter entire section'),
                    ),
                    _LabeledSlider(
                      label: 'section blur sigma',
                      value: _sigma,
                      min: 0,
                      max: 18,
                      onChanged: (v) => setState(() => _sigma = v),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List<Widget>.generate(
                        _scopeCards.length,
                        (index) => ChoiceChip(
                          selected: _focusCard == index,
                          label: Text(_scopeCards[index].title),
                          onSelected: (_) => setState(() => _focusCard = index),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: _panelBox(),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Pattern guidance', style: TextStyle(fontWeight: FontWeight.w800)),
                            SizedBox(height: 6),
                            _Bullet(text: 'Prefer smallest practical scope for filter application.'),
                            _Bullet(text: 'Wrap only selected cards when emphasizing one target.'),
                            _Bullet(text: 'Whole-section filtering can be useful for transition states.'),
                            _Bullet(text: 'Keep text legibility in mind when choosing sigma values.'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _GuideStage(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Scoped section demo', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Expanded(
                      child: _buildSection(filter),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: _panelBox(),
                      child: Text(
                        'focus=${_scopeCards[_focusCard].title} | cardOnly=$_filterCardOnly | wholeSection=$_filterWholeSection | sigma=${_sigma.toStringAsFixed(1)}',
                        style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(ui.ImageFilter filter) {
    Widget grid = GridView.builder(
      itemCount: _scopeCards.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1.2,
      ),
      itemBuilder: (context, index) {
        final item = _scopeCards[index];
        Widget card = _ScopeCard(item: item, focused: _focusCard == index);
        if (_filterCardOnly && _focusCard == index) {
          card = ImageFiltered(imageFilter: filter, enabled: _enabled, child: card);
        }
        return card;
      },
    );

    if (_filterWholeSection) {
      grid = ImageFiltered(imageFilter: filter, enabled: _enabled, child: grid);
    }
    return grid;
  }
}

class _ScopeItem {
  const _ScopeItem(this.title, this.note, this.icon, this.color);

  final String title;
  final String note;
  final IconData icon;
  final Color color;
}

const _scopeCards = <_ScopeItem>[
  _ScopeItem('Telemetry', 'Signal drift and trend quality.', Icons.query_stats, _cBlue),
  _ScopeItem('Policy', 'Compliance gate confidence.', Icons.gpp_good, _cTeal),
  _ScopeItem('Release', 'Rollout progression controls.', Icons.rocket_launch, _cCoral),
  _ScopeItem('Routing', 'Path balancing and queue flow.', Icons.route, _cViolet),
  _ScopeItem('Recovery', 'Fallback and rollback paths.', Icons.restore, _cOlive),
  _ScopeItem('Design', 'Visual language consistency.', Icons.palette, _cNight),
];

class _ScopeCard extends StatelessWidget {
  const _ScopeCard({required this.item, required this.focused});

  final _ScopeItem item;
  final bool focused;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: item.color.withValues(alpha: focused ? 0.2 : 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: item.color.withValues(alpha: focused ? 0.5 : 0.3), width: focused ? 2 : 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(item.icon, color: item.color),
          const SizedBox(height: 6),
          Text(item.title, style: TextStyle(color: item.color, fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Expanded(child: Text(item.note, style: const TextStyle(fontSize: 12, height: 1.3))),
        ],
      ),
    );
  }
}

class _PracticalBoardScene extends StatefulWidget {
  const _PracticalBoardScene({required this.config});

  final _LabConfig config;

  @override
  State<_PracticalBoardScene> createState() => _PracticalBoardSceneState();
}

class _PracticalBoardSceneState extends State<_PracticalBoardScene> {
  int _profile = 0;
  bool _heroFiltered = true;
  bool _thumbFiltered = true;
  bool _alertFiltered = false;
  bool _miniFiltered = true;
  bool _enabled = true;
  final List<String> _events = <String>[];

  void _push(String event) {
    setState(() {
      _events.insert(0, '${_clock()} | $event');
      if (_events.length > 28) {
        _events.removeRange(28, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final profile = _boardProfiles[_profile];

    return SizedBox(
      height: config.compact ? 760 : 900,
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: _GuideStage(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List<Widget>.generate(
                        _boardProfiles.length,
                        (index) => ChoiceChip(
                          selected: _profile == index,
                          label: Text(_boardProfiles[index].name),
                          onSelected: (_) {
                            setState(() => _profile = index);
                            _push('profile -> ${_boardProfiles[index].name}');
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilterChip(
                          selected: _enabled,
                          label: const Text('enabled'),
                          onSelected: (v) {
                            setState(() => _enabled = v);
                            _push('enabled = $v');
                          },
                        ),
                        FilterChip(
                          selected: _heroFiltered,
                          label: const Text('Hero zone filtered'),
                          onSelected: (v) {
                            setState(() => _heroFiltered = v);
                            _push('hero filtered = $v');
                          },
                        ),
                        FilterChip(
                          selected: _thumbFiltered,
                          label: const Text('Thumbnail grid filtered'),
                          onSelected: (v) {
                            setState(() => _thumbFiltered = v);
                            _push('thumb filtered = $v');
                          },
                        ),
                        FilterChip(
                          selected: _alertFiltered,
                          label: const Text('Alerts filtered'),
                          onSelected: (v) {
                            setState(() => _alertFiltered = v);
                            _push('alert filtered = $v');
                          },
                        ),
                        FilterChip(
                          selected: _miniFiltered,
                          label: const Text('Minimap filtered'),
                          onSelected: (v) {
                            setState(() => _miniFiltered = v);
                            _push('minimap filtered = $v');
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFD7E2ED)),
                        ),
                        child: Column(
                          children: [
                            _boardTopBar(profile),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(flex: 3, child: _heroZone(profile)),
                                  Expanded(flex: 4, child: _thumbGrid(profile)),
                                  Expanded(flex: 3, child: _rightColumn(profile)),
                                ],
                              ),
                            ),
                            _boardFooter(profile),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 6,
            child: _EventLog(title: 'Board interactions', events: _events),
          ),
        ],
      ),
    );
  }

  Widget _boardTopBar(_BoardProfile profile) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: profile.color.withValues(alpha: 0.12),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        border: const Border(bottom: BorderSide(color: Color(0xFFD7E2ED))),
      ),
      child: Row(
        children: [
          Icon(profile.leading, color: profile.color, size: 20),
          const SizedBox(width: 8),
          Text(profile.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: _cNight)),
          const Spacer(),
          ...profile.actions.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(left: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => _push('top action ${entry.label}'),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: Row(
                    children: [
                      Icon(entry.icon, size: 16, color: _cNight),
                      const SizedBox(width: 4),
                      Text(entry.label, style: const TextStyle(fontSize: 11)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _heroZone(_BoardProfile profile) {
    final filter = ui.ImageFilter.compose(
      outer: ui.ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      inner: ui.ImageFilter.matrix(
        (Matrix4.identity()..setEntry(0, 1, 0.18)).storage,
        filterQuality: FilterQuality.medium,
      ),
    );

    Widget content = Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [profile.color.withValues(alpha: 0.18), const Color(0xFFE8EFF9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const _DecorativeArt(rotation: 0.16, heavy: true, showOverlayText: true),
            ),
          ),
          const SizedBox(height: 8),
          Text('Hero visual lane', style: TextStyle(color: profile.color, fontWeight: FontWeight.w800)),
        ],
      ),
    );

    if (_heroFiltered) {
      content = ImageFiltered(imageFilter: filter, enabled: _enabled, child: content);
    }

    return Container(
      decoration: const BoxDecoration(border: Border(right: BorderSide(color: Color(0xFFD7E2ED)))),
      child: content,
    );
  }

  Widget _thumbGrid(_BoardProfile profile) {
    final filter = ui.ImageFilter.blur(sigmaX: 3, sigmaY: 3);

    Widget grid = GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: profile.tiles.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1.12,
      ),
      itemBuilder: (context, index) {
        final tile = profile.tiles[index];
        return InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => _push('tile ${tile.title}'),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: tile.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: tile.color.withValues(alpha: 0.32)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(tile.icon, color: tile.color),
                const SizedBox(height: 6),
                Text(tile.title, style: TextStyle(fontWeight: FontWeight.w800, color: tile.color)),
                const SizedBox(height: 4),
                Expanded(child: Text(tile.note, style: const TextStyle(fontSize: 12, height: 1.3))),
              ],
            ),
          ),
        );
      },
    );

    if (_thumbFiltered) {
      grid = ImageFiltered(imageFilter: filter, enabled: _enabled, child: grid);
    }
    return grid;
  }

  Widget _rightColumn(_BoardProfile profile) {
    final alertFilter = ui.ImageFilter.erode(radiusX: 1.5, radiusY: 1.5);
    final miniFilter = ui.ImageFilter.compose(
      outer: ui.ImageFilter.dilate(radiusX: 2, radiusY: 2),
      inner: ui.ImageFilter.blur(sigmaX: 2, sigmaY: 2),
    );

    Widget alerts = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Alerts', style: TextStyle(fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        ...profile.alerts.map(
          (a) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: a.color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: a.color.withValues(alpha: 0.34)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(a.icon, size: 16, color: a.color),
                const SizedBox(width: 6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(a.title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 2),
                      Text(a.note, style: const TextStyle(fontSize: 11, height: 1.3)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );

    if (_alertFiltered) {
      alerts = ImageFiltered(imageFilter: alertFilter, enabled: _enabled, child: alerts);
    }

    Widget miniMap = Container(
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [profile.color.withValues(alpha: 0.2), const Color(0xFFE5ECF8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const _MiniMapPainterCard(),
    );

    if (_miniFiltered) {
      miniMap = ImageFiltered(imageFilter: miniFilter, enabled: _enabled, child: miniMap);
    }

    return Container(
      decoration: const BoxDecoration(border: Border(left: BorderSide(color: Color(0xFFD7E2ED)))),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: alerts),
            const SizedBox(height: 8),
            const Text('Minimap', style: TextStyle(fontWeight: FontWeight.w800)),
            const SizedBox(height: 6),
            miniMap,
          ],
        ),
      ),
    );
  }

  Widget _boardFooter(_BoardProfile profile) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFD),
        border: Border(top: BorderSide(color: Color(0xFFD7E2ED))),
      ),
      child: Row(
        children: [
          ...profile.footer.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => _push('footer action ${entry.label}'),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: Row(
                    children: [
                      Icon(entry.icon, size: 14, color: _cNight),
                      const SizedBox(width: 4),
                      Text(entry.label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          Text('Profile ${profile.name}', style: const TextStyle(fontSize: 11, color: Color(0xFF5A6E7F))),
        ],
      ),
    );
  }
}

class _BoardProfile {
  const _BoardProfile({
    required this.name,
    required this.color,
    required this.leading,
    required this.actions,
    required this.tiles,
    required this.alerts,
    required this.footer,
  });

  final String name;
  final Color color;
  final IconData leading;
  final List<_ActionData> actions;
  final List<_TileData> tiles;
  final List<_AlertData> alerts;
  final List<_ActionData> footer;
}

class _ActionData {
  const _ActionData(this.icon, this.label);

  final IconData icon;
  final String label;
}

class _TileData {
  const _TileData(this.title, this.note, this.icon, this.color);

  final String title;
  final String note;
  final IconData icon;
  final Color color;
}

class _AlertData {
  const _AlertData(this.title, this.note, this.icon, this.color);

  final String title;
  final String note;
  final IconData icon;
  final Color color;
}

const _boardProfiles = <_BoardProfile>[
  _BoardProfile(
    name: 'Ops Clarity',
    color: _cBlue,
    leading: Icons.dashboard,
    actions: [
      _ActionData(Icons.search, 'Search'),
      _ActionData(Icons.filter_alt, 'Filter'),
      _ActionData(Icons.more_horiz, 'More'),
    ],
    tiles: [
      _TileData('Roadmap', 'Milestone map and dependency weave.', Icons.alt_route, _cBlue),
      _TileData('Queue', 'Build throughput and lane occupancy.', Icons.layers, _cTeal),
      _TileData('Risk', 'Escalation watch and confidence lanes.', Icons.warning_amber, _cCoral),
      _TileData('Metrics', 'Signal drift and trend narrative.', Icons.query_stats, _cViolet),
      _TileData('Recovery', 'Fallback and rollback readiness.', Icons.restore, _cOlive),
      _TileData('Design', 'Visual token consistency status.', Icons.palette, _cNight),
    ],
    alerts: [
      _AlertData('Latency', 'Service p95 rose by 9%.', Icons.speed, _cCoral),
      _AlertData('Queue', 'Build backlog above baseline.', Icons.timer, _cOlive),
      _AlertData('Policy', 'Compliance check due in 1h.', Icons.rule, _cViolet),
    ],
    footer: [
      _ActionData(Icons.download, 'Export'),
      _ActionData(Icons.bookmark, 'Snapshot'),
      _ActionData(Icons.share, 'Share'),
    ],
  ),
  _BoardProfile(
    name: 'Incident Focus',
    color: _cCoral,
    leading: Icons.local_fire_department,
    actions: [
      _ActionData(Icons.notifications_active, 'Alerts'),
      _ActionData(Icons.call, 'Bridge'),
      _ActionData(Icons.more_horiz, 'More'),
    ],
    tiles: [
      _TileData('Outage', 'Primary incident timeline board.', Icons.crisis_alert, _cCoral),
      _TileData('Contain', 'Boundary hardening controls.', Icons.shield, _cTeal),
      _TileData('Comms', 'Stakeholder update lanes.', Icons.campaign, _cBlue),
      _TileData('Forensics', 'Evidence and trace links.', Icons.manage_search, _cViolet),
      _TileData('Repair', 'Data and API remediation tracks.', Icons.auto_fix_high, _cOlive),
      _TileData('Closure', 'Postmortem and recovery report.', Icons.task_alt, _cNight),
    ],
    alerts: [
      _AlertData('Critical Path', 'Checkout route unstable.', Icons.warning_amber, _cCoral),
      _AlertData('Data Drift', 'Replication lag increased.', Icons.sync_problem, _cViolet),
      _AlertData('Support Load', 'Agent queue pressure high.', Icons.support_agent, _cTeal),
    ],
    footer: [
      _ActionData(Icons.call, 'War room'),
      _ActionData(Icons.book, 'Runbook'),
      _ActionData(Icons.archive, 'Archive'),
    ],
  ),
  _BoardProfile(
    name: 'Design Lens',
    color: _cViolet,
    leading: Icons.palette,
    actions: [
      _ActionData(Icons.layers, 'Layers'),
      _ActionData(Icons.text_fields, 'Type'),
      _ActionData(Icons.more_horiz, 'More'),
    ],
    tiles: [
      _TileData('Tokens', 'Color and type token alignment.', Icons.style, _cViolet),
      _TileData('Components', 'State matrix consistency pass.', Icons.widgets, _cBlue),
      _TileData('Motion', 'Animation pacing quality checks.', Icons.animation, _cTeal),
      _TileData('Contrast', 'Readability and ratio auditing.', Icons.visibility, _cOlive),
      _TileData('Localization', 'Directionality and truncation checks.', Icons.translate, _cCoral),
      _TileData('Signoff', 'Approval queue and readiness.', Icons.verified, _cNight),
    ],
    alerts: [
      _AlertData('Contrast', 'Two label pairs below threshold.', Icons.visibility_off, _cCoral),
      _AlertData('Token Drift', 'Unmapped semantic token found.', Icons.error_outline, _cViolet),
      _AlertData('SLA', 'Review SLA expires in 4h.', Icons.timer, _cTeal),
    ],
    footer: [
      _ActionData(Icons.file_download, 'Export'),
      _ActionData(Icons.auto_awesome, 'Generate'),
      _ActionData(Icons.send, 'Submit'),
    ],
  ),
];

class _DecorativeArt extends StatelessWidget {
  const _DecorativeArt({required this.rotation, required this.heavy, required this.showOverlayText});

  final double rotation;
  final bool heavy;
  final bool showOverlayText;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFECF5FF), Color(0xFFF7EBF4), Color(0xFFE9F6EF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Transform.rotate(
              angle: rotation,
              child: CustomPaint(
                painter: _ArtPainter(heavy: heavy),
              ),
            ),
            if (showOverlayText)
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.72),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text(
                    'ImageFiltered child output',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _cNight),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ArtPainter extends CustomPainter {
  _ArtPainter({required this.heavy});

  final bool heavy;

  @override
  void paint(Canvas canvas, Size size) {
    final p1 = Paint()..color = _cBlue.withValues(alpha: 0.25);
    final p2 = Paint()..color = _cTeal.withValues(alpha: 0.24);
    final p3 = Paint()..color = _cCoral.withValues(alpha: 0.22);
    final p4 = Paint()..color = _cViolet.withValues(alpha: 0.20);

    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.28), size.shortestSide * 0.2, p1);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.42, size.height * 0.14, size.width * 0.4, size.height * 0.28),
        const Radius.circular(24),
      ),
      p2,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(size.width * 0.38, size.height * 0.72), width: size.width * 0.52, height: size.height * 0.34),
      p3,
    );
    canvas.drawCircle(Offset(size.width * 0.78, size.height * 0.67), size.shortestSide * 0.14, p4);

    final line = Paint()
      ..color = const Color(0x33436174)
      ..strokeWidth = 1.5;
    for (double y = 14; y < size.height; y += 22) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y + (math.sin(y / 20) * 6)), line);
    }

    if (heavy) {
      final dot = Paint()..color = const Color(0x22506A80);
      for (double x = 0; x < size.width; x += 16) {
        for (double y = 0; y < size.height; y += 16) {
          final dx = x + (math.sin(y * 0.1) * 2);
          final dy = y + (math.cos(x * 0.08) * 2);
          canvas.drawCircle(Offset(dx, dy), 1.6, dot);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ArtPainter oldDelegate) => oldDelegate.heavy != heavy;
}

class _PainterCard extends StatelessWidget {
  const _PainterCard({required this.seed, required this.accent});

  final int seed;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [accent.withValues(alpha: 0.22), const Color(0xFFF7FAFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: CustomPaint(
        painter: _WavePainter(seed: seed, accent: accent),
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  _WavePainter({required this.seed, required this.accent});

  final int seed;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (int i = 0; i < 6; i++) {
      final path = Path();
      final yBase = size.height * (0.14 + (i * 0.13));
      path.moveTo(0, yBase);
      for (double x = 0; x <= size.width; x += 8) {
        final y = yBase + math.sin((x / 30) + (i * 0.7) + (seed * 0.2)) * (8 + i * 2);
        path.lineTo(x, y);
      }
      paint.color = accent.withValues(alpha: 0.18 + (i * 0.09));
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _WavePainter oldDelegate) {
    return oldDelegate.seed != seed || oldDelegate.accent != accent;
  }
}

class _ComposeCanvas extends StatelessWidget {
  const _ComposeCanvas();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEAF4FF), Color(0xFFF8EAF4), Color(0xFFEAF7EF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          const _DecorativeArt(rotation: 0.1, heavy: true, showOverlayText: false),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 180,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.75),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD0DEEA)),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('PIPELINE', style: TextStyle(fontWeight: FontWeight.w900, color: _cNight)),
                  SizedBox(height: 4),
                  Text('inner -> outer', style: TextStyle(fontSize: 12, color: Color(0xFF4B5F71))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniMapPainterCard extends StatelessWidget {
  const _MiniMapPainterCard();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _MiniMapPainter(),
    );
  }
}

class _MiniMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final border = Paint()
      ..style = PaintingStyle.stroke
      ..color = const Color(0xFF6B7E90)
      ..strokeWidth = 1.2;
    final lane = Paint()..color = const Color(0x334A6278);
    final active = Paint()..color = const Color(0x88657CCF);

    final rect = Rect.fromLTWH(8, 8, size.width - 16, size.height - 16);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(10)), border);

    for (int i = 0; i < 5; i++) {
      final y = rect.top + 10 + (i * 20);
      canvas.drawLine(Offset(rect.left + 8, y), Offset(rect.right - 8, y), lane);
    }

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(rect.left + 26, rect.top + 22, rect.width * 0.44, rect.height * 0.38),
        const Radius.circular(8),
      ),
      active,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(rect.left + 84, rect.top + 62, rect.width * 0.34, rect.height * 0.23),
        const Radius.circular(8),
      ),
      active..color = const Color(0x6689A1D8),
    );
  }

  @override
  bool shouldRepaint(covariant _MiniMapPainter oldDelegate) => false;
}

class _IconLabel {
  const _IconLabel(this.icon, this.label);

  final IconData icon;
  final String label;
}

class _GuideStage extends StatelessWidget {
  const _GuideStage({required this.showGrid, required this.child});

  final bool showGrid;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD7E2ED)),
        gradient: const LinearGradient(
          colors: [Color(0xFFF8FCFF), Color(0xFFECF3FA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (showGrid) CustomPaint(painter: _GridPainter()),
          child,
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = const Color(0x11000000);
    const step = 22.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LabeledSlider extends StatelessWidget {
  const _LabeledSlider({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ${value.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
        Slider(value: value, min: min, max: max, onChanged: onChanged),
      ],
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(width: 140, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 5),
            child: Icon(Icons.circle, size: 7, color: Color(0xFF385A75)),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(height: 1.34))),
        ],
      ),
    );
  }
}

class _EventLog extends StatelessWidget {
  const _EventLog({required this.title, required this.events});

  final String title;
  final List<String> events;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFCFDFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD9E4F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          if (events.isEmpty)
            const Text('No interactions yet.', style: TextStyle(color: Color(0xFF5E7283)))
          else
            ...events.map(
              (line) => Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(line, style: const TextStyle(fontSize: 12, fontFamily: 'monospace')),
              ),
            ),
        ],
      ),
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
        color: const Color(0xFF183148),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recap: ImageFiltered', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
          SizedBox(height: 8),
          Text(
            'ImageFiltered is best used as a scoped visual lens. Keep it close to the subtree you intend to stylize, use enabled for efficient toggling, and choose filter pipelines that preserve readability where users need precise information.',
            style: TextStyle(color: Color(0xFFD8E6F3), height: 1.38),
          ),
        ],
      ),
    );
  }
}

BoxDecoration _panelBox() {
  return BoxDecoration(
    color: const Color(0xFFF2F7FC),
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: const Color(0xFFD7E2EE)),
  );
}

String _clock() => DateTime.now().toIso8601String().substring(11, 19);
