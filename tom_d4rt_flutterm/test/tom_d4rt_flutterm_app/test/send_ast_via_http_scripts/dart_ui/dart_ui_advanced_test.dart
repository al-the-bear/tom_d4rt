// D4rt test script: Tests dart:ui SemanticsAction, SemanticsFlag,
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// FontFeature, FontVariation, Locale (advanced), PlatformDispatcher concepts,
// LocaleStringAttribute, SpellOutStringAttribute
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

dynamic build(BuildContext context) {
  print('dart:ui advanced test executing');

  // ========== SemanticsAction ==========
  print('--- SemanticsAction Tests ---');
  final actions = <String, ui.SemanticsAction>{
    'tap': ui.SemanticsAction.tap,
    'longPress': ui.SemanticsAction.longPress,
    'scrollLeft': ui.SemanticsAction.scrollLeft,
    'scrollRight': ui.SemanticsAction.scrollRight,
    'scrollUp': ui.SemanticsAction.scrollUp,
    'scrollDown': ui.SemanticsAction.scrollDown,
    'increase': ui.SemanticsAction.increase,
    'decrease': ui.SemanticsAction.decrease,
    'showOnScreen': ui.SemanticsAction.showOnScreen,
    'dismiss': ui.SemanticsAction.dismiss,
    'copy': ui.SemanticsAction.copy,
    'cut': ui.SemanticsAction.cut,
    'paste': ui.SemanticsAction.paste,
    'setText': ui.SemanticsAction.setText,
    'focus': ui.SemanticsAction.focus,
  };
  for (final entry in actions.entries) {
    print('SemanticsAction.${entry.key}: ${entry.value.index}');
  }

  // ========== SemanticsFlag ==========
  print('--- SemanticsFlag Tests ---');
  final flags = <String, ui.SemanticsFlag>{
    'hasCheckedState': ui.SemanticsFlag.hasCheckedState,
    'isChecked': ui.SemanticsFlag.isChecked,
    'isSelected': ui.SemanticsFlag.isSelected,
    'isButton': ui.SemanticsFlag.isButton,
    'isTextField': ui.SemanticsFlag.isTextField,
    'isFocused': ui.SemanticsFlag.isFocused,
    'hasEnabledState': ui.SemanticsFlag.hasEnabledState,
    'isEnabled': ui.SemanticsFlag.isEnabled,
    'isReadOnly': ui.SemanticsFlag.isReadOnly,
    'isHeader': ui.SemanticsFlag.isHeader,
    'isHidden': ui.SemanticsFlag.isHidden,
    'isImage': ui.SemanticsFlag.isImage,
    'isLink': ui.SemanticsFlag.isLink,
    'isSlider': ui.SemanticsFlag.isSlider,
    'isKeyboardKey': ui.SemanticsFlag.isKeyboardKey,
  };
  for (final entry in flags.entries) {
    print('SemanticsFlag.${entry.key}: ${entry.value.index}');
  }

  // ========== FontFeature ==========
  print('--- FontFeature Tests ---');
  final features = <ui.FontFeature>[
    ui.FontFeature('liga'),
    ui.FontFeature('smcp'),
    ui.FontFeature.enable('kern'),
    ui.FontFeature.disable('liga'),
    ui.FontFeature.tabularFigures(),
    ui.FontFeature.oldstyleFigures(),
    ui.FontFeature.proportionalFigures(),
    ui.FontFeature.slashedZero(),
  ];
  for (final f in features) {
    print('FontFeature: ${f.feature} = ${f.value}');
  }

  // ========== FontVariation ==========
  print('--- FontVariation Tests ---');
  final variations = <ui.FontVariation>[
    ui.FontVariation('wght', 400),
    ui.FontVariation('wdth', 100),
    ui.FontVariation('ital', 1),
    ui.FontVariation.weight(700),
    ui.FontVariation.italic(1.0),
    ui.FontVariation.width(125),
  ];
  for (final v in variations) {
    print('FontVariation: ${v.axis} = ${v.value}');
  }

  // ========== Locale advanced ==========
  print('--- Locale advanced Tests ---');
  final locales = <Locale>[
    Locale('en', 'US'),
    Locale('de', 'DE'),
    Locale('ja', 'JP'),
    Locale('zh', 'CN'),
    Locale('ar', 'SA'),
    Locale.fromSubtags(
      languageCode: 'zh',
      scriptCode: 'Hant',
      countryCode: 'TW',
    ),
  ];
  for (final loc in locales) {
    print(
      'Locale: ${loc.toLanguageTag()} (lang=${loc.languageCode}, country=${loc.countryCode})',
    );
  }

  // ========== TextDecoration advanced ==========
  print('--- TextDecoration Tests ---');
  final decorations = <String, TextDecoration>{
    'none': TextDecoration.none,
    'underline': TextDecoration.underline,
    'overline': TextDecoration.overline,
    'lineThrough': TextDecoration.lineThrough,
  };
  for (final entry in decorations.entries) {
    print('TextDecoration.${entry.key}');
  }
  final combined = TextDecoration.combine([
    TextDecoration.underline,
    TextDecoration.overline,
  ]);
  print('Combined decoration: $combined');

  print('All dart:ui advanced tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'dart:ui Advanced Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text('SemanticsAction: ${actions.length} values'),
            Text('SemanticsFlag: ${flags.length} values'),
            Text('FontFeature: ${features.length} features'),
            Text('FontVariation: ${variations.length} variations'),
            Text('Locales: ${locales.length} tested'),
            SizedBox(height: 16.0),
            Text(
              'Font Features Demo',
              style: TextStyle(
                fontSize: 24.0,
                fontFeatures: [ui.FontFeature.tabularFigures()],
                fontVariations: [ui.FontVariation.weight(600)],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
