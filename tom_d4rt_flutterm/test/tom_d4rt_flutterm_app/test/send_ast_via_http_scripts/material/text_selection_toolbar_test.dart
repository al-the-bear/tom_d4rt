import 'dart:math' as math;

import 'package:flutter/material.dart';

const List<String> _guideSteps = [
  'TextSelectionToolbar is the visual shell that renders selection actions near text anchors.',
  'anchorAbove is preferred when there is room; anchorBelow acts as fallback near top edges.',
  'Keep actions concise and meaningful, then split secondary actions into alternate menus if needed.',
  'Validate toolbar placement on large and small surfaces because anchor math can behave differently.',
  'Use TextSelectionToolbarTextButton for action consistency and touch-target correctness.',
  'When styling custom context menus, preserve readability and clear pressed-state affordances.',
  'Diagnostic overlays are useful while tuning anchors and avoiding clipped or cramped toolbars.',
  'Context tools should explain intent: copy, cut, paste, define, translate, share, etc.',
];

const List<_ScenarioCard> _scenarioCards = [
  _ScenarioCard(
    id: 'anchor-studio',
    title: 'Anchor Studio',
    subtitle: 'Visualize anchorAbove / anchorBelow behavior in layered text scenes.',
    accent: Color(0xFF0E7490),
  ),
  _ScenarioCard(
    id: 'overflow-matrix',
    title: 'Overflow Matrix',
    subtitle: 'Stress action count, button width, and toolbar crowding patterns.',
    accent: Color(0xFF0369A1),
  ),
  _ScenarioCard(
    id: 'snippet-workbench',
    title: 'Snippet Workbench',
    subtitle: 'Attach context toolbars to realistic excerpt cards with editing actions.',
    accent: Color(0xFF2563EB),
  ),
  _ScenarioCard(
    id: 'accessibility-lab',
    title: 'Accessibility Lab',
    subtitle: 'Inspect high-contrast, large text, and compact-density tradeoffs.',
    accent: Color(0xFF7C3AED),
  ),
];

const List<_AnchorPreset> _anchorPresets = [
  _AnchorPreset(
    id: 'upper-left',
    title: 'Upper Left Excerpt',
    anchorAbove: Offset(140, 90),
    anchorBelow: Offset(140, 126),
    selectionRect: Rect.fromLTWH(76, 128, 180, 22),
  ),
  _AnchorPreset(
    id: 'center-band',
    title: 'Center Band',
    anchorAbove: Offset(280, 170),
    anchorBelow: Offset(280, 208),
    selectionRect: Rect.fromLTWH(176, 214, 220, 24),
  ),
  _AnchorPreset(
    id: 'lower-right',
    title: 'Lower Right Snippet',
    anchorAbove: Offset(392, 268),
    anchorBelow: Offset(392, 304),
    selectionRect: Rect.fromLTWH(300, 314, 162, 22),
  ),
  _AnchorPreset(
    id: 'tight-top',
    title: 'Near Top Edge',
    anchorAbove: Offset(240, 42),
    anchorBelow: Offset(240, 78),
    selectionRect: Rect.fromLTWH(142, 82, 200, 22),
  ),
  _AnchorPreset(
    id: 'tight-bottom',
    title: 'Near Bottom Edge',
    anchorAbove: Offset(242, 314),
    anchorBelow: Offset(242, 348),
    selectionRect: Rect.fromLTWH(150, 352, 192, 22),
  ),
];

const List<_ToolbarRecipe> _toolbarRecipes = [
  _ToolbarRecipe(
    id: 'core-editing',
    title: 'Core Editing',
    summary: 'Classic editing menu with everyday actions.',
    actions: ['Cut', 'Copy', 'Paste', 'Select all'],
  ),
  _ToolbarRecipe(
    id: 'research-flow',
    title: 'Research Flow',
    summary: 'Editorial and research actions for long-form reading.',
    actions: ['Copy', 'Define', 'Translate', 'Search Web', 'Add Note'],
  ),
  _ToolbarRecipe(
    id: 'review-kit',
    title: 'Review Kit',
    summary: 'Review-oriented actions for collaborative workflows.',
    actions: ['Comment', 'Highlight', 'Resolve', 'Assign', 'Share'],
  ),
  _ToolbarRecipe(
    id: 'developer-tools',
    title: 'Developer Tools',
    summary: 'Code-centric actions for snippets and docs.',
    actions: ['Copy', 'Format', 'Explain', 'Refactor', 'Open Symbol', 'Pin'],
  ),
  _ToolbarRecipe(
    id: 'language-coach',
    title: 'Language Coach',
    summary: 'Learning and editing actions for language practice.',
    actions: ['Listen', 'Spellcheck', 'Simplify', 'Translate', 'Flashcard'],
  ),
];

