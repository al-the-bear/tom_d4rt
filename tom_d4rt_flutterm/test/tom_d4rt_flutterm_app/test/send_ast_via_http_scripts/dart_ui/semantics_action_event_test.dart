import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class _SemanticsNodeCard {
  const _SemanticsNodeCard({
    required this.nodeId,
    required this.title,
    required this.hint,
    required this.color,
    required this.icon,
  });

  final int nodeId;
  final String title;
  final String hint;
  final Color color;
  final IconData icon;
}

class _ActionSpec {
  const _ActionSpec({
    required this.action,
    required this.label,
    required this.intent,
    required this.sampleArgs,
    required this.color,
  });

  final ui.SemanticsAction action;
  final String label;
  final String intent;
  final Map<String, Object> sampleArgs;
  final Color color;
}

class _EventTrace {
  const _EventTrace({
    required this.title,
    required this.detail,
    required this.event,
    required this.color,
  });

  final String title;
  final String detail;
  final ui.SemanticsActionEvent event;
  final Color color;
}

dynamic build(BuildContext context) {
  final DateTime sessionStart = DateTime.now();
  final List<String> diagnostics = <String>[];
  final List<_EventTrace> timeline = <_EventTrace>[];

  final List<_SemanticsNodeCard> nodes = <_SemanticsNodeCard>[
    const _SemanticsNodeCard(
      nodeId: 11,
      title: 'Primary CTA Button',
      hint: 'Activation actions like tap / longPress.',
      color: Color(0xFF0D47A1),
      icon: Icons.smart_button,
    ),
    const _SemanticsNodeCard(
      nodeId: 12,
      title: 'Scrollable Headlines',
      hint: 'Directional scroll actions.',
      color: Color(0xFF1B5E20),
      icon: Icons.view_headline,
    ),
    const _SemanticsNodeCard(
      nodeId: 13,
      title: 'Editable Search Field',
      hint: 'Text actions like setText / cursor movement.',
      color: Color(0xFF6A1B9A),
      icon: Icons.search,
    ),
    const _SemanticsNodeCard(
      nodeId: 14,
      title: 'Range Slider Control',
      hint: 'Increment/decrement semantics actions.',
      color: Color(0xFFEF6C00),
      icon: Icons.tune,
    ),
    const _SemanticsNodeCard(
      nodeId: 15,
      title: 'Dismissible Toast',
      hint: 'Dismiss and focus transfer actions.',
      color: Color(0xFFAD1457),
      icon: Icons.notifications,
    ),
    const _SemanticsNodeCard(
      nodeId: 16,
      title: 'Virtual Document Canvas',
      hint: 'Show-on-screen and movement actions.',
      color: Color(0xFF006064),
      icon: Icons.article,
    ),
  ];

  final List<_ActionSpec> actionSpecs = <_ActionSpec>[
    const _ActionSpec(
      action: ui.SemanticsAction.tap,
      label: 'Tap',
      intent: 'Activate target node (button-style interaction).',
      sampleArgs: <String, Object>{'origin': 'screen-reader'},
      color: Color(0xFF1565C0),
    ),
    const _ActionSpec(
      action: ui.SemanticsAction.longPress,
      label: 'Long Press',
      intent: 'Open alternate contextual action.',
      sampleArgs: <String, Object>{'durationMs': 620},
      color: Color(0xFF283593),
    ),
    const _ActionSpec(
      action: ui.SemanticsAction.scrollLeft,
      label: 'Scroll Left',
      intent: 'Navigate content viewport toward leading side.',
      sampleArgs: <String, Object>{'dx': -72.0, 'dy': 0.0},
      color: Color(0xFF2E7D32),
    ),
    const _ActionSpec(
      action: ui.SemanticsAction.scrollRight,
      label: 'Scroll Right',
      intent: 'Navigate content viewport toward trailing side.',
      sampleArgs: <String, Object>{'dx': 72.0, 'dy': 0.0},
      color: Color(0xFF2E7D32),
    ),
    const _ActionSpec(
      action: ui.SemanticsAction.scrollUp,
      label: 'Scroll Up',
      intent: 'Move viewport to earlier rows/items.',
      sampleArgs: <String, Object>{'dx': 0.0, 'dy': -48.0},
      color: Color(0xFF1B5E20),
    ),
    const _ActionSpec(
      action: ui.SemanticsAction.scrollDown,
      label: 'Scroll Down',
      intent: 'Move viewport to later rows/items.',
      sampleArgs: <String, Object>{'dx': 0.0, 'dy': 48.0},
      color: Color(0xFF1B5E20),
    ),
    const _ActionSpec(
      action: ui.SemanticsAction.increase,
      label: 'Increase',
      intent: 'Raise a discrete value such as slider or stepper.',
      sampleArgs: <String, Object>{'delta': 1},
      color: Color(0xFFEF6C00),
    ),
    const _ActionSpec(
      action: ui.SemanticsAction.decrease,
      label: 'Decrease',
      intent: 'Lower a discrete value such as slider or stepper.',
      sampleArgs: <String, Object>{'delta': -1},
      color: Color(0xFFE65100),
    ),
    const _ActionSpec(
      action: ui.SemanticsAction.setText,
      label: 'Set Text',
      intent: 'Replace field contents via accessibility action.',
      sampleArgs: <String, Object>{'text': 'Accessible input sample'},
      color: Color(0xFF6A1B9A),
    ),
    const _ActionSpec(
      action: ui.SemanticsAction.moveCursorForwardByCharacter,
      label: 'Cursor + Char',
      intent: 'Move cursor one character forward in editable text.',
      sampleArgs: <String, Object>{'extendSelection': false},
      color: Color(0xFF8E24AA),
    ),
    const _ActionSpec(
      action: ui.SemanticsAction.moveCursorBackwardByCharacter,
      label: 'Cursor - Char',
      intent: 'Move cursor one character backward in editable text.',
      sampleArgs: <String, Object>{'extendSelection': true},
      color: Color(0xFF8E24AA),
    ),
    const _ActionSpec(
      action: ui.SemanticsAction.focus,
      label: 'Focus',
      intent: 'Transfer accessibility focus to target node.',
      sampleArgs: <String, Object>{'reason': 'navigation'},
      color: Color(0xFF00838F),
    ),
    const _ActionSpec(
      action: ui.SemanticsAction.dismiss,
      label: 'Dismiss',
      intent: 'Close transient surfaces such as toasts/dialogs.',
      sampleArgs: <String, Object>{'source': 'assistive-tech'},
      color: Color(0xFFAD1457),
    ),
    const _ActionSpec(
      action: ui.SemanticsAction.copy,
      label: 'Copy',
      intent: 'Copy selected text into clipboard context.',
      sampleArgs: <String, Object>{'selection': 'headline'},
      color: Color(0xFF3949AB),
    ),
    const _ActionSpec(
      action: ui.SemanticsAction.paste,
      label: 'Paste',
      intent: 'Insert clipboard content into focused editable node.',
      sampleArgs: <String, Object>{'target': 'search-input'},
      color: Color(0xFF3949AB),
    ),
  ];

  int selectedNodeIndex = 0;
  int selectedActionIndex = 0;
  int viewId = 0;
  int overrideNodeId = 11;

  bool useCustomArgs = true;
  bool markAsReplay = false;
  bool includeSequence = true;
  bool showCopyWithPreview = true;

  String customKey = 'meta';
  String customValue = 'semantics-demo';

  ui.SemanticsActionEvent? latestEvent;
  ui.SemanticsActionEvent? latestCopyVariant;

  void log(String message) {
    final Duration elapsed = DateTime.now().difference(sessionStart);
    final String row =
        '[${elapsed.inSeconds.toString().padLeft(2, '0')}s] $message';
    diagnostics.insert(0, row);
    if (diagnostics.length > 26) {
      diagnostics.removeLast();
    }
  }

  Map<String, Object> buildArgs(_ActionSpec spec) {
    final Map<String, Object> args = <String, Object>{}
      ..addAll(spec.sampleArgs)
      ..addAll(<String, Object>{
        'viewId': viewId,
        'nodeId': overrideNodeId,
      });

    if (includeSequence) {
      args['sequence'] = timeline.length + 1;
      args['createdAtMs'] = DateTime.now().millisecondsSinceEpoch;
    }
    if (markAsReplay) {
      args['isReplay'] = true;
    }
    if (useCustomArgs && customKey.trim().isNotEmpty) {
      args[customKey.trim()] = customValue;
    }
    return args;
  }

  ui.SemanticsActionEvent composeEvent(_ActionSpec spec) {
    return ui.SemanticsActionEvent(
      type: spec.action,
      viewId: viewId,
      nodeId: overrideNodeId,
      arguments: useCustomArgs || includeSequence || markAsReplay
          ? buildArgs(spec)
          : null,
    );
  }

  Color actionColor(ui.SemanticsAction action) {
    for (final _ActionSpec item in actionSpecs) {
      if (item.action == action) {
        return item.color;
      }
    }
    return const Color(0xFF455A64);
  }

  IconData nodeIconForAction(ui.SemanticsAction action) {
    switch (action) {
      case ui.SemanticsAction.tap:
        return Icons.touch_app;
      case ui.SemanticsAction.longPress:
        return Icons.pan_tool;
      case ui.SemanticsAction.scrollLeft:
      case ui.SemanticsAction.scrollRight:
      case ui.SemanticsAction.scrollUp:
      case ui.SemanticsAction.scrollDown:
        return Icons.swap_vert;
      case ui.SemanticsAction.increase:
      case ui.SemanticsAction.decrease:
        return Icons.tune;
      case ui.SemanticsAction.setText:
        return Icons.keyboard;
      case ui.SemanticsAction.moveCursorForwardByCharacter:
      case ui.SemanticsAction.moveCursorBackwardByCharacter:
        return Icons.text_fields;
      case ui.SemanticsAction.focus:
        return Icons.center_focus_strong;
      case ui.SemanticsAction.dismiss:
        return Icons.cancel;
      case ui.SemanticsAction.copy:
      case ui.SemanticsAction.paste:
      case ui.SemanticsAction.cut:
        return Icons.content_copy;
      default:
        return Icons.accessibility_new;
    }
  }

  Widget sectionTitle({required String title, required String subtitle, required IconData icon}) {
    return Row(
      children: <Widget>[
        Container(
          width: 38,
          height: 38,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: <Color>[Color(0xFF0D47A1), Color(0xFF1976D2)],
            ),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  )),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.blueGrey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget miniMetric({required String label, required String value, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color.withValues(alpha: 0.88),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  return StatefulBuilder(
    builder: (BuildContext context, void Function(void Function()) setState) {
      final _SemanticsNodeCard selectedNode = nodes[selectedNodeIndex];
      final _ActionSpec selectedAction = actionSpecs[selectedActionIndex];
      final Color accent = selectedAction.color;

      return SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFF001B2E), Color(0xFF004E89)],
                ),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 14,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Semantics Action Event Theater',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'SemanticsActionEvent represents the engine-level packet fired when assistive technology '
                    'requests an action on a semantics node. This demo shows how type, viewId, nodeId, and arguments '
                    'combine to drive accessibility interactions in interpreter-executed Flutter scripts.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.92),
                      height: 1.35,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: <Widget>[
                      Chip(
                        side: BorderSide.none,
                        backgroundColor: Colors.white.withValues(alpha: 0.15),
                        avatar: const Icon(Icons.filter_center_focus,
                            color: Colors.white),
                        label: Text(
                          'Node ${selectedNode.nodeId}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Chip(
                        side: BorderSide.none,
                        backgroundColor: Colors.white.withValues(alpha: 0.15),
                        avatar: const Icon(Icons.event_note, color: Colors.white),
                        label: Text(
                          selectedAction.label,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Chip(
                        side: BorderSide.none,
                        backgroundColor: Colors.white.withValues(alpha: 0.15),
                        avatar: const Icon(Icons.timeline, color: Colors.white),
                        label: Text(
                          'Timeline ${timeline.length}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Event Composer',
              subtitle: 'Configure the packet fields and dispatch semantics action events manually.',
              icon: Icons.tune,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blueGrey.shade100),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Wrap(
                    spacing: 12,
                    runSpacing: 10,
                    children: <Widget>[
                      SizedBox(
                        width: 250,
                        child: DropdownButtonFormField<int>(
                          initialValue: selectedNodeIndex,
                          decoration: const InputDecoration(
                            labelText: 'Target Node',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          items: nodes.asMap().entries.map((MapEntry<int, _SemanticsNodeCard> entry) {
                            return DropdownMenuItem<int>(
                              value: entry.key,
                              child: Text('${entry.value.nodeId} • ${entry.value.title}'),
                            );
                          }).toList(),
                          onChanged: (int? index) {
                            if (index == null) {
                              return;
                            }
                            setState(() {
                              selectedNodeIndex = index;
                              overrideNodeId = nodes[index].nodeId;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 260,
                        child: DropdownButtonFormField<int>(
                          initialValue: selectedActionIndex,
                          decoration: const InputDecoration(
                            labelText: 'SemanticsAction',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          items: actionSpecs.asMap().entries.map((MapEntry<int, _ActionSpec> entry) {
                            return DropdownMenuItem<int>(
                              value: entry.key,
                              child: Text('${entry.value.label} (${entry.value.action.name})'),
                            );
                          }).toList(),
                          onChanged: (int? index) {
                            if (index == null) {
                              return;
                            }
                            setState(() {
                              selectedActionIndex = index;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        child: TextFormField(
                          initialValue: viewId.toString(),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'viewId',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          onChanged: (String value) {
                            setState(() {
                              viewId = int.tryParse(value) ?? viewId;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        child: TextFormField(
                          initialValue: overrideNodeId.toString(),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'nodeId',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          onChanged: (String value) {
                            setState(() {
                              overrideNodeId = int.tryParse(value) ?? overrideNodeId;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Arguments Controls',
                    style: TextStyle(
                      color: Colors.blueGrey.shade700,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: <Widget>[
                      SizedBox(
                        width: 180,
                        child: TextFormField(
                          initialValue: customKey,
                          decoration: const InputDecoration(
                            labelText: 'Custom key',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          onChanged: (String value) {
                            setState(() {
                              customKey = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 260,
                        child: TextFormField(
                          initialValue: customValue,
                          decoration: const InputDecoration(
                            labelText: 'Custom value',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          onChanged: (String value) {
                            setState(() {
                              customValue = value;
                            });
                          },
                        ),
                      ),
                      FilterChip(
                        label: const Text('Use custom args'),
                        selected: useCustomArgs,
                        onSelected: (bool v) => setState(() => useCustomArgs = v),
                      ),
                      FilterChip(
                        label: const Text('Include sequence'),
                        selected: includeSequence,
                        onSelected: (bool v) => setState(() => includeSequence = v),
                      ),
                      FilterChip(
                        label: const Text('Mark replay'),
                        selected: markAsReplay,
                        onSelected: (bool v) => setState(() => markAsReplay = v),
                      ),
                      FilterChip(
                        label: const Text('Show copyWith variant'),
                        selected: showCopyWithPreview,
                        onSelected: (bool v) =>
                            setState(() => showCopyWithPreview = v),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    selectedAction.intent,
                    style: TextStyle(
                      color: accent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: <Widget>[
                      FilledButton.icon(
                        onPressed: () {
                          setState(() {
                            final ui.SemanticsActionEvent event = composeEvent(selectedAction);
                            latestEvent = event;
                            latestCopyVariant = showCopyWithPreview
                                ? event.copyWith(
                                    nodeId: event.nodeId + 100,
                                    viewId: event.viewId,
                                    type: event.type,
                                  )
                                : null;

                            timeline.insert(
                              0,
                              _EventTrace(
                                title:
                                    '${event.type.name} on node ${event.nodeId}',
                                detail:
                                    'view ${event.viewId} • args ${event.arguments == null ? 'none' : 'provided'}',
                                event: event,
                                color: actionColor(event.type),
                              ),
                            );
                            if (timeline.length > 30) {
                              timeline.removeLast();
                            }
                          });
                          log('Dispatched ${selectedAction.action.name} for node $overrideNodeId (view $viewId).');
                        },
                        icon: const Icon(Icons.send),
                        label: const Text('Dispatch Event'),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            timeline.clear();
                            latestEvent = null;
                            latestCopyVariant = null;
                          });
                          log('Timeline and event previews cleared.');
                        },
                        icon: const Icon(Icons.cleaning_services),
                        label: const Text('Reset Timeline'),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            selectedNodeIndex = 0;
                            selectedActionIndex = 0;
                            viewId = 0;
                            overrideNodeId = nodes[0].nodeId;
                            useCustomArgs = true;
                            includeSequence = true;
                            markAsReplay = false;
                            showCopyWithPreview = true;
                            customKey = 'meta';
                            customValue = 'semantics-demo';
                          });
                          log('Composer returned to default accessibility state.');
                        },
                        icon: const Icon(Icons.restart_alt),
                        label: const Text('Reset Composer'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Semantics Node Map',
              subtitle: 'Visualize which semantic node receives the action event packet.',
              icon: Icons.account_tree,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blueGrey.shade100),
              ),
              child: SizedBox(
                height: 330,
                child: CustomPaint(
                  painter: _SemanticsMapPainter(
                    nodes: nodes,
                    selectedNodeId: overrideNodeId,
                    activeAction: selectedAction.action,
                    accent: accent,
                    timelineDepth: timeline.length,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Node Gallery',
              subtitle: 'Each card illustrates a different accessibility interaction target.',
              icon: Icons.view_module,
            ),
            const SizedBox(height: 10),
            Column(
              children: nodes.asMap().entries.map((MapEntry<int, _SemanticsNodeCard> entry) {
                final bool selected = entry.value.nodeId == overrideNodeId;
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: selected
                        ? entry.value.color.withValues(alpha: 0.14)
                        : entry.value.color.withValues(alpha: 0.06),
                    border: Border.all(
                      color: selected
                          ? entry.value.color.withValues(alpha: 0.52)
                          : entry.value.color.withValues(alpha: 0.24),
                      width: selected ? 1.4 : 1,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: entry.value.color.withValues(alpha: 0.22),
                        ),
                        child: Icon(entry.value.icon, color: entry.value.color),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Node ${entry.value.nodeId} • ${entry.value.title}',
                              style: TextStyle(
                                color: entry.value.color,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              entry.value.hint,
                              style: TextStyle(
                                color: Colors.blueGrey.shade800,
                                height: 1.3,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      FilledButton.tonalIcon(
                        onPressed: () {
                          setState(() {
                            selectedNodeIndex = entry.key;
                            overrideNodeId = entry.value.nodeId;
                          });
                          log('Selected node ${entry.value.nodeId} (${entry.value.title}).');
                        },
                        icon: const Icon(Icons.ads_click),
                        label: const Text('Target'),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Action Palette',
              subtitle: 'Use different SemanticsAction values and compare their expected intent.',
              icon: Icons.palette,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: actionSpecs.asMap().entries.map((MapEntry<int, _ActionSpec> entry) {
                final bool selected = selectedActionIndex == entry.key;
                final _ActionSpec item = entry.value;
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedActionIndex = entry.key;
                    });
                    log('Selected action ${item.action.name}.');
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 210,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: selected
                          ? item.color.withValues(alpha: 0.16)
                          : item.color.withValues(alpha: 0.07),
                      border: Border.all(
                        color: selected
                            ? item.color.withValues(alpha: 0.60)
                            : item.color.withValues(alpha: 0.30),
                        width: selected ? 1.4 : 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              nodeIconForAction(item.action),
                              color: item.color,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                item.label,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: item.color,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.action.name,
                          style: TextStyle(
                            color: Colors.blueGrey.shade700,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.intent,
                          style: TextStyle(
                            color: Colors.blueGrey.shade800,
                            fontSize: 12,
                            height: 1.25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Event Packet Inspector',
              subtitle: 'Inspect latest event fields and copyWith-derived variant.',
              icon: Icons.fact_check,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blueGrey.shade100),
              ),
              child: latestEvent == null
                  ? const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          'No event dispatched yet. Use Dispatch Event to create a SemanticsActionEvent packet.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: <Widget>[
                            SizedBox(
                              width: 210,
                              child: miniMetric(
                                label: 'type',
                                value: latestEvent!.type.name,
                                color: actionColor(latestEvent!.type),
                              ),
                            ),
                            SizedBox(
                              width: 210,
                              child: miniMetric(
                                label: 'viewId',
                                value: latestEvent!.viewId.toString(),
                                color: const Color(0xFF455A64),
                              ),
                            ),
                            SizedBox(
                              width: 210,
                              child: miniMetric(
                                label: 'nodeId',
                                value: latestEvent!.nodeId.toString(),
                                color: const Color(0xFF37474F),
                              ),
                            ),
                            SizedBox(
                              width: 210,
                              child: miniMetric(
                                label: 'arguments',
                                value: latestEvent!.arguments == null
                                    ? 'null'
                                    : 'Map payload',
                                color: const Color(0xFF00695C),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F7FA),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFE0E7EE)),
                          ),
                          child: Text(
                            latestEvent!.arguments?.toString() ?? 'No arguments',
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 12,
                              height: 1.35,
                            ),
                          ),
                        ),
                        if (latestCopyVariant != null) ...<Widget>[
                          const SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFE3F2FD),
                              border: Border.all(color: const Color(0xFF90CAF9)),
                            ),
                            child: Text(
                              'copyWith preview -> type ${latestCopyVariant!.type.name}, '
                              'view ${latestCopyVariant!.viewId}, node ${latestCopyVariant!.nodeId}',
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ],
                    ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Timeline Replay',
              subtitle: 'Chronological feed of dispatched SemanticsActionEvent packets.',
              icon: Icons.timeline,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blueGrey.shade100),
              ),
              child: timeline.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          'Timeline is empty. Dispatch events to create a sequence.',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  : Column(
                      children: timeline.asMap().entries.map((MapEntry<int, _EventTrace> entry) {
                        final int index = entry.key;
                        final _EventTrace row = entry.value;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: row.color.withValues(alpha: 0.08),
                            border: Border.all(color: row.color.withValues(alpha: 0.30)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '#${index + 1}',
                                style: TextStyle(
                                  color: row.color,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(row.title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700)),
                                    const SizedBox(height: 3),
                                    Text(
                                      row.detail,
                                      style: TextStyle(
                                        color: Colors.blueGrey.shade700,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'arguments: ${row.event.arguments ?? 'null'}',
                                      style: const TextStyle(
                                        fontFamily: 'monospace',
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Usage Guide',
              subtitle: 'Practical guidance for wiring SemanticsActionEvent into handlers.',
              icon: Icons.menu_book,
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blueGrey.shade100),
                color: Colors.white,
              ),
              child: const Column(
                children: <Widget>[
                  _GuideLine(
                    title: 'type',
                    detail:
                        'The requested semantics action. Route this through a switch statement to trigger behavior-specific handlers.',
                  ),
                  _GuideLine(
                    title: 'viewId',
                    detail:
                        'Use when multiple Flutter views are present; ensures action is dispatched to the correct semantics tree root.',
                  ),
                  _GuideLine(
                    title: 'nodeId',
                    detail:
                        'Identifies the target semantic node. This should map to the semantics node generated by your render/object tree.',
                  ),
                  _GuideLine(
                    title: 'arguments',
                    detail:
                        'Optional payload for richer actions (selection ranges, deltas, text values). Keep keys stable across handlers.',
                  ),
                  _GuideLine(
                    title: 'copyWith',
                    detail:
                        'Useful for replay or mutation of baseline events while preserving immutable event shape.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Diagnostics Console',
              subtitle: 'Action and node selection logs for quick interpreter debugging.',
              icon: Icons.terminal,
            ),
            const SizedBox(height: 10),
            Container(
              height: 180,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF0B1220),
                borderRadius: BorderRadius.circular(14),
              ),
              child: diagnostics.isEmpty
                  ? const Center(
                      child: Text(
                        'No diagnostics yet. Interact with the composer to generate log entries.',
                        style: TextStyle(
                          color: Color(0xFFB7C9EC),
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      itemCount: diagnostics.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            diagnostics[index],
                            style: const TextStyle(
                              color: Color(0xFFC8D9FF),
                              fontSize: 12,
                              fontFamily: 'monospace',
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 18),
            sectionTitle(
              title: 'Reference Handler Snippet',
              subtitle: 'A typical routing pattern for SemanticsActionEvent handling.',
              icon: Icons.code,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF0B132B),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                'void handleSemanticsEvent(ui.SemanticsActionEvent event) {\\n'
                '  if (event.viewId != activeViewId) return;\\n'
                '  switch (event.type) {\\n'
                '    case ui.SemanticsAction.tap:\\n'
                '      activateNode(event.nodeId);\\n'
                '      break;\\n'
                '    case ui.SemanticsAction.scrollDown:\\n'
                '      applyScroll(event.arguments);\\n'
                '      break;\\n'
                '    case ui.SemanticsAction.setText:\\n'
                '      updateText(event.nodeId, event.arguments);\\n'
                '      break;\\n'
                '    default:\\n'
                '      routeFallback(event);\\n'
                '  }\\n'
                '}',
                style: const TextStyle(
                  color: Color(0xFFD5E7FF),
                  fontFamily: 'monospace',
                  fontSize: 12,
                  height: 1.38,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: const LinearGradient(
                  colors: <Color>[Color(0xFFE8F5E9), Color(0xFFE3F2FD)],
                ),
                border: Border.all(color: const Color(0xFFA5D6A7)),
              ),
              child: Text(
                'Summary: This deep demo treats SemanticsActionEvent as a first-class runtime packet. '
                'You can target semantic nodes, vary action types, shape optional arguments, inspect immutable event fields, '
                'and compare copyWith variants while watching timeline and diagnostics updates. '
                'The result is an instructive visual workflow for accessibility-event integration in interpreter-driven Flutter scripts.',
                style: TextStyle(
                  color: Colors.blueGrey.shade900,
                  fontWeight: FontWeight.w600,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

class _GuideLine extends StatelessWidget {
  const _GuideLine({required this.title, required this.detail});

  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.blueGrey.shade50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.blueGrey.shade900,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            detail,
            style: TextStyle(
              color: Colors.blueGrey.shade700,
              fontWeight: FontWeight.w500,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _SemanticsMapPainter extends CustomPainter {
  _SemanticsMapPainter({
    required this.nodes,
    required this.selectedNodeId,
    required this.activeAction,
    required this.accent,
    required this.timelineDepth,
  });

  final List<_SemanticsNodeCard> nodes;
  final int selectedNodeId;
  final ui.SemanticsAction activeAction;
  final Color accent;
  final int timelineDepth;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFF7FBFF), Color(0xFFEAF2FD)],
      ).createShader(Offset.zero & size);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(12)),
      bg,
    );

    final Paint grid = Paint()
      ..color = const Color(0x22000000)
      ..strokeWidth = 1;
    for (double x = 0; x <= size.width; x += 34) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y <= size.height; y += 34) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final Offset center = Offset(size.width * 0.5, 30);
    final TextPainter rootLabel = TextPainter(
      text: const TextSpan(
        text: 'View Root',
        style: TextStyle(
          color: Color(0xFF0D47A1),
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    canvas.drawCircle(center, 12, Paint()..color = const Color(0xFF0D47A1));
    rootLabel.paint(canvas, Offset(center.dx - rootLabel.width / 2, center.dy + 14));

    final List<Offset> positions = <Offset>[];
    for (int i = 0; i < nodes.length; i++) {
      final double t = i / math.max(1, nodes.length - 1);
      final double dx = 42 + t * (size.width - 84);
      final double dy = 150 + math.sin(t * math.pi * 2) * 34;
      positions.add(Offset(dx, dy));
    }

    for (final Offset p in positions) {
      canvas.drawLine(center, p, Paint()..color = const Color(0xFF90A4AE)..strokeWidth = 1.4);
    }

    for (int i = 0; i < nodes.length; i++) {
      final _SemanticsNodeCard node = nodes[i];
      final Offset p = positions[i];
      final bool selected = node.nodeId == selectedNodeId;

      final Paint circle = Paint()
        ..color = selected
            ? node.color.withValues(alpha: 0.95)
            : node.color.withValues(alpha: 0.70);
      canvas.drawCircle(p, selected ? 20 : 16, circle);

      if (selected) {
        canvas.drawCircle(
          p,
          26,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.2
            ..color = accent.withValues(alpha: 0.70),
        );
      }

      final TextPainter idText = TextPainter(
        text: TextSpan(
          text: node.nodeId.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      idText.paint(canvas, Offset(p.dx - idText.width / 2, p.dy - idText.height / 2));
    }

    final Paint pulse = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = accent.withValues(alpha: 0.58);
    final double radius = 38 + (timelineDepth % 6) * 8;
    canvas.drawCircle(center, radius, pulse);

    final TextPainter info = TextPainter(
      text: TextSpan(
        text: 'Action ${activeAction.name} -> Node $selectedNodeId\nTimeline depth: $timelineDepth',
        style: const TextStyle(
          color: Color(0xFF102027),
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 16);
    info.paint(canvas, Offset(8, size.height - info.height - 8));
  }

  @override
  bool shouldRepaint(covariant _SemanticsMapPainter oldDelegate) {
    return oldDelegate.selectedNodeId != selectedNodeId ||
        oldDelegate.activeAction != activeAction ||
        oldDelegate.timelineDepth != timelineDepth ||
        oldDelegate.accent != accent ||
        oldDelegate.nodes.length != nodes.length;
  }
}
