// D4rt test script: Tests ImageStream from painting
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ImageStream test executing');
  final results = <String>[];

  // ========== Basic ImageStream Tests ==========
  print('Testing ImageStream constructors...');

  // Test 1: Create basic ImageStream
  final stream1 = ImageStream();
  assert(stream1 != null, 'ImageStream should be created');
  results.add('ImageStream created successfully');
  print('ImageStream created');

  // Test 2: Check completer is null initially
  final completer = stream1.completer;
  assert(completer == null, 'Completer should be null initially');
  results.add('Initial completer: ${completer == null ? 'null' : 'present'}');
  print('Initial completer: null');

  // Test 3: Key property
  final key = stream1.key;
  results.add('ImageStream key: $key');
  print('Key: $key');

  // ========== ImageStream Lifecycle Documentation ==========
  print('Documenting ImageStream lifecycle...');

  // Phase 1: Creation
  results.add('Lifecycle 1: ImageStream created empty');
  print('Phase 1: Created');

  // Phase 2: Completer attached
  results.add('Lifecycle 2: ImageStreamCompleter attached via setCompleter');
  print('Phase 2: Completer attached');

  // Phase 3: Listeners added
  results.add('Lifecycle 3: ImageStreamListener(s) added via addListener');
  print('Phase 3: Listeners added');

  // Phase 4: Image delivered
  results.add('Lifecycle 4: ImageInfo delivered to listeners');
  print('Phase 4: Image delivered');

  // Phase 5: Cleanup
  results.add('Lifecycle 5: Listeners removed, resources disposed');
  print('Phase 5: Cleanup');

  // ========== Multiple ImageStream Instances ==========
  print('Testing multiple ImageStream instances...');

  final streams = <ImageStream>[];
  for (var i = 0; i < 5; i++) {
    final stream = ImageStream();
    streams.add(stream);
    results.add('Stream #${i + 1} created: key=${stream.key}');
    print('Stream #${i + 1} created');
  }
  assert(streams.length == 5, 'Should have 5 streams');
  results.add('Total streams created: ${streams.length}');
  print('Total streams: ${streams.length}');

  // ========== ImageStream Methods Documentation ==========
  print('Documenting ImageStream methods...');

  // Method: addListener
  results.add('Method: addListener(ImageStreamListener) - registers listener');
  print('addListener documented');

  // Method: removeListener
  results.add(
    'Method: removeListener(ImageStreamListener) - unregisters listener',
  );
  print('removeListener documented');

  // Method: setCompleter
  results.add(
    'Method: setCompleter(ImageStreamCompleter) - sets the completer',
  );
  print('setCompleter documented');

  // Property: debugLabel
  results.add('Property: debugLabel (String?) - for debugging');
  print('debugLabel documented');

  // ========== ImageStream Properties ==========
  print('Documenting ImageStream properties...');

  // Property: completer
  results.add(
    'Property: completer (ImageStreamCompleter?) - the current completer',
  );
  print('completer property documented');

  // Property: key
  results.add('Property: key (Object?) - cache key for the image');
  print('key property documented');

  // ========== Callback Pattern Documentation ==========
  print('Documenting ImageStream callback patterns...');

  // Callback receives ImageInfo and synchronous flag
  results.add('Callback signature: (ImageInfo info, bool synchronousCall)');
  print('Callback signature documented');

  // synchronousCall indicates if callback is immediate
  results.add('synchronousCall=true: image was already available');
  print('synchronousCall=true documented');

  // synchronousCall=false indicates async delivery
  results.add('synchronousCall=false: image loaded asynchronously');
  print('synchronousCall=false documented');

  // ========== Error Handling Documentation ==========
  print('Documenting error handling...');

  // onError callback
  results.add('Error callback: onError in ImageStreamListener');
  print('onError documented');

  // Error types
  results.add('Error types: NetworkImageLoadException, codec errors, etc.');
  print('Error types documented');

  // Stack trace
  results.add(
    'Error callback receives: (Object exception, StackTrace? stackTrace)',
  );
  print('Stack trace documented');

  // ========== ImageStream Usage Patterns ==========
  print('Documenting usage patterns...');

  // Pattern 1: Widget usage
  results.add('Pattern: Image widget uses ImageStream internally');
  print('Widget pattern documented');

  // Pattern 2: Direct usage
  results.add('Pattern: ImageProvider.resolve() returns ImageStream');
  print('Direct usage documented');

  // Pattern 3: Precaching
  results.add('Pattern: precacheImage() uses ImageStream');
  print('Precaching documented');

  // ========== ImageStream Integration ==========
  print('Documenting ImageStream integration points...');

  results.add('Integration: ImageCache stores ImageStreamCompleter');
  print('ImageCache integration documented');

  results.add('Integration: ImageProvider creates and configures ImageStream');
  print('ImageProvider integration documented');

  results.add('Integration: RenderImage consumes ImageInfo from ImageStream');
  print('RenderImage integration documented');

  // ========== Cleanup Best Practices ==========
  print('Documenting cleanup best practices...');

  results.add('Best practice: Always removeListener in dispose()');
  print('dispose cleanup documented');

  results.add('Best practice: Handle both onImage and onError callbacks');
  print('Error handling documented');

  results.add('Best practice: Check synchronousCall for state management');
  print('State management documented');

  print('ImageStream test completed: ${results.length} tests/docs');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'ImageStream Tests',
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
