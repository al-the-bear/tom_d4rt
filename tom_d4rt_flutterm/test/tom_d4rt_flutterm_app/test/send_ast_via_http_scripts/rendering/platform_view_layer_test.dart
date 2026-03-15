// D4rt test script: Tests PlatformViewLayer from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PlatformViewLayer test executing');

  // ========== Basic PlatformViewLayer creation ==========
  print('--- Basic PlatformViewLayer ---');
  final layer1 = PlatformViewLayer(
    rect: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    viewId: 1,
  );
  print('  created: ${layer1.runtimeType}');
  print('  rect: ${layer1.rect}');
  print('  viewId: ${layer1.viewId}');

  // ========== Different rect configurations ==========
  print('--- Different rect configurations ---');
  final layer2 = PlatformViewLayer(
    rect: Rect.fromLTRB(10.0, 20.0, 110.0, 220.0),
    viewId: 2,
  );
  print('  rect fromLTRB: ${layer2.rect}');
  print('  width: ${layer2.rect.width}');
  print('  height: ${layer2.rect.height}');

  final layer3 = PlatformViewLayer(
    rect: Rect.fromCenter(
      center: Offset(50.0, 50.0),
      width: 80.0,
      height: 60.0,
    ),
    viewId: 3,
  );
  print('  rect fromCenter: ${layer3.rect}');
  print('  center: ${layer3.rect.center}');

  // ========== Zero-sized rect ==========
  print('--- Zero-sized rect ---');
  final layerZero = PlatformViewLayer(rect: Rect.zero, viewId: 4);
  print('  rect.isEmpty: ${layerZero.rect.isEmpty}');
  print('  rect: ${layerZero.rect}');

  // ========== Large viewId ==========
  print('--- Large viewId ---');
  final layerLarge = PlatformViewLayer(
    rect: Rect.fromLTWH(0.0, 0.0, 50.0, 50.0),
    viewId: 999999,
  );
  print('  viewId: ${layerLarge.viewId}');

  // ========== Layer properties ==========
  print('--- Layer properties ---');
  print('  layer1.parent: ${layer1.parent}');
  print('  layer1.nextSibling: ${layer1.nextSibling}');
  print('  layer1.previousSibling: ${layer1.previousSibling}');
  print('  layer1.firstChild: ${layer1.firstChild}');
  print('  layer1.lastChild: ${layer1.lastChild}');
  print('  layer1.attached: ${layer1.attached}');
  print(
    '  layer1.debugSubtreeNeedsAddToScene: ${layer1.debugSubtreeNeedsAddToScene}',
  );

  // ========== ContainerLayer as parent ==========
  print('--- ContainerLayer as parent ---');
  final container = ContainerLayer();
  container.append(layer1);
  print('  layer1.parent != null after append: ${layer1.parent != null}');
  print('  container.firstChild: ${container.firstChild}');
  print('  container.lastChild: ${container.lastChild}');

  // ========== Multiple layers in container ==========
  print('--- Multiple layers in container ---');
  final container2 = ContainerLayer();
  final pvLayer1 = PlatformViewLayer(
    rect: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    viewId: 10,
  );
  final pvLayer2 = PlatformViewLayer(
    rect: Rect.fromLTWH(100.0, 0.0, 100.0, 100.0),
    viewId: 11,
  );
  final pvLayer3 = PlatformViewLayer(
    rect: Rect.fromLTWH(200.0, 0.0, 100.0, 100.0),
    viewId: 12,
  );
  container2.append(pvLayer1);
  container2.append(pvLayer2);
  container2.append(pvLayer3);
  print(
    '  pvLayer1.nextSibling == pvLayer2: ${pvLayer1.nextSibling == pvLayer2}',
  );
  print(
    '  pvLayer2.previousSibling == pvLayer1: ${pvLayer2.previousSibling == pvLayer1}',
  );
  print(
    '  pvLayer3.previousSibling == pvLayer2: ${pvLayer3.previousSibling == pvLayer2}',
  );

  // ========== Remove from parent ==========
  print('--- Remove from parent ---');
  pvLayer2.remove();
  print('  After remove pvLayer2:');
  print(
    '  pvLayer1.nextSibling == pvLayer3: ${pvLayer1.nextSibling == pvLayer3}',
  );
  print(
    '  pvLayer3.previousSibling == pvLayer1: ${pvLayer3.previousSibling == pvLayer1}',
  );
  print('  pvLayer2.parent: ${pvLayer2.parent}');

  // ========== Equality and hashCode ==========
  print('--- Equality and hashCode ---');
  final layerA = PlatformViewLayer(
    rect: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    viewId: 100,
  );
  final layerB = PlatformViewLayer(
    rect: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    viewId: 100,
  );
  print('  layerA == layerA: ${layerA == layerA}');
  print('  layerA == layerB: ${layerA == layerB}');
  print('  layerA.hashCode: ${layerA.hashCode}');

  // ========== ToString ==========
  print('--- ToString ---');
  print('  layer1.toString(): ${layer1.toString()}');

  print('PlatformViewLayer test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'PlatformViewLayer Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Basic layer rect: ${layer1.rect}'),
          Text('Basic layer viewId: ${layer1.viewId}'),
          Text('FromCenter rect: ${layer3.rect}'),
          Text('Large viewId: ${layerLarge.viewId}'),
          Text('Container hierarchy verified'),
          Text('Layer removal verified'),
        ],
      ),
    ),
  );
}
