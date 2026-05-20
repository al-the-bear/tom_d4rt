// D4rt deep visual demo: the Flutter animation laboratory.
//
// This script exercises the core animation primitives exposed by
// `package:flutter/animation.dart`:
//   * Animation<double>, AnimationController
//   * Tween<T> and the typed subclasses (ColorTween, IntTween, SizeTween,
//     AlignmentTween, BorderTween, RectTween, EdgeInsetsTween)
//   * Curve / Curves, CurvedAnimation, Interval, Cubic, Threshold,
//     FlippedCurve, SawTooth
//   * ReverseAnimation, ProxyAnimation, TrainHoppingAnimation
//   * CompoundAnimation, AnimationMin, AnimationMax, AnimationMean
//   * AlwaysStoppedAnimation
//   * TweenSequence / TweenSequenceItem / ConstantTween
//   * AnimationStatus / status listeners
//
// The build() function returns a Scaffold whose body hosts a single
// StatefulWidget (_AnimationLab) that owns the controllers. Each "section"
// renders narrative Text plus a focused visual artifact.

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Entry point used by the d4rt runner.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  debugPrint('AnimationLab deep demo: build() entered');
  return Scaffold(
    backgroundColor: const Color(0xFFF4F1EA),
    appBar: AppBar(
      title: const Text('Animation Laboratory'),
      backgroundColor: const Color(0xFF263238),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: const _AnimationLab(),
  );
}

// ---------------------------------------------------------------------------
// Top level stateful widget: owns AnimationControllers used throughout demo.
// ---------------------------------------------------------------------------

class _AnimationLab extends StatefulWidget {
  const _AnimationLab();

  @override
  State<_AnimationLab> createState() => _AnimationLabState();
}

class _AnimationLabState extends State<_AnimationLab>
    with TickerProviderStateMixin {
  // Primary controller: 2 second cycle, drives most sections.
  late final AnimationController _primary;
  // Secondary controller running at a different speed (compound math demo).
  late final AnimationController _secondary;
  // A controller dedicated to the bouncing-ball TweenSequence demo.
  late final AnimationController _bouncer;

  // Curve wrappers used in the chained-curved animations.
  late final Animation<double> _curvedEaseIn;
  late final Animation<double> _curvedElasticOut;
  late final Animation<double> _reversed;
  late final ProxyAnimation _proxy;

  // Compound animations across _primary and _secondary.
  late final Animation<double> _minAnim;
  late final Animation<double> _maxAnim;
  late final Animation<double> _meanAnim;

  // Status of the primary controller, refreshed via addStatusListener.
  AnimationStatus _primaryStatus = AnimationStatus.dismissed;

  // Whether the proxy points at the "ease-in" or the "elastic-out" parent.
  bool _proxyOnElastic = false;

  @override
  void initState() {
    super.initState();
    _primary = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..addStatusListener(_handleStatus);
    _secondary = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    );
    _bouncer = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _curvedEaseIn = CurvedAnimation(parent: _primary, curve: Curves.easeIn);
    _curvedElasticOut =
        CurvedAnimation(parent: _primary, curve: Curves.elasticOut);
    _reversed = ReverseAnimation(_primary);
    _proxy = ProxyAnimation(_curvedEaseIn);

    _minAnim = AnimationMin<double>(_primary, _secondary);
    _maxAnim = AnimationMax<double>(_primary, _secondary);
    _meanAnim = _MeanAnimation(_primary, _secondary);

    // Kick everything off.
    _primary.repeat(reverse: true);
    _secondary.repeat();
    _bouncer.repeat();
  }

  void _handleStatus(AnimationStatus status) {
    if (!mounted) return;
    setState(() => _primaryStatus = status);
    // Flip the proxy parent every time we hit the forward boundary so the
    // ProxyAnimation row visibly switches feel mid-cycle.
    if (status == AnimationStatus.completed) {
      setState(() {
        _proxyOnElastic = !_proxyOnElastic;
        _proxy.parent = _proxyOnElastic ? _curvedElasticOut : _curvedEaseIn;
      });
    }
  }

  @override
  void dispose() {
    _primary.removeStatusListener(_handleStatus);
    _primary.dispose();
    _secondary.dispose();
    _bouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _HeroHeader(controller: _primary),
          const SizedBox(height: 28),
          const _CurvesCatalogSection(),
          const SizedBox(height: 28),
          _TweenGallerySection(controller: _primary),
          const SizedBox(height: 28),
          _TweenSequenceSection(controller: _bouncer),
          const SizedBox(height: 28),
          _CurvedChainSection(
            easeIn: _curvedEaseIn,
            elasticOut: _curvedElasticOut,
          ),
          const SizedBox(height: 28),
          _ProxyReverseSection(
            primary: _primary,
            reversed: _reversed,
            proxy: _proxy,
            proxyOnElastic: _proxyOnElastic,
          ),
          const SizedBox(height: 28),
          _CompoundSection(
            a: _primary,
            b: _secondary,
            minA: _minAnim,
            maxA: _maxAnim,
            meanA: _meanAnim,
          ),
          const SizedBox(height: 28),
          _StatusListenerSection(status: _primaryStatus),
          const SizedBox(height: 28),
          const _AlwaysStoppedSection(),
          const SizedBox(height: 28),
          const _BestPracticesSection(),
          const SizedBox(height: 32),
          const _LabFooter(),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Workbench-styled section wrapper.
// ---------------------------------------------------------------------------

class _Bench extends StatelessWidget {
  const _Bench({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.child,
  });

  final int index;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD7CFBE), width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF263238),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'SECTION ${index.toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF263238),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 1: Hero header.
