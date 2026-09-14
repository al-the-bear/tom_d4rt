// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// =============================================================================
// AndroidViewSurface Deep Demo
// -----------------------------------------------------------------------------
// This file is a hand-authored long-form demo of the AndroidViewSurface render
// primitive used by Flutter on Android to embed native android.view.View
// instances inside the Flutter render tree.
//
// AndroidViewSurface is the lower-level widget that the higher-level
// AndroidView composes with. It accepts:
//   * an AndroidViewController (lifecycle owner of the native View)
//   * a Set<Factory<OneSequenceGestureRecognizer>> (gesture forwarding)
//   * a PlatformViewHitTestBehavior (touch routing rule)
//
// This demo cannot actually instantiate a real native android.view.View
// because there is no platform plugin registered with this harness; instead
// it explains every concept in detail through cards, diagrams, and tables.
//
// The whole tree is wrapped in a SingleChildScrollView -> Column so it
// renders cleanly under the AST harness regardless of viewport size.
// =============================================================================

// -----------------------------------------------------------------------------
// Color palette ---------------------------------------------------------------
// -----------------------------------------------------------------------------

class _Palette {
  final String name;
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color background;
  final Color surface;
  final Color ink;
  final Color muted;
  final Color success;
  final Color warning;
  final Color danger;
  final Color info;

  const _Palette({
    required this.name,
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.background,
    required this.surface,
    required this.ink,
    required this.muted,
    required this.success,
    required this.warning,
    required this.danger,
    required this.info,
  });
}

const _palette = _Palette(
  name: 'Android Mint',
  primary: Color(0xFF3DDC84),
  secondary: Color(0xFF073042),
  accent: Color(0xFF4285F4),
  background: Color(0xFFF5F7FA),
  surface: Color(0xFFFFFFFF),
  ink: Color(0xFF0E1620),
  muted: Color(0xFF6B7B8A),
  success: Color(0xFF2E7D32),
  warning: Color(0xFFF9A825),
  danger: Color(0xFFC62828),
  info: Color(0xFF1565C0),
);

