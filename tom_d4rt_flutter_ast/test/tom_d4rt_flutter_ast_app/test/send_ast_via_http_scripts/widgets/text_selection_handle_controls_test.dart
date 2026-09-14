// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep demo for TextSelectionHandleControls,
// TextSelectionControls, MaterialTextSelectionControls,
// MaterialTextSelectionHandleControls, CupertinoTextSelectionControls,
// CupertinoTextSelectionHandleControls, plus TextSelectionHandleType and
// TextSelectionDelegate.
//
// Theme: Manuscript-illuminator's gilt anchor pins.
// Selection handles are reimagined as gilded brass anchor pins driven into
// vellum at the head, foot, and shoulder of each highlighted passage; the
// toolbar buttons (Select All / Copy / Cut / Paste) become the illuminator's
// burnishing tools laid out on a felted desk.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextSelectionHandleControls Deep Demo executing');
  print('=' * 60);
  print('Theme: manuscript-illuminator gilt anchor pins on vellum.');

  // ============================================================
  // Palette: parchment, gilt, vermilion ink, lapis ink, oak.
  // ============================================================
  final Color parchment = const Color(0xFFF5ECD7);
  final Color parchmentDeep = const Color(0xFFE7D9B1);
  final Color gilt = const Color(0xFFC9A227);
  final Color giltDeep = const Color(0xFF8C6A1A);
  final Color vermilion = const Color(0xFFB23A3A);
  final Color lapis = const Color(0xFF1F3A6B);
  final Color oak = const Color(0xFF5B3A1B);
  final Color ink = const Color(0xFF1B1B1B);

  // ============================================================
  // SECTION 1: Header banner — the illuminator's desk plate.
  // ============================================================
  print('=== Section 1: Header banner ===');
  final Widget header = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [parchment, parchmentDeep, gilt],
        stops: [0.0, 0.55, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: giltDeep, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: giltDeep.withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: oak.withValues(alpha: 0.25),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book, size: 44.0, color: oak),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TextSelectionHandleControls',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.w800,
                      color: ink,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Manuscript-illuminator gilt anchor pins',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontStyle: FontStyle.italic,
                      color: oak,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.push_pin, size: 36.0, color: gilt),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: parchment.withValues(alpha: 0.65),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: giltDeep.withValues(alpha: 0.5)),
          ),
          child: Text(
            'Selection handles are anchor pins. Toolbar buttons are '
            'burnishing tools. Material wears the brass crown; Cupertino '
            'wears the lapis bead.',
            style: TextStyle(fontSize: 12.0, color: ink),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Class hierarchy diagram.
  // ============================================================
  print('=== Section 2: Class hierarchy ===');
  final List<Map<String, Object>> hierarchyRows = [
    {
      'title': 'TextSelectionControls',
      'subtitle': 'abstract base — defines the contract',
      'icon': Icons.account_tree,
      'color': lapis,
      'depth': 0,
    },
    {
      'title': 'MaterialTextSelectionControls',
      'subtitle': 'Material handles + toolbar',
      'icon': Icons.invert_colors,
      'color': vermilion,
      'depth': 1,
    },
    {
      'title': 'MaterialTextSelectionHandleControls',
      'subtitle': 'Material with TextSelectionHandleControls mixin',
      'icon': Icons.push_pin,
      'color': vermilion,
      'depth': 2,
    },
    {
      'title': 'CupertinoTextSelectionControls',
      'subtitle': 'Cupertino handles + toolbar',
      'icon': Icons.water_drop,
      'color': lapis,
      'depth': 1,
    },
    {
      'title': 'CupertinoTextSelectionHandleControls',
      'subtitle': 'Cupertino with TextSelectionHandleControls mixin',
      'icon': Icons.push_pin_outlined,
      'color': lapis,
      'depth': 2,
    },
    {
      'title': 'TextSelectionHandleControls (mixin)',
      'subtitle': 'disables built-in toolbar; keeps handles',
      'icon': Icons.layers,
      'color': gilt,
      'depth': 1,
    },
  ];

  final List<Widget> hierarchyWidgets = <Widget>[];
  for (int i = 0; i < hierarchyRows.length; i++) {
    final Map<String, Object> row = hierarchyRows[i];
    final int depth = row['depth'] as int;
    final Color rowColor = row['color'] as Color;
    final IconData rowIcon = row['icon'] as IconData;
    print('  hierarchy[$i] depth=$depth title=${row['title']}');
    hierarchyWidgets.add(
      Padding(
        padding: EdgeInsets.only(left: depth * 24.0, top: 6.0, bottom: 6.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                rowColor.withValues(alpha: 0.10),
                rowColor.withValues(alpha: 0.22),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: rowColor, width: 1.4),
            boxShadow: [
              BoxShadow(
                color: rowColor.withValues(alpha: 0.25),
                blurRadius: 6.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(rowIcon, color: rowColor, size: 22.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      row['title'] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                        color: rowColor,
                      ),
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      row['subtitle'] as String,
                      style: TextStyle(fontSize: 11.0, color: oak),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 2.0,
                ),
                decoration: BoxDecoration(
                  color: rowColor.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  'lvl $depth',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.0,
                    color: rowColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final Widget hierarchyPanel = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: parchment,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: giltDeep, width: 1.4),
      boxShadow: [
        BoxShadow(
          color: oak.withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: giltDeep, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Selection-controls inheritance ladder',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: ink,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        ...hierarchyWidgets,
      ],
    ),
  );

  // ============================================================
  // SECTION 3: TextSelectionHandleType — the pin triple.
  // ============================================================
  print('=== Section 3: TextSelectionHandleType ===');
  final List<TextSelectionHandleType> handleTypes = [
    TextSelectionHandleType.left,
    TextSelectionHandleType.right,
    TextSelectionHandleType.collapsed,
  ];
  for (int i = 0; i < handleTypes.length; i++) {
    final TextSelectionHandleType t = handleTypes[i];
    print('  TextSelectionHandleType.${t.name} -> index ${t.index}');
  }

  final List<Map<String, Object>> handleTypeData = [
    {
      'type': TextSelectionHandleType.left,
      'label': 'LEFT',
      'subtitle': 'head pin — start of passage',
      'icon': Icons.arrow_left,
      'color': vermilion,
      'flip': false,
    },
    {
      'type': TextSelectionHandleType.right,
      'label': 'RIGHT',
      'subtitle': 'foot pin — end of passage',
      'icon': Icons.arrow_right,
      'color': lapis,
      'flip': true,
    },
    {
      'type': TextSelectionHandleType.collapsed,
      'label': 'COLLAPSED',
      'subtitle': 'caret pin — single point',
      'icon': Icons.fiber_manual_record,
      'color': gilt,
      'flip': false,
    },
  ];

  final List<Widget> handleTypeCards = <Widget>[];
  for (int i = 0; i < handleTypeData.length; i++) {
    final Map<String, Object> d = handleTypeData[i];
    final TextSelectionHandleType t = d['type'] as TextSelectionHandleType;
    final Color c = d['color'] as Color;
    handleTypeCards.add(
      Container(
        width: 170.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [c.withValues(alpha: 0.10), c.withValues(alpha: 0.28)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: c, width: 1.6),
          boxShadow: [
            BoxShadow(
              color: c.withValues(alpha: 0.35),
              blurRadius: 9.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(d['icon'] as IconData, size: 36.0, color: c),
            SizedBox(height: 6.0),
            Text(
              d['label'] as String,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 14.0,
                color: c,
                letterSpacing: 1.1,
              ),
            ),
            SizedBox(height: 2.0),
            Text(
              'index ${t.index}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: oak,
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: parchment.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                d['subtitle'] as String,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10.0, color: ink),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget handleTypePanel = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [parchment, parchmentDeep],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: giltDeep, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.push_pin, color: giltDeep, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'TextSelectionHandleType — the three pins',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: ink,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: handleTypeCards),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Mock handle visualizations — drawn pins on vellum.
  // ============================================================
  print('=== Section 4: Mock handle anatomy ===');
  print('  buildHandle is documented; runtime context not invoked.');

  final List<Widget> mockPins = <Widget>[];
  final List<Map<String, Object>> mockPinData = [
    {
      'caption': 'Material LEFT',
      'pinColor': vermilion,
      'platform': 'Material',
      'side': 'left',
    },
    {
      'caption': 'Material RIGHT',
      'pinColor': vermilion,
      'platform': 'Material',
      'side': 'right',
    },
    {
      'caption': 'Cupertino LEFT',
      'pinColor': lapis,
      'platform': 'Cupertino',
      'side': 'left',
    },
    {
      'caption': 'COLLAPSED caret',
      'pinColor': gilt,
      'platform': 'Either',
      'side': 'collapsed',
    },
  ];

  for (int i = 0; i < mockPinData.length; i++) {
    final Map<String, Object> p = mockPinData[i];
    final Color pinColor = p['pinColor'] as Color;
    final String side = p['side'] as String;
    final bool isLeft = side == 'left';
    final bool isCollapsed = side == 'collapsed';

    // Visual: parchment plate with a drawn baseline and a pin head/stem.
    final Widget pinDrawing = Container(
      width: 200.0,
      height: 140.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [parchment, parchmentDeep],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: giltDeep, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: oak.withValues(alpha: 0.20),
            blurRadius: 6.0,
            offset: Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Vellum text-line guides.
          Positioned(
            left: 12.0,
            right: 12.0,
            top: 60.0,
            child: Container(height: 1.0, color: oak.withValues(alpha: 0.4)),
          ),
          Positioned(
            left: 12.0,
            right: 12.0,
            top: 90.0,
            child: Container(
              height: 1.0,
              color: oak.withValues(alpha: 0.25),
            ),
          ),
          // Highlighted passage.
          Positioned(
            left: isCollapsed ? 92.0 : 30.0,
            right: isCollapsed ? 92.0 : 30.0,
            top: 60.0,
            height: 30.0,
            child: Container(
              decoration: BoxDecoration(
                color: pinColor.withValues(alpha: 0.18),
                border: Border(
                  bottom: BorderSide(color: pinColor, width: 2.0),
                ),
              ),
            ),
          ),
          // Pin stem.
          Positioned(
            left: isCollapsed
                ? 99.0
                : (isLeft ? 28.0 : null),
            right: isCollapsed
                ? null
                : (isLeft ? null : 28.0),
            top: 86.0,
            child: Container(
              width: 3.0,
              height: 38.0,
              decoration: BoxDecoration(
                color: giltDeep,
                borderRadius: BorderRadius.circular(1.5),
              ),
            ),
          ),
          // Pin head.
          Positioned(
            left: isCollapsed
                ? 90.0
                : (isLeft ? 19.0 : null),
            right: isCollapsed
                ? null
                : (isLeft ? null : 19.0),
            top: 116.0,
            child: Container(
              width: 22.0,
              height: 22.0,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [gilt, pinColor],
                ),
                shape: BoxShape.circle,
                border: Border.all(color: giltDeep, width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: pinColor.withValues(alpha: 0.55),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
            ),
          ),
          // Anchor point indicator (cross-hair).
          Positioned(
            left: isCollapsed
                ? 99.0
                : (isLeft ? 30.0 : null),
            right: isCollapsed
                ? null
                : (isLeft ? null : 30.0),
            top: 84.0,
            child: Icon(Icons.add, size: 10.0, color: vermilion),
          ),
        ],
      ),
    );

    mockPins.add(
      Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: parchment.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: pinColor.withValues(alpha: 0.6),
            width: 1.2,
          ),
        ),
        child: Column(
          children: [
            pinDrawing,
            SizedBox(height: 8.0),
            Text(
              p['caption'] as String,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: pinColor,
              ),
            ),
            Text(
              'platform: ${p['platform']}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: oak,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget mockPinsPanel = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [parchmentDeep, parchment],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: giltDeep, width: 1.4),
      boxShadow: [
        BoxShadow(
          color: oak.withValues(alpha: 0.30),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.brush, color: giltDeep, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Mock anchor pins on vellum',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: ink,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'buildHandle returns a Widget; here we sketch its silhouette '
          'without invoking it against a runtime BuildContext.',
          style: TextStyle(
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
            color: oak,
          ),
        ),
        SizedBox(height: 10.0),
        Wrap(alignment: WrapAlignment.center, children: mockPins),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: getHandleSize comparison — Material vs Cupertino.
  // ============================================================
  print('=== Section 5: getHandleSize ===');
  // Use a representative line height for comparison — we never invoke
  // buildHandle, but Size queries do not require a BuildContext.
  final double textLineHeight = 16.0;
  final TextSelectionControls matCtrls = materialTextSelectionControls;
  final TextSelectionControls matHCtrls = materialTextSelectionHandleControls;
  final TextSelectionControls cupCtrls = cupertinoTextSelectionControls;
  final TextSelectionControls cupHCtrls = cupertinoTextSelectionHandleControls;

  final Size matSize = matCtrls.getHandleSize(textLineHeight);
  final Size matHSize = matHCtrls.getHandleSize(textLineHeight);
  final Size cupSize = cupCtrls.getHandleSize(textLineHeight);
  final Size cupHSize = cupHCtrls.getHandleSize(textLineHeight);

  print('  Material.getHandleSize($textLineHeight) = $matSize');
  print('  MaterialHandle.getHandleSize($textLineHeight) = $matHSize');
  print('  Cupertino.getHandleSize($textLineHeight) = $cupSize');
  print('  CupertinoHandle.getHandleSize($textLineHeight) = $cupHSize');

  final List<Map<String, Object>> sizeRows = [
    {
      'label': 'materialTextSelectionControls',
      'size': matSize,
      'color': vermilion,
    },
    {
      'label': 'materialTextSelectionHandleControls',
      'size': matHSize,
      'color': vermilion,
    },
    {
      'label': 'cupertinoTextSelectionControls',
      'size': cupSize,
      'color': lapis,
    },
    {
      'label': 'cupertinoTextSelectionHandleControls',
      'size': cupHSize,
      'color': lapis,
    },
  ];

  final List<Widget> sizeRowWidgets = <Widget>[];
  for (int i = 0; i < sizeRows.length; i++) {
    final Map<String, Object> r = sizeRows[i];
    final Size s = r['size'] as Size;
    final Color c = r['color'] as Color;
    sizeRowWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: c.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: c.withValues(alpha: 0.5), width: 1.0),
        ),
        child: Row(
          children: [
            Container(
              width: s.width.clamp(8.0, 80.0),
              height: s.height.clamp(8.0, 60.0),
              decoration: BoxDecoration(
                color: c.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: c, width: 1.2),
              ),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    r['label'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      color: c,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Size(w=${s.width.toStringAsFixed(1)}, '
                    'h=${s.height.toStringAsFixed(1)})',
                    style: TextStyle(fontSize: 11.0, color: oak),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget sizePanel = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: parchment,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: giltDeep, width: 1.4),
      boxShadow: [
        BoxShadow(
          color: gilt.withValues(alpha: 0.30),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.straighten, color: giltDeep, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'getHandleSize(textLineHeight: $textLineHeight)',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: ink,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        ...sizeRowWidgets,
      ],
    ),
  );

  // ============================================================
  // SECTION 6: getHandleAnchor diagram.
  // ============================================================
  print('=== Section 6: getHandleAnchor ===');
  // Anchor offsets are computed for each handle type.
  final Offset matAnchorLeft = matCtrls.getHandleAnchor(
    TextSelectionHandleType.left,
    textLineHeight,
  );
  final Offset matAnchorRight = matCtrls.getHandleAnchor(
    TextSelectionHandleType.right,
    textLineHeight,
  );
  final Offset matAnchorCollapsed = matCtrls.getHandleAnchor(
    TextSelectionHandleType.collapsed,
    textLineHeight,
  );
  final Offset cupAnchorLeft = cupCtrls.getHandleAnchor(
    TextSelectionHandleType.left,
    textLineHeight,
  );
  final Offset cupAnchorRight = cupCtrls.getHandleAnchor(
    TextSelectionHandleType.right,
    textLineHeight,
  );
  final Offset cupAnchorCollapsed = cupCtrls.getHandleAnchor(
    TextSelectionHandleType.collapsed,
    textLineHeight,
  );

  print('  Material  L=$matAnchorLeft R=$matAnchorRight C=$matAnchorCollapsed');
  print('  Cupertino L=$cupAnchorLeft R=$cupAnchorRight C=$cupAnchorCollapsed');

  final List<Map<String, Object>> anchorRows = [
    {
      'platform': 'Material',
      'left': matAnchorLeft,
      'right': matAnchorRight,
      'collapsed': matAnchorCollapsed,
      'color': vermilion,
    },
    {
      'platform': 'Cupertino',
      'left': cupAnchorLeft,
      'right': cupAnchorRight,
      'collapsed': cupAnchorCollapsed,
      'color': lapis,
    },
  ];

  Widget anchorChip(String tag, Offset o, Color c) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: c.withValues(alpha: 0.6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.gps_fixed, size: 12.0, color: c),
          SizedBox(width: 4.0),
          Text(
            '$tag: (${o.dx.toStringAsFixed(1)}, ${o.dy.toStringAsFixed(1)})',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: c,
            ),
          ),
        ],
      ),
    );
  }

  final List<Widget> anchorRowWidgets = <Widget>[];
  for (int i = 0; i < anchorRows.length; i++) {
    final Map<String, Object> r = anchorRows[i];
    final Color c = r['color'] as Color;
    anchorRowWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [c.withValues(alpha: 0.08), c.withValues(alpha: 0.18)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: c, width: 1.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              r['platform'] as String,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                color: c,
              ),
            ),
            SizedBox(height: 6.0),
            Wrap(
              children: [
                anchorChip('left', r['left'] as Offset, c),
                anchorChip('right', r['right'] as Offset, c),
                anchorChip('collapsed', r['collapsed'] as Offset, c),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final Widget anchorPanel = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: parchmentDeep.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: giltDeep, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.center_focus_strong, color: giltDeep, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'getHandleAnchor — pin-tip offsets',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: ink,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        ...anchorRowWidgets,
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Toolbar-button cascade — burnishing tools.
  // ============================================================
  print('=== Section 7: Toolbar buttons ===');
  final List<Map<String, Object>> toolbarButtons = [
    {
      'name': 'handleSelectAll',
      'label': 'Select All',
      'icon': Icons.select_all,
      'verb': 'selectAll(SelectionChangedCause.toolbar)',
      'color': lapis,
    },
    {
      'name': 'handleCopy',
      'label': 'Copy',
      'icon': Icons.copy,
      'verb': 'copySelection(SelectionChangedCause.toolbar)',
      'color': gilt,
    },
    {
      'name': 'handleCut',
      'label': 'Cut',
      'icon': Icons.content_cut,
      'verb': 'cutSelection(SelectionChangedCause.toolbar)',
      'color': vermilion,
    },
    {
      'name': 'handlePaste',
      'label': 'Paste',
      'icon': Icons.content_paste,
      'verb': 'pasteText(SelectionChangedCause.toolbar)',
      'color': oak,
    },
  ];

  final List<Widget> toolbarCards = <Widget>[];
  for (int i = 0; i < toolbarButtons.length; i++) {
    final Map<String, Object> b = toolbarButtons[i];
    final Color c = b['color'] as Color;
    print('  ${b['name']} -> ${b['verb']}');
    toolbarCards.add(
      Container(
        width: 220.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [c.withValues(alpha: 0.10), c.withValues(alpha: 0.28)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: c, width: 1.4),
          boxShadow: [
            BoxShadow(
              color: c.withValues(alpha: 0.35),
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: c.withValues(alpha: 0.18),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(b['icon'] as IconData, color: c, size: 22.0),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    b['label'] as String,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: c,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: parchment.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: c.withValues(alpha: 0.4)),
              ),
              child: Text(
                b['name'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: ink,
                ),
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'delegate.${b['verb']}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: oak,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget toolbarPanel = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [parchment, gilt.withValues(alpha: 0.25)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: giltDeep, width: 1.4),
      boxShadow: [
        BoxShadow(
          color: oak.withValues(alpha: 0.20),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.handyman, color: giltDeep, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Toolbar handlers — burnishing tools',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: ink,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'Each handler forwards to TextSelectionDelegate via '
          'SelectionChangedCause.toolbar.',
          style: TextStyle(
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
            color: oak,
          ),
        ),
        SizedBox(height: 10.0),
        Wrap(alignment: WrapAlignment.start, children: toolbarCards),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: TextSelectionDelegate contract panel.
  // ============================================================
  print('=== Section 8: TextSelectionDelegate ===');
  final List<Map<String, String>> delegateMembers = [
    {
      'name': 'textEditingValue',
      'detail': 'TextEditingValue get/set — text + selection state',
    },
    {
      'name': 'userUpdateTextEditingValue',
      'detail': 'apply user edits with SelectionChangedCause',
    },
    {
      'name': 'hideToolbar',
      'detail': '[bool hideHandles = true] — dismiss the toolbar overlay',
    },
    {
      'name': 'bringIntoView',
      'detail': 'TextPosition position — scroll caret into viewport',
    },
    {
      'name': 'cutSelection',
      'detail': 'SelectionChangedCause cause — used by handleCut',
    },
    {
      'name': 'copySelection',
      'detail': 'SelectionChangedCause cause — used by handleCopy',
    },
    {
      'name': 'pasteText',
      'detail': 'Future<void> pasteText(...) — used by handlePaste',
    },
    {
      'name': 'selectAll',
      'detail': 'SelectionChangedCause cause — used by handleSelectAll',
    },
  ];

  final List<Widget> delegateRows = <Widget>[];
  for (int i = 0; i < delegateMembers.length; i++) {
    final Map<String, String> m = delegateMembers[i];
    final bool stripe = i.isEven;
    delegateRows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: stripe
              ? parchment.withValues(alpha: 0.85)
              : parchmentDeep.withValues(alpha: 0.6),
          border: Border(
            bottom: BorderSide(
              color: giltDeep.withValues(alpha: 0.35),
              width: 0.6,
            ),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 30.0,
              child: Text(
                '${i + 1}.',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: oak,
                ),
              ),
            ),
            SizedBox(
              width: 220.0,
              child: Text(
                m['name'] ?? '',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: lapis,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Text(
                m['detail'] ?? '',
                style: TextStyle(fontSize: 11.0, color: ink),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget delegatePanel = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: parchment,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: lapis, width: 1.4),
      boxShadow: [
        BoxShadow(
          color: lapis.withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.assignment_ind, color: lapis, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'TextSelectionDelegate — the scriptorium charter',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: ink,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Column(children: delegateRows),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Material vs Cupertino comparison table.
  // ============================================================
  print('=== Section 9: Material vs Cupertino ===');
  final List<List<String>> compareRows = [
    ['Concrete handles', 'rounded teardrop', 'circular bead'],
    ['Toolbar', 'M3 menu w/ buttons', 'iOS bubble menu'],
    ['Mixin variant', 'MaterialTextSelectionHandleControls',
     'CupertinoTextSelectionHandleControls'],
    ['Default constant', 'materialTextSelectionControls',
     'cupertinoTextSelectionControls'],
    ['Handle constant', 'materialTextSelectionHandleControls',
     'cupertinoTextSelectionHandleControls'],
    ['Theme alignment', 'theme.textSelectionTheme', 'CupertinoTheme'],
  ];

  final List<Widget> compareWidgets = <Widget>[];
  // Header row.
  compareWidgets.add(
    Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: giltDeep.withValues(alpha: 0.65),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 130.0,
            child: Text(
              'Aspect',
              style: TextStyle(
                color: parchment,
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Material',
              style: TextStyle(
                color: parchment,
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Cupertino',
              style: TextStyle(
                color: parchment,
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          ),
        ],
      ),
    ),
  );
  for (int i = 0; i < compareRows.length; i++) {
    final List<String> row = compareRows[i];
    final bool stripe = i.isEven;
    compareWidgets.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: stripe ? parchment : parchmentDeep.withValues(alpha: 0.65),
          border: Border(
            bottom: BorderSide(
              color: giltDeep.withValues(alpha: 0.4),
              width: 0.6,
            ),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 130.0,
              child: Text(
                row[0],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11.0,
                  color: oak,
                ),
              ),
            ),
            Expanded(
              child: Text(
                row[1],
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: vermilion,
                ),
              ),
            ),
            Expanded(
              child: Text(
                row[2],
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: lapis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget comparePanel = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          vermilion.withValues(alpha: 0.10),
          lapis.withValues(alpha: 0.10),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: giltDeep, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows, color: giltDeep, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Material vs Cupertino — house styles',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: ink,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Column(children: compareWidgets),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Code-snippet ledger.
  // ============================================================
  print('=== Section 10: Code-snippet ledger ===');
  final List<Map<String, Object>> snippets = [
    {
      'title': 'Pick the global handle controls',
      'color': vermilion,
      'code': '// Material handles + toolbar\n'
          'final controls = materialTextSelectionControls;\n\n'
          '// Material handles only (toolbar handled elsewhere)\n'
          'final handleOnly = materialTextSelectionHandleControls;',
    },
    {
      'title': 'Cupertino flavour',
      'color': lapis,
      'code': '// Cupertino full kit\n'
          'final cup = cupertinoTextSelectionControls;\n\n'
          '// Cupertino handles only\n'
          'final cupHandles = cupertinoTextSelectionHandleControls;',
    },
    {
      'title': 'TextSelectionHandleControls mixin',
      'color': gilt,
      'code': 'class CalligraphyHandles extends MaterialTextSelectionControls\n'
          '    with TextSelectionHandleControls {}\n\n'
          '// Mixin disables built-in toolbar; handles remain.\n'
          '// Pair with EditableText.contextMenuBuilder.',
    },
    {
      'title': 'Query handle metrics',
      'color': oak,
      'code': 'final size = controls.getHandleSize(textLineHeight);\n'
          'final anchorL = controls.getHandleAnchor(\n'
          '  TextSelectionHandleType.left, textLineHeight);\n'
          'final anchorR = controls.getHandleAnchor(\n'
          '  TextSelectionHandleType.right, textLineHeight);',
    },
    {
      'title': 'Toolbar handlers via delegate',
      'color': vermilion,
      'code': '// Inside a custom TextSelectionControls subclass:\n'
          'controls.handleSelectAll(delegate); '
          '// -> delegate.selectAll(...)\n'
          'controls.handleCopy(delegate);      '
          '// -> delegate.copySelection(...)\n'
          'controls.handleCut(delegate);       '
          '// -> delegate.cutSelection(...)\n'
          'controls.handlePaste(delegate);     '
          '// -> delegate.pasteText(...)',
    },
  ];

  final List<Widget> snippetWidgets = <Widget>[];
  for (int i = 0; i < snippets.length; i++) {
    final Map<String, Object> s = snippets[i];
    final Color c = s['color'] as Color;
    snippetWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: ink.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: c, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: c.withValues(alpha: 0.35),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.code, color: c, size: 16.0),
                SizedBox(width: 6.0),
                Text(
                  s['title'] as String,
                  style: TextStyle(
                    color: c,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              s['code'] as String,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: parchment,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget snippetsPanel = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: oak.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: giltDeep, width: 1.4),
      boxShadow: [
        BoxShadow(
          color: oak.withValues(alpha: 0.45),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.book, color: parchment, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Code ledger — recipes from the scriptorium',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: parchment,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        ...snippetWidgets,
      ],
    ),
  );

  // ============================================================
  // Runtime sanity prints — confirm types.
  // ============================================================
  print('=== Runtime sanity ===');
  print('  matCtrls runtimeType: ${matCtrls.runtimeType}');
  print('  matHCtrls runtimeType: ${matHCtrls.runtimeType}');
  print('  cupCtrls runtimeType: ${cupCtrls.runtimeType}');
  print('  cupHCtrls runtimeType: ${cupHCtrls.runtimeType}');
  print('TextSelectionHandleControls Deep Demo completed');

  // ============================================================
  // Final layout — single scroll view, narrative cascade.
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        header,
        SizedBox(height: 28.0),
        Text(
          '1. Inheritance ladder',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        SizedBox(height: 8.0),
        hierarchyPanel,
        SizedBox(height: 24.0),
        Text(
          '2. The three pin types',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        SizedBox(height: 8.0),
        handleTypePanel,
        SizedBox(height: 24.0),
        Text(
          '3. Anchor-pin anatomy (mock buildHandle)',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        SizedBox(height: 8.0),
        mockPinsPanel,
        SizedBox(height: 24.0),
        Text(
          '4. getHandleSize comparison',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        SizedBox(height: 8.0),
        sizePanel,
        SizedBox(height: 24.0),
        Text(
          '5. getHandleAnchor offsets',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        SizedBox(height: 8.0),
        anchorPanel,
        SizedBox(height: 24.0),
        Text(
          '6. Toolbar burnishing tools',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        SizedBox(height: 8.0),
        toolbarPanel,
        SizedBox(height: 24.0),
        Text(
          '7. TextSelectionDelegate contract',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        SizedBox(height: 8.0),
        delegatePanel,
        SizedBox(height: 24.0),
        Text(
          '8. Material vs Cupertino',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        SizedBox(height: 8.0),
        comparePanel,
        SizedBox(height: 24.0),
        Text(
          '9. Code ledger',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        SizedBox(height: 8.0),
        snippetsPanel,
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [gilt, parchment],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: giltDeep, width: 1.2),
          ),
          child: Row(
            children: [
              Icon(Icons.bookmark, color: oak, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'End of folio — the gilt anchor pins rest in their cushion.',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontStyle: FontStyle.italic,
                    color: oak,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
