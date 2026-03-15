// D4rt test script: Tests LogicalKeyboardKey, PhysicalKeyboardKey, HardwareKeyboard from services
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Services keyboard test executing');

  // ========== LOGICALKEYBOARDKEY ==========
  print('--- LogicalKeyboardKey Tests ---');

  // Common keys
  final space = LogicalKeyboardKey.space;
  print('LogicalKeyboardKey.space:');
  print('  keyId: ${space.keyId}');
  print('  keyLabel: "${space.keyLabel}"');
  print('  debugName: ${space.debugName}');
  print('  runtimeType: ${space.runtimeType}');

  final enter = LogicalKeyboardKey.enter;
  print('LogicalKeyboardKey.enter:');
  print('  keyId: ${enter.keyId}');
  print('  keyLabel: "${enter.keyLabel}"');
  print('  debugName: ${enter.debugName}');

  final escape = LogicalKeyboardKey.escape;
  print('LogicalKeyboardKey.escape:');
  print('  keyId: ${escape.keyId}');
  print('  keyLabel: "${escape.keyLabel}"');
  print('  debugName: ${escape.debugName}');

  final tab = LogicalKeyboardKey.tab;
  print('LogicalKeyboardKey.tab:');
  print('  keyId: ${tab.keyId}');
  print('  debugName: ${tab.debugName}');

  final backspace = LogicalKeyboardKey.backspace;
  print('LogicalKeyboardKey.backspace:');
  print('  keyId: ${backspace.keyId}');
  print('  debugName: ${backspace.debugName}');

  // Letter keys
  final keyA = LogicalKeyboardKey.keyA;
  print('LogicalKeyboardKey.keyA:');
  print('  keyId: ${keyA.keyId}');
  print('  keyLabel: "${keyA.keyLabel}"');

  final keyZ = LogicalKeyboardKey.keyZ;
  print('LogicalKeyboardKey.keyZ:');
  print('  keyId: ${keyZ.keyId}');
  print('  keyLabel: "${keyZ.keyLabel}"');

  // Number keys
  final digit0 = LogicalKeyboardKey.digit0;
  print('LogicalKeyboardKey.digit0:');
  print('  keyId: ${digit0.keyId}');
  print('  keyLabel: "${digit0.keyLabel}"');

  final digit9 = LogicalKeyboardKey.digit9;
  print('LogicalKeyboardKey.digit9:');
  print('  keyId: ${digit9.keyId}');
  print('  keyLabel: "${digit9.keyLabel}"');

  // Modifier keys
  final shiftLeft = LogicalKeyboardKey.shiftLeft;
  print('LogicalKeyboardKey.shiftLeft:');
  print('  keyId: ${shiftLeft.keyId}');
  print('  debugName: ${shiftLeft.debugName}');

  final controlLeft = LogicalKeyboardKey.controlLeft;
  print('LogicalKeyboardKey.controlLeft:');
  print('  keyId: ${controlLeft.keyId}');
  print('  debugName: ${controlLeft.debugName}');

  final altLeft = LogicalKeyboardKey.altLeft;
  print('LogicalKeyboardKey.altLeft:');
  print('  keyId: ${altLeft.keyId}');
  print('  debugName: ${altLeft.debugName}');

  final metaLeft = LogicalKeyboardKey.metaLeft;
  print('LogicalKeyboardKey.metaLeft:');
  print('  keyId: ${metaLeft.keyId}');
  print('  debugName: ${metaLeft.debugName}');

  // Function keys
  final f1 = LogicalKeyboardKey.f1;
  print('LogicalKeyboardKey.f1:');
  print('  keyId: ${f1.keyId}');
  print('  debugName: ${f1.debugName}');

  final f12 = LogicalKeyboardKey.f12;
  print('LogicalKeyboardKey.f12:');
  print('  keyId: ${f12.keyId}');
  print('  debugName: ${f12.debugName}');

  // Arrow keys
  final arrowUp = LogicalKeyboardKey.arrowUp;
  final arrowDown = LogicalKeyboardKey.arrowDown;
  final arrowLeft = LogicalKeyboardKey.arrowLeft;
  final arrowRight = LogicalKeyboardKey.arrowRight;
  print(
    'Arrow keys: up=${arrowUp.debugName}, down=${arrowDown.debugName}, left=${arrowLeft.debugName}, right=${arrowRight.debugName}',
  );

  // ========== PHYSICALKEYBOARDKEY ==========
  print('--- PhysicalKeyboardKey Tests ---');

  final physKeyA = PhysicalKeyboardKey.keyA;
  print('PhysicalKeyboardKey.keyA:');
  print('  usbHidUsage: ${physKeyA.usbHidUsage}');
  print('  debugName: ${physKeyA.debugName}');
  print('  runtimeType: ${physKeyA.runtimeType}');

  final physSpace = PhysicalKeyboardKey.space;
  print('PhysicalKeyboardKey.space:');
  print('  usbHidUsage: ${physSpace.usbHidUsage}');
  print('  debugName: ${physSpace.debugName}');

  final physEnter = PhysicalKeyboardKey.enter;
  print('PhysicalKeyboardKey.enter:');
  print('  usbHidUsage: ${physEnter.usbHidUsage}');
  print('  debugName: ${physEnter.debugName}');

  final physShiftLeft = PhysicalKeyboardKey.shiftLeft;
  print('PhysicalKeyboardKey.shiftLeft:');
  print('  usbHidUsage: ${physShiftLeft.usbHidUsage}');
  print('  debugName: ${physShiftLeft.debugName}');

  // ========== HARDWAREKEYBOARD ==========
  print('--- HardwareKeyboard Tests ---');

  final hwKeyboard = HardwareKeyboard.instance;
  print('HardwareKeyboard.instance:');
  print('  runtimeType: ${hwKeyboard.runtimeType}');
  print('  physicalKeysPressed: ${hwKeyboard.physicalKeysPressed}');
  print('  logicalKeysPressed: ${hwKeyboard.logicalKeysPressed}');
  print('  lockModesEnabled: ${hwKeyboard.lockModesEnabled}');

  // ========== RETURN WIDGET ==========
  print('Services keyboard test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Services Keyboard Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text(
            'Classes Tested:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• LogicalKeyboardKey - logical key identifiers'),
          Text('• PhysicalKeyboardKey - physical key codes'),
          Text('• HardwareKeyboard - keyboard state'),
          SizedBox(height: 16.0),

          Text('Sample Keys:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFFFF8E1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Logical: space=${space.keyId}, enter=${enter.keyId}'),
                Text('  escape=${escape.keyId}, tab=${tab.keyId}'),
                Text('  keyA="${keyA.keyLabel}", digit0="${digit0.keyLabel}"'),
                SizedBox(height: 8.0),
                Text('Physical: keyA=${physKeyA.usbHidUsage}'),
                Text('  space=${physSpace.usbHidUsage}'),
                Text('  enter=${physEnter.usbHidUsage}'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
