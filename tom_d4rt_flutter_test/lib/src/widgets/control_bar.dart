/// Bottom playback control strip — back / play-pause / next.
///
/// All buttons disable themselves when the script list is empty or the
/// chosen path doesn't resolve, so the runner never receives commands it
/// can't service.
library;

import 'package:flutter/material.dart';

import '../script_root_notifier.dart';
import '../test_runner.dart';

class ControlBar extends StatelessWidget {
  final TestRunner runner;
  final ScriptRootNotifier rootNotifier;

  const ControlBar({
    super.key,
    required this.runner,
    required this.rootNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([runner, rootNotifier]),
      builder: (context, _) {
        final hasScripts = runner.scripts.isNotEmpty;
        final pathOk = rootNotifier.exists;
        final enabled = hasScripts && pathOk;
        final isRunning = runner.status == RunnerStatus.running;
        final atStart = runner.currentIndex <= 0;
        final atEnd = runner.currentIndex >= runner.scripts.length - 1;

        return Material(
          color: Theme.of(context).colorScheme.surfaceContainer,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _CtrlButton(
                  icon: Icons.skip_previous,
                  label: 'Back',
                  onPressed:
                      enabled && !isRunning && !atStart ? runner.back : null,
                ),
                _PlayPauseButton(runner: runner, enabled: enabled),
                _CtrlButton(
                  icon: Icons.skip_next,
                  label: 'Next',
                  onPressed: enabled && !isRunning && !atEnd ? runner.next : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CtrlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  const _CtrlButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}

class _PlayPauseButton extends StatelessWidget {
  final TestRunner runner;
  final bool enabled;

  const _PlayPauseButton({required this.runner, required this.enabled});

  @override
  Widget build(BuildContext context) {
    final isRunning = runner.status == RunnerStatus.running;
    return FilledButton.icon(
      onPressed: !enabled
          ? null
          : (isRunning ? runner.pause : runner.play),
      icon: Icon(isRunning ? Icons.pause : Icons.play_arrow),
      label: Text(isRunning ? 'Pause' : 'Play'),
    );
  }
}
