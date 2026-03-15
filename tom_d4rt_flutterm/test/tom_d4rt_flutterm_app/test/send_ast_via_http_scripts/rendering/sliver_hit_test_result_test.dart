// D4rt test script: Tests SliverHitTestResult from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// Test RenderSliver for hit testing
class TestRenderSliver extends RenderSliver {
  final String name;
  TestRenderSliver(this.name);

  @override
  void performLayout() {
    geometry = SliverGeometry(
      scrollExtent: 100.0,
      paintExtent: 100.0,
      maxPaintExtent: 100.0,
    );
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) =>
      'TestRenderSliver($name)';
}

dynamic build(BuildContext context) {
  print('SliverHitTestResult test executing');
  final results = <String>[];

  // ========== Section 1: Basic Construction ==========
  print('--- Section 1: Basic Construction ---');

  final hitResult = SliverHitTestResult();
  print('Created SliverHitTestResult: ${hitResult.runtimeType}');
  print('Initial path length: ${hitResult.path.length}');
  results.add('SliverHitTestResult created');

  // ========== Section 2: Adding Entries ==========
  print('--- Section 2: Adding Entries ---');

  final sliver = TestRenderSliver('test-sliver');
  final entry = SliverHitTestEntry(
    sliver,
    mainAxisPosition: 50.0,
    crossAxisPosition: 25.0,
  );

  hitResult.add(entry);
  print('After adding entry, path length: ${hitResult.path.length}');
  results.add('Path length after add: ${hitResult.path.length}');

  // ========== Section 3: Path Iteration ==========
  print('--- Section 3: Path Iteration ---');

  final multiResult = SliverHitTestResult();
  final slivers = [
    TestRenderSliver('sliver-1'),
    TestRenderSliver('sliver-2'),
    TestRenderSliver('sliver-3'),
  ];

  for (var i = 0; i < slivers.length; i++) {
    multiResult.add(
      SliverHitTestEntry(
        slivers[i],
        mainAxisPosition: 10.0 * i,
        crossAxisPosition: 5.0 * i,
      ),
    );
  }

  print('Added ${slivers.length} entries');
  print('Path contains:');
  for (final e in multiResult.path) {
    if (e is SliverHitTestEntry) {
      print(
        '  - ${e.target}: main=${e.mainAxisPosition}, cross=${e.crossAxisPosition}',
      );
    }
  }
  results.add('Path iteration: ${multiResult.path.length} entries');

  // ========== Section 4: HitTestResult Base Class ==========
  print('--- Section 4: HitTestResult Base Class ---');

  print('hitResult is HitTestResult: ${hitResult is HitTestResult}');
  results.add('Is HitTestResult: ${hitResult is HitTestResult}');

  // ========== Section 5: First Entry Access ==========
  print('--- Section 5: First Entry Access ---');

  if (hitResult.path.isNotEmpty) {
    final first = hitResult.path.first;
    print('First entry type: ${first.runtimeType}');
    if (first is SliverHitTestEntry) {
      print('First entry mainAxisPosition: ${first.mainAxisPosition}');
      print('First entry crossAxisPosition: ${first.crossAxisPosition}');
    }
  }
  results.add('First entry accessed');

  // ========== Section 6: Multiple Adds ==========
  print('--- Section 6: Multiple Adds ---');

  final accumulatedResult = SliverHitTestResult();

  for (var i = 0; i < 5; i++) {
    accumulatedResult.add(
      SliverHitTestEntry(
        TestRenderSliver('batch-$i'),
        mainAxisPosition: i * 20.0,
        crossAxisPosition: i * 10.0,
      ),
    );
    print('After add $i: path length = ${accumulatedResult.path.length}');
  }
  results.add('Accumulated 5 entries');

  // ========== Section 7: Empty Result Check ==========
  print('--- Section 7: Empty Result Check ---');

  final emptyResult = SliverHitTestResult();
  print('Empty result path.isEmpty: ${emptyResult.path.isEmpty}');
  print('Empty result path.length: ${emptyResult.path.length}');
  results.add('Empty result checked');

  // ========== Section 8: addWithAxisOffset ==========
  print('--- Section 8: addWithAxisOffset ---');

  final axisResult = SliverHitTestResult();
  final testSliver = TestRenderSliver('axis-test');

  axisResult.addWithAxisOffset(
    paintOffset: Offset(10, 20),
    mainAxisOffset: 5.0,
    crossAxisOffset: 2.5,
    mainAxisPosition: 50.0,
    crossAxisPosition: 25.0,
    hitTest:
        (
          SliverHitTestResult result, {
          required double mainAxisPosition,
          required double crossAxisPosition,
        }) {
          print('  addWithAxisOffset callback:');
          print('    mainAxisPosition: $mainAxisPosition');
          print('    crossAxisPosition: $crossAxisPosition');
          result.add(
            SliverHitTestEntry(
              testSliver,
              mainAxisPosition: mainAxisPosition,
              crossAxisPosition: crossAxisPosition,
            ),
          );
          return true;
        },
  );

  print('After addWithAxisOffset, path length: ${axisResult.path.length}');
  results.add('addWithAxisOffset tested');

  // ========== Section 9: Wrap from BoxHitTestResult ==========
  print('--- Section 9: Wrap from BoxHitTestResult ---');

  final boxResult = BoxHitTestResult();
  final wrappedResult = SliverHitTestResult.wrap(boxResult);

  print('Wrapped SliverHitTestResult: ${wrappedResult.runtimeType}');
  print('Wrapped result path: ${wrappedResult.path.length}');
  results.add('Wrap from BoxHitTestResult tested');

  // ========== Section 10: Complex Scenario ==========
  print('--- Section 10: Complex Scenario ---');

  final complexResult = SliverHitTestResult();

  // Simulate a nested sliver structure
  final parentSliver = TestRenderSliver('parent');
  final child1 = TestRenderSliver('child-1');
  final child2 = TestRenderSliver('child-2');

  complexResult.add(
    SliverHitTestEntry(
      parentSliver,
      mainAxisPosition: 0.0,
      crossAxisPosition: 0.0,
    ),
  );
  complexResult.add(
    SliverHitTestEntry(child1, mainAxisPosition: 50.0, crossAxisPosition: 0.0),
  );
  complexResult.add(
    SliverHitTestEntry(child2, mainAxisPosition: 100.0, crossAxisPosition: 0.0),
  );

  print('Complex scenario path length: ${complexResult.path.length}');
  print('Hit test path (parent to child):');
  var index = 0;
  for (final e in complexResult.path) {
    if (e is SliverHitTestEntry) {
      print('  [$index] ${e.target}: main=${e.mainAxisPosition}');
      index++;
    }
  }
  results.add('Complex scenario: ${complexResult.path.length} entries');

  // ========== Section 11: Path as Iterable ==========
  print('--- Section 11: Path as Iterable ---');

  final iterableCount = complexResult.path
      .where((e) => e is SliverHitTestEntry)
      .length;
  print('SliverHitTestEntry count in path: $iterableCount');

  final mainAxisSum = complexResult.path
      .whereType<SliverHitTestEntry>()
      .fold<double>(0.0, (sum, e) => sum + e.mainAxisPosition);
  print('Sum of mainAxisPositions: $mainAxisSum');
  results.add('Path iterable operations tested');

  print('SliverHitTestResult test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SliverHitTestResult Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ...results.map(
            (r) => Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text('✓ $r', style: TextStyle(fontSize: 14)),
            ),
          ),
        ],
      ),
    ),
  );
}
