// D4rt test script: Tests Divider, VerticalDivider, DividerThemeData,
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// ListTileTheme, ListTileThemeData, ListTileStyle
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Divider/ListTile theme test executing');

  // ========== Divider ==========
  print('--- Divider Tests ---');
  final divider = Divider(
    height: 16.0,
    thickness: 2.0,
    indent: 16.0,
    endIndent: 16.0,
    color: Colors.grey,
  );
  print('Divider created: height=16, thickness=2');

  // ========== VerticalDivider ==========
  print('--- VerticalDivider Tests ---');
  final vDivider = VerticalDivider(
    width: 16.0,
    thickness: 2.0,
    indent: 8.0,
    endIndent: 8.0,
    color: Colors.grey,
  );
  print('VerticalDivider created: width=16');

  // ========== DividerThemeData ==========
  print('--- DividerThemeData Tests ---');
  final dividerTheme = DividerThemeData(
    color: Colors.grey.shade300,
    space: 16.0,
    thickness: 1.0,
    indent: 0.0,
    endIndent: 0.0,
  );
  print('DividerThemeData created');
  print('  space: ${dividerTheme.space}');

  // ========== ListTileStyle ==========
  print('--- ListTileStyle Tests ---');
  for (final style in ListTileStyle.values) {
    print('ListTileStyle: ${style.name}');
  }

  // ========== ListTileThemeData ==========
  print('--- ListTileThemeData Tests ---');
  final listTileTheme = ListTileThemeData(
    dense: true,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    style: ListTileStyle.list,
    selectedColor: Colors.blue,
    iconColor: Colors.grey,
    textColor: Colors.black87,
    titleTextStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
    subtitleTextStyle: TextStyle(fontSize: 14.0, color: Colors.grey),
    leadingAndTrailingTextStyle: TextStyle(fontSize: 12.0),
    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
    tileColor: Colors.white,
    selectedTileColor: Colors.blue.shade50,
    horizontalTitleGap: 16.0,
    minVerticalPadding: 4.0,
    minLeadingWidth: 40.0,
    enableFeedback: true,
    visualDensity: VisualDensity.compact,
  );
  print('ListTileThemeData created');
  print('  dense: ${listTileTheme.dense}');
  print('  style: ${listTileTheme.style}');

  // ========== ListTileTheme ==========
  print('--- ListTileTheme Tests ---');
  final theme = ListTileTheme(
    data: listTileTheme,
    child: ListView(
      shrinkWrap: true,
      children: [
        ListTile(title: Text('Themed Tile 1')),
        ListTile(title: Text('Themed Tile 2')),
      ],
    ),
  );
  print('ListTileTheme wrapping tiles');

  // ========== ListTileControlAffinity ==========
  print('--- ListTileControlAffinity Tests ---');
  for (final aff in ListTileControlAffinity.values) {
    print('ListTileControlAffinity: ${aff.name}');
  }

  print('All divider/listtile tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Divider/ListTile Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ),
          ListTile(title: Text('Item 1'), subtitle: Text('Subtitle')),
          divider,
          ListTile(title: Text('Item 2'), trailing: Icon(Icons.arrow_forward)),
          divider,
          ListTile(title: Text('Item 3'), leading: Icon(Icons.star)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Left'), vDivider, Text('Right')],
          ),
        ],
      ),
    ),
  );
}
