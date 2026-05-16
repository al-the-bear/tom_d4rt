// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: hand-authored deep visual demo for advanced animated widgets
// (AnimatedSwitcher, AnimatedCrossFade, AnimatedContainer family)
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Section helpers — small reusable visual primitives for the demo cards.
// Each helper returns a Widget. They take only plain Dart values; no state.
// ---------------------------------------------------------------------------

Widget _sectionHeader(String title, String subtitle, Color tone) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[tone.withOpacity(0.85), tone.withOpacity(0.55)],
      ),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: 1.3,
          ),
        ),
      ],
    ),
  );
}

Widget _explainerCard(String title, String body, IconData icon, Color tone) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: tone.withOpacity(0.35), width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: tone, size: 22),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: tone,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _labelChip(String label, Color tone) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: tone.withOpacity(0.15),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: tone, width: 1),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: tone,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _swatch(String name, Color color, double size) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.black12, width: 1),
        ),
      ),
      const SizedBox(height: 4),
      Text(
        name,
        style: const TextStyle(fontSize: 10, color: Colors.black87),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 1 — AnimatedSwitcher gallery: 4 transitionBuilder patterns.
// ---------------------------------------------------------------------------

Widget _switcherFadeTile() {
  return AnimatedSwitcher(
    duration: const Duration(milliseconds: 450),
    reverseDuration: const Duration(milliseconds: 250),
    switchInCurve: Curves.easeIn,
    switchOutCurve: Curves.easeOut,
    transitionBuilder: (Widget child, Animation<double> animation) {
      return FadeTransition(opacity: animation, child: child);
    },
    child: Container(
      key: const ValueKey<String>('fade-tile'),
      width: 120,
      height: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.indigo.shade400,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        'Fade',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
  );
}

Widget _switcherScaleTile() {
  return AnimatedSwitcher(
    duration: const Duration(milliseconds: 500),
    switchInCurve: Curves.elasticOut,
    switchOutCurve: Curves.easeIn,
    transitionBuilder: (Widget child, Animation<double> animation) {
      return ScaleTransition(scale: animation, child: child);
    },
    child: Container(
      key: const ValueKey<String>('scale-tile'),
      width: 120,
      height: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.teal.shade400,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        'Scale',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
  );
}

Widget _switcherSlideTile() {
  return AnimatedSwitcher(
    duration: const Duration(milliseconds: 600),
    switchInCurve: Curves.easeOutCubic,
    switchOutCurve: Curves.easeInCubic,
    transitionBuilder: (Widget child, Animation<double> animation) {
      final Animation<Offset> offset = Tween<Offset>(
        begin: const Offset(0.0, 0.25),
        end: Offset.zero,
      ).animate(animation);
      return SlideTransition(
        position: offset,
        child: FadeTransition(opacity: animation, child: child),
      );
    },
    child: Container(
      key: const ValueKey<String>('slide-tile'),
      width: 120,
      height: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.deepOrange.shade400,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        'Slide',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
  );
}

Widget _switcherRotateTile() {
  return AnimatedSwitcher(
    duration: const Duration(milliseconds: 700),
    switchInCurve: Curves.easeInOut,
    switchOutCurve: Curves.easeInOut,
    transitionBuilder: (Widget child, Animation<double> animation) {
      return RotationTransition(
        turns: animation,
        child: FadeTransition(opacity: animation, child: child),
      );
    },
    child: Container(
      key: const ValueKey<String>('rotate-tile'),
      width: 120,
      height: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.purple.shade400,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        'Rotate',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
  );
}

Widget _switcherDefaultBuilderReferenceCard() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade400),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'AnimatedSwitcher.defaultTransitionBuilder',
          style: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Signature:\n'
          '  Widget Function(Widget child, Animation<double> animation)\n'
          'Default behavior:\n'
          '  return FadeTransition(opacity: animation, child: child);',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: Colors.black87,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Override this builder to introduce scale, slide, rotation, or '
          'composite transitions per child. The builder is invoked for both '
          'the entering and the exiting child so it must be symmetric.',
          style: TextStyle(fontSize: 11, color: Colors.black87, height: 1.35),
        ),
      ],
    ),
  );
}

