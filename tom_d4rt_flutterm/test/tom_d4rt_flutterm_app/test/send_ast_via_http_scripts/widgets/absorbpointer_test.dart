// D4rt test script: Tests AbsorbPointer, IgnorePointer, MouseRegion, RepaintBoundary from widgets
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print(
    'AbsorbPointer/IgnorePointer/MouseRegion/RepaintBoundary test executing',
  );

  // ========== ABSORBPOINTER ==========
  print('--- AbsorbPointer Tests ---');

  // Test AbsorbPointer absorbing=true (default)
  final absorbTrue = AbsorbPointer(
    absorbing: true,
    child: ElevatedButton(
      onPressed: () {
        print('This should not be called');
      },
      child: Text('Absorbed (disabled)'),
    ),
  );
  print('AbsorbPointer absorbing=true created');

  // Test AbsorbPointer absorbing=false
  final absorbFalse = AbsorbPointer(
    absorbing: false,
    child: ElevatedButton(
      onPressed: () {
        print('Button pressed (not absorbed)');
      },
      child: Text('Not absorbed (enabled)'),
    ),
  );
  print('AbsorbPointer absorbing=false created');

  // Test AbsorbPointer wrapping multiple children
  final absorbGroup = AbsorbPointer(
    absorbing: true,
    child: Column(
      children: [
        ElevatedButton(
          onPressed: () {
            print('Button 1');
          },
          child: Text('Button 1'),
        ),
        ElevatedButton(
          onPressed: () {
            print('Button 2');
          },
          child: Text('Button 2'),
        ),
        TextField(decoration: InputDecoration(labelText: 'Absorbed TextField')),
      ],
    ),
  );
  print('AbsorbPointer wrapping group created');

  // ========== IGNOREPOINTER ==========
  print('--- IgnorePointer Tests ---');

  // Test IgnorePointer ignoring=true (default)
  final ignoreTrue = IgnorePointer(
    ignoring: true,
    child: ElevatedButton(
      onPressed: () {
        print('This should not be called');
      },
      child: Text('Ignored (pass-through)'),
    ),
  );
  print('IgnorePointer ignoring=true created');

  // Test IgnorePointer ignoring=false
  final ignoreFalse = IgnorePointer(
    ignoring: false,
    child: ElevatedButton(
      onPressed: () {
        print('Button pressed (not ignored)');
      },
      child: Text('Not ignored (enabled)'),
    ),
  );
  print('IgnorePointer ignoring=false created');

  // Test IgnorePointer wrapping a stack
  final ignoreStack = IgnorePointer(
    ignoring: true,
    child: Stack(
      children: [
        Container(
          width: 200.0,
          height: 80.0,
          color: Colors.blue,
          child: Center(
            child: Text('Background', style: TextStyle(color: Colors.white)),
          ),
        ),
        Positioned(
          top: 10.0,
          left: 10.0,
          child: ElevatedButton(
            onPressed: () {
              print('Stack button');
            },
            child: Text('Stack Btn'),
          ),
        ),
      ],
    ),
  );
  print('IgnorePointer wrapping stack created');

  // ========== MOUSEREGION ==========
  print('--- MouseRegion Tests ---');

  // Test MouseRegion basic with onEnter/onExit
  final mouseBasic = MouseRegion(
    onEnter: (event) {
      print('Mouse entered');
    },
    onExit: (event) {
      print('Mouse exited');
    },
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.green,
      child: Center(
        child: Text('Hover me', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('MouseRegion basic created');

  // Test MouseRegion with onHover
  final mouseHover = MouseRegion(
    onHover: (event) {
      print('Mouse hovering');
    },
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.orange,
      child: Center(
        child: Text('Track hover', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('MouseRegion with onHover created');

  // Test MouseRegion with cursor
  final mouseCursor = MouseRegion(
    cursor: SystemMouseCursors.click,
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.purple,
      child: Center(
        child: Text('Click cursor', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('MouseRegion with click cursor created');

  // Test MouseRegion with opaque=false
  final mouseOpaque = MouseRegion(
    opaque: false,
    onEnter: (event) {
      print('Non-opaque entered');
    },
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.teal,
      child: Center(
        child: Text('Non-opaque', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('MouseRegion opaque=false created');

  // ========== REPAINTBOUNDARY ==========
  print('--- RepaintBoundary Tests ---');

  // Test RepaintBoundary basic
  final repaintBasic = RepaintBoundary(
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.red,
      child: Center(
        child: Text('RepaintBoundary', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('RepaintBoundary basic created');

  // Test RepaintBoundary wrapping complex content
  final repaintComplex = RepaintBoundary(
    child: Column(
      children: [
        Container(
          color: Colors.blue,
          height: 30.0,
          width: 200.0,
          child: Text('Row 1', style: TextStyle(color: Colors.white)),
        ),
        Container(
          color: Colors.green,
          height: 30.0,
          width: 200.0,
          child: Text('Row 2', style: TextStyle(color: Colors.white)),
        ),
        Container(
          color: Colors.orange,
          height: 30.0,
          width: 200.0,
          child: Text('Row 3', style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
  print('RepaintBoundary wrapping complex content created');

  // Test RepaintBoundary with key
  final repaintKeyed = RepaintBoundary(
    key: ValueKey('repaint-boundary-1'),
    child: Container(
      width: 200.0,
      height: 40.0,
      color: Colors.indigo,
      child: Center(
        child: Text('Keyed boundary', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('RepaintBoundary with key created');

  print(
    'All AbsorbPointer/IgnorePointer/MouseRegion/RepaintBoundary tests completed',
  );

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '=== AbsorbPointer Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Absorbing=true:', style: TextStyle(fontWeight: FontWeight.bold)),
        absorbTrue,
        SizedBox(height: 8.0),
        Text('Absorbing=false:', style: TextStyle(fontWeight: FontWeight.bold)),
        absorbFalse,
        SizedBox(height: 8.0),
        Text('Absorbing group:', style: TextStyle(fontWeight: FontWeight.bold)),
        absorbGroup,
        SizedBox(height: 16.0),
        Text(
          '=== IgnorePointer Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Ignoring=true:', style: TextStyle(fontWeight: FontWeight.bold)),
        ignoreTrue,
        SizedBox(height: 8.0),
        Text('Ignoring=false:', style: TextStyle(fontWeight: FontWeight.bold)),
        ignoreFalse,
        SizedBox(height: 8.0),
        Text('Ignoring stack:', style: TextStyle(fontWeight: FontWeight.bold)),
        ignoreStack,
        SizedBox(height: 16.0),
        Text(
          '=== MouseRegion Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text(
          'Basic (enter/exit):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        mouseBasic,
        SizedBox(height: 8.0),
        Text('Hover tracking:', style: TextStyle(fontWeight: FontWeight.bold)),
        mouseHover,
        SizedBox(height: 8.0),
        Text('Click cursor:', style: TextStyle(fontWeight: FontWeight.bold)),
        mouseCursor,
        SizedBox(height: 8.0),
        Text('Non-opaque:', style: TextStyle(fontWeight: FontWeight.bold)),
        mouseOpaque,
        SizedBox(height: 16.0),
        Text(
          '=== RepaintBoundary Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Basic:', style: TextStyle(fontWeight: FontWeight.bold)),
        repaintBasic,
        SizedBox(height: 8.0),
        Text('Complex content:', style: TextStyle(fontWeight: FontWeight.bold)),
        repaintComplex,
        SizedBox(height: 8.0),
        Text('Keyed:', style: TextStyle(fontWeight: FontWeight.bold)),
        repaintKeyed,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text(
          '• AbsorbPointer absorbs hits, preventing children from receiving them',
        ),
        Text(
          '• IgnorePointer ignores hits, passing them through to widgets behind',
        ),
        Text('• MouseRegion tracks mouse enter/exit/hover events'),
        Text('• RepaintBoundary isolates repaint regions for performance'),
      ],
    ),
  );
}
