/// Full-window host for a running D4rt sample app.
///
/// Pushed onto the [Navigator] when the user clicks "Run Sample" in
/// [SamplesBar]. The sample widget produced by the interpreter occupies
/// the entire body; a thin top app bar offers a back button to return
/// to the test-runner start screen. The sample is interpreted exactly
/// once per page (during the first `build`) and reused thereafter — its
/// own internal `StatefulWidget`/`setState` machinery drives subsequent
/// frames via Flutter's normal pump loop.
library;

import 'package:flutter/material.dart';

import '../sample_apps_notifier.dart';
import '../source_flutter_d4rt.dart';

class SampleAppPage extends StatefulWidget {
  final SampleAppEntry sample;
  final SourceFlutterD4rt d4rt;

  const SampleAppPage({
    super.key,
    required this.sample,
    required this.d4rt,
  });

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  Widget? _built;
  String? _errorMessage;
  StackTrace? _errorStack;

  @override
  Widget build(BuildContext context) {
    if (_built == null && _errorMessage == null) {
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
            tooltip: 'Back to test runner',
            onPressed: () => Navigator.of(context).maybePop(),
            visualDensity: VisualDensity.compact,
          ),
          title: Row(
            children: [
              Icon(Icons.apps, size: 14, color: scheme.outline),
              const SizedBox(width: 6),
              Text(
                widget.sample.name,
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
          : (_built ??
              const Center(child: CircularProgressIndicator())),
    );
  }

  void _interpret(BuildContext context) {
    try {
      final widgetResult = widget.d4rt.buildMultiFile<Widget>(
        widget.sample.mainPath,
        buildContext: context,
      );
      _built = widgetResult;
    } on SourceFlutterD4rtException catch (e) {
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
                    Icon(Icons.error_outline,
                        color: scheme.error, size: 22),
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
