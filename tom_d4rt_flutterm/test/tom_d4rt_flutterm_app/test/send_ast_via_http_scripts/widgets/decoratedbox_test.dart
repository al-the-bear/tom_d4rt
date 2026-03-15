// D4rt test script: Tests DecoratedBox, ColoredBox, RotatedBox from widgets
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DecoratedBox test executing');

  // Test DecoratedBox with BoxDecoration color
  final decoratedColor = DecoratedBox(
    decoration: BoxDecoration(color: Colors.blue),
    child: SizedBox(
      width: 200.0,
      height: 60.0,
      child: Center(
        child: Text(
          'DecoratedBox color',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
  print('DecoratedBox with color created');

  // Test DecoratedBox with border radius
  final decoratedRounded = DecoratedBox(
    decoration: BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: SizedBox(
      width: 200.0,
      height: 60.0,
      child: Center(
        child: Text('Rounded', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('DecoratedBox with borderRadius created');

  // Test DecoratedBox with border
  final decoratedBorder = DecoratedBox(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.orange, width: 3.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: SizedBox(
      width: 200.0,
      height: 60.0,
      child: Center(
        child: Text('With border', style: TextStyle(color: Colors.orange)),
      ),
    ),
  );
  print('DecoratedBox with border created');

  // Test DecoratedBox with box shadow
  final decoratedShadow = DecoratedBox(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8.0,
          offset: Offset(2.0, 4.0),
        ),
      ],
    ),
    child: SizedBox(
      width: 200.0,
      height: 60.0,
      child: Center(child: Text('With shadow')),
    ),
  );
  print('DecoratedBox with boxShadow created');

  // Test DecoratedBox with gradient
  final decoratedGradient = DecoratedBox(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.purple, Colors.blue, Colors.cyan],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: SizedBox(
      width: 200.0,
      height: 60.0,
      child: Center(
        child: Text('Gradient', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('DecoratedBox with gradient created');

  // Test DecoratedBox with circle shape
  final decoratedCircle = DecoratedBox(
    decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
    child: SizedBox(
      width: 80.0,
      height: 80.0,
      child: Center(
        child: Text('Circle', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('DecoratedBox with circle shape created');

  // Test DecoratedBox with foreground decoration
  final decoratedForeground = DecoratedBox(
    decoration: BoxDecoration(color: Colors.blue),
    position: DecorationPosition.background,
    child: SizedBox(
      width: 200.0,
      height: 60.0,
      child: Center(
        child: Text('Background', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('DecoratedBox with background position created');

  // Test ColoredBox with color
  final coloredBoxBasic = ColoredBox(
    color: Colors.teal,
    child: SizedBox(
      width: 200.0,
      height: 60.0,
      child: Center(
        child: Text('ColoredBox', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('ColoredBox with teal color created');

  // Test ColoredBox with different colors
  final coloredBoxRed = ColoredBox(
    color: Colors.red,
    child: SizedBox(
      width: 200.0,
      height: 60.0,
      child: Center(
        child: Text('Red ColoredBox', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('ColoredBox with red color created');

  // Test ColoredBox with opacity
  final coloredBoxOpacity = ColoredBox(
    color: Color.fromRGBO(0, 0, 255, 0.5),
    child: SizedBox(
      width: 200.0,
      height: 60.0,
      child: Center(child: Text('Semi-transparent')),
    ),
  );
  print('ColoredBox with semi-transparent color created');

  // Test RotatedBox with quarterTurns 1
  final rotated1 = RotatedBox(
    quarterTurns: 1,
    child: Container(
      width: 80.0,
      height: 40.0,
      color: Colors.indigo,
      child: Center(
        child: Text(
          'Turn 1',
          style: TextStyle(color: Colors.white, fontSize: 12.0),
        ),
      ),
    ),
  );
  print('RotatedBox with quarterTurns=1 (90 degrees) created');

  // Test RotatedBox with quarterTurns 2
  final rotated2 = RotatedBox(
    quarterTurns: 2,
    child: Container(
      width: 80.0,
      height: 40.0,
      color: Colors.brown,
      child: Center(
        child: Text(
          'Turn 2',
          style: TextStyle(color: Colors.white, fontSize: 12.0),
        ),
      ),
    ),
  );
  print('RotatedBox with quarterTurns=2 (180 degrees) created');

  // Test RotatedBox with quarterTurns 3
  final rotated3 = RotatedBox(
    quarterTurns: 3,
    child: Container(
      width: 80.0,
      height: 40.0,
      color: Colors.pink,
      child: Center(
        child: Text(
          'Turn 3',
          style: TextStyle(color: Colors.white, fontSize: 12.0),
        ),
      ),
    ),
  );
  print('RotatedBox with quarterTurns=3 (270 degrees) created');

  // Test RotatedBox with quarterTurns 0 (no rotation)
  final rotated0 = RotatedBox(
    quarterTurns: 0,
    child: Container(
      width: 80.0,
      height: 40.0,
      color: Colors.amber,
      child: Center(
        child: Text(
          'Turn 0',
          style: TextStyle(color: Colors.black, fontSize: 12.0),
        ),
      ),
    ),
  );
  print('RotatedBox with quarterTurns=0 (no rotation) created');

  print('DecoratedBox test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'DecoratedBox / ColoredBox / RotatedBox Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text(
          'DecoratedBox - Color:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: decoratedColor),
        SizedBox(height: 8.0),
        Text(
          'DecoratedBox - Rounded:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: decoratedRounded),
        SizedBox(height: 8.0),
        Text(
          'DecoratedBox - Border:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: decoratedBorder),
        SizedBox(height: 8.0),
        Text(
          'DecoratedBox - Shadow:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: decoratedShadow),
        SizedBox(height: 8.0),
        Text(
          'DecoratedBox - Gradient:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: decoratedGradient),
        SizedBox(height: 8.0),
        Text(
          'DecoratedBox - Circle:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: decoratedCircle),
        SizedBox(height: 16.0),
        Text(
          'ColoredBox - Teal:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: coloredBoxBasic),
        SizedBox(height: 8.0),
        Text(
          'ColoredBox - Red:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: coloredBoxRed),
        SizedBox(height: 8.0),
        Text(
          'ColoredBox - Semi-transparent:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: coloredBoxOpacity),
        SizedBox(height: 16.0),
        Text('RotatedBox:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [Text('0 turns'), SizedBox(height: 4.0), rotated0],
            ),
            Column(children: [Text('1 turn'), SizedBox(height: 4.0), rotated1]),
            Column(
              children: [Text('2 turns'), SizedBox(height: 4.0), rotated2],
            ),
            Column(
              children: [Text('3 turns'), SizedBox(height: 4.0), rotated3],
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• DecoratedBox applies BoxDecoration'),
        Text('• Supports color, border, borderRadius, shadow, gradient'),
        Text('• ColoredBox is a simpler alternative for solid colors'),
        Text('• RotatedBox rotates child by 90-degree increments'),
        Text('• quarterTurns: 0=0, 1=90, 2=180, 3=270 degrees'),
      ],
    ),
  );
}
