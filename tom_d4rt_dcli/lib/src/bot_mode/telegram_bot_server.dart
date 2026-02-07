/// Telegram Bot Server for REPL
///
/// Main server that manages multiple bot connections and routes messages
/// to REPL execution.
library;

import 'dart:async';
import 'dart:io';

import 'package:tom_chattools/tom_chattools.dart';

import 'bot_mode_config.dart';
import 'output_formatter.dart';
import 'security_manager.dart';

/// Telegram Bot Mode Server.
///
/// Manages multiple bot connections and routes messages to REPL instances.
class TelegramBotServer {
  final BotModeConfig config;
  final Map<String, BotInstance> _bots = {};
  final SecurityManager _security;
  final OutputFormatter _formatter;
  final Completer<void> _shutdownCompleter = Completer();

  /// Callback to execute a command (provided by REPL).
  final Future<ExecutionResult> Function(String command) executeCommand;

  TelegramBotServer({
    required this.config,
    required this.executeCommand,
  })  : _security = SecurityManager(config.security),
        _formatter = OutputFormatter(
          config: config.output,
          tempDirectory: config.files.tempDirectory,
        );

  /// Start the bot server.
  Future<void> start() async {
    print('Starting Telegram Bot Server...');

    for (final botConfig in config.bots) {
      final token = Platform.environment[botConfig.tokenEnv];
      if (token == null || token.isEmpty) {
        stderr.writeln(
            'Warning: ${botConfig.tokenEnv} not set, skipping bot "${botConfig.name}"');
        continue;
      }

      try {
        final bot = await BotInstance.create(
          name: botConfig.name,
          token: token,
          allowedUsers: botConfig.allowedUsers,
          vscode: botConfig.vscode,
          security: _security.withOverrides(botConfig.security),
          formatter: _formatter,
          executeCommand: executeCommand,
          pollingTimeout: config.polling.timeout.inSeconds,
        );

        _bots[botConfig.name] = bot;
        bot.startPolling();
        print('  ✓ Bot "${botConfig.name}" started');
        
        // Send welcome message to allowed users
        await bot.sendWelcomeMessages();
      } catch (e) {
        stderr.writeln('Error starting bot "${botConfig.name}": $e');
      }
    }

    if (_bots.isEmpty) {
      throw StateError('No bots were started. Check your configuration.');
    }

    print('');
    print('Bot server started with ${_bots.length} bot(s):');
    for (final bot in _bots.values) {
      final vsInfo = bot.vscode != null
          ? ' → VS Code on ${bot.vscode!.host}:${bot.vscode!.port}'
          : '';
      print('  • ${bot.name}$vsInfo');
    }
    print('');
    print('Press Ctrl+C to stop.');
  }

  /// Wait for shutdown signal.
  Future<void> waitForShutdown() async {
    // Handle SIGINT and SIGTERM
    ProcessSignal.sigint.watch().listen((_) => shutdown());
    ProcessSignal.sigterm.watch().listen((_) => shutdown());

    await _shutdownCompleter.future;
  }

  /// Shutdown the server.
  Future<void> shutdown() async {
    if (_shutdownCompleter.isCompleted) return;

    print('\nShutting down bot server...');
    for (final bot in _bots.values) {
      await bot.stop();
    }
    _shutdownCompleter.complete();
  }
}

/// Single bot instance connected to Telegram.
class BotInstance {
  final String name;
  final String token;
  final List<int> allowedUsers;
  final VSCodeConfig? vscode;
  final SecurityManager security;
  final OutputFormatter formatter;
  final Future<ExecutionResult> Function(String command) executeCommand;

  late final ChatApi _telegram;
  StreamSubscription<ChatMessage>? _subscription;
  bool _running = false;

  BotInstance._({
    required this.name,
    required this.token,
    required this.allowedUsers,
    this.vscode,
    required this.security,
    required this.formatter,
    required this.executeCommand,
    required ChatApi telegram,
  }) : _telegram = telegram;

  /// Create and initialize a bot instance.
  static Future<BotInstance> create({
    required String name,
    required String token,
    required List<int> allowedUsers,
    VSCodeConfig? vscode,
    required SecurityManager security,
    required OutputFormatter formatter,
    required Future<ExecutionResult> Function(String command) executeCommand,
    int pollingTimeout = 30,
  }) async {
    // Create Telegram chat API with polling timeout
    final settings = ChatSettings.telegram(
      token,
      pollingTimeout: Duration(seconds: pollingTimeout),
    );
    final telegram = await ChatApi.connect(settings);

    return BotInstance._(
      name: name,
      token: token,
      allowedUsers: allowedUsers,
      vscode: vscode,
      security: security,
      formatter: formatter,
      executeCommand: executeCommand,
      telegram: telegram,
    );
  }

