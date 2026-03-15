// D4rt test script: Tests LicenseEntry, LicenseEntryWithLineBreaks, LicenseRegistry, LicenseParagraph from foundation
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Foundation license test executing');

  // ========== LICENSEENTRYWITHLINEBREAKS ==========
  print('--- LicenseEntryWithLineBreaks Tests ---');

  final license1 = LicenseEntryWithLineBreaks(
    ['my_package'],
    'MIT License\n\nCopyright (c) 2024 Test Author\n\nPermission is hereby granted...',
  );
  print('LicenseEntryWithLineBreaks created');
  print('  runtimeType: ${license1.runtimeType}');
  print('  packages: ${license1.packages.toList()}');

  // Access paragraphs
  final paragraphs1 = license1.paragraphs.toList();
  print('  paragraphs count: ${paragraphs1.length}');
  for (int i = 0; i < paragraphs1.length; i++) {
    print(
      '  paragraph[$i]: indent=${paragraphs1[i].indent}, text="${paragraphs1[i].text}"',
    );
  }

  // Multiple packages
  final license2 = LicenseEntryWithLineBreaks(
    ['package_a', 'package_b', 'package_c'],
    'BSD 3-Clause License\n\nRedistribution and use in source and binary forms...',
  );
  print('Multi-package license:');
  print('  packages: ${license2.packages.toList()}');
  final paragraphs2 = license2.paragraphs.toList();
  print('  paragraphs count: ${paragraphs2.length}');

  // License with indentation
  final license3 = LicenseEntryWithLineBreaks(
    ['indented_package'],
    'License Header\n\n  1. First clause\n  2. Second clause\n  3. Third clause\n\nEnd of license.',
  );
  print('Indented license:');
  print('  packages: ${license3.packages.toList()}');
  final paragraphs3 = license3.paragraphs.toList();
  print('  paragraphs count: ${paragraphs3.length}');
  for (int i = 0; i < paragraphs3.length; i++) {
    print(
      '  paragraph[$i]: indent=${paragraphs3[i].indent}, text="${paragraphs3[i].text}"',
    );
  }

  // Empty license text
  final emptyLicense = LicenseEntryWithLineBreaks(['empty_pkg'], '');
  print('Empty license:');
  print('  packages: ${emptyLicense.packages.toList()}');
  final emptyParagraphs = emptyLicense.paragraphs.toList();
  print('  paragraphs count: ${emptyParagraphs.length}');

  // ========== LICENSEPARAGRAPH ==========
  print('--- LicenseParagraph Tests ---');

  // LicenseParagraph is returned by LicenseEntry.paragraphs
  // It has .text and .indent properties
  // LicenseParagraph.centeredIndent is a constant
  print('LicenseParagraph.centeredIndent: ${LicenseParagraph.centeredIndent}');

  // Access paragraphs from our first license
  if (paragraphs1.isNotEmpty) {
    final firstParagraph = paragraphs1[0];
    print('First paragraph:');
    print('  text: "${firstParagraph.text}"');
    print('  indent: ${firstParagraph.indent}');
    print('  runtimeType: ${firstParagraph.runtimeType}');
  }

  // ========== LICENSEREGISTRY ==========
  print('--- LicenseRegistry Tests ---');

  // LicenseRegistry is a static class for registering licenses
  print('LicenseRegistry.licenses is a Stream<LicenseEntry>');
  print('LicenseRegistry.addLicense() registers a license');

  // Register a test license
  LicenseRegistry.addLicense(() async* {
    yield LicenseEntryWithLineBreaks([
      'd4rt_test_package',
    ], 'Test license registered via LicenseRegistry');
  });
  print('Test license registered with LicenseRegistry.addLicense()');

  // ========== LICENSEENTRY ==========
  print('--- LicenseEntry Tests ---');

  // LicenseEntry is abstract, tested via LicenseEntryWithLineBreaks
  print('LicenseEntry is abstract - tested via LicenseEntryWithLineBreaks');
  print('LicenseEntry properties:');
  print('  - packages: Iterable<String>');
  print('  - paragraphs: Iterable<LicenseParagraph>');

  // ========== RETURN WIDGET ==========
  print('Foundation license test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Foundation License Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text(
            'Classes Tested:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• LicenseEntryWithLineBreaks - license with text'),
          Text('• LicenseParagraph - license text paragraph'),
          Text('• LicenseRegistry - static license registration'),
          Text('• LicenseEntry - abstract base class'),
          SizedBox(height: 16.0),

          Text('License Info:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFF3E5F5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Package: ${license1.packages.first}'),
                Text('Paragraphs: ${paragraphs1.length}'),
                Text('CenteredIndent: ${LicenseParagraph.centeredIndent}'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