Widget _switcherGallerySection() {
  return Container(
    margin: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.indigo.shade200, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          '1. AnimatedSwitcher gallery',
          'Four transitionBuilder patterns: fade, scale, slide, rotate. '
              'AnimatedSwitcher swaps its child by key — with a static key the '
              'mounted child is rendered using the entry transition at value 1.',
          Colors.indigo,
        ),
        _explainerCard(
          'Why static value renders cleanly',
          'AnimatedSwitcher only animates when the child key changes. With a '
              'fixed key and no state, the entry curve completes once and the '
              'final pose is shown. The transitionBuilder still runs.',
          Icons.swap_horiz,
          Colors.indigo,
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: <Widget>[
              _switcherFadeTile(),
              _switcherScaleTile(),
              _switcherSlideTile(),
              _switcherRotateTile(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 6,
            runSpacing: 6,
            children: <Widget>[
              _labelChip('duration', Colors.indigo),
              _labelChip('reverseDuration', Colors.indigo),
              _labelChip('switchInCurve', Colors.indigo),
              _labelChip('switchOutCurve', Colors.indigo),
              _labelChip('transitionBuilder', Colors.indigo),
              _labelChip('layoutBuilder', Colors.indigo),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _switcherDefaultBuilderReferenceCard(),
        const SizedBox(height: 12),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 2 — AnimatedCrossFade with both crossFadeState values.
// ---------------------------------------------------------------------------

Widget _crossFadeCard({
  required String title,
  required CrossFadeState state,
  required Color tone,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: tone.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: tone,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 8),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 300),
          firstCurve: Curves.easeInQuint,
          secondCurve: Curves.easeOutQuint,
          sizeCurve: Curves.easeInOutCubic,
          alignment: Alignment.center,
          crossFadeState: state,
          firstChild: Container(
            width: 200,
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'First child\n(showFirst)',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          secondChild: Container(
            width: 200,
            height: 120,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.red.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Second child\n(showSecond)',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          layoutBuilder: (
            Widget topChild,
            Key topChildKey,
            Widget bottomChild,
            Key bottomChildKey,
          ) {
            return Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(key: bottomChildKey, child: bottomChild),
                Positioned(key: topChildKey, child: topChild),
              ],
            );
          },
        ),
      ],
    ),
  );
}

