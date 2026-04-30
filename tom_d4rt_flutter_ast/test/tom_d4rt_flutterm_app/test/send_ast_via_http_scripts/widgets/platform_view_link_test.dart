// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// PlatformViewLink — Complete Deep Dive
///
/// Palette: Slate / Charcoal (cool grays with blue undertone)
/// Primary:   Color(0xFF37474F) — Blue Grey 800
/// Secondary: Color(0xFF455A64) — Blue Grey 700
/// Accent:    Color(0xFF42A5F5) — Blue 400
/// Surface:   Color(0xFFECEFF1) — Blue Grey 50
/// Deep:      Color(0xFF263238) — Blue Grey 900
/// Muted:     Color(0xFFB0BEC5) — Blue Grey 200
/// Warm:      Color(0xFF1565C0) — Blue 800
/// Highlight: Color(0xFFCFD8DC) — Blue Grey 100
/// Light:     Color(0xFFF5F5F5) — Grey 100
/// Dark:      Color(0xFF546E7A) — Blue Grey 600

dynamic build(BuildContext context) {
  // ─── Section 1: Title Banner ───
  print('');
  print('████████████████████████████████████████████████████████████');
  print('██                                                      ██');
  print('██   PlatformViewLink — Deep Dive                        ██');
  print('██   Embedding native platform views in Flutter           ██');
  print('██                                                      ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  const blueGrey800 = Color(0xFF37474F);
  const blueGrey700 = Color(0xFF455A64);
  const blue400 = Color(0xFF42A5F5);
  const blueGrey50 = Color(0xFFECEFF1);
  const blueGrey900 = Color(0xFF263238);
  const blueGrey200 = Color(0xFFB0BEC5);
  const blue800 = Color(0xFF1565C0);
  const blueGrey100 = Color(0xFFCFD8DC);
  const grey100 = Color(0xFFF5F5F5);
  const blueGrey600 = Color(0xFF546E7A);

  // ─── Section 2: What Is PlatformViewLink? ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 2: What Is PlatformViewLink?');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  The central widget for embedding native platform views');
  print('  (Android Views, iOS UIViews, etc.) into a Flutter app.');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  PlatformViewLink coordinates three things:           │');
  print('  │                                                       │');
  print('  │  1. Creates the native platform view                  │');
  print('  │     → via onCreatePlatformView callback               │');
  print('  │                                                       │');
  print('  │  2. Allocates a unique platform view ID               │');
  print('  │     → from platformViewsRegistry                      │');
  print('  │                                                       │');
  print('  │  3. Renders the compositor surface                    │');
  print('  │     → via surfaceFactory callback                     │');
  print('  │                                                       │');
  print('  │  It is a StatefulWidget with a complex state that     │');
  print('  │  manages the full lifecycle of native view creation,  │');
  print('  │  focus bridging, and disposal.                        │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 3: Class Definition ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 3: Class Definition');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  class PlatformViewLink extends StatefulWidget {      │');
  print('  │                                                       │');
  print('  │    PlatformViewLink({                                 │');
  print('  │      required this.surfaceFactory,                    │');
  print('  │      required this.onCreatePlatformView,              │');
  print('  │      required this.viewType,                          │');
  print('  │      super.key,                                       │');
  print('  │    });                                                │');
  print('  │                                                       │');
  print('  │    final PlatformViewSurfaceFactory surfaceFactory;   │');
  print('  │    final CreatePlatformViewCallback                   │');
  print('  │        onCreatePlatformView;                          │');
  print('  │    final String viewType;                             │');
  print('  │  }                                                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');
  print('  Three required parameters — no optional ones.');
  print('');

  // ─── Section 4: Type Aliases ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 4: Type Aliases');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  typedef CreatePlatformViewCallback =                 │');
  print('  │    PlatformViewController Function(                   │');
  print('  │      PlatformViewCreationParams params,               │');
  print('  │    );                                                 │');
  print('  │                                                       │');
  print('  │  typedef PlatformViewSurfaceFactory =                 │');
  print('  │    Widget Function(                                   │');
  print('  │      BuildContext context,                             │');
  print('  │      PlatformViewController controller,               │');
  print('  │    );                                                 │');
  print('  │                                                       │');
  print('  │  typedef PlatformViewCreatedCallback =                │');
  print('  │    void Function(int id);                             │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 5: State Machine ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 5: _PlatformViewLinkState');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  class _PlatformViewLinkState                         │');
  print('  │      extends State<PlatformViewLink> {                │');
  print('  │                                                       │');
  print('  │    Fields:                                            │');
  print('  │    • _id: int?                                        │');
  print('  │    • _controller: PlatformViewController?             │');
  print('  │    • _platformViewCreated: bool = false               │');
  print('  │    • _focusNode: FocusNode?                           │');
  print('  │                                                       │');
  print('  │    Important methods:                                 │');
  print('  │    • initState() — allocates ID, creates params,      │');
  print('  │      calls onCreatePlatformView, starts controller    │');
  print('  │    • didUpdateWidget() — detects viewType change,     │');
  print('  │      recreates everything if needed                   │');
  print('  │    • build() — returns placeholder or surface         │');
  print('  │    • dispose() — disposes controller and focus node   │');
  print('  │    • _onPlatformViewCreated(id) — marks ready         │');
  print('  │    • _handlePlatformFocusChanged(bool) — focus bridge │');
  print('  │  }                                                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 6: Lifecycle walkthrough ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 6: Complete Lifecycle Walkthrough');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Phase 1: INITIALIZATION                              │');
  print('  │  ─────────────────────                                │');
  print('  │  initState() {                                        │');
  print('  │    _id = platformViewsRegistry                        │');
  print('  │           .getNextPlatformViewId();                   │');
  print('  │    params = PlatformViewCreationParams._(             │');
  print('  │      id: _id,                                         │');
  print('  │      viewType: widget.viewType,                       │');
  print('  │      onPlatformViewCreated: _onPlatformViewCreated,   │');
  print('  │      onFocusChanged: _handlePlatformFocusChanged,     │');
  print('  │    );                                                 │');
  print('  │    _controller = widget.onCreatePlatformView(params); │');
  print('  │  }                                                    │');
  print('  │                                                       │');
  print('  │  Phase 2: PENDING (native view creating)              │');
  print('  │  ─────────────────────────────────                    │');
  print('  │  build() {                                            │');
  print('  │    if (!_platformViewCreated)                          │');
  print('  │      return SizedBox.expand();  // placeholder        │');
  print('  │  }                                                    │');
  print('  │                                                       │');
  print('  │  Phase 3: READY (native view created)                 │');
  print('  │  ────────────────────────────────                     │');
  print('  │  _onPlatformViewCreated(int id) {                     │');
  print('  │    setState(() => _platformViewCreated = true);       │');
  print('  │  }                                                    │');
  print('  │  build() {                                            │');
  print('  │    // Now shows the surface:                          │');
  print('  │    return Focus(                                      │');
  print('  │      focusNode: _focusNode,                           │');
  print('  │      onFocusChange: _handleFrameworkFocusChanged,     │');
  print('  │      child: widget.surfaceFactory(context, _ctrl!),   │');
  print('  │    );                                                 │');
  print('  │  }                                                    │');
  print('  │                                                       │');
  print('  │  Phase 4: DISPOSAL                                    │');
  print('  │  ──────────────────                                   │');
  print('  │  dispose() {                                          │');
  print('  │    _controller?.dispose();                            │');
  print('  │    _focusNode?.dispose();                             │');
  print('  │    super.dispose();                                   │');
  print('  │  }                                                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 7: Focus Bridging ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 7: Focus Bridging');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  The native view and Flutter have separate focus      │');
  print('  │  systems. PlatformViewLink bridges them:              │');
  print('  │                                                       │');
  print('  │  Native → Flutter:                                    │');
  print('  │  ─────────────────                                    │');
  print('  │  When native view gains focus:                        │');
  print('  │    onFocusChanged(true) → _handlePlatformFocusChanged │');
  print('  │    → _focusNode.requestFocus()                        │');
  print('  │    → Flutter widget tree knows this view has focus    │');
  print('  │                                                       │');
  print('  │  Flutter → Native:                                    │');
  print('  │  ─────────────────                                    │');
  print('  │  When Flutter moves focus away:                       │');
  print('  │    Focus.onFocusChange(false)                         │');
  print('  │    → _handleFrameworkFocusChanged                     │');
  print('  │    → controller.clearFocus()                          │');
  print('  │    → Native view releases focus                       │');
  print('  │                                                       │');
  print('  │  This two-way bridge ensures keyboard events route    │');
  print('  │  correctly between Flutter widgets and native views.  │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 8: viewType Changes ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 8: Handling viewType Changes');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  When the parent rebuilds PlatformViewLink with a     │');
  print('  │  different viewType:                                  │');
  print('  │                                                       │');
  print('  │  didUpdateWidget(oldWidget) {                         │');
  print('  │    if (widget.viewType != oldWidget.viewType) {       │');
  print('  │      // 1. Dispose old controller                     │');
  print('  │      _controller?.dispose();                          │');
  print('  │      // 2. Reset state                                │');
  print('  │      _platformViewCreated = false;                    │');
  print('  │      // 3. Allocate new ID                            │');
  print('  │      _id = platformViewsRegistry...;                  │');
  print('  │      // 4. Create new params + controller             │');
  print('  │      _controller = widget.onCreatePlatformView(       │');
  print('  │        PlatformViewCreationParams._( ... new id )     │');
  print('  │      );                                               │');
  print('  │    }                                                  │');
  print('  │  }                                                    │');
  print('  │                                                       │');
  print('  │  The old native view is fully destroyed, the new      │');
  print('  │  one starts fresh. No state bleeds across changes.    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 9: Build Method Logic ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 9: Build Method — Two States');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  build(BuildContext context) {                         │');
  print('  │    if (_controller == null) {                          │');
  print('  │      return const SizedBox.expand();                  │');
  print('  │      // ↑ Placeholder while native view is creating  │');
  print('  │    }                                                  │');
  print('  │                                                       │');
  print('  │    if (!_platformViewCreated) {                        │');
  print('  │      return const SizedBox.expand();                  │');
  print('  │      // ↑ Still waiting for platform callback         │');
  print('  │    }                                                  │');
  print('  │                                                       │');
  print('  │    return Focus(                                      │');
  print('  │      focusNode: _focusNode,                           │');
  print('  │      onFocusChange: _handleFrameworkFocusChanged,     │');
  print('  │      child: widget.surfaceFactory(                    │');
  print('  │        context, _controller!),                        │');
  print('  │    );                                                 │');
  print('  │    // ↑ Surface widget with focus wrapping            │');
  print('  │  }                                                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 10: Android Example ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 10: Android Usage Example');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  PlatformViewLink(                                    │');
  print('  │    viewType: "my-webview",                            │');
  print('  │    onCreatePlatformView:                              │');
  print('  │      (PlatformViewCreationParams params) {            │');
  print('  │        return PlatformViewsService                    │');
  print('  │          .initSurfaceAndroidView(                     │');
  print('  │            id: params.id,                             │');
  print('  │            viewType: params.viewType,                 │');
  print('  │            layoutDirection: TextDirection.ltr,         │');
  print('  │            creationParams: {"url": "https://..."},    │');
  print('  │            creationParamsCodec:                        │');
  print('  │              const StandardMessageCodec(),            │');
  print('  │          )                                            │');
  print('  │          ..addOnPlatformViewCreatedListener(          │');
  print('  │            params.onPlatformViewCreated,              │');
  print('  │          )                                            │');
  print('  │          ..create();                                  │');
  print('  │      },                                               │');
  print('  │    surfaceFactory:                                    │');
  print('  │      (BuildContext ctx, PlatformViewController ctrl) {│');
  print('  │        return PlatformViewSurface(                    │');
  print('  │          controller: ctrl,                            │');
  print('  │          hitTestBehavior:                              │');
  print('  │            PlatformViewHitTestBehavior.opaque,        │');
  print('  │          gestureRecognizers: const <Factory<          │');
  print('  │              OneSequenceGestureRecognizer>>{},         │');
  print('  │        );                                             │');
  print('  │      },                                               │');
  print('  │  )                                                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 11: iOS Example ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 11: iOS Usage Example');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  PlatformViewLink(                                    │');
  print('  │    viewType: "my-mapview",                            │');
  print('  │    onCreatePlatformView:                              │');
  print('  │      (PlatformViewCreationParams params) {            │');
  print('  │        return PlatformViewsService                    │');
  print('  │          .initUiKitView(                              │');
  print('  │            id: params.id,                             │');
  print('  │            viewType: params.viewType,                 │');
  print('  │            layoutDirection: TextDirection.ltr,         │');
  print('  │            onFocus: () {                              │');
  print('  │              params.onFocusChanged(true);             │');
  print('  │            },                                         │');
  print('  │          )                                            │');
  print('  │          ..addOnPlatformViewCreatedListener(          │');
  print('  │            params.onPlatformViewCreated,              │');
  print('  │          )                                            │');
  print('  │          ..create();                                  │');
  print('  │      },                                               │');
  print('  │    surfaceFactory:                                    │');
  print('  │      (BuildContext ctx, PlatformViewController ctrl) {│');
  print('  │        return PlatformViewSurface(                    │');
  print('  │          controller: ctrl,                            │');
  print('  │          hitTestBehavior:                              │');
  print('  │            PlatformViewHitTestBehavior.opaque,        │');
  print('  │          gestureRecognizers: const <Factory<          │');
  print('  │              OneSequenceGestureRecognizer>>{},         │');
  print('  │        );                                             │');
  print('  │      },                                               │');
  print('  │  )                                                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 12: AndroidView vs PlatformViewLink ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 12: AndroidView vs PlatformViewLink');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌───────────────────────┬──────────────────────────────┐');
  print('  │  AndroidView           │ PlatformViewLink             │');
  print('  ├───────────────────────┼──────────────────────────────┤');
  print('  │  High-level widget     │ Low-level building block     │');
  print('  │  Uses Virtual Display  │ You choose the mode          │');
  print('  │  No surface control    │ Full surface control         │');
  print('  │  Simpler API           │ More flexible API            │');
  print('  │  Auto-creates the      │ You supply callbacks for     │');
  print('  │  controller & surface  │ controller and surface       │');
  print('  │  One rendering mode    │ Works with any controller    │');
  print('  │  Good for simple use   │ Good for advanced/custom     │');
  print('  └───────────────────────┴──────────────────────────────┘');
  print('');
  print('  AndroidView internally uses PlatformViewLink.');
  print('  UiKitView internally uses PlatformViewLink.');
  print('  HtmlElementView does NOT use PlatformViewLink on web.');
  print('');

  // ─── Section 13: Common Use Cases ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 13: Common Use Cases');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  • WebView (Android/iOS native WebView)               │');
  print('  │  • Google Maps (native map view)                      │');
  print('  │  • Video players (native media player)                │');
  print('  │  • Ad SDKs (native ad rendering)                      │');
  print('  │  • Camera preview (native camera surface)             │');
  print('  │  • PDF viewers (native PDF rendering)                 │');
  print('  │  • Custom native UI components                        │');
  print('  │                                                       │');
  print('  │  Any scenario where you need native platform          │');
  print('  │  rendering inside a Flutter widget tree.              │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 14: Live Demo ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 14: Live Visual Demo');
  print('═══════════════════════════════════════════════════════════');
  print('');

  Widget buildPhaseCard({
    required int number,
    required String title,
    required String detail,
    required IconData icon,
    required bool active,
    required Color accentColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: active ? accentColor.withValues(alpha: 0.08) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: active ? accentColor : blueGrey200,
          width: active ? 1.5 : 1.0,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: active ? accentColor : blueGrey200,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                '$number',
                style: TextStyle(
                  color: active ? Colors.white : blueGrey800,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Icon(icon, color: active ? accentColor : blueGrey600, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: blueGrey900,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
                Text(
                  detail,
                  style: TextStyle(
                    color: blueGrey600,
                    fontSize: 11,
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
    backgroundColor: grey100,
    appBar: AppBar(
      title: const Text(
        'PlatformViewLink — Demo',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
      backgroundColor: blueGrey900,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Widget anatomy ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [blueGrey900, blueGrey800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'PlatformViewLink Anatomy',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                ...[
                  {'label': 'viewType', 'type': 'String', 'desc': 'Identifies the native view'},
                  {'label': 'onCreatePlatformView', 'type': 'Callback', 'desc': 'Creates and returns controller'},
                  {'label': 'surfaceFactory', 'type': 'Factory', 'desc': 'Creates surface widget for rendering'},
                ].asMap().entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: blue400.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            entry.value['label']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                entry.value['type']!,
                                style: TextStyle(
                                  color: blue400,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                entry.value['desc']!,
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

          // ── Lifecycle phases ──
          Text(
            'Lifecycle Phases',
            style: TextStyle(
              color: blueGrey900,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 8),
          buildPhaseCard(
            number: 1,
            title: 'Initialization',
            detail: 'Allocate ID, create params, call onCreatePlatformView',
            icon: Icons.play_arrow,
            active: true,
            accentColor: blue800,
          ),
          buildPhaseCard(
            number: 2,
            title: 'Pending',
            detail: 'SizedBox.expand() placeholder while native view creates',
            icon: Icons.hourglass_top,
            active: false,
            accentColor: blue800,
          ),
          buildPhaseCard(
            number: 3,
            title: 'Ready',
            detail: 'onPlatformViewCreated fires → surface widget renders',
            icon: Icons.check_circle,
            active: true,
            accentColor: Color(0xFF43A047),
          ),
          buildPhaseCard(
            number: 4,
            title: 'Disposal',
            detail: 'Controller disposed, focus node disposed',
            icon: Icons.delete_outline,
            active: false,
            accentColor: Color(0xFFE53935),
          ),

          const SizedBox(height: 14),

          // ── Focus bridging ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: blueGrey50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: blueGrey100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.swap_horiz, color: blue800, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      'Two-Way Focus Bridge',
                      style: TextStyle(
                        color: blueGrey900,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: blue400),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.phone_android, color: blueGrey800, size: 24),
                            const SizedBox(height: 4),
                            Text(
                              'Native',
                              style: TextStyle(
                                color: blueGrey900,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'onFocusChanged',
                              style: TextStyle(
                                color: blue800,
                                fontSize: 10,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Column(
                        children: [
                          Icon(Icons.arrow_forward, color: blue800, size: 16),
                          const SizedBox(height: 2),
                          Icon(Icons.arrow_back, color: blueGrey600, size: 16),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: blue400),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.widgets, color: blueGrey800, size: 24),
                            const SizedBox(height: 4),
                            Text(
                              'Flutter',
                              style: TextStyle(
                                color: blueGrey900,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'clearFocus()',
                              style: TextStyle(
                                color: blue800,
                                fontSize: 10,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // ── AndroidView vs PlatformViewLink ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: blueGrey200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AndroidView vs PlatformViewLink',
                  style: TextStyle(
                    color: blueGrey900,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                ...[
                  {'aspect': 'Level', 'av': 'High-level', 'pvl': 'Low-level'},
                  {'aspect': 'Control', 'av': 'Limited', 'pvl': 'Full'},
                  {'aspect': 'Surface', 'av': 'Auto', 'pvl': 'Custom'},
                  {'aspect': 'Mode', 'av': 'Virtual Display', 'pvl': 'Any'},
                  {'aspect': 'Use case', 'av': 'Simple', 'pvl': 'Advanced'},
                ].map((row) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 70,
                          child: Text(
                            row['aspect']!,
                            style: TextStyle(
                              color: blueGrey600,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                            decoration: BoxDecoration(
                              color: blueGrey50,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              row['av']!,
                              style: TextStyle(
                                color: blueGrey800,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                            decoration: BoxDecoration(
                              color: blue400.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              row['pvl']!,
                              style: TextStyle(
                                color: blue800,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
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

  print('  Live widget built: PlatformViewLink demo');
  print('  • Widget anatomy (3 parameters)');
  print('  • 4 lifecycle phase cards');
  print('  • Two-way focus bridge diagram');
  print('  • AndroidView vs PlatformViewLink comparison');
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
  print('  │  1. StatefulWidget for embedding native views        │');
  print('  │  2. Three required params: viewType, create, surface │');
  print('  │  3. Allocates unique ID from platformViewsRegistry   │');
  print('  │  4. Shows SizedBox.expand() until native view ready  │');
  print('  │  5. Focus bridge: native ↔ Flutter via Focus widget  │');
  print('  │  6. Recreates everything on viewType change          │');
  print('  │  7. AndroidView/UiKitView are built on top of it     │');
  print('  │  8. Disposes controller and focus node on unmount    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  print('  Demo colors used:');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  BlueGrey 900 ${blueGrey900.toARGB32().toRadixString(16).padLeft(8, "0")}  Deep');
  print('  │  BlueGrey 800 ${blueGrey800.toARGB32().toRadixString(16).padLeft(8, "0")}  Primary');
  print('  │  BlueGrey 700 ${blueGrey700.toARGB32().toRadixString(16).padLeft(8, "0")}  Secondary');
  print('  │  BlueGrey 600 ${blueGrey600.toARGB32().toRadixString(16).padLeft(8, "0")}  Dark');
  print('  │  Blue 800     ${blue800.toARGB32().toRadixString(16).padLeft(8, "0")}  Warm');
  print('  │  Blue 400     ${blue400.toARGB32().toRadixString(16).padLeft(8, "0")}  Accent');
  print('  │  BlueGrey 200 ${blueGrey200.toARGB32().toRadixString(16).padLeft(8, "0")}  Muted');
  print('  │  BlueGrey 100 ${blueGrey100.toARGB32().toRadixString(16).padLeft(8, "0")}  Highlight');
  print('  │  BlueGrey 50  ${blueGrey50.toARGB32().toRadixString(16).padLeft(8, "0")}  Surface');
  print('  │  Grey 100     ${grey100.toARGB32().toRadixString(16).padLeft(8, "0")}  Light');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  print('████████████████████████████████████████████████████████████');
  print('██  PlatformViewLink — Demo Complete                      ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  return demo;
}
