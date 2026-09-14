// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

dynamic build(BuildContext context) {
  // Palette: deep teal + amber + slate, distinct from any sibling demo.
  const Color kBgDeep = Color(0xFF062A33);
  const Color kPanel = Color(0xFF0E3D49);
  const Color kPanelAlt = Color(0xFF114E5C);
  const Color kAccent = Color(0xFFFFB347);
  const Color kAccentSoft = Color(0xFFFFD089);
  const Color kInk = Color(0xFFE8F4F7);
  const Color kInkDim = Color(0xFF9FB9C0);
  const Color kBorder = Color(0xFF1F6E80);
  const Color kOk = Color(0xFF7BD389);
  const Color kWarn = Color(0xFFEF6F6C);
  const Color kInfo = Color(0xFF6FB1FC);

  // ---- Construct the focal event (try/catch per protocol) ----
  TapSemanticEvent? tapEvent;
  String tapEventErr = '';
  try {
    tapEvent = const TapSemanticEvent();
  } catch (e) {
    tapEventErr = e.toString();
  }

  // Sister events (also wrapped defensively).
  LongPressSemanticsEvent? longPressEvent;
  try {
    longPressEvent = const LongPressSemanticsEvent();
  } catch (_) {}

  AnnounceSemanticsEvent? announceEvent;
  try {
    announceEvent =
        const AnnounceSemanticsEvent('Saved', TextDirection.ltr, 0);
  } catch (_) {}

  TooltipSemanticsEvent? tooltipEvent;
  try {
    tooltipEvent = const TooltipSemanticsEvent('More options');
  } catch (_) {}

  FocusSemanticEvent? focusEvent;
  try {
    focusEvent = const FocusSemanticEvent();
  } catch (_) {}

  // Resolve the data map for display.
  Map<String, dynamic> tapMap = const {};
  String tapMapErr = '';
  try {
    if (tapEvent != null) {
      tapMap = tapEvent.getDataMap();
    }
  } catch (e) {
    tapMapErr = e.toString();
  }

  // Sister event data maps for the comparison table.
  final List<List<String>> sisterRows = <List<String>>[];
  sisterRows.add(<String>['Class', 'type', 'payload', 'typical caller']);
  sisterRows.add(<String>[
    'TapSemanticEvent',
    tapEvent?.type ?? '?',
    tapMap.isEmpty ? '{}' : tapMap.toString(),
    'Semantics(onTap: ...)',
  ]);
  sisterRows.add(<String>[
    'LongPressSemanticsEvent',
    longPressEvent?.type ?? '?',
    longPressEvent == null ? '{}' : longPressEvent.getDataMap().toString(),
    'Semantics(onLongPress: ...)',
  ]);
  sisterRows.add(<String>[
    'AnnounceSemanticsEvent',
    announceEvent?.type ?? '?',
    announceEvent == null ? '{}' : announceEvent.getDataMap().toString(),
    'SemanticsService.announce',
  ]);
  sisterRows.add(<String>[
    'TooltipSemanticsEvent',
    tooltipEvent?.type ?? '?',
    tooltipEvent == null ? '{}' : tooltipEvent.getDataMap().toString(),
    'SemanticsService.tooltip',
  ]);
  sisterRows.add(<String>[
    'FocusSemanticEvent',
    focusEvent?.type ?? '?',
    focusEvent == null ? '{}' : focusEvent.getDataMap().toString(),
    'focus restoration paths',
  ]);

  // ---- Hero header ----
  final Widget hero = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF0E3D49), Color(0xFF062A33)],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: kAccent.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: kAccent.withValues(alpha: 0.55)),
              ),
              child: const Icon(Icons.touch_app_outlined,
                  color: kAccent, size: 26),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'TapSemanticEvent',
                    style: TextStyle(
                      color: kInk,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'package:flutter/semantics.dart  ·  SemanticsEvent subclass',
                    style: TextStyle(color: kInkDim, fontSize: 12.5),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        const Text(
          'A const-constructible signal that the framework dispatches '
          'through SemanticsBinding to assistive technologies (TalkBack, '
          'VoiceOver, Switch Control) when a tap should be announced. '
          'Carries only its type tag — the receiver knows what to say.',
          style: TextStyle(color: kInk, fontSize: 13.5, height: 1.45),
        ),
      ],
    ),
  );

  // ---- Layer diagram ----
  Widget layerBox(String title, String subtitle, Color tint) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tint.withValues(alpha: 0.55)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: const TextStyle(
                  color: kInk, fontSize: 13.5, fontWeight: FontWeight.w700)),
          const SizedBox(height: 2),
          Text(subtitle, style: const TextStyle(color: kInkDim, fontSize: 11)),
        ],
      ),
    );
  }

  const Widget arrowDown = Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Icon(Icons.arrow_downward, size: 18, color: kAccentSoft),
  );

  final Widget layerDiagram = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kPanel,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Semantics layer pipeline',
            style: TextStyle(
                color: kAccent, fontSize: 15, fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        layerBox('Widgets', 'Semantics(onTap: ...) wraps content', kInfo),
        arrowDown,
        layerBox('Semantics tree', 'SemanticsNode graph mirrors widgets', kInfo),
        arrowDown,
        layerBox('SemanticsBinding', 'sendSemanticsUpdate + sendEvent', kAccent),
        arrowDown,
        layerBox('Engine channel', 'flutter/accessibility platform message',
            kAccent),
        arrowDown,
        layerBox('Assistive technology',
            'TalkBack / VoiceOver / Switch Control speaks', kOk),
      ],
    ),
  );

  // ---- Hierarchy chart ----
  Widget hLine(String label, int depth, Color tone, {bool focal = false}) {
    return Padding(
      padding: EdgeInsets.only(left: depth * 18.0, top: 4, bottom: 4),
      child: Row(
        children: <Widget>[
          Text(depth == 0 ? '' : '\u2514\u2500 ',
              style: const TextStyle(color: kInkDim, fontFamily: 'monospace')),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: tone.withValues(alpha: focal ? 0.28 : 0.12),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  color: tone.withValues(alpha: focal ? 0.9 : 0.4),
                  width: focal ? 1.4 : 1),
            ),
            child: Text(label,
                style: TextStyle(
                    color: focal ? kInk : kInkDim,
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    fontWeight:
                        focal ? FontWeight.w700 : FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  final Widget hierarchy = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kPanelAlt,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('SemanticsEvent hierarchy',
            style: TextStyle(
                color: kAccent, fontSize: 15, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        hLine('SemanticsEvent (abstract)', 0, kInfo),
        hLine('TapSemanticEvent', 1, kAccent, focal: true),
        hLine('LongPressSemanticsEvent', 1, kInfo),
        hLine('AnnounceSemanticsEvent', 1, kInfo),
        hLine('TooltipSemanticsEvent', 1, kInfo),
        hLine('FocusSemanticEvent', 1, kInfo),
      ],
    ),
  );

  // ---- Anatomy ----
  Widget anatomyRow(String k, String v, {Color? accent}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 130,
            child: Text(k,
                style: const TextStyle(
                    color: kInkDim,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600)),
          ),
          Expanded(
            child: Text(v,
                style: TextStyle(
                    color: accent ?? kInk,
                    fontFamily: 'monospace',
                    fontSize: 12.5)),
          ),
        ],
      ),
    );
  }

  final Widget anatomy = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kPanel,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Anatomy of a TapSemanticEvent',
            style: TextStyle(
                color: kAccent, fontSize: 15, fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        anatomyRow('class', 'TapSemanticEvent extends SemanticsEvent'),
        anatomyRow('constructor', 'const TapSemanticEvent();'),
        anatomyRow('type', '"${tapEvent?.type ?? '?'}"', accent: kOk),
        anatomyRow('payload', tapMap.isEmpty ? '{}' : tapMap.toString()),
        anatomyRow('getDataMap()', '{ "type": "${tapEvent?.type ?? '?'}" }'),
        anatomyRow('toMap()',
            tapEvent == null ? '?' : tapEvent.toMap().toString()),
        anatomyRow('error', tapEventErr.isEmpty ? '(none)' : tapEventErr,
            accent: tapEventErr.isEmpty ? kOk : kWarn),
        anatomyRow('mapErr', tapMapErr.isEmpty ? '(none)' : tapMapErr,
            accent: tapMapErr.isEmpty ? kOk : kWarn),
      ],
    ),
  );

  // ---- Sister comparison table ----
  final List<TableRow> sisterTable = <TableRow>[];
  for (int i = 0; i < sisterRows.length; i++) {
    final List<String> r = sisterRows[i];
    final bool header = i == 0;
    final bool focal = !header && r[0] == 'TapSemanticEvent';
    final List<Widget> cells = <Widget>[];
    for (int j = 0; j < r.length; j++) {
      cells.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
        child: Text(
          r[j],
          style: TextStyle(
            color: header ? kAccent : (focal ? kAccentSoft : kInk),
            fontFamily: 'monospace',
            fontSize: 11.5,
            fontWeight: header || focal ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ));
    }
    sisterTable.add(TableRow(
      decoration: BoxDecoration(
        color: header
            ? kAccent.withValues(alpha: 0.15)
            : (focal ? kAccent.withValues(alpha: 0.08) : Colors.transparent),
      ),
      children: cells,
    ));
  }

  final Widget sisterPanel = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kPanelAlt,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Sister events',
            style: TextStyle(
                color: kAccent, fontSize: 15, fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        Table(
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(2.0),
            1: FlexColumnWidth(0.9),
            2: FlexColumnWidth(2.4),
            3: FlexColumnWidth(2.2),
          },
          border: TableBorder.all(
              color: kBorder.withValues(alpha: 0.5), width: 0.7),
          children: sisterTable,
        ),
      ],
    ),
  );

  // ---- announce vs tap callout ----
  final Widget announceVsTap = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kPanel,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('TapSemanticEvent vs SemanticsService.announce',
            style: TextStyle(
                color: kAccent, fontSize: 15, fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        const Text(
          'TapSemanticEvent fires implicitly: a node has onTap, the engine '
          'reports the activation, the binding sends type="tap" so the '
          'screen reader can produce its own activation chirp. There is no '
          'message field. By contrast SemanticsService.announce(message, '
          'textDirection) dispatches an AnnounceSemanticsEvent which DOES '
          'carry the spoken text and reading direction.',
          style: TextStyle(color: kInk, fontSize: 12.8, height: 1.45),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kBorder),
          ),
          child: const Text(
            "// implicit\n"
            "Semantics(\n"
            "  onTap: handleTap,\n"
            "  child: ...,\n"
            ");\n\n"
            "// explicit\n"
            "SemanticsService.announce('Saved', TextDirection.ltr);\n"
            "SemanticsService.tooltip('More options');",
            style: TextStyle(
                color: kAccentSoft, fontFamily: 'monospace', fontSize: 12),
          ),
        ),
      ],
    ),
  );

  // ---- Mock screen-reader transcript ----
  Widget transcriptLine(String reader, String spoken, IconData icon, Color c) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, size: 16, color: c),
          const SizedBox(width: 8),
          SizedBox(
            width: 96,
            child: Text(reader,
                style: TextStyle(
                    color: c, fontSize: 12, fontWeight: FontWeight.w700)),
          ),
          Expanded(
            child: Text('"$spoken"',
                style: const TextStyle(
                    color: kInk,
                    fontSize: 12.5,
                    fontStyle: FontStyle.italic)),
          ),
        ],
      ),
    );
  }

  final Widget transcript = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kPanelAlt,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Reader transcript (mock)',
            style: TextStyle(
                color: kAccent, fontSize: 15, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        const Text(
          'Approximate spoken output when each event reaches the platform.',
          style: TextStyle(color: kInkDim, fontSize: 11.5),
        ),
        const SizedBox(height: 10),
        transcriptLine('TalkBack', 'Save. Button. Double-tap to activate.',
            Icons.android, kOk),
        transcriptLine('VoiceOver', 'Save, button. Activated.',
            Icons.phone_iphone, kInfo),
        transcriptLine(
            'NVDA', 'button Save pressed', Icons.desktop_windows, kAccent),
        const Divider(height: 18, color: kBorder),
        transcriptLine('TalkBack', 'Saved.', Icons.campaign, kOk),
        transcriptLine('VoiceOver', 'More options.', Icons.info_outline, kInfo),
      ],
    ),
  );

  // ---- Example Semantics tree ----
  final Widget exampleTree = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kPanel,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Example: Semantics widget tree',
            style: TextStyle(
                color: kAccent, fontSize: 15, fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kBorder),
          ),
          child: const Text(
            "Semantics(\n"
            "  label: 'Save document',\n"
            "  hint: 'Persists to disk',\n"
            "  button: true,\n"
            "  onTap: () {\n"
            "    // engine emits TapSemanticEvent\n"
            "    saveDocument();\n"
            "  },\n"
            "  child: InkWell(\n"
            "    onTap: saveDocument,\n"
            "    child: const Padding(\n"
            "      padding: EdgeInsets.all(8),\n"
            "      child: Text('Save'),\n"
            "    ),\n"
            "  ),\n"
            ");",
            style: TextStyle(
                color: kAccentSoft, fontFamily: 'monospace', fontSize: 12),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'When a screen-reader user double-taps the rendered node, the '
          'engine activates onTap and a TapSemanticEvent is queued so '
          'the platform layer can confirm the action audibly.',
          style: TextStyle(color: kInk, fontSize: 12.5, height: 1.4),
        ),
      ],
    ),
  );

  // ---- SemanticsTag panel ----
  final List<List<String>> tagRows = <List<String>>[
    <String>['name', 'common usage'],
    <String>['"RenderViewport.twoPane"', 'split-view list/detail'],
    <String>['"RenderViewport.excludeFromScrolling"', 'pinned headers'],
    <String>['custom SemanticsTag(name)', 'tag nodes for traversal hooks'],
  ];
  final List<TableRow> tagTable = <TableRow>[];
  for (int i = 0; i < tagRows.length; i++) {
    final List<String> r = tagRows[i];
    final bool header = i == 0;
    final List<Widget> cells = <Widget>[];
    for (int j = 0; j < r.length; j++) {
      cells.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Text(r[j],
            style: TextStyle(
                color: header ? kAccent : kInk,
                fontFamily: 'monospace',
                fontSize: 11.5,
                fontWeight:
                    header ? FontWeight.w700 : FontWeight.w500)),
      ));
    }
    tagTable.add(TableRow(
      decoration: BoxDecoration(
        color: header ? kAccent.withValues(alpha: 0.12) : Colors.transparent,
      ),
      children: cells,
    ));
  }

  final Widget tagPanel = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kPanelAlt,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('SemanticsTag (related concept)',
            style: TextStyle(
                color: kAccent, fontSize: 15, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        const Text(
          'Tags decorate SemanticsNodes for traversal and platform hints. '
          'Distinct from events but in the same package.',
          style: TextStyle(color: kInkDim, fontSize: 11.5),
        ),
        const SizedBox(height: 10),
        Table(
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(2.2),
            1: FlexColumnWidth(2.6),
          },
          border: TableBorder.all(
              color: kBorder.withValues(alpha: 0.5), width: 0.7),
          children: tagTable,
        ),
      ],
    ),
  );

  // ---- Accessibility checklist ----
  final List<List<String>> checklist = <List<String>>[
    <String>['label', 'short, non-redundant name'],
    <String>['hint', 'what activation does'],
    <String>['value', 'current state for sliders/toggles'],
    <String>['increasedValue', 'next value when adjusted up'],
    <String>['decreasedValue', 'next value when adjusted down'],
    <String>['onTap', 'primary activation -> TapSemanticEvent'],
    <String>['onLongPress', 'secondary -> LongPressSemanticsEvent'],
    <String>['button / link / header', 'role flags'],
    <String>['excludeSemantics', 'hide decorative subtrees'],
    <String>['mergeSemantics', 'flatten compound widgets'],
  ];

  Widget checkRow(String k, String v) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(Icons.check_circle_outline, size: 16, color: kOk),
          const SizedBox(width: 8),
          SizedBox(
            width: 150,
            child: Text(k,
                style: const TextStyle(
                    color: kAccent,
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.w700)),
          ),
          Expanded(
            child: Text(v,
                style: const TextStyle(color: kInk, fontSize: 12.3)),
          ),
        ],
      ),
    );
  }

  final List<Widget> checklistRows = <Widget>[];
  for (int i = 0; i < checklist.length; i++) {
    checklistRows.add(checkRow(checklist[i][0], checklist[i][1]));
  }

  final Widget checklistPanel = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kPanel,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Accessibility checklist for tappable nodes',
            style: TextStyle(
                color: kAccent, fontSize: 15, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        ...checklistRows,
      ],
    ),
  );

  // ---- Edge cases ----
  final List<List<String>> edgeRows = <List<String>>[
    <String>['null label', 'reader falls back to child Text or "" — bad UX'],
    <String>['hidden node', 'excludeSemantics: true skips event dispatch'],
    <String>['merged semantics',
        'TapSemanticEvent fires on the merged ancestor'],
    <String>['disabled control',
        'enabled: false -> reader announces "dimmed", no tap'],
    <String>['scrollable parent',
        'tap propagates only if no scroll handles it'],
  ];
  Widget edgeRow(String l, String r) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(Icons.warning_amber_rounded, size: 16, color: kWarn),
          const SizedBox(width: 8),
          SizedBox(
            width: 150,
            child: Text(l,
                style: const TextStyle(
                    color: kWarn,
                    fontSize: 12,
                    fontWeight: FontWeight.w700)),
          ),
          Expanded(
            child: Text(r,
                style: const TextStyle(color: kInk, fontSize: 12.3)),
          ),
        ],
      ),
    );
  }

  final List<Widget> edgeWidgets = <Widget>[];
  for (int i = 0; i < edgeRows.length; i++) {
    edgeWidgets.add(edgeRow(edgeRows[i][0], edgeRows[i][1]));
  }

  final Widget edgePanel = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kPanelAlt,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Edge cases',
            style: TextStyle(
                color: kAccent, fontSize: 15, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        ...edgeWidgets,
      ],
    ),
  );

  // ---- Reference table of SemanticsEvent subclasses ----
  final List<List<String>> refRows = <List<String>>[
    <String>['subclass', 'type', 'carries data?'],
    <String>['TapSemanticEvent', 'tap', 'no'],
    <String>['LongPressSemanticsEvent', 'longPress', 'no'],
    <String>['AnnounceSemanticsEvent', 'announce', 'message + direction'],
    <String>['TooltipSemanticsEvent', 'tooltip', 'message'],
    <String>['FocusSemanticEvent', 'focus', 'no'],
  ];
  final List<TableRow> refTable = <TableRow>[];
  for (int i = 0; i < refRows.length; i++) {
    final List<String> r = refRows[i];
    final bool header = i == 0;
    final bool focal = !header && r[0] == 'TapSemanticEvent';
    final List<Widget> cells = <Widget>[];
    for (int j = 0; j < r.length; j++) {
      cells.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Text(r[j],
            style: TextStyle(
                color: header
                    ? kAccent
                    : (focal ? kAccentSoft : kInk),
                fontFamily: 'monospace',
                fontSize: 11.5,
                fontWeight: header || focal
                    ? FontWeight.w700
                    : FontWeight.w500)),
      ));
    }
    refTable.add(TableRow(
      decoration: BoxDecoration(
        color: header
            ? kAccent.withValues(alpha: 0.15)
            : (focal
                ? kAccent.withValues(alpha: 0.08)
                : Colors.transparent),
      ),
      children: cells,
    ));
  }

  final Widget refPanel = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kPanel,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('SemanticsEvent reference',
            style: TextStyle(
                color: kAccent, fontSize: 15, fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        Table(
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(2.6),
            1: FlexColumnWidth(1.4),
            2: FlexColumnWidth(2.2),
          },
          border: TableBorder.all(
              color: kBorder.withValues(alpha: 0.5), width: 0.7),
          children: refTable,
        ),
      ],
    ),
  );

  // ---- Footer ----
  final Widget footer = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: kPanelAlt,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: kBorder),
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Take-aways',
            style: TextStyle(
                color: kAccent, fontSize: 14, fontWeight: FontWeight.w700)),
        SizedBox(height: 6),
        Text(
          '· TapSemanticEvent is a tag, not a payload carrier.\n'
          '· Authored once by the framework, consumed by the platform.\n'
          '· Pair tap-able widgets with descriptive labels and hints.\n'
          '· For arbitrary speech, prefer SemanticsService.announce.',
          style: TextStyle(color: kInk, fontSize: 12.5, height: 1.5),
        ),
      ],
    ),
  );

  // ---- Palette swatches panel ----
  Widget swatch(String name, Color c, String hex, String role) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: kBorder),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 110,
            child: Text(name,
                style: const TextStyle(
                    color: kAccent,
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.w700)),
          ),
          SizedBox(
            width: 90,
            child: Text(hex,
                style: const TextStyle(
                    color: kInkDim, fontFamily: 'monospace', fontSize: 11.5)),
          ),
          Expanded(
            child: Text(role,
                style: const TextStyle(color: kInk, fontSize: 12.2)),
          ),
        ],
      ),
    );
  }

  final Widget palettePanel = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kPanelAlt,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Demo palette',
            style: TextStyle(
                color: kAccent, fontSize: 15, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        const Text(
          'Colour roles used throughout this TapSemanticEvent demo. Distinct '
          'from sibling demos so the eye can pin the topic instantly.',
          style: TextStyle(color: kInkDim, fontSize: 11.5),
        ),
        const SizedBox(height: 10),
        swatch('kBgDeep', kBgDeep, '#062A33', 'page background'),
        swatch('kPanel', kPanel, '#0E3D49', 'primary panel surface'),
        swatch('kPanelAlt', kPanelAlt, '#114E5C', 'alternating panel'),
        swatch('kAccent', kAccent, '#FFB347', 'headings, focal highlights'),
        swatch('kAccentSoft', kAccentSoft, '#FFD089', 'soft amber accents'),
        swatch('kInk', kInk, '#E8F4F7', 'primary text colour'),
        swatch('kInkDim', kInkDim, '#9FB9C0', 'secondary / muted text'),
        swatch('kBorder', kBorder, '#1F6E80', 'panel borders'),
        swatch('kOk', kOk, '#7BD389', 'success / pass markers'),
        swatch('kWarn', kWarn, '#EF6F6C', 'warnings / errors'),
        swatch('kInfo', kInfo, '#6FB1FC', 'informational tone'),
      ],
    ),
  );

  // ---- Gesture-to-Semantic mapping grid ----
  final List<List<String>> gestureRows = <List<String>>[
    <String>['raw gesture', 'a11y action', 'event class', 'spoken cue'],
    <String>['single tap', 'activate', 'TapSemanticEvent',
        'reader plays activation chirp'],
    <String>['double-tap (TalkBack)', 'activate', 'TapSemanticEvent',
        '"double-tap to activate" → activated'],
    <String>['long press', 'longPress',
        'LongPressSemanticsEvent', '"more options"'],
    <String>['swipe up/down (T)', 'increase/decrease',
        '(custom semantics)', 'reads new value'],
    <String>['swipe right (V)', 'next focusable',
        '(focus traversal)', 'reads next label'],
    <String>['rotor (V) / explore (T)', 'explore by type',
        '(category filter)', 'jumps headings/links/buttons'],
    <String>['three-finger tap (V)', 'announce',
        'AnnounceSemanticsEvent', 'speaks message'],
    <String>['hover briefly', 'tooltip',
        'TooltipSemanticsEvent', 'speaks tooltip text'],
    <String>['focus enters', 'focus',
        'FocusSemanticEvent', 'reader anchors to node'],
  ];

  final List<TableRow> gestureTable = <TableRow>[];
  for (int i = 0; i < gestureRows.length; i++) {
    final List<String> r = gestureRows[i];
    final bool header = i == 0;
    final bool focal = !header && r[2] == 'TapSemanticEvent';
    final List<Widget> cells = <Widget>[];
    for (int j = 0; j < r.length; j++) {
      cells.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Text(
          r[j],
          style: TextStyle(
            color: header ? kAccent : (focal ? kAccentSoft : kInk),
            fontFamily: 'monospace',
            fontSize: 11.3,
            fontWeight: header || focal ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ));
    }
    gestureTable.add(TableRow(
      decoration: BoxDecoration(
        color: header
            ? kAccent.withValues(alpha: 0.15)
            : (focal ? kAccent.withValues(alpha: 0.08) : Colors.transparent),
      ),
      children: cells,
    ));
  }

  final Widget gesturePanel = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kPanel,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Gesture → semantic action map',
            style: TextStyle(
                color: kAccent, fontSize: 15, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        const Text(
          'How user-facing gestures map onto semantic actions and which '
          'SemanticsEvent (if any) appears on the wire.',
          style: TextStyle(color: kInkDim, fontSize: 11.5),
        ),
        const SizedBox(height: 10),
        Table(
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(2.0),
            1: FlexColumnWidth(1.6),
            2: FlexColumnWidth(2.4),
            3: FlexColumnWidth(2.2),
          },
          border: TableBorder.all(
              color: kBorder.withValues(alpha: 0.5), width: 0.7),
          children: gestureTable,
        ),
      ],
    ),
  );

  // ---- Accessibility label dos and don'ts ----
  final List<List<String>> labelRows = <List<String>>[
    <String>['scenario', 'bad label', 'good label'],
    <String>['save button', '"Button"', '"Save document"'],
    <String>['delete icon', '"Trash"', '"Delete selected message"'],
    <String>['nav back', '"Arrow"', '"Back to inbox"'],
    <String>['toggle on', '"Switch"', '"Notifications, on"'],
    <String>['avatar', '"Image"', '"Open profile of Alex Kyaw"'],
    <String>['close dialog', '"X"', '"Close payment dialog"'],
    <String>['search field', '""', '"Search products, edit text"'],
    <String>['volume slider', '"Slider 50"', '"Volume, 50 percent"'],
    <String>['paginated next', '"Next"', '"Next page, page 4 of 12"'],
    <String>['progress bar', '"Bar"', '"Uploading, 73 percent"'],
  ];

  final List<TableRow> labelTable = <TableRow>[];
  for (int i = 0; i < labelRows.length; i++) {
    final List<String> r = labelRows[i];
    final bool header = i == 0;
    final List<Widget> cells = <Widget>[];
    for (int j = 0; j < r.length; j++) {
      Color cellColor = kInk;
      if (!header) {
        if (j == 1) cellColor = kWarn;
        if (j == 2) cellColor = kOk;
      } else {
        cellColor = kAccent;
      }
      cells.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Text(
          r[j],
          style: TextStyle(
            color: cellColor,
            fontFamily: 'monospace',
            fontSize: 11.5,
            fontWeight: header ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ));
    }
    labelTable.add(TableRow(
      decoration: BoxDecoration(
        color: header ? kAccent.withValues(alpha: 0.15) : Colors.transparent,
      ),
      children: cells,
    ));
  }

  final Widget labelPanel = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kPanelAlt,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Label dos and don\'ts',
            style: TextStyle(
                color: kAccent, fontSize: 15, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        const Text(
          'A TapSemanticEvent is silent on its own — the spoken result depends '
          'entirely on the surrounding label, hint, role, and value. Keep '
          'labels short, descriptive, and free of redundant role words.',
          style: TextStyle(color: kInkDim, fontSize: 11.5),
        ),
        const SizedBox(height: 10),
        Table(
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(1.6),
            1: FlexColumnWidth(2.0),
            2: FlexColumnWidth(2.6),
          },
          border: TableBorder.all(
              color: kBorder.withValues(alpha: 0.5), width: 0.7),
          children: labelTable,
        ),
      ],
    ),
  );

  // ---- ASCII Semantic Tree visualization ----
  final List<String> asciiTreeLines = <String>[
    'SemanticsOwner',
    '└─ SemanticsNode#0  (root view)',
    '   ├─ SemanticsNode#1  label="Compose"  button',
    '   │   └─ onTap ──▶ TapSemanticEvent { type: "tap" }',
    '   ├─ SemanticsNode#2  label="Inbox"  header',
    '   │   ├─ SemanticsNode#3  label="From Alex · Project sync"',
    '   │   │   ├─ onTap ──▶ TapSemanticEvent { type: "tap" }',
    '   │   │   └─ onLongPress ──▶ LongPressSemanticsEvent',
    '   │   └─ SemanticsNode#4  label="From Sam · Friday plans"',
    '   │       └─ onTap ──▶ TapSemanticEvent { type: "tap" }',
    '   └─ SemanticsNode#5  label="Settings"  link',
    '       └─ onTap ──▶ TapSemanticEvent { type: "tap" }',
  ];

  final List<Widget> asciiTreeWidgets = <Widget>[];
  for (int i = 0; i < asciiTreeLines.length; i++) {
    final String line = asciiTreeLines[i];
    final bool focal = line.contains('TapSemanticEvent');
    asciiTreeWidgets.add(Text(
      line,
      style: TextStyle(
        color: focal ? kAccent : kInk,
        fontFamily: 'monospace',
        fontSize: 12,
        fontWeight: focal ? FontWeight.w700 : FontWeight.w400,
      ),
    ));
  }

  final Widget asciiTreePanel = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kPanel,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('ASCII view of a Semantics tree',
            style: TextStyle(
                color: kAccent, fontSize: 15, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        const Text(
          'Each onTap edge in the tree is a potential TapSemanticEvent '
          'emitter. The engine queues the event when the user activates the '
          'node through assistive technology.',
          style: TextStyle(color: kInkDim, fontSize: 11.5),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: asciiTreeWidgets,
          ),
        ),
      ],
    ),
  );

  // ---- Lifecycle timeline ----
  Widget timelineStep(int idx, String title, String detail, Color tone) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: tone.withValues(alpha: 0.7)),
            ),
            child: Text('$idx',
                style: TextStyle(
                    color: tone,
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title,
                    style: TextStyle(
                        color: tone,
                        fontSize: 13,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(detail,
                    style: const TextStyle(
                        color: kInk, fontSize: 12.3, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget lifecyclePanel = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kPanelAlt,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Lifecycle of a tap activation',
            style: TextStyle(
                color: kAccent, fontSize: 15, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        const Text(
          'From the moment a screen-reader user double-taps until the audible '
          'confirmation, a TapSemanticEvent passes through several layers.',
          style: TextStyle(color: kInkDim, fontSize: 11.5),
        ),
        const SizedBox(height: 10),
        timelineStep(1, 'Gesture captured',
            'Platform a11y service detects activation gesture (TalkBack '
            'double-tap, VoiceOver single-tap).',
            kInfo),
        timelineStep(2, 'Action dispatched',
            'Engine receives "didPerformAction(activate, nodeId)" and routes '
            'it to the SemanticsOwner.',
            kInfo),
        timelineStep(3, 'Handler invoked',
            'SemanticsNode.onTap (or SemanticsActions.tap) runs in the '
            'Flutter UI isolate.',
            kAccent),
        timelineStep(4, 'Event queued',
            'SemanticsBinding.sendEvent posts a TapSemanticEvent over the '
            'flutter/accessibility platform channel.',
            kAccent),
        timelineStep(5, 'AT confirms',
            'TalkBack/VoiceOver/NVDA receives type="tap" and plays its '
            'activation chirp.',
            kOk),
        timelineStep(6, 'UI updates',
            'Visual side-effects of onTap (state change, navigation) follow '
            'on the next frame.',
            kOk),
      ],
    ),
  );

  // ---- Detailed prose: screen reader behaviour ----
  final Widget proseScreenReaders = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kPanel,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('How each screen reader handles "tap"',
            style: TextStyle(
                color: kAccent, fontSize: 15, fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        const Text(
          'TalkBack (Android). When the user explores by touch and finds a '
          'focusable node, TalkBack reads its label, role, and a short usage '
          'hint such as "double-tap to activate". A double-tap then fires the '
          'platform activate action; Flutter\'s engine performs the node\'s '
          'onTap and immediately queues a TapSemanticEvent. TalkBack uses '
          'this event to play a tiny "click" earcon, signalling that the '
          'activation reached the app.',
          style: TextStyle(color: kInk, fontSize: 12.6, height: 1.5),
        ),
        SizedBox(height: 10),
        Text(
          'VoiceOver (iOS, iPadOS, macOS). VoiceOver focuses a node when the '
          'user single-taps, drags, or rotates the rotor. A subsequent '
          'single-tap with one finger activates it. The engine reports the '
          'action to Flutter; the framework dispatches a TapSemanticEvent. '
          'VoiceOver plays the "Activated" earcon and may speak the new '
          'state if the label or value changed.',
          style: TextStyle(color: kInk, fontSize: 12.6, height: 1.5),
        ),
        SizedBox(height: 10),
        Text(
          'NVDA / JAWS (Windows). On desktop, focus arrives via Tab. Pressing '
          'Enter or Space activates the focused control. Flutter still emits '
          'TapSemanticEvent — the screen reader interprets it as the '
          'activation chirp, then re-reads the node if its label, value, or '
          'expanded state changed.',
          style: TextStyle(color: kInk, fontSize: 12.6, height: 1.5),
        ),
        SizedBox(height: 10),
        Text(
          'Switch Control (iOS) and Voice Access (Android). Both rely on the '
          'same activate action that drives TapSemanticEvent. Switch Control '
          'highlights the next item and a switch press confirms; Voice Access '
          'overlays numbers and the user says "Tap 7". In every case the '
          'underlying signal Flutter sends back is a TapSemanticEvent.',
          style: TextStyle(color: kInk, fontSize: 12.6, height: 1.5),
        ),
      ],
    ),
  );

  // ---- API-surface mini reference ----
  final List<List<String>> apiRows = <List<String>>[
    <String>['member', 'kind', 'description'],
    <String>['TapSemanticEvent()', 'const ctor', 'no parameters; type tag only'],
    <String>['type', 'String', 'always "tap"'],
    <String>['getDataMap()',
        'Map<String,dynamic>',
        'returns event-specific extras ({} for tap)'],
    <String>['toMap()',
        'Map<String,dynamic>',
        '{"type": type, "data": getDataMap()}'],
    <String>['toString()', 'String', 'human-readable identifier'],
    <String>['SemanticsBinding.sendEvent(e)',
        'void',
        'enqueues for platform channel'],
  ];
  final List<TableRow> apiTable = <TableRow>[];
  for (int i = 0; i < apiRows.length; i++) {
    final List<String> r = apiRows[i];
    final bool header = i == 0;
    final List<Widget> cells = <Widget>[];
    for (int j = 0; j < r.length; j++) {
      cells.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Text(r[j],
            style: TextStyle(
                color: header ? kAccent : kInk,
                fontFamily: 'monospace',
                fontSize: 11.4,
                fontWeight:
                    header ? FontWeight.w700 : FontWeight.w500)),
      ));
    }
    apiTable.add(TableRow(
      decoration: BoxDecoration(
        color: header ? kAccent.withValues(alpha: 0.15) : Colors.transparent,
      ),
      children: cells,
    ));
  }

  final Widget apiPanel = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kPanelAlt,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('API surface (mini)',
            style: TextStyle(
                color: kAccent, fontSize: 15, fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        Table(
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(2.6),
            1: FlexColumnWidth(1.6),
            2: FlexColumnWidth(3.0),
          },
          border: TableBorder.all(
              color: kBorder.withValues(alpha: 0.5), width: 0.7),
          children: apiTable,
        ),
      ],
    ),
  );

  // ---- Scenario panels: button, list-tile, custom-painted ----
  Widget scenarioPanel(
      String title, String prose, String code, Color tint) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tint.withValues(alpha: 0.55)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.bookmark_border, size: 18, color: tint),
              const SizedBox(width: 8),
              Expanded(
                child: Text(title,
                    style: TextStyle(
                        color: tint,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(prose,
              style:
                  const TextStyle(color: kInk, fontSize: 12.4, height: 1.45)),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: kBorder),
            ),
            child: Text(code,
                style: const TextStyle(
                    color: kAccentSoft,
                    fontFamily: 'monospace',
                    fontSize: 11.8,
                    height: 1.35)),
          ),
        ],
      ),
    );
  }

  final Widget scenarioButton = scenarioPanel(
    'Scenario A · plain Material button',
    'Stock Material widgets attach onTap-driven semantics automatically. '
    'Each press through assistive technology emits TapSemanticEvent. The '
    'reader reads label + role + state; Flutter quietly fires the event.',
    "ElevatedButton(\n"
    "  onPressed: saveDocument,\n"
    "  child: const Text('Save'),\n"
    ");\n"
    "// implicit Semantics with onTap → TapSemanticEvent",
    kInfo,
  );

  final Widget scenarioListTile = scenarioPanel(
    'Scenario B · ListTile with trailing action',
    'A ListTile groups label, subtitle, and trailing icon into a single '
    'merged semantics node. A tap on any region activates the parent and '
    'fires one TapSemanticEvent; the trailing IconButton can opt out via '
    'excludeFromSemantics or split into its own SemanticsNode.',
    "ListTile(\n"
    "  title: const Text('Project sync'),\n"
    "  subtitle: const Text('Today, 14:30'),\n"
    "  trailing: IconButton(\n"
    "    icon: const Icon(Icons.archive_outlined),\n"
    "    onPressed: archive,\n"
    "  ),\n"
    "  onTap: openThread,\n"
    ");",
    kAccent,
  );

  final Widget scenarioCustomPaint = scenarioPanel(
    'Scenario C · custom-painted hit target',
    'A bare CustomPaint has no built-in semantics. Wrap it in Semantics with '
    'an explicit label, role, and onTap. The framework will treat onTap as '
    'an activate action and emit TapSemanticEvent on user activation.',
    "Semantics(\n"
    "  label: 'Toggle gauge zoom',\n"
    "  hint: 'Activates a wider time window',\n"
    "  button: true,\n"
    "  onTap: toggleZoom,\n"
    "  child: GestureDetector(\n"
    "    onTap: toggleZoom,\n"
    "    child: CustomPaint(painter: gaugePainter),\n"
    "  ),\n"
    ");",
    kOk,
  );

  final Widget scenariosPanel = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kPanel,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Practical scenarios',
            style: TextStyle(
                color: kAccent, fontSize: 15, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        const Text(
          'Three concrete patterns showing where TapSemanticEvent appears.',
          style: TextStyle(color: kInkDim, fontSize: 11.5),
        ),
        const SizedBox(height: 10),
        scenarioButton,
        const SizedBox(height: 10),
        scenarioListTile,
        const SizedBox(height: 10),
        scenarioCustomPaint,
      ],
    ),
  );

  // ---- Quick a11y self-check matrix ----
  final List<List<String>> matrixRows = <List<String>>[
    <String>['check', 'TalkBack', 'VoiceOver', 'NVDA'],
    <String>['focus arrives on tap target', 'yes', 'yes', 'yes (Tab)'],
    <String>['label spoken before role', 'yes', 'yes', 'yes'],
    <String>['hint spoken if present', 'yes', 'yes', 'optional'],
    <String>['activation earcon', 'click', 'tock', 'beep'],
    <String>['re-reads on state change', 'yes', 'yes', 'yes'],
    <String>['supports custom actions', 'yes', 'yes', 'partial'],
  ];

  final List<TableRow> matrixTable = <TableRow>[];
  for (int i = 0; i < matrixRows.length; i++) {
    final List<String> r = matrixRows[i];
    final bool header = i == 0;
    final List<Widget> cells = <Widget>[];
    for (int j = 0; j < r.length; j++) {
      cells.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Text(r[j],
            style: TextStyle(
                color: header ? kAccent : kInk,
                fontFamily: 'monospace',
                fontSize: 11.4,
                fontWeight:
                    header ? FontWeight.w700 : FontWeight.w500)),
      ));
    }
    matrixTable.add(TableRow(
      decoration: BoxDecoration(
        color: header ? kAccent.withValues(alpha: 0.15) : Colors.transparent,
      ),
      children: cells,
    ));
  }

  final Widget matrixPanel = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kPanelAlt,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Self-check matrix per reader',
            style: TextStyle(
                color: kAccent, fontSize: 15, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        const Text(
          'Sanity boxes to tick when QA-ing tappable widgets across the three '
          'most common screen readers.',
          style: TextStyle(color: kInkDim, fontSize: 11.5),
        ),
        const SizedBox(height: 10),
        Table(
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(2.6),
            1: FlexColumnWidth(1.4),
            2: FlexColumnWidth(1.4),
            3: FlexColumnWidth(1.4),
          },
          border: TableBorder.all(
              color: kBorder.withValues(alpha: 0.5), width: 0.7),
          children: matrixTable,
        ),
      ],
    ),
  );

  // ---- Common pitfalls list ----
  final List<List<String>> pitfallRows = <List<String>>[
    <String>['Detached GestureDetector',
        'Wrap in Semantics(onTap: ...) so the engine knows the gesture is '
            'a semantic activation and emits TapSemanticEvent.'],
    <String>['Two onTaps in one merged subtree',
        'Use mergeSemantics: false or wrap the child in '
            'ExcludeSemantics so the AT does not stutter activations.'],
    <String>['Missing role flag',
        'Mark buttons with button: true so readers say "button" before the '
            'label; otherwise the activation chirp is ambiguous.'],
    <String>['Empty label fallback',
        'A node with onTap but no label inherits child Text — fragile when '
            'the child is an Icon. Always provide an explicit label.'],
    <String>['Tap fires but no UI change',
        'AT users hear the activation chirp and expect a state change. '
            'Either announce explicitly via SemanticsService.announce or '
            'update the value/label so the AT re-reads.'],
    <String>['Hidden tap target',
        'opacity: 0 or Offstage subtrees still receive semantics unless '
            'excluded. Wrap in ExcludeSemantics to prevent stray '
            'TapSemanticEvent dispatches.'],
    <String>['Long-press conflated with tap',
        'Use distinct onLongPress so the framework can emit '
            'LongPressSemanticsEvent rather than collapsing both into '
            'TapSemanticEvent.'],
  ];

  Widget pitfallRow(String title, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(Icons.report_gmailerrorred,
              size: 18, color: kWarn),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title,
                    style: const TextStyle(
                        color: kWarn,
                        fontSize: 12.8,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(detail,
                    style: const TextStyle(
                        color: kInk, fontSize: 12.2, height: 1.45)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final List<Widget> pitfallWidgets = <Widget>[];
  for (int i = 0; i < pitfallRows.length; i++) {
    pitfallWidgets.add(pitfallRow(pitfallRows[i][0], pitfallRows[i][1]));
  }

  final Widget pitfallsPanel = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kPanel,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Common pitfalls when relying on TapSemanticEvent',
            style: TextStyle(
                color: kAccent, fontSize: 15, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        ...pitfallWidgets,
      ],
    ),
  );

  // ---- Glossary panel ----
  final List<List<String>> glossaryRows = <List<String>>[
    <String>['SemanticsEvent',
        'Abstract base for one-shot signals sent over the accessibility '
            'platform channel. Subclasses encode the kind of signal in their '
            'type string.'],
    <String>['TapSemanticEvent',
        'Concrete subclass with type "tap" and an empty data map. Fires '
            'whenever a node\'s onTap activate action is invoked through '
            'assistive technology.'],
    <String>['LongPressSemanticsEvent',
        'Sister event with type "longPress". No data map. Emitted on the '
            'long-press activate action.'],
    <String>['AnnounceSemanticsEvent',
        'Carries a spoken message and reading direction. Use when there is '
            'no specific node to attach the announcement to.'],
    <String>['TooltipSemanticsEvent',
        'Carries the tooltip string. Sent when a tooltip becomes visible '
            'to the user.'],
    <String>['FocusSemanticEvent',
        'Signals that focus changed and the new node should be re-read by '
            'the assistive technology.'],
    <String>['SemanticsBinding',
        'Binding mixin that owns the SemanticsOwner and provides sendEvent '
            'for shipping events to the platform.'],
    <String>['SemanticsOwner',
        'Holds the live SemanticsNode tree and dispatches updates to the '
            'engine. The thing TapSemanticEvent is delivered against.'],
    <String>['SemanticsAction',
        'Enum of activate, longPress, scrollLeft, copy, paste, etc. The '
            'action that triggers TapSemanticEvent is "tap".'],
    <String>['SemanticsTag',
        'Identifier used to mark special nodes (e.g. excluded from scroll). '
            'Unrelated to events but lives in the same package.'],
  ];

  Widget glossaryRow(String term, String def) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 180,
            child: Text(term,
                style: const TextStyle(
                    color: kAccent,
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.w700)),
          ),
          Expanded(
            child: Text(def,
                style: const TextStyle(
                    color: kInk, fontSize: 12.2, height: 1.45)),
          ),
        ],
      ),
    );
  }

  final List<Widget> glossaryWidgets = <Widget>[];
  for (int i = 0; i < glossaryRows.length; i++) {
    glossaryWidgets.add(glossaryRow(glossaryRows[i][0], glossaryRows[i][1]));
  }

  final Widget glossaryPanel = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kPanelAlt,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Glossary',
            style: TextStyle(
                color: kAccent, fontSize: 15, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        ...glossaryWidgets,
      ],
    ),
  );

  // ---- Status badge row ----
  Widget statusBadge(String label, bool ok) {
    final Color tone = ok ? kOk : kWarn;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: tone.withValues(alpha: 0.7)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(ok ? Icons.check : Icons.error_outline, size: 14, color: tone),
          const SizedBox(width: 6),
          Text(label,
              style: TextStyle(
                  color: tone,
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  final Widget statusRow = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: kPanel,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Construction status',
            style: TextStyle(
                color: kAccent, fontSize: 14, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        const Text(
          'Did each bridged constructor succeed under the d4rt interpreter?',
          style: TextStyle(color: kInkDim, fontSize: 11.5),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            statusBadge('TapSemanticEvent', tapEvent != null),
            statusBadge('LongPressSemanticsEvent', longPressEvent != null),
            statusBadge('AnnounceSemanticsEvent', announceEvent != null),
            statusBadge('TooltipSemanticsEvent', tooltipEvent != null),
            statusBadge('FocusSemanticEvent', focusEvent != null),
            statusBadge('getDataMap()', tapMapErr.isEmpty),
          ],
        ),
      ],
    ),
  );

  // ---- Animated-feel halo around the focal status (using AlwaysStopped) ----
  final Widget focalHalo = Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: RadialGradient(
        colors: <Color>[
          kAccent.withValues(alpha: 0.22),
          kAccent.withValues(alpha: 0.04),
          Colors.transparent,
        ],
        stops: const <double>[0.0, 0.5, 1.0],
        radius: 0.9,
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: kAccent.withValues(alpha: 0.5)),
    ),
    child: Row(
      children: <Widget>[
        FadeTransition(
          opacity: const AlwaysStoppedAnimation<double>(0.85),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: kAccent.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: kAccent),
            ),
            child: const Icon(Icons.touch_app, color: kAccent, size: 28),
          ),
        ),
        const SizedBox(width: 14),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('TapSemanticEvent — at a glance',
                  style: TextStyle(
                      color: kAccent,
                      fontSize: 15,
                      fontWeight: FontWeight.w800)),
              SizedBox(height: 4),
              Text(
                'A const-constructible "tap" tag. No payload. The platform '
                'turns it into the activation chirp users hear.',
                style: TextStyle(
                    color: kInk, fontSize: 12.5, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ---- Long-form: when NOT to fire a tap ----
  final Widget whenNotPanel = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kPanelAlt,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('When NOT to model a node as tappable',
            style: TextStyle(
                color: kAccent, fontSize: 15, fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        const Text(
          'TapSemanticEvent is cheap, but pretending an inert region is '
          'tappable is harmful. Decorative dividers, illustrative imagery, '
          'and ambient backgrounds should NOT carry onTap. Doing so produces '
          'noise: the AT focuses every "button", reads its placeholder label, '
          'and fires unwanted activation chirps when users explore by touch.',
          style: TextStyle(color: kInk, fontSize: 12.6, height: 1.5),
        ),
        SizedBox(height: 10),
        Text(
          'Likewise, do not attach onTap to nodes whose only effect is a '
          'transient hover-style highlight. Screen reader users cannot '
          'observe hover; they will hear a tap that does nothing. Reserve '
          'TapSemanticEvent for genuine activation: navigation, state '
          'changes, submissions, dismissals, expansions, and selections.',
          style: TextStyle(color: kInk, fontSize: 12.6, height: 1.5),
        ),
        SizedBox(height: 10),
        Text(
          'When unsure, prefer ExcludeSemantics or excludeFromSemantics: true '
          'and leave the gesture as a sighted-only convenience. Quality '
          'beats coverage — every TapSemanticEvent should map to a '
          'meaningful, observable change for the user.',
          style: TextStyle(color: kInk, fontSize: 12.6, height: 1.5),
        ),
      ],
    ),
  );

  // ---- Section helpers ----
  Widget gap() => const SizedBox(height: 16);

  return Scaffold(
    backgroundColor: kBgDeep,
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            hero,
            gap(),
            focalHalo,
            gap(),
            statusRow,
            gap(),
            layerDiagram,
            gap(),
            hierarchy,
            gap(),
            anatomy,
            gap(),
            apiPanel,
            gap(),
            sisterPanel,
            gap(),
            announceVsTap,
            gap(),
            transcript,
            gap(),
            proseScreenReaders,
            gap(),
            exampleTree,
            gap(),
            asciiTreePanel,
            gap(),
            scenariosPanel,
            gap(),
            gesturePanel,
            gap(),
            labelPanel,
            gap(),
            matrixPanel,
            gap(),
            lifecyclePanel,
            gap(),
            tagPanel,
            gap(),
            checklistPanel,
            gap(),
            edgePanel,
            gap(),
            pitfallsPanel,
            gap(),
            whenNotPanel,
            gap(),
            refPanel,
            gap(),
            glossaryPanel,
            gap(),
            palettePanel,
            gap(),
            footer,
          ],
        ),
      ),
    ),
  );
}
