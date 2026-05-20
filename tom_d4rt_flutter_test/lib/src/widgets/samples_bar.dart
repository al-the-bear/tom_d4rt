/// Horizontal strip that lets the user pick a multi-file sample app from
/// `example/<name>/` and launch it. Sits below the test-runner search bar
/// so the two navigation modes (single scripts vs. full apps) coexist.
library;

import 'package:flutter/material.dart';

import '../sample_apps_notifier.dart';

class SamplesBar extends StatelessWidget {
  final SampleAppsNotifier notifier;
  final void Function(SampleAppEntry sample) onRun;

  const SamplesBar({
    super.key,
    required this.notifier,
    required this.onRun,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: notifier,
      builder: (context, _) {
        final theme = Theme.of(context);
        final scheme = theme.colorScheme;
        final samples = notifier.samples;
        final selected = notifier.selected;
        final hasSamples = samples.isNotEmpty;
        return Material(
          color: scheme.surfaceContainerLow,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
            child: Row(
              children: [
                Icon(
                  Icons.apps,
                  size: 18,
                  color: scheme.onSurface,
                ),
                const SizedBox(width: 8),
                Text(
                  'Sample app:',
                  style: theme.textTheme.labelLarge,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: hasSamples
                      ? DropdownButtonHideUnderline(
                          child: DropdownButton<SampleAppEntry>(
                            value: selected,
                            isExpanded: true,
                            isDense: true,
                            items: [
                              for (final sample in samples)
                                DropdownMenuItem(
                                  value: sample,
                                  child: Text(
                                    sample.name,
                                    style: const TextStyle(
                                      fontFamily: 'monospace',
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                            ],
                            onChanged: notifier.select,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            notifier.rootExists
                                ? 'No sample apps in ${notifier.root}'
                                : 'example/ folder not found '
                                    '(looked in ${notifier.root})',
                            style: TextStyle(
                              fontSize: 11.5,
                              color: scheme.outline,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.refresh, size: 16),
                  tooltip: 'Rescan example/',
                  visualDensity: VisualDensity.compact,
                  onPressed: notifier.reload,
                ),
                const SizedBox(width: 4),
                FilledButton.icon(
                  onPressed: selected == null ? null : () => onRun(selected),
                  icon: const Icon(Icons.play_arrow, size: 18),
                  label: const Text('Run Sample'),
                  style: FilledButton.styleFrom(
                    visualDensity: VisualDensity.compact,
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
