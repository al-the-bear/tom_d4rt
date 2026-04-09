// ignore_for_file: avoid_print
// D4rt test script: Deep demo for Axis enum from painting
// Demonstrates horizontal vs vertical layout, flipAxis, main/cross axis
// semantics, and how Axis drives Row, Column, Flex, ListView, and Wrap.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Axis Deep Demo executing');

  // ── palette ──────────────────────────────────────────────────
  final Color axPrimary = Color(0xFF6D4C41); // brown 600
  final Color axAccent = Color(0xFF8D6E63); // brown 400
  final Color axSurface = Color(0xFFFBE9E7); // deep-orange 50
  final Color axHoriz = Color(0xFF00838F); // cyan 800
  final Color axVert = Color(0xFFAD1457); // pink 800
  final Color axDark = Color(0xFF3E2723); // brown 900

  Color axColorFor(Axis a) {
    return a == Axis.horizontal ? axHoriz : axVert;
  }

  IconData axIconFor(Axis a) {
    return a == Axis.horizontal ? Icons.swap_horiz : Icons.swap_vert;
  }

  Widget axBadge(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 11.0, fontWeight: FontWeight.w600, color: color)),
    );
  }

  Widget axSectionHeader(String title, IconData icon) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      margin: EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [axPrimary, axAccent]),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(children: [
        Icon(icon, color: Colors.white, size: 20.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold)),
        ),
      ]),
    );
  }

  Widget axCard(Widget child) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: axPrimary.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
              color: axPrimary.withValues(alpha: 0.08),
              blurRadius: 6.0,
              offset: Offset(0, 2)),
        ],
      ),
      child: child,
    );
  }

  Widget axInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.0),
      child: Row(children: [
        SizedBox(
          width: 140.0,
          child: Text(label,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: axDark)),
        ),
        Expanded(
          child: Text(value,
              style: TextStyle(
                  fontSize: 12.0,
                  color: valueColor ?? axPrimary,
                  fontWeight: FontWeight.w500)),
        ),
      ]),
    );
  }

  // ============================================================
  // SECTION 1: Title & Overview
  // ============================================================
  print('=== Section 1: Title & Overview ===');

  final axTitleSection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [axDark, axPrimary, axAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
            color: axDark.withValues(alpha: 0.35),
            blurRadius: 14.0,
            offset: Offset(0, 6)),
      ],
    ),
    child: Column(children: [
      Icon(Icons.height, size: 48.0, color: Colors.white),
      SizedBox(height: 10.0),
      Text('Axis',
          style: TextStyle(
              color: Colors.white,
              fontSize: 26.0,
              fontWeight: FontWeight.bold)),
      SizedBox(height: 4.0),
      Text('painting library — enum',
          style: TextStyle(
              color: Colors.white70,
              fontSize: 13.0,
              fontStyle: FontStyle.italic)),
      SizedBox(height: 12.0),
      Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          'The fundamental two-dimensional direction enum. '
          'Axis.horizontal and Axis.vertical drive everything from Row/Column '
          'layout to scroll direction, drag constraints, and responsive design.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 12.0, height: 1.4),
        ),
      ),
    ]),
  );

  // ============================================================
  // SECTION 2: The Two Values — Visual Identity
  // ============================================================
  print('=== Section 2: Two Values Visual ===');

  Widget axValueCard(Axis axis, String symbol, String tagline) {
    final c = axColorFor(axis);
    print('  Axis.${axis.name}: index=${axis.index}');
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: axis == Axis.horizontal
              ? Alignment.centerLeft
              : Alignment.topCenter,
          end: axis == Axis.horizontal
              ? Alignment.centerRight
              : Alignment.bottomCenter,
          colors: [c.withValues(alpha: 0.08), c.withValues(alpha: 0.2)],
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: c, width: 2.0),
      ),
      child: Column(children: [
        Text(symbol,
            style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, color: c)),
        SizedBox(height: 6.0),
        Text(axis.name.toUpperCase(),
            style: TextStyle(
                fontSize: 16.0, fontWeight: FontWeight.bold, color: c)),
        SizedBox(height: 4.0),
        axBadge('index ${axis.index}', c),
        SizedBox(height: 8.0),
        Text(tagline,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700, height: 1.3)),
      ]),
    );
  }

  final axValuesSection = axCard(Column(children: [
    Text('The Two Axis Values',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: axDark)),
    SizedBox(height: 12.0),
    Row(children: [
      Expanded(
        child: axValueCard(Axis.horizontal, '↔',
            'Left-to-right or right-to-left.\nDrives Row, horizontal scroll.'),
      ),
      SizedBox(width: 10.0),
      Expanded(
        child: axValueCard(Axis.vertical, '↕',
            'Top-to-bottom or bottom-to-top.\nDrives Column, vertical scroll.'),
      ),
    ]),
  ]));

  // ============================================================
  // SECTION 3: flipAxis() Demonstration
  // ============================================================
  print('=== Section 3: flipAxis() ===');

  final axFlipH = flipAxis(Axis.horizontal);
  final axFlipV = flipAxis(Axis.vertical);
  print('  flipAxis(horizontal) = ${axFlipH.name}');
  print('  flipAxis(vertical) = ${axFlipV.name}');

  final axFlipSection = axCard(Column(children: [
    Text('flipAxis()',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: axDark)),
    SizedBox(height: 4.0),
    Text('Returns the perpendicular axis — the "other" direction',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 14.0),
    ...[Axis.horizontal, Axis.vertical].map((a) {
      final flipped = flipAxis(a);
      final fc = axColorFor(a);
      final tc = axColorFor(flipped);
      return Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: axPrimary.withValues(alpha: 0.2)),
        ),
        child: Row(children: [
          Container(
            width: 44.0,
            height: 44.0,
            decoration: BoxDecoration(
              color: fc.withValues(alpha: 0.12),
              shape: BoxShape.circle,
              border: Border.all(color: fc, width: 1.5),
            ),
            child: Center(child: Icon(axIconFor(a), color: fc, size: 24.0)),
          ),
          SizedBox(width: 8.0),
          Text(a.name,
              style: TextStyle(
                  fontSize: 13.0, fontWeight: FontWeight.w600, color: fc)),
          Expanded(
            child: Center(
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Container(width: 24.0, height: 2.0, color: axPrimary.withValues(alpha: 0.3)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text('flip',
                      style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          color: axPrimary)),
                ),
                Icon(Icons.arrow_forward, size: 16.0, color: axPrimary),
                Container(width: 24.0, height: 2.0, color: axPrimary.withValues(alpha: 0.3)),
              ]),
            ),
          ),
          Text(flipped.name,
              style: TextStyle(
                  fontSize: 13.0, fontWeight: FontWeight.w600, color: tc)),
          SizedBox(width: 8.0),
          Container(
            width: 44.0,
            height: 44.0,
            decoration: BoxDecoration(
              color: tc.withValues(alpha: 0.12),
              shape: BoxShape.circle,
              border: Border.all(color: tc, width: 1.5),
            ),
            child: Center(child: Icon(axIconFor(flipped), color: tc, size: 24.0)),
          ),
        ]),
      );
    }),
  ]));

  // ============================================================
  // SECTION 4: Main Axis vs Cross Axis
  // ============================================================
  print('=== Section 4: Main vs Cross Axis ===');

  Widget axAxisDiagram(Axis mainAxis) {
    final crossAxis = flipAxis(mainAxis);
    final mc = axColorFor(mainAxis);
    final cc = axColorFor(crossAxis);
    final isH = mainAxis == Axis.horizontal;

    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: mc.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: mc.withValues(alpha: 0.3)),
      ),
      child: Column(children: [
        Text(isH ? 'Row / Flex(horizontal)' : 'Column / Flex(vertical)',
            style: TextStyle(
                fontSize: 13.0, fontWeight: FontWeight.bold, color: mc)),
        SizedBox(height: 10.0),
        // Main axis arrow
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: mc.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(children: [
            Container(width: 10.0, height: 10.0,
                decoration: BoxDecoration(color: mc, shape: BoxShape.circle)),
            Expanded(child: Container(height: 2.0, color: mc)),
            Icon(isH ? Icons.arrow_forward : Icons.arrow_downward,
                color: mc, size: 18.0),
            SizedBox(width: 4.0),
            Text('main (${mainAxis.name})',
                style: TextStyle(
                    fontSize: 10.0, fontWeight: FontWeight.bold, color: mc)),
          ]),
        ),
        SizedBox(height: 6.0),
        // Cross axis arrow
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: cc.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(children: [
            Container(width: 10.0, height: 10.0,
                decoration: BoxDecoration(color: cc, shape: BoxShape.circle)),
            Expanded(child: Container(height: 2.0, color: cc)),
            Icon(isH ? Icons.arrow_downward : Icons.arrow_forward,
                color: cc, size: 18.0),
            SizedBox(width: 4.0),
            Text('cross (${crossAxis.name})',
                style: TextStyle(
                    fontSize: 10.0, fontWeight: FontWeight.bold, color: cc)),
          ]),
        ),
      ]),
    );
  }

  final axMainCross = axCard(Column(children: [
    Text('Main Axis vs Cross Axis',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: axDark)),
    SizedBox(height: 4.0),
    Text('Every Flex widget has a main axis (children direction) and a '
        'cross axis (perpendicular)',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    axAxisDiagram(Axis.horizontal),
    SizedBox(height: 10.0),
    axAxisDiagram(Axis.vertical),
  ]));

  // ============================================================
  // SECTION 5: Flex Layout Samples
  // ============================================================
  print('=== Section 5: Flex Layout Samples ===');

  Widget axFlexSample(Axis direction) {
    final c = axColorFor(direction);
    final boxes = List.generate(4, (i) {
      return Container(
        width: 36.0,
        height: 36.0,
        margin: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          color: c.withValues(alpha: 0.15 + i * 0.08),
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: c),
        ),
        child: Center(
          child: Text('$i',
              style: TextStyle(
                  fontSize: 12.0, fontWeight: FontWeight.bold, color: c)),
        ),
      );
    });

    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: c.withValues(alpha: 0.25)),
      ),
      child: Column(children: [
        Text('Flex(direction: Axis.${direction.name})',
            style: TextStyle(
                fontSize: 11.0, fontWeight: FontWeight.bold, color: c)),
        SizedBox(height: 8.0),
        direction == Axis.horizontal
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: boxes,
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: boxes,
              ),
      ]),
    );
  }

  final axFlexSection = axCard(Column(children: [
    Text('Flex Widget — Axis in Action',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: axDark)),
    SizedBox(height: 4.0),
    Text('Flex accepts direction parameter to lay children out on the given Axis',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: axFlexSample(Axis.horizontal)),
        SizedBox(width: 10.0),
        Expanded(child: axFlexSample(Axis.vertical)),
      ],
    ),
  ]));

  // ============================================================
  // SECTION 6: Scroll Direction Samples
  // ============================================================
  print('=== Section 6: Scroll Direction ===');

  Widget axScrollSample(Axis dir) {
    final c = axColorFor(dir);
    final isH = dir == Axis.horizontal;
    final items = List.generate(5, (i) {
      return Container(
        width: isH ? 48.0 : double.infinity,
        height: isH ? double.infinity : 28.0,
        margin: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: c.withValues(alpha: 0.1 + i * 0.06),
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(color: c.withValues(alpha: 0.3)),
        ),
        child: Center(
          child: Text('${i + 1}',
              style: TextStyle(fontSize: 10.0, color: c, fontWeight: FontWeight.w600)),
        ),
      );
    });

    return Container(
      width: isH ? double.infinity : 140.0,
      height: isH ? 60.0 : 170.0,
      padding: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: c, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(axIconFor(dir), size: 12.0, color: c),
            SizedBox(width: 4.0),
            Text('ListView(scrollDirection: Axis.${dir.name})',
                style: TextStyle(
                    fontSize: 9.0, fontWeight: FontWeight.bold, color: c)),
          ]),
          SizedBox(height: 4.0),
          Expanded(
            child: isH
                ? Row(children: items)
                : Column(children: items),
          ),
        ],
      ),
    );
  }

  final axScrollSection = axCard(Column(children: [
    Text('Scroll Direction',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: axDark)),
    SizedBox(height: 4.0),
    Text('ListView.scrollDirection accepts an Axis to scroll horizontally or vertically',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    axScrollSample(Axis.horizontal),
    SizedBox(height: 10.0),
    Center(child: axScrollSample(Axis.vertical)),
  ]));

  // ============================================================
  // SECTION 7: Wrap Widget — Both Axes
  // ============================================================
  print('=== Section 7: Wrap Widget ===');

  Widget axWrapSample(Axis dir) {
    final c = axColorFor(dir);
    final chips = List.generate(9, (i) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        margin: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: c.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: c.withValues(alpha: 0.4)),
        ),
        child: Text('Tag $i',
            style: TextStyle(
                fontSize: 10.0, fontWeight: FontWeight.w500, color: c)),
      );
    });

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: c.withValues(alpha: 0.2)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Wrap(direction: Axis.${dir.name})',
            style: TextStyle(
                fontSize: 11.0, fontWeight: FontWeight.bold, color: c)),
        SizedBox(height: 6.0),
        Wrap(
          direction: dir,
          spacing: 4.0,
          runSpacing: 4.0,
          children: chips,
        ),
      ]),
    );
  }

  final axWrapSection = axCard(Column(children: [
    Text('Wrap Widget',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: axDark)),
    SizedBox(height: 4.0),
    Text('Wrap lays out children along the given axis and wraps to the '
        'next run when space runs out',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    axWrapSample(Axis.horizontal),
    SizedBox(height: 10.0),
    axWrapSample(Axis.vertical),
  ]));

  // ============================================================
  // SECTION 8: AxisDirection Mapping
  // ============================================================
  print('=== Section 8: AxisDirection Mapping ===');

  final axDirMapping = axCard(Column(children: [
    Text('Axis ↔ AxisDirection',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: axDark)),
    SizedBox(height: 4.0),
    Text('Each Axis maps to exactly two AxisDirection values',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Row(children: [
      Expanded(
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: axHoriz.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: axHoriz.withValues(alpha: 0.3)),
          ),
          child: Column(children: [
            Text('Axis.horizontal',
                style: TextStyle(
                    fontSize: 12.0, fontWeight: FontWeight.bold, color: axHoriz)),
            SizedBox(height: 8.0),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Column(children: [
                Icon(Icons.arrow_back, color: axHoriz, size: 24.0),
                Text('left', style: TextStyle(fontSize: 10.0, color: axHoriz)),
              ]),
              Column(children: [
                Icon(Icons.arrow_forward, color: axHoriz, size: 24.0),
                Text('right', style: TextStyle(fontSize: 10.0, color: axHoriz)),
              ]),
            ]),
          ]),
        ),
      ),
      SizedBox(width: 10.0),
      Expanded(
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: axVert.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: axVert.withValues(alpha: 0.3)),
          ),
          child: Column(children: [
            Text('Axis.vertical',
                style: TextStyle(
                    fontSize: 12.0, fontWeight: FontWeight.bold, color: axVert)),
            SizedBox(height: 8.0),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Column(children: [
                Icon(Icons.arrow_upward, color: axVert, size: 24.0),
                Text('up', style: TextStyle(fontSize: 10.0, color: axVert)),
              ]),
              Column(children: [
                Icon(Icons.arrow_downward, color: axVert, size: 24.0),
                Text('down', style: TextStyle(fontSize: 10.0, color: axVert)),
              ]),
            ]),
          ]),
        ),
      ),
    ]),
  ]));

  // ============================================================
  // SECTION 9: MainAxisSize Interaction
  // ============================================================
  print('=== Section 9: MainAxisSize Interaction ===');

  Widget axSizeSample(MainAxisSize mainSize, Axis dir) {
    final c = axColorFor(dir);
    final isH = dir == Axis.horizontal;
    final boxes = List.generate(2, (i) {
      return Container(
        width: 30.0,
        height: 30.0,
        margin: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: c.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(color: c),
        ),
      );
    });

    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(vertical: 3.0),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: c.withValues(alpha: 0.2)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('MainAxisSize.${mainSize == MainAxisSize.max ? "max" : "min"} '
            '+ Axis.${dir.name}',
            style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: c)),
        SizedBox(height: 4.0),
        isH
            ? Row(
                mainAxisSize: mainSize,
                children: boxes,
              )
            : Column(
                mainAxisSize: mainSize,
                children: boxes,
              ),
      ]),
    );
  }

  final axSizeSection = axCard(Column(children: [
    Text('MainAxisSize Interaction',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: axDark)),
    SizedBox(height: 4.0),
    Text('MainAxisSize.max vs min controls how much space the Flex takes along its Axis',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 10.0),
    axSizeSample(MainAxisSize.max, Axis.horizontal),
    axSizeSample(MainAxisSize.min, Axis.horizontal),
    axSizeSample(MainAxisSize.max, Axis.vertical),
    axSizeSample(MainAxisSize.min, Axis.vertical),
  ]));

  // ============================================================
  // SECTION 10: Divider Orientation
  // ============================================================
  print('=== Section 10: Divider Orientation ===');

  final axDividerSection = axCard(Column(children: [
    Text('Divider as Axis Indicator',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: axDark)),
    SizedBox(height: 4.0),
    Text('A Divider runs perpendicular to the current Axis',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Row(children: [
      Expanded(
        child: Container(
          height: 80.0,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: axHoriz.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: axHoriz.withValues(alpha: 0.2)),
          ),
          child: Column(children: [
            Text('In a Row',
                style: TextStyle(
                    fontSize: 11.0, fontWeight: FontWeight.bold, color: axHoriz)),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 30.0, height: 30.0,
                      decoration: BoxDecoration(
                          color: axHoriz.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4.0))),
                  Container(
                      width: 2.0,
                      height: 40.0,
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      color: axHoriz),
                  Container(width: 30.0, height: 30.0,
                      decoration: BoxDecoration(
                          color: axHoriz.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(4.0))),
                ],
              ),
            ),
            Text('vertical divider',
                style: TextStyle(fontSize: 9.0, color: axHoriz)),
          ]),
        ),
      ),
      SizedBox(width: 10.0),
      Expanded(
        child: Container(
          height: 80.0,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: axVert.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: axVert.withValues(alpha: 0.2)),
          ),
          child: Column(children: [
            Text('In a Column',
                style: TextStyle(
                    fontSize: 11.0, fontWeight: FontWeight.bold, color: axVert)),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 60.0, height: 14.0,
                      decoration: BoxDecoration(
                          color: axVert.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4.0))),
                  Container(
                      width: 60.0,
                      height: 2.0,
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      color: axVert),
                  Container(width: 60.0, height: 14.0,
                      decoration: BoxDecoration(
                          color: axVert.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(4.0))),
                ],
              ),
            ),
            Text('horizontal divider',
                style: TextStyle(fontSize: 9.0, color: axVert)),
          ]),
        ),
      ),
    ]),
  ]));

  // ============================================================
  // SECTION 11: Widgets that Accept Axis
  // ============================================================
  print('=== Section 11: Widgets that Accept Axis ===');

  final axWidgetData = <Map<String, String>>[
    {'widget': 'Row / Column', 'usage': 'Implicit via widget type',
      'note': 'Row = horizontal, Column = vertical'},
    {'widget': 'Flex', 'usage': 'direction property',
      'note': 'Generic flexible layout with explicit Axis'},
    {'widget': 'ListView', 'usage': 'scrollDirection',
      'note': 'Sets the scrolling axis'},
    {'widget': 'GridView', 'usage': 'scrollDirection',
      'note': 'Sets the main-axis scrolling direction'},
    {'widget': 'Wrap', 'usage': 'direction',
      'note': 'Children laid along the axis, wrapping on the cross'},
    {'widget': 'Scrollbar', 'usage': 'Inferred from child',
      'note': 'Draws on the cross-axis edge'},
    {'widget': 'Dismissible', 'usage': 'direction',
      'note': 'Controls swipe axis for dismiss gesture'},
    {'widget': 'Draggable', 'usage': 'axis (optional)',
      'note': 'Constrains drag to a single axis'},
  ];

  final axWidgetRows = <TableRow>[
    TableRow(children: [
      Padding(padding: EdgeInsets.all(8.0), child: Text('Widget',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0, color: axDark))),
      Padding(padding: EdgeInsets.all(8.0), child: Text('Axis Usage',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0, color: axDark))),
      Padding(padding: EdgeInsets.all(8.0), child: Text('Note',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0, color: axDark))),
    ]),
  ];
  for (var i = 0; i < axWidgetData.length; i++) {
    final w = axWidgetData[i];
    axWidgetRows.add(TableRow(
      decoration: BoxDecoration(
        color: i.isEven ? Colors.white : axSurface.withValues(alpha: 0.5),
      ),
      children: [
        Padding(padding: EdgeInsets.all(8.0), child: Text(w['widget']!,
            style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: axPrimary))),
        Padding(padding: EdgeInsets.all(8.0), child: Text(w['usage']!,
            style: TextStyle(fontSize: 11.0))),
        Padding(padding: EdgeInsets.all(8.0), child: Text(w['note']!,
            style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600))),
      ],
    ));
  }

  final axWidgetTable = axCard(Column(children: [
    Text('Widgets That Accept Axis',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: axDark)),
    SizedBox(height: 10.0),
    Table(
      border: TableBorder.all(color: axPrimary.withValues(alpha: 0.15)),
      columnWidths: {
        0: FixedColumnWidth(110.0),
        1: FixedColumnWidth(120.0),
        2: FlexColumnWidth(),
      },
      children: axWidgetRows,
    ),
  ]));

  // ============================================================
  // SECTION 12: Responsive Pattern — Axis Switch
  // ============================================================
  print('=== Section 12: Responsive Pattern ===');

  final axResponsiveSection = axCard(Column(children: [
    Text('Responsive Axis Switching',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: axDark)),
    SizedBox(height: 4.0),
    Text('A common pattern: switch Axis based on screen width to adapt layout '
        'between phone and tablet',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Row(children: [
      Expanded(
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: axVert.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: axVert.withValues(alpha: 0.3)),
          ),
          child: Column(children: [
            Icon(Icons.phone_android, size: 28.0, color: axVert),
            SizedBox(height: 4.0),
            Text('Narrow  (< 600 px)',
                style: TextStyle(
                    fontSize: 11.0, fontWeight: FontWeight.bold, color: axVert)),
            SizedBox(height: 6.0),
            Text('Axis.vertical',
                style: TextStyle(fontSize: 12.0, color: axVert)),
            SizedBox(height: 4.0),
            Text('Cards stacked top-to-bottom',
                style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
          ]),
        ),
      ),
      SizedBox(width: 10.0),
      Expanded(
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: axHoriz.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: axHoriz.withValues(alpha: 0.3)),
          ),
          child: Column(children: [
            Icon(Icons.tablet_mac, size: 28.0, color: axHoriz),
            SizedBox(height: 4.0),
            Text('Wide  (≥ 600 px)',
                style: TextStyle(
                    fontSize: 11.0, fontWeight: FontWeight.bold, color: axHoriz)),
            SizedBox(height: 6.0),
            Text('Axis.horizontal',
                style: TextStyle(fontSize: 12.0, color: axHoriz)),
            SizedBox(height: 4.0),
            Text('Cards side-by-side in a row',
                style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
          ]),
        ),
      ),
    ]),
    SizedBox(height: 10.0),
    Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: axSurface,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        'final axis = width >= 600 ? Axis.horizontal : Axis.vertical;\n'
        'return Flex(direction: axis, children: cards);',
        style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: axDark, height: 1.4),
      ),
    ),
  ]));

  // ============================================================
  // SECTION 13: Drag Constraint Visual
  // ============================================================
  print('=== Section 13: Drag Constraints ===');

  Widget axDragBox(Axis? constrainedAxis) {
    final label = constrainedAxis == null
        ? 'Free drag'
        : 'Axis.${constrainedAxis.name} only';
    final c = constrainedAxis == null
        ? axPrimary
        : axColorFor(constrainedAxis);

    final isV = constrainedAxis == Axis.vertical;

    return Container(
      width: 120.0,
      height: 100.0,
      margin: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: c.withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 34.0,
            height: 34.0,
            decoration: BoxDecoration(
              color: c.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(color: c, width: 2.0),
            ),
            child: Center(child: Icon(Icons.open_with, size: 18.0, color: c)),
          ),
          SizedBox(height: 6.0),
          // Arrows showing drag freedom
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            if (!isV)
              Icon(Icons.arrow_back, size: 14.0, color: c),
            if (constrainedAxis == null || isV)
              Icon(Icons.arrow_upward, size: 14.0, color: c),
            if (constrainedAxis == null || isV)
              Icon(Icons.arrow_downward, size: 14.0, color: c),
            if (!isV)
              Icon(Icons.arrow_forward, size: 14.0, color: c),
          ]),
          SizedBox(height: 4.0),
          Text(label,
              style: TextStyle(
                  fontSize: 9.0, fontWeight: FontWeight.w600, color: c)),
        ],
      ),
    );
  }

  final axDragSection = axCard(Column(children: [
    Text('Drag Axis Constraint',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: axDark)),
    SizedBox(height: 4.0),
    Text('Draggable.axis constrains movement to a single Axis (or null for free)',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      alignment: WrapAlignment.center,
      children: [
        axDragBox(null),
        axDragBox(Axis.horizontal),
        axDragBox(Axis.vertical),
      ],
    ),
  ]));

  // ============================================================
  // SECTION 14: Equality & Properties
  // ============================================================
  print('=== Section 14: Equality & Properties ===');

  final axEq1 = Axis.horizontal == Axis.horizontal;
  final axEq2 = Axis.horizontal == Axis.vertical;
  print('  horizontal == horizontal: $axEq1');
  print('  horizontal == vertical: $axEq2');

  final axEqualitySection = axCard(Column(children: [
    Text('Enum Equality & Properties',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: axDark)),
    SizedBox(height: 10.0),
    axInfoRow('horizontal == horizontal', '$axEq1', valueColor: Colors.teal.shade700),
    axInfoRow('horizontal == vertical', '$axEq2', valueColor: Colors.red.shade700),
    axInfoRow('values.length', '${Axis.values.length}'),
    Divider(color: axPrimary.withValues(alpha: 0.15)),
    axInfoRow('horizontal.index', '${Axis.horizontal.index}'),
    axInfoRow('vertical.index', '${Axis.vertical.index}'),
    axInfoRow('horizontal.name', Axis.horizontal.name),
    axInfoRow('vertical.name', Axis.vertical.name),
  ]));

  // ============================================================
  // SECTION 15: When to Choose Each Axis
  // ============================================================
  print('=== Section 15: When to Choose ===');

  Widget axChoiceCard(Axis axis, List<String> useCases) {
    final c = axColorFor(axis);
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: c.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(axIconFor(axis), color: c, size: 20.0),
            SizedBox(width: 6.0),
            Text('Axis.${axis.name}',
                style: TextStyle(
                    fontSize: 13.0, fontWeight: FontWeight.bold, color: c)),
          ]),
          SizedBox(height: 8.0),
          ...useCases.map((uc) => Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(fontSize: 11.0, color: c)),
                    Expanded(
                      child: Text(uc,
                          style: TextStyle(
                              fontSize: 11.0, color: Colors.grey.shade700, height: 1.3)),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  final axChoiceSection = axCard(Column(children: [
    Text('When to Choose Each Axis',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: axDark)),
    SizedBox(height: 12.0),
    axChoiceCard(Axis.horizontal, [
      'Image carousels and galleries',
      'Tab bars and navigation strips',
      'Horizontal chip/tag lists',
      'Side-by-side comparison views',
      'Dashboard metric rows',
    ]),
    SizedBox(height: 10.0),
    axChoiceCard(Axis.vertical, [
      'Social feeds and timelines',
      'Settings / form screens',
      'Chat message lists',
      'News article lists',
      'E-commerce product grids',
    ]),
  ]));

  // ============================================================
  // SECTION 16: Complete Summary Dashboard
  // ============================================================
  print('=== Section 16: Summary Dashboard ===');

  final axSummarySection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [axDark, axPrimary]),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(children: [
      Text('Axis — Summary',
          style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold)),
      SizedBox(height: 12.0),
      Row(children: [
        Expanded(child: Column(children: [
          Text('2', style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.bold)),
          Text('values', style: TextStyle(color: Colors.white70, fontSize: 11.0)),
        ])),
        Expanded(child: Column(children: [
          Text('1', style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.bold)),
          Text('helper (flip)', style: TextStyle(color: Colors.white70, fontSize: 11.0)),
        ])),
        Expanded(child: Column(children: [
          Text('8+', style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.bold)),
          Text('widgets', style: TextStyle(color: Colors.white70, fontSize: 11.0)),
        ])),
      ]),
      SizedBox(height: 12.0),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          'Axis is the simplest yet most pervasive enum in Flutter layout. '
          'Every scrollable, every Flex, and every Wrap depends on it. '
          'Understanding Axis — and its relationship to AxisDirection — is '
          'the key to mastering Flutter layout composition.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 11.0, height: 1.4),
        ),
      ),
    ]),
  );

  print('Axis Deep Demo complete');

  // ── Assemble ─────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1 Title
        axTitleSection,
        SizedBox(height: 16.0),
        // 2 Values
        axSectionHeader('The Two Values', Icons.looks_two),
        axValuesSection,
        // 3 Flip
        axSectionHeader('flipAxis()', Icons.swap_calls),
        axFlipSection,
        // 4 Main/Cross
        axSectionHeader('Main vs Cross Axis', Icons.compare_arrows),
        axMainCross,
        // 5 Flex
        axSectionHeader('Flex Layout Samples', Icons.view_stream),
        axFlexSection,
        // 6 Scroll
        axSectionHeader('Scroll Direction', Icons.view_list),
        axScrollSection,
        // 7 Wrap
        axSectionHeader('Wrap Widget', Icons.wrap_text),
        axWrapSection,
        // 8 AxisDirection
        axSectionHeader('AxisDirection Mapping', Icons.explore),
        axDirMapping,
        // 9 MainAxisSize
        axSectionHeader('MainAxisSize Interaction', Icons.expand),
        axSizeSection,
        // 10 Divider
        axSectionHeader('Divider Orientation', Icons.horizontal_rule),
        axDividerSection,
        // 11 Widgets
        axSectionHeader('Widgets That Accept Axis', Icons.widgets),
        axWidgetTable,
        // 12 Responsive
        axSectionHeader('Responsive Pattern', Icons.devices),
        axResponsiveSection,
        // 13 Drag
        axSectionHeader('Drag Constraints', Icons.pan_tool),
        axDragSection,
        // 14 Equality
        axSectionHeader('Equality & Properties', Icons.check_circle_outline),
        axEqualitySection,
        // 15 When to Choose
        axSectionHeader('When to Choose Each Axis', Icons.lightbulb_outline),
        axChoiceSection,
        // 16 Summary
        SizedBox(height: 8.0),
        axSummarySection,
      ],
    ),
  );
}
