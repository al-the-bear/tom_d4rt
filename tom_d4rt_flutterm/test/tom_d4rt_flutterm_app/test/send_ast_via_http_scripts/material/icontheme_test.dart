// D4rt test script: Tests IconTheme, IconThemeData from material
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IconTheme test executing');

  // ========== ICONTHEMEDATA ==========
  print('--- IconThemeData Tests ---');

  // Test basic IconThemeData
  final basicIconTheme = IconThemeData();
  print('Basic IconThemeData created');

  // Test IconThemeData with color
  final coloredIconTheme = IconThemeData(color: Colors.blue);
  print('IconThemeData with color created');

  // Test IconThemeData with opacity
  final opacityIconTheme = IconThemeData(opacity: 0.5);
  print('IconThemeData with opacity created');

  // Test IconThemeData with size
  final sizedIconTheme = IconThemeData(size: 32.0);
  print('IconThemeData with size created');

  // Test IconThemeData with fill
  final filledIconTheme = IconThemeData(fill: 1.0);
  print('IconThemeData with fill created');

  // Test IconThemeData with weight
  final weightedIconTheme = IconThemeData(weight: 700.0);
  print('IconThemeData with weight created');

  // Test IconThemeData with grade
  final gradedIconTheme = IconThemeData(grade: 200.0);
  print('IconThemeData with grade created');

  // Test IconThemeData with opticalSize
  final opticalIconTheme = IconThemeData(opticalSize: 48.0);
  print('IconThemeData with opticalSize created');

  // Test IconThemeData with shadows
  final shadowedIconTheme = IconThemeData(
    shadows: [
      Shadow(
        color: Colors.black.withOpacity(0.3),
        offset: Offset(2.0, 2.0),
        blurRadius: 4.0,
      ),
    ],
  );
  print('IconThemeData with shadows created');

  // Test IconThemeData with applyTextScaling
  final scaledIconTheme = IconThemeData(applyTextScaling: true);
  print('IconThemeData with applyTextScaling created');

  // Test IconThemeData with all properties
  final fullIconTheme = IconThemeData(
    color: Colors.purple,
    opacity: 0.8,
    size: 28.0,
    fill: 0.5,
    weight: 500.0,
    grade: 100.0,
    opticalSize: 40.0,
    shadows: [
      Shadow(
        color: Colors.purple.withOpacity(0.2),
        offset: Offset(1.0, 1.0),
        blurRadius: 2.0,
      ),
    ],
    applyTextScaling: false,
  );
  print('IconThemeData with all properties created');

  // Test IconThemeData copyWith
  final copiedIconTheme = fullIconTheme.copyWith(
    color: Colors.orange,
    size: 36.0,
  );
  print(
    'IconThemeData copyWith created: color=${copiedIconTheme.color}, size=${copiedIconTheme.size}',
  );

  // Test IconThemeData merge
  final baseTheme = IconThemeData(color: Colors.red, size: 24.0);
  final overrideTheme = IconThemeData(size: 32.0, opacity: 0.9);
  final mergedTheme = baseTheme.merge(overrideTheme);
  print(
    'IconThemeData merge: color=${mergedTheme.color}, size=${mergedTheme.size}, opacity=${mergedTheme.opacity}',
  );

  // Test IconThemeData resolve
  final resolvedTheme = IconThemeData(color: Colors.green).resolve(context);
  print('IconThemeData resolve: resolved=${resolvedTheme.color}');

  // Test IconThemeData isConcrete
  final concreteTheme = IconThemeData(
    color: Colors.blue,
    size: 24.0,
    opacity: 1.0,
  );
  print('IconThemeData isConcrete: ${concreteTheme.isConcrete}');

  // ========== ICONTHEME WIDGET ==========
  print('--- IconTheme Widget Tests ---');

  // Test basic IconTheme
  final basicIconThemeWidget = IconTheme(
    data: IconThemeData(color: Colors.blue, size: 24.0),
    child: Row(
      children: [Icon(Icons.home), Icon(Icons.settings), Icon(Icons.person)],
    ),
  );
  print('Basic IconTheme widget created');

  // Test IconTheme with large icons
  final largeIconThemeWidget = IconTheme(
    data: IconThemeData(color: Colors.red, size: 48.0),
    child: Row(
      children: [Icon(Icons.star), Icon(Icons.favorite), Icon(Icons.thumb_up)],
    ),
  );
  print('IconTheme with large icons created');

  // Test IconTheme with opacity
  final opacityIconThemeWidget = IconTheme(
    data: IconThemeData(color: Colors.green, size: 32.0, opacity: 0.5),
    child: Row(children: [Icon(Icons.visibility), Icon(Icons.visibility_off)]),
  );
  print('IconTheme with opacity created');

  // Test nested IconThemes
  final nestedIconThemeWidget = IconTheme(
    data: IconThemeData(color: Colors.blue, size: 32.0),
    child: Column(
      children: [
        Row(children: [Icon(Icons.cloud), Icon(Icons.sunny)]),
        IconTheme(
          data: IconThemeData(color: Colors.orange, size: 48.0),
          child: Row(children: [Icon(Icons.star), Icon(Icons.star_border)]),
        ),
      ],
    ),
  );
  print('Nested IconTheme widgets created');

  // Test IconTheme.merge
  final mergeIconThemeWidget = IconTheme.merge(
    data: IconThemeData(size: 36.0),
    child: Row(children: [Icon(Icons.add), Icon(Icons.remove)]),
  );
  print('IconTheme.merge created');

  // Test IconTheme.of
  // Note: IconTheme.of(context) would get the current theme
  print('IconTheme.of concept noted (requires actual widget tree context)');

  print('IconTheme test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'IconTheme Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text(
          'Basic IconTheme (blue, 24px):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        basicIconThemeWidget,

        SizedBox(height: 24.0),
        Text(
          'Large IconTheme (red, 48px):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        largeIconThemeWidget,

        SizedBox(height: 24.0),
        Text(
          'IconTheme with Opacity (green, 50%):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        opacityIconThemeWidget,

        SizedBox(height: 24.0),
        Text(
          'Nested IconThemes:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        nestedIconThemeWidget,

        SizedBox(height: 24.0),
        Text('IconTheme.merge:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        IconTheme(
          data: IconThemeData(color: Colors.purple),
          child: mergeIconThemeWidget,
        ),

        SizedBox(height: 24.0),
        Text(
          'Various Icon Sizes:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Row(
          children: [
            IconTheme(
              data: IconThemeData(size: 16.0, color: Colors.teal),
              child: Icon(Icons.circle),
            ),
            SizedBox(width: 8.0),
            IconTheme(
              data: IconThemeData(size: 24.0, color: Colors.teal),
              child: Icon(Icons.circle),
            ),
            SizedBox(width: 8.0),
            IconTheme(
              data: IconThemeData(size: 32.0, color: Colors.teal),
              child: Icon(Icons.circle),
            ),
            SizedBox(width: 8.0),
            IconTheme(
              data: IconThemeData(size: 48.0, color: Colors.teal),
              child: Icon(Icons.circle),
            ),
            SizedBox(width: 8.0),
            IconTheme(
              data: IconThemeData(size: 64.0, color: Colors.teal),
              child: Icon(Icons.circle),
            ),
          ],
        ),

        SizedBox(height: 24.0),
        Text(
          'Icon Colors via Theme:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Wrap(
          spacing: 16.0,
          runSpacing: 8.0,
          children: [
            IconTheme(
              data: IconThemeData(color: Colors.red, size: 32.0),
              child: Icon(Icons.favorite),
            ),
            IconTheme(
              data: IconThemeData(color: Colors.orange, size: 32.0),
              child: Icon(Icons.star),
            ),
            IconTheme(
              data: IconThemeData(color: Colors.yellow, size: 32.0),
              child: Icon(Icons.bolt),
            ),
            IconTheme(
              data: IconThemeData(color: Colors.green, size: 32.0),
              child: Icon(Icons.check_circle),
            ),
            IconTheme(
              data: IconThemeData(color: Colors.blue, size: 32.0),
              child: Icon(Icons.water_drop),
            ),
            IconTheme(
              data: IconThemeData(color: Colors.purple, size: 32.0),
              child: Icon(Icons.diamond),
            ),
          ],
        ),
      ],
    ),
  );
}
