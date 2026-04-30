// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// PopupWindow — Complete Deep Dive
///
/// Palette: Amber / Honey (warm golden tones)
/// Primary:   Color(0xFFFF8F00) — Amber 800
/// Secondary: Color(0xFFFFA000) — Amber 700
/// Accent:    Color(0xFFFFCA28) — Amber 400
/// Surface:   Color(0xFFFFF8E1) — Amber 50
/// Deep:      Color(0xFFE65100) — Orange 900
/// Muted:     Color(0xFFFFE082) — Amber 200
/// Warm:      Color(0xFFFF6F00) — Amber 900
/// Highlight: Color(0xFFFFECB3) — Amber 100
/// Light:     Color(0xFFFFFDE7) — Yellow 50
/// Dark:      Color(0xFF4E342E) — Brown 800

dynamic build(BuildContext context) {
  // ─── Section 1: Title Banner ───
  print('');
  print('████████████████████████████████████████████████████████████');
  print('██                                                      ██');
  print('██   PopupWindow — Deep Dive                              ██');
  print('██   Render Flutter widgets into native popup windows     ██');
  print('██                                                      ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  const amber800 = Color(0xFFFF8F00);
  const amber700 = Color(0xFFFFA000);
  const amber400 = Color(0xFFFFCA28);
  const amber50 = Color(0xFFFFF8E1);
  const orange900 = Color(0xFFE65100);
  const amber200 = Color(0xFFFFE082);
  const amber900 = Color(0xFFFF6F00);
  const amber100 = Color(0xFFFFECB3);
  const yellow50 = Color(0xFFFFFDE7);
  const brown800 = Color(0xFF4E342E);

  // ─── Section 2: What Is PopupWindow? ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 2: What Is PopupWindow?');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  An @internal StatelessWidget that renders a Flutter');
  print('  widget tree into a native popup window managed by a');
  print('  PopupWindowController.');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  @internal                                            │');
  print('  │  class PopupWindow extends StatelessWidget {          │');
  print('  │    const PopupWindow({                                │');
  print('  │      super.key,                                       │');
  print('  │      required this.controller,                        │');
  print('  │      required this.child,                             │');
  print('  │    });                                                │');
  print('  │                                                       │');
  print('  │    final PopupWindowController controller;            │');
  print('  │    final Widget child;                                │');
  print('  │                                                       │');
  print('  │    @override                                          │');
  print('  │    Widget build(BuildContext context) {                │');
  print('  │      return ListenableBuilder(                        │');
  print('  │        listenable: controller,                        │');
  print('  │        builder: (context, child) {                    │');
  print('  │          return WindowScope(                          │');
  print('  │            controller: controller,                    │');
  print('  │            child: View(                               │');
  print('  │              view: controller.rootView,               │');
  print('  │              child: child,                            │');
  print('  │            ),                                         │');
  print('  │          );                                           │');
  print('  │        },                                             │');
  print('  │        child: child,                                  │');
  print('  │      );                                               │');
  print('  │    }                                                  │');
  print('  │  }                                                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 3: The Build Pipeline ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 3: The Build Pipeline (3 Layers)');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Layer 1: ListenableBuilder                           │');
  print('  │  ─────────────────────────                            │');
  print('  │  Wraps the controller (a ChangeNotifier).             │');
  print('  │  Rebuilds everything below when controller changes.  │');
  print('  │  Uses the builder pattern to avoid unnecessary        │');
  print('  │  rebuilds of the child widget tree.                   │');
  print('  │                                                       │');
  print('  │  Layer 2: WindowScope                                 │');
  print('  │  ───────────────────                                  │');
  print('  │  An InheritedWidget that propagates the controller   │');
  print('  │  down the tree. Descendants can access the window     │');
  print('  │  controller via WindowScope.of(context).              │');
  print('  │                                                       │');
  print('  │  Layer 3: View                                        │');
  print('  │  ──────────                                           │');
  print('  │  Renders the child widget tree into the controller\'s │');
  print('  │  rootView (a FlutterView). This is what creates the  │');
  print('  │  separate render tree for the popup window.           │');
  print('  │  Each View gets its own BuildOwner, RenderView, etc. │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 4: Why StatelessWidget? ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 4: Why StatelessWidget?');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  PopupWindow has no internal state:                   │');
  print('  │                                                       │');
  print('  │  • All state lives in PopupWindowController           │');
  print('  │  • Controller is a ChangeNotifier → ListenableBuilder │');
  print('  │    handles rebuilds                                   │');
  print('  │  • The widget is just wiring:                         │');
  print('  │    controller → ListenableBuilder → WindowScope → View│');
  print('  │                                                       │');
  print('  │  Compare: RegularWindow is also a StatelessWidget    │');
  print('  │  for the same reason — the controller owns the state,│');
  print('  │  the widget just connects the pieces.                 │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 5: View Widget ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 5: The View Widget — Separate Render Tree');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  View(view: controller.rootView, child: child)       │');
  print('  │                                                       │');
  print('  │  The View widget creates a SEPARATE render tree:      │');
  print('  │                                                       │');
  print('  │  Main window:                                         │');
  print('  │  ┌────────────────────────────────┐                   │');
  print('  │  │  RenderView #1                  │                   │');
  print('  │  │  └─ RenderObject tree           │                   │');
  print('  │  │     └─ your main app widgets    │                   │');
  print('  │  └────────────────────────────────┘                   │');
  print('  │                                                       │');
  print('  │  Popup window:                                        │');
  print('  │  ┌────────────────────────────────┐                   │');
  print('  │  │  RenderView #2 (via View)       │                   │');
  print('  │  │  └─ RenderObject tree           │                   │');
  print('  │  │     └─ your popup child widgets │                   │');
  print('  │  └────────────────────────────────┘                   │');
  print('  │                                                       │');
  print('  │  Each has its own layout, painting, compositing.      │');
  print('  │  They share the same WidgetsBinding but have          │');
  print('  │  independent rendering pipelines.                     │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 6: WindowScope InheritedWidget ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 6: WindowScope — Access the Controller');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  WindowScope is an InheritedWidget:                   │');
  print('  │                                                       │');
  print('  │  class WindowScope extends InheritedWidget {          │');
  print('  │    final BaseWindowController controller;             │');
  print('  │    static BaseWindowController of(BuildContext ctx);  │');
  print('  │  }                                                    │');
  print('  │                                                       │');
  print('  │  Inside the popup\'s widget tree, any widget can:     │');
  print('  │    final controller = WindowScope.of(context);        │');
  print('  │                                                       │');
  print('  │  This returns the PopupWindowController. Useful for:  │');
  print('  │  • Querying contentSize                               │');
  print('  │  • Responding to controller changes                   │');
  print('  │  • Determining which window you\'re in                │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 7: Comparison with RegularWindow ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 7: PopupWindow vs RegularWindow');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────┬──────────────────────────────┐');
  print('  │  PopupWindow          │ RegularWindow                 │');
  print('  ├──────────────────────┼──────────────────────────────┤');
  print('  │  Takes PopupWindow-   │ Takes RegularWindow-          │');
  print('  │  Controller           │ Controller                    │');
  print('  ├──────────────────────┼──────────────────────────────┤');
  print('  │  No title bar, no     │ Has title, minimize,          │');
  print('  │  minimize, no resize  │ fullscreen, resize            │');
  print('  ├──────────────────────┼──────────────────────────────┤');
  print('  │  Anchored to parent   │ Independent top-level window  │');
  print('  ├──────────────────────┼──────────────────────────────┤');
  print('  │  ListenableBuilder →  │ ListenableBuilder →           │');
  print('  │  WindowScope → View   │ WindowScope → View            │');
  print('  ├──────────────────────┼──────────────────────────────┤');
  print('  │  Same build pattern   │ Same build pattern            │');
  print('  │  (identical structure)│ (identical structure)         │');
  print('  └──────────────────────┴──────────────────────────────┘');
  print('');

  // ─── Section 8: Error Handling ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 8: Error Handling');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  PopupWindow itself doesn\'t throw, but:              │');
  print('  │                                                       │');
  print('  │  The controller it wraps enforces:                    │');
  print('  │                                                       │');
  print('  │  if (!isWindowingEnabled) {                           │');
  print('  │    throw UnsupportedError(                            │');
  print('  │      \'Windowing is not enabled\'                      │');
  print('  │    );                                                 │');
  print('  │  }                                                    │');
  print('  │                                                       │');
  print('  │  This means you can never create a PopupWindow       │');
  print('  │  on a platform where windowing is disabled,           │');
  print('  │  because you can\'t create the controller first.     │');
  print('  │                                                       │');
  print('  │  The widget is safe — it just renders what the        │');
  print('  │  controller provides. The guard is at construction.  │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 9: Usage Pattern ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 9: Usage Pattern (Conceptual)');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  // In a parent window\'s widget:                     │');
  print('  │                                                       │');
  print('  │  // 1. Create controller                              │');
  print('  │  final popupCtl = PopupWindowController(              │');
  print('  │    parent: parentWindowController,                    │');
  print('  │    anchorRect: buttonRect,                            │');
  print('  │    delegate: myDelegate,                              │');
  print('  │  );                                                   │');
  print('  │                                                       │');
  print('  │  // 2. Activate (creates native window)               │');
  print('  │  popupCtl.activate();                                 │');
  print('  │                                                       │');
  print('  │  // 3. Build the popup widget tree                    │');
  print('  │  PopupWindow(                                         │');
  print('  │    controller: popupCtl,                              │');
  print('  │    child: Card(                                       │');
  print('  │      child: ListView(                                 │');
  print('  │        children: [                                    │');
  print('  │          ListTile(title: Text(\'Option A\')),          │');
  print('  │          ListTile(title: Text(\'Option B\')),          │');
  print('  │        ],                                             │');
  print('  │      ),                                               │');
  print('  │    ),                                                 │');
  print('  │  );                                                   │');
  print('  │                                                       │');
  print('  │  // 4. Later, destroy                                 │');
  print('  │  popupCtl.destroy();                                  │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 10: Multiple Render Trees ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 10: Multiple Render Trees Explained');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Flutter historically had ONE render tree per app.    │');
  print('  │                                                       │');
  print('  │  Multi-window changes this:                           │');
  print('  │                                                       │');
  print('  │  WidgetsBinding (single)                              │');
  print('  │  ├─ View #1 (main window)                             │');
  print('  │  │   └─ RenderView → render tree #1                   │');
  print('  │  │       └─ main app content                          │');
  print('  │  ├─ View #2 (popup window)                            │');
  print('  │  │   └─ RenderView → render tree #2                   │');
  print('  │  │       └─ popup child content                       │');
  print('  │  └─ View #3 (another popup)                           │');
  print('  │       └─ RenderView → render tree #3                  │');
  print('  │           └─ third popup content                      │');
  print('  │                                                       │');
  print('  │  All share one WidgetsBinding/event loop but have     │');
  print('  │  independent layout/paint/composite passes.           │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 11: Where It Lives in _window.dart ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 11: Source Code Context');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  File: packages/flutter/lib/src/widgets/_window.dart  │');
  print('  │  Line: ~1288                                          │');
  print('  │                                                       │');
  print('  │  All window classes in the same file:                 │');
  print('  │  ┌────────────────────────────────────────┐           │');
  print('  │  │  BaseWindowController (sealed)          │           │');
  print('  │  │  RegularWindowController                │           │');
  print('  │  │  RegularWindowControllerDelegate        │           │');
  print('  │  │  PopupWindowController                  │           │');
  print('  │  │  PopupWindowControllerDelegate          │           │');
  print('  │  │  PopupWindow ← this class (line 1288)   │           │');
  print('  │  │  RegularWindow                          │           │');
  print('  │  │  WindowScope (InheritedWidget)          │           │');
  print('  │  └────────────────────────────────────────┘           │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 12: Live Demo ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 12: Live Visual Demo');
  print('═══════════════════════════════════════════════════════════');
  print('');

  Widget buildLayerCard({
    required int layer,
    required String name,
    required String role,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 2),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.15), blurRadius: 6)],
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '$layer',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: brown800,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    fontFamily: 'monospace',
                  ),
                ),
                Text(
                  role,
                  style: TextStyle(color: color, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final demo = Scaffold(
    backgroundColor: yellow50,
    appBar: AppBar(
      title: const Text(
        'PopupWindow — Demo',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
      backgroundColor: orange900,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Build pipeline ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [orange900, amber900],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'PopupWindow.build() Pipeline',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '3 nested widgets that connect controller to native window',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 12),
                ...[
                  {'name': 'ListenableBuilder', 'desc': 'Rebuilds on controller changes'},
                  {'name': 'WindowScope', 'desc': 'Propagates controller via InheritedWidget'},
                  {'name': 'View', 'desc': 'Renders child into controller.rootView'},
                ].asMap().entries.map((entry) {
                  final i = entry.key;
                  final item = entry.value;
                  return Padding(
                    padding: EdgeInsets.only(left: i * 16.0, bottom: 4),
                    child: Row(
                      children: [
                        Text(
                          '${i > 0 ? "└─ " : ""}${item['name']}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            fontFamily: 'monospace',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            item['desc']!,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
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

          const SizedBox(height: 14),

          // ── 3-layer build ──
          Text(
            'The 3-Layer Build',
            style: TextStyle(
              color: orange900,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 8),
          buildLayerCard(
            layer: 1,
            name: 'ListenableBuilder',
            role: 'Watches controller (ChangeNotifier), triggers rebuilds',
            color: amber900,
            icon: Icons.hearing,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Icon(Icons.arrow_downward, color: amber700, size: 16),
          ),
          const SizedBox(height: 2),
          buildLayerCard(
            layer: 2,
            name: 'WindowScope',
            role: 'InheritedWidget — children access controller via of()',
            color: amber800,
            icon: Icons.account_tree,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Icon(Icons.arrow_downward, color: amber700, size: 16),
          ),
          const SizedBox(height: 2),
          buildLayerCard(
            layer: 3,
            name: 'View',
            role: 'Renders child into controller.rootView (native window)',
            color: orange900,
            icon: Icons.window,
          ),

          const SizedBox(height: 14),

          // ── Render tree diagram ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: amber50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: amber100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.account_tree_outlined, color: orange900, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      'Multiple Render Trees',
                      style: TextStyle(
                        color: orange900,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: amber800, width: 2),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.desktop_windows, color: amber800, size: 24),
                            const SizedBox(height: 4),
                            Text(
                              'Main Window',
                              style: TextStyle(
                                color: amber800,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'RenderView #1\nRenderObject tree\nApp content',
                              style: TextStyle(color: brown800, fontSize: 10, height: 1.3),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: amber400, width: 2),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.picture_in_picture, color: amber400, size: 24),
                            const SizedBox(height: 4),
                            Text(
                              'Popup Window',
                              style: TextStyle(
                                color: amber800,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'RenderView #2\nRenderObject tree\nPopup content',
                              style: TextStyle(color: brown800, fontSize: 10, height: 1.3),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: amber200),
                  ),
                  child: Text(
                    'Shared: WidgetsBinding, event loop, scheduler\nSeparate: layout, paint, composite per render tree',
                    style: TextStyle(color: brown800, fontSize: 11, height: 1.3),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // ── PopupWindow vs RegularWindow ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: amber200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PopupWindow vs RegularWindow',
                  style: TextStyle(
                    color: orange900,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                ...[
                  {'aspect': 'Controller type', 'popup': 'PopupWindowCtl', 'regular': 'RegularWindowCtl'},
                  {'aspect': 'Build pattern', 'popup': 'Identical', 'regular': 'Identical'},
                  {'aspect': 'Title bar', 'popup': 'None', 'regular': 'Platform title bar'},
                  {'aspect': 'Position', 'popup': 'Anchored to parent', 'regular': 'Independent'},
                  {'aspect': 'Minimize/Full', 'popup': 'No', 'regular': 'Yes'},
                ].map((row) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 90,
                          child: Text(
                            row['aspect']!,
                            style: TextStyle(
                              color: brown800,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: amber50,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              row['popup']!,
                              style: TextStyle(color: amber800, fontSize: 11),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Color(0xFFE3F2FD),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              row['regular']!,
                              style: TextStyle(color: Color(0xFF1565C0), fontSize: 11),
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

  print('  Live widget built: PopupWindow demo');
  print('  • 3-layer build pipeline (ListenableBuilder → WindowScope → View)');
  print('  • Layer detail cards with numbered progression');
  print('  • Multiple render trees diagram (main vs popup)');
  print('  • PopupWindow vs RegularWindow comparison (5 aspects)');
  print('');

  // ─── Section 13: ListenableBuilder Deep Dive ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 13: Why ListenableBuilder (not AnimatedBuilder)');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  ListenableBuilder was introduced to replace the      │');
  print('  │  common pattern of using AnimatedBuilder with a       │');
  print('  │  non-animation Listenable.                            │');
  print('  │                                                       │');
  print('  │  AnimatedBuilder:                                     │');
  print('  │  • Also takes a Listenable (animation parameter)     │');
  print('  │  • Designed for Animation objects                     │');
  print('  │  • Semantically misleading for ChangeNotifier         │');
  print('  │                                                       │');
  print('  │  ListenableBuilder:                                   │');
  print('  │  • Takes any Listenable (listenable parameter)        │');
  print('  │  • Clearer intent: "rebuild when this changes"        │');
  print('  │  • Same underlying mechanism                          │');
  print('  │  • Used throughout the windowing code                 │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 14: How the Child is Preserved ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 14: Child Widget Preservation Pattern');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  ListenableBuilder(                                   │');
  print('  │    listenable: controller,                            │');
  print('  │    builder: (context, child) {                        │');
  print('  │      return WindowScope(                              │');
  print('  │        controller: controller,                        │');
  print('  │        child: View(                                   │');
  print('  │          view: controller.rootView,                   │');
  print('  │          child: child,   // ← preserved from below   │');
  print('  │        ),                                             │');
  print('  │      );                                               │');
  print('  │    },                                                 │');
  print('  │    child: child,  // ← PopupWindow\'s "child" param  │');
  print('  │  )                                                    │');
  print('  │                                                       │');
  print('  │  The outer "child" is passed to the builder as a     │');
  print('  │  parameter. It\'s NOT rebuilt when the controller     │');
  print('  │  notifies — only WindowScope + View are rebuilt.      │');
  print('  │  This is a key performance optimization.              │');
  print('  └──────────────────────────────────────────────────────┘');
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
  print('  │  1. @internal StatelessWidget (not public API)       │');
  print('  │  2. Takes controller (PopupWindowController) + child │');
  print('  │  3. Build: ListenableBuilder → WindowScope → View    │');
  print('  │  4. View creates separate render tree via rootView   │');
  print('  │  5. WindowScope provides controller to descendants   │');
  print('  │  6. ListenableBuilder auto-rebuilds on changes       │');
  print('  │  7. child parameter is preserved (not rebuilt)        │');
  print('  │  8. Identical pattern to RegularWindow               │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  print('  Demo colors used:');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Orange 900  ${orange900.toARGB32().toRadixString(16).padLeft(8, "0")}  Deep');
  print('  │  Amber 900   ${amber900.toARGB32().toRadixString(16).padLeft(8, "0")}  Warm');
  print('  │  Amber 800   ${amber800.toARGB32().toRadixString(16).padLeft(8, "0")}  Primary');
  print('  │  Amber 700   ${amber700.toARGB32().toRadixString(16).padLeft(8, "0")}  Secondary');
  print('  │  Amber 400   ${amber400.toARGB32().toRadixString(16).padLeft(8, "0")}  Accent');
  print('  │  Amber 200   ${amber200.toARGB32().toRadixString(16).padLeft(8, "0")}  Muted');
  print('  │  Amber 100   ${amber100.toARGB32().toRadixString(16).padLeft(8, "0")}  Highlight');
  print('  │  Amber 50    ${amber50.toARGB32().toRadixString(16).padLeft(8, "0")}  Surface');
  print('  │  Yellow 50   ${yellow50.toARGB32().toRadixString(16).padLeft(8, "0")}  Light');
  print('  │  Brown 800   ${brown800.toARGB32().toRadixString(16).padLeft(8, "0")}  Dark');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  print('████████████████████████████████████████████████████████████');
  print('██  PopupWindow — Demo Complete                           ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  return demo;
}
