// D4rt test script: Tests ColorProperty from painting
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ColorProperty test executing');
  final results = <String>[];

  // ========== Basic ColorProperty Tests ==========
  print('Testing ColorProperty constructor...');

  // Test 1: Create ColorProperty with standard color
  final colorProp1 = ColorProperty('backgroundColor', Color(0xFFFF0000));
  assert(colorProp1.name == 'backgroundColor', 'Name should match');
  assert(colorProp1.value == Color(0xFFFF0000), 'Value should match');
  results.add(
    'ColorProperty: name=${colorProp1.name}, value=${colorProp1.value}',
  );
  print('ColorProperty created: ${colorProp1.name}');

  // Test 2: Create ColorProperty with null value
  final colorProp2 = ColorProperty('foregroundColor', null);
  assert(colorProp2.name == 'foregroundColor', 'Name should match');
  assert(colorProp2.value == null, 'Value should be null');
  results.add(
    'ColorProperty null: name=${colorProp2.name}, value=${colorProp2.value}',
  );
  print('Null ColorProperty created');

  // Test 3: Create ColorProperty with defaultValue
  final colorProp3 = ColorProperty(
    'borderColor',
    Color(0xFF00FF00),
    defaultValue: Color(0xFF00FF00),
  );
  results.add('ColorProperty with default: ${colorProp3.name}');
  print('ColorProperty with default created');

  // Test 4: Create ColorProperty with showName false
  final colorProp4 = ColorProperty(
    'highlightColor',
    Color(0xFF0000FF),
    showName: false,
  );
  results.add('ColorProperty showName=false: ${colorProp4.name}');
  print('ColorProperty showName false');

  // ========== Multiple Color Tests ==========
  print('Testing multiple colors...');

  final testColors = [
    {'name': 'red', 'color': Color(0xFFFF0000), 'hex': 'FF0000'},
    {'name': 'green', 'color': Color(0xFF00FF00), 'hex': '00FF00'},
    {'name': 'blue', 'color': Color(0xFF0000FF), 'hex': '0000FF'},
    {'name': 'white', 'color': Color(0xFFFFFFFF), 'hex': 'FFFFFF'},
    {'name': 'black', 'color': Color(0xFF000000), 'hex': '000000'},
    {'name': 'transparent', 'color': Color(0x00000000), 'hex': '00000000'},
  ];

  for (final tc in testColors) {
    final prop = ColorProperty(tc['name'] as String, tc['color'] as Color);
    assert(prop.value == tc['color'], 'Color value should match');
    results.add('Color ${tc['name']}: #${tc['hex']}');
    print('Color ${tc['name']} property created');
  }

  // ========== DiagnosticsProperty Methods ==========
  print('Testing DiagnosticsProperty methods...');

  // Test toDescription
  final descProp = ColorProperty('testColor', Color(0xFFABCDEF));
  final description = descProp.toDescription();
  results.add('toDescription(): $description');
  print('Description: $description');

  // Test toString
  final stringRep = descProp.toString();
  results.add('toString(): ${stringRep.length} chars');
  print('String representation created');

  // ========== DiagnosticLevel Tests ==========
  print('Testing diagnostic levels...');

  final levels = [
    DiagnosticLevel.hidden,
    DiagnosticLevel.fine,
    DiagnosticLevel.debug,
    DiagnosticLevel.info,
    DiagnosticLevel.warning,
    DiagnosticLevel.error,
  ];

  for (final level in levels) {
    final prop = ColorProperty('levelColor', Color(0xFFFF00FF), level: level);
    results.add('Level ${level.name}: created');
    print('Level ${level.name} property created');
  }

  // ========== Alpha Channel Tests ==========
  print('Testing alpha channel...');

  final alphaValues = [0, 64, 128, 192, 255];
  for (final alpha in alphaValues) {
    final color = Color.fromARGB(alpha, 255, 0, 0);
    final prop = ColorProperty('alpha$alpha', color);
    final alphaPercent = (alpha / 255 * 100).toStringAsFixed(0);
    results.add('Alpha $alpha (${alphaPercent}%): ${prop.value}');
    print('Alpha $alpha: $color');
  }

  // ========== Color Manipulation ==========
  print('Testing color values...');

  final baseColor = Color(0xFFABCDEF);
  results.add('Base color: ${baseColor.toString()}');
  results.add('Alpha: ${baseColor.alpha}');
  results.add('Red: ${baseColor.red}');
  results.add('Green: ${baseColor.green}');
  results.add('Blue: ${baseColor.blue}');
  print('Color components extracted');

  // Test withAlpha
  final withAlpha = baseColor.withAlpha(128);
  results.add('withAlpha(128): ${withAlpha.alpha}');
  print('withAlpha: ${withAlpha.alpha}');

  // Test withOpacity
  final withOpacity = baseColor.withOpacity(0.5);
  results.add('withOpacity(0.5): alpha=${withOpacity.alpha}');
  print('withOpacity: ${withOpacity.alpha}');

  // ========== ColorProperty Style Options ==========
  print('Testing style options...');

  // Test with style
  final styledProp = ColorProperty(
    'styledColor',
    Color(0xFFFF5500),
    style: DiagnosticsTreeStyle.singleLine,
  );
  results.add('DiagnosticsTreeStyle.singleLine applied');
  print('Style applied');

  // ========== isFiltered Test ==========
  print('Testing isFiltered behavior...');

  final filterableProp = ColorProperty(
    'filterableColor',
    Color(0xFF123456),
    level: DiagnosticLevel.fine,
  );
  results.add('Filterable property level: ${filterableProp.level}');
  print('Filterable level: ${filterableProp.level}');

  // ========== Edge Cases ==========
  print('Testing edge cases...');

  // Empty name
  final emptyNameProp = ColorProperty('', Color(0xFFFFFFFF));
  results.add('Empty name property: ${emptyNameProp.name.isEmpty}');
  print('Empty name: ${emptyNameProp.name.isEmpty}');

  // Very long name
  final longName = 'a' * 50;
  final longNameProp = ColorProperty(longName, Color(0xFF000000));
  results.add('Long name (${longName.length} chars) property created');
  print('Long name property created');

  print('ColorProperty test completed: ${results.length} tests passed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'ColorProperty Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      Text('Total tests: ${results.length}', style: TextStyle(fontSize: 14)),
      Divider(),
      ...results.map(
        (r) => Padding(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Text(r, style: TextStyle(fontSize: 11)),
        ),
      ),
    ],
  );
}