// ---------------------------------------------------------------------------

class _HeroHeader extends StatelessWidget {
  const _HeroHeader({required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFF1B262C), Color(0xFF0F4C75)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, Widget? child) {
              final double pulse =
                  Curves.easeInOut.transform(controller.value);
              return Container(
                width: 78 + pulse * 14,
                height: 78 + pulse * 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFBBE1FA).withValues(alpha: 0.18),
                  border: Border.all(
                    color: const Color(0xFFBBE1FA)
                        .withValues(alpha: 0.4 + pulse * 0.4),
                    width: 2.5,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 30 + pulse * 18,
                    height: 30 + pulse * 18,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFBBE1FA),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'ANIMATION LABORATORY',
                  style: TextStyle(
                    color: Color(0xFFBBE1FA),
                    fontSize: 11,
                    letterSpacing: 2.4,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Value, status, and listeners.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'An Animation<T> exposes a current value plus a status '
                  '(dismissed, forward, completed, reverse) and notifies '
                  'value and status listeners. The heartbeat on the left is '
                  'an AnimationController driven through Curves.easeInOut.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.88),
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

// ---------------------------------------------------------------------------
// SECTION 2: Curves catalog.
// ---------------------------------------------------------------------------

class _CurvesCatalogSection extends StatelessWidget {
  const _CurvesCatalogSection();

  static const List<_NamedCurve> _all = <_NamedCurve>[
    _NamedCurve('linear', Curves.linear),
    _NamedCurve('decelerate', Curves.decelerate),
    _NamedCurve('fastOutSlowIn', Curves.fastOutSlowIn),
    _NamedCurve('slowMiddle', Curves.slowMiddle),
    _NamedCurve('fastLinearToSlowEaseIn', Curves.fastLinearToSlowEaseIn),
    _NamedCurve('fastEaseInToSlowEaseOut', Curves.fastEaseInToSlowEaseOut),
    _NamedCurve('easeIn', Curves.easeIn),
    _NamedCurve('easeOut', Curves.easeOut),
    _NamedCurve('easeInOut', Curves.easeInOut),
    _NamedCurve('easeInQuad', Curves.easeInQuad),
    _NamedCurve('easeOutQuad', Curves.easeOutQuad),
    _NamedCurve('easeInCubic', Curves.easeInCubic),
    _NamedCurve('easeOutCubic', Curves.easeOutCubic),
    _NamedCurve('easeInQuart', Curves.easeInQuart),
    _NamedCurve('easeOutQuart', Curves.easeOutQuart),
    _NamedCurve('easeInQuint', Curves.easeInQuint),
    _NamedCurve('easeOutQuint', Curves.easeOutQuint),
    _NamedCurve('bounceIn', Curves.bounceIn),
    _NamedCurve('bounceOut', Curves.bounceOut),
    _NamedCurve('bounceInOut', Curves.bounceInOut),
    _NamedCurve('elasticIn', Curves.elasticIn),
    _NamedCurve('elasticOut', Curves.elasticOut),
    _NamedCurve('elasticInOut', Curves.elasticInOut),
    _NamedCurve('easeInBack', Curves.easeInBack),
  ];

  @override
  Widget build(BuildContext context) {
    return _Bench(
      index: 2,
      title: 'Curves catalog',
      subtitle:
          'Every Curve is a function [0,1] -> [0,1]. Each sparkline is the '
          'curve transformed across 100 samples. Pick a curve to control '
          'the perceived "feel" of a tween.',
      icon: Icons.show_chart,
      color: const Color(0xFFD32F2F),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: <Widget>[
          for (final _NamedCurve nc in _all) _CurveCard(named: nc),
        ],
      ),
    );
  }
}

class _NamedCurve {
  const _NamedCurve(this.name, this.curve);
  final String name;
  final Curve curve;
}

class _CurveCard extends StatelessWidget {
  const _CurveCard({required this.named});

  final _NamedCurve named;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 118,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE0CB8C)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 60,
            child: CustomPaint(painter: _CurvePainter(named.curve)),
          ),
          const SizedBox(height: 6),
          Text(
            named.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              fontFamily: 'monospace',
              color: Color(0xFF5D4037),
            ),
          ),
        ],
      ),
    );
  }
}

