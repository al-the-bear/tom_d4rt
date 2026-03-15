// D4rt test script: Tests CupertinoColors, CupertinoDynamicColor,
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// CupertinoThemeData advanced, CupertinoTextThemeData,
// CupertinoIconThemeData, CupertinoSystemColors, CupertinoSlidingSegmentedControl,
// CupertinoSegmentedControl
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Cupertino colors and system test executing');

  // ========== CupertinoColors ==========
  print('--- CupertinoColors Tests ---');
  final colors = {
    'activeBlue': CupertinoColors.activeBlue,
    'activeGreen': CupertinoColors.activeGreen,
    'activeOrange': CupertinoColors.activeOrange,
    'white': CupertinoColors.white,
    'black': CupertinoColors.black,
    'lightBackgroundGray': CupertinoColors.lightBackgroundGray,
    'extraLightBackgroundGray': CupertinoColors.extraLightBackgroundGray,
    'darkBackgroundGray': CupertinoColors.darkBackgroundGray,
    'inactiveGray': CupertinoColors.inactiveGray,
    'destructiveRed': CupertinoColors.destructiveRed,
    'systemBlue': CupertinoColors.systemBlue,
    'systemGreen': CupertinoColors.systemGreen,
    'systemIndigo': CupertinoColors.systemIndigo,
    'systemOrange': CupertinoColors.systemOrange,
    'systemPink': CupertinoColors.systemPink,
    'systemPurple': CupertinoColors.systemPurple,
    'systemRed': CupertinoColors.systemRed,
    'systemTeal': CupertinoColors.systemTeal,
    'systemYellow': CupertinoColors.systemYellow,
  };
  for (final entry in colors.entries) {
    print('  CupertinoColors.${entry.key}: ${entry.value}');
  }

  // ========== CupertinoColors system grays ==========
  print('--- CupertinoColors Grays ---');
  final grays = {
    'systemGrey': CupertinoColors.systemGrey,
    'systemGrey2': CupertinoColors.systemGrey2,
    'systemGrey3': CupertinoColors.systemGrey3,
    'systemGrey4': CupertinoColors.systemGrey4,
    'systemGrey5': CupertinoColors.systemGrey5,
    'systemGrey6': CupertinoColors.systemGrey6,
  };
  for (final entry in grays.entries) {
    print('  CupertinoColors.${entry.key}: ${entry.value}');
  }

  // ========== CupertinoColors semantic ==========
  print('--- CupertinoColors Semantic ---');
  final semantic = {
    'label': CupertinoColors.label,
    'secondaryLabel': CupertinoColors.secondaryLabel,
    'tertiaryLabel': CupertinoColors.tertiaryLabel,
    'quaternaryLabel': CupertinoColors.quaternaryLabel,
    'systemFill': CupertinoColors.systemFill,
    'secondarySystemFill': CupertinoColors.secondarySystemFill,
    'tertiarySystemFill': CupertinoColors.tertiarySystemFill,
    'quaternarySystemFill': CupertinoColors.quaternarySystemFill,
    'placeholderText': CupertinoColors.placeholderText,
    'systemBackground': CupertinoColors.systemBackground,
    'secondarySystemBackground': CupertinoColors.secondarySystemBackground,
    'tertiarySystemBackground': CupertinoColors.tertiarySystemBackground,
    'systemGroupedBackground': CupertinoColors.systemGroupedBackground,
    'secondarySystemGroupedBackground':
        CupertinoColors.secondarySystemGroupedBackground,
    'tertiarySystemGroupedBackground':
        CupertinoColors.tertiarySystemGroupedBackground,
    'separator': CupertinoColors.separator,
    'opaqueSeparator': CupertinoColors.opaqueSeparator,
    'link': CupertinoColors.link,
  };
  for (final entry in semantic.entries) {
    print('  CupertinoColors.${entry.key}: ${entry.value}');
  }

  // ========== CupertinoDynamicColor ==========
  print('--- CupertinoDynamicColor Tests ---');
  final dynamicColor = CupertinoDynamicColor.withBrightness(
    color: Color(0xFF000000),
    darkColor: Color(0xFFFFFFFF),
  );
  print('CupertinoDynamicColor.withBrightness created');

  final dynamicColor2 = CupertinoDynamicColor(
    color: Color(0xFF000000),
    darkColor: Color(0xFFFFFFFF),
    highContrastColor: Color(0xFF000000),
    darkHighContrastColor: Color(0xFFFFFFFF),
    elevatedColor: Color(0xFF222222),
    darkElevatedColor: Color(0xFFDDDDDD),
    highContrastElevatedColor: Color(0xFF111111),
    darkHighContrastElevatedColor: Color(0xFFEEEEEE),
  );
  print('CupertinoDynamicColor full created');

  // ========== CupertinoThemeData advanced ==========
  print('--- CupertinoThemeData Advanced Tests ---');
  final cupertinoTheme = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: CupertinoColors.activeBlue,
    primaryContrastingColor: CupertinoColors.white,
    scaffoldBackgroundColor: CupertinoColors.systemBackground,
    barBackgroundColor: CupertinoColors.systemBackground,
    applyThemeToAll: true,
    textTheme: CupertinoTextThemeData(
      primaryColor: CupertinoColors.activeBlue,
      textStyle: TextStyle(fontSize: 17, color: CupertinoColors.label),
      actionTextStyle: TextStyle(
        fontSize: 17,
        color: CupertinoColors.activeBlue,
      ),
      tabLabelTextStyle: TextStyle(fontSize: 10),
      navTitleTextStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
      navLargeTitleTextStyle: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.bold,
      ),
      navActionTextStyle: TextStyle(
        fontSize: 17,
        color: CupertinoColors.activeBlue,
      ),
      pickerTextStyle: TextStyle(fontSize: 21),
      dateTimePickerTextStyle: TextStyle(fontSize: 21),
    ),
  );
  print('CupertinoThemeData created');
  print('  brightness: ${cupertinoTheme.brightness}');
  print('  primaryColor: ${cupertinoTheme.primaryColor}');

  // ========== CupertinoTextThemeData ==========
  print('--- CupertinoTextThemeData Tests ---');
  final textTheme = cupertinoTheme.textTheme;
  print('CupertinoTextThemeData accessed');
  print('  textStyle: ${textTheme.textStyle}');
  print('  actionTextStyle: ${textTheme.actionTextStyle}');
  print('  navTitleTextStyle: ${textTheme.navTitleTextStyle}');

  // ========== CupertinoSlidingSegmentedControl ==========
  print('--- CupertinoSlidingSegmentedControl Tests ---');
  final slidingSegmented = CupertinoSlidingSegmentedControl<int>(
    groupValue: 0,
    onValueChanged: (value) => print('  Sliding segment: $value'),
    children: {
      0: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text('First'),
      ),
      1: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text('Second'),
      ),
      2: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text('Third'),
      ),
    },
    thumbColor: CupertinoColors.white,
    backgroundColor: CupertinoColors.systemGrey5,
    padding: EdgeInsets.all(2),
  );
  print('CupertinoSlidingSegmentedControl created');

  // ========== CupertinoSegmentedControl ==========
  print('--- CupertinoSegmentedControl Tests ---');
  final segmentedControl = CupertinoSegmentedControl<int>(
    groupValue: 0,
    onValueChanged: (value) => print('  Segment: $value'),
    children: {0: Text('One'), 1: Text('Two'), 2: Text('Three')},
    selectedColor: CupertinoColors.activeBlue,
    unselectedColor: CupertinoColors.white,
    borderColor: CupertinoColors.activeBlue,
    pressedColor: CupertinoColors.systemGrey4,
    padding: EdgeInsets.symmetric(horizontal: 16),
  );
  print('CupertinoSegmentedControl created');

  print('All cupertino colors/system tests passed');

  // ========== RETURN WIDGET ==========
  return CupertinoApp(
    theme: cupertinoTheme,
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Colors')),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16),
            slidingSegmented,
            SizedBox(height: 16),
            segmentedControl,
          ],
        ),
      ),
    ),
  );
}
