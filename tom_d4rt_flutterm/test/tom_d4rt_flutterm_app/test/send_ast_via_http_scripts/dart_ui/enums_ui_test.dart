// D4rt test script: Tests dart:ui enums - Clip, PathFillType, PathOperation,
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// StrokeCap, StrokeJoin, PaintingStyle, BlendMode, TileMode, VertexMode,
// PointMode, ImageByteFormat, PixelFormat, Brightness, AppLifecycleState,
// PointerDeviceKind, PointerSignalKind
import 'dart:ui';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('dart:ui enums test executing');

  // ========== Clip ==========
  print('--- Clip Tests ---');
  print('Clip.none: ${Clip.none}');
  print('Clip.hardEdge: ${Clip.hardEdge}');
  print('Clip.antiAlias: ${Clip.antiAlias}');
  print('Clip.antiAliasWithSaveLayer: ${Clip.antiAliasWithSaveLayer}');
  print('Clip.values: ${Clip.values}');

  // ========== PathFillType ==========
  print('--- PathFillType Tests ---');
  print('PathFillType.nonZero: ${PathFillType.nonZero}');
  print('PathFillType.evenOdd: ${PathFillType.evenOdd}');

  // ========== PathOperation ==========
  print('--- PathOperation Tests ---');
  print('PathOperation.difference: ${PathOperation.difference}');
  print('PathOperation.intersect: ${PathOperation.intersect}');
  print('PathOperation.union: ${PathOperation.union}');
  print('PathOperation.xor: ${PathOperation.xor}');
  print('PathOperation.reverseDifference: ${PathOperation.reverseDifference}');

  // ========== StrokeCap ==========
  print('--- StrokeCap Tests ---');
  print('StrokeCap.butt: ${StrokeCap.butt}');
  print('StrokeCap.round: ${StrokeCap.round}');
  print('StrokeCap.square: ${StrokeCap.square}');

  // ========== StrokeJoin ==========
  print('--- StrokeJoin Tests ---');
  print('StrokeJoin.miter: ${StrokeJoin.miter}');
  print('StrokeJoin.round: ${StrokeJoin.round}');
  print('StrokeJoin.bevel: ${StrokeJoin.bevel}');

  // ========== PaintingStyle ==========
  print('--- PaintingStyle Tests ---');
  print('PaintingStyle.fill: ${PaintingStyle.fill}');
  print('PaintingStyle.stroke: ${PaintingStyle.stroke}');

  // ========== BlendMode ==========
  print('--- BlendMode Tests ---');
  print('BlendMode.clear: ${BlendMode.clear}');
  print('BlendMode.src: ${BlendMode.src}');
  print('BlendMode.dst: ${BlendMode.dst}');
  print('BlendMode.srcOver: ${BlendMode.srcOver}');
  print('BlendMode.dstOver: ${BlendMode.dstOver}');
  print('BlendMode.srcIn: ${BlendMode.srcIn}');
  print('BlendMode.multiply: ${BlendMode.multiply}');
  print('BlendMode.screen: ${BlendMode.screen}');
  print('BlendMode.overlay: ${BlendMode.overlay}');
  print('BlendMode.values: ${BlendMode.values.length} values');

  // ========== TileMode ==========
  print('--- TileMode Tests ---');
  print('TileMode.clamp: ${TileMode.clamp}');
  print('TileMode.repeated: ${TileMode.repeated}');
  print('TileMode.mirror: ${TileMode.mirror}');
  print('TileMode.decal: ${TileMode.decal}');

  // ========== VertexMode ==========
  print('--- VertexMode Tests ---');
  print('VertexMode.triangles: ${VertexMode.triangles}');
  print('VertexMode.triangleStrip: ${VertexMode.triangleStrip}');
  print('VertexMode.triangleFan: ${VertexMode.triangleFan}');

  // ========== PointMode ==========
  print('--- PointMode Tests ---');
  print('PointMode.points: ${PointMode.points}');
  print('PointMode.lines: ${PointMode.lines}');
  print('PointMode.polygon: ${PointMode.polygon}');

  // ========== ImageByteFormat ==========
  print('--- ImageByteFormat Tests ---');
  print('ImageByteFormat.rawRgba: ${ImageByteFormat.rawRgba}');
  print('ImageByteFormat.rawStraightRgba: ${ImageByteFormat.rawStraightRgba}');
  print('ImageByteFormat.rawUnmodified: ${ImageByteFormat.rawUnmodified}');
  print('ImageByteFormat.png: ${ImageByteFormat.png}');

  // ========== PixelFormat ==========
  print('--- PixelFormat Tests ---');
  print('PixelFormat.rgba8888: ${PixelFormat.rgba8888}');
  print('PixelFormat.bgra8888: ${PixelFormat.bgra8888}');

  // ========== Brightness ==========
  print('--- Brightness Tests ---');
  print('Brightness.dark: ${Brightness.dark}');
  print('Brightness.light: ${Brightness.light}');

  // ========== AppLifecycleState ==========
  print('--- AppLifecycleState Tests ---');
  print('AppLifecycleState.detached: ${AppLifecycleState.detached}');
  print('AppLifecycleState.resumed: ${AppLifecycleState.resumed}');
  print('AppLifecycleState.inactive: ${AppLifecycleState.inactive}');
  print('AppLifecycleState.hidden: ${AppLifecycleState.hidden}');
  print('AppLifecycleState.paused: ${AppLifecycleState.paused}');
  print('AppLifecycleState.values: ${AppLifecycleState.values}');

  // ========== PointerDeviceKind ==========
  print('--- PointerDeviceKind Tests ---');
  print('PointerDeviceKind.touch: ${PointerDeviceKind.touch}');
  print('PointerDeviceKind.mouse: ${PointerDeviceKind.mouse}');
  print('PointerDeviceKind.stylus: ${PointerDeviceKind.stylus}');
  print(
    'PointerDeviceKind.invertedStylus: ${PointerDeviceKind.invertedStylus}',
  );
  print('PointerDeviceKind.trackpad: ${PointerDeviceKind.trackpad}');
  print('PointerDeviceKind.unknown: ${PointerDeviceKind.unknown}');

  // ========== PointerSignalKind ==========
  print('--- PointerSignalKind Tests ---');
  print('PointerSignalKind.none: ${PointerSignalKind.none}');
  print('PointerSignalKind.scroll: ${PointerSignalKind.scroll}');
  print(
    'PointerSignalKind.scrollInertiaCancel: ${PointerSignalKind.scrollInertiaCancel}',
  );
  print('PointerSignalKind.scale: ${PointerSignalKind.scale}');
  print('PointerSignalKind.unknown: ${PointerSignalKind.unknown}');

  // ========== Locale ==========
  print('--- Locale Tests ---');
  final locale1 = Locale('en', 'US');
  print('Locale: ${locale1.languageCode}_${locale1.countryCode}');
  final locale2 = Locale('de');
  print('Locale de: ${locale2.languageCode}');
  final locale3 = Locale.fromSubtags(
    languageCode: 'zh',
    scriptCode: 'Hans',
    countryCode: 'CN',
  );
  print('Locale zh_Hans_CN: ${locale3}');

  print('All dart:ui enum tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'dart:ui Enums Test',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('BlendMode values: ${BlendMode.values.length}'),
            Text('Brightness: ${Brightness.light}'),
            Text('Locale: ${locale1}'),
          ],
        ),
      ),
    ),
  );
}
