/// Conversation Trail Storage
///
/// Stores and manages the history of prompts and responses for bot mode.
/// Tracks prompts, responses, attachments, and references.
library;

import 'dart:collection';
import 'dart:io';

/// A single exchange in the conversation trail.
class ConversationExchange {
  /// Timestamp of the exchange.
  final DateTime timestamp;

  /// The prompt received from the user.
  final PromptEntry prompt;

  /// The reply generated.
  final ReplyEntry reply;

  ConversationExchange({
    required this.timestamp,
    required this.prompt,
    required this.reply,
  });

  /// Format as markdown for trail file.
  String toTrailMarkdown() {
    final buffer = StringBuffer();
    buffer.writeln('## EXCHANGE: ${_formatTimestamp(timestamp)}');
    buffer.writeln();
    buffer.writeln('### PROMPT');
    buffer.writeln();
    buffer.writeln('#### PROMPT TEXT');
    buffer.writeln(prompt.text);
    buffer.writeln();
    buffer.writeln('#### PROMPT ATTACHMENTS');
    for (final path in prompt.attachments) {
      buffer.writeln(path);
    }
    buffer.writeln();
    buffer.writeln('### REPLY');
    buffer.writeln();
    buffer.writeln('#### COMMENT');
    buffer.writeln(reply.comment);
    buffer.writeln();
    buffer.writeln('#### MARKDOWN');
    buffer.writeln(reply.markdown);
    buffer.writeln();
    buffer.writeln('#### REFERENCES');
    for (final path in reply.references) {
      buffer.writeln(path);
    }
    buffer.writeln();
    buffer.writeln('#### ATTACHMENTS');
    for (final path in reply.requestedAttachments) {
      buffer.writeln(path);
    }
    buffer.writeln();
    return buffer.toString();
  }

  static String _formatTimestamp(DateTime dt) {
    return '${dt.year}-${_pad(dt.month)}-${_pad(dt.day)} '
        '${_pad(dt.hour)}:${_pad(dt.minute)}:${_pad(dt.second)}';
  }

  static String _pad(int n) => n.toString().padLeft(2, '0');
}

/// Prompt entry in the conversation trail.
class PromptEntry {
  /// The prompt text from the user.
  final String text;

  /// File paths of attachments received with the prompt.
  final List<String> attachments;

  PromptEntry({
    required this.text,
    List<String>? attachments,
  }) : attachments = attachments ?? [];
}

/// Reply entry in the conversation trail.
class ReplyEntry {
  /// The main markdown response.
  final String markdown;

  /// Optional comment from the response.
  final String comment;

  /// File paths referenced while forming the response.
  final List<String> references;

  /// File paths the user explicitly requested.
  final List<String> requestedAttachments;

  ReplyEntry({
    required this.markdown,
    String? comment,
    List<String>? references,
    List<String>? requestedAttachments,
  })  : comment = comment ?? '',
        references = references ?? [],
        requestedAttachments = requestedAttachments ?? [];
}

/// Manages the conversation trail for a bot session.
class ConversationTrailManager {
  /// Maximum number of exchanges to keep in memory.
  final int maxEntries;

  /// Tool name (e.g., 'dcli', 'd4rt').
  final String toolName;

  /// Bot name for file paths.
  final String botName;

  /// Base directory for storage (`~/.tom/<tool>/<botname>/`).
  late final String _baseDir;

  /// In-memory storage of recent exchanges (FIFO queue).
  final Queue<ConversationExchange> _exchanges = Queue();

  /// Trail file handle for persistent storage.
  File? _trailFile;

  /// Whether the trail has been initialized.
  bool _initialized = false;

  ConversationTrailManager({
    required this.toolName,
    required this.botName,
    this.maxEntries = 50,
  }) {
    final home = Platform.environment['HOME'] ?? 
                 Platform.environment['USERPROFILE'] ?? 
                 '.';
    _baseDir = '$home/.tom/$toolName/$botName';
  }

