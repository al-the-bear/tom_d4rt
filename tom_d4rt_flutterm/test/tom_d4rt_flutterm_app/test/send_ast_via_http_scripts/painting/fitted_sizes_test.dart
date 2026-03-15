// D4rt test script: Tests FittedSizes from painting
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FittedSizes test executing');
  final results = <String>[];

  // ========== Basic FittedSizes Tests ==========
  print('Testing FittedSizes constructor...');

  // Test 1: Create FittedSizes with source and destination
  final sourceSize1 = Size(200.0, 100.0);
  final destSize1 = Size(100.0, 50.0);
  final fitted1 = FittedSizes(sourceSize1, destSize1);
  assert(fitted1.source == sourceSize1, 'Source should match');
  assert(fitted1.destination == destSize1, 'Destination should match');
  results.add(
    'FittedSizes: source=${fitted1.source}, dest=${fitted1.destination}',
  );
  print('FittedSizes created: ${fitted1.source} -> ${fitted1.destination}');

  // Test 2: Square sizes
  final sourceSize2 = Size(150.0, 150.0);
  final destSize2 = Size(75.0, 75.0);
  final fitted2 = FittedSizes(sourceSize2, destSize2);
  assert(
    fitted2.source.width == fitted2.source.height,
    'Source should be square',
  );
  assert(
    fitted2.destination.width == fitted2.destination.height,
    'Dest should be square',
  );
  results.add(
    'Square FittedSizes: ${fitted2.source} -> ${fitted2.destination}',
  );
  print('Square: ${fitted2.source} -> ${fitted2.destination}');

  // Test 3: Different aspect ratios
  final sourceSize3 = Size(400.0, 300.0); // 4:3
  final destSize3 = Size(160.0, 90.0); // 16:9
  final fitted3 = FittedSizes(sourceSize3, destSize3);
  results.add('Different ratios: ${fitted3.source} -> ${fitted3.destination}');
  print('Different ratios: ${fitted3.source} -> ${fitted3.destination}');

  // ========== applyBoxFit Tests ==========
  print('Testing applyBoxFit function...');

  // Test 4: BoxFit.contain - fits inside preserving aspect ratio
  final inputSize = Size(800.0, 600.0);
  final outputBox = Size(400.0, 400.0);
  final containResult = applyBoxFit(BoxFit.contain, inputSize, outputBox);
  assert(
    containResult.source == inputSize,
    'Contain source should be full input',
  );
  results.add(
    'BoxFit.contain: source=${containResult.source}, dest=${containResult.destination}',
  );
  print('Contain: ${containResult.destination}');

  // Test 5: BoxFit.cover - covers fully, may clip
  final coverResult = applyBoxFit(BoxFit.cover, inputSize, outputBox);
  results.add(
    'BoxFit.cover: source=${coverResult.source}, dest=${coverResult.destination}',
  );
  print('Cover: ${coverResult.destination}');

  // Test 6: BoxFit.fill - stretches to fill
  final fillResult = applyBoxFit(BoxFit.fill, inputSize, outputBox);
  assert(fillResult.destination == outputBox, 'Fill should use full output');
  results.add(
    'BoxFit.fill: source=${fillResult.source}, dest=${fillResult.destination}',
  );
  print('Fill: ${fillResult.destination}');

  // Test 7: BoxFit.fitWidth
  final fitWidthResult = applyBoxFit(BoxFit.fitWidth, inputSize, outputBox);
  results.add('BoxFit.fitWidth: dest=${fitWidthResult.destination}');
  print('FitWidth: ${fitWidthResult.destination}');

  // Test 8: BoxFit.fitHeight
  final fitHeightResult = applyBoxFit(BoxFit.fitHeight, inputSize, outputBox);
  results.add('BoxFit.fitHeight: dest=${fitHeightResult.destination}');
  print('FitHeight: ${fitHeightResult.destination}');

  // Test 9: BoxFit.none - no scaling
  final noneResult = applyBoxFit(BoxFit.none, inputSize, outputBox);
  results.add('BoxFit.none: dest=${noneResult.destination}');
  print('None: ${noneResult.destination}');

  // Test 10: BoxFit.scaleDown
  final scaleDownResult = applyBoxFit(BoxFit.scaleDown, inputSize, outputBox);
  results.add('BoxFit.scaleDown: dest=${scaleDownResult.destination}');
  print('ScaleDown: ${scaleDownResult.destination}');

  // ========== All BoxFit Values ==========
  print('Testing all BoxFit values...');

  for (final fit in BoxFit.values) {
    final result = applyBoxFit(fit, Size(1920.0, 1080.0), Size(300.0, 200.0));
    results.add(
      'BoxFit.${fit.name}: ${result.destination.width.toStringAsFixed(1)}x${result.destination.height.toStringAsFixed(1)}',
    );
    print('BoxFit.${fit.name}: ${result.destination}');
  }

  // ========== Edge Cases ==========
  print('Testing edge cases...');

  // Test 11: Zero destination
  final zeroDestResult = applyBoxFit(
    BoxFit.contain,
    Size(100.0, 100.0),
    Size.zero,
  );
  results.add('Zero dest: ${zeroDestResult.destination}');
  print('Zero dest: ${zeroDestResult.destination}');

  // Test 12: Very small source
  final smallResult = applyBoxFit(
    BoxFit.contain,
    Size(1.0, 1.0),
    Size(100.0, 100.0),
  );
  results.add('Small source: ${smallResult.destination}');
  print('Small source: ${smallResult.destination}');

  // Test 13: Very large source
  final largeResult = applyBoxFit(
    BoxFit.contain,
    Size(10000.0, 10000.0),
    Size(100.0, 100.0),
  );
  results.add('Large source: ${largeResult.destination}');
  print('Large source: ${largeResult.destination}');

  // ========== Aspect Ratio Calculations ==========
  print('Testing aspect ratio scenarios...');

  final aspectRatios = [
    {'w': 16.0, 'h': 9.0, 'name': '16:9'},
    {'w': 4.0, 'h': 3.0, 'name': '4:3'},
    {'w': 1.0, 'h': 1.0, 'name': '1:1'},
    {'w': 9.0, 'h': 16.0, 'name': '9:16'},
    {'w': 21.0, 'h': 9.0, 'name': '21:9'},
  ];

  for (final ar in aspectRatios) {
    final sourceAR = Size((ar['w'] as double) * 100, (ar['h'] as double) * 100);
    final result = applyBoxFit(BoxFit.contain, sourceAR, Size(200.0, 200.0));
    results.add(
      'Aspect ${ar['name']}: ${result.destination.width.toStringAsFixed(0)}x${result.destination.height.toStringAsFixed(0)}',
    );
    print('${ar['name']}: ${result.destination}');
  }

  // ========== FittedSizes Equality ==========
  print('Testing FittedSizes equality...');

  final fittedA = FittedSizes(Size(10.0, 10.0), Size(5.0, 5.0));
  final fittedB = FittedSizes(Size(10.0, 10.0), Size(5.0, 5.0));
  final fittedC = FittedSizes(Size(10.0, 10.0), Size(6.0, 6.0));

  assert(fittedA.source == fittedB.source, 'Sources should match');
  assert(
    fittedA.destination == fittedB.destination,
    'Destinations should match',
  );
  results.add(
    'Equality: A==B (same) ${fittedA.source == fittedB.source && fittedA.destination == fittedB.destination}',
  );
  results.add(
    'Inequality: A!=C (diff dest) ${fittedA.destination != fittedC.destination}',
  );
  print('Equality tests completed');

  print('FittedSizes test completed: ${results.length} tests passed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'FittedSizes Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      Text('Total tests: ${results.length}', style: TextStyle(fontSize: 14)),
      Divider(),
      ...results.map(
        (r) => Padding(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Text(r, style: TextStyle(fontSize: 11)),
        ),
      ),
    ],
  );
}
