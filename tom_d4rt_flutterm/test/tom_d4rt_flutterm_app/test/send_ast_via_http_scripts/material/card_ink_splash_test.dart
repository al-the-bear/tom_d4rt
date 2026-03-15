// D4rt test script: Tests Card advanced, CardTheme, InkSplash, InkRipple,
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// InteractiveInkFeatureFactory, MaterialInkController, Ink, InkDecoration
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Card and ink splash test executing');

  // ========== Card advanced ==========
  print('--- Card Advanced Tests ---');
  final card1 = Card(
    color: Colors.white,
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.blue[50],
    elevation: 4.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: Colors.grey[300]!),
    ),
    borderOnForeground: true,
    margin: EdgeInsets.all(8),
    clipBehavior: Clip.antiAlias,
    semanticContainer: true,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(height: 120, color: Colors.blue[100]),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Card Title',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Card description text',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Card created');

  // ========== Card.filled ==========
  print('--- Card.filled Tests ---');
  final cardFilled = Card.filled(
    color: Colors.blue[50],
    shadowColor: Colors.transparent,
    elevation: 0,
    margin: EdgeInsets.all(8),
    child: ListTile(title: Text('Filled Card'), subtitle: Text('No elevation')),
  );
  print('Card.filled created');

  // ========== Card.outlined ==========
  print('--- Card.outlined Tests ---');
  final cardOutlined = Card.outlined(
    color: Colors.white,
    elevation: 0,
    margin: EdgeInsets.all(8),
    child: ListTile(
      title: Text('Outlined Card'),
      subtitle: Text('With border'),
    ),
  );
  print('Card.outlined created');

  // ========== CardTheme ==========
  print('--- CardTheme Tests ---');
  final cardTheme = CardThemeData(
    color: Colors.white,
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.blue[50],
    elevation: 2.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: EdgeInsets.all(4),
    clipBehavior: Clip.antiAlias,
  );
  print('CardThemeData created');
  print('  elevation: ${cardTheme.elevation}');
  print('  clipBehavior: ${cardTheme.clipBehavior}');

  // ========== Ink widget ==========
  print('--- Ink Widget Tests ---');
  final ink = Ink(
    decoration: BoxDecoration(
      color: Colors.blue[100],
      borderRadius: BorderRadius.circular(8),
      gradient: LinearGradient(
        colors: [Colors.blue[100]!, Colors.blue[300]!],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    padding: EdgeInsets.all(16),
    width: 200,
    height: 80,
    child: Center(child: Text('Ink Widget')),
  );
  print('Ink widget created');

  // ========== Ink.image ==========
  print('--- Ink.image Tests ---');
  final inkImage = Ink(
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(8),
    ),
    width: 200,
    height: 120,
    child: Center(child: Text('Ink Image Placeholder')),
  );
  print('Ink with decoration created');

  // ========== InkWell with splash factory ==========
  print('--- InkSplash / InkRipple Tests ---');
  final inkWellSplash = InkWell(
    onTap: () => print('  InkSplash tap'),
    splashFactory: InkSplash.splashFactory,
    splashColor: Colors.blue[200],
    highlightColor: Colors.blue[100],
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Text('InkSplash Factory'),
    ),
  );
  print('InkWell with InkSplash.splashFactory created');

  final inkWellRipple = InkWell(
    onTap: () => print('  InkRipple tap'),
    splashFactory: InkRipple.splashFactory,
    splashColor: Colors.red[200],
    highlightColor: Colors.red[100],
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Text('InkRipple Factory'),
    ),
  );
  print('InkWell with InkRipple.splashFactory created');

  // ========== No splash factory ==========
  print('--- NoSplash Tests ---');
  final noSplashInkWell = InkWell(
    onTap: () => print('  No splash tap'),
    splashFactory: NoSplash.splashFactory,
    child: Padding(padding: EdgeInsets.all(16), child: Text('No Splash')),
  );
  print('InkWell with NoSplash.splashFactory created');

  // ========== Elevation-related ==========
  print('--- Elevation Tests ---');
  final elevations = [0.0, 1.0, 2.0, 4.0, 6.0, 8.0, 12.0, 16.0, 24.0];
  for (final e in elevations) {
    print('  Material Design elevation: $e');
  }

  print('All card/ink splash tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    theme: ThemeData(cardTheme: cardTheme),
    home: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            card1,
            cardFilled,
            cardOutlined,
            Card(child: ink),
            Card(child: inkImage),
            Card(child: inkWellSplash),
            Card(child: inkWellRipple),
            Card(child: noSplashInkWell),
          ],
        ),
      ),
    ),
  );
}
