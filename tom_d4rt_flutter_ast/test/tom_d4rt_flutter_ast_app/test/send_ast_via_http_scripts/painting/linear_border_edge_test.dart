// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests LinearBorderEdge from package:flutter/painting.dart
// Deep Demo: Visual demonstration of LinearBorderEdge configurations
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('LinearBorderEdge Deep Demo executing');

  // M3-inspired teal/sage palette
  final Color tealDeep = Color(0xFF0F4C4A);
  final Color tealMid = Color(0xFF2A7F7B);
  final Color tealSoft = Color(0xFF7FB8B4);
  final Color sageMid = Color(0xFF8FA888);
  final Color sageSoft = Color(0xFFCAD9C2);
  final Color cream = Color(0xFFF4F1E8);
  final Color charcoal = Color(0xFF1F2A2A);

  // ============================================================
  // SECTION 1: Title Banner
  // ============================================================
  print('=== Section 1: Title Banner ===');

  final titleBanner = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [tealDeep, tealMid, sageMid],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 0.55, 1.0],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: tealDeep.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: tealMid.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 2.0),
        ),
        BoxShadow(
          color: Colors.white.withValues(alpha: 0.12),
          blurRadius: 1.0,
          offset: Offset(0.0, -1.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.border_outer, color: cream, size: 40.0),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'LinearBorderEdge',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: cream,
                  letterSpacing: 1.1,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'Partial edge descriptors for LinearBorder',
          style: TextStyle(
            fontSize: 14.0,
            color: cream.withValues(alpha: 0.85),
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: cream.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(
              color: cream.withValues(alpha: 0.35),
              width: 1.0,
            ),
          ),
          child: Text(
            'package:flutter/painting.dart',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: cream,
            ),
          ),
        ),
      ],
    ),
  );
  print('Title banner ready');

  // ============================================================
  // SECTION 2: Anatomy Diagram
  // ============================================================
  print('=== Section 2: Anatomy Diagram ===');

  // Create three reference markers for alignment positions -1, 0, +1
  final List<Widget> alignmentMarkers = <Widget>[];
  final List<Map<String, dynamic>> markerSpecs = [
    {'pos': 0.02, 'label': '-1.0', 'desc': 'start'},
    {'pos': 0.50, 'label': '0.0', 'desc': 'center'},
    {'pos': 0.98, 'label': '+1.0', 'desc': 'end'},
  ];
  for (final spec in markerSpecs) {
    alignmentMarkers.add(
      Positioned(
        left: (spec['pos'] as double) * 280.0 - 16.0,
        top: 0.0,
        child: Column(
          children: [
            Container(
              width: 2.0,
              height: 22.0,
              color: tealDeep,
            ),
            Text(
              spec['label'] as String,
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
                color: tealDeep,
              ),
            ),
            Text(
              spec['desc'] as String,
              style: TextStyle(fontSize: 9.0, color: tealMid),
            ),
          ],
        ),
      ),
    );
  }

  final anatomyDiagram = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [cream, sageSoft.withValues(alpha: 0.4)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: tealSoft, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: tealMid.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
        BoxShadow(
          color: charcoal.withValues(alpha: 0.06),
          blurRadius: 2.0,
          offset: Offset(0.0, 1.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Anatomy of an Edge',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: tealDeep,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'A LinearBorderEdge has two parameters: size (length 0-1) '
          'and alignment (-1 start, 0 center, 1 end).',
          style: TextStyle(fontSize: 12.0, color: charcoal),
        ),
        SizedBox(height: 24.0),
        SizedBox(
          width: 280.0,
          height: 60.0,
          child: Stack(
            children: [
              // Full edge baseline
              Positioned(
                top: 30.0,
                left: 0.0,
                right: 0.0,
                child: Container(height: 4.0, color: sageSoft),
              ),
              // Highlighted partial edge (size=0.5 alignment=0)
              Positioned(
                top: 28.0,
                left: 70.0,
                child: Container(
                  width: 140.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: tealDeep,
                    borderRadius: BorderRadius.circular(2.0),
                    boxShadow: [
                      BoxShadow(
                        color: tealDeep.withValues(alpha: 0.4),
                        blurRadius: 6.0,
                        offset: Offset(0.0, 2.0),
                      ),
                    ],
                  ),
                ),
              ),
              ...alignmentMarkers,
            ],
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: charcoal,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'LinearBorderEdge(size: 0.5, alignment: 0.0)',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: cream,
            ),
          ),
        ),
      ],
    ),
  );
  print('Anatomy diagram ready');

  // ============================================================
  // SECTION 3: size parameter showcase
  // ============================================================
  print('=== Section 3: size parameter showcase ===');

  final List<double> sizeValues = [0.25, 0.5, 0.75, 1.0, 0.0];
  final sizeCards = sizeValues.map((s) {
    final edge = LinearBorderEdge(size: s, alignment: 0.0);
    print('LinearBorderEdge(size: $s) -> hash ${edge.hashCode}');
    return Container(
      width: 130.0,
      margin: EdgeInsets.all(6.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            tealSoft.withValues(alpha: 0.18),
            tealMid.withValues(alpha: 0.30),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: tealMid, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: tealMid.withValues(alpha: 0.30),
            blurRadius: 10.0,
            offset: Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'size: $s',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              color: tealDeep,
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            width: 90.0,
            height: 56.0,
            decoration: ShapeDecoration(
              color: cream,
              shape: LinearBorder(
                top: LinearBorderEdge(size: s, alignment: 0.0),
                side: BorderSide(color: tealDeep, width: 3.0),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              '${(s * 100).toInt()}%',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: tealDeep,
              ),
            ),
          ),
          SizedBox(height: 6.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: tealDeep.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              s == 0.0 ? 'invisible' : '${(s * 100).toInt()}% top',
              style: TextStyle(fontSize: 9.0, color: tealDeep),
            ),
          ),
        ],
      ),
    );
  }).toList();

  final sizeSection = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [cream, sageSoft.withValues(alpha: 0.3)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: sageMid.withValues(alpha: 0.5), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: sageMid.withValues(alpha: 0.20),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
        BoxShadow(
          color: tealDeep.withValues(alpha: 0.06),
          blurRadius: 2.0,
          offset: Offset(0.0, 1.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 3 — The size parameter',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: tealDeep,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Fraction of the side covered (0.0 to 1.0).',
          style: TextStyle(fontSize: 12.0, color: charcoal),
        ),
        SizedBox(height: 12.0),
        Wrap(children: sizeCards),
      ],
    ),
  );
  print('Size showcase complete');

  // ============================================================
  // SECTION 4: alignment parameter showcase
  // ============================================================
  print('=== Section 4: alignment parameter showcase ===');

  final List<double> alignmentValues = [-1.0, -0.5, 0.0, 0.5, 1.0];
  final alignmentCards = alignmentValues.map((a) {
    final edge = LinearBorderEdge(size: 0.5, alignment: a);
    print('LinearBorderEdge(size: 0.5, alignment: $a) -> ${edge.runtimeType}');
    String label;
    if (a == -1.0) {
      label = 'flush start';
    } else if (a == -0.5) {
      label = 'left of center';
    } else if (a == 0.0) {
      label = 'centered';
    } else if (a == 0.5) {
      label = 'right of center';
    } else {
      label = 'flush end';
    }

    return Container(
      width: 130.0,
      margin: EdgeInsets.all(6.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            sageSoft.withValues(alpha: 0.55),
            sageMid.withValues(alpha: 0.30),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: sageMid, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: sageMid.withValues(alpha: 0.35),
            blurRadius: 8.0,
            offset: Offset(0.0, 3.0),
          ),
          BoxShadow(
            color: tealDeep.withValues(alpha: 0.05),
            blurRadius: 1.0,
            offset: Offset(0.0, 1.0),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'align: ${a.toStringAsFixed(1)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              color: tealDeep,
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            width: 100.0,
            height: 56.0,
            decoration: ShapeDecoration(
              color: cream,
              shape: LinearBorder(
                top: LinearBorderEdge(size: 0.5, alignment: a),
                side: BorderSide(color: tealDeep, width: 3.0),
              ),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.straighten, color: tealMid, size: 22.0),
          ),
          SizedBox(height: 6.0),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 9.0,
              color: tealDeep,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }).toList();

  final alignmentSection = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [cream, tealSoft.withValues(alpha: 0.18)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: tealSoft, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: tealSoft.withValues(alpha: 0.30),
          blurRadius: 12.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 4 — The alignment parameter',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: tealDeep,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Where on the side the partial edge sits (-1 start, +1 end).',
          style: TextStyle(fontSize: 12.0, color: charcoal),
        ),
        SizedBox(height: 12.0),
        Wrap(children: alignmentCards),
      ],
    ),
  );
  print('Alignment showcase complete');

  // ============================================================
  // SECTION 5: All four sides
  // ============================================================
  print('=== Section 5: all four sides ===');

  final List<Map<String, dynamic>> sideSpecs = [
    {
      'name': 'top',
      'border': LinearBorder(
        top: LinearBorderEdge(size: 1.0, alignment: 0.0),
        side: BorderSide(color: tealDeep, width: 3.0),
      ),
      'icon': Icons.north,
    },
    {
      'name': 'bottom',
      'border': LinearBorder(
        bottom: LinearBorderEdge(size: 1.0, alignment: 0.0),
        side: BorderSide(color: tealDeep, width: 3.0),
      ),
      'icon': Icons.south,
    },
    {
      'name': 'start',
      'border': LinearBorder(
        start: LinearBorderEdge(size: 1.0, alignment: 0.0),
        side: BorderSide(color: tealDeep, width: 3.0),
      ),
      'icon': Icons.west,
    },
    {
      'name': 'end',
      'border': LinearBorder(
        end: LinearBorderEdge(size: 1.0, alignment: 0.0),
        side: BorderSide(color: tealDeep, width: 3.0),
      ),
      'icon': Icons.east,
    },
  ];

  final sideCards = sideSpecs.map((spec) {
    final name = spec['name'] as String;
    final border = spec['border'] as LinearBorder;
    print('Single side: $name -> ${border.runtimeType}');
    return Container(
      width: 140.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            tealMid.withValues(alpha: 0.10),
            tealDeep.withValues(alpha: 0.20),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: tealMid, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: tealDeep.withValues(alpha: 0.20),
            blurRadius: 10.0,
            offset: Offset(0.0, 4.0),
          ),
          BoxShadow(
            color: charcoal.withValues(alpha: 0.05),
            blurRadius: 2.0,
            offset: Offset(0.0, 1.0),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(spec['icon'] as IconData, color: tealDeep, size: 18.0),
              SizedBox(width: 6.0),
              Text(
                'side: $name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: tealDeep,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Container(
            width: 100.0,
            height: 70.0,
            decoration: ShapeDecoration(color: cream, shape: border),
            alignment: Alignment.center,
            child: Text(
              name.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.0,
                color: tealMid,
              ),
            ),
          ),
        ],
      ),
    );
  }).toList();

  final sidesSection = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [cream, tealSoft.withValues(alpha: 0.25)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: tealMid.withValues(alpha: 0.4), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: tealMid.withValues(alpha: 0.20),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 5 — All four sides',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: tealDeep,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'LinearBorder accepts top, bottom, start and end edges.',
          style: TextStyle(fontSize: 12.0, color: charcoal),
        ),
        SizedBox(height: 12.0),
        Wrap(children: sideCards),
      ],
    ),
  );
  print('Sides section complete');

  // ============================================================
  // SECTION 6: Combinations
  // ============================================================
  print('=== Section 6: combinations ===');

  final List<Map<String, dynamic>> comboSpecs = [
    {
      'name': 'Bracket',
      'note': 'top + start corners',
      'border': LinearBorder(
        top: LinearBorderEdge(size: 0.4, alignment: -1.0),
        start: LinearBorderEdge(size: 0.4, alignment: -1.0),
        side: BorderSide(color: tealDeep, width: 3.0),
      ),
    },
    {
      'name': 'L-shape',
      'note': 'bottom + start full',
      'border': LinearBorder(
        bottom: LinearBorderEdge(size: 1.0, alignment: 0.0),
        start: LinearBorderEdge(size: 1.0, alignment: 0.0),
        side: BorderSide(color: tealDeep, width: 3.0),
      ),
    },
    {
      'name': 'Asymmetric',
      'note': 'short top, long bottom',
      'border': LinearBorder(
        top: LinearBorderEdge(size: 0.3, alignment: 1.0),
        bottom: LinearBorderEdge(size: 0.8, alignment: -1.0),
        side: BorderSide(color: tealDeep, width: 3.0),
      ),
    },
    {
      'name': 'Tab-like',
      'note': 'centered top accent',
      'border': LinearBorder(
        top: LinearBorderEdge(size: 0.6, alignment: 0.0),
        side: BorderSide(color: tealDeep, width: 4.0),
      ),
    },
  ];

  final comboCards = comboSpecs.map((spec) {
    final border = spec['border'] as LinearBorder;
    print('Combo: ${spec['name']}');
    return Container(
      width: 150.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            sageSoft.withValues(alpha: 0.4),
            tealSoft.withValues(alpha: 0.35),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(
          color: sageMid.withValues(alpha: 0.6),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: sageMid.withValues(alpha: 0.30),
            blurRadius: 12.0,
            offset: Offset(0.0, 5.0),
          ),
          BoxShadow(
            color: tealDeep.withValues(alpha: 0.06),
            blurRadius: 2.0,
            offset: Offset(0.0, 1.0),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            spec['name'] as String,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
              color: tealDeep,
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            width: 110.0,
            height: 70.0,
            decoration: ShapeDecoration(color: cream, shape: border),
            alignment: Alignment.center,
            child: Icon(Icons.crop_din, color: tealMid, size: 22.0),
          ),
          SizedBox(height: 6.0),
          Text(
            spec['note'] as String,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 9.5, color: charcoal),
          ),
        ],
      ),
    );
  }).toList();

  final combosSection = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [cream, sageMid.withValues(alpha: 0.18)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: sageMid.withValues(alpha: 0.5), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: sageMid.withValues(alpha: 0.22),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 6 — Creative combinations',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: tealDeep,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Mix multiple LinearBorderEdges to make brackets, L-shapes, etc.',
          style: TextStyle(fontSize: 12.0, color: charcoal),
        ),
        SizedBox(height: 12.0),
        Wrap(children: comboCards),
      ],
    ),
  );
  print('Combinations section complete');

  // ============================================================
  // SECTION 7: Material 3 button shapes
  // ============================================================
  print('=== Section 7: Material 3 button shapes ===');

  final outlinedButtonShape = LinearBorder(
    bottom: LinearBorderEdge(size: 1.0, alignment: 0.0),
    side: BorderSide(color: tealDeep, width: 2.0),
  );
  final filledButtonShape = LinearBorder(
    top: LinearBorderEdge(size: 0.5, alignment: 0.0),
    bottom: LinearBorderEdge(size: 0.5, alignment: 0.0),
    side: BorderSide(color: tealDeep, width: 2.0),
  );
  print(
    'Outlined uses: ${outlinedButtonShape.runtimeType}, '
    'Filled uses: ${filledButtonShape.runtimeType}',
  );

  final buttonsSection = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [tealDeep.withValues(alpha: 0.92), tealMid],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: tealDeep.withValues(alpha: 0.40),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: cream.withValues(alpha: 0.10),
          blurRadius: 1.0,
          offset: Offset(0.0, -1.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 7 — Material 3 buttons',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: cream,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'LinearBorder is supported by OutlinedButton & FilledButton.tonal.',
          style: TextStyle(
            fontSize: 12.0,
            color: cream.withValues(alpha: 0.85),
          ),
        ),
        SizedBox(height: 16.0),
        Wrap(
          spacing: 16.0,
          runSpacing: 12.0,
          children: [
            OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.bolt, color: cream),
              label: Text(
                'Outlined',
                style: TextStyle(color: cream),
              ),
              style: OutlinedButton.styleFrom(
                shape: outlinedButtonShape,
                side: BorderSide(color: cream, width: 2.0),
                padding: EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 12.0,
                ),
              ),
            ),
            FilledButton.tonal(
              onPressed: () {},
              child: Text('Filled tonal'),
              style: FilledButton.styleFrom(
                shape: filledButtonShape,
                backgroundColor: cream,
                foregroundColor: tealDeep,
                padding: EdgeInsets.symmetric(
                  horizontal: 22.0,
                  vertical: 12.0,
                ),
              ),
            ),
            FilledButton(
              onPressed: () {},
              child: Text('Bracket'),
              style: FilledButton.styleFrom(
                shape: LinearBorder(
                  top: LinearBorderEdge(size: 0.4, alignment: -1.0),
                  start: LinearBorderEdge(size: 1.0, alignment: 0.0),
                  bottom: LinearBorderEdge(size: 0.4, alignment: -1.0),
                  side: BorderSide(color: cream, width: 2.0),
                ),
                backgroundColor: sageSoft,
                foregroundColor: tealDeep,
                padding: EdgeInsets.symmetric(
                  horizontal: 22.0,
                  vertical: 12.0,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
  print('Buttons section ready');

  // ============================================================
  // SECTION 8: Comparison table
  // ============================================================
  print('=== Section 8: comparison table ===');

  final List<Map<String, String>> comparisonRows = [
    {
      'feature': 'Type',
      'lbe': 'OutlinedBorder',
      'rrb': 'OutlinedBorder',
      'crb': 'OutlinedBorder',
    },
    {
      'feature': 'Per-side control',
      'lbe': 'yes (4 edges)',
      'rrb': 'no (uniform)',
      'crb': 'no (uniform)',
    },
    {
      'feature': 'Partial edges',
      'lbe': 'yes (size 0-1)',
      'rrb': 'no',
      'crb': 'no',
    },
    {
      'feature': 'Rounded corners',
      'lbe': 'no',
      'rrb': 'yes',
      'crb': 'smooth',
    },
    {
      'feature': 'Best for',
      'lbe': 'tabs / accents',
      'rrb': 'cards / chips',
      'crb': 'iOS look',
    },
  ];

  final comparisonHeader = Container(
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
    decoration: BoxDecoration(
      color: tealDeep,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(8.0),
      ),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            'Feature',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: cream,
              fontSize: 12.0,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'LinearBorder',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: cream,
              fontSize: 12.0,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'RoundedRect',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: cream,
              fontSize: 12.0,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'ContinuousR',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: cream,
              fontSize: 12.0,
            ),
          ),
        ),
      ],
    ),
  );

  final comparisonDataRows = comparisonRows.map((row) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: cream,
        border: Border(
          bottom: BorderSide(
            color: tealSoft.withValues(alpha: 0.5),
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              row['feature']!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: tealDeep,
                fontSize: 11.0,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              row['lbe']!,
              style: TextStyle(color: charcoal, fontSize: 11.0),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              row['rrb']!,
              style: TextStyle(color: charcoal, fontSize: 11.0),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              row['crb']!,
              style: TextStyle(color: charcoal, fontSize: 11.0),
            ),
          ),
        ],
      ),
    );
  }).toList();

  final comparisonSection = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [cream, sageSoft.withValues(alpha: 0.35)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: tealMid.withValues(alpha: 0.4), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: tealDeep.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 8 — Comparison vs. siblings',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: tealDeep,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'How LinearBorderEdge differs from other OutlinedBorders.',
          style: TextStyle(fontSize: 12.0, color: charcoal),
        ),
        SizedBox(height: 12.0),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: tealDeep.withValues(alpha: 0.10),
                blurRadius: 6.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Column(
            children: [
              comparisonHeader,
              ...comparisonDataRows,
            ],
          ),
        ),
        SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 80.0,
              height: 60.0,
              decoration: ShapeDecoration(
                color: tealSoft.withValues(alpha: 0.4),
                shape: LinearBorder(
                  top: LinearBorderEdge(size: 0.6, alignment: 0.0),
                  side: BorderSide(color: tealDeep, width: 2.5),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'Linear',
                style: TextStyle(fontSize: 10.0, color: tealDeep),
              ),
            ),
            Container(
              width: 80.0,
              height: 60.0,
              decoration: ShapeDecoration(
                color: sageSoft.withValues(alpha: 0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: BorderSide(color: tealDeep, width: 2.5),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'Rounded',
                style: TextStyle(fontSize: 10.0, color: tealDeep),
              ),
            ),
            Container(
              width: 80.0,
              height: 60.0,
              decoration: ShapeDecoration(
                color: cream,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: tealDeep, width: 2.5),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'Continuous',
                style: TextStyle(fontSize: 10.0, color: tealDeep),
              ),
            ),
          ],
        ),
      ],
    ),
  );
  print('Comparison table ready');

  // ============================================================
  // SECTION 9: Footguns
  // ============================================================
  print('=== Section 9: footguns ===');

  // Cluster C31: the Flutter SDK enforces `size in [0.0, 1.0]` via an
  // `assert(...)` inside LinearBorderEdge's constructor
  // (linear_border.dart L39). Earlier revisions of this script claimed
  // out-of-range sizes "still construct" — that's incorrect: in debug
  // mode the assertion throws immediately. Use boundary values only,
  // and demonstrate the *constraint* in the footguns prose instead.
  final maxSizeEdge = LinearBorderEdge(size: 1.0, alignment: 0.0);
  final minSizeEdge = LinearBorderEdge(size: 0.0, alignment: 0.0);
  final overshootAlign = LinearBorderEdge(size: 0.5, alignment: 2.0);
  print('Max size: ${maxSizeEdge.size} (boundary)');
  print('Min size: ${minSizeEdge.size} (invisible boundary)');
  print('Overshoot alignment: ${overshootAlign.alignment}');

  final List<Map<String, dynamic>> footguns = [
    {
      'icon': Icons.warning_amber,
      'title': 'size > 1.0',
      'desc':
          'The LinearBorderEdge constructor asserts size is in [0,1]. '
          'Values outside this range throw at construction in debug mode.',
    },
    {
      'icon': Icons.do_not_disturb_on,
      'title': 'size < 0',
      'desc':
          'Same assert(size >= 0.0 && size <= 1.0) rejects negatives — '
          'clamp inputs before constructing the edge.',
    },
    {
      'icon': Icons.swap_horiz,
      'title': 'TextDirection',
      'desc':
          '`start`/`end` flip with TextDirection. Use top/bottom for '
          'direction-independent layouts.',
    },
    {
      'icon': Icons.broken_image_outlined,
      'title': 'No corners',
      'desc':
          'LinearBorder ignores BorderRadius — combine with ClipRRect if you '
          'need rounded corners.',
    },
  ];

  final footgunCards = footguns.map((f) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFFFF1E6),
            Color(0xFFFFE0B2).withValues(alpha: 0.45),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Color(0xFFE0A040), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFE0A040).withValues(alpha: 0.30),
            blurRadius: 8.0,
            offset: Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            f['icon'] as IconData,
            color: Color(0xFFB35900),
            size: 26.0,
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  f['title'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8A4A00),
                    fontSize: 13.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  f['desc'] as String,
                  style: TextStyle(color: charcoal, fontSize: 11.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  final footgunsSection = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFFFF8F0),
          Color(0xFFFFEAD2).withValues(alpha: 0.7),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFFE0A040), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFE0A040).withValues(alpha: 0.25),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 9 — Footguns',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF8A4A00),
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Edge cases that bite: bad inputs and direction quirks.',
          style: TextStyle(fontSize: 12.0, color: charcoal),
        ),
        SizedBox(height: 10.0),
        ...footgunCards,
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: charcoal,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'max=${maxSizeEdge.size}  '
            'min=${minSizeEdge.size}  '
            'overshoot=${overshootAlign.alignment}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: cream,
            ),
          ),
        ),
      ],
    ),
  );
  print('Footguns section ready');

  // ============================================================
  // SECTION 10: Recap card
  // ============================================================
  print('=== Section 10: recap ===');

  final recapPoints = <String>[
    'LinearBorderEdge describes one piece of one side of a LinearBorder.',
    'size is a fraction (0-1) of the side covered.',
    'alignment is -1..1 along the side (start..end).',
    'LinearBorder takes up to 4 edges: top, bottom, start, end.',
    'Combine partial edges to build brackets, tabs, L-shapes.',
    'Use with Material 3 buttons via the shape parameter.',
    'Has no corner radius — pair with ClipRRect if needed.',
  ];

  final recapBullets = recapPoints.map((p) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: tealMid, size: 18.0),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              p,
              style: TextStyle(fontSize: 12.5, color: cream),
            ),
          ),
        ],
      ),
    );
  }).toList();

  final recapSection = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [tealDeep, charcoal],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: tealDeep.withValues(alpha: 0.5),
          blurRadius: 22.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: cream.withValues(alpha: 0.10),
          blurRadius: 1.0,
          offset: Offset(0.0, -1.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.auto_awesome, color: cream, size: 24.0),
            SizedBox(width: 10.0),
            Text(
              'Section 10 — Recap',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: cream,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        ...recapBullets,
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: cream.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: cream.withValues(alpha: 0.30),
              width: 1.0,
            ),
          ),
          child: Text(
            'Demo complete — LinearBorderEdge ready to use.',
            style: TextStyle(
              color: cream,
              fontSize: 12.0,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
  print('Recap section ready');

  print('LinearBorderEdge Deep Demo finished');

  return Scaffold(
    backgroundColor: cream,
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          anatomyDiagram,
          sizeSection,
          alignmentSection,
          sidesSection,
          combosSection,
          buttonsSection,
          comparisonSection,
          footgunsSection,
          recapSection,
          SizedBox(height: 20.0),
        ],
      ),
    ),
  );
}
