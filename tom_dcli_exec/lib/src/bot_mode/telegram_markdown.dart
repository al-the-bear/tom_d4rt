/// Telegram MarkdownV2 Converter
///
/// Converts console_markdown formatted text to Telegram MarkdownV2 format.
/// Uses the `marked` package (same parser as `console_markdown`) to parse
/// formatting patterns, then converts them to Telegram-compatible syntax.
///
/// ## Conversion Pipeline
///
/// 1. Strip ANSI escape codes
/// 2. Extract code blocks, inline code, and links (regex pre-processing)
/// 3. Strip dynamic color/console tags (regex)
/// 4. Parse console_markdown formatting via `marked` → placeholder tokens
/// 5. Escape MarkdownV2 special chars in plain text segments
/// 6. Replace placeholder tokens with MarkdownV2 delimiters
/// 7. Restore extracted code blocks and links
///
/// ## Telegram MarkdownV2 Reference
///
/// Supported formatting:
/// - `*bold*`, `_italic_`, `__underline__`, `~strikethrough~`, `||spoiler||`
/// - `` `inline code` ``, ``` ```code block``` ```
/// - `[text](url)` links
///
/// Characters that must be escaped in plain text:
/// `_ * [ ] ( ) ~ \` > # + - = | { } . !`
library;

import 'package:marked/marked.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// Placeholder Token System
// ═══════════════════════════════════════════════════════════════════════════════

/// Unicode Private Use Area characters used as placeholder delimiters.
/// These won't appear in normal text content.
const _fmtStart = '\uE000'; // format marker start
const _fmtEnd = '\uE001'; // format marker end
const _extStart = '\uE010'; // extraction token start
const _extEnd = '\uE011'; // extraction token end

/// Create a format marker placeholder (for marked parser output).
String _fmt(String id) => '$_fmtStart$id$_fmtEnd';

/// Create an extraction placeholder (for pre-extracted content).
String _ext(int id) => '$_extStart$id$_extEnd';

// ═══════════════════════════════════════════════════════════════════════════════
// MarkdownV2 Escaping
// ═══════════════════════════════════════════════════════════════════════════════

/// Characters that must be escaped in Telegram MarkdownV2 plain text.
/// Per Telegram docs: _ * [ ] ( ) ~ ` > # + - = | { } . !
final _mdV2SpecialChars = RegExp(r'[_*\[\]()~`>#\+\-=|{}.!\\]');

/// Escape text for MarkdownV2 plain text context.
String _escapePlainText(String text) {
  return text.replaceAllMapped(_mdV2SpecialChars, (m) => '\\${m[0]}');
}

/// Escape text for MarkdownV2 code context (only ` and \ need escaping).
String _escapeCodeText(String text) {
  return text.replaceAllMapped(RegExp(r'[`\\]'), (m) => '\\${m[0]}');
}

/// Escape text for MarkdownV2 link URL context (only ) and \ need escaping).
String _escapeLinkUrl(String text) {
  return text.replaceAllMapped(RegExp(r'[)\\]'), (m) => '\\${m[0]}');
}

// ═══════════════════════════════════════════════════════════════════════════════
// Marked Parser Definition
// ═══════════════════════════════════════════════════════════════════════════════

