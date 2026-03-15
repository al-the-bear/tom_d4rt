// D4rt comprehensive test script: ScrollViewKeyboardDismissBehavior from widgets
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/widgets.dart';

void _expect(bool condition, String message) {
  if (!condition) {
    print('❌ $message');
    throw StateError('ScrollViewKeyboardDismissBehavior test failed: $message');
  }
  print('✅ $message');
}

String _line(String key, Object value) => '$key: $value';

List<String> _collectDiagnostics(List<ScrollViewKeyboardDismissBehavior> values) {
  final names = values.map((v) => v.name).toList(growable: false);
  final indices = values.map((v) => v.index).toList(growable: false);
  return <String>[
    _line('enum', 'ScrollViewKeyboardDismissBehavior'),
    _line('count', values.length),
    _line('names', names.join(', ')),
    _line('indices', indices.join(', ')),
    _line('first', values.first),
    _line('last', values.last),
  ];
}

dynamic build(BuildContext context) {
  print('========== ScrollViewKeyboardDismissBehavior comprehensive test start ==========' );

  final List<ScrollViewKeyboardDismissBehavior> values = ScrollViewKeyboardDismissBehavior.values.toList(growable: false);
  _expect(values.isNotEmpty, 'ScrollViewKeyboardDismissBehavior exposes at least one enum value');
  _expect(
    values.length == ScrollViewKeyboardDismissBehavior.values.length,
    'ScrollViewKeyboardDismissBehavior.values list length is consistent',
  );

  final ScrollViewKeyboardDismissBehavior first = values.first;
  final ScrollViewKeyboardDismissBehavior last = values.last;

  print(_line('runtimeType', ScrollViewKeyboardDismissBehavior));
  print(_line('firstName', first.name));
  print(_line('firstIndex', first.index));
  print(_line('lastName', last.name));
  print(_line('lastIndex', last.index));
  print(
    'Constructor coverage: enum instances are created by framework internals and validated through values traversal.',
  );

  final List<String> names = values.map((v) => v.name).toList(growable: false);
  final List<int> indices = values.map((v) => v.index).toList(growable: false);
  final Set<String> uniqueNames = names.toSet();
  final Set<int> uniqueIndices = indices.toSet();

  _expect(uniqueNames.length == names.length, 'all enum names are unique');
  _expect(uniqueIndices.length == indices.length, 'all enum indices are unique');
  _expect(indices.first == 0, 'first enum index starts at zero');

  for (final value in values) {
    print('Inspecting value => name=${value.name}, index=${value.index}, raw=$value');
    _expect(
      ScrollViewKeyboardDismissBehavior.values[value.index] == value,
      'index lookup round-trip works for $value',
    );
    _expect(value.toString().contains('.'), 'toString has qualified enum format for $value');
  }

  for (final name in names) {
    final parsed = ScrollViewKeyboardDismissBehavior.values.byName(name);
    _expect(parsed.name == name, 'byName resolves exact name "$name"');
  }

  bool byNameThrows = false;
  try {
    ScrollViewKeyboardDismissBehavior.values.byName('__invalid_enum_name__');
  } catch (error) {
    byNameThrows = true;
    print('Expected byName edge-case error: $error');
  }
  _expect(byNameThrows, 'byName throws on an unknown name');

  bool rangeThrows = false;
  try {
    values[values.length];
  } catch (error) {
    rangeThrows = true;
    print('Expected range edge-case error: $error');
  }
  _expect(rangeThrows, 'list indexing throws for out-of-range access');

  final List<ScrollViewKeyboardDismissBehavior> reversed = values.reversed.toList(growable: false);
  _expect(reversed.first == last, 'reversed list starts with original last');
  _expect(reversed.last == first, 'reversed list ends with original first');

  final List<ScrollViewKeyboardDismissBehavior> sorted = [...values]
    ..sort((a, b) => a.index.compareTo(b.index));
  _expect(sorted.length == values.length, 'sorted list preserves all entries');
  for (var i = 0; i < sorted.length; i++) {
    _expect(sorted[i] == values[i], 'sorted order matches declaration order at index $i');
  }

  final Map<String, ScrollViewKeyboardDismissBehavior> asMap = {
    for (final value in values) value.name: value,
  };
  _expect(asMap.length == values.length, 'name map includes all enum values');
  _expect(asMap[first.name] == first, 'name map resolves first enum value');
  _expect(asMap[last.name] == last, 'name map resolves last enum value');

  final diagnostics = _collectDiagnostics(values);
  print('Diagnostics output:');
  for (final row in diagnostics) {
    print('  $row');
  }

  final String summary = 'ScrollViewKeyboardDismissBehavior checks passed: ${values.length} values validated';
  print(summary);
  print('========== ScrollViewKeyboardDismissBehavior comprehensive test end ==========' );

  return Directionality(
    textDirection: TextDirection.ltr,
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ScrollViewKeyboardDismissBehavior Comprehensive Tests'),
          Text('Count: ${values.length}'),
          Text('First: $first (index: ${first.index})'),
          Text('Last: $last (index: ${last.index})'),
          Text('Unique names: ${uniqueNames.length}'),
          Text('Unique indices: ${uniqueIndices.length}'),
          Text('Summary: $summary'),
        ],
      ),
    ),
  );
}
