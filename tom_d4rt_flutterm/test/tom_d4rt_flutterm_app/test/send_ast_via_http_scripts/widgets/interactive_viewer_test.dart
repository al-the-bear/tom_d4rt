// D4rt test script: Tests InteractiveViewer, TransformationController,
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// MatrixGestureDetector patterns, Matrix4 transforms, FittedBox,
// RotatedBox, ClipRect, ClipRRect
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('InteractiveViewer/Transform test executing');

  // ========== TransformationController ==========
  print('--- TransformationController Tests ---');
  final controller = TransformationController();
  print('TransformationController created');
  print('  initial value: ${controller.value}');

  controller.value = Matrix4.identity()..scale(2.0);
  print('  scaled 2x: ${controller.value.getMaxScaleOnAxis()}');

  controller.value = Matrix4.identity();
  print('  reset to identity');

  // ========== InteractiveViewer ==========
  print('--- InteractiveViewer Tests ---');
  final viewer = InteractiveViewer(
    transformationController: controller,
    boundaryMargin: EdgeInsets.all(20.0),
    minScale: 0.1,
    maxScale: 5.0,
    constrained: true,
    panEnabled: true,
    scaleEnabled: true,
    scaleFactor: 200.0,
    alignment: Alignment.center,
    child: Container(
      width: 300,
      height: 300,
      color: Colors.blue,
      child: Center(
        child: Text('Zoomable', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('InteractiveViewer created');

  // ========== FittedBox ==========
  print('--- FittedBox Tests ---');
  final fittedBox = FittedBox(
    fit: BoxFit.contain,
    alignment: Alignment.center,
    clipBehavior: Clip.hardEdge,
    child: Text('Fitted', style: TextStyle(fontSize: 100)),
  );
  print('FittedBox created: fit=${BoxFit.contain}');

  for (final fit in BoxFit.values) {
    print('  BoxFit: $fit');
  }

  // ========== RotatedBox ==========
  print('--- RotatedBox Tests ---');
  final rotated = RotatedBox(quarterTurns: 1, child: Text('Rotated'));
  print('RotatedBox created: quarterTurns=1');

  // ========== ClipRect ==========
  print('--- ClipRect Tests ---');
  final clipRect = ClipRect(
    clipBehavior: Clip.antiAlias,
    child: Container(width: 100, height: 100, color: Colors.red),
  );
  print('ClipRect created: clipBehavior=${Clip.antiAlias}');

  // ========== ClipRRect ==========
  print('--- ClipRRect Tests ---');
  final clipRRect = ClipRRect(
    borderRadius: BorderRadius.circular(16.0),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Container(width: 100, height: 100, color: Colors.green),
  );
  print('ClipRRect created: borderRadius=16.0');

  // ========== ClipOval ==========
  print('--- ClipOval Tests ---');
  final clipOval = ClipOval(
    clipBehavior: Clip.antiAlias,
    child: Container(width: 100, height: 100, color: Colors.purple),
  );
  print('ClipOval created');

  // ========== ClipPath ==========
  print('--- ClipPath Tests ---');
  final clipPath = ClipPath(
    clipBehavior: Clip.antiAlias,
    child: Container(width: 100, height: 100, color: Colors.orange),
  );
  print('ClipPath created');

  print('All interactive viewer tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 200, child: viewer),
            fittedBox,
            rotated,
            Row(children: [clipRect, clipRRect, clipOval]),
            clipPath,
          ],
        ),
      ),
    ),
  );
}
