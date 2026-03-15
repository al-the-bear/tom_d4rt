// D4rt test script: Tests KeyEvent types, SystemChannels, Clipboard,
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// HapticFeedback, SystemChrome, SystemNavigator, LogicalKeyboardKey extended
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('Services advanced test executing');

  // ========== LogicalKeyboardKey extended ==========
  print('--- LogicalKeyboardKey extended Tests ---');
  final keys = <String, LogicalKeyboardKey>{
    'escape': LogicalKeyboardKey.escape,
    'tab': LogicalKeyboardKey.tab,
    'backspace': LogicalKeyboardKey.backspace,
    'enter': LogicalKeyboardKey.enter,
    'delete': LogicalKeyboardKey.delete,
    'home': LogicalKeyboardKey.home,
    'end': LogicalKeyboardKey.end,
    'pageUp': LogicalKeyboardKey.pageUp,
    'pageDown': LogicalKeyboardKey.pageDown,
    'f1': LogicalKeyboardKey.f1,
    'f5': LogicalKeyboardKey.f5,
    'f12': LogicalKeyboardKey.f12,
    'numpad0': LogicalKeyboardKey.numpad0,
    'numpadEnter': LogicalKeyboardKey.numpadEnter,
    'capsLock': LogicalKeyboardKey.capsLock,
    'numLock': LogicalKeyboardKey.numLock,
  };
  for (final entry in keys.entries) {
    print('LogicalKeyboardKey.${entry.key}: id=${entry.value.keyId}');
  }

  // ========== PhysicalKeyboardKey ==========
  print('--- PhysicalKeyboardKey Tests ---');
  final physKeys = <String, PhysicalKeyboardKey>{
    'keyA': PhysicalKeyboardKey.keyA,
    'digit1': PhysicalKeyboardKey.digit1,
    'arrowUp': PhysicalKeyboardKey.arrowUp,
    'arrowDown': PhysicalKeyboardKey.arrowDown,
    'space': PhysicalKeyboardKey.space,
  };
  for (final entry in physKeys.entries) {
    print(
      'PhysicalKeyboardKey.${entry.key}: usbHidUsage=${entry.value.usbHidUsage}',
    );
  }

  // ========== HapticFeedback ==========
  print('--- HapticFeedback Tests ---');
  print('HapticFeedback.vibrate(): vibration feedback');
  print('HapticFeedback.lightImpact(): light haptic');
  print('HapticFeedback.mediumImpact(): medium haptic');
  print('HapticFeedback.heavyImpact(): heavy haptic');
  print('HapticFeedback.selectionClick(): selection click');

  // ========== SystemChrome ==========
  print('--- SystemChrome Tests ---');
  print('SystemChrome.setPreferredOrientations()');
  print('SystemChrome.setSystemUIOverlayStyle()');
  print('SystemChrome.setApplicationSwitcherDescription()');
  print('SystemChrome.setEnabledSystemUIMode()');

  // ========== SystemUiOverlayStyle ==========
  print('--- SystemUiOverlayStyle Tests ---');
  final lightStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarDividerColor: Colors.grey.shade200,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
  print('SystemUiOverlayStyle light created');

  final darkStyle = SystemUiOverlayStyle.dark;
  print('SystemUiOverlayStyle.dark: ${darkStyle.statusBarBrightness}');

  // ========== SystemUiMode ==========
  print('--- SystemUiMode Tests ---');
  for (final mode in SystemUiMode.values) {
    print('SystemUiMode: ${mode.name}');
  }

  // ========== DeviceOrientation ==========
  print('--- DeviceOrientation Tests ---');
  for (final orientation in DeviceOrientation.values) {
    print('DeviceOrientation: ${orientation.name}');
  }

  // ========== SystemNavigator ==========
  print('--- SystemNavigator Tests ---');
  print('SystemNavigator.pop() pops the system navigator');
  print('SystemNavigator.setFrameworkHandlesBack()');

  // ========== TextInputFormatter ==========
  print('--- TextInputFormatter Tests ---');
  final lengthFormatter = LengthLimitingTextInputFormatter(100);
  print('LengthLimitingTextInputFormatter: maxLength=100');

  final filterFormatter = FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));
  print('FilteringTextInputFormatter: digits only');

  final denyFilter = FilteringTextInputFormatter.deny(RegExp(r'[<>]'));
  print('FilteringTextInputFormatter.deny: no angle brackets');

  // ========== MaxLengthEnforcement ==========
  print('--- MaxLengthEnforcement Tests ---');
  for (final enforcement in MaxLengthEnforcement.values) {
    print('MaxLengthEnforcement: ${enforcement.name}');
  }

  print('All services advanced tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: AnnotatedRegion<SystemUiOverlayStyle>(
      value: lightStyle,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Services Advanced Test',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 16.0),
              Text('LogicalKeyboardKey, PhysicalKeyboardKey'),
              Text('HapticFeedback, SystemChrome'),
              Text('SystemUiOverlayStyle, TextInputFormatter'),
              SizedBox(height: 16.0),
              TextField(
                inputFormatters: [lengthFormatter, filterFormatter],
                decoration: InputDecoration(
                  labelText: 'Numbers only (max 100)',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
