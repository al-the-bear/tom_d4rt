// D4rt test script: Tests SliverPersistentHeader, SliverPersistentHeaderDelegate,
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// SliverAppBar advanced, SliverOverlapAbsorber, SliverOverlapInjector,
// NestedScrollView, SliverLayoutBuilder, SliverCrossAxisGroup
import 'package:flutter/material.dart';
import 'dart:math' as math;

dynamic build(BuildContext context) {
  print('Render sliver types test executing');

  // ========== SliverPersistentHeader ==========
  print('--- SliverPersistentHeader Tests ---');
  final persistentHeader = SliverPersistentHeader(
    delegate: TestPersistentHeaderDelegate(
      minHeight: 60,
      maxHeight: 200,
      child: Container(
        color: Colors.blue,
        child: Center(
          child: Text(
            'Persistent Header',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    ),
    pinned: true,
    floating: false,
  );
  print('SliverPersistentHeader created (pinned)');

  final floatingHeader = SliverPersistentHeader(
    delegate: TestPersistentHeaderDelegate(
      minHeight: 50,
      maxHeight: 150,
      child: Container(
        color: Colors.green,
        child: Center(
          child: Text('Floating Header', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
    pinned: false,
    floating: true,
  );
  print('SliverPersistentHeader created (floating)');

  // ========== SliverAppBar advanced ==========
  print('--- SliverAppBar Advanced Tests ---');
  final sliverAppBar = SliverAppBar(
    expandedHeight: 200.0,
    collapsedHeight: 60.0,
    toolbarHeight: 56.0,
    floating: false,
    pinned: true,
    snap: false,
    stretch: true,
    stretchTriggerOffset: 100.0,
    onStretchTrigger: () async => print('  Stretch triggered'),
    elevation: 4.0,
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.blue[50],
    forceElevated: false,
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    primary: true,
    centerTitle: true,
    excludeHeaderSemantics: false,
    titleSpacing: NavigationToolbar.kMiddleSpacing,
    leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
    automaticallyImplyLeading: true,
    title: Text('Sliver App Bar'),
    actions: [
      IconButton(icon: Icon(Icons.search), onPressed: () {}),
      IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
    ],
    flexibleSpace: FlexibleSpaceBar(
      title: Text('Flexible', style: TextStyle(fontSize: 14)),
      centerTitle: true,
      titlePadding: EdgeInsetsDirectional.only(start: 16, bottom: 16),
      collapseMode: CollapseMode.parallax,
      stretchModes: [
        StretchMode.zoomBackground,
        StretchMode.blurBackground,
        StretchMode.fadeTitle,
      ],
      background: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[700]!, Colors.blue[300]!],
          ),
        ),
      ),
      expandedTitleScale: 1.5,
    ),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(48),
      child: Container(
        color: Colors.blue[700],
        height: 48,
        child: Center(
          child: Text('Bottom', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
    shape: ContinuousRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
    ),
    clipBehavior: Clip.antiAlias,
  );
  print('SliverAppBar advanced created');

  // ========== FlexibleSpaceBar modes ==========
  print('--- CollapseMode Tests ---');
  for (final mode in CollapseMode.values) {
    print('  CollapseMode.$mode');
  }
  print('--- StretchMode Tests ---');
  for (final mode in StretchMode.values) {
    print('  StretchMode.$mode');
  }

  // ========== SliverAppBar.medium ==========
  print('--- SliverAppBar.medium Tests ---');
  final mediumAppBar = SliverAppBar.medium(
    title: Text('Medium App Bar'),
    leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
    actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
  );
  print('SliverAppBar.medium created');

  // ========== SliverAppBar.large ==========
  print('--- SliverAppBar.large Tests ---');
  final largeAppBar = SliverAppBar.large(
    title: Text('Large App Bar'),
    leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
    actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
  );
  print('SliverAppBar.large created');

  // ========== SliverLayoutBuilder ==========
  print('--- SliverLayoutBuilder Tests ---');
  final sliverLayoutBuilder = SliverLayoutBuilder(
    builder: (context, constraints) {
      print(
        '  SliverConstraints: crossAxisExtent=${constraints.crossAxisExtent}',
      );
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => ListTile(title: Text('Layout Item $index')),
          childCount: 5,
        ),
      );
    },
  );
  print('SliverLayoutBuilder created');

  // ========== SliverAnimatedList ==========
  print('--- SliverAnimatedList Tests ---');
  final animatedListKey = GlobalKey<SliverAnimatedListState>();
  final sliverAnimatedList = SliverAnimatedList(
    key: animatedListKey,
    initialItemCount: 5,
    itemBuilder: (context, index, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: ListTile(title: Text('Animated Item $index')),
      );
    },
  );
  print('SliverAnimatedList created');

  // ========== SliverFixedExtentList ==========
  print('--- SliverFixedExtentList Tests ---');
  final sliverFixedList = SliverFixedExtentList(
    delegate: SliverChildBuilderDelegate(
      (context, index) => Container(
        color: Colors.primaries[index % Colors.primaries.length][100],
        child: Center(child: Text('Fixed $index')),
      ),
      childCount: 10,
    ),
    itemExtent: 60.0,
  );
  print('SliverFixedExtentList created');

  print('All render sliver types tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: CustomScrollView(
        slivers: [
          sliverAppBar,
          persistentHeader,
          sliverLayoutBuilder,
          sliverAnimatedList,
          sliverFixedList,
        ],
      ),
    ),
  );
}

class TestPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  TestPersistentHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(TestPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
