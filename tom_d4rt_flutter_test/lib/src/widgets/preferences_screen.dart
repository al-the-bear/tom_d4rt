/// Settings page for the generator feature.
///
/// Single-form layout with: API key, model picker, extended-thinking
/// toggle, max-tokens cap. Loads and saves via [GeneratorPrefs.load] /
/// `.save()`. The page exposes a static `pushAndAwait` helper so the
/// rest of the app can route to it and receive the (possibly mutated)
/// prefs back.
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../generator/prefs_store.dart';

class PreferencesScreen extends StatefulWidget {
  final GeneratorPrefs initial;
  const PreferencesScreen({super.key, required this.initial});

  static Future<GeneratorPrefs> pushAndAwait(
      BuildContext context, GeneratorPrefs current) async {
    final result = await Navigator.of(context).push<GeneratorPrefs>(
      MaterialPageRoute(
        builder: (_) => PreferencesScreen(initial: current),
      ),
    );
    return result ?? current;
  }

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  late final TextEditingController _apiKey;
  late final TextEditingController _maxTokens;
  late GeneratorModel _model;
  late bool _thinking;
  bool _obscure = true;
  String? _maxTokensError;

  @override
  void initState() {
    super.initState();
    _apiKey = TextEditingController(text: widget.initial.apiKey);
    _maxTokens =
        TextEditingController(text: widget.initial.maxTokens.toString());
    _model = widget.initial.model;
    _thinking = widget.initial.extendedThinking;
  }

  @override
  void dispose() {
    _apiKey.dispose();
    _maxTokens.dispose();
    super.dispose();
  }

  /// Validates and parses [_maxTokens]. Sets [_maxTokensError] on
  /// failure; returns null in that case so the save flow can short-
  /// circuit and ask the user to fix the value.
  int? _parsedMaxTokens() {
    final raw = _maxTokens.text.trim();
    final n = int.tryParse(raw);
    if (n == null) {
      setState(() => _maxTokensError = 'Enter an integer.');
      return null;
    }
    if (n < GeneratorPrefs.minMaxTokens || n > GeneratorPrefs.maxMaxTokens) {
      setState(() => _maxTokensError =
          'Must be between ${GeneratorPrefs.minMaxTokens} and '
          '${GeneratorPrefs.maxMaxTokens}.');
      return null;
    }
    if (_maxTokensError != null) {
      setState(() => _maxTokensError = null);
    }
    return n;
  }

  Future<void> _save() async {
    final parsedTokens = _parsedMaxTokens();
    if (parsedTokens == null) return;
    // Mutate the incoming prefs object so any non-settings fields
    // (lastAppName, lastDescription) survive — those are owned by
    // the Generate tab and shouldn't be reset every time the user
    // saves API key / model.
    final prefs = widget.initial
      ..apiKey = _apiKey.text.trim()
      ..model = _model
      ..extendedThinking = _thinking
      ..maxTokens = parsedTokens;
    await prefs.save();
    if (!mounted) return;
    Navigator.of(context).pop(prefs);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generator Settings'),
        actions: [
          TextButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.save),
            label: const Text('Save'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Anthropic API key',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          TextField(
            controller: _apiKey,
            obscureText: _obscure,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: 'sk-ant-...',
              suffixIcon: IconButton(
                icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                tooltip: _obscure ? 'Show' : 'Hide',
                onPressed: () => setState(() => _obscure = !_obscure),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Stored locally via shared_preferences (plaintext). Only this '
            'app on this machine can read it.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: scheme.outline,
                ),
          ),
          const SizedBox(height: 28),
          Text('Model', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          DropdownButtonFormField<GeneratorModel>(
            initialValue: _model,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            items: GeneratorModel.values
                .map((m) => DropdownMenuItem<GeneratorModel>(
                      value: m,
                      child: Text('${m.label} (${m.apiId})'),
                    ))
                .toList(),
            onChanged: (v) {
              if (v != null) setState(() => _model = v);
            },
          ),
          const SizedBox(height: 28),
          SwitchListTile(
            value: _thinking,
            onChanged: (v) => setState(() => _thinking = v),
            title: const Text('Enable extended thinking'),
            subtitle: const Text(
              'Streams the model\'s thinking blocks into the Log tab '
              'before the assistant text. Increases token cost.',
            ),
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 28),
          Text('Max output tokens',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          TextField(
            controller: _maxTokens,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: '${GeneratorPrefs.defaultMaxTokens}',
              errorText: _maxTokensError,
              suffixText: 'tokens',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Upper bound on the assistant response (sent as the '
            '`max_tokens` field). Higher values let the model produce '
            'longer apps but cost more. Allowed range: '
            '${GeneratorPrefs.minMaxTokens}–'
            '${GeneratorPrefs.maxMaxTokens}.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: scheme.outline,
                ),
          ),
        ],
      ),
    );
  }
}
