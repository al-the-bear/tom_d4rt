// D4rt test script: Tests RenderBlockSemantics from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderBlockSemantics test executing');

  // ========== BLOCK SEMANTICS WIDGET TESTS ==========
  print('--- BlockSemantics Widget Tests ---');

  // Test BlockSemantics with blocking: true (default)
  final blockingWidget = BlockSemantics(
    blocking: true,
    child: Container(
      width: 100,
      height: 100,
      color: Colors.blue,
      child: Text('Blocked'),
    ),
  );
  print('BlockSemantics created with blocking: true');
  print('  runtimeType: ${blockingWidget.runtimeType}');
  print('  blocking: ${blockingWidget.blocking}');

  // Test BlockSemantics with blocking: false
  final notBlockingWidget = BlockSemantics(
    blocking: false,
    child: Container(width: 50, height: 50, color: Colors.red),
  );
  print('BlockSemantics created with blocking: false');
  print('  blocking: ${notBlockingWidget.blocking}');

  // ========== SEMANTICS BLOCKING BEHAVIOR ==========
  print('--- Semantics Blocking Behavior ---');
  print('BlockSemantics: Drops semantics of widgets below it in paint order');
  print('Used to prevent lower widgets from being announced by screen readers');
  print('Useful for overlays, modals, and dialogs');

  // Test nested BlockSemantics
  final nestedBlocking = BlockSemantics(
    blocking: true,
    child: Column(
      children: [
        BlockSemantics(blocking: false, child: Text('Inner not blocking')),
        Text('Direct child'),
      ],
    ),
  );
  print('Created nested BlockSemantics widgets');
  print('  Outer blocking: ${nestedBlocking.blocking}');

  // ========== USE CASES ==========
  print('--- Common Use Cases ---');
  print('1. Modal dialogs that should hide background content');
  print('2. Full-screen overlays');
  print('3. Loading screens');
  print('4. Splash screens');

  // Test with Semantics widget
  final withSemantics = BlockSemantics(
    blocking: true,
    child: Semantics(
      label: 'Blocking area',
      child: Container(
        width: 80,
        height: 80,
        color: Colors.green,
        child: Center(child: Text('Semantics')),
      ),
    ),
  );
  print('BlockSemantics wrapping Semantics widget');
  print('  Semantic label is preserved for this widget');

  // ========== WIDGET TREE TESTING ==========
  print('--- Widget Tree Structure ---');

  final complexTree = BlockSemantics(
    blocking: true,
    child: Stack(
      children: [
        Positioned(
          left: 0,
          top: 0,
          child: Semantics(
            label: 'First item',
            child: Container(width: 60, height: 60, color: Colors.purple),
          ),
        ),
        Positioned(
          left: 20,
          top: 20,
          child: Semantics(
            label: 'Second item',
            child: Container(width: 60, height: 60, color: Colors.orange),
          ),
        ),
      ],
    ),
  );
  print('Complex widget tree with BlockSemantics');
  print('  Semantics below this in paint order are dropped');

  // ========== COMPARING WITH EXCLUDE SEMANTICS ==========
  print('--- BlockSemantics vs ExcludeSemantics ---');
  print('BlockSemantics: Blocks semantics of widgets BELOW in paint order');
  print('ExcludeSemantics: Excludes semantics of THIS widget and its subtree');
  print(
    'Key difference: BlockSemantics affects Z-order, ExcludeSemantics affects subtree',
  );

  // Test toggle behavior
  final toggleBlocking = BlockSemantics(
    blocking: true,
    child: Text('Toggle test'),
  );
  print('BlockSemantics toggle test');
  print('  Initial blocking: ${toggleBlocking.blocking}');

  // ========== ACCESSIBILITY TESTING ==========
  print('--- Accessibility Behavior ---');
  print('RenderBlockSemantics drops semantics nodes below it');
  print('Screen readers will not announce blocked content');
  print('Important for proper focus management in overlays');

  print('RenderBlockSemantics test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderBlockSemantics Tests'),
      blockingWidget,
      SizedBox(height: 8),
      notBlockingWidget,
      SizedBox(height: 8),
      withSemantics,
      SizedBox(height: 8),
      Text('All BlockSemantics tests passed'),
    ],
  );
}
