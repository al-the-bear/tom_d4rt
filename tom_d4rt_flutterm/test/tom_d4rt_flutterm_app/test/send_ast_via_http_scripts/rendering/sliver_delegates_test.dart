// D4rt test script: Tests SliverGridDelegateWithFixedCrossAxisCount, SliverGridDelegateWithMaxCrossAxisExtent, ColumnWidth classes
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('Sliver delegates test executing');

  // ========== SLIVER GRID DELEGATE WITH FIXED CROSS AXIS COUNT ==========
  print('--- SliverGridDelegateWithFixedCrossAxisCount Tests ---');

  final fixedCount2 = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
  );
  print('FixedCrossAxisCount(2) created: ${fixedCount2.runtimeType}');
  print('  crossAxisCount: ${fixedCount2.crossAxisCount}');
  print('  mainAxisSpacing: ${fixedCount2.mainAxisSpacing}');
  print('  crossAxisSpacing: ${fixedCount2.crossAxisSpacing}');
  print('  childAspectRatio: ${fixedCount2.childAspectRatio}');

  final fixedCount3Custom = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    mainAxisSpacing: 8.0,
    crossAxisSpacing: 8.0,
    childAspectRatio: 1.5,
  );
  print('FixedCrossAxisCount(3, custom):');
  print('  crossAxisCount: ${fixedCount3Custom.crossAxisCount}');
  print('  mainAxisSpacing: ${fixedCount3Custom.mainAxisSpacing}');
  print('  crossAxisSpacing: ${fixedCount3Custom.crossAxisSpacing}');
  print('  childAspectRatio: ${fixedCount3Custom.childAspectRatio}');

  final fixedCount4WithExtent = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 4,
    mainAxisSpacing: 4.0,
    crossAxisSpacing: 4.0,
    mainAxisExtent: 100.0,
  );
  print('FixedCrossAxisCount(4, mainAxisExtent=100):');
  print('  crossAxisCount: ${fixedCount4WithExtent.crossAxisCount}');
  print('  mainAxisExtent: ${fixedCount4WithExtent.mainAxisExtent}');

  // ========== SLIVER GRID DELEGATE WITH MAX CROSS AXIS EXTENT ==========
  print('--- SliverGridDelegateWithMaxCrossAxisExtent Tests ---');

  final maxExtent100 = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 100.0,
  );
  print('MaxCrossAxisExtent(100) created: ${maxExtent100.runtimeType}');
  print('  maxCrossAxisExtent: ${maxExtent100.maxCrossAxisExtent}');
  print('  mainAxisSpacing: ${maxExtent100.mainAxisSpacing}');
  print('  crossAxisSpacing: ${maxExtent100.crossAxisSpacing}');
  print('  childAspectRatio: ${maxExtent100.childAspectRatio}');

  final maxExtentCustom = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 200.0,
    mainAxisSpacing: 10.0,
    crossAxisSpacing: 10.0,
    childAspectRatio: 0.75,
  );
  print('MaxCrossAxisExtent(200, custom):');
  print('  maxCrossAxisExtent: ${maxExtentCustom.maxCrossAxisExtent}');
  print('  mainAxisSpacing: ${maxExtentCustom.mainAxisSpacing}');
  print('  crossAxisSpacing: ${maxExtentCustom.crossAxisSpacing}');
  print('  childAspectRatio: ${maxExtentCustom.childAspectRatio}');

  final maxExtentWithMainAxis = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 150.0,
    mainAxisExtent: 80.0,
  );
  print('MaxCrossAxisExtent(150, mainAxisExtent=80):');
  print('  mainAxisExtent: ${maxExtentWithMainAxis.mainAxisExtent}');

  // ========== USING DELEGATES IN GRIDVIEW ==========
  print('--- GridView with delegates ---');

  final gridView1 = GridView(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    children: [Text('A'), Text('B'), Text('C'), Text('D')],
  );
  print('GridView with FixedCrossAxisCount created: ${gridView1.runtimeType}');

  final gridView2 = GridView(
    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 120.0,
    ),
    children: [Text('A'), Text('B'), Text('C')],
  );
  print('GridView with MaxCrossAxisExtent created: ${gridView2.runtimeType}');

  // ========== FIXED COLUMN WIDTH ==========
  print('--- FixedColumnWidth Tests ---');

  final fixedCol = FixedColumnWidth(100.0);
  print('FixedColumnWidth(100) created: ${fixedCol.runtimeType}');
  print('  value: ${fixedCol.value}');

  final fixedCol200 = FixedColumnWidth(200.0);
  print('FixedColumnWidth(200) value: ${fixedCol200.value}');

  // ========== FLEX COLUMN WIDTH ==========
  print('--- FlexColumnWidth Tests ---');

  final flexCol = FlexColumnWidth();
  print('FlexColumnWidth() created: ${flexCol.runtimeType}');
  print('  value: ${flexCol.value}');

  final flexCol2 = FlexColumnWidth(2.0);
  print('FlexColumnWidth(2.0) value: ${flexCol2.value}');

  final flexCol3 = FlexColumnWidth(3.0);
  print('FlexColumnWidth(3.0) value: ${flexCol3.value}');

  // ========== INTRINSIC COLUMN WIDTH ==========
  print('--- IntrinsicColumnWidth Tests ---');

  final intrinsicCol = IntrinsicColumnWidth();
  print('IntrinsicColumnWidth() created: ${intrinsicCol.runtimeType}');

  final intrinsicColFlex = IntrinsicColumnWidth(flex: 1.0);
  print('IntrinsicColumnWidth(flex=1) created');

  // ========== TABLE WITH COLUMN WIDTHS ==========
  print('--- Table with column widths ---');

  final table = Table(
    columnWidths: {
      0: FixedColumnWidth(80.0),
      1: FlexColumnWidth(2.0),
      2: IntrinsicColumnWidth(),
    },
    defaultColumnWidth: FlexColumnWidth(),
    children: [
      TableRow(children: [Text('Col1'), Text('Col2'), Text('Col3')]),
      TableRow(children: [Text('A'), Text('B'), Text('C')]),
    ],
  );
  print('Table with mixed column widths created: ${table.runtimeType}');

  // ========== MAX COLUMN WIDTH / MIN COLUMN WIDTH ==========
  print('--- MaxColumnWidth / MinColumnWidth ---');

  final maxCol = MaxColumnWidth(FixedColumnWidth(100.0), FlexColumnWidth(1.0));
  print('MaxColumnWidth created: ${maxCol.runtimeType}');

  final minCol = MinColumnWidth(FixedColumnWidth(200.0), FlexColumnWidth(1.0));
  print('MinColumnWidth created: ${minCol.runtimeType}');

  // ========== FRACTION COLUMN WIDTH ==========
  print('--- FractionColumnWidth Tests ---');

  final fractionCol = FractionColumnWidth(0.5);
  print('FractionColumnWidth(0.5) created: ${fractionCol.runtimeType}');
  print('  value: ${fractionCol.value}');

  final fractionCol25 = FractionColumnWidth(0.25);
  print('FractionColumnWidth(0.25) value: ${fractionCol25.value}');

  print('Sliver delegates test completed');
  return Container(child: Text('Sliver delegates test passed'));
}
