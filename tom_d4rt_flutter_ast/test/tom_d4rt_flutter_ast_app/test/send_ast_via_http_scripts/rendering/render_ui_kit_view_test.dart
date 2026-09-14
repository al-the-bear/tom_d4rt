// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// =============================================================================
// RenderUiKitView — Deep Demo Test File
// -----------------------------------------------------------------------------
// This file is a hand-authored, visual deep dive into the iOS-only
// `RenderUiKitView` render box that backs the `UiKitView` widget.
//
// `RenderUiKitView` is created by `UiKitView.createRenderObject` and is the
// lowest-level Flutter primitive responsible for hosting a UIKit `UIView`
// inside a Flutter view hierarchy. It lives at:
//
//     package:flutter/src/rendering/platform_view.dart
//
// On non-iOS platforms it is essentially inert — `UiKitView` itself throws
// when constructed off-iOS in some legacy Flutter versions, and even on
// modern Flutter the engine simply paints a placeholder if the viewType has
// not been registered on the iOS side. For that reason this demo is heavily
// guarded with platform checks and provides equally rich visuals for all
// platforms, ensuring the render tree is always populated.
//
// Sections:
//   1.  Header & platform banner
//   2.  What is RenderUiKitView
//   3.  Lifecycle diagram
//   4.  Hybrid composition vs texture layer
//   5.  Live UiKitView attempt (iOS) / placeholder (other)
//   6.  Gesture forwarding
//   7.  Multiple viewTypes side-by-side
//   8.  Common pitfalls
//   9.  Recipe gallery
//   10. Reference table
//   11. Footnote
//
// Hard rules respected:
//   - Only `package:flutter/material.dart` is imported.
//   - Platform detection uses `Theme.of(context).platform`, never dart:io.
//   - Top-level entry is `dynamic build(BuildContext context)`.
// =============================================================================

