// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Divider and VerticalDivider widgets from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Divider widgets test executing');

  // ========== DIVIDER ==========
  print('--- Divider Tests ---');

  // Test basic Divider
  final basicDivider = Divider();
  print('Basic Divider created');

  // Test Divider with height
  final heightDivider = Divider(height: 40.0);
  print('Divider with height=40 created');

  // Test Divider with zero height
  final zeroHeightDivider = Divider(height: 0);
  print('Divider with height=0 created');

  // Test Divider with thickness
  final thickDivider = Divider(thickness: 4.0);
  print('Divider with thickness=4 created');

  // Test thin Divider
  final thinDivider = Divider(thickness: 0.5);
  print('Divider with thickness=0.5 created');

  // Test Divider with indent
  final indentDivider = Divider(indent: 20.0);
  print('Divider with indent=20 created');

  // Test Divider with endIndent
  final endIndentDivider = Divider(endIndent: 20.0);
  print('Divider with endIndent=20 created');

  // Test Divider with both indents
  final bothIndentDivider = Divider(indent: 40.0, endIndent: 40.0);
  print('Divider with indent=40, endIndent=40 created');

  // Test Divider with color
  final coloredDivider = Divider(color: Colors.red);
  print('Divider with color=red created');

  // Test various colored dividers
  final blueDivider = Divider(color: Colors.blue, thickness: 2.0);
  final greenDivider = Divider(color: Colors.green, thickness: 2.0);
  final orangeDivider = Divider(color: Colors.orange, thickness: 2.0);
  final purpleDivider = Divider(color: Colors.purple, thickness: 2.0);
  print('Various colored Dividers created');

  // Test styled Divider
  final styledDivider = Divider(
    color: Colors.teal,
    thickness: 3.0,
    height: 30.0,
    indent: 16.0,
    endIndent: 16.0,
  );
  print('Styled Divider created');

  // ========== VERTICALDIVIDER ==========
  print('--- VerticalDivider Tests ---');

  // Test basic VerticalDivider
  final basicVerticalDivider = VerticalDivider();
  print('Basic VerticalDivider created');

  // Test VerticalDivider with width
  final widthVerticalDivider = VerticalDivider(width: 40.0);
  print('VerticalDivider with width=40 created');

  // Test VerticalDivider with zero width
  final zeroWidthVerticalDivider = VerticalDivider(width: 0);
  print('VerticalDivider with width=0 created: $zeroWidthVerticalDivider');

  // Test VerticalDivider with thickness
  final thickVerticalDivider = VerticalDivider(thickness: 4.0);
  print('VerticalDivider with thickness=4 created');

  // Test thin VerticalDivider
  final thinVerticalDivider = VerticalDivider(thickness: 0.5);
  print('VerticalDivider with thickness=0.5 created: $thinVerticalDivider');

  // Test VerticalDivider with indent
  final indentVerticalDivider = VerticalDivider(indent: 20.0);
  print('VerticalDivider with indent=20 created: $indentVerticalDivider');

  // Test VerticalDivider with endIndent
  final endIndentVerticalDivider = VerticalDivider(endIndent: 20.0);
  print('VerticalDivider with endIndent=20 created: $endIndentVerticalDivider');

  // Test VerticalDivider with both indents
  final bothIndentVerticalDivider = VerticalDivider(
    indent: 10.0,
    endIndent: 10.0,
  );
  print('VerticalDivider with indent=10, endIndent=10 created');

  // Test VerticalDivider with color
  final coloredVerticalDivider = VerticalDivider(color: Colors.blue);
  print('VerticalDivider with color=blue created: $coloredVerticalDivider');

  // Test various colored vertical dividers
  final redVertical = VerticalDivider(color: Colors.red, thickness: 2.0);
  final greenVertical = VerticalDivider(color: Colors.green, thickness: 2.0);
  final orangeVertical = VerticalDivider(color: Colors.orange, thickness: 2.0);
  final purpleVertical = VerticalDivider(color: Colors.purple, thickness: 2.0);
  print('Various colored VerticalDividers created');

  // Test styled VerticalDivider
  final styledVerticalDivider = VerticalDivider(
    color: Colors.indigo,
    thickness: 3.0,
    width: 30.0,
    indent: 8.0,
    endIndent: 8.0,
  );
  print('Styled VerticalDivider created');

  print('Divider widgets test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Divider Widgets Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text(
          'Divider Examples:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),

        Text('Basic Divider:'),
        basicDivider,

        Text('With height=40 (more space):'),
        heightDivider,

        Text('With height=0 (no extra space):'),
        zeroHeightDivider,

        Text('Thick (thickness=4):'),
        thickDivider,

        Text('Thin (thickness=0.5):'),
        thinDivider,

        SizedBox(height: 16.0),
        Text('With Indents:', style: TextStyle(fontWeight: FontWeight.bold)),

        Text('Indent left:'),
        indentDivider,

        Text('Indent right:'),
        endIndentDivider,

        Text('Indent both sides:'),
        bothIndentDivider,

        SizedBox(height: 16.0),
        Text(
          'Colored Dividers:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        coloredDivider,
        blueDivider,
        greenDivider,
        orangeDivider,
        purpleDivider,

        SizedBox(height: 16.0),
        Text('Styled Divider:', style: TextStyle(fontWeight: FontWeight.bold)),
        styledDivider,

        SizedBox(height: 24.0),
        Text(
          'VerticalDivider Examples:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          '(Requires Row with IntrinsicHeight)',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        SizedBox(height: 8.0),

        Text('Basic:'),
        SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Left'), basicVerticalDivider, Text('Right')],
          ),
        ),

        Text('With width=40:'),
        SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Left'), widthVerticalDivider, Text('Right')],
          ),
        ),

        Text('Thick (thickness=4):'),
        SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Left'), thickVerticalDivider, Text('Right')],
          ),
        ),

        Text('With indents (top and bottom):'),
        SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Left'), bothIndentVerticalDivider, Text('Right')],
          ),
        ),

        SizedBox(height: 16.0),
        Text(
          'Colored VerticalDividers:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('A'),
              redVertical,
              Text('B'),
              greenVertical,
              Text('C'),
              orangeVertical,
              Text('D'),
              purpleVertical,
              Text('E'),
            ],
          ),
        ),

        SizedBox(height: 16.0),
        Text(
          'Styled VerticalDivider:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                color: Colors.grey.shade100,
                child: Text('Section 1'),
              ),
              styledVerticalDivider,
              Container(
                padding: EdgeInsets.all(16.0),
                color: Colors.grey.shade100,
                child: Text('Section 2'),
              ),
            ],
          ),
        ),

        SizedBox(height: 24.0),
        Text(
          'Common Use Cases:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),

        // List with dividers
        Text('ListView with Dividers:'),
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ListView.separated(
            itemCount: 5,
            separatorBuilder: (context, index) => Divider(height: 1),
            itemBuilder: (context, index) => ListTile(
              title: Text('Item ${index + 1}'),
              leading: Icon(Icons.folder),
            ),
          ),
        ),

        SizedBox(height: 16.0),

        // Row with vertical dividers
        Text('Toolbar with VerticalDividers:'),
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(icon: Icon(Icons.format_bold), onPressed: () {}),
              IconButton(icon: Icon(Icons.format_italic), onPressed: () {}),
              IconButton(icon: Icon(Icons.format_underline), onPressed: () {}),
              VerticalDivider(indent: 8, endIndent: 8),
              IconButton(icon: Icon(Icons.format_align_left), onPressed: () {}),
              IconButton(
                icon: Icon(Icons.format_align_center),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.format_align_right),
                onPressed: () {},
              ),
              VerticalDivider(indent: 8, endIndent: 8),
              IconButton(
                icon: Icon(Icons.format_list_bulleted),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.format_list_numbered),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
