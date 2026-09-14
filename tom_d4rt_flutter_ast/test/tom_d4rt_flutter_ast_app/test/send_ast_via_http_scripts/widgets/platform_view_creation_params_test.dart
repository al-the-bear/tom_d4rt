// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// PlatformViewCreationParams — Complete Deep Dive
///
/// Palette: Copper / Bronze (warm metallic earth tones)
/// Primary:   Color(0xFF5D4037) — Brown 700
/// Secondary: Color(0xFF795548) — Brown 500
/// Accent:    Color(0xFFFF8A65) — Deep Orange 300
/// Surface:   Color(0xFFFBE9E7) — Deep Orange 50
/// Deep:      Color(0xFF3E2723) — Brown 900
/// Muted:     Color(0xFFBCAAA4) — Brown 200
/// Warm:      Color(0xFFD84315) — Deep Orange 800
/// Highlight: Color(0xFFFFCCBC) — Deep Orange 100
/// Light:     Color(0xFFEFEBE9) — Brown 50
/// Dark:      Color(0xFF4E342E) — Brown 800

dynamic build(BuildContext context) {
  // ─── Section 1: Title Banner ───
  print('');
  print('████████████████████████████████████████████████████████████');
  print('██                                                      ██');
  print('██   PlatformViewCreationParams — Deep Dive              ██');
  print('██   Parameter object for native view creation            ██');
  print('██                                                      ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  const brown700 = Color(0xFF5D4037);
  const brown500 = Color(0xFF795548);
  const orange300 = Color(0xFFFF8A65);
  const orange50 = Color(0xFFFBE9E7);
  const brown900 = Color(0xFF3E2723);
  const brown200 = Color(0xFFBCAAA4);
  const orange800 = Color(0xFFD84315);
  const orange100 = Color(0xFFFFCCBC);
  const brown50 = Color(0xFFEFEBE9);
  const brown800 = Color(0xFF4E342E);

  // ─── Section 2: What Is PlatformViewCreationParams? ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 2: What Is PlatformViewCreationParams?');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  A plain parameter object that bundles all the data');
  print('  needed when PlatformViewLink creates a new native view.');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  PlatformViewLink calls its onCreatePlatformView      │');
  print('  │  callback, passing a PlatformViewCreationParams.      │');
  print('  │                                                       │');
  print('  │  Your callback receives:                              │');
  print('  │    • id           — unique view ID (int)              │');
  print('  │    • viewType     — native view type string           │');
  print('  │    • onPlatformViewCreated — notify when ready        │');
  print('  │    • onFocusChanged — forward focus changes           │');
  print('  │                                                       │');
  print('  │  You use these to construct a PlatformViewController  │');
  print('  │  (AndroidViewController, UiKitViewController, etc.)   │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 3: Class Definition ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 3: Class Definition');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  class PlatformViewCreationParams {                   │');
  print('  │    PlatformViewCreationParams._({                     │');
  print('  │      required this.id,                                │');
  print('  │      required this.viewType,                          │');
  print('  │      required this.onPlatformViewCreated,             │');
  print('  │      required this.onFocusChanged,                    │');
  print('  │    });                                                │');
  print('  │                                                       │');
  print('  │    final int id;                                      │');
  print('  │    final String viewType;                             │');
  print('  │    final PlatformViewCreatedCallback                  │');
  print('  │        onPlatformViewCreated;                         │');
  print('  │    final ValueChanged<bool> onFocusChanged;           │');
  print('  │  }                                                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');
  print('  Key details:');
  print('  • Private constructor PlatformViewCreationParams._()');
  print('  • Cannot be instantiated by user code');
  print('  • Only PlatformViewLink._PlatformViewLinkState creates it');
  print('');

  // ─── Section 4: Properties Deep Dive ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 4: Properties Deep Dive');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌─────────────────────────────────────────────────────────┐');
  print('  │  Property                  │ Type / Purpose             │');
  print('  ├─────────────────────────────────────────────────────────┤');
  print('  │  id                        │ int                        │');
  print('  │                            │ Allocated by                │');
  print('  │                            │ platformViewsRegistry       │');
  print('  │                            │ .getNextPlatformViewId()    │');
  print('  ├─────────────────────────────────────────────────────────┤');
  print('  │  viewType                  │ String                     │');
  print('  │                            │ Identifies the native view  │');
  print('  │                            │ (e.g., "my-native-view")   │');
  print('  ├─────────────────────────────────────────────────────────┤');
  print('  │  onPlatformViewCreated     │ PlatformViewCreatedCallback│');
  print('  │                            │ = void Function(int id)    │');
  print('  │                            │ Call when native view ready │');
  print('  ├─────────────────────────────────────────────────────────┤');
  print('  │  onFocusChanged            │ ValueChanged<bool>         │');
  print('  │                            │ = void Function(bool focus) │');
  print('  │                            │ Forward focus gain/loss     │');
  print('  └─────────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 5: Private Constructor Pattern ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 5: Private Constructor Pattern');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  The private constructor._() pattern means:           │');
  print('  │                                                       │');
  print('  │  ✗ PlatformViewCreationParams(...)   // NOT available │');
  print('  │  ✗ PlatformViewCreationParams._(...) // NOT outside   │');
  print('  │    the framework library                              │');
  print('  │                                                       │');
  print('  │  Only the framework can create instances:             │');
  print('  │                                                       │');
  print('  │  // Inside _PlatformViewLinkState.initState():        │');
  print('  │  _params = PlatformViewCreationParams._(              │');
  print('  │    id: platformViewsRegistry.getNextPlatformViewId(), │');
  print('  │    viewType: widget.viewType,                         │');
  print('  │    onPlatformViewCreated: _onPlatformViewCreated,     │');
  print('  │    onFocusChanged: _handlePlatformFocusChanged,       │');
  print('  │  );                                                   │');
  print('  │                                                       │');
  print('  │  This ensures the lifecycle is always managed by      │');
  print('  │  PlatformViewLink — never created ad-hoc.             │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 6: Creation Flow ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 6: Where It Is Created (The Full Flow)');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  1. PlatformViewLink is inserted into the widget tree');
  print('');
  print('  2. _PlatformViewLinkState.initState() runs:');
  print('     a) Allocates new ID from platformViewsRegistry');
  print('     b) Creates PlatformViewCreationParams._( ... )');
  print('     c) Calls widget.onCreatePlatformView(params)');
  print('        → Your callback returns a PlatformViewController');
  print('');
  print('  3. PlatformViewController.create() is called');
  print('     → Native view is created by the platform');
  print('     → Platform calls onPlatformViewCreated(id)');
  print('');
  print('  4. _PlatformViewLinkState rebuilds with the surface');
  print('     widget returned by widget.surfaceFactory');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  PlatformViewLink                                     │');
  print('  │    │                                                  │');
  print('  │    ├─ initState() → allocate ID                       │');
  print('  │    │   └─ PlatformViewCreationParams._( ... )         │');
  print('  │    │       └─ onCreatePlatformView(params)            │');
  print('  │    │           └─ returns PlatformViewController      │');
  print('  │    │                                                  │');
  print('  │    ├─ controller.create()                             │');
  print('  │    │   └─ native view created on platform             │');
  print('  │    │       └─ onPlatformViewCreated(id) callback      │');
  print('  │    │                                                  │');
  print('  │    └─ build() → surfaceFactory(context, controller)   │');
  print('  │        └─ returns PlatformViewSurface                 │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 7: Platform View ID Allocation ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 7: Platform View ID Allocation');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  platformViewsRegistry.getNextPlatformViewId()        │');
  print('  │                                                       │');
  print('  │  Returns a globally unique integer ID for each        │');
  print('  │  native view. The registry is a singleton accessed    │');
  print('  │  via the PlatformViewsRegistry class.                 │');
  print('  │                                                       │');
  print('  │  IDs are sequential and never reused during an        │');
  print('  │  application session. Even if a view is disposed,     │');
  print('  │  its ID is not recycled.                              │');
  print('  │                                                       │');
  print('  │  View 1 → ID 0                                       │');
  print('  │  View 2 → ID 1                                       │');
  print('  │  View 3 → ID 2                                       │');
  print('  │  (View 2 disposed)                                    │');
  print('  │  View 4 → ID 3  (not 1)                              │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 8: Callback Contracts ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 8: Callback Contracts');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  onPlatformViewCreated: (int id) { ... }              │');
  print('  │                                                       │');
  print('  │  MUST be called when the native view finishes setup.  │');
  print('  │  This triggers setState() in PlatformViewLink so it   │');
  print('  │  switches from SizedBox.expand() (placeholder) to    │');
  print('  │  the actual PlatformViewSurface widget.               │');
  print('  │                                                       │');
  print('  │  If you forget to call this, the widget stays as an   │');
  print('  │  empty SizedBox forever — the surface never appears.  │');
  print('  ├──────────────────────────────────────────────────────┤');
  print('  │  onFocusChanged: (bool hasFocus) { ... }              │');
  print('  │                                                       │');
  print('  │  Forward to PlatformViewLink when the native view     │');
  print('  │  gains or loses focus. This allows Flutter to update  │');
  print('  │  its focus tree and manage keyboard input routing.    │');
  print('  │                                                       │');
  print('  │  true  → native view gained focus                     │');
  print('  │  false → native view lost focus                       │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 9: Usage In Your Callback ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 9: Usage In Your onCreatePlatformView Callback');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  PlatformViewLink(                                    │');
  print('  │    viewType: "my-native-view",                        │');
  print('  │    onCreatePlatformView:                              │');
  print('  │        (PlatformViewCreationParams params) {          │');
  print('  │      return PlatformViewsService                      │');
  print('  │        .initSurfaceAndroidView(                       │');
  print('  │          id: params.id,              // ← from params │');
  print('  │          viewType: params.viewType,  // ← from params │');
  print('  │          layoutDirection: TextDirection.ltr,           │');
  print('  │        )                                              │');
  print('  │        ..addOnPlatformViewCreatedListener(            │');
  print('  │          params.onPlatformViewCreated  // ← callback  │');
  print('  │        )                                              │');
  print('  │        ..create();                                    │');
  print('  │    },                                                 │');
  print('  │    surfaceFactory: (context, controller) {            │');
  print('  │      return PlatformViewSurface(                      │');
  print('  │        controller: controller,                        │');
  print('  │        hitTestBehavior:                                │');
  print('  │          PlatformViewHitTestBehavior.opaque,          │');
  print('  │        gestureRecognizers: const <Factory<            │');
  print('  │          OneSequenceGestureRecognizer>>{},             │');
  print('  │      );                                               │');
  print('  │    },                                                 │');
  print('  │  )                                                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 10: Platform-Specific Controllers ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 10: Platform-Specific Controllers');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Platform             │ Controller Type               │');
  print('  ├──────────────────────┼───────────────────────────────┤');
  print('  │  Android (Virtual)    │ AndroidViewController         │');
  print('  │  Android (Hybrid)     │ SurfaceAndroidViewController  │');
  print('  │  iOS (UIKit)          │ UiKitViewController           │');
  print('  │  Web                  │ (not applicable — uses        │');
  print('  │                       │  HtmlElementView directly)    │');
  print('  │  macOS                │ AppKitViewController          │');
  print('  └──────────────────────┴───────────────────────────────┘');
  print('');
  print('  All controllers receive the same params.id and must');
  print('  call params.onPlatformViewCreated when ready.');
  print('');

  // ─── Section 11: ViewType Changes ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 11: What Happens When viewType Changes');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  If PlatformViewLink receives a new viewType:         │');
  print('  │                                                       │');
  print('  │  1. didUpdateWidget detects viewType changed          │');
  print('  │  2. Old controller is disposed                        │');
  print('  │  3. New PlatformViewCreationParams._() is created     │');
  print('  │     with a FRESH id from the registry                │');
  print('  │  4. onCreatePlatformView is called again with         │');
  print('  │     the new params                                   │');
  print('  │  5. New native view is created                        │');
  print('  │                                                       │');
  print('  │  The old native view is destroyed, the new one takes  │');
  print('  │  its place. IDs never collide because the registry    │');
  print('  │  always increments.                                   │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 12: Common Pitfalls ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 12: Common Pitfalls');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  1. Forgetting to call params.onPlatformViewCreated   │');
  print('  │     → Surface never appears, shows empty box          │');
  print('  │                                                       │');
  print('  │  2. Using wrong id for the controller                 │');
  print('  │     → Platform cannot find the view, crash            │');
  print('  │                                                       │');
  print('  │  3. Not forwarding onFocusChanged                     │');
  print('  │     → Flutter focus tree is out of sync               │');
  print('  │     → Keyboard events may route incorrectly           │');
  print('  │                                                       │');
  print('  │  4. Creating params manually (impossible — private    │');
  print('  │     constructor) — but if you try to subclass it,     │');
  print('  │     you lose the framework lifecycle guarantees.      │');
  print('  │                                                       │');
  print('  │  5. Not disposing the controller                      │');
  print('  │     → Native view leaks memory on the platform side   │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 13: Relationship Diagram ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 13: Relationship Diagram');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │                                                       │');
  print('  │  PlatformViewLink (StatefulWidget)                    │');
  print('  │    ├─ viewType: String                                │');
  print('  │    ├─ onCreatePlatformView:                           │');
  print('  │    │    (PlatformViewCreationParams) →                │');
  print('  │    │        PlatformViewController                    │');
  print('  │    └─ surfaceFactory:                                 │');
  print('  │         (BuildContext, PlatformViewController) →      │');
  print('  │             Widget                                    │');
  print('  │                                                       │');
  print('  │  PlatformViewCreationParams                           │');
  print('  │    ├─ id: int                                         │');
  print('  │    ├─ viewType: String                                │');
  print('  │    ├─ onPlatformViewCreated: (int) → void             │');
  print('  │    └─ onFocusChanged: (bool) → void                   │');
  print('  │                                                       │');
  print('  │  PlatformViewController (abstract)                    │');
  print('  │    ├─ viewId: int                                     │');
  print('  │    ├─ dispatchPointerEvent(PointerEvent)              │');
  print('  │    ├─ clearFocus()                                    │');
  print('  │    └─ dispose()                                       │');
  print('  │                                                       │');
  print('  │  PlatformViewSurface (LeafRenderObjectWidget)         │');
  print('  │    ├─ controller: PlatformViewController              │');
  print('  │    ├─ hitTestBehavior                                 │');
  print('  │    └─ gestureRecognizers                              │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 14: Live Demo ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 14: Live Visual Demo');
  print('═══════════════════════════════════════════════════════════');
  print('');

  Widget buildPropertyCard({
    required String name,
    required String type,
    required String purpose,
    required IconData icon,
    required Color cardColor,
    required Color iconBg,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: brown200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: brown900,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  type,
                  style: TextStyle(
                    color: orange800,
                    fontSize: 11,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  purpose,
                  style: TextStyle(
                    color: brown700,
                    fontSize: 12,
                    height: 1.3,
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
    backgroundColor: brown50,
    appBar: AppBar(
      title: const Text(
        'PlatformViewCreationParams — Demo',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
      backgroundColor: brown900,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Creation flow diagram ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [brown900, brown800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Creation Flow',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                ...[
                  {'step': '1', 'label': 'PlatformViewLink mounted', 'detail': 'initState() fires'},
                  {'step': '2', 'label': 'ID allocated', 'detail': 'platformViewsRegistry.getNextPlatformViewId()'},
                  {'step': '3', 'label': 'Params created', 'detail': 'PlatformViewCreationParams._(id, viewType, ...)'},
                  {'step': '4', 'label': 'Callback invoked', 'detail': 'onCreatePlatformView(params) → controller'},
                  {'step': '5', 'label': 'Native view created', 'detail': 'controller.create() → platform side'},
                  {'step': '6', 'label': 'Notify ready', 'detail': 'onPlatformViewCreated(id) → setState'},
                  {'step': '7', 'label': 'Surface rendered', 'detail': 'surfaceFactory(ctx, controller) → widget'},
                ].map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            color: orange300.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Center(
                            child: Text(
                              item['step']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['label']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                item['detail']!,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
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
            'Properties',
            style: TextStyle(
              color: brown900,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 8),
          buildPropertyCard(
            name: 'id',
            type: 'int',
            purpose: 'Unique view ID from platformViewsRegistry. Sequential, never reused.',
            icon: Icons.fingerprint,
            cardColor: Colors.white,
            iconBg: brown700,
          ),
          buildPropertyCard(
            name: 'viewType',
            type: 'String',
            purpose: 'Identifies the native view factory registered on the platform side.',
            icon: Icons.label,
            cardColor: Colors.white,
            iconBg: brown500,
          ),
          buildPropertyCard(
            name: 'onPlatformViewCreated',
            type: 'void Function(int)',
            purpose: 'Call when native view is ready. Triggers PlatformViewLink to show the surface.',
            icon: Icons.check_circle,
            cardColor: orange50,
            iconBg: orange800,
          ),
          buildPropertyCard(
            name: 'onFocusChanged',
            type: 'ValueChanged<bool>',
            purpose: 'Forward focus gain/loss from native view to Flutter focus tree.',
            icon: Icons.center_focus_strong,
            cardColor: orange50,
            iconBg: orange800,
          ),

          const SizedBox(height: 14),

          // ── Platform controllers comparison ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: brown200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Controller per Platform',
                  style: TextStyle(
                    color: brown900,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                ...[
                  {'platform': 'Android (VD)', 'controller': 'AndroidViewController', 'icon': Icons.phone_android},
                  {'platform': 'Android (HC)', 'controller': 'SurfaceAndroidViewController', 'icon': Icons.phone_android},
                  {'platform': 'iOS', 'controller': 'UiKitViewController', 'icon': Icons.phone_iphone},
                  {'platform': 'macOS', 'controller': 'AppKitViewController', 'icon': Icons.laptop_mac},
                  {'platform': 'Web', 'controller': 'HtmlElementView (no params)', 'icon': Icons.language},
                ].map((p) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Icon(p['icon'] as IconData, color: brown700, size: 16),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 90,
                          child: Text(
                            p['platform'] as String,
                            style: TextStyle(
                              color: brown900,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            p['controller'] as String,
                            style: TextStyle(
                              color: orange800,
                              fontFamily: 'monospace',
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
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

          const SizedBox(height: 14),

          // ── Pitfalls ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: orange50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: orange100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.warning_amber, color: orange800, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      'Common Pitfalls',
                      style: TextStyle(
                        color: brown900,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ...[
                  'Forgetting onPlatformViewCreated → empty box forever',
                  'Using wrong id → platform crash',
                  'Not forwarding onFocusChanged → broken keyboard input',
                  'Not disposing controller → native memory leak',
                ].asMap().entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${entry.key + 1}.',
                          style: TextStyle(
                            color: orange800,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            entry.value,
                            style: TextStyle(
                              color: brown700,
                              fontSize: 12,
                              height: 1.3,
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

  print('  Live widget built: PlatformViewCreationParams demo');
  print('  • 7-step creation flow diagram');
  print('  • 4 property cards with icons and types');
  print('  • Platform controllers comparison (5 entries)');
  print('  • Common pitfalls warning panel');
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
  print('  │  1. Parameter object — bundles data for view creation │');
  print('  │  2. Private constructor — only framework creates it  │');
  print('  │  3. id — unique from platformViewsRegistry           │');
  print('  │  4. viewType — matches registered native factory     │');
  print('  │  5. onPlatformViewCreated — MUST call when ready     │');
  print('  │  6. onFocusChanged — bridges native/Flutter focus    │');
  print('  │  7. Created in PlatformViewLink.initState()          │');
  print('  │  8. Recreated on viewType change (new ID allocated)   │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  print('  Demo colors used:');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Brown 900  ${brown900.toARGB32().toRadixString(16).padLeft(8, "0")}  Deep');
  print('  │  Brown 800  ${brown800.toARGB32().toRadixString(16).padLeft(8, "0")}  Dark');
  print('  │  Brown 700  ${brown700.toARGB32().toRadixString(16).padLeft(8, "0")}  Primary');
  print('  │  Brown 500  ${brown500.toARGB32().toRadixString(16).padLeft(8, "0")}  Secondary');
  print('  │  Orange 800 ${orange800.toARGB32().toRadixString(16).padLeft(8, "0")}  Warm');
  print('  │  Orange 300 ${orange300.toARGB32().toRadixString(16).padLeft(8, "0")}  Accent');
  print('  │  Brown 200  ${brown200.toARGB32().toRadixString(16).padLeft(8, "0")}  Muted');
  print('  │  Orange 100 ${orange100.toARGB32().toRadixString(16).padLeft(8, "0")}  Highlight');
  print('  │  Orange 50  ${orange50.toARGB32().toRadixString(16).padLeft(8, "0")}  Surface');
  print('  │  Brown 50   ${brown50.toARGB32().toRadixString(16).padLeft(8, "0")}  Light');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  print('████████████████████████████████████████████████████████████');
  print('██  PlatformViewCreationParams — Demo Complete            ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  return demo;
}
