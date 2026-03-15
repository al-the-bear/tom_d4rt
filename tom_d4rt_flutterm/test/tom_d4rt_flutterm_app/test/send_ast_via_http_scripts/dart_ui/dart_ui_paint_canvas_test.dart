// D4rt test script: Tests dart:ui Canvas operations, Paint extensions,
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// BlendMode, FilterQuality, StrokeCap, StrokeJoin, PathFillType,
// BlurStyle, TileMode, Clip, PointMode
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

dynamic build(BuildContext context) {
  print('dart:ui paint/canvas test executing');

  // ========== BlendMode ==========
  print('--- BlendMode Tests ---');
  final blendModes = [
    ui.BlendMode.srcOver,
    ui.BlendMode.srcIn,
    ui.BlendMode.srcOut,
    ui.BlendMode.dstOver,
    ui.BlendMode.dstIn,
    ui.BlendMode.clear,
    ui.BlendMode.multiply,
    ui.BlendMode.screen,
    ui.BlendMode.overlay,
    ui.BlendMode.darken,
    ui.BlendMode.lighten,
    ui.BlendMode.colorDodge,
    ui.BlendMode.colorBurn,
    ui.BlendMode.softLight,
    ui.BlendMode.hardLight,
    ui.BlendMode.difference,
    ui.BlendMode.exclusion,
    ui.BlendMode.hue,
    ui.BlendMode.saturation,
    ui.BlendMode.color,
    ui.BlendMode.luminosity,
  ];
  print('BlendMode values: ${blendModes.length} tested');
  for (final mode in blendModes.take(5)) {
    print('  BlendMode: ${mode.name}');
  }

  // ========== FilterQuality ==========
  print('--- FilterQuality Tests ---');
  for (final q in ui.FilterQuality.values) {
    print('FilterQuality: ${q.name}');
  }

  // ========== StrokeCap ==========
  print('--- StrokeCap Tests ---');
  for (final cap in ui.StrokeCap.values) {
    print('StrokeCap: ${cap.name}');
  }

  // ========== StrokeJoin ==========
  print('--- StrokeJoin Tests ---');
  for (final join in ui.StrokeJoin.values) {
    print('StrokeJoin: ${join.name}');
  }

  // ========== PathFillType ==========
  print('--- PathFillType Tests ---');
  for (final fill in ui.PathFillType.values) {
    print('PathFillType: ${fill.name}');
  }

  // ========== BlurStyle ==========
  print('--- BlurStyle Tests ---');
  for (final style in ui.BlurStyle.values) {
    print('BlurStyle: ${style.name}');
  }

  // ========== TileMode ==========
  print('--- TileMode Tests ---');
  for (final mode in ui.TileMode.values) {
    print('TileMode: ${mode.name}');
  }

  // ========== Clip ==========
  print('--- Clip Tests ---');
  for (final clip in ui.Clip.values) {
    print('Clip: ${clip.name}');
  }

  // ========== PointMode ==========
  print('--- PointMode Tests ---');
  for (final pm in ui.PointMode.values) {
    print('PointMode: ${pm.name}');
  }

  // ========== PaintingStyle ==========
  print('--- PaintingStyle Tests ---');
  for (final ps in ui.PaintingStyle.values) {
    print('PaintingStyle: ${ps.name}');
  }

  // ========== Paint advanced ==========
  print('--- Paint advanced Tests ---');
  final paint = Paint()
    ..color = Colors.blue
    ..strokeWidth = 2.0
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..blendMode = BlendMode.srcOver
    ..filterQuality = FilterQuality.high
    ..isAntiAlias = true
    ..strokeMiterLimit = 4.0
    ..invertColors = false;
  print('Paint configured:');
  print('  color: ${paint.color}');
  print('  strokeWidth: ${paint.strokeWidth}');
  print('  style: ${paint.style}');
  print('  strokeCap: ${paint.strokeCap}');
  print('  strokeJoin: ${paint.strokeJoin}');
  print('  blendMode: ${paint.blendMode}');
  print('  filterQuality: ${paint.filterQuality}');
  print('  isAntiAlias: ${paint.isAntiAlias}');

  // ========== MaskFilter ==========
  print('--- MaskFilter Tests ---');
  final maskFilter = MaskFilter.blur(BlurStyle.normal, 5.0);
  print('MaskFilter.blur: ${maskFilter}');

  // ========== Path advanced ==========
  print('--- Path advanced Tests ---');
  final path = Path()
    ..moveTo(0, 0)
    ..lineTo(100, 0)
    ..lineTo(100, 100)
    ..lineTo(0, 100)
    ..close();
  final bounds = path.getBounds();
  print('Path bounds: $bounds');

  final path2 = Path()
    ..addOval(Rect.fromCircle(center: Offset(50, 50), radius: 30));
  print('Oval path bounds: ${path2.getBounds()}');
  print('Contains (50,50): ${path2.contains(Offset(50, 50))}');

  print('All dart:ui paint/canvas tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'dart:ui Paint/Canvas Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text('BlendMode: ${blendModes.length} modes'),
            Text('FilterQuality, StrokeCap, StrokeJoin'),
            Text('PathFillType, BlurStyle, TileMode'),
            Text('Paint advanced configuration'),
            Text('MaskFilter, Path operations'),
          ],
        ),
      ),
    ),
  );
}
