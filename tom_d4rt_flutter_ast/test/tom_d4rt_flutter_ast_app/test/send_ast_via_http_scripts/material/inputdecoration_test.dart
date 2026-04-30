// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests InputDecoration, InputBorder, OutlineInputBorder, UnderlineInputBorder from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('InputDecoration widgets test executing');

  // ========== INPUTBORDER ==========
  print('--- InputBorder Tests ---');

  // Test OutlineInputBorder
  final outlineBorder = OutlineInputBorder();
  print('Basic OutlineInputBorder created');

  // Test OutlineInputBorder with borderRadius
  final roundedOutline = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16.0),
  );
  print('OutlineInputBorder with borderRadius created');

  // Test OutlineInputBorder with borderSide
  final coloredOutline = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 2.0),
  );
  print('OutlineInputBorder with borderSide created: $coloredOutline');

  // Test OutlineInputBorder with gapPadding
  final gapOutline = OutlineInputBorder(gapPadding: 8.0);
  print('OutlineInputBorder with gapPadding created: $gapOutline');

  // Test UnderlineInputBorder
  final underlineBorder = UnderlineInputBorder();
  print('Basic UnderlineInputBorder created');

  // Test UnderlineInputBorder with borderSide
  final coloredUnderline = UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2.0),
  );
  print('UnderlineInputBorder with borderSide created: $coloredUnderline');

  // Test UnderlineInputBorder with borderRadius
  final roundedUnderline = UnderlineInputBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
  );
  print('UnderlineInputBorder with borderRadius created: $roundedUnderline');

  // Test InputBorder.none
  final noBorder = InputBorder.none;
  print('InputBorder.none created');

  // ========== INPUTDECORATION ==========
  print('--- InputDecoration Tests ---');

  // Test basic InputDecoration
  final basicDecoration = InputDecoration();
  print('Basic InputDecoration created: $basicDecoration');

  // Test InputDecoration with labelText
  final labelDecoration = InputDecoration(labelText: 'Username');
  print('InputDecoration with labelText created');

  // Test InputDecoration with hintText
  final hintDecoration = InputDecoration(hintText: 'Enter your username');
  print('InputDecoration with hintText created');

  // Test InputDecoration with helperText
  final helperDecoration = InputDecoration(
    labelText: 'Email',
    helperText: 'We will never share your email',
  );
  print('InputDecoration with helperText created');

  // Test InputDecoration with errorText
  final errorDecoration = InputDecoration(
    labelText: 'Password',
    errorText: 'Password is required',
  );
  print('InputDecoration with errorText created');

  // Test InputDecoration with prefixIcon
  final prefixDecoration = InputDecoration(
    labelText: 'Search',
    prefixIcon: Icon(Icons.search),
  );
  print('InputDecoration with prefixIcon created');

  // Test InputDecoration with suffixIcon
  final suffixDecoration = InputDecoration(
    labelText: 'Password',
    suffixIcon: Icon(Icons.visibility),
  );
  print('InputDecoration with suffixIcon created');

  // Test InputDecoration with prefix
  final prefixTextDecoration = InputDecoration(
    labelText: 'Amount',
    prefix: Text('\$ '),
  );
  print('InputDecoration with prefix created');

  // Test InputDecoration with suffix
  final suffixTextDecoration = InputDecoration(
    labelText: 'Weight',
    suffix: Text(' kg'),
  );
  print('InputDecoration with suffix created');

  // Test InputDecoration with prefixText
  final prefixStringDecoration = InputDecoration(
    labelText: 'Website',
    prefixText: 'https://',
  );
  print('InputDecoration with prefixText created');

  // Test InputDecoration with suffixText
  final suffixStringDecoration = InputDecoration(
    labelText: 'Email',
    suffixText: '@example.com',
  );
  print('InputDecoration with suffixText created');

  // Test InputDecoration with counter
  final counterDecoration = InputDecoration(
    labelText: 'Bio',
    counter: Text('0/200'),
  );
  print('InputDecoration with counter created');

  // Test InputDecoration with counterText
  final counterTextDecoration = InputDecoration(
    labelText: 'Message',
    counterText: '140 characters remaining',
  );
  print('InputDecoration with counterText created: $counterTextDecoration');

  // Test InputDecoration with filled
  final filledDecoration = InputDecoration(
    labelText: 'Filled',
    filled: true,
    fillColor: Colors.grey.shade100,
  );
  print('InputDecoration with filled created');

  // Test InputDecoration with border
  final outlineDecoration = InputDecoration(
    labelText: 'Outlined',
    border: OutlineInputBorder(),
  );
  print('InputDecoration with outline border created');

  // Test InputDecoration with focusedBorder
  final focusedDecoration = InputDecoration(
    labelText: 'Focus Border',
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 2.0),
    ),
  );
  print('InputDecoration with focusedBorder created');

  // Test InputDecoration with enabledBorder
  final enabledDecoration = InputDecoration(
    labelText: 'Enabled Border',
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
  );
  print('InputDecoration with enabledBorder created: $enabledDecoration');

  // Test InputDecoration with errorBorder
  final errorBorderDecoration = InputDecoration(
    labelText: 'Error Border',
    errorText: 'Error!',
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2.0),
    ),
  );
  print('InputDecoration with errorBorder created: $errorBorderDecoration');

  // Test InputDecoration with disabledBorder
  final disabledDecoration = InputDecoration(
    labelText: 'Disabled',
    enabled: false,
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
  );
  print('InputDecoration with disabledBorder created: $disabledDecoration');

  // Test InputDecoration with contentPadding
  final paddedDecoration = InputDecoration(
    labelText: 'Padded',
    contentPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
    border: OutlineInputBorder(),
  );
  print('InputDecoration with contentPadding created');

  // Test InputDecoration with isDense
  final denseDecoration = InputDecoration(
    labelText: 'Dense',
    isDense: true,
    border: OutlineInputBorder(),
  );
  print('InputDecoration with isDense created');

  // Test InputDecoration with isCollapsed
  final collapsedDecoration = InputDecoration.collapsed(
    hintText: 'Collapsed decoration',
  );
  print('InputDecoration.collapsed created: $collapsedDecoration');

  // Test InputDecoration with icon
  final iconDecoration = InputDecoration(
    icon: Icon(Icons.person),
    labelText: 'Name',
  );
  print('InputDecoration with icon created: $iconDecoration');

  // Test InputDecoration with labelStyle
  final styledLabelDecoration = InputDecoration(
    labelText: 'Styled Label',
    labelStyle: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
    border: OutlineInputBorder(),
  );
  print('InputDecoration with labelStyle created');

  // Test InputDecoration with floatingLabelStyle
  final floatingLabelDecoration = InputDecoration(
    labelText: 'Floating Label',
    floatingLabelStyle: TextStyle(color: Colors.green, fontSize: 18),
    border: OutlineInputBorder(),
  );
  print('InputDecoration with floatingLabelStyle created');

  // Test InputDecoration with floatingLabelBehavior
  final alwaysFloatDecoration = InputDecoration(
    labelText: 'Always Float',
    floatingLabelBehavior: FloatingLabelBehavior.always,
    border: OutlineInputBorder(),
  );
  print('InputDecoration with floatingLabelBehavior created');

  // Test InputDecoration with hintStyle
  final styledHintDecoration = InputDecoration(
    hintText: 'Styled hint',
    hintStyle: TextStyle(
      color: Colors.grey.shade400,
      fontStyle: FontStyle.italic,
    ),
    border: OutlineInputBorder(),
  );
  print('InputDecoration with hintStyle created: $styledHintDecoration');

  // Test InputDecoration with errorStyle
  final styledErrorDecoration = InputDecoration(
    labelText: 'Error Style',
    errorText: 'Custom error style',
    errorStyle: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
    border: OutlineInputBorder(),
  );
  print('InputDecoration with errorStyle created: $styledErrorDecoration');

  // Test InputDecoration with errorMaxLines
  final multilineErrorDecoration = InputDecoration(
    labelText: 'Multi Error',
    errorText: 'This is a very long error message that spans multiple lines',
    errorMaxLines: 2,
    border: OutlineInputBorder(),
  );
  print('InputDecoration with errorMaxLines created');

  // Test InputDecoration with constraints
  final constrainedDecoration = InputDecoration(
    labelText: 'Constrained',
    constraints: BoxConstraints(maxWidth: 200),
    border: OutlineInputBorder(),
  );
  print('InputDecoration with constraints created: $constrainedDecoration');

  // Test InputDecoration copyWith
  final copiedDecoration = labelDecoration.copyWith(
    hintText: 'Added hint',
    border: OutlineInputBorder(),
  );
  print('InputDecoration.copyWith created: $copiedDecoration');

  print('InputDecoration widgets test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'InputDecoration Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text('Border Types:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        TextField(
          decoration: InputDecoration(
            labelText: 'Outline Border',
            border: outlineBorder,
          ),
        ),
        SizedBox(height: 12.0),
        TextField(
          decoration: InputDecoration(
            labelText: 'Rounded Outline',
            border: roundedOutline,
          ),
        ),
        SizedBox(height: 12.0),
        TextField(
          decoration: InputDecoration(
            labelText: 'Underline Border',
            border: underlineBorder,
          ),
        ),
        SizedBox(height: 12.0),
        TextField(
          decoration: InputDecoration(
            labelText: 'No Border',
            border: noBorder,
            filled: true,
            fillColor: Colors.grey.shade200,
          ),
        ),

        SizedBox(height: 24.0),
        Text(
          'Decoration Examples:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),

        TextField(decoration: labelDecoration),
        SizedBox(height: 12.0),
        TextField(decoration: hintDecoration),
        SizedBox(height: 12.0),
        TextField(decoration: helperDecoration),
        SizedBox(height: 12.0),
        TextField(decoration: errorDecoration),
        SizedBox(height: 12.0),
        TextField(decoration: prefixDecoration),
        SizedBox(height: 12.0),
        TextField(decoration: suffixDecoration),

        SizedBox(height: 24.0),
        Text('Prefix/Suffix:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),

        TextField(decoration: prefixTextDecoration),
        SizedBox(height: 12.0),
        TextField(decoration: suffixTextDecoration),
        SizedBox(height: 12.0),
        TextField(decoration: prefixStringDecoration),
        SizedBox(height: 12.0),
        TextField(decoration: suffixStringDecoration),

        SizedBox(height: 24.0),
        Text('Filled & Styled:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),

        TextField(decoration: filledDecoration),
        SizedBox(height: 12.0),
        TextField(decoration: outlineDecoration),
        SizedBox(height: 12.0),
        TextField(decoration: focusedDecoration),
        SizedBox(height: 12.0),
        TextField(decoration: styledLabelDecoration),
        SizedBox(height: 12.0),
        TextField(decoration: floatingLabelDecoration),
        SizedBox(height: 12.0),
        TextField(decoration: alwaysFloatDecoration),

        SizedBox(height: 24.0),
        Text('Special Cases:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),

        TextField(decoration: denseDecoration),
        SizedBox(height: 12.0),
        TextField(decoration: paddedDecoration),
        SizedBox(height: 12.0),
        Row(
          children: [
            Icon(Icons.person),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                decoration: InputDecoration(labelText: 'With leading icon'),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        TextField(decoration: counterDecoration, maxLines: 3),
        SizedBox(height: 12.0),
        TextField(decoration: multilineErrorDecoration),
      ],
    ),
  );
}
