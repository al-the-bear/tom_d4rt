// Deep demo: RenderObjectWithChildMixin - single-child render objects
// Tests widgets backed by render objects using RenderObjectWithChildMixin
// which provides exactly one child slot (child getter/setter).

import 'package:flutter/material.dart';

// Helper: build a gradient header bar
Widget _buildHeader(String title) {
  print('[RenderObjectWithChildMixin] Building header: $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 28, horizontal: 24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA), Color(0xFFAB47BC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
      boxShadow: [
        BoxShadow(
          color: Color(0x40000000),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 1.2,
      ),
    ),
  );
}

// Helper: build a section title with accent bar
Widget _buildSectionTitle(String title, Color accentColor) {
  print('[RenderObjectWithChildMixin] Section: $title');
  return Padding(
    padding: EdgeInsets.only(top: 24, bottom: 12, left: 16, right: 16),
    child: Row(
      children: [
        Container(
          width: 5,
          height: 28,
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: accentColor,
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper: a labeled demo card
Widget _buildDemoCard(String label, Widget child) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF616161),
          ),
        ),
        SizedBox(height: 8),
        child,
      ],
    ),
  );
}

// Helper: colored box sample
Widget _coloredSample(Color color, {double size = 60}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    ),
  );
}

// Section 1: Padding with different EdgeInsets
Widget _buildPaddingSection() {
  print('[Padding] Demonstrating Padding with various EdgeInsets');

  List<Map<String, dynamic>> paddingExamples = [
    {'label': 'EdgeInsets.all(8)', 'padding': EdgeInsets.all(8)},
    {'label': 'EdgeInsets.all(20)', 'padding': EdgeInsets.all(20)},
    {'label': 'EdgeInsets.symmetric(h:24, v:8)', 'padding': EdgeInsets.symmetric(horizontal: 24, vertical: 8)},
    {'label': 'EdgeInsets.only(left:32)', 'padding': EdgeInsets.only(left: 32)},
    {'label': 'EdgeInsets.fromLTRB(4,16,24,4)', 'padding': EdgeInsets.fromLTRB(4, 16, 24, 4)},
  ];

  List<Widget> items = [];
  for (var ex in paddingExamples) {
    print('[Padding] Example: ${ex['label']}');
    items.add(
      _buildDemoCard(
        ex['label'],
        Container(
          color: Color(0xFFE1BEE7),
          child: Padding(
            padding: ex['padding'],
            child: Container(
              width: 50,
              height: 50,
              color: Color(0xFF7B1FA2),
              child: Center(
                child: Text('P', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('1. Padding (RenderPadding)', Color(0xFF7B1FA2)),
      Text(
        '  Padding uses RenderPadding which extends RenderShiftedBox,\n  a single-child render object via RenderObjectWithChildMixin.',
        style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
      ),
      SizedBox(height: 8),
      ...items,
    ],
  );
}

// Section 2: Align with different Alignment values
Widget _buildAlignSection() {
  print('[Align] Demonstrating Align with various Alignment values');

  List<Map<String, dynamic>> alignExamples = [
    {'label': 'Alignment.topLeft', 'alignment': Alignment.topLeft},
    {'label': 'Alignment.center', 'alignment': Alignment.center},
    {'label': 'Alignment.bottomRight', 'alignment': Alignment.bottomRight},
    {'label': 'Alignment.centerLeft', 'alignment': Alignment.centerLeft},
    {'label': 'Alignment(0.5, -0.5)', 'alignment': Alignment(0.5, -0.5)},
  ];

  List<Widget> items = [];
  for (var ex in alignExamples) {
    print('[Align] Example: ${ex['label']}');
    items.add(
      _buildDemoCard(
        ex['label'],
        Container(
          height: 80,
          width: double.infinity,
          color: Color(0xFFE8EAF6),
          child: Align(
            alignment: ex['alignment'],
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Color(0xFF283593),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('2. Align (RenderPositionedBox)', Color(0xFF283593)),
      Text(
        '  Align uses RenderPositionedBox, another single-child render object.\n  It positions its child within itself according to alignment.',
        style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
      ),
      SizedBox(height: 8),
      ...items,
    ],
  );
}

// Section 3: Transform with rotate, scale, translate
Widget _buildTransformSection() {
  print('[Transform] Demonstrating Transform rotate, scale, translate');

  Widget baseBox = Container(
    width: 60,
    height: 60,
    decoration: BoxDecoration(
      color: Color(0xFFE65100),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Center(
      child: Text('T', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
    ),
  );

  print('[Transform] Rotate by 0.3 radians');
  print('[Transform] Scale by 1.4');
  print('[Transform] Translate by (20, 10)');
  print('[Transform] Combined rotate + scale');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('3. Transform (RenderTransform)', Color(0xFFE65100)),
      Text(
        '  Transform uses RenderTransform, a single-child render object\n  that applies a matrix4 transformation before painting.',
        style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
      ),
      SizedBox(height: 8),
      _buildDemoCard(
        'Transform.rotate(angle: 0.3)',
        Container(
          height: 100,
          width: double.infinity,
          color: Color(0xFFFFF3E0),
          child: Center(
            child: Transform.rotate(angle: 0.3, child: baseBox),
          ),
        ),
      ),
      _buildDemoCard(
        'Transform.scale(scale: 1.4)',
        Container(
          height: 100,
          width: double.infinity,
          color: Color(0xFFFFF3E0),
          child: Center(
            child: Transform.scale(scale: 1.4, child: baseBox),
          ),
        ),
      ),
      _buildDemoCard(
        'Transform.translate(offset: Offset(20, 10))',
        Container(
          height: 100,
          width: double.infinity,
          color: Color(0xFFFFF3E0),
          child: Center(
            child: Transform.translate(offset: Offset(20, 10), child: baseBox),
          ),
        ),
      ),
      _buildDemoCard(
        'Transform(rotate + scale combined)',
        Container(
          height: 100,
          width: double.infinity,
          color: Color(0xFFFFF3E0),
          child: Center(
            child: Transform(
              transform: Matrix4.identity()
                ..rotateZ(0.2)
                ..scale(1.2),
              alignment: Alignment.center,
              child: baseBox,
            ),
          ),
        ),
      ),
    ],
  );
}

// Section 4: Opacity with different values
Widget _buildOpacitySection() {
  print('[Opacity] Demonstrating Opacity with different values');

  List<double> opacityValues = [1.0, 0.75, 0.5, 0.25, 0.1];

  List<Widget> items = [];
  for (var val in opacityValues) {
    print('[Opacity] opacity=$val');
    items.add(
      Expanded(
        child: Column(
          children: [
            Opacity(
              opacity: val,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFF00695C),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 4),
            Text('$val', style: TextStyle(fontSize: 11, color: Color(0xFF757575))),
          ],
        ),
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('4. Opacity (RenderOpacity)', Color(0xFF00695C)),
      Text(
        '  Opacity uses RenderOpacity, a single-child render object\n  that makes its child partially transparent.',
        style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
      ),
      SizedBox(height: 8),
      _buildDemoCard(
        'Opacity values: 1.0, 0.75, 0.5, 0.25, 0.1',
        Row(children: items),
      ),
    ],
  );
}

// Section 5: DecoratedBox with different Decoration types
Widget _buildDecoratedBoxSection() {
  print('[DecoratedBox] Demonstrating DecoratedBox with various decorations');

  print('[DecoratedBox] BoxDecoration with solid color');
  print('[DecoratedBox] BoxDecoration with gradient');
  print('[DecoratedBox] BoxDecoration with border + borderRadius');
  print('[DecoratedBox] BoxDecoration with boxShadow');
  print('[DecoratedBox] ShapeDecoration with circle');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('5. DecoratedBox (RenderDecoratedBox)', Color(0xFFC62828)),
      Text(
        '  DecoratedBox uses RenderDecoratedBox which paints a Decoration\n  either before or after its child.',
        style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
      ),
      SizedBox(height: 8),
      _buildDemoCard(
        'BoxDecoration - solid color + borderRadius',
        DecoratedBox(
          decoration: BoxDecoration(
            color: Color(0xFFEF9A9A),
            borderRadius: BorderRadius.circular(16),
          ),
          child: SizedBox(width: 120, height: 60),
        ),
      ),
      _buildDemoCard(
        'BoxDecoration - linear gradient',
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFC62828), Color(0xFFEF5350), Color(0xFFFFCDD2)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox(width: 200, height: 50),
        ),
      ),
      _buildDemoCard(
        'BoxDecoration - radial gradient',
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [Color(0xFFFFEB3B), Color(0xFFFF9800), Color(0xFFF44336)],
              radius: 0.8,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox(width: 120, height: 120),
        ),
      ),
      _buildDemoCard(
        'BoxDecoration - border + shadow',
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color(0xFFC62828), width: 2),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Color(0x40C62828), blurRadius: 8, offset: Offset(2, 4)),
            ],
          ),
          child: SizedBox(width: 160, height: 60),
        ),
      ),
      _buildDemoCard(
        'ShapeDecoration - circle',
        DecoratedBox(
          decoration: ShapeDecoration(
            color: Color(0xFFAD1457),
            shape: CircleBorder(),
          ),
          child: SizedBox(width: 80, height: 80),
        ),
      ),
    ],
  );
}

