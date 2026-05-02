// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Live demo gallery - ButtonBarTheme deep dive
// ----------------------------------------------------------------------------
// ButtonBarTheme is the inherited Material theme widget that supplies a
// ButtonBarThemeData to any descendant ButtonBar. It is the conduit through
// which alignment, mainAxisSize, layoutBehavior, padding, buttonPadding,
// buttonTextTheme, buttonMinWidth, buttonHeight, overflowDirection, and
// overflowButtonSpacing are propagated through the widget tree without ever
// touching the ButtonBar constructor. Both ButtonBar and ButtonBarTheme are
// deprecated in modern Flutter (replaced by OverflowBar / Wrap / Row), but
// they still drive a tremendous amount of legacy Material code, including
// most AlertDialog actions footers, so understanding the theme is still the
// only way to make those screens look consistent.
//
// This script is a long-form gallery in eleven distinct sections. Each
// section paints a tinted card with one or more real ButtonBar widgets so a
// reader can scroll the build output and see the *visual effect* of every
// ButtonBarThemeData field, plus a final "reading-back" card and a
// reference card listing every theme field with prose.
// ----------------------------------------------------------------------------
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ===========================================================================
  // PROLOGUE - DIAGNOSTIC PRINTS
  // ---------------------------------------------------------------------------
  // The reference cupertino_focus_halo_test gallery prints a diagnostic header
  // before painting the tree. We do the same here so when this script is
  // executed via send_ast_via_http the operator can see, in the run log, that
  // every section's theme has been constructed and is exactly as documented.
  // ===========================================================================
  print('=== ButtonBarTheme Deep Demo ===');
  print('Eleven sections, each pinned to a specific ButtonBarThemeData field.');
  print('Sections:');
  print('  1. Hero - what is ButtonBarTheme + ButtonBarTheme.of(context)');
  print('  2. Alignment sweep (start/end/center/spaceBetween/spaceAround)');
  print('  3. ButtonBarLayoutBehavior (padded vs constrained)');
  print('  4. mainAxisSize (min vs max)');
  print('  5. buttonPadding x buttonMinWidth x buttonHeight matrix');
  print('  6. buttonTextTheme (normal / accent / primary)');
  print('  7. overflowDirection (down vs up) under narrow constraint');
  print('  8. overflowButtonSpacing (0 / 8 / 24)');
  print('  9. Realistic dialog footers themed via ButtonBarTheme');
  print(' 10. Reading-back card calling ButtonBarTheme.of(context)');
  print(' 11. Reference card listing every ButtonBarThemeData field');

  // ===========================================================================
  // PALETTE - DISTINCT TINT PER SECTION
  // ---------------------------------------------------------------------------
  // Each section has its own background tint and accent. The tints stay light
  // so the tinted card never overpowers the actual ButtonBar inside it. The
  // numbers track Material design "50/100" grades so the result reads as a
  // sample book of cards rather than a noisy collage.
  // ===========================================================================
  const heroBg = Color(0xFFEFEAF8);
  const heroAccent = Color(0xFF5E35B1);
  const alignBg = Color(0xFFE3F2FD);
  const alignAccent = Color(0xFF1565C0);
  const layoutBg = Color(0xFFE8F5E9);
  const layoutAccent = Color(0xFF2E7D32);
  const axisBg = Color(0xFFFFF8E1);
  const axisAccent = Color(0xFFB28704);
  const matrixBg = Color(0xFFFCE4EC);
  const matrixAccent = Color(0xFFAD1457);
  const textThemeBg = Color(0xFFE0F7FA);
  const textThemeAccent = Color(0xFF006064);
  const overflowDirBg = Color(0xFFF3E5F5);
  const overflowDirAccent = Color(0xFF6A1B9A);
  const overflowSpacingBg = Color(0xFFFFF3E0);
  const overflowSpacingAccent = Color(0xFFE65100);
  const dialogBg = Color(0xFFE8EAF6);
  const dialogAccent = Color(0xFF283593);
  const readbackBg = Color(0xFFE0F2F1);
  const readbackAccent = Color(0xFF00695C);
  const referenceBg = Color(0xFFECEFF1);
  const referenceAccent = Color(0xFF37474F);

  // ===========================================================================
  // HERO CARD - WHAT IS ButtonBarTheme
  // ---------------------------------------------------------------------------
  // The hero card explains, in plain prose, what ButtonBarTheme is, the
  // contract of ButtonBarTheme.of(context), and why a descendant ButtonBar
  // does not need to know any of these fields directly.
  //
  // Visually we put a single ButtonBar at the bottom of the hero card so the
  // reader can immediately see "this card has live buttons themed by the
  // theme described above". The ButtonBarTheme(data:...) wrap makes the
  // alignment end and the buttonPadding generous so the buttons feel
  // important.
  // ===========================================================================
  Widget buildHeroCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      decoration: BoxDecoration(
        color: heroBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: heroAccent.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '1. ButtonBarTheme - the inherited Material theme widget',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: heroAccent,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'ButtonBarTheme is an InheritedTheme that carries a single '
            'ButtonBarThemeData object down the widget tree. Every '
            'ButtonBar (and many AlertDialog actions footers) that does not '
            'set a field directly resolves it via '
            'ButtonBarTheme.of(context).<field>. Because it is an inherited '
            'theme, you can also place a localised ButtonBarTheme around a '
            'subtree to override styling for just that subtree. This card is '
            'wrapped in a ButtonBarTheme that pushes the row to the right '
            'with generous button padding.',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 12),
          const Text(
            'Resolution order for a single ButtonBar field:',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          const Text('  1. constructor argument (highest priority)'),
          const Text('  2. ButtonBarTheme.of(context).<field>'),
          const Text('  3. hard-coded ButtonBarThemeData default in framework'),
          const SizedBox(height: 14),
          ButtonBarTheme(
            data: const ButtonBarThemeData(
              alignment: MainAxisAlignment.end,
              buttonPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              buttonTextTheme: ButtonTextTheme.primary,
            ),
            child: ButtonBar(
              children: [
                TextButton(
                    onPressed: () => print('hero/cancel'),
                    child: const Text('CANCEL')),
                ElevatedButton(
                    onPressed: () => print('hero/save'),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: heroAccent),
                    child: const Text('SAVE',
                        style: TextStyle(color: Colors.white))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 2 - ALIGNMENT SWEEP
  // ---------------------------------------------------------------------------
  // Five tinted sub-cards inside one parent card. Each sub-card wraps the
  // *same* two-button content under a different ButtonBarTheme(data:) with a
  // different MainAxisAlignment value. Because the buttons are identical,
  // any visual difference is attributable solely to the theme alignment.
  //
  // We use a wide stretch so the spaceBetween / spaceAround variants have
  // somewhere to spread to.
  // ===========================================================================
  Widget alignmentRow(String label, MainAxisAlignment alignment) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: alignAccent.withOpacity(0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: ButtonBarTheme(
              data: ButtonBarThemeData(alignment: alignment),
              child: ButtonBar(
                children: [
                  TextButton(
                      onPressed: () => print('align/$label/cancel'),
                      child: const Text('CANCEL')),
                  ElevatedButton(
                      onPressed: () => print('align/$label/ok'),
                      child: const Text('OK')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAlignmentCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
      decoration: BoxDecoration(
        color: alignBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: alignAccent.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '2. Alignment sweep - five MainAxisAlignment values',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: alignAccent,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Same two buttons, five themes. The label on the left names the '
            'MainAxisAlignment that the local ButtonBarTheme is enforcing.',
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 10),
          alignmentRow('start', MainAxisAlignment.start),
          alignmentRow('end', MainAxisAlignment.end),
          alignmentRow('center', MainAxisAlignment.center),
          alignmentRow('spaceBetween', MainAxisAlignment.spaceBetween),
          alignmentRow('spaceAround', MainAxisAlignment.spaceAround),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 3 - ButtonBarLayoutBehavior (padded vs constrained)
  // ---------------------------------------------------------------------------
  // ButtonBarLayoutBehavior.padded inflates the bar to a comfortable height
  // and gives it generous outside padding. ButtonBarLayoutBehavior.constrained
  // forces the bar into a 52-density tight constraint typical of dialog
  // footers. We render two side-by-side ButtonBars under the same alignment
  // (end) so only the layoutBehavior changes.
  // ===========================================================================
  Widget layoutBehaviourBar(String label, ButtonBarLayoutBehavior behaviour) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: layoutAccent.withOpacity(0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 6),
            ButtonBarTheme(
              data: ButtonBarThemeData(
                alignment: MainAxisAlignment.end,
                layoutBehavior: behaviour,
              ),
              child: ButtonBar(
                children: [
                  TextButton(
                      onPressed: () => print('layout/$label/cancel'),
                      child: const Text('CANCEL')),
                  ElevatedButton(
                      onPressed: () => print('layout/$label/save'),
                      child: const Text('SAVE')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLayoutBehaviourCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
      decoration: BoxDecoration(
        color: layoutBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: layoutAccent.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '3. ButtonBarLayoutBehavior - padded vs constrained',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: layoutAccent,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'padded is the default for ButtonBar standalone use. constrained '
            'is what AlertDialog uses when its actions are passed in - it '
            'caps the bar at 52 logical pixels of height, regardless of the '
            'children intrinsic heights, which is why dialogs look uniform.',
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              layoutBehaviourBar('padded', ButtonBarLayoutBehavior.padded),
              layoutBehaviourBar(
                  'constrained', ButtonBarLayoutBehavior.constrained),
            ],
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 4 - mainAxisSize (min vs max)
  // ---------------------------------------------------------------------------
  // mainAxisSize.max stretches the bar to fill its parent's width.
  // mainAxisSize.min shrinks the bar to fit just the buttons. With the bar
  // shrunk you can see the parent's spare width clearly because the tinted
  // outline sits flush around the buttons only.
  // ===========================================================================
  Widget mainAxisSizeBar(String label, MainAxisSize size) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: axisAccent.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: axisAccent, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: ButtonBarTheme(
              data: ButtonBarThemeData(
                alignment: MainAxisAlignment.end,
                mainAxisSize: size,
              ),
              child: ButtonBar(
                children: [
                  TextButton(
                      onPressed: () => print('axis/$label/cancel'),
                      child: const Text('CANCEL')),
                  ElevatedButton(
                      onPressed: () => print('axis/$label/save'),
                      child: const Text('SAVE')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMainAxisSizeCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
      decoration: BoxDecoration(
        color: axisBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: axisAccent.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '4. mainAxisSize - min vs max',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: axisAccent,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'The thin outlined Box around each ButtonBar is *not* part of the '
            'theme - it is a visual aid that hugs whatever main axis the bar '
            'reports. With mainAxisSize.min the outline collapses around the '
            'buttons; with mainAxisSize.max it stretches edge-to-edge.',
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 4),
          mainAxisSizeBar('mainAxisSize.max', MainAxisSize.max),
          mainAxisSizeBar('mainAxisSize.min', MainAxisSize.min),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 5 - buttonPadding x buttonMinWidth x buttonHeight matrix
  // ---------------------------------------------------------------------------
  // We build a 3 x 3 grid. Rows vary buttonPadding (small / medium / large).
  // Columns vary buttonMinWidth (64 / 96 / 144). Each cell renders a
  // ButtonBarTheme with the corresponding values plus a fixed buttonHeight,
  // and inside it sits a single ButtonBar with a Cancel / OK pair.
  //
  // Because all three values feed into the *same* legacy RaisedButton sizing
  // computation, you need to use a non-Material3 button (TextButton with no
  // material3 padding override is fine - the theme still flows). We keep
  // the children identical so the only differences come from the theme.
  // ===========================================================================
  final paddingValues = <Map<String, dynamic>>[
    {'label': 'small', 'value': const EdgeInsets.symmetric(horizontal: 8)},
    {'label': 'medium', 'value': const EdgeInsets.symmetric(horizontal: 16)},
    {'label': 'large', 'value': const EdgeInsets.symmetric(horizontal: 28)},
  ];
  final minWidthValues = <Map<String, dynamic>>[
    {'label': 'minW=64', 'value': 64.0},
    {'label': 'minW=96', 'value': 96.0},
    {'label': 'minW=144', 'value': 144.0},
  ];
  final heightValues = <Map<String, dynamic>>[
    {'label': 'h=36', 'value': 36.0},
    {'label': 'h=48', 'value': 48.0},
    {'label': 'h=60', 'value': 60.0},
  ];

  Widget matrixCell(EdgeInsets padding, double minWidth, double height,
      String caption) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: matrixAccent.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            caption,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          ButtonBarTheme(
            data: ButtonBarThemeData(
              alignment: MainAxisAlignment.start,
              buttonPadding: padding,
              buttonMinWidth: minWidth,
              buttonHeight: height,
            ),
            child: ButtonBar(
              children: [
                TextButton(
                    onPressed: () => print('matrix/$caption/cancel'),
                    child: const Text('CANCEL')),
                ElevatedButton(
                    onPressed: () => print('matrix/$caption/ok'),
                    child: const Text('OK')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMatrixCard() {
    final rows = <Widget>[];
    for (final pad in paddingValues) {
      final cells = <Widget>[];
      for (final mw in minWidthValues) {
        // We pair each (padding, minWidth) cell with one of the three
        // heights. The simplest mapping is a diagonal: rotate the height
        // index by the row index so each row uses a different height.
        final rowIdx = paddingValues.indexOf(pad);
        final colIdx = minWidthValues.indexOf(mw);
        final h = heightValues[(rowIdx + colIdx) % heightValues.length];
        final caption =
            '${pad['label']} / ${mw['label']} / ${h['label']}';
        cells.add(Expanded(
          child: matrixCell(
            pad['value'] as EdgeInsets,
            mw['value'] as double,
            h['value'] as double,
            caption,
          ),
        ));
      }
      rows.add(Row(children: cells));
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
      decoration: BoxDecoration(
        color: matrixBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: matrixAccent.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '5. buttonPadding x buttonMinWidth x buttonHeight',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: matrixAccent,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'A 3x3 grid varying padding (rows) and min width (columns), with '
            'a rotating height per cell. These three legacy fields are the '
            'oldest sizing levers ButtonBar exposes. Because Material3 '
            'buttons compute their own metrics, the legacy fields only have '
            'visible effect on classic Material buttons; we still see the '
            'cell width grow with min width.',
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 10),
          ...rows,
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 6 - buttonTextTheme (normal / accent / primary)
  // ---------------------------------------------------------------------------
  // The buttonTextTheme is a legacy ButtonTextTheme enum. Three values are
  // exposed: normal (default body colour), accent (theme accent colour),
  // primary (theme primary colour with white text). We render three
  // ButtonBars, one per value, each themed via ButtonBarTheme.
  // ===========================================================================
  Widget buttonTextThemeBar(String label, ButtonTextTheme theme) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: textThemeAccent.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          ButtonBarTheme(
            data: ButtonBarThemeData(
              alignment: MainAxisAlignment.start,
              buttonTextTheme: theme,
            ),
            child: ButtonBar(
              children: [
                TextButton(
                    onPressed: () => print('textTheme/$label/cancel'),
                    child: const Text('CANCEL')),
                TextButton(
                    onPressed: () => print('textTheme/$label/preview'),
                    child: const Text('PREVIEW')),
                ElevatedButton(
                    onPressed: () => print('textTheme/$label/ok'),
                    child: const Text('OK')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButtonTextThemeCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
      decoration: BoxDecoration(
        color: textThemeBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: textThemeAccent.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '6. buttonTextTheme - normal / accent / primary',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textThemeAccent,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'ButtonTextTheme is the legacy enum that drove RaisedButton / '
            'FlatButton text colour. ButtonBarTheme.buttonTextTheme is still '
            'plumbed through the ButtonTheme that ButtonBar wraps around its '
            'children, so any descendant button that does not override its '
            'foregroundColor will pick up the corresponding tone.',
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 4),
          buttonTextThemeBar('normal', ButtonTextTheme.normal),
          buttonTextThemeBar('accent', ButtonTextTheme.accent),
          buttonTextThemeBar('primary', ButtonTextTheme.primary),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 7 - overflowDirection (down vs up)
  // ---------------------------------------------------------------------------
  // ButtonBar overflows when its children's intrinsic widths exceed the
  // available width. The overflow direction controls whether the *first*
  // child stays on top (down) or moves to the bottom (up). To force overflow
  // we wrap each ButtonBar in a narrow SizedBox of width 200 and feed it
  // four buttons with chunky labels.
  // ===========================================================================
  Widget overflowDirBar(String label, VerticalDirection direction) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: overflowDirAccent.withOpacity(0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'first button is the primary action - watch its position when '
              'the bar overflows.',
              style: TextStyle(fontSize: 11, color: Colors.black54),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: 200,
              child: ButtonBarTheme(
                data: ButtonBarThemeData(
                  alignment: MainAxisAlignment.end,
                  overflowDirection: direction,
                ),
                child: ButtonBar(
                  children: [
                    ElevatedButton(
                        onPressed: () => print('overflowDir/$label/save'),
                        child: const Text('SAVE CHANGES')),
                    TextButton(
                        onPressed: () => print('overflowDir/$label/discard'),
                        child: const Text('DISCARD')),
                    TextButton(
                        onPressed: () => print('overflowDir/$label/preview'),
                        child: const Text('PREVIEW')),
                    TextButton(
                        onPressed: () => print('overflowDir/$label/cancel'),
                        child: const Text('CANCEL')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOverflowDirectionCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
      decoration: BoxDecoration(
        color: overflowDirBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: overflowDirAccent.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '7. overflowDirection - down vs up',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: overflowDirAccent,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Each ButtonBar is constrained to 200 logical pixels and given '
            'four labelled buttons so it must overflow into a vertical '
            'stack. The down variant keeps the primary action at the top of '
            'the stack; the up variant pushes it to the bottom.',
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              overflowDirBar('down', VerticalDirection.down),
              overflowDirBar('up', VerticalDirection.up),
            ],
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 8 - overflowButtonSpacing (0 / 8 / 24)
  // ---------------------------------------------------------------------------
  // overflowButtonSpacing is the vertical gap between buttons after they
  // overflow into a stacked column. Three side-by-side narrow ButtonBars
  // with identical content but different spacing values demonstrate the
  // effect.
  // ===========================================================================
  Widget overflowSpacingBar(double spacing) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: overflowSpacingAccent.withOpacity(0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'spacing=$spacing',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: 180,
              child: ButtonBarTheme(
                data: const ButtonBarThemeData(
                  alignment: MainAxisAlignment.end,
                ),
                child: ButtonBar(
                  overflowButtonSpacing: spacing,
                  children: [
                    ElevatedButton(
                        onPressed: () => print('overflowSp/$spacing/save'),
                        child: const Text('SAVE CHANGES')),
                    TextButton(
                        onPressed: () =>
                            print('overflowSp/$spacing/discard'),
                        child: const Text('DISCARD')),
                    TextButton(
                        onPressed: () =>
                            print('overflowSp/$spacing/cancel'),
                        child: const Text('CANCEL')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOverflowSpacingCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
      decoration: BoxDecoration(
        color: overflowSpacingBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: overflowSpacingAccent.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '8. overflowButtonSpacing - 0 / 8 / 24',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: overflowSpacingAccent,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'When a ButtonBar overflows vertically the gap between stacked '
            'children is the bar overflowButtonSpacing. In this Flutter '
            'version the field lives on the ButtonBar constructor itself '
            '(it is not part of ButtonBarThemeData) - so the surrounding '
            'theme keeps alignment, while each ButtonBar passes its own '
            'spacing value. The three columns below differ only in that '
            'argument.',
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              overflowSpacingBar(0),
              overflowSpacingBar(8),
              overflowSpacingBar(24),
            ],
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 9 - REALISTIC DIALOG FOOTERS
  // ---------------------------------------------------------------------------
  // Three faux dialogs, each with its own ButtonBarTheme that matches the
  // dialog's purpose. The themes here showcase how the same set of fields
  // combine to give very different visual signatures:
  //
  //   * Confirm dialog: end-aligned, standard padding, primary text theme.
  //   * Discard / save / save-as: end-aligned, slightly tighter, accent
  //     text theme so the destructive button stands out.
  //   * Three-button confirm: spaceBetween so the destructive button sits
  //     on the far left and primary on the far right with neutral in the
  //     middle.
  // ===========================================================================
  Widget fauxDialog({
    required String title,
    required String message,
    required ButtonBarThemeData theme,
    required List<Widget> actions,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 6),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 14),
            child: Text(
              message,
              style: const TextStyle(fontSize: 13, height: 1.4),
            ),
          ),
          const Divider(height: 1),
          ButtonBarTheme(
            data: theme,
            child: ButtonBar(children: actions),
          ),
        ],
      ),
    );
  }

  Widget buildDialogCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
      decoration: BoxDecoration(
        color: dialogBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: dialogAccent.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '9. Realistic dialog footers',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: dialogAccent,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Three faux dialogs - each one wraps its actions footer in a '
            'specific ButtonBarTheme so the resulting look is bespoke yet '
            'driven entirely by the inherited theme.',
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 10),
          fauxDialog(
            title: 'Save your work?',
            message: 'You have unsaved changes in this document. Save them '
                'before closing?',
            theme: const ButtonBarThemeData(
              alignment: MainAxisAlignment.end,
              buttonPadding: EdgeInsets.symmetric(horizontal: 20),
              buttonTextTheme: ButtonTextTheme.primary,
            ),
            actions: [
              TextButton(
                  onPressed: () => print('dialog/save?/cancel'),
                  child: const Text('CANCEL')),
              ElevatedButton(
                  onPressed: () => print('dialog/save?/save'),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: dialogAccent),
                  child: const Text('SAVE',
                      style: TextStyle(color: Colors.white))),
            ],
          ),
          fauxDialog(
            title: 'Unsaved changes',
            message: 'Discard, save, or save a copy of this document?',
            theme: const ButtonBarThemeData(
              alignment: MainAxisAlignment.end,
              buttonPadding: EdgeInsets.symmetric(horizontal: 14),
              buttonTextTheme: ButtonTextTheme.accent,
            ),
            actions: [
              TextButton(
                  onPressed: () => print('dialog/discard'),
                  child: const Text('DISCARD',
                      style: TextStyle(color: Colors.redAccent))),
              TextButton(
                  onPressed: () => print('dialog/saveAs'),
                  child: const Text('SAVE AS')),
              ElevatedButton(
                  onPressed: () => print('dialog/save'),
                  child: const Text('SAVE')),
            ],
          ),
          fauxDialog(
            title: 'Permanently delete?',
            message: 'This action cannot be undone. The destructive button '
                'sits on the far left, neutral in the middle, primary on '
                'the right - all driven by spaceBetween alignment.',
            theme: const ButtonBarThemeData(
              alignment: MainAxisAlignment.spaceBetween,
              buttonPadding: EdgeInsets.symmetric(horizontal: 12),
            ),
            actions: [
              TextButton(
                  onPressed: () => print('dialog/delete/delete'),
                  child: const Text('DELETE',
                      style: TextStyle(color: Colors.redAccent))),
              TextButton(
                  onPressed: () => print('dialog/delete/archive'),
                  child: const Text('ARCHIVE')),
              ElevatedButton(
                  onPressed: () => print('dialog/delete/cancel'),
                  child: const Text('CANCEL')),
            ],
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 10 - READ-BACK CARD (calls ButtonBarTheme.of(context))
  // ---------------------------------------------------------------------------
  // We put a ButtonBarTheme(data:...) above a Builder. The Builder calls
  // ButtonBarTheme.of(context) and then prints every resolved field next to
  // a live ButtonBar that uses the same theme. This is the most pragmatic
  // proof that ButtonBarTheme.of(context) is what ButtonBar reads.
  // ===========================================================================
  Widget buildReadbackCard() {
    final demoTheme = const ButtonBarThemeData(
      alignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      buttonTextTheme: ButtonTextTheme.primary,
      buttonMinWidth: 88,
      buttonHeight: 40,
      buttonPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      buttonAlignedDropdown: false,
      layoutBehavior: ButtonBarLayoutBehavior.padded,
      overflowDirection: VerticalDirection.down,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
      decoration: BoxDecoration(
        color: readbackBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: readbackAccent.withOpacity(0.35)),
      ),
      child: ButtonBarTheme(
        data: demoTheme,
        child: Builder(builder: (ctx) {
          final resolved = ButtonBarTheme.of(ctx);
          final lines = <Widget>[];
          lines.add(Text(
            'alignment            = ${resolved.alignment}',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          ));
          lines.add(Text(
            'mainAxisSize         = ${resolved.mainAxisSize}',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          ));
          lines.add(Text(
            'buttonTextTheme      = ${resolved.buttonTextTheme}',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          ));
          lines.add(Text(
            'buttonMinWidth       = ${resolved.buttonMinWidth}',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          ));
          lines.add(Text(
            'buttonHeight         = ${resolved.buttonHeight}',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          ));
          lines.add(Text(
            'buttonPadding        = ${resolved.buttonPadding}',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          ));
          lines.add(Text(
            'buttonAlignedDropdown= ${resolved.buttonAlignedDropdown}',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          ));
          lines.add(Text(
            'layoutBehavior       = ${resolved.layoutBehavior}',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          ));
          lines.add(Text(
            'overflowDirection    = ${resolved.overflowDirection}',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          ));
          lines.add(const Text(
            'overflowButtonSpacing= (lives on ButtonBar, not ThemeData)',
            style: TextStyle(fontFamily: 'monospace', fontSize: 12),
          ));

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                '10. Read-back card - ButtonBarTheme.of(context)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: readbackAccent,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Below: every field of the surrounding ButtonBarThemeData, '
                'read back through ButtonBarTheme.of(context) inside a '
                'Builder. The live ButtonBar at the bottom is rendered '
                'inside the same context and therefore inherits exactly '
                'these values.',
                style: TextStyle(fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: readbackAccent.withOpacity(0.25)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: lines,
                ),
              ),
              const SizedBox(height: 12),
              ButtonBar(
                children: [
                  TextButton(
                      onPressed: () => print('readback/cancel'),
                      child: const Text('CANCEL')),
                  TextButton(
                      onPressed: () => print('readback/discard'),
                      child: const Text('DISCARD')),
                  ElevatedButton(
                      onPressed: () => print('readback/save'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: readbackAccent),
                      child: const Text('SAVE',
                          style: TextStyle(color: Colors.white))),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }

  // ===========================================================================
  // SECTION 11 - REFERENCE CARD - every ButtonBarThemeData field
  // ---------------------------------------------------------------------------
  // Compact prose reference. Each row is one field, the type, and a one
  // line meaning. This card uses no live buttons - it is the textual
  // appendix to the visual gallery above.
  // ===========================================================================
  Widget refRow(String name, String type, String meaning) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: Text(
              type,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(
              meaning,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildReferenceCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
      decoration: BoxDecoration(
        color: referenceBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: referenceAccent.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '11. Reference - every ButtonBarThemeData field',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: referenceAccent,
            ),
          ),
          const SizedBox(height: 8),
          refRow('alignment', 'MainAxisAlignment?',
              'Where the buttons sit along the main axis. Defaults to MainAxisAlignment.end.'),
          refRow('mainAxisSize', 'MainAxisSize?',
              'Whether the bar stretches to fill its parent (max) or hugs its children (min).'),
          refRow('buttonTextTheme', 'ButtonTextTheme?',
              'Legacy text-colour enum forwarded to the ButtonTheme around the children.'),
          refRow('buttonMinWidth', 'double?',
              'Minimum width for legacy Material buttons inside the bar.'),
          refRow('buttonHeight', 'double?',
              'Fixed height applied to legacy Material buttons inside the bar.'),
          refRow('buttonPadding', 'EdgeInsetsGeometry?',
              'Internal padding for legacy Material buttons inside the bar.'),
          refRow('buttonAlignedDropdown', 'bool?',
              'If true, dropdowns inside legacy buttons share the bar alignment.'),
          refRow('layoutBehavior', 'ButtonBarLayoutBehavior?',
              'padded = comfortable height; constrained = 52px tight constraint used by AlertDialog.'),
          refRow('overflowDirection', 'VerticalDirection?',
              'When the bar overflows, primary action is on top (down) or bottom (up).'),
          const SizedBox(height: 6),
          const Text(
            'Related field on ButtonBar itself (not on ButtonBarThemeData '
            'in this Flutter version):',
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
          refRow('ButtonBar.overflowButtonSpacing', 'double?',
              'Vertical gap between stacked buttons after overflow. Pass on the bar.'),
          const SizedBox(height: 12),
          const Text(
            'Resolution sequence inside ButtonBar:',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(height: 4),
          const Text(
            '  field = constructor.field ?? ButtonBarTheme.of(context).field '
            '?? hard-coded default',
            style: TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
          const SizedBox(height: 10),
          const Text(
            'Deprecation notice:',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(height: 4),
          const Text(
            'Both ButtonBar and ButtonBarTheme are deprecated in favour of '
            'OverflowBar / Wrap / Row. Existing AlertDialog actions still '
            'use them under the hood, so the theme remains functionally '
            'relevant for any code that targets standard Material dialogs.',
            style: TextStyle(fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // ROOT TREE
  // ---------------------------------------------------------------------------
  // The mandatory harness contract: MaterialApp -> Scaffold -> SafeArea ->
  // SingleChildScrollView -> Column. The Column children are the eleven
  // section cards built above, in order. We pad the outside by 16 logical
  // pixels so the tinted cards never touch the screen edges.
  // ===========================================================================
  return MaterialApp(
    title: 'ButtonBarTheme Deep Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.deepPurple,
      buttonBarTheme: const ButtonBarThemeData(
        alignment: MainAxisAlignment.end,
        buttonTextTheme: ButtonTextTheme.primary,
      ),
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('ButtonBarTheme deep demo'),
        backgroundColor: heroAccent,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildHeroCard(),
              buildAlignmentCard(),
              buildLayoutBehaviourCard(),
              buildMainAxisSizeCard(),
              buildMatrixCard(),
              buildButtonTextThemeCard(),
              buildOverflowDirectionCard(),
              buildOverflowSpacingCard(),
              buildDialogCard(),
              buildReadbackCard(),
              buildReferenceCard(),
              const SizedBox(height: 24),
              const Center(
                child: Text(
                  '-- end of ButtonBarTheme deep demo --',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}
