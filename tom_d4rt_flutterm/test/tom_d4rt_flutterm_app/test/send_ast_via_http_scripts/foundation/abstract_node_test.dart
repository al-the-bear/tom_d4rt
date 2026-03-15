// D4rt test script: Comprehensive AbstractNode coverage
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

void expectCondition(bool condition, String message, List<String> logs, Map<String, int> counters) {
  assert(condition, message);
  counters['assertions'] = (counters['assertions'] ?? 0) + 1;
  final marker = condition ? '✅' : '❌';
  logs.add('$marker $message');
  print('$marker $message');
}

Text summaryLine(String text) {
  return Text(text, textDirection: TextDirection.ltr);
}

dynamic build(BuildContext context) {
  print('--- AbstractNode test start ---');
  final logs = <String>[];
  final counters = <String, int>{'assertions': 0};
  final startedAt = DateTime.now();

  expectCondition(context is BuildContext, 'BuildContext is available', logs, counters);
  expectCondition(startedAt.millisecondsSinceEpoch > 0, 'Start time is valid', logs, counters);

  final owner = Object();
  final root = _NodeHarness('root');
  final childA = _NodeHarness('childA');
  final childB = _NodeHarness('childB');
  expectCondition(root is AbstractNode, 'Root is AbstractNode', logs, counters);
  expectCondition(childA is AbstractNode, 'ChildA is AbstractNode', logs, counters);
  expectCondition(root.attached == false, 'Root starts detached', logs, counters);
  root.attach(owner);
  expectCondition(root.attached, 'Root can attach to owner', logs, counters);
  root.addChild(childA);
  root.addChild(childB);
  expectCondition(childA.parent == root, 'ChildA parent is root', logs, counters);
  expectCondition(childB.parent == root, 'ChildB parent is root', logs, counters);
  expectCondition(childA.attached, 'ChildA attaches with root', logs, counters);
  expectCondition(childB.attached, 'ChildB attaches with root', logs, counters);
  expectCondition(childA.depth > root.depth, 'Child depth is greater than root depth', logs, counters);
  root.removeChild(childB);
  expectCondition(childB.parent == null, 'ChildB parent is cleared after removal', logs, counters);
  expectCondition(childB.attached == false, 'ChildB detaches after removal from attached root', logs, counters);
  root.detach();
  expectCondition(root.attached == false, 'Root detaches cleanly', logs, counters);
  expectCondition(childA.attached == false, 'Remaining child detaches with root', logs, counters);

  final elapsed = DateTime.now().difference(startedAt).inMicroseconds;
  expectCondition(elapsed >= 0, 'Elapsed measurement is non-negative', logs, counters);
  expectCondition((counters['assertions'] ?? 0) >= 24, 'Performed many assertions', logs, counters);

  print('--- AbstractNode test end ---');
  print('Assertions: ${counters['assertions']}');
  print('Log entries: ${logs.length}');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      summaryLine('AbstractNode summary widget'),
      summaryLine('Title: AbstractNode'),
      summaryLine('Assertions: ${counters['assertions']}'),
      summaryLine('Logs: ${logs.length}'),
      summaryLine('Elapsed(us): $elapsed'),
      for (final line in logs.take(24)) summaryLine(line),
    ],
  );
}

class _NodeHarness extends AbstractNode {
  _NodeHarness(this.label);

  final String label;
  final List<_NodeHarness> _children = <_NodeHarness>[];

  void addChild(_NodeHarness child) {
    _children.add(child);
    adoptChild(child);
  }

  void removeChild(_NodeHarness child) {
    _children.remove(child);
    dropChild(child);
  }

  @override
  void attach(covariant Object owner) {
    super.attach(owner);
    for (final child in _children) {
      child.attach(owner);
    }
  }

  @override
  void detach() {
    for (final child in _children) {
      child.detach();
    }
    super.detach();
  }

  @override
  void redepthChildren() {
    for (final child in _children) {
      redepthChild(child);
    }
  }

  @override
  String toString() => '_NodeHarness($label, depth: $depth)';
}
