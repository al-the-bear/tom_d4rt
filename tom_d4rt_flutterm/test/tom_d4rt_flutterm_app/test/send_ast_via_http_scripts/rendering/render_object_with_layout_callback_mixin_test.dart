// ignore_for_file: avoid_print
// Deep demo: RenderObjectWithLayoutCallbackMixin
// Demonstrates LayoutBuilder, OrientationBuilder, and responsive patterns
// that leverage the layout callback mechanism under the hood.

import 'package:flutter/material.dart';

// Helper: builds a gradient header banner
Widget _buildHeader() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple, Colors.indigo, Colors.blue],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withOpacity(0.4),
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'RenderObjectWithLayoutCallbackMixin',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'LayoutBuilder uses this mixin to invoke a callback during layout, '
          'giving access to parent constraints for responsive UI decisions.',
          style: TextStyle(fontSize: 14, color: Colors.white70),
        ),
      ],
    ),
  );
}

// Helper: builds a styled section title
Widget _buildSectionTitle(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(top: 24, bottom: 12),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.withOpacity(0.15), Colors.transparent],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: Colors.indigo, width: 4)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.indigo, size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.indigo.shade800,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// Helper: info chip for constraint values
Widget _buildConstraintChip(String label, String value, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    margin: EdgeInsets.only(right: 8, bottom: 8),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withOpacity(0.4)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: color.withOpacity(0.7),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 6),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

// Section 1: Width-based layout switching (narrow vs wide)
Widget _buildWidthBasedLayout() {
  print('[LayoutCallback] Building width-based layout section');
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      double maxW = constraints.maxWidth;
      print('[LayoutCallback] Width-based: maxWidth=$maxW');
      bool isWide = maxW > 400;
      if (isWide) {
        return Row(
          children: [
            Expanded(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.teal.shade200),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.view_column, color: Colors.teal),
                    SizedBox(height: 4),
                    Text(
                      'Left Panel',
                      style: TextStyle(color: Colors.teal.shade700),
                    ),
                    Text(
                      'Wide mode: side by side',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.teal.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.view_column, color: Colors.orange),
                    SizedBox(height: 4),
                    Text(
                      'Right Panel',
                      style: TextStyle(color: Colors.orange.shade700),
                    ),
                    Text(
                      'Wide mode: side by side',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.orange.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }
      // Narrow: stacked vertically
      return Column(
        children: [
          Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.teal.shade200),
            ),
            alignment: Alignment.center,
            child: Text(
              'Top (narrow stacked)',
              style: TextStyle(color: Colors.teal.shade700),
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange.shade200),
            ),
            alignment: Alignment.center,
            child: Text(
              'Bottom (narrow stacked)',
              style: TextStyle(color: Colors.orange.shade700),
            ),
          ),
        ],
      );
    },
  );
}

// Section 2: Dynamic column count based on constraints
Widget _buildDynamicColumnCount() {
  print('[LayoutCallback] Building dynamic column count section');
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      double maxW = constraints.maxWidth;
      int columns = 1;
      if (maxW > 600) {
        columns = 4;
      } else if (maxW > 400) {
        columns = 3;
      } else if (maxW > 250) {
        columns = 2;
      }
      print('[LayoutCallback] Columns: $columns for width=$maxW');
      List<Widget> items = [];
      List<Color> palette = [
        Colors.red.shade100,
        Colors.blue.shade100,
        Colors.green.shade100,
        Colors.amber.shade100,
        Colors.purple.shade100,
        Colors.cyan.shade100,
      ];
      for (int i = 0; i < 6; i++) {
        items.add(
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: palette[i % palette.length],
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              'Item ${i + 1}',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detected $columns column(s) for width ${maxW.toStringAsFixed(0)}px',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          SizedBox(height: 8),
          GridView.count(
            crossAxisCount: columns,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 2.5,
            children: items,
          ),
        ],
      );
    },
  );
}

// Section 3: List vs Grid switching based on width
Widget _buildListGridSwitch() {
  print('[LayoutCallback] Building list/grid switch section');
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      double maxW = constraints.maxWidth;
      bool useGrid = maxW > 350;
      print('[LayoutCallback] List/Grid: useGrid=$useGrid, width=$maxW');

      List<Widget> entries = [];
      List<IconData> icons = [
        Icons.folder,
        Icons.image,
        Icons.music_note,
        Icons.videocam,
        Icons.description,
        Icons.archive,
      ];
      List<String> labels = [
        'Documents',
        'Photos',
        'Music',
        'Videos',
        'Notes',
        'Archive',
      ];

      for (int i = 0; i < icons.length; i++) {
        if (useGrid) {
          entries.add(
            Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blueGrey.shade200),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icons[i], size: 28, color: Colors.blueGrey.shade600),
                  SizedBox(height: 4),
                  Text(
                    labels[i],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blueGrey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          entries.add(
            Container(
              margin: EdgeInsets.only(bottom: 6),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(icons[i], size: 20, color: Colors.blueGrey.shade600),
                  SizedBox(width: 12),
                  Text(
                    labels[i],
                    style: TextStyle(color: Colors.blueGrey.shade700),
                  ),
                ],
              ),
            ),
          );
        }
      }

      if (useGrid) {
        return GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: entries,
        );
      }
      return Column(children: entries);
    },
  );
}

