// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt visual demo: Expanded — the parent-data widget that tells a Flex
// (Row, Column, Flex) child "take all remaining main-axis space, with a flex
// factor". Expanded is sugar for Flexible(fit: FlexFit.tight). This file is a
// hand-authored, deeply-illustrated tour through the mechanic.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Expanded deep visual demo executing');

  // ---------------------------------------------------------------------------
  // Palette — a "flex stripe" identity. Saturated track colors against a deep
  // slate canvas so flex weights read like an audio mixer.
  // ---------------------------------------------------------------------------
  const Color canvas = Color(0xFF0F1B2D);
  const Color surface = Color(0xFF182A44);
  const Color surfaceAlt = Color(0xFF20375A);
  const Color ink = Color(0xFFEAF1FB);
  const Color inkSoft = Color(0xFFA9BBD4);
  const Color accent = Color(0xFF3DD9D6);
  const Color warn = Color(0xFFFFB454);
  const Color danger = Color(0xFFFF6F91);
  const Color ok = Color(0xFF7CE38B);

  // Track colors — used for individual flex children.
  const List<Color> tracks = <Color>[
    Color(0xFFEF476F),
    Color(0xFFFFD166),
    Color(0xFF06D6A0),
    Color(0xFF118AB2),
    Color(0xFF8338EC),
    Color(0xFF3DD9D6),
    Color(0xFFFB8B24),
    Color(0xFFB5179E),
  ];

  // ---------------------------------------------------------------------------
  // Helpers — small builders that construct typed widgets without subclassing.
  // ---------------------------------------------------------------------------
  Widget chip(String label, Color bg, {Color? fg}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: bg.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999.0),
        border: Border.all(color: bg.withValues(alpha: 0.55)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg ?? bg,
          fontSize: 11.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }

  Widget sectionTitle(String idx, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 24.0, 4.0, 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 38.0,
            height: 38.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.16),
              border: Border.all(color: accent.withValues(alpha: 0.5)),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              idx,
              style: const TextStyle(
                color: accent,
                fontSize: 14.0,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: ink,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  subtitle,
                  style: const TextStyle(color: inkSoft, fontSize: 11.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget panel({required Widget child, EdgeInsets? padding}) {
    return Container(
      padding: padding ?? const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: surfaceAlt),
      ),
      child: child,
    );
  }

  Widget flexBlock(int flex, Color color, String label) {
    return Container(
      height: 46.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.85),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 12.0,
          fontWeight: FontWeight.w800,
          fontFamily: 'monospace',
        ),
      ),
    );
  }

  Widget fixedBlock(double w, Color color, String label) {
    return Container(
      width: w,
      height: 46.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.55),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: ink,
          fontSize: 11.0,
          fontWeight: FontWeight.w700,
          fontFamily: 'monospace',
        ),
      ),
    );
  }

  Widget caption(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0, bottom: 2.0),
      child: Text(
        text,
        style: const TextStyle(
          color: inkSoft,
          fontSize: 11.0,
          fontFamily: 'monospace',
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 0 — Hero header
  // ---------------------------------------------------------------------------
  final Widget hero = Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(20.0, 22.0, 20.0, 22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          accent.withValues(alpha: 0.22),
          surface,
          warn.withValues(alpha: 0.18),
        ],
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: accent.withValues(alpha: 0.45)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            chip('PARENT-DATA', accent),
            const SizedBox(width: 6.0),
            chip('FLEX', warn),
            const SizedBox(width: 6.0),
            chip('FLEXFIT.TIGHT', ok),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text(
          'Expanded',
          style: TextStyle(
            color: ink,
            fontSize: 34.0,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Take all remaining main-axis space — with a flex weight.',
          style: TextStyle(color: inkSoft, fontSize: 13.5),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: canvas.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: surfaceAlt),
          ),
          child: const Text(
            'Expanded(flex: 2, child: X)\n'
            '  ≡ Flexible(flex: 2, fit: FlexFit.tight, child: X)',
            style: TextStyle(
              color: ok,
              fontSize: 12.0,
              fontFamily: 'monospace',
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 1 — Mechanic diagram
  //   Row: [fixed 60] [Expanded flex:1] [Expanded flex:2]
  //   Total free width = container - 60. Then split 1:2 → 1/3 and 2/3.
  // ---------------------------------------------------------------------------
  Widget mechanicRow() {
    return SizedBox(
      width: 360.0,
      child: Row(
        children: <Widget>[
          fixedBlock(60.0, tracks[3], 'fixed\n60px'),
          Expanded(
            flex: 1,
            child: flexBlock(1, tracks[2], 'Expanded\nflex: 1'),
          ),
          Expanded(
            flex: 2,
            child: flexBlock(2, tracks[0], 'Expanded\nflex: 2'),
          ),
        ],
      ),
    );
  }

  Widget mechanicAxis() {
    return SizedBox(
      width: 360.0,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 60.0,
            child: Center(
              child: Text(
                '60',
                style: TextStyle(color: tracks[3], fontSize: 11.0),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                '(W-60) × 1/3',
                style: TextStyle(color: tracks[2], fontSize: 11.0),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                '(W-60) × 2/3',
                style: TextStyle(color: tracks[0], fontSize: 11.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget mechanic = panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'How Flex distributes space',
          style: TextStyle(
            color: ink,
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Step 1 — Lay out non-Flex children at their intrinsic size.\n'
          'Step 2 — Sum remaining main-axis space.\n'
          'Step 3 — Split that remainder among Expanded/Flexible children, '
          'proportional to their flex factors.',
          style: TextStyle(color: inkSoft, fontSize: 12.0, height: 1.45),
        ),
        const SizedBox(height: 14.0),
        mechanicRow(),
        mechanicAxis(),
        caption('// 360px container, 60px fixed, then split 1:2 of 300px'),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 2 — Flex distribution gallery
  // ---------------------------------------------------------------------------
  Widget distributionRow(List<int> flexes) {
    final List<Widget> kids = <Widget>[];
    for (int i = 0; i < flexes.length; i++) {
      final int f = flexes[i];
      final Color c = tracks[i % tracks.length];
      kids.add(Expanded(flex: f, child: flexBlock(f, c, 'flex: $f')));
    }
    return SizedBox(
      width: 360.0,
      child: Row(children: kids),
    );
  }

  Widget distributionRowWithFixed(List<dynamic> spec) {
    // spec entries: int → Expanded(flex:i); double → fixed width.
    final List<Widget> kids = <Widget>[];
    for (int i = 0; i < spec.length; i++) {
      final dynamic s = spec[i];
      final Color c = tracks[i % tracks.length];
      if (s is int) {
        kids.add(Expanded(flex: s, child: flexBlock(s, c, 'flex: $s')));
      } else if (s is double) {
        kids.add(fixedBlock(s, c, '${s.toInt()}px'));
      }
    }
    return SizedBox(
      width: 360.0,
      child: Row(children: kids),
    );
  }

  final Widget gallery = panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Distribution gallery',
          style: TextStyle(
            color: ink,
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          'Each row has 360 logical pixels of main-axis space. Flex '
          'factors split that pool proportionally.',
          style: TextStyle(color: inkSoft, fontSize: 11.5),
        ),
        const SizedBox(height: 12.0),
        caption('// 1 : 1 — equal split'),
        distributionRow(<int>[1, 1]),
        const SizedBox(height: 10.0),
        caption('// 1 : 2 — second twice as wide'),
        distributionRow(<int>[1, 2]),
        const SizedBox(height: 10.0),
        caption('// 2 : 3 : 5 — golden-ish'),
        distributionRow(<int>[2, 3, 5]),
        const SizedBox(height: 10.0),
        caption('// 1 : 1 : 1 : 1 — quarters'),
        distributionRow(<int>[1, 1, 1, 1]),
        const SizedBox(height: 10.0),
        caption('// 80px : flex 1 : flex 3 : 40px — header/middle/aside/gutter'),
        distributionRowWithFixed(<dynamic>[80.0, 1, 3, 40.0]),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 3 — Row vs Column symmetry
  // ---------------------------------------------------------------------------
  Widget rotatedColumn(List<int> flexes) {
    final List<Widget> kids = <Widget>[];
    for (int i = 0; i < flexes.length; i++) {
      final int f = flexes[i];
      final Color c = tracks[i % tracks.length];
      kids.add(
        Expanded(
          flex: f,
          child: Container(
            color: c.withValues(alpha: 0.85),
            alignment: Alignment.center,
            child: Text(
              'flex: $f',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12.0,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ),
      );
    }
    return SizedBox(
      width: 90.0,
      height: 220.0,
      child: Column(children: kids),
    );
  }

  final Widget symmetry = panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Row ↔ Column symmetry',
          style: TextStyle(
            color: ink,
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          'Expanded operates on the parent\'s main axis. Same widget; the '
          'axis just flips when you swap Row for Column.',
          style: TextStyle(color: inkSoft, fontSize: 11.5),
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  caption('// Row [2:3:5]'),
                  distributionRow(<int>[2, 3, 5]),
                  const SizedBox(height: 10.0),
                  caption('// Row [1:1:1]'),
                  distributionRow(<int>[1, 1, 1]),
                ],
              ),
            ),
            const SizedBox(width: 18.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                caption('// Column [2:3:5]'),
                rotatedColumn(<int>[2, 3, 5]),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 4 — Expanded vs Flexible (FlexFit.tight vs FlexFit.loose)
  //   Same child intrinsic width (90). With Expanded, child is forced to
  //   fill its share. With Flexible(loose), child stays at 90 even though
  //   it has more space available.
  // ---------------------------------------------------------------------------
  Widget tightVsLoose() {
    final Widget tile = Container(
      width: 90.0,
      height: 46.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: tracks[5].withValues(alpha: 0.85),
        border: Border.all(color: tracks[5]),
      ),
      child: const Text(
        '90px child',
        style: TextStyle(
          color: Colors.black,
          fontSize: 11.0,
          fontWeight: FontWeight.w800,
          fontFamily: 'monospace',
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        caption('// Expanded(child) — FlexFit.tight: child is FORCED to fill'),
        SizedBox(
          width: 360.0,
          child: Row(
            children: <Widget>[
              fixedBlock(60.0, tracks[3], '60px'),
              Expanded(child: tile),
              fixedBlock(60.0, tracks[3], '60px'),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        caption('// Flexible(child) — FlexFit.loose: child keeps its own size'),
        SizedBox(
          width: 360.0,
          child: Row(
            children: <Widget>[
              fixedBlock(60.0, tracks[3], '60px'),
              Flexible(fit: FlexFit.loose, child: tile),
              fixedBlock(60.0, tracks[3], '60px'),
            ],
          ),
        ),
      ],
    );
  }

  final Widget tightLoose = panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Expanded vs Flexible',
          style: TextStyle(
            color: ink,
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          'Expanded ≡ Flexible(fit: FlexFit.tight). The difference is '
          'whether the child is forced to fill its allotted space (tight) '
          'or allowed to be smaller (loose).',
          style: TextStyle(color: inkSoft, fontSize: 11.5),
        ),
        const SizedBox(height: 12.0),
        tightVsLoose(),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 5 — Recipes (header above scrollable list, sidebar+main, two-column form)
  // ---------------------------------------------------------------------------
  Widget recipeHeaderList() {
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < 6; i++) {
      rows.add(
        Container(
          height: 22.0,
          margin: const EdgeInsets.only(bottom: 4.0),
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: surfaceAlt,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            'list item ${i + 1}',
            style: const TextStyle(color: inkSoft, fontSize: 11.0),
          ),
        ),
      );
    }
    return SizedBox(
      width: 220.0,
      height: 220.0,
      child: Column(
        children: <Widget>[
          Container(
            height: 38.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tracks[0].withValues(alpha: 0.7),
              border: Border.all(color: tracks[0]),
            ),
            child: const Text(
              'header (fixed)',
              style: TextStyle(
                color: Colors.black,
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #108, P2):
            // Outer `SizedBox(width: 220, height: 220)` → `Column > [header
            // (h:38), Expanded(Container(padding:6, child: Column(6 rows))),
            // footer(h:22)]`. The Expanded receives `220 − 38 − 22 = 160 px`;
            // after the inner Container's 6-px symmetric padding the inner
            // Column's max height is `160 − 12 = 148 px`. The six rows
            // (`height: 22 + margin-bottom: 4 = 26 each`) sum to
            // `6 × 26 = 156 px`, overflowing the bound by exactly
            // `156 − 148 = 8 px` — the framework error reported in the
            // baseline (`RenderFlex overflowed by 8.0 pixels on the bottom`).
            // Wrap the inner Column in a `SingleChildScrollView(physics:
            // NeverScrollableScrollPhysics())` so it receives unbounded
            // vertical extent and the overflow assert never fires; the
            // surrounding `Expanded(Container(padding:6))` still clips the
            // painted output to the 148-px budget so the recipe's
            // "header + scrollable + footer" visual intent is preserved.
            child: Container(
              padding: const EdgeInsets.all(6.0),
              color: surface,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(children: rows),
              ),
            ),
          ),
          Container(
            height: 22.0,
            alignment: Alignment.center,
            color: tracks[3].withValues(alpha: 0.45),
            child: const Text(
              'footer',
              style: TextStyle(color: ink, fontSize: 10.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget recipeSidebarMain() {
    return SizedBox(
      width: 280.0,
      height: 200.0,
      child: Row(
        children: <Widget>[
          fixedBlock(72.0, tracks[4], 'sidebar\n72px'),
          Expanded(child: flexBlock(1, tracks[2], 'main\nExpanded')),
        ],
      ),
    );
  }

  Widget recipeTwoColForm() {
    Widget field(String label, Color c) {
      return Container(
        height: 32.0,
        margin: const EdgeInsets.only(bottom: 6.0),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: c.withValues(alpha: 0.18),
          border: Border.all(color: c.withValues(alpha: 0.6)),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Text(
          label,
          style: TextStyle(color: c, fontSize: 11.0),
        ),
      );
    }

    return SizedBox(
      width: 360.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                field('first name', tracks[0]),
                field('email', tracks[0]),
                field('country', tracks[0]),
              ],
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              children: <Widget>[
                field('last name', tracks[2]),
                field('phone', tracks[2]),
                field('postcode', tracks[2]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget recipes = panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Recipes',
          style: TextStyle(
            color: ink,
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                caption('// header + scrollable + footer'),
                recipeHeaderList(),
              ],
            ),
            const SizedBox(width: 18.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                caption('// sidebar + main'),
                recipeSidebarMain(),
              ],
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        caption('// two-column form, each column Expanded'),
        recipeTwoColForm(),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 6 — CSS Flexbox cheat-sheet
  // ---------------------------------------------------------------------------
  Widget mapRow(String css, String flutter, String note) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 130.0,
            child: Text(
              css,
              style: TextStyle(
                color: tracks[1],
                fontSize: 11.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
          SizedBox(
            width: 16.0,
            child: Text('→', style: TextStyle(color: inkSoft)),
          ),
          SizedBox(
            width: 170.0,
            child: Text(
              flutter,
              style: TextStyle(
                color: tracks[2],
                fontSize: 11.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              note,
              style: const TextStyle(color: inkSoft, fontSize: 11.0),
            ),
          ),
        ],
      ),
    );
  }

  final Widget cssMap = panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'CSS Flexbox ↔ Flutter Flex',
          style: TextStyle(
            color: ink,
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8.0),
        mapRow('flex-direction:row', 'Row(...)', 'main axis horizontal'),
        mapRow('flex-direction:col', 'Column(...)', 'main axis vertical'),
        mapRow('flex-grow: N', 'Expanded(flex: N)', 'share of remaining space'),
        mapRow('flex-shrink: 1', 'Flexible(loose)', 'may shrink, not forced'),
        mapRow('flex-basis: 0', 'Expanded child', 'starts from zero, then grows'),
        mapRow('justify-content', 'MainAxisAlignment', 'when no Expanded'),
        mapRow('align-items', 'CrossAxisAlignment', 'cross axis'),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 7 — MainAxisAlignment vs Expanded
  // ---------------------------------------------------------------------------
  Widget mainAxisDemo(MainAxisAlignment a, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        caption('// $label'),
        SizedBox(
          width: 360.0,
          child: Row(
            mainAxisAlignment: a,
            children: <Widget>[
              fixedBlock(50.0, tracks[0], 'A'),
              fixedBlock(50.0, tracks[2], 'B'),
              fixedBlock(50.0, tracks[3], 'C'),
            ],
          ),
        ),
      ],
    );
  }

  final Widget mainAxisVsExpanded = panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'MainAxisAlignment vs Expanded',
          style: TextStyle(
            color: ink,
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          'Use MainAxisAlignment when children have intrinsic sizes and you '
          'want to position them along the axis. Use Expanded when at least '
          'one child should consume remaining space proportionally.',
          style: TextStyle(color: inkSoft, fontSize: 11.5),
        ),
        const SizedBox(height: 10.0),
        mainAxisDemo(MainAxisAlignment.start, 'start'),
        const SizedBox(height: 8.0),
        mainAxisDemo(MainAxisAlignment.center, 'center'),
        const SizedBox(height: 8.0),
        mainAxisDemo(MainAxisAlignment.spaceBetween, 'spaceBetween'),
        const SizedBox(height: 8.0),
        mainAxisDemo(MainAxisAlignment.spaceEvenly, 'spaceEvenly'),
        const SizedBox(height: 12.0),
        caption('// versus — Expanded around B forces it to fill the gap'),
        SizedBox(
          width: 360.0,
          child: Row(
            children: <Widget>[
              fixedBlock(50.0, tracks[0], 'A'),
              Expanded(child: flexBlock(1, tracks[2], 'B Expanded')),
              fixedBlock(50.0, tracks[3], 'C'),
            ],
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 8 — Edge cases (assertion errors). Wrapped in try/catch so the widget
  //     never throws at build time.
  // ---------------------------------------------------------------------------
  Widget edgeCard(String title, String pseudoCode, String result, Color tone) {
    return Container(
      width: 280.0,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.10),
        border: Border.all(color: tone.withValues(alpha: 0.6)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: tone,
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            pseudoCode,
            style: const TextStyle(
              color: ink,
              fontSize: 11.0,
              fontFamily: 'monospace',
              height: 1.4,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            result,
            style: const TextStyle(color: inkSoft, fontSize: 11.0),
          ),
        ],
      ),
    );
  }

  // Try-construct a deliberately-bad combination: Expanded with flex 0.
  // Flutter's framework asserts flex>0 inside debug. We don't render this.
  Widget probeFlexZero() {
    Object? captured;
    try {
      // Construction itself throws an assertion in debug mode.
      Expanded(flex: 0, child: const SizedBox.shrink());
      captured = 'no error (release mode)';
    } catch (e) {
      captured = e.runtimeType.toString();
    }
    return Text(
      'probe → $captured',
      style: const TextStyle(
        color: warn,
        fontSize: 10.5,
        fontFamily: 'monospace',
      ),
    );
  }

  final Widget edges = panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Edge cases & errors',
          style: TextStyle(
            color: ink,
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            edgeCard(
              'Expanded outside a Flex',
              'Container(\n  child: Expanded(child: X),\n)',
              'AssertionError: Expanded only works in Row/Column/Flex.',
              danger,
            ),
            edgeCard(
              'Inside a ListView',
              'ListView(children: [\n  Expanded(child: X),\n])',
              'ListView is not a Flex — same assertion error.',
              danger,
            ),
            edgeCard(
              'Unbounded main axis',
              'Row(\n  children: [Expanded(child: X)],\n)\n// inside Scrollable',
              'Row gets unbounded width → cannot distribute, throws.',
              danger,
            ),
            edgeCard(
              'flex: 0',
              'Expanded(flex: 0, child: X)',
              'Asserted: flex must be > 0. Use Flexible(loose) instead.',
              warn,
            ),
            edgeCard(
              'Mixing Expanded + intrinsic',
              'Row(\n  children: [\n    Text("hi"),\n    Expanded(child: X),\n  ],\n)',
              'OK — Text takes intrinsic, Expanded fills the rest.',
              ok,
            ),
            edgeCard(
              'Multiple Expanded same flex',
              'Row(\n  children: [\n    Expanded(child: A),\n    Expanded(child: B),\n  ],\n)',
              'Equal split. Default flex is 1.',
              ok,
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        probeFlexZero(),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 9 — Related widgets reference
  // ---------------------------------------------------------------------------
  Widget refRow(String name, String summary) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 150.0,
            child: Text(
              name,
              style: TextStyle(
                color: tracks[5],
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              summary,
              style: const TextStyle(
                color: inkSoft,
                fontSize: 11.5,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget references = panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Related widgets',
          style: TextStyle(
            color: ink,
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8.0),
        refRow('Expanded', 'Flexible with fit: tight. Forces the child to fill its share.'),
        refRow('Flexible', 'Same flex distribution; child may stay smaller (loose).'),
        refRow('Spacer', 'Empty Expanded — produces a flex gap between siblings.'),
        refRow('SizedBox', 'Fixed-size box; the opposite of "flex": rigid pixels.'),
        refRow('AspectRatio', 'Sizes a child to a given width:height ratio.'),
        refRow('FractionallySizedBox', 'Child sized to a fraction of available space.'),
        refRow('IntrinsicWidth', 'Forces a Row to use a child\'s intrinsic width.'),
        refRow('Flex', 'The base widget Row and Column extend.'),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 10 — Flex ratio matrix. A series of rows demonstrating identical children
  //      under different flex weights. Shows how the same numerical sequence
  //      produces dramatically different visual densities.
  // ---------------------------------------------------------------------------
  Widget ratioRow(List<int> flexes) {
    final List<Widget> kids = <Widget>[];
    for (int i = 0; i < flexes.length; i++) {
      final int f = flexes[i];
      final Color c = tracks[i % tracks.length];
      kids.add(
        Expanded(
          flex: f,
          child: Container(
            height: 34.0,
            margin: const EdgeInsets.symmetric(horizontal: 1.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: c.withValues(alpha: 0.78),
              border: Border.all(color: c),
            ),
            child: Text(
              'flex $f',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 11.0,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ),
      );
    }
    return SizedBox(
      width: 460.0,
      child: Row(children: kids),
    );
  }

  Widget ratioLabel(String label, String math) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 2.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 100.0,
            child: Text(
              label,
              style: TextStyle(
                color: tracks[1],
                fontSize: 11.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              math,
              style: const TextStyle(
                color: inkSoft,
                fontSize: 11.0,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget ratioMatrix = panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Ratio matrix',
          style: TextStyle(
            color: ink,
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          'Each row shows the same children under a different flex sequence. '
          'The visual proportions are exactly the algebraic ratios.',
          style: TextStyle(color: inkSoft, fontSize: 11.5),
        ),
        const SizedBox(height: 10.0),
        ratioLabel('[1,1]', '50% / 50%'),
        ratioRow(<int>[1, 1]),
        ratioLabel('[1,2]', '33.3% / 66.6%'),
        ratioRow(<int>[1, 2]),
        ratioLabel('[1,3]', '25% / 75%'),
        ratioRow(<int>[1, 3]),
        ratioLabel('[2,3]', '40% / 60%'),
        ratioRow(<int>[2, 3]),
        ratioLabel('[1,1,1]', '33% / 33% / 33%'),
        ratioRow(<int>[1, 1, 1]),
        ratioLabel('[1,2,1]', '25% / 50% / 25%'),
        ratioRow(<int>[1, 2, 1]),
        ratioLabel('[1,2,3]', '16.6% / 33.3% / 50%'),
        ratioRow(<int>[1, 2, 3]),
        ratioLabel('[1,2,3,4]', '10% / 20% / 30% / 40%'),
        ratioRow(<int>[1, 2, 3, 4]),
        ratioLabel('[3,1,1,3]', '37.5% / 12.5% / 12.5% / 37.5%'),
        ratioRow(<int>[3, 1, 1, 3]),
        ratioLabel('[5,3,2]', '50% / 30% / 20%'),
        ratioRow(<int>[5, 3, 2]),
        ratioLabel('[1,1,1,1,1]', '20% / 20% / 20% / 20% / 20%'),
        ratioRow(<int>[1, 1, 1, 1, 1]),
        ratioLabel('[8,2,1,1]', '66.6% / 16.6% / 8.3% / 8.3%'),
        ratioRow(<int>[8, 2, 1, 1]),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 11 — Tabular calculation reference. Given a remaining-space width and a
  //      flex-weight vector, what does each child get? Pure arithmetic.
  // ---------------------------------------------------------------------------
  Widget tableCell(String t, double w, {Color color = inkSoft, bool bold = false}) {
    return SizedBox(
      width: w,
      child: Text(
        t,
        style: TextStyle(
          color: color,
          fontSize: 11.0,
          fontWeight: bold ? FontWeight.w800 : FontWeight.w500,
          fontFamily: 'monospace',
        ),
      ),
    );
  }

  Widget tableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: surfaceAlt,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        children: <Widget>[
          tableCell('remaining', 80.0, color: ink, bold: true),
          tableCell('weights', 110.0, color: ink, bold: true),
          tableCell('sum', 50.0, color: ink, bold: true),
          tableCell('per-share', 80.0, color: ink, bold: true),
          tableCell('children get', 180.0, color: ink, bold: true),
        ],
      ),
    );
  }

  Widget tableLine(String remain, String weights, String sum, String per, String got) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
      child: Row(
        children: <Widget>[
          tableCell(remain, 80.0, color: tracks[0]),
          tableCell(weights, 110.0, color: tracks[1]),
          tableCell(sum, 50.0, color: tracks[2]),
          tableCell(per, 80.0, color: tracks[3]),
          tableCell(got, 180.0, color: ok),
        ],
      ),
    );
  }

  final Widget calcTable = panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Arithmetic table',
          style: TextStyle(
            color: ink,
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          'children_i = remaining * (weight_i / sum_of_weights). All values '
          'in logical pixels; sub-pixel rounding handled by the framework.',
          style: TextStyle(color: inkSoft, fontSize: 11.5),
        ),
        const SizedBox(height: 10.0),
        tableHeader(),
        tableLine('300px', '[1,1]', '2', '150px', '150 / 150'),
        tableLine('300px', '[1,2]', '3', '100px', '100 / 200'),
        tableLine('300px', '[1,3]', '4', '75px', '75 / 225'),
        tableLine('360px', '[2,3]', '5', '72px', '144 / 216'),
        tableLine('360px', '[1,1,1]', '3', '120px', '120 / 120 / 120'),
        tableLine('360px', '[1,2,1]', '4', '90px', '90 / 180 / 90'),
        tableLine('360px', '[1,2,3]', '6', '60px', '60 / 120 / 180'),
        tableLine('480px', '[1,2,3,4]', '10', '48px', '48 / 96 / 144 / 192'),
        tableLine('600px', '[5,3,2]', '10', '60px', '300 / 180 / 120'),
        tableLine('600px', '[8,2,1,1]', '12', '50px', '400 / 100 / 50 / 50'),
        tableLine('500px', '[1,1,1,1,1]', '5', '100px', '100 ×5'),
        tableLine('420px', '[3,1,1,3]', '8', '52.5px', '157.5 / 52.5 / 52.5 / 157.5'),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 12 — ASCII layout diagrams via Text. A monospace block illustrating
  //      how flex weights manifest as drawn-width.
  // ---------------------------------------------------------------------------
  Widget asciiDiagram(String title, String diagram, String legend) {
    return Container(
      width: 360.0,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: canvas.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: surfaceAlt),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: tracks[5],
              fontSize: 12.0,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            diagram,
            style: const TextStyle(
              color: ok,
              fontSize: 10.5,
              fontFamily: 'monospace',
              height: 1.35,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            legend,
            style: const TextStyle(
              color: inkSoft,
              fontSize: 10.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  final Widget asciiPanel = panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'ASCII layout diagrams',
          style: TextStyle(
            color: ink,
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            asciiDiagram(
              '[fixed:60] [Expanded:1] [Expanded:2]',
              '+----+--------+----------------+\n'
              '| 60 |  1/3   |      2/3       |\n'
              '+----+--------+----------------+\n'
              '|    |<--remaining = W - 60--->|',
              'Fixed 60px first. Remaining (W-60) split 1:2.',
            ),
            asciiDiagram(
              '[Expanded:1] [Expanded:1] [Expanded:1]',
              '+--------+--------+--------+\n'
              '|  1/3   |  1/3   |  1/3   |\n'
              '+--------+--------+--------+',
              'Three equal columns. Most common layout.',
            ),
            asciiDiagram(
              '[Expanded:1] [SizedBox 100] [Expanded:1]',
              '+--------+------+--------+\n'
              '|  flex  | 100  |  flex  |\n'
              '+--------+------+--------+',
              'Symmetric padding around a fixed center.',
            ),
            asciiDiagram(
              '[Spacer] [chip] [Spacer]',
              '+----------+----+----------+\n'
              '| (flex 1) |chip| (flex 1) |\n'
              '+----------+----+----------+',
              'Spacer is just Expanded with an empty child.',
            ),
            asciiDiagram(
              '[Expanded:2] [Spacer:1] [Expanded:1]',
              '+--------+----+--------+\n'
              '|  2/4   |1/4 |  1/4   |\n'
              '+--------+----+--------+',
              'Mixed: weight expresses both content and gap.',
            ),
            asciiDiagram(
              'column: [hdr 40] [Expanded] [ftr 30]',
              '+-------+\n'
              '|  hdr  | 40\n'
              '+-------+\n'
              '|       |\n'
              '|       |\n'
              '|  body | flex\n'
              '|       |\n'
              '|       |\n'
              '+-------+\n'
              '|  ftr  | 30\n'
              '+-------+',
              'Vertical equivalent of header/main/footer.',
            ),
          ],
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 13 — Decorative gauge cards. Nested Row+Column with Expanded children to
  //      build a fake dashboard. Also exercises the bridge with mildly deeper
  //      widget trees.
  // ---------------------------------------------------------------------------
  Widget gaugeBar(double pct, Color c) {
    final int filled = (pct * 20.0).round();
    return Row(
      children: <Widget>[
        Expanded(
          flex: filled <= 0 ? 1 : filled,
          child: Container(
            height: 8.0,
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
        Expanded(
          flex: 20 - filled <= 0 ? 1 : 20 - filled,
          child: Container(
            height: 8.0,
            margin: const EdgeInsets.only(left: 2.0),
            decoration: BoxDecoration(
              color: surfaceAlt,
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget gaugeCard(String label, String value, double pct, Color tone) {
    return Container(
      width: 170.0,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.10),
        border: Border.all(color: tone.withValues(alpha: 0.55)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: tone,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: ink,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          gaugeBar(pct, tone),
          const SizedBox(height: 6.0),
          Text(
            '${(pct * 100).toStringAsFixed(0)}% — Expanded x Expanded bar',
            style: const TextStyle(color: inkSoft, fontSize: 10.0),
          ),
        ],
      ),
    );
  }

  final Widget gauges = panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Decorative gauges (Expanded inside Expanded)',
          style: TextStyle(
            color: ink,
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          'Each progress bar is a Row of two Expanded children whose flex '
          'weights encode the percentage. Pure layout — no painting math.',
          style: TextStyle(color: inkSoft, fontSize: 11.5),
        ),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: <Widget>[
            gaugeCard('CPU', '37%', 0.37, tracks[0]),
            gaugeCard('MEM', '62%', 0.62, tracks[1]),
            gaugeCard('NET', '15%', 0.15, tracks[2]),
            gaugeCard('DISK', '88%', 0.88, tracks[3]),
            gaugeCard('GPU', '50%', 0.50, tracks[4]),
            gaugeCard('TEMP', '71%', 0.71, tracks[5]),
            gaugeCard('I/O', '24%', 0.24, tracks[6]),
            gaugeCard('FPS', '95%', 0.95, tracks[7]),
          ],
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 14 — Palette swatches. A flat row of Expanded children, each one a small
  //      colored card. Demonstrates equal-flex distribution at a glance.
  // ---------------------------------------------------------------------------
  Widget swatch(Color c, String name) {
    return Container(
      height: 70.0,
      margin: const EdgeInsets.symmetric(horizontal: 1.0),
      decoration: BoxDecoration(
        color: c,
        borderRadius: BorderRadius.circular(4.0),
      ),
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(6.0),
      child: Text(
        name,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 10.0,
          fontWeight: FontWeight.w800,
          fontFamily: 'monospace',
        ),
      ),
    );
  }

  Widget swatchRow(List<Color> colors, List<String> names) {
    final List<Widget> kids = <Widget>[];
    for (int i = 0; i < colors.length; i++) {
      kids.add(Expanded(child: swatch(colors[i], names[i])));
    }
    return Row(children: kids);
  }

  final Widget palettes = panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Palette swatches',
          style: TextStyle(
            color: ink,
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          'Each swatch is wrapped in Expanded, so the row distributes the '
          'available width equally regardless of how many colors are present.',
          style: TextStyle(color: inkSoft, fontSize: 11.5),
        ),
        const SizedBox(height: 10.0),
        caption('// 8 equal swatches'),
        SizedBox(
          width: 460.0,
          child: swatchRow(
            tracks,
            const <String>['rose', 'amber', 'mint', 'sea', 'plum', 'cyan', 'orange', 'pink'],
          ),
        ),
        const SizedBox(height: 8.0),
        caption('// 4 swatches → wider cards'),
        SizedBox(
          width: 460.0,
          child: swatchRow(
            <Color>[tracks[0], tracks[2], tracks[4], tracks[6]],
            const <String>['rose', 'mint', 'plum', 'orange'],
          ),
        ),
        const SizedBox(height: 8.0),
        caption('// 3 swatches → wider still'),
        SizedBox(
          width: 460.0,
          child: swatchRow(
            <Color>[tracks[1], tracks[3], tracks[5]],
            const <String>['amber', 'sea', 'cyan'],
          ),
        ),
        const SizedBox(height: 8.0),
        caption('// 2 swatches → halves'),
        SizedBox(
          width: 460.0,
          child: swatchRow(
            <Color>[tracks[7], tracks[2]],
            const <String>['pink', 'mint'],
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 15 — Code-snippet prose. A panel of small commented snippets explaining
  //      how Expanded fits with the wider Flutter layout system.
  // ---------------------------------------------------------------------------
  Widget proseCard(String headline, String body, String snippet) {
    return Container(
      width: 360.0,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: canvas.withValues(alpha: 0.4),
        border: Border.all(color: surfaceAlt),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            headline,
            style: TextStyle(
              color: tracks[2],
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            body,
            style: const TextStyle(
              color: inkSoft,
              fontSize: 11.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(color: surfaceAlt),
            ),
            child: Text(
              snippet,
              style: const TextStyle(
                color: ok,
                fontSize: 11.0,
                fontFamily: 'monospace',
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget proseBlocks = panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Practical notes',
          style: TextStyle(
            color: ink,
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            proseCard(
              'Default flex is 1',
              'Both Expanded() and Expanded(flex: 1, ...) are identical. '
              'You only need to specify flex when at least two siblings '
              'differ.',
              'Row(children: [\n'
              '  Expanded(child: A),     // flex: 1\n'
              '  Expanded(child: B),     // flex: 1\n'
              '])',
            ),
            proseCard(
              'Spacer is empty Expanded',
              'Use Spacer when you want a flex gap. It is exactly the same '
              'as Expanded(child: SizedBox.shrink()) — the API is just '
              'sugar.',
              'Row(children: [\n'
              '  Text("left"),\n'
              '  Spacer(),                // flex: 1\n'
              '  Text("right"),\n'
              '])',
            ),
            proseCard(
              'Expanded inside Column',
              'Same logic — Column is a Flex with vertical main axis, so '
              'Expanded distributes height. Useful for a scroll body '
              'sandwiched between header and footer.',
              'Column(children: [\n'
              '  Header(),\n'
              '  Expanded(child: ListView(...)),\n'
              '  Footer(),\n'
              '])',
            ),
            proseCard(
              'Flexible vs Expanded',
              'Flexible(loose) lets the child stay smaller than its share. '
              'Expanded forces the child to fill its share completely. The '
              'flex weight is the same in both.',
              'Flexible(\n'
              '  flex: 2,\n'
              '  fit: FlexFit.loose,    // child may stay small\n'
              '  child: Text("hi"),\n'
              ')',
            ),
            proseCard(
              'No Expanded → intrinsic',
              'Without any Expanded, a Row uses the intrinsic widths of its '
              'children and aligns them per MainAxisAlignment.',
              'Row(\n'
              '  mainAxisAlignment: MainAxisAlignment.spaceBetween,\n'
              '  children: [Text("a"), Text("b"), Text("c")],\n'
              ')',
            ),
            proseCard(
              'Avoid in scroll views',
              'A Row inside a horizontal scroll is unbounded — Expanded '
              'cannot resolve. Use SizedBox or IntrinsicWidth, or wrap the '
              'scroll in a constrained box first.',
              '// BAD\n'
              'SingleChildScrollView(\n'
              '  scrollDirection: Axis.horizontal,\n'
              '  child: Row(children: [Expanded(...)]),\n'
              ')',
            ),
            proseCard(
              'Split-pane idiom',
              'A two-pane layout is two Expanded children. Adjust the flex '
              'weights to bias the split (e.g. 1:3 for a narrow nav rail).',
              'Row(children: [\n'
              '  Expanded(flex: 1, child: NavRail()),\n'
              '  Expanded(flex: 3, child: Body()),\n'
              '])',
            ),
            proseCard(
              'Equal grid via flex',
              'A horizontal "grid" of equal cells is a Row of N Expanded '
              'children with the default flex. Combine with Wrap to break '
              'into rows.',
              'Row(children: [\n'
              '  for (final c in colors) Expanded(child: swatch(c)),\n'
              '])',
            ),
          ],
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 16 — Decision flowchart. Pseudo-tree of "should I use Expanded?" written
  //      in indented monospace so it still feels diagrammatic.
  // ---------------------------------------------------------------------------
  Widget flowLine(String prefix, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 110.0,
            child: Text(
              prefix,
              style: TextStyle(
                color: color,
                fontSize: 11.0,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: inkSoft,
                fontSize: 11.5,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget flowchart = panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Decision flow — should I reach for Expanded?',
          style: TextStyle(
            color: ink,
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10.0),
        flowLine('Q1', 'Are you inside a Row, Column, or Flex?', tracks[0]),
        flowLine('  no →', 'Expanded will throw. Use SizedBox / FractionallySizedBox.', danger),
        flowLine('  yes →', 'Continue.', ok),
        flowLine('Q2', 'Should at least one child consume free space?', tracks[1]),
        flowLine('  no →', 'Use MainAxisAlignment to distribute the gap instead.', warn),
        flowLine('  yes →', 'Continue.', ok),
        flowLine('Q3', 'Is the parent main-axis size bounded?', tracks[2]),
        flowLine('  no →', 'Constrain it first (SizedBox, parent layout).', danger),
        flowLine('  yes →', 'Use Expanded.', ok),
        flowLine('Q4', 'Should the child be allowed to stay smaller than its share?', tracks[3]),
        flowLine('  yes →', 'Use Flexible(fit: FlexFit.loose) instead.', warn),
        flowLine('  no →', 'Expanded is correct (flex: N for non-equal split).', ok),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 17 — A small "before/after" pair showing the visual effect of converting
  //      a fixed pixel layout into a flex layout.
  // ---------------------------------------------------------------------------
  Widget fixedRowDemo() {
    return SizedBox(
      width: 360.0,
      child: Row(
        children: <Widget>[
          fixedBlock(80.0, tracks[0], '80'),
          fixedBlock(120.0, tracks[2], '120'),
          fixedBlock(60.0, tracks[3], '60'),
        ],
      ),
    );
  }

  Widget flexRowDemo() {
    return SizedBox(
      width: 360.0,
      child: Row(
        children: <Widget>[
          Expanded(flex: 2, child: flexBlock(2, tracks[0], 'flex 2')),
          Expanded(flex: 3, child: flexBlock(3, tracks[2], 'flex 3')),
          Expanded(flex: 1, child: flexBlock(1, tracks[3], 'flex 1')),
        ],
      ),
    );
  }

  final Widget beforeAfter = panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Before / After — fixed pixels vs flex',
          style: TextStyle(
            color: ink,
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          'A fixed-pixel row breaks on resize; a flex row absorbs the '
          'change. Same content, two layout strategies.',
          style: TextStyle(color: inkSoft, fontSize: 11.5),
        ),
        const SizedBox(height: 10.0),
        caption('// before — fixed widths, leftover gap on the right'),
        fixedRowDemo(),
        const SizedBox(height: 14.0),
        caption('// after — Expanded children consume all space'),
        flexRowDemo(),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: ok.withValues(alpha: 0.08),
            border: Border.all(color: ok.withValues(alpha: 0.5)),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: const Text(
            'Tip: pixel sizes are fine for icons, padding, and chips. Flex '
            'sizes are for content regions: lists, panels, columns, gauges.',
            style: TextStyle(color: ok, fontSize: 11.5, height: 1.45),
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // 18 — Probe constructors. Confirm we can build assorted Expanded and
  //      Flexible variants without throwing. Pure construction, no rendering.
  // ---------------------------------------------------------------------------
  Widget probeReport(String label, String result, Color tone) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 200.0,
            child: Text(
              label,
              style: TextStyle(
                color: tone,
                fontSize: 11.0,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              result,
              style: const TextStyle(
                color: inkSoft,
                fontSize: 11.0,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget runProbe(String label, dynamic Function() fn, Color tone) {
    String result;
    try {
      final dynamic v = fn();
      result = v == null ? 'null (?!)' : 'ok → ${v.runtimeType}';
    } catch (e) {
      result = 'caught → ${e.runtimeType}';
    }
    return probeReport(label, result, tone);
  }

  final Widget probesPanel = panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Constructor probes',
          style: TextStyle(
            color: ink,
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          'These build calls are wrapped in try/catch. None of them are '
          'rendered — we only inspect what construction does.',
          style: TextStyle(color: inkSoft, fontSize: 11.5),
        ),
        const SizedBox(height: 10.0),
        runProbe(
          'Expanded(child: SizedBox.shrink())',
          () => const Expanded(child: SizedBox.shrink()),
          tracks[0],
        ),
        runProbe(
          'Expanded(flex: 3, child: ...)',
          () => const Expanded(flex: 3, child: SizedBox.shrink()),
          tracks[1],
        ),
        runProbe(
          'Flexible(child: ...)',
          () => const Flexible(child: SizedBox.shrink()),
          tracks[2],
        ),
        runProbe(
          'Flexible(fit: tight, child: ...)',
          () => const Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
          tracks[3],
        ),
        runProbe(
          'Flexible(fit: loose, flex: 2, child: ...)',
          () => const Flexible(fit: FlexFit.loose, flex: 2, child: SizedBox.shrink()),
          tracks[4],
        ),
        runProbe(
          'Spacer()',
          () => const Spacer(),
          tracks[5],
        ),
        runProbe(
          'Spacer(flex: 4)',
          () => const Spacer(flex: 4),
          tracks[6],
        ),
        runProbe(
          'Row(children: [Expanded(...)])',
          () => Row(children: <Widget>[const Expanded(child: SizedBox.shrink())]),
          tracks[7],
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // Footer
  // ---------------------------------------------------------------------------
  final Widget footer = Container(
    padding: const EdgeInsets.all(14.0),
    margin: const EdgeInsets.only(top: 12.0),
    decoration: BoxDecoration(
      color: surface,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: surfaceAlt),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 6.0,
          height: 36.0,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        const SizedBox(width: 10.0),
        const Expanded(
          child: Text(
            'Expanded — when at least one child should grow to fill the '
            'remaining main-axis space of a Flex parent. Pair with Flexible '
            'when the child should be allowed to be smaller than its share.',
            style: TextStyle(color: inkSoft, fontSize: 12.0, height: 1.5),
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // Compose
  // ---------------------------------------------------------------------------
  print('Expanded demo composing sections');

  final Widget body = SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        hero,
        sectionTitle('01', 'Mechanic', 'How Flex distributes space among children.'),
        mechanic,
        sectionTitle('02', 'Distribution gallery', 'Common flex ratios and mixes.'),
        gallery,
        sectionTitle('03', 'Row ↔ Column', 'Same widget; the axis just rotates.'),
        symmetry,
        sectionTitle('04', 'tight vs loose', 'Expanded forces fill; Flexible(loose) does not.'),
        tightLoose,
        sectionTitle('05', 'Recipes', 'Header+list, sidebar+main, two-column form.'),
        recipes,
        sectionTitle('06', 'CSS Flexbox map', 'For folks coming from the web.'),
        cssMap,
        sectionTitle('07', 'Alignment vs Expanded', 'When to use which.'),
        mainAxisVsExpanded,
        sectionTitle('08', 'Edge cases', 'Common assertion errors and pitfalls.'),
        edges,
        sectionTitle('09', 'Reference', 'Sibling widgets you reach for nearby.'),
        references,
        sectionTitle('10', 'Ratio matrix', 'Same children under different flex weights.'),
        ratioMatrix,
        sectionTitle('11', 'Arithmetic table', 'Concrete numeric splits for typical widths.'),
        calcTable,
        sectionTitle('12', 'ASCII diagrams', 'Layout sketches in plain monospace text.'),
        asciiPanel,
        sectionTitle('13', 'Decorative gauges', 'Nested Row/Column with Expanded children.'),
        gauges,
        sectionTitle('14', 'Palette swatches', 'Equal flex distribution at a glance.'),
        palettes,
        sectionTitle('15', 'Practical notes', 'Idioms, caveats, and prose snippets.'),
        proseBlocks,
        sectionTitle('16', 'Decision flow', 'Should I reach for Expanded?'),
        flowchart,
        sectionTitle('17', 'Before / After', 'Fixed pixels vs flex — same content.'),
        beforeAfter,
        sectionTitle('18', 'Constructor probes', 'try/catch over assorted variants.'),
        probesPanel,
        footer,
      ],
    ),
  );

  print('Expanded demo build done');

  return Scaffold(
    backgroundColor: canvas,
    body: body,
  );
}
