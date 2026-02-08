/// Output Formatter for Bot Mode
///
/// Formats REPL output for Telegram messages.
library;

import 'dart:io';

import 'bot_mode_config.dart';

/// Formatted output ready for Telegram.
class FormattedOutput {
  /// The formatted text message.
  final String text;

  /// Optional file attachments.
  final List<File>? attachments;
  
  /// Parse mode for Telegram ('Markdown', 'MarkdownV2', 'HTML', or null for plain text).
  final String? parseMode;

  FormattedOutput({
    required this.text,
    this.attachments,
    this.parseMode,
  });
}

/// Execution result from REPL.
class ExecutionResult {
  /// Captured print output.
  final String output;

  /// Return value (if any).
  final Object? value;

  /// Execution duration.
  final Duration duration;

  /// Whether an error occurred.
  final bool isError;

  /// Error message (if isError is true).
  final String? errorMessage;
  
  /// Optional Copilot Chat response data.
  /// If present, this was a Copilot Chat interaction.
  final CopilotChatResponse? copilotResponse;
  
  /// Whether the output contains pre-formatted text with markdown.
  /// When true, the output should be rendered as markdown, not wrapped in code blocks.
  /// Used for help text, info output, and other formatted displays.
  final bool isFormattedText;

  ExecutionResult({
    required this.output,
    this.value,
    this.duration = Duration.zero,
    this.isError = false,
    this.errorMessage,
    this.copilotResponse,
    this.isFormattedText = false,
  });
}

/// Structured response from Copilot Chat.
class CopilotChatResponse {
  /// The main generated markdown content.
  final String generatedMarkdown;
  
  /// Optional comment/notes from the response.
  final String? comment;
  
  /// File paths referenced while forming the response.
  final List<String> references;
  
  /// File paths the user explicitly requested as attachments.
  final List<String> requestedAttachments;
  
  CopilotChatResponse({
    required this.generatedMarkdown,
    this.comment,
    List<String>? references,
    List<String>? requestedAttachments,
  }) : references = references ?? [],
       requestedAttachments = requestedAttachments ?? [];
  
  /// Create from the Map returned by VsCodeHelper.askCopilotChat.
  factory CopilotChatResponse.fromMap(Map<String, dynamic> map) {
    return CopilotChatResponse(
      generatedMarkdown: map['generatedMarkdown'] as String? ?? '',
      comment: map['comments'] as String?,
      references: (map['references'] as List?)?.cast<String>() ?? [],
      requestedAttachments: (map['requestedAttachments'] as List?)?.cast<String>() ?? [],
    );
  }
}

/// Formats REPL output for Telegram display.
class OutputFormatter {
  final OutputConfig config;
  final String tempDirectory;

  OutputFormatter({
    required this.config,
    this.tempDirectory = '/tmp/telegram-files',
  });

  /// Format an execution result for Telegram.
  FormattedOutput format(ExecutionResult result) {
    var text = result.output;
    List<File>? attachments;

    // Handle error results
    if (result.isError) {
      return FormattedOutput(
        text: '❌ Error: ${result.errorMessage ?? "Unknown error"}',
      );
    }
    
    // Raw passthrough mode: skip all formatting, send directly with Markdown parse mode
    if (config.rawPassthrough) {
      // Just strip ANSI codes and send as-is
      text = _stripAnsi(text);
      return FormattedOutput(
        text: text,
        parseMode: 'Markdown',
      );
    }

    // Strip ANSI codes
    if (config.stripAnsi) {
      text = _stripAnsi(text);
    }

    // Convert console_markdown to plain text (strip color tags, convert bullets)
    if (config.convertMarkdown) {
      text = _convertMarkdownToPlainText(text);
    }
    
    // Use monospace for all output via <pre> tags
    final useMonospace = config.useMonospace && text.isNotEmpty;

    // Wrap in <pre> tag for monospace display
    if (useMonospace) {
      text = '<pre>${_escapeHtml(text)}</pre>';
    }

    // Handle long output
    if (text.length > config.maxOutputChars) {
      final truncated = text.substring(0, config.maxOutputChars);
      final remaining = text.length - config.maxOutputChars;

      text = truncated +
          config.truncationSuffix.replaceAll('{remaining}', remaining.toString());

      if (config.attachFullOutput) {
        attachments = [_createTempFile('output.txt', result.output)];
      }
    }

    // Add result value if present and meaningful
    // Escape for HTML since this is outside the code block
    if (result.value != null) {
      final valueStr = result.value.toString();
      if (valueStr != 'null' && valueStr.isNotEmpty) {
        final escaped = config.useMonospace ? _escapeHtml(valueStr) : valueStr;
        text += '\n\n→ $escaped';
      }
    }

    // Add timing info for slow commands
    if (result.duration.inMilliseconds > 100) {
      text += '\n⏱ ${result.duration.inMilliseconds}ms';
    }
    
    // Handle Copilot Chat response formatting
    if (result.copilotResponse != null) {
      final copilot = result.copilotResponse!;
      final buffer = StringBuffer();
      
      // Add comment at top if present
      if (copilot.comment != null && copilot.comment!.isNotEmpty) {
        buffer.writeln('💬 *Comment:* ${copilot.comment}');
        buffer.writeln();
      }
      
      // List references at top if present
      if (copilot.references.isNotEmpty) {
        buffer.writeln('📚 *References:*');
        for (final ref in copilot.references) {
          buffer.writeln('  • `$ref`');
        }
        buffer.writeln();
      }
      
      // Add the main content
      buffer.write(text);
      
      // Note about attachments at the end
      if (copilot.requestedAttachments.isNotEmpty) {
        buffer.writeln();
        buffer.writeln();
        buffer.writeln('📎 *Attachments available:*');
        for (final att in copilot.requestedAttachments) {
          buffer.writeln('  • `$att`');
        }
      }
      
      text = buffer.toString();
      
      // Auto-attach files from requestedAttachments if configured
      if (config.autoAttachCopilotFiles && copilot.requestedAttachments.isNotEmpty) {
        attachments ??= [];
        for (final path in copilot.requestedAttachments) {
          final file = File(path);
          if (file.existsSync()) {
            attachments.add(file);
          }
        }
      }
    }

    return FormattedOutput(
      text: text, 
      attachments: attachments,
      // Use HTML when we wrap in <pre> tags
      parseMode: useMonospace ? 'HTML' : null,
    );
  }

