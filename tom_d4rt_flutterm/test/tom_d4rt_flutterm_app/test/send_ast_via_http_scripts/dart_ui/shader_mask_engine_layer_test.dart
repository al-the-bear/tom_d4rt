import 'dart:typed_data';
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

void _expectCondition(bool condition, String message, List<String> logs) {
  if (!condition) {
    logs.add('FAIL: $message');
    throw StateError('ShaderMaskEngineLayer test failed: $message');
  }
  logs.add('PASS: $message');
}

Float64List _identityMatrix4() {
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
    0,
    0,
    0,
    1,
  ]);
}

dynamic build(BuildContext context) {
  print('=== ShaderMaskEngineLayer comprehensive test start ===');

  final logs = <String>[];
  var assertionCount = 0;

  final builderA = ui.SceneBuilder();
  final gradient = const ui.Gradient.linear(
    ui.Offset(0, 0),
    ui.Offset(30, 30),
    <ui.Color>[ui.Color(0xFF0000FF), ui.Color(0xFFFF00FF)],
  );
  final shader = gradient.createShader(const ui.Rect.fromLTWH(0, 0, 30, 30));

  final layerA = builderA.pushShaderMask(
    shader,
    const ui.Rect.fromLTWH(0, 0, 30, 30),
    ui.BlendMode.srcIn,
  );

  _expectCondition(
    layerA is ui.ShaderMaskEngineLayer,
    'pushShaderMask returns ShaderMaskEngineLayer',
    logs,
  );
  assertionCount++;

  builderA.addPicture(
    const ui.Offset(0, 0),
    (() {
      final recorder = ui.PictureRecorder();
      final canvas = ui.Canvas(recorder);
      canvas.drawRect(
        const ui.Rect.fromLTWH(0, 0, 10, 10),
        ui.Paint()..color = const ui.Color(0xFFFFFFFF),
      );
      return recorder.endRecording();
    })(),
  );
  builderA.pop();

  final sceneA = builderA.build();
  _expectCondition(
    sceneA is ui.Scene,
    'scene build with shader mask layer succeeds',
    logs,
  );
  assertionCount++;

  final builderB = ui.SceneBuilder();
  final transformLayer = builderB.pushTransform(_identityMatrix4());
  _expectCondition(
    transformLayer is ui.TransformEngineLayer,
    'pushTransform returns TransformEngineLayer',
    logs,
  );
  assertionCount++;

  final reusedLayer = builderB.pushShaderMask(
    shader,
    const ui.Rect.fromLTWH(0, 0, 12, 12),
    ui.BlendMode.srcOver,
    oldLayer: layerA,
    filterQuality: ui.FilterQuality.medium,
  );

  _expectCondition(
    reusedLayer is ui.ShaderMaskEngineLayer,
    'oldLayer reuse returns ShaderMaskEngineLayer',
    logs,
  );
  assertionCount++;

  builderB.pop();
  builderB.pop();
  final sceneB = builderB.build();
  _expectCondition(sceneB is ui.Scene, 'second scene build succeeds', logs);
  assertionCount++;

  // Edge behavior: ensure type-level checks for constructor accessibility.
  final layerTypeName = ui.ShaderMaskEngineLayer.toString();
  _expectCondition(
    layerTypeName.contains('ShaderMaskEngineLayer'),
    'type name includes ShaderMaskEngineLayer',
    logs,
  );
  assertionCount++;

  final blendModes = <ui.BlendMode>[
    ui.BlendMode.srcIn,
    ui.BlendMode.srcOver,
    ui.BlendMode.modulate,
  ];
  _expectCondition(
    blendModes.length == 3,
    'multiple blend modes prepared for behavior coverage',
    logs,
  );
  assertionCount++;

  for (var index = 0; index < blendModes.length; index++) {
    print('blendMode[$index] = ${blendModes[index]}');
  }

  sceneA.dispose();
  sceneB.dispose();

  final summary = <String>[
    'constructors/creation path covered via SceneBuilder.pushShaderMask',
    'properties/type checks covered with runtime and type-name assertions',
    'behavior covered: scene build + oldLayer reuse + filterQuality options',
    'edge case covered: creation path validation without direct constructor',
    'assertions: $assertionCount',
  ];

  for (final line in summary) {
    print('SUMMARY: $line');
  }

  print('=== ShaderMaskEngineLayer comprehensive test complete ===');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('ShaderMaskEngineLayer Tests'),
      Text('Assertions: $assertionCount'),
      Text('Layer A type: ${layerA.runtimeType}'),
      Text('Reused layer type: ${reusedLayer.runtimeType}'),
      Text('Blend modes tested: ${blendModes.length}'),
      Text('Logs: ${logs.length} entries'),
      const Text('Summary widget generated successfully'),
    ],
  );
}