// Section 4: Constraint display showing actual values
Widget _buildConstraintDisplay() {
  print('[LayoutCallback] Building constraint display section');
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      print(
        '[LayoutCallback] Constraints: '
        'minW=${constraints.minWidth}, maxW=${constraints.maxWidth}, '
        'minH=${constraints.minHeight}, maxH=${constraints.maxHeight}',
      );
      return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Live BoxConstraints from parent:',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            SizedBox(height: 10),
            Wrap(
              children: [
                _buildConstraintChip(
                  'minWidth',
                  constraints.minWidth.toStringAsFixed(1),
                  Colors.blue,
                ),
                _buildConstraintChip(
                  'maxWidth',
                  constraints.maxWidth.toStringAsFixed(1),
                  Colors.indigo,
                ),
                _buildConstraintChip(
                  'minHeight',
                  constraints.minHeight.toStringAsFixed(1),
                  Colors.green,
                ),
                _buildConstraintChip(
                  'maxHeight',
                  constraints.maxHeight.toStringAsFixed(1),
                  Colors.teal,
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              constraints.isTight
                  ? 'Constraints are TIGHT (exact size forced)'
                  : 'Constraints are LOOSE (flexible sizing)',
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: constraints.isTight
                    ? Colors.red.shade600
                    : Colors.green.shade600,
              ),
            ),
          ],
        ),
      );
    },
  );
}

// Section 5: Nested LayoutBuilders showing constraint propagation
Widget _buildNestedLayoutBuilders() {
  print('[LayoutCallback] Building nested LayoutBuilders section');
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints outerConstraints) {
      double outerMax = outerConstraints.maxWidth;
      print('[LayoutCallback] Outer LayoutBuilder: maxWidth=$outerMax');
      return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.deepPurple.shade300, width: 2),
          borderRadius: BorderRadius.circular(12),
          color: Colors.deepPurple.shade50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Outer: maxWidth=${outerMax.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.deepPurple,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: LayoutBuilder(
                builder: (BuildContext ctx, BoxConstraints middleConstraints) {
                  double middleMax = middleConstraints.maxWidth;
                  print(
                    '[LayoutCallback]   Middle LayoutBuilder: maxWidth=$middleMax',
                  );
                  return Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue.shade300, width: 2),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue.shade50,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Middle: maxWidth=${middleMax.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: LayoutBuilder(
                            builder: (BuildContext ctx2, BoxConstraints innerConstraints) {
                              double innerMax = innerConstraints.maxWidth;
                              print(
                                '[LayoutCallback]     Inner LayoutBuilder: maxWidth=$innerMax',
                              );
                              return Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.green.shade300,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.green.shade50,
                                ),
                                child: Text(
                                  'Inner: maxWidth=${innerMax.toStringAsFixed(0)}\n'
                                  'Each nesting level reduces available width by padding.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.green.shade700,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}

// Section 6: LayoutBuilder with MediaQuery comparison
Widget _buildMediaQueryComparison() {
  print('[LayoutCallback] Building MediaQuery comparison section');
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      double layoutWidth = constraints.maxWidth;
      Size screenSize = MediaQuery.of(context).size;
      double screenWidth = screenSize.width;
      double screenHeight = screenSize.height;
      double ratio = (layoutWidth / screenWidth) * 100;
      print(
        '[LayoutCallback] MediaQuery compare: layout=$layoutWidth, screen=$screenWidth',
      );
      return Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.amber.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.amber.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LayoutBuilder',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'maxWidth: ${layoutWidth.toStringAsFixed(0)}px',
                        style: TextStyle(fontSize: 12, color: Colors.brown),
                      ),
                      Text(
                        'Reflects ACTUAL parent space',
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Container(width: 1, height: 50, color: Colors.amber.shade300),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MediaQuery',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'width: ${screenWidth.toStringAsFixed(0)}px',
                          style: TextStyle(fontSize: 12, color: Colors.brown),
                        ),
                        Text(
                          'height: ${screenHeight.toStringAsFixed(0)}px',
                          style: TextStyle(fontSize: 12, color: Colors.brown),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: ratio / 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber.shade600,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Layout uses ${ratio.toStringAsFixed(1)}% of screen width',
              style: TextStyle(fontSize: 11, color: Colors.amber.shade800),
            ),
          ],
        ),
      );
    },
  );
}

