// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'dart:math' as math;
import 'package:flutter/material.dart';

// ============================================================================
// Visual deep demo: ToggleablePainter (Material).
//
// ToggleablePainter is the abstract CustomPainter at the heart of every
// classical Material toggle: Checkbox, Switch and Radio all subclass it as
// _CheckboxPainter, _SwitchPainter, _RadioPainter.  It bundles together the
// many things a toggle needs to render: the toggle position animation, the
// reaction (ink splash) animation, focus/hover fade animations, and a small
// army of colors (active / inactive / reaction / inactive-reaction / hover /
// focus).  Subclasses only have to override paint(Canvas, Size) and decide
// what to draw given those inputs.
//
// This demo does NOT instantiate or paint a real ToggleablePainter (that
// would require live Animation<double> objects and we are constrained to a
// pure synchronous build).  Instead, we hand-paint frozen frames of the same
// idea using our own CustomPainters that take plain doubles instead of
// Animation<double>s.  The result is a static, sandbox-friendly walkthrough.
// ============================================================================

// ----------------------------------------------------------------------------
// Theme tokens used across the page.
// ----------------------------------------------------------------------------
const Color _kBg = Color(0xFFF4F6FA);
const Color _kCard = Color(0xFFFFFFFF);
const Color _kInk = Color(0xFF1B1F27);
const Color _kInkDim = Color(0xFF55606D);
const Color _kInkFaint = Color(0xFF8A95A3);
const Color _kBorder = Color(0xFFD8DEE6);
const Color _kAccent = Color(0xFF2E5BFF);
const Color _kAccentSoft = Color(0xFFE1E9FF);
const Color _kHero = Color(0xFF101A2E);
const Color _kHeroAlt = Color(0xFF1B2D55);
const Color _kSwatchA = Color(0xFF26A69A);
const Color _kSwatchB = Color(0xFFEF5350);
const Color _kSwatchC = Color(0xFFFFCA28);
const Color _kSwatchD = Color(0xFF7E57C2);

// ----------------------------------------------------------------------------
// Public entry: the only function D4rt looks for.
// ----------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ToggleablePainter Visual Deep Demo',
    theme: ThemeData(
      primaryColor: _kAccent,
      scaffoldBackgroundColor: _kBg,
      fontFamily: 'Roboto',
    ),
    home: Scaffold(
      backgroundColor: _kBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _PrivateHeroCard(),
              SizedBox(height: 28),
              _PrivateAnatomySection(),
              SizedBox(height: 28),
              _PrivateCheckboxFramesSection(),
              SizedBox(height: 28),
              _PrivateSwitchFramesSection(),
              SizedBox(height: 28),
              _PrivateRadioFramesSection(),
              SizedBox(height: 28),
              _PrivateReactionGallerySection(),
              SizedBox(height: 28),
              _PrivateColorMatrixSection(),
              SizedBox(height: 28),
              _PrivateSubclassFamilySection(),
              SizedBox(height: 28),
              _PrivateCustomPaintCodeSection(),
              SizedBox(height: 28),
              _PrivatePitfallsSection(),
              SizedBox(height: 28),
              _PrivateFooter(),
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================================
// SECTION 1 — Hero card.
// ============================================================================
class _PrivateHeroCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_kHero, _kHeroAlt],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF000000).withValues(alpha: 0.25),
            blurRadius: 22,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Color(0xFFFFFFFF).withValues(alpha: 0.25),
                    ),
                  ),
                  child: Text(
                    'flutter / material',
                    style: TextStyle(
                      color: Color(0xFFCBD8FF),
                      fontSize: 12,
                      letterSpacing: 1.4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 18),
                Text(
                  'ToggleablePainter',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'The abstract CustomPainter behind every classic Material '
                  'toggle. Owns position, reaction, focus and hover '
                  'animations together with the active / inactive / reaction '
                  '/ hover / focus color quintet, and re-paints itself the '
                  'moment any of them change.',
                  style: TextStyle(
                    color: Color(0xFFD7DEEC),
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 18),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _PrivateHeroChip(label: 'extends ChangeNotifier'),
                    _PrivateHeroChip(label: 'implements CustomPainter'),
                    _PrivateHeroChip(label: 'abstract paint(Canvas, Size)'),
                    _PrivateHeroChip(label: 'paintRadialReaction()'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 28),
          Expanded(
            flex: 2,
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF).withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Color(0xFFFFFFFF).withValues(alpha: 0.12),
                  ),
                ),
                child: CustomPaint(
                  painter: _PrivateHeroBackgroundPainter(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateHeroChip extends StatelessWidget {
  final String label;
  const _PrivateHeroChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF).withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xFFFFFFFF).withValues(alpha: 0.20),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Color(0xFFE6ECFA),
          fontSize: 12,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _PrivateHeroBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint glow = Paint()
      ..color = _kAccent.withValues(alpha: 0.35)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 28);
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.5),
      size.shortestSide * 0.32,
      glow,
    );
    final Paint ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Color(0xFFFFFFFF).withValues(alpha: 0.45);
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.5),
      size.shortestSide * 0.34,
      ring,
    );
    final Paint dot = Paint()..color = Colors.white;
    for (int i = 0; i < 12; i++) {
      final double a = (i / 12) * math.pi * 2;
      final double r = size.shortestSide * 0.42;
      final Offset p = Offset(
        size.width * 0.5 + math.cos(a) * r,
        size.height * 0.5 + math.sin(a) * r,
      );
      canvas.drawCircle(p, 2.4, dot);
    }
    final Paint check = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final Path checkPath = Path()
      ..moveTo(size.width * 0.36, size.height * 0.52)
      ..lineTo(size.width * 0.46, size.height * 0.62)
      ..lineTo(size.width * 0.66, size.height * 0.40);
    canvas.drawPath(checkPath, check);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================================================
