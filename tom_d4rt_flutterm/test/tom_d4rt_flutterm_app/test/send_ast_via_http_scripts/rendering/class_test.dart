// D4rt test script: Tests various rendering classes overview
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Rendering classes test executing');

  // ========== Core Layer Classes ==========
  print('--- Core Layer Classes ---');
  final offsetLayer = OffsetLayer();
  offsetLayer.offset = Offset(10.0, 20.0);
  print(
    '  OffsetLayer: ${offsetLayer.runtimeType}, offset=${offsetLayer.offset}',
  );

  final clipRectLayer = ClipRectLayer(
    clipRect: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
  );
  print(
    '  ClipRectLayer: ${clipRectLayer.runtimeType}, rect=${clipRectLayer.clipRect}',
  );

  final opacityLayer = OpacityLayer(alpha: 128);
  print(
    '  OpacityLayer: ${opacityLayer.runtimeType}, alpha=${opacityLayer.alpha}',
  );

  final transformLayer = TransformLayer(transform: Matrix4.identity());
  print('  TransformLayer: ${transformLayer.runtimeType}');

  // ========== Constraints Classes ==========
  print('--- Constraints Classes ---');
  final boxConstraints = BoxConstraints(
    minWidth: 50.0,
    maxWidth: 200.0,
    minHeight: 30.0,
    maxHeight: 150.0,
  );
  print(
    '  BoxConstraints: minW=${boxConstraints.minWidth}, maxW=${boxConstraints.maxWidth}',
  );
  print('    isTight: ${boxConstraints.isTight}');
  print('    isNormalized: ${boxConstraints.isNormalized}');

  final sliverConstraints = SliverConstraints(
    axisDirection: AxisDirection.down,
    growthDirection: GrowthDirection.forward,
    userScrollDirection: ScrollDirection.idle,
    scrollOffset: 0.0,
    precedingScrollExtent: 0.0,
    overlap: 0.0,
    remainingPaintExtent: 500.0,
    crossAxisExtent: 300.0,
    crossAxisDirection: AxisDirection.right,
    viewportMainAxisExtent: 600.0,
    remainingCacheExtent: 500.0,
    cacheOrigin: 0.0,
  );
  print(
    '  SliverConstraints: remainingPaintExtent=${sliverConstraints.remainingPaintExtent}',
  );

  // ========== ParentData Classes ==========
  print('--- ParentData Classes ---');
  final boxParentData = BoxParentData();
  boxParentData.offset = Offset(25.0, 50.0);
  print('  BoxParentData: offset=${boxParentData.offset}');

  final flexParentData = FlexParentData();
  flexParentData.flex = 2;
  flexParentData.fit = FlexFit.tight;
  print(
    '  FlexParentData: flex=${flexParentData.flex}, fit=${flexParentData.fit}',
  );

  final stackParentData = StackParentData();
  stackParentData.top = 10.0;
  stackParentData.left = 20.0;
  print(
    '  StackParentData: top=${stackParentData.top}, left=${stackParentData.left}',
  );

  // ========== Geometry Classes ==========
  print('--- Geometry Classes ---');
  final sliverGeometry = SliverGeometry(
    scrollExtent: 200.0,
    paintExtent: 150.0,
    maxPaintExtent: 200.0,
  );
  print('  SliverGeometry: scrollExtent=${sliverGeometry.scrollExtent}');
  print('    paintExtent: ${sliverGeometry.paintExtent}');
  print('    visible: ${sliverGeometry.visible}');

  final revealedOffset = RevealedOffset(
    offset: 100.0,
    rect: Rect.fromLTWH(0, 0, 50, 50),
  );
  print(
    '  RevealedOffset: offset=${revealedOffset.offset}, rect=${revealedOffset.rect}',
  );

  // ========== Hit Test Classes ==========
  print('--- Hit Test Classes ---');
  final hitTestResult = BoxHitTestResult();
  print('  BoxHitTestResult: ${hitTestResult.runtimeType}');
  print('  path length: ${hitTestResult.path.length}');

  final sliverHitTestResult = SliverHitTestResult();
  print('  SliverHitTestResult: ${sliverHitTestResult.runtimeType}');

  // ========== Selection Classes ==========
  print('--- Selection Classes ---');
  final selectionPoint = SelectionPoint(
    localPosition: Offset(50.0, 25.0),
    lineHeight: 16.0,
    handleType: TextSelectionHandleType.left,
  );
  print('  SelectionPoint: position=${selectionPoint.localPosition}');
  print('    lineHeight: ${selectionPoint.lineHeight}');
  print('    handleType: ${selectionPoint.handleType}');

  final selectionGeometry = SelectionGeometry(
    startSelectionPoint: selectionPoint,
    endSelectionPoint: selectionPoint,
    status: SelectionStatus.uncollapsed,
  );
  print('  SelectionGeometry: status=${selectionGeometry.status}');
  print('    hasSelection: ${selectionGeometry.hasSelection}');

  // ========== Paint Context Classes ==========
  print('--- Paint & Layout Classes ---');
  final layerHandle = LayerHandle<OffsetLayer>();
  print('  LayerHandle: ${layerHandle.runtimeType}');
  print('  layer: ${layerHandle.layer}');

  final layerLink = LayerLink();
  print('  LayerLink: ${layerLink.runtimeType}');
  print('  leader: ${layerLink.leader}');

  // ========== Alignment & Positioning ==========
  print('--- Alignment & Positioning ---');
  print('  Alignment.center: ${Alignment.center}');
  print('  Alignment.topLeft: ${Alignment.topLeft}');
  print('  FractionalOffset.center: ${FractionalOffset.center}');
  print('  FractionalOffset.topLeft: ${FractionalOffset.topLeft}');

  // ========== Enumeration Classes ==========
  print('--- Enumeration Classes ---');
  print('  AxisDirection.values: ${AxisDirection.values.length} values');
  print('  GrowthDirection.values: ${GrowthDirection.values.length} values');
  print('  ScrollDirection.values: ${ScrollDirection.values.length} values');
  print(
    '  TextSelectionHandleType.values: ${TextSelectionHandleType.values.length} values',
  );
  print('  FlexFit.values: ${FlexFit.values.length} values');
  print(
    '  MainAxisAlignment.values: ${MainAxisAlignment.values.length} values',
  );
  print(
    '  CrossAxisAlignment.values: ${CrossAxisAlignment.values.length} values',
  );

  // ========== Table Classes ==========
  print('--- Table Classes ---');
  final tableBorder = TableBorder.all(color: Color(0xFF000000), width: 1.0);
  print('  TableBorder: ${tableBorder.runtimeType}');
  print('    top: ${tableBorder.top}');
  print('    isUniform: ${tableBorder.isUniform}');

  print('Rendering classes test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Rendering Classes Overview',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Layer Classes: OffsetLayer, ClipRect, Opacity, Transform'),
          Text('Constraints: BoxConstraints, SliverConstraints'),
          Text('ParentData: Box, Flex, Stack'),
          Text('Geometry: SliverGeometry, RevealedOffset'),
          Text('Hit Test: BoxHitTestResult, SliverHitTestResult'),
          Text('Selection: SelectionPoint, SelectionGeometry'),
          Text('Alignment: Alignment, FractionalOffset'),
          Text('Table: TableBorder'),
        ],
      ),
    ),
  );
}
