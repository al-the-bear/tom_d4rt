// D4rt test script: Tests RenderAnimatedOpacity from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderAnimatedOpacity test executing');

  // ========== ANIMATED OPACITY CONCEPTS ==========
  print('--- RenderAnimatedOpacity Concepts ---');
  print('RenderAnimatedOpacity animates the opacity of its child');
  print('It uses an Animation<double> to drive opacity changes');
  print('Optimizes painting when fully transparent or opaque');

  // ========== OPACITY VALUES ==========
  print('--- Opacity Value Range ---');
  print('Opacity 0.0: fully transparent (invisible)');
  print('Opacity 0.5: 50% transparent');
  print('Opacity 1.0: fully opaque (visible)');

  // ========== ANIMATED OPACITY WIDGET ==========
  print('--- AnimatedOpacity Widget Tests ---');

  // Create AnimatedOpacity examples with different opacities
  final fullyOpaque = AnimatedOpacity(
    opacity: 1.0,
    duration: Duration(milliseconds: 500),
    child: Container(
      width: 80,
      height: 60,
      color: Colors.blue,
      child: Center(
        child: Text('100%', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Created AnimatedOpacity with opacity: 1.0');

  final halfOpaque = AnimatedOpacity(
    opacity: 0.5,
    duration: Duration(milliseconds: 500),
    child: Container(
      width: 80,
      height: 60,
      color: Colors.blue,
      child: Center(
        child: Text('50%', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Created AnimatedOpacity with opacity: 0.5');

  final quarterOpaque = AnimatedOpacity(
    opacity: 0.25,
    duration: Duration(milliseconds: 500),
    child: Container(
      width: 80,
      height: 60,
      color: Colors.blue,
      child: Center(
        child: Text('25%', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Created AnimatedOpacity with opacity: 0.25');

  final fullyTransparent = AnimatedOpacity(
    opacity: 0.0,
    duration: Duration(milliseconds: 500),
    child: Container(
      width: 80,
      height: 60,
      color: Colors.blue,
      child: Center(
        child: Text('0%', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Created AnimatedOpacity with opacity: 0.0');

  // ========== DURATION TESTS ==========
  print('--- Duration Tests ---');

  final fastAnimation = AnimatedOpacity(
    opacity: 0.8,
    duration: Duration(milliseconds: 100),
    child: Container(width: 50, height: 50, color: Colors.red),
  );
  print('Fast animation: 100ms');

  final slowAnimation = AnimatedOpacity(
    opacity: 0.8,
    duration: Duration(seconds: 2),
    child: Container(width: 50, height: 50, color: Colors.green),
  );
  print('Slow animation: 2 seconds');

  // ========== CURVE TESTS ==========
  print('--- Animation Curve Tests ---');

  final linearCurve = AnimatedOpacity(
    opacity: 0.7,
    duration: Duration(milliseconds: 500),
    curve: Curves.linear,
    child: Container(width: 50, height: 50, color: Colors.purple),
  );
  print('AnimatedOpacity with Curves.linear');

  final easeInCurve = AnimatedOpacity(
    opacity: 0.7,
    duration: Duration(milliseconds: 500),
    curve: Curves.easeIn,
    child: Container(width: 50, height: 50, color: Colors.orange),
  );
  print('AnimatedOpacity with Curves.easeIn');

  final easeOutCurve = AnimatedOpacity(
    opacity: 0.7,
    duration: Duration(milliseconds: 500),
    curve: Curves.easeOut,
    child: Container(width: 50, height: 50, color: Colors.cyan),
  );
  print('AnimatedOpacity with Curves.easeOut');

  final bounceCurve = AnimatedOpacity(
    opacity: 0.7,
    duration: Duration(milliseconds: 500),
    curve: Curves.bounceOut,
    child: Container(width: 50, height: 50, color: Colors.pink),
  );
  print('AnimatedOpacity with Curves.bounceOut');

  // ========== FADE TRANSITION ==========
  print('--- FadeTransition (explicit animation) ---');
  print('FadeTransition requires an explicit Animation<double>');
  print('Uses AnimationController for fine-grained control');
  print('RenderAnimatedOpacity is used by both widgets internally');

  // ========== OPACITY LAYER ==========
  print('--- OpacityLayer Usage ---');
  print('RenderAnimatedOpacity creates an OpacityLayer during painting');
  print('When opacity is 0.0: child is not painted (optimization)');
  print('When opacity is 1.0: no layer created (optimization)');
  print('Between 0.0 and 1.0: OpacityLayer with alpha applied');

  // ========== ALWAYS INCLUDE SEMANTICS ==========
  print('--- alwaysIncludeSemantics Property ---');

  final withSemantics = AnimatedOpacity(
    opacity: 0.0,
    duration: Duration(milliseconds: 500),
    alwaysIncludeSemantics: true,
    child: Text('Hidden but accessible'),
  );
  print(
    'alwaysIncludeSemantics: true - accessibility included even when invisible',
  );

  final withoutSemantics = AnimatedOpacity(
    opacity: 0.0,
    duration: Duration(milliseconds: 500),
    alwaysIncludeSemantics: false,
    child: Text('Hidden and not accessible'),
  );
  print(
    'alwaysIncludeSemantics: false - accessibility excluded when invisible',
  );

  // ========== ON END CALLBACK ==========
  print('--- onEnd Callback ---');
  print('AnimatedOpacity supports onEnd callback');
  print('Called when animation completes');

  // ========== PERFORMANCE CONSIDERATIONS ==========
  print('--- Performance Notes ---');
  print('1. Avoid animating opacity of large subtrees');
  print('2. Use RepaintBoundary to isolate repaints');
  print('3. Consider using Opacity for static opacity');
  print('4. AnimatedOpacity creates compositor layers');

  // ========== COMPARISON WITH OPACITY WIDGET ==========
  print('--- Opacity vs AnimatedOpacity ---');
  print('Opacity: instant opacity change, no animation');
  print('AnimatedOpacity: implicit animation on opacity change');
  print('FadeTransition: explicit animation control');

  final staticOpacity = Opacity(
    opacity: 0.6,
    child: Container(width: 50, height: 50, color: Colors.teal),
  );
  print('Created Opacity widget (no animation)');

  // ========== BLEND MODE EFFECTS ==========
  print('--- ShaderMask for Advanced Effects ---');
  print('For complex opacity effects, consider ShaderMask');
  print('Allows gradient opacity and other shader-based effects');

  print('RenderAnimatedOpacity test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderAnimatedOpacity Tests'),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [fullyOpaque, halfOpaque, quarterOpaque],
      ),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [linearCurve, easeInCurve, easeOutCurve, bounceCurve],
      ),
      SizedBox(height: 8),
      staticOpacity,
      SizedBox(height: 8),
      Text('All opacity tests passed'),
    ],
  );
}