// SECTION 2 — Anatomy of ToggleablePainter fields.
// ============================================================================
class _PrivateAnatomySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<_PrivateField> fields = [
      _PrivateField(
        name: 'position',
        type: 'Animation<double>',
        kind: 'animation',
        blurb: 'Toggle progress 0..1. Drives the on/off transition; the '
            'subclass interprets it (e.g. checkmark draw, thumb slide).',
      ),
      _PrivateField(
        name: 'reaction',
        type: 'Animation<double>',
        kind: 'animation',
        blurb: 'Tap reaction 0..1. Scales the radial ink splash drawn by '
            'paintRadialReaction.',
      ),
      _PrivateField(
        name: 'reactionFocusFade',
        type: 'Animation<double>',
        kind: 'animation',
        blurb: 'Fade-in level for the focus highlight (0..1).',
      ),
      _PrivateField(
        name: 'reactionHoverFade',
        type: 'Animation<double>',
        kind: 'animation',
        blurb: 'Fade-in level for the hover highlight (0..1).',
      ),
      _PrivateField(
        name: 'activeColor',
        type: 'Color',
        kind: 'color',
        blurb: 'Color for the "on" state (filled checkbox, thumb on, dot).',
      ),
      _PrivateField(
        name: 'inactiveColor',
        type: 'Color',
        kind: 'color',
        blurb: 'Color for the "off" state (border, track, ring).',
      ),
      _PrivateField(
        name: 'reactionColor',
        type: 'Color',
        kind: 'color',
        blurb: 'Splash color used while the indicator is active (on).',
      ),
      _PrivateField(
        name: 'inactiveReactionColor',
        type: 'Color',
        kind: 'color',
        blurb: 'Splash color used while the indicator is inactive (off).',
      ),
      _PrivateField(
        name: 'hoverColor',
        type: 'Color',
        kind: 'color',
        blurb: 'Faint disk shown under the indicator while pointer hovers.',
      ),
      _PrivateField(
        name: 'focusColor',
        type: 'Color',
        kind: 'color',
        blurb: 'Faint disk shown under the indicator while focused.',
      ),
      _PrivateField(
        name: 'splashRadius',
        type: 'double',
        kind: 'metric',
        blurb: 'Maximum radius of the radial reaction in logical pixels.',
      ),
      _PrivateField(
        name: 'downPosition',
        type: 'Offset?',
        kind: 'metric',
        blurb: 'Where the touch landed; null when there is no active touch.',
      ),
      _PrivateField(
        name: 'isFocused',
        type: 'bool',
        kind: 'flag',
        blurb: 'Whether the toggle currently has keyboard focus.',
      ),
      _PrivateField(
        name: 'isHovered',
        type: 'bool',
        kind: 'flag',
        blurb: 'Whether a pointer is currently hovering the toggle.',
      ),
    ];
    return _PrivateCard(
      title: 'Anatomy',
      subtitle: 'Every setter on ToggleablePainter swaps the listener and '
          'calls notifyListeners(); the CustomPaint repaints automatically.',
      child: Column(
        children: [
          for (final _PrivateField f in fields) _PrivateFieldRow(field: f),
        ],
      ),
    );
  }
}

class _PrivateField {
  final String name;
  final String type;
  final String kind;
  final String blurb;
  const _PrivateField({
    required this.name,
    required this.type,
    required this.kind,
    required this.blurb,
  });
}

