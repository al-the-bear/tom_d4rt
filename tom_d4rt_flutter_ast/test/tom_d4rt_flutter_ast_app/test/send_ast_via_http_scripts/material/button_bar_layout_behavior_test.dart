// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo - ButtonBarLayoutBehavior from material
// Comprehensive demonstration of ButtonBarLayoutBehavior.padded vs constrained
// across realistic dialog footers, action bars, settings panes, and themed
// button bars. Although the Flutter team has deprecated ButtonBar in favour of
// OverflowBar, the ButtonBarLayoutBehavior enum still ships from
// flutter/material.dart and this file exercises both code paths.

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ==========================================================================
  // PROLOGUE: a tiny debug summary so the harness logs something useful.
  // ==========================================================================
  print('=== ButtonBarLayoutBehavior Deep Demo ===');
  print('Total enum entries: ${ButtonBarLayoutBehavior.values.length}');
  for (final v in ButtonBarLayoutBehavior.values) {
    print('  - index=${v.index}  name=${v.name}');
  }
  print(
    'padded   keeps natural button widths and adds standardised padding.',
  );
  print(
    'constrained enforces a 64dp minimum width so tiny buttons line up tidily.',
  );

  // ==========================================================================
  // PALETTES — one tinted card per section so the reader can follow visually.
  // ==========================================================================
  const Color heroBg = Color(0xFFEDE7F6); // soft violet
  const Color heroAccent = Color(0xFF5E35B1); // deep violet
  const Color heroText = Color(0xFF1A1145);

  const Color sideBg = Color(0xFFE0F2F1); // pale teal
  const Color sideAccent = Color(0xFF00796B);
  const Color sideText = Color(0xFF003B36);

  const Color sweepBg = Color(0xFFFFF3E0); // pale amber
  const Color sweepAccent = Color(0xFFEF6C00);
  const Color sweepText = Color(0xFF4E2A00);

  const Color dialogBg = Color(0xFFE3F2FD); // pale blue
  const Color dialogAccent = Color(0xFF1565C0);
  const Color dialogText = Color(0xFF0B2545);

  const Color themeBg = Color(0xFFFCE4EC); // pale pink
  const Color themeAccent = Color(0xFFC2185B);
  const Color themeText = Color(0xFF50121F);

  const Color longBg = Color(0xFFF1F8E9); // pale lime
  const Color longAccent = Color(0xFF558B2F);
  const Color longText = Color(0xFF1F320A);

  const Color tableBg = Color(0xFFEDEDED); // neutral grey
  const Color tableAccent = Color(0xFF424242);
  const Color tableText = Color(0xFF1A1A1A);

  const Color galleryBg = Color(0xFFE8EAF6); // pale indigo
  const Color galleryAccent = Color(0xFF283593);
  const Color galleryText = Color(0xFF0A1248);

  // ==========================================================================
  // A small reusable trio of buttons so each scenario can show the same
  // children under both layout behaviours without duplicating code each time.
  // The buttons are intentionally `null` onPressed: this is a static demo and
  // we only care about layout.
  // ==========================================================================
  List<Widget> trio() {
    return const <Widget>[
      TextButton(onPressed: null, child: Text('Cancel')),
      OutlinedButton(onPressed: null, child: Text('Reset')),
      ElevatedButton(onPressed: null, child: Text('Save')),
    ];
  }

  // A deliberately tiny pair of buttons — these are the ones where the
  // `constrained` behaviour visibly changes layout (forces 64dp min width).
  List<Widget> tinyPair() {
    return const <Widget>[
      TextButton(onPressed: null, child: Text('No')),
      ElevatedButton(onPressed: null, child: Text('Yes')),
    ];
  }

  // A trio with one wide button that already exceeds the 64dp minimum, so
  // padded vs constrained look almost identical.
  List<Widget> mixedWide() {
    return const <Widget>[
      TextButton(onPressed: null, child: Text('Discard changes')),
      ElevatedButton(onPressed: null, child: Text('Keep editing')),
    ];
  }

  // ==========================================================================
  // SECTION 1 — HERO CARD: what is ButtonBarLayoutBehavior?
  // ==========================================================================
  final Widget section1Hero = Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: heroBg,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: heroAccent, width: 1.4),
    ),
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: heroAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: const Text(
                '1',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'ButtonBarLayoutBehavior — overview',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: heroText,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        const Text(
          'ButtonBarLayoutBehavior is a two-value enum used by ButtonBar (and '
          'historically by Material AlertDialog footers) to choose between '
          'two sizing strategies for the row of action buttons.',
          style: TextStyle(color: heroText, height: 1.4),
        ),
        const SizedBox(height: 10),
        const Text(
          '• padded     — buttons keep their natural intrinsic size and the '
          'bar adds the standard ButtonBar padding around the row.',
          style: TextStyle(color: heroText, height: 1.4),
        ),
        const Text(
          '• constrained — every child is forced to be at least 64dp wide so '
          'short labels (Yes / No / OK) line up neatly with longer ones.',
          style: TextStyle(color: heroText, height: 1.4),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: heroAccent.withOpacity(0.4)),
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline, color: heroAccent),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Although ButtonBar is deprecated in favour of OverflowBar, '
                  'ButtonBarLayoutBehavior is still exported by '
                  'flutter/material.dart and is read by the global '
                  'ButtonBarTheme. Index of values: '
                  '${ButtonBarLayoutBehavior.padded.index} (padded), '
                  '${ButtonBarLayoutBehavior.constrained.index} (constrained).',
                  style: const TextStyle(color: heroText, height: 1.35),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final v in ButtonBarLayoutBehavior.values)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: heroAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${v.name}  (index=${v.index})',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 2 — SIDE-BY-SIDE: same children, two ButtonBars.
  // ==========================================================================
  Widget labeledBar({
    required String label,
    required Color labelColor,
    required ButtonBarLayoutBehavior behavior,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: labelColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  'ButtonBarLayoutBehavior.${behavior.name} '
                  '(rendered via OverflowBar — modern equivalent)',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black54,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              OverflowBar(
                alignment: MainAxisAlignment.end,
                spacing: 8,
                children: behavior == ButtonBarLayoutBehavior.constrained
                    ? <Widget>[
                        for (final Widget kid in children)
                          SizedBox(width: 64, child: kid),
                      ]
                    : children,
              ),
            ],
          ),
        ),
      ],
    );
  }

  final Widget section2Side = Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: sideBg,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: sideAccent, width: 1.4),
    ),
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: sideAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: const Text(
                '2',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Side-by-side comparison',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: sideText,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'Below: identical Cancel / Reset / Save children, rendered into two '
          'ButtonBars sized into the same column width. The left bar uses '
          'padded; the right bar uses constrained. Notice the Save / Reset '
          'buttons grow to the 64dp minimum on the right.',
          style: TextStyle(color: sideText, height: 1.4),
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: labeledBar(
                label: 'padded',
                labelColor: sideAccent,
                behavior: ButtonBarLayoutBehavior.padded,
                children: trio(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: labeledBar(
                label: 'constrained',
                labelColor: sideAccent,
                behavior: ButtonBarLayoutBehavior.constrained,
                children: trio(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Now the same comparison but with a tiny Yes / No pair, where '
          'constrained makes the dramatic visual difference.',
          style: TextStyle(color: sideText, height: 1.4),
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: labeledBar(
                label: 'padded · tiny',
                labelColor: sideAccent,
                behavior: ButtonBarLayoutBehavior.padded,
                children: tinyPair(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: labeledBar(
                label: 'constrained · tiny',
                labelColor: sideAccent,
                behavior: ButtonBarLayoutBehavior.constrained,
                children: tinyPair(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'And finally, when the labels are already wider than 64dp, padded '
          'and constrained render almost identically — the minimum width is '
          'a floor, not a target.',
          style: TextStyle(color: sideText, height: 1.4),
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: labeledBar(
                label: 'padded · wide',
                labelColor: sideAccent,
                behavior: ButtonBarLayoutBehavior.padded,
                children: mixedWide(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: labeledBar(
                label: 'constrained · wide',
                labelColor: sideAccent,
                behavior: ButtonBarLayoutBehavior.constrained,
                children: mixedWide(),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 3 — CONTAINER-WIDTH SWEEP.
  // We render the same children inside fixed-width containers (200, 320, 480,
  // 720) and pair each width with both layout behaviours. This gives a
  // visual "responsive" sweep so the reader sees how layout reacts as the
  // outer width changes.
  // ==========================================================================
  Widget sweepRow(double w) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: sweepAccent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'parent width = ${w.toInt()}dp',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 14,
            runSpacing: 10,
            children: [
              SizedBox(
                width: w,
                child: labeledBar(
                  label: 'padded',
                  labelColor: sweepAccent,
                  behavior: ButtonBarLayoutBehavior.padded,
                  children: tinyPair(),
                ),
              ),
              SizedBox(
                width: w,
                child: labeledBar(
                  label: 'constrained',
                  labelColor: sweepAccent,
                  behavior: ButtonBarLayoutBehavior.constrained,
                  children: tinyPair(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  final Widget section3Sweep = Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: sweepBg,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: sweepAccent, width: 1.4),
    ),
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: sweepAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: const Text(
                '3',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Container-width sweep',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: sweepText,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'A ButtonBar will collapse short labels onto its trailing edge, but '
          'how much room remains depends on the parent. Below, the same Yes/No '
          'pair is wrapped in 200, 320, 480, and 720dp boxes; each box gets '
          'one padded variant and one constrained variant. The wider the box, '
          'the more obvious the trailing-end alignment becomes.',
          style: TextStyle(color: sweepText, height: 1.4),
        ),
        const SizedBox(height: 14),
        sweepRow(200),
        sweepRow(320),
        sweepRow(480),
        sweepRow(720),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 4 — DIALOG FOOTER MOCKUPS.
  // We mock realistic Material dialog content with a title, body, and a
  // ButtonBar footer using each layout behaviour. No real dialog routes are
  // pushed (the harness is static); these are static visual mockups.
  // ==========================================================================
  Widget dialogMock({
    required String title,
    required String body,
    required ButtonBarLayoutBehavior behavior,
    required List<Widget> actions,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: dialogAccent.withOpacity(0.6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: dialogText,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
            child: Text(
              body,
              style: const TextStyle(color: dialogText, height: 1.35),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 6, 12, 4),
            child: Text(
              'footer layoutBehavior reference: '
              'ButtonBarLayoutBehavior.${behavior.name} '
              '(rendered via OverflowBar)',
              style: const TextStyle(
                fontSize: 10,
                color: Colors.black54,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
            child: OverflowBar(
              alignment: MainAxisAlignment.end,
              spacing: 8,
              overflowSpacing: 6,
              children: behavior == ButtonBarLayoutBehavior.constrained
                  ? <Widget>[
                      for (final Widget action in actions)
                        SizedBox(width: 64, child: action),
                    ]
                  : actions,
            ),
          ),
        ],
      ),
    );
  }

  final Widget section4Dialogs = Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: dialogBg,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: dialogAccent, width: 1.4),
    ),
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: dialogAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: const Text(
                '4',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Dialog footer mockups',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: dialogText,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'AlertDialog historically used ButtonBarLayoutBehavior.padded for '
          'its action footer. In modern code you would pass actions to '
          'OverflowBar, but the same enum can still tune classic dialog '
          'mockups. Each card below is a hand-laid mockup, not a real route.',
          style: TextStyle(color: dialogText, height: 1.4),
        ),
        const SizedBox(height: 14),
        dialogMock(
          title: 'Discard draft?',
          body: 'You have unsaved changes that will be lost if you continue.',
          behavior: ButtonBarLayoutBehavior.padded,
          actions: const [
            TextButton(onPressed: null, child: Text('No')),
            ElevatedButton(onPressed: null, child: Text('Yes')),
          ],
        ),
        const SizedBox(height: 14),
        dialogMock(
          title: 'Discard draft? (constrained)',
          body: 'Same dialog, but the footer uses '
              'ButtonBarLayoutBehavior.constrained — see the wider Yes/No.',
          behavior: ButtonBarLayoutBehavior.constrained,
          actions: const [
            TextButton(onPressed: null, child: Text('No')),
            ElevatedButton(onPressed: null, child: Text('Yes')),
          ],
        ),
        const SizedBox(height: 14),
        dialogMock(
          title: 'Save changes',
          body: 'Choose where to save the document — the original location, '
              'or as a new copy.',
          behavior: ButtonBarLayoutBehavior.padded,
          actions: const [
            TextButton(onPressed: null, child: Text('Discard')),
            OutlinedButton(onPressed: null, child: Text('Save')),
            ElevatedButton(onPressed: null, child: Text('Save as')),
          ],
        ),
        const SizedBox(height: 14),
        dialogMock(
          title: 'Confirm delete',
          body: 'Permanently delete 3 selected items? This cannot be undone.',
          behavior: ButtonBarLayoutBehavior.constrained,
          actions: const [
            TextButton(onPressed: null, child: Text('Cancel')),
            ElevatedButton(onPressed: null, child: Text('Delete')),
          ],
        ),
        const SizedBox(height: 14),
        dialogMock(
          title: 'Many actions overflow',
          body: 'When the dialog has too many actions to fit on one row, the '
              'ButtonBar wraps onto multiple lines. constrained still '
              'enforces a minimum button width on each row.',
          behavior: ButtonBarLayoutBehavior.constrained,
          actions: const [
            TextButton(onPressed: null, child: Text('Help')),
            TextButton(onPressed: null, child: Text('Cancel')),
            OutlinedButton(onPressed: null, child: Text('Reset')),
            OutlinedButton(onPressed: null, child: Text('Apply')),
            ElevatedButton(onPressed: null, child: Text('Save')),
          ],
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 5 — THEMED via ButtonBarTheme HIGHER IN THE TREE.
  // Two distinct ButtonBarTheme widgets at the top of two columns. Each child
  // ButtonBar inherits from the nearest ButtonBarTheme, so we can demonstrate
  // theme inheritance without per-bar overrides.
  // ==========================================================================
  Widget themedColumn({
    required ButtonBarLayoutBehavior behavior,
    required String title,
  }) {
    // The original demo wrapped this column in a ButtonBarTheme + a
    // ButtonBarThemeData carrying layoutBehavior, alignment, buttonTextTheme,
    // buttonHeight, and buttonMinWidth. ButtonBarThemeData is no longer
    // bridged — modern Flutter renders the same row via OverflowBar, which
    // does not consult ButtonBarLayoutBehavior. We recreate the visual
    // intent: each child is wrapped in a SizedBox of the original button
    // height (40) and, when behavior is constrained, the original
    // buttonMinWidth (80) — otherwise the natural width is preserved.
    final double rowHeight = 40;
    final double? minWidth =
        behavior == ButtonBarLayoutBehavior.constrained ? 80 : null;
    Widget shape(Widget kid) {
      return SizedBox(
        height: rowHeight,
        width: minWidth,
        child: kid,
      );
    }

    Widget bar(List<Widget> kids) {
      return OverflowBar(
        alignment: MainAxisAlignment.end,
        spacing: 8,
        overflowSpacing: 6,
        children: <Widget>[for (final Widget k in kids) shape(k)],
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: themeAccent.withOpacity(0.6)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: themeText,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'inherits ButtonBarLayoutBehavior.${behavior.name} '
            '(referenced via the enum; rendered via OverflowBar — '
            'ButtonTextTheme.primary, buttonHeight=40'
            '${minWidth != null ? ', buttonMinWidth=80' : ''} from the '
            'original ButtonBarThemeData are simulated by SizedBox)',
            style: const TextStyle(
              fontSize: 10,
              color: Colors.black54,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          bar(const <Widget>[
            TextButton(onPressed: null, child: Text('Cancel')),
            ElevatedButton(onPressed: null, child: Text('OK')),
          ]),
          const Divider(height: 1),
          bar(const <Widget>[
            TextButton(onPressed: null, child: Text('Back')),
            OutlinedButton(onPressed: null, child: Text('Skip')),
            ElevatedButton(onPressed: null, child: Text('Next')),
          ]),
          const Divider(height: 1),
          bar(const <Widget>[
            ElevatedButton(onPressed: null, child: Text('Continue')),
          ]),
        ],
      ),
    );
  }

  final Widget section5Theme = Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: themeBg,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: themeAccent, width: 1.4),
    ),
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: themeAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: const Text(
                '5',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Themed via ButtonBarTheme',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: themeText,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'A ButtonBarTheme high in the tree pushes a single layoutBehavior '
          'down to every ButtonBar below it. The two columns below each '
          'install a ButtonBarTheme at the top and contain three ButtonBars '
          'each — none of those bars carries an inline override. The same '
          'children (Cancel/OK, Back/Skip/Next, Continue) render under each '
          'inherited behaviour.',
          style: TextStyle(color: themeText, height: 1.4),
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: themedColumn(
                behavior: ButtonBarLayoutBehavior.padded,
                title: 'inherits padded',
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: themedColumn(
                behavior: ButtonBarLayoutBehavior.constrained,
                title: 'inherits constrained',
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: themeAccent.withOpacity(0.4)),
          ),
          child: const Text(
            'Tip: ButtonBarThemeData also exposes alignment, '
            'mainAxisSize, buttonTextTheme, buttonMinWidth, '
            'buttonHeight, and overflowDirection. Setting layoutBehavior is '
            'usually the first one you reach for to align Yes/No/OK trios.',
            style: TextStyle(color: themeText, height: 1.35),
          ),
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 6 — LONG-BUTTON-TEXT EDGE CASE.
  // When labels are deliberately long, padded keeps natural wrapping while
  // constrained still respects the 64dp floor (it doesn't shrink large
  // buttons; it only enlarges short ones).
  // ==========================================================================
  Widget longRow(ButtonBarLayoutBehavior b) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: longAccent.withOpacity(0.6)),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              'ButtonBarLayoutBehavior.${b.name} '
              '(rendered via OverflowBar — modern Flutter equivalent; '
              'OverflowBar does not honour ButtonBarLayoutBehavior natively, '
              'the enum value is shown above for reference)',
              style: const TextStyle(
                fontSize: 10,
                color: Colors.black54,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          OverflowBar(
            alignment: MainAxisAlignment.end,
            spacing: 8,
            overflowSpacing: 6,
            children: <Widget>[
              const TextButton(
                onPressed: null,
                child: Text('Maybe later'),
              ),
              const OutlinedButton(
                onPressed: null,
                child: Text('Read the privacy notice'),
              ),
              const ElevatedButton(
                onPressed: null,
                child: Text('I accept the terms and conditions'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  final Widget section6Long = Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: longBg,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: longAccent, width: 1.4),
    ),
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: longAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: const Text(
                '6',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Long-label edge case',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: longText,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'When buttons already exceed the 64dp floor, padded and constrained '
          'look effectively the same — but watch how the bar wraps when the '
          'available width is small. ButtonBar uses overflowDirection to '
          'pick column direction during wrap.',
          style: TextStyle(color: longText, height: 1.4),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: longAccent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Text(
            'padded',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 6),
        longRow(ButtonBarLayoutBehavior.padded),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: longAccent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Text(
            'constrained',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 6),
        longRow(ButtonBarLayoutBehavior.constrained),
        const SizedBox(height: 16),
        const Text(
          'Bonus: the same content rendered with a modern OverflowBar (the '
          'replacement that Material now recommends). OverflowBar does not '
          'consult ButtonBarLayoutBehavior — it has its own knobs '
          '(overflowAlignment, overflowSpacing, alignment).',
          style: TextStyle(color: longText, height: 1.4),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: longAccent.withOpacity(0.6)),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(8),
          child: const OverflowBar(
            spacing: 8,
            overflowSpacing: 8,
            alignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: null, child: Text('Maybe later')),
              OutlinedButton(
                onPressed: null,
                child: Text('Read the privacy notice'),
              ),
              ElevatedButton(
                onPressed: null,
                child: Text('I accept the terms and conditions'),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 7 — REFERENCE TABLE: enum value, index, description.
  // ==========================================================================
  TableRow tableRow(String c1, String c2, String c3, {bool header = false}) {
    final TextStyle style = TextStyle(
      color: tableText,
      fontWeight: header ? FontWeight.bold : FontWeight.normal,
      height: 1.35,
    );
    final Color bg = header ? tableAccent.withOpacity(0.15) : Colors.white;
    return TableRow(
      decoration: BoxDecoration(color: bg),
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(c1, style: style),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(c2, style: style),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(c3, style: style),
        ),
      ],
    );
  }

  final Widget section7Table = Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: tableBg,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: tableAccent, width: 1.4),
    ),
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: tableAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: const Text(
                '7',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Reference table',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: tableText,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'Each enum value, its declared index, and a one-line summary of '
          'the layout it produces. Reading these names from the running '
          'instance proves they survive the AST round-trip.',
          style: TextStyle(color: tableText, height: 1.4),
        ),
        const SizedBox(height: 14),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: tableAccent.withOpacity(0.4)),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(1.0),
              1: FlexColumnWidth(0.6),
              2: FlexColumnWidth(2.4),
            },
            border: TableBorder.symmetric(
              inside: BorderSide(color: tableAccent.withOpacity(0.25)),
            ),
            children: [
              tableRow('value', 'index', 'description', header: true),
              tableRow(
                ButtonBarLayoutBehavior.padded.name,
                '${ButtonBarLayoutBehavior.padded.index}',
                'Children keep their natural intrinsic size; the bar adds '
                    'standard outer padding.',
              ),
              tableRow(
                ButtonBarLayoutBehavior.constrained.name,
                '${ButtonBarLayoutBehavior.constrained.index}',
                'Each child is given at least 64dp of width so short labels '
                    'line up with longer ones.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Sanity check (run at build time):',
          style: TextStyle(
            color: tableText,
            fontWeight: FontWeight.bold,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final v in ButtonBarLayoutBehavior.values)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: tableAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${v.name} → ${v.index}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 8 — RECIPE GALLERY.
  // Three realistic UI mockups: confirm-delete dialog, settings save bar,
  // contact form footer. Each mockup chooses the layout behaviour that best
  // suits its content.
  // ==========================================================================
  // Compact reusable footer that simulates the legacy ButtonBar/ButtonBarTheme
  // wrapper using OverflowBar. The ButtonBarLayoutBehavior enum is referenced
  // for documentation; constrained wraps each child in a 64dp-min SizedBox.
  Widget galleryFooter(ButtonBarLayoutBehavior b, List<Widget> kids) {
    final List<Widget> rendered = b == ButtonBarLayoutBehavior.constrained
        ? <Widget>[for (final Widget k in kids) SizedBox(width: 64, child: k)]
        : kids;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              'footer reference: ButtonBarLayoutBehavior.${b.name} '
              '(rendered via OverflowBar)',
              style: const TextStyle(
                fontSize: 10,
                color: Colors.black54,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          OverflowBar(
            alignment: MainAxisAlignment.end,
            spacing: 8,
            overflowSpacing: 6,
            children: rendered,
          ),
        ],
      ),
    );
  }

  Widget galleryCard({
    required String title,
    required String subtitle,
    required String chip,
    required Widget body,
    required Widget footer,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: galleryAccent.withOpacity(0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: galleryText,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: galleryText.withOpacity(0.75),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: galleryAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    chip,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: body,
          ),
          const Divider(height: 1),
          footer,
        ],
      ),
    );
  }

  final Widget section8Gallery = Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: galleryBg,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: galleryAccent, width: 1.4),
    ),
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: galleryAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: const Text(
                '8',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Recipe gallery',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: galleryText,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'Three realistic mockups that pick the appropriate layoutBehavior '
          'for their content.',
          style: TextStyle(color: galleryText, height: 1.4),
        ),
        const SizedBox(height: 14),
        galleryCard(
          title: 'Confirm delete',
          subtitle: 'Two short labels — constrained tightens them up.',
          chip: 'constrained',
          body: const Text(
            'Are you sure you want to permanently remove "Q3 forecast.xlsx"?',
            style: TextStyle(color: galleryText, height: 1.35),
          ),
          footer: galleryFooter(
            ButtonBarLayoutBehavior.constrained,
            const <Widget>[
              TextButton(onPressed: null, child: Text('No')),
              ElevatedButton(onPressed: null, child: Text('Yes')),
            ],
          ),
        ),
        const SizedBox(height: 14),
        galleryCard(
          title: 'Unsaved settings',
          subtitle: 'Mid-length labels — padded keeps natural sizing.',
          chip: 'padded',
          body: const Text(
            'You changed the notification preferences but have not saved yet.',
            style: TextStyle(color: galleryText, height: 1.35),
          ),
          footer: galleryFooter(
            ButtonBarLayoutBehavior.padded,
            const <Widget>[
              TextButton(onPressed: null, child: Text('Discard')),
              OutlinedButton(onPressed: null, child: Text('Keep editing')),
              ElevatedButton(onPressed: null, child: Text('Save')),
            ],
          ),
        ),
        const SizedBox(height: 14),
        galleryCard(
          title: 'Contact form footer',
          subtitle: 'Five actions — constrained keeps short ones aligned.',
          chip: 'constrained',
          body: const Text(
            'Required fields are marked with an asterisk. Press Send when '
            'you are happy with the contents.',
            style: TextStyle(color: galleryText, height: 1.35),
          ),
          footer: galleryFooter(
            ButtonBarLayoutBehavior.constrained,
            const <Widget>[
              TextButton(onPressed: null, child: Text('Help')),
              TextButton(onPressed: null, child: Text('Cancel')),
              OutlinedButton(onPressed: null, child: Text('Reset')),
              OutlinedButton(onPressed: null, child: Text('Draft')),
              ElevatedButton(onPressed: null, child: Text('Send')),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: galleryAccent.withOpacity(0.4)),
          ),
          child: const Text(
            'Rule of thumb: choose constrained when you have several short '
            'two-or-three-letter labels (Yes/No/OK), and padded when your '
            'labels are already similar in width or you want the bar to feel '
            'lightweight and compact.',
            style: TextStyle(color: galleryText, height: 1.35),
          ),
        ),
      ],
    ),
  );

  // ==========================================================================
  // FOOTER — closing summary card.
  // ==========================================================================
  final Widget footer = Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(14),
    ),
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Summary',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'ButtonBarLayoutBehavior is small but pivotal for tidy Material '
          'action bars. Reach for constrained when a row holds short, '
          'mismatched labels; reach for padded when the labels are already '
          'similar in width or you simply want a compact footer.',
          style: TextStyle(color: Colors.white, height: 1.4),
        ),
        SizedBox(height: 8),
        Text(
          'Although ButtonBar is now deprecated in favour of OverflowBar, '
          'the enum is still part of the Material library and continues to '
          'flow through ButtonBarTheme to any classic ButtonBar instances '
          'that survive in legacy codebases.',
          style: TextStyle(color: Colors.white70, height: 1.4),
        ),
      ],
    ),
  );

  // ==========================================================================
  // ROOT — assemble.
  // ==========================================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ButtonBarLayoutBehavior Deep Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: heroAccent),
      useMaterial3: true,
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  'ButtonBarLayoutBehavior — deep visual demo',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1145),
                  ),
                ),
              ),
              section1Hero,
              const SizedBox(height: 18),
              section2Side,
              const SizedBox(height: 18),
              section3Sweep,
              const SizedBox(height: 18),
              section4Dialogs,
              const SizedBox(height: 18),
              section5Theme,
              const SizedBox(height: 18),
              section6Long,
              const SizedBox(height: 18),
              section7Table,
              const SizedBox(height: 18),
              section8Gallery,
              const SizedBox(height: 18),
              footer,
            ],
          ),
        ),
      ),
    ),
  );
}
