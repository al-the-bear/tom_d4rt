// D4rt test script: Tests TextureLayer from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextureLayer test executing');

  // ========== TextureLayer Basic Creation ==========
  print('--- TextureLayer Basic Creation ---');
  final textureLayer = TextureLayer(
    rect: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    textureId: 1,
  );
  print('  created: ${textureLayer.runtimeType}');
  print('  rect: ${textureLayer.rect}');
  print('  textureId: ${textureLayer.textureId}');
  print('  freeze: ${textureLayer.freeze}');
  print('  filterQuality: ${textureLayer.filterQuality}');

  // ========== TextureLayer with Different Rects ==========
  print('--- TextureLayer with Different Rects ---');
  final smallRect = TextureLayer(
    rect: Rect.fromLTWH(10.0, 20.0, 50.0, 50.0),
    textureId: 2,
  );
  print('  small rect: ${smallRect.rect}');
  print('  textureId: ${smallRect.textureId}');

  final largeRect = TextureLayer(
    rect: Rect.fromLTWH(0.0, 0.0, 500.0, 300.0),
    textureId: 3,
  );
  print('  large rect: ${largeRect.rect}');
  print('  width: ${largeRect.rect.width}');
  print('  height: ${largeRect.rect.height}');

  // ========== TextureLayer with Freeze Option ==========
  print('--- TextureLayer with Freeze ---');
  final frozenTexture = TextureLayer(
    rect: Rect.fromLTWH(0.0, 0.0, 200.0, 200.0),
    textureId: 4,
    freeze: true,
  );
  print('  freeze: ${frozenTexture.freeze}');

  final unfrozenTexture = TextureLayer(
    rect: Rect.fromLTWH(0.0, 0.0, 200.0, 200.0),
    textureId: 5,
    freeze: false,
  );
  print('  unfrozen: ${unfrozenTexture.freeze}');

  // ========== TextureLayer with FilterQuality ==========
  print('--- TextureLayer with FilterQuality ---');
  final lowQuality = TextureLayer(
    rect: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    textureId: 6,
    filterQuality: FilterQuality.low,
  );
  print('  low quality: ${lowQuality.filterQuality}');

  final mediumQuality = TextureLayer(
    rect: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    textureId: 7,
    filterQuality: FilterQuality.medium,
  );
  print('  medium quality: ${mediumQuality.filterQuality}');

  final highQuality = TextureLayer(
    rect: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    textureId: 8,
    filterQuality: FilterQuality.high,
  );
  print('  high quality: ${highQuality.filterQuality}');

  final noneQuality = TextureLayer(
    rect: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    textureId: 9,
    filterQuality: FilterQuality.none,
  );
  print('  none quality: ${noneQuality.filterQuality}');

  // ========== TextureLayer Properties Modification ==========
  print('--- TextureLayer Properties Modification ---');
  final mutableLayer = TextureLayer(
    rect: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    textureId: 10,
  );
  print('  initial rect: ${mutableLayer.rect}');
  mutableLayer.rect = Rect.fromLTWH(50.0, 50.0, 150.0, 150.0);
  print('  modified rect: ${mutableLayer.rect}');

  mutableLayer.textureId = 99;
  print('  modified textureId: ${mutableLayer.textureId}');

  mutableLayer.freeze = true;
  print('  modified freeze: ${mutableLayer.freeze}');

  mutableLayer.filterQuality = FilterQuality.high;
  print('  modified filterQuality: ${mutableLayer.filterQuality}');

  // ========== TextureLayer Layer Hierarchy ==========
  print('--- TextureLayer Layer Hierarchy ---');
  print('  parent: ${textureLayer.parent}');
  print('  nextSibling: ${textureLayer.nextSibling}');
  print('  previousSibling: ${textureLayer.previousSibling}');
  print('  alwaysNeedsAddToScene: ${textureLayer.alwaysNeedsAddToScene}');
  print('  debugCreator: ${textureLayer.debugCreator}');

  print('TextureLayer test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'TextureLayer Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('TextureLayer: ${textureLayer.runtimeType}'),
          Text('Rect: ${textureLayer.rect}'),
          Text('TextureId: ${textureLayer.textureId}'),
          Text('Freeze: ${textureLayer.freeze}'),
          Text('FilterQuality values tested: none, low, medium, high'),
          Text('Properties modifiable: rect, textureId, freeze'),
        ],
      ),
    ),
  );
}
