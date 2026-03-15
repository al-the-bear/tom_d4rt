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


class _ContainerParentData extends ContainerBoxParentData<RenderBox> {}

class _ContainerProbe extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _ContainerParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _ContainerParentData> {
  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! _ContainerParentData) {
      child.parentData = _ContainerParentData();
    }
  }

  @override
  void performLayout() {
    size = constraints.biggest;
    var child = firstChild;
    var dx = 0.0;
    while (child != null) {
      child.layout(BoxConstraints.loose(size), parentUsesSize: true);
      final pd = child.parentData! as _ContainerParentData;
      pd.offset = Offset(dx, 0);
      dx += child.size.width;
      child = pd.nextSibling;
    }
  }
}

dynamic build(BuildContext context) {
  print('RenderBoxContainerDefaultsMixin comprehensive test start');
  final logs = <String>[];
  var pass = 0;
  var fail = 0;

  final parent = _ContainerProbe();
  final c1 = RenderConstrainedBox(additionalConstraints: const BoxConstraints.tightFor(width: 10, height: 8));
  final c2 = RenderConstrainedBox(additionalConstraints: const BoxConstraints.tightFor(width: 12, height: 9));

  parent.add(c1);
  parent.add(c2);

  _check(logs: logs, label: 'parent mixes RenderBoxContainerDefaultsMixin', condition: parent is RenderBoxContainerDefaultsMixin<RenderBox, _ContainerParentData>);
  _check(logs: logs, label: 'children added', condition: parent.childCount == 2);

  parent.layout(const BoxConstraints.tightFor(width: 50, height: 20));
  _check(logs: logs, label: 'parent layout size assigned', condition: parent.size == const Size(50, 20));

  final list = parent.getChildrenAsList();
  _check(logs: logs, label: 'getChildrenAsList length', condition: list.length == 2);
  _check(logs: logs, label: 'child order preserved', condition: identical(list.first, c1) && identical(list.last, c2));

  final hit = BoxHitTestResult();
  final isHit = parent.defaultHitTestChildren(hit, position: const Offset(1, 1));
  _check(logs: logs, label: 'defaultHitTestChildren returns bool', condition: isHit is bool);

  final baseline = parent.defaultComputeDistanceToFirstActualBaseline(TextBaseline.alphabetic);
  _check(logs: logs, label: 'baseline computation executes', condition: baseline == null || baseline >= 0);

  parent.remove(c1);
  _check(logs: logs, label: 'remove child updates count', condition: parent.childCount == 1);

  parent.removeAll();
  _check(logs: logs, label: 'removeAll empties children', condition: parent.childCount == 0);

  for (final line in logs) {
    if (line.contains('[PASS]')) {
      pass++;
    } else {
      fail++;
    }
  }

  print('RenderBoxContainerDefaultsMixin comprehensive test finished: pass=$pass fail=$fail');
  return _summaryWidget(
    title: 'RenderBoxContainerDefaultsMixin Comprehensive Test',
    logs: logs,
    passCount: pass,
    failCount: fail,
  );
}
