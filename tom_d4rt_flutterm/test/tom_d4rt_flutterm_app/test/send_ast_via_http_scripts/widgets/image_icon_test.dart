import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const _cInk = Color(0xFF192E44);
const _cBlue = Color(0xFF2C6792);
const _cTeal = Color(0xFF2E8B78);
const _cCoral = Color(0xFFB96C5D);
const _cViolet = Color(0xFF6760A7);
const _cOlive = Color(0xFF6C7442);

dynamic build(BuildContext context) {
  return const _ImageIconStudioApp();
}

class _ImageIconStudioApp extends StatelessWidget {
  const _ImageIconStudioApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _cBlue),
        scaffoldBackgroundColor: const Color(0xFFF2F6FA),
      ),
      home: const _ImageIconStudioHome(),
    );
  }
}

class _ImageIconStudioHome extends StatefulWidget {
  const _ImageIconStudioHome();

  @override
  State<_ImageIconStudioHome> createState() => _ImageIconStudioHomeState();
}

class _ImageIconStudioHomeState extends State<_ImageIconStudioHome> {
  late Future<_IconAssetBundle> _bundleFuture;
  int _seed = 1;

  bool _compact = false;
  bool _showGrid = true;
  bool _showLabels = true;
  bool _rtl = false;
  double _globalScale = 1.0;

  @override
  void initState() {
    super.initState();
    _bundleFuture = _IconGlyphFactory.generateBundle(seed: _seed);
  }

  void _regenerate() {
    setState(() {
      _seed += 1;
      _bundleFuture = _IconGlyphFactory.generateBundle(seed: _seed);
    });
  }

