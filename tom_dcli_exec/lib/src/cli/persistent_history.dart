/// Persistent command history and defines for D4rt REPL
///
/// Since dart_console's scrollback buffer is private, this module provides
/// a patched Console that exposes the scrollback buffer for pre-population.
library;

import 'dart:io';

// Re-export the core dart_console functionality
export 'package:dart_console/dart_console.dart' hide Console;
import 'package:dart_console/dart_console.dart' as dc;

/// Maximum number of lines to keep in persistent history
const int maxHistoryLines = 500;

/// Configurable data directory for history and defines storage.
/// Set this before using any history/defines functions.
/// Defaults to ~/.tom/dcli
String _dataDirectory = '${Platform.environment['HOME']}/.tom/dcli';

/// Set the data directory for history and defines storage
void setDataDirectory(String path) {
  _dataDirectory = path;
}

/// Get the current data directory
String get dataDirectory => _dataDirectory;

/// Get the path to the history file
String get historyFilePath => '$_dataDirectory/.history';

/// Load persistent history from file
List<String> loadHistory() {
  try {
    final file = File(historyFilePath);
    if (file.existsSync()) {
      return file.readAsLinesSync();
    }
  } catch (_) {
    // Ignore errors loading history
  }
  return [];
}

/// Save a line to persistent history
void appendToHistory(String line) {
  if (line.trim().isEmpty) return;
  
  try {
    final file = File(historyFilePath);
    final parent = file.parent;
    if (!parent.existsSync()) {
      parent.createSync(recursive: true);
    }
    // Append line to history file
    file.writeAsStringSync('$line\n', mode: FileMode.append);
  } catch (_) {
    // Ignore errors saving history
  }
}

/// Truncate history file to max lines (called at startup)
void truncateHistoryIfNeeded() {
  try {
    final file = File(historyFilePath);
    if (!file.existsSync()) return;
    
    final lines = file.readAsLinesSync();
    if (lines.length > maxHistoryLines) {
      // Keep only the last maxHistoryLines lines
      final truncated = lines.sublist(lines.length - maxHistoryLines);
      file.writeAsStringSync('${truncated.join('\n')}\n');
    }
  } catch (_) {
    // Ignore errors truncating history
  }
}

// ============================================================================
// DEFINES SYSTEM
// User-defined command aliases/macros that persist across sessions.
// ============================================================================

/// Get the path to the defines file
String get definesFilePath => '$_dataDirectory/defines';

/// In-memory cache of defines (name -> template)
final Map<String, String> _defines = {};

/// Load defines from file into memory
Map<String, String> loadDefines() {
  _defines.clear();
  try {
    final file = File(definesFilePath);
    if (file.existsSync()) {
      final lines = file.readAsLinesSync();
      for (final line in lines) {
        if (line.trim().isEmpty) continue;
        final eqIndex = line.indexOf('=');
        if (eqIndex > 0) {
          final name = line.substring(0, eqIndex).trim();
          final template = line.substring(eqIndex + 1);
          _defines[name] = template;
        }
      }
    }
  } catch (_) {
    // Ignore errors loading defines
  }
  return Map.unmodifiable(_defines);
}

/// Get all current defines
Map<String, String> getDefines() => Map.unmodifiable(_defines);

/// Load defines from a file (without saving to persistent storage).
/// Returns the number of defines loaded, or -1 if file not found.
/// Default extension is .define.txt if no extension provided.
int loadDefinesFromFile(String path) {
  // Add default extension if no extension provided
  var filePath = path;
  if (!filePath.contains('.')) {
    filePath = '$filePath.define.txt';
  }
  
  try {
    final file = File(filePath);
    if (!file.existsSync()) {
      return -1;
    }
    
    final lines = file.readAsLinesSync();
    var count = 0;
    for (final line in lines) {
      if (line.trim().isEmpty || line.trim().startsWith('//')) continue;
      final eqIndex = line.indexOf('=');
      if (eqIndex > 0) {
        final name = line.substring(0, eqIndex).trim();
        final template = line.substring(eqIndex + 1);
        _defines[name] = template;
        count++;
      }
    }
    return count;
  } catch (_) {
    return -1;
  }
}

/// Add or update a define
void setDefine(String name, String template) {
  _defines[name] = template;
  _saveDefines();
}

