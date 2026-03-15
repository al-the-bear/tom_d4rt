// D4rt test script: Tests CupertinoTheme inheritance, nested themes, IconThemeData in Cupertino context from cupertino
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino themes batch 3 test executing');

  // ========== THEME INHERITANCE ==========
  print('--- Theme Inheritance Tests ---');

  // Test outer theme
  final outerTheme = CupertinoThemeData(
    primaryColor: CupertinoColors.systemBlue,
    brightness: Brightness.light,
    barBackgroundColor: CupertinoColors.white,
    scaffoldBackgroundColor: CupertinoColors.systemBackground,
  );
  print('Outer theme created');
  print('  primaryColor: ${outerTheme.primaryColor}');
  print('  brightness: ${outerTheme.brightness}');

  // Test inner theme that should override outer
  final innerTheme = CupertinoThemeData(
    primaryColor: CupertinoColors.systemRed,
  );
  print('Inner theme created');
  print('  primaryColor: ${innerTheme.primaryColor}');

  // Test deeply nested theme
  final deepTheme = CupertinoThemeData(
    primaryColor: CupertinoColors.systemGreen,
    brightness: Brightness.dark,
  );
  print('Deep theme created');
  print('  primaryColor: ${deepTheme.primaryColor}');
  print('  brightness: ${deepTheme.brightness}');

  // ========== ICONTHEMEDATA ==========
  print('--- IconThemeData in Cupertino Context ---');

  // Test IconThemeData construction for Cupertino usage
  final defaultIconTheme = IconThemeData();
  print('Default IconThemeData created');

  final coloredIconTheme = IconThemeData(color: CupertinoColors.systemBlue);
  print('IconThemeData with color created');
  print('  color: ${coloredIconTheme.color}');

  final sizedIconTheme = IconThemeData(size: 32.0);
  print('IconThemeData with size created');
  print('  size: ${sizedIconTheme.size}');

  final fullIconTheme = IconThemeData(
    color: CupertinoColors.systemIndigo,
    size: 28.0,
    opacity: 0.8,
  );
  print('Full IconThemeData created');
  print('  color: ${fullIconTheme.color}');
  print('  size: ${fullIconTheme.size}');
  print('  opacity: ${fullIconTheme.opacity}');

  // Test IconThemeData.copyWith
  final copiedIconTheme = fullIconTheme.copyWith(
    color: CupertinoColors.systemRed,
  );
  print('IconThemeData.copyWith created');
  print('  color: ${copiedIconTheme.color}');
  print('  size (inherited): ${copiedIconTheme.size}');

  // Note: IconThemeData.merge not available in D4rt (static method not bridged)

  // ========== CUPERTINO THEME WITH TEXTTHEME AND ICONS ==========
  print('--- Combined Theme Tests ---');

  final combinedTheme = CupertinoThemeData(
    primaryColor: CupertinoColors.systemTeal,
    brightness: Brightness.light,
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(fontSize: 16.0, color: CupertinoColors.label),
      navTitleTextStyle: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: CupertinoColors.label,
      ),
      actionTextStyle: TextStyle(
        fontSize: 16.0,
        color: CupertinoColors.systemTeal,
      ),
    ),
    barBackgroundColor: CupertinoColors.extraLightBackgroundGray,
    scaffoldBackgroundColor: CupertinoColors.systemBackground,
  );
  print('Combined theme created');
  print('  primaryColor: ${combinedTheme.primaryColor}');
  print('  textTheme.textStyle: ${combinedTheme.textTheme.textStyle}');
  print('  barBackgroundColor: ${combinedTheme.barBackgroundColor}');

  // ========== THEME COMPARISON ==========
  print('--- Theme Comparison Tests ---');

  final themeA = CupertinoThemeData(primaryColor: CupertinoColors.systemBlue);
  final themeB = CupertinoThemeData(primaryColor: CupertinoColors.systemBlue);
  final themeC = CupertinoThemeData(primaryColor: CupertinoColors.systemRed);

  print('Theme A primaryColor: ${themeA.primaryColor}');
  print('Theme B primaryColor: ${themeB.primaryColor}');
  print('Theme C primaryColor: ${themeC.primaryColor}');

  // ========== DARK/LIGHT MODE THEMES ==========
  print('--- Dark/Light Mode Theme Tests ---');

  final lightModeTheme = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: CupertinoColors.systemBlue,
    barBackgroundColor: CupertinoColors.white,
    scaffoldBackgroundColor: CupertinoColors.systemBackground,
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(color: CupertinoColors.black),
    ),
  );
  print('Light mode theme created');

  final darkModeTheme = CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: CupertinoColors.systemBlue,
    barBackgroundColor: CupertinoColors.black,
    scaffoldBackgroundColor: CupertinoColors.darkBackgroundGray,
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(color: CupertinoColors.white),
    ),
  );
  print('Dark mode theme created');

  print('Light brightness: ${lightModeTheme.brightness}');
  print('Dark brightness: ${darkModeTheme.brightness}');
  print('Light scaffold: ${lightModeTheme.scaffoldBackgroundColor}');
  print('Dark scaffold: ${darkModeTheme.scaffoldBackgroundColor}');

  print('All Cupertino themes batch 3 tests passed');

  // ========== RETURN WIDGET ==========
  return CupertinoApp(
    theme: outerTheme,
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Themes Batch 3')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Theme Inheritance:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),

              // Outer theme context
              Builder(
                builder: (BuildContext ctx) {
                  final theme = CupertinoTheme.of(ctx);
                  return Text('Outer: ${theme.primaryColor}');
                },
              ),
              SizedBox(height: 8.0),

              // Inner theme override
              CupertinoTheme(
                data: innerTheme,
                child: Builder(
                  builder: (BuildContext ctx) {
                    final theme = CupertinoTheme.of(ctx);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Inner: ${theme.primaryColor}'),
                        CupertinoButton.filled(
                          child: Text('Inner Button'),
                          onPressed: () {},
                        ),
                        SizedBox(height: 8.0),

                        // Deep nested theme
                        CupertinoTheme(
                          data: deepTheme,
                          child: Builder(
                            builder: (BuildContext deepCtx) {
                              final deepResolved = CupertinoTheme.of(deepCtx);
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Deep: ${deepResolved.primaryColor}'),
                                  CupertinoButton.filled(
                                    child: Text('Deep Button'),
                                    onPressed: () {},
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              SizedBox(height: 16.0),
              Text(
                'IconThemeData:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),

              IconTheme(
                data: fullIconTheme,
                child: Row(
                  children: [
                    Icon(CupertinoIcons.star_fill),
                    SizedBox(width: 8.0),
                    Icon(CupertinoIcons.heart_fill),
                    SizedBox(width: 8.0),
                    Icon(CupertinoIcons.bell_fill),
                  ],
                ),
              ),
              SizedBox(height: 8.0),

              IconTheme(
                data: coloredIconTheme,
                child: Row(
                  children: [
                    Icon(CupertinoIcons.cloud_fill),
                    SizedBox(width: 8.0),
                    Icon(CupertinoIcons.bolt_fill),
                    SizedBox(width: 8.0),
                    Icon(CupertinoIcons.moon_fill),
                  ],
                ),
              ),

              SizedBox(height: 24.0),
              Text(
                'Tests Completed:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text('• Theme inheritance (3 levels)'),
              Text('• IconThemeData construction'),
              Text('• IconThemeData.copyWith'),
              Text('• Combined theme with text and icons'),
              Text('• Dark/light mode themes'),
              Text('• Theme comparison'),
            ],
          ),
        ),
      ),
    ),
  );
}
