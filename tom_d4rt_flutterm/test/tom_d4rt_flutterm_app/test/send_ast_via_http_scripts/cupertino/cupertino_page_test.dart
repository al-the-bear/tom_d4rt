// D4rt test script: Tests CupertinoPage from cupertino
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoPage test executing');

  // ===== 1. Basic CupertinoPage with required child =====
  print('--- Basic CupertinoPage ---');
  final basicPage = CupertinoPage(
    child: Center(child: Text('Basic Page Content')),
  );
  print('  basic page created');
  print('  child type: ${basicPage.child.runtimeType}');
  print('  maintainState: ${basicPage.maintainState}');
  print('  fullscreenDialog: ${basicPage.fullscreenDialog}');
  print('  canPop: ${basicPage.canPop}');
  print('  allowSnapshotting: ${basicPage.allowSnapshotting}');

  // ===== 2. CupertinoPage with title =====
  print('--- With title ---');
  final titledPage = CupertinoPage(
    title: 'Settings',
    child: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Settings')),
      child: Center(child: Text('Settings Page')),
    ),
  );
  print('  titled page created');
  print('  title: ${titledPage.title}');

  // ===== 3. Fullscreen dialog page =====
  print('--- Fullscreen dialog ---');
  final dialogPage = CupertinoPage(
    fullscreenDialog: true,
    title: 'New Item',
    child: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('New Item'),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text('Cancel'),
          onPressed: () {},
        ),
      ),
      child: Center(child: Text('Dialog content')),
    ),
  );
  print('  fullscreenDialog: ${dialogPage.fullscreenDialog}');

  // ===== 4. Non-poppable page (canPop: false) =====
  print('--- Cannot pop ---');
  final nonPoppable = CupertinoPage(
    canPop: false,
    child: Center(child: Text('Cannot go back')),
  );
  print('  canPop: ${nonPoppable.canPop}');

  // ===== 5. maintainState false =====
  print('--- maintainState false ---');
  final noMaintain = CupertinoPage(
    maintainState: false,
    child: Center(child: Text('State not maintained')),
  );
  print('  maintainState: ${noMaintain.maintainState}');

  // ===== 6. allowSnapshotting false =====
  print('--- allowSnapshotting false ---');
  final noSnapshot = CupertinoPage(
    allowSnapshotting: false,
    child: Center(child: Text('No snapshots')),
  );
  print('  allowSnapshotting: ${noSnapshot.allowSnapshotting}');

  // ===== 7. CupertinoPage creates route =====
  print('--- createRoute ---');
  final routePage = CupertinoPage(
    title: 'Route Page',
    child: Center(child: Text('Route content')),
  );
  final route = routePage.createRoute(context);
  print('  route created: ${route.runtimeType}');

  // ===== 8. Multiple pages for navigation stack simulation =====
  print('--- Multiple pages ---');
  final pages = <CupertinoPage>[];
  for (var i = 0; i < 5; i++) {
    pages.add(CupertinoPage(
      title: 'Page $i',
      child: Center(child: Text('Content $i')),
    ));
  }
  print('  created ${pages.length} pages');
  for (final page in pages) {
    print('    title: ${page.title}');
  }

  // ===== 9. All properties combined =====
  print('--- All properties ---');
  final fullPage = CupertinoPage(
    title: 'Full Config',
    maintainState: true,
    fullscreenDialog: false,
    allowSnapshotting: true,
    canPop: true,
    child: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Full Config')),
      child: Center(child: Text('Fully configured page')),
    ),
  );
  print('  title: ${fullPage.title}');
  print('  maintainState: ${fullPage.maintainState}');
  print('  fullscreenDialog: ${fullPage.fullscreenDialog}');
  print('  allowSnapshotting: ${fullPage.allowSnapshotting}');
  print('  canPop: ${fullPage.canPop}');

  print('CupertinoPage test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('CupertinoPage Test')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('CupertinoPage Tests', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              Text('Basic: child=${basicPage.child.runtimeType}'),
              Text('Titled: title=${titledPage.title}'),
              Text('Dialog: fullscreen=${dialogPage.fullscreenDialog}'),
              Text('NonPop: canPop=${nonPoppable.canPop}'),
              Text('NoMaintain: maintainState=${noMaintain.maintainState}'),
              Text('NoSnap: allowSnapshotting=${noSnapshot.allowSnapshotting}'),
              Text('Route type: ${route.runtimeType}'),
              Text('Pages count: ${pages.length}'),
              SizedBox(height: 12.0),
              Text('Full config:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('  title: ${fullPage.title}'),
              Text('  maintainState: ${fullPage.maintainState}'),
              Text('  fullscreenDialog: ${fullPage.fullscreenDialog}'),
              Text('  canPop: ${fullPage.canPop}'),
            ],
          ),
        ),
      ),
    ),
  );
}
