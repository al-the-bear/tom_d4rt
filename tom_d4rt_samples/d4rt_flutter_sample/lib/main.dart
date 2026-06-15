// d4rt_flutter_sample — interpret Flutter UI written as D4rt scripts.
//
// The whole point of this app: the screens you see are NOT compiled into the
// binary. They are Dart *source files* shipped as assets, interpreted at
// runtime by `SourceFlutterD4rt` into a live Flutter widget tree.
//
// The home screen has three tabs:
//   • Samples    — pick a bundled multi-file sample app and run it.
//   • Paste & Run — paste a script (or load a snippet) and render it live.
//   • Files      — browse every bundled .dart file in a tree, read-only.
//
// Why assets and not disk? `AssetSampleSource` reads the snapshot produced by
// `tool/sync_samples_to_assets.dart` (mirrored from `example/<name>/` into
// `assets/samples/`). Assets are reachable identically on every platform via
// `rootBundle`, so one code path covers desktop and mobile. The interpreter
// itself never touches the filesystem: relative imports are pre-resolved into
// the in-memory sources map before `buildProgram` runs.

import 'package:flutter/material.dart';
import 'package:tom_d4rt_flutter/tom_d4rt_flutter.dart';

import 'src/asset_catalog.dart';
import 'src/files_tab.dart';
import 'src/paste_run_tab.dart';

void main() => runApp(const D4rtFlutterSampleApp());

class D4rtFlutterSampleApp extends StatefulWidget {
  const D4rtFlutterSampleApp({super.key});

  @override
  State<D4rtFlutterSampleApp> createState() => _D4rtFlutterSampleAppState();
}

class _D4rtFlutterSampleAppState extends State<D4rtFlutterSampleApp> {
  // One interpreter for the whole app. Constructing it registers the full
  // Flutter Material bridge surface and calls finalizeBridges() — it is
  // reusable across every sample and every pasted script we run.
  final SourceFlutterD4rt _d4rt = SourceFlutterD4rt();

  // Assets work the same on desktop and mobile, so we always read the bundled
  // snapshot rather than branching on `createSampleSource()`.
  final SampleSource _source = AssetSampleSource();

  // App-local view of all bundled files (samples + copy-paste snippets) for
  // the Paste & Run and Files tabs.
  final AssetCatalog _catalog = AssetCatalog();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'D4rt Flutter Sample',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: HomePage(d4rt: _d4rt, source: _source, catalog: _catalog),
    );
  }
}

/// Tabbed home: Samples / Paste & Run / Files.
class HomePage extends StatelessWidget {
  final SourceFlutterD4rt d4rt;
  final SampleSource source;
  final AssetCatalog catalog;

  const HomePage({
    super.key,
    required this.d4rt,
    required this.source,
    required this.catalog,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: scheme.inversePrimary,
          title: const Text('D4rt Flutter Samples'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.widgets_outlined), text: 'Samples'),
              Tab(icon: Icon(Icons.play_circle_outline), text: 'Paste & Run'),
              Tab(icon: Icon(Icons.folder_open_outlined), text: 'Files'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SamplesTab(d4rt: d4rt, source: source),
            PasteRunTab(d4rt: d4rt, catalog: catalog),
            FilesTab(catalog: catalog),
          ],
        ),
      ),
    );
  }
}

/// "Samples" tab: lists the bundled runnable samples and runs the chosen one.
///
/// Selection works two ways — tap a name in the list, or type a name into the
/// field and press Run. Both resolve to the same [SampleAppEntry] and push a
/// [SampleHostPage].
class SamplesTab extends StatefulWidget {
  final SourceFlutterD4rt d4rt;
  final SampleSource source;

  const SamplesTab({super.key, required this.d4rt, required this.source});

  @override
  State<SamplesTab> createState() => _SamplesTabState();
}

