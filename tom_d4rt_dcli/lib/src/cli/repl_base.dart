/// Base D4rt REPL implementation
///
/// This provides an extensible base class for D4rt-based CLI tools.
/// Extended tools can override methods to add commands, bridges, and help sections.
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:console_markdown/console_markdown.dart';
import 'package:path/path.dart' as p;
import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

import '../api/cli_test_utils.dart';
import '../bot_mode/bot_mode.dart';
import 'cli_integration.dart';
import 'help_text.dart';
import 'persistent_history.dart';
import 'repl_state.dart';
import 'result_formatting.dart';

export 'cli_integration.dart';
export 'help_text.dart';
export 'persistent_history.dart';
export 'repl_state.dart';
export 'result_formatting.dart';

/// Base class for D4rt REPL tools.
/// 
/// Extended tools should:
/// 1. Override [toolName] and [toolVersion] for branding
/// 2. Override [registerBridges] to add additional bridges
/// 3. Override [getImportBlock] to include bridge imports
/// 4. Override [getBridgesHelp] to list available bridges in help
/// 5. Override [getAdditionalHelpSections] to add tool-specific help
/// 6. Override [handleAdditionalCommands] to add tool-specific commands
abstract class D4rtReplBase {
  /// CLI integration for the `cli` global variable.
  final _cliIntegration = CliReplIntegration();
  
  /// The name of the tool (shown in prompt and help)
  String get toolName;
  
  /// The version string for the tool
  String get toolVersion;
  
  /// The file extension for replay files (e.g., 'dcli' for *.dcli files)
  /// Override in subclasses (e.g., 'd4rt' for *.d4rt files)
  String get toolExtension => toolName.toLowerCase();
  
  /// Returns the list of file patterns to match when listing replay files.
  /// Override in subclasses to add tool-specific extensions (e.g., '.d4rt').
  /// Default returns ['.replay.txt', '.<toolExtension>'] (e.g., '.dcli')
  List<String> get replayFilePatterns => ['.replay.txt', '.$toolExtension'];
  
  /// Formats replay file patterns for display in help text (e.g., "*.replay.txt, *.dcli")
  String _formatReplayPatterns() => replayFilePatterns.map((p) => '*$p').join(', ');
  
  /// The data directory for sessions, history, etc.
  /// Default is `~/.tom/<toolname>`. Override for custom location.
  String get dataDirectory => '${Platform.environment['HOME']}/.tom/${toolName.toLowerCase()}';
  
  /// The short form of dataDirectory for display in help (e.g., `~/.tom/dcli`)
  String get dataDirectoryShort => '~/.tom/${toolName.toLowerCase()}';
  
  /// The init source file name (e.g., dcli_init_source.dart)
  String get initSourceFileName => '${toolName.toLowerCase()}_init_source.dart';
  
  /// Whether to include VS Code integration commands (override in extended tools)
  bool get hasVSCodeIntegration => false;
  
  /// Register bridges with the D4rt interpreter.
  /// Extended tools should call super and add their bridges.
  void registerBridges(D4rt d4rt);
  
  /// Get the import block for script initialization.
  /// Extended tools should call super and append their imports.
  String getImportBlock();
  
  /// Get the bridges help section describing available bridges.
  /// If [d4rt] is provided, generates dynamic content from configuration.
  String getBridgesHelp([D4rt? d4rt]);
  
  /// Get additional help sections for tool-specific features.
  /// Returns a list of help section strings.
  List<String> getAdditionalHelpSections() => [];
  
  /// Handle additional tool-specific commands.
  /// Returns true if the command was handled, false to continue with default processing.
  Future<bool> handleAdditionalCommands(
    D4rt d4rt,
    ReplState state,
    String line, {
    bool silent = false,
  }) async => false;
  
  /// Handle additional multiline mode endings.
  /// Called when .end is entered for a multiline mode not handled by the base class.
  /// Returns true if the mode was handled, false otherwise.
  Future<bool> handleAdditionalMultilineEnd(
    D4rt d4rt,
    ReplState state,
    MultilineMode mode,
    String code, {
    bool silent = false,
  }) async => false;
  
  /// Called when starting the REPL, after printing the banner.
  /// Override to add tool-specific startup logic.
  Future<void> onReplStartup(D4rt d4rt, ReplState state) async {}
  
  /// Create a new ReplState instance.
  /// Override to use a custom state class.
  ReplState createReplState() => ReplState(
    promptName: toolName.toLowerCase(),
    dataDir: dataDirectory,
  );
  
  /// Get the version banner shown at startup and with --version.
  String getVersionBanner() {
    return '**$toolName** Interactive REPL <yellow>$toolVersion</yellow>';
  }

  /// Returns the CLI-specific options section (for --help).
  String getCliOptionsHelp() {
    return '''
<cyan>**Options**</cyan>
  <yellow>**-h**</yellow>, <yellow>**--help**</yellow>                Show this help message
  <yellow>**-v**</yellow>, <yellow>**--version**</yellow>             Show version information
  <yellow>**-session**</yellow> <id>                 Resume or start a named session
  <yellow>**-replace-session**</yellow> <id>         Delete existing session and start fresh
  <yellow>**-replay**</yellow> <file>                Replay a file before starting REPL
  <yellow>**-run-replay**</yellow> <file>            Execute replay file and exit
  <yellow>**-test**</yellow>                         Run replay in test mode (with -run-replay)
  <yellow>**-output**</yellow> <file>                Write test output to file (with -test)
  <yellow>**-list-sessions**</yellow>                List available sessions
  <yellow>**-init-source**</yellow> <file>           Use custom init source file
  <yellow>**-no-init-source**</yellow>               Don't load custom init source
  <yellow>**--dump-configuration**</yellow>          Dump registered bridges and configuration
  <yellow>**--debug**</yellow>                       Print init source and debug information
  <yellow>**--bot-mode**</yellow>                    Run as Telegram bot server
  <yellow>**--bot-config**</yellow> <file>           Bot mode configuration file''';
  }

  /// Returns the CLI examples section (for --help).
  String getCliExamplesHelp() {
    final name = toolName.toLowerCase();
    final ext = toolExtension;
    return '''
<cyan>**Examples**</cyan>
  <yellow>$name</yellow>                                  Start interactive REPL
  <yellow>$name myscript.dart</yellow>                    Execute a script
  <yellow>$name myscript.$ext</yellow>                   Same as <yellow>$name -run-replay myscript.$ext</yellow>
  <yellow>$name -run-replay setup.replay.txt</yellow>     Execute replay file and exit
  <yellow>$name -session mysession</yellow>               Start or resume a named session
  <yellow>$name -replace-session mysession</yellow>       Delete session and start fresh
  <yellow>$name -replay setup.$ext -session x</yellow>   Replay file and start session
  <yellow>$name -list-sessions</yellow>                   List available sessions
  <yellow>$name --dump-configuration</yellow>             Dump configuration''';
  }
  
  /// Print CLI usage information (for --help).
  void printUsage() {
    final name = toolName.toLowerCase();
    final ext = toolExtension;
    print('');
    print(getVersionBanner());
    print('<cyan>─────────────────────────────────────────────────────────────</cyan>');
    print('');
    print('<cyan>**Usage**</cyan>');
    print('  <yellow>$name</yellow> [options] [script.dart | replay.$ext]');
    print('');
    print(getCliOptionsHelp());
    print('');
    print(getInitSourceHelp(toolName.toLowerCase(), dataDirectoryShort));
    print('');
    print(getCliExamplesHelp());
    print('');
    print(getSessionsInfoHelp(dataDirectoryShort));
    print('');
    print(getFileConventionsHelp(toolName.toLowerCase(), dataDirectoryShort));
    print('');
    print('<cyan>─────────────────────────────────────────────────────────────</cyan>');
    print('<cyan>**REPL Commands**</cyan>');
    print('<cyan>─────────────────────────────────────────────────────────────</cyan>');
    print('');
    _printAllHelpSections();
    print('');
  }
  
  /// Print all help sections for the REPL help command.
  void _printAllHelpSections([D4rt? d4rt]) {
    print(getCommonCommandsHelp());
    print('');
    
    // Additional tool-specific sections (like VS Code integration)
    for (final section in getAdditionalHelpSections()) {
      print(section);
      print('');
    }
    
    print(getDefinesHelp());
    print('');
    print(getDirectoryCommandsHelp(dataDirectoryShort, replayPatterns: _formatReplayPatterns()));
    print('');
    print(getMultilineHelp());
    print('');
    print(getFileCommandsHelp());
    print('');
    print(getPrintCommandsHelp());
    print('');
    print(getKeyboardShortcutsHelp());
    print('');
    print(getD4rtSyntaxHelp());
    print('');
    print(getTrailCommandsHelp());
    print('');
    print(getCopilotPromptsHelp());
    print('');
    print(getBridgesHelp(d4rt));
  }
  
  /// Prints detailed REPL help (for help command).
  void printReplHelp([D4rt? d4rt]) {
    print('');
    print('**$toolName REPL** - *Detailed Help*');
    print('<cyan>─────────────────────────────────────────────────────────────</cyan>');
    print('');
    _printAllHelpSections(d4rt);
    print('');
    print('<cyan>─────────────────────────────────────────────────────────────</cyan>');
  }
  
