// D4rt test script: Tests Border, BorderSide from painting
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Painting border test executing');

  // ========== BORDERSIDE ==========
  print('--- BorderSide Tests ---');

  // Test BorderSide constructor
  final basicSide = BorderSide(
    color: Color(0xFF2196F3),
    width: 2.0,
    style: BorderStyle.solid,
  );
  print('BorderSide with color, width, style: $basicSide');
  print('  color: ${basicSide.color}');
  print('  width: ${basicSide.width}');
  print('  style: ${basicSide.style}');

  // Test BorderSide.none
  final noneSide = BorderSide.none;
  print('BorderSide.none: $noneSide');
  print('  style: ${noneSide.style}');

  // Test BorderSide with default values
  final defaultSide = BorderSide();
  print('BorderSide() default: $defaultSide');

  // Test BorderSide with only color
  final colorSide = BorderSide(color: Color(0xFFE53935));
  print('BorderSide(color: red): $colorSide');

  // Test BorderSide with only width
  final widthSide = BorderSide(width: 4.0);
  print('BorderSide(width: 4.0): $widthSide');

  // Test BorderSide with strokeAlign
  final insideSide = BorderSide(
    width: 2.0,
    strokeAlign: BorderSide.strokeAlignInside,
  );
  print('BorderSide with strokeAlignInside: $insideSide');

  final outsideSide = BorderSide(
    width: 2.0,
    strokeAlign: BorderSide.strokeAlignOutside,
  );
  print('BorderSide with strokeAlignOutside: $outsideSide');

  final centerSide = BorderSide(
    width: 2.0,
    strokeAlign: BorderSide.strokeAlignCenter,
  );
  print('BorderSide with strokeAlignCenter: $centerSide');

  // Test BorderSide copyWith
  final copiedSide = basicSide.copyWith(width: 5.0);
  print('BorderSide copyWith(width: 5.0): $copiedSide');

  final copiedColorSide = basicSide.copyWith(color: Color(0xFF4CAF50));
  print('BorderSide copyWith(color: green): $copiedColorSide');

  // Test BorderSide scale
  final scaledSide = basicSide.scale(2.0);
  print('BorderSide scale(2.0): $scaledSide');

  // Test BorderSide toPaint
  final paint = basicSide.toPaint();
  print(
    'BorderSide toPaint: color=${paint.color}, strokeWidth=${paint.strokeWidth}',
  );

  // Test BorderSide.merge (same color, different widths)
  final mergedSide = BorderSide.merge(basicSide, basicSide.copyWith(width: 3.0));
  print('BorderSide.merge: $mergedSide');

  // Test BorderSide.canMerge
  final canMerge = BorderSide.canMerge(
    basicSide,
    basicSide.copyWith(width: 3.0),
  );
  print('BorderSide.canMerge (same color different width): $canMerge');

  // Test BorderSide.lerp
  final lerpedSide = BorderSide.lerp(
    BorderSide(color: Color(0xFF2196F3), width: 1.0),
    BorderSide(color: Color(0xFFE53935), width: 5.0),
    0.5,
  );
  print('BorderSide.lerp at 0.5: $lerpedSide');

  // ========== BORDER ==========
  print('--- Border Tests ---');

  // Test Border.all
  final allBorder = Border.all(
    color: Color(0xFF2196F3),
    width: 2.0,
    style: BorderStyle.solid,
  );
  print('Border.all: $allBorder');

  // Test Border.all with defaults
  final defaultAllBorder = Border.all();
  print('Border.all() default: $defaultAllBorder');

  // Test Border constructor
  final customBorder = Border(
    top: BorderSide(color: Color(0xFFE53935), width: 2.0),
    right: BorderSide(color: Color(0xFF4CAF50), width: 3.0),
    bottom: BorderSide(color: Color(0xFF2196F3), width: 4.0),
    left: BorderSide(color: Color(0xFFFF9800), width: 5.0),
  );
  print('Border with different sides: $customBorder');

  // Test Border.symmetric
  final symmetricBorder = Border.symmetric(
    horizontal: BorderSide(color: Color(0xFF2196F3), width: 2.0),
    vertical: BorderSide(color: Color(0xFFE53935), width: 3.0),
  );
  print('Border.symmetric: $symmetricBorder');

  // Test Border.fromBorderSide
  final fromSideBorder = Border.fromBorderSide(basicSide);
  print('Border.fromBorderSide: $fromSideBorder');

  // Test Border properties
  print('Border.top: ${customBorder.top}');
  print('Border.right: ${customBorder.right}');
  print('Border.bottom: ${customBorder.bottom}');
  print('Border.left: ${customBorder.left}');
  print('Border.dimensions: ${customBorder.dimensions}');
  print('Border.isUniform: ${customBorder.isUniform}');
  print('Border.all isUniform: ${allBorder.isUniform}');

  // Test Border.scale
  final scaledBorder = allBorder.scale(2.0);
  print('Border.scale(2.0): $scaledBorder');

  // Test Border.add
  final addedBorder = allBorder.add(Border.all(width: 1.0));
  print('Border.add: $addedBorder');

  // Test Border.lerp
  final lerpedBorder = Border.lerp(
    Border.all(color: Color(0xFF2196F3), width: 1.0),
    Border.all(color: Color(0xFFE53935), width: 5.0),
    0.5,
  );
  print('Border.lerp at 0.5: $lerpedBorder');

  // Test Border with no sides
  final noBorder = Border();
  print('Border() empty: $noBorder');

  // Test Border with only some sides
  final topOnlyBorder = Border(
    top: BorderSide(color: Color(0xFF2196F3), width: 2.0),
  );
  print('Border with only top: $topOnlyBorder');

  final topBottomBorder = Border(
    top: BorderSide(color: Color(0xFF2196F3), width: 2.0),
    bottom: BorderSide(color: Color(0xFF2196F3), width: 2.0),
  );
  print('Border with top and bottom: $topBottomBorder');

  // Test Border.merge
  final mergedBorder = Border.merge(
    Border(top: BorderSide(width: 1.0)),
    Border(bottom: BorderSide(width: 1.0)),
  );
  print('Border.merge: $mergedBorder');

  print('Painting border test completed');

  // Return a visual representation
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Border Tests',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            // Border.all example
            Text(
              'Border.all(color: blue, width: 2):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF2196F3), width: 2.0),
              ),
              child: Center(child: Text('All')),
            ),
            SizedBox(height: 16.0),

            // Different sides example
            Text(
              'Border with different sides:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFFE53935), width: 3.0),
                  right: BorderSide(color: Color(0xFF4CAF50), width: 3.0),
                  bottom: BorderSide(color: Color(0xFF2196F3), width: 3.0),
                  left: BorderSide(color: Color(0xFFFF9800), width: 3.0),
                ),
              ),
              child: Center(child: Text('TRLB')),
            ),
            SizedBox(height: 16.0),

            // Top only border
            Text(
              'Border (top only):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFF9C27B0), width: 4.0),
                ),
              ),
              child: Center(child: Text('Top')),
            ),
            SizedBox(height: 16.0),

            // Bottom divider style
            Text(
              'Border as divider:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Container(
              width: 200.0,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFBDBDBD), width: 1.0),
                ),
              ),
              child: Text('Item with bottom border'),
            ),
            SizedBox(height: 16.0),

            // Thick border
            Text(
              'BorderSide widths:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF2196F3), width: 1.0),
                  ),
                  child: Center(
                    child: Text('1px', style: TextStyle(fontSize: 10.0)),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF2196F3), width: 2.0),
                  ),
                  child: Center(
                    child: Text('2px', style: TextStyle(fontSize: 10.0)),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF2196F3), width: 4.0),
                  ),
                  child: Center(
                    child: Text('4px', style: TextStyle(fontSize: 10.0)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
