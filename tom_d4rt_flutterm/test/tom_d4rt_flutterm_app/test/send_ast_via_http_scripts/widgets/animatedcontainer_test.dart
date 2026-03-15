// D4rt test script: Tests AnimatedContainer from widgets
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimatedContainer test executing');

  // Test AnimatedContainer with duration
  final basicAnimated = AnimatedContainer(
    duration: Duration(milliseconds: 300),
    width: 100.0,
    height: 100.0,
    color: Colors.blue,
    child: Center(
      child: Text('Basic', style: TextStyle(color: Colors.white)),
    ),
  );
  print('AnimatedContainer with duration=300ms created');

  // Test AnimatedContainer with curve
  final curvedAnimated = AnimatedContainer(
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOut,
    width: 150.0,
    height: 80.0,
    color: Colors.green,
    child: Center(
      child: Text('Curved', style: TextStyle(color: Colors.white)),
    ),
  );
  print('AnimatedContainer with curve=easeInOut created');

  // Test AnimatedContainer with BoxDecoration
  final decoratedAnimated = AnimatedContainer(
    duration: Duration(milliseconds: 400),
    width: 120.0,
    height: 120.0,
    decoration: BoxDecoration(
      color: Colors.orange,
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10.0,
          offset: Offset(2.0, 2.0),
        ),
      ],
    ),
    child: Center(
      child: Text('Decorated', style: TextStyle(color: Colors.white)),
    ),
  );
  print('AnimatedContainer with BoxDecoration created');

  // Test AnimatedContainer with different size
  final largeAnimated = AnimatedContainer(
    duration: Duration(milliseconds: 600),
    curve: Curves.bounceOut,
    width: 200.0,
    height: 60.0,
    color: Colors.purple,
    child: Center(
      child: Text('Large', style: TextStyle(color: Colors.white)),
    ),
  );
  print('AnimatedContainer with large size created');

  // Test AnimatedContainer with small size
  final smallAnimated = AnimatedContainer(
    duration: Duration(milliseconds: 600),
    curve: Curves.elasticOut,
    width: 60.0,
    height: 60.0,
    color: Colors.red,
    child: Center(
      child: Text('S', style: TextStyle(color: Colors.white, fontSize: 12.0)),
    ),
  );
  print('AnimatedContainer with small size created');

  // Test AnimatedContainer with padding
  final paddedAnimated = AnimatedContainer(
    duration: Duration(milliseconds: 350),
    padding: EdgeInsets.all(16.0),
    width: 160.0,
    height: 80.0,
    color: Colors.teal,
    child: Text('Padded', style: TextStyle(color: Colors.white)),
  );
  print('AnimatedContainer with padding created');

  // Test AnimatedContainer with margin
  final marginAnimated = AnimatedContainer(
    duration: Duration(milliseconds: 350),
    margin: EdgeInsets.symmetric(horizontal: 20.0),
    width: 140.0,
    height: 60.0,
    color: Colors.indigo,
    child: Center(
      child: Text('Margin', style: TextStyle(color: Colors.white)),
    ),
  );
  print('AnimatedContainer with margin created');

  // Test AnimatedContainer with alignment
  final alignedAnimated = AnimatedContainer(
    duration: Duration(milliseconds: 300),
    width: 180.0,
    height: 80.0,
    color: Colors.brown,
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: EdgeInsets.only(left: 8.0),
      child: Text('Aligned left', style: TextStyle(color: Colors.white)),
    ),
  );
  print('AnimatedContainer with alignment created');

  // Test AnimatedContainer with constraints
  final constrainedAnimated = AnimatedContainer(
    duration: Duration(milliseconds: 500),
    constraints: BoxConstraints(
      minWidth: 50.0,
      maxWidth: 200.0,
      minHeight: 40.0,
      maxHeight: 80.0,
    ),
    color: Colors.pink,
    child: Center(
      child: Text('Constrained', style: TextStyle(color: Colors.white)),
    ),
  );
  print('AnimatedContainer with constraints created');

  // Test AnimatedContainer with transform
  final transformedAnimated = AnimatedContainer(
    duration: Duration(milliseconds: 400),
    width: 100.0,
    height: 50.0,
    color: Colors.cyan,
    transform: Matrix4.rotationZ(0.05),
    child: Center(
      child: Text('Rotated', style: TextStyle(color: Colors.white)),
    ),
  );
  print('AnimatedContainer with transform created');

  print('AnimatedContainer test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'AnimatedContainer Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text('Basic (300ms):', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: basicAnimated),
        SizedBox(height: 8.0),
        Text(
          'Curved (easeInOut):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: curvedAnimated),
        SizedBox(height: 8.0),
        Text('Decorated:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: decoratedAnimated),
        SizedBox(height: 8.0),
        Text(
          'Large (bounceOut):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: largeAnimated),
        SizedBox(height: 8.0),
        Text(
          'Small (elasticOut):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: smallAnimated),
        SizedBox(height: 8.0),
        Text('Padded:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: paddedAnimated),
        SizedBox(height: 8.0),
        Text('Margin:', style: TextStyle(fontWeight: FontWeight.bold)),
        marginAnimated,
        SizedBox(height: 8.0),
        Text('Aligned:', style: TextStyle(fontWeight: FontWeight.bold)),
        alignedAnimated,
        SizedBox(height: 8.0),
        Text('Constrained:', style: TextStyle(fontWeight: FontWeight.bold)),
        constrainedAnimated,
        SizedBox(height: 8.0),
        Text('Transformed:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: transformedAnimated),
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• AnimatedContainer animates between property changes'),
        Text('• duration controls animation length'),
        Text('• curve controls animation easing'),
        Text('• Supports decoration, size, padding, margin, transform'),
        Text('• No AnimationController needed'),
      ],
    ),
  );
}
