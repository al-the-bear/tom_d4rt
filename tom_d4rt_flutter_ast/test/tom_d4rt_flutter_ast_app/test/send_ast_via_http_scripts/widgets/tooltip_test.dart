// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo of Tooltip from flutter material widgets.
// Style: build()-once, no setState, no controllers, statically composed tree.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Tooltip Deep Demo executing');

  // ============ SECTION 1: Title Banner ============
  print('=== Section 1: Title Banner ===');
  final titleBanner = Container(
    width: double.infinity,
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF1A237E),
          Color(0xFF3949AB),
          Color(0xFF7E57C2),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF1A237E).withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: Colors.purple.withValues(alpha: 0.25),
          blurRadius: 32.0,
          offset: Offset(0.0, 16.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                  width: 1.2,
                ),
              ),
              child: Icon(
                Icons.info_outline,
                color: Colors.white,
                size: 36.0,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tooltip',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.6,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Material hover / long-press hint widget',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white.withValues(alpha: 0.85),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 8.0,
          children: [
            _bannerChip('message', Color(0xFFB39DDB)),
            _bannerChip('richMessage', Color(0xFF80DEEA)),
            _bannerChip('verticalOffset', Color(0xFFFFAB91)),
            _bannerChip('decoration', Color(0xFFC5E1A5)),
            _bannerChip('triggerMode', Color(0xFFFFE082)),
            _bannerChip('preferBelow', Color(0xFFF48FB1)),
          ],
        ),
      ],
    ),
  );

  // ============ SECTION 2: Anatomy Diagram ============
  print('=== Section 2: Anatomy Diagram ===');
  final anatomyDiagram = _sectionCard(
    sectionTitle: 'Section 2 — Anatomy of a Tooltip',
    sectionColor: Color(0xFF26A69A),
    sectionIcon: Icons.architecture,
    description:
        'A Tooltip wraps a target widget. On hover (desktop) or long-press '
        '(mobile) Flutter shows a floating bubble offset from the target by '
        'verticalOffset. The bubble contains either message or richMessage.',
    body: Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFE0F2F1),
            Color(0xFFB2DFDB),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Column(
        children: [
          // The "tooltip bubble" mock
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Color(0xFF263238),
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.45),
                  blurRadius: 10.0,
                  offset: Offset(0.0, 4.0),
                ),
              ],
            ),
            child: Text(
              'I am the tooltip bubble',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 4.0),
          // Vertical offset arrow
          Column(
            children: [
              Icon(
                Icons.arrow_drop_down,
                size: 28.0,
                color: Color(0xFF263238),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: Color(0xFF26A69A).withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  'verticalOffset',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontFamily: 'monospace',
                    color: Color(0xFF00695C),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          // The "target" mock
          Tooltip(
            message: 'I am the tooltip bubble',
            child: Container(
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xFF26A69A), width: 2.5),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF26A69A).withValues(alpha: 0.35),
                    blurRadius: 8.0,
                    offset: Offset(0.0, 4.0),
                  ),
                ],
              ),
              child: Icon(
                Icons.help_outline,
                color: Color(0xFF00695C),
                size: 28.0,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'target child',
            style: TextStyle(
              fontSize: 11.0,
              color: Color(0xFF00695C),
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 14.0),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Color(0xFF26A69A), width: 1.0),
            ),
            child: Text(
              'Tooltip(message, child) → wraps any widget. The bubble is\n'
              'rendered into the OverlayState above the rest of the tree.',
              style: TextStyle(
                fontSize: 11.0,
                color: Color(0xFF004D40),
                fontFamily: 'monospace',
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );

  // ============ SECTION 3: Constructor Param Catalogue ============
  print('=== Section 3: Constructor Param Catalogue ===');
  final List<Map<String, Object>> paramCatalogue = <Map<String, Object>>[
    <String, Object>{
      'name': 'message',
      'type': 'String?',
      'color': Color(0xFF7E57C2),
    },
    <String, Object>{
      'name': 'richMessage',
      'type': 'InlineSpan?',
      'color': Color(0xFF42A5F5),
    },
    <String, Object>{
      'name': 'child',
      'type': 'Widget?',
      'color': Color(0xFF26A69A),
    },
    <String, Object>{
      'name': 'verticalOffset',
      'type': 'double?',
      'color': Color(0xFFFFA726),
    },
    <String, Object>{
      'name': 'padding',
      'type': 'EdgeInsetsGeometry?',
      'color': Color(0xFFEC407A),
    },
    <String, Object>{
      'name': 'margin',
      'type': 'EdgeInsetsGeometry?',
      'color': Color(0xFFAB47BC),
    },
    <String, Object>{
      'name': 'decoration',
      'type': 'Decoration?',
      'color': Color(0xFF5C6BC0),
    },
    <String, Object>{
      'name': 'textStyle',
      'type': 'TextStyle?',
      'color': Color(0xFF66BB6A),
    },
    <String, Object>{
      'name': 'textAlign',
      'type': 'TextAlign?',
      'color': Color(0xFFFF7043),
    },
    <String, Object>{
      'name': 'waitDuration',
      'type': 'Duration?',
      'color': Color(0xFF26C6DA),
    },
    <String, Object>{
      'name': 'showDuration',
      'type': 'Duration?',
      'color': Color(0xFFD4E157),
    },
    <String, Object>{
      'name': 'exitDuration',
      'type': 'Duration?',
      'color': Color(0xFF8D6E63),
    },
    <String, Object>{
      'name': 'triggerMode',
      'type': 'TooltipTriggerMode?',
      'color': Color(0xFFEF5350),
    },
    <String, Object>{
      'name': 'enableFeedback',
      'type': 'bool?',
      'color': Color(0xFF78909C),
    },
    <String, Object>{
      'name': 'preferBelow',
      'type': 'bool?',
      'color': Color(0xFF26A69A),
    },
    <String, Object>{
      'name': 'excludeFromSemantics',
      'type': 'bool?',
      'color': Color(0xFFAB47BC),
    },
    <String, Object>{
      'name': 'height',
      'type': 'double?',
      'color': Color(0xFFFFCA28),
    },
  ];
  final paramChips = <Widget>[];
  for (final p in paramCatalogue) {
    paramChips.add(_paramChip(
      p['name'] as String,
      p['type'] as String,
      p['color'] as Color,
    ));
  }
  final paramSection = _sectionCard(
    sectionTitle: 'Section 3 — Constructor Parameters',
    sectionColor: Color(0xFF5C6BC0),
    sectionIcon: Icons.settings_input_component,
    description:
        'Tooltip exposes a rich set of named parameters for content, '
        'positioning, timing and theming. Below is the full chip catalogue '
        'of every commonly-used named argument.',
    body: Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: paramChips,
    ),
  );

  // ============ SECTION 4: Plain message example ============
  print('=== Section 4: Plain message example ===');
  final plainMessageSection = _sectionCard(
    sectionTitle: 'Section 4 — Plain message: IconButton + Tooltip',
    sectionColor: Color(0xFF7E57C2),
    sectionIcon: Icons.text_fields,
    description:
        'The simplest form: wrap an IconButton (or any widget) with a Tooltip '
        'and supply a plain message string. This is the canonical usage in '
        'Material toolbars and AppBars.',
    body: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _targetWithBubble(
              icon: Icons.save,
              tooltipText: 'Save',
              accent: Color(0xFF7E57C2),
            ),
            _targetWithBubble(
              icon: Icons.delete_outline,
              tooltipText: 'Delete this item',
              accent: Color(0xFFEF5350),
            ),
            _targetWithBubble(
              icon: Icons.share,
              tooltipText: 'Share with collaborators',
              accent: Color(0xFF26A69A),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        _codeBlock(
          'Tooltip(\n'
          '  message: "Save",\n'
          '  child: IconButton(\n'
          '    icon: Icon(Icons.save),\n'
          '    onPressed: _onSave,\n'
          '  ),\n'
          ')',
        ),
      ],
    ),
  );

  // ============ SECTION 5: richMessage with TextSpan ============
  print('=== Section 5: richMessage with TextSpan ===');
  final richTooltip = Tooltip(
    richMessage: TextSpan(
      children: <InlineSpan>[
        TextSpan(
          text: 'Press ',
          style: TextStyle(color: Colors.white),
        ),
        TextSpan(
          text: 'Ctrl+S',
          style: TextStyle(
            color: Color(0xFFFFD54F),
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
          ),
        ),
        TextSpan(
          text: ' to save the document.',
          style: TextStyle(color: Colors.white),
        ),
      ],
    ),
    child: Icon(Icons.keyboard, size: 32.0, color: Color(0xFF42A5F5)),
  );

  final richSection = _sectionCard(
    sectionTitle: 'Section 5 — richMessage with TextSpan',
    sectionColor: Color(0xFF42A5F5),
    sectionIcon: Icons.format_color_text,
    description:
        'Use richMessage when the hint mixes styles — e.g. a keyboard '
        'shortcut, an emphasized label, or coloured runs. richMessage and '
        'message are mutually exclusive: never set both.',
    body: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFE3F2FD),
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFF42A5F5), width: 2.0),
                  ),
                  child: richTooltip,
                ),
                SizedBox(height: 6.0),
                Text(
                  'target',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Color(0xFF1565C0),
                  ),
                ),
              ],
            ),
            // Mock of the rendered rich tooltip bubble
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF263238), Color(0xFF37474F)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.45),
                    blurRadius: 10.0,
                    offset: Offset(0.0, 4.0),
                  ),
                ],
              ),
              child: RichText(
                text: TextSpan(
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'Press ',
                      style: TextStyle(color: Colors.white, fontSize: 13.0),
                    ),
                    TextSpan(
                      text: 'Ctrl+S',
                      style: TextStyle(
                        color: Color(0xFFFFD54F),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                        fontSize: 13.0,
                      ),
                    ),
                    TextSpan(
                      text: ' to save.',
                      style: TextStyle(color: Colors.white, fontSize: 13.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _codeBlock(
          'Tooltip(\n'
          '  richMessage: TextSpan(children: [\n'
          '    TextSpan(text: "Press "),\n'
          '    TextSpan(text: "Ctrl+S",\n'
          '      style: TextStyle(fontWeight: bold)),\n'
          '    TextSpan(text: " to save."),\n'
          '  ]),\n'
          '  child: Icon(Icons.keyboard),\n'
          ')',
        ),
      ],
    ),
  );

  // ============ SECTION 6: verticalOffset examples ============
  print('=== Section 6: verticalOffset examples ===');
  final offsetExamples = <Widget>[];
  final List<Map<String, Object>> offsetData = <Map<String, Object>>[
    <String, Object>{
      'offset': 8.0,
      'label': 'small (8px)',
      'color': Color(0xFF66BB6A),
    },
    <String, Object>{
      'offset': 24.0,
      'label': 'default (24px)',
      'color': Color(0xFF42A5F5),
    },
    <String, Object>{
      'offset': 60.0,
      'label': 'large (60px)',
      'color': Color(0xFFEF5350),
    },
  ];
  for (final od in offsetData) {
    final off = od['offset'] as double;
    final label = od['label'] as String;
    final col = od['color'] as Color;
    offsetExamples.add(_offsetMockup(off, label, col));
  }
  final offsetSection = _sectionCard(
    sectionTitle: 'Section 6 — verticalOffset',
    sectionColor: Color(0xFFFFA726),
    sectionIcon: Icons.swap_vert,
    description:
        'verticalOffset is the vertical distance (in logical pixels) between '
        'the target and the tooltip bubble. Default is 24. Smaller values '
        'attach the bubble close to the target; larger values push it away.',
    body: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: offsetExamples,
    ),
  );

  // ============ SECTION 7: Custom decoration and textStyle ============
  print('=== Section 7: Custom decoration and textStyle ===');
  final gradientTooltip = Tooltip(
    message: 'Gradient bubble!',
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFEC407A), Color(0xFFAB47BC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    textStyle: TextStyle(
      color: Colors.white,
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
    ),
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    child: Icon(
      Icons.auto_awesome,
      size: 32.0,
      color: Color(0xFFEC407A),
    ),
  );

  final monoTooltip = Tooltip(
    message: 'console.log("hi")',
    decoration: BoxDecoration(
      color: Color(0xFF1B1B1B),
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: Color(0xFF00E676), width: 1.0),
    ),
    textStyle: TextStyle(
      color: Color(0xFF00E676),
      fontSize: 12.0,
      fontFamily: 'monospace',
    ),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Icon(Icons.terminal, size: 32.0, color: Color(0xFF00E676)),
  );

  final stylingSection = _sectionCard(
    sectionTitle: 'Section 7 — Custom decoration / textStyle',
    sectionColor: Color(0xFFEC407A),
    sectionIcon: Icons.brush,
    description:
        'Override the default dark-grey bubble by passing decoration, '
        'padding and textStyle. Combine with margin to control spacing from '
        'screen edges. Useful for branded or terminal-style tooltips.',
    body: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFFCE4EC),
                    shape: BoxShape.circle,
                  ),
                  child: gradientTooltip,
                ),
                SizedBox(height: 8.0),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 6.0,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFEC407A), Color(0xFFAB47BC)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    'Gradient bubble!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF263238),
                    shape: BoxShape.circle,
                  ),
                  child: monoTooltip,
                ),
                SizedBox(height: 8.0),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 6.0,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF1B1B1B),
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: Color(0xFF00E676), width: 1.0),
                  ),
                  child: Text(
                    'console.log("hi")',
                    style: TextStyle(
                      color: Color(0xFF00E676),
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _codeBlock(
          'Tooltip(\n'
          '  message: "Gradient bubble!",\n'
          '  decoration: BoxDecoration(\n'
          '    gradient: LinearGradient(...),\n'
          '    borderRadius: BorderRadius.circular(12),\n'
          '  ),\n'
          '  textStyle: TextStyle(color: white),\n'
          '  child: Icon(Icons.auto_awesome),\n'
          ')',
        ),
      ],
    ),
  );

  // ============ SECTION 8: triggerMode explanation ============
  print('=== Section 8: triggerMode explanation ===');
  final triggerCards = <Widget>[];
  final List<Map<String, Object>> triggerData = <Map<String, Object>>[
    <String, Object>{
      'mode': 'longPress',
      'icon': Icons.touch_app,
      'color': Color(0xFF7E57C2),
      'desc':
          'Default on touch devices. The bubble appears after a sustained '
          'long-press gesture and dismisses on release.',
    },
    <String, Object>{
      'mode': 'tap',
      'icon': Icons.ads_click,
      'color': Color(0xFF26A69A),
      'desc':
          'A single tap toggles the tooltip. Useful for help icons that '
          'should reveal info without competing with onPressed handlers.',
    },
    <String, Object>{
      'mode': 'manual',
      'icon': Icons.precision_manufacturing,
      'color': Color(0xFFEF5350),
      'desc':
          'No automatic gesture. Caller must invoke the TooltipState (via '
          'GlobalKey) to show or hide the bubble. Used for guided tours.',
    },
  ];
  for (final t in triggerData) {
    triggerCards.add(_triggerCard(
      t['mode'] as String,
      t['desc'] as String,
      t['icon'] as IconData,
      t['color'] as Color,
    ));
  }
  final triggerSection = _sectionCard(
    sectionTitle: 'Section 8 — triggerMode',
    sectionColor: Color(0xFFEF5350),
    sectionIcon: Icons.gesture,
    description:
        'TooltipTriggerMode controls which user gesture causes the bubble '
        'to appear. Pick the mode that matches platform conventions and '
        'whether your target child is also clickable.',
    body: Column(children: triggerCards),
  );

  // ============ SECTION 9: preferBelow true vs false ============
  print('=== Section 9: preferBelow true vs false ===');
  final preferBelowSection = _sectionCard(
    sectionTitle: 'Section 9 — preferBelow',
    sectionColor: Color(0xFF26A69A),
    sectionIcon: Icons.compare_arrows,
    description:
        'preferBelow indicates the desired side of the target. The framework '
        'still flips the bubble to the opposite side if it would clip the '
        'screen. Default is true (bubble below target).',
    body: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _preferBelowMockup(
          true,
          Color(0xFF26A69A),
        ),
        _preferBelowMockup(
          false,
          Color(0xFFEC407A),
        ),
      ],
    ),
  );

  // ============ SECTION 10: Use cases ============
  print('=== Section 10: Use cases ===');
  final useCaseSection = _sectionCard(
    sectionTitle: 'Section 10 — Common Use Cases',
    sectionColor: Color(0xFFAB47BC),
    sectionIcon: Icons.widgets,
    description:
        'Tooltip is ubiquitous in Material apps. The four mock cards below '
        'show realistic placements: form-field hints, IconButton hints, '
        'AppBar action hints, and status-indicator tooltips.',
    body: Column(
      children: [
        // Form-field hint
        Container(
          padding: EdgeInsets.all(12.0),
          margin: EdgeInsets.only(bottom: 12.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: Color(0xFFAB47BC)),
                  ),
                  child: Text(
                    'Email address',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Tooltip(
                message: 'We will only use this for password resets.',
                child: Icon(
                  Icons.help_outline,
                  size: 22.0,
                  color: Color(0xFFAB47BC),
                ),
              ),
            ],
          ),
        ),
        // Mock AppBar with action hints
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          margin: EdgeInsets.only(bottom: 12.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 6.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.menu, color: Colors.white),
              SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  'Inbox',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Tooltip(
                message: 'Search',
                child: Icon(Icons.search, color: Colors.white),
              ),
              SizedBox(width: 14.0),
              Tooltip(
                message: 'Refresh inbox',
                child: Icon(Icons.refresh, color: Colors.white),
              ),
              SizedBox(width: 14.0),
              Tooltip(
                message: 'More actions',
                child: Icon(Icons.more_vert, color: Colors.white),
              ),
            ],
          ),
        ),
        // Mock toolbar
        Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.only(bottom: 12.0),
          decoration: BoxDecoration(
            color: Color(0xFFECEFF1),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xFFB0BEC5)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Tooltip(
                message: 'Bold (Ctrl+B)',
                child: Icon(
                  Icons.format_bold,
                  color: Color(0xFF263238),
                ),
              ),
              Tooltip(
                message: 'Italic (Ctrl+I)',
                child: Icon(
                  Icons.format_italic,
                  color: Color(0xFF263238),
                ),
              ),
              Tooltip(
                message: 'Underline (Ctrl+U)',
                child: Icon(
                  Icons.format_underlined,
                  color: Color(0xFF263238),
                ),
              ),
              Tooltip(
                message: 'Strikethrough',
                child: Icon(
                  Icons.format_strikethrough,
                  color: Color(0xFF263238),
                ),
              ),
              Tooltip(
                message: 'Bullet list',
                child: Icon(
                  Icons.format_list_bulleted,
                  color: Color(0xFF263238),
                ),
              ),
            ],
          ),
        ),
        // Status indicator tooltips
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Service status:',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  _statusDot(
                    Color(0xFF66BB6A),
                    'Healthy — last ping 12s ago',
                  ),
                  SizedBox(width: 12.0),
                  _statusDot(
                    Color(0xFFFFA726),
                    'Degraded — latency over 500ms',
                  ),
                  SizedBox(width: 12.0),
                  _statusDot(
                    Color(0xFFEF5350),
                    'Down — last seen 4m ago',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============ SECTION 11: Footguns ============
  print('=== Section 11: Footguns ===');
  final List<Map<String, Object>> footguns = <Map<String, Object>>[
    <String, Object>{
      'title': 'Tooltips inside ListView',
      'icon': Icons.list_alt,
      'color': Color(0xFFEF5350),
      'desc':
          'Each visible row creates a Tooltip widget. For very long lists '
          'this is fine (Tooltip is cheap), but avoid wrapping every cell '
          'in a richMessage with images — the InlineSpan tree rebuilds.',
    },
    <String, Object>{
      'title': 'Semantics duplication',
      'icon': Icons.accessibility_new,
      'color': Color(0xFFFFA726),
      'desc':
          'If your child already has a semantics label (e.g. IconButton), '
          'the tooltip message is announced too — set excludeFromSemantics: '
          'true to avoid duplicate screen-reader output.',
    },
    <String, Object>{
      'title': 'message vs richMessage',
      'icon': Icons.error_outline,
      'color': Color(0xFFAB47BC),
      'desc':
          'These are mutually exclusive. Setting both throws an assertion '
          'error in debug. Pick exactly one.',
    },
    <String, Object>{
      'title': 'waitDuration vs showDuration',
      'icon': Icons.schedule,
      'color': Color(0xFF42A5F5),
      'desc':
          'waitDuration = delay before the bubble appears on hover. '
          'showDuration = how long it stays after the trigger ends. They '
          'are not the same — confusing them yields tooltips that flash '
          'or never disappear.',
    },
    <String, Object>{
      'title': 'Tooltip without child',
      'icon': Icons.warning_amber_outlined,
      'color': Color(0xFF26A69A),
      'desc':
          'A Tooltip with a null child takes zero hit area, so the bubble '
          'will never trigger. Always wrap something interactive.',
    },
  ];
  final footgunCards = <Widget>[];
  for (final f in footguns) {
    footgunCards.add(_footgunCard(
      f['title'] as String,
      f['desc'] as String,
      f['icon'] as IconData,
      f['color'] as Color,
    ));
  }
  final footgunSection = _sectionCard(
    sectionTitle: 'Section 11 — Footguns',
    sectionColor: Color(0xFFEF5350),
    sectionIcon: Icons.warning_amber,
    description:
        'A few non-obvious pitfalls to keep in mind when designing tooltip '
        'behaviour. Each card calls out the cause and the recommended fix.',
    body: Column(children: footgunCards),
  );

  // ============ SECTION 12: Recap card ============
  print('=== Section 12: Recap card ===');
  final recapSection = _sectionCard(
    sectionTitle: 'Section 12 — Quick Reference Recap',
    sectionColor: Color(0xFF1A237E),
    sectionIcon: Icons.bookmark,
    description:
        'A condensed cheat-sheet of the most useful Tooltip parameters and '
        'their defaults. Bookmark this for code reviews.',
    body: Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE8EAF6), Color(0xFFC5CAE9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF1A237E).withValues(alpha: 0.18),
            blurRadius: 10.0,
            offset: Offset(0.0, 6.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _recapRow('message', 'String? — plain text content'),
          _recapRow('richMessage', 'InlineSpan? — styled content (xor message)'),
          _recapRow('verticalOffset', 'double — default 24.0'),
          _recapRow('preferBelow', 'bool — default true (bubble below target)'),
          _recapRow('waitDuration', 'Duration? — hover delay before show'),
          _recapRow('showDuration', 'Duration? — keep visible after release'),
          _recapRow('exitDuration', 'Duration? — pointer-exit fade-out delay'),
          _recapRow('triggerMode', 'TooltipTriggerMode? — longPress/tap/manual'),
          _recapRow('decoration', 'Decoration? — bubble background/border'),
          _recapRow('textStyle', 'TextStyle? — message text style'),
          _recapRow('padding', 'EdgeInsetsGeometry? — inside the bubble'),
          _recapRow('margin', 'EdgeInsetsGeometry? — keep off screen edges'),
          _recapRow('excludeFromSemantics', 'bool — drop semantic label'),
          _recapRow('enableFeedback', 'bool — haptic/audible feedback'),
          _recapRow('height', 'double? — minimum bubble height'),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Color(0xFF1A237E),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              'Rule of thumb: prefer plain message; reach for richMessage '
              'only when styling matters; theme via TooltipThemeData when '
              'all bubbles in your app should look the same.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  print('Tooltip Deep Demo built — sections assembled');

  return Scaffold(
    backgroundColor: Color(0xFFF5F5FA),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          titleBanner,
          anatomyDiagram,
          paramSection,
          plainMessageSection,
          richSection,
          offsetSection,
          stylingSection,
          triggerSection,
          preferBelowSection,
          useCaseSection,
          footgunSection,
          recapSection,
          SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}

// =============================================================
// Helper: banner chip
// =============================================================
Widget _bannerChip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.25),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color.withValues(alpha: 0.7), width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontSize: 12.0,
        fontFamily: 'monospace',
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// =============================================================
// Helper: section card with gradient header + body
// =============================================================
Widget _sectionCard({
  required String sectionTitle,
  required Color sectionColor,
  required IconData sectionIcon,
  required String description,
  required Widget body,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.white,
          sectionColor.withValues(alpha: 0.06),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(
        color: sectionColor.withValues(alpha: 0.35),
        width: 1.2,
      ),
      boxShadow: [
        BoxShadow(
          color: sectionColor.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: sectionColor.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(sectionIcon, color: sectionColor, size: 22.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                sectionTitle,
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w700,
                  color: sectionColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: sectionColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            description,
            style: TextStyle(
              fontSize: 12.5,
              color: Colors.grey.shade800,
              height: 1.35,
            ),
          ),
        ),
        SizedBox(height: 14.0),
        body,
      ],
    ),
  );
}

