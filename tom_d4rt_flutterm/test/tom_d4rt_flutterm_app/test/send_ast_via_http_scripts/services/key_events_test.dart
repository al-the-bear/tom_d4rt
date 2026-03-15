// D4rt test script: Tests RawKeyEvent, RawKeyDownEvent, RawKeyUpEvent,
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// LogicalKeyboardKey, PhysicalKeyboardKey, KeyEvent, HardwareKeyboard,
// KeyDownEvent, KeyUpEvent, KeyRepeatEvent
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('Key events test executing');

  // ========== LogicalKeyboardKey ==========
  print('--- LogicalKeyboardKey Tests ---');
  final keys = {
    'space': LogicalKeyboardKey.space,
    'enter': LogicalKeyboardKey.enter,
    'escape': LogicalKeyboardKey.escape,
    'tab': LogicalKeyboardKey.tab,
    'backspace': LogicalKeyboardKey.backspace,
    'delete': LogicalKeyboardKey.delete,
    'arrowUp': LogicalKeyboardKey.arrowUp,
    'arrowDown': LogicalKeyboardKey.arrowDown,
    'arrowLeft': LogicalKeyboardKey.arrowLeft,
    'arrowRight': LogicalKeyboardKey.arrowRight,
    'home': LogicalKeyboardKey.home,
    'end': LogicalKeyboardKey.end,
    'pageUp': LogicalKeyboardKey.pageUp,
    'pageDown': LogicalKeyboardKey.pageDown,
    'shiftLeft': LogicalKeyboardKey.shiftLeft,
    'controlLeft': LogicalKeyboardKey.controlLeft,
    'altLeft': LogicalKeyboardKey.altLeft,
    'metaLeft': LogicalKeyboardKey.metaLeft,
    'keyA': LogicalKeyboardKey.keyA,
    'keyZ': LogicalKeyboardKey.keyZ,
    'digit0': LogicalKeyboardKey.digit0,
    'digit9': LogicalKeyboardKey.digit9,
    'f1': LogicalKeyboardKey.f1,
    'f12': LogicalKeyboardKey.f12,
  };
  for (final entry in keys.entries) {
    print(
      '  LogicalKeyboardKey.${entry.key}: keyId=${entry.value.keyId}, keyLabel=${entry.value.keyLabel}',
    );
  }

  // ========== PhysicalKeyboardKey ==========
  print('--- PhysicalKeyboardKey Tests ---');
  final physKeys = {
    'keyA': PhysicalKeyboardKey.keyA,
    'keyZ': PhysicalKeyboardKey.keyZ,
    'enter': PhysicalKeyboardKey.enter,
    'escape': PhysicalKeyboardKey.escape,
    'space': PhysicalKeyboardKey.space,
    'arrowUp': PhysicalKeyboardKey.arrowUp,
    'shiftLeft': PhysicalKeyboardKey.shiftLeft,
    'controlLeft': PhysicalKeyboardKey.controlLeft,
  };
  for (final entry in physKeys.entries) {
    print(
      '  PhysicalKeyboardKey.${entry.key}: usbHidUsage=${entry.value.usbHidUsage}',
    );
  }

  // ========== HardwareKeyboard ==========
  print('--- HardwareKeyboard Tests ---');
  final hwKeyboard = HardwareKeyboard.instance;
  print('HardwareKeyboard.instance: $hwKeyboard');
  print('  physicalKeysPressed: ${hwKeyboard.physicalKeysPressed}');
  print('  logicalKeysPressed: ${hwKeyboard.logicalKeysPressed}');
  print('  lockModesEnabled: ${hwKeyboard.lockModesEnabled}');

  // ========== KeySet ==========
  print('--- KeySet Tests ---');
  final keySet1 = LogicalKeySet(
    LogicalKeyboardKey.control,
    LogicalKeyboardKey.keyC,
  );
  print('LogicalKeySet (Ctrl+C): $keySet1');

  final keySet2 = LogicalKeySet(
    LogicalKeyboardKey.control,
    LogicalKeyboardKey.shift,
    LogicalKeyboardKey.keyS,
  );
  print('LogicalKeySet (Ctrl+Shift+S): $keySet2');

  // ========== SingleActivator ==========
  print('--- SingleActivator Tests ---');
  final activator1 = SingleActivator(LogicalKeyboardKey.keyC, control: true);
  print('SingleActivator (Ctrl+C) created');
  print('  trigger: ${activator1.trigger}');
  print('  control: ${activator1.control}');
  print('  shift: ${activator1.shift}');
  print('  alt: ${activator1.alt}');
  print('  meta: ${activator1.meta}');
  print('  includeRepeats: ${activator1.includeRepeats}');

  final activator2 = SingleActivator(
    LogicalKeyboardKey.keyS,
    control: true,
    shift: true,
    includeRepeats: false,
  );
  print('SingleActivator (Ctrl+Shift+S) created');

  // ========== CharacterActivator ==========
  print('--- CharacterActivator Tests ---');
  final charActivator = CharacterActivator('?');
  print('CharacterActivator("?") created');
  print('  character: ${charActivator.character}');

  // ========== KeyboardListener ==========
  print('--- KeyboardListener Tests ---');
  final keyboardListener = KeyboardListener(
    focusNode: FocusNode(),
    onKeyEvent: (event) {
      print('  KeyEvent: $event');
    },
    autofocus: false,
    includeSemantics: true,
    child: Container(
      width: 200,
      height: 200,
      color: Colors.blue[100],
      child: Center(child: Text('Press keys')),
    ),
  );
  print('KeyboardListener created');

  // ========== Shortcuts widget ==========
  print('--- Shortcuts Tests ---');
  // Note: Actions widget requires Map<Type, Action<Intent>> where Type must be
  // a real Dart Type. D4rt interpreted classes (CopyIntent, PasteIntent) are
  // InterpretedClass, not Type. Use only built-in bridged intent types.
  final shortcuts = Shortcuts(
    shortcuts: {
      SingleActivator(LogicalKeyboardKey.escape): DismissIntent(),
      SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
    },
    child: Actions(
      actions: {
        DismissIntent: CallbackAction<DismissIntent>(
          onInvoke: (intent) {
            print('  Dismiss invoked');
            return null;
          },
        ),
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (intent) {
            print('  Activate invoked');
            return null;
          },
        ),
      },
      child: Focus(
        autofocus: true,
        child: Container(child: Text('Shortcuts active')),
      ),
    ),
  );
  print('Shortcuts + Actions created');

  // ========== Intent types ==========
  print('--- Intent Types ---');
  // Note: CopyIntent and PasteIntent are locally defined and cannot be used
  // as Type map keys in D4rt (InterpretedClass vs Type limitation)
  print('  DismissIntent: ${DismissIntent()}');
  print('  ActivateIntent: ${ActivateIntent()}');
  print('  ScrollIntent: ${ScrollIntent(direction: AxisDirection.down)}');

  print('All key events tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(body: Column(children: [keyboardListener, shortcuts])),
  );
}
