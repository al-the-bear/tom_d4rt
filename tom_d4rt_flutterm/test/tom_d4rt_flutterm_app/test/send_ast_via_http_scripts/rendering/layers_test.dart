// D4rt test script: Tests rendering layer classes and PaintingContext
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Rendering layers test executing');

  // Note: Most Layer classes are internal to the rendering pipeline.
  // Testing them directly is limited, but we can demonstrate concepts.

  // ========== LAYER CONCEPTS ==========
  print('--- Layer Architecture Info ---');
  print('Layer is the base class for all compositing layers');
  print('ContainerLayer is a layer that can have child layers');
  print('OffsetLayer is a layer that applies an offset transform');
  print('PictureLayer holds a ui.Picture for painting');
  print('TextureLayer displays external textures');
  print('ClipRectLayer clips child layers to a rectangle');
  print('ClipRRectLayer clips child layers to a rounded rectangle');
  print('ClipPathLayer clips child layers to a path');
  print('OpacityLayer applies opacity to child layers');
  print('ShaderMaskLayer applies a shader mask to child layers');
  print('BackdropFilterLayer applies a backdrop filter');

  // ========== OFFSET LAYER ==========
  print('--- OffsetLayer Tests ---');

  final offsetLayer = OffsetLayer();
  print('OffsetLayer created');

  // Set offset
  offsetLayer.offset = Offset(10.0, 20.0);
  print('OffsetLayer offset: ${offsetLayer.offset}');

  // ========== CLIP RECT LAYER ==========
  print('--- ClipRectLayer Tests ---');

  final clipRectLayer = ClipRectLayer(
    clipRect: Rect.fromLTWH(0.0, 0.0, 100.0, 80.0),
  );
  print('ClipRectLayer clipRect: ${clipRectLayer.clipRect}');

  // Test clipBehavior
  final hardEdgeClip = ClipRectLayer(
    clipRect: Rect.fromLTWH(0.0, 0.0, 100.0, 80.0),
    clipBehavior: Clip.hardEdge,
  );
  print(
    'ClipRectLayer with hardEdge: clipBehavior=${hardEdgeClip.clipBehavior}',
  );

  final antiAliasClip = ClipRectLayer(
    clipRect: Rect.fromLTWH(0.0, 0.0, 100.0, 80.0),
    clipBehavior: Clip.antiAlias,
  );
  print(
    'ClipRectLayer with antiAlias: clipBehavior=${antiAliasClip.clipBehavior}',
  );

  // ========== CLIP RRECT LAYER ==========
  print('--- ClipRRectLayer Tests ---');

  final clipRRectLayer = ClipRRectLayer(
    clipRRect: RRect.fromRectAndRadius(
      Rect.fromLTWH(0.0, 0.0, 100.0, 80.0),
      Radius.circular(10.0),
    ),
  );
  print('ClipRRectLayer created with rounded rect');

  // ========== CLIP PATH LAYER ==========
  print('--- ClipPathLayer Tests ---');

  final path = Path()
    ..moveTo(50.0, 0.0)
    ..lineTo(100.0, 40.0)
    ..lineTo(80.0, 100.0)
    ..lineTo(20.0, 100.0)
    ..lineTo(0.0, 40.0)
    ..close();

  final clipPathLayer = ClipPathLayer(clipPath: path);
  print('ClipPathLayer created with pentagon path');

  // ========== OPACITY LAYER ==========
  print('--- OpacityLayer Tests ---');

  final opacityLayer = OpacityLayer(alpha: 128);
  print('OpacityLayer alpha: ${opacityLayer.alpha}');

  final fullOpacity = OpacityLayer(alpha: 255);
  print('Full opacity: alpha=${fullOpacity.alpha}');

  final halfOpacity = OpacityLayer(alpha: 128);
  print('Half opacity: alpha=${halfOpacity.alpha}');

  final quarterOpacity = OpacityLayer(alpha: 64);
  print('Quarter opacity: alpha=${quarterOpacity.alpha}');

  // Test with offset
  final opacityWithOffset = OpacityLayer(
    alpha: 200,
    offset: Offset(10.0, 10.0),
  );
  print('OpacityLayer with offset: offset=${opacityWithOffset.offset}');

  // ========== TRANSFORM LAYER ==========
  print('--- TransformLayer Tests ---');

  final transformLayer = TransformLayer(
    transform: Matrix4.identity()
      ..translate(50.0, 50.0)
      ..rotateZ(0.785),
  );
  print('TransformLayer created with rotation transform');

  // ========== LEADER LAYER & FOLLOWER LAYER ==========
  print('--- LeaderLayer / FollowerLayer Tests ---');

  final layerLink = LayerLink();
  print('LayerLink created');

  final leaderLayer = LeaderLayer(link: layerLink, offset: Offset(10.0, 20.0));
  print('LeaderLayer created with offset: ${leaderLayer.offset}');

  final followerLayer = FollowerLayer(
    link: layerLink,
    unlinkedOffset: Offset(5.0, 5.0),
    showWhenUnlinked: false,
  );
  print(
    'FollowerLayer created, showWhenUnlinked: ${followerLayer.showWhenUnlinked}',
  );
  print('FollowerLayer unlinkedOffset: ${followerLayer.unlinkedOffset}');

  // ========== BACKDROP FILTER LAYER ==========
  print('--- BackdropFilterLayer Tests ---');

  final backdropFilterLayer = BackdropFilterLayer(
    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
  );
  print('BackdropFilterLayer created with blur filter');

  // Test with blend mode
  final backdropWithBlend = BackdropFilterLayer(
    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
    blendMode: BlendMode.srcOver,
  );
  print('BackdropFilterLayer with blendMode: ${backdropWithBlend.blendMode}');

  // ========== COLOR FILTER LAYER ==========
  print('--- ColorFilterLayer Tests ---');

  final colorFilterLayer = ColorFilterLayer(
    colorFilter: ColorFilter.mode(Color(0x80FF0000), BlendMode.srcOver),
  );
  print('ColorFilterLayer created with red tint');

  final grayscaleFilter = ColorFilterLayer(
    colorFilter: ColorFilter.matrix([
      0.2126,
      0.7152,
      0.0722,
      0.0,
      0.0,
      0.2126,
      0.7152,
      0.0722,
      0.0,
      0.0,
      0.2126,
      0.7152,
      0.0722,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      1.0,
      0.0,
    ]),
  );
  print('ColorFilterLayer with grayscale matrix');

  // ========== IMAGE FILTER LAYER ==========
  print('--- ImageFilterLayer Tests ---');

  final imageFilterLayer = ImageFilterLayer(
    imageFilter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
  );
  print('ImageFilterLayer with blur');

  // ========== SHADER MASK LAYER ==========
  print('--- ShaderMaskLayer Tests ---');

  final gradient = LinearGradient(
    colors: [Color(0xFF000000), Color(0x00000000)],
  );
  final shaderMaskLayer = ShaderMaskLayer(
    shader: gradient.createShader(Rect.fromLTWH(0.0, 0.0, 100.0, 100.0)),
    maskRect: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    blendMode: BlendMode.dstIn,
  );
  print('ShaderMaskLayer created with gradient mask');

  print('Rendering layers test completed');

  // Return a visual representation demonstrating layer effects
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Layer Architecture Tests',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            Text(
              'Opacity Layers:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Container(
                  width: 60.0,
                  height: 60.0,
                  color: Color(0xFF2196F3).withOpacity(1.0),
                  child: Center(
                    child: Text(
                      '100%',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  width: 60.0,
                  height: 60.0,
                  color: Color(0xFF2196F3).withOpacity(0.75),
                  child: Center(
                    child: Text(
                      '75%',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  width: 60.0,
                  height: 60.0,
                  color: Color(0xFF2196F3).withOpacity(0.5),
                  child: Center(
                    child: Text(
                      '50%',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  width: 60.0,
                  height: 60.0,
                  color: Color(0xFF2196F3).withOpacity(0.25),
                  child: Center(
                    child: Text(
                      '25%',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            Text('Clip Layers:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Row(
              children: [
                Column(
                  children: [
                    ClipRect(
                      child: Container(
                        width: 80.0,
                        height: 80.0,
                        color: Color(0xFFE53935),
                        child: Center(
                          child: Text(
                            'ClipRect',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text('Rect', style: TextStyle(fontSize: 10.0)),
                  ],
                ),
                SizedBox(width: 16.0),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        width: 80.0,
                        height: 80.0,
                        color: Color(0xFF4CAF50),
                        child: Center(
                          child: Text(
                            'ClipRRect',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text('RRect', style: TextStyle(fontSize: 10.0)),
                  ],
                ),
                SizedBox(width: 16.0),
                Column(
                  children: [
                    ClipOval(
                      child: Container(
                        width: 80.0,
                        height: 80.0,
                        color: Color(0xFF2196F3),
                        child: Center(
                          child: Text(
                            'ClipOval',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text('Oval', style: TextStyle(fontSize: 10.0)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'Physical Model (Elevation):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                PhysicalModel(
                  color: Color(0xFFFFFFFF),
                  elevation: 1.0,
                  borderRadius: BorderRadius.circular(4.0),
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    child: Center(
                      child: Text('1dp', style: TextStyle(fontSize: 12.0)),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                PhysicalModel(
                  color: Color(0xFFFFFFFF),
                  elevation: 4.0,
                  borderRadius: BorderRadius.circular(4.0),
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    child: Center(
                      child: Text('4dp', style: TextStyle(fontSize: 12.0)),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                PhysicalModel(
                  color: Color(0xFFFFFFFF),
                  elevation: 8.0,
                  borderRadius: BorderRadius.circular(4.0),
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    child: Center(
                      child: Text('8dp', style: TextStyle(fontSize: 12.0)),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                PhysicalModel(
                  color: Color(0xFFFFFFFF),
                  elevation: 16.0,
                  borderRadius: BorderRadius.circular(4.0),
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    child: Center(
                      child: Text('16dp', style: TextStyle(fontSize: 12.0)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'Transform Layer:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Transform.rotate(
                  angle: 0.0,
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    color: Color(0xFFFF9800),
                    child: Center(
                      child: Text(
                        '0°',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Transform.rotate(
                  angle: 0.262,
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    color: Color(0xFFFF9800),
                    child: Center(
                      child: Text(
                        '15°',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Transform.rotate(
                  angle: 0.785,
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    color: Color(0xFFFF9800),
                    child: Center(
                      child: Text(
                        '45°',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Transform.scale(
                  scale: 0.8,
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    color: Color(0xFF9C27B0),
                    child: Center(
                      child: Text(
                        '0.8x',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
