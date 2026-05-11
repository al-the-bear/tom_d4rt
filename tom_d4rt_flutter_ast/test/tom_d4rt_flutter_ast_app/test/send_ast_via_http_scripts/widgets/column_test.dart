// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, unused_element_parameter, unused_field, unnecessary_import
// =============================================================================
// Column — Visual Deep Demo
// =============================================================================
//
// This file is a hand-authored, exhaustive visual reference for the Flutter
// `Column` widget. It assumes a non-trivial reader: someone who has already
// shipped a few Flutter apps, understands the basics of the framework, but
// wants to see the *entire* alignment / sizing / direction matrix laid out
// side-by-side with bordered Container wrappers, so the actual flex layout
// boundaries are visible at a glance.
//
// The file intentionally avoids:
//   - `main()` — this is not an app entrypoint.
//   - `StatefulWidget` — Column is purely declarative; state is irrelevant.
//   - Any `package:flutter_test` import — this is a build-only script that
//     emits a single `Widget` tree from `build(BuildContext)` so the d4rt
//     pipeline can serialize and replay it.
//
// The shape of the file is fixed by the toolchain: a top-level
// `dynamic build(BuildContext context)` returns a `Widget`, and the host
// app embeds that widget into its own MaterialApp / Scaffold.
//
// -----------------------------------------------------------------------------
// Table of contents
// -----------------------------------------------------------------------------
//
//   1.  Dossier              — what Column is and is not
//   2.  Anatomy              — every constructor argument, annotated
//   3.  MainAxisAlignment    — 6 alignments × 4 child counts (24 panels)
//   4.  CrossAxisAlignment   — 5 alignments × 3 child widths (15 panels)
//   5.  MainAxisSize         — min vs max, with and without parents
//   6.  VerticalDirection    — up vs down comparison
//   7.  TextBaseline pairing — when baseline crossAxisAlignment makes sense
//   8.  TextDirection        — does it matter for a *vertical* Column? Yes.
//   9.  Recipes              — login form, sidebar, settings, stepper, tags,
//                              profile column
//  10.  Spacer / Expanded    — how flex children negotiate space
//  11.  Pitfalls             — unbounded height, baseline misuse, etc.
//  12.  Comparison           — Column vs Wrap vs ListView vs Stack
//  13.  Glossary             — terms used throughout this file
//  14.  Recap                — TL;DR cheat sheet
//
// -----------------------------------------------------------------------------
// Reading order
// -----------------------------------------------------------------------------
//
// You can scroll top-to-bottom; the widget tree is composed bottom-up but
// the documentation is presented top-down. If you only care about one
// section, jump to the corresponding `// --- SECTION N ---` banner.
//
// -----------------------------------------------------------------------------

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// =============================================================================
// Shared style constants
// =============================================================================
//
// We define a small palette and a few reusable BoxDecorations up front so the
// rest of the file is dense with *layout* rather than styling boilerplate.
// Every demo panel uses the same border treatment so flex boundaries are
// instantly recognizable.

const Color _kBorder = Color(0xFF334155); // slate-700, the panel border
const Color _kBorderSoft = Color(0xFF94A3B8); // slate-400, child borders
const Color _kBg = Color(0xFFF1F5F9); // slate-100, panel background
const Color _kCardBg = Color(0xFFFFFFFF); // white, recipe card background
const Color _kAccent = Color(0xFF2563EB); // blue-600, primary accents
const Color _kAccentSoft = Color(0xFFDBEAFE); // blue-100, accent backgrounds
const Color _kDanger = Color(0xFFDC2626); // red-600, "do not do this"
const Color _kSuccess = Color(0xFF16A34A); // green-600, "do this"
const Color _kWarning = Color(0xFFCA8A04); // yellow-600, "be careful"
const Color _kMuted = Color(0xFF64748B); // slate-500, secondary text
const Color _kInk = Color(0xFF0F172A); // slate-900, primary text

// Six distinct child colors so each child in a Column is unambiguous.
const Color _kC1 = Color(0xFFEF4444); // red
const Color _kC2 = Color(0xFFF59E0B); // amber
const Color _kC3 = Color(0xFF10B981); // emerald
const Color _kC4 = Color(0xFF3B82F6); // blue
const Color _kC5 = Color(0xFF8B5CF6); // violet
const Color _kC6 = Color(0xFFEC4899); // pink

// Reusable text styles. Kept terse — most demos label themselves visually.
const TextStyle _kTitle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w700,
  color: _kInk,
);
const TextStyle _kSubtitle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: _kInk,
);
const TextStyle _kBody = TextStyle(fontSize: 13, color: _kInk);
const TextStyle _kCode = TextStyle(
  fontSize: 12,
  fontFamily: 'monospace',
  color: _kInk,
);
const TextStyle _kCaption = TextStyle(fontSize: 11, color: _kMuted);
const TextStyle _kLabel = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w600,
  color: _kInk,
);

// Standard panel border. Used so every demo panel is visually identifiable
// as a *flex container* (i.e. you can see exactly where the Column ends).
BoxDecoration _panelDecoration({Color color = _kBg, Color? border}) {
  return BoxDecoration(
    color: color,
    border: Border.all(color: border ?? _kBorder, width: 1.0),
    borderRadius: BorderRadius.circular(6.0),
  );
}

// Slightly softer decoration for *child* boxes inside a Column. This makes
// it obvious which boxes belong to the parent's flex and which are children
// being laid out.
BoxDecoration _childDecoration(Color color) {
  return BoxDecoration(
    color: color,
    border: Border.all(color: _kBorderSoft, width: 0.5),
    borderRadius: BorderRadius.circular(3.0),
  );
}

// =============================================================================
// Tiny helpers — these are pure functions returning Widgets. They never
// capture state. They exist solely to keep the giant build() tree readable.
// =============================================================================

// A labeled section banner. Two horizontal rules + a centered title.
Widget _sectionBanner(String title, String subtitle) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 24.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(height: 2.0, color: _kBorder),
        const SizedBox(height: 12.0),
        Text(title, style: _kTitle, textAlign: TextAlign.center),
        const SizedBox(height: 4.0),
        Text(subtitle, style: _kCaption, textAlign: TextAlign.center),
        const SizedBox(height: 12.0),
        Container(height: 2.0, color: _kBorder),
      ],
    ),
  );
}

