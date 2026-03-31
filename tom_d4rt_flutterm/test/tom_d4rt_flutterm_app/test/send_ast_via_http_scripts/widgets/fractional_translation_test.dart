import 'package:flutter/material.dart';

const _ink = Color(0xFF1F4E73);
const _sun = Color(0xFFC47B36);
const _moss = Color(0xFF2A7A6F);
const _berry = Color(0xFF924468);
const _violet = Color(0xFF5B54A0);
const _earth = Color(0xFF6D672C);

dynamic build(BuildContext context) {
  return const _FractionalTranslationDeepDemoApp();
}

class _FractionalTranslationDeepDemoApp extends StatelessWidget {
  const _FractionalTranslationDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _ink),
      ),
      home: const _FractionalTranslationPage(),
    );
  }
}

class _FractionalTranslationPage extends StatefulWidget {
  const _FractionalTranslationPage();

  @override
  State<_FractionalTranslationPage> createState() => _FractionalTranslationPageState();
}

class _FractionalTranslationPageState extends State<_FractionalTranslationPage> {
  bool _rtl = false;
  bool _compact = false;
  bool _showGrid = true;

  double _tx = 0.18;
  double _ty = -0.12;

  @override
  Widget build(BuildContext context) {
    final config = _GlobalConfig(
      compact: _compact,
      showGrid: _showGrid,
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      translation: Offset(_tx, _ty),
    );

    return Directionality(
      textDirection: config.textDirection,
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F5F8),
        appBar: AppBar(
          backgroundColor: _ink,
          foregroundColor: Colors.white,
          toolbarHeight: 78,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('FractionalTranslation Deep Demo'),
              const SizedBox(height: 2),
              Text(
                _rtl ? 'Ambient direction: RTL' : 'Ambient direction: LTR',
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
              _StudioDeck(
                rtl: _rtl,
                compact: _compact,
                showGrid: _showGrid,
                tx: _tx,
                ty: _ty,
                onRtlChanged: (v) => setState(() => _rtl = v),
                onCompactChanged: (v) => setState(() => _compact = v),
                onShowGridChanged: (v) => setState(() => _showGrid = v),
                onTxChanged: (v) => setState(() => _tx = v),
                onTyChanged: (v) => setState(() => _ty = v),
              ),
              const SizedBox(height: 12),
              const _SceneShell(
                index: 1,
                accent: _ink,
                title: 'Core Model and Intended Use',
                subtitle:
                    'FractionalTranslation offsets painting by a fraction of the child size, making movement scale with the widget itself.',
                child: _ConceptScene(),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 2,
                accent: _sun,
                title: 'Size-Scaled Translation Lab',
                subtitle:
                    'The same fractional offset creates different absolute movement for differently-sized children.',
                child: _SizeScaledScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 3,
                accent: _moss,
                title: 'Fractional vs Absolute Translation',
                subtitle:
                    'Compare FractionalTranslation with Transform.translate to see responsive vs fixed-pixel displacement.',
                child: _ComparisonScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 4,
                accent: _berry,
                title: 'Hit Test Behavior',
                subtitle:
                    'Toggle transformHitTests and observe where taps are accepted relative to where content is painted.',
                child: _HitTestScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 5,
                accent: _violet,
                title: 'Overflow and Clip Interaction',
                subtitle:
                    'Fractional translation can paint outside parent bounds; clipping policy determines visible output.',
                child: _ClipScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 6,
                accent: _earth,
                title: 'Animated and Practical Composition',
                subtitle:
                    'Animate fractional offsets and apply them to practical card/badge layouts where protrusion is intentional.',
                child: _AnimatedPracticalScene(config: config),
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

class _GlobalConfig {
  const _GlobalConfig({
    required this.compact,
    required this.showGrid,
    required this.textDirection,
    required this.translation,
  });

  final bool compact;
  final bool showGrid;
  final TextDirection textDirection;
  final Offset translation;
}

class _StudioDeck extends StatelessWidget {
  const _StudioDeck({
    required this.rtl,
    required this.compact,
    required this.showGrid,
    required this.tx,
    required this.ty,
    required this.onRtlChanged,
    required this.onCompactChanged,
    required this.onShowGridChanged,
    required this.onTxChanged,
    required this.onTyChanged,
  });

  final bool rtl;
  final bool compact;
  final bool showGrid;
  final double tx;
  final double ty;
  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onShowGridChanged;
  final ValueChanged<double> onTxChanged;
  final ValueChanged<double> onTyChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF1F4E73), Color(0xFF446A89), Color(0xFF734C66)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fractional Translation Studio Deck',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 27),
          ),
          const SizedBox(height: 8),
          const Text(
            'Adjust the global fractional offset once, then inspect how each scene interprets it for layout, hit-testing, clipping, and animation behavior.',
            style: TextStyle(color: Color(0xFFF4F8FF), fontSize: 13, height: 1.45),
          ),
          const SizedBox(height: 10),
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
                  value: compact,
                  onChanged: onCompactChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Compact cards', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SwitchListTile(
                  value: showGrid,
                  onChanged: onShowGridChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Show guide grid', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text('translation.dx = ${tx.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          Slider(
            value: tx,
            min: -1,
            max: 1,
            divisions: 20,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.3),
            onChanged: onTxChanged,
          ),
          Text('translation.dy = ${ty.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          Slider(
            value: ty,
            min: -1,
            max: 1,
            divisions: 20,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.3),
            onChanged: onTyChanged,
          ),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _Tag(label: 'Offset is multiplied by child size'),
              _Tag(label: 'Painting translation, not relayout'),
              _Tag(label: 'transformHitTests toggles hit mapping'),
              _Tag(label: 'Clip controls visibility of overflow'),
            ],
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12)),
      ),
    );
  }
}

