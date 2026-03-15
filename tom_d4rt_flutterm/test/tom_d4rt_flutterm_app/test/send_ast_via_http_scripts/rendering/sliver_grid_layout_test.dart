// D4rt test script: Tests SliverGridLayout from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// Custom implementation of SliverGridLayout for testing
class TestSliverGridLayout extends SliverGridLayout {
  final int columns;
  final double tileWidth;
  final double tileHeight;
  final double spacing;

  TestSliverGridLayout({
    required this.columns,
    required this.tileWidth,
    required this.tileHeight,
    this.spacing = 0.0,
  });

  @override
  int getMinChildIndexForScrollOffset(double scrollOffset) {
    final row = (scrollOffset / (tileHeight + spacing)).floor();
    return row * columns;
  }

  @override
  int getMaxChildIndexForScrollOffset(double scrollOffset) {
    final row = (scrollOffset / (tileHeight + spacing)).floor();
    return (row + 1) * columns - 1;
  }

  @override
  SliverGridGeometry getGeometryForChildIndex(int index) {
    final row = index ~/ columns;
    final col = index % columns;
    return SliverGridGeometry(
      scrollOffset: row * (tileHeight + spacing),
      crossAxisOffset: col * (tileWidth + spacing),
      mainAxisExtent: tileHeight,
      crossAxisExtent: tileWidth,
    );
  }

  @override
  double computeMaxScrollOffset(int childCount) {
    final rows = (childCount + columns - 1) ~/ columns;
    return rows * (tileHeight + spacing) - spacing;
  }
}

dynamic build(BuildContext context) {
  print('SliverGridLayout test executing');
  final results = <String>[];

  // ========== Section 1: SliverGridLayout is Abstract ==========
  print('--- Section 1: SliverGridLayout is Abstract ---');

  print('SliverGridLayout is an abstract class');
  print('It defines the interface for grid layouts');
  results.add('SliverGridLayout is abstract');

  // ========== Section 2: Custom Implementation ==========
  print('--- Section 2: Custom Implementation ---');

  final layout = TestSliverGridLayout(
    columns: 3,
    tileWidth: 100.0,
    tileHeight: 100.0,
    spacing: 10.0,
  );

  print('Created TestSliverGridLayout: ${layout.runtimeType}');
  print('Columns: ${layout.columns}');
  print('Tile size: ${layout.tileWidth} x ${layout.tileHeight}');
  print('Spacing: ${layout.spacing}');
  results.add('Custom layout: ${layout.columns} columns');

  // ========== Section 3: getMinChildIndexForScrollOffset ==========
  print('--- Section 3: getMinChildIndexForScrollOffset ---');

  final scrollOffsets = [0.0, 50.0, 110.0, 220.0, 500.0];

  for (final offset in scrollOffsets) {
    final minIndex = layout.getMinChildIndexForScrollOffset(offset);
    print('Scroll offset $offset -> minChildIndex: $minIndex');
  }
  results.add('getMinChildIndexForScrollOffset tested');

  // ========== Section 4: getMaxChildIndexForScrollOffset ==========
  print('--- Section 4: getMaxChildIndexForScrollOffset ---');

  for (final offset in scrollOffsets) {
    final maxIndex = layout.getMaxChildIndexForScrollOffset(offset);
    print('Scroll offset $offset -> maxChildIndex: $maxIndex');
  }
  results.add('getMaxChildIndexForScrollOffset tested');

  // ========== Section 5: getGeometryForChildIndex ==========
  print('--- Section 5: getGeometryForChildIndex ---');

  for (var i = 0; i < 9; i++) {
    final geometry = layout.getGeometryForChildIndex(i);
    print(
      'Child $i: scroll=${geometry.scrollOffset}, cross=${geometry.crossAxisOffset}',
    );
  }
  results.add('getGeometryForChildIndex tested');

  // ========== Section 6: computeMaxScrollOffset ==========
  print('--- Section 6: computeMaxScrollOffset ---');

  final childCounts = [1, 3, 4, 6, 9, 12];

  for (final count in childCounts) {
    final maxScroll = layout.computeMaxScrollOffset(count);
    print('$count children -> maxScrollOffset: $maxScroll');
  }
  results.add('computeMaxScrollOffset tested');

  // ========== Section 7: Different Grid Configurations ==========
  print('--- Section 7: Different Grid Configurations ---');

  final layout2Col = TestSliverGridLayout(
    columns: 2,
    tileWidth: 150.0,
    tileHeight: 150.0,
    spacing: 5.0,
  );
  print('2-column layout:');
  for (var i = 0; i < 6; i++) {
    final geo = layout2Col.getGeometryForChildIndex(i);
    print('  Item $i: (${geo.scrollOffset}, ${geo.crossAxisOffset})');
  }
  results.add('2-column layout tested');

  final layout4Col = TestSliverGridLayout(
    columns: 4,
    tileWidth: 80.0,
    tileHeight: 80.0,
    spacing: 8.0,
  );
  print('4-column layout:');
  for (var i = 0; i < 8; i++) {
    final geo = layout4Col.getGeometryForChildIndex(i);
    print('  Item $i: (${geo.scrollOffset}, ${geo.crossAxisOffset})');
  }
  results.add('4-column layout tested');

  // ========== Section 8: SliverGridDelegate Integration ==========
  print('--- Section 8: SliverGridDelegate Integration ---');

  // SliverGridDelegate creates SliverGridLayout
  final delegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    mainAxisSpacing: 10.0,
    crossAxisSpacing: 10.0,
  );

  print('Delegate type: ${delegate.runtimeType}');
  print('Delegate crossAxisCount: ${delegate.crossAxisCount}');
  print('Delegate mainAxisSpacing: ${delegate.mainAxisSpacing}');
  print('Delegate crossAxisSpacing: ${delegate.crossAxisSpacing}');

  // Get layout from delegate
  final delegateLayout = delegate.getLayout(
    SliverConstraints(
      axisDirection: AxisDirection.down,
      growthDirection: GrowthDirection.forward,
      userScrollDirection: ScrollDirection.idle,
      scrollOffset: 0.0,
      precedingScrollExtent: 0.0,
      overlap: 0.0,
      remainingPaintExtent: 600.0,
      crossAxisExtent: 360.0,
      crossAxisDirection: AxisDirection.right,
      viewportMainAxisExtent: 600.0,
      remainingCacheExtent: 800.0,
      cacheOrigin: 0.0,
    ),
  );

  print('Layout from delegate: ${delegateLayout.runtimeType}');
  results.add('SliverGridDelegate integration tested');

  // ========== Section 9: No Spacing Layout ==========
  print('--- Section 9: No Spacing Layout ---');

  final noSpacingLayout = TestSliverGridLayout(
    columns: 3,
    tileWidth: 100.0,
    tileHeight: 100.0,
    spacing: 0.0,
  );

  print('No spacing layout:');
  for (var i = 0; i < 6; i++) {
    final geo = noSpacingLayout.getGeometryForChildIndex(i);
    print('  Item $i: (${geo.scrollOffset}, ${geo.crossAxisOffset})');
  }
  results.add('No spacing layout tested');

  // ========== Section 10: Type Checking ==========
  print('--- Section 10: Type Checking ---');

  print('layout is SliverGridLayout: ${layout is SliverGridLayout}');
  print(
    'delegateLayout is SliverGridLayout: ${delegateLayout is SliverGridLayout}',
  );
  results.add('Type checking verified');

  print('SliverGridLayout test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SliverGridLayout Tests',
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
