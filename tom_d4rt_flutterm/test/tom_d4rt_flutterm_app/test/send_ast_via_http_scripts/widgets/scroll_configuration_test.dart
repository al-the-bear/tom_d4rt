// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — ScrollConfiguration
// Demonstrates ScrollConfiguration — the InheritedWidget that provides
// a ScrollBehavior to all scrollable descendants. It controls physics,
// scrollbar appearance, overscroll effects, and drag device support.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ScrollConfiguration Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — What is ScrollConfiguration?
  // ============================================================
  print('=== Section 1: Concept ===');

  // ScrollConfiguration wraps a subtree and provides a
  // ScrollBehavior that controls:
  //
  //   • ScrollPhysics (bouncing, clamping, never)
  //   • Scrollbar appearance and auto-visibility
  //   • Overscroll indicator type (glow vs stretch)
  //   • Which pointer devices can initiate scrolling
  //   • Platform-specific defaults
  //
  // MaterialApp wraps the entire app in a ScrollConfiguration
  // with MaterialScrollBehavior. You can override it at any
  // level in the widget tree.

  final conceptCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFF2E7D32), width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.15),
          blurRadius: 12.0,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.tune, size: 36.0, color: Color(0xFF2E7D32)),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'ScrollConfiguration',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          'An InheritedWidget that provides ScrollBehavior to all '
          'scrollable descendants. It determines how scrollables '
          'respond to user input, what scrollbars look like, and '
          'how overscroll effects are displayed.',
          style: TextStyle(fontSize: 14.0, color: Color(0xFF2E7D32)),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What ScrollBehavior controls:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Color(0xFF1B5E20),
                ),
              ),
              SizedBox(height: 8.0),
              _buildScrollConfigBullet(
                'ScrollPhysics — bounce, clamp, or none',
                Color(0xFF1565C0),
              ),
              _buildScrollConfigBullet(
                'Scrollbar auto-show and styling',
                Color(0xFF2E7D32),
              ),
              _buildScrollConfigBullet(
                'Overscroll indicator type',
                Color(0xFFE65100),
              ),
              _buildScrollConfigBullet(
                'Drag device configuration',
                Color(0xFF6A1B9A),
              ),
              _buildScrollConfigBullet(
                'Platform-specific defaults',
                Color(0xFF37474F),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Class Hierarchy
  // ============================================================
  print('=== Section 2: Class hierarchy ===');

  Widget buildHierarchyNode(
    String name,
    String role,
    Color color,
    int indent,
    IconData icon,
  ) {
    return Container(
      margin: EdgeInsets.only(
        left: indent * 20.0,
        top: 3.0,
        bottom: 3.0,
        right: 8.0,
      ),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18.0),
          SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: color,
                  ),
                ),
                Text(
                  role,
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final hierarchySection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Class Hierarchy',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'How ScrollConfiguration relates to ScrollBehavior.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
        ),
        SizedBox(height: 12.0),
        buildHierarchyNode(
          'ScrollConfiguration',
          'InheritedWidget — provides behavior to subtree',
          Color(0xFF1565C0),
          0,
          Icons.tune,
        ),
        buildHierarchyNode(
          'ScrollBehavior',
          'Base class — platform-agnostic defaults',
          Color(0xFF2E7D32),
          1,
          Icons.settings,
        ),
        buildHierarchyNode(
          'MaterialScrollBehavior',
          'Material defaults — Android glow, scrollbar style',
          Color(0xFFE65100),
          2,
          Icons.android,
        ),
        buildHierarchyNode(
          'CupertinoScrollBehavior',
          'Cupertino defaults — iOS bounce, thin scrollbar',
          Color(0xFF37474F),
          2,
          Icons.apple,
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFF9A825)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline,
                  color: Color(0xFFF9A825), size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'ScrollConfiguration.of(context) returns the '
                  'nearest ScrollBehavior. You can also call '
                  'behavior.copyWith() to modify just specific aspects.',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Color(0xFF795548),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: ScrollPhysics Comparison
  // ============================================================
  print('=== Section 3: ScrollPhysics comparison ===');

  Widget buildPhysicsDemo(
    String name,
    String description,
    Color color,
    IconData icon,
    List<String> characteristics,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9.0),
                topRight: Radius.circular(9.0),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 22.0),
                SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                          color: color,
                        ),
                      ),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Mini scroll demo
          Container(
            height: 100.0,
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: color.withValues(alpha: 0.3)),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: ScrollConfiguration(
              behavior: ScrollBehavior(),
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (ctx, i) {
                  return Container(
                    height: 28.0,
                    margin: EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(
                        alpha: 0.05 + (i % 3) * 0.05,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Center(
                      child: Text(
                        'Item $i',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: color,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: characteristics
                  .map(
                    (c) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 4.0),
                            width: 5.0,
                            height: 5.0,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 6.0),
                          Expanded(
                            child: Text(
                              c,
                              style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.grey.shade700,
                              ),
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
    );
  }

  final physicsSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ScrollPhysics via ScrollBehavior',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'ScrollBehavior.getScrollPhysics() returns the physics for a platform.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
        ),
        SizedBox(height: 12.0),
        buildPhysicsDemo(
          'BouncingScrollPhysics',
          'iOS-style overscroll with spring bounce back',
          Color(0xFF1565C0),
          Icons.arrow_upward,
          [
            'Content bounces past edge then springs back',
            'Natural feel on iOS, used by CupertinoScrollBehavior',
            'Overscroll amount proportional to drag distance',
          ],
        ),
        buildPhysicsDemo(
          'ClampingScrollPhysics',
          'Android-style hard stop at edges',
          Color(0xFF2E7D32),
          Icons.block,
          [
            'Content stops exactly at scroll extent',
            'Default on Android with MaterialScrollBehavior',
            'Overscroll indicator (glow) shown instead of bounce',
          ],
        ),
        buildPhysicsDemo(
          'NeverScrollableScrollPhysics',
          'Prevents all user-initiated scrolling',
          Color(0xFFC62828),
          Icons.lock,
          [
            'Useful for nested scrollables — parent scrolls instead',
            'Can still be scrolled programmatically',
            'Content remains fixed at current position',
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Overscroll Indicator Types
  // ============================================================
  print('=== Section 4: Overscroll indicators ===');

  Widget buildIndicatorCard(
    String name,
    String platform,
    Color color,
    IconData icon,
    String description,
    String visual,
  ) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.5)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
              ),
              child: Column(
                children: [
                  Icon(icon, color: color, size: 28.0),
                  SizedBox(height: 4.0),
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11.0,
                      color: color,
                    ),
                  ),
                  Text(
                    platform,
                    style: TextStyle(
                      fontSize: 9.0,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  // Visual representation
                  Container(
                    height: 60.0,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 8.0),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                        color: color.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        visual,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: color.withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey.shade600,
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

  final overscrollSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          'Overscroll Indicators',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'ScrollBehavior.buildOverscrollIndicator() selects the effect.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
        ),
        SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildIndicatorCard(
              'Glow Indicator',
              'Android ≤ 11',
              Color(0xFF1565C0),
              Icons.lightbulb,
              'Semi-circular glow at the edge when overscrolling. '
                  'Classic Material Design effect.',
              '◠',
            ),
            buildIndicatorCard(
              'Stretch Indicator',
              'Android 12+',
              Color(0xFF2E7D32),
              Icons.open_in_full,
              'Content stretches at edges. Modern Material 3 '
                  'overscroll behaviour.',
              '↕',
            ),
            buildIndicatorCard(
              'No Indicator',
              'iOS (bounce)',
              Color(0xFFE65100),
              Icons.do_not_disturb,
              'iOS uses bounce physics instead of a visual '
                  'overscroll indicator.',
              '⤿',
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Drag Devices Configuration
  // ============================================================
  print('=== Section 5: Drag devices ===');

  Widget buildDeviceRow(
    String device,
    IconData icon,
    Color color,
    bool enabledDefault,
    bool enabledCustom,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20.0),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              device,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.0,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          // Default column
          Container(
            width: 60.0,
            alignment: Alignment.center,
            child: Icon(
              enabledDefault ? Icons.check_circle : Icons.cancel,
              color: enabledDefault
                  ? Color(0xFF2E7D32)
                  : Colors.grey.shade400,
              size: 18.0,
            ),
          ),
          // Custom column
          Container(
            width: 60.0,
            alignment: Alignment.center,
            child: Icon(
              enabledCustom ? Icons.check_circle : Icons.cancel,
              color: enabledCustom
                  ? Color(0xFF1565C0)
                  : Colors.grey.shade400,
              size: 18.0,
            ),
          ),
        ],
      ),
    );
  }

  final dragSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.touch_app,
                color: Color(0xFF6A1B9A), size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Drag Devices',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'ScrollBehavior.dragDevices controls which pointer types can scroll.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
        ),
        SizedBox(height: 12.0),
        // Header
        Container(
          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Device Type',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              SizedBox(
                width: 60.0,
                child: Center(
                  child: Text(
                    'Default',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 60.0,
                child: Center(
                  child: Text(
                    'Custom',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0,
                      color: Color(0xFF1565C0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        buildDeviceRow(
          'Touch',
          Icons.fingerprint,
          Color(0xFF2E7D32),
          true,
          true,
        ),
        buildDeviceRow(
          'Mouse',
          Icons.mouse,
          Color(0xFF1565C0),
          false,
          true,
        ),
        buildDeviceRow(
          'Stylus',
          Icons.edit,
          Color(0xFFE65100),
          false,
          true,
        ),
        buildDeviceRow(
          'Trackpad',
          Icons.touch_app,
          Color(0xFF6A1B9A),
          false,
          true,
        ),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'ScrollConfiguration(\n'
            '  behavior: ScrollBehavior().copyWith(\n'
            '    dragDevices: {\n'
            '      PointerDeviceKind.touch,\n'
            '      PointerDeviceKind.mouse,\n'
            '      PointerDeviceKind.stylus,\n'
            '    },\n'
            '  ),\n'
            '  child: myScrollable,\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: Color(0xFF80CBC4),
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Live ScrollConfiguration Demo
  // ============================================================
  print('=== Section 6: Live demo ===');

  final liveDemo = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF1565C0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.play_circle,
                color: Color(0xFF1565C0), size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Live ScrollConfiguration',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D47A1),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'A custom ScrollBehavior that removes scrollbars and uses '
          'bouncing physics regardless of platform.',
          style: TextStyle(fontSize: 11.0, color: Color(0xFF1565C0)),
        ),
        SizedBox(height: 12.0),
        Container(
          height: 150.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFF1565C0).withValues(alpha: 0.3)),
          ),
          child: ScrollConfiguration(
            behavior: ScrollBehavior().copyWith(
              scrollbars: false,
              physics: BouncingScrollPhysics(),
            ),
            child: ListView.builder(
              itemCount: 20,
              padding: EdgeInsets.all(8.0),
              itemBuilder: (ctx, i) {
                final hue = (i * 18.0) % 360.0;
                return Container(
                  height: 36.0,
                  margin: EdgeInsets.symmetric(vertical: 2.0),
                  decoration: BoxDecoration(
                    color: HSLColor.fromAHSL(1.0, hue, 0.5, 0.85).toColor(),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 10.0),
                      Container(
                        width: 20.0,
                        height: 20.0,
                        decoration: BoxDecoration(
                          color: HSLColor.fromAHSL(1.0, hue, 0.6, 0.5)
                              .toColor(),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${i + 1}',
                            style: TextStyle(
                              fontSize: 9.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        'Bouncing item ${i + 1} — no scrollbar',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: HSLColor.fromAHSL(1.0, hue, 0.6, 0.3)
                              .toColor(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: copyWith Pattern
  // ============================================================
  print('=== Section 7: copyWith pattern ===');

  Widget buildCopyWithField(
    String field,
    String defaultVal,
    String customVal,
    Color color,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100.0,
            child: Text(
              field,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: color,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(4.0),
              margin: EdgeInsets.only(right: 4.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                defaultVal,
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                customVal,
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final copyWithSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.copy, color: Color(0xFF37474F), size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'copyWith Pattern',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'ScrollBehavior.copyWith() lets you override specific fields.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
        ),
        SizedBox(height: 12.0),
        // Header
        Container(
          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 100.0,
                child: Text(
                  'Field',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Default',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Custom',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                    color: Color(0xFF1565C0),
                  ),
                ),
              ),
            ],
          ),
        ),
        buildCopyWithField(
          'scrollbars',
          'true',
          'false',
          Color(0xFF1565C0),
        ),
        buildCopyWithField(
          'overscroll',
          'true',
          'false',
          Color(0xFF2E7D32),
        ),
        buildCopyWithField(
          'physics',
          'platform-based',
          'BouncingScrollPhysics',
          Color(0xFFE65100),
        ),
        buildCopyWithField(
          'dragDevices',
          '{touch}',
          '{touch, mouse}',
          Color(0xFF6A1B9A),
        ),
        buildCopyWithField(
          'platform',
          'current platform',
          'TargetPlatform.iOS',
          Color(0xFF37474F),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF2E7D32), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: Color(0xFF2E7D32), size: 28.0),
            SizedBox(width: 8.0),
            Text(
              'Summary',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildScrollConfigSummaryItem(
          Icons.tune,
          'InheritedWidget',
          'Provides ScrollBehavior to all scrollable descendants',
          Color(0xFF2E7D32),
        ),
        SizedBox(height: 8.0),
        _buildScrollConfigSummaryItem(
          Icons.settings,
          'ScrollBehavior',
          'Controls physics, scrollbars, overscroll, drag devices',
          Color(0xFF1565C0),
        ),
        SizedBox(height: 8.0),
        _buildScrollConfigSummaryItem(
          Icons.copy,
          'copyWith pattern',
          'Override specific fields without subclassing',
          Color(0xFFE65100),
        ),
        SizedBox(height: 8.0),
        _buildScrollConfigSummaryItem(
          Icons.devices,
          'Platform-aware',
          'MaterialScrollBehavior, CupertinoScrollBehavior, or custom',
          Color(0xFF6A1B9A),
        ),
        SizedBox(height: 8.0),
        _buildScrollConfigSummaryItem(
          Icons.find_in_page,
          'of(context)',
          'ScrollConfiguration.of(context) reads nearest behavior',
          Color(0xFF37474F),
        ),
      ],
    ),
  );

  print('ScrollConfiguration Deep Demo complete');

  // ============================================================
  // ASSEMBLE FINAL LAYOUT
  // ============================================================
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1B5E20),
                Color(0xFF2E7D32),
                Color(0xFF388E3C),
              ],
            ),
          ),
          child: Column(
            children: [
              Icon(Icons.tune, size: 48.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                'ScrollConfiguration',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Providing ScrollBehavior to scrollable descendants',
                style: TextStyle(fontSize: 13.0, color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),

        conceptCard,

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '2. Class Hierarchy',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        hierarchySection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '3. ScrollPhysics Types',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        physicsSection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '4. Overscroll Indicators',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        overscrollSection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '5. Drag Devices',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        dragSection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '6. Live Demo',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        liveDemo,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '7. copyWith Pattern',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        copyWithSection,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '8. Summary',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        summaryPanel,
        SizedBox(height: 40.0),
      ],
    ),
  );
}

// ================================================================
// Helpers
// ================================================================
Widget _buildScrollConfigBullet(String text, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 5.0),
          width: 6.0,
          height: 6.0,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12.0, color: color),
          ),
        ),
      ],
    ),
  );
}

Widget _buildScrollConfigSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