class _SceneShell extends StatelessWidget {
  const _SceneShell({
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
                      Text(subtitle, style: const TextStyle(height: 1.4, color: Color(0xFF2F3B45))),
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
        const Text('How to think about FractionalTranslation', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
        const SizedBox(height: 8),
        const Text(
          'FractionalTranslation applies a paint-time translation whose components are fractions of the child width and height. If translation is (0.25, -0.5) and child size is 200x100, the visual shift is (+50, -50) pixels.',
          style: TextStyle(height: 1.45),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFD),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFDDE5EE)),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Bullet(text: 'Translation is size-relative, so larger children move farther in absolute pixels.'),
              _Bullet(text: 'It shifts painting, not layout allocation. Parent constraints and original slot remain.'),
              _Bullet(text: 'transformHitTests=true maps taps to transformed paint position.'),
              _Bullet(text: 'transformHitTests=false keeps hit region at original position.'),
              _Bullet(text: 'Overflow visibility depends on clip behavior of ancestors.'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Wrap(
          spacing: 14,
          runSpacing: 8,
          children: [
            _Legend(color: _ink, label: 'Use for size-relative nudges'),
            _Legend(color: _moss, label: 'Great for badges / overlap motifs'),
            _Legend(color: _berry, label: 'Not a replacement for absolute pixel offsets'),
          ],
        ),
      ],
    );
  }
}

class _SizeScaledScene extends StatelessWidget {
  const _SizeScaledScene({required this.config});

  final _GlobalConfig config;

