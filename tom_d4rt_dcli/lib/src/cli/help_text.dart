/// Base help text functions for D4rt REPL
///
/// These are the help text sections that are shared between the base dcli tool
/// and extended D4rt tools. Extended tools can override or add to these.
library;

/// Returns the common commands section shown at startup and in --help.
String getCommonCommandsHelp() {
  return '''
<cyan>**Commands**</cyan>
  <yellow>**help**</yellow>           Show detailed help
  <yellow>**info**</yellow> [name]    Show details and suggestions for symbols
  <yellow>**classes**</yellow>        List classes in current environment
  <yellow>**enums**</yellow>          List enums in current environment
  <yellow>**methods**</yellow>        List methods in current environment
  <yellow>**variables**</yellow>      List variables in current environment
  <yellow>**imports**</yellow>        Show imports in current environment
  <yellow>**registered-***</yellow>   Show registered bridges (classes/enums/methods/variables/imports)
  <yellow>**show-init**</yellow>      Show initialization source
  <yellow>**clear**</yellow>          Clear the screen
  <yellow>**exit**</yellow>/<yellow>**quit**</yellow>  Exit the REPL''';
}

/// Returns the directory commands section.
String getDirectoryCommandsHelp(String dataPath, {String replayPatterns = '*.replay.txt, *.dcli'}) {
  return '''
<cyan>**Directory**</cyan>
  <yellow>**sessions**</yellow>    List session IDs *(from $dataPath)*
  <yellow>**scripts**</yellow>     List script files *(*.script.txt)*
  <yellow>**plays**</yellow>       List replay files *($replayPatterns)*
  <yellow>**executes**</yellow>    List executable files *(*.exec.dart)*
  <yellow>**ls**</yellow>          List all files in current directory
  <yellow>**cd**</yellow> <path>   Change current directory
  <yellow>**cwd**</yellow>         Show current working directory
  <yellow>**home**</yellow>        Return to *$dataPath*''';
}

/// Returns the defines section.
String getDefinesHelp() {
  return '''
<cyan>**Defines**</cyan> *(Command Aliases)*
  <yellow>**define**</yellow> <name>=<template>   Create a command alias
  <yellow>**undefine**</yellow> <name>            Remove a command alias
  <yellow>**defines**</yellow>                    List all defines
  <yellow>**.load-defines**</yellow> <path>       Load defines from file *(*.define.txt)*
  <yellow>**\$<name>**</yellow> [args]            Invoke a define

  *Placeholders:* <yellow>\$\$</yellow> entire line, <yellow>\$1</yellow>-<yellow>\$9</yellow> individual args

  *Example:*
    <yellow>define greet=print("Hello, \$1!");</yellow>
    <yellow>\$greet World</yellow>''';
}

/// Returns the multiline input section.
String getMultilineHelp() {
  return '''
<cyan>**Multiline**</cyan>
  <yellow>**.start-define**</yellow>   Define functions/classes *(persists)*
  <yellow>**.start-script**</yellow>   Run code block with return value
  <yellow>**.start-file**</yellow>     Run as file in current env
  <yellow>**.start-execute**</yellow>  Run as fresh program
  <yellow>**.end**</yellow>            End multiline input and run''';
}

/// Returns the file commands section.
String getFileCommandsHelp() {
  return '''
<cyan>**Files & Sessions**</cyan>
  <yellow>**.execute**</yellow> <path>  Run file as fresh program *(*.dart)*
  <yellow>**.file**</yellow> <path>     Execute file in current env *(*.exec.dart)*
  <yellow>**.script**</yellow> <path>   Load file line-by-line *(*.script.txt)*
  <yellow>**.load**</yellow> <path>     Replay file with output *(*.replay.txt)*
  <yellow>**.replay**</yellow> <path>   Replay file silently *(*.replay.txt)*
  <yellow>**.session**</yellow> <name>  Switch to session *(*.session.txt)*
  <yellow>**.reset**</yellow> [name]    Reset env, optionally replay session/file''';
}

/// Returns the print commands section.
String getPrintCommandsHelp() {
  return '''
<cyan>**Print File Contents**</cyan>
  <yellow>**.print-file**</yellow> <path>      Print file *(*.exec.dart)*
  <yellow>**.print-script**</yellow> <path>    Print script *(*.script.txt)*
  <yellow>**.print-replay**</yellow> <path>    Print replay *(*.replay.txt)*
  <yellow>**.print-session**</yellow> <name>   Print session *(*.session.txt)*''';
}

