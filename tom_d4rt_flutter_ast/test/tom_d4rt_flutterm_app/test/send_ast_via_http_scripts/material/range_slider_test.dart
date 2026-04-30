// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RangeSlider from material
// Deep Demo: Visual demonstration of dual-thumb range selection sliders
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RangeSlider Deep Demo executing');

  // ============================================================
  // SECTION 1: RangeSlider Fundamentals
  // ============================================================
  print('=== Section 1: RangeSlider Fundamentals ===');

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
              colors: [Colors.orange.shade400, Colors.deepOrange.shade500],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.tune, color: Colors.white, size: 28.0),
              SizedBox(width: 12.0),
              Text(
                'RangeSlider Basics',
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
                'RangeSlider allows users to select a range of values using '
                'two thumbs. Unlike a regular Slider with one thumb, RangeSlider '
                'lets you define both minimum and maximum bounds within a range.',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Core Properties:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade700,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    _buildPropertyRow('values', 'RangeValues with start/end'),
                    _buildPropertyRow('onChanged', 'Called when thumbs move'),
                    _buildPropertyRow('min/max', 'Range boundaries'),
                    _buildPropertyRow('divisions', 'Number of discrete steps'),
                    _buildPropertyRow('labels', 'RangeLabels for display'),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              // Basic example
              Text(
                'Basic Range Selection:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 8.0),
              RangeSlider(
                values: RangeValues(20.0, 80.0),
                min: 0.0,
                max: 100.0,
                onChanged: (values) {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('0', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600)),
                  Text('Selected: 20 - 80', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)),
                  Text('100', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600)),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created fundamentals card');

  // ============================================================
  // SECTION 2: Value Display Integration
  // ============================================================
  print('=== Section 2: Value Display Integration ===');

  final valueDisplayExamples = <Widget>[];

  // Example 1: Percentage display
  valueDisplayExamples.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: EdgeInsets.all(16.0),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress Range',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Text(
                  '25% - 75%',
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          RangeSlider(
            values: RangeValues(25.0, 75.0),
            min: 0.0,
            max: 100.0,
            divisions: 20,
            labels: RangeLabels('25%', '75%'),
            activeColor: Colors.blue,
            onChanged: (values) {},
          ),
        ],
      ),
    ),
  );

  // Example 2: Temperature range
  valueDisplayExamples.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: EdgeInsets.all(16.0),
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
          Row(
            children: [
              Icon(Icons.thermostat, color: Colors.red.shade400),
              SizedBox(width: 8.0),
              Text(
                'Temperature Range',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade700,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text('18°C', style: TextStyle(fontSize: 12.0, color: Colors.blue.shade700)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text('-', style: TextStyle(color: Colors.grey)),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text('24°C', style: TextStyle(fontSize: 12.0, color: Colors.red.shade700)),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.0),
          RangeSlider(
            values: RangeValues(18.0, 24.0),
            min: 10.0,
            max: 35.0,
            divisions: 25,
            labels: RangeLabels('18°', '24°'),
            activeColor: Colors.red.shade400,
            inactiveColor: Colors.grey.shade300,
            onChanged: (values) {},
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('10°C', style: TextStyle(fontSize: 11.0, color: Colors.grey)),
              Text('35°C', style: TextStyle(fontSize: 11.0, color: Colors.grey)),
            ],
          ),
        ],
      ),
    ),
  );
  print('Created ${valueDisplayExamples.length} value display examples');

  // ============================================================
  // SECTION 3: Divisions and Discrete Values
  // ============================================================
  print('=== Section 3: Divisions and Discrete Values ===');

  final divisionsCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.green.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.green.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.linear_scale, color: Colors.green.shade700, size: 28.0),
            SizedBox(width: 12.0),
            Text(
              'Divisions Property',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'The divisions property creates discrete steps on the slider. '
          'Users can only select values at specific intervals, and visual tick '
          'marks appear along the track.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 20.0),

        // No divisions (continuous)
        Text('Continuous (no divisions):', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0)),
        RangeSlider(
          values: RangeValues(30.0, 70.0),
          min: 0.0,
          max: 100.0,
          activeColor: Colors.green.shade400,
          onChanged: (values) {},
        ),

        SizedBox(height: 16.0),
        Text('5 divisions:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0)),
        RangeSlider(
          values: RangeValues(20.0, 80.0),
          min: 0.0,
          max: 100.0,
          divisions: 5,
          labels: RangeLabels('20', '80'),
          activeColor: Colors.green.shade500,
          onChanged: (values) {},
        ),

        SizedBox(height: 16.0),
        Text('10 divisions:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0)),
        RangeSlider(
          values: RangeValues(30.0, 70.0),
          min: 0.0,
          max: 100.0,
          divisions: 10,
          labels: RangeLabels('30', '70'),
          activeColor: Colors.green.shade600,
          onChanged: (values) {},
        ),

        SizedBox(height: 16.0),
        Text('20 divisions:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0)),
        RangeSlider(
          values: RangeValues(25.0, 75.0),
          min: 0.0,
          max: 100.0,
          divisions: 20,
          labels: RangeLabels('25', '75'),
          activeColor: Colors.green.shade700,
          onChanged: (values) {},
        ),
      ],
    ),
  );
  print('Created divisions card');

  // ============================================================
  // SECTION 4: Color Customization
  // ============================================================
  print('=== Section 4: Color Customization ===');

  final colorSchemes = [
    {'name': 'Default', 'active': null, 'inactive': null},
    {'name': 'Ocean Blue', 'active': Colors.blue, 'inactive': Colors.blue.shade100},
    {'name': 'Forest Green', 'active': Colors.green.shade600, 'inactive': Colors.green.shade100},
    {'name': 'Sunset Orange', 'active': Colors.deepOrange, 'inactive': Colors.orange.shade100},
    {'name': 'Royal Purple', 'active': Colors.purple, 'inactive': Colors.purple.shade100},
    {'name': 'Cherry Red', 'active': Colors.red.shade600, 'inactive': Colors.red.shade100},
    {'name': 'Teal Dream', 'active': Colors.teal, 'inactive': Colors.teal.shade100},
    {'name': 'Golden Hour', 'active': Colors.amber.shade700, 'inactive': Colors.amber.shade100},
  ];

  final colorCards = <Widget>[];
  for (final scheme in colorSchemes) {
    print('Color scheme: ${scheme['name']}');
    colorCards.add(
      Container(
        width: 180.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: (scheme['active'] as Color? ?? Colors.grey.shade400).withValues(alpha: 0.4),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              scheme['name'] as String,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: scheme['active'] as Color? ?? Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 8.0),
            RangeSlider(
              values: RangeValues(30.0, 70.0),
              min: 0.0,
              max: 100.0,
              activeColor: scheme['active'] as Color?,
              inactiveColor: scheme['inactive'] as Color?,
              onChanged: (values) {},
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${colorCards.length} color scheme cards');

  // ============================================================
  // SECTION 5: Labels and Semantic Configuration
  // ============================================================
  print('=== Section 5: Labels and Semantic Configuration ===');

  final labelsCard = Container(
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
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.label, color: Colors.purple, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'RangeLabels',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RangeLabels display values above the thumbs when the user '
                'drags them. Labels only appear when divisions are set.',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 20.0),

              // Currency labels
              Text('Currency Labels:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0)),
              SizedBox(height: 4.0),
              RangeSlider(
                values: RangeValues(100.0, 500.0),
                min: 0.0,
                max: 1000.0,
                divisions: 20,
                labels: RangeLabels('\$100', '\$500'),
                activeColor: Colors.green.shade600,
                onChanged: (values) {},
              ),

              SizedBox(height: 16.0),
              Text('Percentage Labels:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0)),
              SizedBox(height: 4.0),
              RangeSlider(
                values: RangeValues(20.0, 80.0),
                min: 0.0,
                max: 100.0,
                divisions: 10,
                labels: RangeLabels('20%', '80%'),
                activeColor: Colors.blue,
                onChanged: (values) {},
              ),

              SizedBox(height: 16.0),
              Text('Time Labels:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0)),
              SizedBox(height: 4.0),
              RangeSlider(
                values: RangeValues(9.0, 17.0),
                min: 0.0,
                max: 24.0,
                divisions: 24,
                labels: RangeLabels('9 AM', '5 PM'),
                activeColor: Colors.orange,
                onChanged: (values) {},
              ),

              SizedBox(height: 16.0),
              Text('Custom Text Labels:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0)),
              SizedBox(height: 4.0),
              RangeSlider(
                values: RangeValues(2.0, 4.0),
                min: 1.0,
                max: 5.0,
                divisions: 4,
                labels: RangeLabels('Moderate', 'High'),
                activeColor: Colors.red,
                onChanged: (values) {},
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created labels card');

  // ============================================================
  // SECTION 6: Price Range Filter Example
  // ============================================================
  print('=== Section 6: Price Range Filter Example ===');

  final priceFilterCard = Container(
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
              colors: [Colors.indigo.shade400, Colors.indigo.shade600],
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
                  Icon(Icons.filter_list, color: Colors.white, size: 24.0),
                  SizedBox(width: 12.0),
                  Text(
                    'Price Filter',
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
                'E-Commerce Product Search',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price Range',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.indigo.shade200),
                    ),
                    child: Text(
                      '\$250 - \$750',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              RangeSlider(
                values: RangeValues(250.0, 750.0),
                min: 0.0,
                max: 1000.0,
                divisions: 20,
                labels: RangeLabels('\$250', '\$750'),
                activeColor: Colors.indigo,
                onChanged: (values) {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$0', style: TextStyle(color: Colors.grey.shade500, fontSize: 12.0)),
                  Text('\$1,000', style: TextStyle(color: Colors.grey.shade500, fontSize: 12.0)),
                ],
              ),
              SizedBox(height: 24.0),
              // Sample products
              Text(
                '324 products in range',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 12.0),
              Row(
                children: [
                  _buildProductCard('\$299', 'Headphones', Colors.orange),
                  SizedBox(width: 12.0),
                  _buildProductCard('\$499', 'Smartwatch', Colors.blue),
                  SizedBox(width: 12.0),
                  _buildProductCard('\$649', 'Tablet', Colors.green),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created price filter card');

  // ============================================================
  // SECTION 7: Age Range Selector
  // ============================================================
  print('=== Section 7: Age Range Selector ===');

  final ageRangeCard = Container(
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
              colors: [Colors.pink.shade300, Colors.pink.shade500],
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
                  Icon(Icons.people, color: Colors.white, size: 24.0),
                  SizedBox(width: 12.0),
                  Text(
                    'Age Preference',
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
                'Dating App Profile Settings',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.pink.shade100, Colors.pink.shade200],
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '25',
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink.shade700,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Icon(Icons.favorite, color: Colors.pink, size: 20.0),
                        ),
                        Text(
                          '35',
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink.shade700,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'years',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.pink.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              RangeSlider(
                values: RangeValues(25.0, 35.0),
                min: 18.0,
                max: 65.0,
                divisions: 47,
                labels: RangeLabels('25', '35'),
                activeColor: Colors.pink,
                onChanged: (values) {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('18', style: TextStyle(color: Colors.grey.shade500, fontSize: 12.0)),
                  Text('65+', style: TextStyle(color: Colors.grey.shade500, fontSize: 12.0)),
                ],
              ),
              SizedBox(height: 16.0),
              // Visual representation
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildAgeCategory('18-24', false),
                  _buildAgeCategory('25-34', true),
                  _buildAgeCategory('35-44', true),
                  _buildAgeCategory('45+', false),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created age range card');

  // ============================================================
  // SECTION 8: API Reference Summary
  // ============================================================
  print('=== Section 8: API Reference Summary ===');

  final apiItems = [
    {
      'signature': 'RangeSlider({...})',
      'description': 'Creates a dual-thumb range selection slider',
      'icon': Icons.tune,
    },
    {
      'signature': 'values: RangeValues',
      'description': 'Current selected range (start, end)',
      'icon': Icons.linear_scale,
    },
    {
      'signature': 'onChanged: (RangeValues)? Function',
      'description': 'Called when user drags either thumb',
      'icon': Icons.touch_app,
    },
    {
      'signature': 'onChangeStart: (RangeValues)? Function',
      'description': 'Called when user starts dragging',
      'icon': Icons.play_arrow,
    },
    {
      'signature': 'onChangeEnd: (RangeValues)? Function',
      'description': 'Called when user ends dragging',
      'icon': Icons.stop,
    },
    {
      'signature': 'min: double',
      'description': 'Minimum selectable value (default 0.0)',
      'icon': Icons.remove,
    },
    {
      'signature': 'max: double',
      'description': 'Maximum selectable value (default 1.0)',
      'icon': Icons.add,
    },
    {
      'signature': 'divisions: int?',
      'description': 'Number of discrete values',
      'icon': Icons.grid_on,
    },
    {
      'signature': 'labels: RangeLabels?',
      'description': 'Labels shown above thumbs',
      'icon': Icons.label,
    },
    {
      'signature': 'activeColor: Color?',
      'description': 'Color between thumbs',
      'icon': Icons.palette,
    },
    {
      'signature': 'inactiveColor: Color?',
      'description': 'Color outside thumbs',
      'icon': Icons.format_color_fill,
    },
    {
      'signature': 'semanticFormatterCallback',
      'description': 'For accessibility value announcements',
      'icon': Icons.accessibility,
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
  print('RangeSlider Deep Demo completed successfully');

  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.deepOrange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 100.0,
                height: 8.0,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 20.0,
                      right: 30.0,
                      child: Container(
                        height: 8.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16.0,
                      top: -4.0,
                      child: Container(
                        width: 16.0,
                        height: 16.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4.0)],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 26.0,
                      top: -4.0,
                      child: Container(
                        width: 16.0,
                        height: 16.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4.0)],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'RangeSlider Deep Demo',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black38, blurRadius: 4.0)],
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Dual-thumb range selection control',
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

        // Section 2: Value Display
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 2: Value Display', Icons.visibility),
        ...valueDisplayExamples,

        // Section 3: Divisions
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 3: Divisions', Icons.linear_scale),
        divisionsCard,

        // Section 4: Colors
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 4: Color Themes', Icons.palette),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: colorCards,
          ),
        ),

        // Section 5: Labels
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 5: Labels', Icons.label),
        labelsCard,

        // Section 6: Price Filter
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 6: Price Filter', Icons.attach_money),
        priceFilterCard,

        // Section 7: Age Range
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 7: Age Range', Icons.person_search),
        ageRangeCard,

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
        Icon(Icons.chevron_right, size: 16.0, color: Colors.orange.shade400),
        SizedBox(width: 4.0),
        Text(
          '$name: ',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Colors.orange.shade700,
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

// Helper: Build product card for price filter example
Widget _buildProductCard(String price, String name, Color color) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(Icons.shopping_bag, color: color, size: 20.0),
          ),
          SizedBox(height: 8.0),
          Text(
            price,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 14.0,
            ),
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    ),
  );
}

// Helper: Build age category indicator
Widget _buildAgeCategory(String label, bool selected) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: selected ? Colors.pink.shade100 : Colors.grey.shade100,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(
        color: selected ? Colors.pink.shade300 : Colors.grey.shade300,
      ),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        color: selected ? Colors.pink.shade700 : Colors.grey.shade500,
      ),
    ),
  );
}
