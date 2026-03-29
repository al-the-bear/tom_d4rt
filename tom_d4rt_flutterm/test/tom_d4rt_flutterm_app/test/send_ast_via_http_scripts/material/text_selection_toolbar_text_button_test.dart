import 'dart:math' as math;

import 'package:flutter/material.dart';

const List<_ButtonFamily> _families = [
  _ButtonFamily(
    id: 'editing-core',
    title: 'Editing Core',
    description: 'Classic editing verbs used in most text selection surfaces.',
    actions: ['Cut', 'Copy', 'Paste', 'Select all'],
    accent: Color(0xFF0F766E),
  ),
  _ButtonFamily(
    id: 'writing-assist',
    title: 'Writing Assist',
    description: 'Actions for drafting, language refinement, and explanations.',
    actions: ['Simplify', 'Rewrite', 'Translate', 'Explain', 'Define'],
    accent: Color(0xFF155E75),
  ),
  _ButtonFamily(
    id: 'review-ops',
    title: 'Review Ops',
    description: 'Annotation and collaboration actions for feedback loops.',
    actions: ['Comment', 'Highlight', 'Resolve', 'Assign', 'Share'],
    accent: Color(0xFF1D4ED8),
  ),
  _ButtonFamily(
    id: 'developer-note',
    title: 'Developer Note',
    description: 'Snippet-centric actions seen in docs and code explorers.',
    actions: ['Copy', 'Format', 'Refactor', 'Open Symbol', 'Pin', 'Run'],
    accent: Color(0xFF7C3AED),
  ),
  _ButtonFamily(
    id: 'learning-mode',
    title: 'Learning Mode',
    description: 'Interactive learning actions with supportive UX language.',
    actions: ['Listen', 'Flashcard', 'Quiz', 'Explain', 'Example'],
    accent: Color(0xFFBE123C),
  ),
];

const List<_LayoutPreset> _layoutPresets = [
  _LayoutPreset(
    id: 'balanced',
    title: 'Balanced Padding',
    horizontal: 12,
    vertical: 8,
    alignment: Alignment.center,
  ),
  _LayoutPreset(
    id: 'compact',
    title: 'Compact Dense',
    horizontal: 8,
    vertical: 5,
    alignment: Alignment.center,
  ),
  _LayoutPreset(
    id: 'roomy',
    title: 'Roomy Reading',
    horizontal: 16,
    vertical: 10,
    alignment: Alignment.center,
  ),
  _LayoutPreset(
    id: 'left-biased',
    title: 'Left Biased',
    horizontal: 12,
    vertical: 7,
    alignment: Alignment.centerLeft,
  ),
  _LayoutPreset(
    id: 'right-biased',
    title: 'Right Biased',
    horizontal: 12,
    vertical: 7,
    alignment: Alignment.centerRight,
  ),
];

const List<_SnippetCase> _snippetCases = [
  _SnippetCase(
    id: 'snippet-a',
    title: 'Release Notes Excerpt',
    text:
        'TextSelectionToolbarTextButton helps compose compact action chips inside the selection toolbar while preserving platform visual language.',
  ),
  _SnippetCase(
    id: 'snippet-b',
    title: 'UX Review Memo',
    text:
        'Button label clarity and spacing directly influence whether users trust contextual actions near selected content.',
  ),
  _SnippetCase(
    id: 'snippet-c',
    title: 'Developer Handbook',
    text:
        'Custom toolbar buttons can host icons or rich children, but they should remain legible at small sizes and larger text scales.',
  ),
  _SnippetCase(
    id: 'snippet-d',
    title: 'Localization Planning',
    text:
        'Long translated labels can overflow quickly, so adaptive spacing and prioritized action order are essential.',
  ),
];

const List<String> _guideBullets = [
  'TextSelectionToolbarTextButton is the building block for each action in TextSelectionToolbar.',
  'Choose clear labels first, then tune padding and alignment for readability and touch comfort.',
  'Prefer concise primary actions and avoid overcrowding one toolbar row with too many verbs.',
  'Use disabled buttons intentionally to communicate unavailable actions without visual confusion.',
  'Test with long labels and larger text to avoid clipped or hard-to-scan action text.',
  'Custom child content can be useful, but keep icon+text combinations minimal and consistent.',
  'Pair this button with diagnostics during development to inspect layout quality under state changes.',
  'When building context menus, map actions to user intent of the selected text, not generic commands.',
  'Consistency across screens is easier when one reusable button composition pattern is adopted.',
  'Accessibility checks should include contrast, spacing, focus indication, and clear disabled affordances.',
];

const List<_QuestionAnswer> _faq = [
  _QuestionAnswer(
    question: 'Why not use plain TextButton directly in selection toolbars?',
    answer:
        'TextSelectionToolbarTextButton provides toolbar-appropriate semantics and expected structure for context actions.',
  ),
  _QuestionAnswer(
    question: 'Can the child be more than plain text?',
    answer:
        'Yes. You can provide icon+text or richer content, but keep it compact and readable in constrained widths.',
  ),
  _QuestionAnswer(
    question: 'How should I decide button padding?',
    answer:
        'Start from balanced spacing, then validate dense and roomy presets against your text scale and action count.',
  ),
  _QuestionAnswer(
    question: 'What is a practical way to test this widget?',
    answer:
        'Preview it in multiple toolbar compositions with realistic labels and edge-case lengths, exactly as this demo does.',
  ),
];

const List<Color> _panelPalette = [
  Color(0xFFEFF6FF),
  Color(0xFFF0FDFA),
  Color(0xFFEEF2FF),
  Color(0xFFFDF2F8),
  Color(0xFFFFF7ED),
  Color(0xFFF8FAFC),
];

