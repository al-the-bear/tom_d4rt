// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: hand-authored deep visual demo for Offstage, Visibility,
// IgnorePointer, AbsorbPointer and the visibility/lifecycle widget family
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Top-level builder helpers (no state, all const-friendly where possible).
// ---------------------------------------------------------------------------

Widget _sectionTitle(String label, Color color) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12.0),
        topRight: Radius.circular(12.0),
      ),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.3,
      ),
    ),
  );
}

Widget _sectionSubtitle(String label) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 4.0),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    ),
  );
}

Widget _sectionBody(Widget child) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(12.0),
        bottomRight: Radius.circular(12.0),
      ),
      border: Border.all(color: Colors.black12, width: 1.0),
    ),
    child: child,
  );
}

Widget _explanatoryCard(String title, String body) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF6F9FC),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(0xFFD7E1EC)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A3D5C),
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          body,
          style: TextStyle(fontSize: 12.5, height: 1.4, color: Colors.black87),
        ),
      ],
    ),
  );
}

Widget _legendDot(Color color, String label) {
  return Padding(
    padding: EdgeInsets.only(right: 12.0, bottom: 4.0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 6.0),
        Text(label, style: TextStyle(fontSize: 11.5)),
      ],
    ),
  );
}

Widget _boxLabel(String text, Color color, double width, double height) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x22000000),
          offset: Offset(0.0, 1.0),
          blurRadius: 2.0,
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 12.5,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

Widget _tableCell(String text, {bool header = false, Color? bg, Color? fg}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: bg ?? (header ? Color(0xFF334E68) : Colors.white),
      border: Border.all(color: Color(0xFFDADADA), width: 0.5),
    ),
    alignment: Alignment.center,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11.0,
        color: fg ?? (header ? Colors.white : Colors.black87),
        fontWeight: header ? FontWeight.bold : FontWeight.normal,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

