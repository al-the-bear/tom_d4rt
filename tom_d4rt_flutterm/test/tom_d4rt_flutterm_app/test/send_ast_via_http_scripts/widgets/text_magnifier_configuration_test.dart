// D4rt test script: Deep Demo — TextMagnifierConfiguration (Magnifier Atelier)
// Demonstrates TextMagnifierConfiguration, the object passed to TextField
// and EditableText controlling how the magnifier loupe appears during
// selection on touch platforms. The atelier metaphor frames the
// configuration as a bench of optical instruments: brass-rimmed lenses,
// ruby index marks, and calibrated cross-sections.
import 'package:flutter/material.dart';
import 'dart:math' as math;

// ---------------------------------------------------------------------------
// Palette — "Magnifier Atelier" — sky, glass, ruby, brass.
// ---------------------------------------------------------------------------

class _TmcfgPalette {
  final String name;
  final Color sky;
  final Color glass;
  final Color ruby;
  final Color brass;
  final Color ink;
  final Color muted;
  final Color background;
  final Color surface;

  const _TmcfgPalette({
    required this.name,
    required this.sky,
    required this.glass,
    required this.ruby,
    required this.brass,
    required this.ink,
    required this.muted,
    required this.background,
    required this.surface,
  });
}

const _tmcfgPalette = _TmcfgPalette(
  name: 'Magnifier Atelier',
  sky: Color(0xFF4A90A4),
  glass: Color(0xFFF4F8F9),
  ruby: Color(0xFFB8243D),
  brass: Color(0xFFBE8A3D),
  ink: Color(0xFF1E2A30),
  muted: Color(0xFF6F7C82),
  background: Color(0xFFEFF3F5),
  surface: Color(0xFFFFFFFF),
);

// ---------------------------------------------------------------------------
// Preset identifiers for the interactive playground.
// ---------------------------------------------------------------------------

enum _TmcfgPreset {
  pill,
  circle,
  roundedRect,
}

// ---------------------------------------------------------------------------
// A record-like holder describing one of the four specimen configurations.
// ---------------------------------------------------------------------------

class _TmcfgSpecimen {
  final String label;
  final String summary;
  final String builderKind;
  final bool handles;
  final IconData icon;
  final Color accent;

  const _TmcfgSpecimen({
    required this.label,
    required this.summary,
    required this.builderKind,
    required this.handles,
    required this.icon,
    required this.accent,
  });
}

final List<_TmcfgSpecimen> _tmcfgSpecimens = <_TmcfgSpecimen>[
  _TmcfgSpecimen(
    label: 'Default (adaptive)',
    summary:
        'Uses TextField\'s default TextMagnifierConfiguration which delegates '
        'to the platform-adaptive TextMagnifier on touch devices.',
    builderKind: 'platform-adaptive',
    handles: false,
    icon: Icons.auto_awesome,
    accent: _tmcfgPalette.sky,
  ),
  _TmcfgSpecimen(
    label: 'Disabled via .disabled',
    summary:
        'TextMagnifierConfiguration.disabled returns a configuration whose '
        'magnifierBuilder always returns null, suppressing the loupe entirely.',
    builderKind: 'disabled',
    handles: false,
    icon: Icons.block,
    accent: _tmcfgPalette.ruby,
  ),
  _TmcfgSpecimen(
    label: 'Custom circular lens',
    summary:
        'Supplies a custom magnifierBuilder rendering a large brass-rimmed '
        'circular lens whose position follows the MagnifierInfo notifier.',
    builderKind: 'circle',
    handles: false,
    icon: Icons.circle_outlined,
    accent: _tmcfgPalette.brass,
  ),
  _TmcfgSpecimen(
    label: 'Custom + handles on loupe',
    summary:
        'Same custom builder, but with shouldDisplayHandlesInMagnifier set '
        'to true so the selection handles render on the magnified surface.',
    builderKind: 'roundedRect',
    handles: true,
    icon: Icons.drag_indicator,
    accent: _tmcfgPalette.sky,
  ),
];

// ---------------------------------------------------------------------------
// Entry point — the d4rt harness invokes build(context).
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  debugPrint(
      '[TextMagnifierConfiguration] Magnifier Atelier deep demo launching');
  return const _TmcfgAtelier();
}

// ---------------------------------------------------------------------------
// Root stateful widget.
// ---------------------------------------------------------------------------

class _TmcfgAtelier extends StatefulWidget {
  const _TmcfgAtelier();

  @override
  State<_TmcfgAtelier> createState() => _TmcfgAtelierState();
}

