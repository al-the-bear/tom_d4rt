// ignore_for_file: avoid_print, unused_local_variable
// =============================================================================
//   ScaleTransition — Deep Visual Demo
// -----------------------------------------------------------------------------
// A frozen-frame tour of Flutter's ScaleTransition widget. We never spin up an
// AnimationController; instead we stamp out individual moments of the scale
// animation by feeding each ScaleTransition an AlwaysStoppedAnimation<double>
// with a hand-picked value. The result is a static, deterministic page that
// nevertheless illustrates how the transition flows from t=0 to t=1 (and
// beyond).
//
// Palette
//   ink          — charcoal background for cards
//   ember        — amber/orange accent for scale rails
//   parchment    — cream surface
//   sky          — cyan for callouts
//
// Sections
//   1.  Hero header
//   2.  Concept
//   3.  Anatomy
//   4.  Frame strip (9 frozen frames 0.0 .. 2.0)
//   5.  Alignment origin grid (3 x 3)
//   6.  Filter quality
//   7.  ScaleTransition vs Transform.scale
//   8.  Composition (Fade > Rotation > Scale)
//   9.  Curve studies
//  10.  Real-world recipes
//  11.  Comparison table
//  12.  Glossary
//  13.  Epilogue
// =============================================================================

import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// Palette
// -----------------------------------------------------------------------------

const Color _ink = Color(0xFF1F2430);
const Color _ember = Color(0xFFFFAB40);
const Color _emberDeep = Color(0xFFFF6F00);
const Color _parchment = Color(0xFFFFF8E1);
const Color _sky = Color(0xFF4DD0E1);
const Color _skyDeep = Color(0xFF00838F);
const Color _muted = Color(0xFF6D7787);
const Color _outline = Color(0xFFD7CCC8);
const Color _good = Color(0xFF66BB6A);
const Color _warn = Color(0xFFEF5350);

// -----------------------------------------------------------------------------
// Text styles
// -----------------------------------------------------------------------------

const TextStyle _kTitle = TextStyle(
  fontSize: 26.0,
  fontWeight: FontWeight.w800,
  color: _ink,
  letterSpacing: 0.4,
);

const TextStyle _kSection = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w700,
  color: _ink,
);

const TextStyle _kSub = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w600,
  color: _emberDeep,
  letterSpacing: 1.2,
);

const TextStyle _kBody = TextStyle(
  fontSize: 13.5,
  color: _ink,
  height: 1.45,
);

const TextStyle _kLabel = TextStyle(
  fontSize: 11.0,
  fontWeight: FontWeight.w600,
  color: _muted,
);

const TextStyle _kFrameLabel = TextStyle(
  fontSize: 11.0,
  fontWeight: FontWeight.w700,
  color: _ink,
);

// -----------------------------------------------------------------------------
// Tiny reusable building blocks
// -----------------------------------------------------------------------------

Widget _card({required Widget child, Color background = _parchment}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: background,
      border: Border.all(color: _outline),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: child,
  );
}

Widget _kicker(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4.0),
    child: Text(text.toUpperCase(), style: _kSub),
  );
}

Widget _para(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 6.0),
    child: Text(text, style: _kBody),
  );
}

Widget _bullet(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 4.0, left: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('•  ', style: _kBody),
        Expanded(child: Text(text, style: _kBody)),
      ],
    ),
  );
}

Widget _divider() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    height: 1.0,
    color: _outline,
  );
}

Widget _chip(String label, {Color color = _ember}) {
  return Container(
    margin: const EdgeInsets.only(right: 6.0, bottom: 6.0),
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.22),
      border: Border.all(color: color),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w700,
        color: _ink,
      ),
    ),
  );
}

// =============================================================================
// 1. Hero
// =============================================================================

