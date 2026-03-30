import 'dart:math' as math;

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// ColorFiltered Deep Demo
//
// ColorFiltered wraps its child in a ColorFilter, which transforms every
// pixel that the child paints.  It is a lightweight composition-layer widget
// useful for:
//  • Greyscale / disabled states
//  • Tinting images or icons with blend modes
//  • Colour-matrix effects (sepia, invert, hue rotation, …)
//  • Accessibility simulations (colour-blind preview)
//  • Dark-mode hacks (invert + hue-rotate)
//
// Unlike ShaderMask (which uses a gradient Shader) or ImageFiltered (which
// manipulates geometry via ImageFilter), ColorFiltered operates purely on
// colour channels.  It takes a single ColorFilter argument.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return const _ColorFilteredDeepDemo();
}

// ============================  Scene enum  =================================

enum _Scene {
  primer,
  blendGallery,
  matrixWorkshop,
  animatedFilters,
  practicalUses,
  compendium,
}

// ============================  Skin palette  ================================

class _Skin {
  const _Skin({
    required this.name,
    required this.shell,
    required this.paper,
    required this.panel,
    required this.ink,
    required this.muted,
    required this.primary,
    required this.secondary,
    required this.tertiary,
  });

  final String name;
  final Color shell;
  final Color paper;
  final Color panel;
  final Color ink;
  final Color muted;
  final Color primary;
  final Color secondary;
  final Color tertiary;
}

const _skins = <_Skin>[
  _Skin(
    name: 'Cobalt Studio',
    shell: Color(0xFF0D1F30),
    paper: Color(0xFFF0F6FC),
    panel: Color(0xFFFFFFFF),
    ink: Color(0xFF1B3044),
    muted: Color(0xFF728C9E),
    primary: Color(0xFF1778C8),
    secondary: Color(0xFF22876A),
    tertiary: Color(0xFFCB8520),
  ),
  _Skin(
    name: 'Sage Workshop',
    shell: Color(0xFF162318),
    paper: Color(0xFFF1F8F3),
    panel: Color(0xFFFFFFFF),
    ink: Color(0xFF263830),
    muted: Color(0xFF6F8A76),
    primary: Color(0xFF2A8E40),
    secondary: Color(0xFF1E7D9A),
    tertiary: Color(0xFFAD8730),
  ),
  _Skin(
    name: 'Ember Theater',
    shell: Color(0xFF291D18),
    paper: Color(0xFFFFF5EE),
    panel: Color(0xFFFFFFFF),
    ink: Color(0xFF3C2E26),
    muted: Color(0xFF907B6E),
    primary: Color(0xFFC06020),
    secondary: Color(0xFF2878A3),
    tertiary: Color(0xFFA08A18),
  ),
];

// ===========================  Event logger  =================================

class _DemoEvent {
  const _DemoEvent({required this.at, required this.label});
  final String at;
  final String label;
}

// ============================  Root widget  =================================

class _ColorFilteredDeepDemo extends StatefulWidget {
  const _ColorFilteredDeepDemo();

  @override
  State<_ColorFilteredDeepDemo> createState() => _ColorFilteredDeepDemoState();
}

class _ColorFilteredDeepDemoState extends State<_ColorFilteredDeepDemo> {
  _Scene _scene = _Scene.primer;
  int _skinIdx = 0;
  final List<_DemoEvent> _log = [];

  _Skin get _skin => _skins[_skinIdx % _skins.length];

  void _push(String label) {
    final now = DateTime.now();
    final stamp =
        '${now.hour.toString().padLeft(2, '0')}:'
        '${now.minute.toString().padLeft(2, '0')}:'
        '${now.second.toString().padLeft(2, '0')}';
    setState(() => _log.add(_DemoEvent(at: stamp, label: label)));
  }

  @override
  void initState() {
    super.initState();
    _push('ColorFiltered deep demo initialised');
  }

  // ----- navigation helpers -----

  String _sceneTitle(_Scene s) {
    switch (s) {
      case _Scene.primer:
        return 'Primer Stage';
      case _Scene.blendGallery:
        return 'Blend Mode Gallery';
      case _Scene.matrixWorkshop:
        return 'Matrix Workshop';
      case _Scene.animatedFilters:
        return 'Animated Filters';
      case _Scene.practicalUses:
        return 'Practical Uses';
      case _Scene.compendium:
        return 'Verification';
    }
  }

  IconData _sceneIcon(_Scene s) {
    switch (s) {
      case _Scene.primer:
        return Icons.auto_awesome;
      case _Scene.blendGallery:
        return Icons.grid_view_rounded;
      case _Scene.matrixWorkshop:
        return Icons.tune;
      case _Scene.animatedFilters:
        return Icons.animation;
      case _Scene.practicalUses:
        return Icons.build_circle;
      case _Scene.compendium:
        return Icons.check_circle_outline;
    }
  }

  // ----- build body -----

  Widget _body() {
    switch (_scene) {
      case _Scene.primer:
        return _PrimerStage(skin: _skin, onEvent: _push);
      case _Scene.blendGallery:
        return _BlendModeGallery(skin: _skin, onEvent: _push);
      case _Scene.matrixWorkshop:
        return _MatrixWorkshop(skin: _skin, onEvent: _push);
      case _Scene.animatedFilters:
        return _AnimatedFiltersSection(skin: _skin, onEvent: _push);
      case _Scene.practicalUses:
        return _PracticalUseCases(skin: _skin, onEvent: _push);
      case _Scene.compendium:
        return _Compendium(skin: _skin, log: _log);
    }
  }