// A single demo panel: title + bordered fixed-size box containing `child`.
// The box has a fixed height so the visual matrix is comparable across
// alignments. Width is fixed too for the same reason.
Widget _panel({
  required String title,
  required Widget child,
  double width = 140.0,
  double height = 180.0,
  String? subtitle,
}) {
  return Container(
    margin: const EdgeInsets.all(6.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: _kLabel),
        if (subtitle != null) ...<Widget>[
          const SizedBox(height: 2.0),
          Text(subtitle, style: _kCaption),
        ],
        const SizedBox(height: 4.0),
        Container(
          width: width,
          height: height,
          decoration: _panelDecoration(),
          child: child,
        ),
      ],
    ),
  );
}

// A colored child box for use inside the demo Columns. Width is variable
// so CrossAxisAlignment.stretch behavior is visible.
Widget _kid(
  Color color, {
  double width = 60.0,
  double height = 24.0,
  String? label,
}) {
  return Container(
    width: width,
    height: height,
    decoration: _childDecoration(color),
    alignment: Alignment.center,
    child: label == null
        ? null
        : Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
  );
}

// A baseline-aware text child. Used in the CrossAxisAlignment.baseline demos.
Widget _textKid(String text, double fontSize, Color color) {
  return Container(
    decoration: BoxDecoration(
      color: color.withOpacity(0.15),
      border: Border.all(color: color, width: 0.5),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
    child: Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: _kInk,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// A compact key-value row used inside several recipes.
Widget _kv(String k, String v) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 90.0,
          child: Text(k, style: _kCaption),
        ),
        Expanded(child: Text(v, style: _kBody)),
      ],
    ),
  );
}

// A markdown-style code block. Plain Container with a fixed font.
Widget _code(String snippet) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: const Color(0xFF0F172A),
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Text(
      snippet,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: Color(0xFFE2E8F0),
        height: 1.4,
      ),
    ),
  );
}

// A "callout" box. Color signals the kind: info / warning / danger / success.
Widget _callout(String kind, String title, String body) {
  final Color color = switch (kind) {
    'danger' => _kDanger,
    'warning' => _kWarning,
    'success' => _kSuccess,
    _ => _kAccent,
  };
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.withOpacity(0.08),
      border: Border(left: BorderSide(color: color, width: 4.0)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(body, style: _kBody),
      ],
    ),
  );
}

// =============================================================================
// SECTION 1 — Dossier
// =============================================================================
//
// Column is a sub-class of Flex with `direction: Axis.vertical` hardcoded.
// It lays out its `children` along a vertical *main axis*, top-to-bottom by
// default. Children are placed one after the other; remaining space along
// the main axis is distributed according to `mainAxisAlignment`, and any
// `Expanded` / `Flexible` children consume flex space first.
//
// Things Column does NOT do that beginners often expect it to:
//   - It does not scroll. If content overflows, you get the yellow/black
//     stripes. Wrap in a SingleChildScrollView or use ListView instead.
//   - It does not wrap. If children exceed the available height, they
//     overflow. Use Wrap if you want flow layout.
//   - It does not size to children when given unbounded height; it asserts.
//   - It does not justify text or apply paragraph baseline alignment unless
//     you specifically set CrossAxisAlignment.baseline AND a textBaseline.
//
// Things Column DOES do that are worth remembering:
//   - It respects TextDirection for *cross-axis* `start`/`end` (left/right).
//   - It respects VerticalDirection for *main-axis* `start`/`end` (up/down).
//   - It treats every non-flex child as a tight constraint along main axis
//     and an unconstrained (loose) constraint along cross axis.
//   - It computes baseline only for the *first* baseline-aligned child;
//     other children are aligned to that.

