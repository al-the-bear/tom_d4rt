// D4rt test script: Tests LayoutBuilder, OrientationBuilder, CustomMultiChildLayout,
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// MultiChildLayoutDelegate, CustomSingleChildLayout, SingleChildLayoutDelegate,
// SizedOverflowBox, OverflowBox
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Layout builder advanced test executing');

  // ========== LayoutBuilder ==========
  print('--- LayoutBuilder Tests ---');
  final layoutBuilder = LayoutBuilder(
    builder: (context, constraints) {
      print('  LayoutBuilder constraints: $constraints');
      print('    maxWidth: ${constraints.maxWidth}');
      print('    maxHeight: ${constraints.maxHeight}');
      print('    minWidth: ${constraints.minWidth}');
      print('    minHeight: ${constraints.minHeight}');
      print('    hasBoundedWidth: ${constraints.hasBoundedWidth}');
      print('    hasBoundedHeight: ${constraints.hasBoundedHeight}');
      print('    hasInfiniteWidth: ${constraints.hasInfiniteWidth}');
      print('    hasInfiniteHeight: ${constraints.hasInfiniteHeight}');

      if (constraints.maxWidth > 600) {
        return Row(
          children: [
            Expanded(child: Container(color: Colors.blue, height: 100)),
            Expanded(child: Container(color: Colors.red, height: 100)),
          ],
        );
      }
      return Column(
        children: [
          Container(color: Colors.blue, height: 50),
          Container(color: Colors.red, height: 50),
        ],
      );
    },
  );
  print('LayoutBuilder created');

  // ========== OrientationBuilder ==========
  print('--- OrientationBuilder Tests ---');
  final orientationBuilder = OrientationBuilder(
    builder: (context, orientation) {
      print('  Orientation: $orientation');
      if (orientation == Orientation.landscape) {
        return Row(
          children: [
            Expanded(child: Container(color: Colors.green, height: 80)),
            Expanded(child: Container(color: Colors.yellow, height: 80)),
          ],
        );
      }
      return Column(
        children: [
          Container(color: Colors.green, height: 40, width: double.infinity),
          Container(color: Colors.yellow, height: 40, width: double.infinity),
        ],
      );
    },
  );
  print('OrientationBuilder created');

  // ========== CustomMultiChildLayout ==========
  print('--- CustomMultiChildLayout Tests ---');
  final multiChildLayout = CustomMultiChildLayout(
    delegate: TestMultiChildLayoutDelegate(),
    children: [
      LayoutId(
        id: 'header',
        child: Container(color: Colors.blue, child: Text('Header')),
      ),
      LayoutId(
        id: 'body',
        child: Container(color: Colors.green, child: Text('Body')),
      ),
      LayoutId(
        id: 'footer',
        child: Container(color: Colors.red, child: Text('Footer')),
      ),
    ],
  );
  print('CustomMultiChildLayout created');

  // ========== CustomSingleChildLayout ==========
  print('--- CustomSingleChildLayout Tests ---');
  final singleChildLayout = CustomSingleChildLayout(
    delegate: TestSingleChildLayoutDelegate(),
    child: Container(
      width: 100,
      height: 100,
      color: Colors.purple,
      child: Center(child: Text('Single')),
    ),
  );
  print('CustomSingleChildLayout created');

  // ========== OverflowBox ==========
  print('--- OverflowBox Tests ---');
  final overflowBox = OverflowBox(
    alignment: Alignment.center,
    minWidth: 0,
    maxWidth: 300,
    minHeight: 0,
    maxHeight: 300,
    child: Container(
      width: 200,
      height: 200,
      color: Colors.teal,
      child: Center(child: Text('Overflow')),
    ),
  );
  print('OverflowBox created');

  // ========== SizedOverflowBox ==========
  print('--- SizedOverflowBox Tests ---');
  final sizedOverflowBox = SizedOverflowBox(
    size: Size(100, 100),
    alignment: Alignment.topLeft,
    child: Container(
      width: 150,
      height: 150,
      color: Colors.amber,
      child: Center(child: Text('SizedOverflow')),
    ),
  );
  print('SizedOverflowBox created');

  // ========== BoxConstraints advanced ==========
  print('--- BoxConstraints Tests ---');
  final c1 = BoxConstraints(
    minWidth: 0,
    maxWidth: 300,
    minHeight: 0,
    maxHeight: 500,
  );
  print('BoxConstraints: $c1');
  final c2 = BoxConstraints.tight(Size(100, 200));
  print('BoxConstraints.tight: $c2');
  final c3 = BoxConstraints.loose(Size(300, 400));
  print('BoxConstraints.loose: $c3');
  final c4 = BoxConstraints.expand(width: 200, height: 300);
  print('BoxConstraints.expand: $c4');
  final c5 = BoxConstraints.tightFor(width: 100);
  print('BoxConstraints.tightFor: $c5');
  print('  c1.isTight: ${c1.isTight}');
  print('  c1.isNormalized: ${c1.isNormalized}');
  print('  c1.biggest: ${c1.biggest}');
  print('  c1.smallest: ${c1.smallest}');
  final c6 = c1.enforce(BoxConstraints(maxWidth: 200));
  print('  enforce: $c6');
  final c7 = c1.deflate(EdgeInsets.all(10));
  print('  deflate: $c7');

  print('All layout builder advanced tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 200, child: layoutBuilder),
            SizedBox(height: 200, child: orientationBuilder),
            SizedBox(height: 200, child: multiChildLayout),
            singleChildLayout,
            overflowBox,
            sizedOverflowBox,
          ],
        ),
      ),
    ),
  );
}

class TestMultiChildLayoutDelegate extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    final headerSize = layoutChild(
      'header',
      BoxConstraints.tightFor(width: size.width, height: 50),
    );
    positionChild('header', Offset.zero);

    final footerSize = layoutChild(
      'footer',
      BoxConstraints.tightFor(width: size.width, height: 50),
    );
    positionChild('footer', Offset(0, size.height - footerSize.height));

    layoutChild(
      'body',
      BoxConstraints.tightFor(
        width: size.width,
        height: size.height - headerSize.height - footerSize.height,
      ),
    );
    positionChild('body', Offset(0, headerSize.height));
  }

  @override
  bool shouldRelayout(TestMultiChildLayoutDelegate oldDelegate) => false;
}

class TestSingleChildLayoutDelegate extends SingleChildLayoutDelegate {
  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(
      (size.width - childSize.width) / 2,
      (size.height - childSize.height) / 2,
    );
  }

  @override
  bool shouldRelayout(TestSingleChildLayoutDelegate oldDelegate) => false;
}
