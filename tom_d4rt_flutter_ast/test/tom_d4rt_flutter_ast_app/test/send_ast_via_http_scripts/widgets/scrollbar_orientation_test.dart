// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';

/// Deep visual demo — ScrollbarOrientation
///
/// ScrollbarOrientation is an enum that specifies where a scrollbar
/// is placed relative to its scroll view. It has four values: left,
/// right, top, and bottom. This is used by RawScrollbar (and its
/// Material/Cupertino descendants) to determine scrollbar placement.
///
/// Sections
/// ─────────
/// 1. What is ScrollbarOrientation?
/// 2. Enum values and their semantics
/// 3. Relationship with scroll direction
/// 4. Live: orientation switcher with vertical content
/// 5. Live: horizontal scrollbar positioning
/// 6. Live: all four orientations in a grid
/// 7. Best practices

// ─── palette ───────────────────────────────────────────────
const _kTeal       = Color(0xFF009688);
const _kTealLight  = Color(0xFFB2DFDB);
const _kTealDark   = Color(0xFF004D40);
const _kPink       = Color(0xFFE91E63);
const _kPinkLight  = Color(0xFFFCE4EC);
const _kPinkDark   = Color(0xFF880E4F);
const _kSurface    = Color(0xFFFBFBFD);
const _kDivider    = Color(0xFFE0E0E0);
const _kTextDark   = Color(0xFF212121);
const _kTextMuted  = Color(0xFF757575);

// ─── enum value details ────────────────────────────────────
class _EnumDetail {
  const _EnumDetail(this.name, this.icon, this.description, this.useCase);
  final String name;
  final IconData icon;
  final String description;
  final String useCase;
}

const _kEnumValues = <_EnumDetail>[
  _EnumDetail(
    'ScrollbarOrientation.left',
    Icons.arrow_back,
    'Places the scrollbar on the left side of the scroll view. '
    'Used with vertical scroll directions.',
    'RTL layouts where the scrollbar should appear on the leading edge, '
    'or custom layouts where left-side scrollbar is preferred.',
  ),
  _EnumDetail(
    'ScrollbarOrientation.right',
    Icons.arrow_forward,
    'Places the scrollbar on the right side of the scroll view. '
    'This is the default for vertical scrolling.',
    'Standard LTR vertical scroll views. Most common orientation. '
    'No explicit setting needed when using default Material Scrollbar.',
  ),
  _EnumDetail(
    'ScrollbarOrientation.top',
    Icons.arrow_upward,
    'Places the scrollbar at the top of the scroll view. '
    'Used with horizontal scroll directions.',
    'Horizontal carousels, image galleries, or timeline views where '
    'the scrollbar should appear above the content.',
  ),
  _EnumDetail(
    'ScrollbarOrientation.bottom',
    Icons.arrow_downward,
    'Places the scrollbar at the bottom of the scroll view. '
    'Used with horizontal scroll directions.',
    'Standard horizontal scroll views. Most common for horizontal '
    'scrolling when a scrollbar indicator is needed.',
  ),
];

// ─── theory content ────────────────────────────────────────
const _kOverview = 'ScrollbarOrientation is a simple enum with four values '
    'that tells the scrollbar framework where to draw the track and thumb. '
    'By default, vertical scroll views use right and horizontal scroll views '
    'use bottom. Override this via the scrollbarOrientation parameter on '
    'RawScrollbar, Scrollbar, or CupertinoScrollbar to move the scrollbar '
    'to any edge — useful for RTL layouts, custom designs, or '
    'unconventional scrollbar placement.';

class _DirectionMapping {
  const _DirectionMapping(this.scrollDirection, this.defaultOrientation,
      this.alternateOrientation);
  final String scrollDirection;
  final String defaultOrientation;
  final String alternateOrientation;
}

const _kDirectionMappings = <_DirectionMapping>[
  _DirectionMapping(
      'Axis.vertical', 'ScrollbarOrientation.right',
      'ScrollbarOrientation.left'),
  _DirectionMapping(
      'Axis.horizontal', 'ScrollbarOrientation.bottom',
      'ScrollbarOrientation.top'),
];

const _kPractices = <String, String>{
  'Follow platform conventions':
      'On LTR systems, right is standard for vertical scrollbars. '
      'Only override when you have a strong design reason.',
  'Match scroll direction to orientation axis':
      'Vertical scrolling uses left/right. Horizontal scrolling uses '
      'top/bottom. Crossing them (e.g., top on a vertical list) '
      'produces a non-functional scrollbar.',
  'Consider RTL layouts':
      'In RTL languages, the scrollbar conventionally appears on the '
      'left. Use Directionality-aware logic or explicitly set left.',
  'Always-visible scrollbars need explicit orientation':
      'When using thumbVisibility: true or isAlwaysShown: true, '
      'make orientation explicit to avoid confusion on unfamiliar '
      'edges.',
  'Accessibility and discoverability':
      'Screen readers announce scrollbar position. Non-standard '
      'placement may confuse assistive technology users. Test with '
      'TalkBack/VoiceOver when using non-default orientations.',
};

