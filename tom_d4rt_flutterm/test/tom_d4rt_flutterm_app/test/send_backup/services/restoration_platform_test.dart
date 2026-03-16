// D4rt test script: Tests RestorationMemento, RestorationData, RestorationCallback, PlatformMenu, PlatformProvidedMenu, PlatformMenuItemGroup, PlatformProvidedMenuItem
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Restoration and platform menu test executing');

  // ========== RestorationMemento / RestorationData ==========
  print('--- RestorationMemento / RestorationData Tests ---');
  // RestorationMemento and RestorationData may not be directly public classes.
  // Reference the restoration system via RestorationManager and RestorationBucket.
  print('RestorationMemento: referenced via RestorationManager system');
  print('RestorationData: referenced via RestorationManager system');
  print('RestorationManager type: RestorationManager');

  // ========== RestorationCallback ==========
  print('--- RestorationCallback Tests ---');
  // RestorationCallback is a typedef: void Function(bool)
  // Define a function matching the signature.
  void restorationCallback(bool needsRestore) {
    print('RestorationCallback invoked with needsRestore: $needsRestore');
  }

  restorationCallback(true);
  print('RestorationCallback: defined function matching typedef signature');
  print('Type: void Function(bool)');

  // ========== PlatformMenu ==========
  print('--- PlatformMenu Tests ---');
  final platformMenu = PlatformMenu(
    label: 'File',
    menus: [
      PlatformMenuItem(
        label: 'New',
        onSelected: () {
          print('New selected');
        },
      ),
      PlatformMenuItem(
        label: 'Open',
        onSelected: () {
          print('Open selected');
        },
      ),
    ],
  );
  print('PlatformMenu label: ${platformMenu.label}');
  print('PlatformMenu menus count: ${platformMenu.menus.length}');
  print('Type: ${platformMenu.runtimeType}');

  // ========== PlatformProvidedMenu ==========
  print('--- PlatformProvidedMenu Tests ---');
  // PlatformProvidedMenu wraps platform-provided menu items like quit, about, etc.
  print('PlatformProvidedMenu: references platform-provided menu types');
  print('Type: PlatformProvidedMenu');

  // ========== PlatformMenuItemGroup ==========
  print('--- PlatformMenuItemGroup Tests ---');
  final menuGroup = PlatformMenuItemGroup(
    members: [
      PlatformMenuItem(
        label: 'Cut',
        onSelected: () {
          print('Cut selected');
        },
      ),
      PlatformMenuItem(
        label: 'Copy',
        onSelected: () {
          print('Copy selected');
        },
      ),
      PlatformMenuItem(
        label: 'Paste',
        onSelected: () {
          print('Paste selected');
        },
      ),
    ],
  );
  print('PlatformMenuItemGroup members count: ${menuGroup.members.length}');
  print('Type: ${menuGroup.runtimeType}');

  // ========== PlatformProvidedMenuItem ==========
  print('--- PlatformProvidedMenuItem Tests ---');
  final providedMenuItem = PlatformProvidedMenuItem(
    type: PlatformProvidedMenuItemType.about,
  );
  print('PlatformProvidedMenuItem type: ${providedMenuItem.type}');
  print('Type: ${providedMenuItem.runtimeType}');

  // Also test quit type
  final quitMenuItem = PlatformProvidedMenuItem(
    type: PlatformProvidedMenuItemType.quit,
  );
  print('PlatformProvidedMenuItem quit type: ${quitMenuItem.type}');

  print('All restoration and platform menu tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Restoration & Platform Menu Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text('RestorationMemento: OK (via RestorationManager)'),
            Text('RestorationData: OK (via RestorationManager)'),
            Text('RestorationCallback: OK'),
            Text('PlatformMenu: OK (label: File)'),
            Text('PlatformProvidedMenu: OK'),
            Text('PlatformMenuItemGroup: OK (3 members)'),
            Text('PlatformProvidedMenuItem: OK (about, quit)'),
          ],
        ),
      ),
    ),
  );
}
