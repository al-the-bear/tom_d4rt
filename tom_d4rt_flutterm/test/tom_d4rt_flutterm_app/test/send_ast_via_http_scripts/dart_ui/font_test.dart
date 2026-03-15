// D4rt test script: Tests FontFeature, FontVariation, RSTransform, Tangent from dart:ui
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('dart:ui font test executing');

  // ========== FONTFEATURE ==========
  print('--- FontFeature Tests ---');

  final smcp = FontFeature.enable('smcp');
  print('FontFeature.enable("smcp"): $smcp');
  print('  feature: ${smcp.feature}');
  print('  value: ${smcp.value}');
  print('  runtimeType: ${smcp.runtimeType}');

  final liga = FontFeature.enable('liga');
  print('FontFeature.enable("liga"): $liga');

  final disableLiga = FontFeature.disable('liga');
  print('FontFeature.disable("liga"): $disableLiga');
  print('  value: ${disableLiga.value}');

  final swsh = FontFeature('swsh', 2);
  print('FontFeature("swsh", 2): $swsh');
  print('  feature: ${swsh.feature}');
  print('  value: ${swsh.value}');

  // Common font features
  final features = [
    FontFeature.enable('kern'),
    FontFeature.enable('onum'),
    FontFeature.enable('tnum'),
    FontFeature.enable('frac'),
    FontFeature.enable('zero'),
  ];
  for (final f in features) {
    print('  FontFeature: ${f.feature} = ${f.value}');
  }

  // Named constructors
  final tabular = FontFeature.tabularFigures();
  print('FontFeature.tabularFigures(): $tabular');

  final oldStyle = FontFeature.oldstyleFigures();
  print('FontFeature.oldstyleFigures(): $oldStyle');

  final proportional = FontFeature.proportionalFigures();
  print('FontFeature.proportionalFigures(): $proportional');

  // ========== FONTVARIATION ==========
  print('--- FontVariation Tests ---');

  final wght = FontVariation('wght', 700);
  print('FontVariation("wght", 700): $wght');
  print('  axis: ${wght.axis}');
  print('  value: ${wght.value}');
  print('  runtimeType: ${wght.runtimeType}');

  final wdth = FontVariation('wdth', 120);
  print('FontVariation("wdth", 120): $wdth');

  final slnt = FontVariation('slnt', -12.0);
  print('FontVariation("slnt", -12): $slnt');

  final ital = FontVariation('ital', 1.0);
  print('FontVariation("ital", 1.0): $ital');

  // Named constructors
  final weightVar = FontVariation.weight(600);
  print('FontVariation.weight(600): $weightVar');

  final widthVar = FontVariation.width(110);
  print('FontVariation.width(110): $widthVar');

  final slantVar = FontVariation.slant(-10.0);
  print('FontVariation.slant(-10): $slantVar');

  final italicVar = FontVariation.italic(1.0);
  print('FontVariation.italic(1.0): $italicVar');

  // ========== RSTRANSFORM ==========
  print('--- RSTransform Tests ---');

  // Identity transform
  final identity = RSTransform(1.0, 0.0, 0.0, 0.0);
  print('RSTransform identity (1,0,0,0): $identity');
  print('  scos: ${identity.scos}');
  print('  ssin: ${identity.ssin}');
  print('  tx: ${identity.tx}');
  print('  ty: ${identity.ty}');
  print('  runtimeType: ${identity.runtimeType}');

  // Rotation transform
  final angle = math.pi / 4; // 45 degrees
  final cosA = math.cos(angle);
  final sinA = math.sin(angle);
  final rotation = RSTransform(cosA, sinA, 50.0, 50.0);
  print('RSTransform 45deg rotation at (50,50): $rotation');
  print('  scos: ${rotation.scos}');
  print('  ssin: ${rotation.ssin}');

  // Scale transform
  final scale2x = RSTransform(2.0, 0.0, 0.0, 0.0);
  print('RSTransform 2x scale: $scale2x');

  // fromComponents factory
  final fromComp = RSTransform.fromComponents(
    rotation: math.pi / 6, // 30 degrees
    scale: 1.5,
    anchorX: 0.0,
    anchorY: 0.0,
    translateX: 100.0,
    translateY: 200.0,
  );
  print('RSTransform.fromComponents(30deg, 1.5x, at 100,200): $fromComp');
  print('  scos: ${fromComp.scos}');
  print('  ssin: ${fromComp.ssin}');
  print('  tx: ${fromComp.tx}');
  print('  ty: ${fromComp.ty}');

  // ========== TANGENT ==========
  print('--- Tangent Tests ---');

  final tangent1 = Tangent(Offset(10.0, 20.0), Offset(1.0, 0.0));
  print('Tangent(position: (10,20), vector: (1,0)): $tangent1');
  print('  position: ${tangent1.position}');
  print('  vector: ${tangent1.vector}');
  print('  angle: ${tangent1.angle}');
  print('  runtimeType: ${tangent1.runtimeType}');

  final tangent2 = Tangent(Offset(50.0, 50.0), Offset(0.0, 1.0));
  print('Tangent(position: (50,50), vector: (0,1))');
  print('  angle: ${tangent2.angle}');

  final tangent3 = Tangent(Offset(0.0, 0.0), Offset(1.0, 1.0));
  print('Tangent(position: (0,0), vector: (1,1))');
  print('  angle: ${tangent3.angle}');

  // ========== LINEMETRICS / VIEWPADDING ==========
  print('--- LineMetrics / ViewPadding Notes ---');

  // LineMetrics cannot be directly constructed - it's returned by Paragraph.computeLineMetrics()
  print('LineMetrics: Not directly constructable');
  print('  Returned by Paragraph.computeLineMetrics()');
  print(
    '  Properties: hardBreak, ascent, descent, unscaledAscent, height, width, left, baseline, lineNumber',
  );

  // ViewPadding is not directly constructable
  print('ViewPadding: Not directly constructable');
  print('  Accessed via FlutterView.padding, FlutterView.viewInsets, etc.');
  print('  Properties: left, top, right, bottom');

  // GlyphInfo is not directly constructable
  print('GlyphInfo: Not directly constructable');
  print('  Returned by Paragraph.getGlyphInfoAt() etc.');

  // ========== RETURN WIDGET ==========
  print('dart:ui font test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'dart:ui Font & Transform Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text(
            'Classes Tested:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• FontFeature - OpenType font features'),
          Text('• FontVariation - variable font axes'),
          Text('• RSTransform - rotation+scale+translate'),
          Text('• Tangent - path tangent vector'),
          SizedBox(height: 16.0),

          Text(
            'Not Constructable:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• LineMetrics - from Paragraph'),
          Text('• ViewPadding - from FlutterView'),
          Text('• GlyphInfo - from Paragraph'),
          SizedBox(height: 16.0),

          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFFCE4EC),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('FontFeature smcp: ${smcp.feature}=${smcp.value}'),
                Text('FontVariation wght: ${wght.axis}=${wght.value}'),
                Text('RSTransform identity: scos=${identity.scos}'),
                Text('Tangent angle: ${tangent1.angle}'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