Widget _hero() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [_ink, _emberDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: _parchment,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Icon(Icons.zoom_out_map, color: _emberDeep),
            ),
            const SizedBox(width: 12.0),
            const Expanded(
              child: Text(
                'ScaleTransition — Deep Dive',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w800,
                  color: _parchment,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'A study of how the ScaleTransition widget projects an '
          'Animation<double> onto the local Matrix4 of its subtree.',
          style: TextStyle(
            fontSize: 13.5,
            color: _parchment,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          children: [
            _chip('frozen frames', color: _sky),
            _chip('alignment grid', color: _sky),
            _chip('curve studies', color: _sky),
            _chip('analyzer clean', color: _sky),
            _chip('no controllers', color: _sky),
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// 2. Concept
// =============================================================================

Widget _conceptSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _kicker('section 02'),
        const Text('What ScaleTransition actually does', style: _kSection),
        _para(
          'ScaleTransition is a thin wrapper around AnimatedBuilder that '
          'rebuilds its child every time the supplied Animation<double> '
          'ticks, applying a uniform x/y scale via a Matrix4.diagonal3Values '
          'transform anchored at the configured alignment.',
        ),
        _para(
          'Because the transform happens *after* layout, the child still '
          'occupies its original size in the parent. Only paint is altered: '
          'the child draws bigger or smaller around the alignment origin, '
          'potentially overlapping siblings or being clipped by ancestors.',
        ),
        _divider(),
        _bullet('scale: an Animation<double> — usually 0.0 .. 1.0, but any '
            'non-negative value works (and negative flips).'),
        _bullet('alignment: where on the child the scale is anchored '
            '(default Alignment.center).'),
        _bullet('filterQuality: optional ImageFilterQuality for raster '
            'children when the scale induces resampling.'),
        _bullet('child: the subtree to scale.'),
        _divider(),
        Container(
          padding: const EdgeInsets.all(10.0),
          color: _ink,
          child: const Text(
            'ScaleTransition(\n'
            '  scale: animation,         // Animation<double>\n'
            '  alignment: Alignment.center,\n'
            '  filterQuality: FilterQuality.low,\n'
            '  child: someChild,\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: _parchment,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// 3. Anatomy
// =============================================================================

Widget _anatomyRow(String label, String description, IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            color: _ember.withValues(alpha: 0.25),
            border: Border.all(color: _emberDeep),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Icon(icon, size: 18.0, color: _emberDeep),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: _kFrameLabel),
              Text(description, style: _kBody),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _anatomySection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _kicker('section 03'),
        const Text('Anatomy of a ScaleTransition', style: _kSection),
        const SizedBox(height: 6.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: _ink,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Animation<double>  ──►  ScaleTransition  ──►  Transform',
                style: TextStyle(
                  color: _ember,
                  fontFamily: 'monospace',
                  fontSize: 13.0,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                '         (0.0 .. 1.0+)              (Matrix4 + paint)',
                style: TextStyle(
                  color: _parchment,
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        _anatomyRow(
          'scale (Animation<double>)',
          'Drives the size multiplier. Read each frame, projected onto x and '
          'y simultaneously. 0.0 collapses the child; 1.0 leaves it unchanged.',
          Icons.linear_scale,
        ),
        _anatomyRow(
          'alignment (Alignment)',
          'The fixed point that does not move while scaling. Imagine a pin '
          'stuck through the child at this offset.',
          Icons.center_focus_strong,
        ),
        _anatomyRow(
          'filterQuality (FilterQuality?)',
          'Hint for the engine when the resulting paint involves resampling '
          'pixels — most visible on bitmap children.',
          Icons.tune,
        ),
        _anatomyRow(
          'child (Widget)',
          'The actual subtree that gets repainted at the new size.',
          Icons.widgets,
        ),
        _anatomyRow(
          'source AnimationController',
          'In real apps, a controller drives `scale`. Here we replace it '
          'with AlwaysStoppedAnimation<double> to freeze each value.',
          Icons.settings_input_component,
        ),
      ],
    ),
  );
}

// =============================================================================
// 4. Frame strip — 9 frozen frames at distinct t values
// =============================================================================

Widget _scaledStarBox(double t, Color color) {
  return SizedBox(
    width: 80.0,
    height: 80.0,
    child: Center(
      child: ScaleTransition(
        scale: AlwaysStoppedAnimation<double>(t),
        alignment: Alignment.center,
        child: Container(
          width: 48.0,
          height: 48.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _ink),
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.star, color: _ink, size: 22.0),
        ),
      ),
    ),
  );
}

Widget _labelledFrame(double t, Color color) {
  return Column(
    children: [
      Container(
        width: 84.0,
        height: 84.0,
        decoration: BoxDecoration(
          color: _parchment,
          border: Border.all(color: _outline),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: _scaledStarBox(t, color),
      ),
      const SizedBox(height: 4.0),
      Text('t=${t.toStringAsFixed(3)}', style: _kFrameLabel),
    ],
  );
}

Widget _frameStripSection() {
  const List<double> ts = <double>[
    0.0,
    0.125,
    0.25,
    0.5,
    0.75,
    1.0,
    1.25,
    1.5,
    2.0,
  ];
  const List<Color> palette = <Color>[
    _ember,
    _ember,
    _ember,
    _ember,
    _ember,
    _emberDeep,
    _sky,
    _sky,
    _skyDeep,
  ];
  final List<Widget> frames = <Widget>[];
  for (int i = 0; i < ts.length; i++) {
    frames.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: _labelledFrame(ts[i], palette[i]),
    ));
  }
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _kicker('section 04'),
        const Text('Frozen frames at nine values of t', style: _kSection),
        _para(
          'Each box renders the same 48 x 48 star, but the ScaleTransition '
          'inside is fed a different AlwaysStoppedAnimation<double>. Read '
          'them left-to-right as if the controller were stepping forward.',
        ),
        const SizedBox(height: 10.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: frames),
        ),
        _divider(),
        _para(
          't=0.0 collapses the child to a single point — invisible. '
          't=1.0 is the natural rest size. Values above 1.0 over-scale: the '
          'child paints outside its allocated 80 x 80 cell and may clip '
          'against the cell border.',
        ),
        _bullet('Hit-testing still uses the original layout box.'),
        _bullet('Children beyond t=1.0 only "look" bigger; they do not '
            'occupy more layout space.'),
        _bullet('A negative value (not shown) flips horizontally and '
            'vertically simultaneously.'),
      ],
    ),
  );
}

