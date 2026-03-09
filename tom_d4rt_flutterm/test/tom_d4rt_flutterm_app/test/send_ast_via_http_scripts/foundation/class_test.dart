// D4rt test script: Tests foundation core classes overview
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Foundation class test executing');

  // ChangeNotifier
  final cn = ChangeNotifier();
  print('ChangeNotifier: ${cn.runtimeType}');
  print('hasListeners: ${cn.hasListeners}');
  cn.addListener(() {});
  print('hasListeners after add: ${cn.hasListeners}');
  cn.dispose();

  // ValueNotifier
  final vn = ValueNotifier<int>(42);
  print('ValueNotifier: value=${vn.value}');
  vn.value = 100;
  print('After set: ${vn.value}');
  vn.dispose();

  // TextTreeConfiguration
  final ttc = TextTreeConfiguration(prefixLineOne: '├─', prefixLastChildLineOne: '└─', prefixOtherLines: '│ ', linkCharacter: '│', prefixOtherLinesRootNode: ' ');
  print('TextTreeConfiguration: ${ttc.runtimeType}');

  // kReleaseMode, kDebugMode, kProfileMode
  print('kReleaseMode: $kReleaseMode');
  print('kDebugMode: $kDebugMode');
  print('kProfileMode: $kProfileMode');

  // defaultTargetPlatform
  print('defaultTargetPlatform: $defaultTargetPlatform');

  print('Foundation class test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('Foundation Class Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('ChangeNotifier, ValueNotifier OK'),
    Text('kDebugMode: $kDebugMode'),
    Text('Platform: $defaultTargetPlatform'),
  ]);
}