class _CurvePainter extends CustomPainter {
  const _CurvePainter(this.curve);

  final Curve curve;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint grid = Paint()
      ..color = const Color(0xFFE0CB8C)
      ..strokeWidth = 0.5;
    canvas.drawLine(Offset(0, size.height), Offset(size.width, size.height),
        grid);
    canvas.drawLine(const Offset(0, 0), Offset(0, size.height), grid);

    final Paint line = Paint()
      ..color = const Color(0xFFD32F2F)
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;

    final Path path = Path();
    const int samples = 100;
    for (int i = 0; i <= samples; i++) {
      final double t = i / samples;
      final double y = curve.transform(t.clamp(0.0, 1.0));
      // y in [<some range], clamp loosely for elastic which can go outside.
      final double clamped = y.clamp(-0.3, 1.3);
      final double px = t * size.width;
      final double py = size.height - (clamped + 0.3) / 1.6 * size.height;
      if (i == 0) {
        path.moveTo(px, py);
      } else {
        path.lineTo(px, py);
      }
    }
    canvas.drawPath(path, line);
  }

  @override
  bool shouldRepaint(covariant _CurvePainter oldDelegate) =>
      oldDelegate.curve != curve;
}

// ---------------------------------------------------------------------------
// SECTION 3: Tween subtype gallery.
// ---------------------------------------------------------------------------