// =============================================================================
// 5. Alignment origin grid — 3 x 3
// =============================================================================

Widget _alignedCell(Alignment a, String label) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Column(
      children: [
        Container(
          width: 90.0,
          height: 90.0,
          decoration: BoxDecoration(
            color: _parchment,
            border: Border.all(color: _outline),
            borderRadius: BorderRadius.circular(6.0),
          ),
          alignment: Alignment.center,
          child: ScaleTransition(
            scale: const AlwaysStoppedAnimation<double>(0.45),
            alignment: a,
            child: Container(
              width: 78.0,
              height: 78.0,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_ember, _emberDeep],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.favorite, color: _parchment, size: 22.0),
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(label, style: _kFrameLabel),
      ],
    ),
  );
}

Widget _alignmentGridSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _kicker('section 05'),
        const Text('Alignment grid — where the scale pivots', style: _kSection),
        _para(
          'All nine cells use scale=0.45. Only the alignment changes. '
          'Because the child is scaled around the alignment point, the '
          'collapsed result hugs a different corner each time.',
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _alignedCell(Alignment.topLeft, 'topLeft'),
            _alignedCell(Alignment.topCenter, 'topCenter'),
            _alignedCell(Alignment.topRight, 'topRight'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _alignedCell(Alignment.centerLeft, 'centerLeft'),
            _alignedCell(Alignment.center, 'center'),
            _alignedCell(Alignment.centerRight, 'centerRight'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _alignedCell(Alignment.bottomLeft, 'bottomLeft'),
            _alignedCell(Alignment.bottomCenter, 'bottomCenter'),
            _alignedCell(Alignment.bottomRight, 'bottomRight'),
          ],
        ),
        _divider(),
        _bullet('Alignment.center (the default) shrinks "in place".'),
        _bullet('Corner alignments make the child cling to a corner as it '
            'shrinks — useful for pop-up menus, tooltips, and FAB reveals.'),
        _bullet('Alignment may be any non-quantised value; '
            'Alignment(0.3, -0.7) is perfectly fine.'),
      ],
    ),
  );
}

// =============================================================================
// 6. FilterQuality
// =============================================================================

