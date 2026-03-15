// D4rt test script: Tests PageView, PageController, TabBarView, TabBar advanced,
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// TabController, DefaultTabController, PageScrollPhysics, PageStorageKey
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PageView and TabView test executing');

  // ========== PageController ==========
  print('--- PageController Tests ---');
  final pageController = PageController(
    initialPage: 0,
    keepPage: true,
    viewportFraction: 1.0,
  );
  print('PageController created');
  print('  initialPage: ${pageController.initialPage}');
  print('  keepPage: ${pageController.keepPage}');
  print('  viewportFraction: ${pageController.viewportFraction}');

  // ========== PageView ==========
  print('--- PageView Tests ---');
  final pageView = PageView(
    controller: pageController,
    scrollDirection: Axis.horizontal,
    reverse: false,
    physics: PageScrollPhysics(),
    pageSnapping: true,
    onPageChanged: (page) => print('  Page changed: $page'),
    padEnds: true,
    clipBehavior: Clip.hardEdge,
    allowImplicitScrolling: false,
    children: [
      Container(
        color: Colors.red,
        child: Center(child: Text('Page 1')),
      ),
      Container(
        color: Colors.green,
        child: Center(child: Text('Page 2')),
      ),
      Container(
        color: Colors.blue,
        child: Center(child: Text('Page 3')),
      ),
    ],
  );
  print('PageView created');

  // ========== PageView.builder ==========
  print('--- PageView.builder Tests ---');
  final pageViewBuilder = PageView.builder(
    controller: PageController(initialPage: 0, viewportFraction: 0.85),
    itemCount: 10,
    itemBuilder: (context, index) => Card(
      margin: EdgeInsets.all(16),
      child: Center(child: Text('Page $index')),
    ),
    onPageChanged: (page) => print('  Builder page: $page'),
  );
  print('PageView.builder created');

  // ========== PageView.custom ==========
  print('--- PageView.custom Tests ---');
  final pageViewCustom = PageView.custom(
    controller: PageController(),
    childrenDelegate: SliverChildBuilderDelegate(
      (context, index) => Container(
        color: Colors.primaries[index % Colors.primaries.length],
        child: Center(child: Text('Custom $index')),
      ),
      childCount: 5,
    ),
  );
  print('PageView.custom created');

  // ========== PageScrollPhysics ==========
  print('--- PageScrollPhysics Tests ---');
  final pagePhysics = PageScrollPhysics(parent: BouncingScrollPhysics());
  print('PageScrollPhysics created');

  // ========== PageStorageKey ==========
  print('--- PageStorageKey Tests ---');
  final storageKey = PageStorageKey<String>('myPage');
  print('PageStorageKey created: value=${storageKey.value}');

  // ========== DefaultTabController ==========
  print('--- DefaultTabController Tests ---');
  final tabScaffold = DefaultTabController(
    length: 3,
    initialIndex: 0,
    animationDuration: Duration(milliseconds: 300),
    child: Scaffold(
      appBar: AppBar(
        title: Text('Tabs'),
        bottom: TabBar(
          tabs: [
            Tab(text: 'Tab 1', icon: Icon(Icons.home)),
            Tab(text: 'Tab 2', icon: Icon(Icons.search)),
            Tab(text: 'Tab 3', icon: Icon(Icons.settings)),
          ],
          isScrollable: false,
          indicatorColor: Colors.white,
          indicatorWeight: 3.0,
          indicatorPadding: EdgeInsets.symmetric(horizontal: 8),
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 3, color: Colors.white),
            borderRadius: BorderRadius.circular(2),
            insets: EdgeInsets.symmetric(horizontal: 16),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
          labelPadding: EdgeInsets.symmetric(horizontal: 16),
          padding: EdgeInsets.zero,
          overlayColor: WidgetStateProperty.all(Colors.white24),
          splashBorderRadius: BorderRadius.circular(8),
          dividerColor: Colors.transparent,
          dividerHeight: 0,
          tabAlignment: TabAlignment.fill,
          onTap: (index) => print('  Tab tapped: $index'),
        ),
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          Center(child: Text('Content 1')),
          Center(child: Text('Content 2')),
          Center(child: Text('Content 3')),
        ],
      ),
    ),
  );
  print('DefaultTabController with TabBar and TabBarView created');

  // ========== Tab widget ==========
  print('--- Tab Tests ---');
  final tab1 = Tab(text: 'Text Tab');
  final tab2 = Tab(icon: Icon(Icons.star));
  final tab3 = Tab(
    text: 'Both',
    icon: Icon(Icons.favorite),
    iconMargin: EdgeInsets.only(bottom: 4),
  );
  final tab4 = Tab(
    child: Row(
      children: [Icon(Icons.info), SizedBox(width: 4), Text('Custom')],
    ),
  );
  print('Tab widgets created: 4 variants');

  // ========== UnderlineTabIndicator ==========
  print('--- UnderlineTabIndicator Tests ---');
  final indicator = UnderlineTabIndicator(
    borderSide: BorderSide(width: 3, color: Colors.blue),
    borderRadius: BorderRadius.circular(2),
    insets: EdgeInsets.symmetric(horizontal: 16),
  );
  print('UnderlineTabIndicator created');

  // ========== TabBarIndicatorSize ==========
  print('--- TabBarIndicatorSize Tests ---');
  print('  TabBarIndicatorSize.tab: ${TabBarIndicatorSize.tab}');
  print('  TabBarIndicatorSize.label: ${TabBarIndicatorSize.label}');

  // ========== TabAlignment ==========
  print('--- TabAlignment Tests ---');
  for (final alignment in TabAlignment.values) {
    print('  TabAlignment.$alignment');
  }

  print('All page view / tab view tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(home: tabScaffold);
}
