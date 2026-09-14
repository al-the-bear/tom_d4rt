// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true),
    home: Scaffold(
      backgroundColor: const Color(0xFFF5F2EE),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 60.0),
          child: Column(children: const <Widget>[
            _HeroCard(),
            SizedBox(height: 24.0),
            _SectionModel(),
            SizedBox(height: 24.0),
            _SectionApi(),
            SizedBox(height: 24.0),
            _SectionVelocityVsEstimate(),
            SizedBox(height: 24.0),
            _SectionConfidence(),
            SizedBox(height: 24.0),
            _SectionVariants(),
            SizedBox(height: 24.0),
            _SectionMagnitudeChart(),
            SizedBox(height: 24.0),
            _SectionCoordinateSystem(),
            SizedBox(height: 24.0),
            _SectionUseCases(),
            SizedBox(height: 24.0),
            _SectionCodeBlock(),
            SizedBox(height: 24.0),
            _SectionPitfalls(),
            SizedBox(height: 24.0),
            _SectionFooter(),
          ]),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Common palette and helpers
// ---------------------------------------------------------------------------

const Color _kInk = Color(0xFF1F2933);
const Color _kInkSoft = Color(0xFF52606D);
const Color _kInkMute = Color(0xFF7B8794);
const Color _kPaper = Color(0xFFF5F2EE);
const Color _kCard = Color(0xFFFFFFFF);
const Color _kAccent = Color(0xFF2F6BFF);
const Color _kAccentDark = Color(0xFF1746B3);
const Color _kCoral = Color(0xFFE85D75);
const Color _kCoralDark = Color(0xFFB23A52);
const Color _kMint = Color(0xFF2EBF91);
const Color _kMintDark = Color(0xFF1B8F6A);
const Color _kAmber = Color(0xFFF6A623);
const Color _kAmberDark = Color(0xFFB6791A);
const Color _kPlum = Color(0xFF8855CC);
const Color _kPlumDark = Color(0xFF5A2E94);
const Color _kSlate = Color(0xFF4C5C68);
const Color _kSlateDark = Color(0xFF2C3A45);
const Color _kBorder = Color(0xFFE3DCD3);

// Reference gestures-package types so the import is meaningful.
const PointerDeviceKind _kDocumentedKind = PointerDeviceKind.touch;
const String _kDocumentedTrackerType = 'VelocityTracker';
const String _kDocumentedEstimateType = 'VelocityEstimate';
const String _kDocumentedVelocityType = 'Velocity';
const String _kDocumentedIosTracker = 'IOSScrollViewFlingVelocityTracker';
const String _kDocumentedMacosTracker = 'MacOSScrollViewFlingVelocityTracker';

// ---------------------------------------------------------------------------
// Hero
// ---------------------------------------------------------------------------

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24.0, 26.0, 24.0, 26.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF2F6BFF),
            Color(0xFF1746B3),
            Color(0xFF0F2E7A),
          ],
          stops: <double>[0.0, 0.55, 1.0],
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF1746B3).withValues(alpha: 0.30),
            blurRadius: 22.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 84.0,
            height: 84.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Colors.white.withValues(alpha: 0.32),
                  Colors.white.withValues(alpha: 0.10),
                ],
              ),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.55),
                width: 2.0,
              ),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.speed_rounded,
              size: 44.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'VelocityTracker',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  'Measuring fling gestures',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.92),
                  ),
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: const <Widget>[
                    _HeroChip(label: 'gestures'),
                    SizedBox(width: 8.0),
                    _HeroChip(label: 'pointer'),
                    SizedBox(width: 8.0),
                    _HeroChip(label: 'fling'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.40),
          width: 1.0,
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section header (used everywhere)
// ---------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.colorDark,
  });

  final String index;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color colorDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[color, colorDark],
        ),
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colorDark.withValues(alpha: 0.22),
            blurRadius: 12.0,
            offset: const Offset(0.0, 6.0),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 44.0,
            height: 44.0,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.20),
              borderRadius: BorderRadius.circular(11.0),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.50),
                width: 1.4,
              ),
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: 22.0, color: Colors.white),
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.30),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text(
                        index,
                        style: const TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.92),
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

// Generic card body
class _CardBody extends StatelessWidget {
  const _CardBody({required this.child, this.padding});
  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 18.0),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: _kBorder, width: 1.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF1F2933).withValues(alpha: 0.05),
            blurRadius: 14.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ---------------------------------------------------------------------------
// Section 1: The model — sample timeline + fitted line
// ---------------------------------------------------------------------------

class _SectionModel extends StatelessWidget {
  const _SectionModel();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          index: '01',
          title: 'The model',
          subtitle: 'Pointer samples on a timeline. Slope = velocity.',
          icon: Icons.timeline_rounded,
          color: _kAccent,
          colorDark: _kAccentDark,
        ),
        const SizedBox(height: 12.0),
        _CardBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'A VelocityTracker collects (time, position) samples from pointer '
                'events. When asked for a velocity it fits a line through the '
                'recent samples and reports its slope in pixels per second.',
                style: TextStyle(
                  fontSize: 13.5,
                  height: 1.5,
                  color: _kInkSoft,
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                height: 240.0,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Color(0xFFF7FAFF),
                      Color(0xFFE8EFFF),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: const Color(0xFFCFD9F2),
                    width: 1.0,
                  ),
                ),
                child: CustomPaint(
                  painter: _SampleTimelinePainter(),
                ),
              ),
              const SizedBox(height: 14.0),
              Row(
                children: const <Widget>[
                  _LegendDot(color: _kAccent, label: 'Sample t=n·16ms'),
                  SizedBox(width: 16.0),
                  _LegendLine(color: _kCoral, label: 'Fitted velocity line'),
                ],
              ),
              const SizedBox(height: 14.0),
              const _Equation(
                title: 'Slope (pixels/second)',
                body: 'v = Δposition / Δtime  →  fitted across last ~100ms',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 1.5),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 4.0,
              ),
            ],
          ),
        ),
        const SizedBox(width: 6.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: _kInkSoft,
          ),
        ),
      ],
    );
  }
}

