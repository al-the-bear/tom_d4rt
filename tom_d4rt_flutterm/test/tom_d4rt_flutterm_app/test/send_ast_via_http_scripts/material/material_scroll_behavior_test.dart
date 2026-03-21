// D4rt test script: Tests MaterialScrollBehavior from material
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.indigo.shade700,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

Widget buildInfoCard(String label, String value) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildColoredListItem(int index, Color color, String label) {
  return Container(
    height: 56,
    margin: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: color.withAlpha(80),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Center(
      child: Text(
        '$label #$index',
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget buildScrollableBox(
  String title,
  Color headerColor,
  Widget child,
  double height,
) {
  print('Building scrollable box: $title');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: headerColor.withAlpha(120), width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: headerColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(height: height, child: child),
      ],
    ),
  );
}

List<Widget> buildColoredItems(int count, Color baseColor, String prefix) {
  List<Widget> items = [];
  for (int i = 0; i < count; i++) {
    int alpha = 100 + ((155 * i) ~/ count);
    Color itemColor = baseColor.withAlpha(alpha);
    items.add(buildColoredListItem(i + 1, itemColor, prefix));
  }
  return items;
}

// Section 1: Basic MaterialScrollBehavior properties overview
Widget buildBasicPropertiesSection() {
  print('=== Section 1: Basic MaterialScrollBehavior Properties ===');
  MaterialScrollBehavior behavior = MaterialScrollBehavior();
  String runtimeTypeStr = behavior.runtimeType.toString();
  Set<PointerDeviceKind> devices = behavior.dragDevices;
  String devicesStr = devices.map((d) => d.toString()).join(', ');
  print('Runtime type: $runtimeTypeStr');
  print('Drag devices: $devicesStr');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader('1. Basic Properties'),
      buildInfoCard('Runtime Type:', runtimeTypeStr),
      buildInfoCard('Drag Devices:', devicesStr),
      buildInfoCard(
        'Device Count:',
        '${devices.length} device type(s) supported',
      ),
      buildInfoCard(
        'Description:',
        'MaterialScrollBehavior is the default ScrollBehavior used by '
            'MaterialApp. It configures overscroll indicators, scroll physics, '
            'scrollbar appearance, and supported drag devices.',
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.indigo.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.indigo.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Key Methods & Properties',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.indigo.shade800,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '- dragDevices: set of supported pointer device kinds',
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(height: 4),
            Text(
              '- getScrollPhysics(context): returns platform scroll physics',
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(height: 4),
            Text(
              '- buildOverscrollIndicator(): adds overscroll visual effect',
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(height: 4),
            Text(
              '- buildScrollbar(): wraps child with scrollbar widget',
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    ],
  );
}

// Section 2: ScrollConfiguration with MaterialScrollBehavior wrapping ListView
Widget buildMaterialScrollListSection() {
  print('=== Section 2: Material Scroll Behavior ListView ===');
  List<Widget> items = buildColoredItems(20, Colors.blue, 'Material');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader('2. MaterialScrollBehavior ListView'),
      buildInfoCard(
        'Demo:',
        'ListView wrapped in ScrollConfiguration using MaterialScrollBehavior. '
            'Scroll to see the Material overscroll glow effect.',
      ),
      buildScrollableBox(
        'Material Scroll Behavior - 20 items',
        Colors.blue.shade700,
        ScrollConfiguration(
          behavior: MaterialScrollBehavior(),
          child: ListView(padding: EdgeInsets.all(8), children: items),
        ),
        300,
      ),
    ],
  );
}

// Section 3: Compare ClampingScrollPhysics vs BouncingScrollPhysics
Widget buildPhysicsComparisonSection() {
  print('=== Section 3: Scroll Physics Comparison ===');
  List<Widget> clampItems = buildColoredItems(15, Colors.teal, 'Clamp');
  List<Widget> bounceItems = buildColoredItems(15, Colors.orange, 'Bounce');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader('3. Scroll Physics Comparison'),
      buildInfoCard(
        'Description:',
        'Compare ClampingScrollPhysics (Android-style) with '
            'BouncingScrollPhysics (iOS-style). Both wrapped with '
            'MaterialScrollBehavior via ScrollConfiguration.',
      ),
      Row(
        children: [
          Expanded(
            child: buildScrollableBox(
              'Clamping (Android)',
              Colors.teal.shade700,
              ScrollConfiguration(
                behavior: MaterialScrollBehavior(),
                child: ListView(
                  physics: ClampingScrollPhysics(),
                  padding: EdgeInsets.all(6),
                  children: clampItems,
                ),
              ),
              240,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: buildScrollableBox(
              'Bouncing (iOS)',
              Colors.orange.shade700,
              ScrollConfiguration(
                behavior: MaterialScrollBehavior(),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(6),
                  children: bounceItems,
                ),
              ),
              240,
            ),
          ),
        ],
      ),
    ],
  );
}

