// D4rt Bridge - Generated file, do not edit
// Sources: 4 files
// Generated: 2026-02-05T08:59:00.704982

// ignore_for_file: unused_import, deprecated_member_use

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

import 'package:dcli_terminal/dcli_terminal.dart' as $pkg;

/// Bridge class for package_dcli_terminal module.
class PackageDcliTerminalBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createAnsiBridge(),
      _createAnsiColorBridge(),
      _createFormatBridge(),
      _createTerminalBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'Ansi': 'package:dcli_terminal/src/ansi.dart',
      'AnsiColor': 'package:dcli_terminal/src/ansi_color.dart',
      'Format': 'package:dcli_terminal/src/format.dart',
      'Terminal': 'package:dcli_terminal/src/terminal.dart',
    };
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<$pkg.TableAlignment>(
        name: 'TableAlignment',
        values: $pkg.TableAlignment.values,
      ),
      BridgedEnumDefinition<$pkg.TerminalClearMode>(
        name: 'TerminalClearMode',
        values: $pkg.TerminalClearMode.values,
      ),
    ];
  }

  /// Returns a map of enum names to their canonical source URIs.
  ///
  /// Used for deduplication when the same enum is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> enumSourceUris() {
    return {
      'TableAlignment': 'package:dcli_terminal/src/format.dart',
      'TerminalClearMode': 'package:dcli_terminal/src/terminal.dart',
    };
  }

  /// Registers all bridges with an interpreter.
  ///
  /// [importPath] is the package import path that D4rt scripts will use
  /// to access these classes (e.g., 'package:tom_build/tom.dart').
  static void registerBridges(D4rt interpreter, String importPath) {
    // Register bridged classes with source URIs for deduplication
    final classes = bridgeClasses();
    final classSources = classSourceUris();
    for (final bridge in classes) {
      interpreter.registerBridgedClass(bridge, importPath, sourceUri: classSources[bridge.name]);
    }

    // Register bridged enums with source URIs for deduplication
    final enums = bridgedEnums();
    final enumSources = enumSourceUris();
    for (final enumDef in enums) {
      interpreter.registerBridgedEnum(enumDef, importPath, sourceUri: enumSources[enumDef.name]);
    }

    // Register global functions with source URIs for deduplication
    final funcs = globalFunctions();
    final funcSources = globalFunctionSourceUris();
    final funcSigs = globalFunctionSignatures();
    for (final entry in funcs.entries) {
      interpreter.registertopLevelFunction(entry.key, entry.value, importPath, sourceUri: funcSources[entry.key], signature: funcSigs[entry.key]);
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      'red': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'red');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'red');
        final background = D4.getNamedArgWithDefault<$pkg.AnsiColor>(named, 'background', $pkg.AnsiColor.none);
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return $pkg.red(text, background: background, bold: bold);
      },
      'black': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'black');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'black');
        final background = D4.getNamedArgWithDefault<$pkg.AnsiColor>(named, 'background', $pkg.AnsiColor.white);
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return $pkg.black(text, background: background, bold: bold);
      },
      'green': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'green');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'green');
        final background = D4.getNamedArgWithDefault<$pkg.AnsiColor>(named, 'background', $pkg.AnsiColor.none);
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return $pkg.green(text, background: background, bold: bold);
      },
      'blue': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'blue');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'blue');
        final background = D4.getNamedArgWithDefault<$pkg.AnsiColor>(named, 'background', $pkg.AnsiColor.none);
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return $pkg.blue(text, background: background, bold: bold);
      },
      'yellow': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'yellow');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'yellow');
        final background = D4.getNamedArgWithDefault<$pkg.AnsiColor>(named, 'background', $pkg.AnsiColor.none);
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return $pkg.yellow(text, background: background, bold: bold);
      },
      'magenta': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'magenta');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'magenta');
        final background = D4.getNamedArgWithDefault<$pkg.AnsiColor>(named, 'background', $pkg.AnsiColor.none);
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return $pkg.magenta(text, background: background, bold: bold);
      },
      'cyan': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'cyan');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'cyan');
        final background = D4.getNamedArgWithDefault<$pkg.AnsiColor>(named, 'background', $pkg.AnsiColor.none);
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return $pkg.cyan(text, background: background, bold: bold);
      },
      'white': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'white');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'white');
        final background = D4.getNamedArgWithDefault<$pkg.AnsiColor>(named, 'background', $pkg.AnsiColor.none);
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return $pkg.white(text, background: background, bold: bold);
      },
      'orange': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'orange');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'orange');
        final background = D4.getNamedArgWithDefault<$pkg.AnsiColor>(named, 'background', $pkg.AnsiColor.none);
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return $pkg.orange(text, background: background, bold: bold);
      },
      'grey': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'grey');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'grey');
        final level = D4.getNamedArgWithDefault<double>(named, 'level', 0.5);
        final background = D4.getNamedArgWithDefault<$pkg.AnsiColor>(named, 'background', $pkg.AnsiColor.none);
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return $pkg.grey(text, level: level, background: background, bold: bold);
      },
    };
  }

  /// Returns a map of global function names to their canonical source URIs.
  ///
  /// Used for deduplication when the same function is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> globalFunctionSourceUris() {
    return {
      'red': 'package:dcli_terminal/src/ansi_color.dart',
      'black': 'package:dcli_terminal/src/ansi_color.dart',
      'green': 'package:dcli_terminal/src/ansi_color.dart',
      'blue': 'package:dcli_terminal/src/ansi_color.dart',
      'yellow': 'package:dcli_terminal/src/ansi_color.dart',
      'magenta': 'package:dcli_terminal/src/ansi_color.dart',
      'cyan': 'package:dcli_terminal/src/ansi_color.dart',
      'white': 'package:dcli_terminal/src/ansi_color.dart',
      'orange': 'package:dcli_terminal/src/ansi_color.dart',
      'grey': 'package:dcli_terminal/src/ansi_color.dart',
    };
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {
      'red': 'String red(String text, {AnsiColor background = AnsiColor.none, bool bold = true})',
      'black': 'String black(String text, {AnsiColor background = AnsiColor.white, bool bold = true})',
      'green': 'String green(String text, {AnsiColor background = AnsiColor.none, bool bold = true})',
      'blue': 'String blue(String text, {AnsiColor background = AnsiColor.none, bool bold = true})',
      'yellow': 'String yellow(String text, {AnsiColor background = AnsiColor.none, bool bold = true})',
      'magenta': 'String magenta(String text, {AnsiColor background = AnsiColor.none, bool bold = true})',
      'cyan': 'String cyan(String text, {AnsiColor background = AnsiColor.none, bool bold = true})',
      'white': 'String white(String text, {AnsiColor background = AnsiColor.none, bool bold = true})',
      'orange': 'String orange(String text, {AnsiColor background = AnsiColor.none, bool bold = true})',
      'grey': 'String grey(String text, {double level = 0.5, AnsiColor background = AnsiColor.none, bool bold = true})',
    };
  }

  /// Returns the list of canonical source library URIs.
  ///
  /// These are the actual source locations of all elements in this bridge,
  /// used for deduplication when the same libraries are exported through
  /// multiple barrels.
  static List<String> sourceLibraries() {
    return [
      'package:dcli_terminal/src/ansi.dart',
      'package:dcli_terminal/src/ansi_color.dart',
      'package:dcli_terminal/src/format.dart',
      'package:dcli_terminal/src/terminal.dart',
    ];
  }

  /// Returns a list of bridged enum names.
  static List<String> get enumNames => [
    'TableAlignment',
    'TerminalClearMode',
  ];

}

