// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderFractionallySizedOverflowBox via FractionallySizedBox
// Deep Demo: Visual demonstration of proportional sizing, alignment, and overflow
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FractionallySizedBox Deep Demo executing');

  // ============================================================
  // SECTION 1: widthFactor only — proportional horizontal sizing
  // ============================================================
  print('=== Section 1: widthFactor only ===');

  final widthFactorValues = <double>[0.25, 0.5, 0.75, 1.0];
  final widthFactorWidgets = <Widget>[];

  for (int i = 0; i < widthFactorValues.length; i++) {
    final factor = widthFactorValues[i];
    print('widthFactor=$factor heightFactor=null (full height)');

    widthFactorWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.blue.shade200, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 28.0,
                  height: 28.0,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade400,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Text(
                  'widthFactor: $factor',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            // Parent container with contrast background and fixed size
            Container(
              width: 320.0,
              height: 60.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.grey.shade500, width: 1.0),
              ),
              child: FractionallySizedBox(
                widthFactor: factor,
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade500, Colors.blue.shade700],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Center(
                    child: Text(
                      '${(factor * 100).toInt()}%',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${widthFactorWidgets.length} widthFactor demos');

  // Code panel for Section 1
  final widthFactorCode = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade300, size: 18.0),
            SizedBox(width: 8.0),
            Text(
              'widthFactor pattern',
              style: TextStyle(
                color: Colors.cyan.shade300,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'Container(\n'
          '  width: 320, height: 60,\n'
          '  color: Colors.grey.shade300,\n'
          '  child: FractionallySizedBox(\n'
          '    widthFactor: 0.5,\n'
          '    alignment: Alignment.centerLeft,\n'
          '    child: ColoredBox(color: Colors.blue),\n'
          '  ),\n'
          ');',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.greenAccent.shade100,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: heightFactor only — proportional vertical sizing
  // ============================================================
  print('=== Section 2: heightFactor only ===');

  final heightFactorValues = <double>[0.25, 0.5, 0.75, 1.0];
  final heightFactorWidgets = <Widget>[];

  for (int i = 0; i < heightFactorValues.length; i++) {
    final factor = heightFactorValues[i];
    print('widthFactor=null heightFactor=$factor');

    heightFactorWidgets.add(
      Container(
        width: 120.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.purple.shade50,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.purple.shade200, width: 1.5),
        ),
        child: Column(
          children: [
            Text(
              'h=$factor',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade900,
                fontSize: 13.0,
              ),
            ),
            SizedBox(height: 8.0),
            // Parent container with contrast background and fixed size
            Container(
              width: 100.0,
              height: 160.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.grey.shade500, width: 1.0),
              ),
              child: FractionallySizedBox(
                heightFactor: factor,
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple.shade400, Colors.purple.shade800],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Center(
                    child: Text(
                      '${(factor * 100).toInt()}%',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${heightFactorWidgets.length} heightFactor demos');

  final heightFactorCode = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.amberAccent, size: 18.0),
            SizedBox(width: 8.0),
            Text(
              'heightFactor pattern',
              style: TextStyle(
                color: Colors.amberAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'FractionallySizedBox(\n'
          '  heightFactor: 0.75,\n'
          '  alignment: Alignment.bottomCenter,\n'
          '  child: ColoredBox(color: Colors.purple),\n'
          ');',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.orangeAccent.shade100,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Both factors combined
  // ============================================================
  print('=== Section 3: widthFactor + heightFactor combined ===');

  final combinedPairs = <Map<String, double>>[
    {'w': 0.25, 'h': 0.25},
    {'w': 0.5, 'h': 0.5},
    {'w': 0.75, 'h': 0.75},
    {'w': 1.0, 'h': 1.0},
    {'w': 0.5, 'h': 0.9},
    {'w': 0.9, 'h': 0.4},
  ];
  final combinedWidgets = <Widget>[];

  for (int i = 0; i < combinedPairs.length; i++) {
    final w = combinedPairs[i]['w']!;
    final h = combinedPairs[i]['h']!;
    print('widthFactor=$w heightFactor=$h');

    combinedWidgets.add(
      Container(
        width: 150.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.teal.shade50,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.teal.shade300, width: 1.5),
        ),
        child: Column(
          children: [
            Text(
              'w:$w / h:$h',
              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade900,
                fontSize: 12.0,
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              width: 130.0,
              height: 110.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.grey.shade500, width: 1.0),
              ),
              child: FractionallySizedBox(
                widthFactor: w,
                heightFactor: h,
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.teal.shade400, Colors.teal.shade700],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${combinedWidgets.length} combined factor demos');

  final combinedCode = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.tealAccent, size: 18.0),
            SizedBox(width: 8.0),
            Text(
              'both factors',
              style: TextStyle(
                color: Colors.tealAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'FractionallySizedBox(\n'
          '  widthFactor: 0.5,\n'
          '  heightFactor: 0.5,\n'
          '  child: ColoredBox(color: Colors.teal),\n'
          ');\n'
          '// Child fills 50% width and 50% height of parent.',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.tealAccent.shade100,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Alignment variations
  // ============================================================
  print('=== Section 4: Alignment variations ===');

  final alignmentEntries = <Map<String, dynamic>>[
    {
      'label': 'topLeft',
      'align': Alignment.topLeft,
      'icon': Icons.north_west,
      'color': Colors.indigo,
    },
    {
      'label': 'topCenter',
      'align': Alignment.topCenter,
      'icon': Icons.north,
      'color': Colors.deepPurple,
    },
    {
      'label': 'topRight',
      'align': Alignment.topRight,
      'icon': Icons.north_east,
      'color': Colors.pink,
    },
    {
      'label': 'centerLeft',
      'align': Alignment.centerLeft,
      'icon': Icons.west,
      'color': Colors.cyan,
    },
    {
      'label': 'center',
      'align': Alignment.center,
      'icon': Icons.center_focus_strong,
      'color': Colors.blueGrey,
    },
    {
      'label': 'centerRight',
      'align': Alignment.centerRight,
      'icon': Icons.east,
      'color': Colors.orange,
    },
    {
      'label': 'bottomLeft',
      'align': Alignment.bottomLeft,
      'icon': Icons.south_west,
      'color': Colors.green,
    },
    {
      'label': 'bottomCenter',
      'align': Alignment.bottomCenter,
      'icon': Icons.south,
      'color': Colors.lime,
    },
    {
      'label': 'bottomRight',
      'align': Alignment.bottomRight,
      'icon': Icons.south_east,
      'color': Colors.red,
    },
  ];

  final alignmentWidgets = <Widget>[];
  for (int i = 0; i < alignmentEntries.length; i++) {
    final entry = alignmentEntries[i];
    final color = entry['color'] as Color;
    final alignment = entry['align'] as Alignment;
    final label = entry['label'] as String;
    print('alignment=$label');

    alignmentWidgets.add(
      Container(
        width: 130.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: color.withValues(alpha: 0.5),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(entry['icon'] as IconData, color: color, size: 16.0),
                SizedBox(width: 4.0),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Container(
              width: 110.0,
              height: 80.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.grey.shade500, width: 1.0),
              ),
              child: FractionallySizedBox(
                widthFactor: 0.4,
                heightFactor: 0.5,
                alignment: alignment,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${alignmentWidgets.length} alignment demos');

  final alignmentCode = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.pinkAccent, size: 18.0),
            SizedBox(width: 8.0),
            Text(
              'alignment pattern',
              style: TextStyle(
                color: Colors.pinkAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'FractionallySizedBox(\n'
          '  widthFactor: 0.4,\n'
          '  heightFactor: 0.5,\n'
          '  alignment: Alignment.topLeft,\n'
          '  child: ColoredBox(color: Colors.indigo),\n'
          ');',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.pinkAccent.shade100,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Overflow demos with factors > 1.0
  // ============================================================
  print('=== Section 5: Overflow with factors > 1.0 ===');

  final overflowPairs = <Map<String, double>>[
    {'w': 1.2, 'h': 1.0},
    {'w': 1.0, 'h': 1.2},
    {'w': 1.3, 'h': 1.3},
    {'w': 1.5, 'h': 0.5},
  ];
  final overflowWidgets = <Widget>[];

  for (int i = 0; i < overflowPairs.length; i++) {
    final w = overflowPairs[i]['w']!;
    final h = overflowPairs[i]['h']!;
    print('OVERFLOW widthFactor=$w heightFactor=$h');

    overflowWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.red.shade300, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.warning_amber, color: Colors.red.shade700, size: 22.0),
                SizedBox(width: 8.0),
                Text(
                  'overflow w:$w h:$h',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade900,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            // Wrap in ClipRect so overflow stays inside our visual frame
            ClipRect(
              child: Container(
                width: 300.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: Colors.grey.shade500, width: 1.0),
                ),
                child: FractionallySizedBox(
                  widthFactor: w,
                  heightFactor: h,
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.red.shade400, Colors.deepOrange.shade700],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Center(
                      child: Text(
                        '${(w * 100).toInt()}% × ${(h * 100).toInt()}%',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${overflowWidgets.length} overflow demos');

  final overflowCode = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.redAccent, size: 18.0),
            SizedBox(width: 8.0),
            Text(
              'overflow pattern',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'ClipRect(\n'
          '  child: Container(\n'
          '    width: 300, height: 100,\n'
          '    child: FractionallySizedBox(\n'
          '      widthFactor: 1.3, // > 1.0 overflows\n'
          '      heightFactor: 1.3,\n'
          '      child: ColoredBox(color: Colors.red),\n'
          '    ),\n'
          '  ),\n'
          ');',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.redAccent.shade100,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Null factor demonstrations
  // ============================================================
  print('=== Section 6: Null factors ===');

  final nullCases = <Map<String, dynamic>>[
    {
      'label': 'widthFactor=null, heightFactor=0.5',
      'w': null,
      'h': 0.5,
      'desc': 'Width passes through, height halved',
      'color': Colors.indigo,
    },
    {
      'label': 'widthFactor=0.5, heightFactor=null',
      'w': 0.5,
      'h': null,
      'desc': 'Width halved, height passes through',
      'color': Colors.green,
    },
    {
      'label': 'widthFactor=null, heightFactor=null',
      'w': null,
      'h': null,
      'desc': 'Loose constraints — child sizes itself',
      'color': Colors.brown,
    },
  ];

  final nullWidgets = <Widget>[];
  for (int i = 0; i < nullCases.length; i++) {
    final entry = nullCases[i];
    final color = entry['color'] as Color;
    final w = entry['w'] as double?;
    final h = entry['h'] as double?;
    print('case=${entry['label']}');

    nullWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entry['label'] as String,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              entry['desc'] as String,
              style: TextStyle(
                fontSize: 11.0,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              width: 280.0,
              height: 90.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.grey.shade500, width: 1.0),
              ),
              child: FractionallySizedBox(
                widthFactor: w,
                heightFactor: h,
                alignment: Alignment.center,
                child: Container(
                  width: 120.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Center(
                    child: Text(
                      'child',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${nullWidgets.length} null-factor demos');

  final nullCode = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.lightBlueAccent, size: 18.0),
            SizedBox(width: 8.0),
            Text(
              'null factor pattern',
              style: TextStyle(
                color: Colors.lightBlueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'FractionallySizedBox(\n'
          '  widthFactor: null,  // child decides width\n'
          '  heightFactor: 0.5,   // half of parent\n'
          '  child: SizedBox(width: 120, height: 50),\n'
          ');',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.lightBlueAccent.shade100,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Real-world examples
  // ============================================================
  print('=== Section 7: Real-world examples ===');

  // 7.1 Progress card with fractional width
  final progressValues = <double>[0.2, 0.55, 0.85];
  final progressLabels = <String>['Sync', 'Backup', 'Index'];
  final progressCards = <Widget>[];
  for (int i = 0; i < progressValues.length; i++) {
    final p = progressValues[i];
    final label = progressLabels[i];
    progressCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.blueGrey.shade200, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade900,
                  ),
                ),
                Text(
                  '${(p * 100).toInt()}%',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            // The progress bar parent — fractional fill
            Container(
              height: 14.0,
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade100,
                borderRadius: BorderRadius.circular(7.0),
              ),
              child: FractionallySizedBox(
                widthFactor: p,
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade400, Colors.indigo.shade500],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 7.2 Photo grid using FractionallySizedBox alignment
  final photoColors = <Color>[
    Colors.deepOrange,
    Colors.amber,
    Colors.lightGreen,
    Colors.teal,
    Colors.cyan,
    Colors.purple,
  ];
  final photoTiles = <Widget>[];
  final photoAligns = <Alignment>[
    Alignment.topLeft,
    Alignment.topCenter,
    Alignment.topRight,
    Alignment.bottomLeft,
    Alignment.bottomCenter,
    Alignment.bottomRight,
  ];
  for (int i = 0; i < photoColors.length; i++) {
    photoTiles.add(
      Container(
        width: 90.0,
        height: 90.0,
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: FractionallySizedBox(
          widthFactor: 0.7,
          heightFactor: 0.7,
          alignment: photoAligns[i],
          child: Container(
            decoration: BoxDecoration(
              color: photoColors[i],
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Center(
              child: Icon(Icons.photo, color: Colors.white, size: 20.0),
            ),
          ),
        ),
      ),
    );
  }

  // 7.3 Two-thirds / one-third split
  final splitLayout = Container(
    height: 110.0,
    margin: EdgeInsets.symmetric(vertical: 10.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.grey.shade400),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: FractionallySizedBox(
              widthFactor: 1.0,
              heightFactor: 0.85,
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade400, Colors.green.shade700],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Center(
                  child: Text(
                    '2/3 panel',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: FractionallySizedBox(
              widthFactor: 1.0,
              heightFactor: 0.6,
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.deepOrange.shade400,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Center(
                  child: Text(
                    '1/3',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  // 7.4 Modal panel taking 80% width
  final modalPanel = Container(
    width: double.infinity,
    height: 160.0,
    margin: EdgeInsets.symmetric(vertical: 10.0),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: FractionallySizedBox(
      widthFactor: 0.8,
      heightFactor: 0.75,
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 12.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue.shade700),
                  SizedBox(width: 8.0),
                  Text(
                    'Modal — 80% width',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.blueGrey.shade900,
                    ),
                  ),
                ],
              ),
              Text(
                'FractionallySizedBox scales the modal proportionally with the screen, '
                'keeping margins consistent across device sizes.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.blueGrey.shade700,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 6.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade600,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
  print('Created real-world example widgets');

  final realWorldCode = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.greenAccent, size: 18.0),
            SizedBox(width: 8.0),
            Text(
              'real-world snippets',
              style: TextStyle(
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          '// Progress bar fill\n'
          'FractionallySizedBox(\n'
          '  widthFactor: progress,\n'
          '  alignment: Alignment.centerLeft,\n'
          '  child: ColoredBox(color: Colors.blue),\n'
          ');\n\n'
          '// Modal panel sized to viewport\n'
          'FractionallySizedBox(\n'
          '  widthFactor: 0.8,\n'
          '  heightFactor: 0.75,\n'
          '  child: ModalCard(),\n'
          ');',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.greenAccent.shade100,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Summary panel
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.purple.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade300, width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.summarize,
              color: Colors.indigo.shade700,
              size: 26.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'Key Takeaways — FractionallySizedBox',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildSummaryItem(
          Icons.swap_horiz,
          'widthFactor',
          'Scales child width as a fraction of available width.',
          Colors.blue,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.swap_vert,
          'heightFactor',
          'Scales child height as a fraction of available height.',
          Colors.purple,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.center_focus_strong,
          'alignment',
          'Positions the child within the leftover space.',
          Colors.teal,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.open_in_full,
          'Overflow (>1.0)',
          'Factors above 1.0 size the child larger than the parent.',
          Colors.red,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.help_outline,
          'null factor',
          'A null factor means that axis is unconstrained by the box.',
          Colors.orange,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.dashboard_customize,
          'Use cases',
          'Progress bars, modal panels, responsive grids and splits.',
          Colors.green,
        ),
      ],
    ),
  );

  print('FractionallySizedBox Deep Demo completed successfully');

  // ============================================================
  // Return complete visual layout wrapped in MaterialApp
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF3F7FF),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header banner
            Container(
              padding: EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo.shade700, Colors.blue.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withValues(alpha: 0.3),
                    blurRadius: 12.0,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.aspect_ratio,
                    size: 56.0,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'FractionallySizedBox Deep Demo',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'Proportional sizing • alignment • overflow • null factors',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),

            // Section 1
            Text(
              '1. widthFactor only',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              'Width scales as a fraction of available width; height passes through.',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.blueGrey.shade700,
              ),
            ),
            SizedBox(height: 8.0),
            ...widthFactorWidgets,
            widthFactorCode,
            SizedBox(height: 24.0),

            // Section 2
            Text(
              '2. heightFactor only',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              'Height scales as a fraction of available height; width passes through.',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.blueGrey.shade700,
              ),
            ),
            SizedBox(height: 8.0),
            Wrap(
              alignment: WrapAlignment.center,
              children: heightFactorWidgets,
            ),
            heightFactorCode,
            SizedBox(height: 24.0),

            // Section 3
            Text(
              '3. Both factors combined',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              'Independent control over both axes for fully proportional child sizing.',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.blueGrey.shade700,
              ),
            ),
            SizedBox(height: 8.0),
            Wrap(
              alignment: WrapAlignment.center,
              children: combinedWidgets,
            ),
            combinedCode,
            SizedBox(height: 24.0),

            // Section 4
            Text(
              '4. Alignment variations',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              'When the child is smaller than the parent, alignment chooses its anchor.',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.blueGrey.shade700,
              ),
            ),
            SizedBox(height: 8.0),
            Wrap(
              alignment: WrapAlignment.center,
              children: alignmentWidgets,
            ),
            alignmentCode,
            SizedBox(height: 24.0),

            // Section 5
            Text(
              '5. Overflow with factors > 1.0',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              'Factors greater than 1.0 deliberately size the child larger than the parent.',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.blueGrey.shade700,
              ),
            ),
            SizedBox(height: 8.0),
            ...overflowWidgets,
            overflowCode,
            SizedBox(height: 24.0),

            // Section 6
            Text(
              '6. Null factor combinations',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              'A null factor lets the child size itself on that axis.',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.blueGrey.shade700,
              ),
            ),
            SizedBox(height: 8.0),
            ...nullWidgets,
            nullCode,
            SizedBox(height: 24.0),

            // Section 7
            Text(
              '7. Real-world examples',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              'Progress cards, photo grid alignment, 2/3 + 1/3 split, modal panel.',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.blueGrey.shade700,
              ),
            ),
            SizedBox(height: 12.0),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade50,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.blueGrey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.show_chart,
                        color: Colors.blue.shade700,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        '7.1 Progress cards (fractional width)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey.shade900,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  ...progressCards,
                ],
              ),
            ),
            SizedBox(height: 12.0),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade50,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.blueGrey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.grid_view,
                        color: Colors.deepOrange.shade700,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        '7.2 Photo grid (alignment anchors)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey.shade900,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: photoTiles,
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.0),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade50,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.blueGrey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.view_column,
                        color: Colors.green.shade700,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        '7.3 2/3 + 1/3 split layout',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey.shade900,
                        ),
                      ),
                    ],
                  ),
                  splitLayout,
                ],
              ),
            ),
            SizedBox(height: 12.0),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade50,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.blueGrey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.web_asset,
                        color: Colors.indigo.shade700,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        '7.4 Modal panel — 80% width',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey.shade900,
                        ),
                      ),
                    ],
                  ),
                  modalPanel,
                ],
              ),
            ),
            realWorldCode,
            SizedBox(height: 24.0),

            // Section 8
            Text(
              '8. Summary',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            summaryPanel,
            SizedBox(height: 16.0),
            Text(
              'Deep demo completed — proportional sizing, alignment, overflow, '
              'and null factor behavior are all exercised above.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.blueGrey.shade700,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// Helper: Build summary item
Widget _buildSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.75),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: color.withValues(alpha: 0.4),
        width: 1.0,
      ),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
