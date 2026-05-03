// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Live demo gallery - OverflowBar (modern ButtonBar) deep dive
// ----------------------------------------------------------------------------
// ButtonBar / ButtonBarTheme / ButtonBarThemeData are deprecated in current
// Flutter and ButtonBarThemeData has no usable bridge in d4rt. The modern
// equivalent is OverflowBar (from package:flutter/widgets.dart, re-exported by
// material), exposing alignment, overflowAlignment, overflowDirection,
// overflowSpacing, and spacing as direct constructor arguments. Per-child
// sizing that used to live in ButtonBarThemeData (buttonHeight, buttonMinWidth,
// buttonPadding, layoutBehavior) is expressed as ordinary SizedBox /
// ConstrainedBox / Padding wrappers. This script is a long-form gallery in
// eleven sections; each demonstrates one OverflowBar property or one
// wrapper-widget pattern that replaces a deprecated ButtonBarThemeData field.
// ----------------------------------------------------------------------------
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ===========================================================================
  // PROLOGUE - DIAGNOSTIC PRINTS
  // Note: ButtonBar and ButtonBarThemeData are deprecated; OverflowBar is the
  // modern equivalent. Each section demonstrates one OverflowBar property or
  // the wrapper-widget pattern that replaces a deprecated field.
  // ===========================================================================
  print('=== OverflowBar (modern ButtonBar) Deep Demo ===');
  print('Eleven sections, each pinned to one modern OverflowBar property or');
  print('one wrapper-widget pattern that replaces a deprecated');
  print('ButtonBarThemeData field.');
  print('Sections:');
  print('  1. Hero - what is OverflowBar (modern replacement for ButtonBar)');
  print('  2. Alignment sweep (OverflowBarAlignment + Row for space*)');
  print('  3. layoutBehavior replacement - ConstrainedBox per child');
  print('  4. mainAxisSize replacement - IntrinsicWidth wrap for min sizing');
  print('  5. buttonPadding x buttonMinWidth x buttonHeight via wrappers');
  print('  6. buttonTextTheme - documented enum, default OverflowBar styling');
  print('  7. overflowDirection (down vs up) under narrow constraint');
  print('  8. overflowSpacing (0 / 8 / 24) - was overflowButtonSpacing');
  print('  9. Realistic dialog footers themed via OverflowBar');
  print(' 10. Read-back card showing OverflowBar argument values directly');
  print(' 11. Reference card listing every OverflowBar property + wrappers');

  // ===========================================================================
  // PALETTE - DISTINCT TINT PER SECTION
  // ---------------------------------------------------------------------------
  // Each section has its own background tint and accent. The tints stay light
  // so the tinted card never overpowers the actual OverflowBar inside it. The
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
  // HERO CARD - WHAT IS OverflowBar
  // Plain prose explanation of the modern replacement for the deprecated
  // ButtonBar / ButtonBarTheme / ButtonBarThemeData triple plus a live
  // end-aligned OverflowBar with pre-padded children at the bottom.
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
            '1. OverflowBar - the modern replacement for ButtonBar',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: heroAccent,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'OverflowBar is the modern Flutter widget that replaces the '
            'deprecated ButtonBar / ButtonBarTheme / ButtonBarThemeData '
            'triple. Where the legacy theme propagated alignment, '
            'mainAxisSize, layoutBehavior and a host of button-sizing fields '
            'invisibly through an InheritedTheme, OverflowBar exposes the '
            'few orthogonal layout knobs (alignment, overflowAlignment, '
            'overflowDirection, overflowSpacing, spacing) directly on the '
            'constructor and pushes per-child sizing back to ordinary '
            'wrapper widgets (SizedBox, Padding, ConstrainedBox).',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 12),
          const Text(
            'How each deprecated field maps to a modern construct:',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          const Text('  alignment            -> OverflowBar.alignment (enum)'),
          const Text('  overflowDirection    -> OverflowBar.overflowDirection'),
          const Text('  overflowButtonSpacing-> OverflowBar.overflowSpacing'),
          const Text('  buttonMinWidth       -> SizedBox(width: ...) per kid'),
          const Text('  buttonHeight         -> SizedBox(height: ...) per kid'),
          const Text('  buttonPadding        -> Padding(padding: ...) per kid'),
          const Text('  layoutBehavior       -> ConstrainedBox per kid'),
          const Text('  mainAxisSize.min     -> wrap OverflowBar in IntrinsicWidth'),
          const SizedBox(height: 14),
          OverflowBar(
            alignment: MainAxisAlignment.end,
            spacing: 8,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextButton(
                    onPressed: () => print('hero/cancel'),
                    child: const Text('CANCEL')),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ElevatedButton(
                    onPressed: () => print('hero/save'),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: heroAccent),
                    child: const Text('SAVE',
                        style: TextStyle(color: Colors.white))),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 2 - ALIGNMENT SWEEP
  // Three rows use OverflowBarAlignment (start/end/center). The remaining
  // two (spaceBetween, spaceAround) have no direct OverflowBar equivalent;
  // OverflowBar replaces those with center-alignment, so we render them with
  // a Row + MainAxisAlignment value for the legacy effect.
  // ===========================================================================
  Widget alignmentRowOverflow(String label, OverflowBarAlignment alignment) {
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
            child: OverflowBar(
              alignment: _overflowToMain(alignment),
              spacing: 8,
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
        ],
      ),
    );
  }

  Widget alignmentRowSpace(String label, MainAxisAlignment alignment) {
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
            child: Row(
              mainAxisAlignment: alignment,
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
            '2. Alignment sweep - five legacy MainAxisAlignment values',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: alignAccent,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Same two buttons, five layouts. The first three rows use '
            'OverflowBarAlignment.start / end / center directly. OverflowBar '
            'replaces spaceBetween / spaceAround with center-alignment; use '
            'Row + MainAxisAlignment for ButtonBar\'s space distributions.',
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 10),
          alignmentRowOverflow('start', OverflowBarAlignment.start),
          alignmentRowOverflow('end', OverflowBarAlignment.end),
          alignmentRowOverflow('center', OverflowBarAlignment.center),
          alignmentRowSpace('spaceBetween', MainAxisAlignment.spaceBetween),
          alignmentRowSpace('spaceAround', MainAxisAlignment.spaceAround),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 3 - layoutBehavior replacement (ConstrainedBox per child)
  // ButtonBarThemeData.layoutBehavior used to choose padded vs constrained.
  // OverflowBar has no equivalent: push the constraint onto each child via a
  // ConstrainedBox wrapper. Two OverflowBars demonstrate the two behaviours.
  // ===========================================================================
  Widget layoutBehaviourBar(String label, bool constrained) {
    final children = <Widget>[
      TextButton(
          onPressed: () => print('layout/$label/cancel'),
          child: const Text('CANCEL')),
      ElevatedButton(
          onPressed: () => print('layout/$label/save'),
          child: const Text('SAVE')),
    ];
    final wrapped = constrained
        ? children
            .map((c) => ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 64),
                  child: c,
                ))
            .toList()
        : children;
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
            OverflowBar(
              alignment: MainAxisAlignment.end,
              spacing: 8,
              children: wrapped,
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
            '3. layoutBehavior replacement - per-child ConstrainedBox',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: layoutAccent,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'The deprecated ButtonBarThemeData.layoutBehavior switched between '
            'padded (comfortable) and constrained (52-density). OverflowBar '
            'has no equivalent: constraints are pushed onto each child via a '
            'ConstrainedBox wrapper. The right column wraps each button in a '
            'ConstrainedBox(minWidth: 64); the left column shows the default.',
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              layoutBehaviourBar('padded (default)', false),
              layoutBehaviourBar('constrained (minW64)', true),
            ],
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 4 - mainAxisSize replacement (IntrinsicWidth wrap)
  // OverflowBar has no mainAxisSize property: max is default; min is
  // replicated by wrapping the OverflowBar in IntrinsicWidth.
  // ===========================================================================
  Widget mainAxisSizeBar(String label, bool minSizing) {
    final bar = OverflowBar(
      alignment: MainAxisAlignment.end,
      spacing: 8,
      children: [
        TextButton(
            onPressed: () => print('axis/$label/cancel'),
            child: const Text('CANCEL')),
        ElevatedButton(
            onPressed: () => print('axis/$label/save'),
            child: const Text('SAVE')),
      ],
    );
    final aligned = minSizing
        ? Align(
            alignment: Alignment.centerLeft,
            child: IntrinsicWidth(child: bar),
          )
        : bar;
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
            child: aligned,
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
            '4. mainAxisSize replacement - IntrinsicWidth wrap',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: axisAccent,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'The thin outlined Box around each OverflowBar is *not* part of '
            'any theme - it is a visual aid that hugs whatever main axis the '
            'bar reports. With IntrinsicWidth (mimicking mainAxisSize.min) '
            'the outline collapses around the children; without it (the '
            'OverflowBar default) it stretches edge-to-edge.',
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 4),
          mainAxisSizeBar('mainAxisSize.max (default)', false),
          mainAxisSizeBar('mainAxisSize.min (IntrinsicWidth)', true),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 5 - buttonPadding x buttonMinWidth x buttonHeight via wrappers
  // 3x3 grid: rows vary per-child Padding, columns vary per-child SizedBox
  // width, each cell rotates a SizedBox height. Wrapper-widget equivalent of
  // the deprecated ButtonBarThemeData (buttonPadding, buttonMinWidth,
  // buttonHeight) triple.
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

  Widget wrapKid(Widget kid, EdgeInsets padding, double minWidth, double h) {
    return Padding(
      padding: padding,
      child: SizedBox(
        width: minWidth,
        height: h,
        child: kid,
      ),
    );
  }

  Widget matrixCell(EdgeInsets padding, double minWidth, double height,
      String caption) {
    final cancel = TextButton(
        onPressed: () => print('matrix/$caption/cancel'),
        child: const Text('CANCEL'));
    final ok = ElevatedButton(
        onPressed: () => print('matrix/$caption/ok'),
        child: const Text('OK'));
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
          OverflowBar(
            alignment: MainAxisAlignment.start,
            spacing: 4,
            children: [
              wrapKid(cancel, padding, minWidth, height),
              wrapKid(ok, padding, minWidth, height),
            ],
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
            '5. buttonPadding x buttonMinWidth x buttonHeight (via wrappers)',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: matrixAccent,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'A 3x3 grid varying per-child Padding (rows) and per-child '
            'SizedBox.width (columns), with a rotating SizedBox.height per '
            'cell. These three legacy ButtonBarThemeData fields '
            '(buttonPadding, buttonMinWidth, buttonHeight) are now expressed '
            'as ordinary wrapper widgets around each OverflowBar child, '
            'which makes the sizing local and explicit.',
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 10),
          ...rows,
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 6 - buttonTextTheme (documented enum, default OverflowBar)
  // OverflowBar has no equivalent for the legacy ButtonTextTheme enum;
  // modern code uses ButtonStyle. Each row labels the legacy enum value and
  // renders a default-styled OverflowBar.
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
            '$label  (ButtonTextTheme.${theme.name})',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          OverflowBar(
            alignment: MainAxisAlignment.start,
            spacing: 8,
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
            '6. buttonTextTheme - normal / accent / primary (label-only)',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textThemeAccent,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'ButtonTextTheme is the legacy enum that drove the deprecated '
            'RaisedButton / FlatButton text colour. OverflowBar has no '
            'equivalent: modern code styles each button via ButtonStyle or a '
            'surrounding Theme. We label each row with the legacy enum value '
            'and render an OverflowBar with default button styling.',
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
  // OverflowBar.overflowDirection controls whether the first child stays on
  // top (down) or moves to the bottom (up) when the bar overflows. We force
  // overflow with a SizedBox(width: 200) and four chunky-labelled buttons.
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
              child: OverflowBar(
                alignment: MainAxisAlignment.end,
                overflowDirection: direction,
                spacing: 8,
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
            'Each OverflowBar is constrained to 200 logical pixels and given '
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
  // SECTION 8 - overflowSpacing (0 / 8 / 24)
  // OverflowBar.overflowSpacing is the modern name for the legacy
  // ButtonBar.overflowButtonSpacing: vertical gap between stacked children
  // after overflow. Three narrow OverflowBars demonstrate the effect.
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
              child: OverflowBar(
                alignment: MainAxisAlignment.end,
                overflowSpacing: spacing,
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
            '8. overflowSpacing - 0 / 8 / 24 (was overflowButtonSpacing)',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: overflowSpacingAccent,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'When an OverflowBar overflows vertically the gap between '
            'stacked children is OverflowBar.overflowSpacing. The legacy '
            'name on ButtonBar was overflowButtonSpacing; the modern '
            'OverflowBar name is overflowSpacing. The three columns below '
            'differ only in that argument.',
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
  // Three faux dialogs: confirm (end-aligned OverflowBar, generous spacing),
  // discard/save/save-as (end-aligned, tighter, destructive accented), and
  // a three-button confirm using Row + spaceBetween (no direct OverflowBar
  // equivalent for the legacy alignment.spaceBetween value).
  // ===========================================================================
  Widget fauxDialog({
    required String title,
    required String message,
    required Widget footer,
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
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 6, 12, 8),
            child: footer,
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
            'Three faux dialogs - each one configures its OverflowBar (or, '
            'for spaceBetween, a plain Row) so the resulting look is bespoke '
            'yet driven entirely by direct constructor arguments.',
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 10),
          fauxDialog(
            title: 'Save your work?',
            message: 'You have unsaved changes in this document. Save them '
                'before closing?',
            footer: OverflowBar(
              alignment: MainAxisAlignment.end,
              spacing: 12,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: TextButton(
                      onPressed: () => print('dialog/save?/cancel'),
                      child: const Text('CANCEL')),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ElevatedButton(
                      onPressed: () => print('dialog/save?/save'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: dialogAccent),
                      child: const Text('SAVE',
                          style: TextStyle(color: Colors.white))),
                ),
              ],
            ),
          ),
          fauxDialog(
            title: 'Unsaved changes',
            message: 'Discard, save, or save a copy of this document?',
            footer: OverflowBar(
              alignment: MainAxisAlignment.end,
              spacing: 8,
              children: [
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
          ),
          fauxDialog(
            title: 'Permanently delete?',
            message: 'This action cannot be undone. The destructive button '
                'sits on the far left, neutral in the middle, primary on '
                'the right - all driven by Row + MainAxisAlignment.spaceBetween '
                '(OverflowBar has no equivalent for the spaceBetween value).',
            footer: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 10 - READ-BACK CARD (direct OverflowBar argument values)
  // OverflowBar takes its configuration directly via constructor arguments,
  // so there is no .of(context) call to make. We declare the values used to
  // build the OverflowBar at the bottom and render them in monospace.
  // ===========================================================================
  Widget buildReadbackCard() {
    const alignment = MainAxisAlignment.end;
    const overflowAlignment = OverflowBarAlignment.end;
    const overflowDirection = VerticalDirection.down;
    const spacing = 12.0;
    const overflowSpacing = 8.0;
    const buttonMinWidth = 88.0;
    const buttonHeight = 40.0;
    const buttonPadding = EdgeInsets.symmetric(horizontal: 18, vertical: 6);

    final lines = <Widget>[
      const Text(
        'alignment            = MainAxisAlignment.end',
        style: TextStyle(fontFamily: 'monospace', fontSize: 12),
      ),
      const Text(
        'overflowAlignment    = OverflowBarAlignment.end',
        style: TextStyle(fontFamily: 'monospace', fontSize: 12),
      ),
      const Text(
        'overflowDirection    = VerticalDirection.down',
        style: TextStyle(fontFamily: 'monospace', fontSize: 12),
      ),
      const Text(
        'spacing              = 12.0',
        style: TextStyle(fontFamily: 'monospace', fontSize: 12),
      ),
      const Text(
        'overflowSpacing      = 8.0  (was overflowButtonSpacing)',
        style: TextStyle(fontFamily: 'monospace', fontSize: 12),
      ),
      const Text(
        'per-child SizedBox.width  = 88.0  (was buttonMinWidth)',
        style: TextStyle(fontFamily: 'monospace', fontSize: 12),
      ),
      const Text(
        'per-child SizedBox.height = 40.0  (was buttonHeight)',
        style: TextStyle(fontFamily: 'monospace', fontSize: 12),
      ),
      const Text(
        'per-child Padding         = EdgeInsets.symmetric(h:18, v:6)',
        style: TextStyle(fontFamily: 'monospace', fontSize: 12),
      ),
      const Text(
        'buttonAlignedDropdown     = (no OverflowBar equivalent; legacy)',
        style: TextStyle(fontFamily: 'monospace', fontSize: 12),
      ),
      const Text(
        'layoutBehavior            = (no OverflowBar equivalent; use '
        'ConstrainedBox per child)',
        style: TextStyle(fontFamily: 'monospace', fontSize: 12),
      ),
    ];

    Widget wrap(Widget kid) => Padding(
          padding: buttonPadding,
          child: SizedBox(
            width: buttonMinWidth,
            height: buttonHeight,
            child: kid,
          ),
        );

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
      decoration: BoxDecoration(
        color: readbackBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: readbackAccent.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '10. Read-back card - OverflowBar arguments laid bare',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: readbackAccent,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Below: the exact constructor arguments and per-child wrapper '
            'values used to build the OverflowBar at the bottom of this '
            'card. OverflowBar takes its configuration directly, so there '
            'is no .of(context) lookup - what you read here is what the bar '
            'sees at layout time.',
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
          OverflowBar(
            alignment: alignment,
            overflowAlignment: overflowAlignment,
            overflowDirection: overflowDirection,
            spacing: spacing,
            overflowSpacing: overflowSpacing,
            children: [
              wrap(TextButton(
                  onPressed: () => print('readback/cancel'),
                  child: const Text('CANCEL'))),
              wrap(TextButton(
                  onPressed: () => print('readback/discard'),
                  child: const Text('DISCARD'))),
              wrap(ElevatedButton(
                  onPressed: () => print('readback/save'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: readbackAccent),
                  child: const Text('SAVE',
                      style: TextStyle(color: Colors.white)))),
            ],
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 11 - REFERENCE CARD - every OverflowBar property + wrapper map
  // Compact prose reference: one row per OverflowBar property or wrapper
  // pattern that replaces a deprecated ButtonBarThemeData field.
  // ===========================================================================
  Widget refRow(String name, String type, String meaning) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 220,
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
            '11. Reference - every OverflowBar property + wrapper map',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: referenceAccent,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Direct OverflowBar constructor properties:',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(height: 4),
          refRow('OverflowBar.alignment', 'MainAxisAlignment?',
              'Alignment of children when laid out as a row (start/end/center).'),
          refRow('OverflowBar.overflowAlignment', 'OverflowBarAlignment?',
              'Cross-axis alignment when children overflow into a stacked column.'),
          refRow('OverflowBar.overflowDirection', 'VerticalDirection?',
              'When the bar overflows, primary action is on top (down) or bottom (up).'),
          refRow('OverflowBar.spacing', 'double?',
              'Horizontal gap between children when laid out as a row.'),
          refRow('OverflowBar.overflowSpacing', 'double?',
              'Vertical gap between stacked children after overflow. Was overflowButtonSpacing on ButtonBar.'),
          refRow('OverflowBar.children', 'List<Widget>',
              'Children to lay out (typically buttons).'),
          const SizedBox(height: 10),
          const Text(
            'Wrapper-widget patterns replacing deprecated '
            'ButtonBarThemeData fields:',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(height: 4),
          refRow('buttonMinWidth          ->', 'SizedBox(width: ...)',
              'Wrap each child in a SizedBox with the desired minimum width.'),
          refRow('buttonHeight            ->', 'SizedBox(height: ...)',
              'Wrap each child in a SizedBox with the desired height.'),
          refRow('buttonPadding           ->', 'Padding(padding: ...)',
              'Wrap each child in a Padding with the desired internal padding.'),
          refRow('layoutBehavior          ->', 'ConstrainedBox(...)',
              'Wrap each child in a ConstrainedBox to mimic the constrained tight layout.'),
          refRow('mainAxisSize.min        ->', 'IntrinsicWidth(...)',
              'Wrap the OverflowBar in IntrinsicWidth to hug its children.'),
          refRow('buttonTextTheme         ->', 'ButtonStyle / Theme',
              'No OverflowBar equivalent; style each button individually.'),
          refRow('buttonAlignedDropdown   ->', '(no equivalent)',
              'Legacy DropdownButton affordance; no parallel in OverflowBar.'),
          refRow('alignment.spaceBetween  ->', 'Row + MainAxisAlignment',
              'OverflowBar.alignment only supports start/end/center; use a Row for space distributions.'),
          refRow('alignment.spaceAround   ->', 'Row + MainAxisAlignment',
              'OverflowBar.alignment only supports start/end/center; use a Row for space distributions.'),
          const SizedBox(height: 12),
          const Text(
            'Layout behaviour summary:',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(height: 4),
          const Text(
            '  if (children fit horizontally) -> Row using alignment + spacing',
            style: TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
          const Text(
            '  else -> Column using overflowAlignment + overflowDirection + '
            'overflowSpacing',
            style: TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
          const SizedBox(height: 10),
          const Text(
            'Deprecation notice:',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(height: 4),
          const Text(
            'ButtonBar / ButtonBarTheme / ButtonBarThemeData are deprecated '
            'in current Flutter. Existing AlertDialog actions still rely on '
            'OverflowBar internally, so the modern OverflowBar is what new '
            'code should target directly.',
            style: TextStyle(fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // ROOT TREE
  // MaterialApp -> Scaffold -> SafeArea -> SingleChildScrollView -> Column.
  // ===========================================================================
  return MaterialApp(
    title: 'OverflowBar Deep Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.deepPurple,
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('OverflowBar (modern ButtonBar) deep demo'),
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
                  '-- end of OverflowBar deep demo --',
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

// Map an OverflowBarAlignment value into the MainAxisAlignment that
// OverflowBar.alignment expects. OverflowBar's `alignment` is typed as
// MainAxisAlignment, and only start/end/center are meaningful for it; we
// preserve the named-by-OverflowBarAlignment intent at the call sites in
// section 2 by going through this small adapter.
MainAxisAlignment _overflowToMain(OverflowBarAlignment value) {
  switch (value) {
    case OverflowBarAlignment.start:
      return MainAxisAlignment.start;
    case OverflowBarAlignment.end:
      return MainAxisAlignment.end;
    case OverflowBarAlignment.center:
      return MainAxisAlignment.center;
  }
}
