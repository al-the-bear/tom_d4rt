// D4rt test script: Tests InheritedCupertinoTheme from cupertino
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('InheritedCupertinoTheme test executing');

  // ===== 1. CupertinoTheme wraps InheritedCupertinoTheme internally =====
  print('--- CupertinoTheme (wraps InheritedCupertinoTheme) ---');
  final lightTheme = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: CupertinoColors.activeBlue,
    scaffoldBackgroundColor: CupertinoColors.white,
  );
  print('  light theme: brightness=${lightTheme.brightness}');
  print('  primaryColor: ${lightTheme.primaryColor}');

  // ===== 2. Dark theme =====
  print('--- Dark theme ---');
  final darkTheme = CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: CupertinoColors.activeOrange,
    scaffoldBackgroundColor: CupertinoColors.black,
  );
  print('  dark theme: brightness=${darkTheme.brightness}');

  // ===== 3. Access theme from context =====
  print('--- Theme.of(context) ---');
  final currentTheme = CupertinoTheme.of(context);
  print('  current brightness: ${currentTheme.brightness}');
  print('  current primaryColor: ${currentTheme.primaryColor}');
  print('  current barBackgroundColor: ${currentTheme.barBackgroundColor}');
  print(
    '  current scaffoldBackgroundColor: ${currentTheme.scaffoldBackgroundColor}',
  );

  // ===== 4. Text theme from inherited theme =====
  print('--- TextThemeData ---');
  final textTheme = currentTheme.textTheme;
  print('  textStyle: ${textTheme.textStyle}');
  print('  navTitleTextStyle: ${textTheme.navTitleTextStyle}');
  print('  navLargeTitleTextStyle: ${textTheme.navLargeTitleTextStyle}');
  print('  tabLabelTextStyle: ${textTheme.tabLabelTextStyle}');
  print('  actionTextStyle: ${textTheme.actionTextStyle}');

  // ===== 5. Custom text theme =====
  print('--- Custom CupertinoTextThemeData ---');
  final customTextTheme = CupertinoTextThemeData(
    primaryColor: CupertinoColors.systemGreen,
  );
  final customTheme = CupertinoThemeData(textTheme: customTextTheme);
  print('  custom text theme created with primaryColor override');

  // ===== 6. Nested themes (theme overrides) =====
  print('--- Nested themes ---');
  final outerContent = CupertinoTheme(
    data: lightTheme,
    child: Column(
      children: [
        Text('Light theme area'),
        CupertinoTheme(
          data: darkTheme,
          child: Container(
            color: CupertinoColors.darkBackgroundGray,
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Dark theme area',
              style: TextStyle(color: CupertinoColors.white),
            ),
          ),
        ),
      ],
    ),
  );
  print('  nested themes created');

  // ===== 7. Theme with all properties =====
  print('--- Full theme customization ---');
  final fullTheme = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF6366F1),
    primaryContrastingColor: CupertinoColors.white,
    scaffoldBackgroundColor: Color(0xFFF8FAFC),
    barBackgroundColor: Color(0xFFFFFFFF),
    textTheme: CupertinoTextThemeData(primaryColor: Color(0xFF6366F1)),
  );
  print('  full theme brightness: ${fullTheme.brightness}');
  print('  full theme primaryColor: ${fullTheme.primaryColor}');
  print('  full theme scaffold: ${fullTheme.scaffoldBackgroundColor}');
  print('  full theme bar: ${fullTheme.barBackgroundColor}');

  // ===== 8. resolveFrom for adaptive colors =====
  print('--- Adaptive colors ---');
  final adaptiveColor = CupertinoColors.systemBlue;
  print('  systemBlue: $adaptiveColor');
  print('  resolved: ${CupertinoDynamicColor.resolve(adaptiveColor, context)}');

  print('InheritedCupertinoTheme test completed');
  return CupertinoApp(
    theme: fullTheme,
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('InheritedTheme')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Theme Tests',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.0),
              Text('Current brightness: ${currentTheme.brightness}'),
              Text('Primary: ${currentTheme.primaryColor}'),
              SizedBox(height: 16.0),
              outerContent,
              SizedBox(height: 16.0),
              CupertinoButton.filled(
                child: Text('Themed Button'),
                onPressed: () {},
              ),
              SizedBox(height: 8.0),
              CupertinoTextField(placeholder: 'Themed TextField'),
            ],
          ),
        ),
      ),
    ),
  );
}
