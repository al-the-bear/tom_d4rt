// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PathOperation enum from dart:ui
// Demonstrates boolean operations that can be applied to combine two paths.
// PathOperation is used with Path.combine() to create complex shapes.
//
// PathOperation enum values:
// - PathOperation.difference: Subtracts path2 from path1
// - PathOperation.intersect: Keeps only overlapping regions
// - PathOperation.union: Combines both paths
// - PathOperation.reverseDifference: Subtracts path1 from path2
// - PathOperation.xor: Keeps only non-overlapping regions
//
// IMPORTANT: In D4rt, class definitions are not allowed. All logic must be in
// the build function, which returns a Widget.

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // Log PathOperation enum information
  print('=== PathOperation Enum Deep Demo ===');
  print('');
  print('PathOperation Enum Overview:');
  print('  Total values: ${PathOperation.values.length}');
  for (final op in PathOperation.values) {
    print('  ${op.index}: ${op.name}');
  }

  print('');
  print('Operation Descriptions:');
  print('  difference: A - B (subtract B from A)');
  print('  intersect: A ∩ B (only overlapping part)');
  print('  union: A ∪ B (combine both)');
  print('  reverseDifference: B - A (subtract A from B)');
  print('  xor: (A - B) ∪ (B - A) (non-overlapping parts)');

  print('');
  print('Use Cases:');
  print('  difference: Creating cutouts, cookie-cutter effects');
  print('  intersect: Masking, clipping to shape');
  print('  union: Combining shapes into one');
  print('  xor: Exclusive regions, ring effects');

  // Build section card helper
  Widget buildSectionCard({
    required String title,
    required IconData icon,
    required Color color,
    required List<Widget> children,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 28),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }

  // Build info row
  Widget buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: valueColor ?? Colors.black87,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build path operation demo widget
  Widget buildOperationDemo(
    PathOperation operation,
    Color resultColor,
    String symbol,
    String description,
  ) {
    return Column(
      children: [
        Text(
          operation.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        SizedBox(height: 8),
        CustomPaint(
          size: Size(140, 140),
          painter: _PathOperationPainter(
            operation: operation,
            resultColor: resultColor,
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: resultColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: resultColor.withValues(alpha: 0.3)),
          ),
          child: Text(
            symbol,
            style: TextStyle(
              fontSize: 14,
              color: resultColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 10, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // Build input shapes legend
  Widget buildInputLegend() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.3),
              border: Border.all(color: Colors.blue, width: 2),
            ),
          ),
          SizedBox(width: 8),
          Text('Path A (square)', style: TextStyle(fontSize: 12)),
          SizedBox(width: 24),
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.3),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.red, width: 2),
            ),
          ),
          SizedBox(width: 8),
          Text('Path B (circle)', style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  // Build operation card with details
  Widget buildOperationCard(
    PathOperation op,
    String symbol,
    String formula,
    List<String> useCases,
    Color color,
  ) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6),
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: color.withValues(alpha: 0.3)),
              ),
              child: Center(
                child: Text(
                  symbol,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          op.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        formula,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 4,
                    children: useCases
                        .map(
                          (u) => Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            margin: EdgeInsets.only(bottom: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(u, style: TextStyle(fontSize: 10)),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('');
  print('Building visual demo sections...');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange, Colors.orange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.merge_type, color: Colors.white, size: 48),
              SizedBox(height: 12),
              Text(
                'PathOperation Enum',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Boolean operations for combining paths',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${PathOperation.values.length} operations available',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 16),

        // Section 1: Enum Overview
        buildSectionCard(
          title: 'PathOperation Values',
          icon: Icons.list_alt,
          color: Colors.blue,
          children: [
            Text(
              'PathOperation defines how to combine two paths using boolean operations.',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            ...PathOperation.values.map(
              (op) => buildInfoRow(
                'PathOperation.${op.name}',
                'index: ${op.index}',
                valueColor: Colors.blue,
              ),
            ),
          ],
        ),

        // Section 2: Input Shapes
        buildSectionCard(
          title: 'Demo Input Shapes',
          icon: Icons.category,
          color: Colors.purple,
          children: [
            Text(
              'All demonstrations use these two overlapping shapes:',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            buildInputLegend(),
            SizedBox(height: 16),
            Center(
              child: CustomPaint(
                size: Size(180, 140),
                painter: _InputShapesPainter(),
              ),
            ),
          ],
        ),

        // Section 3: Visual Operation Comparison
        buildSectionCard(
          title: 'All Operations Visual Comparison',
          icon: Icons.compare,
          color: Colors.teal,
          children: [
            Text(
              'Result of each operation on overlapping square and circle:',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  buildOperationDemo(
                    PathOperation.difference,
                    Colors.blue,
                    'A - B',
                    'Square minus circle',
                  ),
                  SizedBox(width: 16),
                  buildOperationDemo(
                    PathOperation.intersect,
                    Colors.green,
                    'A ∩ B',
                    'Only overlap',
                  ),
                  SizedBox(width: 16),
                  buildOperationDemo(
                    PathOperation.union,
                    Colors.purple,
                    'A ∪ B',
                    'Combine both',
                  ),
                  SizedBox(width: 16),
                  buildOperationDemo(
                    PathOperation.reverseDifference,
                    Colors.red,
                    'B - A',
                    'Circle minus square',
                  ),
                  SizedBox(width: 16),
                  buildOperationDemo(
                    PathOperation.xor,
                    Colors.orange,
                    'A ⊕ B',
                    'Non-overlapping',
                  ),
                ],
              ),
            ),
          ],
        ),

        // Section 4: Detailed Operation Cards
        buildSectionCard(
          title: 'Operation Details',
          icon: Icons.info_outline,
          color: Colors.indigo,
          children: [
            buildOperationCard(PathOperation.difference, '−', 'A - B', [
              'Cutouts',
              'Cookie cutter',
              'Holes',
              'Subtract shapes',
            ], Colors.blue),
            buildOperationCard(PathOperation.intersect, '∩', 'A ∩ B', [
              'Masking',
              'Clipping',
              'Common area',
              'Visible overlap',
            ], Colors.green),
            buildOperationCard(PathOperation.union, '∪', 'A ∪ B', [
              'Merge shapes',
              'Combine paths',
              'Logical OR',
              'Silhouette',
            ], Colors.purple),
            buildOperationCard(PathOperation.reverseDifference, '−', 'B - A', [
              'Reverse cutout',
              'Inverse mask',
              'B only parts',
            ], Colors.red),
            buildOperationCard(PathOperation.xor, '⊕', '(A-B) ∪ (B-A)', [
              'Ring effect',
              'Exclusive parts',
              'Toggle overlap',
            ], Colors.orange),
          ],
        ),

        // Section 5: Large Visual Demos
        buildSectionCard(
          title: 'Difference (A - B)',
          icon: Icons.remove_circle_outline,
          color: Colors.blue,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomPaint(
                    size: Size(200, 150),
                    painter: _LargeOperationPainter(
                      operation: PathOperation.difference,
                      resultColor: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Subtracts path B from path A',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'The result keeps the parts of A that do not overlap with B.',
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                      SizedBox(height: 12),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Example: Cut a circular hole in a rectangle',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),

        buildSectionCard(
          title: 'Intersect (A ∩ B)',
          icon: Icons.filter_center_focus,
          color: Colors.green,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomPaint(
                    size: Size(200, 150),
                    painter: _LargeOperationPainter(
                      operation: PathOperation.intersect,
                      resultColor: Colors.green,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Keeps only where A and B overlap',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'The result is the common region between both paths.',
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                      SizedBox(height: 12),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Example: Clip content to a shape',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),

        buildSectionCard(
          title: 'Union (A ∪ B)',
          icon: Icons.add_circle_outline,
          color: Colors.purple,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomPaint(
                    size: Size(200, 150),
                    painter: _LargeOperationPainter(
                      operation: PathOperation.union,
                      resultColor: Colors.purple,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Combines A and B into one shape',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'The result fills all areas covered by either path.',
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                      SizedBox(height: 12),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.purple.shade50,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Example: Merge overlapping bubbles',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),

        buildSectionCard(
          title: 'Reverse Difference (B - A)',
          icon: Icons.undo,
          color: Colors.red,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomPaint(
                    size: Size(200, 150),
                    painter: _LargeOperationPainter(
                      operation: PathOperation.reverseDifference,
                      resultColor: Colors.red,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Subtracts path A from path B',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'The result keeps parts of B that do not overlap with A.',
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                      SizedBox(height: 12),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Example: Crescent moon from two circles',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),

        buildSectionCard(
          title: 'XOR (Exclusive Or)',
          icon: Icons.sync_alt,
          color: Colors.orange,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomPaint(
                    size: Size(200, 150),
                    painter: _LargeOperationPainter(
                      operation: PathOperation.xor,
                      resultColor: Colors.orange,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Keeps non-overlapping regions only',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'The result excludes areas where both A and B overlap.',
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                      SizedBox(height: 12),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Example: Ring/donut from two circles',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),

        // Section 6: Code Example
        buildSectionCard(
          title: 'Code Example',
          icon: Icons.code,
          color: Colors.blueGrey,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '// Define two paths',
                    style: TextStyle(
                      color: Colors.green.shade400,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'final pathA = Path()..addRect(rect);',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'final pathB = Path()..addOval(oval);',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '// Combine paths with operation',
                    style: TextStyle(
                      color: Colors.green.shade400,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'final result = Path.combine(',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '  PathOperation.difference,',
                    style: TextStyle(
                      color: Colors.orange.shade300,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '  pathA,',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '  pathB,',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    ');',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '// Draw combined path',
                    style: TextStyle(
                      color: Colors.green.shade400,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'canvas.drawPath(result, paint);',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        // Section 7: Truth Table
        buildSectionCard(
          title: 'Operation Truth Table',
          icon: Icons.table_chart,
          color: Colors.brown,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Region',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'diff',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'inter',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'union',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'revDiff',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'xor',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildTruthTableRow('Only A', ['✓', '✗', '✓', '✗', '✓']),
                  _buildTruthTableRow('A ∩ B', ['✗', '✓', '✓', '✗', '✗']),
                  _buildTruthTableRow('Only B', ['✗', '✗', '✓', '✓', '✓']),
                ],
              ),
            ),
          ],
        ),

        // Section 8: Enum Properties
        buildSectionCard(
          title: 'Enum Properties',
          icon: Icons.settings,
          color: Colors.grey.shade700,
          children: [
            buildInfoRow('values.length', '${PathOperation.values.length}'),
            buildInfoRow('values.first', '${PathOperation.values.first}'),
            buildInfoRow('values.last', '${PathOperation.values.last}'),
            Divider(height: 24),
            Text(
              'Index-based access:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8),
            ...List.generate(
              PathOperation.values.length,
              (i) => buildInfoRow('values[$i]', '${PathOperation.values[i]}'),
            ),
          ],
        ),

        // Footer
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text(
                'PathOperation Demo Complete',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'All ${PathOperation.values.length} operations demonstrated with '
                'visual examples showing how each combines two paths.',
                style: TextStyle(color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        SizedBox(height: 32),
      ],
    ),
  );
}

// Helper for truth table rows
Widget _buildTruthTableRow(String region, List<String> values) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(region, style: TextStyle(fontWeight: FontWeight.w500)),
        ),
        ...values.map(
          (v) => Expanded(
            child: Text(
              v,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: v == '✓' ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

/// CustomPainter for showing input shapes (square and circle)
class _InputShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Path A - Square (left side)
    final pathA = Path()..addRect(Rect.fromLTWH(20, 30, 80, 80));
    final paintA = Paint()
      ..color = Colors.blue.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;
    final strokeA = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(pathA, paintA);
    canvas.drawPath(pathA, strokeA);

    // Path B - Circle (overlapping)
    final pathB = Path()..addOval(Rect.fromLTWH(60, 30, 80, 80));
    final paintB = Paint()
      ..color = Colors.red.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;
    final strokeB = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(pathB, paintB);
    canvas.drawPath(pathB, strokeB);

    // Labels
    final textPainterA = TextPainter(
      text: TextSpan(
        text: 'A',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainterA.paint(canvas, Offset(50, 65));

    final textPainterB = TextPainter(
      text: TextSpan(
        text: 'B',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainterB.paint(canvas, Offset(120, 65));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// CustomPainter for demonstrating path operations
class _PathOperationPainter extends CustomPainter {
  final PathOperation operation;
  final Color resultColor;

  _PathOperationPainter({required this.operation, required this.resultColor});

  @override
  void paint(Canvas canvas, Size size) {
    // Create overlapping square and circle
    final rectPath = Path()..addRect(Rect.fromLTWH(15, 30, 70, 70));
    final ovalPath = Path()..addOval(Rect.fromLTWH(55, 30, 70, 70));

    // Combine with operation
    final result = Path.combine(operation, rectPath, ovalPath);

    // Draw result
    final paint = Paint()
      ..color = resultColor
      ..style = PaintingStyle.fill;

    canvas.drawPath(result, paint);

    // Draw outlines of original shapes
    final outlineA = Paint()
      ..color = Colors.blue.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final outlineB = Paint()
      ..color = Colors.red.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawPath(rectPath, outlineA);
    canvas.drawPath(ovalPath, outlineB);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Larger CustomPainter for detailed operation demos
class _LargeOperationPainter extends CustomPainter {
  final PathOperation operation;
  final Color resultColor;

  _LargeOperationPainter({required this.operation, required this.resultColor});

  @override
  void paint(Canvas canvas, Size size) {
    // Create overlapping square and circle
    final rectPath = Path()..addRect(Rect.fromLTWH(10, 25, 100, 100));
    final ovalPath = Path()..addOval(Rect.fromLTWH(60, 25, 100, 100));

    // Draw background shapes with light fill
    final bgPaintA = Paint()
      ..color = Colors.blue.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;
    final bgPaintB = Paint()
      ..color = Colors.red.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;

    canvas.drawPath(rectPath, bgPaintA);
    canvas.drawPath(ovalPath, bgPaintB);

    // Combine with operation
    final result = Path.combine(operation, rectPath, ovalPath);

    // Draw result
    final paint = Paint()
      ..color = resultColor
      ..style = PaintingStyle.fill;

    canvas.drawPath(result, paint);

    // Draw outlines of original shapes
    final outlineA = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final outlineB = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(rectPath, outlineA);
    canvas.drawPath(ovalPath, outlineB);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
