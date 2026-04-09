// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// PredictiveBackRoute — Complete Deep Dive
///
/// Palette: Steel / Graphite (cool neutrals with blue hints)
/// Primary:   Color(0xFF37474F) — Blue Grey 800
/// Secondary: Color(0xFF455A64) — Blue Grey 700
/// Accent:    Color(0xFF78909C) — Blue Grey 400
/// Surface:   Color(0xFFECEFF1) — Blue Grey 50
/// Deep:      Color(0xFF263238) — Blue Grey 900
/// Muted:     Color(0xFFB0BEC5) — Blue Grey 200
/// Warm:      Color(0xFF546E7A) — Blue Grey 600
/// Highlight: Color(0xFFCFD8DC) — Blue Grey 100
/// Light:     Color(0xFFF5F5F5) — Grey 100
/// Dark:      Color(0xFF1A237E) — Indigo 900

dynamic build(BuildContext context) {
  // ─── Section 1: Title Banner ───
  print('');
  print('████████████████████████████████████████████████████████████');
  print('██                                                      ██');
  print('██   PredictiveBackRoute — Deep Dive                      ██');
  print('██   Android predictive back gesture for routes           ██');
  print('██                                                      ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  const blueGrey800 = Color(0xFF37474F);
  const blueGrey700 = Color(0xFF455A64);
  const blueGrey400 = Color(0xFF78909C);
  const blueGrey50 = Color(0xFFECEFF1);
  const blueGrey900 = Color(0xFF263238);
  const blueGrey200 = Color(0xFFB0BEC5);
  const blueGrey600 = Color(0xFF546E7A);
  const blueGrey100 = Color(0xFFCFD8DC);
  const grey100 = Color(0xFFF5F5F5);
  const indigo900 = Color(0xFF1A237E);

  // ─── Section 2: What Is PredictiveBackRoute? ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 2: What Is PredictiveBackRoute?');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  An abstract interface class that defines the contract');
  print('  for routes that support Android\'s predictive back');
  print('  gesture — the swipe-from-edge gesture that shows a');
  print('  preview of what\'s behind the current screen before');
  print('  the user commits to going back.');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  abstract interface class PredictiveBackRoute {       │');
  print('  │                                                       │');
  print('  │    bool get isCurrent;                                │');
  print('  │    bool get popGestureEnabled;                        │');
  print('  │                                                       │');
  print('  │    void handleStartBackGesture({                      │');
  print('  │      double progress,                                 │');
  print('  │    });                                                │');
  print('  │                                                       │');
  print('  │    void handleUpdateBackGestureProgress({             │');
  print('  │      required double progress,                        │');
  print('  │    });                                                │');
  print('  │                                                       │');
  print('  │    void handleCommitBackGesture();                    │');
  print('  │                                                       │');
  print('  │    void handleCancelBackGesture();                    │');
  print('  │  }                                                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 3: Predictive Back Explained ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 3: Android Predictive Back Gesture');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Android 13+ introduced predictive back:              │');
  print('  │                                                       │');
  print('  │  OLD behavior:                                        │');
  print('  │  User swipes → immediate pop → no preview             │');
  print('  │                                                       │');
  print('  │  NEW behavior:                                        │');
  print('  │  User starts swiping from edge                        │');
  print('  │  → App shows a PREVIEW of the previous screen         │');
  print('  │  → User sees where they\'ll go                        │');
  print('  │  → User can COMMIT (complete swipe) or CANCEL         │');
  print('  │  → Much more intuitive navigation                     │');
  print('  │                                                       │');
  print('  │  The PredictiveBackRoute interface enables Flutter     │');
  print('  │  routes to participate in this gesture:                │');
  print('  │  • Start → begin transition animation                 │');
  print('  │  • Update → scrub animation to match finger position  │');
  print('  │  • Commit → complete the pop                          │');
  print('  │  • Cancel → reverse back to current screen            │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 4: The 4 Gesture Methods ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 4: The 4 Gesture Methods');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  1. handleStartBackGesture({double progress})         │');
  print('  │     ─────────────────────────────────────             │');
  print('  │     Called when user starts swiping from the edge.    │');
  print('  │     progress: initial position (usually 0.0).         │');
  print('  │     Route should start its exit transition.           │');
  print('  │                                                       │');
  print('  │  2. handleUpdateBackGestureProgress({                 │');
  print('  │         required double progress})                    │');
  print('  │     ──────────────────────────────────                │');
  print('  │     Called continuously as finger moves.              │');
  print('  │     progress: 0.0 (at edge) → 1.0 (fully swiped).  │');
  print('  │     Route should update transition to match.          │');
  print('  │                                                       │');
  print('  │  3. handleCommitBackGesture()                         │');
  print('  │     ──────────────────────────                        │');
  print('  │     Called when user completes the swipe.             │');
  print('  │     Route should complete the pop transition.         │');
  print('  │     Animation plays to 1.0 from current progress.    │');
  print('  │                                                       │');
  print('  │  4. handleCancelBackGesture()                         │');
  print('  │     ──────────────────────────                        │');
  print('  │     Called when user abandons the swipe.              │');
  print('  │     Route should reverse back to visible state.       │');
  print('  │     Animation plays back to 0.0.                      │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 5: Progress Parameter ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 5: The Progress Parameter (0.0 → 1.0)');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  progress maps from PredictiveBackEvent.progress:     │');
  print('  │                                                       │');
  print('  │  0.0 ──────────────────────────────────────── 1.0     │');
  print('  │  │                                            │       │');
  print('  │  │  Finger at         Finger at              │       │');
  print('  │  │  screen edge       opposite edge          │       │');
  print('  │  │  (just started)    (fully swiped)          │       │');
  print('  │  │                                            │       │');
  print('  │  │  Current screen    Previous screen         │       │');
  print('  │  │  fully visible     fully visible           │       │');
  print('  │  │  (no transition)   (complete transition)   │       │');
  print('  │  │                                            │       │');
  print('  │  └────────────────────────────────────────────┘       │');
  print('  │                                                       │');
  print('  │  The route uses this to drive the page transition     │');
  print('  │  animation. TransitionRoute maps progress directly    │');
  print('  │  to its Animation<double> controller.                 │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 6: Who Implements It? ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 6: Who Implements PredictiveBackRoute?');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  TransitionRoute<T> implements PredictiveBackRoute    │');
  print('  │  └─ ModalRoute<T>                                     │');
  print('  │      └─ PageRoute<T>                                  │');
  print('  │          ├─ MaterialPageRoute                         │');
  print('  │          ├─ CupertinoPageRoute                        │');
  print('  │          └─ any PageRoute subclass                    │');
  print('  │                                                       │');
  print('  │  So EVERY route that has a transition animation       │');
  print('  │  already supports predictive back automatically.      │');
  print('  │                                                       │');
  print('  │  TransitionRoute provides the implementation:         │');
  print('  │  • Uses the existing animation controller             │');
  print('  │  • Maps progress to animation.value                   │');
  print('  │  • handleCommit completes the animation forward       │');
  print('  │  • handleCancel reverses the animation                │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 7: isCurrent and popGestureEnabled ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 7: isCurrent and popGestureEnabled Properties');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  bool get isCurrent                                   │');
  print('  │  ──────────────────                                   │');
  print('  │  True if this route is the topmost route on the       │');
  print('  │  navigator. The predictive back gesture only applies  │');
  print('  │  to the current (topmost) route. If another route     │');
  print('  │  is pushed on top, this becomes false.                │');
  print('  │                                                       │');
  print('  │  bool get popGestureEnabled                           │');
  print('  │  ──────────────────────────                           │');
  print('  │  True if the back gesture should be enabled for this │');
  print('  │  route. Can be false when:                            │');
  print('  │  • Route has a form with unsaved changes              │');
  print('  │  • Route is the root (nothing to pop to)              │');
  print('  │  • Animation is still running from a previous pop     │');
  print('  │  • App has explicitly disabled back gesture            │');
  print('  │                                                       │');
  print('  │  The framework checks both before starting the        │');
  print('  │  gesture: isCurrent && popGestureEnabled.             │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 8: PredictiveBackPageTransitionsBuilder ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 8: PredictiveBackPageTransitionsBuilder');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  The visual counterpart to PredictiveBackRoute:       │');
  print('  │                                                       │');
  print('  │  PredictiveBackPageTransitionsBuilder is a            │');
  print('  │  PageTransitionsBuilder that produces the visual      │');
  print('  │  effect for predictive back on Android.               │');
  print('  │                                                       │');
  print('  │  Default Material 3 theme uses it automatically:      │');
  print('  │    ThemeData(                                         │');
  print('  │      pageTransitionsTheme: PageTransitionsTheme(      │');
  print('  │        builders: {                                    │');
  print('  │          TargetPlatform.android:                      │');
  print('  │            PredictiveBackPageTransitionsBuilder(),    │');
  print('  │        },                                             │');
  print('  │      ),                                               │');
  print('  │    )                                                  │');
  print('  │                                                       │');
  print('  │  The effect: current page shrinks and moves aside    │');
  print('  │  as the previous page is revealed underneath.         │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 9: Gesture Flow Timeline ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 9: Gesture Flow Timeline');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Time →  ────────────────────────────────────────     │');
  print('  │                                                       │');
  print('  │  Event:   Start       Update   Update   Commit/Cancel │');
  print('  │           │           │        │        │             │');
  print('  │  Progress: 0.0        0.3      0.7      (done)       │');
  print('  │  Screen:  Current     Current  Fading   Previous or  │');
  print('  │           visible     moving   out      bounce back  │');
  print('  │                                                       │');
  print('  │  If commit:                                           │');
  print('  │    Animation completes 0.7 → 1.0 (current exits)    │');
  print('  │    Route pops, previous screen fully visible          │');
  print('  │                                                       │');
  print('  │  If cancel:                                           │');
  print('  │    Animation reverses 0.7 → 0.0 (current returns)    │');
  print('  │    Route stays, current screen fully visible again    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 10: "abstract interface class" ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 10: "abstract interface class" in Dart 3');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  abstract: Cannot be instantiated directly            │');
  print('  │  interface: Can only be "implemented" not "extended"  │');
  print('  │  class: Is a class type (not a mixin)                 │');
  print('  │                                                       │');
  print('  │  ✓ class MyRoute implements PredictiveBackRoute       │');
  print('  │  ✗ class MyRoute extends PredictiveBackRoute          │');
  print('  │  ✗ PredictiveBackRoute()                              │');
  print('  │                                                       │');
  print('  │  This means PredictiveBackRoute defines a protocol:  │');
  print('  │  "these methods must exist" but provides no           │');
  print('  │  implementation. TransitionRoute provides the         │');
  print('  │  actual implementation.                               │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 11: Platform Specifics ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 11: Platform-Specific Behavior');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────┬──────────────────────────────┐');
  print('  │  Platform             │ Predictive Back Support       │');
  print('  ├──────────────────────┼──────────────────────────────┤');
  print('  │  Android 14+          │ Full predictive back gesture  │');
  print('  │                       │ with preview animation        │');
  print('  ├──────────────────────┼──────────────────────────────┤');
  print('  │  Android 13           │ Opt-in via manifest flag      │');
  print('  │                       │ (enableOnBackInvokedCallback)│');
  print('  ├──────────────────────┼──────────────────────────────┤');
  print('  │  Android <13          │ Not supported — immediate pop │');
  print('  ├──────────────────────┼──────────────────────────────┤');
  print('  │  iOS                  │ Has own back swipe (edge)     │');
  print('  │                       │ Not using this interface      │');
  print('  ├──────────────────────┼──────────────────────────────┤');
  print('  │  Web / Desktop        │ N/A — no system gesture      │');
  print('  └──────────────────────┴──────────────────────────────┘');
  print('');

  // ─── Section 12: Live Demo ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 12: Live Visual Demo');
  print('═══════════════════════════════════════════════════════════');
  print('');

  Widget buildGesturePhase({
    required String phase,
    required String method,
    required String desc,
    required double progress,
    required Color color,
    required bool isActive,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isActive ? color : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isActive ? color : blueGrey200,
          width: isActive ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isActive ? Colors.white.withValues(alpha: 0.2) : blueGrey50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '${(progress * 100).toInt()}%',
                style: TextStyle(
                  color: isActive ? Colors.white : blueGrey800,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      phase,
                      style: TextStyle(
                        color: isActive ? Colors.white : blueGrey800,
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: isActive
                            ? Colors.white.withValues(alpha: 0.2)
                            : blueGrey50,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        method,
                        style: TextStyle(
                          color: isActive ? Colors.white : blueGrey600,
                          fontSize: 9,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  desc,
                  style: TextStyle(
                    color: isActive ? Colors.white.withValues(alpha: 0.85) : blueGrey600,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          // Progress bar
          SizedBox(
            width: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: isActive
                    ? Colors.white.withValues(alpha: 0.2)
                    : blueGrey100,
                valueColor: AlwaysStoppedAnimation<Color>(
                  isActive ? Colors.white : blueGrey400,
                ),
                minHeight: 6,
              ),
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
        'PredictiveBackRoute — Demo',
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
          // ── Gesture flow visualization ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [blueGrey900, blueGrey700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Predictive Back Gesture Flow',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Android 14+ back gesture with preview',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 12),
                // Simulated screen transition
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color: blueGrey600,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: blueGrey400),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.home, color: Colors.white.withValues(alpha: 0.7), size: 20),
                              Text(
                                'Previous Screen',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(Icons.arrow_back, color: blueGrey400, size: 16),
                    const SizedBox(width: 6),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: blueGrey400, width: 2),
                        ),
                        child: const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.article, color: Colors.white, size: 20),
                              Text(
                                'Current Screen (swiping)',
                                style: TextStyle(color: Colors.white, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // ── 4 gesture phases ──
          Text(
            'Gesture Phases',
            style: TextStyle(
              color: blueGrey900,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Each phase maps to a PredictiveBackRoute method',
            style: TextStyle(color: blueGrey600, fontSize: 12),
          ),
          const SizedBox(height: 8),
          buildGesturePhase(
            phase: 'Start',
            method: 'handleStartBackGesture',
            desc: 'Finger touches edge — begin transition',
            progress: 0.0,
            color: blueGrey800,
            isActive: false,
          ),
          buildGesturePhase(
            phase: 'Update',
            method: 'handleUpdateBackGestureProgress',
            desc: 'Finger moves — scrub animation to match',
            progress: 0.45,
            color: blueGrey700,
            isActive: true,
          ),
          buildGesturePhase(
            phase: 'Commit',
            method: 'handleCommitBackGesture',
            desc: 'Swipe completed — finish pop animation',
            progress: 1.0,
            color: Color(0xFF2E7D32),
            isActive: false,
          ),
          buildGesturePhase(
            phase: 'Cancel',
            method: 'handleCancelBackGesture',
            desc: 'Swipe abandoned — reverse to current',
            progress: 0.0,
            color: Color(0xFFC62828),
            isActive: false,
          ),

          const SizedBox(height: 14),

          // ── Implementation hierarchy ──
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
                    Icon(Icons.account_tree, color: blueGrey800, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      'Implementation Hierarchy',
                      style: TextStyle(
                        color: blueGrey900,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ...[
                  {'level': 0, 'name': 'PredictiveBackRoute (interface)', 'highlight': true},
                  {'level': 1, 'name': 'TransitionRoute<T> (implements)', 'highlight': false},
                  {'level': 2, 'name': 'ModalRoute<T>', 'highlight': false},
                  {'level': 3, 'name': 'PageRoute<T>', 'highlight': false},
                  {'level': 4, 'name': 'MaterialPageRoute', 'highlight': false},
                  {'level': 4, 'name': 'CupertinoPageRoute', 'highlight': false},
                ].map((node) {
                  final level = node['level'] as int;
                  final hl = node['highlight'] as bool;
                  return Padding(
                    padding: EdgeInsets.only(left: level * 14.0, bottom: 3),
                    child: Row(
                      children: [
                        if (level > 0)
                          Text(
                            '└─ ',
                            style: TextStyle(
                              color: blueGrey400,
                              fontSize: 12,
                              fontFamily: 'monospace',
                            ),
                          ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: hl ? blueGrey800 : Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: hl ? blueGrey800 : blueGrey200,
                            ),
                          ),
                          child: Text(
                            node['name'] as String,
                            style: TextStyle(
                              color: hl ? Colors.white : blueGrey800,
                              fontWeight: hl ? FontWeight.w700 : FontWeight.w500,
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

          // ── Properties ──
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
                  'Gate Properties',
                  style: TextStyle(
                    color: blueGrey900,
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
                          color: blueGrey50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.vertical_align_top, color: blueGrey800, size: 24),
                            const SizedBox(height: 4),
                            Text(
                              'isCurrent',
                              style: TextStyle(
                                color: blueGrey800,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                fontFamily: 'monospace',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Is this the topmost route?\nOnly current routes can be swiped back.',
                              style: TextStyle(color: blueGrey600, fontSize: 11, height: 1.3),
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
                          color: blueGrey50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.swipe, color: blueGrey800, size: 24),
                            const SizedBox(height: 4),
                            Text(
                              'popGestureEnabled',
                              style: TextStyle(
                                color: blueGrey800,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                fontFamily: 'monospace',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Allow back gesture?\nFalse for unsaved forms, root route, etc.',
                              style: TextStyle(color: blueGrey600, fontSize: 11, height: 1.3),
                              textAlign: TextAlign.center,
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

          // ── Platform table ──
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
                Text(
                  'Platform Support',
                  style: TextStyle(
                    color: blueGrey900,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                ...[
                  {'platform': 'Android 14+', 'support': 'Full', 'color': Color(0xFF2E7D32), 'icon': Icons.check_circle},
                  {'platform': 'Android 13', 'support': 'Opt-in', 'color': Color(0xFFF9A825), 'icon': Icons.warning_amber},
                  {'platform': 'Android <13', 'support': 'None', 'color': Color(0xFFBDBDBD), 'icon': Icons.cancel_outlined},
                  {'platform': 'iOS', 'support': 'Own gesture', 'color': Color(0xFF1565C0), 'icon': Icons.info_outline},
                  {'platform': 'Web / Desktop', 'support': 'N/A', 'color': Color(0xFFBDBDBD), 'icon': Icons.cancel_outlined},
                ].map((row) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Row(
                      children: [
                        Icon(row['icon'] as IconData, color: row['color'] as Color, size: 16),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 100,
                          child: Text(
                            row['platform'] as String,
                            style: TextStyle(
                              color: blueGrey800,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Text(
                          row['support'] as String,
                          style: TextStyle(
                            color: row['color'] as Color,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
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

  print('  Live widget built: PredictiveBackRoute demo');
  print('  • Gesture flow with screen transition preview');
  print('  • 4 gesture phases (start/update/commit/cancel)');
  print('  • Implementation hierarchy (interface → TransitionRoute → PageRoute)');
  print('  • Gate properties (isCurrent, popGestureEnabled)');
  print('  • Platform support table (5 platforms)');
  print('');

  // ─── Section 13: Common Use Cases ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 13: Common Use Cases');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Most developers don\'t interact with this directly:  │');
  print('  │                                                       │');
  print('  │  1. MaterialPageRoute already supports it             │');
  print('  │     → Just works with Navigator.push() / pop()       │');
  print('  │                                                       │');
  print('  │  2. GoRouter supports it                              │');
  print('  │     → context.go() / context.push() paths            │');
  print('  │                                                       │');
  print('  │  3. Custom routes should implement it for Android     │');
  print('  │     → Extend PageRoute and transitions work           │');
  print('  │                                                       │');
  print('  │  When you NEED to care:                               │');
  print('  │  • Building a completely custom Route subclass         │');
  print('  │  • Implementing a route that doesn\'t use              │');
  print('  │    TransitionRoute\'s animation system                │');
  print('  │  • Disabling predictive back for specific routes      │');
  print('  │    (override popGestureEnabled to return false)       │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 14: How Flutter Connects to the Platform ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 14: Flutter ↔ Platform Connection');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Platform (Android)                                   │');
  print('  │  └─ OnBackInvokedCallback                             │');
  print('  │      (registered by FlutterActivity)                  │');
  print('  │      └─ sends PredictiveBackEvent                     │');
  print('  │          (progress: 0.0 - 1.0)                        │');
  print('  │                                                       │');
  print('  │  Engine                                               │');
  print('  │  └─ Converts PredictiveBackEvent to method calls      │');
  print('  │                                                       │');
  print('  │  Framework                                            │');
  print('  │  └─ Navigator finds current route                     │');
  print('  │     └─ if route is PredictiveBackRoute:               │');
  print('  │         └─ calls handleStart/Update/Commit/Cancel     │');
  print('  │                                                       │');
  print('  │  TransitionRoute implements                           │');
  print('  │  └─ Maps progress to animation controller value       │');
  print('  │     └─ PageTransitionsBuilder renders the visual      │');
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
  print('  │  1. Abstract interface class (protocol definition)   │');
  print('  │  2. 4 methods: start, update, commit, cancel         │');
  print('  │  3. progress: 0.0 (edge) → 1.0 (fully swiped)      │');
  print('  │  4. 2 gate properties: isCurrent, popGestureEnabled  │');
  print('  │  5. Implemented by TransitionRoute (all page routes) │');
  print('  │  6. Android 14+ specific (opt-in on Android 13)      │');
  print('  │  7. Works automatically with MaterialPageRoute       │');
  print('  │  8. PredictiveBackPageTransitionsBuilder for visuals  │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  print('  Demo colors used:');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  BlueGr 900  ${blueGrey900.toARGB32().toRadixString(16).padLeft(8, "0")}  Deep');
  print('  │  BlueGr 800  ${blueGrey800.toARGB32().toRadixString(16).padLeft(8, "0")}  Primary');
  print('  │  BlueGr 700  ${blueGrey700.toARGB32().toRadixString(16).padLeft(8, "0")}  Secondary');
  print('  │  BlueGr 600  ${blueGrey600.toARGB32().toRadixString(16).padLeft(8, "0")}  Warm');
  print('  │  BlueGr 400  ${blueGrey400.toARGB32().toRadixString(16).padLeft(8, "0")}  Accent');
  print('  │  BlueGr 200  ${blueGrey200.toARGB32().toRadixString(16).padLeft(8, "0")}  Muted');
  print('  │  BlueGr 100  ${blueGrey100.toARGB32().toRadixString(16).padLeft(8, "0")}  Highlight');
  print('  │  BlueGr 50   ${blueGrey50.toARGB32().toRadixString(16).padLeft(8, "0")}  Surface');
  print('  │  Grey 100    ${grey100.toARGB32().toRadixString(16).padLeft(8, "0")}  Light');
  print('  │  Indigo 900  ${indigo900.toARGB32().toRadixString(16).padLeft(8, "0")}  Dark');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  print('████████████████████████████████████████████████████████████');
  print('██  PredictiveBackRoute — Demo Complete                   ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  return demo;
}
