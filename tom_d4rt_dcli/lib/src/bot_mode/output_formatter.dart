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

  FormattedOutput({
    required this.text,
    this.attachments,
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

  ExecutionResult({
    required this.output,
    this.value,
    this.duration = Duration.zero,
    this.isError = false,
    this.errorMessage,
    this.copilotResponse,
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

    // Strip ANSI codes
    if (config.stripAnsi) {
      text = _stripAnsi(text);
    }

    // Convert console_markdown to Telegram format
    if (config.convertMarkdown) {
      text = _convertMarkdown(text);
    }

    // Wrap in code block if non-empty
    if (config.useMonospace && text.isNotEmpty) {
      text = '```\n$text\n```';
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

    return FormattedOutput(text: text, attachments: attachments);
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

  /// Convert console_markdown to Telegram markdown.
  String _convertMarkdown(String text) {
    // console_markdown uses patterns like **bold**, <yellow>text</yellow>
    // Telegram MarkdownV2 uses *bold*, _italic_, `code`

    var result = text;

    // Remove console_markdown color tags
    result = result.replaceAll(RegExp(r'<(red|green|yellow|blue|cyan|magenta|white|black|gray)>'), '');
    result = result.replaceAll(RegExp(r'</(red|green|yellow|blue|cyan|magenta|white|black|gray)>'), '');

    // Convert **bold** to *bold* (Telegram format)
    // Note: Telegram MarkdownV2 actually uses *bold* for bold
    result = result.replaceAllMapped(
      RegExp(r'\*\*(.+?)\*\*'),
      (m) => '*${m.group(1)}*',
    );

    return result;
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
