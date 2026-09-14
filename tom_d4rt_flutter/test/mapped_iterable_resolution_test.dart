import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tom_d4rt_flutter/tom_d4rt_flutter.dart';

/// Regression: native-object → bridge resolution must prefer a PRECISE
/// `nativeNames` match in an enclosing scope over a FUZZY name-prefix match in
/// a nearer scope.
///
/// Under the lazy-bridge substrate (import-optimization steps #17/#19) the
/// stdlib `Iterable` bridge — which carries `MappedListIterable` in its
/// `nativeNames` — lives in the warm-parent (enclosing) environment, while a
/// nearer module frame carries the `Map` bridge but not `Iterable`. The
/// previous single-pass-per-frame `Environment.toBridgedClass` returned the
/// fuzzy `"MappedListIterable".startsWith("Map")` match from the nearer frame
/// before reaching the precise `Iterable` match in the parent, so
/// `List.map(...).toList()` failed with
/// `Bridged class 'Map' has no instance method named 'toList'`.
///
/// The fix splits resolution into two chain walks (precise across all frames,
/// then fuzzy fallback across all frames). These tests pin that ordering.
void main() {
  test('List.map().toList() (MappedListIterable) resolves to List, not Map',
      () {
    final flutter = SourceFlutterD4rt();
    final result = flutter.build<Widget>('''
      import 'package:flutter/material.dart';
      Widget build() {
        final items = <int>[1, 2, 3];
        final children = items.map((i) {
          return SizedBox(width: 8.0 * i, height: 8);
        }).toList();
        return Column(children: children);
      }
    ''');
    expect(result, isA<Column>());
    expect((result as Column).children.length, 3);
  });

  test('List.map -> MapEntry then re-map (MappedListIterable<int,MapEntry>)',
      () {
    final flutter = SourceFlutterD4rt();
    final result = flutter.execute<int>('''
      int build() {
        final items = <int>[1, 2, 3];
        final entries = items.map((i) => MapEntry(i, i * 10));
        final doubled = entries.map((e) => e.value * 2).toList();
        return doubled.length;
      }
    ''', name: 'build');
    expect(result, 3);
  });

  test('Map.fromEntries from List.map MapEntries', () {
    final flutter = SourceFlutterD4rt();
    final result = flutter.execute<int>('''
      int build() {
        final items = <int>[1, 2, 3];
        final m = Map.fromEntries(items.map((i) => MapEntry(i, i * 10)));
        return m.length;
      }
    ''', name: 'build');
    expect(result, 3);
  });
}
