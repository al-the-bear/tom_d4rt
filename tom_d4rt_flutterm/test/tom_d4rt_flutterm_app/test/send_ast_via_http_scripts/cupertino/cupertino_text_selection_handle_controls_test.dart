// D4rt test script: Tests CupertinoTextSelectionHandleControls from cupertino
// NOTE: CupertinoTextSelectionHandleControls is NOT bridged in d4rt.
// This test demonstrates the class through its superclass behavior and
// CupertinoTextField integration where it is used internally.
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoTextSelectionHandleControls test executing');

  // ===== 1. Create instance (handle-only controls, no toolbar) =====
  print('--- CupertinoTextSelectionHandleControls ---');
  final handleControls = CupertinoTextSelectionHandleControls();
  print('  created: ${handleControls.runtimeType}');

  // ===== 2. getHandleSize =====
  print('--- getHandleSize ---');
  final sizes = [12.0, 16.0, 20.0, 24.0, 32.0];
  for (final fs in sizes) {
    final size = handleControls.getHandleSize(fs);
    print('  fontSize $fs -> ${size.width}x${size.height}');
  }

  // ===== 3. getHandleAnchor for each type =====
  print('--- getHandleAnchor ---');
  final types = [
    TextSelectionHandleType.left,
    TextSelectionHandleType.right,
    TextSelectionHandleType.collapsed,
  ];
  for (final type in types) {
    final anchor = handleControls.getHandleAnchor(type, 16.0);
    print('  $type -> dx:${anchor.dx}, dy:${anchor.dy}');
  }

  // ===== 4. Compare with CupertinoTextSelectionControls =====
  print('--- Comparison with full controls ---');
  final fullControls = CupertinoTextSelectionControls();
  final handleSize16 = handleControls.getHandleSize(16.0);
  final fullSize16 = fullControls.getHandleSize(16.0);
  print('  handleControls size@16: $handleSize16');
  print('  fullControls size@16: $fullSize16');
  print('  sizes match: ${handleSize16 == fullSize16}');

  final handleAnchorLeft = handleControls.getHandleAnchor(TextSelectionHandleType.left, 16.0);
  final fullAnchorLeft = fullControls.getHandleAnchor(TextSelectionHandleType.left, 16.0);
  print('  handleControls anchor left: $handleAnchorLeft');
  print('  fullControls anchor left: $fullAnchorLeft');

  // ===== 5. CupertinoTextField uses handle controls internally =====
  print('--- TextField integration ---');
  final textField = CupertinoTextField(
    placeholder: 'Select text to see handles',
    controller: TextEditingController(text: 'Sample text for selection'),
  );
  print('  text field created');

  // ===== 6. Multiple selection-enabled fields =====
  print('--- Multiple selectable fields ---');
  final editableFields = <Widget>[];
  final labels = ['Name', 'Email', 'Phone', 'Address'];
  for (final label in labels) {
    editableFields.add(Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: CupertinoTextField(
        placeholder: label,
        prefix: Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text('$label:'),
        ),
      ),
    ));
  }
  print('  ${editableFields.length} editable fields created');

  // ===== 7. Handle size scaling verification =====
  print('--- Handle size at extreme font sizes ---');
  final extremeSizes = [8.0, 72.0, 96.0];
  for (final fs in extremeSizes) {
    final size = handleControls.getHandleSize(fs);
    print('  fontSize $fs -> ${size.width}x${size.height}');
  }

  print('CupertinoTextSelectionHandleControls test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('HandleControls')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Handle Controls Test', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              Text('Type: ${handleControls.runtimeType}'),
              SizedBox(height: 8.0),
              Text('Handle sizes:'),
              for (final fs in sizes)
                Text('  ${fs}px: ${handleControls.getHandleSize(fs)}'),
              SizedBox(height: 16.0),
              Text('Select text in fields:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              textField,
              SizedBox(height: 12.0),
              ...editableFields,
            ],
          ),
        ),
      ),
    ),
  );
}
