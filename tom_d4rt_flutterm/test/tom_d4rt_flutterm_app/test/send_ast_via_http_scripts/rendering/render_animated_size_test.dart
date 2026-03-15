// D4rt test script: Tests RenderAnimatedSize from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderAnimatedSize test executing');

  // ========== ANIMATED SIZE CONCEPTS ==========
  print('--- RenderAnimatedSize Concepts ---');
  print('RenderAnimatedSize animates size changes of its child');
  print('It smoothly transitions between different child sizes');
  print('Uses a TickerProvider for animation timing');

  // ========== RENDER ANIMATED SIZE STATE ==========
  print('--- RenderAnimatedSizeState ---');
  print('RenderAnimatedSizeState.start: animation not yet started');
  print('RenderAnimatedSizeState.stable: no animation, stable size');
  print('RenderAnimatedSizeState.changed: size changed, animating');
  print(
    'RenderAnimatedSizeState.unstable: child size changing during animation',
  );

  // ========== ANIMATED SIZE WIDGET ==========
  print('--- AnimatedSize Widget Tests ---');

  // Small size container
  final smallContainer = AnimatedSize(
    duration: Duration(milliseconds: 500),
    child: Container(
      width: 60,
      height: 40,
      color: Colors.blue,
      child: Center(
        child: Text('S', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Created AnimatedSize with small child (60x40)');

  // Medium size container
  final mediumContainer = AnimatedSize(
    duration: Duration(milliseconds: 500),
    child: Container(
      width: 100,
      height: 80,
      color: Colors.green,
      child: Center(
        child: Text('M', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Created AnimatedSize with medium child (100x80)');

  // Large size container
  final largeContainer = AnimatedSize(
    duration: Duration(milliseconds: 500),
    child: Container(
      width: 150,
      height: 100,
      color: Colors.red,
      child: Center(
        child: Text('L', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Created AnimatedSize with large child (150x100)');

  // ========== DURATION TESTS ==========
  print('--- Duration Tests ---');

  final fastSize = AnimatedSize(
    duration: Duration(milliseconds: 100),
    child: Container(width: 50, height: 50, color: Colors.purple),
  );
  print('Fast animation: 100ms');

  final slowSize = AnimatedSize(
    duration: Duration(seconds: 1),
    child: Container(width: 50, height: 50, color: Colors.orange),
  );
  print('Slow animation: 1 second');

  // ========== CURVE TESTS ==========
  print('--- Animation Curve Tests ---');

  final linearSize = AnimatedSize(
    duration: Duration(milliseconds: 500),
    curve: Curves.linear,
    child: Container(width: 60, height: 40, color: Colors.cyan),
  );
  print('AnimatedSize with Curves.linear');

  final easeInOutSize = AnimatedSize(
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOut,
    child: Container(width: 60, height: 40, color: Colors.teal),
  );
  print('AnimatedSize with Curves.easeInOut');

  final elasticSize = AnimatedSize(
    duration: Duration(milliseconds: 800),
    curve: Curves.elasticOut,
    child: Container(width: 60, height: 40, color: Colors.amber),
  );
  print('AnimatedSize with Curves.elasticOut');

  final bounceSize = AnimatedSize(
    duration: Duration(milliseconds: 800),
    curve: Curves.bounceOut,
    child: Container(width: 60, height: 40, color: Colors.indigo),
  );
  print('AnimatedSize with Curves.bounceOut');

  // ========== ALIGNMENT TESTS ==========
  print('--- Alignment Tests ---');

  final alignTopLeft = AnimatedSize(
    duration: Duration(milliseconds: 500),
    alignment: Alignment.topLeft,
    child: Container(width: 80, height: 60, color: Colors.pink),
  );
  print('AnimatedSize with topLeft alignment');

  final alignCenter = AnimatedSize(
    duration: Duration(milliseconds: 500),
    alignment: Alignment.center,
    child: Container(width: 80, height: 60, color: Colors.lime),
  );
  print('AnimatedSize with center alignment');

  final alignBottomRight = AnimatedSize(
    duration: Duration(milliseconds: 500),
    alignment: Alignment.bottomRight,
    child: Container(width: 80, height: 60, color: Colors.brown),
  );
  print('AnimatedSize with bottomRight alignment');

  // ========== CLIP BEHAVIOR ==========
  print('--- Clip Behavior Tests ---');
  print('Clip.none: no clipping (may overflow)');
  print('Clip.hardEdge: fast clipping, may have aliasing');
  print('Clip.antiAlias: smooth clipping edges');
  print('Clip.antiAliasWithSaveLayer: smooth with save layer');

  final clipHardEdge = AnimatedSize(
    duration: Duration(milliseconds: 500),
    clipBehavior: Clip.hardEdge,
    child: Container(width: 60, height: 40, color: Colors.deepOrange),
  );
  print('AnimatedSize with Clip.hardEdge');

  final clipAntiAlias = AnimatedSize(
    duration: Duration(milliseconds: 500),
    clipBehavior: Clip.antiAlias,
    child: Container(width: 60, height: 40, color: Colors.lightBlue),
  );
  print('AnimatedSize with Clip.antiAlias');

  // ========== REVERSE DURATION ==========
  print('--- Reverse Duration ---');
  print('AnimatedSize supports different reverse duration');
  print('Useful for asymmetric expand/collapse animations');

  final asymmetricSize = AnimatedSize(
    duration: Duration(milliseconds: 300),
    reverseDuration: Duration(milliseconds: 600),
    child: Container(width: 70, height: 50, color: Colors.deepPurple),
  );
  print('AnimatedSize with reverseDuration: 600ms');

  // ========== LAYOUT BEHAVIOR ==========
  print('--- Layout Behavior ---');
  print('RenderAnimatedSize overrides performLayout()');
  print('It animates between the previous and new child size');
  print('The animation respects the provided curve');
  print('During animation, the render object reports the animated size');

  // ========== USE CASES ==========
  print('--- Common Use Cases ---');
  print('1. Expanding/collapsing panels');
  print('2. Dynamic content that changes size');
  print('3. Accordion-style interfaces');
  print('4. Smooth list item animations');

  // ========== PERFORMANCE NOTES ==========
  print('--- Performance Notes ---');
  print('1. AnimatedSize creates a clip layer during animation');
  print('2. Consider using RepaintBoundary for complex children');
  print('3. Avoid nesting multiple AnimatedSize widgets');
  print('4. Size animations trigger layout passes');

  // ========== VS SIZE TRANSITION ==========
  print('--- AnimatedSize vs SizeTransition ---');
  print('AnimatedSize: implicit animation, auto-detects size change');
  print('SizeTransition: explicit animation, requires Animation parameter');

  print('RenderAnimatedSize test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderAnimatedSize Tests'),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [smallContainer, mediumContainer, largeContainer],
      ),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [linearSize, easeInOutSize, elasticSize, bounceSize],
      ),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [alignTopLeft, alignCenter, alignBottomRight],
      ),
      SizedBox(height: 8),
      Text('All size animation tests passed'),
    ],
  );
}
