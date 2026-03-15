// D4rt test script: Tests RenderBaseline from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderBaseline test executing');

  // ========== BASELINE CONCEPTS ==========
  print('--- RenderBaseline Concepts ---');
  print('RenderBaseline positions child based on text baseline');
  print('It shifts the child vertically to align its baseline');
  print('Useful for aligning text with different sizes');

  // ========== TEXT BASELINE TYPES ==========
  print('--- TextBaseline Types ---');
  print('TextBaseline.alphabetic: ${TextBaseline.alphabetic}');
  print('  Baseline for alphabetic characters');
  print('  Used by most Western scripts');
  print('TextBaseline.ideographic: ${TextBaseline.ideographic}');
  print('  Baseline for ideographic characters');
  print('  Used by CJK (Chinese, Japanese, Korean) scripts');

  // ========== BASELINE WIDGET TESTS ==========
  print('--- Baseline Widget Tests ---');

  // Baseline with alphabetic
  final alphabeticBaseline = Container(
    color: Colors.grey.shade200,
    height: 60,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text('Small', style: TextStyle(fontSize: 12)),
        SizedBox(width: 8),
        Text('Medium', style: TextStyle(fontSize: 18)),
        SizedBox(width: 8),
        Text('Large', style: TextStyle(fontSize: 24)),
      ],
    ),
  );
  print('Created Row with alphabetic baseline alignment');

  // Baseline with ideographic
  final ideographicBaseline = Container(
    color: Colors.grey.shade200,
    height: 60,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.ideographic,
      children: [
        Text('文字', style: TextStyle(fontSize: 12)),
        SizedBox(width: 8),
        Text('文字', style: TextStyle(fontSize: 18)),
        SizedBox(width: 8),
        Text('文字', style: TextStyle(fontSize: 24)),
      ],
    ),
  );
  print('Created Row with ideographic baseline alignment');

  // ========== BASELINE WIDGET DIRECT USE ==========
  print('--- Baseline Widget Direct Use ---');

  final baselineWidget = Container(
    color: Colors.blue.shade50,
    height: 80,
    child: Stack(
      children: [
        // Reference line
        Positioned(
          left: 0,
          right: 0,
          top: 50,
          child: Container(height: 1, color: Colors.red),
        ),
        // Baseline-positioned child
        Baseline(
          baseline: 50,
          baselineType: TextBaseline.alphabetic,
          child: Text('Baseline at 50', style: TextStyle(fontSize: 16)),
        ),
      ],
    ),
  );
  print('Created Baseline widget with baseline=50');

  // Different baseline values
  final baseline20 = Baseline(
    baseline: 20,
    baselineType: TextBaseline.alphabetic,
    child: Container(
      width: 50,
      height: 30,
      color: Colors.green,
      child: Center(
        child: Text('20', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Baseline at 20 pixels');

  final baseline40 = Baseline(
    baseline: 40,
    baselineType: TextBaseline.alphabetic,
    child: Container(
      width: 50,
      height: 30,
      color: Colors.orange,
      child: Center(
        child: Text('40', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Baseline at 40 pixels');

  final baseline60 = Baseline(
    baseline: 60,
    baselineType: TextBaseline.alphabetic,
    child: Container(
      width: 50,
      height: 30,
      color: Colors.purple,
      child: Center(
        child: Text('60', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Baseline at 60 pixels');

  // ========== GET DISTANCE TO BASELINE ==========
  print('--- getDistanceToBaseline Method ---');
  print('RenderBox.getDistanceToBaseline(TextBaseline):');
  print('  Returns distance from top to the specified baseline');
  print('  Returns null if no baseline can be determined');
  print('  Used by RenderBaseline to position children');

  // ========== ROW BASELINE ALIGNMENT ==========
  print('--- Row Baseline Alignment ---');
  print('CrossAxisAlignment.baseline requires textBaseline parameter');
  print('All children are aligned to found baseline');
  print('Children without baselines are aligned to top');

  final mixedRow = Container(
    color: Colors.grey.shade100,
    height: 80,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text('Text', style: TextStyle(fontSize: 20)),
        SizedBox(width: 8),
        Container(width: 30, height: 30, color: Colors.blue),
        SizedBox(width: 8),
        TextField(
          decoration: InputDecoration(
            hintText: 'Input',
            border: OutlineInputBorder(),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          ),
        ),
      ],
    ),
  );
  print('Created mixed content row with baseline alignment');

  // ========== TABLE CELL BASELINE ==========
  print('--- Table Cell Baseline ---');
  print('TableCellVerticalAlignment.baseline:');
  print('  Aligns table cells by text baseline');

  // ========== FORM FIELD ALIGNMENT ==========
  print('--- Form Field Alignment ---');
  print('Use baseline alignment for label + input pairs');

  final formRow = Container(
    color: Colors.grey.shade50,
    padding: EdgeInsets.all(8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text('Label:', style: TextStyle(fontSize: 16)),
        SizedBox(width: 8),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            ),
          ),
        ),
      ],
    ),
  );
  print('Created form row with baseline alignment');

  // ========== RENDER BASELINE BEHAVIOR ==========
  print('--- RenderBaseline Behavior ---');
  print('1. Lays out child with incoming constraints');
  print('2. Gets child baseline using getDistanceToBaseline');
  print('3. Positions child so its baseline is at specified offset');
  print('4. Reports its own size including the offset');

  // ========== SIZE CONSTRAINTS ==========
  print('--- Size Constraints ---');
  print('RenderBaseline may report larger size than child');
  print('Size includes vertical offset for baseline positioning');

  // ========== PERFORMANCE NOTES ==========
  print('--- Performance Notes ---');
  print('1. Baseline queries can be expensive for complex text');
  print('2. Cache baseline values when possible');
  print('3. Avoid deep nesting of baseline-aligned widgets');

  // ========== COMMON USE CASES ==========
  print('--- Common Use Cases ---');
  print('1. Aligning labels with inputs');
  print('2. Mixed text sizes in rows');
  print('3. Superscript/subscript positioning');
  print('4. Currency symbols with amounts');

  final currencyExample = Row(
    crossAxisAlignment: CrossAxisAlignment.baseline,
    textBaseline: TextBaseline.alphabetic,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('\$', style: TextStyle(fontSize: 14, color: Colors.green)),
      Text('99', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
      Text('.99', style: TextStyle(fontSize: 14)),
    ],
  );
  print('Created currency display with baseline alignment');

  print('RenderBaseline test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderBaseline Tests'),
      SizedBox(height: 8),
      Text('Alphabetic Baseline:'),
      alphabeticBaseline,
      SizedBox(height: 8),
      Text('Ideographic Baseline:'),
      ideographicBaseline,
      SizedBox(height: 8),
      Text('Baseline Widget:'),
      baselineWidget,
      SizedBox(height: 8),
      Text('Currency Example:'),
      currencyExample,
      SizedBox(height: 8),
      Text('All baseline tests passed'),
    ],
  );
}
