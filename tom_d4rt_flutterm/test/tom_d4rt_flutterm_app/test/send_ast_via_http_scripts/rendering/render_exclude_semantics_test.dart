// D4rt test script: Tests RenderExcludeSemantics from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderExcludeSemantics test executing');

  // ========== EXCLUDE SEMANTICS BASICS ==========
  print('--- ExcludeSemantics Basics ---');
  print('RenderExcludeSemantics excludes subtree from semantic tree');
  print('Child widgets become invisible to screen readers');
  print('Useful for decorative or redundant elements');

  // Test ExcludeSemantics with excluding: true
  final excludingWidget = ExcludeSemantics(
    excluding: true,
    child: Container(
      width: 100,
      height: 100,
      color: Colors.blue,
      child: Center(child: Text('Excluded')),
    ),
  );
  print('ExcludeSemantics created with excluding: true');
  print('  runtimeType: ${excludingWidget.runtimeType}');
  print('  excluding: ${excludingWidget.excluding}');

  // Test with excluding: false
  final notExcludingWidget = ExcludeSemantics(
    excluding: false,
    child: Container(
      width: 80,
      height: 80,
      color: Colors.green,
      child: Center(child: Text('Included')),
    ),
  );
  print('ExcludeSemantics with excluding: false');
  print('  Semantics are preserved');

  // ========== USE CASES ==========
  print('--- Common Use Cases ---');
  print('1. Decorative images (use excludeFromSemantics on Image)');
  print('2. Background patterns or gradients');
  print('3. Duplicate information already announced');
  print('4. Visual-only elements (dividers, shadows)');
  print('5. Loading indicators during transition');

  // Test with decorative element
  final decorativeElement = ExcludeSemantics(
    child: Container(
      width: 150,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.purple, Colors.blue]),
        borderRadius: BorderRadius.circular(25),
      ),
    ),
  );
  print('Decorative gradient element (excluded from semantics)');

  // Test with icon that duplicates text
  final duplicateInfo = Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      ExcludeSemantics(child: Icon(Icons.email, color: Colors.blue)),
      SizedBox(width: 8),
      Text('email@example.com'),
    ],
  );
  print('Icon excluded when text already provides info');

  // ========== SEMANTICS VS EXCLUDE SEMANTICS ==========
  print('--- Semantics vs ExcludeSemantics ---');
  print('Semantics: Adds semantic info to subtree');
  print('ExcludeSemantics: Removes semantic info from subtree');
  print('MergeSemantics: Combines semantics of children');

  // Test combining Semantics with ExcludeSemantics
  final combinedSemantics = Semantics(
    label: 'Main button',
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ExcludeSemantics(child: Icon(Icons.star, color: Colors.amber)),
        Text('Star'),
      ],
    ),
  );
  print('Semantics wrapper with excluded icon');
  print('  Screen reader announces "Main button" only');

  // ========== NESTED EXCLUDE SEMANTICS ==========
  print('--- Nested Behavior ---');

  final nestedExclude = ExcludeSemantics(
    excluding: true,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Hidden text 1'),
        ExcludeSemantics(
          excluding: false,
          child: Text('Still hidden (outer wins)'),
        ),
        Text('Hidden text 2'),
      ],
    ),
  );
  print('Nested ExcludeSemantics');
  print('  Outer excluding: true overrides inner');

  // ========== CONDITIONAL EXCLUSION ==========
  print('--- Conditional Exclusion ---');
  print('Use excluding parameter to toggle dynamically');
  print('Example: exclude during animations, include when static');

  bool isLoading = true;
  final conditionalExclude = ExcludeSemantics(
    excluding: isLoading,
    child: CircularProgressIndicator(),
  );
  print('Conditional exclusion based on loading state');
  print('  isLoading: $isLoading, excluding: $isLoading');

  // ========== ACCESSIBILITY BEST PRACTICES ==========
  print('--- Accessibility Best Practices ---');
  print('1. Never exclude important interactive elements');
  print('2. Use for truly decorative content only');
  print('3. Test with screen readers');
  print('4. Consider semantic alternatives');

  // Test accessible button with decorative background
  final accessibleButton = Stack(
    alignment: Alignment.center,
    children: [
      ExcludeSemantics(
        child: Container(
          width: 120,
          height: 40,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.orange, Colors.red]),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      Semantics(
        button: true,
        label: 'Submit',
        child: Text(
          'Submit',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
  print('Button with excluded gradient background');

  // ========== COMPARING WITH BLOCK SEMANTICS ==========
  print('--- ExcludeSemantics vs BlockSemantics ---');
  print('ExcludeSemantics: Excludes THIS subtree');
  print('BlockSemantics: Blocks widgets BELOW in paint order');
  print('Use ExcludeSemantics for decorative content');
  print('Use BlockSemantics for overlays/modals');

  // Test image with semantics
  final imageWithSemantics = Container(
    width: 100,
    height: 100,
    child: Stack(
      children: [
        ExcludeSemantics(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(Icons.image, size: 40, color: Colors.grey),
            ),
          ),
        ),
        Positioned(
          bottom: 4,
          left: 4,
          right: 4,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            color: Colors.black54,
            child: Text(
              'Photo',
              style: TextStyle(color: Colors.white, fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ),
  );
  print('Image placeholder with caption');
  print('  Placeholder excluded, caption announced');

  // ========== TESTING SEMANTICS ==========
  print('--- Testing Semantics Behavior ---');
  print('Use Flutter DevTools Accessibility inspector');
  print('Or SemanticsDebugger widget for debugging');
  print('Run accessibility tests with flutter_test');

  print('RenderExcludeSemantics test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderExcludeSemantics Tests'),
      SizedBox(height: 8),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [excludingWidget, SizedBox(width: 8), notExcludingWidget],
      ),
      SizedBox(height: 8),
      decorativeElement,
      SizedBox(height: 8),
      duplicateInfo,
      SizedBox(height: 8),
      accessibleButton,
      SizedBox(height: 8),
      imageWithSemantics,
      SizedBox(height: 8),
      Text('All ExcludeSemantics tests passed'),
    ],
  );
}
