/// "Generate" tab — user enters an app name + multi-line description
/// and clicks Send. The owning shell switches to the Log tab on send.
///
/// State (controllers, last-used name/description) lives in this widget.
/// The actual generation pipeline is owned by [GeneratorNotifier]; this
/// widget calls `generate(...)` and lets the notifier drive the rest.
library;

import 'package:flutter/material.dart';

import '../generator/generator_notifier.dart';
import '../generator/prefs_store.dart';

class GeneratePanel extends StatefulWidget {
  final GeneratorNotifier notifier;
  final GeneratorPrefs prefs;
  final VoidCallback onSent;
  final VoidCallback onOpenSettings;

  const GeneratePanel({
    super.key,
    required this.notifier,
    required this.prefs,
    required this.onSent,
    required this.onOpenSettings,
  });

  @override
  State<GeneratePanel> createState() => _GeneratePanelState();
}

class _GeneratePanelState extends State<GeneratePanel> {
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.notifier.addListener(_onNotifierChanged);
  }

  @override
  void dispose() {
    widget.notifier.removeListener(_onNotifierChanged);
    _nameCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  void _onNotifierChanged() => setState(() {});

  void _send() {
    widget.notifier.generate(
      prefs: widget.prefs,
      appName: _nameCtrl.text,
      description: _descCtrl.text,
    );
    widget.onSent();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final keyMissing = widget.prefs.apiKey.trim().isEmpty;
    final busy = widget.notifier.isBusy;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (keyMissing)
            _MissingKeyBanner(onTap: widget.onOpenSettings, scheme: scheme),
          if (keyMissing) const SizedBox(height: 12),
          Text(
            'App name',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _nameCtrl,
            enabled: !busy,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'e.g. weather_dashboard (snake_case, '
                  'becomes example/<name>/main.dart)',
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Description',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 6),
          // Ten-line tall input. We use a fixed-height TextField with
          // maxLines=10 so the field is the requested 10 visible rows
          // regardless of incoming text length.
          TextField(
            controller: _descCtrl,
            enabled: !busy,
            maxLines: 10,
            minLines: 10,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText:
                  'Describe the single-file Flutter app you want the '
                  'model to generate. The system prompt covers '
                  'interpreter limitations and output format — just '
                  'state what you want.',
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Icon(Icons.smart_toy_outlined,
                  size: 18, color: scheme.outline),
              const SizedBox(width: 6),
              Text('Model: ${widget.prefs.model.label}',
                  style: TextStyle(color: scheme.outline)),
              const SizedBox(width: 16),
              if (widget.prefs.extendedThinking)
                Icon(Icons.psychology_outlined,
                    size: 18, color: scheme.outline),
              if (widget.prefs.extendedThinking) const SizedBox(width: 4),
              if (widget.prefs.extendedThinking)
                Text('Extended thinking on',
                    style: TextStyle(color: scheme.outline)),
              const Spacer(),
              FilledButton.icon(
                onPressed: (busy || keyMissing) ? null : _send,
                icon: busy
                    ? const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.send),
                label: Text(busy ? 'Sending…' : 'Send prompt'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MissingKeyBanner extends StatelessWidget {
  final VoidCallback onTap;
  final ColorScheme scheme;
  const _MissingKeyBanner({required this.onTap, required this.scheme});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: scheme.errorContainer,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: scheme.error),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Anthropic API key is not set. Tap to open Settings.',
                  style: TextStyle(color: scheme.onErrorContainer),
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
