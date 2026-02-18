/// Source code information for analysis results.
///
/// This module provides classes for storing and serializing source code
/// information including offsets, ranges, comments, and full source text.
/// This feature is optional and memory-intensive - use only when needed.
library;

import 'dart:convert';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';

/// Source range information for a declaration.
class SourceRange {
  /// Start offset in the source file.
  final int offset;

  /// Length of the source span.
  final int length;

  /// End offset (offset + length).
  int get end => offset + length;

  const SourceRange({
    required this.offset,
    required this.length,
  });

  factory SourceRange.fromAstNode(AstNode node) {
    return SourceRange(offset: node.offset, length: node.length);
  }

  Map<String, dynamic> toJson() => {
        'offset': offset,
        'length': length,
      };

  factory SourceRange.fromJson(Map<String, dynamic> json) {
    return SourceRange(
      offset: json['offset'] as int,
      length: json['length'] as int,
    );
  }

  @override
  String toString() => 'SourceRange($offset, $length)';
}

/// Comment information.
class CommentInfo {
  /// Comment type (doc, single-line, multi-line).
  final CommentType type;

  /// Source range of the comment.
  final SourceRange range;

  /// The comment text (if stored, otherwise null).
  final String? text;

  const CommentInfo({
    required this.type,
    required this.range,
    this.text,
  });

  Map<String, dynamic> toJson() => {
        'type': type.name,
        'range': range.toJson(),
        if (text != null) 'text': text,
      };

  factory CommentInfo.fromJson(Map<String, dynamic> json) {
    return CommentInfo(
      type: CommentType.values.byName(json['type'] as String),
      range: SourceRange.fromJson(json['range'] as Map<String, dynamic>),
      text: json['text'] as String?,
    );
  }

  @override
  String toString() => 'CommentInfo(${type.name}, $range)';
}

/// Comment type enumeration.
enum CommentType {
  /// Documentation comment (/// or /** */)
  doc,

  /// Single-line comment (//)
  singleLine,

  /// Multi-line comment (/* */)
  multiLine,
}

/// Source information for a declaration.
class SourceInfo {
  /// The file URI containing the declaration.
  final String fileUri;

  /// Source range of the entire declaration (including doc comments).
  final SourceRange range;

  /// Documentation comment range (if any).
  final SourceRange? docCommentRange;

  /// Documentation comment text (if stored).
  final String? docComment;

  /// All comments within or before this declaration.
  final List<CommentInfo> comments;

  /// Full source code of the declaration (if stored, otherwise null).
  final String? sourceCode;

  /// Line number (1-based) where the declaration starts.
  final int? line;

  /// Column number (1-based) where the declaration starts.
  final int? column;

  const SourceInfo({
    required this.fileUri,
    required this.range,
    this.docCommentRange,
    this.docComment,
    this.comments = const [],
    this.sourceCode,
    this.line,
    this.column,
  });

  /// Whether this source info includes the full source code.
  bool get hasSourceCode => sourceCode != null;

  /// Whether this source info includes documentation.
  bool get hasDocComment => docComment != null || docCommentRange != null;

  Map<String, dynamic> toJson() => {
        'fileUri': fileUri,
        'range': range.toJson(),
        if (docCommentRange != null) 'docCommentRange': docCommentRange!.toJson(),
        if (docComment != null) 'docComment': docComment,
        if (comments.isNotEmpty) 'comments': comments.map((c) => c.toJson()).toList(),
        if (sourceCode != null) 'sourceCode': sourceCode,
        if (line != null) 'line': line,
        if (column != null) 'column': column,
      };

  factory SourceInfo.fromJson(Map<String, dynamic> json) {
    return SourceInfo(
      fileUri: json['fileUri'] as String,
      range: SourceRange.fromJson(json['range'] as Map<String, dynamic>),
      docCommentRange: json['docCommentRange'] != null
          ? SourceRange.fromJson(json['docCommentRange'] as Map<String, dynamic>)
          : null,
      docComment: json['docComment'] as String?,
      comments: (json['comments'] as List<dynamic>?)
              ?.map((c) => CommentInfo.fromJson(c as Map<String, dynamic>))
              .toList() ??
          const [],
      sourceCode: json['sourceCode'] as String?,
      line: json['line'] as int?,
      column: json['column'] as int?,
    );
  }