/// Console markdown → format-marker placeholders.
///
/// Mirrors the patterns defined in `ConsoleMarkdown` (from the
/// `console_markdown` package) but outputs placeholder tokens instead of
/// ANSI escape codes. Patterns with no Telegram equivalent simply return
/// the inner text (stripping the formatting).
///
/// See the `console_markdown` package README and source for the full list
/// of supported patterns.
// ignore: non_constant_identifier_names
final _ConsoleToPlaceholders = Markdown.map({
  // ─── Formatting Symbols (from ConsoleMarkdownSymbols) ─────────────────

  // Bold: **text** → Telegram *text*
  '[**]': (text, match) => '${_fmt('B')}$text${_fmt('/B')}',

  // Italic: *text* → Telegram _text_
  '[*]': (text, match) => '${_fmt('I')}$text${_fmt('/I')}',

  // Double-underline: ___text___ → no Telegram equivalent, strip
  '[___]': (text, match) => text,

  // Underline: __text__ → Telegram __text__
  '[__]': (text, match) => '${_fmt('U')}$text${_fmt('/U')}',

  // Strikethrough: ~~text~~ → Telegram ~text~
  '[~~]': (text, match) => '${_fmt('S')}$text${_fmt('/S')}',

  // Rapid-blink: !!!text!!! → no Telegram equivalent, strip
  '[!!!]': (text, match) => text,

  // Blink: !!text!! → no Telegram equivalent, strip
  '[!!]': (text, match) => text,

  // Dim: `text` (backtick in console_markdown) → strip
  // Note: Standard inline code is extracted by regex before this parser runs,
  // so this only catches console_markdown dim formatting that survived.
  '[`]': (text, match) => text,

  // Hidden: ||text|| → Telegram ||spoiler||
  '[||]': (text, match) => '${_fmt('SP')}$text${_fmt('/SP')}',

  // Inverse: ^^text^^ → no Telegram equivalent, strip
  '[^^]': (text, match) => text,

  // Superscript: ^text^ → no Telegram equivalent, strip
  '[^]': (text, match) => text,

  // Subscript: ~text~ → no Telegram equivalent, strip
  '[~]': (text, match) => text,

  // ─── Color Tags — strip (Telegram has no color support) ───────────────
  // The `background` property is listed so the tag also matches
  // `<red background>text</red>` etc.

  '<black background>': (text, match) => text,
  '<red background>': (text, match) => text,
  '<green background>': (text, match) => text,
  '<yellow background>': (text, match) => text,
  '<blue background>': (text, match) => text,
  '<magenta background>': (text, match) => text,
  '<cyan background>': (text, match) => text,
  '<white background>': (text, match) => text,
  '<gray background>': (text, match) => text,

  // ─── HTML-like Tags with Telegram Equivalents ─────────────────────────

  '<bold>': (text, match) => '${_fmt('B')}$text${_fmt('/B')}',
  '<b>': (text, match) => '${_fmt('B')}$text${_fmt('/B')}',
  '<italic>': (text, match) => '${_fmt('I')}$text${_fmt('/I')}',
  '<i>': (text, match) => '${_fmt('I')}$text${_fmt('/I')}',
  '<underline>': (text, match) => '${_fmt('U')}$text${_fmt('/U')}',
  '<u>': (text, match) => '${_fmt('U')}$text${_fmt('/U')}',
  '<strikethrough>': (text, match) => '${_fmt('S')}$text${_fmt('/S')}',
  '<s>': (text, match) => '${_fmt('S')}$text${_fmt('/S')}',
  '<hidden>': (text, match) => '${_fmt('SP')}$text${_fmt('/SP')}',

  // ─── HTML-like Tags — strip (no Telegram equivalent) ──────────────────

  '<blink>': (text, match) => text,
  '<rapid-blink>': (text, match) => text,
  '<dim>': (text, match) => text,
  '<double-underline>': (text, match) => text,
  '<uu>': (text, match) => text,
  '<overline>': (text, match) => text,
  '<inverse>': (text, match) => text,
  '<superscript>': (text, match) => text,
  '<sup>': (text, match) => text,
  '<subscript>': (text, match) => text,
  '<sub>': (text, match) => text,

  // ─── Basic Replacements ───────────────────────────────────────────────

  'basic: <reset>': (text, match) => '',
  'basic: <br>': (text, match) => '\n',
});

/// MarkdownV2 delimiter lookup for format markers.
const _fmtToMdV2 = {
  'B': '*',
  '/B': '*', // bold
  'I': '_',
  '/I': '_', // italic
  'U': '__',
  '/U': '__', // underline
  'S': '~',
  '/S': '~', // strikethrough
  'SP': '||',
  '/SP': '||', // spoiler
};

// ═══════════════════════════════════════════════════════════════════════════════
// Conversion Pipeline
// ═══════════════════════════════════════════════════════════════════════════════

