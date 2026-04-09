// ignore_for_file: avoid_print
// D4rt test script: Deep demo for BoxShape enum from painting
// Demonstrates rectangle vs circle shape in BoxDecoration, avatars,
// borders, shadows, gradients, and real-world UI patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BoxShape Deep Demo executing');

  // ── palette ──────────────────────────────────────────────────
  final Color bxPrimary = Color(0xFF2E7D32); // green 800
  final Color bxAccent = Color(0xFF66BB6A); // green 400
  final Color bxSurface = Color(0xFFE8F5E9); // green 50
  final Color bxDark = Color(0xFF1B5E20); // green 900
  final Color bxRect = Color(0xFF1565C0); // blue 800 for rectangle
  final Color bxCirc = Color(0xFFAD1457); // pink 800 for circle

  Widget bxBadge(String text, Color color) {
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

  Widget bxSectionHeader(String title, IconData icon) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      margin: EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [bxPrimary, bxAccent]),
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

  Widget bxCard(Widget child) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: bxPrimary.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
              color: bxPrimary.withValues(alpha: 0.08),
              blurRadius: 6.0,
              offset: Offset(0, 2)),
        ],
      ),
      child: child,
    );
  }

  Widget bxInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.0),
      child: Row(children: [
        SizedBox(
          width: 150.0,
          child: Text(label,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: bxDark)),
        ),
        Expanded(
          child: Text(value,
              style: TextStyle(
                  fontSize: 12.0,
                  color: valueColor ?? bxPrimary,
                  fontWeight: FontWeight.w500)),
        ),
      ]),
    );
  }

  // ============================================================
  // SECTION 1: Title & Overview
  // ============================================================
  print('=== Section 1: Title & Overview ===');

  final bxTitleSection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [bxDark, bxPrimary, bxAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
            color: bxDark.withValues(alpha: 0.35),
            blurRadius: 14.0,
            offset: Offset(0, 6)),
      ],
    ),
    child: Column(children: [
      Icon(Icons.crop_square, size: 48.0, color: Colors.white),
      SizedBox(height: 10.0),
      Text('BoxShape',
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
          'Determines the shape of a BoxDecoration — either a '
          'rectangle (with optional rounded corners) or a circle '
          '(which forces equal width and height). Despite having '
          'only 2 values, BoxShape fundamentally controls how '
          'decorations, borders, shadows, and gradients render.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 12.0, height: 1.4),
        ),
      ),
    ]),
  );

  // ============================================================
  // SECTION 2: The Two Values — Visual Identity
  // ============================================================
  print('=== Section 2: Two Values ===');

  for (final shape in BoxShape.values) {
    print('  BoxShape.${shape.name}: index=${shape.index}');
  }

  final bxTwoValuesSection = bxCard(Column(children: [
    Text('The Two Values',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bxDark)),
    SizedBox(height: 12.0),
    Row(children: [
      Expanded(
        child: Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: bxRect.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: bxRect.withValues(alpha: 0.3)),
          ),
          child: Column(children: [
            Container(
              width: 80.0,
              height: 60.0,
              decoration: BoxDecoration(
                color: bxRect.withValues(alpha: 0.2),
                shape: BoxShape.rectangle,
                border: Border.all(color: bxRect, width: 2.0),
              ),
            ),
            SizedBox(height: 10.0),
            Text('rectangle',
                style: TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.bold, color: bxRect)),
            SizedBox(height: 4.0),
            Text('index: 0 (default)',
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
            SizedBox(height: 6.0),
            Text('Takes the full bounds of the container. '
                'Allows borderRadius for rounded corners.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700, height: 1.3)),
          ]),
        ),
      ),
      SizedBox(width: 12.0),
      Expanded(
        child: Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: bxCirc.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: bxCirc.withValues(alpha: 0.3)),
          ),
          child: Column(children: [
            Container(
              width: 70.0,
              height: 70.0,
              decoration: BoxDecoration(
                color: bxCirc.withValues(alpha: 0.2),
                shape: BoxShape.circle,
                border: Border.all(color: bxCirc, width: 2.0),
              ),
            ),
            SizedBox(height: 10.0),
            Text('circle',
                style: TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.bold, color: bxCirc)),
            SizedBox(height: 4.0),
            Text('index: 1',
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
            SizedBox(height: 6.0),
            Text('Inscribes a circle within the bounds. '
                'Cannot use borderRadius. Forces 1:1 aspect.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700, height: 1.3)),
          ]),
        ),
      ),
    ]),
  ]));

  // ============================================================
  // SECTION 3: BoxDecoration Side-by-Side
  // ============================================================
  print('=== Section 3: BoxDecoration ===');

  Widget bxDecoSample(BoxShape shape, Color fillColor, String label) {
    return Column(children: [
      Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
          color: fillColor.withValues(alpha: 0.25),
          shape: shape,
          border: Border.all(color: fillColor, width: 2.0),
        ),
        child: Center(
          child: Text(shape.name,
              style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: fillColor)),
        ),
      ),
      SizedBox(height: 4.0),
      Text(label,
          style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
    ]);
  }

  final bxDecoColors = [
    Color(0xFFE53935), Color(0xFF1E88E5), Color(0xFF43A047),
    Color(0xFFFB8C00), Color(0xFF8E24AA), Color(0xFF00ACC1),
  ];

  final bxDecoSection = bxCard(Column(children: [
    Text('BoxDecoration with Both Shapes',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bxDark)),
    SizedBox(height: 4.0),
    Text('Same 80×80 container with different colors, rectangle vs circle',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Text('Rectangles',
        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: bxRect)),
    SizedBox(height: 6.0),
    Wrap(
      alignment: WrapAlignment.center,
      spacing: 8.0,
      runSpacing: 8.0,
      children: bxDecoColors.map((c) =>
          bxDecoSample(BoxShape.rectangle, c, 'rect')).toList(),
    ),
    SizedBox(height: 16.0),
    Text('Circles',
        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: bxCirc)),
    SizedBox(height: 6.0),
    Wrap(
      alignment: WrapAlignment.center,
      spacing: 8.0,
      runSpacing: 8.0,
      children: bxDecoColors.map((c) =>
          bxDecoSample(BoxShape.circle, c, 'circle')).toList(),
    ),
  ]));

  // ============================================================
  // SECTION 4: borderRadius Restriction
  // ============================================================
  print('=== Section 4: borderRadius Restriction ===');

  final bxRadiusSection = bxCard(Column(children: [
    Text('borderRadius Restriction',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bxDark)),
    SizedBox(height: 4.0),
    Text('borderRadius is only allowed with BoxShape.rectangle. '
        'Using it with circle throws an assertion error at runtime.',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Row(children: [
      Expanded(
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: bxRect.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: bxRect.withValues(alpha: 0.25)),
          ),
          child: Column(children: [
            Text('Rectangle + borderRadius',
                style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: bxRect)),
            SizedBox(height: 8.0),
            Container(
              width: 100.0,
              height: 60.0,
              decoration: BoxDecoration(
                color: bxRect.withValues(alpha: 0.2),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: bxRect, width: 2.0),
              ),
              child: Center(
                child: Text('radius: 16',
                    style: TextStyle(fontSize: 10.0, color: bxRect)),
              ),
            ),
            SizedBox(height: 6.0),
            bxBadge('VALID', bxRect),
          ]),
        ),
      ),
      SizedBox(width: 10.0),
      Expanded(
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.red.withValues(alpha: 0.25)),
          ),
          child: Column(children: [
            Text('Circle + borderRadius',
                style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: Colors.red)),
            SizedBox(height: 8.0),
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.red.withValues(alpha: 0.3), width: 2.0),
              ),
              child: Center(
                child: Icon(Icons.close, color: Colors.red, size: 28.0),
              ),
            ),
            SizedBox(height: 6.0),
            bxBadge('ASSERTION ERROR', Colors.red),
          ]),
        ),
      ),
    ]),
    SizedBox(height: 12.0),
    Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: bxSurface,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Radius values with rectangle:',
              style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: bxDark)),
          SizedBox(height: 6.0),
          Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: [0.0, 4.0, 8.0, 16.0, 24.0, 40.0].map((r) {
              return Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: bxPrimary.withValues(alpha: 0.15),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(r),
                  border: Border.all(color: bxPrimary),
                ),
                child: Center(
                  child: Text('${r.toInt()}',
                      style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: bxDark)),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 4.0),
          Text('radius 0 → 40: progressively more circular appearance',
              style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
        ],
      ),
    ),
  ]));

  // ============================================================
  // SECTION 5: Shadow Rendering
  // ============================================================
  print('=== Section 5: Shadow Rendering ===');

  final bxShadowSection = bxCard(Column(children: [
    Text('Shadow Shape Follows BoxShape',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bxDark)),
    SizedBox(height: 4.0),
    Text('BoxShadow is clipped to the decoration shape automatically',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Row(children: [
      Expanded(
        child: Column(children: [
          Container(
            width: 100.0,
            height: 70.0,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(color: bxRect.withValues(alpha: 0.4),
                    blurRadius: 12.0, offset: Offset(4, 4)),
              ],
            ),
            child: Center(
              child: Text('rect shadow',
                  style: TextStyle(fontSize: 10.0, color: bxRect)),
            ),
          ),
          SizedBox(height: 8.0),
          Text('Rectangle shadow',
              style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: bxRect)),
          Text('Rectangular spread',
              style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
        ]),
      ),
      Expanded(
        child: Column(children: [
          Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: bxCirc.withValues(alpha: 0.4),
                    blurRadius: 12.0, offset: Offset(4, 4)),
              ],
            ),
            child: Center(
              child: Text('circle\nshadow',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10.0, color: bxCirc)),
            ),
          ),
          SizedBox(height: 8.0),
          Text('Circle shadow',
              style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: bxCirc)),
          Text('Circular spread',
              style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
        ]),
      ),
    ]),
  ]));

  // ============================================================
  // SECTION 6: Gradient Rendering
  // ============================================================
  print('=== Section 6: Gradient Rendering ===');

  final bxGradientSection = bxCard(Column(children: [
    Text('Gradient Clipping by Shape',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bxDark)),
    SizedBox(height: 4.0),
    Text('The same gradient paints differently in each shape',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Row(children: [
      Expanded(
        child: Column(children: [
          Container(
            width: 120.0,
            height: 80.0,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10.0),
              gradient: LinearGradient(
                colors: [Color(0xFF1565C0), Color(0xFF42A5F5), Color(0xFFBBDEFB)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SizedBox(height: 4.0),
          Text('LinearGradient (rect)',
              style: TextStyle(fontSize: 10.0, color: bxRect)),
        ]),
      ),
      SizedBox(width: 8.0),
      Expanded(
        child: Column(children: [
          Container(
            width: 90.0,
            height: 90.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF1565C0), Color(0xFF42A5F5), Color(0xFFBBDEFB)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SizedBox(height: 4.0),
          Text('LinearGradient (circle)',
              style: TextStyle(fontSize: 10.0, color: bxCirc)),
        ]),
      ),
    ]),
    SizedBox(height: 14.0),
    Row(children: [
      Expanded(
        child: Column(children: [
          Container(
            width: 120.0,
            height: 80.0,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10.0),
              gradient: RadialGradient(
                colors: [Color(0xFFFFD54F), Color(0xFFFF8F00), Color(0xFFBF360C)],
              ),
            ),
          ),
          SizedBox(height: 4.0),
          Text('RadialGradient (rect)',
              style: TextStyle(fontSize: 10.0, color: bxRect)),
        ]),
      ),
      SizedBox(width: 8.0),
      Expanded(
        child: Column(children: [
          Container(
            width: 90.0,
            height: 90.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [Color(0xFFFFD54F), Color(0xFFFF8F00), Color(0xFFBF360C)],
              ),
            ),
          ),
          SizedBox(height: 4.0),
          Text('RadialGradient (circle)',
              style: TextStyle(fontSize: 10.0, color: bxCirc)),
        ]),
      ),
    ]),
  ]));

  // ============================================================
  // SECTION 7: Avatar Patterns
  // ============================================================
  print('=== Section 7: Avatar Patterns ===');

  Widget bxAvatarSample(String initials, Color color, double size) {
    return Container(
      width: size,
      height: size,
      margin: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: Colors.white, width: 2.0),
        boxShadow: [
          BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 6.0,
              offset: Offset(0, 2)),
        ],
      ),
      child: Center(
        child: Text(initials,
            style: TextStyle(
                color: Colors.white,
                fontSize: size * 0.32,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  final bxAvatarSection = bxCard(Column(children: [
    Text('Avatar Patterns (BoxShape.circle)',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bxDark)),
    SizedBox(height: 4.0),
    Text('Circular containers are the standard avatar shape in Flutter',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      bxAvatarSample('AB', Color(0xFF1565C0), 50.0),
      bxAvatarSample('CD', Color(0xFFE53935), 50.0),
      bxAvatarSample('EF', Color(0xFF43A047), 50.0),
      bxAvatarSample('GH', Color(0xFFFB8C00), 50.0),
      bxAvatarSample('IJ', Color(0xFF8E24AA), 50.0),
    ]),
    SizedBox(height: 12.0),
    Text('Overlapping avatar stack:',
        style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: bxDark)),
    SizedBox(height: 6.0),
    SizedBox(
      height: 44.0,
      width: 160.0,
      child: Stack(children: [
        Positioned(left: 0, child: bxAvatarSample('A', Color(0xFF1565C0), 40.0)),
        Positioned(left: 24, child: bxAvatarSample('B', Color(0xFFE53935), 40.0)),
        Positioned(left: 48, child: bxAvatarSample('C', Color(0xFF43A047), 40.0)),
        Positioned(left: 72, child: bxAvatarSample('D', Color(0xFFFB8C00), 40.0)),
        Positioned(
          left: 96,
          child: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade400,
              border: Border.all(color: Colors.white, width: 2.0),
            ),
            child: Center(
              child: Text('+3',
                  style: TextStyle(
                      color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ]),
    ),
  ]));

  // ============================================================
  // SECTION 8: Non-Square Containers
  // ============================================================
  print('=== Section 8: Non-Square Containers ===');

  final bxNonSquareSection = bxCard(Column(children: [
    Text('Circle in Non-Square Containers',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bxDark)),
    SizedBox(height: 4.0),
    Text('When width ≠ height, circle inscribes using the smaller dimension. '
        'The container still occupies the full rectangle bounds.',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Wrap(
      alignment: WrapAlignment.center,
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        [120.0, 60.0],
        [60.0, 120.0],
        [80.0, 80.0],
        [140.0, 50.0],
      ].map((dims) {
        final w = dims[0];
        final h = dims[1];
        return Column(children: [
          Container(
            width: w,
            height: h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bxCirc.withValues(alpha: 0.15),
              border: Border.all(color: bxCirc, width: 1.5),
            ),
          ),
          SizedBox(height: 4.0),
          Text('${w.toInt()}×${h.toInt()}',
              style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, color: bxDark)),
          Text('circle: ${(w < h ? w : h).toInt()} dia',
              style: TextStyle(fontSize: 9.0, color: Colors.grey.shade600)),
        ]);
      }).toList(),
    ),
  ]));

  // ============================================================
  // SECTION 9: Comparison Table
  // ============================================================
  print('=== Section 9: Comparison Table ===');

  final bxCompareData = [
    {'feature': 'Default', 'rect': 'Yes', 'circ': 'No'},
    {'feature': 'borderRadius', 'rect': 'Allowed', 'circ': 'Forbidden'},
    {'feature': 'Aspect ratio', 'rect': 'Any', 'circ': '1:1 (inscribed)'},
    {'feature': 'Shadow shape', 'rect': 'Rectangular', 'circ': 'Circular'},
    {'feature': 'Gradient clip', 'rect': 'Rectangular', 'circ': 'Circular'},
    {'feature': 'Image clip', 'rect': 'Rectangular', 'circ': 'Circular'},
    {'feature': 'ClipPath needed', 'rect': 'No', 'circ': 'No'},
    {'feature': 'Common usage', 'rect': 'Cards, buttons', 'circ': 'Avatars, FABs'},
  ];

  final bxCompRows = <TableRow>[
    TableRow(
      decoration: BoxDecoration(color: bxPrimary.withValues(alpha: 0.1)),
      children: [
        Padding(padding: EdgeInsets.all(8.0), child: Text('Feature',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0, color: bxDark))),
        Padding(padding: EdgeInsets.all(8.0), child: Text('rectangle',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0, color: bxRect))),
        Padding(padding: EdgeInsets.all(8.0), child: Text('circle',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0, color: bxCirc))),
      ],
    ),
  ];
  for (var i = 0; i < bxCompareData.length; i++) {
    final d = bxCompareData[i];
    bxCompRows.add(TableRow(
      decoration: BoxDecoration(
        color: i.isEven ? Colors.white : bxSurface.withValues(alpha: 0.5),
      ),
      children: [
        Padding(padding: EdgeInsets.all(8.0), child: Text(d['feature']!,
            style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: bxDark))),
        Padding(padding: EdgeInsets.all(8.0), child: Text(d['rect']!,
            style: TextStyle(fontSize: 11.0, color: bxRect))),
        Padding(padding: EdgeInsets.all(8.0), child: Text(d['circ']!,
            style: TextStyle(fontSize: 11.0, color: bxCirc))),
      ],
    ));
  }

  final bxCompareSection = bxCard(Column(children: [
    Text('Rectangle vs Circle Comparison',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bxDark)),
    SizedBox(height: 10.0),
    Table(
      border: TableBorder.all(color: bxPrimary.withValues(alpha: 0.15)),
      columnWidths: {
        0: FixedColumnWidth(110.0),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
      },
      children: bxCompRows,
    ),
  ]));

  // ============================================================
  // SECTION 10: Widgets That Accept BoxShape
  // ============================================================
  print('=== Section 10: Widget Usage ===');

  final bxWidgetData = [
    {'widget': 'BoxDecoration', 'prop': 'shape', 'note': 'Primary consumer — paints shape'},
    {'widget': 'Container', 'prop': 'via decoration', 'note': 'Wrapper around BoxDecoration'},
    {'widget': 'CircleAvatar', 'prop': 'implicit', 'note': 'Always uses circle internally'},
    {'widget': 'AnimatedContainer', 'prop': 'via decoration', 'note': 'Animates shape transition'},
    {'widget': 'PhysicalModel', 'prop': 'clipBehavior', 'note': 'Uses shape for clipping'},
    {'widget': 'DecoratedBox', 'prop': 'via decoration', 'note': 'Low-level decoration widget'},
  ];

  final bxWidgetRows = <TableRow>[
    TableRow(children: [
      Padding(padding: EdgeInsets.all(8.0), child: Text('Widget',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0, color: bxDark))),
      Padding(padding: EdgeInsets.all(8.0), child: Text('Property',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0, color: bxDark))),
      Padding(padding: EdgeInsets.all(8.0), child: Text('Note',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0, color: bxDark))),
    ]),
  ];
  for (var i = 0; i < bxWidgetData.length; i++) {
    final w = bxWidgetData[i];
    bxWidgetRows.add(TableRow(
      decoration: BoxDecoration(
        color: i.isEven ? Colors.white : bxSurface.withValues(alpha: 0.5),
      ),
      children: [
        Padding(padding: EdgeInsets.all(8.0), child: Text(w['widget']!,
            style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: bxPrimary))),
        Padding(padding: EdgeInsets.all(8.0), child: Text(w['prop']!,
            style: TextStyle(fontSize: 11.0))),
        Padding(padding: EdgeInsets.all(8.0), child: Text(w['note']!,
            style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600))),
      ],
    ));
  }

  final bxWidgetTable = bxCard(Column(children: [
    Text('Widgets Using BoxShape',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bxDark)),
    SizedBox(height: 10.0),
    Table(
      border: TableBorder.all(color: bxPrimary.withValues(alpha: 0.15)),
      columnWidths: {
        0: FixedColumnWidth(130.0),
        1: FixedColumnWidth(100.0),
        2: FlexColumnWidth(),
      },
      children: bxWidgetRows,
    ),
  ]));

  // ============================================================
  // SECTION 11: Switch Pattern
  // ============================================================
  print('=== Section 11: Switch Pattern ===');

  Widget bxStyleForShape(BoxShape shape) {
    final isCircle = shape == BoxShape.circle;
    return Container(
      width: isCircle ? 70.0 : 100.0,
      height: 70.0,
      decoration: BoxDecoration(
        shape: shape,
        color: isCircle
            ? bxCirc.withValues(alpha: 0.2)
            : bxRect.withValues(alpha: 0.2),
        border: Border.all(
          color: isCircle ? bxCirc : bxRect,
          width: 2.0,
        ),
        borderRadius: isCircle ? null : BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(shape.name,
            style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
                color: isCircle ? bxCirc : bxRect)),
      ),
    );
  }

  final bxSwitchSection = bxCard(Column(children: [
    Text('Switch Pattern',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bxDark)),
    SizedBox(height: 4.0),
    Text('Conditional rendering based on BoxShape value',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: bxSurface,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
          'switch (shape) {\n'
          '  case BoxShape.rectangle:\n'
          '    // → use borderRadius\n'
          '  case BoxShape.circle:\n'
          '    // → no borderRadius\n'
          '}',
          style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: bxDark, height: 1.4)),
    ),
    SizedBox(height: 12.0),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        bxStyleForShape(BoxShape.rectangle),
        SizedBox(width: 16.0),
        bxStyleForShape(BoxShape.circle),
      ],
    ),
  ]));

  // ============================================================
  // SECTION 12: Card Gallery — Common UI Elements
  // ============================================================
  print('=== Section 12: UI Elements Gallery ===');

  Widget bxUIElement(String name, BoxShape shape, IconData icon, Color color) {
    final isC = shape == BoxShape.circle;
    return Container(
      width: 100.0,
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Column(children: [
        Container(
          width: isC ? 40.0 : 60.0,
          height: 40.0,
          decoration: BoxDecoration(
            shape: shape,
            color: color.withValues(alpha: 0.2),
            borderRadius: isC ? null : BorderRadius.circular(6.0),
            border: Border.all(color: color),
          ),
          child: Center(child: Icon(icon, color: color, size: 18.0)),
        ),
        SizedBox(height: 6.0),
        Text(name,
            style: TextStyle(
                fontSize: 10.0, fontWeight: FontWeight.bold, color: color)),
        Text(shape.name,
            style: TextStyle(fontSize: 9.0, color: Colors.grey.shade600)),
      ]),
    );
  }

  final bxGallerySection = bxCard(Column(children: [
    Text('Common UI Elements',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bxDark)),
    SizedBox(height: 4.0),
    Text('Which shape is typical for each UI component',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Wrap(
      alignment: WrapAlignment.center,
      spacing: 4.0,
      runSpacing: 4.0,
      children: [
        bxUIElement('Avatar', BoxShape.circle, Icons.person, bxCirc),
        bxUIElement('FAB', BoxShape.circle, Icons.add, Color(0xFF6A1B9A)),
        bxUIElement('Status Dot', BoxShape.circle, Icons.circle, Color(0xFF43A047)),
        bxUIElement('Card', BoxShape.rectangle, Icons.credit_card, bxRect),
        bxUIElement('Button', BoxShape.rectangle, Icons.smart_button, Color(0xFFE65100)),
        bxUIElement('Image', BoxShape.rectangle, Icons.image, Color(0xFF00695C)),
        bxUIElement('Badge', BoxShape.circle, Icons.notifications, Color(0xFFC62828)),
        bxUIElement('Chip', BoxShape.rectangle, Icons.label, Color(0xFF546E7A)),
      ],
    ),
  ]));

  // ============================================================
  // SECTION 13: Enum Equality & Properties
  // ============================================================
  print('=== Section 13: Equality ===');

  final bxEqRR = BoxShape.rectangle == BoxShape.rectangle;
  final bxEqRC = BoxShape.rectangle == BoxShape.circle;
  final bxEqCC = BoxShape.circle == BoxShape.circle;
  print('  rectangle == rectangle: $bxEqRR');
  print('  rectangle == circle: $bxEqRC');
  print('  circle == circle: $bxEqCC');

  final bxEqualitySection = bxCard(Column(children: [
    Text('Enum Equality & Properties',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bxDark)),
    SizedBox(height: 10.0),
    bxInfoRow('rect == rect', '$bxEqRR', valueColor: Colors.teal.shade700),
    bxInfoRow('rect == circle', '$bxEqRC', valueColor: Colors.red.shade700),
    bxInfoRow('circle == circle', '$bxEqCC', valueColor: Colors.teal.shade700),
    Divider(color: bxPrimary.withValues(alpha: 0.15)),
    bxInfoRow('values.length', '${BoxShape.values.length}'),
    bxInfoRow('rectangle.index', '${BoxShape.rectangle.index}'),
    bxInfoRow('circle.index', '${BoxShape.circle.index}'),
    bxInfoRow('first', BoxShape.values.first.name),
    bxInfoRow('last', BoxShape.values.last.name),
  ]));

  // ============================================================
  // SECTION 14: Animated Shape Transition
  // ============================================================
  print('=== Section 14: Animated Transition ===');

  final bxAnimSection = bxCard(Column(children: [
    Text('AnimatedContainer Shape Transition',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bxDark)),
    SizedBox(height: 4.0),
    Text('AnimatedContainer supports animating between shapes. '
        'This simulates the start and end states visually.',
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
    SizedBox(height: 12.0),
    Row(children: [
      Expanded(
        child: Column(children: [
          Text('Start',
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: bxRect)),
          SizedBox(height: 6.0),
          Container(
            width: 80.0,
            height: 60.0,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(4.0),
              color: bxRect.withValues(alpha: 0.2),
              border: Border.all(color: bxRect, width: 2.0),
            ),
            child: Center(child: Icon(Icons.crop_square, color: bxRect)),
          ),
        ]),
      ),
      Column(children: [
        Icon(Icons.arrow_forward, color: bxPrimary, size: 28.0),
        Text('animate',
            style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
      ]),
      Expanded(
        child: Column(children: [
          Text('End',
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: bxCirc)),
          SizedBox(height: 6.0),
          Container(
            width: 70.0,
            height: 70.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bxCirc.withValues(alpha: 0.2),
              border: Border.all(color: bxCirc, width: 2.0),
            ),
            child: Center(child: Icon(Icons.circle_outlined, color: bxCirc)),
          ),
        ]),
      ),
    ]),
    SizedBox(height: 12.0),
    Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: bxSurface,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
          'AnimatedContainer(\n'
          '  duration: Duration(ms: 300),\n'
          '  decoration: BoxDecoration(\n'
          '    shape: isCircle\n'
          '      ? BoxShape.circle\n'
          '      : BoxShape.rectangle,\n'
          '  ),\n'
          ')',
          style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: bxDark, height: 1.4)),
    ),
  ]));

  // ============================================================
  // SECTION 15: When to Use Each
  // ============================================================
  print('=== Section 15: When to Use ===');

  final bxWhenSection = bxCard(Column(children: [
    Text('When to Use Each Shape',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.bold, color: bxDark)),
    SizedBox(height: 12.0),
    Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: bxRect.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: bxRect.withValues(alpha: 0.2)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Use rectangle when:',
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: bxRect)),
        SizedBox(height: 6.0),
        Text('• Content must fill a non-square area',
            style: TextStyle(fontSize: 11.0, color: bxDark, height: 1.5)),
        Text('• You need borderRadius for rounded corners',
            style: TextStyle(fontSize: 11.0, color: bxDark, height: 1.5)),
        Text('• Building cards, containers, buttons, tiles',
            style: TextStyle(fontSize: 11.0, color: bxDark, height: 1.5)),
        Text('• Default shape — use unless circle is needed',
            style: TextStyle(fontSize: 11.0, color: bxDark, height: 1.5)),
      ]),
    ),
    SizedBox(height: 10.0),
    Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: bxCirc.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: bxCirc.withValues(alpha: 0.2)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Use circle when:',
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: bxCirc)),
        SizedBox(height: 6.0),
        Text('• Rendering user avatars or profile images',
            style: TextStyle(fontSize: 11.0, color: bxDark, height: 1.5)),
        Text('• Creating FABs or circular action buttons',
            style: TextStyle(fontSize: 11.0, color: bxDark, height: 1.5)),
        Text('• Status indicators and notification dots',
            style: TextStyle(fontSize: 11.0, color: bxDark, height: 1.5)),
        Text('• Any element that should be perfectly round',
            style: TextStyle(fontSize: 11.0, color: bxDark, height: 1.5)),
      ]),
    ),
  ]));

  // ============================================================
  // SECTION 16: Summary Dashboard
  // ============================================================
  print('=== Section 16: Summary ===');

  final bxSummarySection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [bxDark, bxPrimary]),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(children: [
      Text('BoxShape — Summary',
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
          Text('0', style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.bold)),
          Text('default\n(rectangle)', textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 11.0)),
        ])),
        Expanded(child: Column(children: [
          Text('6+', style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.bold)),
          Text('widgets', style: TextStyle(color: Colors.white70, fontSize: 11.0)),
        ])),
        Expanded(child: Column(children: [
          Text('1:1', style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.bold)),
          Text('circle ratio', style: TextStyle(color: Colors.white70, fontSize: 11.0)),
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
          'BoxShape is a simple but fundamental enum in Flutter\'s painting '
          'library. Rectangle is the default for cards, buttons, and most UI; '
          'circle is essential for avatars, FABs, and status dots. Remember: '
          'borderRadius only works with rectangle — circle handles its own '
          'rounding automatically.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 11.0, height: 1.4),
        ),
      ),
    ]),
  );

  print('BoxShape Deep Demo complete');

  // ── Assemble ─────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1 Title
        bxTitleSection,
        SizedBox(height: 16.0),
        // 2 Two Values
        bxSectionHeader('The Two Values', Icons.compare_arrows),
        bxTwoValuesSection,
        // 3 BoxDecoration
        bxSectionHeader('BoxDecoration Shapes', Icons.palette),
        bxDecoSection,
        // 4 borderRadius
        bxSectionHeader('borderRadius Restriction', Icons.rounded_corner),
        bxRadiusSection,
        // 5 Shadow
        bxSectionHeader('Shadow Rendering', Icons.blur_on),
        bxShadowSection,
        // 6 Gradient
        bxSectionHeader('Gradient Clipping', Icons.gradient),
        bxGradientSection,
        // 7 Avatars
        bxSectionHeader('Avatar Patterns', Icons.group),
        bxAvatarSection,
        // 8 Non-Square
        bxSectionHeader('Non-Square Containers', Icons.crop),
        bxNonSquareSection,
        // 9 Comparison
        bxSectionHeader('Comparison Table', Icons.table_chart),
        bxCompareSection,
        // 10 Widgets
        bxSectionHeader('Widgets Using BoxShape', Icons.widgets),
        bxWidgetTable,
        // 11 Switch
        bxSectionHeader('Switch Pattern', Icons.alt_route),
        bxSwitchSection,
        // 12 UI Elements
        bxSectionHeader('Common UI Elements', Icons.dashboard),
        bxGallerySection,
        // 13 Equality
        bxSectionHeader('Equality & Properties', Icons.check_circle_outline),
        bxEqualitySection,
        // 14 Animation
        bxSectionHeader('Animated Transition', Icons.animation),
        bxAnimSection,
        // 15 When to Use
        bxSectionHeader('When to Use Each', Icons.lightbulb_outline),
        bxWhenSection,
        // 16 Summary
        SizedBox(height: 8.0),
        bxSummarySection,
      ],
    ),
  );
}
