// D4rt test script: Deep Demo - Animatable / Tween family
// Comprehensive visual demonstration of Flutter animation building blocks:
// Animatable, Tween<double>, CurveTween, TweenSequence, ColorTween,
// ConstantTween, IntTween, RectTween, SizeTween, AlignmentTween,
// BorderRadiusTween, DecorationTween — plus live demonstrations using
// TweenAnimationBuilder and the AnimatedXxx widget family.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ===========================================================================
  // PALETTE - shared design tokens used throughout the demo
  // ===========================================================================

  const Color palInk = Color(0xFF161A2E);
  const Color palInkSoft = Color(0xFF4A4F70);
  const Color palAccent = Color(0xFF7C4DFF);
  const Color palAccentSoft = Color(0xFFE6DDFF);
  const Color palMagenta = Color(0xFFE91E63);
  const Color palMagentaSoft = Color(0xFFFFE0EC);
  const Color palTeal = Color(0xFF009688);
  const Color palTealSoft = Color(0xFFD0F0EC);
  const Color palAmber = Color(0xFFFFA000);
  const Color palAmberSoft = Color(0xFFFFE8C2);
  const Color palCyan = Color(0xFF00B0FF);
  const Color palCyanSoft = Color(0xFFCEEEFB);
  const Color palLime = Color(0xFF8BC34A);
  const Color palLimeSoft = Color(0xFFE0F2C7);
  const Color palRose = Color(0xFFE53935);
  const Color palRoseSoft = Color(0xFFFFD8D7);
  const Color palIndigo = Color(0xFF3F51B5);
  const Color palIndigoSoft = Color(0xFFD9DEF5);
  const Color palDeepPurple = Color(0xFF512DA8);
  const Color palDeepPurpleSoft = Color(0xFFDDD3F2);
  const Color palOrange = Color(0xFFFF6D00);
  const Color palOrangeSoft = Color(0xFFFFDFC1);
  const Color palGreenDark = Color(0xFF1B5E20);
  const Color palGreenDarkSoft = Color(0xFFC9E5CC);
  const Color palSurface = Color(0xFFF7F6FB);
  const Color palSurfaceAlt = Color(0xFFEEEAF6);
  const Color palOutline = Color(0xFFD7D1E4);

  // ===========================================================================
  // SECTION SHELL HELPER - wraps each section in a uniform titled card
  // ===========================================================================

  Widget sectionShell({
    required String title,
    required String subtitle,
    required Color surface,
    required Color border,
    required Color titleColor,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: border, width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: titleColor.withValues(alpha: 0.10),
            blurRadius: 16.0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 14.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  titleColor.withValues(alpha: 0.18),
                  titleColor.withValues(alpha: 0.04),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(17.0),
                topRight: Radius.circular(17.0),
              ),
              border: Border(
                bottom: BorderSide(
                  color: titleColor.withValues(alpha: 0.35),
                  width: 1.4,
                ),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 8.0,
                  height: 44.0,
                  decoration: BoxDecoration(
                    color: titleColor,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                const SizedBox(width: 14.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          color: titleColor,
                          fontSize: 19.0,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: palInkSoft,
                          fontSize: 12.5,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: child,
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SMALL HELPERS - badges, captions, value displays
  // ===========================================================================

  Widget chip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: color.withValues(alpha: 0.45), width: 1.0),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget caption(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 2.0),
      child: Text(
        text,
        style: const TextStyle(
          color: palInkSoft,
          fontSize: 12.0,
          height: 1.45,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  Widget codeLine(String code) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: palInk.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        code,
        style: const TextStyle(
          color: Color(0xFFB6E0FF),
          fontFamily: 'monospace',
          fontSize: 12.0,
          height: 1.5,
        ),
      ),
    );
  }

  // ===========================================================================
  // HERO BANNER
  // ===========================================================================

  final Widget heroBanner = Container(
    margin: const EdgeInsets.only(bottom: 6.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF1A0E3E),
          Color(0xFF512DA8),
          Color(0xFFE91E63),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(22.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.28),
          blurRadius: 24.0,
          offset: const Offset(0, 14),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                  width: 1.4,
                ),
              ),
              child: const Icon(
                Icons.animation,
                color: Colors.white,
                size: 40.0,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Animatable & Tween — Deep Demo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    'Live demonstrations of every core tween — driven by '
                    'TweenAnimationBuilder and the AnimatedXxx widget family, '
                    'all interpreted by D4rt at runtime.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.93),
                      fontSize: 13.5,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            chip('Tween<double>', Colors.white),
            chip('ColorTween', Colors.white),
            chip('IntTween', Colors.white),
            chip('RectTween', Colors.white),
            chip('SizeTween', Colors.white),
            chip('AlignmentTween', Colors.white),
            chip('BorderRadiusTween', Colors.white),
            chip('DecorationTween', Colors.white),
            chip('CurveTween', Colors.white),
            chip('TweenSequence', Colors.white),
            chip('ConstantTween', Colors.white),
            chip('AnimatedContainer', Colors.white),
            chip('AnimatedSwitcher', Colors.white),
            chip('TweenAnimationBuilder', Colors.white),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 01 - Tween<double> for opacity, driven by TweenAnimationBuilder
  // ===========================================================================

  final Widget section01 = sectionShell(
    title: 'Section 01 — Tween<double> opacity ramp',
    subtitle:
        'A Tween<double>(begin: 0.05, end: 1.0) feeds TweenAnimationBuilder<double>. '
        'On first build the value sweeps from begin to end across the duration.',
    surface: palSurface,
    border: palOutline,
    titleColor: palAccent,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        codeLine('Tween<double>(begin: 0.05, end: 1.0)'),
        codeLine('TweenAnimationBuilder<double>(duration: 2200ms, ...)'),
        const SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            for (int i = 0; i < 5; i = i + 1)
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.05, end: 1.0),
                duration: Duration(milliseconds: 1400 + i * 300),
                curve: Curves.easeOutCubic,
                builder: (BuildContext c, double v, Widget? _) {
                  return Opacity(
                    opacity: v,
                    child: Container(
                      width: 56.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            palAccent,
                            palAccent.withValues(alpha: 0.55),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        v.toStringAsFixed(2),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
        const SizedBox(height: 14.0),
        caption(
          'Each box uses an independent TweenAnimationBuilder with a '
          'progressively longer duration, so they ramp into view at staggered '
          'paces.',
        ),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            chip('begin: 0.05', palAccent),
            chip('end: 1.0', palAccent),
            chip('Curves.easeOutCubic', palAccent),
            chip('Opacity widget', palDeepPurple),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 02 - ColorTween via TweenAnimationBuilder<Color?>
  // ===========================================================================

  final List<Map<String, Color>> colorPairs = <Map<String, Color>>[
    <String, Color>{'a': palAccent, 'b': palMagenta},
    <String, Color>{'a': palTeal, 'b': palAmber},
    <String, Color>{'a': palCyan, 'b': palRose},
    <String, Color>{'a': palIndigo, 'b': palLime},
  ];

  final Widget section02 = sectionShell(
    title: 'Section 02 — ColorTween interpolation',
    subtitle:
        'ColorTween(begin: A, end: B) returns Color? values along the animation. '
        'Useful for theme-style transitions and accent swaps.',
    surface: palMagentaSoft.withValues(alpha: 0.45),
    border: palMagenta.withValues(alpha: 0.35),
    titleColor: palMagenta,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        codeLine('ColorTween(begin: A, end: B).animate(controller)'),
        codeLine('TweenAnimationBuilder<Color?>(tween: ColorTween(...))'),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: List<Widget>.generate(colorPairs.length, (int i) {
            final Color a = colorPairs[i]['a']!;
            final Color b = colorPairs[i]['b']!;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TweenAnimationBuilder<Color?>(
                  tween: ColorTween(begin: a, end: b),
                  duration: const Duration(milliseconds: 2400),
                  curve: Curves.easeInOut,
                  builder: (BuildContext c, Color? v, Widget? _) {
                    return Container(
                      width: 110.0,
                      height: 84.0,
                      decoration: BoxDecoration(
                        color: v ?? a,
                        borderRadius: BorderRadius.circular(14.0),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: (v ?? a).withValues(alpha: 0.45),
                            blurRadius: 12.0,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '#${(v ?? a).toARGB32().toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'monospace',
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 6.0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: 14.0,
                      height: 14.0,
                      decoration: BoxDecoration(
                        color: a,
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    const Icon(Icons.arrow_forward, size: 12.0),
                    const SizedBox(width: 4.0),
                    Container(
                      width: 14.0,
                      height: 14.0,
                      decoration: BoxDecoration(
                        color: b,
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
        const SizedBox(height: 14.0),
        caption(
          'Color? is the natural type because ColorTween permits null end-points '
          'to fade to/from transparent.',
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 03 - IntTween counters
  // ===========================================================================

  final List<Map<String, dynamic>> counterSpecs = <Map<String, dynamic>>[
    <String, dynamic>{
      'label': 'Active users',
      'end': 12480,
      'icon': Icons.people,
      'color': palAccent,
    },
    <String, dynamic>{
      'label': 'Daily syncs',
      'end': 9342,
      'icon': Icons.sync,
      'color': palTeal,
    },
    <String, dynamic>{
      'label': 'Sessions',
      'end': 2187,
      'icon': Icons.timeline,
      'color': palMagenta,
    },
    <String, dynamic>{
      'label': 'Reports',
      'end': 642,
      'icon': Icons.bar_chart,
      'color': palAmber,
    },
  ];

  final Widget section03 = sectionShell(
    title: 'Section 03 — IntTween counters',
    subtitle:
        'IntTween rounds the lerped double back to int. Perfect for animated '
        'metric badges that should never display fractional digits.',
    surface: palTealSoft.withValues(alpha: 0.4),
    border: palTeal.withValues(alpha: 0.35),
    titleColor: palTeal,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        codeLine('IntTween(begin: 0, end: end).animate(controller)'),
        codeLine('TweenAnimationBuilder<int>(tween: IntTween(...), ...)'),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: List<Widget>.generate(counterSpecs.length, (int i) {
            final Map<String, dynamic> spec = counterSpecs[i];
            final int target = spec['end'] as int;
            final IconData icon = spec['icon'] as IconData;
            final Color color = spec['color'] as Color;
            final String label = spec['label'] as String;
            return Container(
              width: 170.0,
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: color.withValues(alpha: 0.4),
                  width: 1.2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Icon(icon, color: color, size: 22.0),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Text(
                          label,
                          style: const TextStyle(
                            color: palInkSoft,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  TweenAnimationBuilder<int>(
                    tween: IntTween(begin: 0, end: target),
                    duration: const Duration(milliseconds: 2600),
                    curve: Curves.easeOutCubic,
                    builder: (BuildContext c, int v, Widget? _) {
                      return Text(
                        v.toString(),
                        style: TextStyle(
                          color: color,
                          fontSize: 28.0,
                          fontWeight: FontWeight.w900,
                          fontFeatures: const <FontFeature>[
                            FontFeature.tabularFigures(),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'target $target',
                    style: TextStyle(
                      color: palInkSoft,
                      fontSize: 11.0,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 04 - RectTween via AnimatedPositioned in a Stack
  // ===========================================================================

  final Widget section04 = sectionShell(
    title: 'Section 04 — RectTween & AnimatedPositioned',
    subtitle:
        'AnimatedPositioned implicitly interpolates left/top/width/height. '
        'The conceptual tween is a RectTween that lerps the bounding rect.',
    surface: palAmberSoft.withValues(alpha: 0.4),
    border: palAmber.withValues(alpha: 0.4),
    titleColor: palAmber,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        codeLine('RectTween(begin: Rect.fromLTWH(...), end: Rect.fromLTWH(...))'),
        codeLine('AnimatedPositioned(left:, top:, width:, height:, duration:)'),
        const SizedBox(height: 14.0),
        Container(
          height: 220.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: palOutline, width: 1.0),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: <Widget>[
              AnimatedPositioned(
                left: 12.0,
                top: 12.0,
                width: 180.0,
                height: 80.0,
                duration: const Duration(milliseconds: 2200),
                curve: Curves.easeInOutCubic,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: <Color>[palAmber, palOrange],
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'panel A',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                left: 200.0,
                top: 110.0,
                width: 140.0,
                height: 70.0,
                duration: const Duration(milliseconds: 2600),
                curve: Curves.elasticOut,
                child: Container(
                  decoration: BoxDecoration(
                    color: palMagenta,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: palMagenta.withValues(alpha: 0.5),
                        blurRadius: 14.0,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'panel B',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                left: 70.0,
                top: 130.0,
                width: 100.0,
                height: 60.0,
                duration: const Duration(milliseconds: 1800),
                curve: Curves.easeOutBack,
                child: Container(
                  decoration: BoxDecoration(
                    color: palTeal,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'C',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            chip('Curves.easeInOutCubic', palAmber),
            chip('Curves.elasticOut', palMagenta),
            chip('Curves.easeOutBack', palTeal),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 05 - SizeTween via AnimatedSize
  // ===========================================================================

  final List<Map<String, dynamic>> sizeCards = <Map<String, dynamic>>[
    <String, dynamic>{
      'w': 120.0,
      'h': 60.0,
      'label': 'compact',
      'color': palCyan,
    },
    <String, dynamic>{
      'w': 180.0,
      'h': 100.0,
      'label': 'medium',
      'color': palAccent,
    },
    <String, dynamic>{
      'w': 240.0,
      'h': 140.0,
      'label': 'expanded',
      'color': palMagenta,
    },
  ];

  final Widget section05 = sectionShell(
    title: 'Section 05 — SizeTween & AnimatedSize',
    subtitle:
        'AnimatedSize tweens between layout sizes of its child. The implied '
        'SizeTween lerps width and height independently.',
    surface: palCyanSoft.withValues(alpha: 0.45),
    border: palCyan.withValues(alpha: 0.35),
    titleColor: palCyan,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        codeLine('SizeTween(begin: Size(w1,h1), end: Size(w2,h2))'),
        codeLine('AnimatedSize(duration: 1200ms, curve: Curves.easeOutCubic)'),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          alignment: WrapAlignment.center,
          children: List<Widget>.generate(sizeCards.length, (int i) {
            final Map<String, dynamic> spec = sizeCards[i];
            final double w = spec['w'] as double;
            final double h = spec['h'] as double;
            final Color color = spec['color'] as Color;
            final String label = spec['label'] as String;
            return Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: palOutline, width: 1.0),
              ),
              child: AnimatedSize(
                duration: const Duration(milliseconds: 1400),
                curve: Curves.easeOutCubic,
                child: Container(
                  width: w,
                  height: h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        color,
                        color.withValues(alpha: 0.55),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        '${w.toInt()} × ${h.toInt()}',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 11.0,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 10.0),
        caption(
          'Each AnimatedSize wraps its rendered child — D4rt re-invokes build, '
          'and Flutter morphs the layout on every change.',
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 06 - AlignmentTween & AnimatedAlign
  // ===========================================================================

  final List<Alignment> alignmentTargets = <Alignment>[
    Alignment.topLeft,
    Alignment.topCenter,
    Alignment.topRight,
    Alignment.centerLeft,
    Alignment.center,
    Alignment.centerRight,
    Alignment.bottomLeft,
    Alignment.bottomCenter,
    Alignment.bottomRight,
  ];

  final List<String> alignmentNames = <String>[
    'topLeft',
    'topCenter',
    'topRight',
    'centerLeft',
    'center',
    'centerRight',
    'bottomLeft',
    'bottomCenter',
    'bottomRight',
  ];

  final Widget section06 = sectionShell(
    title: 'Section 06 — AlignmentTween & AnimatedAlign',
    subtitle:
        'AlignmentTween lerps between two Alignment values. AnimatedAlign uses '
        'it implicitly to glide a child between anchor positions.',
    surface: palLimeSoft.withValues(alpha: 0.5),
    border: palLime.withValues(alpha: 0.4),
    titleColor: palLime,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        codeLine('AlignmentTween(begin: Alignment.topLeft, end: Alignment.bottomRight)'),
        codeLine('AnimatedAlign(alignment: ..., duration: 1500ms)'),
        const SizedBox(height: 14.0),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          children: List<Widget>.generate(alignmentTargets.length, (int i) {
            final Alignment align = alignmentTargets[i];
            final String name = alignmentNames[i];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: palLime.withValues(alpha: 0.5),
                  width: 1.0,
                ),
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: AnimatedAlign(
                      alignment: align,
                      duration: const Duration(milliseconds: 1600),
                      curve: Curves.easeOutBack,
                      child: Container(
                        width: 22.0,
                        height: 22.0,
                        decoration: BoxDecoration(
                          color: palGreenDark,
                          borderRadius: BorderRadius.circular(6.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: palGreenDark.withValues(alpha: 0.45),
                              blurRadius: 6.0,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    decoration: BoxDecoration(
                      color: palLime.withValues(alpha: 0.18),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(11.0),
                        bottomRight: Radius.circular(11.0),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      name,
                      style: const TextStyle(
                        color: palGreenDark,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 07 - BorderRadiusTween via AnimatedContainer
  // ===========================================================================

  final List<Map<String, dynamic>> radiusSpecs = <Map<String, dynamic>>[
    <String, dynamic>{
      'radius': 6.0,
      'label': 'crisp',
      'color': palIndigo,
    },
    <String, dynamic>{
      'radius': 18.0,
      'label': 'soft',
      'color': palAccent,
    },
    <String, dynamic>{
      'radius': 36.0,
      'label': 'pill',
      'color': palMagenta,
    },
    <String, dynamic>{
      'radius': 60.0,
      'label': 'blob',
      'color': palTeal,
    },
  ];

  final Widget section07 = sectionShell(
    title: 'Section 07 — BorderRadiusTween in AnimatedContainer',
    subtitle:
        'When AnimatedContainer detects a borderRadius change inside its '
        'BoxDecoration, it uses BorderRadiusTween under the hood.',
    surface: palIndigoSoft.withValues(alpha: 0.45),
    border: palIndigo.withValues(alpha: 0.35),
    titleColor: palIndigo,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        codeLine('BorderRadiusTween(begin: BorderRadius.circular(4), end: BorderRadius.circular(64))'),
        codeLine('AnimatedContainer(decoration: BoxDecoration(borderRadius: ...))'),
        const SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List<Widget>.generate(radiusSpecs.length, (int i) {
            final Map<String, dynamic> spec = radiusSpecs[i];
            final double radius = spec['radius'] as double;
            final Color color = spec['color'] as Color;
            final String label = spec['label'] as String;
            return Column(
              children: <Widget>[
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.easeOutCubic,
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(radius),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: color.withValues(alpha: 0.45),
                        blurRadius: 12.0,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  label,
                  style: const TextStyle(
                    color: palInk,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'r=${radius.toInt()}',
                  style: TextStyle(
                    color: palInkSoft,
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 08 - DecorationTween via AnimatedContainer
  // ===========================================================================

  final Widget section08 = sectionShell(
    title: 'Section 08 — DecorationTween: full BoxDecoration morph',
    subtitle:
        'DecorationTween lerps BoxDecoration as a whole, blending gradient, '
        'colour, border, shadow, and radius simultaneously.',
    surface: palDeepPurpleSoft.withValues(alpha: 0.45),
    border: palDeepPurple.withValues(alpha: 0.35),
    titleColor: palDeepPurple,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        codeLine('DecorationTween(begin: BoxDecoration(...), end: BoxDecoration(...))'),
        codeLine('AnimatedContainer(decoration: target, duration: 2s)'),
        const SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            AnimatedContainer(
              duration: const Duration(milliseconds: 2200),
              curve: Curves.easeInOutCubic,
              width: 130.0,
              height: 130.0,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: <Color>[palDeepPurple, palAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: palDeepPurple.withValues(alpha: 0.45),
                    blurRadius: 18.0,
                    offset: const Offset(0, 8),
                  ),
                ],
                border: Border.all(color: Colors.white, width: 3.0),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.spa,
                color: Colors.white,
                size: 48.0,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 2400),
              curve: Curves.easeInOutCubic,
              width: 130.0,
              height: 130.0,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: <Color>[palMagenta, palOrange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(60.0),
                  bottomRight: Radius.circular(60.0),
                  topRight: Radius.circular(12.0),
                  bottomLeft: Radius.circular(12.0),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: palMagenta.withValues(alpha: 0.45),
                    blurRadius: 20.0,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.local_fire_department,
                color: Colors.white,
                size: 48.0,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 2600),
              curve: Curves.easeInOutCubic,
              width: 130.0,
              height: 130.0,
              decoration: BoxDecoration(
                gradient: const RadialGradient(
                  colors: <Color>[palCyan, palIndigo],
                  radius: 1.0,
                ),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: palCyan.withValues(alpha: 0.45),
                    blurRadius: 22.0,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.water_drop,
                color: Colors.white,
                size: 48.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        caption(
          'Three independent AnimatedContainers — each implicitly built on '
          'DecorationTween — drift in from defaults to their target decoration.',
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 09 - CurveTween basics
  // ===========================================================================

  final List<Map<String, dynamic>> curveSpecs = <Map<String, dynamic>>[
    <String, dynamic>{
      'curve': Curves.linear,
      'name': 'linear',
      'color': palInkSoft,
    },
    <String, dynamic>{
      'curve': Curves.easeIn,
      'name': 'easeIn',
      'color': palAccent,
    },
    <String, dynamic>{
      'curve': Curves.easeOut,
      'name': 'easeOut',
      'color': palMagenta,
    },
    <String, dynamic>{
      'curve': Curves.easeInOut,
      'name': 'easeInOut',
      'color': palTeal,
    },
    <String, dynamic>{
      'curve': Curves.bounceOut,
      'name': 'bounceOut',
      'color': palAmber,
    },
    <String, dynamic>{
      'curve': Curves.elasticOut,
      'name': 'elasticOut',
      'color': palRose,
    },
    <String, dynamic>{
      'curve': Curves.easeOutCubic,
      'name': 'easeOutCubic',
      'color': palIndigo,
    },
    <String, dynamic>{
      'curve': Curves.easeInBack,
      'name': 'easeInBack',
      'color': palOrange,
    },
  ];

  final Widget section09 = sectionShell(
    title: 'Section 09 — CurveTween wrapping common curves',
    subtitle:
        'CurveTween wraps any Curve. When chained onto Tween.chain, it remaps '
        'the time axis without changing the begin/end values.',
    surface: palAccentSoft.withValues(alpha: 0.45),
    border: palAccent.withValues(alpha: 0.4),
    titleColor: palAccent,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        codeLine('final CurveTween curve = CurveTween(curve: Curves.bounceOut);'),
        codeLine('Tween<double>(begin: 0, end: 1).chain(curve)'),
        const SizedBox(height: 14.0),
        Column(
          children: List<Widget>.generate(curveSpecs.length, (int i) {
            final Map<String, dynamic> spec = curveSpecs[i];
            final Curve curve = spec['curve'] as Curve;
            final String name = spec['name'] as String;
            final Color color = spec['color'] as Color;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 120.0,
                    child: Text(
                      name,
                      style: TextStyle(
                        color: color,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 18.0,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(9.0),
                        border: Border.all(
                          color: color.withValues(alpha: 0.3),
                          width: 1.0,
                        ),
                      ),
                      child: Stack(
                        children: <Widget>[
                          FractionallySizedBox(
                            widthFactor: 1.0,
                            child: TweenAnimationBuilder<double>(
                              tween: Tween<double>(begin: 0.0, end: 1.0),
                              duration: const Duration(milliseconds: 2400),
                              curve: curve,
                              builder: (BuildContext c, double v, Widget? _) {
                                return Align(
                                  alignment: Alignment.centerLeft,
                                  child: FractionallySizedBox(
                                    // FractionallySizedBox asserts
                                    // `widthFactor >= 0.0` (basic.dart:3224).
                                    // Curves like `easeInBack` / `elasticOut`
                                    // briefly produce negative output during
                                    // animation; the demo includes them in
                                    // `curveSpecs`, so clamp the lower bound
                                    // here. Upper bound (overshoot above 1)
                                    // is allowed by FractionallySizedBox.
                                    widthFactor: v < 0.0 ? 0.0 : v,
                                    heightFactor: 1.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: <Color>[
                                            color.withValues(alpha: 0.5),
                                            color,
                                          ],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(9.0),
                                      ),
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
                ],
              ),
            );
          }),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 10 - TweenSequence with multiple stops
  // ===========================================================================

  final TweenSequence<double> bouncyHeight = TweenSequence<double>(
    <TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 20.0, end: 120.0)
            .chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 30.0,
      ),
      TweenSequenceItem<double>(
        tween: ConstantTween<double>(120.0),
        weight: 10.0,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 120.0, end: 60.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 20.0,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 60.0, end: 160.0)
            .chain(CurveTween(curve: Curves.bounceOut)),
        weight: 40.0,
      ),
    ],
  );

  final Widget section10 = sectionShell(
    title: 'Section 10 — TweenSequence with multiple stops',
    subtitle:
        'TweenSequence stitches several tweens — each weighted — into a single '
        'Animatable. Ideal for hand-crafted keyframe-style motion.',
    surface: palRoseSoft.withValues(alpha: 0.5),
    border: palRose.withValues(alpha: 0.4),
    titleColor: palRose,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        codeLine('TweenSequence<double>([TweenSequenceItem(tween: ..., weight: 30), ...])'),
        codeLine('weights: 30, 10, 20, 40 — sum=100 (any positive numbers work)'),
        const SizedBox(height: 16.0),
        SizedBox(
          height: 200.0,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 3600),
            builder: (BuildContext c, double t, Widget? _) {
              final double v = bouncyHeight.transform(t);
              return Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Container(
                    height: 1.5,
                    color: palRose.withValues(alpha: 0.3),
                  ),
                  Container(
                    width: 110.0,
                    height: v,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: <Color>[palRose, palMagenta],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                      ),
                    ),
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text(
                        v.toStringAsFixed(1),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            chip('rise easeOutCubic', palRose),
            chip('hold (ConstantTween)', palOrange),
            chip('settle easeInOut', palMagenta),
            chip('rebound bounceOut', palDeepPurple),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 11 - CurveTween.chain combos (custom remappings)
  // ===========================================================================

  final List<Map<String, dynamic>> chainSpecs = <Map<String, dynamic>>[
    <String, dynamic>{
      'name': 'easeIn ∘ easeOut',
      'curve': const Interval(0.0, 1.0, curve: Curves.easeInOut),
      'color': palAccent,
    },
    <String, dynamic>{
      'name': 'fastOutSlowIn',
      'curve': Curves.fastOutSlowIn,
      'color': palMagenta,
    },
    <String, dynamic>{
      'name': 'slowMiddle',
      'curve': Curves.slowMiddle,
      'color': palTeal,
    },
    <String, dynamic>{
      'name': 'decelerate',
      'curve': Curves.decelerate,
      'color': palAmber,
    },
    <String, dynamic>{
      'name': 'easeInToLinear',
      'curve': Curves.easeInToLinear,
      'color': palCyan,
    },
    <String, dynamic>{
      'name': 'linearToEaseOut',
      'curve': Curves.linearToEaseOut,
      'color': palLime,
    },
  ];

  final Widget section11 = sectionShell(
    title: 'Section 11 — Chained CurveTween combos',
    subtitle:
        'Use Tween.chain(CurveTween(curve: ...)) to remap the t axis. The base '
        'tween still defines start/end values; the chained curve reshapes time.',
    surface: palTealSoft.withValues(alpha: 0.4),
    border: palTeal.withValues(alpha: 0.35),
    titleColor: palTeal,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        codeLine('final Animatable<double> rotator ='),
        codeLine('  Tween<double>(begin: 0, end: 1).chain(CurveTween(curve: Curves.fastOutSlowIn));'),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: List<Widget>.generate(chainSpecs.length, (int i) {
            final Map<String, dynamic> spec = chainSpecs[i];
            final Curve curve = spec['curve'] as Curve;
            final String name = spec['name'] as String;
            final Color color = spec['color'] as Color;
            return Container(
              width: 150.0,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: color.withValues(alpha: 0.4),
                  width: 1.2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                      color: color,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'monospace',
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 2400),
                    curve: curve,
                    builder: (BuildContext c, double v, Widget? _) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 8.0,
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: FractionallySizedBox(
                              // Clamp lower bound — see comment on the earlier
                              // FractionallySizedBox in this script. Curves
                              // like easeInBack briefly go negative, which
                              // would fail the framework's widthFactor >= 0.0
                              // assertion.
                              widthFactor: v < 0.0 ? 0.0 : v,
                              alignment: Alignment.centerLeft,
                              heightFactor: 1.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          Text(
                            't = ${v.toStringAsFixed(3)}',
                            style: TextStyle(
                              color: palInkSoft,
                              fontSize: 10.5,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 12 - AnimatedSwitcher with custom transitionBuilder
  // ===========================================================================

  final Widget switcherFade = AnimatedSwitcher(
    duration: const Duration(milliseconds: 800),
    switchInCurve: Curves.easeOutCubic,
    switchOutCurve: Curves.easeInCubic,
    transitionBuilder: (Widget child, Animation<double> anim) {
      return FadeTransition(
        opacity: anim,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.85, end: 1.0).animate(anim),
          child: child,
        ),
      );
    },
    child: Container(
      key: const ValueKey<String>('initial'),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[palAccent, palDeepPurple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: palAccent.withValues(alpha: 0.45),
            blurRadius: 16.0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.flash_on, color: Colors.white, size: 28.0),
          SizedBox(width: 10.0),
          Text(
            'fade + scale',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    ),
  );

  final Widget switcherSlide = AnimatedSwitcher(
    duration: const Duration(milliseconds: 900),
    transitionBuilder: (Widget child, Animation<double> anim) {
      final Animation<Offset> offsetAnim = Tween<Offset>(
        begin: const Offset(0.0, 0.4),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeOutCubic)).animate(anim);
      return SlideTransition(
        position: offsetAnim,
        child: FadeTransition(opacity: anim, child: child),
      );
    },
    child: Container(
      key: const ValueKey<String>('slide'),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[palCyan, palTeal],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.swap_vert, color: Colors.white, size: 28.0),
          SizedBox(width: 10.0),
          Text(
            'slide + fade',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    ),
  );

  final Widget switcherRotate = AnimatedSwitcher(
    duration: const Duration(milliseconds: 900),
    transitionBuilder: (Widget child, Animation<double> anim) {
      return RotationTransition(
        turns: Tween<double>(begin: 0.85, end: 1.0).animate(anim),
        child: FadeTransition(opacity: anim, child: child),
      );
    },
    child: Container(
      key: const ValueKey<String>('rotate'),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[palMagenta, palRose],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.refresh, color: Colors.white, size: 28.0),
          SizedBox(width: 10.0),
          Text(
            'rotate + fade',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    ),
  );

  final Widget section12 = sectionShell(
    title: 'Section 12 — AnimatedSwitcher with custom transitionBuilder',
    subtitle:
        'AnimatedSwitcher accepts a transitionBuilder that wraps the incoming '
        'child in any combination of FadeTransition, ScaleTransition, '
        'SlideTransition, RotationTransition — each backed by a Tween.',
    surface: palOrangeSoft.withValues(alpha: 0.4),
    border: palOrange.withValues(alpha: 0.4),
    titleColor: palOrange,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        codeLine('AnimatedSwitcher(transitionBuilder: (child, anim) => ...)'),
        codeLine('FadeTransition, ScaleTransition, SlideTransition, RotationTransition'),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          alignment: WrapAlignment.center,
          children: <Widget>[
            switcherFade,
            switcherSlide,
            switcherRotate,
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 13 - AnimatedCrossFade between two layouts
  // ===========================================================================

  final Widget crossFadeFirst = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: palAccent.withValues(alpha: 0.45), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.dashboard, color: palAccent, size: 22.0),
            const SizedBox(width: 8.0),
            const Text(
              'Compact view',
              style: TextStyle(
                color: palAccent,
                fontSize: 15.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          'A condensed summary suitable for narrow viewports.',
          style: TextStyle(color: palInkSoft, fontSize: 12.5),
        ),
      ],
    ),
  );

  final Widget crossFadeSecond = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[palDeepPurple, palAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.view_module, color: Colors.white, size: 22.0),
            const SizedBox(width: 8.0),
            const Text(
              'Detailed view',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          'Full layout with extra metadata, charts, and supplementary content.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.92),
            fontSize: 12.5,
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 6.0,
          children: <Widget>[
            chip('metric A', Colors.white),
            chip('metric B', Colors.white),
            chip('metric C', Colors.white),
            chip('metric D', Colors.white),
          ],
        ),
      ],
    ),
  );

  final Widget section13 = sectionShell(
    title: 'Section 13 — AnimatedCrossFade between layouts',
    subtitle:
        'AnimatedCrossFade interpolates between two children using a Tween '
        'pair: opacity in one direction, opacity-reverse in the other. '
        'Sizes interpolate via a built-in SizeTween.',
    surface: palLimeSoft.withValues(alpha: 0.5),
    border: palLime.withValues(alpha: 0.4),
    titleColor: palLime,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        codeLine('AnimatedCrossFade(firstChild:, secondChild:, crossFadeState:, duration:)'),
        const SizedBox(height: 14.0),
        AnimatedCrossFade(
          firstChild: crossFadeFirst,
          secondChild: crossFadeSecond,
          crossFadeState: CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 1400),
          sizeCurve: Curves.easeOutCubic,
        ),
        const SizedBox(height: 14.0),
        caption(
          'On initial paint the cross-fade shows the second child; the size '
          'and opacity tweens still play live as Flutter mounts the widget.',
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 14 - AnimatedTheme + AnimatedDefaultTextStyle
  // ===========================================================================

  final ThemeData themeTarget = ThemeData(
    brightness: Brightness.light,
    primaryColor: palDeepPurple,
    colorScheme: const ColorScheme.light(
      primary: palDeepPurple,
      secondary: palMagenta,
      surface: palAccentSoft,
    ),
  );

  final Widget section14 = sectionShell(
    title: 'Section 14 — AnimatedTheme & AnimatedDefaultTextStyle',
    subtitle:
        'AnimatedTheme drives a ThemeDataTween internally. '
        'AnimatedDefaultTextStyle uses TextStyleTween to morph fontSize, '
        'colour, weight, and letterSpacing simultaneously.',
    surface: palAccentSoft.withValues(alpha: 0.4),
    border: palAccent.withValues(alpha: 0.4),
    titleColor: palAccent,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        codeLine('ThemeDataTween — implicit inside AnimatedTheme'),
        codeLine('TextStyleTween — implicit inside AnimatedDefaultTextStyle'),
        const SizedBox(height: 14.0),
        AnimatedTheme(
          data: themeTarget,
          duration: const Duration(milliseconds: 2200),
          curve: Curves.easeOutCubic,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(color: palOutline, width: 1.0),
            ),
            child: Builder(
              builder: (BuildContext c) {
                final ThemeData t = Theme.of(c);
                return Row(
                  children: <Widget>[
                    Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: t.colorScheme.primary,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: t.colorScheme.secondary,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: t.colorScheme.surface,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: palOutline),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Text(
                        'theme primary / secondary / surface',
                        style: TextStyle(
                          color: t.colorScheme.primary,
                          fontWeight: FontWeight.w800,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 18.0),
        AnimatedDefaultTextStyle(
          style: const TextStyle(
            color: palMagenta,
            fontSize: 26.0,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.4,
          ),
          duration: const Duration(milliseconds: 2600),
          curve: Curves.easeInOutCubic,
          child: const Text('TYPE MORPHING'),
        ),
        const SizedBox(height: 6.0),
        AnimatedDefaultTextStyle(
          style: TextStyle(
            color: palTeal,
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
            height: 1.4,
          ),
          duration: const Duration(milliseconds: 2400),
          child: const Text(
            'Secondary line — font-size, weight, colour, and tracking all '
            'animate from defaults to these targets.',
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 15 - AnimatedPadding & AnimatedOpacity stack
  // ===========================================================================

  final List<Map<String, dynamic>> paddingDemos = <Map<String, dynamic>>[
    <String, dynamic>{
      'pad': const EdgeInsets.all(8.0),
      'opacity': 1.0,
      'label': 'tight',
      'color': palIndigo,
    },
    <String, dynamic>{
      'pad': const EdgeInsets.all(20.0),
      'opacity': 0.85,
      'label': 'roomy',
      'color': palAccent,
    },
    <String, dynamic>{
      'pad': const EdgeInsets.all(36.0),
      'opacity': 0.7,
      'label': 'airy',
      'color': palCyan,
    },
    <String, dynamic>{
      'pad': const EdgeInsets.symmetric(horizontal: 40.0, vertical: 14.0),
      'opacity': 0.95,
      'label': 'wide',
      'color': palTeal,
    },
  ];

  final Widget section15 = sectionShell(
    title: 'Section 15 — AnimatedPadding & AnimatedOpacity',
    subtitle:
        'AnimatedPadding uses an EdgeInsetsTween. AnimatedOpacity uses a '
        'plain Tween<double>. Stacking both produces compound entry motion.',
    surface: palIndigoSoft.withValues(alpha: 0.45),
    border: palIndigo.withValues(alpha: 0.4),
    titleColor: palIndigo,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        codeLine('EdgeInsetsTween(begin: EdgeInsets.zero, end: EdgeInsets.all(36))'),
        codeLine('AnimatedPadding(padding:, duration:) + AnimatedOpacity(opacity:, duration:)'),
        const SizedBox(height: 14.0),
        Column(
          children: List<Widget>.generate(paddingDemos.length, (int i) {
            final Map<String, dynamic> spec = paddingDemos[i];
            final EdgeInsets pad = spec['pad'] as EdgeInsets;
            final double opacity = spec['opacity'] as double;
            final Color color = spec['color'] as Color;
            final String label = spec['label'] as String;
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: palOutline, width: 1.0),
              ),
              child: AnimatedPadding(
                padding: pad,
                duration: const Duration(milliseconds: 1800),
                curve: Curves.easeOutCubic,
                child: AnimatedOpacity(
                  opacity: opacity,
                  duration: const Duration(milliseconds: 2000),
                  child: Container(
                    width: double.infinity,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$label  •  pad=$pad  •  op=${opacity.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 16 - ConstantTween demonstration via TweenSequence holds
  // ===========================================================================

  final TweenSequence<Color?> colorHold = TweenSequence<Color?>(
    <TweenSequenceItem<Color?>>[
      TweenSequenceItem<Color?>(
        tween: ColorTween(begin: palCyan, end: palAccent),
        weight: 25.0,
      ),
      TweenSequenceItem<Color?>(
        tween: ConstantTween<Color?>(palAccent),
        weight: 15.0,
      ),
      TweenSequenceItem<Color?>(
        tween: ColorTween(begin: palAccent, end: palMagenta),
        weight: 25.0,
      ),
      TweenSequenceItem<Color?>(
        tween: ConstantTween<Color?>(palMagenta),
        weight: 15.0,
      ),
      TweenSequenceItem<Color?>(
        tween: ColorTween(begin: palMagenta, end: palOrange),
        weight: 20.0,
      ),
    ],
  );

  final Widget section16 = sectionShell(
    title: 'Section 16 — ConstantTween (hold values inside sequences)',
    subtitle:
        'ConstantTween<T>(value) ignores t and always returns value. '
        'Combined with TweenSequence it creates "hold" stops between moves.',
    surface: palAmberSoft.withValues(alpha: 0.45),
    border: palAmber.withValues(alpha: 0.4),
    titleColor: palAmber,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        codeLine('ConstantTween<Color?>(palAccent)  // always returns palAccent'),
        codeLine('TweenSequence stitches lerps with holds for keyframe pauses'),
        const SizedBox(height: 14.0),
        SizedBox(
          height: 90.0,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 4000),
            builder: (BuildContext c, double t, Widget? _) {
              final Color? v = colorHold.transform(t);
              final Color shown = v ?? palCyan;
              return Container(
                decoration: BoxDecoration(
                  color: shown,
                  borderRadius: BorderRadius.circular(14.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: shown.withValues(alpha: 0.5),
                      blurRadius: 18.0,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  shown.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'monospace',
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            chip('lerp 25%', palCyan),
            chip('HOLD 15%', palAccent),
            chip('lerp 25%', palAccent),
            chip('HOLD 15%', palMagenta),
            chip('lerp 20%', palOrange),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 17 - Animatable<T> chain visualizer: arbitrary value mapping
  // ===========================================================================

  final Animatable<double> rotationAnimatable = Tween<double>(begin: -0.05, end: 0.05)
      .chain(CurveTween(curve: Curves.easeInOutSine));

  final Animatable<double> scaleAnimatable = Tween<double>(begin: 0.85, end: 1.0)
      .chain(CurveTween(curve: Curves.elasticOut));

  final Animatable<double> hoverElevation =
      Tween<double>(begin: 2.0, end: 16.0).chain(CurveTween(curve: Curves.easeOutCubic));

  final Widget section17 = sectionShell(
    title: 'Section 17 — Animatable<T>.chain(CurveTween) composition',
    subtitle:
        'Animatable is the abstract parent of every Tween. .chain(other) '
        'composes two Animatables — output of one becomes the t of the next.',
    surface: palDeepPurpleSoft.withValues(alpha: 0.5),
    border: palDeepPurple.withValues(alpha: 0.4),
    titleColor: palDeepPurple,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        codeLine('Animatable<double> rotator = Tween(begin: -0.05, end: 0.05).chain(CurveTween(...));'),
        codeLine('Animatable<double> scaler = Tween(begin: 0.85, end: 1.0).chain(CurveTween(elasticOut));'),
        const SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 2400),
              builder: (BuildContext c, double t, Widget? _) {
                final double v = rotationAnimatable.transform(t);
                return Transform.rotate(
                  angle: v,
                  child: Container(
                    width: 110.0,
                    height: 110.0,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: <Color>[palDeepPurple, palAccent],
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'rot ${(v * 180 / 3.14159).toStringAsFixed(1)}°',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                );
              },
            ),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 2400),
              builder: (BuildContext c, double t, Widget? _) {
                final double v = scaleAnimatable.transform(t);
                return Transform.scale(
                  scale: v,
                  child: Container(
                    width: 110.0,
                    height: 110.0,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: <Color>[palMagenta, palOrange],
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'scale ${v.toStringAsFixed(3)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                );
              },
            ),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 2400),
              builder: (BuildContext c, double t, Widget? _) {
                final double v = hoverElevation.transform(t);
                return Container(
                  width: 110.0,
                  height: 110.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: palTeal.withValues(alpha: 0.5),
                        blurRadius: v,
                        offset: Offset(0, v / 2),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'shadow ${v.toStringAsFixed(1)}',
                    style: const TextStyle(
                      color: palTeal,
                      fontSize: 11.0,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'monospace',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 18 - Composite progress dashboard (radial via Tween<double>)
  // ===========================================================================

  final List<Map<String, dynamic>> radialSpecs = <Map<String, dynamic>>[
    <String, dynamic>{
      'progress': 0.85,
      'label': 'Engagement',
      'color': palAccent,
    },
    <String, dynamic>{
      'progress': 0.62,
      'label': 'Retention',
      'color': palTeal,
    },
    <String, dynamic>{
      'progress': 0.93,
      'label': 'Uptime',
      'color': palGreenDark,
    },
    <String, dynamic>{
      'progress': 0.41,
      'label': 'Conversion',
      'color': palAmber,
    },
  ];

  final Widget section18 = sectionShell(
    title: 'Section 18 — Composite radial progress (Tween<double>)',
    subtitle:
        'Each radial gauge wraps CircularProgressIndicator with a TweenAnimationBuilder, '
        'so the arc fills smoothly to its target ratio.',
    surface: palGreenDarkSoft.withValues(alpha: 0.45),
    border: palGreenDark.withValues(alpha: 0.4),
    titleColor: palGreenDark,
    child: Wrap(
      spacing: 14.0,
      runSpacing: 14.0,
      alignment: WrapAlignment.center,
      children: List<Widget>.generate(radialSpecs.length, (int i) {
        final Map<String, dynamic> spec = radialSpecs[i];
        final double progress = spec['progress'] as double;
        final Color color = spec['color'] as Color;
        final String label = spec['label'] as String;
        return Container(
          width: 150.0,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(
              color: color.withValues(alpha: 0.4),
              width: 1.2,
            ),
          ),
          child: Column(
            children: <Widget>[
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: progress),
                duration: const Duration(milliseconds: 2400),
                curve: Curves.easeOutCubic,
                builder: (BuildContext c, double v, Widget? _) {
                  return SizedBox(
                    width: 96.0,
                    height: 96.0,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 96.0,
                          height: 96.0,
                          child: CircularProgressIndicator(
                            value: v,
                            strokeWidth: 8.0,
                            backgroundColor:
                                color.withValues(alpha: 0.15),
                            valueColor:
                                AlwaysStoppedAnimation<Color>(color),
                          ),
                        ),
                        Text(
                          '${(v * 100).toInt()}%',
                          style: TextStyle(
                            color: color,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w900,
                            fontFeatures: const <FontFeature>[
                              FontFeature.tabularFigures(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 10.0),
              Text(
                label,
                style: const TextStyle(
                  color: palInk,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        );
      }),
    ),
  );

  // ===========================================================================
  // SECTION 19 - Stagger demo: List of TweenAnimationBuilders with offsets
  // ===========================================================================

  final List<Map<String, dynamic>> staggerSpecs = <Map<String, dynamic>>[
    <String, dynamic>{
      'delay': 0,
      'icon': Icons.bolt,
      'label': 'Energy',
      'color': palAmber,
    },
    <String, dynamic>{
      'delay': 200,
      'icon': Icons.eco,
      'label': 'Green',
      'color': palGreenDark,
    },
    <String, dynamic>{
      'delay': 400,
      'icon': Icons.wifi_tethering,
      'label': 'Signal',
      'color': palCyan,
    },
    <String, dynamic>{
      'delay': 600,
      'icon': Icons.diamond,
      'label': 'Premium',
      'color': palMagenta,
    },
    <String, dynamic>{
      'delay': 800,
      'icon': Icons.flight_takeoff,
      'label': 'Boost',
      'color': palAccent,
    },
    <String, dynamic>{
      'delay': 1000,
      'icon': Icons.shield,
      'label': 'Guard',
      'color': palIndigo,
    },
  ];

  final Widget section19 = sectionShell(
    title: 'Section 19 — Stagger via duration variance',
    subtitle:
        'Each row uses a Tween<Offset> with a slightly different duration. '
        'Because the controllers are independent, the cards visibly cascade in.',
    surface: palMagentaSoft.withValues(alpha: 0.4),
    border: palMagenta.withValues(alpha: 0.35),
    titleColor: palMagenta,
    child: Column(
      children: List<Widget>.generate(staggerSpecs.length, (int i) {
        final Map<String, dynamic> spec = staggerSpecs[i];
        final int delay = spec['delay'] as int;
        final IconData icon = spec['icon'] as IconData;
        final String label = spec['label'] as String;
        final Color color = spec['color'] as Color;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: Duration(milliseconds: 900 + delay),
            curve: Curves.easeOutCubic,
            builder: (BuildContext c, double v, Widget? _) {
              return Opacity(
                opacity: v,
                child: Transform.translate(
                  offset: Offset((1 - v) * 80, 0),
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: color.withValues(alpha: 0.4),
                        width: 1.2,
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Icon(icon, color: color, size: 22.0),
                        ),
                        const SizedBox(width: 12.0),
                        Text(
                          label,
                          style: TextStyle(
                            color: color,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'delay ${delay}ms',
                          style: TextStyle(
                            color: palInkSoft,
                            fontSize: 11.0,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    ),
  );

  // ===========================================================================
  // SECTION 20 - Reference table summarising every Animatable used
  // ===========================================================================

  final List<Map<String, String>> referenceRows = <Map<String, String>>[
    <String, String>{
      'tween': 'Tween<double>',
      'lerps': 'numeric scalars',
      'usage': 'AnimatedOpacity, manual TweenAnimationBuilder<double>',
    },
    <String, String>{
      'tween': 'IntTween',
      'lerps': 'integer values (rounded)',
      'usage': 'counters, page numbers, step indices',
    },
    <String, String>{
      'tween': 'ColorTween',
      'lerps': 'Color? (nullable to allow fade in/out)',
      'usage': 'AnimatedContainer color, AnimatedTheme implicit',
    },
    <String, String>{
      'tween': 'RectTween',
      'lerps': 'Rect bounding box',
      'usage': 'Hero animations, AnimatedPositioned',
    },
    <String, String>{
      'tween': 'SizeTween',
      'lerps': 'Size (width x height)',
      'usage': 'AnimatedSize, AnimatedCrossFade size',
    },
    <String, String>{
      'tween': 'AlignmentTween',
      'lerps': 'Alignment vectors',
      'usage': 'AnimatedAlign',
    },
    <String, String>{
      'tween': 'BorderRadiusTween',
      'lerps': 'BorderRadius corners',
      'usage': 'AnimatedContainer decoration radius',
    },
    <String, String>{
      'tween': 'DecorationTween',
      'lerps': 'BoxDecoration (color + gradient + border + shadow)',
      'usage': 'AnimatedContainer full decoration',
    },
    <String, String>{
      'tween': 'EdgeInsetsTween',
      'lerps': 'EdgeInsets paddings',
      'usage': 'AnimatedPadding',
    },
    <String, String>{
      'tween': 'ConstantTween<T>',
      'lerps': 'always returns the same T',
      'usage': 'TweenSequence holds',
    },
    <String, String>{
      'tween': 'CurveTween',
      'lerps': 'remaps t -> curve(t)',
      'usage': 'Tween.chain(CurveTween(...))',
    },
    <String, String>{
      'tween': 'TweenSequence<T>',
      'lerps': 'chained weighted segments',
      'usage': 'keyframe-style multi-stop motion',
    },
    <String, String>{
      'tween': 'Tween<Offset>',
      'lerps': 'Offset positions',
      'usage': 'SlideTransition inside AnimatedSwitcher',
    },
    <String, String>{
      'tween': 'TextStyleTween',
      'lerps': 'TextStyle fields',
      'usage': 'AnimatedDefaultTextStyle implicit',
    },
    <String, String>{
      'tween': 'ThemeDataTween',
      'lerps': 'ThemeData fields',
      'usage': 'AnimatedTheme implicit',
    },
  ];

  final Widget section20 = sectionShell(
    title: 'Section 20 — Reference table: tween species summary',
    subtitle:
        'A flat catalogue of every Animatable touched in this demo, with the '
        'value it interpolates and the widget that typically uses it implicitly.',
    surface: palSurface,
    border: palOutline,
    titleColor: palInk,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: palInk,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: const Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  'Tween',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                    letterSpacing: 0.6,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Interpolates',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  'Typical usage',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ],
          ),
        ),
        ...List<Widget>.generate(referenceRows.length, (int i) {
          final Map<String, String> row = referenceRows[i];
          final Color bg =
              i.isEven ? Colors.white : palSurfaceAlt.withValues(alpha: 0.55);
          return Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: bg,
              border: Border(
                bottom: BorderSide(color: palOutline, width: 0.6),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    row['tween']!,
                    style: const TextStyle(
                      color: palAccent,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    row['lerps']!,
                    style: const TextStyle(
                      color: palInk,
                      fontSize: 12.0,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    row['usage']!,
                    style: TextStyle(
                      color: palInkSoft,
                      fontSize: 11.5,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );

  // ===========================================================================
  // FOOTER - signature card
  // ===========================================================================

  final Widget footer = Container(
    margin: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 6.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[palInk, palDeepPurple],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(
              Icons.auto_awesome,
              color: Colors.white,
              size: 28.0,
            ),
            const SizedBox(width: 10.0),
            const Text(
              'End of demo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          '20 sections covering every major Animatable, every common Tween '
          'subtype, the CurveTween/TweenSequence/ConstantTween combinators, '
          'and the AnimatedXxx implicit-animation widget family — all '
          'interpreted live by D4rt.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.92),
            fontSize: 13.0,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            chip('20 sections', Colors.white),
            chip('15 tween species', Colors.white),
            chip('TweenAnimationBuilder', Colors.white),
            chip('No Ticker needed', Colors.white),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SCAFFOLD ASSEMBLY
  // ===========================================================================

  return Scaffold(
    backgroundColor: palSurfaceAlt,
    appBar: AppBar(
      title: const Text(
        'Animatable / Tween — Deep Demo',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.3,
        ),
      ),
      backgroundColor: palDeepPurple,
      iconTheme: const IconThemeData(color: Colors.white),
      elevation: 6.0,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          heroBanner,
          section01,
          section02,
          section03,
          section04,
          section05,
          section06,
          section07,
          section08,
          section09,
          section10,
          section11,
          section12,
          section13,
          section14,
          section15,
          section16,
          section17,
          section18,
          section19,
          section20,
          footer,
        ],
      ),
    ),
  );
}
