// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DefaultTextStyle, AnimatedDefaultTextStyle from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DefaultTextStyle test executing');

  // ========== DEFAULTTEXTSTYLE ==========
  print('--- DefaultTextStyle Tests ---');

  // DefaultTextStyle provides a default text style to descendants
  final styledText = DefaultTextStyle(
    style: TextStyle(
      fontSize: 20.0,
      color: Colors.blue,
      fontWeight: FontWeight.bold,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Inherits default style'),
        Text('Also uses default style'),
        Text('Overridden', style: TextStyle(color: Colors.red)),
      ],
    ),
  );
  print('DefaultTextStyle with blue bold 20.0 created');

  // Test with textAlign
  final alignedText = DefaultTextStyle(
    style: TextStyle(fontSize: 16.0, color: Colors.green),
    textAlign: TextAlign.center,
    child: Text('Centered text'),
  );
  print('DefaultTextStyle with textAlign.center created');

  // Test with softWrap false
  final noWrapText = DefaultTextStyle(
    style: TextStyle(fontSize: 14.0),
    softWrap: false,
    child: Text('No wrapping text here'),
  );
  print('DefaultTextStyle with softWrap=false created');

  // Test with overflow
  final overflowText = DefaultTextStyle(
    style: TextStyle(fontSize: 14.0),
    overflow: TextOverflow.ellipsis,
    child: Text('This text might be too long and will be ellipsized'),
  );
  print('DefaultTextStyle with overflow=ellipsis created');

  // Test with maxLines
  final maxLinesText = DefaultTextStyle(
    style: TextStyle(fontSize: 14.0),
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    child: Text('Line 1\nLine 2\nLine 3 - should be hidden'),
  );
  print('DefaultTextStyle with maxLines=2 created');

  // Test DefaultTextStyle.merge
  final mergedStyle = DefaultTextStyle.merge(
    style: TextStyle(fontStyle: FontStyle.italic),
    child: Text('Merged italic style'),
  );
  print('DefaultTextStyle.merge created');

  // Test DefaultTextStyle.of
  // (needs to be inside the tree to work properly)

  // ========== ANIMATEDDEFAULTTEXTSTYLE ==========
  print('--- AnimatedDefaultTextStyle Tests ---');

  final animatedStyle = AnimatedDefaultTextStyle(
    style: TextStyle(
      fontSize: 24.0,
      color: Colors.purple,
      fontWeight: FontWeight.w600,
    ),
    duration: Duration(milliseconds: 300),
    child: Text('Animated text style'),
  );
  print('AnimatedDefaultTextStyle created');

  // With curve
  final animatedCurved = AnimatedDefaultTextStyle(
    style: TextStyle(fontSize: 18.0, color: Colors.orange),
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOut,
    child: Text('Curved animation'),
  );
  print('AnimatedDefaultTextStyle with curve created');

  // With textAlign
  final animatedAligned = AnimatedDefaultTextStyle(
    style: TextStyle(fontSize: 16.0, color: Colors.teal),
    duration: Duration(milliseconds: 200),
    textAlign: TextAlign.right,
    softWrap: true,
    maxLines: 3,
    overflow: TextOverflow.fade,
    child: Text('Animated aligned text'),
  );
  print('AnimatedDefaultTextStyle with all params created');

  print('All DefaultTextStyle tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DefaultTextStyle Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            styledText,
            SizedBox(height: 8.0),
            alignedText,
            SizedBox(height: 8.0),
            animatedStyle,
            SizedBox(height: 8.0),
            animatedCurved,
          ],
        ),
      ),
    ),
  );
}
