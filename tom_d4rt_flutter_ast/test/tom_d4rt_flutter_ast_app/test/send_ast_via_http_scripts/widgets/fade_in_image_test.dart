import 'dart:typed_data';

import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// FadeInImage — deep visual demo (sandbox safe).
//
// FadeInImage shows a lightweight placeholder image first, then once the target
// image decodes it cross-fades into place. In the sandbox we cannot perform any
// network work so every FadeInImage we mount below uses `MemoryImage` with tiny
// inline PNG byte arrays. Wherever we want to *show* the behaviour dynamically
// we build a stateless `_SimulatedFadeInImage` that blends two child widgets
// with controllable opacity — this is the visual analogue of the real widget
// without any asynchronous loading.
//
// Top-level `ValueNotifier`s drive the interactive pieces (slider, duration,
// curve, fit) via `ValueListenableBuilder`. No `StatefulWidget` anywhere.
// -----------------------------------------------------------------------------

// A 1x1 transparent PNG — minimum valid byte sequence accepted by MemoryImage.
final Uint8List _pngClear = Uint8List.fromList(<int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D,
  0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
  0x0D, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49,
  0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82,
]);

// A 1x1 mid-grey PNG used as a "low-resolution placeholder".
final Uint8List _pngGrey = Uint8List.fromList(<int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D,
  0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
  0x10, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x62, 0x98, 0x98, 0x98, 0xF8,
  0x0F, 0x00, 0x00, 0x05, 0x00, 0x01, 0x62, 0x7A, 0xD3, 0xE3, 0x00, 0x00,
  0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82,
]);

// Interactive drivers.
final ValueNotifier<double> _fadeSlider = ValueNotifier<double>(0.35);
final ValueNotifier<int> _durationChoice = ValueNotifier<int>(1); // index in _durations
final ValueNotifier<int> _curveChoice = ValueNotifier<int>(3); // index in _curves
final ValueNotifier<int> _fitChoice = ValueNotifier<int>(1); // index in _allFits
final ValueNotifier<int> _alignChoice = ValueNotifier<int>(4); // centre by default

const List<int> _durations = <int>[200, 400, 800, 1600];
const List<String> _durationLabels = <String>['200 ms', '400 ms', '800 ms', '1.6 s'];

const List<Curve> _curves = <Curve>[
  Curves.linear,
  Curves.easeIn,
  Curves.easeOut,
  Curves.easeInOut,
  Curves.bounceOut,
];
const List<String> _curveNames = <String>[
  'linear',
  'easeIn',
  'easeOut',
  'easeInOut',
  'bounceOut',
];

const List<BoxFit> _allFits = <BoxFit>[
  BoxFit.contain,
  BoxFit.cover,
  BoxFit.fill,
  BoxFit.fitWidth,
  BoxFit.fitHeight,
  BoxFit.none,
  BoxFit.scaleDown,
];
const List<String> _fitLabels = <String>[
  'contain',
  'cover',
  'fill',
  'fitWidth',
  'fitHeight',
  'none',
  'scaleDown',
];

const List<Alignment> _alignmentCycle = <Alignment>[
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
const List<String> _alignmentNames = <String>[
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

dynamic build(BuildContext context) {
  final ColorScheme scheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF4C5FD5),
    brightness: Brightness.light,
  );
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true, colorScheme: scheme),
    home: DefaultTabController(
      length: 9,
      child: Scaffold(
        backgroundColor: scheme.surface,
        appBar: AppBar(
          title: const Text('FadeInImage — visual guide'),
          backgroundColor: scheme.primaryContainer,
          foregroundColor: scheme.onPrimaryContainer,
          bottom: const TabBar(
            isScrollable: true,
            tabs: <Widget>[
              Tab(text: 'Overview'),
              Tab(text: 'Lifecycle'),
              Tab(text: 'Real showcase'),
              Tab(text: 'Simulated'),
              Tab(text: 'Duration/Curve'),
              Tab(text: 'Error builders'),
              Tab(text: 'Fit & Align'),
              Tab(text: 'Use cases'),
              Tab(text: 'Cheat sheet'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _OverviewTab(scheme: scheme),
            _LifecycleTab(scheme: scheme),
            _RealShowcaseTab(scheme: scheme),
            _SimulatedTab(scheme: scheme),
            _DurationCurveTab(scheme: scheme),
            _ErrorBuilderTab(scheme: scheme),
            _FitAlignTab(scheme: scheme),
            _UseCaseTab(scheme: scheme),
            _CheatSheetTab(scheme: scheme),
          ],
        ),
      ),
    ),
  );
}

// =============================================================================
// TAB 1 — OVERVIEW / HERO BANNER
// =============================================================================

class _OverviewTab extends StatelessWidget {
  const _OverviewTab({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _HeroBanner(scheme: scheme),
        const SizedBox(height: 24),
        _SectionTitle(scheme: scheme, label: 'What FadeInImage solves'),
        const SizedBox(height: 12),
        _Paragraph(
          text:
              'When a large image decodes the widget tree would otherwise flash '
              'an empty box. FadeInImage keeps a small placeholder visible, '
              'then smoothly blends the real image in once it is ready. The '
              'result is a consumer-grade progressive reveal without any '
              'controller plumbing.',
        ),
        const SizedBox(height: 16),
        _KeyPointsGrid(scheme: scheme),
        const SizedBox(height: 24),
        _SectionTitle(scheme: scheme, label: 'Two states, one widget'),
        const SizedBox(height: 12),
        _TwoStateDiagram(scheme: scheme),
        const SizedBox(height: 24),
        _SectionTitle(scheme: scheme, label: 'Sandbox note'),
        const SizedBox(height: 12),
        _CalloutCard(
          scheme: scheme,
          icon: Icons.info_outline,
          title: 'Memory-only demo',
          body:
              'This sandbox cannot reach the network, so every real FadeInImage '
              'below is built with MemoryImage and tiny 1x1 PNG bytes. The fade '
              'behaviour is reproduced visually by _SimulatedFadeInImage which '
              'blends two widgets using TweenAnimationBuilder and opacity.',
        ),
      ],
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            scheme.primary,
            scheme.tertiary,
          ],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: scheme.primary.withAlpha(80),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: scheme.onPrimary.withAlpha(40),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(Icons.image_outlined, size: 32, color: scheme.onPrimary),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'FadeInImage',
                      style: TextStyle(
                        color: scheme.onPrimary,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Graceful placeholder → target cross-fade',
                      style: TextStyle(
                        color: scheme.onPrimary.withAlpha(220),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _HeroPill(scheme: scheme, label: 'placeholder', icon: Icons.blur_on),
          const SizedBox(height: 8),
          _HeroPill(scheme: scheme, label: 'fadeOutDuration → fadeInDuration', icon: Icons.swap_horiz),
          const SizedBox(height: 8),
          _HeroPill(scheme: scheme, label: 'target image', icon: Icons.photo),
        ],
      ),
    );
  }
}

