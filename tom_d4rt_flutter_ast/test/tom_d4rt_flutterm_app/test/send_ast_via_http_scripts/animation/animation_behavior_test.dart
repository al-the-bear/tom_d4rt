// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests AnimationBehavior from animation
// Deep Demo: Visual demonstration of AnimationBehavior enum and its effects
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimationBehavior Deep Demo executing');

  // ============================================================
  // SECTION 1: AnimationBehavior Enum Values Overview
  // ============================================================
  print('=== Section 1: AnimationBehavior Enum Overview ===');

  // Display all AnimationBehavior values with visual cards
  final behaviorCards = <Widget>[];
  for (final behavior in AnimationBehavior.values) {
    print('AnimationBehavior.${behavior.name} - index: ${behavior.index}');
    behaviorCards.add(
      Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: behavior == AnimationBehavior.normal
              ? Colors.blue.shade100
              : Colors.orange.shade100,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: behavior == AnimationBehavior.normal
                ? Colors.blue
                : Colors.orange,
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4.0,
              offset: Offset(2.0, 2.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              behavior == AnimationBehavior.normal
                  ? Icons.animation
                  : Icons.lock_clock,
              size: 48.0,
              color: behavior == AnimationBehavior.normal
                  ? Colors.blue
                  : Colors.orange,
            ),
            SizedBox(height: 8.0),
            Text(
              'AnimationBehavior.${behavior.name}',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: behavior == AnimationBehavior.normal
                    ? Colors.blue.shade900
                    : Colors.orange.shade900,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'Index: ${behavior.index}',
              style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
            ),
            SizedBox(height: 8.0),
            Text(
              behavior == AnimationBehavior.normal
                  ? 'Respects accessibility\nsettings for animations'
                  : 'Preserves animations\nregardless of settings',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${behaviorCards.length} behavior cards');

  // ============================================================
  // SECTION 2: Visual Comparison Panel
  // ============================================================
  print('=== Section 2: Visual Comparison Panel ===');

  final comparisonPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.purple.shade50, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.purple.shade200, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'AnimationBehavior Comparison',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.purple.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Normal behavior visual
            Container(
              width: 140.0,
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.blue, width: 1.5),
              ),
              child: Column(
                children: [
                  Icon(Icons.accessibility_new, size: 36.0, color: Colors.blue),
                  SizedBox(height: 8.0),
                  Text(
                    'NORMAL',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'System accessible',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    height: 4.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                ],
              ),
            ),
            // VS indicator
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                'VS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            // Preserve behavior visual
            Container(
              width: 140.0,
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.orange, width: 1.5),
              ),
              child: Column(
                children: [
                  Icon(Icons.movie_filter, size: 36.0, color: Colors.orange),
                  SizedBox(height: 8.0),
                  Text(
                    'PRESERVE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade900,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Always animate',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.orange.shade700,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    height: 4.0,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
  print('Created comparison panel');

  // ============================================================
  // SECTION 3: Use Case Scenarios
  // ============================================================
  print('=== Section 3: Use Case Scenarios ===');

  final scenarios = [
    {
      'title': 'Loading Spinners',
      'behavior': AnimationBehavior.preserve,
      'icon': Icons.refresh,
      'description': 'Essential feedback - always animate',
      'color': Colors.green,
    },
    {
      'title': 'Page Transitions',
      'behavior': AnimationBehavior.normal,
      'icon': Icons.swap_horiz,
      'description': 'Decorative - respect user settings',
      'color': Colors.blue,
    },
    {
      'title': 'Progress Indicators',
      'behavior': AnimationBehavior.preserve,
      'icon': Icons.hourglass_empty,
      'description': 'User needs to see progress',
      'color': Colors.purple,
    },
    {
      'title': 'Hero Animations',
      'behavior': AnimationBehavior.normal,
      'icon': Icons.zoom_out_map,
      'description': 'Visual polish - not critical',
      'color': Colors.teal,
    },
    {
      'title': 'Error Shake',
      'behavior': AnimationBehavior.preserve,
      'icon': Icons.error_outline,
      'description': 'Important feedback - always show',
      'color': Colors.red,
    },
    {
      'title': 'List Item Animations',
      'behavior': AnimationBehavior.normal,
      'icon': Icons.list_alt,
      'description': 'Enhancement - optional',
      'color': Colors.indigo,
    },
  ];

  final scenarioWidgets = <Widget>[];
  for (final scenario in scenarios) {
    final isPreserve = scenario['behavior'] == AnimationBehavior.preserve;
    final color = scenario['color'] as Color;

    scenarioWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                scenario['icon'] as IconData,
                color: color,
                size: 28.0,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    scenario['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: color.withValues(alpha: 0.9),
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    scenario['description'] as String,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: isPreserve ? Colors.orange : Colors.blue,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                isPreserve ? 'PRESERVE' : 'NORMAL',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${scenarioWidgets.length} scenario widgets');

  // ============================================================
  // SECTION 4: AnimationBehavior Decision Tree
  // ============================================================
  print('=== Section 4: Decision Tree ===');

  final decisionTree = Container(
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
          'When to Use Each Behavior',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 16.0),
        // Question box
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade100,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.amber, width: 1.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.help_outline, color: Colors.amber.shade800),
              SizedBox(width: 8.0),
              Text(
                'Is the animation essential\nfor user understanding?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade900,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        // Arrow down
        Icon(Icons.arrow_downward, color: Colors.grey),
        SizedBox(height: 12.0),
        // Yes/No branches
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Yes branch
            Container(
              width: 130.0,
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.orange, width: 1.5),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      'YES',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Icon(Icons.lock_clock, color: Colors.orange, size: 32.0),
                  SizedBox(height: 4.0),
                  Text(
                    'Use PRESERVE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            // No branch
            Container(
              width: 130.0,
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.blue, width: 1.5),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      'NO',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Icon(Icons.accessibility_new, color: Colors.blue, size: 32.0),
                  SizedBox(height: 4.0),
                  Text(
                    'Use NORMAL',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
  print('Created decision tree widget');

  // ============================================================
  // SECTION 5: Code Examples Visual
  // ============================================================
  print('=== Section 5: Code Examples ===');

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
            Icon(Icons.code, color: Colors.green.shade400, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Code Examples',
              style: TextStyle(
                color: Colors.green.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        // Example 1
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            '// AnimationController with normal behavior\n'
            'AnimationController(\n'
            '  vsync: this,\n'
            '  duration: Duration(milliseconds: 300),\n'
            ');  // Uses AnimationBehavior.normal by default',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.green.shade300,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        // Example 2
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            '// AnimationController with preserve behavior\n'
            'AnimationController(\n'
            '  vsync: this,\n'
            '  duration: Duration(milliseconds: 300),\n'
            '  animationBehavior: AnimationBehavior.preserve,\n'
            ');  // Animation always plays',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.orange.shade300,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created code examples widget');

  // ============================================================
  // SECTION 6: Summary Statistics
  // ============================================================
  print('=== Section 6: Summary Statistics ===');

  final totalValues = AnimationBehavior.values.length;

  final summaryStats = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade100, Colors.cyan.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.teal, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'AnimationBehavior Summary',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStatCard(
              'Total Values',
              '$totalValues',
              Icons.format_list_numbered,
              Colors.purple,
            ),
            _buildStatCard('Default', 'normal', Icons.settings, Colors.blue),
            _buildStatCard(
              'Alternative',
              'preserve',
              Icons.movie,
              Colors.orange,
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              Text(
                'Accessibility Impact',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade800,
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 16.0),
                  SizedBox(width: 4.0),
                  Text(
                    'NORMAL respects system animation settings',
                    style: TextStyle(fontSize: 11.0),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.warning, color: Colors.orange, size: 16.0),
                  SizedBox(width: 4.0),
                  Text(
                    'PRESERVE ignores "reduce motion" preferences',
                    style: TextStyle(fontSize: 11.0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created summary statistics widget');

  print('AnimationBehavior Deep Demo completed successfully');

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
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.indigo],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: [
              Icon(Icons.animation, size: 48.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                'AnimationBehavior',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Deep Demo - Flutter Animation Library',
                style: TextStyle(fontSize: 14.0, color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),

        // Section 1: Enum values
        Text(
          '1. Enum Values',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: behaviorCards,
        ),
        SizedBox(height: 24.0),

        // Section 2: Comparison
        Text(
          '2. Comparison',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        comparisonPanel,
        SizedBox(height: 24.0),

        // Section 3: Use Cases
        Text(
          '3. Use Case Scenarios',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        ...scenarioWidgets,
        SizedBox(height: 24.0),

        // Section 4: Decision Tree
        Text(
          '4. Decision Guide',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        decisionTree,
        SizedBox(height: 24.0),

        // Section 5: Code Examples
        Text(
          '5. Code Examples',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        codeExamples,
        SizedBox(height: 24.0),

        // Section 6: Summary
        Text(
          '6. Summary',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        summaryStats,
      ],
    ),
  );
}

// Helper function to build stat cards
Widget _buildStatCard(String label, String value, IconData icon, Color color) {
  return Container(
    width: 90.0,
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 24.0),
        SizedBox(height: 4.0),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 14.0,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 9.0, color: Colors.grey.shade600),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
