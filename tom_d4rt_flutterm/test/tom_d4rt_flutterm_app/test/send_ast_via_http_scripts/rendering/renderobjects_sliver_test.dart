// D4rt test script: Tests RenderSliverList, RenderSliverGrid, RenderSliverPadding, RenderSliverOpacity, SliverGeometry
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('RenderObjects sliver test executing');

  // ========== SLIVER GEOMETRY ==========
  print('--- SliverGeometry Tests ---');

  final geomZero = SliverGeometry.zero;
  print('SliverGeometry.zero: ${geomZero.runtimeType}');
  print('  scrollExtent: ${geomZero.scrollExtent}');
  print('  paintExtent: ${geomZero.paintExtent}');
  print('  layoutExtent: ${geomZero.layoutExtent}');
  print('  maxPaintExtent: ${geomZero.maxPaintExtent}');
  print('  visible: ${geomZero.visible}');

  final geomCustom = SliverGeometry(
    scrollExtent: 200.0,
    paintExtent: 150.0,
    maxPaintExtent: 200.0,
    layoutExtent: 150.0,
    cacheExtent: 250.0,
    hasVisualOverflow: false,
  );
  print('SliverGeometry(custom):');
  print('  scrollExtent: ${geomCustom.scrollExtent}');
  print('  paintExtent: ${geomCustom.paintExtent}');
  print('  maxPaintExtent: ${geomCustom.maxPaintExtent}');
  print('  layoutExtent: ${geomCustom.layoutExtent}');
  print('  cacheExtent: ${geomCustom.cacheExtent}');
  print('  hasVisualOverflow: ${geomCustom.hasVisualOverflow}');
  print('  visible: ${geomCustom.visible}');

  final geomWithOverflow = SliverGeometry(
    scrollExtent: 100.0,
    paintExtent: 100.0,
    maxPaintExtent: 100.0,
    hasVisualOverflow: true,
  );
  print(
    'SliverGeometry(overflow=true) hasVisualOverflow: ${geomWithOverflow.hasVisualOverflow}',
  );

  final geomScrollOff = SliverGeometry(
    scrollExtent: 300.0,
    paintExtent: 0.0,
    maxPaintExtent: 300.0,
    scrollOffsetCorrection: 10.0,
  );
  print(
    'SliverGeometry(scrollOffsetCorrection) scrollOffsetCorrection: ${geomScrollOff.scrollOffsetCorrection}',
  );

  // ========== SLIVER CONSTRAINTS ==========
  print('--- SliverConstraints Tests ---');

  // SliverConstraints normally comes from the parent sliver/viewport.
  // Cannot easily construct directly without proper rendering pipeline.
  print(
    'SliverConstraints: typically provided by parent viewport during layout',
  );
  print('  Contains: axisDirection, growthDirection, scrollOffset, etc.');

  // ========== RENDER SLIVER PADDING ==========
  print('--- RenderSliverPadding Tests ---');

  final sliverPadding = RenderSliverPadding(padding: EdgeInsets.all(16.0));
  print('RenderSliverPadding created: ${sliverPadding.runtimeType}');
  print('  padding: ${sliverPadding.padding}');

  final sliverPaddingCustom = RenderSliverPadding(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
  );
  print('RenderSliverPadding(symmetric):');
  print('  padding: ${sliverPaddingCustom.padding}');

  final sliverPaddingOnly = RenderSliverPadding(
    padding: EdgeInsets.only(left: 10.0, top: 20.0, right: 30.0, bottom: 40.0),
  );
  print('RenderSliverPadding(only): padding=${sliverPaddingOnly.padding}');

  // Modify padding
  sliverPadding.padding = EdgeInsets.all(24.0);
  print('After setting padding to 24: ${sliverPadding.padding}');

  // ========== RENDER SLIVER OPACITY ==========
  print('--- RenderSliverOpacity Tests ---');

  final sliverOpacity = RenderSliverOpacity(opacity: 0.5);
  print('RenderSliverOpacity(0.5) created: ${sliverOpacity.runtimeType}');
  print('  opacity: ${sliverOpacity.opacity}');
  print('  alwaysIncludeSemantics: ${sliverOpacity.alwaysIncludeSemantics}');

  final sliverOpacityZero = RenderSliverOpacity(opacity: 0.0);
  print('RenderSliverOpacity(0.0) opacity: ${sliverOpacityZero.opacity}');

  final sliverOpacityFull = RenderSliverOpacity(opacity: 1.0);
  print('RenderSliverOpacity(1.0) opacity: ${sliverOpacityFull.opacity}');

  final sliverOpacitySemantics = RenderSliverOpacity(
    opacity: 0.8,
    alwaysIncludeSemantics: true,
  );
  print(
    'RenderSliverOpacity(semantics=true) alwaysIncludeSemantics: ${sliverOpacitySemantics.alwaysIncludeSemantics}',
  );

  // Modify opacity
  sliverOpacity.opacity = 0.9;
  print('After setting opacity to 0.9: ${sliverOpacity.opacity}');

  // ========== RENDER SLIVER LIST / GRID ==========
  print('--- RenderSliverList / RenderSliverGrid Notes ---');

  // RenderSliverList and RenderSliverGrid require a RenderSliverBoxChildManager
  // which is an abstract class. They cannot be constructed standalone.
  print('RenderSliverList requires RenderSliverBoxChildManager (abstract)');
  print('RenderSliverGrid requires RenderSliverBoxChildManager + gridDelegate');
  print(
    'Limitation: Cannot construct without concrete child manager implementation',
  );
  print(
    'These are typically created internally by SliverList/SliverGrid widgets',
  );

  // ========== GROWTH DIRECTION AND SCROLL DIRECTION ==========
  print('--- GrowthDirection / ScrollDirection ---');
  print('GrowthDirection.forward: ${GrowthDirection.forward}');
  print('GrowthDirection.reverse: ${GrowthDirection.reverse}');
  print('ScrollDirection.idle: ${ScrollDirection.idle}');
  print('ScrollDirection.forward: ${ScrollDirection.forward}');
  print('ScrollDirection.reverse: ${ScrollDirection.reverse}');

  // Note: Cannot call layout() or paint() on orphan render objects
  print('Note: render objects not laid out - no parent render tree attached');

  print('RenderObjects sliver test completed');
  return Container(child: Text('RenderObjects sliver test passed'));
}