  /// Main entry point for the REPL.
  Future<void> run(List<String> arguments) async {
    // Wrap all output in a zone that applies console_markdown formatting
    await runZonedGuarded(
      () => _runImpl(arguments),
      (error, stack) {
        stderr.writeln('<red>**Uncaught error:**</red> $error'.toConsole());
        if (arguments.contains('--debug') || arguments.contains('-debug')) {
          stderr.writeln(stack.toString());
        }
      },
      zoneSpecification: ZoneSpecification(
        print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
          parent.print(zone, line.toConsole());
        },
      ),
    );
  }
  
  /// Internal implementation of run, wrapped in console_markdown zone.
  Future<void> _runImpl(List<String> arguments) async {
    // Parse arguments
    final help = arguments.contains('--help') || 
                 arguments.contains('-help') || 
                 arguments.contains('-h') ||
                 arguments.contains('help');
    final dumpConfig = arguments.contains('--dump-configuration') ||
        arguments.contains('-dump-configuration');
    final version = arguments.contains('--version') || 
                    arguments.contains('-version') ||
                    arguments.contains('-v') ||
                    arguments.contains('version');
    final debug = arguments.contains('--debug') || arguments.contains('-debug');
    final noInitSource = arguments.contains('-no-init-source') || arguments.contains('--no-init-source');
    final testMode = arguments.contains('-test') || arguments.contains('--test');

    // Parse options
    String? sessionId;
    String? replayFile;
    String? runReplayFile;
    String? customInitSource;
    String? testOutputPath;
    String? botModeConfigFile;
    var replaceSession = false;
    final listSessions = arguments.contains('-list-sessions') || arguments.contains('--list-sessions');
    final botMode = arguments.contains('-bot-mode') || arguments.contains('--bot-mode');
    
    // Known option arguments
    final knownOptions = <String>{
      '--help', '-help', '-h', 'help',
      '--version', '-version', '-v', 'version',
      '--dump-configuration', '-dump-configuration',
      '--debug', '-debug',
      '-no-init-source', '--no-init-source',
      '-list-sessions', '--list-sessions',
      '-session', '--session',
      '-replace-session', '--replace-session',
      '-replay', '--replay',
      '-run-replay', '--run-replay',
      '-init-source', '--init-source',
      '-test', '--test',
      '-output', '--output',
      '-bot-mode', '--bot-mode',
      '-bot-config', '--bot-config',
    };
    
    for (var i = 0; i < arguments.length; i++) {
      if (arguments[i] == '-session' || arguments[i] == '--session') {
        if (i + 1 < arguments.length) {
          sessionId = arguments[i + 1];
        }
      }
      if (arguments[i] == '-replace-session' || arguments[i] == '--replace-session') {
        replaceSession = true;
        if (i + 1 < arguments.length) {
          sessionId = arguments[i + 1];
        }
      }
      if (arguments[i] == '-replay' || arguments[i] == '--replay') {
        if (i + 1 < arguments.length) {
          replayFile = arguments[i + 1];
        }
      }
      if (arguments[i] == '-run-replay' || arguments[i] == '--run-replay') {
        if (i + 1 < arguments.length) {
          runReplayFile = arguments[i + 1];
        }
      }
      if (arguments[i] == '-init-source' || arguments[i] == '--init-source') {
        if (i + 1 < arguments.length) {
          customInitSource = arguments[i + 1];
        }
      }
      if (arguments[i] == '-output' || arguments[i] == '--output') {
        if (i + 1 < arguments.length) {
          testOutputPath = arguments[i + 1];
        }
      }
      // Also support -output=path format
      if (arguments[i].startsWith('-output=') || arguments[i].startsWith('--output=')) {
        testOutputPath = arguments[i].split('=').skip(1).join('=');
      }
      if (arguments[i] == '-bot-config' || arguments[i] == '--bot-config') {
        if (i + 1 < arguments.length) {
          botModeConfigFile = arguments[i + 1];
        }
      }
      // Also support -bot-config=path format
      if (arguments[i].startsWith('-bot-config=') || arguments[i].startsWith('--bot-config=')) {
        botModeConfigFile = arguments[i].split('=').skip(1).join('=');
      }
    }

    // Collect option values that should be excluded from non-option args
    final optionValues = <String>{};
    if (sessionId != null) optionValues.add(sessionId);
    if (replayFile != null) optionValues.add(replayFile);
    if (runReplayFile != null) optionValues.add(runReplayFile);
    if (customInitSource != null) optionValues.add(customInitSource);
    if (testOutputPath != null) optionValues.add(testOutputPath);
    if (botModeConfigFile != null) optionValues.add(botModeConfigFile);

    // Get non-option arguments
    final nonOptionArgs = arguments.where((arg) {
      if (arg.startsWith('-')) return false;
      if (knownOptions.contains(arg)) return false;
      if (optionValues.contains(arg)) return false;
      return true;
    }).toList();

    // Determine if the argument is a script file, replay file, or an expression
    String? script;
    String? expression;
    String? replayFileFromExtension;
    
    if (nonOptionArgs.isNotEmpty) {
      final firstArg = nonOptionArgs.first;
      if (firstArg.endsWith('.dart')) {
        script = firstArg;
      } else if (firstArg.endsWith('.$toolExtension')) {
        // Treat *.dcli files as replay files (run-replay)
        replayFileFromExtension = firstArg;
      } else {
        expression = nonOptionArgs.join(' ');
      }
    }

    if (help) {
      printUsage();
      return;
    }

    if (version) {
      print(getVersionBanner());
      return;
    }

    // Create D4rt interpreter with all permissions
    final d4rt = D4rt();
    
    d4rt.grant(FilesystemPermission.any);
    d4rt.grant(NetworkPermission.any);
    d4rt.grant(ProcessRunPermission.any);
    d4rt.grant(IsolatePermission.any);
    d4rt.grant(DangerousPermission.any);

    // Register all bridges
    registerBridges(d4rt);
    
    // Register CLI bridge for the `cli` global variable
    _cliIntegration.registerBridge(d4rt);

    if (dumpConfig) {
      _dumpConfiguration(d4rt);
      return;
    }

    if (listSessions) {
      _listSessions();
      return;
    }

    // Bot mode - run as Telegram bot server
    if (botMode) {
      await _runBotMode(d4rt, configFile: botModeConfigFile);
      return;
    }

    // Determine the init source to use
    final defaultInitSource = '''
${getImportBlock()}
void main() {}
''';

    String initSource;
    String? initSourcePath;
    
    if (customInitSource != null) {
      final customFile = File(customInitSource);
      if (!customFile.existsSync()) {
        stderr.writeln('Error: Init source file not found: $customInitSource');
        exit(1);
      }
      initSource = customFile.readAsStringSync();
      initSourcePath = customInitSource;
      print('Using init source: $initSourcePath');
    } else {
      final defaultInitFile = File('$dataDirectory/$initSourceFileName');
      
      if (defaultInitFile.existsSync() && !noInitSource) {
        initSource = defaultInitFile.readAsStringSync();
        initSourcePath = defaultInitFile.path;
        print('Using init source: $initSourcePath');
      } else if (defaultInitFile.existsSync() && noInitSource) {
        print('Init source found, but loading was suppressed. Using default init source instead.');
        initSource = defaultInitSource;
      } else {
        initSource = defaultInitSource;
      }
    }

    if (debug) {
      print('=== D4rt Initialization Source ===');
      print(initSource);
      print('==================================');
      print('');
    }

    // If an expression was provided, evaluate it and exit
    if (expression != null) {
      d4rt.execute(source: initSource);
      try {
        final result = d4rt.eval(expression);
        if (result != null) {
          printResult(result);
        }
      } catch (e) {
        stderr.writeln('Error: $e');
        exit(1);
      }
      exit(0);
    }

    // If a script file is provided, execute it directly
    if (script != null) {
      await _executeScript(d4rt, script);
      return;
    }

    // If -run-replay is provided with -test, run in test mode
    if (runReplayFile != null && testMode) {
      await _runReplayTestMode(d4rt, runReplayFile, initSource, testOutputPath);
      return;
    }

    // If -run-replay is provided, execute the replay file and exit
    if (runReplayFile != null) {
      await _runReplayAndExit(d4rt, runReplayFile, initSource);
      return;
    }
    
    // If a replay file was specified via extension (e.g., dcli myfile.dcli) with -test
    if (replayFileFromExtension != null && testMode) {
      await _runReplayTestMode(d4rt, replayFileFromExtension, initSource, testOutputPath);
      return;
    }
    
    // If a replay file was specified via extension (e.g., dcli myfile.dcli), execute it
    if (replayFileFromExtension != null) {
      await _runReplayAndExit(d4rt, replayFileFromExtension, initSource);
      return;
    }

    // Initialize environment for REPL mode
    d4rt.execute(source: initSource);

    // Interactive REPL mode
    await _runRepl(
      d4rt, 
      sessionId: sessionId, 
      replaceSession: replaceSession, 
      replayFile: replayFile,
    );
  }
  
  /// Dump the D4rt configuration
  void _dumpConfiguration(D4rt d4rt) {
    print('$toolName Configuration');
    print('==================');
    print('');

    final config = d4rt.getConfiguration();
    
    var totalClasses = 0;
    for (final import in config.imports) {
      totalClasses += import.classes.length;
    }
    print('Registered Bridge Classes: $totalClasses');
    print('');

    for (final import in config.imports) {
      print('Import: ${import.importPath} (${import.classes.length} classes, ${import.enums.length} enums)');
      for (final cls in import.classes) {
        print('  - ${cls.name}');
      }
      print('');
    }

    print('Import Block:');
    print('-' * 40);
    print(getImportBlock());
  }

  /// List available sessions
  void _listSessions() {
    final sessionDir = Directory(dataDirectory);
    if (!sessionDir.existsSync()) {
      print('No sessions found.');
      print('Session directory does not exist: ${sessionDir.path}');
      return;
    }

    final sessionFiles = sessionDir
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.session.txt'))
        .toList();

    if (sessionFiles.isEmpty) {
      print('No sessions found in ${sessionDir.path}');
      return;
    }

    print('Available sessions:');
    print('');
    for (final file in sessionFiles) {
      final name = file.uri.pathSegments.last.replaceAll('.session.txt', '');
      final stat = file.statSync();
      final modified = stat.modified;
      final size = stat.size;
      final lines = file.readAsLinesSync().length;
      print('  $name');
      print('    Modified: $modified');
      print('    Size: $size bytes, $lines lines');
      print('');
    }
  }

  /// Run in bot mode - start Telegram bot server
  Future<void> _runBotMode(D4rt d4rt, {String? configFile}) async {
    // Determine config file location
    final configPath = configFile ?? '$dataDirectory/bot_config.yaml';
    final configFileObj = File(configPath);
    
    if (!configFileObj.existsSync()) {
      stderr.writeln('Bot mode configuration file not found: $configPath');
      stderr.writeln('');
      stderr.writeln('Create a configuration file with the following structure:');
      stderr.writeln('''
# Bot Mode Configuration
bots:
  - name: MyBot
    token_env: TELEGRAM_BOT_TOKEN  # Environment variable containing the token
    allowed_users:
      - 123456789  # Your Telegram user ID
    
security:
  mode: blacklist  # whitelist or blacklist
  allowed_paths:
    - ~/.tom
  blocked_commands:
    - rm
    - sudo
    
output:
  max_length: 4000
  file_threshold: 1000

polling:
  timeout_seconds: 30
''');
      exit(1);
    }
    
    // Load configuration
    BotModeConfig config;
    try {
      config = await BotModeConfig.loadFromFile(configPath);
    } catch (e) {
      stderr.writeln('Error loading bot configuration: $e');
      exit(1);
    }
    
    // Initialize the init source for REPL execution
    final defaultInitSource = '''
${getImportBlock()}
void main() {}
''';
    
    d4rt.execute(source: defaultInitSource);
    
    // Create ReplState for bot mode processing using the overridable method
    // This ensures subclasses can customize state initialization (e.g., VS Code integration)
    final state = createReplState();
    state.currentDirectory = Directory.current.path;
    
    // Create execution callback that uses processInput with zone-based output capture
    Future<ExecutionResult> executeCommand(String command) async {
      final outputBuffer = StringBuffer();
      
      // Strip ANSI escape codes
      String stripAnsi(String text) {
        return text.replaceAll(RegExp(r'\x1B\[[0-9;]*[a-zA-Z]'), '');
      }
      
      // Create custom stdout/stderr that capture output (no markdown conversion - done by formatter)
      final capturedStdout = _CaptureStdout(outputBuffer, (s) => s, stripAnsi);
      final capturedStderr = _CaptureStdout(outputBuffer, (s) => s, stripAnsi, isError: true);
      
      try {
        // Use IOOverrides to capture ALL stdout/stderr, including Console writes
        await IOOverrides.runZoned(
          () async {
            // Also override print within the zone
            await runZoned(
              () async {
                await processInput(d4rt, state, command, silent: false);
              },
              zoneSpecification: ZoneSpecification(
                print: (self, parent, zone, line) {
                  // Don't delegate to parent - this bypasses console_markdown ANSI conversion
                  outputBuffer.writeln(line);
                },
              ),
            );
          },
          stdout: () => capturedStdout,
          stderr: () => capturedStderr,
        );
        
        final output = outputBuffer.toString().trim();
        
        // Detect formatted text commands (help, info) that should render markdown
        final isFormattedText = command == 'help' || 
                                command.startsWith('info ') ||
                                command == 'classes' ||
                                command == 'enums' ||
                                command == 'methods' ||
                                command == 'variables' ||
                                command == 'defines' ||
                                command.startsWith('classes ') ||
                                command.startsWith('enums ') ||
                                command.startsWith('methods ') ||
                                command.startsWith('variables ') ||
                                command.startsWith('defines ');
        
        return ExecutionResult(
          output: output,
          isError: false,
          isFormattedText: isFormattedText,
        );
      } catch (e) {
        // Include captured output along with the error
        final capturedOutput = outputBuffer.toString().trim();
        final errorMsg = stripAnsi(e.toString());
        return ExecutionResult(
          output: capturedOutput.isNotEmpty ? '$capturedOutput\n\n❌ $errorMsg' : '',
          isError: true,
          errorMessage: errorMsg,
        );
      }
    }
    
    // Create and start the bot server
    final server = TelegramBotServer(
      config: config,
      executeCommand: executeCommand,
      toolName: toolName,
      toolVersion: toolVersion,
    );
    
    try {
      await server.start();
      await server.waitForShutdown();
      exit(0);
    } catch (e) {
      stderr.writeln('Bot server error: $e');
      exit(1);
    }
  }
  
  /// Execute a D4rt script file with import resolution.
  Future<void> _executeScript(D4rt d4rt, String scriptPath) async {
    final file = File(scriptPath);
    if (!file.existsSync()) {
      stderr.writeln('Error: Script file not found: $scriptPath');
      exit(1);
    }

    final fullPath = file.absolute.path;
    print('Executing: $fullPath');
    print('');

    try {
      final result = executeFile(
        d4rt,
        fullPath,
        log: (msg) => print('  $msg'),
      );
      
      if (result.success) {
        if (result.sourcesLoaded > 1) {
          print('(loaded ${result.sourcesLoaded} files)');
        }
        if (result.result != null) {
          var finalResult = result.result;
          if (finalResult is Future) {
            finalResult = await finalResult;
          }
          if (finalResult != null) {
            print('Result: $finalResult');
          }
        }
        exit(0);
      } else {
        stderr.writeln('Error: ${result.error}');
        if (result.stackTrace != null && Platform.environment['DEBUG'] == 'true') {
          stderr.writeln(result.stackTrace);
        }
        exit(1);
      }
    } catch (e, stackTrace) {
      stderr.writeln('Error: $e');
      if (Platform.environment['DEBUG'] == 'true') {
        stderr.writeln(stackTrace);
      }
      exit(1);
    }
  }

  /// Execute a replay file and exit.
  Future<void> _runReplayAndExit(D4rt d4rt, String replayPath, String initSource) async {
    final file = File(replayPath);
    if (!file.existsSync()) {
      stderr.writeln('Error: Replay file not found: $replayPath');
      exit(1);
    }

    final fullPath = file.absolute.path;
    print('Running replay: $fullPath');
    print('');

    d4rt.execute(source: initSource);

    final state = createReplState();
    state.currentDirectory = Directory.current.path;

    try {
      final lineCount = await _replayFile(d4rt, state, fullPath, silent: false);
      print('');
      print('Completed: $lineCount lines');
      exit(0);
    } catch (e, stackTrace) {
      stderr.writeln('Error: $e');
      if (Platform.environment['DEBUG'] == 'true') {
        stderr.writeln(stackTrace);
      }
      exit(1);
    }
  }

  /// Execute a replay file in test mode, capturing output.
  /// 
  /// Test mode runs the replay file silently and captures all output.
  /// If [outputPath] is provided, output is written to that file.
  /// Otherwise, output is written to stdout.
  /// 
  /// The test mode also captures verification failures from [verify] calls.
  /// Exit code is 0 if all verifications pass, 1 if any fail.
  Future<void> _runReplayTestMode(
    D4rt d4rt, 
    String replayPath, 
    String initSource,
    String? outputPath,
  ) async {
    final file = File(replayPath);
    if (!file.existsSync()) {
      stderr.writeln('Error: Replay file not found: $replayPath');
      exit(1);
    }

    final fullPath = file.absolute.path;
    final outputBuffer = StringBuffer();
    
    void log(String message) {
      outputBuffer.writeln(message);
    }

    log('Test Mode: $fullPath');
    log('Started: ${DateTime.now().toIso8601String()}');
    log('');

    d4rt.execute(source: initSource);

    final state = createReplState();
    state.currentDirectory = Directory.current.path;

    // Clear any previous verification failures and error reporter
    clearVerificationFailures();
    ErrorReporter.clear();

    var hasErrors = false;
    var lineCount = 0;
    
    try {
      // Run replay silently, capturing output
      lineCount = await _replayFile(d4rt, state, fullPath, silent: true);
      log('Lines executed: $lineCount');
    } catch (e, stackTrace) {
      hasErrors = true;
      log('ERROR: $e');
      if (Platform.environment['DEBUG'] == 'true') {
        log(stackTrace.toString());
      }
    }

    // Revoke benign internal errors that are known to occur during replay
    _revokeBenignTestErrors();

    // Check for reported TomExceptions during execution
    if (ErrorReporter.hasErrors) {
      hasErrors = true;
      log('');
      
      // Use detailed report if DEBUG mode is enabled, otherwise use short report
      if (Platform.environment['DEBUG'] == 'true') {
        log('REPORTED ERRORS (${ErrorReporter.errors.length}) WITH STACK TRACES:');
        log(ErrorReporter.report);
      } else {
        log('REPORTED ERRORS (${ErrorReporter.errors.length}):');
        for (final error in ErrorReporter.errors) {
          log('  - $error');
        }
        log('');
        log('(Set DEBUG=true environment variable to see stack traces)');
      }
    }

    // Check for verification failures from verify() calls
    final failures = verificationFailures;
    if (failures.isNotEmpty) {
      hasErrors = true;
      log('');
      log('VERIFICATION FAILURES (${failures.length}):');
      for (final failure in failures) {
        log('  - $failure');
      }
    }

    log('');
    log('Result: ${hasErrors ? 'FAILED' : 'PASSED'}');
    log('Completed: ${DateTime.now().toIso8601String()}');

    // Output results
    final output = outputBuffer.toString();
    if (outputPath != null) {
      final outputFile = File(outputPath);
      outputFile.writeAsStringSync(output);
      print('Test output written to: $outputPath');
      print(hasErrors ? 'Result: FAILED' : 'Result: PASSED');
    } else {
      print(output);
    }

    exit(hasErrors ? 1 : 0);
  }

  /// Revokes known benign errors that can occur during replay execution.
  ///
  /// These errors are internal to interpreter operations and do not represent
  /// actual test failures. We keep this scoped to test mode only.
  void _revokeBenignTestErrors() {
    final errors = ErrorReporter.errors.toList();
    for (final error in errors) {
      if (_isBenignTestError(error)) {
        error.revoke();
      }
    }
  }

  bool _isBenignTestError(D4rtException error) {
    final message = error.message;
    if (message == 'Undefined variable: this') {
      return true;
    }
    if (message.startsWith('Cannot bridge native object: No registered bridged class found for native type Interpreted')) {
      return true;
    }
    return false;
  }
  
  /// Run the interactive REPL.
  Future<void> _runRepl(
    D4rt d4rt, {
    String? sessionId, 
    bool replaceSession = false, 
    String? replayFile,
  }) async {
    final state = createReplState();
    state.currentSessionId = sessionId;
    
    // Set the data directory for persistent storage (history, defines)
    setDataDirectory(state.dataDirectory);
    
    // Verify the data directory exists or can be created
    final dataDir = Directory(state.dataDirectory);
    try {
      if (!dataDir.existsSync()) {
        dataDir.createSync(recursive: true);
      }
    } catch (e) {
      stderr.writeln('Error: $dataDirectoryShort is not accessible and cannot be created.');
      stderr.writeln('Please ensure you have write permissions to ${dataDir.parent.path}');
      exit(1);
    }
    
    // Load and truncate persistent history at startup
    truncateHistoryIfNeeded();
    final historyLines = loadHistory();
    state.console.loadHistoryIntoScrollback(historyLines);
    
    // Load user-defined command aliases
    loadDefines();
    
    // Print compact banner and quick reference
    print(getVersionBanner());
    print('');
    print('<cyan>**Quick Start**</cyan>');
    print('  <yellow>**help**</yellow> for detailed commands');
    print('  <yellow>**info**</yellow> <name> for symbol details');
    print('  <yellow>**exit**</yellow>/<yellow>**quit**</yellow> to exit');
    print('  <yellow>**.start-script**</yellow> / <yellow>**.end**</yellow> for multiline (or use \\ at line end)');
    print('');
    print('<cyan>**Essential Commands**</cyan>');
    print('  <yellow>**classes**</yellow>/<yellow>**enums**</yellow>/<yellow>**methods**</yellow>/<yellow>**variables**</yellow> [q] - List symbols (q=filter, "q"=case, q*=starts)');
    print('  <yellow>**ls**</yellow>/<yellow>**cd**</yellow>/<yellow>**cwd**</yellow> - Navigate directories');
    print('  <yellow>**.file**</yellow>/<yellow>**execute**</yellow>/<yellow>**script**</yellow> - Run files');
    print('  <yellow>**define**</yellow> <n>=<t> - Create aliases | <yellow>**\$<n>**</yellow> - Invoke alias');
    print('');

    // Initialize CLI controller for the `cli` global variable
    _cliIntegration.initialize(d4rt, state, toolName: toolName);

    // Tool-specific startup (e.g., VS Code integration check)
    await onReplStartup(d4rt, state);

    // Handle -replay option first (before session)
    if (replayFile != null) {
      final file = File(replayFile);
      if (file.existsSync()) {
        print('Replaying file: $replayFile');
        try {
          final replayedLines = await _replayFile(d4rt, state, replayFile, silent: true);
          print('Replayed $replayedLines lines.');
        } catch (e) {
          stderr.writeln('Warning: Failed to replay file: $e');
        }
      } else {
        stderr.writeln('Warning: Replay file not found: $replayFile');
      }
    }

    // Handle session file
    File? sessionFileHandle;
    if (sessionId != null) {
      final sessionDir = Directory(state.dataDirectory);
      if (!sessionDir.existsSync()) {
        sessionDir.createSync(recursive: true);
      }
      
      sessionFileHandle = File('${sessionDir.path}/$sessionId.session.txt');
      
      // Check for old format and migrate if needed
      final oldFormatFile = File('${sessionDir.path}/$sessionId.txt');
      if (oldFormatFile.existsSync() && !sessionFileHandle.existsSync()) {
        oldFormatFile.renameSync(sessionFileHandle.path);
        print('Migrated session file to new format.');
      } else if (oldFormatFile.existsSync()) {
        oldFormatFile.deleteSync();
      }

      if (replaceSession && sessionFileHandle.existsSync()) {
        sessionFileHandle.deleteSync();
        print('Deleted existing session: $sessionId');
      }

      if (sessionFileHandle.existsSync()) {
        print('Replaying session...');
        try {
          final replayedLines = await _replayFile(d4rt, state, sessionFileHandle.path, silent: true);
          print('Restored $replayedLines lines from session.');
        } catch (e) {
          if (e is D4rtException) {
            e.revoke();
          }
          stderr.writeln('Warning: Failed to replay session: $e');
        }
        print('');
      } else {
        print('Starting new session: $sessionId');
        print('');
      }

      try {
        state.sessionFile = sessionFileHandle.openSync(mode: FileMode.append);
      } catch (e) {
        stderr.writeln('Warning: Could not open session file for writing: $e');
      }
    }

    // Set up signal handlers
    final signalSubscriptions = <StreamSubscription<ProcessSignal>>[];
    
    void cleanShutdown(String signalName) {
      state.writeSuccess('Goodbye!');
      state.closeSession();
      exit(0);
    }
    
    signalSubscriptions.add(
      ProcessSignal.sigint.watch().listen((_) {
        if (!state.interruptAwait()) {
          cleanShutdown('SIGINT');
        } else if (state.isAwaitingFuture) {
          print('');
          state.writeMuted('(interrupted - press ^C again to exit)');
        } else {
          print('');
          state.writeMuted('(press ^C again to exit)');
          state.writePrompt();
        }
      })
    );
    
    if (!Platform.isWindows) {
      signalSubscriptions.add(
        ProcessSignal.sigterm.watch().listen((_) => cleanShutdown('SIGTERM'))
      );
    }

    await runZonedGuarded(() async {
      try {
        final continuationBuffer = StringBuffer();
        
        while (true) {
          final inContinuation = continuationBuffer.isNotEmpty;
          if (inContinuation) {
            state.writeContinuationPrompt();
          } else {
            state.writePrompt(multiline: state.multilineMode != MultilineMode.none);
          }
          
          String? input;
          try {
            input = state.console.readLine(cancelOnBreak: true);
          } catch (e) {
            state.writeError('Input error: $e');
            print('');
            state.writeError('Unable to read input. Exiting REPL.');
            break;
          }

          if (input == null ||
              input.trim() == 'exit' ||
              input.trim() == 'quit') {
            state.writeSuccess('Goodbye!');
            break;
          }
          
          if (input.trimRight().endsWith('\\')) {
            final lineWithoutBackslash = input.trimRight();
            continuationBuffer.write(lineWithoutBackslash.substring(0, lineWithoutBackslash.length - 1));
            continue;
          }
          
          String fullInput;
          if (continuationBuffer.isNotEmpty) {
            continuationBuffer.write(input);
            fullInput = continuationBuffer.toString();
            continuationBuffer.clear();
          } else {
            fullInput = input;
          }

          state.recordInput(fullInput);
          appendToHistory(fullInput);

          bool shouldContinue = true;
          try {
            shouldContinue = await processInput(d4rt, state, fullInput);
          } catch (e, stackTrace) {
            _handleReplError(state, e, stackTrace);
            shouldContinue = true;
          }
          
          if (!shouldContinue) {
            break;
          }
        }
      } finally {
        state.closeSession();
        for (final sub in signalSubscriptions) {
          sub.cancel();
        }
      }
    }, (error, stackTrace) {
      _handleReplError(state, error, stackTrace);
    });

    exit(0);
  }

  /// Handle errors in the REPL gracefully
  void _handleReplError(ReplState state, Object error, StackTrace stackTrace) {
    state.writeError('$error');
    if (Platform.environment['DEBUG'] == 'true') {
      state.writeMuted(stackTrace.toString());
    }
  }
  
  /// Process a single line of input. Returns false if the REPL should exit.
  Future<bool> processInput(
    D4rt d4rt,
    ReplState state,
    String input, {
    bool silent = false,
  }) async {
    if (input.trim().isEmpty) {
      if (state.multilineMode != MultilineMode.none) {
        state.multilineBuffer.add('');
      }
      return true;
    }

    final line = input.trim();

    // Skip comment lines
    if (line.startsWith('#') || line.startsWith('//')) {
      return true;
    }

    // Handle multiline mode
    if (state.multilineMode != MultilineMode.none) {
      return _handleMultilineInput(d4rt, state, input, line, silent);
    }

    // Check for additional commands from extended tools first
    if (await handleAdditionalCommands(d4rt, state, line, silent: silent)) {
      return true;
    }

    // Handle standard commands
    return _handleStandardCommands(d4rt, state, line, input, silent);
  }
  
  /// Handle multiline input mode
  Future<bool> _handleMultilineInput(
    D4rt d4rt,
    ReplState state,
    String input,
    String line,
    bool silent,
  ) async {
    if (line == '.end') {
      final code = state.multilineBuffer.join('\n');
      final currentMode = state.multilineMode;
      state.multilineBuffer.clear();
      state.multilineMode = MultilineMode.none;

      if (code.trim().isEmpty) {
        if (!silent) print('(empty script)');
        return true;
      }

      try {
        switch (currentMode) {
          case MultilineMode.file:
            final result = d4rt.continuedExecute(source: code);
            if (result != null && !silent) {
              printResult(result);
            }
            break;
          case MultilineMode.executeNew:
            // Create a fresh D4rt instance for isolated execution
            // This ensures the main REPL's environment (bridges, etc.) is preserved
            final freshD4rt = D4rt();
            freshD4rt.grant(FilesystemPermission.any);
            freshD4rt.grant(NetworkPermission.any);
            freshD4rt.grant(ProcessRunPermission.any);
            freshD4rt.grant(IsolatePermission.any);
            freshD4rt.grant(DangerousPermission.any);
            registerBridges(freshD4rt);
            final result = freshD4rt.execute(source: code);
            if (result != null && !silent) {
              printResult(result);
            }
            break;
          case MultilineMode.define:
            d4rt.eval(code);
            if (!silent) print('(defined)');
            break;
          case MultilineMode.script:
            final containsAwait = RegExp(r'\bawait\b').hasMatch(code);
            dynamic result;
            if (containsAwait) {
              final wrapperCode = '''
Future<Object?> __repl_multiline__() async {
$code
}
''';
              d4rt.eval(wrapperCode);
              final futureResult = d4rt.eval('__repl_multiline__()');
              result = futureResult is Future ? await futureResult : futureResult;
            } else {
              final wrapperCode = '''
Object? __repl_multiline__() {
$code
}
''';
              d4rt.eval(wrapperCode);
              final rawResult = d4rt.eval('__repl_multiline__()');
              result = rawResult is Future ? await rawResult : rawResult;
            }
            if (result != null && !silent) {
              printResult(result);
            }
            break;
          case MultilineMode.none:
            break;
          default:
            // Allow derived classes to handle custom multiline modes
            final handled = await handleAdditionalMultilineEnd(
              d4rt, state, currentMode, code, silent: silent,
            );
            if (!handled && !silent) {
              state.writeWarning('Unknown multiline mode: $currentMode');
            }
            break;
        }
      } catch (e) {
        state.writeError('$e');
      }
      return true;
    }

    state.multilineBuffer.add(input);
    return true;
  }
  
  /// Handle standard REPL commands
  Future<bool> _handleStandardCommands(
    D4rt d4rt,
    ReplState state,
    String line,
    String input,
    bool silent,
  ) async {
    // Help command
    if (line == 'help') {
      if (!silent) printReplHelp(d4rt);
      return true;
    }

    // Define commands
    if (line.startsWith('define ')) {
      return _handleDefineCommand(state, line, silent);
    }

    if (line.startsWith('undefine ')) {
      final name = line.substring(9).trim();
      if (removeDefine(name)) {
        if (!silent) state.writeSuccess('Removed define: $name');
      } else {
        if (!silent) state.writeError('Define not found: $name');
      }
      return true;
    }

    if (line.startsWith('.load-defines ')) {
      final path = line.substring(14).trim();
      if (path.isEmpty) {
        if (!silent) state.writeError('.load-defines requires a file path');
        return true;
      }
      final resolvedPath = _resolveFilePath(state, path, '.define.txt');
      final count = loadDefinesFromFile(resolvedPath);
      if (count < 0) {
        if (!silent) state.writeError('File not found: $resolvedPath');
      } else {
        if (!silent) state.writeSuccess('Loaded $count defines from: $resolvedPath');
      }
      return true;
    }

    if (line == 'defines' || line.startsWith('defines ')) {
      if (!silent) {
        final filter = line.length > 7 ? line.substring(7).trim() : '';
        final defines = getDefines();
        final matcher = _parseSearchFilter(filter);
        final filtered = matcher == null 
            ? defines.entries.toList() 
            : defines.entries.where((e) => matcher(e.key)).toList();
        if (filtered.isEmpty) {
          if (matcher == null) {
            print('No defines. Use: define <name>=<template>');
          } else {
            print('No defines matching: $filter');
          }
        } else {
          print('Defines (${filtered.length}):');
          for (final entry in filtered) {
            print('  \$${entry.key} = ${entry.value}');
          }
        }
      }
      return true;
    }

    // Expand $define invocations
    if (line.startsWith(r'$')) {
      final expanded = tryExpandDefine(line);
      if (expanded != null) {
        if (!silent) {
          state.writeMuted('→ $expanded');
        }
        return processInput(d4rt, state, expanded, silent: silent);
      }
    }

    if (line == 'info' || line.startsWith('info ')) {
      if (!silent) _printInfo(d4rt, state, line);
      return true;
    }

    // Environment state commands
    if (line == 'classes' || line.startsWith('classes ')) {
      if (!silent) {
        final filter = line.length > 7 ? line.substring(7).trim() : '';
        _printEnvironmentClasses(d4rt, state, filter);
      }
      return true;
    }

    if (line == 'enums' || line.startsWith('enums ')) {
      if (!silent) {
        final filter = line.length > 5 ? line.substring(5).trim() : '';
        _printEnvironmentEnums(d4rt, state, filter);
      }
      return true;
    }

    if (line == 'methods' || line.startsWith('methods ')) {
      if (!silent) {
        final filter = line.length > 7 ? line.substring(7).trim() : '';
        _printEnvironmentMethods(d4rt, state, filter);
      }
      return true;
    }

    if (line == 'variables' || line.startsWith('variables ')) {
      if (!silent) {
        final filter = line.length > 9 ? line.substring(9).trim() : '';
        _printEnvironmentVariables(d4rt, state, filter);
      }
      return true;
    }

    if (line == 'imports') {
      if (!silent) _printEnvironmentImports(d4rt, state);
      return true;
    }

    // Registered bridge commands
    if (line == 'registered-classes' || line.startsWith('registered-classes ')) {
      if (!silent) {
        final filter = line.length > 18 ? line.substring(18).trim() : '';
        _printClasses(d4rt, state, filter);
      }
      return true;
    }

    if (line == 'registered-enums' || line.startsWith('registered-enums ')) {
      if (!silent) {
        final filter = line.length > 16 ? line.substring(16).trim() : '';
        _printEnums(d4rt, state, filter);
      }
      return true;
    }

    if (line == 'registered-methods' || line.startsWith('registered-methods ')) {
      if (!silent) {
        final filter = line.length > 18 ? line.substring(18).trim() : '';
        _printGlobalMethods(d4rt, state, filter);
      }
      return true;
    }

    if (line == 'registered-variables' || line.startsWith('registered-variables ')) {
      if (!silent) {
        final filter = line.length > 20 ? line.substring(20).trim() : '';
        _printGlobalVariables(d4rt, state, filter);
      }
      return true;
    }

    if (line == 'registered-imports') {
      if (!silent) _printImports(d4rt, state);
      return true;
    }

    if (line == 'show-init' || line == 'show-initialization') {
      if (!silent) {
        print('=== D4rt Initialization Source ===');
        print(getImportBlock());
        print('void main() {}');
        print('==================================');
      }
      return true;
    }

    if (line == 'clear') {
      if (!silent) state.clearScreen();
      return true;
    }

    // Directory commands
    if (line == 'sessions') {
      if (!silent) _listSessionIds(state);
      return true;
    }

    if (line == 'scripts') {
      if (!silent) _listFilesByPattern(state, state.currentDirectory, '.script.txt');
      return true;
    }

    if (line == 'plays') {
      if (!silent) _listFilesByPatterns(state, state.currentDirectory, replayFilePatterns);
      return true;
    }

    if (line == 'executes') {
      if (!silent) _listFilesByPattern(state, state.currentDirectory, '.exec.dart');
      return true;
    }

    if (line == 'ls') {
      if (!silent) _listDirectory(state, state.currentDirectory);
      return true;
    }

    if (line == 'home') {
      state.currentDirectory = state.dataDirectory;
      if (!silent) print(state.currentDirectory);
      return true;
    }

    if (line.startsWith('cd ')) {
      final path = line.substring(3).trim();
      if (!silent) {
        final result = _changeDirectory(state, path);
        print(result);
      }
      return true;
    }

    if (line == 'cd') {
      if (!silent) print(state.currentDirectory);
      return true;
    }

    if (line == 'cwd') {
      if (!silent) print(state.currentDirectory);
      return true;
    }

    // Multiline commands
    if (line == '.start-define') {
      state.multilineMode = MultilineMode.define;
      if (!silent) {
        print('(entering define mode - type .end to add to global environment)');
      }
      return true;
    }

    if (line == '.start-script') {
      state.multilineMode = MultilineMode.script;
      if (!silent) print('(entering script mode - type .end to run with return value)');
      return true;
    }

    if (line == '.start-file') {
      state.multilineMode = MultilineMode.file;
      if (!silent) {
        print('(entering file mode - type .end to run in current environment)');
      }
      return true;
    }

    if (line == '.start-execute') {
      state.multilineMode = MultilineMode.executeNew;
      if (!silent) {
        print('(entering execute mode - type .end to run as fresh program)');
      }
      return true;
    }

    // File commands
    if (line.startsWith('.execute ')) {
      final name = line.substring(9).trim();
      final filename = _resolveFilePath(state, name, '.dart');
      await _executeFileNew(d4rt, filename, silent: silent);
      return true;
    }

    if (line.startsWith('.file ')) {
      final name = line.substring(6).trim();
      final filename = _resolveFilePath(state, name, '.exec.dart');
      await _executeFile(d4rt, filename, silent: silent);
      return true;
    }
    
    // Inline execution commands - handle space, newline, or multiple newlines after command
    final execMatch = RegExp(r'^exec[\s\n]+(.+)$', dotAll: true).firstMatch(line);
    if (execMatch != null) {
      final code = execMatch.group(1)!;
      if (code.trim().isEmpty) {
        if (!silent) state.writeError('exec requires code to execute');
        return true;
      }
      await _executeCodeInNewInstance(d4rt, state, code, silent: silent);
      return true;
    }
    
    final expMatch = RegExp(r'^exp[\s\n]+(.+)$', dotAll: true).firstMatch(line);
    if (expMatch != null) {
      final expression = expMatch.group(1)!;
      if (expression.trim().isEmpty) {
        if (!silent) state.writeError('exp requires an expression to evaluate');
        return true;
      }
      await _executeCode(d4rt, state, expression, silent);
      return true;
    }

    if (line.startsWith('.script ')) {
      final name = line.substring(8).trim();
      final filename = _resolveFilePath(state, name, '.script.txt');
      await _loadScript(d4rt, filename, silent: silent);
      return true;
    }

    if (line.startsWith('.load ')) {
      final name = line.substring(6).trim();
      final filename = _resolveFilePath(state, name, '.replay.txt');
      await _replayFile(d4rt, state, filename, silent: silent);
      return true;
    }

    if (line.startsWith('.replay ')) {
      final name = line.substring(8).trim();
      final filename = _resolveFilePath(state, name, '.replay.txt');
      await _replayFile(d4rt, state, filename, silent: true);
      if (!silent) print('(replayed $filename)');
      return true;
    }

    if (line.startsWith('.session ')) {
      return _handleSessionCommand(d4rt, state, line, silent);
    }

    if (line == '.reset' || line.startsWith('.reset ')) {
      return _handleResetCommand(d4rt, state, line, silent);
    }

    // Print file commands
    if (line.startsWith('.print-session ')) {
      final name = line.substring(15).trim();
      final sessionDir = state.dataDirectory;
      final filename = '$sessionDir/$name.session.txt';
      if (!silent) _printFileContents(state, filename, 'Session');
      return true;
    }

    if (line.startsWith('.print-script ')) {
      final name = line.substring(14).trim();
      final filename = _resolveFilePath(state, name, '.script.txt');
      if (!silent) _printFileContents(state, filename, 'Script');
      return true;
    }

    if (line.startsWith('.print-file ')) {
      final name = line.substring(12).trim();
      final filename = _resolveFilePath(state, name, '.exec.dart');
      if (!silent) _printFileContents(state, filename, 'File');
      return true;
    }

    if (line.startsWith('.print-replay ')) {
      final name = line.substring(14).trim();
      final filename = _resolveFilePath(state, name, '.replay.txt');
      if (!silent) _printFileContents(state, filename, 'Replay');
      return true;
    }

    // Execute D4rt code
    return _executeCode(d4rt, state, line, silent);
  }
  
  bool _handleDefineCommand(ReplState state, String line, bool silent) {
    final definition = line.substring(7);
    final eqIndex = definition.indexOf('=');
    if (eqIndex <= 0) {
      if (!silent) state.writeError('Invalid define syntax. Use: define <name>=<template>');
      return true;
    }
    final name = definition.substring(0, eqIndex).trim();
    final template = definition.substring(eqIndex + 1);
    if (name.isEmpty) {
      if (!silent) state.writeError('Define name cannot be empty');
      return true;
    }
    if (!RegExp(r'^[a-zA-Z_][a-zA-Z0-9_]*$').hasMatch(name)) {
      if (!silent) state.writeError('Invalid define name: must be a valid identifier');
      return true;
    }
    setDefine(name, template);
    if (!silent) state.writeSuccess('Defined: \$$name');
    return true;
  }
  
  Future<bool> _handleSessionCommand(D4rt d4rt, ReplState state, String line, bool silent) async {
    final sessionName = line.substring(9).trim();
    if (sessionName.isEmpty) {
      if (!silent) state.writeError('.session requires a session name');
      return true;
    }
    
    state.closeSession();
    d4rt.execute(source: 'void main() {}');
    
    state.currentSessionId = sessionName;
    final sessionDir = Directory(state.dataDirectory);
    if (!sessionDir.existsSync()) {
      sessionDir.createSync(recursive: true);
    }
    final sessionFile = File('${sessionDir.path}/$sessionName.session.txt');
    
    if (sessionFile.existsSync()) {
      if (!silent) state.writeMuted('Switching to session: $sessionName');
      try {
        final replayedLines = await _replayFile(d4rt, state, sessionFile.path, silent: true);
        if (!silent) state.writeMuted('Restored $replayedLines lines from session.');
      } catch (e) {
        if (!silent) state.writeWarning('Failed to replay session: $e');
      }
    } else {
      if (!silent) state.writeMuted('Starting new session: $sessionName');
    }
    
    try {
      state.sessionFile = sessionFile.openSync(mode: FileMode.append);
    } catch (e) {
      if (!silent) state.writeWarning('Could not open session file: $e');
    }
    return true;
  }
  
  Future<bool> _handleResetCommand(D4rt d4rt, ReplState state, String line, bool silent) async {
    final name = line.length > 6 ? line.substring(7).trim() : '';
    
    d4rt.execute(source: 'void main() {}');
    if (!silent) state.writeMuted('D4rt environment reset.');
    
    if (name.isNotEmpty) {
      final sessionFile = File('${state.dataDirectory}/$name.session.txt');
      if (sessionFile.existsSync()) {
        try {
          final replayedLines = await _replayFile(d4rt, state, sessionFile.path, silent: true);
          if (!silent) state.writeMuted('Replayed $replayedLines lines from session: $name');
        } catch (e) {
          if (e is D4rtException) {
            e.revoke();
          }
          if (!silent) state.writeWarning('Failed to replay: $e');
        }
      } else {
        final replayFilePath = _resolveFilePath(state, name, '.replay.txt');
        final file = File(replayFilePath);
        if (file.existsSync()) {
          try {
            final replayedLines = await _replayFile(d4rt, state, replayFilePath, silent: true);
            if (!silent) state.writeMuted('Replayed $replayedLines lines from: $replayFilePath');
          } catch (e) {
            if (e is D4rtException) {
              e.revoke();
            }
            if (!silent) state.writeWarning('Failed to replay: $e');
          }
        } else {
          if (!silent) state.writeError('File not found: $name');
        }
      }
    }
    return true;
  }
  
  Future<bool> _executeCode(D4rt d4rt, ReplState state, String line, bool silent) async {
    try {
      dynamic result;
      var executed = false;

      if (!line.contains(';') ||
          line.endsWith(';') && !RegExp(r';\s*\S').hasMatch(line)) {
        final expr = line.endsWith(';') ? line.substring(0, line.length - 1).trim() : line;
        if (expr.isNotEmpty) {
          try {
            // Disable error tracking during speculative expression parsing
            ErrorReporter.disableTracking();
            
            final hasAwait = expr.startsWith('await ') || expr.contains(' await ');
            
            final wrapperCode = hasAwait ? '''
Future<Object?> __repl_expr__() async {
  return $expr;
}
''' : '''
Object? __repl_expr__() {
  return $expr;
}
''';
            d4rt.eval(wrapperCode);
            var rawResult = d4rt.eval('__repl_expr__()');
            
            // Re-enable tracking before awaiting (in case the future throws)
            ErrorReporter.enableTracking();
            
            if (rawResult is Future) {
              state.startAwait();
              try {
                result = await Future.any([rawResult, state.interruptFuture]);
              } on InterruptedException {
                return true;
              } finally {
                state.endAwait();
              }
            } else {
              result = rawResult;
            }
            executed = true;
          } catch (e) {
            // Re-enable tracking in case it was still disabled
            ErrorReporter.enableTracking();
            
            // If expression parsing fails, we'll try as a statement next
            // Don't rethrow unless it's an await expression
            if (expr.startsWith('await ')) {
              rethrow;
            }
            // Otherwise suppress the error and continue to try as statement
          }
        }
      }

      if (!executed) {
        var rawResult = d4rt.eval(line);
        if (rawResult is Future) {
          state.startAwait();
          try {
            result = await Future.any([rawResult, state.interruptFuture]);
          } on InterruptedException {
            return true;
          } finally {
            state.endAwait();
          }
        } else {
          result = rawResult;
        }
      }

      if (result != null && !silent) {
        printResult(result);
      }
    } catch (e) {
      if (!silent) state.writeError('$e');
    }

    return true;
  }
  
  // Helper methods
  
  String _resolveFilePath(ReplState state, String name, String defaultExtension) {
    String path = name;

    if (!path.startsWith('/') && !path.startsWith('~')) {
      if (!path.contains('/')) {
        path = '${state.currentDirectory}/$path';
      } else {
        path = '${state.currentDirectory}/$path';
      }
    } else if (path.startsWith('~/')) {
      path = '${Platform.environment['HOME']}${path.substring(1)}';
    }

    final filename = path.split('/').last;
    if (!filename.contains('.')) {
      path = '$path$defaultExtension';
    }

    return path;
  }
  
  void _listSessionIds(ReplState state) {
    final sessionDir = Directory(state.dataDirectory);
    if (!sessionDir.existsSync()) {
      print('No sessions found.');
      return;
    }

    final sessionIds = sessionDir
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.session.txt'))
        .map((f) => f.uri.pathSegments.last.replaceAll('.session.txt', ''))
        .toList()
      ..sort();

    if (sessionIds.isEmpty) {
      print('No sessions found.');
      return;
    }

    state.printTabulated(sessionIds);
  }

  void _listFilesByPattern(ReplState state, String dirPath, String suffix) {
    _listFilesByPatterns(state, dirPath, [suffix]);
  }
  
  void _listFilesByPatterns(ReplState state, String dirPath, List<String> suffixes) {
    final dir = Directory(dirPath);
    if (!dir.existsSync()) {
      state.writeError('Directory not found: $dirPath');
      return;
    }

    final names = dir
        .listSync()
        .whereType<File>()
        .where((f) => suffixes.any((suffix) => f.path.endsWith(suffix)))
        .map((f) {
          final filename = f.uri.pathSegments.last;
          // Remove any matching suffix to get the base name
          for (final suffix in suffixes) {
            if (filename.endsWith(suffix)) {
              return filename.replaceAll(suffix, '');
            }
          }
          return filename;
        })
        .toSet() // Remove duplicates if same base name with different extensions
        .toList()
      ..sort();

    if (names.isEmpty) {
      state.writeMuted('No files matching ${suffixes.map((s) => '*$s').join(', ')} found.');
      return;
    }

    state.printTabulated(names);
  }

  void _listDirectory(ReplState state, String dirPath) {
    final dir = Directory(dirPath);
    if (!dir.existsSync()) {
      state.writeError('Directory not found: $dirPath');
      return;
    }

    final entries = dir.listSync()
      ..sort((a, b) => a.path.compareTo(b.path));

    if (entries.isEmpty) {
      state.writeMuted('Empty directory.');
      return;
    }

    final names = entries.map((e) {
      final name = p.basename(e.path);
      return e is Directory ? '$name/' : name;
    }).toList();

    state.printTabulated(names);
  }

  String _changeDirectory(ReplState state, String path) {
    String newPath;

    if (path == '~') {
      newPath = Platform.environment['HOME'] ?? '/';
    } else if (path.startsWith('~/')) {
      newPath = '${Platform.environment['HOME']}${path.substring(1)}';
    } else if (path == '-') {
      newPath = state.dataDirectory;
    } else if (path.startsWith('/')) {
      newPath = path;
    } else {
      newPath = '${state.currentDirectory}/$path';
    }

    // Normalize the path to resolve . and .. components
    newPath = p.normalize(newPath);

    final dir = Directory(newPath);
    try {
      if (!dir.existsSync()) {
        return 'Error: Directory not found: $path';
      }
      state.currentDirectory = newPath;
      return newPath;
    } catch (e) {
      return 'Error: Invalid path: $path';
    }
  }

  void _printFileContents(ReplState state, String filename, String fileType) {
    final file = File(filename);
    if (!file.existsSync()) {
      state.writeError('$fileType file not found: $filename');
      return;
    }

    final contents = file.readAsStringSync();
    final lineCount = contents.split('\n').length;
    
    print('=== $fileType: $filename ($lineCount lines) ===');
    print(contents);
    print('=== End of $fileType ===');
  }

  Future<int> _replayFile(
    D4rt d4rt,
    ReplState state,
    String filename, {
    bool silent = false,
  }) async {
    final file = File(filename);
    final fullPath = file.absolute.path;
    if (!file.existsSync()) {
      stderr.writeln('Error: File not found: $fullPath');
      return 0;
    }

    final savedDirectory = state.currentDirectory;
    final fileDirectory = File(fullPath).parent.path;
    state.currentDirectory = fileDirectory;

    final lines = await file.readAsLines();
    var count = 0;

    for (var i = 0; i < lines.length; i++) {
      final line = lines[i];
      try {
        await processInput(d4rt, state, line, silent: silent);
      } catch (e) {
        final lineNum = i + 1;
        throw RuntimeD4rtException('Error on replay line $lineNum: "$line"\nDetails: $e');
      }
      count++;
    }

    state.currentDirectory = savedDirectory;

    if (!silent) {
      print('Loaded $count lines from: $fullPath');
    }

    return count;
  }

  Future<void> _executeFile(D4rt d4rt, String filename, {bool silent = false}) async {
    final file = File(filename);
    final fullPath = file.absolute.path;
    if (!file.existsSync()) {
      stderr.writeln('Error: File not found: $fullPath');
      return;
    }

    try {
      if (!silent) {
        final scriptName = file.uri.pathSegments.last;
        final separator = '━' * 60;
        print('');
        print('<green>$separator</green>');
        print('<green>▶</green> **$scriptName**');
        print('  <yellow>$fullPath</yellow>');
        print('<green>$separator</green>');
        print('');
      }
      final result = executeFileContinued(
        d4rt,
        fullPath,
        log: silent ? null : (msg) => print('  $msg'),
      );
      if (result.success) {
        if (result.result != null && !silent) {
          var finalResult = result.result;
          if (finalResult is Future) {
            finalResult = await finalResult;
          }
          if (finalResult != null) {
            printResult(finalResult);
          }
        }
      } else {
        stderr.writeln('<red>Error:</red> ${result.error}');
      }
    } catch (e) {
      stderr.writeln('<red>Error:</red> $e');
    }
  }

  Future<void> _executeFileNew(D4rt d4rt, String filename, {bool silent = false}) async {
    final file = File(filename);
    final fullPath = file.absolute.path;
    if (!file.existsSync()) {
      stderr.writeln('Error: File not found: $fullPath');
      return;
    }

    try {
      if (!silent) {
        final scriptName = file.uri.pathSegments.last;
        final separator = '━' * 60;
        print('');
        print('<green>$separator</green>');
        print('<green>▶</green> **$scriptName**');
        print('  <yellow>$fullPath</yellow>');
        print('<green>$separator</green>');
        print('');
      }
      final result = executeFile(
        d4rt,
        fullPath,
        log: silent ? null : (msg) => print('  $msg'),
      );
      if (result.success) {
        if (result.result != null && !silent) {
          var finalResult = result.result;
          if (finalResult is Future) {
            finalResult = await finalResult;
          }
          if (finalResult != null) {
            printResult(finalResult);
          }
        }
      } else {
        stderr.writeln('<red>Error:</red> ${result.error}');
      }
    } catch (e) {
      stderr.writeln('<red>Error:</red> $e');
    }
  }
  
  /// Execute code in a new D4rt instance (isolated from current REPL state).
  Future<void> _executeCodeInNewInstance(
    D4rt d4rt, 
    ReplState state, 
    String code, 
    {bool silent = false}
  ) async {
    try {
      // Create a fresh D4rt instance for isolated execution
      final freshD4rt = D4rt();
      freshD4rt.grant(FilesystemPermission.any);
      freshD4rt.grant(NetworkPermission.any);
      freshD4rt.grant(ProcessRunPermission.any);
      freshD4rt.grant(IsolatePermission.any);
      freshD4rt.grant(DangerousPermission.any);
      registerBridges(freshD4rt);
      
      // Combine all imports (stdlib + registered bridges) with user code
      // This allows scripts to use all available classes without explicit imports
      final imports = getImportBlock();
      final fullSource = '$imports\n$code';
      
      // Execute the complete program
      var result = freshD4rt.execute(source: fullSource);
      if (result is Future) {
        result = await result;
      }
      if (result != null && !silent) {
        printResult(result);
      }
    } catch (e) {
      stderr.writeln('<red>Error:</red> $e');
    }
  }

  Future<void> _loadScript(D4rt d4rt, String filename, {bool silent = false}) async {
    final file = File(filename);
    final fullPath = file.absolute.path;
    if (!file.existsSync()) {
      stderr.writeln('Error: File not found: $fullPath');
      return;
    }

    try {
      final lines = await file.readAsLines();
      if (!silent) print('Loading script: $fullPath (${lines.length} lines)');

      for (var i = 0; i < lines.length; i++) {
        final line = lines[i].trim();
        if (line.isEmpty || line.startsWith('//')) {
          continue;
        }

        if (!silent) print('[$i] $line');
        try {
          final result = d4rt.eval(line);
          if (result != null && !silent) {
            print('    => $result');
          }
        } catch (e) {
          stderr.writeln('    Error: $e');
        }
      }
      if (!silent) print('Script loaded.');
    } catch (e) {
      stderr.writeln('Error reading file: $e');
    }
  }
  
  // Info and listing methods (stubs - implemented in extended class or kept simple)
  
  /// Extract package name from import path.
  /// e.g., 'package:tom_core_kernel/tom_core_kernel.dart' -> 'tom_core_kernel'
  String _extractPackageName(String importPath) {
    if (importPath.startsWith('package:')) {
      final parts = importPath.substring(8).split('/');
      return parts.first;
    }
    return importPath.split('/').last.replaceAll('.dart', '');
  }
  
  /// Get sorted list of unique package names from D4rt configuration.
  List<String> getPackageNames(D4rt d4rt) {
    final config = d4rt.getConfiguration();
    final packages = config.imports
        .map((i) => _extractPackageName(i.importPath))
        .toSet()
        .toList()
      ..sort();
    return packages;
  }
  
  /// Format package info for display (used by info command and bridges help).
  void _printPackageInfo(D4rtConfiguration config, String packageName, ReplState state) {
    // Find matching import(s)
    final matchingImports = config.imports
        .where((i) => _extractPackageName(i.importPath) == packageName)
        .toList();
    
    if (matchingImports.isEmpty) {
      state.writeMuted('No package found matching: $packageName');
      print('');
      print('Available packages:');
      final packages = config.imports.map((i) => _extractPackageName(i.importPath)).toSet().toList()..sort();
      for (final pkg in packages) {
        print('  $pkg');
      }
      return;
    }
    
    for (final import in matchingImports) {
      final pkgName = _extractPackageName(import.importPath);
      print('<white>**$pkgName**</white>');
      
      // Classes
      if (import.classes.isNotEmpty) {
        final classNames = import.classes.map((c) => c.name).toList()..sort();
        print('  Classes: ${classNames.join(', ')}');
      }
      
      // Enums
      if (import.enums.isNotEmpty) {
        final enumNames = import.enums.map((e) => e.name).toList()..sort();
        print('  Enums: ${enumNames.join(', ')}');
      }
      
      // Global variables for this package
      final pkgVars = config.globalVariables.where((v) => 
        v.libraryUri.contains(pkgName)
      ).toList();
      if (pkgVars.isNotEmpty) {
        final varNames = pkgVars.map((v) => v.name).toList()..sort();
        print('  Variables: ${varNames.join(', ')}');
      }
      
      // Global getters for this package
      final pkgGetters = config.globalGetters.where((g) => 
        g.libraryUri.contains(pkgName)
      ).toList();
      if (pkgGetters.isNotEmpty) {
        final getterNames = pkgGetters.map((g) => g.name).toList()..sort();
        print('  Getters: ${getterNames.join(', ')}');
      }
      
      // Global functions for this package
      final pkgFuncs = config.globalFunctions.where((f) => 
        f.libraryUri.contains(pkgName)
      ).toList();
      if (pkgFuncs.isNotEmpty) {
        final funcNames = pkgFuncs.map((f) => f.name).toList()..sort();
        print('  Functions: ${funcNames.join(', ')}');
      }
      
      print('');
    }
  }
  
  /// Print all registered packages with their contents (for bridges help).
  void printAllPackagesInfo(D4rt d4rt) {
    final config = d4rt.getConfiguration();
    
    // Group by package name
    final packageImports = <String, List<ImportConfiguration>>{};
    for (final import in config.imports) {
      final pkgName = _extractPackageName(import.importPath);
      packageImports.putIfAbsent(pkgName, () => []).add(import);
    }
    
    final sortedPackages = packageImports.keys.toList()..sort();
    for (final pkgName in sortedPackages) {
      final imports = packageImports[pkgName]!;
      print('<white>**$pkgName**</white>');
      
      // Collect all classes and enums from all imports for this package
      final allClasses = <String>[];
      final allEnums = <String>[];
      for (final import in imports) {
        allClasses.addAll(import.classes.map((c) => c.name));
        allEnums.addAll(import.enums.map((e) => e.name));
      }
      
      if (allClasses.isNotEmpty) {
        allClasses.sort();
        print('  ${allClasses.join(', ')}');
      }
      if (allEnums.isNotEmpty) {
        allEnums.sort();
        print('  ${allEnums.join(', ')}');
      }
      
      // Global variables for this package
      final pkgVars = config.globalVariables.where((v) => 
        v.libraryUri.contains(pkgName)
      ).toList();
      if (pkgVars.isNotEmpty) {
        final varNames = pkgVars.map((v) => v.name).toList()..sort();
        print('  ${varNames.join(', ')}');
      }
      
      // Global getters for this package  
      final pkgGetters = config.globalGetters.where((g) => 
        g.libraryUri.contains(pkgName)
      ).toList();
      if (pkgGetters.isNotEmpty) {
        final getterNames = pkgGetters.map((g) => g.name).toList()..sort();
        print('  ${getterNames.join(', ')}');
      }
      
      // Global functions for this package
      final pkgFuncs = config.globalFunctions.where((f) => 
        f.libraryUri.contains(pkgName)
      ).toList();
      if (pkgFuncs.isNotEmpty) {
        final funcNames = pkgFuncs.map((f) => '${f.name}()').toList()..sort();
        print('  ${funcNames.join(', ')}');
      }
    }
  }
  
  /// Parses a search query for case-sensitivity and wildcard matching.
  /// Returns a function that can be used to match names.
  /// 
  /// Search syntax:
  /// - `query` - case-insensitive exact match
  /// - `"query"` or `'query'` - case-sensitive exact match
  /// - `query*` - case-insensitive startsWith match
  /// - `"query*"` - case-sensitive startsWith match
  /// - `*query*` - case-insensitive contains match
  /// - `"*query*"` - case-sensitive contains match
  /// 
  /// Returns null if query is empty (meaning show all).
  bool Function(String)? _parseSearchFilter(String query) {
    return parseSearchFilter(query);
  }
  
  void _printInfo(D4rt d4rt, ReplState state, String line) {
    var query = line.length > 4 ? line.substring(4).trim() : '';
    final config = d4rt.getConfiguration();

    if (query.isEmpty) {
      print('Info Usage:');
      print('  info <name>         - Show details for a class, enum, function, or variable');
      print('  info <package>      - Show all types from a package');
      print('  info <Class.member> - Show details for a class member');
      print('  info "Name"         - Case-sensitive search (with quotes)');
      print('  info name*          - Starts-with search (with asterisk)');
      print('  info "Name*"        - Case-sensitive starts-with search');
      print('  info *name*         - Contains search (with asterisks)');
      print('  info "*Name*"       - Case-sensitive contains search');
      print('');
      print('Available Packages:');
      final packages = config.imports.map((i) => _extractPackageName(i.importPath)).toSet().toList()..sort();
      for (final pkg in packages) {
        print('  $pkg');
      }
      return;
    }
    
    final filter = parseSearchFilterDetails(query);
    if (filter == null) {
      state.writeMuted('No match found for: $query');
      print('Try: classes, enums, methods, variables, or info <package-name>');
      return;
    }

    // Helper to match names based on search mode
    final matchName = filter.matches;

    // Check if query is a Class.member pattern (only for exact match mode)
    if (filter.mode == SearchMatchMode.exact && filter.term.contains('.')) {
      final parts = filter.term.split('.');
      if (parts.length == 2) {
        final className = parts[0];
        final memberName = parts[1];
        if (_printClassMemberInfo(config, className, memberName, state, caseSensitive: filter.caseSensitive)) {
          return;
        }
      }
    }

    // Check if query matches a package name
    if (!filter.term.contains('.')) {
      final packages = config.imports
          .map((i) => _extractPackageName(i.importPath))
          .toSet()
          .toList()
        ..sort();
      final matchedPackages = packages.where(matchName).toList();
      if (matchedPackages.isNotEmpty) {
        var printed = false;
        for (final pkg in matchedPackages) {
          if (printed) print('');
          _printPackageInfo(config, pkg, state);
          printed = true;
        }
        return;
      }
    }
    
    // Collect all matches to show them all, not just the first one
    var foundMatch = false;
    
    // Check if query matches a global function (check FIRST for priority)
    for (final func in config.globalFunctions) {
      if (matchName(func.name)) {
        if (foundMatch) print(''); // Add blank line between matches
        print('');
        final pkgName = _extractPackageName(func.libraryUri);
        if (func.signature != null && func.signature!.isNotEmpty) {
          print('<white>**${func.name}**</white> ($pkgName) function: ${func.signature}');
        } else {
          print('<white>**${func.name}**</white> ($pkgName) function: ${func.name}()');
        }
        foundMatch = true;
      }
    }
    
    // Check if query matches a class
    for (final import in config.imports) {
      for (final cls in import.classes) {
        if (matchName(cls.name)) {
          print(''); // Add blank line before each match
          _printClassInfo(cls, import.importPath);
          foundMatch = true;
        }
      }
    }
    
    // Check if query matches an enum
    for (final import in config.imports) {
      for (final e in import.enums) {
        if (matchName(e.name)) {
          print('');
          print('<white>**${e.name}**</white> (${_extractPackageName(import.importPath)})');
          print('  Values: ${e.values.join(', ')}');
          foundMatch = true;
        }
      }
    }
    
    // Check if query matches a global variable
    for (final v in config.globalVariables) {
      if (matchName(v.name)) {
        print('');
        final pkgName = _extractPackageName(v.libraryUri);
        print('<white>**${v.name}**</white> ($pkgName) variable: ${v.valueType}');
        foundMatch = true;
      }
    }
    
    // Check if query matches a global getter
    for (final g in config.globalGetters) {
      if (matchName(g.name)) {
        print('');
        final pkgName = _extractPackageName(g.libraryUri);
        if (g.returnType != null) {
          print('<white>**${g.name}**</white> ($pkgName) getter: ${g.returnType}');
        } else {
          print('<white>**${g.name}**</white> ($pkgName) getter');
        }
        foundMatch = true;
      }
    }
    
    if (!foundMatch) {
      state.writeMuted('No match found for: $query');
      print('Try: classes, enums, methods, variables, or info <package-name>');
    }
  }
  
  /// Prints detailed class information including signatures.
  void _printClassInfo(BridgedClassInfo cls, String importPath) {
    print('<white>**${cls.name}**</white> (${_extractPackageName(importPath)})');
    
    if (cls.constructors.isNotEmpty) {
      print('  Constructors:');
      for (final c in cls.constructors) {
        final name = c.isEmpty ? cls.name : '${cls.name}.$c';
        final sig = cls.constructorSignatures[c];
        if (sig != null && sig.isNotEmpty) {
          print('    $name$sig');
        } else {
          print('    $name()');
        }
      }
    }
    if (cls.methods.isNotEmpty) {
      print('  Methods: ${cls.methods.join(', ')}');
    }
    if (cls.getters.isNotEmpty) {
      print('  Getters: ${cls.getters.join(', ')}');
    }
    if (cls.setters.isNotEmpty) {
      print('  Setters: ${cls.setters.join(', ')}');
    }
    if (cls.staticMethods.isNotEmpty) {
      print('  Static Methods: ${cls.staticMethods.join(', ')}');
    }
    if (cls.staticGetters.isNotEmpty) {
      print('  Static Getters: ${cls.staticGetters.join(', ')}');
    }
  }
  
  /// Prints info for a specific class member (Class.member pattern).
  bool _printClassMemberInfo(D4rtConfiguration config, String className, String memberName, ReplState state, {bool caseSensitive = false}) {
    bool matchClassName(String name) => caseSensitive ? name == className : name.toLowerCase() == className.toLowerCase();
    bool matchMemberName(String name) => caseSensitive ? name == memberName : name.toLowerCase() == memberName.toLowerCase();
    String? findMemberMatch(List<String> names) {
      for (final name in names) {
        if (matchMemberName(name)) return name;
      }
      return null;
    }
    
    for (final import in config.imports) {
      for (final cls in import.classes) {
        if (matchClassName(cls.name)) {
          // Check constructors
          final constructorMatch = findMemberMatch(cls.constructors);
          final matchesClassName = matchMemberName(cls.name);
          if (constructorMatch != null || (matchesClassName && cls.constructors.contains(''))) {
            final key = constructorMatch ?? '';
            final sig = cls.constructorSignatures[key];
            final displayName = key.isEmpty ? cls.name : '${cls.name}.$key';
            print('<white>**$displayName**</white> (constructor)');
            if (sig != null && sig.isNotEmpty) {
              print('  Signature: $displayName$sig');
            }
            return true;
          }
          
          // Check instance methods
          final methodMatch = findMemberMatch(cls.methods);
          if (methodMatch != null) {
            final sig = cls.methodSignatures[methodMatch];
            print('<white>**${cls.name}.$methodMatch**</white> (method)');
            if (sig != null && sig.isNotEmpty) {
              print('  Signature: $sig');
            }
            return true;
          }
          
          // Check instance getters
          final getterMatch = findMemberMatch(cls.getters);
          if (getterMatch != null) {
            final sig = cls.getterSignatures[getterMatch];
            print('<white>**${cls.name}.$getterMatch**</white> (getter)');
            if (sig != null && sig.isNotEmpty) {
              print('  Type: $sig');
            }
            return true;
          }
          
          // Check instance setters
          final setterMatch = findMemberMatch(cls.setters);
          if (setterMatch != null) {
            final sig = cls.setterSignatures[setterMatch];
            print('<white>**${cls.name}.$setterMatch**</white> (setter)');
            if (sig != null && sig.isNotEmpty) {
              print('  Type: $sig');
            }
            return true;
          }
          
          // Check static methods
          final staticMethodMatch = findMemberMatch(cls.staticMethods);
          if (staticMethodMatch != null) {
            final sig = cls.staticMethodSignatures[staticMethodMatch];
            print('<white>**${cls.name}.$staticMethodMatch**</white> (static method)');
            if (sig != null && sig.isNotEmpty) {
              print('  Signature: $sig');
            }
            return true;
          }
          
          // Check static getters
          final staticGetterMatch = findMemberMatch(cls.staticGetters);
          if (staticGetterMatch != null) {
            final sig = cls.staticGetterSignatures[staticGetterMatch];
            print('<white>**${cls.name}.$staticGetterMatch**</white> (static getter)');
            if (sig != null && sig.isNotEmpty) {
              print('  Type: $sig');
            }
            return true;
          }
          
          // Member not found, but class exists
          state.writeMuted('Member \'$memberName\' not found in class \'${cls.name}\'');
          print('Available members: ${[...cls.methods, ...cls.getters, ...cls.staticMethods, ...cls.staticGetters].join(', ')}');
          return true;
        }
      }
    }
    return false;
  }
  
  void _printEnvironmentClasses(D4rt d4rt, ReplState state, [String filter = '']) {
    final envState = d4rt.getEnvironmentState();
    if (envState == null) {
      state.writeMuted('No environment state available.');
      return;
    }
    var classes = envState.bridgedClasses.toList()..sort();
    final matcher = _parseSearchFilter(filter);
    if (matcher != null) {
      classes = classes.where(matcher).toList();
    }
    if (classes.isEmpty) {
      if (matcher == null) {
        state.writeMuted('No classes defined in current environment.');
      } else {
        state.writeMuted('No classes matching: $filter');
      }
      return;
    }
    state.printTabulated(classes);
  }
  
  void _printEnvironmentEnums(D4rt d4rt, ReplState state, [String filter = '']) {
    final envState = d4rt.getEnvironmentState();
    if (envState == null) {
      state.writeMuted('No environment state available.');
      return;
    }
    var enums = envState.bridgedEnums.toList()..sort();
    final matcher = _parseSearchFilter(filter);
    if (matcher != null) {
      enums = enums.where(matcher).toList();
    }
    if (enums.isEmpty) {
      if (matcher == null) {
        state.writeMuted('No enums defined in current environment.');
      } else {
        state.writeMuted('No enums matching: $filter');
      }
      return;
    }
    state.printTabulated(enums);
  }
  
  void _printEnvironmentMethods(D4rt d4rt, ReplState state, [String filter = '']) {
    final envState = d4rt.getEnvironmentState();
    if (envState == null) {
      state.writeMuted('No environment state available.');
      return;
    }
    // Filter for NativeFunction values (methods/functions)
    var methods = envState.variables
        .where((v) => v.valueType.contains('NativeFunction') || v.valueType.contains('Function'))
        .map((v) => v.name)
        .toList()
      ..sort();
    final matcher = _parseSearchFilter(filter);
    if (matcher != null) {
      methods = methods.where(matcher).toList();
    }
    if (methods.isEmpty) {
      if (matcher == null) {
        state.writeMuted('No functions defined in current environment.');
      } else {
        state.writeMuted('No functions matching: $filter');
      }
      return;
    }
    state.printTabulated(methods);
  }
  
  void _printEnvironmentVariables(D4rt d4rt, ReplState state, [String filter = '']) {
    final envState = d4rt.getEnvironmentState();
    if (envState == null) {
      state.writeMuted('No environment state available.');
      return;
    }
    // Filter out functions, show only non-function values
    var variables = envState.variables
        .where((v) => !v.valueType.contains('NativeFunction') && !v.valueType.contains('Function'))
        .toList();
    final matcher = _parseSearchFilter(filter);
    if (matcher != null) {
      variables = variables.where((v) => matcher(v.name)).toList();
    }
    final formatted = variables
        .map((v) => '${v.name}: ${v.valueType}${v.isNull ? " (null)" : ""}')
        .toList()
      ..sort();
    if (formatted.isEmpty) {
      if (matcher == null) {
        state.writeMuted('No variables defined in current environment.');
      } else {
        state.writeMuted('No variables matching: $filter');
      }
      return;
    }
    for (final v in formatted) {
      print('  $v');
    }
  }
  
  void _printEnvironmentImports(D4rt d4rt, ReplState state) {
    final config = d4rt.getConfiguration();
    
    if (config.imports.isEmpty) {
      state.writeMuted('No imports registered.');
      return;
    }
    
    // Group by package name
    final packageImports = <String, List<String>>{};
    for (final import in config.imports) {
      final pkgName = _extractPackageName(import.importPath);
      packageImports.putIfAbsent(pkgName, () => []).add(import.importPath);
    }
    
    print('Registered imports (${config.imports.length}):');
    final sortedPackages = packageImports.keys.toList()..sort();
    for (final pkgName in sortedPackages) {
      final paths = packageImports[pkgName]!..sort();
      print('  $pkgName:');
      for (final path in paths) {
        print('    $path');
      }
    }
  }
  
  void _printClasses(D4rt d4rt, ReplState state, [String filter = '']) {
    final config = d4rt.getConfiguration();
    var classes = <String>[];
    for (final import in config.imports) {
      for (final cls in import.classes) {
        classes.add(cls.name);
      }
    }
    final matcher = _parseSearchFilter(filter);
    if (matcher != null) {
      classes = classes.where(matcher).toList();
    }
    if (classes.isEmpty) {
      if (matcher == null) {
        state.writeMuted('No registered classes.');
      } else {
        state.writeMuted('No registered classes matching: $filter');
      }
      return;
    }
    classes.sort();
    state.printTabulated(classes);
  }
  
  void _printEnums(D4rt d4rt, ReplState state, [String filter = '']) {
    final config = d4rt.getConfiguration();
    var enums = <String>[];
    for (final import in config.imports) {
      for (final e in import.enums) {
        enums.add(e.name);
      }
    }
    final matcher = _parseSearchFilter(filter);
    if (matcher != null) {
      enums = enums.where(matcher).toList();
    }
    if (enums.isEmpty) {
      if (matcher == null) {
        state.writeMuted('No registered enums.');
      } else {
        state.writeMuted('No registered enums matching: $filter');
      }
      return;
    }
    enums.sort();
    state.printTabulated(enums);
  }
  
  void _printGlobalMethods(D4rt d4rt, ReplState state, [String filter = '']) {
    final config = d4rt.getConfiguration();
    var methods = config.globalFunctions.map((f) => f.name).toList()..sort();
    var getters = config.globalGetters.map((g) => g.name).toList()..sort();
    final matcher = _parseSearchFilter(filter);
    if (matcher != null) {
      methods = methods.where(matcher).toList();
      getters = getters.where(matcher).toList();
    }
    if (methods.isEmpty && getters.isEmpty) {
      if (matcher == null) {
        state.writeMuted('No registered global methods.');
      } else {
        state.writeMuted('No registered global methods matching: $filter');
      }
      return;
    }
    if (methods.isNotEmpty) {
      print('Global Functions: ${methods.length}');
      state.printTabulated(methods);
    }
    if (getters.isNotEmpty) {
      if (methods.isNotEmpty) print('');
      print('Global Getters: ${getters.length}');
      state.printTabulated(getters);
    }
  }
  
  void _printGlobalVariables(D4rt d4rt, ReplState state, [String filter = '']) {
    final config = d4rt.getConfiguration();
    var variables = config.globalVariables.map((v) => v.name).toList()..sort();
    final matcher = _parseSearchFilter(filter);
    if (matcher != null) {
      variables = variables.where(matcher).toList();
    }
    if (variables.isEmpty) {
      if (matcher == null) {
        state.writeMuted('No registered global variables.');
      } else {
        state.writeMuted('No registered global variables matching: $filter');
      }
      return;
    }
    print('Global Variables: ${variables.length}');
    state.printTabulated(variables);
  }
  
  void _printImports(D4rt d4rt, ReplState state) {
    final config = d4rt.getConfiguration();
    if (config.imports.isEmpty) {
      state.writeMuted('No registered imports.');
      return;
    }
    for (final import in config.imports) {
      print('${import.importPath} (${import.classes.length} classes, ${import.enums.length} enums)');
    }
  }
}

