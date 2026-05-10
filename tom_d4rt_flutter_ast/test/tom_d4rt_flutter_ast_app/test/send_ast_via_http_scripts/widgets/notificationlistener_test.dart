// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
//
// =====================================================================
//  NotificationListener<T> — Visual Deep Demo
// =====================================================================
//
//  This file is a hand-authored visual demo for the D4rt analyzer-free
//  interpreter test corpus. It explains, with cards, diagrams, code
//  snippets, and a side-by-side gallery, how Flutter's
//  NotificationListener<T> works as a *bubble-up* event channel.
//
//  Notifications are the dual of InheritedWidget:
//
//     InheritedWidget   — data flows DOWN from ancestor to descendants.
//     Notification      — events bubble UP from descendant to ancestors.
//
//  A descendant calls   Notification(...).dispatch(context)   which
//  walks UP the element tree, firing every NotificationListener<T>
//  whose generic type matches (T is the static type the listener
//  subscribed to).
//
//  Each listener's onNotification callback returns a bool:
//    - true  => the notification is *consumed*; bubbling stops.
//    - false => bubbling continues to the next matching ancestor.
//
//  Common built-in subclasses ship out of the box:
//    ScrollStartNotification, ScrollUpdateNotification,
//    ScrollEndNotification, OverscrollNotification,
//    UserScrollNotification, LayoutChangedNotification,
//    KeepAliveNotification, SizeChangedLayoutNotification.
//
//  This demo is purely *illustrative*: the entry point is a single
//  static `build` returning a MaterialApp. There is no state, no
//  controllers, no async code. We never actually call dispatch — we
//  only describe the mechanism in code-listing cards and diagrams.
//
// =====================================================================

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------
//  Palette — a calm, technical look reminiscent of a printed reference.
// ---------------------------------------------------------------------

const Color _kPagePaper = Color(0xFFF5F2EC);
const Color _kPageInk = Color(0xFF20242C);
const Color _kPageInkSoft = Color(0xFF4A5360);
const Color _kPageInkFaint = Color(0xFF8A93A1);
const Color _kAccentTeal = Color(0xFF1F8F8F);
const Color _kAccentCoral = Color(0xFFE26A53);
const Color _kAccentAmber = Color(0xFFE0A75E);
const Color _kAccentIndigo = Color(0xFF4250B5);
const Color _kAccentMint = Color(0xFF7AC59B);
const Color _kAccentRose = Color(0xFFB95E84);
const Color _kAccentSlate = Color(0xFF5C6F86);
const Color _kCardWhite = Color(0xFFFFFCF6);
const Color _kCardCream = Color(0xFFFBF5E7);
const Color _kCardChip = Color(0xFFEDE3CC);
const Color _kCodeBg = Color(0xFF1B2026);
const Color _kCodeFg = Color(0xFFE8EDF4);
const Color _kCodeKeyword = Color(0xFFE49A78);
const Color _kCodeType = Color(0xFFA0CCFF);
const Color _kCodeString = Color(0xFFAFE0A0);
const Color _kCodeComment = Color(0xFF6F7C90);
const Color _kCodeNumber = Color(0xFFE9D27A);

// ---------------------------------------------------------------------
//  A static custom Notification example. This is declared but never
//  actually dispatched (we have no live state); it's purely shown in
//  code-listing cards and as a worked example of the pattern.
// ---------------------------------------------------------------------

class _PrivateScoreNotification extends Notification {
  final int score;
  final String label;
  const _PrivateScoreNotification(this.score, {this.label = 'score'});

  @override
  String toString() =>
      '_PrivateScoreNotification(label: \$label, score: \$score)';
}

const _PrivateScoreNotification _kSampleScoreA =
    _PrivateScoreNotification(42, label: 'levelA');
const _PrivateScoreNotification _kSampleScoreB =
    _PrivateScoreNotification(108, label: 'levelB');
const _PrivateScoreNotification _kSampleScoreC =
    _PrivateScoreNotification(733, label: 'finalRound');

// =====================================================================
//  Entry point
// =====================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'NotificationListener Visual Deep Demo',
    theme: ThemeData(
      scaffoldBackgroundColor: _kPagePaper,
      textTheme: TextTheme(
        bodyMedium: TextStyle(color: _kPageInk, fontSize: 14),
      ),
    ),
    home: Scaffold(
      backgroundColor: _kPagePaper,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _privateBuildDocumentHeader(),
            SizedBox(height: 28),
            _privateBuildSection1Hero(),
            SizedBox(height: 28),
            _privateBuildSection2Anatomy(),
            SizedBox(height: 28),
            _privateBuildSection3BuiltinGallery(),
            SizedBox(height: 28),
            _privateBuildSection4ReturnSemantics(),
            SizedBox(height: 28),
            _privateBuildSection5ScrollExample(),
            SizedBox(height: 28),
            _privateBuildSection6CustomScoreExample(),
            SizedBox(height: 28),
            _privateBuildSection7Recipe(),
            SizedBox(height: 28),
            _privateBuildSection8Comparison(),
            SizedBox(height: 28),
            _privateBuildSection9Pitfalls(),
            SizedBox(height: 28),
            _privateBuildSection10Closing(),
            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}

// =====================================================================
//  Document header
// =====================================================================