Widget _crossFadeSection() {
  return Container(
    margin: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.red.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          '2. AnimatedCrossFade — both crossFadeState values',
          'AnimatedCrossFade simultaneously fades and resizes between two '
              'children. With static state the displayed child is shown fully '
              'opaque; the other is fully transparent.',
          Colors.red,
        ),
        _explainerCard(
          'Required parameters',
          'firstChild, secondChild, crossFadeState, and duration. Optional: '
              'reverseDuration, firstCurve, secondCurve, sizeCurve, alignment, '
              'layoutBuilder, excludeBottomFocus.',
          Icons.compare_arrows,
          Colors.red,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: _crossFadeCard(
                  title: 'crossFadeState.showFirst',
                  state: CrossFadeState.showFirst,
                  tone: Colors.blue,
                ),
              ),
              Expanded(
                child: _crossFadeCard(
                  title: 'crossFadeState.showSecond',
                  state: CrossFadeState.showSecond,
                  tone: Colors.red,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Wrap(
            spacing: 6,
            runSpacing: 6,
            children: <Widget>[
              _labelChip('firstChild', Colors.red),
              _labelChip('secondChild', Colors.red),
              _labelChip('crossFadeState', Colors.red),
              _labelChip('duration', Colors.red),
              _labelChip('firstCurve', Colors.red),
              _labelChip('secondCurve', Colors.red),
              _labelChip('sizeCurve', Colors.red),
              _labelChip('alignment', Colors.red),
              _labelChip('layoutBuilder', Colors.red),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 3 — AnimatedContainer parameter showcase: a grid of variants.
// ---------------------------------------------------------------------------

Widget _animatedContainerSample({
  required String label,
  required Color color,
  required double width,
  required double height,
  required BorderRadius radius,
  required AlignmentGeometry alignment,
  required EdgeInsetsGeometry padding,
  required EdgeInsetsGeometry margin,
  required double elevationProxy,
  required Curve curve,
  required Duration duration,
}) {
  return AnimatedContainer(
    duration: duration,
    curve: curve,
    width: width,
    height: height,
    alignment: alignment,
    padding: padding,
    margin: margin,
    decoration: BoxDecoration(
      color: color,
      borderRadius: radius,
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: elevationProxy,
          offset: Offset(0, elevationProxy / 2),
        ),
      ],
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 13,
      ),
    ),
  );
}

Widget _animatedContainerSection() {
  final List<Widget> samples = <Widget>[
    _animatedContainerSample(
      label: 'small',
      color: Colors.green.shade400,
      width: 90,
      height: 60,
      radius: BorderRadius.circular(6),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(2),
      elevationProxy: 2,
      curve: Curves.linear,
      duration: const Duration(milliseconds: 200),
    ),
    _animatedContainerSample(
      label: 'medium',
      color: Colors.green.shade600,
      width: 120,
      height: 80,
      radius: BorderRadius.circular(12),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(4),
      elevationProxy: 4,
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 350),
    ),
    _animatedContainerSample(
      label: 'large',
      color: Colors.green.shade800,
      width: 150,
      height: 100,
      radius: BorderRadius.circular(20),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(6),
      elevationProxy: 8,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 500),
    ),
    _animatedContainerSample(
      label: 'pill',
      color: Colors.lightGreen.shade700,
      width: 140,
      height: 50,
      radius: BorderRadius.circular(25),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      margin: const EdgeInsets.all(4),
      elevationProxy: 3,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 400),
    ),
    _animatedContainerSample(
      label: 'square',
      color: Colors.teal.shade500,
      width: 90,
      height: 90,
      radius: BorderRadius.circular(0),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.all(2),
      elevationProxy: 5,
      curve: Curves.bounceOut,
      duration: const Duration(milliseconds: 700),
    ),
    _animatedContainerSample(
      label: 'tall',
      color: Colors.cyan.shade600,
      width: 80,
      height: 140,
      radius: BorderRadius.circular(8),
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.all(3),
      elevationProxy: 6,
      curve: Curves.elasticOut,
      duration: const Duration(milliseconds: 800),
    ),
  ];

  return Container(
    margin: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.green.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          '3. AnimatedContainer parameter showcase',
          'Six variants demonstrating width, height, color, padding, margin, '
              'alignment, borderRadius, boxShadow, curve, and duration. With '
              'static config the final pose is rendered immediately.',
          Colors.green,
        ),
        _explainerCard(
          'Field set it animates',
          'AnimatedContainer interpolates: alignment, padding, margin, color, '
              'decoration, foregroundDecoration, constraints, width, height, '
              'transform, transformAlignment. Children are not animated.',
          Icons.crop_square,
          Colors.green,
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: samples,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Wrap(
            spacing: 6,
            runSpacing: 6,
            children: <Widget>[
              _labelChip('duration', Colors.green),
              _labelChip('curve', Colors.green),
              _labelChip('width', Colors.green),
              _labelChip('height', Colors.green),
              _labelChip('alignment', Colors.green),
              _labelChip('padding', Colors.green),
              _labelChip('margin', Colors.green),
              _labelChip('decoration', Colors.green),
              _labelChip('transform', Colors.green),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 4 — AnimatedOpacity / AnimatedScale / AnimatedRotation ladder.
// ---------------------------------------------------------------------------

Widget _opacityRung(double opacity) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        opacity: opacity,
        alwaysIncludeSemantics: true,
        child: Container(
          width: 60,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade400,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            opacity.toStringAsFixed(2),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
      const SizedBox(height: 4),
      Text(
        'op=$opacity',
        style: const TextStyle(fontSize: 10, color: Colors.black87),
      ),
    ],
  );
}

Widget _scaleRung(double scale) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      AnimatedScale(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutBack,
        scale: scale,
        alignment: Alignment.center,
        filterQuality: FilterQuality.medium,
        child: Container(
          width: 50,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.orange.shade500,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            scale.toStringAsFixed(2),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ),
      const SizedBox(height: 4),
      Text(
        's=$scale',
        style: const TextStyle(fontSize: 10, color: Colors.black87),
      ),
    ],
  );
}

Widget _rotationRung(double turns) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      AnimatedRotation(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        turns: turns,
        alignment: Alignment.center,
        filterQuality: FilterQuality.high,
        child: Container(
          width: 50,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.pink.shade400,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '${turns}t',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ),
      const SizedBox(height: 4),
      Text(
        't=$turns',
        style: const TextStyle(fontSize: 10, color: Colors.black87),
      ),
    ],
  );
}

