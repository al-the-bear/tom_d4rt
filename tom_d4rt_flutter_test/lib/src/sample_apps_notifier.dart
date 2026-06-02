/// Reactive holder for the discovered sample list and the current selection.
///
/// Sample discovery and source loading are delegated to a [SampleSource],
/// chosen per platform by [createSampleSource]: the live `example/` tree on
/// desktop, a bundled asset snapshot on mobile (see `sample_source.dart`).
///
/// Loading is asynchronous (asset reads are `Future`-based), so callers should
/// observe [loading] and the (possibly empty) [samples] list rather than
/// assuming the corpus is ready at construction time.
library;

import 'package:flutter/foundation.dart';

import 'sample_source.dart';

export 'sample_source.dart'
    show SampleAppEntry, SampleProgram, SampleLoadException, isMobileRuntime;

/// Observable sample list + selection, backed by a [SampleSource].
class SampleAppsNotifier extends ChangeNotifier {
  final SampleSource _source;

  List<SampleAppEntry> _samples = const [];
  SampleAppEntry? _selected;
  bool _loading = true;
  bool _rootExists = false;

  SampleAppsNotifier({SampleSource? source})
      : _source = source ?? createSampleSource() {
    _load();
  }

  /// Where samples are loaded from (disk path or bundled-asset label).
  String get root => _source.rootLabel;

  /// Whether the sample root was reachable at the last load.
  bool get rootExists => _rootExists;

  /// Discovered samples (empty until the first load completes).
  List<SampleAppEntry> get samples => _samples;

  /// Currently selected sample, or null when the corpus is empty.
  SampleAppEntry? get selected => _selected;

  /// Whether a load is in flight.
  bool get loading => _loading;

  /// Pick a different sample. No-op when it already matches the selection.
  void select(SampleAppEntry? entry) {
    if (entry == _selected) return;
    _selected = entry;
    notifyListeners();
  }

  /// Re-scan the source for added/removed samples.
  void reload() => _load();

  /// Resolve a sample into a runnable program (used by the sample host page).
  Future<SampleProgram> loadProgram(SampleAppEntry entry) =>
      _source.loadProgram(entry);

  Future<void> _load() async {
    _loading = true;
    notifyListeners();
    _rootExists = await _source.available;
    _samples = await _source.list();
    if (_samples.isEmpty) {
      _selected = null;
    } else if (_selected == null ||
        !_samples.any((s) => s.name == _selected!.name)) {
      _selected = _samples.first;
    }
    _loading = false;
    notifyListeners();
  }
}
