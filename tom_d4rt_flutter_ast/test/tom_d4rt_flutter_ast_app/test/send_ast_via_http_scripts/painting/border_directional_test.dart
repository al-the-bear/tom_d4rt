// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests BorderDirectional from painting
// Deep Demo: Visual demonstration of RTL-aware borders using start/end sides
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BorderDirectional Deep Demo executing');

  // Indigo / violet i18n palette
  final paletteIndigo = Colors.indigo;
  final paletteViolet = Colors.deepPurple;
  final paletteAccent = Colors.purpleAccent;
  final paletteSurface = Colors.indigo.shade50;
  final paletteEdge = Colors.indigo.shade200;
  final paletteDeep = Colors.indigo.shade900;

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title banner ===');

  final titleBanner = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [paletteIndigo, paletteViolet, paletteAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: paletteIndigo.withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: paletteViolet.withValues(alpha: 0.25),
          blurRadius: 32.0,
          offset: Offset(0.0, 18.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.translate, size: 48.0, color: Colors.white),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BorderDirectional',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'RTL-aware borders with start / end sides',
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
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.4),
              width: 1.0,
            ),
          ),
          child: Text(
            'package:flutter/painting.dart  ->  BorderDirectional',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy
  // ============================================================
  print('=== Section 2: Anatomy ===');

  final anatomyBox = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [paletteSurface, Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: paletteEdge, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: paletteIndigo.withValues(alpha: 0.12),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Anatomy of a BorderDirectional',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: paletteDeep,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Four sides: top, bottom, start, end. start/end resolve to left/right based on TextDirection.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 18.0),
        Center(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Container(
              width: 280.0,
              height: 180.0,
              decoration: BoxDecoration(
                color: Colors.white,
                border: BorderDirectional(
                  top: BorderSide(color: paletteIndigo, width: 4.0),
                  bottom: BorderSide(color: paletteIndigo, width: 4.0),
                  start: BorderSide(color: paletteAccent, width: 4.0),
                  end: BorderSide(color: paletteViolet, width: 4.0),
                ),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 6.0),
                      child: Text(
                        'top',
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                          color: paletteIndigo,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        'bottom',
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                          color: paletteIndigo,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 6.0),
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          'start',
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                            color: paletteAccent,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 6.0),
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Text(
                          'end',
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                            color: paletteViolet,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 6.0,
                      ),
                      decoration: BoxDecoration(
                        color: paletteIndigo.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text(
                        'TextDirection.ltr',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11.0,
                          color: paletteDeep,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: LTR vs RTL
  // ============================================================
  print('=== Section 3: LTR vs RTL ===');

  final ltrRtlBorder = BorderDirectional(
    start: BorderSide(color: paletteAccent, width: 8.0),
    end: BorderSide(color: paletteViolet, width: 2.0),
    top: BorderSide(color: paletteIndigo, width: 1.0),
    bottom: BorderSide(color: paletteIndigo, width: 1.0),
  );

  final ltrCard = Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      width: 160.0,
      height: 110.0,
      decoration: BoxDecoration(color: Colors.white, border: ltrRtlBorder),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.format_textdirection_l_to_r, color: paletteIndigo),
          SizedBox(height: 4.0),
          Text(
            'LTR',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: paletteDeep,
            ),
          ),
          SizedBox(height: 2.0),
          Text(
            'start = LEFT',
            style: TextStyle(fontSize: 10.0, color: paletteAccent),
          ),
          Text(
            'end = right',
            style: TextStyle(fontSize: 10.0, color: paletteViolet),
          ),
        ],
      ),
    ),
  );

  final rtlCard = Directionality(
    textDirection: TextDirection.rtl,
    child: Container(
      width: 160.0,
      height: 110.0,
      decoration: BoxDecoration(color: Colors.white, border: ltrRtlBorder),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.format_textdirection_r_to_l, color: paletteIndigo),
          SizedBox(height: 4.0),
          Text(
            'RTL',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: paletteDeep,
            ),
          ),
          SizedBox(height: 2.0),
          Text(
            'start = RIGHT',
            style: TextStyle(fontSize: 10.0, color: paletteAccent),
          ),
          Text(
            'end = left',
            style: TextStyle(fontSize: 10.0, color: paletteViolet),
          ),
        ],
      ),
    ),
  );

  final ltrRtlSection = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, paletteSurface],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: paletteEdge, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: paletteViolet.withValues(alpha: 0.12),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Same border, different directions',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: paletteDeep,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'A thick start (purpleAccent) flips to the opposite physical edge under RTL.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [ltrCard, rtlCard],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: All four sides individually
  // ============================================================
  print('=== Section 4: All four sides ===');

  final sideCards = <Widget>[];
  final sideData = <Map<String, dynamic>>[
    {
      'name': 'top',
      'border': BorderDirectional(
        top: BorderSide(color: paletteIndigo, width: 6.0),
      ),
      'icon': Icons.border_top,
    },
    {
      'name': 'bottom',
      'border': BorderDirectional(
        bottom: BorderSide(color: paletteViolet, width: 6.0),
      ),
      'icon': Icons.border_bottom,
    },
    {
      'name': 'start',
      'border': BorderDirectional(
        start: BorderSide(color: paletteAccent, width: 6.0),
      ),
      'icon': Icons.border_left,
    },
    {
      'name': 'end',
      'border': BorderDirectional(
        end: BorderSide(color: Colors.deepPurple.shade300, width: 6.0),
      ),
      'icon': Icons.border_right,
    },
  ];

  for (final data in sideData) {
    final name = data['name'] as String;
    final border = data['border'] as BorderDirectional;
    final icon = data['icon'] as IconData;
    sideCards.add(
      Container(
        width: 120.0,
        height: 110.0,
        margin: EdgeInsets.all(6.0),
        decoration: BoxDecoration(color: Colors.white, border: border),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: paletteIndigo, size: 32.0),
            SizedBox(height: 6.0),
            Text(
              name,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: paletteDeep,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final allSidesSection = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [paletteSurface, Colors.white],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: paletteEdge, width: 1.0),
    ),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Each side, on its own',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: paletteDeep,
            ),
          ),
          SizedBox(height: 12.0),
          Wrap(alignment: WrapAlignment.center, children: sideCards),
        ],
      ),
    ),
  );

  // ============================================================
  // SECTION 5: Mixed widths
  // ============================================================
  print('=== Section 5: Mixed widths ===');

  final mixedWidthCards = <Widget>[];
  final mixedWidthData = <Map<String, dynamic>>[
    {
      'label': 'thin top, thick bottom',
      'border': BorderDirectional(
        top: BorderSide(color: paletteIndigo, width: 1.0),
        bottom: BorderSide(color: paletteIndigo, width: 8.0),
        start: BorderSide(color: paletteIndigo, width: 2.0),
        end: BorderSide(color: paletteIndigo, width: 2.0),
      ),
    },
    {
      'label': 'heavy start',
      'border': BorderDirectional(
        top: BorderSide(color: paletteViolet, width: 1.0),
        bottom: BorderSide(color: paletteViolet, width: 1.0),
        start: BorderSide(color: paletteAccent, width: 10.0),
        end: BorderSide(color: paletteViolet, width: 1.0),
      ),
    },
    {
      'label': 'tapered',
      'border': BorderDirectional(
        top: BorderSide(color: paletteIndigo, width: 6.0),
        bottom: BorderSide(color: paletteIndigo, width: 1.0),
        start: BorderSide(color: paletteIndigo, width: 4.0),
        end: BorderSide(color: paletteIndigo, width: 2.0),
      ),
    },
  ];

  for (final data in mixedWidthData) {
    final label = data['label'] as String;
    final border = data['border'] as BorderDirectional;
    mixedWidthCards.add(
      Container(
        width: 150.0,
        height: 100.0,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(color: Colors.white, border: border),
        alignment: Alignment.center,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: paletteDeep,
          ),
        ),
      ),
    );
  }

  final mixedWidthSection = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, Colors.deepPurple.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: paletteEdge, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: paletteIndigo.withValues(alpha: 0.10),
          blurRadius: 12.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mixed widths',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: paletteDeep,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            'BorderSide.width can vary per side. The interpreter does not support compound corners with non-uniform widths, so keep this in flat boxes.',
            style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
          ),
          SizedBox(height: 12.0),
          Wrap(alignment: WrapAlignment.center, children: mixedWidthCards),
        ],
      ),
    ),
  );

  // ============================================================
  // SECTION 6: Color variants
  // ============================================================
  print('=== Section 6: Color variants ===');

  final colorVariantCards = <Widget>[];
  final colorVariantData = <Map<String, dynamic>>[
    {
      'label': 'cold',
      'border': BorderDirectional(
        top: BorderSide(color: Colors.indigo, width: 3.0),
        bottom: BorderSide(color: Colors.blue, width: 3.0),
        start: BorderSide(color: Colors.cyan, width: 3.0),
        end: BorderSide(color: Colors.teal, width: 3.0),
      ),
    },
    {
      'label': 'warm',
      'border': BorderDirectional(
        top: BorderSide(color: Colors.deepOrange, width: 3.0),
        bottom: BorderSide(color: Colors.red, width: 3.0),
        start: BorderSide(color: Colors.amber, width: 3.0),
        end: BorderSide(color: Colors.pink, width: 3.0),
      ),
    },
    {
      'label': 'violets',
      'border': BorderDirectional(
        top: BorderSide(color: Colors.deepPurple.shade300, width: 3.0),
        bottom: BorderSide(color: Colors.deepPurple.shade700, width: 3.0),
        start: BorderSide(color: Colors.purpleAccent, width: 3.0),
        end: BorderSide(color: Colors.indigo.shade400, width: 3.0),
      ),
    },
  ];

  for (final data in colorVariantData) {
    final label = data['label'] as String;
    final border = data['border'] as BorderDirectional;
    colorVariantCards.add(
      Container(
        width: 150.0,
        height: 100.0,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(color: Colors.white, border: border),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: paletteDeep,
          ),
        ),
      ),
    );
  }

  final colorVariantSection = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [paletteSurface, Colors.white, Colors.deepPurple.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: paletteEdge, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: paletteAccent.withValues(alpha: 0.18),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Color variants',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: paletteDeep,
            ),
          ),
          SizedBox(height: 12.0),
          Wrap(alignment: WrapAlignment.center, children: colorVariantCards),
        ],
      ),
    ),
  );

  // ============================================================
  // SECTION 7: BorderStyle.solid vs .none
  // ============================================================
  print('=== Section 7: Style solid vs none ===');

  final solidStyleCard = Container(
    width: 150.0,
    height: 100.0,
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: BorderDirectional(
        top: BorderSide(
          color: paletteIndigo,
          width: 3.0,
          style: BorderStyle.solid,
        ),
        bottom: BorderSide(
          color: paletteIndigo,
          width: 3.0,
          style: BorderStyle.solid,
        ),
        start: BorderSide(
          color: paletteAccent,
          width: 3.0,
          style: BorderStyle.solid,
        ),
        end: BorderSide(
          color: paletteViolet,
          width: 3.0,
          style: BorderStyle.solid,
        ),
      ),
    ),
    alignment: Alignment.center,
    child: Text(
      'BorderStyle.solid',
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        fontWeight: FontWeight.bold,
        color: paletteDeep,
      ),
    ),
  );

  final noneStyleCard = Container(
    width: 150.0,
    height: 100.0,
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: BorderDirectional(
        top: BorderSide(
          color: paletteIndigo,
          width: 3.0,
          style: BorderStyle.solid,
        ),
        bottom: BorderSide(
          color: paletteIndigo,
          width: 3.0,
          style: BorderStyle.solid,
        ),
        start: BorderSide.none,
        end: BorderSide.none,
      ),
    ),
    alignment: Alignment.center,
    child: Text(
      'start/end = none',
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        fontWeight: FontWeight.bold,
        color: paletteDeep,
      ),
    ),
  );

  final styleSection = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: paletteEdge, width: 1.0),
    ),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BorderStyle.solid vs BorderStyle.none',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: paletteDeep,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            'BorderStyle.none renders no stroke and reports zero width. Use BorderSide.none as a constant shorthand.',
            style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
          ),
          SizedBox(height: 12.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: [solidStyleCard, noneStyleCard],
          ),
        ],
      ),
    ),
  );

  // ============================================================
  // SECTION 8: Border vs BorderDirectional comparison
  // ============================================================
  print('=== Section 8: Comparison ===');

  final compareTableHeader = Container(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
    decoration: BoxDecoration(
      color: paletteIndigo.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Row(
      children: [
        _bdCell('Aspect', 110.0, true, paletteDeep),
        _bdCell('Border', 110.0, true, paletteDeep),
        _bdCell('BorderDirectional', 130.0, true, paletteDeep),
      ],
    ),
  );

  final compareRows = <Widget>[];
  final compareData = <List<String>>[
    ['Sides', 'left, right, top, bottom', 'start, end, top, bottom'],
    ['RTL aware', 'no', 'yes'],
    ['Needs Directionality', 'no', 'yes'],
    ['Use case', 'fixed/physical edges', 'i18n / bidi UI'],
    ['BorderRadius', 'supported', 'not supported'],
  ];

  for (final row in compareData) {
    compareRows.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200, width: 1.0),
          ),
        ),
        child: Row(
          children: [
            _bdCell(row[0], 110.0, false, paletteDeep),
            _bdCell(row[1], 110.0, false, Colors.grey.shade800),
            _bdCell(row[2], 130.0, false, paletteAccent),
          ],
        ),
      ),
    );
  }

  final compareSection = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [paletteSurface, Colors.white],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: paletteEdge, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: paletteIndigo.withValues(alpha: 0.10),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Border vs BorderDirectional',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: paletteDeep,
          ),
        ),
        SizedBox(height: 12.0),
        compareTableHeader,
        SizedBox(height: 4.0),
        Column(children: compareRows),
        SizedBox(height: 14.0),
        Row(
          children: [
            Expanded(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Container(
                  height: 70.0,
                  margin: EdgeInsets.only(right: 6.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      left: BorderSide(color: Colors.deepOrange, width: 6.0),
                      right: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Border (left/right)',
                    style: TextStyle(fontSize: 11.0, color: paletteDeep),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Container(
                  height: 70.0,
                  margin: EdgeInsets.only(left: 6.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: BorderDirectional(
                      start: BorderSide(color: Colors.deepOrange, width: 6.0),
                      end: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'BorderDirectional (start/end)',
                    style: TextStyle(fontSize: 11.0, color: paletteDeep),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Real-world mocks
  // ============================================================
  print('=== Section 9: Real-world mocks ===');

  final inputFieldMock = Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      height: 56.0,
      padding: EdgeInsets.symmetric(horizontal: 14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: BorderDirectional(
          bottom: BorderSide(color: paletteIndigo, width: 2.0),
          start: BorderSide(color: paletteAccent, width: 4.0),
        ),
        boxShadow: [
          BoxShadow(
            color: paletteIndigo.withValues(alpha: 0.10),
            blurRadius: 6.0,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: paletteIndigo, size: 20.0),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'Search messages...',
              style: TextStyle(fontSize: 14.0, color: Colors.grey.shade600),
            ),
          ),
          Icon(Icons.tune, color: paletteAccent, size: 20.0),
        ],
      ),
    ),
  );

  final chatBubbleMock = Directionality(
    textDirection: TextDirection.rtl,
    child: Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade50, Colors.white],
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
          ),
          border: BorderDirectional(
            start: BorderSide(color: paletteAccent, width: 4.0),
            top: BorderSide(color: paletteEdge, width: 1.0),
            bottom: BorderSide(color: paletteEdge, width: 1.0),
            end: BorderSide(color: paletteEdge, width: 1.0),
          ),
        ),
        child: Text(
          'Hello world',
          style: TextStyle(fontSize: 13.0, color: paletteDeep),
        ),
      ),
    ),
  );

  final drawerDividerMock = Directionality(
    textDirection: TextDirection.ltr,
    child: Column(
      children: [
        _drawerRow(
          Icons.home,
          'Home',
          paletteIndigo,
          paletteAccent,
          true,
          paletteSurface,
        ),
        _drawerRow(
          Icons.message,
          'Messages',
          paletteIndigo,
          paletteAccent,
          false,
          Colors.white,
        ),
        _drawerRow(
          Icons.settings,
          'Settings',
          paletteIndigo,
          paletteAccent,
          false,
          Colors.white,
        ),
      ],
    ),
  );

  final realWorldSection = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, paletteSurface, Colors.deepPurple.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: paletteEdge, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: paletteViolet.withValues(alpha: 0.18),
          blurRadius: 18.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Real-world mocks',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: paletteDeep,
          ),
        ),
        SizedBox(height: 14.0),
        Text(
          'Bidirectional input field',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: paletteAccent,
          ),
        ),
        SizedBox(height: 6.0),
        inputFieldMock,
        SizedBox(height: 18.0),
        Text(
          'RTL chat bubble (start accent flips to right)',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: paletteAccent,
          ),
        ),
        SizedBox(height: 6.0),
        chatBubbleMock,
        SizedBox(height: 18.0),
        Text(
          'Drawer item with start indicator',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: paletteAccent,
          ),
        ),
        SizedBox(height: 6.0),
        drawerDividerMock,
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Footguns
  // ============================================================
  print('=== Section 10: Footguns ===');

  final footgunData = <Map<String, dynamic>>[
    {
      'icon': Icons.warning_amber,
      'title': 'Requires Directionality ancestor',
      'body':
          'BorderDirectional must resolve start/end via TextDirection. Outside a Directionality, painting throws.',
      'color': Colors.deepOrange,
    },
    {
      'icon': Icons.rounded_corner,
      'title': 'No BorderRadius support',
      'body':
          'Cannot be combined with BoxDecoration.borderRadius. Use Border for rounded boxes, or wrap with ClipRRect.',
      'color': Colors.red,
    },
    {
      'icon': Icons.palette,
      'title': 'Compound paint needs uniform colors',
      'body':
          'paintShape uses a single fast-path stroke when all sides share color/style/width. Mixed colors fall back to per-side rectangles.',
      'color': paletteAccent,
    },
    {
      'icon': Icons.swap_horiz,
      'title': 'start != left',
      'body':
          'Reading code that mixes Border and BorderDirectional is confusing. Pick one per layer of UI.',
      'color': paletteIndigo,
    },
  ];

  final footgunCards = <Widget>[];
  for (final data in footgunData) {
    final color = data['color'] as Color;
    // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #58, P5(a)): The
     // original footgun card combined borderRadius:10 with an asymmetric
     // Border(left: full-color, others: alpha-0.3) -> Flutter forbids non-
     // uniform border colors with a borderRadius. Replaced with uniform
     // Border.all + ClipRRect + IntrinsicHeight Row(stretch) where the
     // coloured left accent is a 4-dp Container. Note: this card section is
     // demonstrating footguns of BorderDirectional, so the test intent is
     // preserved at the data level (titles/bodies still describe the
     // restrictions); only the card chrome was refactored to render.
    footgunCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.2),
              blurRadius: 8.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withValues(alpha: 0.06),
                  color.withValues(alpha: 0.16),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              border: Border.all(
                color: color.withValues(alpha: 0.3),
                width: 1.0,
              ),
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(width: 4.0, color: color),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(data['icon'] as IconData, color: color, size: 24.0),
                          SizedBox(width: 12.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data['title'] as String,
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                    color: color,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  data['body'] as String,
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    color: Colors.grey.shade800,
                                    height: 1.35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  final footgunSection = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, Colors.deepOrange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.deepOrange.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Footguns',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: paletteDeep,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Things that bite when you reach for BorderDirectional.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12.0),
        Column(children: footgunCards),
      ],
    ),
  );

  print('BorderDirectional Deep Demo completed successfully');

  // ============================================================
  // Final composition
  // ============================================================
  return Scaffold(
    backgroundColor: paletteSurface,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 24.0),
          _sectionHeading('1. Title banner above', paletteDeep),
          SizedBox(height: 8.0),
          _sectionHeading('2. Anatomy', paletteDeep),
          SizedBox(height: 8.0),
          anatomyBox,
          SizedBox(height: 24.0),
          _sectionHeading('3. LTR vs RTL', paletteDeep),
          SizedBox(height: 8.0),
          ltrRtlSection,
          SizedBox(height: 24.0),
          _sectionHeading('4. Each side individually', paletteDeep),
          SizedBox(height: 8.0),
          allSidesSection,
          SizedBox(height: 24.0),
          _sectionHeading('5. Mixed widths', paletteDeep),
          SizedBox(height: 8.0),
          mixedWidthSection,
          SizedBox(height: 24.0),
          _sectionHeading('6. Color variants', paletteDeep),
          SizedBox(height: 8.0),
          colorVariantSection,
          SizedBox(height: 24.0),
          _sectionHeading('7. BorderStyle.solid vs .none', paletteDeep),
          SizedBox(height: 8.0),
          styleSection,
          SizedBox(height: 24.0),
          _sectionHeading('8. Border vs BorderDirectional', paletteDeep),
          SizedBox(height: 8.0),
          compareSection,
          SizedBox(height: 24.0),
          _sectionHeading('9. Real-world mocks', paletteDeep),
          SizedBox(height: 8.0),
          realWorldSection,
          SizedBox(height: 24.0),
          _sectionHeading('10. Footguns', paletteDeep),
          SizedBox(height: 8.0),
          footgunSection,
          SizedBox(height: 32.0),
        ],
      ),
    ),
  );
}

// Helper: section heading
Widget _sectionHeading(String text, Color color) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: color,
      letterSpacing: 0.3,
    ),
  );
}

// Helper: comparison cell
Widget _bdCell(String text, double width, bool bold, Color color) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        color: color,
      ),
    ),
  );
}

// Helper: drawer row mock used in section 9
Widget _drawerRow(
  IconData icon,
  String label,
  Color edgeColor,
  Color accent,
  bool active,
  Color background,
) {
  return Container(
    height: 44.0,
    padding: EdgeInsetsDirectional.only(start: 14.0, end: 14.0),
    decoration: BoxDecoration(
      color: background,
      border: BorderDirectional(
        start: BorderSide(
          color: active ? accent : Colors.transparent,
          width: 4.0,
        ),
        bottom: BorderSide(color: edgeColor.withValues(alpha: 0.25), width: 1.0),
      ),
    ),
    child: Row(
      children: [
        Icon(icon, color: active ? accent : edgeColor, size: 20.0),
        SizedBox(width: 12.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
            color: active ? accent : edgeColor,
          ),
        ),
      ],
    ),
  );
}
