// D4rt test script: Tests NavigationDestination, NavigationRailDestination, NavigationDrawerDestination, DrawerHeader, UserAccountsDrawerHeader, AboutListTile from Flutter material
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Navigation destinations test executing');

  // ========== NAVIGATIONDESTINATION ==========
  print('--- NavigationDestination Tests ---');

  // Variation 1: Basic NavigationDestination (used inside NavigationBar)
  final widget1 = NavigationBar(
    destinations: [
      NavigationDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home),
        label: 'Home',
      ),
      NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
      NavigationDestination(
        icon: Icon(Icons.person_outline),
        selectedIcon: Icon(Icons.person),
        label: 'Profile',
      ),
    ],
    selectedIndex: 0,
  );
  print('NavigationDestination(3 destinations with selectedIcon) created');

  // Variation 2: NavigationDestination with tooltip
  final widget2 = NavigationBar(
    destinations: [
      NavigationDestination(
        icon: Icon(Icons.dashboard),
        label: 'Dashboard',
        tooltip: 'Go to dashboard',
      ),
      NavigationDestination(
        icon: Icon(Icons.analytics),
        label: 'Analytics',
        tooltip: 'View analytics',
      ),
    ],
    selectedIndex: 1,
  );
  print('NavigationDestination(with tooltip) created');

  // Variation 3: NavigationDestination with enabled false
  final widget3 = NavigationBar(
    destinations: [
      NavigationDestination(
        icon: Icon(Icons.inbox),
        label: 'Inbox',
        enabled: true,
      ),
      NavigationDestination(
        icon: Icon(Icons.drafts),
        label: 'Drafts',
        enabled: false,
      ),
    ],
    selectedIndex: 0,
  );
  print('NavigationDestination(enabled: false) created');

  // ========== NAVIGATIONRAILDESTINATION ==========
  print('--- NavigationRailDestination Tests ---');

  // Variation 4: NavigationRail with NavigationRailDestination
  final widget4 = NavigationRail(
    destinations: [
      NavigationRailDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home),
        label: Text('Home'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.bookmark_border),
        selectedIcon: Icon(Icons.bookmark),
        label: Text('Bookmarks'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.star_border),
        selectedIcon: Icon(Icons.star),
        label: Text('Favorites'),
      ),
    ],
    selectedIndex: 1,
    onDestinationSelected: (int index) {
      print('Rail destination selected: $index');
    },
  );
  print('NavigationRailDestination(3 destinations with selectedIcon) created');

  // Variation 5: NavigationRailDestination with padding
  final widget5 = NavigationRail(
    destinations: [
      NavigationRailDestination(
        icon: Icon(Icons.folder),
        label: Text('Files'),
        padding: EdgeInsets.symmetric(vertical: 8.0),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.cloud),
        label: Text('Cloud'),
        padding: EdgeInsets.symmetric(vertical: 8.0),
      ),
    ],
    selectedIndex: 0,
    labelType: NavigationRailLabelType.all,
    onDestinationSelected: (int index) {},
  );
  print('NavigationRailDestination(padding, labelType: all) created');

  // Variation 6: NavigationRailDestination with indicatorColor and indicatorShape
  final widget6 = NavigationRail(
    destinations: [
      NavigationRailDestination(
        icon: Icon(Icons.edit),
        selectedIcon: Icon(Icons.edit_note),
        label: Text('Edit'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.delete_outline),
        selectedIcon: Icon(Icons.delete),
        label: Text('Trash'),
      ),
    ],
    selectedIndex: 0,
    indicatorColor: Colors.blue.shade100,
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    onDestinationSelected: (int index) {},
  );
  print('NavigationRail(indicatorColor, indicatorShape) created');

  // ========== NAVIGATIONDRAWERDESTINATION ==========
  print('--- NavigationDrawerDestination Tests ---');

  // Variation 7: NavigationDrawer with NavigationDrawerDestination
  final widget7 = NavigationDrawer(
    selectedIndex: 0,
    onDestinationSelected: (int index) {
      print('Drawer destination selected: $index');
    },
    children: [
      Padding(
        padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
        child: Text(
          'Mail',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
      NavigationDrawerDestination(
        icon: Icon(Icons.drafts_outlined),
        selectedIcon: Icon(Icons.drafts),
        label: Text('Drafts'),
      ),
      Divider(),
      Padding(
        padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
        child: Text(
          'Labels',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
      NavigationDrawerDestination(
        icon: Icon(Icons.label_outline),
        label: Text('Important'),
      ),
    ],
  );
  print('NavigationDrawerDestination(with sections and divider) created');

  // Variation 8: NavigationDrawerDestination with enabled false
  final widget8 = NavigationDrawer(
    selectedIndex: 0,
    onDestinationSelected: (int index) {},
    children: [
      NavigationDrawerDestination(
        icon: Icon(Icons.home),
        label: Text('Active'),
        enabled: true,
      ),
      NavigationDrawerDestination(
        icon: Icon(Icons.lock),
        label: Text('Locked'),
        enabled: false,
      ),
    ],
  );
  print('NavigationDrawerDestination(enabled: false) created');

  // ========== DRAWERHEADER ==========
  print('--- DrawerHeader Tests ---');

  // Variation 9: Basic DrawerHeader
  final widget9 = DrawerHeader(
    child: Text(
      'App Name',
      style: TextStyle(fontSize: 24, color: Colors.white),
    ),
    decoration: BoxDecoration(color: Colors.blue),
  );
  print('DrawerHeader(decoration: blue) created');

  // Variation 10: DrawerHeader with gradient
  final widget10 = DrawerHeader(
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [Colors.purple, Colors.blue]),
    ),
    margin: EdgeInsets.zero,
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CircleAvatar(radius: 28, child: Text('U')),
        SizedBox(height: 8),
        Text('User Name', style: TextStyle(color: Colors.white, fontSize: 18)),
      ],
    ),
  );
  print('DrawerHeader(gradient, margin, padding) created');

  // Variation 11: DrawerHeader with duration
  final widget11 = DrawerHeader(
    decoration: BoxDecoration(color: Colors.teal),
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
    child: Text('Animated Header', style: TextStyle(color: Colors.white)),
  );
  print('DrawerHeader(duration, curve) created');

  // ========== USERACCOUNTSDRAWERHEADER ==========
  print('--- UserAccountsDrawerHeader Tests ---');

  // Variation 12: Basic UserAccountsDrawerHeader
  final widget12 = UserAccountsDrawerHeader(
    accountName: Text('John Doe'),
    accountEmail: Text('john@example.com'),
  );
  print('UserAccountsDrawerHeader(accountName, accountEmail) created');

  // Variation 13: UserAccountsDrawerHeader with pictures
  final widget13 = UserAccountsDrawerHeader(
    accountName: Text('Jane Smith'),
    accountEmail: Text('jane@example.com'),
    currentAccountPicture: CircleAvatar(
      backgroundColor: Colors.white,
      child: Text('JS', style: TextStyle(fontSize: 24)),
    ),
    otherAccountsPictures: [
      CircleAvatar(child: Text('A')),
      CircleAvatar(child: Text('B')),
    ],
  );
  print(
    'UserAccountsDrawerHeader(currentAccountPicture, otherAccountsPictures) created',
  );

  // Variation 14: UserAccountsDrawerHeader with decoration
  final widget14 = UserAccountsDrawerHeader(
    accountName: Text('Alice'),
    accountEmail: Text('alice@test.com'),
    currentAccountPicture: CircleAvatar(
      backgroundColor: Colors.indigo,
      child: Text('A', style: TextStyle(color: Colors.white)),
    ),
    decoration: BoxDecoration(color: Colors.indigo),
    onDetailsPressed: () {
      print('Details pressed');
    },
  );
  print('UserAccountsDrawerHeader(decoration, onDetailsPressed) created');

  // Variation 15: UserAccountsDrawerHeader with arrowColor and margin
  final widget15 = UserAccountsDrawerHeader(
    accountName: Text('Bob'),
    accountEmail: Text('bob@test.com'),
    arrowColor: Colors.yellow,
    margin: EdgeInsets.zero,
    onDetailsPressed: () {},
  );
  print('UserAccountsDrawerHeader(arrowColor, margin) created');

  // ========== ABOUTLISTTILE ==========
  print('--- AboutListTile Tests ---');

  // Variation 16: Basic AboutListTile
  final widget16 = AboutListTile(
    applicationName: 'D4rt App',
    applicationVersion: '1.0.0',
  );
  print('AboutListTile(applicationName, applicationVersion) created');

  // Variation 17: AboutListTile with icon
  final widget17 = AboutListTile(
    icon: Icon(Icons.info),
    applicationName: 'Test App',
    applicationVersion: '2.0.0',
    applicationIcon: FlutterLogo(size: 40),
  );
  print('AboutListTile(icon, applicationIcon) created');

  // Variation 18: AboutListTile with legalese
  final widget18 = AboutListTile(
    applicationName: 'Legal App',
    applicationVersion: '3.0.0',
    applicationLegalese: 'Copyright 2025 Test Corp',
    aboutBoxChildren: [
      SizedBox(height: 16),
      Text('Built with Flutter and D4rt'),
    ],
  );
  print('AboutListTile(applicationLegalese, aboutBoxChildren) created');

  // Variation 19: AboutListTile with child (custom label)
  final widget19 = AboutListTile(
    child: Text('About this app'),
    applicationName: 'Custom Label App',
    applicationVersion: '4.0.0',
    dense: true,
  );
  print('AboutListTile(child: custom label, dense) created');

  print('Navigation destinations test completed');
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        widget1,
        SizedBox(height: 8),
        widget2,
        SizedBox(height: 8),
        widget3,
        SizedBox(height: 16),
        SizedBox(height: 300, child: widget4),
        SizedBox(height: 8),
        SizedBox(height: 200, child: widget7),
        SizedBox(height: 16),
        widget9,
        widget10,
        widget12,
        widget13,
        SizedBox(height: 16),
        widget16,
        widget17,
        widget18,
        widget19,
      ],
    ),
  );
}
