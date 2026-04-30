// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RadioListTile from material
// Deep Demo: Visual demonstration of radio button list tiles for single selection
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RadioListTile Deep Demo executing');

  // ============================================================
  // SECTION 1: RadioListTile Fundamentals
  // ============================================================
  print('=== Section 1: RadioListTile Fundamentals ===');

  final basicExample = Container(
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
              colors: [Colors.blue.shade400, Colors.blue.shade600],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.radio_button_checked, color: Colors.white, size: 28.0),
              SizedBox(width: 12.0),
              Text(
                'RadioListTile Basics',
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
                'RadioListTile combines a ListTile with a Radio widget for '
                'creating single-selection option lists.',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.grey.shade700,
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
                      'Key Properties:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    _buildPropertyItem('value', 'The value this tile represents'),
                    _buildPropertyItem('groupValue', 'Currently selected value in group'),
                    _buildPropertyItem('onChanged', 'Called when selection changes'),
                    _buildPropertyItem('title', 'Primary text widget'),
                    _buildPropertyItem('subtitle', 'Secondary text widget'),
                    _buildPropertyItem('secondary', 'Leading or trailing widget'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created basic example card');

  // ============================================================
  // SECTION 2: Single Selection Groups
  // ============================================================
  print('=== Section 2: Single Selection Groups ===');

  // Payment method selection
  final paymentMethods = [
    {'value': 0, 'title': 'Credit Card', 'subtitle': '•••• 4242', 'icon': Icons.credit_card},
    {'value': 1, 'title': 'PayPal', 'subtitle': 'user@email.com', 'icon': Icons.payment},
    {'value': 2, 'title': 'Bank Transfer', 'subtitle': 'Account ending 1234', 'icon': Icons.account_balance},
    {'value': 3, 'title': 'Apple Pay', 'subtitle': 'Quick checkout', 'icon': Icons.apple},
  ];

  final paymentTiles = <Widget>[];
  for (final method in paymentMethods) {
    print('Payment: ${method['title']}');
    paymentTiles.add(
      RadioListTile<int>(
        value: method['value'] as int,
        groupValue: 0,
        onChanged: (value) {},
        title: Text(method['title'] as String),
        subtitle: Text(method['subtitle'] as String),
        secondary: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(method['icon'] as IconData, color: Colors.green, size: 24.0),
        ),
        activeColor: Colors.green,
      ),
    );
    if (method != paymentMethods.last) {
      paymentTiles.add(Divider(height: 1.0, indent: 72.0));
    }
  }

  final paymentCard = Container(
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
            gradient: LinearGradient(
              colors: [Colors.green.shade400, Colors.green.shade600],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.payment, color: Colors.white, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Payment Method',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  'Select one',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        ...paymentTiles,
        SizedBox(height: 8.0),
      ],
    ),
  );
  print('Created payment selection card');

  // Shipping speed selection
  final shippingOptions = [
    {'value': 0, 'title': 'Standard', 'subtitle': '5-7 business days', 'price': 'FREE', 'color': Colors.grey},
    {'value': 1, 'title': 'Express', 'subtitle': '2-3 business days', 'price': '\$9.99', 'color': Colors.orange},
    {'value': 2, 'title': 'Overnight', 'subtitle': 'Next business day', 'price': '\$24.99', 'color': Colors.red},
  ];

  final shippingTiles = <Widget>[];
  for (final option in shippingOptions) {
    print('Shipping: ${option['title']}');
    shippingTiles.add(
      RadioListTile<int>(
        value: option['value'] as int,
        groupValue: 1,
        onChanged: (value) {},
        title: Row(
          children: [
            Text(
              option['title'] as String,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: (option['color'] as Color).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                option['price'] as String,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: option['color'] as Color,
                  fontSize: 13.0,
                ),
              ),
            ),
          ],
        ),
        subtitle: Text(option['subtitle'] as String),
        activeColor: Colors.orange,
      ),
    );
  }

  final shippingCard = Container(
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
            gradient: LinearGradient(
              colors: [Colors.orange.shade400, Colors.orange.shade600],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.local_shipping, color: Colors.white, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Shipping Speed',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        ...shippingTiles,
        SizedBox(height: 8.0),
      ],
    ),
  );
  print('Created shipping selection card');

  // ============================================================
  // SECTION 3: Control Affinity Comparison
  // ============================================================
  print('=== Section 3: Control Affinity Comparison ===');

  final affinityExamples = <Widget>[];
  final affinities = [
    {'affinity': ListTileControlAffinity.leading, 'label': 'Leading', 'color': Colors.blue},
    {'affinity': ListTileControlAffinity.trailing, 'label': 'Trailing', 'color': Colors.purple},
    {'affinity': ListTileControlAffinity.platform, 'label': 'Platform', 'color': Colors.teal},
  ];

  for (final config in affinities) {
    final affinity = config['affinity'] as ListTileControlAffinity;
    final label = config['label'] as String;
    final color = config['color'] as Color;
    print('Affinity: $label');

    affinityExamples.add(
      Container(
        width: 280.0,
        margin: EdgeInsets.all(8.0),
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
                  Text(
                    'controlAffinity:',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
            RadioListTile<int>(
              value: 0,
              groupValue: 0,
              onChanged: (v) {},
              title: Text('Option A'),
              controlAffinity: affinity,
              activeColor: color,
              dense: true,
            ),
            RadioListTile<int>(
              value: 1,
              groupValue: 0,
              onChanged: (v) {},
              title: Text('Option B'),
              controlAffinity: affinity,
              activeColor: color,
              dense: true,
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${affinityExamples.length} affinity examples');

  // ============================================================
  // SECTION 4: Customization Options
  // ============================================================
  print('=== Section 4: Customization Options ===');

  final customizationExamples = <Widget>[];

  // Dense mode
  customizationExamples.add(
    _buildCustomizationCard(
      title: 'Dense Mode',
      description: 'Reduces vertical padding for compact lists',
      examples: [
        RadioListTile<int>(
          value: 0,
          groupValue: 0,
          onChanged: (v) {},
          title: Text('Dense: false (default)'),
          dense: false,
          activeColor: Colors.indigo,
        ),
        RadioListTile<int>(
          value: 1,
          groupValue: 1,
          onChanged: (v) {},
          title: Text('Dense: true'),
          dense: true,
          activeColor: Colors.indigo,
        ),
      ],
      color: Colors.indigo,
    ),
  );

  // Selected state
  customizationExamples.add(
    _buildCustomizationCard(
      title: 'Selected Background',
      description: 'Highlight the selected tile with tileColor',
      examples: [
        RadioListTile<int>(
          value: 0,
          groupValue: 0,
          onChanged: (v) {},
          title: Text('Selected item'),
          subtitle: Text('This tile is selected'),
          selected: true,
          selectedTileColor: Colors.pink.shade50,
          activeColor: Colors.pink,
        ),
        RadioListTile<int>(
          value: 1,
          groupValue: 0,
          onChanged: (v) {},
          title: Text('Unselected item'),
          subtitle: Text('Normal background'),
          selected: false,
          activeColor: Colors.pink,
        ),
      ],
      color: Colors.pink,
    ),
  );

  // Shape customization
  customizationExamples.add(
    _buildCustomizationCard(
      title: 'Shape Customization',
      description: 'Apply rounded corners or custom shapes',
      examples: [
        RadioListTile<int>(
          value: 0,
          groupValue: 0,
          onChanged: (v) {},
          title: Text('Rounded shape'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          tileColor: Colors.amber.shade50,
          activeColor: Colors.amber.shade700,
        ),
        SizedBox(height: 8.0),
        RadioListTile<int>(
          value: 1,
          groupValue: 0,
          onChanged: (v) {},
          title: Text('Stadium shape'),
          shape: StadiumBorder(),
          tileColor: Colors.amber.shade100,
          activeColor: Colors.amber.shade700,
        ),
      ],
      color: Colors.amber.shade700,
    ),
  );

  // Content padding
  customizationExamples.add(
    _buildCustomizationCard(
      title: 'Content Padding',
      description: 'Adjust internal spacing with contentPadding',
      examples: [
        RadioListTile<int>(
          value: 0,
          groupValue: 0,
          onChanged: (v) {},
          title: Text('Default padding'),
          activeColor: Colors.cyan,
        ),
        RadioListTile<int>(
          value: 1,
          groupValue: 0,
          onChanged: (v) {},
          title: Text('Extra horizontal padding'),
          contentPadding: EdgeInsets.symmetric(horizontal: 32.0),
          activeColor: Colors.cyan,
        ),
      ],
      color: Colors.cyan,
    ),
  );
  print('Created ${customizationExamples.length} customization examples');

  // ============================================================
  // SECTION 5: Toggle Properties
  // ============================================================
  print('=== Section 5: Toggle Properties ===');

  final toggleCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.deepPurple.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepPurple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.toggle_on, color: Colors.deepPurple, size: 28.0),
            SizedBox(width: 12.0),
            Text(
              'toggleable Property',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'When toggleable is true, tapping the selected radio will unselect it, '
          'resulting in a null groupValue. Useful for optional selections.',
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
          child: Column(
            children: [
              RadioListTile<int>(
                value: 0,
                groupValue: 0,
                onChanged: (v) {},
                title: Text('toggleable: false (default)'),
                subtitle: Text('Cannot unselect by tapping'),
                toggleable: false,
                activeColor: Colors.deepPurple,
              ),
              Divider(height: 1.0),
              RadioListTile<int>(
                value: 1,
                groupValue: 1,
                onChanged: (v) {},
                title: Text('toggleable: true'),
                subtitle: Text('Can unselect by tapping again'),
                toggleable: true,
                activeColor: Colors.deepPurple,
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb, color: Colors.amber.shade700, size: 20.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Use toggleable when selection is optional (e.g., filters)',
                  style: TextStyle(
                    fontSize: 12.0,
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
  print('Created toggle property card');

  // ============================================================
  // SECTION 6: Visual Fill Color
  // ============================================================
  print('=== Section 6: Visual Fill Color ===');

  final fillColorExamples = <Widget>[];
  final fillConfigs = [
    {'label': 'Default', 'fillColor': null, 'bgColor': Colors.grey.shade100},
    {'label': 'Blue Fill', 'fillColor': Colors.blue, 'bgColor': Colors.blue.shade50},
    {'label': 'Green Fill', 'fillColor': Colors.green, 'bgColor': Colors.green.shade50},
    {'label': 'Red Fill', 'fillColor': Colors.red, 'bgColor': Colors.red.shade50},
    {'label': 'Orange Fill', 'fillColor': Colors.orange, 'bgColor': Colors.orange.shade50},
    {'label': 'Purple Fill', 'fillColor': Colors.purple, 'bgColor': Colors.purple.shade50},
  ];

  for (final config in fillConfigs) {
    print('Fill color: ${config['label']}');
    fillColorExamples.add(
      Container(
        width: 170.0,
        margin: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: config['bgColor'] as Color,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: RadioListTile<int>(
          value: 0,
          groupValue: 0,
          onChanged: (v) {},
          title: Text(
            config['label'] as String,
            style: TextStyle(fontSize: 13.0),
          ),
          activeColor: config['fillColor'] as Color?,
          dense: true,
        ),
      ),
    );
  }
  print('Created ${fillColorExamples.length} fill color examples');

  // ============================================================
  // SECTION 7: Real-World Form Example
  // ============================================================
  print('=== Section 7: Real-World Form Example ===');

  final surveyForm = Container(
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
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade400, Colors.teal.shade600],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.poll, color: Colors.white, size: 28.0),
                  SizedBox(width: 12.0),
                  Text(
                    'Customer Survey',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                'Help us improve your experience',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
        ),
        // Question 1
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          color: Colors.grey.shade50,
          child: Text(
            'How satisfied are you with our service?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
        ),
        RadioListTile<int>(
          value: 5,
          groupValue: 4,
          onChanged: (v) {},
          title: Text('Very Satisfied'),
          secondary: Text('😄', style: TextStyle(fontSize: 24.0)),
          activeColor: Colors.teal,
        ),
        RadioListTile<int>(
          value: 4,
          groupValue: 4,
          onChanged: (v) {},
          title: Text('Satisfied'),
          secondary: Text('🙂', style: TextStyle(fontSize: 24.0)),
          activeColor: Colors.teal,
        ),
        RadioListTile<int>(
          value: 3,
          groupValue: 4,
          onChanged: (v) {},
          title: Text('Neutral'),
          secondary: Text('😐', style: TextStyle(fontSize: 24.0)),
          activeColor: Colors.teal,
        ),
        RadioListTile<int>(
          value: 2,
          groupValue: 4,
          onChanged: (v) {},
          title: Text('Dissatisfied'),
          secondary: Text('🙁', style: TextStyle(fontSize: 24.0)),
          activeColor: Colors.teal,
        ),
        RadioListTile<int>(
          value: 1,
          groupValue: 4,
          onChanged: (v) {},
          title: Text('Very Dissatisfied'),
          secondary: Text('😞', style: TextStyle(fontSize: 24.0)),
          activeColor: Colors.teal,
        ),
        // Question 2
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          color: Colors.grey.shade50,
          child: Text(
            'How likely are you to recommend us?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
        ),
        RadioListTile<int>(
          value: 10,
          groupValue: 8,
          onChanged: (v) {},
          title: Text('Very Likely (9-10)'),
          activeColor: Colors.green,
        ),
        RadioListTile<int>(
          value: 8,
          groupValue: 8,
          onChanged: (v) {},
          title: Text('Likely (7-8)'),
          activeColor: Colors.green,
        ),
        RadioListTile<int>(
          value: 5,
          groupValue: 8,
          onChanged: (v) {},
          title: Text('Neutral (5-6)'),
          activeColor: Colors.orange,
        ),
        RadioListTile<int>(
          value: 2,
          groupValue: 8,
          onChanged: (v) {},
          title: Text('Unlikely (0-4)'),
          activeColor: Colors.red,
        ),
        SizedBox(height: 16.0),
      ],
    ),
  );
  print('Created survey form');

  // ============================================================
  // SECTION 8: API Reference Summary
  // ============================================================
  print('=== Section 8: API Reference Summary ===');

  final apiItems = [
    {
      'signature': 'RadioListTile<T>',
      'description': 'Generic widget supporting any type for value/groupValue',
      'icon': Icons.radio_button_checked,
    },
    {
      'signature': 'value: T',
      'description': 'The value this radio represents',
      'icon': Icons.label_important,
    },
    {
      'signature': 'groupValue: T?',
      'description': 'Currently selected value in the radio group',
      'icon': Icons.group_work,
    },
    {
      'signature': 'onChanged: (T?)? Function',
      'description': 'Callback when selection changes',
      'icon': Icons.touch_app,
    },
    {
      'signature': 'title: Widget?',
      'description': 'Primary content widget',
      'icon': Icons.title,
    },
    {
      'signature': 'subtitle: Widget?',
      'description': 'Secondary content widget',
      'icon': Icons.subtitles,
    },
    {
      'signature': 'secondary: Widget?',
      'description': 'Widget on opposite side from control',
      'icon': Icons.view_sidebar,
    },
    {
      'signature': 'controlAffinity: ListTileControlAffinity',
      'description': 'Position of radio (leading/trailing/platform)',
      'icon': Icons.swap_horiz,
    },
    {
      'signature': 'toggleable: bool',
      'description': 'If true, tapping selected radio unselects it',
      'icon': Icons.toggle_on,
    },
    {
      'signature': 'activeColor: Color?',
      'description': 'Color when radio is selected',
      'icon': Icons.palette,
    },
    {
      'signature': 'dense: bool?',
      'description': 'Reduces vertical padding',
      'icon': Icons.density_small,
    },
    {
      'signature': 'selected: bool',
      'description': 'Whether tile is visually selected',
      'icon': Icons.check_circle,
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
  print('RadioListTile Deep Demo completed successfully');

  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Icon(Icons.radio_button_off, size: 64.0, color: Colors.white24),
                  Icon(Icons.radio_button_checked, size: 48.0, color: Colors.white),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'RadioListTile Deep Demo',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black38, blurRadius: 4.0)],
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Single-selection lists with rich content',
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
        basicExample,

        // Section 2: Selection Groups
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 2: Selection Groups', Icons.checklist),
        paymentCard,
        shippingCard,

        // Section 3: Control Affinity
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 3: Control Affinity', Icons.swap_horiz),
        Wrap(
          alignment: WrapAlignment.center,
          children: affinityExamples,
        ),

        // Section 4: Customization
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 4: Customization', Icons.tune),
        ...customizationExamples,

        // Section 5: Toggle Property
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 5: Toggle Property', Icons.toggle_on),
        toggleCard,

        // Section 6: Fill Colors
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 6: Active Colors', Icons.palette),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: fillColorExamples,
          ),
        ),

        // Section 7: Survey Form
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 7: Real-World Example', Icons.poll),
        surveyForm,

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

// Helper: Build property item
Widget _buildPropertyItem(String name, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.chevron_right, size: 16.0, color: Colors.blue.shade400),
        SizedBox(width: 4.0),
        Text(
          '$name: ',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade700,
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

// Helper: Build customization card
Widget _buildCustomizationCard({
  required String title,
  required String description,
  required List<Widget> examples,
  required Color color,
}) {
  print('Customization: $title');
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(11.0),
              topRight: Radius.circular(11.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 2.0),
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
        ...examples,
        SizedBox(height: 8.0),
      ],
    ),
  );
}
