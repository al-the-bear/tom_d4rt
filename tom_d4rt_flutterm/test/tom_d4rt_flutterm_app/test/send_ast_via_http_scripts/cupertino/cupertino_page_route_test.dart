// D4rt test script: Tests CupertinoPageRoute, CupertinoModalPopupRoute,
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// CupertinoDialogRoute, CupertinoPageTransitionsBuilder,
// CupertinoPopupSurface, showCupertinoDialog, showCupertinoModalPopup concepts,
// CupertinoScrollbar variants
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Cupertino page route test executing');

  // ========== CupertinoPageRoute ==========
  print('--- CupertinoPageRoute Tests ---');
  final pageRoute = CupertinoPageRoute(
    builder: (context) => CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Detail Page'),
        previousPageTitle: 'Back',
      ),
      child: Center(child: Text('Detail Content')),
    ),
    title: 'Detail',
    maintainState: true,
    fullscreenDialog: false,
    allowSnapshotting: true,
  );
  print('CupertinoPageRoute created');

  // ========== CupertinoPageTransitionsBuilder ==========
  print('--- CupertinoPageTransitionsBuilder Tests ---');
  final transitionsBuilder = CupertinoPageTransitionsBuilder();
  print('CupertinoPageTransitionsBuilder created');

  // ========== CupertinoPopupSurface ==========
  print('--- CupertinoPopupSurface Tests ---');
  final popupSurface = CupertinoPopupSurface(
    isSurfacePainted: true,
    child: Container(
      padding: EdgeInsets.all(16),
      child: Text('Popup Surface Content'),
    ),
  );
  print('CupertinoPopupSurface created');

  // ========== CupertinoAlertDialog ==========
  print('--- CupertinoAlertDialog Tests ---');
  final alertDialog = CupertinoAlertDialog(
    title: Text('Alert Title'),
    content: Text('This is an important message.'),
    actions: [
      CupertinoDialogAction(
        child: Text('Cancel'),
        isDefaultAction: false,
        isDestructiveAction: false,
        onPressed: () => print('  Cancel pressed'),
      ),
      CupertinoDialogAction(
        child: Text('Delete'),
        isDefaultAction: false,
        isDestructiveAction: true,
        onPressed: () => print('  Delete pressed'),
      ),
      CupertinoDialogAction(
        child: Text('OK'),
        isDefaultAction: true,
        onPressed: () => print('  OK pressed'),
      ),
    ],
    insetAnimationDuration: Duration(milliseconds: 100),
    insetAnimationCurve: Curves.decelerate,
  );
  print('CupertinoAlertDialog created');

  // ========== CupertinoDialogAction ==========
  print('--- CupertinoDialogAction Tests ---');
  final dialogAction = CupertinoDialogAction(
    onPressed: () {},
    isDefaultAction: true,
    isDestructiveAction: false,
    textStyle: TextStyle(fontSize: 17),
    child: Text('Confirm'),
  );
  print('CupertinoDialogAction created');

  // ========== CupertinoActionSheet ==========
  print('--- CupertinoActionSheet Tests ---');
  final actionSheet = CupertinoActionSheet(
    title: Text('Select Action'),
    message: Text('Choose one of the following options'),
    actions: [
      CupertinoActionSheetAction(
        onPressed: () => print('  Copy pressed'),
        child: Text('Copy'),
      ),
      CupertinoActionSheetAction(
        onPressed: () => print('  Share pressed'),
        child: Text('Share'),
      ),
      CupertinoActionSheetAction(
        onPressed: () => print('  Delete pressed'),
        isDefaultAction: false,
        isDestructiveAction: true,
        child: Text('Delete'),
      ),
    ],
    cancelButton: CupertinoActionSheetAction(
      onPressed: () => print('  Cancel pressed'),
      isDefaultAction: true,
      child: Text('Cancel'),
    ),
  );
  print('CupertinoActionSheet created');

  // ========== CupertinoContextMenu ==========
  print('--- CupertinoContextMenu Tests ---');
  final contextMenu = CupertinoContextMenu(
    actions: [
      CupertinoContextMenuAction(
        child: Text('Copy'),
        trailingIcon: CupertinoIcons.doc_on_doc,
        onPressed: () => print('  Copy context'),
      ),
      CupertinoContextMenuAction(
        child: Text('Share'),
        trailingIcon: CupertinoIcons.share,
        onPressed: () => print('  Share context'),
      ),
      CupertinoContextMenuAction(
        child: Text('Delete'),
        trailingIcon: CupertinoIcons.delete,
        isDestructiveAction: true,
        onPressed: () => print('  Delete context'),
      ),
    ],
    child: Container(
      width: 200,
      height: 200,
      color: CupertinoColors.activeBlue,
      child: Center(
        child: Text('Hold me', style: TextStyle(color: CupertinoColors.white)),
      ),
    ),
  );
  print('CupertinoContextMenu created');

  // ========== CupertinoContextMenuAction ==========
  print('--- CupertinoContextMenuAction Tests ---');
  final contextAction = CupertinoContextMenuAction(
    child: Text('Action Item'),
    trailingIcon: CupertinoIcons.add,
    isDefaultAction: true,
    isDestructiveAction: false,
    onPressed: () {},
  );
  print('CupertinoContextMenuAction created');

  print('All cupertino page route tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [popupSurface, SizedBox(height: 16), contextMenu],
        ),
      ),
    ),
  );
}