// Section 6: ClipRect, ClipRRect, ClipOval, ClipPath
Widget _buildClipSection() {
  print('[Clip] Demonstrating clip widgets');

  Widget sampleImage = Container(
    width: 80,
    height: 80,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1565C0), Color(0xFF42A5F5), Color(0xFFBBDEFB)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Center(
      child: Text('CLIP', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
    ),
  );

  print('[Clip] ClipRect - rectangular clip');
  print('[Clip] ClipRRect - rounded rectangular clip');
  print('[Clip] ClipOval - elliptical clip');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('6. Clip Widgets (RenderClip*)', Color(0xFF1565C0)),
      Text(
        '  ClipRect, ClipRRect, ClipOval each use single-child render objects\n  (RenderClipRect, RenderClipRRect, RenderClipOval).',
        style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
      ),
      SizedBox(height: 8),
      _buildDemoCard(
        'ClipRect',
        ClipRect(
          child: Align(
            alignment: Alignment.topLeft,
            widthFactor: 0.6,
            heightFactor: 0.6,
            child: sampleImage,
          ),
        ),
      ),
      _buildDemoCard(
        'ClipRRect (borderRadius: 20)',
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: sampleImage,
        ),
      ),
      _buildDemoCard(
        'ClipOval',
        ClipOval(
          child: sampleImage,
        ),
      ),
      _buildDemoCard(
        'ClipRRect (only topLeft: 30, bottomRight: 30)',
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          child: sampleImage,
        ),
      ),
    ],
  );
}

