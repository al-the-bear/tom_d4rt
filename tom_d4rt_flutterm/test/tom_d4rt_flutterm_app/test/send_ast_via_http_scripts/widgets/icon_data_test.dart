import 'package:flutter/material.dart';

const _cNavy = Color(0xFF144266);
const _cAmber = Color(0xFFC9893E);
const _cTeal = Color(0xFF338A79);
const _cRose = Color(0xFF914E6D);
const _cIndigo = Color(0xFF5D5BA7);
const _cOlive = Color(0xFF6D7136);

dynamic build(BuildContext context) {
  return const _IconDataDeepDemoApp();
}

class _IconDataDeepDemoApp extends StatelessWidget {
  const _IconDataDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _cNavy),
        scaffoldBackgroundColor: const Color(0xFFF2F6FA),
      ),
      home: const _IconDataLabPage(),
    );
  }
}

class _IconDataLabPage extends StatefulWidget {
  const _IconDataLabPage();

  @override
  State<_IconDataLabPage> createState() => _IconDataLabPageState();
}

class _IconDataLabPageState extends State<_IconDataLabPage> {
  bool _compact = false;
  bool _showGrid = true;
  bool _rtl = false;
  double _globalIconScale = 1.0;

  @override
  Widget build(BuildContext context) {
    final config = _DemoConfig(
      compact: _compact,
      showGrid: _showGrid,
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      globalScale: _globalIconScale,
    );

    return Directionality(
      textDirection: config.textDirection,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _cNavy,
          foregroundColor: Colors.white,
          toolbarHeight: 82,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('IconData Deep Demo'),
              const SizedBox(height: 2),
              Text(
                'Global icon scale: ${config.globalScale.toStringAsFixed(2)} | Direction: ${_rtl ? 'RTL' : 'LTR'}',
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
                rtl: _rtl,
                scale: _globalIconScale,
                onCompactChanged: (value) => setState(() => _compact = value),
                onShowGridChanged: (value) => setState(() => _showGrid = value),
                onRtlChanged: (value) => setState(() => _rtl = value),
                onScaleChanged: (value) => setState(() => _globalIconScale = value),
              ),
              const SizedBox(height: 12),
              const _SceneCard(
                index: 1,
                accent: _cNavy,
                title: 'What IconData Represents',
                subtitle:
                    'IconData describes a glyph by code point and font metadata. It is consumed by Icon to render visual symbols from icon fonts.',
                child: _ConceptScene(),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 2,
                accent: _cAmber,
                title: 'Code Point Composer',
                subtitle:
                    'Construct IconData from preset code points, slider offset, and hex values while inspecting rendered results and string representation.',
                child: _CodePointComposerScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 3,
                accent: _cTeal,
                title: 'Equality and Hash Semantics',
                subtitle:
                    'Visual comparison of IconData identity fields: codePoint, fontFamily, fontPackage, matchTextDirection, and fontFamilyFallback.',
                child: _EqualityHashScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 4,
                accent: _cRose,
                title: 'matchTextDirection Lab',
                subtitle:
                    'Side-by-side LTR and RTL panels show how identical code points behave when matchTextDirection is true vs false.',
                child: _DirectionalityScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 5,
                accent: _cIndigo,
                title: 'Font Family and Fallback Strategy',
                subtitle:
                    'Compares valid family, missing family, and missing family with fallback list to illustrate practical rendering outcomes.',
                child: _FamilyFallbackScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 6,
                accent: _cOlive,
                title: 'Practical Icon Registry Dashboard',
                subtitle:
                    'A realistic product dashboard where icon definitions are driven by IconData structures and reused across multiple UI zones.',
                child: _PracticalRegistryScene(config: config),
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

class _DemoConfig {
  const _DemoConfig({
    required this.compact,
    required this.showGrid,
    required this.textDirection,
    required this.globalScale,
  });

  final bool compact;
  final bool showGrid;
  final TextDirection textDirection;
  final double globalScale;
}

class _ControlDeck extends StatelessWidget {
  const _ControlDeck({
    required this.compact,
    required this.showGrid,
    required this.rtl,
    required this.scale,
    required this.onCompactChanged,
    required this.onShowGridChanged,
    required this.onRtlChanged,
    required this.onScaleChanged,
  });

  final bool compact;
  final bool showGrid;
  final bool rtl;
  final double scale;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onShowGridChanged;
  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<double> onScaleChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF173F66), Color(0xFF2C607B), Color(0xFF724C66)],
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
              'IconData Control Deck',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 28),
            ),
            const SizedBox(height: 6),
            const Text(
              'Tune global context and then inspect how each IconData property influences rendering, directionality behavior, identity semantics, and practical icon registry design.',
              style: TextStyle(color: Color(0xFFEAF2FA), height: 1.4),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    value: compact,
                    onChanged: onCompactChanged,
                    title: const Text('Compact layout', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    value: showGrid,
                    onChanged: onShowGridChanged,
                    title: const Text('Guide grid', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    value: rtl,
                    onChanged: onRtlChanged,
                    title: const Text('RTL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text('Global icon scale: ${scale.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            Slider(
              value: scale,
              min: 0.7,
              max: 1.6,
              divisions: 18,
              label: scale.toStringAsFixed(2),
              activeColor: Colors.white,
              inactiveColor: Colors.white.withValues(alpha: 0.3),
              onChanged: onScaleChanged,
            ),
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _DeckTag(label: 'codePoint + font metadata'),
                _DeckTag(label: 'matchTextDirection mirroring'),
                _DeckTag(label: 'equality/hash behavior'),
                _DeckTag(label: 'fallback list strategy'),
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
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
      ),
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
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
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
                      const SizedBox(height: 3),
                      Text(subtitle, style: const TextStyle(height: 1.38, color: Color(0xFF2E3D49))),
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
  const _ConceptScene();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('IconData fundamentals', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
        const SizedBox(height: 8),
        const Text(
          'IconData is immutable and intended to be const. Its identity includes all constructor fields, so codePoint alone is not enough for equality. Icon renders it using text style and direction-aware mirroring rules.',
          style: TextStyle(height: 1.42),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FBFE),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFD7E3EE)),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Bullet(text: 'codePoint identifies the glyph in a font.'),
              _Bullet(text: 'fontFamily and fontPackage select where glyph lookup happens.'),
              _Bullet(text: 'matchTextDirection requests automatic mirroring in RTL.'),
              _Bullet(text: 'fontFamilyFallback defines ordered fallback search families.'),
              _Bullet(text: 'operator== and hashCode include all fields, including fallback list content.'),
            ],
          ),
        ),
      ],
    );
  }
}