Widget _privateBuildDocumentHeader() {
  return Container(
    padding: EdgeInsets.fromLTRB(28, 26, 28, 24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [_kPageInk, _kAccentIndigo],
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: _kCardWhite.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _kCardWhite.withValues(alpha: 0.45),
              width: 1.4,
            ),
          ),
          child: Center(
            child: Text(
              'NL',
              style: TextStyle(
                color: _kCardWhite,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.4,
              ),
            ),
          ),
        ),
        SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'NotificationListener<T>',
                style: TextStyle(
                  color: _kCardWhite,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'A visual deep dive into Flutter\u2019s bubble-up event channel.',
                style: TextStyle(
                  color: _kCardWhite.withValues(alpha: 0.85),
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _privateHeaderChip('bubbles up'),
                  _privateHeaderChip('typed by T'),
                  _privateHeaderChip('return true => consume'),
                  _privateHeaderChip('return false => let bubble'),
                  _privateHeaderChip('ScrollNotification'),
                  _privateHeaderChip('LayoutChangedNotification'),
                  _privateHeaderChip('custom subclass OK'),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _privateHeaderChip(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: _kCardWhite.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(999),
      border: Border.all(
        color: _kCardWhite.withValues(alpha: 0.32),
        width: 1,
      ),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: _kCardWhite,
        fontSize: 11.5,
        letterSpacing: 0.4,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// =====================================================================
//  Section 1 — Hero card: the bubble-up pattern
// =====================================================================

Widget _privateBuildSection1Hero() {
  return _privateSectionShell(
    number: '01',
    title: 'The bubble-up pattern',
    accent: _kAccentTeal,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'A descendant widget creates a Notification object and calls '
          'dispatch(context). The framework walks UP the element tree, '
          'firing every NotificationListener<T> whose generic type T '
          'matches the runtime type of the notification. Each listener '
          'returns a bool to decide whether the notification continues '
          'to bubble.',
          style: TextStyle(
            fontSize: 14.5,
            height: 1.55,
            color: _kPageInkSoft,
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 22),
          decoration: BoxDecoration(
            color: _kCardCream,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _kAccentTeal.withValues(alpha: 0.35),
              width: 1.2,
            ),
          ),
          child: Column(
            children: [
              _privateBubbleRow(
                label: 'Root / App',
                color: _kAccentIndigo,
                arrow: '\u25B2  bubble',
                arrowColor: _kAccentTeal,
                showArrow: true,
              ),
              _privateBubbleRow(
                label: 'Page (NotificationListener<ScrollNotification>)',
                color: _kAccentTeal,
                arrow: '\u25B2  bubble',
                arrowColor: _kAccentTeal,
                showArrow: true,
              ),
              _privateBubbleRow(
                label: 'Layout column',
                color: _kAccentSlate,
                arrow: '\u25B2  bubble',
                arrowColor: _kAccentTeal,
                showArrow: true,
              ),
              _privateBubbleRow(
                label: 'Card',
                color: _kAccentSlate,
                arrow: '\u25B2  bubble',
                arrowColor: _kAccentTeal,
                showArrow: true,
              ),
              _privateBubbleRow(
                label: 'Scroll source (ListView) — DISPATCH',
                color: _kAccentCoral,
                arrow: '',
                arrowColor: _kAccentTeal,
                showArrow: false,
              ),
            ],
          ),
        ),
        SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: _privateMiniCard(
                title: 'Subscribe by type',
                body: 'A NotificationListener<T> only sees notifications '
                    'that are an instance of T. Listening to '
                    'ScrollNotification picks up all four scroll subtypes.',
                color: _kAccentIndigo,
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: _privateMiniCard(
                title: 'Bubbling is upward only',
                body: 'Notifications never travel sideways or downward. '
                    'They flow strictly from descendant to ancestor.',
                color: _kAccentCoral,
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: _privateMiniCard(
                title: 'No state required',
                body: 'NotificationListener itself is stateless wiring. '
                    'You can use it to forward events into setState, '
                    'a controller, or a model held above.',
                color: _kAccentMint,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _privateBubbleRow({
  required String label,
  required Color color,
  required String arrow,
  required Color arrowColor,
  required bool showArrow,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: color.withValues(alpha: 0.55),
              width: 1.1,
            ),
          ),
          width: double.infinity,
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 13.5,
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        if (showArrow)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3),
            child: Text(
              arrow,
              style: TextStyle(
                color: arrowColor,
                fontWeight: FontWeight.w700,
                fontSize: 12,
                letterSpacing: 0.4,
              ),
            ),
          ),
      ],
    ),
  );
}

// =====================================================================
//  Section 2 — Anatomy diagram
// =====================================================================

Widget _privateBuildSection2Anatomy() {
  return _privateSectionShell(
    number: '02',
    title: 'Anatomy of a dispatch',
    accent: _kAccentIndigo,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Below: widget A dispatches a notification. It travels through '
          'three ancestors. The middle ancestor returns true and stops '
          'the bubble; the highest ancestor never sees it.',
          style: TextStyle(
            fontSize: 14.5,
            height: 1.55,
            color: _kPageInkSoft,
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          decoration: BoxDecoration(
            color: _kCardWhite,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _kAccentIndigo.withValues(alpha: 0.25),
              width: 1.2,
            ),
          ),
          child: Column(
            children: [
              _privateAnatomyNode(
                index: '5',
                title: 'Root MaterialApp',
                subtitle: 'never receives — bubble was consumed below',
                color: _kAccentSlate,
                muted: true,
              ),
              _privateAnatomyArrow(label: 'X (stopped)', color: _kAccentCoral),
              _privateAnatomyNode(
                index: '4',
                title: 'NotificationListener<ScoreNotification>',
                subtitle: 'CONSUMER — onNotification returns true',
                color: _kAccentTeal,
                muted: false,
              ),
              _privateAnatomyArrow(
                label: '\u25B2 bubble continues',
                color: _kAccentMint,
              ),
              _privateAnatomyNode(
                index: '3',
                title: 'NotificationListener<ScoreNotification>',
                subtitle: 'TRANSPARENT — returns false, bubble keeps going',
                color: _kAccentIndigo,
                muted: false,
              ),
              _privateAnatomyArrow(
                label: '\u25B2 bubble continues',
                color: _kAccentMint,
              ),
              _privateAnatomyNode(
                index: '2',
                title: 'Plain Container (no listener)',
                subtitle: 'just a parent — bubble passes straight through',
                color: _kAccentAmber,
                muted: false,
              ),
              _privateAnatomyArrow(
                label: '\u25B2 dispatch',
                color: _kAccentMint,
              ),
              _privateAnatomyNode(
                index: '1',
                title: 'Widget A',
                subtitle: 'calls ScoreNotification(42).dispatch(context)',
                color: _kAccentCoral,
                muted: false,
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _privateLegendRow([
          _privateLegendItem('dispatcher', _kAccentCoral),
          _privateLegendItem('transparent ancestor', _kAccentAmber),
          _privateLegendItem('passes through', _kAccentIndigo),
          _privateLegendItem('consumer', _kAccentTeal),
          _privateLegendItem('blocked / never sees', _kAccentSlate),
        ]),
      ],
    ),
  );
}

Widget _privateAnatomyNode({
  required String index,
  required String title,
  required String subtitle,
  required Color color,
  required bool muted,
}) {
  final double opacity = muted ? 0.45 : 1.0;
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withValues(alpha: muted ? 0.12 : 0.85),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: color.withValues(alpha: muted ? 0.4 : 1.0),
              width: 1.4,
            ),
          ),
          child: Center(
            child: Text(
              index,
              style: TextStyle(
                color: muted ? color : _kCardWhite,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            decoration: BoxDecoration(
              color: color.withValues(alpha: muted ? 0.05 : 0.10),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: color.withValues(alpha: muted ? 0.25 : 0.5),
                width: 1.1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color.withValues(alpha: opacity),
                    fontWeight: FontWeight.w800,
                    fontSize: 13.5,
                    letterSpacing: 0.1,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: _kPageInkSoft.withValues(alpha: opacity),
                    fontSize: 12,
                    height: 1.4,
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

Widget _privateAnatomyArrow({required String label, required Color color}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: 12,
            letterSpacing: 0.6,
          ),
        ),
      ],
    ),
  );
}

