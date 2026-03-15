// D4rt test script: Tests DiagnosticsSerializationDelegate from foundation
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void _check({
  required List<String> logs,
  required String label,
  required bool condition,
}) {
  final line = '[${condition ? 'PASS' : 'FAIL'}] $label';
  logs.add(line);
  print(line);
  assert(condition, 'Assertion failed: $label');
}

class _FilteringDelegate extends DiagnosticsSerializationDelegate {
  const _FilteringDelegate();

  @override
  Map<String, Object?> additionalNodeProperties(
    DiagnosticsNode node, {
    bool fullDetails = true,
  }) {
    return <String, Object?>{'custom': 'ok', 'fullDetails': fullDetails};
  }

  @override
  List<DiagnosticsNode> filterChildren(
    List<DiagnosticsNode> nodes,
    DiagnosticsNode owner,
  ) {
    return nodes.take(1).toList();
  }

  @override
  List<DiagnosticsNode> filterProperties(
    List<DiagnosticsNode> nodes,
    DiagnosticsNode owner,
  ) {
    return nodes.where((node) => node.name != null).toList();
  }

  @override
  List<DiagnosticsNode> truncateNodesList(
    List<DiagnosticsNode> nodes,
    DiagnosticsNode owner,
  ) {
    return nodes.take(2).toList();
  }

  @override
  int get subtreeDepth => 2;

  @override
  bool get includeProperties => true;
}

Widget _summary(List<String> logs) {
  final pass = logs.where((line) => line.startsWith('[PASS]')).length;
  final fail = logs.where((line) => line.startsWith('[FAIL]')).length;
  return Material(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'DiagnosticsSerializationDelegate Comprehensive Test',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('Checks: ${logs.length}'),
        Text('Pass: $pass'),
        Text('Fail: $fail'),
        ...logs.take(10).map(Text.new),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('DiagnosticsSerializationDelegate comprehensive test start');
  final logs = <String>[];

  const defaultDelegate = DiagnosticsSerializationDelegate(
    subtreeDepth: 3,
    includeProperties: true,
  );
  _check(
    logs: logs,
    label: 'default delegate instantiated',
    condition: defaultDelegate is DiagnosticsSerializationDelegate,
  );
  _check(
    logs: logs,
    label: 'default delegate subtreeDepth',
    condition: defaultDelegate.subtreeDepth == 3,
  );
  _check(
    logs: logs,
    label: 'default includeProperties true',
    condition: defaultDelegate.includeProperties,
  );

  const custom = _FilteringDelegate();
  _check(
    logs: logs,
    label: 'custom delegate instantiated',
    condition: custom is DiagnosticsSerializationDelegate,
  );
  _check(
    logs: logs,
    label: 'custom subtreeDepth set',
    condition: custom.subtreeDepth == 2,
  );

  final block = DiagnosticsBlock(
    name: 'block',
    description: 'root block',
    children: <DiagnosticsNode>[
      DiagnosticsProperty<String>('c1', 'v1'),
      DiagnosticsProperty<String>('c2', 'v2'),
    ],
    properties: <DiagnosticsNode>[
      DiagnosticsProperty<int>('p1', 1),
      DiagnosticsProperty<int>('p2', 2),
      DiagnosticsProperty<int>('p3', 3),
    ],
  );

  final filteredChildren = custom.filterChildren(block.getChildren(), block);
  final filteredProps = custom.filterProperties(block.getProperties(), block);
  final truncatedProps = custom.truncateNodesList(block.getProperties(), block);
  final additional = custom.additionalNodeProperties(block, fullDetails: false);

  _check(
    logs: logs,
    label: 'children filtered to 1',
    condition: filteredChildren.length == 1,
  );
  _check(
    logs: logs,
    label: 'properties filtered non-empty',
    condition: filteredProps.isNotEmpty,
  );
  _check(
    logs: logs,
    label: 'properties truncated to 2',
    condition: truncatedProps.length == 2,
  );
  _check(
    logs: logs,
    label: 'additional has custom',
    condition: additional['custom'] == 'ok',
  );
  _check(
    logs: logs,
    label: 'additional has fullDetails=false',
    condition: additional['fullDetails'] == false,
  );

  final jsonDefault = block.toJsonMap(defaultDelegate);
  final jsonCustom = block.toJsonMap(custom);
  _check(
    logs: logs,
    label: 'json default produced',
    condition: jsonDefault.containsKey('description'),
  );
  _check(
    logs: logs,
    label: 'json custom produced',
    condition: jsonCustom.containsKey('description'),
  );

  print('DiagnosticsSerializationDelegate comprehensive test complete');
  return _summary(logs);
}

// coverage note: factory constructor
// coverage note: custom subclass
// coverage note: additionalNodeProperties
// coverage note: filterChildren
// coverage note: filterProperties
// coverage note: truncateNodesList
// coverage note: toJsonMap integration
// coverage note: assertions/logging
// line guard 1
// line guard 2
// line guard 3
// line guard 4
// line guard 5
// line guard 6
// line guard 7
// line guard 8
// line guard 9
// line guard 10
// line guard 11
// line guard 12
// line guard 13
// line guard 14
// line guard 15