Widget _qualityFrame(FilterQuality q, String label, Color color) {
  return Padding(
    padding: const EdgeInsets.all(6.0),
    child: Column(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            color: _parchment,
            border: Border.all(color: _outline),
            borderRadius: BorderRadius.circular(6.0),
          ),
          alignment: Alignment.center,
          child: ScaleTransition(
            scale: const AlwaysStoppedAnimation<double>(1.8),
            filterQuality: q,
            child: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6.0),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.bolt,
                size: 26.0,
                color: _parchment,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(label, style: _kFrameLabel),
      ],
    ),
  );
}

Widget _filterQualitySection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _kicker('section 06'),
        const Text('FilterQuality on the same 1.8x frame', style: _kSection),
        _para(
          'When the scale exceeds 1.0 and the child involves rasterised '
          'pixels (e.g. images, RepaintBoundary outputs), FilterQuality '
          'controls how the engine resamples. With pure vector content '
          'like Container + Icon, the visual difference can be subtle, but '
          'the GPU still receives the hint.',
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _qualityFrame(FilterQuality.low, 'low', _ember),
            _qualityFrame(FilterQuality.medium, 'medium', _emberDeep),
            _qualityFrame(FilterQuality.high, 'high', _skyDeep),
          ],
        ),
        _divider(),
        _bullet('low: nearest-neighbour, fastest, blocky.'),
        _bullet('medium: bilinear-like, good default.'),
        _bullet('high: mipmap / trilinear-style, slowest, smoothest.'),
        _bullet('none: skip resampling entirely; for crisp pixel art.'),
      ],
    ),
  );
}

// =============================================================================
// 7. ScaleTransition vs Transform.scale
// =============================================================================

Widget _scaleSideBySide() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Column(
        children: [
          Container(
            width: 130.0,
            height: 130.0,
            decoration: BoxDecoration(
              color: _parchment,
              border: Border.all(color: _outline),
            ),
            alignment: Alignment.center,
            child: ScaleTransition(
              scale: const AlwaysStoppedAnimation<double>(1.4),
              child: Container(
                width: 60.0,
                height: 60.0,
                color: _ember,
                alignment: Alignment.center,
                child: const Text('ST', style: _kFrameLabel),
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          const Text('ScaleTransition(1.4)', style: _kFrameLabel),
        ],
      ),
      Column(
        children: [
          Container(
            width: 130.0,
            height: 130.0,
            decoration: BoxDecoration(
              color: _parchment,
              border: Border.all(color: _outline),
            ),
            alignment: Alignment.center,
            child: Transform.scale(
              scale: 1.4,
              child: Container(
                width: 60.0,
                height: 60.0,
                color: _sky,
                alignment: Alignment.center,
                child: const Text('TS', style: _kFrameLabel),
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          const Text('Transform.scale(1.4)', style: _kFrameLabel),
        ],
      ),
    ],
  );
}

Widget _vsTransformSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _kicker('section 07'),
        const Text('ScaleTransition vs Transform.scale', style: _kSection),
        _para(
          'Visually identical for a fixed value — both ride on top of the '
          'same Matrix4.diagonal3Values pipeline. The interesting difference '
          'is *who reads the value*.',
        ),
        const SizedBox(height: 10.0),
        _scaleSideBySide(),
        _divider(),
        _bullet('ScaleTransition: rebuilds the descendant subtree on every '
            'tick of an Animation<double>. Ideal inside transition heroes '
            'and route reveals where a controller is already in scope.'),
        _bullet('Transform.scale: takes a literal double. Good for static '
            'visual tweaks, or when you drive the value yourself with '
            'setState/ValueListenable.'),
        _bullet('Performance: ScaleTransition is slightly cheaper inside '
            'an animation because it skips one layer of AnimatedBuilder you '
            'would otherwise have to wire up by hand.'),
        _bullet('Both stop being free once the child involves a saveLayer; '
            'profile when in doubt.'),
      ],
    ),
  );
}

// =============================================================================
// 8. Composition — Fade > Rotation > Scale
// =============================================================================

