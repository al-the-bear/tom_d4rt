// D4rt test script: Comprehensive TreeSliverStateMixin coverage
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/widgets.dart';
import 'package:flutter/src/widgets/sliver_tree.dart';

void expectCondition(
  bool condition,
  String message,
  List<String> logs,
  Map<String, int> counters,
) {
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
  print('--- TreeSliverStateMixin test start ---');
  final logs = <String>[];
  final counters = <String, int>{'assertions': 0};
  final startedAt = DateTime.now();

  expectCondition(
    context is BuildContext,
    'BuildContext is available',
    logs,
    counters,
  );
  expectCondition(
    startedAt.millisecondsSinceEpoch > 0,
    'Start time is valid',
    logs,
    counters,
  );

  final root = TreeSliverNode<int>(
    1,
    children: [TreeSliverNode<int>(2), TreeSliverNode<int>(3)],
  );
  final leaf = TreeSliverNode<int>(4);
  final harness = _TreeStateHarness(<TreeSliverNode<int>>[root, leaf]);
  expectCondition(
    harness.isExpanded(root) == false,
    'Root starts collapsed',
    logs,
    counters,
  );
  harness.toggleNode(root);
  expectCondition(
    harness.isExpanded(root) == true,
    'Root expands after toggle',
    logs,
    counters,
  );
  expectCondition(
    harness.getNodeFor(4) == leaf,
    'Node lookup finds leaf',
    logs,
    counters,
  );
  expectCondition(
    harness.getNodeFor(999) == null,
    'Missing content resolves to null',
    logs,
    counters,
  );
  expectCondition(harness.isActive(root), 'Root is active', logs, counters);
  expectCondition(
    harness.isActive(leaf),
    'Leaf is active with no parent',
    logs,
    counters,
  );
  expectCondition(
    harness.getActiveIndexFor(root) == 0,
    'Root has index 0',
    logs,
    counters,
  );
  harness.expandAll();
  expectCondition(
    harness.isExpanded(root),
    'expandAll keeps root expanded',
    logs,
    counters,
  );
  harness.collapseAll();
  expectCondition(
    harness.isExpanded(root) == false,
    'collapseAll collapses root',
    logs,
    counters,
  );
  for (final node in <TreeSliverNode<int>>[root, leaf]) {
    expectCondition(
      harness.isActive(node),
      'Node ${node.content} remains active',
      logs,
      counters,
    );
  }
  for (var i = 0; i < 10; i++) {
    final current = i.isEven ? root : leaf;
    harness.toggleNode(current);
    expectCondition(
      harness.isExpanded(current) ==
          (i.isEven ? !((i ~/ 2).isOdd) : ((i ~/ 2).isEven)),
      'Toggle sequence updates expansion state',
      logs,
      counters,
    );
  }
  expectCondition(
    harness.nodes.length == 2,
    'Harness stores all nodes',
    logs,
    counters,
  );
  expectCondition(
    harness.nodes.first.content == 1,
    'First node content matches',
    logs,
    counters,
  );
  expectCondition(
    harness.nodes.last.content == 4,
    'Last node content matches',
    logs,
    counters,
  );

  final elapsed = DateTime.now().difference(startedAt).inMicroseconds;
  expectCondition(
    elapsed >= 0,
    'Elapsed measurement is non-negative',
    logs,
    counters,
  );
  expectCondition(
    (counters['assertions'] ?? 0) >= 24,
    'Performed many assertions',
    logs,
    counters,
  );

  print('--- TreeSliverStateMixin test end ---');
  print('Assertions: ${counters['assertions']}');
  print('Log entries: ${logs.length}');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      summaryLine('TreeSliverStateMixin summary widget'),
      summaryLine('Title: TreeSliverStateMixin'),
      summaryLine('Assertions: ${counters['assertions']}'),
      summaryLine('Logs: ${logs.length}'),
      summaryLine('Elapsed(us): $elapsed'),
      for (final line in logs.take(24)) summaryLine(line),
    ],
  );
}

class _TreeStateHarness with TreeSliverStateMixin<int> {
  _TreeStateHarness(List<TreeSliverNode<int>> allNodes) : nodes = allNodes {
    for (var i = 0; i < nodes.length; i++) {
      _indexByNode[nodes[i]] = i;
      _nodeByContent[nodes[i].content] = nodes[i];
    }
  }

  final List<TreeSliverNode<int>> nodes;
  final Set<TreeSliverNode<int>> _expanded = <TreeSliverNode<int>>{};
  final Map<TreeSliverNode<int>, int> _indexByNode =
      <TreeSliverNode<int>, int>{};
  final Map<int, TreeSliverNode<int>> _nodeByContent =
      <int, TreeSliverNode<int>>{};

  @override
  void collapseAll() => _expanded.clear();

  @override
  void expandAll() => _expanded.addAll(nodes);

  @override
  int? getActiveIndexFor(TreeSliverNode<int> node) => _indexByNode[node];

  @override
  TreeSliverNode<int>? getNodeFor(int content) => _nodeByContent[content];

  @override
  bool isActive(TreeSliverNode<int> node) => _indexByNode.containsKey(node);

  @override
  bool isExpanded(TreeSliverNode<int> node) => _expanded.contains(node);

  @override
  void toggleNode(TreeSliverNode<int> node) {
    if (!_expanded.remove(node)) {
      _expanded.add(node);
    }
  }
}
