// D4rt test script: Tests BottomNavigationBar widget from material
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BottomNavigationBar test executing');

  // Test basic BottomNavigationBar
  final basicNavBar = BottomNavigationBar(
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    ],
    currentIndex: 0,
    onTap: (index) {
      print('Tab $index tapped');
    },
  );
  print('Basic BottomNavigationBar with 3 items created');

  // Test with currentIndex
  final selectedNavBar = BottomNavigationBar(
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
    ],
    currentIndex: 1,
    onTap: (i) {},
  );
  print('BottomNavigationBar with currentIndex=1 created');

  // Test type: fixed
  final fixedNavBar = BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Alerts'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    ],
    currentIndex: 0,
    onTap: (i) {},
  );
  print('BottomNavigationBar with type=fixed created');

  // Test type: shifting
  final shiftingNavBar = BottomNavigationBar(
    type: BottomNavigationBarType.shifting,
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
        backgroundColor: Colors.blue,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'Search',
        backgroundColor: Colors.green,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
        backgroundColor: Colors.purple,
      ),
    ],
    currentIndex: 0,
    onTap: (i) {},
  );
  print('BottomNavigationBar with type=shifting created');

  // Test with custom colors
  final coloredNavBar = BottomNavigationBar(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
    ],
    currentIndex: 0,
    onTap: (i) {},
  );
  print('BottomNavigationBar with custom colors created');

  // Test with selectedIconTheme and unselectedIconTheme
  final themedNavBar = BottomNavigationBar(
    selectedIconTheme: IconThemeData(size: 30.0, color: Colors.blue),
    unselectedIconTheme: IconThemeData(size: 24.0, color: Colors.grey),
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Star'),
    ],
    currentIndex: 0,
    onTap: (i) {},
  );
  print('BottomNavigationBar with icon themes created');

  // Test with selectedLabelStyle and unselectedLabelStyle
  final styledNavBar = BottomNavigationBar(
    selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 12.0,
    ),
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Work'),
    ],
    currentIndex: 0,
    onTap: (i) {},
  );
  print('BottomNavigationBar with label styles created');

  // Test with showSelectedLabels and showUnselectedLabels
  final noLabelsNavBar = BottomNavigationBar(
    showSelectedLabels: false,
    showUnselectedLabels: false,
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
    ],
    currentIndex: 0,
    onTap: (i) {},
  );
  print('BottomNavigationBar with hidden labels created');

  // Test with iconSize
  final largeIconsNavBar = BottomNavigationBar(
    iconSize: 32.0,
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
    ],
    currentIndex: 0,
    onTap: (i) {},
  );
  print('BottomNavigationBar with iconSize=32 created');

  // Test with elevation
  final elevatedNavBar = BottomNavigationBar(
    elevation: 16.0,
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.inbox), label: 'Inbox'),
    ],
    currentIndex: 0,
    onTap: (i) {},
  );
  print('BottomNavigationBar with elevation=16 created');

  // Test with landscapeLayout
  final landscapeNavBar = BottomNavigationBar(
    landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
      BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info'),
    ],
    currentIndex: 0,
    onTap: (i) {},
  );
  print('BottomNavigationBar with landscapeLayout=spread created');

  // Test with enableFeedback
  final feedbackNavBar = BottomNavigationBar(
    enableFeedback: true,
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
    ],
    currentIndex: 0,
    onTap: (i) {},
  );
  print('BottomNavigationBar with enableFeedback=true created');

  // Test with activeIcon
  final activeIconNavBar = BottomNavigationBar(
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        activeIcon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite_border),
        activeIcon: Icon(Icons.favorite),
        label: 'Favorites',
      ),
    ],
    currentIndex: 0,
    onTap: (i) {},
  );
  print('BottomNavigationBar with activeIcon created');

  // Test useLegacyColorScheme
  final legacyColorNavBar = BottomNavigationBar(
    useLegacyColorScheme: false,
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
    ],
    currentIndex: 0,
    onTap: (i) {},
  );
  print('BottomNavigationBar with useLegacyColorScheme=false created');

  print('BottomNavigationBar test completed');

  return Scaffold(
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BottomNavigationBar Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text('NavBar Types:', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('• fixed - all labels visible'),
          Text('• shifting - selected label only'),
          SizedBox(height: 16.0),

          Text(
            'Key Properties:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('• items - list of BottomNavigationBarItem'),
          Text('• currentIndex - selected index'),
          Text('• onTap - tap callback'),
          Text('• type - fixed or shifting'),
          Text('• backgroundColor - background color'),
          Text('• selectedItemColor - selected item color'),
          Text('• unselectedItemColor - unselected color'),
          Text('• iconSize - icon size'),
          Text('• elevation - shadow elevation'),
          SizedBox(height: 16.0),

          Text(
            'BottomNavigationBarItem:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('• icon - inactive icon'),
          Text('• activeIcon - active icon'),
          Text('• label - text label'),
          Text('• backgroundColor - for shifting type'),
          Text('• tooltip - accessibility label'),
        ],
      ),
    ),
    bottomNavigationBar: basicNavBar,
  );
}