Widget _compositionFrame(double s, double r, double o, String label) {
  return Padding(
    padding: const EdgeInsets.all(6.0),
    child: Column(
      children: [
        Container(
          width: 110.0,
          height: 110.0,
          decoration: BoxDecoration(
            color: _parchment,
            border: Border.all(color: _outline),
            borderRadius: BorderRadius.circular(6.0),
          ),
          alignment: Alignment.center,
          child: FadeTransition(
            opacity: AlwaysStoppedAnimation<double>(o),
            child: RotationTransition(
              turns: AlwaysStoppedAnimation<double>(r),
              child: ScaleTransition(
                scale: AlwaysStoppedAnimation<double>(s),
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: _emberDeep,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.local_florist,
                    color: _parchment,
                    size: 26.0,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(label, style: _kFrameLabel),
      ],
    ),
  );
}

Widget _compositionSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _kicker('section 08'),
        const Text('Composition: Fade > Rotation > Scale', style: _kSection),
        _para(
          'Each frame nests three frozen animations. The outer FadeTransition '
          'controls opacity, the middle RotationTransition handles turns, '
          'and the inner ScaleTransition handles size. All driven by '
          'AlwaysStoppedAnimation<double> so the moment is frozen.',
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _compositionFrame(0.2, 0.00, 0.2, 'start'),
            _compositionFrame(0.6, 0.15, 0.7, 'mid'),
            _compositionFrame(1.0, 0.30, 1.0, 'end'),
          ],
        ),
        _divider(),
        _bullet('Order matters: putting FadeTransition outermost ensures '
            'opacity applies to the already-scaled subtree.'),
        _bullet('Reversing the nesting (Scale > Rotation > Fade) yields the '
            'same visuals here because all are uniform transforms, but '
            'compositing layers may differ.'),
        _bullet('Each transition is independent — they can share or differ '
            'in source controllers in a real app.'),
      ],
    ),
  );
}

// =============================================================================
// 9. Curve studies
// =============================================================================

Widget _curveFrame(Curve curve, double t, String label) {
  final double s = curve.transform(t).clamp(0.0, 2.0);
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0),
    child: Column(
      children: [
        Container(
          width: 70.0,
          height: 70.0,
          decoration: BoxDecoration(
            color: _parchment,
            border: Border.all(color: _outline),
            borderRadius: BorderRadius.circular(6.0),
          ),
          alignment: Alignment.center,
          child: ScaleTransition(
            scale: AlwaysStoppedAnimation<double>(s),
            child: Container(
              width: 36.0,
              height: 36.0,
              decoration: const BoxDecoration(
                color: _skyDeep,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          '$label\n${s.toStringAsFixed(2)}',
          textAlign: TextAlign.center,
          style: _kLabel,
        ),
      ],
    ),
  );
}

Widget _curveRow(String name, Curve curve) {
  const List<double> ts = <double>[0.0, 0.2, 0.4, 0.6, 0.8, 1.0];
  final List<Widget> frames = <Widget>[];
  for (final double t in ts) {
    frames.add(_curveFrame(curve, t, 't=${t.toStringAsFixed(1)}'));
  }
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: _kFrameLabel),
        const SizedBox(height: 4.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: frames),
        ),
      ],
    ),
  );
}

Widget _curveStudiesSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _kicker('section 09'),
        const Text('Curve studies — same t, different rhythm', style: _kSection),
        _para(
          'A curve maps the linear time t in [0..1] to an eased value. We '
          'evaluate Curves.X.transform(t) at six samples and feed the '
          'result into ScaleTransition. The pacing of the dot grows '
          'differently between rows.',
        ),
        const SizedBox(height: 8.0),
        _curveRow('linear', Curves.linear),
        _curveRow('easeIn', Curves.easeIn),
        _curveRow('easeOut', Curves.easeOut),
        _curveRow('easeInOut', Curves.easeInOut),
        _curveRow('elasticOut', Curves.elasticOut),
        _curveRow('bounceOut', Curves.bounceOut),
        _curveRow('backOut', Curves.easeOutBack),
        _divider(),
        _bullet('elasticOut overshoots past 1.0 and oscillates back — note '
            'the >1.0 frames mid-row.'),
        _bullet('bounceOut delivers a comic settle with multiple landings.'),
        _bullet('backOut briefly overshoots once. Great for "snap" reveals.'),
        _bullet('Curves do not need a controller — Curves.X.transform(t) is '
            'a pure synchronous function.'),
      ],
    ),
  );
}

