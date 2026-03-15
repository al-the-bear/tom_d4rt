// D4rt test script: Tests SemanticsData, SemanticsHintOverrides, SemanticsTag, OrdinalSortKey, AttributedString from semantics
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Semantics data test executing');

  // ========== SEMANTICSTAG ==========
  print('--- SemanticsTag Tests ---');

  final tag1 = SemanticsTag('button-tag');
  print('SemanticsTag("button-tag"): $tag1');
  print('  name: ${tag1.name}');
  print('  runtimeType: ${tag1.runtimeType}');

  final tag2 = SemanticsTag('header-tag');
  print('SemanticsTag("header-tag"): $tag2');
  print('  name: ${tag2.name}');

  final tag3 = SemanticsTag('custom-role');
  print('SemanticsTag("custom-role"): $tag3');

  // RenderViewport.excludeFromScrolling
  print('Built-in tag: RenderViewport.excludeFromScrolling exists');

  // ========== ORDINALSORTKEY ==========
  print('--- OrdinalSortKey Tests ---');

  final sortKey1 = OrdinalSortKey(1.0);
  print('OrdinalSortKey(1.0): $sortKey1');
  print('  order: ${sortKey1.order}');
  print('  name: ${sortKey1.name}');
  print('  runtimeType: ${sortKey1.runtimeType}');

  final sortKey2 = OrdinalSortKey(2.0);
  print('OrdinalSortKey(2.0): $sortKey2');
  print('  order: ${sortKey2.order}');

  final sortKey3 = OrdinalSortKey(0.5, name: 'header');
  print('OrdinalSortKey(0.5, name: "header"):');
  print('  order: ${sortKey3.order}');
  print('  name: ${sortKey3.name}');

  // Compare sort keys
  final cmp = sortKey1.compareTo(sortKey2);
  print('sortKey1.compareTo(sortKey2): $cmp');

  final cmpEqual = sortKey1.compareTo(OrdinalSortKey(1.0));
  print('sortKey1.compareTo(OrdinalSortKey(1.0)): $cmpEqual');

  // ========== SEMANTICSHINTOVERRIDES ==========
  print('--- SemanticsHintOverrides Tests ---');

  final hintOverrides1 = SemanticsHintOverrides(
    onTapHint: 'Activate button',
    onLongPressHint: 'Show options',
  );
  print('SemanticsHintOverrides:');
  print('  onTapHint: ${hintOverrides1.onTapHint}');
  print('  onLongPressHint: ${hintOverrides1.onLongPressHint}');
  print('  isNotEmpty: ${hintOverrides1.isNotEmpty}');
  print('  runtimeType: ${hintOverrides1.runtimeType}');

  final hintOverridesEmpty = SemanticsHintOverrides();
  print('Empty SemanticsHintOverrides:');
  print('  onTapHint: ${hintOverridesEmpty.onTapHint}');
  print('  onLongPressHint: ${hintOverridesEmpty.onLongPressHint}');
  print('  isNotEmpty: ${hintOverridesEmpty.isNotEmpty}');

  final tapOnly = SemanticsHintOverrides(onTapHint: 'Submit form');
  print('Tap-only hint: onTapHint="${tapOnly.onTapHint}"');

  // ========== ATTRIBUTEDSTRING ==========
  print('--- AttributedString Tests ---');

  final attrStr1 = AttributedString('Hello World');
  print('AttributedString("Hello World"):');
  print('  string: ${attrStr1.string}');
  print('  runtimeType: ${attrStr1.runtimeType}');

  final attrStr2 = AttributedString('Spell check test');
  print('AttributedString("Spell check test"):');
  print('  string: ${attrStr2.string}');

  // With locale attribute
  final attrStr3 = AttributedString(
    'Multilingual text',
    attributes: [
      LocaleStringAttribute(
        range: TextRange(start: 0, end: 12),
        locale: Locale('en', 'US'),
      ),
    ],
  );
  print('AttributedString with locale attribute:');
  print('  string: ${attrStr3.string}');
  print('  attributes count: ${attrStr3.attributes.length}');

  // With spell out attribute
  final attrStr4 = AttributedString(
    'ABC123',
    attributes: [SpellOutStringAttribute(range: TextRange(start: 0, end: 6))],
  );
  print('AttributedString with spell-out:');
  print('  string: ${attrStr4.string}');
  print('  attributes count: ${attrStr4.attributes.length}');

  // Concatenation
  final combined = attrStr1 + attrStr2;
  print('Concatenated: "${combined.string}"');

  // ========== SEMANTICSDATA NOTE ==========
  print('--- SemanticsData Notes ---');

  print('SemanticsData is typically created by the framework');
  print('  Contains all semantics information for a node');
  print('  Properties: flags, actions, attributedLabel, attributedValue');
  print('  attributedHint, attributedIncreasedValue, attributedDecreasedValue');
  print('  tooltip, textDirection, rect, elevation, thickness');
  print('  textSelection, scrollIndex, scrollChildCount, scrollPosition');
  print('  scrollExtentMax, scrollExtentMin, tags, transform');

  // ========== RETURN WIDGET ==========
  print('Semantics data test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Semantics Data Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text(
            'Classes Tested:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• SemanticsTag - semantic annotation tag'),
          Text('• OrdinalSortKey - ordering for accessibility'),
          Text('• SemanticsHintOverrides - hint text overrides'),
          Text('• AttributedString - string with attributes'),
          SizedBox(height: 16.0),

          Text(
            'Framework-Only:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• SemanticsData - full node data (framework-created)'),
          SizedBox(height: 16.0),

          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFE0F7FA),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tag: ${tag1.name}'),
                Text('SortKey: order=${sortKey1.order}'),
                Text('Hints: tap="${hintOverrides1.onTapHint}"'),
                Text('AttrString: "${attrStr1.string}"'),
                Text('Combined: "${combined.string}"'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