Widget _opacityScaleRotationSection() {
  final List<double> opacities = <double>[0.05, 0.25, 0.5, 0.75, 1.0];
  final List<double> scales = <double>[0.4, 0.7, 1.0, 1.3, 1.6];
  final List<double> turns = <double>[0.0, 0.125, 0.25, 0.5, 0.75];

  final List<Widget> opacityRow = <Widget>[];
  for (int i = 0; i < opacities.length; i = i + 1) {
    opacityRow.add(_opacityRung(opacities[i]));
  }

  final List<Widget> scaleRow = <Widget>[];
  for (int i = 0; i < scales.length; i = i + 1) {
    scaleRow.add(_scaleRung(scales[i]));
  }

  final List<Widget> rotationRow = <Widget>[];
  for (int i = 0; i < turns.length; i = i + 1) {
    rotationRow.add(_rotationRung(turns[i]));
  }

  return Container(
    margin: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.deepPurple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          '4. Opacity / Scale / Rotation ladder',
          'Five rungs each for AnimatedOpacity, AnimatedScale, and '
              'AnimatedRotation. Static values across the ladder show the '
              'full range of poses these wrappers expose.',
          Colors.deepPurple,
        ),
        _explainerCard(
          'AnimatedOpacity',
          'Wraps its child with an opacity layer. opacity must be in [0, 1]. '
              'When alwaysIncludeSemantics is true, hidden children still '
              'participate in semantics. Has minimal layout impact.',
          Icons.opacity,
          Colors.deepPurple,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: opacityRow,
          ),
        ),
        const SizedBox(height: 12),
        _explainerCard(
          'AnimatedScale',
          'Scales the child uniformly around alignment. Implemented with a '
              'Transform.scale internally. filterQuality controls the image '
              'sampling used when the scale layer is rasterized.',
          Icons.zoom_out_map,
          Colors.deepPurple,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: scaleRow,
          ),
        ),
        const SizedBox(height: 12),
        _explainerCard(
          'AnimatedRotation',
          'Rotates the child by the given number of turns around alignment. '
              '0.25 turns = 90 degrees clockwise. Internally uses '
              'Transform.rotate with a Matrix4 rotationZ.',
          Icons.rotate_right,
          Colors.deepPurple,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: rotationRow,
          ),
        ),
        const SizedBox(height: 12),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 5 — AnimatedAlign / AnimatedPositioned / AnimatedPadding spatial.
// ---------------------------------------------------------------------------

Widget _alignCell(AlignmentGeometry alignment, String label) {
  return Container(
    width: 110,
    height: 110,
    margin: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: Colors.amber.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.amber.shade600),
    ),
    child: AnimatedAlign(
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOutCubic,
      alignment: alignment,
      heightFactor: 1.0,
      widthFactor: 1.0,
      child: Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.amber.shade800,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

Widget _alignGrid() {
  final List<List<AlignmentGeometry>> rows = <List<AlignmentGeometry>>[
    <AlignmentGeometry>[
      Alignment.topLeft,
      Alignment.topCenter,
      Alignment.topRight,
    ],
    <AlignmentGeometry>[
      Alignment.centerLeft,
      Alignment.center,
      Alignment.centerRight,
    ],
    <AlignmentGeometry>[
      Alignment.bottomLeft,
      Alignment.bottomCenter,
      Alignment.bottomRight,
    ],
  ];
  final List<String> labels = <String>[
    'TL', 'TC', 'TR', 'CL', 'CC', 'CR', 'BL', 'BC', 'BR',
  ];

  final List<Widget> rowWidgets = <Widget>[];
  int idx = 0;
  for (int r = 0; r < rows.length; r = r + 1) {
    final List<Widget> cells = <Widget>[];
    for (int c = 0; c < rows[r].length; c = c + 1) {
      cells.add(_alignCell(rows[r][c], labels[idx]));
      idx = idx + 1;
    }
    rowWidgets.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: cells));
  }
  return Column(children: rowWidgets);
}

Widget _positionedDemoBox({
  required double left,
  required double top,
  required double width,
  required double height,
  required Color color,
  required String label,
}) {
  return AnimatedPositioned(
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOut,
    left: left,
    top: top,
    width: width,
    height: height,
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    ),
  );
}

