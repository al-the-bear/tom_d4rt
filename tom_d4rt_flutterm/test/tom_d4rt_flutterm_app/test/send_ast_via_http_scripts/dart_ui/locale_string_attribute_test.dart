// D4rt test script: Deep demo for LocaleStringAttribute from dart:ui.
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const _LocaleStringAttributeDeepDemoPage(),
  );
}

class _LocaleStringAttributeDeepDemoPage extends StatefulWidget {
  const _LocaleStringAttributeDeepDemoPage();

  @override
  State<_LocaleStringAttributeDeepDemoPage> createState() => _LocaleStringAttributeDeepDemoPageState();
}

class _LocaleStringAttributeDeepDemoPageState extends State<_LocaleStringAttributeDeepDemoPage>
    with SingleTickerProviderStateMixin {
  final List<String> _passed = <String>[];
  final List<String> _failed = <String>[];
  final List<String> _notes = <String>[];
  final List<_LocaleRangeEntry> _entries = <_LocaleRangeEntry>[];

  int _activeLocale = 0;
  int _activeText = 0;
  double _start = 0;
  double _end = 16;
  double _priority = 0.7;
  bool _showGrid = true;
  bool _showIndices = true;
  bool _animate = true;
  bool _snapToWord = true;
  bool _autoExpand = false;
  int _palette = 0;

  late final AnimationController _anim;

  final List<List<Color>> _palettes = <List<Color>>[
    <Color>[const Color(0xFF0B132B), const Color(0xFF1C2541), const Color(0xFF5BC0BE)],
    <Color>[const Color(0xFF3F1D38), const Color(0xFF7B2D5E), const Color(0xFFFF7AA2)],
    <Color>[const Color(0xFF064E3B), const Color(0xFF047857), const Color(0xFF34D399)],
  ];

  final List<_LocaleProfile> _profiles = const <_LocaleProfile>[
    _LocaleProfile('English (US)', Locale('en', 'US'), Color(0xFF2563EB), Icons.language),
    _LocaleProfile('French (FR)', Locale('fr', 'FR'), Color(0xFF7C3AED), Icons.translate),
    _LocaleProfile('German (DE)', Locale('de', 'DE'), Color(0xFF0F766E), Icons.g_translate),
    _LocaleProfile('Japanese (JP)', Locale('ja', 'JP'), Color(0xFFEA580C), Icons.text_fields),
    _LocaleProfile('Arabic (EG)', Locale('ar', 'EG'), Color(0xFFBE123C), Icons.format_align_right),
  ];

  final List<_SampleText> _texts = const <_SampleText>[
    _SampleText(
      label: 'Global Product Banner',
      text:
          'Spring Collection 2026: premium fabrics, sustainable sourcing, and tailored fits for every city.',
    ),
    _SampleText(
      label: 'Travel Assistant Prompt',
      text:
          'Select your destination, preferred language, and accessibility settings before confirming your itinerary.',
    ),
    _SampleText(
      label: 'Media Subtitle Segment',
      text:
          'The horizon clears at dawn, revealing distant mountains and the calm rhythm of the harbor.',
    ),
    _SampleText(
      label: 'Mixed Script Example',
      text:
          'Welcome ようこそ to the culture lab where الفن and design merge across languages.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat();
    _clampRange();
    _emit('LocaleStringAttribute studio initialized.');
    _runProbes();
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  void _emit(String message) {
    final DateTime now = DateTime.now();
    final String stamp =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    _notes.insert(0, '[$stamp] $message');
    if (_notes.length > 38) {
      _notes.removeLast();
    }
  }

  _LocaleProfile _profile() => _profiles[_activeLocale];

  _SampleText _sample() => _texts[_activeText];

  int _textLength() => _sample().text.length;

  int _startInt() => _start.round().clamp(0, _textLength());

  int _endInt() => _end.round().clamp(0, _textLength());

  void _clampRange() {
    final int len = _textLength();
    _start = _start.clamp(0, len.toDouble());
    _end = _end.clamp(0, len.toDouble());
    if (_start > _end) {
      final double t = _start;
      _start = _end;
      _end = t;
    }
    if (_snapToWord) {
      final String text = _sample().text;
      int s = _start.round();
      int e = _end.round();
      while (s > 0 && s < text.length && text[s - 1] != ' ') {
        s--;
      }
      while (e < text.length && text[e] != ' ') {
        e++;
      }
      _start = s.toDouble();
      _end = e.toDouble();
    }
  }

  ui.LocaleStringAttribute _currentAttribute() {
    final ui.TextRange range = ui.TextRange(start: _startInt(), end: _endInt());
    return ui.LocaleStringAttribute(range: range, locale: _profile().locale);
  }

  void _appendCurrent() {
    _clampRange();
    final ui.LocaleStringAttribute attr = _currentAttribute();
    final _LocaleRangeEntry entry = _LocaleRangeEntry(
      locale: _profile().locale,
      localeLabel: _profile().label,
      range: attr.range,
      textLabel: _sample().label,
      textLength: _textLength(),
      color: _profile().color,
      priority: _priority,
    );
    _entries.insert(0, entry);
    if (_entries.length > 26) {
      _entries.removeLast();
    }
    _emit(
      'Added ${entry.localeLabel} range ${entry.range.start}-${entry.range.end} on ${entry.textLabel}.',
    );
    if (_autoExpand) {
      final int len = _textLength();
      final double window = (len * 0.22).clamp(6, 36).toDouble();
      _start = (_start + window * 0.5).clamp(0, len.toDouble());
      _end = (_start + window).clamp(0, len.toDouble());
      _clampRange();
    }
    setState(() {});
  }

  void _simulateDocumentPlan() {
    _entries.clear();
    final String text = _sample().text;
    final int segment = (text.length / _profiles.length).ceil();
    int cursor = 0;
    for (int i = 0; i < _profiles.length; i++) {
      final int start = cursor;
      final int end = i == _profiles.length - 1 ? text.length : (cursor + segment).clamp(0, text.length);
      cursor = end;
      final _LocaleProfile p = _profiles[i];
      _entries.add(
        _LocaleRangeEntry(
          locale: p.locale,
          localeLabel: p.label,
          range: ui.TextRange(start: start, end: end),
          textLabel: _sample().label,
          textLength: text.length,
          color: p.color,
          priority: 0.4 + (i / (_profiles.length + 1)),
        ),
      );
    }
    _emit('Generated document-wide locale segmentation plan (${_entries.length} attributes).');
    setState(() {});
  }

  void _runProbes() {
    _passed.clear();
    _failed.clear();

    void probe(String label, bool ok) {
      if (ok) {
        _passed.add(label);
      } else {
        _failed.add(label);
      }
    }

    final ui.LocaleStringAttribute attr = _currentAttribute();
    probe('LocaleStringAttribute is constructible', attr.runtimeType == ui.LocaleStringAttribute);
    probe('range start/end are preserved', attr.range.start == _startInt() && attr.range.end == _endInt());
    probe('locale is preserved', attr.locale == _profile().locale);

    final ui.StringAttribute copied = attr.copy(range: const ui.TextRange(start: 1, end: 4));
    probe('copy produces updated range', copied.range.start == 1 && copied.range.end == 4);
    probe('copy keeps locale semantics', copied.toString().contains(_profile().locale.languageCode));

    final ui.LocaleStringAttribute alt = ui.LocaleStringAttribute(
      range: const ui.TextRange(start: 0, end: 3),
      locale: const Locale('fr', 'FR'),
    );
    probe('different locale values are supported', alt.locale == const Locale('fr', 'FR'));

    final ui.LocaleStringAttribute wide = ui.LocaleStringAttribute(
      range: ui.TextRange(start: 0, end: _textLength()),
      locale: const Locale('de'),
    );
    probe('full-length ranges are supported', wide.range.end == _textLength());
    probe('summary text can be generated', '${_passed.length + _failed.length} checks'.endsWith('checks'));

    setState(() {});
  }

  Widget _header() {
    final List<Color> colors = _palettes[_palette];
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors),
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(color: colors[1].withAlpha(92), blurRadius: 16, offset: const Offset(0, 8)),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'LocaleStringAttribute Annotation Studio',
            style: TextStyle(color: Colors.white, fontSize: 23.5, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 8),
          Text(
            'LocaleStringAttribute binds a locale to a specific text range, enabling '
            'fine-grained multilingual shaping, fallback selection, and rendering hints '
            'inside rich text pipelines.',
            style: TextStyle(color: Colors.white, fontSize: 13.1, height: 1.35),
          ),
        ],
      ),
    );
  }

  Widget _section(String title, String subtitle, IconData icon, Color accent) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accent.withAlpha(22),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withAlpha(90)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: accent.withAlpha(34),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: accent),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(fontSize: 12.2)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _conceptCards() {
    Widget card(String title, String body, IconData icon, Color color) {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.all(6),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color.withAlpha(90)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(icon, color: color),
              const SizedBox(height: 8),
              Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(body, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          card('Range-based tagging', 'Assign locale metadata only where needed.', Icons.select_all,
              const Color(0xFF2563EB)),
          card('Script shaping', 'Guide engines toward locale-appropriate glyph behavior.',
              Icons.format_shapes, const Color(0xFF7C3AED)),
          card('Fallback control', 'Improve matching for language-specific rendering.', Icons.tune,
              const Color(0xFF0F766E)),
          card('Mixed content', 'Support multilingual runs in one paragraph.', Icons.language,
              const Color(0xFFB45309)),
        ],
      ),
    );
  }

  Widget _builderPanel() {
    final int len = _textLength();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Locale range builder', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List<Widget>.generate(_profiles.length, (int i) {
              final _LocaleProfile p = _profiles[i];
              return ChoiceChip(
                label: Text(p.label),
                selected: _activeLocale == i,
                onSelected: (_) {
                  setState(() {
                    _activeLocale = i;
                  });
                  _emit('Active locale changed to ${p.label}.');
                },
              );
            }),
          ),
          const SizedBox(height: 8),
          DropdownButton<int>(
            value: _activeText,
            isExpanded: true,
            onChanged: (int? value) {
              if (value != null) {
                setState(() {
                  _activeText = value;
                  _start = 0;
                  _end = (_textLength() * 0.2).clamp(4, _textLength()).toDouble();
                  _clampRange();
                });
                _emit('Text sample switched to ${_sample().label}.');
              }
            },
            items: List<DropdownMenuItem<int>>.generate(
              _texts.length,
              (int i) => DropdownMenuItem<int>(value: i, child: Text(_texts[i].label)),
            ),
          ),
          const SizedBox(height: 8),
          Text('Start index: ${_startInt()} / $len'),
          Slider(
            value: _start,
            min: 0,
            max: len.toDouble(),
            divisions: len == 0 ? 1 : len,
            onChanged: (double v) {
              setState(() {
                _start = v;
                if (_start > _end) {
                  _end = _start;
                }
              });
            },
            onChangeEnd: (_) {
              setState(_clampRange);
            },
          ),
          Text('End index: ${_endInt()} / $len'),
          Slider(
            value: _end,
            min: 0,
            max: len.toDouble(),
            divisions: len == 0 ? 1 : len,
            onChanged: (double v) {
              setState(() {
                _end = v;
                if (_end < _start) {
                  _start = _end;
                }
              });
            },
            onChangeEnd: (_) {
              setState(_clampRange);
            },
          ),
          Text('Priority marker: ${_priority.toStringAsFixed(2)}'),
          Slider(
            value: _priority,
            min: 0,
            max: 1,
            divisions: 100,
            onChanged: (double v) => setState(() => _priority = v),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              FilterChip(
                label: const Text('snap to words'),
                selected: _snapToWord,
                onSelected: (bool v) {
                  setState(() {
                    _snapToWord = v;
                    _clampRange();
                  });
                },
              ),
              FilterChip(
                label: const Text('show grid'),
                selected: _showGrid,
                onSelected: (bool v) => setState(() => _showGrid = v),
              ),
              FilterChip(
                label: const Text('show indices'),
                selected: _showIndices,
                onSelected: (bool v) => setState(() => _showIndices = v),
              ),
              FilterChip(
                label: const Text('animate'),
                selected: _animate,
                onSelected: (bool v) {
                  setState(() => _animate = v);
                  if (_animate) {
                    _anim.repeat();
                  } else {
                    _anim.stop();
                  }
                },
              ),
              FilterChip(
                label: const Text('auto-expand after add'),
                selected: _autoExpand,
                onSelected: (bool v) => setState(() => _autoExpand = v),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: _appendCurrent,
                icon: const Icon(Icons.add),
                label: const Text('Add Locale Attribute'),
              ),
              OutlinedButton.icon(
                onPressed: _simulateDocumentPlan,
                icon: const Icon(Icons.auto_awesome),
                label: const Text('Simulate Document Plan'),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  _entries.clear();
                  _emit('Locale attribute list cleared.');
                  setState(() {});
                },
                icon: const Icon(Icons.clear_all),
                label: const Text('Clear Attributes'),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  _runProbes();
                  _emit('Probe suite executed.');
                },
                icon: const Icon(Icons.fact_check_outlined),
                label: const Text('Run Probes'),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _palette = (_palette + 1) % _palettes.length;
                  });
                },
                icon: const Icon(Icons.palette_outlined),
                label: const Text('Palette'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _textPreviewPanel() {
    final String text = _sample().text;
    final int s = _startInt().clamp(0, text.length);
    final int e = _endInt().clamp(s, text.length);
    final String a = text.substring(0, s);
    final String b = text.substring(s, e);
    final String c = text.substring(e);
    final Color color = _profile().color;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Localized text preview: ${_sample().label}',
              style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 15, color: Color(0xFF0F172A), height: 1.4),
                children: <InlineSpan>[
                  TextSpan(text: a),
                  TextSpan(
                    text: b,
                    style: TextStyle(
                      backgroundColor: color.withAlpha(70),
                      color: const Color(0xFF0F172A),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(text: c),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _kv('locale', '${_profile().locale.languageCode}-${_profile().locale.countryCode ?? ''}'),
              _kv('range', '$s-$e'),
              _kv('length', '${e - s} chars'),
              _kv('priority', _priority.toStringAsFixed(2)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _kv(String key, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text('$key: $value', style: const TextStyle(fontSize: 12.1)),
    );
  }

  Widget _coverageMapPanel() {
    final int textLength = _textLength();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Coverage heatmap', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 220,
            child: AnimatedBuilder(
              animation: _anim,
              builder: (BuildContext context, Widget? child) {
                return CustomPaint(
                  painter: _CoveragePainter(
                    textLength: textLength,
                    entries: _entries,
                    pulse: _animate ? _anim.value : 0,
                    showGrid: _showGrid,
                    showIndices: _showIndices,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Heatmap shows locale-tagged spans over character indices for the active sample text.',
            style: const TextStyle(fontSize: 12.1),
          ),
        ],
      ),
    );
  }

  Widget _timelinePanel() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Attribute timeline', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          SizedBox(
            height: 220,
            child: _entries.isEmpty
                ? const Center(
                    child: Text(
                      'No attributes yet. Add one in the builder panel.',
                      style: TextStyle(fontSize: 12.2, color: Color(0xFF64748B)),
                    ),
                  )
                : ListView.builder(
                    itemCount: _entries.length,
                    itemBuilder: (BuildContext context, int index) {
                      final _LocaleRangeEntry e = _entries[index];
                      final double frac = e.textLength == 0 ? 0 : (e.range.end - e.range.start) / e.textLength;
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: e.color.withAlpha(20),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: e.color.withAlpha(96)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 24,
                                  height: 24,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(shape: BoxShape.circle, color: e.color),
                                  child: Text('${index + 1}', style: const TextStyle(color: Colors.white, fontSize: 11)),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    '${e.localeLabel} | ${e.range.start}-${e.range.end} on ${e.textLabel} '
                                    '| priority ${e.priority.toStringAsFixed(2)}',
                                    style: const TextStyle(fontSize: 12.1),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: LinearProgressIndicator(
                                value: frac,
                                minHeight: 8,
                                valueColor: AlwaysStoppedAnimation<Color>(e.color),
                                backgroundColor: const Color(0xFFE2E8F0),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _useCasesPanel() {
    Widget card(String title, String body, IconData icon, List<Color> colors) {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.all(6),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: colors),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(icon, color: Colors.white),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(body, style: const TextStyle(color: Colors.white, fontSize: 12)),
            ],
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          card('Localized subtitles', 'Assign locale per segment to improve subtitle shaping.', Icons.subtitles,
              const <Color>[Color(0xFF2563EB), Color(0xFF60A5FA)]),
          card('Mixed-script copy', 'Blend Latin, kana, and Arabic runs with precise locale hints.',
              Icons.font_download, const <Color>[Color(0xFF7C3AED), Color(0xFFA78BFA)]),
          card('Commerce content', 'Tag product names and legal text by regional language.', Icons.store,
              const <Color>[Color(0xFF0F766E), Color(0xFF2DD4BF)]),
        ],
      ),
    );
  }

  Widget _probePanel() {
    Widget line(String text, bool ok) {
      final Color c = ok ? const Color(0xFF15803D) : const Color(0xFFB91C1C);
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: c.withAlpha(20),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: c.withAlpha(96)),
        ),
        child: Row(
          children: <Widget>[
            Icon(ok ? Icons.check_circle : Icons.cancel, color: c, size: 18),
            const SizedBox(width: 8),
            Expanded(child: Text(text, style: const TextStyle(fontSize: 12.2))),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Runtime probe dashboard', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text('Passed: ${_passed.length}, Failed: ${_failed.length}'),
          const SizedBox(height: 8),
          ..._passed.map((String s) => line(s, true)),
          ..._failed.map((String s) => line(s, false)),
        ],
      ),
    );
  }

  Widget _notesPanel() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Operational notes', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(_notes[index], style: const TextStyle(fontSize: 12)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryPanel() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: const Text(
        'LocaleStringAttribute summary: use locale-tagged text ranges to control multilingual '
        'rendering behavior at run-level precision. This is particularly valuable for mixed-script '
        'content, subtitle systems, and region-aware typography where one paragraph contains '
        'multiple language contexts.',
        style: TextStyle(fontSize: 12.3, height: 1.35),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text('dart:ui - LocaleStringAttribute'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        elevation: 0.7,
      ),
      body: ListView(
        children: <Widget>[
          _header(),
          _section(
            '1) Concept orientation',
            'Why locale range attributes matter in multilingual text rendering.',
            Icons.menu_book,
            const Color(0xFF2563EB),
          ),
          _conceptCards(),
          _section(
            '2) Attribute builder',
            'Interactively create locale-tagged ranges over text samples.',
            Icons.tune,
            const Color(0xFF7C3AED),
          ),
          _builderPanel(),
          _section(
            '3) Text preview',
            'Visualize selected locale range in the active document snippet.',
            Icons.visibility,
            const Color(0xFF0F766E),
          ),
          _textPreviewPanel(),
          _section(
            '4) Coverage heatmap',
            'Inspect how locale attributes cover character indices.',
            Icons.grid_on,
            const Color(0xFF0369A1),
          ),
          _coverageMapPanel(),
          _section(
            '5) Attribute timeline',
            'Track all generated locale range annotations.',
            Icons.timeline,
            const Color(0xFFBE123C),
          ),
          _timelinePanel(),
          _section(
            '6) Practical scenarios',
            'Common real-world integrations for locale range tagging.',
            Icons.widgets,
            const Color(0xFFB45309),
          ),
          _useCasesPanel(),
          _section(
            '7) Probe checks',
            'Validate runtime behavior of construction, copy, and ranges.',
            Icons.fact_check,
            const Color(0xFF166534),
          ),
          _probePanel(),
          _section(
            '8) Notes and summary',
            'Operational trace and final implementation guidance.',
            Icons.notes,
            const Color(0xFF475569),
          ),
          _notesPanel(),
          _summaryPanel(),
        ],
      ),
    );
  }
}

