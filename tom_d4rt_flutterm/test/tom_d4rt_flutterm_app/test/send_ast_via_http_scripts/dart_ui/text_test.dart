// D4rt test script: Tests TextPosition, TextRange, TextBox, TextDecoration, TextHeightBehavior, FontFeature, FontVariation
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('dart:ui text typography tests executing');

  // ========== TextPosition ==========
  print('--- TextPosition Tests ---');
  final tp1 = TextPosition(offset: 5);
  print('TextPosition: offset=${tp1.offset}, affinity=${tp1.affinity}');
  final tp2 = TextPosition(offset: 10, affinity: TextAffinity.upstream);
  print(
    'TextPosition upstream: offset=${tp2.offset}, affinity=${tp2.affinity}',
  );
  final tp3 = TextPosition(offset: 0, affinity: TextAffinity.downstream);
  print('TextPosition downstream: offset=${tp3.offset}');
  print('tp1 == tp1: ${tp1 == tp1}');
  print('tp1.hashCode: ${tp1.hashCode}');

  // ========== TextRange ==========
  print('--- TextRange Tests ---');
  final tr1 = TextRange(start: 0, end: 10);
  print('TextRange(0,10): start=${tr1.start}, end=${tr1.end}');
  print('isValid: ${tr1.isValid}');
  print('isCollapsed: ${tr1.isCollapsed}');
  print('isNormalized: ${tr1.isNormalized}');
  final tr2 = TextRange.collapsed(5);
  print(
    'TextRange.collapsed(5): start=${tr2.start}, end=${tr2.end}, isCollapsed=${tr2.isCollapsed}',
  );
  final tr3 = TextRange.empty;
  print('TextRange.empty: start=${tr3.start}, end=${tr3.end}');
  print('textBefore: ${tr1.textBefore("Hello World")}');
  print('textAfter: ${tr1.textAfter("Hello World")}');
  print('textInside: ${tr1.textInside("Hello World")}');

  // ========== TextDecoration ==========
  print('--- TextDecoration Tests ---');
  print('TextDecoration.none: ${TextDecoration.none}');
  print('TextDecoration.underline: ${TextDecoration.underline}');
  print('TextDecoration.overline: ${TextDecoration.overline}');
  print('TextDecoration.lineThrough: ${TextDecoration.lineThrough}');
  final combined = TextDecoration.combine([
    TextDecoration.underline,
    TextDecoration.overline,
  ]);
  print('TextDecoration.combine: $combined');
  print('contains underline: ${combined.contains(TextDecoration.underline)}');
  print(
    'contains lineThrough: ${combined.contains(TextDecoration.lineThrough)}',
  );

  // ========== TextHeightBehavior ==========
  print('--- TextHeightBehavior Tests ---');
  final thb1 = TextHeightBehavior();
  print(
    'TextHeightBehavior default: applyFirst=${thb1.applyHeightToFirstAscent}, applyLast=${thb1.applyHeightToLastDescent}',
  );
  final thb2 = TextHeightBehavior(
    applyHeightToFirstAscent: false,
    applyHeightToLastDescent: true,
    leadingDistribution: TextLeadingDistribution.even,
  );
  print(
    'TextHeightBehavior custom: applyFirst=${thb2.applyHeightToFirstAscent}, leading=${thb2.leadingDistribution}',
  );

  // ========== FontFeature ==========
  print('--- FontFeature Tests ---');
  final ff1 = FontFeature('liga');
  print('FontFeature liga: ${ff1.feature}, value=${ff1.value}');
  final ff2 = FontFeature('smcp', 1);
  print('FontFeature smcp: ${ff2.feature}, value=${ff2.value}');
  final ff3 = FontFeature.enable('kern');
  print('FontFeature.enable kern: ${ff3.feature}');
  final ff4 = FontFeature.disable('liga');
  print('FontFeature.disable liga: ${ff4.feature}, value=${ff4.value}');
  final ff5 = FontFeature.tabularFigures();
  print('FontFeature.tabularFigures: ${ff5.feature}');
  final ff6 = FontFeature.oldstyleFigures();
  print('FontFeature.oldstyleFigures: ${ff6.feature}');

  // ========== FontVariation ==========
  print('--- FontVariation Tests ---');
  final fv1 = FontVariation('wght', 400.0);
  print('FontVariation wght: axis=${fv1.axis}, value=${fv1.value}');
  final fv2 = FontVariation('wdth', 100.0);
  print('FontVariation wdth: axis=${fv2.axis}, value=${fv2.value}');
  final fv3 = FontVariation.weight(700.0);
  print('FontVariation.weight(700): axis=${fv3.axis}, value=${fv3.value}');

  // ========== TextBox ==========
  print('--- TextBox Tests ---');
  final tb1 = TextBox.fromLTRBD(10.0, 20.0, 100.0, 40.0, TextDirection.ltr);
  print(
    'TextBox: left=${tb1.left}, top=${tb1.top}, right=${tb1.right}, bottom=${tb1.bottom}',
  );
  print('direction: ${tb1.direction}');
  print('start: ${tb1.start}, end: ${tb1.end}');
  final tb2 = TextBox.fromLTRBD(50.0, 0.0, 200.0, 30.0, TextDirection.rtl);
  print('TextBox RTL: start=${tb2.start}, end=${tb2.end}');
  print('toRect: ${tb1.toRect()}');

  print('All text typography tests passed');

  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'dart:ui Text Typography Tests',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text('TextPosition: 3 instances'),
            Text('TextRange: normal, collapsed, empty'),
            Text('TextDecoration: 4 types + combine'),
            Text('TextHeightBehavior: default + custom'),
            Text('FontFeature: liga, smcp, kern, tabular'),
            Text('FontVariation: wght, wdth, weight()'),
            Text('TextBox: LTR + RTL'),
          ],
        ),
      ),
    ),
  );
}
