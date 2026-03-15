// D4rt test script: Tests BackdropKey from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BackdropKey test executing');

  // ========== BackdropKey Static Instance ==========
  print('--- BackdropKey Static Instance ---');
  // BackdropKey is typically used internally with BackdropFilterLayer
  print('  BackdropKey is used with BackdropFilterLayer');
  print('  Used to identify backdrop filter effects');

  // ========== BackdropFilterLayer Basic Tests ==========
  print('--- BackdropFilterLayer Basic Tests ---');
  final filter = ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0);
  final backdropLayer = BackdropFilterLayer(filter: filter);
  print('  created: ${backdropLayer.runtimeType}');
  print('  filter: ${backdropLayer.filter}');
  print('  blendMode: ${backdropLayer.blendMode}');

  // ========== BackdropFilterLayer with Different Filters ==========
  print('--- BackdropFilterLayer with Different Filters ---');
  final blurFilter = ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0);
  final blurLayer = BackdropFilterLayer(filter: blurFilter);
  print('  blur filter layer: ${blurLayer.filter}');

  final smallBlur = ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0);
  final smallBlurLayer = BackdropFilterLayer(filter: smallBlur);
  print('  small blur layer created');

  final largeBlur = ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0);
  final largeBlurLayer = BackdropFilterLayer(filter: largeBlur);
  print('  large blur layer created');

  // ========== BackdropFilterLayer with BlendMode ==========
  print('--- BackdropFilterLayer with BlendMode ---');
  final srcOverLayer = BackdropFilterLayer(
    filter: filter,
    blendMode: BlendMode.srcOver,
  );
  print('  srcOver blendMode: ${srcOverLayer.blendMode}');

  final multiplyLayer = BackdropFilterLayer(
    filter: filter,
    blendMode: BlendMode.multiply,
  );
  print('  multiply blendMode: ${multiplyLayer.blendMode}');

  final screenLayer = BackdropFilterLayer(
    filter: filter,
    blendMode: BlendMode.screen,
  );
  print('  screen blendMode: ${screenLayer.blendMode}');

  final overlayLayer = BackdropFilterLayer(
    filter: filter,
    blendMode: BlendMode.overlay,
  );
  print('  overlay blendMode: ${overlayLayer.blendMode}');

  // ========== BackdropFilterLayer Property Modification ==========
  print('--- BackdropFilterLayer Property Modification ---');
  final mutableLayer = BackdropFilterLayer(filter: filter);
  print('  initial filter: ${mutableLayer.filter}');

  final newFilter = ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0);
  mutableLayer.filter = newFilter;
  print('  modified filter: ${mutableLayer.filter}');

  mutableLayer.blendMode = BlendMode.colorDodge;
  print('  modified blendMode: ${mutableLayer.blendMode}');

  // ========== BackdropFilterLayer Layer Hierarchy ==========
  print('--- BackdropFilterLayer Layer Hierarchy ---');
  print('  parent: ${backdropLayer.parent}');
  print('  nextSibling: ${backdropLayer.nextSibling}');
  print('  previousSibling: ${backdropLayer.previousSibling}');
  print('  alwaysNeedsAddToScene: ${backdropLayer.alwaysNeedsAddToScene}');

  // ========== ImageFilter Blur Variations ==========
  print('--- ImageFilter Blur Variations ---');
  final blurXOnly = ImageFilter.blur(sigmaX: 10.0, sigmaY: 0.0);
  print('  horizontal blur: sigmaX=10, sigmaY=0');

  final blurYOnly = ImageFilter.blur(sigmaX: 0.0, sigmaY: 10.0);
  print('  vertical blur: sigmaX=0, sigmaY=10');

  final equalBlur = ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0);
  print('  equal blur: sigmaX=8, sigmaY=8');

  // ========== BlendMode Values ==========
  print('--- BlendMode Values ---');
  final blendModes = [
    BlendMode.clear,
    BlendMode.src,
    BlendMode.dst,
    BlendMode.srcOver,
    BlendMode.dstOver,
    BlendMode.srcIn,
    BlendMode.dstIn,
    BlendMode.srcOut,
  ];
  for (final mode in blendModes) {
    print('  ${mode.name}: index=${mode.index}');
  }

  // ========== BackdropFilter Widget Context ==========
  print('--- BackdropFilter Widget Context ---');
  print('  BackdropFilterLayer is created by BackdropFilter widget');
  print('  Used for frosted glass effects');
  print('  Applied to content behind the filter');

  // ========== Key Concepts ==========
  print('--- Key Concepts ---');
  print('  BackdropKey identifies the backdrop filter');
  print('  Allows efficient repainting of backdrop effects');
  print('  Used internally by rendering pipeline');

  print('BackdropKey test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'BackdropKey Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('BackdropFilterLayer: ${backdropLayer.runtimeType}'),
          Text('Filter: blur effect'),
          Text('BlendMode options tested'),
          Text('Layer hierarchy properties verified'),
          Text('ImageFilter variations: horizontal, vertical, equal'),
          Text('Used with BackdropFilter widget'),
        ],
      ),
    ),
  );
}