class _TmcfgAtelierState extends State<_TmcfgAtelier>
    with TickerProviderStateMixin {
  late final AnimationController _flareController;
  late final AnimationController _rayController;
  late final TextEditingController _specimenA;
  late final TextEditingController _specimenB;
  late final TextEditingController _specimenC;
  late final TextEditingController _specimenD;
  late final TextEditingController _playgroundController;

  _TmcfgPreset _preset = _TmcfgPreset.circle;
  double _scale = 1.65;
  bool _handlesOnMagnifier = false;
  bool _verbose = false;
  int _specimenIndex = 0;

  @override
  void initState() {
    super.initState();
    _flareController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
    _rayController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    _specimenA = TextEditingController(
      text: 'Long-press here to summon the default adaptive magnifier.',
    );
    _specimenB = TextEditingController(
      text: 'This field has the magnifier fully disabled via .disabled.',
    );
    _specimenC = TextEditingController(
      text: 'Our custom circular lens hovers above touch-selection points.',
    );
    _specimenD = TextEditingController(
      text: 'Handles follow the selection right on the magnified surface.',
    );
    _playgroundController = TextEditingController(
      text: 'Tune the sliders and toggles to reshape the lens in real time.',
    );
  }

  @override
  void dispose() {
    _flareController.dispose();
    _rayController.dispose();
    _specimenA.dispose();
    _specimenB.dispose();
    _specimenC.dispose();
    _specimenD.dispose();
    _playgroundController.dispose();
    super.dispose();
  }

  void _trace(String message) {
    if (_verbose) {
      debugPrint('[TmcfgAtelier] $message');
    }
  }

  // -------------------------------------------------------------------------
  // Builders for the four specimen configurations.
  // -------------------------------------------------------------------------

  TextMagnifierConfiguration _configForSpecimen(_TmcfgSpecimen spec) {
    switch (spec.builderKind) {
      case 'platform-adaptive':
        return const TextMagnifierConfiguration();
      case 'disabled':
        return TextMagnifierConfiguration.disabled;
      case 'circle':
        return TextMagnifierConfiguration(
          magnifierBuilder: _tmcfgCircleMagnifierBuilder,
          shouldDisplayHandlesInMagnifier: spec.handles,
        );
      case 'roundedRect':
        return TextMagnifierConfiguration(
          magnifierBuilder: _tmcfgRoundedRectMagnifierBuilder,
          shouldDisplayHandlesInMagnifier: spec.handles,
        );
    }
    return const TextMagnifierConfiguration();
  }

  TextMagnifierConfiguration _playgroundConfig() {
    final MagnifierBuilder chosen;
    switch (_preset) {
      case _TmcfgPreset.pill:
        chosen = _tmcfgPillMagnifierBuilder;
        break;
      case _TmcfgPreset.circle:
        chosen = _tmcfgCircleMagnifierBuilder;
        break;
      case _TmcfgPreset.roundedRect:
        chosen = _tmcfgRoundedRectMagnifierBuilder;
        break;
    }
    // Wrap the chosen builder so we can thread the playground scale through
    // the existing MagnifierBuilder signature without changing its shape.
    return TextMagnifierConfiguration(
      magnifierBuilder: (
        BuildContext context,
        MagnifierController controller,
        ValueNotifier<MagnifierInfo> notifier,
      ) {
        _trace('Playground builder invoked, scale=$_scale preset=$_preset');
        return _TmcfgScaleProxy(
          scale: _scale,
          inner: chosen(context, controller, notifier),
        );
      },
      shouldDisplayHandlesInMagnifier: _handlesOnMagnifier,
    );
  }

  // -------------------------------------------------------------------------
  // Layout scaffolding.
  // -------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: _tmcfgPalette.background,
        textTheme: Typography.blackMountainView.apply(
          bodyColor: _tmcfgPalette.ink,
          displayColor: _tmcfgPalette.ink,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: _tmcfgPalette.sky,
          primary: _tmcfgPalette.sky,
          secondary: _tmcfgPalette.ruby,
          surface: _tmcfgPalette.surface,
        ),
      ),
      home: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(child: _buildHeroHeader()),
              SliverToBoxAdapter(child: _buildIntroBand()),
              SliverToBoxAdapter(child: _buildSpecimenGrid()),
              SliverToBoxAdapter(child: _buildCrossSectionPanel()),
              SliverToBoxAdapter(child: _buildDiagnosticCard()),
              SliverToBoxAdapter(child: _buildPlayground()),
              SliverToBoxAdapter(child: _buildApiCard()),
              SliverToBoxAdapter(child: _buildPitfallCard()),
              SliverToBoxAdapter(child: _buildReferenceRails()),
              SliverToBoxAdapter(child: _buildFooter()),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Hero header — animated lens-flare CustomPainter.
  // -------------------------------------------------------------------------

  Widget _buildHeroHeader() {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 18, 18, 10),
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            _tmcfgPalette.sky.withValues(alpha: 0.95),
            _tmcfgPalette.ink.withValues(alpha: 0.92),
          ],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _tmcfgPalette.ink.withValues(alpha: 0.22),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 168,
            height: 168,
            child: AnimatedBuilder(
              animation: _flareController,
              builder: (BuildContext context, Widget? _) {
                return CustomPaint(
                  painter: _TmcfgLensFlarePainter(
                    progress: _flareController.value,
                    sky: _tmcfgPalette.sky,
                    ruby: _tmcfgPalette.ruby,
                    brass: _tmcfgPalette.brass,
                    glass: _tmcfgPalette.glass,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 22),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Magnifier Atelier',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                    color: _tmcfgPalette.glass,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'TextMagnifierConfiguration — lenses for TextField and EditableText',
                  style: TextStyle(
                    fontSize: 14,
                    color: _tmcfgPalette.glass.withValues(alpha: 0.85),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  children: <Widget>[
                    _chip('magnifierBuilder', _tmcfgPalette.ruby),
                    _chip('shouldDisplayHandlesInMagnifier',
                        _tmcfgPalette.brass),
                    _chip('MagnifierController', _tmcfgPalette.glass),
                    _chip('ValueNotifier<MagnifierInfo>', _tmcfgPalette.glass),
                    _chip('.disabled', _tmcfgPalette.ruby),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.55)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11.5,
          fontFamily: 'monospace',
          color: color == _tmcfgPalette.glass
              ? _tmcfgPalette.glass
              : _tmcfgPalette.glass.withValues(alpha: 0.95),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Intro band — three short textual cards framing the concept.
  // -------------------------------------------------------------------------

  Widget _buildIntroBand() {
    final cards = <Map<String, Object>>[
      <String, Object>{
        'title': 'What it configures',
        'body':
            'A bundle describing how TextField/EditableText should render the '
                'magnifier loupe during selection on touch platforms.',
        'icon': Icons.tune,
        'accent': _tmcfgPalette.sky,
      },
      <String, Object>{
        'title': 'Who supplies it',
        'body':
            'The caller — each TextField accepts magnifierConfiguration. '
                'Platform defaults provide a sensible adaptive loupe.',
        'icon': Icons.touch_app,
        'accent': _tmcfgPalette.brass,
      },
      <String, Object>{
        'title': 'When it triggers',
        'body':
            'Primarily on long-press and handle drags on touch devices. '
                'Desktop/mouse flows typically skip the builder.',
        'icon': Icons.timer_outlined,
        'accent': _tmcfgPalette.ruby,
      },
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(18, 4, 18, 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (int i = 0; i < cards.length; i++)
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: i == 0 ? 0 : 8,
                  right: i == cards.length - 1 ? 0 : 8,
                ),
                child: _introCard(
                  cards[i]['title'] as String,
                  cards[i]['body'] as String,
                  cards[i]['icon'] as IconData,
                  cards[i]['accent'] as Color,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _introCard(String title, String body, IconData icon, Color accent) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _tmcfgPalette.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.3)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: accent, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: accent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            body,
            style: TextStyle(
              fontSize: 12.5,
              height: 1.45,
              color: _tmcfgPalette.ink,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Specimen grid — four TextFields, one per configuration.
  // -------------------------------------------------------------------------

  Widget _buildSpecimenGrid() {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 12, 18, 6),
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
      decoration: BoxDecoration(
        color: _tmcfgPalette.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _tmcfgPalette.sky.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionHeader(
            'Specimen Bench',
            'Four live TextFields, each threaded to a distinct '
                'TextMagnifierConfiguration. Long-press on a touch device '
                'to engage the loupe.',
            Icons.view_in_ar,
            _tmcfgPalette.sky,
          ),
          const SizedBox(height: 14),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 1.55,
            children: <Widget>[
              _specimenCard(0, _specimenA),
              _specimenCard(1, _specimenB),
              _specimenCard(2, _specimenC),
              _specimenCard(3, _specimenD),
            ],
          ),
        ],
      ),
    );
  }

  Widget _specimenCard(int index, TextEditingController controller) {
    final spec = _tmcfgSpecimens[index];
    final selected = _specimenIndex == index;
    final accent = spec.accent;
    return GestureDetector(
      onTap: () {
        setState(() {
          _specimenIndex = index;
          _trace('Selected specimen $index (${spec.label})');
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected
              ? accent.withValues(alpha: 0.08)
              : _tmcfgPalette.glass,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? accent.withValues(alpha: 0.75)
                : accent.withValues(alpha: 0.25),
            width: selected ? 1.6 : 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(spec.icon, color: accent, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    spec.label,
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w800,
                      color: accent,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              spec.summary,
              style: TextStyle(
                fontSize: 11.5,
                color: _tmcfgPalette.muted,
                height: 1.4,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: controller,
              magnifierConfiguration: _configForSpecimen(spec),
              style: TextStyle(
                fontSize: 13,
                color: _tmcfgPalette.ink,
                fontFamily: 'monospace',
              ),
              maxLines: 2,
              minLines: 2,
              decoration: InputDecoration(
                filled: true,
                fillColor: _tmcfgPalette.surface,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: accent.withValues(alpha: 0.5),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: accent, width: 1.4),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: <Widget>[
                _tagChip('builder=${spec.builderKind}', accent),
                _tagChip('handles=${spec.handles}', accent),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _tagChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.5,
          fontFamily: 'monospace',
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _sectionHeader(
    String title,
    String subtitle,
    IconData icon,
    Color accent,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                accent.withValues(alpha: 0.22),
                accent.withValues(alpha: 0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accent.withValues(alpha: 0.35)),
          ),
          child: Icon(icon, color: accent, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: _tmcfgPalette.ink,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12.5,
                  color: _tmcfgPalette.muted,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // -------------------------------------------------------------------------
  // Optical cross-section panel.
  // -------------------------------------------------------------------------

  Widget _buildCrossSectionPanel() {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 12, 18, 6),
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
      decoration: BoxDecoration(
        color: _tmcfgPalette.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _tmcfgPalette.brass.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionHeader(
            'Optical Cross-Section',
            'A schematic showing how the lens projects content from the '
                'selection on the baseline up to the hovering magnifier.',
            Icons.science_outlined,
            _tmcfgPalette.brass,
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 260,
            child: AnimatedBuilder(
              animation: _rayController,
              builder: (BuildContext context, Widget? _) {
                return CustomPaint(
                  painter: _TmcfgCrossSectionPainter(
                    ray: _rayController.value,
                    sky: _tmcfgPalette.sky,
                    brass: _tmcfgPalette.brass,
                    ruby: _tmcfgPalette.ruby,
                    glass: _tmcfgPalette.glass,
                    ink: _tmcfgPalette.ink,
                  ),
                  size: Size.infinite,
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              _legendDot(_tmcfgPalette.ruby, 'Ray path'),
              const SizedBox(width: 14),
              _legendDot(_tmcfgPalette.brass, 'Lens rim'),
              const SizedBox(width: 14),
              _legendDot(_tmcfgPalette.sky, 'Focal axis'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _legendDot(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.5,
            color: _tmcfgPalette.ink,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // -------------------------------------------------------------------------
  // Diagnostic card — live display of the selected config's fields.
  // -------------------------------------------------------------------------

  Widget _buildDiagnosticCard() {
    final spec = _tmcfgSpecimens[_specimenIndex];
    final cfg = _configForSpecimen(spec);
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 12, 18, 6),
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
      decoration: BoxDecoration(
        color: _tmcfgPalette.ink,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _tmcfgPalette.ruby.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.terminal, color: _tmcfgPalette.ruby, size: 22),
              const SizedBox(width: 10),
              Text(
                'Config Diagnostic',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: _tmcfgPalette.glass,
                ),
              ),
              const Spacer(),
              _tagChip('specimen #${_specimenIndex + 1}', _tmcfgPalette.brass),
            ],
          ),
          const SizedBox(height: 12),
          _diagRow('label', spec.label),
          _diagRow('builderKind', spec.builderKind),
          _diagRow('shouldDisplayHandlesInMagnifier',
              spec.handles.toString()),
          _diagRow(
            'builder is no-op',
            identical(
              cfg.magnifierBuilder,
              TextMagnifierConfiguration.disabled.magnifierBuilder,
            ).toString(),
          ),
          _diagRow('identicalTo(.disabled)',
              identical(cfg, TextMagnifierConfiguration.disabled).toString()),
          _diagRow('identicalTo(.empty)',
              identical(cfg, const TextMagnifierConfiguration()).toString()),
          _diagRow('runtimeType', cfg.runtimeType.toString()),
        ],
      ),
    );
  }

  Widget _diagRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 220,
            child: Text(
              key,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'monospace',
                color: _tmcfgPalette.brass,
              ),
            ),
          ),
          Text(
            ' = ',
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: _tmcfgPalette.muted,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'monospace',
                color: _tmcfgPalette.glass,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Interactive playground.
  // -------------------------------------------------------------------------

  Widget _buildPlayground() {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 12, 18, 6),
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
      decoration: BoxDecoration(
        color: _tmcfgPalette.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _tmcfgPalette.sky.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionHeader(
            'Interactive Playground',
            'Rewire the custom magnifierBuilder live. Choose a preset, '
                'scale the lens, and toggle handle rendering on the loupe.',
            Icons.science,
            _tmcfgPalette.sky,
          ),
          const SizedBox(height: 14),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final bool wide = constraints.maxWidth > 640;
              final Widget controls = _playgroundControls();
              final Widget preview = _playgroundPreview();
              if (wide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(flex: 5, child: controls),
                    const SizedBox(width: 14),
                    Expanded(flex: 6, child: preview),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  controls,
                  const SizedBox(height: 12),
                  preview,
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _playgroundControls() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _tmcfgPalette.glass,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _tmcfgPalette.sky.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Preset magnifierBuilder',
            style: TextStyle(
              fontSize: 12.5,
              color: _tmcfgPalette.muted,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<_TmcfgPreset>(
            initialValue: _preset,
            decoration: InputDecoration(
              filled: true,
              fillColor: _tmcfgPalette.surface,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 8),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: _tmcfgPalette.sky.withValues(alpha: 0.4),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: _tmcfgPalette.sky, width: 1.4),
              ),
            ),
            items: const <DropdownMenuItem<_TmcfgPreset>>[
              DropdownMenuItem<_TmcfgPreset>(
                value: _TmcfgPreset.pill,
                child: Text('Pill (wide horizontal loupe)'),
              ),
              DropdownMenuItem<_TmcfgPreset>(
                value: _TmcfgPreset.circle,
                child: Text('Circle (classic round lens)'),
              ),
              DropdownMenuItem<_TmcfgPreset>(
                value: _TmcfgPreset.roundedRect,
                child: Text('Rounded rectangle (tablet style)'),
              ),
            ],
            onChanged: (_TmcfgPreset? value) {
              if (value == null) return;
              setState(() {
                _preset = value;
                _trace('Preset changed to $value');
              });
            },
          ),
          const SizedBox(height: 14),
          Text(
            'shouldDisplayHandlesInMagnifier',
            style: TextStyle(
              fontSize: 12.5,
              color: _tmcfgPalette.muted,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: <Widget>[
              Switch(
                value: _handlesOnMagnifier,
                activeThumbColor: _tmcfgPalette.ruby,
                onChanged: (bool v) {
                  setState(() {
                    _handlesOnMagnifier = v;
                    _trace('Handles toggle = $v');
                  });
                },
              ),
              const SizedBox(width: 8),
              Text(
                _handlesOnMagnifier
                    ? 'Handles travel with the loupe'
                    : 'Handles stay below the loupe',
                style: TextStyle(
                  fontSize: 12.5,
                  color: _tmcfgPalette.ink,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Magnifier scale factor: ${_scale.toStringAsFixed(2)}x',
            style: TextStyle(
              fontSize: 12.5,
              color: _tmcfgPalette.muted,
              fontWeight: FontWeight.w600,
            ),
          ),
          Slider(
            value: _scale,
            onChanged: (double v) {
              setState(() {
                _scale = v;
                _trace('Scale = $v');
              });
            },
            min: 1.1,
            max: 2.5,
            divisions: 28,
            activeColor: _tmcfgPalette.ruby,
            label: '${_scale.toStringAsFixed(2)}x',
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Icon(Icons.bug_report_outlined,
                  color: _tmcfgPalette.brass, size: 16),
              const SizedBox(width: 6),
              Text(
                'Verbose tracing',
                style: TextStyle(
                  fontSize: 12.5,
                  color: _tmcfgPalette.ink,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Switch(
                value: _verbose,
                activeThumbColor: _tmcfgPalette.brass,
                onChanged: (bool v) {
                  setState(() {
                    _verbose = v;
                  });
                  if (v) {
                    debugPrint('[TmcfgAtelier] verbose tracing enabled');
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _playgroundPreview() {
    final cfg = _playgroundConfig();
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _tmcfgPalette.ink.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(14),
        border:
            Border.all(color: _tmcfgPalette.brass.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.zoom_in, color: _tmcfgPalette.ruby, size: 18),
              const SizedBox(width: 8),
              Text(
                'Live playground field',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: _tmcfgPalette.ink,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _playgroundController,
            magnifierConfiguration: cfg,
            maxLines: 3,
            minLines: 3,
            style: TextStyle(
              fontSize: 13.5,
              color: _tmcfgPalette.ink,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: _tmcfgPalette.surface,
              hintText: 'Long-press on a touch device to engage the loupe',
              hintStyle: TextStyle(color: _tmcfgPalette.muted),
              contentPadding: const EdgeInsets.all(12),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _tmcfgPalette.ruby.withValues(alpha: 0.5),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: _tmcfgPalette.ruby, width: 1.4),
              ),
            ),
          ),
          const SizedBox(height: 10),
          _previewSummaryLine(
            'preset',
            _preset.toString().split('.').last,
            _tmcfgPalette.brass,
          ),
          _previewSummaryLine(
            'scale',
            '${_scale.toStringAsFixed(2)}x',
            _tmcfgPalette.sky,
          ),
          _previewSummaryLine(
            'handles',
            _handlesOnMagnifier.toString(),
            _tmcfgPalette.ruby,
          ),
          _previewSummaryLine(
            'builder no-op',
            identical(
              cfg.magnifierBuilder,
              TextMagnifierConfiguration.disabled.magnifierBuilder,
            ).toString(),
            _tmcfgPalette.muted,
          ),
        ],
      ),
    );
  }

  Widget _previewSummaryLine(String key, String value, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: <Widget>[
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: accent,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$key: ',
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: _tmcfgPalette.muted,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: _tmcfgPalette.ink,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Quoted API card.
  // -------------------------------------------------------------------------

  Widget _buildApiCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 12, 18, 6),
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
      decoration: BoxDecoration(
        color: _tmcfgPalette.ink,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.menu_book_outlined,
                  color: _tmcfgPalette.brass, size: 22),
              const SizedBox(width: 10),
              Text(
                'Quoted API',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: _tmcfgPalette.glass,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _codeBlock(<String>[
            '/// The configuration passed to TextField / EditableText',
            '/// controlling the touch-selection magnifier loupe.',
            'class TextMagnifierConfiguration {',
            '  const TextMagnifierConfiguration({',
            '    MagnifierBuilder? magnifierBuilder,',
            '    this.shouldDisplayHandlesInMagnifier = true,',
            '  }) : _magnifierBuilder = magnifierBuilder;',
            '',
            '  /// Static instance disabling the magnifier entirely.',
            '  static const TextMagnifierConfiguration disabled = ...;',
            '',
            '  /// Static instance with no custom builder — falls back to',
            '  /// the platform-adaptive default TextMagnifier.',
            '  static const TextMagnifierConfiguration empty = ...;',
            '}',
          ]),
          const SizedBox(height: 14),
          _codeBlock(<String>[
            '/// Function type for building the actual magnifier widget.',
            'typedef MagnifierBuilder = Widget? Function(',
            '  BuildContext context,',
            '  MagnifierController controller,',
            '  ValueNotifier<MagnifierInfo> magnifierInfo,',
            ');',
          ]),
        ],
      ),
    );
  }

  Widget _codeBlock(List<String> lines) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _tmcfgPalette.glass.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border:
            Border.all(color: _tmcfgPalette.brass.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (final String line in lines)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Text(
                line.isEmpty ? ' ' : line,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: line.startsWith('///') || line.startsWith('  ///')
                      ? _tmcfgPalette.muted
                      : _tmcfgPalette.glass,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Pitfall card.
  // -------------------------------------------------------------------------

  Widget _buildPitfallCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 12, 18, 6),
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            _tmcfgPalette.ruby.withValues(alpha: 0.1),
            _tmcfgPalette.ruby.withValues(alpha: 0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _tmcfgPalette.ruby.withValues(alpha: 0.45)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _tmcfgPalette.ruby.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.warning_amber_rounded,
                color: _tmcfgPalette.ruby, size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Pitfall — touch-only invocation',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: _tmcfgPalette.ruby,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'The custom magnifierBuilder is typically only invoked '
                  'during touch-driven selection (long-press, handle drag). '
                  'Desktop mouse selection or keyboard-based selection on '
                  'platforms without a magnifier will silently skip the '
                  'builder. Do not encode business logic in the builder — '
                  'treat it strictly as a visual concern, and perform any '
                  'semantic work elsewhere so it is not skipped on desktop.',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: _tmcfgPalette.ink,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: <Widget>[
                    _tagChip('touch-only', _tmcfgPalette.ruby),
                    _tagChip('visual-only', _tmcfgPalette.brass),
                    _tagChip('no side effects', _tmcfgPalette.ink),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Reference rails — extra educational callouts filling out the page.
  // -------------------------------------------------------------------------

  Widget _buildReferenceRails() {
    final rails = <Map<String, Object>>[
      <String, Object>{
        'title': 'Default behaviour',
        'body':
            'When TextField receives no magnifierConfiguration it uses the '
                'platform-adaptive default returned by '
                'TextMagnifier.adaptiveMagnifierConfiguration, which mirrors '
                'iOS-style loupes on iOS and Material-style loupes on Android.',
        'icon': Icons.smartphone,
        'accent': _tmcfgPalette.sky,
      },
      <String, Object>{
        'title': 'Null builder vs .disabled',
        'body':
            'Passing a config whose magnifierBuilder returns null effectively '
                'disables the magnifier, but .disabled is a canned sentinel '
                'with clearer intent. Prefer the sentinel for readability.',
        'icon': Icons.block_flipped,
        'accent': _tmcfgPalette.ruby,
      },
      <String, Object>{
        'title': 'MagnifierInfo notifier',
        'body':
            'The notifier reports field size, global selection position, '
                'caret rect, and the current drag position. Your builder '
                'reads from it with ValueListenableBuilder to reposition.',
        'icon': Icons.my_location,
        'accent': _tmcfgPalette.brass,
      },
      <String, Object>{
        'title': 'MagnifierController',
        'body':
            'The controller owns the overlay entry hosting the magnifier. '
                'Use it to coordinate show/hide transitions or to inspect '
                'the currently mounted overlay entry.',
        'icon': Icons.settings_applications_outlined,
        'accent': _tmcfgPalette.ink,
      },
      <String, Object>{
        'title': 'Interplay with handles',
        'body':
            'shouldDisplayHandlesInMagnifier tells the framework whether '
                'text selection handles should be painted onto the magnified '
                'surface while it is visible. Useful for precise handle drag.',
        'icon': Icons.drag_handle,
        'accent': _tmcfgPalette.sky,
      },
      <String, Object>{
        'title': 'Performance notes',
        'body':
            'The magnifier repaints while the drag position changes. Keep '
                'the custom builder widget tree shallow — avoid expensive '
                'layouts or animations that would stall the drag rate.',
        'icon': Icons.speed,
        'accent': _tmcfgPalette.brass,
      },
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(18, 12, 18, 6),
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
      decoration: BoxDecoration(
        color: _tmcfgPalette.surface,
        borderRadius: BorderRadius.circular(18),
        border:
            Border.all(color: _tmcfgPalette.muted.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionHeader(
            'Reference Rails',
            'Quick-reference call-outs about the configuration and how it '
                'plugs into the selection-magnifier pipeline.',
            Icons.bookmark_outline,
            _tmcfgPalette.brass,
          ),
          const SizedBox(height: 14),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 2.0,
            children: <Widget>[
              for (final Map<String, Object> rail in rails)
                _railCard(
                  rail['title'] as String,
                  rail['body'] as String,
                  rail['icon'] as IconData,
                  rail['accent'] as Color,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _railCard(String title, String body, IconData icon, Color accent) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: accent, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: accent,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              body,
              style: TextStyle(
                fontSize: 11.5,
                color: _tmcfgPalette.ink,
                height: 1.45,
              ),
              overflow: TextOverflow.fade,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Footer.
  // -------------------------------------------------------------------------

  Widget _buildFooter() {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 12, 18, 24),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: _tmcfgPalette.ink,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.verified_outlined,
              color: _tmcfgPalette.brass, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Magnifier Atelier — hand-authored optical demo of '
              'TextMagnifierConfiguration rendered under the d4rt AST '
              'harness. Sky/glass/ruby/brass palette; live specimens; '
              'interactive playground; cross-section schematic; quoted API.',
              style: TextStyle(
                fontSize: 11.5,
                color: _tmcfgPalette.glass,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Custom MagnifierBuilder #1 — brass-rimmed circular lens.
// ---------------------------------------------------------------------------

Widget? _tmcfgCircleMagnifierBuilder(
  BuildContext context,
  MagnifierController controller,
  ValueNotifier<MagnifierInfo> notifier,
) {
  debugPrint('[Tmcfg] circle magnifier builder invoked');
  return _TmcfgHoveringLens(
    notifier: notifier,
    shape: _TmcfgLensShape.circle,
    size: const Size(124, 124),
    rimColor: _tmcfgPalette.brass,
    innerColor: _tmcfgPalette.glass,
    indexColor: _tmcfgPalette.ruby,
  );
}

// ---------------------------------------------------------------------------
// Custom MagnifierBuilder #2 — rounded-rectangle tablet-style loupe.
// ---------------------------------------------------------------------------

Widget? _tmcfgRoundedRectMagnifierBuilder(
  BuildContext context,
  MagnifierController controller,
  ValueNotifier<MagnifierInfo> notifier,
) {
  debugPrint('[Tmcfg] roundedRect magnifier builder invoked');
  return _TmcfgHoveringLens(
    notifier: notifier,
    shape: _TmcfgLensShape.roundedRect,
    size: const Size(156, 92),
    rimColor: _tmcfgPalette.sky,
    innerColor: _tmcfgPalette.glass,
    indexColor: _tmcfgPalette.ruby,
  );
}

// ---------------------------------------------------------------------------
// Custom MagnifierBuilder #3 — pill-shaped loupe (horizontal ellipse).
// ---------------------------------------------------------------------------

Widget? _tmcfgPillMagnifierBuilder(
  BuildContext context,
  MagnifierController controller,
  ValueNotifier<MagnifierInfo> notifier,
) {
  debugPrint('[Tmcfg] pill magnifier builder invoked');
  return _TmcfgHoveringLens(
    notifier: notifier,
    shape: _TmcfgLensShape.pill,
    size: const Size(180, 72),
    rimColor: _tmcfgPalette.ruby,
    innerColor: _tmcfgPalette.glass,
    indexColor: _tmcfgPalette.brass,
  );
}

// ---------------------------------------------------------------------------
// Shape enum for the hovering lens.
// ---------------------------------------------------------------------------

enum _TmcfgLensShape {
  circle,
  roundedRect,
  pill,
}

// ---------------------------------------------------------------------------
// Hovering-lens widget — reads MagnifierInfo from the notifier and
// positions itself above the current drag point.
// ---------------------------------------------------------------------------

class _TmcfgHoveringLens extends StatelessWidget {
  final ValueNotifier<MagnifierInfo> notifier;
  final _TmcfgLensShape shape;
  final Size size;
  final Color rimColor;
  final Color innerColor;
  final Color indexColor;

  const _TmcfgHoveringLens({
    required this.notifier,
    required this.shape,
    required this.size,
    required this.rimColor,
    required this.innerColor,
    required this.indexColor,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<MagnifierInfo>(
      valueListenable: notifier,
      builder: (BuildContext context, MagnifierInfo info, Widget? _) {
        final Offset anchor = info.globalGesturePosition;
        final Offset topLeft = Offset(
          anchor.dx - size.width / 2,
          anchor.dy - size.height - 18,
        );
        return Positioned(
          left: topLeft.dx,
          top: topLeft.dy,
          child: IgnorePointer(
            child: CustomPaint(
              size: size,
              painter: _TmcfgLensPainter(
                shape: shape,
                rimColor: rimColor,
                innerColor: innerColor,
                indexColor: indexColor,
              ),
            ),
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Scale proxy — wraps a rendered lens, scaling it by the playground slider.
// ---------------------------------------------------------------------------

class _TmcfgScaleProxy extends StatelessWidget {
  final double scale;
  final Widget? inner;

  const _TmcfgScaleProxy({
    required this.scale,
    required this.inner,
  });

  @override
  Widget build(BuildContext context) {
    final Widget effective = inner ?? const SizedBox.shrink();
    return Transform.scale(
      scale: scale,
      alignment: Alignment.bottomCenter,
      child: effective,
    );
  }
}

// ---------------------------------------------------------------------------
// Lens painter — draws the filled inner area + brass rim + ruby index mark.
// ---------------------------------------------------------------------------

class _TmcfgLensPainter extends CustomPainter {
  final _TmcfgLensShape shape;
  final Color rimColor;
  final Color innerColor;
  final Color indexColor;

  const _TmcfgLensPainter({
    required this.shape,
    required this.rimColor,
    required this.innerColor,
    required this.indexColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Path bodyPath = _buildPath(rect);
    final Paint fill = Paint()
      ..style = PaintingStyle.fill
      ..color = innerColor.withValues(alpha: 0.88);
    final Paint rim = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..color = rimColor;
    final Paint innerRim = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = rimColor.withValues(alpha: 0.6);
    canvas.drawShadow(bodyPath, rimColor.withValues(alpha: 0.45), 6, false);
    canvas.drawPath(bodyPath, fill);
    canvas.drawPath(bodyPath, rim);
    canvas.drawPath(bodyPath.shift(const Offset(0, 0)), innerRim);

    // Ruby index mark — a small dot at the top of the lens.
    final Paint indexPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = indexColor;
    canvas.drawCircle(
      Offset(size.width / 2, 6),
      3.2,
      indexPaint,
    );
    canvas.drawCircle(
      Offset(size.width / 2, 6),
      3.2,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.1
        ..color = rimColor,
    );

    // Cross-hair inside the lens (ray-diagram hint).
    final Paint hairPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8
      ..color = rimColor.withValues(alpha: 0.45);
    canvas.drawLine(
      Offset(size.width / 2, size.height * 0.25),
      Offset(size.width / 2, size.height * 0.75),
      hairPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.25, size.height / 2),
      Offset(size.width * 0.75, size.height / 2),
      hairPaint,
    );
  }

  Path _buildPath(Rect rect) {
    switch (shape) {
      case _TmcfgLensShape.circle:
        return Path()..addOval(rect);
      case _TmcfgLensShape.roundedRect:
        return Path()
          ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(16)));
      case _TmcfgLensShape.pill:
        return Path()
          ..addRRect(
            RRect.fromRectAndRadius(
              rect,
              Radius.circular(rect.height / 2),
            ),
          );
    }
  }

  @override
  bool shouldRepaint(covariant _TmcfgLensPainter old) {
    return old.shape != shape ||
        old.rimColor != rimColor ||
        old.innerColor != innerColor ||
        old.indexColor != indexColor;
  }
}

// ---------------------------------------------------------------------------
// Hero header — animated lens-flare painter.
// ---------------------------------------------------------------------------

class _TmcfgLensFlarePainter extends CustomPainter {
  final double progress;
  final Color sky;
  final Color ruby;
  final Color brass;
  final Color glass;

  const _TmcfgLensFlarePainter({
    required this.progress,
    required this.sky,
    required this.ruby,
    required this.brass,
    required this.glass,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = math.min(size.width, size.height) / 2 - 4;

    // Glass body.
    final Paint glassFill = Paint()
      ..shader = RadialGradient(
        colors: <Color>[
          glass.withValues(alpha: 0.85),
          glass.withValues(alpha: 0.10),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, glassFill);

    // Concentric brass rings.
    for (int i = 0; i < 5; i++) {
      final double r = radius * (1.0 - i * 0.12);
      final Paint ring = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = (i == 0) ? 4 : (i == 4 ? 0.8 : 1.5)
        ..color = brass.withValues(alpha: 0.8 - (i * 0.12));
      canvas.drawCircle(center, r, ring);
    }

    // Cross hairs.
    final Paint hair = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = sky.withValues(alpha: 0.5);
    canvas.drawLine(
      Offset(center.dx - radius * 0.85, center.dy),
      Offset(center.dx + radius * 0.85, center.dy),
      hair,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy - radius * 0.85),
      Offset(center.dx, center.dy + radius * 0.85),
      hair,
    );

    // Ruby light-bead travelling around the rim.
    final double angle = progress * math.pi * 2;
    final Offset bead = Offset(
      center.dx + radius * math.cos(angle),
      center.dy + radius * math.sin(angle),
    );
    final Paint beadGlow = Paint()
      ..style = PaintingStyle.fill
      ..shader = RadialGradient(
        colors: <Color>[
          ruby.withValues(alpha: 0.9),
          ruby.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(center: bead, radius: 16));
    canvas.drawCircle(bead, 16, beadGlow);

    final Paint beadCore = Paint()
      ..style = PaintingStyle.fill
      ..color = ruby;
    canvas.drawCircle(bead, 4.5, beadCore);

    // Secondary satellite beads lagging the main bead.
    for (int i = 1; i <= 3; i++) {
      final double a = angle - (i * 0.18);
      final Offset satellite = Offset(
        center.dx + radius * math.cos(a),
        center.dy + radius * math.sin(a),
      );
      final Paint satellitePaint = Paint()
        ..style = PaintingStyle.fill
        ..color = ruby.withValues(alpha: 0.35 - i * 0.08);
      canvas.drawCircle(satellite, 3.0 - i * 0.4, satellitePaint);
    }

    // Inner highlight (specular).
    final Paint specular = Paint()
      ..style = PaintingStyle.fill
      ..shader = RadialGradient(
        colors: <Color>[
          glass.withValues(alpha: 0.7),
          glass.withValues(alpha: 0.0),
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(center.dx - radius * 0.25, center.dy - radius * 0.25),
          radius: radius * 0.3,
        ),
      );
    canvas.drawCircle(
      Offset(center.dx - radius * 0.25, center.dy - radius * 0.25),
      radius * 0.3,
      specular,
    );

    // Label tick marks (brass calipers).
    final Paint tick = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = brass.withValues(alpha: 0.85);
    for (int i = 0; i < 36; i++) {
      final double a = i * math.pi / 18;
      final double inner = radius * 0.92;
      final double outer = (i % 3 == 0) ? radius : radius * 0.97;
      final Offset p1 = Offset(
        center.dx + inner * math.cos(a),
        center.dy + inner * math.sin(a),
      );
      final Offset p2 = Offset(
        center.dx + outer * math.cos(a),
        center.dy + outer * math.sin(a),
      );
      canvas.drawLine(p1, p2, tick);
    }
  }

  @override
  bool shouldRepaint(covariant _TmcfgLensFlarePainter old) {
    return old.progress != progress;
  }
}

// ---------------------------------------------------------------------------
// Cross-section painter — lens + ray diagram + baseline selection.
// ---------------------------------------------------------------------------

class _TmcfgCrossSectionPainter extends CustomPainter {
  final double ray;
  final Color sky;
  final Color brass;
  final Color ruby;
  final Color glass;
  final Color ink;

  const _TmcfgCrossSectionPainter({
    required this.ray,
    required this.sky,
    required this.brass,
    required this.ruby,
    required this.glass,
    required this.ink,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Backdrop grid.
    final Paint gridPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..color = ink.withValues(alpha: 0.06);
    for (double x = 0; x < size.width; x += 24) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += 24) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Focal axis (vertical).
    final double axisX = size.width / 2;
    final Paint axisPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = sky.withValues(alpha: 0.75);
    canvas.drawLine(
      Offset(axisX, 12),
      Offset(axisX, size.height - 32),
      axisPaint,
    );

    // Baseline — where the TextField sits.
    final double baselineY = size.height - 40;
    final Paint baselinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = ink.withValues(alpha: 0.75);
    canvas.drawLine(
      Offset(20, baselineY),
      Offset(size.width - 20, baselineY),
      baselinePaint,
    );

    // Selection range on the baseline.
    final Paint selectionPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = sky.withValues(alpha: 0.25);
    final Rect selectionRect = Rect.fromLTWH(
      axisX - 40,
      baselineY - 12,
      80,
      12,
    );
    canvas.drawRect(selectionRect, selectionPaint);
    canvas.drawRect(
      selectionRect,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = sky.withValues(alpha: 0.9),
    );

    // The hovering lens body.
    final double lensY = 72;
    final double lensRadius = 48;
    final Offset lensCenter = Offset(axisX, lensY);

    final Paint lensFill = Paint()
      ..style = PaintingStyle.fill
      ..shader = RadialGradient(
        colors: <Color>[
          glass.withValues(alpha: 0.95),
          glass.withValues(alpha: 0.35),
        ],
      ).createShader(Rect.fromCircle(center: lensCenter, radius: lensRadius));
    canvas.drawCircle(lensCenter, lensRadius, lensFill);

    final Paint lensRim = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.2
      ..color = brass;
    canvas.drawCircle(lensCenter, lensRadius, lensRim);

    final Paint innerRim = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1
      ..color = brass.withValues(alpha: 0.55);
    canvas.drawCircle(lensCenter, lensRadius - 6, innerRim);

    // Ray paths from selection edges to the lens edges.
    final List<Offset> sources = <Offset>[
      Offset(selectionRect.left, baselineY - 6),
      Offset(selectionRect.right, baselineY - 6),
      Offset(selectionRect.center.dx, baselineY - 6),
    ];
    final List<Offset> targets = <Offset>[
      Offset(lensCenter.dx - lensRadius + 8, lensCenter.dy + 4),
      Offset(lensCenter.dx + lensRadius - 8, lensCenter.dy + 4),
      Offset(lensCenter.dx, lensCenter.dy + lensRadius - 6),
    ];

    for (int i = 0; i < sources.length; i++) {
      final Paint rayPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..color = ruby.withValues(alpha: 0.7 + 0.2 * ray);
      canvas.drawLine(sources[i], targets[i], rayPaint);
      // Arrow tip.
      _drawArrow(canvas, sources[i], targets[i], rayPaint);
    }

    // Labels.
    _paintLabel(canvas, 'Lens', Offset(lensCenter.dx + lensRadius + 8,
        lensCenter.dy - 6), brass);
    _paintLabel(canvas, 'Selection', Offset(selectionRect.right + 6,
        baselineY - 2), sky);
    _paintLabel(canvas, 'Baseline', Offset(24, baselineY + 14), ink);
    _paintLabel(canvas, 'Focal axis', Offset(axisX + 4, 6),
        sky.withValues(alpha: 0.85));

    // A travelling bead on the focal axis to animate the ray-trace.
    final double beadY = 72 + ((baselineY - 72 - 16) * ray);
    final Paint beadPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = ruby;
    canvas.drawCircle(Offset(axisX, beadY), 3.6, beadPaint);
    canvas.drawCircle(
      Offset(axisX, beadY),
      3.6,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = glass,
    );
  }

  void _drawArrow(Canvas canvas, Offset from, Offset to, Paint basePaint) {
    final double angle = math.atan2(to.dy - from.dy, to.dx - from.dx);
    const double arrow = 6;
    final Offset p1 = Offset(
      to.dx - arrow * math.cos(angle - math.pi / 7),
      to.dy - arrow * math.sin(angle - math.pi / 7),
    );
    final Offset p2 = Offset(
      to.dx - arrow * math.cos(angle + math.pi / 7),
      to.dy - arrow * math.sin(angle + math.pi / 7),
    );
    canvas.drawLine(to, p1, basePaint);
    canvas.drawLine(to, p2, basePaint);
  }

  void _paintLabel(Canvas canvas, String text, Offset offset, Color color) {
    final TextSpan span = TextSpan(
      text: text,
      style: TextStyle(
        fontSize: 11,
        color: color,
        fontWeight: FontWeight.w700,
        fontFamily: 'monospace',
      ),
    );
    final TextPainter tp = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant _TmcfgCrossSectionPainter old) {
    return old.ray != ray;
  }
}
