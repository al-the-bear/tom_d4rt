// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TabPageSelector from material
// Deep Demo: Visual demonstration of page indicator dots for tab views
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TabPageSelector Deep Demo executing');

  // ============================================================
  // SECTION 1: TabPageSelector Fundamentals
  // ============================================================
  print('=== Section 1: TabPageSelector Fundamentals ===');

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
              colors: [Colors.teal.shade400, Colors.teal.shade600],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.more_horiz, color: Colors.white, size: 28.0),
              SizedBox(width: 12.0),
              Text(
                'TabPageSelector Basics',
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
                'TabPageSelector displays a row of circular indicators that show '
                'which tab is currently selected. It works with TabController to '
                'sync with TabBar and TabBarView.',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.teal.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Key Properties:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade700,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    _buildPropertyRow('controller', 'TabController to sync with'),
                    _buildPropertyRow('color', 'Selected indicator fill color'),
                    _buildPropertyRow('selectedColor', 'Unselected indicator color'),
                    _buildPropertyRow('indicatorSize', 'Diameter of dot indicators'),
                    _buildPropertyRow('borderStyle', 'Border styling for indicators'),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              // Visual indicator simulation
              Center(
                child: Column(
                  children: [
                    Text(
                      'Simulated Page Indicators:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    _buildSimulatedIndicators(5, 2, Colors.teal, 12.0),
                    SizedBox(height: 8.0),
                    Text(
                      'Page 3 of 5',
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
      ],
    ),
  );
  print('Created fundamentals card');

  // ============================================================
  // SECTION 2: Color Customization
  // ============================================================
  print('=== Section 2: Color Customization ===');

  final colorExamples = <Widget>[];
  final colorSchemes = [
    {'name': 'Default', 'selected': Colors.grey, 'unselected': Colors.grey.shade300},
    {'name': 'Blue', 'selected': Colors.blue, 'unselected': Colors.blue.shade100},
    {'name': 'Green', 'selected': Colors.green, 'unselected': Colors.green.shade100},
    {'name': 'Orange', 'selected': Colors.orange, 'unselected': Colors.orange.shade100},
    {'name': 'Purple', 'selected': Colors.purple, 'unselected': Colors.purple.shade100},
    {'name': 'Pink', 'selected': Colors.pink, 'unselected': Colors.pink.shade100},
    {'name': 'Cyan', 'selected': Colors.cyan, 'unselected': Colors.cyan.shade100},
    {'name': 'Amber', 'selected': Colors.amber, 'unselected': Colors.amber.shade100},
  ];

  for (final scheme in colorSchemes) {
    print('Color: ${scheme['name']}');
    colorExamples.add(
      Container(
        width: 140.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: (scheme['selected'] as Color).withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          children: [
            Text(
              scheme['name'] as String,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: scheme['selected'] as Color,
              ),
            ),
            SizedBox(height: 12.0),
            _buildSimulatedIndicators(
              4,
              1,
              scheme['selected'] as Color,
              10.0,
              unselectedColor: scheme['unselected'] as Color,
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${colorExamples.length} color examples');

  // ============================================================
  // SECTION 3: Size Variations
  // ============================================================
  print('=== Section 3: Size Variations ===');

  final sizeCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.purple.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.purple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.aspect_ratio, color: Colors.purple, size: 28.0),
            SizedBox(width: 12.0),
            Text(
              'Indicator Sizes',
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
          'The indicatorSize property controls the diameter of each dot. '
          'Default size is 12.0 logical pixels.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 20.0),

        // Size 8
        _buildSizeExample('Small (8.0)', 8.0, Colors.purple.shade300),
        SizedBox(height: 16.0),

        // Size 12 (default)
        _buildSizeExample('Default (12.0)', 12.0, Colors.purple.shade500),
        SizedBox(height: 16.0),

        // Size 16
        _buildSizeExample('Medium (16.0)', 16.0, Colors.purple.shade600),
        SizedBox(height: 16.0),

        // Size 20
        _buildSizeExample('Large (20.0)', 20.0, Colors.purple.shade700),
        SizedBox(height: 16.0),

        // Size 24
        _buildSizeExample('Extra Large (24.0)', 24.0, Colors.purple.shade800),
      ],
    ),
  );
  print('Created size card');

  // ============================================================
  // SECTION 4: Border Styling
  // ============================================================
  print('=== Section 4: Border Styling ===');

  final borderCard = Container(
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
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.border_style, color: Colors.orange, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Border Styles',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade900,
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
                'Indicators can have solid borders or no borders at all. '
                'The borderStyle property accepts BorderStyle.solid or BorderStyle.none.',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 20.0),

              // Solid border (default)
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BorderStyle.solid',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                            ),
                          ),
                          Text(
                            'Shows outline on unselected',
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildBorderedIndicators(4, 1, true, Colors.orange),
                  ],
                ),
              ),
              SizedBox(height: 12.0),

              // No border
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BorderStyle.none',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                            ),
                          ),
                          Text(
                            'Clean look with fill only',
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildBorderedIndicators(4, 1, false, Colors.orange),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created border card');

  // ============================================================
  // SECTION 5: Page Positions
  // ============================================================
  print('=== Section 5: Page Positions ===');

  final positionsCard = Container(
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
              Icon(Icons.adjust, color: Colors.blue, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Selection States',
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('First Page', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)),
                      SizedBox(height: 8.0),
                      _buildSimulatedIndicators(5, 0, Colors.blue, 14.0),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Second Page', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)),
                      SizedBox(height: 8.0),
                      _buildSimulatedIndicators(5, 1, Colors.blue, 14.0),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('Middle Page', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)),
                      SizedBox(height: 8.0),
                      _buildSimulatedIndicators(5, 2, Colors.blue, 14.0),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Last Page', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)),
                      SizedBox(height: 8.0),
                      _buildSimulatedIndicators(5, 4, Colors.blue, 14.0),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created positions card');

  // ============================================================
  // SECTION 6: Onboarding Example
  // ============================================================
  print('=== Section 6: Onboarding Example ===');

  final onboardingCard = Container(
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
            children: [
              Text(
                'Welcome to MyApp',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Onboarding Flow',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Simulated onboarding page content
              Container(
                padding: EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.rocket_launch,
                        color: Colors.indigo,
                        size: 48.0,
                      ),
                    ),
                    SizedBox(height: 24.0),
                    Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo.shade900,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Begin your journey with our app',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.0),
              // Page indicators
              _buildSimulatedIndicators(4, 0, Colors.indigo, 10.0),
              SizedBox(height: 24.0),
              // Navigation buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text('Skip', style: TextStyle(color: Colors.grey)),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.indigo.shade400, Colors.indigo.shade600],
                      ),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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
  );
  print('Created onboarding card');

  // ============================================================
  // SECTION 7: Image Gallery Example
  // ============================================================
  print('=== Section 7: Image Gallery Example ===');

  final galleryCard = Container(
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.3),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          height: 200.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade400, Colors.purple.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image, color: Colors.white, size: 48.0),
                    SizedBox(height: 8.0),
                    Text(
                      'Photo 3 of 6',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
              // Left arrow
              Positioned(
                left: 16.0,
                top: 0.0,
                bottom: 0.0,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.chevron_left, color: Colors.white),
                  ),
                ),
              ),
              // Right arrow
              Positioned(
                right: 16.0,
                top: 0.0,
                bottom: 0.0,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.chevron_right, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // White indicators on dark background
              _buildSimulatedIndicators(6, 2, Colors.white, 8.0, unselectedColor: Colors.white24),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Summer Vacation 2024',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.favorite_border, color: Colors.white70, size: 20.0),
                      SizedBox(width: 12.0),
                      Icon(Icons.share, color: Colors.white70, size: 20.0),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created gallery card');

  // ============================================================
  // SECTION 8: API Reference Summary
  // ============================================================
  print('=== Section 8: API Reference Summary ===');

  final apiItems = [
    {
      'signature': 'TabPageSelector({...})',
      'description': 'Creates page indicator dots',
      'icon': Icons.more_horiz,
    },
    {
      'signature': 'controller: TabController?',
      'description': 'Links to TabController for sync',
      'icon': Icons.sync,
    },
    {
      'signature': 'indicatorSize: double',
      'description': 'Diameter of each dot (default 12.0)',
      'icon': Icons.circle,
    },
    {
      'signature': 'color: Color?',
      'description': 'Fill color for unselected indicators',
      'icon': Icons.palette,
    },
    {
      'signature': 'selectedColor: Color?',
      'description': 'Fill color for selected indicator',
      'icon': Icons.color_lens,
    },
    {
      'signature': 'borderStyle: BorderStyle?',
      'description': 'Border style (solid or none)',
      'icon': Icons.border_style,
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

  // Related widgets
  final relatedWidgets = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.amber.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.amber.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.link, color: Colors.amber.shade700, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Related Widgets',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _buildRelatedChip('TabController'),
            _buildRelatedChip('TabBar'),
            _buildRelatedChip('TabBarView'),
            _buildRelatedChip('TabPageSelectorIndicator'),
            _buildRelatedChip('PageView'),
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
  print('TabPageSelector Deep Demo completed successfully');

  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.cyan],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < 5; i++)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      width: i == 2 ? 16.0 : 12.0,
                      height: i == 2 ? 16.0 : 12.0,
                      decoration: BoxDecoration(
                        color: i == 2 ? Colors.white : Colors.white38,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: i == 2 ? 0 : 1.5,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                'TabPageSelector Deep Demo',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black38, blurRadius: 4.0)],
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Page indicator dots for tab views',
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

        // Section 2: Colors
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 2: Color Schemes', Icons.palette),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: colorExamples,
          ),
        ),

        // Section 3: Sizes
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 3: Size Variations', Icons.aspect_ratio),
        sizeCard,

        // Section 4: Borders
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 4: Border Styles', Icons.border_style),
        borderCard,

        // Section 5: Positions
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 5: Selection States', Icons.adjust),
        positionsCard,

        // Section 6: Onboarding
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 6: Onboarding Flow', Icons.rocket_launch),
        onboardingCard,

        // Section 7: Gallery
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 7: Image Gallery', Icons.photo_library),
        galleryCard,

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
        Icon(Icons.chevron_right, size: 16.0, color: Colors.teal.shade400),
        SizedBox(width: 4.0),
        Text(
          '$name: ',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade700,
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

// Helper: Build simulated page indicators
Widget _buildSimulatedIndicators(
  int count,
  int selected,
  Color selectedColor,
  double size, {
  Color? unselectedColor,
}) {
  final dots = <Widget>[];
  for (var i = 0; i < count; i++) {
    dots.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 3.0),
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: i == selected ? selectedColor : (unselectedColor ?? selectedColor.withValues(alpha: 0.3)),
          shape: BoxShape.circle,
          border: i != selected
              ? Border.all(color: selectedColor.withValues(alpha: 0.5), width: 1.0)
              : null,
        ),
      ),
    );
  }
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: dots,
  );
}

// Helper: Build bordered indicators
Widget _buildBorderedIndicators(int count, int selected, bool hasBorder, Color color) {
  final dots = <Widget>[];
  for (var i = 0; i < count; i++) {
    dots.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 3.0),
        width: 14.0,
        height: 14.0,
        decoration: BoxDecoration(
          color: i == selected ? color : Colors.transparent,
          shape: BoxShape.circle,
          border: hasBorder ? Border.all(color: color, width: 1.5) : null,
        ),
      ),
    );
  }
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: dots,
  );
}

// Helper: Build size example
Widget _buildSizeExample(String label, double size, Color color) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.grey.shade700,
          ),
        ),
        Spacer(),
        _buildSimulatedIndicators(4, 1, color, size),
      ],
    ),
  );
}

// Helper: Build related widget chip
Widget _buildRelatedChip(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.amber.shade100,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.amber.shade300),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w500,
        color: Colors.amber.shade900,
      ),
    ),
  );
}
