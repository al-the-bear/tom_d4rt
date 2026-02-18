/// Demonstrates Dart comment syntax and documentation
///
/// Features covered:
/// - Single-line comments (//)
/// - Multi-line comments (/* */)
/// - Documentation comments (///)
/// - Doc comment features (references, markdown)
/// - Dartdoc directives

// This is a single-line comment

/* This is a 
   multi-line comment
   spanning several lines */

/// This is a documentation comment
/// It uses triple slashes
/// And can span multiple lines

/// This is also a documentation comment
/// using block comment style
/// Less common but valid
library;


void main() {
  print('=== Comments ===');
  print('');

  // Single-line comments
  print('--- Single-Line Comments ---');
  print('// comment text');
  print('Used for brief explanations');

  // Inline comments
  int x = 5; // inline comment after code
  print('Inline: int x = 5; // comment');
  print('Value of x: $x');

  // Multi-line comments
  print('');
  print('--- Multi-Line Comments ---');
  print('/* comment');
  print('   spanning');
  print('   multiple lines */');

  /* Multi-line comments
     can contain // single-line syntax
     without issues */
  print('Can contain // inside');

  // Nested comments NOT supported
  print('Nested /* comments */ NOT supported');

  // Documentation comments
  print('');
  print('--- Documentation Comments ---');
  print('/// Single line doc comment');
  print('');
  print('/// Multi-line');
  print('/// doc comment');
  print('');
  print('Used for:');
  print('  - Classes, methods, functions');
  print('  - Properties, parameters');
  print('  - Libraries, exports');

  // Dartdoc features
  print('');
  print('--- Dartdoc Features ---');

  print('');
  print('Markdown support:');
  print('  - **bold** and *italic*');
  print('  - `code` inline');
  print('  - [links](url)');
  print('  - Lists and headers');

  print('');
  print('Code blocks:');
  print('  /// ```dart');
  print('  /// var x = 42;');
  print('  /// ```');

  print('');
  print('References:');
  print('  [String]    - links to String class');
  print('  [List.add]  - links to method');
  print('  [new Foo]   - links to constructor');

  // Show documentation examples
  print('');
  print('--- Documentation Examples ---');
  print('See classes below for examples...');
  print('');

  // Create documented instances
  var calc = Calculator();
  print('Calculator.add(2, 3): ${calc.add(2, 3)}');
  print('Calculator.multiply(4, 5): ${calc.multiply(4, 5)}');

  var user = User('Alice');
  print('User name: ${user.name}');
  user.greet();

  var doc = DocumentedClass();
  doc.documentedMethod('test');

  // TODO comments
  print('');
  print('--- TODO Comments ---');
  print('// TODO: implement feature');
  print('// FIXME: fix this bug');
  print('// HACK: temporary workaround');
  print('// NOTE: important note');
  // TODO: this is an example TODO
  // FIXME: this is an example FIXME

  // Ignore comments
  print('');
  print('--- Ignore Directives ---');
  print('// ignore: lint_rule_name');
  print('// ignore_for_file: lint_rule_name');

  // ignore: unused_local_variable
  var unused = 42;
  print('Example: // ignore: unused_local_variable');

  // Deprecation
  print('');
  print('--- Deprecation ---');
  print('@deprecated annotation with doc comment');
  print('');

  var old = OldApi();
  // ignore: deprecated_member_use_from_same_package
  old.oldMethod();

  // Comment best practices
  print('');
  print('--- Best Practices ---');
  print('');
  print('DO:');
  print('  - Document public APIs');
  print('  - Start with verb (Returns, Creates, etc.)');
  print('  - Include examples for complex APIs');
  print('  - Document parameters and return values');
  print('');
  print('DON\'T:');
  print('  - State the obvious');
  print('  - Over-comment simple code');
  print('  - Leave outdated comments');

  print('');
  print('=== End of Comments Demo ===');
}

/// A calculator for basic math operations.
///
/// This class provides simple arithmetic operations.
///
/// Example:
/// ```dart
/// var calc = Calculator();
/// print(calc.add(2, 3)); // 5
/// ```
class Calculator {
  /// Adds two numbers together.
  ///
  /// Returns the sum of [a] and [b].
  int add(int a, int b) => a + b;

  /// Multiplies two numbers.
  ///
  /// Parameters:
  /// - [a]: The first number
  /// - [b]: The second number
  ///
  /// Returns the product of [a] and [b].
  int multiply(int a, int b) => a * b;
}

/// Represents a user in the system.
///
/// Users have a [name] and can [greet] others.
///
/// See also:
/// - [Calculator] for math operations
class User {
  /// The user's display name.
  ///
  /// This cannot be empty.
  final String name;

  /// Creates a new user with the given [name].
  ///
  /// Throws [ArgumentError] if [name] is empty.
  User(this.name) {
    if (name.isEmpty) {
      throw ArgumentError('Name cannot be empty');
    }
  }

  /// Prints a greeting message.
  ///
  /// Example:
  /// ```dart
  /// var user = User('Alice');
  /// user.greet(); // Hello, I'm Alice
  /// ```
  void greet() {
    print('Hello, I\'m $name');
  }
}

/// A class demonstrating documentation patterns.
///
/// ## Overview
///
/// This class shows various dartdoc features including:
/// - Markdown formatting
/// - Code examples
/// - Cross-references
///
/// ## Usage
///
/// ```dart
/// var doc = DocumentedClass();
/// doc.documentedMethod('value');
/// ```
///
/// ## See Also
///
/// * [Calculator] - For arithmetic operations
/// * [User] - For user management
class DocumentedClass {
  /// A documented method with full documentation.
  ///
  /// This method demonstrates:
  /// 1. Parameter documentation
  /// 2. Return value documentation
  /// 3. Exception documentation
  ///
  /// ### Parameters
  ///
  /// - [input]: The input string to process.
  ///   Must not be null or empty.
  ///
  /// ### Returns
  ///
  /// The processed string with prefix.
  ///
  /// ### Throws
  ///
  /// - [ArgumentError] if [input] is empty
  ///
  /// ### Example
  ///
  /// ```dart
  /// var result = doc.documentedMethod('test');
  /// print(result); // processed: test
  /// ```
  String documentedMethod(String input) {
    if (input.isEmpty) {
      throw ArgumentError('Input cannot be empty');
    }
    var result = 'processed: $input';
    print(result);
    return result;
  }
}

/// Old API that has been replaced.
///
/// @deprecated Use [Calculator] instead.
class OldApi {
  /// Old method.
  ///
  /// @deprecated Use [Calculator.add] instead.
  @Deprecated('Use Calculator.add() instead.')
  void oldMethod() {
    print('Old method called (deprecated)');
  }
}
