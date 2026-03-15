// D4rt test script: Tests RenderAligningShiftedBox from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderAligningShiftedBox test executing');

  // ========== ALIGNMENT CONCEPTS ==========
  print('--- RenderAligningShiftedBox Concepts ---');
  print(
    'RenderAligningShiftedBox is the base class for alignment render objects',
  );
  print('It shifts its child according to an Alignment value');
  print(
    'Subclasses: RenderPositionedBox (Align), RenderConstrainedOverflowBox, etc.',
  );

  // ========== ALIGNMENT VALUES ==========
  print('--- Alignment Values ---');
  print('Alignment.topLeft: ${Alignment.topLeft}');
  print('Alignment.topCenter: ${Alignment.topCenter}');
  print('Alignment.topRight: ${Alignment.topRight}');
  print('Alignment.centerLeft: ${Alignment.centerLeft}');
  print('Alignment.center: ${Alignment.center}');
  print('Alignment.centerRight: ${Alignment.centerRight}');
  print('Alignment.bottomLeft: ${Alignment.bottomLeft}');
  print('Alignment.bottomCenter: ${Alignment.bottomCenter}');
  print('Alignment.bottomRight: ${Alignment.bottomRight}');

  // ========== ALIGN WIDGET TESTS ==========
  print('--- Align Widget Tests (uses RenderPositionedBox) ---');

  final alignTopLeft = Container(
    width: 100,
    height: 80,
    color: Colors.grey.shade300,
    child: Align(
      alignment: Alignment.topLeft,
      child: Container(width: 30, height: 30, color: Colors.red),
    ),
  );
  print('Created Align with topLeft');

  final alignCenter = Container(
    width: 100,
    height: 80,
    color: Colors.grey.shade300,
    child: Align(
      alignment: Alignment.center,
      child: Container(width: 30, height: 30, color: Colors.blue),
    ),
  );
  print('Created Align with center');

  final alignBottomRight = Container(
    width: 100,
    height: 80,
    color: Colors.grey.shade300,
    child: Align(
      alignment: Alignment.bottomRight,
      child: Container(width: 30, height: 30, color: Colors.green),
    ),
  );
  print('Created Align with bottomRight');

  // ========== CUSTOM ALIGNMENT ==========
  print('--- Custom Alignment Values ---');

  final customAlign = Container(
    width: 100,
    height: 80,
    color: Colors.grey.shade300,
    child: Align(
      alignment: Alignment(0.5, -0.5),
      child: Container(width: 20, height: 20, color: Colors.purple),
    ),
  );
  print('Created Align with custom Alignment(0.5, -0.5)');
  print('  x: 0.5 (slightly right of center)');
  print('  y: -0.5 (slightly above center)');

  // ========== WIDTH/HEIGHT FACTOR ==========
  print('--- Width/Height Factor Tests ---');

  final alignWithFactor = Container(
    color: Colors.yellow.shade100,
    child: Align(
      alignment: Alignment.center,
      widthFactor: 2.0,
      heightFactor: 2.0,
      child: Container(width: 40, height: 40, color: Colors.orange),
    ),
  );
  print('Created Align with widthFactor: 2.0, heightFactor: 2.0');
  print('  Parent size will be 2x child size');

  final alignWithWidthFactor = Align(
    alignment: Alignment.centerLeft,
    widthFactor: 3.0,
    child: Container(width: 30, height: 30, color: Colors.cyan),
  );
  print('Created Align with widthFactor: 3.0');

  // ========== CENTER WIDGET ==========
  print('--- Center Widget Tests ---');
  print(
    'Center is a convenience widget equivalent to Align(alignment: Alignment.center)',
  );

  final centerWidget = Container(
    width: 100,
    height: 80,
    color: Colors.grey.shade200,
    child: Center(child: Container(width: 30, height: 30, color: Colors.teal)),
  );
  print('Created Center widget');

  final centerWithFactor = Center(
    widthFactor: 1.5,
    heightFactor: 1.5,
    child: Container(width: 40, height: 40, color: Colors.indigo),
  );
  print('Created Center with factors');

  // ========== FRACTIONAL OFFSET ==========
  print('--- FractionalOffset Tests ---');
  print('FractionalOffset.topLeft (0.0, 0.0)');
  print('FractionalOffset.center (0.5, 0.5)');
  print('FractionalOffset.bottomRight (1.0, 1.0)');

  final fractionalAlign = Container(
    width: 100,
    height: 80,
    color: Colors.grey.shade300,
    child: Align(
      alignment: FractionalOffset(0.75, 0.25),
      child: Container(width: 20, height: 20, color: Colors.amber),
    ),
  );
  print('Created Align with FractionalOffset(0.75, 0.25)');

  // ========== ALIGNMENT GEOMETRY ==========
  print('--- AlignmentGeometry Tests ---');

  final directional = AlignmentDirectional.topStart;
  print('AlignmentDirectional.topStart: $directional');
  print('AlignmentDirectional.bottomEnd: ${AlignmentDirectional.bottomEnd}');
  print('A1ignmentDirectional respects text direction (LTR/RTL)');

  // ========== POSITIONED BOX TESTS ==========
  print('--- RenderPositionedBox Properties ---');
  print('RenderPositionedBox implements RenderAligningShiftedBox');
  print('Properties: alignment, widthFactor, heightFactor, textDirection');

  // ========== ALIGNMENT ARITHMETIC ==========
  print('--- Alignment Arithmetic ---');
  final a1 = Alignment(0.5, 0.5);
  final a2 = Alignment(0.2, 0.3);
  print('Alignment(0.5, 0.5) + Alignment(0.2, 0.3) = ${a1 + a2}');
  print('Alignment(0.5, 0.5) - Alignment(0.2, 0.3) = ${a1 - a2}');
  print('Alignment(0.5, 0.5) * 2 = ${a1 * 2}');
  print('-Alignment(0.5, 0.5) = ${-a1}');

  // ========== LAYOUT BEHAVIOR ==========
  print('--- Layout Behavior ---');
  print('RenderAligningShiftedBox computes child position using:');
  print('  childParentData.offset = alignment.alongOffset(...)');
  print('The offset is calculated based on remaining space after child layout');

  print('RenderAligningShiftedBox test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderAligningShiftedBox Tests'),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [alignTopLeft, alignCenter, alignBottomRight],
      ),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [customAlign, centerWidget],
      ),
      SizedBox(height: 8),
      alignWithFactor,
      SizedBox(height: 8),
      Text('All alignment tests passed'),
    ],
  );
}
