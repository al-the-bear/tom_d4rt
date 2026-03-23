// Deep demo: RenderCustomMultiChildLayoutBox / CustomMultiChildLayout widget
// Tests CustomMultiChildLayout with custom delegates, LayoutId children,
// circular arrangements, staggered layouts, card stacks, dynamic sizing,
// Flow comparison, and practical dashboard layout patterns.

import 'package:flutter/material.dart';

Widget _buildHeader(String title, String subtitle) {
  print('Building header: $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 28, horizontal: 20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF00695C), Color(0xFF00897B), Color(0xFF26A69A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
      boxShadow: [
        BoxShadow(
          color: Color(0x4000695C),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 6),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xCCFFFFFF),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(IconData icon, String title) {
  print('Building section: $title');
  return Padding(
    padding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 12),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0x1A00695C),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Color(0xFF00695C), size: 22),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1B5E20),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCard(Widget child) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: child,
  );
}

Widget _buildLabel(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Color(0xFF616161),
      ),
    ),
  );
}

Widget _buildColorBox(Color color, double width, double height, String label) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Center(
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    ),
  );
}

// Delegate 1: Simple pattern - positions children in a diagonal line
class _DiagonalDelegate extends MultiChildLayoutDelegate {
  void performLayout(Size size) {
    print('  DiagonalDelegate.performLayout called, size: $size');
    int index = 0;
    List<String> ids = ['diag_a', 'diag_b', 'diag_c', 'diag_d'];
    for (String id in ids) {
      if (hasChild(id)) {
        Size childSize = layoutChild(id, BoxConstraints.loose(size));
        double xOffset = index * 60.0;
        double yOffset = index * 40.0;
        positionChild(id, Offset(xOffset, yOffset));
        print('    Positioned $id at ($xOffset, $yOffset), size: $childSize');
        index = index + 1;
      }
    }
  }

  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}

// Delegate 2: Circular arrangement of children
class _CircularDelegate extends MultiChildLayoutDelegate {
  double radius;
  int count;

  _CircularDelegate({
    required this.radius,
    required this.count,
  });

  void performLayout(Size size) {
    print('  CircularDelegate.performLayout called, radius: $radius, count: $count');
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    print('    Center: ($centerX, $centerY)');

    for (int i = 0; i < count; i++) {
      String id = 'circle_$i';
      if (hasChild(id)) {
        Size childSize = layoutChild(id, BoxConstraints.loose(size));
        // Simplified circular placement at cardinal directions
        double px = centerX + (radius * ((i % 4 == 0) ? -1.0 : (i % 4 == 1) ? 0.0 : (i % 4 == 2) ? 1.0 : 0.0)) - childSize.width / 2;
        double py = centerY + (radius * ((i % 4 == 0) ? 0.0 : (i % 4 == 1) ? -1.0 : (i % 4 == 2) ? 0.0 : 1.0)) - childSize.height / 2;
        positionChild(id, Offset(px.clamp(0.0, size.width - childSize.width), py.clamp(0.0, size.height - childSize.height)));
        print('    Positioned $id at circular position index $i');
      }
    }
  }

  bool shouldRelayout(_CircularDelegate oldDelegate) {
    return oldDelegate.radius != radius || oldDelegate.count != count;
  }
}

// Delegate 3: Staggered / waterfall layout
class _StaggeredDelegate extends MultiChildLayoutDelegate {
  int columnCount;

  _StaggeredDelegate({required this.columnCount});

  void performLayout(Size size) {
    print('  StaggeredDelegate.performLayout called, columns: $columnCount');
    double columnWidth = size.width / columnCount;
    List<double> columnHeights = List.filled(columnCount, 0.0);
    int childCount = 6;

    for (int i = 0; i < childCount; i++) {
      String id = 'stagger_$i';
      if (hasChild(id)) {
        Size childSize = layoutChild(
          id,
          BoxConstraints(
            maxWidth: columnWidth - 8,
            minWidth: 0,
            maxHeight: size.height,
            minHeight: 0,
          ),
        );

        // Find shortest column
        int shortestCol = 0;
        for (int c = 1; c < columnCount; c++) {
          if (columnHeights[c] < columnHeights[shortestCol]) {
            shortestCol = c;
          }
        }

        double x = shortestCol * columnWidth + 4;
        double y = columnHeights[shortestCol] + 4;
        positionChild(id, Offset(x, y));
        columnHeights[shortestCol] = y + childSize.height;
        print('    Positioned $id in column $shortestCol at y=$y, childH=${childSize.height}');
      }
    }
  }

