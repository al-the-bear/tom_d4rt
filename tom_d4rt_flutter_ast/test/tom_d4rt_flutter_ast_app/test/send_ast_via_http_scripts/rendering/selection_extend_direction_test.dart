// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unnecessary_import
// D4rt deep-visual demo: SelectionExtendDirection enum from package:flutter/rendering.dart
// Values: previousLine, nextLine, forward, backward
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // Static helpers (always-stopped) - keep motion strictly visual
  // ============================================================
  final AlwaysStoppedAnimation<double> animFull =
      AlwaysStoppedAnimation<double>(1.0);
  final AlwaysStoppedAnimation<double> animMid =
      AlwaysStoppedAnimation<double>(0.5);
  final AlwaysStoppedAnimation<double> animLow =
      AlwaysStoppedAnimation<double>(0.25);
  final Duration zeroDur = Duration.zero;

  // ============================================================
  // Per-value visual data records
  // ============================================================
  final List<Map<String, dynamic>> directionData = <Map<String, dynamic>>[
    <String, dynamic>{
      'value': SelectionExtendDirection.previousLine,
      'label': 'previousLine',
      'glyph': '▲',
      'icon': Icons.keyboard_arrow_up,
      'arrow': Icons.north,
      'palette': <Color>[Color(0xFF4F46E5), Color(0xFF7C3AED), Color(0xFFA855F7)],
      'softColor': Color(0xFFEDE9FE),
      'darkColor': Color(0xFF312E81),
      'tagline': 'Up one line',
      'detail':
          'Move one edge of the selection vertically to the previous adjacent line. '
              'Considers both soft and hard line breaks. Pair with dx for horizontal target.',
      'shortcut': 'Shift + ↑',
      'axis': 'vertical',
      'flow': '— previous line ←',
    },
    <String, dynamic>{
      'value': SelectionExtendDirection.nextLine,
      'label': 'nextLine',
      'glyph': '▼',
      'icon': Icons.keyboard_arrow_down,
      'arrow': Icons.south,
      'palette': <Color>[Color(0xFF0EA5E9), Color(0xFF06B6D4), Color(0xFF14B8A6)],
      'softColor': Color(0xFFE0F2FE),
      'darkColor': Color(0xFF0C4A6E),
      'tagline': 'Down one line',
      'detail':
          'Move one edge of the selection vertically to the next adjacent line. '
              'Considers both soft and hard line breaks. dx defines the horizontal landing point.',
      'shortcut': 'Shift + ↓',
      'axis': 'vertical',
      'flow': '→ next line —',
    },
    <String, dynamic>{
      'value': SelectionExtendDirection.forward,
      'label': 'forward',
      'glyph': '▶',
      'icon': Icons.east,
      'arrow': Icons.arrow_forward,
      'palette': <Color>[Color(0xFF16A34A), Color(0xFF22C55E), Color(0xFF84CC16)],
      'softColor': Color(0xFFDCFCE7),
      'darkColor': Color(0xFF14532D),
      'tagline': 'Forward in line',
      'detail':
          'Move the selection edges forward to a horizontal offset in the same line. '
              'When there is no on-going selection, start at first line and select toward dx. '
              'Receivers must return SelectionResult.end.',
      'shortcut': 'Shift + →',
      'axis': 'horizontal',
      'flow': '|====▶',
    },
    <String, dynamic>{
      'value': SelectionExtendDirection.backward,
      'label': 'backward',
      'glyph': '◀',
      'icon': Icons.west,
      'arrow': Icons.arrow_back,
      'palette': <Color>[Color(0xFFE11D48), Color(0xFFF43F5E), Color(0xFFF97316)],
      'softColor': Color(0xFFFFE4E6),
      'darkColor': Color(0xFF881337),
      'tagline': 'Backward in line',
      'detail':
          'Move the selection edges backward to a horizontal offset in the same line. '
              'When there is no on-going selection, start at last line and select backward toward dx. '
              'Receivers must return SelectionResult.end.',
      'shortcut': 'Shift + ←',
      'axis': 'horizontal',
      'flow': '◀====|',
    },
  ];

  // ============================================================
  // SECTION 1 — Hero header banner
  // ============================================================
  final Widget hero = Container(
    margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
    padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 32.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color(0xFF0F172A),
          Color(0xFF1E1B4B),
          Color(0xFF4C1D95),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x664C1D95),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[Color(0xFFA855F7), Color(0xFF22D3EE)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color(0x66A855F7),
                    blurRadius: 18.0,
                    offset: Offset(0.0, 6.0),
                  ),
                ],
              ),
              child: Icon(Icons.text_fields, size: 36.0, color: Colors.white),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'SelectionExtendDirection',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/rendering.dart  •  enum  •  ${SelectionExtendDirection.values.length} values',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Color(0xFFC4B5FD),
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Color(0x55FFFFFF), width: 1.0),
          ),
          child: Text(
            'Describes how a Selectable should extend its selection in response to a '
            'DirectionallyExtendSelectionEvent. Vertical values traverse adjacent '
            'lines; horizontal values move within the same line toward a dx offset.',
            style: TextStyle(
              color: Color(0xFFEDE9FE),
              fontSize: 13.5,
              height: 1.45,
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Row(
          children: <Widget>[
            for (final Map<String, dynamic> d in directionData)
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: d['palette'] as List<Color>,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: (d['palette'] as List<Color>).first.withValues(alpha: 0.5),
                        blurRadius: 8.0,
                        offset: Offset(0.0, 4.0),
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        d['glyph'] as String,
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        d['label'] as String,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2 — Anatomy of selection extension
  // ============================================================
  final Widget anatomy = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Color(0xFFFEF3C7), Color(0xFFFDE68A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFFF59E0B), width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x33F59E0B),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.account_tree, color: Color(0xFF92400E), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Anatomy of a directional extension',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16.0,
                color: Color(0xFF78350F),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFFBEB),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xFFFCD34D), width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _anatomyRow('1.', 'User input', 'Shift + arrow keys / IME / a11y'),
              _anatomyRow('2.', 'Framework dispatch',
                  'DirectionallyExtendSelectionEvent(direction, dx, isEnd)'),
              _anatomyRow('3.', 'Selectable visit',
                  'SelectionContainer routes to active Selectable'),
              _anatomyRow('4.', 'Edge movement',
                  'Edge slides per SelectionExtendDirection value'),
              _anatomyRow('5.', 'Result',
                  'SelectionResult.{pending, next, previous, end, none}'),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          children: <Widget>[
            Expanded(
              child: _anatomyAxisCard(
                'Vertical axis',
                'previousLine • nextLine',
                Icons.swap_vert,
                <Color>[Color(0xFF6366F1), Color(0xFF06B6D4)],
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _anatomyAxisCard(
                'Horizontal axis',
                'forward • backward',
                Icons.swap_horiz,
                <Color>[Color(0xFF22C55E), Color(0xFFE11D48)],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3 — Per-value cards (one per enum value, distinct visuals)
  // ============================================================
  final List<Widget> valueCards = <Widget>[];
  for (final Map<String, dynamic> d in directionData) {
    final SelectionExtendDirection v = d['value'] as SelectionExtendDirection;
    final List<Color> palette = d['palette'] as List<Color>;
    final Color soft = d['softColor'] as Color;
    final Color dark = d['darkColor'] as Color;
    final bool isVertical = (d['axis'] as String) == 'vertical';

    valueCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.0),
          gradient: LinearGradient(
            colors: <Color>[Colors.white, soft],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: palette.first.withValues(alpha: 0.45), width: 1.5),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: palette.first.withValues(alpha: 0.25),
              blurRadius: 16.0,
              offset: Offset(0.0, 8.0),
            ),
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 4.0,
              offset: Offset(0.0, 1.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Header strip with gradient
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: palette,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(17.0),
                  topRight: Radius.circular(17.0),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 56.0,
                    height: 56.0,
                    decoration: BoxDecoration(
                      color: Color(0x33FFFFFF),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.0),
                    ),
                    alignment: Alignment.center,
                    child: Icon(d['icon'] as IconData, color: Colors.white, size: 30.0),
                  ),
                  SizedBox(width: 14.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'SelectionExtendDirection.${d['label']}',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          d['tagline'] as String,
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: Color(0x44FFFFFF),
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.white, width: 1.0),
                    ),
                    child: Text(
                      'index ${v.index}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Body with description + diagram
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    d['detail'] as String,
                    style: TextStyle(
                      color: dark,
                      fontSize: 13.0,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 14.0),
                  Row(
                    children: <Widget>[
                      // Diagram
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 150.0,
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: palette.first.withValues(alpha: 0.4)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: palette.last.withValues(alpha: 0.18),
                                blurRadius: 8.0,
                                offset: Offset(0.0, 4.0),
                              ),
                            ],
                          ),
                          child: isVertical
                              ? _verticalDiagram(v, palette)
                              : _horizontalDiagram(v, palette),
                        ),
                      ),
                      SizedBox(width: 12.0),
                      // Side metadata
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            _miniBadge('axis', d['axis'] as String, palette.first),
                            SizedBox(height: 6.0),
                            _miniBadge('shortcut', d['shortcut'] as String, palette[1]),
                            SizedBox(height: 6.0),
                            _miniBadge('flow', d['flow'] as String, palette.last),
                            SizedBox(height: 6.0),
                            _miniBadge('glyph', d['glyph'] as String, dark),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  // Code-ish representation of dispatch
                  Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: palette.first.withValues(alpha: 0.6), width: 1.0),
                    ),
                    child: Text(
                      'DirectionallyExtendSelectionEvent(\n'
                      '  dx: 142.0,\n'
                      '  isEnd: true,\n'
                      '  direction: SelectionExtendDirection.${d['label']},\n'
                      ')',
                      style: TextStyle(
                        color: palette.last,
                        fontFamily: 'monospace',
                        fontSize: 11.5,
                        height: 1.4,
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
  }

  // ============================================================
  // SECTION 4 — Recipe gallery (common usage patterns)
  // ============================================================
  final Widget recipes = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Color(0xFFE0F2FE), Color(0xFFCFFAFE), Color(0xFFCCFBF1)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Color(0xFF14B8A6), width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x3314B8A6),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.menu_book, color: Color(0xFF115E59), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Recipes & dispatch patterns',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF134E4A),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _recipeBlock(
          'Move caret one line up',
          'previousLine',
          Color(0xFF6366F1),
          'final SelectionExtendDirection dir = SelectionExtendDirection.previousLine;\n'
              'final DirectionallyExtendSelectionEvent ev = DirectionallyExtendSelectionEvent(\n'
              '  dx: caretGlobalDx, isEnd: true, direction: dir,\n'
              ');\n'
              'selectable.dispatchSelectionEvent(ev);',
        ),
        _recipeBlock(
          'Extend selection to next visual line',
          'nextLine',
          Color(0xFF06B6D4),
          'switch (key) {\n'
              '  case LogicalKeyboardKey.arrowDown:\n'
              '    return DirectionallyExtendSelectionEvent(\n'
              '      dx: anchorDx, isEnd: true,\n'
              '      direction: SelectionExtendDirection.nextLine,\n'
              '    );\n'
              '}',
        ),
        _recipeBlock(
          'Forward in line (e.g. Shift + Right)',
          'forward',
          Color(0xFF22C55E),
          'if (event.direction == SelectionExtendDirection.forward) {\n'
              '  edge = moveEdgeHorizontally(edge, targetDx);\n'
              '  return SelectionResult.end;\n'
              '}',
        ),
        _recipeBlock(
          'Backward in line (e.g. Shift + Left)',
          'backward',
          Color(0xFFE11D48),
          'if (event.direction == SelectionExtendDirection.backward) {\n'
              '  edge = moveEdgeHorizontally(edge, targetDx);\n'
              '  return SelectionResult.end;\n'
              '}',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5 — Pitfalls and gotchas
  // ============================================================
  final Widget pitfalls = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Color(0xFFFFE4E6), Color(0xFFFFEDD5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Color(0xFFE11D48), width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x33E11D48),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.warning_amber, color: Color(0xFF9F1239), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls & gotchas',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF881337),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _pitfallItem(
          Icons.linear_scale,
          'Soft vs hard breaks',
          'previousLine and nextLine consider both soft (wrap) and hard (\\n) breaks. '
              'Don\'t collapse them onto paragraphs.',
          Color(0xFFE11D48),
        ),
        _pitfallItem(
          Icons.keyboard_double_arrow_right,
          'forward / backward must end',
          'Selectables receiving forward or backward must return SelectionResult.end. '
              'Returning pending or next can desync the SelectionContainer.',
          Color(0xFFF97316),
        ),
        _pitfallItem(
          Icons.start,
          'No on-going selection?',
          'forward starts at the first line; backward starts at the last line. '
              'Plan dx carefully when bootstrapping.',
          Color(0xFF7C3AED),
        ),
        _pitfallItem(
          Icons.swap_calls,
          'isEnd vs isStart',
          'DirectionallyExtendSelectionEvent.isEnd selects which edge moves. '
              'Direction is independent of which edge is travelling.',
          Color(0xFF0EA5E9),
        ),
        _pitfallItem(
          Icons.compare_arrows,
          'dx is global',
          'dx is in global coordinates. Convert through globalToLocal for per-Selectable layout math.',
          Color(0xFF14B8A6),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6 — Comparison table (all four values across attrs)
  // ============================================================
  final Widget compareTable = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFF8FAFC),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFFCBD5E1), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.table_chart, color: Color(0xFF334155), size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Comparison matrix',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15.0,
                color: Color(0xFF0F172A),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[Color(0xFF1E293B), Color(0xFF334155)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
          ),
          child: Row(
            children: <Widget>[
              _tableHeader('Value', 110.0),
              _tableHeader('Axis', 78.0),
              _tableHeader('Index', 60.0),
              _tableHeader('Glyph', 60.0),
              _tableHeader('Shortcut', 90.0),
            ],
          ),
        ),
        for (int i = 0; i < directionData.length; i++)
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: i.isEven ? Color(0xFFFFFFFF) : Color(0xFFF1F5F9),
              border: Border(
                bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1.0),
              ),
            ),
            child: Row(
              children: <Widget>[
                _tableCell(
                  directionData[i]['label'] as String,
                  110.0,
                  (directionData[i]['palette'] as List<Color>).first,
                  bold: true,
                ),
                _tableCell(
                  directionData[i]['axis'] as String,
                  78.0,
                  Color(0xFF475569),
                ),
                _tableCell(
                  '${(directionData[i]['value'] as SelectionExtendDirection).index}',
                  60.0,
                  Color(0xFF475569),
                  mono: true,
                ),
                _tableCell(
                  directionData[i]['glyph'] as String,
                  60.0,
                  (directionData[i]['palette'] as List<Color>).last,
                  bold: true,
                ),
                _tableCell(
                  directionData[i]['shortcut'] as String,
                  90.0,
                  Color(0xFF475569),
                  mono: true,
                ),
              ],
            ),
          ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7 — Quick reference / cheat sheet
  // ============================================================
  final Widget cheatSheet = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Color(0xFF0F172A), Color(0xFF1E1B4B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x661E1B4B),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.flash_on, color: Color(0xFFFCD34D), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Quick reference',
              style: TextStyle(
                color: Color(0xFFFCD34D),
                fontWeight: FontWeight.w700,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: <Widget>[
            for (final Map<String, dynamic> d in directionData)
              Container(
                width: 220.0,
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      (d['palette'] as List<Color>).first.withValues(alpha: 0.25),
                      (d['palette'] as List<Color>).last.withValues(alpha: 0.15),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: (d['palette'] as List<Color>).first,
                    width: 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          d['glyph'] as String,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(width: 6.0),
                        Text(
                          d['label'] as String,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'monospace',
                            fontSize: 13.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      d['tagline'] as String,
                      style: TextStyle(
                        color: Color(0xFFE0E7FF),
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      d['shortcut'] as String,
                      style: TextStyle(
                        color: Color(0xFFFCD34D),
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0x33FCD34D),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xFFFCD34D), width: 1.0),
          ),
          child: Text(
            'Mnemonic: vertical pair (previousLine ▲ / nextLine ▼) walks lines, '
            'horizontal pair (forward ▶ / backward ◀) slides within the current line.',
            style: TextStyle(
              color: Color(0xFFFEF3C7),
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8 — Index-bar visualization (animated-style bars, static)
  // ============================================================
  final Widget indexBar = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Color(0xFFFAF5FF), Color(0xFFEDE9FE), Color(0xFFE0E7FF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFFA855F7), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x33A855F7),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.bar_chart, color: Color(0xFF6D28D9), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Index ordering (declared order)',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF4C1D95),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            for (final Map<String, dynamic> d in directionData)
              _indexBar(
                d['label'] as String,
                (d['value'] as SelectionExtendDirection).index,
                d['palette'] as List<Color>,
              ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFF5F3FF),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFC4B5FD), width: 1.0),
          ),
          child: Text(
            'Declared order in flutter/rendering: previousLine(0), nextLine(1), forward(2), backward(3).',
            style: TextStyle(
              color: Color(0xFF4C1D95),
              fontFamily: 'monospace',
              fontSize: 11.5,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9 — ASCII / glyph footer
  // ============================================================
  final String asciiArt = '''
+----------------------------+      previousLine
|                            |             ▲
|   The quick brown fox      |             |
|   jumps over the lazy      |  ◀---- forward / backward ----▶
|   dog and selects all      |             |
|   four directions ⇄        |             ▼
+----------------------------+        nextLine
''';

  final Widget footer = Container(
    margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 24.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Color(0xFF111827), Color(0xFF1F2937)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFF374151), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x66000000),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.terminal, color: Color(0xFF22D3EE), size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'ASCII map',
              style: TextStyle(
                color: Color(0xFF22D3EE),
                fontWeight: FontWeight.w700,
                fontSize: 14.0,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          asciiArt,
          style: TextStyle(
            fontFamily: 'monospace',
            color: Color(0xFFE5E7EB),
            fontSize: 12.0,
            height: 1.35,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'SelectionExtendDirection — drives the geometry of selection edges in flutter/rendering.',
          style: TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 11.5,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // Compose final layout
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              hero,
              _sectionTitle('1. Anatomy of a directional selection'),
              anatomy,
              _sectionTitle('2. The four enum values'),
              ...valueCards,
              _sectionTitle('3. Recipes & dispatch patterns'),
              recipes,
              _sectionTitle('4. Pitfalls & gotchas'),
              pitfalls,
              _sectionTitle('5. Comparison matrix'),
              compareTable,
              _sectionTitle('6. Quick reference'),
              cheatSheet,
              _sectionTitle('7. Index ordering'),
              indexBar,
              _sectionTitle('8. ASCII footer'),
              footer,
            ],
          ),
        ),
      ),
    ),
  );
}

