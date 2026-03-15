// D4rt test script: Tests ColorFilter, ImageFilter, MaskFilter from dart:ui
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('dart:ui filters test executing');

  // ========== COLORFILTER ==========
  print('--- ColorFilter Tests ---');

  // ColorFilter.mode
  final modeFilter = ColorFilter.mode(Color(0xFF000000), BlendMode.srcOver);
  print('ColorFilter.mode(black, srcOver): $modeFilter');
  print('  runtimeType: ${modeFilter.runtimeType}');

  final redOverlay = ColorFilter.mode(Color(0x80FF0000), BlendMode.srcATop);
  print('ColorFilter.mode(red50%, srcATop): $redOverlay');

  final tintFilter = ColorFilter.mode(Color(0xFF0000FF), BlendMode.modulate);
  print('ColorFilter.mode(blue, modulate): $tintFilter');

  // ColorFilter.matrix
  final identityMatrix = <double>[
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
  ];
  final matrixFilter = ColorFilter.matrix(identityMatrix);
  print('ColorFilter.matrix(identity): $matrixFilter');

  // Greyscale matrix
  final greyscaleMatrix = <double>[
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ];
  final greyscaleFilter = ColorFilter.matrix(greyscaleMatrix);
  print('ColorFilter.matrix(greyscale): $greyscaleFilter');

  // ColorFilter.linearToSrgbGamma
  final linearToSrgb = ColorFilter.linearToSrgbGamma();
  print('ColorFilter.linearToSrgbGamma(): $linearToSrgb');

  // ColorFilter.srgbToLinearGamma
  final srgbToLinear = ColorFilter.srgbToLinearGamma();
  print('ColorFilter.srgbToLinearGamma(): $srgbToLinear');

  // Test various BlendModes with ColorFilter
  final blendModes = [
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
    BlendMode.multiply,
    BlendMode.screen,
    BlendMode.overlay,
  ];
  for (final mode in blendModes) {
    final f = ColorFilter.mode(Color(0xFF00FF00), mode);
    print('  ColorFilter.mode(green, $mode): ${f.runtimeType}');
  }

  // ========== MASKFILTER ==========
  print('--- MaskFilter Tests ---');

  final normalBlur = MaskFilter.blur(BlurStyle.normal, 5.0);
  print('MaskFilter.blur(normal, 5.0): $normalBlur');
  print('  runtimeType: ${normalBlur.runtimeType}');

  final solidBlur = MaskFilter.blur(BlurStyle.solid, 3.0);
  print('MaskFilter.blur(solid, 3.0): $solidBlur');

  final outerBlur = MaskFilter.blur(BlurStyle.outer, 8.0);
  print('MaskFilter.blur(outer, 8.0): $outerBlur');

  final innerBlur = MaskFilter.blur(BlurStyle.inner, 2.0);
  print('MaskFilter.blur(inner, 2.0): $innerBlur');

  // Test all BlurStyles
  for (final style in BlurStyle.values) {
    final blur = MaskFilter.blur(style, 4.0);
    print('  MaskFilter.blur($style, 4.0): ${blur.runtimeType}');
  }

  // ========== IMAGEFILTER ==========
  print('--- ImageFilter Tests ---');

  final blurFilter = ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0);
  print('ImageFilter.blur(sigmaX: 2, sigmaY: 2): $blurFilter');
  print('  runtimeType: ${blurFilter.runtimeType}');

  final asymBlur = ImageFilter.blur(sigmaX: 5.0, sigmaY: 1.0);
  print('ImageFilter.blur(sigmaX: 5, sigmaY: 1): $asymBlur');

  final noBlur = ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0);
  print('ImageFilter.blur(sigmaX: 0, sigmaY: 0): $noBlur');

  // Note: ImageFilter.matrix requires Float64List which is not available in D4rt

  // ImageFilter.compose
  final composedFilter = ImageFilter.compose(
    outer: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
    inner: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
  );
  print('ImageFilter.compose(outer blur + inner blur): $composedFilter');

  // ImageFilter with TileMode
  final clampBlur = ImageFilter.blur(
    sigmaX: 5.0,
    sigmaY: 5.0,
    tileMode: TileMode.clamp,
  );
  print('ImageFilter.blur with clamp: $clampBlur');

  final repeatBlur = ImageFilter.blur(
    sigmaX: 5.0,
    sigmaY: 5.0,
    tileMode: TileMode.repeated,
  );
  print('ImageFilter.blur with repeat: $repeatBlur');

  // ========== RETURN WIDGET ==========
  print('dart:ui filters test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'dart:ui Filters Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text(
            'Classes Tested:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• ColorFilter - color transformation filters'),
          Text('• MaskFilter - blur mask effects'),
          Text('• ImageFilter - image blur/matrix filters'),
          SizedBox(height: 16.0),

          Text('Filter Types:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFE0F7FA),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ColorFilter:'),
                Text('  .mode(color, blendMode)'),
                Text('  .matrix(20-element list)'),
                Text('  .linearToSrgbGamma()'),
                Text('  .srgbToLinearGamma()'),
                SizedBox(height: 8.0),
                Text('MaskFilter:'),
                Text('  .blur(BlurStyle, sigma)'),
                SizedBox(height: 8.0),
                Text('ImageFilter:'),
                Text('  .blur(sigmaX, sigmaY)'),
                Text('  .matrix(Float64List)'),
                Text('  .compose(outer, inner)'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