/// Convert console_markdown text to Telegram MarkdownV2.
///
/// Handles the full conversion pipeline:
/// - Strips ANSI escape codes
/// - Extracts code blocks, inline code, and links (preserving them)
/// - Strips dynamic color and `<console>` tags
/// - Parses console_markdown formatting with the `marked` package
/// - Escapes MarkdownV2 special characters in plain text
/// - Restores code blocks, links, and formatting delimiters
String toTelegramMarkdownV2(String text) {
  // Step 1: Strip ANSI escape codes
  text = text.replaceAll(RegExp(r'\x1B\[[0-9;]*[a-zA-Z]'), '');

  // Step 2: Extract code blocks, inline code, and links into placeholders.
  // These need special escaping rules and must not be processed by the
  // marked parser.
  final extractions = <String, String>{};
  var counter = 0;

  // Fenced code blocks: ```lang\ncontent```
  text = text.replaceAllMapped(
    RegExp(r'```(\w*\n?)([\s\S]*?)```'),
    (m) {
      final id = counter++;
      final lang = m.group(1) ?? '';
      final code = _escapeCodeText(m.group(2) ?? '');
      extractions[_ext(id)] = '```$lang$code```';
      return _ext(id);
    },
  );

  // Inline code: `content`
  text = text.replaceAllMapped(
    RegExp(r'`([^`\n]+)`'),
    (m) {
      final id = counter++;
      final code = _escapeCodeText(m.group(1)!);
      extractions[_ext(id)] = '`$code`';
      return _ext(id);
    },
  );

  // Markdown links: [text](url)
  text = text.replaceAllMapped(
    RegExp(r'\[([^\]]+)\]\(([^)]+)\)'),
    (m) {
      final id = counter++;
      final linkText = _escapePlainText(m.group(1)!);
      final linkUrl = _escapeLinkUrl(m.group(2)!);
      extractions[_ext(id)] = '[$linkText]($linkUrl)';
      return _ext(id);
    },
  );

  // Step 3: Strip dynamic color/console tags that the marked parser
  // can't handle (complex regex-based patterns in console_markdown).

  // <console ...>text</console>
  text = text.replaceAllMapped(
    RegExp(r'<console[^>]*>([\s\S]*?)</console>'),
    (m) => m.group(1)!,
  );
  // <rgb(r,g,b)>text</rgb>
  text = text.replaceAllMapped(
    RegExp(r'<rgb\([^)]*\)[^>]*>([\s\S]*?)</rgb>'),
    (m) => m.group(1)!,
  );
  // <hex(...)>text</hex>
  text = text.replaceAllMapped(
    RegExp(r'<hex\([^)]*\)[^>]*>([\s\S]*?)</hex>'),
    (m) => m.group(1)!,
  );
  // <#color>text</#>
  text = text.replaceAllMapped(
    RegExp(r'<#[0-9a-fA-F]+[^>]*>([\s\S]*?)</#>'),
    (m) => m.group(1)!,
  );

  // Step 4: Parse with marked (console_markdown patterns → placeholders)
  text = _ConsoleToPlaceholders.apply(text);

  // Step 5: Escape MarkdownV2 special chars in plain text segments
  // (everything between placeholder tokens)
  text = _escapeNonPlaceholders(text);

  // Step 6: Replace format markers with MarkdownV2 delimiters
  for (final entry in _fmtToMdV2.entries) {
    text = text.replaceAll(_fmt(entry.key), entry.value);
  }

  // Step 7: Restore extracted content (code blocks, inline code, links)
  for (final entry in extractions.entries) {
    text = text.replaceAll(entry.key, entry.value);
  }

  return text;
}

/// Escape MarkdownV2 special chars only in plain text segments.
///
/// Walks through the text character by character. When a placeholder token
/// (format marker or extraction) is encountered, it's copied as-is.
/// All other characters are escaped if they're MarkdownV2 specials.
String _escapeNonPlaceholders(String text) {
  final buffer = StringBuffer();
  var i = 0;

  while (i < text.length) {
    // Check for format marker placeholder: \uE000...\uE001
    if (text[i] == _fmtStart) {
      final end = text.indexOf(_fmtEnd, i + 1);
      if (end != -1) {
        buffer.write(text.substring(i, end + 1));
        i = end + 1;
        continue;
      }
    }

    // Check for extraction placeholder: \uE010...\uE011
    if (text[i] == _extStart) {
      final end = text.indexOf(_extEnd, i + 1);
      if (end != -1) {
        buffer.write(text.substring(i, end + 1));
        i = end + 1;
        continue;
      }
    }

    // Plain text char — escape if it's a MarkdownV2 special char
    final char = text[i];
    if (_mdV2SpecialChars.hasMatch(char)) {
      buffer.write('\\$char');
    } else {
      buffer.write(char);
    }
    i++;
  }

  return buffer.toString();
}

// ═══════════════════════════════════════════════════════════════════════════════
// Public API
// ═══════════════════════════════════════════════════════════════════════════════

/// Result of preparing text for Telegram.
class TelegramPreparedMessage {
  /// The formatted message text in MarkdownV2 format.
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
/// - Parses console_markdown and converts to MarkdownV2
/// - Truncates at line ending if too long
/// - Handles single long line case
TelegramPreparedMessage prepareForTelegram(String text, {int maxChars = 4000}) {
  // Convert to Telegram MarkdownV2
  final converted = toTelegramMarkdownV2(text);

  // Check if truncation needed
  if (converted.length <= maxChars) {
    return TelegramPreparedMessage(text: converted);
  }

  // Find last newline before limit for clean truncation
  final lastNewline = converted.lastIndexOf('\n', maxChars);

  // If no good newline found, it might be a single long line
  if (lastNewline < maxChars ~/ 2) {
    if (!converted.contains('\n') || converted.indexOf('\n') > maxChars) {
      return TelegramPreparedMessage(
        text: '\\(Line too long \\- sent as attachment\\)',
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
    text: '$truncated\n\n\\.\\.\\. \\[$remaining more chars\\]',
    wasTruncated: true,
    remainingChars: remaining,
  );
}