// Section 7: Responsive text sizing based on constraints
Widget _buildResponsiveTextSizing() {
  print('[LayoutCallback] Building responsive text sizing section');
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      double maxW = constraints.maxWidth;
      double titleSize = (maxW / 20).clamp(14.0, 32.0);
      double bodySize = (maxW / 30).clamp(11.0, 18.0);
      int maxLines = maxW > 400 ? 5 : 3;
      print(
        '[LayoutCallback] Text sizing: title=$titleSize, body=$bodySize, maxLines=$maxLines',
      );
      return Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.lime.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.lime.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Responsive Title',
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'This body text scales dynamically based on the available width. '
              'As the parent constraint narrows, font sizes shrink and maxLines '
              'decrease. Font size: ${bodySize.toStringAsFixed(1)}px, '
              'maxLines: $maxLines. The layout callback fires every time constraints '
              'change, giving precise adaptation control.',
              style: TextStyle(
                fontSize: bodySize,
                color: Colors.green.shade700,
                height: 1.4,
              ),
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _buildConstraintChip(
                  'titleSize',
                  '${titleSize.toStringAsFixed(1)}',
                  Colors.green,
                ),
                _buildConstraintChip(
                  'bodySize',
                  '${bodySize.toStringAsFixed(1)}',
                  Colors.teal,
                ),
                _buildConstraintChip(
                  'maxLines',
                  '$maxLines',
                  Colors.lime.shade700,
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

// Section 8: OrientationBuilder for orientation-based layout
Widget _buildOrientationSection() {
  print('[LayoutCallback] Building OrientationBuilder section');
  return OrientationBuilder(
    builder: (BuildContext context, Orientation orientation) {
      bool isLandscape = orientation == Orientation.landscape;
      print('[LayoutCallback] Orientation: ${orientation.toString()}');
      return Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isLandscape ? Colors.cyan.shade50 : Colors.pink.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isLandscape ? Colors.cyan.shade300 : Colors.pink.shade300,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isLandscape
                      ? Icons.stay_current_landscape
                      : Icons.stay_current_portrait,
                  color: isLandscape ? Colors.cyan : Colors.pink,
                  size: 28,
                ),
                SizedBox(width: 10),
                Text(
                  isLandscape ? 'Landscape Mode' : 'Portrait Mode',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isLandscape
                        ? Colors.cyan.shade800
                        : Colors.pink.shade800,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'OrientationBuilder uses a similar mechanism to LayoutBuilder. '
              'It determines orientation from the aspect ratio of the parent '
              'constraints: wider than tall = landscape.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                Chip(
                  label: Text(
                    isLandscape ? 'Horizontal flow' : 'Vertical flow',
                  ),
                  backgroundColor: isLandscape
                      ? Colors.cyan.shade100
                      : Colors.pink.shade100,
                ),
                Chip(
                  label: Text(isLandscape ? 'Side nav' : 'Bottom nav'),
                  backgroundColor: isLandscape
                      ? Colors.cyan.shade100
                      : Colors.pink.shade100,
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

// Section 9a: Responsive dashboard pattern
Widget _buildResponsiveDashboard() {
  print('[LayoutCallback] Building responsive dashboard section');
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      double maxW = constraints.maxWidth;
      int crossAxisCount = maxW > 500 ? 3 : (maxW > 300 ? 2 : 1);
      print('[LayoutCallback] Dashboard: columns=$crossAxisCount, width=$maxW');

      List<Map<String, dynamic>> cards = [
        {
          'title': 'Revenue',
          'value': '\$12,340',
          'icon': Icons.attach_money,
          'color': Colors.green,
        },
        {
          'title': 'Users',
          'value': '1,204',
          'icon': Icons.people,
          'color': Colors.blue,
        },
        {
          'title': 'Orders',
          'value': '384',
          'icon': Icons.shopping_cart,
          'color': Colors.orange,
        },
        {
          'title': 'Growth',
          'value': '+14.2%',
          'icon': Icons.trending_up,
          'color': Colors.purple,
        },
        {
          'title': 'Bounce',
          'value': '32.1%',
          'icon': Icons.exit_to_app,
          'color': Colors.red,
        },
        {
          'title': 'Uptime',
          'value': '99.9%',
          'icon': Icons.check_circle,
          'color': Colors.teal,
        },
      ];

      List<Widget> cardWidgets = [];
      for (int i = 0; i < cards.length; i++) {
        Map<String, dynamic> card = cards[i];
        Color c = card['color'] as Color;
        cardWidgets.add(
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: c.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: c.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(card['icon'] as IconData, color: c, size: 20),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        card['title'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  card['value'] as String,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: c,
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return GridView.count(
        crossAxisCount: crossAxisCount,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.8,
        children: cardWidgets,
      );
    },
  );
}

// Section 9b: Adaptive navigation pattern
Widget _buildAdaptiveNavigation() {
  print('[LayoutCallback] Building adaptive navigation section');
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      double maxW = constraints.maxWidth;
      bool showSideNav = maxW > 450;
      print('[LayoutCallback] Navigation: sideNav=$showSideNav, width=$maxW');

      Widget navItems = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNavItem(Icons.home, 'Home', showSideNav),
          _buildNavItem(Icons.search, 'Search', showSideNav),
          _buildNavItem(Icons.notifications, 'Alerts', showSideNav),
          _buildNavItem(Icons.settings, 'Settings', showSideNav),
        ],
      );

      Widget contentArea = Container(
        height: showSideNav ? 160 : 80,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.dashboard, color: Colors.grey.shade400, size: 28),
            SizedBox(height: 4),
            Text(
              'Content Area',
              style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
            ),
            Text(
              showSideNav
                  ? 'Side navigation visible'
                  : 'Bottom navigation mode',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 11),
            ),
          ],
        ),
      );

      if (showSideNav) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.indigo.shade200),
              ),
              child: navItems,
            ),
            SizedBox(width: 12),
            Expanded(child: contentArea),
          ],
        );
      }

      // Bottom nav mode
      return Column(
        children: [
          contentArea,
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.indigo.shade200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.home, color: Colors.indigo, size: 22),
                Icon(Icons.search, color: Colors.indigo.shade300, size: 22),
                Icon(
                  Icons.notifications,
                  color: Colors.indigo.shade300,
                  size: 22,
                ),
                Icon(Icons.settings, color: Colors.indigo.shade300, size: 22),
              ],
            ),
          ),
        ],
      );
    },
  );
}

