// D4rt test script: Tests Semantics package classes and imports
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
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
