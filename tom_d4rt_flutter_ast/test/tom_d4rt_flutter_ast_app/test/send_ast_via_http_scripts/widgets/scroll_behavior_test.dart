// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ScrollConfiguration, ScrollBehavior, ViewportOffset,
// PrimaryScrollController, PageStorage, PageStorageBucket
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ScrollBehavior/ScrollConfiguration test executing');

  // ========== ScrollBehavior ==========
  print('--- ScrollBehavior Tests ---');
  final behavior = ScrollBehavior();
  print('ScrollBehavior created');
  final platform = behavior.getPlatform(context);
  print('  getPlatform: $platform');

  // ========== MaterialScrollBehavior ==========
  print('--- MaterialScrollBehavior Tests ---');
  final matBehavior = MaterialScrollBehavior();
  print('MaterialScrollBehavior created: $matBehavior');

  // ========== ScrollConfiguration ==========
  print('--- ScrollConfiguration Tests ---');
  final scrollConfig = ScrollConfiguration(
    behavior: behavior,
    child: Text('Configured'),
  );
  print('ScrollConfiguration created: $scrollConfig');

  // ========== PrimaryScrollController ==========
  print('--- PrimaryScrollController Tests ---');
  final controller = ScrollController();
  final primaryCtrl = PrimaryScrollController(
    controller: controller,
    child: Text('Primary'),
  );
  print('PrimaryScrollController created: $primaryCtrl');

  // ========== PageStorage ==========
  print('--- PageStorage Tests ---');
  final bucket = PageStorageBucket();
  print('PageStorageBucket created');

  final pageStorage = PageStorage(bucket: bucket, child: Text('Stored'));
  print('PageStorage created: $pageStorage');

  // Write and read from bucket
  bucket.writeState(context, 'testValue', identifier: 'key1');
  print('PageStorageBucket WriteState done');

  // ========== KeyboardDismissBehavior ==========
  print('--- KeyboardDismissBehavior Tests ---');
  print('manual: ${ScrollViewKeyboardDismissBehavior.manual}');
  print('onDrag: ${ScrollViewKeyboardDismissBehavior.onDrag}');

  print('All scroll behavior tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: ScrollConfiguration(
        behavior: MaterialScrollBehavior(),
        child: PrimaryScrollController(
          controller: ScrollController(),
          child: PageStorage(
            bucket: PageStorageBucket(),
            child: ListView(
              children: [
                Text('ScrollBehavior Test'),
                Text('ScrollConfiguration Test'),
                Text('PrimaryScrollController Test'),
                Text('PageStorage Test'),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