Widget _positionedStack() {
  return SizedBox(
    width: 260,
    height: 180,
    child: Stack(
      clipBehavior: Clip.hardEdge,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blueGrey.shade300),
          ),
        ),
        _positionedDemoBox(
          left: 10,
          top: 10,
          width: 60,
          height: 40,
          color: Colors.indigo,
          label: 'NW',
        ),
        _positionedDemoBox(
          left: 190,
          top: 10,
          width: 60,
          height: 40,
          color: Colors.deepOrange,
          label: 'NE',
        ),
        _positionedDemoBox(
          left: 100,
          top: 70,
          width: 60,
          height: 40,
          color: Colors.teal,
          label: 'C',
        ),
        _positionedDemoBox(
          left: 10,
          top: 130,
          width: 60,
          height: 40,
          color: Colors.purple,
          label: 'SW',
        ),
        _positionedDemoBox(
          left: 190,
          top: 130,
          width: 60,
          height: 40,
          color: Colors.brown,
          label: 'SE',
        ),
      ],
    ),
  );
}

Widget _paddingRung(EdgeInsetsGeometry padding, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: 110,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.lime.shade100,
          border: Border.all(color: Colors.lime.shade700),
          borderRadius: BorderRadius.circular(6),
        ),
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          padding: padding,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.lime.shade800,
              borderRadius: BorderRadius.circular(4),
            ),
            alignment: Alignment.center,
            child: const Text(
              ' ',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: const TextStyle(fontSize: 10, color: Colors.black87),
      ),
    ],
  );
}

Widget _spatialSection() {
  return Container(
    margin: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.amber.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          '5. Spatial: AnimatedAlign / Positioned / Padding',
          'AnimatedAlign covers a 3x3 alignment grid. AnimatedPositioned '
              'arranges 5 boxes inside a Stack. AnimatedPadding ramps inner '
              'padding from tight to loose.',
          Colors.amber,
        ),
        _explainerCard(
          'AnimatedAlign',
          'Implicit version of Align. Interpolates alignment, '
              'heightFactor and widthFactor across the duration with the '
              'given curve.',
          Icons.center_focus_strong,
          Colors.amber,
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: _alignGrid(),
        ),
        _explainerCard(
          'AnimatedPositioned',
          'Implicit version of Positioned. Must be the direct child of a '
              'Stack. Animates left, top, right, bottom, width, height. '
              'AnimatedPositionedDirectional uses start/end for RTL-aware '
              'placement.',
          Icons.grid_on,
          Colors.amber,
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Center(child: _positionedStack()),
        ),
        _explainerCard(
          'AnimatedPadding',
          'Animates inner EdgeInsetsGeometry. Useful for hover/focus states '
              'where padding grows as feedback. The child must be a '
              'non-null widget — no built-in placeholder is provided.',
          Icons.space_bar,
          Colors.amber,
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              _paddingRung(const EdgeInsets.all(2), 'all(2)'),
              _paddingRung(const EdgeInsets.all(6), 'all(6)'),
              _paddingRung(const EdgeInsets.all(12), 'all(12)'),
              _paddingRung(const EdgeInsets.fromLTRB(20, 4, 4, 4), 'LTRB(20,4,4,4)'),
              _paddingRung(const EdgeInsets.symmetric(horizontal: 16, vertical: 4), 'H16/V4'),
              _paddingRung(const EdgeInsets.only(left: 24, top: 12), 'only(L24,T12)'),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 6 — ImplicitlyAnimatedWidget anatomy card + cousin widgets.
// ---------------------------------------------------------------------------

Widget _anatomyCodeBlock() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(10),
    ),
    child: const Text(
      'abstract class ImplicitlyAnimatedWidget extends StatefulWidget {\n'
      '  const ImplicitlyAnimatedWidget({\n'
      '    super.key,\n'
      '    this.curve = Curves.linear,\n'
      '    required this.duration,\n'
      '    this.onEnd,\n'
      '  });\n'
      '\n'
      '  final Curve curve;\n'
      '  final Duration duration;\n'
      '  final VoidCallback? onEnd;\n'
      '\n'
      '  @override\n'
      '  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget>\n'
      '      createState() => ...;\n'
      '}\n'
      '\n'
      '// Concrete widgets extend it and override forEachTween() to register\n'
      '// each property tween (Tween<Color>, Tween<EdgeInsetsGeometry>, etc.)\n',
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11,
        color: Colors.tealAccent,
        height: 1.45,
      ),
    ),
  );
}

Widget _slideTile(Offset offset, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: 110,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade50,
          border: Border.all(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(6),
        ),
        alignment: Alignment.center,
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          offset: offset,
          child: Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade700,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 4),
      Text(
        'offset=($offset)'.replaceAll('Offset', ''),
        style: const TextStyle(fontSize: 10),
      ),
    ],
  );
}

