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

// =============================================================================
// Message Processing Types
// =============================================================================

/// Preprocessed message data extracted from incoming Telegram message.
class PreprocessedMessage {
  /// The original ChatMessage from Telegram.
  final ChatMessage original;
  
  /// User ID (validated).
  final int userId;
  
  /// Original text (from message.text).
  final String originalText;
  
  /// Processed text (with attachments suffix and normalized quotes).
  final String processedText;
  
  /// Paths to saved received attachments.
  final List<String> receivedAttachments;

  PreprocessedMessage({
    required this.original,
    required this.userId,
    required this.originalText,
    required this.processedText,
    required this.receivedAttachments,
  });
}

/// Type of message determined during preprocessing.
enum MessageType {
  /// Trail command (list-attachments, get-references, etc.)
  trailCommand,
  
  /// Explicit Copilot prompt (starts with ?)
  explicitCopilot,
  
  /// Implicit Copilot prompt (ends with . or ?)
  implicitCopilot,
  
  /// REPL command to execute
  replCommand,
}

/// Result of message execution (before formatting).
class MessageExecutionResult {
  /// The execution result from REPL or Copilot.
  final ExecutionResult? executionResult;
  
  /// Captured stdout during execution.
  final String capturedOutput;
  
  /// Error that occurred during execution (if any).
  final Object? error;
  
  /// Stack trace (if error occurred).
  final StackTrace? stackTrace;
  
  /// Reply entry for conversation trail.
  final ReplyEntry? replyEntry;
  
  /// Whether this is a trail command result (special handling).
  final bool isTrailCommand;
  
  /// Pre-formatted output (for trail commands).
  final FormattedOutput? preformattedOutput;

  MessageExecutionResult({
    this.executionResult,
    this.capturedOutput = '',
    this.error,
    this.stackTrace,
    this.replyEntry,
    this.isTrailCommand = false,
    this.preformattedOutput,
  });
  