class _PrivateFieldRow extends StatelessWidget {
  final _PrivateField field;
  const _PrivateFieldRow({required this.field});

  @override
  Widget build(BuildContext context) {
    Color kindColor;
    switch (field.kind) {
      case 'animation':
        kindColor = _kAccent;
        break;
      case 'color':
        kindColor = _kSwatchD;
        break;
      case 'metric':
        kindColor = _kSwatchA;
        break;
      default:
        kindColor = _kSwatchC;
    }
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Color(0xFFF8FAFD),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            padding: EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: kindColor.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              field.kind,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: kindColor,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(width: 14),
          SizedBox(
            width: 180,
            child: Text(
              field.name,
              style: TextStyle(
                color: _kInk,
                fontSize: 14,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            width: 170,
            child: Text(
              field.type,
              style: TextStyle(
                color: _kAccent,
                fontSize: 13,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              field.blurb,
              style: TextStyle(color: _kInkDim, fontSize: 13, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 3 — Checkbox: 5 frozen frames at position 0, 0.25, 0.5, 0.75, 1.
// ============================================================================
class _PrivateCheckboxFramesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<double> stops = [0.0, 0.25, 0.5, 0.75, 1.0];
    return _PrivateCard(
      title: 'Frozen frames: Checkbox',
      subtitle: 'Five static replicas of a Material checkbox at position '
          '0, 0.25, 0.5, 0.75 and 1. Drawn entirely by hand — no live '
          'animation, no real Checkbox widget.',
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (final double t in stops)
                _PrivateFrameTile(
                  label: 'pos = ${t.toStringAsFixed(2)}',
                  size: 64,
                  painter: _PrivateCheckboxFramePainter(
                    position: t,
                    activeColor: _kAccent,
                    inactiveColor: _kInkFaint,
                    fillColor: Colors.white,
                  ),
                ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kAccentSoft,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'In real Material code, _CheckboxPainter.paint() reads '
              'position.value and uses it to interpolate the box fill, '
              'border weight, and check-stroke length. We simulate the '
              'same idea here with a plain double.',
              style: TextStyle(color: _kInk, fontSize: 13, height: 1.45),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateFrameTile extends StatelessWidget {
  final String label;
  final double size;
  final CustomPainter painter;
  const _PrivateFrameTile({
    required this.label,
    required this.size,
    required this.painter,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size + 24,
          height: size + 24,
          decoration: BoxDecoration(
            color: Color(0xFFF8FAFD),
            border: Border.all(color: _kBorder),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: SizedBox(
            width: size,
            height: size,
            child: CustomPaint(painter: painter),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: _kInkDim,
            fontSize: 12,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }
}

class _PrivateCheckboxFramePainter extends CustomPainter {
  final double position;
  final Color activeColor;
  final Color inactiveColor;
  final Color fillColor;
  _PrivateCheckboxFramePainter({
    required this.position,
    required this.activeColor,
    required this.inactiveColor,
    required this.fillColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double t = position.clamp(0.0, 1.0);
    final Rect box = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width * 0.7,
      height: size.height * 0.7,
    );
    final RRect rrect = RRect.fromRectAndRadius(box, Radius.circular(3));
    final Color blended = Color.lerp(inactiveColor, activeColor, t)!;
    final Paint fill = Paint()
      ..color = Color.lerp(fillColor, activeColor, t)!;
    final Paint border = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = blended;
    canvas.drawRRect(rrect, fill);
    canvas.drawRRect(rrect, border);
    if (t > 0) {
      final Paint check = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.4
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;
      final Offset a = Offset(box.left + box.width * 0.22,
          box.top + box.height * 0.55);
      final Offset b = Offset(box.left + box.width * 0.42,
          box.top + box.height * 0.74);
      final Offset c = Offset(box.left + box.width * 0.78,
          box.top + box.height * 0.32);
      final Path path = Path()..moveTo(a.dx, a.dy);
      if (t < 0.5) {
        final double k = t / 0.5;
        final Offset mid =
            Offset(a.dx + (b.dx - a.dx) * k, a.dy + (b.dy - a.dy) * k);
        path.lineTo(mid.dx, mid.dy);
      } else {
        path.lineTo(b.dx, b.dy);
        final double k = (t - 0.5) / 0.5;
        final Offset mid =
            Offset(b.dx + (c.dx - b.dx) * k, b.dy + (c.dy - b.dy) * k);
        path.lineTo(mid.dx, mid.dy);
      }
      canvas.drawPath(path, check);
    }
  }

  @override
  bool shouldRepaint(covariant _PrivateCheckboxFramePainter old) {
    return old.position != position ||
        old.activeColor != activeColor ||
        old.inactiveColor != inactiveColor ||
        old.fillColor != fillColor;
  }
}

// ============================================================================
// SECTION 4 — Switch: 5 frozen frames.
// ============================================================================
class _PrivateSwitchFramesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<double> stops = [0.0, 0.25, 0.5, 0.75, 1.0];
    return _PrivateCard(
      title: 'Frozen frames: Switch',
      subtitle: 'Same idea, but the painter draws a track and a thumb that '
          'slides from left to right as position goes 0 -> 1.',
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (final double t in stops)
                _PrivateFrameTile(
                  label: 'pos = ${t.toStringAsFixed(2)}',
                  size: 70,
                  painter: _PrivateSwitchFramePainter(
                    position: t,
                    activeColor: _kAccent,
                    inactiveColor: _kInkFaint,
                  ),
                ),
            ],
          ),
          SizedBox(height: 16),
          _PrivateNoteBlock(
            text: 'The real _SwitchPainter additionally consults the '
                'theme-resolved colors and the thumb-image factories; here '
                'we keep it deliberately simple so the position math stays '
                'visible.',
          ),
        ],
      ),
    );
  }
}

class _PrivateSwitchFramePainter extends CustomPainter {
  final double position;
  final Color activeColor;
  final Color inactiveColor;
  _PrivateSwitchFramePainter({
    required this.position,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double t = position.clamp(0.0, 1.0);
    final double trackHeight = size.height * 0.4;
    final Rect track = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width * 0.85,
      height: trackHeight,
    );
    final Color trackColor =
        Color.lerp(inactiveColor, activeColor, t)!.withValues(alpha: 0.55);
    final Paint trackPaint = Paint()..color = trackColor;
    canvas.drawRRect(
      RRect.fromRectAndRadius(track, Radius.circular(trackHeight / 2)),
      trackPaint,
    );
    final double thumbR = trackHeight * 0.65;
    final double thumbX = track.left + thumbR + (track.width - thumbR * 2) * t;
    final Offset thumbCenter = Offset(thumbX, track.center.dy);
    final Paint thumbShadow = Paint()
      ..color = Color(0x33000000)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 2);
    canvas.drawCircle(thumbCenter.translate(0, 1), thumbR, thumbShadow);
    final Paint thumb = Paint()
      ..color = Color.lerp(Colors.white, activeColor, t * 0.85)!;
    canvas.drawCircle(thumbCenter, thumbR, thumb);
    final Paint thumbBorder = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Color(0xFFFFFFFF).withValues(alpha: 0.8);
    canvas.drawCircle(thumbCenter, thumbR, thumbBorder);
  }

  @override
  bool shouldRepaint(covariant _PrivateSwitchFramePainter old) {
    return old.position != position ||
        old.activeColor != activeColor ||
        old.inactiveColor != inactiveColor;
  }
}

// ============================================================================
// SECTION 5 — Radio: 5 frozen frames.
// ============================================================================
class _PrivateRadioFramesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<double> stops = [0.0, 0.25, 0.5, 0.75, 1.0];
    return _PrivateCard(
      title: 'Frozen frames: Radio',
      subtitle: 'Same five positions, this time interpreted as the radius '
          'of the inner dot inside an outer ring.',
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (final double t in stops)
                _PrivateFrameTile(
                  label: 'pos = ${t.toStringAsFixed(2)}',
                  size: 64,
                  painter: _PrivateRadioFramePainter(
                    position: t,
                    activeColor: _kAccent,
                    inactiveColor: _kInkFaint,
                  ),
                ),
            ],
          ),
          SizedBox(height: 16),
          _PrivateNoteBlock(
            text: 'Material\'s _RadioPainter also fades the ring color '
                'between inactiveColor and activeColor as position grows. '
                'We mirror that by lerping with t.',
          ),
        ],
      ),
    );
  }
}

