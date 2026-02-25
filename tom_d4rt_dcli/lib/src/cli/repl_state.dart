/// REPL state management for D4rt
///
/// This file contains the _ReplState class and related enums for managing
/// the interactive REPL state.
library;

import 'dart:async';
import 'dart:io';

import 'persistent_history.dart';

/// Exception thrown when an await operation is interrupted by CTRL-C
class InterruptedException implements Exception {
  @override
  String toString() => 'InterruptedException';
}

/// Multiline mode types
enum MultilineMode { 
  none, 
  script, 
  file, 
  executeNew, 
  define,
  /// VS Code eval mode - returns last expression value
  vscodeEval,
  /// VS Code script mode - complete file with main()
  vscodeScript,
}

/// Session state for the REPL
class ReplState {
  /// The prompt name (e.g., 'dcli', 'd4rt')
  final String _promptName;
  
  /// The data directory for sessions, history, etc.
  final String dataDirectory;
  
  MultilineMode multilineMode = MultilineMode.none;
  final List<String> multilineBuffer = [];
  RandomAccessFile? sessionFile;
  late String currentDirectory;
  String? currentSessionId;
  
  /// Create a new ReplState with optional custom prompt name and data directory
  ReplState({
    String promptName = 'dcli',
    String? dataDir,
  }) : _promptName = promptName,
       dataDirectory = dataDir ?? '${Platform.environment['HOME']}/.tom/$promptName' {
    // Default current directory to data directory
    currentDirectory = dataDirectory;
    // Cache terminal width once at startup
    try {
      _cachedTerminalWidth = console.windowWidth;
    } catch (_) {
      _cachedTerminalWidth = 80; // Fallback
    }
  }
  
  /// Console with scrollback history for readline support
  final Console console = Console.scrolling(recordBlanks: false);
  
  /// Completer for interrupting pending await operations via CTRL-C
  Completer<void>? _interruptCompleter;
  
  /// Timestamp of last CTRL-C press for double-press detection
  DateTime? _lastCtrlCTime;
  
  /// Whether we're currently awaiting a Future (can be interrupted)
  bool get isAwaitingFuture => _interruptCompleter != null;
  
  /// Start tracking a pending await operation
  void startAwait() {
    _interruptCompleter = Completer<void>();
  }
  
  /// End tracking a pending await operation
  void endAwait() {
    _interruptCompleter = null;
  }
  
  /// Interrupt the pending await operation
  /// Returns true if an await was interrupted, false if should exit
  bool interruptAwait() {
    final now = DateTime.now();
    final lastTime = _lastCtrlCTime;
    _lastCtrlCTime = now;
    
    // If second CTRL-C within 1 second, signal exit
    if (lastTime != null && now.difference(lastTime).inMilliseconds < 1000) {
      return false; // Should exit
    }
    
    // If we have a pending await, interrupt it
    if (_interruptCompleter != null && !_interruptCompleter!.isCompleted) {
      _interruptCompleter!.completeError(InterruptedException());
      return true;
    }
    
    // No pending await - treat as first press, wait for second
    return true;
  }
  
  /// Get the interrupt future for racing with async operations
  /// Returns a Future that completes with an error when interrupted
  Future<dynamic> get interruptFuture {
    if (_interruptCompleter == null) {
      // Return a future that never completes
      return Completer<dynamic>().future;
    }
    return _interruptCompleter!.future.then((_) => throw InterruptedException());
  }

  /// Cached terminal width to avoid repeated ANSI queries that leave escape sequences in stdin
  int? _cachedTerminalWidth;

  /// Get terminal width (cached to avoid ANSI escape sequence issues)
  int get terminalWidth => _cachedTerminalWidth ?? 80;

  /// The prompt prefix
  String get promptName => _promptName;

  /// Write the prompt with color
  /// 
  /// Prompt format: `tool cwd[session]>`
  /// Examples:
  /// - `dcli ~>` - DCli in home directory
  /// - `tom tom_build>` - Tom in tom_build directory  
  /// - `tom scripts[session]>` - Tom with active session
  void writePrompt({bool multiline = false}) {
    if (multiline) {
      console.setForegroundColor(ConsoleColor.brightBlack);
      console.write('...   ');
    } else {
      console.setForegroundColor(ConsoleColor.cyan);
      console.write(promptName);
      console.write(' ');
      console.write(_currentDirName);
      // Add session indicator if active
      if (currentSessionId != null) {
        console.setForegroundColor(ConsoleColor.yellow);
        console.write('[');
        console.write(currentSessionId!);
        console.write(']');
      }
      console.setForegroundColor(ConsoleColor.brightBlack);
      console.write('> ');
    }
    console.resetColorAttributes();
  }
  