/// Remove a define
bool removeDefine(String name) {
  if (_defines.containsKey(name)) {
    _defines.remove(name);
    _saveDefines();
    return true;
  }
  return false;
}

/// Save all defines to file
void _saveDefines() {
  try {
    final file = File(definesFilePath);
    final parent = file.parent;
    if (!parent.existsSync()) {
      parent.createSync(recursive: true);
    }
    final content = _defines.entries
        .map((e) => '${e.key}=${e.value}')
        .join('\n');
    file.writeAsStringSync(content.isEmpty ? '' : '$content\n');
  } catch (_) {
    // Ignore errors saving defines
  }
}

/// Parse arguments from a string, respecting quotes
/// Returns a list of arguments where quoted strings are kept together
List<String> parseDefineArgs(String input) {
  final args = <String>[];
  final buffer = StringBuffer();
  String? quoteChar;
  var escaped = false;
  
  for (var i = 0; i < input.length; i++) {
    final char = input[i];
    
    if (escaped) {
      buffer.write(char);
      escaped = false;
      continue;
    }
    
    if (char == '\\') {
      escaped = true;
      continue;
    }
    
    if (quoteChar != null) {
      // Inside quotes
      if (char == quoteChar) {
        // End of quoted section
        quoteChar = null;
      } else {
        buffer.write(char);
      }
    } else {
      // Outside quotes
      if (char == '"' || char == "'") {
        quoteChar = char;
      } else if (char == ' ' || char == '\t') {
        // Whitespace - end of argument
        if (buffer.isNotEmpty) {
          args.add(buffer.toString());
          buffer.clear();
        }
      } else {
        buffer.write(char);
      }
    }
  }
  
  // Add last argument if any
  if (buffer.isNotEmpty) {
    args.add(buffer.toString());
  }
  
  return args;
}

/// Expand a define template with arguments
/// Placeholders:
///   $$ - entire rest of line (unmodified)
///   $1, $2, $3, etc. - individual arguments
String expandDefine(String template, String restOfLine) {
  var result = template;
  
  // Replace $$ with the entire rest of line
  result = result.replaceAll(r'$$', restOfLine);
  
  // Parse arguments for $1, $2, etc.
  final args = parseDefineArgs(restOfLine);
  
  // Replace $1, $2, etc. with corresponding arguments
  // Start from highest number to avoid $1 replacing part of $10
  for (var i = 9; i >= 1; i--) {
    final placeholder = '\$$i';
    final value = i <= args.length ? args[i - 1] : '';
    result = result.replaceAll(placeholder, value);
  }
  
  return result;
}

/// Check if a line starts with a define invocation (@name)
/// Returns the expanded code if it matches, null otherwise
String? tryExpandDefine(String line) {
  if (!line.startsWith('@')) return null;
  
  // Find the define name (everything until first space or end of line)
  final spaceIndex = line.indexOf(' ');
  final defineName = spaceIndex > 0 
      ? line.substring(1, spaceIndex) 
      : line.substring(1);
  
  if (!_defines.containsKey(defineName)) return null;
  
  final template = _defines[defineName]!;
  final restOfLine = spaceIndex > 0 ? line.substring(spaceIndex + 1) : '';
  
  return expandDefine(template, restOfLine);
}

/// Scrollback buffer for command history - copied from dart_console
/// but made public so we can pre-populate it
class ScrollbackBuffer {
  final lineList = <String>[];
  int? lineIndex;
  String? currentLineBuffer;
  bool recordBlanks;

  ScrollbackBuffer({required this.recordBlanks});

  /// Add a new line to the scrollback buffer
  void add(String buffer) {
    if (buffer == '' && !recordBlanks) {
      return;
    }
    lineList.add(buffer);
    lineIndex = lineList.length;
    currentLineBuffer = null;
  }

  /// Scroll up - return previous line
  String up(String buffer) {
    if (lineIndex == null) {
      return buffer;
    } else {
      currentLineBuffer ??= buffer;
      lineIndex = lineIndex! - 1;
      lineIndex = lineIndex! < 0 ? 0 : lineIndex;
      return lineList[lineIndex!];
    }
  }