class _PrivateRadioFramePainter extends CustomPainter {
  final double position;
  final Color activeColor;
  final Color inactiveColor;
  _PrivateRadioFramePainter({
    required this.position,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double t = position.clamp(0.0, 1.0);
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double outerR = size.shortestSide * 0.35;
    final Color ringColor = Color.lerp(inactiveColor, activeColor, t)!;
    final Paint ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = ringColor;
    canvas.drawCircle(center, outerR, ring);
    if (t > 0) {
      final double innerR = outerR * 0.55 * t;
      final Paint dot = Paint()..color = activeColor;
      canvas.drawCircle(center, innerR, dot);
    }
  }

  @override
  bool shouldRepaint(covariant _PrivateRadioFramePainter old) {
    return old.position != position ||
        old.activeColor != activeColor ||
        old.inactiveColor != inactiveColor;
  }
}

// ============================================================================
// SECTION 6 — Reaction ripple gallery (5 frozen splash states).
// ============================================================================
class _PrivateReactionGallerySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<double> stops = [0.0, 0.25, 0.5, 0.75, 1.0];
    return _PrivateCard(
      title: 'Reaction ripple gallery',
      subtitle: 'Five frozen states of the radial reaction (the splash) '
          'that ToggleablePainter.paintRadialReaction() would draw under '
          'the indicator. The inner dot represents the indicator itself.',
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (final double t in stops)
                _PrivateFrameTile(
                  label: 'reaction = ${t.toStringAsFixed(2)}',
                  size: 80,
                  painter: _PrivateReactionPainter(
                    reaction: t,
                    splashRadius: 30,
                    reactionColor: _kAccent,
                    indicatorColor: _kAccent,
                  ),
                ),
            ],
          ),
          SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _PrivateNoteBlock(
                  text: 'The splash radius interpolates 0 -> splashRadius. '
                      'The opacity follows a roughly parabolic curve that '
                      'fades back to zero by reaction = 1.',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _PrivateNoteBlock(
                  text: 'inactiveReactionColor is used while the toggle is '
                      'off; reactionColor while it is on — Material picks '
                      'between the two based on position.value.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PrivateReactionPainter extends CustomPainter {
  final double reaction;
  final double splashRadius;
  final Color reactionColor;
  final Color indicatorColor;
  _PrivateReactionPainter({
    required this.reaction,
    required this.splashRadius,
    required this.reactionColor,
    required this.indicatorColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double t = reaction.clamp(0.0, 1.0);
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double r = splashRadius * t;
    final double opacity = 1.0 - ((2.0 * t - 1.0) * (2.0 * t - 1.0));
    final Paint splash = Paint()
      ..color = reactionColor.withValues(alpha: 0.35 * opacity);
    canvas.drawCircle(center, r, splash);
    final Paint indicator = Paint()..color = indicatorColor;
    canvas.drawCircle(center, 7, indicator);
    final Paint ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..color = reactionColor.withValues(alpha: 0.6);
    canvas.drawCircle(center, r, ring);
  }

  @override
  bool shouldRepaint(covariant _PrivateReactionPainter old) {
    return old.reaction != reaction ||
        old.splashRadius != splashRadius ||
        old.reactionColor != reactionColor ||
        old.indicatorColor != indicatorColor;
  }
}

// ============================================================================
// SECTION 7 — Color matrix (8 cards).
// ============================================================================
class _PrivateColorMatrixSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<_PrivateColorCombo> combos = [
      _PrivateColorCombo(
        title: 'Default',
        active: _kAccent,
        inactive: _kInkFaint,
        reaction: _kAccent,
        hover: _kAccent,
        focus: _kAccent,
      ),
      _PrivateColorCombo(
        title: 'Brand teal',
        active: _kSwatchA,
        inactive: _kInkFaint,
        reaction: _kSwatchA,
        hover: _kSwatchA,
        focus: _kSwatchA,
      ),
      _PrivateColorCombo(
        title: 'Danger',
        active: _kSwatchB,
        inactive: _kInkFaint,
        reaction: _kSwatchB,
        hover: _kSwatchB,
        focus: _kSwatchB,
      ),
      _PrivateColorCombo(
        title: 'Sunshine',
        active: _kSwatchC,
        inactive: _kInkFaint,
        reaction: _kSwatchC,
        hover: _kSwatchC,
        focus: _kSwatchC,
      ),
      _PrivateColorCombo(
        title: 'Mixed splash',
        active: _kAccent,
        inactive: _kInkFaint,
        reaction: _kSwatchB,
        hover: _kAccent,
        focus: _kAccent,
      ),
      _PrivateColorCombo(
        title: 'Mixed hover',
        active: _kAccent,
        inactive: _kInkFaint,
        reaction: _kAccent,
        hover: _kSwatchC,
        focus: _kAccent,
      ),
      _PrivateColorCombo(
        title: 'Mixed focus',
        active: _kAccent,
        inactive: _kInkFaint,
        reaction: _kAccent,
        hover: _kAccent,
        focus: _kSwatchD,
      ),
      _PrivateColorCombo(
        title: 'Calm gray',
        active: _kInk,
        inactive: _kInkFaint,
        reaction: _kInk,
        hover: _kInk,
        focus: _kInk,
      ),
    ];
    return _PrivateCard(
      title: 'Color matrix',
      subtitle: 'Eight combinations of activeColor, inactiveColor, '
          'reactionColor, hoverColor and focusColor — each card shows the '
          'indicator at position 1 with a focus and a hover halo behind it.',
      child: Wrap(
        spacing: 14,
        runSpacing: 14,
        children: [for (final c in combos) _PrivateColorComboCard(combo: c)],
      ),
    );
  }
}

