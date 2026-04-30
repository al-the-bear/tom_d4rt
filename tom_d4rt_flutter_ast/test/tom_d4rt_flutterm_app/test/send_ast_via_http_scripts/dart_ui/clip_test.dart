// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Clip enum from dart:ui
// Demonstrates all Clip modes used for clipping behavior in Flutter widgets.
// Clip controls how content that exceeds container boundaries is handled.
//
// Clip enum values:
// - Clip.none: No clipping (fastest, overflow visible)
// - Clip.hardEdge: Clip at bounds with aliased edges (fast)
// - Clip.antiAlias: Clip with anti-aliased edges (slower, smoother)
// - Clip.antiAliasWithSaveLayer: Anti-alias + saveLayer (slowest, best for complex cases)
//
// IMPORTANT: In D4rt, class definitions are not allowed. All logic must be in
// the build function, which returns a Widget.

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // Log Clip enum information
  print('=== Clip Enum Deep Demo ===');
  print('');
  print('Clip Enum Overview:');
  print('  Total values: ${Clip.values.length}');
  for (final clip in Clip.values) {
    print('  ${clip.index}: ${clip.name}');
  }

  print('');
  print('Clip Behavior Summary:');
  print('  Clip.none: No clipping, content overflows (fastest performance)');
  print('  Clip.hardEdge: Hard edge clipping with aliased edges');
  print('  Clip.antiAlias: Smooth anti-aliased clipping edges');
  print('  Clip.antiAliasWithSaveLayer: Best quality with saveLayer');

  print('');
  print('Performance Comparison:');
  print(
    '  Fastest → Slowest: none < hardEdge < antiAlias < antiAliasWithSaveLayer',
  );
  print('  Quality: none < hardEdge < antiAlias < antiAliasWithSaveLayer');

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
            width: 160,
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

  // Build clip demo card
  Widget buildClipDemoCard(
    Clip clipMode,
    String description,
    List<String> characteristics,
    Color color,
  ) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    clipMode.name.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: characteristics
                  .map(
                    (c) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: color.withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        c,
                        style: TextStyle(fontSize: 11, color: color),
                      ),
                    ),
                  )
                  .toList(),
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
              colors: [Colors.purple, Colors.deepPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.crop, color: Colors.white, size: 48),
              SizedBox(height: 12),
              Text(
                'Clip Enum',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Clipping behavior for widget overflow',
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
                  '${Clip.values.length} clip modes available',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 16),

        // Section 1: Enum Values Overview
        buildSectionCard(
          title: 'Clip Values Overview',
          icon: Icons.list_alt,
          color: Colors.blue,
          children: [
            Text(
              'The Clip enum defines how widgets clip their content when it overflows bounds.',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            ...Clip.values.map(
              (clip) => buildInfoRow(
                'Clip.${clip.name}',
                'index: ${clip.index}',
                valueColor: Colors.blue,
              ),
            ),
          ],
        ),

        // Section 2: Clip Mode Descriptions
        buildSectionCard(
          title: 'Clip Mode Characteristics',
          icon: Icons.info_outline,
          color: Colors.indigo,
          children: [
            buildClipDemoCard(
              Clip.none,
              'No clipping applied - content visibly overflows',
              [
                'No clipping',
                'Fastest performance',
                'Overflow visible',
                'Default for some widgets',
              ],
              Colors.green,
            ),
            buildClipDemoCard(
              Clip.hardEdge,
              'Hard edge clipping with aliased (jagged) edges',
              [
                'Basic clipping',
                'Fast performance',
                'Aliased edges',
                'Good for rectangles',
              ],
              Colors.orange,
            ),
            buildClipDemoCard(
              Clip.antiAlias,
              'Smooth anti-aliased clipping edges',
              [
                'Smooth edges',
                'Moderate performance',
                'Anti-aliased',
                'Good for curves',
              ],
              Colors.blue,
            ),
            buildClipDemoCard(
              Clip.antiAliasWithSaveLayer,
              'Best quality with saveLayer for complex scenarios',
              [
                'Highest quality',
                'Slowest performance',
                'Uses saveLayer',
                'For overlapping content',
              ],
              Colors.purple,
            ),
          ],
        ),

        // Section 3: Visual Comparison with ClipRect
        buildSectionCard(
          title: 'ClipRect Behavior Comparison',
          icon: Icons.compare,
          color: Colors.teal,
          children: [
            Text(
              'Compare how different Clip modes affect clipping behavior:',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // Clip.none demo
                  Column(
                    children: [
                      Text(
                        'Clip.none',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2),
                        ),
                        child: ClipRect(
                          clipBehavior: Clip.none,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                color: Colors.green.withValues(alpha: 0.3),
                              ),
                              Positioned(
                                right: -20,
                                bottom: -20,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Overflow visible',
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(width: 24),
                  // Clip.hardEdge demo
                  Column(
                    children: [
                      Text(
                        'Clip.hardEdge',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange, width: 2),
                        ),
                        child: ClipRect(
                          clipBehavior: Clip.hardEdge,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                color: Colors.orange.withValues(alpha: 0.3),
                              ),
                              Positioned(
                                right: -20,
                                bottom: -20,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Clipped (aliased)',
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(width: 24),
                  // Clip.antiAlias demo
                  Column(
                    children: [
                      Text(
                        'Clip.antiAlias',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2),
                        ),
                        child: ClipRect(
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                color: Colors.blue.withValues(alpha: 0.3),
                              ),
                              Positioned(
                                right: -20,
                                bottom: -20,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Smooth edges',
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(width: 24),
                  // Clip.antiAliasWithSaveLayer demo
                  Column(
                    children: [
                      Text(
                        'Clip.aAWithSaveLayer',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 2),
                        ),
                        child: ClipRect(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                color: Colors.purple.withValues(alpha: 0.3),
                              ),
                              Positioned(
                                right: -20,
                                bottom: -20,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.purple,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Best quality',
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

        // Section 4: ClipRRect with Border Radius
        buildSectionCard(
          title: 'ClipRRect with BorderRadius',
          icon: Icons.rounded_corner,
          color: Colors.pink,
          children: [
            Text(
              'ClipRRect clips to a rounded rectangle. Clip behavior affects edge smoothness:',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: Clip.values
                    .map(
                      (clip) => Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Column(
                          children: [
                            Text(
                              clip.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              clipBehavior: clip,
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.pink, Colors.orange],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.white,
                                    size: 36,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.pink.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'idx: ${clip.index}',
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),

        // Section 5: ClipOval
        buildSectionCard(
          title: 'ClipOval Demonstration',
          icon: Icons.circle_outlined,
          color: Colors.cyan,
          children: [
            Text(
              'ClipOval clips to an ellipse. Compare clip quality on curved edges:',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: Clip.values
                    .map(
                      (clip) => Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Column(
                          children: [
                            ClipOval(
                              clipBehavior: clip,
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  gradient: RadialGradient(
                                    colors: [Colors.cyan, Colors.blue.shade900],
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    clip.index.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              clip.name,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),

        // Section 6: ClipPath with Custom Shape
        buildSectionCard(
          title: 'Clip with Container BoxDecoration',
          icon: Icons.category,
          color: Colors.amber.shade800,
          children: [
            Text(
              'Container.clipBehavior affects how BoxDecoration clips content:',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: Clip.values
                  .map(
                    (clip) => Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          clipBehavior: clip,
                          decoration: BoxDecoration(
                            color: Colors.amber.shade100,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.amber.shade800,
                              width: 2,
                            ),
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                right: -15,
                                top: 20,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  color: Colors.amber.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(clip.name, style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        ),

        // Section 7: Performance Considerations
        buildSectionCard(
          title: 'Performance Guide',
          icon: Icons.speed,
          color: Colors.red,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning_amber, color: Colors.red, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Performance Impact',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Clip behavior affects rendering performance. Use the least '
                    'expensive option that meets visual requirements.',
                    style: TextStyle(color: Colors.red.shade700, fontSize: 13),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Performance comparison bars
            ...(() {
              final performanceData = [
                {'clip': Clip.none, 'perf': 1.0, 'label': 'Fastest'},
                {'clip': Clip.hardEdge, 'perf': 0.75, 'label': 'Fast'},
                {'clip': Clip.antiAlias, 'perf': 0.5, 'label': 'Moderate'},
                {
                  'clip': Clip.antiAliasWithSaveLayer,
                  'perf': 0.25,
                  'label': 'Slowest',
                },
              ];
              return performanceData.map(
                (data) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          (data['clip'] as Clip).name,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: data['perf'] as double,
                              child: Container(
                                height: 20,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.green, Colors.red],
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        data['label'] as String,
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            })(),
          ],
        ),

        // Section 8: Use Case Recommendations
        buildSectionCard(
          title: 'Use Case Recommendations',
          icon: Icons.lightbulb_outline,
          color: Colors.green,
          children: [
            _buildUseCaseRow(
              'Rectangular containers',
              'Clip.hardEdge',
              'Simple geometry doesn\'t benefit from anti-aliasing',
              Colors.orange,
            ),
            _buildUseCaseRow(
              'Rounded corners',
              'Clip.antiAlias',
              'Smooth curves look better with anti-aliasing',
              Colors.blue,
            ),
            _buildUseCaseRow(
              'Circular avatars',
              'Clip.antiAlias',
              'Smooth oval edges for professional look',
              Colors.blue,
            ),
            _buildUseCaseRow(
              'Complex overlapping content',
              'Clip.antiAliasWithSaveLayer',
              'Prevents blending artifacts at clip boundary',
              Colors.purple,
            ),
            _buildUseCaseRow(
              'No overflow expected',
              'Clip.none',
              'Skip clipping entirely for best performance',
              Colors.green,
            ),
          ],
        ),

        // Section 9: Enum Operations
        buildSectionCard(
          title: 'Enum Properties & Operations',
          icon: Icons.code,
          color: Colors.brown,
          children: [
            buildInfoRow('Clip.values.length', '${Clip.values.length}'),
            buildInfoRow('Clip.values.first', '${Clip.values.first}'),
            buildInfoRow('Clip.values.last', '${Clip.values.last}'),
            Divider(height: 24),
            Text(
              'Index-based access:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8),
            ...List.generate(
              Clip.values.length,
              (i) => buildInfoRow('Clip.values[$i]', '${Clip.values[i]}'),
            ),
            Divider(height: 24),
            Text(
              'Iteration patterns:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.brown.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'for (final clip in Clip.values) { ... }',
                    style: TextStyle(fontFamily: 'monospace', fontSize: 12),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Clip.values.map((c) => c.name).toList()',
                    style: TextStyle(fontFamily: 'monospace', fontSize: 12),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Clip.values.where((c) => c.index > 0)',
                    style: TextStyle(fontFamily: 'monospace', fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),

        // Section 10: Stack clipBehavior
        buildSectionCard(
          title: 'Stack clipBehavior Property',
          icon: Icons.layers,
          color: Colors.deepOrange,
          children: [
            Text(
              'Stack widget has a clipBehavior property that controls overflow clipping of positioned children:',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Stack with Clip.none
                Column(
                  children: [
                    Text(
                      'Clip.none',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.deepOrange, width: 2),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            color: Colors.deepOrange.withValues(alpha: 0.2),
                          ),
                          Positioned(
                            top: -20,
                            left: 30,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text('Visible overflow', style: TextStyle(fontSize: 10)),
                  ],
                ),
                // Stack with Clip.hardEdge
                Column(
                  children: [
                    Text(
                      'Clip.hardEdge',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.deepOrange, width: 2),
                      ),
                      child: Stack(
                        clipBehavior: Clip.hardEdge,
                        children: [
                          Container(
                            color: Colors.deepOrange.withValues(alpha: 0.2),
                          ),
                          Positioned(
                            top: -20,
                            left: 30,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text('Clipped overflow', style: TextStyle(fontSize: 10)),
                  ],
                ),
              ],
            ),
          ],
        ),

        // Section 11: PhysicalModel clipBehavior
        buildSectionCard(
          title: 'PhysicalModel with Clip',
          icon: Icons.view_in_ar,
          color: Colors.blueGrey,
          children: [
            Text(
              'PhysicalModel uses clipBehavior for elevation shadows:',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    [Clip.hardEdge, Clip.antiAlias, Clip.antiAliasWithSaveLayer]
                        .map(
                          (clip) => Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Column(
                              children: [
                                PhysicalModel(
                                  color: Colors.blueGrey.shade100,
                                  elevation: 8,
                                  clipBehavior: clip,
                                  borderRadius: BorderRadius.circular(16),
                                  child: SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: Center(
                                      child: Icon(
                                        Icons.view_in_ar,
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(clip.name, style: TextStyle(fontSize: 11)),
                              ],
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
          ],
        ),

        // Section 12: Comparison Table
        buildSectionCard(
          title: 'Clip Mode Comparison Table',
          icon: Icons.table_chart,
          color: Colors.grey.shade700,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  // Header row
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
                          flex: 2,
                          child: Text(
                            'Mode',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Speed',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Quality',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'SaveLayer',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Data rows
                  _buildTableRow('none', '★★★★★', '★☆☆☆☆', 'No', Colors.green),
                  _buildTableRow(
                    'hardEdge',
                    '★★★★☆',
                    '★★☆☆☆',
                    'No',
                    Colors.orange,
                  ),
                  _buildTableRow(
                    'antiAlias',
                    '★★★☆☆',
                    '★★★★☆',
                    'No',
                    Colors.blue,
                  ),
                  _buildTableRow(
                    'antiAliasWithSaveLayer',
                    '★☆☆☆☆',
                    '★★★★★',
                    'Yes',
                    Colors.purple,
                  ),
                ],
              ),
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
                'Clip Enum Demo Complete',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'All ${Clip.values.length} Clip modes demonstrated with visual examples '
                'and performance considerations.',
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

// Helper function for use case rows
Widget _buildUseCaseRow(
  String useCase,
  String recommended,
  String reason,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(useCase, style: TextStyle(fontWeight: FontWeight.w500)),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            recommended,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Text(
            reason,
            style: TextStyle(fontSize: 11, color: Colors.grey[600]),
          ),
        ),
      ],
    ),
  );
}

// Helper function for table rows
Widget _buildTableRow(
  String mode,
  String speed,
  String quality,
  String saveLayer,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              SizedBox(width: 8),
              Text(mode, style: TextStyle(fontFamily: 'monospace')),
            ],
          ),
        ),
        Expanded(child: Text(speed, style: TextStyle(fontSize: 11))),
        Expanded(child: Text(quality, style: TextStyle(fontSize: 11))),
        Expanded(child: Text(saveLayer, style: TextStyle(fontSize: 11))),
      ],
    ),
  );
}
