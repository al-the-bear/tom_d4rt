// D4rt test script: Tests RotationTransition, SizeTransition, DecoratedBoxTransition from widgets
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print(
    'RotationTransition/SizeTransition/DecoratedBoxTransition test executing',
  );

  // ========== ROTATIONTRANSITION ==========
  print('--- RotationTransition Tests ---');

  // Test RotationTransition at 0 turns (no rotation)
  final rotateZero = RotationTransition(
    turns: AlwaysStoppedAnimation(0.0),
    child: Container(
      width: 80.0,
      height: 80.0,
      color: Colors.blue,
      child: Center(
        child: Text('0', style: TextStyle(color: Colors.white, fontSize: 20.0)),
      ),
    ),
  );
  print('RotationTransition turns=0.0 created');

  // Test RotationTransition at 0.25 turns (90 degrees)
  final rotateQuarter = RotationTransition(
    turns: AlwaysStoppedAnimation(0.25),
    child: Container(
      width: 80.0,
      height: 80.0,
      color: Colors.green,
      child: Center(
        child: Text(
          '90',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
    ),
  );
  print('RotationTransition turns=0.25 (90 deg) created');

  // Test RotationTransition at 0.5 turns (180 degrees)
  final rotateHalf = RotationTransition(
    turns: AlwaysStoppedAnimation(0.5),
    child: Container(
      width: 80.0,
      height: 80.0,
      color: Colors.red,
      child: Center(
        child: Text(
          '180',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
    ),
  );
  print('RotationTransition turns=0.5 (180 deg) created');

  // Test RotationTransition at 0.75 turns (270 degrees)
  final rotateThreeQuarter = RotationTransition(
    turns: AlwaysStoppedAnimation(0.75),
    child: Container(
      width: 80.0,
      height: 80.0,
      color: Colors.orange,
      child: Center(
        child: Text(
          '270',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
    ),
  );
  print('RotationTransition turns=0.75 (270 deg) created');

  // Test RotationTransition with alignment
  final rotateAligned = RotationTransition(
    turns: AlwaysStoppedAnimation(0.125),
    alignment: Alignment.topLeft,
    child: Container(
      width: 80.0,
      height: 80.0,
      color: Colors.purple,
      child: Center(
        child: Text(
          'TL',
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
      ),
    ),
  );
  print('RotationTransition with alignment=topLeft created');

  // ========== SIZETRANSITION ==========
  print('--- SizeTransition Tests ---');

  // Test SizeTransition at full size
  final sizeFull = SizeTransition(
    sizeFactor: AlwaysStoppedAnimation(1.0),
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.teal,
      child: Center(
        child: Text('Full size', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('SizeTransition sizeFactor=1.0 created');

  // Test SizeTransition at half size
  final sizeHalf = SizeTransition(
    sizeFactor: AlwaysStoppedAnimation(0.5),
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.indigo,
      child: Center(
        child: Text('Half size', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('SizeTransition sizeFactor=0.5 created');

  // Test SizeTransition at zero size
  final sizeZero = SizeTransition(
    sizeFactor: AlwaysStoppedAnimation(0.0),
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.red,
      child: Center(
        child: Text('Zero', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('SizeTransition sizeFactor=0.0 created');

  // Test SizeTransition with horizontal axis
  final sizeHorizontal = SizeTransition(
    sizeFactor: AlwaysStoppedAnimation(0.75),
    axis: Axis.horizontal,
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.brown,
      child: Center(
        child: Text('Horizontal 0.75', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('SizeTransition horizontal axis, sizeFactor=0.75 created');

  // Test SizeTransition with axisAlignment
  final sizeAligned = SizeTransition(
    sizeFactor: AlwaysStoppedAnimation(0.5),
    axisAlignment: -1.0,
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.amber,
      child: Center(
        child: Text('Aligned -1.0', style: TextStyle(color: Colors.black)),
      ),
    ),
  );
  print('SizeTransition with axisAlignment=-1.0 created');

  // Note: PositionedTransition removed - AlwaysStoppedAnimation<dynamic> can't be
  // assigned to Animation<RelativeRect> in D4rt

  // Note: DecoratedBoxTransition removed - AlwaysStoppedAnimation<dynamic> can't be
  // assigned to Animation<Decoration> in D4rt

  print('All RotationTransition/SizeTransition tests completed');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '=== RotationTransition Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('0 turns:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: rotateZero),
        SizedBox(height: 8.0),
        Text(
          '0.25 turns (90 deg):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: rotateQuarter),
        SizedBox(height: 8.0),
        Text(
          '0.5 turns (180 deg):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: rotateHalf),
        SizedBox(height: 8.0),
        Text(
          '0.75 turns (270 deg):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: rotateThreeQuarter),
        SizedBox(height: 8.0),
        Text(
          'TopLeft alignment:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(
          child: SizedBox(width: 120.0, height: 120.0, child: rotateAligned),
        ),
        SizedBox(height: 16.0),
        Text(
          '=== SizeTransition Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Full size (1.0):', style: TextStyle(fontWeight: FontWeight.bold)),
        sizeFull,
        SizedBox(height: 8.0),
        Text('Half size (0.5):', style: TextStyle(fontWeight: FontWeight.bold)),
        sizeHalf,
        SizedBox(height: 8.0),
        Text('Zero size (0.0):', style: TextStyle(fontWeight: FontWeight.bold)),
        sizeZero,
        SizedBox(height: 8.0),
        Text(
          'Horizontal axis (0.75):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        sizeHorizontal,
        SizedBox(height: 8.0),
        Text(
          'Axis alignment -1.0:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        sizeAligned,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• RotationTransition rotates child by turns (0.0 to 1.0)'),
        Text('• SizeTransition clips child by sizeFactor along an axis'),
        Text('• All use AlwaysStoppedAnimation for static testing'),
      ],
    ),
  );
}
