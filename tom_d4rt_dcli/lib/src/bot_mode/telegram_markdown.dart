/// Telegram Markdown Parser and Converter
///
/// Parses console_markdown and converts to Telegram-compatible Markdown.
library;

/// A parsed segment of text - either plain text or a formatted span.
sealed class MarkdownSegment {
  const MarkdownSegment();
}

/// Plain text segment (no formatting).
class TextSegment extends MarkdownSegment {
  final String text;
  const TextSegment(this.text);
  
  @override
  String toString() => 'Text("$text")';
}

/// Formatted text segment with a tag.
class FormattedSegment extends MarkdownSegment {
  /// The tag type (e.g., 'bold', 'italic', 'code', 'color').
  final MarkdownTag tag;
  
  /// The content inside the tag.
  final String content;
  
  const FormattedSegment(this.tag, this.content);
  
  @override
  String toString() => 'Formatted($tag, "$content")';
}

/// Types of markdown tags we recognize.
enum MarkdownTag {
  /// **bold** or __bold__
  bold,
  
  /// *italic* or _italic_
  italic,
  
  /// `code`
  inlineCode,
  
  /// ```code block```
  codeBlock,
  
  /// [text](url)
  link,
  
  /// `<color>text</color>` - console_markdown color tags
  color,
  
  /// ~strikethrough~ (MarkdownV2)
  strikethrough,
  
  /// ||spoiler|| (MarkdownV2)
  spoiler,
}

/// Mapping from source format to Telegram format.
class TelegramMarkdownConverter {
  /// Parse console_markdown text into segments.
  /// 
  /// Recognizes:
  /// - Color tags: `<yellow>text</yellow>`, `<cyan>text</cyan>`, etc.
  /// - Bold: **text** or __text__
  /// - Italic: *text* or _text_
  /// - Code: `text` or ```text```
  /// - Links: [text](url)
  static List<MarkdownSegment> parse(String text) {
    final segments = <MarkdownSegment>[];
    final buffer = StringBuffer();
    var i = 0;
    
    while (i < text.length) {
      // Check for color tags: <color>...</color>
      final colorMatch = _matchColorTag(text, i);
      if (colorMatch != null) {
        if (buffer.isNotEmpty) {
          segments.add(TextSegment(buffer.toString()));
          buffer.clear();
        }
        segments.add(FormattedSegment(MarkdownTag.color, colorMatch.content));
        i = colorMatch.endIndex;
        continue;
      }
      
      // Check for code block: ```...```
      if (text.startsWith('```', i)) {
        final endIndex = text.indexOf('```', i + 3);
        if (endIndex != -1) {
          if (buffer.isNotEmpty) {
            segments.add(TextSegment(buffer.toString()));
            buffer.clear();
          }
          final content = text.substring(i + 3, endIndex);
          segments.add(FormattedSegment(MarkdownTag.codeBlock, content));
          i = endIndex + 3;
          continue;
        }
      }
      
      // Check for inline code: `...`
      if (text[i] == '`' && !text.startsWith('```', i)) {
        final endIndex = text.indexOf('`', i + 1);
        if (endIndex != -1 && !text.substring(i + 1, endIndex).contains('\n')) {
          if (buffer.isNotEmpty) {
            segments.add(TextSegment(buffer.toString()));
            buffer.clear();
          }
          final content = text.substring(i + 1, endIndex);
          segments.add(FormattedSegment(MarkdownTag.inlineCode, content));
          i = endIndex + 1;
          continue;
        }
      }
      
      // Check for bold: **...**
      if (text.startsWith('**', i)) {
        final endIndex = _findDoubleDelimiter(text, i + 2, '**');
        if (endIndex != -1) {
          if (buffer.isNotEmpty) {
            segments.add(TextSegment(buffer.toString()));
            buffer.clear();
          }
          final content = text.substring(i + 2, endIndex);
          segments.add(FormattedSegment(MarkdownTag.bold, content));
          i = endIndex + 2;
          continue;
        }
      }
      
      // Check for bold: __...__
      if (text.startsWith('__', i)) {
        final endIndex = _findDoubleDelimiter(text, i + 2, '__');
        if (endIndex != -1) {
          if (buffer.isNotEmpty) {
            segments.add(TextSegment(buffer.toString()));
            buffer.clear();
          }
          final content = text.substring(i + 2, endIndex);
          segments.add(FormattedSegment(MarkdownTag.bold, content));
          i = endIndex + 2;
          continue;
        }
      }
      
      // Check for italic: *...* (but not **)
      if (text[i] == '*' && !text.startsWith('**', i)) {
        final endIndex = _findMatchingDelimiter(text, i + 1, '*');
        if (endIndex != -1) {
          // Make sure it's not a wildcard like *.txt
          final content = text.substring(i + 1, endIndex);
          if (!content.contains(' ') || (content.length > 1 && !content.startsWith(' ') && !content.endsWith(' '))) {
            if (_isWordBoundary(text, i) && _isWordBoundary(text, endIndex + 1)) {
              if (buffer.isNotEmpty) {
                segments.add(TextSegment(buffer.toString()));
                buffer.clear();
              }
              segments.add(FormattedSegment(MarkdownTag.italic, content));
              i = endIndex + 1;
              continue;
            }
          }
        }
      }
      
      // Check for italic: _..._ (but not __)
      if (text[i] == '_' && !text.startsWith('__', i)) {
        final endIndex = _findMatchingDelimiter(text, i + 1, '_');
        if (endIndex != -1) {
          final content = text.substring(i + 1, endIndex);
          // Don't match file patterns like _.txt
          if (content.isNotEmpty && !content.startsWith('.') && !content.contains('/')) {
            if (_isWordBoundary(text, i) && _isWordBoundary(text, endIndex + 1)) {
              if (buffer.isNotEmpty) {
                segments.add(TextSegment(buffer.toString()));
                buffer.clear();
              }
              segments.add(FormattedSegment(MarkdownTag.italic, content));
              i = endIndex + 1;
              continue;
            }
          }
        }
      }
      
      // Check for link: [text](url)
      if (text[i] == '[') {
        final linkMatch = _matchLink(text, i);
        if (linkMatch != null) {
          if (buffer.isNotEmpty) {
            segments.add(TextSegment(buffer.toString()));
            buffer.clear();
          }
          segments.add(FormattedSegment(MarkdownTag.link, '${linkMatch.text}|${linkMatch.url}'));
          i = linkMatch.endIndex;
          continue;
        }
      }
      
      // Regular character
      buffer.write(text[i]);
      i++;
    }
    
    // Add remaining text
    if (buffer.isNotEmpty) {
      segments.add(TextSegment(buffer.toString()));
    }
    
    return segments;
  }
  
