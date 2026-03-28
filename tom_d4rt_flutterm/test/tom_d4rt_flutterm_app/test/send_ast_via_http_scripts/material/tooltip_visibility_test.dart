// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TooltipVisibility from material
// Deep Demo: Visual demonstration of tooltip visibility control
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TooltipVisibility Deep Demo executing');

  // ============================================================
  // SECTION 1: TooltipVisibility Fundamentals
  // ============================================================
  print('=== Section 1: TooltipVisibility Fundamentals ===');

  final fundamentalsCard = Container(
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.amber.shade500, Colors.orange.shade600],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.visibility, color: Colors.white, size: 28.0),
              SizedBox(width: 12.0),
              Text(
                'TooltipVisibility Basics',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TooltipVisibility controls whether tooltips in its subtree are shown '
                'or hidden. This is useful for temporarily disabling tooltips during '
                'specific interactions or on certain screens.',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.amber.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Key Properties:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.amber.shade700,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    _buildPropertyRow('visible', 'Controls tooltip visibility (true/false)'),
                    _buildPropertyRow('child', 'The widget subtree to control'),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Static Methods:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    _buildPropertyRow('TooltipVisibility.of(context)', 'Returns current visibility state'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created fundamentals card');

  // ============================================================
  // SECTION 2: Visibility States
  // ============================================================
  print('=== Section 2: Visibility States ===');

  final visibilityStatesCard = Container(
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.toggle_on, color: Colors.purple, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Visibility States Comparison',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade900,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Visible = true
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.visibility, color: Colors.green, size: 32.0),
                      SizedBox(height: 8.0),
                      Text(
                        'visible: true',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                          fontSize: 13.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Tooltips appear on long press or hover (default behavior)',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12.0),
                      TooltipVisibility(
                        visible: true,
                        child: Tooltip(
                          message: 'This tooltip is visible!',
                          child: Container(
                            padding: EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.touch_app, size: 16.0, color: Colors.green.shade700),
                                SizedBox(width: 4.0),
                                Text(
                                  'Hover / Long press',
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    color: Colors.green.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12.0),
              // Visible = false
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.visibility_off, color: Colors.red, size: 32.0),
                      SizedBox(height: 8.0),
                      Text(
                        'visible: false',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade700,
                          fontSize: 13.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Tooltips are suppressed and will not appear',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12.0),
                      TooltipVisibility(
                        visible: false,
                        child: Tooltip(
                          message: 'This tooltip is hidden!',
                          child: Container(
                            padding: EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.block, size: 16.0, color: Colors.red.shade700),
                                SizedBox(width: 4.0),
                                Text(
                                  'No tooltip here',
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    color: Colors.red.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created visibility states card');

  // ============================================================
  // SECTION 3: Nested Visibility
  // ============================================================
  print('=== Section 3: Nested Visibility ===');

  final nestedCard = Container(
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.account_tree, color: Colors.teal, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Nested Visibility Scopes',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade900,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TooltipVisibility can be nested. Inner visibility settings override '
                'outer settings for their respective subtrees:',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 16.0),

              // Outer scope: visible
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.green.shade300, width: 2.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.visibility, color: Colors.green, size: 18.0),
                        SizedBox(width: 6.0),
                        Text(
                          'Outer: visible = true',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      children: [
                        // Tooltip that will show
                        Expanded(
                          child: TooltipVisibility(
                            visible: true,
                            child: Tooltip(
                              message: 'Outer scope tooltip',
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Text(
                                  'Has tooltip',
                                  style: TextStyle(fontSize: 11.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        // Inner scope: hidden
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: Colors.red.shade200),
                            ),
                            child: TooltipVisibility(
                              visible: false,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.visibility_off, color: Colors.red, size: 14.0),
                                      SizedBox(width: 4.0),
                                      Text(
                                        'Inner: false',
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          color: Colors.red.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.0),
                                  Tooltip(
                                    message: 'Hidden by inner scope',
                                    child: Container(
                                      padding: EdgeInsets.all(6.0),
                                      decoration: BoxDecoration(
                                        color: Colors.red.shade100,
                                        borderRadius: BorderRadius.circular(4.0),
                                      ),
                                      child: Text(
                                        'No tooltip',
                                        style: TextStyle(fontSize: 10.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created nested card');

  // ============================================================
  // SECTION 4: Toolbar Example
  // ============================================================
  print('=== Section 4: Toolbar Example ===');

  final toolbarButtons = [
    {'icon': Icons.undo, 'tooltip': 'Undo'},
    {'icon': Icons.redo, 'tooltip': 'Redo'},
    {'icon': Icons.content_cut, 'tooltip': 'Cut'},
    {'icon': Icons.content_copy, 'tooltip': 'Copy'},
    {'icon': Icons.content_paste, 'tooltip': 'Paste'},
    {'icon': Icons.format_bold, 'tooltip': 'Bold'},
    {'icon': Icons.format_italic, 'tooltip': 'Italic'},
    {'icon': Icons.format_underline, 'tooltip': 'Underline'},
  ];

  final toolbarCard = Container(
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.2),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade400, Colors.indigo.shade600],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.build, color: Colors.white, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Toolbar with Tooltips',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'In a text editor, tooltips help users understand button functions. '
                'You might disable them during active editing:',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 16.0),

              // Tooltips enabled - toolbar
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.visibility, color: Colors.green, size: 16.0),
                        SizedBox(width: 6.0),
                        Text(
                          'Tooltips Enabled',
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    TooltipVisibility(
                      visible: true,
                      child: Row(
                        children: toolbarButtons.map((btn) {
                          return Tooltip(
                            message: btn['tooltip'] as String,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 2.0),
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Icon(
                                btn['icon'] as IconData,
                                size: 18.0,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.0),

              // Tooltips disabled - toolbar
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.visibility_off, color: Colors.red, size: 16.0),
                        SizedBox(width: 6.0),
                        Text(
                          'Tooltips Disabled (during editing)',
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    TooltipVisibility(
                      visible: false,
                      child: Row(
                        children: toolbarButtons.map((btn) {
                          return Tooltip(
                            message: btn['tooltip'] as String,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 2.0),
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Icon(
                                btn['icon'] as IconData,
                                size: 18.0,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created toolbar card');

  // ============================================================
  // SECTION 5: Icon Grid Example
  // ============================================================
  print('=== Section 5: Icon Grid Example ===');

  final iconItems = [
    {'icon': Icons.folder, 'name': 'Documents', 'color': Colors.amber},
    {'icon': Icons.image, 'name': 'Images', 'color': Colors.green},
    {'icon': Icons.music_note, 'name': 'Music', 'color': Colors.purple},
    {'icon': Icons.movie, 'name': 'Videos', 'color': Colors.red},
    {'icon': Icons.download, 'name': 'Downloads', 'color': Colors.blue},
    {'icon': Icons.settings, 'name': 'Settings', 'color': Colors.grey},
  ];

  final iconGrid = Container(
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.apps, color: Colors.blue, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'File Browser Icons',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'In a file browser, tooltips show full folder names. '
                'Disable them when labels are already visible:',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 16.0),

              // With tooltips
              Text(
                'Icon view (tooltips enabled):',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              TooltipVisibility(
                visible: true,
                child: Wrap(
                  spacing: 12.0,
                  runSpacing: 12.0,
                  children: iconItems.map((item) {
                    return Tooltip(
                      message: item['name'] as String,
                      child: Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: (item['color'] as Color).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Icon(
                          item['icon'] as IconData,
                          color: item['color'] as Color,
                          size: 28.0,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: 20.0),

              // With labels (no tooltips needed)
              Text(
                'List view (tooltips disabled):',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              TooltipVisibility(
                visible: false,
                child: Column(
                  children: iconItems.take(4).map((item) {
                    return Tooltip(
                      message: item['name'] as String,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 4.0),
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              item['icon'] as IconData,
                              color: item['color'] as Color,
                              size: 22.0,
                            ),
                            SizedBox(width: 12.0),
                            Text(
                              item['name'] as String,
                              style: TextStyle(fontSize: 13.0),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created icon grid');

  // ============================================================
  // SECTION 6: Accessibility Modes
  // ============================================================
  print('=== Section 6: Accessibility Modes ===');

  final accessibilityCard = Container(
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.deepOrange.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.accessibility, color: Colors.deepOrange, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Accessibility Considerations',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange.shade900,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAccessibilityItem(
                icon: Icons.record_voice_over,
                title: 'Screen Reader Mode',
                description: 'Keep tooltips visible=true when screen readers are active. '
                    'Tooltips provide important context for assistive technologies.',
                isRecommended: true,
              ),
              SizedBox(height: 12.0),
              _buildAccessibilityItem(
                icon: Icons.touch_app,
                title: 'Touch Devices',
                description: 'Consider disabling tooltips on touch-only devices where '
                    'hover is not available and long-press conflicts with other gestures.',
                isRecommended: false,
              ),
              SizedBox(height: 12.0),
              _buildAccessibilityItem(
                icon: Icons.mouse,
                title: 'Mouse Interaction',
                description: 'Enable tooltips for mouse users to provide context on hover. '
                    'This is the default and expected behavior on desktop.',
                isRecommended: true,
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created accessibility card');

  // ============================================================
  // SECTION 7: Use Cases
  // ============================================================
  print('=== Section 7: Use Cases ===');

  final useCases = [
    {
      'title': 'Gaming / Full Screen',
      'description': 'Disable tooltips during gameplay to avoid UI disruptions',
      'icon': Icons.sports_esports,
      'color': Colors.purple,
      'visible': false,
    },
    {
      'title': 'Form Entry Mode',
      'description': 'Disable tooltips while user is actively typing in forms',
      'icon': Icons.edit_note,
      'color': Colors.blue,
      'visible': false,
    },
    {
      'title': 'Tutorial Overlay',
      'description': 'Enable tooltips to guide users through new features',
      'icon': Icons.school,
      'color': Colors.green,
      'visible': true,
    },
    {
      'title': 'Presentation Mode',
      'description': 'Disable tooltips during screen sharing or presentations',
      'icon': Icons.present_to_all,
      'color': Colors.orange,
      'visible': false,
    },
    {
      'title': 'Help Mode',
      'description': 'Enable all tooltips when user asks for help',
      'icon': Icons.help,
      'color': Colors.teal,
      'visible': true,
    },
    {
      'title': 'Expert User Mode',
      'description': 'Disable tooltips for experienced users who know the UI',
      'icon': Icons.bolt,
      'color': Colors.amber,
      'visible': false,
    },
  ];

  final useCaseWidgets = <Widget>[];
  for (final useCase in useCases) {
    useCaseWidgets.add(
      _buildUseCaseCard(
        title: useCase['title'] as String,
        description: useCase['description'] as String,
        icon: useCase['icon'] as IconData,
        color: useCase['color'] as Color,
        visible: useCase['visible'] as bool,
      ),
    );
  }
  print('Created ${useCaseWidgets.length} use case cards');

  // ============================================================
  // SECTION 8: API Reference Summary
  // ============================================================
  print('=== Section 8: API Reference Summary ===');

  final apiItems = [
    {
      'signature': 'TooltipVisibility({Key? key, required bool visible, required Widget child})',
      'description': 'Constructor with required visibility flag',
      'icon': Icons.code,
    },
    {
      'signature': 'visible: bool',
      'description': 'Determines if tooltips in subtree are shown',
      'icon': Icons.visibility,
    },
    {
      'signature': 'child: Widget',
      'description': 'The widget subtree affected by visibility',
      'icon': Icons.widgets,
    },
    {
      'signature': 'static bool of(BuildContext context)',
      'description': 'Returns current tooltip visibility state from context',
      'icon': Icons.search,
    },
  ];

  final apiCards = <Widget>[];
  for (final api in apiItems) {
    apiCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 3.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.blueGrey.shade100),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                api['icon'] as IconData,
                color: Colors.blueGrey.shade600,
                size: 16.0,
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    api['signature'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey.shade800,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    api['description'] as String,
                    style: TextStyle(
                      fontSize: 11.0,
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

  // Related widgets
  final relatedWidgets = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.cyan.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.cyan.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.link, color: Colors.cyan.shade700, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Related Widgets',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _buildRelatedChip('Tooltip'),
            _buildRelatedChip('TooltipTheme'),
            _buildRelatedChip('TooltipThemeData'),
            _buildRelatedChip('MouseRegion'),
            _buildRelatedChip('InheritedWidget'),
          ],
        ),
      ],
    ),
  );

  final apiSummaryCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.blueGrey.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blueGrey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.api, color: Colors.blueGrey.shade700, size: 28.0),
            SizedBox(width: 12.0),
            Text(
              'API Reference',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        ...apiCards,
      ],
    ),
  );
  print('Created API summary card');

  // ============================================================
  // Final Layout Assembly
  // ============================================================
  print('TooltipVisibility Deep Demo completed successfully');

  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.amber.shade500, Colors.orange.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.visibility, color: Colors.white, size: 24.0),
                  SizedBox(width: 8.0),
                  Icon(Icons.arrow_forward, color: Colors.white70, size: 16.0),
                  SizedBox(width: 8.0),
                  Icon(Icons.visibility_off, color: Colors.white54, size: 24.0),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'TooltipVisibility Deep Demo',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black38, blurRadius: 4.0)],
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Control tooltip visibility in widget subtrees',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),

        // Section 1: Fundamentals
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 1: Fundamentals', Icons.school),
        fundamentalsCard,

        // Section 2: Visibility States
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 2: Visibility States', Icons.toggle_on),
        visibilityStatesCard,

        // Section 3: Nested
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 3: Nested Scopes', Icons.account_tree),
        nestedCard,

        // Section 4: Toolbar
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 4: Toolbar Example', Icons.build),
        toolbarCard,

        // Section 5: Icon Grid
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 5: File Browser', Icons.apps),
        iconGrid,

        // Section 6: Accessibility
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 6: Accessibility', Icons.accessibility),
        accessibilityCard,

        // Section 7: Use Cases
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 7: Use Cases', Icons.lightbulb),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Wrap(
            children: useCaseWidgets,
          ),
        ),

        // Section 8: API Reference
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 8: API Reference', Icons.api),
        relatedWidgets,
        apiSummaryCard,

        SizedBox(height: 32.0),
      ],
    ),
  );
}

// Helper: Build section header
Widget _buildSectionHeader(String title, IconData icon) {
  print('Section: $title');
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      children: [
        Icon(icon, color: Colors.grey.shade700),
        SizedBox(width: 8.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
      ],
    ),
  );
}

// Helper: Build property row
Widget _buildPropertyRow(String name, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.chevron_right, size: 16.0, color: Colors.amber.shade400),
        SizedBox(width: 4.0),
        Text(
          '$name: ',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: Colors.amber.shade700,
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper: Build accessibility item
Widget _buildAccessibilityItem({
  required IconData icon,
  required String title,
  required String description,
  required bool isRecommended,
}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: isRecommended ? Colors.green.shade50 : Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: isRecommended ? Colors.green.shade200 : Colors.grey.shade200,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: isRecommended ? Colors.green.shade100 : Colors.grey.shade100,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: isRecommended ? Colors.green.shade700 : Colors.grey.shade600,
            size: 20.0,
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                    ),
                  ),
                  if (isRecommended) ...[
                    SizedBox(width: 8.0),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        'Keep enabled',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 11.0,
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

// Helper: Build use case card
Widget _buildUseCaseCard({
  required String title,
  required String description,
  required IconData icon,
  required Color color,
  required bool visible,
}) {
  return Container(
    width: 170.0,
    margin: EdgeInsets.all(6.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.3)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.1),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20.0),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: visible ? Colors.green.shade100 : Colors.red.shade100,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    visible ? Icons.visibility : Icons.visibility_off,
                    size: 10.0,
                    color: visible ? Colors.green.shade700 : Colors.red.shade700,
                  ),
                  SizedBox(width: 2.0),
                  Text(
                    visible ? 'ON' : 'OFF',
                    style: TextStyle(
                      fontSize: 9.0,
                      fontWeight: FontWeight.bold,
                      color: visible ? Colors.green.shade700 : Colors.red.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 10.0,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    ),
  );
}

// Helper: Build related widget chip
Widget _buildRelatedChip(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.cyan.shade100,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.cyan.shade300),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w500,
        color: Colors.cyan.shade900,
      ),
    ),
  );
}