  @override
  Widget build(BuildContext context) {
    final settings = _DemoSettings(
      compact: _compact,
      showGrid: _showGrid,
      showLabels: _showLabels,
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      globalScale: _globalScale,
      seed: _seed,
    );

    return Directionality(
      textDirection: settings.textDirection,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _cInk,
          foregroundColor: Colors.white,
          toolbarHeight: 84,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('ImageIcon Deep Demo'),
              const SizedBox(height: 2),
              Text(
                'Seed ${settings.seed} | Scale ${settings.globalScale.toStringAsFixed(2)} | Direction ${_rtl ? 'RTL' : 'LTR'}',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        body: FutureBuilder<_IconAssetBundle>(
          future: _bundleFuture,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final bundle = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _TopRibbon(
                    compact: _compact,
                    showGrid: _showGrid,
                    showLabels: _showLabels,
                    rtl: _rtl,
                    scale: _globalScale,
                    seed: _seed,
                    onCompactChanged: (v) => setState(() => _compact = v),
                    onGridChanged: (v) => setState(() => _showGrid = v),
                    onLabelsChanged: (v) => setState(() => _showLabels = v),
                    onRtlChanged: (v) => setState(() => _rtl = v),
                    onScaleChanged: (v) => setState(() => _globalScale = v),
                    onRegenerate: _regenerate,
                  ),
                  const SizedBox(height: 12),
                  _SectionBlock(
                    index: 1,
                    accent: _cBlue,
                    title: 'Source Generation Lab',
                    subtitle:
                        'Generates icon glyph images in-memory so ImageIcon demos are self-contained and deterministic without external assets.',
                    child: _SourceGenerationSection(settings: settings, bundle: bundle),
                  ),
                  const SizedBox(height: 12),
                  _SectionBlock(
                    index: 2,
                    accent: _cTeal,
                    title: 'Image vs ImageIcon Behavior',
                    subtitle:
                        'Compares raw Image rendering against ImageIcon tinting, size behavior, and ambient IconTheme interactions.',
                    child: _CoreBehaviorSection(settings: settings, bundle: bundle),
                  ),
                  const SizedBox(height: 12),
                  _SectionBlock(
                    index: 3,
                    accent: _cCoral,
                    title: 'Theme Cascade Studio',
                    subtitle:
                        'Demonstrates nested IconTheme inheritance, explicit overrides, and null-image behavior in hierarchical UI zones.',
                    child: _ThemeCascadeSection(settings: settings, bundle: bundle),
                  ),
                  const SizedBox(height: 12),
                  _SectionBlock(
                    index: 4,
                    accent: _cViolet,
                    title: 'Interaction and State Gallery',
                    subtitle:
                        'Shows practical ImageIcon usage in controls, chips, lists, and stateful components with visual state transitions.',
                    child: _StateGallerySection(settings: settings, bundle: bundle),
                  ),
                  const SizedBox(height: 12),
                  _SectionBlock(
                    index: 5,
                    accent: _cOlive,
                    title: 'Fallback and Reliability Patterns',
                    subtitle:
                        'Explores missing providers, delayed providers, and resilient fallback wrappers to keep icon surfaces stable.',
                    child: _FallbackSection(settings: settings, bundle: bundle),
                  ),
                  const SizedBox(height: 12),
                  _SectionBlock(
                    index: 6,
                    accent: _cInk,
                    title: 'Practical Operations Board',
                    subtitle:
                        'A realistic multi-zone board using ImageIcon assets across topbar, navigation, cards, alerts, and footer actions.',
                    child: _PracticalBoardSection(settings: settings, bundle: bundle),
                  ),
                  const SizedBox(height: 12),
                  const _RecapPanel(),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _DemoSettings {
  const _DemoSettings({
    required this.compact,
    required this.showGrid,
    required this.showLabels,
    required this.textDirection,
    required this.globalScale,
    required this.seed,
  });

  final bool compact;
  final bool showGrid;
  final bool showLabels;
  final TextDirection textDirection;
  final double globalScale;
  final int seed;
}

class _TopRibbon extends StatelessWidget {
  const _TopRibbon({
    required this.compact,
    required this.showGrid,
    required this.showLabels,
    required this.rtl,
    required this.scale,
    required this.seed,
    required this.onCompactChanged,
    required this.onGridChanged,
    required this.onLabelsChanged,
    required this.onRtlChanged,
    required this.onScaleChanged,
    required this.onRegenerate,
  });

  final bool compact;
  final bool showGrid;
  final bool showLabels;
  final bool rtl;
  final double scale;
  final int seed;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onGridChanged;
  final ValueChanged<bool> onLabelsChanged;
  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<double> onScaleChanged;
  final VoidCallback onRegenerate;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF17324A), Color(0xFF2F647B), Color(0xFF634F7D)],
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
              'ImageIcon Control Ribbon',
              style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            Text(
              'Generated icon pack seed: $seed. Regenerate to produce a fresh in-memory icon set while preserving all section interactions.',
              style: const TextStyle(color: Color(0xFFEAF2F9), height: 1.36),
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
                    value: showLabels,
                    onChanged: onLabelsChanged,
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
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Global scale: ${scale.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
                FilledButton(
                  onPressed: onRegenerate,
                  style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: _cInk),
                  child: const Text('Regenerate Pack'),
                ),
              ],
            ),
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
                _RibbonTag(label: 'ImageProvider -> ImageIcon'),
                _RibbonTag(label: 'Tint + IconTheme behavior'),
                _RibbonTag(label: 'State/fallback patterns'),
                _RibbonTag(label: 'Production composition'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RibbonTag extends StatelessWidget {
  const _RibbonTag({required this.label});

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

class _SectionBlock extends StatelessWidget {
  const _SectionBlock({
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

class _SourceGenerationSection extends StatelessWidget {
  const _SourceGenerationSection({required this.settings, required this.bundle});

  final _DemoSettings settings;
  final _IconAssetBundle bundle;

  @override
  Widget build(BuildContext context) {
    final keys = bundle.order;
    return SizedBox(
      height: settings.compact ? 520 : 620,
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: _BackdropPanel(
              showGrid: settings.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Generated icon pack', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Expanded(
                      child: GridView.builder(
                        itemCount: keys.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: settings.compact ? 3 : 4,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 1.05,
                        ),
                        itemBuilder: (context, index) {
                          final key = keys[index];
                          final provider = bundle.providers[key]!;
                          return _GeneratedPreviewCard(
                            keyName: key,
                            provider: provider,
                            showLabels: settings.showLabels,
                          );
                        },
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
            child: _BackdropPanel(
              showGrid: false,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Generation summary', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    _InfoRow(label: 'seed', value: '${settings.seed}'),
                    _InfoRow(label: 'icon count', value: '${bundle.order.length}'),
                    _InfoRow(label: 'provider type', value: 'MemoryImage'),
                    _InfoRow(label: 'image size', value: '${bundle.pixelSize} x ${bundle.pixelSize} px'),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: _softBox(),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Why this matters', style: TextStyle(fontWeight: FontWeight.w800)),
                          SizedBox(height: 6),
                          _BulletText(text: 'ImageIcon depends on ImageProvider sources.'),
                          _BulletText(text: 'In-memory generation keeps the demo deterministic and portable.'),
                          _BulletText(text: 'Monochrome glyphs are ideal for tint behavior tests.'),
                          _BulletText(text: 'Regeneration verifies provider changes and rebuild behavior.'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: _BackdropPanel(
                        showGrid: false,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Raw image strip', style: TextStyle(fontWeight: FontWeight.w800)),
                              const SizedBox(height: 8),
                              Expanded(
                                child: ListView.separated(
                                  itemCount: keys.length,
                                  separatorBuilder: (_, _) => const SizedBox(height: 6),
                                  itemBuilder: (context, index) {
                                    final key = keys[index];
                                    return Row(
                                      children: [
                                        Image(image: bundle.providers[key]!, width: 22, height: 22, fit: BoxFit.contain),
                                        const SizedBox(width: 8),
                                        Expanded(child: Text(key, style: const TextStyle(fontSize: 12))),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
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

class _GeneratedPreviewCard extends StatelessWidget {
  const _GeneratedPreviewCard({required this.keyName, required this.provider, required this.showLabels});

  final String keyName;
  final ImageProvider provider;
  final bool showLabels;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FBFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD6E2ED)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: provider, width: 34, height: 34, fit: BoxFit.contain),
          if (showLabels) ...[
            const SizedBox(height: 6),
            Text(keyName, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700), textAlign: TextAlign.center),
          ],
        ],
      ),
    );
  }
}

class _CoreBehaviorSection extends StatefulWidget {
  const _CoreBehaviorSection({required this.settings, required this.bundle});

  final _DemoSettings settings;
  final _IconAssetBundle bundle;

  @override
  State<_CoreBehaviorSection> createState() => _CoreBehaviorSectionState();
}

class _CoreBehaviorSectionState extends State<_CoreBehaviorSection> {
  String _selectedKey = 'rocket';
  double _iconSize = 40;
  double _themeOpacity = 1.0;
  bool _enabledTheme = true;
  bool _overrideColor = false;
  Color _themeColor = _cBlue;
  Color _override = _cCoral;

  @override
  Widget build(BuildContext context) {
    final settings = widget.settings;
    final bundle = widget.bundle;
    final provider = bundle.providers[_selectedKey]!;

    final iconTheme = IconThemeData(
      size: _iconSize * settings.globalScale,
      color: _themeColor,
      opacity: _themeOpacity,
    );

    return SizedBox(
      height: settings.compact ? 560 : 680,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _BackdropPanel(
              showGrid: settings.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Behavior controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: bundle.order
                            .map(
                              (k) => ChoiceChip(
                                selected: _selectedKey == k,
                                label: Text(k),
                                onSelected: (_) => setState(() => _selectedKey = k),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 8),
                      _LabeledValueSlider(
                        label: 'IconTheme.size',
                        value: _iconSize,
                        min: 16,
                        max: 86,
                        onChanged: (v) => setState(() => _iconSize = v),
                      ),
                      _LabeledValueSlider(
                        label: 'IconTheme.opacity',
                        value: _themeOpacity,
                        min: 0.1,
                        max: 1,
                        onChanged: (v) => setState(() => _themeOpacity = v),
                      ),
                      SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: _enabledTheme,
                        onChanged: (v) => setState(() => _enabledTheme = v),
                        title: const Text('Wrap with IconTheme'),
                      ),
                      SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: _overrideColor,
                        onChanged: (v) => setState(() => _overrideColor = v),
                        title: const Text('Override ImageIcon.color'),
                      ),
                      const SizedBox(height: 6),
                      _ColorRow(
                        title: 'Theme color',
                        selected: _themeColor,
                        onChanged: (c) => setState(() => _themeColor = c),
                      ),
                      const SizedBox(height: 6),
                      _ColorRow(
                        title: 'Override color',
                        selected: _override,
                        onChanged: (c) => setState(() => _override = c),
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
            child: _BackdropPanel(
              showGrid: settings.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Image vs ImageIcon', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: _comparisonCard(
                              title: 'Image (raw provider)',
                              tone: _cBlue,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(image: provider, width: 80 * settings.globalScale, height: 80 * settings.globalScale),
                                  const SizedBox(height: 8),
                                  const Text('No automatic icon-theme tinting', style: TextStyle(fontSize: 12)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _comparisonCard(
                              title: 'ImageIcon (theme-aware)',
                              tone: _cTeal,
                              child: _maybeTheme(
                                data: iconTheme,
                                enabled: _enabledTheme,
                                child: Center(
                                  child: ImageIcon(
                                    provider,
                                    color: _overrideColor ? _override : null,
                                    semanticLabel: 'image icon preview',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: _BackdropPanel(
                        showGrid: false,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Diagnostics', style: TextStyle(fontWeight: FontWeight.w800)),
                              const SizedBox(height: 6),
                              _InfoRow(label: 'provider key', value: _selectedKey),
                              _InfoRow(label: 'theme enabled', value: '$_enabledTheme'),
                              _InfoRow(label: 'override color', value: _overrideColor ? '$_override' : '(none)'),
                              _InfoRow(label: 'theme size', value: (iconTheme.size ?? 24).toStringAsFixed(2)),
                              _InfoRow(label: 'theme opacity', value: (iconTheme.opacity ?? 1).toStringAsFixed(2)),
                              const SizedBox(height: 8),
                              const Text(
                                'ImageIcon uses ImageProvider input but behaves like iconography: it reads IconTheme defaults and applies tint/opacity semantics.',
                                style: TextStyle(height: 1.34),
                              ),
                            ],
                          ),
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

  Widget _maybeTheme({required IconThemeData data, required bool enabled, required Widget child}) {
    if (!enabled) {
      return child;
    }
    return IconTheme(data: data, child: child);
  }

  Widget _comparisonCard({required String title, required Color tone, required Widget child}) {
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
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _ThemeCascadeSection extends StatefulWidget {
  const _ThemeCascadeSection({required this.settings, required this.bundle});

  final _DemoSettings settings;
  final _IconAssetBundle bundle;

  @override
  State<_ThemeCascadeSection> createState() => _ThemeCascadeSectionState();
}

class _ThemeCascadeSectionState extends State<_ThemeCascadeSection> {
  bool _innerOverride = true;
  bool _showNullImage = true;
  bool _showExplicitSize = false;

  @override
  Widget build(BuildContext context) {
    final settings = widget.settings;
    final bundle = widget.bundle;

    final outer = IconThemeData(size: 44 * settings.globalScale, color: _cBlue, opacity: 0.95);
    final inner = IconThemeData(size: 30 * settings.globalScale, color: _cCoral, opacity: 0.8);

    return SizedBox(
      height: settings.compact ? 590 : 710,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _BackdropPanel(
              showGrid: settings.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Cascade toggles', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _innerOverride,
                      onChanged: (v) => setState(() => _innerOverride = v),
                      title: const Text('Enable inner IconTheme override'),
                    ),
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _showNullImage,
                      onChanged: (v) => setState(() => _showNullImage = v),
                      title: const Text('Show null-image ImageIcon sample'),
                    ),
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _showExplicitSize,
                      onChanged: (v) => setState(() => _showExplicitSize = v),
                      title: const Text('Use explicit ImageIcon.size override'),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: _softBox(),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('What to look for', style: TextStyle(fontWeight: FontWeight.w800)),
                            SizedBox(height: 6),
                            _BulletText(text: 'Outer IconTheme sets ambient defaults.'),
                            _BulletText(text: 'Inner IconTheme can narrow icon language for local zones.'),
                            _BulletText(text: 'Explicit size/color on ImageIcon overrides inherited theme.'),
                            _BulletText(text: 'ImageIcon(null) reserves space and supports semantic labeling.'),
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
            child: _BackdropPanel(
              showGrid: settings.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: IconTheme(
                  data: outer,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Nested theme zones', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: _themeZone(
                                title: 'Outer zone',
                                tone: _cBlue,
                                providers: bundle.primarySet,
                                explicitSize: _showExplicitSize ? 26 * settings.globalScale : null,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _innerOverride
                                  ? IconTheme(
                                      data: inner,
                                      child: _themeZone(
                                        title: 'Inner override zone',
                                        tone: _cCoral,
                                        providers: bundle.secondarySet,
                                        explicitSize: _showExplicitSize ? 42 * settings.globalScale : null,
                                      ),
                                    )
                                  : _themeZone(
                                      title: 'Inner zone (inherit outer)',
                                      tone: _cTeal,
                                      providers: bundle.secondarySet,
                                      explicitSize: _showExplicitSize ? 42 * settings.globalScale : null,
                                    ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (_showNullImage)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: _softBox(),
                          child: Row(
                            children: [
                              const Text('Null-image sample:', style: TextStyle(fontWeight: FontWeight.w700)),
                              const SizedBox(width: 8),
                              const ImageIcon(null, semanticLabel: 'empty icon slot'),
                              const SizedBox(width: 8),
                              Text('Rendered size follows IconTheme (${(IconTheme.of(context).size ?? 24).toStringAsFixed(1)})'),
                            ],
                          ),
                        ),
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

  Widget _themeZone({required String title, required Color tone, required List<ImageProvider> providers, double? explicitSize}) {
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
            child: GridView.builder(
              itemCount: providers.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFD5E2ED)),
                  ),
                  child: Center(
                    child: ImageIcon(
                      providers[index],
                      size: explicitSize,
                      semanticLabel: 'theme zone icon',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StateGallerySection extends StatefulWidget {
  const _StateGallerySection({required this.settings, required this.bundle});

  final _DemoSettings settings;
  final _IconAssetBundle bundle;

  @override
  State<_StateGallerySection> createState() => _StateGallerySectionState();
}

class _StateGallerySectionState extends State<_StateGallerySection> {
  int _selected = 0;
  bool _disabled = false;
  bool _warning = false;
  bool _dense = false;
  final List<String> _events = <String>[];

  void _log(String line) {
    setState(() {
      _events.insert(0, '${_clock()} | $line');
      if (_events.length > 24) {
        _events.removeRange(24, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final settings = widget.settings;
    final icons = widget.bundle.primarySet;

    Color currentColor() {
      if (_disabled) {
        return const Color(0xFF96A4B0);
      }
      if (_warning) {
        return _cCoral;
      }
      return _cBlue;
    }

    final tileSpace = _dense ? 4.0 : 10.0;

    return SizedBox(
      height: settings.compact ? 620 : 740,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _BackdropPanel(
              showGrid: settings.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('State controls', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _disabled,
                      onChanged: (v) {
                        setState(() => _disabled = v);
                        _log('disabled = $v');
                      },
                      title: const Text('Disabled state'),
                    ),
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _warning,
                      onChanged: (v) {
                        setState(() => _warning = v);
                        _log('warning = $v');
                      },
                      title: const Text('Warning tone'),
                    ),
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _dense,
                      onChanged: (v) {
                        setState(() => _dense = v);
                        _log('dense layout = $v');
                      },
                      title: const Text('Dense gallery layout'),
                    ),
                    const SizedBox(height: 8),
                    Expanded(child: _EventTicker(title: 'State gallery log', events: _events)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _BackdropPanel(
              showGrid: settings.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Interactive gallery', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Expanded(
                      child: GridView.builder(
                        itemCount: icons.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: settings.compact ? 3 : 4,
                          mainAxisSpacing: tileSpace,
                          crossAxisSpacing: tileSpace,
                          childAspectRatio: 1.08,
                        ),
                        itemBuilder: (context, index) {
                          final provider = icons[index];
                          final selected = _selected == index;
                          final tileColor = selected ? currentColor().withValues(alpha: 0.15) : const Color(0xFFF8FBFF);
                          return InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: _disabled
                                ? null
                                : () {
                                    setState(() => _selected = index);
                                    _log('selected card $index');
                                  },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: tileColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: selected ? currentColor().withValues(alpha: 0.6) : const Color(0xFFD6E2ED),
                                  width: selected ? 2 : 1,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ImageIcon(provider, color: currentColor(), size: 34 * settings.globalScale),
                                  if (settings.showLabels) ...[
                                    const SizedBox(height: 6),
                                    Text('Action ${index + 1}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11)),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: _softBox(),
                      child: Row(
                        children: [
                          Expanded(
                            child: _StateChip(
                              label: 'Normal',
                              active: !_disabled && !_warning,
                              color: _cBlue,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _StateChip(
                              label: 'Warning',
                              active: !_disabled && _warning,
                              color: _cCoral,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _StateChip(
                              label: 'Disabled',
                              active: _disabled,
                              color: const Color(0xFF95A4AF),
                            ),
                          ),
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

class _StateChip extends StatelessWidget {
  const _StateChip({required this.label, required this.active, required this.color});

  final String label;
  final bool active;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: active ? 0.18 : 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: active ? 0.6 : 0.25)),
      ),
      child: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w800), textAlign: TextAlign.center),
    );
  }
}

class _FallbackSection extends StatefulWidget {
  const _FallbackSection({required this.settings, required this.bundle});

  final _DemoSettings settings;
  final _IconAssetBundle bundle;

  @override
  State<_FallbackSection> createState() => _FallbackSectionState();
}

class _FallbackSectionState extends State<_FallbackSection> {
  bool _useBroken = true;
  bool _useDelayed = true;
  bool _showNullProvider = true;
  double _delaySeconds = 1.0;

  @override
  Widget build(BuildContext context) {
    final settings = widget.settings;
    final fallback = widget.bundle.providers['shield']!;
    final broken = _BrokenMemoryProvider();

    return SizedBox(
      height: settings.compact ? 620 : 740,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _BackdropPanel(
              showGrid: settings.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Fallback controls', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _useBroken,
                      onChanged: (v) => setState(() => _useBroken = v),
                      title: const Text('Simulate broken provider'),
                    ),
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _useDelayed,
                      onChanged: (v) => setState(() => _useDelayed = v),
                      title: const Text('Simulate delayed provider'),
                    ),
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _showNullProvider,
                      onChanged: (v) => setState(() => _showNullProvider = v),
                      title: const Text('Show null provider reserve-space sample'),
                    ),
                    _LabeledValueSlider(
                      label: 'Delay seconds',
                      value: _delaySeconds,
                      min: 0.2,
                      max: 3,
                      onChanged: (v) => setState(() => _delaySeconds = v),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: _softBox(),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Reliability notes', style: TextStyle(fontWeight: FontWeight.w800)),
                            SizedBox(height: 6),
                            _BulletText(text: 'A missing or corrupt provider can leave icon slots blank.'),
                            _BulletText(text: 'Use fallback wrappers for critical control surfaces.'),
                            _BulletText(text: 'Delayed providers should show placeholders while loading.'),
                            _BulletText(text: 'ImageIcon(null) can reserve geometry intentionally.'),
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
            child: _BackdropPanel(
              showGrid: settings.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Fallback patterns', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: _fallbackCard(
                              title: 'Safe primary/fallback wrapper',
                              tone: _cOlive,
                              child: Center(
                                child: _SafeImageIcon(
                                  primary: _useBroken ? broken : widget.bundle.providers['rocket']!,
                                  fallback: fallback,
                                  size: 56 * settings.globalScale,
                                  color: _cOlive,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _fallbackCard(
                              title: 'Delayed provider sample',
                              tone: _cViolet,
                              child: Center(
                                child: _DelayedImageIcon(
                                  delay: Duration(milliseconds: (_delaySeconds * 1000).round()),
                                  enabled: _useDelayed,
                                  provider: widget.bundle.providers['signal']!,
                                  size: 56 * settings.globalScale,
                                  color: _cViolet,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _fallbackCard(
                              title: 'Null provider reserve-space',
                              tone: _cCoral,
                              child: Center(
                                child: _showNullProvider
                                    ? const ImageIcon(
                                        null,
                                        size: 56,
                                        semanticLabel: 'reserved icon slot',
                                      )
                                    : ImageIcon(
                                        widget.bundle.providers['alert']!,
                                        size: 56 * settings.globalScale,
                                        color: _cCoral,
                                      ),
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
                      decoration: _softBox(),
                      child: _InfoRow(label: 'fallback mode', value: 'broken=$_useBroken delayed=$_useDelayed null=$_showNullProvider'),
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

  Widget _fallbackCard({required String title, required Color tone, required Widget child}) {
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
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _SafeImageIcon extends StatefulWidget {
  const _SafeImageIcon({
    required this.primary,
    required this.fallback,
    required this.size,
    required this.color,
  });

  final ImageProvider primary;
  final ImageProvider fallback;
  final double size;
  final Color color;

  @override
  State<_SafeImageIcon> createState() => _SafeImageIconState();
}

class _SafeImageIconState extends State<_SafeImageIcon> {
  bool _failed = false;

  @override
  void didUpdateWidget(covariant _SafeImageIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.primary != widget.primary) {
      _failed = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = _failed ? widget.fallback : widget.primary;
    return ImageIcon(
      provider,
      size: widget.size,
      color: widget.color,
      semanticLabel: 'safe image icon',
      key: ValueKey('${provider.hashCode}-${widget.size}-${widget.color.toARGB32()}'),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _probe(widget.primary);
    });
  }

  void _probe(ImageProvider provider) {
    final stream = provider.resolve(const ImageConfiguration());
    ImageStreamListener? listener;
    listener = ImageStreamListener(
      (image, syncCall) {
        stream.removeListener(listener!);
      },
      onError: (error, stackTrace) {
        if (mounted) {
          setState(() => _failed = true);
        }
        stream.removeListener(listener!);
      },
    );
    stream.addListener(listener);
  }
}

class _DelayedImageIcon extends StatefulWidget {
  const _DelayedImageIcon({
    required this.delay,
    required this.enabled,
    required this.provider,
    required this.size,
    required this.color,
  });

  final Duration delay;
  final bool enabled;
  final ImageProvider provider;
  final double size;
  final Color color;

  @override
  State<_DelayedImageIcon> createState() => _DelayedImageIconState();
}

class _DelayedImageIconState extends State<_DelayedImageIcon> {
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _run();
  }

  @override
  void didUpdateWidget(covariant _DelayedImageIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.delay != widget.delay || oldWidget.enabled != widget.enabled || oldWidget.provider != widget.provider) {
      _run();
    }
  }

  void _run() {
    setState(() => _ready = !widget.enabled);
    if (widget.enabled) {
      Future<void>.delayed(widget.delay, () {
        if (mounted) {
          setState(() => _ready = true);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return SizedBox(
        width: widget.size,
        height: widget.size,
        child: const CircularProgressIndicator(strokeWidth: 2),
      );
    }
    return ImageIcon(widget.provider, size: widget.size, color: widget.color, semanticLabel: 'delayed image icon');
  }
}

class _PracticalBoardSection extends StatefulWidget {
  const _PracticalBoardSection({required this.settings, required this.bundle});

  final _DemoSettings settings;
  final _IconAssetBundle bundle;

  @override
  State<_PracticalBoardSection> createState() => _PracticalBoardSectionState();
}

class _PracticalBoardSectionState extends State<_PracticalBoardSection> {
  int _profileIndex = 0;
  bool _highContrast = false;
  bool _compactRail = false;
  bool _colorOverride = false;
  final List<String> _events = <String>[];

  void _log(String event) {
    setState(() {
      _events.insert(0, '${_clock()} | $event');
      if (_events.length > 28) {
        _events.removeRange(28, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final settings = widget.settings;
    final bundle = widget.bundle;
    final profile = _boardProfiles[_profileIndex];

    final baseColor = _highContrast ? Colors.white : _cInk;
    final tint = _colorOverride ? profile.color : null;

    final iconTheme = IconThemeData(
      size: (20 * settings.globalScale).clamp(14, 36),
      color: baseColor,
      opacity: _highContrast ? 1 : 0.92,
    );

    return SizedBox(
      height: settings.compact ? 760 : 900,
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: _BackdropPanel(
              showGrid: settings.showGrid,
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
                          selected: _profileIndex == index,
                          label: Text(_boardProfiles[index].name),
                          onSelected: (_) {
                            setState(() => _profileIndex = index);
                            _log('profile -> ${_boardProfiles[index].name}');
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
                          selected: _highContrast,
                          label: const Text('High contrast board'),
                          onSelected: (v) {
                            setState(() => _highContrast = v);
                            _log('high contrast = $v');
                          },
                        ),
                        FilterChip(
                          selected: _compactRail,
                          label: const Text('Compact rail'),
                          onSelected: (v) {
                            setState(() => _compactRail = v);
                            _log('compact rail = $v');
                          },
                        ),
                        FilterChip(
                          selected: _colorOverride,
                          label: const Text('Per-icon color override'),
                          onSelected: (v) {
                            setState(() => _colorOverride = v);
                            _log('color override = $v');
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: IconTheme(
                        data: iconTheme,
                        child: Container(
                          decoration: BoxDecoration(
                            color: _highContrast ? const Color(0xFF1D2730) : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFD7E2ED)),
                          ),
                          child: Column(
                            children: [
                              _boardTop(profile, bundle, tint, baseColor),
                              Expanded(
                                child: Row(
                                  children: [
                                    _boardRail(profile, bundle, tint, baseColor),
                                    Expanded(child: _boardCards(profile, bundle, tint, baseColor)),
                                    _boardAlerts(profile, bundle, tint, baseColor),
                                  ],
                                ),
                              ),
                              _boardBottom(profile, bundle, tint, baseColor),
                            ],
                          ),
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
            child: _EventTicker(title: 'Board interaction log', events: _events),
          ),
        ],
      ),
    );
  }

  Widget _boardTop(_BoardProfile profile, _IconAssetBundle bundle, Color? tint, Color textColor) {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: profile.color.withValues(alpha: _highContrast ? 0.18 : 0.12),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: [
          ImageIcon(bundle.providers[profile.leadingKey], color: tint ?? textColor, semanticLabel: 'board lead icon'),
          const SizedBox(width: 8),
          Text(profile.name, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: textColor)),
          const Spacer(),
          ...profile.topActions.map(
            (action) => Padding(
              padding: const EdgeInsets.only(left: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => _log('top action ${action.label}'),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: Row(
                    children: [
                      ImageIcon(bundle.providers[action.key], color: tint ?? textColor, size: 18, semanticLabel: action.label),
                      const SizedBox(width: 4),
                      Text(action.label, style: TextStyle(fontSize: 11, color: textColor)),
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

  Widget _boardRail(_BoardProfile profile, _IconAssetBundle bundle, Color? tint, Color textColor) {
    final width = _compactRail ? 72.0 : 96.0;
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: _highContrast ? const Color(0xFF232F3A) : const Color(0xFFF8FBFF),
        border: const Border(right: BorderSide(color: Color(0xFFD7E2ED))),
      ),
      child: Column(
        children: profile.rail.map(
          (entry) {
            return InkWell(
              onTap: () => _log('rail ${entry.label}'),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    ImageIcon(bundle.providers[entry.key], color: tint ?? textColor, size: _compactRail ? 16 : 20, semanticLabel: entry.label),
                    if (!_compactRail && widget.settings.showLabels) ...[
                      const SizedBox(height: 3),
                      Text(entry.label, style: TextStyle(fontSize: 10, color: textColor), textAlign: TextAlign.center),
                    ],
                  ],
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  Widget _boardCards(_BoardProfile profile, _IconAssetBundle bundle, Color? tint, Color textColor) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GridView.builder(
        itemCount: profile.cards.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 1.16,
        ),
        itemBuilder: (context, index) {
          final card = profile.cards[index];
          return InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => _log('card ${card.title}'),
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
                  ImageIcon(bundle.providers[card.key], color: tint ?? card.color, semanticLabel: card.title),
                  const SizedBox(height: 6),
                  Text(card.title, style: TextStyle(fontWeight: FontWeight.w800, color: textColor)),
                  const SizedBox(height: 4),
                  Expanded(child: Text(card.note, style: TextStyle(fontSize: 12, color: textColor.withValues(alpha: 0.8), height: 1.3))),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _boardAlerts(_BoardProfile profile, _IconAssetBundle bundle, Color? tint, Color textColor) {
    return Container(
      width: 190,
      decoration: BoxDecoration(
        color: _highContrast ? const Color(0xFF212D38) : const Color(0xFFFDF8F8),
        border: const Border(left: BorderSide(color: Color(0xFFD7E2ED))),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Alerts', style: TextStyle(fontWeight: FontWeight.w800, color: textColor)),
            const SizedBox(height: 8),
            ...profile.alerts.map(
              (a) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: a.color.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: a.color.withValues(alpha: 0.35)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageIcon(bundle.providers[a.key], color: tint ?? a.color, size: 16, semanticLabel: a.title),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(a.title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: textColor)),
                          const SizedBox(height: 2),
                          Text(a.note, style: TextStyle(fontSize: 11, color: textColor.withValues(alpha: 0.85), height: 1.3)),
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

  Widget _boardBottom(_BoardProfile profile, _IconAssetBundle bundle, Color? tint, Color textColor) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: _highContrast ? const Color(0xFF22303A) : const Color(0xFFF8FAFD),
        border: const Border(top: BorderSide(color: Color(0xFFD7E2ED))),
      ),
      child: Row(
        children: [
          ...profile.footer.map(
            (a) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => _log('footer ${a.label}'),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: Row(
                    children: [
                      ImageIcon(bundle.providers[a.key], size: 14, color: tint ?? textColor, semanticLabel: a.label),
                      const SizedBox(width: 4),
                      Text(a.label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: textColor)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          Text('ImageIcon across board zones', style: TextStyle(fontSize: 11, color: textColor.withValues(alpha: 0.8))),
        ],
      ),
    );
  }
}

class _EventTicker extends StatelessWidget {
  const _EventTicker({required this.title, required this.events});

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
            const Text('No interactions yet.', style: TextStyle(color: Color(0xFF5D7182)))
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

class _BackdropPanel extends StatelessWidget {
  const _BackdropPanel({required this.showGrid, required this.child});

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

class _LabeledValueSlider extends StatelessWidget {
  const _LabeledValueSlider({
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

class _ColorRow extends StatelessWidget {
  const _ColorRow({
    required this.title,
    required this.selected,
    required this.onChanged,
  });

  final String title;
  final Color selected;
  final ValueChanged<Color> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 108, child: Text(title, style: const TextStyle(fontWeight: FontWeight.w700))),
        ..._palette.map(
          (color) => Padding(
            padding: const EdgeInsets.only(right: 6),
            child: InkWell(
              borderRadius: BorderRadius.circular(999),
              onTap: () => onChanged(color),
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: selected == color ? Colors.black : Colors.white, width: selected == color ? 2 : 1),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(width: 130, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}

class _BulletText extends StatelessWidget {
  const _BulletText({required this.text});

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
            child: Icon(Icons.circle, size: 7, color: Color(0xFF3B5D77)),
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
      decoration: BoxDecoration(
        color: const Color(0xFF173149),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recap: ImageIcon', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
          SizedBox(height: 8),
          Text(
            'ImageIcon bridges image providers into icon semantics. It picks up IconTheme defaults, supports optional direct overrides, and can be integrated with resilient loading/fallback patterns for production interfaces.',
            style: TextStyle(color: Color(0xFFD8E6F3), height: 1.38),
          ),
        ],
      ),
    );
  }
}

BoxDecoration _softBox() {
  return BoxDecoration(
    color: const Color(0xFFF2F7FC),
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: const Color(0xFFD7E2EE)),
  );
}

String _clock() => DateTime.now().toIso8601String().substring(11, 19);

const _palette = <Color>[
  _cBlue,
  _cTeal,
  _cCoral,
  _cViolet,
  _cOlive,
  _cInk,
];

class _BrokenMemoryProvider extends ImageProvider<_BrokenMemoryProvider> {
  @override
  Future<_BrokenMemoryProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<_BrokenMemoryProvider>(this);
  }

  @override
  ImageStreamCompleter loadImage(_BrokenMemoryProvider key, ImageDecoderCallback decode) {
    return OneFrameImageStreamCompleter(
      Future<ImageInfo>.error(StateError('simulated broken image provider')),
    );
  }
}

class _IconAssetBundle {
  const _IconAssetBundle({
    required this.providers,
    required this.order,
    required this.primarySet,
    required this.secondarySet,
    required this.pixelSize,
  });

  final Map<String, MemoryImage> providers;
  final List<String> order;
  final List<ImageProvider> primarySet;
  final List<ImageProvider> secondarySet;
  final int pixelSize;
}

class _IconGlyphFactory {
  static Future<_IconAssetBundle> generateBundle({required int seed}) async {
    const keys = [
      'rocket',
      'shield',
      'signal',
      'route',
      'radar',
      'alert',
      'spark',
      'pulse',
      'stack',
      'orbit',
      'lock',
      'flare',
    ];

    final map = <String, MemoryImage>{};
    for (final key in keys) {
      final bytes = await _drawGlyph(key: key, seed: seed, size: 96);
      map[key] = MemoryImage(bytes);
    }

    return _IconAssetBundle(
      providers: map,
      order: keys,
      primarySet: [
        map['rocket']!,
        map['shield']!,
        map['signal']!,
        map['route']!,
        map['radar']!,
        map['alert']!,
      ],
      secondarySet: [
        map['spark']!,
        map['pulse']!,
        map['stack']!,
        map['orbit']!,
        map['lock']!,
        map['flare']!,
      ],
      pixelSize: 96,
    );
  }

  static Future<Uint8List> _drawGlyph({required String key, required int seed, required int size}) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final rect = Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble());

    final bg = Paint()..color = const Color(0x00000000);
    canvas.drawRect(rect, bg);

    final black = Paint()..color = const Color(0xFF000000);
    final subtle = Paint()..color = const Color(0xE6000000);

    final double s = size.toDouble();
    final double unit = s / 24;
    final random = math.Random(seed * (key.codeUnitAt(0) + key.codeUnitAt(key.length - 1)));

    switch (key) {
      case 'rocket':
        final body = Path()
          ..moveTo(12 * unit, 2 * unit)
          ..lineTo(17 * unit, 9 * unit)
          ..lineTo(12 * unit, 22 * unit)
          ..lineTo(7 * unit, 9 * unit)
          ..close();
        canvas.drawPath(body, black);
        canvas.drawCircle(Offset(12 * unit, 10 * unit), 2.2 * unit, bg..color = const Color(0x00FFFFFF));
      case 'shield':
        final shield = Path()
          ..moveTo(12 * unit, 2 * unit)
          ..lineTo(20 * unit, 6 * unit)
          ..lineTo(18 * unit, 16 * unit)
          ..lineTo(12 * unit, 22 * unit)
          ..lineTo(6 * unit, 16 * unit)
          ..lineTo(4 * unit, 6 * unit)
          ..close();
        canvas.drawPath(shield, black);
      case 'signal':
        for (int i = 0; i < 4; i++) {
          final h = (i + 1) * 4 * unit;
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH((4 + i * 4) * unit, (22 * unit) - h, 2.5 * unit, h),
              Radius.circular(1 * unit),
            ),
            black,
          );
        }
      case 'route':
        final p = Path()
          ..moveTo(4 * unit, 19 * unit)
          ..quadraticBezierTo(10 * unit, 9 * unit, 14 * unit, 14 * unit)
          ..quadraticBezierTo(18 * unit, 19 * unit, 20 * unit, 6 * unit);
        canvas.drawPath(
          p,
          Paint()
            ..color = Colors.black
            ..style = PaintingStyle.stroke
            ..strokeWidth = 3.2 * unit
            ..strokeCap = StrokeCap.round,
        );
      case 'radar':
        canvas.drawCircle(Offset(12 * unit, 12 * unit), 9 * unit, Paint()..color = Colors.black..style = PaintingStyle.stroke..strokeWidth = 2.2 * unit);
        canvas.drawCircle(Offset(12 * unit, 12 * unit), 5.8 * unit, Paint()..color = Colors.black..style = PaintingStyle.stroke..strokeWidth = 2.0 * unit);
        canvas.drawLine(Offset(12 * unit, 12 * unit), Offset(19 * unit, 8 * unit), Paint()..color = Colors.black..strokeWidth = 2.2 * unit..strokeCap = StrokeCap.round);
      case 'alert':
        final tri = Path()
          ..moveTo(12 * unit, 3 * unit)
          ..lineTo(21 * unit, 20 * unit)
          ..lineTo(3 * unit, 20 * unit)
          ..close();
        canvas.drawPath(tri, black);
      case 'spark':
        final p = Path()
          ..moveTo(12 * unit, 2 * unit)
          ..lineTo(14 * unit, 9 * unit)
          ..lineTo(22 * unit, 12 * unit)
          ..lineTo(14 * unit, 15 * unit)
          ..lineTo(12 * unit, 22 * unit)
          ..lineTo(10 * unit, 15 * unit)
          ..lineTo(2 * unit, 12 * unit)
          ..lineTo(10 * unit, 9 * unit)
          ..close();
        canvas.drawPath(p, black);
      case 'pulse':
        final p = Path()
          ..moveTo(2 * unit, 13 * unit)
          ..lineTo(7 * unit, 13 * unit)
          ..lineTo(10 * unit, 6 * unit)
          ..lineTo(14 * unit, 18 * unit)
          ..lineTo(17 * unit, 11 * unit)
          ..lineTo(22 * unit, 11 * unit);
        canvas.drawPath(
          p,
          Paint()
            ..color = Colors.black
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.8 * unit
            ..strokeCap = StrokeCap.round
            ..strokeJoin = StrokeJoin.round,
        );
      case 'stack':
        for (int i = 0; i < 3; i++) {
          final y = (5 + i * 6).toDouble() * unit;
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(4 * unit, y, 16 * unit, 3.8 * unit),
              Radius.circular(1.2 * unit),
            ),
            black,
          );
        }
      case 'orbit':
        canvas.drawCircle(Offset(12 * unit, 12 * unit), 2.2 * unit, black);
        canvas.drawOval(
          Rect.fromCenter(center: Offset(12 * unit, 12 * unit), width: 20 * unit, height: 8 * unit),
          Paint()
            ..color = Colors.black
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.2 * unit,
        );
        canvas.drawOval(
          Rect.fromCenter(center: Offset(12 * unit, 12 * unit), width: 8 * unit, height: 20 * unit),
          Paint()
            ..color = Colors.black
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.0 * unit,
        );
      case 'lock':
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(6 * unit, 10 * unit, 12 * unit, 12 * unit),
            Radius.circular(2 * unit),
          ),
          black,
        );
        canvas.drawArc(
          Rect.fromLTWH(8 * unit, 4 * unit, 8 * unit, 9 * unit),
          math.pi,
          math.pi,
          false,
          Paint()
            ..color = Colors.black
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.2 * unit,
        );
      case 'flare':
        for (int i = 0; i < 10; i++) {
          final angle = (i / 10) * math.pi * 2;
          final r1 = 4 * unit;
          final r2 = 10 * unit;
          final p1 = Offset(12 * unit + math.cos(angle) * r1, 12 * unit + math.sin(angle) * r1);
          final p2 = Offset(12 * unit + math.cos(angle) * r2, 12 * unit + math.sin(angle) * r2);
          canvas.drawLine(p1, p2, Paint()..color = Colors.black..strokeWidth = 2.1 * unit..strokeCap = StrokeCap.round);
        }
        canvas.drawCircle(Offset(12 * unit, 12 * unit), 3.2 * unit, subtle);
      default:
        canvas.drawCircle(Offset(12 * unit, 12 * unit), 8 * unit, black);
    }

    for (int i = 0; i < 8; i++) {
      final x = random.nextDouble() * s;
      final y = random.nextDouble() * s;
      canvas.drawCircle(Offset(x, y), 0.6 * unit, subtle);
    }

    final picture = recorder.endRecording();
    final image = await picture.toImage(size, size);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    return bytes!.buffer.asUint8List();
  }
}

class _BoardProfile {
  const _BoardProfile({
    required this.name,
    required this.color,
    required this.leadingKey,
    required this.topActions,
    required this.rail,
    required this.cards,
    required this.alerts,
    required this.footer,
  });

  final String name;
  final Color color;
  final String leadingKey;
  final List<_ActionDef> topActions;
  final List<_ActionDef> rail;
  final List<_CardDef> cards;
  final List<_AlertDef> alerts;
  final List<_ActionDef> footer;
}

class _ActionDef {
  const _ActionDef({required this.key, required this.label});

  final String key;
  final String label;
}

class _CardDef {
  const _CardDef({required this.key, required this.title, required this.note, required this.color});

  final String key;
  final String title;
  final String note;
  final Color color;
}

class _AlertDef {
  const _AlertDef({required this.key, required this.title, required this.note, required this.color});

  final String key;
  final String title;
  final String note;
  final Color color;
}

const _boardProfiles = <_BoardProfile>[
  _BoardProfile(
    name: 'Ops Clarity',
    color: _cBlue,
    leadingKey: 'stack',
    topActions: [
      _ActionDef(key: 'flare', label: 'Search'),
      _ActionDef(key: 'route', label: 'Filter'),
      _ActionDef(key: 'orbit', label: 'More'),
    ],
    rail: [
      _ActionDef(key: 'route', label: 'Plan'),
      _ActionDef(key: 'signal', label: 'Flow'),
      _ActionDef(key: 'rocket', label: 'Ship'),
      _ActionDef(key: 'shield', label: 'Policy'),
    ],
    cards: [
      _CardDef(key: 'rocket', title: 'Launch Lane', note: 'Release cadence, rollout pacing, and risk envelope tracking.', color: _cBlue),
      _CardDef(key: 'signal', title: 'Signal Watch', note: 'Telemetry trend narratives and anomaly confidence signals.', color: _cTeal),
      _CardDef(key: 'route', title: 'Routing Matrix', note: 'Flow path optimization and lane balancing under load.', color: _cCoral),
      _CardDef(key: 'shield', title: 'Policy Gates', note: 'Compliance checkpoints and release hard-stop criteria.', color: _cViolet),
      _CardDef(key: 'radar', title: 'Radar Scope', note: 'Cross-team visibility and coordination focus points.', color: _cOlive),
      _CardDef(key: 'spark', title: 'Refinement', note: 'Continuous quality and visual consistency improvements.', color: _cInk),
    ],
    alerts: [
      _AlertDef(key: 'alert', title: 'Latency Spike', note: 'Service p95 rose by 12%.', color: _cCoral),
      _AlertDef(key: 'pulse', title: 'Heartbeat Drift', note: 'Signal consistency below threshold.', color: _cViolet),
      _AlertDef(key: 'lock', title: 'Policy Due', note: 'Review window closes in 2h.', color: _cOlive),
    ],
    footer: [
      _ActionDef(key: 'stack', label: 'Export'),
      _ActionDef(key: 'orbit', label: 'Snapshot'),
      _ActionDef(key: 'flare', label: 'Share'),
    ],
  ),
  _BoardProfile(
    name: 'Incident Focus',
    color: _cCoral,
    leadingKey: 'alert',
    topActions: [
      _ActionDef(key: 'radar', label: 'Alerts'),
      _ActionDef(key: 'pulse', label: 'Bridge'),
      _ActionDef(key: 'flare', label: 'More'),
    ],
    rail: [
      _ActionDef(key: 'alert', label: 'Incident'),
      _ActionDef(key: 'shield', label: 'Contain'),
      _ActionDef(key: 'rocket', label: 'Recover'),
      _ActionDef(key: 'stack', label: 'Archive'),
    ],
    cards: [
      _CardDef(key: 'alert', title: 'Outage Track', note: 'Primary incident timeline and ownership path.', color: _cCoral),
      _CardDef(key: 'shield', title: 'Containment', note: 'Boundary hardening and fallback activation states.', color: _cTeal),
      _CardDef(key: 'route', title: 'Routing Guard', note: 'Traffic reroute and pressure balancing controls.', color: _cBlue),
      _CardDef(key: 'pulse', title: 'Pulse Review', note: 'Recovery pulse checks and confidence bands.', color: _cViolet),
      _CardDef(key: 'lock', title: 'Security Notes', note: 'Incident policy constraints and audit events.', color: _cOlive),
      _CardDef(key: 'flare', title: 'Status Broadcast', note: 'Stakeholder communication and status cadence.', color: _cInk),
    ],
    alerts: [
      _AlertDef(key: 'alert', title: 'Critical Path', note: 'Checkout route unstable.', color: _cCoral),
      _AlertDef(key: 'signal', title: 'Queue Saturation', note: 'Build queue above baseline.', color: _cViolet),
      _AlertDef(key: 'lock', title: 'Security Hold', note: 'Temporary gate lock engaged.', color: _cOlive),
    ],
    footer: [
      _ActionDef(key: 'pulse', label: 'War Room'),
      _ActionDef(key: 'stack', label: 'Runbook'),
      _ActionDef(key: 'orbit', label: 'Archive'),
    ],
  ),
  _BoardProfile(
    name: 'Design Lens',
    color: _cViolet,
    leadingKey: 'spark',
    topActions: [
      _ActionDef(key: 'stack', label: 'Layers'),
      _ActionDef(key: 'signal', label: 'Type'),
      _ActionDef(key: 'orbit', label: 'More'),
    ],
    rail: [
      _ActionDef(key: 'spark', label: 'Tokens'),
      _ActionDef(key: 'flare', label: 'UI'),
      _ActionDef(key: 'route', label: 'Motion'),
      _ActionDef(key: 'shield', label: 'Review'),
    ],
    cards: [
      _CardDef(key: 'spark', title: 'Token System', note: 'Semantic icon token mappings and palette discipline.', color: _cViolet),
      _CardDef(key: 'flare', title: 'Visual Rhythm', note: 'Icon-label balance in dense component sets.', color: _cBlue),
      _CardDef(key: 'route', title: 'Flow Language', note: 'Directional icon consistency across navigation paths.', color: _cTeal),
      _CardDef(key: 'orbit', title: 'Motion Accent', note: 'Animated icon states and transition semantics.', color: _cCoral),
      _CardDef(key: 'lock', title: 'Accessibility', note: 'Contrast, semantics labels, and clarity checks.', color: _cOlive),
      _CardDef(key: 'radar', title: 'Review Radar', note: 'Outstanding component review hotspots.', color: _cInk),
    ],
    alerts: [
      _AlertDef(key: 'alert', title: 'Contrast Alert', note: 'Two icon pairs below target ratio.', color: _cCoral),
      _AlertDef(key: 'signal', title: 'Token Drift', note: 'Unmapped icon semantic detected.', color: _cViolet),
      _AlertDef(key: 'pulse', title: 'Review SLA', note: 'Design review due in 5h.', color: _cTeal),
    ],
    footer: [
      _ActionDef(key: 'stack', label: 'Export'),
      _ActionDef(key: 'spark', label: 'Generate'),
      _ActionDef(key: 'rocket', label: 'Submit'),
    ],
  ),
];
