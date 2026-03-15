// D4rt test script: Tests TextTheme, Typography — material text styling
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Material text theme test executing');

  // ========== TextTheme ==========
  print('--- TextTheme Tests ---');

  final textTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 57.0, fontWeight: FontWeight.w400),
    displayMedium: TextStyle(fontSize: 45.0, fontWeight: FontWeight.w400),
    displaySmall: TextStyle(fontSize: 36.0, fontWeight: FontWeight.w400),
    headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w400),
    headlineMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w400),
    headlineSmall: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
    titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
    titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
    titleSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
    labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
    labelMedium: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),
    labelSmall: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w500),
  );
  print('TextTheme displayLarge fontSize: ${textTheme.displayLarge!.fontSize}');
  print('TextTheme bodyMedium fontSize: ${textTheme.bodyMedium!.fontSize}');
  print('TextTheme labelSmall fontSize: ${textTheme.labelSmall!.fontSize}');

  // TextTheme copyWith
  final modified = textTheme.copyWith(
    bodyLarge: TextStyle(fontSize: 18.0, color: Colors.blue),
  );
  print(
    'TextTheme copyWith bodyLarge fontSize: ${modified.bodyLarge!.fontSize}',
  );

  // TextTheme apply
  final applied = textTheme.apply(fontSizeFactor: 1.2, bodyColor: Colors.red);
  print(
    'TextTheme apply fontSizeFactor 1.2 displayLarge: ${applied.displayLarge!.fontSize}',
  );

  // TextTheme merge
  final merged = textTheme.merge(
    TextTheme(bodyLarge: TextStyle(color: Colors.green)),
  );
  print('TextTheme merged bodyLarge color: ${merged.bodyLarge!.color}');

  // ========== Typography ==========
  print('--- Typography Tests ---');

  final typography = Typography.material2021();
  print(
    'Typography.material2021 black bodyMedium: ${typography.black.bodyMedium}',
  );
  print(
    'Typography.material2021 white bodyMedium: ${typography.white.bodyMedium}',
  );

  final typographyEn = Typography.material2021(
    platform: TargetPlatform.android,
  );
  print(
    'Typography.material2021 (android) englishLike bodyLarge: ${typographyEn.englishLike.bodyLarge}',
  );

  final typographyOld = Typography.material2018();
  print(
    'Typography.material2018 black bodyMedium: ${typographyOld.black.bodyMedium}',
  );

  // ========== VisualDensity ==========
  print('--- VisualDensity Tests ---');

  final vdStandard = VisualDensity.standard;
  print(
    'VisualDensity.standard horizontal: ${vdStandard.horizontal}, vertical: ${vdStandard.vertical}',
  );

  final vdCompact = VisualDensity.compact;
  print(
    'VisualDensity.compact horizontal: ${vdCompact.horizontal}, vertical: ${vdCompact.vertical}',
  );

  final vdComfortable = VisualDensity.comfortable;
  print(
    'VisualDensity.comfortable horizontal: ${vdComfortable.horizontal}, vertical: ${vdComfortable.vertical}',
  );

  final vdAdaptive = VisualDensity.adaptivePlatformDensity;
  print(
    'VisualDensity.adaptivePlatformDensity: h=${vdAdaptive.horizontal}, v=${vdAdaptive.vertical}',
  );

  final vdCustom = VisualDensity(horizontal: -2.0, vertical: 1.0);
  print(
    'VisualDensity custom effectiveConstraints: ${vdCustom.effectiveConstraints(BoxConstraints(minWidth: 48.0, minHeight: 48.0))}',
  );

  // ========== MaterialTapTargetSize ==========
  print('--- MaterialTapTargetSize Tests ---');

  print('MaterialTapTargetSize.padded: ${MaterialTapTargetSize.padded}');
  print(
    'MaterialTapTargetSize.shrinkWrap: ${MaterialTapTargetSize.shrinkWrap}',
  );

  print('All material text theme tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Material Text Theme Test', style: textTheme.headlineMedium),
            SizedBox(height: 8.0),
            Text('displayLarge', style: textTheme.displayLarge),
            Text('headlineMedium', style: textTheme.headlineMedium),
            Text('titleLarge', style: textTheme.titleLarge),
            Text('bodyLarge', style: textTheme.bodyLarge),
            Text('bodyMedium', style: textTheme.bodyMedium),
            Text('labelSmall', style: textTheme.labelSmall),
            SizedBox(height: 16.0),
            Text(
              'VisualDensity standard: ${vdStandard.horizontal}x${vdStandard.vertical}',
            ),
            Text(
              'VisualDensity compact: ${vdCompact.horizontal}x${vdCompact.vertical}',
            ),
          ],
        ),
      ),
    ),
  );
}
