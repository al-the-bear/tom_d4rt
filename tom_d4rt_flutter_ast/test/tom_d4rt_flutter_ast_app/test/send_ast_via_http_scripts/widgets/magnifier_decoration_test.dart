import 'package:flutter/material.dart';

const _bg = Color(0xFFF2F6FA);
const _ink = Color(0xFF173245);
const _blue = Color(0xFF2D628A);
const _green = Color(0xFF2B7F66);
const _amber = Color(0xFFAE8442);
const _rose = Color(0xFF9E5D71);
const _violet = Color(0xFF665CB0);

dynamic build(BuildContext context) {
  return const _MagnifierDecorationDeepDemoApp();
}

class _MagnifierDecorationDeepDemoApp extends StatelessWidget {
  const _MagnifierDecorationDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _blue),
        scaffoldBackgroundColor: _bg,
      ),
      home: const _MagnifierDecorationDeepDemoPage(),
    );
  }
}

class _MagnifierDecorationDeepDemoPage extends StatefulWidget {
  const _MagnifierDecorationDeepDemoPage();

  @override
  State<_MagnifierDecorationDeepDemoPage> createState() => _MagnifierDecorationDeepDemoPageState();
}

class _MagnifierDecorationDeepDemoPageState extends State<_MagnifierDecorationDeepDemoPage> {
  bool _compact = false;
  bool _guide = true;
  bool _notes = true;
  bool _rtl = false;
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _ink,
          foregroundColor: Colors.white,
          toolbarHeight: 92,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('MagnifierDecoration Deep Demo'),
              Text(
                'lens style design | shape and shadow tuning | focal geometry | practical magnifier compositions',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 12, fontWeight: FontWeight.w500),
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
                guide: _guide,
                notes: _notes,
                rtl: _rtl,
                scale: _scale,
                onCompactChanged: (v) => setState(() => _compact = v),
                onGuideChanged: (v) => setState(() => _guide = v),
                onNotesChanged: (v) => setState(() => _notes = v),
                onRtlChanged: (v) => setState(() => _rtl = v),
                onScaleChanged: (v) => setState(() => _scale = v),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 1,
                tone: _blue,
                title: 'Decoration Fundamentals Studio',
                subtitle:
                    'Tune MagnifierDecoration opacity, shape, border style, and shadow stack on a live RawMagnifier stage.',
                child: _FundamentalsScene(compact: _compact, guide: _guide, notes: _notes, scale: _scale),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 2,
                tone: _green,
                title: 'Shape Gallery',
                subtitle:
                    'Visual compare of rounded, continuous, beveled, stadium, and circle shape borders with lens-specific recommendations.',
                child: _ShapeGalleryScene(compact: _compact, guide: _guide, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 3,
                tone: _amber,
                title: 'Shadow Dynamics Lab',
                subtitle:
                    'Build depth with layered BoxShadow presets and custom controls while tracking readability and emphasis.',
                child: _ShadowScene(compact: _compact, guide: _guide, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 4,
                tone: _rose,
                title: 'Focal Geometry Lab',
                subtitle:
                    'Combine decoration with magnificationScale, focalPointOffset, clip behavior, and lens size for precise output.',
                child: _GeometryScene(compact: _compact, guide: _guide, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 5,
                tone: _violet,
                title: 'Practical Lens Console',
                subtitle:
                    'Three application layouts show how MagnifierDecoration can align with product-specific visual language.',
                child: _PracticalScene(compact: _compact, guide: _guide, notes: _notes),
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

class _ControlDeck extends StatelessWidget {
  const _ControlDeck({
    required this.compact,
    required this.guide,
    required this.notes,
    required this.rtl,
    required this.scale,
    required this.onCompactChanged,
    required this.onGuideChanged,
    required this.onNotesChanged,
    required this.onRtlChanged,
    required this.onScaleChanged,
  });

  final bool compact;
  final bool guide;
  final bool notes;
  final bool rtl;
  final double scale;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onGuideChanged;
  final ValueChanged<bool> onNotesChanged;
  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<double> onScaleChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF173953), Color(0xFF275E80), Color(0xFF3B7B67), Color(0xFF625FB0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Magnifier Style Deck',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
          ),
          const SizedBox(height: 6),
          const Text(
            'MagnifierDecoration customizes the optical frame of RawMagnifier: '
            'shape language, opacity profile, and shadow treatment. '
            'Treat it as design system surface styling for lens components.',
            style: TextStyle(color: Color(0xFFDDEBF7), height: 1.35),
          ),
          const SizedBox(height: 10),
          // Use a Wrap so the four SwitchListTiles flow to a second row at
          // narrower viewport widths instead of squeezing each label tighter
          // than its intrinsic width and overflowing the inner Row inside
          // SwitchListTile (the longest label here is "Instruction notes").
          LayoutBuilder(
            builder: (context, constraints) {
              final tileWidth = (constraints.maxWidth / 2).clamp(220.0, 340.0);
              SizedBox tile(Widget child) => SizedBox(width: tileWidth, child: child);
              return Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  tile(SwitchListTile(
                    value: compact,
                    onChanged: onCompactChanged,
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Compact scenes', overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  )),
                  tile(SwitchListTile(
                    value: guide,
                    onChanged: onGuideChanged,
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Guide overlays', overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  )),
                  tile(SwitchListTile(
                    value: notes,
                    onChanged: onNotesChanged,
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Instruction notes', overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  )),
                  tile(SwitchListTile(
                    value: rtl,
                    onChanged: onRtlChanged,
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: const Text('RTL mode', overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  )),
                ],
              );
            },
          ),
          Text('Global scale: ${scale.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          Slider(
            value: scale,
            min: 0.8,
            max: 1.35,
            divisions: 11,
            onChanged: onScaleChanged,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }
}

class _SceneShell extends StatelessWidget {
  const _SceneShell({
    required this.index,
    required this.tone,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final int index;
  final Color tone;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 15, offset: const Offset(0, 7)),
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
                  backgroundColor: tone,
                  foregroundColor: Colors.white,
                  child: Text('$index', style: const TextStyle(fontWeight: FontWeight.w800)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800, fontSize: 19)),
                      const SizedBox(height: 4),
                      Text(subtitle, style: const TextStyle(color: Color(0xFF3A4E62), height: 1.34)),
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

enum _ShapeKind {
  rounded,
  continuous,
  beveled,
  stadium,
  circle,
}

enum _ShadowPreset {
  subtle,
  balanced,
  dramatic,
  neon,
}

enum _ClipMode {
  none,
  hardEdge,
  antiAlias,
  antiAliasWithSaveLayer,
}

class _FundamentalsScene extends StatefulWidget {
  const _FundamentalsScene({required this.compact, required this.guide, required this.notes, required this.scale});

  final bool compact;
  final bool guide;
  final bool notes;
  final double scale;

  @override
  State<_FundamentalsScene> createState() => _FundamentalsSceneState();
}

class _FundamentalsSceneState extends State<_FundamentalsScene> {
  _ShapeKind _shape = _ShapeKind.rounded;
  double _radius = 18;
  double _borderWidth = 2;
  double _opacity = 0.96;
  bool _shadowsOn = true;
  bool _overlay = true;
  int _revision = 1;

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 860.0 : 1020.0;
    final decoration = _buildDecoration(
      shape: _shape,
      radius: _radius,
      borderWidth: _borderWidth,
      opacity: _opacity,
      shadowPreset: _ShadowPreset.balanced,
      shadowsOn: _shadowsOn,
      tone: _blue,
    );

    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _PanelSurface(
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Decoration controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<_ShapeKind>(
                        initialValue: _shape,
                        decoration: const InputDecoration(labelText: 'Shape profile', border: OutlineInputBorder()),
                        items: _ShapeKind.values
                            .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                            .toList(),
                        onChanged: (v) => setState(() => _shape = v ?? _shape),
                      ),
                      const SizedBox(height: 8),
                      _SliderLine(label: 'Corner radius', value: _radius, min: 0, max: 42, onChanged: (v) => setState(() => _radius = v)),
                      _SliderLine(label: 'Border width', value: _borderWidth, min: 0, max: 6, onChanged: (v) => setState(() => _borderWidth = v)),
                      _SliderLine(label: 'Opacity', value: _opacity, min: 0.2, max: 1, onChanged: (v) => setState(() => _opacity = v)),
                      SwitchListTile(
                        value: _shadowsOn,
                        onChanged: (v) => setState(() => _shadowsOn = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Enable balanced shadows'),
                      ),
                      SwitchListTile(
                        value: _overlay,
                        onChanged: (v) => setState(() => _overlay = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show lens center overlay'),
                      ),
                      const SizedBox(height: 8),
                      FilledButton.tonal(
                        onPressed: () => setState(() => _revision += 1),
                        child: Text('Refresh stage ($_revision)'),
                      ),
                      const SizedBox(height: 8),
                      _DataTableCard(
                        rows: [
                          _DataRowItem('shape', _shape.name),
                          _DataRowItem('radius', _radius.toStringAsFixed(1)),
                          _DataRowItem('border width', _borderWidth.toStringAsFixed(1)),
                          _DataRowItem('opacity', _opacity.toStringAsFixed(2)),
                          _DataRowItem('shadows', _shadowsOn ? 'enabled' : 'disabled'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _blue,
                          lines: const [
                            'MagnifierDecoration controls lens frame style only; image content comes from RawMagnifier child and focal settings.',
                            'Use shape and border style to align magnifier UI with the product design language.',
                            'Opacity can soften or harden lens presence depending on interaction density.',
                          ],
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
            child: _PanelSurface(
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Transform.scale(
                  scale: widget.scale,
                  alignment: Alignment.topCenter,
                  child: _MagnifierStage(
                    tone: _blue,
                    decoration: decoration,
                    magnificationScale: 1.6,
                    size: const Size(240, 170),
                    focalPointOffset: const Offset(0, -8),
                    clip: Clip.antiAlias,
                    overlay: _overlay,
                    revision: _revision,
                    label: 'Fundamentals stage',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShapeGalleryScene extends StatefulWidget {
  const _ShapeGalleryScene({required this.compact, required this.guide, required this.notes});

  final bool compact;
  final bool guide;
  final bool notes;

  @override
  State<_ShapeGalleryScene> createState() => _ShapeGallerySceneState();
}

class _ShapeGallerySceneState extends State<_ShapeGalleryScene> {
  _ShapeKind _selected = _ShapeKind.rounded;
  int _revision = 1;

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 980.0 : 1160.0;

    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _PanelSurface(
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Shape selector', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _ShapeKind.values
                            .map(
                              (s) => ChoiceChip(
                                selected: _selected == s,
                                label: Text(s.name),
                                onSelected: (_) => setState(() => _selected = s),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 8),
                      FilledButton.tonal(
                        onPressed: () => setState(() => _revision += 1),
                        child: Text('Refresh gallery ($_revision)'),
                      ),
                      const SizedBox(height: 8),
                      _DataTableCard(
                        rows: [
                          _DataRowItem('selected shape', _selected.name),
                          _DataRowItem('recommended use', _shapeUseCase(_selected)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _green,
                          lines: const [
                            'Rounded and continuous shapes usually fit modern text and content surfaces.',
                            'Beveled and stadium variants can emphasize tool-like or control-like interaction zones.',
                            'Circle lenses work best when visual focus is central and the surrounding composition is balanced.',
                          ],
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
            child: _PanelSurface(
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.07,
                  children: [
                    _shapeCard(_ShapeKind.rounded, _green, _selected == _ShapeKind.rounded, _revision),
                    _shapeCard(_ShapeKind.continuous, _blue, _selected == _ShapeKind.continuous, _revision),
                    _shapeCard(_ShapeKind.beveled, _amber, _selected == _ShapeKind.beveled, _revision),
                    _shapeCard(_ShapeKind.stadium, _rose, _selected == _ShapeKind.stadium, _revision),
                    _shapeCard(_ShapeKind.circle, _violet, _selected == _ShapeKind.circle, _revision),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _shapeCard(_ShapeKind shape, Color tone, bool selected, int revision) {
    final decoration = _buildDecoration(
      shape: shape,
      radius: 20,
      borderWidth: selected ? 3 : 2,
      opacity: selected ? 0.98 : 0.92,
      shadowPreset: _ShadowPreset.subtle,
      shadowsOn: true,
      tone: tone,
    );

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: selected ? 0.75 : 0.35), width: selected ? 2 : 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(shape.name, style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Expanded(
            child: _MagnifierStage(
              tone: tone,
              decoration: decoration,
              magnificationScale: 1.45,
              size: const Size(180, 124),
              focalPointOffset: const Offset(0, -4),
              clip: Clip.antiAlias,
              overlay: true,
              revision: revision,
              label: '${shape.name} gallery',
            ),
          ),
          const SizedBox(height: 6),
          Text(_shapeUseCase(shape), style: const TextStyle(fontSize: 12, color: Color(0xFF3A4F61))),
        ],
      ),
    );
  }
}

class _ShadowScene extends StatefulWidget {
  const _ShadowScene({required this.compact, required this.guide, required this.notes});

  final bool compact;
  final bool guide;
  final bool notes;

  @override
  State<_ShadowScene> createState() => _ShadowSceneState();
}

class _ShadowSceneState extends State<_ShadowScene> {
  _ShadowPreset _preset = _ShadowPreset.balanced;
  bool _enabled = true;
  double _opacity = 0.95;
  double _blurBoost = 0;
  double _offsetY = 6;
  int _revision = 1;

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 900.0 : 1080.0;

    final primary = _buildDecoration(
      shape: _ShapeKind.rounded,
      radius: 20,
      borderWidth: 2,
      opacity: _opacity,
      shadowPreset: _preset,
      shadowsOn: _enabled,
      tone: _amber,
      blurBoost: _blurBoost,
      yOffset: _offsetY,
    );

    final secondary = _buildDecoration(
      shape: _ShapeKind.rounded,
      radius: 20,
      borderWidth: 2,
      opacity: _opacity,
      shadowPreset: _ShadowPreset.subtle,
      shadowsOn: false,
      tone: _amber,
    );

    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _PanelSurface(
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Shadow controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<_ShadowPreset>(
                        initialValue: _preset,
                        decoration: const InputDecoration(labelText: 'Preset', border: OutlineInputBorder()),
                        items: _ShadowPreset.values
                            .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                            .toList(),
                        onChanged: (v) => setState(() => _preset = v ?? _preset),
                      ),
                      const SizedBox(height: 8),
                      _SliderLine(label: 'Lens opacity', value: _opacity, min: 0.2, max: 1, onChanged: (v) => setState(() => _opacity = v)),
                      _SliderLine(label: 'Blur boost', value: _blurBoost, min: 0, max: 20, onChanged: (v) => setState(() => _blurBoost = v)),
                      _SliderLine(label: 'Vertical offset', value: _offsetY, min: -2, max: 20, onChanged: (v) => setState(() => _offsetY = v)),
                      SwitchListTile(
                        value: _enabled,
                        onChanged: (v) => setState(() => _enabled = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Enable shadows'),
                      ),
                      const SizedBox(height: 8),
                      FilledButton.tonal(
                        onPressed: () => setState(() => _revision += 1),
                        child: Text('Refresh shadow stage ($_revision)'),
                      ),
                      const SizedBox(height: 8),
                      _DataTableCard(
                        rows: [
                          _DataRowItem('preset', _preset.name),
                          _DataRowItem('enabled', _enabled ? 'yes' : 'no'),
                          _DataRowItem('opacity', _opacity.toStringAsFixed(2)),
                          _DataRowItem('blur boost', _blurBoost.toStringAsFixed(1)),
                          _DataRowItem('offset y', _offsetY.toStringAsFixed(1)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _amber,
                          lines: const [
                            'Small layered shadows produce optical depth while preserving content clarity under the lens.',
                            'Overly aggressive blur can reduce edge definition and make magnified text harder to read.',
                            'Shadow style should match the ambient elevation model of the app shell.',
                          ],
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
            child: _PanelSurface(
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: _CompareCard(
                        title: 'With shadows',
                        tone: _amber,
                        child: _MagnifierStage(
                          tone: _amber,
                          decoration: primary,
                          magnificationScale: 1.7,
                          size: const Size(220, 150),
                          focalPointOffset: const Offset(0, -6),
                          clip: Clip.antiAlias,
                          overlay: true,
                          revision: _revision,
                          label: 'Shadow active',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _CompareCard(
                        title: 'Without shadows',
                        tone: _rose,
                        child: _MagnifierStage(
                          tone: _rose,
                          decoration: secondary,
                          magnificationScale: 1.7,
                          size: const Size(220, 150),
                          focalPointOffset: const Offset(0, -6),
                          clip: Clip.antiAlias,
                          overlay: true,
                          revision: _revision,
                          label: 'Shadow disabled',
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

class _GeometryScene extends StatefulWidget {
  const _GeometryScene({required this.compact, required this.guide, required this.notes});

  final bool compact;
  final bool guide;
  final bool notes;

  @override
  State<_GeometryScene> createState() => _GeometrySceneState();
}

class _GeometrySceneState extends State<_GeometryScene> {
  double _magnification = 1.5;
  double _sizeW = 220;
  double _sizeH = 150;
  double _focalX = 0;
  double _focalY = -8;
  _ClipMode _clipMode = _ClipMode.antiAlias;
  _ShapeKind _shape = _ShapeKind.continuous;
  int _revision = 1;

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 940.0 : 1120.0;

    final decoration = _buildDecoration(
      shape: _shape,
      radius: 18,
      borderWidth: 2,
      opacity: 0.96,
      shadowPreset: _ShadowPreset.balanced,
      shadowsOn: true,
      tone: _rose,
    );

    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _PanelSurface(
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Geometry controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      _SliderLine(label: 'Magnification scale', value: _magnification, min: 1, max: 3, onChanged: (v) => setState(() => _magnification = v)),
                      _SliderLine(label: 'Lens width', value: _sizeW, min: 120, max: 320, onChanged: (v) => setState(() => _sizeW = v)),
                      _SliderLine(label: 'Lens height', value: _sizeH, min: 80, max: 240, onChanged: (v) => setState(() => _sizeH = v)),
                      _SliderLine(label: 'Focal X', value: _focalX, min: -80, max: 80, onChanged: (v) => setState(() => _focalX = v)),
                      _SliderLine(label: 'Focal Y', value: _focalY, min: -80, max: 80, onChanged: (v) => setState(() => _focalY = v)),
                      DropdownButtonFormField<_ClipMode>(
                        initialValue: _clipMode,
                        decoration: const InputDecoration(labelText: 'Clip mode', border: OutlineInputBorder()),
                        items: _ClipMode.values.map((e) => DropdownMenuItem(value: e, child: Text(e.name))).toList(),
                        onChanged: (v) => setState(() => _clipMode = v ?? _clipMode),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<_ShapeKind>(
                        initialValue: _shape,
                        decoration: const InputDecoration(labelText: 'Decoration shape', border: OutlineInputBorder()),
                        items: _ShapeKind.values.map((e) => DropdownMenuItem(value: e, child: Text(e.name))).toList(),
                        onChanged: (v) => setState(() => _shape = v ?? _shape),
                      ),
                      const SizedBox(height: 8),
                      FilledButton.tonal(
                        onPressed: () => setState(() => _revision += 1),
                        child: Text('Refresh geometry stage ($_revision)'),
                      ),
                      const SizedBox(height: 8),
                      _DataTableCard(
                        rows: [
                          _DataRowItem('magnification', _magnification.toStringAsFixed(2)),
                          _DataRowItem('size', '${_sizeW.toStringAsFixed(0)} x ${_sizeH.toStringAsFixed(0)}'),
                          _DataRowItem('focal', '(${_focalX.toStringAsFixed(1)}, ${_focalY.toStringAsFixed(1)})'),
                          _DataRowItem('clip', _clipMode.name),
                          _DataRowItem('shape', _shape.name),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _rose,
                          lines: const [
                            'Lens geometry and decoration must be tuned together; large magnification often needs softer frame treatment.',
                            'focalPointOffset helps align the apparent zoom center with the interaction target.',
                            'clipBehavior defines edge behavior where child sampling exceeds the lens shape.',
                          ],
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
            child: _PanelSurface(
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: _MagnifierStage(
                  tone: _rose,
                  decoration: decoration,
                  magnificationScale: _magnification,
                  size: Size(_sizeW, _sizeH),
                  focalPointOffset: Offset(_focalX, _focalY),
                  clip: _clipToFlutter(_clipMode),
                  overlay: true,
                  revision: _revision,
                  label: 'Geometry stage',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PracticalScene extends StatefulWidget {
  const _PracticalScene({required this.compact, required this.guide, required this.notes});

  final bool compact;
  final bool guide;
  final bool notes;

  @override
  State<_PracticalScene> createState() => _PracticalSceneState();
}

class _PracticalSceneState extends State<_PracticalScene> {
  bool _overlay = true;
  int _revision = 1;
  final List<String> _events = <String>[];

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 1120.0 : 1320.0;

    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: _PanelSurface(
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilterChip(
                          selected: _overlay,
                          label: const Text('Overlay guides'),
                          onSelected: (v) => setState(() => _overlay = v),
                        ),
                        FilledButton.tonal(
                          onPressed: () => setState(() => _revision += 1),
                          child: Text('Refresh all lenses ($_revision)'),
                        ),
                        FilledButton.tonal(
                          onPressed: () {
                            setState(() {
                              _events.insert(0, '${_clock()} | baseline snapshot captured');
                              if (_events.length > 30) {
                                _events.removeRange(30, _events.length);
                              }
                            });
                          },
                          child: const Text('Capture snapshot'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: _PracticalLensCard(
                              title: 'Document Inspector Lens',
                              tone: _blue,
                              decoration: _buildDecoration(
                                shape: _ShapeKind.rounded,
                                radius: 18,
                                borderWidth: 2,
                                opacity: 0.95,
                                shadowPreset: _ShadowPreset.balanced,
                                shadowsOn: true,
                                tone: _blue,
                              ),
                              overlay: _overlay,
                              revision: _revision,
                              label: 'Doc lens',
                              onEvent: (e) => _push('doc: $e'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _PracticalLensCard(
                              title: 'Timeline Scrubber Lens',
                              tone: _green,
                              decoration: _buildDecoration(
                                shape: _ShapeKind.stadium,
                                radius: 20,
                                borderWidth: 2,
                                opacity: 0.93,
                                shadowPreset: _ShadowPreset.subtle,
                                shadowsOn: true,
                                tone: _green,
                              ),
                              overlay: _overlay,
                              revision: _revision,
                              label: 'Timeline lens',
                              onEvent: (e) => _push('timeline: $e'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _PracticalLensCard(
                              title: 'Map Focus Lens',
                              tone: _violet,
                              decoration: _buildDecoration(
                                shape: _ShapeKind.circle,
                                radius: 20,
                                borderWidth: 2,
                                opacity: 0.98,
                                shadowPreset: _ShadowPreset.dramatic,
                                shadowsOn: true,
                                tone: _violet,
                              ),
                              overlay: _overlay,
                              revision: _revision,
                              label: 'Map lens',
                              onEvent: (e) => _push('map: $e'),
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
          const SizedBox(width: 10),
          Expanded(
            flex: 6,
            child: _PanelSurface(
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Practical notes', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    _DataTableCard(
                      rows: [
                        _DataRowItem('revision', '$_revision'),
                        _DataRowItem('overlay', _overlay ? 'visible' : 'hidden'),
                        _DataRowItem('active layouts', 'document / timeline / map'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (widget.notes)
                      _InstructionCard(
                        tone: _violet,
                        lines: const [
                          'Treat MagnifierDecoration as part of component theming, not a one-off hardcoded effect.',
                          'Different workflows can share the same magnifier behavior while using context-specific frame styling.',
                          'In production UI, align lens shape, border, and shadows with existing elevation and corner systems.',
                        ],
                      ),
                    const SizedBox(height: 8),
                    const Text('Event log', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Expanded(child: _LogCard(lines: _events)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _push(String message) {
    setState(() {
      _events.insert(0, '${_clock()} | $message');
      if (_events.length > 30) {
        _events.removeRange(30, _events.length);
      }
    });
  }
}

class _PracticalLensCard extends StatefulWidget {
  const _PracticalLensCard({
    required this.title,
    required this.tone,
    required this.decoration,
    required this.overlay,
    required this.revision,
    required this.label,
    required this.onEvent,
  });

  final String title;
  final Color tone;
  final MagnifierDecoration decoration;
  final bool overlay;
  final int revision;
  final String label;
  final ValueChanged<String> onEvent;

  @override
  State<_PracticalLensCard> createState() => _PracticalLensCardState();
}

class _PracticalLensCardState extends State<_PracticalLensCard> {
  double _x = 0;
  double _y = -8;
  double _scale = 1.55;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.tone.withValues(alpha: 0.40)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title, style: TextStyle(color: widget.tone, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Expanded(
            child: _MagnifierStage(
              tone: widget.tone,
              decoration: widget.decoration,
              magnificationScale: _scale,
              size: const Size(180, 126),
              focalPointOffset: Offset(_x, _y),
              clip: Clip.antiAlias,
              overlay: widget.overlay,
              revision: widget.revision,
              label: widget.label,
            ),
          ),
          const SizedBox(height: 6),
          _MiniSlider(label: 'X', value: _x, min: -60, max: 60, onChanged: (v) => setState(() => _x = v)),
          _MiniSlider(label: 'Y', value: _y, min: -60, max: 60, onChanged: (v) => setState(() => _y = v)),
          _MiniSlider(label: 'Scale', value: _scale, min: 1, max: 2.5, onChanged: (v) => setState(() => _scale = v)),
          const SizedBox(height: 4),
          FilledButton.tonal(
            onPressed: () => widget.onEvent('focus=(${_x.toStringAsFixed(1)}, ${_y.toStringAsFixed(1)}), scale=${_scale.toStringAsFixed(2)}'),
            child: const Text('Record lens setting'),
          ),
        ],
      ),
    );
  }
}

class _CompareCard extends StatelessWidget {
  const _CompareCard({required this.title, required this.tone, required this.child});

  final String title;
  final Color tone;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.40)),
        color: Colors.white,
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

class _MagnifierStage extends StatelessWidget {
  const _MagnifierStage({
    required this.tone,
    required this.decoration,
    required this.magnificationScale,
    required this.size,
    required this.focalPointOffset,
    required this.clip,
    required this.overlay,
    required this.revision,
    required this.label,
  });

  final Color tone;
  final MagnifierDecoration decoration;
  final double magnificationScale;
  final Size size;
  final Offset focalPointOffset;
  final Clip clip;
  final bool overlay;
  final int revision;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: _PatternCanvas(tone: tone, revision: revision, label: label)),
        Align(
          alignment: Alignment.center,
          child: RawMagnifier(
            decoration: decoration,
            magnificationScale: magnificationScale,
            focalPointOffset: focalPointOffset,
            clipBehavior: clip,
            size: size,
            child: _PatternCanvas(tone: tone, revision: revision, label: '$label lens'),
          ),
        ),
        if (overlay)
          IgnorePointer(
            child: Center(
              child: Container(
                width: size.width + 10,
                height: size.height + 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: tone.withValues(alpha: 0.28), width: 2),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _PatternCanvas extends StatelessWidget {
  const _PatternCanvas({required this.tone, required this.revision, required this.label});

  final Color tone;
  final int revision;
  final String label;

  @override
  Widget build(BuildContext context) {
    final chips = List<String>.generate(9, (i) => 'Seg ${i + 1}');
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tone.withValues(alpha: 0.12), Colors.white, tone.withValues(alpha: 0.08)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tone.withValues(alpha: 0.25)),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Guard against the lens stage being narrower than the
              // composite "<context> lens" / "<context> lens lens" label —
              // ellipsis lets the label shrink instead of overflowing the
              // canvas Row to the right.
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: tone, fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(width: 6),
              Text('rev $revision', style: TextStyle(color: tone.withValues(alpha: 0.75), fontWeight: FontWeight.w600, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
              childAspectRatio: 1.2,
              children: chips
                  .map(
                    (chip) => Container(
                      decoration: BoxDecoration(
                        color: tone.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: tone.withValues(alpha: 0.30)),
                      ),
                      child: Center(
                        child: Text(chip, style: TextStyle(color: tone.withValues(alpha: 0.9), fontWeight: FontWeight.w700)),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _PanelSurface extends StatelessWidget {
  const _PanelSurface({required this.guide, required this.child});

  final bool guide;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC6D7E7)),
        gradient: const LinearGradient(
          colors: [Color(0xFFFAFCFF), Color(0xFFEFF5FC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (guide) const CustomPaint(painter: _GridPainter()),
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
    final p = Paint()..color = const Color(0x10000000);
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

class _DataRowItem {
  const _DataRowItem(this.label, this.value);

  final String label;
  final String value;
}

class _DataTableCard extends StatelessWidget {
  const _DataTableCard({required this.rows});

  final List<_DataRowItem> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F8FD),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD3E1EF)),
      ),
      child: Column(
        children: rows
            .map(
              (r) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                // Use a 2:3 flex split for the label/value columns instead of
                // a hard SizedBox(width: 130). The data table renders inside
                // narrow flex 6 / 15 side panels where 130 px of label can be
                // most of the row, leaving the value column unable to fit.
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        r.label,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      flex: 3,
                      child: Text(
                        r.value,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      ),
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

class _SliderLine extends StatelessWidget {
  const _SliderLine({required this.label, required this.value, required this.min, required this.max, required this.onChanged});

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
        Text('$label: ${value.toStringAsFixed(2)}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
        Slider(value: value, min: min, max: max, onChanged: onChanged),
      ],
    );
  }
}

class _MiniSlider extends StatelessWidget {
  const _MiniSlider({required this.label, required this.value, required this.min, required this.max, required this.onChanged});

  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 38, child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700))),
        Expanded(child: Slider(value: value, min: min, max: max, onChanged: onChanged)),
      ],
    );
  }
}

class _InstructionCard extends StatelessWidget {
  const _InstructionCard({required this.tone, required this.lines});

  final Color tone;
  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: tone.withValues(alpha: 0.95), borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lines
            .map(
              (line) => Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Icon(Icons.circle, size: 7, color: Color(0xFFC0E4FF)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(line, style: const TextStyle(color: Color(0xFFEAF6FF), height: 1.35))),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _LogCard extends StatelessWidget {
  const _LogCard({required this.lines});

  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFCFDEEC)),
      ),
      child: lines.isEmpty
          ? const Text('No events yet.', style: TextStyle(color: Color(0xFF62798D)))
          : ListView.builder(
              itemCount: lines.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(lines[index], style: const TextStyle(fontSize: 11, fontFamily: 'monospace')),
                );
              },
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
        color: const Color(0xFF15384F),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recap: MagnifierDecoration', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
          SizedBox(height: 8),
          Text(
            'MagnifierDecoration defines the visual identity of a lens surface: shape silhouette, optical frame opacity, and depth cues via shadows. '
            'Use it with RawMagnifier to keep magnification behavior stable while aligning the lens style with each product context.',
            style: TextStyle(color: Color(0xFFD7E8F6), height: 1.35),
          ),
        ],
      ),
    );
  }
}

MagnifierDecoration _buildDecoration({
  required _ShapeKind shape,
  required double radius,
  required double borderWidth,
  required double opacity,
  required _ShadowPreset shadowPreset,
  required bool shadowsOn,
  required Color tone,
  double blurBoost = 0,
  double yOffset = 6,
}) {
  final border = BorderSide(color: tone.withValues(alpha: 0.72), width: borderWidth);
  final shapeBorder = switch (shape) {
    _ShapeKind.rounded => RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius), side: border),
    _ShapeKind.continuous => ContinuousRectangleBorder(borderRadius: BorderRadius.circular(radius), side: border),
    _ShapeKind.beveled => BeveledRectangleBorder(borderRadius: BorderRadius.circular(radius), side: border),
    _ShapeKind.stadium => StadiumBorder(side: border),
    _ShapeKind.circle => CircleBorder(side: border),
  };

  final shadows = shadowsOn
      ? _buildShadows(preset: shadowPreset, tone: tone, blurBoost: blurBoost, yOffset: yOffset)
      : null;

  return MagnifierDecoration(opacity: opacity, shadows: shadows, shape: shapeBorder);
}

List<BoxShadow> _buildShadows({
  required _ShadowPreset preset,
  required Color tone,
  required double blurBoost,
  required double yOffset,
}) {
  switch (preset) {
    case _ShadowPreset.subtle:
      return [
        BoxShadow(color: Colors.black.withValues(alpha: 0.10), blurRadius: 8 + blurBoost, offset: Offset(0, yOffset * 0.35)),
      ];
    case _ShadowPreset.balanced:
      return [
        BoxShadow(color: Colors.black.withValues(alpha: 0.16), blurRadius: 10 + blurBoost, offset: Offset(0, yOffset * 0.45)),
        BoxShadow(color: tone.withValues(alpha: 0.20), blurRadius: 22 + blurBoost, spreadRadius: 1, offset: Offset(0, yOffset)),
      ];
    case _ShadowPreset.dramatic:
      return [
        BoxShadow(color: Colors.black.withValues(alpha: 0.26), blurRadius: 14 + blurBoost, offset: Offset(0, yOffset)),
        BoxShadow(color: tone.withValues(alpha: 0.28), blurRadius: 32 + blurBoost, spreadRadius: 2, offset: Offset(0, yOffset + 3)),
      ];
    case _ShadowPreset.neon:
      return [
        BoxShadow(color: tone.withValues(alpha: 0.45), blurRadius: 24 + blurBoost, spreadRadius: 2, offset: Offset(0, yOffset * 0.4)),
        BoxShadow(color: Colors.white.withValues(alpha: 0.35), blurRadius: 8 + blurBoost * 0.4, offset: const Offset(0, 0)),
      ];
  }
}

String _shapeUseCase(_ShapeKind shape) {
  switch (shape) {
    case _ShapeKind.rounded:
      return 'General purpose lens for dashboards and document tools.';
    case _ShapeKind.continuous:
      return 'Soft premium look for modern iOS-like interaction surfaces.';
    case _ShapeKind.beveled:
      return 'Mechanical or technical styling where angular edges are desired.';
    case _ShapeKind.stadium:
      return 'Great for timeline and scrubber interfaces with horizontal emphasis.';
    case _ShapeKind.circle:
      return 'Central focus lens for map, image, or pointer-based inspection.';
  }
}

Clip _clipToFlutter(_ClipMode mode) {
  switch (mode) {
    case _ClipMode.none:
      return Clip.none;
    case _ClipMode.hardEdge:
      return Clip.hardEdge;
    case _ClipMode.antiAlias:
      return Clip.antiAlias;
    case _ClipMode.antiAliasWithSaveLayer:
      return Clip.antiAliasWithSaveLayer;
  }
}

String _clock() => DateTime.now().toIso8601String().substring(11, 19);
