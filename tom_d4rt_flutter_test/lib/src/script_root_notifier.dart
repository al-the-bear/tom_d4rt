/// Holds the currently-selected script root path and exposes a native
/// directory picker. The `TestRunner` listens to this notifier and
/// reloads its script list on every change.
library;

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

import 'test_script_loader.dart';

/// Mutable, observable script-root path.
///
/// Defaults to [TestScriptLoader.defaultRoot] so the first launch tries to
/// auto-locate the sibling corpus. If that fails, [exists] returns false
/// and the UI surfaces a "path not found" affordance prompting the user
/// to pick a folder manually.
class ScriptRootNotifier extends ChangeNotifier {
  String _root;

  ScriptRootNotifier() : _root = TestScriptLoader.defaultRoot;

  /// The currently selected root path (may not exist on disk).
  String get root => _root;

  /// Whether [root] currently resolves to an existing directory.
  bool get exists => TestScriptLoader.rootExists(_root);

  /// Opens a native directory picker. Updates [root] and notifies
  /// listeners only if the user actually selects a folder.
  Future<void> pickDirectory() async {
    final result = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Select D4rt test script folder',
      initialDirectory: Directory(_root).existsSync() ? _root : null,
    );
    if (result != null && result != _root) {
      _root = result;
      notifyListeners();
    }
  }

  /// Programmatic setter — useful for tests or for restoring a previous
  /// session's path. No-ops when the new path matches the current one to
  /// avoid spurious notifications.
  void setRoot(String path) {
    if (path == _root) return;
    _root = path;
    notifyListeners();
  }
}
