/// Locating a mirror-AST node in the source it came from, for a diagnostic
/// (SCE236).
///
/// The analyzer-free line has no `toSource()`: `tom_ast_model` renders nothing
/// back to text, and building a renderer for every node type is the wrong
/// size of answer. A bundle can carry its SOURCE instead
/// (`AstBundle.sources`, filled when the bundler is asked to include it), and
/// every node already carries `offset` and `length` into it, so an excerpt is a
/// substring.
///
/// An offset alone is not enough even with the source to hand: it is an offset
/// into ONE module of several, and the module being executed is not reliably
/// the module a node was parsed from (a function defined in an import runs
/// with the entry point as the current library). So the node's module is found
/// by walking the loaded modules for it, by IDENTITY — mirror nodes compare
/// structurally, so two equal-looking nodes in different modules would
/// otherwise be confused. This is an error path, so the walk's cost does not
/// matter.
library;

import 'package:tom_ast_model/tom_ast_model.dart';

/// A short description of where [node] is and what it says.
///
/// - With the module's source bundled: `'<excerpt>' (<uri>:<line>:<column>)`.
/// - Without it: the module and offset, and how to get the excerpt. Naming the
///   module is still worth having, because a release bundle may legitimately
///   leave its source out.
/// - When no loaded module contains the node: says so.
String describeNodeSource(
  SAstNode node, {
  required Map<String, SCompilationUnit> modules,
  Map<String, String>? sources,
}) {
  final uri = moduleContaining(node, modules);
  if (uri == null) {
    return '(not available: no loaded module contains this node; '
        'offset ${node.offset})';
  }
  final source = sources?[uri];
  if (source == null ||
      node.offset < 0 ||
      node.offset + node.length > source.length) {
    return '(not bundled: $uri, offset ${node.offset}; build the bundle '
        'with its sources to quote them)';
  }
  final text = source
      .substring(node.offset, node.offset + node.length)
      .replaceAll(RegExp(r'\s+'), ' ');
  final excerpt = text.length <= 60 ? text : '${text.substring(0, 57)}...';
  final (line, column) = _lineAndColumn(source, node.offset);
  return "'$excerpt' ($uri:$line:$column)";
}

/// The URI of the module in [modules] whose tree contains [node], by identity.
String? moduleContaining(SAstNode node, Map<String, SCompilationUnit> modules) {
  for (final entry in modules.entries) {
    final pending = <SAstNode>[entry.value];
    while (pending.isNotEmpty) {
      final current = pending.removeLast();
      if (identical(current, node)) return entry.key;
      final children = _Children();
      current.visitChildren(children);
      pending.addAll(children.nodes);
    }
  }
  return null;
}

(int, int) _lineAndColumn(String source, int offset) {
  var line = 1;
  var lineStart = 0;
  for (var i = 0; i < offset; i++) {
    if (source.codeUnitAt(i) == 0x0A) {
      line++;
      lineStart = i + 1;
    }
  }
  return (line, offset - lineStart + 1);
}

class _Children extends SAstVisitor<void> {
  final nodes = <SAstNode>[];

  @override
  void visitNode(SAstNode node) => nodes.add(node);
}