class _TweenGallerySection extends StatelessWidget {
  const _TweenGallerySection({required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return _Bench(
      index: 3,
      title: 'Tween subtype gallery',
      subtitle:
          'A Tween<T> linearly interpolates between begin and end. Specialized '
          'subtypes handle types Tween<T> alone cannot interpolate.',
      icon: Icons.transform,
      color: const Color(0xFF1976D2),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: _ColorTweenCard(controller: controller)),
              const SizedBox(width: 10),
              Expanded(child: _IntTweenCard(controller: controller)),
              const SizedBox(width: 10),
              Expanded(child: _SizeTweenCard(controller: controller)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(child: _AlignmentTweenCard(controller: controller)),
              const SizedBox(width: 10),
              Expanded(child: _BorderTweenCard(controller: controller)),
              const SizedBox(width: 10),
              Expanded(child: _RectTweenCard(controller: controller)),
            ],
          ),
          const SizedBox(height: 10),
          _EdgeInsetsTweenCard(controller: controller),
        ],
      ),
    );
  }
}

class _GalleryCard extends StatelessWidget {
  const _GalleryCard({
    required this.label,
    required this.tweenName,
    required this.child,
  });

  final String label;
  final String tweenName;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFCFD8DC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFF1976D2).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              tweenName,
              style: const TextStyle(
                fontSize: 10,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
                color: Color(0xFF0D47A1),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF37474F),
            ),
          ),
          const SizedBox(height: 10),
          Center(child: child),
        ],
      ),
    );
  }
}

class _ColorTweenCard extends StatelessWidget {
  const _ColorTweenCard({required this.controller});
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    final ColorTween tween =
        ColorTween(begin: const Color(0xFFE91E63), end: const Color(0xFF00BCD4));
    return _GalleryCard(
      label: 'Background morph',
      tweenName: 'ColorTween',
      child: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          final Color c = tween.transform(controller.value) ?? Colors.grey;
          return Container(
            width: 80,
            height: 50,
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(8),
            ),
          );
        },
      ),
    );
  }
}

class _IntTweenCard extends StatelessWidget {
  const _IntTweenCard({required this.controller});
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    final IntTween tween = IntTween(begin: 0, end: 100);
    return _GalleryCard(
      label: 'Counter 0 -> 100',
      tweenName: 'IntTween',
      child: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          final int value = tween.transform(controller.value);
          return Text(
            value.toString().padLeft(3, '0'),
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
              color: Color(0xFF1B5E20),
            ),
          );
        },
      ),
    );
  }
}

class _SizeTweenCard extends StatelessWidget {
  const _SizeTweenCard({required this.controller});
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    final SizeTween tween = SizeTween(
      begin: const Size(20, 20),
      end: const Size(80, 50),
    );
    return _GalleryCard(
      label: 'Box grows',
      tweenName: 'SizeTween',
      child: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          final Size s = tween.transform(controller.value) ?? Size.zero;
          return Container(
            width: s.width,
            height: s.height,
            decoration: BoxDecoration(
              color: const Color(0xFFFF9800),
              borderRadius: BorderRadius.circular(6),
            ),
          );
        },
      ),
    );
  }
}

class _AlignmentTweenCard extends StatelessWidget {
  const _AlignmentTweenCard({required this.controller});
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    final AlignmentTween tween = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
    return _GalleryCard(
      label: 'Dot slides',
      tweenName: 'AlignmentTween',
      child: SizedBox(
        height: 40,
        child: AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget? child) {
            final Alignment a =
                tween.transform(controller.value);
            return Align(
              alignment: a,
              child: Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  color: Color(0xFF7B1FA2),
                  shape: BoxShape.circle,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _BorderTweenCard extends StatelessWidget {
  const _BorderTweenCard({required this.controller});
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    final BorderTween tween = BorderTween(
      begin: Border.all(color: const Color(0xFF263238), width: 1),
      end: Border.all(color: const Color(0xFFD32F2F), width: 6),
    );
    return _GalleryCard(
      label: 'Border morph',
      tweenName: 'BorderTween',
      child: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          final Border? b = tween.transform(controller.value);
          return Container(
            width: 60,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              border: b,
              borderRadius: BorderRadius.circular(6),
            ),
          );
        },
      ),
    );
  }
}

