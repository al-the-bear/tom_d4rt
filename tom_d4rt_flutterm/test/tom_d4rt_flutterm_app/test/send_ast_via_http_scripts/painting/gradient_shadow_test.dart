// D4rt test script: Tests LinearGradient, BoxShadow from painting
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Painting gradient shadow test executing');

  // ========== LINEARGRADIENT ==========
  print('--- LinearGradient Tests ---');

  // Test basic LinearGradient
  final basicGradient = LinearGradient(
    colors: [Color(0xFF2196F3), Color(0xFFE53935)],
  );
  print('Basic LinearGradient: colors=${basicGradient.colors}');

  // Test LinearGradient with begin/end
  final horizontalGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF2196F3), Color(0xFFE53935)],
  );
  print(
    'Horizontal gradient: begin=${horizontalGradient.begin}, end=${horizontalGradient.end}',
  );

  final verticalGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF2196F3), Color(0xFFE53935)],
  );
  print(
    'Vertical gradient: begin=${verticalGradient.begin}, end=${verticalGradient.end}',
  );

  final diagonalGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2196F3), Color(0xFFE53935)],
  );
  print(
    'Diagonal gradient: begin=${diagonalGradient.begin}, end=${diagonalGradient.end}',
  );

  // Test LinearGradient with multiple colors
  final multiColorGradient = LinearGradient(
    colors: [
      Color(0xFFE53935), // Red
      Color(0xFFFF9800), // Orange
      Color(0xFFFFEB3B), // Yellow
      Color(0xFF4CAF50), // Green
      Color(0xFF2196F3), // Blue
      Color(0xFF9C27B0), // Purple
    ],
  );
  print('Multi-color gradient: ${multiColorGradient.colors.length} colors');

  // Test LinearGradient with stops
  final stopsGradient = LinearGradient(
    colors: [Color(0xFF2196F3), Color(0xFFE53935), Color(0xFF4CAF50)],
    stops: [0.0, 0.3, 1.0],
  );
  print('Gradient with stops: ${stopsGradient.stops}');

  // Test LinearGradient with tileMode
  final clampGradient = LinearGradient(
    colors: [Color(0xFF2196F3), Color(0xFFE53935)],
    tileMode: TileMode.clamp,
  );
  print('Gradient tileMode clamp: ${clampGradient.tileMode}');

  final repeatGradient = LinearGradient(
    colors: [Color(0xFF2196F3), Color(0xFFE53935)],
    tileMode: TileMode.repeated,
  );
  print('Gradient tileMode repeated: ${repeatGradient.tileMode}');

  final mirrorGradient = LinearGradient(
    colors: [Color(0xFF2196F3), Color(0xFFE53935)],
    tileMode: TileMode.mirror,
  );
  print('Gradient tileMode mirror: ${mirrorGradient.tileMode}');

  final decalGradient = LinearGradient(
    colors: [Color(0xFF2196F3), Color(0xFFE53935)],
    tileMode: TileMode.decal,
  );
  print('Gradient tileMode decal: ${decalGradient.tileMode}');

  // Test LinearGradient.lerp
  final gradientStart = LinearGradient(
    colors: [Color(0xFF2196F3), Color(0xFF2196F3)],
  );
  final gradientEnd = LinearGradient(
    colors: [Color(0xFFE53935), Color(0xFFE53935)],
  );
  final lerpedGradient = LinearGradient.lerp(gradientStart, gradientEnd, 0.5);
  print('LinearGradient.lerp at 0.5: colors=${lerpedGradient?.colors}');

  // Test LinearGradient with transform
  final transformedGradient = LinearGradient(
    colors: [Color(0xFF2196F3), Color(0xFFE53935)],
    transform: GradientRotation(0.785), // 45 degrees
  );
  print('Gradient with transform: ${transformedGradient.transform}');

  // Test LinearGradient scale
  final scaledGradient = basicGradient.scale(0.5);
  print('Gradient.scale(0.5): colors=${scaledGradient.colors}');

  // Test createShader
  final shader = basicGradient.createShader(
    Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
  );
  print('createShader created: ${shader != null}');

  // ========== BOXSHADOW ==========
  print('--- BoxShadow Tests ---');

  // Test basic BoxShadow
  final basicShadow = BoxShadow(
    color: Color(0x80000000),
    offset: Offset(2.0, 2.0),
    blurRadius: 4.0,
  );
  print(
    'Basic BoxShadow: color=${basicShadow.color}, offset=${basicShadow.offset}, blurRadius=${basicShadow.blurRadius}',
  );

  // Test BoxShadow with default values
  final defaultShadow = BoxShadow();
  print(
    'BoxShadow() default: color=${defaultShadow.color}, offset=${defaultShadow.offset}',
  );

  // Test BoxShadow with spreadRadius
  final spreadShadow = BoxShadow(
    color: Color(0x80000000),
    offset: Offset(0.0, 4.0),
    blurRadius: 8.0,
    spreadRadius: 2.0,
  );
  print(
    'BoxShadow with spreadRadius: spreadRadius=${spreadShadow.spreadRadius}',
  );

  // Test BoxShadow with negative spreadRadius
  final negativeSreadShadow = BoxShadow(
    color: Color(0x80000000),
    offset: Offset(0.0, 2.0),
    blurRadius: 8.0,
    spreadRadius: -2.0,
  );
  print(
    'BoxShadow with negative spreadRadius: ${negativeSreadShadow.spreadRadius}',
  );

  // Test BoxShadow with blurStyle
  final normalBlurShadow = BoxShadow(
    color: Color(0x80000000),
    blurRadius: 8.0,
    blurStyle: BlurStyle.normal,
  );
  print('BoxShadow blurStyle normal: ${normalBlurShadow.blurStyle}');

  final solidBlurShadow = BoxShadow(
    color: Color(0x80000000),
    blurRadius: 8.0,
    blurStyle: BlurStyle.solid,
  );
  print('BoxShadow blurStyle solid: ${solidBlurShadow.blurStyle}');

  final outerBlurShadow = BoxShadow(
    color: Color(0x80000000),
    blurRadius: 8.0,
    blurStyle: BlurStyle.outer,
  );
  print('BoxShadow blurStyle outer: ${outerBlurShadow.blurStyle}');

  final innerBlurShadow = BoxShadow(
    color: Color(0x80000000),
    blurRadius: 8.0,
    blurStyle: BlurStyle.inner,
  );
  print('BoxShadow blurStyle inner: ${innerBlurShadow.blurStyle}');

  // Test BoxShadow scale
  final scaledShadow = basicShadow.scale(2.0);
  print(
    'BoxShadow.scale(2.0): blurRadius=${scaledShadow.blurRadius}, offset=${scaledShadow.offset}',
  );

  // Test BoxShadow.lerp
  final shadowStart = BoxShadow(
    color: Color(0x80000000),
    offset: Offset(0.0, 0.0),
    blurRadius: 0.0,
  );
  final shadowEnd = BoxShadow(
    color: Color(0x80000000),
    offset: Offset(10.0, 10.0),
    blurRadius: 20.0,
  );
  final lerpedShadow = BoxShadow.lerp(shadowStart, shadowEnd, 0.5);
  print(
    'BoxShadow.lerp at 0.5: offset=${lerpedShadow?.offset}, blurRadius=${lerpedShadow?.blurRadius}',
  );

  // Test BoxShadow.lerpList
  final shadowList1 = [BoxShadow(color: Color(0x80000000), blurRadius: 4.0)];
  final shadowList2 = [
    BoxShadow(color: Color(0x80000000), blurRadius: 8.0),
    BoxShadow(color: Color(0x40000000), blurRadius: 16.0),
  ];
  final lerpedList = BoxShadow.lerpList(shadowList1, shadowList2, 0.5);
  print('BoxShadow.lerpList: ${lerpedList?.length} shadows');

  // Test BoxShadow toPaint
  final paint = basicShadow.toPaint();
  print('BoxShadow.toPaint: color=${paint.color}');

  // Test elevated shadow patterns (Material Design)
  final elevation2Shadow = [
    BoxShadow(
      color: Color(0x33000000),
      offset: Offset(0.0, 1.0),
      blurRadius: 3.0,
      spreadRadius: 0.0,
    ),
    BoxShadow(
      color: Color(0x1F000000),
      offset: Offset(0.0, 1.0),
      blurRadius: 1.0,
      spreadRadius: 0.0,
    ),
  ];
  print('Material elevation 2 shadow: ${elevation2Shadow.length} shadows');

  final elevation8Shadow = [
    BoxShadow(
      color: Color(0x33000000),
      offset: Offset(0.0, 5.0),
      blurRadius: 5.0,
      spreadRadius: -3.0,
    ),
    BoxShadow(
      color: Color(0x24000000),
      offset: Offset(0.0, 8.0),
      blurRadius: 10.0,
      spreadRadius: 1.0,
    ),
    BoxShadow(
      color: Color(0x1F000000),
      offset: Offset(0.0, 3.0),
      blurRadius: 14.0,
      spreadRadius: 2.0,
    ),
  ];
  print('Material elevation 8 shadow: ${elevation8Shadow.length} shadows');

  print('Painting gradient shadow test completed');

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
              'Gradient & Shadow Tests',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            // LinearGradient examples
            Text(
              'LinearGradient:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),

            Text('Horizontal:', style: TextStyle(fontSize: 12.0)),
            Container(
              width: 200.0,
              height: 50.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFF2196F3), Color(0xFFE53935)],
                ),
              ),
            ),
            SizedBox(height: 8.0),

            Text('Vertical:', style: TextStyle(fontSize: 12.0)),
            Container(
              width: 200.0,
              height: 50.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF2196F3), Color(0xFFE53935)],
                ),
              ),
            ),
            SizedBox(height: 8.0),

            Text('Diagonal:', style: TextStyle(fontSize: 12.0)),
            Container(
              width: 200.0,
              height: 50.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF2196F3), Color(0xFFE53935)],
                ),
              ),
            ),
            SizedBox(height: 8.0),

            Text('Rainbow:', style: TextStyle(fontSize: 12.0)),
            Container(
              width: 200.0,
              height: 50.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFE53935),
                    Color(0xFFFF9800),
                    Color(0xFFFFEB3B),
                    Color(0xFF4CAF50),
                    Color(0xFF2196F3),
                    Color(0xFF9C27B0),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8.0),

            Text('With stops [0, 0.3, 1]:', style: TextStyle(fontSize: 12.0)),
            Container(
              width: 200.0,
              height: 50.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF2196F3),
                    Color(0xFFE53935),
                    Color(0xFF4CAF50),
                  ],
                  stops: [0.0, 0.3, 1.0],
                ),
              ),
            ),
            SizedBox(height: 16.0),

            // BoxShadow examples
            Text('BoxShadow:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),

            Row(
              children: [
                Column(
                  children: [
                    Text('Low', style: TextStyle(fontSize: 10.0)),
                    SizedBox(height: 4.0),
                    Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0.0, 2.0),
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16.0),
                Column(
                  children: [
                    Text('Medium', style: TextStyle(fontSize: 10.0)),
                    SizedBox(height: 4.0),
                    Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0.0, 4.0),
                            blurRadius: 8.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16.0),
                Column(
                  children: [
                    Text('High', style: TextStyle(fontSize: 10.0)),
                    SizedBox(height: 4.0),
                    Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0.0, 8.0),
                            blurRadius: 16.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24.0),

            Text(
              'Colored Shadows:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF2196F3),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x802196F3),
                        offset: Offset(0.0, 4.0),
                        blurRadius: 12.0,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.0),
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFE53935),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x80E53935),
                        offset: Offset(0.0, 4.0),
                        blurRadius: 12.0,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.0),
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF4CAF50),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x804CAF50),
                        offset: Offset(0.0, 4.0),
                        blurRadius: 12.0,
                      ),
                    ],
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
