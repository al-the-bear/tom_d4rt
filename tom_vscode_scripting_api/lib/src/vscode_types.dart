/// Common types and result classes for VS Code API
library;

/// Represents a URI in VS Code
class VSCodeUri {
  final String scheme;
  final String authority;
  final String path;
  final String query;
  final String fragment;
  final String fsPath;

  VSCodeUri({
    required this.scheme,
    this.authority = '',
    required this.path,
    this.query = '',
    this.fragment = '',
    required this.fsPath,
  });

  factory VSCodeUri.file(String path) {
    return VSCodeUri(
      scheme: 'file',
      path: path,
      fsPath: path,
    );
  }

  factory VSCodeUri.fromJson(Map<String, dynamic> json) {
    return VSCodeUri(
      scheme: json['scheme'] ?? '',
      authority: json['authority'] ?? '',
      path: json['path'] ?? '',
      query: json['query'] ?? '',
      fragment: json['fragment'] ?? '',
      fsPath: json['fsPath'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'scheme': scheme,
      'authority': authority,
      'path': path,
      'query': query,
      'fragment': fragment,
      'fsPath': fsPath,
    };
  }

  @override
  String toString() => fsPath;
}

/// Represents a workspace folder
class WorkspaceFolder {
  final VSCodeUri uri;
  final String name;
  final int index;

  WorkspaceFolder({
    required this.uri,
    required this.name,
    required this.index,
  });

  factory WorkspaceFolder.fromJson(Map<String, dynamic> json) {
    return WorkspaceFolder(
      uri: VSCodeUri.fromJson(json['uri']),
      name: json['name'],
      index: json['index'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uri': uri.toJson(),
      'name': name,
      'index': index,
    };
  }
}

/// Text document representation
class TextDocument {
  final VSCodeUri uri;
  final String fileName;
  final bool isUntitled;
  final String languageId;
  final int version;
  final bool isDirty;
  final bool isClosed;
  final int lineCount;

  TextDocument({
    required this.uri,
    required this.fileName,
    required this.isUntitled,
    required this.languageId,
    required this.version,
    required this.isDirty,
    required this.isClosed,
    required this.lineCount,
  });

  factory TextDocument.fromJson(Map<String, dynamic> json) {
    return TextDocument(
      uri: VSCodeUri.fromJson(json['uri']),
      fileName: json['fileName'],
      isUntitled: json['isUntitled'],
      languageId: json['languageId'],
      version: json['version'],
      isDirty: json['isDirty'],
      isClosed: json['isClosed'],
      lineCount: json['lineCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uri': uri.toJson(),
      'fileName': fileName,
      'isUntitled': isUntitled,
      'languageId': languageId,
      'version': version,
      'isDirty': isDirty,
      'isClosed': isClosed,
      'lineCount': lineCount,
    };
  }
}

/// Position in a text document
class Position {
  final int line;
  final int character;

  Position(this.line, this.character);

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(json['line'], json['character']);
  }

  Map<String, dynamic> toJson() {
    return {'line': line, 'character': character};
  }
}

/// Range in a text document
class Range {
  final Position start;
  final Position end;

  Range(this.start, this.end);

  factory Range.fromJson(Map<String, dynamic> json) {
    return Range(
      Position.fromJson(json['start']),
      Position.fromJson(json['end']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start': start.toJson(),
      'end': end.toJson(),
    };
  }
}

/// Selection in a text editor
class Selection extends Range {
  final Position anchor;
  final Position active;
  final bool isReversed;

  Selection(this.anchor, this.active, this.isReversed)
      : super(
          isReversed ? active : anchor,
          isReversed ? anchor : active,
        );

  factory Selection.fromJson(Map<String, dynamic> json) {
    return Selection(
      Position.fromJson(json['anchor']),
      Position.fromJson(json['active']),
      json['isReversed'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'anchor': anchor.toJson(),
      'active': active.toJson(),
      'isReversed': isReversed,
      'start': start.toJson(),
      'end': end.toJson(),
    };
  }
}

/// Text editor representation
class TextEditor {
  final TextDocument document;
  final Selection selection;
  final List<Selection> selections;
  final Range? visibleRanges;

  TextEditor({
    required this.document,
    required this.selection,
    required this.selections,
    this.visibleRanges,
  });

  factory TextEditor.fromJson(Map<String, dynamic> json) {
    return TextEditor(
      document: TextDocument.fromJson(json['document']),
      selection: Selection.fromJson(json['selection']),
      selections: (json['selections'] as List)
          .map((s) => Selection.fromJson(s))
          .toList(),
      visibleRanges: json['visibleRanges'] != null
          ? Range.fromJson(json['visibleRanges'][0])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'document': document.toJson(),
      'selection': selection.toJson(),
      'selections': selections.map((s) => s.toJson()).toList(),
      'visibleRanges': visibleRanges?.toJson(),
    };
  }
}

/// Quick pick item
class QuickPickItem {
  final String label;
  final String? description;
  final String? detail;
  final bool picked;

  QuickPickItem({
    required this.label,
    this.description,
    this.detail,
    this.picked = false,
  });

  factory QuickPickItem.fromJson(Map<String, dynamic> json) {
    return QuickPickItem(
      label: json['label'],
      description: json['description'],
      detail: json['detail'],
      picked: json['picked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      if (description != null) 'description': description,
      if (detail != null) 'detail': detail,
      'picked': picked,
    };
  }
}

/// Input box options
class InputBoxOptions {
  final String? prompt;
  final String? placeHolder;
  final String? value;
  final bool password;

  InputBoxOptions({
    this.prompt,
    this.placeHolder,
    this.value,
    this.password = false,
  });

  Map<String, dynamic> toJson() {
    return {
      if (prompt != null) 'prompt': prompt,
      if (placeHolder != null) 'placeHolder': placeHolder,
      if (value != null) 'value': value,
      'password': password,
    };
  }
}

/// Message options
class MessageOptions {
  final bool modal;
  final String? detail;

  MessageOptions({
    this.modal = false,
    this.detail,
  });

  Map<String, dynamic> toJson() {
    return {
      'modal': modal,
      if (detail != null) 'detail': detail,
    };
  }
}

/// Terminal options
class TerminalOptions {
  final String? name;
  final String? shellPath;
  final List<String>? shellArgs;
  final String? cwd;
  final Map<String, String>? env;

  TerminalOptions({
    this.name,
    this.shellPath,
    this.shellArgs,
    this.cwd,
    this.env,
  });

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (shellPath != null) 'shellPath': shellPath,
      if (shellArgs != null) 'shellArgs': shellArgs,
      if (cwd != null) 'cwd': cwd,
      if (env != null) 'env': env,
    };
  }
}

/// Diagnostic severity
enum DiagnosticSeverity {
  error(0),
  warning(1),
  information(2),
  hint(3);

  final int value;
  const DiagnosticSeverity(this.value);
}

/// File system watcher options
class FileSystemWatcherOptions {
  final bool ignoreCreateEvents;
  final bool ignoreChangeEvents;
  final bool ignoreDeleteEvents;

  FileSystemWatcherOptions({
    this.ignoreCreateEvents = false,
    this.ignoreChangeEvents = false,
    this.ignoreDeleteEvents = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'ignoreCreateEvents': ignoreCreateEvents,
      'ignoreChangeEvents': ignoreChangeEvents,
      'ignoreDeleteEvents': ignoreDeleteEvents,
    };
  }
}