// ====================================================================
// Helper widgets
// ====================================================================

Widget _sectionTitle(String text) {
  return Container(
    margin: EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 6.0),
    child: Row(
      children: <Widget>[
        Container(
          width: 5.0,
          height: 22.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[Color(0xFF7C3AED), Color(0xFF06B6D4)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        SizedBox(width: 10.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyRow(String num, String title, String body) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 28.0,
          padding: EdgeInsets.symmetric(vertical: 2.0),
          decoration: BoxDecoration(
            color: Color(0xFFF59E0B),
            borderRadius: BorderRadius.circular(4.0),
          ),
          alignment: Alignment.center,
          child: Text(
            num,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12.5,
                  color: Color(0xFF78350F),
                ),
              ),
              Text(
                body,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Color(0xFF92400E),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyAxisCard(
  String title,
  String values,
  IconData icon,
  List<Color> palette,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          palette.first.withValues(alpha: 0.15),
          palette.last.withValues(alpha: 0.15),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: palette.first, width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: palette.first.withValues(alpha: 0.2),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Icon(icon, color: palette.first, size: 28.0),
        SizedBox(height: 6.0),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12.5,
            color: palette.first,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          values,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: palette.last,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _verticalDiagram(SelectionExtendDirection v, List<Color> palette) {
  final bool up = v == SelectionExtendDirection.previousLine;
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      _diagramLine('Lorem ipsum dolor sit', palette, highlighted: up),
      SizedBox(height: 4.0),
      _diagramLine('amet, consectetur adipiscing', palette, highlighted: false, current: true),
      SizedBox(height: 4.0),
      _diagramLine('elit, sed do eiusmod tempor', palette, highlighted: !up),
      SizedBox(height: 6.0),
      Icon(
        up ? Icons.arrow_upward : Icons.arrow_downward,
        color: palette.first,
        size: 22.0,
      ),
    ],
  );
}

Widget _diagramLine(
  String text,
  List<Color> palette, {
  bool highlighted = false,
  bool current = false,
}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      gradient: highlighted
          ? LinearGradient(
              colors: <Color>[
                palette.first.withValues(alpha: 0.4),
                palette.last.withValues(alpha: 0.2),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            )
          : null,
      color: highlighted ? null : (current ? Color(0xFFF1F5F9) : Colors.transparent),
      borderRadius: BorderRadius.circular(4.0),
      border: current
          ? Border.all(color: palette.last.withValues(alpha: 0.6), width: 1.0)
          : null,
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11.0,
        fontFamily: 'monospace',
        color: highlighted ? palette.last : Color(0xFF334155),
        fontWeight: highlighted ? FontWeight.w700 : FontWeight.w400,
      ),
    ),
  );
}

Widget _horizontalDiagram(SelectionExtendDirection v, List<Color> palette) {
  final bool fwd = v == SelectionExtendDirection.forward;
  // Simulate a single line with a moving caret/range.
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        'The quick brown fox',
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 12.0,
          color: Color(0xFF334155),
        ),
      ),
      SizedBox(height: 8.0),
      Container(
        height: 10.0,
        decoration: BoxDecoration(
          color: Color(0xFFE2E8F0),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          children: <Widget>[
            if (!fwd) Spacer(flex: 2),
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: palette,
                    begin: fwd ? Alignment.centerLeft : Alignment.centerRight,
                    end: fwd ? Alignment.centerRight : Alignment.centerLeft,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: palette.first.withValues(alpha: 0.5),
                      blurRadius: 6.0,
                      offset: Offset(0.0, 2.0),
                    ),
                  ],
                ),
              ),
            ),
            if (fwd) Spacer(flex: 2),
          ],
        ),
      ),
      SizedBox(height: 8.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            fwd ? Icons.arrow_forward : Icons.arrow_back,
            color: palette.first,
            size: 22.0,
          ),
          SizedBox(width: 6.0),
          Text(
            fwd ? 'select to dx →' : '← select to dx',
            style: TextStyle(
              fontSize: 11.0,
              color: palette.last,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _miniBadge(String label, String value, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
    ),
    child: Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 9.0,
              fontWeight: FontWeight.w700,
              color: color,
              fontFamily: 'monospace',
            ),
          ),
        ),
        SizedBox(width: 6.0),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 11.0,
              color: color,
              fontFamily: 'monospace',
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