// -----------------------------------------------------------------------------
// Top-level entry -------------------------------------------------------------
// -----------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('=== AndroidViewSurface Deep Demo ===');
  print('Rendering long-form conceptual demo for AndroidViewSurface.');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'AndroidViewSurface Deep Demo',
    theme: ThemeData(
      primaryColor: _palette.primary,
      scaffoldBackgroundColor: _palette.background,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Color(0xFF0E1620), fontSize: 14),
      ),
      cardTheme: const CardThemeData(
        elevation: 1,
        margin: EdgeInsets.all(6),
      ),
    ),
    home: Scaffold(
      backgroundColor: _palette.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _section1HeaderAndPlatformBanner(context),
              const SizedBox(height: 18),
              _section2WhatIsAndroidViewSurface(),
              const SizedBox(height: 18),
              _section3CompositionModes(),
              const SizedBox(height: 18),
              _section4Lifecycle(),
              const SizedBox(height: 18),
              _section5HitTestBehaviorVisualizer(),
              const SizedBox(height: 18),
              _section6GestureRecognizerFactories(),
              const SizedBox(height: 18),
              _section7LiveAndroidViewSurfaceAttempt(context),
              const SizedBox(height: 18),
              _section8MultipleViewTypeShowcase(context),
              const SizedBox(height: 18),
              _section9CommonPitfalls(),
              const SizedBox(height: 18),
              _section10RecipeGallery(),
              const SizedBox(height: 18),
              _section11ReferenceTable(),
              const SizedBox(height: 24),
              _footer(),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// Section 1: Header & platform banner ----------------------------------------
// =============================================================================

Widget _section1HeaderAndPlatformBanner(BuildContext context) {
  final TargetPlatform tp = Theme.of(context).platform;
  final bool isAndroid = tp == TargetPlatform.android;

  final Color bannerBg = isAndroid
      ? _palette.success.withOpacity(0.12)
      : _palette.warning.withOpacity(0.18);
  final Color bannerBorder = isAndroid ? _palette.success : _palette.warning;
  final IconData icon = isAndroid ? Icons.android : Icons.warning_amber_rounded;
  final String title = isAndroid
      ? 'Running on Android'
      : 'Android-only widget — current platform is not Android';
  final String subtitle = isAndroid
      ? 'AndroidViewSurface can be exercised live on this device.'
      : 'AndroidViewSurface only renders on Android. The rest of this page '
            'is a conceptual walk-through with diagrams.';

  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_palette.secondary, _palette.primary],
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.android, color: _palette.primary, size: 30),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'AndroidViewSurface',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'The render primitive behind AndroidView',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: bannerBg,
            border: Border.all(color: bannerBorder, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: <Widget>[
              Icon(icon, color: bannerBorder, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Theme.of(context).platform = ${tp.toString()}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section 2: What is AndroidViewSurface --------------------------------------
// =============================================================================

Widget _section2WhatIsAndroidViewSurface() {
  return _SectionCard(
    icon: Icons.help_outline,
    title: '1. What is AndroidViewSurface?',
    color: _palette.info,
    children: <Widget>[
      const Text(
        'AndroidViewSurface is the low-level Flutter widget that bridges '
        'between the Flutter render tree and an Android Surface holding a '
        'native android.view.View. The higher-level AndroidView widget is a '
        'convenience wrapper that creates an AndroidViewController, then '
        'composes an AndroidViewSurface inside its render tree to display '
        'the controller\'s output.',
        style: TextStyle(fontSize: 14, height: 1.5),
      ),
      const SizedBox(height: 10),
      const Text(
        'In other words: when you use AndroidView, an AndroidViewSurface is '
        'created for you. When you use AndroidViewSurface directly, you are '
        'opting in to fine-grained control over the controller lifecycle, '
        'the gesture forwarding set, and the hit-test behavior.',
        style: TextStyle(fontSize: 14, height: 1.5),
      ),
      const SizedBox(height: 16),
      _layeredDiagram(),
      const SizedBox(height: 12),
      _bulletList(<String>[
        'Render tree primitive: PlatformViewRenderBox subclass.',
        'Owned by Flutter, displays Android-owned Surface bytes.',
        'Decouples controller creation from widget tree placement.',
        'Allows multiple Flutter widgets to read the same controller (rare but allowed in HC).',
        'Supports all three composition modes selected by AndroidViewController.',
      ]),
    ],
  );
}

Widget _layeredDiagram() {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _palette.background,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _palette.muted.withOpacity(0.4)),
    ),
    child: Column(
      children: <Widget>[
        _layerBox('AndroidView (widget)', _palette.primary, 'High-level user-facing widget'),
        _arrowDown(),
        _layerBox('AndroidViewSurface (render)', _palette.accent, 'Render tree primitive'),
        _arrowDown(),
        _layerBox('SurfaceView / TextureView', _palette.info, 'Android side rendering target'),
        _arrowDown(),
        _layerBox('android.view.View', _palette.secondary, 'The actual native view'),
      ],
    ),
  );
}

Widget _layerBox(String label, Color color, String subtitle) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withOpacity(0.15),
      border: Border.all(color: color, width: 1.5),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            color: _palette.ink,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}

Widget _arrowDown() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Icon(Icons.arrow_downward, size: 18, color: _palette.muted),
  );
}

// =============================================================================
// Section 3: Composition modes ------------------------------------------------
// =============================================================================

Widget _section3CompositionModes() {
  return _SectionCard(
    icon: Icons.layers,
    title: '2. Composition modes',
    color: _palette.accent,
    children: <Widget>[
      const Text(
        'Android offers three different composition strategies for embedding '
        'a native View inside a Flutter scene. Each mode has a different '
        'trade-off between correctness (z-order, clipping, transforms) and '
        'performance (extra GPU copies, separate render thread, etc.).',
        style: TextStyle(fontSize: 14, height: 1.5),
      ),
      const SizedBox(height: 12),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: _compositionModeCard(
            title: 'Hybrid Composition',
            shortName: 'HC',
            color: _palette.primary,
            pros: const <String>[
              'Most correct rendering',
              'Supports overlays and transforms',
              'Native a11y intact',
              'Best for complex Views (WebView, MapView)',
            ],
            cons: const <String>[
              'Forces UI thread sync',
              'Higher latency on each frame',
              'Frame budget pressure',
            ],
          )),
          Expanded(child: _compositionModeCard(
            title: 'Texture Layer HC',
            shortName: 'TLHC',
            color: _palette.accent,
            pros: const <String>[
              'Decoupled from UI thread',
              'Lower latency than HC',
              'Currently the recommended default in modern Flutter',
              'Works well with most native Views',
            ],
            cons: const <String>[
              'Some Views misbehave when drawn into a TextureView',
              'a11y less robust than HC',
            ],
          )),
          Expanded(child: _compositionModeCard(
            title: 'Virtual Display',
            shortName: 'VD',
            color: _palette.secondary,
            pros: const <String>[
              'Legacy fallback (oldest mode)',
              'Available everywhere',
              'Works for read-only View content',
            ],
            cons: const <String>[
              'No keyboard / IME / hover',
              'Touch issues with maps and webview',
              'Considered obsolete for new code',
            ],
          )),
        ],
      ),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _palette.info.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _palette.info),
        ),
        child: Row(
          children: <Widget>[
            Icon(Icons.info_outline, color: _palette.info),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Default note: modern Flutter (3.x+) uses TLHC by default '
                'and falls back to HC for views that report they cannot be '
                'drawn into a TextureView. Virtual Display is largely deprecated.',
                style: TextStyle(color: _palette.ink, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _compositionModeCard({
  required String title,
  required String shortName,
  required Color color,
  required List<String> pros,
  required List<String> cons,
}) {
  return Card(
    margin: const EdgeInsets.all(4),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(color: color, width: 1.5),
    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  shortName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Pros',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: _palette.success,
            ),
          ),
          ...pros.map((String p) => _miniBullet(p, _palette.success)),
          const SizedBox(height: 6),
          Text(
            'Cons',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: _palette.danger,
            ),
          ),
          ...cons.map((String c) => _miniBullet(c, _palette.danger)),
        ],
      ),
    ),
  );
}

