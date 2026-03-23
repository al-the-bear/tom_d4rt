// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderNestedScrollViewViewport through NestedScrollView widget
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// RenderNestedScrollViewViewport is the internal render object used by NestedScrollView
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('RenderNestedScrollViewViewport test executing');

  // NestedScrollView creates RenderNestedScrollViewViewport internally
  // We test via the widget API as direct instantiation requires complex setup

  // Track scroll position
  final outerController = ScrollController();
  final innerScrollKey = GlobalKey();

  // Variation 1: Basic NestedScrollView with floating SliverAppBar
  final widget1 = NestedScrollView(
    controller: outerController,
    headerSliverBuilder: (context, innerBoxIsScrolled) => [
      SliverAppBar(
        title: Text('Floating Header'),
        floating: true,
        forceElevated: innerBoxIsScrolled,
        expandedHeight: 120.0,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
      ),
    ],
    body: Builder(
      builder: (context) {
        // Access NestedScrollView internals
        final parentController = PrimaryScrollController.maybeOf(context);
        print('NestedScrollView parent controller: $parentController');
        return ListView.builder(
          key: innerScrollKey,
          itemCount: 20,
          itemBuilder: (context, index) => ListTile(
            title: Text('Item $index'),
            leading: CircleAvatar(child: Text('$index')),
          ),
        );
      },
    ),
  );
  print('NestedScrollView (floating) created');

  // Variation 2: NestedScrollView with pinned SliverAppBar
  final widget2 = NestedScrollView(
    headerSliverBuilder: (context, innerBoxIsScrolled) => [
      SliverAppBar(
        title: Text('Pinned Header'),
        pinned: true,
        expandedHeight: 150.0,
        backgroundColor: Colors.teal,
        flexibleSpace: FlexibleSpaceBar(
          title: Text('Expanded', style: TextStyle(fontSize: 12)),
          background: Container(color: Colors.teal.shade300),
          collapseMode: CollapseMode.parallax,
        ),
      ),
    ],
    body: ListView(
      children: List.generate(
        15,
        (i) => Container(
          height: 60,
          color: i.isEven ? Colors.grey.shade200 : Colors.grey.shade100,
          child: Center(child: Text('Content $i')),
        ),
      ),
    ),
  );
  print('NestedScrollView (pinned) created');

  // Variation 3: NestedScrollView with multiple slivers
  final widget3 = NestedScrollView(
    headerSliverBuilder: (context, innerBoxIsScrolled) => [
      SliverAppBar(
        title: Text('Multi-Sliver'),
        floating: true,
        snap: true,
        backgroundColor: Colors.deepOrange,
      ),
      SliverToBoxAdapter(
        child: Container(
          height: 80,
          color: Colors.orange.shade200,
          child: Center(
            child: Text(
              'Secondary Header Section',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
      SliverPersistentHeader(
        pinned: true,
        delegate: _SliverPersistentHeaderDelegate(
          minHeight: 40,
          maxHeight: 60,
          child: Container(
            color: Colors.amber,
            alignment: Alignment.center,
            child: Text('Persistent Sub-header'),
          ),
        ),
      ),
    ],
    body: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.0,
      ),
      itemCount: 20,
      itemBuilder: (context, index) => Card(
        margin: EdgeInsets.all(4),
        child: Center(child: Text('Grid $index')),
      ),
    ),
  );
  print('NestedScrollView (multi-sliver) created');

  // Variation 4: NestedScrollView with SliverOverlapAbsorber/Injector
  final widget4 = NestedScrollView(
    floatHeaderSlivers: true,
    headerSliverBuilder: (context, innerBoxIsScrolled) => [
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        sliver: SliverAppBar(
          title: Text('Overlap Absorber'),
          floating: true,
          snap: true,
          pinned: false,
          expandedHeight: 100,
          forceElevated: innerBoxIsScrolled,
        ),
      ),
    ],
    body: Builder(
      builder: (context) {
        return CustomScrollView(
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) =>
                    ListTile(title: Text('Overlap Item $index')),
                childCount: 25,
              ),
            ),
          ],
        );
      },
    ),
  );
  print('NestedScrollView (overlap absorber) created');

  // Test scroll physics interaction
  print('Testing scroll physics...');
  // NestedScrollView with custom physics
  final _ = NestedScrollView(
    physics: BouncingScrollPhysics(),
    headerSliverBuilder: (context, _) => [
      SliverAppBar(title: Text('Bouncing'), floating: true),
    ],
    body: ListView(children: [Container(height: 200, color: Colors.cyan)]),
  );
  print('BouncingScrollPhysics applied');

  print('RenderNestedScrollViewViewport test completed');

  // ========== RETURN WIDGET ==========
  return DefaultTabController(
    length: 4,
    child: Scaffold(
      appBar: AppBar(
        title: Text('RenderNestedScrollViewViewport'),
        bottom: TabBar(
          isScrollable: true,
          tabs: [
            Tab(text: 'Floating'),
            Tab(text: 'Pinned'),
            Tab(text: 'Multi-Sliver'),
            Tab(text: 'Overlap'),
          ],
        ),
      ),
      body: TabBarView(children: [widget1, widget2, widget3, widget4]),
    ),
  );
}

// Helper delegate for SliverPersistentHeader
class _SliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverPersistentHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