// ─── helpers ───────────────────────────────────────────────
Widget _sectionHeader(String title, IconData icon) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [_kTealDark, _kPinkDark]),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 22),
        SizedBox(width: 12),
        Expanded(
          child: Text(title,
              style: TextStyle(color: Colors.white, fontSize: 16,
                  fontWeight: FontWeight.w700, letterSpacing: 0.4)),
        ),
      ],
    ),
  );
}

Widget _card({required Widget child}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kDivider),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04),
          blurRadius: 6, offset: Offset(0, 2))],
    ),
    child: child,
  );
}

Widget _label(String text) {
  return Text(text,
      style: TextStyle(fontSize: 11, color: _kTextMuted,
          fontWeight: FontWeight.w600, letterSpacing: 0.6));
}

Widget _mono(String text, {Color? color}) {
  return Text(text,
      style: TextStyle(fontFamily: 'monospace', fontSize: 12.5,
          color: color ?? _kTextDark, height: 1.45));
}

Widget _bullet(String text) {
  return Padding(
    padding: EdgeInsets.only(left: 8, bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(margin: EdgeInsets.only(top: 7), width: 5, height: 5,
            decoration: BoxDecoration(color: _kTeal, shape: BoxShape.circle)),
        SizedBox(width: 10),
        Expanded(child: Text(text,
            style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4))),
      ],
    ),
  );
}

// ─── entry point ───────────────────────────────────────────
dynamic build(BuildContext context) {
  print('ScrollbarOrientation deep visual demo');
  print('─' * 48);
  print('Sections: overview, enum values, scroll direction mapping,');
  print('orientation switcher, horizontal scrollbar, grid, best practices.');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: _kTeal, brightness: Brightness.light),
      scaffoldBackgroundColor: _kSurface,
    ),
    home: _DemoScaffold(),
  );
}

class _DemoScaffold extends StatefulWidget {
  @override
  State<_DemoScaffold> createState() => _DemoScaffoldState();
}

class _DemoScaffoldState extends State<_DemoScaffold> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ScrollbarOrientation'),
        backgroundColor: _kTealDark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: IndexedStack(
        index: _tabIndex,
        children: [_TheoryPage(), _SwitcherPage(), _GridPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        selectedItemColor: _kTealDark,
        onTap: (i) => setState(() => _tabIndex = i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.school_outlined), label: 'Theory'),
          BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: 'Switcher'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Grid'),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAB 1: Theory
// ═══════════════════════════════════════════════════════════
class _TheoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: 40),
      children: [
        _sectionHeader('1 · What Is ScrollbarOrientation?', Icons.info_outline),
        SizedBox(height: 8),
        _card(child: Text(_kOverview,
            style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4))),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('USAGE WITH RAWSCROLLBAR'),
              SizedBox(height: 8),
              _mono('RawScrollbar('),
              _mono('  scrollbarOrientation:'),
              _mono('    ScrollbarOrientation.left,'),
              _mono('  thumbVisibility: true,'),
              _mono('  child: ListView(...),'),
              _mono(')'),
              SizedBox(height: 8),
              _bullet('Pass scrollbarOrientation to RawScrollbar, Scrollbar, '
                  'or CupertinoScrollbar.'),
              _bullet('The orientation must match the scroll axis — vertical '
                  'scroll → left/right, horizontal scroll → top/bottom.'),
            ],
          ),
        ),

        SizedBox(height: 12),
        _sectionHeader('2 · Enum Values', Icons.list_alt),
        SizedBox(height: 8),
        ..._kEnumValues.map((v) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 32, height: 32,
                    decoration: BoxDecoration(
                      color: _kTealLight, shape: BoxShape.circle),
                    alignment: Alignment.center,
                    child: Icon(v.icon, color: _kTealDark, size: 18),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: _kPinkLight,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(v.name,
                          style: TextStyle(fontFamily: 'monospace',
                              fontWeight: FontWeight.w700, fontSize: 11,
                              color: _kPinkDark)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(v.description,
                  style: TextStyle(fontSize: 12.5, color: _kTextDark,
                      height: 1.35)),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _kTealLight.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.lightbulb_outline, size: 14, color: _kTeal),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(v.useCase,
                          style: TextStyle(fontSize: 11.5, color: _kTextDark,
                              height: 1.3)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),

        SizedBox(height: 12),
        _sectionHeader('3 · Scroll Direction Mapping', Icons.compare_arrows),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('SCROLL DIRECTION → SCROLLBAR ORIENTATION'),
              SizedBox(height: 8),
              Table(
                columnWidths: {
                  0: FlexColumnWidth(1.5),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(2),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                border: TableBorder.all(color: _kDivider, width: 0.5),
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                        color: _kTealLight.withOpacity(0.5)),
                    children: ['Scroll Dir', 'Default', 'Alternate'].map((h) =>
                        Padding(
                          padding: EdgeInsets.all(6),
                          child: Text(h, style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 10.5,
                              color: _kTealDark)),
                        )).toList(),
                  ),
                  ..._kDirectionMappings.map((d) => TableRow(
                    children: [d.scrollDirection, d.defaultOrientation,
                        d.alternateOrientation].map((c) =>
                        Padding(
                          padding: EdgeInsets.all(6),
                          child: Text(c, style: TextStyle(
                              fontFamily: 'monospace', fontSize: 9.5,
                              color: _kTextDark)),
                        )).toList(),
                  )),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 12),
        _sectionHeader('7 · Best Practices', Icons.lightbulb_outlined),
        SizedBox(height: 8),
        ..._kPractices.entries.map((e) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle_outline, color: _kTeal, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(e.key,
                        style: TextStyle(fontWeight: FontWeight.w600,
                            fontSize: 13, color: _kTealDark)),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Padding(
                padding: EdgeInsets.only(left: 26),
                child: Text(e.value,
                    style: TextStyle(fontSize: 12.5, color: _kTextDark,
                        height: 1.35)),
              ),
            ],
          ),
        )),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAB 2: Interactive orientation switcher
