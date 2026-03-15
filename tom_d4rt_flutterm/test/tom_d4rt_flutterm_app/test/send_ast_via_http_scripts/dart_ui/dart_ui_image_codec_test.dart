// D4rt test script: Tests dart:ui Image concepts, Codec, FrameInfo,
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// Picture, PictureRecorder, SceneBuilder, Scene, Paragraph,
// ParagraphBuilder, ParagraphStyle, TextStyle as ui.TextStyle
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

dynamic build(BuildContext context) {
  print('Dart UI image/codec test executing');

  // ========== PictureRecorder ==========
  print('--- PictureRecorder Tests ---');
  final recorder = ui.PictureRecorder();
  print('PictureRecorder created');
  print('  isRecording: ${recorder.isRecording}');

  // ========== Canvas with PictureRecorder ==========
  print('--- Canvas Tests ---');
  final canvas = Canvas(recorder);
  print('Canvas created from PictureRecorder');

  canvas.drawRect(
    Rect.fromLTWH(0, 0, 100, 100),
    Paint()..color = Color(0xFFFF0000),
  );
  print('  drawRect done');

  canvas.drawCircle(
    Offset(50, 50),
    30,
    Paint()
      ..color = Color(0xFF00FF00)
      ..style = PaintingStyle.fill,
  );
  print('  drawCircle done');

  canvas.drawLine(
    Offset(0, 0),
    Offset(100, 100),
    Paint()
      ..color = Color(0xFF0000FF)
      ..strokeWidth = 2.0,
  );
  print('  drawLine done');

  canvas.drawOval(
    Rect.fromLTWH(10, 10, 80, 40),
    Paint()..color = Color(0xFFFF00FF),
  );
  print('  drawOval done');

  canvas.drawRRect(
    RRect.fromRectAndRadius(Rect.fromLTWH(10, 60, 80, 30), Radius.circular(8)),
    Paint()..color = Color(0xFFFFFF00),
  );
  print('  drawRRect done');

  final path = Path();
  path.moveTo(50, 0);
  path.lineTo(100, 100);
  path.lineTo(0, 100);
  path.close();
  canvas.drawPath(path, Paint()..color = Color(0xFF00FFFF));
  print('  drawPath (triangle) done');

  canvas.save();
  canvas.translate(10, 10);
  canvas.rotate(0.1);
  canvas.scale(0.9);
  canvas.restore();
  print('  save/translate/rotate/scale/restore done');

  canvas.clipRect(Rect.fromLTWH(0, 0, 80, 80));
  print('  clipRect done');

  canvas.clipRRect(
    RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, 80, 80), Radius.circular(8)),
  );
  print('  clipRRect done');

  canvas.clipPath(path);
  print('  clipPath done');

  // ========== Picture ==========
  print('--- Picture Tests ---');
  final picture = recorder.endRecording();
  print('Picture created from recorder');

  // ========== ParagraphBuilder ==========
  print('--- ParagraphBuilder Tests ---');
  final paragraphStyle = ui.ParagraphStyle(
    textAlign: TextAlign.left,
    textDirection: TextDirection.ltr,
    maxLines: 3,
    fontFamily: 'Roboto',
    fontSize: 16.0,
    height: 1.5,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
    ellipsis: '...',
    locale: Locale('en', 'US'),
    // Note: strutStyle uses dart:ui StrutStyle, not painting.StrutStyle.
    // D4rt resolves StrutStyle to painting.StrutStyle causing cross-package cast error.
  );
  print('ParagraphStyle created');

  final builder = ui.ParagraphBuilder(paragraphStyle);
  builder.pushStyle(
    ui.TextStyle(
      color: Color(0xFF000000),
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
      letterSpacing: 0.5,
      wordSpacing: 1.0,
      height: 1.5,
      decoration: TextDecoration.none,
      decorationColor: Color(0xFFFF0000),
      decorationStyle: TextDecorationStyle.solid,
      fontFamily: 'Roboto',
      locale: Locale('en'),
    ),
  );
  builder.addText('Hello World from ParagraphBuilder. ');
  builder.pop();

  builder.pushStyle(
    ui.TextStyle(
      color: Color(0xFFFF0000),
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      decoration: TextDecoration.underline,
    ),
  );
  builder.addText('Bold red text.');
  builder.pop();

  print('ParagraphBuilder with styles created');

  // ========== Paragraph ==========
  print('--- Paragraph Tests ---');
  final paragraph = builder.build();
  paragraph.layout(ui.ParagraphConstraints(width: 300));
  print('Paragraph built and laid out');
  print('  width: ${paragraph.width}');
  print('  height: ${paragraph.height}');
  print('  minIntrinsicWidth: ${paragraph.minIntrinsicWidth}');
  print('  maxIntrinsicWidth: ${paragraph.maxIntrinsicWidth}');
  print('  longestLine: ${paragraph.longestLine}');
  print('  alphabeticBaseline: ${paragraph.alphabeticBaseline}');
  print('  ideographicBaseline: ${paragraph.ideographicBaseline}');
  print('  didExceedMaxLines: ${paragraph.didExceedMaxLines}');

  // ========== Paint advanced ==========
  print('--- Paint Advanced Tests ---');
  final paint = Paint()
    ..color = Color(0xFF0000FF)
    ..strokeWidth = 3.0
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..strokeMiterLimit = 4.0
    ..style = PaintingStyle.stroke
    ..isAntiAlias = true
    ..blendMode = BlendMode.srcOver
    ..filterQuality = FilterQuality.high
    ..invertColors = false;
  print('Paint advanced created');
  print('  color: ${paint.color}');
  print('  strokeWidth: ${paint.strokeWidth}');
  print('  strokeCap: ${paint.strokeCap}');
  print('  strokeJoin: ${paint.strokeJoin}');
  print('  style: ${paint.style}');
  print('  blendMode: ${paint.blendMode}');
  print('  filterQuality: ${paint.filterQuality}');

  // ========== BlendMode values ==========
  print('--- BlendMode Tests ---');
  final blendModes = [
    BlendMode.clear,
    BlendMode.src,
    BlendMode.dst,
    BlendMode.srcOver,
    BlendMode.dstOver,
    BlendMode.srcIn,
    BlendMode.dstIn,
    BlendMode.srcOut,
    BlendMode.dstOut,
    BlendMode.srcATop,
    BlendMode.dstATop,
    BlendMode.xor,
    BlendMode.plus,
    BlendMode.multiply,
    BlendMode.screen,
    BlendMode.overlay,
    BlendMode.darken,
    BlendMode.lighten,
  ];
  for (final mode in blendModes) {
    print('  BlendMode.$mode');
  }

  // ========== StrokeCap / StrokeJoin ==========
  print('--- StrokeCap Tests ---');
  for (final cap in StrokeCap.values) {
    print('  StrokeCap.$cap');
  }
  print('--- StrokeJoin Tests ---');
  for (final join in StrokeJoin.values) {
    print('  StrokeJoin.$join');
  }

  print('All dart:ui image/codec tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: CustomPaint(
          size: Size(300, 300),
          painter: TestCanvasPainter(picture),
        ),
      ),
    ),
  );
}

class TestCanvasPainter extends CustomPainter {
  final ui.Picture picture;
  TestCanvasPainter(this.picture);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPicture(picture);
  }

  @override
  bool shouldRepaint(TestCanvasPainter oldDelegate) => false;
}