Widget _miniBullet(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.circle, size: 6, color: color),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 11, color: _palette.ink, height: 1.3),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section 4: Lifecycle --------------------------------------------------------
// =============================================================================

Widget _section4Lifecycle() {
  final List<_LifecycleStep> steps = <_LifecycleStep>[
    _LifecycleStep(
      step: 1,
      title: 'viewType registered',
      icon: Icons.app_registration,
      detail:
          'Native side calls FlutterEngine.platformViewsController.registry.'
          'registerViewFactory(viewType, factory). The viewType string is the '
          'shared key between Dart and platform code.',
    ),
    _LifecycleStep(
      step: 2,
      title: 'controller created',
      icon: Icons.create,
      detail:
          'On Dart side, PlatformViewsService.initSurfaceAndroidView(...) or '
          'initExpensiveAndroidView(...) returns an AndroidViewController. '
          'The controller has not yet allocated a Surface.',
    ),
    _LifecycleStep(
      step: 3,
      title: 'AndroidViewSurface attached',
      icon: Icons.attachment,
      detail:
          'Flutter inserts an AndroidViewSurface widget into the tree. The '
          'underlying RenderObject (PlatformViewRenderBox) reports its layout '
          'size to the controller.',
    ),
    _LifecycleStep(
      step: 4,
      title: 'Surface ready',
      icon: Icons.check_circle_outline,
      detail:
          'controller.create() requests the platform side to allocate the '
          'native View, attach it to a Surface (TextureView/SurfaceView) and '
          'wire up the Surface to the Flutter compositor.',
    ),
    _LifecycleStep(
      step: 5,
      title: 'frames painted',
      icon: Icons.brush,
      detail:
          'Each Flutter frame, the AndroidViewSurface either composes the '
          'native Surface as a separate platform layer (HC) or samples a '
          'TextureView (TLHC). Touches are routed via the configured '
          'PlatformViewHitTestBehavior.',
    ),
    _LifecycleStep(
      step: 6,
      title: 'controller disposed',
      icon: Icons.delete_outline,
      detail:
          'When the AndroidViewSurface is detached or the route is popped, '
          'controller.dispose() releases the native View and its Surface. '
          'Forgetting to dispose causes leaks (very visible in WebView/Maps).',
    ),
  ];

  return _SectionCard(
    icon: Icons.timeline,
    title: '3. Lifecycle (6 steps)',
    color: _palette.success,
    children: <Widget>[
      Column(
        children: steps.map(_lifecycleStepCard).toList(),
      ),
    ],
  );
}

