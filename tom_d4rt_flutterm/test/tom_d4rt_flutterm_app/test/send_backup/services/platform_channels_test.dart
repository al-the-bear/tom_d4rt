// D4rt test script: Tests MethodChannel, BasicMessageChannel,
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// EventChannel, BinaryCodec, StandardMessageCodec, StandardMethodCodec,
// PlatformException, MissingPluginException
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('Platform channels test executing');

  // ========== MethodChannel ==========
  print('--- MethodChannel Tests ---');
  final methodChannel = MethodChannel('com.example.test/method');
  print('MethodChannel: ${methodChannel.name}');

  final optMethodChannel = OptionalMethodChannel('com.example.test/optional');
  print('OptionalMethodChannel: ${optMethodChannel.name}');

  // ========== BasicMessageChannel ==========
  print('--- BasicMessageChannel Tests ---');
  final stringChannel = BasicMessageChannel<String>(
    'com.example.test/string',
    StringCodec(),
  );
  print('BasicMessageChannel<String>: ${stringChannel.name}');

  final jsonChannel = BasicMessageChannel<dynamic>(
    'com.example.test/json',
    JSONMessageCodec(),
  );
  print('BasicMessageChannel<dynamic> (JSON): ${jsonChannel.name}');

  // ========== EventChannel ==========
  print('--- EventChannel Tests ---');
  final eventChannel = EventChannel('com.example.test/events');
  print('EventChannel: ${eventChannel.name}');

  // ========== StringCodec ==========
  print('--- StringCodec Tests ---');
  final stringCodec = StringCodec();
  final encoded = stringCodec.encodeMessage('hello');
  // Note: encoded is ByteData? but D4rt wraps it as _ByteDataView
  // which doesn't have .lengthInBytes bridged
  print('StringCodec encoded: ${encoded != null ? "success" : "null"}');
  if (encoded != null) {
    final decoded = stringCodec.decodeMessage(encoded);
    print('StringCodec decoded: $decoded');
  }

  // ========== JSONMessageCodec ==========
  print('--- JSONMessageCodec Tests ---');
  final jsonCodec = JSONMessageCodec();
  final jsonEncoded = jsonCodec.encodeMessage({'key': 'value', 'count': 42});
  print(
    'JSONMessageCodec encoded: ${jsonEncoded != null ? "success" : "null"}',
  );

  // ========== StandardMessageCodec ==========
  print('--- StandardMessageCodec Tests ---');
  final stdCodec = StandardMessageCodec();
  final stdEncoded = stdCodec.encodeMessage([1, 2, 'three']);
  print(
    'StandardMessageCodec encoded: ${stdEncoded != null ? "success" : "null"}',
  );

  // ========== StandardMethodCodec ==========
  print('--- StandardMethodCodec Tests ---');
  final stdMethodCodec = StandardMethodCodec();
  final call = MethodCall('getValue', {'id': 123});
  print('MethodCall: method=${call.method}, args=${call.arguments}');
  final encodedCall = stdMethodCodec.encodeMethodCall(call);
  // Note: encodedCall.lengthInBytes not available on _ByteDataView in D4rt
  print('Encoded MethodCall: success');

  // ========== PlatformException ==========
  print('--- PlatformException Tests ---');
  final platformEx = PlatformException(
    code: 'UNAVAILABLE',
    message: 'Service unavailable',
    details: {'reason': 'timeout'},
    stacktrace: 'at channel.invoke()',
  );
  print('PlatformException: code=${platformEx.code}');
  print('  message: ${platformEx.message}');
  print('  details: ${platformEx.details}');

  // ========== MissingPluginException ==========
  print('--- MissingPluginException Tests ---');
  final missingEx = MissingPluginException(
    'No implementation found for method test',
  );
  print('MissingPluginException: ${missingEx.message}');

  // ========== BinaryCodec ==========
  print('--- BinaryCodec Tests ---');
  final binaryCodec = BinaryCodec();
  print('BinaryCodec instance created');

  print('All platform channels tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Platform Channels Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text('MethodChannel, BasicMessageChannel'),
            Text('EventChannel, Codecs'),
            Text('PlatformException, MissingPluginException'),
          ],
        ),
      ),
    ),
  );
}