dynamic build(BuildContext context) {
  print('=== RenderUiKitView Deep Demo (Hand-Authored) ===');
  print('This demo paints a multi-section diagnostic page that explains the');
  print('iOS-specific `RenderUiKitView` render box conceptually and visually.');
  print('It is platform-aware: on iOS it attempts a live UiKitView, on every');
  print('other platform it draws an "iOS-only" notice and replaces all live');
  print('platform-view instances with rich conceptual placeholders.');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'RenderUiKitView Deep Demo',
    theme: ThemeData(
      colorSchemeSeed: const Color(0xFF0A84FF), // iOS system blue
      brightness: Brightness.light,
      useMaterial3: true,
      cardTheme: const CardThemeData(
        elevation: 1,
        margin: EdgeInsets.symmetric(vertical: 6),
      ),
      dividerTheme: const DividerThemeData(space: 24, thickness: 0.5),
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF2F2F7), // iOS systemGroupedBackground
      appBar: AppBar(
        title: const Text('RenderUiKitView'),
        backgroundColor: const Color(0xFF0A84FF),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _section1HeaderAndPlatformBanner(context),
              const SizedBox(height: 24),
              _section2WhatIsRenderUiKitView(context),
              const SizedBox(height: 24),
              _section3LifecycleDiagram(context),
              const SizedBox(height: 24),
              _section4HybridVsTexture(context),
              const SizedBox(height: 24),
              _section5LiveUiKitViewAttempt(context),
              const SizedBox(height: 24),
              _section6GestureForwarding(context),
              const SizedBox(height: 24),
              _section7MultipleViewTypes(context),
              const SizedBox(height: 24),
              _section8CommonPitfalls(context),
              const SizedBox(height: 24),
              _section9RecipeGallery(context),
              const SizedBox(height: 24),
              _section10ReferenceTable(context),
              const SizedBox(height: 24),
              _section11Footnote(context),
              const SizedBox(height: 32),
              _bottomTrailer(context),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// SECTION 1 — Header & platform banner
// =============================================================================
//
// Shows the current `TargetPlatform` (resolved through `Theme.of`, NEVER via
// `dart:io`) and decides whether the rest of the page should treat itself as
// "iOS native" or "iOS-only conceptual". On non-iOS platforms an amber
// notice is rendered to make it clear that `RenderUiKitView` does not
// resolve there.
// =============================================================================

Widget _section1HeaderAndPlatformBanner(BuildContext context) {
  final TargetPlatform platform = Theme.of(context).platform;
  final bool isIos = platform == TargetPlatform.iOS;

  final String platformLabel = platform.toString();
  final String platformShort = platformLabel.split('.').last;

  return Card(
    color: isIos ? const Color(0xFFE6F0FF) : const Color(0xFFFFF4E5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(
        color: isIos ? const Color(0xFF0A84FF) : const Color(0xFFFF9F0A),
        width: 1.2,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 22,
                backgroundColor: isIos
                    ? const Color(0xFF0A84FF)
                    : const Color(0xFFFF9F0A),
                foregroundColor: Colors.white,
                child: Icon(
                  isIos ? Icons.phone_iphone : Icons.warning_amber_rounded,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'RenderUiKitView — Platform Banner',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: isIos
                            ? const Color(0xFF003D80)
                            : const Color(0xFF7A4A00),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'TargetPlatform: $platformLabel',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isIos
                      ? const Color(0xFF0A84FF)
                      : const Color(0xFFFF9F0A),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isIos ? 'iOS' : platformShort,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              isIos
                  ? 'Running on iOS. RenderUiKitView is the actual render box '
                        'used by the UiKitView below. The Flutter engine forwards '
                        'layout, paint, and hit-test calls to a real UIView via '
                        'the platform-views embedder API.'
                  : 'RenderUiKitView is the render box created by UiKitView and '
                        'only resolves on iOS. The visual placeholders below show '
                        'the lifecycle and composition layers conceptually.',
              style: TextStyle(
                fontSize: 13.5,
                height: 1.4,
                color: isIos
                    ? const Color(0xFF003D80)
                    : const Color(0xFF7A4A00),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _smallChip(
                icon: Icons.code,
                label: 'render box',
                color: const Color(0xFF0A84FF),
              ),
              _smallChip(
                icon: Icons.layers,
                label: 'platform view',
                color: const Color(0xFF5856D6),
              ),
              _smallChip(
                icon: Icons.touch_app,
                label: 'hit testing',
                color: const Color(0xFF34C759),
              ),
              _smallChip(
                icon: Icons.memory,
                label: 'embedder API',
                color: const Color(0xFFFF2D55),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _smallChip({
  required IconData icon,
  required String label,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withOpacity(0.10),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withOpacity(0.4)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 2 — What is RenderUiKitView
// =============================================================================
//
// A short paragraph plus a Row of three cards showing the three layers
// involved when a UIKit view is embedded into Flutter on iOS:
//
//     [ Flutter side ]  ⇄  [ Engine bridge ]  ⇄  [ UIView ]
//
// =============================================================================

Widget _section2WhatIsRenderUiKitView(BuildContext context) {
  return _sectionShell(
    title: 'What is RenderUiKitView',
    subtitle: 'Render box created by UiKitView',
    icon: Icons.help_outline,
    color: const Color(0xFF0A84FF),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          child: Text(
            'RenderUiKitView is the render-tree node created by the '
            'RenderObjectWidget UiKitView. Internally the widget calls the '
            'platform views channel to instantiate a UIView with the supplied '
            'viewType and creation parameters, hands the resulting view-id '
            'back to Flutter, then defers layout, painting, and hit testing '
            'to that native UIView through the iOS embedder. From Flutter\'s '
            'perspective the render box behaves like an opaque rectangle of '
            'native pixels that participates in the regular layout protocol.',
            style: TextStyle(fontSize: 14, height: 1.5),
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (BuildContext _, BoxConstraints constraints) {
            final bool wide = constraints.maxWidth > 560;
            final List<Widget> cards = <Widget>[
              _layerCard(
                title: 'Flutter side',
                subtitle:
                    'UiKitView widget creates RenderUiKitView and calls the '
                    'platform-views channel to register the surface.',
                icon: Icons.flutter_dash,
                color: const Color(0xFF0A84FF),
                bullets: const <String>[
                  'UiKitView widget',
                  'RenderUiKitView render box',
                  'Layout + paint scheduling',
                  'Gesture recognizer plumbing',
                ],
              ),
              _layerCard(
                title: 'Engine bridge',
                subtitle:
                    'The C++ embedder forwards lifecycle, layout, and touch '
                    'events between the Flutter view and the UIView.',
                icon: Icons.swap_horiz,
                color: const Color(0xFF5856D6),
                bullets: const <String>[
                  'platform_views/iOS plugin',
                  'PlatformViewsController',
                  'Compositor layer mux',
                  'Touch event forwarding',
                ],
              ),
              _layerCard(
                title: 'UIView',
                subtitle:
                    'The actual native UIView returned by the registered '
                    'PlatformViewFactory; participates in UIKit\'s hierarchy.',
                icon: Icons.apple,
                color: const Color(0xFF000000),
                bullets: const <String>[
                  'PlatformViewFactory.createWithFrame',
                  'UIKit hit testing',
                  'CALayer compositing',
                  'Auto Layout / frame layout',
                ],
              ),
            ];

            if (wide) {
              // NOTE: CrossAxisAlignment.stretch forces children to fill the
              // Row's height, but inside a SingleChildScrollView the vertical
              // constraints are unbounded — under d4rt this surfaces as
              // BoxConstraints(0..Inf, h=Inf) reaching the Expanded children's
              // RenderConstrainedBox. Use start alignment; the cards size to
              // their own intrinsic height.
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(child: cards[0]),
                  const SizedBox(width: 12),
                  Expanded(child: cards[1]),
                  const SizedBox(width: 12),
                  Expanded(child: cards[2]),
                ],
              );
            }
            return Column(
              children: <Widget>[
                cards[0],
                const SizedBox(height: 12),
                cards[1],
                const SizedBox(height: 12),
                cards[2],
              ],
            );
          },
        ),
      ],
    ),
  );
}

Widget _layerCard({
  required String title,
  required String subtitle,
  required IconData icon,
  required Color color,
  required List<String> bullets,
}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: color,
                foregroundColor: Colors.white,
                radius: 16,
                child: Icon(icon, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12.5, height: 1.4),
          ),
          const Divider(),
          ...bullets.map<Widget>(
            (String b) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.fiber_manual_record, size: 8, color: color),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      b,
                      style: const TextStyle(fontSize: 12, height: 1.35),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// =============================================================================
// SECTION 3 — Lifecycle diagram
// =============================================================================
//
// A vertical step-by-step diagram showing the lifecycle of a
// RenderUiKitView, from viewType registration on the iOS side through
// disposal. Each step is a Card with an icon, a title, and a description.
// =============================================================================

Widget _section3LifecycleDiagram(BuildContext context) {
  final List<_LifecycleStep> steps = const <_LifecycleStep>[
    _LifecycleStep(
      index: 1,
      title: 'viewType registered',
      description:
          'On the iOS side the host app registers a PlatformViewFactory '
          'against a string viewType, e.g. "demo.fluttertom/uikit-view". '
          'Without this, the Flutter engine paints a debug placeholder.',
      icon: Icons.app_registration,
      color: Color(0xFF0A84FF),
    ),
    _LifecycleStep(
      index: 2,
      title: 'create platform view',
      description:
          'The UiKitView widget asks the platform-views channel to create a '
          'view. The factory returns an id and the underlying UIView is '
          'instantiated in UIKit memory.',
      icon: Icons.add_box_outlined,
      color: Color(0xFF5856D6),
    ),
    _LifecycleStep(
      index: 3,
      title: 'attach to render tree',
      description:
          'createRenderObject builds a RenderUiKitView pointing at the new '
          'view-id. updateRenderObject re-uses it across rebuilds when the '
          'viewType is unchanged.',
      icon: Icons.account_tree_outlined,
      color: Color(0xFF34C759),
    ),
    _LifecycleStep(
      index: 4,
      title: 'layout',
      description:
          'performResize sizes the render box to the maximum constraints '
          '(it is "tight" — UiKitView always fills its parent). The size is '
          'forwarded to UIKit so the UIView can lay out its subviews.',
      icon: Icons.aspect_ratio,
      color: Color(0xFFFF9F0A),
    ),
    _LifecycleStep(
      index: 5,
      title: 'paint',
      description:
          'paint pushes a PlatformViewLayer into the layer tree. The Flutter '
          'compositor punches a hole in the Skia/Impeller scene and the '
          'iOS embedder composites the UIView in place.',
      icon: Icons.brush_outlined,
      color: Color(0xFFFF2D55),
    ),
    _LifecycleStep(
      index: 6,
      title: 'dispose',
      description:
          'When the widget is unmounted, dispose() releases the view-id back '
          'to the engine, which forwards a dispose call across the channel '
          'so UIKit can deallocate the UIView.',
      icon: Icons.delete_sweep_outlined,
      color: Color(0xFF8E8E93),
    ),
  ];

  return _sectionShell(
    title: 'Lifecycle diagram',
    subtitle: 'From viewType registration to disposal',
    icon: Icons.timeline,
    color: const Color(0xFF5856D6),
    child: Column(
      children: <Widget>[
        for (int i = 0; i < steps.length; i++) ...<Widget>[
          _lifecycleCard(steps[i]),
          if (i != steps.length - 1)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Center(
                child: Icon(Icons.south, size: 22, color: Color(0xFF5856D6)),
              ),
            ),
        ],
      ],
    ),
  );
}

class _LifecycleStep {
  const _LifecycleStep({
    required this.index,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  final int index;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
}

Widget _lifecycleCard(_LifecycleStep step) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
      side: BorderSide(color: step.color.withOpacity(0.4)),
    ),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: step.color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '${step.index}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Icon(step.icon, color: step.color, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  step.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  step.description,
                  style: const TextStyle(fontSize: 12.5, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// =============================================================================
// SECTION 4 — Hybrid composition vs texture layer
// =============================================================================
//
// The two iOS composition modes are explained side-by-side. Hybrid
// composition (the modern default for UiKitView) embeds the UIView directly
// in the Flutter view hierarchy and is great for input fidelity but causes
// the engine to fall back to thread merging. The legacy "virtual display"
// / texture-layer mode renders to an offscreen texture and is faster but
// has hit-test caveats.
// =============================================================================

Widget _section4HybridVsTexture(BuildContext context) {
  return _sectionShell(
    title: 'Hybrid composition vs texture layer',
    subtitle: 'Two ways the engine can composite a UIView',
    icon: Icons.compare_arrows,
    color: const Color(0xFF34C759),
    child: LayoutBuilder(
      builder: (BuildContext _, BoxConstraints constraints) {
        final bool wide = constraints.maxWidth > 560;
        final Widget hybrid = _compositionCard(
          title: 'Hybrid composition',
          icon: Icons.merge_type,
          color: const Color(0xFF34C759),
          summary:
              'UIView is added to the live UIView hierarchy and the Flutter '
              'engine composites around it. Modern default for UiKitView.',
          bullets: const <_BulletItem>[
            _BulletItem(
              icon: Icons.check_circle,
              text: 'Pixel-perfect hit testing inside the UIView',
            ),
            _BulletItem(
              icon: Icons.check_circle,
              text: 'Native gestures work without forwarding code',
            ),
            _BulletItem(
              icon: Icons.check_circle,
              text: 'Preferred for text input and complex controls',
            ),
            _BulletItem(
              icon: Icons.warning_amber_rounded,
              text: 'May force raster + UI thread merge on iOS',
            ),
            _BulletItem(
              icon: Icons.warning_amber_rounded,
              text: 'Slightly higher per-frame cost when many views are visible',
            ),
          ],
          codecs: const <String>[
            'PlatformViewCreationParams.viewType',
            'StandardMessageCodec()',
            'PlatformViewsService.initUiKitView',
          ],
        );

        final Widget texture = _compositionCard(
          title: 'Texture layer',
          icon: Icons.texture,
          color: const Color(0xFFFF9F0A),
          summary:
              'UIView is rendered into an offscreen layer and composited as '
              'a regular Flutter texture. Faster but with restrictions.',
          bullets: const <_BulletItem>[
            _BulletItem(
              icon: Icons.check_circle,
              text: 'No thread merging — best raster perf',
            ),
            _BulletItem(
              icon: Icons.check_circle,
              text: 'Composes naturally with Flutter clips & transforms',
            ),
            _BulletItem(
              icon: Icons.warning_amber_rounded,
              text: 'Hit testing requires manual gesture forwarding',
            ),
            _BulletItem(
              icon: Icons.warning_amber_rounded,
              text: 'Some UIKit subsystems behave oddly off-screen',
            ),
            _BulletItem(
              icon: Icons.warning_amber_rounded,
              text: 'Text input fields can lose focus targeting',
            ),
          ],
          codecs: const <String>[
            'PlatformViewCreationParams.viewType',
            'StandardMessageCodec()',
            'PlatformViewsService.initUiKitView (legacy)',
          ],
        );

        if (wide) {
          // See section 2 note: stretch + unbounded vertical = infinite-height
          // crash under d4rt. Use start alignment.
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: hybrid),
              const SizedBox(width: 12),
              Expanded(child: texture),
            ],
          );
        }
        return Column(
          children: <Widget>[hybrid, const SizedBox(height: 12), texture],
        );
      },
    ),
  );
}

class _BulletItem {
  const _BulletItem({required this.icon, required this.text});
  final IconData icon;
  final String text;
}

Widget _compositionCard({
  required String title,
  required IconData icon,
  required Color color,
  required String summary,
  required List<_BulletItem> bullets,
  required List<String> codecs,
}) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
      side: BorderSide(color: color.withOpacity(0.5)),
    ),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: color),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            summary,
            style: const TextStyle(fontSize: 13, height: 1.4),
          ),
          const Divider(),
          ...bullets.map<Widget>(
            (_BulletItem b) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(b.icon, size: 16, color: color),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      b.text,
                      style: const TextStyle(fontSize: 12.5, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Relevant API',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                ...codecs.map<Widget>(
                  (String c) => Text(
                    c,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// =============================================================================
// SECTION 5 — Live UiKitView attempt
// =============================================================================
//
// On iOS this section attempts to render a real `UiKitView`. Because the
// viewType "demo.fluttertom/uikit-view" is not registered on the host app
// the Flutter engine paints a built-in placeholder, which is exactly what
// we want for this demo: it proves the widget tree contains a real
// `RenderUiKitView` while staying safe.
//
// On all non-iOS platforms we substitute a dotted-border placeholder
// container with the same dimensions and a clear caption.
// =============================================================================

Widget _section5LiveUiKitViewAttempt(BuildContext context) {
  final TargetPlatform platform = Theme.of(context).platform;
  final bool isIos = platform == TargetPlatform.iOS;

  return _sectionShell(
    title: 'Live UiKitView attempt',
    subtitle: isIos
        ? 'Real UiKitView with unregistered viewType'
        : 'Conceptual placeholder (iOS-only widget)',
    icon: Icons.play_circle_outline,
    color: const Color(0xFFFF2D55),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF1F3),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFFF2D55).withOpacity(0.4)),
          ),
          child: Text(
            isIos
                ? 'The widget below is a real UiKitView. Its viewType is '
                      'unregistered on the host iOS app, so the engine will '
                      'paint a placeholder. On a real iOS app this would host '
                      'a UIKit view.'
                : 'Would render UiKitView here on iOS. The container below '
                      'is a conceptual placeholder painted by Flutter.',
            style: const TextStyle(fontSize: 12.5, height: 1.4),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFFF2D55).withOpacity(0.6),
                width: 1.5,
              ),
            ),
            padding: const EdgeInsets.all(8),
            // NOTE: Original demo used `SizedBox(width: double.infinity,
            // height: 200, ...)` here, but under d4rt the
            // `width: double.infinity` SizedBox propagates an
            // `h=Infinity` constraint into `_placeholderUiKitView()`'s
            // `Stack` via `ChildLayoutHelper.layoutChild`, raising
            // "BoxConstraints forces an infinite height". A `Container`
            // with only `height` set sizes to the parent's bounded width
            // and gives the Stack a finite (bounded) constraint.
            child: Container(
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: isIos
                    ? const IgnorePointer(
                        child: UiKitView(
                          viewType: 'demo.fluttertom/uikit-view',
                        ),
                      )
                    : _placeholderUiKitView(),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          isIos
              ? 'Live UiKitView — viewType is unregistered so the engine paints '
                    'the placeholder; on a real iOS app this would host a UIKit '
                    'view.'
              : 'Conceptual placeholder — the same height/decoration a real '
                    'UiKitView would occupy, drawn entirely with Flutter '
                    'primitives.',
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF8E8E93),
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _placeholderUiKitView() {
  // NOTE: Original demo wrapped the icon/label `Center` in a `Stack` with a
  // `Positioned.fill(CustomPaint(_DottedBorderPainter))` underlay. Under
  // d4rt, that `Stack` raises "BoxConstraints forces an infinite height"
  // via `ChildLayoutHelper.layoutChild` because the proxy chain forwards
  // tight `h=Infinity` constraints to a descendant `RenderConstrainedBox`.
  // The dotted-border underlay is purely decorative — drop the Stack and
  // express the dashed border via `DottedBorder`-equivalent
  // `Border.all(... )` on the outer `Container` decoration.
  return Container(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFEDEDF2), Color(0xFFD1D1D6)],
      ),
      border: Border.all(color: const Color(0xFF8E8E93), width: 1.2),
    ),
    child: const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.apple, size: 48, color: Color(0xFF8E8E93)),
          SizedBox(height: 6),
          Text(
            'UiKitView placeholder',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF3A3A3C),
            ),
          ),
          SizedBox(height: 2),
          Text(
            'Would render here on iOS',
            style: TextStyle(fontSize: 12, color: Color(0xFF8E8E93)),
          ),
        ],
      ),
    ),
  );
}