// Section 4: Material-style Scrollbar wrapping content
Widget buildScrollbarSection() {
  print('=== Section 4: Material Scrollbar Demo ===');
  ScrollController scrollCtrl = ScrollController();
  List<Widget> items = buildColoredItems(25, Colors.purple, 'Scrollbar');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader('4. Material Scrollbar'),
      buildInfoCard(
        'Demo:',
        'A Scrollbar widget wrapping a ListView. Material scrollbar '
            'appears when the user scrolls. The Scrollbar widget is what '
            'MaterialScrollBehavior.buildScrollbar() generates internally.',
      ),
      buildScrollableBox(
        'Scrollbar + ListView - 25 items',
        Colors.purple.shade700,
        Scrollbar(
          controller: scrollCtrl,
          thumbVisibility: true,
          thickness: 8,
          radius: Radius.circular(4),
          child: ListView(
            controller: scrollCtrl,
            padding: EdgeInsets.all(8),
            children: items,
          ),
        ),
        280,
      ),
    ],
  );
}

// Section 5: Nested scroll views
Widget buildNestedScrollSection() {
  print('=== Section 5: Nested Scroll Views ===');
  List<Widget> outerItems = [];
  for (int i = 0; i < 6; i++) {
    List<Widget> innerItems = buildColoredItems(
      10,
      Colors.primaries[i % Colors.primaries.length],
      'Inner',
    );
    outerItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.primaries[i % Colors.primaries.length].shade700,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Nested Group ${i + 1}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
            SizedBox(height: 4),
            SizedBox(
              height: 160,
              child: ScrollConfiguration(
                behavior: MaterialScrollBehavior(),
                child: ListView(
                  padding: EdgeInsets.all(4),
                  children: innerItems,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader('5. Nested Scroll Views'),
      buildInfoCard(
        'Demo:',
        'Outer scroll view contains inner scroll views, each with '
            'MaterialScrollBehavior. This demonstrates scroll behavior '
            'propagation and independent scrolling within nested containers.',
      ),
      buildScrollableBox(
        'Outer Scroll - 6 Nested Groups',
        Colors.brown.shade700,
        ScrollConfiguration(
          behavior: MaterialScrollBehavior(),
          child: ListView(padding: EdgeInsets.all(8), children: outerItems),
        ),
        350,
      ),
    ],
  );
}

// Section 6: Overscroll indicator comparison
Widget buildOverscrollIndicatorSection() {
  print('=== Section 6: Overscroll Indicator Comparison ===');
  List<Widget> stretchItems = buildColoredItems(12, Colors.red, 'Stretch');
  List<Widget> glowItems = buildColoredItems(12, Colors.green, 'Glow');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader('6. Overscroll Indicators'),
      buildInfoCard(
        'Stretch Indicator:',
        'StretchingOverscrollIndicator stretches the content on overscroll. '
            'Used on Android 12+.',
      ),
      buildInfoCard(
        'Glow Indicator:',
        'GlowingOverscrollIndicator shows a glow effect on edges. '
            'Used on older Android versions.',
      ),
      Row(
        children: [
          Expanded(
            child: buildScrollableBox(
              'Stretch Effect',
              Colors.red.shade700,
              ScrollConfiguration(
                behavior: MaterialScrollBehavior(),
                child: StretchingOverscrollIndicator(
                  axisDirection: AxisDirection.down,
                  child: ListView(
                    physics: ClampingScrollPhysics(),
                    padding: EdgeInsets.all(6),
                    children: stretchItems,
                  ),
                ),
              ),
              220,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: buildScrollableBox(
              'Glow Effect',
              Colors.green.shade700,
              ScrollConfiguration(
                behavior: MaterialScrollBehavior(),
                child: GlowingOverscrollIndicator(
                  axisDirection: AxisDirection.down,
                  color: Colors.green,
                  child: ListView(
                    physics: ClampingScrollPhysics(),
                    padding: EdgeInsets.all(6),
                    children: glowItems,
                  ),
                ),
              ),
              220,
            ),
          ),
        ],
      ),
    ],
  );
}

// Section 7: CustomScrollView with MaterialScrollBehavior
Widget buildCustomScrollViewSection() {
  print('=== Section 7: CustomScrollView with MaterialScrollBehavior ===');
  List<Widget> sliverItems = [];
  for (int i = 0; i < 20; i++) {
    int alpha = 100 + ((155 * i) ~/ 20);
    sliverItems.add(
      Container(
        height: 52,
        margin: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.deepOrange.withAlpha(alpha),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.deepOrange.withAlpha(40),
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Sliver Item #${i + 1}',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader('7. CustomScrollView with Slivers'),
      buildInfoCard(
        'Demo:',
        'CustomScrollView using SliverAppBar and SliverList inside '
            'a ScrollConfiguration with MaterialScrollBehavior. Shows '
            'how the scroll behavior integrates with the sliver protocol.',
      ),
      buildScrollableBox(
        'CustomScrollView - SliverAppBar + SliverList',
        Colors.deepOrange.shade700,
        ScrollConfiguration(
          behavior: MaterialScrollBehavior(),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.deepOrange.shade600,
                expandedHeight: 80,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'Sliver Header',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  background: Container(color: Colors.deepOrange.shade400),
                ),
              ),
              SliverList(delegate: SliverChildListDelegate(sliverItems)),
            ],
          ),
        ),
        320,
      ),
    ],
  );
}