  @override
  String toString() => 'SourceInfo($fileUri, $range)';
}

/// Options for source code extraction.
class SourceExtractionOptions {
  /// Whether to include full source code.
  final bool includeSourceCode;

  /// Whether to include documentation comments.
  final bool includeDocComments;

  /// Whether to include all comments (including inline).
  final bool includeAllComments;

  /// Whether to include line/column information.
  final bool includeLineInfo;

  /// Maximum source code length to include (0 = unlimited).
  final int maxSourceLength;

  const SourceExtractionOptions({
    this.includeSourceCode = true,
    this.includeDocComments = true,
    this.includeAllComments = false,
    this.includeLineInfo = true,
    this.maxSourceLength = 0,
  });

  /// No source extraction (only ranges).
  static const rangesOnly = SourceExtractionOptions(
    includeSourceCode: false,
    includeDocComments: false,
    includeAllComments: false,
    includeLineInfo: true,
  );

  /// Documentation only.
  static const docOnly = SourceExtractionOptions(
    includeSourceCode: false,
    includeDocComments: true,
    includeAllComments: false,
    includeLineInfo: true,
  );

  /// Full source code.
  static const full = SourceExtractionOptions(
    includeSourceCode: true,
    includeDocComments: true,
    includeAllComments: true,
    includeLineInfo: true,
  );
}

/// Extracts source information from AST nodes.
class SourceInfoExtractor {
  final SourceExtractionOptions options;

  /// Cache of file contents by URI.
  final Map<String, String> _sourceCache = {};

  SourceInfoExtractor({this.options = SourceExtractionOptions.docOnly});

  /// Register source content for a file.
  void registerSource(String fileUri, String content) {
    _sourceCache[fileUri] = content;
  }

  /// Extract source info from a compilation unit member.
  SourceInfo? extractFromDeclaration(
    Declaration node,
    String fileUri,
    String? source,
  ) {
    final content = source ?? _sourceCache[fileUri];
    if (content == null) return null;

    // Get doc comment (Declaration is always an AnnotatedNode)
    final docComment = node.documentationComment;

    // Calculate line/column
    int? line;
    int? column;
    if (options.includeLineInfo && content.isNotEmpty) {
      final info = _calculateLineColumn(content, node.offset);
      line = info.$1;
      column = info.$2;
    }

    // Build comment list
    final comments = <CommentInfo>[];
    if (options.includeAllComments) {
      _collectComments(node, content, comments);
    }

    // Extract source code
    String? sourceCode;
    if (options.includeSourceCode) {
      var code = content.substring(node.offset, node.end);
      if (options.maxSourceLength > 0 && code.length > options.maxSourceLength) {
        code = code.substring(0, options.maxSourceLength);
      }
      sourceCode = code;
    }

    // Extract doc comment
    SourceRange? docCommentRange;
    String? docCommentText;
    if (docComment != null) {
      docCommentRange = SourceRange(
        offset: docComment.offset,
        length: docComment.length,
      );
      if (options.includeDocComments) {
        docCommentText = content.substring(docComment.offset, docComment.end);
      }
    }

    return SourceInfo(
      fileUri: fileUri,
      range: SourceRange.fromAstNode(node),
      docCommentRange: docCommentRange,
      docComment: docCommentText,
      comments: comments,
      sourceCode: sourceCode,
      line: line,
      column: column,
    );
  }