  bool shouldRelayout(_StaggeredDelegate oldDelegate) {
    return oldDelegate.columnCount != columnCount;
  }
}

// Delegate 4: Overlapping card stack
class _CardStackDelegate extends MultiChildLayoutDelegate {
  double overlapOffset;

  _CardStackDelegate({required this.overlapOffset});

  void performLayout(Size size) {
    print('  CardStackDelegate.performLayout called, overlap: $overlapOffset');
    List<String> ids = ['stack_0', 'stack_1', 'stack_2', 'stack_3', 'stack_4'];

    for (int i = 0; i < ids.length; i++) {
      if (hasChild(ids[i])) {
        Size childSize = layoutChild(ids[i], BoxConstraints.loose(size));
        double x = i * overlapOffset;
        double y = i * (overlapOffset * 0.5);
        positionChild(ids[i], Offset(x, y));
        print('    Positioned ${ids[i]} at ($x, $y), overlap chain');
      }
    }
  }

  bool shouldRelayout(_CardStackDelegate oldDelegate) {
    return oldDelegate.overlapOffset != overlapOffset;
  }
}

// Delegate 5: Dynamic sizing delegate - adjusts based on available space
class _DynamicSizingDelegate extends MultiChildLayoutDelegate {
  double availableWidth;

  _DynamicSizingDelegate({required this.availableWidth});

  void performLayout(Size size) {
    print('  DynamicSizingDelegate.performLayout called, available: $availableWidth');
    List<String> ids = ['dyn_header', 'dyn_body', 'dyn_footer'];
    double currentY = 0;

    for (String id in ids) {
      if (hasChild(id)) {
        Size childSize = layoutChild(
          id,
          BoxConstraints(
            maxWidth: availableWidth,
            minWidth: 0,
            maxHeight: size.height - currentY,
            minHeight: 0,
          ),
        );
        positionChild(id, Offset(0, currentY));
        print('    Positioned $id at y=$currentY, height=${childSize.height}');
        currentY = currentY + childSize.height + 8;
      }
    }
  }

  bool shouldRelayout(_DynamicSizingDelegate oldDelegate) {
    return oldDelegate.availableWidth != availableWidth;
  }
}

// Delegate 6: Dashboard layout with named regions
class _DashboardDelegate extends MultiChildLayoutDelegate {
  void performLayout(Size size) {
    print('  DashboardDelegate.performLayout called');
    double padding = 8.0;
    double headerHeight = 50.0;
    double sidebarWidth = size.width * 0.3;
    double mainWidth = size.width - sidebarWidth - padding;

    // Header across the top
    if (hasChild('dash_header')) {
      layoutChild('dash_header', BoxConstraints.tightFor(width: size.width, height: headerHeight));
      positionChild('dash_header', Offset(0, 0));
      print('    Dashboard header positioned');
    }

    // Sidebar on the left
    double bodyTop = headerHeight + padding;
    double bodyHeight = size.height - bodyTop;
    if (hasChild('dash_sidebar')) {
      layoutChild('dash_sidebar', BoxConstraints.tightFor(width: sidebarWidth, height: bodyHeight));
      positionChild('dash_sidebar', Offset(0, bodyTop));
      print('    Dashboard sidebar positioned at left');
    }

    // Main content area top half
    if (hasChild('dash_main_top')) {
      double mainH = (bodyHeight - padding) / 2;
      layoutChild('dash_main_top', BoxConstraints.tightFor(width: mainWidth, height: mainH));
      positionChild('dash_main_top', Offset(sidebarWidth + padding, bodyTop));
      print('    Dashboard main_top positioned');
    }

    // Main content area bottom half
    if (hasChild('dash_main_bottom')) {
      double mainH = (bodyHeight - padding) / 2;
      double bottomY = bodyTop + mainH + padding;
      layoutChild('dash_main_bottom', BoxConstraints.tightFor(width: mainWidth, height: mainH));
      positionChild('dash_main_bottom', Offset(sidebarWidth + padding, bottomY));
      print('    Dashboard main_bottom positioned');
    }
  }

  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}

