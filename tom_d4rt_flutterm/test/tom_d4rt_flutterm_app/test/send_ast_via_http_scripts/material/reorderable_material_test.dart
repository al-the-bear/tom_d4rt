// D4rt test script: Tests ReorderableListView, ReorderableDragStartListener,
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// SliverReorderableList, InkWell advanced, InkResponse, InkHighlight, Material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Reorderable and material ink test executing');

  // ========== ReorderableListView ==========
  print('--- ReorderableListView Tests ---');
  final items = List.generate(10, (index) => 'Item $index');

  final reorderableList = ReorderableListView(
    onReorder: (oldIndex, newIndex) {
      print('  Reorder: $oldIndex -> $newIndex');
    },
    proxyDecorator: (child, index, animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (context, child) => Material(elevation: 4, child: child),
        child: child,
      );
    },
    header: Container(
      padding: EdgeInsets.all(16),
      child: Text('Reorderable Header'),
    ),
    footer: Container(
      padding: EdgeInsets.all(16),
      child: Text('Reorderable Footer'),
    ),
    padding: EdgeInsets.all(8),
    scrollDirection: Axis.vertical,
    reverse: false,
    children: items
        .map(
          (item) => ListTile(
            key: ValueKey(item),
            title: Text(item),
            leading: Icon(Icons.drag_handle),
          ),
        )
        .toList(),
  );
  print('ReorderableListView created');

  // ========== ReorderableListView.builder ==========
  print('--- ReorderableListView.builder Tests ---');
  final reorderableBuilder = ReorderableListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) =>
        ListTile(key: ValueKey(items[index]), title: Text(items[index])),
    onReorder: (oldIndex, newIndex) {
      print('  Builder reorder: $oldIndex -> $newIndex');
    },
    buildDefaultDragHandles: true,
  );
  print('ReorderableListView.builder created');

  // ========== ReorderableDragStartListener ==========
  print('--- ReorderableDragStartListener Tests ---');
  final dragListener = ReorderableDragStartListener(
    index: 0,
    child: Icon(Icons.drag_indicator),
    enabled: true,
  );
  print('ReorderableDragStartListener created: index=0');

  final delayedListener = ReorderableDelayedDragStartListener(
    index: 1,
    child: Icon(Icons.drag_indicator),
    enabled: true,
  );
  print('ReorderableDelayedDragStartListener created: index=1');

  // ========== InkWell advanced ==========
  print('--- InkWell Advanced Tests ---');
  final inkWell = InkWell(
    onTap: () => print('  Tapped'),
    onDoubleTap: () => print('  Double tapped'),
    onLongPress: () => print('  Long pressed'),
    onTapDown: (details) => print('  Tap down'),
    onTapUp: (details) => print('  Tap up'),
    onTapCancel: () => print('  Tap cancel'),
    onHighlightChanged: (highlight) => print('  Highlight: $highlight'),
    onHover: (hover) => print('  Hover: $hover'),
    onFocusChange: (focus) => print('  Focus: $focus'),
    splashColor: Colors.blue[200],
    highlightColor: Colors.blue[100],
    hoverColor: Colors.blue[50],
    focusColor: Colors.blue[300],
    overlayColor: WidgetStateProperty.all(Colors.blue[100]),
    borderRadius: BorderRadius.circular(8),
    customBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    enableFeedback: true,
    excludeFromSemantics: false,
    canRequestFocus: true,
    autofocus: false,
    child: Container(padding: EdgeInsets.all(16), child: Text('Ink Well')),
  );
  print('InkWell advanced created');

  // ========== InkResponse ==========
  print('--- InkResponse Tests ---');
  final inkResponse = InkResponse(
    onTap: () => print('  Response tapped'),
    onLongPress: () => print('  Response long pressed'),
    splashColor: Colors.red[200],
    highlightColor: Colors.red[100],
    hoverColor: Colors.red[50],
    highlightShape: BoxShape.circle,
    radius: 24.0,
    containedInkWell: false,
    child: Container(width: 48, height: 48, child: Icon(Icons.circle)),
  );
  print('InkResponse created');

  // ========== Material widget ==========
  print('--- Material Widget Tests ---');
  final materialWidget = Material(
    type: MaterialType.card,
    elevation: 4.0,
    color: Colors.white,
    shadowColor: Colors.black54,
    surfaceTintColor: Colors.blue[50],
    borderRadius: BorderRadius.circular(12),
    borderOnForeground: true,
    clipBehavior: Clip.antiAlias,
    animationDuration: Duration(milliseconds: 300),
    child: Container(
      padding: EdgeInsets.all(16),
      child: Text('Material Widget'),
    ),
  );
  print('Material widget created: type=${MaterialType.card}');

  // ========== MaterialType enum ==========
  print('--- MaterialType Tests ---');
  for (final t in MaterialType.values) {
    print('  MaterialType.$t');
  }

  print('All reorderable/material ink tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 300, child: reorderableList),
            SizedBox(height: 16),
            dragListener,
            inkWell,
            inkResponse,
            materialWidget,
          ],
        ),
      ),
    ),
  );
}