// Section 7: SizedBox, ConstrainedBox, LimitedBox
Widget _buildSizingSection() {
  print('[Sizing] Demonstrating SizedBox, ConstrainedBox, LimitedBox');

  print('[Sizing] SizedBox with explicit width/height');
  print('[Sizing] SizedBox.expand');
  print('[Sizing] ConstrainedBox with min/max constraints');
  print('[Sizing] LimitedBox with maxWidth/maxHeight');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('7. Sizing Boxes (RenderConstrainedBox etc.)', Color(0xFF2E7D32)),
      Text(
        '  SizedBox, ConstrainedBox, LimitedBox all use single-child render\n  objects that impose sizing constraints on their child.',
        style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
      ),
      SizedBox(height: 8),
      _buildDemoCard(
        'SizedBox(width: 150, height: 40)',
        SizedBox(
          width: 150,
          height: 40,
          child: Container(
            color: Color(0xFFA5D6A7),
            child: Center(child: Text('150x40')),
          ),
        ),
      ),
      _buildDemoCard(
        'SizedBox(width: 80, height: 80)',
        SizedBox(
          width: 80,
          height: 80,
          child: Container(
            color: Color(0xFF66BB6A),
            child: Center(child: Text('80x80', style: TextStyle(color: Colors.white))),
          ),
        ),
      ),
      _buildDemoCard(
        'ConstrainedBox(minWidth: 100, minHeight: 50)',
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: 100, minHeight: 50),
          child: Container(
            color: Color(0xFFC8E6C9),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text('Min 100x50'),
            ),
          ),
        ),
      ),
      _buildDemoCard(
        'ConstrainedBox(maxWidth: 200, maxHeight: 60)',
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 200, maxHeight: 60),
          child: Container(
            width: 300,
            height: 100,
            color: Color(0xFF81C784),
            child: Center(child: Text('Constrained', style: TextStyle(color: Colors.white))),
          ),
        ),
      ),
      _buildDemoCard(
        'LimitedBox(maxWidth: 150, maxHeight: 50)',
        UnconstrainedBox(
          child: LimitedBox(
            maxWidth: 150,
            maxHeight: 50,
            child: Container(
              color: Color(0xFF388E3C),
              child: Center(child: Text('Limited', style: TextStyle(color: Colors.white))),
            ),
          ),
        ),
      ),
    ],
  );
}

