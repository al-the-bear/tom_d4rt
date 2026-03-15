// D4rt test script: Tests SelectionPoint from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectionPoint test executing');
  final results = <String>[];

  // ========== Section 1: Basic SelectionPoint Creation ==========
  print('--- Section 1: Basic SelectionPoint Creation ---');

  final point1 = SelectionPoint(
    localPosition: Offset(10.0, 20.0),
    lineHeight: 16.0,
    handleType: TextSelectionHandleType.left,
  );
  print('Created SelectionPoint: ${point1.runtimeType}');
  print('localPosition: ${point1.localPosition}');
  print('lineHeight: ${point1.lineHeight}');
  print('handleType: ${point1.handleType}');
  results.add('SelectionPoint created with left handle');

  // ========== Section 2: Different Handle Types ==========
  print('--- Section 2: Different Handle Types ---');

  final leftPoint = SelectionPoint(
    localPosition: Offset(0.0, 0.0),
    lineHeight: 14.0,
    handleType: TextSelectionHandleType.left,
  );
  print('Left handle point: ${leftPoint.handleType}');

  final rightPoint = SelectionPoint(
    localPosition: Offset(100.0, 0.0),
    lineHeight: 14.0,
    handleType: TextSelectionHandleType.right,
  );
  print('Right handle point: ${rightPoint.handleType}');

  final collapsedPoint = SelectionPoint(
    localPosition: Offset(50.0, 0.0),
    lineHeight: 14.0,
    handleType: TextSelectionHandleType.collapsed,
  );
  print('Collapsed handle point: ${collapsedPoint.handleType}');
  results.add('Handle types: left, right, collapsed');

  // ========== Section 3: TextSelectionHandleType Values ==========
  print('--- Section 3: TextSelectionHandleType Values ---');

  for (final handleType in TextSelectionHandleType.values) {
    print('  ${handleType.name}: index=${handleType.index}');
  }
  print('Total handle types: ${TextSelectionHandleType.values.length}');
  results.add(
    'TextSelectionHandleType values: ${TextSelectionHandleType.values.length}',
  );

  // ========== Section 4: Different Local Positions ==========
  print('--- Section 4: Different Local Positions ---');

  final positions = [
    Offset(0, 0),
    Offset(50, 25),
    Offset(100, 50),
    Offset(-10, -5),
    Offset(1000, 500),
  ];

  for (final pos in positions) {
    final testPoint = SelectionPoint(
      localPosition: pos,
      lineHeight: 16.0,
      handleType: TextSelectionHandleType.left,
    );
    print('Point at $pos: localPosition=${testPoint.localPosition}');
  }
  results.add('Tested ${positions.length} different positions');

  // ========== Section 5: Different Line Heights ==========
  print('--- Section 5: Different Line Heights ---');

  final lineHeights = [10.0, 14.0, 16.0, 20.0, 24.0, 32.0];

  for (final height in lineHeights) {
    final testPoint = SelectionPoint(
      localPosition: Offset(0, 0),
      lineHeight: height,
      handleType: TextSelectionHandleType.left,
    );
    print('Point with lineHeight $height: ${testPoint.lineHeight}');
  }
  results.add('Tested ${lineHeights.length} line heights');

  // ========== Section 6: Selection Points for Text Selection ==========
  print('--- Section 6: Selection Points for Text Selection ---');

  final startSelection = SelectionPoint(
    localPosition: Offset(10.0, 100.0),
    lineHeight: 18.0,
    handleType: TextSelectionHandleType.left,
  );

  final endSelection = SelectionPoint(
    localPosition: Offset(200.0, 100.0),
    lineHeight: 18.0,
    handleType: TextSelectionHandleType.right,
  );

  print('Start selection: ${startSelection.localPosition}');
  print('End selection: ${endSelection.localPosition}');
  final selectionWidth =
      endSelection.localPosition.dx - startSelection.localPosition.dx;
  print('Selection width: $selectionWidth');
  results.add('Selection span width: $selectionWidth');

  // ========== Section 7: Multiple Lines Selection ==========
  print('--- Section 7: Multiple Lines Selection ---');

  final linePoints = <SelectionPoint>[];
  for (var line = 0; line < 5; line++) {
    linePoints.add(
      SelectionPoint(
        localPosition: Offset(0.0, line * 20.0),
        lineHeight: 18.0,
        handleType: line == 0
            ? TextSelectionHandleType.left
            : TextSelectionHandleType.right,
      ),
    );
  }
  print('Created ${linePoints.length} line selection points');
  for (var i = 0; i < linePoints.length; i++) {
    print(
      '  Line $i: y=${linePoints[i].localPosition.dy}, handle=${linePoints[i].handleType}',
    );
  }
  results.add('Multi-line selection: ${linePoints.length} points');

  // ========== Section 8: Equality and Properties ==========
  print('--- Section 8: Equality and Properties ---');

  final pointA = SelectionPoint(
    localPosition: Offset(10, 20),
    lineHeight: 16.0,
    handleType: TextSelectionHandleType.left,
  );

  final pointB = SelectionPoint(
    localPosition: Offset(10, 20),
    lineHeight: 16.0,
    handleType: TextSelectionHandleType.left,
  );

  print('pointA == pointA: ${pointA == pointA}');
  print('pointA == pointB: ${pointA == pointB}');
  print('pointA.hashCode: ${pointA.hashCode}');
  print('pointB.hashCode: ${pointB.hashCode}');
  results.add('Equality test: ${pointA == pointB}');

  // ========== Section 9: ToString ==========
  print('--- Section 9: ToString ---');

  print('point1.toString(): ${point1.toString()}');
  results.add('ToString available');

  print('SelectionPoint test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SelectionPoint Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ...results.map(
            (r) => Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text('✓ $r', style: TextStyle(fontSize: 14)),
            ),
          ),
        ],
      ),
    ),
  );
}