class _PrivateColorCombo {
  final String title;
  final Color active;
  final Color inactive;
  final Color reaction;
  final Color hover;
  final Color focus;
  const _PrivateColorCombo({
    required this.title,
    required this.active,
    required this.inactive,
    required this.reaction,
    required this.hover,
    required this.focus,
  });
}

class _PrivateColorComboCard extends StatelessWidget {
  final _PrivateColorCombo combo;
  const _PrivateColorComboCard({required this.combo});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Color(0xFFF8FAFD),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            combo.title,
            style: TextStyle(
              color: _kInk,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: CustomPaint(
                painter: _PrivateColorComboPainter(combo: combo),
              ),
            ),
          ),
          SizedBox(height: 10),
          _PrivateSwatchLine(label: 'active', color: combo.active),
          _PrivateSwatchLine(label: 'inactive', color: combo.inactive),
          _PrivateSwatchLine(label: 'reaction', color: combo.reaction),
          _PrivateSwatchLine(label: 'hover', color: combo.hover),
          _PrivateSwatchLine(label: 'focus', color: combo.focus),
        ],
      ),
    );
  }
}

class _PrivateSwatchLine extends StatelessWidget {
  final String label;
  final Color color;
  const _PrivateSwatchLine({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: _kBorder),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: _kInkDim,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateColorComboPainter extends CustomPainter {
  final _PrivateColorCombo combo;
  _PrivateColorComboPainter({required this.combo});

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final Paint focusHalo = Paint()
      ..color = combo.focus.withValues(alpha: 0.18);
    canvas.drawCircle(center, size.shortestSide * 0.45, focusHalo);
    final Paint hoverHalo = Paint()
      ..color = combo.hover.withValues(alpha: 0.30);
    canvas.drawCircle(center, size.shortestSide * 0.34, hoverHalo);
    final Paint reactionRing = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..color = combo.reaction.withValues(alpha: 0.7);
    canvas.drawCircle(center, size.shortestSide * 0.40, reactionRing);
    // Indicator: a filled rounded square with active fill, inactive border.
    final Rect box = Rect.fromCenter(
      center: center,
      width: size.shortestSide * 0.36,
      height: size.shortestSide * 0.36,
    );
    final RRect r = RRect.fromRectAndRadius(box, Radius.circular(4));
    canvas.drawRRect(r, Paint()..color = combo.active);
    canvas.drawRRect(
      r,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = combo.inactive,
    );
    // Checkmark in white.
    final Paint check = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final Path p = Path()
      ..moveTo(box.left + box.width * 0.22, box.top + box.height * 0.55)
      ..lineTo(box.left + box.width * 0.42, box.top + box.height * 0.74)
      ..lineTo(box.left + box.width * 0.78, box.top + box.height * 0.32);
    canvas.drawPath(p, check);
  }

  @override
  bool shouldRepaint(covariant _PrivateColorComboPainter old) {
    return old.combo != combo;
  }
}

// ============================================================================
// SECTION 8 — Subclass family table.
// ============================================================================
class _PrivateSubclassFamilySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<_PrivateSubclassRow> rows = [
      _PrivateSubclassRow(
        name: '_CheckboxPainter',
        owner: 'Checkbox',
        positionMeans: 'check-stroke draw progress',
        usesReaction: 'yes',
        notes: 'Also draws the optional dash for tristate.',
      ),
      _PrivateSubclassRow(
        name: '_SwitchPainter',
        owner: 'Switch (Material 2)',
        positionMeans: 'thumb x-position 0..1',
        usesReaction: 'yes',
        notes: 'Track + thumb + optional thumb image.',
      ),
      _PrivateSubclassRow(
        name: '_RadioPainter',
        owner: 'Radio',
        positionMeans: 'inner dot radius 0..max',
        usesReaction: 'yes',
        notes: 'Outer ring color lerps with position.',
      ),
    ];
    return _PrivateCard(
      title: 'Subclass family',
      subtitle: 'The three named ToggleablePainter subclasses inside '
          'flutter/material — each one re-uses the same field set but '
          'gives "position" its own meaning.',
      child: Column(
        children: [
          _PrivateSubclassHeader(),
          for (final r in rows) _PrivateSubclassRowView(row: r),
        ],
      ),
    );
  }
}

