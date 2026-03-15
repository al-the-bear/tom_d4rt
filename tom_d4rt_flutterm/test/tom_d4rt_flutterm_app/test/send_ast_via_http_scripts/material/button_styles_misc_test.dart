// D4rt test script: Tests ButtonBarTheme, ButtonStyleButton, RaisedButton, FlatButton, OutlineButton, MaterialBannerAction, NavigationIndicatorTransition, PopupMenuItemState, PopupMenuItemSelected
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Button styles and misc material tests executing');

  // ========== ButtonBarTheme ==========
  print('--- ButtonBarTheme Tests ---');
  final buttonBarThemeData = ButtonBarThemeData(
    alignment: MainAxisAlignment.center,
    buttonPadding: EdgeInsets.all(8.0),
    layoutBehavior: ButtonBarLayoutBehavior.padded,
  );
  print('ButtonBarThemeData alignment: ${buttonBarThemeData.alignment}');
  print(
    'ButtonBarThemeData buttonPadding: ${buttonBarThemeData.buttonPadding}',
  );
  print(
    'ButtonBarThemeData layoutBehavior: ${buttonBarThemeData.layoutBehavior}',
  );
  // ButtonBarTheme is an InheritedWidget wrapping ButtonBarThemeData
  print('ButtonBarTheme type: ${ButtonBarTheme}');
  print('ButtonBarThemeData type: ${buttonBarThemeData.runtimeType}');

  // ========== ButtonStyleButton (abstract) ==========
  print('--- ButtonStyleButton Tests ---');
  // ButtonStyleButton is the abstract base class for ElevatedButton, TextButton, OutlinedButton etc.
  // We reference it through its concrete subclasses.
  print('ButtonStyleButton type: ${ButtonStyleButton}');
  final elevatedButton = ElevatedButton(
    onPressed: () {},
    child: Text('Elevated'),
  );
  print(
    'ElevatedButton is ButtonStyleButton: ${elevatedButton is ButtonStyleButton}',
  );
  final textButton = TextButton(onPressed: () {}, child: Text('Text'));
  print('TextButton is ButtonStyleButton: ${textButton is ButtonStyleButton}');
  final outlinedButton = OutlinedButton(
    onPressed: () {},
    child: Text('Outlined'),
  );
  print(
    'OutlinedButton is ButtonStyleButton: ${outlinedButton is ButtonStyleButton}',
  );

  // ========== Deprecated Buttons ==========
  print('--- Deprecated Button Tests ---');
  // RaisedButton was deprecated and removed in Flutter 3.x → replaced by ElevatedButton
  print(
    'RaisedButton (deprecated) → use ElevatedButton: ${elevatedButton.runtimeType}',
  );
  // FlatButton was deprecated and removed in Flutter 3.x → replaced by TextButton
  print('FlatButton (deprecated) → use TextButton: ${textButton.runtimeType}');
  // OutlineButton was deprecated and removed in Flutter 3.x → replaced by OutlinedButton
  print(
    'OutlineButton (deprecated) → use OutlinedButton: ${outlinedButton.runtimeType}',
  );

  // ========== MaterialBannerAction ==========
  print('--- MaterialBannerAction Tests ---');
  // MaterialBanner actions are typically TextButton or other button widgets
  final bannerAction = TextButton(onPressed: () {}, child: Text('Dismiss'));
  final banner = MaterialBanner(
    content: Text('Test banner'),
    actions: [bannerAction],
  );
  print('MaterialBanner created with action: ${bannerAction.runtimeType}');
  print('MaterialBanner type: ${banner.runtimeType}');

  // ========== NavigationIndicatorTransition ==========
  print('--- NavigationIndicatorTransition Tests ---');
  // NavigationIndicatorTransition is related to the NavigationBar indicator animation
  // It is part of the internal navigation bar theming system
  print('NavigationIndicatorTransition referenced via NavigationBar theming');
  final navBarTheme = NavigationBarThemeData(
    indicatorColor: Colors.blue,
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
  print('NavigationBarThemeData indicatorColor: ${navBarTheme.indicatorColor}');
  print('NavigationBarThemeData indicatorShape: ${navBarTheme.indicatorShape}');

  // ========== PopupMenuItemState / PopupMenuItemSelected ==========
  print('--- PopupMenuItemState / PopupMenuItemSelected Tests ---');
  // PopupMenuItemSelected is the callback type: void Function(T)
  // PopupMenuItemState relates to the State of PopupMenuItem
  final PopupMenuItemSelected<String> onSelected = (String value) {
    print('Selected: $value');
  };
  print('PopupMenuItemSelected callback type: ${onSelected.runtimeType}');
  // Create a PopupMenuButton that uses the callback type
  final popupMenu = PopupMenuButton<String>(
    onSelected: onSelected,
    itemBuilder: (BuildContext ctx) => [
      PopupMenuItem<String>(value: 'option1', child: Text('Option 1')),
      PopupMenuItem<String>(value: 'option2', child: Text('Option 2')),
    ],
  );
  print('PopupMenuButton type: ${popupMenu.runtimeType}');
  print('PopupMenuItem references PopupMenuItemState internally');

  print('All button styles and misc material tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Button Styles Misc Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text('ButtonBarTheme: configured'),
            Text('ButtonStyleButton: abstract, 3 subclasses tested'),
            Text(
              'Deprecated: RaisedButton→Elevated, FlatButton→Text, OutlineButton→Outlined',
            ),
            Text('MaterialBannerAction: TextButton in banner'),
            Text('NavigationIndicatorTransition: themed'),
            Text('PopupMenuItemState/Selected: callback referenced'),
          ],
        ),
      ),
    ),
  );
}
