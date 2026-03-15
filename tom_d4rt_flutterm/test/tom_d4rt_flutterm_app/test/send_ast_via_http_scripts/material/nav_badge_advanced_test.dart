// D4rt test script: Tests material Badge, SegmentedButton advanced,
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// NavigationDrawer, NavigationRailDestination, NavigationRailLabelType
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Material nav/badge advanced test executing');

  // ========== Badge advanced ==========
  print('--- Badge advanced Tests ---');
  final badge = Badge(
    label: Text('3'),
    backgroundColor: Colors.red,
    textColor: Colors.white,
    textStyle: TextStyle(fontSize: 10.0),
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    alignment: AlignmentDirectional.topEnd,
    offset: Offset(2, -2),
    isLabelVisible: true,
    child: Icon(Icons.mail, size: 30.0),
  );
  print('Badge created: label=3, backgroundColor=red');

  final emptyBadge = Badge(
    smallSize: 8.0,
    child: Icon(Icons.notifications, size: 30.0),
  );
  print('Badge (empty/dot): smallSize=8');

  // ========== BadgeThemeData ==========
  print('--- BadgeThemeData Tests ---');
  final badgeTheme = BadgeThemeData(
    backgroundColor: Colors.orange,
    textColor: Colors.white,
    smallSize: 6.0,
    largeSize: 16.0,
    textStyle: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    alignment: AlignmentDirectional.topEnd,
    offset: Offset(0, 0),
  );
  print('BadgeThemeData created');
  print('  backgroundColor: ${badgeTheme.backgroundColor}');
  print('  smallSize: ${badgeTheme.smallSize}');
  print('  largeSize: ${badgeTheme.largeSize}');

  // ========== NavigationDrawer ==========
  print('--- NavigationDrawer Tests ---');
  final navDrawer = NavigationDrawer(
    selectedIndex: 1,
    onDestinationSelected: (int index) => print('Drawer selected: $index'),
    backgroundColor: Colors.white,
    elevation: 1.0,
    indicatorColor: Colors.blue.shade100,
    indicatorShape: StadiumBorder(),
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.blue.shade50,
    children: [
      Padding(
        padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
        child: Text(
          'Mail',
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
        ),
      ),
      NavigationDrawerDestination(
        icon: Icon(Icons.inbox_outlined),
        selectedIcon: Icon(Icons.inbox),
        label: Text('Inbox'),
      ),
      NavigationDrawerDestination(
        icon: Icon(Icons.send_outlined),
        selectedIcon: Icon(Icons.send),
        label: Text('Sent'),
      ),
      Divider(indent: 28, endIndent: 28),
      NavigationDrawerDestination(
        icon: Icon(Icons.delete_outline),
        selectedIcon: Icon(Icons.delete),
        label: Text('Trash'),
      ),
    ],
  );
  print('NavigationDrawer: 3 destinations');

  // ========== NavigationDrawerDestination ==========
  print('--- NavigationDrawerDestination Tests ---');
  final dest = NavigationDrawerDestination(
    icon: Icon(Icons.star_border),
    selectedIcon: Icon(Icons.star),
    label: Text('Starred'),
    enabled: true,
  );
  print('NavigationDrawerDestination created');

  // ========== NavigationDrawerThemeData ==========
  print('--- NavigationDrawerThemeData Tests ---');
  final drawerTheme = NavigationDrawerThemeData(
    backgroundColor: Colors.grey.shade50,
    elevation: 2.0,
    indicatorColor: Colors.blue.shade100,
    indicatorShape: StadiumBorder(),
    tileHeight: 56.0,
    labelTextStyle: WidgetStateProperty.all(TextStyle(fontSize: 14.0)),
    iconTheme: WidgetStateProperty.all(IconThemeData(size: 24.0)),
  );
  print('NavigationDrawerThemeData created');

  // ========== NavigationRailLabelType ==========
  print('--- NavigationRailLabelType Tests ---');
  for (final type in NavigationRailLabelType.values) {
    print('NavigationRailLabelType: ${type.name}');
  }

  // ========== NavigationRailThemeData ==========
  print('--- NavigationRailThemeData Tests ---');
  final railTheme = NavigationRailThemeData(
    backgroundColor: Colors.grey.shade100,
    elevation: 0.0,
    indicatorColor: Colors.blue.shade100,
    indicatorShape: StadiumBorder(),
    labelType: NavigationRailLabelType.all,
    groupAlignment: -1.0,
    minWidth: 72.0,
    minExtendedWidth: 256.0,
    useIndicator: true,
  );
  print('NavigationRailThemeData created');

  print('All material nav/badge advanced tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: 0,
            labelType: NavigationRailLabelType.all,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.bookmark_border),
                selectedIcon: Icon(Icons.bookmark),
                label: Text('Saved'),
              ),
            ],
            onDestinationSelected: (int index) {},
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Nav/Badge Advanced Test',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [badge, SizedBox(width: 16), emptyBadge],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