Widget _section1Dossier() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(16.0),
    decoration: _panelDecoration(color: _kCardBg),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('1. Dossier — what Column is', style: _kSubtitle),
        const SizedBox(height: 8.0),
        const Text(
          'Column is a Flex with direction=Axis.vertical. It arranges '
          'children along a vertical main axis. It does NOT scroll, NOT wrap, '
          'and asserts if the main-axis is unbounded without intrinsic sizing.',
          style: _kBody,
        ),
        _code(
          'Column(\n'
          '  mainAxisAlignment: MainAxisAlignment.start,\n'
          '  crossAxisAlignment: CrossAxisAlignment.center,\n'
          '  mainAxisSize: MainAxisSize.max,\n'
          '  verticalDirection: VerticalDirection.down,\n'
          '  textDirection: TextDirection.ltr,\n'
          '  textBaseline: TextBaseline.alphabetic,\n'
          '  children: <Widget>[ ... ],\n'
          ')',
        ),
        _callout(
          'info',
          'Mental model',
          'Think of Column as a stack of horizontal shelves. Main axis = '
              'how shelves are vertically distributed. Cross axis = how each '
              'shelf is horizontally aligned.',
        ),
        _callout(
          'warning',
          'Unbounded height',
          'If you put a Column inside a parent that does not constrain its '
              'height (Scrollable, IntrinsicHeight contexts, unconstrained '
              'Box constraints), use mainAxisSize: MainAxisSize.min or wrap '
              'the Column in a SizedBox/Container with a fixed height.',
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 2 — Anatomy
// =============================================================================
//
// Every constructor argument of Column annotated with one or two sentences
// of intent and a typical default. Reading this once should remove most
// surprises.

Widget _section2Anatomy() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(16.0),
    decoration: _panelDecoration(color: _kCardBg),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('2. Anatomy — every argument', style: _kSubtitle),
        const SizedBox(height: 8.0),
        _kv(
          'children',
          'List<Widget>. The vertical sequence. Reordering matters. '
              'Insert SizedBox(height: N) for gaps.',
        ),
        _kv(
          'mainAxisAlignment',
          'How free vertical space is distributed: start (default), end, '
              'center, spaceBetween, spaceAround, spaceEvenly.',
        ),
        _kv(
          'crossAxisAlignment',
          'How each child is positioned horizontally: start, center (default '
              'after constraints!), end, stretch, baseline.',
        ),
        _kv(
          'mainAxisSize',
          'max (default): fill parent height. min: shrink-wrap to sum of '
              'child heights. Critical inside scroll views.',
        ),
        _kv(
          'verticalDirection',
          'down (default): first child at top. up: first child at bottom. '
              'Affects start/end interpretation on main axis.',
        ),
        _kv(
          'textDirection',
          'ltr (default in en-US): start = left, end = right. rtl flips '
              'horizontal start/end. Affects cross axis.',
        ),
        _kv(
          'textBaseline',
          'Required ONLY when crossAxisAlignment is baseline. Choose '
              'alphabetic (Latin scripts) or ideographic (CJK).',
        ),
        _kv(
          'key',
          'Standard Widget key. Useful when reordering children to preserve '
              'element identity.',
        ),
        _code(
          '// Typical "fill parent, top-to-bottom, stretch wide":\n'
          'Column(\n'
          '  crossAxisAlignment: CrossAxisAlignment.stretch,\n'
          '  children: const <Widget>[ ... ],\n'
          ')',
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 3 — MainAxisAlignment: 6 × 4 matrix
// =============================================================================
//
// 24 panels. Each row pins one MainAxisAlignment value. Each column pins a
// child count: 0, 2, 3, 5. The empty (0-children) column is included on
// purpose: it shows that with no children, alignment has nothing to act on.
//
// Why these counts?
//   - 0: degenerate case. Useful for documenting that Column(children: [])
//        renders as an empty zero-height box (when mainAxisSize: min) or a
//        full-height empty box (when max).
//   - 2: minimum needed to see space *between* children differ from space
//        *around* children.
//   - 3: classic "logo, content, footer" pattern.
//   - 5: enough to make spaceBetween vs spaceAround vs spaceEvenly visibly
//        different. With only 3, spaceAround and spaceEvenly look similar.

List<Widget> _kidsCount(int n) {
  const List<Color> palette = <Color>[_kC1, _kC2, _kC3, _kC4, _kC5];
  return <Widget>[
    for (int i = 0; i < n; i++)
      _kid(palette[i % palette.length], label: 'C${i + 1}'),
  ];
}

Widget _mainAxisCell(MainAxisAlignment a, int n) {
  return _panel(
    title: '$n child${n == 1 ? '' : 'ren'}',
    width: 110.0,
    height: 200.0,
    child: Column(
      mainAxisAlignment: a,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _kidsCount(n),
    ),
  );
}

Widget _mainAxisRow(MainAxisAlignment a, String label, String hint) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(8.0),
    decoration: _panelDecoration(color: _kCardBg),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: <Widget>[
            Text(label, style: _kSubtitle),
            const SizedBox(width: 8.0),
            Expanded(child: Text(hint, style: _kCaption)),
          ],
        ),
        const SizedBox(height: 6.0),
        Wrap(
          children: <Widget>[
            _mainAxisCell(a, 0),
            _mainAxisCell(a, 2),
            _mainAxisCell(a, 3),
            _mainAxisCell(a, 5),
          ],
        ),
      ],
    ),
  );
}

Widget _section3MainAxisMatrix() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      const SizedBox(height: 8.0),
      const Text(
        '3. MainAxisAlignment — every value × {0, 2, 3, 5} children',
        style: _kSubtitle,
      ),
      const SizedBox(height: 6.0),
      const Text(
        'Each box is 110×200. Children are 60×24 with mainAxisSize.max so '
        'the Column fills the box vertically and alignment is observable.',
        style: _kCaption,
      ),
      _mainAxisRow(
        MainAxisAlignment.start,
        'start',
        'Children packed at the top. Free space below. (Default.)',
      ),
      _mainAxisRow(
        MainAxisAlignment.center,
        'center',
        'Children packed in the middle. Equal free space top & bottom.',
      ),
      _mainAxisRow(
        MainAxisAlignment.end,
        'end',
        'Children packed at the bottom. Free space above.',
      ),
      _mainAxisRow(
        MainAxisAlignment.spaceBetween,
        'spaceBetween',
        'Equal gaps BETWEEN children. None at top/bottom. (n=0,1 → start.)',
      ),
      _mainAxisRow(
        MainAxisAlignment.spaceAround,
        'spaceAround',
        'Half-gaps at edges, full gaps between. Children get equal halos.',
      ),
      _mainAxisRow(
        MainAxisAlignment.spaceEvenly,
        'spaceEvenly',
        'Equal gaps everywhere: top, between, bottom. The cleanest split.',
      ),
      _callout(
        'info',
        'Edge cases',
        'With 0 children, all six alignments render the same: an empty box. '
            'With 1 child, spaceBetween behaves like start (no "between" to '
            'distribute). spaceAround and spaceEvenly center the single child.',
      ),
    ],
  );
}

// =============================================================================
// SECTION 4 — CrossAxisAlignment: 5 × 3 matrix
// =============================================================================
//
// CrossAxisAlignment controls horizontal placement of each child inside the
// Column's width. We show 5 alignment values × 3 child width patterns:
//   - uniform: all children 60 wide (no width variation to highlight cross
//     positioning vs. width differences)
//   - varied:  children 40 / 80 / 50 / 100 (alignment is most visible here)
//   - text:    text children of different font sizes (baseline only meaningful
//              when content has a real baseline)

Widget _crossAxisCellUniform(CrossAxisAlignment a) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: a,
    textBaseline: a == CrossAxisAlignment.baseline
        ? TextBaseline.alphabetic
        : null,
    children: a == CrossAxisAlignment.baseline
        ? <Widget>[
            _textKid('Aa', 12.0, _kC1),
            _textKid('Aa', 12.0, _kC2),
            _textKid('Aa', 12.0, _kC3),
          ]
        : <Widget>[
            _kid(_kC1, width: 60.0),
            _kid(_kC2, width: 60.0),
            _kid(_kC3, width: 60.0),
          ],
  );
}