class _LegendLine extends StatelessWidget {
  const _LegendLine({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 20.0,
          height: 3.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        const SizedBox(width: 6.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: _kInkSoft,
          ),
        ),
      ],
    );
  }
}

class _Equation extends StatelessWidget {
  const _Equation({required this.title, required this.body});
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF7EF),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: const Color(0xFFEDE0C8), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              color: _kAmberDark,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            body,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 13.0,
              color: _kInk,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SampleTimelinePainter extends CustomPainter {
  const _SampleTimelinePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final double padL = 36.0;
    final double padR = 16.0;
    final double padT = 18.0;
    final double padB = 28.0;
    final double plotW = w - padL - padR;
    final double plotH = h - padT - padB;

    // Grid
    final Paint grid = Paint()
      ..color = const Color(0xFFCFD9F2)
      ..strokeWidth = 0.6;
    for (int i = 0; i <= 5; i++) {
      final double y = padT + plotH * i / 5.0;
      canvas.drawLine(Offset(padL, y), Offset(w - padR, y), grid);
    }
    for (int i = 0; i <= 10; i++) {
      final double x = padL + plotW * i / 10.0;
      canvas.drawLine(Offset(x, padT), Offset(x, h - padB), grid);
    }

    // Axes
    final Paint axis = Paint()
      ..color = const Color(0xFF52606D)
      ..strokeWidth = 1.4;
    canvas.drawLine(Offset(padL, h - padB), Offset(w - padR, h - padB), axis);
    canvas.drawLine(Offset(padL, padT), Offset(padL, h - padB), axis);

    // Sample data: 11 samples roughly along a slope (~700 px/s)
    final List<double> times = <double>[
      0.0, 16.0, 32.0, 48.0, 64.0, 80.0, 96.0, 112.0, 128.0, 144.0, 160.0,
    ];
    final List<double> positions = <double>[
      6.0, 16.0, 24.0, 38.0, 50.0, 64.0, 72.0, 86.0, 100.0, 112.0, 124.0,
    ];

    Offset toPixel(double t, double p) {
      final double x = padL + (t / 160.0) * plotW;
      final double y = (h - padB) - (p / 130.0) * plotH;
      return Offset(x, y);
    }

    // Fitted line (from first to last sample, with averaging slope)
    final Offset start = toPixel(0.0, 8.0);
    final Offset end = toPixel(160.0, 122.0);
    final Paint fit = Paint()
      ..color = const Color(0xFFE85D75)
      ..strokeWidth = 2.6
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(start, end, fit);

    // Sample dots
    final Paint dotFill = Paint()..color = const Color(0xFF2F6BFF);
    final Paint dotStroke = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    for (int i = 0; i < times.length; i++) {
      final Offset p = toPixel(times[i], positions[i]);
      canvas.drawCircle(p, 5.0, dotFill);
      canvas.drawCircle(p, 5.0, dotStroke);
    }

    // X-axis tick labels (t in ms)
    final List<String> xLabels = <String>['0', '40', '80', '120', '160'];
    for (int i = 0; i < xLabels.length; i++) {
      final double x = padL + plotW * i / (xLabels.length - 1);
      _drawText(
        canvas,
        '${xLabels[i]}ms',
        Offset(x - 10.0, h - padB + 6.0),
        const Color(0xFF52606D),
        10.0,
      );
    }
    // Y-axis labels
    _drawText(canvas, 'pos', Offset(6.0, padT - 4.0),
        const Color(0xFF52606D), 10.0);
    _drawText(canvas, 'time →', Offset(w - 56.0, h - 14.0),
        const Color(0xFF52606D), 10.0);
  }

  void _drawText(Canvas canvas, String text, Offset pos, Color color, double size) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, pos);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// Section 2: VelocityTracker API
// ---------------------------------------------------------------------------

