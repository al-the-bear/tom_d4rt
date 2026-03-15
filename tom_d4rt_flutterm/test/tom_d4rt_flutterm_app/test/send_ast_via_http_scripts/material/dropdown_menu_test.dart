// D4rt test script: Tests DropdownMenu, DropdownMenuEntry, DropdownMenuThemeData,
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// MenuAnchor, MenuBar, MenuItemButton, SubmenuButton, MenuStyle
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Dropdown menu test executing');

  // ========== DropdownMenu ==========
  print('--- DropdownMenu Tests ---');
  final dropdownMenu = DropdownMenu<String>(
    initialSelection: 'opt1',
    label: Text('Select option'),
    hintText: 'Choose...',
    helperText: 'Select an item',
    errorText: null,
    width: 300,
    menuHeight: 200,
    leadingIcon: Icon(Icons.list),
    trailingIcon: Icon(Icons.arrow_drop_down),
    selectedTrailingIcon: Icon(Icons.arrow_drop_up),
    enableFilter: true,
    enableSearch: true,
    requestFocusOnTap: true,
    enabled: true,
    expandedInsets: EdgeInsets.zero,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
      filled: true,
      fillColor: Colors.grey[100],
    ),
    menuStyle: MenuStyle(
      backgroundColor: WidgetStateProperty.all(Colors.white),
      elevation: WidgetStateProperty.all(8.0),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    textStyle: TextStyle(fontSize: 16),
    onSelected: (value) => print('  Selected: $value'),
    dropdownMenuEntries: [
      DropdownMenuEntry<String>(
        value: 'opt1',
        label: 'Option 1',
        leadingIcon: Icon(Icons.looks_one),
        trailingIcon: Icon(Icons.check),
        enabled: true,
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(Colors.black),
        ),
        labelWidget: Text(
          'Custom Option 1',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DropdownMenuEntry<String>(
        value: 'opt2',
        label: 'Option 2',
        leadingIcon: Icon(Icons.looks_two),
      ),
      DropdownMenuEntry<String>(
        value: 'opt3',
        label: 'Option 3 (disabled)',
        enabled: false,
      ),
    ],
  );
  print('DropdownMenu created');

  // ========== DropdownMenuEntry ==========
  print('--- DropdownMenuEntry Tests ---');
  final entry = DropdownMenuEntry<int>(
    value: 42,
    label: 'Answer',
    leadingIcon: Icon(Icons.star),
    enabled: true,
  );
  print(
    'DropdownMenuEntry created: value=${entry.value}, label=${entry.label}',
  );

  // ========== MenuAnchor ==========
  print('--- MenuAnchor Tests ---');
  final menuAnchor = MenuAnchor(
    builder: (context, controller, child) {
      return IconButton(
        icon: Icon(Icons.more_vert),
        onPressed: () {
          if (controller.isOpen) {
            controller.close();
          } else {
            controller.open();
          }
        },
      );
    },
    menuChildren: [
      MenuItemButton(
        onPressed: () => print('  Cut'),
        leadingIcon: Icon(Icons.content_cut),
        trailingIcon: Text(
          'Ctrl+X',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        child: Text('Cut'),
      ),
      MenuItemButton(
        onPressed: () => print('  Copy'),
        leadingIcon: Icon(Icons.content_copy),
        child: Text('Copy'),
      ),
      MenuItemButton(
        onPressed: () => print('  Paste'),
        leadingIcon: Icon(Icons.content_paste),
        child: Text('Paste'),
        closeOnActivate: true,
      ),
      Divider(),
      MenuItemButton(
        onPressed: null,
        leadingIcon: Icon(Icons.delete, color: Colors.grey),
        child: Text('Delete', style: TextStyle(color: Colors.grey)),
      ),
    ],
    style: MenuStyle(
      backgroundColor: WidgetStateProperty.all(Colors.white),
      elevation: WidgetStateProperty.all(8.0),
      padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 4)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    alignmentOffset: Offset(0, 4),
  );
  print('MenuAnchor created');

  // ========== MenuItemButton ==========
  print('--- MenuItemButton Tests ---');
  final menuItem = MenuItemButton(
    onPressed: () => print('  Menu item pressed'),
    onHover: (hovering) => print('  Hovering: $hovering'),
    onFocusChange: (focused) => print('  Focused: $focused'),
    leadingIcon: Icon(Icons.edit),
    trailingIcon: Icon(Icons.arrow_right),
    requestFocusOnHover: true,
    closeOnActivate: true,
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Colors.black87),
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    ),
    child: Text('Edit'),
  );
  print('MenuItemButton created');

  // ========== SubmenuButton ==========
  print('--- SubmenuButton Tests ---');
  final submenu = SubmenuButton(
    menuChildren: [
      MenuItemButton(onPressed: () {}, child: Text('Sub Item 1')),
      MenuItemButton(onPressed: () {}, child: Text('Sub Item 2')),
      MenuItemButton(onPressed: () {}, child: Text('Sub Item 3')),
    ],
    leadingIcon: Icon(Icons.format_list_bulleted),
    trailingIcon: Icon(Icons.arrow_right),
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Colors.black87),
    ),
    alignmentOffset: Offset(0, 4),
    menuStyle: MenuStyle(elevation: WidgetStateProperty.all(4.0)),
    child: Text('More Options'),
  );
  print('SubmenuButton created');

  // ========== MenuStyle ==========
  print('--- MenuStyle Tests ---');
  final menuStyle = MenuStyle(
    backgroundColor: WidgetStateProperty.all(Colors.white),
    shadowColor: WidgetStateProperty.all(Colors.black26),
    surfaceTintColor: WidgetStateProperty.all(Colors.blue[50]),
    elevation: WidgetStateProperty.all(8.0),
    padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 4)),
    minimumSize: WidgetStateProperty.all(Size(200, 0)),
    maximumSize: WidgetStateProperty.all(Size(400, 500)),
    side: WidgetStateProperty.all(BorderSide(color: Colors.grey[300]!)),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    alignment: Alignment.bottomLeft,
    fixedSize: null,
  );
  print('MenuStyle created');

  // ========== DropdownMenuThemeData ==========
  print('--- DropdownMenuThemeData Tests ---');
  final dmTheme = DropdownMenuThemeData(
    textStyle: TextStyle(fontSize: 16),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
    menuStyle: menuStyle,
  );
  print('DropdownMenuThemeData created');

  print('All dropdown menu tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Menus'), actions: [menuAnchor]),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            dropdownMenu,
            SizedBox(height: 16),
            Row(children: [menuItem, submenu]),
          ],
        ),
      ),
    ),
  );
}
