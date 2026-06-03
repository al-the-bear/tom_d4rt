/// Analyzer-free D4rt Flutter demo.
///
/// A sample browser that loads pre-compiled [AstBundle] JSON from assets and
/// renders each one via [FlutterD4rt] — the zero-analyzer, web-safe runtime
/// from `tom_d4rt_flutter_ast`. Because nothing here depends on the analyzer
/// or `dart:io`, the same code builds and runs on web, desktop, and mobile.
///
/// Bundles are produced at build time by
/// `tool/compile_samples_to_bundles.dart`. Run that (under `flutter test`)
/// after adding or editing any `example/<name>/main.dart`.
library;

import 'package:flutter/material.dart';
import 'package:tom_d4rt_flutter_ast/tom_d4rt_flutter_ast.dart';

import 'src/bundle_app_page.dart';
import 'src/bundle_source.dart';

void main() {
  runApp(const D4rtAstDemoApp());
}

class D4rtAstDemoApp extends StatelessWidget {
  const D4rtAstDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'D4rt AST Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const _SamplesShell(),
    );
  }
}

/// Grid of pre-compiled samples. Tapping one pushes a [BundleAppPage] that
/// interprets the bundle and renders the resulting widget tree.
class _SamplesShell extends StatefulWidget {
  const _SamplesShell();

  @override
  State<_SamplesShell> createState() => _SamplesShellState();
}

class _SamplesShellState extends State<_SamplesShell> {
  // A single shared interpreter across samples keeps bridge registration
  // (which builds a large metadata graph) a one-time cost. Each page resets
  // the script environment before interpreting so samples stay isolated.
  final FlutterD4rt _d4rt = FlutterD4rt();
  final BundleSource _source = BundleSource();

  late Future<List<BundleEntry>> _entries;

  @override
  void initState() {
    super.initState();
    _entries = _source.list();
  }

  void _runSample(BundleEntry entry) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BundleAppPage(
          entry: entry,
          d4rt: _d4rt,
          source: _source,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('D4rt AST Samples')),
      body: FutureBuilder<List<BundleEntry>>(
        future: _entries,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return _Message(
              'Failed to read bundle manifest.\n\n${snapshot.error}',
            );
          }
          final entries = snapshot.data ?? const [];
          if (entries.isEmpty) {
            return const _Message(
              'No compiled bundles found.\n\nRun '
              '`flutter test tool/compile_samples_to_bundles.dart` '
              'and rebuild.',
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 220,
              mainAxisExtent: 84,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: entries.length,
            itemBuilder: (context, i) => _SampleTile(
              entry: entries[i],
              onTap: () => _runSample(entries[i]),
            ),
          );
        },
      ),
    );
  }
}

class _SampleTile extends StatelessWidget {
  final BundleEntry entry;
  final VoidCallback onTap;

  const _SampleTile({required this.entry, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              Icon(Icons.apps, color: scheme.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  entry.name,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(Icons.play_arrow),
            ],
          ),
        ),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  final String text;
  const _Message(this.text);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