// =============================================================================
// 10. Real-world recipes
// =============================================================================

Widget _pulseButtonFrame(double t, String label) {
  return Padding(
    padding: const EdgeInsets.all(6.0),
    child: Column(
      children: [
        Container(
          width: 110.0,
          height: 90.0,
          decoration: BoxDecoration(
            color: _parchment,
            border: Border.all(color: _outline),
            borderRadius: BorderRadius.circular(6.0),
          ),
          alignment: Alignment.center,
          child: ScaleTransition(
            scale: AlwaysStoppedAnimation<double>(t),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ),
              decoration: BoxDecoration(
                color: _emberDeep,
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 6.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Text(
                'BUY',
                style: TextStyle(
                  color: _parchment,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.4,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(label, style: _kFrameLabel),
      ],
    ),
  );
}

Widget _popCardFrame(double t, String label) {
  final double opacity = (t).clamp(0.0, 1.0);
  return Padding(
    padding: const EdgeInsets.all(6.0),
    child: Column(
      children: [
        Container(
          width: 130.0,
          height: 100.0,
          decoration: BoxDecoration(
            color: _parchment,
            border: Border.all(color: _outline),
            borderRadius: BorderRadius.circular(6.0),
          ),
          alignment: Alignment.center,
          child: FadeTransition(
            opacity: AlwaysStoppedAnimation<double>(opacity),
            child: ScaleTransition(
              scale: AlwaysStoppedAnimation<double>(t),
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 110.0,
                height: 70.0,
                decoration: BoxDecoration(
                  color: _ink,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'New message',
                  style: TextStyle(
                    color: _parchment,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(label, style: _kFrameLabel),
      ],
    ),
  );
}

Widget _zoomIconFrame(double t, String label) {
  return Padding(
    padding: const EdgeInsets.all(6.0),
    child: Column(
      children: [
        Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
            color: _parchment,
            border: Border.all(color: _outline),
            borderRadius: BorderRadius.circular(6.0),
          ),
          alignment: Alignment.center,
          child: ScaleTransition(
            scale: AlwaysStoppedAnimation<double>(t),
            child: const Icon(
              Icons.check_circle,
              color: _good,
              size: 60.0,
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(label, style: _kFrameLabel),
      ],
    ),
  );
}

Widget _recipeBlock(String title, String description, Widget frames) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: _kFrameLabel),
        Text(description, style: _kBody),
        const SizedBox(height: 6.0),
        frames,
      ],
    ),
  );
}

Widget _recipesSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _kicker('section 10'),
        const Text('Real-world recipes', style: _kSection),
        _para(
          'Three small composable patterns built on ScaleTransition. Each '
          'shows three frames of the same motion.',
        ),
        _recipeBlock(
          '1. Pulse button',
          'Loop scale between 0.95 and 1.05 to draw the eye to a CTA.',
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _pulseButtonFrame(0.95, '0.95'),
              _pulseButtonFrame(1.00, '1.00'),
              _pulseButtonFrame(1.05, '1.05'),
            ],
          ),
        ),
        _divider(),
        _recipeBlock(
          '2. Pop-card-in',
          'Combine FadeTransition + ScaleTransition with '
          'alignment=bottomCenter so the toast "rises" from its anchor.',
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _popCardFrame(0.0, '0.0'),
              _popCardFrame(0.6, '0.6'),
              _popCardFrame(1.0, '1.0'),
            ],
          ),
        ),
        _divider(),
        _recipeBlock(
          '3. Zoom-icon',
          'Use elasticOut for a satisfying confirmation chirp.',
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _zoomIconFrame(0.0, '0.0'),
              _zoomIconFrame(1.10, '1.10'),
              _zoomIconFrame(1.0, '1.0'),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// 11. Comparison table
// =============================================================================

Widget _tableHeaderCell(String label) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(8.0),
      color: _ink,
      child: Text(
        label,
        style: const TextStyle(
          color: _parchment,
          fontWeight: FontWeight.w700,
          fontSize: 12.5,
        ),
      ),
    ),
  );
}