enum SearchMatchMode {
  exact,
  startsWith,
  contains,
}

class SearchFilter {
  const SearchFilter({
    required this.term,
    required this.caseSensitive,
    required this.mode,
  });

  final String term;
  final bool caseSensitive;
  final SearchMatchMode mode;

  bool matches(String name) {
    final source = caseSensitive ? name : name.toLowerCase();
    final target = caseSensitive ? term : term.toLowerCase();
    switch (mode) {
      case SearchMatchMode.contains:
        return source.contains(target);
      case SearchMatchMode.startsWith:
        return source.startsWith(target);
      case SearchMatchMode.exact:
        return source == target;
    }
  }
}

/// Parses a search query for case-sensitivity and wildcard matching.
///
/// Search syntax:
/// - `query` - case-insensitive exact match
/// - `"query"` or `'query'` - case-sensitive exact match
/// - `query*` - case-insensitive startsWith match
/// - `"query*"` - case-sensitive startsWith match
/// - `*query*` - case-insensitive contains match
/// - `"*query*"` - case-sensitive contains match
///
/// Returns null if query is empty (meaning show all).
SearchFilter? parseSearchFilterDetails(String query) {
  if (query.isEmpty) return null;

  var searchTerm = query;
  var caseSensitive = false;

  // Check for quotes (single or double)
  if ((searchTerm.startsWith('"') && searchTerm.endsWith('"')) ||
      (searchTerm.startsWith("'") && searchTerm.endsWith("'"))) {
    caseSensitive = true;
    searchTerm = searchTerm.substring(1, searchTerm.length - 1);
  }

  // Determine match mode based on asterisk wildcards
  // *term* = contains, term* = startsWith, term = exact
  final startsWithAsterisk = searchTerm.startsWith('*');
  final endsWithAsterisk = searchTerm.endsWith('*');

  SearchMatchMode mode;
  if (startsWithAsterisk && endsWithAsterisk) {
    mode = SearchMatchMode.contains;
    searchTerm = searchTerm.substring(1, searchTerm.length - 1);
  } else if (!startsWithAsterisk && endsWithAsterisk) {
    mode = SearchMatchMode.startsWith;
    searchTerm = searchTerm.substring(0, searchTerm.length - 1);
  } else {
    mode = SearchMatchMode.exact;
    if (startsWithAsterisk) {
      searchTerm = searchTerm.substring(1);
    }
  }

  return SearchFilter(
    term: searchTerm,
    caseSensitive: caseSensitive,
    mode: mode,
  );
}

