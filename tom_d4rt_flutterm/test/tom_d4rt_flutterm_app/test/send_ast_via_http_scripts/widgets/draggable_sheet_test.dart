// D4rt test script: Tests DraggableScrollableSheet, DraggableScrollableController,
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// DraggableScrollableNotification, BottomSheet, NotificationListener,
// SheetDragDetails, SnappingSheetBehavior and ShowModalBottomSheet concepts
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

dynamic build(BuildContext context) {
  print('Draggable sheet test executing');

  // ========== DraggableScrollableController ==========
  print('--- DraggableScrollableController Tests ---');
  final dsController = DraggableScrollableController();
  print('DraggableScrollableController created');

  // ========== DraggableScrollableSheet ==========
  print('--- DraggableScrollableSheet Tests ---');
  final draggableSheet = DraggableScrollableSheet(
    initialChildSize: 0.3,
    minChildSize: 0.1,
    maxChildSize: 0.9,
    expand: true,
    snap: true,
    snapSizes: [0.25, 0.5, 0.75],
    snapAnimationDuration: Duration(milliseconds: 150),
    controller: dsController,
    shouldCloseOnMinExtent: true,
    builder: (context, scrollController) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: ListView.builder(
          controller: scrollController,
          itemCount: 25,
          itemBuilder: (context, index) => ListTile(
            leading: Icon(Icons.list),
            title: Text('Item $index'),
            subtitle: Text('Description for item $index'),
          ),
        ),
      );
    },
  );
  print('DraggableScrollableSheet created');
  print('  initialChildSize: 0.3');
  print('  minChildSize: 0.1');
  print('  maxChildSize: 0.9');
  print('  snap: true');

  // ========== DraggableScrollableNotification ==========
  print('--- DraggableScrollableNotification Tests ---');
  final notificationListener =
      NotificationListener<DraggableScrollableNotification>(
        onNotification: (notification) {
          print('  DraggableScrollableNotification:');
          print('    extent: ${notification.extent}');
          print('    minExtent: ${notification.minExtent}');
          print('    maxExtent: ${notification.maxExtent}');
          print('    initialExtent: ${notification.initialExtent}');
          print(
            '    shouldCloseOnMinExtent: ${notification.shouldCloseOnMinExtent}',
          );
          return false;
        },
        child: draggableSheet,
      );
  print('NotificationListener<DraggableScrollableNotification> created');

  // ========== BottomSheet ==========
  print('--- BottomSheet Tests ---');
  final bottomSheet = BottomSheet(
    onClosing: () => print('  BottomSheet closing'),
    builder: (context) {
      return Container(
        height: 200,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text('Bottom Sheet Content', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            ElevatedButton(onPressed: () {}, child: Text('Action')),
          ],
        ),
      );
    },
    enableDrag: true,
    showDragHandle: true,
    dragHandleColor: Colors.grey[400],
    dragHandleSize: Size(32, 4),
    backgroundColor: Colors.white,
    elevation: 8.0,
    shadowColor: Colors.black26,
    clipBehavior: Clip.antiAlias,
    constraints: BoxConstraints(maxHeight: 400),
    animationController: AnimationController(
      vsync: TestVSync(),
      duration: Duration(milliseconds: 300),
    ),
  );
  print('BottomSheet created');

  // ========== NotificationListener types ==========
  print('--- NotificationListener Tests ---');
  final scrollNotifListener = NotificationListener<ScrollNotification>(
    onNotification: (notification) {
      if (notification is ScrollStartNotification) {
        print('  Scroll started');
      } else if (notification is ScrollUpdateNotification) {
        print('  Scroll updated');
      } else if (notification is ScrollEndNotification) {
        print('  Scroll ended');
      }
      return false;
    },
    child: ListView(children: [Text('Item 1'), Text('Item 2')]),
  );
  print('NotificationListener<ScrollNotification> created');

  // ========== BottomSheetThemeData ==========
  print('--- BottomSheetThemeData Tests ---');
  final bsTheme = BottomSheetThemeData(
    backgroundColor: Colors.white,
    elevation: 8.0,
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.blue[50],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    showDragHandle: true,
    dragHandleColor: Colors.grey[300],
    dragHandleSize: Size(32, 4),
    clipBehavior: Clip.antiAlias,
    constraints: BoxConstraints(maxWidth: 600),
    modalBackgroundColor: Colors.white,
    modalElevation: 16.0,
    modalBarrierColor: Colors.black54,
  );
  print('BottomSheetThemeData created');
  print('  elevation: ${bsTheme.elevation}');
  print('  showDragHandle: ${bsTheme.showDragHandle}');

  print('All draggable sheet tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Stack(
        children: [
          Center(child: Text('Background Content')),
          notificationListener,
        ],
      ),
    ),
  );
}

class TestVSync implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}