class _SamplesTabState extends State<SamplesTab>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _nameController = TextEditingController();
  List<SampleAppEntry> _samples = const [];
  String? _loadError;
  bool _loading = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadSamples();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _loadSamples() async {
    try {
      final samples = await widget.source.list();
      if (!mounted) return;
      setState(() {
        _samples = samples;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loadError = e.toString();
        _loading = false;
      });
    }
  }

  void _runByName(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    final match = _samples.where((s) => s.name == trimmed);
    if (match.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No sample named "$trimmed".')),
      );
      return;
    }
    _open(match.first);
  }

  void _open(SampleAppEntry entry) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => SampleHostPage(
          entry: entry,
          d4rt: widget.d4rt,
          loadProgram: widget.source.loadProgram,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final scheme = Theme.of(context).colorScheme;
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_loadError != null) {
      return _GalleryError(message: _loadError!);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Sample name',
                    hintText: 'e.g. counter_app',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: _runByName,
                ),
              ),
              const SizedBox(width: 12),
              FilledButton.icon(
                onPressed: () => _runByName(_nameController.text),
                icon: const Icon(Icons.play_arrow),
                label: const Text('Run'),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: _samples.isEmpty
              ? Center(
                  child: Text(
                    'No samples bundled.\n'
                    'Run: dart run tool/sync_samples_to_assets.dart',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: scheme.outline),
                  ),
                )
              : ListView.separated(
                  itemCount: _samples.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, i) {
                    final s = _samples[i];
                    return ListTile(
                      leading: const Icon(Icons.widgets_outlined),
                      title: Text(
                        s.name,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _open(s),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

/// Full-window host for one running sample.
///
/// Resolves the [entry] into a [SampleProgram] (async — assets are loaded via
/// `rootBundle`), then interprets it into a [Widget] exactly once during the
/// first `build`, when a real [BuildContext] carrying Theme/Navigator is in
/// scope. The sample's own `StatefulWidget`/`setState` drives later frames.
class SampleHostPage extends StatefulWidget {
  final SampleAppEntry entry;
  final SourceFlutterD4rt d4rt;
  final Future<SampleProgram> Function(SampleAppEntry) loadProgram;

  const SampleHostPage({
    super.key,
    required this.entry,
    required this.d4rt,
    required this.loadProgram,
  });

  @override
  State<SampleHostPage> createState() => _SampleHostPageState();
}

class _SampleHostPageState extends State<SampleHostPage> {
  SampleProgram? _program;
  Widget? _built;
  String? _errorMessage;
  StackTrace? _errorStack;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final program = await widget.loadProgram(widget.entry);
      if (!mounted) return;
      setState(() => _program = program);
    } catch (e, st) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString();
        _errorStack = st;
      });
    }
  }

  void _interpret(BuildContext context) {
    try {
      _built = widget.d4rt.buildProgram<Widget>(
        _program!,
        buildContext: context,
      );
    } on SourceFlutterD4rtException catch (e) {
      _errorMessage = e.message;
    } catch (e, st) {
      _errorMessage = e.toString();
      _errorStack = st;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_program != null && _built == null && _errorMessage == null) {
      _interpret(context);
    }
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: scheme.surfaceContainerHigh,
        title: Text(
          widget.entry.name,
          style: const TextStyle(fontFamily: 'monospace', fontSize: 15),
        ),
      ),
      body: _errorMessage != null
          ? _SampleError(message: _errorMessage!, stack: _errorStack)
          : (_built ?? const Center(child: CircularProgressIndicator())),
    );
  }
}

class _GalleryError extends StatelessWidget {
  final String message;
  const _GalleryError({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          'Could not list samples:\n\n$message',
          textAlign: TextAlign.center,
          style: const TextStyle(fontFamily: 'monospace'),
        ),
      ),
    );
  }
}

class _SampleError extends StatelessWidget {
  final String message;
  final StackTrace? stack;
  const _SampleError({required this.message, this.stack});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: scheme.errorContainer,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: scheme.error),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.error_outline, color: scheme.error, size: 22),
                    const SizedBox(width: 8),
                    Text(
                      'Sample interpretation failed',
                      style: TextStyle(
                        color: scheme.error,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SelectableText(
                  message,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    color: scheme.onErrorContainer,
                  ),
                ),
              ],
            ),
          ),
          if (stack != null) ...[
            const SizedBox(height: 12),
            SelectableText(
              stack.toString(),
              style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
            ),
          ],
        ],
      ),
    );
  }
}
