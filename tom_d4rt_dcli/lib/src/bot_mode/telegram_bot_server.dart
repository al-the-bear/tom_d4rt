/// Telegram Bot Server for REPL
///
/// Main server that manages multiple bot connections and routes messages
/// to REPL execution.
library;

import 'dart:async';
import 'dart:io';

import 'package:tom_chattools/tom_chattools.dart';
import 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart';

import 'bot_mode_config.dart';
import 'conversation_trail.dart';
import 'output_formatter.dart';
import 'security_manager.dart';

/// Telegram Bot Mode Server.
///
/// Manages multiple bot connections and routes messages to REPL instances.
class TelegramBotServer {
  final BotModeConfig config;
  final String toolName;
  final String toolVersion;
  final Map<String, BotInstance> _bots = {};
  final SecurityManager _security;
  final OutputFormatter _formatter;
  final Completer<void> _shutdownCompleter = Completer();

  /// Callback to execute a command (provided by REPL).
  final Future<ExecutionResult> Function(String command) executeCommand;

  TelegramBotServer({
    required this.config,
    required this.executeCommand,
    required this.toolName,
    required this.toolVersion,
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
          toolName: toolName,
          toolVersion: toolVersion,
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
  final String toolName;
  final String toolVersion;
  
  /// Conversation trail manager for this bot.
  final ConversationTrailManager trailManager;

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
    required this.toolName,
    required this.toolVersion,
    required this.trailManager,
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
    required String toolName,
    required String toolVersion,
  }) async {
    // Create Telegram chat API with polling timeout
    final settings = ChatSettings.telegram(
      token,
      pollingTimeout: Duration(seconds: pollingTimeout),
    );
    final telegram = await ChatApi.connect(settings);
    
    // Create and initialize conversation trail manager
    final trailManager = ConversationTrailManager(
      toolName: toolName,
      botName: name,
    );
    await trailManager.initialize();

    return BotInstance._(
      name: name,
      token: token,
      allowedUsers: allowedUsers,
      vscode: vscode,
      security: security,
      formatter: formatter,
      executeCommand: executeCommand,
      telegram: telegram,
      toolName: toolName,
      toolVersion: toolVersion,
      trailManager: trailManager,
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

*$toolName* v$toolVersion
$vsInfo

Type help for available commands, or enter any REPL command directly.
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
    var text = message.text;
    if (text == null || text.isEmpty) return;
    
    // Process and save received file attachments
    final receivedAttachments = <String>[];
    if (message.attachments.isNotEmpty) {
      for (final attachment in message.attachments) {
        try {
          // Download attachment content
          final fileName = attachment.fileName ?? 
              'attachment_${DateTime.now().millisecondsSinceEpoch}';
          final data = await _downloadAttachment(attachment);
          if (data != null) {
            final savedPath = await trailManager.saveReceivedFile(fileName, data);
            print('[BOT] Saved attachment to: $savedPath');
            receivedAttachments.add(savedPath);
          } else {
            print('[BOT] Failed to download attachment: $fileName');
          }
        } catch (e) {
          stderr.writeln('Failed to save attachment: $e');
        }
      }
    }
    
    // If there are attachments, append file info to the command
    if (receivedAttachments.isNotEmpty) {
      final attachmentsSuffix = '''

The user attached the following files for your reference or because they are referenced in the prompt:

${receivedAttachments.join('\n')}
''';
      text = '$text$attachmentsSuffix';
    }

    // Normalize quotes: Convert curly quotes to straight quotes
    // Telegram often converts straight quotes to curly quotes
    text = text
        .replaceAll('\u201C', '"')  // " (left double quotation mark)
        .replaceAll('\u201D', '"')  // " (right double quotation mark)
        .replaceAll('\u2018', "'")  // ' (left single quotation mark)
        .replaceAll('\u2019', "'"); // ' (right single quotation mark)

    // Handle bot commands (starting with /)
    if (text.startsWith('/')) {
      await _handleBotCommand(message, text);
      return;
    }
    
    // Handle trail commands (check original text without attachments suffix)
    final originalText = message.text!;
    if (originalText.startsWith('list-attachments') || 
        originalText.startsWith('list-references') ||
        originalText.startsWith('get-attachments') ||
        originalText.startsWith('get-references')) {
      await _handleTrailCommand(message, originalText);
      return;
    }
    
    // Check if this is an explicit Copilot prompt (starts with ?)
    // These always go to Copilot, even if they look like commands
    if (originalText.trim().startsWith('?')) {
      final prompt = _stripCopilotPrefix(text);
      await _handleCopilotChatPrompt(message, prompt, receivedAttachments);
      return;
    }
    
    // Check if this is a REPL command - commands should NOT go to Copilot
    // even if they end with . or ?
    if (_isReplCommand(originalText)) {
      // Fall through to REPL execution below
    } else {
      // Check if this looks like a Copilot Chat prompt
      print('[BOT] Checking if Copilot Chat prompt...');
      print('[BOT]   originalText: "$originalText"');
      final isCopilot = _isCopilotChatPrompt(originalText);
      print('[BOT]   _isCopilotChatPrompt result: $isCopilot');
      if (isCopilot) {
        await _handleCopilotChatPrompt(message, text, receivedAttachments);
        return;
      }
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
      
      // Build reply entry from result
      // If there's a Copilot response, use its structured data
      final copilot = result.copilotResponse;
      final replyEntry = copilot != null
          ? ReplyEntry(
              markdown: copilot.generatedMarkdown,
              comment: copilot.comment,
              references: copilot.references,
              requestedAttachments: copilot.requestedAttachments,
            )
          : ReplyEntry(
              markdown: formatted.text,
              comment: result.isError ? result.errorMessage : null,
            );
      
      // Record exchange in trail
      final exchange = ConversationExchange(
        timestamp: DateTime.now(),
        prompt: PromptEntry(
          text: message.text ?? text,  // Use original text without attachments suffix
          attachments: receivedAttachments,
        ),
        reply: replyEntry,
      );
      await trailManager.addExchange(exchange);
      
      await _sendReply(message, formatted);
    } catch (e) {
      await _sendReply(message, formatter.formatError('$e'));
    }
  }
  
  /// Handle trail-related commands.
  Future<void> _handleTrailCommand(ChatMessage message, String command) async {
    try {
      final parts = command.split(RegExp(r'\s+'));
      final cmd = parts.first.toLowerCase();
      print('[TRAIL] Handling trail command: "$cmd" (full: "$command")');
      
      switch (cmd) {
        case 'list-attachments':
          final attachments = trailManager.allAttachments;
          print('[TRAIL] Found ${attachments.length} attachments');
          if (attachments.isEmpty) {
            await _sendReply(message, FormattedOutput(text: 'No attachments in trail.'));
          } else {
            final buffer = StringBuffer('*Attachments in Trail*\n\n');
            for (final entry in attachments.entries) {
              buffer.writeln('`${entry.key}`: ${entry.value}');
            }
            await _sendReply(message, FormattedOutput(text: buffer.toString()));
          }
          break;
          
        case 'list-references':
          final references = trailManager.allReferences;
          print('[TRAIL] Found ${references.length} references');
          if (references.isEmpty) {
            await _sendReply(message, FormattedOutput(text: 'No references in trail.'));
          } else {
            final buffer = StringBuffer('*References in Trail*\n\n');
            for (final entry in references.entries) {
              buffer.writeln('`${entry.key}`: ${entry.value}');
            }
            await _sendReply(message, FormattedOutput(text: buffer.toString()));
          }
          break;
          
        case 'get-attachments':
          if (parts.length < 2) {
            await _sendReply(message, FormattedOutput(
              text: 'Usage: `get-attachments <id1>, <id2>, ...`\n\nExample: `get-attachments A000, A001`',
            ));
          } else {
            final ids = parts.sublist(1).join(' ').split(',').map((s) => s.trim()).toList();
            final paths = trailManager.getAttachmentPaths(ids);
            if (paths.isEmpty) {
              await _sendReply(message, FormattedOutput(text: 'No matching attachments found.'));
            } else {
              await _sendFilesAsAttachments(message, paths);
            }
          }
          break;
          
        case 'get-references':
          if (parts.length < 2) {
            await _sendReply(message, FormattedOutput(
              text: 'Usage: `get-references <id1>, <id2>, ...`\n\nExample: `get-references R000, R001`',
            ));
          } else {
            final ids = parts.sublist(1).join(' ').split(',').map((s) => s.trim()).toList();
            final paths = trailManager.getReferencePaths(ids);
            if (paths.isEmpty) {
              await _sendReply(message, FormattedOutput(text: 'No matching references found.'));
            } else {
              await _sendFilesAsAttachments(message, paths);
            }
          }
          break;
          
        default:
          // This shouldn't happen since we pre-check with startsWith
          await _sendReply(message, FormattedOutput(
            text: '⚠️ Unknown trail command: `$cmd`',
          ));
      }
    } catch (e, stack) {
      print('[TRAIL] Error handling trail command: $e\n$stack');
      await _sendReply(message, formatter.formatError('Trail command error: $e'));
    }
  }
  
  /// Send files as attachments to the user.
  Future<void> _sendFilesAsAttachments(ChatMessage original, List<String> paths) async {
    for (final path in paths) {
      final file = File(path);
      if (await file.exists()) {
        // Determine file type from extension
        final extension = path.split('.').last.toLowerCase();
        final attachmentType = _getAttachmentType(extension);
        final fileName = path.split('/').last;
        
        // Create message with attachment
        final messageWithAttachment = ChatMessage(
          id: '',
          sender: const ChatSender.self(),
          timestamp: DateTime.now(),
          attachments: [
            ChatAttachment(
              type: attachmentType,
              url: path,
              fileName: fileName,
            ),
          ],
        );
        
        try {
          await _telegram.send(
            ChatReceiver.id(original.sender.id),
            messageWithAttachment,
          );
        } catch (e) {
          // Fallback to text message with path
          await _telegram.sendMessage(
            ChatReceiver.id(original.sender.id),
            '📎 File: $path\n(Could not send as attachment: $e)',
          );
        }
      } else {
        await _telegram.sendMessage(
          ChatReceiver.id(original.sender.id),
          '⚠️ File not found: $path',
        );
      }
    }
  }
  
  /// Get attachment type from file extension.
  ChatAttachmentType _getAttachmentType(String extension) {
    switch (extension) {
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
      case 'webp':
        return ChatAttachmentType.image;
      case 'mp4':
      case 'mov':
      case 'avi':
      case 'webm':
        return ChatAttachmentType.video;
      case 'mp3':
      case 'wav':
      case 'ogg':
      case 'm4a':
        return ChatAttachmentType.audio;
      default:
        return ChatAttachmentType.document;
    }
  }
  
  /// Check if text looks like a Copilot Chat prompt.
  /// Returns true if the message:
  /// - Starts with ? (explicit Copilot trigger)
  /// - Starts with TODO: or QUESTION:
  /// - Ends with . or ?
  /// - Ends with at least three dashes (---) on a separate last line
  bool _isCopilotChatPrompt(String text) {
    final trimmed = text.trim();
    
    // Check for ? prefix (explicit Copilot trigger)
    if (trimmed.startsWith('?')) {
      return true;
    }
    
    // Check for TODO: or QUESTION: prefix (case insensitive)
    final upperText = trimmed.toUpperCase();
    if (upperText.startsWith('TODO:') || upperText.startsWith('QUESTION:')) {
      return true;
    }
    
    // Check if ends with . or ?
    if (trimmed.endsWith('.') || trimmed.endsWith('?')) {
      return true;
    }
    
    // Check if last line is at least three dashes
    final lines = trimmed.split('\n');
    if (lines.isNotEmpty) {
      final lastLine = lines.last.trim();
      if (RegExp(r'^-{3,}$').hasMatch(lastLine)) {
        return true;
      }
    }
    
    return false;
  }
  
  /// Remove the ? prefix from a Copilot prompt if present.
  String _stripCopilotPrefix(String text) {
    final trimmed = text.trim();
    if (trimmed.startsWith('?')) {
      return trimmed.substring(1).trim();
    }
    return text;
  }
  
  /// Check if text is a known REPL command (to avoid sending commands to Copilot).
  bool _isReplCommand(String text) {
    final trimmed = text.trim().toLowerCase();
    
    // List of known REPL commands that should NOT go to Copilot
    const commands = [
      'help',
      'quit',
      'exit',
      'clear',
      'history',
      'vars',
      'variables',
      'imports',
      'registered-classes',
      'registered-enums',
      'registered-methods',
      'registered-variables',
      'registered-imports',
      'show-init',
      'show-initialization',
      'sessions',
      'session',
      'bridges',
      'config',
      'status',
      'env',
      'reset',
      'multiline',
      'load',
      'save',
      'run',
      'execute',
      'exec',
      'exp',
      'classes',
      'enums',
      'methods',
      'defines',
      'info',
    ];
    
    // Check exact match or prefix with space
    for (final cmd in commands) {
      if (trimmed == cmd || trimmed.startsWith('$cmd ')) {
        return true;
      }
    }
    
    // Also check for dot-commands (.load, .save, etc.)
    if (trimmed.startsWith('.')) {
      return true;
    }
    
    return false;
  }
  
  /// Handle a message as a Copilot Chat prompt.
  Future<void> _handleCopilotChatPrompt(
    ChatMessage message, 
    String prompt,
    List<String> receivedAttachments,
  ) async {
    try {
      // Send typing indicator
      await _sendTyping(message);
      
      // Notify user we're sending to Copilot
      await _telegram.sendMessage(
        ChatReceiver.id(message.sender.id),
        '🤖 Sending to Copilot Chat...',
      );
      
      // Call Copilot Chat
      final response = await VsCodeHelper.askCopilotChat(prompt);
      
      // Parse response
      final copilotResponse = CopilotChatResponse.fromMap(response);
      
      // Create execution result with Copilot response
      final result = ExecutionResult(
        output: copilotResponse.generatedMarkdown,
        copilotResponse: copilotResponse,
      );
      
      // Format and send reply
      final formatted = formatter.format(result);
      
      // Record exchange in trail
      final exchange = ConversationExchange(
        timestamp: DateTime.now(),
        prompt: PromptEntry(
          text: message.text ?? prompt,
          attachments: receivedAttachments,
        ),
        reply: ReplyEntry(
          markdown: copilotResponse.generatedMarkdown,
          comment: copilotResponse.comment,
          references: copilotResponse.references,
          requestedAttachments: copilotResponse.requestedAttachments,
        ),
      );
      await trailManager.addExchange(exchange);
      
      await _sendReply(message, formatted);
      
      // Send requested attachments as actual files if configured
      if (formatter.config.autoAttachCopilotFiles && copilotResponse.requestedAttachments.isNotEmpty) {
        await _sendFilesAsAttachments(message, copilotResponse.requestedAttachments);
      }
    } catch (e) {
      await _sendReply(message, formatter.formatError('Copilot Chat error: $e'));
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

*Bot Commands:*
/start - Show this welcome message
/status - Show bot status

Type any REPL command directly, or `help` for detailed help.
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
          formatter.formatWarning('Unknown command: $cmd\nType help for available commands.'),
        );
    }
  }