Widget _crossAxisCellVaried(CrossAxisAlignment a) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: a,
    textBaseline: a == CrossAxisAlignment.baseline
        ? TextBaseline.alphabetic
        : null,
    children: a == CrossAxisAlignment.baseline
        ? <Widget>[
            _textKid('Big', 22.0, _kC1),
            _textKid('mid', 16.0, _kC2),
            _textKid('tiny', 10.0, _kC3),
            _textKid('Med', 14.0, _kC4),
          ]
        : <Widget>[
            _kid(_kC1, width: 40.0),
            _kid(_kC2, width: 80.0),
            _kid(_kC3, width: 50.0),
            _kid(_kC4, width: 100.0),
          ],
  );
}

Widget _crossAxisCellText(CrossAxisAlignment a) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: a,
    textBaseline: a == CrossAxisAlignment.baseline
        ? TextBaseline.alphabetic
        : null,
    children: <Widget>[
      _textKid('header', 18.0, _kC4),
      _textKid('body text line', 12.0, _kC4),
      _textKid('footer', 10.0, _kC4),
    ],
  );
}

Widget _crossAxisRow(CrossAxisAlignment a, String label, String hint) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(8.0),
    decoration: _panelDecoration(color: _kCardBg),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: <Widget>[
            Text(label, style: _kSubtitle),
            const SizedBox(width: 8.0),
            Expanded(child: Text(hint, style: _kCaption)),
          ],
        ),
        const SizedBox(height: 6.0),
        Wrap(
          children: <Widget>[
            _panel(
              title: 'uniform widths',
              width: 160.0,
              height: 180.0,
              child: _crossAxisCellUniform(a),
            ),
            _panel(
              title: 'varied widths',
              width: 160.0,
              height: 180.0,
              child: _crossAxisCellVaried(a),
            ),
            _panel(
              title: 'text children',
              width: 160.0,
              height: 180.0,
              child: _crossAxisCellText(a),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _section4CrossAxisMatrix() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      const SizedBox(height: 8.0),
      const Text(
        '4. CrossAxisAlignment — every value × {uniform, varied, text}',
        style: _kSubtitle,
      ),
      const SizedBox(height: 6.0),
      const Text(
        'Cross axis on a Column is HORIZONTAL. Watch how children of '
        'different widths shift left/right (or stretch full-width).',
        style: _kCaption,
      ),
      _crossAxisRow(
        CrossAxisAlignment.start,
        'start',
        'Hugs the left (or right under RTL). Default for many layouts.',
      ),
      _crossAxisRow(
        CrossAxisAlignment.center,
        'center',
        'Each child centered horizontally on its own. (Default.)',
      ),
      _crossAxisRow(
        CrossAxisAlignment.end,
        'end',
        'Hugs the right (or left under RTL).',
      ),
      _crossAxisRow(
        CrossAxisAlignment.stretch,
        'stretch',
        'Each child forced to full available width. Child widths are ignored.',
      ),
      _crossAxisRow(
        CrossAxisAlignment.baseline,
        'baseline',
        'Aligns text baselines. Requires textBaseline. Useless without text.',
      ),
      _callout(
        'warning',
        'stretch + intrinsic widths',
        'CrossAxisAlignment.stretch overrides child width entirely. If you '
            'specified width: 100 on a child, it will still be stretched. To '
            'preserve a width, wrap it in Align(alignment: Alignment.centerLeft).',
      ),
      _callout(
        'danger',
        'baseline misuse',
        'Setting crossAxisAlignment: baseline without textBaseline triggers '
            'an assert in debug. Setting it on non-text children silently '
            'falls back to bottom of the box, which is rarely what you want.',
      ),
    ],
  );
}

// =============================================================================
// SECTION 5 — MainAxisSize: min vs max
// =============================================================================
//
// max (default): the Column tries to fill its parent's available height. If
//   the parent's height is unbounded, this is an error. mainAxisAlignment
//   has visible effect: free space is distributed.
//
// min: the Column shrinks to the sum of its children's heights. Free space
//   does not exist; mainAxisAlignment values have no observable effect
//   (start/end/center/spaceXxx all look identical when there's no free space).

