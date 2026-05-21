/// Local persistence for generator settings.
///
/// Wraps shared_preferences with a tiny API surface so the rest of the
/// generator code doesn't have to know about plugin lifecycles. Values
/// live in plaintext under the app's user-scoped prefs file — fine for
/// a local-only dev/test tool.
library;

import 'package:shared_preferences/shared_preferences.dart';

/// Anthropic models that the prefs UI exposes. Keep this list small —
/// the chooser is a static dropdown.
enum GeneratorModel {
  opus47('claude-opus-4-7', 'Opus 4.7'),
  sonnet46('claude-sonnet-4-6', 'Sonnet 4.6');

  final String apiId;
  final String label;
  const GeneratorModel(this.apiId, this.label);

  static GeneratorModel fromApiId(String id) {
    for (final m in GeneratorModel.values) {
      if (m.apiId == id) return m;
    }
    return GeneratorModel.opus47;
  }
}

class GeneratorPrefs {
  static const _kApiKey = 'generator.anthropicApiKey';
  static const _kModel = 'generator.model';
  static const _kThinking = 'generator.extendedThinking';
  static const _kMaxTokens = 'generator.maxTokens';
  static const _kLastAppName = 'generator.lastAppName';
  static const _kLastDescription = 'generator.lastDescription';

  static const defaultMaxTokens = 16000;
  static const minMaxTokens = 1024;
  static const maxMaxTokens = 200000;

  String apiKey;
  GeneratorModel model;
  bool extendedThinking;
  int maxTokens;
  String lastAppName;
  String lastDescription;

  GeneratorPrefs({
    this.apiKey = '',
    this.model = GeneratorModel.opus47,
    this.extendedThinking = true,
    this.maxTokens = defaultMaxTokens,
    this.lastAppName = '',
    this.lastDescription = '',
  });

  static Future<GeneratorPrefs> load() async {
    final p = await SharedPreferences.getInstance();
    return GeneratorPrefs(
      apiKey: p.getString(_kApiKey) ?? '',
      model: GeneratorModel.fromApiId(
          p.getString(_kModel) ?? GeneratorModel.opus47.apiId),
      extendedThinking: p.getBool(_kThinking) ?? true,
      maxTokens: p.getInt(_kMaxTokens) ?? defaultMaxTokens,
      lastAppName: p.getString(_kLastAppName) ?? '',
      lastDescription: p.getString(_kLastDescription) ?? '',
    );
  }

  Future<void> save() async {
    final p = await SharedPreferences.getInstance();
    await p.setString(_kApiKey, apiKey);
    await p.setString(_kModel, model.apiId);
    await p.setBool(_kThinking, extendedThinking);
    await p.setInt(_kMaxTokens, maxTokens);
    await p.setString(_kLastAppName, lastAppName);
    await p.setString(_kLastDescription, lastDescription);
  }
}
