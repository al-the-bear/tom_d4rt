// D4rt test script: Tests RenderView, RenderViewport, and root render object concepts
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('RenderObjects view test executing');

  // ========== RENDER VIEW ==========
  print('--- RenderView Notes ---');

  // RenderView is the root of the render tree. It is created and managed
  // by the framework (RendererBinding). Cannot be constructed standalone
  // without a FlutterView.
  print('RenderView is the root render object of the render tree');
  print('It is created by the framework (RendererBinding)');
  print('Cannot be constructed standalone — requires a FlutterView');

  // ========== RENDER VIEWPORT ==========
  print('--- RenderViewport Notes ---');

  // RenderViewport requires axisDirection, crossAxisDirection, offset
  // and a ViewportOffset. It manages slivers.
  print('RenderViewport is the scrollable viewport render object');
  print('Requires: axisDirection, crossAxisDirection, offset (ViewportOffset)');

  // We can construct a basic RenderViewport with ViewportOffset
  final offset = ViewportOffset.fixed(0.0);
  final viewport = RenderViewport(
    axisDirection: AxisDirection.down,
    crossAxisDirection: AxisDirection.right,
    offset: offset,
  );
  print('RenderViewport created: ${viewport.runtimeType}');
  print('  axisDirection: ${viewport.axisDirection}');
  print('  crossAxisDirection: ${viewport.crossAxisDirection}');
  print('  anchor: ${viewport.anchor}');
  print('  cacheExtent: ${viewport.cacheExtent}');

  final viewportCustom = RenderViewport(
    axisDirection: AxisDirection.right,
    crossAxisDirection: AxisDirection.down,
    offset: ViewportOffset.fixed(50.0),
    anchor: 0.5,
    cacheExtent: 100.0,
  );
  print('RenderViewport(custom):');
  print('  axisDirection: ${viewportCustom.axisDirection}');
  print('  crossAxisDirection: ${viewportCustom.crossAxisDirection}');
  print('  anchor: ${viewportCustom.anchor}');
  print('  cacheExtent: ${viewportCustom.cacheExtent}');

  // Modify properties
  viewport.axisDirection = AxisDirection.up;
  print('After axisDirection change: ${viewport.axisDirection}');
  viewport.anchor = 0.25;
  print('After anchor change: ${viewport.anchor}');
  viewport.cacheExtent = 200.0;
  print('After cacheExtent change: ${viewport.cacheExtent}');

  // ========== RENDER SHRINK WRAPPING VIEWPORT ==========
  print('--- RenderShrinkWrappingViewport Tests ---');

  final shrinkViewport = RenderShrinkWrappingViewport(
    axisDirection: AxisDirection.down,
    crossAxisDirection: AxisDirection.right,
    offset: ViewportOffset.zero(),
  );
  print('RenderShrinkWrappingViewport created: ${shrinkViewport.runtimeType}');
  print('  axisDirection: ${shrinkViewport.axisDirection}');
  print('  crossAxisDirection: ${shrinkViewport.crossAxisDirection}');

  // ========== RENDER ABSTRACT VIEWPORT ==========
  print('--- RenderAbstractViewport Notes ---');
  print('RenderAbstractViewport is the abstract base class for viewports');
  print('Provides: getOffsetToReveal, defaultCacheExtent');

  // ========== VIEWPORT OFFSET ==========
  print('--- ViewportOffset Tests ---');

  final fixedOffset = ViewportOffset.fixed(100.0);
  print('ViewportOffset.fixed(100): pixels=${fixedOffset.pixels}');

  final zeroOffset = ViewportOffset.zero();
  print('ViewportOffset.zero(): pixels=${zeroOffset.pixels}');

  print('hasPixels: ${fixedOffset.hasPixels}');
  print('userScrollDirection: ${fixedOffset.userScrollDirection}');

  // ========== RENDER SLIVER FILL VIEWPORT ==========
  print('--- RenderSliverFillViewport Notes ---');
  print('RenderSliverFillViewport requires a RenderSliverBoxChildManager');
  print('Cannot construct standalone — needs child manager');

  // ========== CACHE EXTENT STYLE ==========
  print('--- CacheExtentStyle values ---');
  print('CacheExtentStyle.pixel: ${CacheExtentStyle.pixel}');
  print('CacheExtentStyle.viewport: ${CacheExtentStyle.viewport}');

  // Note: Cannot call layout() or paint() on orphan render objects
  print('Note: render objects not laid out - no parent render tree attached');

  print('RenderObjects view test completed');
  return Container(child: Text('RenderObjects view test passed'));
}