// ═══════════════════════════════════════════════════════════
class _SwitcherPage extends StatefulWidget {
  @override
  State<_SwitcherPage> createState() => _SwitcherPageState();
}

class _SwitcherPageState extends State<_SwitcherPage> {
  ScrollbarOrientation _orientation = ScrollbarOrientation.right;
  bool _alwaysShow = true;
  double _thickness = 8.0;
  final _scrollController = ScrollController();

  static const _kOrientations = <ScrollbarOrientation, String>{
    ScrollbarOrientation.left: 'Left',
    ScrollbarOrientation.right: 'Right',
    ScrollbarOrientation.top: 'Top',
    ScrollbarOrientation.bottom: 'Bottom',
  };

  bool get _isVertical =>
      _orientation == ScrollbarOrientation.left ||
      _orientation == ScrollbarOrientation.right;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          color: _kTealDark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ORIENTATION SWITCHER',
                  style: TextStyle(color: Colors.white70, fontSize: 11,
                      fontWeight: FontWeight.w700, letterSpacing: 0.6)),
              SizedBox(height: 4),
              Text('Switch between the four ScrollbarOrientation values. '
                  'The scrollbar moves to the selected edge. Left/Right use '
                  'vertical scroll, Top/Bottom use horizontal scroll.',
                  style: TextStyle(color: Colors.white70, fontSize: 10.5,
                      height: 1.3)),
              SizedBox(height: 8),
              Row(
                children: _kOrientations.entries.map((e) {
                  final selected = e.key == _orientation;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _orientation = e.key),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        padding: EdgeInsets.symmetric(vertical: 7),
                        decoration: BoxDecoration(
                          color: selected
                              ? _kPink.withOpacity(0.3)
                              : Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: selected ? _kPink : Colors.white24),
                        ),
                        alignment: Alignment.center,
                        child: Text(e.value,
                            style: TextStyle(
                                color: selected ? Colors.white : Colors.white54,
                                fontSize: 11, fontWeight: FontWeight.w700)),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text('Thickness: ', style: TextStyle(
                      color: Colors.white70, fontSize: 10)),
                  Expanded(
                    child: Slider(
                      value: _thickness, min: 4, max: 20,
                      activeColor: _kPink,
                      onChanged: (v) =>
                          setState(() => _thickness = v),
                    ),
                  ),
                  Text('${_thickness.toInt()}px',
                      style: TextStyle(color: _kPink,
                          fontFamily: 'monospace', fontSize: 11)),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _alwaysShow = !_alwaysShow),
                    child: Row(
                      children: [
                        Icon(_alwaysShow
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                            color: _alwaysShow ? _kPink : Colors.white54,
                            size: 18),
                        SizedBox(width: 6),
                        Text('Always visible',
                            style: TextStyle(color: Colors.white70,
                                fontSize: 10.5)),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                        'Axis: ${_isVertical ? "vertical" : "horizontal"}',
                        style: TextStyle(color: Colors.white70,
                            fontFamily: 'monospace', fontSize: 10)),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: RawScrollbar(
            controller: _scrollController,
            scrollbarOrientation: _orientation,
            thumbVisibility: _alwaysShow,
            thickness: _thickness,
            thumbColor: _kPink.withOpacity(0.6),
            radius: Radius.circular(_thickness / 2),
            child: _isVertical
                ? ListView.builder(
                    controller: _scrollController,
                    itemCount: 40,
                    itemBuilder: (context, index) => _scrollItem(index, true),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: 40,
                    itemBuilder: (context, index) => _scrollItem(index, false),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _scrollItem(int index, bool vertical) {
    final hue = (index * 9.0) % 360;
    final color = HSVColor.fromAHSV(1, hue, 0.15, 0.97).toColor();

    if (vertical) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        height: 54,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Container(
              width: 30, height: 30,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Text('${index + 1}',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800,
                      color: _kTextDark)),
            ),
            SizedBox(width: 12),
            Text('Scroll item ${index + 1}',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600,
                    color: _kTextDark)),
            Spacer(),
            Text('${hue.toInt()}°',
                style: TextStyle(fontFamily: 'monospace', fontSize: 10,
                    color: _kTextMuted)),
          ],
        ),
      );
    }

    return Container(
      width: 120,
      margin: EdgeInsets.symmetric(horizontal: 3, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${index + 1}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800,
                  color: _kTextDark)),
          Text('${hue.toInt()}°',
              style: TextStyle(fontFamily: 'monospace', fontSize: 10,
                  color: _kTextMuted)),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAB 3: All four orientations in a grid
