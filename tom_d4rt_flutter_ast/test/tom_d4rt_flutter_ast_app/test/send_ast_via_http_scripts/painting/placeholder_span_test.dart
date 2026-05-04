// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Visual Demo for PlaceholderSpan from painting.
// PlaceholderSpan is the abstract base class for InlineSpans that reserve a
// rectangular slot inside a text run. The concrete subclass shipping with
// Flutter is WidgetSpan, which lets a regular Widget participate in line
// breaking and text shaping inside Text.rich / RichText.
//
// This demo renders eleven richly styled sections using gradient cards,
// shadow stacks, and real Text.rich(...) examples. Color theme: cyan/teal,
// indicating "inline flowing" content.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PlaceholderSpan Deep Demo executing');

  // ============================================================
  // SHARED PALETTE
  // ============================================================
  final Color tealDeep = Color(0xFF00695C);
  final Color tealMid = Color(0xFF00897B);
  final Color tealSoft = Color(0xFF80CBC4);
  final Color cyanDeep = Color(0xFF006064);
  final Color cyanMid = Color(0xFF0097A7);
  final Color cyanSoft = Color(0xFFB2EBF2);
  final Color inkDark = Color(0xFF263238);
  final Color paper = Color(0xFFF1F8F8);

  // ============================================================
  // SECTION 1 - TITLE BANNER
  // ============================================================
  print('=== Section 1: Title Banner ===');
  final Widget titleBanner = Container(
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [cyanDeep, tealMid, tealSoft],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 0.55, 1.0],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: cyanDeep.withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: Offset(0.0, 10.0),
          spreadRadius: 1.0,
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.15),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: Icon(
                Icons.format_textdirection_l_to_r,
                color: Colors.white,
                size: 36.0,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PlaceholderSpan',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    'Inline rectangles inside flowing text',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.30),
              width: 1.0,
            ),
          ),
          child: Text.rich(
            TextSpan(
              children: <InlineSpan>[
                TextSpan(
                  text: 'Reserve a slot ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      'HERE',
                      style: TextStyle(
                        color: cyanDeep,
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TextSpan(
                  text: ' inside a paragraph.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2 - ANATOMY OF A LINE WITH A PLACEHOLDER
  // ============================================================
  print('=== Section 2: Anatomy ===');
  final Widget anatomyDiagram = Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [paper, cyanSoft.withValues(alpha: 0.55)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: cyanMid.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: cyanMid.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Anatomy of a Text Line',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: cyanDeep,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'A WidgetSpan reserves a rectangle inside a single line of text.',
          style: TextStyle(fontSize: 12.0, color: inkDark),
        ),
        SizedBox(height: 16.0),
        // The diagram itself - layered to show ascender, baseline, descender.
        Container(
          height: 140.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Stack(
            children: <Widget>[
              // Ascender guide line
              Positioned(
                left: 0.0,
                right: 0.0,
                top: 38.0,
                child: _guideLine('ascender', Colors.purple.shade300),
              ),
              // Baseline guide line
              Positioned(
                left: 0.0,
                right: 0.0,
                top: 86.0,
                child: _guideLine('baseline', tealDeep),
              ),
              // Descender guide line
              Positioned(
                left: 0.0,
                right: 0.0,
                top: 110.0,
                child: _guideLine('descender', Colors.orange.shade400),
              ),
              // The actual line of rich text on top of the guides
              Positioned(
                left: 16.0,
                right: 16.0,
                top: 50.0,
                child: Text.rich(
                  TextSpan(
                    children: <InlineSpan>[
                      TextSpan(
                        text: 'Buy ',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: inkDark,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Container(
                          width: 56.0,
                          height: 28.0,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [tealMid, cyanMid],
                            ),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Center(
                            child: Text(
                              'SLOT',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TextSpan(
                        text: ' now',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: inkDark,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 6.0,
          children: <Widget>[
            _legendDot('ascender', Colors.purple.shade300),
            _legendDot('baseline', tealDeep),
            _legendDot('descender', Colors.orange.shade400),
            _legendDot('slot', tealMid),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3 - PlaceholderAlignment ENUM TABLE
  // ============================================================
  print('=== Section 3: PlaceholderAlignment values ===');
  final List<Map<String, Object>> alignmentSpecs = <Map<String, Object>>[
    <String, Object>{
      'name': 'top',
      'value': PlaceholderAlignment.top,
      'desc': 'Top of the line box',
      'icon': Icons.vertical_align_top,
    },
    <String, Object>{
      'name': 'middle',
      'value': PlaceholderAlignment.middle,
      'desc': 'Vertically centered',
      'icon': Icons.vertical_align_center,
    },
    <String, Object>{
      'name': 'bottom',
      'value': PlaceholderAlignment.bottom,
      'desc': 'Bottom of the line box',
      'icon': Icons.vertical_align_bottom,
    },
    <String, Object>{
      'name': 'aboveBaseline',
      'value': PlaceholderAlignment.aboveBaseline,
      'desc': 'Sits above the text baseline',
      'icon': Icons.arrow_upward,
    },
    <String, Object>{
      'name': 'belowBaseline',
      'value': PlaceholderAlignment.belowBaseline,
      'desc': 'Sits below the text baseline',
      'icon': Icons.arrow_downward,
    },
    <String, Object>{
      'name': 'baseline',
      'value': PlaceholderAlignment.baseline,
      'desc': 'Anchored to the text baseline',
      'icon': Icons.format_underlined,
    },
  ];

  final List<Widget> alignmentCards = <Widget>[];
  for (final Map<String, Object> spec in alignmentSpecs) {
    final String name = spec['name'] as String;
    final String desc = spec['desc'] as String;
    final IconData icon = spec['icon'] as IconData;
    final PlaceholderAlignment alignment = spec['value'] as PlaceholderAlignment;

    print('PlaceholderAlignment.$name -> $alignment');
    alignmentCards.add(
      Container(
        width: 170.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              cyanSoft.withValues(alpha: 0.6),
              tealSoft.withValues(alpha: 0.5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: cyanMid, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: cyanMid.withValues(alpha: 0.25),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, color: cyanDeep, size: 18.0),
                SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: cyanDeep,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Text(
              desc,
              style: TextStyle(fontSize: 10.5, color: inkDark),
            ),
            SizedBox(height: 10.0),
            // Visual rendering of this alignment versus a baseline.
            Container(
              height: 46.0,
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              alignment: Alignment.centerLeft,
              child: Text.rich(
                TextSpan(
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'Ag',
                      style: TextStyle(fontSize: 18.0, color: inkDark),
                    ),
                    WidgetSpan(
                      alignment: alignment,
                      baseline: alignment == PlaceholderAlignment.baseline ||
                              alignment == PlaceholderAlignment.aboveBaseline ||
                              alignment == PlaceholderAlignment.belowBaseline
                          ? TextBaseline.alphabetic
                          : null,
                      child: Container(
                        width: 18.0,
                        height: 18.0,
                        decoration: BoxDecoration(
                          color: tealDeep,
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                      ),
                    ),
                    TextSpan(
                      text: 'gA',
                      style: TextStyle(fontSize: 18.0, color: inkDark),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget alignmentTable = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, paper],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: cyanMid.withValues(alpha: 0.4)),
      boxShadow: [
        BoxShadow(
          color: cyanDeep.withValues(alpha: 0.10),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'PlaceholderAlignment values',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: cyanDeep,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Each card shows the alignment relative to the baseline of "Ag gA".',
          style: TextStyle(fontSize: 12.0, color: inkDark),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.start, children: alignmentCards),
      ],
    ),
  );

  // ============================================================
  // SECTION 4 - WIDGETSPAN BASICS
  // ============================================================
  print('=== Section 4: WidgetSpan basics ===');
  final Widget basicsCard = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [tealSoft.withValues(alpha: 0.45), cyanSoft.withValues(alpha: 0.6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: tealMid.withValues(alpha: 0.6), width: 1.4),
      boxShadow: [
        BoxShadow(
          color: tealMid.withValues(alpha: 0.30),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.star_rate_rounded, color: Colors.amber.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Hello star world',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: tealDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: tealMid.withValues(alpha: 0.5)),
          ),
          child: Text.rich(
            TextSpan(
              style: TextStyle(fontSize: 18.0, color: inkDark),
              children: <InlineSpan>[
                TextSpan(text: 'Hello '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(
                    Icons.star,
                    color: Colors.amber.shade700,
                    size: 20.0,
                  ),
                ),
                TextSpan(text: ' World'),
              ],
            ),
          ),
        ),
        SizedBox(height: 10.0),
        _annotation(
          'A WidgetSpan in the middle of two TextSpans, aligned to middle.',
          tealDeep,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5 - MIXED INLINE RUNS
  // ============================================================
  print('=== Section 5: Mixed inline runs ===');
  final Widget mixedRuns = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, cyanSoft.withValues(alpha: 0.55)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: cyanMid.withValues(alpha: 0.5)),
      boxShadow: [
        BoxShadow(
          color: cyanDeep.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Mixed inline runs',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: cyanDeep,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Chips, badges, avatars and buttons inline with text.',
          style: TextStyle(fontSize: 12.0, color: inkDark),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: cyanMid.withValues(alpha: 0.45)),
          ),
          child: Text.rich(
            TextSpan(
              style: TextStyle(fontSize: 15.0, color: inkDark, height: 1.6),
              children: <InlineSpan>[
                TextSpan(text: 'User '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: CircleAvatar(
                    radius: 10.0,
                    backgroundColor: tealMid,
                    child: Text(
                      'A',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TextSpan(text: ' Alex earned '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade100,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Colors.amber.shade700),
                    ),
                    child: Text(
                      '+125 XP',
                      style: TextStyle(
                        color: Colors.amber.shade900,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TextSpan(text: ' for '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: cyanMid,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.bolt, color: Colors.white, size: 12.0),
                        SizedBox(width: 2.0),
                        Text(
                          'fast',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextSpan(text: ' completion. Click '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 3.0,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [tealMid, cyanMid],
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      'CLAIM',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TextSpan(text: ' to redeem.'),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6 - STYLE OVERRIDE
  // ============================================================
  print('=== Section 6: Style override ===');
  final Widget styleOverride = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [paper, tealSoft.withValues(alpha: 0.5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: tealMid),
      boxShadow: [
        BoxShadow(
          color: tealMid.withValues(alpha: 0.22),
          blurRadius: 9.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'WidgetSpan style override',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: tealDeep,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'The style argument controls measurement (font size, letter spacing).',
          style: TextStyle(fontSize: 12.0, color: inkDark),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text.rich(
            TextSpan(
              style: TextStyle(fontSize: 14.0, color: inkDark),
              children: <InlineSpan>[
                TextSpan(text: 'Default: '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Container(
                    width: 14.0,
                    height: 14.0,
                    color: tealMid,
                  ),
                ),
                TextSpan(text: '   Bigger style: '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  style: TextStyle(fontSize: 28.0, letterSpacing: 4.0),
                  child: Container(
                    width: 14.0,
                    height: 14.0,
                    color: cyanMid,
                  ),
                ),
                TextSpan(text: '   Tight: '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  style: TextStyle(fontSize: 10.0, letterSpacing: 0.0),
                  child: Container(
                    width: 14.0,
                    height: 14.0,
                    color: cyanDeep,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8.0),
        _annotation(
          'Same child widget, different surrounding measurement context.',
          tealDeep,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7 - BASELINE PARAM EXAMPLE
  // ============================================================
  print('=== Section 7: Baseline param ===');
  final Widget baselineExample = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [cyanSoft.withValues(alpha: 0.55), Colors.white],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: cyanMid),
      boxShadow: [
        BoxShadow(
          color: cyanMid.withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'TextBaseline parameter',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: cyanDeep,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'baseline is required for baseline / aboveBaseline / belowBaseline.',
          style: TextStyle(fontSize: 12.0, color: inkDark),
        ),
        SizedBox(height: 14.0),
        _baselineRow(
          label: 'TextBaseline.alphabetic',
          color: tealDeep,
          baseline: TextBaseline.alphabetic,
        ),
        SizedBox(height: 10.0),
        _baselineRow(
          label: 'TextBaseline.ideographic',
          color: cyanDeep,
          baseline: TextBaseline.ideographic,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8 - REAL WORLD MOCKS
  // ============================================================
  print('=== Section 8: Real-world mocks ===');
  final Widget realWorld = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [paper, cyanSoft.withValues(alpha: 0.7)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: cyanMid),
      boxShadow: [
        BoxShadow(
          color: cyanDeep.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 7.0),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 4.0,
          offset: Offset(0.0, 1.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Real-world mocks',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: cyanDeep,
          ),
        ),
        SizedBox(height: 12.0),
        // Pill in paragraph
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text.rich(
            TextSpan(
              style: TextStyle(fontSize: 14.0, color: inkDark, height: 1.6),
              children: <InlineSpan>[
                TextSpan(
                  text: 'Your subscription is ',
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 3.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.green.shade400),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.check_circle,
                          color: Colors.green.shade700,
                          size: 12.0,
                        ),
                        SizedBox(width: 4.0),
                        Text(
                          'ACTIVE',
                          style: TextStyle(
                            color: Colors.green.shade900,
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextSpan(
                  text: ' and renews automatically next month.',
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10.0),
        // Inline progress dot
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text.rich(
            TextSpan(
              style: TextStyle(fontSize: 14.0, color: inkDark, height: 1.6),
              children: <InlineSpan>[
                TextSpan(text: 'Build status '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.orange.withValues(alpha: 0.6),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                  ),
                ),
                TextSpan(text: ' running   '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                TextSpan(text: ' done   '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                TextSpan(text: ' idle'),
              ],
            ),
          ),
        ),
        SizedBox(height: 10.0),
        // Chat bubble with avatar
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
            constraints: BoxConstraints(maxWidth: 320.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [cyanMid, tealMid],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(14.0),
                bottomRight: Radius.circular(14.0),
                bottomLeft: Radius.circular(14.0),
              ),
            ),
            child: Text.rich(
              TextSpan(
                style: TextStyle(color: Colors.white, fontSize: 14.0),
                children: <InlineSpan>[
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: CircleAvatar(
                      radius: 9.0,
                      backgroundColor: Colors.white,
                      child: Text(
                        'B',
                        style: TextStyle(
                          color: tealDeep,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  TextSpan(text: '  Hey, did you see the new release?'),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9 - COMPARISON TABLE
  // ============================================================
  print('=== Section 9: Comparison ===');
  final Widget comparison = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, tealSoft.withValues(alpha: 0.45)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: tealMid),
      boxShadow: [
        BoxShadow(
          color: tealMid.withValues(alpha: 0.20),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'PlaceholderSpan vs InlineSpan vs TextSpan',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: tealDeep,
          ),
        ),
        SizedBox(height: 12.0),
        // Header row
        _comparisonHeader(tealDeep),
        // Data rows
        _comparisonRow(
          'Class',
          'InlineSpan',
          'PlaceholderSpan',
          'TextSpan',
          tealDeep,
        ),
        _comparisonRow(
          'Abstract?',
          'yes',
          'yes',
          'no',
          tealDeep,
        ),
        _comparisonRow(
          'Carries text',
          'maybe',
          'no (slot)',
          'yes',
          tealDeep,
        ),
        _comparisonRow(
          'Carries widget',
          'maybe',
          'yes (subclass)',
          'no',
          tealDeep,
        ),
        _comparisonRow(
          'Children',
          'inlineSpans',
          'inlineSpans',
          'inlineSpans',
          tealDeep,
        ),
        _comparisonRow(
          'Concrete sub',
          'TextSpan/Widget',
          'WidgetSpan',
          '-',
          tealDeep,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10 - FOOTGUNS
  // ============================================================
  print('=== Section 10: Footguns ===');
  final Widget footguns = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.orange.shade50, Colors.red.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.orange.shade400, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.warning_amber_rounded,
                color: Colors.orange.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Footguns',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _footgun(
          'Forgetting baseline',
          'baseline / aboveBaseline / belowBaseline REQUIRE TextBaseline.',
          Icons.warning,
          Colors.orange.shade800,
        ),
        _footgun(
          'Too many WidgetSpans',
          'Each is a real RenderObject; large lists become expensive.',
          Icons.speed,
          Colors.deepOrange.shade700,
        ),
        _footgun(
          'Accessibility',
          'Semantics fall through to the child widget; provide labels.',
          Icons.accessibility_new,
          Colors.red.shade700,
        ),
        _footgun(
          'Nested rich text',
          'Avoid Text.rich inside a WidgetSpan inside Text.rich; layout cost.',
          Icons.layers,
          Colors.brown.shade600,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 11 - RECAP CARD
  // ============================================================
  print('=== Section 11: Recap ===');
  final Widget recap = Container(
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [tealDeep, cyanDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: cyanDeep.withValues(alpha: 0.50),
          blurRadius: 18.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.20),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.check_circle, color: Colors.white, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _recapBullet(
          'PlaceholderSpan is the abstract base for inline rectangle slots.',
        ),
        _recapBullet(
          'WidgetSpan is the only built-in concrete subclass.',
        ),
        _recapBullet(
          'PlaceholderAlignment has 6 values; baseline-relative ones need TextBaseline.',
        ),
        _recapBullet(
          'Use sparingly: each WidgetSpan inflates a real Widget tree.',
        ),
        _recapBullet(
          'Great for inline pills, badges, avatars, icons inside paragraphs.',
        ),
      ],
    ),
  );

  print('PlaceholderSpan Deep Demo completed');

  // ============================================================
  // FINAL LAYOUT - SCAFFOLD WITH SCROLLABLE COLUMN
  // ============================================================
  return Scaffold(
    backgroundColor: paper,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // 1
          titleBanner,
          SizedBox(height: 20.0),

          // 2
          _sectionHeader('1. Anatomy', cyanDeep),
          anatomyDiagram,
          SizedBox(height: 20.0),

          // 3
          _sectionHeader('2. PlaceholderAlignment', cyanDeep),
          alignmentTable,
          SizedBox(height: 20.0),

          // 4
          _sectionHeader('3. WidgetSpan basics', cyanDeep),
          basicsCard,
          SizedBox(height: 20.0),

          // 5
          _sectionHeader('4. Mixed inline runs', cyanDeep),
          mixedRuns,
          SizedBox(height: 20.0),

          // 6
          _sectionHeader('5. Style override', cyanDeep),
          styleOverride,
          SizedBox(height: 20.0),

          // 7
          _sectionHeader('6. Baseline parameter', cyanDeep),
          baselineExample,
          SizedBox(height: 20.0),

          // 8
          _sectionHeader('7. Real-world mocks', cyanDeep),
          realWorld,
          SizedBox(height: 20.0),

          // 9
          _sectionHeader('8. Comparison', cyanDeep),
          comparison,
          SizedBox(height: 20.0),

          // 10
          _sectionHeader('9. Footguns', cyanDeep),
          footguns,
          SizedBox(height: 20.0),

          // 11
          _sectionHeader('10. Recap', cyanDeep),
          recap,
          SizedBox(height: 30.0),
        ],
      ),
    ),
  );
}

// ============================================================
// HELPER WIDGETS
// ============================================================

Widget _sectionHeader(String label, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    child: Row(
      children: <Widget>[
        Container(
          width: 4.0,
          height: 22.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        SizedBox(width: 8.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _guideLine(String label, Color color) {
  return Row(
    children: <Widget>[
      Container(
        width: 60.0,
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 9.0,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Expanded(
        child: Container(
          height: 1.0,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: color.withValues(alpha: 0.7),
                width: 1.0,
                style: BorderStyle.solid,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _legendDot(String label, Color color) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
      SizedBox(width: 4.0),
      Text(
        label,
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
      ),
    ],
  );
}

Widget _annotation(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Row(
      children: <Widget>[
        Icon(Icons.info_outline, size: 14.0, color: color),
        SizedBox(width: 6.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 11.0, color: color),
          ),
        ),
      ],
    ),
  );
}

Widget _baselineRow({
  required String label,
  required Color color,
  required TextBaseline baseline,
}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 6.0),
        Text.rich(
          TextSpan(
            style: TextStyle(fontSize: 18.0, color: Colors.black),
            children: <InlineSpan>[
              TextSpan(text: 'word '),
              WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: baseline,
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
              ),
              TextSpan(text: ' word'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _comparisonHeader(Color color) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Row(
      children: <Widget>[
        _compCell('Property', 90.0, color, bold: true),
        _compCell('InlineSpan', 90.0, color, bold: true),
        _compCell('Placeholder', 90.0, color, bold: true),
        _compCell('TextSpan', 80.0, color, bold: true),
      ],
    ),
  );
}

Widget _comparisonRow(
  String label,
  String inlineCol,
  String placeholderCol,
  String textCol,
  Color color,
) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.grey.shade300),
      ),
    ),
    child: Row(
      children: <Widget>[
        _compCell(label, 90.0, color, bold: true),
        _compCell(inlineCol, 90.0, Colors.black87),
        _compCell(placeholderCol, 90.0, Colors.black87),
        _compCell(textCol, 80.0, Colors.black87),
      ],
    ),
  );
}

Widget _compCell(String text, double width, Color color, {bool bold = false}) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11.0,
        color: color,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      ),
    ),
  );
}

Widget _footgun(String title, String body, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.only(bottom: 8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: color, size: 18.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                body,
                style: TextStyle(fontSize: 11.5, color: Colors.black87),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _recapBullet(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.chevron_right, color: Colors.white, size: 18.0),
        SizedBox(width: 4.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.95),
              fontSize: 13.0,
            ),
          ),
        ),
      ],
    ),
  );
}
