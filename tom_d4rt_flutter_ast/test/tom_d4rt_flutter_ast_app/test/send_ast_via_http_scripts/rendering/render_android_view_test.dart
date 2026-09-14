// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// =====================================================================
// RenderAndroidView — Deep Demo (Harness-Safe)
// =====================================================================
//
// RenderAndroidView is the RenderObject that backs the AndroidView
// widget. AndroidView lets you embed a real native Android View
// (think MapView, WebView, AdView, a custom SurfaceView…) into the
// middle of your Flutter widget tree. The Flutter engine carves a
// transparent hole in its own surface and asks the Android compositor
// to draw the native view underneath, while still letting Flutter
// dispatch touch events, manage focus, and clip the result.
//
// This file is a long, hand-authored, instructive demo. It uses ONLY
// `package:flutter/material.dart` so it can be parsed by the harness
// AST runner without tripping unnecessary_import lints (material.dart
// re-exports widgets, painting, rendering primitives, gestures, and
// services). It does NOT instantiate RenderAndroidView directly: the
// AndroidViewController required by its constructor is owned by the
// Flutter engine and cannot be synthesised in script context.
//
// Constructor (Flutter 3.41.6):
//   RenderAndroidView({
//     required AndroidViewController viewController,
//     required PlatformViewHitTestBehavior hitTestBehavior,
//     required Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers,
//     Clip clipBehavior = Clip.hardEdge,
//   })
//
// =====================================================================

// ---------------------------------------------------------------------
// CustomPainter #1 — embedding diagram
// ---------------------------------------------------------------------
class _EmbeddingDiagramPainter extends CustomPainter {
  _EmbeddingDiagramPainter(this.t) : super(repaint: t);
  final Animation<double> t;

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFFF3F4FB);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(14)),
      bg,
    );

    final flutter = Paint()..color = const Color(0xFF5C6BC0);
    final flutterRect = Rect.fromLTWH(12, 12, size.width - 24, size.height - 24);
    canvas.drawRRect(
      RRect.fromRectAndRadius(flutterRect, const Radius.circular(10)),
      flutter,
    );

    final holePaint = Paint()..color = const Color(0xFFFFFFFF);
    final holeRect = Rect.fromLTWH(
      flutterRect.left + 36,
      flutterRect.top + 36,
      flutterRect.width - 72,
      flutterRect.height - 72,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(holeRect, const Radius.circular(8)),
      holePaint,
    );

    // Native android view content (a fake map grid).
    final grid = Paint()
      ..color = const Color(0xFF26A69A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    for (double x = holeRect.left; x < holeRect.right; x += 18) {
      canvas.drawLine(
        Offset(x, holeRect.top),
        Offset(x, holeRect.bottom),
        grid,
      );
    }
    for (double y = holeRect.top; y < holeRect.bottom; y += 18) {
      canvas.drawLine(
        Offset(holeRect.left, y),
        Offset(holeRect.right, y),
        grid,
      );
    }

    final labelStyle = const TextStyle(
      color: Color(0xFF1A237E),
      fontSize: 12,
      fontWeight: FontWeight.bold,
    );
    _label(canvas, 'Flutter surface', Offset(flutterRect.left + 8, flutterRect.top + 6), labelStyle.copyWith(color: Colors.white));
    _label(canvas, 'Native AndroidView (hole)', Offset(holeRect.left + 6, holeRect.top + 4), labelStyle);

    // Animated touch ripple to suggest hit-test.
    final ripple = Paint()
      ..color = const Color(0xFFFFC107).withOpacity(0.6 - 0.6 * t.value)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final rippleR = 8 + 60 * t.value;
    canvas.drawCircle(holeRect.center, rippleR, ripple);
  }

  void _label(Canvas canvas, String text, Offset at, TextStyle style) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, at);
  }

  @override
  bool shouldRepaint(covariant _EmbeddingDiagramPainter old) => old.t != t;
}

// ---------------------------------------------------------------------
// CustomPainter #2 — hit-test behavior visualization
// ---------------------------------------------------------------------
class _HitTestPainter extends CustomPainter {
  _HitTestPainter(this.behavior, this.tap);
  final String behavior;
  final Offset? tap;

  @override
  void paint(Canvas canvas, Size size) {
    final outer = Paint()..color = const Color(0xFFECEFF1);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10)),
      outer,
    );
    final viewRect = Rect.fromLTWH(20, 26, size.width - 40, size.height - 52);
    final innerColor = switch (behavior) {
      'opaque' => const Color(0xFF8BC34A),
      'translucent' => const Color(0xFFFFB74D),
      'transparent' => const Color(0xFF90A4AE),
      _ => const Color(0xFF90A4AE),
    };
    final inner = Paint()..color = innerColor;
    canvas.drawRRect(
      RRect.fromRectAndRadius(viewRect, const Radius.circular(8)),
      inner,
    );

    if (behavior == 'translucent') {
      final hatch = Paint()
        ..color = Colors.black.withOpacity(0.18)
        ..strokeWidth = 1;
      for (double x = viewRect.left; x < viewRect.right; x += 6) {
        canvas.drawLine(
          Offset(x, viewRect.top),
          Offset(x + 6, viewRect.bottom),
          hatch,
        );
      }
    }

    if (tap != null) {
      final dot = Paint()..color = const Color(0xFFD81B60);
      canvas.drawCircle(tap!, 6, dot);
    }
  }

  @override
  bool shouldRepaint(covariant _HitTestPainter old) =>
      old.behavior != behavior || old.tap != tap;
}