Widget _section5MainAxisSize() {
  Widget cell(MainAxisSize size, String t) {
    return _panel(
      title: t,
      width: 140.0,
      height: 200.0,
      child: Column(
        mainAxisSize: size,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _kid(_kC1, label: 'A'),
          _kid(_kC2, label: 'B'),
          _kid(_kC3, label: 'C'),
        ],
      ),
    );
  }

  Widget cellInRow(MainAxisSize size, String t) {
    // Show how mainAxisSize behaves inside a Row (cross-axis container with
    // limited *cross* extent — the Column is sized loosely).
    return _panel(
      title: t,
      width: 220.0,
      height: 200.0,
      child: Row(
        children: <Widget>[
          Container(
            color: _kAccentSoft,
            child: Column(
              mainAxisSize: size,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _kid(_kC1, label: 'A'),
                _kid(_kC2, label: 'B'),
                _kid(_kC3, label: 'C'),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          const Expanded(
            child: Text(
              'The blue tint shows what the Column actually occupies.',
              style: _kCaption,
            ),
          ),
        ],
      ),
    );
  }

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(16.0),
    decoration: _panelDecoration(color: _kCardBg),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('5. MainAxisSize — min vs max', style: _kSubtitle),
        const SizedBox(height: 6.0),
        const Text(
          'Same children, same mainAxisAlignment (spaceBetween). Only '
          'mainAxisSize differs. When min, free space does not exist, so '
          'spaceBetween has nothing to distribute.',
          style: _kCaption,
        ),
        Wrap(
          children: <Widget>[
            cell(MainAxisSize.max, 'MainAxisSize.max'),
            cell(MainAxisSize.min, 'MainAxisSize.min'),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'Inside a Row (cross-axis parent): the Column receives a loose '
          'height constraint. min hugs the children, max stretches to fill.',
          style: _kCaption,
        ),
        Wrap(
          children: <Widget>[
            cellInRow(MainAxisSize.max, 'In Row + max'),
            cellInRow(MainAxisSize.min, 'In Row + min'),
          ],
        ),
        _callout(
          'warning',
          'When in doubt, use min',
          'In list cells, dialogs, and other "intrinsic" contexts, use '
              'MainAxisSize.min. Only use max when you intentionally want '
              'to fill vertical space and distribute it via alignment.',
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 6 — VerticalDirection: down vs up
// =============================================================================
//
// down (default): children laid out top → bottom. First child = top.
// up: children laid out bottom → top. First child = bottom.
//
// Affects which end MainAxisAlignment.start and .end refer to, but does
// NOT reverse the children list — you keep declaring children in logical
// order.

Widget _section6VerticalDirection() {
  Widget cell(VerticalDirection vd, MainAxisAlignment ma, String t) {
    return _panel(
      title: t,
      width: 110.0,
      height: 200.0,
      child: Column(
        verticalDirection: vd,
        mainAxisAlignment: ma,
        children: <Widget>[
          _kid(_kC1, label: '1'),
          _kid(_kC2, label: '2'),
          _kid(_kC3, label: '3'),
        ],
      ),
    );
  }

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(16.0),
    decoration: _panelDecoration(color: _kCardBg),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '6. VerticalDirection — down (default) vs up',
          style: _kSubtitle,
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Children are always declared [1, 2, 3] in code. Direction flips '
          'which end is treated as start.',
          style: _kCaption,
        ),
        Wrap(
          children: <Widget>[
            cell(VerticalDirection.down, MainAxisAlignment.start, 'down + start'),
            cell(VerticalDirection.up, MainAxisAlignment.start, 'up + start'),
            cell(VerticalDirection.down, MainAxisAlignment.end, 'down + end'),
            cell(VerticalDirection.up, MainAxisAlignment.end, 'up + end'),
            cell(VerticalDirection.down, MainAxisAlignment.spaceBetween,
                'down + between'),
            cell(VerticalDirection.up, MainAxisAlignment.spaceBetween,
                'up + between'),
          ],
        ),
        _callout(
          'info',
          'Use case for up',
          'Chat message lists, log viewers, or "growing upward" UIs. But '
              'usually you would use ListView(reverse: true) instead, which '
              'composes better with scrolling.',
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 7 — TextBaseline pairing
// =============================================================================
//
// crossAxisAlignment: baseline only works for text-bearing children, and
// requires you to pick a TextBaseline: alphabetic or ideographic.

Widget _section7TextBaseline() {
  Widget cell(TextBaseline tb, String t) {
    return _panel(
      title: t,
      width: 180.0,
      height: 120.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: tb,
        children: <Widget>[
          _textKid('Aa 24', 24.0, _kC1),
          _textKid('bg 14', 14.0, _kC2),
          _textKid('gp 10', 10.0, _kC3),
        ],
      ),
    );
  }

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(16.0),
    decoration: _panelDecoration(color: _kCardBg),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '7. TextBaseline — alphabetic vs ideographic',
          style: _kSubtitle,
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Both look similar for Latin scripts. ideographic is for CJK '
          'glyphs whose baseline differs from Latin alphabetic.',
          style: _kCaption,
        ),
        Wrap(
          children: <Widget>[
            cell(TextBaseline.alphabetic, 'alphabetic'),
            cell(TextBaseline.ideographic, 'ideographic'),
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 8 — TextDirection on a Column
// =============================================================================
//
// TextDirection affects how CrossAxisAlignment.start and .end map to
// left/right. In ltr, start = left. In rtl, start = right.

Widget _section8TextDirection() {
  Widget cell(TextDirection td, CrossAxisAlignment ca, String t) {
    return _panel(
      title: t,
      width: 160.0,
      height: 130.0,
      child: Directionality(
        textDirection: td,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: ca,
          children: <Widget>[
            _kid(_kC1, width: 40.0, label: 'A'),
            _kid(_kC2, width: 60.0, label: 'B'),
            _kid(_kC3, width: 30.0, label: 'C'),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(16.0),
    decoration: _panelDecoration(color: _kCardBg),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('8. TextDirection — ltr vs rtl', style: _kSubtitle),
        const SizedBox(height: 6.0),
        const Text(
          'start/end on the cross axis flip between left/right depending on '
          'ambient or explicit Directionality.',
          style: _kCaption,
        ),
        Wrap(
          children: <Widget>[
            cell(TextDirection.ltr, CrossAxisAlignment.start, 'ltr + start'),
            cell(TextDirection.rtl, CrossAxisAlignment.start, 'rtl + start'),
            cell(TextDirection.ltr, CrossAxisAlignment.end, 'ltr + end'),
            cell(TextDirection.rtl, CrossAxisAlignment.end, 'rtl + end'),
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 9 — Recipes
// =============================================================================
//
// Six realistic Column-driven patterns. Each is wrapped in a fixed-size
// bordered container so flex behaviour is visible.

// --- Recipe 1: Login form ----------------------------------------------------
Widget _recipeLoginForm() {
  return Container(
    width: 280.0,
    padding: const EdgeInsets.all(16.0),
    decoration: _panelDecoration(color: _kCardBg),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text('Sign in', style: _kTitle),
        const SizedBox(height: 4.0),
        const Text('Welcome back. Use your email to sign in.',
            style: _kCaption),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          decoration: BoxDecoration(
            border: Border.all(color: _kBorderSoft),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: const Text('email@example.com', style: _kBody),
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          decoration: BoxDecoration(
            border: Border.all(color: _kBorderSoft),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: const Text('••••••••', style: _kBody),
        ),
        const SizedBox(height: 4.0),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Forgot password?',
            style: TextStyle(
              fontSize: 12,
              color: _kAccent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            color: _kAccent,
            borderRadius: BorderRadius.circular(4.0),
          ),
          alignment: Alignment.center,
          child: const Text(
            'Sign in',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'or continue with',
          style: _kCaption,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            for (final String label in <String>['Google', 'GitHub', 'SSO'])
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 6.0),
                decoration: BoxDecoration(
                  border: Border.all(color: _kBorderSoft),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(label, style: _kCaption),
              ),
          ],
        ),
      ],
    ),
  );
}

// --- Recipe 2: Dashboard sidebar ---------------------------------------------
Widget _recipeSidebar() {
  Widget item(IconData icon, String label, {bool active = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: active ? _kAccentSoft : null,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        children: <Widget>[
          Icon(icon,
              size: 16, color: active ? _kAccent : _kMuted),
          const SizedBox(width: 10.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: active ? FontWeight.w700 : FontWeight.w500,
              color: active ? _kAccent : _kInk,
            ),
          ),
        ],
      ),
    );
  }

  return Container(
    width: 200.0,
    height: 420.0,
    decoration: _panelDecoration(color: _kCardBg),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 28.0,
                height: 28.0,
                decoration: BoxDecoration(
                  color: _kAccent,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'T',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              const Text('Tom Console', style: _kLabel),
            ],
          ),
        ),
        Container(height: 1.0, color: _kBorderSoft),
        const SizedBox(height: 8.0),
        item(Icons.dashboard_outlined, 'Overview', active: true),
        item(Icons.layers_outlined, 'Projects'),
        item(Icons.work_outline, 'Quests'),
        item(Icons.task_alt_outlined, 'Todos'),
        item(Icons.bug_report_outlined, 'Issues'),
        const Spacer(),
        Container(height: 1.0, color: _kBorderSoft),
        item(Icons.settings_outlined, 'Settings'),
        item(Icons.logout, 'Sign out'),
      ],
    ),
  );
}

// --- Recipe 3: Settings list -------------------------------------------------
Widget _recipeSettingsList() {
  Widget row(String label, String value, {bool last = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      decoration: BoxDecoration(
        border: last
            ? null
            : const Border(
                bottom: BorderSide(color: _kBorderSoft, width: 0.5),
              ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(child: Text(label, style: _kBody)),
          Text(value, style: _kCaption),
          const SizedBox(width: 6.0),
          const Icon(Icons.chevron_right, size: 16, color: _kMuted),
        ],
      ),
    );
  }

  return Container(
    width: 320.0,
    decoration: _panelDecoration(color: _kCardBg),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(12.0),
          child: const Text('Account', style: _kLabel),
        ),
        row('Display name', 'Alexis'),
        row('Email', 'alexis@example.com'),
        row('Language', 'English'),
        row('Theme', 'System', last: true),
        Container(
          padding: const EdgeInsets.all(12.0),
          child: const Text('Notifications', style: _kLabel),
        ),
        row('Email digest', 'Weekly'),
        row('Mentions', 'Immediately'),
        row('Quiet hours', '22:00–07:00', last: true),
      ],
    ),
  );
}

// --- Recipe 4: Vertical step indicator ---------------------------------------
Widget _recipeStepper() {
  Widget step(int n, String label, String detail,
      {bool done = false, bool active = false, bool last = false}) {
    final Color dot =
        done ? _kSuccess : active ? _kAccent : _kBorderSoft;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: 22.0,
                height: 22.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: dot,
                  shape: BoxShape.circle,
                ),
                child: done
                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                    : Text(
                        '$n',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
              if (!last)
                Expanded(
                  child: Container(width: 2.0, color: dot),
                ),
            ],
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(label,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight:
                            active ? FontWeight.w700 : FontWeight.w600,
                        color: active ? _kAccent : _kInk,
                      )),
                  const SizedBox(height: 2.0),
                  Text(detail, style: _kCaption),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  return Container(
    width: 320.0,
    padding: const EdgeInsets.all(14.0),
    decoration: _panelDecoration(color: _kCardBg),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text('Onboarding', style: _kLabel),
        const SizedBox(height: 12.0),
        step(1, 'Create account', 'Verified email.', done: true),
        step(2, 'Pick a workspace', 'Joined "tom-agent".', done: true),
        step(3, 'Invite teammates',
            'Send invites to collaborators.', active: true),
        step(4, 'Configure runtime',
            'Local Docker or hosted.', last: false),
        step(5, 'Run first quest',
            'A quest is a multi-step AI task.', last: true),
      ],
    ),
  );
}