dynamic build(BuildContext context) {
  var familyIndex = 0;
  var layoutIndex = 0;
  var snippetIndex = 0;
  var activeBoard = 0;
  var showGrid = true;
  var showDiagnostics = true;
  var compactDensity = false;
  var highContrast = false;
  var useLongLabels = false;
  var enableIconChildren = true;
  var disableAlternate = false;
  var largeText = false;
  var toolbarScale = 1.0;
  var panelScale = 1.0;
  var customHorizontalPadding = 12.0;
  var customVerticalPadding = 8.0;
  var interactionCount = 0;
  var timelineTick = 0;
  final eventLog = <String>[];

  void addEvent(String message) {
    final now = DateTime.now();
    final stamp =
        '[${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}]';
    eventLog.insert(0, '$stamp $message');
    if (eventLog.length > 22) {
      eventLog.removeRange(22, eventLog.length);
    }
  }

  debugPrint('TextSelectionToolbarTextButton deep demo initialized');

  return StatefulBuilder(
    builder: (context, setState) {
      final family = _families[familyIndex];
      final preset = _layoutPresets[layoutIndex];
      final snippet = _snippetCases[snippetIndex];
      final scheme = _deriveScheme(family.accent, highContrast);

      final resolvedHorizontal = customHorizontalPadding;
      final resolvedVertical = customVerticalPadding;
      final resolvedTextSize = (largeText ? 15.5 : 13.2) * (compactDensity ? 0.94 : 1.0);

      final theme = Theme.of(context).copyWith(
        colorScheme: scheme,
        scaffoldBackgroundColor: scheme.surface,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: scheme.onSurface,
              displayColor: scheme.onSurface,
            ),
      );

      return Theme(
        data: theme,
        child: Container(
          color: scheme.surface,
          child: Column(
            children: [
              _buildTopHeader(
                scheme: scheme,
                family: family,
                preset: preset,
                interactionCount: interactionCount,
                timelineTick: timelineTick,
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLeftControlDeck(
                      scheme: scheme,
                      familyIndex: familyIndex,
                      layoutIndex: layoutIndex,
                      snippetIndex: snippetIndex,
                      activeBoard: activeBoard,
                      showGrid: showGrid,
                      showDiagnostics: showDiagnostics,
                      compactDensity: compactDensity,
                      highContrast: highContrast,
                      useLongLabels: useLongLabels,
                      enableIconChildren: enableIconChildren,
                      disableAlternate: disableAlternate,
                      largeText: largeText,
                      toolbarScale: toolbarScale,
                      panelScale: panelScale,
                      customHorizontalPadding: customHorizontalPadding,
                      customVerticalPadding: customVerticalPadding,
                      onFamilyChanged: (value) {
                        setState(() {
                          familyIndex = value;
                          timelineTick += 1;
                          addEvent('Action family set to ${_families[value].title}.');
                        });
                      },
                      onLayoutChanged: (value) {
                        setState(() {
                          layoutIndex = value;
                          timelineTick += 1;
                          addEvent('Layout preset set to ${_layoutPresets[value].title}.');
                        });
                      },
                      onSnippetChanged: (value) {
                        setState(() {
                          snippetIndex = value;
                          timelineTick += 1;
                          addEvent('Snippet focus set to ${_snippetCases[value].title}.');
                        });
                      },
                      onBoardChanged: (value) {
                        setState(() {
                          activeBoard = value;
                          timelineTick += 1;
                          addEvent('Board switched to ${_boardLabel(value)}.');
                        });
                      },
                      onGridChanged: (value) {
                        setState(() {
                          showGrid = value;
                          timelineTick += 1;
                          addEvent('Grid ${value ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onDiagnosticsChanged: (value) {
                        setState(() {
                          showDiagnostics = value;
                          timelineTick += 1;
                          addEvent('Diagnostics ${value ? 'shown' : 'hidden'}.');
                        });
                      },
                      onCompactChanged: (value) {
                        setState(() {
                          compactDensity = value;
                          timelineTick += 1;
                          addEvent('Compact density ${value ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onContrastChanged: (value) {
                        setState(() {
                          highContrast = value;
                          timelineTick += 1;
                          addEvent('Contrast mode ${value ? 'high' : 'standard'}.');
                        });
                      },
                      onLongLabelsChanged: (value) {
                        setState(() {
                          useLongLabels = value;
                          timelineTick += 1;
                          addEvent('Long labels ${value ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onIconChildrenChanged: (value) {
                        setState(() {
                          enableIconChildren = value;
                          timelineTick += 1;
                          addEvent('Icon children ${value ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onDisableAlternateChanged: (value) {
                        setState(() {
                          disableAlternate = value;
                          timelineTick += 1;
                          addEvent('Alternate disable mode ${value ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onLargeTextChanged: (value) {
                        setState(() {
                          largeText = value;
                          timelineTick += 1;
                          addEvent('Large text mode ${value ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onToolbarScaleChanged: (value) {
                        setState(() {
                          toolbarScale = value;
                          timelineTick += 1;
                        });
                      },
                      onPanelScaleChanged: (value) {
                        setState(() {
                          panelScale = value;
                          timelineTick += 1;
                        });
                      },
                      onHorizontalPaddingChanged: (value) {
                        setState(() {
                          customHorizontalPadding = value;
                          timelineTick += 1;
                        });
                      },
                      onVerticalPaddingChanged: (value) {
                        setState(() {
                          customVerticalPadding = value;
                          timelineTick += 1;
                        });
                      },
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 12, 12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              scheme.surface,
                              scheme.surfaceContainerHighest.withAlpha(154),
                              scheme.surface,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: scheme.outlineVariant.withAlpha(130)),
                        ),
                        child: AnimatedScale(
                          scale: panelScale,
                          duration: Duration(milliseconds: 220),
                          alignment: Alignment.topCenter,
                          child: _buildBoardByIndex(
                            boardIndex: activeBoard,
                            scheme: scheme,
                            family: family,
                            preset: preset,
                            snippet: snippet,
                            showGrid: showGrid,
                            showDiagnostics: showDiagnostics,
                            compactDensity: compactDensity,
                            useLongLabels: useLongLabels,
                            enableIconChildren: enableIconChildren,
                            disableAlternate: disableAlternate,
                            resolvedHorizontal: resolvedHorizontal,
                            resolvedVertical: resolvedVertical,
                            resolvedTextSize: resolvedTextSize,
                            toolbarScale: toolbarScale,
                            onTapAction: (action, source) {
                              setState(() {
                                interactionCount += 1;
                                timelineTick += 1;
                                addEvent('$source -> $action');
                              });
                            },
                            eventLog: eventLog,
                            interactionCount: interactionCount,
                            timelineTick: timelineTick,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

String _boardLabel(int index) {
  const labels = ['Composition', 'Padding Lab', 'State Compare', 'Toolbar Integration', 'Guide + Timeline'];
  if (index < 0 || index >= labels.length) {
    return labels[0];
  }
  return labels[index];
}

Widget _buildTopHeader({
  required ColorScheme scheme,
  required _ButtonFamily family,
  required _LayoutPreset preset,
  required int interactionCount,
  required int timelineTick,
}) {
  return Container(
    margin: EdgeInsets.fromLTRB(12, 12, 12, 10),
    padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          family.accent.withAlpha(54),
          scheme.primary.withAlpha(40),
          scheme.secondary.withAlpha(32),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: family.accent.withAlpha(140)),
      boxShadow: [
        BoxShadow(
          color: family.accent.withAlpha(24),
          blurRadius: 16,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(170),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: family.accent.withAlpha(170)),
          ),
          child: CustomPaint(painter: _ButtonGlyphPainter(accent: family.accent, seed: timelineTick.toDouble())),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TextSelectionToolbarTextButton Atelier',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              ),
              SizedBox(height: 4),
              Text(
                '${family.title}  |  ${preset.title}  |  interactions: $interactionCount',
                style: TextStyle(fontWeight: FontWeight.w600, color: scheme.onSurface.withAlpha(180)),
              ),
              SizedBox(height: 5),
              Text(
                family.description,
                style: TextStyle(color: scheme.onSurface.withAlpha(170)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildLeftControlDeck({
  required ColorScheme scheme,
  required int familyIndex,
  required int layoutIndex,
  required int snippetIndex,
  required int activeBoard,
  required bool showGrid,
  required bool showDiagnostics,
  required bool compactDensity,
  required bool highContrast,
  required bool useLongLabels,
  required bool enableIconChildren,
  required bool disableAlternate,
  required bool largeText,
  required double toolbarScale,
  required double panelScale,
  required double customHorizontalPadding,
  required double customVerticalPadding,
  required ValueChanged<int> onFamilyChanged,
  required ValueChanged<int> onLayoutChanged,
  required ValueChanged<int> onSnippetChanged,
  required ValueChanged<int> onBoardChanged,
  required ValueChanged<bool> onGridChanged,
  required ValueChanged<bool> onDiagnosticsChanged,
  required ValueChanged<bool> onCompactChanged,
  required ValueChanged<bool> onContrastChanged,
  required ValueChanged<bool> onLongLabelsChanged,
  required ValueChanged<bool> onIconChildrenChanged,
  required ValueChanged<bool> onDisableAlternateChanged,
  required ValueChanged<bool> onLargeTextChanged,
  required ValueChanged<double> onToolbarScaleChanged,
  required ValueChanged<double> onPanelScaleChanged,
  required ValueChanged<double> onHorizontalPaddingChanged,
  required ValueChanged<double> onVerticalPaddingChanged,
}) {
  return Container(
    width: 372,
    margin: EdgeInsets.fromLTRB(12, 10, 0, 12),
    padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFF0FDFA),
          Color(0xFFEFF6FF),
          Color(0xFFEEF2FF),
          Color(0xFFFDF2F8),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: scheme.outlineVariant.withAlpha(140)),
    ),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Control Deck', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          SizedBox(height: 4),
          Text(
            'Configure button composition, spacing, states, and integration boards.',
            style: TextStyle(color: scheme.onSurface.withAlpha(172)),
          ),
          SizedBox(height: 10),
          _dropdownCard<int>(
            label: 'Action Family',
            value: familyIndex,
            items: [
              for (var i = 0; i < _families.length; i++)
                DropdownMenuItem<int>(value: i, child: Text(_families[i].title)),
            ],
            onChanged: onFamilyChanged,
          ),
          _dropdownCard<int>(
            label: 'Layout Preset',
            value: layoutIndex,
            items: [
              for (var i = 0; i < _layoutPresets.length; i++)
                DropdownMenuItem<int>(value: i, child: Text(_layoutPresets[i].title)),
            ],
            onChanged: onLayoutChanged,
          ),
          _dropdownCard<int>(
            label: 'Snippet Context',
            value: snippetIndex,
            items: [
              for (var i = 0; i < _snippetCases.length; i++)
                DropdownMenuItem<int>(value: i, child: Text(_snippetCases[i].title)),
            ],
            onChanged: onSnippetChanged,
          ),
          _dropdownCard<int>(
            label: 'Active Board',
            value: activeBoard,
            items: [
              for (var i = 0; i < 5; i++)
                DropdownMenuItem<int>(value: i, child: Text(_boardLabel(i))),
            ],
            onChanged: onBoardChanged,
          ),
          SizedBox(height: 8),
          _switchCard(
            title: 'Show grid overlay',
            subtitle: 'Display helper grid in composition board',
            value: showGrid,
            onChanged: onGridChanged,
          ),
          _switchCard(
            title: 'Show diagnostics',
            subtitle: 'Reveal sizing and state resolution details',
            value: showDiagnostics,
            onChanged: onDiagnosticsChanged,
          ),
          _switchCard(
            title: 'Compact density',
            subtitle: 'Use tighter button geometry',
            value: compactDensity,
            onChanged: onCompactChanged,
          ),
          _switchCard(
            title: 'High contrast',
            subtitle: 'Increase visual contrast intensity',
            value: highContrast,
            onChanged: onContrastChanged,
          ),
          _switchCard(
            title: 'Long labels',
            subtitle: 'Stress action text width and wrapping',
            value: useLongLabels,
            onChanged: onLongLabelsChanged,
          ),
          _switchCard(
            title: 'Icon children',
            subtitle: 'Use icon + text child compositions',
            value: enableIconChildren,
            onChanged: onIconChildrenChanged,
          ),
          _switchCard(
            title: 'Disable alternates',
            subtitle: 'Disable every second action for state checks',
            value: disableAlternate,
            onChanged: onDisableAlternateChanged,
          ),
          _switchCard(
            title: 'Large text',
            subtitle: 'Increase typography for accessibility checks',
            value: largeText,
            onChanged: onLargeTextChanged,
          ),
          SizedBox(height: 8),
          _sliderCard(
            label: 'Toolbar scale',
            value: toolbarScale,
            min: 0.8,
            max: 1.35,
            onChanged: onToolbarScaleChanged,
          ),
          _sliderCard(
            label: 'Panel scale',
            value: panelScale,
            min: 0.9,
            max: 1.12,
            onChanged: onPanelScaleChanged,
          ),
          _sliderCard(
            label: 'Horizontal padding',
            value: customHorizontalPadding,
            min: 6,
            max: 20,
            onChanged: onHorizontalPaddingChanged,
          ),
          _sliderCard(
            label: 'Vertical padding',
            value: customVerticalPadding,
            min: 4,
            max: 14,
            onChanged: onVerticalPaddingChanged,
          ),
        ],
      ),
    ),
  );
}

Widget _dropdownCard<T>({
  required String label,
  required T value,
  required List<DropdownMenuItem<T>> items,
  required ValueChanged<T> onChanged,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    padding: EdgeInsets.fromLTRB(10, 9, 10, 10),
    decoration: BoxDecoration(
      color: Colors.white.withAlpha(170),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.black.withAlpha(24)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.w700)),
        SizedBox(height: 6),
        DropdownButtonFormField<T>(
          initialValue: value,
          isExpanded: true,
          decoration: InputDecoration(border: OutlineInputBorder(), isDense: true),
          items: items,
          onChanged: (next) {
            if (next != null) {
              onChanged(next);
            }
          },
        ),
      ],
    ),
  );
}

Widget _switchCard({
  required String title,
  required String subtitle,
  required bool value,
  required ValueChanged<bool> onChanged,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
    decoration: BoxDecoration(
      color: Colors.white.withAlpha(162),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.black.withAlpha(21)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(title, style: TextStyle(fontWeight: FontWeight.w700))),
            Switch(value: value, onChanged: onChanged),
          ],
        ),
        Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.black.withAlpha(166))),
      ],
    ),
  );
}

Widget _sliderCard({
  required String label,
  required double value,
  required double min,
  required double max,
  required ValueChanged<double> onChanged,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white.withAlpha(170),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.black.withAlpha(20)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ${value.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.w700)),
        Slider(value: value, min: min, max: max, onChanged: onChanged),
      ],
    ),
  );
}

Widget _buildBoardByIndex({
  required int boardIndex,
  required ColorScheme scheme,
  required _ButtonFamily family,
  required _LayoutPreset preset,
  required _SnippetCase snippet,
  required bool showGrid,
  required bool showDiagnostics,
  required bool compactDensity,
  required bool useLongLabels,
  required bool enableIconChildren,
  required bool disableAlternate,
  required double resolvedHorizontal,
  required double resolvedVertical,
  required double resolvedTextSize,
  required double toolbarScale,
  required void Function(String action, String source) onTapAction,
  required List<String> eventLog,
  required int interactionCount,
  required int timelineTick,
}) {
  switch (boardIndex) {
    case 0:
      return _buildCompositionBoard(
        scheme: scheme,
        family: family,
        preset: preset,
        showGrid: showGrid,
        showDiagnostics: showDiagnostics,
        compactDensity: compactDensity,
        useLongLabels: useLongLabels,
        enableIconChildren: enableIconChildren,
        disableAlternate: disableAlternate,
        resolvedHorizontal: resolvedHorizontal,
        resolvedVertical: resolvedVertical,
        resolvedTextSize: resolvedTextSize,
        toolbarScale: toolbarScale,
        onTapAction: onTapAction,
      );
    case 1:
      return _buildPaddingLabBoard(
        scheme: scheme,
        family: family,
        compactDensity: compactDensity,
        useLongLabels: useLongLabels,
        enableIconChildren: enableIconChildren,
        resolvedTextSize: resolvedTextSize,
        toolbarScale: toolbarScale,
        onTapAction: onTapAction,
      );
    case 2:
      return _buildStateCompareBoard(
        scheme: scheme,
        family: family,
        compactDensity: compactDensity,
        useLongLabels: useLongLabels,
        enableIconChildren: enableIconChildren,
        disableAlternate: disableAlternate,
        resolvedHorizontal: resolvedHorizontal,
        resolvedVertical: resolvedVertical,
        resolvedTextSize: resolvedTextSize,
        toolbarScale: toolbarScale,
        showDiagnostics: showDiagnostics,
        onTapAction: onTapAction,
      );
    case 3:
      return _buildToolbarIntegrationBoard(
        scheme: scheme,
        family: family,
        snippet: snippet,
        compactDensity: compactDensity,
        useLongLabels: useLongLabels,
        enableIconChildren: enableIconChildren,
        disableAlternate: disableAlternate,
        resolvedHorizontal: resolvedHorizontal,
        resolvedVertical: resolvedVertical,
        resolvedTextSize: resolvedTextSize,
        toolbarScale: toolbarScale,
        onTapAction: onTapAction,
      );
    default:
      return _buildGuideBoard(
        scheme: scheme,
        family: family,
        eventLog: eventLog,
        interactionCount: interactionCount,
        timelineTick: timelineTick,
      );
  }
}

Widget _buildCompositionBoard({
  required ColorScheme scheme,
  required _ButtonFamily family,
  required _LayoutPreset preset,
  required bool showGrid,
  required bool showDiagnostics,
  required bool compactDensity,
  required bool useLongLabels,
  required bool enableIconChildren,
  required bool disableAlternate,
  required double resolvedHorizontal,
  required double resolvedVertical,
  required double resolvedTextSize,
  required double toolbarScale,
  required void Function(String action, String source) onTapAction,
}) {
  final actions = _actionsForDisplay(family.actions, useLongLabels);
  final sceneSize = Size(560, 430);

  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          title: 'Composition Board',
          subtitle: 'Core button composition patterns for TextSelectionToolbarTextButton.',
          chip: family.title,
          scheme: scheme,
        ),
        SizedBox(height: 12),
        Center(
          child: Container(
            width: sceneSize.width,
            height: sceneSize.height,
            decoration: BoxDecoration(
              color: scheme.surface.withAlpha(188),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: scheme.outlineVariant.withAlpha(130)),
            ),
            child: Stack(
              children: [
                if (showGrid)
                  Positioned.fill(
                    child: CustomPaint(painter: _GridOverlayPainter(color: scheme.outlineVariant.withAlpha(92))),
                  ),
                Positioned(
                  left: 26,
                  top: 22,
                  child: SizedBox(
                    width: 500,
                    child: Text(
                      'This board previews button composition inside a toolbar row. '
                      'Toggle icon-child mode and long labels to inspect practical constraints.',
                      style: TextStyle(color: scheme.onSurface.withAlpha(176)),
                    ),
                  ),
                ),
                Positioned(
                  left: 30,
                  top: 94,
                  child: Transform.scale(
                    scale: toolbarScale,
                    alignment: Alignment.topLeft,
                    child: TextSelectionToolbar(
                      anchorAbove: Offset(190, 50),
                      anchorBelow: Offset(190, 86),
                      children: [
                        for (var i = 0; i < actions.length; i++)
                          _toolbarActionButton(
                            label: actions[i],
                            compactDensity: compactDensity,
                            enableIconChildren: enableIconChildren,
                            disabled: disableAlternate && i.isOdd,
                            horizontalPadding: resolvedHorizontal,
                            verticalPadding: resolvedVertical,
                            textSize: resolvedTextSize,
                            alignment: preset.alignment,
                            onTap: () => onTapAction(actions[i], 'Composition Board'),
                          ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 30,
                  top: 205,
                  child: _miniCard(
                    scheme: scheme,
                    title: 'Pattern A · Text only',
                    child: TextSelectionToolbarTextButton(
                      padding: EdgeInsets.symmetric(horizontal: resolvedHorizontal, vertical: resolvedVertical),
                      onPressed: () => onTapAction('Text-only action', 'Composition Board'),
                      child: Text('Copy', style: TextStyle(fontSize: resolvedTextSize)),
                    ),
                  ),
                ),
                Positioned(
                  left: 202,
                  top: 205,
                  child: _miniCard(
                    scheme: scheme,
                    title: 'Pattern B · Icon + text',
                    child: TextSelectionToolbarTextButton(
                      padding: EdgeInsets.symmetric(horizontal: resolvedHorizontal, vertical: resolvedVertical),
                      onPressed: () => onTapAction('Icon-text action', 'Composition Board'),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.copy_all, size: compactDensity ? 14 : 16),
                          SizedBox(width: 5),
                          Text('Copy', style: TextStyle(fontSize: resolvedTextSize)),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 374,
                  top: 205,
                  child: _miniCard(
                    scheme: scheme,
                    title: 'Pattern C · Disabled',
                    child: TextSelectionToolbarTextButton(
                      padding: EdgeInsets.symmetric(horizontal: resolvedHorizontal, vertical: resolvedVertical),
                      onPressed: null,
                      child: Text('Paste', style: TextStyle(fontSize: resolvedTextSize)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showDiagnostics) ...[
          SizedBox(height: 12),
          _diagnosticsPanel(
            scheme: scheme,
            title: 'Composition diagnostics',
            lines: [
              'actions: ${actions.length}',
              'padding: h=${resolvedHorizontal.toStringAsFixed(1)}, v=${resolvedVertical.toStringAsFixed(1)}',
              'textSize: ${resolvedTextSize.toStringAsFixed(1)}',
              'alignment: ${preset.alignment}',
              'icon children: ${enableIconChildren ? 'on' : 'off'}',
            ],
          ),
        ],
        SizedBox(height: 12),
        _teachingNotes(
          scheme: scheme,
          title: 'What this board teaches',
          bullets: [
            'TextSelectionToolbarTextButton works as the atomic action unit inside TextSelectionToolbar.',
            'Icon + text children are possible, but should remain compact to avoid crowded rows.',
            'Disabled states remain important for communicating unavailable contextual actions.',
          ],
        ),
      ],
    ),
  );
}

Widget _miniCard({required ColorScheme scheme, required String title, required Widget child}) {
  return Container(
    width: 156,
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: scheme.surfaceContainerHighest.withAlpha(134),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: scheme.outlineVariant.withAlpha(130)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5)),
        SizedBox(height: 8),
        child,
      ],
    ),
  );
}

Widget _buildPaddingLabBoard({
  required ColorScheme scheme,
  required _ButtonFamily family,
  required bool compactDensity,
  required bool useLongLabels,
  required bool enableIconChildren,
  required double resolvedTextSize,
  required double toolbarScale,
  required void Function(String action, String source) onTapAction,
}) {
  final actions = _actionsForDisplay(family.actions, useLongLabels);
  final samplePads = [
    EdgeInsets.symmetric(horizontal: 6, vertical: compactDensity ? 4 : 6),
    EdgeInsets.symmetric(horizontal: 10, vertical: compactDensity ? 5 : 7),
    EdgeInsets.symmetric(horizontal: 14, vertical: compactDensity ? 6 : 8),
    EdgeInsets.symmetric(horizontal: 18, vertical: compactDensity ? 7 : 9),
  ];

  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          title: 'Padding and Alignment Lab',
          subtitle: 'Compare spacing presets and alignment choices side by side.',
          chip: 'layout tuning',
          scheme: scheme,
        ),
        SizedBox(height: 10),
        for (var i = 0; i < samplePads.length; i++)
          Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _panelPalette[i % _panelPalette.length],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: scheme.outlineVariant.withAlpha(122)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Preset ${i + 1} · h=${samplePads[i].horizontal} v=${samplePads[i].vertical}',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 8),
                Transform.scale(
                  scale: toolbarScale,
                  alignment: Alignment.topLeft,
                  child: TextSelectionToolbar(
                    anchorAbove: Offset(190, 50),
                    anchorBelow: Offset(190, 86),
                    children: [
                      for (var j = 0; j < math.min(actions.length, 5); j++)
                        TextSelectionToolbarTextButton(
                          padding: samplePads[i],
                          onPressed: () => onTapAction(actions[j], 'Padding Lab'),
                          child: enableIconChildren && j.isEven
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(_iconForAction(actions[j]), size: compactDensity ? 14 : 16),
                                    SizedBox(width: 4),
                                    Text(actions[j], style: TextStyle(fontSize: resolvedTextSize)),
                                  ],
                                )
                              : Text(actions[j], style: TextStyle(fontSize: resolvedTextSize)),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        _teachingNotes(
          scheme: scheme,
          title: 'Padding guidance',
          bullets: [
            'Small padding increases density but can hurt tap comfort and readability.',
            'Roomier padding improves scanability for longer labels and larger text scales.',
            'Use one baseline preset across app surfaces for consistency.',
          ],
        ),
      ],
    ),
  );
}

Widget _buildStateCompareBoard({
  required ColorScheme scheme,
  required _ButtonFamily family,
  required bool compactDensity,
  required bool useLongLabels,
  required bool enableIconChildren,
  required bool disableAlternate,
  required double resolvedHorizontal,
  required double resolvedVertical,
  required double resolvedTextSize,
  required double toolbarScale,
  required bool showDiagnostics,
  required void Function(String action, String source) onTapAction,
}) {
  final actions = _actionsForDisplay(family.actions, useLongLabels);

  Widget row(String label, bool disabledMode, bool iconsMode) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surface.withAlpha(188),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant.withAlpha(128)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w700)),
          SizedBox(height: 8),
          Transform.scale(
            scale: toolbarScale,
            alignment: Alignment.topLeft,
            child: TextSelectionToolbar(
              anchorAbove: Offset(170, 42),
              anchorBelow: Offset(170, 78),
              children: [
                for (var i = 0; i < math.min(actions.length, 6); i++)
                  _toolbarActionButton(
                    label: actions[i],
                    compactDensity: compactDensity,
                    enableIconChildren: iconsMode,
                    disabled: disabledMode && (disableAlternate ? i.isOdd : i == 2),
                    horizontalPadding: resolvedHorizontal,
                    verticalPadding: resolvedVertical,
                    textSize: resolvedTextSize,
                    alignment: Alignment.center,
                    onTap: () => onTapAction(actions[i], 'State Compare'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          title: 'State Comparison Board',
          subtitle: 'Enabled, mixed disabled, and icon/text composition state checks.',
          chip: 'state behavior',
          scheme: scheme,
        ),
        SizedBox(height: 10),
        row('All enabled baseline', false, enableIconChildren),
        row('Mixed disabled stress test', true, enableIconChildren),
        row('Text-only fallback', true, false),
        if (showDiagnostics)
          _diagnosticsPanel(
            scheme: scheme,
            title: 'State diagnostics',
            lines: [
              'Alternate disable mode: ${disableAlternate ? 'on' : 'off'}',
              'Icon children: ${enableIconChildren ? 'enabled' : 'disabled'}',
              'Action count previewed: ${math.min(actions.length, 6)}',
              'Padding tokens: h=${resolvedHorizontal.toStringAsFixed(1)}, v=${resolvedVertical.toStringAsFixed(1)}',
            ],
          ),
      ],
    ),
  );
}

Widget _buildToolbarIntegrationBoard({
  required ColorScheme scheme,
  required _ButtonFamily family,
  required _SnippetCase snippet,
  required bool compactDensity,
  required bool useLongLabels,
  required bool enableIconChildren,
  required bool disableAlternate,
  required double resolvedHorizontal,
  required double resolvedVertical,
  required double resolvedTextSize,
  required double toolbarScale,
  required void Function(String action, String source) onTapAction,
}) {
  final actions = _actionsForDisplay(family.actions, useLongLabels);

  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          title: 'Toolbar Integration Board',
          subtitle: 'Contextual snippet cards showing realistic toolbar action composition.',
          chip: snippet.title,
          scheme: scheme,
        ),
        SizedBox(height: 10),
        for (var i = 0; i < _snippetCases.length; i++)
          _integrationCard(
            scheme: scheme,
            snippet: _snippetCases[i],
            selected: _snippetCases[i].id == snippet.id,
            actions: actions,
            compactDensity: compactDensity,
            enableIconChildren: enableIconChildren,
            disableAlternate: disableAlternate,
            resolvedHorizontal: resolvedHorizontal,
            resolvedVertical: resolvedVertical,
            resolvedTextSize: resolvedTextSize,
            toolbarScale: toolbarScale,
            onTapAction: onTapAction,
          ),
        _teachingNotes(
          scheme: scheme,
          title: 'Integration guidance',
          bullets: [
            'Button labels should map to selected-text intent in each content domain.',
            'Snippet-based previews help validate whether the same action set feels coherent.',
            'Use disabled actions to represent unavailable operations without breaking menu structure.',
          ],
        ),
      ],
    ),
  );
}

Widget _integrationCard({
  required ColorScheme scheme,
  required _SnippetCase snippet,
  required bool selected,
  required List<String> actions,
  required bool compactDensity,
  required bool enableIconChildren,
  required bool disableAlternate,
  required double resolvedHorizontal,
  required double resolvedVertical,
  required double resolvedTextSize,
  required double toolbarScale,
  required void Function(String action, String source) onTapAction,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: selected ? scheme.primaryContainer.withAlpha(110) : scheme.surface.withAlpha(188),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: selected ? scheme.primary.withAlpha(166) : scheme.outlineVariant.withAlpha(124),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(snippet.title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        SizedBox(height: 6),
        Text(snippet.text),
        SizedBox(height: 10),
        Transform.scale(
          scale: toolbarScale,
          alignment: Alignment.topLeft,
          child: TextSelectionToolbar(
            anchorAbove: Offset(180, 44),
            anchorBelow: Offset(180, 80),
            children: [
              for (var i = 0; i < math.min(actions.length, 5); i++)
                _toolbarActionButton(
                  label: actions[i],
                  compactDensity: compactDensity,
                  enableIconChildren: enableIconChildren,
                  disabled: disableAlternate && i == 1,
                  horizontalPadding: resolvedHorizontal,
                  verticalPadding: resolvedVertical,
                  textSize: resolvedTextSize,
                  alignment: Alignment.center,
                  onTap: () => onTapAction(actions[i], 'Integration / ${snippet.title}'),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildGuideBoard({
  required ColorScheme scheme,
  required _ButtonFamily family,
  required List<String> eventLog,
  required int interactionCount,
  required int timelineTick,
}) {
  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          title: 'Guide and Timeline',
          subtitle: 'Instructive notes plus live interaction history for this button widget.',
          chip: family.title,
          scheme: scheme,
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: scheme.tertiaryContainer.withAlpha(110),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: scheme.tertiary.withAlpha(130)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('How to use TextSelectionToolbarTextButton well',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
              SizedBox(height: 8),
              for (final bullet in _guideBullets) _bulletLine(bullet),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest.withAlpha(132),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: scheme.outlineVariant.withAlpha(130)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('FAQ', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
              SizedBox(height: 8),
              for (final item in _faq)
                Padding(
                  padding: EdgeInsets.only(bottom: 9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.question, style: TextStyle(fontWeight: FontWeight.w700)),
                      SizedBox(height: 2),
                      Text(item.answer),
                    ],
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: scheme.primaryContainer.withAlpha(104),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: scheme.primary.withAlpha(122)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Interaction timeline', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
              SizedBox(height: 8),
              Text('Interactions: $interactionCount  |  Timeline ticks: $timelineTick'),
              SizedBox(height: 8),
              if (eventLog.isEmpty)
                Text('No events yet. Interact with controls and actions to populate this timeline.')
              else
                for (final line in eventLog)
                  Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Text(line, style: TextStyle(fontFamily: 'monospace', fontSize: 12.5)),
                  ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _sectionHeader({
  required String title,
  required String subtitle,
  required String chip,
  required ColorScheme scheme,
}) {
  return Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
            SizedBox(height: 4),
            Text(subtitle, style: TextStyle(color: scheme.onSurface.withAlpha(176))),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: scheme.primaryContainer.withAlpha(170),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(chip, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
      ),
    ],
  );
}

Widget _diagnosticsPanel({required ColorScheme scheme, required String title, required List<String> lines}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: scheme.primaryContainer.withAlpha(104),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: scheme.primary.withAlpha(126)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        SizedBox(height: 8),
        for (final line in lines)
          Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: Text(line, style: TextStyle(fontFamily: 'monospace', fontSize: 12.5)),
          ),
      ],
    ),
  );
}

Widget _teachingNotes({required ColorScheme scheme, required String title, required List<String> bullets}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: scheme.surfaceContainerHighest.withAlpha(130),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: scheme.outlineVariant.withAlpha(130)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        SizedBox(height: 8),
        for (final bullet in bullets) _bulletLine(bullet),
      ],
    ),
  );
}

Widget _bulletLine(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 7, right: 8),
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: Color(0xFF0F766E), shape: BoxShape.circle),
          ),
        ),
        Expanded(child: Text(text)),
      ],
    ),
  );
}

Widget _toolbarActionButton({
  required String label,
  required bool compactDensity,
  required bool enableIconChildren,
  required bool disabled,
  required double horizontalPadding,
  required double verticalPadding,
  required double textSize,
  required AlignmentGeometry alignment,
  required VoidCallback onTap,
}) {
  return TextSelectionToolbarTextButton(
    padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: compactDensity ? verticalPadding - 1 : verticalPadding),
    onPressed: disabled ? null : onTap,
    alignment: alignment,
    child: enableIconChildren
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(_iconForAction(label), size: compactDensity ? 14 : 16),
              SizedBox(width: 4),
              Text(label, style: TextStyle(fontSize: textSize)),
            ],
          )
        : Text(label, style: TextStyle(fontSize: textSize)),
  );
}

