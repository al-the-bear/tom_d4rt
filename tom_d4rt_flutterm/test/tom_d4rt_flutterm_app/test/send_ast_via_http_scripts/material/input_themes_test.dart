// D4rt test script: Tests TabBarTheme, SliderTheme, SliderThemeData, SwitchTheme, SwitchThemeData, CheckboxTheme, CheckboxThemeData, RadioTheme, RadioThemeData, ProgressIndicatorTheme, ProgressIndicatorThemeData from material
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Input themes test executing');

  // ========== TAB BAR THEME DATA ==========
  print('--- TabBarThemeData Tests ---');

  final tabBarTheme = TabBarThemeData(
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(color: Colors.blue, width: 3.0),
    ),
    indicatorColor: Colors.blue,
    indicatorSize: TabBarIndicatorSize.tab,
    labelColor: Colors.blue,
    unselectedLabelColor: Colors.grey,
    labelStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
    unselectedLabelStyle: TextStyle(fontSize: 14.0),
    labelPadding: EdgeInsets.symmetric(horizontal: 16.0),
    dividerColor: Colors.grey.shade300,
    dividerHeight: 1.0,
    overlayColor: WidgetStateProperty.all(Colors.blue.withValues(alpha: 0.1)),
    tabAlignment: TabAlignment.fill,
  );
  print('TabBarThemeData created');
  print('  indicatorColor: ${tabBarTheme.indicatorColor}');
  print('  indicatorSize: ${tabBarTheme.indicatorSize}');
  print('  labelColor: ${tabBarTheme.labelColor}');
  print('  unselectedLabelColor: ${tabBarTheme.unselectedLabelColor}');
  print('  dividerColor: ${tabBarTheme.dividerColor}');
  print('  dividerHeight: ${tabBarTheme.dividerHeight}');
  print('  tabAlignment: ${tabBarTheme.tabAlignment}');

  // Test copyWith
  final copiedTabBarTheme = tabBarTheme.copyWith(
    labelColor: Colors.indigo,
    indicatorColor: Colors.indigo,
  );
  print('TabBarThemeData.copyWith created');
  print('  new labelColor: ${copiedTabBarTheme.labelColor}');
  print('  new indicatorColor: ${copiedTabBarTheme.indicatorColor}');

  // ========== SLIDER THEME DATA ==========
  print('--- SliderThemeData Tests ---');

  final sliderThemeData = SliderThemeData(
    activeTrackColor: Colors.blue,
    inactiveTrackColor: Colors.blue.shade100,
    disabledActiveTrackColor: Colors.grey,
    disabledInactiveTrackColor: Colors.grey.shade200,
    thumbColor: Colors.blue,
    disabledThumbColor: Colors.grey.shade400,
    overlayColor: Colors.blue.withValues(alpha: 0.2),
    activeTickMarkColor: Colors.blue.shade800,
    inactiveTickMarkColor: Colors.blue.shade200,
    valueIndicatorColor: Colors.blue.shade700,
    valueIndicatorTextStyle: TextStyle(fontSize: 14.0, color: Colors.white),
    trackHeight: 4.0,
    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
    overlayShape: RoundSliderOverlayShape(overlayRadius: 24.0),
    tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 2.0),
    valueIndicatorShape: PaddleSliderValueIndicatorShape(),
    trackShape: RoundedRectSliderTrackShape(),
    showValueIndicator: ShowValueIndicator.onlyForDiscrete,
  );
  print('SliderThemeData created');
  print('  activeTrackColor: ${sliderThemeData.activeTrackColor}');
  print('  thumbColor: ${sliderThemeData.thumbColor}');
  print('  trackHeight: ${sliderThemeData.trackHeight}');
  print('  showValueIndicator: ${sliderThemeData.showValueIndicator}');

  // Test copyWith
  final copiedSliderTheme = sliderThemeData.copyWith(
    activeTrackColor: Colors.green,
    thumbColor: Colors.green,
  );
  print('SliderThemeData.copyWith created');
  print('  new activeTrackColor: ${copiedSliderTheme.activeTrackColor}');
  print('  new thumbColor: ${copiedSliderTheme.thumbColor}');

  // ========== SWITCH THEME DATA ==========
  print('--- SwitchThemeData Tests ---');

  final switchThemeData = SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return Colors.blue;
      return Colors.grey;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return Colors.blue.shade200;
      return Colors.grey.shade300;
    }),
    trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    overlayColor: WidgetStateProperty.all(Colors.blue.withValues(alpha: 0.1)),
    splashRadius: 20.0,
    thumbIcon: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected))
        return Icon(Icons.check, size: 14.0);
      return null;
    }),
  );
  print('SwitchThemeData created');
  print('  splashRadius: ${switchThemeData.splashRadius}');
  print('  thumbColor: ${switchThemeData.thumbColor}');
  print('  trackColor: ${switchThemeData.trackColor}');

  // Test copyWith
  final copiedSwitchTheme = switchThemeData.copyWith(splashRadius: 24.0);
  print('SwitchThemeData.copyWith created');
  print('  new splashRadius: ${copiedSwitchTheme.splashRadius}');

  // ========== CHECKBOX THEME DATA ==========
  print('--- CheckboxThemeData Tests ---');

  final checkboxThemeData = CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return Colors.blue;
      return Colors.transparent;
    }),
    checkColor: WidgetStateProperty.all(Colors.white),
    overlayColor: WidgetStateProperty.all(Colors.blue.withValues(alpha: 0.1)),
    splashRadius: 20.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
    side: BorderSide(color: Colors.grey, width: 2.0),
    visualDensity: VisualDensity.compact,
  );
  print('CheckboxThemeData created');
  print('  splashRadius: ${checkboxThemeData.splashRadius}');
  print('  shape: ${checkboxThemeData.shape}');
  print('  side: ${checkboxThemeData.side}');
  print('  visualDensity: ${checkboxThemeData.visualDensity}');

  // Test copyWith
  final copiedCheckboxTheme = checkboxThemeData.copyWith(splashRadius: 24.0);
  print('CheckboxThemeData.copyWith created');
  print('  new splashRadius: ${copiedCheckboxTheme.splashRadius}');

  // ========== RADIO THEME DATA ==========
  print('--- RadioThemeData Tests ---');

  final radioThemeData = RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return Colors.blue;
      return Colors.grey;
    }),
    overlayColor: WidgetStateProperty.all(Colors.blue.withValues(alpha: 0.1)),
    splashRadius: 20.0,
    visualDensity: VisualDensity.compact,
  );
  print('RadioThemeData created');
  print('  splashRadius: ${radioThemeData.splashRadius}');
  print('  fillColor: ${radioThemeData.fillColor}');
  print('  visualDensity: ${radioThemeData.visualDensity}');

  // Test copyWith
  final copiedRadioTheme = radioThemeData.copyWith(splashRadius: 24.0);
  print('RadioThemeData.copyWith created');
  print('  new splashRadius: ${copiedRadioTheme.splashRadius}');

  // ========== PROGRESS INDICATOR THEME DATA ==========
  print('--- ProgressIndicatorThemeData Tests ---');

  final progressThemeData = ProgressIndicatorThemeData(
    color: Colors.blue,
    linearTrackColor: Colors.blue.shade100,
    circularTrackColor: Colors.blue.shade50,
    linearMinHeight: 4.0,
    refreshBackgroundColor: Colors.grey.shade200,
  );
  print('ProgressIndicatorThemeData created');
  print('  color: ${progressThemeData.color}');
  print('  linearTrackColor: ${progressThemeData.linearTrackColor}');
  print('  circularTrackColor: ${progressThemeData.circularTrackColor}');
  print('  linearMinHeight: ${progressThemeData.linearMinHeight}');
  print(
    '  refreshBackgroundColor: ${progressThemeData.refreshBackgroundColor}',
  );

  // Test copyWith
  final copiedProgressTheme = progressThemeData.copyWith(
    color: Colors.green,
    linearMinHeight: 6.0,
  );
  print('ProgressIndicatorThemeData.copyWith created');
  print('  new color: ${copiedProgressTheme.color}');
  print('  new linearMinHeight: ${copiedProgressTheme.linearMinHeight}');

  // ========== WRAP IN THEME WIDGET ==========
  print('--- Theme Integration ---');

  final themeData = ThemeData(
    tabBarTheme: tabBarTheme,
    sliderTheme: sliderThemeData,
    switchTheme: switchThemeData,
    checkboxTheme: checkboxThemeData,
    radioTheme: radioThemeData,
    progressIndicatorTheme: progressThemeData,
  );
  print('ThemeData with input themes created');

  return Theme(
    data: themeData,
    child: Builder(
      builder: (ctx) {
        final resolvedTheme = Theme.of(ctx);
        print('Theme.of resolved');
        print(
          '  tabBarTheme.labelColor: ${resolvedTheme.tabBarTheme.labelColor}',
        );
        print(
          '  sliderTheme.thumbColor: ${resolvedTheme.sliderTheme.thumbColor}',
        );
        print(
          '  checkboxTheme.splashRadius: ${resolvedTheme.checkboxTheme.splashRadius}',
        );
        print(
          '  progressIndicatorTheme.color: ${resolvedTheme.progressIndicatorTheme.color}',
        );

        return SliderTheme(
          data: sliderThemeData,
          child: SwitchTheme(
            data: switchThemeData,
            child: CheckboxTheme(
              data: checkboxThemeData,
              child: RadioTheme(
                data: radioThemeData,
                child: ProgressIndicatorTheme(
                  data: progressThemeData,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LinearProgressIndicator(value: 0.6),
                      SizedBox(height: 8.0),
                      Text('Input themes test passed'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
