// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// PopupWindowController — Complete Deep Dive
///
/// Palette: Forest / Emerald (deep greens)
/// Primary:   Color(0xFF1B5E20) — Green 900
/// Secondary: Color(0xFF2E7D32) — Green 800
/// Accent:    Color(0xFF66BB6A) — Green 400
/// Surface:   Color(0xFFE8F5E9) — Green 50
/// Deep:      Color(0xFF0D3B0D) — custom forest
/// Muted:     Color(0xFFA5D6A7) — Green 200
/// Warm:      Color(0xFF388E3C) — Green 700
/// Highlight: Color(0xFFC8E6C9) — Green 100
/// Light:     Color(0xFFF1F8E9) — Light Green 50
/// Dark:      Color(0xFF004D40) — Teal 900

dynamic build(BuildContext context) {
  // ─── Section 1: Title Banner ───
  print('');
  print('████████████████████████████████████████████████████████████');
  print('██                                                      ██');
  print('██   PopupWindowController — Deep Dive                    ██');
  print('██   Manage native popup windows in Flutter               ██');
  print('██                                                      ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  const green900 = Color(0xFF1B5E20);
  const green800 = Color(0xFF2E7D32);
  const green400 = Color(0xFF66BB6A);
  const green50 = Color(0xFFE8F5E9);
  const forest = Color(0xFF0D3B0D);
  const green200 = Color(0xFFA5D6A7);
  const green700 = Color(0xFF388E3C);
  const green100 = Color(0xFFC8E6C9);
  const lightGreen50 = Color(0xFFF1F8E9);
  const teal900 = Color(0xFF004D40);

  // ─── Section 2: What Is PopupWindowController? ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 2: What Is PopupWindowController?');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  An @internal abstract class that manages native popup');
  print('  windows on desktop platforms. It extends');
  print('  BaseWindowController (which extends ChangeNotifier)');
  print('  and provides the API for creating, activating, resizing,');
  print('  and destroying popup windows.');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  @internal                                            │');
  print('  │  abstract class PopupWindowController                 │');
  print('  │      extends BaseWindowController {                   │');
  print('  │                                                       │');
  print('  │    factory PopupWindowController({                    │');
  print('  │      required RegularWindowController parent,         │');
  print('  │      required Rect anchorRect,                        │');
  print('  │      PopupWindowPositioner positioner,                │');
  print('  │      BoxConstraints? preferredConstraints,            │');
  print('  │      PopupWindowControllerDelegate delegate,          │');
  print('  │    });                                                │');
  print('  │                                                       │');
  print('  │    RegularWindowController get parent;                │');
  print('  │    bool get isActivated;                              │');
  print('  │    void activate();                                   │');
  print('  │    void setConstraints(BoxConstraints);               │');
  print('  │    void destroy();                                    │');
  print('  │  }                                                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 3: Class Hierarchy ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 3: Class Hierarchy');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  ChangeNotifier                                       │');
  print('  │  └─ BaseWindowController (sealed)                     │');
  print('  │      ├─ RegularWindowController                       │');
  print('  │      │   (main/top-level windows)                     │');
  print('  │      │   ├─ title, size, isFullscreen, isMinimized   │');
  print('  │      │   └─ setFullscreen(), minimize(), restore()    │');
  print('  │      │                                                │');
  print('  │      └─ PopupWindowController  ← THIS CLASS           │');
  print('  │          (auxiliary popup windows)                     │');
  print('  │          ├─ parent, isActivated                       │');
  print('  │          ├─ activate(), setConstraints(), destroy()   │');
  print('  │          └─ takes PopupWindowControllerDelegate       │');
  print('  │                                                       │');
  print('  │  Both share from BaseWindowController:                │');
  print('  │    • contentSize (Size)                               │');
  print('  │    • rootView (FlutterView)                           │');
  print('  │    • notifyListeners() from ChangeNotifier            │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 4: Factory Constructor ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 4: Factory Constructor Parameters');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────┬──────────────────────────────┐');
  print('  │  Parameter            │ Purpose                       │');
  print('  ├──────────────────────┼──────────────────────────────┤');
  print('  │  parent (required)    │ The RegularWindowController   │');
  print('  │                       │ that owns this popup.         │');
  print('  │                       │ Popup appears relative to it │');
  print('  ├──────────────────────┼──────────────────────────────┤');
  print('  │  anchorRect (required)│ Rectangle in parent\'s coords │');
  print('  │                       │ where the popup anchors.      │');
  print('  │                       │ Popup positioned relative    │');
  print('  │                       │ to this rect                  │');
  print('  ├──────────────────────┼──────────────────────────────┤');
  print('  │  positioner           │ PopupWindowPositioner that    │');
  print('  │                       │ calculates final position.    │');
  print('  │                       │ e.g. centerOnAnchor,          │');
  print('  │                       │ belowAnchor, etc.             │');
  print('  ├──────────────────────┼──────────────────────────────┤');
  print('  │  preferredConstraints│ Optional BoxConstraints for    │');
  print('  │                       │ initial popup size hints.     │');
  print('  │                       │ Platform may adjust           │');
  print('  ├──────────────────────┼──────────────────────────────┤');
  print('  │  delegate             │ PopupWindowController-        │');
  print('  │                       │ Delegate for lifecycle events │');
  print('  │                       │ (onWindowDestroyed)           │');
  print('  └──────────────────────┴──────────────────────────────┘');
  print('');

  // ─── Section 5: Parent-Child Relationship ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 5: Parent-Child Window Relationship');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │                                                       │');
  print('  │  ┌─────────────────────────────────┐                  │');
  print('  │  │  RegularWindowController (parent)│                  │');
  print('  │  │  ┌─────────────────────────────┤                  │');
  print('  │  │  │  Main App Window              │                  │');
  print('  │  │  │  ┌───────────────────────┐   │                  │');
  print('  │  │  │  │ anchorRect            │   │                  │');
  print('  │  │  │  │ (the thing the popup  │   │                  │');
  print('  │  │  │  │  anchors to)          │   │                  │');
  print('  │  │  │  └───────────┬───────────┘   │                  │');
  print('  │  │  │              │               │                  │');
  print('  │  │  └──────────────┼───────────────┘                  │');
  print('  │  └─────────────────┼─────────────────┘                │');
  print('  │                    ▼                                   │');
  print('  │      ┌───────────────────────────┐                    │');
  print('  │      │ PopupWindowController      │                    │');
  print('  │      │ (popup window)             │                    │');
  print('  │      │ Positioned by positioner   │                    │');
  print('  │      └───────────────────────────┘                    │');
  print('  │                                                       │');
  print('  │  The popup is always a child of a regular window.    │');
  print('  │  When the parent is destroyed, the popup is too.     │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 6: Activation Lifecycle ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 6: activate() / destroy() Lifecycle');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  ┌────────────┐   activate()   ┌────────────────┐    │');
  print('  │  │  Created    │ ──────────── → │  Activated      │    │');
  print('  │  │  (inactive) │               │  (visible)       │    │');
  print('  │  └────────────┘               │  Native window   │    │');
  print('  │                                │  exists on screen│    │');
  print('  │                                └───────┬──────────┘    │');
  print('  │                                        │               │');
  print('  │                                destroy() / user close │');
  print('  │                                        │               │');
  print('  │                                        ▼               │');
  print('  │                                ┌────────────────┐     │');
  print('  │                                │  Destroyed      │     │');
  print('  │                                │  delegate       │     │');
  print('  │                                │  .onWindowDest- │     │');
  print('  │                                │   royed()       │     │');
  print('  │                                └────────────────┘     │');
  print('  │                                                       │');
  print('  │  isActivated is true only between activate() and      │');
  print('  │  destroy(). After destroy(), the controller should    │');
  print('  │  be discarded (do not reactivate).                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 7: setConstraints ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 7: setConstraints() — Dynamic Resizing');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  void setConstraints(BoxConstraints constraints)      │');
  print('  │                                                       │');
  print('  │  Changes the popup window\'s size constraints after   │');
  print('  │  creation. Useful for:                                │');
  print('  │                                                       │');
  print('  │  • Content-dependent sizing (popup grows as content  │');
  print('  │    loads)                                             │');
  print('  │  • Responsive popups that adapt to different anchors  │');
  print('  │  • Animated size changes                              │');
  print('  │                                                       │');
  print('  │  Note: This calls notifyListeners() internally,      │');
  print('  │  triggering a rebuild of any widgets listening to     │');
  print('  │  the controller.                                      │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 8: Comparison with Dialog/Overlay ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 8: Popup Window vs Dialog vs Overlay');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────┬───────────┬──────────┬───────────┐');
  print('  │  Feature          │ PopupWC   │ Dialog   │ Overlay   │');
  print('  ├──────────────────┼───────────┼──────────┼───────────┤');
  print('  │  Native window?   │ Yes       │ No       │ No        │');
  print('  │  Can escape app   │ Yes       │ No       │ No        │');
  print('  │  bounds?           │           │          │           │');
  print('  │  Own render tree?  │ Yes       │ Shared   │ Shared    │');
  print('  │  Platform          │ Desktop   │ All      │ All       │');
  print('  │  Modal?            │ No        │ Usually  │ No        │');
  print('  │  Z-order           │ OS level  │ Widget   │ Widget    │');
  print('  │  Stability          │ Experi-   │ Stable   │ Stable    │');
  print('  │                    │ mental    │          │           │');
  print('  └──────────────────┴───────────┴──────────┴───────────┘');
  print('');

  // ─── Section 9: rootView and contentSize ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 9: rootView and contentSize (from BaseWindow)');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Inherited from BaseWindowController:                 │');
  print('  │                                                       │');
  print('  │  FlutterView get rootView                             │');
  print('  │  ─────────────────────                                │');
  print('  │  The native view backing the popup window.            │');
  print('  │  Used by PopupWindow widget:                          │');
  print('  │    View(view: controller.rootView, child: child)     │');
  print('  │  This creates a separate render tree for the popup.   │');
  print('  │                                                       │');
  print('  │  Size get contentSize                                 │');
  print('  │  ────────────────────                                 │');
  print('  │  The current size of the popup\'s content area.       │');
  print('  │  Updated when the platform resizes the window         │');
  print('  │  (e.g. due to setConstraints or screen changes).     │');
  print('  │  Notifies listeners when changed.                     │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 10: Common Popup Scenarios ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 10: Common Popup Scenarios (Future Use Cases)');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  When multi-window is stable, popups could be:        │');
  print('  │                                                       │');
  print('  │  • Tooltip-like panels that escape the app bounds     │');
  print('  │  • Detachable tool palettes (like Photoshop)          │');
  print('  │  • Auto-complete dropdowns that overflow the window   │');
  print('  │  • Context menus rendered as native windows           │');
  print('  │  • Color picker panels anchored to a button           │');
  print('  │  • Chat popup windows from a main app                 │');
  print('  │                                                       │');
  print('  │  Key advantage over Overlay:                          │');
  print('  │  The popup can extend BEYOND the parent window bounds │');
  print('  │  — something an Overlay entry can never do.           │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 11: PopupWindowPositioner ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 11: PopupWindowPositioner');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  The positioner parameter controls where the popup   │');
  print('  │  appears relative to the anchorRect:                  │');
  print('  │                                                       │');
  print('  │  ┌────────────────────┐                               │');
  print('  │  │  anchorRect        │                               │');
  print('  │  │  (button/tooltip)  │                               │');
  print('  │  └────────┬───────────┘                               │');
  print('  │           │                                           │');
  print('  │           ▼ positioner decides                        │');
  print('  │  ┌────────────────────┐                               │');
  print('  │  │  Popup Window      │                               │');
  print('  │  │  (positioned here) │                               │');
  print('  │  └────────────────────┘                               │');
  print('  │                                                       │');
  print('  │  Built-in positioners:                                │');
  print('  │  • centerOnAnchor — centers popup on the rect        │');
  print('  │  • belowAnchor — places popup below the rect         │');
  print('  │  • Custom — implement PopupWindowPositioner           │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 12: Live Demo ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 12: Live Visual Demo');
  print('═══════════════════════════════════════════════════════════');
  print('');

  Widget buildPropRow({
    required String property,
    required String type,
    required String desc,
    required Color accent,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: green100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4, height: 32,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      property,
                      style: TextStyle(
                        color: forest,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: green50,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        type,
                        style: TextStyle(
                          color: green700,
                          fontSize: 10,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  desc,
                  style: TextStyle(color: green800, fontSize: 11),
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
        'PopupWindowController — Demo',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
      backgroundColor: forest,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Factory constructor card ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [forest, green900],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Factory Constructor',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                ...[
                  {'param': 'parent', 'type': 'RegularWindowController', 'required': true},
                  {'param': 'anchorRect', 'type': 'Rect', 'required': true},
                  {'param': 'positioner', 'type': 'PopupWindowPositioner', 'required': false},
                  {'param': 'preferredConstraints', 'type': 'BoxConstraints?', 'required': false},
                  {'param': 'delegate', 'type': 'PopupWindowControllerDelegate', 'required': false},
                ].map((p) {
                  final req = p['required'] as bool;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 56,
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: req ? green400.withValues(alpha: 0.4) : Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              req ? 'required' : 'optional',
                              style: TextStyle(
                                color: req ? Colors.white : Colors.white.withValues(alpha: 0.6),
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${p['param']}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            fontFamily: 'monospace',
                          ),
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            '(${p['type']})',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 11,
                              fontFamily: 'monospace',
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

          // ── API surface ──
          Text(
            'API Surface',
            style: TextStyle(
              color: forest,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 8),
          buildPropRow(
            property: 'parent',
            type: 'RegularWindowController',
            desc: 'The parent window that owns this popup',
            accent: green900,
          ),
          buildPropRow(
            property: 'isActivated',
            type: 'bool',
            desc: 'True after activate(), false after destroy()',
            accent: green800,
          ),
          buildPropRow(
            property: 'activate()',
            type: 'void',
            desc: 'Creates the native window and makes it visible',
            accent: green700,
          ),
          buildPropRow(
            property: 'setConstraints()',
            type: 'void',
            desc: 'Updates popup size constraints dynamically',
            accent: green400,
          ),
          buildPropRow(
            property: 'destroy()',
            type: 'void',
            desc: 'Closes the native window, notifies delegate',
            accent: Color(0xFFE53935),
          ),
          buildPropRow(
            property: 'contentSize',
            type: 'Size',
            desc: 'Current content area size (from BaseWindowController)',
            accent: teal900,
          ),
          buildPropRow(
            property: 'rootView',
            type: 'FlutterView',
            desc: 'The backing native view (from BaseWindowController)',
            accent: teal900,
          ),

          const SizedBox(height: 14),

          // ── Parent-child diagram ──
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
                  'Parent-Child Window Model',
                  style: TextStyle(
                    color: forest,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),
                // Parent window
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: green800, width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.desktop_windows, color: green900, size: 16),
                          const SizedBox(width: 6),
                          Text(
                            'RegularWindowController (Parent)',
                            style: TextStyle(
                              color: green900,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Anchor rect
                      Container(
                        width: 120,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFF9C4),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Color(0xFFFDD835), width: 1),
                        ),
                        child: Text(
                          'anchorRect',
                          style: TextStyle(
                            color: Color(0xFFF57F17),
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Icon(Icons.south, color: green700, size: 16),
                      const SizedBox(height: 4),
                      // Popup window
                      Container(
                        width: 200,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: green50,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: green400, width: 2),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.picture_in_picture, color: green700, size: 14),
                            const SizedBox(width: 6),
                            Text(
                              'PopupWindowController',
                              style: TextStyle(
                                color: green900,
                                fontWeight: FontWeight.w700,
                                fontSize: 11,
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
          ),

          const SizedBox(height: 14),

          // ── Comparison table ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: green200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PopupWindow vs Dialog vs Overlay',
                  style: TextStyle(
                    color: forest,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                ...[
                  {'feature': 'Native window', 'popup': true, 'dialog': false, 'overlay': false},
                  {'feature': 'Escapes bounds', 'popup': true, 'dialog': false, 'overlay': false},
                  {'feature': 'Own render tree', 'popup': true, 'dialog': false, 'overlay': false},
                  {'feature': 'All platforms', 'popup': false, 'dialog': true, 'overlay': true},
                  {'feature': 'Stable API', 'popup': false, 'dialog': true, 'overlay': true},
                ].map((row) {
                  Widget check(bool val) => Icon(
                    val ? Icons.check_circle : Icons.cancel_outlined,
                    color: val ? Color(0xFF43A047) : Color(0xFFBDBDBD),
                    size: 14,
                  );
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            row['feature'] as String,
                            style: TextStyle(color: green900, fontSize: 12),
                          ),
                        ),
                        SizedBox(width: 50, child: Center(child: check(row['popup'] as bool))),
                        SizedBox(width: 50, child: Center(child: check(row['dialog'] as bool))),
                        SizedBox(width: 50, child: Center(child: check(row['overlay'] as bool))),
                      ],
                    ),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      const SizedBox(width: 120),
                      SizedBox(
                        width: 50,
                        child: Center(child: Text('Popup', style: TextStyle(color: green700, fontSize: 10, fontWeight: FontWeight.w700))),
                      ),
                      SizedBox(
                        width: 50,
                        child: Center(child: Text('Dialog', style: TextStyle(color: green700, fontSize: 10, fontWeight: FontWeight.w700))),
                      ),
                      SizedBox(
                        width: 50,
                        child: Center(child: Text('Overlay', style: TextStyle(color: green700, fontSize: 10, fontWeight: FontWeight.w700))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  print('  Live widget built: PopupWindowController demo');
  print('  • Factory constructor (5 params with required/optional)');
  print('  • API surface (7 properties/methods)');
  print('  • Parent-child window model diagram');
  print('  • Popup vs Dialog vs Overlay comparison (5 features)');
  print('');

  // ─── Section 13: ChangeNotifier Integration ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 13: ChangeNotifier Integration');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  PopupWindowController extends BaseWindowController   │');
  print('  │  which extends ChangeNotifier.                        │');
  print('  │                                                       │');
  print('  │  What notifies listeners:                             │');
  print('  │  • contentSize changes                                │');
  print('  │  • setConstraints() is called                         │');
  print('  │  • Internal state transitions                         │');
  print('  │                                                       │');
  print('  │  The PopupWindow widget uses ListenableBuilder:       │');
  print('  │    ListenableBuilder(                                 │');
  print('  │      listenable: controller,                          │');
  print('  │      builder: (context, child) => WindowScope(        │');
  print('  │        controller: controller,                        │');
  print('  │        child: View(                                   │');
  print('  │          view: controller.rootView,                   │');
  print('  │          child: child,                                │');
  print('  │        ),                                             │');
  print('  │      ),                                               │');
  print('  │    )                                                  │');
  print('  │                                                       │');
  print('  │  So any controller change automatically rebuilds      │');
  print('  │  the popup\'s widget tree.                             │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 14: Platform Considerations ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 14: Platform Considerations');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────┬──────────────────────────────┐');
  print('  │  Platform             │ Popup Window Support          │');
  print('  ├──────────────────────┼──────────────────────────────┤');
  print('  │  macOS                │ In development (primary)      │');
  print('  │  Windows              │ In development                │');
  print('  │  Linux                │ Planned (X11/Wayland)         │');
  print('  │  Android / iOS        │ N/A (single window model)     │');
  print('  │  Web                  │ Limited (no true OS windows)  │');
  print('  ├──────────────────────┼──────────────────────────────┤');
  print('  │  All platforms        │ Throws UnsupportedError if    │');
  print('  │                       │ isWindowingEnabled is false   │');
  print('  └──────────────────────┴──────────────────────────────┘');
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
  print('  │  1. @internal abstract class (not public API)        │');
  print('  │  2. Extends BaseWindowController (ChangeNotifier)    │');
  print('  │  3. Factory: parent, anchorRect, positioner, etc.    │');
  print('  │  4. Lifecycle: create → activate → [use] → destroy   │');
  print('  │  5. Has isActivated, setConstraints, destroy APIs    │');
  print('  │  6. Takes PopupWindowControllerDelegate for events   │');
  print('  │  7. Can overflow parent window (unlike Dialog)       │');
  print('  │  8. Desktop-only, behind isWindowingEnabled flag     │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  print('  Demo colors used:');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Forest      ${forest.toARGB32().toRadixString(16).padLeft(8, "0")}  Deep');
  print('  │  Green 900   ${green900.toARGB32().toRadixString(16).padLeft(8, "0")}  Primary');
  print('  │  Green 800   ${green800.toARGB32().toRadixString(16).padLeft(8, "0")}  Secondary');
  print('  │  Green 700   ${green700.toARGB32().toRadixString(16).padLeft(8, "0")}  Warm');
  print('  │  Green 400   ${green400.toARGB32().toRadixString(16).padLeft(8, "0")}  Accent');
  print('  │  Green 200   ${green200.toARGB32().toRadixString(16).padLeft(8, "0")}  Muted');
  print('  │  Green 100   ${green100.toARGB32().toRadixString(16).padLeft(8, "0")}  Highlight');
  print('  │  Green 50    ${green50.toARGB32().toRadixString(16).padLeft(8, "0")}  Surface');
  print('  │  LtGreen 50  ${lightGreen50.toARGB32().toRadixString(16).padLeft(8, "0")}  Light');
  print('  │  Teal 900    ${teal900.toARGB32().toRadixString(16).padLeft(8, "0")}  Dark');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  print('████████████████████████████████████████████████████████████');
  print('██  PopupWindowController — Demo Complete                 ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  return demo;
}
