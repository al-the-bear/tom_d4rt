// D4rt test script: Tests AnimatedSwitcher, AnimatedCrossFade, AnimatedSize,
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// AnimatedModalBarrier, AnimatedPositionedDirectional, AnimatedFractionallySizedBox,
// AnimatedSlide, AnimatedRotation
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

dynamic build(BuildContext context) {
  print('Animated widgets advanced test executing');

  // ========== AnimatedSwitcher ==========
  print('--- AnimatedSwitcher Tests ---');
  final animatedSwitcher = AnimatedSwitcher(
    duration: Duration(milliseconds: 500),
    reverseDuration: Duration(milliseconds: 300),
    switchInCurve: Curves.easeIn,
    switchOutCurve: Curves.easeOut,
    transitionBuilder: (child, animation) {
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(scale: animation, child: child),
      );
    },
    layoutBuilder: (currentChild, previousChildren) {
      return Stack(
        alignment: Alignment.center,
        children: [...previousChildren, if (currentChild != null) currentChild],
      );
    },
    child: Text('Content', key: ValueKey('key1')),
  );
  print('AnimatedSwitcher created');

  // ========== AnimatedCrossFade ==========
  print('--- AnimatedCrossFade Tests ---');
  final crossFade = AnimatedCrossFade(
    firstChild: Container(
      width: 200,
      height: 100,
      color: Colors.blue,
      child: Center(child: Text('First')),
    ),
    secondChild: Container(
      width: 200,
      height: 150,
      color: Colors.red,
      child: Center(child: Text('Second')),
    ),
    crossFadeState: CrossFadeState.showFirst,
    duration: Duration(milliseconds: 300),
    reverseDuration: Duration(milliseconds: 200),
    firstCurve: Curves.easeIn,
    secondCurve: Curves.easeOut,
    sizeCurve: Curves.easeInOut,
    alignment: Alignment.center,
    excludeBottomFocus: true,
  );
  print('AnimatedCrossFade created');
  print('  CrossFadeState.showFirst: ${CrossFadeState.showFirst}');
  print('  CrossFadeState.showSecond: ${CrossFadeState.showSecond}');

  // ========== AnimatedSize ==========
  print('--- AnimatedSize Tests ---');
  final animatedSize = AnimatedSize(
    duration: Duration(milliseconds: 300),
    reverseDuration: Duration(milliseconds: 200),
    curve: Curves.easeInOut,
    alignment: Alignment.center,
    clipBehavior: Clip.hardEdge,
    child: Container(width: 100, height: 100, color: Colors.green),
  );
  print('AnimatedSize created');

  // ========== AnimatedSlide ==========
  print('--- AnimatedSlide Tests ---');
  final animatedSlide = AnimatedSlide(
    offset: Offset(0, 0),
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
    child: Container(
      width: 100,
      height: 100,
      color: Colors.orange,
      child: Center(child: Text('Slide')),
    ),
  );
  print('AnimatedSlide created');

  // ========== AnimatedRotation ==========
  print('--- AnimatedRotation Tests ---');
  final animatedRotation = AnimatedRotation(
    turns: 0.5,
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOut,
    alignment: Alignment.center,
    filterQuality: FilterQuality.low,
    child: Container(
      width: 100,
      height: 100,
      color: Colors.purple,
      child: Center(child: Text('Rotate')),
    ),
  );
  print('AnimatedRotation created');

  // ========== AnimatedFractionallySizedBox ==========
  print('--- AnimatedFractionallySizedBox Tests ---');
  final animatedFractional = AnimatedFractionallySizedBox(
    widthFactor: 0.8,
    heightFactor: 0.5,
    alignment: Alignment.center,
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
    child: Container(
      color: Colors.teal,
      child: Center(child: Text('Fractional')),
    ),
  );
  print('AnimatedFractionallySizedBox created');

  // ========== AnimatedPositionedDirectional ==========
  print('--- AnimatedPositionedDirectional Tests ---');
  final animatedPosDir = AnimatedPositionedDirectional(
    start: 10.0,
    top: 10.0,
    width: 100.0,
    height: 100.0,
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
    child: Container(color: Colors.amber),
  );
  print('AnimatedPositionedDirectional created');

  // ========== AnimatedModalBarrier ==========
  print('--- AnimatedModalBarrier Tests ---');
  final animController = AnimationController(vsync: TestVSync(), value: 0.5);
  final animatedBarrier = AnimatedModalBarrier(
    color: animController.drive(
      ColorTween(begin: Colors.transparent, end: Colors.black54),
    ),
    dismissible: true,
    semanticsLabel: 'Barrier',
  );
  print('AnimatedModalBarrier created');

  print('All animated widgets advanced tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            animatedSwitcher,
            crossFade,
            animatedSize,
            animatedSlide,
            animatedRotation,
            Container(height: 200, child: animatedFractional),
            SizedBox(height: 200, child: Stack(children: [animatedPosDir])),
          ],
        ),
      ),
    ),
  );
}

class TestVSync implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}