Widget _privateLegendRow(List<Widget> items) {
  return Wrap(
    spacing: 14,
    runSpacing: 8,
    children: items,
  );
}

Widget _privateLegendItem(String label, Color color) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      SizedBox(width: 6),
      Text(
        label,
        style: TextStyle(
          color: _kPageInkSoft,
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}

// =====================================================================
//  Section 3 — Built-in Notification gallery
// =====================================================================

Widget _privateBuildSection3BuiltinGallery() {
  return _privateSectionShell(
    number: '03',
    title: 'Built-in Notification gallery',
    accent: _kAccentCoral,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Flutter ships with a small set of Notification subclasses. '
          'Listening to the base type (e.g. ScrollNotification) covers '
          'all of its leaf subtypes; listening to a leaf type (e.g. '
          'ScrollEndNotification) covers only that one.',
          style: TextStyle(
            fontSize: 14.5,
            height: 1.55,
            color: _kPageInkSoft,
          ),
        ),
        SizedBox(height: 20),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            _privateBuiltinCard(
              name: 'ScrollStartNotification',
              accent: _kAccentTeal,
              kind: 'scroll',
              description:
                  'Fires once at the moment a Scrollable starts moving.',
              snippet:
                  'NotificationListener<ScrollStartNotification>(\n'
                  '  onNotification: (n) {\n'
                  '    // first frame of motion\n'
                  '    return false;\n'
                  '  },\n'
                  '  child: ListView(...),\n'
                  ');',
            ),
            _privateBuiltinCard(
              name: 'ScrollUpdateNotification',
              accent: _kAccentIndigo,
              kind: 'scroll',
              description:
                  'Fires on every pixel-delta as the user scrolls.',
              snippet:
                  'NotificationListener<ScrollUpdateNotification>(\n'
                  '  onNotification: (n) {\n'
                  '    final delta = n.scrollDelta;\n'
                  '    return false;\n'
                  '  },\n'
                  '  child: ListView(...),\n'
                  ');',
            ),
            _privateBuiltinCard(
              name: 'ScrollEndNotification',
              accent: _kAccentCoral,
              kind: 'scroll',
              description:
                  'Fires when the Scrollable comes to rest.',
              snippet:
                  'NotificationListener<ScrollEndNotification>(\n'
                  '  onNotification: (n) {\n'
                  '    // good time to snapshot scroll state\n'
                  '    return false;\n'
                  '  },\n'
                  '  child: ListView(...),\n'
                  ');',
            ),
            _privateBuiltinCard(
              name: 'OverscrollNotification',
              accent: _kAccentAmber,
              kind: 'scroll',
              description:
                  'Fires when scroll attempts to go past content edge.',
              snippet:
                  'NotificationListener<OverscrollNotification>(\n'
                  '  onNotification: (n) {\n'
                  '    final overshoot = n.overscroll;\n'
                  '    return false;\n'
                  '  },\n'
                  '  child: ListView(...),\n'
                  ');',
            ),
            _privateBuiltinCard(
              name: 'UserScrollNotification',
              accent: _kAccentMint,
              kind: 'scroll',
              description:
                  'Tells you the *direction* of user-driven scroll.',
              snippet:
                  'NotificationListener<UserScrollNotification>(\n'
                  '  onNotification: (n) {\n'
                  '    final dir = n.direction;\n'
                  '    return false;\n'
                  '  },\n'
                  '  child: ListView(...),\n'
                  ');',
            ),
            _privateBuiltinCard(
              name: 'LayoutChangedNotification',
              accent: _kAccentRose,
              kind: 'layout',
              description:
                  'Dispatched by a SizeChangedLayoutNotifier when its '
                  'subtree changes size.',
              snippet:
                  'NotificationListener<LayoutChangedNotification>(\n'
                  '  onNotification: (n) {\n'
                  '    return false;\n'
                  '  },\n'
                  '  child: SizeChangedLayoutNotifier(\n'
                  '    child: child,\n'
                  '  ),\n'
                  ');',
            ),
            _privateBuiltinCard(
              name: 'KeepAliveNotification',
              accent: _kAccentIndigo,
              kind: 'lifecycle',
              description:
                  'Lets a child of a lazy list opt into being kept alive '
                  'when scrolled out of view.',
              snippet:
                  'NotificationListener<KeepAliveNotification>(\n'
                  '  onNotification: (n) {\n'
                  '    return false;\n'
                  '  },\n'
                  '  child: child,\n'
                  ');',
            ),
            _privateBuiltinCard(
              name: 'SizeChangedLayoutNotification',
              accent: _kAccentTeal,
              kind: 'layout',
              description:
                  'Concrete notification dispatched by '
                  'SizeChangedLayoutNotifier on geometry change.',
              snippet:
                  'NotificationListener<SizeChangedLayoutNotification>(\n'
                  '  onNotification: (n) {\n'
                  '    return false;\n'
                  '  },\n'
                  '  child: SizeChangedLayoutNotifier(\n'
                  '    child: child,\n'
                  '  ),\n'
                  ');',
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _privateBuiltinCard({
  required String name,
  required Color accent,
  required String kind,
  required String description,
  required String snippet,
}) {
  return Container(
    width: 360,
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kCardWhite,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(
        color: accent.withValues(alpha: 0.45),
        width: 1.2,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: accent.withValues(alpha: 0.55),
                  width: 1,
                ),
              ),
              child: Text(
                kind,
                style: TextStyle(
                  color: accent,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
            ),
            Spacer(),
            Icon(
              Icons.bolt_outlined,
              size: 16,
              color: accent.withValues(alpha: 0.8),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          name,
          style: TextStyle(
            color: _kPageInk,
            fontWeight: FontWeight.w800,
            fontSize: 16,
            letterSpacing: 0.1,
          ),
        ),
        SizedBox(height: 6),
        Text(
          description,
          style: TextStyle(
            color: _kPageInkSoft,
            fontSize: 12.5,
            height: 1.45,
          ),
        ),
        SizedBox(height: 10),
        _privateCodeBlock(snippet),
      ],
    ),
  );
}

// =====================================================================
//  Section 4 — Return value semantics
// =====================================================================

Widget _privateBuildSection4ReturnSemantics() {
  return _privateSectionShell(
    number: '04',
    title: 'onNotification return value',
    accent: _kAccentMint,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'The bool returned from onNotification is the single most '
          'important detail of the whole API. It decides whether '
          'ancestors above this listener will *also* see the event.',
          style: TextStyle(
            fontSize: 14.5,
            height: 1.55,
            color: _kPageInkSoft,
          ),
        ),
        SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _privateReturnPanel(
                title: 'return true \u2192 consumed',
                accent: _kAccentCoral,
                badge: 'STOP',
                explanation:
                    'You declare ownership. The notification dies here. '
                    'No ancestor listener will fire. Use this when the '
                    'event was conceptually for *you* and only you.',
                snippet:
                    'NotificationListener<ScrollEndNotification>(\n'
                    '  onNotification: (n) {\n'
                    '    _saveSnapshot(n);\n'
                    '    return true; // consume\n'
                    '  },\n'
                    '  child: child,\n'
                    ');',
                bullets: [
                  'no further listeners fire',
                  'the dispatcher cannot tell — it\u2019s fire-and-forget',
                  'use sparingly: blocks composition',
                ],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _privateReturnPanel(
                title: 'return false \u2192 lets it bubble',
                accent: _kAccentTeal,
                badge: 'PASS',
                explanation:
                    'You observe in passing but allow ancestors to also '
                    'react. This is the more common, more composable '
                    'choice; default to it unless you have a reason.',
                snippet:
                    'NotificationListener<ScrollNotification>(\n'
                    '  onNotification: (n) {\n'
                    '    _logForDebug(n);\n'
                    '    return false; // keep bubbling\n'
                    '  },\n'
                    '  child: child,\n'
                    ');',
                bullets: [
                  'parent listeners still fire',
                  'composes with other instrumentation',
                  'preferred default',
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _privateReturnPanel({
  required String title,
  required Color accent,
  required String badge,
  required String explanation,
  required String snippet,
  required List<String> bullets,
}) {
  return Container(
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: _kCardWhite,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(
        color: accent.withValues(alpha: 0.55),
        width: 1.3,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                badge,
                style: TextStyle(
                  color: _kCardWhite,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.w800,
                  fontSize: 16.5,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          explanation,
          style: TextStyle(
            color: _kPageInkSoft,
            fontSize: 13,
            height: 1.5,
          ),
        ),
        SizedBox(height: 12),
        _privateCodeBlock(snippet),
        SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: bullets
              .map(
                (b) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5, right: 8),
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: accent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          b,
                          style: TextStyle(
                            color: _kPageInkSoft,
                            fontSize: 12.5,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    ),
  );
}

// =====================================================================
//  Section 5 — Realistic example #1: scroll speed-meter (illustrative)
// =====================================================================

Widget _privateBuildSection5ScrollExample() {
  return _privateSectionShell(
    number: '05',
    title: 'Realistic example: scroll speed-meter',
    accent: _kAccentAmber,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'A common pattern: an ancestor wraps a list and displays a '
          'speed-meter / scroll indicator that *would* react to '
          'ScrollUpdateNotification. The widget below is purely '
          'illustrative — there is no live state in this demo, so the '
          'meter is rendered at a fixed value to show the layout.',
          style: TextStyle(
            fontSize: 14.5,
            height: 1.55,
            color: _kPageInkSoft,
          ),
        ),
        SizedBox(height: 18),
        Container(
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: _kCardWhite,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _kAccentAmber.withValues(alpha: 0.45),
              width: 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _privateScrollSpeedMeter(value: 0.62),
              SizedBox(height: 14),
              _privateFakeListPreview(),
              SizedBox(height: 16),
              _privateCodeBlock(
                'NotificationListener<ScrollUpdateNotification>(\n'
                '  onNotification: (n) {\n'
                '    final pixels = n.metrics.pixels;\n'
                '    final max    = n.metrics.maxScrollExtent;\n'
                '    final ratio  = max == 0 ? 0.0 : pixels / max;\n'
                '    // forward into a controller / setState\n'
                '    _meter.value = ratio.clamp(0.0, 1.0);\n'
                '    return false;\n'
                '  },\n'
                '  child: ListView.builder(\n'
                '    itemCount: 200,\n'
                '    itemBuilder: (c, i) => ListTile(title: Text(\u0027row \$i\u0027)),\n'
                '  ),\n'
                ');',
              ),
            ],
          ),
        ),
        SizedBox(height: 14),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: _kAccentAmber.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _kAccentAmber.withValues(alpha: 0.45),
              width: 1.0,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                size: 18,
                color: _kAccentAmber,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Returning false here is the right choice — outer '
                  'analytics or page-level listeners may still want to '
                  'observe scroll updates.',
                  style: TextStyle(
                    color: _kPageInkSoft,
                    fontSize: 12.5,
                    height: 1.45,
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

Widget _privateScrollSpeedMeter({required double value}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    decoration: BoxDecoration(
      color: _kCardCream,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: _kAccentAmber.withValues(alpha: 0.4),
        width: 1.0,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(
              'scroll progress',
              style: TextStyle(
                color: _kPageInkSoft,
                fontWeight: FontWeight.w700,
                fontSize: 12,
                letterSpacing: 0.6,
              ),
            ),
            Spacer(),
            Text(
              '${(value * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                color: _kAccentAmber,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 10,
              decoration: BoxDecoration(
                color: _kAccentAmber.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            FractionallySizedBox(
              widthFactor: value,
              child: Container(
                height: 10,
                decoration: BoxDecoration(
                  color: _kAccentAmber,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _privateFakeListPreview() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: _kCardCream,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: _kPageInkFaint.withValues(alpha: 0.5),
        width: 1.0,
      ),
    ),
    child: Column(
      children: [
        _privateFakeRow('row 0', _kAccentTeal),
        _privateFakeRow('row 1', _kAccentIndigo),
        _privateFakeRow('row 2', _kAccentCoral),
        _privateFakeRow('row 3', _kAccentMint),
        _privateFakeRow('row 4', _kAccentRose),
      ],
    ),
  );
}

Widget _privateFakeRow(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    margin: EdgeInsets.symmetric(vertical: 3),
    decoration: BoxDecoration(
      color: _kCardWhite,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(
        color: color.withValues(alpha: 0.4),
        width: 1.0,
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            color: _kPageInk,
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
//  Section 6 — Realistic example #2: custom score notification
// =====================================================================

Widget _privateBuildSection6CustomScoreExample() {
  return _privateSectionShell(
    number: '06',
    title: 'Custom: _PrivateScoreNotification',
    accent: _kAccentRose,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'A deeply nested cell wants to publish a score upward to a '
          'banner near the top of the page, *without* threading a '
          'controller through every level. Notifications are a clean '
          'fit: define a subclass, dispatch from the leaf, listen at the '
          'ancestor.',
          style: TextStyle(
            fontSize: 14.5,
            height: 1.55,
            color: _kPageInkSoft,
          ),
        ),
        SizedBox(height: 18),
        _privateScoreBanner(),
        SizedBox(height: 18),
        Container(
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: _kCardWhite,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _kAccentRose.withValues(alpha: 0.45),
              width: 1.2,
            ),
          ),
          child: Column(
            children: [
              _privateScorePathStep(
                index: '1',
                title: 'Banner ancestor',
                subtitle: 'NotificationListener<_PrivateScoreNotification>',
                color: _kAccentRose,
                inverted: true,
              ),
              _privateScorePathArrow(),
              _privateScorePathStep(
                index: '2',
                title: 'Section column',
                subtitle: 'no listener — passes through',
                color: _kAccentSlate,
                inverted: false,
              ),
              _privateScorePathArrow(),
              _privateScorePathStep(
                index: '3',
                title: 'Card grid',
                subtitle: 'no listener — passes through',
                color: _kAccentSlate,
                inverted: false,
              ),
              _privateScorePathArrow(),
              _privateScorePathStep(
                index: '4',
                title: 'Leaf cell (button)',
                subtitle:
                    'calls _PrivateScoreNotification(108).dispatch(context)',
                color: _kAccentCoral,
                inverted: true,
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _privateCodeBlock(
          'class ScoreNotification extends Notification {\n'
          '  final int score;\n'
          '  const ScoreNotification(this.score);\n'
          '}\n'
          '\n'
          '// somewhere deep:\n'
          'GestureDetector(\n'
          '  onTap: () {\n'
          '    // (NOT called in this demo — illustrative)\n'
          '    ScoreNotification(108).dispatch(context);\n'
          '  },\n'
          '  child: Text(\u0027submit\u0027),\n'
          ')\n'
          '\n'
          '// somewhere high:\n'
          'NotificationListener<ScoreNotification>(\n'
          '  onNotification: (n) {\n'
          '    setState(() => _score = n.score);\n'
          '    return true; // we own this event\n'
          '  },\n'
          '  child: page,\n'
          ');',
        ),
      ],
    ),
  );
}

Widget _privateScoreBanner() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kAccentRose, _kAccentIndigo],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      children: [
        Icon(
          Icons.emoji_events_outlined,
          color: _kCardWhite,
          size: 28,
        ),
        SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CURRENT SCORE',
              style: TextStyle(
                color: _kCardWhite.withValues(alpha: 0.7),
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.4,
              ),
            ),
            SizedBox(height: 2),
            Text(
              '${_kSampleScoreB.score}',
              style: TextStyle(
                color: _kCardWhite,
                fontSize: 26,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: _kCardWhite.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: _kCardWhite.withValues(alpha: 0.5),
              width: 1,
            ),
          ),
          child: Text(
            'label: ${_kSampleScoreB.label}',
            style: TextStyle(
              color: _kCardWhite,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _privateScorePathStep({
  required String index,
  required String title,
  required String subtitle,
  required Color color,
  required bool inverted,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 11),
    decoration: BoxDecoration(
      color: inverted ? color : color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: color.withValues(alpha: inverted ? 1.0 : 0.5),
        width: 1.2,
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: inverted
                ? _kCardWhite.withValues(alpha: 0.25)
                : color.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: inverted ? _kCardWhite : color.withValues(alpha: 0.5),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              index,
              style: TextStyle(
                color: inverted ? _kCardWhite : color,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: inverted ? _kCardWhite : color,
                  fontWeight: FontWeight.w800,
                  fontSize: 13.5,
                ),
              ),
              SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  color: inverted
                      ? _kCardWhite.withValues(alpha: 0.85)
                      : _kPageInkSoft,
                  fontSize: 12,
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

Widget _privateScorePathArrow() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Center(
      child: Text(
        '\u25B2  bubble up',
        style: TextStyle(
          color: _kAccentRose,
          fontWeight: FontWeight.w700,
          fontSize: 11.5,
          letterSpacing: 0.6,
        ),
      ),
    ),
  );
}

// =====================================================================
//  Section 7 — Recipe code listing
// =====================================================================

Widget _privateBuildSection7Recipe() {
  return _privateSectionShell(
    number: '07',
    title: 'Mini recipe',
    accent: _kAccentIndigo,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'A complete, copy-pasteable mini recipe for adding a custom '
          'Notification to a screen: define the subclass, dispatch from '
          'the deep child, listen near the top of the screen.',
          style: TextStyle(
            fontSize: 14.5,
            height: 1.55,
            color: _kPageInkSoft,
          ),
        ),
        SizedBox(height: 16),
        _privateCodeBlock(
          '// 1) Define the notification subclass.\n'
          'class CountChangedNotification extends Notification {\n'
          '  final int newCount;\n'
          '  final String source;\n'
          '  const CountChangedNotification({\n'
          '    required this.newCount,\n'
          '    required this.source,\n'
          '  });\n'
          '\n'
          '  @override\n'
          '  String toString() =>\n'
          '      \u0027CountChanged(\$source: \$newCount)\u0027;\n'
          '}\n'
          '\n'
          '// 2) Dispatch from a deep child. The framework walks UP\n'
          '//    from this BuildContext, firing matching listeners.\n'
          'class IncrementButton extends StatelessWidget {\n'
          '  final int next;\n'
          '  const IncrementButton(this.next);\n'
          '\n'
          '  @override\n'
          '  Widget build(BuildContext context) {\n'
          '    return TextButton(\n'
          '      onPressed: () {\n'
          '        CountChangedNotification(\n'
          '          newCount: next,\n'
          '          source: \u0027incrementButton\u0027,\n'
          '        ).dispatch(context);\n'
          '      },\n'
          '      child: Text(\u0027+1\u0027),\n'
          '    );\n'
          '  }\n'
          '}\n'
          '\n'
          '// 3) Listen near the top. Decide whether to consume.\n'
          'class CountScreen extends StatefulWidget {\n'
          '  @override\n'
          '  State<CountScreen> createState() => _CountScreenState();\n'
          '}\n'
          '\n'
          'class _CountScreenState extends State<CountScreen> {\n'
          '  int _count = 0;\n'
          '\n'
          '  @override\n'
          '  Widget build(BuildContext context) {\n'
          '    return NotificationListener<CountChangedNotification>(\n'
          '      onNotification: (n) {\n'
          '        setState(() => _count = n.newCount);\n'
          '        return true; // we own this event\n'
          '      },\n'
          '      child: Column(\n'
          '        children: [\n'
          '          Text(\u0027count: \$_count\u0027),\n'
          '          IncrementButton(_count + 1),\n'
          '        ],\n'
          '      ),\n'
          '    );\n'
          '  }\n'
          '}',
        ),
      ],
    ),
  );
}

// =====================================================================
//  Section 8 — Comparison table
// =====================================================================

Widget _privateBuildSection8Comparison() {
  return _privateSectionShell(
    number: '08',
    title: 'NotificationListener vs alternatives',
    accent: _kAccentSlate,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Notifications are not always the right answer. The table '
          'below compares them to the other usual ways data flows '
          'between widgets in Flutter.',
          style: TextStyle(
            fontSize: 14.5,
            height: 1.55,
            color: _kPageInkSoft,
          ),
        ),
        SizedBox(height: 18),
        Container(
          decoration: BoxDecoration(
            color: _kCardWhite,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _kAccentSlate.withValues(alpha: 0.4),
              width: 1.2,
            ),
          ),
          child: Column(
            children: [
              _privateCompareHeader(),
              _privateCompareRow(
                feature: 'NotificationListener',
                direction: 'up (descendant \u2192 ancestor)',
                shape: 'event-shaped',
                cancellable: 'yes (return true)',
                bestFor: 'one-shot bubbling events',
                accent: _kAccentTeal,
              ),
              _privateCompareRow(
                feature: 'InheritedWidget',
                direction: 'down (ancestor \u2192 descendants)',
                shape: 'data-shaped',
                cancellable: 'n/a',
                bestFor: 'shared, read-only state',
                accent: _kAccentIndigo,
              ),
              _privateCompareRow(
                feature: 'EventBus / pub-sub',
                direction: 'global (anywhere \u2192 anywhere)',
                shape: 'event-shaped',
                cancellable: 'no (subscriber-driven)',
                bestFor: 'cross-screen, decoupled signals',
                accent: _kAccentCoral,
              ),
              _privateCompareRow(
                feature: 'Provider / Riverpod',
                direction: 'down (DI scope)',
                shape: 'state-shaped',
                cancellable: 'n/a',
                bestFor: 'reactive shared state',
                accent: _kAccentMint,
              ),
              _privateCompareRow(
                feature: 'Callback prop',
                direction: 'down then back up via closure',
                shape: 'function-shaped',
                cancellable: 'n/a',
                bestFor: 'one immediate parent only',
                accent: _kAccentAmber,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _privateCompareHeader() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: _kAccentSlate.withValues(alpha: 0.12),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(13),
        topRight: Radius.circular(13),
      ),
    ),
    child: Row(
      children: [
        Expanded(flex: 3, child: _privateCompareHeaderCell('mechanism')),
        Expanded(flex: 3, child: _privateCompareHeaderCell('direction')),
        Expanded(flex: 2, child: _privateCompareHeaderCell('shape')),
        Expanded(flex: 2, child: _privateCompareHeaderCell('cancellable')),
        Expanded(flex: 3, child: _privateCompareHeaderCell('best for')),
      ],
    ),
  );
}

Widget _privateCompareHeaderCell(String label) {
  return Text(
    label,
    style: TextStyle(
      color: _kAccentSlate,
      fontSize: 11,
      fontWeight: FontWeight.w800,
      letterSpacing: 1.2,
    ),
  );
}

Widget _privateCompareRow({
  required String feature,
  required String direction,
  required String shape,
  required String cancellable,
  required String bestFor,
  required Color accent,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 13),
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(
          color: _kPageInkFaint.withValues(alpha: 0.35),
          width: 1,
        ),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  feature,
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(flex: 3, child: _privateCompareCell(direction)),
        Expanded(flex: 2, child: _privateCompareCell(shape)),
        Expanded(flex: 2, child: _privateCompareCell(cancellable)),
        Expanded(flex: 3, child: _privateCompareCell(bestFor)),
      ],
    ),
  );
}

Widget _privateCompareCell(String text) {
  return Text(
    text,
    style: TextStyle(
      color: _kPageInkSoft,
      fontSize: 12,
      height: 1.4,
    ),
  );
}

// =====================================================================
//  Section 9 — Pitfalls
// =====================================================================

Widget _privateBuildSection9Pitfalls() {
  return _privateSectionShell(
    number: '09',
    title: 'Pitfalls and gotchas',
    accent: _kAccentCoral,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'A short, opinionated list of mistakes to avoid when reaching '
          'for NotificationListener.',
          style: TextStyle(
            fontSize: 14.5,
            height: 1.55,
            color: _kPageInkSoft,
          ),
        ),
        SizedBox(height: 18),
        _privatePitfallCard(
          icon: Icons.block_outlined,
          title: 'Don\u2019t accidentally block bubbling.',
          body: 'Returning true means \u0022I consumed it.\u0022 If a parent '
              'analytics layer also wants the event, you\u2019ve broken it. '
              'Default to false unless ownership is intentional.',
          accent: _kAccentCoral,
        ),
        _privatePitfallCard(
          icon: Icons.account_tree_outlined,
          title: 'Listeners subscribe by static type T.',
          body: 'NotificationListener<ScrollEndNotification> will not '
              'see ScrollUpdateNotification. Listening to the abstract '
              'base type ScrollNotification covers all four subtypes.',
          accent: _kAccentTeal,
        ),
        _privatePitfallCard(
          icon: Icons.swap_vert_outlined,
          title: 'No sideways or downward delivery.',
          body: 'A sibling cannot receive your notification. Only '
              'ancestors of the dispatching BuildContext fire.',
          accent: _kAccentIndigo,
        ),
        _privatePitfallCard(
          icon: Icons.history_toggle_off_outlined,
          title: 'Notifications are fire-and-forget.',
          body: 'There is no return value to the dispatcher, no async '
              'await, no acknowledgement. Use a Future-returning '
              'callback instead if you need a reply.',
          accent: _kAccentAmber,
        ),
        _privatePitfallCard(
          icon: Icons.layers_outlined,
          title: 'Don\u2019t use them for cross-screen shared state.',
          body: 'They live within one widget subtree. For app-wide '
              'reactive state, reach for InheritedWidget / Provider / '
              'Riverpod / a controller.',
          accent: _kAccentMint,
        ),
        _privatePitfallCard(
          icon: Icons.bolt_outlined,
          title: 'dispatch() needs a mounted BuildContext.',
          body: 'After the widget that called dispatch is unmounted, '
              'further dispatches with the stale context are no-ops or '
              'throw. Capture context only inside callbacks that fire '
              'while the widget is alive.',
          accent: _kAccentRose,
        ),
      ],
    ),
  );
}

Widget _privatePitfallCard({
  required IconData icon,
  required String title,
  required String body,
  required Color accent,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: _kCardWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: accent.withValues(alpha: 0.5),
        width: 1.2,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(9),
            border: Border.all(
              color: accent.withValues(alpha: 0.55),
              width: 1.0,
            ),
          ),
          child: Icon(icon, color: accent, size: 20),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 5),
              Text(
                body,
                style: TextStyle(
                  color: _kPageInkSoft,
                  fontSize: 12.5,
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

// =====================================================================
//  Section 10 — Closing card / palette / metadata
// =====================================================================

Widget _privateBuildSection10Closing() {
  return Container(
    padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
    decoration: BoxDecoration(
      color: _kPageInk,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _kAccentTeal,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'WRAP-UP',
                style: TextStyle(
                  color: _kCardWhite,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.4,
                ),
              ),
            ),
            SizedBox(width: 10),
            Text(
              'Section 10 / 10',
              style: TextStyle(
                color: _kCardWhite.withValues(alpha: 0.6),
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14),
        Text(
          'NotificationListener<T> in one breath',
          style: TextStyle(
            color: _kCardWhite,
            fontSize: 22,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.2,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Bubble events upward by static type. Return false to compose, '
          'true to own. Prefer it for transient signals; reach for '
          'InheritedWidget / Provider for actual shared state.',
          style: TextStyle(
            color: _kCardWhite.withValues(alpha: 0.85),
            fontSize: 14,
            height: 1.55,
          ),
        ),
        SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _privateClosingMetaRow('demo type', 'visual deep'),
                  _privateClosingMetaRow('subject', 'NotificationListener'),
                  _privateClosingMetaRow('sections', '10'),
                  _privateClosingMetaRow('dispatches called', '0 (illustrative)'),
                  _privateClosingMetaRow(
                    'custom subclass',
                    '_PrivateScoreNotification',
                  ),
                ],
              ),
            ),
            SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'palette',
                    style: TextStyle(
                      color: _kCardWhite.withValues(alpha: 0.6),
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.4,
                    ),
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _privateClosingSwatch('teal', _kAccentTeal),
                      _privateClosingSwatch('coral', _kAccentCoral),
                      _privateClosingSwatch('amber', _kAccentAmber),
                      _privateClosingSwatch('indigo', _kAccentIndigo),
                      _privateClosingSwatch('mint', _kAccentMint),
                      _privateClosingSwatch('rose', _kAccentRose),
                      _privateClosingSwatch('slate', _kAccentSlate),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: _kCardWhite.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _kCardWhite.withValues(alpha: 0.25),
              width: 1.0,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 16,
                color: _kCardWhite.withValues(alpha: 0.7),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'D4rt analyzer-free corpus \u2014 visual deep demo. '
                  'Single static build entry point, no live state, '
                  'no controllers, no async.',
                  style: TextStyle(
                    color: _kCardWhite.withValues(alpha: 0.8),
                    fontSize: 12,
                    height: 1.45,
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

Widget _privateClosingMetaRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        SizedBox(
          width: 130,
          child: Text(
            label,
            style: TextStyle(
              color: _kCardWhite.withValues(alpha: 0.5),
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: _kCardWhite,
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _privateClosingSwatch(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 9, vertical: 5),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(999),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: _kCardWhite,
        fontWeight: FontWeight.w800,
        fontSize: 11,
        letterSpacing: 0.5,
      ),
    ),
  );
}

// =====================================================================
//  Shared shell + helper widgets
// =====================================================================

Widget _privateSectionShell({
  required String number,
  required String title,
  required Color accent,
  required Widget child,
}) {
  return Container(
    padding: EdgeInsets.fromLTRB(24, 22, 24, 24),
    decoration: BoxDecoration(
      color: _kCardWhite,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(
        color: accent.withValues(alpha: 0.32),
        width: 1.2,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                number,
                style: TextStyle(
                  color: _kCardWhite,
                  fontWeight: FontWeight.w800,
                  fontSize: 11.5,
                  letterSpacing: 1.6,
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: _kPageInk,
                  fontWeight: FontWeight.w800,
                  fontSize: 19,
                  letterSpacing: 0.2,
                ),
              ),
            ),
            Container(
              height: 6,
              width: 60,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        child,
      ],
    ),
  );
}

Widget _privateMiniCard({
  required String title,
  required String body,
  required Color color,
}) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: color.withValues(alpha: 0.45),
        width: 1.1,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 26,
          height: 4,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 13.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.1,
          ),
        ),
        SizedBox(height: 6),
        Text(
          body,
          style: TextStyle(
            color: _kPageInkSoft,
            fontSize: 12,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget _privateCodeBlock(String code) {
  final List<TextSpan> spans = _privateColorizeDart(code);
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: _kPageInkFaint.withValues(alpha: 0.4),
        width: 1.0,
      ),
    ),
    child: SelectableText.rich(
      TextSpan(
        style: TextStyle(
          color: _kCodeFg,
          fontFamily: 'monospace',
          fontSize: 12,
          height: 1.5,
        ),
        children: spans,
      ),
    ),
  );
}

