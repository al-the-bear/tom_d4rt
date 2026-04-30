// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests RawChip from material
// Deep Demo: Visual demonstration of the foundational chip widget
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawChip Deep Demo executing');

  // ============================================================
  // SECTION 1: RawChip Fundamentals
  // ============================================================
  print('=== Section 1: RawChip Fundamentals ===');

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
              colors: [Colors.deepPurple.shade400, Colors.deepPurple.shade600],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.memory, color: Colors.white, size: 28.0),
              SizedBox(width: 12.0),
              Text(
                'RawChip Anatomy',
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
                'RawChip is the foundation for Material chips. It provides a compact element '
                'that represents an entity, attribute, or action. All other chip types '
                '(Chip, ActionChip, ChoiceChip, FilterChip, InputChip) are built on RawChip.',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 20.0),
              
              // Basic chip examples
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
                spacing: 12.0,
                runSpacing: 12.0,
                children: [
                  // Label only
                  RawChip(
                    label: Text('Label Only'),
                  ),
                  // With avatar
                  RawChip(
                    avatar: CircleAvatar(
                      backgroundColor: Colors.deepPurple.shade100,
                      child: Icon(Icons.person, size: 16.0, color: Colors.deepPurple),
                    ),
                    label: Text('With Avatar'),
                  ),
                  // With delete icon
                  RawChip(
                    label: Text('Deletable'),
                    onDeleted: () {
                      print('Delete pressed');
                    },
                  ),
                  // With avatar and delete
                  RawChip(
                    avatar: CircleAvatar(
                      backgroundColor: Colors.green.shade100,
                      child: Text('JD', style: TextStyle(fontSize: 10.0, color: Colors.green.shade700)),
                    ),
                    label: Text('Full Chip'),
                    onDeleted: () {
                      print('Delete full chip');
                    },
                  ),
                ],
              ),
              
              SizedBox(height: 24.0),
              
              // Chip anatomy diagram
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.deepPurple.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chip Anatomy:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple.shade700,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      children: [
                        // Visual anatomy
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(color: Colors.deepPurple.shade300),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.blue, width: 2.0),
                                ),
                                child: Icon(Icons.face, size: 18.0, color: Colors.blue),
                              ),
                              SizedBox(width: 8.0),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  border: Border.all(color: Colors.green, width: 2.0),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  'Label',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.green.shade700,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Container(
                                padding: EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade100,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.red, width: 2.0),
                                ),
                                child: Icon(Icons.close, size: 14.0, color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16.0),
                        // Legend
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLegendItem(Colors.blue, 'Avatar'),
                            SizedBox(height: 4.0),
                            _buildLegendItem(Colors.green, 'Label'),
                            SizedBox(height: 4.0),
                            _buildLegendItem(Colors.red, 'Delete Icon'),
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
  print('Created fundamentals card');

  // ============================================================
  // SECTION 2: Selection States
  // ============================================================
  print('=== Section 2: Selection States ===');

  final selectionCard = Container(
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
              Icon(Icons.check_circle, color: Colors.blue, size: 24.0),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RawChip can display selection states using the selected property '
                'and respond to taps with showCheckmark for visual feedback:',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 16.0),
              
              // Unselected vs Selected
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Unselected',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(height: 12.0),
                          RawChip(
                            label: Text('Category'),
                            selected: false,
                            onSelected: (value) {
                              print('Selected: $value');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Selected',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: Colors.blue.shade600,
                            ),
                          ),
                          SizedBox(height: 12.0),
                          RawChip(
                            label: Text('Category'),
                            selected: true,
                            showCheckmark: true,
                            onSelected: (value) {
                              print('Selected: $value');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 20.0),
              
              // Selection variations
              Text(
                'Selection Variations:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                ),
              ),
              SizedBox(height: 12.0),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  RawChip(
                    label: Text('With Check'),
                    selected: true,
                    showCheckmark: true,
                    checkmarkColor: Colors.white,
                    selectedColor: Colors.green,
                    onSelected: (v) {},
                  ),
                  RawChip(
                    label: Text('No Check'),
                    selected: true,
                    showCheckmark: false,
                    selectedColor: Colors.orange,
                    onSelected: (v) {},
                  ),
                  RawChip(
                    avatar: CircleAvatar(
                      backgroundColor: Colors.purple.shade100,
                      child: Icon(Icons.star, size: 14.0, color: Colors.purple),
                    ),
                    label: Text('Avatar + Check'),
                    selected: true,
                    showCheckmark: true,
                    selectedColor: Colors.purple.shade100,
                    onSelected: (v) {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created selection card');

  // ============================================================
  // SECTION 3: Avatar Customization
  // ============================================================
  print('=== Section 3: Avatar Customization ===');

  final avatarCard = Container(
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
              Icon(Icons.account_circle, color: Colors.teal, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Avatar Customization',
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
                'The avatar property accepts any widget, allowing for rich visual customization:',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 16.0),
              
              // Different avatar types
              Wrap(
                spacing: 12.0,
                runSpacing: 12.0,
                children: [
                  // Text initials
                  RawChip(
                    avatar: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Text(
                        'AB',
                        style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.blue.shade700),
                      ),
                    ),
                    label: Text('Text Initials'),
                  ),
                  
                  // Icon avatar
                  RawChip(
                    avatar: CircleAvatar(
                      backgroundColor: Colors.green.shade100,
                      child: Icon(Icons.eco, size: 16.0, color: Colors.green),
                    ),
                    label: Text('Icon Avatar'),
                  ),
                  
                  // Emoji avatar
                  RawChip(
                    avatar: CircleAvatar(
                      backgroundColor: Colors.amber.shade100,
                      child: Text('🎉', style: TextStyle(fontSize: 14.0)),
                    ),
                    label: Text('Emoji'),
                  ),
                  
                  // Number badge
                  RawChip(
                    avatar: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Text(
                        '5',
                        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    label: Text('Count Badge'),
                  ),
                  
                  // Gradient avatar
                  RawChip(
                    avatar: Container(
                      width: 24.0,
                      height: 24.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.purple, Colors.pink],
                        ),
                      ),
                      child: Icon(Icons.favorite, size: 14.0, color: Colors.white),
                    ),
                    label: Text('Gradient'),
                  ),
                  
                  // Status indicator
                  RawChip(
                    avatar: Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade200,
                          child: Icon(Icons.person, size: 16.0, color: Colors.grey),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 8.0,
                            height: 8.0,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 1.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                    label: Text('Online Status'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created avatar card');

  // ============================================================
  // SECTION 4: Chip Colors & Theming
  // ============================================================
  print('=== Section 4: Chip Colors & Theming ===');

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
                'Colors & Theming',
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
                'RawChip offers extensive color customization:',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 16.0),
              
              // Color variants
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildColorRow('backgroundColor', [
                    RawChip(
                      label: Text('Default'),
                    ),
                    RawChip(
                      label: Text('Custom'),
                      backgroundColor: Colors.amber.shade100,
                    ),
                    RawChip(
                      label: Text('Vibrant', style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.deepPurple,
                    ),
                  ]),
                  SizedBox(height: 16.0),
                  
                  _buildColorRow('selectedColor', [
                    RawChip(
                      label: Text('Blue'),
                      selected: true,
                      selectedColor: Colors.blue.shade100,
                      onSelected: (v) {},
                    ),
                    RawChip(
                      label: Text('Green'),
                      selected: true,
                      selectedColor: Colors.green.shade100,
                      onSelected: (v) {},
                    ),
                    RawChip(
                      label: Text('Pink'),
                      selected: true,
                      selectedColor: Colors.pink.shade100,
                      onSelected: (v) {},
                    ),
                  ]),
                  SizedBox(height: 16.0),
                  
                  _buildColorRow('disabledColor', [
                    RawChip(
                      label: Text('Disabled'),
                      isEnabled: false,
                    ),
                    RawChip(
                      label: Text('Custom'),
                      isEnabled: false,
                      disabledColor: Colors.amber.shade50,
                    ),
                  ]),
                  SizedBox(height: 16.0),
                  
                  _buildColorRow('deleteIconColor', [
                    RawChip(
                      label: Text('Default'),
                      onDeleted: () {},
                    ),
                    RawChip(
                      label: Text('Red'),
                      deleteIconColor: Colors.red,
                      onDeleted: () {},
                    ),
                    RawChip(
                      label: Text('Blue'),
                      deleteIconColor: Colors.blue,
                      onDeleted: () {},
                    ),
                  ]),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created colors card');

  // ============================================================
  // SECTION 5: Shape Customization
  // ============================================================
  print('=== Section 5: Shape Customization ===');

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
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.rounded_corner, color: Colors.indigo, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Shape Customization',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade900,
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
                'The shape property accepts OutlinedBorder for custom chip shapes:',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 16.0),
              
              Wrap(
                spacing: 12.0,
                runSpacing: 12.0,
                children: [
                  // Stadium (default)
                  RawChip(
                    label: Text('Stadium'),
                    shape: StadiumBorder(),
                    backgroundColor: Colors.indigo.shade50,
                  ),
                  
                  // Rounded rectangle
                  RawChip(
                    label: Text('Rounded'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: Colors.green.shade50,
                  ),
                  
                  // Beveled
                  RawChip(
                    label: Text('Beveled'),
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: Colors.orange.shade50,
                  ),
                  
                  // Border with stroke
                  RawChip(
                    label: Text('Outlined'),
                    shape: StadiumBorder(
                      side: BorderSide(color: Colors.purple, width: 2.0),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  
                  // Dashed-look border
                  RawChip(
                    label: Text('Stroked'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      side: BorderSide(color: Colors.teal, width: 1.5),
                    ),
                    backgroundColor: Colors.teal.shade50,
                  ),
                  
                  // Circular/pill with small radius
                  RawChip(
                    label: Text('Pill'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    backgroundColor: Colors.pink.shade50,
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
  // SECTION 6: Padding & Sizing
  // ============================================================
  print('=== Section 6: Padding & Sizing ===');

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
                'Padding & Sizing',
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
                'Control chip density with padding and materialTapTargetSize:',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 16.0),
              
              // Different padding
              Text('labelPadding variations:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)),
              SizedBox(height: 8.0),
              Wrap(
                spacing: 12.0,
                runSpacing: 12.0,
                children: [
                  RawChip(
                    label: Text('Compact'),
                    labelPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    backgroundColor: Colors.cyan.shade100,
                  ),
                  RawChip(
                    label: Text('Default'),
                    backgroundColor: Colors.cyan.shade100,
                  ),
                  RawChip(
                    label: Text('Spacious'),
                    labelPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    backgroundColor: Colors.cyan.shade100,
                  ),
                ],
              ),
              
              SizedBox(height: 20.0),
              
              // Tap target size
              Text('materialTapTargetSize:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        children: [
                          Text('padded', style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
                          SizedBox(height: 8.0),
                          RawChip(
                            label: Text('Tap Area'),
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            backgroundColor: Colors.cyan.shade100,
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
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        children: [
                          Text('shrinkWrap', style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
                          SizedBox(height: 8.0),
                          RawChip(
                            label: Text('Tap Area'),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            backgroundColor: Colors.cyan.shade100,
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
  print('Created sizing card');

  // ============================================================
  // SECTION 7: Tag Cloud Example
  // ============================================================
  print('=== Section 7: Tag Cloud Example ===');

  final tags = [
    {'label': 'Flutter', 'color': Colors.blue, 'selected': true},
    {'label': 'Dart', 'color': Colors.teal, 'selected': true},
    {'label': 'Mobile', 'color': Colors.green, 'selected': false},
    {'label': 'Web', 'color': Colors.orange, 'selected': false},
    {'label': 'Desktop', 'color': Colors.purple, 'selected': false},
    {'label': 'UI/UX', 'color': Colors.pink, 'selected': true},
    {'label': 'Material', 'color': Colors.indigo, 'selected': false},
    {'label': 'Animation', 'color': Colors.amber, 'selected': false},
  ];

  final tagCloudCard = Container(
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
              colors: [Colors.grey.shade800, Colors.grey.shade900],
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
                  Icon(Icons.tag, color: Colors.white, size: 24.0),
                  SizedBox(width: 12.0),
                  Text(
                    'Skills & Interests',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Text(
                'Select your areas of expertise',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: tags.map((tag) {
              final color = tag['color'] as Color;
              final isSelected = tag['selected'] as bool;
              return RawChip(
                avatar: isSelected
                    ? null
                    : CircleAvatar(
                        backgroundColor: color.withValues(alpha: 0.2),
                        child: Icon(Icons.add, size: 14.0, color: color),
                      ),
                label: Text(
                  tag['label'] as String,
                  style: TextStyle(
                    color: isSelected ? Colors.white : color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                selected: isSelected,
                showCheckmark: isSelected,
                checkmarkColor: Colors.white,
                selectedColor: color,
                backgroundColor: color.withValues(alpha: 0.1),
                shape: StadiumBorder(
                  side: BorderSide(
                    color: isSelected ? color : color.withValues(alpha: 0.3),
                  ),
                ),
                onSelected: (value) {
                  print('${tag['label']} selected: $value');
                },
              );
            }).toList(),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '3 selected',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13.0,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  'Save Preferences',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created tag cloud card');

  // ============================================================
  // SECTION 8: Contact Chips Example
  // ============================================================
  print('=== Section 8: Contact Chips Example ===');

  final contacts = [
    {'name': 'Alice Smith', 'initials': 'AS', 'color': Colors.blue},
    {'name': 'Bob Johnson', 'initials': 'BJ', 'color': Colors.green},
    {'name': 'Carol White', 'initials': 'CW', 'color': Colors.purple},
  ];

  final contactsCard = Container(
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
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.people, color: Colors.blue, size: 24.0),
              SizedBox(width: 12.0),
              Text(
                'Email Recipients',
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
                'To:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    ...contacts.map((contact) {
                      final color = contact['color'] as MaterialColor;
                      return RawChip(
                        avatar: CircleAvatar(
                          backgroundColor: color.shade100,
                          child: Text(
                            contact['initials'] as String,
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: color.shade700,
                            ),
                          ),
                        ),
                        label: Text(
                          contact['name'] as String,
                          style: TextStyle(fontSize: 13.0),
                        ),
                        onDeleted: () {
                          print('Remove ${contact['name']}');
                        },
                        deleteIcon: Icon(Icons.close, size: 16.0),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      );
                    }),
                    // Add more chip
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add, size: 16.0, color: Colors.grey),
                          SizedBox(width: 4.0),
                          Text(
                            'Add',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13.0,
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
      ],
    ),
  );
  print('Created contacts card');

  // ============================================================
  // SECTION 9: API Reference Summary
  // ============================================================
  print('=== Section 9: API Reference Summary ===');

  final apiItems = [
    {'prop': 'label', 'type': 'Widget', 'desc': 'Primary content of the chip'},
    {'prop': 'avatar', 'type': 'Widget?', 'desc': 'Leading circular widget'},
    {'prop': 'selected', 'type': 'bool', 'desc': 'Selection state'},
    {'prop': 'onSelected', 'type': 'ValueChanged<bool>?', 'desc': 'Selection callback'},
    {'prop': 'onDeleted', 'type': 'VoidCallback?', 'desc': 'Delete callback'},
    {'prop': 'onPressed', 'type': 'VoidCallback?', 'desc': 'Tap callback'},
    {'prop': 'backgroundColor', 'type': 'Color?', 'desc': 'Background fill color'},
    {'prop': 'selectedColor', 'type': 'Color?', 'desc': 'Fill when selected'},
    {'prop': 'disabledColor', 'type': 'Color?', 'desc': 'Fill when disabled'},
    {'prop': 'shape', 'type': 'OutlinedBorder?', 'desc': 'Border shape'},
    {'prop': 'showCheckmark', 'type': 'bool', 'desc': 'Show checkmark when selected'},
    {'prop': 'isEnabled', 'type': 'bool', 'desc': 'Enable/disable interaction'},
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
              Container(
                width: 100.0,
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
              Container(
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
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info, color: Colors.amber.shade700, size: 20.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'RawChip is the base for Chip, ActionChip, ChoiceChip, FilterChip, and InputChip.',
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
  print('Created API card');

  // ============================================================
  // Final Layout Assembly
  // ============================================================
  print('RawChip Deep Demo completed successfully');

  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.indigo],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RawChip(
                    avatar: CircleAvatar(
                      backgroundColor: Colors.white24,
                      child: Icon(Icons.code, size: 14.0, color: Colors.white),
                    ),
                    label: Text('Raw', style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.white12,
                  ),
                  SizedBox(width: 8.0),
                  RawChip(
                    label: Text('Chip', style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.white24,
                    onDeleted: () {},
                    deleteIconColor: Colors.white70,
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                'RawChip Deep Demo',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black38, blurRadius: 4.0)],
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'The foundational chip widget for Material Design',
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
        _buildSectionHeader('Section 2: Selection States', Icons.check_circle),
        selectionCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 3: Avatars', Icons.account_circle),
        avatarCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 4: Colors & Theming', Icons.palette),
        colorsCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 5: Shape Customization', Icons.rounded_corner),
        shapesCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 6: Padding & Sizing', Icons.aspect_ratio),
        sizingCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 7: Tag Cloud', Icons.tag),
        tagCloudCard,

        SizedBox(height: 24.0),
        _buildSectionHeader('Section 8: Contact Chips', Icons.people),
        contactsCard,

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

// Helper: Legend item
Widget _buildLegendItem(MaterialColor color, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 12.0,
        height: 12.0,
        decoration: BoxDecoration(
          color: color.shade100,
          border: Border.all(color: color, width: 2.0),
          borderRadius: BorderRadius.circular(2.0),
        ),
      ),
      SizedBox(width: 6.0),
      Text(
        label,
        style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
      ),
    ],
  );
}

// Helper: Color demo row
Widget _buildColorRow(String propertyName, List<Widget> chips) {
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
          propertyName,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(height: 8.0),
      Wrap(
        spacing: 10.0,
        runSpacing: 8.0,
        children: chips,
      ),
    ],
  );
}
