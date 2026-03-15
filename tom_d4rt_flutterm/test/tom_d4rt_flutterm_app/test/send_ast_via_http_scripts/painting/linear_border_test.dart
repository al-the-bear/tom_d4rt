// D4rt test script: Tests LinearBorder from painting
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('LinearBorder test executing');
  final results = <String>[];

  // ========== LinearBorder Tests ==========
  print('Testing LinearBorder...');

  // Test 1: Default LinearBorder
  final border1 = LinearBorder();
  assert(border1.side == BorderSide.none, 'Default side should be none');
  results.add('LinearBorder default: side=${border1.side}');
  print('LinearBorder default created');

  // Test 2: LinearBorder with side
  final border2 = LinearBorder(
    side: BorderSide(color: Color(0xFF000000), width: 2.0),
  );
  assert(border2.side.width == 2.0, 'Side width should be 2.0');
  results.add('LinearBorder side width: ${border2.side.width}');
  print('LinearBorder with side: width=${border2.side.width}');

  // Test 3: LinearBorder.top constructor
  final border3 = LinearBorder.top(
    side: BorderSide(color: Color(0xFFFF0000), width: 1.0),
  );
  results.add('LinearBorder.top: created');
  print('LinearBorder.top created');

  // Test 4: LinearBorder.bottom constructor
  final border4 = LinearBorder.bottom(
    side: BorderSide(color: Color(0xFF00FF00), width: 1.5),
  );
  results.add('LinearBorder.bottom: created');
  print('LinearBorder.bottom created');

  // Test 5: LinearBorder.start constructor
  final border5 = LinearBorder.start(
    side: BorderSide(color: Color(0xFF0000FF), width: 2.0),
  );
  results.add('LinearBorder.start: created');
  print('LinearBorder.start created');

  // Test 6: LinearBorder.end constructor
  final border6 = LinearBorder.end(
    side: BorderSide(color: Color(0xFFFFFF00), width: 2.5),
  );
  results.add('LinearBorder.end: created');
  print('LinearBorder.end created');

  // Test 7: LinearBorder with LinearBorderEdge
  final edgeStart = LinearBorderEdge(size: 0.5, alignment: 0.0);
  final edgeEnd = LinearBorderEdge(size: 0.5, alignment: 1.0);
  final border7 = LinearBorder(
    side: BorderSide(width: 1.0),
    start: edgeStart,
    end: edgeEnd,
  );
  assert(border7.start?.size == 0.5, 'Start edge size should be 0.5');
  results.add('LinearBorder edges: start size=${border7.start?.size}');
  print('LinearBorder with edges: start size=${border7.start?.size}');

  // Test 8: LinearBorder scale
  final border8 = LinearBorder(side: BorderSide(width: 2.0));
  final scaled = border8.scale(2.0);
  results.add('LinearBorder scaled: applied');
  print('LinearBorder scale applied');

  // Test 9: LinearBorder lerp
  final borderA = LinearBorder(side: BorderSide(width: 0.0));
  final borderB = LinearBorder(side: BorderSide(width: 4.0));
  final lerped = ShapeBorder.lerp(borderA, borderB, 0.5);
  assert(lerped != null, 'Lerped border should not be null');
  results.add('LinearBorder lerp: computed');
  print('LinearBorder lerp computed');

  // Test 10: LinearBorder getOuterPath
  final rect10 = Rect.fromLTWH(0, 0, 100, 50);
  final outerPath = border1.getOuterPath(rect10);
  final bounds = outerPath.getBounds();
  assert(bounds.width == 100, 'Outer path width should be 100');
  results.add('LinearBorder outerPath: ${bounds.width}x${bounds.height}');
  print('LinearBorder outerPath: $bounds');

  // Test 11: LinearBorder getInnerPath
  final innerPath = border2.getInnerPath(rect10);
  final innerBounds = innerPath.getBounds();
  results.add(
    'LinearBorder innerPath: ${innerBounds.width}x${innerBounds.height}',
  );
  print('LinearBorder innerPath: $innerBounds');

  // Test 12: LinearBorder dimensions
  final dims = border2.dimensions;
  results.add('LinearBorder dimensions: $dims');
  print('LinearBorder dimensions: $dims');

  // Test 13: LinearBorder copyWith
  final border13 = border2.copyWith(
    side: BorderSide(width: 5.0, color: Color(0xFFFF0000)),
  );
  assert(border13.side.width == 5.0, 'Copied side width should be 5.0');
  results.add('LinearBorder copyWith: width=${border13.side.width}');
  print('LinearBorder copyWith verified');

  // Test 14: LinearBorder equality
  final eq1 = LinearBorder(side: BorderSide(width: 1.0));
  final eq2 = LinearBorder(side: BorderSide(width: 1.0));
  assert(eq1 == eq2, 'Equal borders should be equal');
  results.add('LinearBorder equality: ${eq1 == eq2}');
  print('LinearBorder equality verified');

  print('LinearBorder test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('LinearBorder Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
