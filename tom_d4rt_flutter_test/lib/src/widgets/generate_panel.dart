/// "Generate" tab — user enters an app name + multi-line description
/// and clicks "Send prompt" to start a fresh session. Once a session
/// exists (the notifier holds an in-memory FS and conversation
/// history), a "Follow-up" form appears below for continuing the
/// conversation without resetting state.
///
/// State persistence:
///   • Name + initial description: persisted via [GeneratorPrefs]
///     (last value pre-filled on next launch).
///   • Follow-up prompts: NOT persisted — local widget state only,
///     cleared after each send.
library;

import 'dart:async';

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
  late final TextEditingController _nameCtrl;
  late final TextEditingController _descCtrl;
  final TextEditingController _followUpCtrl = TextEditingController();
  Timer? _persistDebounce;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.prefs.lastAppName);
    _descCtrl = TextEditingController(text: widget.prefs.lastDescription);
    _nameCtrl.addListener(_onTextChanged);
    _descCtrl.addListener(_onTextChanged);
    widget.notifier.addListener(_onNotifierChanged);
  }

  @override
  void dispose() {
    _persistDebounce?.cancel();
    widget.prefs.lastAppName = _nameCtrl.text;
    widget.prefs.lastDescription = _descCtrl.text;
    widget.notifier.removeListener(_onNotifierChanged);
    _nameCtrl.removeListener(_onTextChanged);
    _descCtrl.removeListener(_onTextChanged);
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _followUpCtrl.dispose();
    super.dispose();
  }

  void _onNotifierChanged() => setState(() {});

  void _onTextChanged() {
    widget.prefs.lastAppName = _nameCtrl.text;
    widget.prefs.lastDescription = _descCtrl.text;
    _persistDebounce?.cancel();
    _persistDebounce = Timer(const Duration(milliseconds: 500), () {
      widget.prefs.save();
    });
  }

  /// Send the initial prompt — always resets the session, even if the
  /// app name is unchanged. Matches the user's mental model: "Send
  /// prompt" = start fresh; "Send follow-up" = continue.
  void _sendInitial() {
    _persistDebounce?.cancel();
    widget.prefs.lastAppName = _nameCtrl.text;
    widget.prefs.lastDescription = _descCtrl.text;
    widget.prefs.save();
    widget.notifier.generate(
      prefs: widget.prefs,
      appName: _nameCtrl.text,
      description: _descCtrl.text,
    );
    widget.onSent();
  }

  void _sendFollowUp() {
    final text = _followUpCtrl.text;
    if (text.trim().isEmpty) return;
    widget.notifier.sendFollowUp(
      prefs: widget.prefs,
      prompt: text,
    );
    _followUpCtrl.clear();
    widget.onSent();
  }

  void _resetSession() {
    widget.notifier.resetSession();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final keyMissing = widget.prefs.apiKey.trim().isEmpty;
    final busy = widget.notifier.isBusy;
    final hasSession = widget.notifier.hasSession;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (keyMissing)
            _MissingKeyBanner(onTap: widget.onOpenSettings, scheme: scheme),
          if (keyMissing) const SizedBox(height: 12),
          if (hasSession) ...[
            _SessionBanner(
              notifier: widget.notifier,
              onReset: _resetSession,
              busy: busy,
            ),
            const SizedBox(height: 16),
          ],
          Text('App name', style: Theme.of(context).textTheme.titleSmall),
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
            hasSession ? 'Initial prompt' : 'Description',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _descCtrl,
            enabled: !busy,
            maxLines: 10,
            minLines: 10,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText:
                  'Describe the Flutter app you want the model to generate. '
                  'The system prompt covers interpreter limitations and the '
                  'tool-use protocol — just state what you want.',
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Icon(Icons.smart_toy_outlined, size: 18, color: scheme.outline),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Model: ${widget.prefs.model.label}'
                  '${widget.prefs.extendedThinking ? "  · thinking on" : ""}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: scheme.outline),
                ),
              ),
              FilledButton.icon(
                onPressed: (busy || keyMissing) ? null : _sendInitial,
                icon: busy && !hasSession
                    ? const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(hasSession ? Icons.restart_alt : Icons.send),
                label: Text(busy && !hasSession
                    ? 'Sending…'
                    : (hasSession ? 'Reset & send' : 'Send prompt')),
              ),
            ],
          ),
          if (hasSession) ...[
            const SizedBox(height: 28),
            const Divider(height: 1),
            const SizedBox(height: 20),
            Text('Follow-up',
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 6),
            Text(
              'Continues the current session — same in-memory FS, same '
              'conversation history. Cleared on send; not persisted '
              'across app restarts.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: scheme.outline,
                  ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _followUpCtrl,
              enabled: !busy && !keyMissing,
              maxLines: 10,
              minLines: 10,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText:
                    'e.g. "add a settings screen with a dark-mode toggle" '
                    'or "fix the overflow on the score panel".',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Spacer(),
                FilledButton.icon(
                  onPressed: (busy || keyMissing) ? null : _sendFollowUp,
                  icon: busy
                      ? const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.subdirectory_arrow_right),
                  label: Text(busy ? 'Sending…' : 'Send follow-up'),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _SessionBanner extends StatelessWidget {
  final GeneratorNotifier notifier;
  final VoidCallback onReset;
  final bool busy;
  const _SessionBanner({
    required this.notifier,
    required this.onReset,
    required this.busy,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final files = notifier.sessionFiles;
    return Material(
      color: scheme.secondaryContainer,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 10, 10, 10),
        child: Row(
          children: [
            Icon(Icons.history_edu_outlined,
                color: scheme.onSecondaryContainer),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Active session: ${notifier.sessionAppName}',
                    style: TextStyle(
                      color: scheme.onSecondaryContainer,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    files.isEmpty
                        ? '(no files yet)'
                        : '${files.length} file(s): ${files.join(", ")}',
                    style: TextStyle(
                      color: scheme.onSecondaryContainer,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            TextButton.icon(
              onPressed: busy ? null : onReset,
              icon: const Icon(Icons.delete_outline, size: 16),
              label: const Text('Reset'),
            ),
          ],
        ),
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
