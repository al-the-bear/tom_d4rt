// D4rt test script: Tests Paint, Canvas, PictureRecorder, MaskFilter, ColorFilter, ImageFilter
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('dart:ui paint/canvas tests executing');

  // ========== Paint comprehensive ==========
  print('--- Paint Tests ---');
  final paint1 = Paint()
    ..color = Color.fromARGB(255, 255, 0, 0)
    ..strokeWidth = 3.0
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.bevel
    ..blendMode = BlendMode.srcOver
    ..filterQuality = FilterQuality.high
    ..isAntiAlias = true
    ..strokeMiterLimit = 6.0
    ..invertColors = false;
  print('paint1 color: ${paint1.color}');
  print('paint1 strokeWidth: ${paint1.strokeWidth}');
  print('paint1 style: ${paint1.style}');
  print('paint1 strokeCap: ${paint1.strokeCap}');
  print('paint1 strokeJoin: ${paint1.strokeJoin}');
  print('paint1 blendMode: ${paint1.blendMode}');
  print('paint1 filterQuality: ${paint1.filterQuality}');
  print('paint1 isAntiAlias: ${paint1.isAntiAlias}');

  final paint2 = Paint()
    ..color = Color.fromARGB(128, 0, 255, 0)
    ..style = PaintingStyle.fill;
  print('paint2 style: ${paint2.style}');

  // ========== MaskFilter ==========
  print('--- MaskFilter Tests ---');
  final mask1 = MaskFilter.blur(BlurStyle.normal, 5.0);
  print('MaskFilter.blur(normal, 5): $mask1');
  final mask2 = MaskFilter.blur(BlurStyle.inner, 3.0);
  print('MaskFilter.blur(inner, 3): $mask2');
  final mask3 = MaskFilter.blur(BlurStyle.outer, 8.0);
  print('MaskFilter.blur(outer, 8): $mask3');
  final mask4 = MaskFilter.blur(BlurStyle.solid, 2.0);
  print('MaskFilter.blur(solid, 2): $mask4');

  // ========== ColorFilter ==========
  print('--- ColorFilter Tests ---');
  final cf1 = ColorFilter.mode(Colors.red, BlendMode.srcIn);
  print('ColorFilter.mode(red, srcIn): $cf1');
  final cf2 = ColorFilter.linearToSrgbGamma();
  print('ColorFilter.linearToSrgbGamma: $cf2');
  final cf3 = ColorFilter.srgbToLinearGamma();
  print('ColorFilter.srgbToLinearGamma: $cf3');
  final cf4 = ColorFilter.matrix(<double>[
    1,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);
  print('ColorFilter.matrix (identity): $cf4');

  // ========== ImageFilter ==========
  print('--- ImageFilter Tests ---');
  final imgf1 = ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0);
  print('ImageFilter.blur(5,5): $imgf1');
  final imgf2 = ui.ImageFilter.blur(sigmaX: 0.0, sigmaY: 10.0);
  print('ImageFilter.blur(0,10): $imgf2');
  final imgf3 = ui.ImageFilter.blur(
    sigmaX: 3.0,
    sigmaY: 3.0,
    tileMode: TileMode.clamp,
  );
  print('ImageFilter.blur w/ clamp: $imgf3');

  // ========== Canvas + PictureRecorder ==========
  print('--- Canvas/PictureRecorder Tests ---');
  final recorder = ui.PictureRecorder();
  print('PictureRecorder created: ${recorder.runtimeType}');
  print('isRecording before: ${recorder.isRecording}');

  final canvas = Canvas(recorder, Rect.fromLTWH(0, 0, 300, 200));
  print('Canvas created');

  canvas.drawRect(Rect.fromLTWH(10, 10, 100, 80), paint1);
  print('drawRect done');

  canvas.drawCircle(Offset(150.0, 100.0), 40.0, paint2);
  print('drawCircle done');

  canvas.drawLine(Offset(0, 0), Offset(300.0, 200.0), paint1);
  print('drawLine done');

  final path = Path()
    ..moveTo(50, 50)
    ..lineTo(100, 10)
    ..lineTo(150, 50)
    ..close();
  canvas.drawPath(path, paint2);
  print('drawPath done');

  canvas.drawOval(Rect.fromLTWH(180, 20, 80, 50), paint1);
  print('drawOval done');

  canvas.drawRRect(RRect.fromLTRBXY(200, 80, 290, 180, 10, 10), paint2);
  print('drawRRect done');

  canvas.save();
  canvas.translate(10.0, 10.0);
  canvas.restore();
  print('save/translate/restore done');

  canvas.clipRect(Rect.fromLTWH(0, 0, 300, 200));
  print('clipRect done');

  final picture = recorder.endRecording();
  print('Picture recorded: ${picture.runtimeType}');
  print('isRecording after: ${recorder.isRecording}');

  print('All paint/canvas tests passed');

  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'dart:ui Paint/Canvas Tests',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Paint: stroke=${paint1.strokeWidth}, cap=${paint1.strokeCap}',
            ),
            Text('MaskFilter: 4 blur styles'),
            Text('ColorFilter: mode, gamma, matrix'),
            Text('ImageFilter: 3 blur configs'),
            Text('Canvas: rect, circle, line, path, oval, rrect'),
            Text('PictureRecorder: record + endRecording'),
          ],
        ),
      ),
    ),
  );
}