// =============================================================
// Helper: parameter chip
// =============================================================
Widget _paramChip(String name, String type, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.18),
          color.withValues(alpha: 0.32),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: color,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(width: 6.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 1.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            type,
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.white,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================
// Helper: target with mocked bubble
// =============================================================
Widget _targetWithBubble({
  required IconData icon,
  required String tooltipText,
  required Color accent,
}) {
  return Column(
    children: [
      // mock bubble
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: Color(0xFF263238),
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Text(
          tooltipText,
          style: TextStyle(color: Colors.white, fontSize: 11.0),
        ),
      ),
      Icon(Icons.arrow_drop_down, color: Color(0xFF263238)),
      // real Tooltip wrapping a clickable-looking thing
      Tooltip(
        message: tooltipText,
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            shape: BoxShape.circle,
            border: Border.all(color: accent, width: 1.5),
          ),
          child: Icon(icon, color: accent, size: 26.0),
        ),
      ),
    ],
  );
}

// =============================================================
// Helper: code block
// =============================================================
Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Text(
      code,
      style: TextStyle(
        color: Color(0xFFB2DFDB),
        fontFamily: 'monospace',
        fontSize: 11.0,
        height: 1.4,
      ),
    ),
  );
}

// =============================================================
// Helper: verticalOffset mockup
// =============================================================
Widget _offsetMockup(double offset, String label, Color color) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: Color(0xFF263238),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Text(
          'Hint',
          style: TextStyle(color: Colors.white, fontSize: 11.0),
        ),
      ),
      Container(
        height: offset,
        width: 2.0,
        color: color.withValues(alpha: 0.6),
      ),
      Tooltip(
        message: 'Hint',
        verticalOffset: offset,
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.18),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2.0),
          ),
          child: Icon(Icons.adjust, color: color, size: 22.0),
        ),
      ),
      SizedBox(height: 6.0),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11.0,
            fontFamily: 'monospace',
            color: color,
          ),
        ),
      ),
    ],
  );
}