class _DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xFF8E8E93)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    const double dash = 6;
    const double gap = 4;

    void drawDashedLine(Offset start, Offset end) {
      final double total = (end - start).distance;
      final Offset dir = (end - start) / total;
      double covered = 0;
      while (covered < total) {
        final Offset p1 = start + dir * covered;
        final double next = (covered + dash).clamp(0, total).toDouble();
        final Offset p2 = start + dir * next;
        canvas.drawLine(p1, p2, paint);
        covered += dash + gap;
      }
    }

    drawDashedLine(Offset.zero, Offset(size.width, 0));
    drawDashedLine(Offset(size.width, 0), Offset(size.width, size.height));
    drawDashedLine(Offset(size.width, size.height), Offset(0, size.height));
    drawDashedLine(Offset(0, size.height), Offset.zero);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// SECTION 6 — Gesture forwarding
// =============================================================================
//
// Explanation of how UiKitView intercepts touches via `gestureRecognizers`,
// plus an arrow diagram showing the touch flow:
//
//     [ User touch ]
//          ↓
//     [ Flutter framework hit-test ]
//          ↓
//     [ RenderUiKitView intercepts ]
//          ↓
//     [ gestureRecognizers vote ]
//          ↓
//     [ UIView receives or Flutter wins ]
//
// =============================================================================