class _RectTweenCard extends StatelessWidget {
  const _RectTweenCard({required this.controller});
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    final RectTween tween = RectTween(
      begin: const Rect.fromLTWH(0, 0, 20, 20),
      end: const Rect.fromLTWH(40, 20, 60, 40),
    );
    return _GalleryCard(
      label: 'Outline morphs',
      tweenName: 'RectTween',
      child: SizedBox(
        width: 110,
        height: 70,
        child: AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget? child) {
            final Rect r = tween.transform(controller.value) ?? Rect.zero;
            return CustomPaint(painter: _RectPainter(r));
          },
        ),
      ),
    );
  }
}

class _RectPainter extends CustomPainter {
  const _RectPainter(this.rect);

  final Rect rect;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = const Color(0xFF00897B)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawRect(rect, p);
  }

  @override
  bool shouldRepaint(covariant _RectPainter oldDelegate) =>
      oldDelegate.rect != rect;
}

class _EdgeInsetsTweenCard extends StatelessWidget {
  const _EdgeInsetsTweenCard({required this.controller});
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    final EdgeInsetsTween tween = EdgeInsetsTween(
      begin: const EdgeInsets.all(2),
      end: const EdgeInsets.all(20),
    );
    return _GalleryCard(
      label: 'Padding pulses',
      tweenName: 'EdgeInsetsTween',
      child: SizedBox(
        height: 70,
        child: AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget? child) {
            final EdgeInsets e =
                tween.transform(controller.value);
            return Container(
              padding: e,
              decoration: BoxDecoration(
                color: const Color(0xFFFFE0B2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: Color(0xFFE65100),
                  shape: BoxShape.circle,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 4: TweenSequence bouncing ball.
// ---------------------------------------------------------------------------

class _TweenSequenceSection extends StatelessWidget {
  _TweenSequenceSection({required this.controller});

  final AnimationController controller;

  // 3 items: shoot up (weight 1, easeOut), fall (weight 2, bounceOut), pause.
  late final Animation<double> _sequence = TweenSequence<double>(
    <TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 1.0,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.0, end: 0.0)
            .chain(CurveTween(curve: Curves.bounceOut)),
        weight: 2.0,
      ),
      TweenSequenceItem<double>(
        tween: ConstantTween<double>(0.0),
        weight: 1.0,
      ),
    ],
  ).animate(controller);

  @override
  Widget build(BuildContext context) {
    return _Bench(
      index: 4,
      title: 'TweenSequence: a bouncing ball',
      subtitle:
          'A TweenSequence stitches multiple weighted tweens into a single '
          'Animation<T>. Weights determine the fraction of the parent '
          'animation each segment occupies. The timeline below shows the '
          'three weighted segments.',
      icon: Icons.sports_basketball,
      color: const Color(0xFFEF6C00),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 130,
            child: AnimatedBuilder(
              animation: _sequence,
              builder: (BuildContext context, Widget? child) {
                final double h = _sequence.value;
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      height: 4,
                      color: const Color(0xFF6D4C41),
                    ),
                    Positioned(
                      bottom: 4 + h * 90,
                      child: Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEF6C00),
                          shape: BoxShape.circle,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.25),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: _SeqBar(
                  label: 'rise (easeOut)',
                  color: const Color(0xFF66BB6A),
                ),
              ),
              const SizedBox(width: 2),
              Expanded(
                flex: 2,
                child: _SeqBar(
                  label: 'fall (bounceOut)',
                  color: const Color(0xFFEF6C00),
                ),
              ),
              const SizedBox(width: 2),
              Expanded(
                flex: 1,
                child: _SeqBar(
                  label: 'pause (constant)',
                  color: const Color(0xFF90A4AE),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SeqBar extends StatelessWidget {
  const _SeqBar({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 10,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 5: CurvedAnimation chain.
// ---------------------------------------------------------------------------

class _CurvedChainSection extends StatelessWidget {
  const _CurvedChainSection({
    required this.easeIn,
    required this.elasticOut,
  });

  final Animation<double> easeIn;
  final Animation<double> elasticOut;

  @override
  Widget build(BuildContext context) {
    return _Bench(
      index: 5,
      title: 'CurvedAnimation: same controller, two feels',
      subtitle:
          'Two CurvedAnimation views share one controller. The left track is '
          'wrapped in easeIn, the right in elasticOut. Both advance in '
          'lockstep, but the visible motion differs because each Curve '
          'remaps the parent value.',
      icon: Icons.compare_arrows,
      color: const Color(0xFF388E3C),
      child: Column(
        children: <Widget>[
          _CurvedTrack(label: 'easeIn', anim: easeIn, color: const Color(0xFF388E3C)),
          const SizedBox(height: 10),
          _CurvedTrack(
            label: 'elasticOut',
            anim: elasticOut,
            color: const Color(0xFF7B1FA2),
          ),
        ],
      ),
    );
  }
}

class _CurvedTrack extends StatelessWidget {
  const _CurvedTrack({
    required this.label,
    required this.anim,
    required this.color,
  });

  final String label;
  final Animation<double> anim;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 88,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 28,
            child: AnimatedBuilder(
              animation: anim,
              builder: (BuildContext context, Widget? child) {
                final double v = anim.value.clamp(-0.1, 1.1);
                return Stack(
                  alignment: Alignment.centerLeft,
                  children: <Widget>[
                    Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left:
                                ((v + 0.1) / 1.2 * (constraints.maxWidth - 22))
                                    .clamp(0.0, constraints.maxWidth - 22),
                          ),
                          child: Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 6: ProxyAnimation + ReverseAnimation.
// ---------------------------------------------------------------------------

class _ProxyReverseSection extends StatelessWidget {
  const _ProxyReverseSection({
    required this.primary,
    required this.reversed,
    required this.proxy,
    required this.proxyOnElastic,
  });

  final Animation<double> primary;
  final Animation<double> reversed;
  final ProxyAnimation proxy;
  final bool proxyOnElastic;

  @override
  Widget build(BuildContext context) {
    return _Bench(
      index: 6,
      title: 'ProxyAnimation and ReverseAnimation',
      subtitle:
          'ReverseAnimation reads parent.value as (1 - parent.value). '
          'ProxyAnimation forwards to a parent that can be swapped at '
          'runtime — useful when the source animation changes mid-flight. '
          'The proxy below alternates between easeIn and elasticOut after '
          'each forward completion.',
      icon: Icons.swap_horiz,
      color: const Color(0xFF0288D1),
      child: Column(
        children: <Widget>[
          _DotRow(label: 'controller', anim: primary, color: const Color(0xFF0288D1)),
          const SizedBox(height: 8),
          _DotRow(
            label: 'reversed',
            anim: reversed,
            color: const Color(0xFFD81B60),
          ),
          const SizedBox(height: 8),
          _DotRow(
            label: 'proxy (${proxyOnElastic ? "elasticOut" : "easeIn"})',
            anim: proxy,
            color: const Color(0xFF6A1B9A),
          ),
        ],
      ),
    );
  }
}

class _DotRow extends StatelessWidget {
  const _DotRow({
    required this.label,
    required this.anim,
    required this.color,
  });

  final String label;
  final Animation<double> anim;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 22,
            child: AnimatedBuilder(
              animation: anim,
              builder: (BuildContext context, Widget? child) {
                final double v = anim.value.clamp(-0.1, 1.1);
                return LayoutBuilder(
                  builder:
                      (BuildContext context, BoxConstraints constraints) {
                    final double w = constraints.maxWidth - 18;
                    return Stack(
                      children: <Widget>[
                        Positioned(
                          top: 9,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 2,
                            color: color.withValues(alpha: 0.15),
                          ),
                        ),
                        Positioned(
                          left: ((v + 0.1) / 1.2 * w).clamp(0.0, w),
                          top: 2,
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 7: Compound animations (min, max, mean).
// ---------------------------------------------------------------------------

class _CompoundSection extends StatelessWidget {
  const _CompoundSection({
    required this.a,
    required this.b,
    required this.minA,
    required this.maxA,
    required this.meanA,
  });

  final Animation<double> a;
  final Animation<double> b;
  final Animation<double> minA;
  final Animation<double> maxA;
  final Animation<double> meanA;

  @override
  Widget build(BuildContext context) {
    return _Bench(
      index: 7,
      title: 'CompoundAnimation: min, max, mean',
      subtitle:
          'AnimationMin, AnimationMax (and a custom mean subclass of '
          'CompoundAnimation) blend two parents into one Animation<double>. '
          'Below: parents A and B running at different speeds, plus the '
          'three compound traces.',
      icon: Icons.merge_type,
      color: const Color(0xFF5E35B1),
      child: Column(
        children: <Widget>[
          _Trace(label: 'A (primary)', anim: a, color: const Color(0xFF1976D2)),
          _Trace(label: 'B (secondary)', anim: b, color: const Color(0xFF00897B)),
          _Trace(label: 'min(A, B)', anim: minA, color: const Color(0xFFD81B60)),
          _Trace(label: 'max(A, B)', anim: maxA, color: const Color(0xFFF9A825)),
          _Trace(label: 'mean(A, B)', anim: meanA, color: const Color(0xFF5E35B1)),
        ],
      ),
    );
  }
}

class _Trace extends StatelessWidget {
  const _Trace({
    required this.label,
    required this.anim,
    required this.color,
  });

  final String label;
  final Animation<double> anim;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 16,
              child: AnimatedBuilder(
                animation: anim,
                builder: (BuildContext context, Widget? child) {
                  final double v = anim.value.clamp(0.0, 1.0);
                  return Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: v,
                        child: Container(
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 44,
            child: AnimatedBuilder(
              animation: anim,
              builder: (BuildContext context, Widget? child) {
                return Text(
                  anim.value.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 10,
                    fontFamily: 'monospace',
                  ),
                  textAlign: TextAlign.right,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Concrete mean subclass of CompoundAnimation, since AnimationMean is not
// part of the public Flutter SDK on all channels — we synthesize it.
class _MeanAnimation extends CompoundAnimation<double> {
  _MeanAnimation(Animation<double> first, Animation<double> next)
      : super(first: first, next: next);

  @override
  double get value => (first.value + next.value) / 2.0;
}

// ---------------------------------------------------------------------------
// SECTION 8: Status listener demo.
// ---------------------------------------------------------------------------

class _StatusListenerSection extends StatelessWidget {
  const _StatusListenerSection({required this.status});

  final AnimationStatus status;

  @override
  Widget build(BuildContext context) {
    return _Bench(
      index: 8,
      title: 'AnimationStatus listeners',
      subtitle:
          'addStatusListener fires whenever the AnimationStatus changes. The '
          'four chips below light up to reflect the live status of the '
          'primary controller.',
      icon: Icons.traffic,
      color: const Color(0xFFC2185B),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: <Widget>[
          _StatusChip(
            label: 'dismissed',
            color: const Color(0xFF9E9E9E),
            active: status == AnimationStatus.dismissed,
          ),
          _StatusChip(
            label: 'forward',
            color: const Color(0xFFF9A825),
            active: status == AnimationStatus.forward,
          ),
          _StatusChip(
            label: 'completed',
            color: const Color(0xFF2E7D32),
            active: status == AnimationStatus.completed,
          ),
          _StatusChip(
            label: 'reverse',
            color: const Color(0xFFD32F2F),
            active: status == AnimationStatus.reverse,
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.label,
    required this.color,
    required this.active,
  });

  final String label;
  final Color color;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: active ? color : color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: active ? Colors.white : color,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: active ? Colors.white : color,
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 9: AlwaysStoppedAnimation.
// ---------------------------------------------------------------------------

class _AlwaysStoppedSection extends StatelessWidget {
  const _AlwaysStoppedSection();

  @override
  Widget build(BuildContext context) {
    return _Bench(
      index: 9,
      title: 'AlwaysStoppedAnimation',
      subtitle:
          'AlwaysStoppedAnimation<T> presents a constant value and a status '
          'permanently set to AnimationStatus.dismissed. It is ideal for '
          'plugging a static value into APIs that expect Animation<T>, e.g. '
          'a FadeTransition that never animates.',
      icon: Icons.pause_circle_filled,
      color: const Color(0xFF455A64),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFECEFF1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'final fade = AlwaysStoppedAnimation<double>(0.5);',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Color(0xFF263238),
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'FadeTransition(opacity: fade, child: badge)',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Color(0xFF263238),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'No controller, no ticker, no dispose() needed.',
                    style: TextStyle(fontSize: 12, color: Color(0xFF455A64)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 14),
          FadeTransition(
            opacity: const AlwaysStoppedAnimation<double>(0.5),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF455A64),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'HALF-FADED',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                  letterSpacing: 1.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 10: Best practices.
// ---------------------------------------------------------------------------

class _BestPracticesSection extends StatelessWidget {
  const _BestPracticesSection();

  @override
  Widget build(BuildContext context) {
    return _Bench(
      index: 10,
      title: 'Best practices',
      subtitle:
          'A short field guide for picking the right primitive and keeping '
          'controllers healthy.',
      icon: Icons.lightbulb,
      color: const Color(0xFFF9A825),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Bullet(
            color: Color(0xFFD32F2F),
            title: 'Always dispose() controllers.',
            body:
                'Every AnimationController owns a Ticker. Leaking one keeps '
                'the frame callback alive and prints "AnimationController '
                'methods should not be used after calling dispose".',
          ),
          _Bullet(
            color: Color(0xFFF9A825),
            title: 'Remove listeners you add.',
            body:
                'addListener/addStatusListener pin the closure. If the '
                'closure captures BuildContext or State, you risk leaking '
                'the whole subtree. Remove the listener in dispose().',
          ),
          _Bullet(
            color: Color(0xFF2E7D32),
            title: 'Prefer implicit animations for simple cases.',
            body:
                'AnimatedContainer, AnimatedOpacity, TweenAnimationBuilder '
                'cover most "move this from A to B over D" needs without '
                'requiring a controller.',
          ),
          _Bullet(
            color: Color(0xFF1976D2),
            title: 'Use TickerMode and SingleTickerProvider correctly.',
            body:
                'Off-screen pages should not be ticking. TickerMode and the '
                'SingleTickerProviderStateMixin / TickerProviderStateMixin '
                'distinction matters for performance.',
          ),
          _Bullet(
            color: Color(0xFF6A1B9A),
            title: 'Wrap CurvedAnimation, do not chain Tween.chain blindly.',
            body:
                'CurvedAnimation maps the parent value through a Curve once '
                'per frame. tween.chain(CurveTween(...)) is great inside '
                'TweenSequenceItem, but for a controller wrap it once in '
                'CurvedAnimation and reuse.',
          ),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({
    required this.color,
    required this.title,
    required this.body,
  });

  final Color color;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: color,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  body,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: Colors.grey.shade800,
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

// ---------------------------------------------------------------------------
// Footer.
// ---------------------------------------------------------------------------

class _LabFooter extends StatelessWidget {
  const _LabFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF263238),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.science, color: Color(0xFFBBE1FA)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'End of the animation laboratory. Every section above is built '
              'from the same primitives: Animation, Tween, Curve.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withValues(alpha: 0.85),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
