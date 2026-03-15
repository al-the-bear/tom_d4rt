// D4rt test script: Tests TableBorder from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TableBorder test executing');
  final results = <String>[];

  // ========== Section 1: Basic TableBorder Creation ==========
  print('--- Section 1: Basic TableBorder Creation ---');

  final border1 = TableBorder();
  print('Created default TableBorder: ${border1.runtimeType}');
  print('Default top: ${border1.top}');
  print('Default right: ${border1.right}');
  print('Default bottom: ${border1.bottom}');
  print('Default left: ${border1.left}');
  results.add('Basic creation successful');

  // ========== Section 2: TableBorder with All Sides ==========
  print('--- Section 2: TableBorder with All Sides ---');

  final borderSide = BorderSide(color: Color(0xFF000000), width: 2.0);
  final border2 = TableBorder(
    top: borderSide,
    right: borderSide,
    bottom: borderSide,
    left: borderSide,
  );
  print('Border with sides - top width: ${border2.top.width}');
  print('Border with sides - right width: ${border2.right.width}');
  print('Border with sides - bottom width: ${border2.bottom.width}');
  print('Border with sides - left width: ${border2.left.width}');
  results.add('All sides: width=2.0');

  // ========== Section 3: TableBorder.all Factory ==========
  print('--- Section 3: TableBorder.all Factory ---');

  final borderAll = TableBorder.all(color: Color(0xFFFF0000), width: 1.5);
  print('TableBorder.all top width: ${borderAll.top.width}');
  print('TableBorder.all top color: ${borderAll.top.color}');
  print(
    'TableBorder.all horizontalInside width: ${borderAll.horizontalInside.width}',
  );
  print(
    'TableBorder.all verticalInside width: ${borderAll.verticalInside.width}',
  );
  results.add('TableBorder.all: width=1.5, color=red');

  // ========== Section 4: TableBorder.symmetric Factory ==========
  print('--- Section 4: TableBorder.symmetric Factory ---');

  final outsideSide = BorderSide(color: Color(0xFF0000FF), width: 2.0);
  final insideSide = BorderSide(color: Color(0xFF00FF00), width: 1.0);
  final borderSymmetric = TableBorder.symmetric(
    outside: outsideSide,
    inside: insideSide,
  );
  print('Symmetric - top width: ${borderSymmetric.top.width}');
  print(
    'Symmetric - horizontalInside width: ${borderSymmetric.horizontalInside.width}',
  );
  print(
    'Symmetric - verticalInside width: ${borderSymmetric.verticalInside.width}',
  );
  results.add('TableBorder.symmetric: outside=2, inside=1');

  // ========== Section 5: Horizontal and Vertical Inside ==========
  print('--- Section 5: Horizontal and Vertical Inside ---');

  final border3 = TableBorder(
    top: BorderSide(width: 1.0),
    bottom: BorderSide(width: 1.0),
    left: BorderSide(width: 1.0),
    right: BorderSide(width: 1.0),
    horizontalInside: BorderSide(width: 0.5, color: Color(0xFFCCCCCC)),
    verticalInside: BorderSide(width: 0.5, color: Color(0xFFCCCCCC)),
  );
  print('horizontalInside width: ${border3.horizontalInside.width}');
  print('verticalInside width: ${border3.verticalInside.width}');
  print('horizontalInside color: ${border3.horizontalInside.color}');
  results.add('Inside borders: width=0.5');

  // ========== Section 6: Border Radius ==========
  print('--- Section 6: Border Radius ---');

  final borderWithRadius = TableBorder(
    top: BorderSide(width: 1.0),
    bottom: BorderSide(width: 1.0),
    left: BorderSide(width: 1.0),
    right: BorderSide(width: 1.0),
    borderRadius: BorderRadius.circular(8.0),
  );
  print('Border radius: ${borderWithRadius.borderRadius}');
  print('Top left radius: ${borderWithRadius.borderRadius.topLeft}');
  print('Bottom right radius: ${borderWithRadius.borderRadius.bottomRight}');
  results.add('Border radius: 8.0');

  // ========== Section 7: Various Border Widths ==========
  print('--- Section 7: Various Border Widths ---');

  final widths = [0.5, 1.0, 1.5, 2.0, 3.0, 5.0];
  for (final width in widths) {
    final border = TableBorder.all(width: width);
    print('Border width $width: top=${border.top.width}');
  }
  results.add('Tested ${widths.length} border widths');

  // ========== Section 8: Various Colors ==========
  print('--- Section 8: Various Colors ---');

  final colors = [
    Color(0xFF000000), // Black
    Color(0xFFFF0000), // Red
    Color(0xFF00FF00), // Green
    Color(0xFF0000FF), // Blue
    Color(0xFFFFFFFF), // White
  ];
  for (final color in colors) {
    final border = TableBorder.all(color: color);
    print('Border color $color: ${border.top.color}');
  }
  results.add('Tested ${colors.length} colors');

  // ========== Section 9: isUniform Property ==========
  print('--- Section 9: isUniform Property ---');

  final uniformBorder = TableBorder.all(width: 1.0, color: Color(0xFF000000));
  print('Uniform border isUniform: ${uniformBorder.isUniform}');

  final nonUniformBorder = TableBorder(
    top: BorderSide(width: 1.0),
    bottom: BorderSide(width: 2.0),
  );
  print('Non-uniform border isUniform: ${nonUniformBorder.isUniform}');
  results.add('isUniform tested');

  // ========== Section 10: dimensions Property ==========
  print('--- Section 10: dimensions Property ---');

  final border4 = TableBorder.all(width: 2.0);
  print('dimensions: ${border4.dimensions}');
  print('dimensions.horizontal: ${border4.dimensions.horizontal}');
  print('dimensions.vertical: ${border4.dimensions.vertical}');
  results.add('dimensions tested');

  // ========== Section 11: scale Method ==========
  print('--- Section 11: scale Method ---');

  final originalBorder = TableBorder.all(width: 2.0);
  final scaledBorder = originalBorder.scale(0.5);
  print('Original width: ${originalBorder.top.width}');
  print('Scaled (0.5) width: ${scaledBorder.top.width}');

  final scaledBorder2 = originalBorder.scale(2.0);
  print('Scaled (2.0) width: ${scaledBorder2.top.width}');
  results.add('scale method tested');

  // ========== Section 12: lerp Static Method ==========
  print('--- Section 12: lerp Static Method ---');

  final borderA = TableBorder.all(width: 1.0);
  final borderB = TableBorder.all(width: 3.0);

  final lerpHalf = TableBorder.lerp(borderA, borderB, 0.5);
  print('Lerp 0.5 width: ${lerpHalf?.top.width}');

  final lerpQuarter = TableBorder.lerp(borderA, borderB, 0.25);
  print('Lerp 0.25 width: ${lerpQuarter?.top.width}');
  results.add('lerp method tested');

  print('TableBorder test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TableBorder Tests'),
      Text('Results: ${results.length} sections'),
      ...results.map((r) => Text(r)),
    ],
  );
}
