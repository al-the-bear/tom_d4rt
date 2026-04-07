// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — PreferredSizeWidget interface
// Demonstrates PreferredSizeWidget: the interface that widgets implement to
// report a preferred size to parent layout widgets. Used by Scaffold to size
// the AppBar region, and by AppBar to size its bottom slot.
// This is the INTERFACE itself — distinct from PreferredSize (the wrapper widget).
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PreferredSizeWidget Deep Demo executing');

  // ============================================================
  // SECTION 1: What PreferredSizeWidget Is — Concept Overview
  // ============================================================
  print('=== Section 1: PreferredSizeWidget Concept ===');

  // PreferredSizeWidget is a mixin on Widget that adds:
  //   Size get preferredSize
  //
  // It does NOT constrain the widget to that size — it merely
  // REPORTS a preferred size that parent widgets can read. The
  // canonical consumer is Scaffold, which reads AppBar.preferredSize
  // to determine how much space to allocate above the body.
  //
  // Key distinction:
  //   PreferredSizeWidget = the interface (abstract)
  //   PreferredSize = a concrete widget that wraps any child and
  //                   reports a given preferred size

  final conceptCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF6A1B9A), Color(0xFF4A148C)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.purple.withValues(alpha: 0.3),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.straighten, color: Colors.white, size: 30.0),
            SizedBox(width: 12.0),
            Text(
              'PreferredSizeWidget',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Text(
          'An interface (mixin on Widget) that adds a single getter: '
          'preferredSize. It tells parent widgets how much space the '
          'widget WANTS, but does not enforce that size. The parent '
          'decides how to use the information.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.white.withValues(alpha: 0.9),
            height: 1.5,
          ),
        ),
        SizedBox(height: 16.0),
        // Interface vs wrapper
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(Icons.api, color: Colors.amberAccent, size: 26.0),
                    SizedBox(height: 6.0),
                    Text(
                      'PreferredSizeWidget',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'The interface — an abstract contract. '
                      'Implemented by AppBar, TabBar, and custom widgets.',
                      style: TextStyle(fontSize: 9.0, color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(Icons.wrap_text, color: Colors.white54, size: 26.0),
                    SizedBox(height: 6.0),
                    Text(
                      'PreferredSize',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'A concrete wrapper widget. Wraps any child '
                      'and reports a given preferred size on its behalf.',
                      style: TextStyle(fontSize: 9.0, color: Colors.white54),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  print('Created concept overview card');

  // ============================================================
  // SECTION 2: Widgets That Implement PreferredSizeWidget
  // ============================================================
  print('=== Section 2: Framework Widgets Implementing the Interface ===');

  // These Flutter widgets implement PreferredSizeWidget directly:
  //  - AppBar (preferredSize = toolbarHeight + bottom preferredSize)
  //  - TabBar (preferredSize = Tab height + indicator)
  //  - PreferredSize (preferredSize = user-specified size)
  //  - CupertinoNavigationBar
  //  - SliverAppBar (implements it for compatibility)
  //  - BottomAppBar (implements it to report its height)

  final implementors = [
    {
      'name': 'AppBar',
      'size': 'toolbarHeight + bottom.preferredSize.height',
      'default': '56.0 dp (or 64.0 with bottom)',
      'icon': Icons.web_asset,
      'color': Colors.blue,
      'detail': 'Primary app bar. Reports combined toolbar + bottom height.',
    },
    {
      'name': 'TabBar',
      'size': 'kTabHeight (46.0) + indicator',
      'default': '46.0 dp',
      'icon': Icons.tab,
      'color': Colors.indigo,
      'detail': 'Tab navigation bar. Reports tab row height. Needs no PreferredSize wrapper.',
    },
    {
      'name': 'PreferredSize',
      'size': 'User-configured Size',
      'default': 'Any value',
      'icon': Icons.crop_free,
      'color': Colors.teal,
      'detail': 'Generic wrapper. Reports whatever size you pass in constructor.',
    },
    {
      'name': 'CupertinoNavigationBar',
      'size': 'kMinInteractiveDimensionCupertino',
      'default': '44.0 dp',
      'icon': Icons.phone_iphone,
      'color': Colors.grey,
      'detail': 'iOS-style navigation bar. Shorter than Material AppBar.',
    },
    {
      'name': 'BottomAppBar',
      'size': 'kBottomNavigationBarHeight',
      'default': '56.0 dp',
      'icon': Icons.grid_view,
      'color': Colors.brown,
      'detail': 'Bottom app bar for FAB notch integration.',
    },
  ];

  final implementorCards = <Widget>[];
  for (final impl in implementors) {
    final color = impl['color'] as MaterialColor;
    implementorCards.add(
      Container(
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: color.shade50,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 42.0,
              height: 42.0,
              decoration: BoxDecoration(
                color: color.shade100,
                borderRadius: BorderRadius.circular(10.0),
              ),
              alignment: Alignment.center,
              child: Icon(impl['icon'] as IconData, color: color.shade700, size: 22.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        impl['name'] as String,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: color.shade800,
                        ),
                      ),
                      SizedBox(width: 6.0),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: color.shade100,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          impl['default'] as String,
                          style: TextStyle(
                            fontSize: 9.0,
                            fontWeight: FontWeight.bold,
                            color: color.shade700,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    impl['detail'] as String,
                    style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600),
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    'preferredSize: ${impl['size']}',
                    style: TextStyle(
                      fontSize: 9.0,
                      fontFamily: 'monospace',
                      color: color.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final section2 = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Widgets Implementing PreferredSizeWidget',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'These Flutter framework widgets implement PreferredSizeWidget '
          'directly, meaning they have a preferredSize getter built in.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 14.0),
        ...implementorCards,
      ],
    ),
  );

  print('Created ${implementorCards.length} implementor cards');

  // ============================================================
  // SECTION 3: AppBar Uses PreferredSizeWidget
  // ============================================================
  print('=== Section 3: How Scaffold Reads preferredSize ===');

  // Scaffold reads appBar.preferredSize.height to determine how much
  // vertical space to reserve above the body. The AppBar itself
  // calculates its preferredSize from toolbarHeight + bottom.preferredSize.

  // Visual: a layout diagram showing the size allocation chain

  final layoutDiagram = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.blue.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How Scaffold Reads preferredSize',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Scaffold reads appBar.preferredSize.height to determine the '
          'space allocated for the app bar region. This drives the layout.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 14.0),
        // Layout chain
        _buildLayoutBlock(
          'Scaffold',
          'Reads appBar.preferredSize.height\n→ Allocates that space at top',
          Colors.indigo,
          0,
        ),
        _buildLayoutArrow(),
        _buildLayoutBlock(
          'AppBar (PreferredSizeWidget)',
          'preferredSize = Size.fromHeight(\n  toolbarHeight + bottom.preferredSize.height\n)',
          Colors.blue,
          1,
        ),
        _buildLayoutArrow(),
        Row(
          children: [
            SizedBox(width: 24.0),
            Expanded(
              child: _buildLayoutBlock(
                'toolbarHeight',
                'Default: 56.0 dp\n(kToolbarHeight)',
                Colors.teal,
                2,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _buildLayoutBlock(
                'bottom (PreferredSizeWidget)',
                'e.g. TabBar: 46.0 dp\nor PreferredSize: custom',
                Colors.orange,
                2,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        // Calculated example
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Example Calculation:',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
              SizedBox(height: 6.0),
              _buildCalcRow('toolbarHeight', '56.0', Colors.teal),
              _buildCalcRow('+ TabBar.preferredSize.height', '46.0', Colors.orange),
              Container(
                height: 1.0,
                margin: EdgeInsets.symmetric(vertical: 4.0),
                color: Colors.grey.shade300,
              ),
              _buildCalcRow('= AppBar.preferredSize.height', '102.0', Colors.indigo),
            ],
          ),
        ),
      ],
    ),
  );

  print('Created layout diagram showing size calculation chain');

  // ============================================================
  // SECTION 4: Live AppBar Sizes
  // ============================================================
  print('=== Section 4: Live AppBar Preferred Sizes ===');

  // Show actual AppBar instances and their computed preferredSize

  final appBarSimple = AppBar(
    title: Text('Simple AppBar'),
    backgroundColor: Colors.blue.shade600,
  );

  final appBarWithTabBar = AppBar(
    title: Text('With TabBar'),
    backgroundColor: Colors.indigo.shade600,
    bottom: TabBar(
      tabs: [
        Tab(text: 'Tab 1'),
        Tab(text: 'Tab 2'),
        Tab(text: 'Tab 3'),
      ],
      controller: null,
    ),
  );

  final appBarWithPreferred = AppBar(
    title: Text('With Custom Bottom'),
    backgroundColor: Colors.teal.shade600,
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(30.0),
      child: Container(height: 30.0, color: Colors.teal.shade300),
    ),
  );

  final appBarCustomToolbar = AppBar(
    title: Text('Custom Toolbar'),
    backgroundColor: Colors.deepPurple.shade600,
    toolbarHeight: 72.0,
  );

  print('AppBar (simple) preferredSize: ${appBarSimple.preferredSize}');
  print('AppBar (TabBar bottom) preferredSize: ${appBarWithTabBar.preferredSize}');
  print('AppBar (PreferredSize 30) preferredSize: ${appBarWithPreferred.preferredSize}');
  print('AppBar (toolbar 72) preferredSize: ${appBarCustomToolbar.preferredSize}');

  final appBarSizes = [
    {'label': 'Simple AppBar', 'size': appBarSimple.preferredSize, 'color': Colors.blue},
    {'label': 'With TabBar bottom', 'size': appBarWithTabBar.preferredSize, 'color': Colors.indigo},
    {'label': 'With PreferredSize(30)', 'size': appBarWithPreferred.preferredSize, 'color': Colors.teal},
    {'label': 'Custom toolbar (72)', 'size': appBarCustomToolbar.preferredSize, 'color': Colors.deepPurple},
  ];

  final sizeCards = <Widget>[];
  for (final entry in appBarSizes) {
    final size = entry['size'] as Size;
    final color = entry['color'] as MaterialColor;
    sizeCards.add(
      Container(
        margin: EdgeInsets.only(bottom: 8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: color.shade50,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.shade200),
        ),
        child: Row(
          children: [
            // Visual height bar
            Container(
              width: 12.0,
              height: size.height * 0.6,
              decoration: BoxDecoration(
                color: color.shade400,
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry['label'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: color.shade800,
                    ),
                  ),
                  Text(
                    'preferredSize: Size(${size.width}, ${size.height})',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: 'monospace',
                      color: color.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: color.shade100,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                '${size.height.toStringAsFixed(0)} dp',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final section4 = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Live AppBar Preferred Sizes',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Actual preferredSize values from real AppBar instances. '
          'Scaffold reads these to allocate space.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 14.0),
        ...sizeCards,
      ],
    ),
  );

  print('Created ${sizeCards.length} live AppBar size cards');

  // ============================================================
  // SECTION 5: Scaffold Layout Visualization
  // ============================================================
  print('=== Section 5: Scaffold Layout Based on PreferredSize ===');

  // Visual showing how different preferredSize values affect
  // the Scaffold layout — specifically the body position

  final layoutExamples = [
    {
      'label': 'Standard (56dp)',
      'height': 56.0,
      'color': Colors.blue,
      'desc': 'Default AppBar height',
    },
    {
      'label': 'With TabBar (102dp)',
      'height': 102.0,
      'color': Colors.indigo,
      'desc': 'AppBar + TabBar',
    },
    {
      'label': 'Tall Custom (120dp)',
      'height': 120.0,
      'color': Colors.purple,
      'desc': 'Extended header area',
    },
    {
      'label': 'Compact (40dp)',
      'height': 40.0,
      'color': Colors.teal,
      'desc': 'Minimal header',
    },
  ];

  final layoutCards = <Widget>[];
  for (final ex in layoutExamples) {
    final color = ex['color'] as MaterialColor;
    final height = ex['height'] as double;
    final totalHeight = 160.0;
    final bodyHeight = totalHeight - height;

    layoutCards.add(
      Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 3.0),
          child: Column(
            children: [
              // Mini scaffold diagram
              Container(
                height: totalHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Column(
                  children: [
                    // AppBar region
                    Container(
                      height: height,
                      decoration: BoxDecoration(
                        color: color.shade400,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(7.0),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${height.toInt()}dp',
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // Body region
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(7.0),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Body\n${bodyHeight.toInt()}dp',
                          style: TextStyle(
                            fontSize: 9.0,
                            color: Colors.grey.shade600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                ex['label'] as String,
                style: TextStyle(
                  fontSize: 9.0,
                  fontWeight: FontWeight.bold,
                  color: color.shade700,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                ex['desc'] as String,
                style: TextStyle(fontSize: 8.0, color: Colors.grey.shade500),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  final section5 = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How preferredSize Affects Scaffold Layout',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Scaffold allocates space for the appBar based on preferredSize.height. '
          'The body receives the remaining vertical space.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: layoutCards,
        ),
      ],
    ),
  );

  print('Created ${layoutCards.length} scaffold layout comparisons');

  // ============================================================
  // SECTION 6: Preferred vs Actual Size
  // ============================================================
  print('=== Section 6: Preferred vs Actual Size ===');

  // Key concept: preferredSize is a HINT, not a constraint.
  // The widget can be rendered at a different size than its
  // preferred size. The parent decides how to use the hint.

  final sizeComparison = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.orange.shade50,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.orange.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preferred Size ≠ Actual Size',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.orange.shade800,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'preferredSize is a HINT — not a layout constraint. The widget '
          'can be rendered at any size the parent chooses. PreferredSizeWidget '
          'has no mechanism to enforce its preferred size.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 14.0),
        // Visual comparison
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Column(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green.shade600, size: 28.0),
                    SizedBox(height: 6.0),
                    Text(
                      'In Scaffold',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Scaffold reads preferredSize '
                      'and allocates that exact space. '
                      'Preferred = actual size.',
                      style: TextStyle(fontSize: 9.0, color: Colors.grey.shade700),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Column(
                  children: [
                    Icon(Icons.warning_amber, color: Colors.red.shade600, size: 28.0),
                    SizedBox(height: 6.0),
                    Text(
                      'In Custom Layout',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade800,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Other parents may ignore '
                      'preferredSize entirely. The '
                      'widget renders at parent size.',
                      style: TextStyle(fontSize: 9.0, color: Colors.grey.shade700),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        // Analogy
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.amber.shade300),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.amber.shade700, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Analogy: preferredSize is like a resume — '
                  'it states what the widget wants, but the employer '
                  '(parent widget) makes the final hiring decision.',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.amber.shade900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('Created preferred vs actual size comparison');

  // ============================================================
  // SECTION 7: Custom Implementation Pattern
  // ============================================================
  print('=== Section 7: Custom PreferredSizeWidget Implementation ===');

  // Developers can implement PreferredSizeWidget on their own widget
  // class. This pattern is used when you need a custom AppBar-like
  // widget that Scaffold can accept.

  final codePatterns = [
    {
      'title': 'Pattern 1: Extending StatelessWidget',
      'code': 'class CustomHeader extends StatelessWidget\n'
          '    implements PreferredSizeWidget {\n'
          '  @override\n'
          '  Size get preferredSize => Size.fromHeight(80.0);\n'
          '  @override\n'
          '  Widget build(context) => Container(...);\n'
          '}',
      'color': Colors.blue,
      'note': 'Most common pattern. Direct implementation of the interface.',
    },
    {
      'title': 'Pattern 2: Using PreferredSize Wrapper',
      'code': 'Scaffold(\n'
          '  appBar: PreferredSize(\n'
          '    preferredSize: Size.fromHeight(80.0),\n'
          '    child: MyCustomWidget(),\n'
          '  ),\n'
          ')',
      'color': Colors.teal,
      'note': 'Quick wrapper. No need to implement the interface yourself.',
    },
    {
      'title': 'Pattern 3: Dynamic PreferredSize',
      'code': 'class FlexHeader extends StatefulWidget\n'
          '    implements PreferredSizeWidget {\n'
          '  final double height;\n'
          '  FlexHeader({this.height = 60.0});\n'
          '  @override\n'
          '  Size get preferredSize => Size.fromHeight(height);\n'
          '}',
      'color': Colors.purple,
      'note': 'Height from constructor. Changes require rebuilding Scaffold.',
    },
  ];

  final patternWidgets = <Widget>[];
  for (final pattern in codePatterns) {
    final color = pattern['color'] as MaterialColor;
    patternWidgets.add(
      Container(
        margin: EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: color.shade50,
                borderRadius: BorderRadius.vertical(top: Radius.circular(11.0)),
              ),
              child: Row(
                children: [
                  Icon(Icons.code, color: color.shade600, size: 18.0),
                  SizedBox(width: 8.0),
                  Text(
                    pattern['title'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: color.shade800,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.0),
              color: Color(0xFF263238),
              child: Text(
                pattern['code'] as String,
                style: TextStyle(
                  fontSize: 10.0,
                  fontFamily: 'monospace',
                  color: Colors.greenAccent.shade200,
                  height: 1.4,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(11.0)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, color: Colors.grey.shade500, size: 14.0),
                  SizedBox(width: 6.0),
                  Expanded(
                    child: Text(
                      pattern['note'] as String,
                      style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final section7 = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Custom PreferredSizeWidget Implementation',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Three common patterns for creating widgets that satisfy '
          'the PreferredSizeWidget interface.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 14.0),
        ...patternWidgets,
      ],
    ),
  );

  print('Created ${patternWidgets.length} implementation pattern cards');

  // ============================================================
  // SECTION 8: TabBar as PreferredSizeWidget
  // ============================================================
  print('=== Section 8: TabBar — Native PreferredSizeWidget ===');

  // TabBar implements PreferredSizeWidget directly, which means it
  // can be used directly as AppBar.bottom without wrapping it in
  // PreferredSize. This is a common point of confusion.

  final tabBar = TabBar(
    tabs: [
      Tab(text: 'Home', icon: Icon(Icons.home, size: 16.0)),
      Tab(text: 'Search', icon: Icon(Icons.search, size: 16.0)),
      Tab(text: 'Profile', icon: Icon(Icons.person, size: 16.0)),
    ],
    controller: null,
  );

  print('TabBar preferredSize: ${tabBar.preferredSize}');

  final tabBarSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.indigo.shade50,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TabBar: A Native PreferredSizeWidget',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade800,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'TabBar implements PreferredSizeWidget directly. It does NOT '
          'need to be wrapped in PreferredSize when used as AppBar.bottom.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 14.0),
        // Correct usage
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 18.0),
                  SizedBox(width: 6.0),
                  Text(
                    'Correct — TabBar directly',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.0),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xFF263238),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'AppBar(\n  bottom: TabBar(tabs: [...]),  // Works directly!\n)',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontFamily: 'monospace',
                    color: Colors.greenAccent.shade200,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        // Unnecessary wrapping
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.orange.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.warning_amber, color: Colors.orange, size: 18.0),
                  SizedBox(width: 6.0),
                  Text(
                    'Unnecessary — redundant wrapper',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.0),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xFF263238),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'AppBar(\n  bottom: PreferredSize(          // Unnecessary!\n    preferredSize: Size.fromHeight(46),\n    child: TabBar(tabs: [...]),\n  ),\n)',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontFamily: 'monospace',
                    color: Colors.orangeAccent.shade100,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        // Size info
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.indigo.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.straighten, color: Colors.indigo.shade700, size: 18.0),
              SizedBox(width: 8.0),
              Text(
                'TabBar.preferredSize = ${tabBar.preferredSize}',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  color: Colors.indigo.shade800,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('Created TabBar PreferredSizeWidget section');

  // ============================================================
  // SECTION 9: Inheritance Chain Visualization
  // ============================================================
  print('=== Section 9: Type Hierarchy ===');

  final hierarchy = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.deepPurple.shade50,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.deepPurple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PreferredSizeWidget in the Type Hierarchy',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade800,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'PreferredSizeWidget is declared as: '
          'abstract class PreferredSizeWidget implements Widget. '
          'It narrows the Widget interface with one additional getter.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 14.0),
        // Type tree
        _buildTypeNode('Widget', 'Base class for all Flutter widgets', Colors.grey, 0),
        _buildTypeConnector(1),
        _buildTypeNode(
          'PreferredSizeWidget',
          'Widget + Size get preferredSize',
          Colors.deepPurple,
          1,
        ),
        _buildTypeConnector(2),
        Row(
          children: [
            SizedBox(width: 40.0),
            Expanded(
              child: _buildTypeNode(
                'AppBar',
                'Material app bar\npreferredSize from toolbar + bottom',
                Colors.blue,
                2,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Row(
          children: [
            SizedBox(width: 40.0),
            Expanded(
              child: _buildTypeNode(
                'TabBar',
                'Tab navigation bar\npreferredSize from tab height',
                Colors.indigo,
                2,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Row(
          children: [
            SizedBox(width: 40.0),
            Expanded(
              child: _buildTypeNode(
                'PreferredSize',
                'Generic wrapper\npreferredSize from constructor',
                Colors.teal,
                2,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Row(
          children: [
            SizedBox(width: 40.0),
            Expanded(
              child: _buildTypeNode(
                'YourCustomWidget',
                'Your widget class implementing\nPreferredSizeWidget',
                Colors.orange,
                2,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  print('Created type hierarchy visualization');

  // ============================================================
  // ASSEMBLY
  // ============================================================
  print('=== Assembling PreferredSizeWidget Deep Demo ===');

  final result = SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title
        Container(
          margin: EdgeInsets.all(16.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color(0xFF4A148C),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Column(
            children: [
              Text(
                'PreferredSizeWidget Deep Demo',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'The interface for sizing AppBar • TabBar • Custom headers',
                style: TextStyle(fontSize: 11.0, color: Colors.white60),
              ),
            ],
          ),
        ),
        conceptCard,
        section2,
        layoutDiagram,
        section4,
        section5,
        sizeComparison,
        section7,
        tabBarSection,
        hierarchy,
        SizedBox(height: 30.0),
      ],
    ),
  );

  print('PreferredSizeWidget Deep Demo complete: 9 sections');
  return result;
}

// ========================================================================
// Helper Functions
// ========================================================================

Widget _buildLayoutBlock(String title, String content, MaterialColor color, int depth) {
  return Container(
    margin: EdgeInsets.only(left: depth * 12.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: color.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          content,
          style: TextStyle(
            fontSize: 9.0,
            fontFamily: 'monospace',
            color: color.shade600,
          ),
        ),
      ],
    ),
  );
}

Widget _buildLayoutArrow() {
  return Container(
    height: 18.0,
    alignment: Alignment.center,
    child: Icon(Icons.arrow_downward, size: 14.0, color: Colors.grey.shade400),
  );
}

Widget _buildCalcRow(String label, String value, MaterialColor color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10.0,
              fontFamily: 'monospace',
              color: color.shade700,
            ),
          ),
        ),
        Text(
          '$value dp',
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
            color: color.shade800,
          ),
        ),
      ],
    ),
  );
}

Widget _buildTypeNode(String name, String desc, MaterialColor color, int depth) {
  return Container(
    margin: EdgeInsets.only(left: depth * 20.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.shade300),
    ),
    child: Row(
      children: [
        Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: color.shade600,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: color.shade800,
              ),
            ),
            Text(
              desc,
              style: TextStyle(fontSize: 9.0, color: Colors.grey.shade600),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildTypeConnector(int depth) {
  return Container(
    margin: EdgeInsets.only(left: depth * 20.0 + 3.0),
    height: 12.0,
    width: 2.0,
    color: Colors.grey.shade400,
  );
}
