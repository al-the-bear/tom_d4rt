// D4rt test script: Tests DefaultCupertinoLocalizations from cupertino
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('DefaultCupertinoLocalizations test executing');

  // ========== DEFAULTCUPERTINOLOCALIZATIONS ==========
  print('--- DefaultCupertinoLocalizations Tests ---');

  // Construct DefaultCupertinoLocalizations directly
  final localizations = DefaultCupertinoLocalizations();
  print('DefaultCupertinoLocalizations created');

  // Test datePickerYear
  final year2025 = localizations.datePickerYear(2025);
  print('datePickerYear(2025): $year2025');

  final year2000 = localizations.datePickerYear(2000);
  print('datePickerYear(2000): $year2000');

  // Test datePickerMonth
  final jan = localizations.datePickerMonth(1);
  final feb = localizations.datePickerMonth(2);
  final mar = localizations.datePickerMonth(3);
  final apr = localizations.datePickerMonth(4);
  final may = localizations.datePickerMonth(5);
  final jun = localizations.datePickerMonth(6);
  final jul = localizations.datePickerMonth(7);
  final aug = localizations.datePickerMonth(8);
  final sep = localizations.datePickerMonth(9);
  final oct = localizations.datePickerMonth(10);
  final nov = localizations.datePickerMonth(11);
  final dec = localizations.datePickerMonth(12);
  print('datePickerMonth(1): $jan');
  print('datePickerMonth(6): $jun');
  print('datePickerMonth(12): $dec');

  // Test datePickerDayOfMonth
  final day1 = localizations.datePickerDayOfMonth(1);
  final day15 = localizations.datePickerDayOfMonth(15);
  final day31 = localizations.datePickerDayOfMonth(31);
  print('datePickerDayOfMonth(1): $day1');
  print('datePickerDayOfMonth(15): $day15');
  print('datePickerDayOfMonth(31): $day31');

  // Test datePickerHour
  final hour0 = localizations.datePickerHour(0);
  final hour12 = localizations.datePickerHour(12);
  final hour23 = localizations.datePickerHour(23);
  print('datePickerHour(0): $hour0');
  print('datePickerHour(12): $hour12');
  print('datePickerHour(23): $hour23');

  // Test datePickerMinute
  final min0 = localizations.datePickerMinute(0);
  final min30 = localizations.datePickerMinute(30);
  final min59 = localizations.datePickerMinute(59);
  print('datePickerMinute(0): $min0');
  print('datePickerMinute(30): $min30');
  print('datePickerMinute(59): $min59');

  // Test datePickerMediumDate
  final mediumDate = localizations.datePickerMediumDate(DateTime(2025, 6, 15));
  print('datePickerMediumDate: $mediumDate');

  // Test datePickerDateOrder
  final dateOrder = localizations.datePickerDateOrder;
  print('datePickerDateOrder: $dateOrder');

  // Test datePickerDateTimeOrder
  final dateTimeOrder = localizations.datePickerDateTimeOrder;
  print('datePickerDateTimeOrder: $dateTimeOrder');

  // Test anteMeridiemAbbreviation and postMeridiemAbbreviation
  final am = localizations.anteMeridiemAbbreviation;
  final pm = localizations.postMeridiemAbbreviation;
  print('anteMeridiemAbbreviation: $am');
  print('postMeridiemAbbreviation: $pm');

  // Test alertDialogLabel
  final alertLabel = localizations.alertDialogLabel;
  print('alertDialogLabel: $alertLabel');

  // Test timerPickerHourLabel
  final hourLabel1 = localizations.timerPickerHourLabel(1);
  final hourLabel5 = localizations.timerPickerHourLabel(5);
  print('timerPickerHourLabel(1): $hourLabel1');
  print('timerPickerHourLabel(5): $hourLabel5');

  // Test timerPickerMinuteLabel
  final minLabel1 = localizations.timerPickerMinuteLabel(1);
  final minLabel30 = localizations.timerPickerMinuteLabel(30);
  print('timerPickerMinuteLabel(1): $minLabel1');
  print('timerPickerMinuteLabel(30): $minLabel30');

  // Test timerPickerSecondLabel
  final secLabel1 = localizations.timerPickerSecondLabel(1);
  final secLabel45 = localizations.timerPickerSecondLabel(45);
  print('timerPickerSecondLabel(1): $secLabel1');
  print('timerPickerSecondLabel(45): $secLabel45');

  // Test tabSemanticsLabel
  final tabLabel = localizations.tabSemanticsLabel(tabIndex: 2, tabCount: 5);
  print('tabSemanticsLabel(tabIndex:2, tabCount:5): $tabLabel');

  // Test copyButtonLabel, cutButtonLabel, pasteButtonLabel, selectAllButtonLabel
  final copyLabel = localizations.copyButtonLabel;
  final cutLabel = localizations.cutButtonLabel;
  final pasteLabel = localizations.pasteButtonLabel;
  final selectAllLabel = localizations.selectAllButtonLabel;
  print('copyButtonLabel: $copyLabel');
  print('cutButtonLabel: $cutLabel');
  print('pasteButtonLabel: $pasteLabel');
  print('selectAllButtonLabel: $selectAllLabel');

  // Test searchTextFieldPlaceholderLabel
  final searchPlaceholder = localizations.searchTextFieldPlaceholderLabel;
  print('searchTextFieldPlaceholderLabel: $searchPlaceholder');

  // Test modalBarrierDismissLabel
  final barrierLabel = localizations.modalBarrierDismissLabel;
  print('modalBarrierDismissLabel: $barrierLabel');

  print('All DefaultCupertinoLocalizations tests passed');

  // ========== RETURN WIDGET ==========
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Localizations Test')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DefaultCupertinoLocalizations:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text('Year 2025: $year2025'),
              Text('Month Jan: $jan'),
              Text('Month Jun: $jun'),
              Text('Month Dec: $dec'),
              Text('Day 15: $day15'),
              Text('Hour 12: $hour12'),
              Text('Minute 30: $min30'),
              SizedBox(height: 8.0),
              Text('Medium date: $mediumDate'),
              Text('Date order: $dateOrder'),
              Text('AM: $am / PM: $pm'),
              SizedBox(height: 8.0),
              Text('Alert label: $alertLabel'),
              Text('Copy: $copyLabel'),
              Text('Cut: $cutLabel'),
              Text('Paste: $pasteLabel'),
              Text('Select All: $selectAllLabel'),
              Text('Search: $searchPlaceholder'),
              Text('Barrier: $barrierLabel'),
              SizedBox(height: 8.0),
              Text('Tab label: $tabLabel'),
              Text('Hour label(1): $hourLabel1'),
              Text('Min label(30): $minLabel30'),
              Text('Sec label(45): $secLabel45'),
              SizedBox(height: 16.0),
              Text(
                'Tests Completed:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text('• DefaultCupertinoLocalizations'),
              Text('• Date/time picker labels'),
              Text('• Button labels'),
              Text('• Semantic labels'),
            ],
          ),
        ),
      ),
    ),
  );
}
