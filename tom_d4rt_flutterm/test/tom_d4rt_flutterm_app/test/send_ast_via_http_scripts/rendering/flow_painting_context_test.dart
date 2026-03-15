// D4rt test script: Tests FlowPaintingContext from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FlowPaintingContext test executing');

  // ========== FlowPaintingContext is abstract - test via Flow widget ==========
  print('--- FlowPaintingContext (abstract) ---');
  print('  FlowPaintingContext is an abstract class used by FlowDelegate');
  print('  Testing via FlowDelegate implementation');

  // ========== Custom FlowDelegate to access FlowPaintingContext ==========
  print('--- Custom FlowDelegate ---');
  int paintCallCount = 0;
  Size? lastSize;
  int? lastChildCount;

  final delegate = _TestFlowDelegate(
    onPaint: (FlowPaintingContext flowContext, Size size, int childCount) {
      paintCallCount++;
      lastSize = size;
      lastChildCount = childCount;
    },
  );
  print('  delegate created: ${delegate.runtimeType}');
  print('  shouldRepaint: ${delegate.shouldRepaint(delegate)}');

  // ========== FlowDelegate methods ==========
  print('--- FlowDelegate methods ---');
  print(
    '  getSize returns: ${delegate.getSize(BoxConstraints.loose(Size(200.0, 200.0)))}',
  );
  print(
    '  getConstraintsForChild: ${delegate.getConstraintsForChild(0, BoxConstraints.loose(Size(100.0, 100.0)))}',
  );

  // ========== Create Flow widget to trigger FlowPaintingContext ==========
  print('--- Flow widget with delegate ---');
  final flowWidget = Flow(
    delegate: _SimpleFlowDelegate(),
    children: [
      Container(width: 40.0, height: 40.0, color: Color(0xFF2196F3)),
      Container(width: 40.0, height: 40.0, color: Color(0xFF4CAF50)),
      Container(width: 40.0, height: 40.0, color: Color(0xFFFF5722)),
    ],
  );
  print('  Flow widget created');
  print('  children count: 3');

  // ========== FlowDelegate with different layouts ==========
  print('--- Different FlowDelegate layouts ---');
  final horizontalDelegate = _HorizontalFlowDelegate();
  print('  horizontal delegate: ${horizontalDelegate.runtimeType}');

  final verticalDelegate = _VerticalFlowDelegate();
  print('  vertical delegate: ${verticalDelegate.runtimeType}');

  // ========== FlowDelegate shouldRepaint ==========
  print('--- shouldRepaint tests ---');
  final delegateA = _SimpleFlowDelegate();
  final delegateB = _SimpleFlowDelegate();
  print(
    '  delegateA.shouldRepaint(delegateA): ${delegateA.shouldRepaint(delegateA)}',
  );
  print(
    '  delegateA.shouldRepaint(delegateB): ${delegateA.shouldRepaint(delegateB)}',
  );

  // ========== FlowDelegate getSize ==========
  print('--- getSize tests ---');
  final constraints = BoxConstraints(maxWidth: 300.0, maxHeight: 200.0);
  print(
    '  getSize with constrained: ${_SimpleFlowDelegate().getSize(constraints)}',
  );
  print(
    '  getSize with loose: ${_SimpleFlowDelegate().getSize(BoxConstraints.loose(Size(400.0, 300.0)))}',
  );

  print('FlowPaintingContext test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'FlowPaintingContext Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('FlowPaintingContext is abstract'),
          Text('Tested via FlowDelegate'),
          SizedBox(height: 8.0),
          Container(
            height: 60.0,
            child: Flow(
              delegate: _HorizontalFlowDelegate(),
              children: [
                Container(width: 40.0, height: 40.0, color: Color(0xFF2196F3)),
                Container(width: 40.0, height: 40.0, color: Color(0xFF4CAF50)),
                Container(width: 40.0, height: 40.0, color: Color(0xFFFF5722)),
              ],
            ),
          ),
          Text('Horizontal Flow Layout'),
        ],
      ),
    ),
  );
}

class _TestFlowDelegate extends FlowDelegate {
  final void Function(FlowPaintingContext, Size, int) onPaint;
  _TestFlowDelegate({required this.onPaint});

  @override
  void paintChildren(FlowPaintingContext context) {
    onPaint(context, context.size, 0);
    for (int i = 0; i < 3; i++) {
      context.paintChild(i);
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}

class _SimpleFlowDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
    for (int i = 0; i < 3; i++) {
      context.paintChild(
        i,
        transform: Matrix4.translationValues(i * 50.0, 0.0, 0.0),
      );
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}

class _HorizontalFlowDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
    double dx = 0.0;
    for (int i = 0; i < 3; i++) {
      context.paintChild(
        i,
        transform: Matrix4.translationValues(dx, 10.0, 0.0),
      );
      dx += 50.0;
    }
  }

  @override
  Size getSize(BoxConstraints constraints) => Size(150.0, 60.0);

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}

class _VerticalFlowDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
    double dy = 0.0;
    for (int i = 0; i < 3; i++) {
      context.paintChild(i, transform: Matrix4.translationValues(0.0, dy, 0.0));
      dy += 50.0;
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}