class _SectionApi extends StatelessWidget {
  const _SectionApi();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          index: '02',
          title: 'VelocityTracker API',
          subtitle: 'Core methods for feeding samples and reading velocity.',
          icon: Icons.api_rounded,
          color: _kMint,
          colorDark: _kMintDark,
        ),
        const SizedBox(height: 12.0),
        _CardBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              _ApiCard(
                signature: 'VelocityTracker.withKind(PointerDeviceKind kind)',
                returns: 'VelocityTracker',
                description:
                    'Creates a tracker tuned for the given device kind. '
                    'Touch and stylus use different sample weighting than mouse.',
                params: <_Param>[
                  _Param('kind', 'PointerDeviceKind',
                      'touch, mouse, stylus, trackpad, invertedStylus'),
                ],
                accent: _kAccent,
              ),
              SizedBox(height: 12.0),
              _ApiCard(
                signature: 'addPosition(Duration time, Offset position)',
                returns: 'void',
                description:
                    'Append a (time, position) sample. Time must be '
                    'monotonically non-decreasing. Typically called from '
                    'PointerEvent.timeStamp / localPosition.',
                params: <_Param>[
                  _Param('time', 'Duration',
                      'Engine timestamp of the pointer event'),
                  _Param('position', 'Offset',
                      'Pointer position in local coordinates'),
                ],
                accent: _kMint,
              ),
              SizedBox(height: 12.0),
              _ApiCard(
                signature: 'getVelocity()',
                returns: 'Velocity',
                description:
                    'Returns a Velocity assembled from the most recent '
                    'samples. If estimate is null or low confidence, '
                    'returns Velocity.zero.',
                params: <_Param>[],
                accent: _kAmber,
              ),
              SizedBox(height: 12.0),
              _ApiCard(
                signature: 'getVelocityEstimate()',
                returns: 'VelocityEstimate?',
                description:
                    'Lower-level result including confidence, time window '
                    'and offset. Use when you need to gate on confidence '
                    'before accepting a fling.',
                params: <_Param>[],
                accent: _kCoral,
              ),
              SizedBox(height: 12.0),
              _ApiCard(
                signature: 'reset()',
                returns: 'void',
                description:
                    'Clears all stored samples. Call when starting a new '
                    'gesture or after a pointer cancel event so stale data '
                    'does not bleed into the next fling.',
                params: <_Param>[],
                accent: _kPlum,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Param {
  const _Param(this.name, this.type, this.description);
  final String name;
  final String type;
  final String description;
}

class _ApiCard extends StatelessWidget {
  const _ApiCard({
    required this.signature,
    required this.returns,
    required this.description,
    required this.params,
    required this.accent,
  });

  final String signature;
  final String returns;
  final String description;
  final List<_Param> params;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 14.0),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: _kBorder, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 6.0,
                height: 20.0,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  signature,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13.0,
                    fontWeight: FontWeight.w700,
                    color: _kInk,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(
                    color: accent.withValues(alpha: 0.40),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  '→ $returns',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    color: accent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12.5,
              height: 1.5,
              color: _kInkSoft,
            ),
          ),
          if (params.isNotEmpty) ...<Widget>[
            const SizedBox(height: 10.0),
            for (final _Param p in params) _ParamRow(param: p, accent: accent),
          ],
        ],
      ),
    );
  }
}

class _ParamRow extends StatelessWidget {
  const _ParamRow({required this.param, required this.accent});
  final _Param param;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F4F8),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              param.name,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                fontWeight: FontWeight.w700,
                color: _kInk,
              ),
            ),
          ),
          const SizedBox(width: 6.0),
          Text(
            param.type,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              color: accent,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              param.description,
              style: const TextStyle(
                fontSize: 11.5,
                color: _kInkSoft,
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
// Section 3: Velocity vs VelocityEstimate
// ---------------------------------------------------------------------------

class _SectionVelocityVsEstimate extends StatelessWidget {
  const _SectionVelocityVsEstimate();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          index: '03',
          title: 'Velocity vs VelocityEstimate',
          subtitle: 'Two related result types with different shapes.',
          icon: Icons.compare_arrows_rounded,
          color: _kCoral,
          colorDark: _kCoralDark,
        ),
        const SizedBox(height: 12.0),
        _CardBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              _CompareTable(
                rows: <_CompareRow>[
                  _CompareRow('pixelsPerSecond', 'Offset', 'Offset'),
                  _CompareRow('confidence',      '—',      'double (0..1)'),
                  _CompareRow('duration',        '—',      'Duration'),
                  _CompareRow('offset',          '—',      'Offset (Δ pos)'),
                  _CompareRow('clampMagnitude',  'Velocity', '—'),
                  _CompareRow('null on low data','no',     'yes'),
                  _CompareRow('zero default',    'Velocity.zero', 'null'),
                ],
              ),
              SizedBox(height: 12.0),
              _CompareNote(
                text:
                    'Use Velocity when you only need a final value. Use '
                    'VelocityEstimate when you need to decide whether the '
                    'value is trustworthy enough for a fling.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CompareRow {
  const _CompareRow(this.property, this.velocity, this.estimate);
  final String property;
  final String velocity;
  final String estimate;
}

class _CompareTable extends StatelessWidget {
  const _CompareTable({required this.rows});
  final List<_CompareRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _kBorder, width: 1.0),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12.0, vertical: 10.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Color(0xFFFCEFF2),
                  Color(0xFFF6E1E6),
                ],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
            ),
            child: Row(
              children: const <Widget>[
                Expanded(flex: 4, child: _Th('Property')),
                Expanded(flex: 3, child: _Th('Velocity')),
                Expanded(flex: 3, child: _Th('VelocityEstimate')),
              ],
            ),
          ),
          for (int i = 0; i < rows.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12.0, vertical: 9.0),
              decoration: BoxDecoration(
                color: i.isEven ? _kCard : const Color(0xFFFAF6F2),
                border: Border(
                  top: BorderSide(color: _kBorder, width: 0.6),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(flex: 4, child: _Td(rows[i].property, mono: true)),
                  Expanded(flex: 3, child: _Td(rows[i].velocity)),
                  Expanded(flex: 3, child: _Td(rows[i].estimate)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Th extends StatelessWidget {
  const _Th(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 11.5,
        fontWeight: FontWeight.w800,
        color: _kCoralDark,
        letterSpacing: 0.4,
      ),
    );
  }
}

class _Td extends StatelessWidget {
  const _Td(this.text, {this.mono = false});
  final String text;
  final bool mono;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: mono ? 'monospace' : null,
        fontSize: 12.0,
        fontWeight: mono ? FontWeight.w700 : FontWeight.w500,
        color: mono ? _kInk : _kInkSoft,
      ),
    );
  }
}