// =============================================================================
// Ansi Bridge
// =============================================================================

BridgedClass _createAnsiBridge() {
  return BridgedClass(
    nativeType: $pkg.Ansi,
    name: 'Ansi',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg.Ansi();
      },
    },
    staticGetters: {
      'isSupported': (visitor) => $pkg.Ansi.isSupported,
      'resetEmitAnsi': (visitor) => $pkg.Ansi.resetEmitAnsi,
      'esc': (visitor) => $pkg.Ansi.esc,
    },
    staticMethods: {
      'strip': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'strip');
        final line = D4.getRequiredArg<String>(positional, 0, 'line', 'strip');
        return $pkg.Ansi.strip(line);
      },
    },
    constructorSignatures: {
      '': 'factory Ansi()',
    },
    staticMethodSignatures: {
      'strip': 'String strip(String line)',
    },
    staticGetterSignatures: {
      'isSupported': 'bool get isSupported',
      'resetEmitAnsi': 'void get resetEmitAnsi',
      'esc': 'dynamic get esc',
    },
    staticSetterSignatures: {
      'isSupported': 'set isSupported(bool value)',
    },
  );
}

// =============================================================================
// AnsiColor Bridge
// =============================================================================

BridgedClass _createAnsiColorBridge() {
  return BridgedClass(
    nativeType: $pkg.AnsiColor,
    name: 'AnsiColor',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'AnsiColor');
        final code = D4.getRequiredArg<int>(positional, 0, 'code', 'AnsiColor');
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return $pkg.AnsiColor(code, bold: bold);
      },
    },
    getters: {
      'code': (visitor, target) => D4.validateTarget<$pkg.AnsiColor>(target, 'AnsiColor').code,
      'bold': (visitor, target) => D4.validateTarget<$pkg.AnsiColor>(target, 'AnsiColor').bold,
    },
    methods: {
      'apply': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.AnsiColor>(target, 'AnsiColor');
        D4.requireMinArgs(positional, 1, 'apply');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'apply');
        if (!named.containsKey('background')) {
          return t.apply(text);
        }
        if (named.containsKey('background')) {
          final background = D4.getRequiredNamedArg<$pkg.AnsiColor>(named, 'background', 'apply');
          return t.apply(text, background: background);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    staticGetters: {
      'codeBlack': (visitor) => $pkg.AnsiColor.codeBlack,
      'codeRed': (visitor) => $pkg.AnsiColor.codeRed,
      'codeGreen': (visitor) => $pkg.AnsiColor.codeGreen,
      'codeYellow': (visitor) => $pkg.AnsiColor.codeYellow,
      'codeBlue': (visitor) => $pkg.AnsiColor.codeBlue,
      'codeMagenta': (visitor) => $pkg.AnsiColor.codeMagenta,
      'codeCyan': (visitor) => $pkg.AnsiColor.codeCyan,
      'codeWhite': (visitor) => $pkg.AnsiColor.codeWhite,
      'codeOrange': (visitor) => $pkg.AnsiColor.codeOrange,
      'codeGrey': (visitor) => $pkg.AnsiColor.codeGrey,
      'black': (visitor) => $pkg.AnsiColor.black,
      'red': (visitor) => $pkg.AnsiColor.red,
      'green': (visitor) => $pkg.AnsiColor.green,
      'yellow': (visitor) => $pkg.AnsiColor.yellow,
      'blue': (visitor) => $pkg.AnsiColor.blue,
      'magenta': (visitor) => $pkg.AnsiColor.magenta,
      'cyan': (visitor) => $pkg.AnsiColor.cyan,
      'white': (visitor) => $pkg.AnsiColor.white,
      'orange': (visitor) => $pkg.AnsiColor.orange,
      'none': (visitor) => $pkg.AnsiColor.none,
    },
    staticMethods: {
      'reset': (visitor, positional, named, typeArgs) {
        return $pkg.AnsiColor.reset();
      },
      'fgReset': (visitor, positional, named, typeArgs) {
        return $pkg.AnsiColor.fgReset();
      },
      'bgReset': (visitor, positional, named, typeArgs) {
        return $pkg.AnsiColor.bgReset();
      },
    },
    constructorSignatures: {
      '': 'const AnsiColor(int code, {bool bold = true})',
    },
    methodSignatures: {
      'apply': 'String apply(String text, {AnsiColor background = none})',
    },
    getterSignatures: {
      'code': 'int get code',
      'bold': 'bool get bold',
    },
    staticMethodSignatures: {
      'reset': 'String reset()',
      'fgReset': 'String fgReset()',
      'bgReset': 'String bgReset()',
    },
    staticGetterSignatures: {
      'codeBlack': 'int get codeBlack',
      'codeRed': 'int get codeRed',
      'codeGreen': 'int get codeGreen',
      'codeYellow': 'int get codeYellow',
      'codeBlue': 'int get codeBlue',
      'codeMagenta': 'int get codeMagenta',
      'codeCyan': 'int get codeCyan',
      'codeWhite': 'int get codeWhite',
      'codeOrange': 'int get codeOrange',
      'codeGrey': 'int get codeGrey',
      'black': 'AnsiColor get black',
      'red': 'AnsiColor get red',
      'green': 'AnsiColor get green',
      'yellow': 'AnsiColor get yellow',
      'blue': 'AnsiColor get blue',
      'magenta': 'AnsiColor get magenta',
      'cyan': 'AnsiColor get cyan',
      'white': 'AnsiColor get white',
      'orange': 'AnsiColor get orange',
      'none': 'AnsiColor get none',
    },
  );
}

