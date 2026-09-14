// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests TabPageSelectorIndicator from material
// Deep Demo: Visual demonstration of the page indicator dot widget
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TabPageSelectorIndicator Deep Demo executing');

  // ============================================================
  // SECTION 1: TabPageSelectorIndicator Fundamentals
  // ============================================================
  print('=== Section 1: TabPageSelectorIndicator Fundamentals ===');

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
              Icon(Icons.fiber_manual_record, color: Colors.white, size: 28.0),
              SizedBox(width: 12.0),
              Text(
                'Indicator Fundamentals',
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
                'TabPageSelectorIndicator is a single dot indicator used to represent '
                'page selection state. It\'s the building block of TabPageSelector, '
                'displaying as filled (selected) or outlined (unselected).',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 24.0),
              
              // Basic states comparison
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Unselected
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: TabPageSelectorIndicator(
                          backgroundColor: Colors.indigo,
                          borderColor: Colors.indigo,
                          size: 24.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Selected',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          color: Colors.indigo,
                        ),
                      ),
                      Text(
                        'backgroundColor set',
                        style: TextStyle(fontSize: 10.0, color: Colors.grey),
                      ),
                    ],
                  ),
                  // Selected
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: TabPageSelectorIndicator(
                          backgroundColor: Colors.transparent,
                          borderColor: Colors.indigo,
                          size: 24.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Unselected',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        'backgroundColor transparent',
                        style: TextStyle(fontSize: 10.0, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              
              SizedBox(height: 24.0),
              
              // Simple indicator row
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    Text(
                      'Combined in a Row (mimics TabPageSelector):',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: Colors.indigo.shade700,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TabPageSelectorIndicator(
                          backgroundColor: Colors.indigo,
                          borderColor: Colors.indigo,
                          size: 12.0,
                        ),
                        SizedBox(width: 8.0),
                        TabPageSelectorIndicator(
                          backgroundColor: Colors.transparent,
                          borderColor: Colors.indigo,
                          size: 12.0,
                        ),
                        SizedBox(width: 8.0),
                        TabPageSelectorIndicator(
                          backgroundColor: Colors.transparent,
                          borderColor: Colors.indigo,
                          size: 12.0,
                        ),
                        SizedBox(width: 8.0),
                        TabPageSelectorIndicator(
                          backgroundColor: Colors.transparent,
                          borderColor: Colors.indigo,
                          size: 12.0,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Page 1 of 4',
                      style: TextStyle(fontSize: 11.0, color: Colors.grey),
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
  // SECTION 2: Size Variations
  // ============================================================
  print('=== Section 2: Size Variations ===');

  final sizesCard = Container(
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
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.zoom_out_map, color: Colors.teal, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Size Variations',
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
                'The size property controls the indicator diameter:',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 20.0),
              
              // Size scale
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildSizeDemo(6.0, 'Tiny'),
                  _buildSizeDemo(10.0, 'Small'),
                  _buildSizeDemo(14.0, 'Default'),
                  _buildSizeDemo(20.0, 'Large'),
                  _buildSizeDemo(28.0, 'XLarge'),
                ],
              ),
              
              SizedBox(height: 24.0),
              
              // Context examples
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Use Cases by Size:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    _buildUseCaseRow('6-8dp', 'Dense lists, compact UIs'),
                    _buildUseCaseRow('10-12dp', 'Standard page indicators'),
                    _buildUseCaseRow('14-16dp', 'Tutorial carousels'),
                    _buildUseCaseRow('20+dp', 'Hero sections, feature tours'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created sizes card');

  // ============================================================
  // SECTION 3: Color Customization
  // ============================================================
  print('=== Section 3: Color Customization ===');

  final colorsCard = Container(
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
              colors: [Colors.purple.shade400, Colors.pink.shade400],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.palette, color: Colors.white, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Color Customization',
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
                'Customize both fill (backgroundColor) and border (borderColor):',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 20.0),
              
              // Color showcase
              Wrap(
                spacing: 16.0,
                runSpacing: 16.0,
                children: [
                  _buildColorDemo('Red', Colors.red),
                  _buildColorDemo('Orange', Colors.orange),
                  _buildColorDemo('Amber', Colors.amber),
                  _buildColorDemo('Green', Colors.green),
                  _buildColorDemo('Teal', Colors.teal),
                  _buildColorDemo('Blue', Colors.blue),
                  _buildColorDemo('Indigo', Colors.indigo),
                  _buildColorDemo('Purple', Colors.purple),
                  _buildColorDemo('Pink', Colors.pink),
                ],
              ),
              
              SizedBox(height: 24.0),
              
              // Mixed colors
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mixed Fill & Border Colors:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            TabPageSelectorIndicator(
                              backgroundColor: Colors.pink,
                              borderColor: Colors.purple,
                              size: 20.0,
                            ),
                            SizedBox(height: 4.0),
                            Text('Pink/Purple', style: TextStyle(fontSize: 10.0)),
                          ],
                        ),
                        Column(
                          children: [
                            TabPageSelectorIndicator(
                              backgroundColor: Colors.amber,
                              borderColor: Colors.orange,
                              size: 20.0,
                            ),
                            SizedBox(height: 4.0),
                            Text('Amber/Orange', style: TextStyle(fontSize: 10.0)),
                          ],
                        ),
                        Column(
                          children: [
                            TabPageSelectorIndicator(
                              backgroundColor: Colors.cyan,
                              borderColor: Colors.blue,
                              size: 20.0,
                            ),
                            SizedBox(height: 4.0),
                            Text('Cyan/Blue', style: TextStyle(fontSize: 10.0)),
                          ],
                        ),
                        Column(
                          children: [
                            TabPageSelectorIndicator(
                              backgroundColor: Colors.white,
                              borderColor: Colors.grey,
                              size: 20.0,
                            ),
                            SizedBox(height: 4.0),
                            Text('White/Grey', style: TextStyle(fontSize: 10.0)),
                          ],
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
  print('Created colors card');

  // ============================================================
  // SECTION 4: Indicator Sets
  // ============================================================
  print('=== Section 4: Indicator Sets ===');

  final indicatorSetsCard = Container(
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
              Icon(Icons.more_horiz, color: Colors.blue, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Indicator Sets',
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
                'Building custom page indicators by combining multiple dots:',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 20.0),
              
              // Different page positions
              _buildIndicatorSet('3 Pages, Position 1', 3, 0, Colors.blue),
              SizedBox(height: 16.0),
              _buildIndicatorSet('5 Pages, Position 3', 5, 2, Colors.green),
              SizedBox(height: 16.0),
              _buildIndicatorSet('7 Pages, Position 5', 7, 4, Colors.orange),
              SizedBox(height: 16.0),
              _buildIndicatorSet('4 Pages, Position 4', 4, 3, Colors.purple),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created indicator sets card');

  // ============================================================
  // SECTION 5: Themed Indicators
  // ============================================================
  print('=== Section 5: Themed Indicators ===');

  final themedCard = Container(
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
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.dark_mode, color: Colors.white, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Themed Indicators',
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
              // Light theme
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    Text(
                      'Light Theme',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        final isSelected = index == 1;
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: TabPageSelectorIndicator(
                            backgroundColor: isSelected ? Colors.grey.shade800 : Colors.transparent,
                            borderColor: Colors.grey.shade800,
                            size: 12.0,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 16.0),
              
              // Dark theme
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    Text(
                      'Dark Theme',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        final isSelected = index == 1;
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: TabPageSelectorIndicator(
                            backgroundColor: isSelected ? Colors.white : Colors.transparent,
                            borderColor: Colors.white70,
                            size: 12.0,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 16.0),
              
              // Accent themes
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue.shade700, Colors.blue.shade900],
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        children: [
                          Text('Ocean', style: TextStyle(color: Colors.white, fontSize: 11.0)),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(4, (index) {
                              final isSelected = index == 0;
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.0),
                                child: TabPageSelectorIndicator(
                                  backgroundColor: isSelected ? Colors.cyan : Colors.transparent,
                                  borderColor: Colors.cyan,
                                  size: 10.0,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.orange.shade400, Colors.red.shade400],
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        children: [
                          Text('Sunset', style: TextStyle(color: Colors.white, fontSize: 11.0)),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(4, (index) {
                              final isSelected = index == 2;
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.0),
                                child: TabPageSelectorIndicator(
                                  backgroundColor: isSelected ? Colors.yellow : Colors.transparent,
                                  borderColor: Colors.yellow,
                                  size: 10.0,
                                ),
                              );
                            }),
                          ),
                        ],
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
  print('Created themed card');

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
              colors: [Colors.deepPurple, Colors.indigo],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Column(
            children: [
              Icon(Icons.rocket_launch, color: Colors.white, size: 48.0),
              SizedBox(height: 16.0),
              Text(
                'Welcome to MyApp',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Discover amazing features',
                style: TextStyle(
                  fontSize: 14.0,
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
              // Onboarding content area
              Container(
                height: 120.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.explore, size: 48.0, color: Colors.indigo),
                    SizedBox(height: 12.0),
                    Text(
                      'Explore Features',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Swipe to learn more about what you can do',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 24.0),
              
              // Page indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  final isSelected = index == 0;
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.0),
                    child: TabPageSelectorIndicator(
                      backgroundColor: isSelected ? Colors.indigo : Colors.transparent,
                      borderColor: Colors.indigo,
                      size: 12.0,
                    ),
                  );
                }),
              ),
              
              SizedBox(height: 24.0),
              
              // Navigation buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text('Skip'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Next'),
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
  // SECTION 7: Image Carousel Example
  // ============================================================
  print('=== Section 7: Image Carousel Example ===');

  final carouselCard = Container(
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black38,
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        // Header
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(Icons.photo_library, color: Colors.white, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Image Carousel',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        
        // Image placeholder
        Container(
          height: 180.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade400, Colors.purple.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.image, color: Colors.white54, size: 48.0),
                SizedBox(height: 8.0),
                Text(
                  'Image 2 of 5',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // Indicators overlay
        Container(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final isSelected = index == 1;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: TabPageSelectorIndicator(
                  backgroundColor: isSelected ? Colors.white : Colors.white24,
                  borderColor: Colors.white,
                  size: 8.0,
                ),
              );
            }),
          ),
        ),
      ],
    ),
  );
  print('Created carousel card');

  // ============================================================
  // SECTION 8: API Reference Summary
  // ============================================================
  print('=== Section 8: API Reference Summary ===');

  final apiCard = Container(
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
        
        _buildApiRow('backgroundColor', 'Color', 'Fill color (transparent = unselected)'),
        _buildApiRow('borderColor', 'Color', 'Border/outline color'),
        _buildApiRow('size', 'double', 'Diameter of the indicator dot'),
        
        SizedBox(height: 16.0),
        
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.lightbulb, color: Colors.amber.shade700, size: 20.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Usage Tips:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: Colors.amber.shade900,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      '• Set backgroundColor to transparent for unselected state\n'
                      '• Use consistent borderColor across all indicators\n'
                      '• Consider TabPageSelector for automatic state management',
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.amber.shade800,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
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
          child: Row(
            children: [
              Icon(Icons.info, color: Colors.blue.shade700, size: 20.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'TabPageSelectorIndicator is typically used as a building block for '
                  'custom page indicators. For standard usage, prefer TabPageSelector.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.blue.shade900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created API card');

  // ============================================================
  // Final Layout Assembly
  // ============================================================
  print('TabPageSelectorIndicator Deep Demo completed successfully');

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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: TabPageSelectorIndicator(
                      backgroundColor: index == 2 ? Colors.white : Colors.white38,
                      borderColor: Colors.white,
                      size: index == 2 ? 16.0 : 12.0,
                    ),
                  );
                }),
              ),
              SizedBox(height: 20.0),
              Text(
                'TabPageSelectorIndicator',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black38, blurRadius: 4.0)],
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Deep Demo',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'The single dot indicator for page selection',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.white60,
                ),
              ),
            ],
          ),
        ),

        // Sections
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 1: Fundamentals', Icons.school),
        fundamentalsCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 2: Size Variations', Icons.zoom_out_map),
        sizesCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 3: Color Customization', Icons.palette),
        colorsCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 4: Indicator Sets', Icons.more_horiz),
        indicatorSetsCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 5: Themed Indicators', Icons.dark_mode),
        themedCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 6: Onboarding Example', Icons.rocket_launch),
        onboardingCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 7: Image Carousel', Icons.photo_library),
        carouselCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 8: API Reference', Icons.api),
        apiCard,

        SizedBox(height: 32.0),
      ],
    ),
  );
}

