// ignore_for_file: avoid_print
// D4rt test script: Deep demo for BorderStyle enum from painting
// Demonstrates solid vs none border rendering, per-side control,
// width variations, table borders, input decorations, and conditional styling.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BorderStyle Deep Demo executing');

  // ── palette ──────────────────────────────────────────────────
  final Color bsPrimary = Color(0xFF455A64); // blue-grey 700
  final Color bsAccent = Color(0xFF607D8B); // blue-grey 500
  final Color bsSurface = Color(0xFFECEFF1); // blue-grey 50
  final Color bsSolid = Color(0xFF1B5E20); // green 900
  final Color bsNone = Color(0xFFB71C1C); // red 900
  final Color bsDark = Color(0xFF212121); // grey 900

  Widget bsBadge(String text, Color color) {
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

  Widget bsSectionHeader(String title, IconData icon) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      margin: EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [bsPrimary, bsAccent]),
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

  Widget bsCard(Widget child) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: bsPrimary.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
              color: bsPrimary.withValues(alpha: 0.08),
              blurRadius: 6.0,
              offset: Offset(0, 2)),
        ],
      ),
      child: child,
    );
  }

  Widget bsInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.0),
      child: Row(children: [
        SizedBox(
          width: 140.0,
          child: Text(label,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: bsDark)),
        ),
        Expanded(
          child: Text(value,
              style: TextStyle(
                  fontSize: 12.0,
                  color: valueColor ?? bsPrimary,
                  fontWeight: FontWeight.w500)),
        ),
      ]),
    );
  }

  // ============================================================
  // SECTION 1: Title & Overview
  // ============================================================
  print('=== Section 1: Title & Overview ===');

  final bsTitleSection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [bsDark, bsPrimary, bsAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
            color: bsDark.withValues(alpha: 0.35),
            blurRadius: 14.0,
            offset: Offset(0, 6)),
      ],
    ),
    child: Column(children: [
      Icon(Icons.border_style, size: 48.0, color: Colors.white),
      SizedBox(height: 10.0),
      Text('BorderStyle',
          style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
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
          'Controls whether a border line is actually painted. '
          'BorderStyle.solid draws a visible line; BorderStyle.none '
          'suppresses it entirely. Used in BorderSide, Border, '
          'OutlineInputBorder, and TableBorder.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 12.0, height: 1.4),
        ),
      ),
    ]),
  );

  // ============================================================
  // SECTION 2: The Two Values — Side by Side
  // ============================================================
  print('=== Section 2: Two Values ===');

  Widget bsValueCard(BorderStyle style, String explanation, Color color) {
    print('  BorderStyle.${style.name}: index=${style.index}');
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: style == BorderStyle.solid ? color : Colors.transparent,
            width: 3.0,
            style: style,
          ),
        ),
        child: Column(children: [
          Icon(
            style == BorderStyle.solid ? Icons.check_box_outlined : Icons.disabled_by_default_outlined,
            size: 36.0,
            color: color,
          ),
          SizedBox(height: 8.0),
          Text(style.name.toUpperCase(),
              style: TextStyle(
                  fontSize: 16.0, fontWeight: FontWeight.bold, color: color)),
          SizedBox(height: 4.0),
          bsBadge('index ${style.index}', color),
          SizedBox(height: 8.0),
          Text(explanation,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700, height: 1.3)),
        ]),
      ),
    );
  }

  final bsValuesSection = bsCard(Column(children: [
    Text('The Two BorderStyle Values',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bsDark)),
    SizedBox(height: 12.0),
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        bsValueCard(BorderStyle.none,
            'No border is painted.\nThe border width still takes up space '
                'in hit-testing but nothing renders.',
            bsNone),
        SizedBox(width: 12.0),
        bsValueCard(BorderStyle.solid,
            'A solid line is drawn.\nThis is the default for BorderSide '
                'when constructed with width > 0.',
            bsSolid),
      ],
    ),
  ]));

  // ============================================================
  // SECTION 3: Visual Comparison — Same Box with Different Styles
  // ============================================================
  print('=== Section 3: Visual Comparison ===');

  Widget bsDemoBox(BorderStyle style, double width, Color color, String label) {
    final borderSide = BorderSide(
      color: color,
      width: width,
      style: style,
    );
    return Container(
      width: 100.0,
      height: 80.0,
      margin: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: bsSurface,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: color,
          width: width,
          style: style,
        ),
      ),
      child: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10.0, fontWeight: FontWeight.bold, color: bsDark)),
          SizedBox(height: 2.0),
          Text('side.style: ${borderSide.style.name}',
              style: TextStyle(fontSize: 9.0, color: Colors.grey.shade600)),
        ]),
      ),
    );
  }

  final bsComparisonSection = bsCard(Column(children: [
    Text('Visual Comparison',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bsDark)),
    SizedBox(height: 4.0),
    Text('Identical boxes, same color and width — only BorderStyle differs',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Wrap(
      alignment: WrapAlignment.center,
      spacing: 4.0,
      runSpacing: 4.0,
      children: [
        bsDemoBox(BorderStyle.solid, 1.0, Colors.blue.shade700, 'solid\n1.0'),
        bsDemoBox(BorderStyle.none, 1.0, Colors.blue.shade700, 'none\n1.0'),
        bsDemoBox(BorderStyle.solid, 3.0, Colors.teal.shade700, 'solid\n3.0'),
        bsDemoBox(BorderStyle.none, 3.0, Colors.teal.shade700, 'none\n3.0'),
        bsDemoBox(BorderStyle.solid, 5.0, Colors.purple.shade700, 'solid\n5.0'),
        bsDemoBox(BorderStyle.none, 5.0, Colors.purple.shade700, 'none\n5.0'),
      ],
    ),
  ]));

  // ============================================================
  // SECTION 4: Per-Side Border Control
  // ============================================================
  print('=== Section 4: Per-Side Border Control ===');

  Widget bsSideBox(String label, Border border) {
    return Container(
      width: 120.0,
      height: 80.0,
      margin: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: border,
      ),
      child: Center(
        child: Text(label,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 10.0, fontWeight: FontWeight.w600, color: bsDark)),
      ),
    );
  }

  final bsSolidSide = BorderSide(color: bsSolid, width: 3.0, style: BorderStyle.solid);
  final bsNoneSide = BorderSide(color: bsNone, width: 3.0, style: BorderStyle.none);

  final bsPerSideSection = bsCard(Column(children: [
    Text('Per-Side Border Control',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bsDark)),
    SizedBox(height: 4.0),
    Text('Each side of a Border can independently have solid or none style',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Wrap(
      alignment: WrapAlignment.center,
      spacing: 4.0,
      runSpacing: 4.0,
      children: [
        bsSideBox('All solid', Border(
            top: bsSolidSide, right: bsSolidSide,
            bottom: bsSolidSide, left: bsSolidSide)),
        bsSideBox('Top only', Border(
            top: bsSolidSide, right: bsNoneSide,
            bottom: bsNoneSide, left: bsNoneSide)),
        bsSideBox('Bottom only', Border(
            top: bsNoneSide, right: bsNoneSide,
            bottom: bsSolidSide, left: bsNoneSide)),
        bsSideBox('Left + Right', Border(
            top: bsNoneSide, right: bsSolidSide,
            bottom: bsNoneSide, left: bsSolidSide)),
        bsSideBox('Top + Bottom', Border(
            top: bsSolidSide, right: bsNoneSide,
            bottom: bsSolidSide, left: bsNoneSide)),
        bsSideBox('All none', Border(
            top: bsNoneSide, right: bsNoneSide,
            bottom: bsNoneSide, left: bsNoneSide)),
      ],
    ),
  ]));

  // ============================================================
  // SECTION 5: BorderSide Properties Deep Dive
  // ============================================================
  print('=== Section 5: BorderSide Properties ===');

  final bsSide1 = BorderSide(color: Colors.indigo, width: 2.0, style: BorderStyle.solid);
  final bsSide2 = BorderSide.none;
  print('  solid side: color=${bsSide1.color}, width=${bsSide1.width}, style=${bsSide1.style}');
  print('  none side: color=${bsSide2.color}, width=${bsSide2.width}, style=${bsSide2.style}');

  final bsBorderSideSection = bsCard(Column(children: [
    Text('BorderSide Properties',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bsDark)),
    SizedBox(height: 4.0),
    Text('BorderSide is the carrier of BorderStyle — each side has its own style',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: bsSolid.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: bsSolid.withValues(alpha: 0.3)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('BorderSide(color: indigo, width: 2.0, style: solid)',
            style: TextStyle(
                fontSize: 11.0, fontWeight: FontWeight.bold, color: bsSolid)),
        SizedBox(height: 6.0),
        bsInfoRow('color', '${bsSide1.color}'),
        bsInfoRow('width', '${bsSide1.width}'),
        bsInfoRow('style', '${bsSide1.style}'),
        bsInfoRow('strokeAlign', '${bsSide1.strokeAlign}'),
      ]),
    ),
    SizedBox(height: 10.0),
    Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: bsNone.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: bsNone.withValues(alpha: 0.3)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('BorderSide.none',
            style: TextStyle(
                fontSize: 11.0, fontWeight: FontWeight.bold, color: bsNone)),
        SizedBox(height: 6.0),
        bsInfoRow('color', '${bsSide2.color}'),
        bsInfoRow('width', '${bsSide2.width}'),
        bsInfoRow('style', '${bsSide2.style}'),
      ]),
    ),
  ]));

  // ============================================================
  // SECTION 6: Width Variations Gallery
  // ============================================================
  print('=== Section 6: Width Gallery ===');

  final bsWidths = [0.5, 1.0, 2.0, 3.0, 4.0, 6.0, 8.0];
  final bsWidthCards = bsWidths.map((w) {
    return Container(
      width: 80.0,
      height: 70.0,
      margin: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(
          color: bsPrimary,
          width: w,
          style: BorderStyle.solid,
        ),
      ),
      child: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('${w}px',
              style: TextStyle(
                  fontSize: 13.0, fontWeight: FontWeight.bold, color: bsDark)),
          Text('solid',
              style: TextStyle(fontSize: 9.0, color: Colors.grey.shade600)),
        ]),
      ),
    );
  }).toList();

  final bsWidthSection = bsCard(Column(children: [
    Text('Border Width Gallery',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bsDark)),
    SizedBox(height: 4.0),
    Text('All use BorderStyle.solid — only the width changes',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Wrap(
      alignment: WrapAlignment.center,
      spacing: 4.0,
      runSpacing: 4.0,
      children: bsWidthCards,
    ),
  ]));

  // ============================================================
  // SECTION 7: Color + Style Combinations
  // ============================================================
  print('=== Section 7: Color Combinations ===');

  final bsColorCombos = <Map<String, dynamic>>[
    {'color': Colors.red.shade700, 'label': 'Red'},
    {'color': Colors.blue.shade700, 'label': 'Blue'},
    {'color': Colors.green.shade700, 'label': 'Green'},
    {'color': Colors.orange.shade700, 'label': 'Orange'},
    {'color': Colors.purple.shade700, 'label': 'Purple'},
    {'color': Colors.teal.shade700, 'label': 'Teal'},
  ];

  final bsColorCards = bsColorCombos.map((combo) {
    final c = combo['color'] as Color;
    final label = combo['label'] as String;
    return Container(
      width: 90.0,
      height: 70.0,
      margin: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: c, width: 2.5, style: BorderStyle.solid),
      ),
      child: Center(
        child: Text(label,
            style: TextStyle(
                fontSize: 12.0, fontWeight: FontWeight.bold, color: c)),
      ),
    );
  }).toList();

  final bsColorSection = bsCard(Column(children: [
    Text('Color + Solid Style',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bsDark)),
    SizedBox(height: 4.0),
    Text('BorderStyle.solid with different border colors',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Wrap(
      alignment: WrapAlignment.center,
      spacing: 4.0,
      runSpacing: 4.0,
      children: bsColorCards,
    ),
  ]));

  // ============================================================
  // SECTION 8: Table Borders
  // ============================================================
  print('=== Section 8: Table Borders ===');

  Widget bsTableSample(String label, TableBorder tableBorder) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label,
            style: TextStyle(
                fontSize: 11.0, fontWeight: FontWeight.bold, color: bsPrimary)),
        SizedBox(height: 4.0),
        Table(
          border: tableBorder,
          columnWidths: {
            0: FixedColumnWidth(80.0),
            1: FixedColumnWidth(80.0),
            2: FixedColumnWidth(80.0),
          },
          children: [
            TableRow(children: [
              Padding(padding: EdgeInsets.all(8.0), child: Text('A1', style: TextStyle(fontSize: 11.0))),
              Padding(padding: EdgeInsets.all(8.0), child: Text('B1', style: TextStyle(fontSize: 11.0))),
              Padding(padding: EdgeInsets.all(8.0), child: Text('C1', style: TextStyle(fontSize: 11.0))),
            ]),
            TableRow(children: [
              Padding(padding: EdgeInsets.all(8.0), child: Text('A2', style: TextStyle(fontSize: 11.0))),
              Padding(padding: EdgeInsets.all(8.0), child: Text('B2', style: TextStyle(fontSize: 11.0))),
              Padding(padding: EdgeInsets.all(8.0), child: Text('C2', style: TextStyle(fontSize: 11.0))),
            ]),
            TableRow(children: [
              Padding(padding: EdgeInsets.all(8.0), child: Text('A3', style: TextStyle(fontSize: 11.0))),
              Padding(padding: EdgeInsets.all(8.0), child: Text('B3', style: TextStyle(fontSize: 11.0))),
              Padding(padding: EdgeInsets.all(8.0), child: Text('C3', style: TextStyle(fontSize: 11.0))),
            ]),
          ],
        ),
      ]),
    );
  }

  final bsTableSection = bsCard(Column(children: [
    Text('Table Borders',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bsDark)),
    SizedBox(height: 4.0),
    Text('TableBorder uses BorderSide (and thus BorderStyle) for each edge',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    bsTableSample('TableBorder.all(style: solid)',
        TableBorder.all(color: bsPrimary, style: BorderStyle.solid)),
    bsTableSample('Outer solid, inner none',
        TableBorder(
          top: BorderSide(color: bsPrimary, width: 2.0),
          bottom: BorderSide(color: bsPrimary, width: 2.0),
          left: BorderSide(color: bsPrimary, width: 2.0),
          right: BorderSide(color: bsPrimary, width: 2.0),
          horizontalInside: BorderSide(style: BorderStyle.none),
          verticalInside: BorderSide(style: BorderStyle.none),
        )),
    bsTableSample('Horizontal dividers only',
        TableBorder(
          top: BorderSide(style: BorderStyle.none),
          bottom: BorderSide(style: BorderStyle.none),
          left: BorderSide(style: BorderStyle.none),
          right: BorderSide(style: BorderStyle.none),
          horizontalInside: BorderSide(color: bsAccent, width: 1.0),
          verticalInside: BorderSide(style: BorderStyle.none),
        )),
  ]));

  // ============================================================
  // SECTION 9: Shape Interaction
  // ============================================================
  print('=== Section 9: Shape Interaction ===');

  Widget bsShapeBox(BoxShape shape, BorderStyle style, String label) {
    final hasBorder = style == BorderStyle.solid;
    return Container(
      width: 90.0,
      height: 90.0,
      margin: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: hasBorder ? bsSolid.withValues(alpha: 0.06) : bsNone.withValues(alpha: 0.06),
        shape: shape,
        border: Border.all(
          color: hasBorder ? bsSolid : bsNone,
          width: 3.0,
          style: style,
        ),
      ),
      child: Center(
        child: Text(label,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 9.0,
                fontWeight: FontWeight.w600,
                color: hasBorder ? bsSolid : bsNone)),
      ),
    );
  }

  final bsShapeSection = bsCard(Column(children: [
    Text('BoxShape + BorderStyle',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bsDark)),
    SizedBox(height: 4.0),
    Text('BorderStyle applies equally to rectangle and circle shapes',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Wrap(
      alignment: WrapAlignment.center,
      spacing: 4.0,
      runSpacing: 4.0,
      children: [
        bsShapeBox(BoxShape.rectangle, BorderStyle.solid, 'rect\nsolid'),
        bsShapeBox(BoxShape.rectangle, BorderStyle.none, 'rect\nnone'),
        bsShapeBox(BoxShape.circle, BorderStyle.solid, 'circle\nsolid'),
        bsShapeBox(BoxShape.circle, BorderStyle.none, 'circle\nnone'),
      ],
    ),
  ]));

  // ============================================================
  // SECTION 10: Input Decoration Borders
  // ============================================================
  print('=== Section 10: Input Decoration ===');

  Widget bsInputSample(String label, InputBorder border) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label,
            style: TextStyle(
                fontSize: 11.0, fontWeight: FontWeight.bold, color: bsPrimary)),
        SizedBox(height: 4.0),
        InputDecorator(
          decoration: InputDecoration(
            hintText: 'Type here...',
            hintStyle: TextStyle(fontSize: 12.0, color: Colors.grey.shade400),
            border: border,
            enabledBorder: border,
            contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          ),
          child: Text('Sample text',
              style: TextStyle(fontSize: 12.0, color: bsDark)),
        ),
      ]),
    );
  }

  final bsInputSection = bsCard(Column(children: [
    Text('Input Decoration Borders',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bsDark)),
    SizedBox(height: 4.0),
    Text('OutlineInputBorder and UnderlineInputBorder accept borderSide '
        'which carries BorderStyle',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    bsInputSample('OutlineInputBorder (solid)',
        OutlineInputBorder(
          borderSide: BorderSide(color: bsPrimary, width: 2.0, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(8.0),
        )),
    bsInputSample('OutlineInputBorder (none)',
        OutlineInputBorder(
          borderSide: BorderSide(style: BorderStyle.none),
          borderRadius: BorderRadius.circular(8.0),
        )),
    bsInputSample('UnderlineInputBorder (solid)',
        UnderlineInputBorder(
          borderSide: BorderSide(color: bsSolid, width: 2.0, style: BorderStyle.solid),
        )),
    bsInputSample('UnderlineInputBorder (none)',
        UnderlineInputBorder(
          borderSide: BorderSide(style: BorderStyle.none),
        )),
  ]));

  // ============================================================
  // SECTION 11: Conditional Border Pattern
  // ============================================================
  print('=== Section 11: Conditional Borders ===');

  Widget bsConditionalCard(String label, bool isEnabled) {
    final borderStyle = isEnabled ? BorderStyle.solid : BorderStyle.none;
    final borderColor = isEnabled ? bsSolid : bsNone;
    return Container(
      width: 130.0,
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: borderColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: borderColor,
          width: 2.0,
          style: borderStyle,
        ),
      ),
      child: Column(children: [
        Icon(isEnabled ? Icons.check_circle : Icons.cancel,
            color: borderColor, size: 28.0),
        SizedBox(height: 6.0),
        Text(label,
            style: TextStyle(
                fontSize: 11.0, fontWeight: FontWeight.bold, color: borderColor)),
        SizedBox(height: 2.0),
        Text('style: ${borderStyle.name}',
            style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
      ]),
    );
  }

  final bsConditionalSection = bsCard(Column(children: [
    Text('Conditional Borders',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bsDark)),
    SizedBox(height: 4.0),
    Text('A common pattern: toggle BorderStyle based on enabled/selected state',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Wrap(
      alignment: WrapAlignment.center,
      children: [
        bsConditionalCard('Enabled', true),
        bsConditionalCard('Disabled', false),
        bsConditionalCard('Selected', true),
        bsConditionalCard('Unselected', false),
      ],
    ),
    SizedBox(height: 10.0),
    Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: bsSurface,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        'final style = isSelected\n'
        '    ? BorderStyle.solid\n'
        '    : BorderStyle.none;',
        style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: bsDark, height: 1.4),
      ),
    ),
  ]));

  // ============================================================
  // SECTION 12: StrokeAlign Interaction
  // ============================================================
  print('=== Section 12: StrokeAlign ===');

  Widget bsStrokeBox(double strokeAlign, String label) {
    return Container(
      width: 100.0,
      height: 80.0,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: bsSurface,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: bsPrimary,
          width: 4.0,
          style: BorderStyle.solid,
          strokeAlign: strokeAlign,
        ),
      ),
      child: Center(
        child: Text(label,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 10.0, fontWeight: FontWeight.w600, color: bsDark)),
      ),
    );
  }

  final bsStrokeSection = bsCard(Column(children: [
    Text('StrokeAlign (only with solid)',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bsDark)),
    SizedBox(height: 4.0),
    Text('strokeAlign shifts the border line inward, centered, or outward — '
        'only meaningful when style is solid',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Wrap(
      alignment: WrapAlignment.center,
      children: [
        bsStrokeBox(BorderSide.strokeAlignInside, 'Inside\n(-1.0)'),
        bsStrokeBox(BorderSide.strokeAlignCenter, 'Center\n(0.0)'),
        bsStrokeBox(BorderSide.strokeAlignOutside, 'Outside\n(1.0)'),
      ],
    ),
  ]));

  // ============================================================
  // SECTION 13: BorderSide.merge and lerp
  // ============================================================
  print('=== Section 13: merge and lerp ===');

  final bsMerged = BorderSide.merge(
    BorderSide(color: Colors.blue, width: 1.0, style: BorderStyle.solid),
    BorderSide(color: Colors.blue, width: 2.0, style: BorderStyle.solid),
  );
  print('  merged width: ${bsMerged.width}');

  final bsLerpResult = BorderSide.lerp(
    BorderSide(color: Colors.red, width: 0.0, style: BorderStyle.none),
    BorderSide(color: Colors.blue, width: 4.0, style: BorderStyle.solid),
    0.5,
  );
  print('  lerp(none→solid, 0.5): style=${bsLerpResult.style}, width=${bsLerpResult.width}');

  final bsMergeSection = bsCard(Column(children: [
    Text('BorderSide.merge & lerp',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bsDark)),
    SizedBox(height: 10.0),
    Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: bsSurface,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('BorderSide.merge()',
            style: TextStyle(
                fontSize: 12.0, fontWeight: FontWeight.bold, color: bsPrimary)),
        SizedBox(height: 4.0),
        Text('Combines two sides into one by adding widths',
            style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
        bsInfoRow('merge(1.0 + 2.0)', 'width = ${bsMerged.width}'),
        bsInfoRow('merged style', '${bsMerged.style}'),
      ]),
    ),
    SizedBox(height: 10.0),
    Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: bsSurface,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('BorderSide.lerp()',
            style: TextStyle(
                fontSize: 12.0, fontWeight: FontWeight.bold, color: bsPrimary)),
        SizedBox(height: 4.0),
        Text('Interpolates between two sides — style appears at t > 0',
            style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
        bsInfoRow('lerp(none→solid, 0.5)', 'style = ${bsLerpResult.style}'),
        bsInfoRow('lerp width at 0.5', '${bsLerpResult.width}'),
      ]),
    ),
  ]));

  // ============================================================
  // SECTION 14: Equality & Properties
  // ============================================================
  print('=== Section 14: Equality ===');

  final bsEq1 = BorderStyle.none == BorderStyle.none;
  final bsEq2 = BorderStyle.none == BorderStyle.solid;
  print('  none == none: $bsEq1');
  print('  none == solid: $bsEq2');

  final bsEqualitySection = bsCard(Column(children: [
    Text('Enum Equality & Properties',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bsDark)),
    SizedBox(height: 10.0),
    bsInfoRow('none == none', '$bsEq1', valueColor: Colors.teal.shade700),
    bsInfoRow('none == solid', '$bsEq2', valueColor: Colors.red.shade700),
    bsInfoRow('values.length', '${BorderStyle.values.length}'),
    Divider(color: bsPrimary.withValues(alpha: 0.15)),
    bsInfoRow('none.index', '${BorderStyle.none.index}'),
    bsInfoRow('solid.index', '${BorderStyle.solid.index}'),
    bsInfoRow('none.name', BorderStyle.none.name),
    bsInfoRow('solid.name', BorderStyle.solid.name),
  ]));

  // ============================================================
  // SECTION 15: When to Use Each Style
  // ============================================================
  print('=== Section 15: When to Use ===');

  Widget bsUsageBlock(String title, Color color, IconData icon,
      List<String> items) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(icon, color: color, size: 20.0),
          SizedBox(width: 6.0),
          Text(title,
              style: TextStyle(
                  fontSize: 13.0, fontWeight: FontWeight.bold, color: color)),
        ]),
        SizedBox(height: 8.0),
        ...items.map((item) => Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• ', style: TextStyle(fontSize: 11.0, color: color)),
                  Expanded(
                    child: Text(item,
                        style: TextStyle(
                            fontSize: 11.0, color: Colors.grey.shade700, height: 1.3)),
                  ),
                ],
              ),
            )),
      ]),
    );
  }

  final bsUsageSection = bsCard(Column(children: [
    Text('When to Use Each Style',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bsDark)),
    SizedBox(height: 12.0),
    bsUsageBlock('BorderStyle.solid', bsSolid, Icons.check_box_outlined, [
      'Card outlines and container frames',
      'Table grid lines and cell separators',
      'Input field focus/enabled borders',
      'Selected or highlighted items',
      'Visual section dividers',
    ]),
    SizedBox(height: 10.0),
    bsUsageBlock('BorderStyle.none', bsNone, Icons.disabled_by_default_outlined, [
      'Disabled or inactive input fields',
      'Borderless card designs (Material 3)',
      'Conditional borders: show only on hover or selection',
      'Suppressing default borders while preserving other decoration',
      'Removing table inner lines for clean row-based layouts',
    ]),
  ]));

  // ============================================================
  // SECTION 16: Complete Summary Dashboard
  // ============================================================
  print('=== Section 16: Summary Dashboard ===');

  final bsSummarySection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [bsDark, bsPrimary]),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(children: [
      Text('BorderStyle — Summary',
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
          Text('5+', style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.bold)),
          Text('border classes', style: TextStyle(color: Colors.white70, fontSize: 11.0)),
        ])),
        Expanded(child: Column(children: [
          Text('3', style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.bold)),
          Text('stroke aligns', style: TextStyle(color: Colors.white70, fontSize: 11.0)),
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
          'BorderStyle is deceptively simple — just two values — but it '
          'appears in every border-drawing widget in Flutter. The solid/none '
          'toggle is the foundation for conditional borders, animated '
          'transitions, and clean table designs.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 11.0, height: 1.4),
        ),
      ),
    ]),
  );

  print('BorderStyle Deep Demo complete');

  // ── Assemble ─────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1 Title
        bsTitleSection,
        SizedBox(height: 16.0),
        // 2 Values
        bsSectionHeader('The Two Values', Icons.looks_two),
        bsValuesSection,
        // 3 Comparison
        bsSectionHeader('Visual Comparison', Icons.compare),
        bsComparisonSection,
        // 4 Per-Side
        bsSectionHeader('Per-Side Control', Icons.border_all),
        bsPerSideSection,
        // 5 BorderSide
        bsSectionHeader('BorderSide Properties', Icons.info_outline),
        bsBorderSideSection,
        // 6 Width
        bsSectionHeader('Width Gallery', Icons.line_weight),
        bsWidthSection,
        // 7 Color
        bsSectionHeader('Color Combinations', Icons.palette),
        bsColorSection,
        // 8 Table
        bsSectionHeader('Table Borders', Icons.table_chart),
        bsTableSection,
        // 9 Shape
        bsSectionHeader('Shape Interaction', Icons.crop_square),
        bsShapeSection,
        // 10 Input
        bsSectionHeader('Input Decoration', Icons.text_fields),
        bsInputSection,
        // 11 Conditional
        bsSectionHeader('Conditional Borders', Icons.toggle_on),
        bsConditionalSection,
        // 12 StrokeAlign
        bsSectionHeader('Stroke Alignment', Icons.format_align_center),
        bsStrokeSection,
        // 13 Merge/Lerp
        bsSectionHeader('Merge & Lerp', Icons.merge_type),
        bsMergeSection,
        // 14 Equality
        bsSectionHeader('Equality & Properties', Icons.check_circle_outline),
        bsEqualitySection,
        // 15 Usage
        bsSectionHeader('When to Use Each', Icons.lightbulb_outline),
        bsUsageSection,
        // 16 Summary
        SizedBox(height: 8.0),
        bsSummarySection,
      ],
    ),
  );
}