List<String> _actionsForDisplay(List<String> actions, bool longLabels) {
  if (!longLabels) {
    return actions;
  }
  return [for (final action in actions) '$action selection'];
}

IconData _iconForAction(String action) {
  final lower = action.toLowerCase();
  if (lower.contains('cut')) return Icons.content_cut;
  if (lower.contains('copy')) return Icons.copy_all;
  if (lower.contains('paste')) return Icons.content_paste;
  if (lower.contains('select')) return Icons.select_all;
  if (lower.contains('rewrite')) return Icons.auto_fix_high;
  if (lower.contains('translate')) return Icons.translate;
  if (lower.contains('define')) return Icons.menu_book;
  if (lower.contains('explain')) return Icons.tips_and_updates;
  if (lower.contains('comment')) return Icons.comment_outlined;
  if (lower.contains('highlight')) return Icons.highlight;
  if (lower.contains('resolve')) return Icons.task_alt;
  if (lower.contains('assign')) return Icons.assignment_ind_outlined;
  if (lower.contains('share')) return Icons.share_outlined;
  if (lower.contains('format')) return Icons.format_align_left;
  if (lower.contains('refactor')) return Icons.build_outlined;
  if (lower.contains('symbol')) return Icons.tag;
  if (lower.contains('pin')) return Icons.push_pin_outlined;
  if (lower.contains('run')) return Icons.play_arrow_outlined;
  if (lower.contains('listen')) return Icons.hearing;
  if (lower.contains('quiz')) return Icons.quiz_outlined;
  if (lower.contains('flashcard')) return Icons.style_outlined;
  if (lower.contains('example')) return Icons.lightbulb_outline;
  return Icons.chevron_right;
}

