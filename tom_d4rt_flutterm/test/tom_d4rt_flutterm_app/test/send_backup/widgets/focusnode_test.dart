// D4rt test script: Tests FocusNode and FocusScope widgets from widgets
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FocusNode test executing');

  // Test basic FocusNode
  final basicNode = FocusNode();
  print('Basic FocusNode created');
  print('FocusNode hasFocus: ${basicNode.hasFocus}');
  print('FocusNode hasPrimaryFocus: ${basicNode.hasPrimaryFocus}');
  print('FocusNode canRequestFocus: ${basicNode.canRequestFocus}');
  print('FocusNode skipTraversal: ${basicNode.skipTraversal}');

  // Test FocusNode with debugLabel
  final labeledNode = FocusNode(debugLabel: 'MyFocusNode');
  print('FocusNode with debugLabel created: ${labeledNode.debugLabel}');

  // Test FocusNode with skipTraversal
  final skipNode = FocusNode(skipTraversal: true);
  print('FocusNode with skipTraversal=true created');

  // Test FocusNode with canRequestFocus
  final noRequestNode = FocusNode(canRequestFocus: false);
  print('FocusNode with canRequestFocus=false created');

  // Test FocusNode with descendantsAreFocusable
  final noDescendantsNode = FocusNode(descendantsAreFocusable: false);
  print('FocusNode with descendantsAreFocusable=false created');

  // Test FocusNode methods
  print('FocusNode.requestFocus() - requests focus');
  print('FocusNode.unfocus() - removes focus');
  print('FocusNode.nextFocus() - moves to next');
  print('FocusNode.previousFocus() - moves to previous');
  print('FocusNode.dispose() - cleans up');

  // Test FocusNode with listener
  final listenNode = FocusNode();
  listenNode.addListener(() {
    print('FocusNode focus changed: ${listenNode.hasFocus}');
  });
  print('FocusNode with listener created');

  // Test FocusScope widget
  final focusScopeWidget = FocusScope(
    child: Column(
      children: [
        TextField(decoration: InputDecoration(labelText: 'Field 1')),
        TextField(decoration: InputDecoration(labelText: 'Field 2')),
        TextField(decoration: InputDecoration(labelText: 'Field 3')),
      ],
    ),
  );
  print('FocusScope widget with 3 text fields created');

  // Test FocusScope with autofocus
  final autofocusScope = FocusScope(
    autofocus: true,
    child: TextField(decoration: InputDecoration(labelText: 'Autofocus Scope')),
  );
  print('FocusScope with autofocus=true created');

  // Test FocusScope with skipTraversal
  final skipScope = FocusScope(
    skipTraversal: true,
    child: TextField(decoration: InputDecoration(labelText: 'Skip Traversal')),
  );
  print('FocusScope with skipTraversal=true created');

  // Test FocusScope with canRequestFocus
  final noFocusScope = FocusScope(
    canRequestFocus: false,
    child: TextField(decoration: InputDecoration(labelText: 'No Focus')),
  );
  print('FocusScope with canRequestFocus=false created');

  // Test FocusScope.of(context) methods
  print('FocusScope.of(context) - gets nearest FocusScopeNode');
  print('FocusScopeNode.requestFocus() - requests focus for node');
  print('FocusScopeNode.unfocus() - removes focus from scope');
  print('FocusScopeNode.nextFocus() - next in scope');
  print('FocusScopeNode.previousFocus() - previous in scope');

  // Test Focus widget
  final focusWidget = Focus(
    onFocusChange: (hasFocus) {
      print('Focus changed: $hasFocus');
    },
    child: Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.blue.shade100,
      child: Text('Focusable Container'),
    ),
  );
  print('Focus widget with onFocusChange created');

  // Test Focus with autofocus
  final autofocusWidget = Focus(
    autofocus: true,
    child: Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.green.shade100,
      child: Text('Autofocus Container'),
    ),
  );
  print('Focus widget with autofocus=true created');

  // Test Focus with focusNode
  final customNodeWidget = Focus(
    focusNode: FocusNode(debugLabel: 'Custom'),
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: Text('Custom Node Container'),
    ),
  );
  print('Focus widget with custom focusNode created');

  // Test Focus with onKey
  final keyHandlerWidget = Focus(
    onKey: (node, event) {
      print('Key event: ${event.logicalKey}');
      return KeyEventResult.ignored;
    },
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: Text('Key Handler Container'),
    ),
  );
  print('Focus widget with onKey handler created');

  // Test FocusTraversalGroup
  final traversalGroup = FocusTraversalGroup(
    policy: OrderedTraversalPolicy(),
    child: Column(
      children: [
        FocusTraversalOrder(
          order: NumericFocusOrder(2.0),
          child: TextField(decoration: InputDecoration(labelText: 'Second')),
        ),
        FocusTraversalOrder(
          order: NumericFocusOrder(1.0),
          child: TextField(decoration: InputDecoration(labelText: 'First')),
        ),
        FocusTraversalOrder(
          order: NumericFocusOrder(3.0),
          child: TextField(decoration: InputDecoration(labelText: 'Third')),
        ),
      ],
    ),
  );
  print('FocusTraversalGroup with OrderedTraversalPolicy created');

  // Test ReadingOrderTraversalPolicy
  final readingOrder = FocusTraversalGroup(
    policy: ReadingOrderTraversalPolicy(),
    child: Row(
      children: [
        Expanded(
          child: TextField(decoration: InputDecoration(labelText: 'Left')),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: TextField(decoration: InputDecoration(labelText: 'Right')),
        ),
      ],
    ),
  );
  print('FocusTraversalGroup with ReadingOrderTraversalPolicy created');

  // Test WidgetOrderTraversalPolicy
  final widgetOrder = FocusTraversalGroup(
    policy: WidgetOrderTraversalPolicy(),
    child: Column(
      children: [
        TextField(decoration: InputDecoration(labelText: 'Order 1')),
        TextField(decoration: InputDecoration(labelText: 'Order 2')),
      ],
    ),
  );
  print('FocusTraversalGroup with WidgetOrderTraversalPolicy created');

  // Test ExcludeFocus
  final excludeFocus = ExcludeFocus(
    child: TextField(decoration: InputDecoration(labelText: 'Excluded')),
  );
  print('ExcludeFocus widget created');

  // Test FocusNode tree structure
  print('FocusNode.parent - parent node');
  print('FocusNode.children - child nodes');
  print('FocusNode.ancestors - ancestor nodes');
  print('FocusNode.descendants - descendant nodes');

  print('FocusNode test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'FocusNode Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text(
          'FocusScope Widget:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        focusScopeWidget,
        SizedBox(height: 16.0),
        Text('Focus Widget:', style: TextStyle(fontWeight: FontWeight.bold)),
        focusWidget,
        SizedBox(height: 16.0),
        autofocusWidget,
        SizedBox(height: 16.0),
        Text('Traversal Group:', style: TextStyle(fontWeight: FontWeight.bold)),
        traversalGroup,
        SizedBox(height: 16.0),
        Text('Reading Order:', style: TextStyle(fontWeight: FontWeight.bold)),
        readingOrder,
        SizedBox(height: 16.0),
        Text('Widget Order:', style: TextStyle(fontWeight: FontWeight.bold)),
        widgetOrder,
      ],
    ),
  );
}
