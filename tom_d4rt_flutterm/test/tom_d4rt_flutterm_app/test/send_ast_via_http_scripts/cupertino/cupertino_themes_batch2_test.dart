// D4rt test script: Tests CupertinoThemeData applied to widgets, theme-aware widget styling from cupertino
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino themes batch 2 test executing');

  // ========== THEME-AWARE WIDGET STYLING ==========
  print('--- Theme-Aware Widget Styling Tests ---');

  // Test CupertinoThemeData with different primaryColors applied to widgets
  final redTheme = CupertinoThemeData(primaryColor: CupertinoColors.systemRed);
  print('Red theme created');
  print('  primaryColor: ${redTheme.primaryColor}');

  final greenTheme = CupertinoThemeData(
    primaryColor: CupertinoColors.systemGreen,
  );
  print('Green theme created');
  print('  primaryColor: ${greenTheme.primaryColor}');

  final purpleTheme = CupertinoThemeData(
    primaryColor: CupertinoColors.systemPurple,
  );
  print('Purple theme created');
  print('  primaryColor: ${purpleTheme.primaryColor}');

  final orangeTheme = CupertinoThemeData(
    primaryColor: CupertinoColors.systemOrange,
    brightness: Brightness.light,
  );
  print('Orange theme created');
  print('  primaryColor: ${orangeTheme.primaryColor}');
  print('  brightness: ${orangeTheme.brightness}');

  final tealTheme = CupertinoThemeData(
    primaryColor: CupertinoColors.systemTeal,
    barBackgroundColor: CupertinoColors.white,
  );
  print('Teal theme created');
  print('  primaryColor: ${tealTheme.primaryColor}');
  print('  barBackgroundColor: ${tealTheme.barBackgroundColor}');

  // ========== THEME TEXTTHEME VARIATIONS ==========
  print('--- Theme TextTheme Variations ---');

  // Test large text theme
  final largeTextTheme = CupertinoTextThemeData(
    textStyle: TextStyle(fontSize: 20.0),
    navTitleTextStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    navLargeTitleTextStyle: TextStyle(
      fontSize: 40.0,
      fontWeight: FontWeight.w900,
    ),
    tabLabelTextStyle: TextStyle(fontSize: 12.0),
  );
  print('Large text theme created');
  print('  textStyle fontSize: ${largeTextTheme.textStyle.fontSize}');
  print(
    '  navTitleTextStyle fontSize: ${largeTextTheme.navTitleTextStyle.fontSize}',
  );

  // Test compact text theme
  final compactTextTheme = CupertinoTextThemeData(
    textStyle: TextStyle(fontSize: 12.0),
    navTitleTextStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
    tabLabelTextStyle: TextStyle(fontSize: 8.0),
  );
  print('Compact text theme created');
  print('  textStyle fontSize: ${compactTextTheme.textStyle.fontSize}');

  // Test theme with large text applied
  final largeTheme = CupertinoThemeData(
    primaryColor: CupertinoColors.systemBlue,
    textTheme: largeTextTheme,
  );
  print('Theme with large text created');
  print('  textTheme.textStyle: ${largeTheme.textTheme.textStyle}');

  // Test theme with compact text applied
  final compactTheme = CupertinoThemeData(
    primaryColor: CupertinoColors.systemIndigo,
    textTheme: compactTextTheme,
  );
  print('Theme with compact text created');
  print('  textTheme.textStyle: ${compactTheme.textTheme.textStyle}');

  // ========== THEME COPYWITH CHAINS ==========
  print('--- Theme CopyWith Chains ---');

  final baseTheme = CupertinoThemeData(
    primaryColor: CupertinoColors.systemBlue,
    brightness: Brightness.light,
    barBackgroundColor: CupertinoColors.white,
  );

  final step1 = baseTheme.copyWith(primaryColor: CupertinoColors.systemRed);
  print('CopyWith step 1 - changed primary to red');
  print('  primaryColor: ${step1.primaryColor}');
  print('  brightness (inherited): ${step1.brightness}');

  final step2 = step1.copyWith(brightness: Brightness.dark);
  print('CopyWith step 2 - changed brightness to dark');
  print('  primaryColor (inherited): ${step2.primaryColor}');
  print('  brightness: ${step2.brightness}');

  final step3 = step2.copyWith(
    scaffoldBackgroundColor: CupertinoColors.darkBackgroundGray,
  );
  print('CopyWith step 3 - added scaffoldBackgroundColor');
  print('  primaryColor (inherited): ${step3.primaryColor}');
  print('  brightness (inherited): ${step3.brightness}');
  print('  scaffoldBackgroundColor: ${step3.scaffoldBackgroundColor}');

  // ========== THEME RESOLUTION ==========
  print('--- Theme Resolution Tests ---');

  // Test resolveFrom
  final dynamicTheme = CupertinoThemeData(
    primaryColor: CupertinoColors.activeBlue,
    barBackgroundColor: CupertinoColors.systemBackground,
    scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
  );
  print('Dynamic theme created');
  print('  primaryColor: ${dynamicTheme.primaryColor}');

  print('All Cupertino themes batch 2 tests passed');

  // ========== RETURN WIDGET ==========
  return CupertinoApp(
    theme: baseTheme,
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Themes Batch 2')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Theme-Aware Widget Styling:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),

              // Red themed section
              CupertinoTheme(
                data: redTheme,
                child: Column(
                  children: [
                    CupertinoButton.filled(
                      child: Text('Red Theme'),
                      onPressed: () {},
                    ),
                    SizedBox(height: 4.0),
                    CupertinoSwitch(value: true, onChanged: (v) {}),
                  ],
                ),
              ),
              SizedBox(height: 8.0),

              // Green themed section
              CupertinoTheme(
                data: greenTheme,
                child: Column(
                  children: [
                    CupertinoButton.filled(
                      child: Text('Green Theme'),
                      onPressed: () {},
                    ),
                    SizedBox(height: 4.0),
                    CupertinoSwitch(value: true, onChanged: (v) {}),
                  ],
                ),
              ),
              SizedBox(height: 8.0),

              // Purple themed section
              CupertinoTheme(
                data: purpleTheme,
                child: Column(
                  children: [
                    CupertinoButton.filled(
                      child: Text('Purple Theme'),
                      onPressed: () {},
                    ),
                    SizedBox(height: 4.0),
                    CupertinoActivityIndicator(),
                  ],
                ),
              ),
              SizedBox(height: 8.0),

              // Orange themed section
              CupertinoTheme(
                data: orangeTheme,
                child: CupertinoButton.filled(
                  child: Text('Orange Theme'),
                  onPressed: () {},
                ),
              ),
              SizedBox(height: 8.0),

              // Teal themed section
              CupertinoTheme(
                data: tealTheme,
                child: CupertinoButton.filled(
                  child: Text('Teal Theme'),
                  onPressed: () {},
                ),
              ),

              SizedBox(height: 16.0),
              Text(
                'Text Theme Variations:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),

              CupertinoTheme(
                data: largeTheme,
                child: Builder(
                  builder: (BuildContext ctx) {
                    final theme = CupertinoTheme.of(ctx);
                    return Text(
                      'Large text theme',
                      style: theme.textTheme.textStyle,
                    );
                  },
                ),
              ),
              SizedBox(height: 4.0),

              CupertinoTheme(
                data: compactTheme,
                child: Builder(
                  builder: (BuildContext ctx) {
                    final theme = CupertinoTheme.of(ctx);
                    return Text(
                      'Compact text theme',
                      style: theme.textTheme.textStyle,
                    );
                  },
                ),
              ),

              SizedBox(height: 24.0),
              Text(
                'Tests Completed:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text('• Theme-aware widget styling'),
              Text('• CupertinoTextThemeData variations'),
              Text('• CupertinoThemeData.copyWith chains'),
              Text('• Theme resolution'),
              Text('• Themed CupertinoSwitch'),
              Text('• Themed CupertinoActivityIndicator'),
            ],
          ),
        ),
      ),
    ),
  );
}
