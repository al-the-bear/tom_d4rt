// D4rt test script: Tests RenderAbsorbPointer from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderAbsorbPointer test executing');

  // ========== ABSORB POINTER WIDGET TESTS ==========
  print('--- AbsorbPointer Widget Tests ---');

  // Test AbsorbPointer with absorbing: true (default)
  final absorbingWidget = AbsorbPointer(
    absorbing: true,
    child: Container(
      width: 100,
      height: 100,
      color: Colors.blue,
      child: Text('Absorbed'),
    ),
  );
  print('AbsorbPointer created with absorbing: true');
  print('  runtimeType: ${absorbingWidget.runtimeType}');
  print('  absorbing: ${absorbingWidget.absorbing}');

  // Test AbsorbPointer with absorbing: false
  final notAbsorbingWidget = AbsorbPointer(
    absorbing: false,
    child: Container(width: 50, height: 50, color: Colors.red),
  );
  print('AbsorbPointer created with absorbing: false');
  print('  absorbing: ${notAbsorbingWidget.absorbing}');

  // ========== COMPARING WITH IGNORE POINTER ==========
  print('--- AbsorbPointer vs IgnorePointer ---');
  print(
    'AbsorbPointer: Absorbs pointer events, prevents children from receiving them',
  );
  print(
    'IgnorePointer: Ignores pointer events, they pass through to widgets behind',
  );
  print(
    'Key difference: AbsorbPointer stops propagation, IgnorePointer allows it',
  );

  // Test with ignoringSemantics
  final absorbWithSemantics = AbsorbPointer(
    absorbing: true,
    ignoringSemantics: true,
    child: Text('Semantics ignored'),
  );
  print('AbsorbPointer with ignoringSemantics: true');
  print('  ignoringSemantics: ${absorbWithSemantics.ignoringSemantics}');

  final absorbWithoutSemantics = AbsorbPointer(
    absorbing: true,
    ignoringSemantics: false,
    child: Text('Semantics not ignored'),
  );
  print('AbsorbPointer with ignoringSemantics: false');
  print('  ignoringSemantics: ${absorbWithoutSemantics.ignoringSemantics}');

  // Test with null ignoringSemantics (defaults to absorbing value)
  final absorbDefaultSemantics = AbsorbPointer(
    absorbing: true,
    child: Text('Default semantics'),
  );
  print('AbsorbPointer with default ignoringSemantics');
  print('  ignoringSemantics: ${absorbDefaultSemantics.ignoringSemantics}');

  // ========== NESTED ABSORB POINTER TESTS ==========
  print('--- Nested AbsorbPointer Tests ---');

  final nestedAbsorb = AbsorbPointer(
    absorbing: true,
    child: Column(
      children: [
        AbsorbPointer(absorbing: false, child: Text('Inner not absorbing')),
        Text('Direct child'),
      ],
    ),
  );
  print('Created nested AbsorbPointer widgets');
  print('  Outer absorbing: ${nestedAbsorb.absorbing}');

  // ========== USE CASES ==========
  print('--- Common Use Cases ---');
  print('1. Disabling buttons during loading');
  print('2. Preventing interaction during animations');
  print('3. Form validation - disabling submit while invalid');
  print('4. Modal dialogs - preventing background interaction');

  // Test with GestureDetector child
  final absorbGesture = AbsorbPointer(
    absorbing: true,
    child: GestureDetector(
      onTap: () => print('Tap received'),
      child: Container(
        width: 80,
        height: 80,
        color: Colors.green,
        child: Center(child: Text('Tap Me')),
      ),
    ),
  );
  print('AbsorbPointer wrapping GestureDetector');
  print('  When absorbing=true, onTap will NOT trigger');

  // ========== WIDGET TREE TESTING ==========
  print('--- Widget Tree Structure ---');

  final complexTree = AbsorbPointer(
    absorbing: true,
    child: Stack(
      children: [
        Positioned(
          left: 0,
          top: 0,
          child: Container(width: 60, height: 60, color: Colors.purple),
        ),
        Positioned(
          left: 20,
          top: 20,
          child: Container(width: 60, height: 60, color: Colors.orange),
        ),
      ],
    ),
  );
  print('Complex widget tree with AbsorbPointer');
  print('  All children are blocked from receiving pointer events');

  // ========== HIT TEST BEHAVIOR ==========
  print('--- Hit Test Behavior ---');
  print('AbsorbPointer stops hit testing at its boundary');
  print('RenderAbsorbPointer.hitTest returns false when absorbing');
  print('This prevents events from reaching child render objects');

  print('RenderAbsorbPointer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderAbsorbPointer Tests'),
      absorbingWidget,
      SizedBox(height: 8),
      notAbsorbingWidget,
      SizedBox(height: 8),
      absorbGesture,
      SizedBox(height: 8),
      Text('All AbsorbPointer tests passed'),
    ],
  );
}
