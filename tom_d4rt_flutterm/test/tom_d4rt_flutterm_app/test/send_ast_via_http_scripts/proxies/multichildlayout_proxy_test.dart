// D4rt test script: Tests D4rtMultiChildLayoutDelegate proxy with CustomMultiChildLayout widget
// Phase 4: Proxy class generation for abstract delegates (GEN-083)
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('D4rtMultiChildLayoutDelegate proxy test executing');

  // ========== BASIC MULTI-CHILD LAYOUT ==========
  print('--- D4rtMultiChildLayoutDelegate Basic ---');

  // Create a delegate that positions two children (header + body)
  final basicDelegate = D4rtMultiChildLayoutDelegate(
    onPerformLayout: (Size size) {
      // This callback receives the available size and should
      // lay out and position children using layoutChild and positionChild
      print('performLayout called with size: $size');
    },
    onShouldRelayout: (MultiChildLayoutDelegate oldDelegate) => false,
  );
  print('D4rtMultiChildLayoutDelegate created: ${basicDelegate.runtimeType}');
  print('  is MultiChildLayoutDelegate: ${basicDelegate is MultiChildLayoutDelegate}');

  // Use in CustomMultiChildLayout widget
  final widget1 = CustomMultiChildLayout(
    delegate: basicDelegate,
    children: [
      LayoutId(
        id: 'header',
        child: Container(
          height: 50.0,
          color: Colors.blue,
          child: Center(child: Text('Header')),
        ),
      ),
      LayoutId(
        id: 'body',
        child: Container(
          color: Colors.grey,
          child: Center(child: Text('Body Content')),
        ),
      ),
    ],
  );
  print('CustomMultiChildLayout with header/body children created');

  // ========== THREE-PANEL LAYOUT ==========
  print('--- Three-Panel Layout ---');

  final threePanelDelegate = D4rtMultiChildLayoutDelegate(
    onPerformLayout: (Size size) {
      print('Three-panel layout, available: $size');
    },
    onShouldRelayout: (MultiChildLayoutDelegate oldDelegate) => false,
  );
  print('Three-panel delegate created');

  final widget2 = CustomMultiChildLayout(
    delegate: threePanelDelegate,
    children: [
      LayoutId(
        id: 'top',
        child: Container(
          height: 40.0,
          color: Colors.red,
          child: Center(child: Text('Top')),
        ),
      ),
      LayoutId(
        id: 'middle',
        child: Container(
          height: 80.0,
          color: Colors.green,
          child: Center(child: Text('Middle')),
        ),
      ),
      LayoutId(
        id: 'bottom',
        child: Container(
          height: 40.0,
          color: Colors.blue,
          child: Center(child: Text('Bottom')),
        ),
      ),
    ],
  );
  print('CustomMultiChildLayout with 3 panels created');

  // ========== OVERLAY LAYOUT ==========
  print('--- Overlay Layout ---');

  final overlayDelegate = D4rtMultiChildLayoutDelegate(
    onPerformLayout: (Size size) {
      print('Overlay layout called');
    },
    onShouldRelayout: (MultiChildLayoutDelegate oldDelegate) => false,
  );

  final widget3 = CustomMultiChildLayout(
    delegate: overlayDelegate,
    children: [
      LayoutId(
        id: 'background',
        child: Container(
          width: 200.0,
          height: 200.0,
          color: Colors.amber,
        ),
      ),
      LayoutId(
        id: 'foreground',
        child: Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text('Overlay', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    ],
  );
  print('CustomMultiChildLayout with overlay pattern created');

  // ========== DYNAMIC RELAYOUT ==========
  print('--- shouldRelayout Logic ---');

  final dynamicDelegate = D4rtMultiChildLayoutDelegate(
    onPerformLayout: (Size size) {
      print('Dynamic layout triggered');
    },
    onShouldRelayout: (MultiChildLayoutDelegate oldDelegate) => true,
  );
  print('Dynamic delegate (always relayouts) created');

  final widget4 = CustomMultiChildLayout(
    delegate: dynamicDelegate,
    children: [
      LayoutId(
        id: 'item',
        child: Container(
          width: 150.0,
          height: 50.0,
          color: Colors.teal,
          child: Center(child: Text('Dynamic Item')),
        ),
      ),
    ],
  );
  print('CustomMultiChildLayout with dynamic delegate created');

  // ========== WITH KEY ==========
  print('--- CustomMultiChildLayout with Key ---');

  final widget5 = CustomMultiChildLayout(
    key: ValueKey('proxy-multi-layout-1'),
    delegate: basicDelegate,
    children: [
      LayoutId(
        id: 'only-child',
        child: Container(
          width: 100.0,
          height: 100.0,
          color: Colors.orange,
          child: Center(child: Text('Keyed')),
        ),
      ),
    ],
  );
  print('CustomMultiChildLayout with ValueKey created');

  print('D4rtMultiChildLayoutDelegate proxy test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('D4rtMultiChildLayoutDelegate Proxy Tests'),
      SizedBox(height: 8.0),
      SizedBox(
        width: 250.0,
        height: 160.0,
        child: widget1,
      ),
      SizedBox(height: 8.0),
      SizedBox(
        width: 250.0,
        height: 180.0,
        child: widget2,
      ),
      SizedBox(height: 8.0),
      SizedBox(
        width: 220.0,
        height: 210.0,
        child: widget3,
      ),
      SizedBox(height: 8.0),
      SizedBox(
        width: 200.0,
        height: 60.0,
        child: widget4,
      ),
    ],
  );
}
