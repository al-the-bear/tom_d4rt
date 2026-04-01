import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show PlatformViewHitTestBehavior;

const _cNavy = Color(0xFF0D3555);
const _cSky = Color(0xFF2E7AA8);
const _cMint = Color(0xFF2E8A79);
const _cAmber = Color(0xFFB98442);
const _cRose = Color(0xFF9B5A78);
const _cViolet = Color(0xFF615CA8);
const _cOlive = Color(0xFF74793E);

dynamic build(BuildContext context) {
  return const _ImgElementPlatformViewStudioApp();
}

class _ImgElementPlatformViewStudioApp extends StatelessWidget {
  const _ImgElementPlatformViewStudioApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _cSky),
        scaffoldBackgroundColor: const Color(0xFFF1F6FA),
      ),
      home: const _ImgElementPlatformViewStudioPage(),
    );
  }
}

class _ImgElementPlatformViewStudioPage extends StatefulWidget {
  const _ImgElementPlatformViewStudioPage();

  @override
  State<_ImgElementPlatformViewStudioPage> createState() => _ImgElementPlatformViewStudioPageState();
}

class _ImgElementPlatformViewStudioPageState extends State<_ImgElementPlatformViewStudioPage> {
  bool _compact = false;
  bool _showGrid = true;
  bool _showLabels = true;
  bool _rtl = false;
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    final config = _DemoConfig(
      compact: _compact,
      showGrid: _showGrid,
      showLabels: _showLabels,
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      scale: _scale,
    );