  /// Scroll down - return next line
  String? down() {
    if (lineIndex == null) {
      return null;
    } else {
      lineIndex = lineIndex! + 1;
      lineIndex = lineIndex! > lineList.length ? lineList.length : lineIndex;
      if (lineIndex == lineList.length) {
        final temp = currentLineBuffer;
        currentLineBuffer = null;
        return temp;
      } else {
        return lineList[lineIndex!];
      }
    }
  }
  
  /// Pre-populate with history lines
  void loadHistory(List<String> history) {
    for (final line in history) {
      if (line.isNotEmpty || recordBlanks) {
        lineList.add(line);
      }
    }
    lineIndex = lineList.length;
  }
}

/// Console wrapper that exposes the scrollback buffer for pre-population
/// 
/// This is a thin wrapper around dart_console's Console that adds
/// the ability to pre-load history from a file.
class Console {
  final dc.Console _console;
  final ScrollbackBuffer scrollbackBuffer;
  
  /// Create a console with scrollback history support
  Console.scrolling({bool recordBlanks = false}) 
    : _console = dc.Console(),
      scrollbackBuffer = ScrollbackBuffer(recordBlanks: recordBlanks);
  
  /// Pre-populate scrollback with history lines
  void loadHistoryIntoScrollback(List<String> history) {
    scrollbackBuffer.loadHistory(history);
  }
  
  // Delegate common methods to the underlying console
  
  int get windowWidth => _console.windowWidth;
  int get windowHeight => _console.windowHeight;
  
  dc.Coordinate? get cursorPosition => _console.cursorPosition;
  
  void write(String text) => _console.write(text);
  void writeLine([String? text]) => _console.writeLine(text);
  
  void setForegroundColor(dc.ConsoleColor color) => _console.setForegroundColor(color);
  void setBackgroundColor(dc.ConsoleColor color) => _console.setBackgroundColor(color);
  void resetColorAttributes() => _console.resetColorAttributes();
  
  void clearScreen() => _console.clearScreen();
  void eraseLine() => _console.eraseLine();
  void cursorUp([int count = 1]) {
    for (var i = 0; i < count; i++) {
      _console.cursorUp();
    }
  }
  void cursorDown([int count = 1]) {
    for (var i = 0; i < count; i++) {
      _console.cursorDown();
    }
  }
  void cursorLeft([int count = 1]) {
    for (var i = 0; i < count; i++) {
      _console.cursorLeft();
    }
  }
  void cursorRight([int count = 1]) {
    for (var i = 0; i < count; i++) {
      _console.cursorRight();
    }
  }
  
  void hideCursor() => _console.hideCursor();
  void showCursor() => _console.showCursor();
  
  void setRawMode() => _console.rawMode = true;
  void unsetRawMode() => _console.rawMode = false;
  
  dc.Key readKey() => _console.readKey();
  