// Section 1: Simple diagonal pattern
Widget _buildDiagonalPatternSection() {
  print('Section 1: Diagonal pattern layout');

  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Diagonal arrangement of 4 children'),
        Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFF1F8E9),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFC5E1A5), width: 1),
          ),
          child: CustomMultiChildLayout(
            delegate: _DiagonalDelegate(),
            children: [
              LayoutId(
                id: 'diag_a',
                child: _buildColorBox(Color(0xFF2E7D32), 50, 50, 'A'),
              ),
              LayoutId(
                id: 'diag_b',
                child: _buildColorBox(Color(0xFF388E3C), 50, 50, 'B'),
              ),
              LayoutId(
                id: 'diag_c',
                child: _buildColorBox(Color(0xFF43A047), 50, 50, 'C'),
              ),
              LayoutId(
                id: 'diag_d',
                child: _buildColorBox(Color(0xFF4CAF50), 50, 50, 'D'),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        _buildLabel('Children positioned at increasing x,y offsets'),
        Text(
          'Each child offset by (60, 40) from previous',
          style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
        ),
      ],
    ),
  );
}

// Section 2: LayoutId with different identifiers
Widget _buildLayoutIdSection() {
  print('Section 2: LayoutId widget wrapping children');

  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('LayoutId maps children to delegate slots'),
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomMultiChildLayout(
            delegate: _DiagonalDelegate(),
            children: [
              LayoutId(
                id: 'diag_a',
                child: Container(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFF1B5E20),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text('id: diag_a', style: TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                ),
              ),
              LayoutId(
                id: 'diag_b',
                child: Container(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFF2E7D32),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text('id: diag_b', style: TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                ),
              ),
              LayoutId(
                id: 'diag_c',
                child: Container(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFF388E3C),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text('id: diag_c', style: TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                ),
              ),
              LayoutId(
                id: 'diag_d',
                child: Container(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFF43A047),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text('id: diag_d', style: TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Each LayoutId must have a unique id matching delegate expectations',
          style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
        ),
      ],
    ),
  );
}

// Section 3: Circular arrangement
Widget _buildCircularSection() {
  print('Section 3: Circular arrangement of items');
  List<Color> circleColors = [
    Color(0xFFD32F2F),
    Color(0xFF1976D2),
    Color(0xFF388E3C),
    Color(0xFFF57C00),
  ];

  List<Widget> circleChildren = [];
  for (int i = 0; i < 4; i++) {
    print('  Creating circular child $i');
    circleChildren.add(
      LayoutId(
        id: 'circle_$i',
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: circleColors[i],
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Color(0x40000000), blurRadius: 4, offset: Offset(0, 2)),
            ],
          ),
          child: Center(
            child: Text('${i + 1}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Circular arrangement delegate (4 items)'),
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFFFE082), width: 1),
          ),
          child: CustomMultiChildLayout(
            delegate: _CircularDelegate(radius: 60.0, count: 4),
            children: circleChildren,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Children positioned around a center point at cardinal directions',
          style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
        ),
      ],
    ),
  );
}

