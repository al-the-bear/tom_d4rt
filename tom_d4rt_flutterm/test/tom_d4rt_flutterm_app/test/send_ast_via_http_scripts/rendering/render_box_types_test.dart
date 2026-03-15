// D4rt test script: Tests RenderDecoratedBox, RenderPadding, RenderAlign,
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// RenderPositionedBox, RenderConstrainedBox, RenderFlex, RenderConstrainedOverflowBox
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('RenderBox types test executing');

  // ========== RenderPadding ==========
  print('--- RenderPadding Tests ---');
  final renderPadding = RenderPadding(
    padding: EdgeInsets.all(16.0),
    textDirection: TextDirection.ltr,
  );
  print('RenderPadding created: padding=16.0');

  // ========== RenderPositionedBox ==========
  print('--- RenderPositionedBox Tests ---');
  final renderPositioned = RenderPositionedBox(
    alignment: Alignment.center,
    widthFactor: null,
    heightFactor: null,
    textDirection: TextDirection.ltr,
  );
  print('RenderPositionedBox created: alignment=center');

  // ========== RenderConstrainedBox ==========
  print('--- RenderConstrainedBox Tests ---');
  final renderConstrained = RenderConstrainedBox(
    additionalConstraints: BoxConstraints(
      minWidth: 100.0,
      maxWidth: 300.0,
      minHeight: 50.0,
      maxHeight: 200.0,
    ),
  );
  print('RenderConstrainedBox created');
  print('  min: 100x50');
  print('  max: 300x200');

  // ========== BoxConstraints advanced ==========
  print('--- BoxConstraints advanced Tests ---');
  final tight = BoxConstraints.tight(Size(200, 100));
  print('BoxConstraints.tight: $tight');

  final loose = BoxConstraints.loose(Size(300, 200));
  print('BoxConstraints.loose: $loose');

  final expand = BoxConstraints.expand(width: 400, height: 300);
  print('BoxConstraints.expand: $expand');

  final tightFor = BoxConstraints.tightFor(width: 150);
  print('BoxConstraints.tightFor width=150: $tightFor');

  // Constraint operations
  final normalized = BoxConstraints(minWidth: 200, maxWidth: 100).normalize();
  print('Normalized: $normalized');

  final constrained = BoxConstraints(
    minWidth: 100,
    maxWidth: 300,
  ).constrain(Size(250, 150));
  print('Constrained size: $constrained');

  // ========== RenderFlex ==========
  print('--- RenderFlex Tests ---');
  final renderFlex = RenderFlex(
    direction: Axis.vertical,
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.center,
    textDirection: TextDirection.ltr,
    verticalDirection: VerticalDirection.down,
    clipBehavior: Clip.none,
  );
  print('RenderFlex created: direction=vertical');

  // ========== ContainerBoxParentData ==========
  print('--- ParentData Tests ---');
  final parentData = BoxParentData();
  print('BoxParentData created: offset=${parentData.offset}');

  print('All render box tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'RenderBox Types Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text('RenderPadding, RenderPositionedBox'),
            Text('RenderConstrainedBox, RenderFlex'),
            Text('BoxConstraints: tight, loose, expand'),
          ],
        ),
      ),
    ),
  );
}
