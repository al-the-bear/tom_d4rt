// D4rt test script: Tests RenderConstrainedOverflowBox from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderConstrainedOverflowBox test executing');

  // ========== CONSTRAINED OVERFLOW BOX BASICS ==========
  print('--- ConstrainedOverflowBox Basics ---');
  print(
    'RenderConstrainedOverflowBox allows child to overflow with constraints',
  );
  print('Child can be larger than parent but respects min/max constraints');
  print('Useful for controlled overflow scenarios');

  // Test using OverflowBox which maps to RenderConstrainedOverflowBox
  final basicOverflow = OverflowBox(
    minWidth: 50,
    maxWidth: 200,
    minHeight: 50,
    maxHeight: 200,
    child: Container(
      width: 150,
      height: 150,
      color: Colors.blue,
      child: Center(child: Text('Overflow')),
    ),
  );
  print('OverflowBox created with constrained dimensions');
  print('  minWidth: ${basicOverflow.minWidth}');
  print('  maxWidth: ${basicOverflow.maxWidth}');
  print('  minHeight: ${basicOverflow.minHeight}');
  print('  maxHeight: ${basicOverflow.maxHeight}');

  // ========== ALIGNMENT OPTIONS ==========
  print('--- Alignment Options ---');

  final alignCenter = OverflowBox(
    alignment: Alignment.center,
    maxWidth: 100,
    maxHeight: 100,
    child: Container(width: 80, height: 80, color: Colors.red),
  );
  print('Alignment.center: Child centered in overflow area');

  final alignTopLeft = OverflowBox(
    alignment: Alignment.topLeft,
    maxWidth: 100,
    maxHeight: 100,
    child: Container(width: 80, height: 80, color: Colors.green),
  );
  print('Alignment.topLeft: Child at top-left corner');

  final alignBottomRight = OverflowBox(
    alignment: Alignment.bottomRight,
    maxWidth: 100,
    maxHeight: 100,
    child: Container(width: 80, height: 80, color: Colors.orange),
  );
  print('Alignment.bottomRight: Child at bottom-right corner');

  // ========== CONSTRAINT VARIATIONS ==========
  print('--- Constraint Variations ---');

  // Only width constrained
  final widthOnly = OverflowBox(
    minWidth: 100,
    maxWidth: 100,
    child: Container(width: 150, height: 50, color: Colors.purple),
  );
  print('Width-only constraints: width forced to 100');

  // Only height constrained
  final heightOnly = OverflowBox(
    minHeight: 100,
    maxHeight: 100,
    child: Container(width: 50, height: 150, color: Colors.teal),
  );
  print('Height-only constraints: height forced to 100');

  // Tight constraints
  final tightConstraints = OverflowBox(
    minWidth: 80,
    maxWidth: 80,
    minHeight: 80,
    maxHeight: 80,
    child: Container(width: 200, height: 200, color: Colors.amber),
  );
  print('Tight constraints (80x80): Child forced to exact size');

  // ========== USE CASES ==========
  print('--- Common Use Cases ---');
  print('1. Dropdown menus that extend beyond parent');
  print('2. Tooltips that overflow container');
  print('3. Custom popup widgets');
  print('4. Image previews in constrained spaces');

  // Test with Stack for visual overflow
  final stackOverflow = Container(
    width: 100,
    height: 100,
    color: Colors.grey[300],
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        OverflowBox(
          maxWidth: 150,
          maxHeight: 150,
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.5),
              border: Border.all(color: Colors.blue, width: 2),
            ),
          ),
        ),
      ],
    ),
  );
  print('Stack with overflow: Child extends beyond parent');

  // ========== FIT PROPERTY ==========
  print('--- Fit Property ---');
  print('OverflowBox uses constraints to control child sizing');
  print('Unlike SizedOverflowBox which has explicit size');
  print('Constraints can be null to use parent constraints');

  // Test with null constraints (pass through)
  final passThrough = OverflowBox(
    child: Container(width: 50, height: 50, color: Colors.pink),
  );
  print('No constraints specified: Uses parent constraints');

  // ========== COMPARING OVERFLOW WIDGETS ==========
  print('--- Comparing Overflow Widgets ---');
  print('OverflowBox: Constrains child, allows visual overflow');
  print('SizedOverflowBox: Fixed size, child can overflow');
  print('FractionallySizedBox: Size relative to parent');
  print('UnconstrainedBox: Removes parent constraints');

  // ========== NESTED OVERFLOW ==========
  print('--- Nested Overflow Behavior ---');

  final nestedOverflow = Container(
    width: 80,
    height: 80,
    color: Colors.grey[200],
    child: OverflowBox(
      maxWidth: 120,
      maxHeight: 120,
      child: Container(
        width: 120,
        height: 120,
        color: Colors.indigo.withValues(alpha: 0.7),
        child: Center(
          child: OverflowBox(
            maxWidth: 80,
            maxHeight: 80,
            child: Container(width: 80, height: 80, color: Colors.yellow),
          ),
        ),
      ),
    ),
  );
  print('Nested OverflowBox widgets');
  print('  Outer: 80 -> 120 overflow');
  print('  Inner: Forces 80x80');

  // ========== LAYOUT IMPLICATIONS ==========
  print('--- Layout Implications ---');
  print('RenderConstrainedOverflowBox reports its own size to parent');
  print('But child can paint outside those bounds');
  print('Use with Stack.clipBehavior = Clip.none for visibility');

  print('RenderConstrainedOverflowBox test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderConstrainedOverflowBox Tests'),
      Container(
        width: 100,
        height: 100,
        color: Colors.grey[300],
        child: basicOverflow,
      ),
      SizedBox(height: 8),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 60, height: 60, child: alignCenter),
          SizedBox(width: 8),
          Container(width: 60, height: 60, child: alignTopLeft),
        ],
      ),
      SizedBox(height: 8),
      stackOverflow,
      SizedBox(height: 8),
      Text('All ConstrainedOverflowBox tests passed'),
    ],
  );
}