// --- Recipe 5: Tags column ---------------------------------------------------
Widget _recipeTagsColumn() {
  Widget tag(String text, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        border: Border.all(color: color, width: 0.5),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  return Container(
    width: 180.0,
    padding: const EdgeInsets.all(12.0),
    decoration: _panelDecoration(color: _kCardBg),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Labels', style: _kLabel),
        const SizedBox(height: 6.0),
        tag('bug', _kDanger),
        tag('enhancement', _kAccent),
        tag('documentation', _kSuccess),
        tag('blocked', _kWarning),
        tag('needs-triage', _kMuted),
        tag('good-first-issue', _kC5),
      ],
    ),
  );
}

// --- Recipe 6: Profile column ------------------------------------------------
Widget _recipeProfile() {
  return Container(
    width: 240.0,
    padding: const EdgeInsets.all(16.0),
    decoration: _panelDecoration(color: _kCardBg),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 72.0,
          height: 72.0,
          decoration: BoxDecoration(
            color: _kAccentSoft,
            shape: BoxShape.circle,
            border: Border.all(color: _kAccent, width: 2.0),
          ),
          alignment: Alignment.center,
          child: const Text(
            'AK',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: _kAccent,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        const Text('Alexis Kyaw', style: _kSubtitle),
        const Text('Principal Engineer', style: _kCaption),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                const Text('128', style: _kLabel),
                const Text('quests', style: _kCaption),
              ],
            ),
            Column(
              children: <Widget>[
                const Text('1.2k', style: _kLabel),
                const Text('commits', style: _kCaption),
              ],
            ),
            Column(
              children: <Widget>[
                const Text('42', style: _kLabel),
                const Text('PRs', style: _kCaption),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: _kAccent,
            borderRadius: BorderRadius.circular(4.0),
          ),
          alignment: Alignment.center,
          child: const Text(
            'Message',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _section9Recipes() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(16.0),
    decoration: _panelDecoration(color: _kCardBg),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('9. Recipes', style: _kSubtitle),
        const SizedBox(height: 6.0),
        const Text(
          'Six realistic Column-driven patterns. Hover (mentally) over the '
          'panel borders to see flex bounds.',
          style: _kCaption,
        ),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            _recipeLoginForm(),
            _recipeSidebar(),
            _recipeSettingsList(),
            _recipeStepper(),
            _recipeTagsColumn(),
            _recipeProfile(),
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 10 — Spacer and Expanded inside a Column
// =============================================================================
//
// Expanded(child:) and Spacer() are flex-allocated children. They consume
// remaining main-axis space according to their `flex` weight. Spacer is
// just Expanded(child: SizedBox.shrink()) — a named convenience.

Widget _section10SpacerExpanded() {
  Widget cell(String t, Column col) {
    return _panel(title: t, width: 140.0, height: 220.0, child: col);
  }

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(16.0),
    decoration: _panelDecoration(color: _kCardBg),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '10. Spacer & Expanded inside a Column',
          style: _kSubtitle,
        ),
        const SizedBox(height: 6.0),
        const Text(
          'flex children consume the leftover main-axis space first. Any '
          'non-flex child contributes its intrinsic height; what is left is '
          'split by the flex factors.',
          style: _kCaption,
        ),
        Wrap(
          children: <Widget>[
            cell(
              'no flex',
              Column(
                children: <Widget>[
                  _kid(_kC1, label: 'A'),
                  _kid(_kC2, label: 'B'),
                  _kid(_kC3, label: 'C'),
                ],
              ),
            ),
            cell(
              '1 Spacer',
              Column(
                children: <Widget>[
                  _kid(_kC1, label: 'A'),
                  const Spacer(),
                  _kid(_kC2, label: 'B'),
                  _kid(_kC3, label: 'C'),
                ],
              ),
            ),
            cell(
              '2 Spacers',
              Column(
                children: <Widget>[
                  _kid(_kC1, label: 'A'),
                  const Spacer(),
                  _kid(_kC2, label: 'B'),
                  const Spacer(),
                  _kid(_kC3, label: 'C'),
                ],
              ),
            ),
            cell(
              'Expanded mid',
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _kid(_kC1, label: 'header', width: 80.0),
                  Expanded(
                    child: Container(
                      color: _kAccentSoft,
                      alignment: Alignment.center,
                      child: const Text('body', style: _kBody),
                    ),
                  ),
                  _kid(_kC3, label: 'footer', width: 80.0),
                ],
              ),
            ),
            cell(
              'flex 1/2',
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(color: _kC1, alignment: Alignment.center,
                        child: const Text('1', style: _kBody)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(color: _kC2, alignment: Alignment.center,
                        child: const Text('2', style: _kBody)),
                  ),
                ],
              ),
            ),
            cell(
              'flex 1/2/3',
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(color: _kC1, alignment: Alignment.center,
                        child: const Text('1', style: _kBody)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(color: _kC2, alignment: Alignment.center,
                        child: const Text('2', style: _kBody)),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(color: _kC3, alignment: Alignment.center,
                        child: const Text('3', style: _kBody)),
                  ),
                ],
              ),
            ),
          ],
        ),
        _callout(
          'info',
          'Flexible vs Expanded',
          'Expanded == Flexible(fit: FlexFit.tight). Flexible(fit: loose) '
              'allows the child to be smaller than its allocated slice.',
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 11 — Pitfalls
// =============================================================================

Widget _section11Pitfalls() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(16.0),
    decoration: _panelDecoration(color: _kCardBg),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('11. Common pitfalls', style: _kSubtitle),
        const SizedBox(height: 6.0),
        _callout(
          'danger',
          'Unbounded height',
          'Putting a Column inside a SingleChildScrollView, a ListView item '
              'using shrinkWrap, or any IntrinsicHeight context with '
              'mainAxisSize.max throws RenderFlex with unbounded constraints. '
              'Fix: mainAxisSize.min, or wrap in SizedBox(height: ...).',
        ),
        _callout(
          'danger',
          'baseline without textBaseline',
          'Asserts in debug, undefined in release. Always pair '
              'CrossAxisAlignment.baseline with a TextBaseline.',
        ),
        _callout(
          'warning',
          'stretch with intrinsic-width children',
          'CrossAxisAlignment.stretch overrides child widths. If you need '
              'mixed widths, use start/center/end and let each child size '
              'itself, or wrap stretching children in SizedBox.',
        ),
        _callout(
          'warning',
          'mainAxisAlignment on MainAxisSize.min',
          'Has no observable effect — there is no free space to distribute. '
              'If alignment "is not working", check mainAxisSize first.',
        ),
        _callout(
          'warning',
          'Expanded inside scrolling Column',
          'Expanded requires a bounded parent main axis. Inside a '
              'SingleChildScrollView, the Column main axis is unbounded, so '
              'Expanded explodes. Switch to ListView or fix the height.',
        ),
        _callout(
          'info',
          'Reordering children and keys',
          'When animating reorders, give each child a unique Key. Otherwise '
              'the element tree re-uses positions and state gets reattached '
              'to the wrong child.',
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 12 — Column vs Wrap vs ListView vs Stack
// =============================================================================

Widget _section12Comparison() {
  Widget block(String title, String when, String avoid, Widget demo) {
    return Container(
      width: 220.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: _panelDecoration(color: _kCardBg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(title, style: _kSubtitle),
          const SizedBox(height: 4.0),
          Text('Use when: $when', style: _kCaption),
          Text('Avoid when: $avoid', style: _kCaption),
          const SizedBox(height: 8.0),
          Container(
            height: 160.0,
            decoration: _panelDecoration(),
            child: demo,
          ),
        ],
      ),
    );
  }

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '12. Comparison: Column vs alternatives',
          style: _kSubtitle,
        ),
        const SizedBox(height: 6.0),
        Wrap(
          children: <Widget>[
            block(
              'Column',
              'fixed small list of vertical children',
              'children can overflow or need to scroll',
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _kid(_kC1, label: 'A'),
                  _kid(_kC2, label: 'B'),
                  _kid(_kC3, label: 'C'),
                ],
              ),
            ),
            block(
              'Wrap',
              'children should flow to next "line" when out of space',
              'children have an order-critical visual sequence',
              Wrap(
                direction: Axis.vertical,
                spacing: 4.0,
                runSpacing: 4.0,
                children: <Widget>[
                  for (int i = 0; i < 10; i++)
                    _kid(<Color>[_kC1, _kC2, _kC3, _kC4, _kC5][i % 5],
                        width: 40.0, label: '$i'),
                ],
              ),
            ),
            block(
              'ListView',
              'long list, scrolling required, many children',
              'few children with no scrolling needed (overkill)',
              ListView(
                children: <Widget>[
                  for (int i = 0; i < 14; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: _kid(
                          <Color>[_kC1, _kC2, _kC3, _kC4, _kC5][i % 5],
                          width: double.infinity, label: 'row $i'),
                    ),
                ],
              ),
            ),
            block(
              'Stack',
              'children overlap or are absolutely positioned',
              'children should not overlap',
              Stack(
                children: <Widget>[
                  Positioned(
                    top: 8.0, left: 8.0,
                    child: _kid(_kC1, width: 60.0, height: 60.0, label: 'top'),
                  ),
                  Positioned(
                    top: 40.0, left: 40.0,
                    child: _kid(_kC2, width: 60.0, height: 60.0, label: 'mid'),
                  ),
                  Positioned(
                    top: 72.0, left: 72.0,
                    child: _kid(_kC3, width: 60.0, height: 60.0, label: 'bot'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 13 — Glossary
// =============================================================================

Widget _section13Glossary() {
  Widget term(String t, String d) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 150.0,
            child: Text(t, style: _kLabel),
          ),
          Expanded(child: Text(d, style: _kBody)),
        ],
      ),
    );
  }

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(16.0),
    decoration: _panelDecoration(color: _kCardBg),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('13. Glossary', style: _kSubtitle),
        const SizedBox(height: 8.0),
        term('Main axis',
            'For Column: vertical. For Row: horizontal. The axis along which '
                'children are laid out.'),
        term('Cross axis',
            'Perpendicular to the main axis. For Column: horizontal width.'),
        term('Tight constraints',
            'A min == max constraint. Forces the child to a specific size.'),
        term('Loose constraints',
            'min = 0, max = something. The child can pick any size up to max.'),
        term('Unbounded constraint',
            'Max is infinity. The child must size itself; it cannot fill.'),
        term('Intrinsic size',
            'A widget\'s preferred natural size, independent of constraints.'),
        term('Flex factor',
            'The integer weight passed to Expanded/Flexible. Free space is '
                'divided in proportion to these weights.'),
        term('Baseline',
            'The invisible line on which Latin text "sits". '
                'CrossAxisAlignment.baseline aligns children to a shared one.'),
        term('TextDirection',
            'ltr or rtl. Determines which end is "start" on the cross axis.'),
        term('VerticalDirection',
            'down or up. Determines which end is "start" on the main axis.'),
      ],
    ),
  );
}

