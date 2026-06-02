// Pomodoro home screen — listens to the [PomodoroSession] via
// `ListenableBuilder` and renders the countdown, controls, and phase-end
// chip. The seed colour for the surrounding theme is owned by
// [PomodoroApp]; this widget just consumes whatever `Theme.of(context)`
// currently provides so it follows the cross-phase colour transition.
import 'package:flutter/material.dart';

import 'phase_chip.dart';
import 'session.dart';

class PomodoroHome extends StatelessWidget {
  final PomodoroSession session;

  const PomodoroHome({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: session,
      builder: (context, _) {
        final scheme = Theme.of(context).colorScheme;
        final phase = session.phase;
        final phaseLabel = labelForPhase(phase);
        final isRunning = session.isRunning;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Pomodoro'),
            actions: [
              IconButton(
                key: const ValueKey<String>('skip'),
                tooltip: 'Skip phase',
                onPressed: session.skipPhase,
                icon: const Icon(Icons.skip_next),
              ),
              IconButton(
                key: const ValueKey<String>('reset'),
                tooltip: 'Reset',
                onPressed: session.reset,
                icon: const Icon(Icons.restart_alt),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                PhaseEndChip(
                  message: session.pendingNotice,
                  onDismiss: session.dismissNotice,
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _PhaseBadge(label: phaseLabel, scheme: scheme),
                        const SizedBox(height: 28),
                        _CountdownText(
                          seconds: session.remainingSeconds,
                          scheme: scheme,
                        ),
                        const SizedBox(height: 16),
                        _ProgressBar(
                          progress: session.progress,
                          scheme: scheme,
                        ),
                        const SizedBox(height: 24),
                        _CycleCounter(
                          completedWorkCycles: session.completedWorkCycles,
                          scheme: scheme,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                  child: SizedBox(
                    height: 56,
                    width: double.infinity,
                    child: FilledButton.icon(
                      key: const ValueKey<String>('toggle'),
                      onPressed: session.toggle,
                      icon: Icon(isRunning
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded),
                      label: Text(isRunning ? 'Pause' : 'Start'),
                      style: FilledButton.styleFrom(
                        padding:
                            const EdgeInsets.symmetric(vertical: 14),
                        textStyle: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PhaseBadge extends StatelessWidget {
  final String label;
  final ColorScheme scheme;

  const _PhaseBadge({required this.label, required this.scheme});

  @override
  Widget build(BuildContext context) {
    // The badge background tracks the theme so it transitions smoothly
    // alongside `AnimatedTheme` at the top.
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          color: scheme.onPrimaryContainer,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.6,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _CountdownText extends StatelessWidget {
  final int seconds;
  final ColorScheme scheme;

  const _CountdownText({required this.seconds, required this.scheme});

  @override
  Widget build(BuildContext context) {
    return Text(
      formatRemaining(seconds),
      key: const ValueKey<String>('countdown'),
      style: TextStyle(
        fontSize: 96,
        fontWeight: FontWeight.w200,
        color: scheme.onSurface,
        fontFamily: 'monospace',
        letterSpacing: -3,
        height: 1.0,
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final double progress;
  final ColorScheme scheme;

  const _ProgressBar({required this.progress, required this.scheme});

  @override
  Widget build(BuildContext context) {
    final clamped = progress.clamp(0.0, 1.0);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: LinearProgressIndicator(
          value: clamped,
          minHeight: 6,
          backgroundColor: scheme.surfaceContainerHighest,
          valueColor: AlwaysStoppedAnimation<Color>(scheme.primary),
        ),
      ),
    );
  }
}

class _CycleCounter extends StatelessWidget {
  final int completedWorkCycles;
  final ColorScheme scheme;

  const _CycleCounter({
    required this.completedWorkCycles,
    required this.scheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.local_fire_department,
            size: 18, color: scheme.tertiary),
        const SizedBox(width: 6),
        Text(
          'Cycles completed: $completedWorkCycles',
          style: TextStyle(
            color: scheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}
