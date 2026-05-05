// D4rt deep-demo Flutter test script: PointerSignalResolver.
// Hand-authored visual exposition of how Flutter routes PointerSignalEvents
// (trackpad scroll, mouse wheel, etc.) through PointerSignalResolver.
//
// This file is a single-file Flutter script: it exposes a top-level
// build(BuildContext) function. It does NOT call runApp(). It does not
// dispatch real events; it only constructs and inspects a fresh
// PointerSignalResolver instance and walks through its semantics visually.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette (top-level private tokens). Mixed cobalt / magenta / mint scheme,
// chosen to differ from neighbouring deep-demo files in this folder.
// ---------------------------------------------------------------------------
const Color kInkDeep = Color(0xFF0B1020);
const Color kInkMid = Color(0xFF141A33);
const Color kInkSoft = Color(0xFF1F2547);
const Color kInkLine = Color(0xFF2B3160);
const Color kMistPale = Color(0xFFE2E4F4);
const Color kMistMid = Color(0xFFB7BCDB);
const Color kMistDim = Color(0xFF7C82AB);

const Color kCobaltCore = Color(0xFF3E5BFF);
const Color kCobaltSoft = Color(0xFF6F84FF);
const Color kCobaltGlow = Color(0xFFA9B4FF);

const Color kMagentaCore = Color(0xFFD946EF);
const Color kMagentaSoft = Color(0xFFE879F9);
const Color kMagentaGlow = Color(0xFFF5C8FF);

const Color kMintCore = Color(0xFF14B8A6);
const Color kMintSoft = Color(0xFF2DD4BF);
const Color kMintGlow = Color(0xFF99F6E4);

const Color kAmberAccent = Color(0xFFFCD34D);
const Color kCrimsonAccent = Color(0xFFEF4444);
const Color kEmeraldAccent = Color(0xFF22C55E);

// ---------------------------------------------------------------------------
// Top-level small private value types used by the demo for clarity.
// ---------------------------------------------------------------------------
class ApiRow {
  final String signature;
  final String returns;
  final String summary;
  final IconData icon;
  final Color tint;
  const ApiRow({
    required this.signature,
    required this.returns,
    required this.summary,
    required this.icon,
    required this.tint,
  });
}

class ConflictCase {
  final String title;
  final String outerLabel;
  final String innerLabel;
  final bool outerRegisters;
  final bool innerRegisters;
  final String outcome;
  final IconData verdictIcon;
  final Color verdictColor;
  const ConflictCase({
    required this.title,
    required this.outerLabel,
    required this.innerLabel,
    required this.outerRegisters,
    required this.innerRegisters,
    required this.outcome,
    required this.verdictIcon,
    required this.verdictColor,
  });
}

class StepRow {
  final int index;
  final String headline;
  final String detail;
  final IconData icon;
  final Color color;
  const StepRow({
    required this.index,
    required this.headline,
    required this.detail,
    required this.icon,
    required this.color,
  });
}

// ---------------------------------------------------------------------------
// Entry point.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  // Construct an isolated resolver instance just to demonstrate that the
  // type is reachable from gestures.dart. We do NOT register or resolve
  // events on it — the framework's real resolver lives on
  // GestureBinding.instance.pointerSignalResolver and is the one that wins
  // in production.
  final PointerSignalResolver resolver = PointerSignalResolver();
  final String resolverType = resolver.runtimeType.toString();
  final String resolverHash = resolver.hashCode.toRadixString(16);

  return Scaffold(
    backgroundColor: kInkDeep,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeroHeader(resolverType, resolverHash),
          const SizedBox(height: 28.0),
          buildProblemPanel(),
          const SizedBox(height: 28.0),
          buildAlgorithmPanel(),
          const SizedBox(height: 28.0),
          buildNestingVisual(),
          const SizedBox(height: 28.0),
          buildApiAnatomy(),
          const SizedBox(height: 28.0),
          buildSetupWalkthrough(),
          const SizedBox(height: 28.0),
          buildConflictScenarios(),
          const SizedBox(height: 28.0),
          buildArenaComparison(),
          const SizedBox(height: 28.0),
          buildRealWorldExample(),
          const SizedBox(height: 28.0),
          buildCaveats(),
          const SizedBox(height: 28.0),
          buildFooter(),
        ],
      ),
    ),
  );
}