// =============================================================================
// Format Bridge
// =============================================================================

BridgedClass _createFormatBridge() {
  return BridgedClass(
    nativeType: $pkg.Format,
    name: 'Format',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg.Format();
      },
    },
    methods: {
      'row': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Format>(target, 'Format');
        D4.requireMinArgs(positional, 1, 'row');
        if (positional.isEmpty) {
          throw ArgumentError('row: Missing required argument "cols" at position 0');
        }
        final cols = D4.coerceList<String?>(positional[0], 'cols');
        final widths = D4.coerceListOrNull<int>(named['widths'], 'widths');
        final alignments = D4.coerceListOrNull<$pkg.TableAlignment>(named['alignments'], 'alignments');
        final delimiter = D4.getOptionalNamedArg<String?>(named, 'delimiter');
        return t.row(cols, widths: widths, alignments: alignments, delimiter: delimiter);
      },
      'limitString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Format>(target, 'Format');
        D4.requireMinArgs(positional, 1, 'limitString');
        final display = D4.getRequiredArg<String>(positional, 0, 'display', 'limitString');
        final width = D4.getNamedArgWithDefault<int>(named, 'width', 40);
        return t.limitString(display, width: width);
      },
      'percentage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Format>(target, 'Format');
        D4.requireMinArgs(positional, 2, 'percentage');
        final progress = D4.getRequiredArg<double>(positional, 0, 'progress', 'percentage');
        final precision = D4.getRequiredArg<int>(positional, 1, 'precision', 'percentage');
        return t.percentage(progress, precision);
      },
      'bytesAsReadable': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Format>(target, 'Format');
        D4.requireMinArgs(positional, 1, 'bytesAsReadable');
        final bytes = D4.getRequiredArg<int>(positional, 0, 'bytes', 'bytesAsReadable');
        final pad = D4.getNamedArgWithDefault<bool>(named, 'pad', true);
        return t.bytesAsReadable(bytes, pad: pad);
      },
    },
    constructorSignatures: {
      '': 'factory Format()',
    },
    methodSignatures: {
      'row': 'String row(List<String?> cols, {List<int>? widths, List<TableAlignment>? alignments, String? delimiter})',
      'limitString': 'String limitString(String display, {int width = 40})',
      'percentage': 'String percentage(double progress, int precision)',
      'bytesAsReadable': 'String bytesAsReadable(int bytes, {bool pad = true})',
    },
  );
}

