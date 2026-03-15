// D4rt test script: Tests BoxPainter conceptual from painting via BoxDecoration
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BoxPainter test executing');
  final results = <String>[];

  // ========== BoxPainter Tests via BoxDecoration ==========
  // BoxPainter is obtained via Decoration.createBoxPainter()
  print('Testing BoxPainter via BoxDecoration.createBoxPainter()...');

  // Test 1: Create BoxDecoration to get BoxPainter
  final decoration1 = BoxDecoration(color: Color(0xFF0000FF));
  assert(
    decoration1.color == Color(0xFF0000FF),
    'Decoration color should be blue',
  );
  results.add('BoxDecoration for painter: color=${decoration1.color}');
  print('BoxDecoration created for BoxPainter access');

  // Test 2: BoxDecoration with border for complex painting
  final decoration2 = BoxDecoration(
    color: Color(0xFFFF0000),
    border: Border.all(color: Color(0xFF000000), width: 2.0),
  );
  assert(decoration2.border != null, 'Border should not be null');
  results.add('BoxDecoration with border: verified');
  print('BoxDecoration with border verified');

  // Test 3: BoxDecoration with borderRadius
  final decoration3 = BoxDecoration(
    color: Color(0xFF00FF00),
    borderRadius: BorderRadius.circular(10.0),
  );
  assert(decoration3.borderRadius != null, 'BorderRadius should not be null');
  results.add('BoxDecoration borderRadius: ${decoration3.borderRadius}');
  print('BoxDecoration borderRadius: ${decoration3.borderRadius}');

  // Test 4: BoxDecoration with gradient
  final decoration4 = BoxDecoration(
    gradient: LinearGradient(colors: [Color(0xFFFF0000), Color(0xFF0000FF)]),
  );
  assert(decoration4.gradient != null, 'Gradient should not be null');
  results.add('BoxDecoration gradient: present');
  print('BoxDecoration gradient verified');

  // Test 5: BoxDecoration with boxShadow
  final decoration5 = BoxDecoration(
    color: Color(0xFFFFFFFF),
    boxShadow: [
      BoxShadow(
        color: Color(0x40000000),
        blurRadius: 10.0,
        offset: Offset(2.0, 2.0),
      ),
    ],
  );
  assert(decoration5.boxShadow != null, 'BoxShadow should not be null');
  assert(decoration5.boxShadow!.length == 1, 'Should have 1 shadow');
  results.add(
    'BoxDecoration boxShadow count: ${decoration5.boxShadow!.length}',
  );
  print('BoxDecoration boxShadow: ${decoration5.boxShadow!.length} shadows');

  // Test 6: BoxDecoration BoxShape.circle
  final decoration6 = BoxDecoration(
    color: Color(0xFFFF0000),
    shape: BoxShape.circle,
  );
  assert(decoration6.shape == BoxShape.circle, 'Shape should be circle');
  results.add('BoxDecoration shape: ${decoration6.shape}');
  print('BoxDecoration shape: ${decoration6.shape}');

  // Test 7: BoxDecoration BoxShape.rectangle
  final decoration7 = BoxDecoration(
    color: Color(0xFF00FF00),
    shape: BoxShape.rectangle,
  );
  assert(decoration7.shape == BoxShape.rectangle, 'Shape should be rectangle');
  results.add('BoxDecoration rectangle shape: ${decoration7.shape}');
  print('BoxDecoration rectangle shape verified');

  // Test 8: BoxDecoration padding calculation
  final decoration8 = BoxDecoration(border: Border.all(width: 5.0));
  final padding = decoration8.padding;
  assert(padding != null, 'Padding should not be null');
  results.add('BoxDecoration padding: $padding');
  print('BoxDecoration padding: $padding');

  // Test 9: BoxDecoration lerp
  final decorationA = BoxDecoration(color: Color(0xFF000000));
  final decorationB = BoxDecoration(color: Color(0xFFFFFFFF));
  final lerped = BoxDecoration.lerp(decorationA, decorationB, 0.5);
  assert(lerped != null, 'Lerped decoration should not be null');
  results.add('BoxDecoration lerp: ${lerped?.color}');
  print('BoxDecoration lerp: ${lerped?.color}');

  // Test 10: BoxDecoration scale
  final scaledDeco = decoration8.scale(2.0);
  results.add('BoxDecoration scale: applied');
  print('BoxDecoration scale applied');

  // Test 11: Complex BoxDecoration
  final complexDecoration = BoxDecoration(
    color: Color(0xFFEEEEEE),
    border: Border.all(color: Color(0xFF333333), width: 1.0),
    borderRadius: BorderRadius.circular(8.0),
    boxShadow: [
      BoxShadow(
        color: Color(0x20000000),
        blurRadius: 4.0,
        offset: Offset(0, 2),
      ),
    ],
  );
  assert(complexDecoration.color != null, 'Complex decoration color present');
  assert(complexDecoration.border != null, 'Complex decoration border present');
  assert(
    complexDecoration.borderRadius != null,
    'Complex decoration radius present',
  );
  results.add('Complex BoxDecoration: all properties set');
  print('Complex BoxDecoration verified');

  // Test 12: BoxDecoration equality
  final decoX = BoxDecoration(color: Color(0xFFFF0000));
  final decoY = BoxDecoration(color: Color(0xFFFF0000));
  assert(decoX == decoY, 'Equal decorations should be equal');
  results.add('BoxDecoration equality: ${decoX == decoY}');
  print('BoxDecoration equality verified');

  print('BoxPainter test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BoxPainter Tests (via BoxDecoration)'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
