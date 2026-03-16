// D4rt test script: Tests AnimationStatus enum, AnimationMax, AnimationMin,
// AnimationMean from animation
// Deep Demo: Visual demonstration of animation status states and comparison operators
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimationStatus Deep Demo executing');

  // ============================================================
  // SECTION 1: AnimationStatus Enum Overview
  // ============================================================
  print('=== Section 1: AnimationStatus Overview ===');

  final statusCards = <Widget>[];
  final statusData = [
    {
      'status': AnimationStatus.dismissed,
      'icon': Icons.stop_circle_outlined,
      'color': Colors.grey,
      'description': 'Animation at start',
      'value': 0.0,
    },
    {
      'status': AnimationStatus.forward,
      'icon': Icons.play_arrow,
      'color': Colors.green,
      'description': 'Moving to end',
      'value': 0.5,
    },
    {
      'status': AnimationStatus.reverse,
      'icon': Icons.replay,
      'color': Colors.orange,
      'description': 'Moving to start',
      'value': 0.5,
    },
    {
      'status': AnimationStatus.completed,
      'icon': Icons.check_circle,
      'color': Colors.blue,
      'description': 'Animation at end',
      'value': 1.0,
    },
  ];

  for (final data in statusData) {
    final status = data['status'] as AnimationStatus;
    final color = data['color'] as Color;
    print('AnimationStatus.${status.name} - index: ${status.index}');
    
    statusCards.add(
      Container(
        width: 150.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.1), color.withOpacity(0.2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color, width: 2.0),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(data['icon'] as IconData, size: 48.0, color: color),
            SizedBox(height: 8.0),
            Text(
              status.name.toUpperCase(),
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'Index: ${status.index}',
              style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                data['description'] as String,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10.0, color: color),
              ),
            ),
            SizedBox(height: 12.0),
            // Progress bar visualization
            Container(
              height: 8.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: data['value'] as double,
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
  print('Created ${statusCards.length} status cards');

  // ============================================================
  // SECTION 2: AnimationStatus Properties Matrix
  // ============================================================
  print('=== Section 2: Status Properties Matrix ===');

  final propertiesMatrix = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade400, width: 1.0),
    ),
    child: Column(
      children: [
        Text(
          'AnimationStatus Properties',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 16.0),
        // Header row
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.indigo.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              _buildHeaderCell('Status', 80.0),
              _buildHeaderCell('isDismissed', 80.0),
              _buildHeaderCell('isCompleted', 80.0),
              _buildHeaderCell('isAnimating', 80.0),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        // Data rows
        for (final status in AnimationStatus.values)
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
              ),
            ),
            child: Row(
              children: [
                _buildDataCell(status.name, 80.0, Colors.black87),
                _buildBoolCell(status.isDismissed, 80.0),
                _buildBoolCell(status.isCompleted, 80.0),
                _buildBoolCell(status.isAnimating, 80.0),
              ],
            ),
          ),
      ],
    ),
  );
  print('Created properties matrix');

  // ============================================================
  // SECTION 3: AnimationStatus State Machine Visualization
  // ============================================================
  print('=== Section 3: State Machine ===');

  final stateMachine = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.purple.shade50, Colors.blue.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.purple.shade200, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'Animation State Machine',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.purple.shade900,
          ),
        ),
        SizedBox(height: 24.0),
        // State machine visualization
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Dismissed state
            _buildStateNode('DISMISSED', Colors.grey, Icons.stop_circle_outlined),
            SizedBox(width: 12.0),
            // Forward arrow
            Column(
              children: [
                Icon(Icons.arrow_forward, color: Colors.green, size: 28.0),
                Text('forward()', style: TextStyle(fontSize: 10.0, color: Colors.green)),
              ],
            ),
            SizedBox(width: 12.0),
            // Forward state
            _buildStateNode('FORWARD', Colors.green, Icons.play_arrow),
          ],
        ),
        SizedBox(height: 16.0),
        // Vertical connections
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 80.0),
            Icon(Icons.swap_vert, color: Colors.orange, size: 28.0),
            SizedBox(width: 60.0),
            Icon(Icons.arrow_downward, color: Colors.blue, size: 28.0),
            SizedBox(width: 60.0),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Reverse state
            _buildStateNode('REVERSE', Colors.orange, Icons.replay),
            SizedBox(width: 12.0),
            // Back arrow
            Column(
              children: [
                Icon(Icons.arrow_back, color: Colors.red, size: 28.0),
                Text('reverse()', style: TextStyle(fontSize: 10.0, color: Colors.red)),
              ],
            ),
            SizedBox(width: 12.0),
            // Completed state
            _buildStateNode('COMPLETED', Colors.blue, Icons.check_circle),
          ],
        ),
      ],
    ),
  );
  print('Created state machine visualization');

  // ============================================================
  // SECTION 4: AnimationMax Visual Demonstration
  // ============================================================
  print('=== Section 4: AnimationMax ===');

  // Create various AnimationMax examples
  final maxExamples = [
    {'v1': 0.3, 'v2': 0.7},
    {'v1': 0.9, 'v2': 0.1},
    {'v1': 0.5, 'v2': 0.5},
    {'v1': 0.0, 'v2': 1.0},
    {'v1': 0.25, 'v2': 0.75},
  ];

  final maxWidgets = <Widget>[];
  for (final ex in maxExamples) {
    final v1 = ex['v1'] as double;
    final v2 = ex['v2'] as double;
    final animMax = AnimationMax<double>(
      AlwaysStoppedAnimation<double>(v1),
      AlwaysStoppedAnimation<double>(v2),
    );
    print('AnimationMax($v1, $v2) = ${animMax.value}');
    
    maxWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.green.shade300, width: 1.5),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAnimValueBar('Value 1', v1, Colors.blue),
                _buildAnimValueBar('Value 2', v2, Colors.orange),
                _buildAnimValueBar('MAX', animMax.value, Colors.green),
              ],
            ),
            SizedBox(height: 12.0),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                'AnimationMax($v1, $v2) = ${animMax.value}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: Colors.green.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${maxWidgets.length} AnimationMax demos');

  // ============================================================
  // SECTION 5: AnimationMin Visual Demonstration
  // ============================================================
  print('=== Section 5: AnimationMin ===');

  final minWidgets = <Widget>[];
  for (final ex in maxExamples) {
    final v1 = ex['v1'] as double;
    final v2 = ex['v2'] as double;
    final animMin = AnimationMin<double>(
      AlwaysStoppedAnimation<double>(v1),
      AlwaysStoppedAnimation<double>(v2),
    );
    print('AnimationMin($v1, $v2) = ${animMin.value}');
    
    minWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.red.shade300, width: 1.5),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAnimValueBar('Value 1', v1, Colors.blue),
                _buildAnimValueBar('Value 2', v2, Colors.orange),
                _buildAnimValueBar('MIN', animMin.value, Colors.red),
              ],
            ),
            SizedBox(height: 12.0),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.red.shade100,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                'AnimationMin($v1, $v2) = ${animMin.value}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: Colors.red.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${minWidgets.length} AnimationMin demos');

  // ============================================================
  // SECTION 6: AnimationMean Visual Demonstration
  // ============================================================
  print('=== Section 6: AnimationMean ===');

  final meanExamples = [
    {'left': 0.2, 'right': 0.8},
    {'left': 0.0, 'right': 1.0},
    {'left': 0.4, 'right': 0.4},
    {'left': 0.1, 'right': 0.9},
    {'left': 0.7, 'right': 0.3},
  ];

  final meanWidgets = <Widget>[];
  for (final ex in meanExamples) {
    final left = ex['left'] as double;
    final right = ex['right'] as double;
    final animMean = AnimationMean(
      left: AlwaysStoppedAnimation<double>(left),
      right: AlwaysStoppedAnimation<double>(right),
    );
    print('AnimationMean($left, $right) = ${animMean.value}');
    
    meanWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.purple.shade50,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.purple.shade300, width: 1.5),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAnimValueBar('Left', left, Colors.blue),
                _buildAnimValueBar('Right', right, Colors.orange),
                _buildAnimValueBar('MEAN', animMean.value, Colors.purple),
              ],
            ),
            SizedBox(height: 12.0),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.purple.shade100,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                'AnimationMean($left, $right) = ${animMean.value.toStringAsFixed(2)}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: Colors.purple.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${meanWidgets.length} AnimationMean demos');

  // ============================================================
  // SECTION 7: Comparison Overview
  // ============================================================
  print('=== Section 7: Comparison Overview ===');

  final comparisonOverview = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade100, Colors.orange.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.amber, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'Animation Comparison Classes',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.amber.shade900,
          ),
        ),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildComparisonCard(
              'AnimationMax',
              'max(a, b)',
              Icons.arrow_upward,
              Colors.green,
            ),
            _buildComparisonCard(
              'AnimationMin',
              'min(a, b)',
              Icons.arrow_downward,
              Colors.red,
            ),
            _buildComparisonCard(
              'AnimationMean',
              '(a + b) / 2',
              Icons.linear_scale,
              Colors.purple,
            ),
          ],
        ),
      ],
    ),
  );
  print('Created comparison overview');

  // ============================================================
  // SECTION 8: Code Examples
  // ============================================================
  print('=== Section 8: Code Examples ===');

  final codeExamples = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade400, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Usage Examples',
              style: TextStyle(
                color: Colors.cyan.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        _buildCodeBlock(
          '// Check animation status\n'
          'if (status.isAnimating) {\n'
          '  // Forward or reverse\n'
          '} else if (status.isCompleted) {\n'
          '  // At end position\n'
          '} else if (status.isDismissed) {\n'
          '  // At start position\n'
          '}',
          Colors.blue.shade300,
        ),
        SizedBox(height: 12.0),
        _buildCodeBlock(
          '// Combine animations\n'
          'final combined = AnimationMax(\n'
          '  fadeAnimation,\n'
          '  slideAnimation,\n'
          ');',
          Colors.green.shade300,
        ),
        SizedBox(height: 12.0),
        _buildCodeBlock(
          '// Create smooth blend\n'
          'final blend = AnimationMean(\n'
          '  left: scaleIn,\n'
          '  right: scaleOut,\n'
          ');',
          Colors.purple.shade300,
        ),
      ],
    ),
  );
  print('Created code examples');

  print('AnimationStatus Deep Demo completed successfully');

  // ============================================================
  // Return complete visual layout
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: [
              Icon(Icons.play_circle_filled, size: 56.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                'AnimationStatus',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Status, Max, Min & Mean',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0),
        
        // Section 1: Status Cards
        Text(
          '1. AnimationStatus Values',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: statusCards,
        ),
        SizedBox(height: 32.0),
        
        // Section 2: Properties Matrix
        Text(
          '2. Status Properties',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        propertiesMatrix,
        SizedBox(height: 32.0),
        
        // Section 3: State Machine
        Text(
          '3. State Transitions',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        stateMachine,
        SizedBox(height: 32.0),
        
        // Section 7: Comparison Overview (moved up for context)
        Text(
          '4. Animation Comparison',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        comparisonOverview,
        SizedBox(height: 32.0),
        
        // Section 4: AnimationMax
        Text(
          '5. AnimationMax Examples',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        ...maxWidgets.take(3),
        SizedBox(height: 32.0),
        
        // Section 5: AnimationMin
        Text(
          '6. AnimationMin Examples',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        ...minWidgets.take(3),
        SizedBox(height: 32.0),
        
        // Section 6: AnimationMean
        Text(
          '7. AnimationMean Examples',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        ...meanWidgets.take(3),
        SizedBox(height: 32.0),
        
        // Section 8: Code Examples
        Text(
          '8. Code Examples',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        codeExamples,
      ],
    ),
  );
}

// Helper: Build header cell for matrix
Widget _buildHeaderCell(String text, double width) {
  return Container(
    width: width,
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 11.0,
        color: Colors.indigo.shade900,
      ),
    ),
  );
}

// Helper: Build data cell for matrix
Widget _buildDataCell(String text, double width, Color color) {
  return Container(
    width: width,
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 11.0, color: color),
    ),
  );
}

// Helper: Build boolean indicator cell
Widget _buildBoolCell(bool value, double width) {
  return Container(
    width: width,
    child: Icon(
      value ? Icons.check_circle : Icons.cancel,
      color: value ? Colors.green : Colors.red.shade300,
      size: 18.0,
    ),
  );
}

// Helper: Build state node for state machine
Widget _buildStateNode(String label, Color color, IconData icon) {
  return Container(
    width: 80.0,
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: color.withOpacity(0.2),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color, width: 2.0),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 24.0),
        SizedBox(height: 4.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 9.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

// Helper: Build animation value bar
Widget _buildAnimValueBar(String label, double value, Color color) {
  return Container(
    width: 80.0,
    child: Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 4.0),
        Container(
          height: 60.0,
          width: 24.0,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60.0 * value,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          value.toStringAsFixed(2),
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

// Helper: Build comparison card
Widget _buildComparisonCard(String title, String formula, IconData icon, Color color) {
  return Container(
    width: 100.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withOpacity(0.5), width: 1.5),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 32.0),
        SizedBox(height: 8.0),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11.0,
            color: color,
          ),
        ),
        SizedBox(height: 4.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            formula,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 9.0,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper: Build code block
Widget _buildCodeBlock(String code, Color textColor) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: textColor,
      ),
    ),
  );
}
