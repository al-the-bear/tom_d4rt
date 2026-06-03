/// Full-window host for a running D4rt sample, rendered from a pre-compiled
/// [AstBundle] via the analyzer-free [FlutterD4rt] runtime.
///
/// Pushed onto the [Navigator] when the user taps a sample in the browser.
/// The bundle JSON is loaded from assets, deserialized into an [AstBundle],
/// then interpreted exactly once (during the first `build`) and reused — the
/// sample's own `StatefulWidget`/`setState` machinery drives later frames via
/// Flutter's normal pump loop.
library;

import 'package:flutter/material.dart';
import 'package:tom_d4rt_flutter_ast/tom_d4rt_flutter_ast.dart';

import 'bundle_source.dart';

class BundleAppPage extends StatefulWidget {
  final BundleEntry entry;
  final FlutterD4rt d4rt;
  final BundleSource source;

  const BundleAppPage({
    super.key,
    required this.entry,
    required this.d4rt,
    required this.source,
  });

  @override
  State<BundleAppPage> createState() => _BundleAppPageState();
}

class _BundleAppPageState extends State<BundleAppPage> {
  AstBundle? _bundle;
  Widget? _built;
  String? _errorMessage;
  StackTrace? _errorStack;

  @override
  void initState() {
    super.initState();
    _loadBundle();
  }

  Future<void> _loadBundle() async {
    try {
      final bundle = await widget.source.load(widget.entry);
      if (!mounted) return;
      setState(() => _bundle = bundle);
    } catch (e, st) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString();
        _errorStack = st;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Interpret only once the bundle has loaded and a real BuildContext
    // (with Theme/Navigator in scope) is available.
    if (_bundle != null && _built == null && _errorMessage == null) {
      _interpret(context);
    }
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(36),
        child: AppBar(
          toolbarHeight: 36,
          backgroundColor: scheme.surfaceContainerHigh,
          foregroundColor: scheme.onSurface,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, size: 18),
            tooltip: 'Back to samples',
            onPressed: () => Navigator.of(context).maybePop(),
            visualDensity: VisualDensity.compact,
          ),
          title: Row(
            children: [
              Icon(Icons.apps, size: 14, color: scheme.outline),
              const SizedBox(width: 6),
              Text(
                widget.entry.name,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh, size: 16),
              tooltip: 'Re-interpret sample',
              visualDensity: VisualDensity.compact,
              onPressed: _reinterpret,
            ),
          ],
        ),
      ),
      body: _errorMessage != null
          ? _ErrorBody(message: _errorMessage!, stack: _errorStack)
          : (_built ?? const Center(child: CircularProgressIndicator())),
    );
  }

  void _interpret(BuildContext context) {
    try {
      // Each page gets a fresh script environment so re-runs and sibling
      // samples don't leak script-declared names into each other.
      widget.d4rt.resetScript();
      _built = widget.d4rt.build<Widget>(_bundle!, context);
    } on FlutterD4rtException catch (e) {
      _errorMessage = e.message;
    } catch (e, st) {
      _errorMessage = e.toString();
      _errorStack = st;
    }
  }

  void _reinterpret() {
    setState(() {
      _built = null;
      _errorMessage = null;
      _errorStack = null;
    });
  }
}

class _ErrorBody extends StatelessWidget {
  final String message;
  final StackTrace? stack;

  const _ErrorBody({required this.message, this.stack});

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
