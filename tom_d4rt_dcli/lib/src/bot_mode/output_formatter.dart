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

    // Strip ANSI codes
    if (config.stripAnsi) {
      text = _stripAnsi(text);
    }

    // Convert console_markdown to Telegram format
    if (config.convertMarkdown) {
      text = _convertMarkdown(text);
    }
    
    // For formatted text (help, info), escape for MarkdownV2 but don't wrap in code block
    // For code output, wrap in code block
    final useCodeBlock = config.useMonospace && text.isNotEmpty && !result.isFormattedText;
    
    if (result.isFormattedText && text.isNotEmpty) {
      // Escape special MarkdownV2 characters outside of already-formatted content
      text = _escapeMarkdownV2ForFormattedText(text);
    }

    // Wrap in code block if non-empty and not formatted text
    if (useCodeBlock) {
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
    // Escape for MarkdownV2 since this is outside the code block
    if (result.value != null) {
      final valueStr = result.value.toString();
      if (valueStr != 'null' && valueStr.isNotEmpty) {
        final escaped = config.useMonospace ? _escapeMarkdownV2(valueStr) : valueStr;
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
      // Use MarkdownV2 when we have code blocks or formatted content
      parseMode: (config.useMonospace || result.isFormattedText) ? 'MarkdownV2' : null,
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
  /// - *bold* or **bold** → *bold*
  /// - _italic_ → _italic_
  /// - `code` → `code`
  /// - ```code block``` → ```code block```
  /// - [text](url) → text (url) - links simplified
  /// - # headers → **header** (bold)
  String _convertMarkdown(String text) {
    var result = text;

    // Remove console_markdown color tags
    result = result.replaceAll(RegExp(r'<(red|green|yellow|blue|cyan|magenta|white|black|gray)>'), '');
    result = result.replaceAll(RegExp(r'</(red|green|yellow|blue|cyan|magenta|white|black|gray)>'), '');

    // Preserve code blocks first (don't process inside them)
    final codeBlocks = <String>[];
    result = result.replaceAllMapped(
      RegExp(r'```[\s\S]*?```', multiLine: true),
      (m) {
        codeBlocks.add(m.group(0)!);
        return '\x00CODE_BLOCK_${codeBlocks.length - 1}\x00';
      },
    );
    
    // Preserve inline code
    final inlineCode = <String>[];
    result = result.replaceAllMapped(
      RegExp(r'`[^`]+`'),
      (m) {
        inlineCode.add(m.group(0)!);
        return '\x00INLINE_CODE_${inlineCode.length - 1}\x00';
      },
    );

    // Convert markdown headers to bold (# Header → *Header*)
    result = result.replaceAllMapped(
      RegExp(r'^#{1,6}\s+(.+)$', multiLine: true),
      (m) => '*${m.group(1)}*',
    );

    // Convert **bold** to *bold* (Telegram format)
    result = result.replaceAllMapped(
      RegExp(r'\*\*(.+?)\*\*'),
      (m) => '*${m.group(1)}*',
    );
    
    // Convert __bold__ to *bold* (alternative bold syntax)
    result = result.replaceAllMapped(
      RegExp(r'__(.+?)__'),
      (m) => '*${m.group(1)}*',
    );

    // Convert markdown links [text](url) to simple format
    result = result.replaceAllMapped(
      RegExp(r'\[([^\]]+)\]\(([^)]+)\)'),
      (m) => '${m.group(1)} (${m.group(2)})',
    );

    // Convert bullet lists: - item or * item → • item
    result = result.replaceAllMapped(
      RegExp(r'^[\s]*[-*]\s+', multiLine: true),
      (m) => '• ',
    );
    
    // Convert numbered lists: 1. item → 1. item (keep as is, just clean up spacing)
    result = result.replaceAllMapped(
      RegExp(r'^(\s*\d+)\.\s+', multiLine: true),
      (m) => '${m.group(1)}. ',
    );

    // Remove horizontal rules (---, ***, ___)
    result = result.replaceAll(RegExp(r'^[-*_]{3,}$', multiLine: true), '');
    
    // Clean up multiple blank lines
    result = result.replaceAll(RegExp(r'\n{3,}'), '\n\n');

    // Restore code blocks
    for (var i = 0; i < codeBlocks.length; i++) {
      result = result.replaceFirst('\x00CODE_BLOCK_$i\x00', codeBlocks[i]);
    }
    
    // Restore inline code
    for (var i = 0; i < inlineCode.length; i++) {
      result = result.replaceFirst('\x00INLINE_CODE_$i\x00', inlineCode[i]);
    }

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
  
  /// Escape special characters for Telegram's MarkdownV2.
  /// 
  /// Characters that need escaping outside of code blocks:
  /// _ * [ ] ( ) ~ ` > # + - = | { } . !
  String _escapeMarkdownV2(String text) {
    // List of special characters that need escaping in MarkdownV2
    const specialChars = r'_*[]()~`>#+-=|{}.!';
    final buffer = StringBuffer();
    
    for (var i = 0; i < text.length; i++) {
      final char = text[i];
      if (specialChars.contains(char)) {
        buffer.write('\\');
      }
      buffer.write(char);
    }
    
    return buffer.toString();
  }
  
  /// Escape special characters for MarkdownV2 while preserving formatting.
  /// 
  /// This method escapes characters that break MarkdownV2 parsing while
  /// preserving intentional formatting like *bold*, _italic_, and `code`.
  String _escapeMarkdownV2ForFormattedText(String text) {
    // Characters to escape (excluding * _ ` which are used for formatting)
    // Must escape: ( ) [ ] ~ > # + - = | { } . !
    const escapeChars = r'()[]~>#+-=|{}.!';
    final buffer = StringBuffer();
    
    for (var i = 0; i < text.length; i++) {
      final char = text[i];
      if (escapeChars.contains(char)) {
        buffer.write('\\');
      }
      buffer.write(char);
    }
    
    return buffer.toString();
  }
}
