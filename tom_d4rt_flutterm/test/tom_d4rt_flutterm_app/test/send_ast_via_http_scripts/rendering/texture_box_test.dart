// D4rt test script: Tests TextureBox from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextureBox test executing');
  final results = <String>[];

  // ========== Section 1: Basic Creation ==========
  print('--- Section 1: Basic TextureBox Creation ---');

  final textureBox1 = TextureBox(textureId: 1);
  print('Created TextureBox: ${textureBox1.runtimeType}');
  print('textureId: ${textureBox1.textureId}');
  print('Is RenderBox: ${textureBox1 is RenderBox}');
  results.add('Basic creation: textureId=1');

  // ========== Section 2: Various Texture IDs ==========
  print('--- Section 2: Various Texture IDs ---');

  final textureIds = [0, 1, 5, 10, 100, 1000];
  for (final id in textureIds) {
    final tb = TextureBox(textureId: id);
    print('TextureBox with textureId $id: ${tb.textureId}');
  }
  results.add('Tested ${textureIds.length} texture IDs');

  // ========== Section 3: FilterQuality Property ==========
  print('--- Section 3: FilterQuality Property ---');

  // Default filter quality
  final defaultQuality = TextureBox(textureId: 1);
  print('Default filterQuality: ${defaultQuality.filterQuality}');

  // Low filter quality
  final lowQuality = TextureBox(textureId: 1, filterQuality: FilterQuality.low);
  print('Low filterQuality: ${lowQuality.filterQuality}');

  // Medium filter quality
  final mediumQuality = TextureBox(
    textureId: 1,
    filterQuality: FilterQuality.medium,
  );
  print('Medium filterQuality: ${mediumQuality.filterQuality}');

  // High filter quality
  final highQuality = TextureBox(
    textureId: 1,
    filterQuality: FilterQuality.high,
  );
  print('High filterQuality: ${highQuality.filterQuality}');

  // None filter quality
  final noneQuality = TextureBox(
    textureId: 1,
    filterQuality: FilterQuality.none,
  );
  print('None filterQuality: ${noneQuality.filterQuality}');
  results.add('FilterQuality tested: all values');

  // ========== Section 4: All FilterQuality Values ==========
  print('--- Section 4: All FilterQuality Values ---');

  for (final quality in FilterQuality.values) {
    final tb = TextureBox(textureId: 1, filterQuality: quality);
    print('FilterQuality.${quality.name}: ${tb.filterQuality}');
  }
  print('Total FilterQuality values: ${FilterQuality.values.length}');
  results.add('FilterQuality enum: ${FilterQuality.values.length} values');

  // ========== Section 5: Freeze Property ==========
  print('--- Section 5: Freeze Property ---');

  final unfrozen = TextureBox(textureId: 1, freeze: false);
  print('Unfrozen: freeze=${unfrozen.freeze}');

  final frozen = TextureBox(textureId: 1, freeze: true);
  print('Frozen: freeze=${frozen.freeze}');
  results.add('Freeze property tested');

  // ========== Section 6: Changing Texture ID ==========
  print('--- Section 6: Changing Texture ID ---');

  final tb = TextureBox(textureId: 1);
  print('Initial textureId: ${tb.textureId}');

  tb.textureId = 5;
  print('After setting to 5: ${tb.textureId}');

  tb.textureId = 100;
  print('After setting to 100: ${tb.textureId}');
  results.add('Texture ID change tested');

  // ========== Section 7: Changing Filter Quality ==========
  print('--- Section 7: Changing Filter Quality ---');

  final tb2 = TextureBox(textureId: 1, filterQuality: FilterQuality.low);
  print('Initial filterQuality: ${tb2.filterQuality}');

  tb2.filterQuality = FilterQuality.high;
  print('After setting to high: ${tb2.filterQuality}');

  tb2.filterQuality = FilterQuality.medium;
  print('After setting to medium: ${tb2.filterQuality}');
  results.add('Filter quality change tested');

  // ========== Section 8: Changing Freeze ==========
  print('--- Section 8: Changing Freeze ---');

  final tb3 = TextureBox(textureId: 1, freeze: false);
  print('Initial freeze: ${tb3.freeze}');

  tb3.freeze = true;
  print('After setting to true: ${tb3.freeze}');

  tb3.freeze = false;
  print('After setting to false: ${tb3.freeze}');
  results.add('Freeze change tested');

  // ========== Section 9: Multiple Instances ==========
  print('--- Section 9: Multiple Instances ---');

  final instances = <TextureBox>[];
  for (int i = 0; i < 5; i++) {
    final tb = TextureBox(
      textureId: i,
      filterQuality: FilterQuality.values[i % FilterQuality.values.length],
      freeze: i % 2 == 0,
    );
    instances.add(tb);
    print(
      'Instance $i - textureId: ${tb.textureId}, filterQuality: ${tb.filterQuality}, freeze: ${tb.freeze}',
    );
  }
  results.add('Created ${instances.length} instances');

  // ========== Section 10: Inheritance Chain ==========
  print('--- Section 10: Inheritance Chain ---');

  final textureBox2 = TextureBox(textureId: 1);
  print('Is RenderObject: ${textureBox2 is RenderObject}');
  print('Is RenderBox: ${textureBox2 is RenderBox}');
  print('Is TextureBox: ${textureBox2 is TextureBox}');
  print('Runtime type: ${textureBox2.runtimeType}');
  results.add('Inheritance chain verified');

  // ========== Section 11: SizedByParent Property ==========
  print('--- Section 11: SizedByParent Property ---');

  final textureBox3 = TextureBox(textureId: 1);
  print('sizedByParent: ${textureBox3.sizedByParent}');
  results.add('sizedByParent: ${textureBox3.sizedByParent}');

  // ========== Section 12: Large Texture IDs ==========
  print('--- Section 12: Large Texture IDs ---');

  final largeIds = [10000, 100000, 1000000, 999999999];
  for (final id in largeIds) {
    final tb = TextureBox(textureId: id);
    print('Large textureId $id: ${tb.textureId}');
  }
  results.add('Tested ${largeIds.length} large texture IDs');

  print('TextureBox test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextureBox Tests'),
      Text('Results: ${results.length} sections'),
      ...results.map((r) => Text(r)),
    ],
  );
}
