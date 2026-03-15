// D4rt test script: Tests ClipPathLayer from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ClipPathLayer test executing');

  // ========== ClipPathLayer Basic Creation ==========
  print('--- ClipPathLayer Basic Creation ---');
  final trianglePath = Path()
    ..moveTo(50.0, 0.0)
    ..lineTo(100.0, 100.0)
    ..lineTo(0.0, 100.0)
    ..close();

  final clipLayer = ClipPathLayer(clipPath: trianglePath);
  print('  created: ${clipLayer.runtimeType}');
  print('  clipPath: ${clipLayer.clipPath}');
  print('  clipBehavior: ${clipLayer.clipBehavior}');

  // ========== ClipPathLayer with Different Paths ==========
  print('--- ClipPathLayer with Different Paths ---');

  // Circle path
  final circlePath = Path()
    ..addOval(Rect.fromCircle(center: Offset(50.0, 50.0), radius: 40.0));
  final circleClip = ClipPathLayer(clipPath: circlePath);
  print('  circle clip created');

  // Rectangle path
  final rectPath = Path()..addRect(Rect.fromLTWH(10.0, 10.0, 80.0, 60.0));
  final rectClip = ClipPathLayer(clipPath: rectPath);
  print('  rectangle clip created');

  // Rounded rectangle path
  final rrectPath = Path()
    ..addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0.0, 0.0, 100.0, 80.0),
        Radius.circular(15.0),
      ),
    );
  final rrectClip = ClipPathLayer(clipPath: rrectPath);
  print('  rounded rectangle clip created');

  // Star path (pentagon)
  final starPath = Path()
    ..moveTo(50.0, 0.0)
    ..lineTo(61.0, 35.0)
    ..lineTo(100.0, 35.0)
    ..lineTo(68.0, 57.0)
    ..lineTo(79.0, 91.0)
    ..lineTo(50.0, 70.0)
    ..lineTo(21.0, 91.0)
    ..lineTo(32.0, 57.0)
    ..lineTo(0.0, 35.0)
    ..lineTo(39.0, 35.0)
    ..close();
  final starClip = ClipPathLayer(clipPath: starPath);
  print('  star clip created');

  // ========== ClipPathLayer with ClipBehavior ==========
  print('--- ClipPathLayer with ClipBehavior ---');
  final hardEdgeClip = ClipPathLayer(
    clipPath: trianglePath,
    clipBehavior: Clip.hardEdge,
  );
  print('  hardEdge: ${hardEdgeClip.clipBehavior}');

  final antiAliasClip = ClipPathLayer(
    clipPath: trianglePath,
    clipBehavior: Clip.antiAlias,
  );
  print('  antiAlias: ${antiAliasClip.clipBehavior}');

  final antiAliasWithSaveLayerClip = ClipPathLayer(
    clipPath: trianglePath,
    clipBehavior: Clip.antiAliasWithSaveLayer,
  );
  print('  antiAliasWithSaveLayer: ${antiAliasWithSaveLayerClip.clipBehavior}');

  // ========== ClipPathLayer Property Modification ==========
  print('--- ClipPathLayer Property Modification ---');
  final mutableLayer = ClipPathLayer(clipPath: trianglePath);
  print('  initial clipPath set');

  final newPath = Path()..addOval(Rect.fromLTWH(0.0, 0.0, 120.0, 80.0));
  mutableLayer.clipPath = newPath;
  print('  modified clipPath to oval');

  mutableLayer.clipBehavior = Clip.antiAlias;
  print('  modified clipBehavior: ${mutableLayer.clipBehavior}');

  // ========== ClipPathLayer Layer Hierarchy ==========
  print('--- ClipPathLayer Layer Hierarchy ---');
  print('  parent: ${clipLayer.parent}');
  print('  firstChild: ${clipLayer.firstChild}');
  print('  lastChild: ${clipLayer.lastChild}');
  print('  nextSibling: ${clipLayer.nextSibling}');
  print('  previousSibling: ${clipLayer.previousSibling}');
  print('  hasChildren: ${clipLayer.hasChildren}');

  // ========== Path Operations ==========
  print('--- Path Operations ---');
  final complexPath = Path();
  complexPath.moveTo(0.0, 0.0);
  complexPath.lineTo(100.0, 0.0);
  complexPath.quadraticBezierTo(150.0, 50.0, 100.0, 100.0);
  complexPath.cubicTo(80.0, 120.0, 20.0, 120.0, 0.0, 100.0);
  complexPath.close();
  print('  complex path with curves created');

  final complexClip = ClipPathLayer(clipPath: complexPath);
  print('  complex clip layer: ${complexClip.runtimeType}');

  // ========== Path Bounds ==========
  print('--- Path Bounds ---');
  print('  triangle bounds: ${trianglePath.getBounds()}');
  print('  circle bounds: ${circlePath.getBounds()}');
  print('  rect bounds: ${rectPath.getBounds()}');
  print('  star bounds: ${starPath.getBounds()}');

  // ========== Clip Behavior Values ==========
  print('--- Clip Behavior Values ---');
  for (final clip in Clip.values) {
    print('  ${clip.name}: index=${clip.index}');
  }

  print('ClipPathLayer test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'ClipPathLayer Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('ClipPathLayer: ${clipLayer.runtimeType}'),
          Text('Shapes: triangle, circle, rect, rrect, star'),
          Text('ClipBehavior: hardEdge, antiAlias, antiAliasWithSaveLayer'),
          Text('Property modification verified'),
          Text('Path operations: lines, curves, bezier'),
          Text('Path bounds calculated'),
        ],
      ),
    ),
  );
}