// ===========================================================================
// SECTION 1 — Hero header
// ===========================================================================
Widget buildHeroHeader(String resolverType, String resolverHash) {
  return Container(
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[kInkDeep, kInkMid, kInkSoft],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(22.0),
      border: Border.all(color: kCobaltCore.withValues(alpha: 0.4), width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kCobaltCore.withValues(alpha: 0.40),
          blurRadius: 28.0,
          offset: const Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: kMagentaCore.withValues(alpha: 0.25),
          blurRadius: 38.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: <Color>[kCobaltCore, kMagentaCore],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: kCobaltCore.withValues(alpha: 0.55),
                    blurRadius: 16.0,
                    offset: const Offset(0.0, 6.0),
                  ),
                ],
              ),
              child: const Icon(
                Icons.alt_route,
                color: Colors.white,
                size: 38.0,
              ),
            ),
            const SizedBox(width: 18.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'PointerSignalResolver',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'package:flutter/gestures.dart',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      color: kCobaltGlow.withValues(alpha: 0.95),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                color: kMagentaCore.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: kMagentaCore.withValues(alpha: 0.6),
                  width: 1.0,
                ),
              ),
              child: const Text(
                'mediator',
                style: TextStyle(
                  color: kMagentaGlow,
                  fontSize: 12.0,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 22.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0,
          ),
          decoration: BoxDecoration(
            color: kMintCore.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: kMintCore.withValues(alpha: 0.5),
              width: 1.0,
            ),
          ),
          child: const Text(
            'The framework-managed mediator that decides which Listener\n'
            'consumes a discrete PointerSignalEvent (trackpad scroll, mouse\n'
            'wheel, scale signals). Multiple listeners up the tree may want\n'
            'the same event — the resolver gives it to the one that calls\n'
            'register() first during dispatch.',
            style: TextStyle(
              fontSize: 13.0,
              color: kMintGlow,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 18.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: <Widget>[
            buildHeroChip(Icons.fingerprint, 'instance type', resolverType),
            buildHeroChip(Icons.tag, 'hash', '0x$resolverHash'),
            buildHeroChip(Icons.bolt, 'discrete', 'not gestures'),
            buildHeroChip(Icons.layers, 'first-wins', 'register order'),
            buildHeroChip(Icons.mouse, 'wheel', 'trackpad / mouse'),
          ],
        ),
      ],
    ),
  );
}

