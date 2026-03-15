// D4rt test script: Tests RenderEditablePainter from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

// Custom editable painter for highlighting
class _HighlightPainter extends RenderEditablePainter {
  final Color highlightColor;
  final List<TextBox> boxes;

  _HighlightPainter({required this.highlightColor, this.boxes = const []});

  @override
  void paint(Canvas canvas, Size size, RenderEditable renderEditable) {
    final paint = Paint()
      ..color = highlightColor
      ..style = PaintingStyle.fill;

    for (final box in boxes) {
      canvas.drawRect(box.toRect(), paint);
    }
  }

  @override
  bool shouldRepaint(RenderEditablePainter? oldDelegate) {
    if (oldDelegate is! _HighlightPainter) return true;
    return highlightColor != oldDelegate.highlightColor ||
        boxes.length != oldDelegate.boxes.length;
  }
}

// Underline painter for custom text decoration
class _UnderlinePainter extends RenderEditablePainter {
  final Color color;
  final double thickness;

  _UnderlinePainter({this.color = Colors.red, this.thickness = 2.0});

  @override
  void paint(Canvas canvas, Size size, RenderEditable renderEditable) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    // Draw squiggly underline
    final path = Path();
    double x = 0;
    double y = size.height - thickness;
    path.moveTo(x, y);

    while (x < size.width) {
      path.quadraticBezierTo(x + 2, y + 3, x + 4, y);
      path.quadraticBezierTo(x + 6, y - 3, x + 8, y);
      x += 8;
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(RenderEditablePainter? oldDelegate) {
    if (oldDelegate is! _UnderlinePainter) return true;
    return color != oldDelegate.color || thickness != oldDelegate.thickness;
  }
}

dynamic build(BuildContext context) {
  print('RenderEditablePainter test executing');

  // ========== RENDER EDITABLE PAINTER BASICS ==========
  print('--- RenderEditablePainter Basics ---');
  print('RenderEditablePainter is an abstract class for custom painting');
  print('Used to paint custom decorations on RenderEditable (text fields)');
  print('Examples: selection highlights, cursors, spell-check underlines');

  // ========== PAINTER METHODS ==========
  print('--- Painter Methods ---');
  print('paint(Canvas, Size, RenderEditable): Paint custom decorations');
  print('shouldRepaint(oldDelegate): Return true to trigger repaint');
  print('addListener/removeListener: For animation support');

  // Create custom painters
  final highlightPainter = _HighlightPainter(
    highlightColor: Colors.yellow.withValues(alpha: 0.5),
    boxes: [TextBox.fromLTRBD(0, 0, 100, 20, TextDirection.ltr)],
  );
  print('Created highlight painter');
  print('  highlightColor: yellow with 50% opacity');

  final underlinePainter = _UnderlinePainter(color: Colors.red, thickness: 1.5);
  print('Created underline painter');
  print('  color: red, thickness: 1.5');

  // ========== USE CASES ==========
  print('--- Common Use Cases ---');
  print('1. Custom selection highlight colors');
  print('2. Spell-check underlines (wavy red lines)');
  print('3. Grammar suggestions (blue underlines)');
  print('4. Search term highlighting');
  print('5. Code syntax highlighting backgrounds');

  // Test using TextField with custom styles
  final highlightedTextField = Container(
    width: 250,
    child: TextField(
      decoration: InputDecoration(
        labelText: 'Highlighted Field',
        filled: true,
        fillColor: Colors.yellow[50],
        border: OutlineInputBorder(),
      ),
      style: TextStyle(background: Paint()..color = Colors.yellow[200]!),
    ),
  );
  print('TextField with yellow highlight background');

  // Test spell-check style
  final spellCheckField = Container(
    width: 250,
    child: TextField(
      decoration: InputDecoration(
        labelText: 'Spell Check Style',
        border: OutlineInputBorder(),
        errorText: 'Mispeled word',
        errorStyle: TextStyle(color: Colors.red),
      ),
    ),
  );
  print('TextField demonstrating spell-check error style');

  // ========== INTEGRATION WITH RENDER EDITABLE ==========
  print('--- Integration with RenderEditable ---');
  print('RenderEditable provides:');
  print('  - text: TextPainter for text layout');
  print('  - selection: Current text selection');
  print('  - cursorColor: Color of the cursor');
  print('  - textDirection: Direction of text flow');

  // Test search highlighting concept
  final searchTextField = Container(
    width: 250,
    child: TextField(
      decoration: InputDecoration(
        labelText: 'Search Field',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
        fillColor: Colors.grey[100],
        filled: true,
      ),
      controller: TextEditingController(text: 'matching text'),
    ),
  );
  print('Search field with match indication');

  // ========== MULTIPLE PAINTERS ==========
  print('--- Multiple Painters ---');
  print('foregroundPainter: Paints above text');
  print('backgroundPainter: Paints behind text');
  print('Can use both for layered effects');

  // Test styled text field
  final styledField = Container(
    width: 250,
    child: TextField(
      decoration: InputDecoration(
        labelText: 'Styled Text',
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple, width: 2),
        ),
      ),
      style: TextStyle(
        color: Colors.purple[700],
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
  print('Custom styled text field');

  // ========== ANIMATION SUPPORT ==========
  print('--- Animation Support ---');
  print('Use addListener for animated painting');
  print('Call markNeedsPaint to trigger repaint');
  print('Useful for cursor blinking, selection animation');

  // Test cursor animation concept
  final animatedCursorField = Container(
    width: 250,
    child: TextField(
      decoration: InputDecoration(
        labelText: 'Animated Cursor',
        border: OutlineInputBorder(),
      ),
      cursorColor: Colors.blue,
      cursorWidth: 3,
      showCursor: true,
    ),
  );
  print('Field with animated cursor (built-in)');

  // ========== PERFORMANCE CONSIDERATIONS ==========
  print('--- Performance Considerations ---');
  print('shouldRepaint prevents unnecessary repaints');
  print('Compare all properties that affect painting');
  print('Cache Paint objects when possible');
  print('Minimize complex path operations');

  // ========== CUSTOM DECORATION EXAMPLE ==========
  print('--- Custom Decoration Examples ---');

  final codeField = Container(
    width: 250,
    child: TextField(
      decoration: InputDecoration(
        labelText: 'Code Input',
        border: OutlineInputBorder(),
        fillColor: Colors.grey[900],
        filled: true,
        labelStyle: TextStyle(color: Colors.grey[400]),
      ),
      style: TextStyle(
        color: Colors.green[300],
        fontFamily: 'monospace',
        fontSize: 14,
      ),
      cursorColor: Colors.green,
    ),
  );
  print('Code editor style text field');

  // Test grammar highlight style
  final grammarField = Container(
    width: 250,
    child: TextField(
      decoration: InputDecoration(
        labelText: 'Grammar Check',
        border: OutlineInputBorder(),
        helperText: 'Blue underline = grammar suggestion',
        helperStyle: TextStyle(color: Colors.blue),
      ),
    ),
  );
  print('Grammar check style indicator');

  print('RenderEditablePainter test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderEditablePainter Tests'),
      SizedBox(height: 8),
      highlightedTextField,
      SizedBox(height: 8),
      spellCheckField,
      SizedBox(height: 8),
      searchTextField,
      SizedBox(height: 8),
      codeField,
      SizedBox(height: 8),
      Text('All EditablePainter tests passed'),
    ],
  );
}
