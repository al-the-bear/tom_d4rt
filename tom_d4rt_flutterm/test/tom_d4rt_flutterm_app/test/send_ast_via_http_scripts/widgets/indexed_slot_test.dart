// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests IndexedSlot from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IndexedSlot test executing');
  print('=' * 50);

  // === IndexedSlot class tests ===
  // IndexedSlot is an immutable class used as slot values for
  // children of a MultiChildRenderObjectElement. It pairs an
  // index with an optional Element value.

  // Test 1: Create IndexedSlot instances
  print('\nTest 1: Create IndexedSlot instances');
  const slot1 = IndexedSlot<Element?>(0, null);
  print('Created IndexedSlot with index 0 and null value');
  print('index: ${slot1.index}');
  print('value: ${slot1.value}');
  print('Type: ${slot1.runtimeType}');

  // Test 2: IndexedSlot with different indices
  print('\nTest 2: Different indices');
  const slots = [
    IndexedSlot<Element?>(0, null),
    IndexedSlot<Element?>(1, null),
    IndexedSlot<Element?>(5, null),
    IndexedSlot<Element?>(100, null),
  ];
  for (final slot in slots) {
    print('  index: ${slot.index}');
  }

  // Test 3: Equality comparison
  print('\nTest 3: Equality comparison');
  const slotA = IndexedSlot<Element?>(0, null);
  const slotB = IndexedSlot<Element?>(0, null);
  const slotC = IndexedSlot<Element?>(1, null);
  print('slotA == slotB (same index, same value): ${slotA == slotB}');
  print('slotA == slotC (different index): ${slotA == slotC}');

  // Test 4: Hash code behavior
  print('\nTest 4: Hash code behavior');
  print('slotA.hashCode: ${slotA.hashCode}');
  print('slotB.hashCode: ${slotB.hashCode}');
  print('Hash codes equal: ${slotA.hashCode == slotB.hashCode}');
  print('slotC.hashCode: ${slotC.hashCode}');
  print('Different from slotA: ${slotA.hashCode != slotC.hashCode}');

  // Test 5: Immutability
  print('\nTest 5: Immutability');
  print('@immutable annotation ensures compile-time safety');
  print('Properties are final: index, value');
  print('Const constructor available');

  // Test 6: Generic type parameter
  print('\nTest 6: Generic type parameter');
  print('IndexedSlot<T extends Element?>');
  print('T represents the type of the slot value');
  print('Typically Element? in practice');

  // Test 7: Usage context
  print('\nTest 7: Usage context');
  print('Used by RenderObjectElement.updateChildren()');
  print('Represents position in parent child list');
  print('value: previous sibling Element or null');
  print('index: position in children list');

  // Test 8: Comparison operators
  print('\nTest 8: Comparison implementation');
  print('operator ==:');
  print('  - Checks runtimeType');
  print('  - Compares index');
  print('  - Compares value');

  // Test 9: Multiple slots pattern
  print('\nTest 9: Multiple slots pattern');
  final slotList = List.generate(
    5,
    (i) => IndexedSlot<Element?>(i, null),
  );
  print('Generated ${slotList.length} slots');
  for (int i = 0; i < slotList.length; i++) {
    print('  Slot $i: index=${slotList[i].index}');
  }

  // Test 10: Const canonicalization
  print('\nTest 10: Const canonicalization');
  const s1 = IndexedSlot<Element?>(0, null);
  const s2 = IndexedSlot<Element?>(0, null);
  print('identical(s1, s2): ${identical(s1, s2)}');

  print('\n' + '=' * 50);
  print('IndexedSlot test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'IndexedSlot Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Tests: 10 categories executed'),
      Text('Type: @immutable generic class'),
      Text('Properties: index, value'),
      Text('Purpose: Child slot tracking'),
    ],
  );
}