// ---------------------------------------------------------------------
// CustomPainter #3 — clipBehavior overflow demonstration
// ---------------------------------------------------------------------
class _ClipPainter extends CustomPainter {
  _ClipPainter(this.clip);
  final Clip clip;

  @override
  void paint(Canvas canvas, Size size) {
    final framePaint = Paint()
      ..color = const Color(0xFF6A1B9A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final frame = RRect.fromRectAndRadius(
      Rect.fromLTWH(10, 10, size.width - 20, size.height - 20),
      const Radius.circular(18),
    );

    canvas.save();
    if (clip != Clip.none) {
      canvas.clipRRect(frame);
    }

    final hatch = Paint()
      ..color = const Color(0xFFFF7043).withOpacity(0.55)
      ..strokeWidth = 2;
    for (double i = -size.width; i < size.width * 2; i += 10) {
      canvas.drawLine(
        Offset(i, -10),
        Offset(i + size.height + 20, size.height + 10),
        hatch,
      );
    }

    canvas.restore();
    canvas.drawRRect(frame, framePaint);
  }

  @override
  bool shouldRepaint(covariant _ClipPainter old) => old.clip != clip;
}

// ---------------------------------------------------------------------
// CustomPainter #4 — lifecycle schematic
// ---------------------------------------------------------------------
class _LifecyclePainter extends CustomPainter {
  _LifecyclePainter(this.stage);
  final int stage; // 0 created, 1 attached, 2 resized, 3 disposed

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFFFFF3E0);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(12)),
      bg,
    );
    final stages = ['create', 'attach', 'resize', 'dispose'];
    final w = size.width / stages.length;
    for (var i = 0; i < stages.length; i++) {
      final active = i == stage;
      final p = Paint()
        ..color = active ? const Color(0xFFFB8C00) : const Color(0xFFFFCC80);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(i * w + 8, 16, w - 16, size.height - 32),
          const Radius.circular(8),
        ),
        p,
      );
      final tp = TextPainter(
        text: TextSpan(
          text: stages[i],
          style: TextStyle(
            color: active ? Colors.white : Colors.brown.shade900,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(
        canvas,
        Offset(
          i * w + (w - tp.width) / 2,
          (size.height - tp.height) / 2,
        ),
      );
    }

    // Connector arrows.
    final arrow = Paint()
      ..color = const Color(0xFF6D4C41)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    for (var i = 0; i < stages.length - 1; i++) {
      final y = size.height / 2;
      final x1 = (i + 1) * w - 8;
      final x2 = (i + 1) * w + 8;
      canvas.drawLine(Offset(x1, y), Offset(x2, y), arrow);
    }
  }

  @override
  bool shouldRepaint(covariant _LifecyclePainter old) => old.stage != stage;
}

// =====================================================================
// build entry — required by the harness
// =====================================================================
dynamic build(BuildContext context) {
  print('=== RenderAndroidView Deep Demo (Harness-Safe) ===');
  print('PlatformViewHitTestBehavior values (hardcoded, not imported):');
  const hitBehaviors = ['opaque', 'translucent', 'transparent'];
  for (var i = 0; i < hitBehaviors.length; i++) {
    print('  $i: ${hitBehaviors[i]}');
  }
  print('Clip values relevant to RenderAndroidView.clipBehavior:');
  for (final c in Clip.values) {
    print('  ${c.index}: ${c.name}');
  }

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'RenderAndroidView Deep Demo',
    theme: ThemeData(
      colorSchemeSeed: const Color(0xFF3F51B5),
      useMaterial3: true,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('RenderAndroidView — Deep Demo'),
        backgroundColor: const Color(0xFF3F51B5),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _heroIntroSection(context),
              const SizedBox(height: 18),
              _constructorMapSection(context),
              const SizedBox(height: 18),
              _platformGuardSection(context),
              const SizedBox(height: 18),
              _hitTestSection(context),
              const SizedBox(height: 18),
              _clipBehaviorSection(context),
              const SizedBox(height: 18),
              _gestureRecognizerSection(context),
              const SizedBox(height: 18),
              _hybridVsTextureSection(context),
              const SizedBox(height: 18),
              _compositingTradeoffsSection(context),
              const SizedBox(height: 18),
              _lifecycleSection(context),
              const SizedBox(height: 18),
              _pitfallsSection(context),
              const SizedBox(height: 18),
              _realAppsSection(context),
              const SizedBox(height: 18),
              _decisionSection(context),
              const SizedBox(height: 18),
              _referenceTableSection(context),
              const SizedBox(height: 18),
              _footerSection(context),
            ],
          ),
        ),
      ),
    ),
  );
}

