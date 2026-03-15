// D4rt test script: Tests Constraints from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Constraints test executing');
  final results = <String>[];

  // ========== Section 1: BoxConstraints Creation ==========
  print('--- Section 1: BoxConstraints Creation ---');

  // BoxConstraints is the most common Constraints subclass
  final basic = BoxConstraints();
  print('Default BoxConstraints: $basic');
  print('isTight: ${basic.isTight}');
  print('isNormalized: ${basic.isNormalized}');
  results.add(
    'Default constraints: minW=${basic.minWidth}, maxW=${basic.maxWidth}',
  );

  // ========== Section 2: Tight Constraints ==========
  print('--- Section 2: Tight Constraints ---');

  final tight = BoxConstraints.tight(Size(100, 50));
  print('Tight constraints: $tight');
  print('isTight: ${tight.isTight}');
  print('biggest: ${tight.biggest}');
  print('smallest: ${tight.smallest}');
  results.add('Tight: isTight=${tight.isTight}, size=${tight.biggest}');

  // ========== Section 3: Loose Constraints ==========
  print('--- Section 3: Loose Constraints ---');

  final loose = BoxConstraints.loose(Size(200, 150));
  print('Loose constraints: $loose');
  print('isTight: ${loose.isTight}');
  print('hasBoundedWidth: ${loose.hasBoundedWidth}');
  print('hasBoundedHeight: ${loose.hasBoundedHeight}');
  results.add(
    'Loose: bounded=${loose.hasBoundedWidth && loose.hasBoundedHeight}',
  );

  // ========== Section 4: Expand Constraints ==========
  print('--- Section 4: Expand Constraints ---');

  final expand = BoxConstraints.expand(width: 300, height: 200);
  print('Expand constraints: $expand');
  print('isTight: ${expand.isTight}');
  print('constrainWidth(400): ${expand.constrainWidth(400)}');
  print('constrainHeight(300): ${expand.constrainHeight(300)}');
  results.add('Expand: isTight=${expand.isTight}');

  // ========== Section 5: Min/Max Constraints ==========
  print('--- Section 5: Min/Max Constraints ---');

  final minMax = BoxConstraints(
    minWidth: 50,
    maxWidth: 150,
    minHeight: 40,
    maxHeight: 120,
  );
  print('Min/Max constraints: $minMax');
  print('constrainWidth(30): ${minMax.constrainWidth(30)}'); // Should be 50
  print('constrainWidth(200): ${minMax.constrainWidth(200)}'); // Should be 150
  print('constrainHeight(20): ${minMax.constrainHeight(20)}'); // Should be 40
  results.add(
    'Constrain 30→${minMax.constrainWidth(30)}, 200→${minMax.constrainWidth(200)}',
  );

  // ========== Section 6: Constrain Methods ==========
  print('--- Section 6: Constrain Methods ---');

  final constrainer = BoxConstraints(
    minWidth: 100,
    maxWidth: 300,
    minHeight: 80,
    maxHeight: 200,
  );

  // Test constrain method
  final size1 = constrainer.constrain(Size(50, 50));
  final size2 = constrainer.constrain(Size(500, 500));
  final size3 = constrainer.constrain(Size(200, 150));

  print('constrain(50x50): $size1');
  print('constrain(500x500): $size2');
  print('constrain(200x150): $size3');
  results.add('Constrain: 50x50→$size1, 500x500→$size2');

  // ========== Section 7: Normalized and Satisfied ==========
  print('--- Section 7: Normalized Constraints ---');

  // Test normalize
  final unnormalized = BoxConstraints(
    minWidth: 200,
    maxWidth: 100, // min > max (invalid)
    minHeight: 150,
    maxHeight: 80, // min > max (invalid)
  );
  print('Unnormalized: $unnormalized');
  print('isNormalized: ${unnormalized.isNormalized}');

  final normalized = unnormalized.normalize();
  print('After normalize: $normalized');
  print('isNormalized after: ${normalized.isNormalized}');
  results.add(
    'Normalize: before=${unnormalized.isNormalized}, after=${normalized.isNormalized}',
  );

  // ========== Section 8: Width/Height Specific ==========
  print('--- Section 8: Width/Height Specific ---');

  final widthOnly = BoxConstraints.tightFor(width: 100);
  final heightOnly = BoxConstraints.tightFor(height: 80);

  print('Width only: $widthOnly');
  print('Height only: $heightOnly');
  print('widthOnly.hasTightWidth: ${widthOnly.hasTightWidth}');
  print('heightOnly.hasTightHeight: ${heightOnly.hasTightHeight}');
  results.add(
    'TightFor: width=${widthOnly.hasTightWidth}, height=${heightOnly.hasTightHeight}',
  );

  // ========== Section 9: Infinite Constraints ==========
  print('--- Section 9: Infinite Constraints ---');

  final infinite = BoxConstraints(
    maxWidth: double.infinity,
    maxHeight: double.infinity,
  );
  print('Infinite constraints: $infinite');
  print('hasBoundedWidth: ${infinite.hasBoundedWidth}');
  print('hasBoundedHeight: ${infinite.hasBoundedHeight}');
  print('hasInfiniteWidth: ${infinite.hasInfiniteWidth}');
  print('hasInfiniteHeight: ${infinite.hasInfiniteHeight}');
  results.add(
    'Infinite: unboundedW=${!infinite.hasBoundedWidth}, unboundedH=${!infinite.hasBoundedHeight}',
  );

  // ========== Section 10: Deflate/Enforce ==========
  print('--- Section 10: Deflate/Enforce ---');

  final original = BoxConstraints.tight(Size(200, 150));
  final deflated = original.deflate(EdgeInsets.all(20));

  print('Original: $original');
  print('Deflated by 20: $deflated');
  print('Deflated biggest: ${deflated.biggest}');
  results.add('Deflate: ${original.biggest}→${deflated.biggest}');

  // Enforce
  final enforced = original.enforce(BoxConstraints(maxWidth: 100));
  print('Enforced maxWidth=100: $enforced');
  results.add('Enforce: ${enforced.maxWidth}');

  print('Constraints test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Constraints Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ...results.map(
            (r) => Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text('✓ $r', style: TextStyle(fontSize: 14)),
            ),
          ),
        ],
      ),
    ),
  );
}
