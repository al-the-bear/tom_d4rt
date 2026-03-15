// D4rt test script: Tests AssetBundleImageKey from painting
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AssetBundleImageKey test executing');
  final results = <String>[];

  // ========== AssetBundleImageKey Tests ==========
  print('Testing AssetBundleImageKey...');

  // Test 1: Create AssetBundleImageKey with standard scale
  final bundle = rootBundle;
  final key1 = AssetBundleImageKey(
    bundle: bundle,
    name: 'assets/images/test.png',
    scale: 1.0,
  );
  assert(key1.name == 'assets/images/test.png', 'Name should match');
  assert(key1.scale == 1.0, 'Scale should be 1.0');
  results.add('AssetBundleImageKey name: ${key1.name}');
  print('AssetBundleImageKey created: ${key1.name}');

  // Test 2: AssetBundleImageKey with 2x scale
  final key2 = AssetBundleImageKey(
    bundle: bundle,
    name: 'assets/images/2x/test.png',
    scale: 2.0,
  );
  assert(key2.scale == 2.0, 'Scale should be 2.0');
  results.add('AssetBundleImageKey 2x scale: ${key2.scale}');
  print('AssetBundleImageKey 2x: scale=${key2.scale}');

  // Test 3: AssetBundleImageKey with 3x scale
  final key3 = AssetBundleImageKey(
    bundle: bundle,
    name: 'assets/images/3x/test.png',
    scale: 3.0,
  );
  assert(key3.scale == 3.0, 'Scale should be 3.0');
  results.add('AssetBundleImageKey 3x scale: ${key3.scale}');
  print('AssetBundleImageKey 3x: scale=${key3.scale}');

  // Test 4: AssetBundleImageKey with fractional scale
  final key4 = AssetBundleImageKey(
    bundle: bundle,
    name: 'assets/images/1.5x/test.png',
    scale: 1.5,
  );
  assert(key4.scale == 1.5, 'Scale should be 1.5');
  results.add('AssetBundleImageKey 1.5x scale: ${key4.scale}');
  print('AssetBundleImageKey 1.5x: scale=${key4.scale}');

  // Test 5: AssetBundleImageKey bundle reference
  final key5 = AssetBundleImageKey(
    bundle: bundle,
    name: 'test_asset.png',
    scale: 1.0,
  );
  assert(key5.bundle == bundle, 'Bundle should match rootBundle');
  results.add('AssetBundleImageKey bundle: verified');
  print('AssetBundleImageKey bundle reference verified');

  // Test 6: AssetBundleImageKey with different path
  final key6 = AssetBundleImageKey(
    bundle: bundle,
    name: 'packages/my_package/icons/icon.png',
    scale: 1.0,
  );
  assert(key6.name.contains('packages'), 'Name should contain packages');
  results.add('AssetBundleImageKey package path: ${key6.name}');
  print('AssetBundleImageKey package path verified');

  // Test 7: AssetBundleImageKey equality - same values
  final keyA = AssetBundleImageKey(
    bundle: bundle,
    name: 'same.png',
    scale: 1.0,
  );
  final keyB = AssetBundleImageKey(
    bundle: bundle,
    name: 'same.png',
    scale: 1.0,
  );
  assert(keyA == keyB, 'Same keys should be equal');
  results.add('AssetBundleImageKey equality: ${keyA == keyB}');
  print('AssetBundleImageKey equality verified');

  // Test 8: AssetBundleImageKey inequality - different names
  final keyC = AssetBundleImageKey(bundle: bundle, name: 'a.png', scale: 1.0);
  final keyD = AssetBundleImageKey(bundle: bundle, name: 'b.png', scale: 1.0);
  assert(keyC != keyD, 'Different names should not be equal');
  results.add('AssetBundleImageKey inequality (name): ${keyC != keyD}');
  print('AssetBundleImageKey name inequality verified');

  // Test 9: AssetBundleImageKey inequality - different scales
  final keyE = AssetBundleImageKey(
    bundle: bundle,
    name: 'test.png',
    scale: 1.0,
  );
  final keyF = AssetBundleImageKey(
    bundle: bundle,
    name: 'test.png',
    scale: 2.0,
  );
  assert(keyE != keyF, 'Different scales should not be equal');
  results.add('AssetBundleImageKey inequality (scale): ${keyE != keyF}');
  print('AssetBundleImageKey scale inequality verified');

  // Test 10: AssetBundleImageKey hashCode
  final hash1 = keyA.hashCode;
  final hash2 = keyB.hashCode;
  assert(hash1 == hash2, 'Equal keys should have same hashCode');
  results.add('AssetBundleImageKey hashCode: $hash1');
  print('AssetBundleImageKey hashCode: $hash1');

  // Test 11: AssetBundleImageKey toString
  final keyStr = key1.toString();
  assert(keyStr.isNotEmpty, 'toString should not be empty');
  results.add('AssetBundleImageKey toString: ${keyStr.length} chars');
  print('AssetBundleImageKey toString: $keyStr');

  // Test 12: AssetBundleImageKey with nested directory
  final key12 = AssetBundleImageKey(
    bundle: bundle,
    name: 'assets/category/subcategory/deep/image.png',
    scale: 1.0,
  );
  assert(key12.name.split('/').length == 5, 'Should have 5 path segments');
  results.add('AssetBundleImageKey nested path: ${key12.name}');
  print('AssetBundleImageKey nested path verified');

  print('AssetBundleImageKey test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AssetBundleImageKey Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
