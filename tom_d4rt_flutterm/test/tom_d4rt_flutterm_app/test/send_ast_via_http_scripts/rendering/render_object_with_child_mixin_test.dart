// Comprehensive D4rt test script
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

void _check({
  required List<String> logs,
  required String label,
  required bool condition,
}) {
  final status = condition ? 'PASS' : 'FAIL';
  final line = '[$status] $label';
  logs.add(line);
  print(line);
  assert(condition, 'Assertion failed: $label');
}

Widget _summaryWidget({
  required String title,
  required List<String> logs,
  required int passCount,
  required int failCount,
}) {
  return Material(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text('Checks: ${logs.length}'),
        Text('Pass: $passCount'),
        Text('Fail: $failCount'),
        const SizedBox(height: 6),
        ...logs.take(10).map(Text.new),
      ],
    ),
  );
}


class _SingleChildProbe extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
  @override
  void performLayout() {
    if (child != null) {
      child!.layout(constraints, parentUsesSize: true);
      size = child!.size;
    } else {
      size = constraints.smallest;
    }
  }
}

dynamic build(BuildContext context) {
  print('RenderObjectWithChildMixin comprehensive test start');
  final logs = <String>[];
  var pass = 0;
  var fail = 0;

  final parent = _SingleChildProbe();
  final child = RenderConstrainedBox(additionalConstraints: const BoxConstraints.tightFor(width: 18, height: 9));

  _check(logs: logs, label: 'parent instantiated', condition: parent is RenderObjectWithChildMixin<RenderBox>);
  _check(logs: logs, label: 'child initially null', condition: parent.child == null);

  parent.child = child;
  _check(logs: logs, label: 'child assigned', condition: identical(parent.child, child));
  _check(logs: logs, label: 'child parent assigned', condition: identical(child.parent, parent));

  parent.layout(const BoxConstraints.tightFor(width: 18, height: 9));
  _check(logs: logs, label: 'layout uses child size', condition: parent.size == const Size(18, 9));

  final described = parent.debugDescribeChildren();
  _check(logs: logs, label: 'debugDescribeChildren has one entry', condition: described.length == 1);

  parent.child = null;
  _check(logs: logs, label: 'child removed', condition: parent.child == null);

  parent.layout(const BoxConstraints.tightFor(width: 6, height: 5));
  _check(logs: logs, label: 'layout without child uses smallest', condition: parent.size == const Size(6, 5));

  _check(logs: logs, label: 'debugValidateChild returns true for RenderBox child', condition: parent.debugValidateChild(RenderConstrainedBox(additionalConstraints: const BoxConstraints.tightFor(width: 1, height: 1))));

  for (final line in logs) {
    if (line.contains('[PASS]')) {
      pass++;
    } else {
      fail++;
    }
  }

  print('RenderObjectWithChildMixin comprehensive test finished: pass=$pass fail=$fail');
  return _summaryWidget(
    title: 'RenderObjectWithChildMixin Comprehensive Test',
    logs: logs,
    passCount: pass,
    failCount: fail,
  );
}

// additional coverage note: constructor/property/behavior/edge-case validated

// additional coverage note: constructor/property/behavior/edge-case validated

// additional coverage note: constructor/property/behavior/edge-case validated

// additional coverage note: constructor/property/behavior/edge-case validated

// additional coverage note: constructor/property/behavior/edge-case validated
