// D4rt test script: Tests SliverLayoutDimensions from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverLayoutDimensions test executing');
  final results = <String>[];

  // ========== Section 1: Basic SliverLayoutDimensions Creation ==========
  print('--- Section 1: Basic SliverLayoutDimensions Creation ---');

  final dimensions1 = SliverLayoutDimensions(
    scrollOffset: 100.0,
    precedingScrollExtent: 50.0,
    viewportMainAxisExtent: 600.0,
    crossAxisExtent: 400.0,
  );
  print('Created SliverLayoutDimensions: ${dimensions1.runtimeType}');
  print('scrollOffset: ${dimensions1.scrollOffset}');
  print('precedingScrollExtent: ${dimensions1.precedingScrollExtent}');
  print('viewportMainAxisExtent: ${dimensions1.viewportMainAxisExtent}');
  print('crossAxisExtent: ${dimensions1.crossAxisExtent}');
  results.add('Basic creation: scrollOffset=100.0');

  // ========== Section 2: Zero Values ==========
  print('--- Section 2: Zero Values ---');

  final zeroDimensions = SliverLayoutDimensions(
    scrollOffset: 0.0,
    precedingScrollExtent: 0.0,
    viewportMainAxisExtent: 0.0,
    crossAxisExtent: 0.0,
  );
  print('Zero dimensions scrollOffset: ${zeroDimensions.scrollOffset}');
  print(
    'Zero dimensions precedingScrollExtent: ${zeroDimensions.precedingScrollExtent}',
  );
  print(
    'Zero dimensions viewportMainAxisExtent: ${zeroDimensions.viewportMainAxisExtent}',
  );
  print('Zero dimensions crossAxisExtent: ${zeroDimensions.crossAxisExtent}');
  results.add('Zero values tested');

  // ========== Section 3: Large Values ==========
  print('--- Section 3: Large Values ---');

  final largeDimensions = SliverLayoutDimensions(
    scrollOffset: 10000.0,
    precedingScrollExtent: 5000.0,
    viewportMainAxisExtent: 2000.0,
    crossAxisExtent: 1500.0,
  );
  print('Large scrollOffset: ${largeDimensions.scrollOffset}');
  print(
    'Large precedingScrollExtent: ${largeDimensions.precedingScrollExtent}',
  );
  print(
    'Large viewportMainAxisExtent: ${largeDimensions.viewportMainAxisExtent}',
  );
  print('Large crossAxisExtent: ${largeDimensions.crossAxisExtent}');
  results.add('Large values: scrollOffset=10000.0');

  // ========== Section 4: Various Scroll Offsets ==========
  print('--- Section 4: Various Scroll Offsets ---');

  final scrollOffsets = [0.0, 50.0, 100.0, 250.0, 500.0, 1000.0];
  for (final offset in scrollOffsets) {
    final dims = SliverLayoutDimensions(
      scrollOffset: offset,
      precedingScrollExtent: 0.0,
      viewportMainAxisExtent: 600.0,
      crossAxisExtent: 400.0,
    );
    print('Dimensions with scrollOffset $offset: ${dims.scrollOffset}');
  }
  results.add('Tested ${scrollOffsets.length} scroll offsets');

  // ========== Section 5: Various Preceding Scroll Extents ==========
  print('--- Section 5: Various Preceding Scroll Extents ---');

  final precedingExtents = [0.0, 100.0, 200.0, 500.0, 1000.0];
  for (final extent in precedingExtents) {
    final dims = SliverLayoutDimensions(
      scrollOffset: 100.0,
      precedingScrollExtent: extent,
      viewportMainAxisExtent: 600.0,
      crossAxisExtent: 400.0,
    );
    print(
      'Dimensions with precedingScrollExtent $extent: ${dims.precedingScrollExtent}',
    );
  }
  results.add('Tested ${precedingExtents.length} preceding extents');

  // ========== Section 6: Various Viewport Main Axis Extents ==========
  print('--- Section 6: Various Viewport Main Axis Extents ---');

  final viewportExtents = [100.0, 300.0, 600.0, 800.0, 1200.0];
  for (final extent in viewportExtents) {
    final dims = SliverLayoutDimensions(
      scrollOffset: 100.0,
      precedingScrollExtent: 50.0,
      viewportMainAxisExtent: extent,
      crossAxisExtent: 400.0,
    );
    print(
      'Dimensions with viewportMainAxisExtent $extent: ${dims.viewportMainAxisExtent}',
    );
  }
  results.add('Tested ${viewportExtents.length} viewport extents');

  // ========== Section 7: Various Cross Axis Extents ==========
  print('--- Section 7: Various Cross Axis Extents ---');

  final crossAxisExtents = [200.0, 300.0, 400.0, 500.0, 800.0];
  for (final extent in crossAxisExtents) {
    final dims = SliverLayoutDimensions(
      scrollOffset: 100.0,
      precedingScrollExtent: 50.0,
      viewportMainAxisExtent: 600.0,
      crossAxisExtent: extent,
    );
    print('Dimensions with crossAxisExtent $extent: ${dims.crossAxisExtent}');
  }
  results.add('Tested ${crossAxisExtents.length} cross axis extents');

  // ========== Section 8: Equality Comparison ==========
  print('--- Section 8: Equality Comparison ---');

  final dims1 = SliverLayoutDimensions(
    scrollOffset: 100.0,
    precedingScrollExtent: 50.0,
    viewportMainAxisExtent: 600.0,
    crossAxisExtent: 400.0,
  );
  final dims2 = SliverLayoutDimensions(
    scrollOffset: 100.0,
    precedingScrollExtent: 50.0,
    viewportMainAxisExtent: 600.0,
    crossAxisExtent: 400.0,
  );
  final dims3 = SliverLayoutDimensions(
    scrollOffset: 200.0,
    precedingScrollExtent: 50.0,
    viewportMainAxisExtent: 600.0,
    crossAxisExtent: 400.0,
  );
  print('dims1 == dims2: ${dims1 == dims2}');
  print('dims1 == dims3: ${dims1 == dims3}');
  print(
    'dims1.hashCode == dims2.hashCode: ${dims1.hashCode == dims2.hashCode}',
  );
  results.add('Equality: same=${dims1 == dims2}, different=${dims1 == dims3}');

  // ========== Section 9: Runtime Type Check ==========
  print('--- Section 9: Runtime Type Check ---');

  print('dimensions1.runtimeType: ${dimensions1.runtimeType}');
  print('Is SliverLayoutDimensions: ${dimensions1 is SliverLayoutDimensions}');
  results.add('Runtime type verified');

  print('SliverLayoutDimensions test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverLayoutDimensions Tests'),
      Text('Results: ${results.length} sections'),
      ...results.map((r) => Text(r)),
    ],
  );
}