// =====================================================================
// Section 1 — Hero intro
// =====================================================================
Widget _heroIntroSection(BuildContext context) {
  return StatefulBuilder(
    builder: (context, setState) {
      return Card(
        elevation: 3,
        color: const Color(0xFFE8EAF6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: Color(0xFF3F51B5), width: 1.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '1 · What RenderAndroidView is for',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'RenderAndroidView is the leaf RenderObject behind the AndroidView '
                'widget. Its job is to take a live native Android View — owned by an '
                'AndroidViewController and managed by the Flutter engine — and embed '
                'it as if it were a Flutter widget. The Flutter compositor cooperates '
                'with the Android compositor: a transparent rectangle is reserved on '
                'the Flutter surface, the native view is rendered underneath (or '
                'composited via a texture), and Flutter dispatches input events back '
                'to the native view through the platform views channel.',
                style: TextStyle(fontSize: 14, height: 1.45),
              ),
              const SizedBox(height: 10),
              const Text(
                'You almost never construct RenderAndroidView yourself. You use the '
                'AndroidView widget from package:flutter/widgets.dart (re-exported by '
                'material.dart), and Flutter wires up the controller, the surface, '
                'and the render object. Knowing what the render object actually does '
                'helps you reason about hit testing, clipping, jank, and lifecycle.',
                style: TextStyle(fontSize: 14, height: 1.45),
              ),
              const SizedBox(height: 14),
              _AnimatedDiagram(),
              const SizedBox(height: 8),
              const Text(
                'Above: Flutter surface (indigo) cuts a hole; the native AndroidView '
                '(grid) is composited beneath it. The yellow ring represents a touch '
                'event being routed through the platform views hit-test chain.',
                style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _AnimatedDiagram extends StatefulWidget {
  @override
  State<_AnimatedDiagram> createState() => _AnimatedDiagramState();
}

class _AnimatedDiagramState extends State<_AnimatedDiagram>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: CustomPaint(
        painter: _EmbeddingDiagramPainter(_c),
      ),
    );
  }
}

// =====================================================================
// Section 2 — Constructor map
// =====================================================================
Widget _constructorMapSection(BuildContext context) {
  return StatefulBuilder(
    builder: (context, setState) {
      return Card(
        elevation: 3,
        color: const Color(0xFFE0F2F1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: Color(0xFF00897B), width: 1.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '2 · Constructor parameters & setters',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004D40),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Every parameter on RenderAndroidView has an equivalent setter that '
                'updates the embedded view in place — no new RenderObject is built '
                'when these change. This is what lets the AndroidView widget react '
                'to setState without tearing down the underlying Android view.',
                style: TextStyle(fontSize: 14, height: 1.45),
              ),
              const SizedBox(height: 12),
              _paramRow(
                'viewController',
                'AndroidViewController',
                'Owns the lifecycle of the native Android View. Required. Never '
                'null after construction. Setting it replaces the embedded view.',
              ),
              _paramRow(
                'hitTestBehavior',
                'PlatformViewHitTestBehavior',
                'Controls whether touches inside the view are absorbed (opaque), '
                'translucent (both Flutter and the native view see them), or '
                'transparent (Flutter ignores the area, native view still sees it).',
              ),
              _paramRow(
                'gestureRecognizers',
                'Set<Factory<OneSequenceGestureRecognizer>>',
                'Recognizers Flutter is allowed to win in the gesture arena before '
                'forwarding to the native view. Use Factory<>() to avoid leaking '
                'state between widget rebuilds.',
              ),
              _paramRow(
                'clipBehavior',
                'Clip (default Clip.hardEdge)',
                'How RenderAndroidView clips the embedded native view. hardEdge is '
                'almost always correct; antiAlias only matters when the surrounding '
                'shape has rounded corners and you actually see the seam.',
              ),
              const SizedBox(height: 12),
              const Text(
                'Typical AndroidView widget invocation (pseudocode):',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const SelectableText(
                'AndroidView(\n'
                '  viewType: \'plugins.example.com/native_map\',\n'
                '  layoutDirection: TextDirection.ltr,\n'
                '  creationParams: <String, dynamic>{\'lat\': 47.6, \'lng\': -122.3},\n'
                '  creationParamsCodec: const StandardMessageCodec(),\n'
                '  onPlatformViewCreated: (id) => print(\'created \$id\'),\n'
                '  hitTestBehavior: PlatformViewHitTestBehavior.opaque,\n'
                '  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{\n'
                '    Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer()),\n'
                '  },\n'
                '  clipBehavior: Clip.hardEdge,\n'
                ');',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.5,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _paramRow(String name, String type, String role) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF00695C),
              fontFamily: 'monospace',
            ),
          ),
        ),
        SizedBox(
          width: 220,
          child: Text(
            type,
            style: const TextStyle(
              color: Color(0xFF004D40),
              fontStyle: FontStyle.italic,
              fontFamily: 'monospace',
              fontSize: 12.5,
            ),
          ),
        ),
        Expanded(
          child: Text(
            role,
            style: const TextStyle(fontSize: 13, height: 1.35),
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// Section 3 — Platform guard live
// =====================================================================
Widget _platformGuardSection(BuildContext context) {
  return StatefulBuilder(
    builder: (context, setState) {
      final platform = Theme.of(context).platform;
      final isAndroid = platform == TargetPlatform.android;
      return Card(
        elevation: 3,
        color: const Color(0xFFFFF8E1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: Color(0xFFFFB300), width: 1.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '3 · Platform guard — runtime behavior',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF6F00),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Detected platform: ${platform.name}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              if (isAndroid)
                const Text(
                  'On Android — would render the native view here, but this demo '
                  'does not ship a plugin viewType, so we show a placeholder with '
                  'the controller schematic. In a real app you would wire an '
                  'AndroidView with a registered plugin viewType such as '
                  '"plugins.flutter.io/google_maps" or "webview_flutter".',
                  style: TextStyle(fontSize: 14, height: 1.45),
                )
              else
                Text(
                  'Native AndroidView render is unavailable on ${platform.name}. '
                  'Showing a faithful schematic instead. Platform views render '
                  'only on Android — you are on ${platform.name}.',
                  style: const TextStyle(fontSize: 14, height: 1.45),
                ),
              const SizedBox(height: 14),
              Container(
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFFFB300), width: 1.4),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFE082), Color(0xFFFFCC80)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _SchematicPainter(),
                      ),
                    ),
                    const Positioned(
                      left: 14,
                      top: 12,
                      child: Text(
                        'Schematic: AndroidViewController owns the surface',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6D4C41),
                        ),
                      ),
                    ),
                    const Positioned(
                      bottom: 10,
                      right: 12,
                      child: Text(
                        '(no real native view rendered in this script context)',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Color(0xFF6D4C41),
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Note that we use Theme.of(context).platform — it returns a '
                'TargetPlatform enum value re-exported through material.dart and '
                'works in both web and tests, unlike dart:io Platform.',
                style: TextStyle(fontSize: 13, height: 1.4),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _SchematicPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final boxPaint = Paint()
      ..color = Colors.brown.shade700
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final fill = Paint()..color = const Color(0xFFFFF3E0);

    final controller = Rect.fromLTWH(20, 50, 160, 80);
    final surface = Rect.fromLTWH(220, 50, 160, 80);
    final flutter = Rect.fromLTWH(120, 160, 160, 50);

    for (final r in [controller, surface, flutter]) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(8)),
        fill,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(8)),
        boxPaint,
      );
    }

    void label(Rect r, String text) {
      final tp = TextPainter(
        text: TextSpan(
          text: text,
          style: const TextStyle(
            color: Color(0xFF4E342E),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )
        ..layout(maxWidth: r.width - 8);
      tp.paint(
        canvas,
        Offset(r.left + (r.width - tp.width) / 2,
            r.top + (r.height - tp.height) / 2),
      );
    }

    label(controller, 'AndroidViewController');
    label(surface, 'Surface / SurfaceTexture');
    label(flutter, 'Flutter widget tree');

    final arrow = Paint()
      ..color = Colors.brown.shade700
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(controller.centerRight, surface.centerLeft, arrow);
    canvas.drawLine(surface.bottomCenter, flutter.topCenter, arrow);
    canvas.drawLine(controller.bottomCenter, flutter.topCenter, arrow);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// =====================================================================
// Section 4 — Hit-test behavior visualization
// =====================================================================
Widget _hitTestSection(BuildContext context) {
  return StatefulBuilder(
    builder: (context, setState) {
      Offset? lastTap;
      String lastBehavior = 'none';
      return StatefulBuilder(
        builder: (context, setLocal) {
          void register(String b, Offset o) {
            setLocal(() {
              lastTap = o;
              lastBehavior = b;
            });
          }

          return Card(
            elevation: 3,
            color: const Color(0xFFFFEBEE),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: const BorderSide(color: Color(0xFFE53935), width: 1.2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '4 · PlatformViewHitTestBehavior in pictures',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB71C1C),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Hit-test behavior decides what happens when a pointer lands '
                    'over the embedded native view. Tap each tile to highlight '
                    'where the touch would go: Flutter only, native only, or both.',
                    style: TextStyle(fontSize: 14, height: 1.45),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _hitTile(
                          'opaque',
                          'Flutter receives no events. Native view consumes '
                          'everything inside its rect. Use for full-screen '
                          'native canvases (camera, immersive map).',
                          (o) => register('opaque', o),
                          lastTap,
                          lastBehavior,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _hitTile(
                          'translucent',
                          'Both Flutter AND the native view see the event. '
                          'Useful when a Flutter overlay (e.g. floating toolbar) '
                          'must coexist with native scrolling.',
                          (o) => register('translucent', o),
                          lastTap,
                          lastBehavior,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _hitTile(
                          'transparent',
                          'Flutter ignores the area entirely. The native view '
                          'still receives the event. Use when Flutter must '
                          'never absorb a tap meant for the native side.',
                          (o) => register('transparent', o),
                          lastTap,
                          lastBehavior,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Last tap: ${lastTap == null ? 'none yet' : 'on $lastBehavior at (${lastTap!.dx.toStringAsFixed(1)}, ${lastTap!.dy.toStringAsFixed(1)})'}',
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Widget _hitTile(
  String label,
  String desc,
  void Function(Offset) onTap,
  Offset? tap,
  String activeBehavior,
) {
  return GestureDetector(
    onTapDown: (d) => onTap(d.localPosition),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 110,
          child: CustomPaint(
            painter: _HitTestPainter(
              label,
              activeBehavior == label ? tap : null,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFB71C1C),
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 2),
        Text(
          desc,
          style: const TextStyle(fontSize: 12, height: 1.3),
        ),
      ],
    ),
  );
}

// =====================================================================
// Section 5 — clipBehavior gallery
// =====================================================================
Widget _clipBehaviorSection(BuildContext context) {
  final clips = Clip.values;
  return StatefulBuilder(
    builder: (context, setState) {
      return Card(
        elevation: 3,
        color: const Color(0xFFFFF3E0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: Color(0xFFEF6C00), width: 1.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '5 · clipBehavior gallery',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE65100),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Clip controls how the native view is masked against its declared '
                'bounds. The orange hatch represents the native view trying to '
                'paint outside the rounded purple frame; the clip mode determines '
                'how Flutter handles the overflow before composition.',
                style: TextStyle(fontSize: 14, height: 1.45),
              ),
              const SizedBox(height: 14),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.4,
                children: clips.map((c) => _clipPanel(c)).toList(),
              ),
              const SizedBox(height: 8),
              const Text(
                'Performance ranking (cheapest → most expensive): Clip.none < '
                'Clip.hardEdge < Clip.antiAlias < Clip.antiAliasWithSaveLayer. '
                'For RenderAndroidView, hardEdge is the default and almost always '
                'the right answer; the other modes only matter when you wrap the '
                'native view in a rounded shape and visibly see jagged corners.',
                style: TextStyle(fontSize: 13, height: 1.4),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _clipPanel(Clip c) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFFEF6C00)),
    ),
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Clip.${c.name}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFE65100),
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 6),
        Expanded(
          child: CustomPaint(painter: _ClipPainter(c)),
        ),
        const SizedBox(height: 4),
        Text(
          _clipDescription(c),
          style: const TextStyle(fontSize: 11, height: 1.3),
        ),
      ],
    ),
  );
}

String _clipDescription(Clip c) {
  switch (c) {
    case Clip.none:
      return 'No clipping at all. Cheapest. Native view can paint outside.';
    case Clip.hardEdge:
      return 'Clip with a fast jagged edge. Default for RenderAndroidView.';
    case Clip.antiAlias:
      return 'Smooth clip edge. Slightly more expensive; only visible against '
          'rounded shapes or rotations.';
    case Clip.antiAliasWithSaveLayer:
      return 'Clip + saveLayer. Most expensive. Avoid unless you compose with '
          'transparency and need the smoothest edge.';
  }
}

// =====================================================================
// Section 6 — Gesture recognizer recipe
// =====================================================================
Widget _gestureRecognizerSection(BuildContext context) {
  return StatefulBuilder(
    builder: (context, setState) {
      var taps = 0;
      var pans = 0;
      return StatefulBuilder(
        builder: (context, setLocal) {
          return Card(
            elevation: 3,
            color: const Color(0xFFFCE4EC),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: const BorderSide(color: Color(0xFFD81B60), width: 1.2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '6 · Gesture recognizer factory recipe',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF880E4F),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Set<Factory<OneSequenceGestureRecognizer>> tells Flutter '
                    'which gestures it is allowed to compete for, before they '
                    'fall through to the native view. Use Factory<>() so each '
                    'rebuild gets a fresh recognizer and you do not share '
                    'state across frames.',
                    style: TextStyle(fontSize: 14, height: 1.45),
                  ),
                  const SizedBox(height: 12),
                  const SelectableText(
                    '<Factory<OneSequenceGestureRecognizer>>{\n'
                    '  Factory<TapGestureRecognizer>(\n'
                    '    () => TapGestureRecognizer()..onTap = onTap,\n'
                    '  ),\n'
                    '  Factory<PanGestureRecognizer>(\n'
                    '    () => PanGestureRecognizer()..onUpdate = onPan,\n'
                    '  ),\n'
                    '  Factory<VerticalDragGestureRecognizer>(\n'
                    '    () => VerticalDragGestureRecognizer(),\n'
                    '  ),\n'
                    '  Factory<EagerGestureRecognizer>(\n'
                    '    () => EagerGestureRecognizer(),\n'
                    '  ),\n'
                    '};',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.5,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Tip: EagerGestureRecognizer claims every gesture immediately. '
                    'Use it when the native view should NEVER receive input — '
                    'Flutter wins the arena before any other recognizer competes.',
                    style: TextStyle(fontSize: 13, height: 1.4),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => setLocal(() => taps++),
                    onPanUpdate: (_) => setLocal(() => pans++),
                    child: Container(
                      height: 90,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8BBD0),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFD81B60)),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Tap & drag — taps: $taps · pan ticks: $pans',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF880E4F),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'In a real AndroidView, the gestureRecognizers set decides '
                    'whether the gesture above is delivered to the native view '
                    'or absorbed by Flutter. The widget below is just a Flutter '
                    'GestureDetector that simulates the Flutter side of that '
                    'arena negotiation.',
                    style: TextStyle(fontSize: 13, height: 1.4),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

// =====================================================================
// Section 7 — Hybrid composition vs texture layer
// =====================================================================
Widget _hybridVsTextureSection(BuildContext context) {
  return StatefulBuilder(
    builder: (context, setState) {
      return Card(
        elevation: 3,
        color: const Color(0xFFE0F7FA),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: Color(0xFF00ACC1), width: 1.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '7 · Hybrid composition vs texture layer',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF006064),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Android offers two strategies for embedding a native view.\n\n'
                'Hybrid composition (HC): the native view is rendered into the '
                'same window as Flutter and the Android compositor handles '
                'z-ordering. Lower latency for input, accurate accessibility, '
                'but Flutter must thread-hop and you may hit jank when the '
                'native view triggers layout.\n\n'
                'Virtual display / Texture-layer (TL): the native view is '
                'drawn into a virtual display whose Surface is exposed as a '
                'GPU texture. Flutter composites it as a texture, so it can '
                'be rotated, scaled, and animated freely — at the cost of '
                'input latency and some accessibility degradation.',
                style: TextStyle(fontSize: 14, height: 1.45),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _diagramTile('Hybrid composition', const Color(0xFF26C6DA), 'native view in real window; correct semantics; harder to animate')),
                  const SizedBox(width: 10),
                  Expanded(child: _diagramTile('Texture layer', const Color(0xFF80DEEA), 'rendered into off-screen surface; cheap to transform; lossy input')),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'AndroidView delegates the choice to its controller class — '
                'AndroidViewController or its subclasses ExpensiveAndroidView '
                'and TextureAndroidViewController. RenderAndroidView itself '
                'only sees the result.',
                style: TextStyle(fontSize: 13, height: 1.4),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _diagramTile(String title, Color accent, String desc) {
  return Container(
    height: 130,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: accent.withOpacity(0.18),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: accent.withOpacity(1.0),
          ),
        ),
        const SizedBox(height: 6),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: accent),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.layers, color: accent, size: 36),
          ),
        ),
        const SizedBox(height: 6),
        Text(desc, style: const TextStyle(fontSize: 11, height: 1.3)),
      ],
    ),
  );
}

// =====================================================================
// Section 8 — Compositing trade-offs
// =====================================================================
Widget _compositingTradeoffsSection(BuildContext context) {
  return StatefulBuilder(
    builder: (context, setState) {
      return Card(
        elevation: 3,
        color: const Color(0xFFF9FBE7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: Color(0xFFAFB42B), width: 1.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '8 · Compositing trade-offs',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF827717),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Embedding a native Android view always costs something — but '
                'how much depends on what else is happening on the same frame.\n\n'
                '• Animations on top of an AndroidView force a saveLayer in some '
                '  hybrid composition modes. Avoid wrapping the AndroidView in '
                '  Opacity, ColorFiltered, or anti-aliased ClipRRect during a '
                '  hot animation.\n'
                '• GPU contention is real: the native view and Flutter both '
                '  want the GPU. If your map flashes during a hero animation, '
                '  consider TextureAndroidViewController so the native side '
                '  caches into a texture.\n'
                '• AndroidView.onPlatformViewCreated runs on the platform '
                '  thread. Schedule heavy native init (loading map tiles, '
                '  warming a webview) AFTER first frame using SchedulerBinding.',
                style: TextStyle(fontSize: 14, height: 1.45),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: _miniDiagram('Animated overlay', Icons.auto_awesome, const Color(0xFFC0CA33)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _miniDiagram('GPU contention', Icons.memory, const Color(0xFF9E9D24)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _miniDiagram('Texture cache', Icons.image, const Color(0xFFCDDC39)),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _miniDiagram(String title, IconData icon, Color color) {
  return Container(
    height: 110,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withOpacity(0.18),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 6),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.lerp(color, Colors.black, 0.4),
            fontSize: 12.5,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// Section 9 — Lifecycle states
// =====================================================================
Widget _lifecycleSection(BuildContext context) {
  return StatefulBuilder(
    builder: (context, setState) {
      var stage = 0;
      return StatefulBuilder(
        builder: (context, setLocal) {
          final names = ['create', 'attach', 'resize', 'dispose'];
          final descs = [
            'AndroidViewController instance allocated. No Surface yet. The '
                'native side has not been told to initialise.',
            'Surface created and the native view is attached to it. Flutter '
                'has called create() on the platform side; first frames may now '
                'arrive over the engine bridge.',
            'Layout pass changed the size, so RenderAndroidView calls '
                'AndroidViewController.setSize(). The native view is asked to '
                'lay out at the new dimensions.',
            'RenderObject is detached and AndroidViewController.dispose() runs. '
                'Releases the Surface, unregisters from the engine, and frees '
                'native references to the Android View.',
          ];
          return Card(
            elevation: 3,
            color: const Color(0xFFEFEBE9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: const BorderSide(color: Color(0xFF6D4C41), width: 1.2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '9 · Controller lifecycle',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4E342E),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'AndroidViewController has its own state machine — every '
                    'state transition can throw if you call it out of order. '
                    'Click through the four canonical stages below to see what '
                    'happens behind the scenes when AndroidView is attached, '
                    'resized, and torn down.',
                    style: TextStyle(fontSize: 14, height: 1.45),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 80,
                    child: CustomPaint(
                      painter: _LifecyclePainter(stage),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: List.generate(
                      names.length,
                      (i) => ChoiceChip(
                        label: Text(names[i]),
                        selected: stage == i,
                        onSelected: (_) => setLocal(() => stage = i),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF6D4C41)),
                    ),
                    child: Text(
                      '${names[stage]}: ${descs[stage]}',
                      style: const TextStyle(fontSize: 13, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

// =====================================================================
// Section 10 — Common pitfalls
// =====================================================================
Widget _pitfallsSection(BuildContext context) {
  final pitfalls = <_Pitfall>[
    _Pitfall(
      'Late or null controller',
      'Forgetting to await PlatformViewsService.initAndroidView() or assigning '
          'to a `late` controller before it is created throws '
          '"LateInitializationError" on the first build. Always wrap '
          'controller creation in onPlatformViewCreated.',
    ),
    _Pitfall(
      'Leaking native references',
      'AndroidViewController holds JNI references to the actual Android View. '
          'If the widget is removed without calling dispose(), the native view '
          'lives until the activity finishes. Symptoms: WebView keeps playing '
          'audio after navigation.',
    ),
    _Pitfall(
      'Hit-test dead zones',
      'Setting hitTestBehavior to transparent on a full-bleed AndroidView '
          'leaves Flutter unable to receive any tap inside its bounds. Common '
          'cause of "my floating action button does nothing on the map screen".',
    ),
    _Pitfall(
      'Resizing during scroll',
      'Native views are expensive to resize. Calling setState that changes the '
          'AndroidView size every scroll frame causes ANR-like jank. Wrap the '
          'AndroidView in a fixed-size box or use AspectRatio.',
    ),
    _Pitfall(
      'Mixing with Hero / Transform.rotate',
      'Hero animations and Transform.rotate require Flutter to composite the '
          'AndroidView through a saveLayer. With hybrid composition this can '
          'flicker. Switch to TextureAndroidViewController for transitions.',
    ),
    _Pitfall(
      'Wrong gestureRecognizers set',
      'Passing recognizers as instances instead of Factory wrappers leads to '
          'recognizer reuse across frames, causing "recognizer already added '
          'to gesture arena" assertions in debug.',
    ),
  ];

  return StatefulBuilder(
    builder: (context, setState) {
      return Card(
        elevation: 3,
        color: const Color(0xFFF3E5F5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: Color(0xFF8E24AA), width: 1.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '10 · Common pitfalls',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Embedding a native view sits at the boundary of two render '
                'systems and three threads (UI, raster, platform). Most bugs '
                'live at that boundary. The cards below collect the failure '
                'modes that show up most often.',
                style: TextStyle(fontSize: 14, height: 1.45),
              ),
              const SizedBox(height: 12),
              Column(
                children: pitfalls.map(_pitfallCard).toList(),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _Pitfall {
  _Pitfall(this.title, this.body);
  final String title;
  final String body;
}

Widget _pitfallCard(_Pitfall p) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFF8E24AA)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          p.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF6A1B9A),
          ),
        ),
        const SizedBox(height: 4),
        Text(p.body, style: const TextStyle(fontSize: 13, height: 1.4)),
      ],
    ),
  );
}

// =====================================================================
// Section 11 — Real apps using AndroidView
// =====================================================================
Widget _realAppsSection(BuildContext context) {
  final entries = <_AppEntry>[
    _AppEntry('Google Maps', Icons.map, const Color(0xFF388E3C),
        'google_maps_flutter wraps AndroidView around com.google.android.gms.maps.MapView. Hit-test opaque, hybrid composition.'),
    _AppEntry('WebView', Icons.public, const Color(0xFF1976D2),
        'webview_flutter exposes android.webkit.WebView via a platform view. Often opaque, switches to texture for animations.'),
    _AppEntry('AdMob banners', Icons.campaign, const Color(0xFFEF6C00),
        'google_mobile_ads renders AdView through AndroidView. Translucent hit-test so taps still reach SDK click handlers.'),
    _AppEntry('Camera preview', Icons.photo_camera, const Color(0xFF6D4C41),
        'camera plugin uses AndroidView around a SurfaceView/PreviewView. Texture layer is preferred for filters and AR overlays.'),
    _AppEntry('Native video', Icons.movie, const Color(0xFF7B1FA2),
        'video_player can wrap ExoPlayer via AndroidView when texture layer is not enough (e.g. DRM that requires SurfaceView).'),
    _AppEntry('Native chart libs', Icons.bar_chart, const Color(0xFFD81B60),
        'Custom charting libraries (MPAndroidChart, AnyChart) embed via AndroidView so they can keep their interactive renderer.'),
  ];

  return StatefulBuilder(
    builder: (context, setState) {
      return Card(
        elevation: 3,
        color: const Color(0xFFE8F5E9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: Color(0xFF43A047), width: 1.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '11 · Real apps using AndroidView',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'AndroidView is everywhere in production Flutter apps. Below '
                'are six widely-used integrations that all rely on the same '
                'RenderAndroidView under the hood. Each has its own opinion on '
                'hit-testing, composition mode, and lifecycle hooks.',
                style: TextStyle(fontSize: 14, height: 1.45),
              ),
              const SizedBox(height: 14),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2.2,
                children: entries.map(_appCard).toList(),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _AppEntry {
  _AppEntry(this.name, this.icon, this.color, this.note);
  final String name;
  final IconData icon;
  final Color color;
  final String note;
}

Widget _appCard(_AppEntry e) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: e.color.withOpacity(0.10),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: e.color),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(e.icon, color: e.color, size: 30),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                e.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: e.color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                e.note,
                style: const TextStyle(fontSize: 11.5, height: 1.3),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// Section 12 — Decision card
// =====================================================================
Widget _decisionSection(BuildContext context) {
  return StatefulBuilder(
    builder: (context, setState) {
      return Card(
        elevation: 3,
        color: const Color(0xFFECEFF1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: Color(0xFF455A64), width: 1.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '12 · When to use AndroidView',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF263238),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'AndroidView is the heaviest-weight Flutter widget. Reach for '
                'it only when you really need the live native view. The matrix '
                'below summarises the choice space.',
                style: TextStyle(fontSize: 14, height: 1.45),
              ),
              const SizedBox(height: 14),
              _decisionCard(
                'AndroidView',
                Colors.indigo,
                'Use when an Android-only library exposes interactive UI you '
                'cannot reasonably reimplement (Maps, WebView, AR camera).',
              ),
              _decisionCard(
                'UiKitView',
                Colors.teal,
                'Same idea on iOS. AndroidView and UiKitView are sibling '
                'platform-view widgets; if you need both, write a thin shared '
                'wrapper that picks per platform.',
              ),
              _decisionCard(
                'webview_flutter',
                Colors.deepOrange,
                'Already wraps AndroidView for you. Prefer the package over '
                'rolling your own AndroidView when the goal is just a webview.',
              ),
              _decisionCard(
                'Platform channel + Flutter widget',
                Colors.brown,
                'When the native side is logic-only (BLE, IAP, FFI), do NOT '
                'embed an AndroidView. Use MethodChannel/EventChannel and '
                'render the UI in pure Flutter — far cheaper.',
              ),
              _decisionCard(
                'Fully native fragment',
                Colors.deepPurple,
                'When the entire screen is native (large legacy module), '
                'embedding inside Flutter via AndroidView is rarely the right '
                'answer. Push the screen with FlutterEngine.attach instead, '
                'or use add-to-app patterns.',
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _decisionCard(String title, MaterialColor color, String body) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.shade400),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color.shade900,
          ),
        ),
        const SizedBox(height: 4),
        Text(body, style: const TextStyle(fontSize: 13, height: 1.4)),
      ],
    ),
  );
}

// =====================================================================
// Section 13 — Reference table
// =====================================================================
Widget _referenceTableSection(BuildContext context) {
  return StatefulBuilder(
    builder: (context, setState) {
      return Card(
        elevation: 3,
        color: const Color(0xFFE3F2FD),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: Color(0xFF1976D2), width: 1.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '13 · Reference table — RenderAndroidView API',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Quick lookup for every constructor parameter and setter on '
                'RenderAndroidView (Flutter 3.41.6). Setters update the '
                'embedded view in place — they do not allocate a new render '
                'object.',
                style: TextStyle(fontSize: 14, height: 1.45),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all(
                    const Color(0xFFBBDEFB),
                  ),
                  columns: const [
                    DataColumn(label: Text('Member')),
                    DataColumn(label: Text('Type')),
                    DataColumn(label: Text('Role')),
                  ],
                  rows: const [
                    DataRow(cells: [
                      DataCell(Text('viewController')),
                      DataCell(Text('AndroidViewController')),
                      DataCell(Text('Owns native view; setting it swaps the embed')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('hitTestBehavior')),
                      DataCell(Text('PlatformViewHitTestBehavior')),
                      DataCell(Text('Determines pointer routing across the boundary')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('gestureRecognizers')),
                      DataCell(Text('Set<Factory<OneSequenceGestureRecognizer>>')),
                      DataCell(Text('Recognizers Flutter is allowed to claim first')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('clipBehavior')),
                      DataCell(Text('Clip')),
                      DataCell(Text('Edge clipping; default Clip.hardEdge')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('sizedByParent')),
                      DataCell(Text('bool (true)')),
                      DataCell(Text('RenderObject takes parent constraints verbatim')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('alwaysNeedsCompositing')),
                      DataCell(Text('bool (true)')),
                      DataCell(Text('Forces a layer; required for native composition')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('paint')),
                      DataCell(Text('void Function(PaintingContext, Offset)')),
                      DataCell(Text('Adds a PlatformViewLayer to the engine')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('hitTest')),
                      DataCell(Text('bool Function(BoxHitTestResult, {Offset position})')),
                      DataCell(Text('Implements the hit-test behavior contract')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('describeSemanticsConfiguration')),
                      DataCell(Text('void Function(SemanticsConfiguration)')),
                      DataCell(Text('Surfaces native a11y; requires controller support')),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// =====================================================================
// Section 14 — Footer / references
// =====================================================================
Widget _footerSection(BuildContext context) {
  return StatefulBuilder(
    builder: (context, setState) {
      return Card(
        elevation: 3,
        color: const Color(0xFFFFEBEE),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: Color(0xFFC62828), width: 1.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '14 · References and further reading',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB71C1C),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Bookmark these official docs while working with platform '
                'views. They drift between Flutter releases — verify the '
                'channel before copying snippets.',
                style: TextStyle(fontSize: 14, height: 1.45),
              ),
              const SizedBox(height: 12),
              _refLine('AndroidView', 'api.flutter.dev/flutter/widgets/AndroidView-class.html'),
              _refLine('AndroidViewController', 'api.flutter.dev/flutter/services/AndroidViewController-class.html'),
              _refLine('PlatformViewSurface', 'api.flutter.dev/flutter/widgets/PlatformViewSurface-class.html'),
              _refLine('Hybrid composition', 'docs.flutter.dev/platform-integration/android/platform-views'),
              _refLine('Hit testing on platform views', 'docs.flutter.dev/platform-integration/platform-views/hit-testing'),
              _refLine('Texture-layer hybrid composition', 'docs.flutter.dev/release/breaking-changes/android-surface-control'),
              const SizedBox(height: 12),
              const Text(
                'End of demo. Total sections: 14. Custom painters: 4. Imports: '
                'package:flutter/material.dart only. RenderAndroidView is not '
                'instantiated directly because its required AndroidViewController '
                'cannot be synthesised from interpreted Dart.',
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFFB71C1C),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _refLine(String name, String url) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.link, size: 16, color: Color(0xFFC62828)),
        const SizedBox(width: 6),
        SizedBox(
          width: 220,
          child: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFB71C1C),
            ),
          ),
        ),
        Expanded(
          child: SelectableText(
            url,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Color(0xFF6D4C41),
            ),
          ),
        ),
      ],
    ),
  );
}
