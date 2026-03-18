// D4rt test script: Tests SemanticsProperties, CustomSemanticsAction,
// OrdinalSortKey, SemanticsTag, SemanticsHintOverrides
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

dynamic build(BuildContext context) {
  print('Semantics properties test executing');

  // ========== SemanticsProperties ==========
  print('--- SemanticsProperties Tests ---');

  final props = SemanticsProperties(
    enabled: true,
    checked: false,
    label: 'Test label',
    value: 'Test value',
    hint: 'Test hint',
    textDirection: TextDirection.ltr,
    button: true,
    header: false,
    link: false,
    focused: false,
    hidden: false,
    slider: false,
    toggled: false,
    readOnly: false,
    selected: false,
    liveRegion: false,
    maxValueLength: 100,
    currentValueLength: 50,
  );
  print('SemanticsProperties label: ${props.label}');
  print('SemanticsProperties value: ${props.value}');
  print('SemanticsProperties hint: ${props.hint}');
  print('SemanticsProperties enabled: ${props.enabled}');
  print('SemanticsProperties checked: ${props.checked}');
  print('SemanticsProperties button: ${props.button}');
  print('SemanticsProperties focused: ${props.focused}');
  print('SemanticsProperties textDirection: ${props.textDirection}');

  // ========== CustomSemanticsAction ==========
  print('--- CustomSemanticsAction Tests ---');

  final action1 = CustomSemanticsAction(label: 'Custom action 1');
  print('CustomSemanticsAction label: ${action1.label}');

  final action2 = CustomSemanticsAction(label: 'Custom action 2');
  print('CustomSemanticsAction label2: ${action2.label}');

  // ========== OrdinalSortKey ==========
  print('--- OrdinalSortKey Tests ---');

  final sortKey1 = OrdinalSortKey(1.0);
  print('OrdinalSortKey order: ${sortKey1.order}');
  print('OrdinalSortKey name: ${sortKey1.name}');

  final sortKey2 = OrdinalSortKey(2.0, name: 'secondary');
  print('OrdinalSortKey named order: ${sortKey2.order}');
  print('OrdinalSortKey named name: ${sortKey2.name}');

  final comparison = sortKey1.compareTo(sortKey2);
  print('OrdinalSortKey compareTo: $comparison');

  // ========== SemanticsTag ==========
  print('--- SemanticsTag Tests ---');

  final tag = SemanticsTag('myTag');
  print('SemanticsTag name: ${tag.name}');

  final tag2 = SemanticsTag('anotherTag');
  print('SemanticsTag2 name: ${tag2.name}');

  // ========== SemanticsHintOverrides ==========
  print('--- SemanticsHintOverrides Tests ---');

  final hintOverrides = SemanticsHintOverrides(
    onTapHint: 'Tap to activate',
    onLongPressHint: 'Long press to show options',
  );
  print('SemanticsHintOverrides onTapHint: ${hintOverrides.onTapHint}');
  print(
    'SemanticsHintOverrides onLongPressHint: ${hintOverrides.onLongPressHint}',
  );

  print('All semantics properties tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Semantics(
          label: 'Test label for semantics',
          value: 'value',
          hint: 'hint',
          button: true,
          enabled: true,
          sortKey: OrdinalSortKey(1.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Semantics Properties Test',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Label: ${props.label}'),
              Text('SortKey order: ${sortKey1.order}'),
              Semantics(
                customSemanticsActions: {
                  action1: () => print('Action 1'),
                  action2: () => print('Action 2'),
                },
                child: Text('Custom Actions'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
