// D4rt test script: Tests CupertinoTextSelectionControls from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoTextSelectionControls test executing');

  // ===== 1. Default constructor =====
  print('--- CupertinoTextSelectionControls ---');
  final controls = CupertinoTextSelectionControls();
  print('  created: ${controls.runtimeType}');

  // ===== 2. getHandleSize at various font sizes =====
  print('--- getHandleSize ---');
  final fontSizes = [12.0, 16.0, 20.0, 24.0, 32.0, 48.0];
  for (final fontSize in fontSizes) {
    final size = controls.getHandleSize(fontSize);
    print('  fontSize $fontSize -> handleSize: $size (w:${size.width}, h:${size.height})');
  }

  // ===== 3. getHandleAnchor for different handle types =====
  print('--- getHandleAnchor ---');
  final handleTypes = [
    TextSelectionHandleType.left,
    TextSelectionHandleType.right,
    TextSelectionHandleType.collapsed,
  ];
  for (final type in handleTypes) {
    final anchor = controls.getHandleAnchor(type, 16.0);
    print('  type: $type -> anchor: $anchor (dx:${anchor.dx}, dy:${anchor.dy})');
  }

  // ===== 4. Handle anchors at different sizes =====
  print('--- Anchor scaling ---');
  for (final fontSize in [12.0, 24.0, 48.0]) {
    final leftAnchor = controls.getHandleAnchor(TextSelectionHandleType.left, fontSize);
    final rightAnchor = controls.getHandleAnchor(TextSelectionHandleType.right, fontSize);
    print('  font $fontSize: left=$leftAnchor, right=$rightAnchor');
  }

  // ===== 5. Capability methods =====
  print('--- Capabilities ---');
  print('  canCut: ${controls.canCut(null)}');
  print('  canCopy: ${controls.canCopy(null)}');
  print('  canPaste: ${controls.canPaste(null)}');
  print('  canSelectAll: ${controls.canSelectAll(null)}');

  // ===== 6. Used with CupertinoTextField =====
  print('--- CupertinoTextField integration ---');
  final textField1 = CupertinoTextField(
    placeholder: 'Select text here',
    selectionControls: CupertinoTextSelectionControls(),
  );
  print('  text field with selection controls created');

  // ===== 7. Multiple TextFields with same controls =====
  print('--- Shared controls across fields ---');
  final sharedControls = CupertinoTextSelectionControls();
  final fields = <CupertinoTextField>[];
  for (var i = 0; i < 3; i++) {
    fields.add(CupertinoTextField(
      placeholder: 'Field $i',
      selectionControls: sharedControls,
    ));
  }
  print('  ${fields.length} text fields sharing same controls');

  // ===== 8. Compare handle sizes left vs right =====
  print('--- Handle size consistency ---');
  final sizeLeft = controls.getHandleSize(16.0);
  final sizeRight = controls.getHandleSize(16.0);
  print('  left call: $sizeLeft');
  print('  right call: $sizeRight');
  print('  same? ${sizeLeft == sizeRight}');

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
              SizedBox(height: 12.0),
              Text('Handle sizes at fonts 12-48:'),
              for (final fs in fontSizes)
                Text('  ${fs}px -> ${controls.getHandleSize(fs)}'),
              SizedBox(height: 12.0),
              Text('TextFields:', style: TextStyle(fontWeight: FontWeight.bold)),
              textField1,
              SizedBox(height: 8.0),
              ...fields.map((f) => Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: f,
              )),
            ],
          ),
        ),
      ),
    ),
  );
}
