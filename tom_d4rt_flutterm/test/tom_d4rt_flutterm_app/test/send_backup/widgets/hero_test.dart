// D4rt test script: Tests Hero from widgets
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Hero test executing');

  // Test Hero with tag and child
  final heroBasic = Hero(
    tag: 'hero-basic',
    child: Container(
      width: 100.0,
      height: 100.0,
      color: Colors.blue,
      child: Center(
        child: Text('Basic Hero', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Hero with tag=hero-basic created');

  // Test Hero with string tag
  final heroString = Hero(
    tag: 'hero-string-tag',
    child: Container(
      width: 120.0,
      height: 80.0,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Center(
        child: Text('String tag', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Hero with string tag created');

  // Test Hero with int tag
  final heroInt = Hero(
    tag: 42,
    child: Container(
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
      child: Center(
        child: Text(
          '42',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
    ),
  );
  print('Hero with int tag=42 created');

  // Test Hero with Icon child
  final heroIcon = Hero(
    tag: 'hero-icon',
    child: Icon(Icons.star, size: 64.0, color: Colors.amber),
  );
  print('Hero with Icon child created');

  // Test Hero with Image-like child (using Container with decoration)
  final heroImage = Hero(
    tag: 'hero-image',
    child: Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.white, width: 2.0),
      ),
      child: Center(child: Icon(Icons.image, size: 40.0, color: Colors.white)),
    ),
  );
  print('Hero with image-like child created');

  // Test Hero with createRectTween
  final heroRectTween = Hero(
    tag: 'hero-rect-tween',
    createRectTween: (Rect? begin, Rect? end) {
      print('createRectTween called: begin=$begin, end=$end');
      return MaterialRectCenterArcTween(begin: begin, end: end);
    },
    child: Container(
      width: 100.0,
      height: 60.0,
      color: Colors.red,
      child: Center(
        child: Text('RectTween', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Hero with createRectTween created');

  // Test Hero with flightShuttleBuilder
  final heroShuttle = Hero(
    tag: 'hero-shuttle',
    flightShuttleBuilder:
        (
          BuildContext flightContext,
          Animation animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext,
        ) {
          print('flightShuttleBuilder called, direction=$flightDirection');
          return Container(
            color: Colors.yellow,
            child: Center(child: Text('In flight!')),
          );
        },
    child: Container(
      width: 100.0,
      height: 60.0,
      color: Colors.teal,
      child: Center(
        child: Text('Shuttle', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Hero with flightShuttleBuilder created');

  // Test Hero with placeholderBuilder
  final heroPlaceholder = Hero(
    tag: 'hero-placeholder',
    placeholderBuilder: (BuildContext ctx, Size heroSize, Widget child) {
      print('placeholderBuilder called: size=$heroSize');
      return SizedBox(width: heroSize.width, height: heroSize.height);
    },
    child: Container(
      width: 100.0,
      height: 60.0,
      color: Colors.indigo,
      child: Center(
        child: Text('Placeholder', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Hero with placeholderBuilder created');

  // Test Hero with Card child
  final heroCard = Hero(
    tag: 'hero-card',
    child: Card(
      elevation: 8.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.flight, size: 32.0, color: Colors.blue),
            SizedBox(height: 8.0),
            Text('Hero Card'),
          ],
        ),
      ),
    ),
  );
  print('Hero with Card child created');

  print('Hero test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Hero Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text('Basic Hero:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: heroBasic),
        SizedBox(height: 8.0),
        Text('String tag:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: heroString),
        SizedBox(height: 8.0),
        Text('Int tag (42):', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: heroInt),
        SizedBox(height: 8.0),
        Text('Icon Hero:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: heroIcon),
        SizedBox(height: 8.0),
        Text('Image-like Hero:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: heroImage),
        SizedBox(height: 8.0),
        Text(
          'With createRectTween:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: heroRectTween),
        SizedBox(height: 8.0),
        Text(
          'With flightShuttleBuilder:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: heroShuttle),
        SizedBox(height: 8.0),
        Text(
          'With placeholderBuilder:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: heroPlaceholder),
        SizedBox(height: 8.0),
        Text('Hero Card:', style: TextStyle(fontWeight: FontWeight.bold)),
        heroCard,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Hero animates between routes with matching tags'),
        Text('• tag must be unique within a route'),
        Text('• createRectTween customizes flight path'),
        Text('• flightShuttleBuilder customizes in-flight widget'),
        Text('• placeholderBuilder replaces widget during flight'),
      ],
    ),
  );
}
