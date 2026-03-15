// D4rt test script: Tests Canvas and PictureRecorder from dart:ui
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Canvas test executing');

  // ========== PICTURE RECORDER ==========
  print('--- PictureRecorder Tests ---');

  final recorder = PictureRecorder();
  print('PictureRecorder created: ${recorder.runtimeType}');
  print('  isRecording: ${recorder.isRecording}');

  // ========== CANVAS CREATION ==========
  print('--- Canvas Creation ---');

  final canvas = Canvas(recorder, Rect.fromLTWH(0, 0, 200, 200));
  print('Canvas created: ${canvas.runtimeType}');
  print('  isRecording: ${recorder.isRecording}');

  // ========== PAINT OBJECT ==========
  print('--- Paint Tests ---');

  final redPaint = Paint()..color = Color(0xFFFF0000);
  print('Red paint created: color=${redPaint.color}');

  final bluePaint = Paint()..color = Color(0xFF0000FF);
  print('Blue paint created: color=${bluePaint.color}');

  final styledPaint = Paint()
    ..color = Color(0xFF00FF00)
    ..strokeWidth = 3.0
    ..style = PaintingStyle.stroke;
  print('Styled paint: color=${styledPaint.color}');
  print('  strokeWidth: ${styledPaint.strokeWidth}');
  print('  style: ${styledPaint.style}');

  final antiAliasPaint = Paint()
    ..color = Color(0xFFFFFF00)
    ..isAntiAlias = true;
  print('AntiAlias paint: isAntiAlias=${antiAliasPaint.isAntiAlias}');

  // ========== DRAW SHAPES ==========
  print('--- Drawing Shapes ---');

  // Draw rectangle
  canvas.drawRect(Rect.fromLTWH(10, 10, 80, 80), redPaint);
  print('Drew red rectangle at (10,10) 80x80');

  // Draw circle
  canvas.drawCircle(Offset(150, 100), 40, bluePaint);
  print('Drew blue circle at (150,100) radius=40');

  // Draw line
  final linePaint = Paint()
    ..strokeWidth = 2.0
    ..color = Color(0xFF000000);
  canvas.drawLine(Offset(0, 0), Offset(200, 200), linePaint);
  print('Drew diagonal line from (0,0) to (200,200)');

  // Draw oval
  canvas.drawOval(Rect.fromLTWH(20, 120, 60, 40), styledPaint);
  print('Drew green oval outline at (20,120) 60x40');

  // Draw rounded rect
  final rrect = RRect.fromRectAndRadius(
    Rect.fromLTWH(100, 10, 80, 60),
    Radius.circular(10),
  );
  canvas.drawRRect(rrect, bluePaint);
  print('Drew blue rounded rect at (100,10) 80x60 r=10');

  // Draw arc
  canvas.drawArc(Rect.fromLTWH(10, 50, 100, 100), 0.0, 3.14, false, redPaint);
  print('Drew red arc');

  // Draw points
  final points = [Offset(10, 10), Offset(50, 50), Offset(90, 30)];
  canvas.drawPoints(PointMode.points, points, redPaint);
  print('Drew 3 red points');

  // ========== CANVAS TRANSFORMATIONS ==========
  print('--- Canvas Transformations ---');

  canvas.save();
  print('Canvas state saved');

  canvas.translate(10.0, 10.0);
  print('Canvas translated by (10, 10)');

  canvas.scale(1.5, 1.5);
  print('Canvas scaled by (1.5, 1.5)');

  canvas.rotate(0.1);
  print('Canvas rotated by 0.1 radians');

  canvas.drawRect(Rect.fromLTWH(0, 0, 20, 20), redPaint);
  print('Drew transformed rectangle');

  canvas.restore();
  print('Canvas state restored');

  // Save/restore count
  canvas.save();
  canvas.save();
  print('getSaveCount: ${canvas.getSaveCount()}');
  canvas.restore();
  canvas.restore();

  // ========== CANVAS CLIPPING ==========
  print('--- Canvas Clipping ---');

  canvas.save();
  canvas.clipRect(Rect.fromLTWH(50, 50, 100, 100));
  print('Clipped to rect (50,50) 100x100');
  canvas.drawRect(Rect.fromLTWH(0, 0, 200, 200), bluePaint);
  print('Drew rect (clipped to clip region)');
  canvas.restore();

  // ========== PATH DRAWING ==========
  print('--- Path Drawing ---');

  final path = Path();
  path.moveTo(10, 10);
  path.lineTo(50, 80);
  path.lineTo(90, 10);
  path.close();
  canvas.drawPath(path, styledPaint);
  print('Drew triangle path');

  // ========== END RECORDING ==========
  print('--- End Recording ---');

  final picture = recorder.endRecording();
  print('Recording ended: ${picture.runtimeType}');
  print('  recorder.isRecording: ${recorder.isRecording}');

  // ========== POINT MODE ENUM ==========
  print('--- PointMode values ---');
  print('PointMode.points: ${PointMode.points}');
  print('PointMode.lines: ${PointMode.lines}');
  print('PointMode.polygon: ${PointMode.polygon}');

  // ========== PAINTING STYLE ENUM ==========
  print('--- PaintingStyle values ---');
  print('PaintingStyle.fill: ${PaintingStyle.fill}');
  print('PaintingStyle.stroke: ${PaintingStyle.stroke}');

  print('Canvas test completed');
  return Container(child: Text('Canvas test passed'));
}