  bool get hasError => error != null;
}

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
  
  /// Whether the bot is currently running.
  bool get isRunning => _running;

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

  // ===========================================================================
  // Message Handling - Main Entry Point
  // ===========================================================================

  /// Handle an incoming message using 4-step processing:
  /// 1. Preprocess: extract text, caption, attachments
  /// 2. Security check
  /// 3. Execute with output capture
  /// 4. Send unified reply
  Future<void> _handleMessage(ChatMessage message) async {
    // -------------------------------------------------------------------------
    // STEP 1: Message Preprocessing
    // -------------------------------------------------------------------------
    final preprocessed = await _preprocessMessage(message);
    if (preprocessed == null) {
      // Preprocessing failed (unauthorized user or empty message)
      return;
    }
    
    // -------------------------------------------------------------------------
    // STEP 2: Security Check
    // -------------------------------------------------------------------------
    final securityResult = security.isCommandAllowed(preprocessed.processedText);
    if (!securityResult.permitted) {
      await _sendReply(
        message,
        formatter.formatError('Command not allowed: ${securityResult.reason}'),
      );
      return;
    }
    
    // -------------------------------------------------------------------------
    // STEP 3: Execute with Output Capture (runZonedGuarded)
    // -------------------------------------------------------------------------
    await _sendTyping(message);
    
    final executionResult = await _executeWithCapture(preprocessed);
    
    // -------------------------------------------------------------------------
    // STEP 4: Send Unified Reply
    // -------------------------------------------------------------------------
    await _sendUnifiedReply(preprocessed, executionResult);
  }

  // ===========================================================================
  // Step 1: Message Preprocessing
  // ===========================================================================

  /// Preprocess incoming message: validate user, extract text, save attachments.
  /// Returns null if message should not be processed (unauthorized or empty).
  Future<PreprocessedMessage?> _preprocessMessage(ChatMessage message) async {
    // Validate user
    final userId = int.tryParse(message.sender.id);
    if (userId == null || !allowedUsers.contains(userId)) {
      await _sendReply(message, formatter.formatError('Unauthorized user'));
      return null;
    }

    // Get command text
    var text = message.text;
    if (text == null || text.isEmpty) return null;
    
    final originalText = text;
    
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
    
    return PreprocessedMessage(
      original: message,
      userId: userId,
      originalText: originalText,
      processedText: text,
      receivedAttachments: receivedAttachments,
    );
  }

  /// Determine the type of message for routing.
  MessageType _determineMessageType(PreprocessedMessage msg) {
    final originalText = msg.originalText;
    
    // Trail commands
    if (originalText.startsWith('list-attachments') || 
        originalText.startsWith('list-references') ||
        originalText.startsWith('get-attachments') ||
        originalText.startsWith('get-references')) {
      return MessageType.trailCommand;
    }
    
    // Explicit Copilot prompt (starts with ?)
    if (originalText.trim().startsWith('?')) {
      return MessageType.explicitCopilot;
    }
    
    // REPL command check - these should NOT go to Copilot
    if (_isReplCommand(originalText)) {
      return MessageType.replCommand;
    }
    
    // Implicit Copilot prompt check
    if (_isCopilotChatPrompt(originalText)) {
      return MessageType.implicitCopilot;
    }
    
    // Default: REPL command
    return MessageType.replCommand;
  }

  // ===========================================================================
  // Step 3: Execute with Output Capture
  // ===========================================================================

  /// Execute the message with stdout/stderr capture using runZonedGuarded.
  Future<MessageExecutionResult> _executeWithCapture(PreprocessedMessage msg) async {
    final messageType = _determineMessageType(msg);
    final capturedOutput = StringBuffer();
    ExecutionResult? executionResult;
    ReplyEntry? replyEntry;
    Object? error;
    StackTrace? stackTrace;
    FormattedOutput? preformattedOutput;
    bool isTrailCommand = false;
    
    // Create a completer to track when execution finishes
    final completer = Completer<void>();
    
    // Run with output capture
    runZonedGuarded(
      () async {
        try {
          switch (messageType) {
            case MessageType.trailCommand:
              isTrailCommand = true;
              preformattedOutput = await _executeTrailCommand(msg.originalText);
              
            case MessageType.explicitCopilot:
              final prompt = _stripCopilotPrefix(msg.processedText);
              (executionResult, replyEntry) = await _executeCopilotPrompt(
                prompt, 
                msg.receivedAttachments,
              );
              
            case MessageType.implicitCopilot:
              (executionResult, replyEntry) = await _executeCopilotPrompt(
                msg.processedText, 
                msg.receivedAttachments,
              );
              
            case MessageType.replCommand:
              executionResult = await executeCommand(msg.processedText);
              final formatted = formatter.format(executionResult!);
              replyEntry = ReplyEntry(
                markdown: formatted.text,
                comment: executionResult!.isError ? executionResult!.errorMessage : null,
              );
          }
        } catch (e, st) {
          error = e;
          stackTrace = st;
        } finally {
          completer.complete();
        }
      },
      (e, st) {
        // This catches uncaught errors in the zone
        error = e;
        stackTrace = st;
        if (!completer.isCompleted) {
          completer.complete();
        }
      },
      zoneSpecification: ZoneSpecification(
        print: (self, parent, zone, line) {
          capturedOutput.writeln(line);
          // Also print to actual stdout for debugging
          parent.print(zone, line);
        },
      ),
    );
    
    // Wait for execution to complete
    await completer.future;
    
    return MessageExecutionResult(
      executionResult: executionResult,
      capturedOutput: capturedOutput.toString(),
      error: error,
      stackTrace: stackTrace,
      replyEntry: replyEntry,
      isTrailCommand: isTrailCommand,
      preformattedOutput: preformattedOutput,
    );
  }

  /// Execute a trail command and return formatted output.
  Future<FormattedOutput> _executeTrailCommand(String command) async {
    final parts = command.split(RegExp(r'\s+'));
    final cmd = parts.first.toLowerCase();
    print('[TRAIL] Handling trail command: "$cmd" (full: "$command")');
    
    switch (cmd) {
      case 'list-attachments':
        final attachments = trailManager.allAttachments;
        print('[TRAIL] Found ${attachments.length} attachments');
        if (attachments.isEmpty) {
          return FormattedOutput(text: 'No attachments in trail.');
        } else {
          final buffer = StringBuffer('*Attachments in Trail*\n\n');
          for (final entry in attachments.entries) {
            buffer.writeln('`${entry.key}`: ${entry.value}');
          }
          return FormattedOutput(text: buffer.toString());
        }
        
      case 'list-references':
        final references = trailManager.allReferences;
        print('[TRAIL] Found ${references.length} references');
        if (references.isEmpty) {
          return FormattedOutput(text: 'No references in trail.');
        } else {
          final buffer = StringBuffer('*References in Trail*\n\n');
          for (final entry in references.entries) {
            buffer.writeln('`${entry.key}`: ${entry.value}');
          }
          return FormattedOutput(text: buffer.toString());
        }
        
      case 'get-attachments':
        if (parts.length < 2) {
          return FormattedOutput(
            text: 'Usage: `get-attachments <id1>, <id2>, ...`\n\nExample: `get-attachments A000, A001`',
          );
        } else {
          final ids = parts.sublist(1).join(' ').split(',').map((s) => s.trim()).toList();
          final paths = trailManager.getAttachmentPaths(ids);
          if (paths.isEmpty) {
            return FormattedOutput(text: 'No matching attachments found.');
          } else {
            // Return file paths as text; actual file sending handled in reply step
            return FormattedOutput(
              text: '📎 Sending ${paths.length} attachment(s)...',
              attachments: paths.map((p) => File(p)).toList(),
            );
          }
        }
        
      case 'get-references':
        if (parts.length < 2) {
          return FormattedOutput(
            text: 'Usage: `get-references <id1>, <id2>, ...`\n\nExample: `get-references R000, R001`',
          );
        } else {
          final ids = parts.sublist(1).join(' ').split(',').map((s) => s.trim()).toList();
          final paths = trailManager.getReferencePaths(ids);
          if (paths.isEmpty) {
            return FormattedOutput(text: 'No matching references found.');
          } else {
            // Return file paths as text; actual file sending handled in reply step
            return FormattedOutput(
              text: '📎 Sending ${paths.length} reference(s)...',
              attachments: paths.map((p) => File(p)).toList(),
            );
          }
        }
        
      default:
        return FormattedOutput(text: '⚠️ Unknown trail command: `$cmd`');
    }
  }

  /// Execute a Copilot Chat prompt and return result with reply entry.
  Future<(ExecutionResult, ReplyEntry)> _executeCopilotPrompt(
    String prompt,
    List<String> receivedAttachments,
  ) async {
    // Notify user we're sending to Copilot (will be captured in output)
    print('🤖 Sending to Copilot Chat...');
    
    // Call Copilot Chat
    final response = await VsCodeHelper.askCopilotChat(prompt);
    
    // Parse response
    final copilotResponse = CopilotChatResponse.fromMap(response);
    
    // Create execution result with Copilot response
    final result = ExecutionResult(
      output: copilotResponse.generatedMarkdown,
      copilotResponse: copilotResponse,
    );
    
    final replyEntry = ReplyEntry(
      markdown: copilotResponse.generatedMarkdown,
      comment: copilotResponse.comment,
      references: copilotResponse.references,
      requestedAttachments: copilotResponse.requestedAttachments,
    );
    
    return (result, replyEntry);
  }

  // ===========================================================================
  // Step 4: Send Unified Reply
  // ===========================================================================

  /// Send unified reply based on execution result.
  Future<void> _sendUnifiedReply(
    PreprocessedMessage msg,
    MessageExecutionResult result,
  ) async {
    // Handle errors
    if (result.hasError) {
      await _sendReply(
        msg.original,
        formatter.formatError('${result.error}'),
      );
      return;
    }
    
    // Handle trail commands (special formatting)
    if (result.isTrailCommand && result.preformattedOutput != null) {
      await _sendReply(msg.original, result.preformattedOutput!);
      
      // Send file attachments if any
      if (result.preformattedOutput!.attachments != null) {
        await _sendFilesAsAttachments(
          msg.original, 
          result.preformattedOutput!.attachments!.map((f) => f.path).toList(),
        );
      }
      return;
    }
    
    // Build the reply text
    // For REPL commands: use ExecutionResult.output (captured by executeCommand's zone)
    // For trail/copilot: use capturedOutput (captured by our zone)
    String replyText;
    
    if (result.executionResult != null && result.executionResult!.output.isNotEmpty) {
      // REPL command - use ExecutionResult.output which has the captured output
      replyText = result.executionResult!.output.trim();
      
      // If there's a return value, append it
      if (result.executionResult!.value != null) {
        final valueStr = '${result.executionResult!.value}';
        replyText = replyText.isNotEmpty ? '$replyText\n→ $valueStr' : '→ $valueStr';
      }
    } else if (result.capturedOutput.trim().isNotEmpty) {
      // Other commands - use capturedOutput from our zone
      replyText = result.capturedOutput.trim();
    } else {
      replyText = '✓ (no output)';
    }
    
    // Format using the captured output, not ExecutionResult.output
    final formatted = formatter.formatRaw(replyText);
    
    // Record exchange in trail
    if (result.replyEntry != null || result.executionResult != null) {
      final exchange = ConversationExchange(
        timestamp: DateTime.now(),
        prompt: PromptEntry(
          text: msg.originalText,
          attachments: msg.receivedAttachments,
        ),
        reply: result.replyEntry ?? ReplyEntry(
          markdown: replyText,
          comment: result.executionResult?.isError == true 
              ? result.executionResult?.errorMessage 
              : null,
        ),
      );
      await trailManager.addExchange(exchange);
    }
    
    await _sendReply(msg.original, formatted);
    
    // Send file attachments from formatter (e.g., full output on truncation)
    if (formatted.attachments != null && formatted.attachments!.isNotEmpty) {
      await _sendFilesAsAttachments(
        msg.original,
        formatted.attachments!.map((f) => f.path).toList(),
      );
    }
    
    // Send Copilot requested attachments if configured
    final copilot = result.executionResult?.copilotResponse;
    if (copilot != null && 
        formatter.config.autoAttachCopilotFiles && 
        copilot.requestedAttachments.isNotEmpty) {
      await _sendFilesAsAttachments(msg.original, copilot.requestedAttachments);
    }
  }

  // ===========================================================================
  // Welcome Messages
  // ===========================================================================

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
        await _debugSendMessage(
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

  // ===========================================================================
  // File Attachments
  // ===========================================================================
  
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
          await _debugSendMessage(
            ChatReceiver.id(original.sender.id),
            '📎 File: $path\n(Could not send as attachment: $e)',
          );
        }
      } else {
        await _debugSendMessage(
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

  // ===========================================================================
  // Reply Sending
  // ===========================================================================

  /// Send a text reply to a message.
  /// Note: File attachments are handled separately via _sendFilesAsAttachments().
  Future<void> _sendReply(ChatMessage original, FormattedOutput output) async {
    await _debugSendMessage(
      ChatReceiver.id(original.sender.id),
      output.text,
      parseMode: output.parseMode,
    );
  }
  
  /// Debug wrapper for sending messages - prints exactly what is sent.
  /// Uses stdout directly to avoid being captured by runZonedGuarded.
  Future<void> _debugSendMessage(
    ChatReceiver receiver,
    String text, {
    String? parseMode,
  }) async {
    stdout.writeln('');
    stdout.writeln('╔════════════════════════════════════════════════════════════');
    stdout.writeln('║ SENDING TO TELEGRAM');
    stdout.writeln('╠════════════════════════════════════════════════════════════');
    stdout.writeln('║ receiver: $receiver');
    stdout.writeln('║ parseMode: $parseMode');
    stdout.writeln('╠════════════════════════════════════════════════════════════');
    stdout.writeln('║ TEXT:');
    stdout.writeln('╠════════════════════════════════════════════════════════════');
    for (final line in text.split('\n')) {
      stdout.writeln('║ $line');
    }
    stdout.writeln('╚════════════════════════════════════════════════════════════');
    stdout.writeln('');
    
    await _telegram.sendMessage(receiver, text, parseMode: parseMode);
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
