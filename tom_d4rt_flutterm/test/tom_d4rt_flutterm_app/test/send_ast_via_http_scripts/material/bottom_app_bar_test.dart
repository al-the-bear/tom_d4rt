// D4rt test script: Tests BottomAppBar, BottomAppBarTheme, NavigationBar,
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// NavigationDestination, NavigationBarThemeData, BadgeThemeData,
// Badge, NavigationDrawer, NavigationDrawerDestination
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Bottom app bar and navigation test executing');

  // ========== BottomAppBar ==========
  print('--- BottomAppBar Tests ---');
  final bottomAppBar = BottomAppBar(
    color: Colors.blue,
    elevation: 8.0,
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.blue[50],
    shape: CircularNotchedRectangle(),
    clipBehavior: Clip.antiAlias,
    notchMargin: 8.0,
    padding: EdgeInsets.symmetric(horizontal: 16),
    height: 64.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: Icon(Icons.home, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.search, color: Colors.white),
          onPressed: () {},
        ),
        SizedBox(width: 48), // Space for FAB
        IconButton(
          icon: Icon(Icons.favorite, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.person, color: Colors.white),
          onPressed: () {},
        ),
      ],
    ),
  );
  print('BottomAppBar created');

  // ========== CircularNotchedRectangle ==========
  print('--- CircularNotchedRectangle Tests ---');
  final notchedShape = CircularNotchedRectangle();
  print('CircularNotchedRectangle created');
  final path = notchedShape.getOuterPath(
    Rect.fromLTWH(0, 0, 400, 64),
    Rect.fromCircle(center: Offset(200, 0), radius: 28),
  );
  print('  getOuterPath computed');

  // ========== BottomAppBarTheme ==========
  print('--- BottomAppBarTheme Tests ---');
  final bottomAppBarTheme = BottomAppBarTheme(
    color: Colors.white,
    elevation: 4.0,
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.blue[50],
    shape: CircularNotchedRectangle(),
    height: 64.0,
    padding: EdgeInsets.symmetric(horizontal: 12),
  );
  print('BottomAppBarTheme created');
  print('  elevation: ${bottomAppBarTheme.elevation}');
  print('  height: ${bottomAppBarTheme.height}');

  // ========== NavigationBar ==========
  print('--- NavigationBar Tests ---');
  final navigationBar = NavigationBar(
    selectedIndex: 0,
    onDestinationSelected: (index) => print('  Nav selected: $index'),
    destinations: [
      NavigationDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home),
        label: 'Home',
        tooltip: 'Go to home',
        enabled: true,
      ),
      NavigationDestination(
        icon: Badge(
          label: Text('3'),
          child: Icon(Icons.notifications_outlined),
        ),
        selectedIcon: Badge(label: Text('3'), child: Icon(Icons.notifications)),
        label: 'Notifications',
      ),
      NavigationDestination(
        icon: Icon(Icons.settings_outlined),
        selectedIcon: Icon(Icons.settings),
        label: 'Settings',
      ),
    ],
    elevation: 3.0,
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.blue[50],
    backgroundColor: Colors.white,
    indicatorColor: Colors.blue[100],
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    height: 80.0,
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    animationDuration: Duration(milliseconds: 500),
    overlayColor: WidgetStateProperty.all(Colors.blue[50]),
  );
  print('NavigationBar created');

  // ========== NavigationDestinationLabelBehavior ==========
  print('--- NavigationDestinationLabelBehavior Tests ---');
  for (final b in NavigationDestinationLabelBehavior.values) {
    print('  NavigationDestinationLabelBehavior.$b');
  }

  // ========== NavigationBarThemeData ==========
  print('--- NavigationBarThemeData Tests ---');
  final navBarTheme = NavigationBarThemeData(
    height: 80.0,
    backgroundColor: Colors.white,
    elevation: 3.0,
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.blue[50],
    indicatorColor: Colors.blue[100],
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    overlayColor: WidgetStateProperty.all(Colors.blue[50]),
    labelTextStyle: WidgetStateProperty.all(TextStyle(fontSize: 12)),
    iconTheme: WidgetStateProperty.all(IconThemeData(size: 24)),
  );
  print('NavigationBarThemeData created');

  // ========== Badge ==========
  print('--- Badge Tests ---');
  final badge1 = Badge(
    label: Text('99+'),
    backgroundColor: Colors.red,
    textColor: Colors.white,
    textStyle: TextStyle(fontSize: 10),
    padding: EdgeInsets.symmetric(horizontal: 6),
    alignment: AlignmentDirectional.topEnd,
    offset: Offset(4, -4),
    largeSize: 16.0,
    smallSize: 6.0,
    isLabelVisible: true,
    child: Icon(Icons.mail),
  );
  print('Badge with label created');

  final badge2 = Badge(child: Icon(Icons.notifications));
  print('Badge dot created');

  // ========== BadgeThemeData ==========
  print('--- BadgeThemeData Tests ---');
  final badgeTheme = BadgeThemeData(
    backgroundColor: Colors.red,
    textColor: Colors.white,
    textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
    padding: EdgeInsets.symmetric(horizontal: 6),
    alignment: AlignmentDirectional.topEnd,
    offset: Offset(4, -4),
    largeSize: 16.0,
    smallSize: 6.0,
  );
  print('BadgeThemeData created');

  // ========== NavigationDrawer ==========
  print('--- NavigationDrawer Tests ---');
  final navDrawer = NavigationDrawer(
    selectedIndex: 0,
    onDestinationSelected: (index) => print('  Drawer selected: $index'),
    elevation: 1.0,
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.blue[50],
    backgroundColor: Colors.white,
    indicatorColor: Colors.blue[100],
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(28),
    ),
    tilePadding: EdgeInsets.symmetric(horizontal: 12),
    children: [
      Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Navigation',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      NavigationDrawerDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home),
        label: Text('Home'),
        enabled: true,
      ),
      NavigationDrawerDestination(
        icon: Icon(Icons.settings_outlined),
        selectedIcon: Icon(Icons.settings),
        label: Text('Settings'),
      ),
      Divider(),
      NavigationDrawerDestination(
        icon: Icon(Icons.info_outline),
        selectedIcon: Icon(Icons.info),
        label: Text('About'),
      ),
    ],
  );
  print('NavigationDrawer created');

  print('All bottom app bar / navigation tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      bottomNavigationBar: navigationBar,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Center(child: Text('Content')),
      drawer: navDrawer,
    ),
  );
}