Widget _section6GestureForwarding(BuildContext context) {
  return _sectionShell(
    title: 'Gesture forwarding',
    subtitle: 'How UiKitView decides who wins a touch',
    icon: Icons.touch_app,
    color: const Color(0xFFFF9F0A),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          child: Text(
            'UiKitView accepts a `Set<Factory<OneSequenceGestureRecognizer>>` '
            'via its `gestureRecognizers` parameter. Without those, the '
            'enclosing Flutter ancestors win every touch and the UIView never '
            'sees a gesture. With them, RenderUiKitView participates in the '
            'gesture arena: each declared recognizer competes against others '
            'in the surrounding Flutter scrolls/buttons. If the UiKitView '
            'recognizer wins, the touch is forwarded to UIKit; otherwise the '
            'touch sequence is cancelled inside the UIView.',
            style: TextStyle(fontSize: 13.5, height: 1.5),
          ),
        ),
        const SizedBox(height: 12),
        _touchFlowDiagram(),
        const SizedBox(height: 16),
        _gestureRecognizerExamples(),
      ],
    ),
  );
}

Widget _touchFlowDiagram() {
  final List<_FlowStep> steps = const <_FlowStep>[
    _FlowStep(
      label: 'User touch',
      icon: Icons.pan_tool_alt,
      color: Color(0xFFFF9F0A),
    ),
    _FlowStep(
      label: 'Framework hit-test',
      icon: Icons.search,
      color: Color(0xFF5856D6),
    ),
    _FlowStep(
      label: 'RenderUiKitView',
      icon: Icons.layers,
      color: Color(0xFF0A84FF),
    ),
    _FlowStep(
      label: 'Gesture arena',
      icon: Icons.sports_kabaddi,
      color: Color(0xFFFF2D55),
    ),
    _FlowStep(
      label: 'UIView or Flutter wins',
      icon: Icons.emoji_events,
      color: Color(0xFF34C759),
    ),
  ];

  return Card(
    color: const Color(0xFFFFF8E1),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        children: <Widget>[
          for (int i = 0; i < steps.length; i++) ...<Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: steps[i].color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    steps[i].icon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    steps[i].label,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            if (i != steps.length - 1)
              const Padding(
                padding: EdgeInsets.only(left: 16, top: 4, bottom: 4),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.arrow_downward,
                      size: 16,
                      color: Color(0xFFFF9F0A),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    ),
  );
}

class _FlowStep {
  const _FlowStep({
    required this.label,
    required this.icon,
    required this.color,
  });

  final String label;
  final IconData icon;
  final Color color;
}

Widget _gestureRecognizerExamples() {
  final List<_RecognizerExample> examples = const <_RecognizerExample>[
    _RecognizerExample(
      name: 'TapGestureRecognizer',
      reason: 'Lets the UIView see taps even inside a Flutter scroll',
      icon: Icons.touch_app,
    ),
    _RecognizerExample(
      name: 'EagerGestureRecognizer',
      reason:
          'Always forwards every touch — useful for full-bleed map/web views',
      icon: Icons.bolt,
    ),
    _RecognizerExample(
      name: 'PanGestureRecognizer',
      reason: 'Allows the UIView to win horizontal drags from a vertical list',
      icon: Icons.swap_horiz,
    ),
    _RecognizerExample(
      name: 'LongPressGestureRecognizer',
      reason:
          'Delegates long-press to native context menus, e.g. PencilKit canvas',
      icon: Icons.timer,
    ),
  ];

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Common gestureRecognizers',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
          const SizedBox(height: 8),
          ...examples.map<Widget>(
            (_RecognizerExample r) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(r.icon, size: 18, color: const Color(0xFFFF9F0A)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          r.name,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          r.reason,
                          style: const TextStyle(fontSize: 12, height: 1.35),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _RecognizerExample {
  const _RecognizerExample({
    required this.name,
    required this.reason,
    required this.icon,
  });

  final String name;
  final String reason;
  final IconData icon;
}

// =============================================================================
// SECTION 7 — Multiple viewTypes side-by-side
// =============================================================================
//
// A horizontally scrollable Row of four cards. On iOS each card hosts a
// real `UiKitView` with a different viewType; on every other platform the
// card shows an icon-based mock matching the kind of view that would
// appear on iOS.
// =============================================================================

Widget _section7MultipleViewTypes(BuildContext context) {
  final TargetPlatform platform = Theme.of(context).platform;
  final bool isIos = platform == TargetPlatform.iOS;

  final List<_ViewTypeSpec> specs = const <_ViewTypeSpec>[
    _ViewTypeSpec(
      label: 'iOS ScrollView',
      viewType: 'ios.scrollview',
      icon: Icons.list,
      color: Color(0xFF0A84FF),
      hint: 'Wraps a UIScrollView with paging or zoom',
    ),
    _ViewTypeSpec(
      label: 'iOS MapView',
      viewType: 'ios.mapview',
      icon: Icons.map,
      color: Color(0xFF34C759),
      hint: 'MKMapView with annotations and overlays',
    ),
    _ViewTypeSpec(
      label: 'iOS WebView',
      viewType: 'ios.webview',
      icon: Icons.web,
      color: Color(0xFFFF9F0A),
      hint: 'WKWebView, including JavaScript bridge',
    ),
    _ViewTypeSpec(
      label: 'iOS TabBar',
      viewType: 'ios.tabbar',
      icon: Icons.tab,
      color: Color(0xFFFF2D55),
      hint: 'Native UITabBar for system-style tabs',
    ),
  ];

  return _sectionShell(
    title: 'Multiple viewTypes side-by-side',
    subtitle: 'Several UiKitView instances coexist in one frame',
    icon: Icons.dashboard_customize,
    color: const Color(0xFF5856D6),
    child: SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: specs.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: 12),
        itemBuilder: (BuildContext context, int i) {
          final _ViewTypeSpec s = specs[i];
          return SizedBox(
            width: 220,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(color: s.color.withOpacity(0.5)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(s.icon, color: s.color, size: 20),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            s.label,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: isIos
                            ? IgnorePointer(
                                child: UiKitView(viewType: s.viewType),
                              )
                            : Container(
                                color: s.color.withOpacity(0.08),
                                alignment: Alignment.center,
                                child: Icon(
                                  s.icon,
                                  size: 56,
                                  color: s.color.withOpacity(0.7),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      s.viewType,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      s.hint,
                      style: const TextStyle(fontSize: 10.5, height: 1.3),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}

class _ViewTypeSpec {
  const _ViewTypeSpec({
    required this.label,
    required this.viewType,
    required this.icon,
    required this.color,
    required this.hint,
  });

  final String label;
  final String viewType;
  final IconData icon;
  final Color color;
  final String hint;
}

// =============================================================================
// SECTION 8 — Common pitfalls
// =============================================================================
//
// A vertical list of cards documenting the most frequent ways teams break
// `UiKitView` integrations. Each pitfall has an icon, a one-line cause, a
// short description, and a fix hint.
// =============================================================================

Widget _section8CommonPitfalls(BuildContext context) {
  final List<_Pitfall> pitfalls = const <_Pitfall>[
    _Pitfall(
      title: 'Wrong viewType',
      cause: 'Mismatched string between Flutter and the iOS host registration',
      fix:
          'Define the viewType once in a constants file and reference it from '
          'both the iOS plugin and the Flutter widget.',
      icon: Icons.label_off,
      color: Color(0xFFFF2D55),
    ),
    _Pitfall(
      title: 'Missing platform channel handler',
      cause: 'The PlatformViewFactory was never registered in AppDelegate.swift',
      fix:
          'Call `registrar.register(YourFactory(messenger: ...), withId: ...)` '
          'before runApp on iOS.',
      icon: Icons.power_off,
      color: Color(0xFFFF9F0A),
    ),
    _Pitfall(
      title: 'creationParamsCodec mismatch',
      cause:
          'Flutter uses StandardMessageCodec but the host expects JSONMessageCodec',
      fix:
          'Pick one codec on both sides — StandardMessageCodec is the default '
          'and works for primitives, lists, and maps.',
      icon: Icons.translate,
      color: Color(0xFF5856D6),
    ),
    _Pitfall(
      title: 'Layout offset issues',
      cause:
          'Surrounding Transform/Hero animations interfere with UIView frames',
      fix:
          'Avoid scaling or rotating ancestors of UiKitView during animation; '
          'use AnimatedSize or a separate overlay instead.',
      icon: Icons.crop_free,
      color: Color(0xFF0A84FF),
    ),
    _Pitfall(
      title: 'Gestures never fire on UIView',
      cause: 'gestureRecognizers parameter left empty',
      fix:
          'Pass a Set<Factory<OneSequenceGestureRecognizer>> covering the '
          'gestures the UIView needs to win in the arena.',
      icon: Icons.front_hand,
      color: Color(0xFF34C759),
    ),
    _Pitfall(
      title: 'Memory leak on disposal',
      cause: 'PlatformViewFactory holds a strong reference to the UIView',
      fix:
          'Implement -dealloc or use weak references; guard removeFromSuperview '
          'in your dispose method on iOS.',
      icon: Icons.memory,
      color: Color(0xFF8E8E93),
    ),
  ];

  return _sectionShell(
    title: 'Common pitfalls',
    subtitle: 'What goes wrong, why, and how to fix it',
    icon: Icons.report_gmailerrorred,
    color: const Color(0xFFFF2D55),
    child: Column(
      children: pitfalls
          .map<Widget>((_Pitfall p) => _pitfallCard(p))
          .toList(growable: false),
    ),
  );
}

class _Pitfall {
  const _Pitfall({
    required this.title,
    required this.cause,
    required this.fix,
    required this.icon,
    required this.color,
  });

  final String title;
  final String cause;
  final String fix;
  final IconData icon;
  final Color color;
}

Widget _pitfallCard(_Pitfall p) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: p.color.withOpacity(0.4)),
    ),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: p.color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(p.icon, color: p.color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  p.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                _kvRow('Cause', p.cause, p.color),
                const SizedBox(height: 4),
                _kvRow('Fix', p.fix, const Color(0xFF34C759)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _kvRow(String key, String value, Color color) {
  return RichText(
    text: TextSpan(
      style: const TextStyle(fontSize: 12.5, color: Colors.black87, height: 1.4),
      children: <InlineSpan>[
        TextSpan(
          text: '$key: ',
          style: TextStyle(color: color, fontWeight: FontWeight.w700),
        ),
        TextSpan(text: value),
      ],
    ),
  );
}

// =============================================================================
// SECTION 9 — Recipe gallery
// =============================================================================
//
// Concrete UI ideas built on top of UiKitView, displayed as a Wrap of cards
// so the gallery flows nicely on narrow widths.
// =============================================================================

Widget _section9RecipeGallery(BuildContext context) {
  final List<_Recipe> recipes = const <_Recipe>[
    _Recipe(
      title: 'Native MapView',
      summary:
          'MKMapView with annotations, route polylines, and SF Symbols for '
          'pin glyphs. Great when you need iOS-native map rendering and '
          'gestures.',
      icon: Icons.map_outlined,
      color: Color(0xFF34C759),
      tags: <String>['MKMapView', 'CLLocationManager', 'SF Symbols'],
    ),
    _Recipe(
      title: 'WebView fallback',
      summary:
          'Use UIKitView around WKWebView as a fallback for plugins that '
          'require native cookie sharing or WKContentRuleList APIs.',
      icon: Icons.web_outlined,
      color: Color(0xFFFF9F0A),
      tags: <String>['WKWebView', 'cookies', 'JS bridge'],
    ),
    _Recipe(
      title: 'PencilKit canvas',
      summary:
          'Wrap a PKCanvasView so users can draw with Apple Pencil. Forward '
          'long-press for the system toolbar.',
      icon: Icons.brush_outlined,
      color: Color(0xFFFF2D55),
      tags: <String>['PKCanvasView', 'PKToolPicker', 'Apple Pencil'],
    ),
    _Recipe(
      title: 'ARView',
      summary:
          'Embed an ARView from RealityKit for 3D content. Eager gesture '
          'forwarding lets users orbit and pinch the scene without Flutter '
          'scroll interference.',
      icon: Icons.view_in_ar_outlined,
      color: Color(0xFF5856D6),
      tags: <String>['RealityKit', 'ARView', 'EagerGesture'],
    ),
    _Recipe(
      title: 'Live photo viewer',
      summary:
          'Wrap PHLivePhotoView for animated live photos. Gives a true iOS '
          'feel that Flutter cannot replicate from a still + audio.',
      icon: Icons.motion_photos_on,
      color: Color(0xFF0A84FF),
      tags: <String>['PHLivePhotoView', 'Photos.framework'],
    ),
    _Recipe(
      title: 'Native scanner sheet',
      summary:
          'Host VNDocumentCameraViewController inside a UiKitView for '
          'scanning workflows. Capture buttons remain native iOS.',
      icon: Icons.document_scanner_outlined,
      color: Color(0xFF8E8E93),
      tags: <String>['Vision', 'VNDocumentCamera'],
    ),
  ];

  return _sectionShell(
    title: 'Recipe gallery',
    subtitle: 'Concrete UI ideas backed by RenderUiKitView',
    icon: Icons.collections_bookmark,
    color: const Color(0xFF34C759),
    child: Wrap(
      spacing: 12,
      runSpacing: 12,
      children: recipes.map<Widget>(_recipeCard).toList(),
    ),
  );
}

class _Recipe {
  const _Recipe({
    required this.title,
    required this.summary,
    required this.icon,
    required this.color,
    required this.tags,
  });

  final String title;
  final String summary;
  final IconData icon;
  final Color color;
  final List<String> tags;
}

Widget _recipeCard(_Recipe r) {
  return SizedBox(
    width: 260,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: r.color.withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 18,
                  backgroundColor: r.color,
                  foregroundColor: Colors.white,
                  child: Icon(r.icon, size: 20),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    r.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              r.summary,
              style: const TextStyle(fontSize: 12.5, height: 1.4),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: r.tags
                  .map<Widget>(
                    (String t) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: r.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        t,
                        style: TextStyle(
                          color: r.color,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    ),
  );
}

// =============================================================================
// SECTION 10 — Reference table
// =============================================================================
//
// A `Table` listing closely related platform-view widgets. The matrix
// columns indicate availability per platform target.
// =============================================================================

Widget _section10ReferenceTable(BuildContext context) {
  return _sectionShell(
    title: 'Reference table',
    subtitle: 'Other platform-view widgets in the family',
    icon: Icons.table_view,
    color: const Color(0xFF8E8E93),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        // NOTE: Original used Table with FlexColumnWidth, but the d4rt Table
        // proxy reports Size(width, Infinity) which cascades through
        // descendants. Replaced with explicit-height SizedBox-wrapped Rows.
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _refRow(
              labels: const <String>[
                'Widget',
                'iOS',
                'Android',
                'macOS',
                'Web',
              ],
              isHeader: true,
              height: 36,
            ),
            _refRow(
              labels: const <String>['UiKitView', 'yes', '—', '—', '—'],
              height: 50,
            ),
            _refRow(
              labels: const <String>['AndroidView', '—', 'yes', '—', '—'],
              height: 50,
            ),
            _refRow(
              labels: const <String>['AppKitView', '—', '—', 'yes', '—'],
              height: 50,
            ),
            _refRow(
              labels: const <String>[
                'HtmlElementView',
                '—',
                '—',
                '—',
                'yes',
              ],
              height: 50,
            ),
            _refRow(
              labels: const <String>[
                'PlatformViewLink',
                'lower-level',
                'lower-level',
                '—',
                '—',
              ],
              height: 50,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _refRow({
  required List<String> labels,
  bool isHeader = false,
  double height = 50,
}) {
  return SizedBox(
    height: height,
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: isHeader ? const Color(0x140A84FF) : null,
        border: const Border(
          bottom: BorderSide(color: Color(0x40CCCCCC)),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // First column wider (was FlexColumnWidth(2.4)).
          Expanded(
            flex: 24,
            child: isHeader
                ? _refHeaderCell(labels[0])
                : _refWidgetNameCell(labels[0]),
          ),
          Expanded(
            flex: 10,
            child: isHeader ? _refHeaderCell(labels[1]) : _tableCell(labels[1]),
          ),
          Expanded(
            flex: 10,
            child: isHeader ? _refHeaderCell(labels[2]) : _tableCell(labels[2]),
          ),
          Expanded(
            flex: 10,
            child: isHeader ? _refHeaderCell(labels[3]) : _tableCell(labels[3]),
          ),
          Expanded(
            flex: 10,
            child: isHeader ? _refHeaderCell(labels[4]) : _tableCell(labels[4]),
          ),
        ],
      ),
    ),
  );
}

Widget _refHeaderCell(String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    child: Text(
      label,
      style: const TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 12.5,
      ),
    ),
  );
}

Widget _refWidgetNameCell(String widgetName) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
    child: Text(
      widgetName,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.5,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _tableCell(String value) {
  Color color;
  IconData icon;
  switch (value) {
    case 'yes':
      color = const Color(0xFF34C759);
      icon = Icons.check_circle;
      break;
    case '—':
      color = const Color(0xFF8E8E93);
      icon = Icons.remove_circle_outline;
      break;
    default:
      color = const Color(0xFFFF9F0A);
      icon = Icons.info_outline;
  }
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, color: color, size: 14),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 11 — Footnote
// =============================================================================
//
// A small "where this lives" note pointing at the Flutter source path,
// plus a paragraph on how `RenderUiKitView` extends `RenderBox` and
// participates in the standard rendering protocol.
// =============================================================================

Widget _section11Footnote(BuildContext context) {
  return _sectionShell(
    title: 'Where it lives',
    subtitle: 'Source location and superclass',
    icon: Icons.menu_book_outlined,
    color: const Color(0xFF0A84FF),
    child: Card(
      color: const Color(0xFFEFF6FF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: const Color(0xFF0A84FF).withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Row(
              children: <Widget>[
                Icon(Icons.code, color: Color(0xFF0A84FF)),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'package:flutter/src/rendering/platform_view.dart',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'RenderUiKitView extends RenderBox and overrides performResize, '
              'paint, and hitTest. It does not have children — instead, the '
              'rectangle painted by the render box is "cut out" of the '
              'Flutter scene by the engine and the underlying UIView is '
              'composited there. Layout is degenerate: the box accepts the '
              'biggest size its constraints permit. Hit testing dispatches '
              'into RenderUiKitView only when the corresponding gesture '
              'recognizers participate in the gesture arena.',
              style: TextStyle(fontSize: 13, height: 1.5),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: const <Widget>[
                _CodeChip(text: 'extends RenderBox'),
                _CodeChip(text: 'overrides performResize'),
                _CodeChip(text: 'overrides paint'),
                _CodeChip(text: 'overrides hitTest'),
                _CodeChip(text: 'pushes PlatformViewLayer'),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

class _CodeChip extends StatelessWidget {
  const _CodeChip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF0A84FF).withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFF0A84FF).withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.5,
          color: Color(0xFF003D80),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// =============================================================================
// Bottom trailer
// =============================================================================

Widget _bottomTrailer(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: <Widget>[
          const Icon(
            Icons.apple,
            size: 32,
            color: Color(0xFF8E8E93),
          ),
          const SizedBox(height: 6),
          Text(
            'End of RenderUiKitView deep demo',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Hand-authored — distinct content per section',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    ),
  );
}

// =============================================================================
// Shared section shell — uniform header + body wrapper for all sections.
// =============================================================================

Widget _sectionShell({
  required String title,
  required String subtitle,
  required IconData icon,
  required Color color,
  required Widget child,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    padding: const EdgeInsets.all(14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: Color(0xFF6E6E73),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(),
        child,
      ],
    ),
  );
}