// A *very* small heuristic colourizer just so the code listings are
// pleasant to look at. It is deliberately crude — keywords, types,
// strings, comments, numbers — no parsing.
List<TextSpan> _privateColorizeDart(String code) {
  const Set<String> keywords = {
    'class',
    'final',
    'const',
    'return',
    'if',
    'else',
    'for',
    'while',
    'do',
    'switch',
    'case',
    'break',
    'continue',
    'this',
    'super',
    'extends',
    'implements',
    'with',
    'override',
    'true',
    'false',
    'null',
    'void',
    'new',
    'static',
    'late',
    'required',
    'in',
    'is',
    'as',
  };
  const Set<String> types = {
    'BuildContext',
    'Widget',
    'Notification',
    'NotificationListener',
    'ScrollNotification',
    'ScrollStartNotification',
    'ScrollUpdateNotification',
    'ScrollEndNotification',
    'OverscrollNotification',
    'UserScrollNotification',
    'LayoutChangedNotification',
    'KeepAliveNotification',
    'SizeChangedLayoutNotification',
    'SizeChangedLayoutNotifier',
    'CountChangedNotification',
    'ScoreNotification',
    'IncrementButton',
    'CountScreen',
    'ListView',
    'Text',
    'Column',
    'TextButton',
    'GestureDetector',
    'StatelessWidget',
    'StatefulWidget',
    'State',
    'String',
    'int',
    'double',
    'bool',
  };

  final List<TextSpan> out = [];
  int i = 0;
  while (i < code.length) {
    final String c = code[i];

    // line comment
    if (c == '/' && i + 1 < code.length && code[i + 1] == '/') {
      int j = i;
      while (j < code.length && code[j] != '\n') {
        j++;
      }
      out.add(
        TextSpan(
          text: code.substring(i, j),
          style: TextStyle(
            color: _kCodeComment,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
      i = j;
      continue;
    }

    // string literal (single quote)
    if (c == '\u0027') {
      int j = i + 1;
      while (j < code.length && code[j] != '\u0027') {
        j++;
      }
      if (j < code.length) j++;
      out.add(
        TextSpan(
          text: code.substring(i, j),
          style: TextStyle(color: _kCodeString),
        ),
      );
      i = j;
      continue;
    }

    // identifier / keyword / type
    if (_privateIsIdentStart(c)) {
      int j = i + 1;
      while (j < code.length && _privateIsIdentPart(code[j])) {
        j++;
      }
      final String word = code.substring(i, j);
      Color col = _kCodeFg;
      if (keywords.contains(word)) {
        col = _kCodeKeyword;
      } else if (types.contains(word)) {
        col = _kCodeType;
      }
      out.add(TextSpan(text: word, style: TextStyle(color: col)));
      i = j;
      continue;
    }

    // number
    if (_privateIsDigit(c)) {
      int j = i + 1;
      while (j < code.length &&
          (_privateIsDigit(code[j]) || code[j] == '.')) {
        j++;
      }
      out.add(
        TextSpan(
          text: code.substring(i, j),
          style: TextStyle(color: _kCodeNumber),
        ),
      );
      i = j;
      continue;
    }

    // punctuation / whitespace fallthrough
    out.add(TextSpan(text: c));
    i++;
  }
  return out;
}

bool _privateIsIdentStart(String c) {
  if (c.isEmpty) return false;
  final int cp = c.codeUnitAt(0);
  return (cp >= 0x41 && cp <= 0x5A) ||
      (cp >= 0x61 && cp <= 0x7A) ||
      cp == 0x5F;
}

bool _privateIsIdentPart(String c) {
  if (c.isEmpty) return false;
  final int cp = c.codeUnitAt(0);
  return _privateIsIdentStart(c) || (cp >= 0x30 && cp <= 0x39);
}

bool _privateIsDigit(String c) {
  if (c.isEmpty) return false;
  final int cp = c.codeUnitAt(0);
  return cp >= 0x30 && cp <= 0x39;
}
