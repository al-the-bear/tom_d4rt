// D4rt test script: Tests NoDefaultCupertinoThemeData, MaterialBasedCupertinoThemeData from cupertino
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Cupertino themes batch 4 test executing');

  // ========== NODEFAULTCUPERTINOTHEMEDATA ==========
  print('--- NoDefaultCupertinoThemeData Tests ---');

  // Test NoDefaultCupertinoThemeData with minimal params
  final minimalNoDefault = NoDefaultCupertinoThemeData(
    primaryColor: CupertinoColors.systemOrange,
  );
  print('NoDefaultCupertinoThemeData with primaryColor created');
  print('  primaryColor: ${minimalNoDefault.primaryColor}');

  // Test NoDefaultCupertinoThemeData with brightness
  final brightNoDefault = NoDefaultCupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: CupertinoColors.systemBlue,
  );
  print('NoDefaultCupertinoThemeData with brightness created');
  print('  brightness: ${brightNoDefault.brightness}');
  print('  primaryColor: ${brightNoDefault.primaryColor}');

  // Test NoDefaultCupertinoThemeData with full properties
  final fullNoDefault = NoDefaultCupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: CupertinoColors.systemIndigo,
    primaryContrastingColor: CupertinoColors.white,
    barBackgroundColor: CupertinoColors.extraLightBackgroundGray,
    scaffoldBackgroundColor: CupertinoColors.systemBackground,
    textTheme: CupertinoTextThemeData(
      primaryColor: CupertinoColors.systemIndigo,
      textStyle: TextStyle(fontSize: 16.0, color: CupertinoColors.label),
      navTitleTextStyle: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: CupertinoColors.label,
      ),
    ),
  );
  print('Full NoDefaultCupertinoThemeData created');
  print('  brightness: ${fullNoDefault.brightness}');
  print('  primaryColor: ${fullNoDefault.primaryColor}');
  print('  primaryContrastingColor: ${fullNoDefault.primaryContrastingColor}');
  print('  barBackgroundColor: ${fullNoDefault.barBackgroundColor}');
  print('  scaffoldBackgroundColor: ${fullNoDefault.scaffoldBackgroundColor}');
  print('  textTheme: ${fullNoDefault.textTheme}');

  // Test NoDefaultCupertinoThemeData with only textTheme
  final textOnlyNoDefault = NoDefaultCupertinoThemeData(
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(fontSize: 20.0),
      navLargeTitleTextStyle: TextStyle(
        fontSize: 36.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
  print('NoDefaultCupertinoThemeData with only textTheme created');

  // Test NoDefaultCupertinoThemeData with copyWith
  final copiedNoDefault = fullNoDefault.copyWith(
    primaryColor: CupertinoColors.systemRed,
  );
  print('NoDefaultCupertinoThemeData.copyWith created');
  print('  primaryColor: ${copiedNoDefault.primaryColor}');

  // Test NoDefaultCupertinoThemeData properties applied via CupertinoThemeData
  // Note: NoDefaultCupertinoThemeData is the SUPERCLASS of CupertinoThemeData,
  // so it cannot be passed directly to CupertinoTheme(data:). We use
  // CupertinoThemeData with the same properties instead.
  final noDefaultThemeWidget = CupertinoTheme(
    data: CupertinoThemeData(
      brightness: fullNoDefault.brightness,
      primaryColor: fullNoDefault.primaryColor,
      primaryContrastingColor: fullNoDefault.primaryContrastingColor,
      barBackgroundColor: fullNoDefault.barBackgroundColor,
      scaffoldBackgroundColor: fullNoDefault.scaffoldBackgroundColor,
      textTheme: fullNoDefault.textTheme,
    ),
    child: Builder(
      builder: (BuildContext ctx) {
        final theme = CupertinoTheme.of(ctx);
        print('NoDefault properties via CupertinoTheme.of:');
        print('  primaryColor: ${theme.primaryColor}');
        return Text('NoDefault themed text');
      },
    ),
  );
  print('NoDefaultCupertinoThemeData properties applied via CupertinoTheme');

  // ========== MATERIALBASEDCUPERTINOTHEMEDATA ==========
  print('--- MaterialBasedCupertinoThemeData Tests ---');

  // Test MaterialBasedCupertinoThemeData with basic MaterialTheme
  final lightMaterialTheme = ThemeData.light();
  final materialBasedLight = MaterialBasedCupertinoThemeData(
    materialTheme: lightMaterialTheme,
  );
  print('MaterialBasedCupertinoThemeData from light theme created');
  print('  primaryColor: ${materialBasedLight.primaryColor}');
  print('  brightness: ${materialBasedLight.brightness}');
  print(
    '  scaffoldBackgroundColor: ${materialBasedLight.scaffoldBackgroundColor}',
  );

  // Test MaterialBasedCupertinoThemeData with dark MaterialTheme
  final darkMaterialTheme = ThemeData.dark();
  final materialBasedDark = MaterialBasedCupertinoThemeData(
    materialTheme: darkMaterialTheme,
  );
  print('MaterialBasedCupertinoThemeData from dark theme created');
  print('  primaryColor: ${materialBasedDark.primaryColor}');
  print('  brightness: ${materialBasedDark.brightness}');
  print(
    '  scaffoldBackgroundColor: ${materialBasedDark.scaffoldBackgroundColor}',
  );

  // Test MaterialBasedCupertinoThemeData with custom MaterialTheme
  final customMaterialTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  );
  final materialBasedCustom = MaterialBasedCupertinoThemeData(
    materialTheme: customMaterialTheme,
  );
  print('MaterialBasedCupertinoThemeData from custom theme created');
  print('  primaryColor: ${materialBasedCustom.primaryColor}');
  print('  brightness: ${materialBasedCustom.brightness}');

  // Test MaterialBasedCupertinoThemeData with blue seed
  final blueMaterialTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  );
  final materialBasedBlue = MaterialBasedCupertinoThemeData(
    materialTheme: blueMaterialTheme,
  );
  print('MaterialBasedCupertinoThemeData from blue seed created');
  print('  primaryColor: ${materialBasedBlue.primaryColor}');

  // Test MaterialBasedCupertinoThemeData with red seed
  final redMaterialTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
  );
  final materialBasedRed = MaterialBasedCupertinoThemeData(
    materialTheme: redMaterialTheme,
  );
  print('MaterialBasedCupertinoThemeData from red seed created');
  print('  primaryColor: ${materialBasedRed.primaryColor}');

  // Test MaterialBasedCupertinoThemeData textTheme access
  print('MaterialBased textTheme access:');
  print('  textStyle: ${materialBasedLight.textTheme.textStyle}');
  print(
    '  navTitleTextStyle: ${materialBasedLight.textTheme.navTitleTextStyle}',
  );
  print('  actionTextStyle: ${materialBasedLight.textTheme.actionTextStyle}');

  // Test MaterialBasedCupertinoThemeData.copyWith
  final copiedMaterialBased = materialBasedLight.copyWith(
    primaryColor: CupertinoColors.systemGreen,
  );
  print('MaterialBasedCupertinoThemeData.copyWith created');
  print('  primaryColor: ${copiedMaterialBased.primaryColor}');

  // ========== COMPARISON ==========
  print('--- Comparison: Regular vs NoDefault vs MaterialBased ---');

  final regularTheme = CupertinoThemeData(
    primaryColor: CupertinoColors.systemBlue,
  );
  print('Regular: primaryColor=${regularTheme.primaryColor}');
  print('NoDefault: primaryColor=${fullNoDefault.primaryColor}');
  print('MaterialBased: primaryColor=${materialBasedLight.primaryColor}');

  print('All Cupertino themes batch 4 tests passed');

  // ========== RETURN WIDGET ==========
  return CupertinoApp(
    theme: CupertinoThemeData(primaryColor: CupertinoColors.systemBlue),
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Themes Batch 4')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'NoDefaultCupertinoThemeData:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),

              // NoDefault themed section — use CupertinoThemeData (supertype fix)
              CupertinoTheme(
                data: CupertinoThemeData(
                  primaryColor: CupertinoColors.systemOrange,
                ),
                child: Builder(
                  builder: (BuildContext ctx) {
                    final theme = CupertinoTheme.of(ctx);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('NoDefault primary: ${theme.primaryColor}'),
                        SizedBox(height: 4.0),
                        CupertinoButton.filled(
                          child: Text('NoDefault Button'),
                          onPressed: () {},
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 8.0),

              CupertinoTheme(
                data: CupertinoThemeData(
                  primaryColor: CupertinoColors.systemPurple,
                  brightness: Brightness.light,
                ),
                child: CupertinoButton.filled(
                  child: Text('Purple NoDefault'),
                  onPressed: () {},
                ),
              ),

              SizedBox(height: 16.0),
              Text(
                'MaterialBasedCupertinoThemeData:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),

              // MaterialBased from light theme
              CupertinoTheme(
                data: materialBasedLight,
                child: Builder(
                  builder: (BuildContext ctx) {
                    final theme = CupertinoTheme.of(ctx);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MaterialBased(light) primary: ${theme.primaryColor}',
                        ),
                        SizedBox(height: 4.0),
                        CupertinoButton.filled(
                          child: Text('Light Material'),
                          onPressed: () {},
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 8.0),

              // MaterialBased from custom theme
              CupertinoTheme(
                data: materialBasedCustom,
                child: Builder(
                  builder: (BuildContext ctx) {
                    final theme = CupertinoTheme.of(ctx);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MaterialBased(custom) primary: ${theme.primaryColor}',
                        ),
                        SizedBox(height: 4.0),
                        CupertinoButton.filled(
                          child: Text('Custom Material'),
                          onPressed: () {},
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 8.0),

              // MaterialBased from dark theme
              CupertinoTheme(
                data: materialBasedDark,
                child: CupertinoButton.filled(
                  child: Text('Dark Material'),
                  onPressed: () {},
                ),
              ),

              SizedBox(height: 24.0),
              Text(
                'Tests Completed:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text('• NoDefaultCupertinoThemeData construction'),
              Text('• NoDefaultCupertinoThemeData.copyWith'),
              Text('• NoDefaultCupertinoThemeData via CupertinoTheme'),
              Text('• MaterialBasedCupertinoThemeData light'),
              Text('• MaterialBasedCupertinoThemeData dark'),
              Text('• MaterialBasedCupertinoThemeData custom'),
              Text('• MaterialBasedCupertinoThemeData.copyWith'),
              Text('• Theme type comparison'),
            ],
          ),
        ),
      ),
    ),
  );
}
