// ignore_for_file: avoid_print
// D4rt test script: Tests CupertinoTextSelectionControls from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoTextSelectionControls test executing');

  // Default constructor
  final controls = CupertinoTextSelectionControls();
  print('created: ${controls.runtimeType}');

  // getHandleSize at various font sizes
  final fontSizes = [12.0, 16.0, 20.0, 24.0, 32.0, 48.0];
  for (final fontSize in fontSizes) {
    final size = controls.getHandleSize(fontSize);
    print('fontSize $fontSize -> handleSize: $size');
  }

  // getHandleAnchor for different handle types
  final handleTypes = [
    TextSelectionHandleType.left,
    TextSelectionHandleType.right,
    TextSelectionHandleType.collapsed,
  ];
  for (final type in handleTypes) {
    final anchor = controls.getHandleAnchor(type, 16.0);
    print('type: $type -> anchor: $anchor');
  }

  // Handle anchors at different sizes
  for (final fontSize in [12.0, 24.0, 48.0]) {
    final leftAnchor = controls.getHandleAnchor(TextSelectionHandleType.left, fontSize);
    final rightAnchor = controls.getHandleAnchor(TextSelectionHandleType.right, fontSize);
    print('font $fontSize: left=$leftAnchor, right=$rightAnchor');
  }

  // Used with CupertinoTextField
  final textField1 = CupertinoTextField(
    placeholder: 'Select text here',
    selectionControls: CupertinoTextSelectionControls(),
  );
  print('text field with selection controls created');

  // Multiple TextFields with same controls
  final sharedControls = CupertinoTextSelectionControls();
  final fields = <CupertinoTextField>[];
  for (var i = 0; i < 3; i++) {
    fields.add(CupertinoTextField(
      placeholder: 'Field $i',
      selectionControls: sharedControls,
    ));
  }
  print('${fields.length} text fields sharing same controls');

  // Compare handle sizes consistency
  final sizeA = controls.getHandleSize(16.0);
  final sizeB = controls.getHandleSize(16.0);
  print('handle size consistent: ${sizeA == sizeB}');

  print('CupertinoTextSelectionControls test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('SelectionControls')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('CupertinoTextSelectionControls', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              Text('Handle sizes tested at 6 font sizes'),
              Text('Anchors tested for left/right/collapsed'),
              textField1,
              SizedBox(height: 8.0),
              ...fields,
            ],
          ),
        ),
      ),
    ),
  );
}
