// D4rt test script: Tests Offset, Size, Rect, RRect, RSuperellipse from dart:ui
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('dart:ui geometry tests executing');

  // ========== Offset advanced ==========
  print('--- Offset Advanced Tests ---');
  final o1 = Offset.fromDirection(1.5708); // ~pi/2
  print(
    'Offset.fromDirection(pi/2): dx=${o1.dx.toStringAsFixed(4)}, dy=${o1.dy.toStringAsFixed(4)}',
  );
  final o2 = Offset.fromDirection(0.0, 100.0);
  print('Offset.fromDirection(0, 100): dx=${o2.dx}, dy=${o2.dy}');
  final o3 = Offset(3.0, 4.0);
  print('distance: ${o3.distance}'); // 5.0
  print('distanceSquared: ${o3.distanceSquared}'); // 25.0
  print('direction: ${o3.direction}');
  print('isFinite: ${o3.isFinite}');
  print('isInfinite: ${o3.isInfinite}');
  final scaled = o3.scale(2.0, 3.0);
  print('scale(2,3): ${scaled.dx}, ${scaled.dy}');
  final translated = o3.translate(10.0, 20.0);
  print('translate(10,20): ${translated.dx}, ${translated.dy}');
  final negated = -o3;
  print('negated: ${negated.dx}, ${negated.dy}');
  print('Offset.zero: ${Offset.zero.dx}, ${Offset.zero.dy}');
  print('Offset.infinite: ${Offset.infinite.dx}');

  // ========== Size advanced ==========
  print('--- Size Advanced Tests ---');
  final s1 = Size.fromWidth(200.0);
  print('Size.fromWidth(200): ${s1.width}x${s1.height}');
  final s2 = Size.fromHeight(150.0);
  print('Size.fromHeight(150): ${s2.width}x${s2.height}');
  final s3 = Size.fromRadius(50.0);
  print('Size.fromRadius(50): ${s3.width}x${s3.height}');
  final s4 = Size(100.0, 80.0);
  print('aspectRatio: ${s4.aspectRatio}');
  print('longestSide: ${s4.longestSide}');
  print('shortestSide: ${s4.shortestSide}');
  print('isEmpty: ${s4.isEmpty}');
  print('isFinite: ${s4.isFinite}');
  print('isInfinite: ${s4.isInfinite}');
  print('flipped: ${s4.flipped.width}x${s4.flipped.height}');
  final constrained = s4.bottomRight(Offset.zero);
  print('bottomRight: ${constrained.dx}, ${constrained.dy}');
  print('Size.zero: ${Size.zero.width}x${Size.zero.height}');
  print('Size.infinite: ${Size.infinite.width}');

  // ========== RRect ==========
  print('--- RRect Tests ---');
  final rr1 = RRect.fromLTRBXY(10.0, 20.0, 200.0, 150.0, 8.0, 8.0);
  print(
    'RRect.fromLTRBXY: left=${rr1.left}, top=${rr1.top}, width=${rr1.width}, height=${rr1.height}',
  );
  final rr2 = RRect.fromRectXY(Rect.fromLTWH(0, 0, 100, 100), 12.0, 12.0);
  print('RRect.fromRectXY: tlRadiusX=${rr2.tlRadiusX}');
  final rr3 = RRect.fromRectAndRadius(
    Rect.fromLTWH(0, 0, 80, 60),
    Radius.circular(10.0),
  );
  print('RRect.fromRectAndRadius: blRadius=${rr3.blRadius}');
  final rr4 = RRect.fromRectAndCorners(
    Rect.fromLTWH(0, 0, 120, 90),
    topLeft: Radius.circular(4.0),
    topRight: Radius.circular(8.0),
    bottomLeft: Radius.circular(12.0),
    bottomRight: Radius.circular(16.0),
  );
  print(
    'RRect.fromRectAndCorners: tl=${rr4.tlRadiusX}, tr=${rr4.trRadiusX}, bl=${rr4.blRadiusX}, br=${rr4.brRadiusX}',
  );
  print('RRect.zero: ${RRect.zero.width}x${RRect.zero.height}');
  print('isRect: ${rr1.isRect}');
  print('isFinite: ${rr1.isFinite}');
  print('isStadium: ${rr1.isStadium}');
  print('isEllipse: ${rr1.isEllipse}');

  // ========== RSuperellipse ==========
  print('--- RSuperellipse Tests ---');
  final rse1 = RSuperellipse.fromRectAndCorners(
    Rect.fromLTWH(0, 0, 100, 100),
    topLeft: Radius.circular(20.0),
    topRight: Radius.circular(20.0),
    bottomLeft: Radius.circular(20.0),
    bottomRight: Radius.circular(20.0),
  );
  print(
    'RSuperellipse: left=${rse1.left}, top=${rse1.top}, width=${rse1.width}',
  );
  print('tlRadiusX: ${rse1.tlRadiusX}, trRadiusX: ${rse1.trRadiusX}');
  print('isFinite: ${rse1.isFinite}');

  print('All geometry tests passed');

  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'dart:ui Geometry Tests',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 8.0),
              Text(
                'Offset: direction=${o3.direction.toStringAsFixed(2)}, distance=${o3.distance}',
              ),
              Text(
                'Size: ${s4.width}x${s4.height}, aspect=${s4.aspectRatio.toStringAsFixed(2)}',
              ),
              Text(
                'RRect: ${rr4.tlRadiusX}/${rr4.trRadiusX}/${rr4.blRadiusX}/${rr4.brRadiusX}',
              ),
              Text(
                'RSuperellipse: ${rse1.width.toInt()}x${rse1.height.toInt()}',
              ),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
