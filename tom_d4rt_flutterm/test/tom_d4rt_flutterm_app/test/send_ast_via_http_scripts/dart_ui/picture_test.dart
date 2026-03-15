// D4rt test script: Tests PictureRecorder, Canvas basics from dart:ui
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('dart:ui picture test executing');

  // ========== PICTURERECORDER ==========
  print('--- PictureRecorder Tests ---');

  final recorder = PictureRecorder();
  print('PictureRecorder created');
  print('  runtimeType: ${recorder.runtimeType}');
  print('  isRecording: ${recorder.isRecording}');

  // ========== CANVAS ==========
  print('--- Canvas Tests ---');

  final canvas = Canvas(recorder);
  print('Canvas created from recorder');
  print('  runtimeType: ${canvas.runtimeType}');
  print('  isRecording: ${recorder.isRecording}');

  // Draw a rectangle
  final rectPaint = Paint()
    ..color = Color(0xFFFF0000)
    ..style = PaintingStyle.fill;
  canvas.drawRect(Rect.fromLTWH(10.0, 10.0, 80.0, 60.0), rectPaint);
  print('Drew red rectangle (10,10,80,60)');

  // Draw a circle
  final circlePaint = Paint()
    ..color = Color(0xFF0000FF)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3.0;
  canvas.drawCircle(Offset(50.0, 50.0), 30.0, circlePaint);
  print('Drew blue circle at (50,50) r=30');

  // Draw a line
  final linePaint = Paint()
    ..color = Color(0xFF00FF00)
    ..strokeWidth = 2.0;
  canvas.drawLine(Offset(0.0, 0.0), Offset(100.0, 100.0), linePaint);
  print('Drew green diagonal line');

  // Draw oval
  final ovalPaint = Paint()
    ..color = Color(0xFFFF00FF)
    ..style = PaintingStyle.fill;
  canvas.drawOval(Rect.fromLTWH(20.0, 30.0, 60.0, 40.0), ovalPaint);
  print('Drew magenta oval');

  // Draw rounded rectangle
  final rrectPaint = Paint()
    ..color = Color(0xFFFF8800)
    ..style = PaintingStyle.fill;
  canvas.drawRRect(
    RRect.fromRectAndRadius(
      Rect.fromLTWH(5.0, 5.0, 90.0, 70.0),
      Radius.circular(10.0),
    ),
    rrectPaint,
  );
  print('Drew orange rounded rectangle');

  // Draw path
  final path = Path();
  path.moveTo(10.0, 80.0);
  path.lineTo(50.0, 10.0);
  path.lineTo(90.0, 80.0);
  path.close();
  final pathPaint = Paint()
    ..color = Color(0xFF00FFFF)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;
  canvas.drawPath(path, pathPaint);
  print('Drew cyan triangle path');

  // Save/restore
  canvas.save();
  print('Canvas save()');

  canvas.translate(10.0, 10.0);
  print('Canvas translate(10, 10)');

  canvas.scale(0.5);
  print('Canvas scale(0.5)');

  canvas.drawRect(Rect.fromLTWH(0.0, 0.0, 50.0, 50.0), rectPaint);
  print('Drew scaled rectangle');

  canvas.restore();
  print('Canvas restore()');

  // Draw arc
  canvas.drawArc(
    Rect.fromLTWH(10.0, 10.0, 80.0, 80.0),
    0.0,
    3.14159,
    false,
    circlePaint,
  );
  print('Drew arc');

  // Draw points
  final pointPaint = Paint()
    ..color = Color(0xFFFFFF00)
    ..strokeWidth = 5.0
    ..strokeCap = StrokeCap.round;
  canvas.drawPoints(PointMode.points, [
    Offset(20.0, 20.0),
    Offset(40.0, 40.0),
    Offset(60.0, 60.0),
  ], pointPaint);
  print('Drew 3 points');

  // ClipRect
  canvas.save();
  canvas.clipRect(Rect.fromLTWH(0.0, 0.0, 50.0, 50.0));
  print('Canvas clipRect applied');
  canvas.restore();

  // ========== END RECORDING ==========
  print('--- End Recording ---');

  final picture = recorder.endRecording();
  print('Picture recorded: ${picture.runtimeType}');
  print('  isRecording after end: ${recorder.isRecording}');

  // ========== POINTMODE ==========
  print('--- PointMode Tests ---');

  for (final mode in PointMode.values) {
    print('  PointMode.$mode: index=${mode.index}');
  }

  // ========== RETURN WIDGET ==========
  print('dart:ui picture test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'dart:ui Picture & Canvas Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text(
            'Classes Tested:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• PictureRecorder - records canvas ops'),
          Text('• Canvas - drawing surface'),
          Text('• Picture - recorded drawing'),
          Text('• PointMode - point rendering mode'),
          SizedBox(height: 16.0),

          Text(
            'Canvas Operations:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFEDE7F6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• drawRect - filled rectangle'),
                Text('• drawCircle - stroked circle'),
                Text('• drawLine - diagonal line'),
                Text('• drawOval - filled oval'),
                Text('• drawRRect - rounded rectangle'),
                Text('• drawPath - triangle path'),
                Text('• drawArc - semicircle arc'),
                Text('• drawPoints - point array'),
                Text('• save/restore - transform stack'),
                Text('• translate/scale - transforms'),
                Text('• clipRect - clipping region'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
