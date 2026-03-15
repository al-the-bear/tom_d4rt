// D4rt test script: Tests SystemUiOverlayStyle, TextEditingDelta concepts from services
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Services text boundary / overlay style test executing');

  // ========== SYSTEMUIOVERLAYSTYLE ==========
  print('--- SystemUiOverlayStyle Tests ---');

  final style1 = SystemUiOverlayStyle(
    statusBarColor: Color(0xFF000000),
    statusBarBrightness: Brightness.dark,
  );
  print('SystemUiOverlayStyle created');
  print('  statusBarColor: ${style1.statusBarColor}');
  print('  statusBarBrightness: ${style1.statusBarBrightness}');
  print('  runtimeType: ${style1.runtimeType}');

  final style2 = SystemUiOverlayStyle(
    statusBarColor: Color(0xFFFFFFFF),
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Color(0xFF000000),
    systemNavigationBarDividerColor: Color(0xFF333333),
    systemNavigationBarIconBrightness: Brightness.light,
  );
  print('Full SystemUiOverlayStyle:');
  print('  statusBarColor: ${style2.statusBarColor}');
  print('  statusBarBrightness: ${style2.statusBarBrightness}');
  print('  statusBarIconBrightness: ${style2.statusBarIconBrightness}');
  print('  systemNavigationBarColor: ${style2.systemNavigationBarColor}');
  print(
    '  systemNavigationBarDividerColor: ${style2.systemNavigationBarDividerColor}',
  );
  print(
    '  systemNavigationBarIconBrightness: ${style2.systemNavigationBarIconBrightness}',
  );

  // Predefined styles
  final light = SystemUiOverlayStyle.light;
  print('SystemUiOverlayStyle.light:');
  print('  statusBarBrightness: ${light.statusBarBrightness}');
  print('  statusBarIconBrightness: ${light.statusBarIconBrightness}');

  final dark = SystemUiOverlayStyle.dark;
  print('SystemUiOverlayStyle.dark:');
  print('  statusBarBrightness: ${dark.statusBarBrightness}');
  print('  statusBarIconBrightness: ${dark.statusBarIconBrightness}');

  // copyWith
  final modified = light.copyWith(statusBarColor: Color(0xFF4CAF50));
  print('light.copyWith(statusBarColor: green):');
  print('  statusBarColor: ${modified.statusBarColor}');
  print('  statusBarBrightness: ${modified.statusBarBrightness}');

  // ========== TEXTEDITINGDELTA ==========
  print('--- TextEditingDelta Tests ---');

  // TextEditingDeltaInsertion
  final insertion = TextEditingDeltaInsertion(
    oldText: 'Hello',
    textInserted: ' World',
    insertionOffset: 5,
    selection: TextSelection.collapsed(offset: 11),
    composing: TextRange.empty,
  );
  print('TextEditingDeltaInsertion:');
  print('  oldText: "${insertion.oldText}"');
  print('  textInserted: "${insertion.textInserted}"');
  print('  insertionOffset: ${insertion.insertionOffset}');
  print('  runtimeType: ${insertion.runtimeType}');

  // TextEditingDeltaDeletion
  final deletion = TextEditingDeltaDeletion(
    oldText: 'Hello World',
    deletedRange: TextRange(start: 5, end: 11),
    selection: TextSelection.collapsed(offset: 5),
    composing: TextRange.empty,
  );
  print('TextEditingDeltaDeletion:');
  print('  oldText: "${deletion.oldText}"');
  print('  deletedRange: ${deletion.deletedRange}');
  print('  runtimeType: ${deletion.runtimeType}');

  // TextEditingDeltaReplacement
  final replacement = TextEditingDeltaReplacement(
    oldText: 'Hello World',
    replacementText: 'Dart',
    replacedRange: TextRange(start: 6, end: 11),
    selection: TextSelection.collapsed(offset: 10),
    composing: TextRange.empty,
  );
  print('TextEditingDeltaReplacement:');
  print('  oldText: "${replacement.oldText}"');
  print('  replacementText: "${replacement.replacementText}"');
  print('  replacedRange: ${replacement.replacedRange}');
  print('  runtimeType: ${replacement.runtimeType}');

  // TextEditingDeltaNonTextUpdate
  final nonTextUpdate = TextEditingDeltaNonTextUpdate(
    oldText: 'Hello',
    selection: TextSelection(baseOffset: 0, extentOffset: 5),
    composing: TextRange.empty,
  );
  print('TextEditingDeltaNonTextUpdate:');
  print('  oldText: "${nonTextUpdate.oldText}"');
  print('  runtimeType: ${nonTextUpdate.runtimeType}');

  // ========== TEXTSELECTION ==========
  print('--- TextSelection Tests ---');

  final sel1 = TextSelection(baseOffset: 0, extentOffset: 5);
  print('TextSelection(0, 5):');
  print('  baseOffset: ${sel1.baseOffset}');
  print('  extentOffset: ${sel1.extentOffset}');
  print('  isCollapsed: ${sel1.isCollapsed}');
  print('  isDirectional: ${sel1.isDirectional}');

  final collapsed = TextSelection.collapsed(offset: 3);
  print('TextSelection.collapsed(3):');
  print('  baseOffset: ${collapsed.baseOffset}');
  print('  isCollapsed: ${collapsed.isCollapsed}');

  final fromPosition = TextSelection.fromPosition(TextPosition(offset: 7));
  print('TextSelection.fromPosition(7): offset=${fromPosition.baseOffset}');

  // ========== RETURN WIDGET ==========
  print('Services text boundary / overlay style test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Services Text Boundary Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text(
            'Classes Tested:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• SystemUiOverlayStyle - status/nav bar style'),
          Text('• TextEditingDeltaInsertion - text insert delta'),
          Text('• TextEditingDeltaDeletion - text delete delta'),
          Text('• TextEditingDeltaReplacement - text replace delta'),
          Text('• TextEditingDeltaNonTextUpdate - selection delta'),
          Text('• TextSelection - text selection range'),
          SizedBox(height: 16.0),

          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFE8F5E9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Overlay Styles:'),
                Text('  light brightness: ${light.statusBarBrightness}'),
                Text('  dark brightness: ${dark.statusBarBrightness}'),
                SizedBox(height: 8.0),
                Text('TextSelection(0,5) collapsed: ${sel1.isCollapsed}'),
                Text('TextSelection.collapsed(3): ${collapsed.isCollapsed}'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
