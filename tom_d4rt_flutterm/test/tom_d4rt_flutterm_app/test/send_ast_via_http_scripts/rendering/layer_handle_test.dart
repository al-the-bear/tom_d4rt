// D4rt test script: Tests LayerHandle from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('LayerHandle test executing');

  // ========== Basic LayerHandle creation ==========
  print('--- Basic LayerHandle ---');
  final handle1 = LayerHandle<ContainerLayer>();
  print('  created: ${handle1.runtimeType}');
  print('  layer: ${handle1.layer}');

  // ========== LayerHandle with different layer types ==========
  print('--- Different layer types ---');
  final containerHandle = LayerHandle<ContainerLayer>();
  print('  ContainerLayer handle: ${containerHandle.runtimeType}');

  final offsetHandle = LayerHandle<OffsetLayer>();
  print('  OffsetLayer handle: ${offsetHandle.runtimeType}');

  final transformHandle = LayerHandle<TransformLayer>();
  print('  TransformLayer handle: ${transformHandle.runtimeType}');

  final opacityHandle = LayerHandle<OpacityLayer>();
  print('  OpacityLayer handle: ${opacityHandle.runtimeType}');

  // ========== Setting layer on handle ==========
  print('--- Setting layer on handle ---');
  final containerLayer = ContainerLayer();
  final handleWithLayer = LayerHandle<ContainerLayer>();
  handleWithLayer.layer = containerLayer;
  print('  handle.layer set: ${handleWithLayer.layer != null}');
  print('  layer runtimeType: ${handleWithLayer.layer?.runtimeType}');

  // ========== OffsetLayer handle ==========
  print('--- OffsetLayer handle ---');
  final offsetLayer = OffsetLayer(offset: Offset(10.0, 20.0));
  final offsetLayerHandle = LayerHandle<OffsetLayer>();
  offsetLayerHandle.layer = offsetLayer;
  print('  offset layer set');
  print('  offset: ${offsetLayerHandle.layer?.offset}');

  // ========== TransformLayer handle ==========
  print('--- TransformLayer handle ---');
  final transformLayer = TransformLayer(transform: Matrix4.identity());
  final transformLayerHandle = LayerHandle<TransformLayer>();
  transformLayerHandle.layer = transformLayer;
  print('  transform layer set');
  print('  transform: ${transformLayerHandle.layer?.transform}');

  // ========== OpacityLayer handle ==========
  print('--- OpacityLayer handle ---');
  final opacityLayer = OpacityLayer(alpha: 128);
  final opacityLayerHandle = LayerHandle<OpacityLayer>();
  opacityLayerHandle.layer = opacityLayer;
  print('  opacity layer set');
  print('  alpha: ${opacityLayerHandle.layer?.alpha}');

  // ========== Clearing layer handle ==========
  print('--- Clearing layer handle ---');
  final clearHandle = LayerHandle<ContainerLayer>();
  clearHandle.layer = ContainerLayer();
  print('  before clear: ${clearHandle.layer != null}');
  clearHandle.layer = null;
  print('  after clear: ${clearHandle.layer}');

  // ========== Multiple handles to same layer type ==========
  print('--- Multiple handles ---');
  final multiHandle1 = LayerHandle<OffsetLayer>();
  final multiHandle2 = LayerHandle<OffsetLayer>();
  final multiHandle3 = LayerHandle<OffsetLayer>();
  multiHandle1.layer = OffsetLayer(offset: Offset(0.0, 0.0));
  multiHandle2.layer = OffsetLayer(offset: Offset(10.0, 10.0));
  multiHandle3.layer = OffsetLayer(offset: Offset(20.0, 20.0));
  print('  handle1 offset: ${multiHandle1.layer?.offset}');
  print('  handle2 offset: ${multiHandle2.layer?.offset}');
  print('  handle3 offset: ${multiHandle3.layer?.offset}');

  // ========== LayerHandle lifecycle ==========
  print('--- LayerHandle lifecycle ---');
  final lifecycleHandle = LayerHandle<ContainerLayer>();
  print('  initial layer: ${lifecycleHandle.layer}');
  lifecycleHandle.layer = ContainerLayer();
  print('  after assignment: ${lifecycleHandle.layer != null}');
  final previousLayer = lifecycleHandle.layer;
  lifecycleHandle.layer = ContainerLayer();
  print('  after reassignment: different layer');

  print('LayerHandle test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'LayerHandle Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Basic handle: ${handle1.runtimeType}'),
          Text('Initial layer: null'),
          SizedBox(height: 8.0),
          Text('Layer types:'),
          Text('  - ContainerLayer'),
          Text('  - OffsetLayer'),
          Text('  - TransformLayer'),
          Text('  - OpacityLayer'),
          SizedBox(height: 8.0),
          Text('Handle with layer: ${handleWithLayer.layer != null}'),
          Text('Offset layer offset: ${offsetLayerHandle.layer?.offset}'),
          Text('Opacity layer alpha: ${opacityLayerHandle.layer?.alpha}'),
        ],
      ),
    ),
  );
}
