// D4rt test script: Tests CupertinoLocalizations, CupertinoPageRoute, showCupertinoModalPopup, showCupertinoDialog, CupertinoSliverNavigationBar, CupertinoSegmentedControl, CupertinoSlidingSegmentedControl, CupertinoTextSelectionControls
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Cupertino misc advanced tests executing');

  // ========== CupertinoLocalizations ==========
  print('--- CupertinoLocalizations Tests ---');
  final localizations = DefaultCupertinoLocalizations();
  print('type: ${localizations.runtimeType}');
  print('datePickerMonth(1): ${localizations.datePickerMonth(1)}');
  print('datePickerDayOfMonth(15): ${localizations.datePickerDayOfMonth(15)}');
  print('timerPickerHour(3): ${localizations.timerPickerHour(3)}');
  print('timerPickerMinute(45): ${localizations.timerPickerMinute(45)}');
  print('timerPickerSecond(30): ${localizations.timerPickerSecond(30)}');
  print('selectAllButtonLabel: ${localizations.selectAllButtonLabel}');
  print('copyButtonLabel: ${localizations.copyButtonLabel}');
  print('cutButtonLabel: ${localizations.cutButtonLabel}');
  print('pasteButtonLabel: ${localizations.pasteButtonLabel}');
  print('CupertinoLocalizations tests passed');

  // ========== CupertinoPageRoute ==========
  print('--- CupertinoPageRoute Tests ---');
  final route = CupertinoPageRoute<void>(
    builder: (ctx) => const SizedBox(),
    title: 'Test Route',
  );
  print('type: ${route.runtimeType}');
  print('title: ${route.title}');
  print('maintainState: ${route.maintainState}');
  print('fullscreenDialog: ${route.fullscreenDialog}');
  print('CupertinoPageRoute tests passed');

  // ========== showCupertinoModalPopup / showCupertinoDialog ==========
  print('--- showCupertinoModalPopup / showCupertinoDialog Tests ---');
  print('showCupertinoModalPopup type: ${showCupertinoModalPopup.runtimeType}');
  print('showCupertinoDialog type: ${showCupertinoDialog.runtimeType}');
  print('Both are top-level functions from cupertino library');
  print('showCupertinoModalPopup/showCupertinoDialog reference passed');

  // ========== CupertinoSliverNavigationBar ==========
  print('--- CupertinoSliverNavigationBar Tests ---');
  final sliverNavBar = CupertinoSliverNavigationBar(largeTitle: Text('Test'));
  print('type: ${sliverNavBar.runtimeType}');
  print('CupertinoSliverNavigationBar is a StatefulWidget');
  print('Its State class (CupertinoSliverNavigationBarState) is internal');
  print('CupertinoSliverNavigationBar tests passed');

  // ========== CupertinoSegmentedControl ==========
  print('--- CupertinoSegmentedControl Tests ---');
  final segmented = CupertinoSegmentedControl<int>(
    children: const {0: Text('One'), 1: Text('Two'), 2: Text('Three')},
    onValueChanged: (int val) {
      print('selected: $val');
    },
    groupValue: 0,
  );
  print('type: ${segmented.runtimeType}');
  print('CupertinoSegmentedControl theming via CupertinoTheme');
  print('CupertinoSegmentedControl tests passed');

  // ========== CupertinoSlidingSegmentedControl ==========
  print('--- CupertinoSlidingSegmentedControl Tests ---');
  final sliding = CupertinoSlidingSegmentedControl<int>(
    children: const {0: Text('A'), 1: Text('B')},
    onValueChanged: (int? val) {
      print('sliding selected: $val');
    },
    groupValue: 0,
  );
  print('type: ${sliding.runtimeType}');
  print('CupertinoSlidingSegmentedControl tests passed');

  // ========== CupertinoTextSelectionControls ==========
  print('--- CupertinoTextSelectionControls Tests ---');
  final selectionControls = CupertinoTextSelectionControls();
  print('type: ${selectionControls.runtimeType}');
  print('CupertinoTextSelectionControls is a TextSelectionControls impl');
  print('CupertinoTextSelectionHandlePainter is internal/private');
  print('CupertinoTextSelectionControlsTools is not a public API');
  print('CupertinoTextSelectionControls tests passed');

  // ========== CupertinoAdaptiveTheme ==========
  print('--- CupertinoAdaptiveTheme Tests ---');
  final cupertinoTheme = const CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: CupertinoColors.activeBlue,
  );
  print('CupertinoThemeData type: ${cupertinoTheme.runtimeType}');
  print('brightness: ${cupertinoTheme.brightness}');
  print('primaryColor: ${cupertinoTheme.primaryColor}');
  print('CupertinoAdaptiveTheme is accessed via CupertinoTheme widget');
  print('Cupertino adaptive theming tests passed');

  print('All Cupertino misc advanced tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Cupertino Misc Advanced Tests',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text('CupertinoLocalizations: OK'),
            Text('CupertinoPageRoute: OK'),
            Text('showCupertinoModalPopup: referenced'),
            Text('showCupertinoDialog: referenced'),
            Text('CupertinoSliverNavigationBar: OK'),
            Text('CupertinoSegmentedControl: OK'),
            Text('CupertinoSlidingSegmentedControl: OK'),
            Text('CupertinoTextSelectionControls: OK'),
            Text('CupertinoAdaptiveTheme: OK'),
          ],
        ),
      ),
    ),
  );
}
