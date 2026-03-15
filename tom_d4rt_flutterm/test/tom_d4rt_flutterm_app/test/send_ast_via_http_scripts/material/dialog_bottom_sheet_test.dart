// D4rt test script: Tests Dialog advanced, AlertDialog advanced,
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// SimpleDialog, SimpleDialogOption, DialogThemeData, showDialog,
// showGeneralDialog, showAboutDialog, AboutDialog, LicensePage
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Dialog and bottom sheet test executing');

  // ========== AlertDialog advanced ==========
  print('--- AlertDialog Advanced Tests ---');
  final alertDialog = AlertDialog(
    title: Text('Alert Title'),
    titlePadding: EdgeInsets.fromLTRB(24, 24, 24, 0),
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Alert dialog content goes here.'),
        SizedBox(height: 16),
        TextField(decoration: InputDecoration(labelText: 'Input')),
      ],
    ),
    contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 0),
    contentTextStyle: TextStyle(fontSize: 16, color: Colors.black87),
    actions: [
      TextButton(onPressed: () {}, child: Text('Cancel')),
      ElevatedButton(onPressed: () {}, child: Text('OK')),
    ],
    actionsPadding: EdgeInsets.fromLTRB(24, 0, 24, 24),
    actionsAlignment: MainAxisAlignment.end,
    actionsOverflowAlignment: OverflowBarAlignment.end,
    actionsOverflowDirection: VerticalDirection.down,
    actionsOverflowButtonSpacing: 8.0,
    backgroundColor: Colors.white,
    elevation: 24.0,
    shadowColor: Colors.black54,
    surfaceTintColor: Colors.blue[50],
    insetPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 24),
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    alignment: Alignment.center,
    scrollable: false,
    icon: Icon(Icons.warning, color: Colors.orange, size: 48),
    iconPadding: EdgeInsets.only(top: 24),
    iconColor: Colors.orange,
  );
  print('AlertDialog advanced created');

  // ========== SimpleDialog ==========
  print('--- SimpleDialog Tests ---');
  final simpleDialog = SimpleDialog(
    title: Text('Select an option'),
    titlePadding: EdgeInsets.fromLTRB(24, 24, 24, 0),
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    children: [
      SimpleDialogOption(
        onPressed: () => print('  Option 1 selected'),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          children: [
            Icon(Icons.access_time, color: Colors.blue),
            SizedBox(width: 16),
            Text('Option 1'),
          ],
        ),
      ),
      SimpleDialogOption(
        onPressed: () => print('  Option 2 selected'),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          children: [
            Icon(Icons.audiotrack, color: Colors.green),
            SizedBox(width: 16),
            Text('Option 2'),
          ],
        ),
      ),
      SimpleDialogOption(
        onPressed: () => print('  Option 3 selected'),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          children: [
            Icon(Icons.map, color: Colors.red),
            SizedBox(width: 16),
            Text('Option 3'),
          ],
        ),
      ),
    ],
    contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 16),
    backgroundColor: Colors.white,
    elevation: 24.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    alignment: Alignment.center,
    insetPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 24),
  );
  print('SimpleDialog created');

  // ========== DialogThemeData ==========
  print('--- DialogThemeData Tests ---');
  final dialogTheme = DialogThemeData(
    backgroundColor: Colors.white,
    elevation: 24.0,
    shadowColor: Colors.black54,
    surfaceTintColor: Colors.blue[50],
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    alignment: Alignment.center,
    titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    contentTextStyle: TextStyle(fontSize: 16),
    actionsPadding: EdgeInsets.fromLTRB(24, 0, 24, 24),
    iconColor: Colors.blue,
    insetPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 24),
    clipBehavior: Clip.antiAlias,
  );
  print('DialogThemeData created');
  print('  elevation: ${dialogTheme.elevation}');

  // ========== AboutDialog ==========
  print('--- AboutDialog Tests ---');
  final aboutDialog = AboutDialog(
    applicationName: 'Test App',
    applicationVersion: '1.0.0',
    applicationIcon: Icon(Icons.apps, size: 48),
    applicationLegalese: '© 2024 Test Company',
    children: [
      SizedBox(height: 16),
      Text('Additional information about the app.'),
    ],
  );
  print('AboutDialog created');

  // ========== LicensePage ==========
  print('--- LicensePage Tests ---');
  final licensePage = LicensePage(
    applicationName: 'Test App',
    applicationVersion: '1.0.0',
    applicationIcon: Icon(Icons.apps, size: 48),
    applicationLegalese: '© 2024 Test Company',
  );
  print('LicensePage created');

  // ========== OverflowBarAlignment ==========
  print('--- OverflowBarAlignment Tests ---');
  for (final a in OverflowBarAlignment.values) {
    print('  OverflowBarAlignment.$a');
  }

  // ========== showModalBottomSheet concepts ==========
  print('--- ModalBottomSheet Concepts ---');
  final modalContent = Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 4,
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        ListTile(
          leading: Icon(Icons.share),
          title: Text('Share'),
          onTap: () => print('  Share tapped'),
        ),
        ListTile(
          leading: Icon(Icons.link),
          title: Text('Get Link'),
          onTap: () => print('  Get link tapped'),
        ),
        ListTile(
          leading: Icon(Icons.edit),
          title: Text('Edit'),
          onTap: () => print('  Edit tapped'),
        ),
        ListTile(
          leading: Icon(Icons.delete, color: Colors.red),
          title: Text('Delete', style: TextStyle(color: Colors.red)),
          onTap: () => print('  Delete tapped'),
        ),
      ],
    ),
  );
  print('Modal bottom sheet content created');

  // ========== showTimePicker / showDatePicker concepts ==========
  print('--- Picker Dialog Concepts ---');
  final datePicker = DatePickerDialog(
    initialDate: DateTime(2024, 1, 15),
    firstDate: DateTime(2020, 1, 1),
    lastDate: DateTime(2030, 12, 31),
    initialCalendarMode: DatePickerMode.day,
    initialEntryMode: DatePickerEntryMode.calendar,
  );
  print('DatePickerDialog created');

  print('All dialog / bottom sheet tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    theme: ThemeData(dialogTheme: dialogTheme),
    home: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            alertDialog,
            SizedBox(height: 16),
            simpleDialog,
            SizedBox(height: 16),
            modalContent,
          ],
        ),
      ),
    ),
  );
}
