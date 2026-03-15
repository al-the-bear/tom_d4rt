// D4rt test script: Tests DiagnosticsNode, DiagnosticPropertiesBuilder, StringProperty, IntProperty from foundation
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Foundation diagnostics test executing');

  // ========== DIAGNOSTICPROPERTIESBUILDER ==========
  print('--- DiagnosticPropertiesBuilder Tests ---');

  final builder = DiagnosticPropertiesBuilder();
  print('DiagnosticPropertiesBuilder created');
  print('  runtimeType: ${builder.runtimeType}');

  // Add StringProperty
  builder.add(StringProperty('name', 'TestWidget'));
  print('Added StringProperty("name", "TestWidget")');

  // Add IntProperty
  builder.add(IntProperty('count', 42));
  print('Added IntProperty("count", 42)');

  // Add DoubleProperty
  builder.add(DoubleProperty('opacity', 0.75));
  print('Added DoubleProperty("opacity", 0.75)');

  // Add FlagProperty
  builder.add(FlagProperty('enabled', value: true, ifTrue: 'enabled'));
  print('Added FlagProperty("enabled", value: true)');

  // Add DiagnosticsProperty
  builder.add(DiagnosticsProperty<String>('label', 'Hello'));
  print('Added DiagnosticsProperty<String>("label", "Hello")');

  // Add EnumProperty
  builder.add(EnumProperty<TextDirection>('direction', TextDirection.ltr));
  print('Added EnumProperty<TextDirection>("direction", TextDirection.ltr)');

  // Print all properties
  print('Builder properties count: ${builder.properties.length}');
  for (final prop in builder.properties) {
    print('  ${prop.name}: ${prop.toStringDeep()}');
  }

  // ========== STRINGPROPERTY ==========
  print('--- StringProperty Tests ---');

  final stringProp = StringProperty('title', 'My Widget');
  print('StringProperty: $stringProp');
  print('  name: ${stringProp.name}');
  print('  value: ${stringProp.value}');
  print('  runtimeType: ${stringProp.runtimeType}');

  final quotedProp = StringProperty('text', 'Hello World', quoted: true);
  print('Quoted StringProperty: $quotedProp');

  final nullStringProp = StringProperty(
    'nullable',
    null,
    defaultValue: 'default',
  );
  print('Null StringProperty: $nullStringProp');

  // ========== INTPROPERTY ==========
  print('--- IntProperty Tests ---');

  final intProp = IntProperty('width', 200);
  print('IntProperty: $intProp');
  print('  name: ${intProp.name}');
  print('  value: ${intProp.value}');
  print('  runtimeType: ${intProp.runtimeType}');

  final nullIntProp = IntProperty('height', null);
  print('Null IntProperty: $nullIntProp');

  // ========== DOUBLEPROPERTY ==========
  print('--- DoubleProperty Tests ---');

  final doubleProp = DoubleProperty('opacity', 0.5);
  print('DoubleProperty: $doubleProp');
  print('  name: ${doubleProp.name}');
  print('  value: ${doubleProp.value}');

  final percentProp = DoubleProperty.lazy('percent', () => 0.85);
  print('Lazy DoubleProperty: $percentProp');

  // ========== FLAGPROPERTY ==========
  print('--- FlagProperty Tests ---');

  final trueFlag = FlagProperty(
    'visible',
    value: true,
    ifTrue: 'visible',
    ifFalse: 'hidden',
  );
  print('FlagProperty (true): $trueFlag');

  final falseFlag = FlagProperty(
    'visible',
    value: false,
    ifTrue: 'visible',
    ifFalse: 'hidden',
  );
  print('FlagProperty (false): $falseFlag');

  // ========== ENUMPROPERTY ==========
  print('--- EnumProperty Tests ---');

  final enumProp = EnumProperty<TextAlign>('align', TextAlign.center);
  print('EnumProperty: $enumProp');
  print('  name: ${enumProp.name}');
  print('  value: ${enumProp.value}');

  final nullEnumProp = EnumProperty<TextAlign>('align', null);
  print('Null EnumProperty: $nullEnumProp');

  // ========== DIAGNOSTICSPROPERTY ==========
  print('--- DiagnosticsProperty Tests ---');

  final diagProp = DiagnosticsProperty<Color>('color', Color(0xFFFF0000));
  print('DiagnosticsProperty<Color>: $diagProp');
  print('  name: ${diagProp.name}');
  print('  value: ${diagProp.value}');

  final diagPropWithDefault = DiagnosticsProperty<int>(
    'size',
    16,
    defaultValue: 14,
  );
  print('DiagnosticsProperty with default: $diagPropWithDefault');

  // ========== DIAGNOSTICSNODE ==========
  print('--- DiagnosticsNode Tests ---');

  // DiagnosticsNode is abstract; test via message node
  final messageNode = DiagnosticsNode.message('This is a diagnostic message');
  print('DiagnosticsNode.message: $messageNode');
  print('  runtimeType: ${messageNode.runtimeType}');
  print('  toString: ${messageNode.toString()}');

  // ========== RETURN WIDGET ==========
  print('Foundation diagnostics test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Foundation Diagnostics Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text(
            'Classes Tested:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• DiagnosticPropertiesBuilder - collects properties'),
          Text('• DiagnosticsNode - base diagnostic node'),
          Text('• StringProperty - string diagnostic'),
          Text('• IntProperty - integer diagnostic'),
          Text('• DoubleProperty - double diagnostic'),
          Text('• FlagProperty - boolean flag diagnostic'),
          Text('• EnumProperty - enum value diagnostic'),
          Text('• DiagnosticsProperty<T> - generic diagnostic'),
          SizedBox(height: 16.0),

          Text(
            'Property Summary:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFE3F2FD),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('StringProperty("title", "My Widget")'),
                Text('IntProperty("width", 200)'),
                Text('DoubleProperty("opacity", 0.5)'),
                Text('FlagProperty("visible", value: true)'),
                Text('EnumProperty("align", TextAlign.center)'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
