// D4rt test script: Tests ImageChunkEvent from painting
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ImageChunkEvent test executing');
  final results = <String>[];

  // ========== Basic ImageChunkEvent Tests ==========
  print('Testing ImageChunkEvent constructors...');

  // Test 1: ImageChunkEvent with both values
  final event1 = ImageChunkEvent(
    cumulativeBytesLoaded: 5000,
    expectedTotalBytes: 10000,
  );
  assert(
    event1.cumulativeBytesLoaded == 5000,
    'cumulativeBytesLoaded should be 5000',
  );
  assert(
    event1.expectedTotalBytes == 10000,
    'expectedTotalBytes should be 10000',
  );
  results.add(
    'ImageChunkEvent: loaded=${event1.cumulativeBytesLoaded}, total=${event1.expectedTotalBytes}',
  );
  print('Event1: ${event1.cumulativeBytesLoaded}/${event1.expectedTotalBytes}');

  // Test 2: ImageChunkEvent with null expectedTotalBytes
  final event2 = ImageChunkEvent(
    cumulativeBytesLoaded: 2500,
    expectedTotalBytes: null,
  );
  assert(
    event2.cumulativeBytesLoaded == 2500,
    'cumulativeBytesLoaded should be 2500',
  );
  assert(
    event2.expectedTotalBytes == null,
    'expectedTotalBytes should be null',
  );
  results.add(
    'ImageChunkEvent (unknown total): loaded=${event2.cumulativeBytesLoaded}, total=unknown',
  );
  print('Event2: ${event2.cumulativeBytesLoaded}/unknown');

  // Test 3: Progress calculation
  final progress = event1.expectedTotalBytes != null
      ? (event1.cumulativeBytesLoaded / event1.expectedTotalBytes!) * 100
      : -1;
  assert(progress == 50.0, 'Progress should be 50%');
  results.add('Progress calculation: ${progress.toStringAsFixed(1)}%');
  print('Progress: ${progress.toStringAsFixed(1)}%');

  // ========== Multiple Progress Events Simulation ==========
  print('Simulating download progress events...');

  final totalBytes = 100000;
  final chunkSize = 10000;
  final events = <ImageChunkEvent>[];

  for (var loaded = chunkSize; loaded <= totalBytes; loaded += chunkSize) {
    final event = ImageChunkEvent(
      cumulativeBytesLoaded: loaded,
      expectedTotalBytes: totalBytes,
    );
    events.add(event);
    final pct = (loaded / totalBytes * 100).toStringAsFixed(0);
    results.add('Progress event: $loaded/$totalBytes (${pct}%)');
    print('Progress: ${pct}%');
  }

  assert(events.length == 10, 'Should have 10 progress events');
  results.add('Total progress events: ${events.length}');
  print('Total events: ${events.length}');

  // ========== Edge Cases ==========
  print('Testing edge cases...');

  // Test 4: Zero bytes loaded
  final event3 = ImageChunkEvent(
    cumulativeBytesLoaded: 0,
    expectedTotalBytes: 50000,
  );
  assert(event3.cumulativeBytesLoaded == 0, 'Should allow 0 bytes loaded');
  results.add(
    'Zero loaded: ${event3.cumulativeBytesLoaded}/${event3.expectedTotalBytes}',
  );
  print('Zero loaded event created');

  // Test 5: All bytes loaded
  final event4 = ImageChunkEvent(
    cumulativeBytesLoaded: 50000,
    expectedTotalBytes: 50000,
  );
  final completed = event4.cumulativeBytesLoaded == event4.expectedTotalBytes;
  assert(completed, 'Should detect completion');
  results.add(
    'Completed: ${event4.cumulativeBytesLoaded}/${event4.expectedTotalBytes} (done=$completed)',
  );
  print('Completed event: done=$completed');

  // Test 6: Large file progress
  final largeTotal = 1024 * 1024 * 100; // 100 MB
  final largeLoaded = 1024 * 1024 * 45; // 45 MB
  final event5 = ImageChunkEvent(
    cumulativeBytesLoaded: largeLoaded,
    expectedTotalBytes: largeTotal,
  );
  final largePct =
      (event5.cumulativeBytesLoaded / event5.expectedTotalBytes!) * 100;
  results.add(
    'Large file: ${(largeLoaded / 1024 / 1024).toStringAsFixed(0)}MB/${(largeTotal / 1024 / 1024).toStringAsFixed(0)}MB (${largePct.toStringAsFixed(1)}%)',
  );
  print('Large file progress: ${largePct.toStringAsFixed(1)}%');

  // ========== Byte Size Formatting ==========
  print('Testing byte size formatting...');

  String formatBytes(int bytes) {
    if (bytes < 1024) return '${bytes}B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)}KB';
    if (bytes < 1024 * 1024 * 1024)
      return '${(bytes / 1024 / 1024).toStringAsFixed(1)}MB';
    return '${(bytes / 1024 / 1024 / 1024).toStringAsFixed(1)}GB';
  }

  final byteSizes = [500, 5000, 50000, 500000, 5000000, 50000000];
  for (final size in byteSizes) {
    results.add('Format ${size} bytes: ${formatBytes(size)}');
    print('${size} bytes = ${formatBytes(size)}');
  }

  // ========== Progress Bar Simulation ==========
  print('Simulating progress bar...');

  String progressBar(int loaded, int? total, int width) {
    if (total == null || total == 0) return '[${'?'.padRight(width)}]';
    final pct = loaded / total;
    final filled = (pct * width).round();
    return '[${'='.padLeft(filled, '=').padRight(width, ' ')}] ${(pct * 100).toStringAsFixed(0)}%';
  }

  for (var i = 0; i <= 10; i++) {
    final loaded = i * 1000;
    final bar = progressBar(loaded, 10000, 20);
    results.add('Progress bar: $bar');
    print(bar);
  }

  // ========== Unknown Size Progress ==========
  print('Testing unknown size progress...');

  final unknownEvents = <ImageChunkEvent>[];
  for (var loaded = 10000; loaded <= 50000; loaded += 10000) {
    final event = ImageChunkEvent(
      cumulativeBytesLoaded: loaded,
      expectedTotalBytes: null,
    );
    unknownEvents.add(event);
    results.add('Unknown total: ${formatBytes(loaded)} loaded');
    print('Loaded: ${formatBytes(loaded)}');
  }
  assert(unknownEvents.length == 5, 'Should have 5 unknown events');

  print('ImageChunkEvent test completed: ${results.length} tests passed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'ImageChunkEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      Text('Total tests: ${results.length}', style: TextStyle(fontSize: 14)),
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
