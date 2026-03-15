// D4rt test script: Tests AssetBundleImageProvider conceptual via AssetImage from painting
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AssetBundleImageProvider test executing');
  final results = <String>[];

  // ========== AssetBundleImageProvider via AssetImage Tests ==========
  // AssetBundleImageProvider is an abstract base class
  // We test via concrete implementation AssetImage
  print('Testing AssetBundleImageProvider concepts via AssetImage...');

  // Test 1: Create basic AssetImage
  final assetImage1 = AssetImage('assets/images/logo.png');
  assert(
    assetImage1.assetName == 'assets/images/logo.png',
    'Asset name should match',
  );
  results.add('AssetImage name: ${assetImage1.assetName}');
  print('AssetImage created: ${assetImage1.assetName}');

  // Test 2: AssetImage with package
  final assetImage2 = AssetImage('icons/icon.png', package: 'my_package');
  assert(assetImage2.package == 'my_package', 'Package should match');
  results.add('AssetImage package: ${assetImage2.package}');
  print('AssetImage package: ${assetImage2.package}');

  // Test 3: AssetImage keyName with package
  final assetImage3 = AssetImage('icon.png', package: 'other_package');
  final keyName3 = assetImage3.keyName;
  assert(keyName3.contains('packages'), 'KeyName should contain packages');
  results.add('AssetImage keyName: $keyName3');
  print('AssetImage keyName: $keyName3');

  // Test 4: AssetImage without package keyName
  final assetImage4 = AssetImage('assets/test.png');
  assert(
    assetImage4.keyName == 'assets/test.png',
    'KeyName should equal assetName',
  );
  results.add('AssetImage no-package keyName: ${assetImage4.keyName}');
  print('AssetImage keyName without package verified');

  // Test 5: AssetImage with explicit bundle
  final customBundle = rootBundle;
  final assetImage5 = AssetImage('test.png', bundle: customBundle);
  assert(assetImage5.bundle == customBundle, 'Bundle should match');
  results.add('AssetImage bundle: bundled');
  print('AssetImage bundle reference verified');

  // Test 6: AssetImage equality
  final imgA = AssetImage('same.png');
  final imgB = AssetImage('same.png');
  assert(imgA == imgB, 'Same asset images should be equal');
  results.add('AssetImage equality: ${imgA == imgB}');
  print('AssetImage equality verified');

  // Test 7: AssetImage inequality
  final imgC = AssetImage('a.png');
  final imgD = AssetImage('b.png');
  assert(imgC != imgD, 'Different asset images should not be equal');
  results.add('AssetImage inequality: ${imgC != imgD}');
  print('AssetImage inequality verified');

  // Test 8: AssetImage hashCode consistency
  final hash1 = imgA.hashCode;
  final hash2 = imgB.hashCode;
  assert(hash1 == hash2, 'Equal images should have same hashCode');
  results.add('AssetImage hashCode: $hash1');
  print('AssetImage hashCode: $hash1');

  // Test 9: AssetImage toString
  final strVal = assetImage1.toString();
  assert(strVal.isNotEmpty, 'toString should not be empty');
  results.add('AssetImage toString: ${strVal.length} chars');
  print('AssetImage toString: $strVal');

  // Test 10: ExactAssetImage - related class
  final exactAsset = ExactAssetImage('assets/exact.png', scale: 2.0);
  assert(exactAsset.scale == 2.0, 'Scale should be 2.0');
  assert(exactAsset.assetName == 'assets/exact.png', 'Asset name should match');
  results.add('ExactAssetImage scale: ${exactAsset.scale}');
  print('ExactAssetImage: scale=${exactAsset.scale}');

  // Test 11: ExactAssetImage with package
  final exactAsset2 = ExactAssetImage('icon.png', scale: 1.0, package: 'pkg');
  assert(exactAsset2.package == 'pkg', 'Package should match');
  results.add('ExactAssetImage package: ${exactAsset2.package}');
  print('ExactAssetImage package: ${exactAsset2.package}');

  // Test 12: ExactAssetImage keyName
  final exactKeyName = exactAsset2.keyName;
  assert(exactKeyName.contains('packages'), 'Should contain packages path');
  results.add('ExactAssetImage keyName: $exactKeyName');
  print('ExactAssetImage keyName: $exactKeyName');

  // Test 13: ExactAssetImage equality
  final exact1 = ExactAssetImage('test.png', scale: 2.0);
  final exact2 = ExactAssetImage('test.png', scale: 2.0);
  assert(exact1 == exact2, 'Equal exact images should be equal');
  results.add('ExactAssetImage equality: ${exact1 == exact2}');
  print('ExactAssetImage equality verified');

  print('AssetBundleImageProvider test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AssetBundleImageProvider Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
