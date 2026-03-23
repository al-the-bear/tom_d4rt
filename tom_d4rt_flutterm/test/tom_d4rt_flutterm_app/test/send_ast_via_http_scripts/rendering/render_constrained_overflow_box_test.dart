// D4rt deep demo: RenderConstrainedOverflowBox / OverflowBox
// Tests OverflowBox widget which imposes different constraints on its child
// than it receives from its parent, allowing the child to overflow.
// Also demonstrates SizedOverflowBox and ConstrainedBox comparison.

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('[render_constrained_overflow_box_test] build() called');
  print('[render_constrained_overflow_box_test] Building OverflowBox deep demo');

  return SingleChildScrollView(
    child: Container(
      color: Color(0xFF121212),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: 24.0),

          // Section 1: Basic OverflowBox allowing child to overflow parent
          _buildSectionTitle('1. OverflowBox: Child Overflows Parent'),
          _buildOverflowBasicDemo(),
          SizedBox(height: 24.0),

          // Section 2: Different minWidth / maxWidth values
          _buildSectionTitle('2. OverflowBox: minWidth / maxWidth'),
          _buildMinMaxWidthDemo(),
          SizedBox(height: 24.0),

          // Section 3: Different minHeight / maxHeight values
          _buildSectionTitle('3. OverflowBox: minHeight / maxHeight'),
          _buildMinMaxHeightDemo(),
          SizedBox(height: 24.0),

          // Section 4: Different alignment values
          _buildSectionTitle('4. OverflowBox: Alignment Variations'),
          _buildAlignmentDemo(),
          SizedBox(height: 24.0),

          // Section 5: SizedOverflowBox for comparison
          _buildSectionTitle('5. SizedOverflowBox Comparison'),
          _buildSizedOverflowBoxDemo(),
          SizedBox(height: 24.0),

          // Section 6: ConstrainedBox vs OverflowBox
          _buildSectionTitle('6. ConstrainedBox vs OverflowBox'),
          _buildConstrainedVsOverflowDemo(),
          SizedBox(height: 24.0),

          // Section 7: Overflow visualization with colored borders
          _buildSectionTitle('7. Overflow Visualization (Parent vs Child Bounds)'),
          _buildOverflowVisualization(),
          SizedBox(height: 24.0),

          // Section 8: Practical patterns
          _buildSectionTitle('8. Practical Patterns'),
          _buildPracticalPatterns(),
          SizedBox(height: 40.0),
        ],
      ),
    ),
  );
}

// Header with gradient styling
Widget _buildHeader() {
  print('[render_constrained_overflow_box_test] _buildHeader()');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF6A1B9A), Color(0xFFAB47BC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x606A1B9A),
          blurRadius: 12.0,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'RenderConstrainedOverflowBox Demo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'OverflowBox • SizedOverflowBox • ConstrainedBox comparison',
          style: TextStyle(
            color: Color(0xCCFFFFFF),
            fontSize: 13.0,
          ),
        ),
      ],
    ),
  );
}

// Section title with gradient underline
Widget _buildSectionTitle(String title) {
  print('[render_constrained_overflow_box_test] Section: $title');
  return Padding(
    padding: EdgeInsets.only(bottom: 12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Color(0xFFCE93D8),
            fontSize: 17.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4.0),
        Container(
          height: 2.0,
          width: 180.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFAB47BC), Color(0x006A1B9A)],
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper: labeled parent container with clipping to show overflow
Widget _buildParentBox(String label, double width, double height, Widget child) {
  print('[render_constrained_overflow_box_test] _buildParentBox: $label (${width}x$height)');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(color: Color(0xFFBBBBBB), fontSize: 11.0),
      ),
      SizedBox(height: 4.0),
      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF4CAF50), width: 2.0),
          color: Color(0x114CAF50),
        ),
        child: child,
      ),
    ],
  );
}