class _HeroPill extends StatelessWidget {
  const _HeroPill({required this.scheme, required this.label, required this.icon});
  final ColorScheme scheme;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: scheme.onPrimary.withAlpha(48),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 16, color: scheme.onPrimary),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: scheme.onPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _KeyPointsGrid extends StatelessWidget {
  const _KeyPointsGrid({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final List<List<String>> points = <List<String>>[
      <String>['No controller', 'Animations are internal to the widget'],
      <String>['Error fallback', 'placeholder / image error builders'],
      <String>['Replaces loading spinners', 'Users see content the whole time'],
      <String>['Pairs with Image.*', 'MemoryImage / AssetImage / NetworkImage'],
    ];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: points.map((List<String> p) {
        return SizedBox(
          width: 260,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: scheme.secondaryContainer,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: scheme.outlineVariant),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  p[0],
                  style: TextStyle(
                    color: scheme.onSecondaryContainer,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  p[1],
                  style: TextStyle(
                    color: scheme.onSecondaryContainer.withAlpha(210),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _TwoStateDiagram extends StatelessWidget {
  const _TwoStateDiagram({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: CustomPaint(
        painter: _TwoStatePainter(scheme: scheme),
        size: Size.infinite,
      ),
    );
  }
}

class _TwoStatePainter extends CustomPainter {
  _TwoStatePainter({required this.scheme});
  final ColorScheme scheme;

  @override
  void paint(Canvas canvas, Size size) {
    final double half = size.width / 2;
    final Paint left = Paint()..color = scheme.tertiaryContainer;
    final Paint right = Paint()..color = scheme.primaryContainer;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(12, 12, half - 24, size.height - 24),
        const Radius.circular(18),
      ),
      left,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(half + 12, 12, half - 24, size.height - 24),
        const Radius.circular(18),
      ),
      right,
    );
    _drawLabel(canvas, 'placeholder', 32, 40, scheme.onTertiaryContainer, bold: true);
    _drawLabel(canvas, 'low fidelity', 32, 66, scheme.onTertiaryContainer);
    _drawLabel(canvas, 'small bytes', 32, 86, scheme.onTertiaryContainer);
    _drawLabel(canvas, 'always ready', 32, 106, scheme.onTertiaryContainer);
    _drawLabel(canvas, 'image', half + 32, 40, scheme.onPrimaryContainer, bold: true);
    _drawLabel(canvas, 'high fidelity', half + 32, 66, scheme.onPrimaryContainer);
    _drawLabel(canvas, 'loads asynchronously', half + 32, 86, scheme.onPrimaryContainer);
    _drawLabel(canvas, 'cross-faded in', half + 32, 106, scheme.onPrimaryContainer);
    final Paint arrow = Paint()
      ..color = scheme.onSurface
      ..strokeWidth = 2.4
      ..style = PaintingStyle.stroke;
    final double midY = size.height / 2;
    canvas.drawLine(Offset(half - 4, midY), Offset(half + 4, midY), arrow);
    final Path tri = Path()
      ..moveTo(half + 4, midY - 6)
      ..lineTo(half + 14, midY)
      ..lineTo(half + 4, midY + 6)
      ..close();
    canvas.drawPath(tri, Paint()..color = scheme.onSurface);
  }

  void _drawLabel(Canvas canvas, String text, double x, double y, Color color,
      {bool bold = false}) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: bold ? 16 : 12,
          fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(x, y));
  }

  @override
  bool shouldRepaint(covariant _TwoStatePainter oldDelegate) => false;
}

// =============================================================================
// TAB 2 — LIFECYCLE DIAGRAM
// =============================================================================

class _LifecycleTab extends StatelessWidget {
  const _LifecycleTab({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _SectionTitle(scheme: scheme, label: 'The four-phase fade'),
        const SizedBox(height: 12),
        _Paragraph(
          text:
              'Internally, FadeInImage orchestrates a fade-out of the placeholder '
              'and a fade-in of the target. Durations and curves are independent '
              'for each direction. The timeline below names each phase and shows '
              'which widget is visible.',
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 260,
          child: CustomPaint(
            painter: _LifecyclePainter(scheme: scheme),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: 24),
        _PhaseList(scheme: scheme),
        const SizedBox(height: 24),
        _SectionTitle(scheme: scheme, label: 'Pseudo timeline formula'),
        const SizedBox(height: 12),
        _CodeBlock(
          scheme: scheme,
          code: 'placeholderOpacity = 1 - fadeOutCurve(t / fadeOutDuration)\n'
              'imageOpacity       = fadeInCurve(max(0, (t - fadeOutDuration) / fadeInDuration))',
        ),
        const SizedBox(height: 20),
        _CalloutCard(
          scheme: scheme,
          icon: Icons.timer_outlined,
          title: 'Default durations',
          body:
              'fadeOutDuration defaults to 300 ms, fadeInDuration to 700 ms. Both '
              'default to Curves.easeIn. For very short images, matching both to '
              'the same short duration feels snappier.',
        ),
      ],
    );
  }
}

class _LifecyclePainter extends CustomPainter {
  _LifecyclePainter({required this.scheme});
  final ColorScheme scheme;

  @override
  void paint(Canvas canvas, Size size) {
    final double lanesTop = 40;
    final double laneHeight = 70;
    final Paint bg = Paint()..color = scheme.surfaceContainerHighest;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(16),
      ),
      bg,
    );

    // Axis title row.
    _drawText(canvas, 'placeholder opacity', 16, lanesTop - 24, scheme.onSurfaceVariant, 12);
    _drawText(canvas, 'image opacity', 16, lanesTop + laneHeight + 16, scheme.onSurfaceVariant, 12);

    // Lanes backgrounds.
    final Paint lane = Paint()..color = scheme.surface;
    canvas.drawRect(
      Rect.fromLTWH(16, lanesTop, size.width - 32, laneHeight),
      lane,
    );
    canvas.drawRect(
      Rect.fromLTWH(16, lanesTop + laneHeight + 24, size.width - 32, laneHeight),
      lane,
    );

    // Phase segments.
    final List<double> phaseBreaks = <double>[0.0, 0.15, 0.55, 0.85, 1.0];
    final List<Color> phaseColors = <Color>[
      scheme.tertiary,
      scheme.tertiary.withAlpha(160),
      scheme.primary.withAlpha(180),
      scheme.primary,
    ];
    final List<String> phaseNames = <String>[
      'placeholder shown',
      'decode starts',
      'cross-fade',
      'image visible',
    ];
    final double areaLeft = 16;
    final double areaWidth = size.width - 32;

    for (int i = 0; i < 4; i++) {
      final double x0 = areaLeft + phaseBreaks[i] * areaWidth;
      final double x1 = areaLeft + phaseBreaks[i + 1] * areaWidth;
      final Paint marker = Paint()..color = phaseColors[i].withAlpha(40);
      canvas.drawRect(Rect.fromLTWH(x0, lanesTop, x1 - x0, laneHeight), marker);
      canvas.drawRect(
        Rect.fromLTWH(x0, lanesTop + laneHeight + 24, x1 - x0, laneHeight),
        marker,
      );
      _drawText(canvas, phaseNames[i], x0 + 6, lanesTop + laneHeight * 2 + 34,
          scheme.onSurface, 10);
    }

    // Opacity curves.
    final Path placeholderPath = Path();
    final Path imagePath = Path();
    for (int i = 0; i <= 80; i++) {
      final double t = i / 80.0;
      final double ph = _computePlaceholder(t);
      final double im = _computeImage(t);
      final double x = areaLeft + t * areaWidth;
      final double phY = lanesTop + laneHeight - ph * (laneHeight - 8) - 4;
      final double imY = lanesTop + laneHeight + 24 + laneHeight - im * (laneHeight - 8) - 4;
      if (i == 0) {
        placeholderPath.moveTo(x, phY);
        imagePath.moveTo(x, imY);
      } else {
        placeholderPath.lineTo(x, phY);
        imagePath.lineTo(x, imY);
      }
    }
    final Paint phPaint = Paint()
      ..color = scheme.tertiary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.6;
    final Paint imPaint = Paint()
      ..color = scheme.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.6;
    canvas.drawPath(placeholderPath, phPaint);
    canvas.drawPath(imagePath, imPaint);
  }

  double _computePlaceholder(double t) {
    if (t < 0.15) return 1.0;
    if (t < 0.85) {
      final double phase = (t - 0.15) / 0.70;
      return 1.0 - Curves.easeIn.transform(phase);
    }
    return 0.0;
  }

  double _computeImage(double t) {
    if (t < 0.15) return 0.0;
    if (t < 0.85) {
      final double phase = (t - 0.15) / 0.70;
      return Curves.easeIn.transform(phase);
    }
    return 1.0;
  }

  void _drawText(Canvas canvas, String text, double x, double y, Color color, double size) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: size, fontWeight: FontWeight.w600),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(x, y));
  }

  @override
  bool shouldRepaint(covariant _LifecyclePainter oldDelegate) => false;
}