// =============================================================================
// SECTION 14 — Recap / TL;DR
// =============================================================================

Widget _section14Recap() {
  Widget bullet(String t) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('•  ', style: _kBody),
          Expanded(child: Text(t, style: _kBody)),
        ],
      ),
    );
  }

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(16.0),
    decoration: _panelDecoration(color: _kAccentSoft, border: _kAccent),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('14. Recap — TL;DR cheat sheet', style: _kSubtitle),
        const SizedBox(height: 8.0),
        bullet('Column = Flex with Axis.vertical. No scroll, no wrap, no '
            'sizing magic.'),
        bullet('mainAxisAlignment distributes vertical free space. Has no '
            'effect when mainAxisSize is min.'),
        bullet('crossAxisAlignment positions each child horizontally. stretch '
            'overrides child widths.'),
        bullet('mainAxisSize: max fills parent height. min hugs children. '
            'Default is max. Use min inside scroll views.'),
        bullet('verticalDirection.up reverses what "start" means on the main '
            'axis without reversing the children list.'),
        bullet('CrossAxisAlignment.baseline REQUIRES textBaseline. Otherwise '
            'asserts.'),
        bullet('Expanded and Spacer eat leftover main-axis space proportionally '
            'to flex. They require bounded main-axis constraints.'),
        bullet('When in doubt, wrap your Column in a fixed-height SizedBox to '
            'remove ambiguity.'),
        bullet('For long scrolling content, prefer ListView over Column + '
            'SingleChildScrollView.'),
        bullet('Bordered Container wrappers (like in this file) are a great '
            'debugging tool for flex layout boundaries.'),
      ],
    ),
  );
}

