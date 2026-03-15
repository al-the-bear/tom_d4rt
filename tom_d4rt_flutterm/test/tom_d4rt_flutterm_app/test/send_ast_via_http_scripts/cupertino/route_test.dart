// D4rt test script: Tests Cupertino routing classes overview
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino routing test executing');

  // ===== 1. CupertinoPageRoute =====
  print('--- CupertinoPageRoute ---');
  final pageRoute = CupertinoPageRoute(
    builder: (ctx) => CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Page Route')),
      child: Center(child: Text('Via CupertinoPageRoute')),
    ),
    title: 'Page Route',
  );
  print('  CupertinoPageRoute created: ${pageRoute.runtimeType}');

  // ===== 2. CupertinoPageRoute with fullscreenDialog =====
  print('--- Fullscreen dialog route ---');
  final dialogRoute = CupertinoPageRoute(
    fullscreenDialog: true,
    builder: (ctx) => CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Dialog'),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text('Close'),
          onPressed: () => Navigator.of(ctx).pop(),
        ),
      ),
      child: Center(child: Text('Fullscreen dialog')),
    ),
  );
  print('  fullscreenDialog route: ${dialogRoute.fullscreenDialog}');

  // ===== 3. CupertinoPage declarative routing =====
  print('--- CupertinoPage ---');
  final page = CupertinoPage(
    child: Center(child: Text('Declarative page')),
    title: 'Declarative',
  );
  print('  CupertinoPage: title=${page.title}');

  // ===== 4. CupertinoSheetRoute =====
  print('--- CupertinoSheetRoute ---');
  final sheetRoute = CupertinoSheetRoute(
    builder: (ctx) => CupertinoPageScaffold(
      child: Center(child: Text('Sheet content')),
    ),
  );
  print('  CupertinoSheetRoute: ${sheetRoute.runtimeType}');

  // ===== 5. Navigator.push with CupertinoPageRoute =====
  print('--- Navigator integration ---');
  final pushButton = CupertinoButton(
    child: Text('Push Page'),
    onPressed: () {
      Navigator.of(context).push(CupertinoPageRoute(
        builder: (ctx) => CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(middle: Text('Pushed')),
          child: SafeArea(
            child: Center(
              child: CupertinoButton(
                child: Text('Go Back'),
                onPressed: () => Navigator.of(ctx).pop(),
              ),
            ),
          ),
        ),
      ));
    },
  );
  print('  push button created');

  // ===== 6. showCupertinoModalPopup =====
  print('--- Modal popup ---');
  final modalButton = CupertinoButton(
    child: Text('Show Modal'),
    onPressed: () {
      showCupertinoModalPopup(
        context: context,
        builder: (ctx) => CupertinoActionSheet(
          title: Text('Options'),
          actions: [
            CupertinoActionSheetAction(
              child: Text('Option 1'),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
            CupertinoActionSheetAction(
              child: Text('Option 2'),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text('Cancel'),
            isDefaultAction: true,
            onPressed: () => Navigator.of(ctx).pop(),
          ),
        ),
      );
    },
  );
  print('  modal button created');

  // ===== 7. showCupertinoDialog =====
  print('--- Cupertino dialog ---');
  final dialogButton = CupertinoButton(
    child: Text('Show Dialog'),
    onPressed: () {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: Text('Alert'),
          content: Text('This is an alert dialog'),
          actions: [
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
          ],
        ),
      );
    },
  );
  print('  dialog button created');

  // ===== 8. showCupertinoSheet =====
  print('--- Sheet ---');
  final sheetButton = CupertinoButton(
    child: Text('Show Sheet'),
    onPressed: () {
      showCupertinoSheet(
        context: context,
        pageBuilder: (ctx) => CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(middle: Text('Sheet')),
          child: Center(child: Text('Sheet page')),
        ),
      );
    },
  );
  print('  sheet button created');

  print('Cupertino routing test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Routes Test')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              pushButton,
              SizedBox(height: 8.0),
              modalButton,
              SizedBox(height: 8.0),
              dialogButton,
              SizedBox(height: 8.0),
              sheetButton,
              SizedBox(height: 24.0),
              Text('Route types:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('CupertinoPageRoute: ${pageRoute.runtimeType}'),
              Text('CupertinoSheetRoute: ${sheetRoute.runtimeType}'),
              Text('CupertinoPage: ${page.runtimeType}'),
            ],
          ),
        ),
      ),
    ),
  );
}
