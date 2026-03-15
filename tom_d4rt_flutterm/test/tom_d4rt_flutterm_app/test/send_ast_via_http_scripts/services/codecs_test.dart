// D4rt test script: Tests StandardMessageCodec, StandardMethodCodec, JSONMessageCodec, JSONMethodCodec, BinaryCodec, StringCodec from services
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Services codecs test executing');

  // ========== STRINGCODEC ==========
  print('--- StringCodec Tests ---');

  final stringCodec = StringCodec();
  print('StringCodec created');
  print('  runtimeType: ${stringCodec.runtimeType}');

  final encoded = stringCodec.encodeMessage('Hello, D4rt!');
  print('Encoded "Hello, D4rt!": ${encoded != null ? "has data" : "null"}');

  final decoded = stringCodec.decodeMessage(encoded);
  print('Decoded: "$decoded"');

  // Empty string
  final emptyEncoded = stringCodec.encodeMessage('');
  final emptyDecoded = stringCodec.decodeMessage(emptyEncoded);
  print('Empty string round-trip: "$emptyDecoded"');

  // Null message
  final nullDecoded = stringCodec.decodeMessage(null);
  print('Null decode: $nullDecoded');

  // ========== JSONMESSAGECODEC ==========
  print('--- JSONMessageCodec Tests ---');

  final jsonMsgCodec = JSONMessageCodec();
  print('JSONMessageCodec created');
  print('  runtimeType: ${jsonMsgCodec.runtimeType}');

  // Encode/decode string
  final jsonStrEncoded = jsonMsgCodec.encodeMessage('test string');
  final jsonStrDecoded = jsonMsgCodec.decodeMessage(jsonStrEncoded);
  print('String round-trip: "$jsonStrDecoded"');

  // Encode/decode number
  final jsonNumEncoded = jsonMsgCodec.encodeMessage(42);
  final jsonNumDecoded = jsonMsgCodec.decodeMessage(jsonNumEncoded);
  print('Number round-trip: $jsonNumDecoded');

  // Encode/decode map
  final jsonMapEncoded = jsonMsgCodec.encodeMessage({
    'key': 'value',
    'count': 5,
  });
  final jsonMapDecoded = jsonMsgCodec.decodeMessage(jsonMapEncoded);
  print('Map round-trip: $jsonMapDecoded');

  // Encode/decode list
  final jsonListEncoded = jsonMsgCodec.encodeMessage([1, 'two', 3.0, true]);
  final jsonListDecoded = jsonMsgCodec.decodeMessage(jsonListEncoded);
  print('List round-trip: $jsonListDecoded');

  // ========== JSONMETHODCODEC ==========
  print('--- JSONMethodCodec Tests ---');

  final jsonMethodCodec = JSONMethodCodec();
  print('JSONMethodCodec created');
  print('  runtimeType: ${jsonMethodCodec.runtimeType}');

  // Encode method call
  final methodCall = MethodCall('testMethod', {'arg1': 'hello', 'arg2': 42});
  final encodedCall = jsonMethodCodec.encodeMethodCall(methodCall);
  print('Encoded method call: ${encodedCall != null ? "has data" : "null"}');

  // Decode method call
  final decodedCall = jsonMethodCodec.decodeMethodCall(encodedCall);
  print('Decoded method call:');
  print('  method: ${decodedCall.method}');
  print('  arguments: ${decodedCall.arguments}');

  // Encode success envelope
  final successEnv = jsonMethodCodec.encodeSuccessEnvelope('result_value');
  print(
    'Encoded success envelope: ${successEnv != null ? "has data" : "null"}',
  );

  // Decode success envelope
  final decodedSuccess = jsonMethodCodec.decodeEnvelope(successEnv);
  print('Decoded success: $decodedSuccess');

  // ========== STANDARDMESSAGECODEC ==========
  print('--- StandardMessageCodec Tests ---');

  final stdMsgCodec = StandardMessageCodec();
  print('StandardMessageCodec created');
  print('  runtimeType: ${stdMsgCodec.runtimeType}');

  // Encode/decode null
  final nullEncoded = stdMsgCodec.encodeMessage(null);
  final nullDec = stdMsgCodec.decodeMessage(nullEncoded);
  print('Null round-trip: $nullDec');

  // Encode/decode int
  final intEncoded = stdMsgCodec.encodeMessage(12345);
  final intDec = stdMsgCodec.decodeMessage(intEncoded);
  print('Int round-trip: $intDec');

  // Encode/decode double
  final doubleEncoded = stdMsgCodec.encodeMessage(3.14159);
  final doubleDec = stdMsgCodec.decodeMessage(doubleEncoded);
  print('Double round-trip: $doubleDec');

  // Encode/decode string
  final strEncoded = stdMsgCodec.encodeMessage('Standard message');
  final strDec = stdMsgCodec.decodeMessage(strEncoded);
  print('String round-trip: "$strDec"');

  // Encode/decode bool
  final boolEncoded = stdMsgCodec.encodeMessage(true);
  final boolDec = stdMsgCodec.decodeMessage(boolEncoded);
  print('Bool round-trip: $boolDec');

  // Encode/decode list
  final listEncoded = stdMsgCodec.encodeMessage([1, 'two', 3.0]);
  final listDec = stdMsgCodec.decodeMessage(listEncoded);
  print('List round-trip: $listDec');

  // Encode/decode map
  final mapEncoded = stdMsgCodec.encodeMessage({'a': 1, 'b': 'two'});
  final mapDec = stdMsgCodec.decodeMessage(mapEncoded);
  print('Map round-trip: $mapDec');

  // ========== STANDARDMETHODCODEC ==========
  print('--- StandardMethodCodec Tests ---');

  final stdMethodCodec = StandardMethodCodec();
  print('StandardMethodCodec created');
  print('  runtimeType: ${stdMethodCodec.runtimeType}');

  // Encode method call
  final stdCall = MethodCall('getData', [1, 2, 3]);
  final stdEncoded = stdMethodCodec.encodeMethodCall(stdCall);
  print(
    'Encoded standard method call: ${stdEncoded != null ? "has data" : "null"}',
  );

  final stdDecoded = stdMethodCodec.decodeMethodCall(stdEncoded);
  print('Decoded: method=${stdDecoded.method}, args=${stdDecoded.arguments}');

  // Success envelope
  final stdSuccess = stdMethodCodec.encodeSuccessEnvelope({
    'data': [1, 2, 3],
  });
  final stdSuccessDec = stdMethodCodec.decodeEnvelope(stdSuccess);
  print('Success envelope result: $stdSuccessDec');

  // ========== BINARYCODEC ==========
  print('--- BinaryCodec Tests ---');

  final binaryCodec = BinaryCodec();
  print('BinaryCodec created');
  print('  runtimeType: ${binaryCodec.runtimeType}');

  // Binary passes through unchanged
  final bytes = Uint8List.fromList([1, 2, 3, 4, 5]);
  final binaryEncoded = binaryCodec.encodeMessage(bytes.buffer.asByteData());
  print('Binary encoded: ${binaryEncoded != null ? "has data" : "null"}');

  final binaryDecoded = binaryCodec.decodeMessage(binaryEncoded);
  print('Binary decoded: ${binaryDecoded != null ? "has data" : "null"}');

  // ========== RETURN WIDGET ==========
  print('Services codecs test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Services Codecs Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text(
            'Classes Tested:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• StringCodec - string encoding'),
          Text('• JSONMessageCodec - JSON message encoding'),
          Text('• JSONMethodCodec - JSON method call encoding'),
          Text('• StandardMessageCodec - platform message encoding'),
          Text('• StandardMethodCodec - platform method encoding'),
          Text('• BinaryCodec - raw binary pass-through'),
          SizedBox(height: 16.0),

          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFE0F2F1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Codec Round-trip Results:'),
                Text('  String: "$decoded"'),
                Text('  JSON string: "$jsonStrDecoded"'),
                Text('  JSON number: $jsonNumDecoded'),
                Text('  Standard int: $intDec'),
                Text('  Standard double: $doubleDec'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