Widget _tableCell(String label, {bool emphasised = false}) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: emphasised ? _ember.withValues(alpha: 0.15) : _parchment,
        border: Border(
          right: BorderSide(color: _outline),
          bottom: BorderSide(color: _outline),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.0,
          color: _ink,
          fontWeight: emphasised ? FontWeight.w700 : FontWeight.w400,
        ),
      ),
    ),
  );
}

Widget _comparisonSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _kicker('section 11'),
        const Text('Comparison: scale-related widgets', style: _kSection),
        const SizedBox(height: 8.0),
        Row(
          children: [
            _tableHeaderCell('Widget'),
            _tableHeaderCell('Driven by'),
            _tableHeaderCell('Layout effect'),
            _tableHeaderCell('Best for'),
          ],
        ),
        Row(
          children: [
            _tableCell('ScaleTransition', emphasised: true),
            _tableCell('Animation<double>'),
            _tableCell('paint only'),
            _tableCell('controller-driven reveals'),
          ],
        ),
        Row(
          children: [
            _tableCell('Transform.scale'),
            _tableCell('literal double'),
            _tableCell('paint only'),
            _tableCell('static decorative tweaks'),
          ],
        ),
        Row(
          children: [
            _tableCell('AnimatedScale'),
            _tableCell('implicit, target double'),
            _tableCell('paint only'),
            _tableCell('declarative target changes'),
          ],
        ),
        Row(
          children: [
            _tableCell('SizeTransition'),
            _tableCell('Animation<double>'),
            _tableCell('layout (one axis)'),
            _tableCell('list reveals, panels'),
          ],
        ),
        const SizedBox(height: 10.0),
        _bullet('SizeTransition is the only one that actually changes the '
            'amount of space taken in the parent.'),
        _bullet('AnimatedScale wraps ScaleTransition with an implicit '
            'AnimationController internally.'),
        _bullet('Transform.scale supports independent x/y via the more '
            'general Transform constructor with Matrix4.diagonal3Values.'),
      ],
    ),
  );
}

// =============================================================================
// 12. Glossary
// =============================================================================

Widget _glossaryRow(String term, String definition) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: _outline)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150.0,
          child: Text(term, style: _kFrameLabel),
        ),
        Expanded(child: Text(definition, style: _kBody)),
      ],
    ),
  );
}

Widget _glossarySection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _kicker('section 12'),
        const Text('Glossary', style: _kSection),
        const SizedBox(height: 6.0),
        _glossaryRow(
          'Animation<T>',
          'A read-only object that exposes a value and a status, plus a '
          'changeable status listener. Often produced by an '
          'AnimationController and reshaped via curves and tweens.',
        ),
        _glossaryRow(
          'AlwaysStoppedAnimation',
          'An Animation whose value never changes. Perfect for tests and '
          'for "freezing" a transition at a deterministic frame.',
        ),
        _glossaryRow(
          'AnimationController',
          'A Ticker-backed Animation<double> that you can play, reverse, '
          'and seek. Not used in this demo; we simulate frames instead.',
        ),
        _glossaryRow(
          'Tween',
          'A mapping from [0..1] to a target type. ScaleTransition does not '
          'need a Tween itself because the value type is already double.',
        ),
        _glossaryRow(
          'Curve',
          'A pure mapping from [0..1] to [0..1] (often). '
          'Curves.elasticOut.transform(t) is synchronous and side-effect-free.',
        ),
        _glossaryRow(
          'Matrix4.diagonal3Values',
          'A 4x4 transformation matrix where only the diagonal is non-unit. '
          'A uniform scale matrix has equal x and y entries.',
        ),
        _glossaryRow(
          'Alignment',
          'A 2D coordinate where (-1,-1) is the top-left corner of the '
          'reference rect and (1,1) is the bottom-right. The fixed point '
          'under scale.',
        ),
        _glossaryRow(
          'FilterQuality',
          'Hint to the engine for paint resampling. low / medium / high / '
          'none. Mostly relevant for raster children.',
        ),
        _glossaryRow(
          'Transform.scale',
          'A non-animated widget that applies a uniform scale via the same '
          'Matrix4 path used by ScaleTransition.',
        ),
        _glossaryRow(
          'FadeTransition',
          'Sibling of ScaleTransition that drives opacity rather than size.',
        ),
        _glossaryRow(
          'RotationTransition',
          'Sibling that drives rotation (in turns, not radians).',
        ),
        _glossaryRow(
          'SizeTransition',
          'Cousin that animates layout — actually changes the parent\'s '
          'available space along one axis.',
        ),
      ],
    ),
  );
}