// Section 4: Staggered / waterfall layout
Widget _buildStaggeredSection() {
  print('Section 4: Staggered waterfall layout');

  List<double> heights = [60.0, 90.0, 45.0, 75.0, 55.0, 80.0];
  List<Color> staggerColors = [
    Color(0xFF5C6BC0),
    Color(0xFF7986CB),
    Color(0xFF9FA8DA),
    Color(0xFF3F51B5),
    Color(0xFF303F9F),
    Color(0xFF283593),
  ];

  List<Widget> staggerChildren = [];
  for (int i = 0; i < 6; i++) {
    print('  Creating stagger child $i with height ${heights[i]}');
    staggerChildren.add(
      LayoutId(
        id: 'stagger_$i',
        child: Container(
          height: heights[i],
          decoration: BoxDecoration(
            color: staggerColors[i],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              'Item $i\n${heights[i].toInt()}px',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }

  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Staggered layout with 3 columns'),
        Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFE8EAF6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomMultiChildLayout(
            delegate: _StaggeredDelegate(columnCount: 3),
            children: staggerChildren,
          ),
        ),
        SizedBox(height: 8),
        _buildLabel('Staggered layout with 2 columns'),
        Container(
          height: 260,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFE8EAF6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomMultiChildLayout(
            delegate: _StaggeredDelegate(columnCount: 2),
            children: [
              LayoutId(id: 'stagger_0', child: Container(height: 70, decoration: BoxDecoration(color: Color(0xFF5C6BC0), borderRadius: BorderRadius.circular(8)))),
              LayoutId(id: 'stagger_1', child: Container(height: 100, decoration: BoxDecoration(color: Color(0xFF7986CB), borderRadius: BorderRadius.circular(8)))),
              LayoutId(id: 'stagger_2', child: Container(height: 50, decoration: BoxDecoration(color: Color(0xFF9FA8DA), borderRadius: BorderRadius.circular(8)))),
              LayoutId(id: 'stagger_3', child: Container(height: 80, decoration: BoxDecoration(color: Color(0xFF3F51B5), borderRadius: BorderRadius.circular(8)))),
              LayoutId(id: 'stagger_4', child: Container(height: 60, decoration: BoxDecoration(color: Color(0xFF303F9F), borderRadius: BorderRadius.circular(8)))),
              LayoutId(id: 'stagger_5', child: Container(height: 90, decoration: BoxDecoration(color: Color(0xFF283593), borderRadius: BorderRadius.circular(8)))),
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Items placed in shortest column first, creating waterfall effect',
          style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
        ),
      ],
    ),
  );
}

// Section 5: Overlapping card stack
Widget _buildCardStackSection() {
  print('Section 5: Overlapping card stack');

  List<Color> stackColors = [
    Color(0xFFE53935),
    Color(0xFFFB8C00),
    Color(0xFFFDD835),
    Color(0xFF43A047),
    Color(0xFF1E88E5),
  ];

  List<Widget> stackChildren = [];
  for (int i = 0; i < 5; i++) {
    print('  Creating stack card $i');
    stackChildren.add(
      LayoutId(
        id: 'stack_$i',
        child: Container(
          width: 100,
          height: 140,
          decoration: BoxDecoration(
            color: stackColors[i],
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Color(0x60000000), blurRadius: 6, offset: Offset(2, 2)),
            ],
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Center(
            child: Text(
              'Card ${i + 1}',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }

  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Overlapping card stack (offset 30)'),
        Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFFCE4EC),
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomMultiChildLayout(
            delegate: _CardStackDelegate(overlapOffset: 30.0),
            children: stackChildren,
          ),
        ),
        SizedBox(height: 12),
        _buildLabel('Tighter overlap (offset 18)'),
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomMultiChildLayout(
            delegate: _CardStackDelegate(overlapOffset: 18.0),
            children: [
              LayoutId(id: 'stack_0', child: Container(width: 90, height: 120, decoration: BoxDecoration(color: Color(0xFF8E24AA), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white, width: 2)))),
              LayoutId(id: 'stack_1', child: Container(width: 90, height: 120, decoration: BoxDecoration(color: Color(0xFFAB47BC), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white, width: 2)))),
              LayoutId(id: 'stack_2', child: Container(width: 90, height: 120, decoration: BoxDecoration(color: Color(0xFFCE93D8), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white, width: 2)))),
              LayoutId(id: 'stack_3', child: Container(width: 90, height: 120, decoration: BoxDecoration(color: Color(0xFFE1BEE7), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white, width: 2)))),
              LayoutId(id: 'stack_4', child: Container(width: 90, height: 120, decoration: BoxDecoration(color: Color(0xFFF3E5F5), borderRadius: BorderRadius.circular(10), border: Border.all(color: Color(0xFFCE93D8), width: 2)))),
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Each card offset from previous, creating a fanned-out stack',
          style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
        ),
      ],
    ),
  );
}