Widget _animatedSlideShowcase() {
  final List<Widget> tiles = <Widget>[
    _slideTile(const Offset(0.0, 0.0), 'CC'),
    _slideTile(const Offset(0.5, 0.0), 'R+'),
    _slideTile(const Offset(-0.5, 0.0), 'L-'),
    _slideTile(const Offset(0.0, 0.5), 'D+'),
    _slideTile(const Offset(0.0, -0.5), 'U-'),
    _slideTile(const Offset(0.3, 0.3), 'SE'),
  ];
  return Wrap(spacing: 12, runSpacing: 12, children: tiles);
}

Widget _animatedSizeShowcase() {
  final List<Widget> samples = <Widget>[];
  final List<double> widths = <double>[60, 100, 140, 80, 120];
  final List<double> heights = <double>[40, 60, 70, 100, 50];
  for (int i = 0; i < widths.length; i = i + 1) {
    samples.add(
      Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.cyan.shade50,
          border: Border.all(color: Colors.cyan),
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.all(4),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 350),
          reverseDuration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: Alignment.center,
          clipBehavior: Clip.hardEdge,
          child: Container(
            width: widths[i],
            height: heights[i],
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.cyan.shade700,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '${widths[i].toInt()}x${heights[i].toInt()}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
  return Wrap(children: samples);
}

Widget _animatedDefaultTextStyleShowcase() {
  final List<TextStyle> styles = <TextStyle>[
    const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w300),
    const TextStyle(fontSize: 14, color: Colors.indigo, fontWeight: FontWeight.w400),
    const TextStyle(fontSize: 16, color: Colors.teal, fontWeight: FontWeight.w500),
    const TextStyle(fontSize: 20, color: Colors.deepOrange, fontWeight: FontWeight.bold),
    const TextStyle(fontSize: 24, color: Colors.red, fontWeight: FontWeight.w900),
  ];
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < styles.length; i = i + 1) {
    rows.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          style: styles[i],
          textAlign: TextAlign.left,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          child: Text('Stage ${i + 1}: animated default text style'),
        ),
      ),
    );
  }
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows);
}