// Section 8: FittedBox with different BoxFit values
Widget _buildFittedBoxSection() {
  print('[FittedBox] Demonstrating FittedBox with different BoxFit values');

  List<Map<String, dynamic>> fitExamples = [
    {'label': 'BoxFit.contain', 'fit': BoxFit.contain},
    {'label': 'BoxFit.cover', 'fit': BoxFit.cover},
    {'label': 'BoxFit.fill', 'fit': BoxFit.fill},
    {'label': 'BoxFit.fitWidth', 'fit': BoxFit.fitWidth},
    {'label': 'BoxFit.fitHeight', 'fit': BoxFit.fitHeight},
    {'label': 'BoxFit.scaleDown', 'fit': BoxFit.scaleDown},
    {'label': 'BoxFit.none', 'fit': BoxFit.none},
  ];

  Widget innerContent = Container(
    width: 120,
    height: 80,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF4A148C), Color(0xFF9C27B0)],
      ),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Center(
      child: Text('FIT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    ),
  );

  List<Widget> items = [];
  for (var ex in fitExamples) {
    print('[FittedBox] BoxFit: ${ex['label']}');
    items.add(
      _buildDemoCard(
        ex['label'],
        Container(
          width: 180,
          height: 60,
          color: Color(0xFFF3E5F5),
          child: FittedBox(
            fit: ex['fit'],
            child: innerContent,
          ),
        ),
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('8. FittedBox (RenderFittedBox)', Color(0xFF4A148C)),
      Text(
        '  FittedBox uses RenderFittedBox, a single-child render object that\n  scales and positions its child within itself according to BoxFit.',
        style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
      ),
      SizedBox(height: 8),
      ...items,
    ],
  );
}

// Section 9: Comparison table of single-child render objects
Widget _buildComparisonTable() {
  print('[Table] Building comparison of single-child render objects');

  List<Map<String, String>> tableData = [
    {'widget': 'Padding', 'renderObject': 'RenderPadding', 'purpose': 'Insets child by EdgeInsets'},
    {'widget': 'Align', 'renderObject': 'RenderPositionedBox', 'purpose': 'Positions child by Alignment'},
    {'widget': 'Center', 'renderObject': 'RenderPositionedBox', 'purpose': 'Centers child (Align subclass)'},
    {'widget': 'Transform', 'renderObject': 'RenderTransform', 'purpose': 'Applies Matrix4 transform'},
    {'widget': 'Opacity', 'renderObject': 'RenderOpacity', 'purpose': 'Applies alpha transparency'},
    {'widget': 'DecoratedBox', 'renderObject': 'RenderDecoratedBox', 'purpose': 'Paints Decoration around child'},
    {'widget': 'ClipRect', 'renderObject': 'RenderClipRect', 'purpose': 'Clips to rectangle'},
    {'widget': 'ClipRRect', 'renderObject': 'RenderClipRRect', 'purpose': 'Clips to rounded rectangle'},
    {'widget': 'ClipOval', 'renderObject': 'RenderClipOval', 'purpose': 'Clips to oval/circle'},
    {'widget': 'SizedBox', 'renderObject': 'RenderConstrainedBox', 'purpose': 'Forces exact size'},
    {'widget': 'ConstrainedBox', 'renderObject': 'RenderConstrainedBox', 'purpose': 'Applies BoxConstraints'},
    {'widget': 'LimitedBox', 'renderObject': 'RenderLimitedBox', 'purpose': 'Limits size in unconstrained axis'},
    {'widget': 'FittedBox', 'renderObject': 'RenderFittedBox', 'purpose': 'Scales/positions by BoxFit'},
    {'widget': 'FractionallySizedBox', 'renderObject': 'RenderFractionallySizedOverflowBox', 'purpose': 'Sizes child as fraction of parent'},
    {'widget': 'IntrinsicWidth', 'renderObject': 'RenderIntrinsicWidth', 'purpose': 'Sizes to intrinsic width'},
    {'widget': 'IntrinsicHeight', 'renderObject': 'RenderIntrinsicHeight', 'purpose': 'Sizes to intrinsic height'},
  ];

  List<TableRow> rows = [];

  // Header row
  rows.add(
    TableRow(
      decoration: BoxDecoration(color: Color(0xFF37474F)),
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Text('Widget', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text('Render Object', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text('Purpose', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
        ),
      ],
    ),
  );

  // Data rows
  for (var i = 0; i < tableData.length; i++) {
    var row = tableData[i];
    Color bgColor = (i % 2 == 0) ? Color(0xFFFFFFFF) : Color(0xFFF5F5F5);
    print('[Table] Row: ${row['widget']} -> ${row['renderObject']}');
    rows.add(
      TableRow(
        decoration: BoxDecoration(color: bgColor),
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(row['widget']!, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF1B5E20))),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(row['renderObject']!, style: TextStyle(fontSize: 11, color: Color(0xFF4E342E), fontFamily: 'monospace')),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(row['purpose']!, style: TextStyle(fontSize: 11, color: Color(0xFF616161))),
          ),
        ],
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('9. Single-Child Render Object Comparison', Color(0xFF37474F)),
      Text(
        '  All these widgets use RenderObjectWithChildMixin internally.\n  Each has exactly one child slot managed by the mixin.',
        style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
      ),
      SizedBox(height: 8),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Table(
          border: TableBorder.all(color: Color(0xFFBDBDBD), width: 1),
          columnWidths: {
            0: FlexColumnWidth(1.2),
            1: FlexColumnWidth(1.8),
            2: FlexColumnWidth(2.0),
          },
          children: rows,
        ),
      ),
    ],
  );
}

