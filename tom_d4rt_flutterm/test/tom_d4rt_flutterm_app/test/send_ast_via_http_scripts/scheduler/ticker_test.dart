// D4rt test script: Tests Ticker, TickerProvider from package:flutter/scheduler.dart
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:flutter/scheduler.dart';

dynamic build(BuildContext context) {
  print('Scheduler test executing');

  // ========== SCHEDULERBINDING ==========
  print('--- SchedulerBinding Tests ---');

  // Note: SchedulerBinding is a singleton and already initialized in Flutter
  // We can access scheduler information through it

  // SchedulerPhase
  print('SchedulerPhase.idle: ${SchedulerPhase.idle}');
  print(
    'SchedulerPhase.transientCallbacks: ${SchedulerPhase.transientCallbacks}',
  );
  print(
    'SchedulerPhase.midFrameMicrotasks: ${SchedulerPhase.midFrameMicrotasks}',
  );
  print(
    'SchedulerPhase.persistentCallbacks: ${SchedulerPhase.persistentCallbacks}',
  );
  print(
    'SchedulerPhase.postFrameCallbacks: ${SchedulerPhase.postFrameCallbacks}',
  );

  // ========== TICKERPROVIDER ==========
  print('--- TickerProvider Tests ---');

  // TickerProvider is typically used via SingleTickerProviderStateMixin
  // or TickerProviderStateMixin in a State class
  print('TickerProvider is an abstract class for creating Tickers');
  print('Common implementations:');
  print('  - SingleTickerProviderStateMixin (for single animation)');
  print('  - TickerProviderStateMixin (for multiple animations)');

  // ========== TICKER ==========
  print('--- Ticker Tests ---');

  // Note: Creating a Ticker requires a TickerProvider/vsync
  // Since we're in a build method and not a State with a mixin,
  // we'll document the API rather than create actual tickers

  print(
    'Ticker constructor: Ticker(TickerCallback onTick, {String? debugLabel})',
  );
  print('Ticker properties:');
  print('  - isTicking: bool');
  print('  - isActive: bool');
  print('  - muted: bool (getter/setter)');
  print('  - debugLabel: String?');
  print('Ticker methods:');
  print('  - start(): TickerFuture');
  print('  - stop({bool canceled = false}): void');
  print('  - absorbTicker(Ticker originalTicker): void');
  print('  - dispose(): void');

  // ========== TICKERFUTURE ==========
  print('--- TickerFuture Tests ---');

  // TickerFuture is returned by Ticker.start()
  final completedFuture = TickerFuture.complete();
  print('TickerFuture.complete() created');
  print('TickerFuture properties:');
  print('  - orCancel: Future<void>');
  print('  - whenComplete/then/catchError (Future methods)');

  // ========== PRIORITY ==========
  print('--- Priority Tests ---');

  print('Priority.idle: ${Priority.idle.value}');
  print('Priority.animation: ${Priority.animation.value}');
  print('Priority.touch: ${Priority.touch.value}');
  print('Priority.kMaxOffset: ${Priority.kMaxOffset}');

  // ========== FRAME TIMING ==========
  print('--- FrameTiming Tests ---');

  // FrameTiming is typically received from SchedulerBinding
  print('FrameTiming provides timing for frame phases:');
  print('  - buildDuration: Duration');
  print('  - rasterDuration: Duration');
  print('  - vsyncOverhead: Duration');
  print('  - totalSpan: Duration');
  print('  - layerCacheCount: int');
  print('  - layerCacheBytes: int');

  // FramePhase
  print('FramePhase.vsyncStart');
  print('FramePhase.buildStart');
  print('FramePhase.buildFinish');
  print('FramePhase.rasterStart');
  print('FramePhase.rasterFinish');
  print('FramePhase.rasterFinishWallTime');

  // ========== APPLIFECYCLESTATE ==========
  print('--- AppLifecycleState Tests ---');

  print('AppLifecycleState.detached: ${AppLifecycleState.detached}');
  print('AppLifecycleState.resumed: ${AppLifecycleState.resumed}');
  print('AppLifecycleState.inactive: ${AppLifecycleState.inactive}');
  print('AppLifecycleState.hidden: ${AppLifecycleState.hidden}');
  print('AppLifecycleState.paused: ${AppLifecycleState.paused}');

  print('Scheduler test completed');

  // Return visual demonstration with a TickerMode example
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Scheduler Tests',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            Text(
              'SchedulerPhase:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.all(8.0),
              color: Color(0xFFE0E0E0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1. idle - between frames',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '2. transientCallbacks - animate',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '3. midFrameMicrotasks - process microtasks',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '4. persistentCallbacks - build/layout/paint',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '5. postFrameCallbacks - cleanup',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            Text(
              'Ticker Usage:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.all(8.0),
              color: Color(0xFFE0E0E0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '// In a State with SingleTickerProviderStateMixin:',
                    style: TextStyle(fontSize: 11.0, fontFamily: 'monospace'),
                  ),
                  Text(
                    'late final _controller = AnimationController(',
                    style: TextStyle(fontSize: 11.0, fontFamily: 'monospace'),
                  ),
                  Text(
                    '  vsync: this,  // from mixin',
                    style: TextStyle(fontSize: 11.0, fontFamily: 'monospace'),
                  ),
                  Text(
                    '  duration: Duration(seconds: 1),',
                    style: TextStyle(fontSize: 11.0, fontFamily: 'monospace'),
                  ),
                  Text(
                    ');',
                    style: TextStyle(fontSize: 11.0, fontFamily: 'monospace'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            Text(
              'TickerProvider Mixins:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.only(right: 4.0),
                    color: Color(0xFF2196F3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SingleTicker',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          'One animation',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 10.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.only(left: 4.0),
                    color: Color(0xFF4CAF50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TickerProvider',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          'Multiple anims',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 10.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'Priority Levels:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 6.0,
                  ),
                  margin: EdgeInsets.only(right: 8.0),
                  color: Color(0xFF9E9E9E),
                  child: Text(
                    'idle',
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12.0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 6.0,
                  ),
                  margin: EdgeInsets.only(right: 8.0),
                  color: Color(0xFF2196F3),
                  child: Text(
                    'animation',
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12.0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 6.0,
                  ),
                  color: Color(0xFFE53935),
                  child: Text(
                    'touch',
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12.0),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'AppLifecycleState:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (final state in [
                  'detached',
                  'resumed',
                  'inactive',
                  'hidden',
                  'paused',
                ])
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 4.0,
                    ),
                    color: Color(0xFF9C27B0),
                    child: Text(
                      state,
                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 9.0),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'TickerMode Widget:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TickerMode(
              enabled: true,
              child: Container(
                padding: EdgeInsets.all(8.0),
                color: Color(0xFFE0E0E0),
                child: Text('Animations enabled in this subtree'),
              ),
            ),
            SizedBox(height: 8.0),
            TickerMode(
              enabled: false,
              child: Container(
                padding: EdgeInsets.all(8.0),
                color: Color(0xFFFFCDD2),
                child: Text('Animations disabled in this subtree'),
              ),
            ),
            SizedBox(height: 16.0),

            Text(
              'Frame Timing Info:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.all(8.0),
              color: Color(0xFFE0E0E0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'buildDuration - widget build time',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    'rasterDuration - GPU render time',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    'vsyncOverhead - vsync delay',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    'totalSpan - total frame time',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