// Helper: Section header
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

// Helper: Size demo
Widget _buildSizeDemo(double size, String label) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.teal.shade50,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: TabPageSelectorIndicator(
          backgroundColor: Colors.teal,
          borderColor: Colors.teal,
          size: size,
        ),
      ),
      SizedBox(height: 6.0),
      Text(
        label,
        style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
      ),
      Text(
        '${size.toInt()}dp',
        style: TextStyle(fontSize: 9.0, color: Colors.grey),
      ),
    ],
  );
}

// Helper: Use case row
Widget _buildUseCaseRow(String size, String useCase) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(
          width: 50.0,
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: Colors.teal.shade100,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            size,
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(width: 8.0),
        Text(
          useCase,
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
        ),
      ],
    ),
  );
}

// Helper: Color demo
Widget _buildColorDemo(String name, MaterialColor color) {
  return Column(
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabPageSelectorIndicator(
            backgroundColor: color,
            borderColor: color,
            size: 16.0,
          ),
          SizedBox(width: 4.0),
          TabPageSelectorIndicator(
            backgroundColor: Colors.transparent,
            borderColor: color,
            size: 16.0,
          ),
        ],
      ),
      SizedBox(height: 4.0),
      Text(name, style: TextStyle(fontSize: 9.0)),
    ],
  );
}

// Helper: Indicator set
Widget _buildIndicatorSet(String label, int total, int selected, Color color) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),
          ),
        ),
        Row(
          children: List.generate(total, (index) {
            final isSelected = index == selected;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.0),
              child: TabPageSelectorIndicator(
                backgroundColor: isSelected ? color : Colors.transparent,
                borderColor: color,
                size: 10.0,
              ),
            );
          }),
        ),
      ],
    ),
  );
}

// Helper: API row
Widget _buildApiRow(String prop, String type, String desc) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.blueGrey.shade100),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110.0,
          child: Text(
            prop,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
        ),
        SizedBox(
          width: 60.0,
          child: Text(
            type,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.grey.shade700,
            ),
          ),
        ),
      ],
    ),
  );
}
