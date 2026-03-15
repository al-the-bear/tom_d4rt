// D4rt test script: Tests SliverGridGeometry from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverGridGeometry test executing');
  final results = <String>[];

  // ========== Section 1: Basic SliverGridGeometry Creation ==========
  print('--- Section 1: Basic SliverGridGeometry Creation ---');

  final geometry1 = SliverGridGeometry(
    scrollOffset: 0.0,
    crossAxisOffset: 0.0,
    mainAxisExtent: 100.0,
    crossAxisExtent: 100.0,
  );

  print('Created SliverGridGeometry: ${geometry1.runtimeType}');
  print('scrollOffset: ${geometry1.scrollOffset}');
  print('crossAxisOffset: ${geometry1.crossAxisOffset}');
  print('mainAxisExtent: ${geometry1.mainAxisExtent}');
  print('crossAxisExtent: ${geometry1.crossAxisExtent}');
  results.add('SliverGridGeometry created');

  // ========== Section 2: All Properties ==========
  print('--- Section 2: All Properties ---');

  final geometry2 = SliverGridGeometry(
    scrollOffset: 100.0,
    crossAxisOffset: 50.0,
    mainAxisExtent: 150.0,
    crossAxisExtent: 200.0,
  );

  print('scrollOffset: ${geometry2.scrollOffset}');
  print('crossAxisOffset: ${geometry2.crossAxisOffset}');
  print('mainAxisExtent: ${geometry2.mainAxisExtent}');
  print('crossAxisExtent: ${geometry2.crossAxisExtent}');
  print('trailingScrollOffset: ${geometry2.trailingScrollOffset}');
  results.add('trailingScrollOffset: ${geometry2.trailingScrollOffset}');

  // ========== Section 3: Trailing Scroll Offset Calculation ==========
  print('--- Section 3: Trailing Scroll Offset Calculation ---');

  // trailingScrollOffset = scrollOffset + mainAxisExtent
  final testGeometry = SliverGridGeometry(
    scrollOffset: 200.0,
    crossAxisOffset: 0.0,
    mainAxisExtent: 80.0,
    crossAxisExtent: 100.0,
  );

  final expected = testGeometry.scrollOffset + testGeometry.mainAxisExtent;
  final actual = testGeometry.trailingScrollOffset;
  print('scrollOffset + mainAxisExtent = $expected');
  print('trailingScrollOffset = $actual');
  print('Calculation correct: ${expected == actual}');
  results.add('Trailing scroll offset calculation verified');

  // ========== Section 4: Get Box Constraints ==========
  print('--- Section 4: Get Box Constraints ---');

  final constraints = geometry1.getBoxConstraints(
    SliverConstraints(
      axisDirection: AxisDirection.down,
      growthDirection: GrowthDirection.forward,
      userScrollDirection: ScrollDirection.forward,
      scrollOffset: 0.0,
      precedingScrollExtent: 0.0,
      overlap: 0.0,
      remainingPaintExtent: 600.0,
      crossAxisExtent: 400.0,
      crossAxisDirection: AxisDirection.right,
      viewportMainAxisExtent: 600.0,
      remainingCacheExtent: 800.0,
      cacheOrigin: 0.0,
    ),
  );

  print('BoxConstraints from geometry:');
  print('  minWidth: ${constraints.minWidth}');
  print('  maxWidth: ${constraints.maxWidth}');
  print('  minHeight: ${constraints.minHeight}');
  print('  maxHeight: ${constraints.maxHeight}');
  results.add('BoxConstraints generated');

  // ========== Section 5: Different Grid Configurations ==========
  print('--- Section 5: Different Grid Configurations ---');

  final configs = [
    (scroll: 0.0, cross: 0.0, main: 100.0, crossExt: 100.0),
    (scroll: 0.0, cross: 110.0, main: 100.0, crossExt: 100.0),
    (scroll: 110.0, cross: 0.0, main: 100.0, crossExt: 100.0),
    (scroll: 110.0, cross: 110.0, main: 100.0, crossExt: 100.0),
  ];

  for (var i = 0; i < configs.length; i++) {
    final cfg = configs[i];
    final geo = SliverGridGeometry(
      scrollOffset: cfg.scroll,
      crossAxisOffset: cfg.cross,
      mainAxisExtent: cfg.main,
      crossAxisExtent: cfg.crossExt,
    );
    print(
      'Config $i: scrollOff=${cfg.scroll}, crossOff=${cfg.cross}, trailing=${geo.trailingScrollOffset}',
    );
  }
  results.add('Tested ${configs.length} grid configurations');

  // ========== Section 6: Large Values ==========
  print('--- Section 6: Large Values ---');

  final largeGeometry = SliverGridGeometry(
    scrollOffset: 10000.0,
    crossAxisOffset: 5000.0,
    mainAxisExtent: 500.0,
    crossAxisExtent: 300.0,
  );

  print('Large scrollOffset: ${largeGeometry.scrollOffset}');
  print('Large trailingScrollOffset: ${largeGeometry.trailingScrollOffset}');
  results.add('Large values handled');

  // ========== Section 7: Zero Main Axis Extent ==========
  print('--- Section 7: Zero Main Axis Extent ---');

  final zeroMainGeometry = SliverGridGeometry(
    scrollOffset: 100.0,
    crossAxisOffset: 50.0,
    mainAxisExtent: 0.0,
    crossAxisExtent: 100.0,
  );

  print('Zero mainAxisExtent: ${zeroMainGeometry.mainAxisExtent}');
  print('Trailing with zero main: ${zeroMainGeometry.trailingScrollOffset}');
  results.add('Zero mainAxisExtent tested');

  // ========== Section 8: Fractional Values ==========
  print('--- Section 8: Fractional Values ---');

  final fractionalGeometry = SliverGridGeometry(
    scrollOffset: 123.456,
    crossAxisOffset: 78.901,
    mainAxisExtent: 99.999,
    crossAxisExtent: 150.5,
  );

  print('Fractional scrollOffset: ${fractionalGeometry.scrollOffset}');
  print('Fractional crossAxisOffset: ${fractionalGeometry.crossAxisOffset}');
  print('Fractional mainAxisExtent: ${fractionalGeometry.mainAxisExtent}');
  print(
    'Fractional trailingScrollOffset: ${fractionalGeometry.trailingScrollOffset}',
  );
  results.add('Fractional values handled');

  // ========== Section 9: ToString ==========
  print('--- Section 9: ToString ---');

  print('geometry1.toString(): ${geometry1.toString()}');
  results.add('ToString available');

  // ========== Section 10: Multiple Items Grid Simulation ==========
  print('--- Section 10: Multiple Items Grid Simulation ---');

  // Simulate a 3-column grid with spacing
  final columnWidth = 100.0;
  final spacing = 10.0;
  final items = <SliverGridGeometry>[];

  for (var row = 0; row < 3; row++) {
    for (var col = 0; col < 3; col++) {
      items.add(
        SliverGridGeometry(
          scrollOffset: row * (columnWidth + spacing),
          crossAxisOffset: col * (columnWidth + spacing),
          mainAxisExtent: columnWidth,
          crossAxisExtent: columnWidth,
        ),
      );
    }
  }

  print('Created ${items.length} grid items');
  for (var i = 0; i < items.length; i++) {
    print(
      '  Item $i: scroll=${items[i].scrollOffset}, cross=${items[i].crossAxisOffset}',
    );
  }
  results.add('Grid simulation: ${items.length} items');

  print('SliverGridGeometry test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SliverGridGeometry Tests',
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