/// Returns the keyboard shortcuts section (for help command).
String getKeyboardShortcutsHelp() {
  return '''
<cyan>**Keyboard Shortcuts**</cyan>
  <yellow>**Up**</yellow>/<yellow>**Down**</yellow>       Navigate command history
  <yellow>**Left**</yellow>/<yellow>**Right**</yellow>    Move cursor
  <yellow>**Home**</yellow>/<yellow>**Ctrl-A**</yellow>   Go to start of line
  <yellow>**End**</yellow>/<yellow>**Ctrl-E**</yellow>    Go to end of line
  <yellow>**Ctrl-U**</yellow>            Delete to start of line
  <yellow>**Ctrl-K**</yellow>            Delete to end of line
  <yellow>**Ctrl-L**</yellow>            Clear screen
  <yellow>**Ctrl-C**</yellow>            Cancel await / exit''';
}

/// Returns the D4rt syntax section (for help command).
String getD4rtSyntaxHelp() {
  return '''
<cyan>**D4rt Syntax**</cyan>
  <yellow>var x = 10;</yellow>            Variable declaration
  <yellow>print(x);</yellow>              Print value
  <yellow>int foo(int x) => x;</yellow>   Define function *(persists)*
  <yellow>class Foo {}</yellow>           Define class *(persists)*''';
}

/// Returns the file conventions section (for --help).
String getFileConventionsHelp(String toolName, String dataPath) {
  final initFile = '${toolName}_init_source.dart';
  final ext = toolName; // dcli or d4rt
  return '''
<cyan>**File Conventions**</cyan>
  *Extensions:*
    <yellow>*.$ext</yellow>          $toolName replay file *(CLI argument or <yellow>**.load**</yellow>/<yellow>**.replay**</yellow> commands)*
    <yellow>*.$ext.dart</yellow>     Dart script for $toolName *(<yellow>**.execute**</yellow>/<yellow>**.file**</yellow> commands)*
    <yellow>*.script.txt</yellow>    Line-by-line script *(<yellow>**.script**</yellow> command)*
    <yellow>*.replay.txt</yellow>    Replay file *(<yellow>**.load**</yellow>/<yellow>**.replay**</yellow> commands)*
    <yellow>*.session.txt</yellow>   Session file *(auto-managed, records all input)*
    <yellow>*.define.txt</yellow>    Variable definitions *(<yellow>**.load-defines**</yellow> command)*

  *Locations:*
    <yellow>$dataPath/</yellow>                    Session files, custom init source
    <yellow>$dataPath/$initFile</yellow>  Custom initialization script

  *Path Resolution:*
    Absolute: <yellow>/path/to/file.dart</yellow>  |  Relative: <yellow>./scripts/myfile.dart</yellow>
    Home: <yellow>~/scripts/myfile.dart</yellow>   |  Basename: <yellow>myfile</yellow> *(auto-adds extension)*''';
}

/// Returns the sessions info section (for --help).
String getSessionsInfoHelp(String dataPath) {
  return '''
<cyan>**Sessions**</cyan>
  Sessions are stored in *$dataPath/<session-id>.session.txt*
  All input is recorded and replayed on session restart.
  Edit the session file to modify history.''';
}

/// Returns the init source section (for --help).
String getInitSourceHelp(String toolName, String dataPath) {
  final initFile = '${toolName}_init_source.dart';
  return '''
<cyan>**Init Source**</cyan>
  D4rt loads an initialization script before starting. By default, it uses
  the built-in import block for all registered bridges. Customize by placing
  a <yellow>$initFile</yellow> file in <yellow>$dataPath/</yellow>.''';
}

/// Returns the standard library note for bridges help.
String getStdlibNote() {
  return '''
  *Dart standard libraries dart:async, dart:io, dart:convert, dart:math,*
  *dart:collection, dart:typed_data, and dart:isolate are available to all scripts.*''';
}

/// Returns the stdlib import statements to prepend to scripts.
///
/// These imports are for Dart standard libraries that are bridged in D4rt
/// and available to all scripts.
String getStdlibImports() {
  return '''import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:math';
import 'dart:collection';
import 'dart:typed_data';
import 'dart:isolate';
''';
}
