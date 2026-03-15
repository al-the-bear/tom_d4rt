// D4rt test script: Tests SliverGridRegularTileLayout from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverGridRegularTileLayout test executing');
  final results = <String>[];

  // ========== Section 1: Basic Creation ==========
  print('--- Section 1: Basic Creation ---');

  final layout = SliverGridRegularTileLayout(
    crossAxisCount: 3,
    mainAxisStride: 110.0,
    crossAxisStride: 110.0,
    childMainAxisExtent: 100.0,
    childCrossAxisExtent: 100.0,
    reverseCrossAxis: false,
  );

  print('Created SliverGridRegularTileLayout: ${layout.runtimeType}');
  print('crossAxisCount: ${layout.crossAxisCount}');
  print('mainAxisStride: ${layout.mainAxisStride}');
  print('crossAxisStride: ${layout.crossAxisStride}');
  print('childMainAxisExtent: ${layout.childMainAxisExtent}');
  print('childCrossAxisExtent: ${layout.childCrossAxisExtent}');
  print('reverseCrossAxis: ${layout.reverseCrossAxis}');
  results.add('SliverGridRegularTileLayout created');

  // ========== Section 2: Type Checking ==========
  print('--- Section 2: Type Checking ---');

  print('layout is SliverGridLayout: ${layout is SliverGridLayout}');
  results.add('Is SliverGridLayout: ${layout is SliverGridLayout}');

  // ========== Section 3: getMinChildIndexForScrollOffset ==========
  print('--- Section 3: getMinChildIndexForScrollOffset ---');

  final scrollOffsets = [0.0, 50.0, 110.0, 220.0, 330.0, 500.0];

  for (final offset in scrollOffsets) {
    final minIndex = layout.getMinChildIndexForScrollOffset(offset);
    print('Scroll $offset -> minChildIndex: $minIndex');
  }
  results.add('getMinChildIndexForScrollOffset tested');

  // ========== Section 4: getMaxChildIndexForScrollOffset ==========
  print('--- Section 4: getMaxChildIndexForScrollOffset ---');

  for (final offset in scrollOffsets) {
    final maxIndex = layout.getMaxChildIndexForScrollOffset(offset);
    print('Scroll $offset -> maxChildIndex: $maxIndex');
  }
  results.add('getMaxChildIndexForScrollOffset tested');

  // ========== Section 5: getGeometryForChildIndex ==========
  print('--- Section 5: getGeometryForChildIndex ---');

  for (var i = 0; i < 9; i++) {
    final geometry = layout.getGeometryForChildIndex(i);
    final row = i ~/ 3;
    final col = i % 3;
    print(
      'Child $i (row=$row, col=$col): scroll=${geometry.scrollOffset}, cross=${geometry.crossAxisOffset}',
    );
  }
  results.add('getGeometryForChildIndex tested for 9 items');

  // ========== Section 6: computeMaxScrollOffset ==========
  print('--- Section 6: computeMaxScrollOffset ---');

  final childCounts = [1, 3, 4, 6, 9, 10, 12, 15];

  for (final count in childCounts) {
    final maxScroll = layout.computeMaxScrollOffset(count);
    final rows = (count + 2) ~/ 3;
    print('$count children ($rows rows) -> maxScrollOffset: $maxScroll');
  }
  results.add('computeMaxScrollOffset tested');

  // ========== Section 7: Different Column Counts ==========
  print('--- Section 7: Different Column Counts ---');

  final layout2Col = SliverGridRegularTileLayout(
    crossAxisCount: 2,
    mainAxisStride: 120.0,
    crossAxisStride: 160.0,
    childMainAxisExtent: 100.0,
    childCrossAxisExtent: 150.0,
    reverseCrossAxis: false,
  );

  print('2-column layout:');
  for (var i = 0; i < 6; i++) {
    final geo = layout2Col.getGeometryForChildIndex(i);
    print(
      '  Item $i: scroll=${geo.scrollOffset}, cross=${geo.crossAxisOffset}',
    );
  }
  results.add('2-column layout tested');

  final layout4Col = SliverGridRegularTileLayout(
    crossAxisCount: 4,
    mainAxisStride: 85.0,
    crossAxisStride: 85.0,
    childMainAxisExtent: 80.0,
    childCrossAxisExtent: 80.0,
    reverseCrossAxis: false,
  );

  print('4-column layout:');
  for (var i = 0; i < 8; i++) {
    final geo = layout4Col.getGeometryForChildIndex(i);
    print(
      '  Item $i: scroll=${geo.scrollOffset}, cross=${geo.crossAxisOffset}',
    );
  }
  results.add('4-column layout tested');

  // ========== Section 8: Reverse Cross Axis ==========
  print('--- Section 8: Reverse Cross Axis ---');

  final reversedLayout = SliverGridRegularTileLayout(
    crossAxisCount: 3,
    mainAxisStride: 110.0,
    crossAxisStride: 110.0,
    childMainAxisExtent: 100.0,
    childCrossAxisExtent: 100.0,
    reverseCrossAxis: true,
  );

  print('Reversed cross axis layout:');
  for (var i = 0; i < 6; i++) {
    final normal = layout.getGeometryForChildIndex(i);
    final reversed = reversedLayout.getGeometryForChildIndex(i);
    print(
      '  Item $i: normal cross=${normal.crossAxisOffset}, reversed cross=${reversed.crossAxisOffset}',
    );
  }
  results.add('Reverse cross axis tested');

  // ========== Section 9: No Spacing (Stride equals Extent) ==========
  print('--- Section 9: No Spacing ---');

  final noSpacingLayout = SliverGridRegularTileLayout(
    crossAxisCount: 3,
    mainAxisStride: 100.0,
    crossAxisStride: 100.0,
    childMainAxisExtent: 100.0,
    childCrossAxisExtent: 100.0,
    reverseCrossAxis: false,
  );

  print('No spacing layout (stride == extent):');
  for (var i = 0; i < 6; i++) {
    final geo = noSpacingLayout.getGeometryForChildIndex(i);
    print(
      '  Item $i: scroll=${geo.scrollOffset}, cross=${geo.crossAxisOffset}',
    );
  }
  results.add('No spacing layout tested');

  // ========== Section 10: Large Spacing ==========
  print('--- Section 10: Large Spacing ---');

  final largeSpacingLayout = SliverGridRegularTileLayout(
    crossAxisCount: 2,
    mainAxisStride: 200.0, // 100 spacing
    crossAxisStride: 200.0,
    childMainAxisExtent: 100.0,
    childCrossAxisExtent: 100.0,
    reverseCrossAxis: false,
  );

  print('Large spacing layout (100px spacing):');
  for (var i = 0; i < 4; i++) {
    final geo = largeSpacingLayout.getGeometryForChildIndex(i);
    print(
      '  Item $i: scroll=${geo.scrollOffset}, cross=${geo.crossAxisOffset}',
    );
  }
  print(
    'Max scroll for 4 items: ${largeSpacingLayout.computeMaxScrollOffset(4)}',
  );
  results.add('Large spacing layout tested');

  // ========== Section 11: Single Column ==========
  print('--- Section 11: Single Column ---');

  final singleColLayout = SliverGridRegularTileLayout(
    crossAxisCount: 1,
    mainAxisStride: 110.0,
    crossAxisStride: 300.0,
    childMainAxisExtent: 100.0,
    childCrossAxisExtent: 300.0,
    reverseCrossAxis: false,
  );

  print('Single column layout:');
  for (var i = 0; i < 5; i++) {
    final geo = singleColLayout.getGeometryForChildIndex(i);
    print(
      '  Item $i: scroll=${geo.scrollOffset}, cross=${geo.crossAxisOffset}',
    );
  }
  results.add('Single column layout tested');

  print('SliverGridRegularTileLayout test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SliverGridRegularTileLayout Tests',
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
