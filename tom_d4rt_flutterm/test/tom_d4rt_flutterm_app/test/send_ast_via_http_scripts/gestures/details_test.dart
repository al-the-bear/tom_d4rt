// D4rt test script: Tests gesture detail classes
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Gestures detail test executing');

  // ========== TAP DETAILS ==========
  print('--- TapDownDetails Tests ---');

  final tapDownDetails = TapDownDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 80.0),
    kind: PointerDeviceKind.touch,
  );
  print('TapDownDetails:');
  print('  globalPosition: ${tapDownDetails.globalPosition}');
  print('  localPosition: ${tapDownDetails.localPosition}');
  print('  kind: ${tapDownDetails.kind}');

  // Test with default localPosition
  final tapDownGlobalOnly = TapDownDetails(
    globalPosition: Offset(150.0, 250.0),
  );
  print('TapDownDetails (global only): ${tapDownGlobalOnly.globalPosition}');
  print('  local defaults to global: ${tapDownGlobalOnly.localPosition}');

  // Test different pointer kinds
  final tapDownMouse = TapDownDetails(
    globalPosition: Offset(100.0, 100.0),
    kind: PointerDeviceKind.mouse,
  );
  print('TapDownDetails with mouse: ${tapDownMouse.kind}');

  final tapDownStylus = TapDownDetails(
    globalPosition: Offset(100.0, 100.0),
    kind: PointerDeviceKind.stylus,
  );
  print('TapDownDetails with stylus: ${tapDownStylus.kind}');

  print('--- TapUpDetails Tests ---');

  final tapUpDetails = TapUpDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 80.0),
    kind: PointerDeviceKind.touch,
  );
  print('TapUpDetails:');
  print('  globalPosition: ${tapUpDetails.globalPosition}');
  print('  localPosition: ${tapUpDetails.localPosition}');
  print('  kind: ${tapUpDetails.kind}');

  // ========== DRAG DETAILS ==========
  print('--- DragStartDetails Tests ---');

  final dragStartDetails = DragStartDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 80.0),
    sourceTimeStamp: Duration(milliseconds: 1000),
    kind: PointerDeviceKind.touch,
  );
  print('DragStartDetails:');
  print('  globalPosition: ${dragStartDetails.globalPosition}');
  print('  localPosition: ${dragStartDetails.localPosition}');
  print('  sourceTimeStamp: ${dragStartDetails.sourceTimeStamp}');
  print('  kind: ${dragStartDetails.kind}');

  print('--- DragUpdateDetails Tests ---');

  final dragUpdateDetails = DragUpdateDetails(
    globalPosition: Offset(150.0, 250.0),
    localPosition: Offset(100.0, 130.0),
    delta: Offset(0.0, 15.0),
    primaryDelta: 15.0,
    sourceTimeStamp: Duration(milliseconds: 1100),
  );
  print('DragUpdateDetails:');
  print('  globalPosition: ${dragUpdateDetails.globalPosition}');
  print('  localPosition: ${dragUpdateDetails.localPosition}');
  print('  delta: ${dragUpdateDetails.delta}');
  print('  primaryDelta: ${dragUpdateDetails.primaryDelta}');
  print('  sourceTimeStamp: ${dragUpdateDetails.sourceTimeStamp}');

  // Test with just required params
  final dragUpdateMinimal = DragUpdateDetails(
    globalPosition: Offset(200.0, 300.0),
  );
  print(
    'DragUpdateDetails minimal: global=${dragUpdateMinimal.globalPosition}',
  );

  print('--- DragEndDetails Tests ---');

  final dragEndDetails = DragEndDetails(
    velocity: Velocity(pixelsPerSecond: Offset(0.0, 300.0)),
    primaryVelocity: 300.0,
  );
  print('DragEndDetails:');
  print('  velocity: ${dragEndDetails.velocity}');
  print('  primaryVelocity: ${dragEndDetails.primaryVelocity}');

  // Test with zero velocity
  final dragEndStopped = DragEndDetails(velocity: Velocity.zero);
  print('DragEndDetails stopped: velocity=${dragEndStopped.velocity}');

  // ========== VELOCITY ==========
  print('--- Velocity Tests ---');

  final velocity = Velocity(pixelsPerSecond: Offset(100.0, 200.0));
  print('Velocity: ${velocity.pixelsPerSecond}');

  final velocityZero = Velocity.zero;
  print('Velocity.zero: ${velocityZero.pixelsPerSecond}');

  // Test velocity operations
  final negatedVelocity = -velocity;
  print('Negated velocity: ${negatedVelocity.pixelsPerSecond}');

  final addedVelocity =
      velocity + Velocity(pixelsPerSecond: Offset(50.0, 50.0));
  print('Added velocity: ${addedVelocity.pixelsPerSecond}');

  final subtractedVelocity =
      velocity - Velocity(pixelsPerSecond: Offset(50.0, 50.0));
  print('Subtracted velocity: ${subtractedVelocity.pixelsPerSecond}');

  // Test clampMagnitude
  final fastVelocity = Velocity(pixelsPerSecond: Offset(1000.0, 1000.0));
  final clampedVelocity = fastVelocity.clampMagnitude(100.0, 500.0);
  print('Clamped velocity (max 500): ${clampedVelocity.pixelsPerSecond}');

  // ========== LONG PRESS DETAILS ==========
  print('--- LongPressStartDetails Tests ---');

  final longPressStartDetails = LongPressStartDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 80.0),
  );
  print('LongPressStartDetails:');
  print('  globalPosition: ${longPressStartDetails.globalPosition}');
  print('  localPosition: ${longPressStartDetails.localPosition}');

  print('--- LongPressMoveUpdateDetails Tests ---');

  final longPressMoveDetails = LongPressMoveUpdateDetails(
    globalPosition: Offset(120.0, 220.0),
    localPosition: Offset(70.0, 100.0),
    offsetFromOrigin: Offset(20.0, 20.0),
    localOffsetFromOrigin: Offset(20.0, 20.0),
  );
  print('LongPressMoveUpdateDetails:');
  print('  globalPosition: ${longPressMoveDetails.globalPosition}');
  print('  offsetFromOrigin: ${longPressMoveDetails.offsetFromOrigin}');

  print('--- LongPressEndDetails Tests ---');

  final longPressEndDetails = LongPressEndDetails(
    globalPosition: Offset(130.0, 230.0),
    localPosition: Offset(80.0, 110.0),
    velocity: Velocity(pixelsPerSecond: Offset(100.0, 50.0)),
  );
  print('LongPressEndDetails:');
  print('  globalPosition: ${longPressEndDetails.globalPosition}');
  print('  velocity: ${longPressEndDetails.velocity}');

  // ========== SCALE DETAILS ==========
  print('--- ScaleStartDetails Tests ---');

  final scaleStartDetails = ScaleStartDetails(
    focalPoint: Offset(150.0, 150.0),
    localFocalPoint: Offset(75.0, 75.0),
    pointerCount: 2,
  );
  print('ScaleStartDetails:');
  print('  focalPoint: ${scaleStartDetails.focalPoint}');
  print('  localFocalPoint: ${scaleStartDetails.localFocalPoint}');
  print('  pointerCount: ${scaleStartDetails.pointerCount}');

  print('--- ScaleUpdateDetails Tests ---');

  final scaleUpdateDetails = ScaleUpdateDetails(
    focalPoint: Offset(160.0, 160.0),
    localFocalPoint: Offset(80.0, 80.0),
    scale: 1.5,
    horizontalScale: 1.5,
    verticalScale: 1.5,
    rotation: 0.785, // 45 degrees
    pointerCount: 2,
    focalPointDelta: Offset(10.0, 10.0),
  );
  print('ScaleUpdateDetails:');
  print('  focalPoint: ${scaleUpdateDetails.focalPoint}');
  print('  scale: ${scaleUpdateDetails.scale}');
  print('  horizontalScale: ${scaleUpdateDetails.horizontalScale}');
  print('  verticalScale: ${scaleUpdateDetails.verticalScale}');
  print('  rotation: ${scaleUpdateDetails.rotation}');
  print('  pointerCount: ${scaleUpdateDetails.pointerCount}');
  print('  focalPointDelta: ${scaleUpdateDetails.focalPointDelta}');

  print('--- ScaleEndDetails Tests ---');

  final scaleEndDetails = ScaleEndDetails(
    velocity: Velocity(pixelsPerSecond: Offset(200.0, 100.0)),
    scaleVelocity: 0.5,
    pointerCount: 0,
  );
  print('ScaleEndDetails:');
  print('  velocity: ${scaleEndDetails.velocity}');
  print('  scaleVelocity: ${scaleEndDetails.scaleVelocity}');
  print('  pointerCount: ${scaleEndDetails.pointerCount}');

  // ========== FORCE PRESS DETAILS ==========
  print('--- ForcePressDetails Tests ---');

  final forcePressDetails = ForcePressDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 80.0),
    pressure: 0.8,
  );
  print('ForcePressDetails:');
  print('  globalPosition: ${forcePressDetails.globalPosition}');
  print('  localPosition: ${forcePressDetails.localPosition}');
  print('  pressure: ${forcePressDetails.pressure}');

  // ========== OFFSET PAIR ==========
  print('--- OffsetPair Tests ---');

  final offsetPair = OffsetPair(
    local: Offset(50.0, 80.0),
    global: Offset(100.0, 200.0),
  );
  print('OffsetPair:');
  print('  local: ${offsetPair.local}');
  print('  global: ${offsetPair.global}');

  final zeroOffsetPair = OffsetPair.zero;
  print(
    'OffsetPair.zero: local=${zeroOffsetPair.local}, global=${zeroOffsetPair.global}',
  );

  // Test from event globals using PointerDownEvent
  final pointerEvent = PointerDownEvent(position: Offset(100.0, 200.0));
  final fromGlobals = OffsetPair.fromEventPosition(pointerEvent);
  print(
    'OffsetPair.fromEventPosition: local=${fromGlobals.local}, global=${fromGlobals.global}',
  );

  // Test operations
  final addedPair =
      offsetPair +
      OffsetPair(local: Offset(10.0, 10.0), global: Offset(20.0, 20.0));
  print(
    'Added OffsetPair: local=${addedPair.local}, global=${addedPair.global}',
  );

  final subtractedPair =
      offsetPair -
      OffsetPair(local: Offset(10.0, 10.0), global: Offset(20.0, 20.0));
  print(
    'Subtracted OffsetPair: local=${subtractedPair.local}, global=${subtractedPair.global}',
  );

  print('Gestures detail test completed');

  // Return a visual representation with interactive gestures
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gesture Details Tests',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            Text(
              'Tap Gestures:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                GestureDetector(
                  onTapDown: (details) =>
                      print('TapDown: ${details.globalPosition}'),
                  onTapUp: (details) =>
                      print('TapUp: ${details.globalPosition}'),
                  onTap: () => print('Tap'),
                  child: Container(
                    width: 80.0,
                    height: 60.0,
                    color: Color(0xFF2196F3),
                    child: Center(
                      child: Text(
                        'Tap',
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                GestureDetector(
                  onDoubleTap: () => print('DoubleTap'),
                  child: Container(
                    width: 80.0,
                    height: 60.0,
                    color: Color(0xFF4CAF50),
                    child: Center(
                      child: Text(
                        'Double',
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'Drag Gestures:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                GestureDetector(
                  onHorizontalDragStart: (d) =>
                      print('HorizDrag: ${d.globalPosition}'),
                  onHorizontalDragUpdate: (d) => print('HorizMove: ${d.delta}'),
                  onHorizontalDragEnd: (d) => print('HorizEnd: ${d.velocity}'),
                  child: Container(
                    width: 100.0,
                    height: 60.0,
                    color: Color(0xFFFF9800),
                    child: Center(
                      child: Text(
                        'H-Drag',
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                GestureDetector(
                  onVerticalDragStart: (d) =>
                      print('VertDrag: ${d.globalPosition}'),
                  onVerticalDragUpdate: (d) => print('VertMove: ${d.delta}'),
                  onVerticalDragEnd: (d) => print('VertEnd: ${d.velocity}'),
                  child: Container(
                    width: 100.0,
                    height: 60.0,
                    color: Color(0xFFE53935),
                    child: Center(
                      child: Text(
                        'V-Drag',
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            Text('Long Press:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            GestureDetector(
              onLongPressStart: (d) => print('LongPress: ${d.globalPosition}'),
              onLongPressMoveUpdate: (d) =>
                  print('LongMove: ${d.offsetFromOrigin}'),
              onLongPressEnd: (d) => print('LongEnd: ${d.velocity}'),
              child: Container(
                width: 120.0,
                height: 60.0,
                color: Color(0xFF9C27B0),
                child: Center(
                  child: Text(
                    'Long Press',
                    style: TextStyle(color: Color(0xFFFFFFFF)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),

            Text('Scale/Pinch:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            GestureDetector(
              onScaleStart: (d) => print('ScaleStart: ${d.focalPoint}'),
              onScaleUpdate: (d) => print(
                'ScaleUpdate: scale=${d.scale}, rotation=${d.rotation}',
              ),
              onScaleEnd: (d) => print('ScaleEnd: ${d.velocity}'),
              child: Container(
                width: 150.0,
                height: 80.0,
                color: Color(0xFF607D8B),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Scale/Rotate',
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                      ),
                      Text(
                        '(pinch gesture)',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),

            Text(
              'Detail Classes Summary:',
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
                    '• TapDownDetails - position, kind',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• TapUpDetails - position, kind',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• DragStartDetails - position, timestamp',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• DragUpdateDetails - delta, position',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• DragEndDetails - velocity',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• LongPressStartDetails - position',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• LongPressMoveUpdateDetails - offset',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• LongPressEndDetails - velocity',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• ScaleStartDetails - focalPoint, count',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• ScaleUpdateDetails - scale, rotation',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• ScaleEndDetails - velocity',
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
