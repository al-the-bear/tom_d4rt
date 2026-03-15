// D4rt test script: Tests RevealedOffset from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RevealedOffset test executing');

  // ========== Basic RevealedOffset creation ==========
  print('--- Basic RevealedOffset ---');
  final offset1 = RevealedOffset(
    offset: 100.0,
    rect: Rect.fromLTWH(0.0, 100.0, 200.0, 50.0),
  );
  print('  created: ${offset1.runtimeType}');
  print('  offset: ${offset1.offset}');
  print('  rect: ${offset1.rect}');

  // ========== Different offset values ==========
  print('--- Different offset values ---');
  final offsetZero = RevealedOffset(
    offset: 0.0,
    rect: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
  );
  final offsetNegative = RevealedOffset(
    offset: -50.0,
    rect: Rect.fromLTWH(0.0, -50.0, 100.0, 100.0),
  );
  final offsetLarge = RevealedOffset(
    offset: 10000.0,
    rect: Rect.fromLTWH(0.0, 10000.0, 100.0, 100.0),
  );
  print('  zero offset: ${offsetZero.offset}');
  print('  negative offset: ${offsetNegative.offset}');
  print('  large offset: ${offsetLarge.offset}');

  // ========== Different rect configurations ==========
  print('--- Different rect configurations ---');
  final rectFromLTRB = RevealedOffset(
    offset: 50.0,
    rect: Rect.fromLTRB(10.0, 50.0, 210.0, 150.0),
  );
  print('  rect fromLTRB: ${rectFromLTRB.rect}');
  print('  rect width: ${rectFromLTRB.rect.width}');
  print('  rect height: ${rectFromLTRB.rect.height}');

  final rectFromCenter = RevealedOffset(
    offset: 75.0,
    rect: Rect.fromCenter(
      center: Offset(100.0, 75.0),
      width: 80.0,
      height: 60.0,
    ),
  );
  print('  rect fromCenter: ${rectFromCenter.rect}');
  print('  rect center: ${rectFromCenter.rect.center}');

  // ========== Zero rect ==========
  print('--- Zero rect ---');
  final zeroRect = RevealedOffset(offset: 0.0, rect: Rect.zero);
  print('  rect.isEmpty: ${zeroRect.rect.isEmpty}');
  print('  rect: ${zeroRect.rect}');

  // ========== Rect properties ==========
  print('--- Rect properties from RevealedOffset ---');
  final testOffset = RevealedOffset(
    offset: 200.0,
    rect: Rect.fromLTWH(10.0, 200.0, 150.0, 75.0),
  );
  print('  rect.left: ${testOffset.rect.left}');
  print('  rect.top: ${testOffset.rect.top}');
  print('  rect.right: ${testOffset.rect.right}');
  print('  rect.bottom: ${testOffset.rect.bottom}');
  print('  rect.width: ${testOffset.rect.width}');
  print('  rect.height: ${testOffset.rect.height}');
  print('  rect.topLeft: ${testOffset.rect.topLeft}');
  print('  rect.bottomRight: ${testOffset.rect.bottomRight}');
  print('  rect.size: ${testOffset.rect.size}');

  // ========== Offset relation to rect ==========
  print('--- Offset relation to rect ---');
  print(
    '  offset matches rect.top: ${testOffset.offset == testOffset.rect.top}',
  );
  print('  offset value: ${testOffset.offset}');
  print('  rect.top value: ${testOffset.rect.top}');

  // ========== Multiple RevealedOffsets ==========
  print('--- Multiple RevealedOffsets ---');
  final offsets = [
    RevealedOffset(offset: 0.0, rect: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0)),
    RevealedOffset(
      offset: 100.0,
      rect: Rect.fromLTWH(0.0, 100.0, 100.0, 100.0),
    ),
    RevealedOffset(
      offset: 200.0,
      rect: Rect.fromLTWH(0.0, 200.0, 100.0, 100.0),
    ),
    RevealedOffset(
      offset: 300.0,
      rect: Rect.fromLTWH(0.0, 300.0, 100.0, 100.0),
    ),
  ];
  print('  Created ${offsets.length} RevealedOffsets');
  for (var i = 0; i < offsets.length; i++) {
    print(
      '  [$i] offset: ${offsets[i].offset}, rect.top: ${offsets[i].rect.top}',
    );
  }

  // ========== ToString ==========
  print('--- ToString ---');
  print('  offset1.toString(): ${offset1.toString()}');

  // ========== Equality behavior ==========
  print('--- Equality behavior ---');
  final offsetA = RevealedOffset(
    offset: 100.0,
    rect: Rect.fromLTWH(0.0, 100.0, 50.0, 50.0),
  );
  final offsetB = RevealedOffset(
    offset: 100.0,
    rect: Rect.fromLTWH(0.0, 100.0, 50.0, 50.0),
  );
  print('  offsetA == offsetA: ${offsetA == offsetA}');
  print('  offsetA == offsetB: ${offsetA == offsetB}');
  print(
    '  offsetA.offset == offsetB.offset: ${offsetA.offset == offsetB.offset}',
  );
  print('  offsetA.rect == offsetB.rect: ${offsetA.rect == offsetB.rect}');

  print('RevealedOffset test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'RevealedOffset Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Basic offset: ${offset1.offset}'),
          Text('Basic rect: ${offset1.rect}'),
          Text('Zero offset: ${offsetZero.offset}'),
          Text('Negative offset: ${offsetNegative.offset}'),
          Text('Large offset: ${offsetLarge.offset}'),
          Text('Rect center: ${rectFromCenter.rect.center}'),
          Text('Multiple offsets created: ${offsets.length}'),
        ],
      ),
    ),
  );
}