// Helper: child box used inside overflow demos
Widget _buildChildBox(double width, double height, Color color, String label) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: color.withOpacity(0.3),
      border: Border.all(color: color, width: 1.5),
      borderRadius: BorderRadius.circular(4.0),
    ),
    alignment: Alignment.center,
    child: Text(
      label,
      style: TextStyle(color: Colors.white, fontSize: 10.0),
      textAlign: TextAlign.center,
    ),
  );
}

// Section 1: Basic OverflowBox allowing child to overflow parent
Widget _buildOverflowBasicDemo() {
  print('[render_constrained_overflow_box_test] _buildOverflowBasicDemo()');
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Green border = parent (100x100). Child wants 160x160.',
          style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 12.0),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            _buildParentBox('Without OverflowBox', 100.0, 100.0,
              Container(
                width: 160.0,
                height: 160.0,
                color: Color(0x44FF5722),
                alignment: Alignment.center,
                child: Text('160x160\n(clipped)', style: TextStyle(color: Colors.white, fontSize: 10.0), textAlign: TextAlign.center),
              ),
            ),
            SizedBox(width: 40.0),
            _buildParentBox('With OverflowBox', 100.0, 100.0,
              OverflowBox(
                maxWidth: 160.0,
                maxHeight: 160.0,
                child: Container(
                  width: 160.0,
                  height: 160.0,
                  decoration: BoxDecoration(
                    color: Color(0x44FF5722),
                    border: Border.all(color: Color(0xFFFF5722), width: 1.5),
                  ),
                  alignment: Alignment.center,
                  child: Text('160x160\n(overflows!)', style: TextStyle(color: Colors.white, fontSize: 10.0), textAlign: TextAlign.center),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'OverflowBox removes parent constraint, child can paint outside bounds.',
          style: TextStyle(color: Color(0xFF888888), fontSize: 11.0),
        ),
      ],
    ),
  );
}

