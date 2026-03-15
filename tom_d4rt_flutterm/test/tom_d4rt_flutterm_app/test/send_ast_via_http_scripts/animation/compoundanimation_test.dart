// D4rt test script: Tests ProxyAnimation, ReverseAnimation, and animation composition from animation
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('CompoundAnimation test executing');

  // ========== PROXYANIMATION ==========
  print('--- ProxyAnimation Tests ---');

  // ProxyAnimation wrapping an AlwaysStoppedAnimation
  final baseAnim = AlwaysStoppedAnimation<double>(0.7);
  final proxy = ProxyAnimation(baseAnim);
  print('ProxyAnimation wrapping AlwaysStoppedAnimation(0.7):');
  print('  value: ${proxy.value}');
  print('  status: ${proxy.status}');

  // ProxyAnimation with different values
  final proxy0 = ProxyAnimation(AlwaysStoppedAnimation<double>(0.0));
  print('ProxyAnimation(0.0): value=${proxy0.value}, status=${proxy0.status}');

  final proxy1 = ProxyAnimation(AlwaysStoppedAnimation<double>(1.0));
  print('ProxyAnimation(1.0): value=${proxy1.value}, status=${proxy1.status}');

  final proxyHalf = ProxyAnimation(AlwaysStoppedAnimation<double>(0.5));
  print(
    'ProxyAnimation(0.5): value=${proxyHalf.value}, status=${proxyHalf.status}',
  );

  // ProxyAnimation without parent (defaults)
  final proxyEmpty = ProxyAnimation();
  print('ProxyAnimation() [no parent]:');
  print('  value: ${proxyEmpty.value}');
  print('  status: ${proxyEmpty.status}');

  // Set parent on empty proxy
  proxyEmpty.parent = AlwaysStoppedAnimation<double>(0.3);
  print('ProxyAnimation after setting parent to 0.3:');
  print('  value: ${proxyEmpty.value}');
  print('  status: ${proxyEmpty.status}');

  // ========== REVERSEANIMATION ==========
  print('--- ReverseAnimation Tests ---');

  // ReverseAnimation inverts the value
  final forwardAnim = AlwaysStoppedAnimation<double>(0.3);
  final reverse = ReverseAnimation(forwardAnim);
  print('ReverseAnimation(0.3):');
  print('  value: ${reverse.value}');
  print('  status: ${reverse.status}');

  final reverseOfFull = ReverseAnimation(AlwaysStoppedAnimation<double>(1.0));
  print('ReverseAnimation(1.0):');
  print('  value: ${reverseOfFull.value}');
  print('  status: ${reverseOfFull.status}');

  final reverseOfZero = ReverseAnimation(AlwaysStoppedAnimation<double>(0.0));
  print('ReverseAnimation(0.0):');
  print('  value: ${reverseOfZero.value}');
  print('  status: ${reverseOfZero.status}');

  final reverseOfHalf = ReverseAnimation(AlwaysStoppedAnimation<double>(0.5));
  print('ReverseAnimation(0.5):');
  print('  value: ${reverseOfHalf.value}');
  print('  status: ${reverseOfHalf.status}');

  // ========== PROXY + REVERSE COMPOSITION ==========
  print('--- Composition Tests ---');

  // ProxyAnimation wrapping ReverseAnimation
  final composedAnim = AlwaysStoppedAnimation<double>(0.8);
  final reversed = ReverseAnimation(composedAnim);
  final proxied = ProxyAnimation(reversed);
  print('ProxyAnimation(ReverseAnimation(0.8)):');
  print('  value: ${proxied.value}');
  print('  status: ${proxied.status}');

  // Double reverse (should be identity)
  final doubleReverse = ReverseAnimation(
    ReverseAnimation(AlwaysStoppedAnimation<double>(0.6)),
  );
  print('ReverseAnimation(ReverseAnimation(0.6)):');
  print('  value: ${doubleReverse.value}');

  // ========== CURVEDANIMATION CONCEPT ==========
  print('--- CurvedAnimation with AlwaysStoppedAnimation ---');

  // CurvedAnimation requires AnimationController normally,
  // but we can use it with ProxyAnimation
  final curveParent = AlwaysStoppedAnimation<double>(0.5);
  final curved = CurvedAnimation(parent: curveParent, curve: Curves.easeInOut);
  print('CurvedAnimation(parent=0.5, curve=easeInOut):');
  print('  value: ${curved.value}');

  final curvedLinear = CurvedAnimation(
    parent: AlwaysStoppedAnimation<double>(0.5),
    curve: Curves.linear,
  );
  print(
    'CurvedAnimation(parent=0.5, curve=linear): value=${curvedLinear.value}',
  );

  final curvedBounce = CurvedAnimation(
    parent: AlwaysStoppedAnimation<double>(0.5),
    curve: Curves.bounceOut,
  );
  print(
    'CurvedAnimation(parent=0.5, curve=bounceOut): value=${curvedBounce.value}',
  );

  // Multiple animation values through CurvedAnimation
  print('CurvedAnimation easeInOut at various parent values:');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final c = CurvedAnimation(
      parent: AlwaysStoppedAnimation<double>(t),
      curve: Curves.easeInOut,
    );
    print('  parent=$t -> curved=${c.value.toStringAsFixed(4)}');
  }

  // ========== TRAINHOPPINGANIMATION ==========
  print('--- TrainHoppingAnimation Tests ---');

  // TrainHoppingAnimation switches from one animation to another
  // when the second crosses the first
  final train1 = AlwaysStoppedAnimation<double>(0.4);
  final train2 = AlwaysStoppedAnimation<double>(0.6);
  final trainHop = TrainHoppingAnimation(train1, train2);
  print('TrainHoppingAnimation(0.4, 0.6):');
  print('  value: ${trainHop.value}');
  print('  status: ${trainHop.status}');

  final trainHop2 = TrainHoppingAnimation(
    AlwaysStoppedAnimation<double>(0.8),
    AlwaysStoppedAnimation<double>(0.2),
  );
  print('TrainHoppingAnimation(0.8, 0.2):');
  print('  value: ${trainHop2.value}');

  // TrainHoppingAnimation with null second animation
  final trainSingle = TrainHoppingAnimation(
    AlwaysStoppedAnimation<double>(0.5),
    null,
  );
  print('TrainHoppingAnimation(0.5, null):');
  print('  value: ${trainSingle.value}');

  // ========== WIDGET TREE ==========
  return Container(
    padding: EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Compound Animation Test Results',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1565C0),
            ),
          ),
          SizedBox(height: 16.0),

          // Visualize ProxyAnimation
          Text(
            'ProxyAnimation (value=0.7):',
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.0),
          FadeTransition(
            opacity: proxy,
            child: Container(
              width: 200.0,
              height: 30.0,
              color: Color(0xFF2196F3),
              child: Center(
                child: Text(
                  'ProxyAnimation',
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 11.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.0),

          // Visualize ReverseAnimation
          Text(
            'ReverseAnimation of 0.3 (shows as 0.7):',
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.0),
          FadeTransition(
            opacity: reverse,
            child: Container(
              width: 200.0,
              height: 30.0,
              color: Color(0xFF4CAF50),
              child: Center(
                child: Text(
                  'ReverseAnimation',
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 11.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.0),

          // Visualize CurvedAnimation
          Text(
            'CurvedAnimation (easeInOut at 0.5):',
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.0),
          FadeTransition(
            opacity: curved,
            child: Container(
              width: 200.0,
              height: 30.0,
              color: Color(0xFFFF9800),
              child: Center(
                child: Text(
                  'CurvedAnimation',
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 11.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.0),

          // Visualize TrainHoppingAnimation
          Text(
            'TrainHoppingAnimation (0.4 -> 0.6):',
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.0),
          FadeTransition(
            opacity: trainHop,
            child: Container(
              width: 200.0,
              height: 30.0,
              color: Color(0xFF9C27B0),
              child: Center(
                child: Text(
                  'TrainHopping',
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 11.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0),

          // Bar chart showing values
          Text(
            'Value Comparison:',
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          _valueBar('Proxy(0.7)', proxy.value, Color(0xFF2196F3)),
          SizedBox(height: 4.0),
          _valueBar('Reverse(0.3)', reverse.value, Color(0xFF4CAF50)),
          SizedBox(height: 4.0),
          _valueBar('Curved(0.5)', curved.value, Color(0xFFFF9800)),
          SizedBox(height: 4.0),
          _valueBar('TrainHop', trainHop.value, Color(0xFF9C27B0)),
          SizedBox(height: 16.0),

          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFF5F5F5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Animation Composition Summary:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
                ),
                SizedBox(height: 4.0),
                Text(
                  '• ProxyAnimation: wraps and delegates to another animation',
                  style: TextStyle(fontSize: 11.0),
                ),
                Text(
                  '• ReverseAnimation: inverts animation value (1 - value)',
                  style: TextStyle(fontSize: 11.0),
                ),
                Text(
                  '• CurvedAnimation: applies curve to parent animation',
                  style: TextStyle(fontSize: 11.0),
                ),
                Text(
                  '• TrainHoppingAnimation: switches between two animations',
                  style: TextStyle(fontSize: 11.0),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _valueBar(String label, double value, Color color) {
  return Row(
    children: [
      SizedBox(
        width: 100.0,
        child: Text(label, style: TextStyle(fontSize: 11.0)),
      ),
      Expanded(
        child: Container(
          height: 16.0,
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: value,
            child: Container(color: color),
          ),
        ),
      ),
      SizedBox(width: 4.0),
      Text(value.toStringAsFixed(3), style: TextStyle(fontSize: 10.0)),
    ],
  );
}