class _CompareNote extends StatelessWidget {
  const _CompareNote({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 10.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF6F8),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: const Color(0xFFEFC8D0), width: 1.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(Icons.info_outline_rounded,
              size: 18.0, color: _kCoralDark),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12.0,
                color: _kInkSoft,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 4: Confidence visualization
// ---------------------------------------------------------------------------

class _SectionConfidence extends StatelessWidget {
  const _SectionConfidence();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          index: '04',
          title: 'Confidence visualization',
          subtitle: 'How sample dispersion maps to estimate confidence.',
          icon: Icons.scatter_plot_rounded,
          color: _kAmber,
          colorDark: _kAmberDark,
        ),
        const SizedBox(height: 12.0),
        _CardBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'A VelocityTracker reports how confident it is in the line '
                'fit. Tight, monotonic samples → confidence near 1.0. '
                'Scattered or contradictory samples → confidence near 0.',
                style: TextStyle(
                  fontSize: 13.0,
                  height: 1.5,
                  color: _kInkSoft,
                ),
              ),
              const SizedBox(height: 14.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Expanded(
                    child: _ConfidenceMini(
                      label: 'High',
                      confidence: 0.95,
                      kind: _MiniKind.high,
                      accent: _kMint,
                      accentDark: _kMintDark,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: _ConfidenceMini(
                      label: 'Medium',
                      confidence: 0.62,
                      kind: _MiniKind.medium,
                      accent: _kAmber,
                      accentDark: _kAmberDark,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: _ConfidenceMini(
                      label: 'Low',
                      confidence: 0.21,
                      kind: _MiniKind.low,
                      accent: _kCoral,
                      accentDark: _kCoralDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14.0),
              _ConfidenceBar(),
            ],
          ),
        ),
      ],
    );
  }
}

enum _MiniKind { high, medium, low }

class _ConfidenceMini extends StatelessWidget {
  const _ConfidenceMini({
    required this.label,
    required this.confidence,
    required this.kind,
    required this.accent,
    required this.accentDark,
  });

