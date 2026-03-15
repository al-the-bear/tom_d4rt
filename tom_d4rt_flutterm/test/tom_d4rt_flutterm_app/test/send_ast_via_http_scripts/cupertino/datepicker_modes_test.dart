// D4rt test script: Tests CupertinoDatePicker with CupertinoDatePickerMode values, CupertinoTimerPicker with CupertinoTimerPickerMode values from cupertino
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino date/timer picker modes test executing');

  // ========== CUPERTINODATEPICKER MODES ==========
  print('--- CupertinoDatePicker Mode Tests ---');

  // Test CupertinoDatePickerMode.date
  final datePicker = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.date,
    initialDateTime: DateTime(2025, 6, 15),
    onDateTimeChanged: (DateTime dt) {
      print('Date changed: $dt');
    },
  );
  print('CupertinoDatePicker mode=date created');

  // Test CupertinoDatePickerMode.time
  final timePicker = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.time,
    initialDateTime: DateTime(2025, 6, 15, 14, 30),
    onDateTimeChanged: (DateTime dt) {
      print('Time changed: $dt');
    },
  );
  print('CupertinoDatePicker mode=time created');

  // Test CupertinoDatePickerMode.dateAndTime
  final dateAndTimePicker = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.dateAndTime,
    initialDateTime: DateTime(2025, 6, 15, 14, 30),
    onDateTimeChanged: (DateTime dt) {
      print('DateTime changed: $dt');
    },
  );
  print('CupertinoDatePicker mode=dateAndTime created');

  // Test CupertinoDatePickerMode.monthYear
  final monthYearPicker = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.monthYear,
    initialDateTime: DateTime(2025, 6, 1),
    onDateTimeChanged: (DateTime dt) {
      print('MonthYear changed: $dt');
    },
  );
  print('CupertinoDatePicker mode=monthYear created');

  // Test CupertinoDatePicker with minimumDate and maximumDate
  final boundedDatePicker = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.date,
    initialDateTime: DateTime(2025, 6, 15),
    minimumDate: DateTime(2020, 1, 1),
    maximumDate: DateTime(2030, 12, 31),
    onDateTimeChanged: (DateTime dt) {
      print('Bounded date changed: $dt');
    },
  );
  print('CupertinoDatePicker with min/max dates created');

  // Test CupertinoDatePicker with minimumYear and maximumYear
  final yearBoundedPicker = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.date,
    initialDateTime: DateTime(2025, 6, 15),
    minimumYear: 2000,
    maximumYear: 2050,
    onDateTimeChanged: (DateTime dt) {
      print('Year-bounded date changed: $dt');
    },
  );
  print('CupertinoDatePicker with min/max years created');

  // Test CupertinoDatePicker with use24hFormat
  final format24hPicker = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.time,
    initialDateTime: DateTime(2025, 6, 15, 14, 30),
    use24hFormat: true,
    onDateTimeChanged: (DateTime dt) {
      print('24h time changed: $dt');
    },
  );
  print('CupertinoDatePicker with use24hFormat created');

  // Test CupertinoDatePicker with minuteInterval
  final intervalPicker = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.time,
    initialDateTime: DateTime(2025, 6, 15, 14, 0),
    minuteInterval: 15,
    onDateTimeChanged: (DateTime dt) {
      print('Interval time changed: $dt');
    },
  );
  print('CupertinoDatePicker with minuteInterval created');

  // Test CupertinoDatePicker with backgroundColor
  final bgDatePicker = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.date,
    initialDateTime: DateTime(2025, 6, 15),
    backgroundColor: CupertinoColors.systemGroupedBackground,
    onDateTimeChanged: (DateTime dt) {},
  );
  print('CupertinoDatePicker with backgroundColor created');

  // ========== CUPERTINOTIMERPPICKER MODES ==========
  print('--- CupertinoTimerPicker Mode Tests ---');

  // Test CupertinoTimerPickerMode.hms (hours, minutes, seconds)
  final hmsTimer = CupertinoTimerPicker(
    mode: CupertinoTimerPickerMode.hms,
    initialTimerDuration: Duration(hours: 1, minutes: 30, seconds: 45),
    onTimerDurationChanged: (Duration d) {
      print('HMS timer changed: $d');
    },
  );
  print('CupertinoTimerPicker mode=hms created');

  // Test CupertinoTimerPickerMode.hm (hours, minutes)
  final hmTimer = CupertinoTimerPicker(
    mode: CupertinoTimerPickerMode.hm,
    initialTimerDuration: Duration(hours: 2, minutes: 15),
    onTimerDurationChanged: (Duration d) {
      print('HM timer changed: $d');
    },
  );
  print('CupertinoTimerPicker mode=hm created');

  // Test CupertinoTimerPickerMode.ms (minutes, seconds)
  final msTimer = CupertinoTimerPicker(
    mode: CupertinoTimerPickerMode.ms,
    initialTimerDuration: Duration(minutes: 5, seconds: 30),
    onTimerDurationChanged: (Duration d) {
      print('MS timer changed: $d');
    },
  );
  print('CupertinoTimerPicker mode=ms created');

  // Test CupertinoTimerPicker with minuteInterval
  final intervalTimer = CupertinoTimerPicker(
    mode: CupertinoTimerPickerMode.hm,
    minuteInterval: 5,
    initialTimerDuration: Duration(hours: 1, minutes: 30),
    onTimerDurationChanged: (Duration d) {
      print('Interval timer changed: $d');
    },
  );
  print('CupertinoTimerPicker with minuteInterval created');

  // Test CupertinoTimerPicker with secondInterval
  final secIntervalTimer = CupertinoTimerPicker(
    mode: CupertinoTimerPickerMode.hms,
    secondInterval: 10,
    initialTimerDuration: Duration(hours: 0, minutes: 10, seconds: 30),
    onTimerDurationChanged: (Duration d) {
      print('Sec interval timer changed: $d');
    },
  );
  print('CupertinoTimerPicker with secondInterval created');

  // Test CupertinoTimerPicker with alignment
  final alignedTimer = CupertinoTimerPicker(
    mode: CupertinoTimerPickerMode.hm,
    alignment: Alignment.center,
    initialTimerDuration: Duration(hours: 0, minutes: 45),
    onTimerDurationChanged: (Duration d) {},
  );
  print('CupertinoTimerPicker with alignment created');

  // Test CupertinoTimerPicker with backgroundColor
  final bgTimer = CupertinoTimerPicker(
    mode: CupertinoTimerPickerMode.hms,
    backgroundColor: CupertinoColors.systemGroupedBackground,
    initialTimerDuration: Duration(hours: 0, minutes: 15, seconds: 0),
    onTimerDurationChanged: (Duration d) {},
  );
  print('CupertinoTimerPicker with backgroundColor created');

  print('All date/timer picker mode tests passed');

  // ========== RETURN WIDGET ==========
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('DatePicker Modes Test'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Cupertino Date/Timer Pickers:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
              SizedBox(
                height: 250.0,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text('Date Mode'),
                          SizedBox(height: 4.0),
                          Expanded(child: datePicker),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text('Time Mode'),
                          SizedBox(height: 4.0),
                          Expanded(child: timePicker),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Timer Picker (HM):'),
              ),
              SizedBox(height: 150.0, child: hmTimer),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tests Completed:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text('• CupertinoDatePickerMode.date'),
                    Text('• CupertinoDatePickerMode.time'),
                    Text('• CupertinoDatePickerMode.dateAndTime'),
                    Text('• CupertinoDatePickerMode.monthYear'),
                    Text('• CupertinoTimerPickerMode.hms'),
                    Text('• CupertinoTimerPickerMode.hm'),
                    Text('• CupertinoTimerPickerMode.ms'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
