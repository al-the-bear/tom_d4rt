// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
// D4rt deep visual demo: Focus traversal advanced.
//
// Theme: lighthouse / harbor — beacons sweeping in defined order, ships
// queueing into berths the way focus queues through traversal policies.
// Palette: midnight navy, harbor mist, brass-lamp gold, foam white, signal
// red. Each section is a hand-built panel; no setState, no controllers,
// no Future, no Stream — only declarative widgets demonstrating the
// shape and behaviour of FocusTraversalGroup, FocusTraversalPolicy and
// its subclasses, plus the supporting types: NumericFocusOrder,
// LexicalFocusOrder, TraversalDirection,
// DirectionalFocusTraversalPolicyMixin and RawKeyboardListener.
//
// Sections (top → bottom):
//   1.  Hero banner (lighthouse logbook).
//   2.  Anatomy of FocusTraversalGroup (decomposed schematic).
//   3.  Policy snapshot — WidgetOrderTraversalPolicy.
//   4.  Policy snapshot — ReadingOrderTraversalPolicy.
//   5.  Policy snapshot — OrderedTraversalPolicy + NumericFocusOrder.
//   6.  Policy snapshot — OrderedTraversalPolicy + LexicalFocusOrder.
//   7.  Side-by-side comparison strip.
//   8.  NumericFocusOrder explainer (number line + comparator behaviour).
//   9.  LexicalFocusOrder explainer (string compareTo behaviour).
//   10. TraversalDirection enum cards (up / down / left / right).
//   11. DirectionalFocusTraversalPolicyMixin explainer.
//   12. Tab vs Shift-Tab vs arrow-key behaviour matrix.
//   13. RawKeyboardListener wiring sketch.
//   14. FocusNode lifecycle trace (request, has, dispose).
//   15. Common pitfalls catalogue.
//   16. Accessibility callouts.
//   17. Footer / colophon.
//
// The demo is one top-level `dynamic build(BuildContext context)` returning a
// MaterialApp. Single import: `package:flutter/material.dart`. No main(),
// no runApp(). All FocusTraversalGroup / Focus widgets are real and
// rendered; the framework manages the underlying nodes — we never mutate
// a FocusNode in build, never schedule timers and never spin up async
// work. Visual ordering numbers on each grid mirror the policy's
// traversal sequence so a reader can compare side-by-side.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette ──────────────────────────────────────────────────────────
  const Color cNavy = Color(0xFF0E1B2C);
  const Color cNavyDeep = Color(0xFF071224);
  const Color cNavyMist = Color(0xFF1B2D44);
  const Color cHarbor = Color(0xFF2F4866);
  const Color cFog = Color(0xFFE7EEF5);
  const Color cFogDeep = Color(0xFFC8D5E2);
  const Color cFoam = Color(0xFFF7FAFC);
  const Color cBrass = Color(0xFFD4A24A);
  const Color cBrassDeep = Color(0xFF8C6A24);
  const Color cBrassPale = Color(0xFFF1DCA9);
  const Color cBeacon = Color(0xFFFFD986);
  const Color cSignal = Color(0xFFD64541);
  const Color cSignalDeep = Color(0xFF8E2A26);
  const Color cTeal = Color(0xFF2C8A99);
  const Color cTealDeep = Color(0xFF18525B);
  const Color cMoss = Color(0xFF5C7848);
  const Color cInk = Color(0xFF101820);
  const Color cInkFade = Color(0xFF34404C);
  const Color cRope = Color(0xFFB78A4F);

  // ── Tiny atoms / helpers ─────────────────────────────────────────────
  Widget gap(double h) => SizedBox(height: h);
  Widget hgap(double w) => SizedBox(width: w);

  Widget chip(String label, Color bg, Color fg, {double radius = 999}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: fg.withValues(alpha: 0.35), width: 0.8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget pill(String left, String right, Color border, Color bg) {
    return Container(
      margin: EdgeInsets.only(right: 8, bottom: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: border,
              borderRadius:
                  BorderRadius.only(
                    topLeft: Radius.circular(14),
                    bottomLeft: Radius.circular(14),
                  ),
            ),
            child: Text(
              left,
              style: TextStyle(
                color: cFoam,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              right,
              style: TextStyle(
                color: border,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(String number, String title, String subtitle) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 14, top: 8),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [cNavy, cNavyMist],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: cBrass, width: 6)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 46,
            height: 46,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: cBrass,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: cBrassDeep, width: 2),
            ),
            child: Text(
              number,
              style: TextStyle(
                color: cInk,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          hgap(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: cFoam,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                  ),
                ),
                gap(3),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: cBrassPale.withValues(alpha: 0.85),
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget paragraph(String body, {Color color = cInkFade}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Text(
        body,
        style: TextStyle(fontSize: 12.5, height: 1.55, color: color),
      ),
    );
  }

  Widget bullet(String body, {Color dot = cBrass, Color text = cInk}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 6, right: 10),
            width: 7,
            height: 7,
            decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
          ),
          Expanded(
            child: Text(
              body,
              style: TextStyle(fontSize: 12, height: 1.5, color: text),
            ),
          ),
        ],
      ),
    );
  }

  Widget codeLine(String code, {Color bg = cNavyDeep, Color fg = cBrassPale}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 2),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: cBrassDeep.withValues(alpha: 0.4)),
      ),
      child: Text(
        code,
        style: TextStyle(
          color: fg,
          fontFamily: 'monospace',
          fontSize: 11.5,
          height: 1.45,
        ),
      ),
    );
  }

  Widget noteBox(String text, Color border, Color bg) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: Border(left: BorderSide(color: border, width: 4)),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 12, height: 1.55, color: border),
      ),
    );
  }

  Widget panelShell({
    required String tag,
    required String title,
    required Color accent,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: cFoam,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.35), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(13),
                topRight: Radius.circular(13),
              ),
              border: Border(
                bottom: BorderSide(
                  color: accent.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      color: cFoam,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                hgap(10),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: cInk,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(14), child: child),
        ],
      ),
    );
  }

  // ── Focusable cell (rendered, no controllers) ────────────────────────
  // Each cell shows: a visible focus order index, a label, and uses a real
  // Focus widget so the FocusTraversalGroup wrapping it has actual nodes
  // to enumerate. We never call requestFocus/dispose — the framework
  // handles that. The number on the chip is the order the active policy
  // would deliver focus (precomputed for the demo so the reader can see
  // "this is what tab order looks like for this policy").
  Widget focusableCell({
    required String label,
    required int orderIndex,
    required Color accent,
    Color? bg,
  }) {
    return Focus(
      child: Container(
        margin: EdgeInsets.all(4),
        height: 56,
        decoration: BoxDecoration(
          color: bg ?? cFog,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: accent.withValues(alpha: 0.55), width: 1.4),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 4,
              left: 6,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '#$orderIndex',
                  style: TextStyle(
                    color: cFoam,
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                label,
                style: TextStyle(
                  color: cInk,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget arrow(String label, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          fontFamily: 'monospace',
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────
  // 1. HERO BANNER — lighthouse logbook
  // ─────────────────────────────────────────────────────────────────────
  Widget hero = Container(
    width: double.infinity,
    padding: EdgeInsets.fromLTRB(28, 30, 28, 30),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [cNavyDeep, cNavy, cNavyMist, cHarbor],
      ),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: cBrass, width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 56,
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: cBeacon,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: cBrassDeep, width: 2),
              ),
              child: Text(
                'F',
                style: TextStyle(
                  color: cInk,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            hgap(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FOCUS TRAVERSAL — DEEP DEMO',
                    style: TextStyle(
                      color: cBrassPale,
                      fontSize: 12,
                      letterSpacing: 4,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  gap(4),
                  Text(
                    'The lighthouse logbook',
                    style: TextStyle(
                      color: cFoam,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                  ),
                  gap(4),
                  Text(
                    'FocusTraversalGroup, FocusTraversalPolicy and friends.',
                    style: TextStyle(
                      color: cBrassPale,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        gap(20),
        Wrap(
          children: [
            pill('GROUP', 'FocusTraversalGroup', cBrass, cFoam),
            pill('POLICY', 'FocusTraversalPolicy', cTeal, cFoam),
            pill('ORDER', 'NumericFocusOrder', cSignal, cFoam),
            pill('ORDER', 'LexicalFocusOrder', cMoss, cFoam),
            pill('DIRS', 'TraversalDirection', cBrassDeep, cFoam),
            pill('MIXIN', 'DirectionalFocusTraversalPolicyMixin', cTealDeep,
                cFoam),
            pill('KEYS', 'RawKeyboardListener', cSignalDeep, cFoam),
          ],
        ),
        gap(10),
        Text(
          'A guided tour of how Flutter decides which control receives '
          'focus next when the user presses Tab, Shift-Tab or one of the '
          'arrow keys. Every panel below renders real focusable widgets '
          'inside real FocusTraversalGroups so the policy choice is not '
          'just described, it is enacted.',
          style: TextStyle(color: cFog, fontSize: 12.5, height: 1.6),
        ),
      ],
    ),
  );

  // ─────────────────────────────────────────────────────────────────────
  // 2. ANATOMY OF FocusTraversalGroup
  // ─────────────────────────────────────────────────────────────────────
  Widget anatomy = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      paragraph(
        'A FocusTraversalGroup wraps a subtree and supplies a '
        'FocusTraversalPolicy that decides the order of focusables within '
        'it. Groups can nest: an outer group will visit each inner group '
        'as a single unit, descending into the inner policy when the '
        'outer policy reaches the boundary.',
      ),
      gap(8),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cNavyDeep,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: cBrass, width: 1.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FocusTraversalGroup(',
              style: TextStyle(
                color: cBrassPale,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'policy: WidgetOrderTraversalPolicy(),',
                style: TextStyle(
                  color: cFoam,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'descendantsAreFocusable: true,',
                style: TextStyle(
                  color: cFoam,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'descendantsAreTraversable: true,',
                style: TextStyle(
                  color: cFoam,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'child: <subtree>,',
                style: TextStyle(
                  color: cFoam,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
            Text(
              ')',
              style: TextStyle(
                color: cBrassPale,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      gap(10),
      bullet('policy — selects ordering algorithm; defaults to '
          'ReadingOrderTraversalPolicy when none is given.'),
      bullet('descendantsAreFocusable — when false, every Focus inside '
          'the subtree refuses focus, including via traversal.'),
      bullet('descendantsAreTraversable — when false, the subtree is '
          'reachable via direct requestFocus() but skipped by Tab.'),
      bullet('child — typical Flutter child slot; Form/Column/Grid/etc.'),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  // 3-6. POLICY SNAPSHOTS — four 3x3 grids, each wrapped in a real
  // FocusTraversalGroup. The number on every cell is the index that
  // policy would deliver focus to (1-based) starting from the top-left
  // entry of the group.
  // ─────────────────────────────────────────────────────────────────────

  // Helper: wrap nine cells in a 3x3 grid laid out by row-major children.
  Widget gridOf(List<Widget> nine) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: nine[0]),
            Expanded(child: nine[1]),
            Expanded(child: nine[2]),
          ],
        ),
        Row(
          children: [
            Expanded(child: nine[3]),
            Expanded(child: nine[4]),
            Expanded(child: nine[5]),
          ],
        ),
        Row(
          children: [
            Expanded(child: nine[6]),
            Expanded(child: nine[7]),
            Expanded(child: nine[8]),
          ],
        ),
      ],
    );
  }

  // Snapshot 3 — WidgetOrderTraversalPolicy. Order follows the order in
  // which Focus widgets are described in the widget tree (left-to-right
  // children of each Row, then next Row).
  Widget snapshotWidgetOrder = panelShell(
    tag: 'POLICY 1',
    title: 'WidgetOrderTraversalPolicy — tree order',
    accent: cBrass,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Visits focusables in the order they appear in the widget tree '
          '(depth-first). Predictable and great when your UI mirrors the '
          'logical reading order of the form.',
          style: TextStyle(color: cInkFade, fontSize: 12, height: 1.5),
        ),
        gap(10),
        FocusTraversalGroup(
          policy: WidgetOrderTraversalPolicy(),
          child: gridOf([
            focusableCell(label: 'A', orderIndex: 1, accent: cBrass),
            focusableCell(label: 'B', orderIndex: 2, accent: cBrass),
            focusableCell(label: 'C', orderIndex: 3, accent: cBrass),
            focusableCell(label: 'D', orderIndex: 4, accent: cBrass),
            focusableCell(label: 'E', orderIndex: 5, accent: cBrass),
            focusableCell(label: 'F', orderIndex: 6, accent: cBrass),
            focusableCell(label: 'G', orderIndex: 7, accent: cBrass),
            focusableCell(label: 'H', orderIndex: 8, accent: cBrass),
            focusableCell(label: 'I', orderIndex: 9, accent: cBrass),
          ]),
        ),
        gap(8),
        codeLine('FocusTraversalGroup(policy: WidgetOrderTraversalPolicy(),'),
        codeLine('  child: Column(children: [Row(...), Row(...), Row(...)])'),
        codeLine(')'),
      ],
    ),
  );

  // Snapshot 4 — ReadingOrderTraversalPolicy. For a left-to-right
  // language, reading order produces the same order on a clean grid as
  // WidgetOrder, but unlike WidgetOrder it is geometric: it inspects
  // each focusable's rect and sorts by top, then left. Useful when the
  // visual layout does not match tree order (e.g. Stacks, manual
  // Positioned widgets).
  Widget snapshotReadingOrder = panelShell(
    tag: 'POLICY 2',
    title: 'ReadingOrderTraversalPolicy — visual reading order',
    accent: cTeal,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sorts focusables by their on-screen rectangles using the '
          'ambient text direction. Top-to-bottom, then leading-to-trailing '
          '(left-to-right in LTR). The default policy of FocusTraversalGroup.',
          style: TextStyle(color: cInkFade, fontSize: 12, height: 1.5),
        ),
        gap(10),
        FocusTraversalGroup(
          policy: ReadingOrderTraversalPolicy(),
          child: gridOf([
            focusableCell(label: 'A', orderIndex: 1, accent: cTeal),
            focusableCell(label: 'B', orderIndex: 2, accent: cTeal),
            focusableCell(label: 'C', orderIndex: 3, accent: cTeal),
            focusableCell(label: 'D', orderIndex: 4, accent: cTeal),
            focusableCell(label: 'E', orderIndex: 5, accent: cTeal),
            focusableCell(label: 'F', orderIndex: 6, accent: cTeal),
            focusableCell(label: 'G', orderIndex: 7, accent: cTeal),
            focusableCell(label: 'H', orderIndex: 8, accent: cTeal),
            focusableCell(label: 'I', orderIndex: 9, accent: cTeal),
          ]),
        ),
        gap(8),
        codeLine(
          'FocusTraversalGroup(policy: ReadingOrderTraversalPolicy(), ...)',
        ),
        codeLine('// In RTL locales, leading is right; the policy adapts.'),
      ],
    ),
  );

  // Snapshot 5 — OrderedTraversalPolicy + NumericFocusOrder. Each cell
  // is wrapped in FocusTraversalOrder with a numeric weight that the
  // policy uses to sort. We deliberately scramble the tree so the
  // numeric override is what determines order.
  Widget snapshotNumeric = panelShell(
    tag: 'POLICY 3',
    title: 'OrderedTraversalPolicy + NumericFocusOrder',
    accent: cSignal,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'OrderedTraversalPolicy reads FocusTraversalOrder annotations and '
          'sorts ascending. NumericFocusOrder uses a double — fractional '
          'weights work, ties fall back to the supplementary policy.',
          style: TextStyle(color: cInkFade, fontSize: 12, height: 1.5),
        ),
        gap(10),
        FocusTraversalGroup(
          policy: OrderedTraversalPolicy(),
          child: gridOf([
            FocusTraversalOrder(
              order: NumericFocusOrder(7),
              child: focusableCell(label: '7', orderIndex: 7, accent: cSignal),
            ),
            FocusTraversalOrder(
              order: NumericFocusOrder(2),
              child: focusableCell(label: '2', orderIndex: 2, accent: cSignal),
            ),
            FocusTraversalOrder(
              order: NumericFocusOrder(5),
              child: focusableCell(label: '5', orderIndex: 5, accent: cSignal),
            ),
            FocusTraversalOrder(
              order: NumericFocusOrder(1),
              child: focusableCell(label: '1', orderIndex: 1, accent: cSignal),
            ),
            FocusTraversalOrder(
              order: NumericFocusOrder(9),
              child: focusableCell(label: '9', orderIndex: 9, accent: cSignal),
            ),
            FocusTraversalOrder(
              order: NumericFocusOrder(3),
              child: focusableCell(label: '3', orderIndex: 3, accent: cSignal),
            ),
            FocusTraversalOrder(
              order: NumericFocusOrder(8),
              child: focusableCell(label: '8', orderIndex: 8, accent: cSignal),
            ),
            FocusTraversalOrder(
              order: NumericFocusOrder(4),
              child: focusableCell(label: '4', orderIndex: 4, accent: cSignal),
            ),
            FocusTraversalOrder(
              order: NumericFocusOrder(6),
              child: focusableCell(label: '6', orderIndex: 6, accent: cSignal),
            ),
          ]),
        ),
        gap(8),
        codeLine('FocusTraversalOrder(order: NumericFocusOrder(2.5),'),
        codeLine('  child: TextField(...))   // sorts before 3, after 2'),
      ],
    ),
  );

  // Snapshot 6 — OrderedTraversalPolicy + LexicalFocusOrder. Sort by
  // string compareTo. Useful when keys are easier to express as words
  // ("city" before "country" before "zip") than as numbers.
  Widget snapshotLexical = panelShell(
    tag: 'POLICY 4',
    title: 'OrderedTraversalPolicy + LexicalFocusOrder',
    accent: cMoss,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'LexicalFocusOrder uses String.compareTo. Mind upper-case vs '
          'lower-case (capitals sort first in ASCII). Use leading zeros '
          'for stable mixed-numeric strings: "01", "02", ..., "10".',
          style: TextStyle(color: cInkFade, fontSize: 12, height: 1.5),
        ),
        gap(10),
        FocusTraversalGroup(
          policy: OrderedTraversalPolicy(),
          child: gridOf([
            FocusTraversalOrder(
              order: LexicalFocusOrder('grape'),
              child: focusableCell(
                  label: 'grape', orderIndex: 6, accent: cMoss),
            ),
            FocusTraversalOrder(
              order: LexicalFocusOrder('apple'),
              child: focusableCell(
                  label: 'apple', orderIndex: 1, accent: cMoss),
            ),
            FocusTraversalOrder(
              order: LexicalFocusOrder('cherry'),
              child: focusableCell(
                  label: 'cherry', orderIndex: 3, accent: cMoss),
            ),
            FocusTraversalOrder(
              order: LexicalFocusOrder('banana'),
              child: focusableCell(
                  label: 'banana', orderIndex: 2, accent: cMoss),
            ),
            FocusTraversalOrder(
              order: LexicalFocusOrder('iris'),
              child: focusableCell(
                  label: 'iris', orderIndex: 8, accent: cMoss),
            ),
            FocusTraversalOrder(
              order: LexicalFocusOrder('elder'),
              child: focusableCell(
                  label: 'elder', orderIndex: 5, accent: cMoss),
            ),
            FocusTraversalOrder(
              order: LexicalFocusOrder('hazel'),
              child: focusableCell(
                  label: 'hazel', orderIndex: 7, accent: cMoss),
            ),
            FocusTraversalOrder(
              order: LexicalFocusOrder('date'),
              child: focusableCell(
                  label: 'date', orderIndex: 4, accent: cMoss),
            ),
            FocusTraversalOrder(
              order: LexicalFocusOrder('juniper'),
              child: focusableCell(
                  label: 'juniper', orderIndex: 9, accent: cMoss),
            ),
          ]),
        ),
        gap(8),
        codeLine("LexicalFocusOrder('row01-col02')   // recommended pattern"),
      ],
    ),
  );

  // ─────────────────────────────────────────────────────────────────────
  // 7. SIDE-BY-SIDE COMPARISON STRIP — small recap row.
  // ─────────────────────────────────────────────────────────────────────
  Widget comparisonRow(String name, String rule, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              name,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
              ),
            ),
          ),
          hgap(8),
          Expanded(
            child: Text(
              rule,
              style: TextStyle(
                color: cInk,
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget comparisonStrip = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      paragraph(
        'A quick recap so the four panels above are easy to recall later. '
        'Pick the simplest policy that produces the order you want — '
        'WidgetOrder for plain forms, ReadingOrder when geometry diverges '
        'from tree order, OrderedTraversalPolicy when neither matches.',
      ),
      gap(8),
      comparisonRow(
        'WidgetOrder',
        'Tree order. Stable, fast, ignores geometry. The right choice when '
        'your column reads top-to-bottom in code order.',
        cBrass,
      ),
      comparisonRow(
        'ReadingOrder',
        'Visual rectangle order. Top-then-leading. Adapts to RTL. Default '
        'policy for FocusTraversalGroup.',
        cTeal,
      ),
      comparisonRow(
        'Ordered + Numeric',
        'Explicit doubles. Best for dynamic layouts where you want to '
        'inject items at fractional positions (1.5 between 1 and 2).',
        cSignal,
      ),
      comparisonRow(
        'Ordered + Lexical',
        'Strings via compareTo. Use sortable keys, e.g. zero-padded '
        'numbers or hierarchical names ("section.subsection.field").',
        cMoss,
      ),
      comparisonRow(
        'Directional (mixin)',
        'Adds findFirstFocusInDirection used by all policies for arrow '
        'keys. Always present on every traversal policy.',
        cTealDeep,
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  // 8. NumericFocusOrder explainer — a number-line illustration.
  // ─────────────────────────────────────────────────────────────────────
  Widget numberMarker(double value, String label, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Column(
        children: [
          Text(
            value.toString(),
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w900,
              fontFamily: 'monospace',
            ),
          ),
          Text(
            label,
            style: TextStyle(color: cInkFade, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget numericExplainer = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      paragraph(
        'NumericFocusOrder wraps a double. Values are compared by '
        'compareTo, which is identical to the natural ordering of '
        'doubles (NaN excluded — never use NaN). Equal values fall back '
        'to the supplementary secondary policy of OrderedTraversalPolicy '
        '(by default ReadingOrderTraversalPolicy).',
      ),
      gap(8),
      Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cFog,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: cSignal.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            numberMarker(0.5, 'first', cSignalDeep),
            arrow('→', cSignal),
            numberMarker(1.0, 'second', cSignalDeep),
            arrow('→', cSignal),
            numberMarker(1.5, 'inserted', cBrass),
            arrow('→', cSignal),
            numberMarker(2.0, 'third', cSignalDeep),
            arrow('→', cSignal),
            numberMarker(10.0, 'last', cSignalDeep),
          ],
        ),
      ),
      gap(8),
      bullet(
        'Insert between existing items by choosing a midpoint value: '
        'between 2.0 and 3.0 use 2.5, then 2.25, etc.',
        dot: cSignal,
      ),
      bullet(
        'Negative numbers are valid; use them for items that should '
        'precede everything, e.g. a "skip to content" link at -1.0.',
        dot: cSignal,
      ),
      bullet(
        'Comparator returns sign of (a.order - b.order). Tie behaviour '
        'falls through to the secondary policy.',
        dot: cSignal,
      ),
      gap(8),
      codeLine('class NumericFocusOrder extends FocusOrder {'),
      codeLine('  const NumericFocusOrder(this.order);'),
      codeLine('  final double order;'),
      codeLine('  int doCompare(NumericFocusOrder other) =>'),
      codeLine('      order.compareTo(other.order);'),
      codeLine('}'),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  // 9. LexicalFocusOrder explainer.
  // ─────────────────────────────────────────────────────────────────────
  Widget lexRow(String left, String right, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              left,
              style: TextStyle(
                color: color,
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          arrow('→', color),
          hgap(8),
          Expanded(
            child: Text(
              right,
              style: TextStyle(color: cInk, fontSize: 11.5, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget lexicalExplainer = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      paragraph(
        'LexicalFocusOrder wraps a String and compares with String.compareTo. '
        'That uses UTF-16 code-unit ordering — capitals sort before '
        'lower-case letters, "10" sorts before "2". The fix for both is '
        'to design keys that sort the way you read them.',
      ),
      gap(6),
      lexRow('"alpha"', '< "beta"  (a < b)', cMoss),
      lexRow('"Beta"', '< "alpha" (capital B = 0x42 < a = 0x61)', cMoss),
      lexRow('"item-2"', '> "item-10" (because "-" then "2" > "1")', cMoss),
      lexRow('"item-02"', '< "item-10" (zero-padded fixes mixed numeric)',
          cMoss),
      gap(6),
      bullet(
        'Lower-case everything before passing to LexicalFocusOrder if '
        'mixing user-supplied strings.',
        dot: cMoss,
      ),
      bullet(
        'Zero-pad numeric segments. Five-digit padding suffices for most '
        'forms ("00001", "00002", ...).',
        dot: cMoss,
      ),
      bullet(
        'Hierarchical paths sort naturally: "personal.name", '
        '"personal.email", "address.street" — but only if the path '
        'segments themselves are stable.',
        dot: cMoss,
      ),
      gap(8),
      codeLine('class LexicalFocusOrder extends FocusOrder {'),
      codeLine('  const LexicalFocusOrder(this.order);'),
      codeLine('  final String order;'),
      codeLine('  int doCompare(LexicalFocusOrder other) =>'),
      codeLine('      order.compareTo(other.order);'),
      codeLine('}'),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  // 10. TraversalDirection enum cards (up / down / left / right)
  // ─────────────────────────────────────────────────────────────────────
  Widget directionCard(
    String name,
    String key,
    IconData icon,
    String description,
    Color color,
  ) {
    return Container(
      margin: EdgeInsets.all(6),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: cFoam, size: 18),
              ),
              hgap(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: color,
                        fontFamily: 'monospace',
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      key,
                      style: TextStyle(
                        color: cInkFade,
                        fontSize: 10.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          gap(8),
          Text(
            description,
            style: TextStyle(color: cInk, fontSize: 11.5, height: 1.45),
          ),
        ],
      ),
    );
  }

  Widget directionEnumCards = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      paragraph(
        'TraversalDirection is the enum passed to '
        'inDirection / focusInDirection. Four values, one per arrow key. '
        'It is the lingua franca between key handlers and the policy: '
        'the policy maps a TraversalDirection to "next focusable in that '
        'direction" using DirectionalFocusTraversalPolicyMixin.',
      ),
      gap(8),
      Row(
        children: [
          Expanded(
            child: directionCard(
              'TraversalDirection.up',
              'arrow up / W',
              Icons.arrow_upward,
              'Find the nearest focusable above the current focus rect.',
              cTeal,
            ),
          ),
          Expanded(
            child: directionCard(
              'TraversalDirection.down',
              'arrow down / S',
              Icons.arrow_downward,
              'Find the nearest focusable below the current focus rect.',
              cTeal,
            ),
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            child: directionCard(
              'TraversalDirection.left',
              'arrow left / A',
              Icons.arrow_back,
              'Find the nearest focusable to the leading side.',
              cBrass,
            ),
          ),
          Expanded(
            child: directionCard(
              'TraversalDirection.right',
              'arrow right / D',
              Icons.arrow_forward,
              'Find the nearest focusable to the trailing side.',
              cBrass,
            ),
          ),
        ],
      ),
      gap(6),
      noteBox(
        'There is no diagonal direction. Diagonal handlers must dispatch '
        'two single-step calls or compute the target manually — keep '
        'composite gestures out of policy logic.',
        cTealDeep,
        cFog,
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  // 11. DirectionalFocusTraversalPolicyMixin explainer.
  // ─────────────────────────────────────────────────────────────────────
  Widget directionalMixin = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      paragraph(
        'DirectionalFocusTraversalPolicyMixin is mixed into every concrete '
        'FocusTraversalPolicy. It supplies geometric search routines used '
        'when the user presses an arrow key — they answer "given the '
        'current focus rect and a TraversalDirection, which focusable is '
        'closest in that direction?".',
      ),
      gap(6),
      bullet(
        'inDirection(node, direction) — public API; called by every '
        'arrow-key intent.',
        dot: cTealDeep,
      ),
      bullet(
        'findFirstFocusInDirection(node, direction) — protected; locates '
        'the first traversal candidate, ignoring axis-misaligned items.',
        dot: cTealDeep,
      ),
      bullet(
        'sortDescendants(descendants, currentNode) — overridden by each '
        'concrete subclass to order forward (Tab) traversal.',
        dot: cTealDeep,
      ),
      gap(8),
      Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cNavyDeep,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'mixin DirectionalFocusTraversalPolicyMixin',
              style: TextStyle(
                color: cBeacon,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
            Text(
              '    on FocusTraversalPolicy {',
              style: TextStyle(
                color: cBeacon,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
            Text(
              '  bool inDirection(FocusNode current,',
              style: TextStyle(
                color: cFoam,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
            Text(
              '                   TraversalDirection dir) { ... }',
              style: TextStyle(
                color: cFoam,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
            Text(
              '}',
              style: TextStyle(
                color: cBeacon,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      gap(8),
      noteBox(
        'Because the mixin is on the base class, every traversal policy — '
        'including custom ones — already supports arrow-key navigation '
        'without you wiring anything special. Just press the arrow keys.',
        cTeal,
        cFog,
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  // 12. Tab vs Shift-Tab vs arrow-key matrix.
  // ─────────────────────────────────────────────────────────────────────
  TableRow keyRow(String key, String forward, String reverse,
      {Color color = cInk, bool head = false}) {
    final TextStyle style = TextStyle(
      color: head ? cBrass : color,
      fontSize: 12,
      fontWeight: head ? FontWeight.w800 : FontWeight.w500,
      fontFamily: head ? 'monospace' : null,
      height: 1.4,
    );
    return TableRow(
      decoration: BoxDecoration(
        color: head ? cNavy : cFoam,
      ),
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(key, style: style),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(forward, style: style),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(reverse, style: style),
        ),
      ],
    );
  }

  Widget keyMatrix = Table(
    columnWidths: const {
      0: FlexColumnWidth(1.0),
      1: FlexColumnWidth(2.4),
      2: FlexColumnWidth(2.4),
    },
    border: TableBorder.all(color: cFogDeep, width: 1),
    children: [
      keyRow('Key', 'Forward (default)', 'Reverse / opposite', head: true),
      keyRow(
        'Tab',
        'Calls nextFocus() on the primary focus.',
        'Shift+Tab calls previousFocus() — same policy in reverse.',
      ),
      keyRow(
        'Arrow ↑',
        'inDirection(TraversalDirection.up).',
        'Shift+Arrow does not invert the direction.',
      ),
      keyRow(
        'Arrow ↓',
        'inDirection(TraversalDirection.down).',
        'No reverse pair; left/right are independent axes.',
      ),
      keyRow(
        'Arrow ←',
        'inDirection(TraversalDirection.left) — leading in LTR.',
        'In RTL, "left" still maps to physical left — the policy adapts '
            'reading order, but TraversalDirection is geometric.',
      ),
      keyRow(
        'Arrow →',
        'inDirection(TraversalDirection.right) — trailing in LTR.',
        'Pairs with Arrow ←; both ignore Tab order entirely.',
      ),
      keyRow(
        'Enter',
        'Activates the focused control (ButtonActivateIntent).',
        'Does not change focus by itself.',
      ),
      keyRow(
        'Esc',
        'Triggers DismissIntent — typically returns focus to the parent.',
        'Not part of traversal but commonly tied to focus management.',
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  // 13. RawKeyboardListener wiring sketch.
  //
  // RawKeyboardListener is a low-level escape hatch: when the platform
  // sends a raw key event you can short-circuit it before traversal sees
  // it. Use sparingly — Shortcuts/Actions is the high-level idiom.
  // ─────────────────────────────────────────────────────────────────────
  Widget rawKeyboardSketch = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      paragraph(
        'RawKeyboardListener forwards raw key events to a callback. It is '
        'still useful when you want to react to a global key (F1, Esc, '
        'Ctrl+S) without registering a Shortcut at every level of the '
        'tree. Combine it with FocusTraversalGroup by placing the '
        'listener high enough to see all keys before the traversal '
        'machinery consumes them.',
      ),
      gap(6),
      Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cNavyDeep,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "RawKeyboardListener(",
              style: TextStyle(
                color: cBrassPale,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                "focusNode: rootFocus,",
                style: TextStyle(
                  color: cFoam,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                "onKey: (RawKeyEvent event) {",
                style: TextStyle(
                  color: cFoam,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 32),
              child: Text(
                "if (event is RawKeyDownEvent &&",
                style: TextStyle(
                  color: cFoam,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 48),
              child: Text(
                "event.logicalKey == LogicalKeyboardKey.tab) {",
                style: TextStyle(
                  color: cFoam,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 64),
              child: Text(
                "// Custom Tab handling here.",
                style: TextStyle(
                  color: cBeacon,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 32),
              child: Text(
                "}",
                style: TextStyle(
                  color: cFoam,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                "},",
                style: TextStyle(
                  color: cFoam,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                "child: FocusTraversalGroup(...),",
                style: TextStyle(
                  color: cFoam,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
            Text(
              ")",
              style: TextStyle(
                color: cBrassPale,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      gap(6),
      bullet(
        'Returning KeyEventResult.handled stops propagation; '
        'KeyEventResult.ignored lets the framework continue.',
        dot: cSignalDeep,
      ),
      bullet(
        'Migrate to HardwareKeyboard / KeyboardListener for new code — '
        'RawKeyboardListener is on the deprecation path.',
        dot: cSignalDeep,
      ),
      bullet(
        'For idiomatic shortcuts use Shortcuts + Actions: cleaner, more '
        'composable and cooperates with FocusTraversalGroup automatically.',
        dot: cSignalDeep,
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  // 14. FocusNode lifecycle trace.
  //
  // Although our build() does not allocate a FocusNode, every Focus
  // widget allocates one for us. This panel describes the lifecycle in
  // text + diagram form.
  // ─────────────────────────────────────────────────────────────────────
  Widget lifecycleStep(int step, String name, String desc, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              step.toString(),
              style: TextStyle(
                color: cFoam,
                fontWeight: FontWeight.w900,
                fontSize: 14,
              ),
            ),
          ),
          hgap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w800,
                    fontSize: 12.5,
                    fontFamily: 'monospace',
                  ),
                ),
                gap(3),
                Text(
                  desc,
                  style: TextStyle(
                    color: cInk,
                    fontSize: 11.5,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget lifecyclePanel = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      paragraph(
        'A FocusNode is created (explicitly or by Focus()), attached to '
        'the FocusManager during the first build, can be made the primary '
        'focus, fires notifications when its hasFocus changes, and finally '
        'must be disposed if you owned it.',
      ),
      lifecycleStep(
        1,
        'allocate',
        'FocusNode(debugLabel: "...") or implicit via Focus() child.',
        cBrass,
      ),
      lifecycleStep(
        2,
        'attach',
        'attach(BuildContext) is called by Focus.didChangeDependencies. '
        'The node is now reachable through FocusManager.instance.',
        cTeal,
      ),
      lifecycleStep(
        3,
        'request',
        'requestFocus() — moves primary focus, runs ChangeNotifier '
        'callbacks, schedules a re-paint.',
        cSignal,
      ),
      lifecycleStep(
        4,
        'traverse',
        'Tab / arrow keys ask the policy for nextFocus / inDirection. '
        'The chosen node receives requestFocus().',
        cMoss,
      ),
      lifecycleStep(
        5,
        'unfocus',
        'unfocus(disposition: ...) clears the node — UnfocusDisposition '
        'controls scope handling.',
        cTealDeep,
      ),
      lifecycleStep(
        6,
        'dispose',
        'dispose() detaches from the manager. Required when you own the '
        'node — Focus() owns its own node and cleans up automatically.',
        cSignalDeep,
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  // 15. Common pitfalls catalogue.
  // ─────────────────────────────────────────────────────────────────────
  Widget pitfallCard(String title, String body, Color border) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: cFog,
        borderRadius: BorderRadius.circular(10),
        border: Border(left: BorderSide(color: border, width: 5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: border,
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
            ),
          ),
          gap(4),
          Text(
            body,
            style: TextStyle(color: cInk, fontSize: 11.5, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget pitfalls = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      pitfallCard(
        'Forgetting that ReadingOrder is the default',
        'A bare FocusTraversalGroup uses ReadingOrderTraversalPolicy. If '
        'your tab order looks "off" first inspect that — sometimes the '
        'fix is to switch explicitly to WidgetOrderTraversalPolicy.',
        cBrass,
      ),
      pitfallCard(
        'Mixing Numeric and Lexical orders in one group',
        'OrderedTraversalPolicy is fine with multiple FocusOrder types — '
        'but compareTo throws if it cannot find a doCompare overload. '
        'Stick to one FocusOrder subclass per group.',
        cSignal,
      ),
      pitfallCard(
        'Lexical "10" sorting before "2"',
        'String.compareTo is code-unit based. Zero-pad your numeric '
        'segments or compose them deliberately ("00010" vs "00002").',
        cMoss,
      ),
      pitfallCard(
        'Forgetting descendantsAreTraversable',
        'A panel hidden offscreen is still traversable unless you set '
        'descendantsAreTraversable: false. Combining with ExcludeFocus is '
        'the cleanest way to skip a whole subtree without unmounting it.',
        cTeal,
      ),
      pitfallCard(
        'Disposing a FocusNode owned by Focus()',
        'If you wrap a Focus(child: ...) without supplying a focusNode, '
        'the widget owns the node. Calling dispose on it from outside '
        'crashes when the framework disposes it again.',
        cSignalDeep,
      ),
      pitfallCard(
        'Arrow keys "do nothing"',
        'Arrow-key traversal needs at least one focusable in that '
        'direction. Inside a single-row Row(), Up/Down do nothing — '
        'which is correct, but easy to misread as a bug.',
        cTealDeep,
      ),
      pitfallCard(
        'Using NumericFocusOrder with NaN',
        'NumericFocusOrder(double.nan).compareTo(any) is undefined and '
        'will likely surface as inconsistent traversal. Validate doubles.',
        cBrassDeep,
      ),
      pitfallCard(
        'Re-creating policy objects every build',
        'OK in practice — the cost is negligible — but if you carry state '
        'in a custom policy keep the instance stable via a const or via a '
        'StatefulWidget field.',
        cBrass,
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  // 16. Accessibility callouts.
  // ─────────────────────────────────────────────────────────────────────
  Widget a11yCard(String title, String body, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          hgap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                gap(3),
                Text(
                  body,
                  style: TextStyle(color: cInk, fontSize: 11.5, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget accessibility = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      a11yCard(
        'Match focus order to reading order',
        'Screen-reader users navigate forms by Tab. If the visual order '
        'does not match the underlying logical order, swap to '
        'ReadingOrderTraversalPolicy or supply explicit FocusTraversalOrder '
        'annotations.',
        Icons.menu_book_outlined,
        cTeal,
      ),
      a11yCard(
        'Visible focus indicators',
        'A traversal policy is only useful if the user can see where '
        'focus landed. Use FocusableActionDetector or explicit '
        'BoxDecoration changes on hasFocus to draw a visible ring.',
        Icons.visibility_outlined,
        cBrass,
      ),
      a11yCard(
        'Skip-to-content links',
        'Top-of-page "Skip to main content" links are real focusables '
        'with NumericFocusOrder(-1). They are first in tab order and '
        'usually only visible while focused.',
        Icons.fast_forward_outlined,
        cMoss,
      ),
      a11yCard(
        'Modal dialogs trap focus',
        'When a Dialog opens, wrap it in a FocusTraversalGroup so Tab '
        'cycles within the dialog. Use Navigator.popUntil or '
        'FocusScope.of(context).requestFocus to restore focus on close.',
        Icons.lock_outlined,
        cSignal,
      ),
      a11yCard(
        'RTL adapts ReadingOrder',
        'ReadingOrderTraversalPolicy uses Directionality.of(context). '
        'Wrap a panel in Directionality(textDirection: TextDirection.rtl) '
        'to test arabic / hebrew layouts.',
        Icons.swap_horiz,
        cTealDeep,
      ),
      a11yCard(
        'Arrow keys for grids',
        'A 2D grid (data tables, calendar, chess board) deserves arrow '
        'navigation in addition to Tab. The directional mixin already '
        'handles it — your job is to make the cells focusable.',
        Icons.grid_view,
        cBrassDeep,
      ),
    ],
  );

  // ─────────────────────────────────────────────────────────────────────
  // 17. Footer / colophon.
  // ─────────────────────────────────────────────────────────────────────
  Widget footer = Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 12, bottom: 4),
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [cNavy, cNavyDeep],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: cBrass, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'COLOPHON',
          style: TextStyle(
            color: cBrass,
            letterSpacing: 4,
            fontSize: 11,
            fontWeight: FontWeight.w800,
          ),
        ),
        gap(6),
        Text(
          'Focus traversal — deep demo',
          style: TextStyle(
            color: cFoam,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        gap(4),
        Text(
          'A hand-drawn tour of FocusTraversalGroup, the four built-in '
          'FocusTraversalPolicy implementations, NumericFocusOrder, '
          'LexicalFocusOrder, TraversalDirection, '
          'DirectionalFocusTraversalPolicyMixin and RawKeyboardListener. '
          'Every policy snapshot above is rendered with real Focus '
          'widgets so you can press Tab in a debug build and watch the '
          'highlight ring move in the order shown on each chip.',
          style: TextStyle(color: cFog, fontSize: 12, height: 1.55),
        ),
        gap(10),
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: [
            chip('flutter/material.dart', cNavyMist, cBeacon),
            chip('FocusTraversalGroup', cNavyMist, cBrass),
            chip('FocusTraversalPolicy', cNavyMist, cBrass),
            chip('WidgetOrderTraversalPolicy', cNavyMist, cBeacon),
            chip('ReadingOrderTraversalPolicy', cNavyMist, cBeacon),
            chip('OrderedTraversalPolicy', cNavyMist, cBeacon),
            chip('NumericFocusOrder', cNavyMist, cBeacon),
            chip('LexicalFocusOrder', cNavyMist, cBeacon),
            chip('DirectionalFocusTraversalPolicyMixin', cNavyMist, cBeacon),
            chip('TraversalDirection', cNavyMist, cBeacon),
            chip('RawKeyboardListener', cNavyMist, cBeacon),
          ],
        ),
      ],
    ),
  );

  // ─────────────────────────────────────────────────────────────────────
  // Final assembly — single scroll view containing all sections.
  // ─────────────────────────────────────────────────────────────────────
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Focus Traversal Deep Demo',
    home: Scaffold(
      backgroundColor: cFoam,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(18, 22, 18, 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hero,
              gap(16),
              sectionTitle(
                '01',
                'Anatomy of FocusTraversalGroup',
                'Wrapping a subtree in a policy.',
              ),
              anatomy,
              gap(8),
              sectionTitle(
                '02',
                'Policy snapshots — four real grids',
                'Each grid is wrapped in a FocusTraversalGroup with a '
                'different policy.',
              ),
              snapshotWidgetOrder,
              snapshotReadingOrder,
              snapshotNumeric,
              snapshotLexical,
              gap(8),
              sectionTitle(
                '03',
                'Side-by-side comparison',
                'Picking the right policy for the job.',
              ),
              comparisonStrip,
              gap(8),
              sectionTitle(
                '04',
                'NumericFocusOrder',
                'Sort by double — fractional weights and gaps.',
              ),
              numericExplainer,
              gap(8),
              sectionTitle(
                '05',
                'LexicalFocusOrder',
                'Sort by string — beware of code-unit ordering.',
              ),
              lexicalExplainer,
              gap(8),
              sectionTitle(
                '06',
                'TraversalDirection',
                'The four arrow-key directions.',
              ),
              directionEnumCards,
              gap(8),
              sectionTitle(
                '07',
                'DirectionalFocusTraversalPolicyMixin',
                'How arrow-key navigation works on every policy.',
              ),
              directionalMixin,
              gap(8),
              sectionTitle(
                '08',
                'Tab vs Shift-Tab vs arrows',
                'Key bindings and what they ask the policy.',
              ),
              keyMatrix,
              gap(8),
              sectionTitle(
                '09',
                'RawKeyboardListener',
                'Low-level escape hatch for global keys.',
              ),
              rawKeyboardSketch,
              gap(8),
              sectionTitle(
                '10',
                'FocusNode lifecycle',
                'Allocate → attach → request → traverse → unfocus → dispose.',
              ),
              lifecyclePanel,
              gap(8),
              sectionTitle(
                '11',
                'Common pitfalls',
                'Things that surprise developers.',
              ),
              pitfalls,
              gap(8),
              sectionTitle(
                '12',
                'Accessibility',
                'Make traversal serve every user.',
              ),
              accessibility,
              gap(10),
              footer,
            ],
          ),
        ),
      ),
    ),
  );
}