// Section 2: Different minWidth / maxWidth values
Widget _buildMinMaxWidthDemo() {
  print('[render_constrained_overflow_box_test] _buildMinMaxWidthDemo()');

  List<Map<String, dynamic>> configs = [
    {'label': 'maxWidth: 200', 'minW': null, 'maxW': 200.0},
    {'label': 'maxWidth: 80', 'minW': null, 'maxW': 80.0},
    {'label': 'minWidth: 150', 'minW': 150.0, 'maxW': null},
    {'label': 'min: 60, max: 180', 'minW': 60.0, 'maxW': 180.0},
  ];

  List<Widget> rows = [];
  for (var cfg in configs) {
    print('[render_constrained_overflow_box_test] minMaxWidth config: ${cfg['label']}');
    rows.add(
      Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Row(
          children: [
            SizedBox(
              width: 130.0,
              child: Text(
                cfg['label'],
                style: TextStyle(color: Color(0xFFBBBBBB), fontSize: 11.0),
              ),
            ),
            Container(
              width: 120.0,
              height: 50.0,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF4CAF50), width: 1.5),
              ),
              child: OverflowBox(
                minWidth: cfg['minW'],
                maxWidth: cfg['maxW'],
                child: Container(
                  color: Color(0x5542A5F5),
                  height: 40.0,
                  alignment: Alignment.center,
                  child: Text(
                    'Child',
                    style: TextStyle(color: Colors.white, fontSize: 10.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Parent is 120px wide (green). OverflowBox overrides width constraints.',
          style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 12.0),
        ),
        SizedBox(height: 10.0),
        ...rows,
      ],
    ),
  );
}

// Section 3: Different minHeight / maxHeight values
Widget _buildMinMaxHeightDemo() {
  print('[render_constrained_overflow_box_test] _buildMinMaxHeightDemo()');

  List<Map<String, dynamic>> configs = [
    {'label': 'maxHeight: 120', 'minH': null, 'maxH': 120.0},
    {'label': 'maxHeight: 30', 'minH': null, 'maxH': 30.0},
    {'label': 'minHeight: 100', 'minH': 100.0, 'maxH': null},
    {'label': 'min: 40, max: 100', 'minH': 40.0, 'maxH': 100.0},
  ];

  List<Widget> rows = [];
  for (var cfg in configs) {
    print('[render_constrained_overflow_box_test] minMaxHeight config: ${cfg['label']}');
    rows.add(
      Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Row(
          children: [
            SizedBox(
              width: 130.0,
              child: Text(
                cfg['label'],
                style: TextStyle(color: Color(0xFFBBBBBB), fontSize: 11.0),
              ),
            ),
            Container(
              width: 80.0,
              height: 60.0,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF4CAF50), width: 1.5),
              ),
              child: OverflowBox(
                minHeight: cfg['minH'],
                maxHeight: cfg['maxH'],
                child: Container(
                  color: Color(0x55EF5350),
                  width: 70.0,
                  alignment: Alignment.center,
                  child: Text(
                    'Child',
                    style: TextStyle(color: Colors.white, fontSize: 10.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Parent is 60px tall (green). OverflowBox overrides height constraints.',
          style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 12.0),
        ),
        SizedBox(height: 10.0),
        ...rows,
      ],
    ),
  );
}

// Section 4: Different alignment values
Widget _buildAlignmentDemo() {
  print('[render_constrained_overflow_box_test] _buildAlignmentDemo()');

  List<Map<String, dynamic>> alignments = [
    {'label': 'topLeft', 'align': Alignment.topLeft},
    {'label': 'topCenter', 'align': Alignment.topCenter},
    {'label': 'topRight', 'align': Alignment.topRight},
    {'label': 'centerLeft', 'align': Alignment.centerLeft},
    {'label': 'center', 'align': Alignment.center},
    {'label': 'centerRight', 'align': Alignment.centerRight},
    {'label': 'bottomLeft', 'align': Alignment.bottomLeft},
    {'label': 'bottomCenter', 'align': Alignment.bottomCenter},
    {'label': 'bottomRight', 'align': Alignment.bottomRight},
  ];

  List<Widget> items = [];
  for (var a in alignments) {
    print('[render_constrained_overflow_box_test] alignment: ${a['label']}');
    items.add(
      Column(
        children: [
          Text(
            a['label'],
            style: TextStyle(color: Color(0xFFBBBBBB), fontSize: 9.0),
          ),
          SizedBox(height: 3.0),
          Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF4CAF50), width: 1.5),
              color: Color(0x114CAF50),
            ),
            child: OverflowBox(
              alignment: a['align'],
              maxWidth: 50.0,
              maxHeight: 50.0,
              child: Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Color(0x55FF9800),
                  border: Border.all(color: Color(0xFFFF9800), width: 1.0),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                alignment: Alignment.center,
                child: Text(
                  '50x50',
                  style: TextStyle(color: Colors.white, fontSize: 8.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Each parent is 80x80 (green). Child is 50x50 (orange). Alignment controls position.',
          style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 12.0),
        ),
        SizedBox(height: 10.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: items,
        ),
      ],
    ),
  );
}

// Section 5: SizedOverflowBox for comparison
Widget _buildSizedOverflowBoxDemo() {
  print('[render_constrained_overflow_box_test] _buildSizedOverflowBoxDemo()');

  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SizedOverflowBox sizes itself to a given size, but passes original constraints to child.',
          style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 12.0),
        ),
        SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedOverflowBox example 1
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SizedOverflowBox\nsize: 80x80',
                  style: TextStyle(color: Color(0xFFBBBBBB), fontSize: 11.0),
                ),
                SizedBox(height: 4.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF2196F3), width: 2.0),
                  ),
                  child: SizedOverflowBox(
                    size: Size(80.0, 80.0),
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 130.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Color(0x55FF9800),
                        border: Border.all(color: Color(0xFFFF9800), width: 1.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '130x50 child',
                        style: TextStyle(color: Colors.white, fontSize: 10.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 32.0),
            // SizedOverflowBox example 2
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SizedOverflowBox\nsize: 60x100',
                  style: TextStyle(color: Color(0xFFBBBBBB), fontSize: 11.0),
                ),
                SizedBox(height: 4.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF2196F3), width: 2.0),
                  ),
                  child: SizedOverflowBox(
                    size: Size(60.0, 100.0),
                    alignment: Alignment.center,
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: Color(0x55E91E63),
                        border: Border.all(color: Color(0xFFE91E63), width: 1.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '100x100\ncircle',
                        style: TextStyle(color: Colors.white, fontSize: 10.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Blue border = SizedOverflowBox reported size. Child paints outside.',
          style: TextStyle(color: Color(0xFF888888), fontSize: 11.0),
        ),
      ],
    ),
  );
}