  /// Convert parsed segments to Telegram Markdown.
  /// 
  /// - Strips color tags (Telegram doesn't support colors)
  /// - Converts **bold** to *bold*
  /// - Keeps *italic* as _italic_
  /// - Keeps `code` as `code`
  /// - Escapes special characters in plain text
  static String toTelegramMarkdown(List<MarkdownSegment> segments) {
    final buffer = StringBuffer();
    
    for (final segment in segments) {
      switch (segment) {
        case TextSegment(:final text):
          buffer.write(_escapeForTelegram(text));
        case FormattedSegment(:final tag, :final content):
          switch (tag) {
            case MarkdownTag.bold:
              buffer.write('*${_escapeForTelegram(content)}*');
            case MarkdownTag.italic:
              buffer.write('_${_escapeForTelegram(content)}_');
            case MarkdownTag.inlineCode:
              // Code content is not escaped
              buffer.write('`$content`');
            case MarkdownTag.codeBlock:
              // Code block content is not escaped
              buffer.write('```$content```');
            case MarkdownTag.link:
              final parts = content.split('|');
              if (parts.length == 2) {
                buffer.write('[${_escapeForTelegram(parts[0])}](${parts[1]})');
              } else {
                buffer.write(_escapeForTelegram(content));
              }
            case MarkdownTag.color:
              // Strip color tags, just output the content escaped
              buffer.write(_escapeForTelegram(content));
            case MarkdownTag.strikethrough:
              buffer.write('~${_escapeForTelegram(content)}~');
            case MarkdownTag.spoiler:
              buffer.write('||${_escapeForTelegram(content)}||');
          }
      }
    }
    
    return buffer.toString();
  }
  
  /// Escape special characters for Telegram Markdown.
  /// 
  /// In legacy Markdown mode, we must escape:
  /// - * _ ` [ ] ( ) that could be misinterpreted as formatting
  static String _escapeForTelegram(String text) {
    final buffer = StringBuffer();
    
    for (var i = 0; i < text.length; i++) {
      final char = text[i];
      
      // Escape characters that could break Telegram's markdown parser
      switch (char) {
        case '*':
        case '_':
        case '`':
        case '[':
        case ']':
          // Escape with backslash
          buffer.write('\\');
          buffer.write(char);
        default:
          buffer.write(char);
      }
    }
    
    return buffer.toString();
  }
  
  /// Check if position is at a word boundary.
  static bool _isWordBoundary(String text, int pos) {
    if (pos <= 0 || pos >= text.length) return true;
    final charBefore = text[pos - 1];
    return charBefore == ' ' || charBefore == '\n' || charBefore == '\t' ||
           charBefore == '(' || charBefore == '[' || charBefore == '{';
  }
  