  /// Send a reply to a message.
  Future<void> _sendReply(ChatMessage original, FormattedOutput output) async {
    await _telegram.sendMessage(
      ChatReceiver.id(original.sender.id),
      output.text,
      parseMode: output.parseMode,
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
  
  /// Download attachment content.
  /// Returns null if download fails or is not supported.
  Future<List<int>?> _downloadAttachment(ChatAttachment attachment) async {
    if (attachment.url.isEmpty) return null;
    
    try {
      // Check if it's a local file path first
      if (!attachment.url.startsWith('http') && !_isTelegramFileId(attachment.url)) {
        final file = File(attachment.url);
        if (await file.exists()) {
          return await file.readAsBytes();
        }
      }
      
      // For Telegram file IDs, use the ChatApi's downloadAttachment method
      if (_isTelegramFileId(attachment.url)) {
        return await _telegram.downloadAttachment(attachment);
      }
      
      // For HTTP URLs, use HttpClient to download
      final httpClient = HttpClient();
      try {
        final request = await httpClient.getUrl(Uri.parse(attachment.url));
        final response = await request.close();
        if (response.statusCode == 200) {
          final bytes = <int>[];
          await for (final chunk in response) {
            bytes.addAll(chunk);
          }
          return bytes;
        }
      } finally {
        httpClient.close();
      }
    } catch (e) {
      stderr.writeln('Failed to download attachment: $e');
    }
    return null;
  }
  
  /// Check if a string looks like a Telegram file ID.
  bool _isTelegramFileId(String url) {
    // Telegram file IDs are long base64-like strings starting with specific prefixes
    // They don't contain slashes or protocol prefixes
    return url.isNotEmpty && 
           !url.contains('/') && 
           !url.contains(':') &&
           url.length > 20;
  }

  /// Stop the bot.
  Future<void> stop() async {
    _running = false;
    await _subscription?.cancel();
    // TODO: Disconnect telegram when ChatApi supports it
  }
}
