// D4rt test script: Tests Cupertino class overview from cupertino
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino class overview test executing');

  // ========== CupertinoApp ==========
  print('--- CupertinoApp ---');
  final app = CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Test')),
      child: Center(child: Text('Hello')),
    ),
  );
  print('  CupertinoApp created');
  print('  type: ${app.runtimeType}');

  // ========== CupertinoThemeData ==========
  print('--- CupertinoThemeData ---');
  final theme = CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: CupertinoColors.activeBlue,
    scaffoldBackgroundColor: CupertinoColors.black,
    barBackgroundColor: CupertinoColors.darkBackgroundGray,
  );
  print('  brightness: ${theme.brightness}');
  print('  primaryColor: ${theme.primaryColor}');
  print('  scaffoldBackgroundColor: ${theme.scaffoldBackgroundColor}');

  // ========== CupertinoTextThemeData ==========
  print('--- CupertinoTextThemeData ---');
  final textTheme = CupertinoTextThemeData(
    primaryColor: CupertinoColors.activeBlue,
  );
  print('  textStyle: ${textTheme.textStyle}');
  print('  navTitleTextStyle: ${textTheme.navTitleTextStyle}');
  print('  navLargeTitleTextStyle: ${textTheme.navLargeTitleTextStyle}');

  // ========== CupertinoColors ==========
  print('--- CupertinoColors ---');
  final colors = <(String, Color)>[
    ('activeBlue', CupertinoColors.activeBlue),
    ('activeGreen', CupertinoColors.activeGreen),
    ('activeOrange', CupertinoColors.activeOrange),
    ('white', CupertinoColors.white),
    ('black', CupertinoColors.black),
    ('lightBackgroundGray', CupertinoColors.lightBackgroundGray),
    ('darkBackgroundGray', CupertinoColors.darkBackgroundGray),
    ('systemRed', CupertinoColors.systemRed),
    ('systemGreen', CupertinoColors.systemGreen),
    ('systemBlue', CupertinoColors.systemBlue),
    ('systemYellow', CupertinoColors.systemYellow),
    ('systemPurple', CupertinoColors.systemPurple),
    ('systemPink', CupertinoColors.systemPink),
    ('systemGrey', CupertinoColors.systemGrey),
  ];
  for (final c in colors) {
    print('  ${c.$1}: ${c.$2}');
  }

  // ========== CupertinoIcons ==========
  print('--- CupertinoIcons ---');
  final icons = <(String, IconData)>[
    ('back', CupertinoIcons.back),
    ('forward', CupertinoIcons.forward),
    ('add', CupertinoIcons.add),
    ('search', CupertinoIcons.search),
    ('settings', CupertinoIcons.settings),
    ('heart', CupertinoIcons.heart),
    ('heartFill', CupertinoIcons.heart_fill),
    ('home', CupertinoIcons.home),
    ('trash', CupertinoIcons.trash),
    ('gear', CupertinoIcons.gear),
  ];
  for (final i in icons) {
    print('  ${i.$1}: codePoint=${i.$2.codePoint}');
  }

  print('Cupertino class overview test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Cupertino Class Overview'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CupertinoThemeData',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              Text('  brightness: ${theme.brightness}'),
              Text('  primaryColor: ${theme.primaryColor}'),
              SizedBox(height: 12.0),
              Text(
                'CupertinoColors',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              for (final c in colors)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                  child: Row(
                    children: [
                      Container(width: 24.0, height: 24.0, color: c.$2),
                      SizedBox(width: 8.0),
                      Text(c.$1),
                    ],
                  ),
                ),
              SizedBox(height: 12.0),
              Text(
                'CupertinoIcons',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              Wrap(
                spacing: 12.0,
                runSpacing: 8.0,
                children: [
                  for (final i in icons)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(i.$2, size: 28.0),
                        Text(i.$1, style: TextStyle(fontSize: 10.0)),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
