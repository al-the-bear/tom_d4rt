/// DCli Color Output Example
///
/// Demonstrates red, green, blue, yellow, cyan, magenta, etc. color functions.
///
/// Run with: dart run tomexample/color_output.dart
library;

import 'package:dcli/dcli.dart';

void main() {
  print('=== DCli Color Output Examples ===\n');

  // 1. Basic colors
  print('--- 1. Basic Colors ---');
  print(red('This is red text'));
  print(green('This is green text'));
  print(blue('This is blue text'));
  print(yellow('This is yellow text'));
  print(cyan('This is cyan text'));
  print(magenta('This is magenta text'));
  print(orange('This is orange text'));
  print(white('This is white text'));
  print(grey('This is grey text'));

  // 2. Background colors
  print('\n--- 2. Background Colors ---');
  print(white('White on red', background: AnsiColor.red));
  print(black('Black on green', background: AnsiColor.green));
  print(black('Black on yellow', background: AnsiColor.yellow));
  print(white('White on blue', background: AnsiColor.blue));
  print(black('Black on cyan', background: AnsiColor.cyan));
  print(white('White on magenta', background: AnsiColor.magenta));

  // 3. Bold text
  print('\n--- 3. Bold Text ---');
  print(red('Bold red', bold: true));
  print(green('Bold green', bold: true));
  print(blue('Bold blue', bold: true));

  // 4. Status messages pattern
  print('\n--- 4. Status Messages ---');
  print('${green("✓")} Task completed successfully');
  print('${yellow("⚠")} Warning: disk space low');
  print('${red("✗")} Error: file not found');
  print('${blue("ℹ")} Info: processing started');

  // 5. Formatted output
  print('\n--- 5. Formatted Output ---');
  print('Building ${cyan("my_app")}...');
  print('  ${grey("├──")} Compiling ${yellow("lib/main.dart")}');
  print('  ${grey("├──")} Compiling ${yellow("lib/utils.dart")}');
  print('  ${grey("└──")} ${green("Done!")}');

  // 6. Progress-style output
  print('\n--- 6. Progress-Style Output ---');
  final steps = ['Initialize', 'Download', 'Install', 'Configure'];
  for (var i = 0; i < steps.length; i++) {
    final step = steps[i];
    final status = i < steps.length - 1 ? green('✓') : blue('→');
    print('  $status $step');
  }

  // 7. Error formatting
  print('\n--- 7. Error Formatting ---');
  void printError(String message) {
    print(red('Error: ', bold: true) + message);
  }

  void printWarning(String message) {
    print(yellow('Warning: ', bold: true) + message);
  }

  void printSuccess(String message) {
    print(green('Success: ', bold: true) + message);
  }

  printError('Connection timeout');
  printWarning('Deprecated API usage');
  printSuccess('Build completed');

  // 8. Table-like output
  print('\n--- 8. Table-Like Output ---');
  final header =
      '${grey("│")} ${cyan("NAME".padRight(15))} ${grey("│")} ${cyan("STATUS".padRight(10))} ${grey("│")}';
  final separator = grey('├${"─" * 17}┼${"─" * 12}┤');

  print(grey('┌${"─" * 17}┬${"─" * 12}┐'));
  print(header);
  print(separator);
  print(
      '${grey("│")} ${"server".padRight(15)} ${grey("│")} ${green("running".padRight(10))} ${grey("│")}');
  print(
      '${grey("│")} ${"database".padRight(15)} ${grey("│")} ${green("healthy".padRight(10))} ${grey("│")}');
  print(
      '${grey("│")} ${"cache".padRight(15)} ${grey("│")} ${yellow("warning".padRight(10))} ${grey("│")}');
  print(
      '${grey("│")} ${"worker".padRight(15)} ${grey("│")} ${red("stopped".padRight(10))} ${grey("│")}');
  print(grey('└${"─" * 17}┴${"─" * 12}┘'));

  // 9. Diff-style output
  print('\n--- 9. Diff-Style Output ---');
  print(cyan('@@ -1,3 +1,3 @@'));
  print(red('- old line content'));
  print(green('+ new line content'));
  print('  unchanged line');

  // 10. Log levels
  print('\n--- 10. Log Levels ---');
  void log(String level, String message) {
    final timestamp =
        grey('[${DateTime.now().toIso8601String().substring(11, 19)}]');
    final levelStr = switch (level) {
      'DEBUG' => grey('DEBUG'),
      'INFO' => blue('INFO '),
      'WARN' => yellow('WARN '),
      'ERROR' => red('ERROR'),
      _ => level.padRight(5),
    };
    print('$timestamp $levelStr $message');
  }

  log('DEBUG', 'Entering function main()');
  log('INFO', 'Application started');
  log('WARN', 'Configuration file not found, using defaults');
  log('ERROR', 'Failed to connect to database');

  // 11. Highlighting matches
  print('\n--- 11. Highlighting Matches ---');
  String highlight(String text, String pattern) {
    return text.replaceAll(pattern, yellow(pattern, bold: true));
  }

  final logLine = 'Error: Connection refused at host localhost:8080';
  print(highlight(logLine, 'Error'));
  print(highlight(logLine, 'localhost'));

  // 12. ASCII art banner
  print('\n--- 12. ASCII Banner ---');
  print(cyan(r'''
  ____   ____ _ _ 
 |  _ \ / ___| (_)
 | | | | |   | | |
 | |_| | |___| | |
 |____/ \____|_|_|
'''));

  // 13. Conditional coloring
  print('\n--- 13. Conditional Coloring ---');
  String statusColor(String status) {
    return switch (status.toLowerCase()) {
      'success' || 'ok' || 'pass' => green(status),
      'warning' || 'warn' || 'skip' => yellow(status),
      'error' || 'fail' || 'failed' => red(status),
      _ => status,
    };
  }

  final results = ['SUCCESS', 'FAIL', 'WARNING', 'OK', 'ERROR'];
  for (final result in results) {
    print('  Test result: ${statusColor(result)}');
  }

  // 14. Emoji + colors
  print('\n--- 14. Emoji + Colors ---');
  print('${green("🎉")} ${green("All tests passed!", bold: true)}');
  print('${yellow("⚠️")}  ${yellow("3 warnings found")}');
  print('${red("❌")} ${red("Build failed", bold: true)}');
  print('${blue("📦")} ${blue("Installing dependencies...")}');
  print('${cyan("🔍")} ${cyan("Analyzing code...")}');

  // 15. Terminal width considerations
  print('\n--- 15. Terminal Info ---');
  try {
    final width = Terminal().columns;
    final height = Terminal().rows;
    print('Terminal size: ${width}x$height');
    print(grey('─' * width));
  } catch (e) {
    print(yellow('Unable to detect terminal size'));
  }

  print('\n=== Color Output Example Complete ===');
}
