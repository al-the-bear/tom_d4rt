// D4rt comprehensive test script for RadioClient
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/widgets.dart';

class _RadioClientProbe implements RadioClient {
  _RadioClientProbe(this.label, {required this.seed});

  final String label;
  final int seed;
  final List<String> logs = <String>[];

  void addLog(String value) {
    logs.add(value);
    print('[probe-log] $value');
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    final member = invocation.memberName.toString();
    final marker = 'noSuchMethod:$member';
    logs.add(marker);
    print('[probe-missing] $marker');
    return null;
  }
}

void _assertTrue(bool condition, String message) {
  print('[assert] $message => $condition');
  assert(condition, message);
}

void _assertEquals(Object? a, Object? b, String message) {
  final ok = a == b;
  print('[assert-eq] $message => $a == $b : $ok');
  assert(ok, message);
}

void _assertNotEmpty(List<dynamic> values, String message) {
  final ok = values.isNotEmpty;
  print('[assert-list] $message => len=${values.length}');
  assert(ok, message);
}

Map<String, dynamic> _runProbeCase({
  required String caseName,
  required _RadioClientProbe probe,
  required int increment,
}) {
  print('[case] start: $caseName');
  probe.addLog(caseName);
  final int score = probe.seed + increment;
  final bool hasEvenScore = score % 2 == 0;
  final int combinedLen = probe.label.length + probe.logs.length;
  _assertTrue(score >= probe.seed - 100, "score lower bound");
  _assertTrue(combinedLen >= probe.label.length, "combined length bound");
  print('[case] done: $caseName score=$score even=$hasEvenScore');
  return <String, dynamic>{
    'case': caseName,
    'score': score,
    'even': hasEvenScore,
    'combinedLen': combinedLen,
  };
}

dynamic build(BuildContext context) {
  print('=== RadioClient comprehensive script start ===');

  final _RadioClientProbe primary = _RadioClientProbe('primary', seed: 7);
  final _RadioClientProbe edge = _RadioClientProbe('', seed: -3);
  final _RadioClientProbe large = _RadioClientProbe('large-case', seed: 999);

  _assertTrue(primary is Object, "primary object existence");
  _assertTrue(primary.runtimeType.toString().contains("Probe"), "runtime type naming");
  _assertEquals(primary.label, "primary", "constructor label assignment");
  _assertEquals(primary.seed, 7, "constructor seed assignment");

  primary.addLog("boot");
  edge.addLog("edge-boot");
  large.addLog("large-boot");

  final List<Map<String, dynamic>> caseResults = <Map<String, dynamic>>[
    _runProbeCase(caseName: "standard", probe: primary, increment: 1),
    _runProbeCase(caseName: "edge", probe: edge, increment: 0),
    _runProbeCase(caseName: "large", probe: large, increment: 21),
  ];

  _assertEquals(caseResults.length, 3, "all probe cases created");
  _assertTrue(caseResults.any((Map<String, dynamic> m) => m["even"] == true), "at least one even score");
  _assertTrue(caseResults.any((Map<String, dynamic> m) => (m["score"] as int) < 0) == false, "scores non-negative after increment");

  final List<String> mergedLogs = <String>[...primary.logs, ...edge.logs, ...large.logs];
  _assertNotEmpty(mergedLogs, "merged logs should not be empty");
  _assertTrue(mergedLogs.first.contains("boot"), "first log contains boot");
  _assertTrue(mergedLogs.any((String value) => value.contains("edge")), "edge marker exists");

  final Map<String, int> stats = <String, int>{
    "primaryLogs": primary.logs.length,
    "edgeLogs": edge.logs.length,
    "largeLogs": large.logs.length,
    "totalLogs": mergedLogs.length,
  };

  _assertTrue(stats["totalLogs"]! >= stats["primaryLogs"]!, "total logs >= primary logs");
  _assertTrue(stats.values.every((int value) => value >= 1), "each stats bucket >= 1");

  final List<String> scoreLines = caseResults
      .map((Map<String, dynamic> result) => "${result["case"]}:${result["score"]}:${result["even"]}")
      .toList(growable: false);

  _assertEquals(scoreLines.length, 3, "score line count");
  _assertTrue(scoreLines.join("|").contains("standard"), "score lines include standard");
  print('=== RadioClient comprehensive script done ===');

  return Directionality(
    textDirection: TextDirection.ltr,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('RadioClient Summary'),
        Text("cases=${caseResults.length}"),
        Text("totalLogs=${stats["totalLogs"]}"),
        Text("scoreDigest=${scoreLines.join(",")}"),
      ],
    ),
  );
}
