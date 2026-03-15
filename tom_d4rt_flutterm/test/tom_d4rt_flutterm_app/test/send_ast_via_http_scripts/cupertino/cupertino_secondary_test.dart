// D4rt test script: Tests CupertinoColors, CupertinoDynamicColor,
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// CupertinoDialogAction, CupertinoActionSheetAction, CupertinoPopupSurface,
// CupertinoFormRow, CupertinoScrollbar, CupertinoListTileChevron
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Cupertino secondary widgets test executing');

  // ========== CupertinoColors ==========
  print('--- CupertinoColors Tests ---');

  print('CupertinoColors.activeBlue: ${CupertinoColors.activeBlue}');
  print('CupertinoColors.activeGreen: ${CupertinoColors.activeGreen}');
  print('CupertinoColors.activeOrange: ${CupertinoColors.activeOrange}');
  print('CupertinoColors.white: ${CupertinoColors.white}');
  print('CupertinoColors.black: ${CupertinoColors.black}');
  print(
    'CupertinoColors.lightBackgroundGray: ${CupertinoColors.lightBackgroundGray}',
  );
  print(
    'CupertinoColors.extraLightBackgroundGray: ${CupertinoColors.extraLightBackgroundGray}',
  );
  print(
    'CupertinoColors.darkBackgroundGray: ${CupertinoColors.darkBackgroundGray}',
  );
  print('CupertinoColors.inactiveGray: ${CupertinoColors.inactiveGray}');
  print('CupertinoColors.destructiveRed: ${CupertinoColors.destructiveRed}');

  // System colors
  print('CupertinoColors.systemBlue: ${CupertinoColors.systemBlue}');
  print('CupertinoColors.systemGreen: ${CupertinoColors.systemGreen}');
  print('CupertinoColors.systemIndigo: ${CupertinoColors.systemIndigo}');
  print('CupertinoColors.systemOrange: ${CupertinoColors.systemOrange}');
  print('CupertinoColors.systemPink: ${CupertinoColors.systemPink}');
  print('CupertinoColors.systemPurple: ${CupertinoColors.systemPurple}');
  print('CupertinoColors.systemRed: ${CupertinoColors.systemRed}');
  print('CupertinoColors.systemTeal: ${CupertinoColors.systemTeal}');
  print('CupertinoColors.systemYellow: ${CupertinoColors.systemYellow}');

  // ========== CupertinoDynamicColor ==========
  print('--- CupertinoDynamicColor Tests ---');

  final dynamicColor = CupertinoDynamicColor.withBrightness(
    color: Color(0xFF000000),
    darkColor: Color(0xFFFFFFFF),
  );
  print('CupertinoDynamicColor created');
  print('CupertinoDynamicColor color: ${dynamicColor.color}');
  print('CupertinoDynamicColor darkColor: ${dynamicColor.darkColor}');

  final dynamicFull = CupertinoDynamicColor(
    color: Color(0xFF000000),
    darkColor: Color(0xFFFFFFFF),
    highContrastColor: Color(0xFF111111),
    darkHighContrastColor: Color(0xFFEEEEEE),
    elevatedColor: Color(0xFF222222),
    darkElevatedColor: Color(0xFFDDDDDD),
    highContrastElevatedColor: Color(0xFF333333),
    darkHighContrastElevatedColor: Color(0xFFCCCCCC),
  );
  print('CupertinoDynamicColor full: color=${dynamicFull.color}');

  // ========== CupertinoDialogAction ==========
  print('--- CupertinoDialogAction Tests ---');

  final dialogAction = CupertinoDialogAction(
    child: Text('OK'),
    isDefaultAction: true,
    isDestructiveAction: false,
    onPressed: () => print('OK pressed'),
  );
  print(
    'CupertinoDialogAction isDefaultAction: ${dialogAction.isDefaultAction}',
  );
  print(
    'CupertinoDialogAction isDestructiveAction: ${dialogAction.isDestructiveAction}',
  );

  final destructiveAction = CupertinoDialogAction(
    child: Text('Delete'),
    isDefaultAction: false,
    isDestructiveAction: true,
    onPressed: () => print('Delete pressed'),
  );
  print(
    'CupertinoDialogAction destructive: ${destructiveAction.isDestructiveAction}',
  );

  // ========== CupertinoActionSheetAction ==========
  print('--- CupertinoActionSheetAction Tests ---');

  final actionSheetAction = CupertinoActionSheetAction(
    child: Text('Share'),
    isDefaultAction: true,
    isDestructiveAction: false,
    onPressed: () => print('Share pressed'),
  );
  print(
    'CupertinoActionSheetAction isDefaultAction: ${actionSheetAction.isDefaultAction}',
  );

  // ========== CupertinoFormRow ==========
  print('--- CupertinoFormRow Tests ---');

  final formRow = CupertinoFormRow(
    prefix: Text('Name'),
    helper: Text('Enter your name'),
    error: null,
    child: CupertinoTextField(placeholder: 'John Doe'),
  );
  print('CupertinoFormRow created');

  print('All cupertino secondary widgets tests passed');

  // ========== RETURN WIDGET ==========
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Cupertino Secondary Test'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              CupertinoListSection(
                header: Text('Cupertino Colors'),
                children: [
                  CupertinoListTile(
                    title: Text('System Blue'),
                    trailing: Container(
                      width: 24.0,
                      height: 24.0,
                      color: CupertinoColors.systemBlue,
                    ),
                  ),
                  CupertinoListTile(
                    title: Text('System Red'),
                    trailing: Container(
                      width: 24.0,
                      height: 24.0,
                      color: CupertinoColors.systemRed,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              formRow,
            ],
          ),
        ),
      ),
    ),
  );
}
