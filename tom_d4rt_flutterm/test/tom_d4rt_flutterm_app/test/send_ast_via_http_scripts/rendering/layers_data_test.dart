// D4rt test script: Tests OpacityLayer, TransformLayer, ClipRectLayer, ClipRRectLayer, ImageFilterLayer, BackdropFilterLayer
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('Layers data test executing');

  // ========== OPACITY LAYER ==========
  print('--- OpacityLayer Tests ---');

  final opacityLayer = OpacityLayer(alpha: 128);
  print('OpacityLayer(128) created: ${opacityLayer.runtimeType}');
  print('  alpha: ${opacityLayer.alpha}');

  final opacityLayerFull = OpacityLayer(alpha: 255);
  print('OpacityLayer(255) alpha: ${opacityLayerFull.alpha}');

  final opacityLayerZero = OpacityLayer(alpha: 0);
  print('OpacityLayer(0) alpha: ${opacityLayerZero.alpha}');

  final opacityLayerWithOffset = OpacityLayer(
    alpha: 200,
    offset: Offset(10.0, 20.0),
  );
  print('OpacityLayer(200, offset):');
  print('  alpha: ${opacityLayerWithOffset.alpha}');
  print('  offset: ${opacityLayerWithOffset.offset}');

  // Modify alpha
  opacityLayer.alpha = 64;
  print('After setting alpha to 64: ${opacityLayer.alpha}');

  // Modify offset
  opacityLayer.offset = Offset(5.0, 10.0);
  print('After setting offset: ${opacityLayer.offset}');

  // ========== TRANSFORM LAYER ==========
  print('--- TransformLayer Tests ---');

  final transformLayer = TransformLayer();
  print('TransformLayer() created: ${transformLayer.runtimeType}');

  final transformLayerIdentity = TransformLayer(transform: Matrix4.identity());
  print(
    'TransformLayer(identity) created: ${transformLayerIdentity.runtimeType}',
  );

  final transformLayerTranslate = TransformLayer(
    transform: Matrix4.translationValues(50.0, 100.0, 0.0),
  );
  print('TransformLayer(translate) created');
  print('  transform: ${transformLayerTranslate.transform}');

  final transformLayerScale = TransformLayer(
    transform: Matrix4.diagonal3Values(2.0, 2.0, 1.0),
  );
  print('TransformLayer(scale) created');

  final transformLayerWithOffset = TransformLayer(
    transform: Matrix4.identity(),
    offset: Offset(10.0, 20.0),
  );
  print('TransformLayer with offset: ${transformLayerWithOffset.offset}');

  // Modify transform
  transformLayer.transform = Matrix4.rotationZ(0.5);
  print('After setting transform: ${transformLayer.transform}');

  // ========== CLIP RECT LAYER ==========
  print('--- ClipRectLayer Tests ---');

  final clipRectLayer = ClipRectLayer(clipRect: Rect.fromLTWH(0, 0, 100, 80));
  print('ClipRectLayer created: ${clipRectLayer.runtimeType}');
  print('  clipRect: ${clipRectLayer.clipRect}');
  print('  clipBehavior: ${clipRectLayer.clipBehavior}');

  final clipRectLayerAntiAlias = ClipRectLayer(
    clipRect: Rect.fromLTWH(10, 10, 200, 150),
    clipBehavior: Clip.antiAlias,
  );
  print(
    'ClipRectLayer(antiAlias) clipBehavior: ${clipRectLayerAntiAlias.clipBehavior}',
  );

  // Modify clipRect
  clipRectLayer.clipRect = Rect.fromLTWH(5, 5, 90, 70);
  print('After setting clipRect: ${clipRectLayer.clipRect}');

  // ========== CLIP RRECT LAYER ==========
  print('--- ClipRRectLayer Tests ---');

  final clipRRectLayer = ClipRRectLayer(
    clipRRect: RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, 100, 80),
      Radius.circular(12.0),
    ),
  );
  print('ClipRRectLayer created: ${clipRRectLayer.runtimeType}');
  print('  clipRRect: ${clipRRectLayer.clipRRect}');

  final clipRRectCustomCorners = ClipRRectLayer(
    clipRRect: RRect.fromRectAndCorners(
      Rect.fromLTWH(0, 0, 100, 80),
      topLeft: Radius.circular(8.0),
      topRight: Radius.circular(16.0),
      bottomLeft: Radius.circular(4.0),
      bottomRight: Radius.circular(24.0),
    ),
  );
  print('ClipRRectLayer(custom corners) created');

  // ========== IMAGE FILTER LAYER ==========
  print('--- ImageFilterLayer Tests ---');

  final blurFilter = ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0);
  final imageFilterLayer = ImageFilterLayer(imageFilter: blurFilter);
  print('ImageFilterLayer(blur) created: ${imageFilterLayer.runtimeType}');

  final imageFilterLayerOffset = ImageFilterLayer(
    imageFilter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
    offset: Offset(0.0, 0.0),
  );
  print('ImageFilterLayer(blur, offset) created');

  // ========== BACKDROP FILTER LAYER ==========
  print('--- BackdropFilterLayer Tests ---');

  final backdropFilter = BackdropFilterLayer(
    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
  );
  print('BackdropFilterLayer created: ${backdropFilter.runtimeType}');

  final backdropFilterWithBlend = BackdropFilterLayer(
    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
    blendMode: BlendMode.srcOver,
  );
  print('BackdropFilterLayer(blend) created');
  print('  blendMode: ${backdropFilterWithBlend.blendMode}');

  // ========== OFFSET LAYER ==========
  print('--- OffsetLayer Tests ---');

  final offsetLayer = OffsetLayer();
  print('OffsetLayer() created: ${offsetLayer.runtimeType}');

  offsetLayer.offset = Offset(25.0, 50.0);
  print('OffsetLayer offset: ${offsetLayer.offset}');

  final offsetLayerDirect = OffsetLayer(offset: Offset(10.0, 20.0));
  print('OffsetLayer(10,20) offset: ${offsetLayerDirect.offset}');

  // ========== CLIP PATH LAYER ==========
  print('--- ClipPathLayer Tests ---');

  final path = Path()
    ..addOval(Rect.fromCircle(center: Offset(50, 50), radius: 40));
  final clipPathLayer = ClipPathLayer(clipPath: path);
  print('ClipPathLayer created: ${clipPathLayer.runtimeType}');
  print('  clipBehavior: ${clipPathLayer.clipBehavior}');

  final clipPathLayerAntiAlias = ClipPathLayer(
    clipPath: path,
    clipBehavior: Clip.antiAlias,
  );
  print(
    'ClipPathLayer(antiAlias) clipBehavior: ${clipPathLayerAntiAlias.clipBehavior}',
  );

  print('Layers data test completed');
  return Container(child: Text('Layers data test passed'));
}