    return Directionality(
      textDirection: config.textDirection,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _cNavy,
          foregroundColor: Colors.white,
          toolbarHeight: 84,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('ImgElementPlatformView Deep Demo'),
              const SizedBox(height: 2),
              Text(
                kIsWeb
                    ? 'Runtime: Flutter Web (embedded DOM image surfaces)'
                    : 'Runtime: non-web (behavior simulation for interpreter testing)',
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
              _TopControls(
                compact: _compact,
                showGrid: _showGrid,
                showLabels: _showLabels,
                rtl: _rtl,
                scale: _scale,
                onCompactChanged: (v) => setState(() => _compact = v),
                onShowGridChanged: (v) => setState(() => _showGrid = v),
                onShowLabelsChanged: (v) => setState(() => _showLabels = v),
                onRtlChanged: (v) => setState(() => _rtl = v),
                onScaleChanged: (v) => setState(() => _scale = v),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 1,
                accent: _cSky,
                title: 'ImgElementPlatformView Concept and Runtime Contract',
                subtitle:
                    'Explains what ImgElementPlatformView does in Flutter web internals: it wraps an <img> element in a platform view, applies width/height defaults, and forwards src via creation params.',
                child: _ConceptScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 2,
                accent: _cMint,
                title: 'Source and Styling Studio',
                subtitle:
                    'Interactive src switching, BoxFit tuning, and style presets that mimic ImgElementPlatformView behavior while demonstrating rendering differences.',
                child: _SourceStudioScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 3,
                accent: _cAmber,
                title: 'Layout, Constraints, and Clipping Matrix',
                subtitle:
                    'Shows how an image-backed platform view behaves inside different constraint boxes, clipped containers, and aspect-ratio layouts.',
                child: _LayoutMatrixScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 4,
                accent: _cRose,
                title: 'Layering and Hit-Test Surface Lab',
                subtitle:
                    'Demonstrates overlay interactions and hit-test behavior choices relevant to platform-view surfaces in Flutter web composition.',
                child: _LayerHitTestScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 5,
                accent: _cViolet,
                title: 'Fallback and Diagnostics Patterns',
                subtitle:
                    'Covers null-src behavior, invalid sources, delayed updates, and practical logging patterns for robust image platform-view pipelines.',
                child: _FallbackDiagnosticsScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 6,
                accent: _cOlive,
                title: 'Practical Content Board Composition',
                subtitle:
                    'Assembles a realistic operations board that uses image platform-view tiles across hero, gallery, alerts, and action strips.',
                child: _PracticalBoardScene(config: config),
              ),
              const SizedBox(height: 12),
              const _RecapPanel(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _DemoConfig {
  const _DemoConfig({
    required this.compact,
    required this.showGrid,
    required this.showLabels,
    required this.textDirection,
    required this.scale,
  });

  final bool compact;
  final bool showGrid;
  final bool showLabels;
  final TextDirection textDirection;
  final double scale;
}

class _TopControls extends StatelessWidget {
  const _TopControls({
    required this.compact,
    required this.showGrid,
    required this.showLabels,
    required this.rtl,
    required this.scale,
    required this.onCompactChanged,
    required this.onShowGridChanged,
    required this.onShowLabelsChanged,
    required this.onRtlChanged,
    required this.onScaleChanged,
  });

  final bool compact;
  final bool showGrid;
  final bool showLabels;
  final bool rtl;
  final double scale;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onShowGridChanged;
  final ValueChanged<bool> onShowLabelsChanged;
  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<double> onScaleChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF173B5B), Color(0xFF2A6F83), Color(0xFF5C5DA3)],
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
              'ImgElementPlatformView Control Deck',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 28),
            ),
            const SizedBox(height: 6),
            Text(
              'This demo manually reproduces ImgElementPlatformView semantics with HtmlElementView.fromTagName(img) on web and a visual fallback on non-web, so interpreter behavior can be validated consistently.',
              style: const TextStyle(color: Color(0xFFE5EEF8), height: 1.35),
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
                    onChanged: onShowGridChanged,
                    title: const Text('Guide grid', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    value: showLabels,
                    onChanged: onShowLabelsChanged,
                    title: const Text('Labels', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
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
            const SizedBox(height: 4),
            Text(
              'Global scale: ${scale.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
            Slider(
              value: scale,
              min: 0.75,
              max: 1.4,
              divisions: 13,
              label: scale.toStringAsFixed(2),
              activeColor: Colors.white,
              inactiveColor: Colors.white.withValues(alpha: 0.35),
              onChanged: onScaleChanged,
            ),
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _DeckTag(label: 'src lifecycle'),
                _DeckTag(label: 'layout and clipping'),
                _DeckTag(label: 'hit-test surfaces'),
                _DeckTag(label: 'fallback diagnostics'),
                _DeckTag(label: 'practical composition'),
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
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
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
                      Text(subtitle, style: const TextStyle(color: Color(0xFF2E4455), height: 1.34)),
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

class _ConceptScene extends StatelessWidget {
  const _ConceptScene({required this.config});

  final _DemoConfig config;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: config.compact ? 520 : 620,
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: _BackdropBox(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Internal behavior map', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: config.compact ? 2 : 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 1.2,
                        children: const [
                          _ConceptTile(
                            title: 'Purpose',
                            note:
                                'Hosts a browser <img> element in a Flutter platform view, optimized for web image rendering paths where DOM-backed content is required.',
                            color: _cSky,
                          ),
                          _ConceptTile(
                            title: 'Input',
                            note: 'Takes a nullable src string. If src is null, the implementation returns an expanded empty box.',
                            color: _cMint,
                          ),
                          _ConceptTile(
                            title: 'Factory Registration',
                            note:
                                'Registers a view factory once and creates img elements with width/height 100% plus pointer-events none defaults.',
                            color: _cAmber,
                          ),
                          _ConceptTile(
                            title: 'Creation Params',
                            note:
                                'For each surface, src is forwarded through creation params so each platform view instance resolves the correct image URL.',
                            color: _cRose,
                          ),
                          _ConceptTile(
                            title: 'Hit Testing',
                            note:
                                'Uses transparent behavior in its implementation to avoid swallowing Flutter interactions above/below layered surfaces.',
                            color: _cViolet,
                          ),
                          _ConceptTile(
                            title: 'Interpreter Focus',
                            note:
                                'This demo emphasizes visual interaction and configuration patterns instead of API assertions, matching interpreter verification goals.',
                            color: _cOlive,
                          ),
                        ],
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
            child: _BackdropBox(
              showGrid: false,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Equivalent implementation preview', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    _InfoLine(label: 'runtime', value: kIsWeb ? 'web' : 'non-web simulation'),
                    const _InfoLine(label: 'element', value: '<img>'),
                    const _InfoLine(label: 'width/height', value: '100% / 100%'),
                    const _InfoLine(label: 'pointer events', value: 'none (default semantics)'),
                    const _InfoLine(label: 'factory type', value: 'platform view'),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: _softPanel(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Mini visual', style: TextStyle(fontWeight: FontWeight.w800)),
                            const SizedBox(height: 6),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _PreviewFrame(
                                      title: 'Valid src',
                                      child: _buildImgSurfaceEquivalent(
                                        src: _imgSources.first.src,
                                        fit: BoxFit.cover,
                                        behavior: PlatformViewHitTestBehavior.transparent,
                                        label: 'concept valid',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Expanded(
                                    child: _PreviewFrame(
                                      title: 'Null src',
                                      child: SizedBox.expand(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'On web, the left frame is a real DOM-backed image surface via HtmlElementView.fromTagName(img). On non-web, a styled simulation keeps this test visual and instructive.',
                              style: TextStyle(fontSize: 12, height: 1.3),
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
        ],
      ),
    );
  }
}

class _ConceptTile extends StatelessWidget {
  const _ConceptTile({required this.title, required this.note, required this.color});

  final String title;
  final String note;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Expanded(child: Text(note, style: const TextStyle(fontSize: 12, height: 1.3))),
        ],
      ),
    );
  }
}

class _SourceStudioScene extends StatefulWidget {
  const _SourceStudioScene({required this.config});

  final _DemoConfig config;

  @override
  State<_SourceStudioScene> createState() => _SourceStudioSceneState();
}

class _SourceStudioSceneState extends State<_SourceStudioScene> {
  int _index = 0;
  BoxFit _fit = BoxFit.cover;
  bool _nullSrc = false;
  bool _round = false;
  bool _customCss = true;
  bool _shadow = true;
  PlatformViewHitTestBehavior _behavior = PlatformViewHitTestBehavior.transparent;
  final List<String> _events = <String>[];

  void _log(String text) {
    setState(() {
      _events.insert(0, '${_time()} | $text');
      if (_events.length > 22) {
        _events.removeRange(22, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final source = _imgSources[_index];
    final activeSrc = _nullSrc ? null : source.src;
    final radius = _round ? 16.0 : 6.0;

    return SizedBox(
      height: config.compact ? 620 : 740,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _BackdropBox(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Source controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: List<Widget>.generate(
                          _imgSources.length,
                          (i) => ChoiceChip(
                            selected: _index == i,
                            label: Text(_imgSources[i].name),
                            onSelected: (_) {
                              setState(() => _index = i);
                              _log('source -> ${_imgSources[i].name}');
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      _FitSelector(
                        fit: _fit,
                        onChanged: (value) {
                          setState(() => _fit = value);
                          _log('fit -> $value');
                        },
                      ),
                      const SizedBox(height: 8),
                      _BehaviorSelector(
                        behavior: _behavior,
                        onChanged: (value) {
                          setState(() => _behavior = value);
                          _log('behavior -> $value');
                        },
                      ),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: _nullSrc,
                        onChanged: (v) {
                          setState(() => _nullSrc = v);
                          _log('null src = $v');
                        },
                        title: const Text('Use null src (SizedBox.expand semantics)'),
                      ),
                      SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: _round,
                        onChanged: (v) {
                          setState(() => _round = v);
                          _log('rounded host = $v');
                        },
                        title: const Text('Rounded clipping container'),
                      ),
                      SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: _customCss,
                        onChanged: (v) {
                          setState(() => _customCss = v);
                          _log('custom css = $v');
                        },
                        title: const Text('Apply custom element styles in callback'),
                      ),
                      SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: _shadow,
                        onChanged: (v) {
                          setState(() => _shadow = v);
                          _log('shadow overlay = $v');
                        },
                        title: const Text('Host panel shadow emphasis'),
                      ),
                      const SizedBox(height: 8),
                      _EventLog(title: 'Source studio log', events: _events),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _BackdropBox(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Live src surface comparison', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: _PreviewFrame(
                              title: 'Equivalent ImgElementPlatformView surface',
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radius),
                                  boxShadow: _shadow
                                      ? [
                                          BoxShadow(
                                            color: Colors.black.withValues(alpha: 0.15),
                                            blurRadius: 10,
                                            offset: const Offset(0, 6),
                                          ),
                                        ]
                                      : null,
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: _buildImgSurfaceEquivalent(
                                  src: activeSrc,
                                  fit: _fit,
                                  behavior: _behavior,
                                  useCustomStyle: _customCss,
                                  label: 'studio main',
                                  onElementCreated: (element) {
                                    _log('element created type=${element.runtimeType}');
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _PreviewFrame(
                              title: 'Flutter Image widget reference',
                              child: activeSrc == null
                                  ? const Center(
                                      child: Text(
                                        'Null src active\n(reference intentionally empty)',
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  : Image.network(
                                      activeSrc,
                                      fit: _fit,
                                      errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.error_outline, size: 32)),
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
                      decoration: _softPanel(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Selected source details', style: TextStyle(fontWeight: FontWeight.w800)),
                          const SizedBox(height: 6),
                          _InfoLine(label: 'name', value: source.name),
                          _InfoLine(label: 'description', value: source.description),
                          _InfoLine(label: 'src length', value: '${source.src.length} chars'),
                          _InfoLine(label: 'fit', value: '$_fit'),
                          _InfoLine(label: 'behavior', value: '$_behavior'),
                          _InfoLine(label: 'null src active', value: '$_nullSrc'),
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
}

class _FitSelector extends StatelessWidget {
  const _FitSelector({required this.fit, required this.onChanged});

  final BoxFit fit;
  final ValueChanged<BoxFit> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('BoxFit', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _fitChip(BoxFit.cover),
            _fitChip(BoxFit.contain),
            _fitChip(BoxFit.fill),
            _fitChip(BoxFit.fitWidth),
            _fitChip(BoxFit.fitHeight),
            _fitChip(BoxFit.none),
          ],
        ),
      ],
    );
  }

  Widget _fitChip(BoxFit value) {
    return ChoiceChip(
      selected: fit == value,
      label: Text(value.name),
      onSelected: (_) => onChanged(value),
    );
  }
}

class _BehaviorSelector extends StatelessWidget {
  const _BehaviorSelector({required this.behavior, required this.onChanged});

  final PlatformViewHitTestBehavior behavior;
  final ValueChanged<PlatformViewHitTestBehavior> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Hit-test behavior', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ChoiceChip(
              selected: behavior == PlatformViewHitTestBehavior.opaque,
              label: const Text('opaque'),
              onSelected: (_) => onChanged(PlatformViewHitTestBehavior.opaque),
            ),
            ChoiceChip(
              selected: behavior == PlatformViewHitTestBehavior.translucent,
              label: const Text('translucent'),
              onSelected: (_) => onChanged(PlatformViewHitTestBehavior.translucent),
            ),
            ChoiceChip(
              selected: behavior == PlatformViewHitTestBehavior.transparent,
              label: const Text('transparent'),
              onSelected: (_) => onChanged(PlatformViewHitTestBehavior.transparent),
            ),
          ],
        ),
      ],
    );
  }
}

class _LayoutMatrixScene extends StatefulWidget {
  const _LayoutMatrixScene({required this.config});

  final _DemoConfig config;

  @override
  State<_LayoutMatrixScene> createState() => _LayoutMatrixSceneState();
}

class _LayoutMatrixSceneState extends State<_LayoutMatrixScene> {
  bool _clip = true;
  bool _aspect = true;
  bool _padding = true;
  int _source = 1;
  BoxFit _fit = BoxFit.cover;

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final src = _imgSources[_source].src;
    final cards = <_LayoutSpec>[
      const _LayoutSpec('Square 1:1', 1.0, 120),
      const _LayoutSpec('Wide 16:9', 16 / 9, 120),
      const _LayoutSpec('Tall 3:4', 3 / 4, 140),
      const _LayoutSpec('Banner 3:1', 3.0, 120),
      const _LayoutSpec('Portrait 9:16', 9 / 16, 140),
      const _LayoutSpec('Cinema 21:9', 21 / 9, 120),
    ];

    return SizedBox(
      height: config.compact ? 640 : 760,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _BackdropBox(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Constraint matrix controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: List<Widget>.generate(
                          _imgSources.length,
                          (i) => ChoiceChip(
                            selected: _source == i,
                            label: Text(_imgSources[i].name),
                            onSelected: (_) => setState(() => _source = i),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      _FitSelector(fit: _fit, onChanged: (v) => setState(() => _fit = v)),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: _clip,
                        onChanged: (v) => setState(() => _clip = v),
                        title: const Text('Enable host ClipRRect'),
                      ),
                      SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: _aspect,
                        onChanged: (v) => setState(() => _aspect = v),
                        title: const Text('Use AspectRatio wrappers'),
                      ),
                      SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: _padding,
                        onChanged: (v) => setState(() => _padding = v),
                        title: const Text('Add inner host padding'),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: _softPanel(),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Why this section matters', style: TextStyle(fontWeight: FontWeight.w800)),
                            SizedBox(height: 6),
                            _BulletLine(text: 'ImgElementPlatformView returns a surface that fills available constraints.'),
                            _BulletLine(text: 'Host box sizing and clipping shape final visual composition.'),
                            _BulletLine(text: 'Fit mode influences perceived crop behavior for content-heavy images.'),
                            _BulletLine(text: 'Constraint matrices reveal artifacts early before production rollout.'),
                          ],
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
            child: _BackdropBox(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  itemCount: cards.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: config.compact ? 2 : 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: config.compact ? 1.0 : 1.06,
                  ),
                  itemBuilder: (context, index) {
                    final spec = cards[index];
                    return _matrixCell(
                      title: spec.title,
                      ratio: spec.ratio,
                      height: spec.height,
                      src: src,
                      fit: _fit,
                      clip: _clip,
                      aspect: _aspect,
                      padding: _padding,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _matrixCell({
    required String title,
    required double ratio,
    required double height,
    required String src,
    required BoxFit fit,
    required bool clip,
    required bool aspect,
    required bool padding,
  }) {
    Widget content = _buildImgSurfaceEquivalent(
      src: src,
      fit: fit,
      behavior: PlatformViewHitTestBehavior.transparent,
      label: title,
    );

    if (padding) {
      content = Padding(padding: const EdgeInsets.all(6), child: content);
    }

    if (aspect) {
      content = AspectRatio(aspectRatio: ratio, child: content);
    } else {
      content = SizedBox(height: height, child: content);
    }

    if (clip) {
      content = ClipRRect(borderRadius: BorderRadius.circular(12), child: content);
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FBFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E2EE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
          const SizedBox(height: 6),
          Expanded(child: content),
          const SizedBox(height: 6),
          Text('ratio: ${ratio.toStringAsFixed(2)} | fit: ${fit.name}', style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}

class _LayoutSpec {
  const _LayoutSpec(this.title, this.ratio, this.height);

  final String title;
  final double ratio;
  final double height;
}

class _LayerHitTestScene extends StatefulWidget {
  const _LayerHitTestScene({required this.config});

  final _DemoConfig config;

  @override
  State<_LayerHitTestScene> createState() => _LayerHitTestSceneState();
}

class _LayerHitTestSceneState extends State<_LayerHitTestScene> {
  PlatformViewHitTestBehavior _behavior = PlatformViewHitTestBehavior.transparent;
  bool _overlay = true;
  bool _pointerLabel = true;
  int _counter = 0;
  final List<String> _events = <String>[];

  void _push(String value) {
    setState(() {
      _events.insert(0, '${_time()} | $value');
      if (_events.length > 26) {
        _events.removeRange(26, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final src = _imgSources[2].src;

    return SizedBox(
      height: config.compact ? 620 : 740,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _BackdropBox(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Layering controls', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    _BehaviorSelector(
                      behavior: _behavior,
                      onChanged: (v) {
                        setState(() => _behavior = v);
                        _push('behavior -> $v');
                      },
                    ),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _overlay,
                      onChanged: (v) {
                        setState(() => _overlay = v);
                        _push('overlay actions = $v');
                      },
                      title: const Text('Show overlay action chips'),
                    ),
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _pointerLabel,
                      onChanged: (v) {
                        setState(() => _pointerLabel = v);
                        _push('pointer label = $v');
                      },
                      title: const Text('Show pointer event summary label'),
                    ),
                    const SizedBox(height: 8),
                    FilledButton.tonal(
                      onPressed: () {
                        setState(() => _counter += 1);
                        _push('manual action counter = $_counter');
                      },
                      child: Text('Increment action counter ($_counter)'),
                    ),
                    const SizedBox(height: 8),
                    Expanded(child: _EventLog(title: 'Layer lab events', events: _events)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _BackdropBox(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Interactive layered surface', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: _buildImgSurfaceEquivalent(
                                src: src,
                                fit: BoxFit.cover,
                                behavior: _behavior,
                                label: 'layer lab',
                                onElementCreated: (element) => _push('element created ${element.runtimeType}'),
                              ),
                            ),
                          ),
                          if (_overlay)
                            Positioned(
                              top: 10,
                              left: 10,
                              right: 10,
                              child: Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  ActionChip(
                                    label: const Text('Refresh'),
                                    onPressed: () => _push('overlay refresh action'),
                                  ),
                                  ActionChip(
                                    label: const Text('Pin'),
                                    onPressed: () => _push('overlay pin action'),
                                  ),
                                  ActionChip(
                                    label: const Text('Audit'),
                                    onPressed: () => _push('overlay audit action'),
                                  ),
                                ],
                              ),
                            ),
                          if (_pointerLabel)
                            Positioned(
                              right: 10,
                              bottom: 10,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xCC1F2D3A),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  'hitTest=${_behavior.name}',
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
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
                      decoration: _softPanel(),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Interpretation tips', style: TextStyle(fontWeight: FontWeight.w800)),
                          SizedBox(height: 6),
                          _BulletLine(text: 'transparent is often preferred for image-backed surfaces with Flutter overlays.'),
                          _BulletLine(text: 'opaque may absorb interactions intended for layers above.'),
                          _BulletLine(text: 'translucent allows both platform view and siblings to participate.'),
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
}

class _FallbackDiagnosticsScene extends StatefulWidget {
  const _FallbackDiagnosticsScene({required this.config});

  final _DemoConfig config;

  @override
  State<_FallbackDiagnosticsScene> createState() => _FallbackDiagnosticsSceneState();
}

class _FallbackDiagnosticsSceneState extends State<_FallbackDiagnosticsScene> {
  bool _nullSrc = false;
  bool _invalidSrc = false;
  bool _delayedSrc = false;
  double _delaySeconds = 1.0;
  final List<String> _events = <String>[];

  void _emit(String line) {
    setState(() {
      _events.insert(0, '${_time()} | $line');
      if (_events.length > 30) {
        _events.removeRange(30, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final validSrc = _imgSources[4].src;
    final brokenSrc = 'https://invalid.example.invalid/not-found-image.png';
    final selected = _nullSrc ? null : (_invalidSrc ? brokenSrc : validSrc);

    return SizedBox(
      height: config.compact ? 650 : 770,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _BackdropBox(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Fallback controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: _nullSrc,
                        onChanged: (v) {
                          setState(() => _nullSrc = v);
                          _emit('null src = $v');
                        },
                        title: const Text('Use null src'),
                      ),
                      SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: _invalidSrc,
                        onChanged: (v) {
                          setState(() => _invalidSrc = v);
                          _emit('invalid src = $v');
                        },
                        title: const Text('Use invalid src URL'),
                      ),
                      SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: _delayedSrc,
                        onChanged: (v) {
                          setState(() => _delayedSrc = v);
                          _emit('delayed source = $v');
                        },
                        title: const Text('Delay source assignment'),
                      ),
                      const SizedBox(height: 6),
                      _NumericSlider(
                        label: 'Delay seconds',
                        value: _delaySeconds,
                        min: 0.2,
                        max: 3,
                        onChanged: (v) => setState(() => _delaySeconds = v),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: _softPanel(),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Diagnostics strategy', style: TextStyle(fontWeight: FontWeight.w800)),
                            SizedBox(height: 6),
                            _BulletLine(text: 'Treat null src as intentional empty geometry, not always an error.'),
                            _BulletLine(text: 'Track element creation and src assignments in logs for reproducibility.'),
                            _BulletLine(text: 'Wrap critical UI zones with visual fallbacks for broken image paths.'),
                            _BulletLine(text: 'Use delayed assignment tests to mimic async source arrival.'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      _EventLog(title: 'Diagnostics log', events: _events),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _BackdropBox(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Resilience gallery', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: _PreviewFrame(
                              title: 'Primary surface',
                              child: _DelayedImgSurface(
                                enabled: _delayedSrc,
                                delay: Duration(milliseconds: (_delaySeconds * 1000).round()),
                                src: selected,
                                fit: BoxFit.cover,
                                onEvent: _emit,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _PreviewFrame(
                              title: 'Fallback wrapper',
                              child: _SafeImgSurface(
                                src: selected,
                                fallbackSrc: _imgSources[0].src,
                                onEvent: _emit,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _PreviewFrame(
                              title: 'Reference image',
                              child: selected == null
                                  ? const Center(child: Text('No source selected'))
                                  : Image.network(
                                      selected,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.broken_image, size: 34)),
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
                      decoration: _softPanel(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _InfoLine(label: 'effective src', value: selected ?? '(null)'),
                          _InfoLine(label: 'invalid src mode', value: '$_invalidSrc'),
                          _InfoLine(label: 'delayed src mode', value: '$_delayedSrc'),
                          _InfoLine(label: 'delay', value: '${_delaySeconds.toStringAsFixed(2)} sec'),
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
}

class _DelayedImgSurface extends StatefulWidget {
  const _DelayedImgSurface({
    required this.enabled,
    required this.delay,
    required this.src,
    required this.fit,
    required this.onEvent,
  });

  final bool enabled;
  final Duration delay;
  final String? src;
  final BoxFit fit;
  final ValueChanged<String> onEvent;

  @override
  State<_DelayedImgSurface> createState() => _DelayedImgSurfaceState();
}

class _DelayedImgSurfaceState extends State<_DelayedImgSurface> {
  String? _active;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  void didUpdateWidget(covariant _DelayedImgSurface oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enabled != widget.enabled || oldWidget.delay != widget.delay || oldWidget.src != widget.src) {
      _refresh();
    }
  }

  void _refresh() {
    if (!widget.enabled) {
      setState(() => _active = widget.src);
      widget.onEvent('delayed mode off -> immediate src set');
      return;
    }

    setState(() => _active = null);
    widget.onEvent('delayed mode on -> waiting ${widget.delay.inMilliseconds}ms');
    Future<void>.delayed(widget.delay, () {
      if (mounted) {
        setState(() => _active = widget.src);
        widget.onEvent('delayed src applied');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_active == null && widget.enabled) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }
    return _buildImgSurfaceEquivalent(
      src: _active,
      fit: widget.fit,
      behavior: PlatformViewHitTestBehavior.transparent,
      label: 'delayed surface',
    );
  }
}

class _SafeImgSurface extends StatelessWidget {
  const _SafeImgSurface({required this.src, required this.fallbackSrc, required this.onEvent});

  final String? src;
  final String fallbackSrc;
  final ValueChanged<String> onEvent;

  @override
  Widget build(BuildContext context) {
    final isBroken = src != null && src!.contains('invalid.example.invalid');
    final effective = (src == null || isBroken) ? fallbackSrc : src;
    onEvent((src == null || isBroken) ? 'fallback surface active' : 'fallback surface using primary src');

    return _buildImgSurfaceEquivalent(
      src: effective,
      fit: BoxFit.cover,
      behavior: PlatformViewHitTestBehavior.transparent,
      label: 'safe surface',
      useCustomStyle: true,
    );
  }
}

class _PracticalBoardScene extends StatefulWidget {
  const _PracticalBoardScene({required this.config});

  final _DemoConfig config;

  @override
  State<_PracticalBoardScene> createState() => _PracticalBoardSceneState();
}

class _PracticalBoardSceneState extends State<_PracticalBoardScene> {
  int _profile = 0;
  bool _compactRail = false;
  bool _highContrast = false;
  bool _showBadges = true;
  final List<String> _events = <String>[];

  void _push(String value) {
    setState(() {
      _events.insert(0, '${_time()} | $value');
      if (_events.length > 28) {
        _events.removeRange(28, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final profile = _profiles[_profile];
    final fg = _highContrast ? Colors.white : _cNavy;

    return SizedBox(
      height: config.compact ? 780 : 920,
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: _BackdropBox(
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
                        _profiles.length,
                        (i) => ChoiceChip(
                          selected: _profile == i,
                          label: Text(_profiles[i].name),
                          onSelected: (_) {
                            setState(() => _profile = i);
                            _push('profile -> ${_profiles[i].name}');
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
                          selected: _compactRail,
                          label: const Text('Compact rail'),
                          onSelected: (v) {
                            setState(() => _compactRail = v);
                            _push('compact rail = $v');
                          },
                        ),
                        FilterChip(
                          selected: _highContrast,
                          label: const Text('High contrast board'),
                          onSelected: (v) {
                            setState(() => _highContrast = v);
                            _push('high contrast = $v');
                          },
                        ),
                        FilterChip(
                          selected: _showBadges,
                          label: const Text('Status badges'),
                          onSelected: (v) {
                            setState(() => _showBadges = v);
                            _push('status badges = $v');
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: _highContrast ? const Color(0xFF1B2731) : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFD6E2EE)),
                        ),
                        child: Column(
                          children: [
                            _boardTop(profile, fg),
                            Expanded(
                              child: Row(
                                children: [
                                  _boardRail(profile, fg),
                                  Expanded(child: _boardContent(profile, fg)),
                                  _boardSide(profile, fg),
                                ],
                              ),
                            ),
                            _boardBottom(profile, fg),
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
            child: _EventLog(title: 'Board event stream', events: _events),
          ),
        ],
      ),
    );
  }

  Widget _boardTop(_BoardProfile profile, Color fg) {
    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: profile.tone.withValues(alpha: _highContrast ? 0.2 : 0.12),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            height: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: _buildImgSurfaceEquivalent(
                src: profile.heroSrc,
                fit: BoxFit.cover,
                behavior: PlatformViewHitTestBehavior.transparent,
                label: 'board hero',
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(profile.name, style: TextStyle(color: fg, fontWeight: FontWeight.w800, fontSize: 18)),
          const Spacer(),
          ...profile.actions.map(
            (a) => Padding(
              padding: const EdgeInsets.only(left: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => _push('top action ${a.label}'),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(a.label, style: TextStyle(color: fg, fontSize: 12, fontWeight: FontWeight.w700)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _boardRail(_BoardProfile profile, Color fg) {
    final width = _compactRail ? 70.0 : 102.0;
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: _highContrast ? const Color(0xFF223240) : const Color(0xFFF7FBFF),
        border: const Border(right: BorderSide(color: Color(0xFFD7E2EE))),
      ),
      child: ListView.builder(
        itemCount: profile.nav.length,
        itemBuilder: (context, index) {
          final item = profile.nav[index];
          return InkWell(
            onTap: () => _push('rail ${item.label}'),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              child: Column(
                children: [
                  SizedBox(
                    width: _compactRail ? 24 : 30,
                    height: _compactRail ? 24 : 30,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: _buildImgSurfaceEquivalent(
                        src: item.src,
                        fit: BoxFit.cover,
                        behavior: PlatformViewHitTestBehavior.transparent,
                        label: item.label,
                      ),
                    ),
                  ),
                  if (!_compactRail && widget.config.showLabels) ...[
                    const SizedBox(height: 4),
                    Text(item.label, style: TextStyle(fontSize: 10, color: fg), textAlign: TextAlign.center),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _boardContent(_BoardProfile profile, Color fg) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GridView.builder(
        itemCount: profile.cards.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1.18,
        ),
        itemBuilder: (context, index) {
          final card = profile.cards[index];
          return InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => _push('card ${card.title}'),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: card.color.withValues(alpha: _highContrast ? 0.22 : 0.12),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: card.color.withValues(alpha: 0.35)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 34,
                    height: 34,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: _buildImgSurfaceEquivalent(
                        src: card.src,
                        fit: BoxFit.cover,
                        behavior: PlatformViewHitTestBehavior.transparent,
                        label: card.title,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(card.title, style: TextStyle(color: fg, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  Expanded(
                    child: Text(card.note, style: TextStyle(color: fg.withValues(alpha: 0.85), fontSize: 12, height: 1.3)),
                  ),
                  if (_showBadges)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: card.color.withValues(alpha: 0.22),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(card.badge, style: TextStyle(fontSize: 10, color: fg, fontWeight: FontWeight.w700)),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _boardSide(_BoardProfile profile, Color fg) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: _highContrast ? const Color(0xFF21303D) : const Color(0xFFFDF8F8),
        border: const Border(left: BorderSide(color: Color(0xFFD7E2EE))),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Alerts', style: TextStyle(color: fg, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            ...profile.alerts.map(
              (alert) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: alert.color.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: alert.color.withValues(alpha: 0.35)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 18,
                      height: 18,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: _buildImgSurfaceEquivalent(
                          src: alert.src,
                          fit: BoxFit.cover,
                          behavior: PlatformViewHitTestBehavior.transparent,
                          label: alert.title,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(alert.title, style: TextStyle(color: fg, fontWeight: FontWeight.w700, fontSize: 12)),
                          const SizedBox(height: 2),
                          Text(alert.note, style: TextStyle(color: fg.withValues(alpha: 0.82), fontSize: 11, height: 1.3)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boardBottom(_BoardProfile profile, Color fg) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: _highContrast ? const Color(0xFF233340) : const Color(0xFFF8FAFD),
        border: const Border(top: BorderSide(color: Color(0xFFD7E2EE))),
      ),
      child: Row(
        children: [
          ...profile.footer.map(
            (f) => Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () => _push('footer ${f.label}'),
                child: Text(f.label, style: TextStyle(color: fg, fontWeight: FontWeight.w700, fontSize: 11)),
              ),
            ),
          ),
          const Spacer(),
          Text('DOM image platform-view composition', style: TextStyle(color: fg.withValues(alpha: 0.8), fontSize: 11)),
        ],
      ),
    );
  }
}

class _PreviewFrame extends StatelessWidget {
  const _PreviewFrame({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FBFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E2EE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
            child: Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: ClipRRect(borderRadius: BorderRadius.circular(8), child: child),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackdropBox extends StatelessWidget {
  const _BackdropBox({required this.showGrid, required this.child});

  final bool showGrid;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD7E2EE)),
        gradient: const LinearGradient(
          colors: [Color(0xFFF8FCFF), Color(0xFFEDF3FA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (showGrid) const CustomPaint(painter: _GridPainter()),
          child,
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  const _GridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    const step = 22.0;
    final p = Paint()..color = const Color(0x11000000);
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
        border: Border.all(color: const Color(0xFFD7E2EE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          if (events.isEmpty)
            const Text('No events yet.', style: TextStyle(color: Color(0xFF607489)))
          else
            ...events.map(
              (line) => Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(line, style: const TextStyle(fontSize: 11, fontFamily: 'monospace')),
              ),
            ),
        ],
      ),
    );
  }
}

class _NumericSlider extends StatelessWidget {
  const _NumericSlider({
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 130, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 12, height: 1.25))),
        ],
      ),
    );
  }
}

class _BulletLine extends StatelessWidget {
  const _BulletLine({required this.text});

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
            child: Icon(Icons.circle, size: 7, color: Color(0xFF3D5F7B)),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(height: 1.34))),
        ],
      ),
    );
  }
}

class _RecapPanel extends StatelessWidget {
  const _RecapPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: const Color(0xFF16344E), borderRadius: BorderRadius.circular(14)),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recap: ImgElementPlatformView', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
          SizedBox(height: 8),
          Text(
            'ImgElementPlatformView is the web-oriented image surface bridge between Flutter widgets and browser DOM img elements. This demo validates src handling, sizing, clipping, layering, and fallback patterns visually for interpreter reliability.',
            style: TextStyle(color: Color(0xFFD6E4F2), height: 1.36),
          ),
        ],
      ),
    );
  }
}

Widget _buildImgSurfaceEquivalent({
  required String? src,
  required BoxFit fit,
  required PlatformViewHitTestBehavior behavior,
  required String label,
  bool useCustomStyle = true,
  ValueChanged<Object>? onElementCreated,
}) {
  if (src == null) {
    return Container(
      color: const Color(0xFFF2F4F7),
      alignment: Alignment.center,
      child: const Text('null src\nSizedBox.expand behavior', textAlign: TextAlign.center),
    );
  }

  if (!kIsWeb) {
    return _NonWebImgSurfaceMock(src: src, fit: fit, label: label);
  }

  return HtmlElementView.fromTagName(
    tagName: 'img',
    hitTestBehavior: behavior,
    onElementCreated: (element) {
      _configureImgElement(
        element,
        src: src,
        fit: fit,
        label: label,
        customStyle: useCustomStyle,
      );
      onElementCreated?.call(element);
    },
  );
}

void _configureImgElement(
  Object element, {
  required String src,
  required BoxFit fit,
  required String label,
  required bool customStyle,
}) {
  if (!kIsWeb) {
    return;
  }

  final dynamic e = element;
  try {
    e.src = src;
  } catch (_) {}
  try {
    e.setAttribute('src', src);
  } catch (_) {}
  try {
    e.style.width = '100%';
    e.style.height = '100%';
    e.style.pointerEvents = 'none';
  } catch (_) {}

  if (customStyle) {
    final fitCss = switch (fit) {
      BoxFit.contain => 'contain',
      BoxFit.cover => 'cover',
      BoxFit.fill => 'fill',
      BoxFit.fitWidth => 'scale-down',
      BoxFit.fitHeight => 'scale-down',
      BoxFit.none => 'none',
      BoxFit.scaleDown => 'scale-down',
    };

    try {
      e.style.objectFit = fitCss;
      e.style.objectPosition = 'center';
      e.style.filter = 'saturate(1.02) contrast(1.02)';
      e.setAttribute('data-label', label);
      e.title = label;
      e.alt = label;
    } catch (_) {}
  }
}

class _NonWebImgSurfaceMock extends StatelessWidget {
  const _NonWebImgSurfaceMock({required this.src, required this.fit, required this.label});

  final String src;
  final BoxFit fit;
  final String label;

  @override
  Widget build(BuildContext context) {
    final hue = src.length % 360;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            HSLColor.fromAHSL(1, hue.toDouble(), 0.45, 0.90).toColor(),
            HSLColor.fromAHSL(1, (hue + 50).toDouble(), 0.44, 0.85).toColor(),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Icon(Icons.image, size: 36, color: Colors.black.withValues(alpha: 0.55)),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              color: const Color(0xAA1A2530),
              child: Text(
                'non-web mock\n$label\nfit=${fit.name}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 11),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImgSource {
  const _ImgSource({required this.name, required this.description, required this.src});

  final String name;
  final String description;
  final String src;
}

class _BoardProfile {
  const _BoardProfile({
    required this.name,
    required this.tone,
    required this.heroSrc,
    required this.actions,
    required this.nav,
    required this.cards,
    required this.alerts,
    required this.footer,
  });

  final String name;
  final Color tone;
  final String heroSrc;
  final List<_ActionDef> actions;
  final List<_ActionDef> nav;
  final List<_CardDef> cards;
  final List<_AlertDef> alerts;
  final List<_ActionDef> footer;
}

class _ActionDef {
  const _ActionDef({required this.label, required this.src});

  final String label;
  final String src;
}

class _CardDef {
  const _CardDef({required this.title, required this.note, required this.badge, required this.src, required this.color});

  final String title;
  final String note;
  final String badge;
  final String src;
  final Color color;
}

class _AlertDef {
  const _AlertDef({required this.title, required this.note, required this.src, required this.color});

  final String title;
  final String note;
  final String src;
  final Color color;
}

String _time() => DateTime.now().toIso8601String().substring(11, 19);

BoxDecoration _softPanel() {
  return BoxDecoration(
    color: const Color(0xFFF2F7FC),
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: const Color(0xFFD7E2EE)),
  );
}

String _svgData({
  required String id,
  required String title,
  required String c1,
  required String c2,
  required String c3,
}) {
  final raw = '''
<svg xmlns="http://www.w3.org/2000/svg" width="640" height="360" viewBox="0 0 640 360">
  <defs>
    <linearGradient id="g$id" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0%" stop-color="$c1" />
      <stop offset="100%" stop-color="$c2" />
    </linearGradient>
  </defs>
  <rect width="640" height="360" fill="url(#g$id)" />
  <circle cx="540" cy="88" r="74" fill="$c3" fill-opacity="0.24" />
  <rect x="48" y="78" width="300" height="170" rx="20" fill="#ffffff" fill-opacity="0.20" />
  <rect x="66" y="102" width="180" height="16" rx="8" fill="#ffffff" fill-opacity="0.74" />
  <rect x="66" y="132" width="254" height="12" rx="6" fill="#ffffff" fill-opacity="0.58" />
  <rect x="66" y="154" width="224" height="12" rx="6" fill="#ffffff" fill-opacity="0.58" />
  <rect x="66" y="176" width="260" height="12" rx="6" fill="#ffffff" fill-opacity="0.58" />
  <rect x="66" y="205" width="104" height="26" rx="13" fill="#ffffff" fill-opacity="0.84" />
  <text x="320" y="326" text-anchor="middle" font-size="28" font-family="Arial" fill="#ffffff" fill-opacity="0.92">$title</text>
</svg>
''';
  return 'data:image/svg+xml;utf8,${Uri.encodeComponent(raw)}';
}

final _imgSources = <_ImgSource>[
  _ImgSource(
    name: 'Aurora',
    description: 'Layered gradient card style for hero headers and emphasis panels.',
    src: _svgData(id: 'a', title: 'Aurora Surface', c1: '#1E4F73', c2: '#4D82A8', c3: '#A6E1FF'),
  ),
  _ImgSource(
    name: 'Coral',
    description: 'Warm contrast style useful for warning, workflow state, and urgency highlights.',
    src: _svgData(id: 'b', title: 'Coral Track', c1: '#8B4A5D', c2: '#C47E63', c3: '#FFD0A7'),
  ),
  _ImgSource(
    name: 'Forest',
    description: 'Calm operational visual style for healthy metrics and stable channels.',
    src: _svgData(id: 'c', title: 'Forest Board', c1: '#2F6652', c2: '#4D9472', c3: '#B6F6CF'),
  ),
  _ImgSource(
    name: 'Violet',
    description: 'Design-system themed surface often used in tooling dashboards.',
    src: _svgData(id: 'd', title: 'Violet Workspace', c1: '#4D4C90', c2: '#847DC4', c3: '#DDD5FF'),
  ),
  _ImgSource(
    name: 'Slate',
    description: 'Neutral analytical board style to keep focus on overlaid data and controls.',
    src: _svgData(id: 'e', title: 'Slate Matrix', c1: '#35495E', c2: '#58728B', c3: '#D6E6F5'),
  ),
  _ImgSource(
    name: 'Olive',
    description: 'Earth tone style suitable for planning contexts and long-horizon sections.',
    src: _svgData(id: 'f', title: 'Olive Planner', c1: '#586238', c2: '#8D9654', c3: '#ECF3B9'),
  ),
];

final _profiles = <_BoardProfile>[
  _BoardProfile(
    name: 'Operations Atlas',
    tone: _cSky,
    heroSrc: _imgSources[0].src,
    actions: [
      _ActionDef(label: 'Search', src: _imgSources[3].src),
      _ActionDef(label: 'Filter', src: _imgSources[4].src),
      _ActionDef(label: 'Export', src: _imgSources[1].src),
    ],
    nav: [
      _ActionDef(label: 'Overview', src: _imgSources[0].src),
      _ActionDef(label: 'Traffic', src: _imgSources[2].src),
      _ActionDef(label: 'Capacity', src: _imgSources[4].src),
      _ActionDef(label: 'Policy', src: _imgSources[5].src),
    ],
    cards: [
      _CardDef(
        title: 'Ingress Balance',
        note: 'Tracks inflow consistency and queue smoothness across regional channels.',
        badge: 'stable',
        src: _imgSources[2].src,
        color: _cMint,
      ),
      _CardDef(
        title: 'Release Lane',
        note: 'Visual lane for pending release artifacts and deploy readiness checks.',
        badge: 'watch',
        src: _imgSources[0].src,
        color: _cSky,
      ),
      _CardDef(
        title: 'Risk Envelope',
        note: 'Boundary overlay for policy and compliance risk near deployment windows.',
        badge: 'medium',
        src: _imgSources[1].src,
        color: _cRose,
      ),
      _CardDef(
        title: 'Design Pulse',
        note: 'Surface-level quality pulse for UI consistency and interaction polish.',
        badge: 'healthy',
        src: _imgSources[3].src,
        color: _cViolet,
      ),
      _CardDef(
        title: 'Storage Scope',
        note: 'Capacity trend panel for growth planning and retention constraints.',
        badge: 'review',
        src: _imgSources[4].src,
        color: _cAmber,
      ),
      _CardDef(
        title: 'Roadmap Rail',
        note: 'Forward-looking milestone board with strategic dependency highlights.',
        badge: 'aligned',
        src: _imgSources[5].src,
        color: _cOlive,
      ),
    ],
    alerts: [
      _AlertDef(title: 'Spike', note: 'p95 latency climbed 11% in one zone.', src: _imgSources[1].src, color: _cRose),
      _AlertDef(title: 'Drift', note: 'Input quality variance detected.', src: _imgSources[3].src, color: _cViolet),
      _AlertDef(title: 'Gate', note: 'Policy approval pending before merge.', src: _imgSources[5].src, color: _cOlive),
    ],
    footer: [
      _ActionDef(label: 'Snapshot', src: _imgSources[4].src),
      _ActionDef(label: 'Share', src: _imgSources[0].src),
      _ActionDef(label: 'Archive', src: _imgSources[2].src),
    ],
  ),
  _BoardProfile(
    name: 'Incident Canvas',
    tone: _cRose,
    heroSrc: _imgSources[1].src,
    actions: [
      _ActionDef(label: 'Bridge', src: _imgSources[3].src),
      _ActionDef(label: 'Route', src: _imgSources[4].src),
      _ActionDef(label: 'Comms', src: _imgSources[0].src),
    ],
    nav: [
      _ActionDef(label: 'Live', src: _imgSources[1].src),
      _ActionDef(label: 'Contain', src: _imgSources[2].src),
      _ActionDef(label: 'Recover', src: _imgSources[0].src),
      _ActionDef(label: 'Audit', src: _imgSources[4].src),
    ],
    cards: [
      _CardDef(
        title: 'Primary Incident',
        note: 'Main timeline and owner chain with priority escalation context.',
        badge: 'critical',
        src: _imgSources[1].src,
        color: _cRose,
      ),
      _CardDef(
        title: 'Containment',
        note: 'Immediate blast-radius constraints and override toggles.',
        badge: 'active',
        src: _imgSources[2].src,
        color: _cMint,
      ),
      _CardDef(
        title: 'Routing',
        note: 'Traffic steering controls for pressure balancing under outage load.',
        badge: 'live',
        src: _imgSources[4].src,
        color: _cAmber,
      ),
      _CardDef(
        title: 'Stakeholder Feed',
        note: 'Comms panel for updates, impacts, and estimated recovery times.',
        badge: 'queued',
        src: _imgSources[0].src,
        color: _cSky,
      ),
      _CardDef(
        title: 'Forensics',
        note: 'Post-event evidence trail and reconstruction checkpoint links.',
        badge: 'pending',
        src: _imgSources[3].src,
        color: _cViolet,
      ),
      _CardDef(
        title: 'Retrospective',
        note: 'Improvement backlog and ownership handoff status.',
        badge: 'open',
        src: _imgSources[5].src,
        color: _cOlive,
      ),
    ],
    alerts: [
      _AlertDef(title: 'Service Down', note: 'Checkout endpoint returning 500.', src: _imgSources[1].src, color: _cRose),
      _AlertDef(title: 'Queue Full', note: 'Message broker saturation high.', src: _imgSources[4].src, color: _cAmber),
      _AlertDef(title: 'Security Hold', note: 'Manual verification required.', src: _imgSources[5].src, color: _cOlive),
    ],
    footer: [
      _ActionDef(label: 'Runbook', src: _imgSources[3].src),
      _ActionDef(label: 'War Room', src: _imgSources[1].src),
      _ActionDef(label: 'Timeline', src: _imgSources[0].src),
    ],
  ),
  _BoardProfile(
    name: 'Design Studio',
    tone: _cViolet,
    heroSrc: _imgSources[3].src,
    actions: [
      _ActionDef(label: 'Tokens', src: _imgSources[5].src),
      _ActionDef(label: 'Preview', src: _imgSources[0].src),
      _ActionDef(label: 'Publish', src: _imgSources[2].src),
    ],
    nav: [
      _ActionDef(label: 'Palette', src: _imgSources[3].src),
      _ActionDef(label: 'Components', src: _imgSources[0].src),
      _ActionDef(label: 'Motion', src: _imgSources[4].src),
      _ActionDef(label: 'A11y', src: _imgSources[2].src),
    ],
    cards: [
      _CardDef(
        title: 'Token Layer',
        note: 'Semantic color and spacing token preview board.',
        badge: 'ready',
        src: _imgSources[5].src,
        color: _cOlive,
      ),
      _CardDef(
        title: 'Component Deck',
        note: 'Cross-density component coverage and icon language checks.',
        badge: 'draft',
        src: _imgSources[0].src,
        color: _cSky,
      ),
      _CardDef(
        title: 'Interaction Specs',
        note: 'Transition and response patterns for dynamic controls.',
        badge: 'review',
        src: _imgSources[4].src,
        color: _cAmber,
      ),
      _CardDef(
        title: 'Web Surface',
        note: 'Img element platform-view patterns for blended web UI zones.',
        badge: 'new',
        src: _imgSources[3].src,
        color: _cViolet,
      ),
      _CardDef(
        title: 'Accessibility',
        note: 'Contrast, semantics, and readability checkpoints.',
        badge: 'pass',
        src: _imgSources[2].src,
        color: _cMint,
      ),
      _CardDef(
        title: 'Delivery',
        note: 'Release packaging and documentation readiness markers.',
        badge: 'queued',
        src: _imgSources[1].src,
        color: _cRose,
      ),
    ],
    alerts: [
      _AlertDef(title: 'Contrast', note: 'One pair under threshold.', src: _imgSources[1].src, color: _cRose),
      _AlertDef(title: 'Token Drift', note: 'Unmapped semantic token.', src: _imgSources[5].src, color: _cOlive),
      _AlertDef(title: 'Review SLA', note: 'Design sign-off due in 4h.', src: _imgSources[3].src, color: _cViolet),
    ],
    footer: [
      _ActionDef(label: 'Export', src: _imgSources[4].src),
      _ActionDef(label: 'Sync', src: _imgSources[0].src),
      _ActionDef(label: 'Release', src: _imgSources[2].src),
    ],
  ),
];
