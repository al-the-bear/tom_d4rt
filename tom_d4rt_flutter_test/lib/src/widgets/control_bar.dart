/// Bottom playback control strip — Back / Next.
///
/// Single-step only: there is no autoplay. The currently rendered script
/// remains on screen indefinitely so Flutter's normal frame-pump drives any
/// animations the script defines. Both buttons disable themselves while a
/// script execution is in flight, when the script list is empty, or when
/// the chosen path doesn't resolve, so the runner never receives commands
/// it can't service.
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
        final executing = runner.status == RunnerStatus.executing;
        final enabled = hasScripts && pathOk && !executing;
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
                  onPressed: enabled && !atStart ? runner.back : null,
                ),
                _CtrlButton(
                  icon: Icons.skip_next,
                  label: 'Next',
                  onPressed: enabled && !atEnd ? runner.next : null,
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
    return FilledButton.tonalIcon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}
