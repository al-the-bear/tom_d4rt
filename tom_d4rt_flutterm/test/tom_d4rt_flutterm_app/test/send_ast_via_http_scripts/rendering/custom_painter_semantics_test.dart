// D4rt test script: Tests CustomPainterSemantics from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/semantics.dart';

dynamic build(BuildContext context) {
  print('CustomPainterSemantics test executing');
  final results = <String>[];

  // ========== Section 1: Basic Construction ==========
  print('--- Section 1: Basic Construction ---');

  final basic = CustomPainterSemantics(
    rect: Rect.fromLTWH(0, 0, 100, 50),
    properties: SemanticsProperties(label: 'Test label'),
  );
  print('Created basic CustomPainterSemantics');
  print('Rect: ${basic.rect}');
  results.add('Created with rect: ${basic.rect}');

  // ========== Section 2: With Key ==========
  print('--- Section 2: With Key ---');

  final withKey = CustomPainterSemantics(
    key: ValueKey('semantics-1'),
    rect: Rect.fromLTWH(10, 20, 80, 40),
    properties: SemanticsProperties(label: 'Keyed semantics'),
  );
  print('Created with key: ${withKey.key}');
  print('Key type: ${withKey.key.runtimeType}');
  results.add('Key: ${withKey.key}');

  // ========== Section 3: Transform ==========
  print('--- Section 3: Transform ---');

  final transform = Matrix4.identity()..translate(50.0, 25.0);
  final withTransform = CustomPainterSemantics(
    rect: Rect.fromLTWH(0, 0, 100, 100),
    transform: transform,
    properties: SemanticsProperties(label: 'Transformed'),
  );
  print('Created with transform');
  print('Has transform: ${withTransform.transform != null}');
  results.add('Has transform: ${withTransform.transform != null}');

  // ========== Section 4: Semantics Properties ==========
  print('--- Section 4: Semantics Properties ---');

  final propsSemantics = CustomPainterSemantics(
    rect: Rect.fromLTWH(0, 0, 200, 100),
    properties: SemanticsProperties(
      label: 'Button',
      hint: 'Tap to activate',
      button: true,
      enabled: true,
    ),
  );
  print('Properties label: ${propsSemantics.properties.label}');
  print('Properties hint: ${propsSemantics.properties.hint}');
  print('Is button: ${propsSemantics.properties.button}');
  results.add(
    'Properties: label=${propsSemantics.properties.label}, button=${propsSemantics.properties.button}',
  );

  // ========== Section 5: Multiple Semantics ==========
  print('--- Section 5: Multiple Semantics ---');

  final semanticsList = <CustomPainterSemantics>[
    CustomPainterSemantics(
      rect: Rect.fromLTWH(0, 0, 100, 50),
      properties: SemanticsProperties(label: 'Item 1'),
    ),
    CustomPainterSemantics(
      rect: Rect.fromLTWH(0, 50, 100, 50),
      properties: SemanticsProperties(label: 'Item 2'),
    ),
    CustomPainterSemantics(
      rect: Rect.fromLTWH(0, 100, 100, 50),
      properties: SemanticsProperties(label: 'Item 3'),
    ),
  ];

  print('Created ${semanticsList.length} semantics');
  for (var i = 0; i < semanticsList.length; i++) {
    print('  Item $i: rect=${semanticsList[i].rect}');
  }
  results.add('Multiple semantics: ${semanticsList.length} items');

  // ========== Section 6: Tags ==========
  print('--- Section 6: Tags ---');

  final tag1 = SemanticsTag('custom-tag-1');
  final tag2 = SemanticsTag('custom-tag-2');

  final taggedSemantics = CustomPainterSemantics(
    rect: Rect.fromLTWH(0, 0, 50, 50),
    tags: {tag1, tag2},
    properties: SemanticsProperties(label: 'Tagged'),
  );
  print('Created with tags');
  print('Tags count: ${taggedSemantics.tags?.length ?? 0}');
  results.add('Tags count: ${taggedSemantics.tags?.length ?? 0}');

  // ========== Section 7: Actions ==========
  print('--- Section 7: Actions ---');

  var tapCount = 0;
  final actionSemantics = CustomPainterSemantics(
    rect: Rect.fromLTWH(0, 0, 100, 40),
    properties: SemanticsProperties(
      label: 'Clickable',
      onTap: () {
        tapCount++;
        print('Tap action triggered');
      },
    ),
  );
  print('Created with onTap action');
  print('Has onTap: ${actionSemantics.properties.onTap != null}');
  results.add('Has onTap: ${actionSemantics.properties.onTap != null}');

  // ========== Section 8: Rect Properties ==========
  print('--- Section 8: Rect Properties ---');

  final rectTest = CustomPainterSemantics(
    rect: Rect.fromLTRB(10, 20, 110, 70),
    properties: SemanticsProperties(label: 'Rect test'),
  );
  print('Rect left: ${rectTest.rect.left}');
  print('Rect top: ${rectTest.rect.top}');
  print('Rect right: ${rectTest.rect.right}');
  print('Rect bottom: ${rectTest.rect.bottom}');
  print('Rect width: ${rectTest.rect.width}');
  print('Rect height: ${rectTest.rect.height}');
  results.add('Rect: ${rectTest.rect.width}x${rectTest.rect.height}');

  // ========== Section 9: Empty Properties ==========
  print('--- Section 9: Empty Properties ---');

  final emptyProps = CustomPainterSemantics(
    rect: Rect.fromLTWH(0, 0, 30, 30),
    properties: SemanticsProperties(),
  );
  print('Created with empty properties');
  print('Label is null: ${emptyProps.properties.label == null}');
  results.add('Empty props label: ${emptyProps.properties.label}');

  // ========== Section 10: Zero Rect ==========
  print('--- Section 10: Zero Rect ---');

  final zeroRect = CustomPainterSemantics(
    rect: Rect.zero,
    properties: SemanticsProperties(label: 'Zero rect'),
  );
  print('Zero rect: ${zeroRect.rect}');
  print('Is zero: ${zeroRect.rect == Rect.zero}');
  results.add('Zero rect: ${zeroRect.rect == Rect.zero}');

  print('CustomPainterSemantics test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'CustomPainterSemantics Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ...results.map(
            (r) => Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text('✓ $r', style: TextStyle(fontSize: 14)),
            ),
          ),
        ],
      ),
    ),
  );
}
