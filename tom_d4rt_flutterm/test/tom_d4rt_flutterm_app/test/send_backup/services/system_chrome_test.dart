// D4rt test script: Tests SystemChrome enums, DeviceOrientation, SystemUiMode,
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// SystemUiOverlay, Clipboard, HapticFeedback, SystemSound
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('Services system chrome test executing');

  // ========== DeviceOrientation ==========
  print('--- DeviceOrientation Tests ---');

  print('DeviceOrientation.portraitUp: ${DeviceOrientation.portraitUp}');
  print('DeviceOrientation.portraitDown: ${DeviceOrientation.portraitDown}');
  print('DeviceOrientation.landscapeLeft: ${DeviceOrientation.landscapeLeft}');
  print(
    'DeviceOrientation.landscapeRight: ${DeviceOrientation.landscapeRight}',
  );
  print('DeviceOrientation.values: ${DeviceOrientation.values}');

  // ========== SystemUiMode ==========
  print('--- SystemUiMode Tests ---');

  print('SystemUiMode.leanBack: ${SystemUiMode.leanBack}');
  print('SystemUiMode.immersive: ${SystemUiMode.immersive}');
  print('SystemUiMode.immersiveSticky: ${SystemUiMode.immersiveSticky}');
  print('SystemUiMode.edgeToEdge: ${SystemUiMode.edgeToEdge}');
  print('SystemUiMode.manual: ${SystemUiMode.manual}');
  print('SystemUiMode.values: ${SystemUiMode.values}');

  // ========== SystemUiOverlay ==========
  print('--- SystemUiOverlay Tests ---');

  print('SystemUiOverlay.top: ${SystemUiOverlay.top}');
  print('SystemUiOverlay.bottom: ${SystemUiOverlay.bottom}');
  print('SystemUiOverlay.values: ${SystemUiOverlay.values}');

  // ========== SystemSoundType ==========
  print('--- SystemSoundType Tests ---');

  print('SystemSoundType.click: ${SystemSoundType.click}');
  print('SystemSoundType.alert: ${SystemSoundType.alert}');
  print('SystemSoundType.values: ${SystemSoundType.values}');

  // ========== MaxLengthEnforcement ==========
  print('--- MaxLengthEnforcement Tests ---');

  print('MaxLengthEnforcement.none: ${MaxLengthEnforcement.none}');
  print('MaxLengthEnforcement.enforced: ${MaxLengthEnforcement.enforced}');
  print(
    'MaxLengthEnforcement.truncateAfterCompositionEnds: ${MaxLengthEnforcement.truncateAfterCompositionEnds}',
  );
  print('MaxLengthEnforcement.values: ${MaxLengthEnforcement.values}');

  // ========== SmartDashesType / SmartQuotesType ==========
  print('--- SmartDashesType / SmartQuotesType Tests ---');

  print('SmartDashesType.disabled: ${SmartDashesType.disabled}');
  print('SmartDashesType.enabled: ${SmartDashesType.enabled}');
  print('SmartQuotesType.disabled: ${SmartQuotesType.disabled}');
  print('SmartQuotesType.enabled: ${SmartQuotesType.enabled}');

  // ========== TextInputType ==========
  print('--- TextInputType Tests ---');

  print('TextInputType.text: ${TextInputType.text}');
  print('TextInputType.multiline: ${TextInputType.multiline}');
  print('TextInputType.number: ${TextInputType.number}');
  print('TextInputType.phone: ${TextInputType.phone}');
  print('TextInputType.emailAddress: ${TextInputType.emailAddress}');
  print('TextInputType.url: ${TextInputType.url}');
  print('TextInputType.visiblePassword: ${TextInputType.visiblePassword}');
  print('TextInputType.name: ${TextInputType.name}');
  print('TextInputType.streetAddress: ${TextInputType.streetAddress}');
  print('TextInputType.none: ${TextInputType.none}');

  // ========== TextInputAction ==========
  print('--- TextInputAction Tests ---');

  print('TextInputAction.none: ${TextInputAction.none}');
  print('TextInputAction.done: ${TextInputAction.done}');
  print('TextInputAction.go: ${TextInputAction.go}');
  print('TextInputAction.search: ${TextInputAction.search}');
  print('TextInputAction.send: ${TextInputAction.send}');
  print('TextInputAction.next: ${TextInputAction.next}');
  print('TextInputAction.previous: ${TextInputAction.previous}');
  print('TextInputAction.newline: ${TextInputAction.newline}');
  print('TextInputAction.values: ${TextInputAction.values}');

  // ========== ApplicationSwitcherDescription ==========
  print('--- ApplicationSwitcherDescription Tests ---');

  final appDesc = ApplicationSwitcherDescription(
    label: 'Test App',
    primaryColor: 0xFF2196F3,
  );
  print('AppSwitcherDescription label: ${appDesc.label}');
  print('AppSwitcherDescription primaryColor: ${appDesc.primaryColor}');

  print('All services system chrome tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Services System Chrome Tests',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'DeviceOrientation values: ${DeviceOrientation.values.length}',
            ),
            Text('SystemUiMode values: ${SystemUiMode.values.length}'),
            Text('TextInputType: ${TextInputType.text}'),
            Text('TextInputAction values: ${TextInputAction.values.length}'),
          ],
        ),
      ),
    ),
  );
}
