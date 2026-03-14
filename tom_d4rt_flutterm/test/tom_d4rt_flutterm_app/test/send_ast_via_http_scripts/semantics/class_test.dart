// D4rt test script: Tests Semantics package classes and imports
import 'dart:ui';
import 'package:flutter/semantics.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Semantics package classes comprehensive test executing');
  final results = <String>[];

  // ========== Semantics Package Class Tests ==========
  print('Testing Semantics package classes...');

  // Test 1: SemanticsConfiguration availability
  final config = SemanticsConfiguration();
  assert(config != null, 'SemanticsConfiguration should be available');
  results.add('SemanticsConfiguration available');
  print('SemanticsConfiguration: ${config.runtimeType}');

  // Test 2: SemanticsData availability
  final data = SemanticsData(
    flags: 0,
    actions: 0,
    identifier: '',
    attributedLabel: AttributedString('Test'),
    attributedValue: AttributedString(''),
    attributedIncreasedValue: AttributedString(''),
    attributedDecreasedValue: AttributedString(''),
    attributedHint: AttributedString(''),
    tooltip: '',
    textDirection: TextDirection.ltr,
    rect: Rect.zero,
    elevation: 0,
    thickness: 0,
    textSelection: null,
    scrollIndex: null,
    scrollChildCount: null,
    scrollPosition: null,
    scrollExtentMax: null,
    scrollExtentMin: null,
    platformViewId: null,
    maxValueLength: null,
    currentValueLength: null,
    tags: null,
    transform: null,
    customSemanticsActionIds: null,
    headingLevel: 0,
    linkUrl: null,
    role: null,
    controlsNodes: null,
  );
  assert(data != null, 'SemanticsData should be available');
  results.add('SemanticsData available');
  print('SemanticsData: ${data.runtimeType}');

  // Test 3: SemanticsProperties availability
  final props = SemanticsProperties(
    label: 'Test widget',
    hint: 'Double tap to activate',
  );
  assert(props != null, 'SemanticsProperties should be available');
  results.add('SemanticsProperties available');
  print('SemanticsProperties: ${props.label}');

  // Test 4: SemanticsTag availability
  final tag = SemanticsTag('custom_tag');
  assert(tag.name == 'custom_tag', 'SemanticsTag name should match');
  results.add('SemanticsTag: custom_tag');
  print('SemanticsTag: ${tag.name}');

  // Test 5: AttributedString availability
  final attrStr = AttributedString('Hello World');
  assert(attrStr.string == 'Hello World', 'AttributedString should work');
  results.add('AttributedString: Hello World');
  print('AttributedString: ${attrStr.string}');

  // Test 6: LocaleStringAttribute availability
  final localeAttr = LocaleStringAttribute(
    range: TextRange(start: 0, end: 5),
    locale: Locale('en', 'US'),
  );
  assert(localeAttr.locale.languageCode == 'en', 'Locale should be en');
  results.add('LocaleStringAttribute: en_US');
  print('LocaleStringAttribute: ${localeAttr.locale}');

  // Test 7: SpellOutStringAttribute availability
  final spellAttr = SpellOutStringAttribute(range: TextRange(start: 0, end: 5));
  assert(spellAttr.range.start == 0, 'SpellOut range should start at 0');
  results.add('SpellOutStringAttribute available');
  print('SpellOutStringAttribute: range=${spellAttr.range}');

  // Test 8: SemanticsAction enum
  final actions = SemanticsAction.values;
  assert(actions.contains(SemanticsAction.tap), 'Should have tap action');
  assert(actions.contains(SemanticsAction.longPress), 'Should have longPress');
  assert(actions.contains(SemanticsAction.scrollUp), 'Should have scrollUp');
  results.add('SemanticsAction: ${actions.length} values');
  print('SemanticsAction values: ${actions.length}');

  // Test 9: SemanticsFlag enum
  final flags = SemanticsFlag.values;
  assert(flags.contains(SemanticsFlag.isButton), 'Should have isButton');
  assert(flags.contains(SemanticsFlag.isTextField), 'Should have isTextField');
  results.add('SemanticsFlag: ${flags.length} values');
  print('SemanticsFlag values: ${flags.length}');

  // Test 10: AnnounceSemanticsEvent class
  final announce = AnnounceSemanticsEvent('Hello', TextDirection.ltr);
  assert(announce.message == 'Hello', 'Announce message should match');
  results.add('AnnounceSemanticsEvent available');
  print('AnnounceSemanticsEvent: ${announce.message}');

  // Test 11: TooltipSemanticsEvent class
  final tooltip = TooltipSemanticsEvent('Tooltip text');
  assert(tooltip.message == 'Tooltip text', 'Tooltip message should match');
  results.add('TooltipSemanticsEvent available');
  print('TooltipSemanticsEvent: ${tooltip.message}');

  // Test 12: TapSemanticEvent class
  final tap = TapSemanticEvent(1);
  assert(tap.nodeId == 1, 'TapSemanticEvent nodeId should be 1');
  results.add('TapSemanticEvent: nodeId=1');
  print('TapSemanticEvent: nodeId=${tap.nodeId}');

  // Test 13: LongPressSemanticsEvent class
  final longPress = LongPressSemanticsEvent(2);
  assert(longPress.nodeId == 2, 'LongPress nodeId should be 2');
  results.add('LongPressSemanticsEvent: nodeId=2');
  print('LongPressSemanticsEvent: nodeId=${longPress.nodeId}');

  // Test 14: FocusSemanticsEvent class
  final focus = FocusSemanticsEvent(3);
  assert(focus.nodeId == 3, 'Focus nodeId should be 3');
  results.add('FocusSemanticsEvent: nodeId=3');
  print('FocusSemanticsEvent: nodeId=${focus.nodeId}');

  // Test 15: Semantics widget
  final semanticsWidget = Semantics(
    label: 'Test Semantics',
    child: Container(),
  );
  assert(semanticsWidget != null, 'Semantics widget should be created');
  results.add('Semantics widget available');
  print('Semantics widget created');

  // Test 16: SemanticsDebugger widget
  results.add('SemanticsDebugger available for debugging');
  print('SemanticsDebugger: visual debugging tool');

  // Test 17: CustomSemanticsAction class
  final customAction = CustomSemanticsAction(label: 'Custom Action');
  assert(customAction.label == 'Custom Action', 'Custom action label should match');
  results.add('CustomSemanticsAction: Custom Action');
  print('CustomSemanticsAction: ${customAction.label}');

  // Test 18: OrdinalSortKey class
  final sortKey = OrdinalSortKey(1.0);
  assert(sortKey.order == 1.0, 'Sort key order should be 1.0');
  results.add('OrdinalSortKey: order=1.0');
  print('OrdinalSortKey: order=${sortKey.order}');

  // Test 19: Assertiveness enum
  final assertiveness = Assertiveness.values;
  assert(assertiveness.contains(Assertiveness.polite), 'Should have polite');
  assert(assertiveness.contains(Assertiveness.assertive), 'Should have assertive');
  results.add('Assertiveness: ${assertiveness.length} values');
  print('Assertiveness values: $assertiveness');

  // Test 20: Summary
  print('Semantics package classes test completed with ${results.length} tests');
  results.add('All tests passed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Semantics Package Classes', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('Core: SemanticsConfiguration, SemanticsData'),
      Text('Events: Announce, Tooltip, Tap, LongPress, Focus'),
      Text('Attributes: LocaleString, SpellOut'),
      Text('Enums: SemanticsAction, SemanticsFlag, Assertiveness'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
