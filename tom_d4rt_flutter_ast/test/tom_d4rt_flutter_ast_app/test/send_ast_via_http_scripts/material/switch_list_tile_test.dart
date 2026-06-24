// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SwitchListTile from material
// Deep Demo: Visual demonstration of toggle switches in list tile format
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SwitchListTile Deep Demo executing');

  // ============================================================
  // SECTION 1: SwitchListTile Fundamentals
  // ============================================================
  print('=== Section 1: SwitchListTile Fundamentals ===');

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
              colors: [Colors.indigo.shade400, Colors.indigo.shade600],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.toggle_on, color: Colors.white, size: 28.0),
              SizedBox(width: 12.0),
              Text(
                'SwitchListTile Basics',
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
                'SwitchListTile is a convenience widget that combines a ListTile '
                'with a Switch. Perfect for settings screens where users toggle '
                'features on or off.',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.indigo.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Core Properties:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo.shade700,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    _buildPropertyRow('value', 'Current on/off state (bool)'),
                    _buildPropertyRow('onChanged', 'Called when user toggles'),
                    _buildPropertyRow('title', 'Primary content widget'),
                    _buildPropertyRow('subtitle', 'Secondary description'),
                    _buildPropertyRow('secondary', 'Leading or trailing widget'),
                    _buildPropertyRow('activeColor', 'Color when switch is on'),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Basic examples
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
            ),
          ),
          child: Material(
            type: MaterialType.transparency,
            child: Column(
            children: [
              SwitchListTile(
                value: true,
                onChanged: (v) {},
                title: Text('Feature Enabled'),
                subtitle: Text('This switch is currently ON'),
              ),
              Divider(height: 1.0),
              SwitchListTile(
                value: false,
                onChanged: (v) {},
                title: Text('Feature Disabled'),
                subtitle: Text('This switch is currently OFF'),
              ),
            ],
          ),
          ),
        ),
      ],
    ),
  );
  print('Created fundamentals card');

  // ============================================================
  // SECTION 2: Color Customization
  // ============================================================
  print('=== Section 2: Color Customization ===');

  final colorConfigs = [
    {'name': 'Default', 'active': null, 'thumb': null, 'track': null},
    {'name': 'Blue Theme', 'active': Colors.blue, 'thumb': Colors.blue.shade200, 'track': Colors.blue.shade100},
    {'name': 'Green Theme', 'active': Colors.green, 'thumb': Colors.green.shade200, 'track': Colors.green.shade100},
    {'name': 'Orange Theme', 'active': Colors.orange, 'thumb': Colors.orange.shade200, 'track': Colors.orange.shade100},
    {'name': 'Purple Theme', 'active': Colors.purple, 'thumb': Colors.purple.shade200, 'track': Colors.purple.shade100},
    {'name': 'Teal Theme', 'active': Colors.teal, 'thumb': Colors.teal.shade200, 'track': Colors.teal.shade100},
  ];

  final colorTiles = <Widget>[];
  for (var i = 0; i < colorConfigs.length; i++) {
    final config = colorConfigs[i];
    print('Color config: ${config['name']}');
    colorTiles.add(
      Container(
        width: 280.0,
        margin: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: (config['active'] as Color? ?? Colors.grey).withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: (config['active'] as Color? ?? Colors.grey.shade300).withValues(alpha: 0.15),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(11.0),
                  topRight: Radius.circular(11.0),
                ),
              ),
              child: Text(
                config['name'] as String,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: config['active'] as Color? ?? Colors.grey.shade700,
                ),
              ),
            ),
            Material(
              type: MaterialType.transparency,
              child: SwitchListTile(
                value: true,
                onChanged: (v) {},
                title: Text('ON State', style: TextStyle(fontSize: 13.0)),
                activeColor: config['active'] as Color?,
                activeThumbColor: config['thumb'] as Color?,
                activeTrackColor: config['track'] as Color?,
                dense: true,
              ),
            ),
            Material(
              type: MaterialType.transparency,
              child: SwitchListTile(
                value: false,
                onChanged: (v) {},
                title: Text('OFF State', style: TextStyle(fontSize: 13.0)),
                activeColor: config['active'] as Color?,
                dense: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${colorTiles.length} color examples');

  // ============================================================
  // SECTION 3: Secondary Widget Integration
  // ============================================================
  print('=== Section 3: Secondary Widget Integration ===');

  final secondaryExamples = <Widget>[
    // With Icon
    Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 4.0,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: SwitchListTile(
        value: true,
        onChanged: (v) {},
        title: Text('Notifications'),
        subtitle: Text('Receive push notifications'),
        secondary: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.notifications, color: Colors.blue),
        ),
        activeColor: Colors.blue,
      ),
      ),
    ),
    // With Avatar
    Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 4.0,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: SwitchListTile(
        value: true,
        onChanged: (v) {},
        title: Text('Dark Mode'),
        subtitle: Text('Use dark theme throughout the app'),
        secondary: CircleAvatar(
          backgroundColor: Colors.grey.shade800,
          child: Icon(Icons.dark_mode, color: Colors.amber),
        ),
        activeColor: Colors.grey.shade700,
      ),
      ),
    ),
    // With Badge
    Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 4.0,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: SwitchListTile(
        value: false,
        onChanged: (v) {},
        title: Text('WiFi'),
        subtitle: Text('Connect to wireless networks'),
        secondary: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.wifi, color: Colors.green),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 12.0,
                height: 12.0,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2.0),
                ),
              ),
            ),
          ],
        ),
        activeColor: Colors.green,
      ),
      ),
    ),
    // With Status Text
    Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 4.0,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: SwitchListTile(
        value: true,
        onChanged: (v) {},
        title: Text('Auto-Sync'),
        subtitle: Text('Automatically sync data in background'),
        secondary: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Colors.teal.shade100,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            'PRO',
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade700,
            ),
          ),
        ),
        activeColor: Colors.teal,
      ),
      ),
    ),
  ];
  print('Created ${secondaryExamples.length} secondary widget examples');

  // ============================================================
  // SECTION 4: Adaptive Switch Mode
  // ============================================================
  print('=== Section 4: Adaptive Switch Mode ===');

  final adaptiveCard = Container(
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
            Icon(Icons.phone_iphone, color: Colors.amber.shade700, size: 28.0),
            SizedBox(width: 12.0),
            Text(
              'Adaptive Switch Mode',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'SwitchListTile.adaptive uses platform-native switch appearance: '
          'Cupertino style on iOS/macOS, Material style on Android/Windows/Linux.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 16.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Material(
            type: MaterialType.transparency,
            child: Column(
            children: [
              SwitchListTile.adaptive(
                value: true,
                onChanged: (v) {},
                title: Text('Adaptive Switch (ON)'),
                subtitle: Text('Matches platform appearance'),
                secondary: Icon(Icons.settings, color: Colors.amber.shade700),
                activeColor: Colors.amber.shade700,
              ),
              Divider(height: 1.0),
              SwitchListTile.adaptive(
                value: false,
                onChanged: (v) {},
                title: Text('Adaptive Switch (OFF)'),
                subtitle: Text('Native look and feel'),
                secondary: Icon(Icons.tune, color: Colors.amber.shade700),
                activeColor: Colors.amber.shade700,
              ),
            ],
          ),
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            Icon(Icons.info_outline, color: Colors.amber.shade600, size: 18.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                'Use adaptive switches for cross-platform apps that need native feel',
                style: TextStyle(
                  fontSize: 12.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.amber.shade800,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
  print('Created adaptive switch card');

  // ============================================================
  // SECTION 5: Dense Mode Comparison
  // ============================================================
  print('=== Section 5: Dense Mode Comparison ===');

  final denseModeCard = Container(
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
            color: Colors.cyan.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.density_small, color: Colors.cyan.shade700, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Dense Mode Comparison',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan.shade900,
                ),
              ),
            ],
          ),
        ),
        // Standard mode
        Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'dense: false (default)',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              Material(
                type: MaterialType.transparency,
                child: SwitchListTile(
                value: true,
                onChanged: (v) {},
                title: Text('Standard Spacing'),
                subtitle: Text('More padding around content'),
                secondary: Icon(Icons.space_bar, color: Colors.cyan),
                dense: false,
                activeColor: Colors.cyan,
              ),
              ),
            ],
          ),
        ),
        Divider(height: 1.0),
        // Dense mode
        Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'dense: true',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              Material(
                type: MaterialType.transparency,
                child: SwitchListTile(
                value: true,
                onChanged: (v) {},
                title: Text('Dense Spacing'),
                subtitle: Text('Less padding, compact layout'),
                secondary: Icon(Icons.compress, color: Colors.cyan),
                dense: true,
                activeColor: Colors.cyan,
              ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
      ],
    ),
  );
  print('Created dense mode card');

  // ============================================================
  // SECTION 6: Control Affinity Positions
  // ============================================================
  print('=== Section 6: Control Affinity Positions ===');

  final affinityExamples = <Widget>[];
  final affinities = [
    {'affinity': ListTileControlAffinity.leading, 'label': 'Leading', 'desc': 'Switch on the left', 'color': Colors.deepPurple},
    {'affinity': ListTileControlAffinity.trailing, 'label': 'Trailing', 'desc': 'Switch on the right (default)', 'color': Colors.pink},
    {'affinity': ListTileControlAffinity.platform, 'label': 'Platform', 'desc': 'Follows OS convention', 'color': Colors.brown},
  ];

  for (final config in affinities) {
    final affinity = config['affinity'] as ListTileControlAffinity;
    final label = config['label'] as String;
    final desc = config['desc'] as String;
    final color = config['color'] as Color;
    print('Affinity: $label');

    affinityExamples.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(11.0),
                  topRight: Radius.circular(11.0),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    desc,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Material(
              type: MaterialType.transparency,
              child: SwitchListTile(
              value: true,
              onChanged: (v) {},
              title: Text('$label Affinity'),
              subtitle: Text('controlAffinity: $affinity'),
              controlAffinity: affinity,
              activeColor: color,
            ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${affinityExamples.length} affinity examples');

  // ============================================================
  // SECTION 7: Settings Screen Example
  // ============================================================
  print('=== Section 7: Settings Screen Example ===');

  final settingsCategories = [
    {
      'title': 'Privacy',
      'icon': Icons.security,
      'color': Colors.red,
      'settings': [
        {'name': 'Share Analytics', 'subtitle': 'Help improve app experience', 'value': true},
        {'name': 'Location Access', 'subtitle': 'Allow background location', 'value': false},
        {'name': 'Face ID', 'subtitle': 'Use biometrics to unlock', 'value': true},
      ],
    },
    {
      'title': 'Notifications',
      'icon': Icons.notifications,
      'color': Colors.blue,
      'settings': [
        {'name': 'Push Notifications', 'subtitle': 'Receive alerts', 'value': true},
        {'name': 'Email Updates', 'subtitle': 'Weekly digest', 'value': false},
        {'name': 'In-App Sounds', 'subtitle': 'Play notification sounds', 'value': true},
      ],
    },
    {
      'title': 'Display',
      'icon': Icons.display_settings,
      'color': Colors.green,
      'settings': [
        {'name': 'Dark Mode', 'subtitle': 'Use dark theme', 'value': false},
        {'name': 'Reduce Motion', 'subtitle': 'Minimize animations', 'value': false},
        {'name': 'Large Text', 'subtitle': 'Increase font size', 'value': false},
      ],
    },
  ];

  final settingsScreenTiles = <Widget>[];
  for (final category in settingsCategories) {
    print('Settings: ${category['title']}');
    final settings = category['settings'] as List<Map<String, dynamic>>;
    final tiles = <Widget>[];

    for (var i = 0; i < settings.length; i++) {
      final setting = settings[i];
      tiles.add(
        Material(
          type: MaterialType.transparency,
          child: SwitchListTile(
          value: setting['value'] as bool,
          onChanged: (v) {},
          title: Text(setting['name'] as String),
          subtitle: Text(setting['subtitle'] as String),
          activeColor: category['color'] as Color,
          dense: true,
        ),
        ),
      );
      if (i < settings.length - 1) {
        tiles.add(Divider(height: 1.0, indent: 16.0, endIndent: 16.0));
      }
    }

    settingsScreenTiles.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
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
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: (category['color'] as Color).withValues(alpha: 0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
              child: Row(
                children: [
                  Icon(category['icon'] as IconData, color: category['color'] as Color, size: 20.0),
                  SizedBox(width: 8.0),
                  Text(
                    category['title'] as String,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: category['color'] as Color,
                    ),
                  ),
                ],
              ),
            ),
            ...tiles,
            SizedBox(height: 4.0),
          ],
        ),
      ),
    );
  }
  print('Created settings screen with ${settingsScreenTiles.length} categories');

  // ============================================================
  // SECTION 8: API Reference Summary
  // ============================================================
  print('=== Section 8: API Reference Summary ===');

  final apiItems = [
    {
      'signature': 'SwitchListTile({...})',
      'description': 'Creates a toggle switch inside a ListTile',
      'icon': Icons.toggle_on,
    },
    {
      'signature': 'SwitchListTile.adaptive({...})',
      'description': 'Platform-adaptive switch appearance',
      'icon': Icons.settings,
    },
    {
      'signature': 'value: bool',
      'description': 'Current toggle state',
      'icon': Icons.check_box,
    },
    {
      'signature': 'onChanged: (bool)? Function',
      'description': 'Callback when value changes',
      'icon': Icons.touch_app,
    },
    {
      'signature': 'activeColor: Color?',
      'description': 'Color when switch is on',
      'icon': Icons.palette,
    },
    {
      'signature': 'activeThumbColor: Color?',
      'description': 'Thumb color when on',
      'icon': Icons.circle,
    },
    {
      'signature': 'activeTrackColor: Color?',
      'description': 'Track color when on',
      'icon': Icons.linear_scale,
    },
    {
      'signature': 'inactiveThumbColor: Color?',
      'description': 'Thumb color when off',
      'icon': Icons.circle_outlined,
    },
    {
      'signature': 'inactiveTrackColor: Color?',
      'description': 'Track color when off',
      'icon': Icons.horizontal_rule,
    },
    {
      'signature': 'title: Widget?',
      'description': 'Primary content',
      'icon': Icons.title,
    },
    {
      'signature': 'subtitle: Widget?',
      'description': 'Secondary content',
      'icon': Icons.subtitles,
    },
    {
      'signature': 'secondary: Widget?',
      'description': 'Widget opposite to switch',
      'icon': Icons.view_sidebar,
    },
    {
      'signature': 'dense: bool?',
      'description': 'Reduces vertical padding',
      'icon': Icons.density_small,
    },
    {
      'signature': 'controlAffinity: ListTileControlAffinity',
      'description': 'Position of switch (leading/trailing)',
      'icon': Icons.swap_horiz,
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
                      fontSize: 11.0,
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
  print('SwitchListTile Deep Demo completed successfully');

  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 72.0,
                    height: 42.0,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(21.0),
                    ),
                  ),
                  Positioned(
                    right: 4.0,
                    child: Container(
                      width: 34.0,
                      height: 34.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'SwitchListTile Deep Demo',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black38, blurRadius: 4.0)],
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Toggle switches with list tile integration',
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

        // Section 2: Color Customization
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 2: Color Customization', Icons.palette),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: colorTiles,
          ),
        ),

        // Section 3: Secondary Widget
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 3: Secondary Widget', Icons.widgets),
        ...secondaryExamples,

        // Section 4: Adaptive Mode
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 4: Adaptive Mode', Icons.phone_iphone),
        adaptiveCard,

        // Section 5: Dense Mode
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 5: Dense Mode', Icons.density_small),
        denseModeCard,

        // Section 6: Control Affinity
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 6: Control Affinity', Icons.swap_horiz),
        ...affinityExamples,

        // Section 7: Settings Screen
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 7: Settings Screen', Icons.settings),
        Container(
          margin: EdgeInsets.all(16.0),
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.person, color: Colors.grey.shade700),
                  SizedBox(width: 8.0),
                  Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              ...settingsScreenTiles,
            ],
          ),
        ),

        // Section 8: API Reference
        SizedBox(height: 24.0),
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

// Helper: Build property row
Widget _buildPropertyRow(String name, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.chevron_right, size: 16.0, color: Colors.indigo.shade400),
        SizedBox(width: 4.0),
        Text(
          '$name: ',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade700,
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ],
    ),
  );
}