  /// Get just the current directory name (last path component)
  /// Returns '~' for home directory
  String get _currentDirName {
    final home = Platform.environment['HOME'] ?? '';
    if (currentDirectory == home) return '~';
    final uri = Uri.parse(currentDirectory);
    return uri.pathSegments.isNotEmpty ? uri.pathSegments.last : '~';
  }
  
  /// Write continuation prompt (for lines ending with \)
  void writeContinuationPrompt() {
    console.setForegroundColor(ConsoleColor.brightBlack);
    console.write('   \\  ');
    console.resetColorAttributes();
  }

  /// Write an error message in red
  void writeError(String message) {
    console.setForegroundColor(ConsoleColor.red);
    console.writeLine('Error: $message');
    console.resetColorAttributes();
  }

  /// Write a warning message in yellow
  void writeWarning(String message) {
    console.setForegroundColor(ConsoleColor.yellow);
    console.writeLine('Warning: $message');
    console.resetColorAttributes();
  }

  /// Write a success/info message in green
  void writeSuccess(String message) {
    console.setForegroundColor(ConsoleColor.green);
    console.writeLine(message);
    console.resetColorAttributes();
  }

  /// Write a muted/secondary message
  void writeMuted(String message) {
    console.setForegroundColor(ConsoleColor.brightBlack);
    console.writeLine(message);
    console.resetColorAttributes();
  }

  /// Clear the screen (including scrollback buffer)
  void clearScreen() {
    // Use escape sequence that clears scrollback buffer as well
    // \x1B[3J clears scrollback, \x1B[2J clears screen, \x1B[H moves cursor home
    // Use console.write to avoid conflict with dart_console's stream management
    console.write('\x1B[3J\x1B[2J\x1B[H');
  }

  /// Print items in optimized column layout based on terminal width
  void printTabulated(List<String> items) {
    if (items.isEmpty) return;

    final termWidth = terminalWidth;  // Use cached width
    final minPadding = 2;

    // Try to fit as many columns as possible
    // Start with max possible columns and decrease until it fits
    final maxCols = items.length;
    
    for (var numCols = maxCols; numCols >= 1; numCols--) {
      // Calculate column widths for this layout
      final colWidths = _calculateColumnWidths(items, numCols);
      final totalWidth = colWidths.fold(0, (sum, w) => sum + w + minPadding);
      
      if (totalWidth <= termWidth || numCols == 1) {
        // This layout fits, use it
        _printWithColumnWidths(items, colWidths, minPadding);
        return;
      }
    }
  }

  /// Calculate width for each column based on items that will be in that column
  List<int> _calculateColumnWidths(List<String> items, int numCols) {
    final colWidths = List<int>.filled(numCols, 0);
    final numRows = (items.length / numCols).ceil();
    
    for (var i = 0; i < items.length; i++) {
      final col = i ~/ numRows;  // Column-first layout (like ls)
      if (col < numCols) {
        colWidths[col] = colWidths[col] > items[i].length 
            ? colWidths[col] 
            : items[i].length;
      }
    }
    return colWidths;
  }

  /// Print items with specific column widths
  void _printWithColumnWidths(List<String> items, List<int> colWidths, int padding) {
    final numCols = colWidths.length;
    final numRows = (items.length / numCols).ceil();
    
    for (var row = 0; row < numRows; row++) {
      final buffer = StringBuffer();
      for (var col = 0; col < numCols; col++) {
        final idx = col * numRows + row;  // Column-first indexing
        if (idx < items.length) {
          buffer.write(items[idx].padRight(colWidths[col] + padding));
        }
      }
      print(buffer.toString().trimRight());
    }
  }

  void recordInput(String input) {
    if (sessionFile != null) {
      sessionFile!.writeStringSync('$input\n');
      sessionFile!.flushSync();
    }
  }

  void closeSession() {
    sessionFile?.closeSync();
    sessionFile = null;
  }
}
