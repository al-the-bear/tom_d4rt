// D4rt test script: Tests TextPainter from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Rendering TextPainter test executing');

  // ========== TEXTPAINTER ==========
  print('--- TextPainter Tests ---');

  // Test basic TextPainter
  final basicPainter = TextPainter(
    text: TextSpan(text: 'Hello World'),
    textDirection: TextDirection.ltr,
  );
  print(
    'Basic TextPainter created: textDirection=${basicPainter.textDirection}',
  );

  // Test layout
  basicPainter.layout();
  print(
    'After layout: width=${basicPainter.width}, height=${basicPainter.height}',
  );
  print('  size=${basicPainter.size}');

  // Test with maxWidth
  final constrainedPainter = TextPainter(
    text: TextSpan(text: 'This is a longer text that should wrap'),
    textDirection: TextDirection.ltr,
  );
  constrainedPainter.layout(maxWidth: 100.0);
  print(
    'Constrained layout (maxWidth=100): width=${constrainedPainter.width}, height=${constrainedPainter.height}',
  );

  // Test minWidth
  final minWidthPainter = TextPainter(
    text: TextSpan(text: 'Short'),
    textDirection: TextDirection.ltr,
  );
  minWidthPainter.layout(minWidth: 200.0, maxWidth: 300.0);
  print('MinWidth layout (min=200): width=${minWidthPainter.width}');

  // Test with styled text
  final styledPainter = TextPainter(
    text: TextSpan(
      text: 'Styled',
      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    ),
    textDirection: TextDirection.ltr,
  );
  styledPainter.layout();
  print(
    'Styled text: width=${styledPainter.width}, height=${styledPainter.height}',
  );

  // Test textAlign
  final leftAlignPainter = TextPainter(
    text: TextSpan(text: 'Left'),
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.left,
  );
  print('TextAlign.left: ${leftAlignPainter.textAlign}');

  final centerAlignPainter = TextPainter(
    text: TextSpan(text: 'Center'),
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.center,
  );
  print('TextAlign.center: ${centerAlignPainter.textAlign}');

  final rightAlignPainter = TextPainter(
    text: TextSpan(text: 'Right'),
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.right,
  );
  print('TextAlign.right: ${rightAlignPainter.textAlign}');

  final justifyAlignPainter = TextPainter(
    text: TextSpan(text: 'Justify this text to fill the line completely'),
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.justify,
  );
  print('TextAlign.justify: ${justifyAlignPainter.textAlign}');

  // Test textDirection
  final rtlPainter = TextPainter(
    text: TextSpan(text: 'مرحبا'),
    textDirection: TextDirection.rtl,
  );
  print('RTL direction: ${rtlPainter.textDirection}');

  // Test maxLines
  final maxLinesPainter = TextPainter(
    text: TextSpan(text: 'Line 1\nLine 2\nLine 3\nLine 4'),
    textDirection: TextDirection.ltr,
    maxLines: 2,
  );
  maxLinesPainter.layout();
  print('MaxLines=2: height=${maxLinesPainter.height}');

  // Test ellipsis
  final ellipsisPainter = TextPainter(
    text: TextSpan(
      text: 'This is a very long text that should be truncated with ellipsis',
    ),
    textDirection: TextDirection.ltr,
    maxLines: 1,
    ellipsis: '...',
  );
  ellipsisPainter.layout(maxWidth: 150.0);
  print('Ellipsis: didExceedMaxLines=${ellipsisPainter.didExceedMaxLines}');

  // Test textScaler
  final scaledPainter = TextPainter(
    text: TextSpan(text: 'Scaled'),
    textDirection: TextDirection.ltr,
    textScaler: TextScaler.linear(2.0),
  );
  scaledPainter.layout();
  print(
    'Scaled 2x: width=${scaledPainter.width}, height=${scaledPainter.height}',
  );

  // Test strutStyle
  final strutPainter = TextPainter(
    text: TextSpan(text: 'Strut'),
    textDirection: TextDirection.ltr,
    strutStyle: StrutStyle(fontSize: 20.0, height: 1.5, forceStrutHeight: true),
  );
  strutPainter.layout();
  print('With strutStyle: height=${strutPainter.height}');

  // Test textHeightBehavior
  final heightBehaviorPainter = TextPainter(
    text: TextSpan(text: 'Height Behavior'),
    textDirection: TextDirection.ltr,
    textHeightBehavior: TextHeightBehavior(
      applyHeightToFirstAscent: false,
      applyHeightToLastDescent: false,
    ),
  );
  heightBehaviorPainter.layout();
  print('With textHeightBehavior: height=${heightBehaviorPainter.height}');

  // Test textWidthBasis
  final longestLinePainter = TextPainter(
    text: TextSpan(text: 'Test'),
    textDirection: TextDirection.ltr,
    textWidthBasis: TextWidthBasis.longestLine,
  );
  print('TextWidthBasis.longestLine: ${longestLinePainter.textWidthBasis}');

  final parentPainter = TextPainter(
    text: TextSpan(text: 'Test'),
    textDirection: TextDirection.ltr,
    textWidthBasis: TextWidthBasis.parent,
  );
  print('TextWidthBasis.parent: ${parentPainter.textWidthBasis}');

  // Test getPositionForOffset
  basicPainter.layout();
  final position = basicPainter.getPositionForOffset(Offset(20.0, 10.0));
  print(
    'getPositionForOffset(20, 10): offset=${position.offset}, affinity=${position.affinity}',
  );

  // Test getOffsetForCaret
  final caretOffset = basicPainter.getOffsetForCaret(
    TextPosition(offset: 5),
    Rect.zero,
  );
  print(
    'getOffsetForCaret(offset=5): x=${caretOffset.dx}, y=${caretOffset.dy}',
  );

  // Test getFullHeightForCaret
  final caretHeight = basicPainter.getFullHeightForCaret(
    TextPosition(offset: 5),
    Rect.zero,
  );
  print('getFullHeightForCaret(offset=5): ${caretHeight}');

  // Test getBoxesForSelection
  final boxes = basicPainter.getBoxesForSelection(
    TextSelection(baseOffset: 0, extentOffset: 5),
  );
  print('getBoxesForSelection(0-5): ${boxes.length} boxes');

  // Test preferredLineHeight
  print('preferredLineHeight: ${basicPainter.preferredLineHeight}');

  // Test minIntrinsicWidth and maxIntrinsicWidth
  print('minIntrinsicWidth: ${basicPainter.minIntrinsicWidth}');
  print('maxIntrinsicWidth: ${basicPainter.maxIntrinsicWidth}');

  // Test computeLineMetrics
  final metrics = basicPainter.computeLineMetrics();
  print('computeLineMetrics: ${metrics.length} lines');
  if (metrics.isNotEmpty) {
    print(
      '  First line: height=${metrics.first.height}, baseline=${metrics.first.baseline}',
    );
  }

  // Test didExceedMaxLines
  print('didExceedMaxLines (basic): ${basicPainter.didExceedMaxLines}');
  print('didExceedMaxLines (ellipsis): ${ellipsisPainter.didExceedMaxLines}');

  // Test getWordBoundary
  final wordBoundary = basicPainter.getWordBoundary(TextPosition(offset: 2));
  print(
    'getWordBoundary(offset=2): start=${wordBoundary.start}, end=${wordBoundary.end}',
  );

  // Test getLineBoundary
  final lineBoundary = basicPainter.getLineBoundary(TextPosition(offset: 2));
  print(
    'getLineBoundary(offset=2): start=${lineBoundary.start}, end=${lineBoundary.end}',
  );

  // Test inlinePlaceholderBoxes
  print('inlinePlaceholderBoxes: ${basicPainter.inlinePlaceholderBoxes}');

  // Test with inline placeholder
  final placeholderPainter = TextPainter(
    text: TextSpan(
      children: [
        TextSpan(text: 'Before '),
        WidgetSpan(
          child: Container(width: 20.0, height: 20.0, color: Color(0xFFE53935)),
        ),
        TextSpan(text: ' After'),
      ],
    ),
    textDirection: TextDirection.ltr,
  );
  placeholderPainter.setPlaceholderDimensions([
    PlaceholderDimensions(
      size: Size(20.0, 20.0),
      alignment: PlaceholderAlignment.middle,
      baseline: TextBaseline.alphabetic,
    ),
  ]);
  placeholderPainter.layout();
  print('With placeholder: width=${placeholderPainter.width}');

  // Test markNeedsLayout
  basicPainter.markNeedsLayout();
  print('After markNeedsLayout, needs re-layout');

  // Test dispose
  final disposablePainter = TextPainter(
    text: TextSpan(text: 'Disposable'),
    textDirection: TextDirection.ltr,
  );
  disposablePainter.layout();
  disposablePainter.dispose();
  print('Disposed painter');

  print('Rendering TextPainter test completed');

  // Return a visual representation
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TextPainter Tests',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            Text(
              'Text Alignment:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),

            Container(
              width: 200.0,
              padding: EdgeInsets.all(8.0),
              color: Color(0xFFE3F2FD),
              child: Text('Left aligned', textAlign: TextAlign.left),
            ),
            SizedBox(height: 4.0),
            Container(
              width: 200.0,
              padding: EdgeInsets.all(8.0),
              color: Color(0xFFE3F2FD),
              child: Text('Center aligned', textAlign: TextAlign.center),
            ),
            SizedBox(height: 4.0),
            Container(
              width: 200.0,
              padding: EdgeInsets.all(8.0),
              color: Color(0xFFE3F2FD),
              child: Text('Right aligned', textAlign: TextAlign.right),
            ),
            SizedBox(height: 16.0),

            Text(
              'Max Lines & Ellipsis:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Container(
              width: 200.0,
              padding: EdgeInsets.all(8.0),
              color: Color(0xFFFFF3E0),
              child: Text(
                'This is a very long text that should be truncated with ellipsis when it exceeds the available width',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 16.0),

            Text('Text Scale:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('1x', style: TextStyle(fontSize: 14.0)),
                SizedBox(width: 8.0),
                Text('1.5x', style: TextStyle(fontSize: 21.0)),
                SizedBox(width: 8.0),
                Text('2x', style: TextStyle(fontSize: 28.0)),
              ],
            ),
            SizedBox(height: 16.0),

            Text('Direction:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Color(0xFFE8F5E9),
                    child: Text('LTR: Hello', textDirection: TextDirection.ltr),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Color(0xFFE8F5E9),
                    child: Text('RTL: مرحبا', textDirection: TextDirection.rtl),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