// ═══════════════════════════════════════════════════════════
class _GridPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          color: _kTealDark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ALL FOUR ORIENTATIONS',
                  style: TextStyle(color: Colors.white70, fontSize: 11,
                      fontWeight: FontWeight.w700, letterSpacing: 0.6)),
              SizedBox(height: 4),
              Text('See all four ScrollbarOrientation values side by side. '
                  'Left/Right scrollbars on vertical lists, Top/Bottom on '
                  'horizontal lists.',
                  style: TextStyle(color: Colors.white70, fontSize: 10.5,
                      height: 1.3)),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: _OrientedPanel(
                          label: 'LEFT',
                          orientation: ScrollbarOrientation.left,
                          isVertical: true,
                          color: _kTeal,
                        ),
                      ),
                      SizedBox(width: 6),
                      Expanded(
                        child: _OrientedPanel(
                          label: 'RIGHT',
                          orientation: ScrollbarOrientation.right,
                          isVertical: true,
                          color: _kPink,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: _OrientedPanel(
                          label: 'TOP',
                          orientation: ScrollbarOrientation.top,
                          isVertical: false,
                          color: Colors.orange,
                        ),
                      ),
                      SizedBox(width: 6),
                      Expanded(
                        child: _OrientedPanel(
                          label: 'BOTTOM',
                          orientation: ScrollbarOrientation.bottom,
                          isVertical: false,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _OrientedPanel extends StatefulWidget {
  const _OrientedPanel({
    required this.label,
    required this.orientation,
    required this.isVertical,
    required this.color,
  });

  final String label;
  final ScrollbarOrientation orientation;
  final bool isVertical;
  final Color color;

  @override
  State<_OrientedPanel> createState() => _OrientedPanelState();
}

class _OrientedPanelState extends State<_OrientedPanel> {
  final _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.color.withOpacity(0.4)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 6),
            color: widget.color.withOpacity(0.15),
            alignment: Alignment.center,
            child: Text(widget.label,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800,
                    color: widget.color, letterSpacing: 1)),
          ),
          Expanded(
            child: RawScrollbar(
              controller: _controller,
              scrollbarOrientation: widget.orientation,
              thumbVisibility: true,
              thickness: 6,
              thumbColor: widget.color.withOpacity(0.5),
              radius: Radius.circular(3),
              child: widget.isVertical
                  ? ListView.builder(
                      controller: _controller,
                      itemCount: 30,
                      itemBuilder: (context, i) {
                        final shade = (i * 12.0) % 360;
                        return Container(
                          margin: EdgeInsets.all(2),
                          height: 32,
                          decoration: BoxDecoration(
                            color: HSVColor.fromAHSV(1, shade, 0.12, 0.97)
                                .toColor(),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          alignment: Alignment.center,
                          child: Text('${i + 1}',
                              style: TextStyle(fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: _kTextMuted)),
                        );
                      },
                    )
                  : ListView.builder(
                      controller: _controller,
                      scrollDirection: Axis.horizontal,
                      itemCount: 30,
                      itemBuilder: (context, i) {
                        final shade = (i * 12.0) % 360;
                        return Container(
                          margin: EdgeInsets.all(2),
                          width: 40,
                          decoration: BoxDecoration(
                            color: HSVColor.fromAHSV(1, shade, 0.12, 0.97)
                                .toColor(),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          alignment: Alignment.center,
                          child: Text('${i + 1}',
                              style: TextStyle(fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: _kTextMuted)),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