  /// Start polling for messages.
  void startPolling() {
    _running = true;
    // Listen to incoming messages via the stream
    _subscription = _telegram.onMessage.listen(
      _handleMessage,
      onError: (e) {
        stderr.writeln('[$name] Message stream error: $e');
      },
    );
  }

  /// Send welcome messages to all allowed users.
  Future<void> sendWelcomeMessages() async {
    final vsInfo = vscode != null
        ? 'Connected to VS Code on ${vscode!.host}:${vscode!.port}'
        : 'No VS Code connection configured';
    
    final welcomeMessage = '''
🤖 *$name Bot* started!

$vsInfo

Type /help for available commands, or enter any REPL command directly.
''';

    for (final userId in allowedUsers) {
      try {
        await _telegram.sendMessage(
          ChatReceiver.id(userId.toString()),
          welcomeMessage,
        );
        print('  📨 Sent welcome to user $userId');
      } catch (e) {
        // User may not have started the bot yet, that's OK
        stderr.writeln('  ⚠ Could not send welcome to user $userId: $e');
      }
    }
  }

  /// Handle an incoming message.
  Future<void> _handleMessage(ChatMessage message) async {
    // Validate user
    final userId = int.tryParse(message.sender.id);
    if (userId == null || !allowedUsers.contains(userId)) {
      await _sendReply(message, formatter.formatError('Unauthorized user'));
      return;
    }

    // Get command text
    final text = message.text;
    if (text == null || text.isEmpty) return;

    // Handle bot commands (starting with /)
    if (text.startsWith('/')) {
      await _handleBotCommand(message, text);
      return;
    }

    // Security check
    final allowed = security.isCommandAllowed(text);
    if (!allowed.permitted) {
      await _sendReply(
        message,
        formatter.formatError('Command not allowed: ${allowed.reason}'),
      );
      return;
    }

    // Execute command
    try {
      // Send typing indicator
      await _sendTyping(message);

      // Execute the command via REPL
      final result = await executeCommand(text);

      // Format and send reply
      final formatted = formatter.format(result);
      await _sendReply(message, formatted);
    } catch (e) {
      await _sendReply(message, formatter.formatError('$e'));
    }
  }

  /// Handle bot commands (starting with /).
  Future<void> _handleBotCommand(ChatMessage message, String command) async {
    final cmd = command.toLowerCase().split(' ').first;

    switch (cmd) {
      case '/start':
        final vsInfo = vscode != null
            ? 'Connected to VS Code on ${vscode!.host}:${vscode!.port}'
            : 'No VS Code connection configured';
        await _sendReply(
          message,
          FormattedOutput(text: '''
🤖 *$name Bot* - D4rt REPL

$vsInfo

*Commands:*
/help - Show available commands
/status - Show bot status

Type any REPL command to execute.
'''),
        );
        break;

      case '/help':
        await _sendReply(
          message,
          FormattedOutput(text: '''
*Available Commands*

/start - Show welcome message
/help - Show this help
/status - Show bot status

*REPL Commands*
Type any REPL command directly, for example:
• `print("Hello")` - Print a message
• `help` - Show REPL help
• `.history` - Show command history
'''),
        );
        break;

      case '/status':
        await _sendReply(
          message,
          FormattedOutput(text: '''
*Bot Status*

Bot: $name
Running: ${_running ? "✅ Yes" : "❌ No"}
VS Code: ${vscode != null ? "${vscode!.host}:${vscode!.port}" : "Not configured"}
'''),
        );
        break;

      default:
        await _sendReply(
          message,
          formatter.formatWarning('Unknown command: $cmd\nType /help for available commands.'),
        );
    }
  }

  /// Send a reply to a message.
  Future<void> _sendReply(ChatMessage original, FormattedOutput output) async {
    await _telegram.sendMessage(
      ChatReceiver.id(original.sender.id),
      output.text,
    );

    // Send attachments if any
    if (output.attachments != null) {
      for (final file in output.attachments!) {
        // TODO: Implement file sending when ChatApi supports it
        // For now, just notify about the file
        await _telegram.sendMessage(
          ChatReceiver.id(original.sender.id),
          '📎 File: ${file.path}',
        );
      }
    }
  }

  /// Send typing indicator.
  Future<void> _sendTyping(ChatMessage message) async {
    // TODO: Implement when ChatApi supports chat actions
  }

  /// Stop the bot.
  Future<void> stop() async {
    _running = false;
    await _subscription?.cancel();
    // TODO: Disconnect telegram when ChatApi supports it
  }
}
