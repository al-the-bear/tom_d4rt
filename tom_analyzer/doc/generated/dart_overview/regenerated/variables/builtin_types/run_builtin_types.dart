/// Demonstrates Dart built-in types
///
/// Features covered:
/// - int, double, num
/// - String (with interpolation)
/// - bool
/// - Symbol
/// - Runes (Unicode)
library;

void main() {
  print('=== Built-in Types ===\n');

  // Numbers: int
  print('--- int ---');
  int decimal = 42;
  int hex = 0x2A; // 42 in hex
  int binary = 0x2A; // 42 - binary: 101010
  int withSeparator = 1_000_000; // Underscores for readability
  print('decimal: $decimal');
  print('hex (0x2A): $hex');
  print('binary (42 = 0b101010): $binary');
  print('with separator: $withSeparator');

  // Numbers: double
  print('\n--- double ---');
  double simple = 3.14;
  double scientific = 1.42e5; // 142000.0
  double negative = -273.15;
  print('simple: $simple');
  print('scientific (1.42e5): $scientific');
  print('negative: $negative');
  print('double.infinity: ${double.infinity}');
  print('double.nan: ${double.nan}');

  // Numbers: num (supertype)
  print('\n--- num (supertype of int and double) ---');
  num value = 42;
  print('num as int: $value (${value.runtimeType})');
  value = 3.14;
  print('num as double: $value (${value.runtimeType})');

  // String
  print('\n--- String ---');
  String single = 'Single quotes';
  String double_ = "Double quotes";
  String multiline = '''
This is a
multiline string
  with preserved indentation''';
  print('single: $single');
  print('double: $double_');
  print('multiline:\n$multiline');

  // String interpolation
  print('\n--- String Interpolation ---');
  var name = 'Alice';
  var age = 30;
  print('Simple: Hello, $name!');
  print('Expression: In 5 years, $name will be ${age + 5}');
  print('Method call: Name uppercase: ${name.toUpperCase()}');

  // String operations
  print('\n--- String Operations ---');
  var str = 'Hello, World!';
  print('Length: ${str.length}');
  print('Contains "World": ${str.contains('World')}');
  print('Substring(0,5): ${str.substring(0, 5)}');
  print('Split by comma: ${str.split(', ')}');
  print('Replace: ${str.replaceAll('World', 'Dart')}');

  // Raw strings
  print('\n--- Raw Strings ---');
  var raw = r'Raw string: \n is not a newline, $name is literal';
  print(raw);

  // Bool
  print('\n--- bool ---');
  bool isTrue = getTrue();
  bool isFalse = getFalse();
  print('isTrue: $isTrue');
  print('isFalse: $isFalse');
  print('Logical AND (true && false): ${isTrue && isFalse}');
  print('Logical OR (true || false): ${isTrue || isFalse}');
  print('Logical NOT (!true): ${!isTrue}');

  // Symbol
  print('\n--- Symbol ---');
  Symbol sym1 = #mySymbol;
  Symbol sym2 = Symbol('mySymbol');
  print('sym1: $sym1');
  print('sym2: $sym2');
  print('sym1 == sym2: ${sym1 == sym2}'); // true - same identifier

  // Runes (Unicode code points)
  print('\n--- Runes (Unicode) ---');
  var emoji = '\u{1F600}'; // Grinning face emoji
  var heart = '\u2764'; // Heart (BMP character)
  print('Emoji (\\u{1F600}): $emoji');
  print('Heart (\\u2764): $heart');

  var text = 'Dart \u{1F3AF}'; // Dart with dart emoji
  print('Text with emoji: $text');
  print('Runes: ${text.runes.toList()}');

  // Iterating over characters (grapheme clusters)
  var greeting = 'Hi 👋🏽'; // Emoji with skin tone modifier
  print('\nGreeting: $greeting');
  print('Length (code units): ${greeting.length}');
  print('Runes count: ${greeting.runes.length}');

  print('\n=== End of Built-in Types Demo ===');
}

// Helper functions to prevent compile-time optimization
bool getTrue() => true;
bool getFalse() => false;
