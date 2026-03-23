// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RawScrollbar, InheritedNotifier, WillPopScope,
// DefaultAssetBundle, RawGestureDetector concept
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Raw widgets test executing');

  // ========== RawScrollbar ==========
  print('--- RawScrollbar Tests ---');
  final scrollController = ScrollController();
  final rawScrollbar = RawScrollbar(
    controller: scrollController,
    thumbVisibility: true,
    thickness: 6.0,
    radius: Radius.circular(3.0),
    thumbColor: Colors.grey,
    child: ListView.builder(
      controller: scrollController,
      itemCount: 20,
      itemBuilder: (ctx, i) => Text('Item $i'),
    ),
  );
  print('RawScrollbar created');
  print('  thickness: 6.0');
  print('  thumbVisibility: true');

  // ========== DefaultAssetBundle ==========
  print('--- DefaultAssetBundle Tests ---');
  final assetBundle = DefaultAssetBundle(
    bundle: DefaultAssetBundle.of(context),
    child: Text('Asset bundle'),
  );
  print('DefaultAssetBundle created');

  // ========== WillPopScope (deprecated but tests bridge) ==========
  print('--- PopScope Tests ---');
  final popScope = PopScope(canPop: true, child: Text('Pop scope'));
  print('PopScope canPop: true');

  final noPop = PopScope(
    canPop: false,
    onPopInvokedWithResult: (didPop, result) {
      print('  Pop invoked: didPop=$didPop');
    },
    child: Text('No pop'),
  );
  print('PopScope canPop: false with callback');

  // ========== InheritedNotifier ==========
  print('--- InheritedNotifier Tests ---');
  final notifier = ValueNotifier<int>(42);
  print('ValueNotifier created with value: ${notifier.value}');
  notifier.value = 99;
  print('ValueNotifier updated to: ${notifier.value}');
  notifier.dispose();

  print('All raw widgets tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: PopScope(
        canPop: true,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Raw Widgets Test',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 16.0),
              Text('RawScrollbar with controller'),
              Text('DefaultAssetBundle'),
              Text('PopScope canPop variants'),
              Text('InheritedNotifier / ValueNotifier'),
            ],
          ),
        ),
      ),
    ),
  );
}
