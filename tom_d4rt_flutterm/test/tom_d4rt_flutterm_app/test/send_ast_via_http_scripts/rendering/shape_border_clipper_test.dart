// D4rt test script: Tests ShapeBorderClipper from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ShapeBorderClipper test executing');
  final results = <String>[];

  // ========== Section 1: Basic ShapeBorderClipper Creation ==========
  print('--- Section 1: Basic ShapeBorderClipper Creation ---');

  final roundedRect = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  );

  final clipper = ShapeBorderClipper(shape: roundedRect);

  print('Created ShapeBorderClipper: ${clipper.runtimeType}');
  print('Shape: ${clipper.shape}');
  results.add('ShapeBorderClipper created');

  // ========== Section 2: Different Shapes ==========
  print('--- Section 2: Different Shapes ---');

  // Circle
  final circleClipper = ShapeBorderClipper(shape: CircleBorder());
  print('Circle clipper shape: ${circleClipper.shape}');
  results.add('CircleBorder clipper');

  // Stadium (pill shape)
  final stadiumClipper = ShapeBorderClipper(shape: StadiumBorder());
  print('Stadium clipper shape: ${stadiumClipper.shape}');
  results.add('StadiumBorder clipper');

  // Beveled rectangle
  final beveledClipper = ShapeBorderClipper(
    shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(15)),
  );
  print('Beveled clipper shape: ${beveledClipper.shape}');
  results.add('BeveledRectangleBorder clipper');

  // Continuous rectangle
  final continuousClipper = ShapeBorderClipper(
    shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20)),
  );
  print('Continuous clipper shape: ${continuousClipper.shape}');
  results.add('ContinuousRectangleBorder clipper');

  // ========== Section 3: Get Clip Path ==========
  print('--- Section 3: Get Clip Path ---');

  final size = Size(200, 100);
  final clip = clipper.getClip(size);

  print('Got clip for size $size');
  print('Clip path bounds: ${clip.getBounds()}');
  print('Clip path fillType: ${clip.fillType}');
  results.add('getClip returned path');

  // ========== Section 4: Different Sizes ==========
  print('--- Section 4: Different Sizes ---');

  final sizes = [Size(50, 50), Size(100, 200), Size(300, 150), Size(10, 10)];

  for (final s in sizes) {
    final path = clipper.getClip(s);
    print('Size $s -> bounds: ${path.getBounds()}');
  }
  results.add('Tested ${sizes.length} different sizes');

  // ========== Section 5: Circle Clipper Details ==========
  print('--- Section 5: Circle Clipper Details ---');

  final circleSize = Size(100, 100);
  final circlePath = circleClipper.getClip(circleSize);
  print('Circle path bounds: ${circlePath.getBounds()}');

  // Test with non-square size
  final ovalSize = Size(200, 100);
  final ovalPath = circleClipper.getClip(ovalSize);
  print('Oval path bounds: ${ovalPath.getBounds()}');
  results.add('Circle/Oval paths tested');

  // ========== Section 6: Stadium Clipper Details ==========
  print('--- Section 6: Stadium Clipper Details ---');

  final stadiumPath1 = stadiumClipper.getClip(Size(200, 50));
  print('Wide stadium bounds: ${stadiumPath1.getBounds()}');

  final stadiumPath2 = stadiumClipper.getClip(Size(50, 200));
  print('Tall stadium bounds: ${stadiumPath2.getBounds()}');
  results.add('Stadium paths tested');

  // ========== Section 7: With TextDirection ==========
  print('--- Section 7: With TextDirection ---');

  final ltrClipper = ShapeBorderClipper(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.only(
        topStart: Radius.circular(20),
        bottomEnd: Radius.circular(20),
      ),
    ),
    textDirection: TextDirection.ltr,
  );
  print('LTR clipper textDirection: ${ltrClipper.textDirection}');

  final rtlClipper = ShapeBorderClipper(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.only(
        topStart: Radius.circular(20),
        bottomEnd: Radius.circular(20),
      ),
    ),
    textDirection: TextDirection.rtl,
  );
  print('RTL clipper textDirection: ${rtlClipper.textDirection}');
  results.add('TextDirection LTR and RTL tested');

  // ========== Section 8: CustomClipper Interface ==========
  print('--- Section 8: CustomClipper Interface ---');

  print(
    'ShapeBorderClipper is CustomClipper<Path>: ${clipper is CustomClipper<Path>}',
  );
  print('Clipper runtimeType: ${clipper.runtimeType}');
  results.add('CustomClipper<Path> interface verified');

  // ========== Section 9: Should Reclip ==========
  print('--- Section 9: Should Reclip ---');

  final sameShapeClipper = ShapeBorderClipper(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );

  final differentShapeClipper = ShapeBorderClipper(shape: CircleBorder());

  final shouldReclipSame = clipper.shouldReclip(sameShapeClipper);
  final shouldReclipDifferent = clipper.shouldReclip(differentShapeClipper);

  print('Should reclip same shape: $shouldReclipSame');
  print('Should reclip different shape: $shouldReclipDifferent');
  results.add('shouldReclip tested');

  // ========== Section 10: Semantic Bounds ==========
  print('--- Section 10: Semantic Bounds ---');

  final semanticSize = Size(150, 100);
  final semanticBounds = clipper.getApproximateClipRect(semanticSize);
  print('Approximate clip rect for $semanticSize: $semanticBounds');
  results.add('getApproximateClipRect tested');

  print('ShapeBorderClipper test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'ShapeBorderClipper Tests',
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