class _PhaseList extends StatelessWidget {
  const _PhaseList({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final List<List<String>> phases = <List<String>>[
      <String>['1. Placeholder showing',
          'Opacity is 1.0 for the placeholder image; the main image has not yet been requested.'],
      <String>['2. Image loading',
          'Provider starts resolving the target; placeholder still fully visible.'],
      <String>['3. Cross-fade',
          'fadeOut + fadeIn overlap; placeholder opacity slides from 1 → 0 while image goes 0 → 1.'],
      <String>['4. Image visible',
          'Target fully opaque; placeholder has been torn down by the widget internals.'],
    ];
    return Column(
      children: phases.map((List<String> p) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: scheme.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: scheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  p[0].substring(0, 1),
                  style: TextStyle(
                    color: scheme.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      p[0],
                      style: TextStyle(
                        color: scheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      p[1],
                      style: TextStyle(
                        color: scheme.onSurfaceVariant,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// =============================================================================
// TAB 3 — REAL FADEINIMAGE SHOWCASE
// =============================================================================

class _RealShowcaseTab extends StatelessWidget {
  const _RealShowcaseTab({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _SectionTitle(scheme: scheme, label: 'Real FadeInImage widgets'),
        const SizedBox(height: 12),
        _Paragraph(
          text:
              'Each tile below mounts a live FadeInImage using MemoryImage. The '
              'PNG bytes are intentionally tiny — the point is to prove the '
              'widget accepts and renders real provider output inside the '
              'sandbox. The framing decoration around each tile makes the tiny '
              'image visible as a coloured dot.',
        ),
        const SizedBox(height: 20),
        GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 0.9,
          children: <Widget>[
            _PhotoFrame(
              scheme: scheme,
              label: 'default',
              caption: 'implicit fit',
              child: FadeInImage(
                placeholder: MemoryImage(_pngGrey),
                image: MemoryImage(_pngClear),
                fadeInDuration: const Duration(milliseconds: 700),
                fadeOutDuration: const Duration(milliseconds: 300),
              ),
            ),
            _PhotoFrame(
              scheme: scheme,
              label: 'BoxFit.cover',
              caption: 'fills, crops edges',
              child: FadeInImage(
                placeholder: MemoryImage(_pngGrey),
                image: MemoryImage(_pngClear),
                fit: BoxFit.cover,
                width: 160,
                height: 120,
              ),
            ),
            _PhotoFrame(
              scheme: scheme,
              label: 'BoxFit.contain',
              caption: 'keeps aspect',
              child: FadeInImage(
                placeholder: MemoryImage(_pngGrey),
                image: MemoryImage(_pngClear),
                fit: BoxFit.contain,
                width: 160,
                height: 120,
              ),
            ),
            _PhotoFrame(
              scheme: scheme,
              label: 'BoxFit.fill',
              caption: 'stretches',
              child: FadeInImage(
                placeholder: MemoryImage(_pngGrey),
                image: MemoryImage(_pngClear),
                fit: BoxFit.fill,
                width: 160,
                height: 120,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _SectionTitle(scheme: scheme, label: 'Constructor anatomy'),
        const SizedBox(height: 12),
        _CodeBlock(
          scheme: scheme,
          code: 'FadeInImage(\n'
              '  placeholder: MemoryImage(smallBytes),\n'
              '  image: MemoryImage(bigBytes),\n'
              '  fadeInDuration: Duration(milliseconds: 700),\n'
              '  fadeOutDuration: Duration(milliseconds: 300),\n'
              '  fadeInCurve: Curves.easeIn,\n'
              '  fadeOutCurve: Curves.easeIn,\n'
              '  fit: BoxFit.cover,\n'
              '  alignment: Alignment.center,\n'
              ');',
        ),
        const SizedBox(height: 20),
        _CalloutCard(
          scheme: scheme,
          icon: Icons.lightbulb_outline,
          title: 'Why MemoryImage here?',
          body:
              'The sandbox cannot fetch URLs. FadeInImage.assetNetwork and '
              'FadeInImage.memoryNetwork both hit the network, so they would '
              'throw. MemoryImage is deterministic, completes immediately, and '
              'still exercises the placeholder→image transition through the '
              'ImageStream API.',
        ),
      ],
    );
  }
}

class _PhotoFrame extends StatelessWidget {
  const _PhotoFrame({
    required this.scheme,
    required this.label,
    required this.caption,
    required this.child,
  });
  final ColorScheme scheme;
  final String label;
  final String caption;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: scheme.outlineVariant),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: scheme.primary.withAlpha(30),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: scheme.primary.withAlpha(80)),
              ),
              alignment: Alignment.center,
              child: SizedBox(
                width: 64,
                height: 64,
                child: child,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              color: scheme.onSurface,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          Text(
            caption,
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 4 — SIMULATED PLAYGROUND
// =============================================================================

class _SimulatedTab extends StatelessWidget {
  const _SimulatedTab({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _SectionTitle(scheme: scheme, label: 'Slider-driven cross-fade'),
        const SizedBox(height: 12),
        _Paragraph(
          text:
              '_SimulatedFadeInImage mirrors what the real widget does with '
              'ImageStream listeners: it layers two children and drives their '
              'opacities from a single progress value. Drag the slider to walk '
              'through the cross-fade frame by frame.',
        ),
        const SizedBox(height: 20),
        ValueListenableBuilder<double>(
          valueListenable: _fadeSlider,
          builder: (BuildContext context, double progress, Widget? _) {
            return Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: scheme.outlineVariant),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 200,
                        child: _SimulatedFadeInImage(
                          t: progress,
                          placeholder: _PlaceholderArt(scheme: scheme),
                          image: _HighFidelityArt(scheme: scheme),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: <Widget>[
                          Text(
                            'placeholder',
                            style: TextStyle(
                              color: scheme.tertiary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Expanded(
                            child: Slider(
                              value: progress,
                              onChanged: (double v) => _fadeSlider.value = v,
                            ),
                          ),
                          Text(
                            'image',
                            style: TextStyle(
                              color: scheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'progress = ${(progress * 100).toStringAsFixed(0)}%   '
                        'placeholder α = ${((1 - progress) * 100).toStringAsFixed(0)}%   '
                        'image α = ${(progress * 100).toStringAsFixed(0)}%',
                        style: TextStyle(
                          color: scheme.onSurfaceVariant,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    _MiniSnapshot(scheme: scheme, progress: 0.0, label: 't=0.00'),
                    _MiniSnapshot(scheme: scheme, progress: 0.25, label: 't=0.25'),
                    _MiniSnapshot(scheme: scheme, progress: 0.50, label: 't=0.50'),
                    _MiniSnapshot(scheme: scheme, progress: 0.75, label: 't=0.75'),
                    _MiniSnapshot(scheme: scheme, progress: 1.00, label: 't=1.00'),
                  ],
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 24),
        _SectionTitle(scheme: scheme, label: 'How the simulation is built'),
        const SizedBox(height: 12),
        _CodeBlock(
          scheme: scheme,
          code: 'class _SimulatedFadeInImage extends StatelessWidget {\n'
              '  final Widget placeholder;\n'
              '  final Widget image;\n'
              '  final double t;            // 0..1 progress\n'
              '  @override\n'
              '  Widget build(BuildContext context) => Stack(\n'
              '    fit: StackFit.expand,\n'
              '    children: [\n'
              '      Opacity(opacity: 1 - t, child: placeholder),\n'
              '      Opacity(opacity: t, child: image),\n'
              '    ],\n'
              '  );\n'
              '}',
        ),
      ],
    );
  }
}

class _SimulatedFadeInImage extends StatelessWidget {
  const _SimulatedFadeInImage({
    required this.placeholder,
    required this.image,
    required this.t,
  });
  final Widget placeholder;
  final Widget image;
  final double t;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Opacity(opacity: (1.0 - t).clamp(0.0, 1.0), child: placeholder),
          Opacity(opacity: t.clamp(0.0, 1.0), child: image),
        ],
      ),
    );
  }
}

class _PlaceholderArt extends StatelessWidget {
  const _PlaceholderArt({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            scheme.tertiaryContainer,
            scheme.tertiary.withAlpha(120),
          ],
        ),
      ),
      alignment: Alignment.center,
      child: Icon(
        Icons.blur_on,
        size: 72,
        color: scheme.onTertiaryContainer.withAlpha(180),
      ),
    );
  }
}

class _HighFidelityArt extends StatelessWidget {
  const _HighFidelityArt({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _MountainScenePainter(scheme: scheme),
      size: Size.infinite,
    );
  }
}

class _MountainScenePainter extends CustomPainter {
  _MountainScenePainter({required this.scheme});
  final ColorScheme scheme;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint sky = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          scheme.primary,
          scheme.primaryContainer,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height * 0.6));
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height * 0.6),
      sky,
    );
    final Paint sun = Paint()..color = scheme.tertiary;
    canvas.drawCircle(Offset(size.width * 0.72, size.height * 0.25), 22, sun);

    final Path back = Path()
      ..moveTo(0, size.height * 0.55)
      ..lineTo(size.width * 0.3, size.height * 0.28)
      ..lineTo(size.width * 0.55, size.height * 0.50)
      ..lineTo(size.width * 0.78, size.height * 0.30)
      ..lineTo(size.width, size.height * 0.55)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(back, Paint()..color = scheme.secondary.withAlpha(180));

    final Path front = Path()
      ..moveTo(0, size.height * 0.75)
      ..lineTo(size.width * 0.22, size.height * 0.55)
      ..lineTo(size.width * 0.48, size.height * 0.80)
      ..lineTo(size.width * 0.70, size.height * 0.58)
      ..lineTo(size.width, size.height * 0.78)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(front, Paint()..color = scheme.primary);
  }

  @override
  bool shouldRepaint(covariant _MountainScenePainter oldDelegate) => false;
}

class _MiniSnapshot extends StatelessWidget {
  const _MiniSnapshot({
    required this.scheme,
    required this.progress,
    required this.label,
  });
  final ColorScheme scheme;
  final double progress;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 80,
            child: _SimulatedFadeInImage(
              t: progress,
              placeholder: _PlaceholderArt(scheme: scheme),
              image: _HighFidelityArt(scheme: scheme),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: scheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 5 — DURATION & CURVE PLAYGROUND
// =============================================================================

class _DurationCurveTab extends StatelessWidget {
  const _DurationCurveTab({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _SectionTitle(scheme: scheme, label: 'Pick a duration'),
        const SizedBox(height: 12),
        ValueListenableBuilder<int>(
          valueListenable: _durationChoice,
          builder: (BuildContext context, int d, Widget? _) {
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_durations.length, (int i) {
                return _ChoicePill(
                  scheme: scheme,
                  label: _durationLabels[i],
                  selected: i == d,
                  onTap: () => _durationChoice.value = i,
                );
              }),
            );
          },
        ),
        const SizedBox(height: 20),
        _SectionTitle(scheme: scheme, label: 'Pick a curve'),
        const SizedBox(height: 12),
        ValueListenableBuilder<int>(
          valueListenable: _curveChoice,
          builder: (BuildContext context, int c, Widget? _) {
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_curves.length, (int i) {
                return _ChoicePill(
                  scheme: scheme,
                  label: _curveNames[i],
                  selected: i == c,
                  onTap: () => _curveChoice.value = i,
                );
              }),
            );
          },
        ),
        const SizedBox(height: 24),
        _SectionTitle(scheme: scheme, label: 'Live preview'),
        const SizedBox(height: 12),
        ValueListenableBuilder<int>(
          valueListenable: _durationChoice,
          builder: (BuildContext context, int dIndex, Widget? _) {
            return ValueListenableBuilder<int>(
              valueListenable: _curveChoice,
              builder: (BuildContext context, int cIndex, Widget? _) {
                final Duration d = Duration(milliseconds: _durations[dIndex]);
                final Curve c = _curves[cIndex];
                return Container(
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: scheme.outlineVariant),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 180,
                        child: TweenAnimationBuilder<double>(
                          key: ValueKey<String>('tween-$dIndex-$cIndex'),
                          tween: Tween<double>(begin: 0.0, end: 1.0),
                          duration: d,
                          curve: c,
                          builder: (BuildContext context, double v, Widget? _) {
                            return _SimulatedFadeInImage(
                              t: v,
                              placeholder: _PlaceholderArt(scheme: scheme),
                              image: _HighFidelityArt(scheme: scheme),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'duration: ${_durationLabels[dIndex]}',
                            style: TextStyle(
                              color: scheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'curve: ${_curveNames[cIndex]}',
                            style: TextStyle(
                              color: scheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _CurveMiniature(
                        scheme: scheme,
                        curve: c,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        const SizedBox(height: 24),
        _SectionTitle(scheme: scheme, label: 'Guidance'),
        const SizedBox(height: 12),
        Column(
          children: <Widget>[
            _GuidanceRow(
              scheme: scheme,
              title: 'Short duration (≤ 200 ms)',
              body: 'Feels instant; use for UI chrome where no animation would look broken.',
            ),
            _GuidanceRow(
              scheme: scheme,
              title: 'Medium (300-700 ms)',
              body: 'Matches Flutter defaults; reads as a polished transition.',
            ),
            _GuidanceRow(
              scheme: scheme,
              title: 'Long (≥ 1 s)',
              body: 'Great for hero-style reveals but feels sluggish in list scrolling.',
            ),
            _GuidanceRow(
              scheme: scheme,
              title: 'Nonlinear curves',
              body: 'easeOut and easeInOut mimic real camera focus pulls; bounceOut is deliberately playful.',
            ),
          ],
        ),
      ],
    );
  }
}

class _ChoicePill extends StatelessWidget {
  const _ChoicePill({
    required this.scheme,
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final ColorScheme scheme;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? scheme.primary : scheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: selected ? scheme.primary : scheme.outlineVariant,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? scheme.onPrimary : scheme.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _CurveMiniature extends StatelessWidget {
  const _CurveMiniature({required this.scheme, required this.curve});
  final ColorScheme scheme;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: CustomPaint(
        painter: _CurveMiniaturePainter(scheme: scheme, curve: curve),
        size: Size.infinite,
      ),
    );
  }
}

class _CurveMiniaturePainter extends CustomPainter {
  _CurveMiniaturePainter({required this.scheme, required this.curve});
  final ColorScheme scheme;
  final Curve curve;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint axis = Paint()
      ..color = scheme.outlineVariant
      ..strokeWidth = 1.0;
    canvas.drawLine(Offset(0, size.height - 2), Offset(size.width, size.height - 2), axis);
    canvas.drawLine(const Offset(2, 0), Offset(2, size.height), axis);
    final Path path = Path();
    for (int i = 0; i <= 60; i++) {
      final double t = i / 60.0;
      final double v = curve.transform(t);
      final double x = 4 + t * (size.width - 8);
      final double y = size.height - 4 - v * (size.height - 8);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    final Paint stroke = Paint()
      ..color = scheme.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2;
    canvas.drawPath(path, stroke);
  }

  @override
  bool shouldRepaint(covariant _CurveMiniaturePainter oldDelegate) =>
      oldDelegate.curve != curve;
}

class _GuidanceRow extends StatelessWidget {
  const _GuidanceRow({
    required this.scheme,
    required this.title,
    required this.body,
  });
  final ColorScheme scheme;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: scheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            body,
            style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 6 — ERROR BUILDERS
// =============================================================================

class _ErrorBuilderTab extends StatelessWidget {
  const _ErrorBuilderTab({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _SectionTitle(scheme: scheme, label: 'imageErrorBuilder'),
        const SizedBox(height: 12),
        _Paragraph(
          text:
              'When the target image fails to load, FadeInImage invokes the '
              'imageErrorBuilder with the BuildContext, the Object error, and '
              'the optional StackTrace. Return any widget you like — usually a '
              'subtle state hinting that content is unavailable.',
        ),
        const SizedBox(height: 16),
        _ErrorMock(
          scheme: scheme,
          title: 'image failed to load',
          icon: Icons.broken_image_outlined,
          body: 'Recommendation: keep the same footprint as the successful image so the layout does not jump.',
        ),
        const SizedBox(height: 20),
        _CodeBlock(
          scheme: scheme,
          code: 'FadeInImage(\n'
              '  placeholder: ...,\n'
              '  image: ...,\n'
              '  imageErrorBuilder: (ctx, err, stack) => _brokenTile(),\n'
              ');',
        ),
        const SizedBox(height: 28),
        _SectionTitle(scheme: scheme, label: 'placeholderErrorBuilder'),
        const SizedBox(height: 12),
        _Paragraph(
          text:
              'This is far rarer but important when the placeholder itself is '
              'an asset that can go missing. If the placeholder fails and no '
              'builder is supplied, the widget silently shows an empty box '
              'before the target image resolves — which can look like a flash.',
        ),
        const SizedBox(height: 16),
        _ErrorMock(
          scheme: scheme,
          title: 'placeholder missing',
          icon: Icons.image_not_supported_outlined,
          body: 'Fall back to a solid colour that matches the dominant palette of the real image.',
        ),
        const SizedBox(height: 20),
        _CodeBlock(
          scheme: scheme,
          code: 'FadeInImage(\n'
              '  placeholder: AssetImage("missing/path.png"),\n'
              '  image: MemoryImage(bytes),\n'
              '  placeholderErrorBuilder: (ctx, err, stack) => ColoredBox(\n'
              '    color: Colors.grey.shade300,\n'
              '  ),\n'
              ');',
        ),
        const SizedBox(height: 28),
        _SectionTitle(scheme: scheme, label: 'Signature reminder'),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: scheme.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'typedef ImageErrorWidgetBuilder = Widget Function(\n'
                '  BuildContext context,\n'
                '  Object error,\n'
                '  StackTrace? stackTrace,\n'
                ');',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  color: scheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ErrorMock extends StatelessWidget {
  const _ErrorMock({
    required this.scheme,
    required this.title,
    required this.icon,
    required this.body,
  });
  final ColorScheme scheme;
  final String title;
  final IconData icon;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.errorContainer.withAlpha(90),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.error.withAlpha(80)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: scheme.surfaceContainer,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: scheme.outlineVariant),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Icon(icon, size: 40, color: scheme.error),
                Positioned(
                  bottom: 6,
                  child: Text(
                    'error',
                    style: TextStyle(
                      color: scheme.error,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: scheme.onErrorContainer,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: TextStyle(
                    color: scheme.onErrorContainer,
                    fontSize: 13,
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

// =============================================================================
// TAB 7 — FIT & ALIGNMENT MATRIX
// =============================================================================

class _FitAlignTab extends StatelessWidget {
  const _FitAlignTab({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _SectionTitle(scheme: scheme, label: 'Fit + alignment mini-matrix'),
        const SizedBox(height: 12),
        _Paragraph(
          text:
              'FadeInImage inherits BoxFit and alignment semantics from the '
              'underlying Image widget. Use the chips below to pick a fit and '
              'alignment; the cells show how the child area relates to the '
              'frame for each combination.',
        ),
        const SizedBox(height: 16),
        _SectionTitle(scheme: scheme, label: 'Fits'),
        const SizedBox(height: 8),
        ValueListenableBuilder<int>(
          valueListenable: _fitChoice,
          builder: (BuildContext context, int i, Widget? _) {
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_allFits.length, (int idx) {
                return _ChoicePill(
                  scheme: scheme,
                  label: _fitLabels[idx],
                  selected: idx == i,
                  onTap: () => _fitChoice.value = idx,
                );
              }),
            );
          },
        ),
        const SizedBox(height: 20),
        _SectionTitle(scheme: scheme, label: 'Alignments'),
        const SizedBox(height: 8),
        ValueListenableBuilder<int>(
          valueListenable: _alignChoice,
          builder: (BuildContext context, int a, Widget? _) {
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_alignmentCycle.length, (int idx) {
                return _ChoicePill(
                  scheme: scheme,
                  label: _alignmentNames[idx],
                  selected: idx == a,
                  onTap: () => _alignChoice.value = idx,
                );
              }),
            );
          },
        ),
        const SizedBox(height: 24),
        _SectionTitle(scheme: scheme, label: 'Full 7×3 matrix (preview of combinations)'),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _allFits.length * 3,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (BuildContext context, int index) {
            final int fitIndex = index ~/ 3;
            final int alignSubIndex = index % 3; // 0=topLeft, 1=center, 2=bottomRight
            final Alignment align = <Alignment>[
              Alignment.topLeft,
              Alignment.center,
              Alignment.bottomRight,
            ][alignSubIndex];
            final String alignLabel = <String>['TL', 'C', 'BR'][alignSubIndex];
            return _FitAlignCell(
              scheme: scheme,
              fit: _allFits[fitIndex],
              fitLabel: _fitLabels[fitIndex],
              alignment: align,
              alignmentLabel: alignLabel,
            );
          },
        ),
        const SizedBox(height: 24),
        _SectionTitle(scheme: scheme, label: 'Active selection, full size'),
        const SizedBox(height: 12),
        ValueListenableBuilder<int>(
          valueListenable: _fitChoice,
          builder: (BuildContext context, int fIndex, Widget? _) {
            return ValueListenableBuilder<int>(
              valueListenable: _alignChoice,
              builder: (BuildContext context, int aIndex, Widget? _) {
                return Container(
                  height: 220,
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: scheme.outlineVariant),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: CustomPaint(
                    painter: _FitAlignPainter(
                      scheme: scheme,
                      fit: _allFits[fIndex],
                      alignment: _alignmentCycle[aIndex],
                    ),
                    size: Size.infinite,
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class _FitAlignCell extends StatelessWidget {
  const _FitAlignCell({
    required this.scheme,
    required this.fit,
    required this.fitLabel,
    required this.alignment,
    required this.alignmentLabel,
  });
  final ColorScheme scheme;
  final BoxFit fit;
  final String fitLabel;
  final Alignment alignment;
  final String alignmentLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: scheme.outlineVariant),
      ),
      padding: const EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: CustomPaint(
              painter: _FitAlignPainter(
                scheme: scheme,
                fit: fit,
                alignment: alignment,
              ),
              size: Size.infinite,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$fitLabel / $alignmentLabel',
            style: TextStyle(
              fontSize: 10,
              color: scheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _FitAlignPainter extends CustomPainter {
  _FitAlignPainter({
    required this.scheme,
    required this.fit,
    required this.alignment,
  });
  final ColorScheme scheme;
  final BoxFit fit;
  final Alignment alignment;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint frame = Paint()..color = scheme.primary.withAlpha(30);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), frame);
    final Paint border = Paint()
      ..color = scheme.primary.withAlpha(140)
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), border);

    // Simulated child native size of 3:2 aspect.
    const Size child = Size(120, 80);
    final Size drawn = _applyFit(fit, child, size);
    final Offset childOffset = _applyAlignment(alignment, drawn, size);
    final Rect r = Rect.fromLTWH(childOffset.dx, childOffset.dy, drawn.width, drawn.height);
    final Paint childFill = Paint()..color = scheme.secondary.withAlpha(180);
    canvas.drawRect(r, childFill);
    final Paint childStroke = Paint()
      ..color = scheme.onSecondary.withAlpha(200)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    canvas.drawRect(r, childStroke);
  }

  Size _applyFit(BoxFit fit, Size child, Size parent) {
    final double childAspect = child.width / child.height;
    final double parentAspect = parent.width / parent.height;
    switch (fit) {
      case BoxFit.fill:
        return parent;
      case BoxFit.contain:
        if (childAspect > parentAspect) {
          return Size(parent.width, parent.width / childAspect);
        }
        return Size(parent.height * childAspect, parent.height);
      case BoxFit.cover:
        if (childAspect > parentAspect) {
          return Size(parent.height * childAspect, parent.height);
        }
        return Size(parent.width, parent.width / childAspect);
      case BoxFit.fitWidth:
        return Size(parent.width, parent.width / childAspect);
      case BoxFit.fitHeight:
        return Size(parent.height * childAspect, parent.height);
      case BoxFit.none:
        return child;
      case BoxFit.scaleDown:
        if (child.width <= parent.width && child.height <= parent.height) {
          return child;
        }
        if (childAspect > parentAspect) {
          return Size(parent.width, parent.width / childAspect);
        }
        return Size(parent.height * childAspect, parent.height);
    }
  }

  Offset _applyAlignment(Alignment a, Size child, Size parent) {
    final double dx = (parent.width - child.width) * ((a.x + 1) / 2);
    final double dy = (parent.height - child.height) * ((a.y + 1) / 2);
    return Offset(dx, dy);
  }

  @override
  bool shouldRepaint(covariant _FitAlignPainter oldDelegate) =>
      oldDelegate.fit != fit || oldDelegate.alignment != alignment;
}

// =============================================================================
// TAB 8 — USE CASE GALLERY
// =============================================================================

class _UseCaseTab extends StatelessWidget {
  const _UseCaseTab({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final List<_UseCaseEntry> cases = <_UseCaseEntry>[
      _UseCaseEntry(
        icon: Icons.person_pin,
        title: 'Avatar placeholder',
        hint: 'CircleAvatar tones while the profile pic loads.',
        progress: 0.45,
      ),
      _UseCaseEntry(
        icon: Icons.album,
        title: 'Album art',
        hint: 'Blurred low-res from the queue service, then CD-quality art.',
        progress: 0.65,
      ),
      _UseCaseEntry(
        icon: Icons.shopping_bag,
        title: 'Product grid',
        hint: 'Muted colour card then crisp product photo.',
        progress: 0.80,
      ),
      _UseCaseEntry(
        icon: Icons.panorama,
        title: 'Hero banner',
        hint: 'Full-width banner with a calm gradient placeholder.',
        progress: 0.30,
      ),
      _UseCaseEntry(
        icon: Icons.preview,
        title: 'Feed hero preview',
        hint: 'Tiny thumbnail already available from the API becomes the placeholder.',
        progress: 0.55,
      ),
      _UseCaseEntry(
        icon: Icons.auto_awesome,
        title: 'Low-res → high-res',
        hint: 'Classic progressive JPEG workflow.',
        progress: 0.75,
      ),
    ];
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _SectionTitle(scheme: scheme, label: 'When FadeInImage shines'),
        const SizedBox(height: 12),
        _Paragraph(
          text:
              'Any surface where "empty → content" would otherwise jolt the '
              'user is a good fit. Below are six common templates. Each card '
              'shows a frozen instant of the fade to illustrate the pattern.',
        ),
        const SizedBox(height: 20),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 0.78,
          children: cases.map((_UseCaseEntry e) {
            return _UseCaseCard(scheme: scheme, entry: e);
          }).toList(),
        ),
        const SizedBox(height: 24),
        _SectionTitle(scheme: scheme, label: 'Progressive loading recipe'),
        const SizedBox(height: 12),
        _CodeBlock(
          scheme: scheme,
          code: 'FadeInImage(\n'
              '  placeholder: MemoryImage(thumbnailBytes),\n'
              '  image: NetworkImage(highResUrl),\n'
              '  fadeInDuration: Duration(milliseconds: 500),\n'
              '  fit: BoxFit.cover,\n'
              ');',
        ),
      ],
    );
  }
}

class _UseCaseEntry {
  const _UseCaseEntry({
    required this.icon,
    required this.title,
    required this.hint,
    required this.progress,
  });
  final IconData icon;
  final String title;
  final String hint;
  final double progress;
}

class _UseCaseCard extends StatelessWidget {
  const _UseCaseCard({required this.scheme, required this.entry});
  final ColorScheme scheme;
  final _UseCaseEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outlineVariant),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: _SimulatedFadeInImage(
                t: entry.progress,
                placeholder: _PlaceholderArt(scheme: scheme),
                image: _HighFidelityArt(scheme: scheme),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Icon(entry.icon, size: 18, color: scheme.primary),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  entry.title,
                  style: TextStyle(
                    color: scheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            entry.hint,
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// PITFALLS — shared into Cheat Sheet tab together with API reference
// =============================================================================

class _Pitfalls extends StatelessWidget {
  const _Pitfalls({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final List<List<String>> pitfalls = <List<String>>[
      <String>[
        'Mismatched placeholder size',
        'If the placeholder has a different intrinsic size than the image, the widget will reflow during the fade causing a visible jump. Lock width/height on FadeInImage itself.',
      ],
      <String>[
        'fadeOutDuration too short',
        'A very fast fadeOut can look like a flash because the user perceives a sudden switch. Keep fadeOutDuration ≥ 200 ms for most surfaces.',
      ],
      <String>[
        'Asset missing at runtime',
        'A typo in an asset path causes placeholderErrorBuilder (or a silent empty) instead of a placeholder. Always wire both errorBuilders in production.',
      ],
    ];
    return Column(
      children: pitfalls.map((List<String> p) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: scheme.surfaceContainer,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.warning_amber_rounded,
                      size: 18, color: scheme.error),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      p[0],
                      style: TextStyle(
                        color: scheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                p[1],
                style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 13),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// =============================================================================
// TAB 9 — CHEAT SHEET
// =============================================================================

class _CheatSheetTab extends StatelessWidget {
  const _CheatSheetTab({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _SectionTitle(scheme: scheme, label: 'Constructors'),
        const SizedBox(height: 12),
        _ApiTable(
          scheme: scheme,
          headers: const <String>['Name', 'Purpose'],
          rows: const <List<String>>[
            <String>['FadeInImage', 'General-purpose, any two ImageProviders.'],
            <String>['FadeInImage.memoryNetwork', 'Bytes placeholder + URL image (network — unavailable in sandbox).'],
            <String>['FadeInImage.assetNetwork', 'Asset placeholder + URL image (network — unavailable in sandbox).'],
          ],
        ),
        const SizedBox(height: 24),
        _SectionTitle(scheme: scheme, label: 'Properties'),
        const SizedBox(height: 12),
        _ApiTable(
          scheme: scheme,
          headers: const <String>['Name', 'Type', 'Default', 'Purpose'],
          rows: const <List<String>>[
            <String>['placeholder', 'ImageProvider', 'required', 'Shown first, always visible at t=0.'],
            <String>['image', 'ImageProvider', 'required', 'Target image; fades in once decoded.'],
            <String>['placeholderErrorBuilder', 'ImageErrorWidgetBuilder?', 'null', 'Fallback widget when placeholder throws.'],
            <String>['imageErrorBuilder', 'ImageErrorWidgetBuilder?', 'null', 'Fallback widget when image throws.'],
            <String>['fadeInDuration', 'Duration', '700 ms', 'Time image takes to reach full opacity.'],
            <String>['fadeOutDuration', 'Duration', '300 ms', 'Time placeholder takes to leave.'],
            <String>['fadeInCurve', 'Curve', 'Curves.easeIn', 'Curve applied to image opacity.'],
            <String>['fadeOutCurve', 'Curve', 'Curves.easeIn', 'Curve applied to placeholder opacity.'],
            <String>['width', 'double?', 'null', 'Locks the painted width.'],
            <String>['height', 'double?', 'null', 'Locks the painted height.'],
            <String>['fit', 'BoxFit?', 'null', 'How image fills the box.'],
            <String>['alignment', 'AlignmentGeometry', 'Alignment.center', 'Alignment inside the box.'],
            <String>['repeat', 'ImageRepeat', 'ImageRepeat.noRepeat', 'Tiling mode.'],
            <String>['matchTextDirection', 'bool', 'false', 'Mirror image in RTL locales.'],
            <String>['excludeFromSemantics', 'bool', 'false', 'Hide image semantics for a11y.'],
            <String>['filterQuality', 'FilterQuality', 'FilterQuality.medium', 'Sampling quality.'],
          ],
        ),
        const SizedBox(height: 24),
        _SectionTitle(scheme: scheme, label: 'Pitfalls'),
        const SizedBox(height: 12),
        _Pitfalls(scheme: scheme),
        const SizedBox(height: 24),
        _SectionTitle(scheme: scheme, label: 'Compared to related widgets'),
        const SizedBox(height: 12),
        _ApiTable(
          scheme: scheme,
          headers: const <String>['Widget', 'When to prefer', 'Trade-offs'],
          rows: const <List<String>>[
            <String>[
              'Image.memory',
              'You already have bytes and do not need a placeholder.',
              'No fade-in; appears instantly.',
            ],
            <String>[
              'Image.asset',
              'Bundled asset with a known path.',
              'No placeholder support; pair with FadeInImage if you need progressive reveal.',
            ],
            <String>[
              'CachedNetworkImage',
              'Need on-disk caching and retry semantics.',
              'Third-party; richer but heavier API.',
            ],
            <String>[
              'FadeInImage',
              'You have a lightweight placeholder and a heavier image.',
              'Minimal API; no caching layer of its own.',
            ],
          ],
        ),
        const SizedBox(height: 28),
        _FinalBanner(scheme: scheme),
      ],
    );
  }
}

class _ApiTable extends StatelessWidget {
  const _ApiTable({
    required this.scheme,
    required this.headers,
    required this.rows,
  });
  final ColorScheme scheme;
  final List<String> headers;
  final List<List<String>> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outlineVariant),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Row(
            children: headers.map((String h) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    h,
                    style: TextStyle(
                      color: scheme.onSurface,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          Divider(color: scheme.outlineVariant, height: 1),
          ...rows.map((List<String> row) {
            return Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: scheme.outlineVariant),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: row.map((String cell) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        cell,
                        style: TextStyle(
                          color: scheme.onSurfaceVariant,
                          fontSize: 12,
                          fontFamily: row == rows.first ? null : 'monospace',
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _FinalBanner extends StatelessWidget {
  const _FinalBanner({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: <Color>[
            scheme.tertiary,
            scheme.primary,
          ],
        ),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.bookmark_added, color: scheme.onPrimary, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Remember: FadeInImage is a polish widget. Match durations to the '
              'surrounding motion language and always size both children to the '
              'same footprint for a perfectly still cross-fade.',
              style: TextStyle(
                color: scheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Shared small building blocks
// =============================================================================

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.scheme, required this.label});
  final ColorScheme scheme;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 6,
          height: 22,
          decoration: BoxDecoration(
            color: scheme.primary,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            color: scheme.onSurface,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _Paragraph extends StatelessWidget {
  const _Paragraph({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, height: 1.45),
    );
  }
}

class _CalloutCard extends StatelessWidget {
  const _CalloutCard({
    required this.scheme,
    required this.icon,
    required this.title,
    required this.body,
  });
  final ColorScheme scheme;
  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.tertiaryContainer.withAlpha(140),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.tertiary.withAlpha(120)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: scheme.onTertiaryContainer),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: scheme.onTertiaryContainer,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: TextStyle(
                    color: scheme.onTertiaryContainer,
                    fontSize: 13,
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

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.scheme, required this.code});
  final ColorScheme scheme;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      width: double.infinity,
      child: Text(
        code,
        style: TextStyle(
          fontFamily: 'monospace',
          color: scheme.onSurface,
          fontSize: 13,
          height: 1.45,
        ),
      ),
    );
  }
}
