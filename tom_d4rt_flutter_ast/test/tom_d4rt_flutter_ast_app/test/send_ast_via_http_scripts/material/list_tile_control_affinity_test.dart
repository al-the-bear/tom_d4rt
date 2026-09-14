// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ListTileControlAffinity from material
// Deep Demo: Visual demonstration of control positioning in ListTile variants
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ListTileControlAffinity Deep Demo executing');

  // ============================================================
  // SECTION 1: ListTileControlAffinity Overview
  // ============================================================
  print('=== Section 1: ListTileControlAffinity Overview ===');

  // Demonstrate all enum values
  final affinities = [
    ListTileControlAffinity.leading,
    ListTileControlAffinity.trailing,
    ListTileControlAffinity.platform,
  ];

  print('ListTileControlAffinity.leading: ${ListTileControlAffinity.leading}');
  print('ListTileControlAffinity.trailing: ${ListTileControlAffinity.trailing}');
  print('ListTileControlAffinity.platform: ${ListTileControlAffinity.platform}');
  print('Total enum values: ${affinities.length}');

  for (final affinity in affinities) {
    print('${affinity.name}: index=${affinity.index}');
  }

  final overviewCards = <Widget>[];
  final affinityDescriptions = {
    ListTileControlAffinity.leading: {
      'title': 'Leading',
      'description': 'Control appears at the start of the tile (left in LTR). Common for quick selection interfaces.',
      'icon': Icons.first_page,
      'color': Colors.blue,
      'controlPosition': 'Start',
    },
    ListTileControlAffinity.trailing: {
      'title': 'Trailing',
      'description': 'Control appears at the end of the tile (right in LTR). This is the default position.',
      'icon': Icons.last_page,
      'color': Colors.green,
      'controlPosition': 'End',
    },
    ListTileControlAffinity.platform: {
      'title': 'Platform',
      'description': 'Uses platform conventions. iOS: trailing, Android: leading. Adapts automatically.',
      'icon': Icons.devices,
      'color': Colors.purple,
      'controlPosition': 'Varies',
    },
  };

  for (final affinity in affinities) {
    final data = affinityDescriptions[affinity]!;
    final color = data['color'] as Color;

    overviewCards.add(
      Container(
        width: 280.0,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withValues(alpha: 0.12), color.withValues(alpha: 0.04)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: color.withValues(alpha: 0.4), width: 2.0),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.2),
              blurRadius: 10.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14.0),
                  topRight: Radius.circular(14.0),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(alpha: 0.3),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Icon(data['icon'] as IconData, color: color, size: 24.0),
                  ),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['title'] as String,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                        Text(
                          'Control: ${data['controlPosition']}',
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
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['description'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  // Visual mini-preview
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      children: affinity == ListTileControlAffinity.leading
                          ? [
                              Icon(Icons.check_box, color: color, size: 20.0),
                              SizedBox(width: 12.0),
                              Expanded(child: Text('List item text', style: TextStyle(fontSize: 12.0))),
                            ]
                          : affinity == ListTileControlAffinity.trailing
                              ? [
                                  Expanded(child: Text('List item text', style: TextStyle(fontSize: 12.0))),
                                  SizedBox(width: 12.0),
                                  Icon(Icons.check_box, color: color, size: 20.0),
                                ]
                              : [
                                  Icon(Icons.help_outline, color: Colors.grey, size: 16.0),
                                  SizedBox(width: 8.0),
                                  Expanded(
                                    child: Text(
                                      'Position varies by platform',
                                      style: TextStyle(fontSize: 11.0, fontStyle: FontStyle.italic),
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
      ),
    );
  }
  print('Created ${overviewCards.length} overview cards');

  // ============================================================
  // SECTION 2: CheckboxListTile Examples
  // ============================================================
  print('=== Section 2: CheckboxListTile Examples ===');

  final checkboxExamples = <Widget>[];
  final checkboxItems = [
    {'title': 'Enable notifications', 'subtitle': 'Receive push notifications', 'icon': Icons.notifications},
    {'title': 'Dark mode', 'subtitle': 'Use dark theme', 'icon': Icons.dark_mode},
    {'title': 'Auto-update', 'subtitle': 'Download updates automatically', 'icon': Icons.system_update},
  ];

  for (final affinity in [ListTileControlAffinity.leading, ListTileControlAffinity.trailing]) {
    final isLeading = affinity == ListTileControlAffinity.leading;
    final color = isLeading ? Colors.blue : Colors.green;
    print('CheckboxListTile: ${affinity.name}');

    final tiles = <Widget>[];
    for (var i = 0; i < checkboxItems.length; i++) {
      final item = checkboxItems[i];
      tiles.add(
        Material(
          type: MaterialType.transparency,
          child: CheckboxListTile(
          value: i == 0,
          onChanged: (value) {},
          title: Text(item['title'] as String),
          subtitle: Text(item['subtitle'] as String),
          secondary: Icon(item['icon'] as IconData, color: color),
          controlAffinity: affinity,
          activeColor: color,
        ),
        ),
      );
    }

    checkboxExamples.add(
      Container(
        width: 340.0,
        margin: EdgeInsets.all(8.0),
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
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_box, color: color),
                  SizedBox(width: 8.0),
                  Text(
                    'CheckboxListTile',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      affinity.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ...tiles,
          ],
        ),
      ),
    );
  }
  print('Created ${checkboxExamples.length} checkbox examples');

  // ============================================================
  // SECTION 3: SwitchListTile Examples
  // ============================================================
  print('=== Section 3: SwitchListTile Examples ===');

  final switchExamples = <Widget>[];
  final switchItems = [
    {'title': 'Wi-Fi', 'subtitle': 'Connected to HomeNetwork', 'icon': Icons.wifi},
    {'title': 'Bluetooth', 'subtitle': 'Available', 'icon': Icons.bluetooth},
    {'title': 'Airplane Mode', 'subtitle': 'All connections disabled', 'icon': Icons.airplanemode_active},
  ];

  for (final affinity in [ListTileControlAffinity.leading, ListTileControlAffinity.trailing]) {
    final isLeading = affinity == ListTileControlAffinity.leading;
    final color = isLeading ? Colors.teal : Colors.orange;
    print('SwitchListTile: ${affinity.name}');

    final tiles = <Widget>[];
    for (var i = 0; i < switchItems.length; i++) {
      final item = switchItems[i];
      tiles.add(
        Material(
          type: MaterialType.transparency,
          child: SwitchListTile(
          value: i < 2,
          onChanged: (value) {},
          title: Text(item['title'] as String),
          subtitle: Text(item['subtitle'] as String),
          secondary: Icon(item['icon'] as IconData, color: color),
          controlAffinity: affinity,
          activeColor: color,
        ),
        ),
      );
    }

    switchExamples.add(
      Container(
        width: 340.0,
        margin: EdgeInsets.all(8.0),
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
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.toggle_on, color: color),
                  SizedBox(width: 8.0),
                  Text(
                    'SwitchListTile',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      affinity.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ...tiles,
          ],
        ),
      ),
    );
  }
  print('Created ${switchExamples.length} switch examples');

  // ============================================================
  // SECTION 4: RadioListTile Examples
  // ============================================================
  print('=== Section 4: RadioListTile Examples ===');

  final radioExamples = <Widget>[];
  final radioItems = [
    {'title': 'Light Theme', 'subtitle': 'Bright and clean', 'icon': Icons.light_mode},
    {'title': 'Dark Theme', 'subtitle': 'Easy on the eyes', 'icon': Icons.dark_mode},
    {'title': 'System Default', 'subtitle': 'Follow system settings', 'icon': Icons.settings_suggest},
  ];

  for (final affinity in [ListTileControlAffinity.leading, ListTileControlAffinity.trailing]) {
    final isLeading = affinity == ListTileControlAffinity.leading;
    final color = isLeading ? Colors.indigo : Colors.pink;
    print('RadioListTile: ${affinity.name}');

    final tiles = <Widget>[];
    for (var i = 0; i < radioItems.length; i++) {
      final item = radioItems[i];
      tiles.add(
        Material(
          type: MaterialType.transparency,
          child: RadioListTile<int>(
          value: i,
          groupValue: 1,
          onChanged: (value) {},
          title: Text(item['title'] as String),
          subtitle: Text(item['subtitle'] as String),
          secondary: Icon(item['icon'] as IconData, color: color),
          controlAffinity: affinity,
          activeColor: color,
        ),
        ),
      );
    }

    radioExamples.add(
      Container(
        width: 340.0,
        margin: EdgeInsets.all(8.0),
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
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.radio_button_checked, color: color),
                  SizedBox(width: 8.0),
                  Text(
                    'RadioListTile',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      affinity.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ...tiles,
          ],
        ),
      ),
    );
  }
  print('Created ${radioExamples.length} radio examples');

  // ============================================================
  // SECTION 5: Platform-Specific Behavior
  // ============================================================
  print('=== Section 5: Platform-Specific Behavior ===');

  final platformCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.purple.shade50, Colors.blue.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.purple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.devices, color: Colors.purple, size: 28.0),
            SizedBox(width: 12.0),
            Text(
              'Platform-Specific Behavior',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'When using ListTileControlAffinity.platform, the control position '
          'adapts based on platform design guidelines.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 20.0),
        // Android convention
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Icon(Icons.android, color: Colors.green, size: 20.0),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Android / Material Design',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.0),
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_box, color: Colors.green, size: 24.0),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Setting option', style: TextStyle(fontWeight: FontWeight.w500)),
                          Text('Checkbox at leading', style: TextStyle(fontSize: 12.0, color: Colors.grey)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '→ Control at LEADING (start) position',
                style: TextStyle(
                  fontSize: 12.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.green.shade600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        // iOS convention
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Icon(Icons.apple, color: Colors.blue, size: 20.0),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'iOS / Cupertino Design',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.0),
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Setting option', style: TextStyle(fontWeight: FontWeight.w500)),
                          Text('Switch at trailing', style: TextStyle(fontSize: 12.0, color: Colors.grey)),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Icon(Icons.toggle_on, color: Colors.blue, size: 32.0),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '→ Control at TRAILING (end) position',
                style: TextStyle(
                  fontSize: 12.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.blue.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created platform card');

  // ============================================================
  // SECTION 6: Settings Screen Example
  // ============================================================
  print('=== Section 6: Settings Screen Example ===');

  final settingsExample = Container(
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
    child: Material(
      type: MaterialType.transparency,
      child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueGrey.shade700, Colors.blueGrey.shade900],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.settings, color: Colors.white, size: 28.0),
              SizedBox(width: 12.0),
              Text(
                'App Settings',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        // Group: Appearance
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          width: double.infinity,
          color: Colors.grey.shade100,
          child: Text(
            'APPEARANCE',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
              letterSpacing: 1.0,
            ),
          ),
        ),
        SwitchListTile(
          value: true,
          onChanged: (v) {},
          title: Text('Dark Mode'),
          subtitle: Text('Use dark theme'),
          secondary: Icon(Icons.dark_mode, color: Colors.blueGrey),
          controlAffinity: ListTileControlAffinity.trailing,
        ),
        Divider(height: 1.0),
        SwitchListTile(
          value: false,
          onChanged: (v) {},
          title: Text('Reduce Animations'),
          subtitle: Text('Minimize visual motion'),
          secondary: Icon(Icons.animation, color: Colors.blueGrey),
          controlAffinity: ListTileControlAffinity.trailing,
        ),
        // Group: Notifications
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          width: double.infinity,
          color: Colors.grey.shade100,
          child: Text(
            'NOTIFICATIONS',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
              letterSpacing: 1.0,
            ),
          ),
        ),
        SwitchListTile(
          value: true,
          onChanged: (v) {},
          title: Text('Push Notifications'),
          subtitle: Text('Receive alerts'),
          secondary: Icon(Icons.notifications, color: Colors.blueGrey),
          controlAffinity: ListTileControlAffinity.trailing,
        ),
        Divider(height: 1.0),
        SwitchListTile(
          value: true,
          onChanged: (v) {},
          title: Text('Email Notifications'),
          subtitle: Text('Weekly updates'),
          secondary: Icon(Icons.email, color: Colors.blueGrey),
          controlAffinity: ListTileControlAffinity.trailing,
        ),
        Divider(height: 1.0),
        SwitchListTile(
          value: false,
          onChanged: (v) {},
          title: Text('Sound'),
          subtitle: Text('Play notification sounds'),
          secondary: Icon(Icons.volume_up, color: Colors.blueGrey),
          controlAffinity: ListTileControlAffinity.trailing,
        ),
        // Group: Privacy
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          width: double.infinity,
          color: Colors.grey.shade100,
          child: Text(
            'PRIVACY',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
              letterSpacing: 1.0,
            ),
          ),
        ),
        CheckboxListTile(
          value: true,
          onChanged: (v) {},
          title: Text('Analytics'),
          subtitle: Text('Help improve the app'),
          secondary: Icon(Icons.analytics, color: Colors.blueGrey),
          controlAffinity: ListTileControlAffinity.trailing,
        ),
        Divider(height: 1.0),
        CheckboxListTile(
          value: false,
          onChanged: (v) {},
          title: Text('Personalized Ads'),
          subtitle: Text('Show relevant advertisements'),
          secondary: Icon(Icons.ads_click, color: Colors.blueGrey),
          controlAffinity: ListTileControlAffinity.trailing,
        ),
        SizedBox(height: 8.0),
      ],
    ),
    ),
  );
  print('Created settings example');

  // ============================================================
  // SECTION 7: Enum Properties & Methods
  // ============================================================
  print('=== Section 7: Enum Properties & Methods ===');

  final enumProperties = <Widget>[];
  final allValues = ListTileControlAffinity.values;
  print('ListTileControlAffinity.values: $allValues');
  print('values.length: ${allValues.length}');

  for (var i = 0; i < allValues.length; i++) {
    final value = allValues[i];
    print('values[$i] = ${value.name}');

    final colorMap = {
      ListTileControlAffinity.leading: Colors.blue,
      ListTileControlAffinity.trailing: Colors.green,
      ListTileControlAffinity.platform: Colors.purple,
    };

    enumProperties.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: colorMap[value]!.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: colorMap[value]!.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$i',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: colorMap[value],
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ListTileControlAffinity.${value.name}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: colorMap[value],
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    children: [
                      _buildProperty('index', '${value.index}'),
                      SizedBox(width: 20.0),
                      _buildProperty('name', '"${value.name}"'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final enumCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.grey.shade700, size: 28.0),
            SizedBox(width: 12.0),
            Text(
              'Enum Properties',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        ...enumProperties,
      ],
    ),
  );
  print('Created enum card');

  // ============================================================
  // SECTION 8: API Reference Summary
  // ============================================================
  print('=== Section 8: API Reference Summary ===');

  final apiItems = [
    {
      'signature': 'ListTileControlAffinity.leading',
      'description': 'Places control at start (leading) position',
      'icon': Icons.first_page,
    },
    {
      'signature': 'ListTileControlAffinity.trailing',
      'description': 'Places control at end (trailing) position (default)',
      'icon': Icons.last_page,
    },
    {
      'signature': 'ListTileControlAffinity.platform',
      'description': 'Uses platform-specific conventions (iOS: trailing, Android: leading)',
      'icon': Icons.devices,
    },
    {
      'signature': 'CheckboxListTile.controlAffinity',
      'description': 'Property to set control position in CheckboxListTile',
      'icon': Icons.check_box,
    },
    {
      'signature': 'SwitchListTile.controlAffinity',
      'description': 'Property to set control position in SwitchListTile',
      'icon': Icons.toggle_on,
    },
    {
      'signature': 'RadioListTile.controlAffinity',
      'description': 'Property to set control position in RadioListTile',
      'icon': Icons.radio_button_checked,
    },
  ];

  final apiCards = <Widget>[];
  for (final api in apiItems) {
    apiCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.amber.shade100),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                api['icon'] as IconData,
                color: Colors.amber.shade700,
                size: 20.0,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    api['signature'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber.shade900,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    api['description'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
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

  final apiSummaryCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.amber.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.amber.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.api, color: Colors.amber.shade700, size: 28.0),
            SizedBox(width: 12.0),
            Text(
              'API Reference',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade900,
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
  print('ListTileControlAffinity Deep Demo completed successfully');

  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.green, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_box, size: 32.0, color: Colors.white),
                  SizedBox(width: 8.0),
                  Icon(Icons.toggle_on, size: 40.0, color: Colors.white),
                  SizedBox(width: 8.0),
                  Icon(Icons.radio_button_checked, size: 32.0, color: Colors.white),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'ListTileControlAffinity',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black38, blurRadius: 4.0)],
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Control positioning in selection list tiles',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),

        // Section 1: Overview
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 1: Enum Overview', Icons.info_outline),
        Wrap(
          alignment: WrapAlignment.center,
          children: overviewCards,
        ),

        // Section 2: CheckboxListTile
        SizedBox(height: 32.0),
        _buildSectionHeader('Section 2: CheckboxListTile', Icons.check_box),
        Wrap(
          alignment: WrapAlignment.center,
          children: checkboxExamples,
        ),

        // Section 3: SwitchListTile
        SizedBox(height: 32.0),
        _buildSectionHeader('Section 3: SwitchListTile', Icons.toggle_on),
        Wrap(
          alignment: WrapAlignment.center,
          children: switchExamples,
        ),

        // Section 4: RadioListTile
        SizedBox(height: 32.0),
        _buildSectionHeader('Section 4: RadioListTile', Icons.radio_button_checked),
        Wrap(
          alignment: WrapAlignment.center,
          children: radioExamples,
        ),

        // Section 5: Platform Behavior
        SizedBox(height: 32.0),
        _buildSectionHeader('Section 5: Platform Behavior', Icons.devices),
        platformCard,

        // Section 6: Settings Example
        SizedBox(height: 32.0),
        _buildSectionHeader('Section 6: Real-World Example', Icons.settings),
        settingsExample,

        // Section 7: Enum Properties
        SizedBox(height: 32.0),
        _buildSectionHeader('Section 7: Enum Properties', Icons.code),
        enumCard,

        // Section 8: API Reference
        SizedBox(height: 32.0),
        _buildSectionHeader('Section 8: API Reference', Icons.api),
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

// Helper: Build property chip
Widget _buildProperty(String label, String value) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        '$label: ',
        style: TextStyle(
          fontSize: 10.0,
          color: Colors.grey.shade500,
        ),
      ),
      Text(
        value,
        style: TextStyle(
          fontSize: 10.0,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade700,
        ),
      ),
    ],
  );
}
