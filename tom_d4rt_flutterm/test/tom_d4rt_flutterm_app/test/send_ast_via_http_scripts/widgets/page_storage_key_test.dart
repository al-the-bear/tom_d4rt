// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PageStorageKey from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PageStorageKey test executing');
  print('=' * 50);

  // === Test PageStorageKey class ===
  print('\nPageStorageKey identifies PageStorage values');

  // Create PageStorageKey
  print('\n--- Testing creation ---');
  const key1 = PageStorageKey<String>('myPage');
  print('Created PageStorageKey<String>("myPage")');
  print('key1.value: ${key1.value}');
  print('key1.runtimeType: ${key1.runtimeType}');

  // Create with int
  print('\n--- Testing with int ---');
  const key2 = PageStorageKey<int>(42);
  print('Created PageStorageKey<int>(42)');
  print('key2.value: ${key2.value}');

  // Test inheritance
  print('\n--- Testing inheritance ---');
  print('key1 is ValueKey: ${key1 is ValueKey}');
  print('key1 is LocalKey: ${key1 is LocalKey}');

  // Test equality
  print('\n--- Testing equality ---');
  const keyA = PageStorageKey<String>('test');
  const keyB = PageStorageKey<String>('test');
  const keyC = PageStorageKey<String>('other');
  print('keyA == keyB: ${keyA == keyB}');
  print('keyA == keyC: ${keyA == keyC}');

  // Test with ListView
  print('\n--- Testing with ListView ---');
  final listView = ListView.builder(
    key: PageStorageKey<String>('myList'),
    itemCount: 50,
    itemBuilder: (ctx, i) => ListTile(title: Text('Item $i')),
  );
  print('Created ListView with PageStorageKey');
  print('Scroll position will be preserved');

  // Test PageStorage usage
  print('\n--- PageStorage usage ---');
  print('PageStorage.of(context).writeState(context, value)');
  print('PageStorage.of(context).readState(context)');
  print('Keys form identifier chain to storage');

  // Test with TabBarView
  print('\n--- Common use case ---');
  print('TabBarView tabs preserve scroll positions');
  print('Each tab child has PageStorageKey');
  print('Navigator uses PageStorage for routes');

  // hashCode
  print('\n--- Testing hashCode ---');
  print('key1.hashCode: ${key1.hashCode}');
  print('keyA.hashCode: ${keyA.hashCode}');

  print('\n' + '=' * 50);
  print('PageStorageKey test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PageStorageKey Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('key1.value: ${key1.value}'),
      Text('keyA == keyB: ${keyA == keyB}'),
      Text('Extends: ValueKey<T>'),
    ],
  );
}
