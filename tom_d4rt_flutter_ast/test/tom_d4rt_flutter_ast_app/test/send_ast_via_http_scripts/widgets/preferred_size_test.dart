// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, sized_box_for_whitespace
// D4rt test script: Deep Demo — PreferredSize widget
// Demonstrates PreferredSize: a widget that has a preferred size but
// imposes no constraints on its child. Commonly used with AppBar.bottom
// to provide TabBars, search bars, or any custom bottom widget with
// a known preferred height.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PreferredSize Deep Demo executing');

  // ============================================================
  // SECTION 1: What Is PreferredSize?
  // ============================================================
  // PreferredSize wraps a child widget and reports a specific
  // preferred size via the PreferredSizeWidget interface. The
  // widget itself does NOT constrain or size its child — it merely
  // communicates a preferred size to parent widgets that ask for it,
  // such as Scaffold when computing the total AppBar height.
  //
  // The most common use case: AppBar.bottom expects a
  // PreferredSizeWidget. TabBar already implements this interface,
  // but for custom widgets (search bars, filter chips, progress
  // indicators), you wrap them in PreferredSize.
  print('=== Section 1: PreferredSize Basics ===');

  // A simple AppBar with PreferredSize bottom widget
  final basicAppBar = AppBar(
    backgroundColor: Colors.indigo.shade700,
    title: Text(
      'Basic AppBar',
      style: TextStyle(color: Colors.white, fontSize: 16.0),
    ),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(48.0),
      child: Container(
        height: 48.0,
        color: Colors.indigo.shade500,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.white70, size: 18.0),
            SizedBox(width: 8.0),
            Text(
              'This bottom area uses PreferredSize',
              style: TextStyle(
                fontSize: 13.0,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    ),
  );

  print('Created basic AppBar with PreferredSize bottom');

  final section1 = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.height, color: Colors.indigo, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'PreferredSize Basics',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'PreferredSize wraps a widget and reports a preferred size '
            'to parent widgets. It does NOT constrain its child — the '
            'child must size itself. This is used primarily for '
            'AppBar.bottom, which requires a PreferredSizeWidget.',
            style: TextStyle(fontSize: 12.0, color: Colors.indigo.shade700),
          ),
        ),
        SizedBox(height: 16.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: SizedBox(
            height: 110.0,
            child: Scaffold(
              appBar: basicAppBar,
              body: Container(color: Colors.grey.shade100),
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Usage:\n'
            '  AppBar(\n'
            '    bottom: PreferredSize(\n'
            '      preferredSize: Size.fromHeight(48.0),\n'
            '      child: MyCustomWidget(),\n'
            '    ),\n'
            '  )',
            style: TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: Colors.grey.shade800,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Search Bar as AppBar Bottom
  // ============================================================
  print('=== Section 2: Search Bar Bottom ===');

  final searchAppBar = AppBar(
    backgroundColor: Colors.teal.shade700,
    title: Text(
      'Contacts',
      style: TextStyle(color: Colors.white, fontSize: 16.0),
    ),
    actions: [
      Icon(Icons.more_vert, color: Colors.white, size: 22.0),
      SizedBox(width: 8.0),
    ],
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(56.0),
      child: Container(
        height: 56.0,
        padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              Icon(Icons.search, color: Colors.white70, size: 20.0),
              SizedBox(width: 8.0),
              Text(
                'Search contacts...',
                style: TextStyle(fontSize: 14.0, color: Colors.white60),
              ),
              Spacer(),
              Icon(Icons.mic, color: Colors.white70, size: 20.0),
            ],
          ),
        ),
      ),
    ),
  );

  print('Created search bar AppBar bottom');

  final section2 = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.teal.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.search, color: Colors.teal, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Search Bar Bottom',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'A common pattern: placing a search field below the AppBar '
          'title using PreferredSize. The search bar stays attached '
          'to the AppBar and scrolls away with it (or stays if pinned).',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: SizedBox(
            height: 120.0,
            child: Scaffold(
              appBar: searchAppBar,
              body: Container(color: Colors.grey.shade100),
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Filter Chips as AppBar Bottom
  // ============================================================
  print('=== Section 3: Filter Chips Bottom ===');

  final chipLabels = ['All', 'Photos', 'Videos', 'Audio', 'Docs'];

  final chipWidgets = <Widget>[];
  for (var i = 0; i < chipLabels.length; i++) {
    final isSelected = i == 0;
    chipWidgets.add(
      Container(
        margin: EdgeInsets.only(right: 8.0),
        padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white
              : Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          chipLabels[i],
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected
                ? Colors.deepPurple.shade700
                : Colors.white,
          ),
        ),
      ),
    );
  }

  final filterChipAppBar = AppBar(
    backgroundColor: Colors.deepPurple.shade700,
    title: Text(
      'Media Library',
      style: TextStyle(color: Colors.white, fontSize: 16.0),
    ),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(44.0),
      child: Container(
        height: 44.0,
        padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: chipWidgets),
        ),
      ),
    ),
  );

  print('Created filter chip AppBar bottom with ${chipLabels.length} chips');

  final section3 = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepPurple.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.filter_list, color: Colors.deepPurple, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Filter Chips Bottom',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'Horizontally scrollable filter chips work great as an AppBar '
          'bottom widget. PreferredSize tells the Scaffold exactly how '
          'much extra space the chip row needs below the title.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: SizedBox(
            height: 110.0,
            child: Scaffold(
              appBar: filterChipAppBar,
              body: Container(color: Colors.grey.shade100),
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Progress Indicator Bottom
  // ============================================================
  print('=== Section 4: Progress Indicator Bottom ===');

  final progressAppBar = AppBar(
    backgroundColor: Colors.orange.shade700,
    title: Text(
      'Uploading Files',
      style: TextStyle(color: Colors.white, fontSize: 16.0),
    ),
    actions: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          '3 of 8',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      SizedBox(width: 12.0),
    ],
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(6.0),
      child: LinearProgressIndicator(
        value: 0.375,
        backgroundColor: Colors.orange.shade900,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        minHeight: 6.0,
      ),
    ),
  );

  // Indeterminate progress bar
  final loadingAppBar = AppBar(
    backgroundColor: Colors.blue.shade700,
    title: Text(
      'Loading Data',
      style: TextStyle(color: Colors.white, fontSize: 16.0),
    ),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(4.0),
      child: LinearProgressIndicator(
        backgroundColor: Colors.blue.shade900,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
        minHeight: 4.0,
      ),
    ),
  );

  print('Created progress indicator AppBar bottoms');

  final section4 = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.orange.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.linear_scale, color: Colors.orange, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Progress Indicator Bottom',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'A thin progress bar below the AppBar is one of the simplest '
          'uses of PreferredSize. It can show determinate progress '
          '(upload %) or indeterminate loading.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.0),
        Text(
          'Determinate (37.5%):',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w600,
            color: Colors.orange.shade700,
          ),
        ),
        SizedBox(height: 6.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: SizedBox(
            height: 70.0,
            child: Scaffold(
              appBar: progressAppBar,
              body: Container(color: Colors.grey.shade100),
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Text(
          'Indeterminate (loading):',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w600,
            color: Colors.blue.shade700,
          ),
        ),
        SizedBox(height: 6.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: SizedBox(
            height: 70.0,
            child: Scaffold(
              appBar: loadingAppBar,
              body: Container(color: Colors.grey.shade100),
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Multi-Row Bottom with Tabs + Info
  // ============================================================
  print('=== Section 5: Multi-Row Bottom ===');

  // Combining tabs and an info strip in a single PreferredSize
  final multiRowAppBar = AppBar(
    backgroundColor: Colors.green.shade700,
    title: Text(
      'Project Dashboard',
      style: TextStyle(color: Colors.white, fontSize: 16.0),
    ),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(88.0),
      child: Column(
        children: [
          // Tab row
          Container(
            height: 44.0,
            child: Row(
              children: [
                _buildBottomTab('Overview', Icons.dashboard, true, Colors.white),
                _buildBottomTab('Tasks', Icons.task_alt, false, Colors.white70),
                _buildBottomTab('Files', Icons.folder, false, Colors.white70),
                _buildBottomTab('Team', Icons.group, false, Colors.white70),
              ],
            ),
          ),
          // Info strip
          Container(
            height: 44.0,
            color: Colors.green.shade800,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoChip('Sprint 14', Icons.speed),
                _buildInfoChip('Day 3/10', Icons.calendar_today),
                _buildInfoChip('78% done', Icons.pie_chart),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  print('Created multi-row bottom with tabs and info strip');

  final section5 = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.green.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.view_stream, color: Colors.green.shade700, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Multi-Row Bottom',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'PreferredSize can wrap a Column with multiple rows. Set '
          'the preferredSize to the total height of all rows combined. '
          'This enables tabs + info bars, tabs + search, or any '
          'multi-layer bottom layout in a single PreferredSize.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: SizedBox(
            height: 150.0,
            child: Scaffold(
              appBar: multiRowAppBar,
              body: Container(color: Colors.grey.shade100),
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Tip: The preferredSize height must match the total '
            'height of the child Column. If it is too small, the '
            'AppBar will be shorter than expected; too large and '
            'there will be empty space.',
            style: TextStyle(fontSize: 11.0, color: Colors.green.shade700),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Custom PreferredSize Widget Pattern
  // ============================================================
  print('=== Section 6: The PreferredSizeWidget Interface ===');

  // Show that TabBar is already a PreferredSizeWidget — no
  // wrapping needed. But custom widgets must be wrapped.
  final tabBarAppBar = AppBar(
    backgroundColor: Colors.red.shade700,
    title: Text(
      'TabBar (built-in)',
      style: TextStyle(color: Colors.white, fontSize: 14.0),
    ),
    bottom: TabBar(
      controller: null,
      tabs: [
        Tab(icon: Icon(Icons.home, size: 18.0), text: 'Home'),
        Tab(icon: Icon(Icons.star, size: 18.0), text: 'Favs'),
        Tab(icon: Icon(Icons.settings, size: 18.0), text: 'Settings'),
      ],
      indicatorColor: Colors.white,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.red.shade200,
      labelStyle: TextStyle(fontSize: 10.0),
    ),
  );

  print('Created TabBar vs PreferredSize comparison');

  final section6 = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.red.shade700, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'PreferredSizeWidget Interface',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'Some widgets already implement PreferredSizeWidget:\n'
          '• TabBar — reports its own preferred size\n'
          '• AppBar — implements PreferredSizeWidget itself\n\n'
          'For custom widgets, wrap them in PreferredSize.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.0),
        Text(
          'TabBar needs NO PreferredSize wrapper:',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w600,
            color: Colors.red.shade700,
          ),
        ),
        SizedBox(height: 8.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: SizedBox(
            height: 120.0,
            child: DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: tabBarAppBar,
                body: Container(color: Colors.grey.shade100),
              ),
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'When to use PreferredSize:',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                '• Custom search bars → wrap in PreferredSize\n'
                '• Filter chip rows → wrap in PreferredSize\n'
                '• Progress bars → wrap in PreferredSize\n'
                '• TabBar → already PreferredSizeWidget, no wrap\n'
                '• Custom StatefulWidget → implement PreferredSizeWidget',
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Varying Heights Showcase
  // ============================================================
  print('=== Section 7: Different Heights ===');

  // Show how different preferredSize heights affect the AppBar layout
  final heights = <Map<String, dynamic>>[
    {'height': 4.0, 'label': '4dp — thin line', 'color': Colors.blue},
    {'height': 24.0, 'label': '24dp — compact', 'color': Colors.green},
    {'height': 48.0, 'label': '48dp — standard', 'color': Colors.orange},
    {'height': 80.0, 'label': '80dp — expanded', 'color': Colors.purple},
  ];

  final heightShowcase = <Widget>[];
  for (final entry in heights) {
    final h = entry['height'] as double;
    final color = entry['color'] as MaterialColor;
    heightShowcase.add(
      Padding(
        padding: EdgeInsets.only(bottom: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entry['label'] as String,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
                color: color.shade700,
              ),
            ),
            SizedBox(height: 4.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: SizedBox(
                height: 56.0 + h + 4.0,
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: color.shade600,
                    toolbarHeight: 40.0,
                    title: Text(
                      'Title',
                      style: TextStyle(color: Colors.white, fontSize: 13.0),
                    ),
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(h),
                      child: Container(
                        height: h,
                        color: color.shade300,
                        alignment: Alignment.center,
                        child: h >= 24.0
                            ? Text(
                                '${h.toInt()} dp',
                                style: TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold,
                                  color: color.shade900,
                                ),
                              )
                            : SizedBox.shrink(),
                      ),
                    ),
                  ),
                  body: Container(color: Colors.grey.shade50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('Created ${heights.length} height variation samples');

  final section7 = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.straighten, color: Colors.deepPurple, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Height Variations',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'The preferredSize height directly affects how much space '
          'the Scaffold allocates below the AppBar title. From a 4dp '
          'divider line to an 80dp expanded area — the height is '
          'entirely up to you.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.0),
        ...heightShowcase,
      ],
    ),
  );

  // ============================================================
  // Final Assembly
  // ============================================================
  print('=== Assembling final layout ===');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title bar
        Container(
          padding: EdgeInsets.fromLTRB(20.0, 48.0, 20.0, 20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade800, Colors.deepPurple.shade500],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PreferredSize',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'Wraps a widget and reports a preferred size via the '
                'PreferredSizeWidget interface. Used for AppBar.bottom '
                '(search bars, filter chips, progress indicators).',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.deepPurple.shade100,
                ),
              ),
            ],
          ),
        ),
        section1,
        SizedBox(height: 8.0),
        section2,
        SizedBox(height: 8.0),
        section3,
        SizedBox(height: 8.0),
        section4,
        SizedBox(height: 8.0),
        section5,
        SizedBox(height: 8.0),
        section6,
        SizedBox(height: 8.0),
        section7,
        SizedBox(height: 32.0),
      ],
    ),
  );
}

// ========================================================================
// Helper Functions
// ========================================================================

Widget _buildBottomTab(String label, IconData icon, bool active, Color color) {
  return Expanded(
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: active ? Colors.white : Colors.transparent,
            width: 2.0,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16.0),
          SizedBox(width: 4.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: active ? FontWeight.bold : FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildInfoChip(String label, IconData icon) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, color: Colors.white60, size: 14.0),
      SizedBox(width: 4.0),
      Text(
        label,
        style: TextStyle(
          fontSize: 10.0,
          color: Colors.white70,
        ),
      ),
    ],
  );
}
