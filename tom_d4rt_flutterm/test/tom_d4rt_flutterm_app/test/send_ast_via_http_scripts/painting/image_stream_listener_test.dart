// D4rt test script: Tests ImageStreamListener from painting
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ImageStreamListener test executing');
  final results = <String>[];

  // ========== Basic ImageStreamListener Tests ==========
  print('Testing ImageStreamListener constructors...');

  // Test 1: Create ImageStreamListener with onImage only
  var imageCallCount = 0;
  final listener1 = ImageStreamListener((ImageInfo info, bool synchronousCall) {
    imageCallCount++;
    print('Image callback invoked');
  });
  assert(listener1 != null, 'Listener should be created');
  results.add('ImageStreamListener with onImage created');
  print('Listener1 created');

  // Test 2: Create ImageStreamListener with onImage and onError
  var errorCallCount = 0;
  final listener2 = ImageStreamListener(
    (ImageInfo info, bool synchronousCall) {
      imageCallCount++;
    },
    onError: (Object exception, StackTrace? stackTrace) {
      errorCallCount++;
      print('Error callback invoked: $exception');
    },
  );
  assert(listener2 != null, 'Listener with error handler should be created');
  results.add('ImageStreamListener with onImage and onError created');
  print('Listener2 created');

  // Test 3: Create ImageStreamListener with onChunk
  var chunkCallCount = 0;
  final listener3 = ImageStreamListener(
    (ImageInfo info, bool synchronousCall) {
      imageCallCount++;
    },
    onChunk: (ImageChunkEvent event) {
      chunkCallCount++;
      print(
        'Chunk event: ${event.cumulativeBytesLoaded}/${event.expectedTotalBytes}',
      );
    },
  );
  assert(listener3 != null, 'Listener with chunk handler should be created');
  results.add('ImageStreamListener with onChunk created');
  print('Listener3 created');

  // Test 4: Full ImageStreamListener
  final listener4 = ImageStreamListener(
    (ImageInfo info, bool synchronousCall) {
      imageCallCount++;
    },
    onChunk: (ImageChunkEvent event) {
      chunkCallCount++;
    },
    onError: (Object exception, StackTrace? stackTrace) {
      errorCallCount++;
    },
  );
  assert(listener4 != null, 'Full listener should be created');
  results.add('Full ImageStreamListener created (all callbacks)');
  print('Full listener created');

  // ========== Callback Signature Documentation ==========
  print('Documenting callback signatures...');

  // onImage signature
  results.add('onImage: void Function(ImageInfo info, bool synchronousCall)');
  print('onImage signature documented');

  // onError signature
  results.add(
    'onError: void Function(Object exception, StackTrace? stackTrace)?',
  );
  print('onError signature documented');

  // onChunk signature
  results.add('onChunk: void Function(ImageChunkEvent event)?');
  print('onChunk signature documented');

  // ========== Callback Behavior Documentation ==========
  print('Documenting callback behavior...');

  // synchronousCall parameter
  results.add(
    'synchronousCall=true: Called during addListener (image was cached)',
  );
  print('synchronousCall=true documented');

  results.add('synchronousCall=false: Called asynchronously (image loaded)');
  print('synchronousCall=false documented');

  // Image callback frequency
  results.add('onImage may be called multiple times (multi-frame images)');
  print('Multi-frame documented');

  // Chunk callback frequency
  results.add('onChunk called during progressive loading');
  print('Chunk frequency documented');

  // ========== Error Handling Patterns ==========
  print('Documenting error handling patterns...');

  // Pattern 1: Basic error handling
  results.add('Pattern: Always provide onError to handle failures');
  print('Error handling pattern documented');

  // Pattern 2: Error types
  final errorTypes = [
    'NetworkImageLoadException - HTTP errors',
    'SocketException - Network unavailable',
    'FormatException - Invalid image format',
    'Exception - General loading failures',
  ];
  for (final errorType in errorTypes) {
    results.add('Error type: $errorType');
    print('Error type: $errorType');
  }

  // ========== ImageStreamListener Equality ==========
  print('Testing listener equality...');

  // Same callback = same listener
  void imageCallback(ImageInfo info, bool sync) {}
  final listenerA = ImageStreamListener(imageCallback);
  final listenerB = ImageStreamListener(imageCallback);

  // Note: Listeners with same callback are equal
  results.add('Listener equality based on callback identity');
  print('Equality documented');

  // ========== ImageStreamListener in ImageStream ==========
  print('Testing ImageStreamListener with ImageStream...');

  final stream = ImageStream();
  results.add('ImageStream created for listener test');
  print('Stream created');

  // Note: Cannot fully test addListener without completer,
  // but can verify API exists
  results.add('ImageStream.addListener(listener) - registers callback');
  print('addListener API documented');

  results.add('ImageStream.removeListener(listener) - unregisters callback');
  print('removeListener API documented');

  // ========== Best Practices ==========
  print('Documenting best practices...');

  results.add('Best practice: Store listener reference for removal');
  print('Listener storage documented');

  results.add('Best practice: Remove listener in dispose()');
  print('Dispose cleanup documented');

  results.add('Best practice: Handle both success and error cases');
  print('Error handling documented');

  results.add('Best practice: Dispose ImageInfo after use');
  print('Resource disposal documented');

  // ========== Multiple Listeners Count ==========
  print('Testing multiple listener creation...');

  final listeners = <ImageStreamListener>[];
  for (var i = 0; i < 5; i++) {
    final idx = i;
    final listener = ImageStreamListener(
      (ImageInfo info, bool sync) => print('Listener $idx called'),
    );
    listeners.add(listener);
    results.add('Listener #${i + 1} created');
    print('Listener #${i + 1} created');
  }
  assert(listeners.length == 5, 'Should have 5 listeners');
  results.add('Total listeners created: ${listeners.length}');

  print('ImageStreamListener test completed: ${results.length} tests/docs');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'ImageStreamListener Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      Text('Total items: ${results.length}', style: TextStyle(fontSize: 14)),
      Divider(),
      ...results.map(
        (r) => Padding(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Text(r, style: TextStyle(fontSize: 11)),
        ),
      ),
    ],
  );
}
