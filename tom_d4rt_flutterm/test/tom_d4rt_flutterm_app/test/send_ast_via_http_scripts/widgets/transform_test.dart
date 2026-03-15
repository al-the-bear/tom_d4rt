// D4rt test script: Tests Transform widget from widgets
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'dart:math' as math;

dynamic build(BuildContext context) {
  print('Transform test executing');

  // Test Transform.rotate
  final rotated = Transform.rotate(
    angle: math.pi / 4, // 45 degrees
    child: Container(
      height: 60.0,
      width: 60.0,
      color: Colors.blue,
      child: Center(
        child: Text('45°', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Transform.rotate(45 degrees) created');

  final rotatedOrigin = Transform.rotate(
    angle: math.pi / 6, // 30 degrees
    origin: Offset(30.0, 30.0), // rotate around center
    child: Container(
      height: 60.0,
      width: 60.0,
      color: Colors.green,
      child: Center(
        child: Text('30°', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Transform.rotate with origin created');

  // Test Transform.scale
  final scaled = Transform.scale(
    scale: 1.5,
    child: Container(
      height: 40.0,
      width: 40.0,
      color: Colors.red,
      child: Center(
        child: Text(
          '1.5x',
          style: TextStyle(color: Colors.white, fontSize: 10.0),
        ),
      ),
    ),
  );
  print('Transform.scale(1.5) created');

  final scaledXY = Transform.scale(
    scaleX: 2.0,
    scaleY: 0.5,
    child: Container(
      height: 40.0,
      width: 40.0,
      color: Colors.purple,
      child: Center(
        child: Text(
          '2x0.5',
          style: TextStyle(color: Colors.white, fontSize: 10.0),
        ),
      ),
    ),
  );
  print('Transform.scale(scaleX: 2.0, scaleY: 0.5) created');

  // Test Transform.translate
  final translated = Transform.translate(
    offset: Offset(20.0, 10.0),
    child: Container(
      height: 50.0,
      width: 100.0,
      color: Colors.orange,
      child: Center(
        child: Text('Translated', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Transform.translate(20, 10) created');

  // Test Transform.flip
  final flippedH = Transform.flip(
    flipX: true,
    child: Container(
      height: 50.0,
      width: 100.0,
      color: Colors.teal,
      child: Center(
        child: Text('Flip X', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Transform.flip(flipX: true) created');

  final flippedV = Transform.flip(
    flipY: true,
    child: Container(
      height: 50.0,
      width: 100.0,
      color: Colors.cyan,
      child: Center(
        child: Text('Flip Y', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Transform.flip(flipY: true) created');

  // Test Transform with Matrix4
  final matrix = Matrix4.identity();
  matrix.setEntry(3, 2, 0.001); // perspective
  matrix.rotateY(0.2);

  final perspective = Transform(
    transform: matrix,
    alignment: Alignment.center,
    child: Container(
      height: 80.0,
      width: 120.0,
      color: Colors.indigo,
      child: Center(
        child: Text('3D', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Transform with Matrix4 perspective created');

  // Test Transform with alignment
  final alignedTransform = Transform.rotate(
    angle: math.pi / 8,
    alignment: Alignment.topLeft,
    child: Container(
      height: 60.0,
      width: 100.0,
      color: Colors.pink,
      child: Center(
        child: Text(
          'Top-Left Origin',
          style: TextStyle(color: Colors.white, fontSize: 10.0),
        ),
      ),
    ),
  );
  print('Transform with alignment=topLeft created');

  // Test Transform with transformHitTests
  final hitTestTransform = Transform.rotate(
    angle: math.pi / 4,
    transformHitTests: true,
    child: GestureDetector(
      onTap: () => print('Rotated button tapped'),
      child: Container(
        height: 60.0,
        width: 60.0,
        color: Colors.amber,
        child: Center(
          child: Text('Tap', style: TextStyle(color: Colors.black)),
        ),
      ),
    ),
  );
  print('Transform with transformHitTests=true created');

  // Test Matrix4 operations
  print('Matrix4 operations:');
  final m1 = Matrix4.identity();
  print('Matrix4.identity() created');

  final m2 = Matrix4.rotationZ(math.pi / 2);
  print('Matrix4.rotationZ(90°) created');

  final m3 = Matrix4.rotationX(0.5);
  print('Matrix4.rotationX created');

  final m4 = Matrix4.rotationY(0.5);
  print('Matrix4.rotationY created');

  final m5 = Matrix4.translationValues(10.0, 20.0, 0.0);
  print('Matrix4.translationValues(10, 20, 0) created');

  final m6 = Matrix4.diagonal3Values(2.0, 2.0, 1.0);
  print('Matrix4.diagonal3Values(2, 2, 1) - scale created');

  final m7 = Matrix4.skewX(0.2);
  print('Matrix4.skewX(0.2) created');

  final m8 = Matrix4.skewY(0.2);
  print('Matrix4.skewY(0.2) created');

  // Test combining transforms
  final combined = Transform.rotate(
    angle: math.pi / 6,
    child: Transform.scale(
      scale: 1.2,
      child: Container(
        height: 50.0,
        width: 80.0,
        color: Colors.lime,
        child: Center(
          child: Text('Combined', style: TextStyle(color: Colors.black)),
        ),
      ),
    ),
  );
  print('Combined Transform (rotate + scale) created');

  // Test RotatedBox (different from Transform.rotate)
  final rotatedBox = RotatedBox(
    quarterTurns: 1, // 90 degrees clockwise
    child: Container(
      height: 60.0,
      width: 100.0,
      color: Colors.brown,
      child: Center(
        child: Text('RotatedBox', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('RotatedBox(quarterTurns: 1) created');

  // Test AnimatedContainer transform
  print('AnimatedContainer supports transform property');

  print('Transform test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Transform Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text(
          'Transform.rotate:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 40.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(height: 80.0, width: 80.0, child: Center(child: rotated)),
            Container(
              height: 80.0,
              width: 80.0,
              child: Center(child: rotatedOrigin),
            ),
          ],
        ),
        SizedBox(height: 40.0),

        Text('Transform.scale:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(height: 80.0, width: 80.0, child: Center(child: scaled)),
            Container(
              height: 80.0,
              width: 80.0,
              child: Center(child: scaledXY),
            ),
          ],
        ),
        SizedBox(height: 30.0),

        Text(
          'Transform.translate:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          height: 80.0,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: translated,
        ),
        SizedBox(height: 16.0),

        Text('Transform.flip:', style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [flippedH, flippedV],
        ),
        SizedBox(height: 16.0),

        Text(
          'Matrix4 Perspective:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: perspective),
        SizedBox(height: 30.0),

        Text(
          'Combined Transform:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20.0),
        Center(child: combined),
        SizedBox(height: 30.0),

        Text('RotatedBox:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: rotatedBox),
        SizedBox(height: 16.0),

        Text('Transform Types:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Transform.rotate - rotation'),
        Text('• Transform.scale - scaling'),
        Text('• Transform.translate - translation'),
        Text('• Transform.flip - horizontal/vertical flip'),
        Text('• Transform(transform: Matrix4) - custom'),
        Text('• RotatedBox - 90° increments'),
      ],
    ),
  );
}