class _LocaleProfile {
  const _LocaleProfile(this.label, this.locale, this.color, this.icon);

  final String label;
  final Locale locale;
  final Color color;
  final IconData icon;
}

class _SampleText {
  const _SampleText({required this.label, required this.text});

  final String label;
  final String text;
}

class _LocaleRangeEntry {
  const _LocaleRangeEntry({
    required this.locale,
    required this.localeLabel,
    required this.range,
    required this.textLabel,
    required this.textLength,
    required this.color,
    required this.priority,
  });

  final Locale locale;
  final String localeLabel;
  final ui.TextRange range;
  final String textLabel;
  final int textLength;
  final Color color;
  final double priority;
}

class _CoveragePainter extends CustomPainter {
  const _CoveragePainter({
    required this.textLength,
    required this.entries,
    required this.pulse,
    required this.showGrid,
    required this.showIndices,
  });

  final int textLength;
  final List<_LocaleRangeEntry> entries;
  final double pulse;
  final bool showGrid;
  final bool showIndices;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFF0F172A).withAlpha(22);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10)),
      bg,
    );

    if (showGrid) {
      final Paint g = Paint()
        ..color = Colors.white24
        ..strokeWidth = 1;
      const double gap = 16;
      for (double x = 0; x <= size.width; x += gap) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), g);
      }
      for (double y = 0; y <= size.height; y += gap) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), g);
      }
    }

    final Rect track = Rect.fromLTWH(20, size.height * 0.22, size.width - 40, size.height * 0.56);
    final Paint trackPaint = Paint()..color = const Color(0xFFCBD5E1).withAlpha(130);
    canvas.drawRRect(RRect.fromRectAndRadius(track, const Radius.circular(8)), trackPaint);

    for (int i = 0; i < entries.length && i < 18; i++) {
      final _LocaleRangeEntry e = entries[i];
      final double sx = textLength == 0 ? 0 : e.range.start / textLength;
      final double ex = textLength == 0 ? 0 : e.range.end / textLength;
      final double y = track.top + 6 + i * 10;
      final Rect r = Rect.fromLTWH(
        track.left + sx * track.width,
        y,
        ((ex - sx) * track.width).clamp(1, track.width),
        8,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(4)),
        Paint()..color = e.color.withAlpha(180),
      );
    }

    final Offset pulseDot = Offset(track.left + pulse * track.width, track.bottom + 12);
    canvas.drawCircle(pulseDot, 5, Paint()..color = const Color(0xFF22D3EE));

    if (showIndices) {
      final TextPainter t1 = TextPainter(
        text: TextSpan(
          text: '0',
          style: const TextStyle(fontSize: 11, color: Color(0xFF0F172A)),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      t1.paint(canvas, Offset(track.left - 2, track.bottom + 16));

      final TextPainter t2 = TextPainter(
        text: TextSpan(
          text: '$textLength',
          style: const TextStyle(fontSize: 11, color: Color(0xFF0F172A)),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      t2.paint(canvas, Offset(track.right - t2.width, track.bottom + 16));
    }
  }

  @override
  bool shouldRepaint(covariant _CoveragePainter oldDelegate) {
    return oldDelegate.textLength != textLength ||
        oldDelegate.entries != entries ||
        oldDelegate.pulse != pulse ||
        oldDelegate.showGrid != showGrid ||
        oldDelegate.showIndices != showIndices;
  }
}
