// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// PopupWindowControllerDelegate — Complete Deep Dive
///
/// Palette: Indigo / Violet (deep blue-purples)
/// Primary:   Color(0xFF283593) — Indigo 800
/// Secondary: Color(0xFF3949AB) — Indigo 600
/// Accent:    Color(0xFF7986CB) — Indigo 300
/// Surface:   Color(0xFFE8EAF6) — Indigo 50
/// Deep:      Color(0xFF1A237E) — Indigo 900
/// Muted:     Color(0xFF9FA8DA) — Indigo 200
/// Warm:      Color(0xFF303F9F) — Indigo 700
/// Highlight: Color(0xFFC5CAE9) — Indigo 100
/// Light:     Color(0xFFF3E5F5) — Purple 50
/// Dark:      Color(0xFF0D47A1) — Blue 900

dynamic build(BuildContext context) {
  // ─── Section 1: Title Banner ───
  print('');
  print('████████████████████████████████████████████████████████████');
  print('██                                                      ██');
  print('██   PopupWindowControllerDelegate — Deep Dive            ██');
  print('██   Internal delegate for popup window lifecycle         ██');
  print('██                                                      ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  const indigo800 = Color(0xFF283593);
  const indigo600 = Color(0xFF3949AB);
  const indigo300 = Color(0xFF7986CB);
  const indigo50 = Color(0xFFE8EAF6);
  const indigo900 = Color(0xFF1A237E);
  const indigo200 = Color(0xFF9FA8DA);
  const indigo700 = Color(0xFF303F9F);
  const indigo100 = Color(0xFFC5CAE9);
  const purple50 = Color(0xFFF3E5F5);
  const blue900 = Color(0xFF0D47A1);

  // ─── Section 2: What Is PopupWindowControllerDelegate? ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 2: What Is PopupWindowControllerDelegate?');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  An @internal mixin class that serves as the lifecycle');
  print('  delegate for popup windows in Flutter\'s experimental');
  print('  multi-window architecture.');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  @internal                                            │');
  print('  │  mixin class PopupWindowControllerDelegate {          │');
  print('  │    void onWindowDestroyed() {}                        │');
  print('  │  }                                                    │');
  print('  │                                                       │');
  print('  │  That\'s it — one method, empty default.              │');
  print('  │  But it\'s a critical hook in the windowing system.   │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 3: Why @internal? ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 3: Why @internal?');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  The @internal annotation means:                      │');
  print('  │                                                       │');
  print('  │  • Not part of Flutter\'s public API                  │');
  print('  │  • Can change or be removed without notice            │');
  print('  │  • Defined in _window.dart (underscore = private)     │');
  print('  │  • Only used by the framework itself                  │');
  print('  │  • Protected by the isWindowingEnabled feature flag   │');
  print('  │                                                       │');
  print('  │  You can study it, understand the architecture,       │');
  print('  │  but you should NOT directly instantiate or extend    │');
  print('  │  it in your application code.                         │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 4: The Windowing Architecture ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 4: The Multi-Window Architecture');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Flutter\'s experimental windowing system:            │');
  print('  │                                                       │');
  print('  │  ┌─────────────────────────────┐                      │');
  print('  │  │ WindowController (abstract)  │                      │');
  print('  │  │  ├─ BaseWindowController     │                      │');
  print('  │  │  │   (sealed, extends         │                      │');
  print('  │  │  │    ChangeNotifier)          │                      │');
  print('  │  │  │   ├─ RegularWindowController│                     │');
  print('  │  │  │   └─ PopupWindowController  │                     │');
  print('  │  │  │       ↓ takes a             │                      │');
  print('  │  │  │   PopupWindowController-     │                     │');
  print('  │  │  │       Delegate              │                      │');
  print('  │  │  └─────────────────────────────│                     │');
  print('  │  └─────────────────────────────┘                      │');
  print('  │                                                       │');
  print('  │  Each window type has its own controller.             │');
  print('  │  PopupWindowController receives a delegate so it      │');
  print('  │  can notify about lifecycle events.                   │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 5: Delegate Pattern Explained ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 5: The Delegate Pattern in Flutter Windowing');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  The delegate pattern separates:                      │');
  print('  │                                                       │');
  print('  │  Controller (PopupWindowController)                   │');
  print('  │  ├─ Manages the native window                         │');
  print('  │  ├─ Activates / destroys the window                   │');
  print('  │  ├─ Handles constraints and positioning               │');
  print('  │  └─ Notifies delegate about events                    │');
  print('  │                                                       │');
  print('  │  Delegate (PopupWindowControllerDelegate)            │');
  print('  │  ├─ Responds to lifecycle events                      │');
  print('  │  ├─ onWindowDestroyed() — cleanup                     │');
  print('  │  └─ Can be extended for more events in future         │');
  print('  │                                                       │');
  print('  │  This is the same pattern used elsewhere in Flutter:  │');
  print('  │  • RouterDelegate — builds routes                     │');
  print('  │  • ScrollActivityDelegate — handles scrolling         │');
  print('  │  • SliverChildDelegate — builds slivers               │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 6: onWindowDestroyed ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 6: onWindowDestroyed() Method');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  void onWindowDestroyed() {}                          │');
  print('  │                                                       │');
  print('  │  Called when:                                          │');
  print('  │  • The popup window is closed by the user             │');
  print('  │  • The native window is destroyed by the platform     │');
  print('  │  • controller.destroy() is called programmatically    │');
  print('  │                                                       │');
  print('  │  Use for:                                             │');
  print('  │  • Cleaning up resources tied to the popup            │');
  print('  │  • Updating parent window state                       │');
  print('  │  • Removing references to the destroyed controller    │');
  print('  │  • Logging or analytics                               │');
  print('  │                                                       │');
  print('  │  Default: empty body (no-op).                         │');
  print('  │  Override to add your cleanup logic.                  │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 7: isWindowingEnabled Guard ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 7: The isWindowingEnabled Feature Flag');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  All windowing APIs are behind a feature flag:        │');
  print('  │                                                       │');
  print('  │    if (!isWindowingEnabled) {                         │');
  print('  │      throw UnsupportedError(                          │');
  print('  │        \'Windowing is not enabled\'                    │');
  print('  │      );                                               │');
  print('  │    }                                                  │');
  print('  │                                                       │');
  print('  │  Currently disabled by default on all platforms.      │');
  print('  │  Must be explicitly enabled in the engine.            │');
  print('  │                                                       │');
  print('  │  What happens when disabled:                          │');
  print('  │  • PopupWindowController.new() → UnsupportedError     │');
  print('  │  • RegularWindowController.new() → UnsupportedError  │');
  print('  │  • The delegate class itself can be instantiated      │');
  print('  │    (it\'s a simple mixin class with no guards)        │');
  print('  │  • But it\'s useless without a controller             │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 8: Relationship to RegularWindowControllerDelegate ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 8: Popup vs Regular Window Delegates');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────┬──────────────────────────────┐');
  print('  │  Popup Delegate       │ Regular Delegate              │');
  print('  ├──────────────────────┼──────────────────────────────┤');
  print('  │  PopupWindowController│ RegularWindowController       │');
  print('  │  Delegate             │ Delegate                      │');
  print('  ├──────────────────────┼──────────────────────────────┤');
  print('  │  onWindowDestroyed()  │ onWindowDestroyed()           │');
  print('  │                       │ onWindowFocusChanged(bool)    │');
  print('  │                       │ onWindowFullscreenChanged()   │');
  print('  │                       │ onWindowMinimizedChanged()    │');
  print('  ├──────────────────────┼──────────────────────────────┤');
  print('  │  Simpler — popups     │ Richer — main windows have   │');
  print('  │  just appear and      │ focus, fullscreen, minimize  │');
  print('  │  disappear            │ states to track              │');
  print('  └──────────────────────┴──────────────────────────────┘');
  print('');

  // ─── Section 9: Lifecycle Flow ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 9: Popup Window Lifecycle');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  1. Parent requests a popup:                          │');
  print('  │     final controller = PopupWindowController(         │');
  print('  │       parent: parentController,                       │');
  print('  │       anchorRect: Rect.fromLTWH(100, 200, 0, 0),    │');
  print('  │       positioner: PopupWindowPositioner.centerOnAnchor│');
  print('  │       delegate: myDelegate,                           │');
  print('  │     );                                                │');
  print('  │                                                       │');
  print('  │  2. Popup gets activated:                             │');
  print('  │     controller.activate() → native window created     │');
  print('  │                                                       │');
  print('  │  3. Widget tree rendered in popup:                    │');
  print('  │     PopupWindow(controller: ctl, child: myWidget)    │');
  print('  │                                                       │');
  print('  │  4. User closes popup OR code calls destroy():        │');
  print('  │     controller.destroy()                              │');
  print('  │                                                       │');
  print('  │  5. Delegate notified:                                │');
  print('  │     delegate.onWindowDestroyed()                      │');
  print('  │     ← your cleanup logic runs here                   │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 10: Why Mixin Class? ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 10: Why "mixin class" (not abstract class)?');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Dart 3 introduced "mixin class":                     │');
  print('  │  • Can be used as both a mixin (with) and a class    │');
  print('  │  • Has a default constructor (no abstract members)    │');
  print('  │                                                       │');
  print('  │  "mixin class PopupWindowControllerDelegate"          │');
  print('  │                                                       │');
  print('  │  Used as a mixin:                                     │');
  print('  │    class MyWidget extends StatelessWidget             │');
  print('  │        with PopupWindowControllerDelegate { ... }     │');
  print('  │                                                       │');
  print('  │  Used as a class:                                     │');
  print('  │    class MyDelegate                                   │');
  print('  │        extends PopupWindowControllerDelegate { ... }  │');
  print('  │                                                       │');
  print('  │  Maximum flexibility for the framework to wire it    │');
  print('  │  into different class hierarchies.                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 11: Future Direction ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 11: Future Direction of Multi-Window');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  The multi-window API is experimental with:           │');
  print('  │                                                       │');
  print('  │  • Active development on macOS and Windows            │');
  print('  │  • Linux support planned                              │');
  print('  │  • Mobile platforms unlikely (single-window model)    │');
  print('  │  • Web may get limited support                        │');
  print('  │                                                       │');
  print('  │  When stable, PopupWindowControllerDelegate may:     │');
  print('  │  • Get more lifecycle methods                         │');
  print('  │  • Become public API (lose @internal)                 │');
  print('  │  • Gain events like onPopupFocused, onPopupResized   │');
  print('  │  • Follow the RegularWindowControllerDelegate model  │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 12: Live Demo ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 12: Live Visual Demo');
  print('═══════════════════════════════════════════════════════════');
  print('');

  Widget buildPhaseBox({
    required int step,
    required String title,
    required String desc,
    required IconData icon,
    required Color bg,
    required bool isActive,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isActive ? bg : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isActive ? bg : indigo200,
          width: isActive ? 2 : 1,
        ),
        boxShadow: isActive
            ? [BoxShadow(color: bg.withValues(alpha: 0.3), blurRadius: 6)]
            : [],
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: isActive ? Colors.white.withValues(alpha: 0.3) : indigo50,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                '$step',
                style: TextStyle(
                  color: isActive ? Colors.white : indigo800,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Icon(icon, color: isActive ? Colors.white : indigo600, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isActive ? Colors.white : blue900,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                Text(
                  desc,
                  style: TextStyle(
                    color: isActive ? Colors.white.withValues(alpha: 0.8) : indigo600,
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
    backgroundColor: purple50,
    appBar: AppBar(
      title: const Text(
        'PopupWindowControllerDelegate — Demo',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
      backgroundColor: indigo900,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Class hierarchy ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [indigo900, indigo700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Windowing Class Hierarchy',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                ...[
                  {'level': 0, 'name': 'ChangeNotifier', 'type': 'base'},
                  {'level': 1, 'name': 'BaseWindowController (sealed)', 'type': 'sealed'},
                  {'level': 2, 'name': 'RegularWindowController', 'type': 'regular'},
                  {'level': 2, 'name': 'PopupWindowController', 'type': 'popup'},
                  {'level': 3, 'name': 'takes: PopupWindowControllerDelegate', 'type': 'delegate'},
                ].map((node) {
                  final level = node['level'] as int;
                  final isTarget = node['type'] == 'delegate';
                  return Padding(
                    padding: EdgeInsets.only(left: level * 16.0, bottom: 4),
                    child: Row(
                      children: [
                        if (level > 0)
                          Text(
                            '└─ ',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 12,
                              fontFamily: 'monospace',
                            ),
                          ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: isTarget
                                ? indigo300.withValues(alpha: 0.4)
                                : Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                            border: isTarget
                                ? Border.all(color: indigo300, width: 1)
                                : null,
                          ),
                          child: Text(
                            node['name'] as String,
                            style: TextStyle(
                              color: isTarget ? Colors.white : Colors.white.withValues(alpha: 0.9),
                              fontWeight: isTarget ? FontWeight.w700 : FontWeight.w500,
                              fontSize: 12,
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

          // ── Lifecycle phases ──
          Text(
            'Popup Window Lifecycle',
            style: TextStyle(
              color: indigo900,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Delegate is notified at step 5 (window destroyed)',
            style: TextStyle(color: indigo600, fontSize: 12),
          ),
          const SizedBox(height: 8),
          buildPhaseBox(
            step: 1, title: 'Create Controller',
            desc: 'PopupWindowController(parent, anchorRect, delegate)',
            icon: Icons.add_box_outlined, bg: indigo800, isActive: false,
          ),
          buildPhaseBox(
            step: 2, title: 'Activate',
            desc: 'controller.activate() → native window created',
            icon: Icons.launch, bg: indigo800, isActive: false,
          ),
          buildPhaseBox(
            step: 3, title: 'Render Content',
            desc: 'PopupWindow(controller, child) builds widget tree',
            icon: Icons.widgets_outlined, bg: indigo800, isActive: false,
          ),
          buildPhaseBox(
            step: 4, title: 'Destroy',
            desc: 'controller.destroy() or user closes the popup',
            icon: Icons.close, bg: indigo800, isActive: false,
          ),
          buildPhaseBox(
            step: 5, title: 'Delegate Notified',
            desc: 'delegate.onWindowDestroyed() — your cleanup runs',
            icon: Icons.notifications_active, bg: indigo700, isActive: true,
          ),

          const SizedBox(height: 14),

          // ── Comparison table ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: indigo100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Popup vs Regular Delegate',
                  style: TextStyle(
                    color: indigo900,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: indigo50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: indigo200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Popup Delegate',
                              style: TextStyle(
                                color: indigo900,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'onWindowDestroyed()\n\n(simpler — popups\njust appear and\ndisappear)',
                              style: TextStyle(color: indigo700, fontSize: 11, height: 1.3),
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
                          color: purple50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: indigo200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Regular Delegate',
                              style: TextStyle(
                                color: indigo900,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'onWindowDestroyed()\nonWindowFocusChanged()\nonWindowFullscreen...()\nonWindowMinimized...()',
                              style: TextStyle(color: indigo700, fontSize: 11, height: 1.3),
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

          // ── Feature flag warning ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFFFE082)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.warning_amber, color: Color(0xFFF9A825), size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Experimental API',
                        style: TextStyle(
                          color: Color(0xFFF57F17),
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Multi-window APIs are behind the isWindowingEnabled flag. '
                        'Currently disabled on all platforms. This is internal Flutter '
                        'framework code, not intended for direct use in applications.',
                        style: TextStyle(color: Color(0xFF795548), fontSize: 12, height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // ── Mixin class explanation ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: indigo50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: indigo100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.code, color: indigo800, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      'Why "mixin class"?',
                      style: TextStyle(
                        color: indigo900,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ...[
                  'Can be used with "with" (mixin) or "extends" (class)',
                  'Dart 3 feature — combines mixin + class declaration',
                  'Has default constructor (no abstract members)',
                  'Framework can mix it into any class hierarchy',
                  'onWindowDestroyed() has empty body = safe default',
                ].map((text) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 6, height: 6,
                          margin: const EdgeInsets.only(top: 5, right: 8),
                          decoration: BoxDecoration(
                            color: indigo600,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            text,
                            style: TextStyle(color: blue900, fontSize: 12),
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

  print('  Live widget built: PopupWindowControllerDelegate demo');
  print('  • Class hierarchy (ChangeNotifier → BaseWindow → Popup)');
  print('  • 5-step lifecycle flow (create → activate → render → destroy → notify)');
  print('  • Popup vs Regular delegate comparison');
  print('  • Experimental API warning badge');
  print('  • Mixin class explanation (5 points)');
  print('');

  // ─── Section 13: Delegate Pattern in Flutter ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 13: Delegates Across Flutter');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────┬──────────────────────────────┐');
  print('  │  Delegate Class       │ What It Delegates             │');
  print('  ├──────────────────────┼──────────────────────────────┤');
  print('  │  RouterDelegate       │ Route build + pop behavior   │');
  print('  │  SliverChildDelegate  │ Child widget creation        │');
  print('  │  LocalizationsDelegate│ Locale resource loading      │');
  print('  │  ScrollActivity-      │ Scroll notifications         │');
  print('  │    Delegate           │                               │');
  print('  │  PopupWindowController│ Popup lifecycle events        │');
  print('  │    Delegate ← HERE   │ (onWindowDestroyed)           │');
  print('  └──────────────────────┴──────────────────────────────┘');
  print('');

  // ─── Section 14: Source Code Location ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 14: Source Code Location');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  File: packages/flutter/lib/src/widgets/_window.dart  │');
  print('  │  Line: ~775                                           │');
  print('  │                                                       │');
  print('  │  Nearby classes (same file):                          │');
  print('  │  • BaseWindowController (sealed)                      │');
  print('  │  • RegularWindowController                            │');
  print('  │  • RegularWindowControllerDelegate                    │');
  print('  │  • PopupWindowController                              │');
  print('  │  • PopupWindowControllerDelegate ← this class        │');
  print('  │  • PopupWindow (StatelessWidget)                      │');
  print('  │  • RegularWindow (StatelessWidget)                    │');
  print('  │  • WindowScope (InheritedWidget)                      │');
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
  print('  │  1. @internal mixin class (not public API)           │');
  print('  │  2. One method: onWindowDestroyed()                  │');
  print('  │  3. Part of Flutter\'s experimental multi-window     │');
  print('  │  4. Behind isWindowingEnabled feature flag            │');
  print('  │  5. Used by PopupWindowController as lifecycle hook   │');
  print('  │  6. Empty default — override for cleanup logic       │');
  print('  │  7. "mixin class" = flexible Dart 3 composition      │');
  print('  │  8. Simpler than RegularWindowControllerDelegate     │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  print('  Demo colors used:');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Indigo 900  ${indigo900.toARGB32().toRadixString(16).padLeft(8, "0")}  Deep');
  print('  │  Indigo 800  ${indigo800.toARGB32().toRadixString(16).padLeft(8, "0")}  Primary');
  print('  │  Indigo 700  ${indigo700.toARGB32().toRadixString(16).padLeft(8, "0")}  Warm');
  print('  │  Indigo 600  ${indigo600.toARGB32().toRadixString(16).padLeft(8, "0")}  Secondary');
  print('  │  Indigo 300  ${indigo300.toARGB32().toRadixString(16).padLeft(8, "0")}  Accent');
  print('  │  Indigo 200  ${indigo200.toARGB32().toRadixString(16).padLeft(8, "0")}  Muted');
  print('  │  Indigo 100  ${indigo100.toARGB32().toRadixString(16).padLeft(8, "0")}  Highlight');
  print('  │  Indigo 50   ${indigo50.toARGB32().toRadixString(16).padLeft(8, "0")}  Surface');
  print('  │  Purple 50   ${purple50.toARGB32().toRadixString(16).padLeft(8, "0")}  Light');
  print('  │  Blue 900    ${blue900.toARGB32().toRadixString(16).padLeft(8, "0")}  Dark');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  print('████████████████████████████████████████████████████████████');
  print('██  PopupWindowControllerDelegate — Demo Complete         ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  return demo;
}
