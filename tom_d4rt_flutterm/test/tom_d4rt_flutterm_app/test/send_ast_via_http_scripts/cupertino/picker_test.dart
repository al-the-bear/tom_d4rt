// D4rt test script: Tests CupertinoPicker, CupertinoDatePicker, CupertinoTimerPicker from cupertino
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino picker test executing');

  // ========== CUPERTINOPICKER ==========
  print('--- CupertinoPicker Tests ---');

  // Test basic CupertinoPicker
  final basicPicker = CupertinoPicker(
    itemExtent: 32.0,
    onSelectedItemChanged: (int index) {
      print('Selected: $index');
    },
    children: [
      Center(child: Text('Item 1')),
      Center(child: Text('Item 2')),
      Center(child: Text('Item 3')),
    ],
  );
  print('Basic CupertinoPicker created');

  // Test CupertinoPicker with diameterRatio
  final diameterPicker = CupertinoPicker(
    itemExtent: 32.0,
    diameterRatio: 1.0,
    onSelectedItemChanged: (index) {},
    children: [
      Center(child: Text('A')),
      Center(child: Text('B')),
      Center(child: Text('C')),
    ],
  );
  print('CupertinoPicker with diameterRatio created');

  // Test CupertinoPicker with backgroundColor
  final bgPicker = CupertinoPicker(
    itemExtent: 32.0,
    backgroundColor: CupertinoColors.systemGroupedBackground,
    onSelectedItemChanged: (index) {},
    children: [
      Center(child: Text('One')),
      Center(child: Text('Two')),
      Center(child: Text('Three')),
    ],
  );
  print('CupertinoPicker with backgroundColor created');

  // Test CupertinoPicker with squeeze
  final squeezedPicker = CupertinoPicker(
    itemExtent: 32.0,
    squeeze: 1.5,
    onSelectedItemChanged: (index) {},
    children: [
      Center(child: Text('X')),
      Center(child: Text('Y')),
      Center(child: Text('Z')),
    ],
  );
  print('CupertinoPicker with squeeze created');

  // Test CupertinoPicker with magnification
  final magnifiedPicker = CupertinoPicker(
    itemExtent: 32.0,
    magnification: 1.2,
    onSelectedItemChanged: (index) {},
    children: [
      Center(child: Text('First')),
      Center(child: Text('Second')),
      Center(child: Text('Third')),
    ],
  );
  print('CupertinoPicker with magnification created');

  // Test CupertinoPicker with offAxisFraction
  final offAxisPicker = CupertinoPicker(
    itemExtent: 32.0,
    offAxisFraction: 0.5,
    onSelectedItemChanged: (index) {},
    children: [
      Center(child: Text('Left')),
      Center(child: Text('Center')),
      Center(child: Text('Right')),
    ],
  );
  print('CupertinoPicker with offAxisFraction created');

  // Test CupertinoPicker with useMagnifier
  final useMagnifierPicker = CupertinoPicker(
    itemExtent: 32.0,
    useMagnifier: true,
    magnification: 1.3,
    onSelectedItemChanged: (index) {},
    children: [
      Center(child: Text('Option A')),
      Center(child: Text('Option B')),
      Center(child: Text('Option C')),
    ],
  );
  print('CupertinoPicker with useMagnifier created');

  // Test CupertinoPicker with selectionOverlay
  final overlayPicker = CupertinoPicker(
    itemExtent: 32.0,
    selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
      background: CupertinoColors.systemBlue.withOpacity(0.1),
    ),
    onSelectedItemChanged: (index) {},
    children: [
      Center(child: Text('Pick 1')),
      Center(child: Text('Pick 2')),
      Center(child: Text('Pick 3')),
    ],
  );
  print('CupertinoPicker with selectionOverlay created');

  // Test CupertinoPicker.builder
  final builderPicker = CupertinoPicker.builder(
    itemExtent: 32.0,
    onSelectedItemChanged: (index) {},
    itemBuilder: (context, index) {
      return Center(child: Text('Item ${index + 1}'));
    },
    childCount: 10,
  );
  print('CupertinoPicker.builder created');

  // Test CupertinoPicker with scrollController
  final scrollControllerPicker = CupertinoPicker(
    itemExtent: 32.0,
    scrollController: FixedExtentScrollController(initialItem: 2),
    onSelectedItemChanged: (index) {},
    children: [
      Center(child: Text('January')),
      Center(child: Text('February')),
      Center(child: Text('March')),
      Center(child: Text('April')),
      Center(child: Text('May')),
    ],
  );
  print('CupertinoPicker with scrollController created');

  // Test CupertinoPicker with looping
  final loopingPicker = CupertinoPicker(
    itemExtent: 32.0,
    looping: true,
    onSelectedItemChanged: (index) {},
    children: [
      Center(child: Text('1')),
      Center(child: Text('2')),
      Center(child: Text('3')),
      Center(child: Text('4')),
      Center(child: Text('5')),
    ],
  );
  print('CupertinoPicker with looping created');

  // ========== CUPERTINODATEPICKER ==========
  print('--- CupertinoDatePicker Tests ---');

  // Test basic CupertinoDatePicker
  final basicDatePicker = CupertinoDatePicker(
    onDateTimeChanged: (DateTime dateTime) {
      print('Date changed: $dateTime');
    },
  );
  print('Basic CupertinoDatePicker created');

  // Test CupertinoDatePicker with mode: date
  final datePicker = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.date,
    onDateTimeChanged: (dateTime) {},
  );
  print('CupertinoDatePicker with mode: date created');

  // Test CupertinoDatePicker with mode: time
  final timePicker = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.time,
    onDateTimeChanged: (dateTime) {},
  );
  print('CupertinoDatePicker with mode: time created');

  // Test CupertinoDatePicker with mode: dateAndTime
  final dateAndTimePicker = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.dateAndTime,
    onDateTimeChanged: (dateTime) {},
  );
  print('CupertinoDatePicker with mode: dateAndTime created');

  // Test CupertinoDatePicker with mode: monthYear
  final monthYearPicker = CupertinoDatePicker(
    mode: CupertinoDatePickerMode.monthYear,
    onDateTimeChanged: (dateTime) {},
  );
  print('CupertinoDatePicker with mode: monthYear created');

  // Test CupertinoDatePicker with initialDateTime
  final initialDatePicker = CupertinoDatePicker(
    initialDateTime: DateTime(2025, 6, 15, 10, 30),
    onDateTimeChanged: (dateTime) {},
  );
  print('CupertinoDatePicker with initialDateTime created');

  // Test CupertinoDatePicker with minimumDate
  final minDatePicker = CupertinoDatePicker(
    minimumDate: DateTime(2020, 1, 1),
    onDateTimeChanged: (dateTime) {},
  );
  print('CupertinoDatePicker with minimumDate created');

  // Test CupertinoDatePicker with maximumDate
  final maxDatePicker = CupertinoDatePicker(
    maximumDate: DateTime(2030, 12, 31),
    onDateTimeChanged: (dateTime) {},
  );
  print('CupertinoDatePicker with maximumDate created');

  // Test CupertinoDatePicker with minimumYear
  final minYearPicker = CupertinoDatePicker(
    minimumYear: 2000,
    mode: CupertinoDatePickerMode.date,
    onDateTimeChanged: (dateTime) {},
  );
  print('CupertinoDatePicker with minimumYear created');

  // Test CupertinoDatePicker with maximumYear
  final maxYearPicker = CupertinoDatePicker(
    maximumYear: 2050,
    mode: CupertinoDatePickerMode.date,
    onDateTimeChanged: (dateTime) {},
  );
  print('CupertinoDatePicker with maximumYear created');

  // Test CupertinoDatePicker with minuteInterval
  final intervalPicker = CupertinoDatePicker(
    minuteInterval: 15,
    initialDateTime: DateTime(2025, 6, 15, 10, 0),
    mode: CupertinoDatePickerMode.time,
    onDateTimeChanged: (dateTime) {},
  );
  print('CupertinoDatePicker with minuteInterval created');

  // Test CupertinoDatePicker with use24hFormat
  final format24hPicker = CupertinoDatePicker(
    use24hFormat: true,
    mode: CupertinoDatePickerMode.time,
    onDateTimeChanged: (dateTime) {},
  );
  print('CupertinoDatePicker with use24hFormat created');

  // Test CupertinoDatePicker with dateOrder
  final dateOrderPicker = CupertinoDatePicker(
    dateOrder: DatePickerDateOrder.ymd,
    mode: CupertinoDatePickerMode.date,
    onDateTimeChanged: (dateTime) {},
  );
  print('CupertinoDatePicker with dateOrder created');

  // Test CupertinoDatePicker with backgroundColor
  final bgDatePicker = CupertinoDatePicker(
    backgroundColor: CupertinoColors.systemGrey6,
    onDateTimeChanged: (dateTime) {},
  );
  print('CupertinoDatePicker with backgroundColor created');

  // Test CupertinoDatePicker with showDayOfWeek
  final dayOfWeekPicker = CupertinoDatePicker(
    showDayOfWeek: true,
    mode: CupertinoDatePickerMode.date,
    onDateTimeChanged: (dateTime) {},
  );
  print('CupertinoDatePicker with showDayOfWeek created');

  // Test CupertinoDatePicker with itemExtent
  final itemExtentDatePicker = CupertinoDatePicker(
    itemExtent: 40.0,
    onDateTimeChanged: (dateTime) {},
  );
  print('CupertinoDatePicker with itemExtent created');

  // ========== CUPERTINOTIMERPICKER ==========
  print('--- CupertinoTimerPicker Tests ---');

  // Test basic CupertinoTimerPicker
  final basicTimerPicker = CupertinoTimerPicker(
    onTimerDurationChanged: (Duration duration) {
      print('Duration changed: $duration');
    },
  );
  print('Basic CupertinoTimerPicker created');

  // Test CupertinoTimerPicker with mode: hm
  final hmTimerPicker = CupertinoTimerPicker(
    mode: CupertinoTimerPickerMode.hm,
    onTimerDurationChanged: (duration) {},
  );
  print('CupertinoTimerPicker with mode: hm created');

  // Test CupertinoTimerPicker with mode: ms
  final msTimerPicker = CupertinoTimerPicker(
    mode: CupertinoTimerPickerMode.ms,
    onTimerDurationChanged: (duration) {},
  );
  print('CupertinoTimerPicker with mode: ms created');

  // Test CupertinoTimerPicker with mode: hms
  final hmsTimerPicker = CupertinoTimerPicker(
    mode: CupertinoTimerPickerMode.hms,
    onTimerDurationChanged: (duration) {},
  );
  print('CupertinoTimerPicker with mode: hms created');

  // Test CupertinoTimerPicker with initialTimerDuration
  final initialTimerPicker = CupertinoTimerPicker(
    initialTimerDuration: Duration(hours: 1, minutes: 30),
    onTimerDurationChanged: (duration) {},
  );
  print('CupertinoTimerPicker with initialTimerDuration created');

  // Test CupertinoTimerPicker with minuteInterval
  final intervalTimerPicker = CupertinoTimerPicker(
    minuteInterval: 5,
    onTimerDurationChanged: (duration) {},
  );
  print('CupertinoTimerPicker with minuteInterval created');

  // Test CupertinoTimerPicker with secondInterval
  final secondIntervalTimerPicker = CupertinoTimerPicker(
    mode: CupertinoTimerPickerMode.hms,
    secondInterval: 10,
    onTimerDurationChanged: (duration) {},
  );
  print('CupertinoTimerPicker with secondInterval created');

  // Test CupertinoTimerPicker with alignment
  final alignedTimerPicker = CupertinoTimerPicker(
    alignment: Alignment.centerLeft,
    onTimerDurationChanged: (duration) {},
  );
  print('CupertinoTimerPicker with alignment created');

  // Test CupertinoTimerPicker with backgroundColor
  final bgTimerPicker = CupertinoTimerPicker(
    backgroundColor: CupertinoColors.systemGrey6,
    onTimerDurationChanged: (duration) {},
  );
  print('CupertinoTimerPicker with backgroundColor created');

  // Test CupertinoTimerPicker with itemExtent
  final itemExtentTimerPicker = CupertinoTimerPicker(
    itemExtent: 40.0,
    onTimerDurationChanged: (duration) {},
  );
  print('CupertinoTimerPicker with itemExtent created');

  print('Cupertino picker test completed');

  // Return a visual representation
  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Picker Tests')),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Cupertino Pickers:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),

            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text('Basic Picker'),
                        SizedBox(height: 8.0),
                        Expanded(child: basicPicker),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text('Date Picker'),
                        SizedBox(height: 8.0),
                        Expanded(
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: (dt) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.0),
            Padding(padding: EdgeInsets.all(8.0), child: Text('Timer Picker:')),
            SizedBox(height: 150.0, child: basicTimerPicker),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    ),
  );
}
