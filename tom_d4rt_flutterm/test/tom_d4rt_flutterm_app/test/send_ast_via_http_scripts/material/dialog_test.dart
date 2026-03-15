// D4rt test script: Tests Dialog, AlertDialog, SimpleDialog, BottomSheet, SnackBar from material
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Dialog/Overlay widgets test executing');

  // ========== DIALOG ==========
  print('--- Dialog Tests ---');

  // Test basic Dialog
  final basicDialog = Dialog(
    child: Padding(padding: EdgeInsets.all(16.0), child: Text('Basic Dialog')),
  );
  print('Basic Dialog created');

  // Test Dialog with backgroundColor
  final coloredDialog = Dialog(
    backgroundColor: Colors.lightBlue.shade50,
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Text('Colored Dialog'),
    ),
  );
  print('Dialog with backgroundColor created');

  // Test Dialog with elevation
  final elevatedDialog = Dialog(
    elevation: 24.0,
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Text('Elevated Dialog'),
    ),
  );
  print('Dialog with elevation created');

  // Test Dialog with shape
  final shapedDialog = Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Text('Rounded Dialog'),
    ),
  );
  print('Dialog with shape created');

  // Test Dialog with insetPadding
  final insetDialog = Dialog(
    insetPadding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
    child: Padding(padding: EdgeInsets.all(16.0), child: Text('Inset Dialog')),
  );
  print('Dialog with insetPadding created');

  // Test Dialog.fullscreen
  final fullscreenDialog = Dialog.fullscreen(
    child: Center(child: Text('Fullscreen Dialog')),
  );
  print('Dialog.fullscreen created');

  // ========== ALERTDIALOG ==========
  print('--- AlertDialog Tests ---');

  // Test basic AlertDialog
  final basicAlert = AlertDialog(
    title: Text('Alert'),
    content: Text('This is an alert dialog.'),
  );
  print('Basic AlertDialog created');

  // Test AlertDialog with actions
  final actionAlert = AlertDialog(
    title: Text('Confirm'),
    content: Text('Are you sure?'),
    actions: [
      TextButton(
        onPressed: () {
          print('Cancel pressed');
        },
        child: Text('Cancel'),
      ),
      TextButton(
        onPressed: () {
          print('OK pressed');
        },
        child: Text('OK'),
      ),
    ],
  );
  print('AlertDialog with actions created');

  // Test AlertDialog with icon
  final iconAlert = AlertDialog(
    icon: Icon(Icons.warning, color: Colors.orange, size: 48.0),
    title: Text('Warning'),
    content: Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () {}, child: Text('Cancel')),
      TextButton(onPressed: () {}, child: Text('Delete')),
    ],
  );
  print('AlertDialog with icon created');

  // Test AlertDialog with backgroundColor
  final coloredAlert = AlertDialog(
    backgroundColor: Colors.amber.shade50,
    title: Text('Colored'),
    content: Text('Custom background color'),
  );
  print('AlertDialog with backgroundColor created');

  // Test AlertDialog with shape
  final shapedAlert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    title: Text('Rounded'),
    content: Text('Rounded corners'),
  );
  print('AlertDialog with shape created');

  // Test AlertDialog with elevation
  final elevatedAlert = AlertDialog(
    elevation: 32.0,
    title: Text('Elevated'),
    content: Text('High elevation'),
  );
  print('AlertDialog with elevation created');

  // Test AlertDialog with titlePadding
  final paddedAlert = AlertDialog(
    titlePadding: EdgeInsets.all(24.0),
    contentPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
    actionsPadding: EdgeInsets.all(8.0),
    title: Text('Custom Padding'),
    content: Text('Custom padding values'),
    actions: [TextButton(onPressed: () {}, child: Text('OK'))],
  );
  print('AlertDialog with custom padding created');

  // Test AlertDialog with actionsAlignment
  final alignedActionsAlert = AlertDialog(
    title: Text('Actions Alignment'),
    content: Text('Actions are centered'),
    actionsAlignment: MainAxisAlignment.center,
    actions: [
      TextButton(onPressed: () {}, child: Text('A')),
      TextButton(onPressed: () {}, child: Text('B')),
    ],
  );
  print('AlertDialog with actionsAlignment created');

  // Test AlertDialog with scrollable content
  final scrollableAlert = AlertDialog(
    title: Text('Scrollable'),
    content: SingleChildScrollView(
      child: Column(children: List.generate(10, (i) => Text('Item $i'))),
    ),
    actions: [TextButton(onPressed: () {}, child: Text('Close'))],
  );
  print('AlertDialog with scrollable content created');

  // ========== SIMPLEDIALOG ==========
  print('--- SimpleDialog Tests ---');

  // Test basic SimpleDialog
  final basicSimple = SimpleDialog(
    title: Text('Select'),
    children: [
      SimpleDialogOption(
        child: Text('Option 1'),
        onPressed: () {
          print('Option 1 selected');
        },
      ),
      SimpleDialogOption(
        child: Text('Option 2'),
        onPressed: () {
          print('Option 2 selected');
        },
      ),
    ],
  );
  print('Basic SimpleDialog created');

  // Test SimpleDialog with backgroundColor
  final coloredSimple = SimpleDialog(
    backgroundColor: Colors.green.shade50,
    title: Text('Colored'),
    children: [
      SimpleDialogOption(child: Text('A')),
      SimpleDialogOption(child: Text('B')),
    ],
  );
  print('SimpleDialog with backgroundColor created');

  // Test SimpleDialog with shape
  final shapedSimple = SimpleDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    title: Text('Rounded'),
    children: [SimpleDialogOption(child: Text('Option'))],
  );
  print('SimpleDialog with shape created');

  // ========== BOTTOMSHEET ==========
  print('--- BottomSheet Tests ---');

  // Test basic BottomSheet
  final basicBottomSheet = BottomSheet(
    onClosing: () {
      print('BottomSheet closing');
    },
    builder: (BuildContext context) {
      return Container(
        height: 200.0,
        padding: EdgeInsets.all(16.0),
        child: Text('Bottom Sheet Content'),
      );
    },
  );
  print('Basic BottomSheet created');

  // Test BottomSheet with backgroundColor
  final coloredBottomSheet = BottomSheet(
    backgroundColor: Colors.purple.shade50,
    onClosing: () {},
    builder: (context) {
      return Container(
        height: 150.0,
        child: Center(child: Text('Colored BottomSheet')),
      );
    },
  );
  print('BottomSheet with backgroundColor created');

  // Test BottomSheet with elevation
  final elevatedBottomSheet = BottomSheet(
    elevation: 16.0,
    onClosing: () {},
    builder: (context) {
      return Container(
        height: 150.0,
        child: Center(child: Text('Elevated BottomSheet')),
      );
    },
  );
  print('BottomSheet with elevation created');

  // Test BottomSheet with shape
  final shapedBottomSheet = BottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
    ),
    onClosing: () {},
    builder: (context) {
      return Container(
        height: 150.0,
        child: Center(child: Text('Rounded BottomSheet')),
      );
    },
  );
  print('BottomSheet with shape created');

  // Test BottomSheet with clipBehavior
  final clippedBottomSheet = BottomSheet(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    onClosing: () {},
    builder: (context) {
      return Container(
        height: 150.0,
        color: Colors.blue,
        child: Center(
          child: Text('Clipped', style: TextStyle(color: Colors.white)),
        ),
      );
    },
  );
  print('BottomSheet with clipBehavior created');

  // Test BottomSheet enableDrag
  final draggableBottomSheet = BottomSheet(
    enableDrag: true,
    onClosing: () {},
    builder: (context) {
      return Container(
        height: 150.0,
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(child: Center(child: Text('Drag to close'))),
          ],
        ),
      );
    },
  );
  print('BottomSheet enableDrag created');

  // ========== SNACKBAR ==========
  print('--- SnackBar Tests ---');

  // Test basic SnackBar
  final basicSnackBar = SnackBar(content: Text('This is a snack bar'));
  print('Basic SnackBar created');

  // Test SnackBar with action
  final actionSnackBar = SnackBar(
    content: Text('Item deleted'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        print('Undo pressed');
      },
    ),
  );
  print('SnackBar with action created');

  // Test SnackBar with duration
  final longSnackBar = SnackBar(
    content: Text('Long duration'),
    duration: Duration(seconds: 10),
  );
  print('SnackBar with long duration created');

  // Test SnackBar with backgroundColor
  final coloredSnackBar = SnackBar(
    content: Text('Success!'),
    backgroundColor: Colors.green,
  );
  print('SnackBar with backgroundColor created');

  // Test SnackBar with behavior
  final floatingSnackBar = SnackBar(
    content: Text('Floating snack bar'),
    behavior: SnackBarBehavior.floating,
  );
  print('SnackBar with floating behavior created');

  // Test SnackBar with margin
  final marginedSnackBar = SnackBar(
    content: Text('With margin'),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(16.0),
  );
  print('SnackBar with margin created');

  // Test SnackBar with shape
  final shapedSnackBar = SnackBar(
    content: Text('Rounded snack bar'),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
  );
  print('SnackBar with shape created');

  // Test SnackBar with elevation
  final elevatedSnackBar = SnackBar(content: Text('Elevated'), elevation: 8.0);
  print('SnackBar with elevation created');

  // Test SnackBar with padding
  final paddedSnackBar = SnackBar(
    content: Text('Padded content'),
    padding: EdgeInsets.all(24.0),
  );
  print('SnackBar with padding created');

  // Test SnackBar with width
  final widthSnackBar = SnackBar(
    content: Text('Fixed width'),
    behavior: SnackBarBehavior.floating,
    width: 300.0,
  );
  print('SnackBar with width created');

  // Test SnackBar with onVisible
  final onVisibleSnackBar = SnackBar(
    content: Text('Visible callback'),
    onVisible: () {
      print('SnackBar is now visible');
    },
  );
  print('SnackBar with onVisible created');

  // Test SnackBar with dismissDirection
  final dismissSnackBar = SnackBar(
    content: Text('Swipe to dismiss'),
    dismissDirection: DismissDirection.horizontal,
  );
  print('SnackBar with dismissDirection created');

  // Test SnackBar with showCloseIcon
  final closeIconSnackBar = SnackBar(
    content: Text('With close icon'),
    showCloseIcon: true,
    closeIconColor: Colors.white,
  );
  print('SnackBar with showCloseIcon created');

  print('Dialog/Overlay widgets test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dialog & Overlay Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text('Dialog:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 150, child: basicDialog),
        SizedBox(height: 8.0),

        Text('AlertDialog:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 200, child: actionAlert),
        SizedBox(height: 8.0),

        Text('SimpleDialog:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 200, child: basicSimple),
        SizedBox(height: 8.0),

        Text('BottomSheet:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 200, child: shapedBottomSheet),
        SizedBox(height: 8.0),

        Text(
          'SnackBar (preview):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          color: Colors.grey.shade800,
          padding: EdgeInsets.all(16.0),
          child: Text(
            'SnackBars are shown via ScaffoldMessenger',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