// =============================================================
// Helper: triggerMode card
// =============================================================
Widget _triggerCard(String mode, String desc, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.12),
          color.withValues(alpha: 0.22),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: color, size: 24.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TooltipTriggerMode.$mode',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontFamily: 'monospace',
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade800,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================
// Helper: preferBelow mockup
// =============================================================
Widget _preferBelowMockup(bool below, Color color) {
  final bubble = Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Text(
      'Hint',
      style: TextStyle(color: Colors.white, fontSize: 11.0),
    ),
  );
  final target = Tooltip(
    message: 'Hint',
    preferBelow: below,
    child: Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2.0),
      ),
      child: Icon(Icons.touch_app, color: color, size: 24.0),
    ),
  );
  return Column(
    children: [
      Text(
        below ? 'preferBelow: true' : 'preferBelow: false',
        style: TextStyle(
          fontSize: 12.0,
          fontFamily: 'monospace',
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
      SizedBox(height: 8.0),
      if (!below) bubble,
      if (!below) Icon(Icons.arrow_drop_down, color: Color(0xFF263238)),
      target,
      if (below) Icon(Icons.arrow_drop_up, color: Color(0xFF263238)),
      if (below) bubble,
    ],
  );
}

// =============================================================
// Helper: status dot
// =============================================================
Widget _statusDot(Color color, String hint) {
  return Tooltip(
    message: hint,
    child: Column(
      children: [
        Container(
          width: 18.0,
          height: 18.0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.6),
                blurRadius: 6.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            hint,
            style: TextStyle(fontSize: 9.0, color: color),
          ),
        ),
      ],
    ),
  );
}

// =============================================================
// Helper: footgun card
// =============================================================
Widget _footgunCard(String title, String desc, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.10),
          color.withValues(alpha: 0.22),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.55), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.15),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(7.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.25),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 22.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade800,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================
// Helper: recap row
// =============================================================
Widget _recapRow(String name, String desc) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 130.0,
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: Color(0xFF1A237E).withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.0,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(
              fontSize: 11.5,
              color: Colors.grey.shade900,
            ),
          ),
        ),
      ],
    ),
  );
}
