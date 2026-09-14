// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests RawMaterialButton from material
// Deep Demo: Visual demonstration of the low-level Material button widget
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawMaterialButton Deep Demo executing');

  // ============================================================
  // SECTION 1: RawMaterialButton Fundamentals
  // ============================================================
  print('=== Section 1: RawMaterialButton Fundamentals ===');

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
              colors: [Colors.blue.shade400, Colors.blue.shade600],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.touch_app, color: Colors.white, size: 28.0),
              SizedBox(width: 12.0),
              Text(
                'RawMaterialButton Fundamentals',
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
                'RawMaterialButton is a low-level widget for building custom Material buttons. '
                'It provides ink splash effects, elevation, and shape customization while '
                'giving you full control over the button\'s appearance.',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 20.0),
              
              // Basic examples
              Text(
                'Basic Variants:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 12.0),
              
              Wrap(
                spacing: 16.0,
                runSpacing: 16.0,
                children: [
                  // Basic button
                  RawMaterialButton(
                    onPressed: () {
                      print('Basic button pressed');
                    },
                    child: Text('Basic'),
                  ),
                  
                  // Filled button
                  RawMaterialButton(
                    onPressed: () {
                      print('Filled button pressed');
                    },
                    fillColor: Colors.blue,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text('Filled', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  
                  // Outlined button
                  RawMaterialButton(
                    onPressed: () {
                      print('Outlined button pressed');
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      side: BorderSide(color: Colors.blue, width: 1.5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text('Outlined', style: TextStyle(color: Colors.blue)),
                    ),
                  ),
                  
                  // Icon button
                  RawMaterialButton(
                    onPressed: () {
                      print('Icon button pressed');
                    },
                    shape: CircleBorder(),
                    constraints: BoxConstraints(minWidth: 48.0, minHeight: 48.0),
                    child: Icon(Icons.favorite, color: Colors.pink),
                  ),
                ],
              ),
              
              SizedBox(height: 20.0),
              
              // Info box
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
                    Icon(Icons.info, color: Colors.amber.shade700, size: 20.0),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        'Note: RawMaterialButton is a lower-level alternative to ElevatedButton, '
                        'TextButton, and OutlinedButton. Use it when you need custom button styling.',
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
        ),
      ],
    ),
  );
  print('Created fundamentals card');

  // ============================================================
  // SECTION 2: Shape Variations
  // ============================================================
  print('=== Section 2: Shape Variations ===');

  final shapesCard = Container(
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
              Icon(Icons.category, color: Colors.purple, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Shape Variations',
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
                'The shape property accepts ShapeBorder for custom button shapes:',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 16.0),
              
              Wrap(
                spacing: 16.0,
                runSpacing: 16.0,
                children: [
                  // Rectangle
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: () {},
                        fillColor: Colors.purple.shade100,
                        shape: RoundedRectangleBorder(),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(Icons.crop_square, color: Colors.purple),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text('Rectangle', style: TextStyle(fontSize: 10.0)),
                    ],
                  ),
                  
                  // Rounded
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: () {},
                        fillColor: Colors.indigo.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(Icons.rounded_corner, color: Colors.indigo),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text('Rounded', style: TextStyle(fontSize: 10.0)),
                    ],
                  ),
                  
                  // Circle
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: () {},
                        fillColor: Colors.blue.shade100,
                        shape: CircleBorder(),
                        constraints: BoxConstraints(minWidth: 50.0, minHeight: 50.0),
                        child: Icon(Icons.circle, color: Colors.blue),
                      ),
                      SizedBox(height: 4.0),
                      Text('Circle', style: TextStyle(fontSize: 10.0)),
                    ],
                  ),
                  
                  // Stadium
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: () {},
                        fillColor: Colors.green.shade100,
                        shape: StadiumBorder(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                          child: Icon(Icons.horizontal_rule, color: Colors.green),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text('Stadium', style: TextStyle(fontSize: 10.0)),
                    ],
                  ),
                  
                  // Beveled
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: () {},
                        fillColor: Colors.orange.shade100,
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(Icons.pentagon, color: Colors.orange),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text('Beveled', style: TextStyle(fontSize: 10.0)),
                    ],
                  ),
                  
                  // Continuous
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: () {},
                        fillColor: Colors.teal.shade100,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(Icons.square_rounded, color: Colors.teal),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text('Continuous', style: TextStyle(fontSize: 10.0)),
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
  print('Created shapes card');

  // ============================================================
  // SECTION 3: Elevation & Shadow
  // ============================================================
  print('=== Section 3: Elevation & Shadow ===');

  final elevationCard = Container(
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
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.layers, color: Colors.grey.shade700, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Elevation & Shadow',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade900,
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
                'Control button depth with elevation and highlightElevation:',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 20.0),
              
              // Elevation scale
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildElevationButton('0', 0.0),
                  _buildElevationButton('2', 2.0),
                  _buildElevationButton('4', 4.0),
                  _buildElevationButton('8', 8.0),
                  _buildElevationButton('16', 16.0),
                ],
              ),
              
              SizedBox(height: 24.0),
              
              // Highlight elevation
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Highlight Elevation (press to see effect):',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RawMaterialButton(
                          onPressed: () {},
                          elevation: 2.0,
                          highlightElevation: 8.0,
                          fillColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: Text('Press Me', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        RawMaterialButton(
                          onPressed: () {},
                          elevation: 0.0,
                          highlightElevation: 4.0,
                          fillColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: Text('Flat Rise', style: TextStyle(color: Colors.white)),
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
  print('Created elevation card');

  // ============================================================
  // SECTION 4: Colors & States
  // ============================================================
  print('=== Section 4: Colors & States ===');

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
              colors: [Colors.orange.shade400, Colors.red.shade400],
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
                'Colors & States',
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
              // Fill colors
              _buildColorSection('fillColor', [
                RawMaterialButton(
                  onPressed: () {},
                  fillColor: Colors.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Red', style: TextStyle(color: Colors.white)),
                  ),
                ),
                RawMaterialButton(
                  onPressed: () {},
                  fillColor: Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Green', style: TextStyle(color: Colors.white)),
                  ),
                ),
                RawMaterialButton(
                  onPressed: () {},
                  fillColor: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Blue', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ]),
              
              SizedBox(height: 16.0),
              
              // Splash and highlight colors
              _buildColorSection('splashColor', [
                RawMaterialButton(
                  onPressed: () {},
                  splashColor: Colors.pink.withValues(alpha: 0.3),
                  fillColor: Colors.pink.shade50,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Pink Splash'),
                  ),
                ),
                RawMaterialButton(
                  onPressed: () {},
                  splashColor: Colors.amber.withValues(alpha: 0.3),
                  fillColor: Colors.amber.shade50,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Amber Splash'),
                  ),
                ),
              ]),
              
              SizedBox(height: 16.0),
              
              // Disabled state
              _buildColorSection('Disabled State', [
                RawMaterialButton(
                  onPressed: () {},
                  fillColor: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Enabled', style: TextStyle(color: Colors.white)),
                  ),
                ),
                RawMaterialButton(
                  onPressed: null,
                  disabledElevation: 0.0,
                  fillColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Disabled', style: TextStyle(color: Colors.grey.shade500)),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created colors card');

  // ============================================================
  // SECTION 5: Sizing & Constraints
  // ============================================================
  print('=== Section 5: Sizing & Constraints ===');

  final sizingCard = Container(
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
              Icon(Icons.aspect_ratio, color: Colors.cyan, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Sizing & Constraints',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan.shade900,
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
                'Control button size with constraints and padding:',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 16.0),
              
              // Different sizes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Small
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: () {},
                        constraints: BoxConstraints(minWidth: 32.0, minHeight: 32.0),
                        fillColor: Colors.cyan,
                        shape: CircleBorder(),
                        child: Icon(Icons.add, size: 16.0, color: Colors.white),
                      ),
                      SizedBox(height: 4.0),
                      Text('Small', style: TextStyle(fontSize: 10.0)),
                    ],
                  ),
                  // Medium
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: () {},
                        constraints: BoxConstraints(minWidth: 48.0, minHeight: 48.0),
                        fillColor: Colors.cyan,
                        shape: CircleBorder(),
                        child: Icon(Icons.add, size: 24.0, color: Colors.white),
                      ),
                      SizedBox(height: 4.0),
                      Text('Medium', style: TextStyle(fontSize: 10.0)),
                    ],
                  ),
                  // Large
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: () {},
                        constraints: BoxConstraints(minWidth: 64.0, minHeight: 64.0),
                        fillColor: Colors.cyan,
                        shape: CircleBorder(),
                        child: Icon(Icons.add, size: 32.0, color: Colors.white),
                      ),
                      SizedBox(height: 4.0),
                      Text('Large', style: TextStyle(fontSize: 10.0)),
                    ],
                  ),
                ],
              ),
              
              SizedBox(height: 24.0),
              
              // Padding variations
              Text(
                'Padding variations:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
              SizedBox(height: 12.0),
              Wrap(
                spacing: 12.0,
                runSpacing: 12.0,
                children: [
                  RawMaterialButton(
                    onPressed: () {},
                    fillColor: Colors.cyan.shade100,
                    padding: EdgeInsets.all(4.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    child: Text('Compact'),
                  ),
                  RawMaterialButton(
                    onPressed: () {},
                    fillColor: Colors.cyan.shade100,
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    child: Text('Spacious'),
                  ),
                  RawMaterialButton(
                    onPressed: () {},
                    fillColor: Colors.cyan.shade100,
                    padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
                    shape: StadiumBorder(),
                    child: Text('Wide'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created sizing card');

  // ============================================================
  // SECTION 6: Icon Buttons Gallery
  // ============================================================
  print('=== Section 6: Icon Buttons Gallery ===');

  final iconButtonsCard = Container(
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
            color: Colors.pink.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.apps, color: Colors.pink, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Icon Buttons Gallery',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink.shade900,
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
                'RawMaterialButton works great as a custom icon button:',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 16.0),
              
              // Social media buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSocialButton(Icons.camera_alt, Colors.pink, 'Instagram'),
                  _buildSocialButton(Icons.play_arrow, Colors.red, 'YouTube'),
                  _buildSocialButton(Icons.code, Colors.grey.shade800, 'GitHub'),
                  _buildSocialButton(Icons.language, Colors.blue, 'Web'),
                ],
              ),
              
              SizedBox(height: 24.0),
              
              // Action buttons row
              Text(
                'Floating Action Buttons:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
              SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Mini FAB
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: () {},
                        fillColor: Colors.pink,
                        shape: CircleBorder(),
                        elevation: 4.0,
                        constraints: BoxConstraints(minWidth: 40.0, minHeight: 40.0),
                        child: Icon(Icons.add, color: Colors.white, size: 20.0),
                      ),
                      SizedBox(height: 4.0),
                      Text('Mini', style: TextStyle(fontSize: 10.0)),
                    ],
                  ),
                  // Regular FAB
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: () {},
                        fillColor: Colors.pink,
                        shape: CircleBorder(),
                        elevation: 6.0,
                        constraints: BoxConstraints(minWidth: 56.0, minHeight: 56.0),
                        child: Icon(Icons.add, color: Colors.white, size: 24.0),
                      ),
                      SizedBox(height: 4.0),
                      Text('Regular', style: TextStyle(fontSize: 10.0)),
                    ],
                  ),
                  // Extended FAB
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: () {},
                        fillColor: Colors.pink,
                        shape: StadiumBorder(),
                        elevation: 6.0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add, color: Colors.white, size: 20.0),
                              SizedBox(width: 8.0),
                              Text('Create', style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text('Extended', style: TextStyle(fontSize: 10.0)),
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
  print('Created icon buttons card');

  // ============================================================
  // SECTION 7: Custom Button Styles
  // ============================================================
  print('=== Section 7: Custom Button Styles ===');

  final customStylesCard = Container(
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
              colors: [Colors.indigo, Colors.purple],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.style, color: Colors.white, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Custom Button Styles',
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
              // Gradient button
              Container(
                margin: EdgeInsets.only(bottom: 16.0),
                child: RawMaterialButton(
                  onPressed: () {
                    print('Gradient button pressed');
                  },
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple, Colors.pink, Colors.orange],
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.rocket_launch, color: Colors.white),
                          SizedBox(width: 8.0),
                          Text(
                            'Launch',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
              // Neon glow button
              Container(
                margin: EdgeInsets.only(bottom: 16.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.cyan.withValues(alpha: 0.6),
                      blurRadius: 20.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: RawMaterialButton(
                  onPressed: () {
                    print('Neon button pressed');
                  },
                  fillColor: Colors.grey.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: Colors.cyan, width: 2.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
                    child: Text(
                      'NEON STYLE',
                      style: TextStyle(
                        color: Colors.cyan,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              
              // Pill buttons row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RawMaterialButton(
                    onPressed: () {},
                    fillColor: Colors.red.shade400,
                    shape: StadiumBorder(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.favorite, color: Colors.white, size: 16.0),
                          SizedBox(width: 4.0),
                          Text('Like', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: () {},
                    fillColor: Colors.blue.shade400,
                    shape: StadiumBorder(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.share, color: Colors.white, size: 16.0),
                          SizedBox(width: 4.0),
                          Text('Share', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: () {},
                    fillColor: Colors.green.shade400,
                    shape: StadiumBorder(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.bookmark, color: Colors.white, size: 16.0),
                          SizedBox(width: 4.0),
                          Text('Save', style: TextStyle(color: Colors.white)),
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
  print('Created custom styles card');

  // ============================================================
  // SECTION 8: Toolbar Example
  // ============================================================
  print('=== Section 8: Toolbar Example ===');

  final toolbarCard = Container(
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
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.edit, color: Colors.white, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Text Editor Toolbar',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        
        // Toolbar
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
          ),
          child: Row(
            children: [
              // Format buttons
              _buildToolbarButton(Icons.format_bold, false),
              _buildToolbarButton(Icons.format_italic, false),
              _buildToolbarButton(Icons.format_underlined, true),
              Container(
                width: 1.0,
                height: 24.0,
                color: Colors.grey.shade400,
                margin: EdgeInsets.symmetric(horizontal: 8.0),
              ),
              // Alignment buttons
              _buildToolbarButton(Icons.format_align_left, true),
              _buildToolbarButton(Icons.format_align_center, false),
              _buildToolbarButton(Icons.format_align_right, false),
              Container(
                width: 1.0,
                height: 24.0,
                color: Colors.grey.shade400,
                margin: EdgeInsets.symmetric(horizontal: 8.0),
              ),
              // List buttons
              _buildToolbarButton(Icons.format_list_bulleted, false),
              _buildToolbarButton(Icons.format_list_numbered, false),
              Spacer(),
              // Undo/redo
              _buildToolbarButton(Icons.undo, false),
              _buildToolbarButton(Icons.redo, false),
            ],
          ),
        ),
        
        // Content area
        Container(
          padding: EdgeInsets.all(16.0),
          height: 120.0,
          child: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
            'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey.shade700,
              height: 1.5,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created toolbar card');

  // ============================================================
  // SECTION 9: API Reference Summary
  // ============================================================
  print('=== Section 9: API Reference Summary ===');

  final apiItems = [
    {'prop': 'onPressed', 'type': 'VoidCallback?', 'desc': 'Tap callback (null = disabled)'},
    {'prop': 'onLongPress', 'type': 'VoidCallback?', 'desc': 'Long press callback'},
    {'prop': 'fillColor', 'type': 'Color?', 'desc': 'Background fill color'},
    {'prop': 'splashColor', 'type': 'Color?', 'desc': 'Ink splash color on press'},
    {'prop': 'highlightColor', 'type': 'Color?', 'desc': 'Highlight overlay color'},
    {'prop': 'elevation', 'type': 'double', 'desc': 'Default elevation (dp)'},
    {'prop': 'highlightElevation', 'type': 'double', 'desc': 'Elevation when pressed'},
    {'prop': 'disabledElevation', 'type': 'double', 'desc': 'Elevation when disabled'},
    {'prop': 'shape', 'type': 'ShapeBorder', 'desc': 'Button border shape'},
    {'prop': 'constraints', 'type': 'BoxConstraints', 'desc': 'Min/max size constraints'},
    {'prop': 'padding', 'type': 'EdgeInsets', 'desc': 'Internal padding'},
    {'prop': 'child', 'type': 'Widget', 'desc': 'Button content'},
  ];

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
        ...apiItems.map((item) => Container(
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
              SizedBox(
                width: 110.0,
                child: Text(
                  item['prop'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),
              SizedBox(
                width: 90.0,
                child: Text(
                  item['type'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.0,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  item['desc'] as String,
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    ),
  );
  print('Created API card');

  // ============================================================
  // Final Layout Assembly
  // ============================================================
  print('RawMaterialButton Deep Demo completed successfully');

  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade700, Colors.indigo.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RawMaterialButton(
                    onPressed: () {},
                    fillColor: Colors.white24,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.touch_app, color: Colors.white, size: 32.0),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'RawMaterialButton Deep Demo',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black38, blurRadius: 4.0)],
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Low-level Material button for custom designs',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white70,
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
        _buildSectionHeader('Section 2: Shape Variations', Icons.category),
        shapesCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 3: Elevation & Shadow', Icons.layers),
        elevationCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 4: Colors & States', Icons.palette),
        colorsCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 5: Sizing & Constraints', Icons.aspect_ratio),
        sizingCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 6: Icon Buttons', Icons.apps),
        iconButtonsCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 7: Custom Styles', Icons.style),
        customStylesCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 8: Toolbar Example', Icons.edit),
        toolbarCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 9: API Reference', Icons.api),
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

// Helper: Elevation button
Widget _buildElevationButton(String label, double elevation) {
  return Column(
    children: [
      RawMaterialButton(
        onPressed: () {},
        elevation: elevation,
        fillColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        constraints: BoxConstraints(minWidth: 50.0, minHeight: 50.0),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
      ),
      SizedBox(height: 4.0),
      Text(
        'dp',
        style: TextStyle(fontSize: 10.0, color: Colors.grey),
      ),
    ],
  );
}

// Helper: Color section
Widget _buildColorSection(String title, List<Widget> buttons) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(height: 8.0),
      Wrap(
        spacing: 12.0,
        runSpacing: 8.0,
        children: buttons,
      ),
    ],
  );
}

// Helper: Social button
Widget _buildSocialButton(IconData icon, Color color, String label) {
  return Column(
    children: [
      RawMaterialButton(
        onPressed: () {
          print('$label pressed');
        },
        fillColor: color,
        shape: CircleBorder(),
        elevation: 2.0,
        constraints: BoxConstraints(minWidth: 48.0, minHeight: 48.0),
        child: Icon(icon, color: Colors.white, size: 24.0),
      ),
      SizedBox(height: 4.0),
      Text(label, style: TextStyle(fontSize: 10.0)),
    ],
  );
}

// Helper: Toolbar button
Widget _buildToolbarButton(IconData icon, bool isActive) {
  return RawMaterialButton(
    onPressed: () {
      print('Toolbar button pressed');
    },
    fillColor: isActive ? Colors.blue.shade100 : Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.0),
    ),
    constraints: BoxConstraints(minWidth: 32.0, minHeight: 32.0),
    child: Icon(
      icon,
      size: 18.0,
      color: isActive ? Colors.blue : Colors.grey.shade700,
    ),
  );
}
