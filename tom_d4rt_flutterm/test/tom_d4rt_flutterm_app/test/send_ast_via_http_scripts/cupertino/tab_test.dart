// D4rt test script: Tests CupertinoTabController, CupertinoTabScaffold, CupertinoTabBar, CupertinoTabView from cupertino
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino tab test executing');

  // ========== CUPERTINOTABCONTROLLER ==========
  print('--- CupertinoTabController Tests ---');

  // Test basic CupertinoTabController
  final tabController = CupertinoTabController();
  print('Basic CupertinoTabController created');
  print('  initial index: ${tabController.index}');

  // Test CupertinoTabController with initialIndex
  final indexedController = CupertinoTabController(initialIndex: 2);
  print('CupertinoTabController with initialIndex=2 created');
  print('  index: ${indexedController.index}');

  // Test setting index
  tabController.index = 1;
  print('tabController.index set to 1: ${tabController.index}');

  // Reset index
  tabController.index = 0;
  print('tabController.index reset to 0: ${tabController.index}');

  // ========== CUPERTINOTABBAR ==========
  print('--- CupertinoTabBar Tests ---');

  // Test basic CupertinoTabBar
  final basicTabBar = CupertinoTabBar(
    items: [
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search),
        label: 'Search',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.settings),
        label: 'Settings',
      ),
    ],
  );
  print('Basic CupertinoTabBar created');

  // Test CupertinoTabBar with currentIndex
  final indexedTabBar = CupertinoTabBar(
    currentIndex: 1,
    items: [
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.heart),
        label: 'Favorites',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.person),
        label: 'Profile',
      ),
    ],
  );
  print('CupertinoTabBar with currentIndex=1 created');

  // Test CupertinoTabBar with backgroundColor
  final bgTabBar = CupertinoTabBar(
    backgroundColor: CupertinoColors.systemGroupedBackground,
    items: [
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search),
        label: 'Search',
      ),
    ],
  );
  print('CupertinoTabBar with backgroundColor created');

  // Test CupertinoTabBar with activeColor and inactiveColor
  final coloredTabBar = CupertinoTabBar(
    activeColor: CupertinoColors.systemRed,
    inactiveColor: CupertinoColors.systemGrey,
    items: [
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.doc), label: 'Docs'),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.folder),
        label: 'Files',
      ),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.cloud), label: 'Cloud'),
    ],
  );
  print('CupertinoTabBar with activeColor/inactiveColor created');

  // Test CupertinoTabBar with iconSize
  final iconSizeTabBar = CupertinoTabBar(
    iconSize: 32.0,
    items: [
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.bell), label: 'Alerts'),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.mail), label: 'Mail'),
    ],
  );
  print('CupertinoTabBar with iconSize created');

  // Test CupertinoTabBar with onTap
  final tappableTabBar = CupertinoTabBar(
    onTap: (int index) {
      print('Tab tapped: $index');
    },
    items: [
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.gear),
        label: 'Settings',
      ),
    ],
  );
  print('CupertinoTabBar with onTap created');

  // ========== CUPERTINOTABSCAFFOLD ==========
  print('--- CupertinoTabScaffold Tests ---');

  // Test basic CupertinoTabScaffold
  final basicTabScaffold = CupertinoTabScaffold(
    tabBar: CupertinoTabBar(
      items: [
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.settings),
          label: 'Settings',
        ),
      ],
    ),
    tabBuilder: (BuildContext context, int index) {
      return CupertinoTabView(
        builder: (BuildContext context) {
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(middle: Text('Tab $index')),
            child: Center(child: Text('Content for tab $index')),
          );
        },
      );
    },
  );
  print('Basic CupertinoTabScaffold created');

  // Test CupertinoTabScaffold with controller
  final controllerTabScaffold = CupertinoTabScaffold(
    controller: tabController,
    tabBar: CupertinoTabBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.book),
          label: 'Library',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.music_note),
          label: 'Music',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.video_camera),
          label: 'Video',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.photo),
          label: 'Photos',
        ),
      ],
    ),
    tabBuilder: (BuildContext context, int index) {
      final titles = ['Library', 'Music', 'Video', 'Photos'];
      return CupertinoTabView(
        builder: (BuildContext context) {
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(middle: Text(titles[index])),
            child: Center(child: Text('Content: ${titles[index]}')),
          );
        },
      );
    },
  );
  print('CupertinoTabScaffold with controller created');

  // Test CupertinoTabScaffold with backgroundColor
  final bgTabScaffold = CupertinoTabScaffold(
    backgroundColor: CupertinoColors.systemBackground,
    tabBar: CupertinoTabBar(
      items: [
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.person),
          label: 'Profile',
        ),
      ],
    ),
    tabBuilder: (BuildContext context, int index) {
      return CupertinoTabView(
        builder: (BuildContext context) {
          return Center(child: Text('Tab $index'));
        },
      );
    },
  );
  print('CupertinoTabScaffold with backgroundColor created');

  // Test CupertinoTabScaffold with resizeToAvoidBottomInset
  final resizeTabScaffold = CupertinoTabScaffold(
    resizeToAvoidBottomInset: false,
    tabBar: CupertinoTabBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.chat_bubble),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.person_2),
          label: 'Contacts',
        ),
      ],
    ),
    tabBuilder: (BuildContext context, int index) {
      return Center(child: Text('Tab $index'));
    },
  );
  print('CupertinoTabScaffold with resizeToAvoidBottomInset created');

  // ========== CUPERTINOTABVIEW ==========
  print('--- CupertinoTabView Tests ---');

  // Test basic CupertinoTabView
  final basicTabView = CupertinoTabView(
    builder: (BuildContext context) {
      return Center(child: Text('Tab View Content'));
    },
  );
  print('Basic CupertinoTabView created');

  // Test CupertinoTabView with defaultTitle
  final titledTabView = CupertinoTabView(
    defaultTitle: 'My Tab',
    builder: (BuildContext context) {
      return Center(child: Text('Titled Tab View'));
    },
  );
  print('CupertinoTabView with defaultTitle created');

  print('All Cupertino tab tests passed');

  // ========== RETURN WIDGET ==========
  return CupertinoApp(home: basicTabScaffold);
}
