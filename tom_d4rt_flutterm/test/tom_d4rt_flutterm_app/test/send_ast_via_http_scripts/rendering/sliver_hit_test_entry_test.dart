// D4rt test script: Tests SliverHitTestEntry from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// Test RenderSliver for hit testing
class TestRenderSliver extends RenderSliver {
  @override
  void performLayout() {
    geometry = SliverGeometry(
      scrollExtent: 100.0,
      paintExtent: 100.0,
      maxPaintExtent: 100.0,
    );
  }
}

dynamic build(BuildContext context) {
  print('SliverHitTestEntry test executing');
  final results = <String>[];

  // ========== Section 1: Create Test RenderSliver ==========
  print('--- Section 1: Create Test RenderSliver ---');

  final sliver = TestRenderSliver();
  print('Created TestRenderSliver: ${sliver.runtimeType}');
  results.add('TestRenderSliver created');

  // ========== Section 2: Create SliverHitTestEntry ==========
  print('--- Section 2: Create SliverHitTestEntry ---');

  final entry = SliverHitTestEntry(
    sliver,
    mainAxisPosition: 50.0,
    crossAxisPosition: 25.0,
  );

  print('Created SliverHitTestEntry: ${entry.runtimeType}');
  print('Target: ${entry.target.runtimeType}');
  print('mainAxisPosition: ${entry.mainAxisPosition}');
  print('crossAxisPosition: ${entry.crossAxisPosition}');
  results.add('SliverHitTestEntry created');

  // ========== Section 3: Target Property ==========
  print('--- Section 3: Target Property ---');

  print('entry.target: ${entry.target}');
  print('entry.target is RenderSliver: ${entry.target is RenderSliver}');
  print('entry.target runtimeType: ${entry.target.runtimeType}');
  results.add('Target is RenderSliver: ${entry.target is RenderSliver}');

  // ========== Section 4: Position Properties ==========
  print('--- Section 4: Position Properties ---');

  print('mainAxisPosition: ${entry.mainAxisPosition}');
  print('crossAxisPosition: ${entry.crossAxisPosition}');

  // Create entries with different positions
  final positions = [
    (main: 0.0, cross: 0.0),
    (main: 50.0, cross: 25.0),
    (main: 100.0, cross: 50.0),
    (main: 25.5, cross: 12.75),
  ];

  for (final pos in positions) {
    final testEntry = SliverHitTestEntry(
      sliver,
      mainAxisPosition: pos.main,
      crossAxisPosition: pos.cross,
    );
    print(
      'Entry at (${pos.main}, ${pos.cross}): main=${testEntry.mainAxisPosition}, cross=${testEntry.crossAxisPosition}',
    );
  }
  results.add('Tested ${positions.length} positions');

  // ========== Section 5: HitTestEntry Base Class ==========
  print('--- Section 5: HitTestEntry Base Class ---');

  print('entry is HitTestEntry: ${entry is HitTestEntry}');
  results.add('Is HitTestEntry: ${entry is HitTestEntry}');

  // ========== Section 6: Multiple Entries ==========
  print('--- Section 6: Multiple Entries ---');

  final slivers = [TestRenderSliver(), TestRenderSliver(), TestRenderSliver()];

  final entries = <SliverHitTestEntry>[];
  for (var i = 0; i < slivers.length; i++) {
    entries.add(
      SliverHitTestEntry(
        slivers[i],
        mainAxisPosition: i * 30.0,
        crossAxisPosition: i * 15.0,
      ),
    );
  }

  print('Created ${entries.length} SliverHitTestEntries');
  for (var i = 0; i < entries.length; i++) {
    print(
      '  Entry $i: main=${entries[i].mainAxisPosition}, cross=${entries[i].crossAxisPosition}',
    );
  }
  results.add('Multiple entries: ${entries.length}');

  // ========== Section 7: ToString ==========
  print('--- Section 7: ToString ---');

  print('entry.toString(): ${entry.toString()}');
  results.add('ToString available');

  // ========== Section 8: Negative Positions ==========
  print('--- Section 8: Negative Positions ---');

  final negEntry = SliverHitTestEntry(
    sliver,
    mainAxisPosition: -10.0,
    crossAxisPosition: -5.0,
  );

  print('Negative positions entry:');
  print('  mainAxisPosition: ${negEntry.mainAxisPosition}');
  print('  crossAxisPosition: ${negEntry.crossAxisPosition}');
  results.add('Negative positions handled');

  // ========== Section 9: Large Positions ==========
  print('--- Section 9: Large Positions ---');

  final largeEntry = SliverHitTestEntry(
    sliver,
    mainAxisPosition: 10000.0,
    crossAxisPosition: 5000.0,
  );

  print('Large positions entry:');
  print('  mainAxisPosition: ${largeEntry.mainAxisPosition}');
  print('  crossAxisPosition: ${largeEntry.crossAxisPosition}');
  results.add('Large positions handled');

  // ========== Section 10: Zero Positions ==========
  print('--- Section 10: Zero Positions ---');

  final zeroEntry = SliverHitTestEntry(
    sliver,
    mainAxisPosition: 0.0,
    crossAxisPosition: 0.0,
  );

  print('Zero positions entry:');
  print('  mainAxisPosition: ${zeroEntry.mainAxisPosition}');
  print('  crossAxisPosition: ${zeroEntry.crossAxisPosition}');
  results.add('Zero positions handled');

  // ========== Section 11: Entry Collection ==========
  print('--- Section 11: Entry Collection ---');

  final result = SliverHitTestResult();
  result.add(entry);

  print('Added entry to SliverHitTestResult');
  print('Result path length: ${result.path.length}');

  final firstInPath = result.path.first;
  print('First entry in path: ${firstInPath.runtimeType}');

  if (firstInPath is SliverHitTestEntry) {
    print('First entry mainAxisPosition: ${firstInPath.mainAxisPosition}');
    print('First entry crossAxisPosition: ${firstInPath.crossAxisPosition}');
  }
  results.add('Entry added to result path');

  print('SliverHitTestEntry test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SliverHitTestEntry Tests',
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