class _PrivateSubclassRow {
  final String name;
  final String owner;
  final String positionMeans;
  final String usesReaction;
  final String notes;
  const _PrivateSubclassRow({
    required this.name,
    required this.owner,
    required this.positionMeans,
    required this.usesReaction,
    required this.notes,
  });
}

class _PrivateSubclassHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _kInk,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Row(
        children: [
          _PrivateHeaderCell(text: 'painter', flex: 2),
          _PrivateHeaderCell(text: 'used by', flex: 2),
          _PrivateHeaderCell(text: 'position means', flex: 3),
          _PrivateHeaderCell(text: 'reaction', flex: 1),
          _PrivateHeaderCell(text: 'notes', flex: 3),
        ],
      ),
    );
  }
}

class _PrivateHeaderCell extends StatelessWidget {
  final String text;
  final int flex;
  const _PrivateHeaderCell({required this.text, required this.flex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

class _PrivateSubclassRowView extends StatelessWidget {
  final _PrivateSubclassRow row;
  const _PrivateSubclassRowView({required this.row});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Color(0xFFF8FAFD),
        border: Border(bottom: BorderSide(color: _kBorder)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              row.name,
              style: TextStyle(
                color: _kAccent,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              row.owner,
              style: TextStyle(color: _kInk, fontSize: 13),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              row.positionMeans,
              style: TextStyle(color: _kInkDim, fontSize: 13),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              row.usesReaction,
              style: TextStyle(
                color: _kSwatchA,
                fontSize: 12,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              row.notes,
              style: TextStyle(color: _kInkDim, fontSize: 12, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 9 — Code listing: how a custom toggleable painter overrides paint().
// ============================================================================
class _PrivateCustomPaintCodeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<_PrivateCodeLine> lines = [
      _PrivateCodeLine('class _StarTogglePainter extends ToggleablePainter {',
          _PrivateCodeKind.keyword),
      _PrivateCodeLine('  @override', _PrivateCodeKind.annotation),
      _PrivateCodeLine('  void paint(Canvas canvas, Size size) {',
          _PrivateCodeKind.keyword),
      _PrivateCodeLine('    final double t = position.value;',
          _PrivateCodeKind.code),
      _PrivateCodeLine('    final Offset c = size.center(Offset.zero);',
          _PrivateCodeKind.code),
      _PrivateCodeLine('    final Color tint =',
          _PrivateCodeKind.code),
      _PrivateCodeLine(
          '        Color.lerp(inactiveColor, activeColor, t)!;',
          _PrivateCodeKind.code),
      _PrivateCodeLine('    final Paint star = Paint()..color = tint;',
          _PrivateCodeKind.code),
      _PrivateCodeLine('    if (isHovered)', _PrivateCodeKind.keyword),
      _PrivateCodeLine(
          '      canvas.drawCircle(c, splashRadius,',
          _PrivateCodeKind.code),
      _PrivateCodeLine(
          '          Paint()..color = hoverColor.withValues(alpha: 0.12));',
          _PrivateCodeKind.code),
      _PrivateCodeLine('    if (isFocused)', _PrivateCodeKind.keyword),
      _PrivateCodeLine(
          '      canvas.drawCircle(c, splashRadius,',
          _PrivateCodeKind.code),
      _PrivateCodeLine(
          '          Paint()..color = focusColor.withValues(alpha: 0.18));',
          _PrivateCodeKind.code),
      _PrivateCodeLine('    paintRadialReaction(canvas: canvas, offset: c);',
          _PrivateCodeKind.code),
      _PrivateCodeLine('    canvas.drawPath(_starPath(c, t), star);',
          _PrivateCodeKind.code),
      _PrivateCodeLine('  }', _PrivateCodeKind.keyword),
      _PrivateCodeLine('}', _PrivateCodeKind.keyword),
    ];
    return _PrivateCard(
      title: 'Sketch: a custom ToggleablePainter',
      subtitle: 'A minimal subclass that draws a star which fades from '
          'inactive to active color. The reaction splash, hover halo and '
          'focus halo are reused via paintRadialReaction and the existing '
          'hover/focus colors.',
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFF101826),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final l in lines) _PrivateCodeLineView(line: l),
          ],
        ),
      ),
    );
  }
}

enum _PrivateCodeKind { keyword, annotation, code }

class _PrivateCodeLine {
  final String text;
  final _PrivateCodeKind kind;
  const _PrivateCodeLine(this.text, this.kind);
}

class _PrivateCodeLineView extends StatelessWidget {
  final _PrivateCodeLine line;
  const _PrivateCodeLineView({required this.line});

