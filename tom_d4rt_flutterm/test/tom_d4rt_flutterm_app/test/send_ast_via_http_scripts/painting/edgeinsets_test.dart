// D4rt test script: Tests EdgeInsets, EdgeInsetsDirectional, EdgeInsetsGeometry from painting
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Painting edgeinsets test executing');

  // ========== EDGEINSETS ==========
  print('--- EdgeInsets Tests ---');

  // Test EdgeInsets.all
  final allInsets = EdgeInsets.all(16.0);
  print('EdgeInsets.all(16.0): $allInsets');
  print(
    '  left: ${allInsets.left}, top: ${allInsets.top}, right: ${allInsets.right}, bottom: ${allInsets.bottom}',
  );

  // Test EdgeInsets.zero
  final zeroInsets = EdgeInsets.zero;
  print('EdgeInsets.zero: $zeroInsets');

  // Test EdgeInsets.only
  final onlyLeftInsets = EdgeInsets.only(left: 10.0);
  print('EdgeInsets.only(left: 10.0): $onlyLeftInsets');

  final onlyTopInsets = EdgeInsets.only(top: 20.0);
  print('EdgeInsets.only(top: 20.0): $onlyTopInsets');

  final onlyMultiple = EdgeInsets.only(
    left: 10.0,
    top: 20.0,
    right: 30.0,
    bottom: 40.0,
  );
  print('EdgeInsets.only(...): $onlyMultiple');

  // Test EdgeInsets.symmetric
  final symmetricHorizontal = EdgeInsets.symmetric(horizontal: 16.0);
  print('EdgeInsets.symmetric(horizontal: 16.0): $symmetricHorizontal');

  final symmetricVertical = EdgeInsets.symmetric(vertical: 8.0);
  print('EdgeInsets.symmetric(vertical: 8.0): $symmetricVertical');

  final symmetricBoth = EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0);
  print(
    'EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0): $symmetricBoth',
  );

  // Test EdgeInsets.fromLTRB
  final fromLTRB = EdgeInsets.fromLTRB(10.0, 20.0, 30.0, 40.0);
  print('EdgeInsets.fromLTRB(10.0, 20.0, 30.0, 40.0): $fromLTRB');

  // Test EdgeInsets.fromViewPadding (need ViewPadding - skip for now)
  // Test EdgeInsets.lerp
  final startInsets = EdgeInsets.all(0.0);
  final endInsets = EdgeInsets.all(100.0);
  final lerpedInsets = EdgeInsets.lerp(startInsets, endInsets, 0.5);
  print('EdgeInsets.lerp at 0.5: $lerpedInsets');

  // Test EdgeInsets operators
  final addedInsets = allInsets + symmetricBoth;
  print('EdgeInsets addition: $addedInsets');

  final subtractedInsets = endInsets - startInsets;
  print('EdgeInsets subtraction: $subtractedInsets');

  final negatedInsets = -allInsets;
  print('EdgeInsets negation: $negatedInsets');

  final multipliedInsets = allInsets * 2.0;
  print('EdgeInsets multiplication: $multipliedInsets');

  final dividedInsets = allInsets / 2.0;
  print('EdgeInsets division: $dividedInsets');

  final intDividedInsets = allInsets ~/ 2;
  print('EdgeInsets integer division: $intDividedInsets');

  final moduloInsets = allInsets % 10.0;
  print('EdgeInsets modulo: $moduloInsets');

  // Test EdgeInsets properties
  print('isNonNegative: ${allInsets.isNonNegative}');
  print('horizontal: ${symmetricBoth.horizontal}');
  print('vertical: ${symmetricBoth.vertical}');
  print('collapsedSize: ${allInsets.collapsedSize}');
  print('flipped: ${fromLTRB.flipped}');

  // Test EdgeInsets methods
  final inflatedSize = allInsets.inflateSize(Size(100.0, 100.0));
  print('inflateSize(Size(100, 100)): $inflatedSize');

  final deflatedSize = allInsets.deflateSize(Size(100.0, 100.0));
  print('deflateSize(Size(100, 100)): $deflatedSize');

  final inflatedRect = allInsets.inflateRect(
    Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
  );
  print('inflateRect: $inflatedRect');

  final deflatedRect = allInsets.deflateRect(
    Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
  );
  print('deflateRect: $deflatedRect');

  // Test EdgeInsets copyWith
  final copiedInsets = fromLTRB.copyWith(left: 99.0);
  print('copyWith(left: 99.0): $copiedInsets');

  // Test EdgeInsets clamp
  final clampedInsets = fromLTRB.clamp(EdgeInsets.zero, EdgeInsets.all(25.0));
  print('clamp to max 25: $clampedInsets');

  // ========== EDGEINSETSDIRECTIONAL ==========
  print('--- EdgeInsetsDirectional Tests ---');

  // Test EdgeInsetsDirectional.zero
  final dirZero = EdgeInsetsDirectional.zero;
  print('EdgeInsetsDirectional.zero: $dirZero');

  // Test EdgeInsetsDirectional.all
  final dirAll = EdgeInsetsDirectional.all(16.0);
  print('EdgeInsetsDirectional.all(16.0): $dirAll');
  print(
    '  start: ${dirAll.start}, top: ${dirAll.top}, end: ${dirAll.end}, bottom: ${dirAll.bottom}',
  );

  // Test EdgeInsetsDirectional.only
  final dirOnlyStart = EdgeInsetsDirectional.only(start: 10.0);
  print('EdgeInsetsDirectional.only(start: 10.0): $dirOnlyStart');

  final dirOnlyEnd = EdgeInsetsDirectional.only(end: 20.0);
  print('EdgeInsetsDirectional.only(end: 20.0): $dirOnlyEnd');

  final dirOnlyMultiple = EdgeInsetsDirectional.only(
    start: 10.0,
    top: 20.0,
    end: 30.0,
    bottom: 40.0,
  );
  print('EdgeInsetsDirectional.only(...): $dirOnlyMultiple');

  // Test EdgeInsetsDirectional.symmetric
  final dirSymmetricHorizontal = EdgeInsetsDirectional.symmetric(
    horizontal: 16.0,
  );
  print(
    'EdgeInsetsDirectional.symmetric(horizontal: 16.0): $dirSymmetricHorizontal',
  );

  final dirSymmetricVertical = EdgeInsetsDirectional.symmetric(vertical: 8.0);
  print(
    'EdgeInsetsDirectional.symmetric(vertical: 8.0): $dirSymmetricVertical',
  );

  final dirSymmetricBoth = EdgeInsetsDirectional.symmetric(
    horizontal: 20.0,
    vertical: 10.0,
  );
  print('EdgeInsetsDirectional.symmetric(h: 20, v: 10): $dirSymmetricBoth');

  // Test EdgeInsetsDirectional.fromSTEB
  final fromSTEB = EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 30.0, 40.0);
  print('EdgeInsetsDirectional.fromSTEB(10, 20, 30, 40): $fromSTEB');

  // Test EdgeInsetsDirectional operators
  final dirAdded = dirAll + dirSymmetricBoth;
  print('EdgeInsetsDirectional addition: $dirAdded');

  final dirNegated = -dirAll;
  print('EdgeInsetsDirectional negation: $dirNegated');

  final dirMultiplied = dirAll * 2.0;
  print('EdgeInsetsDirectional multiplication: $dirMultiplied');

  final dirDivided = dirAll / 2.0;
  print('EdgeInsetsDirectional division: $dirDivided');

  // Test EdgeInsetsDirectional resolve
  final resolvedLTR = fromSTEB.resolve(TextDirection.ltr);
  print('Resolved LTR: $resolvedLTR');

  final resolvedRTL = fromSTEB.resolve(TextDirection.rtl);
  print('Resolved RTL: $resolvedRTL');

  // Test EdgeInsetsDirectional lerp
  final dirStart = EdgeInsetsDirectional.all(0.0);
  final dirEnd = EdgeInsetsDirectional.all(100.0);
  final dirLerped = EdgeInsetsDirectional.lerp(dirStart, dirEnd, 0.5);
  print('EdgeInsetsDirectional.lerp at 0.5: $dirLerped');

  // ========== EDGEINSETSGEOMETRY ==========
  print('--- EdgeInsetsGeometry Tests ---');

  // EdgeInsetsGeometry is abstract, test via lerp
  final geoStart = EdgeInsets.all(0.0);
  final geoEnd = EdgeInsetsDirectional.all(100.0);
  final geoLerped = EdgeInsetsGeometry.lerp(geoStart, geoEnd, 0.5);
  print(
    'EdgeInsetsGeometry.lerp between EdgeInsets and EdgeInsetsDirectional: $geoLerped',
  );

  // Test add method
  final geoAdded = geoStart.add(EdgeInsets.all(10.0));
  print('EdgeInsetsGeometry.add: $geoAdded');

  // Test subtract (via operator -)
  print('EdgeInsetsGeometry subtract: implemented via operator -');

  print('Painting edgeinsets test completed');

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
              'EdgeInsets Tests',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            // EdgeInsets.all example
            Text(
              'EdgeInsets.all(16):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              color: Color(0xFFE3F2FD),
              child: Container(
                margin: EdgeInsets.all(16.0),
                color: Color(0xFF2196F3),
                width: 50.0,
                height: 50.0,
              ),
            ),
            SizedBox(height: 16.0),

            // EdgeInsets.symmetric example
            Text(
              'EdgeInsets.symmetric(h: 32, v: 8):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              color: Color(0xFFE8F5E9),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
                color: Color(0xFF4CAF50),
                width: 50.0,
                height: 50.0,
              ),
            ),
            SizedBox(height: 16.0),

            // EdgeInsets.only example
            Text(
              'EdgeInsets.only(left: 48):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              color: Color(0xFFFFF3E0),
              child: Container(
                margin: EdgeInsets.only(left: 48.0),
                color: Color(0xFFFF9800),
                width: 50.0,
                height: 50.0,
              ),
            ),
            SizedBox(height: 16.0),

            // EdgeInsets.fromLTRB example
            Text(
              'EdgeInsets.fromLTRB(8, 16, 24, 32):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              color: Color(0xFFF3E5F5),
              child: Container(
                margin: EdgeInsets.fromLTRB(8.0, 16.0, 24.0, 32.0),
                color: Color(0xFF9C27B0),
                width: 50.0,
                height: 50.0,
              ),
            ),
            SizedBox(height: 16.0),

            // RTL example
            Text(
              'EdgeInsetsDirectional (RTL-aware):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                color: Color(0xFFFFEBEE),
                child: Padding(
                  padding: EdgeInsetsDirectional.only(start: 48.0),
                  child: Container(
                    color: Color(0xFFE53935),
                    width: 50.0,
                    height: 50.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
