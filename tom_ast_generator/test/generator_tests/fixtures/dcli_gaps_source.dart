/// Test fixture for DCli bridge gap tests.
///
/// This file contains patterns that cause issues in DCli bridges:
/// 1. Extension methods with callback parameters
/// 2. Abstract classes with internal implementations
/// 3. Optional parameters with defaults

// =============================================================================
// Extension Callback Tests
// =============================================================================

/// Extension with callback methods - tests extension callback wrapping
extension StringAsProcess on String {
  /// Method with void Function(String) callback
  void forEach(void Function(String) lineAction) {
    for (final line in split('\n')) {
      lineAction(line);
    }
  }
  
  /// Method with callback that has return type
  List<String> toList({void Function(String)? progress}) {
    final lines = split('\n');
    if (progress != null) {
      for (final line in lines) {
        progress(line);
      }
    }
    return lines;
  }
  
  /// Getter - no callback issues
  String get firstLine => split('\n').first;
}

// =============================================================================
// Superclass Bridge Resolution Tests
// =============================================================================

/// Abstract base class that is exported
abstract class Progress {
  List<String> get lines;
  int? get exitCode;
  void forEach(void Function(String) action);
}

/// Factory function that returns subclass
Progress captureProgress() {
  return _ProgressImpl();
}

/// Internal implementation - NOT exported
class _ProgressImpl extends Progress {
  final List<String> _lines = [];
  
  @override
  List<String> get lines => _lines;
  
  @override
  int? get exitCode => 0;
  
  @override
  void forEach(void Function(String) action) {
    for (final line in _lines) {
      action(line);
    }
  }
}

// =============================================================================
// Optional Parameter Tests
// =============================================================================

/// Class for find results
class FindProgress {
  final List<String> _results = [];
  
  void forEach(void Function(String) action) {
    for (final item in _results) {
      action(item);
    }
  }
  
  List<String> toList() => _results;
}

/// Function with optional nullable parameter
FindProgress find(
  String pattern, {
  bool recursive = true,
  Progress? progress,  // Optional and nullable - should NOT be required
  String workingDirectory = '.',
}) {
  return FindProgress();
}

/// Function with optional callback parameter
void runCommand(
  String command, {
  void Function(String)? onLine,  // Optional callback - nullable
  void Function(int)? onExit,
}) {
  // Implementation
}

// =============================================================================
// Class Method Callback Tests
// =============================================================================

/// Class with method that takes callback parameter
class ProcessRunner {
  void execute(
    String command, {
    required void Function(String) stdout,
    void Function(String)? stderr,
  }) {
    stdout('output');
    stderr?.call('error');
  }
  
  void forEach(void Function(String line) callback) {
    callback('line1');
    callback('line2');
  }
}