// Helper: navigation item for adaptive nav
Widget _buildNavItem(IconData icon, String label, bool expanded) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: Colors.indigo.shade600),
        if (expanded) SizedBox(width: 8),
        if (expanded)
          Text(
            label,
            style: TextStyle(fontSize: 13, color: Colors.indigo.shade700),
          ),
      ],
    ),
  );
}

// Main entry point
dynamic build(BuildContext context) {
  print(
    '[LayoutCallback] === RenderObjectWithLayoutCallbackMixin Deep Demo ===',
  );
  print(
    '[LayoutCallback] LayoutBuilder wraps RenderObjectWithLayoutCallbackMixin',
  );
  print(
    '[LayoutCallback] to provide parent constraints during the layout phase',
  );

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),

        // Section 1: Width-based layout
        _buildSectionTitle('1. Width-Based Layout Switching', Icons.swap_horiz),
        _buildWidthBasedLayout(),

        // Section 2: Dynamic column count
        _buildSectionTitle('2. Dynamic Column Count', Icons.grid_view),
        _buildDynamicColumnCount(),

        // Section 3: List vs Grid
        _buildSectionTitle('3. List vs Grid Switching', Icons.view_list),
        _buildListGridSwitch(),

        // Section 4: Constraint display
        _buildSectionTitle('4. Live Constraint Display', Icons.info_outline),
        _buildConstraintDisplay(),

        // Section 5: Nested LayoutBuilders
        _buildSectionTitle(
          '5. Nested LayoutBuilders (Constraint Propagation)',
          Icons.layers,
        ),
        _buildNestedLayoutBuilders(),

        // Section 6: MediaQuery comparison
        _buildSectionTitle('6. LayoutBuilder vs MediaQuery', Icons.compare),
        _buildMediaQueryComparison(),

        // Section 7: Responsive text sizing
        _buildSectionTitle('7. Responsive Text Sizing', Icons.text_fields),
        _buildResponsiveTextSizing(),

        // Section 8: OrientationBuilder
        _buildSectionTitle('8. OrientationBuilder', Icons.screen_rotation),
        _buildOrientationSection(),

        // Section 9: Practical patterns
        _buildSectionTitle('9a. Responsive Dashboard Pattern', Icons.dashboard),
        _buildResponsiveDashboard(),

        _buildSectionTitle('9b. Adaptive Navigation Pattern', Icons.navigation),
        _buildAdaptiveNavigation(),

        // Footer
        SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'RenderObjectWithLayoutCallbackMixin Summary',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 6),
              Text(
                'This mixin enables render objects to call back into the widget layer '
                'during layout. LayoutBuilder and OrientationBuilder both use this '
                'pattern to let widgets adapt to their actual constraints rather '
                'than just screen size. This is fundamental to truly responsive '
                'Flutter layouts.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
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
