// D4rt test script: Tests Opacity and FadeTransition widgets from widgets
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Opacity test executing');

  // Test basic Opacity
  final fullyOpaque = Opacity(
    opacity: 1.0,
    child: Container(
      height: 50.0,
      color: Colors.blue,
      child: Center(
        child: Text('Opacity: 1.0', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Opacity(1.0) created - fully visible');

  final halfOpacity = Opacity(
    opacity: 0.5,
    child: Container(
      height: 50.0,
      color: Colors.blue,
      child: Center(
        child: Text('Opacity: 0.5', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Opacity(0.5) created - half transparent');

  final quarterOpacity = Opacity(
    opacity: 0.25,
    child: Container(
      height: 50.0,
      color: Colors.blue,
      child: Center(
        child: Text('Opacity: 0.25', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Opacity(0.25) created - mostly transparent');

  final fullyTransparent = Opacity(
    opacity: 0.0,
    child: Container(
      height: 50.0,
      color: Colors.blue,
      child: Center(
        child: Text('Opacity: 0.0', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Opacity(0.0) created - fully transparent');

  // Test Opacity with alwaysIncludeSemantics
  final withSemantics = Opacity(
    opacity: 0.0,
    alwaysIncludeSemantics: true,
    child: Text('Semantics included when invisible'),
  );
  print('Opacity with alwaysIncludeSemantics=true created');

  // Test FadeTransition
  final fadeAnimation = AlwaysStoppedAnimation<double>(0.5);
  final fadeTransition = FadeTransition(
    opacity: fadeAnimation,
    child: Container(
      height: 50.0,
      color: Colors.green,
      child: Center(
        child: Text('FadeTransition', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('FadeTransition with AlwaysStoppedAnimation(0.5) created');

  // Test FadeTransition with alwaysIncludeSemantics
  final fadeWithSemantics = FadeTransition(
    opacity: AlwaysStoppedAnimation<double>(0.0),
    alwaysIncludeSemantics: true,
    child: Text('Fade with semantics'),
  );
  print('FadeTransition with alwaysIncludeSemantics=true created');

  // Test opacity values
  print('Opacity must be between 0.0 and 1.0');
  print('Opacity 0.0 = fully transparent');
  print('Opacity 1.0 = fully opaque');

  // Test AnimatedOpacity
  final animatedOpacity = AnimatedOpacity(
    opacity: 0.75,
    duration: Duration(milliseconds: 300),
    child: Container(
      height: 50.0,
      color: Colors.purple,
      child: Center(
        child: Text('AnimatedOpacity', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('AnimatedOpacity with duration=300ms created');

  // Test AnimatedOpacity with curve
  final animatedOpacityCurve = AnimatedOpacity(
    opacity: 0.5,
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOut,
    child: Container(
      height: 50.0,
      color: Colors.orange,
      child: Center(
        child: Text(
          'AnimatedOpacity with Curve',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
  print('AnimatedOpacity with curve=easeInOut created');

  // Test AnimatedOpacity with onEnd
  final animatedOpacityCallback = AnimatedOpacity(
    opacity: 0.8,
    duration: Duration(milliseconds: 200),
    onEnd: () {
      print('AnimatedOpacity animation completed');
    },
    child: Container(
      height: 50.0,
      color: Colors.teal,
      child: Center(
        child: Text('With onEnd', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('AnimatedOpacity with onEnd callback created');

  // Test SliverOpacity
  print('SliverOpacity - opacity for sliver children');

  // Test opacity stack
  final opacityStack = Stack(
    children: [
      Container(
        height: 100.0,
        color: Colors.red,
        child: Center(
          child: Text(
            'Base Layer',
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ),
      ),
      Opacity(
        opacity: 0.7,
        child: Container(
          height: 100.0,
          color: Colors.blue,
          child: Center(
            child: Text(
              'Semi-transparent Overlay',
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
          ),
        ),
      ),
    ],
  );
  print('Stack with opacity overlay created');

  // Test performance notes
  print(
    'Performance: Opacity is expensive, prefer using colors with opacity when possible',
  );
  print('Container(color: Colors.blue.withOpacity(0.5)) is more efficient');

  // Test color with opacity alternative
  final colorOpacity = Container(
    height: 50.0,
    color: Colors.blue.withOpacity(0.5),
    child: Center(
      child: Text('Color with opacity', style: TextStyle(color: Colors.white)),
    ),
  );
  print('Container with color.withOpacity(0.5) created');

  // Test Visibility as alternative
  final visibilityWidget = Visibility(
    visible: true,
    child: Text('Visibility widget'),
  );
  print('Visibility widget created as alternative');

  final invisibleWidget = Visibility(
    visible: false,
    maintainSize: true,
    maintainAnimation: true,
    maintainState: true,
    child: Text('Invisible but maintains space'),
  );
  print('Visibility with maintainSize=true created');

  print('Opacity test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Opacity Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text('Opacity Values:', style: TextStyle(fontWeight: FontWeight.bold)),
        fullyOpaque,
        SizedBox(height: 4.0),
        halfOpacity,
        SizedBox(height: 4.0),
        quarterOpacity,
        SizedBox(height: 4.0),
        Container(
          height: 50.0,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Center(
            child: Stack(children: [Text('(invisible)'), fullyTransparent]),
          ),
        ),
        SizedBox(height: 16.0),

        Text('FadeTransition:', style: TextStyle(fontWeight: FontWeight.bold)),
        fadeTransition,
        SizedBox(height: 16.0),

        Text('AnimatedOpacity:', style: TextStyle(fontWeight: FontWeight.bold)),
        animatedOpacity,
        SizedBox(height: 4.0),
        animatedOpacityCurve,
        SizedBox(height: 4.0),
        animatedOpacityCallback,
        SizedBox(height: 16.0),

        Text('Opacity Stack:', style: TextStyle(fontWeight: FontWeight.bold)),
        opacityStack,
        SizedBox(height: 16.0),

        Text(
          'Color Opacity Alternative:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        colorOpacity,
        SizedBox(height: 16.0),

        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Opacity(opacity: 0-1) - static opacity'),
        Text('• FadeTransition - animated with Animation<double>'),
        Text('• AnimatedOpacity - implicit animation'),
        Text('• alwaysIncludeSemantics - for accessibility'),
        Text('• color.withOpacity() - more performant'),
      ],
    ),
  );
}