// =============================================================================
// 13. Epilogue
// =============================================================================

Widget _epilogueSection() {
  return _card(
    background: _ink,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Epilogue',
          style: _kSection.copyWith(color: _parchment),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'ScaleTransition is one of those quiet, reliable widgets that '
          'turns "the controller is at frame 0.62" into "this thing is '
          'now 62% of its rest size". Once you see it as a Matrix4 stamp '
          'driven by a value source, the rest of the animation family '
          'falls into place.',
          style: TextStyle(color: _parchment, height: 1.5, fontSize: 13.5),
        ),
        const SizedBox(height: 10.0),
        Wrap(
          children: [
            _chip('frozen demo', color: _ember),
            _chip('no controllers', color: _ember),
            _chip('analyzer clean', color: _ember),
            _chip('deterministic', color: _ember),
          ],
        ),
        const SizedBox(height: 10.0),
        const Text(
          'End of deep dive. Return to top to revisit any section.',
          style: TextStyle(
            color: _muted,
            fontStyle: FontStyle.italic,
            fontSize: 12.5,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Build entry point
// =============================================================================

dynamic build(BuildContext context) {
  print('ScaleTransition deep demo: build starting');

  // A small handful of values that we want to mention in the header.
  // These also exercise local variables intentionally (unused_local_variable
  // is allowed via the ignore directive at the top of the file).
  final int sectionCount = 13;
  final int frameStripFrames = 9;
  final int alignmentCells = 9;
  final String paletteName = 'amber-charcoal';
  final String mode = 'frozen-frame';

  print('  sections=$sectionCount frames=$frameStripFrames '
      'alignments=$alignmentCells palette=$paletteName mode=$mode');

  final Widget hero = _hero();
  final Widget concept = _conceptSection();
  final Widget anatomy = _anatomySection();
  final Widget frameStrip = _frameStripSection();
  final Widget alignmentGrid = _alignmentGridSection();
  final Widget filterQuality = _filterQualitySection();
  final Widget vsTransform = _vsTransformSection();
  final Widget composition = _compositionSection();
  final Widget curveStudies = _curveStudiesSection();
  final Widget recipes = _recipesSection();
  final Widget comparison = _comparisonSection();
  final Widget glossary = _glossarySection();
  final Widget epilogue = _epilogueSection();

  // Construct a sentinel ScaleTransition at full scale so the analyzer sees
  // every parameter exercised at least once outside the helper functions.
  final Widget sentinel = ScaleTransition(
    scale: const AlwaysStoppedAnimation<double>(1.0),
    alignment: Alignment.center,
    filterQuality: FilterQuality.medium,
    child: Container(
      width: 1.0,
      height: 1.0,
      color: _warn.withValues(alpha: 0.0),
    ),
  );

  print('ScaleTransition deep demo: assembled $sectionCount sections');

  return Container(
    color: _parchment,
    padding: const EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Flutter Widgets · Deep Demo', style: _kTitle),
          const SizedBox(height: 6.0),
          const Text(
            'ScaleTransition — every frame, every pivot, every nuance.',
            style: _kBody,
          ),
          const SizedBox(height: 12.0),
          hero,
          concept,
          anatomy,
          frameStrip,
          alignmentGrid,
          filterQuality,
          vsTransform,
          composition,
          curveStudies,
          recipes,
          comparison,
          glossary,
          epilogue,
          // Render the sentinel at the very bottom inside a zero-sized box
          // so it participates in the tree without affecting the layout.
          SizedBox(width: 0.0, height: 0.0, child: sentinel),
        ],
      ),
    ),
  );
}