// Section 10: Additional visual demos - FractionallySizedBox, IntrinsicWidth
Widget _buildAdditionalDemos() {
  print('[Additional] Building additional single-child demos');

  print('[Additional] FractionallySizedBox with widthFactor=0.7');
  print('[Additional] IntrinsicWidth wrapping varied-width children');
  print('[Additional] Nested single-child render objects');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('10. Additional Single-Child Demos', Color(0xFF00838F)),
      _buildDemoCard(
        'FractionallySizedBox(widthFactor: 0.7, heightFactor: 0.5)',
        Container(
          height: 100,
          width: double.infinity,
          color: Color(0xFFE0F7FA),
          child: FractionallySizedBox(
            widthFactor: 0.7,
            heightFactor: 0.5,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF00838F),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text('70% x 50%', style: TextStyle(color: Colors.white, fontSize: 14)),
              ),
            ),
          ),
        ),
      ),
      _buildDemoCard(
        'Nested: Opacity > Transform > Padding > DecoratedBox',
        Center(
          child: Opacity(
            opacity: 0.8,
            child: Transform.rotate(
              angle: 0.1,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF00838F), Color(0xFF4DD0E1)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Color(0x4000838F), blurRadius: 10, offset: Offset(2, 4)),
                    ],
                  ),
                  child: SizedBox(
                    width: 200,
                    height: 60,
                    child: Center(
                      child: Text(
                        'Nested RenderObjects',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      _buildDemoCard(
        'Align inside ClipRRect inside Opacity',
        Opacity(
          opacity: 0.9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: 80,
              width: double.infinity,
              color: Color(0xFFB2EBF2),
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFF006064),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text('!', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

// Footer widget
Widget _buildFooter() {
  print('[Footer] Building footer');
  return Container(
    margin: EdgeInsets.all(16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF4A148C), Color(0xFF6A1B9A)],
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Text(
          'RenderObjectWithChildMixin Deep Demo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'All widgets above use single-child render objects.\n'
          'The mixin provides the child getter/setter and manages\n'
          'the parent-child relationship in the render tree.',
          style: TextStyle(color: Color(0xFFCE93D8), fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

// Entry point
dynamic build(BuildContext context) {
  print('=== RenderObjectWithChildMixin Deep Demo ===');
  print('Demonstrating widgets backed by single-child render objects');
  print('RenderObjectWithChildMixin provides exactly one child slot');
  print('');
  print('[Build] Starting render of all sections');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader('RenderObjectWithChildMixin'),
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Deep demo of widgets using single-child render objects.\n'
            'RenderObjectWithChildMixin is a mixin that provides exactly\n'
            'one child slot with getter/setter for the render object.',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242), height: 1.5),
          ),
        ),
        SizedBox(height: 8),

        // Section 1: Padding
        _buildPaddingSection(),
        SizedBox(height: 16),

        // Section 2: Align
        _buildAlignSection(),
        SizedBox(height: 16),

        // Section 3: Transform
        _buildTransformSection(),
        SizedBox(height: 16),

        // Section 4: Opacity
        _buildOpacitySection(),
        SizedBox(height: 16),

        // Section 5: DecoratedBox
        _buildDecoratedBoxSection(),
        SizedBox(height: 16),

        // Section 6: Clip widgets
        _buildClipSection(),
        SizedBox(height: 16),

        // Section 7: Sizing boxes
        _buildSizingSection(),
        SizedBox(height: 16),

        // Section 8: FittedBox
        _buildFittedBoxSection(),
        SizedBox(height: 16),

        // Section 9: Comparison table
        _buildComparisonTable(),
        SizedBox(height: 16),

        // Section 10: Additional demos
        _buildAdditionalDemos(),
        SizedBox(height: 16),

        // Footer
        _buildFooter(),
        SizedBox(height: 32),
      ],
    ),
  );
}
