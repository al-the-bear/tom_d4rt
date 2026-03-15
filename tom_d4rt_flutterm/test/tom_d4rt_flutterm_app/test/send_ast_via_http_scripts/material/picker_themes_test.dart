// D4rt test script: Tests DatePickerTheme, DatePickerThemeData, TimePickerTheme, TimePickerThemeData, PopupMenuTheme, PopupMenuThemeData from material
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Picker themes test executing');

  // ========== DATE PICKER THEME DATA ==========
  print('--- DatePickerThemeData Tests ---');

  final datePickerThemeData = DatePickerThemeData(
    backgroundColor: Colors.white,
    elevation: 6.0,
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.blue.shade50,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
    headerBackgroundColor: Colors.blue,
    headerForegroundColor: Colors.white,
    headerHeadlineStyle: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
    headerHelpStyle: TextStyle(fontSize: 14.0),
    dayStyle: TextStyle(fontSize: 14.0),
    dayForegroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return Colors.white;
      if (states.contains(WidgetState.disabled)) return Colors.grey;
      return Colors.black87;
    }),
    dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return Colors.blue;
      return Colors.transparent;
    }),
    dayOverlayColor: WidgetStateProperty.all(
      Colors.blue.withValues(alpha: 0.1),
    ),
    todayForegroundColor: WidgetStateProperty.all(Colors.blue),
    todayBackgroundColor: WidgetStateProperty.all(Colors.transparent),
    todayBorder: BorderSide(color: Colors.blue, width: 1.0),
    yearStyle: TextStyle(fontSize: 16.0),
    yearForegroundColor: WidgetStateProperty.all(Colors.black87),
    yearBackgroundColor: WidgetStateProperty.all(Colors.transparent),
    yearOverlayColor: WidgetStateProperty.all(
      Colors.blue.withValues(alpha: 0.1),
    ),
    weekdayStyle: TextStyle(fontSize: 12.0, color: Colors.grey.shade600),
    rangePickerBackgroundColor: Colors.white,
    rangePickerElevation: 0.0,
    rangePickerShadowColor: Colors.transparent,
    rangePickerSurfaceTintColor: Colors.transparent,
    rangePickerHeaderBackgroundColor: Colors.blue,
    rangePickerHeaderForegroundColor: Colors.white,
    rangePickerHeaderHeadlineStyle: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    ),
    rangePickerHeaderHelpStyle: TextStyle(fontSize: 14.0),
    rangeSelectionBackgroundColor: Colors.blue.shade50,
    rangeSelectionOverlayColor: WidgetStateProperty.all(
      Colors.blue.withValues(alpha: 0.1),
    ),
    dividerColor: Colors.grey.shade300,
  );
  print('DatePickerThemeData created');
  print('  backgroundColor: ${datePickerThemeData.backgroundColor}');
  print('  elevation: ${datePickerThemeData.elevation}');
  print(
    '  headerBackgroundColor: ${datePickerThemeData.headerBackgroundColor}',
  );
  print(
    '  headerForegroundColor: ${datePickerThemeData.headerForegroundColor}',
  );
  print('  todayBorder: ${datePickerThemeData.todayBorder}');
  print(
    '  rangeSelectionBackgroundColor: ${datePickerThemeData.rangeSelectionBackgroundColor}',
  );
  print('  dividerColor: ${datePickerThemeData.dividerColor}');
  print('  shape: ${datePickerThemeData.shape}');

  // Test copyWith
  final copiedDatePickerTheme = datePickerThemeData.copyWith(
    backgroundColor: Colors.grey.shade50,
    elevation: 8.0,
  );
  print('DatePickerThemeData.copyWith created');
  print('  new backgroundColor: ${copiedDatePickerTheme.backgroundColor}');
  print('  new elevation: ${copiedDatePickerTheme.elevation}');
  print(
    '  headerBackgroundColor preserved: ${copiedDatePickerTheme.headerBackgroundColor}',
  );

  // ========== TIME PICKER THEME DATA ==========
  print('--- TimePickerThemeData Tests ---');

  final timePickerThemeData = TimePickerThemeData(
    backgroundColor: Colors.white,
    elevation: 6.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
    hourMinuteShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    dayPeriodShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    dayPeriodColor: Colors.blue.shade50,
    dayPeriodTextColor: Colors.blue,
    dayPeriodBorderSide: BorderSide(color: Colors.blue, width: 1.0),
    hourMinuteColor: Colors.blue.shade50,
    hourMinuteTextColor: Colors.blue,
    dialHandColor: Colors.blue,
    dialBackgroundColor: Colors.blue.shade50,
    dialTextColor: Colors.black87,
    entryModeIconColor: Colors.blue,
    helpTextStyle: TextStyle(fontSize: 12.0, color: Colors.grey),
    hourMinuteTextStyle: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
    dayPeriodTextStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
    padding: EdgeInsets.all(24.0),
    cancelButtonStyle: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Colors.grey),
    ),
    confirmButtonStyle: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Colors.blue),
    ),
  );
  print('TimePickerThemeData created');
  print('  backgroundColor: ${timePickerThemeData.backgroundColor}');
  print('  elevation: ${timePickerThemeData.elevation}');
  print('  dialHandColor: ${timePickerThemeData.dialHandColor}');
  print('  dialBackgroundColor: ${timePickerThemeData.dialBackgroundColor}');
  print('  hourMinuteColor: ${timePickerThemeData.hourMinuteColor}');
  print('  dayPeriodColor: ${timePickerThemeData.dayPeriodColor}');
  print('  entryModeIconColor: ${timePickerThemeData.entryModeIconColor}');
  print('  shape: ${timePickerThemeData.shape}');

  // Test copyWith
  final copiedTimePickerTheme = timePickerThemeData.copyWith(
    backgroundColor: Colors.grey.shade50,
    dialHandColor: Colors.indigo,
  );
  print('TimePickerThemeData.copyWith created');
  print('  new backgroundColor: ${copiedTimePickerTheme.backgroundColor}');
  print('  new dialHandColor: ${copiedTimePickerTheme.dialHandColor}');

  // ========== POPUP MENU THEME DATA ==========
  print('--- PopupMenuThemeData Tests ---');

  final popupMenuThemeData = PopupMenuThemeData(
    color: Colors.white,
    elevation: 8.0,
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.grey.shade50,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    textStyle: TextStyle(fontSize: 14.0, color: Colors.black87),
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(fontSize: 14.0, color: Colors.black87),
    ),
    enableFeedback: true,
    iconColor: Colors.grey.shade700,
    iconSize: 24.0,
    position: PopupMenuPosition.over,
  );
  print('PopupMenuThemeData created');
  print('  color: ${popupMenuThemeData.color}');
  print('  elevation: ${popupMenuThemeData.elevation}');
  print('  shadowColor: ${popupMenuThemeData.shadowColor}');
  print('  enableFeedback: ${popupMenuThemeData.enableFeedback}');
  print('  iconColor: ${popupMenuThemeData.iconColor}');
  print('  iconSize: ${popupMenuThemeData.iconSize}');
  print('  position: ${popupMenuThemeData.position}');
  print('  shape: ${popupMenuThemeData.shape}');

  // Test copyWith
  final copiedPopupMenuTheme = popupMenuThemeData.copyWith(
    color: Colors.grey.shade100,
    elevation: 4.0,
  );
  print('PopupMenuThemeData.copyWith created');
  print('  new color: ${copiedPopupMenuTheme.color}');
  print('  new elevation: ${copiedPopupMenuTheme.elevation}');

  // ========== WRAP IN THEME WIDGET ==========
  print('--- Theme Integration ---');

  final themeData = ThemeData(
    datePickerTheme: datePickerThemeData,
    timePickerTheme: timePickerThemeData,
    popupMenuTheme: popupMenuThemeData,
  );
  print('ThemeData with picker themes created');

  return Theme(
    data: themeData,
    child: Builder(
      builder: (ctx) {
        final resolvedTheme = Theme.of(ctx);
        print('Theme.of resolved');
        print(
          '  datePickerTheme.elevation: ${resolvedTheme.datePickerTheme.elevation}',
        );
        print(
          '  timePickerTheme.dialHandColor: ${resolvedTheme.timePickerTheme.dialHandColor}',
        );
        print(
          '  popupMenuTheme.elevation: ${resolvedTheme.popupMenuTheme.elevation}',
        );

        return DatePickerTheme(
          data: datePickerThemeData,
          child: TimePickerTheme(
            data: timePickerThemeData,
            child: PopupMenuTheme(
              data: popupMenuThemeData,
              child: Card(child: Text('Picker themes test passed')),
            ),
          ),
        );
      },
    ),
  );
}