Widget _animatedPhysicalModelShowcase() {
  final List<double> elevations = <double>[1.0, 4.0, 8.0, 16.0];
  final List<Widget> tiles = <Widget>[];
  for (int i = 0; i < elevations.length; i = i + 1) {
    tiles.add(
      Padding(
        padding: const EdgeInsets.all(6),
        child: AnimatedPhysicalModel(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          elevation: elevations[i],
          color: Colors.deepPurple.shade300,
          animateColor: true,
          shadowColor: Colors.black54,
          animateShadowColor: true,
          clipBehavior: Clip.antiAlias,
          child: Container(
            width: 80,
            height: 80,
            alignment: Alignment.center,
            child: Text(
              'e=${elevations[i].toInt()}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }
  return Wrap(children: tiles);
}

Widget _animatedThemeShowcase() {
  final ThemeData base = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.indigo,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
  );
  return AnimatedTheme(
    duration: const Duration(milliseconds: 400),
    curve: Curves.easeInOut,
    data: base,
    child: Builder(
      builder: (BuildContext ctx) {
        final ColorScheme cs = Theme.of(ctx).colorScheme;
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: cs.primary, width: 1),
          ),
          child: Row(
            children: <Widget>[
              _swatch('primary', cs.primary, 28),
              const SizedBox(width: 8),
              _swatch('secondary', cs.secondary, 28),
              const SizedBox(width: 8),
              _swatch('tertiary', cs.tertiary, 28),
              const SizedBox(width: 8),
              _swatch('surface', cs.surface, 28),
              const SizedBox(width: 8),
              _swatch('error', cs.error, 28),
            ],
          ),
        );
      },
    ),
  );
}

Widget _implicitAnatomySection() {
  return Container(
    margin: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.blueGrey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          '6. ImplicitlyAnimatedWidget anatomy',
          'Source-level view of the base class shared by AnimatedContainer, '
              'AnimatedPadding, AnimatedAlign, AnimatedOpacity, '
              'AnimatedDefaultTextStyle, AnimatedPhysicalModel, AnimatedTheme.',
          Colors.blueGrey,
        ),
        _explainerCard(
          'forEachTween',
          'Every concrete subclass overrides forEachTween. The framework '
              'iterates the registered tweens once per build to lerp between '
              'the previous and the new value.',
          Icons.code,
          Colors.blueGrey,
        ),
        _anatomyCodeBlock(),
        _explainerCard(
          'AnimatedSlide',
          'Translates the child by a fractional Offset relative to its own '
              'size. Offset(1,0) shifts a full width to the right.',
          Icons.swipe_right,
          Colors.blueGrey,
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: _animatedSlideShowcase(),
        ),
        _explainerCard(
          'AnimatedSize',
          'Resizes itself smoothly when its child changes size. Unlike most '
              'implicit widgets, AnimatedSize requires a Ticker — the older '
              '"vsync" argument is now optional and uses the closest Element.',
          Icons.aspect_ratio,
          Colors.blueGrey,
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: _animatedSizeShowcase(),
        ),
        _explainerCard(
          'AnimatedDefaultTextStyle',
          'Interpolates between TextStyle objects. Inherited by descendant '
              'Text widgets through DefaultTextStyle.of(context).',
          Icons.text_fields,
          Colors.blueGrey,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: _animatedDefaultTextStyleShowcase(),
        ),
        const SizedBox(height: 12),
        _explainerCard(
          'AnimatedPhysicalModel',
          'Animates elevation, color, and shadowColor for a Material-like '
              'physical surface. animateColor and animateShadowColor toggle '
              'whether color and shadow are interpolated or snapped.',
          Icons.layers,
          Colors.blueGrey,
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: _animatedPhysicalModelShowcase(),
        ),
        _explainerCard(
          'AnimatedTheme',
          'Implicit version of Theme. Lerps every interpolatable ThemeData '
              'property to its target value. Descendants pick up the new '
              'ThemeData transparently.',
          Icons.palette,
          Colors.blueGrey,
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: _animatedThemeShowcase(),
        ),
        const SizedBox(height: 12),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 7 — Tween.transform reference: how to read static values from a
// Tween without an AnimationController.
// ---------------------------------------------------------------------------

Widget _tweenReferenceCard() {
  // We compute three sample poses by reading Tween.transform(t) directly.
  // This is the analyzer-friendly way to obtain interpolated values without
  // an AnimationController.
  final Tween<double> sizeTween = Tween<double>(begin: 40.0, end: 120.0);
  final ColorTween colorTween = ColorTween(
    begin: Colors.lightBlue.shade100,
    end: Colors.deepPurple.shade700,
  );
  final Tween<double> radiusTween = Tween<double>(begin: 2.0, end: 20.0);

  final List<double> samples = <double>[0.0, 0.25, 0.5, 0.75, 1.0];
  final List<Widget> tiles = <Widget>[];
  for (int i = 0; i < samples.length; i = i + 1) {
    final double t = samples[i];
    final double s = sizeTween.transform(t);
    final Color c = colorTween.transform(t) ?? Colors.transparent;
    final double r = radiusTween.transform(t);
    tiles.add(
      Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: s,
              height: s,
              decoration: BoxDecoration(
                color: c,
                borderRadius: BorderRadius.circular(r),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              't=${t.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 11, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
  return Container(
    margin: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.cyan.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionHeader(
          '7. Tween.transform(t) reference ladder',
          'Reading interpolated values directly from a Tween without an '
              'AnimationController. Tween.transform(t) is pure: same input '
              'always yields the same output.',
          Colors.cyan,
        ),
        _explainerCard(
          'Pattern',
          'Build the Tween with begin/end. Call .transform(t) where t is a '
              'plain double in [0, 1]. Returned value matches the type '
              'parameter — for ColorTween the result is Color?.',
          Icons.timeline,
          Colors.cyan,
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.end,
            spacing: 8,
            runSpacing: 8,
            children: tiles,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Footer — summary and reference of every widget covered.
// ---------------------------------------------------------------------------

Widget _summaryFooter() {
  final List<List<String>> entries = <List<String>>[
    <String>['AnimatedSwitcher', 'Swap child by key with a custom transitionBuilder.'],
    <String>['AnimatedCrossFade', 'Cross-fade and resize between two children.'],
    <String>['AnimatedContainer', 'Implicit Container; interpolates every visual property.'],
    <String>['AnimatedAlign', 'Implicit Align; interpolates alignment and size factors.'],
    <String>['AnimatedPositioned', 'Implicit Positioned inside a Stack.'],
    <String>['AnimatedPadding', 'Implicit Padding; interpolates EdgeInsets.'],
    <String>['AnimatedOpacity', 'Implicit Opacity; lerps the opacity layer.'],
    <String>['AnimatedScale', 'Implicit Transform.scale around alignment.'],
    <String>['AnimatedRotation', 'Implicit Transform.rotate via turns count.'],
    <String>['AnimatedSlide', 'Implicit fractional translation of child.'],
    <String>['AnimatedSize', 'Smoothly resizes to fit a changing child.'],
    <String>['AnimatedDefaultTextStyle', 'Lerps TextStyle for descendant Text widgets.'],
    <String>['AnimatedPhysicalModel', 'Lerps elevation, color, shadowColor for a surface.'],
    <String>['AnimatedTheme', 'Lerps ThemeData for the subtree.'],
    <String>['ImplicitlyAnimatedWidget', 'Base class — concrete subclasses override forEachTween.'],
  ];
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < entries.length; i = i + 1) {
    final List<String> e = entries[i];
    rows.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 200,
              child: Text(
                e[0],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: Colors.indigo,
                ),
              ),
            ),
            Expanded(
              child: Text(
                e[1],
                style: const TextStyle(fontSize: 12, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
  return Container(
    margin: const EdgeInsets.all(12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.indigo.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Coverage summary',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'All 15 widget constructors below are exercised with static value '
          'props so the analyzer-free interpreter can render them without '
          'any state, ticker, or AnimationController.',
          style: TextStyle(fontSize: 12, color: Colors.black87),
        ),
        const SizedBox(height: 12),
        Column(children: rows),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Top-level build entry. Returns a Scaffold wrapping every section.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('animated_widgets_adv_test: build entry');

  final Widget switcherSection = _switcherGallerySection();
  print('animated_widgets_adv_test: section 1 (AnimatedSwitcher) ready');

  final Widget crossFadeSection = _crossFadeSection();
  print('animated_widgets_adv_test: section 2 (AnimatedCrossFade) ready');

  final Widget containerSection = _animatedContainerSection();
  print('animated_widgets_adv_test: section 3 (AnimatedContainer) ready');

  final Widget ladderSection = _opacityScaleRotationSection();
  print('animated_widgets_adv_test: section 4 (Opacity/Scale/Rotation) ready');

  final Widget spatialSection = _spatialSection();
  print('animated_widgets_adv_test: section 5 (spatial Align/Positioned/Padding) ready');

  final Widget anatomySection = _implicitAnatomySection();
  print('animated_widgets_adv_test: section 6 (Implicit anatomy + cousins) ready');

  final Widget tweenSection = _tweenReferenceCard();
  print('animated_widgets_adv_test: section 7 (Tween.transform ladder) ready');

  final Widget footer = _summaryFooter();
  print('animated_widgets_adv_test: footer ready');

  return Scaffold(
    backgroundColor: Colors.grey.shade100,
    appBar: AppBar(
      title: const Text('Advanced animated widgets demo'),
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
      elevation: 2,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Intro card sets the tone for the visual demo.
          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Colors.indigo.shade700,
                  Colors.deepPurple.shade400,
                ],
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.18),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Advanced animated widgets',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'A static, analyzer-clean visual catalog of every widget in '
                  'the Implicit/Animated family. Each section ships its own '
                  'reference card, parameter chips, and rendered poses so the '
                  'D4rt interpreter can verify both layout and styling.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: <Widget>[
                    _labelChip('AnimatedSwitcher', Colors.white),
                    _labelChip('AnimatedCrossFade', Colors.white),
                    _labelChip('AnimatedContainer', Colors.white),
                    _labelChip('AnimatedAlign', Colors.white),
                    _labelChip('AnimatedDefaultTextStyle', Colors.white),
                    _labelChip('AnimatedPositioned', Colors.white),
                    _labelChip('AnimatedSize', Colors.white),
                    _labelChip('AnimatedOpacity', Colors.white),
                    _labelChip('AnimatedPadding', Colors.white),
                    _labelChip('AnimatedPhysicalModel', Colors.white),
                    _labelChip('AnimatedRotation', Colors.white),
                    _labelChip('AnimatedScale', Colors.white),
                    _labelChip('AnimatedSlide', Colors.white),
                    _labelChip('AnimatedTheme', Colors.white),
                    _labelChip('ImplicitlyAnimatedWidget', Colors.white),
                  ],
                ),
              ],
            ),
          ),
          switcherSection,
          crossFadeSection,
          containerSection,
          ladderSection,
          spatialSection,
          anatomySection,
          tweenSection,
          footer,
          const SizedBox(height: 24),
        ],
      ),
    ),
  );
}