// Section 6: Dynamic sizing based on children
Widget _buildDynamicSizingSection() {
  print('Section 6: Dynamic sizing layout');

  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Full width dynamic sizing (300px available)'),
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFE0F2F1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomMultiChildLayout(
            delegate: _DynamicSizingDelegate(availableWidth: 300.0),
            children: [
              LayoutId(
                id: 'dyn_header',
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFF00695C),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text('Header Region', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              LayoutId(
                id: 'dyn_body',
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color(0xFF00897B),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text('Body Region', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              LayoutId(
                id: 'dyn_footer',
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Color(0xFF26A69A),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text('Footer', style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        _buildLabel('Narrow dynamic sizing (150px available)'),
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFE0F2F1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomMultiChildLayout(
            delegate: _DynamicSizingDelegate(availableWidth: 150.0),
            children: [
              LayoutId(
                id: 'dyn_header',
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(color: Color(0xFF004D40), borderRadius: BorderRadius.circular(6)),
                  child: Center(child: Text('Hdr', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                ),
              ),
              LayoutId(
                id: 'dyn_body',
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(color: Color(0xFF00695C), borderRadius: BorderRadius.circular(6)),
                  child: Center(child: Text('Body', style: TextStyle(color: Colors.white))),
                ),
              ),
              LayoutId(
                id: 'dyn_footer',
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(color: Color(0xFF00897B), borderRadius: BorderRadius.circular(6)),
                  child: Center(child: Text('Ftr', style: TextStyle(color: Colors.white, fontSize: 12))),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Delegate constrains children to available width, stacking vertically',
          style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
        ),
      ],
    ),
  );
}

// Section 7: Comparison with Flow widget
Widget _buildFlowComparisonSection() {
  print('Section 7: Flow comparison');

  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('CustomMultiChildLayout: delegate-based positioning'),
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFF1F8E9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomMultiChildLayout(
            delegate: _DiagonalDelegate(),
            children: [
              LayoutId(id: 'diag_a', child: _buildColorBox(Color(0xFF558B2F), 45, 45, '1')),
              LayoutId(id: 'diag_b', child: _buildColorBox(Color(0xFF689F38), 45, 45, '2')),
              LayoutId(id: 'diag_c', child: _buildColorBox(Color(0xFF7CB342), 45, 45, '3')),
              LayoutId(id: 'diag_d', child: _buildColorBox(Color(0xFF8BC34A), 45, 45, '4')),
            ],
          ),
        ),
        SizedBox(height: 12),
        _buildLabel('Flow widget: transform-based painting'),
        Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.all(8),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildColorBox(Color(0xFFE65100), 45, 45, '1'),
              _buildColorBox(Color(0xFFEF6C00), 45, 45, '2'),
              _buildColorBox(Color(0xFFF57C00), 45, 45, '3'),
              _buildColorBox(Color(0xFFFB8C00), 45, 45, '4'),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Key Differences:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              SizedBox(height: 6),
              Text('- CustomMultiChildLayout: named children via LayoutId', style: TextStyle(fontSize: 12)),
              Text('- Flow: index-based, uses matrix transforms', style: TextStyle(fontSize: 12)),
              Text('- CustomMulti: full layout control per child', style: TextStyle(fontSize: 12)),
              Text('- Flow: efficient for animations, repaints only', style: TextStyle(fontSize: 12)),
              Text('- Both use delegates with performLayout', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ],
    ),
  );
}

// Section 8: Dashboard layout pattern
Widget _buildDashboardSection() {
  print('Section 8: Practical dashboard layout');

  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Dashboard with header, sidebar, and main panels'),
        Container(
          height: 280,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFECEFF1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomMultiChildLayout(
            delegate: _DashboardDelegate(),
            children: [
              LayoutId(
                id: 'dash_header',
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF37474F),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 16),
                      Icon(Icons.dashboard, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text('Dashboard', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      Spacer(),
                      Icon(Icons.notifications_none, color: Color(0xAAFFFFFF), size: 20),
                      SizedBox(width: 12),
                      Icon(Icons.person_outline, color: Color(0xAAFFFFFF), size: 20),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
              ),
              LayoutId(
                id: 'dash_sidebar',
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF455A64),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12)),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSidebarItem(Icons.home, 'Home'),
                      _buildSidebarItem(Icons.analytics, 'Analytics'),
                      _buildSidebarItem(Icons.settings, 'Settings'),
                      _buildSidebarItem(Icons.info_outline, 'About'),
                    ],
                  ),
                ),
              ),
              LayoutId(
                id: 'dash_main_top',
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Statistics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          _buildStatChip('Users', '1,234', Color(0xFF1E88E5)),
                          SizedBox(width: 8),
                          _buildStatChip('Revenue', '\$5.6k', Color(0xFF43A047)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          _buildStatChip('Orders', '89', Color(0xFFF57C00)),
                          SizedBox(width: 8),
                          _buildStatChip('Growth', '+12%', Color(0xFF8E24AA)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              LayoutId(
                id: 'dash_main_bottom',
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(12)),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Recent Activity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      SizedBox(height: 8),
                      _buildActivityRow('New signup', '2 min ago', Color(0xFF1E88E5)),
                      _buildActivityRow('Order placed', '15 min ago', Color(0xFF43A047)),
                      _buildActivityRow('Payment received', '1 hr ago', Color(0xFFF57C00)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Header + sidebar + 2 main panels, all positioned by delegate',
          style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
        ),
      ],
    ),
  );
}