  @override
  Widget build(BuildContext context) {
    Color c;
    switch (line.kind) {
      case _PrivateCodeKind.keyword:
        c = Color(0xFFC792EA);
        break;
      case _PrivateCodeKind.annotation:
        c = Color(0xFFFFCB6B);
        break;
      case _PrivateCodeKind.code:
        c = Color(0xFFEEFFFF);
        break;
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1),
      child: Text(
        line.text,
        style: TextStyle(
          color: c,
          fontSize: 13,
          fontFamily: 'monospace',
          height: 1.45,
        ),
      ),
    );
  }
}

// ============================================================================
// SECTION 10 — Pitfalls.
// ============================================================================
class _PrivatePitfallsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<_PrivatePitfall> pitfalls = [
      _PrivatePitfall(
        title: 'Forgetting to call notifyListeners()',
        body: 'If you add new fields to a ToggleablePainter subclass and '
            'forget to call notifyListeners() in their setters, the '
            'CustomPaint will not repaint when they change.',
      ),
      _PrivatePitfall(
        title: 'Reading position.value off-frame',
        body: 'position is an Animation<double>; reading position.value '
            'outside paint() (or without listening) may give a stale value '
            'between ticks.',
      ),
      _PrivatePitfall(
        title: 'Mixing colors with .withOpacity',
        body: 'Prefer Color.withValues(alpha: ...) over the deprecated '
            'withOpacity for accurate color-space-aware blending.',
      ),
      _PrivatePitfall(
        title: 'Drawing outside the size',
        body: 'paintRadialReaction with a large splashRadius may overflow '
            'size; clip the canvas or pick a sensible radius for your '
            'indicator size.',
      ),
      _PrivatePitfall(
        title: 'Not implementing shouldRepaint correctly',
        body: 'ToggleablePainter\'s default uses ChangeNotifier comparison '
            'via the _RepaintingPainter mechanism — overriding it manually '
            'with a wrong comparison breaks repaints on color changes.',
      ),
      _PrivatePitfall(
        title: 'Hard-coding theme colors',
        body: 'activeColor, inactiveColor and reaction colors should come '
            'from MaterialState resolvers / the theme so the toggle '
            'follows light/dark and density automatically.',
      ),
    ];
    return _PrivateCard(
      title: 'Pitfalls',
      subtitle: 'Things that bite when you write or extend a '
          'ToggleablePainter subclass.',
      child: Column(
        children: [for (final p in pitfalls) _PrivatePitfallRow(pitfall: p)],
      ),
    );
  }
}

