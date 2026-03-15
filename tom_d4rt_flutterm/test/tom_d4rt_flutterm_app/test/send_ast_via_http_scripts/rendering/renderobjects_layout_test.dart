// D4rt test script: Tests RenderFlex, RenderWrap, RenderTable, RenderFlow, RenderListBody
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('RenderObjects layout test executing');

  // ========== RENDER FLEX ==========
  print('--- RenderFlex Tests ---');

  final flexH = RenderFlex(direction: Axis.horizontal);
  print('RenderFlex(horizontal) created: ${flexH.runtimeType}');
  print('  direction: ${flexH.direction}');
  print('  mainAxisAlignment: ${flexH.mainAxisAlignment}');
  print('  crossAxisAlignment: ${flexH.crossAxisAlignment}');
  print('  mainAxisSize: ${flexH.mainAxisSize}');

  final flexV = RenderFlex(direction: Axis.vertical);
  print('RenderFlex(vertical) direction: ${flexV.direction}');

  final flexFull = RenderFlex(
    direction: Axis.horizontal,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    textDirection: TextDirection.ltr,
    verticalDirection: VerticalDirection.down,
  );
  print('RenderFlex(full params):');
  print('  mainAxisAlignment: ${flexFull.mainAxisAlignment}');
  print('  crossAxisAlignment: ${flexFull.crossAxisAlignment}');
  print('  mainAxisSize: ${flexFull.mainAxisSize}');
  print('  textDirection: ${flexFull.textDirection}');
  print('  verticalDirection: ${flexFull.verticalDirection}');

  // Modify properties
  flexH.direction = Axis.vertical;
  print('After direction change: ${flexH.direction}');
  flexH.mainAxisAlignment = MainAxisAlignment.end;
  print('After mainAxisAlignment change: ${flexH.mainAxisAlignment}');

  // ========== RENDER WRAP ==========
  print('--- RenderWrap Tests ---');

  final wrap = RenderWrap();
  print('RenderWrap() created: ${wrap.runtimeType}');
  print('  direction: ${wrap.direction}');
  print('  alignment: ${wrap.alignment}');
  print('  spacing: ${wrap.spacing}');
  print('  runAlignment: ${wrap.runAlignment}');
  print('  runSpacing: ${wrap.runSpacing}');
  print('  crossAxisAlignment: ${wrap.crossAxisAlignment}');

  final wrapCustom = RenderWrap(
    direction: Axis.vertical,
    alignment: WrapAlignment.center,
    spacing: 8.0,
    runAlignment: WrapAlignment.spaceBetween,
    runSpacing: 4.0,
    crossAxisAlignment: WrapCrossAlignment.center,
    textDirection: TextDirection.ltr,
    verticalDirection: VerticalDirection.down,
  );
  print('RenderWrap(custom):');
  print('  direction: ${wrapCustom.direction}');
  print('  alignment: ${wrapCustom.alignment}');
  print('  spacing: ${wrapCustom.spacing}');
  print('  runAlignment: ${wrapCustom.runAlignment}');
  print('  runSpacing: ${wrapCustom.runSpacing}');
  print('  crossAxisAlignment: ${wrapCustom.crossAxisAlignment}');

  // Modify properties
  wrap.spacing = 12.0;
  print('After spacing change: ${wrap.spacing}');
  wrap.runSpacing = 6.0;
  print('After runSpacing change: ${wrap.runSpacing}');

  // ========== RENDER TABLE ==========
  print('--- RenderTable Tests ---');

  final table = RenderTable(columns: 3, textDirection: TextDirection.ltr);
  print('RenderTable(3 columns) created: ${table.runtimeType}');
  print('  columns: ${table.columns}');
  print('  rows: ${table.rows}');
  print('  textDirection: ${table.textDirection}');

  final tableWithDefaults = RenderTable(
    columns: 2,
    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    textDirection: TextDirection.ltr,
  );
  print('RenderTable(2 cols, middle align):');
  print('  columns: ${tableWithDefaults.columns}');
  print(
    '  defaultVerticalAlignment: ${tableWithDefaults.defaultVerticalAlignment}',
  );

  // Modify columns
  table.columns = 4;
  print('After columns change to 4: ${table.columns}');

  // ========== RENDER FLOW ==========
  print('--- RenderFlow Tests ---');

  // Note: RenderFlow requires a FlowDelegate, which is abstract.
  // We cannot instantiate RenderFlow without providing a concrete delegate.
  // This is a known limitation for bridge testing.
  print('RenderFlow requires a FlowDelegate (abstract class)');
  print('Cannot construct RenderFlow without a concrete FlowDelegate subclass');
  print(
    'Limitation: FlowDelegate has abstract methods that must be overridden',
  );

  // ========== RENDER LIST BODY ==========
  print('--- RenderListBody Tests ---');

  final listBody = RenderListBody(axisDirection: AxisDirection.down);
  print('RenderListBody(down) created: ${listBody.runtimeType}');
  print('  axisDirection: ${listBody.axisDirection}');
  print('  mainAxis: ${listBody.mainAxis}');

  final listBodyRight = RenderListBody(axisDirection: AxisDirection.right);
  print('RenderListBody(right) axisDirection: ${listBodyRight.axisDirection}');
  print('  mainAxis: ${listBodyRight.mainAxis}');

  // ========== AXIS DIRECTION HELPERS ==========
  print('--- AxisDirection helpers ---');
  print('AxisDirection.up: ${AxisDirection.up}');
  print('AxisDirection.down: ${AxisDirection.down}');
  print('AxisDirection.left: ${AxisDirection.left}');
  print('AxisDirection.right: ${AxisDirection.right}');
  print(
    'axisDirectionToAxis(down): ${axisDirectionToAxis(AxisDirection.down)}',
  );
  print(
    'axisDirectionToAxis(right): ${axisDirectionToAxis(AxisDirection.right)}',
  );

  // Note: Cannot call layout() or paint() on orphan render objects
  print('Note: render objects not laid out - no parent render tree attached');

  print('RenderObjects layout test completed');
  return Container(child: Text('RenderObjects layout test passed'));
}
