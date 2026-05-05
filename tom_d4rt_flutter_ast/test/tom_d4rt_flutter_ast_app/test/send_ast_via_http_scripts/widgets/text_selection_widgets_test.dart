// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep visual demo: Text selection theming.
// Covers TextSelectionThemeData (cursorColor / selectionColor /
// selectionHandleColor), the TextSelectionTheme InheritedWidget wrapper,
// the TextSelectionHandleType enum (left/right/collapsed), and a static
// mock of TextSelectionToolbar styling. Also contrasts text selection
// theming with TextStyle (typography vs interaction chrome).
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextSelection deep-visual demo executing');

  // Unique palette for this demo: deep ink + saffron accents over warm cream.
  const Color paperBg = Color(0xFFFBF6EC);
  const Color inkBg = Color(0xFF1F2933);
  const Color paperFg = Color(0xFF1F2933);
  const Color inkFg = Color(0xFFFBF6EC);
  const Color accentSaffron = Color(0xFFE8A33D);
  const Color accentRose = Color(0xFFC2185B);
  const Color accentTeal = Color(0xFF00897B);
  const Color accentIndigo = Color(0xFF3949AB);
  const Color accentForest = Color(0xFF2E7D32);
  const Color accentPlum = Color(0xFF6A1B9A);
  const Color accentSlate = Color(0xFF455A64);
  const Color hairline = Color(0xFFD7CFBE);

  // ========== TextSelectionHandleType ==========
  print('--- TextSelectionHandleType enum ---');
  final List<TextSelectionHandleType> handleTypes = <TextSelectionHandleType>[];
  for (int i = 0; i < TextSelectionHandleType.values.length; i++) {
    final TextSelectionHandleType t = TextSelectionHandleType.values[i];
    handleTypes.add(t);
    print('  [$i] ${t.name} -> index=${t.index}');
  }

  // ========== TextSelectionThemeData base palette ==========
  print('--- TextSelectionThemeData base ---');
  TextSelectionThemeData? baseData;
  try {
    baseData = TextSelectionThemeData(
      cursorColor: accentSaffron,
      selectionColor: accentSaffron.withValues(alpha: 0.32),
      selectionHandleColor: accentSaffron,
    );
    print('  base data: $baseData');
  } catch (e) {
    print('  ERR base data: $e');
  }

  // Default empty theme data (all nulls — falls back to platform defaults).
  TextSelectionThemeData? emptyData;
  try {
    emptyData = const TextSelectionThemeData();
    print('  empty data cursor: ${emptyData.cursorColor}');
    print('  empty data selection: ${emptyData.selectionColor}');
    print('  empty data handle: ${emptyData.selectionHandleColor}');
  } catch (e) {
    print('  ERR empty data: $e');
  }

  // copyWith — selectively override one field.
  TextSelectionThemeData? copiedData;
  try {
    copiedData = baseData?.copyWith(cursorColor: accentRose);
    print('  copyWith cursor: ${copiedData?.cursorColor}');
  } catch (e) {
    print('  ERR copyWith: $e');
  }

  // lerp halfway between base and empty.
  TextSelectionThemeData? lerped;
  try {
    lerped = TextSelectionThemeData.lerp(baseData, emptyData, 0.5);
    print('  lerp 0.5 cursor: ${lerped?.cursorColor}');
  } catch (e) {
    print('  ERR lerp: $e');
  }

  // Edge case: fully transparent selection color.
  TextSelectionThemeData? ghostData;
  try {
    ghostData = const TextSelectionThemeData(
      cursorColor: accentRose,
      selectionColor: Color(0x00000000),
      selectionHandleColor: accentRose,
    );
    print('  ghost selection alpha: ${ghostData.selectionColor?.a}');
  } catch (e) {
    print('  ERR ghost: $e');
  }

  // Plumbed via Theme.of(context).textSelectionTheme — read current.
  try {
    final TextSelectionThemeData inherited =
        Theme.of(context).textSelectionTheme;
    print('  inherited cursor: ${inherited.cursorColor}');
  } catch (e) {
    print('  ERR inherited: $e');
  }

  // ---- helpers -------------------------------------------------------------

  Widget sectionHeader(String tag, String title, Color accent) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
      decoration: BoxDecoration(
        color: paperBg,
        border: Border(left: BorderSide(color: accent, width: 5.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            tag,
            style: TextStyle(
              color: accent,
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.6,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            title,
            style: const TextStyle(
              color: paperFg,
              fontSize: 19.0,
              fontWeight: FontWeight.w800,
              height: 1.15,
            ),
          ),
        ],
      ),
    );
  }

  Widget chip(String label, Color bg, Color fg) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(99.0),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontSize: 11.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }

  Widget swatch(Color c, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 18.0,
          height: 18.0,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: hairline, width: 1.0),
          ),
        ),
        const SizedBox(width: 6.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11.0,
            color: paperFg,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }

  // Hero header
  final Widget hero = Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(26.0, 32.0, 26.0, 28.0),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[inkBg, Color(0xFF323F4B), Color(0xFF52606D)],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            chip('FLUTTER · MATERIAL', accentSaffron, inkBg),
            const SizedBox(width: 8.0),
            chip('TEXT INPUT CHROME', inkFg.withValues(alpha: 0.15), inkFg),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text(
          'TextSelectionTheme',
          style: TextStyle(
            color: inkFg,
            fontSize: 34.0,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.6,
            height: 1.05,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'Cursor, selection highlight, handle teardrops — a deep visual tour.',
          style: TextStyle(
            color: inkFg.withValues(alpha: 0.78),
            fontSize: 14.5,
            fontWeight: FontWeight.w400,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 18.0),
        Row(
          children: <Widget>[
            swatch(accentSaffron, 'cursor'),
            const SizedBox(width: 14.0),
            swatch(accentSaffron.withValues(alpha: 0.32), 'selection'),
            const SizedBox(width: 14.0),
            swatch(accentSaffron, 'handle'),
          ],
        ),
      ],
    ),
  );

  // ---- The Three Colors schematic -----------------------------------------

  Widget annotated(String label, Color dot, double left, double top) {
    return Positioned(
      left: left,
      top: top,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 10.0,
            height: 10.0,
            decoration: BoxDecoration(
              color: dot,
              shape: BoxShape.circle,
              border: Border.all(color: paperFg, width: 1.2),
            ),
          ),
          const SizedBox(width: 6.0),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: paperBg,
              border: Border.all(color: hairline, width: 1.0),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 10.5,
                color: paperFg,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget schematic = Container(
    margin: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 6.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: hairline, width: 1.0),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'The three colors',
          style: TextStyle(
            color: accentIndigo,
            fontSize: 12.0,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          height: 170.0,
          child: Stack(
            children: <Widget>[
              // Mock text editing area
              Positioned(
                left: 30.0,
                top: 50.0,
                right: 30.0,
                child: Container(
                  height: 60.0,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFDF7),
                    border: Border.all(color: hairline, width: 1.2),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: <Widget>[
                      // Selection highlight rectangle
                      Positioned(
                        left: 32.0,
                        top: 6.0,
                        width: 110.0,
                        height: 24.0,
                        child: Container(
                          color: accentSaffron.withValues(alpha: 0.32),
                        ),
                      ),
                      // Text baseline
                      const Padding(
                        padding: EdgeInsets.only(left: 4.0),
                        child: Text(
                          'edit · select · drag',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: paperFg,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                      // Cursor caret bar
                      Positioned(
                        left: 142.0,
                        top: 6.0,
                        child: Container(
                          width: 2.0,
                          height: 24.0,
                          color: accentSaffron,
                        ),
                      ),
                      // Left handle teardrop
                      Positioned(
                        left: 26.0,
                        top: 28.0,
                        child: Container(
                          width: 12.0,
                          height: 12.0,
                          decoration: BoxDecoration(
                            color: accentSaffron,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(99.0),
                              topRight: Radius.circular(99.0),
                              bottomRight: Radius.circular(99.0),
                            ),
                          ),
                        ),
                      ),
                      // Right handle teardrop
                      Positioned(
                        left: 138.0,
                        top: 28.0,
                        child: Container(
                          width: 12.0,
                          height: 12.0,
                          decoration: BoxDecoration(
                            color: accentSaffron,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(99.0),
                              topRight: Radius.circular(99.0),
                              bottomLeft: Radius.circular(99.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              annotated('cursorColor', accentSaffron, 200.0, 6.0),
              annotated(
                  'selectionColor',
                  accentSaffron.withValues(alpha: 0.32),
                  20.0,
                  6.0),
              annotated('selectionHandleColor', accentSaffron, 60.0, 130.0),
            ],
          ),
        ),
      ],
    ),
  );

  // ---- Field card factory --------------------------------------------------

  Widget fieldCard(String title, String hint, Color cursor, Color sel,
      Color handle, Color accent) {
    final TextSelectionThemeData local = TextSelectionThemeData(
      cursorColor: cursor,
      selectionColor: sel.withValues(alpha: 0.34),
      selectionHandleColor: handle,
    );
    Widget body;
    try {
      body = TextSelectionTheme(
        data: local,
        child: TextField(
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide(color: hairline, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide(color: hairline, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide(color: accent, width: 1.6),
            ),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 10.0, vertical: 10.0),
          ),
        ),
      );
    } catch (e) {
      body = Text('field err: $e');
    }
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: hairline, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8.0,
                height: 8.0,
                decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
              ),
              const SizedBox(width: 6.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w800,
                  color: paperFg,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          body,
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 6.0,
            runSpacing: 4.0,
            children: <Widget>[
              swatch(cursor, 'cur'),
              swatch(sel.withValues(alpha: 0.34), 'sel'),
              swatch(handle, 'hdl'),
            ],
          ),
        ],
      ),
    );
  }

  // 9-card grid of palettes
  final List<Widget> fieldCards = <Widget>[
    fieldCard('Saffron', 'lorem ipsum', accentSaffron, accentSaffron,
        accentSaffron, accentSaffron),
    fieldCard('Rose', 'dolor sit amet', accentRose, accentRose, accentRose,
        accentRose),
    fieldCard('Teal', 'consectetur', accentTeal, accentTeal, accentTeal,
        accentTeal),
    fieldCard('Indigo', 'adipiscing', accentIndigo, accentIndigo,
        accentIndigo, accentIndigo),
    fieldCard('Forest', 'elit sed do', accentForest, accentForest,
        accentForest, accentForest),
    fieldCard('Plum', 'eiusmod tempor', accentPlum, accentPlum, accentPlum,
        accentPlum),
    fieldCard('Slate', 'incididunt ut', accentSlate, accentSlate,
        accentSlate, accentSlate),
    fieldCard('Mixed A', 'cursor=rose, sel=teal', accentRose, accentTeal,
        accentIndigo, accentRose),
    fieldCard('Mixed B', 'handles=plum', accentForest, accentSaffron,
        accentPlum, accentForest),
  ];

  final List<Widget> gridRows = <Widget>[];
  for (int r = 0; r < 3; r++) {
    final List<Widget> rowChildren = <Widget>[];
    for (int c = 0; c < 3; c++) {
      final int idx = r * 3 + c;
      rowChildren.add(Expanded(child: fieldCards[idx]));
      if (c < 2) {
        rowChildren.add(const SizedBox(width: 10.0));
      }
    }
    gridRows.add(Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rowChildren,
    ));
    if (r < 2) {
      gridRows.add(const SizedBox(height: 10.0));
    }
  }

  final Widget fieldGrid = Container(
    margin: const EdgeInsets.fromLTRB(18.0, 8.0, 18.0, 8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: paperBg.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: hairline, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Nine TextSelectionTheme variants',
          style: TextStyle(
            color: accentRose,
            fontSize: 12.0,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 10.0),
        Column(children: gridRows),
      ],
    ),
  );

  // ---- Handle types gallery -----------------------------------------------

  Widget handleGlyph(TextSelectionHandleType t, Color c) {
    BorderRadius radius;
    if (t == TextSelectionHandleType.left) {
      radius = const BorderRadius.only(
        topLeft: Radius.circular(99.0),
        topRight: Radius.circular(99.0),
        bottomRight: Radius.circular(99.0),
      );
    } else if (t == TextSelectionHandleType.right) {
      radius = const BorderRadius.only(
        topLeft: Radius.circular(99.0),
        topRight: Radius.circular(99.0),
        bottomLeft: Radius.circular(99.0),
      );
    } else {
      radius = BorderRadius.circular(99.0);
    }
    return Container(
      width: 28.0,
      height: 28.0,
      decoration: BoxDecoration(color: c, borderRadius: radius),
    );
  }

  String handleDesc(TextSelectionHandleType t) {
    if (t == TextSelectionHandleType.left) {
      return 'Range start. Teardrop with rounded top + bottom-right.';
    }
    if (t == TextSelectionHandleType.right) {
      return 'Range end. Teardrop with rounded top + bottom-left.';
    }
    return 'Single cursor. Round dot below the caret.';
  }

  final List<Widget> handleCards = <Widget>[];
  for (int i = 0; i < handleTypes.length; i++) {
    final TextSelectionHandleType t = handleTypes[i];
    handleCards.add(Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: hairline, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              // mini caret
              Container(width: 2.0, height: 22.0, color: accentTeal),
              const SizedBox(width: 6.0),
              handleGlyph(t, accentTeal),
              const SizedBox(width: 10.0),
              Text(
                'TextSelectionHandleType.${t.name}',
                style: const TextStyle(
                  fontSize: 12.5,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w800,
                  color: paperFg,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            handleDesc(t),
            style: const TextStyle(
              fontSize: 12.0,
              color: paperFg,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            'index = ${t.index}',
            style: TextStyle(
              fontSize: 10.5,
              color: paperFg.withValues(alpha: 0.55),
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    ));
  }

  final Widget handlesGallery = Container(
    margin: const EdgeInsets.fromLTRB(18.0, 8.0, 18.0, 8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: hairline, width: 1.0),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'TextSelectionHandleType — visual semantics',
          style: TextStyle(
            color: accentTeal,
            fontSize: 12.0,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 10.0),
        Column(
          children: <Widget>[
            for (int i = 0; i < handleCards.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: handleCards[i],
              ),
          ],
        ),
      ],
    ),
  );

  // ---- Toolbar mock --------------------------------------------------------

  Widget toolbarButton(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      child: Text(
        label,
        style: const TextStyle(
          color: inkFg,
          fontSize: 13.5,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  final Widget toolbarMock = Container(
    margin: const EdgeInsets.fromLTRB(18.0, 8.0, 18.0, 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: paperBg,
      border: Border.all(color: hairline, width: 1.0),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Static TextSelectionToolbar mock',
          style: TextStyle(
            color: accentPlum,
            fontSize: 12.0,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 14.0),
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: inkBg,
              borderRadius: BorderRadius.circular(6.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 12.0,
                  offset: const Offset(0.0, 4.0),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                toolbarButton('Cut'),
                Container(width: 1.0, height: 22.0,
                    color: inkFg.withValues(alpha: 0.18)),
                toolbarButton('Copy'),
                Container(width: 1.0, height: 22.0,
                    color: inkFg.withValues(alpha: 0.18)),
                toolbarButton('Paste'),
                Container(width: 1.0, height: 22.0,
                    color: inkFg.withValues(alpha: 0.18)),
                toolbarButton('Select All'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        Text(
          'In real Flutter, the contextual toolbar is rendered by '
          'TextSelectionControls.buildToolbar / TextSelectionToolbar — '
          'shape, anchor, and arrow are derived from the selection.',
          style: TextStyle(
            color: paperFg.withValues(alpha: 0.7),
            fontSize: 12.0,
            height: 1.4,
          ),
        ),
      ],
    ),
  );

  // ---- Comparison: theme vs TextStyle -------------------------------------

  Widget compareRow(String left, String right, Color lColor, Color rColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 180.0,
            child: Text(
              left,
              style: TextStyle(
                color: lColor,
                fontSize: 12.5,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              right,
              style: TextStyle(
                color: rColor,
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget comparison = Container(
    margin: const EdgeInsets.fromLTRB(18.0, 8.0, 18.0, 8.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: hairline, width: 1.0),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Theme vs TextStyle (and the absence of a CursorTheme)',
          style: TextStyle(
            color: accentForest,
            fontSize: 12.0,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8.0),
        compareRow('TextStyle.color',
            'Glyph color of the *characters*. Has nothing to do with cursor or selection.',
            accentIndigo, paperFg),
        compareRow('TextSelectionThemeData.cursorColor',
            'The blinking caret bar. Plumbed via Theme.of(context).textSelectionTheme.',
            accentSaffron, paperFg),
        compareRow('TextSelectionThemeData.selectionColor',
            'Background highlight rectangle behind selected glyphs.',
            accentRose, paperFg),
        compareRow('TextSelectionThemeData.selectionHandleColor',
            'Color of the left/right teardrop handles and the collapsed dot.',
            accentTeal, paperFg),
        compareRow('CursorTheme',
            'Does not exist as a separate widget — cursor color lives inside TextSelectionThemeData.',
            accentPlum, paperFg),
      ],
    ),
  );

  // ---- Code cards ----------------------------------------------------------

  Widget codeCard(String title, String code, Color accent) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        color: inkBg,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.85),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11.0,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.0,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              code,
              style: TextStyle(
                color: inkFg.withValues(alpha: 0.92),
                fontSize: 12.0,
                fontFamily: 'monospace',
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget codeBlock = Container(
    margin: const EdgeInsets.fromLTRB(18.0, 8.0, 18.0, 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        codeCard(
            'APP-LEVEL THEME',
            'MaterialApp(\n'
                '  theme: ThemeData(\n'
                '    textSelectionTheme: TextSelectionThemeData(\n'
                '      cursorColor: Colors.amber,\n'
                '      selectionColor: Colors.amber.withOpacity(0.32),\n'
                '      selectionHandleColor: Colors.amber,\n'
                '    ),\n'
                '  ),\n'
                '  home: ...,\n'
                ');',
            accentSaffron),
        codeCard(
            'LOCAL OVERRIDE',
            'TextSelectionTheme(\n'
                '  data: const TextSelectionThemeData(\n'
                '    cursorColor: Color(0xFFC2185B),\n'
                '  ),\n'
                '  child: TextField(),\n'
                ');',
            accentRose),
        codeCard(
            'EDGE CASE: TRANSPARENT SELECTION',
            'const TextSelectionThemeData(\n'
                '  selectionColor: Color(0x00000000),\n'
                ');\n'
                '// Selection still works, just invisible.',
            accentSlate),
      ],
    ),
  );

  // ---- References ----------------------------------------------------------

  final List<List<String>> refs = <List<String>>[
    <String>[
      'TextSelectionThemeData',
      'Holds cursorColor, selectionColor, selectionHandleColor.'
    ],
    <String>[
      'TextSelectionTheme',
      'InheritedWidget that scopes a TextSelectionThemeData.'
    ],
    <String>[
      'TextSelectionHandleType',
      'Enum: left, right, collapsed.'
    ],
    <String>[
      'TextSelectionToolbar',
      'Default Material toolbar (Cut/Copy/Paste/Select All).'
    ],
    <String>[
      'TextSelectionControls',
      'Abstract: how to paint handles + toolbar (do not subclass here).'
    ],
    <String>[
      'TextSelectionDelegate',
      'Bridge to the editing state during selection gestures.'
    ],
    <String>[
      'TextSelectionPoint',
      'A point describing one end of a selection.'
    ],
    <String>[
      'SelectionRegistrar',
      'Registers Selectables for cross-widget selection.'
    ],
    <String>[
      'EditableText',
      'Lower-level field that reads the TextSelectionTheme.'
    ],
  ];

  final List<Widget> refRows = <Widget>[];
  for (int i = 0; i < refs.length; i++) {
    final List<String> r = refs[i];
    refRows.add(Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: i.isEven ? Colors.white : paperBg.withValues(alpha: 0.5),
        border: Border(bottom: BorderSide(color: hairline, width: 0.6)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 28.0,
            child: Text(
              '${i + 1}',
              style: TextStyle(
                fontSize: 11.0,
                color: paperFg.withValues(alpha: 0.5),
                fontFamily: 'monospace',
              ),
            ),
          ),
          SizedBox(
            width: 200.0,
            child: Text(
              r[0],
              style: const TextStyle(
                fontSize: 12.5,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
                color: accentIndigo,
              ),
            ),
          ),
          Expanded(
            child: Text(
              r[1],
              style: const TextStyle(
                fontSize: 12.0,
                color: paperFg,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    ));
  }

  final Widget references = Container(
    margin: const EdgeInsets.fromLTRB(18.0, 8.0, 18.0, 8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: hairline, width: 1.0),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 8.0),
          child: Text(
            'Related types (reference)',
            style: TextStyle(
              color: accentIndigo,
              fontSize: 12.0,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Column(children: refRows),
      ],
    ),
  );

  // Footer
  final Widget footer = Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 22.0),
    color: inkBg,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            chip('END OF DEMO', accentSaffron, inkBg),
            const SizedBox(width: 8.0),
            chip(
                'handles=${handleTypes.length}',
                inkFg.withValues(alpha: 0.15),
                inkFg),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          'TextSelectionThemeData controls cursor, selection highlight and '
          'handles — three orthogonal colors plumbed through the widget tree '
          'by a TextSelectionTheme InheritedWidget.',
          style: TextStyle(
            color: inkFg.withValues(alpha: 0.78),
            fontSize: 12.0,
            height: 1.4,
          ),
        ),
      ],
    ),
  );

  // ---- Compose -------------------------------------------------------------

  final Widget body = SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        hero,
        sectionHeader('SECTION 01', 'The three colors at a glance',
            accentSaffron),
        schematic,
        sectionHeader('SECTION 02', 'Live TextField palette grid',
            accentRose),
        fieldGrid,
        sectionHeader('SECTION 03', 'TextSelectionHandleType gallery',
            accentTeal),
        handlesGallery,
        sectionHeader('SECTION 04', 'TextSelectionToolbar mock',
            accentPlum),
        toolbarMock,
        sectionHeader('SECTION 05', 'Theme vs TextStyle',
            accentForest),
        comparison,
        sectionHeader('SECTION 06', 'How to apply it',
            accentIndigo),
        codeBlock,
        sectionHeader('SECTION 07', 'Related types',
            accentSlate),
        references,
        footer,
      ],
    ),
  );

  print('TextSelection deep-visual demo composed');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: accentSaffron,
        selectionColor: accentSaffron.withValues(alpha: 0.32),
        selectionHandleColor: accentSaffron,
      ),
    ),
    home: Scaffold(
      backgroundColor: paperBg,
      body: SafeArea(child: body),
    ),
  );
}
