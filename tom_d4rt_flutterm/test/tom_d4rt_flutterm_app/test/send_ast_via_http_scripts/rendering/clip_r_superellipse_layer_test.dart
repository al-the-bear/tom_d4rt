// D4rt test script: Tests ClipRSuperellipseLayer from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ClipRSuperellipseLayer test executing');

  // ========== ClipRSuperellipseLayer Basic Creation ==========
  print('--- ClipRSuperellipseLayer Basic Creation ---');
  final superellipse = RSuperellipse.fromRectAndCornerRadius(
    Rect.fromLTWH(0.0, 0.0, 100.0, 80.0),
    10.0,
  );
  final clipLayer = ClipRSuperellipseLayer(clipRSuperellipse: superellipse);
  print('  created: ${clipLayer.runtimeType}');
  print('  clipRSuperellipse: ${clipLayer.clipRSuperellipse}');
  print('  clipBehavior: ${clipLayer.clipBehavior}');

  // ========== RSuperellipse Basics ==========
  print('--- RSuperellipse Basics ---');
  final basicSuperellipse = RSuperellipse.fromRectAndCornerRadius(
    Rect.fromLTWH(10.0, 10.0, 200.0, 150.0),
    20.0,
  );
  print('  basic superellipse created');
  print('  outerRect: ${basicSuperellipse.outerRect}');

  // ========== RSuperellipse with Different Corner Radii ==========
  print('--- RSuperellipse with Different Corner Radii ---');
  final smallCorner = RSuperellipse.fromRectAndCornerRadius(
    Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    5.0,
  );
  print('  small corner radius (5.0): created');

  final mediumCorner = RSuperellipse.fromRectAndCornerRadius(
    Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    15.0,
  );
  print('  medium corner radius (15.0): created');

  final largeCorner = RSuperellipse.fromRectAndCornerRadius(
    Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    30.0,
  );
  print('  large corner radius (30.0): created');

  // ========== ClipRSuperellipseLayer with ClipBehavior ==========
  print('--- ClipRSuperellipseLayer with ClipBehavior ---');
  final hardEdgeClip = ClipRSuperellipseLayer(
    clipRSuperellipse: superellipse,
    clipBehavior: Clip.hardEdge,
  );
  print('  hardEdge: ${hardEdgeClip.clipBehavior}');

  final antiAliasClip = ClipRSuperellipseLayer(
    clipRSuperellipse: superellipse,
    clipBehavior: Clip.antiAlias,
  );
  print('  antiAlias: ${antiAliasClip.clipBehavior}');

  final saveLayerClip = ClipRSuperellipseLayer(
    clipRSuperellipse: superellipse,
    clipBehavior: Clip.antiAliasWithSaveLayer,
  );
  print('  antiAliasWithSaveLayer: ${saveLayerClip.clipBehavior}');

  // ========== ClipRSuperellipseLayer Property Modification ==========
  print('--- ClipRSuperellipseLayer Property Modification ---');
  final mutableLayer = ClipRSuperellipseLayer(clipRSuperellipse: superellipse);
  print('  initial clipRSuperellipse set');

  final newSuperellipse = RSuperellipse.fromRectAndCornerRadius(
    Rect.fromLTWH(20.0, 20.0, 150.0, 100.0),
    25.0,
  );
  mutableLayer.clipRSuperellipse = newSuperellipse;
  print('  modified clipRSuperellipse');

  mutableLayer.clipBehavior = Clip.antiAlias;
  print('  modified clipBehavior: ${mutableLayer.clipBehavior}');

  // ========== ClipRSuperellipseLayer Layer Hierarchy ==========
  print('--- ClipRSuperellipseLayer Layer Hierarchy ---');
  print('  parent: ${clipLayer.parent}');
  print('  firstChild: ${clipLayer.firstChild}');
  print('  lastChild: ${clipLayer.lastChild}');
  print('  nextSibling: ${clipLayer.nextSibling}');
  print('  previousSibling: ${clipLayer.previousSibling}');
  print('  hasChildren: ${clipLayer.hasChildren}');

  // ========== RSuperellipse Various Sizes ==========
  print('--- RSuperellipse Various Sizes ---');
  final sizes = [
    [50.0, 50.0],
    [100.0, 80.0],
    [200.0, 100.0],
    [300.0, 200.0],
  ];
  for (final size in sizes) {
    final se = RSuperellipse.fromRectAndCornerRadius(
      Rect.fromLTWH(0.0, 0.0, size[0], size[1]),
      12.0,
    );
    print('  superellipse ${size[0]}x${size[1]}: outerRect=${se.outerRect}');
  }

  // ========== RSuperellipse Edge Cases ==========
  print('--- RSuperellipse Edge Cases ---');
  final squareSuperellipse = RSuperellipse.fromRectAndCornerRadius(
    Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    20.0,
  );
  print('  square superellipse: ${squareSuperellipse.outerRect}');

  final tallSuperellipse = RSuperellipse.fromRectAndCornerRadius(
    Rect.fromLTWH(0.0, 0.0, 50.0, 200.0),
    15.0,
  );
  print('  tall superellipse: ${tallSuperellipse.outerRect}');

  final wideSuperellipse = RSuperellipse.fromRectAndCornerRadius(
    Rect.fromLTWH(0.0, 0.0, 250.0, 60.0),
    10.0,
  );
  print('  wide superellipse: ${wideSuperellipse.outerRect}');

  // ========== Comparing with RRect ==========
  print('--- Comparing with Traditional RRect ---');
  final rrect = RRect.fromRectAndRadius(
    Rect.fromLTWH(0.0, 0.0, 100.0, 80.0),
    Radius.circular(10.0),
  );
  print('  RRect (for comparison): $rrect');
  print('  RSuperellipse has smoother corner curves than RRect');
  print('  Used for iOS-style "squircle" shapes');

  print('ClipRSuperellipseLayer test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'ClipRSuperellipseLayer Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('ClipRSuperellipseLayer: ${clipLayer.runtimeType}'),
          Text('RSuperellipse: smooth corner "squircle" shape'),
          Text('Corner radii: 5, 15, 30'),
          Text('ClipBehavior: hardEdge, antiAlias, saveLayer'),
          Text('Various sizes tested: 50x50 to 300x200'),
          Text('iOS-style smooth corners'),
        ],
      ),
    ),
  );
}