Widget _recipeBlock(
  String title,
  String tag,
  Color accent,
  String code,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.2),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(9.0),
              topRight: Radius.circular(9.0),
            ),
          ),
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12.5,
                    color: Color(0xFF134E4A),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFF0F172A),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(9.0),
              bottomRight: Radius.circular(9.0),
            ),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFFD1FAE5),
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _pitfallItem(IconData icon, String title, String body, Color accent) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: accent, size: 18.0),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12.5,
                  color: accent,
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 11.5,
                  color: Color(0xFF334155),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _tableHeader(String text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: TextStyle(
        color: Color(0xFFE2E8F0),
        fontWeight: FontWeight.w700,
        fontSize: 11.5,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _tableCell(
  String text,
  double width,
  Color color, {
  bool bold = false,
  bool mono = false,
}) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 11.5,
        fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
        fontFamily: (bold || mono) ? 'monospace' : null,
      ),
    ),
  );
}

Widget _indexBar(String label, int index, List<Color> palette) {
  // Bars stretch with index for a visual ordering cue (static).
  final double height = 36.0 + (index * 18.0);
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      Text(
        '$index',
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 12.0,
          fontWeight: FontWeight.w700,
          color: palette.last,
        ),
      ),
      SizedBox(height: 4.0),
      Container(
        width: 36.0,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: palette,
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: palette.first.withValues(alpha: 0.45),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
      ),
      SizedBox(height: 6.0),
      SizedBox(
        width: 80.0,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.5,
            color: palette.last,
            fontWeight: FontWeight.w700,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}
