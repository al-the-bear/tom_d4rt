// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — PrimaryScrollController widget
// Demonstrates PrimaryScrollController: an InheritedWidget that associates
// a ScrollController with a subtree. Widgets like ListView and CustomScrollView
// automatically attach to the primary ScrollController when no explicit
// controller is provided and when the scroll direction is vertical.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PrimaryScrollController Deep Demo executing');

  // ============================================================
  // SECTION 1: What Is PrimaryScrollController?
  // ============================================================
  // PrimaryScrollController is an InheritedWidget that provides a
  // ScrollController to descendant scrollable widgets. When a
  // ListView, GridView, or CustomScrollView has `primary: true`
  // (the default for vertical scrolling) and no explicit controller,
  // it automatically uses the PrimaryScrollController from the
  // nearest ancestor.
  //
  // The Scaffold already installs a PrimaryScrollController, which
  // is why scroll-to-top works when tapping the status bar on iOS.
  // You can provide your own to gain programmatic scroll control
  // without threading a controller through the widget tree.
  print('=== Section 1: PrimaryScrollController Basics ===');

  // ScrollController that we track for position display
  final controller1 = ScrollController();

  final basicExample = SizedBox(
    height: 300.0,
    child: PrimaryScrollController(
      controller: controller1,
      child: Column(
        children: [
          // Header showing what we are demonstrating
          Container(
            color: Colors.indigo.shade700,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              children: [
                Icon(Icons.swap_vert, color: Colors.white, size: 20.0),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    'PrimaryScrollController provides controller',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // The list below automatically uses the primary controller
          Expanded(
            child: ListView.builder(
              // primary defaults to true for vertical, will pick up
              // the PrimaryScrollController automatically
              itemCount: 30,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 10.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.indigo.shade100),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32.0,
                        height: 32.0,
                        decoration: BoxDecoration(
                          color: Colors.indigo.shade100,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                            color: Colors.indigo.shade700,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.0),
                      Text(
                        'Item ${index + 1} — using primary controller',
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey.shade800,
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
    ),
  );

  print('Created basic PrimaryScrollController example');

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
            Icon(Icons.swap_vert, color: Colors.indigo, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'PrimaryScrollController Basics',
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
            'PrimaryScrollController is an InheritedWidget that provides '
            'a ScrollController to descendant scrollables. When a '
            'ListView or CustomScrollView with primary=true has no '
            'explicit controller, it uses the primary controller '
            'from the widget tree.',
            style: TextStyle(fontSize: 12.0, color: Colors.indigo.shade700),
          ),
        ),
        SizedBox(height: 16.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: basicExample,
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'How it works:\n'
            '  PrimaryScrollController(\n'
            '    controller: myController,\n'
            '    child: ListView(...), // picks up myController\n'
            '  )\n\n'
            '  // Or read it from context:\n'
            '  PrimaryScrollController.of(context)',
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
  // SECTION 2: Scroll-to-Top and Scroll-to-Bottom Buttons
  // ============================================================
  print('=== Section 2: Programmatic Scroll Control ===');

  // Demonstrates using the primary controller to jump or animate
  // to specific positions in the scroll view
  final controllerForButtons = ScrollController();

  final scrollButtonExample = SizedBox(
    height: 320.0,
    child: PrimaryScrollController(
      controller: controllerForButtons,
      child: Builder(
        builder: (innerContext) {
          return Column(
            children: [
              // Control bar with scroll buttons
              Container(
                color: Colors.teal.shade700,
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildScrollButton(
                      'Top',
                      Icons.vertical_align_top,
                      Colors.white,
                      () {
                        controllerForButtons.animateTo(
                          0.0,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeOut,
                        );
                      },
                    ),
                    _buildScrollButton(
                      'Middle',
                      Icons.vertical_align_center,
                      Colors.teal.shade200,
                      () {
                        final maxScroll = controllerForButtons.position.maxScrollExtent;
                        controllerForButtons.animateTo(
                          maxScroll / 2,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                    _buildScrollButton(
                      'Bottom',
                      Icons.vertical_align_bottom,
                      Colors.teal.shade200,
                      () {
                        controllerForButtons.animateTo(
                          controllerForButtons.position.maxScrollExtent,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeOut,
                        );
                      },
                    ),
                  ],
                ),
              ),
              // Scrollable list
              Expanded(
                child: ListView.builder(
                  itemCount: 40,
                  itemBuilder: (context, index) {
                    final isHighlight = index == 0 || index == 19 || index == 39;
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 10.0,
                      ),
                      color: isHighlight
                          ? Colors.teal.shade50
                          : Colors.white,
                      child: Row(
                        children: [
                          if (isHighlight)
                            Icon(
                              Icons.bookmark,
                              size: 18.0,
                              color: Colors.teal.shade600,
                            )
                          else
                            Icon(
                              Icons.circle,
                              size: 6.0,
                              color: Colors.grey.shade400,
                            ),
                          SizedBox(width: 12.0),
                          Text(
                            isHighlight
                                ? 'Bookmark: item ${index + 1}'
                                : 'Item ${index + 1}',
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: isHighlight
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isHighlight
                                  ? Colors.teal.shade800
                                  : Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    ),
  );

  print('Created scroll-to-position example with animated buttons');

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
            Icon(Icons.touch_app, color: Colors.teal, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Programmatic Scroll Control',
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
          'The primary controller lets ancestor widgets control the '
          'scroll position of a descendant ListView. Jump to top, '
          'bottom, or any offset — great for "scroll to top" FABs, '
          'anchor links, or index navigation.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: scrollButtonExample,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Multiple Scrollables — Which Gets Primary?
  // ============================================================
  print('=== Section 3: Primary Selection Rules ===');

  // Demonstrate that only ONE scrollable can be primary.
  // When multiple ListViews exist, only the one marked primary: true
  // (or the first vertical one, by default) uses the primary controller.
  final primaryRulesVisual = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.orange.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.orange.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Primary Selection Rules:',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.orange.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        _buildRuleRow(
          '1',
          'Vertical ScrollView with no controller → primary: true (default)',
          Colors.green,
          true,
        ),
        SizedBox(height: 8.0),
        _buildRuleRow(
          '2',
          'Horizontal ScrollView → primary: false (default)',
          Colors.red,
          false,
        ),
        SizedBox(height: 8.0),
        _buildRuleRow(
          '3',
          'ScrollView with explicit controller → primary: false',
          Colors.red,
          false,
        ),
        SizedBox(height: 8.0),
        _buildRuleRow(
          '4',
          'ScrollView with primary: true → uses PrimaryScrollController',
          Colors.green,
          true,
        ),
        SizedBox(height: 8.0),
        _buildRuleRow(
          '5',
          'Multiple primary: true in same subtree → assertion error!',
          Colors.red,
          false,
        ),
      ],
    ),
  );

  // Side-by-side: one vertical (primary) and one horizontal (not primary)
  final sideBySide = Row(
    children: [
      Expanded(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, size: 14.0, color: Colors.green.shade700),
                  SizedBox(width: 4.0),
                  Text(
                    'Vertical = primary',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 140.0,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10.0),
                ),
                child: ListView.builder(
                  itemCount: 15,
                  itemBuilder: (context, i) => Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.green.shade100),
                      ),
                    ),
                    child: Text(
                      'Vertical ${i + 1}',
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(width: 12.0),
      Expanded(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cancel, size: 14.0, color: Colors.orange.shade700),
                  SizedBox(width: 4.0),
                  Text(
                    'Horizontal ≠ primary',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade800,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 140.0,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10.0),
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 15,
                  itemBuilder: (context, i) => Container(
                    width: 80.0,
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'H${i + 1}',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  print('Created primary selection rules visual');

  final section3 = Container(
    margin: EdgeInsets.all(16.0),
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
            Icon(Icons.rule, color: Colors.orange.shade700, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Primary Selection Rules',
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
          'Only one scrollable per subtree can be primary. Vertical '
          'scroll views default to primary: true. Horizontal ones '
          'are primary: false. Having two primary: true in the same '
          'subtree causes an assertion error.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.0),
        primaryRulesVisual,
        SizedBox(height: 16.0),
        sideBySide,
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Nested Scroll Views
  // ============================================================
  print('=== Section 4: Nested Scroll Views ===');

  // When you nest scrollables, inner ones should set primary: false
  // to avoid conflicting with the outer PrimaryScrollController.
  final nestedExample = SizedBox(
    height: 320.0,
    child: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.deepPurple.shade700,
            child: Text(
              'Outer CustomScrollView (primary)',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.all(12.0),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.deepPurple.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nested horizontal list (primary: false)',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.deepPurple.shade700,
                  ),
                ),
                SizedBox(height: 8.0),
                SizedBox(
                  height: 70.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    primary: false,
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      final colors = [
                        Colors.deepPurple, Colors.indigo, Colors.blue,
                        Colors.teal, Colors.green, Colors.amber,
                      ];
                      final c = colors[index % colors.length];
                      return Container(
                        width: 70.0,
                        margin: EdgeInsets.only(right: 8.0),
                        decoration: BoxDecoration(
                          color: c.shade100,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.image, color: c.shade600, size: 22.0),
                            Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontSize: 10.0,
                                color: c.shade700,
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
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.deepPurple.shade100,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 28.0,
                      height: 28.0,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade100,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple.shade700,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.0),
                    Text(
                      'Outer sliver item ${index + 1}',
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              );
            },
            childCount: 20,
          ),
        ),
      ],
    ),
  );

  print('Created nested scroll views example');

  final section4 = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
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
            Icon(Icons.layers, color: Colors.deepPurple, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Nested Scroll Views',
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
          'When nesting scrollables, inner ones must set primary: false '
          'to avoid conflicting with the outer PrimaryScrollController. '
          'The outer view owns the primary controller; inner views use '
          'their own or no controller.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: nestedExample,
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Important: If an inner scrollable has primary: true, '
            'it will try to attach to the PrimaryScrollController, '
            'causing conflicts. Always set primary: false or provide '
            'an explicit controller for nested scrollables.',
            style: TextStyle(fontSize: 11.0, color: Colors.deepPurple.shade700),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Scaffold Integration
  // ============================================================
  print('=== Section 5: Scaffold Integration ===');

  // Scaffold automatically installs a PrimaryScrollController.
  // On iOS, tapping the status bar triggers scrollToTop on the
  // primary scroll controller.
  final scaffoldExample = SizedBox(
    height: 300.0,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade700,
          title: Text(
            'Scaffold with Primary Controller',
            style: TextStyle(color: Colors.white, fontSize: 14.0),
          ),
        ),
        body: ListView.builder(
          // This list automatically uses the Scaffold's
          // PrimaryScrollController because:
          // 1. It scrolls vertically (default)
          // 2. No explicit controller is provided
          // 3. primary defaults to true
          itemCount: 30,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              decoration: BoxDecoration(
                color: index % 2 == 0
                    ? Colors.white
                    : Colors.green.shade50,
                border: Border(
                  bottom: BorderSide(color: Colors.green.shade100),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 8.0,
                    color: Colors.green.shade400,
                  ),
                  SizedBox(width: 12.0),
                  Text(
                    'Auto-primary item ${index + 1}',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'via Scaffold',
                    style: TextStyle(
                      fontSize: 9.0,
                      color: Colors.green.shade400,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ),
  );

  print('Created Scaffold integration example');

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
            Icon(Icons.phone_android, color: Colors.green.shade700, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Scaffold Integration',
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
          'Scaffold automatically installs a PrimaryScrollController. '
          'On iOS, tapping the status bar scrolls the primary '
          'scrollable back to the top. This works out of the box '
          'with no configuration needed.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.0),
        scaffoldExample,
        SizedBox(height: 12.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Scaffold provides PrimaryScrollController:',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                '• iOS status bar tap → scrolls to top\n'
                '• No explicit controller needed in the ListView\n'
                '• primary: true is default for vertical scroll\n'
                '• Override with your own PrimaryScrollController',
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: PrimaryScrollController.of(context)
  // ============================================================
  print('=== Section 6: Accessing via .of(context) ===');

  final ofContextVisual = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.cyan.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.cyan.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Accessing the Primary Controller',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.cyan.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Get the controller (throws if none):\n'
            'final ctrl = PrimaryScrollController.of(context);\n\n'
            '// Get controller or null:\n'
            'final ctrl = PrimaryScrollController.maybeOf(context);\n\n'
            '// Jump to position:\n'
            'ctrl.jumpTo(0.0);\n\n'
            '// Animate to position:\n'
            'ctrl.animateTo(500.0, ...);',
            style: TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: Colors.cyan.shade800,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            _buildApiCard(
              '.of(context)',
              'Returns controller\nor throws',
              Colors.cyan,
              Icons.search,
            ),
            SizedBox(width: 8.0),
            _buildApiCard(
              '.maybeOf(context)',
              'Returns controller\nor null',
              Colors.teal,
              Icons.help_outline,
            ),
            SizedBox(width: 8.0),
            _buildApiCard(
              '.none()',
              'Removes primary\nfrom subtree',
              Colors.red,
              Icons.block,
            ),
          ],
        ),
      ],
    ),
  );

  print('Created .of(context) API visual');

  final section6 = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.cyan.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade700, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'API: .of(context) & .none()',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'PrimaryScrollController provides static methods to access '
          'the controller from any descendant. Use .of() when you '
          'expect one to exist, .maybeOf() to check safely, and '
          '.none() to explicitly remove the primary controller.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.0),
        ofContextVisual,
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
              colors: [Colors.blue.shade900, Colors.blue.shade600],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PrimaryScrollController',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'InheritedWidget that provides a ScrollController to '
                'descendant scrollables. Enables programmatic scroll '
                'control and iOS status-bar scroll-to-top.',
                style: TextStyle(fontSize: 13.0, color: Colors.blue.shade100),
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
        SizedBox(height: 32.0),
      ],
    ),
  );
}

// ========================================================================
// Helper Functions
// ========================================================================

Widget _buildScrollButton(
  String label,
  IconData icon,
  Color color,
  VoidCallback onTap,
) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8.0),
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
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildRuleRow(String num, String text, MaterialColor color, bool check) {
  return Row(
    children: [
      Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          color: color.shade100,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          num,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: color.shade800,
          ),
        ),
      ),
      SizedBox(width: 10.0),
      Icon(
        check ? Icons.check_circle : Icons.cancel,
        size: 16.0,
        color: color.shade600,
      ),
      SizedBox(width: 6.0),
      Expanded(
        child: Text(
          text,
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade800),
        ),
      ),
    ],
  );
}

Widget _buildApiCard(String title, String desc, MaterialColor color, IconData icon) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.shade200),
      ),
      child: Column(
        children: [
          Icon(icon, color: color.shade600, size: 22.0),
          SizedBox(height: 4.0),
          Text(
            title,
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: color.shade800,
            ),
          ),
          SizedBox(height: 2.0),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8.0,
              color: color.shade600,
            ),
          ),
        ],
      ),
    ),
  );
}