  /// Read a line with scrollback history support
  /// 
  /// This is a custom implementation that uses our exposed scrollback buffer
  /// instead of dart_console's private one.
  String? readLine({bool cancelOnBreak = false}) {
    var buffer = '';
    var index = 0; // Cursor position within buffer
    
    _console.rawMode = true;
    
    try {
      while (true) {
        final key = _console.readKey();
        
        // Handle special keys
        if (key.isControl) {
          switch (key.controlChar) {
            case dc.ControlCharacter.enter:
              _console.writeLine();
              scrollbackBuffer.add(buffer);
              return buffer;
              
            case dc.ControlCharacter.ctrlC:
              if (cancelOnBreak) {
                _console.writeLine();
                return null;
              }
              // Otherwise ignore
              break;
              
            case dc.ControlCharacter.ctrlD:
              // End of input
              if (buffer.isEmpty) {
                _console.writeLine();
                return null;
              }
              break;
              
            case dc.ControlCharacter.backspace:
              if (index > 0) {
                // Delete character before cursor
                buffer = buffer.substring(0, index - 1) + buffer.substring(index);
                index--;
                // Redraw line from cursor position
                _console.cursorLeft();
                _console.write(buffer.substring(index));
                _console.write(' '); // Clear last character
                // Move cursor back to position
                final charsToMove = buffer.length - index + 1;
                for (var i = 0; i < charsToMove; i++) {
                  _console.cursorLeft();
                }
              }
              break;
              
            case dc.ControlCharacter.delete:
              if (index < buffer.length) {
                // Delete character at cursor
                buffer = buffer.substring(0, index) + buffer.substring(index + 1);
                // Redraw line from cursor position
                _console.write(buffer.substring(index));
                _console.write(' '); // Clear last character
                // Move cursor back to position
                final charsToMove = buffer.length - index + 1;
                for (var i = 0; i < charsToMove; i++) {
                  _console.cursorLeft();
                }
              }
              break;
              
            case dc.ControlCharacter.arrowLeft:
              if (index > 0) {
                index--;
                _console.cursorLeft();
              }
              break;
              
            case dc.ControlCharacter.arrowRight:
              if (index < buffer.length) {
                index++;
                _console.cursorRight();
              }
              break;
              
            case dc.ControlCharacter.arrowUp:
              // Get previous line from history
              final previous = scrollbackBuffer.up(buffer);
              // Clear current line
              if (index < buffer.length) {
                for (var i = index; i < buffer.length; i++) {
                  _console.cursorRight();
                }
              }
              for (var i = 0; i < buffer.length; i++) {
                _console.write('\b \b');
              }
              // Write new line
              buffer = previous;
              index = buffer.length;
              _console.write(buffer);
              break;
              
            case dc.ControlCharacter.arrowDown:
              // Get next line from history
              final next = scrollbackBuffer.down();
              if (next != null) {
                // Clear current line
                if (index < buffer.length) {
                  for (var i = index; i < buffer.length; i++) {
                    _console.cursorRight();
                  }
                }
                for (var i = 0; i < buffer.length; i++) {
                  _console.write('\b \b');
                }
                // Write new line
                buffer = next;
                index = buffer.length;
                _console.write(buffer);
              }
              break;
              
            case dc.ControlCharacter.home:
              // Move cursor to start
              for (var i = 0; i < index; i++) {
                _console.cursorLeft();
              }
              index = 0;
              break;
              
            case dc.ControlCharacter.end:
              // Move cursor to end
              for (var i = index; i < buffer.length; i++) {
                _console.cursorRight();
              }
              index = buffer.length;
              break;
              
            case dc.ControlCharacter.ctrlA:
              // Home (like Ctrl-A in readline)
              for (var i = 0; i < index; i++) {
                _console.cursorLeft();
              }
              index = 0;
              break;
              
            case dc.ControlCharacter.ctrlE:
              // End (like Ctrl-E in readline)
              for (var i = index; i < buffer.length; i++) {
                _console.cursorRight();
              }
              index = buffer.length;
              break;
              
            case dc.ControlCharacter.ctrlU:
              // Delete to start of line
              if (index > 0) {
                // Move to start, clear line, rewrite from cursor position
                for (var i = 0; i < index; i++) {
                  _console.cursorLeft();
                }
                final remaining = buffer.substring(index);
                _console.write(remaining);
                for (var i = 0; i < buffer.length - index; i++) {
                  _console.write(' ');
                }
                for (var i = 0; i < buffer.length; i++) {
                  _console.cursorLeft();
                }
                _console.write(remaining);
                for (var i = 0; i < remaining.length; i++) {
                  _console.cursorLeft();
                }
                buffer = remaining;
                index = 0;
              }
              break;
              
            case dc.ControlCharacter.ctrlK:
              // Delete to end of line
              if (index < buffer.length) {
                final charsToDelete = buffer.length - index;
                for (var i = 0; i < charsToDelete; i++) {
                  _console.write(' ');
                }
                for (var i = 0; i < charsToDelete; i++) {
                  _console.cursorLeft();
                }
                buffer = buffer.substring(0, index);
              }
              break;
              
            case dc.ControlCharacter.ctrlL:
              // Clear screen
              _console.clearScreen();
              // Redraw prompt and buffer (caller needs to handle this)
              break;
              
            default:
              // Ignore other control characters
              break;
          }
        } else {
          // Regular character - insert at cursor position
          final char = key.char;
          buffer = buffer.substring(0, index) + char + buffer.substring(index);
          index++;
          // Write from current position to end, then move back
          _console.write(buffer.substring(index - 1));
          final charsToMove = buffer.length - index;
          for (var i = 0; i < charsToMove; i++) {
            _console.cursorLeft();
          }
        }
      }
    } finally {
      _console.rawMode = false;
    }
  }
}
