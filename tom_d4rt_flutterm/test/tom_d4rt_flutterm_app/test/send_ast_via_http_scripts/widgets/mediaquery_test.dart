// D4rt test script: Tests MediaQuery from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MediaQuery test executing');

  // Test MediaQuery.of(context) to get data
  final mediaData = MediaQuery.of(context);
  print('MediaQuery.of(context) size: ${mediaData.size}');
  print('MediaQuery.of(context) devicePixelRatio: ${mediaData.devicePixelRatio}');
  print('MediaQuery.of(context) padding: ${mediaData.padding}');
  print('MediaQuery.of(context) viewInsets: ${mediaData.viewInsets}');
  print('MediaQuery.of(context) textScaleFactor: ${mediaData.textScaleFactor}');
  print('MediaQuery.of(context) platformBrightness: ${mediaData.platformBrightness}');

  // Test MediaQuery.sizeOf shortcut
  final size = MediaQuery.sizeOf(context);
  print('MediaQuery.sizeOf: $size');
  print('Screen width: ${size.width}');
  print('Screen height: ${size.height}');

  // Test MediaQueryData constructor
  final customData = MediaQueryData(
    size: Size(400.0, 800.0),
    devicePixelRatio: 2.0,
    padding: EdgeInsets.only(top: 44.0, bottom: 34.0),
    textScaleFactor: 1.0,
  );
  print('Custom MediaQueryData created: size=${customData.size}');
  print('Custom padding: ${customData.padding}');

  // Test MediaQuery widget wrapping child with custom data
  final mediaQueryWidget = MediaQuery(
    data: customData,
    child: Container(
      color: Colors.blue,
      height: 100.0,
      child: Center(
        child: Text('Custom MediaQuery', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('MediaQuery widget with custom data created');

  // Test removePadding
  final noPaddingWidget = MediaQuery.removePadding(
    context: context,
    removeTop: true,
    removeBottom: true,
    child: Container(
      color: Colors.green,
      height: 100.0,
      child: Center(
        child: Text('No padding', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('MediaQuery.removePadding created (top and bottom removed)');

  // Test removePadding with only top
  final noTopPadding = MediaQuery.removePadding(
    context: context,
    removeTop: true,
    child: Container(
      color: Colors.orange,
      height: 100.0,
      child: Center(
        child: Text('No top padding', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('MediaQuery.removePadding created (top only)');

  // Test removeViewInsets
  final noViewInsets = MediaQuery.removeViewInsets(
    context: context,
    removeBottom: true,
    child: Container(
      color: Colors.purple,
      height: 100.0,
      child: Center(
        child: Text('No view insets', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('MediaQuery.removeViewInsets created (bottom removed)');

  // Test MediaQueryData.copyWith
  final modifiedData = mediaData.copyWith(
    textScaleFactor: 2.0,
  );
  print('MediaQueryData.copyWith textScaleFactor=2.0: ${modifiedData.textScaleFactor}');

  final scaledWidget = MediaQuery(
    data: modifiedData,
    child: Container(
      color: Colors.teal,
      height: 100.0,
      child: Center(
        child: Text('Scaled text', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('MediaQuery with modified data created');

  // Display responsive info
  final width = mediaData.size.width;
  final isNarrow = width < 600.0;
  print('Screen width: $width, isNarrow: $isNarrow');

  print('MediaQuery test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'MediaQuery Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text('Screen: ${mediaData.size}'),
        Text('DPR: ${mediaData.devicePixelRatio}'),
        Text('Padding: ${mediaData.padding}'),
        SizedBox(height: 16.0),
        Text('Custom MediaQuery:', style: TextStyle(fontWeight: FontWeight.bold)),
        mediaQueryWidget,
        SizedBox(height: 8.0),
        Text('Remove padding:', style: TextStyle(fontWeight: FontWeight.bold)),
        noPaddingWidget,
        SizedBox(height: 8.0),
        noTopPadding,
        SizedBox(height: 8.0),
        Text('Remove view insets:', style: TextStyle(fontWeight: FontWeight.bold)),
        noViewInsets,
        SizedBox(height: 8.0),
        Text('Scaled text:', style: TextStyle(fontWeight: FontWeight.bold)),
        scaledWidget,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• MediaQuery.of(context) gets device info'),
        Text('• MediaQuery.sizeOf(context) for screen size'),
        Text('• removePadding removes safe area padding'),
        Text('• removeViewInsets removes keyboard insets'),
        Text('• copyWith modifies specific properties'),
      ],
    ),
  );
}