  final String label;
  final double confidence;
  final _MiniKind kind;
  final Color accent;
  final Color accentDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            accent.withValues(alpha: 0.08),
            accent.withValues(alpha: 0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: accent.withValues(alpha: 0.35),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 6.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6.0),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w800,
                    color: accentDark,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100.0,
            child: CustomPaint(
              painter: _MiniScatterPainter(kind: kind, accent: accent),
              child: const SizedBox.expand(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 10.0),
            child: Row(
              children: <Widget>[
                Text(
                  'confidence',
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    color: _kInkMute,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 7.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    confidence.toStringAsFixed(2),
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                      color: accentDark,
                    ),
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

class _MiniScatterPainter extends CustomPainter {
  const _MiniScatterPainter({required this.kind, required this.accent});
  final _MiniKind kind;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final Paint grid = Paint()
      ..color = const Color(0xFFE0DACF)
      ..strokeWidth = 0.6;
    for (int i = 1; i < 4; i++) {
      final double y = h * i / 4.0;
      canvas.drawLine(Offset(6.0, y), Offset(w - 6.0, y), grid);
    }

    List<Offset> samples;
    Offset lineA;
    Offset lineB;
    switch (kind) {
      case _MiniKind.high:
        samples = <Offset>[
          const Offset(0.06, 0.85),
          const Offset(0.18, 0.74),
          const Offset(0.30, 0.62),
          const Offset(0.42, 0.50),
          const Offset(0.54, 0.40),
          const Offset(0.66, 0.30),
          const Offset(0.78, 0.20),
          const Offset(0.90, 0.10),
        ];
        lineA = const Offset(0.04, 0.88);
        lineB = const Offset(0.92, 0.08);
        break;
      case _MiniKind.medium:
        samples = <Offset>[
          const Offset(0.06, 0.80),
          const Offset(0.18, 0.78),
          const Offset(0.30, 0.55),
          const Offset(0.42, 0.62),
          const Offset(0.54, 0.42),
          const Offset(0.66, 0.32),
          const Offset(0.78, 0.34),
          const Offset(0.90, 0.18),
        ];
        lineA = const Offset(0.04, 0.78);
        lineB = const Offset(0.92, 0.22);
        break;
      case _MiniKind.low:
        samples = <Offset>[
          const Offset(0.06, 0.85),
          const Offset(0.18, 0.35),
          const Offset(0.30, 0.70),
          const Offset(0.42, 0.20),
          const Offset(0.54, 0.65),
          const Offset(0.66, 0.78),
          const Offset(0.78, 0.30),
          const Offset(0.90, 0.60),
        ];
        lineA = const Offset(0.04, 0.62);
        lineB = const Offset(0.92, 0.50);
        break;
    }

    final Paint linePaint = Paint()
      ..color = accent.withValues(alpha: 0.55)
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(lineA.dx * w, lineA.dy * h),
      Offset(lineB.dx * w, lineB.dy * h),
      linePaint,
    );

    final Paint dotPaint = Paint()..color = accent;
    final Paint dotRing = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    for (final Offset s in samples) {
      final Offset p = Offset(s.dx * w, s.dy * h);
      canvas.drawCircle(p, 4.2, dotPaint);
      canvas.drawCircle(p, 4.2, dotRing);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ConfidenceBar extends StatelessWidget {
  const _ConfidenceBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            Color(0xFFFCE9D0),
            Color(0xFFF6D8A8),
          ],
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: const Color(0xFFE9C58A), width: 1.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(Icons.tips_and_updates_outlined,
              size: 18.0, color: _kAmberDark),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              'Common practice: reject flings when confidence < 0.5 and fall '
              'back to a snap or release without momentum.',
              style: const TextStyle(
                fontSize: 12.0,
                color: _kInk,
                height: 1.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 5: Variants
// ---------------------------------------------------------------------------

class _SectionVariants extends StatelessWidget {
  const _SectionVariants();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          index: '05',
          title: 'VelocityTracker variants',
          subtitle: 'Platform-tuned trackers and when each is used.',
          icon: Icons.devices_other_rounded,
          color: _kPlum,
          colorDark: _kPlumDark,
        ),
        const SizedBox(height: 12.0),
        _CardBody(
          child: Column(
            children: const <Widget>[
              _VariantCard(
                name: 'VelocityTracker (default)',
                kind: 'Cross-platform baseline',
                window: '~100 ms',
                weighting: 'Equal weight on recent samples',
                used: 'Touch and stylus on Android, Linux, Windows.',
                color: _kAccent,
                colorDark: _kAccentDark,
                icon: Icons.touch_app_rounded,
              ),
              SizedBox(height: 10.0),
              _VariantCard(
                name: 'IOSScrollViewFlingVelocityTracker',
                kind: 'iOS-tuned',
                window: '~120 ms',
                weighting: 'Weighted recent samples (iOS curve)',
                used: 'Scrollable physics on iOS to match UIKit fling feel.',
                color: _kMint,
                colorDark: _kMintDark,
                icon: Icons.phone_iphone_rounded,
              ),
              SizedBox(height: 10.0),
              _VariantCard(
                name: 'MacOSScrollViewFlingVelocityTracker',
                kind: 'macOS-tuned',
                window: '~150 ms',
                weighting: 'Adjusted for trackpad/momentum scroll',
                used: 'Scrollable physics on macOS for AppKit-like flings.',
                color: _kCoral,
                colorDark: _kCoralDark,
                icon: Icons.laptop_mac_rounded,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _VariantCard extends StatelessWidget {
  const _VariantCard({
    required this.name,
    required this.kind,
    required this.window,
    required this.weighting,
    required this.used,
    required this.color,
    required this.colorDark,
    required this.icon,
  });

  final String name;
  final String kind;
  final String window;
  final String weighting;
  final String used;
  final Color color;
  final Color colorDark;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: _kBorder, width: 1.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 42.0,
            height: 42.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[color, colorDark],
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: Colors.white, size: 22.0),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: _kInk,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  kind,
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    color: colorDark,
                  ),
                ),
                const SizedBox(height: 8.0),
                _VariantRow(label: 'Window', value: window),
                _VariantRow(label: 'Weighting', value: weighting),
                _VariantRow(label: 'Used', value: used),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _VariantRow extends StatelessWidget {
  const _VariantRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 64.0,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: _kInkMute,
                letterSpacing: 0.4,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 11.5,
                color: _kInkSoft,
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
// Section 6: Magnitude chart
// ---------------------------------------------------------------------------

class _SectionMagnitudeChart extends StatelessWidget {
  const _SectionMagnitudeChart();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          index: '06',
          title: 'pixelsPerSecond range',
          subtitle: 'Typical velocity magnitudes and clampMagnitude.',
          icon: Icons.bar_chart_rounded,
          color: _kSlate,
          colorDark: _kSlateDark,
        ),
        const SizedBox(height: 12.0),
        _CardBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Velocity magnitudes are reported in pixels per second. '
                'Most apps cap them via clampMagnitude(min, max) before '
                'feeding them into scroll physics.',
                style: TextStyle(
                  fontSize: 13.0,
                  height: 1.5,
                  color: _kInkSoft,
                ),
              ),
              const SizedBox(height: 14.0),
              const _MagnitudeBar(
                label: 'Idle / barely moving',
                value: 50.0,
                max: 8000.0,
                color: _kMint,
                colorDark: _kMintDark,
                annotation: '50 px/s',
              ),
              const SizedBox(height: 8.0),
              const _MagnitudeBar(
                label: 'Slow scroll',
                value: 200.0,
                max: 8000.0,
                color: _kAccent,
                colorDark: _kAccentDark,
                annotation: '200 px/s',
              ),
              const SizedBox(height: 8.0),
              const _MagnitudeBar(
                label: 'Comfortable scroll',
                value: 700.0,
                max: 8000.0,
                color: _kPlum,
                colorDark: _kPlumDark,
                annotation: '700 px/s',
              ),
              const SizedBox(height: 8.0),
              const _MagnitudeBar(
                label: 'Fast scroll',
                value: 1500.0,
                max: 8000.0,
                color: _kAmber,
                colorDark: _kAmberDark,
                annotation: '1500 px/s',
              ),
              const SizedBox(height: 8.0),
              const _MagnitudeBar(
                label: 'Aggressive fling',
                value: 4000.0,
                max: 8000.0,
                color: _kCoral,
                colorDark: _kCoralDark,
                annotation: '4000 px/s',
              ),
              const SizedBox(height: 8.0),
              const _MagnitudeBar(
                label: 'Max recognized fling',
                value: 8000.0,
                max: 8000.0,
                color: _kSlate,
                colorDark: _kSlateDark,
                annotation: '8000 px/s',
              ),
              const SizedBox(height: 14.0),
              Container(
                padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 10.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF4FB),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                      color: const Color(0xFFCFD9F2), width: 1.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Icon(Icons.shield_outlined,
                        size: 18.0, color: _kAccentDark),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        'velocity.clampMagnitude(800, 5000) keeps your '
                        'physics inside a comfortable band even when a user '
                        'flings hard.',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: _kInk,
                          height: 1.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MagnitudeBar extends StatelessWidget {
  const _MagnitudeBar({
    required this.label,
    required this.value,
    required this.max,
    required this.color,
    required this.colorDark,
    required this.annotation,
  });

  final String label;
  final double value;
  final double max;
  final Color color;
  final Color colorDark;
  final String annotation;

  @override
  Widget build(BuildContext context) {
    final double pct = (value / max).clamp(0.0, 1.0);
    return Row(
      children: <Widget>[
        SizedBox(
          width: 140.0,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: _kInkSoft,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 22.0,
            decoration: BoxDecoration(
              color: const Color(0xFFF1ECE4),
              borderRadius: BorderRadius.circular(11.0),
            ),
            child: Stack(
              children: <Widget>[
                FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: pct,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[color, colorDark],
                      ),
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    annotation,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      color: _kInk,
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

// ---------------------------------------------------------------------------
// Section 7: Coordinate system
// ---------------------------------------------------------------------------

class _SectionCoordinateSystem extends StatelessWidget {
  const _SectionCoordinateSystem();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          index: '07',
          title: 'Coordinate system reminder',
          subtitle: '+x is right, +y is down. Velocity is signed.',
          icon: Icons.grid_4x4_rounded,
          color: _kMint,
          colorDark: _kMintDark,
        ),
        const SizedBox(height: 12.0),
        _CardBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Flutter places (0, 0) at the top-left of the widget. A drag '
                'to the right yields a positive dx velocity; a drag down '
                'yields positive dy. Upward swipes therefore have a '
                'negative dy.',
                style: TextStyle(
                  fontSize: 13.0,
                  height: 1.5,
                  color: _kInkSoft,
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                height: 240.0,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Color(0xFFE9F8F1),
                      Color(0xFFD3F0E1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: const Color(0xFFA8DFC2),
                    width: 1.0,
                  ),
                ),
                child: CustomPaint(painter: _AxisDiagramPainter()),
              ),
              const SizedBox(height: 12.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _AxisLegendCard(
                      icon: Icons.east_rounded,
                      label: '+dx',
                      desc: 'Right swipe',
                      color: _kAccent,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: _AxisLegendCard(
                      icon: Icons.west_rounded,
                      label: '-dx',
                      desc: 'Left swipe',
                      color: _kPlum,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: _AxisLegendCard(
                      icon: Icons.south_rounded,
                      label: '+dy',
                      desc: 'Down swipe',
                      color: _kAmberDark,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: _AxisLegendCard(
                      icon: Icons.north_rounded,
                      label: '-dy',
                      desc: 'Up swipe',
                      color: _kCoralDark,
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

class _AxisLegendCard extends StatelessWidget {
  const _AxisLegendCard({
    required this.icon,
    required this.label,
    required this.desc,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String desc;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _kBorder, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, size: 20.0, color: color),
          const SizedBox(height: 6.0),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13.0,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            desc,
            style: const TextStyle(
              fontSize: 11.0,
              color: _kInkSoft,
            ),
          ),
        ],
      ),
    );
  }
}

class _AxisDiagramPainter extends CustomPainter {
  const _AxisDiagramPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final Offset origin = Offset(w * 0.18, h * 0.30);
    final double xLen = w * 0.65;
    final double yLen = h * 0.55;

    // Axis lines
    final Paint axis = Paint()
      ..color = const Color(0xFF1B8F6A)
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(origin, Offset(origin.dx + xLen, origin.dy), axis);
    canvas.drawLine(origin, Offset(origin.dx, origin.dy + yLen), axis);

    // Arrowheads
    _arrowhead(canvas, Offset(origin.dx + xLen, origin.dy), 0.0, axis);
    _arrowhead(canvas, Offset(origin.dx, origin.dy + yLen), 90.0, axis);

    // Labels
    _drawText(canvas, '(0, 0)', Offset(origin.dx - 36.0, origin.dy - 14.0),
        const Color(0xFF1B8F6A), 11.0);
    _drawText(canvas, '+x  (dx > 0)',
        Offset(origin.dx + xLen - 70.0, origin.dy - 18.0),
        const Color(0xFF1B8F6A), 12.0);
    _drawText(canvas, '+y  (dy > 0)',
        Offset(origin.dx - 8.0, origin.dy + yLen + 6.0),
        const Color(0xFF1B8F6A), 12.0);

    // Sample velocity vector
    final Paint vec = Paint()
      ..color = const Color(0xFF2F6BFF)
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;
    final Offset vEnd = Offset(origin.dx + xLen * 0.55,
        origin.dy + yLen * 0.45);
    canvas.drawLine(origin, vEnd, vec);
    _arrowhead(canvas, vEnd, 38.0, vec);
    _drawText(canvas, 'v = (+ , +)',
        Offset(vEnd.dx + 6.0, vEnd.dy - 4.0),
        const Color(0xFF1746B3), 11.5);

    // Negative dy vector (upward swipe)
    final Paint vecUp = Paint()
      ..color = const Color(0xFFB23A52)
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;
    final Offset vUpEnd = Offset(origin.dx + xLen * 0.30,
        origin.dy - yLen * 0.22);
    canvas.drawLine(origin, vUpEnd, vecUp);
    _arrowhead(canvas, vUpEnd, -38.0, vecUp);
    _drawText(canvas, 'v = (+ , −)',
        Offset(vUpEnd.dx + 6.0, vUpEnd.dy - 14.0),
        const Color(0xFFB23A52), 11.5);
  }

  void _arrowhead(Canvas canvas, Offset tip, double angleDeg, Paint paint) {
    final double rad = angleDeg * 3.141592653589793 / 180.0;
    final double size = 8.0;
    final double back = 12.0;
    final double bx = tip.dx -
        back * (rad == 0.0 ? 1.0 : _cos(rad));
    final double by = tip.dy - back * _sin(rad);
    final Offset wing1 = Offset(
      bx + size * _sin(rad),
      by - size * _cos(rad),
    );
    final Offset wing2 = Offset(
      bx - size * _sin(rad),
      by + size * _cos(rad),
    );
    final Path path = Path()
      ..moveTo(tip.dx, tip.dy)
      ..lineTo(wing1.dx, wing1.dy)
      ..lineTo(wing2.dx, wing2.dy)
      ..close();
    final Paint fill = Paint()..color = paint.color;
    canvas.drawPath(path, fill);
  }

  // Local sin/cos approximations using Taylor series are overkill — use real
  // math via dart:math? Cannot import. Approximate with low-order series for
  // small angles; for general angles, fall back to a small lookup-free
  // estimate. Since we only call with fixed angles (0, 90, 38, -38) the
  // accuracy needed is modest.
  double _sin(double r) {
    // Reduce to [-pi, pi]
    const double pi = 3.141592653589793;
    double x = r;
    while (x > pi) {
      x -= 2.0 * pi;
    }
    while (x < -pi) {
      x += 2.0 * pi;
    }
    final double x2 = x * x;
    return x * (1.0 - x2 / 6.0 + x2 * x2 / 120.0 - x2 * x2 * x2 / 5040.0);
  }

  double _cos(double r) {
    const double pi = 3.141592653589793;
    double x = r;
    while (x > pi) {
      x -= 2.0 * pi;
    }
    while (x < -pi) {
      x += 2.0 * pi;
    }
    final double x2 = x * x;
    return 1.0 - x2 / 2.0 + x2 * x2 / 24.0 - x2 * x2 * x2 / 720.0;
  }

  void _drawText(
      Canvas canvas, String text, Offset pos, Color color, double size) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, pos);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// Section 8: Use cases
// ---------------------------------------------------------------------------

class _SectionUseCases extends StatelessWidget {
  const _SectionUseCases();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          index: '08',
          title: 'Use cases',
          subtitle: 'Where Flutter consumes VelocityTracker output.',
          icon: Icons.dashboard_customize_rounded,
          color: _kAccent,
          colorDark: _kAccentDark,
        ),
        const SizedBox(height: 12.0),
        Row(
          children: const <Widget>[
            Expanded(
              child: _UseCaseCard(
                title: 'PageView snap',
                icon: Icons.view_carousel_rounded,
                color: _kAccent,
                colorDark: _kAccentDark,
                snippet:
                    'if (velocity.pixelsPerSecond.dx.abs() > 400)\n'
                    '  snapToNextPage();',
                description:
                    'Use dx of pixelsPerSecond to decide whether a swipe '
                    'crosses the page-snap threshold.',
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _UseCaseCard(
                title: 'Dismissible swipe',
                icon: Icons.swipe_rounded,
                color: _kCoral,
                colorDark: _kCoralDark,
                snippet:
                    'final v = velocity.pixelsPerSecond.dx;\n'
                    'if (v.abs() > 700) dismiss();',
                description:
                    'Dismissible uses signed dx velocity to decide if a '
                    'fling completes the dismissal.',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          children: const <Widget>[
            Expanded(
              child: _UseCaseCard(
                title: 'Scroll fling',
                icon: Icons.south_rounded,
                color: _kMint,
                colorDark: _kMintDark,
                snippet:
                    'final v = velocity.pixelsPerSecond.dy;\n'
                    'simulation = ClampingScrollSimulation(\n'
                    '  position: pos, velocity: v);',
                description:
                    'Scrollables convert dy velocity into a simulation that '
                    'drives the scroll position over time.',
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _UseCaseCard(
                title: 'Custom drag widget',
                icon: Icons.open_with_rounded,
                color: _kPlum,
                colorDark: _kPlumDark,
                snippet:
                    'final est = tracker.getVelocityEstimate();\n'
                    'if ((est?.confidence ?? 0) > 0.5) {\n'
                    '  startInertia(est!.pixelsPerSecond);\n'
                    '}',
                description:
                    'Gate inertia animations on confidence so jittery taps '
                    'do not produce surprise momentum.',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _UseCaseCard extends StatelessWidget {
  const _UseCaseCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.colorDark,
    required this.snippet,
    required this.description,
  });

  final String title;
  final IconData icon;
  final Color color;
  final Color colorDark;
  final String snippet;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 14.0),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: _kBorder, width: 1.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF1F2933).withValues(alpha: 0.04),
            blurRadius: 10.0,
            offset: const Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36.0,
                height: 36.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[color, colorDark],
                  ),
                  borderRadius: BorderRadius.circular(9.0),
                ),
                alignment: Alignment.center,
                child: Icon(icon, size: 19.0, color: Colors.white),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800,
                    color: _kInk,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
            decoration: BoxDecoration(
              color: const Color(0xFF1F2933),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              snippet,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Color(0xFFDDEBFF),
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            description,
            style: const TextStyle(
              fontSize: 11.5,
              color: _kInkSoft,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 9: Code block — full usage
// ---------------------------------------------------------------------------

class _SectionCodeBlock extends StatelessWidget {
  const _SectionCodeBlock();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          index: '09',
          title: 'Full usage snippet',
          subtitle: 'A complete fling-detection pattern.',
          icon: Icons.code_rounded,
          color: _kPlum,
          colorDark: _kPlumDark,
        ),
        const SizedBox(height: 12.0),
        _CardBody(
          padding: const EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 14.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Color(0xFF1F2933),
                      Color(0xFF111820),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: const Color(0xFF2C3A45),
                    width: 1.0,
                  ),
                ),
                child: const Text(
                  'final tracker = VelocityTracker.withKind(\n'
                  '  PointerDeviceKind.touch,\n'
                  ');\n'
                  '\n'
                  'void handleMove(PointerMoveEvent event) {\n'
                  '  tracker.addPosition(\n'
                  '    event.timeStamp,\n'
                  '    event.localPosition,\n'
                  '  );\n'
                  '}\n'
                  '\n'
                  'void handleUp(PointerUpEvent event) {\n'
                  '  final Velocity v = tracker.getVelocity();\n'
                  '  if (v.pixelsPerSecond.dx.abs() > 800.0) {\n'
                  '    triggerFling(v.pixelsPerSecond);\n'
                  '  } else {\n'
                  '    snapBack();\n'
                  '  }\n'
                  '  tracker.reset();\n'
                  '}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    color: Color(0xFFE6F1FF),
                    height: 1.55,
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              Row(
                children: const <Widget>[
                  _Tag(text: 'PointerDeviceKind.touch', color: _kAccent),
                  SizedBox(width: 6.0),
                  _Tag(text: 'getVelocity()', color: _kMint),
                  SizedBox(width: 6.0),
                  _Tag(text: 'reset()', color: _kCoral),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.text, required this.color});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(
          color: color.withValues(alpha: 0.40),
          width: 1.0,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 10.5,
          fontWeight: FontWeight.w800,
          color: color,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 10: Pitfalls
// ---------------------------------------------------------------------------

class _SectionPitfalls extends StatelessWidget {
  const _SectionPitfalls();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          index: '10',
          title: 'Pitfalls',
          subtitle: 'Common mistakes when using VelocityTracker.',
          icon: Icons.warning_amber_rounded,
          color: _kAmber,
          colorDark: _kAmberDark,
        ),
        const SizedBox(height: 12.0),
        _CardBody(
          child: Column(
            children: const <Widget>[
              _PitfallRow(
                index: 1,
                title: 'Samples out of order',
                description:
                    'addPosition expects monotonically non-decreasing time '
                    'values. Mixing samples from two pointers corrupts the '
                    'fit.',
              ),
              _PitfallRow(
                index: 2,
                title: 'Missing reset between gestures',
                description:
                    'After a pointer up or cancel, call reset(). Otherwise '
                    'stale samples bleed into the next gesture and produce '
                    'phantom velocity.',
              ),
              _PitfallRow(
                index: 3,
                title: 'Ignoring axis filtering',
                description:
                    'A horizontal scroll widget should only care about dx. '
                    'Use a clampMagnitude or zero-out dy before applying '
                    'physics.',
              ),
              _PitfallRow(
                index: 4,
                title: 'Acting on every estimate',
                description:
                    'getVelocityEstimate is cheap but its confidence can be '
                    'low until you have at least 3 samples. Wait for a '
                    'gesture-end before final decisions.',
              ),
              _PitfallRow(
                index: 5,
                title: 'Skipping confidence threshold',
                description:
                    'Trusting a Velocity blindly leads to surprise flings on '
                    'tiny finger movements. Threshold confidence > 0.5.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PitfallRow extends StatelessWidget {
  const _PitfallRow({
    required this.index,
    required this.title,
    required this.description,
  });

  final int index;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 28.0,
            height: 28.0,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color(0xFFF6A623),
                  Color(0xFFB6791A),
                ],
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: Alignment.center,
            child: Text(
              index.toString(),
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: _kInk,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: _kInkSoft,
                    height: 1.5,
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
// Section 11: Footer
// ---------------------------------------------------------------------------

class _SectionFooter extends StatelessWidget {
  const _SectionFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF2C3A45),
            Color(0xFF1F2933),
          ],
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.30),
                width: 1.0,
              ),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.speed_rounded,
              size: 22.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'VelocityTracker — visual deep demo',
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  'package:flutter/gestures.dart · static snapshot',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Colors.white.withValues(alpha: 0.80),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 9.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text(
              'v1.0.0',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