// Section 8: GridView with MaterialScrollBehavior
Widget buildGridViewSection() {
  print('=== Section 8: GridView with MaterialScrollBehavior ===');
  List<Widget> gridItems = [];
  for (int i = 0; i < 24; i++) {
    Color cellColor = Colors.primaries[i % Colors.primaries.length].shade400;
    gridItems.add(
      Container(
        decoration: BoxDecoration(
          color: cellColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: cellColor.withAlpha(80),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.grid_view, color: Colors.white, size: 24),
              SizedBox(height: 4),
              Text(
                'Cell ${i + 1}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader('8. GridView with Material Scroll'),
      buildInfoCard(
        'Demo:',
        'GridView.count with 3 columns, wrapped in ScrollConfiguration '
            'using MaterialScrollBehavior. Grid items are colorful cells '
            'with icons that scroll with Material overscroll behavior.',
      ),
      buildScrollableBox(
        'GridView - 24 cells (3 columns)',
        Colors.cyan.shade700,
        ScrollConfiguration(
          behavior: MaterialScrollBehavior(),
          child: GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            padding: EdgeInsets.all(8),
            children: gridItems,
          ),
        ),
        300,
      ),
    ],
  );
}

// Section 9: PageView with Material scroll physics
Widget buildPageViewSection() {
  print('=== Section 9: PageView with Material Physics ===');
  List<Widget> pages = [];
  List<MaterialColor> pageColors = [
    Colors.indigo,
    Colors.pink,
    Colors.teal,
    Colors.amber,
    Colors.deepPurple,
  ];
  List<String> pageLabels = [
    'Welcome Page',
    'Features Page',
    'Gallery Page',
    'Settings Page',
    'Summary Page',
  ];
  for (int i = 0; i < 5; i++) {
    pages.add(
      Container(
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [pageColors[i].shade300, pageColors[i].shade700],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: pageColors[i].withAlpha(100),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.swipe, color: Colors.white, size: 48),
              SizedBox(height: 12),
              Text(
                pageLabels[i],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Page ${i + 1} of 5',
                style: TextStyle(
                  color: Colors.white.withAlpha(200),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Swipe left/right to navigate',
                style: TextStyle(
                  color: Colors.white.withAlpha(160),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader('9. PageView with Material Physics'),
      buildInfoCard(
        'Demo:',
        'PageView with 5 colorful gradient pages. MaterialScrollBehavior '
            'applies the scroll physics for smooth page transitions. '
            'Swipe horizontally to change pages.',
      ),
      buildScrollableBox(
        'PageView - 5 Swipeable Pages',
        Colors.pink.shade700,
        ScrollConfiguration(
          behavior: MaterialScrollBehavior(),
          child: PageView(children: pages),
        ),
        220,
      ),
    ],
  );
}

// Section 10: Summary comparison
Widget buildSummarySection() {
  print('=== Section 10: Summary Comparison ===');

  Widget buildComparisonRow(
    String feature,
    String material,
    String cupertino,
    Color rowColor,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: rowColor.withAlpha(30),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: rowColor.withAlpha(80)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              feature,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              material,
              style: TextStyle(fontSize: 12, color: Colors.blue.shade700),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              cupertino,
              style: TextStyle(fontSize: 12, color: Colors.orange.shade700),
            ),
          ),
        ],
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader('10. Summary Comparison'),
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                'Feature',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.grey.shade900,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'Material',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.blue.shade800,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'Cupertino',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.orange.shade800,
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 4),
      buildComparisonRow(
        'Overscroll Effect',
        'Glow / Stretch',
        'Bounce',
        Colors.blue,
      ),
      buildComparisonRow(
        'Scroll Physics',
        'ClampingScrollPhysics',
        'BouncingScrollPhysics',
        Colors.teal,
      ),
      buildComparisonRow(
        'Scrollbar Style',
        'Material Scrollbar',
        'Cupertino Scrollbar',
        Colors.purple,
      ),
      buildComparisonRow(
        'Drag Devices',
        'Touch + Stylus + Mouse',
        'Touch + Stylus + Mouse',
        Colors.amber,
      ),
      buildComparisonRow(
        'Edge Behavior',
        'Hard edge clamp',
        'Elastic overscroll',
        Colors.red,
      ),
      buildComparisonRow(
        'Platform Default',
        'Android',
        'iOS / macOS',
        Colors.green,
      ),
      SizedBox(height: 12),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo.shade50, Colors.indigo.shade100],
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.indigo.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Key Takeaways',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.indigo.shade800,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '1. MaterialScrollBehavior is automatically applied by MaterialApp',
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(height: 4),
            Text(
              '2. Use ScrollConfiguration to override scroll behavior locally',
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(height: 4),
            Text(
              '3. Overscroll indicators differ between Android versions',
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(height: 4),
            Text(
              '4. ScrollPhysics can be overridden per-widget regardless of behavior',
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(height: 4),
            Text(
              '5. Nested scroll views each get their own scroll behavior context',
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(height: 4),
            Text(
              '6. CustomScrollView, GridView, and PageView all respect MaterialScrollBehavior',
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    ],
  );
}

dynamic build(BuildContext context) {
  print('=== MaterialScrollBehavior Deep Demo ===');
  print('Building comprehensive demo of MaterialScrollBehavior');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title banner
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade800, Colors.blue.shade600],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withAlpha(100),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(Icons.swap_vert, color: Colors.white, size: 40),
              SizedBox(height: 8),
              Text(
                'MaterialScrollBehavior',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Deep Demo - Scroll Behavior in Material Design',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withAlpha(200),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // Section 1: Basic properties
        buildBasicPropertiesSection(),
        SizedBox(height: 16),

        // Section 2: Material scroll behavior ListView
        buildMaterialScrollListSection(),
        SizedBox(height: 16),

        // Section 3: Physics comparison
        buildPhysicsComparisonSection(),
        SizedBox(height: 16),

        // Section 4: Scrollbar
        buildScrollbarSection(),
        SizedBox(height: 16),

        // Section 5: Nested scroll views
        buildNestedScrollSection(),
        SizedBox(height: 16),

        // Section 6: Overscroll indicators
        buildOverscrollIndicatorSection(),
        SizedBox(height: 16),

        // Section 7: CustomScrollView
        buildCustomScrollViewSection(),
        SizedBox(height: 16),

        // Section 8: GridView
        buildGridViewSection(),
        SizedBox(height: 16),

        // Section 9: PageView
        buildPageViewSection(),
        SizedBox(height: 16),

        // Section 10: Summary
        buildSummarySection(),
        SizedBox(height: 32),

        // Footer
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'End of MaterialScrollBehavior Deep Demo',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
