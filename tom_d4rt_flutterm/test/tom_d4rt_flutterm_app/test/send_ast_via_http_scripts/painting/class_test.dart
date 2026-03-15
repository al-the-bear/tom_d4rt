// D4rt test script: Tests multiple painting classes from Flutter painting package
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// Covers: TextPainter, BoxDecoration, ImageProvider, Gradient, Border, TextStyle
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Painting class overview test executing');

  // ========== TEXTPAINTER ==========
  print('--- TextPainter Tests ---');
  final textPainter = TextPainter(
    text: TextSpan(
      text: 'Hello TextPainter',
      style: TextStyle(fontSize: 20.0, color: Colors.blue),
    ),
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.left,
    maxLines: 1,
  );
  textPainter.layout(minWidth: 0.0, maxWidth: 300.0);
  print('TextPainter width: ${textPainter.width}');
  print('TextPainter height: ${textPainter.height}');
  print('TextPainter size: ${textPainter.size}');
  print('TextPainter minIntrinsicWidth: ${textPainter.minIntrinsicWidth}');
  print('TextPainter maxIntrinsicWidth: ${textPainter.maxIntrinsicWidth}');
  print('TextPainter preferredLineHeight: ${textPainter.preferredLineHeight}');

  // TextPainter with multiline
  final multiLinePainter = TextPainter(
    text: TextSpan(
      text: 'Line 1\nLine 2\nLine 3',
      style: TextStyle(fontSize: 16.0),
    ),
    textDirection: TextDirection.ltr,
    maxLines: 3,
  );
  multiLinePainter.layout(maxWidth: 200.0);
  print('Multiline height: ${multiLinePainter.height}');

  // ========== TEXTSTYLE ==========
  print('--- TextStyle Tests ---');
  final textStyle1 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    color: Colors.red,
    letterSpacing: 1.5,
    wordSpacing: 2.0,
    height: 1.2,
    decoration: TextDecoration.underline,
    decorationColor: Colors.blue,
    decorationStyle: TextDecorationStyle.wavy,
  );
  print('TextStyle fontSize: ${textStyle1.fontSize}');
  print('TextStyle fontWeight: ${textStyle1.fontWeight}');
  print('TextStyle decoration: ${textStyle1.decoration}');

  final mergedStyle = textStyle1.merge(TextStyle(color: Colors.green));
  print('Merged TextStyle color: ${mergedStyle.color}');

  final copiedStyle = textStyle1.copyWith(fontSize: 32.0);
  print('Copied TextStyle fontSize: ${copiedStyle.fontSize}');

  // ========== BOXDECORATION ==========
  print('--- BoxDecoration Tests ---');
  final boxDeco1 = BoxDecoration(
    color: Colors.purple,
    borderRadius: BorderRadius.circular(12.0),
    boxShadow: [
      BoxShadow(color: Colors.black38, blurRadius: 8.0, offset: Offset(2, 4)),
    ],
  );
  print('BoxDecoration color: ${boxDeco1.color}');
  print('BoxDecoration borderRadius: ${boxDeco1.borderRadius}');

  final boxDeco2 = BoxDecoration(
    gradient: LinearGradient(colors: [Colors.red, Colors.orange]),
    shape: BoxShape.circle,
  );
  print('BoxDecoration shape: ${boxDeco2.shape}');

  // ========== GRADIENT ==========
  print('--- Gradient Tests ---');
  final linearGrad = LinearGradient(
    colors: [Colors.blue, Colors.green, Colors.yellow],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  print('LinearGradient colors: ${linearGrad.colors.length}');
  print('LinearGradient begin: ${linearGrad.begin}');

  final radialGrad = RadialGradient(
    colors: [Colors.white, Colors.blue],
    center: Alignment.center,
    radius: 0.8,
  );
  print('RadialGradient radius: ${radialGrad.radius}');

  final sweepGrad = SweepGradient(
    colors: [Colors.red, Colors.green, Colors.blue, Colors.red],
    startAngle: 0.0,
    endAngle: 3.14159 * 2,
  );
  print('SweepGradient colors: ${sweepGrad.colors.length}');

  // ========== BORDER ==========
  print('--- Border Tests ---');
  final border1 = Border.all(color: Colors.black, width: 2.0);
  print('Border.all width: ${border1.top.width}');

  final border2 = Border(
    top: BorderSide(color: Colors.red, width: 3.0),
    bottom: BorderSide(color: Colors.blue, width: 3.0),
    left: BorderSide(color: Colors.green, width: 1.0),
    right: BorderSide(color: Colors.yellow, width: 1.0),
  );
  print('Border top color: ${border2.top.color}');
  print('Border dimensions: ${border2.dimensions}');

  // ========== BORDERRADIUS ==========
  print('--- BorderRadius Tests ---');
  final br1 = BorderRadius.circular(16.0);
  print('BorderRadius.circular: ${br1.topLeft}');

  final br2 = BorderRadius.only(
    topLeft: Radius.circular(8.0),
    bottomRight: Radius.elliptical(16.0, 8.0),
  );
  print('BorderRadius.only topLeft: ${br2.topLeft}');

  // ========== EDGEINSETS ==========
  print('--- EdgeInsets Tests ---');
  final ei1 = EdgeInsets.all(16.0);
  print('EdgeInsets.all: ${ei1.left}');

  final ei2 = EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0);
  print('EdgeInsets.symmetric h: ${ei2.left}, v: ${ei2.top}');

  final ei3 = EdgeInsets.fromLTRB(5, 10, 15, 20);
  print(
    'EdgeInsets.fromLTRB: ${ei3.left}, ${ei3.top}, ${ei3.right}, ${ei3.bottom}',
  );

  // ========== ALIGNMENT ==========
  print('--- Alignment Tests ---');
  print('Alignment.topLeft: ${Alignment.topLeft}');
  print('Alignment.center: ${Alignment.center}');
  print('Alignment.bottomRight: ${Alignment.bottomRight}');
  final customAlign = Alignment(0.5, -0.3);
  print('Custom Alignment: $customAlign');

  print('Painting class overview test completed');

  // ========== RETURN WIDGET ==========
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Painting Classes Overview',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),

          // TextPainter demo
          Text(
            'TextPainter: ${textPainter.width.toStringAsFixed(1)} x ${textPainter.height.toStringAsFixed(1)}',
          ),
          SizedBox(height: 8),

          // TextStyle demos
          Text('Bold Italic Underline', style: textStyle1),
          Text('Merged Green', style: mergedStyle),
          SizedBox(height: 12),

          // BoxDecoration demos
          Container(
            width: 150,
            height: 50,
            decoration: boxDeco1,
            child: Center(
              child: Text('Shadow Box', style: TextStyle(color: Colors.white)),
            ),
          ),
          SizedBox(height: 8),
          Container(width: 60, height: 60, decoration: boxDeco2),
          SizedBox(height: 12),

          // Gradient demos
          Container(
            width: 200,
            height: 40,
            decoration: BoxDecoration(
              gradient: linearGrad,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: Text('LinearGradient')),
          ),
          SizedBox(height: 8),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: radialGrad,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: sweepGrad,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(height: 12),

          // Border demo
          Container(
            width: 100,
            height: 50,
            decoration: BoxDecoration(border: border2, color: Colors.white),
            child: Center(child: Text('Borders')),
          ),
          SizedBox(height: 12),

          // EdgeInsets demo
          Container(
            color: Colors.grey.shade300,
            child: Padding(
              padding: ei2,
              child: Container(color: Colors.blue, width: 80, height: 40),
            ),
          ),
        ],
      ),
    ),
  );
}
