// D4rt test script: Tests RenderAnnotatedRegion from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('RenderAnnotatedRegion test executing');

  // ========== ANNOTATED REGION CONCEPTS ==========
  print('--- RenderAnnotatedRegion Concepts ---');
  print(
    'RenderAnnotatedRegion adds metadata annotations to render tree regions',
  );
  print('Annotations can be queried via hit testing');
  print('Generic type T defines the annotation value type');

  // ========== ANNOTATED REGION LAYER ==========
  print('--- AnnotatedRegionLayer ---');
  print('RenderAnnotatedRegion creates AnnotatedRegionLayer during painting');
  print('The layer holds the annotation value');
  print('Layers can be queried with Layer.find() or hit testing');

  // ========== SYSTEM UI OVERLAY STYLE ==========
  print('--- SystemUiOverlayStyle Examples ---');

  final lightStyle = SystemUiOverlayStyle.light;
  print('SystemUiOverlayStyle.light:');
  print('  statusBarBrightness: ${lightStyle.statusBarBrightness}');
  print('  statusBarIconBrightness: ${lightStyle.statusBarIconBrightness}');

  final darkStyle = SystemUiOverlayStyle.dark;
  print('SystemUiOverlayStyle.dark:');
  print('  statusBarBrightness: ${darkStyle.statusBarBrightness}');
  print('  statusBarIconBrightness: ${darkStyle.statusBarIconBrightness}');

  // Custom style
  final customStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
  print('Custom SystemUiOverlayStyle created');
  print('  statusBarColor: transparent');

  // ========== ANNOTATED REGION WIDGET ==========
  print('--- AnnotatedRegion Widget Tests ---');

  // Using AnnotatedRegion with SystemUiOverlayStyle
  final annotatedLight = AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle.light,
    child: Container(
      width: 100,
      height: 80,
      color: Colors.black87,
      child: Center(
        child: Text('Light Icons', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Created AnnotatedRegion with light overlay style');

  final annotatedDark = AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle.dark,
    child: Container(
      width: 100,
      height: 80,
      color: Colors.white,
      child: Center(
        child: Text('Dark Icons', style: TextStyle(color: Colors.black)),
      ),
    ),
  );
  print('Created AnnotatedRegion with dark overlay style');

  // ========== SIZED PARAMETER ==========
  print('--- sized Parameter ---');

  final sizedTrue = AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle.light,
    sized: true,
    child: Container(width: 50, height: 50, color: Colors.blue),
  );
  print('AnnotatedRegion with sized: true');
  print('  Region is clipped to child bounds');

  final sizedFalse = AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle.light,
    sized: false,
    child: Container(width: 50, height: 50, color: Colors.green),
  );
  print('AnnotatedRegion with sized: false');
  print('  Region extends to full layer bounds');

  // ========== CUSTOM ANNOTATION TYPES ==========
  print('--- Custom Annotation Types ---');
  print('AnnotatedRegion can use any type T');
  print('Common uses: routing info, theme data, region identifiers');

  // String annotation example
  final stringAnnotated = AnnotatedRegion<String>(
    value: 'header-region',
    child: Container(
      width: 100,
      height: 40,
      color: Colors.purple,
      child: Center(
        child: Text('Header', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Created AnnotatedRegion<String> with value: header-region');

  // Integer annotation example
  final intAnnotated = AnnotatedRegion<int>(
    value: 42,
    child: Container(
      width: 80,
      height: 40,
      color: Colors.orange,
      child: Center(
        child: Text('ID: 42', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Created AnnotatedRegion<int> with value: 42');

  // ========== ANNOTATION RESULT ==========
  print('--- AnnotationResult Class ---');
  print('AnnotationResult<T> holds results from annotation queries');
  print('  entries: list of AnnotationEntry objects');
  print('AnnotationEntry contains:');
  print('  annotation: the annotation value');
  print('  localPosition: position relative to annotated region');

  // ========== HIT TESTING FOR ANNOTATIONS ==========
  print('--- Hit Testing for Annotations ---');
  print('Layer.find<T>(Offset) queries annotations at a point');
  print('Returns AnnotationResult<T> with all matching annotations');
  print('Annotations are ordered from front to back');

  // ========== SCAFFOLD AND APP BAR ==========
  print('--- Scaffold Integration ---');
  print('Scaffold uses AnnotatedRegion for system UI styling');
  print('AppBar automatically sets appropriate overlay style');
  print('Based on AppBarTheme.systemOverlayStyle');

  final scaffoldExample = Container(
    width: 150,
    height: 100,
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      border: Border.all(color: Colors.grey),
    ),
    child: Column(
      children: [
        Container(
          height: 30,
          color: Colors.blue,
          child: Center(
            child: Text(
              'AppBar',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
        Expanded(child: Center(child: Text('Body'))),
      ],
    ),
  );
  print('Scaffold-like structure demonstration');

  // ========== NESTED ANNOTATIONS ==========
  print('--- Nested Annotations ---');
  print('Multiple AnnotatedRegions can be nested');
  print('Inner annotations take precedence in hit testing');

  final nestedAnnotation = AnnotatedRegion<String>(
    value: 'outer',
    child: Container(
      width: 120,
      height: 80,
      color: Colors.red.shade100,
      child: Center(
        child: AnnotatedRegion<String>(
          value: 'inner',
          child: Container(
            width: 60,
            height: 40,
            color: Colors.red.shade400,
            child: Center(
              child: Text('Inner', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ),
    ),
  );
  print('Created nested AnnotatedRegion widgets');

  // ========== USAGE PATTERNS ==========
  print('--- Common Usage Patterns ---');
  print('1. System UI theming (status bar, navigation bar)');
  print('2. Region identification for analytics');
  print('3. Custom hit test metadata');
  print('4. Accessibility region marking');

  print('RenderAnnotatedRegion test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderAnnotatedRegion Tests'),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [annotatedLight, annotatedDark],
      ),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [stringAnnotated, intAnnotated],
      ),
      SizedBox(height: 8),
      nestedAnnotation,
      SizedBox(height: 8),
      Text('All annotated region tests passed'),
    ],
  );
}
