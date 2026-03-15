// D4rt test script: Tests CupertinoAlertDialog, CupertinoActionSheet, CupertinoDialogAction from cupertino
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino dialog test executing');

  // ========== CUPERTINOALERTDIALOG ==========
  print('--- CupertinoAlertDialog Tests ---');

  // Test basic CupertinoAlertDialog
  final basicDialog = CupertinoAlertDialog(
    title: Text('Alert'),
    content: Text('This is an alert message.'),
    actions: [CupertinoDialogAction(child: Text('OK'), onPressed: () {})],
  );
  print('Basic CupertinoAlertDialog created');

  // Test CupertinoAlertDialog with multiple actions
  final multiActionDialog = CupertinoAlertDialog(
    title: Text('Confirm'),
    content: Text('Are you sure you want to proceed?'),
    actions: [
      CupertinoDialogAction(child: Text('Cancel'), onPressed: () {}),
      CupertinoDialogAction(child: Text('Confirm'), onPressed: () {}),
    ],
  );
  print('CupertinoAlertDialog with multiple actions created');

  // Test CupertinoAlertDialog with destructive action
  final destructiveDialog = CupertinoAlertDialog(
    title: Text('Delete Item'),
    content: Text('This action cannot be undone.'),
    actions: [
      CupertinoDialogAction(child: Text('Cancel'), onPressed: () {}),
      CupertinoDialogAction(
        isDestructiveAction: true,
        child: Text('Delete'),
        onPressed: () {},
      ),
    ],
  );
  print('CupertinoAlertDialog with destructive action created');

  // Test CupertinoAlertDialog with default action
  final defaultActionDialog = CupertinoAlertDialog(
    title: Text('Save Changes'),
    content: Text('Do you want to save your changes?'),
    actions: [
      CupertinoDialogAction(child: Text("Don't Save"), onPressed: () {}),
      CupertinoDialogAction(
        isDefaultAction: true,
        child: Text('Save'),
        onPressed: () {},
      ),
    ],
  );
  print('CupertinoAlertDialog with default action created');

  // Test CupertinoAlertDialog with scrollable content
  final scrollableDialog = CupertinoAlertDialog(
    title: Text('Terms and Conditions'),
    content: SingleChildScrollView(
      child: Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
        'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
        'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
      ),
    ),
    actions: [
      CupertinoDialogAction(child: Text('Decline'), onPressed: () {}),
      CupertinoDialogAction(child: Text('Accept'), onPressed: () {}),
    ],
  );
  print('CupertinoAlertDialog with scrollable content created');

  // Test CupertinoAlertDialog without title
  final noTitleDialog = CupertinoAlertDialog(
    content: Text('Message without title'),
    actions: [CupertinoDialogAction(child: Text('OK'), onPressed: () {})],
  );
  print('CupertinoAlertDialog without title created');

  // Test CupertinoAlertDialog without content
  final noContentDialog = CupertinoAlertDialog(
    title: Text('Notification'),
    actions: [CupertinoDialogAction(child: Text('Dismiss'), onPressed: () {})],
  );
  print('CupertinoAlertDialog without content created');

  // Test CupertinoAlertDialog with insetAnimationDuration
  final animatedDialog = CupertinoAlertDialog(
    insetAnimationDuration: Duration(milliseconds: 200),
    title: Text('Animated'),
    content: Text('With custom animation duration'),
    actions: [CupertinoDialogAction(child: Text('OK'), onPressed: () {})],
  );
  print('CupertinoAlertDialog with insetAnimationDuration created');

  // Test CupertinoAlertDialog with insetAnimationCurve
  final curvedDialog = CupertinoAlertDialog(
    insetAnimationCurve: Curves.easeInOut,
    title: Text('Curved'),
    content: Text('With custom animation curve'),
    actions: [CupertinoDialogAction(child: Text('OK'), onPressed: () {})],
  );
  print('CupertinoAlertDialog with insetAnimationCurve created');

  // ========== CUPERTINODIALOGACTION ==========
  print('--- CupertinoDialogAction Tests ---');

  // Test basic CupertinoDialogAction
  final basicAction = CupertinoDialogAction(
    child: Text('Action'),
    onPressed: () {
      print('Action pressed');
    },
  );
  print('Basic CupertinoDialogAction created');

  // Test CupertinoDialogAction with isDefaultAction
  final defaultAction = CupertinoDialogAction(
    isDefaultAction: true,
    child: Text('Default'),
    onPressed: () {},
  );
  print('CupertinoDialogAction with isDefaultAction created');

  // Test CupertinoDialogAction with isDestructiveAction
  final destructiveAction = CupertinoDialogAction(
    isDestructiveAction: true,
    child: Text('Delete'),
    onPressed: () {},
  );
  print('CupertinoDialogAction with isDestructiveAction created');

  // Test CupertinoDialogAction with textStyle
  final styledAction = CupertinoDialogAction(
    textStyle: TextStyle(fontSize: 18.0),
    child: Text('Styled'),
    onPressed: () {},
  );
  print('CupertinoDialogAction with textStyle created');

  // Test CupertinoDialogAction disabled
  final disabledAction = CupertinoDialogAction(
    child: Text('Disabled'),
    onPressed: null,
  );
  print('CupertinoDialogAction disabled created');

  // ========== CUPERTINOACTIONSHEET ==========
  print('--- CupertinoActionSheet Tests ---');

  // Test basic CupertinoActionSheet
  final basicActionSheet = CupertinoActionSheet(
    actions: [
      CupertinoActionSheetAction(child: Text('Action 1'), onPressed: () {}),
      CupertinoActionSheetAction(child: Text('Action 2'), onPressed: () {}),
    ],
  );
  print('Basic CupertinoActionSheet created');

  // Test CupertinoActionSheet with title
  final titledActionSheet = CupertinoActionSheet(
    title: Text('Select Option'),
    actions: [
      CupertinoActionSheetAction(child: Text('Option 1'), onPressed: () {}),
      CupertinoActionSheetAction(child: Text('Option 2'), onPressed: () {}),
    ],
  );
  print('CupertinoActionSheet with title created');

  // Test CupertinoActionSheet with message
  final messageActionSheet = CupertinoActionSheet(
    title: Text('Share Photo'),
    message: Text('Choose how you want to share this photo'),
    actions: [
      CupertinoActionSheetAction(
        child: Text('Share to Instagram'),
        onPressed: () {},
      ),
      CupertinoActionSheetAction(
        child: Text('Share to Twitter'),
        onPressed: () {},
      ),
      CupertinoActionSheetAction(child: Text('Copy Link'), onPressed: () {}),
    ],
  );
  print('CupertinoActionSheet with message created');

  // Test CupertinoActionSheet with cancelButton
  final cancelButtonActionSheet = CupertinoActionSheet(
    title: Text('Options'),
    actions: [
      CupertinoActionSheetAction(child: Text('Save'), onPressed: () {}),
      CupertinoActionSheetAction(child: Text('Share'), onPressed: () {}),
    ],
    cancelButton: CupertinoActionSheetAction(
      child: Text('Cancel'),
      onPressed: () {},
    ),
  );
  print('CupertinoActionSheet with cancelButton created');

  // Test CupertinoActionSheet with destructive action
  final destructiveActionSheet = CupertinoActionSheet(
    title: Text('Delete Photo'),
    message: Text('This action cannot be undone'),
    actions: [
      CupertinoActionSheetAction(
        isDestructiveAction: true,
        child: Text('Delete'),
        onPressed: () {},
      ),
    ],
    cancelButton: CupertinoActionSheetAction(
      child: Text('Cancel'),
      onPressed: () {},
    ),
  );
  print('CupertinoActionSheet with destructive action created');

  // Test CupertinoActionSheet with default action
  final defaultActionSheet = CupertinoActionSheet(
    title: Text('Save Document'),
    actions: [
      CupertinoActionSheetAction(
        isDefaultAction: true,
        child: Text('Save'),
        onPressed: () {},
      ),
      CupertinoActionSheetAction(child: Text('Save As...'), onPressed: () {}),
    ],
    cancelButton: CupertinoActionSheetAction(
      child: Text('Cancel'),
      onPressed: () {},
    ),
  );
  print('CupertinoActionSheet with default action created');

  // ========== CUPERTINOACTIONSHEETACTION ==========
  print('--- CupertinoActionSheetAction Tests ---');

  // Test basic CupertinoActionSheetAction
  final basicSheetAction = CupertinoActionSheetAction(
    child: Text('Action'),
    onPressed: () {
      print('Sheet action pressed');
    },
  );
  print('Basic CupertinoActionSheetAction created');

  // Test CupertinoActionSheetAction with isDefaultAction
  final defaultSheetAction = CupertinoActionSheetAction(
    isDefaultAction: true,
    child: Text('Default Action'),
    onPressed: () {},
  );
  print('CupertinoActionSheetAction with isDefaultAction created');

  // Test CupertinoActionSheetAction with isDestructiveAction
  final destructiveSheetAction = CupertinoActionSheetAction(
    isDestructiveAction: true,
    child: Text('Delete'),
    onPressed: () {},
  );
  print('CupertinoActionSheetAction with isDestructiveAction created');

  // ========== CUPERTINOPOPUPSURFACE ==========
  print('--- CupertinoPopupSurface Tests ---');

  // Test basic CupertinoPopupSurface
  final basicPopupSurface = CupertinoPopupSurface(
    child: Padding(padding: EdgeInsets.all(16.0), child: Text('Popup content')),
  );
  print('Basic CupertinoPopupSurface created');

  // Test CupertinoPopupSurface with isSurfacePainted
  final paintedPopupSurface = CupertinoPopupSurface(
    isSurfacePainted: true,
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Text('Painted surface'),
    ),
  );
  print('CupertinoPopupSurface with isSurfacePainted created');

  // Test CupertinoPopupSurface not painted
  final unpaintedPopupSurface = CupertinoPopupSurface(
    isSurfacePainted: false,
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Text('Unpainted surface'),
    ),
  );
  print('CupertinoPopupSurface with isSurfacePainted=false created');

  print('Cupertino dialog test completed');

  // Return a visual representation
  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Dialog Tests')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Alert Dialog Preview:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemGrey4),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: basicDialog,
              ),

              SizedBox(height: 24.0),
              Text(
                'Destructive Dialog Preview:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemGrey4),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: destructiveDialog,
              ),

              SizedBox(height: 24.0),
              Text(
                'Action Sheet Preview:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemGrey4),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: cancelButtonActionSheet,
              ),

              SizedBox(height: 24.0),
              Text(
                'Popup Surface Preview:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemGrey4),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: paintedPopupSurface,
              ),

              SizedBox(height: 24.0),
              Text(
                'Tests Completed:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text('• CupertinoAlertDialog'),
              Text('• CupertinoDialogAction'),
              Text('• CupertinoActionSheet'),
              Text('• CupertinoActionSheetAction'),
              Text('• CupertinoPopupSurface'),
            ],
          ),
        ),
      ),
    ),
  );
}
