/// Tool definitions sent to the Anthropic API + the executor that turns
/// tool-use calls into virtual-FS mutations.
///
/// Tools intentionally mirror the subset of operations a human author
/// would use to write a multi-file Flutter sample: write files, read
/// them back, list them, grep for symbols, occasionally delete.
library;

import 'virtual_fs.dart';

/// JSON schema descriptors for every tool the model can invoke. The
/// `input_schema` is what Anthropic uses to validate tool inputs before
/// invoking the host.
final List<Map<String, dynamic>> generatorToolSchemas = <Map<String, dynamic>>[
  {
    'name': 'write_file',
    'description':
        'Create or overwrite a file in the in-memory project. Use this '
        'for `main.dart` (the entry point with the top-level `Widget '
        'build(BuildContext context)`) AND for every helper file. Paths '
        'are relative to the project root; `main.dart` lives at the '
        'root, `cell.dart` would be imported via `import \'cell.dart\';` '
        'from `main.dart`.',
    'input_schema': {
      'type': 'object',
      'properties': {
        'path': {
          'type': 'string',
          'description': 'Relative file path, e.g. `main.dart`, '
              '`widgets/board.dart`, `engine.dart`. Use forward slashes.',
        },
        'content': {
          'type': 'string',
          'description': 'Full Dart source. Imports use relative paths '
              'between project files; `package:flutter/...` and '
              '`dart:async`/`dart:math`/`dart:convert` are allowed.',
        },
      },
      'required': ['path', 'content'],
    },
  },
  {
    'name': 'read_file',
    'description':
        'Read a file you previously wrote. Useful when adding a new '
        'file that needs to import from / refer to an existing one and '
        'you want to confirm names + signatures.',
    'input_schema': {
      'type': 'object',
      'properties': {
        'path': {'type': 'string'},
      },
      'required': ['path'],
    },
  },
  {
    'name': 'list_files',
    'description':
        'List every file currently in the project, optionally under a '
        'directory prefix.',
    'input_schema': {
      'type': 'object',
      'properties': {
        'directory': {
          'type': 'string',
          'description': 'Optional directory prefix, e.g. `widgets`.',
        },
      },
    },
  },
  {
    'name': 'grep_search',
    'description':
        'Regex search across the in-memory project. Returns up to 200 '
        'matching lines as `path:line:content`. Use to find symbol '
        'definitions/usages before refactoring.',
    'input_schema': {
      'type': 'object',
      'properties': {
        'pattern': {
          'type': 'string',
          'description': 'Dart `RegExp` syntax (POSIX-like).',
        },
        'directory': {
          'type': 'string',
          'description': 'Optional directory prefix to limit the search.',
        },
        'case_sensitive': {
          'type': 'boolean',
          'description': 'Defaults to true.',
        },
      },
      'required': ['pattern'],
    },
  },
  {
    'name': 'delete_file',
    'description':
        'Remove a file from the in-memory project. Use when refactoring '
        'so leftover files don\'t get persisted at the end.',
    'input_schema': {
      'type': 'object',
      'properties': {
        'path': {'type': 'string'},
      },
      'required': ['path'],
    },
  },
];

/// Result of executing one tool call. [content] is the string we send
/// back as the `tool_result` body. [isError] marks `is_error: true` so
/// the model knows the call failed.
class ToolExecutionResult {
  final String content;
  final bool isError;
  /// Optional short summary suitable for the log UI (one line).
  final String summary;
  ToolExecutionResult(this.content, {this.isError = false, String? summary})
      : summary = summary ?? content;
}

/// Executes one tool call against [fs]. Catches exceptions and turns
/// them into `is_error: true` results so a bad tool call never crashes
/// the conversation loop.
ToolExecutionResult executeGeneratorTool(
  VirtualFs fs,
  String toolName,
  Map<String, dynamic> input,
) {
  try {
    switch (toolName) {
      case 'write_file':
        final path = input['path']?.toString() ?? '';
        final content = input['content']?.toString() ?? '';
        if (path.isEmpty) {
          return ToolExecutionResult('Error: `path` is required.',
              isError: true);
        }
        fs.write(path, content);
        final lines = content.split('\n').length;
        return ToolExecutionResult(
          'Wrote ${content.length} chars ($lines lines) to $path.',
          summary: 'write_file → $path ($lines lines)',
        );

      case 'read_file':
        final path = input['path']?.toString() ?? '';
        final content = fs.read(path);
        if (content == null) {
          return ToolExecutionResult(
            'Error: file not found: $path. Current files: '
            '${fs.listFiles().join(", ")}',
            isError: true,
            summary: 'read_file → $path (not found)',
          );
        }
        return ToolExecutionResult(
          content,
          summary: 'read_file → $path (${content.length} chars)',
        );

      case 'list_files':
        final directory = input['directory']?.toString();
        final files = fs.listFiles(directory: directory);
        if (files.isEmpty) {
          return ToolExecutionResult(
            directory == null || directory.isEmpty
                ? '(no files yet)'
                : '(no files under $directory)',
            summary: 'list_files → 0 files',
          );
        }
        return ToolExecutionResult(
          files.join('\n'),
          summary: 'list_files → ${files.length} files',
        );

      case 'grep_search':
        final pattern = input['pattern']?.toString() ?? '';
        final directory = input['directory']?.toString();
        final caseSensitive = input['case_sensitive'] == false ? false : true;
        if (pattern.isEmpty) {
          return ToolExecutionResult('Error: `pattern` is required.',
              isError: true);
        }
        final hits = fs.grep(
          pattern,
          directory: directory,
          caseSensitive: caseSensitive,
        );
        if (hits.isEmpty) {
          return ToolExecutionResult(
            'No matches for /$pattern/.',
            summary: 'grep "$pattern" → 0',
          );
        }
        return ToolExecutionResult(
          hits.join('\n'),
          summary: 'grep "$pattern" → ${hits.length} hits',
        );

      case 'delete_file':
        final path = input['path']?.toString() ?? '';
        if (!fs.delete(path)) {
          return ToolExecutionResult(
            'Error: file not found: $path',
            isError: true,
            summary: 'delete_file → $path (not found)',
          );
        }
        return ToolExecutionResult(
          'Deleted $path.',
          summary: 'delete_file → $path',
        );

      default:
        return ToolExecutionResult(
          'Error: unknown tool `$toolName`.',
          isError: true,
        );
    }
  } catch (e, st) {
    return ToolExecutionResult(
      'Error during $toolName: $e\n$st',
      isError: true,
      summary: '$toolName → error: $e',
    );
  }
}
