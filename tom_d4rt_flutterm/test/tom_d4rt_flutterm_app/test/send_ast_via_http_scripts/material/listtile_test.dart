// D4rt test script: Tests ListTile widget from material
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ListTile test executing');

  // Test basic ListTile
  final basicTile = ListTile(title: Text('Basic ListTile'));
  print('Basic ListTile created');

  // Test ListTile with subtitle
  final subtitleTile = ListTile(
    title: Text('Title'),
    subtitle: Text('Subtitle text goes here'),
  );
  print('ListTile with subtitle created');

  // Test ListTile with leading
  final leadingTile = ListTile(
    leading: Icon(Icons.person),
    title: Text('With Leading Icon'),
  );
  print('ListTile with leading icon created');

  // Test ListTile with trailing
  final trailingTile = ListTile(
    title: Text('With Trailing'),
    trailing: Icon(Icons.arrow_forward_ios),
  );
  print('ListTile with trailing icon created');

  // Test ListTile with leading and trailing
  final fullTile = ListTile(
    leading: CircleAvatar(child: Text('A')),
    title: Text('Full ListTile'),
    subtitle: Text('With all components'),
    trailing: Icon(Icons.more_vert),
  );
  print('Full ListTile with all components created');

  // Test ListTile with onTap
  final tappableTile = ListTile(
    leading: Icon(Icons.touch_app),
    title: Text('Tappable Tile'),
    onTap: () {
      print('ListTile tapped');
    },
  );
  print('ListTile with onTap created');

  // Test ListTile with onLongPress
  final longPressTile = ListTile(
    title: Text('Long Press Tile'),
    onLongPress: () {
      print('ListTile long pressed');
    },
  );
  print('ListTile with onLongPress created');

  // Test ListTile with selected
  final selectedTile = ListTile(
    leading: Icon(Icons.check_circle),
    title: Text('Selected Tile'),
    selected: true,
    selectedTileColor: Colors.blue.shade50,
    selectedColor: Colors.blue,
  );
  print('ListTile with selected=true created');

  // Test ListTile with enabled
  final disabledTile = ListTile(title: Text('Disabled Tile'), enabled: false);
  print('ListTile with enabled=false created');

  // Test ListTile with dense
  final denseTile = ListTile(title: Text('Dense Tile'), dense: true);
  print('ListTile with dense=true created');

  // Test ListTile with visualDensity
  final compactTile = ListTile(
    title: Text('Compact Tile'),
    visualDensity: VisualDensity.compact,
  );
  print('ListTile with visualDensity=compact created');

  // Test ListTile with contentPadding
  final paddedTile = ListTile(
    title: Text('Custom Padding'),
    contentPadding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
  );
  print('ListTile with contentPadding created');

  // Test ListTile with tileColor
  final coloredTile = ListTile(
    title: Text('Colored Tile'),
    tileColor: Colors.amber.shade100,
  );
  print('ListTile with tileColor created');

  // Test ListTile with shape
  final shapedTile = ListTile(
    title: Text('Shaped Tile'),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
      side: BorderSide(color: Colors.grey),
    ),
    tileColor: Colors.grey.shade100,
  );
  print('ListTile with shape created');

  // Test ListTile with isThreeLine
  final threeLineTile = ListTile(
    isThreeLine: true,
    leading: CircleAvatar(child: Icon(Icons.email)),
    title: Text('Three Line Tile'),
    subtitle: Text(
      'This is a subtitle that can span multiple lines to show more information about this item',
    ),
  );
  print('ListTile with isThreeLine=true created');

  // Test ListTile with minLeadingWidth
  final minLeadingTile = ListTile(
    leading: Icon(Icons.star),
    title: Text('Min Leading Width'),
    minLeadingWidth: 56.0,
  );
  print('ListTile with minLeadingWidth=56 created');

  // Test ListTile with minVerticalPadding
  final verticalPaddingTile = ListTile(
    title: Text('Vertical Padding'),
    minVerticalPadding: 20.0,
  );
  print('ListTile with minVerticalPadding=20 created');

  // Test ListTile with horizontalTitleGap
  final titleGapTile = ListTile(
    leading: Icon(Icons.folder),
    title: Text('Title Gap'),
    horizontalTitleGap: 24.0,
  );
  print('ListTile with horizontalTitleGap=24 created');

  // Test ListTile with style
  final styledListTile = ListTile(
    style: ListTileStyle.drawer,
    leading: Icon(Icons.settings),
    title: Text('Drawer Style'),
  );
  print('ListTile with style=drawer created');

  // Test ListTile with focusColor and hoverColor
  final hoverTile = ListTile(
    title: Text('Hover/Focus Colors'),
    focusColor: Colors.green.withOpacity(0.2),
    hoverColor: Colors.green.withOpacity(0.1),
    onTap: () {},
  );
  print('ListTile with hover/focus colors created');

  // Test ListTile with splashColor
  final splashTile = ListTile(
    title: Text('Splash Color'),
    splashColor: Colors.purple.withOpacity(0.3),
    onTap: () {},
  );
  print('ListTile with splashColor created');

  print('ListTile test completed');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'ListTile Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        basicTile,
        Divider(height: 1.0),
        subtitleTile,
        Divider(height: 1.0),
        leadingTile,
        Divider(height: 1.0),
        trailingTile,
        Divider(height: 1.0),
        fullTile,
        Divider(height: 1.0),
        tappableTile,
        Divider(height: 1.0),
        selectedTile,
        Divider(height: 1.0),
        disabledTile,
        Divider(height: 1.0),
        denseTile,
        Divider(height: 1.0),
        coloredTile,
        Divider(height: 1.0),
        shapedTile,
        Divider(height: 1.0),
        threeLineTile,
        Divider(height: 1.0),
        paddedTile,
      ],
    ),
  );
}
