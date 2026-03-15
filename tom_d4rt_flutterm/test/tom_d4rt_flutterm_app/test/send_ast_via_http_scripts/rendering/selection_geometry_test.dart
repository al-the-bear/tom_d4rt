// D4rt test script: Tests SelectionGeometry from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectionGeometry test executing');

  // ========== Basic SelectionGeometry creation ==========
  print('--- Basic SelectionGeometry ---');
  final geometry1 = SelectionGeometry(
    status: SelectionStatus.uncollapsed,
    hasContent: true,
  );
  print('  created: ${geometry1.runtimeType}');
  print('  status: ${geometry1.status}');
  print('  hasContent: ${geometry1.hasContent}');

  // ========== With start and end selection points ==========
  print('--- With selection points ---');
  final startPoint = SelectionPoint(
    localPosition: Offset(10.0, 20.0),
    lineHeight: 16.0,
    handleType: TextSelectionHandleType.left,
  );
  final endPoint = SelectionPoint(
    localPosition: Offset(100.0, 20.0),
    lineHeight: 16.0,
    handleType: TextSelectionHandleType.right,
  );
  final geometryWithPoints = SelectionGeometry(
    status: SelectionStatus.uncollapsed,
    hasContent: true,
    startSelectionPoint: startPoint,
    endSelectionPoint: endPoint,
  );
  print('  startSelectionPoint: ${geometryWithPoints.startSelectionPoint}');
  print('  endSelectionPoint: ${geometryWithPoints.endSelectionPoint}');
  print(
    '  start localPosition: ${geometryWithPoints.startSelectionPoint?.localPosition}',
  );
  print(
    '  end localPosition: ${geometryWithPoints.endSelectionPoint?.localPosition}',
  );

  // ========== SelectionStatus enumeration ==========
  print('--- SelectionStatus values ---');
  for (final status in SelectionStatus.values) {
    print('  ${status.name}: ${status.index}');
  }
  print('  Total status values: ${SelectionStatus.values.length}');

  // ========== Different status values ==========
  print('--- Different status values ---');
  final noneGeometry = SelectionGeometry(
    status: SelectionStatus.none,
    hasContent: false,
  );
  final uncollapsedGeometry = SelectionGeometry(
    status: SelectionStatus.uncollapsed,
    hasContent: true,
  );
  final collapsedGeometry = SelectionGeometry(
    status: SelectionStatus.collapsed,
    hasContent: false,
  );
  print('  none status: ${noneGeometry.status}');
  print('  uncollapsed status: ${uncollapsedGeometry.status}');
  print('  collapsed status: ${collapsedGeometry.status}');

  // ========== hasContent variations ==========
  print('--- hasContent variations ---');
  final withContent = SelectionGeometry(
    status: SelectionStatus.uncollapsed,
    hasContent: true,
  );
  final withoutContent = SelectionGeometry(
    status: SelectionStatus.none,
    hasContent: false,
  );
  print('  withContent.hasContent: ${withContent.hasContent}');
  print('  withoutContent.hasContent: ${withoutContent.hasContent}');

  // ========== SelectionPoint details ==========
  print('--- SelectionPoint details ---');
  final point1 = SelectionPoint(
    localPosition: Offset(50.0, 100.0),
    lineHeight: 20.0,
    handleType: TextSelectionHandleType.collapsed,
  );
  print('  localPosition: ${point1.localPosition}');
  print('  lineHeight: ${point1.lineHeight}');
  print('  handleType: ${point1.handleType}');

  // ========== TextSelectionHandleType enumeration ==========
  print('--- TextSelectionHandleType values ---');
  for (final handleType in TextSelectionHandleType.values) {
    print('  ${handleType.name}: ${handleType.index}');
  }
  print('  Total handle types: ${TextSelectionHandleType.values.length}');

  // ========== Multiple geometries ==========
  print('--- Multiple geometries ---');
  final geometries = [
    SelectionGeometry(status: SelectionStatus.none, hasContent: false),
    SelectionGeometry(status: SelectionStatus.collapsed, hasContent: false),
    SelectionGeometry(status: SelectionStatus.uncollapsed, hasContent: true),
  ];
  print('  Created ${geometries.length} geometries');
  for (var i = 0; i < geometries.length; i++) {
    print(
      '  [$i] status: ${geometries[i].status}, hasContent: ${geometries[i].hasContent}',
    );
  }

  // ========== CopyWith ==========
  print('--- CopyWith ---');
  final original = SelectionGeometry(
    status: SelectionStatus.uncollapsed,
    hasContent: true,
    startSelectionPoint: startPoint,
    endSelectionPoint: endPoint,
  );
  final copied = original.copyWith(status: SelectionStatus.collapsed);
  print('  original.status: ${original.status}');
  print('  copied.status: ${copied.status}');
  print('  original.hasContent: ${original.hasContent}');
  print('  copied.hasContent: ${copied.hasContent}');

  // ========== Equality and HashCode ==========
  print('--- Equality and HashCode ---');
  final geoA = SelectionGeometry(
    status: SelectionStatus.none,
    hasContent: false,
  );
  final geoB = SelectionGeometry(
    status: SelectionStatus.none,
    hasContent: false,
  );
  print('  geoA == geoA: ${geoA == geoA}');
  print('  geoA == geoB: ${geoA == geoB}');
  print('  geoA.hashCode: ${geoA.hashCode}');
  print('  geoB.hashCode: ${geoB.hashCode}');

  // ========== ToString ==========
  print('--- ToString ---');
  print('  geometry1.toString(): ${geometry1.toString()}');

  print('SelectionGeometry test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SelectionGeometry Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Status: ${geometry1.status}'),
          Text('HasContent: ${geometry1.hasContent}'),
          Text('Status values: ${SelectionStatus.values.length}'),
          Text('Handle types: ${TextSelectionHandleType.values.length}'),
          Text('CopyWith works: ${original.status} -> ${copied.status}'),
          Text('Geometries created: ${geometries.length}'),
        ],
      ),
    ),
  );
}