Widget _lifecycleStepCard(_LifecycleStep step) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _palette.surface,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _palette.muted.withOpacity(0.3)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: _palette.success.withOpacity(0.18),
            borderRadius: BorderRadius.circular(19),
          ),
          alignment: Alignment.center,
          child: Text(
            '${step.step}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _palette.success,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Icon(step.icon, color: _palette.success),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                step.title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _palette.ink,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                step.detail,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.4,
                  color: _palette.muted,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _LifecycleStep {
  final int step;
  final String title;
  final IconData icon;
  final String detail;
  _LifecycleStep({
    required this.step,
    required this.title,
    required this.icon,
    required this.detail,
  });
}

// =============================================================================
// Section 5: Hit-test behavior visualizer ------------------------------------
// =============================================================================

Widget _section5HitTestBehaviorVisualizer() {
  return _SectionCard(
    icon: Icons.touch_app,
    title: '4. PlatformViewHitTestBehavior',
    color: _palette.warning,
    children: <Widget>[
      const Text(
        'PlatformViewHitTestBehavior selects how touches that fall inside '
        'the bounds of an AndroidViewSurface are routed. The enum has three '
        'values, each with a clearly defined effect on Flutter\'s gesture '
        'arena and the underlying native View.',
        style: TextStyle(fontSize: 14, height: 1.5),
      ),
      const SizedBox(height: 12),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: _hitTestCard(
            title: 'opaque',
            color: _palette.danger,
            description:
                'AndroidViewSurface absorbs all touches inside its bounds. '
                'Flutter siblings beneath never receive these events. '
                'Best for views like maps and webviews that need full input.',
            scenarioHits: const <bool>[true, false, false],
          )),
          Expanded(child: _hitTestCard(
            title: 'translucent',
            color: _palette.warning,
            description:
                'Touches reach the AndroidViewSurface AND propagate through '
                'so Flutter widgets behind it can also process them. Useful '
                'for transparent overlays.',
            scenarioHits: const <bool>[true, true, false],
          )),
          Expanded(child: _hitTestCard(
            title: 'transparent',
            color: _palette.info,
            description:
                'Touches skip the AndroidViewSurface and go to whatever is '
                'beneath. Useful when the native view is purely decorative.',
            scenarioHits: const <bool>[false, true, false],
          )),
        ],
      ),
    ],
  );
}

Widget _hitTestCard({
  required String title,
  required Color color,
  required String description,
  required List<bool> scenarioHits,
}) {
  return Card(
    margin: const EdgeInsets.all(4),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(color: color, width: 1.5),
    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: _palette.ink,
            ),
          ),
          const SizedBox(height: 10),
          _hitTestDiagram(color: color, hits: scenarioHits),
        ],
      ),
    ),
  );
}

