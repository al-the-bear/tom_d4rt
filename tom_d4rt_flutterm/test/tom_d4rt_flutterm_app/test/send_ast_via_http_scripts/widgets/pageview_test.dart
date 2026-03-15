// D4rt test script: Tests PageView widget from widgets
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PageView test executing');

  // Test basic PageView
  final basicPageView = PageView(
    children: [
      Container(
        color: Colors.red,
        child: Center(
          child: Text(
            'Page 1',
            style: TextStyle(fontSize: 24.0, color: Colors.white),
          ),
        ),
      ),
      Container(
        color: Colors.green,
        child: Center(
          child: Text(
            'Page 2',
            style: TextStyle(fontSize: 24.0, color: Colors.white),
          ),
        ),
      ),
      Container(
        color: Colors.blue,
        child: Center(
          child: Text(
            'Page 3',
            style: TextStyle(fontSize: 24.0, color: Colors.white),
          ),
        ),
      ),
    ],
  );
  print('Basic PageView with 3 children created');

  // Test PageView with controller
  final controller = PageController(initialPage: 1, viewportFraction: 0.9);
  print('PageController created: initialPage=1, viewportFraction=0.9');

  final withController = PageView(
    controller: controller,
    children: [
      Container(
        color: Colors.orange,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
      ),
      Container(
        color: Colors.purple,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
      ),
      Container(
        color: Colors.teal,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
      ),
    ],
  );
  print('PageView with controller created');

  // Test PageView.builder
  final pageViewBuilder = PageView.builder(
    itemCount: 10,
    itemBuilder: (context, index) {
      return Container(
        color: Colors.primaries[index % Colors.primaries.length],
        child: Center(
          child: Text(
            'Page $index',
            style: TextStyle(fontSize: 24.0, color: Colors.white),
          ),
        ),
      );
    },
  );
  print('PageView.builder with 10 items created');

  // Test PageView.custom
  final pageViewCustom = PageView.custom(
    childrenDelegate: SliverChildBuilderDelegate((context, index) {
      return Container(
        color: Colors.accents[index % Colors.accents.length],
        child: Center(child: Text('Custom $index')),
      );
    }, childCount: 5),
  );
  print('PageView.custom with SliverChildBuilderDelegate created');

  // Test PageView with scrollDirection
  final horizontalPageView = PageView(
    scrollDirection: Axis.horizontal,
    children: [
      Container(
        color: Colors.red.shade200,
        child: Center(child: Text('Horizontal 1')),
      ),
      Container(
        color: Colors.red.shade300,
        child: Center(child: Text('Horizontal 2')),
      ),
      Container(
        color: Colors.red.shade400,
        child: Center(child: Text('Horizontal 3')),
      ),
    ],
  );
  print('PageView with scrollDirection=Axis.horizontal created');

  final verticalPageView = PageView(
    scrollDirection: Axis.vertical,
    children: [
      Container(
        color: Colors.blue.shade200,
        child: Center(child: Text('Vertical 1')),
      ),
      Container(
        color: Colors.blue.shade300,
        child: Center(child: Text('Vertical 2')),
      ),
      Container(
        color: Colors.blue.shade400,
        child: Center(child: Text('Vertical 3')),
      ),
    ],
  );
  print('PageView with scrollDirection=Axis.vertical created');

  // Test PageView with physics
  final bouncingPhysics = PageView(
    physics: BouncingScrollPhysics(),
    children: [
      Container(
        color: Colors.amber.shade200,
        child: Center(child: Text('Bouncing 1')),
      ),
      Container(
        color: Colors.amber.shade300,
        child: Center(child: Text('Bouncing 2')),
      ),
    ],
  );
  print('PageView with BouncingScrollPhysics created');

  final clampingPhysics = PageView(
    physics: ClampingScrollPhysics(),
    children: [
      Container(
        color: Colors.green.shade200,
        child: Center(child: Text('Clamping 1')),
      ),
      Container(
        color: Colors.green.shade300,
        child: Center(child: Text('Clamping 2')),
      ),
    ],
  );
  print('PageView with ClampingScrollPhysics created');

  final neverScroll = PageView(
    physics: NeverScrollableScrollPhysics(),
    children: [
      Container(
        color: Colors.grey.shade300,
        child: Center(child: Text('Never Scroll')),
      ),
    ],
  );
  print('PageView with NeverScrollableScrollPhysics created');

  // Test PageView with onPageChanged
  final withCallback = PageView(
    onPageChanged: (int page) {
      print('PageView page changed to: $page');
    },
    children: [
      Container(
        color: Colors.cyan.shade200,
        child: Center(child: Text('Callback 1')),
      ),
      Container(
        color: Colors.cyan.shade300,
        child: Center(child: Text('Callback 2')),
      ),
      Container(
        color: Colors.cyan.shade400,
        child: Center(child: Text('Callback 3')),
      ),
    ],
  );
  print('PageView with onPageChanged callback created');

  // Test PageView with reverse
  final reversePageView = PageView(
    reverse: true,
    children: [
      Container(
        color: Colors.pink.shade200,
        child: Center(child: Text('Reverse 1')),
      ),
      Container(
        color: Colors.pink.shade300,
        child: Center(child: Text('Reverse 2')),
      ),
      Container(
        color: Colors.pink.shade400,
        child: Center(child: Text('Reverse 3')),
      ),
    ],
  );
  print('PageView with reverse=true created');

  // Test PageView with pageSnapping
  final noSnapping = PageView(
    pageSnapping: false,
    children: [
      Container(
        color: Colors.lime.shade200,
        child: Center(child: Text('No Snap 1')),
      ),
      Container(
        color: Colors.lime.shade300,
        child: Center(child: Text('No Snap 2')),
      ),
    ],
  );
  print('PageView with pageSnapping=false created');

  // Test PageController methods
  print('PageController.jumpToPage(2) - instant jump');
  print('PageController.animateToPage(2) - animated scroll');
  print('PageController.nextPage() - go to next');
  print('PageController.previousPage() - go to previous');

  // Test PageController with keepPage
  final keepPageController = PageController(initialPage: 0, keepPage: true);
  print('PageController with keepPage=true created');

  // Test padEnds
  final padEndsPageView = PageView(
    controller: PageController(viewportFraction: 0.8),
    padEnds: true,
    children: [
      Container(
        color: Colors.indigo.shade200,
        child: Center(child: Text('Pad 1')),
      ),
      Container(
        color: Colors.indigo.shade300,
        child: Center(child: Text('Pad 2')),
      ),
      Container(
        color: Colors.indigo.shade400,
        child: Center(child: Text('Pad 3')),
      ),
    ],
  );
  print('PageView with padEnds=true created');

  // Test allowImplicitScrolling
  final implicitScroll = PageView(
    allowImplicitScrolling: true,
    children: [
      Container(
        color: Colors.brown.shade200,
        child: Center(child: Text('Implicit 1')),
      ),
      Container(
        color: Colors.brown.shade300,
        child: Center(child: Text('Implicit 2')),
      ),
    ],
  );
  print('PageView with allowImplicitScrolling=true created');

  print('PageView test completed');

  return Column(
    children: [
      Expanded(flex: 3, child: basicPageView),
      Expanded(flex: 2, child: withController),
      Expanded(flex: 2, child: pageViewBuilder),
    ],
  );
}