  @override
  Widget build(BuildContext context) {
    const small = Size(120, 80);
    const medium = Size(180, 110);
    const large = Size(260, 160);

    final sdx = config.translation.dx * small.width;
    final sdy = config.translation.dy * small.height;
    final mdx = config.translation.dx * medium.width;
    final mdy = config.translation.dy * medium.height;
    final ldx = config.translation.dx * large.width;
    final ldy = config.translation.dy * large.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Current fraction: (${config.translation.dx.toStringAsFixed(2)}, ${config.translation.dy.toStringAsFixed(2)})',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        const Text(
          'Same fraction, different child size -> different pixel movement. Labels below show computed dx/dy in pixels.',
          style: TextStyle(height: 1.35),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: config.compact ? 220 : 280,
          child: _GuideStage(
            showGrid: config.showGrid,
            child: Row(
              children: [
                Expanded(
                  child: _FractionCard(
                    title: 'Small 120x80',
                    size: small,
                    translation: config.translation,
                    color: const Color(0xFFC8DFF3),
                    movementLabel: 'dx ${sdx.toStringAsFixed(1)} | dy ${sdy.toStringAsFixed(1)}',
                  ),
                ),
                Expanded(
                  child: _FractionCard(
                    title: 'Medium 180x110',
                    size: medium,
                    translation: config.translation,
                    color: const Color(0xFFD8ECC8),
                    movementLabel: 'dx ${mdx.toStringAsFixed(1)} | dy ${mdy.toStringAsFixed(1)}',
                  ),
                ),
                Expanded(
                  child: _FractionCard(
                    title: 'Large 260x160',
                    size: large,
                    translation: config.translation,
                    color: const Color(0xFFEED2E0),
                    movementLabel: 'dx ${ldx.toStringAsFixed(1)} | dy ${ldy.toStringAsFixed(1)}',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FractionCard extends StatelessWidget {
  const _FractionCard({
    required this.title,
    required this.size,
    required this.translation,
    required this.color,
    required this.movementLabel,
  });

  final String title;
  final Size size;
  final Offset translation;
  final Color color;
  final String movementLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: size.width,
                  height: size.height,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: const Color(0xFF7E8FA0), width: 1.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                FractionalTranslation(
                  translation: translation,
                  child: Container(
                    width: size.width,
                    height: size.height,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF5F7286), width: 1.2),
                    ),
                    alignment: Alignment.center,
                    child: const Text('Translated', style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(movementLabel, style: const TextStyle(fontSize: 12, color: Color(0xFF4B5D6E))),
        ],
      ),
    );
  }
}

class _ComparisonScene extends StatefulWidget {
  const _ComparisonScene({required this.config});

  final _GlobalConfig config;

  @override
  State<_ComparisonScene> createState() => _ComparisonSceneState();
}

class _ComparisonSceneState extends State<_ComparisonScene> {
  double _absoluteDx = 32;
  double _absoluteDy = -18;

  @override
  Widget build(BuildContext context) {
    final config = widget.config;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Left: FractionalTranslation (size-relative). Right: Transform.translate (absolute pixels).',
          style: TextStyle(height: 1.35),
        ),
        const SizedBox(height: 8),
        Text('Absolute offset: (${_absoluteDx.toStringAsFixed(0)}, ${_absoluteDy.toStringAsFixed(0)})', style: const TextStyle(fontWeight: FontWeight.w700)),
        Slider(
          value: _absoluteDx,
          min: -80,
          max: 80,
          divisions: 16,
          onChanged: (v) => setState(() => _absoluteDx = v),
        ),
        Slider(
          value: _absoluteDy,
          min: -80,
          max: 80,
          divisions: 16,
          onChanged: (v) => setState(() => _absoluteDy = v),
        ),
        SizedBox(
          height: config.compact ? 220 : 280,
          child: _GuideStage(
            showGrid: config.showGrid,
            child: Row(
              children: [
                Expanded(
                  child: _CompareCard(
                    title: 'FractionalTranslation',
                    subtitle: 'Scales with child size.',
                    child: FractionalTranslation(
                      translation: config.translation,
                      child: _PaletteTile(color: const Color(0xFFC8DEF3), label: 'Fractional'),
                    ),
                  ),
                ),
                Expanded(
                  child: _CompareCard(
                    title: 'Transform.translate',
                    subtitle: 'Fixed pixel movement.',
                    child: Transform.translate(
                      offset: Offset(_absoluteDx, _absoluteDy),
                      child: _PaletteTile(color: const Color(0xFFEFD2E0), label: 'Absolute'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CompareCard extends StatelessWidget {
  const _CompareCard({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFD8E3EE)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
            Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF516373))),
            const SizedBox(height: 10),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 170,
                    height: 120,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF7D8E9E), width: 1.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaletteTile extends StatelessWidget {
  const _PaletteTile({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 120,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF6D7E8F)),
      ),
      alignment: Alignment.center,
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
    );
  }
}

class _HitTestScene extends StatefulWidget {
  const _HitTestScene({required this.config});

  final _GlobalConfig config;

  @override
  State<_HitTestScene> createState() => _HitTestSceneState();
}

class _HitTestSceneState extends State<_HitTestScene> {
  bool _transformHitTests = true;
  int _tapCount = 0;
  int _rawTapCount = 0;

  @override
  Widget build(BuildContext context) {
    final config = widget.config;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ActionButton(
              label: _transformHitTests ? 'transformHitTests: true' : 'transformHitTests: false',
              color: _berry,
              onPressed: () => setState(() => _transformHitTests = !_transformHitTests),
            ),
            _ActionButton(
              label: 'Reset counters',
              color: _ink,
              onPressed: () => setState(() {
                _tapCount = 0;
                _rawTapCount = 0;
              }),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text('Translated target taps: $_tapCount | Base area taps: $_rawTapCount', style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        const Text(
          'Tap where the painted card appears and where the dashed origin frame is. Toggle transformHitTests to compare behavior.',
          style: TextStyle(height: 1.35),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: config.compact ? 220 : 280,
          child: _GuideStage(
            showGrid: config.showGrid,
            child: Center(
              child: Container(
                width: 360,
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFD8E3EE)),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => _rawTapCount += 1),
                      child: Container(
                        width: 170,
                        height: 120,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xAA576D84), style: BorderStyle.solid, width: 1.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: const Text('Origin slot', style: TextStyle(color: Color(0xFF5A6B7B))),
                      ),
                    ),
                    FractionalTranslation(
                      translation: config.translation,
                      transformHitTests: _transformHitTests,
                      child: GestureDetector(
                        onTap: () => setState(() => _tapCount += 1),
                        child: Container(
                          width: 170,
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD8ECC8),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFF5E7A63), width: 1.3),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            _transformHitTests ? 'Hit mapped with paint' : 'Hit stays at origin',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ClipScene extends StatefulWidget {
  const _ClipScene({required this.config});

  final _GlobalConfig config;

  @override
  State<_ClipScene> createState() => _ClipSceneState();
}

class _ClipSceneState extends State<_ClipScene> {
  Clip _clip = Clip.none;

  @override
  Widget build(BuildContext context) {
    final config = widget.config;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ActionButton(
              label: 'clipBehavior: ${_clip.name}',
              color: _violet,
              onPressed: () {
                setState(() {
                  _clip = switch (_clip) {
                    Clip.none => Clip.hardEdge,
                    Clip.hardEdge => Clip.antiAlias,
                    Clip.antiAlias => Clip.none,
                    Clip.antiAliasWithSaveLayer => Clip.none,
                  };
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'The translated card intentionally overflows parent bounds. Change clipBehavior to observe what remains visible.',
          style: TextStyle(height: 1.35),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: config.compact ? 220 : 280,
          child: _GuideStage(
            showGrid: config.showGrid,
            child: Center(
              child: Container(
                width: 420,
                height: 220,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFD8E3EE)),
                ),
                child: ClipRect(
                  clipBehavior: _clip,
                  child: Container(
                    width: 280,
                    height: 150,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FBFF),
                      border: Border.all(color: const Color(0xFF8B9BAA), width: 1.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        const Positioned(
                          bottom: 6,
                          child: Text('Parent bounds', style: TextStyle(color: Color(0xFF5A6C7E))),
                        ),
                        FractionalTranslation(
                          translation: config.translation,
                          child: Container(
                            width: 180,
                            height: 100,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFD2E0),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color(0xFF825069), width: 1.2),
                            ),
                            alignment: Alignment.center,
                            child: const Text('Translated overflow tile', style: TextStyle(fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AnimatedPracticalScene extends StatefulWidget {
  const _AnimatedPracticalScene({required this.config});

  final _GlobalConfig config;

  @override
  State<_AnimatedPracticalScene> createState() => _AnimatedPracticalSceneState();
}

class _AnimatedPracticalSceneState extends State<_AnimatedPracticalScene> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _auto = false;
  double _amplitude = 0.3;
  int _selected = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400), reverseDuration: const Duration(milliseconds: 900));
    _loop();
  }

  Future<void> _loop() async {
    while (mounted) {
      await Future<void>.delayed(const Duration(milliseconds: 120));
      if (!mounted || !_auto) {
        continue;
      }
      if (_controller.status == AnimationStatus.completed) {
        await _controller.reverse();
      } else if (_controller.status == AnimationStatus.dismissed) {
        await _controller.forward();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final items = <_BoardItem>[
      const _BoardItem('Arrival', 'Incoming shipment reached dock gate.'),
      const _BoardItem('Review', 'Quality team attached photo evidence.'),
      const _BoardItem('Dispatch', 'Courier picked batch for route north.'),
      const _BoardItem('Confirm', 'Recipient signed and archived receipt.'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ActionButton(
              label: _auto ? 'Auto motion: ON' : 'Auto motion: OFF',
              color: _earth,
              onPressed: () => setState(() => _auto = !_auto),
            ),
            _ActionButton(
              label: 'Forward',
              color: _ink,
              onPressed: () => _controller.forward(),
            ),
            _ActionButton(
              label: 'Reverse',
              color: _berry,
              onPressed: () => _controller.reverse(),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text('Animation value: ${_controller.value.toStringAsFixed(2)} | amplitude: ${_amplitude.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w700)),
        Slider(
          value: _amplitude,
          min: 0.05,
          max: 0.6,
          divisions: 11,
          onChanged: (v) => setState(() => _amplitude = v),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: config.compact ? 280 : 360,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _GuideStage(
                  showGrid: config.showGrid,
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      final t = Curves.easeInOut.transform(_controller.value);
                      final offset = Offset(
                        config.translation.dx * (1 + t) * _amplitude * 2,
                        config.translation.dy * (1 + t) * _amplitude * 2,
                      );

                      return Center(
                        child: FractionalTranslation(
                          translation: offset,
                          child: Container(
                            width: 220,
                            height: 130,
                            decoration: BoxDecoration(
                              color: const Color(0xFFD7ECC8),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFF5E7A63), width: 1.3),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Animated fraction\n(${offset.dx.toStringAsFixed(2)}, ${offset.dy.toStringAsFixed(2)})',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      );
                    },
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
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFD3DEEA)),
                          ),
                          child: const Text('Practical board with protruding status chips', style: TextStyle(fontWeight: FontWeight.w800)),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: ListView.separated(
                            itemCount: items.length,
                            separatorBuilder: (_, _) => const SizedBox(height: 8),
                            itemBuilder: (context, index) {
                              final item = items[index];
                              final selected = index == _selected;

                              return InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () => setState(() => _selected = index),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: selected ? const Color(0xFFEAF3FD) : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: const Color(0xFFD6E1ED)),
                                  ),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(item.title, style: const TextStyle(fontWeight: FontWeight.w800)),
                                          const SizedBox(height: 4),
                                          Text(item.detail, style: const TextStyle(height: 1.3, color: Color(0xFF55697A))),
                                        ],
                                      ),
                                      FractionalTranslation(
                                        translation: const Offset(0.45, -0.45),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                            decoration: BoxDecoration(
                                              color: selected ? const Color(0xFF2A7A6F) : const Color(0xFF6F7D8A),
                                              borderRadius: BorderRadius.circular(999),
                                            ),
                                            child: Text(
                                              selected ? 'Active' : 'Idle',
                                              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
                                            ),
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BoardItem {
  const _BoardItem(this.title, this.detail);

  final String title;
  final String detail;
}

class _GuideStage extends StatelessWidget {
  const _GuideStage({required this.showGrid, required this.child});

  final bool showGrid;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFFF7FBFF), Color(0xFFEAF2F8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFFD4E0EB)),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (showGrid)
            CustomPaint(
              painter: _GridPainter(),
            ),
          child,
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const step = 22.0;
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

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 9, height: 9, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
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

class _RecapPanel extends StatelessWidget {
  const _RecapPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF10273C),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recap: Choosing FractionalTranslation',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
          ),
          SizedBox(height: 8),
          Text(
            'Use FractionalTranslation when movement should scale naturally with child dimensions. Prefer Transform.translate when offsets must stay absolute in pixels regardless of widget size.',
            style: TextStyle(color: Color(0xFFD9E5F1), height: 1.4),
          ),
        ],
      ),
    );
  }
}
