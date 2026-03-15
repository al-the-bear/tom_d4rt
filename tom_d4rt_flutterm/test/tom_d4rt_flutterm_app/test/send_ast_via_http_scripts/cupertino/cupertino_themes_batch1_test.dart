// D4rt test script: Tests CupertinoThemeData properties, CupertinoTextThemeData, CupertinoTheme.of from cupertino
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino themes batch 1 test executing');

  // ========== CUPERTINOTHEMEDATA DEEP DIVE ==========
  print('--- CupertinoThemeData Properties Tests ---');

  // Test CupertinoThemeData with primaryColor
  final primaryTheme = CupertinoThemeData(
    primaryColor: CupertinoColors.systemRed,
  );
  print('CupertinoThemeData with primaryColor created');
  print('  primaryColor: ${primaryTheme.primaryColor}');

  // Test CupertinoThemeData with primaryContrastingColor
  final contrastTheme = CupertinoThemeData(
    primaryColor: CupertinoColors.systemBlue,
    primaryContrastingColor: CupertinoColors.white,
  );
  print('CupertinoThemeData with primaryContrastingColor created');
  print('  primaryColor: ${contrastTheme.primaryColor}');
  print('  primaryContrastingColor: ${contrastTheme.primaryContrastingColor}');

  // Test CupertinoThemeData with barBackgroundColor
  final barBgTheme = CupertinoThemeData(
    barBackgroundColor: CupertinoColors.systemGroupedBackground,
  );
  print('CupertinoThemeData with barBackgroundColor created');
  print('  barBackgroundColor: ${barBgTheme.barBackgroundColor}');

  // Test CupertinoThemeData with scaffoldBackgroundColor
  final scaffoldBgTheme = CupertinoThemeData(
    scaffoldBackgroundColor: CupertinoColors.systemBackground,
  );
  print('CupertinoThemeData with scaffoldBackgroundColor created');
  print(
    '  scaffoldBackgroundColor: ${scaffoldBgTheme.scaffoldBackgroundColor}',
  );

  // Test CupertinoThemeData with brightness
  final lightTheme = CupertinoThemeData(brightness: Brightness.light);
  print('CupertinoThemeData with brightness=light created');
  print('  brightness: ${lightTheme.brightness}');

  final darkTheme = CupertinoThemeData(brightness: Brightness.dark);
  print('CupertinoThemeData with brightness=dark created');
  print('  brightness: ${darkTheme.brightness}');

  // Test CupertinoThemeData with applyThemeToAll
  final applyAllTheme = CupertinoThemeData(
    primaryColor: CupertinoColors.systemPurple,
    applyThemeToAll: true,
  );
  print('CupertinoThemeData with applyThemeToAll created');
  print('  applyThemeToAll: ${applyAllTheme.applyThemeToAll}');

  // Test CupertinoThemeData with all properties
  final fullTheme = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: CupertinoColors.systemIndigo,
    primaryContrastingColor: CupertinoColors.white,
    barBackgroundColor: CupertinoColors.extraLightBackgroundGray,
    scaffoldBackgroundColor: CupertinoColors.systemBackground,
    applyThemeToAll: false,
  );
  print('Full CupertinoThemeData created');
  print('  brightness: ${fullTheme.brightness}');
  print('  primaryColor: ${fullTheme.primaryColor}');
  print('  primaryContrastingColor: ${fullTheme.primaryContrastingColor}');
  print('  barBackgroundColor: ${fullTheme.barBackgroundColor}');
  print('  scaffoldBackgroundColor: ${fullTheme.scaffoldBackgroundColor}');

  // ========== CUPERTINOTEXTTHEMEDATA ==========
  print('--- CupertinoTextThemeData Tests ---');

  // Test basic CupertinoTextThemeData
  final basicTextTheme = CupertinoTextThemeData();
  print('Basic CupertinoTextThemeData created');

  // Test CupertinoTextThemeData with primaryColor
  final coloredTextTheme = CupertinoTextThemeData(
    primaryColor: CupertinoColors.systemBlue,
  );
  print('CupertinoTextThemeData with primaryColor created');

  // Test CupertinoTextThemeData with custom text styles
  final customTextTheme = CupertinoTextThemeData(
    textStyle: TextStyle(fontSize: 16.0, color: CupertinoColors.label),
    actionTextStyle: TextStyle(
      fontSize: 16.0,
      color: CupertinoColors.activeBlue,
    ),
    tabLabelTextStyle: TextStyle(
      fontSize: 10.0,
      color: CupertinoColors.inactiveGray,
    ),
    navTitleTextStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: CupertinoColors.label,
    ),
    navLargeTitleTextStyle: TextStyle(
      fontSize: 34.0,
      fontWeight: FontWeight.bold,
      color: CupertinoColors.label,
    ),
    navActionTextStyle: TextStyle(
      fontSize: 16.0,
      color: CupertinoColors.activeBlue,
    ),
    pickerTextStyle: TextStyle(fontSize: 22.0, color: CupertinoColors.label),
    dateTimePickerTextStyle: TextStyle(
      fontSize: 20.0,
      color: CupertinoColors.label,
    ),
  );
  print('CupertinoTextThemeData with custom styles created');
  print('  textStyle: ${customTextTheme.textStyle}');
  print('  actionTextStyle: ${customTextTheme.actionTextStyle}');
  print('  tabLabelTextStyle: ${customTextTheme.tabLabelTextStyle}');
  print('  navTitleTextStyle: ${customTextTheme.navTitleTextStyle}');
  print('  navLargeTitleTextStyle: ${customTextTheme.navLargeTitleTextStyle}');
  print('  navActionTextStyle: ${customTextTheme.navActionTextStyle}');
  print('  pickerTextStyle: ${customTextTheme.pickerTextStyle}');
  print(
    '  dateTimePickerTextStyle: ${customTextTheme.dateTimePickerTextStyle}',
  );

  // Test CupertinoThemeData with textTheme
  final themedWithText = CupertinoThemeData(
    primaryColor: CupertinoColors.systemGreen,
    textTheme: customTextTheme,
  );
  print('CupertinoThemeData with textTheme created');
  print('  textTheme.textStyle: ${themedWithText.textTheme.textStyle}');

  // ========== CUPERTINOTHEME.OF ==========
  print('--- CupertinoTheme.of Tests ---');

  // CupertinoTheme.of(context) will be tested in the widget tree
  print('CupertinoTheme.of will be tested in widget tree');

  // ========== CUPERTINOTHEMEDATA.COPYWITH ==========
  print('--- CupertinoThemeData.copyWith Tests ---');

  final baseTheme = CupertinoThemeData(
    primaryColor: CupertinoColors.systemBlue,
    brightness: Brightness.light,
  );

  final copiedTheme = baseTheme.copyWith(
    primaryColor: CupertinoColors.systemRed,
  );
  print('CupertinoThemeData.copyWith created');
  print('  original primaryColor: ${baseTheme.primaryColor}');
  print('  copied primaryColor: ${copiedTheme.primaryColor}');
  print('  copied brightness (inherited): ${copiedTheme.brightness}');

  final copiedTheme2 = baseTheme.copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: CupertinoColors.black,
  );
  print('CupertinoThemeData.copyWith with brightness change');
  print('  brightness: ${copiedTheme2.brightness}');
  print('  scaffoldBackgroundColor: ${copiedTheme2.scaffoldBackgroundColor}');

  print('All Cupertino themes batch 1 tests passed');

  // ========== RETURN WIDGET ==========
  return CupertinoApp(
    theme: fullTheme,
    home: Builder(
      builder: (BuildContext innerContext) {
        // Test CupertinoTheme.of inside widget tree
        final resolvedTheme = CupertinoTheme.of(innerContext);
        print('CupertinoTheme.of resolved');
        print('  resolved primaryColor: ${resolvedTheme.primaryColor}');
        print('  resolved brightness: ${resolvedTheme.brightness}');

        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(middle: Text('Themes Batch 1')),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CupertinoThemeData Properties:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text('Primary: ${resolvedTheme.primaryColor}'),
                  Text('Brightness: ${resolvedTheme.brightness}'),
                  Text('Bar bg: ${resolvedTheme.barBackgroundColor}'),
                  Text('Scaffold bg: ${resolvedTheme.scaffoldBackgroundColor}'),
                  SizedBox(height: 16.0),
                  Text(
                    'CupertinoTextThemeData:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text('Text style: ${resolvedTheme.textTheme.textStyle}'),
                  Text(
                    'Nav title: ${resolvedTheme.textTheme.navTitleTextStyle}',
                  ),
                  SizedBox(height: 16.0),
                  CupertinoTheme(
                    data: CupertinoThemeData(
                      primaryColor: CupertinoColors.systemRed,
                    ),
                    child: Builder(
                      builder: (BuildContext nestedContext) {
                        final nested = CupertinoTheme.of(nestedContext);
                        return Text(
                          'Nested theme primary: ${nested.primaryColor}',
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16.0),
                  CupertinoTheme(
                    data: CupertinoThemeData(
                      primaryColor: CupertinoColors.systemGreen,
                      textTheme: CupertinoTextThemeData(
                        primaryColor: CupertinoColors.systemGreen,
                      ),
                    ),
                    child: CupertinoButton.filled(
                      child: Text('Green Theme Button'),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 16.0),
                  CupertinoTheme(
                    data: CupertinoThemeData(
                      primaryColor: CupertinoColors.systemPurple,
                    ),
                    child: CupertinoButton.filled(
                      child: Text('Purple Theme Button'),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Tests Completed:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text('• CupertinoThemeData properties'),
                  Text('• CupertinoThemeData.copyWith'),
                  Text('• CupertinoTextThemeData'),
                  Text('• CupertinoTheme.of'),
                  Text('• Nested CupertinoTheme'),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