  /// Format a simple text message.
  FormattedOutput formatText(String text) {
    return format(ExecutionResult(output: text));
  }

  /// Format an error message.
  FormattedOutput formatError(String error) {
    return FormattedOutput(text: '❌ $error');
  }

  /// Format a success message.
  FormattedOutput formatSuccess(String message) {
    return FormattedOutput(text: '✅ $message');
  }

  /// Format a warning message.
  FormattedOutput formatWarning(String message) {
    return FormattedOutput(text: '⚠️ $message');
  }

  /// Format an info message.
  FormattedOutput formatInfo(String message) {
    return FormattedOutput(text: 'ℹ️ $message');
  }

  /// Strip ANSI escape codes from text.
  String _stripAnsi(String text) {
    // Remove ANSI escape codes (colors, cursor movements, etc.)
    return text.replaceAll(RegExp(r'\x1B\[[0-9;]*[a-zA-Z]'), '');
  }

  /// Convert markdown to Telegram-compatible format.
  /// 
  /// Telegram supports a subset of Markdown:
  /// Convert console_markdown to plain text for Telegram.
  /// 
  /// Strips color tags, converts bullets, removes markdown formatting.
  String _convertMarkdownToPlainText(String text) {
    var result = text;

    // Remove console_markdown color tags
    result = result.replaceAll(RegExp(r'<(red|green|yellow|blue|cyan|magenta|white|black|gray)>'), '');
    result = result.replaceAll(RegExp(r'</(red|green|yellow|blue|cyan|magenta|white|black|gray)>'), '');

    // Remove code block markers but keep content
    result = result.replaceAllMapped(
      RegExp(r'```([\s\S]*?)```', multiLine: true),
      (m) => m.group(1)!.trim(),
    );
    
    // Remove inline code markers but keep content
    result = result.replaceAllMapped(
      RegExp(r'`([^`]+)`'),
      (m) => m.group(1)!,
    );

    // Convert markdown headers (# Header → Header)
    result = result.replaceAllMapped(
      RegExp(r'^#{1,6}\s+(.+)$', multiLine: true),
      (m) => m.group(1)!,
    );

    // Remove **bold** markers
    result = result.replaceAllMapped(
      RegExp(r'\*\*(.+?)\*\*'),
      (m) => m.group(1)!,
    );
    
    // Remove *italic* markers (but be careful with wildcards like *.txt)
    // Only remove when there's text between asterisks without spaces at boundaries
    result = result.replaceAllMapped(
      RegExp(r'(?<!\S)\*([^*\s][^*]*[^*\s]|[^*\s])\*(?!\S)'),
      (m) => m.group(1)!,
    );
    
    // Remove __bold__ markers
    result = result.replaceAllMapped(
      RegExp(r'__(.+?)__'),
      (m) => m.group(1)!,
    );

    // Remove _italic_ markers
    result = result.replaceAllMapped(
      RegExp(r'(?<!\S)_([^_\s][^_]*[^_\s]|[^_\s])_(?!\S)'),
      (m) => m.group(1)!,
    );

    // Convert markdown links [text](url) to simple format
    result = result.replaceAllMapped(
      RegExp(r'\[([^\]]+)\]\(([^)]+)\)'),
      (m) => '${m.group(1)} (${m.group(2)})',
    );

    // Convert bullet lists: - item → • item (but not * which could be wildcard)
    result = result.replaceAllMapped(
      RegExp(r'^(\s*)-\s+', multiLine: true),
      (m) => '${m.group(1)}• ',
    );

    // Remove horizontal rules (---, ***, ___)
    result = result.replaceAll(RegExp(r'^[-*_]{3,}$', multiLine: true), '');
    
    // Clean up multiple blank lines
    result = result.replaceAll(RegExp(r'\n{3,}'), '\n\n');

    return result.trim();
  }

  /// Create a temporary file with content.
  File _createTempFile(String name, String content) {
    final dir = Directory(tempDirectory);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final file = File('${dir.path}/${timestamp}_$name');
    file.writeAsStringSync(content);
    return file;
  }
  
  /// Escape HTML special characters.
  String _escapeHtml(String text) {
    return text
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;');
  }
}
