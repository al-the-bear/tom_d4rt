// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// PlatformViewSurface — Complete Deep Dive
///
/// Palette: Mint / Sage (fresh green-grey tones)
/// Primary:   Color(0xFF2E7D32) — Green 800
/// Secondary: Color(0xFF388E3C) — Green 700
/// Accent:    Color(0xFF66BB6A) — Green 400
/// Surface:   Color(0xFFE8F5E9) — Green 50
/// Deep:      Color(0xFF1B5E20) — Green 900
/// Muted:     Color(0xFFA5D6A7) — Green 200
/// Warm:      Color(0xFF43A047) — Green 600
/// Highlight: Color(0xFFC8E6C9) — Green 100
/// Light:     Color(0xFFF1F8E9) — Light Green 50
/// Dark:      Color(0xFF558B2F) — Light Green 800

dynamic build(BuildContext context) {
  // ─── Section 1: Title Banner ───
  print('');
  print('████████████████████████████████████████████████████████████');
  print('██                                                      ██');
  print('██   PlatformViewSurface — Deep Dive                     ██');
  print('██   Compositor integration for native platform views     ██');
  print('██                                                      ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  const green800 = Color(0xFF2E7D32);
  const green700 = Color(0xFF388E3C);
  const green400 = Color(0xFF66BB6A);
  const green50 = Color(0xFFE8F5E9);
  const green900 = Color(0xFF1B5E20);
  const green200 = Color(0xFFA5D6A7);
  const green600 = Color(0xFF43A047);
  const green100 = Color(0xFFC8E6C9);
  const lightGreen50 = Color(0xFFF1F8E9);
  const lightGreen800 = Color(0xFF558B2F);

  // ─── Section 2: What Is PlatformViewSurface? ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 2: What Is PlatformViewSurface?');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  The rendering widget that displays a native platform');
  print('  view inside the Flutter compositor layer tree.');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  PlatformViewSurface is a LeafRenderObjectWidget.     │');
  print('  │  It has no children — it IS the leaf node where       │');
  print('  │  the native view content appears.                     │');
  print('  │                                                       │');
  print('  │  It creates a PlatformViewRenderBox that:             │');
  print('  │  • Adds a PlatformViewLayer to the compositor         │');
  print('  │  • Forwards pointer events to the native view         │');
  print('  │  • Manages gesture recognizer competition             │');
  print('  │  • Controls hit-testing behavior                      │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 3: Class Definition ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 3: Class Definition');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  class PlatformViewSurface                            │');
  print('  │      extends LeafRenderObjectWidget {                 │');
  print('  │                                                       │');
  print('  │    const PlatformViewSurface({                        │');
  print('  │      required this.controller,                        │');
  print('  │      required this.hitTestBehavior,                   │');
  print('  │      required this.gestureRecognizers,                │');
  print('  │      super.key,                                       │');
  print('  │    });                                                │');
  print('  │                                                       │');
  print('  │    final PlatformViewController controller;           │');
  print('  │    final PlatformViewHitTestBehavior hitTestBehavior; │');
  print('  │    final Set<Factory<OneSequenceGestureRecognizer>>   │');
  print('  │        gestureRecognizers;                            │');
  print('  │  }                                                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 4: LeafRenderObjectWidget ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 4: What Is a LeafRenderObjectWidget?');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Widget hierarchy for rendering:                      │');
  print('  │                                                       │');
  print('  │  Widget                                               │');
  print('  │  └─ RenderObjectWidget                                │');
  print('  │     ├─ SingleChildRenderObjectWidget  (1 child)       │');
  print('  │     ├─ MultiChildRenderObjectWidget   (N children)    │');
  print('  │     └─ LeafRenderObjectWidget         (0 children)    │');
  print('  │                                                       │');
  print('  │  LeafRenderObjectWidget is the terminal node —        │');
  print('  │  it creates a RenderObject that paints directly.      │');
  print('  │  No child layout, no child painting.                  │');
  print('  │                                                       │');
  print('  │  Other LeafRenderObjectWidgets:                       │');
  print('  │  • RawImage (displays dart:ui Image)                  │');
  print('  │  • Texture (displays external texture)                │');
  print('  │  • ErrorWidget (displays error in debug)              │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 5: PlatformViewRenderBox ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 5: PlatformViewRenderBox');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  createRenderObject() creates PlatformViewRenderBox:  │');
  print('  │                                                       │');
  print('  │  class PlatformViewRenderBox extends RenderBox {      │');
  print('  │    • controller — dispatches pointer events            │');
  print('  │    • hitTestBehavior — controls hit testing            │');
  print('  │    • gestureRecognizers — gesture competition          │');
  print('  │                                                       │');
  print('  │    paint(PaintingContext, Offset):                     │');
  print('  │      → context.addLayer(PlatformViewLayer(            │');
  print('  │          rect: offset & size,                         │');
  print('  │          viewId: controller.viewId,                   │');
  print('  │        ));                                            │');
  print('  │                                                       │');
  print('  │    The render box does NOT paint pixels — it inserts  │');
  print('  │    a PlatformViewLayer that tells the compositor      │');
  print('  │    "render the native view here."                     │');
  print('  │                                                       │');
  print('  │    handleEvent(PointerEvent):                         │');
  print('  │      → controller.dispatchPointerEvent(event)         │');
  print('  │      → forwarded to the native view                   │');
  print('  │  }                                                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 6: PlatformViewHitTestBehavior ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 6: PlatformViewHitTestBehavior');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  enum PlatformViewHitTestBehavior {                   │');
  print('  │                                                       │');
  print('  │    opaque,                                            │');
  print('  │    // Absorbs all hit tests within its bounds.        │');
  print('  │    // Flutter widgets behind it never get tapped.     │');
  print('  │    // Most common choice for full-screen native views.│');
  print('  │                                                       │');
  print('  │    translucent,                                       │');
  print('  │    // Registers hit tests but allows them to pass     │');
  print('  │    // through. Both native view AND Flutter widgets   │');
  print('  │    // behind can receive events.                      │');
  print('  │                                                       │');
  print('  │    transparent,                                       │');
  print('  │    // Does not participate in hit testing at all.     │');
  print('  │    // All touches pass through to Flutter widgets     │');
  print('  │    // behind the surface. Native view gets nothing.   │');
  print('  │  }                                                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 7: Gesture Recognizers ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 7: Gesture Recognizer Competition');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  gestureRecognizers: Set<Factory<                     │');
  print('  │      OneSequenceGestureRecognizer>>                   │');
  print('  │                                                       │');
  print('  │  These recognizers participate in the Flutter gesture  │');
  print('  │  arena alongside the native view. This solves the     │');
  print('  │  problem of gesture conflicts:                        │');
  print('  │                                                       │');
  print('  │  Example: Native scrollable view inside Flutter scroll│');
  print('  │  → Both want to handle vertical drags                 │');
  print('  │  → gestureRecognizers decides who wins                │');
  print('  │                                                       │');
  print('  │  Common configurations:                               │');
  print('  │                                                       │');
  print('  │  Empty set (most common):                             │');
  print('  │    const <Factory<OneSequenceGestureRecognizer>>{}    │');
  print('  │    → All gestures go to the native view               │');
  print('  │                                                       │');
  print('  │  With recognizers:                                    │');
  print('  │    { Factory<VerticalDragGestureRecognizer>(           │');
  print('  │        () => VerticalDragGestureRecognizer()) }       │');
  print('  │    → Vertical drags compete with native view          │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 8: PlatformViewLayer ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 8: PlatformViewLayer');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  When PlatformViewRenderBox paints, it adds:          │');
  print('  │                                                       │');
  print('  │  PlatformViewLayer(                                   │');
  print('  │    rect: offset & size,    // position + dimensions   │');
  print('  │    viewId: controller.viewId, // native view ID       │');
  print('  │  )                                                    │');
  print('  │                                                       │');
  print('  │  The compositor uses this layer to:                   │');
  print('  │  1. Reserve a rectangular region                      │');
  print('  │  2. Tell the platform to render the native view       │');
  print('  │     in that exact region                              │');
  print('  │  3. Composite Flutter layers around/over/under it     │');
  print('  │                                                       │');
  print('  │  On Android with Hybrid Composition:                  │');
  print('  │    → Native view inserted into the Android view       │');
  print('  │      hierarchy at the right Z-order                   │');
  print('  │                                                       │');
  print('  │  On Android with Virtual Display:                     │');
  print('  │    → Native view renders to a virtual display         │');
  print('  │    → Output appears as a texture in the Flutter layer │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 9: AndroidViewSurface ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 9: AndroidViewSurface Subclass');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  class AndroidViewSurface extends PlatformViewSurface │');
  print('  │                                                       │');
  print('  │  Specialized subclass for Android Hybrid Composition. │');
  print('  │                                                       │');
  print('  │  Overrides createRenderObject() to return             │');
  print('  │  _PlatformViewRenderBoxWithHybridFallback which:      │');
  print('  │                                                       │');
  print('  │  • Uses texture-based rendering when possible         │');
  print('  │  • Falls back to Hybrid Composition automatically     │');
  print('  │  • Handles the Android-specific rendering quirks      │');
  print('  │                                                       │');
  print('  │  This is the surface returned by                      │');
  print('  │  AndroidViewSurface.surfaceFactory when using         │');
  print('  │  Hybrid Composition mode on Android.                  │');
  print('  │                                                       │');
  print('  │  Usage:                                               │');
  print('  │  surfaceFactory: (ctx, controller) {                  │');
  print('  │    return AndroidViewSurface(                         │');
  print('  │      controller: controller as AndroidViewController, │');
  print('  │      hitTestBehavior:                                 │');
  print('  │        PlatformViewHitTestBehavior.opaque,            │');
  print('  │      gestureRecognizers: const {},                    │');
  print('  │    );                                                 │');
  print('  │  }                                                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 10: Rendering Modes ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 10: Android Rendering Modes');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────┬──────────────────────────────┐');
  print('  │  Mode                 │ How It Works                 │');
  print('  ├──────────────────────┼──────────────────────────────┤');
  print('  │  Virtual Display      │ Native view renders to a     │');
  print('  │                       │ virtual display, output is   │');
  print('  │                       │ captured as a texture.       │');
  print('  │                       │ Surface: PlatformViewSurface │');
  print('  ├──────────────────────┼──────────────────────────────┤');
  print('  │  Hybrid Composition   │ Native view inserted into    │');
  print('  │                       │ the Android view hierarchy   │');
  print('  │                       │ at the correct Z-order.      │');
  print('  │                       │ Surface: AndroidViewSurface  │');
  print('  ├──────────────────────┼──────────────────────────────┤');
  print('  │  Texture Layer        │ Native view renders to a     │');
  print('  │                       │ SurfaceTexture, composed as  │');
  print('  │                       │ a texture layer.             │');
  print('  │                       │ Surface: PlatformViewSurface │');
  print('  └──────────────────────┴──────────────────────────────┘');
  print('');

  // ─── Section 11: Pointer Event Flow ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 11: Pointer Event Flow');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  User touches the PlatformViewSurface area:           │');
  print('  │                                                       │');
  print('  │  1. Flutter receives raw pointer event                │');
  print('  │  2. Hit test finds PlatformViewRenderBox              │');
  print('  │  3. gestureRecognizers compete in gesture arena       │');
  print('  │  4. If native view wins (or no competition):          │');
  print('  │     → controller.dispatchPointerEvent(event)          │');
  print('  │     → Event forwarded to native view via platform     │');
  print('  │        channel (MotionEvent on Android, UITouch on    │');
  print('  │        iOS)                                           │');
  print('  │                                                       │');
  print('  │  5. Native view handles the event normally            │');
  print('  │     (scrolling, tapping, dragging, etc.)              │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 12: updateRenderObject ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 12: createRenderObject & updateRenderObject');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  @override                                            │');
  print('  │  RenderObject createRenderObject(BuildContext ctx) {  │');
  print('  │    return PlatformViewRenderBox(                      │');
  print('  │      controller: controller,                          │');
  print('  │      hitTestBehavior: hitTestBehavior,                │');
  print('  │      gestureRecognizers: gestureRecognizers,          │');
  print('  │    );                                                 │');
  print('  │  }                                                    │');
  print('  │                                                       │');
  print('  │  @override                                            │');
  print('  │  void updateRenderObject(BuildContext ctx,            │');
  print('  │      PlatformViewRenderBox renderObject) {            │');
  print('  │    renderObject                                       │');
  print('  │      ..controller = controller                        │');
  print('  │      ..hitTestBehavior = hitTestBehavior              │');
  print('  │      ..updateGestureRecognizers(gestureRecognizers);  │');
  print('  │  }                                                    │');
  print('  │                                                       │');
  print('  │  Updates are efficient — only changed properties      │');
  print('  │  are reassigned on the existing render object.        │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 13: Full Widget Stack ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 13: Full Widget Stack');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Your Code:                                           │');
  print('  │  ┌──────────────────────────────────┐                 │');
  print('  │  │  AndroidView / UiKitView          │ ← High-level  │');
  print('  │  └──────────┬───────────────────────┘                 │');
  print('  │             │ builds                                  │');
  print('  │  ┌──────────▼───────────────────────┐                 │');
  print('  │  │  PlatformViewLink                 │ ← Coordinator │');
  print('  │  └──────────┬───────────────────────┘                 │');
  print('  │             │ surfaceFactory()                        │');
  print('  │  ┌──────────▼───────────────────────┐                 │');
  print('  │  │  PlatformViewSurface              │ ← Leaf widget │');
  print('  │  └──────────┬───────────────────────┘                 │');
  print('  │             │ createRenderObject()                    │');
  print('  │  ┌──────────▼───────────────────────┐                 │');
  print('  │  │  PlatformViewRenderBox            │ ← RenderBox   │');
  print('  │  └──────────┬───────────────────────┘                 │');
  print('  │             │ paint()                                 │');
  print('  │  ┌──────────▼───────────────────────┐                 │');
  print('  │  │  PlatformViewLayer                │ ← Compositor  │');
  print('  │  └─────────────────────────────────┘                  │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 14: Live Demo ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 14: Live Visual Demo');
  print('═══════════════════════════════════════════════════════════');
  print('');

  Widget buildHitTestCard({
    required String mode,
    required String description,
    required IconData icon,
    required Color accent,
    required String example,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: green200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: accent, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mode,
                  style: TextStyle(
                    color: green900,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    color: green800,
                    fontSize: 12,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: green50,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    example,
                    style: TextStyle(
                      color: lightGreen800,
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
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

  final demo = Scaffold(
    backgroundColor: lightGreen50,
    appBar: AppBar(
      title: const Text(
        'PlatformViewSurface — Demo',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
      backgroundColor: green900,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Widget stack diagram ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [green900, green800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Widget → Render → Layer Stack',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                ...[
                  {'layer': 'PlatformViewSurface', 'type': 'LeafRenderObjectWidget', 'icon': Icons.layers},
                  {'layer': 'PlatformViewRenderBox', 'type': 'RenderBox', 'icon': Icons.crop_square},
                  {'layer': 'PlatformViewLayer', 'type': 'Compositor Layer', 'icon': Icons.filter_none},
                  {'layer': 'Native View', 'type': 'Platform (Android/iOS)', 'icon': Icons.phone_android},
                ].asMap().entries.map((entry) {
                  final i = entry.key;
                  final item = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: green400.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            item['icon'] as IconData,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['layer'] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                item['type'] as String,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.65),
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (i < 3)
                          Icon(Icons.arrow_downward, color: green400, size: 14),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // ── Properties ──
          Text(
            'Constructor Properties',
            style: TextStyle(
              color: green900,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'All three are required',
            style: TextStyle(color: green700, fontSize: 12),
          ),
          const SizedBox(height: 8),
          ...[
            {
              'name': 'controller',
              'type': 'PlatformViewController',
              'desc': 'Dispatches events and provides viewId',
              'icon': Icons.settings_remote,
            },
            {
              'name': 'hitTestBehavior',
              'type': 'PlatformViewHitTestBehavior',
              'desc': 'Controls touch event routing',
              'icon': Icons.touch_app,
            },
            {
              'name': 'gestureRecognizers',
              'type': 'Set<Factory<...>>',
              'desc': 'Gesture arena participants',
              'icon': Icons.pan_tool,
            },
          ].map((prop) {
            return Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: green100),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: green800.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      prop['icon'] as IconData,
                      color: green800,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          prop['name'] as String,
                          style: TextStyle(
                            color: green900,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            fontFamily: 'monospace',
                          ),
                        ),
                        Text(
                          prop['type'] as String,
                          style: TextStyle(
                            color: green600,
                            fontSize: 11,
                            fontFamily: 'monospace',
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          prop['desc'] as String,
                          style: TextStyle(
                            color: green700,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 12),

          // ── Hit test behaviors ──
          Text(
            'Hit Test Behaviors',
            style: TextStyle(
              color: green900,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 8),
          buildHitTestCard(
            mode: 'opaque',
            description: 'Absorbs all touches. Flutter widgets behind are unreachable.',
            icon: Icons.block,
            accent: green900,
            example: 'Full-screen map, video player',
          ),
          buildHitTestCard(
            mode: 'translucent',
            description: 'Both native view and Flutter widgets behind receive events.',
            icon: Icons.blur_on,
            accent: green600,
            example: 'Semi-transparent overlay',
          ),
          buildHitTestCard(
            mode: 'transparent',
            description: 'All touches pass through. Native view receives nothing.',
            icon: Icons.visibility_off,
            accent: green200,
            example: 'Decorative native element, display-only',
          ),

          const SizedBox(height: 12),

          // ── Rendering modes ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: green50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: green100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Android Rendering Modes',
                  style: TextStyle(
                    color: green900,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                ...[
                  {'mode': 'Virtual Display', 'surface': 'PlatformViewSurface', 'how': 'Texture capture'},
                  {'mode': 'Hybrid Composition', 'surface': 'AndroidViewSurface', 'how': 'View hierarchy'},
                  {'mode': 'Texture Layer', 'surface': 'PlatformViewSurface', 'how': 'SurfaceTexture'},
                ].map((m) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: green800,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        SizedBox(
                          width: 120,
                          child: Text(
                            m['mode']!,
                            style: TextStyle(
                              color: green900,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${m["surface"]} (${m["how"]})',
                            style: TextStyle(
                              color: lightGreen800,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  print('  Live widget built: PlatformViewSurface demo');
  print('  • Widget → Render → Layer stack (4 layers)');
  print('  • 3 constructor property cards');
  print('  • 3 hit test behavior cards');
  print('  • Android rendering modes panel');
  print('');

  // ─── Section 15: Summary ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 15: Summary');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Key takeaways:                                      │');
  print('  │                                                      │');
  print('  │  1. LeafRenderObjectWidget — no children              │');
  print('  │  2. Creates PlatformViewRenderBox for rendering       │');
  print('  │  3. Adds PlatformViewLayer to compositor              │');
  print('  │  4. Three hit test modes: opaque/translucent/         │');
  print('  │     transparent                                      │');
  print('  │  5. gestureRecognizers for Flutter/native gesture     │');
  print('  │     conflict resolution                              │');
  print('  │  6. AndroidViewSurface extends it for Hybrid mode    │');
  print('  │  7. Forwards pointer events via controller            │');
  print('  │  8. Efficient updates via updateRenderObject          │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  print('  Demo colors used:');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Green 900      ${green900.toARGB32().toRadixString(16).padLeft(8, "0")}  Deep');
  print('  │  Green 800      ${green800.toARGB32().toRadixString(16).padLeft(8, "0")}  Primary');
  print('  │  Green 700      ${green700.toARGB32().toRadixString(16).padLeft(8, "0")}  Secondary');
  print('  │  Green 600      ${green600.toARGB32().toRadixString(16).padLeft(8, "0")}  Warm');
  print('  │  Green 400      ${green400.toARGB32().toRadixString(16).padLeft(8, "0")}  Accent');
  print('  │  Green 200      ${green200.toARGB32().toRadixString(16).padLeft(8, "0")}  Muted');
  print('  │  Green 100      ${green100.toARGB32().toRadixString(16).padLeft(8, "0")}  Highlight');
  print('  │  Green 50       ${green50.toARGB32().toRadixString(16).padLeft(8, "0")}  Surface');
  print('  │  LightGreen 50  ${lightGreen50.toARGB32().toRadixString(16).padLeft(8, "0")}  Light');
  print('  │  LightGreen 800 ${lightGreen800.toARGB32().toRadixString(16).padLeft(8, "0")}  Dark');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  print('████████████████████████████████████████████████████████████');
  print('██  PlatformViewSurface — Demo Complete                   ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  return demo;
}
