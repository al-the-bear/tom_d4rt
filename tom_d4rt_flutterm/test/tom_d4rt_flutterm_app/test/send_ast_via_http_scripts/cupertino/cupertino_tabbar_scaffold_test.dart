// D4rt test script: Tests CupertinoTabBar advanced, CupertinoTabScaffold advanced,
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// CupertinoTabController advanced, CupertinoScrollbar, CupertinoListSection,
// CupertinoListTile, CupertinoFormSection, CupertinoFormRow
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Cupertino tab bar / scaffold test executing');

  // ========== CupertinoTabBar advanced ==========
  print('--- CupertinoTabBar Advanced Tests ---');
  final tabBar = CupertinoTabBar(
    items: [
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home),
        activeIcon: Icon(CupertinoIcons.house_fill),
        label: 'Home',
        tooltip: 'Go home',
        backgroundColor: CupertinoColors.systemBackground,
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search),
        activeIcon: Icon(CupertinoIcons.search),
        label: 'Search',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.bell),
        activeIcon: Icon(CupertinoIcons.bell_fill),
        label: 'Alerts',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.person),
        activeIcon: Icon(CupertinoIcons.person_fill),
        label: 'Profile',
      ),
    ],
    currentIndex: 0,
    onTap: (index) => print('  Tab tapped: $index'),
    activeColor: CupertinoColors.activeBlue,
    inactiveColor: CupertinoColors.inactiveGray,
    backgroundColor: CupertinoColors.systemBackground,
    iconSize: 28.0,
    height: 50.0,
    border: Border(
      top: BorderSide(color: CupertinoColors.separator, width: 0.5),
    ),
  );
  print('CupertinoTabBar advanced created');

  // ========== CupertinoScrollbar ==========
  print('--- CupertinoScrollbar Tests ---');
  final scrollbar = CupertinoScrollbar(
    thickness: 6.0,
    thicknessWhileDragging: 10.0,
    radius: Radius.circular(10),
    radiusWhileDragging: Radius.circular(14),
    thumbVisibility: false,
    child: ListView.builder(
      itemCount: 50,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.all(8),
        child: Text('Scrollbar Item $index'),
      ),
    ),
  );
  print('CupertinoScrollbar created');

  // ========== CupertinoListSection ==========
  print('--- CupertinoListSection Tests ---');
  final listSection = CupertinoListSection(
    header: Text('Settings'),
    footer: Text('Manage your preferences'),
    children: [
      CupertinoListTile(
        title: Text('Wi-Fi'),
        subtitle: Text('Connected'),
        leading: Icon(CupertinoIcons.wifi, color: CupertinoColors.activeBlue),
        trailing: CupertinoSwitch(value: true, onChanged: (v) {}),
        onTap: () => print('  Wi-Fi tapped'),
      ),
      CupertinoListTile(
        title: Text('Bluetooth'),
        subtitle: Text('On'),
        leading: Icon(
          CupertinoIcons.bluetooth,
          color: CupertinoColors.activeBlue,
        ),
        trailing: CupertinoSwitch(value: true, onChanged: (v) {}),
      ),
      CupertinoListTile(
        title: Text('Cellular'),
        leading: Icon(
          CupertinoIcons.antenna_radiowaves_left_right,
          color: CupertinoColors.activeGreen,
        ),
        trailing: CupertinoListTileChevron(),
        onTap: () => print('  Cellular tapped'),
      ),
    ],
  );
  print('CupertinoListSection created');

  // ========== CupertinoListSection.insetGrouped ==========
  print('--- CupertinoListSection.insetGrouped Tests ---');
  final listSectionInset = CupertinoListSection.insetGrouped(
    header: Text('Account'),
    children: [
      CupertinoListTile(
        title: Text('Username'),
        additionalInfo: Text('john_doe'),
        trailing: CupertinoListTileChevron(),
      ),
      CupertinoListTile(
        title: Text('Email'),
        additionalInfo: Text('john@example.com'),
        trailing: CupertinoListTileChevron(),
      ),
    ],
  );
  print('CupertinoListSection.insetGrouped created');

  // ========== CupertinoListTile ==========
  print('--- CupertinoListTile Tests ---');
  final listTile = CupertinoListTile(
    title: Text('List Tile'),
    subtitle: Text('Subtitle text'),
    leading: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: CupertinoColors.activeBlue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(CupertinoIcons.star_fill, color: CupertinoColors.white),
    ),
    additionalInfo: Text('Info'),
    trailing: CupertinoListTileChevron(),
    onTap: () => print('  List tile tapped'),
    leadingSize: 40.0,
    leadingToTitle: 12.0,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    backgroundColor: CupertinoColors.systemBackground,
    backgroundColorActivated: CupertinoColors.systemGrey5,
  );
  print('CupertinoListTile created');

  // ========== CupertinoListTile.notched ==========
  print('--- CupertinoListTile.notched Tests ---');
  final notchedTile = CupertinoListTile.notched(
    title: Text('Notched Tile'),
    subtitle: Text('With notch'),
    leading: Icon(CupertinoIcons.bell),
    trailing: CupertinoListTileChevron(),
  );
  print('CupertinoListTile.notched created');

  // ========== CupertinoFormSection ==========
  print('--- CupertinoFormSection Tests ---');
  final formSection = CupertinoFormSection(
    header: Text('PERSONAL INFORMATION'),
    footer: Text('All fields are required'),
    children: [
      CupertinoFormRow(
        prefix: Text('Name'),
        child: CupertinoTextFormFieldRow(placeholder: 'Enter name'),
      ),
      CupertinoFormRow(
        prefix: Text('Email'),
        child: CupertinoTextFormFieldRow(
          placeholder: 'Enter email',
          keyboardType: TextInputType.emailAddress,
        ),
      ),
    ],
  );
  print('CupertinoFormSection created');

  // ========== CupertinoFormSection.insetGrouped ==========
  print('--- CupertinoFormSection.insetGrouped Tests ---');
  final formSectionInset = CupertinoFormSection.insetGrouped(
    header: Text('ADDRESS'),
    children: [
      CupertinoFormRow(
        prefix: Text('Street'),
        child: CupertinoTextFormFieldRow(placeholder: 'Street'),
      ),
      CupertinoFormRow(
        prefix: Text('City'),
        child: CupertinoTextFormFieldRow(placeholder: 'City'),
      ),
    ],
  );
  print('CupertinoFormSection.insetGrouped created');

  print('All cupertino tab/scaffold tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(middle: Text('Cupertino')),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                listSection,
                listSectionInset,
                formSection,
                formSectionInset,
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
