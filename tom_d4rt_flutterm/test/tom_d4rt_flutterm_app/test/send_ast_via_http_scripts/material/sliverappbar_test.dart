// D4rt test script: Tests SliverAppBar, FlexibleSpaceBar from material
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverAppBar/FlexibleSpaceBar test executing');

  // ========== SLIVERAPPBAR ==========
  print('--- SliverAppBar Tests ---');

  // Test basic SliverAppBar
  final sliverBasic = CustomScrollView(
    slivers: [
      SliverAppBar(title: Text('Basic SliverAppBar'), expandedHeight: 150.0),
      SliverList(
        delegate: SliverChildListDelegate([
          ListTile(title: Text('Basic item 1')),
          ListTile(title: Text('Basic item 2')),
          ListTile(title: Text('Basic item 3')),
        ]),
      ),
    ],
  );
  print('SliverAppBar basic created');

  // Test SliverAppBar with floating
  final sliverFloating = CustomScrollView(
    slivers: [
      SliverAppBar(
        title: Text('Floating'),
        floating: true,
        expandedHeight: 120.0,
      ),
      SliverList(
        delegate: SliverChildListDelegate([
          ListTile(title: Text('Floating item 1')),
          ListTile(title: Text('Floating item 2')),
          ListTile(title: Text('Floating item 3')),
          ListTile(title: Text('Floating item 4')),
          ListTile(title: Text('Floating item 5')),
        ]),
      ),
    ],
  );
  print('SliverAppBar floating=true created');

  // Test SliverAppBar with pinned
  final sliverPinned = CustomScrollView(
    slivers: [
      SliverAppBar(title: Text('Pinned'), pinned: true, expandedHeight: 150.0),
      SliverList(
        delegate: SliverChildListDelegate([
          ListTile(title: Text('Pinned item 1')),
          ListTile(title: Text('Pinned item 2')),
          ListTile(title: Text('Pinned item 3')),
          ListTile(title: Text('Pinned item 4')),
          ListTile(title: Text('Pinned item 5')),
        ]),
      ),
    ],
  );
  print('SliverAppBar pinned=true created');

  // Test SliverAppBar with snap (requires floating=true)
  final sliverSnap = CustomScrollView(
    slivers: [
      SliverAppBar(
        title: Text('Snap'),
        floating: true,
        snap: true,
        expandedHeight: 130.0,
      ),
      SliverList(
        delegate: SliverChildListDelegate([
          ListTile(title: Text('Snap item 1')),
          ListTile(title: Text('Snap item 2')),
          ListTile(title: Text('Snap item 3')),
          ListTile(title: Text('Snap item 4')),
          ListTile(title: Text('Snap item 5')),
        ]),
      ),
    ],
  );
  print('SliverAppBar snap=true (with floating) created');

  // Test SliverAppBar with expandedHeight and FlexibleSpaceBar
  final sliverFlexible = CustomScrollView(
    slivers: [
      SliverAppBar(
        expandedHeight: 200.0,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(title: Text('Flexible Title')),
      ),
      SliverList(
        delegate: SliverChildListDelegate([
          ListTile(title: Text('Flexible item 1')),
          ListTile(title: Text('Flexible item 2')),
          ListTile(title: Text('Flexible item 3')),
          ListTile(title: Text('Flexible item 4')),
        ]),
      ),
    ],
  );
  print('SliverAppBar with FlexibleSpaceBar title created');

  // Test SliverAppBar with FlexibleSpaceBar background
  final sliverBackground = CustomScrollView(
    slivers: [
      SliverAppBar(
        expandedHeight: 200.0,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          title: Text('With Background', style: TextStyle(color: Colors.white)),
          background: Container(
            color: Colors.blue,
            child: Center(
              child: Icon(Icons.photo, size: 60.0, color: Colors.white70),
            ),
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate([
          ListTile(title: Text('Background item 1')),
          ListTile(title: Text('Background item 2')),
          ListTile(title: Text('Background item 3')),
        ]),
      ),
    ],
  );
  print('SliverAppBar with FlexibleSpaceBar background created');

  // Test SliverAppBar with actions
  final sliverActions = CustomScrollView(
    slivers: [
      SliverAppBar(
        title: Text('With Actions'),
        pinned: true,
        expandedHeight: 160.0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print('Search pressed');
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              print('More pressed');
            },
          ),
        ],
      ),
      SliverList(
        delegate: SliverChildListDelegate([
          ListTile(title: Text('Actions item 1')),
          ListTile(title: Text('Actions item 2')),
          ListTile(title: Text('Actions item 3')),
        ]),
      ),
    ],
  );
  print('SliverAppBar with actions created');

  // Test SliverAppBar with leading
  final sliverLeading = CustomScrollView(
    slivers: [
      SliverAppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            print('Back pressed');
          },
        ),
        title: Text('With Leading'),
        expandedHeight: 120.0,
      ),
      SliverList(
        delegate: SliverChildListDelegate([
          ListTile(title: Text('Leading item 1')),
          ListTile(title: Text('Leading item 2')),
        ]),
      ),
    ],
  );
  print('SliverAppBar with leading icon created');

  // Test SliverAppBar with backgroundColor and foregroundColor
  final sliverColored = CustomScrollView(
    slivers: [
      SliverAppBar(
        title: Text('Colored'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        pinned: true,
        expandedHeight: 150.0,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(color: Colors.deepPurple),
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate([
          ListTile(title: Text('Colored item 1')),
          ListTile(title: Text('Colored item 2')),
          ListTile(title: Text('Colored item 3')),
        ]),
      ),
    ],
  );
  print('SliverAppBar with colors created');

  // ========== FLEXIBLESPACEBAR ==========
  print('--- FlexibleSpaceBar Tests ---');

  // Test FlexibleSpaceBar with centerTitle
  final flexCenter = CustomScrollView(
    slivers: [
      SliverAppBar(
        expandedHeight: 180.0,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          title: Text('Centered Title'),
          centerTitle: true,
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate([
          ListTile(title: Text('Center title item 1')),
          ListTile(title: Text('Center title item 2')),
        ]),
      ),
    ],
  );
  print('FlexibleSpaceBar with centerTitle=true created');

  // Test FlexibleSpaceBar with collapseMode parallax
  final flexParallax = CustomScrollView(
    slivers: [
      SliverAppBar(
        expandedHeight: 200.0,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          title: Text('Parallax', style: TextStyle(color: Colors.white)),
          collapseMode: CollapseMode.parallax,
          background: Container(
            color: Colors.teal,
            child: Center(
              child: Icon(Icons.landscape, size: 80.0, color: Colors.white54),
            ),
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate([
          ListTile(title: Text('Parallax item 1')),
          ListTile(title: Text('Parallax item 2')),
          ListTile(title: Text('Parallax item 3')),
        ]),
      ),
    ],
  );
  print('FlexibleSpaceBar with collapseMode=parallax created');

  // Test FlexibleSpaceBar with collapseMode pin
  final flexPin = CustomScrollView(
    slivers: [
      SliverAppBar(
        expandedHeight: 180.0,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          title: Text('Pin Mode', style: TextStyle(color: Colors.white)),
          collapseMode: CollapseMode.pin,
          background: Container(
            color: Colors.indigo,
            child: Center(
              child: Icon(Icons.push_pin, size: 60.0, color: Colors.white54),
            ),
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate([
          ListTile(title: Text('Pin item 1')),
          ListTile(title: Text('Pin item 2')),
        ]),
      ),
    ],
  );
  print('FlexibleSpaceBar with collapseMode=pin created');

  // Test FlexibleSpaceBar with titlePadding
  final flexPadding = CustomScrollView(
    slivers: [
      SliverAppBar(
        expandedHeight: 180.0,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          title: Text('Custom Padding'),
          titlePadding: EdgeInsets.only(left: 20.0, bottom: 16.0),
          background: Container(color: Colors.orange),
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate([
          ListTile(title: Text('Padding item 1')),
          ListTile(title: Text('Padding item 2')),
        ]),
      ),
    ],
  );
  print('FlexibleSpaceBar with titlePadding created');

  print('All SliverAppBar/FlexibleSpaceBar tests completed');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '=== SliverAppBar Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Basic:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 250.0, child: sliverBasic),
        SizedBox(height: 8.0),
        Text('Floating:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 250.0, child: sliverFloating),
        SizedBox(height: 8.0),
        Text('Pinned:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 250.0, child: sliverPinned),
        SizedBox(height: 8.0),
        Text('Snap:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 250.0, child: sliverSnap),
        SizedBox(height: 8.0),
        Text('Flexible title:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 280.0, child: sliverFlexible),
        SizedBox(height: 8.0),
        Text('With background:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 280.0, child: sliverBackground),
        SizedBox(height: 8.0),
        Text('With actions:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 250.0, child: sliverActions),
        SizedBox(height: 8.0),
        Text('With leading:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 200.0, child: sliverLeading),
        SizedBox(height: 8.0),
        Text('Colored:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 250.0, child: sliverColored),
        SizedBox(height: 16.0),
        Text(
          '=== FlexibleSpaceBar Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Center title:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 250.0, child: flexCenter),
        SizedBox(height: 8.0),
        Text(
          'Parallax collapse:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 280.0, child: flexParallax),
        SizedBox(height: 8.0),
        Text('Pin collapse:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 250.0, child: flexPin),
        SizedBox(height: 8.0),
        Text('Title padding:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 250.0, child: flexPadding),
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• SliverAppBar collapses/expands inside CustomScrollView'),
        Text('• expandedHeight sets the expanded size'),
        Text('• floating shows bar when scrolling up'),
        Text('• pinned keeps collapsed bar visible'),
        Text('• snap snaps to full expanded/collapsed size'),
        Text('• FlexibleSpaceBar provides collapsing content area'),
        Text('• collapseMode controls how background collapses'),
      ],
    ),
  );
}