// =============================================================================
// Terminal Bridge
// =============================================================================

BridgedClass _createTerminalBridge() {
  return BridgedClass(
    nativeType: $pkg.Terminal,
    name: 'Terminal',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg.Terminal();
      },
    },
    getters: {
      'isAnsi': (visitor, target) => D4.validateTarget<$pkg.Terminal>(target, 'Terminal').isAnsi,
      'column': (visitor, target) => D4.validateTarget<$pkg.Terminal>(target, 'Terminal').column,
      'columns': (visitor, target) => D4.validateTarget<$pkg.Terminal>(target, 'Terminal').columns,
      'row': (visitor, target) => D4.validateTarget<$pkg.Terminal>(target, 'Terminal').row,
      'hasTerminal': (visitor, target) => D4.validateTarget<$pkg.Terminal>(target, 'Terminal').hasTerminal,
      'rows': (visitor, target) => D4.validateTarget<$pkg.Terminal>(target, 'Terminal').rows,
      'lines': (visitor, target) => D4.validateTarget<$pkg.Terminal>(target, 'Terminal').lines,
    },
    setters: {
      'column': (visitor, target, value) => 
        D4.validateTarget<$pkg.Terminal>(target, 'Terminal').column = value as dynamic,
      'row': (visitor, target, value) => 
        D4.validateTarget<$pkg.Terminal>(target, 'Terminal').row = value as dynamic,
    },
    methods: {
      'clearScreen': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Terminal>(target, 'Terminal');
        final mode = D4.getNamedArgWithDefault<$pkg.TerminalClearMode>(named, 'mode', $pkg.TerminalClearMode.all);
        t.clearScreen(mode: mode);
        return null;
      },
      'overwriteLine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Terminal>(target, 'Terminal');
        D4.requireMinArgs(positional, 1, 'overwriteLine');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'overwriteLine');
        t.overwriteLine(text);
        return null;
      },
      'write': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Terminal>(target, 'Terminal');
        D4.requireMinArgs(positional, 1, 'write');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'write');
        t.write(text);
        return null;
      },
      'writeLine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Terminal>(target, 'Terminal');
        D4.requireMinArgs(positional, 1, 'writeLine');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'writeLine');
        if (!named.containsKey('alignment')) {
          t.writeLine(text);
          return null;
        }
        if (named.containsKey('alignment')) {
          final alignment = D4.getRequiredNamedArg<dynamic>(named, 'alignment', 'writeLine');
          t.writeLine(text, alignment: alignment);
          return null;
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'clearLine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Terminal>(target, 'Terminal');
        final mode = D4.getNamedArgWithDefault<$pkg.TerminalClearMode>(named, 'mode', $pkg.TerminalClearMode.all);
        t.clearLine(mode: mode);
        return null;
      },
      'showCursor': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Terminal>(target, 'Terminal');
        final show = D4.getRequiredNamedArg<bool>(named, 'show', 'showCursor');
        t.showCursor(show: show);
        return null;
      },
      'cursorUp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Terminal>(target, 'Terminal');
        t.cursorUp();
        return null;
      },
      'cursorDown': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Terminal>(target, 'Terminal');
        t.cursorDown();
        return null;
      },
      'cursorLeft': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Terminal>(target, 'Terminal');
        t.cursorLeft();
        return null;
      },
      'cursorRight': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Terminal>(target, 'Terminal');
        t.cursorRight();
        return null;
      },
      'startOfLine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Terminal>(target, 'Terminal');
        t.startOfLine();
        return null;
      },
      'home': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Terminal>(target, 'Terminal');
        t.home();
        return null;
      },
    },
    staticMethods: {
      'previousLine': (visitor, positional, named, typeArgs) {
        return $pkg.Terminal.previousLine();
      },
    },
    constructorSignatures: {
      '': 'factory Terminal()',
    },
    methodSignatures: {
      'clearScreen': 'void clearScreen({TerminalClearMode mode = TerminalClearMode.all})',
      'overwriteLine': 'void overwriteLine(String text)',
      'write': 'void write(String text)',
      'writeLine': 'void writeLine(String text, {TextAlignment alignment = TextAlignment.left})',
      'clearLine': 'void clearLine({TerminalClearMode mode = TerminalClearMode.all})',
      'showCursor': 'void showCursor({required bool show})',
      'cursorUp': 'void cursorUp()',
      'cursorDown': 'void cursorDown()',
      'cursorLeft': 'void cursorLeft()',
      'cursorRight': 'void cursorRight()',
      'startOfLine': 'void startOfLine()',
      'home': 'void home()',
    },
    getterSignatures: {
      'isAnsi': 'bool get isAnsi',
      'column': 'int get column',
      'columns': 'int get columns',
      'row': 'int get row',
      'hasTerminal': 'bool get hasTerminal',
      'rows': 'int get rows',
      'lines': 'int get lines',
    },
    setterSignatures: {
      'column': 'set column(int value)',
      'row': 'set row(int value)',
    },
    staticMethodSignatures: {
      'previousLine': 'void previousLine()',
    },
  );
}

