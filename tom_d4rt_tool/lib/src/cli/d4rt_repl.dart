/// D4rt Interactive REPL
///
/// Command-line interpreter for D4rt with all Tom Framework bridges pre-registered.
/// This is the extended version of the base REPL from tom_d4rt_dcli.
library;

import 'package:tom_dartscript_bridges/tom_dartscript_bridges.dart';

import 'version.versioner.dart';

/// D4rt REPL with full Tom Framework bridges and VS Code integration.
class D4rtRepl extends D4rtReplBase with VSCodeIntegrationMixin {
  @override
  String get toolName => 'D4rt';

  @override
  String get toolVersion => TomVersionInfo.versionLong;

  @override
  bool get hasVSCodeIntegration => true;

  /// D4rt supports both .dcli and .d4rt replay files (in addition to .replay.txt)
  @override
  List<String> get replayFilePatterns => ['.replay.txt', '.dcli', '.d4rt'];

  @override
  void registerBridges(D4rt d4rt) {
    // Register all Tom Framework bridges including dcli
    TomDartscriptBridges.register(d4rt);
  }

  @override
  String getImportBlock() {
    // Prepend stdlib imports (available via D4rt's built-in stdlib bridges)
    return getStdlibImports() + TomDartscriptBridges.getImportBlock();
  }

  @override
  String getBridgesHelp([D4rt? d4rt]) {
    final buffer = StringBuffer();
    buffer.writeln('<cyan>**Bridges**</cyan>');
    buffer.writeln('  Use <yellow>**info**</yellow> <package> to see details for a specific package.');
    buffer.writeln('');

    if (d4rt != null) {
      // Generate list of info commands from configuration
      final packages = getPackageNames(d4rt);
      for (final pkg in packages) {
        buffer.writeln('  <yellow>info</yellow> $pkg');
      }
      buffer.writeln('');
    }

    buffer.writeln('  Use <yellow>**classes**</yellow> to list all available classes.');
    buffer.writeln('');
    buffer.writeln(getStdlibNote());
    return buffer.toString();
  }

  @override
  List<String> getAdditionalHelpSections() {
    return [
      getVSCodeIntegrationHelp(),
    ];
  }

  @override
  String getCliOptionsHelp() {
    return '''
<cyan>**Options**</cyan>
  <yellow>**-h**</yellow>, <yellow>**--help**</yellow>                Show this help message
  <yellow>**-v**</yellow>, <yellow>**--version**</yellow>             Show version information
  <yellow>**-session**</yellow> <id>                 Resume or start a named session
  <yellow>**-replace-session**</yellow> <id>         Delete existing session and start fresh
  <yellow>**-replay**</yellow> <file>                Replay a file before starting REPL
  <yellow>**-run-replay**</yellow> <file>            Execute replay file and exit
  <yellow>**-list-sessions**</yellow>                List available sessions
  <yellow>**-init-source**</yellow> <file>           Use custom init source file
  <yellow>**-no-init-source**</yellow>               Don't load custom init source
  <yellow>**--dump-configuration**</yellow>          Dump registered bridges and configuration
  <yellow>**--debug**</yellow>                       Print init source and debug information
  <yellow>**-integration-server-port**</yellow> <port>  Override VS Code port *(default: 19900)*''';
  }

  @override
  ReplState createReplState() {
    // Initialize VS Code integration from mixin
    initVSCodeIntegration();

    return ReplState(promptName: 'd4rt');
  }

  @override
  Future<void> onReplStartup(D4rt d4rt, ReplState state) async {
    // Check if VS Code server is available and print status
    await checkVSCodeAvailability();
  }

  @override
  Future<bool> handleAdditionalCommands(
    D4rt d4rt,
    ReplState state,
    String line, {
    bool silent = false,
  }) async {
    // Delegate to VS Code integration mixin
    return handleVSCodeCommands(state, line, silent: silent);
  }

  @override
  Future<bool> handleAdditionalMultilineEnd(
    D4rt d4rt,
    ReplState state,
    MultilineMode mode,
    String code, {
    bool silent = false,
  }) async {
    // Delegate to VS Code integration mixin
    return handleVSCodeMultilineEnd(state, mode, code, silent: silent);
  }
}

/// Entry point for the D4rt REPL.
Future<void> d4rtMain(List<String> arguments) async {
  // Parse VS Code port from arguments
  int? port;
  for (var i = 0; i < arguments.length; i++) {
    if (arguments[i] == '-integration-server-port' && i + 1 < arguments.length) {
      port = int.tryParse(arguments[i + 1]);
    }
  }

  final repl = D4rtRepl();
  if (port != null) {
    repl.vscodePort = port;
  }

  await repl.run(arguments);
}