Widget _buildSidebarItem(IconData icon, String label) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Icon(icon, color: Color(0xBBFFFFFF), size: 16),
        SizedBox(width: 6),
        Text(label, style: TextStyle(color: Color(0xDDFFFFFF), fontSize: 12)),
      ],
    ),
  );
}

Widget _buildStatChip(String label, String value, Color color) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 10, color: Color(0xFF757575))),
          SizedBox(height: 2),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    ),
  );
}

Widget _buildActivityRow(String title, String time, Color dotColor) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
        ),
        SizedBox(width: 8),
        Expanded(child: Text(title, style: TextStyle(fontSize: 12))),
        Text(time, style: TextStyle(fontSize: 10, color: Color(0xFF9E9E9E))),
      ],
    ),
  );
}

// Section 9: Delegate implementation notes
Widget _buildDelegateNotesSection() {
  print('Section 9: Delegate implementation notes');

  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('MultiChildLayoutDelegate contract'),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Required methods:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              SizedBox(height: 6),
              Text('1. performLayout(Size size) - layout and position children', style: TextStyle(fontSize: 12)),
              Text('2. shouldRelayout(old) - return true if layout changed', style: TextStyle(fontSize: 12)),
              SizedBox(height: 10),
              Text('Available in performLayout:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              SizedBox(height: 6),
              Text('- hasChild(id) - check if child with id exists', style: TextStyle(fontSize: 12)),
              Text('- layoutChild(id, constraints) - measure child', style: TextStyle(fontSize: 12)),
              Text('- positionChild(id, offset) - place child', style: TextStyle(fontSize: 12)),
              SizedBox(height: 10),
              Text('Rules:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              SizedBox(height: 6),
              Text('- Each child must be laid out exactly once', style: TextStyle(fontSize: 12)),
              Text('- layoutChild must be called before positionChild', style: TextStyle(fontSize: 12)),
              Text('- Children not positioned default to Offset.zero', style: TextStyle(fontSize: 12)),
              Text('- LayoutId wraps each child with a unique id', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        SizedBox(height: 12),
        _buildLabel('When to use CustomMultiChildLayout'),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('- Complex positioning not achievable with Row/Column/Stack', style: TextStyle(fontSize: 12)),
              Text('- Children sizes depend on each other', style: TextStyle(fontSize: 12)),
              Text('- Dashboard or grid layouts with named regions', style: TextStyle(fontSize: 12)),
              Text('- Circular / radial arrangements', style: TextStyle(fontSize: 12)),
              Text('- Overlapping elements with precise control', style: TextStyle(fontSize: 12)),
              Text('- Any layout where child position depends on sibling size', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ],
    ),
  );
}

// Main entry point
dynamic build(BuildContext context) {
  print('RenderCustomMultiChildLayoutBox deep demo executing');
  print('Demonstrates CustomMultiChildLayout and MultiChildLayoutDelegate');
  print('Uses LayoutId to map children to delegate positions');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader(
          'CustomMultiChildLayout Demo',
          'RenderCustomMultiChildLayoutBox - delegate-driven multi-child positioning',
        ),

        _buildSectionTitle(Icons.trending_up, '1. Diagonal Pattern'),
        _buildDiagonalPatternSection(),

        _buildSectionTitle(Icons.label, '2. LayoutId Mapping'),
        _buildLayoutIdSection(),

        _buildSectionTitle(Icons.radio_button_unchecked, '3. Circular Arrangement'),
        _buildCircularSection(),

        _buildSectionTitle(Icons.view_quilt, '4. Staggered Waterfall'),
        _buildStaggeredSection(),

        _buildSectionTitle(Icons.layers, '5. Overlapping Card Stack'),
        _buildCardStackSection(),

        _buildSectionTitle(Icons.aspect_ratio, '6. Dynamic Sizing'),
        _buildDynamicSizingSection(),

        _buildSectionTitle(Icons.compare, '7. Flow Comparison'),
        _buildFlowComparisonSection(),

        _buildSectionTitle(Icons.dashboard, '8. Dashboard Layout'),
        _buildDashboardSection(),

        _buildSectionTitle(Icons.description, '9. Delegate Notes'),
        _buildDelegateNotesSection(),

        SizedBox(height: 32),
        Center(
          child: Text(
            'End of CustomMultiChildLayout Deep Demo',
            style: TextStyle(fontSize: 13, color: Color(0xFF9E9E9E)),
          ),
        ),
        SizedBox(height: 24),
      ],
    ),
  );
}