  @override
  Widget build(BuildContext context) {
    final skin = _skin;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: skin.paper,
        appBar: AppBar(
          backgroundColor: skin.shell,
          foregroundColor: skin.paper,
          title: Text(
            'ColorFiltered  ·  ${_sceneTitle(_scene)}',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.palette_outlined),
              tooltip: 'Cycle skin',
              onPressed: () {
                setState(() => _skinIdx++);
                _push('Skin → ${_skins[_skinIdx % _skins.length].name}');
              },
            ),
          ],
        ),
        body: _body(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _scene.index,
          onTap: (i) {
            final s = _Scene.values[i];
            setState(() => _scene = s);
            _push('Navigate → ${_sceneTitle(s)}');
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: skin.panel,
          selectedItemColor: skin.primary,
          unselectedItemColor: skin.muted,
          selectedFontSize: 11,
          unselectedFontSize: 10,
          items: _Scene.values
              .map(
                (s) => BottomNavigationBarItem(
                  icon: Icon(_sceneIcon(s)),
                  label: _sceneTitle(s),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  1.  PRIMER STAGE
// ═══════════════════════════════════════════════════════════════════════════

class _PrimerStage extends StatelessWidget {
  const _PrimerStage({required this.skin, required this.onEvent});
  final _Skin skin;
  final void Function(String) onEvent;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // --- Introduction card ---
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: skin.panel,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: skin.muted.withAlpha(40)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.auto_awesome, color: skin.primary, size: 28),
                  const SizedBox(width: 10),
                  Text(
                    'What is ColorFiltered?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: skin.ink,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                'ColorFiltered applies a ColorFilter to every pixel its child '
                'paints.  It sits in the paint pipeline between the child\'s '
                'render and the screen, re‑mapping colour channels without '
                'affecting layout.\n\n'
                'Two factory constructors are commonly used:\n'
                '  • ColorFilter.mode(color, blendMode) — blend a single '
                'colour via a BlendMode.\n'
                '  • ColorFilter.matrix(list) — a 5×4 colour‑transformation '
                'matrix applied to [R, G, B, A, 1] producing new RGBA.\n\n'
                'Compared to Opacity, it can tint or invert — not just fade. '
                'Compared to ShaderMask, no Shader is needed. Compared to '
                'ImageFiltered, it touches colour, not geometry (blur/offset).',
                style: TextStyle(
                  fontSize: 13.5,
                  height: 1.55,
                  color: skin.ink,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // --- Before / After pair ---
        _sectionHeader(skin, 'Before / After'),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _LabelledTile(
                label: 'Original',
                skin: skin,
                child: const _RichGradientTile(),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _LabelledTile(
                label: 'mode(blue, modulate)',
                skin: skin,
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF4488CC),
                    BlendMode.modulate,
                  ),
                  child: const _RichGradientTile(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _LabelledTile(
                label: 'Greyscale matrix',
                skin: skin,
                child: ColorFiltered(
                  colorFilter: ColorFilter.matrix(_greyscaleMatrix),
                  child: const _RichGradientTile(),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _LabelledTile(
                label: 'Invert matrix',
                skin: skin,
                child: ColorFiltered(
                  colorFilter: ColorFilter.matrix(_invertMatrix),
                  child: const _RichGradientTile(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _LabelledTile(
                label: 'Sepia matrix',
                skin: skin,
                child: ColorFiltered(
                  colorFilter: ColorFilter.matrix(_sepiaMatrix),
                  child: const _RichGradientTile(),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _LabelledTile(
                label: 'mode(amber, screen)',
                skin: skin,
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Color(0x99FFAA00),
                    BlendMode.screen,
                  ),
                  child: const _RichGradientTile(),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // --- How it plugs in ---
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: skin.primary.withAlpha(15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            '💡  ColorFiltered simply wraps a child:\n\n'
            '    ColorFiltered(\n'
            '      colorFilter: ColorFilter.mode(\n'
            '        Colors.blue, BlendMode.modulate),\n'
            '      child: myWidget,\n'
            '    )\n\n'
            'The filter applies to the full sub-tree — every pixel the child '
            'paints, including images, text, and decorations.',
            style: TextStyle(
              fontSize: 13,
              height: 1.6,
              color: skin.ink,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  2.  BLEND MODE GALLERY
// ═══════════════════════════════════════════════════════════════════════════

class _BlendEntry {
  const _BlendEntry(this.mode, this.info);
  final BlendMode mode;
  final String info;
}

const _blendEntries = <_BlendEntry>[
  _BlendEntry(BlendMode.modulate, 'Multiplies source & dest channels'),
  _BlendEntry(BlendMode.srcATop, 'Source drawn atop destination'),
  _BlendEntry(BlendMode.multiply, 'Darkens by multiplying'),
  _BlendEntry(BlendMode.screen, 'Lightens by inverting multiply'),
  _BlendEntry(BlendMode.overlay, 'Combines multiply & screen'),
  _BlendEntry(BlendMode.colorBurn, 'Darkens dest toward source'),
  _BlendEntry(BlendMode.colorDodge, 'Lightens dest toward source'),
  _BlendEntry(BlendMode.softLight, 'Gentle light mix'),
  _BlendEntry(BlendMode.hue, 'Applies source hue'),
  _BlendEntry(BlendMode.saturation, 'Applies source saturation'),
  _BlendEntry(BlendMode.color, 'Applies source hue + saturation'),
  _BlendEntry(BlendMode.luminosity, 'Applies source luminosity'),
];

class _BlendModeGallery extends StatefulWidget {
  const _BlendModeGallery({required this.skin, required this.onEvent});
  final _Skin skin;
  final void Function(String) onEvent;

  @override
  State<_BlendModeGallery> createState() => _BlendModeGalleryState();
}

class _BlendModeGalleryState extends State<_BlendModeGallery> {
  Color _tintColor = const Color(0xFF3388DD);
  int _selectedIdx = -1;

  static const _tintOptions = <Color>[
    Color(0xFF3388DD),
    Color(0xFFDD4433),
    Color(0xFF33AA55),
    Color(0xFFAA33CC),
    Color(0xFFFFAA00),
    Color(0xFF222222),
  ];

  @override
  void initState() {
    super.initState();
    widget.onEvent('Blend gallery opened');
  }

  @override
  Widget build(BuildContext context) {
    final skin = widget.skin;
    return Column(
      children: [
        // Tint colour picker strip
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: skin.panel,
          child: Row(
            children: [
              Text(
                'Tint colour:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: skin.ink,
                ),
              ),
              const SizedBox(width: 12),
              ..._tintOptions.map(
                (c) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() => _tintColor = c);
                      widget.onEvent(
                        'Tint → #${c.toARGB32().toRadixString(16).padLeft(8, '0')}',
                      );
                    },
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: c,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color:
                              c == _tintColor
                                  ? skin.primary
                                  : skin.muted.withAlpha(60),
                          width: c == _tintColor ? 3 : 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),

        // Grid of blend-mode cards
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(14),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 0.82,
            ),
            itemCount: _blendEntries.length,
            itemBuilder: (_, i) {
              final e = _blendEntries[i];
              final selected = i == _selectedIdx;
              return GestureDetector(
                onTap: () {
                  setState(() => _selectedIdx = i == _selectedIdx ? -1 : i);
                  widget.onEvent('Blend tap → ${e.mode.name}');
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: skin.panel,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selected ? skin.primary : skin.muted.withAlpha(50),
                      width: selected ? 2.5 : 1,
                    ),
                    boxShadow:
                        selected
                            ? [
                              BoxShadow(
                                color: skin.primary.withAlpha(40),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ]
                            : [],
                  ),
                  child: Column(
                    children: [
                      // Filtered preview tile
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(11),
                          ),
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              _tintColor,
                              e.mode,
                            ),
                            child: const _RichGradientTile(),
                          ),
                        ),
                      ),
                      // Label
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: skin.panel,
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(11),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.mode.name,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: skin.ink,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              e.info,
                              style: TextStyle(
                                fontSize: 10.5,
                                color: skin.muted,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // Detail strip for selected blend mode
        if (_selectedIdx >= 0)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            color: skin.primary.withAlpha(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BlendMode.${_blendEntries[_selectedIdx].mode.name}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: skin.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _blendEntries[_selectedIdx].info,
                  style: TextStyle(fontSize: 12.5, color: skin.ink),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('Before:', style: TextStyle(fontSize: 11)),
                    const SizedBox(width: 6),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: const _RichGradientTile(),
                    ),
                    const SizedBox(width: 16),
                    const Text('After:', style: TextStyle(fontSize: 11)),
                    const SizedBox(width: 6),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          _tintColor,
                          _blendEntries[_selectedIdx].mode,
                        ),
                        child: const _RichGradientTile(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  3.  MATRIX WORKSHOP
// ═══════════════════════════════════════════════════════════════════════════

class _MatrixPreset {
  const _MatrixPreset(this.name, this.matrix);
  final String name;
  final List<double> matrix;
}

final _matrixPresets = <_MatrixPreset>[
  _MatrixPreset('Identity', _identityMatrix),
  _MatrixPreset('Greyscale', _greyscaleMatrix),
  _MatrixPreset('Sepia', _sepiaMatrix),
  _MatrixPreset('Invert', _invertMatrix),
  _MatrixPreset('High Contrast', _highContrastMatrix),
  _MatrixPreset('Warm Shift', _warmMatrix),
  _MatrixPreset('Cool Shift', _coolMatrix),
  _MatrixPreset('Vintage', _vintageMatrix),
];

class _MatrixWorkshop extends StatefulWidget {
  const _MatrixWorkshop({required this.skin, required this.onEvent});
  final _Skin skin;
  final void Function(String) onEvent;

  @override
  State<_MatrixWorkshop> createState() => _MatrixWorkshopState();
}

class _MatrixWorkshopState extends State<_MatrixWorkshop> {
  late List<double> _matrix;
  int _presetIdx = 0;

  @override
  void initState() {
    super.initState();
    _matrix = List<double>.from(_identityMatrix);
    widget.onEvent('Matrix workshop opened');
  }

  void _applyPreset(int idx) {
    setState(() {
      _presetIdx = idx;
      _matrix = List<double>.from(_matrixPresets[idx].matrix);
    });
    widget.onEvent('Matrix preset → ${_matrixPresets[idx].name}');
  }

  void _nudgeCell(int i, double delta) {
    setState(() {
      _matrix[i] = (_matrix[i] + delta).clamp(-2.0, 2.0);
      // Round to avoid float noise in display
      _matrix[i] = ((_matrix[i] * 100).roundToDouble()) / 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    final skin = widget.skin;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Introduction
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: skin.panel,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: skin.muted.withAlpha(40)),
          ),
          child: Text(
            'A colour matrix is a 5×4 list of doubles.  Rows correspond to '
            'output R, G, B, A.  Columns are multiplied against '
            '[srcR, srcG, srcB, srcA, 1.0] so the fifth column is an additive '
            'offset.\n\nTap a cell to nudge ±0.1.  Use presets for curated '
            'effects.',
            style: TextStyle(fontSize: 13, color: skin.ink, height: 1.5),
          ),
        ),
        const SizedBox(height: 14),

        // Preset bar
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(_matrixPresets.length, (i) {
            final selected = i == _presetIdx;
            return GestureDetector(
              onTap: () => _applyPreset(i),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: selected ? skin.primary : skin.panel,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: selected ? skin.primary : skin.muted.withAlpha(60),
                  ),
                ),
                child: Text(
                  _matrixPresets[i].name,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: selected ? skin.panel : skin.ink,
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 18),

        // Matrix grid (4 rows × 5 cols)
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: skin.panel,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: skin.muted.withAlpha(40)),
          ),
          child: Column(
            children: [
              // Header row
              Row(
                children: [
                  _matrixHeaderCell('', skin),
                  _matrixHeaderCell('srcR', skin),
                  _matrixHeaderCell('srcG', skin),
                  _matrixHeaderCell('srcB', skin),
                  _matrixHeaderCell('srcA', skin),
                  _matrixHeaderCell('+ofs', skin),
                ],
              ),
              const Divider(height: 8),
              for (int row = 0; row < 4; row++)
                _buildMatrixRow(row, skin),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Large preview
        _sectionHeader(skin, 'Live preview'),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: Row(
            children: [
              Expanded(
                child: _LabelledTile(
                  label: 'Original',
                  skin: skin,
                  child: const _RichGradientTile(),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _LabelledTile(
                  label: _matrixPresets[_presetIdx].name,
                  skin: skin,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.matrix(_matrix),
                    child: const _RichGradientTile(),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Also show with icons / text
        SizedBox(
          height: 120,
          child: Row(
            children: [
              Expanded(
                child: _LabelledTile(
                  label: 'Icons original',
                  skin: skin,
                  child: const _IconStrip(),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _LabelledTile(
                  label: 'Icons filtered',
                  skin: skin,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.matrix(_matrix),
                    child: const _IconStrip(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMatrixRow(int row, _Skin skin) {
    const rowLabels = ['outR', 'outG', 'outB', 'outA'];
    const rowColors = [
      Color(0xFFE04040),
      Color(0xFF30A830),
      Color(0xFF3080E0),
      Color(0xFF808080),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 42,
            child: Text(
              rowLabels[row],
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: rowColors[row],
              ),
            ),
          ),
          for (int col = 0; col < 5; col++)
            _matrixCell(row * 5 + col, skin),
        ],
      ),
    );
  }

  Widget _matrixCell(int idx, _Skin skin) {
    final v = _matrix[idx];
    return Expanded(
      child: GestureDetector(
        onTap: () => _nudgeCell(idx, 0.1),
        onLongPress: () => _nudgeCell(idx, -0.1),
        child: Container(
          margin: const EdgeInsets.all(2),
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color:
                v.abs() > 0.01
                    ? skin.primary.withAlpha(((v.abs() * 40).clamp(5, 60)).toInt())
                    : skin.paper,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: skin.muted.withAlpha(40)),
          ),
          alignment: Alignment.center,
          child: Text(
            v.toStringAsFixed(2),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: skin.ink,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ),
    );
  }

  Widget _matrixHeaderCell(String text, _Skin skin) {
    if (text.isEmpty) {
      return const SizedBox(width: 42);
    }
    return Expanded(
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: skin.muted,
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  4.  ANIMATED FILTERS
// ═══════════════════════════════════════════════════════════════════════════

class _AnimatedFiltersSection extends StatelessWidget {
  const _AnimatedFiltersSection({required this.skin, required this.onEvent});
  final _Skin skin;
  final void Function(String) onEvent;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: skin.panel,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: skin.muted.withAlpha(40)),
          ),
          child: Text(
            'ColorFilter values can be computed per-frame inside an '
            'AnimatedBuilder to produce smooth filter transitions.  Below '
            'are three animated demos: a hue rotator, a tint pulser, and a '
            'sunrise warm-shift.',
            style: TextStyle(fontSize: 13, color: skin.ink, height: 1.5),
          ),
        ),
        const SizedBox(height: 18),

        _sectionHeader(skin, 'Hue Rotation'),
        const SizedBox(height: 10),
        SizedBox(
          height: 180,
          child: _HueRotatorTile(skin: skin, onEvent: onEvent),
        ),

        const SizedBox(height: 22),
        _sectionHeader(skin, 'Tint Pulse'),
        const SizedBox(height: 10),
        SizedBox(
          height: 180,
          child: _TintPulseTile(skin: skin, onEvent: onEvent),
        ),

        const SizedBox(height: 22),
        _sectionHeader(skin, 'Sunrise Warm-shift'),
        const SizedBox(height: 10),
        SizedBox(
          height: 180,
          child: _SunriseTile(skin: skin, onEvent: onEvent),
        ),

        const SizedBox(height: 22),
        _sectionHeader(skin, 'Saturation Fade'),
        const SizedBox(height: 10),
        SizedBox(
          height: 180,
          child: _SaturationFadeTile(skin: skin, onEvent: onEvent),
        ),
      ],
    );
  }
}

// ---- Hue rotator ----

class _HueRotatorTile extends StatefulWidget {
  const _HueRotatorTile({required this.skin, required this.onEvent});
  final _Skin skin;
  final void Function(String) onEvent;

  @override
  State<_HueRotatorTile> createState() => _HueRotatorTileState();
}

class _HueRotatorTileState extends State<_HueRotatorTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
    widget.onEvent('Hue rotator started');
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) {
        final angle = _ctrl.value * 2 * math.pi;
        final cosA = math.cos(angle);
        final sinA = math.sin(angle);
        // Rotation around the luminance vector (approx. 0.213, 0.715, 0.072)
        final matrix = <double>[
          0.213 + cosA * 0.787 - sinA * 0.213,
          0.715 - cosA * 0.715 - sinA * 0.715,
          0.072 - cosA * 0.072 + sinA * 0.928,
          0, 0,
          0.213 - cosA * 0.213 + sinA * 0.143,
          0.715 + cosA * 0.285 + sinA * 0.140,
          0.072 - cosA * 0.072 - sinA * 0.283,
          0, 0,
          0.213 - cosA * 0.213 - sinA * 0.787,
          0.715 - cosA * 0.715 + sinA * 0.715,
          0.072 + cosA * 0.928 + sinA * 0.072,
          0, 0,
          0, 0, 0, 1, 0,
        ];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: widget.skin.muted.withAlpha(50)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ColorFiltered(
                  colorFilter: ColorFilter.matrix(matrix),
                  child: child!,
                ),
                Positioned(
                  left: 10,
                  bottom: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Hue: ${(angle * 180 / math.pi).toStringAsFixed(0)}°',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: const _RichGradientTile(),
    );
  }
}

// ---- Tint pulse ----

class _TintPulseTile extends StatefulWidget {
  const _TintPulseTile({required this.skin, required this.onEvent});
  final _Skin skin;
  final void Function(String) onEvent;

  @override
  State<_TintPulseTile> createState() => _TintPulseTileState();
}

class _TintPulseTileState extends State<_TintPulseTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    widget.onEvent('Tint pulse started');
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) {
        final t = _ctrl.value;
        // Interpolate from identity toward a deep-blue tint
        final r = 1.0 - t * 0.6;
        final g = 1.0 - t * 0.4;
        final b = 1.0 + t * 0.0; // keep blue high
        final matrix = <double>[
          r, 0, 0, 0, 0,
          0, g, 0, 0, 0,
          0, 0, b, 0, t * 30,
          0, 0, 0, 1, 0,
        ];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: widget.skin.muted.withAlpha(50)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ColorFiltered(
                  colorFilter: ColorFilter.matrix(matrix),
                  child: child!,
                ),
                Positioned(
                  left: 10,
                  bottom: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Blue tint: ${(t * 100).toStringAsFixed(0)}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: const _RichGradientTile(),
    );
  }
}

// ---- Sunrise warm-shift ----

class _SunriseTile extends StatefulWidget {
  const _SunriseTile({required this.skin, required this.onEvent});
  final _Skin skin;
  final void Function(String) onEvent;

  @override
  State<_SunriseTile> createState() => _SunriseTileState();
}

class _SunriseTileState extends State<_SunriseTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
    widget.onEvent('Sunrise tile started');
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  List<double> _lerpMatrix(List<double> a, List<double> b, double t) {
    return List.generate(20, (i) => a[i] + (b[i] - a[i]) * t);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) {
        final matrix = _lerpMatrix(_coolMatrix, _warmMatrix, _ctrl.value);
        final label =
            _ctrl.value < 0.5
                ? 'Dawn (cool → warm)'
                : 'Golden hour';
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: widget.skin.muted.withAlpha(50)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ColorFiltered(
                  colorFilter: ColorFilter.matrix(matrix),
                  child: child!,
                ),
                Positioned(
                  left: 10,
                  bottom: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: const _RichGradientTile(),
    );
  }
}

// ---- Saturation fade ----

class _SaturationFadeTile extends StatefulWidget {
  const _SaturationFadeTile({required this.skin, required this.onEvent});
  final _Skin skin;
  final void Function(String) onEvent;

  @override
  State<_SaturationFadeTile> createState() => _SaturationFadeTileState();
}

class _SaturationFadeTileState extends State<_SaturationFadeTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    widget.onEvent('Saturation fade started');
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) {
        // Interpolate from identity to greyscale
        final t = _ctrl.value;
        final s = 1.0 - t; // saturation goes from 1→0
        final matrix = <double>[
          0.213 + 0.787 * s, 0.715 - 0.715 * s, 0.072 - 0.072 * s, 0, 0,
          0.213 - 0.213 * s, 0.715 + 0.285 * s, 0.072 - 0.072 * s, 0, 0,
          0.213 - 0.213 * s, 0.715 - 0.715 * s, 0.072 + 0.928 * s, 0, 0,
          0, 0, 0, 1, 0,
        ];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: widget.skin.muted.withAlpha(50)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ColorFiltered(
                  colorFilter: ColorFilter.matrix(matrix),
                  child: child!,
                ),
                Positioned(
                  left: 10,
                  bottom: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Saturation: ${(s * 100).toStringAsFixed(0)}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: const _RichGradientTile(),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  5.  PRACTICAL USE CASES
// ═══════════════════════════════════════════════════════════════════════════

class _PracticalUseCases extends StatefulWidget {
  const _PracticalUseCases({required this.skin, required this.onEvent});
  final _Skin skin;
  final void Function(String) onEvent;

  @override
  State<_PracticalUseCases> createState() => _PracticalUseCasesState();
}

class _PracticalUseCasesState extends State<_PracticalUseCases> {
  bool _buttonsEnabled = true;
  bool _darkModeHack = false;
  int _cbSimIdx = 0; // colour-blind simulation index
  int _photoEffect = 0;

  static const _cbSimNames = [
    'Normal',
    'Protanopia',
    'Deuteranopia',
    'Tritanopia',
  ];

  static final _cbSimMatrices = [
    _identityMatrix,
    _protanopiaMatrix,
    _deuteranopiaMatrix,
    _tritanopiaMatrix,
  ];

  static const _photoNames = [
    'Original',
    'Vintage',
    'Cool Tone',
    'Dramatic',
    'Sepia',
  ];

  static final _photoMatrices = [
    _identityMatrix,
    _vintageMatrix,
    _coolMatrix,
    _highContrastMatrix,
    _sepiaMatrix,
  ];

  @override
  void initState() {
    super.initState();
    widget.onEvent('Practical use-cases opened');
  }

  @override
  Widget build(BuildContext context) {
    final skin = widget.skin;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // --- (a) Disabled button row ---
        _sectionHeader(skin, 'A. Disabled state via greyscale'),
        const SizedBox(height: 6),
        Text(
          'A common pattern: wrap a widget in ColorFiltered with a greyscale '
          'matrix to visually indicate a disabled state, rather than '
          'rebuilding with different colours.',
          style: TextStyle(fontSize: 12.5, color: skin.ink, height: 1.5),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              'Enabled:',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: skin.ink,
              ),
            ),
            const SizedBox(width: 8),
            Switch(
              value: _buttonsEnabled,
              onChanged: (v) {
                setState(() => _buttonsEnabled = v);
                widget.onEvent(
                  'Buttons ${v ? 'enabled' : 'disabled'}',
                );
              },
              activeThumbColor: skin.primary,
            ),
          ],
        ),
        const SizedBox(height: 8),
        _ConditionalGreyscale(
          enabled: _buttonsEnabled,
          child: Row(
            children: [
              _DemoButton(label: 'Save', icon: Icons.save, skin: skin),
              const SizedBox(width: 10),
              _DemoButton(label: 'Export', icon: Icons.upload, skin: skin),
              const SizedBox(width: 10),
              _DemoButton(label: 'Share', icon: Icons.share, skin: skin),
            ],
          ),
        ),

        const SizedBox(height: 28),

        // --- (b) Dark-mode inversion hack ---
        _sectionHeader(skin, 'B. Dark-mode inversion hack'),
        const SizedBox(height: 6),
        Text(
          'Apply an invert matrix plus a hue-rotate (to correct the '
          'hue shift from inversion) to approximate a dark mode on any '
          'light-themed content.',
          style: TextStyle(fontSize: 12.5, color: skin.ink, height: 1.5),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              'Dark hack:',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: skin.ink,
              ),
            ),
            const SizedBox(width: 8),
            Switch(
              value: _darkModeHack,
              onChanged: (v) {
                setState(() => _darkModeHack = v);
                widget.onEvent('Dark hack ${v ? 'ON' : 'OFF'}');
              },
              activeThumbColor: skin.primary,
            ),
          ],
        ),
        const SizedBox(height: 8),
        ColorFiltered(
          colorFilter: ColorFilter.matrix(
            _darkModeHack ? _darkModeInvertMatrix : _identityMatrix,
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: skin.muted.withAlpha(50)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.article, color: skin.primary, size: 22),
                    const SizedBox(width: 8),
                    Text(
                      'Sample Light Card',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: skin.ink,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'This card is always built with light colours.  The '
                  'ColorFiltered invert matrix flips it to appear dark '
                  'without rebuilding any widgets.',
                  style: TextStyle(
                    fontSize: 13,
                    color: skin.ink,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF4488CC),
                        Color(0xFF44CC88),
                        Color(0xFFDDAA33),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 28),

        // --- (c) Colour-blind simulation ---
        _sectionHeader(skin, 'C. Colour-blind simulation'),
        const SizedBox(height: 6),
        Text(
          'Approximate how a colour-blind user sees your UI by applying '
          'known simulation matrices for common deficiencies.',
          style: TextStyle(fontSize: 12.5, color: skin.ink, height: 1.5),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(_cbSimNames.length, (i) {
            final selected = i == _cbSimIdx;
            return GestureDetector(
              onTap: () {
                setState(() => _cbSimIdx = i);
                widget.onEvent('CB sim → ${_cbSimNames[i]}');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: selected ? skin.secondary : skin.panel,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color:
                        selected ? skin.secondary : skin.muted.withAlpha(60),
                  ),
                ),
                child: Text(
                  _cbSimNames[i],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: selected ? Colors.white : skin.ink,
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 12),
        ColorFiltered(
          colorFilter: ColorFilter.matrix(_cbSimMatrices[_cbSimIdx]),
          child: _buildColourGrid(skin),
        ),

        const SizedBox(height: 28),

        // --- (d) Photo effect strip ---
        _sectionHeader(skin, 'D. Photo effects'),
        const SizedBox(height: 6),
        Text(
          'Apply preset colour matrices to the same source tile — common '
          'in photo/video editing apps.',
          style: TextStyle(fontSize: 12.5, color: skin.ink, height: 1.5),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 140,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _photoNames.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (_, i) {
              final selected = i == _photoEffect;
              return GestureDetector(
                onTap: () {
                  setState(() => _photoEffect = i);
                  widget.onEvent('Photo effect → ${_photoNames[i]}');
                },
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color:
                              selected
                                  ? skin.primary
                                  : skin.muted.withAlpha(50),
                          width: selected ? 3 : 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(9),
                        child: ColorFiltered(
                          colorFilter: ColorFilter.matrix(_photoMatrices[i]),
                          child: const _RichGradientTile(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _photoNames[i],
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight:
                            selected ? FontWeight.w700 : FontWeight.normal,
                        color: selected ? skin.primary : skin.muted,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        // Large preview of the selected effect
        SizedBox(
          height: 180,
          child: Row(
            children: [
              Expanded(
                child: _LabelledTile(
                  label: 'Original',
                  skin: skin,
                  child: const _RichGradientTile(),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _LabelledTile(
                  label: _photoNames[_photoEffect],
                  skin: skin,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.matrix(
                      _photoMatrices[_photoEffect],
                    ),
                    child: const _RichGradientTile(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildColourGrid(_Skin skin) {
    const colours = [
      Color(0xFFE53935), // red
      Color(0xFFFF9800), // orange
      Color(0xFFFFEB3B), // yellow
      Color(0xFF4CAF50), // green
      Color(0xFF2196F3), // blue
      Color(0xFF9C27B0), // purple
      Color(0xFF795548), // brown
      Color(0xFF607D8B), // teal-grey
    ];
    const icons = [
      Icons.favorite,
      Icons.star,
      Icons.wb_sunny,
      Icons.park,
      Icons.water_drop,
      Icons.auto_awesome,
      Icons.terrain,
      Icons.waves,
    ];
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(colours.length, (i) {
        return Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: colours[i],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Icon(icons[i], color: Colors.white, size: 30),
          ),
        );
      }),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  6.  VERIFICATION COMPENDIUM
// ═══════════════════════════════════════════════════════════════════════════

class _Compendium extends StatelessWidget {
  const _Compendium({required this.skin, required this.log});
  final _Skin skin;
  final List<_DemoEvent> log;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Summary panel
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: skin.panel,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: skin.muted.withAlpha(40)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.check_circle, color: skin.secondary, size: 26),
                  const SizedBox(width: 10),
                  Text(
                    'Verification Summary',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: skin.ink,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _summaryRow(skin, 'Sections visited', '6 available'),
              _summaryRow(skin, 'BlendMode cards', '12 blend modes'),
              _summaryRow(skin, 'Matrix presets', '8 curated presets'),
              _summaryRow(skin, 'Animations', '4 (hue, tint, sunrise, sat)'),
              _summaryRow(skin, 'Practical demos', '4 (disable, dark, CB, photo)'),
              _summaryRow(
                skin,
                'Colour-blind sims',
                'Normal, Protanopia, Deuteranopia, Tritanopia',
              ),
              _summaryRow(skin, 'Photo effects', '5 presets'),
              _summaryRow(skin, 'Event log entries', '${log.length}'),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // Features checklist
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: skin.secondary.withAlpha(10),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: skin.secondary.withAlpha(40)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Feature Checklist',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: skin.secondary,
                ),
              ),
              const SizedBox(height: 10),
              _checkItem(skin, 'ColorFilter.mode with 12 BlendModes'),
              _checkItem(skin, 'ColorFilter.matrix with 8 presets'),
              _checkItem(skin, 'Interactive matrix cell editing'),
              _checkItem(skin, 'Animated hue rotation via matrix'),
              _checkItem(skin, 'Animated tint pulse (blue shift)'),
              _checkItem(skin, 'Animated sunrise warm↔cool transition'),
              _checkItem(skin, 'Animated saturation fade to greyscale'),
              _checkItem(skin, 'Greyscale-disabled pattern'),
              _checkItem(skin, 'Dark-mode inversion hack'),
              _checkItem(skin, 'Colour-blind simulation matrices'),
              _checkItem(skin, 'Photo-effect preset strip'),
              _checkItem(skin, 'Before/after comparison pairs'),
              _checkItem(skin, 'Skin cycling across 3 palettes'),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // ColorFiltered API notes
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: skin.tertiary.withAlpha(10),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: skin.tertiary.withAlpha(40)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'API Notes',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: skin.tertiary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '• ColorFiltered is a SingleChildRenderObjectWidget.\n'
                '• It creates a RenderObject that applies a ColorFilter to its '
                'paint layer.\n'
                '• The colorFilter parameter is required and non-null.\n'
                '• ColorFilter.mode(color, blendMode) blends the given color '
                'with each source pixel using the specified BlendMode.\n'
                '• ColorFilter.matrix(list) applies a 5×4 (20-element) '
                'transformation matrix to [R, G, B, A, 1].\n'
                '• ColorFilter.linearToSrgbGamma() and srgbToLinearGamma() '
                'convert between linear and sRGB colour spaces.\n'
                '• Unlike BackdropFilter, ColorFiltered only affects its own '
                'child — not widgets behind it.\n'
                '• Performance: applying a colour filter adds a GPU pass, so '
                'avoid nesting many filters in a single frame.\n'
                '• For animated filters, rebuild with a new ColorFilter on '
                'each frame via AnimatedBuilder — do not try to mutate the '
                'filter in place.',
                style: TextStyle(
                  fontSize: 12.5,
                  height: 1.6,
                  color: skin.ink,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // Event log timeline
        _sectionHeader(skin, 'Event Timeline'),
        const SizedBox(height: 10),
        if (log.isEmpty)
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'No events recorded yet.',
              style: TextStyle(color: skin.muted),
            ),
          )
        else
          Container(
            constraints: const BoxConstraints(maxHeight: 300),
            decoration: BoxDecoration(
              color: skin.panel,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: skin.muted.withAlpha(40)),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(12),
              itemCount: log.length,
              separatorBuilder: (_, _) => Divider(
                color: skin.muted.withAlpha(25),
                height: 1,
              ),
              itemBuilder: (_, i) {
                final e = log[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 60,
                        child: Text(
                          e.at,
                          style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'monospace',
                            color: skin.muted,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                          color: skin.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          e.label,
                          style: TextStyle(
                            fontSize: 12,
                            color: skin.ink,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

        const SizedBox(height: 20),

        // All-clear banner
        Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [skin.secondary, skin.primary],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.verified, color: Colors.white, size: 24),
              const SizedBox(width: 10),
              const Text(
                'ColorFiltered — All Clear',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _summaryRow(_Skin skin, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(
            width: 160,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12.5,
                color: skin.muted,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 12.5, color: skin.ink),
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkItem(_Skin skin, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check, color: skin.secondary, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 12.5, color: skin.ink),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  Helper widgets
// ═══════════════════════════════════════════════════════════════════════════

Widget _sectionHeader(_Skin skin, String title) {
  return Row(
    children: [
      Container(
        width: 4,
        height: 18,
        decoration: BoxDecoration(
          color: skin.primary,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      const SizedBox(width: 8),
      Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: skin.ink,
        ),
      ),
    ],
  );
}

class _LabelledTile extends StatelessWidget {
  const _LabelledTile({
    required this.label,
    required this.skin,
    required this.child,
  });
  final String label;
  final _Skin skin;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: skin.muted.withAlpha(50)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: child,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: skin.muted,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

/// A richly coloured gradient tile used as a visual source for filter demos.
class _RichGradientTile extends StatelessWidget {
  const _RichGradientTile();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: const _GradientMosaicPainter(),
      child: const SizedBox.expand(),
    );
  }
}

class _GradientMosaicPainter extends CustomPainter {
  const _GradientMosaicPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Background diagonal gradient
    final bgPaint =
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: const [
              Color(0xFFFF6B6B),
              Color(0xFFFECA57),
              Color(0xFF48DBFB),
              Color(0xFFFF9FF3),
            ],
          ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), bgPaint);

    // Overlay circles
    final rng = math.Random(42);
    for (int i = 0; i < 12; i++) {
      final cx = rng.nextDouble() * w;
      final cy = rng.nextDouble() * h;
      final r = 8.0 + rng.nextDouble() * 25;
      final c = Color.fromARGB(
        100 + rng.nextInt(100),
        rng.nextInt(256),
        rng.nextInt(256),
        rng.nextInt(256),
      );
      canvas.drawCircle(Offset(cx, cy), r, Paint()..color = c);
    }

    // Diagonal stripes for visual richness
    final stripePaint =
        Paint()
          ..color = const Color(0x30FFFFFF)
          ..strokeWidth = 3;
    for (double d = -h; d < w + h; d += 18) {
      canvas.drawLine(Offset(d, 0), Offset(d + h, h), stripePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// A strip of colourful icons — to test colour filters on icon widgets.
class _IconStrip extends StatelessWidget {
  const _IconStrip();

  @override
  Widget build(BuildContext context) {
    const icons = [
      (Icons.favorite, Color(0xFFE53935)),
      (Icons.star, Color(0xFFFFB300)),
      (Icons.park, Color(0xFF43A047)),
      (Icons.water_drop, Color(0xFF1E88E5)),
      (Icons.auto_awesome, Color(0xFF8E24AA)),
    ];
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:
            icons
                .map(
                  (e) => Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: e.$2.withAlpha(30),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(e.$1, color: e.$2, size: 26),
                  ),
                )
                .toList(),
      ),
    );
  }
}

class _DemoButton extends StatelessWidget {
  const _DemoButton({
    required this.label,
    required this.icon,
    required this.skin,
  });
  final String label;
  final IconData icon;
  final _Skin skin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: skin.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Wraps child in a greyscale ColorFiltered when not enabled.
class _ConditionalGreyscale extends StatelessWidget {
  const _ConditionalGreyscale({
    required this.enabled,
    required this.child,
  });
  final bool enabled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (enabled) return child;
    return ColorFiltered(
      colorFilter: ColorFilter.matrix(_greyscaleMatrix),
      child: IgnorePointer(child: child),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  Pre-baked colour matrices (5×4 = 20 elements each)
// ═══════════════════════════════════════════════════════════════════════════

final List<double> _identityMatrix = <double>[
  1, 0, 0, 0, 0,
  0, 1, 0, 0, 0,
  0, 0, 1, 0, 0,
  0, 0, 0, 1, 0,
];

final List<double> _greyscaleMatrix = <double>[
  0.2126, 0.7152, 0.0722, 0, 0,
  0.2126, 0.7152, 0.0722, 0, 0,
  0.2126, 0.7152, 0.0722, 0, 0,
  0, 0, 0, 1, 0,
];

final List<double> _sepiaMatrix = <double>[
  0.393, 0.769, 0.189, 0, 0,
  0.349, 0.686, 0.168, 0, 0,
  0.272, 0.534, 0.131, 0, 0,
  0, 0, 0, 1, 0,
];

final List<double> _invertMatrix = <double>[
  -1, 0, 0, 0, 255,
  0, -1, 0, 0, 255,
  0, 0, -1, 0, 255,
  0, 0, 0, 1, 0,
];

final List<double> _highContrastMatrix = <double>[
  1.5, 0, 0, 0, -40,
  0, 1.5, 0, 0, -40,
  0, 0, 1.5, 0, -40,
  0, 0, 0, 1, 0,
];

final List<double> _warmMatrix = <double>[
  1.2, 0, 0, 0, 10,
  0, 1.0, 0, 0, 0,
  0, 0, 0.8, 0, -10,
  0, 0, 0, 1, 0,
];

final List<double> _coolMatrix = <double>[
  0.85, 0, 0, 0, -5,
  0, 1.0, 0, 0, 0,
  0, 0, 1.2, 0, 15,
  0, 0, 0, 1, 0,
];

final List<double> _vintageMatrix = <double>[
  0.62, 0.32, 0.06, 0, 15,
  0.22, 0.67, 0.11, 0, 10,
  0.18, 0.28, 0.54, 0, 20,
  0, 0, 0, 1, 0,
];

/// Invert + approximate hue-rotate 180° for a "dark mode" hack.
final List<double> _darkModeInvertMatrix = <double>[
  -0.574, -0.926, -0.500, 0, 255,
  -0.500, -0.574, -0.926, 0, 255,
  -0.926, -0.500, -0.574, 0, 255,
  0, 0, 0, 1, 0,
];

// Colour-blind simulation matrices (approximate)
// Source: https://www.inf.ufrgs.br/~oliveira/pubs_files/CVD_Simulation/

final List<double> _protanopiaMatrix = <double>[
  0.567, 0.433, 0.000, 0, 0,
  0.558, 0.442, 0.000, 0, 0,
  0.000, 0.242, 0.758, 0, 0,
  0, 0, 0, 1, 0,
];

final List<double> _deuteranopiaMatrix = <double>[
  0.625, 0.375, 0.000, 0, 0,
  0.700, 0.300, 0.000, 0, 0,
  0.000, 0.300, 0.700, 0, 0,
  0, 0, 0, 1, 0,
];

final List<double> _tritanopiaMatrix = <double>[
  0.950, 0.050, 0.000, 0, 0,
  0.000, 0.433, 0.567, 0, 0,
  0.000, 0.475, 0.525, 0, 0,
  0, 0, 0, 1, 0,
];