// Section 6: ConstrainedBox vs OverflowBox behavior comparison
Widget _buildConstrainedVsOverflowDemo() {
  print('[render_constrained_overflow_box_test] _buildConstrainedVsOverflowDemo()');

  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ConstrainedBox tightens constraints. OverflowBox loosens them.',
          style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 12.0),
        ),
        SizedBox(height: 12.0),

        // ConstrainedBox example
        Text(
          'ConstrainedBox(maxWidth: 100) inside 200px parent:',
          style: TextStyle(color: Color(0xFFBBBBBB), fontSize: 11.0),
        ),
        SizedBox(height: 4.0),
        Container(
          width: 200.0,
          height: 60.0,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF4CAF50), width: 1.5),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 100.0),
            child: Container(
              color: Color(0x5542A5F5),
              alignment: Alignment.center,
              child: Text(
                'Constrained\nmax 100w',
                style: TextStyle(color: Colors.white, fontSize: 10.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        SizedBox(height: 16.0),

        // OverflowBox that loosens constraints
        Text(
          'OverflowBox(maxWidth: 300) inside 200px parent:',
          style: TextStyle(color: Color(0xFFBBBBBB), fontSize: 11.0),
        ),
        SizedBox(height: 4.0),
        Container(
          width: 200.0,
          height: 60.0,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF4CAF50), width: 1.5),
          ),
          child: OverflowBox(
            maxWidth: 300.0,
            child: Container(
              color: Color(0x55FF5722),
              alignment: Alignment.center,
              child: Text(
                'Overflow\nmax 300w',
                style: TextStyle(color: Colors.white, fontSize: 10.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        SizedBox(height: 16.0),

        // Both combined
        Text(
          'ConstrainedBox(min:80) + OverflowBox(max:250):',
          style: TextStyle(color: Color(0xFFBBBBBB), fontSize: 11.0),
        ),
        SizedBox(height: 4.0),
        Container(
          width: 200.0,
          height: 60.0,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF4CAF50), width: 1.5),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 80.0),
            child: OverflowBox(
              maxWidth: 250.0,
              child: Container(
                color: Color(0x559C27B0),
                alignment: Alignment.center,
                child: Text(
                  'Combined\n250w overflow',
                  style: TextStyle(color: Colors.white, fontSize: 10.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'ConstrainedBox cannot exceed parent. OverflowBox can.',
          style: TextStyle(color: Color(0xFF888888), fontSize: 11.0),
        ),
      ],
    ),
  );
}

// Section 7: Overflow visualization with colored borders
Widget _buildOverflowVisualization() {
  print('[render_constrained_overflow_box_test] _buildOverflowVisualization()');

  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Green = parent bounds, Red = child bounds (overflowing)',
          style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 12.0),
        ),
        SizedBox(height: 12.0),

        // Visualization 1: horizontal overflow
        Text(
          'Horizontal overflow (child 220w, parent 140w):',
          style: TextStyle(color: Color(0xFFBBBBBB), fontSize: 11.0),
        ),
        SizedBox(height: 4.0),
        Container(
          width: 140.0,
          height: 70.0,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF4CAF50), width: 3.0),
            color: Color(0x114CAF50),
          ),
          child: OverflowBox(
            maxWidth: 220.0,
            alignment: Alignment.center,
            child: Container(
              width: 220.0,
              height: 50.0,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFEF5350), width: 2.0),
                color: Color(0x22EF5350),
                borderRadius: BorderRadius.circular(6.0),
              ),
              alignment: Alignment.center,
              child: Text(
                '220 x 50 (overflows horizontally)',
                style: TextStyle(color: Colors.white, fontSize: 9.0),
              ),
            ),
          ),
        ),
        SizedBox(height: 20.0),

        // Visualization 2: vertical overflow
        Text(
          'Vertical overflow (child 140h, parent 70h):',
          style: TextStyle(color: Color(0xFFBBBBBB), fontSize: 11.0),
        ),
        SizedBox(height: 4.0),
        Container(
          width: 160.0,
          height: 70.0,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF4CAF50), width: 3.0),
            color: Color(0x114CAF50),
          ),
          child: OverflowBox(
            maxHeight: 140.0,
            alignment: Alignment.center,
            child: Container(
              width: 120.0,
              height: 140.0,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFEF5350), width: 2.0),
                color: Color(0x22EF5350),
                borderRadius: BorderRadius.circular(6.0),
              ),
              alignment: Alignment.center,
              child: Text(
                '120 x 140\n(overflows\nvertically)',
                style: TextStyle(color: Colors.white, fontSize: 9.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        SizedBox(height: 20.0),

        // Visualization 3: both axes overflow
        Text(
          'Both axes overflow (child 200x120, parent 120x60):',
          style: TextStyle(color: Color(0xFFBBBBBB), fontSize: 11.0),
        ),
        SizedBox(height: 4.0),
        Container(
          width: 120.0,
          height: 60.0,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF4CAF50), width: 3.0),
            color: Color(0x114CAF50),
          ),
          child: OverflowBox(
            maxWidth: 200.0,
            maxHeight: 120.0,
            alignment: Alignment.center,
            child: Container(
              width: 200.0,
              height: 120.0,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFEF5350), width: 2.0),
                color: Color(0x22EF5350),
                borderRadius: BorderRadius.circular(6.0),
              ),
              alignment: Alignment.center,
              child: Text(
                '200 x 120\n(both axes overflow)',
                style: TextStyle(color: Colors.white, fontSize: 9.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        SizedBox(height: 12.0),

        // Nested overflow visualization layers
        Text(
          'Layered: grandparent (blue) > parent (green) > child (red):',
          style: TextStyle(color: Color(0xFFBBBBBB), fontSize: 11.0),
        ),
        SizedBox(height: 4.0),
        Container(
          width: 200.0,
          height: 100.0,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF2196F3), width: 3.0),
            color: Color(0x112196F3),
          ),
          alignment: Alignment.center,
          child: Container(
            width: 130.0,
            height: 70.0,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF4CAF50), width: 2.0),
              color: Color(0x114CAF50),
            ),
            child: OverflowBox(
              maxWidth: 180.0,
              maxHeight: 90.0,
              alignment: Alignment.center,
              child: Container(
                width: 180.0,
                height: 90.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFEF5350), width: 2.0),
                  color: Color(0x22EF5350),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child: Text(
                  '180x90 child\noverflows green parent\nstays in blue grandparent',
                  style: TextStyle(color: Colors.white, fontSize: 9.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// Section 8: Practical patterns
Widget _buildPracticalPatterns() {
  print('[render_constrained_overflow_box_test] _buildPracticalPatterns()');

  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tooltip-like overflow pattern
        Text(
          'Pattern A: Tooltip that overflows its trigger',
          style: TextStyle(color: Color(0xFFBBBBBB), fontSize: 12.0, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8.0),
        Row(
          children: [
            SizedBox(width: 40.0),
            Container(
              width: 60.0,
              height: 30.0,
              decoration: BoxDecoration(
                color: Color(0xFF424242),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: OverflowBox(
                maxWidth: 160.0,
                maxHeight: 80.0,
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 60.0,
                      height: 30.0,
                      alignment: Alignment.center,
                      child: Text(
                        'Hover me',
                        style: TextStyle(color: Colors.white, fontSize: 10.0),
                      ),
                    ),
                    Container(
                      width: 150.0,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF616161),
                        borderRadius: BorderRadius.circular(6.0),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x40000000),
                            blurRadius: 8.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        'This tooltip content overflows the trigger button width',
                        style: TextStyle(color: Colors.white, fontSize: 10.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 60.0),

        // Dropdown menu overflow pattern
        Text(
          'Pattern B: Dropdown menu that overflows container',
          style: TextStyle(color: Color(0xFFBBBBBB), fontSize: 12.0, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8.0),
        Row(
          children: [
            Container(
              width: 100.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: Color(0xFF37474F),
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: Color(0xFF546E7A), width: 1.0),
              ),
              child: OverflowBox(
                maxHeight: 180.0,
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 100.0,
                      height: 36.0,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Select...',
                            style: TextStyle(color: Colors.white, fontSize: 11.0),
                          ),
                          SizedBox(width: 4.0),
                          Icon(Icons.arrow_drop_down, color: Colors.white, size: 16.0),
                        ],
                      ),
                    ),
                    Container(
                      width: 100.0,
                      decoration: BoxDecoration(
                        color: Color(0xFF455A64),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(4.0),
                          bottomRight: Radius.circular(4.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x60000000),
                            blurRadius: 6.0,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildDropdownItem('Option 1'),
                          _buildDropdownItem('Option 2'),
                          _buildDropdownItem('Option 3'),
                          _buildDropdownItem('Option 4'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 80.0),

        // Badge overflow pattern
        Text(
          'Pattern C: Badge overflowing icon container',
          style: TextStyle(color: Color(0xFFBBBBBB), fontSize: 12.0, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8.0),
        Row(
          children: [
            _buildBadgeIcon(Icons.mail, '5'),
            SizedBox(width: 24.0),
            _buildBadgeIcon(Icons.notifications, '12'),
            SizedBox(width: 24.0),
            _buildBadgeIcon(Icons.shopping_cart, '99+'),
          ],
        ),
        SizedBox(height: 20.0),

        // Decorative overflow
        Text(
          'Pattern D: Decorative element overflowing card',
          style: TextStyle(color: Color(0xFFBBBBBB), fontSize: 12.0, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8.0),
        Container(
          width: 220.0,
          height: 80.0,
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -10.0,
                top: -10.0,
                child: OverflowBox(
                  maxWidth: 80.0,
                  maxHeight: 80.0,
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Color(0x339C27B0),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Feature Card',
                      style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Decorative circle overflows edge',
                      style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 11.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper for dropdown items
Widget _buildDropdownItem(String text) {
  print('[render_constrained_overflow_box_test] dropdown item: $text');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
    child: Text(
      text,
      style: TextStyle(color: Colors.white, fontSize: 11.0),
    ),
  );
}

// Helper for badge icons
Widget _buildBadgeIcon(IconData icon, String count) {
  print('[render_constrained_overflow_box_test] badge icon: $count');
  return Container(
    width: 40.0,
    height: 40.0,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: Color(0xFF37474F),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: Colors.white, size: 22.0),
        ),
        Positioned(
          right: -6.0,
          top: -6.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: Color(0xFFE53935),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              count,
              style: TextStyle(color: Colors.white, fontSize: 9.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    ),
  );
}