class _CodePointComposerScene extends StatefulWidget {
  const _CodePointComposerScene({required this.config});

  final _DemoConfig config;

  @override
  State<_CodePointComposerScene> createState() => _CodePointComposerSceneState();
}

class _CodePointComposerSceneState extends State<_CodePointComposerScene> {
  _IconPreset _preset = _iconPresets.first;
  int _offset = 0;
  final TextEditingController _hexController = TextEditingController();
  int? _manualCodePoint;
  final List<String> _events = <String>[];

  @override
  void initState() {
    super.initState();
    _hexController.text = _preset.icon.codePoint.toRadixString(16).toUpperCase();
  }

  @override
  void dispose() {
    _hexController.dispose();
    super.dispose();
  }

  void _push(String line) {
    setState(() {
      _events.insert(0, '${_time()} | $line');
      if (_events.length > 18) {
        _events.removeRange(18, _events.length);
      }
    });
  }

  IconData _compose() {
    final int cp = (_manualCodePoint ?? _preset.icon.codePoint) + _offset;
    final base = _preset.icon;
    return IconData(
      cp,
      fontFamily: base.fontFamily,
      fontPackage: base.fontPackage,
      matchTextDirection: base.matchTextDirection,
      fontFamilyFallback: base.fontFamilyFallback,
    );
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final IconData composed = _compose();
    final double size = (80 * config.globalScale).clamp(56, 148);
    final String iconString = composed.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _iconPresets
              .map(
                (entry) => ChoiceChip(
                  selected: _preset == entry,
                  label: Text(entry.name),
                  onSelected: (_) {
                    setState(() {
                      _preset = entry;
                      _manualCodePoint = null;
                      _offset = 0;
                      _hexController.text = entry.icon.codePoint.toRadixString(16).toUpperCase();
                    });
                    _push('preset changed to ${entry.name}');
                  },
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _hexController,
                decoration: const InputDecoration(
                  labelText: 'Manual code point (hex)',
                  border: OutlineInputBorder(),
                  prefixText: '0x',
                  isDense: true,
                ),
                onSubmitted: (value) {
                  final int? parsed = int.tryParse(value, radix: 16);
                  setState(() => _manualCodePoint = parsed);
                  _push(parsed == null ? 'invalid hex input' : 'manual code point set U+${parsed.toRadixString(16).toUpperCase()}');
                },
              ),
            ),
            const SizedBox(width: 10),
            _ActionButton(
              label: 'Apply hex',
              color: _cAmber,
              onPressed: () {
                final int? parsed = int.tryParse(_hexController.text, radix: 16);
                setState(() => _manualCodePoint = parsed);
                _push(parsed == null ? 'invalid hex input' : 'manual code point set U+${parsed.toRadixString(16).toUpperCase()}');
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text('Offset: $_offset', style: const TextStyle(fontWeight: FontWeight.w700)),
        Slider(
          value: _offset.toDouble(),
          min: -20,
          max: 20,
          divisions: 40,
          label: _offset.toString(),
          onChanged: (value) => setState(() => _offset = value.round()),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: config.compact ? 300 : 360,
          child: Row(
            children: [
              Expanded(
                child: _GuideStage(
                  showGrid: config.showGrid,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: _panelBox(),
                          child: Text(iconString, style: const TextStyle(fontWeight: FontWeight.w700)),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Center(
                            child: Container(
                              width: 240,
                              height: 220,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFE1EFFA), Color(0xFFF7E7EE)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: const Color(0xFFD2DFEB)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(composed, size: size, color: _cNavy),
                                  const SizedBox(height: 10),
                                  Text('U+${composed.codePoint.toRadixString(16).toUpperCase().padLeft(5, '0')}'),
                                  Text('fontFamily=${composed.fontFamily ?? '(null)'}', style: const TextStyle(fontSize: 12)),
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
                child: _EventLog(title: 'Composer log', events: _events),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _EqualityHashScene extends StatefulWidget {
  const _EqualityHashScene({required this.config});

  final _DemoConfig config;

  @override
  State<_EqualityHashScene> createState() => _EqualityHashSceneState();
}

class _EqualityHashSceneState extends State<_EqualityHashScene> {
  late final IconData _base;
  late final IconData _same;
  late final IconData _diffDirection;
  late final IconData _diffFamily;
  late final IconData _diffFallback;

  @override
  void initState() {
    super.initState();
    _base = IconData(
      Icons.arrow_forward.codePoint,
      fontFamily: Icons.arrow_forward.fontFamily,
      fontPackage: Icons.arrow_forward.fontPackage,
      matchTextDirection: true,
      fontFamilyFallback: const <String>['MaterialIcons'],
    );
    _same = IconData(
      Icons.arrow_forward.codePoint,
      fontFamily: Icons.arrow_forward.fontFamily,
      fontPackage: Icons.arrow_forward.fontPackage,
      matchTextDirection: true,
      fontFamilyFallback: const <String>['MaterialIcons'],
    );
    _diffDirection = IconData(
      Icons.arrow_forward.codePoint,
      fontFamily: Icons.arrow_forward.fontFamily,
      fontPackage: Icons.arrow_forward.fontPackage,
      matchTextDirection: false,
      fontFamilyFallback: const <String>['MaterialIcons'],
    );
    _diffFamily = IconData(
      Icons.arrow_forward.codePoint,
      fontFamily: 'DifferentFamily',
      fontPackage: Icons.arrow_forward.fontPackage,
      matchTextDirection: true,
      fontFamilyFallback: const <String>['MaterialIcons'],
    );
    _diffFallback = IconData(
      Icons.arrow_forward.codePoint,
      fontFamily: Icons.arrow_forward.fontFamily,
      fontPackage: Icons.arrow_forward.fontPackage,
      matchTextDirection: true,
      fontFamilyFallback: const <String>['MaterialIcons', 'AnotherFallback'],
    );
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final rows = <_EqRowData>[
      _EqRowData('base vs same', _base, _same),
      _EqRowData('base vs diffDirection', _base, _diffDirection),
      _EqRowData('base vs diffFamily', _base, _diffFamily),
      _EqRowData('base vs diffFallback', _base, _diffFallback),
    ];
    final set = <IconData>{_base, _same, _diffDirection, _diffFamily, _diffFallback};

    return SizedBox(
      height: config.compact ? 340 : 420,
      child: Row(
        children: [
          Expanded(
            child: _GuideStage(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Set size from 5 instances: ${set.length}', style: const TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.separated(
                        itemCount: rows.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final row = rows[index];
                          final equal = row.a == row.b;
                          final hashEqual = row.a.hashCode == row.b.hashCode;
                          return Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: equal ? const Color(0xFFEAF7EE) : const Color(0xFFFBEDEF),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: equal ? const Color(0xFFC8E4D0) : const Color(0xFFEBCED3)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(row.label, style: const TextStyle(fontWeight: FontWeight.w800)),
                                const SizedBox(height: 4),
                                Text('== : $equal | hashCode equal: $hashEqual', style: const TextStyle(fontSize: 12)),
                                const SizedBox(height: 4),
                                Text('A ${row.a}', style: const TextStyle(fontSize: 11, fontFamily: 'monospace')),
                                Text('B ${row.b}', style: const TextStyle(fontSize: 11, fontFamily: 'monospace')),
                              ],
                            ),
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
            child: _GuideStage(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Rendered sample strip', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _chipForIcon(_base, 'base', _cNavy, config.globalScale),
                          _chipForIcon(_same, 'same', _cTeal, config.globalScale),
                          _chipForIcon(_diffDirection, 'dir', _cRose, config.globalScale),
                          _chipForIcon(_diffFamily, 'family', _cAmber, config.globalScale),
                          _chipForIcon(_diffFallback, 'fallback', _cIndigo, config.globalScale),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: _panelBox(),
                      child: const Text(
                        'IconData equality can break if any metadata differs, even when codePoint is identical. This affects map/set keys and diagnostics comparisons in icon registries.',
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

  Widget _chipForIcon(IconData icon, String label, Color color, double scale) {
    return Container(
      width: 112,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28 * scale),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _EqRowData {
  const _EqRowData(this.label, this.a, this.b);

  final String label;
  final IconData a;
  final IconData b;
}

class _DirectionalityScene extends StatefulWidget {
  const _DirectionalityScene({required this.config});

  final _DemoConfig config;

  @override
  State<_DirectionalityScene> createState() => _DirectionalitySceneState();
}

class _DirectionalitySceneState extends State<_DirectionalityScene> {
  bool _localRtl = false;

  IconData _manual(bool match) {
    final base = Icons.arrow_forward;
    return IconData(
      base.codePoint,
      fontFamily: base.fontFamily,
      fontPackage: base.fontPackage,
      matchTextDirection: match,
    );
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final iconA = _manual(false);
    final iconB = _manual(true);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            FilterChip(
              selected: _localRtl,
              label: const Text('Local RTL panel'),
              onSelected: (value) => setState(() => _localRtl = value),
            ),
            const SizedBox(width: 8),
            Text('Panel direction: ${_localRtl ? 'RTL' : 'LTR'}', style: const TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: config.compact ? 310 : 380,
          child: Row(
            children: [
              Expanded(
                child: _GuideStage(
                  showGrid: config.showGrid,
                  child: Directionality(
                    textDirection: _localRtl ? TextDirection.rtl : TextDirection.ltr,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('matchTextDirection = false', style: TextStyle(fontWeight: FontWeight.w800)),
                          const SizedBox(height: 6),
                          Expanded(child: _directionCard(iconA, 'No auto mirroring', _cRose, config.globalScale)),
                          const SizedBox(height: 8),
                          const Text('matchTextDirection = true', style: TextStyle(fontWeight: FontWeight.w800)),
                          const SizedBox(height: 6),
                          Expanded(child: _directionCard(iconB, 'Mirrors in RTL', _cTeal, config.globalScale)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: _panelBox(),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Interpretation', style: TextStyle(fontWeight: FontWeight.w800)),
                      SizedBox(height: 6),
                      Text(
                        'Use matchTextDirection for directional icons that should naturally reflect language direction. Keep it false for symbols whose orientation must remain fixed regardless of text direction.',
                        style: TextStyle(height: 1.35),
                      ),
                      SizedBox(height: 8),
                      _Bullet(text: 'Common directional candidates: arrows, chevrons, exit/enter indicators.'),
                      _Bullet(text: 'Common non-directional candidates: logos, status dots, numerical glyphs.'),
                      _Bullet(text: 'Mirroring is applied by Icon via Directionality context.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _directionCard(IconData icon, String note, Color color, double scale) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 74 * scale, color: color),
          const SizedBox(height: 8),
          Text(note, style: const TextStyle(fontWeight: FontWeight.w700)),
          Text('matchTextDirection=${icon.matchTextDirection}', style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class _FamilyFallbackScene extends StatefulWidget {
  const _FamilyFallbackScene({required this.config});

  final _DemoConfig config;

  @override
  State<_FamilyFallbackScene> createState() => _FamilyFallbackSceneState();
}

class _FamilyFallbackSceneState extends State<_FamilyFallbackScene> {
  late final IconData _valid;
  late final IconData _missingNoFallback;
  late final IconData _missingWithFallback;

  @override
  void initState() {
    super.initState();
    final base = Icons.favorite;
    _valid = IconData(
      base.codePoint,
      fontFamily: base.fontFamily,
      fontPackage: base.fontPackage,
    );
    _missingNoFallback = IconData(
      base.codePoint,
      fontFamily: 'MissingFamily',
      fontPackage: base.fontPackage,
    );
    _missingWithFallback = IconData(
      base.codePoint,
      fontFamily: 'MissingFamily',
      fontPackage: base.fontPackage,
      fontFamilyFallback: const <String>['MaterialIcons'],
    );
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;

    return SizedBox(
      height: config.compact ? 320 : 390,
      child: Row(
        children: [
          Expanded(child: _familyCard(_valid, 'Valid family', _cTeal, config.globalScale)),
          const SizedBox(width: 8),
          Expanded(child: _familyCard(_missingNoFallback, 'Missing family, no fallback', _cRose, config.globalScale)),
          const SizedBox(width: 8),
          Expanded(child: _familyCard(_missingWithFallback, 'Missing family + fallback', _cIndigo, config.globalScale)),
        ],
      ),
    );
  }

  Widget _familyCard(IconData icon, String title, Color color, double scale) {
    return _GuideStage(
      showGrid: widget.config.showGrid,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.w800, color: color)),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: color.withValues(alpha: 0.35)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: color, size: 68 * scale),
                    const SizedBox(height: 8),
                    Text('U+${icon.codePoint.toRadixString(16).toUpperCase()}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text('fontFamily: ${icon.fontFamily}', style: const TextStyle(fontSize: 12)),
            Text('fallback: ${icon.fontFamilyFallback?.join(', ') ?? '(none)'}', style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _PracticalRegistryScene extends StatefulWidget {
  const _PracticalRegistryScene({required this.config});

  final _DemoConfig config;

  @override
  State<_PracticalRegistryScene> createState() => _PracticalRegistrySceneState();
}

class _PracticalRegistrySceneState extends State<_PracticalRegistryScene> {
  int _section = 0;
  bool _showLabels = true;
  bool _highContrast = false;
  final List<String> _events = <String>[];

  void _push(String message) {
    setState(() {
      _events.insert(0, '${_time()} | $message');
      if (_events.length > 24) {
        _events.removeRange(24, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final section = _registrySections[_section];
    final panelColor = _highContrast ? const Color(0xFF1E252E) : Colors.white;
    final textColor = _highContrast ? Colors.white : const Color(0xFF203544);

    return SizedBox(
      height: config.compact ? 520 : 620,
      child: Row(
        children: [
          Expanded(
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
                        _registrySections.length,
                        (index) => ChoiceChip(
                          selected: _section == index,
                          label: Text(_registrySections[index].name),
                          onSelected: (_) {
                            setState(() => _section = index);
                            _push('section -> ${_registrySections[index].name}');
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
                          selected: _showLabels,
                          label: const Text('Show labels'),
                          onSelected: (value) => setState(() => _showLabels = value),
                        ),
                        FilterChip(
                          selected: _highContrast,
                          label: const Text('High contrast panel'),
                          onSelected: (value) => setState(() => _highContrast = value),
                        ),
                        _ActionButton(
                          label: 'Clear log',
                          color: section.color,
                          onPressed: () => setState(_events.clear),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: panelColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFD7E2ED)),
                        ),
                        child: Column(
                          children: [
                            _toolbar(section, textColor),
                            Expanded(
                              child: Row(
                                children: [
                                  _navRail(section, textColor),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: GridView.builder(
                                        itemCount: section.cards.length,
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 8,
                                          mainAxisSpacing: 8,
                                          childAspectRatio: 1.18,
                                        ),
                                        itemBuilder: (context, index) {
                                          final card = section.cards[index];
                                          return InkWell(
                                            borderRadius: BorderRadius.circular(10),
                                            onTap: () => _push('card tap ${card.title}'),
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: _highContrast
                                                    ? const Color(0xFF2A333E)
                                                    : card.color.withValues(alpha: 0.14),
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: _highContrast
                                                      ? const Color(0xFF3E4A58)
                                                      : card.color.withValues(alpha: 0.35),
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Icon(card.icon, color: _highContrast ? Colors.white : card.color, size: 26 * config.globalScale),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    card.title,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w800,
                                                      color: _highContrast ? Colors.white : const Color(0xFF213646),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Expanded(
                                                    child: Text(
                                                      card.note,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        height: 1.3,
                                                        color: _highContrast ? const Color(0xFFD2DEE9) : const Color(0xFF4F6475),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
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
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _EventLog(title: 'Registry log', events: _events),
          ),
        ],
      ),
    );
  }

  Widget _toolbar(_RegistrySection section, Color textColor) {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: section.color.withValues(alpha: _highContrast ? 0.2 : 0.12),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: [
          Icon(section.toolbarLeading, color: textColor, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(section.name, style: TextStyle(fontWeight: FontWeight.w800, color: textColor)),
          ),
          ...section.toolbarActions.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(left: 6),
              child: IconButton(
                onPressed: () => _push('toolbar action ${entry.label}'),
                icon: Icon(entry.icon, color: textColor, size: 18),
                tooltip: entry.label,
                constraints: const BoxConstraints.tightFor(width: 32, height: 32),
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navRail(_RegistrySection section, Color textColor) {
    return Container(
      width: 78,
      decoration: BoxDecoration(
        color: _highContrast ? const Color(0xFF242D38) : const Color(0xFFF8FBFF),
        border: const Border(right: BorderSide(color: Color(0xFFD8E2ED))),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: section.railEntries
            .map(
              (entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: Column(
                  children: [
                    Icon(entry.icon, color: textColor, size: 20),
                    const SizedBox(height: 2),
                    if (_showLabels)
                      Text(
                        entry.label,
                        style: TextStyle(fontSize: 10, color: textColor),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _RegistrySection {
  const _RegistrySection({
    required this.name,
    required this.color,
    required this.toolbarLeading,
    required this.toolbarActions,
    required this.railEntries,
    required this.cards,
  });

  final String name;
  final Color color;
  final IconData toolbarLeading;
  final List<_IconLabel> toolbarActions;
  final List<_IconLabel> railEntries;
  final List<_RegistryCard> cards;
}

class _RegistryCard {
  const _RegistryCard({
    required this.title,
    required this.note,
    required this.icon,
    required this.color,
  });

  final String title;
  final String note;
  final IconData icon;
  final Color color;
}

class _IconLabel {
  const _IconLabel(this.icon, this.label);

  final IconData icon;
  final String label;
}

const List<_RegistrySection> _registrySections = <_RegistrySection>[
  _RegistrySection(
    name: 'Planning Workspace',
    color: _cNavy,
    toolbarLeading: Icons.dashboard,
    toolbarActions: <_IconLabel>[
      _IconLabel(Icons.search, 'Search'),
      _IconLabel(Icons.filter_alt, 'Filter'),
      _IconLabel(Icons.more_horiz, 'More'),
    ],
    railEntries: <_IconLabel>[
      _IconLabel(Icons.home, 'Home'),
      _IconLabel(Icons.route, 'Roadmap'),
      _IconLabel(Icons.checklist, 'Tasks'),
      _IconLabel(Icons.person, 'Owners'),
    ],
    cards: <_RegistryCard>[
      _RegistryCard(title: 'Roadmap', note: 'Milestone and dependency map.', icon: Icons.alt_route, color: Color(0xFF2B6FA7)),
      _RegistryCard(title: 'Backlog', note: 'Prioritized tactical queue.', icon: Icons.view_stream, color: Color(0xFF3B8E78)),
      _RegistryCard(title: 'Risks', note: 'Critical blockers and mitigations.', icon: Icons.warning_amber, color: Color(0xFFBE7D37)),
      _RegistryCard(title: 'Budget', note: 'Financial tracking and variance.', icon: Icons.pie_chart, color: Color(0xFF6F63B0)),
      _RegistryCard(title: 'Quality', note: 'Regression trends and confidence.', icon: Icons.rule_folder, color: Color(0xFF8D4E70)),
      _RegistryCard(title: 'Signals', note: 'Cross-team status indicators.', icon: Icons.monitor_heart, color: Color(0xFF5C7A48)),
    ],
  ),
  _RegistrySection(
    name: 'Operations Console',
    color: _cTeal,
    toolbarLeading: Icons.hub,
    toolbarActions: <_IconLabel>[
      _IconLabel(Icons.notifications_active, 'Alerts'),
      _IconLabel(Icons.download, 'Export'),
      _IconLabel(Icons.settings, 'Settings'),
    ],
    railEntries: <_IconLabel>[
      _IconLabel(Icons.radar, 'Radar'),
      _IconLabel(Icons.timeline, 'Trace'),
      _IconLabel(Icons.analytics, 'Metrics'),
      _IconLabel(Icons.task_alt, 'Actions'),
    ],
    cards: <_RegistryCard>[
      _RegistryCard(title: 'Live Radar', note: 'Incoming incident streams.', icon: Icons.radar, color: Color(0xFF2C6FA5)),
      _RegistryCard(title: 'Trace Graph', note: 'Execution sequence visibility.', icon: Icons.timeline, color: Color(0xFF3D8C79)),
      _RegistryCard(title: 'Alert Queue', note: 'Priority escalations and assignment.', icon: Icons.notification_important, color: Color(0xFFBA7A38)),
      _RegistryCard(title: 'Pulse', note: 'Service heartbeat and SLI snapshots.', icon: Icons.favorite, color: Color(0xFF6F63AE)),
      _RegistryCard(title: 'Dispatch', note: 'Ticket and ownership routing.', icon: Icons.send, color: Color(0xFF8C4E6F)),
      _RegistryCard(title: 'Recovery', note: 'Rollback and remediation workflows.', icon: Icons.restore, color: Color(0xFF64723E)),
    ],
  ),
  _RegistrySection(
    name: 'Design Review',
    color: _cRose,
    toolbarLeading: Icons.palette,
    toolbarActions: <_IconLabel>[
      _IconLabel(Icons.layers, 'Layers'),
      _IconLabel(Icons.edit, 'Edit'),
      _IconLabel(Icons.share, 'Share'),
    ],
    railEntries: <_IconLabel>[
      _IconLabel(Icons.brush, 'Styles'),
      _IconLabel(Icons.text_fields, 'Typography'),
      _IconLabel(Icons.animation, 'Motion'),
      _IconLabel(Icons.fact_check, 'Review'),
    ],
    cards: <_RegistryCard>[
      _RegistryCard(title: 'Palette Set', note: 'Color token consistency checks.', icon: Icons.color_lens, color: Color(0xFF2D6FA5)),
      _RegistryCard(title: 'Type Scale', note: 'Hierarchy and readability review.', icon: Icons.format_size, color: Color(0xFF3E8A79)),
      _RegistryCard(title: 'Motion Pass', note: 'Animation pacing and continuity.', icon: Icons.animation, color: Color(0xFFB77838)),
      _RegistryCard(title: 'Contrast', note: 'Accessible contrast score checks.', icon: Icons.visibility, color: Color(0xFF6E63AF)),
      _RegistryCard(title: 'Feedback', note: 'Reviewer notes and annotations.', icon: Icons.chat_bubble_outline, color: Color(0xFF8D4E70)),
      _RegistryCard(title: 'Signoff', note: 'Approval and handoff status.', icon: Icons.verified, color: Color(0xFF65723E)),
    ],
  ),
  _RegistrySection(
    name: 'Release Board',
    color: _cOlive,
    toolbarLeading: Icons.rocket_launch,
    toolbarActions: <_IconLabel>[
      _IconLabel(Icons.cloud_upload, 'Upload'),
      _IconLabel(Icons.speed, 'Perf'),
      _IconLabel(Icons.more_vert, 'Menu'),
    ],
    railEntries: <_IconLabel>[
      _IconLabel(Icons.inventory_2, 'Artifacts'),
      _IconLabel(Icons.security, 'Checks'),
      _IconLabel(Icons.cloud_done, 'Deploy'),
      _IconLabel(Icons.query_stats, 'Observe'),
    ],
    cards: <_RegistryCard>[
      _RegistryCard(title: 'Build Artifacts', note: 'Package and binary lineage.', icon: Icons.archive, color: Color(0xFF2E6FA4)),
      _RegistryCard(title: 'Gate Checks', note: 'Policy and compliance status.', icon: Icons.gpp_good, color: Color(0xFF3F8A78)),
      _RegistryCard(title: 'Rollout Plan', note: 'Progressive deployment steps.', icon: Icons.route, color: Color(0xFFB97837)),
      _RegistryCard(title: 'Metrics Watch', note: 'Post-release telemetry stream.', icon: Icons.query_stats, color: Color(0xFF6E63AF)),
      _RegistryCard(title: 'Incident Mode', note: 'Fallback and escalation paths.', icon: Icons.health_and_safety, color: Color(0xFF8D4F6F)),
      _RegistryCard(title: 'Closure', note: 'Release summary and retention.', icon: Icons.task_alt, color: Color(0xFF64723E)),
    ],
  ),
];

class _GuideStage extends StatelessWidget {
  const _GuideStage({required this.showGrid, required this.child});

  final bool showGrid;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFFF9FCFF), Color(0xFFECF3F9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFFD7E2ED)),
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
    const double step = 22;
    final paint = Paint()..color = const Color(0x11000000);
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.label, required this.color, required this.onPressed});

  final String label;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(backgroundColor: color, foregroundColor: Colors.white),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Icon(Icons.circle, size: 7, color: Color(0xFF36536D)),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(height: 1.35))),
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
        border: Border.all(color: const Color(0xFFDCE6F1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          if (events.isEmpty)
            const Text('No events captured yet.', style: TextStyle(color: Color(0xFF5D7082)))
          else
            ...events.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(entry, style: const TextStyle(fontSize: 12, fontFamily: 'monospace')),
              ),
            ),
        ],
      ),
    );
  }
}

class _IconPreset {
  const _IconPreset(this.name, this.icon);

  final String name;
  final IconData icon;
}

const List<_IconPreset> _iconPresets = <_IconPreset>[
  _IconPreset('Favorite', Icons.favorite),
  _IconPreset('Rocket', Icons.rocket_launch),
  _IconPreset('Shield', Icons.shield),
  _IconPreset('Palette', Icons.palette),
  _IconPreset('Analytics', Icons.analytics),
  _IconPreset('Flight', Icons.flight),
  _IconPreset('Build', Icons.build_circle),
  _IconPreset('Route', Icons.route),
];

BoxDecoration _panelBox({Color color = const Color(0xFFF2F7FC), Color border = const Color(0xFFD6E2EE)}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: border),
  );
}

String _time() => DateTime.now().toIso8601String().substring(11, 19);

class _RecapCard extends StatelessWidget {
  const _RecapCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: const Color(0xFF142F44),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recap: IconData',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
          ),
          SizedBox(height: 8),
          Text(
            'Treat IconData as a precise glyph descriptor, not just an int code point. For robust UI systems, define icon registries with explicit metadata, use matchTextDirection thoughtfully, and keep identity semantics in mind when caching or deduplicating icons.',
            style: TextStyle(color: Color(0xFFD8E6F3), height: 1.4),
          ),
        ],
      ),
    );
  }
}
