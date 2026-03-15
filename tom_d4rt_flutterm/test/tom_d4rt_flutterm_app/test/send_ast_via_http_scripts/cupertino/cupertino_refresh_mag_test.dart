// D4rt test script: Tests CupertinoSliverRefreshControl, CupertinoMagnifier,
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// CupertinoPageTransition, CupertinoFullscreenDialogTransition,
// CupertinoTabView, CupertinoTabScaffold, CupertinoTabController
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

dynamic build(BuildContext context) {
  print('Cupertino refresh/magnifier test executing');

  // ========== CupertinoSliverRefreshControl ==========
  print('--- CupertinoSliverRefreshControl Tests ---');
  final refreshControl = CupertinoSliverRefreshControl(
    refreshTriggerPullDistance: 100.0,
    refreshIndicatorExtent: 60.0,
    onRefresh: () async {
      print('  Refreshing...');
      await Future.delayed(Duration(seconds: 1));
    },
  );
  print('CupertinoSliverRefreshControl created');
  print('  refreshTriggerPullDistance: 100.0');
  print('  refreshIndicatorExtent: 60.0');

  // ========== CupertinoMagnifier ==========
  print('--- CupertinoMagnifier Tests ---');
  final magnifier = CupertinoMagnifier(
    size: Size(80, 48),
    borderRadius: BorderRadius.circular(40),
    // inOutAnimation requires Animation<double>, skip for this test
    additionalFocalPointOffset: Offset(0, -8),
  );
  print('CupertinoMagnifier created');

  // ========== CupertinoPageTransition ==========
  print('--- CupertinoPageTransition Tests ---');
  final animationController = AnimationController(
    vsync: TestVSync(),
    duration: Duration(milliseconds: 300),
  );

  final pageTransition = CupertinoPageTransition(
    primaryRouteAnimation: animationController,
    secondaryRouteAnimation: animationController,
    linearTransition: false,
    child: Container(
      color: Colors.blue,
      child: Center(child: Text('Page Content')),
    ),
  );
  print('CupertinoPageTransition created');

  // ========== CupertinoFullscreenDialogTransition ==========
  print('--- CupertinoFullscreenDialogTransition Tests ---');
  final dialogTransition = CupertinoFullscreenDialogTransition(
    primaryRouteAnimation: animationController,
    secondaryRouteAnimation: animationController,
    linearTransition: false,
    child: Container(
      color: Colors.white,
      child: Center(child: Text('Dialog Content')),
    ),
  );
  print('CupertinoFullscreenDialogTransition created');

  // ========== CupertinoTabController ==========
  print('--- CupertinoTabController Tests ---');
  final tabController = CupertinoTabController(initialIndex: 0);
  print('CupertinoTabController created: index=${tabController.index}');
  tabController.index = 1;
  print('  Set index to 1: ${tabController.index}');
  tabController.index = 0;
  tabController.dispose();
  print('  Disposed');

  // ========== CupertinoTabScaffold ==========
  print('--- CupertinoTabScaffold Tests ---');
  final tabScaffold = CupertinoTabScaffold(
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
      activeColor: CupertinoColors.activeBlue,
      inactiveColor: CupertinoColors.inactiveGray,
      backgroundColor: CupertinoColors.systemBackground,
      iconSize: 30.0,
      height: 50.0,
    ),
    tabBuilder: (context, index) {
      return CupertinoTabView(
        builder: (context) {
          return Center(child: Text('Tab $index'));
        },
      );
    },
    backgroundColor: CupertinoColors.systemBackground,
    resizeToAvoidBottomInset: true,
  );
  print('CupertinoTabScaffold created');

  // ========== CupertinoTabView ==========
  print('--- CupertinoTabView Tests ---');
  final tabView = CupertinoTabView(
    builder: (context) => Center(child: Text('Tab View')),
    routes: {'/detail': (context) => Center(child: Text('Detail'))},
    defaultTitle: 'Tab',
  );
  print('CupertinoTabView created');

  print('All cupertino refresh/magnifier tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                refreshControl,
                SliverList(
                  delegate: SliverChildListDelegate([
                    magnifier,
                    pageTransition,
                    dialogTransition,
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class TestVSync implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}
