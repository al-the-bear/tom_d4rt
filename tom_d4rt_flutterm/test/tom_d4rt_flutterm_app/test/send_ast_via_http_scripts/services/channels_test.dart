// D4rt test script: Tests BasicMessageChannel, EventChannel, OptionalMethodChannel, MethodChannel, MethodCall from services
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Services channels test executing');

  // ========== METHODCALL ==========
  print('--- MethodCall Tests ---');

  final call1 = MethodCall('testMethod');
  print('MethodCall("testMethod"):');
  print('  method: ${call1.method}');
  print('  arguments: ${call1.arguments}');
  print('  runtimeType: ${call1.runtimeType}');

  final call2 = MethodCall('getData', {'id': 42, 'name': 'test'});
  print('MethodCall("getData", {id: 42, name: "test"}):');
  print('  method: ${call2.method}');
  print('  arguments: ${call2.arguments}');

  final call3 = MethodCall('processList', [1, 2, 3, 'four']);
  print('MethodCall("processList", [1, 2, 3, "four"]):');
  print('  method: ${call3.method}');
  print('  arguments: ${call3.arguments}');

  final callNoArgs = MethodCall('ping');
  print('MethodCall("ping"):');
  print('  method: ${callNoArgs.method}');
  print('  arguments: ${callNoArgs.arguments}');

  // MethodCall toString
  print('MethodCall.toString: ${call2.toString()}');

  // ========== METHODCHANNEL ==========
  print('--- MethodChannel Tests ---');

  final methodChannel = MethodChannel('com.example.test/method');
  print('MethodChannel created');
  print('  name: ${methodChannel.name}');
  print('  codec: ${methodChannel.codec.runtimeType}');
  print('  runtimeType: ${methodChannel.runtimeType}');

  final methodChannel2 = MethodChannel(
    'com.example.test/custom',
    JSONMethodCodec(),
  );
  print('MethodChannel with JSONMethodCodec:');
  print('  name: ${methodChannel2.name}');
  print('  codec: ${methodChannel2.codec.runtimeType}');

  // Set method call handler
  methodChannel.setMethodCallHandler((MethodCall call) async {
    print('  Handler received: ${call.method}');
    return 'response';
  });
  print('Method call handler set');

  // ========== OPTIONALMETHODCHANNEL ==========
  print('--- OptionalMethodChannel Tests ---');

  final optionalChannel = OptionalMethodChannel('com.example.test/optional');
  print('OptionalMethodChannel created');
  print('  name: ${optionalChannel.name}');
  print('  codec: ${optionalChannel.codec.runtimeType}');
  print('  runtimeType: ${optionalChannel.runtimeType}');

  // ========== BASICMESSAGECHANNEL ==========
  print('--- BasicMessageChannel Tests ---');

  final basicChannel = BasicMessageChannel<String>(
    'com.example.test/basic',
    StringCodec(),
  );
  print('BasicMessageChannel<String> created');
  print('  name: ${basicChannel.name}');
  print('  codec: ${basicChannel.codec.runtimeType}');
  print('  runtimeType: ${basicChannel.runtimeType}');

  final jsonBasicChannel = BasicMessageChannel<dynamic>(
    'com.example.test/json_basic',
    JSONMessageCodec(),
  );
  print('BasicMessageChannel<dynamic> with JSON created');
  print('  name: ${jsonBasicChannel.name}');
  print('  codec: ${jsonBasicChannel.codec.runtimeType}');

  // Set message handler
  basicChannel.setMessageHandler((String? message) async {
    print('  Basic handler received: $message');
    return 'reply';
  });
  print('Basic message handler set');

  // ========== EVENTCHANNEL ==========
  print('--- EventChannel Tests ---');

  final eventChannel = EventChannel('com.example.test/events');
  print('EventChannel created');
  print('  name: ${eventChannel.name}');
  print('  codec: ${eventChannel.codec.runtimeType}');
  print('  runtimeType: ${eventChannel.runtimeType}');

  final jsonEventChannel = EventChannel(
    'com.example.test/json_events',
    JSONMethodCodec(),
  );
  print('EventChannel with JSONMethodCodec:');
  print('  name: ${jsonEventChannel.name}');
  print('  codec: ${jsonEventChannel.codec.runtimeType}');

  // ========== CHANNEL NAMING CONVENTIONS ==========
  print('--- Channel Naming Conventions ---');

  print('Platform channels use reverse domain naming:');
  print('  com.example.app/method_name');
  print('  io.flutter.plugins/plugin_name');
  print('Common Flutter channels:');
  print('  flutter/platform - platform events');
  print('  flutter/navigation - route navigation');
  print('  flutter/lifecycle - app lifecycle');

  // ========== RETURN WIDGET ==========
  print('Services channels test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Services Channels Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text(
            'Classes Tested:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• MethodCall - method invocation data'),
          Text('• MethodChannel - bidirectional method calls'),
          Text('• OptionalMethodChannel - nullable methods'),
          Text('• BasicMessageChannel - simple messaging'),
          Text('• EventChannel - event streams'),
          SizedBox(height: 16.0),

          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFF3E5F5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Channel Names:'),
                Text('  MethodChannel: ${methodChannel.name}'),
                Text('  OptionalMethodChannel: ${optionalChannel.name}'),
                Text('  BasicMessageChannel: ${basicChannel.name}'),
                Text('  EventChannel: ${eventChannel.name}'),
                SizedBox(height: 8.0),
                Text('MethodCall: ${call2.method}(${call2.arguments})'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