  /// Get all attachments from all exchanges with their IDs.
  /// Returns map of ID (A000, A001, ...) to file path.
  Map<String, String> get allAttachments {
    final result = <String, String>{};
    var index = 0;
    for (final exchange in _exchanges) {
      for (final path in exchange.reply.requestedAttachments) {
        result['A${index.toString().padLeft(3, '0')}'] = path;
        index++;
      }
    }
    return result;
  }

  /// Get all references from all exchanges with their IDs.
  /// Returns map of ID (R000, R001, ...) to file path.
  Map<String, String> get allReferences {
    final result = <String, String>{};
    var index = 0;
    for (final exchange in _exchanges) {
      for (final path in exchange.reply.references) {
        result['R${index.toString().padLeft(3, '0')}'] = path;
        index++;
      }
    }
    return result;
  }

  /// Get file paths for given attachment IDs.
  List<String> getAttachmentPaths(List<String> ids) {
    final attachments = allAttachments;
    return ids
        .map((id) => attachments[id.toUpperCase()])
        .whereType<String>()
        .toList();
  }

  /// Get file paths for given reference IDs.
  List<String> getReferencePaths(List<String> ids) {
    final references = allReferences;
    return ids
        .map((id) => references[id.toUpperCase()])
        .whereType<String>()
        .toList();
  }

  /// Initialize the trail manager and create necessary directories.
  Future<void> initialize() async {
    if (_initialized) return;

    // Create base directory
    final baseDir = Directory(_baseDir);
    if (!await baseDir.exists()) {
      await baseDir.create(recursive: true);
    }

    // Create received files directory
    final receivedDir = Directory('$_baseDir/received');
    if (!await receivedDir.exists()) {
      await receivedDir.create(recursive: true);
    }

    // Create/append to trail file
    _trailFile = File('$_baseDir/trail.txt');
    final header = '# CHAT TRAIL $botName STARTED ${ConversationExchange._formatTimestamp(DateTime.now())}\n\n';
    
    if (await _trailFile!.exists()) {
      // Append separator for new session
      await _trailFile!.writeAsString('\n---\n\n$header', mode: FileMode.append);
    } else {
      await _trailFile!.writeAsString(header);
    }

    _initialized = true;
  }

  /// Add a new exchange to the trail.
  Future<void> addExchange(ConversationExchange exchange) async {
    if (!_initialized) {
      await initialize();
    }

    // Add to in-memory queue
    _exchanges.addLast(exchange);

    // Trim if over limit
    while (_exchanges.length > maxEntries) {
      _exchanges.removeFirst();
    }

    // Append to trail file
    if (_trailFile != null) {
      await _trailFile!.writeAsString(
        exchange.toTrailMarkdown(),
        mode: FileMode.append,
      );
    }
  }

  /// Save a received file attachment.
  /// Returns the full path where the file was saved.
  Future<String> saveReceivedFile(String originalFilename, List<int> data) async {
    if (!_initialized) {
      await initialize();
    }

    final timestamp = DateTime.now();
    final tsString = '${timestamp.year}'
        '${ConversationExchange._pad(timestamp.month)}'
        '${ConversationExchange._pad(timestamp.day)}_'
        '${ConversationExchange._pad(timestamp.hour)}'
        '${ConversationExchange._pad(timestamp.minute)}'
        '${ConversationExchange._pad(timestamp.second)}';
    
    final safeFilename = originalFilename.replaceAll(RegExp(r'[^\w\.\-]'), '_');
    final fullPath = '$_baseDir/received/${tsString}_$safeFilename';
    
    final file = File(fullPath);
    await file.writeAsBytes(data);
    
    return fullPath;
  }

  /// Get all exchanges (for iteration).
  Iterable<ConversationExchange> get exchanges => _exchanges;

  /// Get the directory where received files are stored.
  String get receivedFilesDirectory => '$_baseDir/received';

  /// Get the trail file path.
  String get trailFilePath => '$_baseDir/trail.txt';
}