const List<_SnippetRecord> _snippets = [
  _SnippetRecord(
    id: 'doc-1',
    title: 'Design Review Excerpt',
    body:
        'The toolbar should stay contextual and lightweight, so users can act quickly without losing reading flow.',
  ),
  _SnippetRecord(
    id: 'doc-2',
    title: 'Engineering Note',
    body:
        'Anchor fallback must handle edge cases near viewport boundaries where above placement cannot fit.',
  ),
  _SnippetRecord(
    id: 'doc-3',
    title: 'Product Copy Draft',
    body:
        'Contextual actions can educate users when labels are meaningful and tied to their current intention.',
  ),
  _SnippetRecord(
    id: 'doc-4',
    title: 'Support Transcript',
    body:
        'Adding diagnostics while tuning a selection toolbar often reveals clipping and spacing issues early.',
  ),
];

const List<_FaqItem> _faq = [
  _FaqItem(
    question: 'What does TextSelectionToolbar primarily solve?',
    answer:
        'It renders a context-action surface near selected content so users can complete text actions without leaving focus.',
  ),
  _FaqItem(
    question: 'Why provide both anchorAbove and anchorBelow?',
    answer:
        'Toolbar placement should adapt to available space. A fallback anchor keeps the menu visible near screen edges.',
  ),
  _FaqItem(
    question: 'How many actions should one toolbar carry?',
    answer:
        'Prefer concise top actions. If menus grow too wide, split secondary actions into additional UI or adaptive pathways.',
  ),
  _FaqItem(
    question: 'How does this relate to contextMenuBuilder usage?',
    answer:
        'TextSelectionToolbar is the presentational widget often used by custom context menu builders for text widgets.',
  ),
];

