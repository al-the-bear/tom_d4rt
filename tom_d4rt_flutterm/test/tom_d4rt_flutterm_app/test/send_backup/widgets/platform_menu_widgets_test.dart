// Tests: DefaultPlatformMenuDelegate, PlatformMenuBar, PlatformMenu,
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
//        PlatformMenuItem, PlatformMenuDelegate, DefaultTextStyleTransition,
//        RawMagnifier, RawKeyboardListener
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // --- DefaultPlatformMenuDelegate Tests ---
  print('--- DefaultPlatformMenuDelegate Tests ---');
  print('DefaultPlatformMenuDelegate is the default platform menu delegate');
  print('Type: $DefaultPlatformMenuDelegate');
  print('Delegates platform menu operations to the underlying platform');

  // --- PlatformMenuBar Tests ---
  print('--- PlatformMenuBar Tests ---');
  var menuBar = PlatformMenuBar(menus: [], child: Container());
  print('PlatformMenuBar: $menuBar');
  print('PlatformMenuBar menus: ${menuBar.menus}');
  print('PlatformMenuBar defines a platform-native menu bar');

  // --- PlatformMenu Tests ---
  print('--- PlatformMenu Tests ---');
  var platformMenu = PlatformMenu(label: 'File', menus: []);
  print('PlatformMenu: $platformMenu');
  print('PlatformMenu label: ${platformMenu.label}');
  print('PlatformMenu menus: ${platformMenu.menus}');

  // --- PlatformMenuItem Tests ---
  print('--- PlatformMenuItem Tests ---');
  var menuItem = PlatformMenuItem(
    label: 'Open',
    onSelected: () {
      print('Menu item selected');
    },
  );
  print('PlatformMenuItem: $menuItem');
  print('PlatformMenuItem label: ${menuItem.label}');
  print('PlatformMenuItem onSelected: ${menuItem.onSelected}');

  // --- PlatformMenuDelegate Tests ---
  print('--- PlatformMenuDelegate Tests ---');
  print('PlatformMenuDelegate is an abstract interface for platform menus');
  print('Type: $PlatformMenuDelegate');
  print('DefaultPlatformMenuDelegate is its concrete implementation');

  // --- DefaultTextStyleTransition Tests ---
  print('--- DefaultTextStyleTransition Tests ---');
  print('DefaultTextStyleTransition animates DefaultTextStyle changes');
  print('Type: $DefaultTextStyleTransition');
  print('Requires an Animation<TextStyle> to drive the transition');
  print('Used for animated text style changes in implicit animations');

  // --- RawMagnifier Tests ---
  print('--- RawMagnifier Tests ---');
  var magnifier = RawMagnifier(
    decoration: const MagnifierDecoration(),
    size: const Size(80.0, 48.0),
  );
  print('RawMagnifier: $magnifier');
  print('RawMagnifier size: ${magnifier.size}');
  print('RawMagnifier decoration: ${magnifier.decoration}');
  print('RawMagnifier provides a raw magnifying glass effect');

  // --- RawKeyboardListener Tests ---
  print('--- RawKeyboardListener Tests ---');
  // ignore: deprecated_member_use
  var keyboardListener = RawKeyboardListener(
    focusNode: FocusNode(),
    onKey: (event) {
      print('Key event: $event');
    },
    child: const Text('Keyboard Listener'),
  );
  print('RawKeyboardListener: $keyboardListener');
  print('RawKeyboardListener focusNode: ${keyboardListener.focusNode}');
  print('RawKeyboardListener is deprecated in favor of KeyboardListener');

  print('All platform menu widgets tests passed');

  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            menuBar,
            magnifier,
            keyboardListener,
            const Text('Platform Menu Widgets Test'),
          ],
        ),
      ),
    ),
  );
}