Widget _hitTestDiagram({required Color color, required List<bool> hits}) {
  // hits indices: [0]=AndroidViewSurface, [1]=Flutter sibling beneath, [2]=neither
  final IconData fingerIcon = Icons.touch_app;
  return Container(
    height: 110,
    decoration: BoxDecoration(
      color: _palette.background,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _palette.muted.withOpacity(0.4)),
    ),
    child: Stack(
      children: <Widget>[
        // Sibling layer behind
        Positioned(
          left: 8,
          top: 12,
          right: 8,
          bottom: 12,
          child: Container(
            decoration: BoxDecoration(
              color: hits[1]
                  ? _palette.success.withOpacity(0.25)
                  : _palette.muted.withOpacity(0.15),
              borderRadius: BorderRadius.circular(4),
            ),
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.all(4),
            child: Text(
              'Flutter sibling',
              style: TextStyle(
                fontSize: 9,
                color: _palette.muted,
              ),
            ),
          ),
        ),
        // AVS layer in front
        Positioned(
          left: 28,
          top: 24,
          right: 28,
          bottom: 24,
          child: Container(
            decoration: BoxDecoration(
              color: hits[0]
                  ? color.withOpacity(0.35)
                  : color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: color),
            ),
            alignment: Alignment.center,
            child: Text(
              'AVS',
              style: TextStyle(
                fontSize: 10,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        // Finger pointer
        Positioned(
          right: 6,
          top: 4,
          child: Icon(fingerIcon, size: 18, color: _palette.ink),
        ),
        // Arrow showing which layer gets hit
        Positioned(
          left: 6,
          top: 4,
          child: Row(
            children: <Widget>[
              Icon(
                hits[0] ? Icons.arrow_forward : Icons.arrow_downward,
                size: 14,
                color: hits[0] ? color : _palette.success,
              ),
              const SizedBox(width: 4),
              Text(
                hits[0]
                    ? 'AVS gets it'
                    : (hits[1] ? 'Sibling gets it' : 'Lost'),
                style: TextStyle(
                  fontSize: 9,
                  color: _palette.ink,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section 6: GestureRecognizer factories -------------------------------------
// =============================================================================

Widget _section6GestureRecognizerFactories() {
  return _SectionCard(
    icon: Icons.swipe,
    title: '5. GestureRecognizer factories',
    color: _palette.danger,
    children: <Widget>[
      const Text(
        'AndroidViewSurface accepts a Set<Factory<OneSequenceGestureRecognizer>> '
        'argument. Each factory builds a fresh recognizer that competes in '
        'Flutter\'s gesture arena. If the recognizer wins, the corresponding '
        'gesture is forwarded to the native View. If it loses, Flutter widgets '
        'around the AndroidViewSurface get to handle the gesture.',
        style: TextStyle(fontSize: 14, height: 1.5),
      ),
      const SizedBox(height: 12),
      _codeBlock(
        'final Set<Factory<OneSequenceGestureRecognizer>> gestures =\n'
        '    <Factory<OneSequenceGestureRecognizer>>{\n'
        '      Factory<OneSequenceGestureRecognizer>(\n'
        '        () => EagerGestureRecognizer(),\n'
        '      ),\n'
        '    };\n'
        '\n'
        'AndroidViewSurface(\n'
        '  controller: controller,\n'
        '  gestureRecognizers: gestures,\n'
        '  hitTestBehavior: PlatformViewHitTestBehavior.opaque,\n'
        ');',
      ),
      const SizedBox(height: 12),
      _bulletList(<String>[
        'EagerGestureRecognizer always wins — every touch goes to the native View.',
        'VerticalDragGestureRecognizer factory — only forward vertical drags.',
        'HorizontalDragGestureRecognizer factory — pair with a parent ListView.',
        'TapGestureRecognizer factory — forward taps without scroll/drag.',
        'Use a Factory so each PlatformViewSurface attempt builds a new instance.',
      ]),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _palette.warning.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _palette.warning),
        ),
        child: Row(
          children: <Widget>[
            Icon(Icons.warning_amber_rounded, color: _palette.warning),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Without any factory, the native View only receives gestures '
                'that no Flutter widget cares about. This is why a WebView '
                'sometimes feels unresponsive when nested in scrollables.',
                style: TextStyle(color: _palette.ink, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// =============================================================================
// Section 7: Live AndroidViewSurface attempt ---------------------------------
// =============================================================================

Widget _section7LiveAndroidViewSurfaceAttempt(BuildContext context) {
  final TargetPlatform tp = Theme.of(context).platform;
  final bool isAndroid = tp == TargetPlatform.android;

  return _SectionCard(
    icon: Icons.play_circle_outline,
    title: '6. Live AndroidViewSurface attempt',
    color: _palette.primary,
    children: <Widget>[
      Text(
        isAndroid
            ? 'On Android, we would attempt to instantiate a real '
                  'AndroidViewSurface here. Because there is no platform '
                  'plugin registered for the viewType in the harness, we '
                  'still render a placeholder, but with an Android-themed '
                  'banner.'
            : 'On non-Android we cannot instantiate AndroidViewSurface at '
                  'all. The placeholder below shows the dimensions and the '
                  'expected viewType.',
        style: const TextStyle(fontSize: 13, height: 1.5),
      ),
      const SizedBox(height: 12),
      _avsPlaceholder(
        width: 320,
        height: 220,
        viewType: 'mock.platform.view',
        isAndroid: isAndroid,
      ),
      const SizedBox(height: 12),
      _bulletList(<String>[
        'Required: a registered viewType on the Android side.',
        'Required: an AndroidViewController obtained from PlatformViewsService.',
        'Optional: a custom Set<Factory<OneSequenceGestureRecognizer>>.',
        'Optional: a non-default PlatformViewHitTestBehavior.',
        'Calling AndroidViewSurface without a controller throws AssertionError.',
      ]),
    ],
  );
}

Widget _avsPlaceholder({
  required double width,
  required double height,
  required String viewType,
  required bool isAndroid,
}) {
  final Color border = isAndroid ? _palette.primary : _palette.muted;
  return Center(
    child: CustomPaint(
      size: Size(width, height),
      painter: _DottedBorderPainter(color: border),
      child: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  isAndroid ? Icons.android : Icons.devices_other,
                  size: 36,
                  color: border,
                ),
                const SizedBox(height: 8),
                Text(
                  isAndroid
                      ? 'Would render AndroidViewSurface here'
                      : 'Would render AndroidViewSurface here on Android',
                  style: TextStyle(
                    color: _palette.ink,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'viewType: "$viewType"',
                  style: TextStyle(
                    color: _palette.muted,
                    fontSize: 11,
                    fontFamily: 'monospace',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'size: ${width.toStringAsFixed(0)} x ${height.toStringAsFixed(0)}',
                  style: TextStyle(
                    color: _palette.muted,
                    fontSize: 11,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class _DottedBorderPainter extends CustomPainter {
  final Color color;
  _DottedBorderPainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    const double dash = 6;
    const double gap = 4;
    // top
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x + dash, 0), paint);
      x += dash + gap;
    }
    // right
    double y = 0;
    while (y < size.height) {
      canvas.drawLine(Offset(size.width, y), Offset(size.width, y + dash), paint);
      y += dash + gap;
    }
    // bottom
    x = 0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, size.height), Offset(x + dash, size.height), paint);
      x += dash + gap;
    }
    // left
    y = 0;
    while (y < size.height) {
      canvas.drawLine(Offset(0, y), Offset(0, y + dash), paint);
      y += dash + gap;
    }
  }

  @override
  bool shouldRepaint(covariant _DottedBorderPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

// =============================================================================
// Section 8: Multiple viewType showcase --------------------------------------
// =============================================================================

Widget _section8MultipleViewTypeShowcase(BuildContext context) {
  final List<_ViewTypeEntry> entries = <_ViewTypeEntry>[
    _ViewTypeEntry(
      viewType: 'android.webview',
      icon: Icons.public,
      color: _palette.info,
      summary: 'Android WebView wrapped in AndroidViewSurface.',
    ),
    _ViewTypeEntry(
      viewType: 'android.mapview',
      icon: Icons.map,
      color: _palette.success,
      summary: 'Google Maps SDK MapView via the google_maps_flutter plugin.',
    ),
    _ViewTypeEntry(
      viewType: 'android.cameraview',
      icon: Icons.camera_alt,
      color: _palette.danger,
      summary: 'CameraX preview view, exposed as a SurfaceView.',
    ),
    _ViewTypeEntry(
      viewType: 'android.adview',
      icon: Icons.ads_click,
      color: _palette.warning,
      summary: 'AdMob banner inflated as a native android.view.View.',
    ),
  ];

  return _SectionCard(
    icon: Icons.grid_view,
    title: '7. Multiple viewType showcase',
    color: _palette.info,
    children: <Widget>[
      const Text(
        'A single Flutter screen can host any number of AndroidViewSurfaces, '
        'each with its own viewType, controller, and hit-test rule. The four '
        'placeholders below show the most common viewType patterns.',
        style: TextStyle(fontSize: 14, height: 1.5),
      ),
      const SizedBox(height: 12),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: entries.map(_viewTypeCard).toList(),
      ),
    ],
  );
}

Widget _viewTypeCard(_ViewTypeEntry e) {
  return Expanded(
    child: Card(
      margin: const EdgeInsets.all(4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: e.color, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(e.icon, color: e.color, size: 32),
            const SizedBox(height: 6),
            Text(
              e.viewType,
              style: TextStyle(
                color: e.color,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(height: 4),
            Text(
              e.summary,
              style: TextStyle(
                color: _palette.ink,
                fontSize: 11,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: e.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: e.color.withOpacity(0.5)),
              ),
              alignment: Alignment.center,
              child: Text(
                'AVS placeholder',
                style: TextStyle(
                  fontSize: 10,
                  color: e.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _ViewTypeEntry {
  final String viewType;
  final IconData icon;
  final Color color;
  final String summary;
  _ViewTypeEntry({
    required this.viewType,
    required this.icon,
    required this.color,
    required this.summary,
  });
}

// =============================================================================
// Section 9: Common pitfalls -------------------------------------------------
// =============================================================================

Widget _section9CommonPitfalls() {
  final List<_Pitfall> pitfalls = <_Pitfall>[
    _Pitfall(
      title: 'wrong viewType',
      icon: Icons.error_outline,
      color: _palette.danger,
      detail:
          'The viewType passed to the controller must match exactly what the '
          'native side registered. Even a typo causes a MissingPluginException '
          'and an empty rectangle.',
    ),
    _Pitfall(
      title: 'missing platform plugin',
      icon: Icons.power_off,
      color: _palette.warning,
      detail:
          'If the host app forgets to call GeneratedPluginRegistrant.'
          'registerWith() (or the plugin\'s ViewFactory is not registered), '
          'controller.create() throws MissingPluginException.',
    ),
    _Pitfall(
      title: 'gesture conflict',
      icon: Icons.swipe_left,
      color: _palette.info,
      detail:
          'A WebView inside a vertical ListView fights the parent for vertical '
          'drags. Add a VerticalDragGestureRecognizer factory (or '
          'EagerGestureRecognizer) so the WebView wins.',
    ),
    _Pitfall(
      title: 'z-order issues',
      icon: Icons.layers_outlined,
      color: _palette.accent,
      detail:
          'Pre-HC, Flutter widgets could not be drawn on top of a platform '
          'view. With Hybrid Composition this works, but at a frame-cost. '
          'Avoid placing huge Flutter widgets over an AVS unless you must.',
    ),
    _Pitfall(
      title: 'scrollbar conflicts',
      icon: Icons.swap_vert,
      color: _palette.success,
      detail:
          'Some native Views (WebView, MapView) draw their own scrollbars. '
          'Combined with a Flutter SingleChildScrollView this leads to '
          'double scrollbars and weird fling physics. Disable one side.',
    ),
    _Pitfall(
      title: 'performance: prefer TLHC',
      icon: Icons.speed,
      color: _palette.primary,
      detail:
          'Hybrid Composition forces UI-thread sync each frame. Texture Layer '
          'HC keeps the native render thread independent. Always profile '
          'with a release build, not debug, before deciding on a mode.',
    ),
  ];

  return _SectionCard(
    icon: Icons.warning_amber_rounded,
    title: '8. Common pitfalls',
    color: _palette.danger,
    children: <Widget>[
      Wrap(
        children: pitfalls.map(_pitfallCard).toList(),
      ),
    ],
  );
}

Widget _pitfallCard(_Pitfall p) {
  return SizedBox(
    width: 260,
    child: Card(
      margin: const EdgeInsets.all(4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: p.color, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(p.icon, color: p.color),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    p.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: p.color,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              p.detail,
              style: TextStyle(
                color: _palette.ink,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _Pitfall {
  final String title;
  final IconData icon;
  final Color color;
  final String detail;
  _Pitfall({
    required this.title,
    required this.icon,
    required this.color,
    required this.detail,
  });
}

// =============================================================================
// Section 10: Recipe gallery -------------------------------------------------
// =============================================================================

Widget _section10RecipeGallery() {
  final List<_Recipe> recipes = <_Recipe>[
    _Recipe(
      title: 'Embed Google Maps',
      icon: Icons.location_on,
      color: _palette.success,
      steps: const <String>[
        'Add google_maps_flutter to pubspec.yaml',
        'Register API key in AndroidManifest.xml',
        'Use GoogleMap widget — it nests an AndroidViewSurface internally',
        'Forward all gestures with EagerGestureRecognizer if inside a ListView',
      ],
    ),
    _Recipe(
      title: 'WebView fallback',
      icon: Icons.public,
      color: _palette.info,
      steps: const <String>[
        'Add webview_flutter to pubspec.yaml',
        'Use WebViewWidget(controller: ...) which wraps AndroidViewSurface',
        'If inside a CustomScrollView, give the WebView a fixed height',
        'Set hitTestBehavior to opaque so WebView owns its touches',
      ],
    ),
    _Recipe(
      title: 'Native camera preview',
      icon: Icons.camera,
      color: _palette.danger,
      steps: const <String>[
        'Use camera or camerax_android plugin',
        'Plugin registers a viewType and returns a controller',
        'AndroidViewSurface is created by the plugin; you only get a Widget',
        'Dispose the controller in dispose() to release the camera HW',
      ],
    ),
    _Recipe(
      title: 'Ad SDK banner',
      icon: Icons.ads_click,
      color: _palette.warning,
      steps: const <String>[
        'Use google_mobile_ads or applovin_max plugin',
        'Banner is built natively and exposed via AndroidViewSurface',
        'Use translucent hit-test if you overlay Flutter UI on top',
        'Watch for ANRs caused by ad SDK doing UI thread work',
      ],
    ),
  ];

  return _SectionCard(
    icon: Icons.menu_book,
    title: '9. Recipe gallery',
    color: _palette.accent,
    children: <Widget>[
      Wrap(
        children: recipes.map(_recipeCard).toList(),
      ),
    ],
  );
}

Widget _recipeCard(_Recipe r) {
  return SizedBox(
    width: 260,
    child: Card(
      margin: const EdgeInsets.all(4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: r.color, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(r.icon, color: r.color),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    r.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: r.color,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...r.steps.asMap().entries.map(
                  (MapEntry<int, String> e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: r.color.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${e.key + 1}',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: r.color,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            e.value,
                            style: TextStyle(
                              fontSize: 11,
                              color: _palette.ink,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            const SizedBox(height: 6),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: r.color.withOpacity(0.08),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: r.color.withOpacity(0.4)),
              ),
              alignment: Alignment.center,
              child: Text(
                'integration diagram (placeholder)',
                style: TextStyle(
                  fontSize: 10,
                  color: r.color,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _Recipe {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> steps;
  _Recipe({
    required this.title,
    required this.icon,
    required this.color,
    required this.steps,
  });
}

// =============================================================================
// Section 11: Reference table ------------------------------------------------
// =============================================================================

Widget _section11ReferenceTable() {
  final List<_TableRow> rows = <_TableRow>[
    _TableRow(
      widget: 'AndroidView',
      platforms: 'Android',
      role: 'High-level widget; wraps AndroidViewSurface internally.',
      color: _palette.primary,
    ),
    _TableRow(
      widget: 'AndroidViewSurface',
      platforms: 'Android',
      role: 'Render primitive; takes controller, gestures, hit-test.',
      color: _palette.accent,
    ),
    _TableRow(
      widget: 'UiKitView',
      platforms: 'iOS',
      role: 'Embed UIView via FlutterPlatformView.',
      color: _palette.info,
    ),
    _TableRow(
      widget: 'AppKitView',
      platforms: 'macOS',
      role: 'Embed NSView. Newer addition (Flutter 3.x).',
      color: _palette.secondary,
    ),
    _TableRow(
      widget: 'HtmlElementView',
      platforms: 'Web',
      role: 'Embed an HTMLElement via the platform view registry.',
      color: _palette.warning,
    ),
    _TableRow(
      widget: 'PlatformViewLink',
      platforms: 'Android, iOS, macOS',
      role: 'Cross-platform link between controller and surface.',
      color: _palette.success,
    ),
  ];

  return _SectionCard(
    icon: Icons.table_chart,
    title: '10. Reference Table',
    color: _palette.secondary,
    children: <Widget>[
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: _palette.muted.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: <Widget>[
            _tableHeaderRow(),
            ...rows.map(_tableDataRow),
          ],
        ),
      ),
    ],
  );
}

Widget _tableHeaderRow() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    decoration: BoxDecoration(
      color: _palette.secondary,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
    ),
    child: Row(
      children: const <Widget>[
        Expanded(
          flex: 2,
          child: Text(
            'Widget',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Platforms',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            'Role',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _tableDataRow(_TableRow r) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    decoration: BoxDecoration(
      color: _palette.surface,
      border: Border(
        top: BorderSide(color: _palette.muted.withOpacity(0.3)),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(
            r.widget,
            style: TextStyle(
              color: r.color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            r.platforms,
            style: TextStyle(
              color: _palette.ink,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            r.role,
            style: TextStyle(
              color: _palette.ink,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

class _TableRow {
  final String widget;
  final String platforms;
  final String role;
  final Color color;
  _TableRow({
    required this.widget,
    required this.platforms,
    required this.role,
    required this.color,
  });
}

// =============================================================================
// Footer ----------------------------------------------------------------------
// =============================================================================

Widget _footer() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _palette.secondary,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.flutter_dash, color: _palette.primary),
            const SizedBox(width: 8),
            const Text(
              'AndroidViewSurface — end of demo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          'Hand-authored long-form demo. Eleven sections explore the lower-'
          'level Android platform-view rendering primitive and the choices '
          'it exposes.',
          style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
        ),
      ],
    ),
  );
}

// =============================================================================
// Shared building blocks ------------------------------------------------------
// =============================================================================

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final List<Widget> children;
  const _SectionCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _palette.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.4)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: color),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }
}

Widget _bulletList(List<String> items) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: items
        .map((String t) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.check, size: 14, color: _palette.success),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      t,
                      style: TextStyle(
                        fontSize: 12,
                        color: _palette.ink,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ))
        .toList(),
  );
}

Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFF0E1620),
      borderRadius: BorderRadius.circular(8),
    ),
    child: SelectableText(
      code,
      style: const TextStyle(
        color: Color(0xFF8FE0A0),
        fontFamily: 'monospace',
        fontSize: 12,
        height: 1.45,
      ),
    ),
  );
}

// =============================================================================
// End of file ----------------------------------------------------------------
// =============================================================================
