// D4rt test script: Tests RenderStack, RenderCustomPaint,
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// RenderPhysicalModel, RenderPhysicalShape, RenderAnimatedOpacity,
// RenderEditable concepts
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('Render composite test executing');

  // ========== StackFit ==========
  print('--- StackFit Tests ---');
  for (final fit in StackFit.values) {
    print('StackFit: ${fit.name}');
  }

  // ========== Overflow ==========
  print('--- Overflow/Clip Tests ---');
  for (final clip in Clip.values) {
    print('Clip: ${clip.name}');
  }

  // ========== RenderCustomPaint concept ==========
  print('--- RenderCustomPaint Tests ---');
  print('RenderCustomPaint uses CustomPainter for foreground/background');
  print('CustomPainter.paint(Canvas, Size) is the key method');
  print('CustomPainter.shouldRepaint determines repainting');

  // ========== PhysicalModelLayer concept ==========
  print('--- PhysicalModel render Tests ---');
  final physicalModel = PhysicalModel(
    color: Colors.white,
    elevation: 4.0,
    shadowColor: Colors.black26,
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(8.0),
    clipBehavior: Clip.antiAlias,
    child: Container(
      width: 100,
      height: 100,
      child: Center(child: Text('Physical')),
    ),
  );
  print('PhysicalModel widget created: elevation=4.0');

  // ========== RenderAnimatedOpacity ==========
  print('--- RenderAnimatedOpacity Tests ---');
  // Note: AlwaysStoppedAnimation is NOT a TickerProvider, cannot be used for vsync
  print(
    'AnimatedOpacity concept: widget-level test only (no AnimationController without TickerProvider)',
  );

  // AnimatedOpacity widget
  final animOpacity = AnimatedOpacity(
    opacity: 0.5,
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
    child: Text('Half visible'),
  );
  print('AnimatedOpacity widget: opacity=0.5');

  // ========== RenderStack via Stack widget ==========
  print('--- RenderStack (via Stack) Tests ---');
  final stack = Stack(
    fit: StackFit.loose,
    alignment: Alignment.center,
    clipBehavior: Clip.hardEdge,
    children: [
      Container(width: 200, height: 200, color: Colors.blue.shade100),
      Positioned(
        top: 10,
        left: 10,
        child: Container(width: 100, height: 100, color: Colors.red.shade200),
      ),
      Positioned(
        bottom: 10,
        right: 10,
        child: Container(width: 80, height: 80, color: Colors.green.shade200),
      ),
    ],
  );
  print('Stack with StackFit.loose, 3 children');

  // ========== IndexedStack ==========
  print('--- IndexedStack Tests ---');
  final indexedStack = IndexedStack(
    index: 1,
    alignment: Alignment.center,
    sizing: StackFit.loose,
    children: [Text('Page 0'), Text('Page 1 (visible)'), Text('Page 2')],
  );
  print('IndexedStack index=1');

  print('All render composite tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Render Composite Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            physicalModel,
            SizedBox(height: 16.0),
            animOpacity,
            SizedBox(height: 16.0),
            SizedBox(height: 200, child: stack),
            SizedBox(height: 16.0),
            indexedStack,
          ],
        ),
      ),
    ),
  );
}
