// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests CupertinoDesktopTextSelectionControls from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoDesktopTextSelectionControls test executing');

  // ========== Construction ==========
  print('--- Construction ---');
  final controls = CupertinoDesktopTextSelectionControls();
  print('  created: ${controls.runtimeType}');

  // ========== Handle size ==========
  print('--- Handle size ---');
  final handleSize = controls.getHandleSize(14.0);
  print('  getHandleSize(14.0): $handleSize');
  final handleSize2 = controls.getHandleSize(20.0);
  print('  getHandleSize(20.0): $handleSize2');
  final handleSize3 = controls.getHandleSize(10.0);
  print('  getHandleSize(10.0): $handleSize3');

  // ========== Handle anchor ==========
  print('--- Handle anchor ---');
  final anchorLeft = controls.getHandleAnchor(
    TextSelectionHandleType.left,
    14.0,
  );
  print('  anchor(left, 14.0): $anchorLeft');
  final anchorRight = controls.getHandleAnchor(
    TextSelectionHandleType.right,
    14.0,
  );
  print('  anchor(right, 14.0): $anchorRight');
  final anchorCollapsed = controls.getHandleAnchor(
    TextSelectionHandleType.collapsed,
    14.0,
  );
  print('  anchor(collapsed, 14.0): $anchorCollapsed');

  // ========== Capability methods ==========
  print('--- Capability methods ---');
  print('  Note: canCut/canCopy/canPaste/canSelectAll are deprecated');
  print('  Use contextMenuBuilder instead');

  // ========== Compare with mobile controls ==========
  print('--- Compare with mobile controls ---');
  final mobileControls = CupertinoTextSelectionControls();
  print('  desktop type: ${controls.runtimeType}');
  print('  mobile type: ${mobileControls.runtimeType}');
  final desktopSize = controls.getHandleSize(14.0);
  final mobileSize = mobileControls.getHandleSize(14.0);
  print('  desktop handleSize: $desktopSize');
  print('  mobile handleSize: $mobileSize');

  print('CupertinoDesktopTextSelectionControls test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Desktop Text Selection'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CupertinoDesktopTextSelectionControls',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text('Handle Sizes:'),
              Text('  14pt: $handleSize'),
              Text('  20pt: $handleSize2'),
              Text('  10pt: $handleSize3'),
              SizedBox(height: 8.0),
              Text('Handle Anchors:'),
              Text('  left: $anchorLeft'),
              Text('  right: $anchorRight'),
              Text('  collapsed: $anchorCollapsed'),
              SizedBox(height: 8.0),
              Text('Desktop vs Mobile:'),
              Text('  desktop handle: $desktopSize'),
              Text('  mobile handle: $mobileSize'),
              SizedBox(height: 16.0),
              Text('Text field with desktop controls:'),
              CupertinoTextField(
                placeholder: 'Try selecting text',
                selectionControls: controls,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
