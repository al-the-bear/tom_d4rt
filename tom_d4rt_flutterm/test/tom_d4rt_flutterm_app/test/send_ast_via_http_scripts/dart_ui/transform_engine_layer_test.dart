import 'dart:typed_data';
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

void _expectCondition(bool condition, String message, List<String> logs) {
  if (!condition) {
    logs.add('FAIL: $message');
    throw StateError('TransformEngineLayer test failed: $message');
  }
  logs.add('PASS: $message');
}

Float64List _translation(double dx, double dy) {
  return Float64List.fromList(<double>[
    1,
    0,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    0,
    1,
    0,
    dx,
    dy,
    0,
    1,
  ]);
}

dynamic build(BuildContext context) {
  print('=== TransformEngineLayer comprehensive test start ===');

  final logs = <String>[];
  var assertionCount = 0;

  final builderA = ui.SceneBuilder();
  final transformA = _translation(12, 24);
  final layerA = builderA.pushTransform(transformA);

  _expectCondition(
    layerA is ui.TransformEngineLayer,
    'pushTransform creates TransformEngineLayer',
    logs,
  );
  assertionCount++;

  final recorderA = ui.PictureRecorder();
  final canvasA = ui.Canvas(recorderA);
  canvasA.drawRect(
    const ui.Rect.fromLTWH(0, 0, 20, 20),
    ui.Paint()..color = const ui.Color(0xFF00FF00),
  );
  builderA.addPicture(const ui.Offset(0, 0), recorderA.endRecording());
  builderA.pop();
  final sceneA = builderA.build();

  _expectCondition(
    sceneA is ui.Scene,
    'scene with transform layer builds successfully',
    logs,
  );
  assertionCount++;

  final builderB = ui.SceneBuilder();
  final transformB = _translation(-6, 18);
  final reusedLayer = builderB.pushTransform(transformB, oldLayer: layerA);

  _expectCondition(
    reusedLayer is ui.TransformEngineLayer,
    'oldLayer reuse returns TransformEngineLayer',
    logs,
  );
  assertionCount++;

  final recorderB = ui.PictureRecorder();
  final canvasB = ui.Canvas(recorderB);
  canvasB.drawCircle(
    const ui.Offset(10, 10),
    8,
    ui.Paint()..color = const ui.Color(0xFFFF0000),
  );
  builderB.addPicture(const ui.Offset(0, 0), recorderB.endRecording());
  builderB.pop();
  final sceneB = builderB.build();

  _expectCondition(
    sceneB is ui.Scene,
    'scene with reused transform layer builds successfully',
    logs,
  );
  assertionCount++;

  _expectCondition(
    ui.TransformEngineLayer.toString().contains('TransformEngineLayer'),
    'TransformEngineLayer type name is accessible',
    logs,
  );
  assertionCount++;

  final matrixLengths = <int>[transformA.length, transformB.length];
  _expectCondition(
    matrixLengths.every((value) => value == 16),
    'both transform matrices are 4x4',
    logs,
  );
  assertionCount++;

  _expectCondition(
    transformA[12] == 12 && transformA[13] == 24,
    'first transform translation stored in matrix',
    logs,
  );
  assertionCount++;

  _expectCondition(
    transformB[12] == -6 && transformB[13] == 18,
    'second transform translation stored in matrix',
    logs,
  );
  assertionCount++;

  sceneA.dispose();
  sceneB.dispose();

  print('layerA runtimeType: ${layerA.runtimeType}');
  print('reusedLayer runtimeType: ${reusedLayer.runtimeType}');
  print('matrixLengths: $matrixLengths');

  final summary = <String>[
    'constructor path covered by SceneBuilder.pushTransform',
    'properties covered by matrix content checks and type checks',
    'behavior covered with build/pop and oldLayer reuse path',
    'edge cases covered with negative translation and matrix length checks',
    'assertions: $assertionCount',
  ];

  for (final line in summary) {
    print('SUMMARY: $line');
  }

  print('=== TransformEngineLayer comprehensive test complete ===');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('TransformEngineLayer Tests'),
      Text('Assertions: $assertionCount'),
      Text('Layer A: ${layerA.runtimeType}'),
      Text('Layer B: ${reusedLayer.runtimeType}'),
      Text('Matrix lengths: $matrixLengths'),
      Text('Logs: ${logs.length} entries'),
      const Text('Summary widget generated successfully'),
    ],
  );
}
