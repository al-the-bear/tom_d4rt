/// Widget that executes D4rt test scripts inside the Flutter build cycle so
/// that a real [BuildContext] — with access to [Theme], [MediaQuery],
/// [Navigator], etc. — is available to the script.
///
/// This mirrors the execution model used by the `tom_d4rt_flutter_ast` test
/// harness (`_D4rtTestPageState._buildD4rtWidget`), where D4rt is invoked
/// synchronously inside `State.build()` and the result is a `Widget` that
/// Flutter renders immediately. A post-frame callback is used to defer the
/// result notification until after layout and paint, so the runner's
/// `completeScript()` is never called while a frame is still in progress.
library;

import 'dart:async';

import 'package:flutter/material.dart';

import '../source_flutter_d4rt.dart';
import '../test_runner.dart';
import '../test_script_loader.dart';

/// Renders the widget produced by the current D4rt script.
///
/// [runner] exposes [TestRunner.pendingScript] when a new script is ready for
/// execution. [d4rt] is the shared interpreter instance; it is created once
/// in `_AppShellState` and passed here to avoid re-registering bridges on
/// every script invocation.
///
/// Layout contract: this widget fills its parent completely. Callers should
/// wrap it in an [Expanded] or sized container.
class D4rtScriptView extends StatefulWidget {
  final TestRunner runner;
  final SourceFlutterD4rt d4rt;

  const D4rtScriptView({
    super.key,
    required this.runner,
    required this.d4rt,
  });

  @override
  State<D4rtScriptView> createState() => _D4rtScriptViewState();
}

class _D4rtScriptViewState extends State<D4rtScriptView> {
  /// The most recently produced widget. Displayed until the next script
  /// replaces it or [runner._reload()] clears the result.
  Widget? _builtWidget;

  /// Incremented each time a new widget is produced. Used as a [KeyedSubtree]
  /// key to force a full element-subtree remount, preventing
  /// `InheritedElement` dependency leaks between scripts.
  int _generation = 0;

  @override
  void initState() {
    super.initState();
    widget.runner.addListener(_onRunnerChanged);
  }

  @override
  void didUpdateWidget(D4rtScriptView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.runner != widget.runner) {
      oldWidget.runner.removeListener(_onRunnerChanged);
      widget.runner.addListener(_onRunnerChanged);
    }
  }

  @override
  void dispose() {
    widget.runner.removeListener(_onRunnerChanged);
    super.dispose();
  }

  void _onRunnerChanged() {
    // Clear the displayed widget when the root is reloaded (lastResult == null
    // is the sentinel set by TestRunner._reload()).
    if (widget.runner.lastResult == null) {
      _builtWidget = null;
    }
    setState(() {});
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final pending = widget.runner.pendingScript;
    if (pending != null) {
      _executePending(context, pending);
    }

    if (_builtWidget != null) {
      return KeyedSubtree(
        key: ValueKey(_generation),
        child: _builtWidget!,
      );
    }
    return const _Placeholder();
  }

  /// Execute [pending] synchronously inside the Flutter build phase so the
  /// [BuildContext] is real and fully wired into the widget tree.
  ///
  /// Mirrors `_D4rtTestPageState._buildD4rtWidget` in the reference test app:
  /// - `runZonedGuarded` captures `print()` output and async zone errors.
  /// - `addPostFrameCallback` fires after layout + paint so the result is
  ///   never delivered while a frame is still in progress.
  void _executePending(BuildContext context, TestScript pending) {
    final output = <String>[];
    bool completed = false;
    Widget? resultWidget;
    String? errorMessage;
    StackTrace? errorStack;

    runZonedGuarded(
      () {
        try {
          resultWidget = widget.d4rt.build<Widget>(pending.source, context);
          _builtWidget = resultWidget;
          _generation++;

          if (!completed) {
            completed = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.runner.completeScript(
                TestResult.pass(
                  pending.name,
                  resultWidget!.runtimeType.toString(),
                  output: List<String>.unmodifiable(output),
                ),
              );
            });
          }
        } on SourceFlutterD4rtException catch (e) {
          errorMessage = e.message;
          if (!completed) {
            completed = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.runner.completeScript(
                TestResult.fail(
                  pending.name,
                  e.message,
                  null,
                  List<String>.unmodifiable(output),
                ),
              );
            });
          }
        } catch (e, st) {
          errorMessage = e.toString();
          errorStack = st;
          if (!completed) {
            completed = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.runner.completeScript(
                TestResult.fail(
                  pending.name,
                  e.toString(),
                  st,
                  List<String>.unmodifiable(output),
                ),
              );
            });
          }
        }
      },
      (error, stackTrace) {
        // Async zone error — should not happen with synchronous D4rt, but
        // guard against it to prevent an app crash.
        debugPrint('[D4rtScriptView] Uncaught zone error: $error\n$stackTrace');
        errorMessage ??= 'Uncaught zone error: $error';
        errorStack ??= stackTrace;
        if (!completed) {
          completed = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            widget.runner.completeScript(
              TestResult.fail(
                pending.name,
                'Uncaught zone error: $error',
                stackTrace,
                List<String>.unmodifiable(output),
              ),
            );
          });
        }
      },
      zoneSpecification: ZoneSpecification(
        print: (self, parent, zone, line) {
          output.add(line);
          parent.print(zone, '[D4rtScriptView] $line');
        },
      ),
    );

    // If an error occurred during build, replace the displayed widget with
    // the error display so the user sees something meaningful immediately
    // rather than the previous script's widget.
    if (errorMessage != null) {
      _builtWidget = _ErrorDisplay(
        message: errorMessage!,
        stack: errorStack,
      );
      _generation++;
    }
  }
}

// ── Supporting widgets ───────────────────────────────────────────────────────

class _Placeholder extends StatelessWidget {
  const _Placeholder();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.code,
            size: 48,
            color: theme.colorScheme.outlineVariant,
          ),
          const SizedBox(height: 12),
          Text(
            'The rendered widget will appear here',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorDisplay extends StatelessWidget {
  final String message;
  final StackTrace? stack;

  const _ErrorDisplay({required this.message, this.stack});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
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
                    Icon(Icons.error_outline, color: scheme.error, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Build error',
                      style: TextStyle(
                        color: scheme.error,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SelectableText(
                  message,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: scheme.onErrorContainer,
                  ),
                ),
              ],
            ),
          ),
          if (stack != null) ...[
            const SizedBox(height: 8),
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
