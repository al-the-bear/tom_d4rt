// ignore_for_file: unused_local_variable, unused_element, avoid_print
// ignore_for_file: unnecessary_null_comparison, prefer_function_declarations_over_variables
// ignore_for_file: unnecessary_brace_in_string_interps, deprecated_member_use

import 'package:flutter/material.dart';

// ============================================================================
// DebugOverflowIndicatorMixin Demo
// ============================================================================
// 
// This script demonstrates the DebugOverflowIndicatorMixin visually by
// creating actual overflow scenarios. The mixin paints distinctive yellow
// and black stripes when content exceeds container bounds.

dynamic build(BuildContext context) {
  print('DebugOverflowIndicatorMixin Demo');
  print('=' * 50);
  print('');
  print('Demonstrating overflow indicator behavior:');
  print('- Yellow/black stripes appear when content overflows');
  print('- Only visible in debug mode');
  print('- Helps identify layout issues during development');
  print('');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('DebugOverflowIndicatorMixin Demo'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Introduction
            _buildSectionHeader('What is DebugOverflowIndicatorMixin?'),
            _buildInfoCard(
              'A mixin class for RenderObjects that paints visual overflow '
              'indicators during debug mode. When content exceeds available '
              'space, Flutter displays distinctive yellow and black diagonal '
              'stripes to alert developers.',
            ),
            SizedBox(height: 16),

            // Section 2: Hazard Pattern Explanation
            _buildSectionHeader('Hazard Warning Pattern'),
            _buildInfoCard(
              'The yellow (#E7C300) and black (#000000) color combination is '
              'internationally recognized as a hazard warning. This makes '
              'overflow issues immediately apparent during development.',
            ),
            SizedBox(height: 16),

            // Section 3: Overflow Directions
            _buildSectionHeader('Overflow Directions'),
            _buildDirectionCard('Top', 'Content extends above the container'),
            _buildDirectionCard('Right', 'Content extends past the right edge'),
            _buildDirectionCard('Bottom', 'Content extends below the container'),
            _buildDirectionCard('Left', 'Content extends past the left edge'),
            SizedBox(height: 16),

            // Section 4: Visual Example (Controlled overflow)
            _buildSectionHeader('Simulated Overflow Visualization'),
            _buildOverflowSimulation(),
            SizedBox(height: 16),

            // Section 5: Common Causes
            _buildSectionHeader('Common Causes of Overflow'),
            _buildCauseCard('Fixed-width text in narrow containers'),
            _buildCauseCard('Row with children exceeding available width'),
            _buildCauseCard('Images larger than their container'),
            _buildCauseCard('Missing Expanded/Flexible widgets'),
            SizedBox(height: 16),

            // Section 6: Solutions
            _buildSectionHeader('Common Solutions'),
            _buildSolutionCard('Wrap text with Flexible or Expanded'),
            _buildSolutionCard('Use ConstrainedBox or SizedBox'),
            _buildSolutionCard('Add SingleChildScrollView for scrollable content'),
            _buildSolutionCard('Use FittedBox to scale content'),
            _buildSolutionCard('Apply overflow: TextOverflow.ellipsis for text'),
            SizedBox(height: 32),

            // Section 7: Summary
            _buildSectionHeader('Summary'),
            _buildInfoCard(
              'DebugOverflowIndicatorMixin helps developers identify layout '
              'issues by painting visible indicators when content overflows. '
              'These indicators are only shown in debug builds and are '
              'stripped in release mode.',
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}

Widget _buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.deepOrange.shade700,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

Widget _buildInfoCard(String text) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 14, height: 1.5),
    ),
  );
}

Widget _buildDirectionCard(String direction, String description) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.amber.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.amber.shade200),
    ),
    child: Row(
      children: [
        Container(
          width: 60,
          child: Text(
            direction,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCauseCard(String cause) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.red.shade50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Icon(Icons.warning_amber_rounded, color: Colors.red.shade400, size: 20),
        SizedBox(width: 8),
        Expanded(
          child: Text(cause, style: TextStyle(fontSize: 13)),
        ),
      ],
    ),
  );
}

Widget _buildSolutionCard(String solution) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.green.shade50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Icon(Icons.check_circle, color: Colors.green.shade400, size: 20),
        SizedBox(width: 8),
        Expanded(
          child: Text(solution, style: TextStyle(fontSize: 13)),
        ),
      ],
    ),
  );
}

Widget _buildOverflowSimulation() {
  // Simulate the appearance of overflow stripes without actually causing overflow
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overflow Stripe Pattern (Simulation):',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(height: 12),
        Container(
          height: 40,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFE7C300), // Warning yellow
                Color(0xFF000000), // Black
                Color(0xFFE7C300),
                Color(0xFF000000),
                Color(0xFFE7C300),
                Color(0xFF000000),
                Color(0xFFE7C300),
                Color(0xFF000000),
              ],
              stops: [0.0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875],
              transform: GradientRotation(0.785), // 45 degrees
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'This pattern appears at the edge where content overflows.',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}
