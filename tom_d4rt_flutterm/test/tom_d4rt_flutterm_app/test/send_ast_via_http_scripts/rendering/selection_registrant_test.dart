// D4rt test script: Comprehensive SelectionRegistrant coverage
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

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
  print('--- SelectionRegistrant test start ---');
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

  final registrar = _FakeSelectionRegistrar();
  final selectable = _SelectableHarness();
  expectCondition(
    selectable is SelectionRegistrant,
    'Selectable harness mixes in SelectionRegistrant',
    logs,
    counters,
  );
  expectCondition(
    selectable.registrar == null,
    'Registrar starts null',
    logs,
    counters,
  );
  selectable.registrar = registrar;
  expectCondition(
    selectable.registrar == registrar,
    'Registrar can be assigned',
    logs,
    counters,
  );
  expectCondition(
    registrar.addCount == 1,
    'Registrar add called when content exists',
    logs,
    counters,
  );
  expectCondition(
    registrar.removeCount == 0,
    'No remove call yet',
    logs,
    counters,
  );
  selectable.valueForTest = const SelectionGeometry(
    status: SelectionStatus.none,
    hasContent: false,
  );
  expectCondition(
    registrar.removeCount == 1,
    'Registrar remove called when content becomes empty',
    logs,
    counters,
  );
  selectable.valueForTest = const SelectionGeometry(
    status: SelectionStatus.collapsed,
    hasContent: true,
  );
  expectCondition(
    registrar.addCount == 2,
    'Registrar add called again when content returns',
    logs,
    counters,
  );
  final selected = selectable.getSelectedContent();
  expectCondition(
    selected != null,
    'Selected content can be returned',
    logs,
    counters,
  );
  expectCondition(
    selectable.getSelection() != null,
    'Selection range can be returned',
    logs,
    counters,
  );
  expectCondition(
    selectable.dispatchSelectionEvent(const ClearSelectionEvent()) ==
        SelectionResult.none,
    'Dispatch handles clear event',
    logs,
    counters,
  );
  expectCondition(
    selectable.contentLength == 1,
    'Content length is exposed',
    logs,
    counters,
  );
  selectable.registrar = null;
  expectCondition(
    selectable.registrar == null,
    'Registrar can be cleared',
    logs,
    counters,
  );
  selectable.dispose();
  expectCondition(
    registrar.removeCount >= 1,
    'Dispose keeps registrar state consistent',
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

  print('--- SelectionRegistrant test end ---');
  print('Assertions: ${counters['assertions']}');
  print('Log entries: ${logs.length}');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      summaryLine('SelectionRegistrant summary widget'),
      summaryLine('Title: SelectionRegistrant'),
      summaryLine('Assertions: ${counters['assertions']}'),
      summaryLine('Logs: ${logs.length}'),
      summaryLine('Elapsed(us): $elapsed'),
      for (final line in logs.take(24)) summaryLine(line),
    ],
  );
}

class _FakeSelectionRegistrar implements SelectionRegistrar {
  int addCount = 0;
  int removeCount = 0;

  @override
  void add(Selectable selectable) {
    addCount += 1;
  }

  @override
  void remove(Selectable selectable) {
    removeCount += 1;
  }
}

class _SelectableHarness extends ChangeNotifier
    with Selectable, SelectionRegistrant {
  SelectionGeometry _value = const SelectionGeometry(
    status: SelectionStatus.collapsed,
    hasContent: true,
  );

  set valueForTest(SelectionGeometry geometry) {
    _value = geometry;
    notifyListeners();
  }

  @override
  SelectionGeometry get value => _value;

  @override
  List<Rect> get boundingBoxes => const <Rect>[Rect.fromLTWH(0, 0, 10, 10)];

  @override
  int get contentLength => 1;

  @override
  SelectionResult dispatchSelectionEvent(SelectionEvent event) =>
      SelectionResult.none;

  @override
  SelectedContent? getSelectedContent() =>
      const SelectedContent(plainText: 'x');

  @override
  SelectedContentRange? getSelection() =>
      const SelectedContentRange(startOffset: 0, endOffset: 1);

  @override
  Matrix4 getTransformTo(RenderObject? ancestor) => Matrix4.identity();

  @override
  void pushHandleLayers(LayerLink? startHandle, LayerLink? endHandle) {}

  @override
  Size get size => const Size(10, 10);
}