ColorScheme _deriveScheme(Color seed, bool highContrast) {
  final base = ColorScheme.fromSeed(seedColor: seed);
  if (!highContrast) {
    return base;
  }
  return base.copyWith(
    primary: _shiftContrast(base.primary, 0.24),
    onPrimary: _shiftContrast(base.onPrimary, 0.24),
    secondary: _shiftContrast(base.secondary, 0.2),
    onSecondary: _shiftContrast(base.onSecondary, 0.22),
    tertiary: _shiftContrast(base.tertiary, 0.2),
    onTertiary: _shiftContrast(base.onTertiary, 0.22),
    surface: _shiftContrast(base.surface, 0.07),
    onSurface: _shiftContrast(base.onSurface, 0.2),
    outline: _shiftContrast(base.outline, 0.2),
    outlineVariant: _shiftContrast(base.outlineVariant, 0.15),
  );
}

Color _shiftContrast(Color color, double amount) {
  final hsl = HSLColor.fromColor(color);
  final saturation = (hsl.saturation + amount * 0.56).clamp(0.0, 1.0);
  final lightness = hsl.lightness < 0.5
      ? (hsl.lightness - amount * 0.34).clamp(0.0, 1.0)
      : (hsl.lightness + amount * 0.2).clamp(0.0, 1.0);
  return hsl.withSaturation(saturation).withLightness(lightness).toColor();
}

