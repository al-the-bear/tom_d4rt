// D4rt test script: Tests CupertinoPickerDefaultSelectionOverlay from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoPickerDefaultSelectionOverlay test executing');

  // ===== 1. Default overlay (all defaults) =====
  print('--- Default overlay ---');
  final defaultOverlay = CupertinoPickerDefaultSelectionOverlay();
  print('  default overlay created');
  print('  runtimeType: ${defaultOverlay.runtimeType}');

  // ===== 2. Custom background color =====
  print('--- Custom background ---');
  final blueOverlay = CupertinoPickerDefaultSelectionOverlay(
    background: CupertinoColors.systemBlue.withValues(alpha: 0.15),
  );
  print('  blue background overlay created');

  final redOverlay = CupertinoPickerDefaultSelectionOverlay(
    background: CupertinoColors.systemRed.withValues(alpha: 0.1),
  );
  print('  red background overlay created');

  final transparentOverlay = CupertinoPickerDefaultSelectionOverlay(
    background: Color(0x00000000),
  );
  print('  transparent overlay created [${transparentOverlay.hashCode }]');

  // ===== 3. Cap edge options =====
  print('--- Cap edge variations ---');
  final bothCapped = CupertinoPickerDefaultSelectionOverlay(
    capStartEdge: true,
    capEndEdge: true,
  );
  print('  both edges capped (default) [${bothCapped.hashCode }]');

  final noCaps = CupertinoPickerDefaultSelectionOverlay(
    capStartEdge: false,
    capEndEdge: false,
  );
  print('  no caps');

  final startOnly = CupertinoPickerDefaultSelectionOverlay(
    capStartEdge: true,
    capEndEdge: false,
  );
  print('  start cap only [${startOnly.hashCode }]');

  final endOnly = CupertinoPickerDefaultSelectionOverlay(
    capStartEdge: false,
    capEndEdge: true,
  );
  print('  end cap only [${endOnly.hashCode }]');

  // ===== 4. Combined: custom background + cap settings =====
  print('--- Combined customization ---');
  final combined = CupertinoPickerDefaultSelectionOverlay(
    background: CupertinoColors.systemGreen.withValues(alpha: 0.2),
    capStartEdge: false,
    capEndEdge: true,
  );
  print('  combined customization overlay created');

  // ===== 5. Inside CupertinoPicker =====
  print('--- Inside CupertinoPicker ---');
  final pickerWithDefault = CupertinoPicker(
    itemExtent: 32.0,
    onSelectedItemChanged: (index) {},
    selectionOverlay: CupertinoPickerDefaultSelectionOverlay(),
    children: [
      for (var i = 1; i <= 12; i++) Center(child: Text('Item $i')),
    ],
  );
  print('  picker with default overlay created');

  final pickerCustom = CupertinoPicker(
    itemExtent: 40.0,
    onSelectedItemChanged: (index) {},
    selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
      background: CupertinoColors.systemIndigo.withValues(alpha: 0.12),
      capStartEdge: true,
      capEndEdge: true,
    ),
    children: [
      for (var i = 0; i < 10; i++) Center(child: Text('Option $i')),
    ],
  );
  print('  picker with custom overlay created');

  // ===== 6. Picker with NO overlay (null) vs default =====
  print('--- Null vs default overlay ---');
  final pickerNoOverlay = CupertinoPicker(
    itemExtent: 32.0,
    onSelectedItemChanged: (index) {},
    selectionOverlay: null,
    children: [
      Center(child: Text('No overlay')),
      Center(child: Text('Picker')),
    ],
  );
  print('  picker with null overlay created');

  print('CupertinoPickerDefaultSelectionOverlay test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('PickerOverlay Test')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Default Picker:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 150.0, child: pickerWithDefault),
              SizedBox(height: 16.0),
              Text('Custom Overlay:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 150.0, child: pickerCustom),
              SizedBox(height: 16.0),
              Text('No Overlay:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 100.0, child: pickerNoOverlay),
              SizedBox(height: 16.0),
              Text('Standalone overlays:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 40.0, child: defaultOverlay),
              SizedBox(height: 40.0, child: blueOverlay),
              SizedBox(height: 40.0, child: redOverlay),
              SizedBox(height: 40.0, child: noCaps),
              SizedBox(height: 40.0, child: combined),
            ],
          ),
        ),
      ),
    ),
  );
}
