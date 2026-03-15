// D4rt test script: Tests LeaderLayer from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('LeaderLayer test executing');

  // ========== Basic LeaderLayer creation ==========
  print('--- Basic LeaderLayer ---');
  final link1 = LayerLink();
  final leader1 = LeaderLayer(link: link1);
  print('  created: ${leader1.runtimeType}');
  print('  link: ${leader1.link}');
  print('  offset: ${leader1.offset}');

  // ========== LeaderLayer with offset ==========
  print('--- LeaderLayer with offset ---');
  final link2 = LayerLink();
  final leader2 = LeaderLayer(link: link2, offset: Offset(10.0, 20.0));
  print('  offset: ${leader2.offset}');

  final leader3 = LeaderLayer(link: LayerLink(), offset: Offset(-5.0, 15.0));
  print('  negative x offset: ${leader3.offset}');

  final leader4 = LeaderLayer(link: LayerLink(), offset: Offset.zero);
  print('  zero offset: ${leader4.offset}');

  // ========== LayerLink relationship ==========
  print('--- LayerLink relationship ---');
  final sharedLink = LayerLink();
  final leaderWithLink = LeaderLayer(link: sharedLink);
  print('  leader.link == sharedLink: ${leaderWithLink.link == sharedLink}');
  print('  sharedLink.leader: ${sharedLink.leader}');

  // ========== LeaderLayer properties ==========
  print('--- LeaderLayer properties ---');
  print('  leader1.debugCreator: ${leader1.debugCreator}');
  print('  leader1.parent: ${leader1.parent}');
  print('  leader1.nextSibling: ${leader1.nextSibling}');
  print('  leader1.previousSibling: ${leader1.previousSibling}');

  // ========== Multiple LeaderLayers ==========
  print('--- Multiple LeaderLayers ---');
  final leaderA = LeaderLayer(link: LayerLink(), offset: Offset(0.0, 0.0));
  final leaderB = LeaderLayer(link: LayerLink(), offset: Offset(50.0, 0.0));
  final leaderC = LeaderLayer(link: LayerLink(), offset: Offset(100.0, 0.0));
  print('  leaderA offset: ${leaderA.offset}');
  print('  leaderB offset: ${leaderB.offset}');
  print('  leaderC offset: ${leaderC.offset}');

  // ========== Layer hierarchy ==========
  print('--- Layer hierarchy ---');
  print('  LeaderLayer extends ContainerLayer');
  print('  leader1 is ContainerLayer: ${leader1 is ContainerLayer}');
  print('  leader1 is Layer: ${leader1 is Layer}');

  // ========== Offset modifications ==========
  print('--- Offset modifications ---');
  final modifiableLeader = LeaderLayer(link: LayerLink());
  print('  initial offset: ${modifiableLeader.offset}');
  modifiableLeader.offset = Offset(25.0, 35.0);
  print('  modified offset: ${modifiableLeader.offset}');
  modifiableLeader.offset = Offset(100.0, 200.0);
  print('  further modified: ${modifiableLeader.offset}');

  // ========== Using with CompositedTransformTarget ==========
  print('--- With CompositedTransformTarget widget ---');
  final widgetLink = LayerLink();
  final targetWidget = CompositedTransformTarget(
    link: widgetLink,
    child: Container(width: 80.0, height: 40.0, color: Color(0xFF4CAF50)),
  );
  print('  CompositedTransformTarget created');
  print('  uses LeaderLayer internally');

  print('LeaderLayer test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'LeaderLayer Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Basic leader: ${leader1.runtimeType}'),
          Text('Link: ${leader1.link.runtimeType}'),
          Text('Offset: ${leader2.offset}'),
          SizedBox(height: 8.0),
          Text('Layer hierarchy:'),
          Text('  - extends ContainerLayer'),
          Text('  - implements Layer'),
          SizedBox(height: 8.0),
          CompositedTransformTarget(
            link: LayerLink(),
            child: Container(
              width: 100.0,
              height: 50.0,
              color: Color(0xFF2196F3),
              child: Center(
                child: Text(
                  'Target',
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
              ),
            ),
          ),
          Text('CompositedTransformTarget uses LeaderLayer'),
        ],
      ),
    ),
  );
}
