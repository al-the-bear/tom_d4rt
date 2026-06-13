/// Build-suite logger.
///
/// A thin wrapper over DCli's color bridges that gives the build tasks a
/// consistent, numbered output format. Lives in its own file to demonstrate
/// cross-file class usage in a multi-file D4rt CLI script.
library;

import 'package:dcli/dcli.dart';

/// Records counters and renders coloured, step-numbered build output.
class BuildLogger {
  int _step = 0;
  int warnings = 0;
  int errors = 0;

  /// Announce the start of a numbered build step.
  void step(String title) {
    _step++;
    print('');
    print(cyan('[$_step] $title', bold: true));
  }

  /// Indented success line.
  void ok(String message) => print('    ${green('✓')} $message');

  /// Indented neutral info line.
  void info(String message) => print('    ${grey('·', level: 0.6)} $message');

  /// Indented warning line; bumps the [warnings] counter.
  void warn(String message) {
    warnings++;
    print('    ${yellow('!')} ${yellow(message)}');
  }

  /// Indented error line; bumps the [errors] counter.
  void err(String message) {
    errors++;
    printerr('    ${red('✗')} ${red(message)}');
  }

  /// Final coloured summary. Returns the process exit code to use
  /// (`0` when there were no errors, `1` otherwise).
  int summary() {
    print('');
    final parts = <String>[
      '$_step steps',
      '$warnings warnings',
      '$errors errors',
    ];
    final line = 'Build finished: ${parts.join(', ')}';
    if (errors > 0) {
      printerr(red(line, bold: true));
      return 1;
    }
    print(green(line, bold: true));
    return 0;
  }
}