class _GridOverlayPainter extends CustomPainter {
  _GridOverlayPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    const step = 28.0;
    for (var x = 0.0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (var y = 0.0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridOverlayPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _ButtonGlyphPainter extends CustomPainter {
  _ButtonGlyphPainter({required this.accent, required this.seed});

  final Color accent;
  final double seed;

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = Colors.white.withAlpha(160);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(10)),
      bg,
    );

    final rnd = math.Random(seed.toInt() + 43);
    final paint = Paint()..style = PaintingStyle.fill;
    for (var i = 0; i < 5; i++) {
      final width = size.width * (0.35 + rnd.nextDouble() * 0.5);
      final top = 8 + i * 9.3;
      paint.color = Color.lerp(accent, Colors.white, i / 6)?.withAlpha(228) ?? accent;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(8, top, width, 5.5),
          Radius.circular(4),
        ),
        paint,
      );
    }

    final outline = Paint()
      ..color = accent.withAlpha(160)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(6, 6, size.width - 12, size.height - 12), Radius.circular(8)),
      outline,
    );
  }

  @override
  bool shouldRepaint(covariant _ButtonGlyphPainter oldDelegate) {
    return oldDelegate.accent != accent || oldDelegate.seed != seed;
  }
}

class _ButtonFamily {
  const _ButtonFamily({
    required this.id,
    required this.title,
    required this.description,
    required this.actions,
    required this.accent,
  });

  final String id;
  final String title;
  final String description;
  final List<String> actions;
  final Color accent;
}

class _LayoutPreset {
  const _LayoutPreset({
    required this.id,
    required this.title,
    required this.horizontal,
    required this.vertical,
    required this.alignment,
  });

  final String id;
  final String title;
  final double horizontal;
  final double vertical;
  final AlignmentGeometry alignment;
}

class _SnippetCase {
  const _SnippetCase({required this.id, required this.title, required this.text});

  final String id;
  final String title;
  final String text;
}

class _QuestionAnswer {
  const _QuestionAnswer({required this.question, required this.answer});

  final String question;
  final String answer;
}