/// Parses a search query for case-sensitivity and wildcard matching.
/// Returns a function that can be used to match names.
bool Function(String)? parseSearchFilter(String query) {
  final filter = parseSearchFilterDetails(query);
  if (filter == null) return null;
  return filter.matches;
}

/// Stdout/Stderr capture wrapper for bot mode output capture.
/// 
/// Captures all writes to stdout/stderr and converts them to Telegram format.
class _CaptureStdout implements Stdout {
  final StringBuffer _buffer;
  final String Function(String) _convertMarkdown;
  final String Function(String) _stripAnsi;
  final bool isError;
  
  _CaptureStdout(
    this._buffer, 
    this._convertMarkdown, 
    this._stripAnsi, {
    this.isError = false,
  });
  
  @override
  void write(Object? object) {
    final text = _convertMarkdown(_stripAnsi(object?.toString() ?? ''));
    if (isError && text.isNotEmpty) {
      _buffer.write('❌ $text');
    } else {
      _buffer.write(text);
    }
  }
  
  @override
  void writeln([Object? object = '']) {
    final text = _convertMarkdown(_stripAnsi(object?.toString() ?? ''));
    if (isError && text.isNotEmpty) {
      _buffer.writeln('❌ $text');
    } else {
      _buffer.writeln(text);
    }
  }
  
  @override
  void writeAll(Iterable objects, [String separator = '']) {
    write(objects.map((o) => o.toString()).join(separator));
  }
  
  @override
  void writeCharCode(int charCode) {
    write(String.fromCharCode(charCode));
  }
  
  @override
  void add(List<int> data) {
    write(String.fromCharCodes(data));
  }
  
  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    writeln('Error: $error');
  }
  
  @override
  Future addStream(Stream<List<int>> stream) async {
    await for (final data in stream) {
      add(data);
    }
  }
  
  @override
  Future close() async {}
  
  @override
  Future get done => Future.value();
  
  @override
  Future flush() async {}
  
  // Stub implementations for remaining Stdout interface
  @override
  Encoding get encoding => utf8;
  
  @override
  set encoding(Encoding encoding) {}
  
  @override
  String get lineTerminator => '\n';
  
  @override
  set lineTerminator(String lineTerminator) {}
  
  @override
  bool get hasTerminal => false;
  
  @override
  IOSink get nonBlocking => this;
  
  @override
  bool get supportsAnsiEscapes => false;
  
  @override
  int get terminalColumns => 80;
  
  @override
  int get terminalLines => 24;
}