Widget buildHeroChip(IconData icon, String label, String value) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: kInkDeep.withValues(alpha: 0.65),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: kCobaltSoft.withValues(alpha: 0.45),
        width: 1.0,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 14.0, color: kCobaltGlow),
        const SizedBox(width: 6.0),
        Text(
          label,
          style: const TextStyle(
            color: kMistMid,
            fontSize: 11.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 6.0),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12.0,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 2 — The problem it solves
// ===========================================================================
Widget buildProblemPanel() {
  return Container(
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      color: kInkMid,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: kCrimsonAccent.withValues(alpha: 0.4)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kCrimsonAccent.withValues(alpha: 0.18),
          blurRadius: 20.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: kCrimsonAccent.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Icon(
                Icons.report_problem,
                color: kCrimsonAccent,
                size: 22.0,
              ),
            ),
            const SizedBox(width: 12.0),
            const Text(
              '1 · The problem it solves',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        const Text(
          'Pointer signal events (PointerScrollEvent, PointerScaleEvent, '
          'PointerScrollInertiaCancelEvent) walk the hit-test stack just like '
          'pointer-down events. But — unlike taps and drags — there is no '
          '"gesture arena" for them. So if three nested Listeners all asked '
          '"do you want this scroll?", three would say yes, and the page would '
          'jump three times for one wheel notch.',
          style: TextStyle(color: kMistPale, fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 18.0),
        SizedBox(
          height: 220.0,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: kInkDeep,
                    borderRadius: BorderRadius.circular(14.0),
                    border: Border.all(
                      color: kInkLine,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 24.0,
                top: 18.0,
                right: 24.0,
                bottom: 18.0,
                child: buildAmbiguityRing('outer Listener', kCobaltCore, 0),
              ),
              Positioned(
                left: 80.0,
                top: 50.0,
                right: 80.0,
                bottom: 50.0,
                child: buildAmbiguityRing('middle Listener', kMagentaCore, 1),
              ),
              Positioned(
                left: 140.0,
                top: 78.0,
                right: 140.0,
                bottom: 78.0,
                child: buildAmbiguityRing('inner Listener', kMintCore, 2),
              ),
              Positioned(
                left: 0.0,
                top: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kAmberAccent.withValues(alpha: 0.95),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: kAmberAccent.withValues(alpha: 0.55),
                          blurRadius: 18.0,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.mouse,
                      color: kInkDeep,
                      size: 20.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: kCrimsonAccent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: kCrimsonAccent.withValues(alpha: 0.45),
            ),
          ),
          child: Row(
            children: <Widget>[
              const Icon(Icons.warning_amber, color: kCrimsonAccent),
              const SizedBox(width: 10.0),
              const Expanded(
                child: Text(
                  'Without the resolver, all three rings would react. The '
                  'page scrolls three notches per wheel tick. Bad.',
                  style: TextStyle(
                    color: kMistPale,
                    fontSize: 12.5,
                    height: 1.4,
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

Widget buildAmbiguityRing(String label, Color tint, int depth) {
  return Container(
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.08 + depth * 0.03),
      borderRadius: BorderRadius.circular(14.0 - depth * 2.0),
      border: Border.all(
        color: tint.withValues(alpha: 0.7),
        width: 1.5,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 6.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 3.0,
          ),
          decoration: BoxDecoration(
            color: tint.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}

// ===========================================================================
// SECTION 3 — The resolution algorithm
// ===========================================================================
Widget buildAlgorithmPanel() {
  const List<StepRow> steps = <StepRow>[
    StepRow(
      index: 1,
      headline: 'Hit-test result captured',
      detail:
          'The PointerSignalEvent is created and a HitTestResult is built '
          'top-down, the same way as for pointer-down events.',
      icon: Icons.timeline,
      color: kCobaltCore,
    ),
    StepRow(
      index: 2,
      headline: 'Walk targets in reverse',
      detail:
          'GestureBinding.dispatchEvent walks the path innermost-first '
          '(the hit-test result is reversed during dispatch).',
      icon: Icons.swap_vert,
      color: kCobaltSoft,
    ),
    StepRow(
      index: 3,
      headline: 'Listener gets the event',
      detail:
          'Each Listener with onPointerSignal receives the event and may '
          'call resolver.register(event, callback).',
      icon: Icons.touch_app,
      color: kMagentaCore,
    ),
    StepRow(
      index: 4,
      headline: 'Resolver remembers FIRST',
      detail:
          'The resolver records ONLY the first registration per event. '
          'Subsequent register() calls for the same event are no-ops.',
      icon: Icons.flag,
      color: kMagentaSoft,
    ),
    StepRow(
      index: 5,
      headline: 'resolve() fires the winner',
      detail:
          'After dispatch, GestureBinding calls resolver.resolve(event), '
          'which invokes the stored callback, if any.',
      icon: Icons.bolt,
      color: kMintCore,
    ),
    StepRow(
      index: 6,
      headline: 'Per-event lifetime',
      detail:
          'Registration is cleared once the event resolves. The next event '
          'starts the cycle from scratch.',
      icon: Icons.restart_alt,
      color: kMintSoft,
    ),
  ];

  return Container(
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[kInkMid, kInkSoft],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: kCobaltSoft.withValues(alpha: 0.45)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: kCobaltCore.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Icon(
                Icons.account_tree,
                color: kCobaltGlow,
                size: 22.0,
              ),
            ),
            const SizedBox(width: 12.0),
            const Text(
              '2 · The resolution algorithm',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        const Text(
          'The framework follows a deterministic six-step routine. The '
          'numbered rows below trace one event from creation to handling.',
          style: TextStyle(
            color: kMistPale,
            fontSize: 13.0,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16.0),
        Column(
          children: steps.map(buildAlgorithmRow).toList(),
        ),
      ],
    ),
  );
}

Widget buildAlgorithmRow(StepRow step) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: kInkDeep.withValues(alpha: 0.65),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: step.color.withValues(alpha: 0.55)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 40.0,
          height: 40.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: <Color>[
                step.color,
                step.color.withValues(alpha: 0.7),
              ],
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: step.color.withValues(alpha: 0.45),
                blurRadius: 10.0,
              ),
            ],
          ),
          child: Text(
            '${step.index}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
        const SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(step.icon, color: step.color, size: 16.0),
                  const SizedBox(width: 6.0),
                  Text(
                    step.headline,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              Text(
                step.detail,
                style: const TextStyle(
                  color: kMistMid,
                  fontSize: 12.5,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 4 — Conceptual nesting visualization
// ===========================================================================
Widget buildNestingVisual() {
  return Container(
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      color: kInkMid,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: kMagentaCore.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: kMagentaCore.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Icon(
                Icons.layers,
                color: kMagentaGlow,
                size: 22.0,
              ),
            ),
            const SizedBox(width: 12.0),
            const Text(
              '3 · Conceptual tree (outer → middle → inner)',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        SizedBox(
          height: 320.0,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        kInkDeep,
                        kInkSoft.withValues(alpha: 0.9),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14.0),
                    border: Border.all(color: kInkLine),
                  ),
                ),
              ),
              Positioned(
                left: 16.0,
                top: 16.0,
                right: 16.0,
                bottom: 16.0,
                child: buildTreeBox(
                  label: 'outer Listener',
                  priority: 'priority: 3 (last to register)',
                  tint: kCobaltCore,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 36.0, 20.0, 20.0),
                    child: buildTreeBox(
                      label: 'middle Listener',
                      priority: 'priority: 2',
                      tint: kMagentaCore,
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 36.0, 20.0, 20.0),
                        child: buildTreeBox(
                          label: 'inner Listener',
                          priority: 'priority: 1 (first to register)',
                          tint: kMintCore,
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 10.0,
                              ),
                              decoration: BoxDecoration(
                                color: kAmberAccent.withValues(alpha: 0.92),
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color:
                                        kAmberAccent.withValues(alpha: 0.55),
                                    blurRadius: 14.0,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const <Widget>[
                                  Icon(
                                    Icons.arrow_downward,
                                    color: kInkDeep,
                                    size: 14.0,
                                  ),
                                  SizedBox(width: 6.0),
                                  Text(
                                    'PointerScrollEvent',
                                    style: TextStyle(
                                      color: kInkDeep,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        const Text(
          'Dispatch order is reverse hit-test: the inner listener is asked '
          'about the event first. If it calls register(), it locks the '
          'event. The middle and outer listeners may still see the event '
          'object (so they can update hover state, etc.) but their '
          'register() calls become no-ops.',
          style: TextStyle(color: kMistMid, fontSize: 12.5, height: 1.5),
        ),
      ],
    ),
  );
}

Widget buildTreeBox({
  required String label,
  required String priority,
  required Color tint,
  required Widget child,
}) {
  return Container(
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: tint.withValues(alpha: 0.7), width: 1.6),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: tint.withValues(alpha: 0.18),
          blurRadius: 12.0,
        ),
      ],
    ),
    child: Stack(
      children: <Widget>[
        Positioned(
          left: 12.0,
          top: 8.0,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              color: tint,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ),
        Positioned(
          right: 10.0,
          top: 8.0,
          child: Text(
            priority,
            style: TextStyle(
              color: tint.withValues(alpha: 0.85),
              fontSize: 10.0,
              fontFamily: 'monospace',
            ),
          ),
        ),
        child,
      ],
    ),
  );
}

// ===========================================================================
// SECTION 5 — API anatomy
// ===========================================================================
Widget buildApiAnatomy() {
  const List<ApiRow> rows = <ApiRow>[
    ApiRow(
      signature:
          'register(PointerSignalEvent event, PointerSignalResolvedCallback cb)',
      returns: 'void',
      summary:
          'Tells the resolver "I will handle this event". Only the FIRST '
          'such call per event is remembered.',
      icon: Icons.app_registration,
      tint: kCobaltCore,
    ),
    ApiRow(
      signature: 'GestureBinding.instance.pointerSignalResolver',
      returns: 'PointerSignalResolver',
      summary:
          'The single, framework-owned resolver instance. Production code '
          'uses this — never construct your own for live dispatch.',
      icon: Icons.public,
      tint: kMagentaCore,
    ),
    ApiRow(
      signature: 'typedef PointerSignalResolvedCallback',
      returns: 'void Function(PointerSignalEvent event)',
      summary:
          'The signature your handler must match: takes the event, returns '
          'nothing. Keep it short — it runs in the dispatch path.',
      icon: Icons.arrow_forward,
      tint: kMintCore,
    ),
    ApiRow(
      signature: 'PointerSignalResolver()',
      returns: 'PointerSignalResolver',
      summary:
          'Public constructor. Useful for tests; in real apps, use the '
          'binding-owned instance.',
      icon: Icons.construction,
      tint: kAmberAccent,
    ),
  ];

  return Container(
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      color: kInkSoft,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: kCobaltGlow.withValues(alpha: 0.35)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: kCobaltSoft.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Icon(
                Icons.api,
                color: kCobaltGlow,
                size: 22.0,
              ),
            ),
            const SizedBox(width: 12.0),
            const Text(
              '4 · API anatomy',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: rows.map(buildApiCard).toList(),
        ),
      ],
    ),
  );
}

Widget buildApiCard(ApiRow row) {
  return SizedBox(
    width: 360.0,
    child: Card(
      color: kInkDeep,
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: row.tint.withValues(alpha: 0.6)),
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: row.tint.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(row.icon, color: row.tint, size: 18.0),
                ),
                const SizedBox(width: 8.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: row.tint.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    'returns ${row.returns}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10.5,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Text(
              row.signature,
              style: TextStyle(
                color: row.tint.withValues(alpha: 0.95),
                fontFamily: 'monospace',
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              row.summary,
              style: const TextStyle(
                color: kMistMid,
                fontSize: 12.0,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ===========================================================================
// SECTION 6 — Sample setup walk-through (pseudo-code)
// ===========================================================================
Widget buildSetupWalkthrough() {
  const String code = '''
// Inside any widget's build(...) — purely textual.
Listener(
  onPointerSignal: (PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      GestureBinding.instance.pointerSignalResolver.register(
        event,
        (PointerSignalEvent e) {
          // We won the resolution race — handle the wheel notch here.
          // e is the same event object that was offered to us.
          handleScroll(e as PointerScrollEvent);
        },
      );
    }
  },
  child: ScrollableViewport(...),
);

// Notes:
//  * Don't call resolver.resolve() yourself — GestureBinding does that.
//  * Registration is per-event. Re-register every time onPointerSignal
//    fires; there is no persistent subscription.
//  * The callback runs synchronously after dispatch finishes.''';

  return Container(
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      color: kInkMid,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: kMintCore.withValues(alpha: 0.45)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: kMintCore.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Icon(
                Icons.code,
                color: kMintGlow,
                size: 22.0,
              ),
            ),
            const SizedBox(width: 12.0),
            const Text(
              '5 · Sample setup (pseudo-code)',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: kInkDeep,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: kInkLine),
          ),
          child: const Text(
            code,
            style: TextStyle(
              color: kMintGlow,
              fontFamily: 'monospace',
              fontSize: 12.0,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 8.0,
          children: <Widget>[
            buildPseudoTag('one Listener', kCobaltCore),
            buildPseudoTag('per-event registration', kMagentaCore),
            buildPseudoTag('synchronous callback', kMintCore),
            buildPseudoTag('no resolver.resolve()', kAmberAccent),
          ],
        ),
      ],
    ),
  );
}

Widget buildPseudoTag(String label, Color tint) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: tint.withValues(alpha: 0.7)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.check_circle, size: 13.0, color: tint),
        const SizedBox(width: 6.0),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 7 — Conflict scenarios
// ===========================================================================
Widget buildConflictScenarios() {
  const List<ConflictCase> cases = <ConflictCase>[
    ConflictCase(
      title: 'A · outer wins',
      outerLabel: 'outer ScrollView',
      innerLabel: 'inner static box',
      outerRegisters: true,
      innerRegisters: false,
      outcome: 'inner skips registration; resolver only sees outer.',
      verdictIcon: Icons.check_circle,
      verdictColor: kEmeraldAccent,
    ),
    ConflictCase(
      title: 'B · inner wins',
      outerLabel: 'outer ScrollView',
      innerLabel: 'inner ScrollView',
      outerRegisters: true,
      innerRegisters: true,
      outcome:
          'reverse dispatch hits inner first; outer.register is a no-op.',
      verdictIcon: Icons.check_circle,
      verdictColor: kEmeraldAccent,
    ),
    ConflictCase(
      title: 'C · only inner registers',
      outerLabel: 'outer Listener',
      innerLabel: 'inner ScrollView',
      outerRegisters: false,
      innerRegisters: true,
      outcome:
          'inner registers first, outer never bothers — clean handoff.',
      verdictIcon: Icons.check_circle,
      verdictColor: kEmeraldAccent,
    ),
    ConflictCase(
      title: 'D · neither registers',
      outerLabel: 'plain Container',
      innerLabel: 'plain Container',
      outerRegisters: false,
      innerRegisters: false,
      outcome:
          'no callback stored; resolve() is a no-op; the event drops.',
      verdictIcon: Icons.cancel,
      verdictColor: kCrimsonAccent,
    ),
  ];

  return Container(
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      color: kInkSoft,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: kAmberAccent.withValues(alpha: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: kAmberAccent.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Icon(
                Icons.compare_arrows,
                color: kAmberAccent,
                size: 22.0,
              ),
            ),
            const SizedBox(width: 12.0),
            const Text(
              '6 · Conflict scenarios',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: cases.map(buildConflictCard).toList(),
        ),
      ],
    ),
  );
}

Widget buildConflictCard(ConflictCase scenario) {
  return SizedBox(
    width: 360.0,
    child: Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: kInkDeep,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(
          color: scenario.verdictColor.withValues(alpha: 0.55),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: scenario.verdictColor.withValues(alpha: 0.18),
            blurRadius: 12.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                scenario.verdictIcon,
                color: scenario.verdictColor,
                size: 18.0,
              ),
              const SizedBox(width: 8.0),
              Text(
                scenario.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          SizedBox(
            height: 130.0,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: buildScenarioBox(
                    scenario.outerLabel,
                    kCobaltCore,
                    scenario.outerRegisters,
                  ),
                ),
                Positioned(
                  left: 28.0,
                  top: 28.0,
                  right: 28.0,
                  bottom: 18.0,
                  child: buildScenarioBox(
                    scenario.innerLabel,
                    kMagentaCore,
                    scenario.innerRegisters,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 8.0,
            ),
            decoration: BoxDecoration(
              color: scenario.verdictColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              scenario.outcome,
              style: const TextStyle(
                color: kMistPale,
                fontSize: 11.5,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildScenarioBox(String label, Color tint, bool registers) {
  return Container(
    decoration: BoxDecoration(
      color: tint.withValues(alpha: registers ? 0.22 : 0.08),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: tint.withValues(alpha: registers ? 0.85 : 0.4),
        width: 1.4,
      ),
    ),
    child: Stack(
      children: <Widget>[
        Positioned(
          left: 8.0,
          top: 6.0,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 3.0,
            ),
            decoration: BoxDecoration(
              color: tint,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Positioned(
          right: 8.0,
          top: 6.0,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 6.0,
              vertical: 3.0,
            ),
            decoration: BoxDecoration(
              color: registers
                  ? kEmeraldAccent.withValues(alpha: 0.85)
                  : kCrimsonAccent.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  registers ? Icons.check : Icons.close,
                  color: Colors.white,
                  size: 11.0,
                ),
                const SizedBox(width: 3.0),
                Text(
                  registers ? 'register' : 'no-op',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 8 — Comparison vs gesture arena
// ===========================================================================
Widget buildArenaComparison() {
  return Container(
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[kInkMid, kInkSoft],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: kMagentaSoft.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: kMagentaSoft.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Icon(
                Icons.balance,
                color: kMagentaGlow,
                size: 22.0,
              ),
            ),
            const SizedBox(width: 12.0),
            const Text(
              '7 · Resolver vs gesture arena',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: buildCompareColumn(
                title: 'PointerSignalResolver',
                subtitle: 'discrete events (scroll, scale)',
                tint: kCobaltCore,
                bullets: const <String>[
                  'first register() per event wins',
                  'no concept of accept / reject / sweep',
                  'one shot — no continuous tracking',
                  'walked alongside hit-test result reverse',
                  'no defer-decisions; synchronous',
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: buildCompareColumn(
                title: 'GestureArena',
                subtitle: 'continuous gestures (tap, drag)',
                tint: kMagentaCore,
                bullets: const <String>[
                  'recognizers compete to "win"',
                  'accept / reject / sweep semantics',
                  'tracks pointer over multiple events',
                  'last-living recognizer wins by default',
                  'can be deferred until pointer-up',
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: kMagentaCore.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: kMagentaCore.withValues(alpha: 0.45),
            ),
          ),
          child: const Text(
            'Why two systems? Because pointer signals are NOT gestures. A '
            'wheel notch is a single discrete fact, not a stream that has '
            'to be "won" over time. Running it through the arena would '
            'make every wheel notch wait for arena resolution, which is '
            'the wrong shape of latency.',
            style: TextStyle(
              color: kMistPale,
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildCompareColumn({
  required String title,
  required String subtitle,
  required Color tint,
  required List<String> bullets,
}) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: kInkDeep.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: tint.withValues(alpha: 0.6)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 2.0),
        Text(
          subtitle,
          style: TextStyle(
            color: tint.withValues(alpha: 0.9),
            fontSize: 11.5,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: bullets.map((String b) => buildBullet(b, tint)).toList(),
        ),
      ],
    ),
  );
}

Widget buildBullet(String text, Color tint) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 5.0, right: 8.0),
          child: Container(
            width: 6.0,
            height: 6.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: tint,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: kMistPale,
              fontSize: 12.0,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 9 — Real-world example: nested viewports
// ===========================================================================
Widget buildRealWorldExample() {
  return Container(
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      color: kInkMid,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: kMintSoft.withValues(alpha: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: kMintSoft.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Icon(
                Icons.view_carousel,
                color: kMintGlow,
                size: 22.0,
              ),
            ),
            const SizedBox(width: 12.0),
            const Text(
              '8 · Real world: carousel with nested list',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text(
          'A horizontal carousel containing five vertical lists. The user '
          'scrolls the wheel while the cursor is over a card. The inner '
          'vertical list claims the wheel; the outer carousel does not, so '
          'the page below scrolls vertically — not horizontally — even '
          'though the carousel could have moved.',
          style: TextStyle(
            color: kMistPale,
            fontSize: 12.8,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16.0),
        SizedBox(
          height: 180.0,
          child: Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  kCobaltCore.withValues(alpha: 0.18),
                  kCobaltSoft.withValues(alpha: 0.10),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: kCobaltCore.withValues(alpha: 0.55),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.swap_horiz,
                      color: kCobaltGlow,
                      size: 16.0,
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      'outer · horizontal carousel  (Listener does NOT register)',
                      style: TextStyle(
                        color: kCobaltGlow.withValues(alpha: 0.95),
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      buildCarouselCard('Card A', kMagentaCore, vertical: true),
                      const SizedBox(width: 8.0),
                      buildCarouselCard('Card B', kMintCore, vertical: true),
                      const SizedBox(width: 8.0),
                      buildCarouselCard(
                        'Card C ◀ scrolling',
                        kAmberAccent,
                        vertical: true,
                        highlighted: true,
                      ),
                      const SizedBox(width: 8.0),
                      buildCarouselCard('Card D', kCobaltSoft, vertical: true),
                      const SizedBox(width: 8.0),
                      buildCarouselCard('Card E', kMagentaSoft, vertical: true),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: kMintCore.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: kMintCore.withValues(alpha: 0.4)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(Icons.lightbulb, color: kMintGlow),
              const SizedBox(width: 10.0),
              const Expanded(
                child: Text(
                  'Card C\'s inner ListView calls register() first. The '
                  'outer carousel\'s pan handler is NOT a Listener for '
                  'pointer signals at all (it uses a horizontal drag '
                  'recognizer in the gesture arena), so there is no '
                  'conflict — two separate routing systems coexist.',
                  style: TextStyle(
                    color: kMistPale,
                    fontSize: 12.0,
                    height: 1.5,
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

Widget buildCarouselCard(
  String label,
  Color tint, {
  bool vertical = false,
  bool highlighted = false,
}) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        color: tint.withValues(alpha: highlighted ? 0.32 : 0.18),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: tint.withValues(alpha: highlighted ? 1.0 : 0.55),
          width: highlighted ? 2.0 : 1.0,
        ),
        boxShadow: highlighted
            ? <BoxShadow>[
                BoxShadow(
                  color: tint.withValues(alpha: 0.55),
                  blurRadius: 14.0,
                ),
              ]
            : <BoxShadow>[],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: kInkDeep.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Center(
                  child: Icon(
                    vertical
                        ? Icons.swap_vert
                        : Icons.swap_horizontal_circle,
                    color: tint,
                    size: 22.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ===========================================================================
// SECTION 10 — Caveats
// ===========================================================================
Widget buildCaveats() {
  return Container(
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      color: kInkSoft,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: kCrimsonAccent.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: kCrimsonAccent.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Icon(
                Icons.shield_moon,
                color: kCrimsonAccent,
                size: 22.0,
              ),
            ),
            const SizedBox(width: 12.0),
            const Text(
              '9 · Caveats and edge cases',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Column(
          children: <Widget>[
            buildCaveatTile(
              icon: Icons.devices_other,
              title: 'Platforms without trackpad signals',
              body:
                  'On platforms that do not synthesize PointerSignalEvents '
                  '(e.g. some embedded targets, older mobile gestures), the '
                  'resolver is simply never invoked. Don\'t rely on it as '
                  'the only scroll path; it complements other input.',
            ),
            buildCaveatTile(
              icon: Icons.timer,
              title: 'Per-event lifetime',
              body:
                  'register() ties a callback to ONE event. The next '
                  'PointerScrollEvent is a fresh contest. Storing state '
                  'across events is the listener\'s job, not the '
                  'resolver\'s.',
            ),
            buildCaveatTile(
              icon: Icons.sync_problem,
              title: 'Dispatch order matters',
              body:
                  'Innermost listeners win because dispatch reverses the '
                  'hit-test stack. If you wrap a Listener inside another '
                  'Listener, the inner one always gets the first chance '
                  'to call register().',
            ),
            buildCaveatTile(
              icon: Icons.bug_report,
              title: 'Don\'t call resolve() yourself',
              body:
                  'GestureBinding calls resolve() once dispatch is done. '
                  'Calling it manually outside the binding will fire '
                  'the callback at a wrong time and break invariants.',
            ),
            buildCaveatTile(
              icon: Icons.engineering,
              title: 'Test isolation',
              body:
                  'For unit tests you can construct a private '
                  'PointerSignalResolver() and exercise register/resolve '
                  'directly. The framework binding will not see it; that '
                  'is intentional.',
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildCaveatTile({
  required IconData icon,
  required String title,
  required String body,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: kInkDeep,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: kInkLine),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: kCrimsonAccent.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: kCrimsonAccent, size: 18.0),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                body,
                style: const TextStyle(
                  color: kMistMid,
                  fontSize: 12.0,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 11 — Footer / takeaways
// ===========================================================================
Widget buildFooter() {
  return Container(
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[kInkSoft, kInkMid, kInkDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: kCobaltCore.withValues(alpha: 0.45)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kCobaltCore.withValues(alpha: 0.25),
          blurRadius: 20.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.flag, color: kCobaltGlow),
            const SizedBox(width: 10.0),
            const Text(
              'Takeaways',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            buildTakeawayBlock(
              tint: kCobaltCore,
              icon: Icons.alt_route,
              text:
                  'PointerSignalResolver mediates ambiguity for discrete '
                  'pointer signals: scroll, scale, inertia-cancel.',
            ),
            buildTakeawayBlock(
              tint: kMagentaCore,
              icon: Icons.flag,
              text:
                  'Only the FIRST register() per event wins. Reverse '
                  'dispatch makes inner listeners win by default.',
            ),
            buildTakeawayBlock(
              tint: kMintCore,
              icon: Icons.public,
              text:
                  'Use GestureBinding.instance.pointerSignalResolver in '
                  'real apps. Construct your own only for tests.',
            ),
            buildTakeawayBlock(
              tint: kAmberAccent,
              icon: Icons.balance,
              text:
                  'It is NOT the gesture arena. Two separate routing '
                  'systems handle gestures vs pointer signals.',
            ),
            buildTakeawayBlock(
              tint: kCrimsonAccent,
              icon: Icons.timer,
              text:
                  'Registration is per-event and synchronous. There is no '
                  'persistent subscription to manage.',
            ),
            buildTakeawayBlock(
              tint: kEmeraldAccent,
              icon: Icons.check_circle,
              text:
                  'When in doubt: wrap with Listener.onPointerSignal and '
                  'call resolver.register(event, cb) — the framework '
                  'handles the rest.',
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 10.0,
          ),
          decoration: BoxDecoration(
            color: kCobaltCore.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: kCobaltCore.withValues(alpha: 0.45),
            ),
          ),
          child: Row(
            children: <Widget>[
              const Icon(
                Icons.menu_book,
                color: kCobaltGlow,
                size: 16.0,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Reference: PointerSignalResolver in '
                  'package:flutter/gestures.dart — see Flutter source '
                  'lib/src/gestures/pointer_signal_resolver.dart.',
                  style: TextStyle(
                    color: kCobaltGlow.withValues(alpha: 0.95),
                    fontSize: 12.0,
                    fontFamily: 'monospace',
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

Widget buildTakeawayBlock({
  required Color tint,
  required IconData icon,
  required String text,
}) {
  return SizedBox(
    width: 320.0,
    child: Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: tint.withValues(alpha: 0.55)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: tint, size: 18.0),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: kMistPale,
                fontSize: 12.0,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
