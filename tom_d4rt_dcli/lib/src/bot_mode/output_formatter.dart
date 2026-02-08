/// Output Formatter for Bot Mode
///
/// Formats REPL output for Telegram messages.
library;

import 'dart:io';

import 'bot_mode_config.dart';
import 'telegram_markdown.dart';

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
  /// 
  /// Parses console_markdown and converts to Telegram-compatible Markdown.
  /// Handles truncation at line endings and attaches full output if too long.
  FormattedOutput format(ExecutionResult result) {
    var text = result.output;
    List<File>? attachments;

    // Handle error results
    if (result.isError) {
      return FormattedOutput(
        text: '❌ Error: ${result.errorMessage ?? "Unknown error"}',
      );
    }

    // Add result value if present and meaningful
    if (result.value != null) {
      final valueStr = result.value.toString();
      if (valueStr != 'null' && valueStr.isNotEmpty) {
        text += '\n\n→ $valueStr';
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
        buffer.writeln('💬 Comment: ${copilot.comment}');
        buffer.writeln();
      }
      
      // List references at top if present
      if (copilot.references.isNotEmpty) {
        buffer.writeln('📚 References:');
        for (final ref in copilot.references) {
          buffer.writeln('  • $ref');
        }
        buffer.writeln();
      }
      
      // Add the main content
      buffer.write(text);
      
      // Note about attachments at the end
      if (copilot.requestedAttachments.isNotEmpty) {
        buffer.writeln();
        buffer.writeln();
        buffer.writeln('📎 Attachments available:');
        for (final att in copilot.requestedAttachments) {
          buffer.writeln('  • $att');
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

    // Parse and convert to Telegram markdown, with truncation
    final prepared = prepareForTelegram(text, maxChars: config.maxOutputChars);
    
    // Handle single long line - send as attachment only
    if (prepared.isSingleLongLine) {
      attachments ??= [];
      attachments.add(_createTempFile('output.txt', result.output));
      return FormattedOutput(
        text: prepared.text,
        attachments: attachments,
        parseMode: null, // Plain text for the "(Line too long)" message
      );
    }
    
    // Attach full output if truncated
    if (prepared.wasTruncated && config.attachFullOutput) {
      attachments ??= [];
      attachments.add(_createTempFile('output.txt', result.output));
    }

    return FormattedOutput(
      text: prepared.text, 
      attachments: attachments,
      parseMode: 'MarkdownV2',
    );
  }

  /// Format a simple text message.
  FormattedOutput formatText(String text) {
    return format(ExecutionResult(output: text));
  }

  /// Format raw text output (e.g., captured print output).
  ///
  /// Delegates to [format] with an ExecutionResult wrapper.
  /// This ensures all formatting logic (truncation, attachments, etc.) is handled consistently.
  FormattedOutput formatRaw(String text) {
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
}