class _PrivatePitfall {
  final String title;
  final String body;
  const _PrivatePitfall({required this.title, required this.body});
}

class _PrivatePitfallRow extends StatelessWidget {
  final _PrivatePitfall pitfall;
  const _PrivatePitfallRow({required this.pitfall});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Color(0xFFFFF7E6),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFFF1C97B)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Color(0xFFF1C97B),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              '!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pitfall.title,
                  style: TextStyle(
                    color: _kInk,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  pitfall.body,
                  style: TextStyle(
                    color: _kInkDim,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 11 — Footer.
// ============================================================================
class _PrivateFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _kInk,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: _kAccent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: CustomPaint(
              painter: _PrivateFooterMarkPainter(),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ToggleablePainter — visual deep demo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Static, sandbox-friendly walkthrough — no live '
                  'animations, no real Checkbox/Switch/Radio widgets.',
                  style: TextStyle(
                    color: Color(0xFFC8D1E0),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Text(
            'tom_d4rt_flutter_ast',
            style: TextStyle(
              color: Color(0xFF8A95A3),
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateFooterMarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint check = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final Path p = Path()
      ..moveTo(size.width * 0.22, size.height * 0.55)
      ..lineTo(size.width * 0.42, size.height * 0.74)
      ..lineTo(size.width * 0.78, size.height * 0.32);
    canvas.drawPath(p, check);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================================================
// Reusable card / note components.
// ============================================================================
class _PrivateCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;
  const _PrivateCard({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kBorder),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF000000).withValues(alpha: 0.04),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: _kInk,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
          SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(color: _kInkDim, fontSize: 13, height: 1.5),
          ),
          SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}

class _PrivateNoteBlock extends StatelessWidget {
  final String text;
  const _PrivateNoteBlock({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kAccentSoft,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kAccent.withValues(alpha: 0.25)),
      ),
      child: Text(
        text,
        style: TextStyle(color: _kInk, fontSize: 13, height: 1.5),
      ),
    );
  }
}