  /// Find matching delimiter, skipping escaped ones.
  static int _findMatchingDelimiter(String text, int start, String delimiter) {
    for (var i = start; i < text.length; i++) {
      if (text[i] == '\n') return -1; // Don't span lines for inline formatting
      if (text.startsWith(delimiter, i)) {
        // Make sure it's not escaped
        if (i == 0 || text[i - 1] != '\\') {
          return i;
        }
      }
    }
    return -1;
  }
  
  /// Find matching double delimiter (** or __).
  /// Unlike _findMatchingDelimiter, allows spanning lines for bold.
  static int _findDoubleDelimiter(String text, int start, String delimiter) {
    for (var i = start; i < text.length - 1; i++) {
      if (text.startsWith(delimiter, i)) {
        // Make sure it's not escaped
        if (i == 0 || text[i - 1] != '\\') {
          return i;
        }
      }
    }
    return -1;
  }
  
  /// Match a color tag at position.
  static _ColorTagMatch? _matchColorTag(String text, int pos) {
    if (text[pos] != '<') return null;
    
    const colors = ['red', 'green', 'yellow', 'blue', 'cyan', 'magenta', 'white', 'black', 'gray'];
    
    for (final color in colors) {
      final openTag = '<$color>';
      final closeTag = '</$color>';
      
      if (text.startsWith(openTag, pos)) {
        final closeIndex = text.indexOf(closeTag, pos + openTag.length);
        if (closeIndex != -1) {
          return _ColorTagMatch(
            content: text.substring(pos + openTag.length, closeIndex),
            endIndex: closeIndex + closeTag.length,
          );
        }
      }
    }
    
    return null;
  }
  
  /// Match a markdown link at position.
  static _LinkMatch? _matchLink(String text, int pos) {
    if (text[pos] != '[') return null;
    
    final closeBracket = text.indexOf(']', pos + 1);
    if (closeBracket == -1) return null;
    
    if (closeBracket + 1 >= text.length || text[closeBracket + 1] != '(') return null;
    
    final closeParen = text.indexOf(')', closeBracket + 2);
    if (closeParen == -1) return null;
    
    return _LinkMatch(
      text: text.substring(pos + 1, closeBracket),
      url: text.substring(closeBracket + 2, closeParen),
      endIndex: closeParen + 1,
    );
  }
}

class _ColorTagMatch {
  final String content;
  final int endIndex;
  _ColorTagMatch({required this.content, required this.endIndex});
}

class _LinkMatch {
  final String text;
  final String url;
  final int endIndex;
  _LinkMatch({required this.text, required this.url, required this.endIndex});
}

/// Result of preparing text for Telegram.
class TelegramPreparedMessage {
  /// The formatted message text.
  final String text;
  
  /// Whether the message was truncated.
  final bool wasTruncated;
  
  /// Whether the message is too long even after truncation (single long line).
  final bool isSingleLongLine;
  
  /// Number of characters remaining (if truncated).
  final int remainingChars;
  
  const TelegramPreparedMessage({
    required this.text,
    this.wasTruncated = false,
    this.isSingleLongLine = false,
    this.remainingChars = 0,
  });
}

/// Prepare text for sending to Telegram.
/// 
/// - Parses and converts markdown
/// - Truncates at line ending if too long
/// - Handles single long line case
TelegramPreparedMessage prepareForTelegram(String text, {int maxChars = 4000}) {
  // First, strip ANSI escape codes
  final stripped = text.replaceAll(RegExp(r'\x1B\[[0-9;]*[a-zA-Z]'), '');
  
  // Parse and convert to Telegram markdown
  final segments = TelegramMarkdownConverter.parse(stripped);
  final converted = TelegramMarkdownConverter.toTelegramMarkdown(segments);
  
  // Check if truncation needed
  if (converted.length <= maxChars) {
    return TelegramPreparedMessage(text: converted);
  }
  
  // Find last newline before limit for clean truncation
  final lastNewline = converted.lastIndexOf('\n', maxChars);
  
  // If no newline in first half, it's a single long line
  if (lastNewline < maxChars ~/ 2) {
    // Check if the entire text is just one long line
    if (!converted.contains('\n') || converted.indexOf('\n') > maxChars) {
      return TelegramPreparedMessage(
        text: '(Line too long - sent as attachment)',
        wasTruncated: true,
        isSingleLongLine: true,
        remainingChars: converted.length,
      );
    }
  }
  
  // Truncate at last newline
  final cutPoint = lastNewline > 0 ? lastNewline : maxChars;
  final truncated = converted.substring(0, cutPoint);
  final remaining = converted.length - cutPoint;
  
  return TelegramPreparedMessage(
    text: '$truncated\n\n... [$remaining more chars]',
    wasTruncated: true,
    remainingChars: remaining,
  );
}