// ---------------------------------------------------------------------------
// MAIN BUILD ENTRY
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('==========================================================');
  print('Offstage / Visibility / Opacity / IgnorePointer / AbsorbPointer');
  print('deep visual demo - executing build()');
  print('==========================================================');

  // =========================================================================
  // SECTION 1 - OFFSTAGE SIDE BY SIDE
  // =========================================================================
  print('--- Section 1: Offstage side-by-side ---');

  final offstageHidden = Offstage(
    offstage: true,
    child: _boxLabel('OFFSTAGE\ntrue', Colors.indigo, 140.0, 70.0),
  );

  final offstageVisible = Offstage(
    offstage: false,
    child: _boxLabel('OFFSTAGE\nfalse', Colors.indigo, 140.0, 70.0),
  );

  final offstageDefault = Offstage(
    child: _boxLabel(
      'OFFSTAGE\ndefault (true)',
      Colors.deepPurple,
      140.0,
      70.0,
    ),
  );

  final offstageNested = Offstage(
    offstage: false,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _boxLabel('OUTER false', Colors.teal, 200.0, 36.0),
        SizedBox(height: 4.0),
        Offstage(
          offstage: true,
          child: _boxLabel('INNER true', Colors.red, 200.0, 36.0),
        ),
        SizedBox(height: 4.0),
        _boxLabel('AFTER inner', Colors.teal, 200.0, 36.0),
      ],
    ),
  );

  final section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _explanatoryCard(
        'Offstage essentials',
        'Offstage(offstage: true) keeps the subtree mounted (state retained, '
            'controllers alive), still runs build/layout for measurement, but '
            'paints nothing and takes no space (size becomes Size.zero in the '
            'parent). offstage: false makes it behave like a transparent '
            'pass-through.',
      ),
      _sectionSubtitle('offstage:true vs offstage:false (in a Row)'),
      Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(8.0),
          color: Color(0xFFFAFAFA),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text('hidden', style: TextStyle(fontSize: 11.0)),
                SizedBox(height: 4.0),
                Container(
                  width: 140.0,
                  height: 70.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 1.0),
                    color: Color(0xFFEFEFEF),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        '(nothing visible here)',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.black45,
                        ),
                      ),
                      offstageHidden,
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text('visible', style: TextStyle(fontSize: 11.0)),
                SizedBox(height: 4.0),
                offstageVisible,
              ],
            ),
            Column(
              children: [
                Text('default', style: TextStyle(fontSize: 11.0)),
                SizedBox(height: 4.0),
                Container(
                  width: 140.0,
                  height: 70.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 1.0),
                    color: Color(0xFFEFEFEF),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        '(default hides)',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.black45,
                        ),
                      ),
                      offstageDefault,
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(height: 8.0),
      _sectionSubtitle('Nested Offstage (outer false, inner true)'),
      offstageNested,
      _explanatoryCard(
        'Lifecycle vs. layout',
        'Even when offstage: true, the inner subtree still has its build() '
            'called and its State (if any) preserved. This is why Offstage is '
            'used to keep tabs alive while hiding them - the state is not '
            'thrown away the way it is with conditional return of SizedBox.shrink().',
      ),
    ],
  );

  // =========================================================================
  // SECTION 2 - VISIBILITY FLAG MATRIX
  // =========================================================================
  print('--- Section 2: Visibility flag matrix (8 rows) ---');

  // Eight rows showcasing combinations of visible/maintain* flags.
  // Note: maintainState/Animation/Size/Semantics/Interactivity have constraints:
  //   - maintainSize requires maintainAnimation && maintainState
  //   - maintainAnimation requires maintainState
  //   - maintainSemantics / maintainInteractivity require maintainSize
  // We pick valid combinations only.

  final vis1 = Visibility(
    visible: true,
    child: _boxLabel('visible:true', Colors.green, 240.0, 30.0),
  );

  final vis2 = Visibility(
    visible: false,
    child: _boxLabel('visible:false (default replacement)', Colors.green, 240.0,
        30.0),
    replacement: Container(
      width: 240.0,
      height: 30.0,
      color: Color(0xFFE8E8E8),
      alignment: Alignment.center,
      child: Text(
        '<replacement: SizedBox.shrink-like>',
        style: TextStyle(fontSize: 11.0, color: Colors.black54),
      ),
    ),
  );

  final vis3 = Visibility(
    visible: false,
    maintainState: true,
    child: _boxLabel('vis:false + maintainState', Colors.orange, 240.0, 30.0),
    replacement: Container(
      width: 240.0,
      height: 30.0,
      color: Color(0xFFFFE0B2),
      alignment: Alignment.center,
      child: Text(
        'state kept, no paint, no space',
        style: TextStyle(fontSize: 11.0, color: Colors.brown),
      ),
    ),
  );

  final vis4 = Visibility(
    visible: false,
    maintainState: true,
    maintainAnimation: true,
    child: _boxLabel('+ maintainAnimation', Colors.amber, 240.0, 30.0),
    replacement: Container(
      width: 240.0,
      height: 30.0,
      color: Color(0xFFFFF59D),
      alignment: Alignment.center,
      child: Text(
        'animations tick, no paint, no space',
        style: TextStyle(fontSize: 11.0, color: Colors.brown),
      ),
    ),
  );

  final vis5 = Visibility(
    visible: false,
    maintainState: true,
    maintainAnimation: true,
    maintainSize: true,
    child: _boxLabel(
      '+ maintainSize (keeps box space)',
      Colors.deepOrange,
      240.0,
      30.0,
    ),
  );

  final vis6 = Visibility(
    visible: false,
    maintainState: true,
    maintainAnimation: true,
    maintainSize: true,
    maintainSemantics: true,
    child: _boxLabel('+ maintainSemantics', Colors.purple, 240.0, 30.0),
  );

  final vis7 = Visibility(
    visible: false,
    maintainState: true,
    maintainAnimation: true,
    maintainSize: true,
    maintainInteractivity: true,
    child: _boxLabel(
      '+ maintainInteractivity (clickable invisible)',
      Colors.pink,
      240.0,
      30.0,
    ),
  );

  final vis8 = Visibility.maintain(
    visible: false,
    child: _boxLabel(
      'Visibility.maintain(false) - all flags on',
      Colors.blueGrey,
      240.0,
      30.0,
    ),
  );

  Widget visibilityRow(String label, Widget visWidget, String layoutNote) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 160.0,
            child: Text(label,
                style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w500)),
          ),
          Expanded(child: visWidget),
          SizedBox(width: 8.0),
          SizedBox(
            width: 110.0,
            child: Text(layoutNote,
                style: TextStyle(fontSize: 10.5, color: Colors.black54)),
          ),
        ],
      ),
    );
  }

  final visibilityMatrix = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _explanatoryCard(
        'Visibility flag matrix',
        'Visibility has six knobs. They form a dependency chain: '
            'maintainSize requires maintainAnimation, which requires '
            'maintainState. maintainSemantics and maintainInteractivity '
            'require maintainSize. The default replacement is '
            'SizedBox.shrink(). Pick the smallest set of flags that matches '
            'your needed behavior.',
      ),
      SizedBox(height: 6.0),
      Row(
        children: [
          _legendDot(Colors.green, 'visible'),
          _legendDot(Colors.orange, 'state only'),
          _legendDot(Colors.amber, '+ animation'),
          _legendDot(Colors.deepOrange, '+ size'),
          _legendDot(Colors.purple, '+ semantics'),
          _legendDot(Colors.pink, '+ interactivity'),
          _legendDot(Colors.blueGrey, '.maintain()'),
        ],
      ),
      SizedBox(height: 8.0),
      visibilityRow('1) visible:true', vis1, 'shows normally'),
      visibilityRow('2) visible:false', vis2, 'replaced, no space if shrink'),
      visibilityRow('3) +maintainState', vis3, 'state kept'),
      visibilityRow('4) +maintainAnimation', vis4, 'tickers run'),
      visibilityRow('5) +maintainSize', vis5, 'keeps box space'),
      visibilityRow('6) +maintainSemantics', vis6, 'a11y tree present'),
      visibilityRow('7) +maintainInteractivity', vis7, 'hit-test alive'),
      visibilityRow('8) Visibility.maintain', vis8, 'fully maintained'),
      SizedBox(height: 8.0),
      _explanatoryCard(
        'Hidden but heavy?',
        'Maintaining more flags = the subtree is doing more work while '
            'invisible. For long-lived but rarely-shown subtrees with '
            'expensive build cost, prefer Offstage; for short flips, '
            'Visibility.maintain is often the simplest choice.',
      ),
    ],
  );

  // =========================================================================
  // SECTION 3 - VISIBILITY MATRIX AS TABLE
  // =========================================================================
  print('--- Section 3: Visibility matrix as table (paint/layout/hit/sem) ---');

  Widget tableRow(List<Widget> cells) {
    return Row(
      children: [
        for (var i = 0; i < cells.length; i = i + 1) Expanded(child: cells[i]),
      ],
    );
  }

  final visibilityTable = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _explanatoryCard(
        'Behavioral truth table',
        'For each Visibility configuration, the table shows whether the '
            'subtree participates in: PAINT (visible pixels), LAYOUT '
            '(consumes parent space), HIT (responds to pointers), SEM '
            '(announced to screen readers), STATE (State objects preserved), '
            'and ANIM (Ticker/AnimationController continues).',
      ),
      SizedBox(height: 6.0),
      tableRow([
        _tableCell('Config', header: true),
        _tableCell('Paint', header: true),
        _tableCell('Layout', header: true),
        _tableCell('Hit', header: true),
        _tableCell('Sem', header: true),
        _tableCell('State', header: true),
        _tableCell('Anim', header: true),
      ]),
      tableRow([
        _tableCell('visible:true'),
        _tableCell('YES'),
        _tableCell('YES'),
        _tableCell('YES'),
        _tableCell('YES'),
        _tableCell('YES'),
        _tableCell('YES'),
      ]),
      tableRow([
        _tableCell('visible:false'),
        _tableCell('no'),
        _tableCell('shrink'),
        _tableCell('no'),
        _tableCell('no'),
        _tableCell('no'),
        _tableCell('no'),
      ]),
      tableRow([
        _tableCell('+maintainState'),
        _tableCell('no'),
        _tableCell('shrink'),
        _tableCell('no'),
        _tableCell('no'),
        _tableCell('YES'),
        _tableCell('no'),
      ]),
      tableRow([
        _tableCell('+animation'),
        _tableCell('no'),
        _tableCell('shrink'),
        _tableCell('no'),
        _tableCell('no'),
        _tableCell('YES'),
        _tableCell('YES'),
      ]),
      tableRow([
        _tableCell('+size'),
        _tableCell('no'),
        _tableCell('YES'),
        _tableCell('no'),
        _tableCell('no'),
        _tableCell('YES'),
        _tableCell('YES'),
      ]),
      tableRow([
        _tableCell('+semantics'),
        _tableCell('no'),
        _tableCell('YES'),
        _tableCell('no'),
        _tableCell('YES'),
        _tableCell('YES'),
        _tableCell('YES'),
      ]),
      tableRow([
        _tableCell('+interactivity'),
        _tableCell('no'),
        _tableCell('YES'),
        _tableCell('YES'),
        _tableCell('no'),
        _tableCell('YES'),
        _tableCell('YES'),
      ]),
      tableRow([
        _tableCell('.maintain'),
        _tableCell('no'),
        _tableCell('YES'),
        _tableCell('YES'),
        _tableCell('YES'),
        _tableCell('YES'),
        _tableCell('YES'),
      ]),
      tableRow([
        _tableCell('Offstage:true', bg: Color(0xFFEDE7F6)),
        _tableCell('no', bg: Color(0xFFEDE7F6)),
        _tableCell('shrink', bg: Color(0xFFEDE7F6)),
        _tableCell('no', bg: Color(0xFFEDE7F6)),
        _tableCell('no', bg: Color(0xFFEDE7F6)),
        _tableCell('YES', bg: Color(0xFFEDE7F6)),
        _tableCell('YES', bg: Color(0xFFEDE7F6)),
      ]),
      tableRow([
        _tableCell('Opacity:0.0', bg: Color(0xFFE0F2F1)),
        _tableCell('no*', bg: Color(0xFFE0F2F1)),
        _tableCell('YES', bg: Color(0xFFE0F2F1)),
        _tableCell('YES', bg: Color(0xFFE0F2F1)),
        _tableCell('YES', bg: Color(0xFFE0F2F1)),
        _tableCell('YES', bg: Color(0xFFE0F2F1)),
        _tableCell('YES', bg: Color(0xFFE0F2F1)),
      ]),
      SizedBox(height: 4.0),
      Text(
        '* Opacity(0.0) still rasterizes into a save-layer; prefer Visibility '
        'for fully-hidden children.',
        style: TextStyle(fontSize: 10.5, color: Colors.black54),
      ),
    ],
  );

  // =========================================================================
  // SECTION 4 - OPACITY LADDER
  // =========================================================================
  print('--- Section 4: Opacity ladder 0.0 -> 1.0 ---');

  // Hand-built ladder (no loops over Flutter collections); manual rungs.
  final opacityRungs = <double>[
    0.0,
    0.1,
    0.2,
    0.3,
    0.4,
    0.5,
    0.6,
    0.7,
    0.8,
    0.9,
    1.0,
  ];

  final opacityRungWidgets = <Widget>[];
  for (var i = 0; i < opacityRungs.length; i = i + 1) {
    final t = opacityRungs[i];
    // Tween.transform demo (no AnimationController):
    final colorTween = ColorTween(begin: Colors.red, end: Colors.green);
    final c = colorTween.transform(t) ?? Colors.grey;
    opacityRungWidgets.add(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 3.0),
        child: Row(
          children: [
            SizedBox(
              width: 56.0,
              child: Text(
                'op=${t.toStringAsFixed(1)}',
                style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Opacity(
                opacity: t,
                child: Container(
                  height: 22.0,
                  decoration: BoxDecoration(
                    color: c,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Opacity rung @ ${t.toStringAsFixed(1)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final opacityLadder = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _explanatoryCard(
        'Opacity ladder',
        'Opacity wraps the subtree in a save-layer (or ColorFilter at the '
            'engine level) and blends the rasterized output. Even at 0.0 '
            'the subtree paints, lays out, and hit-tests. For invisible '
            'children prefer Visibility/Offstage. For animated fades prefer '
            'AnimatedOpacity or FadeTransition - they avoid rebuilding the '
            'subtree on every frame.',
      ),
      SizedBox(height: 6.0),
      Column(children: opacityRungWidgets),
      SizedBox(height: 6.0),
      _explanatoryCard(
        'Color tween via .transform(t)',
        'The ladder also demonstrates ColorTween(begin:red, end:green) '
            '.transform(t) without any AnimationController - a pure pull-based '
            'sample of the tween. This is the d4rt-friendly pattern.',
      ),
    ],
  );

  // =========================================================================
  // SECTION 5 - IGNOREPOINTER vs ABSORBPOINTER
  // =========================================================================
  print('--- Section 5: IgnorePointer vs AbsorbPointer ---');

  // Three side-by-side stacks: bare, IgnorePointer wrapping top, AbsorbPointer
  // wrapping top. Underneath, a button labeled "below" simulates a child that
  // sits beneath in a Stack.
  Widget pointerStack(String topLabel, Widget? wrapper) {
    final topButton = ElevatedButton(
      onPressed: () {
        print('TOP button tapped (would fire if not blocked)');
      },
      child: Text(topLabel),
    );
    final top = wrapper ?? topButton;
    return SizedBox(
      width: 180.0,
      height: 120.0,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFE7B5),
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.circular(6.0),
              ),
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextButton(
                onPressed: () {
                  print('BELOW button tapped');
                },
                child: Text(
                  'below',
                  style: TextStyle(color: Colors.brown),
                ),
              ),
            ),
          ),
          Align(alignment: Alignment.topCenter, child: top),
        ],
      ),
    );
  }

  final pointerBare = pointerStack('bare', null);
  final pointerIgnore = pointerStack(
    'ignored',
    IgnorePointer(
      ignoring: true,
      child: ElevatedButton(
        onPressed: () {
          print('this never fires - ignored');
        },
        child: Text('ignored'),
      ),
    ),
  );
  final pointerAbsorb = pointerStack(
    'absorbed',
    AbsorbPointer(
      absorbing: true,
      child: ElevatedButton(
        onPressed: () {
          print('this never fires - absorbed');
        },
        child: Text('absorbed'),
      ),
    ),
  );

  final pointerSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _explanatoryCard(
        'IgnorePointer vs AbsorbPointer',
        'IgnorePointer: the subtree is transparent to hit-testing. Pointers '
            'pass through to widgets below. AbsorbPointer: the subtree '
            'consumes pointers itself (no child callback fires), but pointers '
            'DO NOT reach widgets below either. Both leave paint, layout, '
            'state and animations untouched.',
      ),
      SizedBox(height: 6.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text('Bare', style: TextStyle(fontSize: 11.0)),
              SizedBox(height: 4.0),
              pointerBare,
            ],
          ),
          Column(
            children: [
              Text('IgnorePointer', style: TextStyle(fontSize: 11.0)),
              SizedBox(height: 4.0),
              pointerIgnore,
            ],
          ),
          Column(
            children: [
              Text('AbsorbPointer', style: TextStyle(fontSize: 11.0)),
              SizedBox(height: 4.0),
              pointerAbsorb,
            ],
          ),
        ],
      ),
      SizedBox(height: 6.0),
      Row(
        children: [
          Expanded(
            child: _explanatoryCard(
              'When pointers go through',
              'Use IgnorePointer to "disable" a layer visually but allow the '
                  'background to remain interactive (e.g. a faded preview '
                  'overlay that should not steal taps).',
            ),
          ),
          SizedBox(width: 6.0),
          Expanded(
            child: _explanatoryCard(
              'When pointers are eaten',
              'Use AbsorbPointer to fully disable interaction inside a region '
                  'while still blocking the background (e.g. a modal-like '
                  'busy state).',
            ),
          ),
        ],
      ),
    ],
  );

  // =========================================================================
  // SECTION 6 - EXCLUDESEMANTICS + SEMANTIC TREE MOCK
  // =========================================================================
  print('--- Section 6: ExcludeSemantics with semantic-tree mock ---');

  Widget semNode(String label, {bool excluded = false, double indent = 0.0}) {
    return Padding(
      padding: EdgeInsets.only(left: indent, top: 2.0, bottom: 2.0),
      child: Row(
        children: [
          Icon(
            excluded ? Icons.visibility_off : Icons.label_important_outline,
            size: 14.0,
            color: excluded ? Colors.grey : Colors.indigo,
          ),
          SizedBox(width: 6.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.5,
              color: excluded ? Colors.grey : Colors.black87,
              decoration:
                  excluded ? TextDecoration.lineThrough : TextDecoration.none,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  final excludeCard = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.black26),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: ExcludeSemantics(
      excluding: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Decorative card',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.0),
          Text(
            'These visuals are hidden from screen readers. The subtree still '
            'paints; only the semantics tree skips it.',
            style: TextStyle(fontSize: 12.0),
          ),
          SizedBox(height: 6.0),
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 18.0),
              Icon(Icons.star, color: Colors.amber, size: 18.0),
              Icon(Icons.star, color: Colors.amber, size: 18.0),
              Icon(Icons.star_border, color: Colors.amber, size: 18.0),
              Icon(Icons.star_border, color: Colors.amber, size: 18.0),
            ],
          ),
        ],
      ),
    ),
  );

  final semanticsTree = Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5FA),
      border: Border.all(color: Colors.black26),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mock semantics tree (what TalkBack/VoiceOver sees):',
          style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6.0),
        semNode('Scaffold'),
        semNode('Section: Offstage demo', indent: 16.0),
        semNode('Section: Visibility matrix', indent: 16.0),
        semNode('Section: Opacity ladder', indent: 16.0),
        semNode('Section: Pointer wrappers', indent: 16.0),
        semNode('Section: ExcludeSemantics demo', indent: 16.0),
        semNode('(excluded) Decorative card title', excluded: true, indent: 32.0),
        semNode('(excluded) star icons', excluded: true, indent: 32.0),
        semNode('(excluded) descriptive text', excluded: true, indent: 32.0),
        semNode('Section: Lifecycle vs layout summary', indent: 16.0),
      ],
    ),
  );

  final semanticsSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _explanatoryCard(
        'ExcludeSemantics',
        'ExcludeSemantics(excluding: true) prunes the subtree from the '
            'semantics tree. Paint, layout, hit-testing, and state all stay '
            'normal - only the accessibility tree skips it. Inverse: '
            'MergeSemantics (collapse children into one node). Cousin: '
            'BlockSemantics (replace siblings).',
      ),
      SizedBox(height: 6.0),
      excludeCard,
      SizedBox(height: 8.0),
      semanticsTree,
    ],
  );

  // =========================================================================
  // SECTION 7 - LIFECYCLE vs LAYOUT COMPARISON
  // =========================================================================
  print('--- Section 7: Lifecycle vs layout summary ---');

  Widget compareCell(String title, String paint, String layout, String hit,
      String sem, String state, String anim) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Color(0xFFFAFAFC),
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A237E),
            ),
          ),
          SizedBox(height: 4.0),
          Text('paint   : $paint', style: TextStyle(fontSize: 11.0)),
          Text('layout  : $layout', style: TextStyle(fontSize: 11.0)),
          Text('hit-test: $hit', style: TextStyle(fontSize: 11.0)),
          Text('semantic: $sem', style: TextStyle(fontSize: 11.0)),
          Text('state   : $state', style: TextStyle(fontSize: 11.0)),
          Text('anim    : $anim', style: TextStyle(fontSize: 11.0)),
        ],
      ),
    );
  }

  final comparisonGrid = Wrap(
    spacing: 8.0,
    runSpacing: 8.0,
    children: [
      SizedBox(
        width: 240.0,
        child: compareCell(
          'Offstage(offstage:true)',
          'no',
          'no space',
          'no',
          'no',
          'KEPT',
          'KEPT',
        ),
      ),
      SizedBox(
        width: 240.0,
        child: compareCell(
          'Visibility(visible:false)',
          'no',
          'shrink',
          'no',
          'no',
          'lost',
          'lost',
        ),
      ),
      SizedBox(
        width: 240.0,
        child: compareCell(
          'Visibility.maintain',
          'no',
          'KEEPS',
          'KEPT',
          'KEPT',
          'KEPT',
          'KEPT',
        ),
      ),
      SizedBox(
        width: 240.0,
        child: compareCell(
          'Opacity(0.0)',
          'no*',
          'KEEPS',
          'KEPT',
          'KEPT',
          'KEPT',
          'KEPT',
        ),
      ),
      SizedBox(
        width: 240.0,
        child: compareCell(
          'IgnorePointer',
          'KEEPS',
          'KEEPS',
          'PASSES',
          'KEPT',
          'KEPT',
          'KEPT',
        ),
      ),
      SizedBox(
        width: 240.0,
        child: compareCell(
          'AbsorbPointer',
          'KEEPS',
          'KEEPS',
          'EATEN',
          'KEPT',
          'KEPT',
          'KEPT',
        ),
      ),
      SizedBox(
        width: 240.0,
        child: compareCell(
          'ExcludeSemantics',
          'KEEPS',
          'KEEPS',
          'KEPT',
          'no',
          'KEPT',
          'KEPT',
        ),
      ),
      SizedBox(
        width: 240.0,
        child: compareCell(
          'Conditional (if false)',
          'gone',
          'gone',
          'gone',
          'gone',
          'lost',
          'lost',
        ),
      ),
    ],
  );

  final lifecycleSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _explanatoryCard(
        'Decision matrix',
        'Pick the widget by what you must preserve. If the child holds '
            'expensive state, never use a conditional - that throws State '
            'objects away. If you also need its layout box (e.g. for scroll '
            'positions), use Visibility.maintain. If you just need to hide '
            'pixels temporarily but keep the tab alive, Offstage is the '
            'cheapest option.',
      ),
      SizedBox(height: 8.0),
      comparisonGrid,
      SizedBox(height: 8.0),
      _explanatoryCard(
        'Choosing in practice',
        '- Tab page that should not rebuild on switch  -> Offstage.\n'
            '- Hidden form field that must still validate  -> '
            'Visibility.maintain.\n'
            '- Disabled overlay that lets clicks through  -> IgnorePointer.\n'
            '- Modal busy curtain                          -> AbsorbPointer.\n'
            '- Decorative star ratings under a label      -> ExcludeSemantics.\n'
            '- Cross-fade between two real layouts        -> AnimatedCrossFade.',
      ),
    ],
  );

  // =========================================================================
  // SECTION 8 - INTERACTION CHEAT-SHEET (pointer + visibility combined)
  // =========================================================================
  print('--- Section 8: Combined cheat-sheet ---');

  Widget combo(String title, Widget child) {
    return Container(
      width: 220.0,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6.0),
          child,
        ],
      ),
    );
  }

  final comboOffstageBtn = combo(
    'Offstage(true) + Button',
    Offstage(
      offstage: true,
      child: ElevatedButton(
        onPressed: () {
          print('hidden button (never seen)');
        },
        child: Text('hidden btn'),
      ),
    ),
  );

  final comboVisInteract = combo(
    'Vis(false) + maintainInteractivity',
    Visibility(
      visible: false,
      maintainState: true,
      maintainAnimation: true,
      maintainSize: true,
      maintainInteractivity: true,
      child: ElevatedButton(
        onPressed: () {
          print('invisible but tappable');
        },
        child: Text('invisible tap'),
      ),
    ),
  );

  final comboOpacityZero = combo(
    'Opacity(0.0) + Button',
    Opacity(
      opacity: 0.0,
      child: ElevatedButton(
        onPressed: () {
          print('opacity-zero button (still tappable)');
        },
        child: Text('opacity 0 btn'),
      ),
    ),
  );

  final comboIgnoreOpacity = combo(
    'Opacity(0.3) + IgnorePointer',
    IgnorePointer(
      ignoring: true,
      child: Opacity(
        opacity: 0.3,
        child: ElevatedButton(
          onPressed: () {
            print('never fires (ignored)');
          },
          child: Text('faded + ignored'),
        ),
      ),
    ),
  );

  final comboAbsorbVisible = combo(
    'AbsorbPointer + visible child',
    AbsorbPointer(
      absorbing: true,
      child: ElevatedButton(
        onPressed: () {
          print('eaten by AbsorbPointer');
        },
        child: Text('eaten btn'),
      ),
    ),
  );

  final comboExcludeSem = combo(
    'ExcludeSemantics + IconBtn',
    ExcludeSemantics(
      excluding: true,
      child: IconButton(
        icon: Icon(Icons.favorite, color: Colors.pink),
        onPressed: () {
          print('decorative heart');
        },
      ),
    ),
  );

  final cheatsheet = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _explanatoryCard(
        'Combinations cheat-sheet',
        'These six tiles show common combinations of visibility and '
            'pointer wrappers around an interactive child. The print() '
            'statements in their callbacks document expected behavior even '
            'though, in this static build(), no taps are simulated.',
      ),
      SizedBox(height: 6.0),
      Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: [
          comboOffstageBtn,
          comboVisInteract,
          comboOpacityZero,
          comboIgnoreOpacity,
          comboAbsorbVisible,
          comboExcludeSem,
        ],
      ),
    ],
  );

  // =========================================================================
  // SECTION 9 - FINAL TAKEAWAYS
  // =========================================================================
  print('--- Section 9: Final takeaways ---');

  final takeaways = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFDE7),
      border: Border.all(color: Color(0xFFFFE082)),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key takeaways',
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6.0),
        Text(
          '1. Offstage hides paint AND layout, keeps lifecycle. Default '
          'offstage = true.',
          style: TextStyle(fontSize: 12.0),
        ),
        Text(
          '2. Visibility has six knobs; flags form a chain '
          '(state -> animation -> size -> {semantics, interactivity}).',
          style: TextStyle(fontSize: 12.0),
        ),
        Text(
          '3. Visibility.maintain is the "keep everything but pixels" '
          'shortcut.',
          style: TextStyle(fontSize: 12.0),
        ),
        Text(
          '4. Opacity 0.0 is not free: subtree still paints, lays out, and '
          'hit-tests. Use Visibility/Offstage to truly hide.',
          style: TextStyle(fontSize: 12.0),
        ),
        Text(
          '5. IgnorePointer = transparent to taps; AbsorbPointer = eats taps. '
          'Pick by what should happen to widgets below.',
          style: TextStyle(fontSize: 12.0),
        ),
        Text(
          '6. ExcludeSemantics prunes only the a11y tree; everything else '
          'stays normal. Pair with decorative imagery.',
          style: TextStyle(fontSize: 12.0),
        ),
        Text(
          '7. A conditional (if-false return) throws away State; that is '
          'usually what you DO NOT want for long-lived subtrees.',
          style: TextStyle(fontSize: 12.0),
        ),
      ],
    ),
  );

  // =========================================================================
  // ASSEMBLE THE FINAL TREE
  // =========================================================================
  print('Assembling final widget tree...');

  final body = ListView(
    padding: EdgeInsets.all(12.0),
    children: [
      _sectionTitle('1. Offstage side-by-side', Colors.indigo),
      _sectionBody(section1),
      SizedBox(height: 16.0),
      _sectionTitle('2. Visibility flag matrix (8 rows)', Colors.deepPurple),
      _sectionBody(visibilityMatrix),
      SizedBox(height: 16.0),
      _sectionTitle('3. Behavioral truth table', Colors.teal),
      _sectionBody(visibilityTable),
      SizedBox(height: 16.0),
      _sectionTitle('4. Opacity ladder (0.0 -> 1.0)', Colors.deepOrange),
      _sectionBody(opacityLadder),
      SizedBox(height: 16.0),
      _sectionTitle('5. IgnorePointer vs AbsorbPointer', Colors.brown),
      _sectionBody(pointerSection),
      SizedBox(height: 16.0),
      _sectionTitle('6. ExcludeSemantics + a11y tree mock', Colors.blueGrey),
      _sectionBody(semanticsSection),
      SizedBox(height: 16.0),
      _sectionTitle('7. Lifecycle vs layout decision matrix', Colors.indigo),
      _sectionBody(lifecycleSection),
      SizedBox(height: 16.0),
      _sectionTitle('8. Combinations cheat-sheet', Colors.deepPurple),
      _sectionBody(cheatsheet),
      SizedBox(height: 16.0),
      _sectionTitle('9. Takeaways', Colors.green),
      _sectionBody(takeaways),
      SizedBox(height: 24.0),
      Center(
        child: Text(
          'end of demo - d4rt visibility/lifecycle family',
          style: TextStyle(
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
            color: Colors.black54,
          ),
        ),
      ),
      SizedBox(height: 24.0),
    ],
  );

  print('Build complete - returning Scaffold');

  return Scaffold(
    backgroundColor: Color(0xFFF1F4F8),
    appBar: AppBar(
      title: Text('Offstage / Visibility / Pointer / Semantics'),
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
    ),
    body: body,
  );
}