dynamic build(BuildContext context) {
  var scenarioIndex = 0;
  var recipeIndex = 0;
  var anchorIndex = 1;
  var gridEnabled = true;
  var showHandles = true;
  var compactMode = false;
  var highContrast = false;
  var showDiagnostics = true;
  var longLabels = false;
  var toolbarScale = 1.0;
  var panelZoom = 1.0;
  var actionPadding = 10.0;
  var interactionCount = 0;
  var timelineTick = 0;
  var selectedSnippet = 0;
  final eventLog = <String>[];

  void addEvent(String message) {
    final now = DateTime.now();
    final line =
        '[${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}] $message';
    eventLog.insert(0, line);
    if (eventLog.length > 20) {
      eventLog.removeRange(20, eventLog.length);
    }
  }

  debugPrint('TextSelectionToolbar deep demo initialized');

  return StatefulBuilder(
    builder: (context, setState) {
      final scenario = _scenarioCards[scenarioIndex];
      final recipe = _toolbarRecipes[recipeIndex];
      final anchor = _anchorPresets[anchorIndex];
      final scheme = _buildScheme(scenario.accent, highContrast);
      final scale = compactMode ? 0.92 : toolbarScale;

      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: scheme,
          scaffoldBackgroundColor: scheme.surface,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: scheme.onSurface,
                displayColor: scheme.onSurface,
              ),
        ),
        child: Container(
          color: scheme.surface,
          child: Column(
            children: [
              _buildHeader(
                scenario: scenario,
                recipe: recipe,
                interactionCount: interactionCount,
                timelineTick: timelineTick,
                scheme: scheme,
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildControlPanel(
                      scheme: scheme,
                      scenarioIndex: scenarioIndex,
                      recipeIndex: recipeIndex,
                      anchorIndex: anchorIndex,
                      selectedSnippet: selectedSnippet,
                      gridEnabled: gridEnabled,
                      showHandles: showHandles,
                      compactMode: compactMode,
                      highContrast: highContrast,
                      showDiagnostics: showDiagnostics,
                      longLabels: longLabels,
                      toolbarScale: toolbarScale,
                      panelZoom: panelZoom,
                      actionPadding: actionPadding,
                      onScenarioChanged: (value) {
                        setState(() {
                          scenarioIndex = value;
                          timelineTick += 1;
                          addEvent('Scenario changed to ${_scenarioCards[value].title}.');
                        });
                      },
                      onRecipeChanged: (value) {
                        setState(() {
                          recipeIndex = value;
                          timelineTick += 1;
                          addEvent('Toolbar recipe changed to ${_toolbarRecipes[value].title}.');
                        });
                      },
                      onAnchorChanged: (value) {
                        setState(() {
                          anchorIndex = value;
                          timelineTick += 1;
                          addEvent('Anchor preset changed to ${_anchorPresets[value].title}.');
                        });
                      },
                      onSnippetChanged: (value) {
                        setState(() {
                          selectedSnippet = value;
                          timelineTick += 1;
                          addEvent('Snippet focus changed to ${_snippets[value].title}.');
                        });
                      },
                      onGridChanged: (value) {
                        setState(() {
                          gridEnabled = value;
                          timelineTick += 1;
                          addEvent('Grid ${value ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onHandlesChanged: (value) {
                        setState(() {
                          showHandles = value;
                          timelineTick += 1;
                          addEvent('Selection handles ${value ? 'shown' : 'hidden'}.');
                        });
                      },
                      onCompactChanged: (value) {
                        setState(() {
                          compactMode = value;
                          timelineTick += 1;
                          addEvent('Compact mode ${value ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onContrastChanged: (value) {
                        setState(() {
                          highContrast = value;
                          timelineTick += 1;
                          addEvent('High contrast ${value ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onDiagnosticsChanged: (value) {
                        setState(() {
                          showDiagnostics = value;
                          timelineTick += 1;
                          addEvent('Diagnostics ${value ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onLongLabelsChanged: (value) {
                        setState(() {
                          longLabels = value;
                          timelineTick += 1;
                          addEvent('Long labels ${value ? 'enabled' : 'disabled'}.');
                        });
                      },
                      onToolbarScaleChanged: (value) {
                        setState(() {
                          toolbarScale = value;
                          timelineTick += 1;
                        });
                      },
                      onPanelZoomChanged: (value) {
                        setState(() {
                          panelZoom = value;
                          timelineTick += 1;
                        });
                      },
                      onActionPaddingChanged: (value) {
                        setState(() {
                          actionPadding = value;
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
                              scheme.surfaceContainerHighest.withAlpha(170),
                              scheme.surface,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: scheme.outlineVariant.withAlpha(128)),
                        ),
                        child: AnimatedScale(
                          duration: Duration(milliseconds: 220),
                          scale: panelZoom,
                          alignment: Alignment.topCenter,
                          child: _buildScenarioSurface(
                            scenarioIndex: scenarioIndex,
                            scheme: scheme,
                            recipe: recipe,
                            anchor: anchor,
                            selectedSnippet: selectedSnippet,
                            gridEnabled: gridEnabled,
                            showHandles: showHandles,
                            compactMode: compactMode,
                            longLabels: longLabels,
                            showDiagnostics: showDiagnostics,
                            toolbarScale: scale,
                            actionPadding: actionPadding,
                            onActionTriggered: (action, location) {
                              setState(() {
                                interactionCount += 1;
                                timelineTick += 1;
                                addEvent('$location action: $action');
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

Widget _buildHeader({
  required _ScenarioCard scenario,
  required _ToolbarRecipe recipe,
  required int interactionCount,
  required int timelineTick,
  required ColorScheme scheme,
}) {
  return Container(
    margin: EdgeInsets.fromLTRB(12, 12, 12, 10),
    padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          scenario.accent.withAlpha(52),
          scheme.primary.withAlpha(40),
          scheme.secondary.withAlpha(32),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: scenario.accent.withAlpha(130)),
      boxShadow: [
        BoxShadow(
          color: scenario.accent.withAlpha(28),
          blurRadius: 18,
          offset: Offset(0, 7),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(166),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: scenario.accent.withAlpha(170)),
          ),
          child: CustomPaint(
            painter: _AnchorGlyphPainter(
              accent: scenario.accent,
              tick: timelineTick.toDouble(),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TextSelectionToolbar Studio',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 4),
              Text(
                '${scenario.title}  |  ${recipe.title}  |  interactions: $interactionCount',
                style: TextStyle(fontWeight: FontWeight.w600, color: scheme.onSurface.withAlpha(180)),
              ),
              SizedBox(height: 5),
              Text(
                scenario.subtitle,
                style: TextStyle(color: scheme.onSurface.withAlpha(170)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildControlPanel({
  required ColorScheme scheme,
  required int scenarioIndex,
  required int recipeIndex,
  required int anchorIndex,
  required int selectedSnippet,
  required bool gridEnabled,
  required bool showHandles,
  required bool compactMode,
  required bool highContrast,
  required bool showDiagnostics,
  required bool longLabels,
  required double toolbarScale,
  required double panelZoom,
  required double actionPadding,
  required ValueChanged<int> onScenarioChanged,
  required ValueChanged<int> onRecipeChanged,
  required ValueChanged<int> onAnchorChanged,
  required ValueChanged<int> onSnippetChanged,
  required ValueChanged<bool> onGridChanged,
  required ValueChanged<bool> onHandlesChanged,
  required ValueChanged<bool> onCompactChanged,
  required ValueChanged<bool> onContrastChanged,
  required ValueChanged<bool> onDiagnosticsChanged,
  required ValueChanged<bool> onLongLabelsChanged,
  required ValueChanged<double> onToolbarScaleChanged,
  required ValueChanged<double> onPanelZoomChanged,
  required ValueChanged<double> onActionPaddingChanged,
}) {
  return Container(
    width: 368,
    margin: EdgeInsets.fromLTRB(12, 10, 0, 12),
    padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFF0F9FF),
          Color(0xFFF5F3FF),
          Color(0xFFEFF6FF),
          Color(0xFFF8FAFC),
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
          Text('Control Console', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          SizedBox(height: 4),
          Text(
            'Tune anchors, action sets, density, and diagnostics for toolbar behavior.',
            style: TextStyle(color: scheme.onSurface.withAlpha(172)),
          ),
          SizedBox(height: 10),
          _dropdownBlock<int>(
            title: 'Scenario Board',
            value: scenarioIndex,
            items: [
              for (var i = 0; i < _scenarioCards.length; i++)
                DropdownMenuItem<int>(value: i, child: Text(_scenarioCards[i].title)),
            ],
            onChanged: onScenarioChanged,
          ),
          _dropdownBlock<int>(
            title: 'Toolbar Recipe',
            value: recipeIndex,
            items: [
              for (var i = 0; i < _toolbarRecipes.length; i++)
                DropdownMenuItem<int>(value: i, child: Text(_toolbarRecipes[i].title)),
            ],
            onChanged: onRecipeChanged,
          ),
          _dropdownBlock<int>(
            title: 'Anchor Preset',
            value: anchorIndex,
            items: [
              for (var i = 0; i < _anchorPresets.length; i++)
                DropdownMenuItem<int>(value: i, child: Text(_anchorPresets[i].title)),
            ],
            onChanged: onAnchorChanged,
          ),
          _dropdownBlock<int>(
            title: 'Snippet Focus',
            value: selectedSnippet,
            items: [
              for (var i = 0; i < _snippets.length; i++)
                DropdownMenuItem<int>(value: i, child: Text(_snippets[i].title)),
            ],
            onChanged: onSnippetChanged,
          ),
          SizedBox(height: 8),
          _switchBlock(
            title: 'Grid overlay',
            subtitle: 'Display placement grid in anchor scenes',
            value: gridEnabled,
            onChanged: onGridChanged,
          ),
          _switchBlock(
            title: 'Show handles',
            subtitle: 'Render synthetic selection handles',
            value: showHandles,
            onChanged: onHandlesChanged,
          ),
          _switchBlock(
            title: 'Compact mode',
            subtitle: 'Reduce toolbar footprint for dense layouts',
            value: compactMode,
            onChanged: onCompactChanged,
          ),
          _switchBlock(
            title: 'High contrast',
            subtitle: 'Increase contrast for visibility checks',
            value: highContrast,
            onChanged: onContrastChanged,
          ),
          _switchBlock(
            title: 'Show diagnostics',
            subtitle: 'Reveal anchor distance and overflow risk details',
            value: showDiagnostics,
            onChanged: onDiagnosticsChanged,
          ),
          _switchBlock(
            title: 'Long labels',
            subtitle: 'Stress toolbar width and action readability',
            value: longLabels,
            onChanged: onLongLabelsChanged,
          ),
          SizedBox(height: 8),
          _sliderBlock(
            label: 'Toolbar scale',
            value: toolbarScale,
            min: 0.8,
            max: 1.35,
            onChanged: onToolbarScaleChanged,
          ),
          _sliderBlock(
            label: 'Panel zoom',
            value: panelZoom,
            min: 0.9,
            max: 1.15,
            onChanged: onPanelZoomChanged,
          ),
          _sliderBlock(
            label: 'Action button padding',
            value: actionPadding,
            min: 6,
            max: 18,
            onChanged: onActionPaddingChanged,
          ),
        ],
      ),
    ),
  );
}

Widget _dropdownBlock<T>({
  required String title,
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
        Text(title, style: TextStyle(fontWeight: FontWeight.w700)),
        SizedBox(height: 6),
        DropdownButtonFormField<T>(
          initialValue: value,
          isExpanded: true,
          decoration: InputDecoration(isDense: true, border: OutlineInputBorder()),
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

Widget _switchBlock({
  required String title,
  required String subtitle,
  required bool value,
  required ValueChanged<bool> onChanged,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
    decoration: BoxDecoration(
      color: Colors.white.withAlpha(160),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.black.withAlpha(20)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(title, style: TextStyle(fontWeight: FontWeight.w700)),
            ),
            Switch(value: value, onChanged: onChanged),
          ],
        ),
        Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.black.withAlpha(168))),
      ],
    ),
  );
}

Widget _sliderBlock({
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

Widget _buildScenarioSurface({
  required int scenarioIndex,
  required ColorScheme scheme,
  required _ToolbarRecipe recipe,
  required _AnchorPreset anchor,
  required int selectedSnippet,
  required bool gridEnabled,
  required bool showHandles,
  required bool compactMode,
  required bool longLabels,
  required bool showDiagnostics,
  required double toolbarScale,
  required double actionPadding,
  required void Function(String action, String location) onActionTriggered,
  required List<String> eventLog,
  required int interactionCount,
  required int timelineTick,
}) {
  switch (scenarioIndex) {
    case 0:
      return _buildAnchorStudio(
        scheme: scheme,
        recipe: recipe,
        anchor: anchor,
        gridEnabled: gridEnabled,
        showHandles: showHandles,
        compactMode: compactMode,
        longLabels: longLabels,
        showDiagnostics: showDiagnostics,
        toolbarScale: toolbarScale,
        actionPadding: actionPadding,
        onActionTriggered: onActionTriggered,
      );
    case 1:
      return _buildOverflowMatrix(
        scheme: scheme,
        recipe: recipe,
        compactMode: compactMode,
        longLabels: longLabels,
        toolbarScale: toolbarScale,
        actionPadding: actionPadding,
        onActionTriggered: onActionTriggered,
      );
    case 2:
      return _buildSnippetWorkbench(
        scheme: scheme,
        recipe: recipe,
        selectedSnippet: selectedSnippet,
        compactMode: compactMode,
        longLabels: longLabels,
        toolbarScale: toolbarScale,
        actionPadding: actionPadding,
        onActionTriggered: onActionTriggered,
      );
    default:
      return _buildAccessibilityLab(
        scheme: scheme,
        recipe: recipe,
        compactMode: compactMode,
        longLabels: longLabels,
        showDiagnostics: showDiagnostics,
        toolbarScale: toolbarScale,
        actionPadding: actionPadding,
        eventLog: eventLog,
        interactionCount: interactionCount,
        timelineTick: timelineTick,
        onActionTriggered: onActionTriggered,
      );
  }
}

Widget _buildAnchorStudio({
  required ColorScheme scheme,
  required _ToolbarRecipe recipe,
  required _AnchorPreset anchor,
  required bool gridEnabled,
  required bool showHandles,
  required bool compactMode,
  required bool longLabels,
  required bool showDiagnostics,
  required double toolbarScale,
  required double actionPadding,
  required void Function(String action, String location) onActionTriggered,
}) {
  final actions = _actionsForRecipe(recipe, longLabels);
  final sceneSize = Size(560, 430);

  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _surfaceHeader(
          title: 'Anchor Studio',
          subtitle: 'Placement playground with visual anchors and synthetic selection zone.',
          scheme: scheme,
          chip: anchor.title,
        ),
        SizedBox(height: 12),
        Center(
          child: Container(
            width: sceneSize.width,
            height: sceneSize.height,
            decoration: BoxDecoration(
              color: scheme.surface.withAlpha(192),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: scheme.outlineVariant.withAlpha(130)),
            ),
            child: Stack(
              children: [
                if (gridEnabled)
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _GridPainter(color: scheme.outlineVariant.withAlpha(100)),
                    ),
                  ),
                Positioned(
                  left: 28,
                  top: 24,
                  child: SizedBox(
                    width: 500,
                    child: Text(
                      'This scene demonstrates how toolbar anchors relate to selected text. '
                      'The blue point is anchorAbove, the purple point is anchorBelow.',
                      style: TextStyle(color: scheme.onSurface.withAlpha(176)),
                    ),
                  ),
                ),
                Positioned.fromRect(
                  rect: anchor.selectionRect,
                  child: Container(
                    decoration: BoxDecoration(
                      color: scheme.primary.withAlpha(34),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: scheme.primary.withAlpha(150)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Selected excerpt',
                      style: TextStyle(fontWeight: FontWeight.w700, color: scheme.primary),
                    ),
                  ),
                ),
                if (showHandles)
                  ..._selectionHandles(anchor.selectionRect, scheme.primary),
                Positioned(
                  left: anchor.anchorAbove.dx - 6,
                  top: anchor.anchorAbove.dy - 6,
                  child: _anchorDot(Colors.blue.shade700),
                ),
                Positioned(
                  left: anchor.anchorBelow.dx - 6,
                  top: anchor.anchorBelow.dy - 6,
                  child: _anchorDot(Colors.purple.shade700),
                ),
                Positioned(
                  left: 28,
                  top: 296,
                  child: Transform.scale(
                    scale: toolbarScale,
                    alignment: Alignment.topLeft,
                    child: TextSelectionToolbar(
                      anchorAbove: anchor.anchorAbove,
                      anchorBelow: anchor.anchorBelow,
                      children: [
                        for (var i = 0; i < actions.length; i++)
                          _toolbarButton(
                            label: actions[i],
                            compact: compactMode,
                            padding: actionPadding,
                            onPressed: () => onActionTriggered(actions[i], 'Anchor Studio'),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showDiagnostics) ...[
          SizedBox(height: 12),
          _anchorDiagnosticsCard(scheme: scheme, anchor: anchor, actions: actions, toolbarScale: toolbarScale),
        ],
        SizedBox(height: 12),
        _teachingCard(
          scheme: scheme,
          title: 'What this scene explains',
          bullets: [
            'anchorAbove and anchorBelow are explicit placement hints; TextSelectionToolbar adapts based on available room.',
            'Selection rectangles and handles help validate whether toolbar placement feels contextually attached.',
            'Large action sets can make toolbar width exceed safe space; combine this with overflow testing.',
          ],
        ),
      ],
    ),
  );
}

List<Widget> _selectionHandles(Rect selection, Color color) {
  return [
    Positioned(
      left: selection.left - 4,
      top: selection.top - 8,
      child: _handle(color),
    ),
    Positioned(
      left: selection.right - 4,
      top: selection.bottom - 2,
      child: _handle(color),
    ),
  ];
}

Widget _handle(Color color) {
  return Column(
    children: [
      Container(width: 2, height: 11, color: color),
      Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    ],
  );
}

Widget _anchorDot(Color color) {
  return Container(
    width: 12,
    height: 12,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white, width: 1.2),
    ),
  );
}

Widget _anchorDiagnosticsCard({
  required ColorScheme scheme,
  required _AnchorPreset anchor,
  required List<String> actions,
  required double toolbarScale,
}) {
  final aboveToBelow = (anchor.anchorBelow - anchor.anchorAbove).distance;
  final likelyWidth = (actions.length * 92 * toolbarScale).toStringAsFixed(0);
  final risk = actions.length >= 6 ? 'High' : actions.length >= 5 ? 'Medium' : 'Low';

  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: scheme.primaryContainer.withAlpha(92),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: scheme.primary.withAlpha(130)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Anchor diagnostics', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        SizedBox(height: 8),
        Text('anchorAbove: (${anchor.anchorAbove.dx.toStringAsFixed(1)}, ${anchor.anchorAbove.dy.toStringAsFixed(1)})'),
        Text('anchorBelow: (${anchor.anchorBelow.dx.toStringAsFixed(1)}, ${anchor.anchorBelow.dy.toStringAsFixed(1)})'),
        Text('Vertical separation: ${aboveToBelow.toStringAsFixed(1)} px'),
        Text('Estimated toolbar width: ~$likelyWidth px  |  Overflow risk: $risk'),
      ],
    ),
  );
}

Widget _buildOverflowMatrix({
  required ColorScheme scheme,
  required _ToolbarRecipe recipe,
  required bool compactMode,
  required bool longLabels,
  required double toolbarScale,
  required double actionPadding,
  required void Function(String action, String location) onActionTriggered,
}) {
  final baseActions = _actionsForRecipe(recipe, longLabels);
  final matrixRows = [
    ('4 actions', baseActions.take(4).toList()),
    ('5 actions', baseActions.take(math.min(baseActions.length, 5)).toList()),
    ('6 actions', baseActions.take(math.min(baseActions.length, 6)).toList()),
    ('all actions', baseActions),
  ];

  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _surfaceHeader(
          title: 'Overflow Matrix',
          subtitle: 'Compare how action count changes toolbar footprint and readability.',
          scheme: scheme,
          chip: recipe.title,
        ),
        SizedBox(height: 10),
        for (final row in matrixRows)
          Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: scheme.surface.withAlpha(190),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: scheme.outlineVariant.withAlpha(128)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(row.$1, style: TextStyle(fontWeight: FontWeight.w700)),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Transform.scale(
                    scale: toolbarScale,
                    alignment: Alignment.topLeft,
                    child: TextSelectionToolbar(
                      anchorAbove: Offset(210, 28),
                      anchorBelow: Offset(210, 62),
                      children: [
                        for (var i = 0; i < row.$2.length; i++)
                          _toolbarButton(
                            label: row.$2[i],
                            compact: compactMode,
                            padding: actionPadding,
                            onPressed: () => onActionTriggered(row.$2[i], 'Overflow Matrix'),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        _teachingCard(
          scheme: scheme,
          title: 'Overflow guidance',
          bullets: [
            'Use concise labels for primary actions to keep toolbars comfortably scannable.',
            'If width pressure increases, split lower-priority actions into secondary affordances.',
            'Test both compact and regular spacing to preserve touch-target accessibility.',
          ],
        ),
      ],
    ),
  );
}

Widget _buildSnippetWorkbench({
  required ColorScheme scheme,
  required _ToolbarRecipe recipe,
  required int selectedSnippet,
  required bool compactMode,
  required bool longLabels,
  required double toolbarScale,
  required double actionPadding,
  required void Function(String action, String location) onActionTriggered,
}) {
  final actions = _actionsForRecipe(recipe, longLabels);

  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _surfaceHeader(
          title: 'Snippet Workbench',
          subtitle: 'Attach selection toolbars to realistic text excerpt cards.',
          scheme: scheme,
          chip: _snippets[selectedSnippet].title,
        ),
        SizedBox(height: 10),
        for (var i = 0; i < _snippets.length; i++)
          _snippetTile(
            scheme: scheme,
            snippet: _snippets[i],
            recipe: recipe,
            actions: actions,
            toolbarScale: toolbarScale,
            compactMode: compactMode,
            actionPadding: actionPadding,
            selected: i == selectedSnippet,
            onActionTriggered: onActionTriggered,
          ),
        SizedBox(height: 12),
        _teachingCard(
          scheme: scheme,
          title: 'Workbench notes',
          bullets: [
            'Context menus feel best when actions reflect the selected snippet domain.',
            'A research snippet can expose Define/Translate while a code snippet may expose Explain/Format.',
            'This board demonstrates per-content action curation while reusing one TextSelectionToolbar structure.',
          ],
        ),
      ],
    ),
  );
}

Widget _snippetTile({
  required ColorScheme scheme,
  required _SnippetRecord snippet,
  required _ToolbarRecipe recipe,
  required List<String> actions,
  required double toolbarScale,
  required bool compactMode,
  required double actionPadding,
  required bool selected,
  required void Function(String action, String location) onActionTriggered,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: selected ? scheme.primaryContainer.withAlpha(120) : scheme.surface.withAlpha(186),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: selected ? scheme.primary.withAlpha(170) : scheme.outlineVariant.withAlpha(120),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(snippet.title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        SizedBox(height: 6),
        Text(snippet.body),
        SizedBox(height: 10),
        Transform.scale(
          scale: toolbarScale,
          alignment: Alignment.topLeft,
          child: TextSelectionToolbar(
            anchorAbove: Offset(160, 36),
            anchorBelow: Offset(160, 70),
            children: [
              for (var i = 0; i < math.min(actions.length, 5); i++)
                _toolbarButton(
                  label: actions[i],
                  compact: compactMode,
                  padding: actionPadding,
                  onPressed: () => onActionTriggered(actions[i], '${snippet.title} / ${recipe.title}'),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildAccessibilityLab({
  required ColorScheme scheme,
  required _ToolbarRecipe recipe,
  required bool compactMode,
  required bool longLabels,
  required bool showDiagnostics,
  required double toolbarScale,
  required double actionPadding,
  required List<String> eventLog,
  required int interactionCount,
  required int timelineTick,
  required void Function(String action, String location) onActionTriggered,
}) {
  final actions = _actionsForRecipe(recipe, longLabels);
  final largeTextStyle = TextStyle(fontSize: compactMode ? 12 : 15, fontWeight: FontWeight.w600);

  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _surfaceHeader(
          title: 'Accessibility Lab',
          subtitle: 'Readability, touch targets, and diagnostics timeline in one board.',
          scheme: scheme,
          chip: showDiagnostics ? 'diagnostics on' : 'diagnostics off',
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest.withAlpha(128),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: scheme.outlineVariant.withAlpha(130)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Large-text toolbar preview', style: TextStyle(fontWeight: FontWeight.w700)),
              SizedBox(height: 8),
              Transform.scale(
                scale: toolbarScale,
                alignment: Alignment.topLeft,
                child: TextSelectionToolbar(
                  anchorAbove: Offset(180, 30),
                  anchorBelow: Offset(180, 66),
                  children: [
                    for (var i = 0; i < math.min(actions.length, 6); i++)
                      TextSelectionToolbarTextButton(
                        padding: EdgeInsets.symmetric(horizontal: actionPadding, vertical: compactMode ? 5 : 8),
                        onPressed: () => onActionTriggered(actions[i], 'Accessibility Lab'),
                        child: Text(actions[i], style: largeTextStyle),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        _teachingCard(
          scheme: scheme,
          title: 'Accessibility checklist',
          bullets: [
            'Pressed labels should remain legible under high-contrast combinations.',
            'Button padding must remain touch-friendly even when compact mode is enabled.',
            'Long labels should not collapse into unreadable truncation.',
            'A diagnostic timeline helps verify control-state transitions during review.',
          ],
        ),
        SizedBox(height: 10),
        if (showDiagnostics)
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
                Text('Timeline + FAQ', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                SizedBox(height: 8),
                Text('Interactions: $interactionCount   Timeline ticks: $timelineTick'),
                SizedBox(height: 8),
                if (eventLog.isEmpty)
                  Text('No interaction events yet. Tap toolbar actions and controls to populate history.')
                else
                  for (final event in eventLog)
                    Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Text(event, style: TextStyle(fontFamily: 'monospace', fontSize: 12.5)),
                    ),
                SizedBox(height: 10),
                for (final item in _faq)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
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
            color: scheme.primaryContainer.withAlpha(98),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: scheme.primary.withAlpha(120)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('How to apply this in contextMenuBuilder', style: TextStyle(fontWeight: FontWeight.w700)),
              SizedBox(height: 8),
              Text(
                'Use your text widget\'s context menu builder to provide TextSelectionToolbar with anchors and '
                'TextSelectionToolbarTextButton children that map to your product actions. Keep labels concise and test edge anchors.',
              ),
              SizedBox(height: 8),
              for (final step in _guideSteps) _guideLine(step),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _surfaceHeader({
  required String title,
  required String subtitle,
  required ColorScheme scheme,
  required String chip,
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

Widget _toolbarButton({
  required String label,
  required bool compact,
  required double padding,
  required VoidCallback onPressed,
}) {
  return TextSelectionToolbarTextButton(
    padding: EdgeInsets.symmetric(horizontal: padding, vertical: compact ? 5 : 8),
    onPressed: onPressed,
    child: Text(label),
  );
}

Widget _teachingCard({
  required ColorScheme scheme,
  required String title,
  required List<String> bullets,
}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: scheme.surfaceContainerHighest.withAlpha(128),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: scheme.outlineVariant.withAlpha(130)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.w700)),
        SizedBox(height: 8),
        for (final bullet in bullets) _guideLine(bullet),
      ],
    ),
  );
}

Widget _guideLine(String text) {
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
            decoration: BoxDecoration(color: Color(0xFF0E7490), shape: BoxShape.circle),
          ),
        ),
        Expanded(child: Text(text)),
      ],
    ),
  );
}

ColorScheme _buildScheme(Color seed, bool highContrast) {
  final base = ColorScheme.fromSeed(seedColor: seed);
  if (!highContrast) {
    return base;
  }
  return base.copyWith(
    primary: _adjustContrast(base.primary, 0.24),
    onPrimary: _adjustContrast(base.onPrimary, 0.26),
    secondary: _adjustContrast(base.secondary, 0.21),
    onSecondary: _adjustContrast(base.onSecondary, 0.24),
    tertiary: _adjustContrast(base.tertiary, 0.2),
    onTertiary: _adjustContrast(base.onTertiary, 0.23),
    surface: _adjustContrast(base.surface, 0.08),
    onSurface: _adjustContrast(base.onSurface, 0.2),
    outline: _adjustContrast(base.outline, 0.2),
    outlineVariant: _adjustContrast(base.outlineVariant, 0.15),
  );
}

Color _adjustContrast(Color color, double delta) {
  final hsl = HSLColor.fromColor(color);
  final saturation = (hsl.saturation + delta * 0.52).clamp(0.0, 1.0);
  final lightness = hsl.lightness < 0.5
      ? (hsl.lightness - delta * 0.34).clamp(0.0, 1.0)
      : (hsl.lightness + delta * 0.18).clamp(0.0, 1.0);
  return hsl.withSaturation(saturation).withLightness(lightness).toColor();
}

List<String> _actionsForRecipe(_ToolbarRecipe recipe, bool longLabels) {
  if (!longLabels) {
    return recipe.actions;
  }
  return [
    for (final action in recipe.actions) '$action action',
  ];
}

class _GridPainter extends CustomPainter {
  _GridPainter({required this.color});

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
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _AnchorGlyphPainter extends CustomPainter {
  _AnchorGlyphPainter({required this.accent, required this.tick});

  final Color accent;
  final double tick;

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = Colors.white.withAlpha(160);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(10)),
      bg,
    );

    final center = Offset(size.width / 2, size.height / 2);
    final arcPaint = Paint()
      ..color = accent.withAlpha(220)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: 18),
      -math.pi * 0.85 + (tick % 16) * 0.02,
      math.pi * 1.35,
      false,
      arcPaint,
    );

    final dotA = Paint()..color = Colors.blue.shade700;
    final dotB = Paint()..color = Colors.purple.shade700;
    canvas.drawCircle(Offset(center.dx - 11, center.dy - 6), 3.4, dotA);
    canvas.drawCircle(Offset(center.dx + 12, center.dy + 8), 3.4, dotB);

    final linePaint = Paint()
      ..color = accent.withAlpha(180)
      ..strokeWidth = 2;
    canvas.drawLine(Offset(10, size.height - 12), Offset(size.width - 10, 12), linePaint);
  }

  @override
  bool shouldRepaint(covariant _AnchorGlyphPainter oldDelegate) {
    return oldDelegate.accent != accent || oldDelegate.tick != tick;
  }
}

class _ScenarioCard {
  const _ScenarioCard({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  final String id;
  final String title;
  final String subtitle;
  final Color accent;
}

class _AnchorPreset {
  const _AnchorPreset({
    required this.id,
    required this.title,
    required this.anchorAbove,
    required this.anchorBelow,
    required this.selectionRect,
  });

  final String id;
  final String title;
  final Offset anchorAbove;
  final Offset anchorBelow;
  final Rect selectionRect;
}

class _ToolbarRecipe {
  const _ToolbarRecipe({
    required this.id,
    required this.title,
    required this.summary,
    required this.actions,
  });

  final String id;
  final String title;
  final String summary;
  final List<String> actions;
}

class _SnippetRecord {
  const _SnippetRecord({
    required this.id,
    required this.title,
    required this.body,
  });

  final String id;
  final String title;
  final String body;
}

class _FaqItem {
  const _FaqItem({required this.question, required this.answer});

  final String question;
  final String answer;
}
