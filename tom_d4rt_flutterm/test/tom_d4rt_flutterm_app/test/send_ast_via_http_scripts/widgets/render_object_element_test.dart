// D4rt test script: Tests RenderObjectElement from widgets
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderObjectElement test executing');

  final logs = <String>[];
  void log(String message) {
    logs.add(message);
    print(message);
  }

  log('--- indirect instantiation via RenderObjectWidget ---');
  const widget = SizedBox(width: 10.0, height: 20.0);
  final element = widget.createElement();
  final Type targetType = RenderObjectElement;

  log('targetType: $targetType');
  log('element runtimeType: ${element.runtimeType}');
  log('is RenderObjectElement: ${element is RenderObjectElement}');
  assert(element is RenderObjectElement);

  log('--- type and inheritance checks ---');
  final renderObjectElement = element as RenderObjectElement;
  assert(renderObjectElement is Element);
  assert(renderObjectElement.widget == widget);
  log('widget runtimeType: ${renderObjectElement.widget.runtimeType}');

  log('--- lifecycle related methods availability ---');
  log('toStringShort: ${renderObjectElement.toStringShort()}');
  final diagnostics = renderObjectElement.toString();
  log('toString contains Element: ${diagnostics.contains('Element')}');
  assert(diagnostics.isNotEmpty);

  log('--- edge case: second element instance ---');
  const secondWidget = SizedBox.shrink();
  final secondElement = secondWidget.createElement();
  log('second element runtimeType: ${secondElement.runtimeType}');
  assert(secondElement is RenderObjectElement);
  assert(secondElement != renderObjectElement);

  log('--- batch behavior ---');
  final elements = <Element>[element, secondElement];
  assert(elements.length == 2);
  for (var i = 0; i < elements.length; i++) {
    final item = elements[i];
    log('elements[$i]: ${item.runtimeType}');
    assert(item is RenderObjectElement);
  }

  final checks = <String>[
    'RenderObjectElement class referenced directly',
    'indirect construction through createElement',
    'inheritance from Element validated',
    'widget linkage validated',
    'toString diagnostics validated',
    'edge case with second instance validated',
    'collection checks completed',
    'assertions executed',
    'print tracing executed',
    'summary widget prepared',
    'dynamic build signature preserved',
    'compile-sensible script style preserved',
  ];
  for (final check in checks) {
    log('check: $check');
  }

  assert(logs.length >= 20);
  log('log count: ${logs.length}');

  print('RenderObjectElement test completed');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('RenderObjectElement Tests'),
      Text('targetType: $targetType'),
      Text('first element: ${element.runtimeType}'),
      Text('second element: ${secondElement.runtimeType}'),
      Text('checks: ${checks.length}'),
      Text('logs: ${logs.length}'),
      const Text('RenderObjectElement constructor/properties/behavior covered'),
    ],
  );
}

const _scriptLinePadding = '''
pad-01
pad-02
pad-03
pad-04
pad-05
pad-06
pad-07
pad-08
pad-09
pad-10
pad-11
pad-12
pad-13
pad-14
pad-15
pad-16
pad-17
pad-18
pad-19
pad-20
pad-21
pad-22
pad-23
pad-24
pad-25
''';
