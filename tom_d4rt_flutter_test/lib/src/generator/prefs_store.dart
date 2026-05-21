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

  String apiKey;
  GeneratorModel model;
  bool extendedThinking;

  GeneratorPrefs({
    this.apiKey = '',
    this.model = GeneratorModel.opus47,
    this.extendedThinking = true,
  });

  static Future<GeneratorPrefs> load() async {
    final p = await SharedPreferences.getInstance();
    return GeneratorPrefs(
      apiKey: p.getString(_kApiKey) ?? '',
      model: GeneratorModel.fromApiId(
          p.getString(_kModel) ?? GeneratorModel.opus47.apiId),
      extendedThinking: p.getBool(_kThinking) ?? true,
    );
  }

  Future<void> save() async {
    final p = await SharedPreferences.getInstance();
    await p.setString(_kApiKey, apiKey);
    await p.setString(_kModel, model.apiId);
    await p.setBool(_kThinking, extendedThinking);
  }
}