  void _collectComments(AstNode node, String content, List<CommentInfo> result) {
    Token? token = node.beginToken;
    while (token != null && token.offset <= node.end) {
      Token? comment = token.precedingComments;
      while (comment != null) {
        final type = _getCommentType(comment);
        result.add(CommentInfo(
          type: type,
          range: SourceRange(offset: comment.offset, length: comment.length),
          text: content.substring(comment.offset, comment.end),
        ));
        comment = comment.next;
      }
      if (token == node.endToken) break;
      token = token.next;
    }
  }

  CommentType _getCommentType(Token comment) {
    final lexeme = comment.lexeme;
    if (lexeme.startsWith('///') || lexeme.startsWith('/**')) {
      return CommentType.doc;
    } else if (lexeme.startsWith('//')) {
      return CommentType.singleLine;
    } else {
      return CommentType.multiLine;
    }
  }

  (int, int) _calculateLineColumn(String content, int offset) {
    int line = 1;
    int lastLineStart = 0;
    for (int i = 0; i < offset && i < content.length; i++) {
      if (content[i] == '\n') {
        line++;
        lastLineStart = i + 1;
      }
    }
    return (line, offset - lastLineStart + 1);
  }
}

/// Collection of source info for all declarations in an analysis result.
class SourceInfoCollection {
  /// Source info by element qualified name.
  final Map<String, SourceInfo> _info = {};

  /// File contents cache.
  final Map<String, String> _sources = {};

  /// Creates an empty source info collection.
  SourceInfoCollection();

  /// Add source info for an element.
  void add(String qualifiedName, SourceInfo info) {
    _info[qualifiedName] = info;
  }

  /// Get source info for an element.
  SourceInfo? get(String qualifiedName) => _info[qualifiedName];

  /// Register source content for a file.
  void registerSource(String fileUri, String content) {
    _sources[fileUri] = content;
  }

  /// Get source content for a file.
  String? getSource(String fileUri) => _sources[fileUri];

  /// All registered elements.
  Iterable<String> get elements => _info.keys;

  /// Number of elements with source info.
  int get count => _info.length;

  /// Whether source info is available for an element.
  bool has(String qualifiedName) => _info.containsKey(qualifiedName);

  /// Serialize to JSON.
  Map<String, dynamic> toJson() => {
        'elements': _info.map((k, v) => MapEntry(k, v.toJson())),
        'sources': _sources,
      };

  /// Deserialize from JSON.
  factory SourceInfoCollection.fromJson(Map<String, dynamic> json) {
    final collection = SourceInfoCollection();
    final elements = json['elements'] as Map<String, dynamic>?;
    if (elements != null) {
      for (final entry in elements.entries) {
        collection.add(
          entry.key,
          SourceInfo.fromJson(entry.value as Map<String, dynamic>),
        );
      }
    }
    final sources = json['sources'] as Map<String, dynamic>?;
    if (sources != null) {
      for (final entry in sources.entries) {
        collection.registerSource(entry.key, entry.value as String);
      }
    }
    return collection;
  }

  /// Serialize to JSON string.
  String toJsonString({bool pretty = false}) {
    final encoder = pretty ? const JsonEncoder.withIndent('  ') : const JsonEncoder();
    return encoder.convert(toJson());
  }

  /// Deserialize from JSON string.
  factory SourceInfoCollection.fromJsonString(String json) {
    return SourceInfoCollection.fromJson(
      jsonDecode(json) as Map<String, dynamic>,
    );
  }

  /// Total memory estimate (rough).
  int get estimatedMemoryBytes {
    var size = 0;
    for (final info in _info.values) {
      size += info.fileUri.length * 2;
      size += (info.sourceCode?.length ?? 0) * 2;
      size += (info.docComment?.length ?? 0) * 2;
      for (final comment in info.comments) {
        size += (comment.text?.length ?? 0) * 2;
      }
      size += 100; // overhead
    }
    for (final source in _sources.values) {
      size += source.length * 2;
    }
    return size;
  }

  /// Human-readable memory size.
  String get estimatedMemorySize {
    final bytes = estimatedMemoryBytes;
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / 1024 / 1024).toStringAsFixed(1)} MB';
  }
}