// =============================================================================
// Top-level build entry point
// =============================================================================
//
// The toolchain calls this once. We return a single Widget that contains every
// section as a vertical stack inside a SingleChildScrollView, so the demo can
// be navigated as a long scrollable page.

dynamic build(BuildContext context) {
  if (kDebugMode) {
    // foundation import is *used* here so unnecessary_import does not bark.
    debugPrint('Column visual deep demo build()');
  }

  final Widget content = Container(
    color: const Color(0xFFE2E8F0),
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _sectionBanner(
          'Column — Visual Deep Demo',
          'Every alignment / sizing / direction combination, hand-authored.',
        ),
        _section1Dossier(),
        _section2Anatomy(),
        _sectionBanner('MainAxisAlignment matrix', '6 alignments × 4 child counts'),
        _section3MainAxisMatrix(),
        _sectionBanner('CrossAxisAlignment matrix', '5 alignments × 3 child width patterns'),
        _section4CrossAxisMatrix(),
        _sectionBanner('Sizing & direction', 'MainAxisSize + VerticalDirection + TextDirection'),
        _section5MainAxisSize(),
        _section6VerticalDirection(),
        _section7TextBaseline(),
        _section8TextDirection(),
        _sectionBanner('Recipes', 'Real-world Column patterns'),
        _section9Recipes(),
        _sectionBanner('Flex children', 'Spacer / Expanded inside a Column'),
        _section10SpacerExpanded(),
        _sectionBanner('Pitfalls & comparisons', 'What to avoid; what to use instead'),
        _section11Pitfalls(),
        _section12Comparison(),
        _sectionBanner('Reference', 'Glossary and recap'),
        _section13Glossary(),
        _section14Recap(),
        const SizedBox(height: 32.0),
        const Center(
          child: Text(
            '— end of Column visual deep demo —',
            style: _kCaption,
          ),
        ),
        const SizedBox(height: 32.0),
      ],
    ),
  );

  return SingleChildScrollView(
    child: content,
  );
}
