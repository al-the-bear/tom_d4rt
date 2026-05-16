// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: hand-authored deep visual demo for Route<T> and the
// Cupertino route family — PageRoute, ModalRoute, PopupRoute, OverlayRoute,
// TransitionRoute, CupertinoPageRoute, CupertinoModalPopupRoute,
// CupertinoDialogRoute, CupertinoSheetRoute and the RouteSettings glue.
//
// Theme: a "subway / transit map" — each route family is a coloured line on
// the graphite/cream canvas of the navigator. The demo is a static layout,
// no live navigation — properties that depend on a live Navigator are
// surfaced through try/catch wrappers and tagged as "not-attached".
import 'package:flutter/cupertino.dart';

// ---------------------------------------------------------------------------
// Palette — the "line colours" of the subway map
// ---------------------------------------------------------------------------

const Color _kInk = Color(0xFF1B1F26);
const Color _kGraphite = Color(0xFF2A2F38);
const Color _kIron = Color(0xFF3C4350);
const Color _kSlate = Color(0xFF5B6472);
const Color _kFog = Color(0xFFB7BFC9);
const Color _kCream = Color(0xFFF4EFE3);
const Color _kPaper = Color(0xFFFBF7EC);
const Color _kCard = Color(0xFFFFFFFF);

const Color _kLineRed = Color(0xFFC8323D); // PageRoute
const Color _kLineOrange = Color(0xFFE07A2C); // ModalRoute
const Color _kLineYellow = Color(0xFFE3B43A); // PopupRoute
const Color _kLineGreen = Color(0xFF3C8F5A); // TransitionRoute
const Color _kLineBlue = Color(0xFF2F6FB4); // OverlayRoute
const Color _kLinePurple = Color(0xFF7B4CA0); // CupertinoPageRoute
const Color _kLineTeal = Color(0xFF2F8F8C); // CupertinoSheetRoute

const TextStyle _kMono = TextStyle(
  fontFamily: 'Menlo',
  fontSize: 11.5,
  color: _kInk,
  height: 1.35,
);

// ---------------------------------------------------------------------------
// Tiny helpers — reusable visual pieces
// ---------------------------------------------------------------------------

Widget _gap(double h) => SizedBox(height: h);

Widget _hgap(double w) => SizedBox(width: w);

Widget _lineDot(Color color, String label) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 13.0,
          height: 13.0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: _kInk, width: 1.0),
          ),
        ),
        _hgap(5.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.5,
            color: _kInk,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget _bannerSection(int n, String title, String subtitle, Color color) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
    padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [_kInk, _kGraphite],
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border(left: BorderSide(color: color, width: 6.0)),
      boxShadow: [
        BoxShadow(
          color: Color(0x66000000),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 36.0,
          height: 36.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: _kCream, width: 1.6),
          ),
          child: Text(
            n.toString(),
            style: TextStyle(
              color: _kCard,
              fontSize: 15.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        _hgap(12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: _kCream,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
              _gap(3.0),
              Text(
                subtitle,
                style: TextStyle(
                  color: _kFog,
                  fontSize: 12.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _explainerCard(String body, {Color? tint}) {
  final Color accent = tint ?? _kLineBlue;
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
    decoration: BoxDecoration(
      color: _kPaper,
      border: Border(left: BorderSide(color: accent, width: 4.0)),
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(8.0),
        bottomRight: Radius.circular(8.0),
      ),
    ),
    child: Text(
      body,
      style: TextStyle(color: _kInk, fontSize: 13.0, height: 1.4),
    ),
  );
}

Widget _captionRow(String label, String value, {Color? valueColor}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130.0,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.5,
              color: _kSlate,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 11.5,
              color: valueColor ?? _kInk,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _attachedBadge(bool ok, String label) {
  return Container(
    margin: EdgeInsets.only(left: 6.0),
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
    decoration: BoxDecoration(
      color: ok ? _kLineGreen : _kLineRed,
      borderRadius: BorderRadius.circular(3.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: _kCard,
        fontSize: 9.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.4,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 1 — Hero header
// ---------------------------------------------------------------------------

Widget _heroHeader() {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 4.0),
    padding: EdgeInsets.fromLTRB(18.0, 20.0, 18.0, 20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [_kInk, _kIron, _kGraphite],
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x77000000),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: _kLinePurple,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'CUPERTINO • NAVIGATOR',
                style: TextStyle(
                  color: _kCream,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            _hgap(8.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: _kLineYellow,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'DEEP DEMO',
                style: TextStyle(
                  color: _kInk,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ],
        ),
        _gap(10.0),
        Text(
          'Route<T> — the navigator\'s contract',
          style: TextStyle(
            color: _kCream,
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.3,
          ),
        ),
        _gap(4.0),
        Text(
          'A subway map of the Cupertino route family',
          style: TextStyle(
            color: _kFog,
            fontSize: 13.5,
            fontStyle: FontStyle.italic,
          ),
        ),
        _gap(14.0),
        Wrap(
          children: [
            _lineDot(_kLineBlue, 'OverlayRoute'),
            _lineDot(_kLineGreen, 'TransitionRoute'),
            _lineDot(_kLineOrange, 'ModalRoute'),
            _lineDot(_kLineRed, 'PageRoute'),
            _lineDot(_kLineYellow, 'PopupRoute'),
            _lineDot(_kLinePurple, 'CupertinoPageRoute'),
            _lineDot(_kLineTeal, 'CupertinoSheetRoute'),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 2 — Concept overview card
// ---------------------------------------------------------------------------

Widget _conceptOverview() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _kCard,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kFog, width: 0.8),
      boxShadow: [
        BoxShadow(
          color: Color(0x22000000),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What is a Route?',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w800,
            color: _kInk,
          ),
        ),
        _gap(8.0),
        Text(
          'A Route<T> represents one screen-or-overlay on the Navigator\'s '
          'stack. The type parameter T is what the route eventually returns '
          'to whoever pushed it: pop a route with a String and the awaiting '
          'caller resolves with that String. Cupertino just supplies the '
          'iOS-flavoured concrete classes — the contract is shared with '
          'Material.',
          style: TextStyle(fontSize: 12.5, color: _kIron, height: 1.45),
        ),
        _gap(12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kPaper,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: _kFog, width: 0.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _captionRow('Owner', 'Navigator → Overlay → OverlayEntry'),
              _captionRow('Contract', 'install / didPush / didPop / dispose'),
              _captionRow('Return value', 'Future<T?> resolved by pop(value)'),
              _captionRow('Settings', 'RouteSettings(name, arguments)'),
              _captionRow('Visual', 'TransitionRoute paints transition layers'),
              _captionRow('Barrier', 'ModalRoute adds tap-to-dismiss scrim'),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 3 — Class hierarchy diagram (ASCII-style tree)
// ---------------------------------------------------------------------------

Widget _treeRow(String pipe, String name, Color color, String note) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 110.0,
          child: Text(pipe, style: _kMono),
        ),
        Container(
          width: 12.0,
          height: 12.0,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        _hgap(6.0),
        SizedBox(
          width: 200.0,
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'Menlo',
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              color: _kInk,
            ),
          ),
        ),
        Expanded(
          child: Text(
            note,
            style: TextStyle(
              fontSize: 11.0,
              color: _kSlate,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _hierarchyDiagram() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _kCream,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kFog, width: 0.8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Class hierarchy',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w800,
            color: _kInk,
          ),
        ),
        _gap(8.0),
        _treeRow('Route<T>', 'abstract', _kSlate, 'the contract'),
        _treeRow(' └── ', 'OverlayRoute<T>', _kLineBlue,
            'paints into Overlay via OverlayEntry'),
        _treeRow('      └── ', 'TransitionRoute<T>', _kLineGreen,
            'owns a primary AnimationController'),
        _treeRow('           └── ', 'ModalRoute<T>', _kLineOrange,
            'adds the barrier scrim & focus traps'),
        _treeRow('                └── ', 'PageRoute<T>', _kLineRed,
            'fullscreen, opaque, push/pop animated'),
        _treeRow('                     └── ', 'CupertinoPageRoute<T>',
            _kLinePurple, 'iOS slide-in transition + back gesture'),
        _treeRow('                └── ', 'PopupRoute<T>', _kLineYellow,
            'non-fullscreen overlays (sheets, dialogs)'),
        _treeRow('                     └── ', 'CupertinoModalPopupRoute<T>',
            _kLineYellow, 'iOS-style action sheet popup'),
        _treeRow('                     └── ', 'CupertinoDialogRoute<T>',
            _kLineOrange, 'iOS-style centred alert dialog'),
        _treeRow('                     └── ', 'CupertinoSheetRoute<T>',
            _kLineTeal, 'iOS 15+ stacked card sheet'),
        _gap(8.0),
        _explainerCard(
          'Read top-to-bottom: each child class layers responsibility on '
          'its parent. Once you reach PageRoute, the route is "page-like"; '
          'PopupRoute is the sibling branch for ephemeral overlays.',
          tint: _kLineGreen,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 4 — Live specimen: build route instances and surface properties.
// All attached-Navigator dependent reads are wrapped in try/catch.
// ---------------------------------------------------------------------------

class _SpecimenReport {
  final String label;
  final String typeName;
  final String settingsName;
  final String settingsArguments;
  final String fullscreenDialog;
  final String title;
  final String attachedNote;
  final bool attached;
  final Color accent;

  const _SpecimenReport({
    required this.label,
    required this.typeName,
    required this.settingsName,
    required this.settingsArguments,
    required this.fullscreenDialog,
    required this.title,
    required this.attachedNote,
    required this.attached,
    required this.accent,
  });
}

_SpecimenReport _reportFromCupertinoPage(
  CupertinoPageRoute<dynamic> route,
  String label,
  Color accent,
) {
  String title;
  try {
    title = route.title ?? '(none)';
  } catch (_) {
    title = '(throws)';
  }
  String fsd;
  try {
    fsd = route.fullscreenDialog.toString();
  } catch (_) {
    fsd = '(throws)';
  }
  String name;
  String args;
  try {
    name = route.settings.name ?? '(unnamed)';
  } catch (_) {
    name = '(throws)';
  }
  try {
    final dynamic a = route.settings.arguments;
    args = a == null ? '(null)' : a.toString();
  } catch (_) {
    args = '(throws)';
  }
  String attachedNote;
  bool attached;
  try {
    // isCurrent / isActive read the navigator state — outside a Navigator
    // these accessors throw or return false. We surface that as a badge.
    final bool current = route.isCurrent;
    attached = current;
    attachedNote = 'isCurrent=$current';
  } catch (e) {
    attached = false;
    attachedNote = 'not-attached (${e.runtimeType})';
  }
  return _SpecimenReport(
    label: label,
    typeName: route.runtimeType.toString(),
    settingsName: name,
    settingsArguments: args,
    fullscreenDialog: fsd,
    title: title,
    attachedNote: attachedNote,
    attached: attached,
    accent: accent,
  );
}

Widget _specimenCard(_SpecimenReport r) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 14.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _kCard,
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        left: BorderSide(color: r.accent, width: 6.0),
        top: BorderSide(color: _kFog, width: 0.5),
        right: BorderSide(color: _kFog, width: 0.5),
        bottom: BorderSide(color: _kFog, width: 0.5),
      ),
      boxShadow: [
        BoxShadow(
          color: Color(0x11000000),
          blurRadius: 3.0,
          offset: Offset(0.0, 1.5),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              r.label,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w800,
                color: _kInk,
              ),
            ),
            _attachedBadge(r.attached, r.attached ? 'ACTIVE' : 'DETACHED'),
          ],
        ),
        _gap(8.0),
        _captionRow('runtimeType', r.typeName),
        _captionRow('settings.name', r.settingsName),
        _captionRow('settings.args', r.settingsArguments),
        _captionRow('fullscreenDialog', r.fullscreenDialog),
        _captionRow('title', r.title),
        _captionRow('attached', r.attachedNote,
            valueColor: r.attached ? _kLineGreen : _kLineRed),
      ],
    ),
  );
}

Widget _liveSpecimenSection() {
  final CupertinoPageRoute<dynamic> standard = CupertinoPageRoute<dynamic>(
    builder: (ctx) => CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Standard')),
      child: Center(child: Text('Standard slide-in')),
    ),
    settings: RouteSettings(
      name: '/profile',
      arguments: <String, dynamic>{'userId': 42},
    ),
    title: 'Profile',
  );

  final CupertinoPageRoute<String> dialog = CupertinoPageRoute<String>(
    fullscreenDialog: true,
    builder: (ctx) => CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Edit')),
      child: Center(child: Text('Fullscreen edit')),
    ),
    settings: RouteSettings(
      name: '/edit',
      arguments: <String, dynamic>{'draft': true},
    ),
    title: 'Edit',
  );

  final CupertinoPageRoute<int> typed = CupertinoPageRoute<int>(
    builder: (ctx) => CupertinoPageScaffold(
      child: Center(child: Text('Pick a number')),
    ),
    settings: RouteSettings(name: '/pick-int'),
    title: 'Pick',
  );

  final reports = <_SpecimenReport>[
    _reportFromCupertinoPage(
      standard,
      'CupertinoPageRoute<dynamic>',
      _kLinePurple,
    ),
    _reportFromCupertinoPage(
      dialog,
      'CupertinoPageRoute<String> (fullscreen)',
      _kLineRed,
    ),
    _reportFromCupertinoPage(typed, 'CupertinoPageRoute<int>', _kLineOrange),
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _explainerCard(
        'Routes are constructed eagerly — the builder closure is held until '
        'the route mounts. Reading isCurrent / isActive / animation outside '
        'a real Navigator throws; we wrap those in try/catch and surface a '
        '"DETACHED" badge so the demo still composes statically.',
        tint: _kLinePurple,
      ),
      ...reports.map(_specimenCard),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 5 — RouteSettings showcase
// ---------------------------------------------------------------------------

Widget _settingsCard({
  required String name,
  required String args,
  required String note,
  required Color color,
}) {
  return Container(
    width: 250.0,
    margin: EdgeInsets.all(6.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _kCard,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 10.0,
              height: 10.0,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            _hgap(6.0),
            Text(
              'RouteSettings',
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
        _gap(8.0),
        Text(
          'name',
          style: TextStyle(
            fontSize: 10.5,
            color: _kSlate,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(name, style: _kMono),
        _gap(6.0),
        Text(
          'arguments',
          style: TextStyle(
            fontSize: 10.5,
            color: _kSlate,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(args, style: _kMono),
        _gap(8.0),
        Text(
          note,
          style: TextStyle(
            fontSize: 11.0,
            color: _kIron,
            fontStyle: FontStyle.italic,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

Widget _routeSettingsShowcase() {
  final s1 = RouteSettings(name: '/', arguments: null);
  final s2 = RouteSettings(
    name: '/profile/42',
    arguments: <String, dynamic>{'tab': 'overview'},
  );
  final s3 = RouteSettings(
    name: '/checkout',
    arguments: <String, dynamic>{
      'cartId': 'c-7781',
      'currency': 'EUR',
      'lineItems': 3,
    },
  );
  final s4 = RouteSettings(name: '/unnamed', arguments: 'plain-string-arg');

  String describeArgs(Object? args) {
    if (args == null) return '(null)';
    if (args is String) return '"$args"';
    if (args is Map) {
      final entries = args.entries
          .map((e) => '${e.key}: ${e.value}')
          .join(', ');
      return '{$entries}';
    }
    return args.toString();
  }

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
    child: Wrap(
      children: [
        _settingsCard(
          name: s1.name ?? '(null)',
          args: describeArgs(s1.arguments),
          note: 'Root route — typically the initial home page.',
          color: _kLineBlue,
        ),
        _settingsCard(
          name: s2.name ?? '(null)',
          args: describeArgs(s2.arguments),
          note: 'Deep link with a structured map of arguments.',
          color: _kLinePurple,
        ),
        _settingsCard(
          name: s3.name ?? '(null)',
          args: describeArgs(s3.arguments),
          note: 'Multi-field map argument — common for checkout flows.',
          color: _kLineGreen,
        ),
        _settingsCard(
          name: s4.name ?? '(null)',
          args: describeArgs(s4.arguments),
          note: 'Arguments can be any Object — strings, ints, custom DTOs.',
          color: _kLineOrange,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 6 — fullscreenDialog vs standard push
// ---------------------------------------------------------------------------

Widget _transitionSpecimen({
  required String title,
  required String shape,
  required String gesture,
  required String navBar,
  required Color color,
  required bool fullscreen,
}) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 6.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color, width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w800,
              color: _kInk,
            ),
          ),
          _gap(8.0),
          Container(
            height: 80.0,
            decoration: BoxDecoration(
              color: _kPaper,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: _kFog, width: 0.6),
            ),
            child: Center(
              child: Container(
                width: 90.0,
                height: 60.0,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border(
                    top: BorderSide(
                      color: color,
                      width: fullscreen ? 6.0 : 1.2,
                    ),
                    left: BorderSide(color: color, width: 1.2),
                    right: BorderSide(color: color, width: 1.2),
                    bottom: BorderSide(color: color, width: 1.2),
                  ),
                ),
                child: Center(
                  child: Text(
                    fullscreen ? 'modal' : 'page',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: color,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ),
          _gap(8.0),
          _captionRow('shape', shape),
          _captionRow('gesture', gesture),
          _captionRow('nav bar', navBar),
        ],
      ),
    ),
  );
}

Widget _fullscreenVsPush() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _transitionSpecimen(
          title: 'standard push',
          shape: 'slide L→R',
          gesture: 'edge-swipe to pop',
          navBar: 'back button',
          color: _kLinePurple,
          fullscreen: false,
        ),
        _transitionSpecimen(
          title: 'fullscreenDialog',
          shape: 'slide bottom→top',
          gesture: 'no edge swipe',
          navBar: 'close button',
          color: _kLineRed,
          fullscreen: true,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 7 — Declarative CupertinoPage vs imperative CupertinoPageRoute
// ---------------------------------------------------------------------------

Widget _compareDeclarative() {
  final CupertinoPage<dynamic> page = CupertinoPage<dynamic>(
    child: Center(child: Text('declarative')),
    title: 'Declarative',
    name: '/declarative',
    arguments: <String, dynamic>{'mode': 'router'},
  );
  final CupertinoPageRoute<dynamic> route = CupertinoPageRoute<dynamic>(
    builder: (ctx) => Center(child: Text('imperative')),
    title: 'Imperative',
    settings: RouteSettings(name: '/imperative'),
  );

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _kCard,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kFog, width: 0.8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CupertinoPage  vs  CupertinoPageRoute',
          style: TextStyle(
            fontSize: 14.5,
            fontWeight: FontWeight.w800,
            color: _kInk,
          ),
        ),
        _gap(4.0),
        Text(
          'Two ways to express the same concept — declarative (router-based) '
          'and imperative (Navigator.push).',
          style: TextStyle(
            fontSize: 11.5,
            color: _kSlate,
            fontStyle: FontStyle.italic,
          ),
        ),
        _gap(10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kPaper,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Column(
            children: [
              _captionRow('CupertinoPage.title', page.title ?? '(none)'),
              _captionRow('CupertinoPage.name', page.name ?? '(none)'),
              _captionRow(
                'CupertinoPage.arguments',
                page.arguments?.toString() ?? '(none)',
              ),
              _captionRow(
                'CupertinoPage.runtimeType',
                page.runtimeType.toString(),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                height: 1.0,
                color: _kFog,
              ),
              _captionRow(
                'CupertinoPageRoute.title',
                route.title ?? '(none)',
              ),
              _captionRow(
                'CupertinoPageRoute.settings.name',
                route.settings.name ?? '(none)',
              ),
              _captionRow(
                'CupertinoPageRoute.runtimeType',
                route.runtimeType.toString(),
              ),
            ],
          ),
        ),
        _gap(10.0),
        _explainerCard(
          'CupertinoPage is a Page<T> — describe the stack as data, the '
          'Navigator reconciles. CupertinoPageRoute is the imperative '
          'companion you push directly. Pages are mutated by rebuilding the '
          'list; routes are mutated by pushing & popping.',
          tint: _kLineTeal,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 8 — Triple-column sheet/popup/dialog showcase
// ---------------------------------------------------------------------------

Widget _miniPhoneFrame({required Widget child, required Color color}) {
  return Container(
    height: 200.0,
    margin: EdgeInsets.all(6.0),
    decoration: BoxDecoration(
      color: _kInk,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: _kIron, width: 1.0),
    ),
    padding: EdgeInsets.all(6.0),
    child: Container(
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: EdgeInsets.all(8.0),
      child: child,
    ),
  );
}

Widget _sheetMockup() {
  return _miniPhoneFrame(
    color: _kLineTeal,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 14.0,
          decoration: BoxDecoration(
            color: _kFog,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        _gap(6.0),
        Expanded(child: Container(color: _kCream)),
        _gap(4.0),
        Container(
          height: 90.0,
          decoration: BoxDecoration(
            color: _kLineTeal.withOpacity(0.12),
            borderRadius: BorderRadius.vertical(top: Radius.circular(14.0)),
            border: Border.all(color: _kLineTeal, width: 1.2),
          ),
          child: Center(
            child: Text(
              'CupertinoSheetRoute',
              style: TextStyle(
                color: _kLineTeal,
                fontWeight: FontWeight.w800,
                fontSize: 11.0,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _popupMockup() {
  return _miniPhoneFrame(
    color: _kLineYellow,
    child: Stack(
      children: [
        Positioned.fill(child: Container(color: _kCream)),
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 6.0,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                padding: EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  color: _kCard,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: _kLineYellow, width: 1.2),
                ),
                child: Center(
                  child: Text(
                    'Action 1',
                    style: TextStyle(
                      color: _kInk,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              _gap(4.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                padding: EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  color: _kCard,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: _kLineYellow, width: 1.2),
                ),
                child: Center(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: _kLineRed,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _dialogMockup() {
  return _miniPhoneFrame(
    color: _kLineOrange,
    child: Stack(
      children: [
        Positioned.fill(child: Container(color: _kCream)),
        Positioned.fill(
          child: Container(
            color: Color(0x77000000),
            alignment: Alignment.center,
            child: Container(
              width: 110.0,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Alert',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 11.0,
                      color: _kInk,
                    ),
                  ),
                  _gap(4.0),
                  Text(
                    'Are you sure?',
                    style: TextStyle(fontSize: 9.5, color: _kIron),
                  ),
                  _gap(6.0),
                  Container(
                    height: 1.0,
                    color: _kFog,
                  ),
                  _gap(4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 9.5,
                          color: _kLineBlue,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'OK',
                        style: TextStyle(
                          fontSize: 9.5,
                          color: _kLineBlue,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _popupGallery() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    child: Row(
      children: [
        Expanded(
          child: Column(
            children: [
              _sheetMockup(),
              Text(
                'CupertinoSheetRoute',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  color: _kLineTeal,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                child: Text(
                  'iOS 15+ card sheet — drag handle, partial-screen, stacks '
                  'visually behind the previous page.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10.5, color: _kSlate),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              _popupMockup(),
              Text(
                'CupertinoModalPopupRoute',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  color: _kLineYellow,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                child: Text(
                  'Action sheet — anchored to the bottom, tap outside to '
                  'dismiss via the modal barrier.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10.5, color: _kSlate),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              _dialogMockup(),
              Text(
                'CupertinoDialogRoute',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  color: _kLineOrange,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                child: Text(
                  'Centred alert — opaque scrim, no swipe-dismiss; pop via '
                  'an explicit action button.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10.5, color: _kSlate),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 9 — Lifecycle diagram
// ---------------------------------------------------------------------------

Widget _lifecycleStep({
  required int n,
  required String name,
  required String desc,
  required Color color,
  bool last = false,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: [
          Container(
            width: 28.0,
            height: 28.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: _kInk, width: 1.2),
            ),
            child: Text(
              n.toString(),
              style: TextStyle(
                color: _kCard,
                fontSize: 12.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          if (!last)
            Container(width: 2.0, height: 30.0, color: _kFog),
        ],
      ),
      _hgap(12.0),
      Expanded(
        child: Padding(
          padding: EdgeInsets.only(top: 4.0, bottom: 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w800,
                  color: _kInk,
                ),
              ),
              _gap(2.0),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 11.5,
                  color: _kSlate,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _lifecycleDiagram() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _kCard,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kFog, width: 0.8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Route lifecycle',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w800,
            color: _kInk,
          ),
        ),
        _gap(10.0),
        _lifecycleStep(
          n: 1,
          name: 'install',
          color: _kLineBlue,
          desc: 'Navigator inserts the route\'s OverlayEntry(s) into the '
              'Overlay. No animation has run yet.',
        ),
        _lifecycleStep(
          n: 2,
          name: 'didPush',
          color: _kLineGreen,
          desc: 'Push animation starts. Returns the TickerFuture that '
              'completes when the entry is fully on-screen.',
        ),
        _lifecycleStep(
          n: 3,
          name: 'didChangeNext',
          color: _kLineYellow,
          desc: 'Called when a new route is pushed on top — your route '
              'learns who its successor is and can react.',
        ),
        _lifecycleStep(
          n: 4,
          name: 'didChangePrevious',
          color: _kLineOrange,
          desc: 'Called when the route below changes — typical when '
              'replace() or removeRoute() mutates the stack mid-flight.',
        ),
        _lifecycleStep(
          n: 5,
          name: 'didPop(result)',
          color: _kLineRed,
          desc: 'The pop animation begins. The popped Future<T?> resolves '
              'with whatever value was passed to Navigator.pop().',
        ),
        _lifecycleStep(
          n: 6,
          name: 'dispose',
          color: _kLinePurple,
          desc: 'OverlayEntries are removed and the route\'s controllers are '
              'disposed. Anything held by the route is now free.',
          last: true,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 10 — Recipe cards
// ---------------------------------------------------------------------------

Widget _recipeCard({
  required String title,
  required String code,
  required String note,
  required Color color,
}) {
  return Container(
    width: 290.0,
    margin: EdgeInsets.all(6.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _kCard,
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        top: BorderSide(color: color, width: 3.0),
        left: BorderSide(color: _kFog, width: 0.6),
        right: BorderSide(color: _kFog, width: 0.6),
        bottom: BorderSide(color: _kFog, width: 0.6),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        _gap(8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: _kInk,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'Menlo',
              fontSize: 10.5,
              color: _kCream,
              height: 1.4,
            ),
          ),
        ),
        _gap(8.0),
        Text(
          note,
          style: TextStyle(
            fontSize: 11.0,
            color: _kIron,
            fontStyle: FontStyle.italic,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

Widget _recipeGrid() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    child: Wrap(
      children: [
        _recipeCard(
          title: '1. Push a page',
          color: _kLinePurple,
          code:
              'Navigator.of(context).push(\n'
              '  CupertinoPageRoute(\n'
              '    builder: (_) => DetailPage(),\n'
              '  ),\n'
              ');',
          note: 'The classic imperative push — slides in from the right '
              'with the iOS back gesture enabled by default.',
        ),
        _recipeCard(
          title: '2. Push & await result',
          color: _kLineGreen,
          code:
              'final pick = await Navigator.of(ctx)\n'
              '    .push<String>(\n'
              '  CupertinoPageRoute<String>(\n'
              '    builder: (_) => Picker(),\n'
              '  ),\n'
              ');',
          note: 'Type the route parameter T explicitly so the pop value '
              'type-checks against the awaited Future.',
        ),
        _recipeCard(
          title: '3. Replace current',
          color: _kLineOrange,
          code:
              'Navigator.of(context).pushReplacement(\n'
              '  CupertinoPageRoute(\n'
              '    builder: (_) => Welcome(),\n'
              '  ),\n'
              ');',
          note: 'Replace swaps the top of the stack — the previous route '
              'is disposed and the new one takes its place.',
        ),
        _recipeCard(
          title: '4. Pop until a name',
          color: _kLineRed,
          code:
              'Navigator.of(context).popUntil(\n'
              '  (route) => route.settings.name == \'/\'\n'
              ');',
          note: 'Walks the stack popping each route until the predicate '
              'returns true — great for "Done" buttons.',
        ),
        _recipeCard(
          title: '5. Push & clear stack',
          color: _kLineBlue,
          code:
              'Navigator.of(context).pushAndRemoveUntil(\n'
              '  CupertinoPageRoute(\n'
              '    builder: (_) => Home(),\n'
              '  ),\n'
              '  (route) => false,\n'
              ');',
          note: 'After login: jump to Home and wipe the stack so users '
              'cannot back-swipe into the auth screens.',
        ),
        _recipeCard(
          title: '6. Show a sheet',
          color: _kLineTeal,
          code:
              'showCupertinoSheet(\n'
              '  context: context,\n'
              '  pageBuilder: (_) => SettingsSheet(),\n'
              ');',
          note: 'A helper that pushes a CupertinoSheetRoute — partial '
              'overlay with the stacked-card visual.',
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 11 — Comparison table: Route variants
// ---------------------------------------------------------------------------

Widget _cmpHeader(String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: _kInk,
      border: Border.all(color: _kIron, width: 0.4),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: _kCream,
        fontSize: 11.5,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

Widget _cmpCell(String text, {Color? color, bool bold = false}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: color ?? _kCard,
      border: Border.all(color: _kFog, width: 0.5),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11.0,
        color: _kInk,
        fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
        height: 1.35,
      ),
    ),
  );
}

Widget _comparisonTable() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: _kCard,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kFog, width: 0.8),
    ),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 4.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Route variant comparison',
              style: TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w800,
                color: _kInk,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(150.0),
              1: FlexColumnWidth(1.0),
              2: FlexColumnWidth(1.0),
              3: FlexColumnWidth(1.0),
              4: FlexColumnWidth(1.0),
            },
            children: <TableRow>[
              TableRow(children: <Widget>[
                _cmpHeader('Route variant'),
                _cmpHeader('Platform'),
                _cmpHeader('Transition'),
                _cmpHeader('Back gesture'),
                _cmpHeader('Owns barrier?'),
              ]),
              TableRow(children: <Widget>[
                _cmpCell('Route<T>', bold: true, color: _kPaper),
                _cmpCell('abstract'),
                _cmpCell('—'),
                _cmpCell('—'),
                _cmpCell('—'),
              ]),
              TableRow(children: <Widget>[
                _cmpCell('PageRoute<T>', bold: true, color: _kPaper),
                _cmpCell('abstract / both'),
                _cmpCell('subclass decides'),
                _cmpCell('subclass decides'),
                _cmpCell('yes (opaque)'),
              ]),
              TableRow(children: <Widget>[
                _cmpCell('MaterialPageRoute<T>',
                    bold: true, color: _kPaper),
                _cmpCell('Material / Android'),
                _cmpCell('fade-up'),
                _cmpCell('no'),
                _cmpCell('yes'),
              ]),
              TableRow(children: <Widget>[
                _cmpCell('CupertinoPageRoute<T>',
                    bold: true, color: _kPaper),
                _cmpCell('Cupertino / iOS'),
                _cmpCell('horizontal slide'),
                _cmpCell('edge swipe'),
                _cmpCell('yes'),
              ]),
              TableRow(children: <Widget>[
                _cmpCell('PopupRoute<T>', bold: true, color: _kPaper),
                _cmpCell('abstract'),
                _cmpCell('subclass decides'),
                _cmpCell('subclass decides'),
                _cmpCell('yes (translucent)'),
              ]),
              TableRow(children: <Widget>[
                _cmpCell('DialogRoute<T> (Material)',
                    bold: true, color: _kPaper),
                _cmpCell('Material'),
                _cmpCell('fade-scale'),
                _cmpCell('no'),
                _cmpCell('yes'),
              ]),
              TableRow(children: <Widget>[
                _cmpCell('CupertinoDialogRoute<T>',
                    bold: true, color: _kPaper),
                _cmpCell('Cupertino'),
                _cmpCell('fade'),
                _cmpCell('no'),
                _cmpCell('yes'),
              ]),
              TableRow(children: <Widget>[
                _cmpCell('CupertinoModalPopupRoute<T>',
                    bold: true, color: _kPaper),
                _cmpCell('Cupertino'),
                _cmpCell('slide-up'),
                _cmpCell('no'),
                _cmpCell('yes (dim)'),
              ]),
              TableRow(children: <Widget>[
                _cmpCell('CupertinoSheetRoute<T>',
                    bold: true, color: _kPaper),
                _cmpCell('Cupertino (iOS15+)'),
                _cmpCell('stacked sheet'),
                _cmpCell('drag-to-dismiss'),
                _cmpCell('yes (dim)'),
              ]),
            ],
          ),
        ),
        _gap(8.0),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 12 — Glossary
// ---------------------------------------------------------------------------

Widget _glossaryRow(String term, String def, Color accent) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: _kPaper,
      borderRadius: BorderRadius.circular(6.0),
      border: Border(left: BorderSide(color: accent, width: 3.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          term,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w800,
            color: _kInk,
          ),
        ),
        _gap(2.0),
        Text(
          def,
          style: TextStyle(fontSize: 11.5, color: _kIron, height: 1.4),
        ),
      ],
    ),
  );
}

Widget _glossarySection() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _kCard,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kFog, width: 0.8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Glossary',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w800,
            color: _kInk,
          ),
        ),
        _gap(6.0),
        _glossaryRow(
          'Navigator',
          'The widget that manages a stack of routes. Reached via '
              'Navigator.of(context) or via a NavigatorState key.',
          _kLineRed,
        ),
        _glossaryRow(
          'Overlay',
          'A Stack of OverlayEntries — the surface routes paint into. '
              'Every Navigator hosts an Overlay.',
          _kLineBlue,
        ),
        _glossaryRow(
          'OverlayEntry',
          'A single layer in the Overlay. Routes typically install one or '
              'two: the page content and the modal barrier.',
          _kLineBlue,
        ),
        _glossaryRow(
          'RouteSettings',
          'Identity metadata for a route: name plus optional arguments. '
              'Surfaced via route.settings.',
          _kLineGreen,
        ),
        _glossaryRow(
          'ModalBarrier',
          'The translucent scrim painted behind modal routes that '
              'intercepts touches and optionally dismisses on tap.',
          _kLineOrange,
        ),
        _glossaryRow(
          'TransitionRoute',
          'A Route that owns a primary AnimationController and exposes '
              'animation / secondaryAnimation hooks for its content.',
          _kLineGreen,
        ),
        _glossaryRow(
          'PopupRoute',
          'A TransitionRoute that does NOT cover the full screen — used '
              'by sheets, popups and dialogs.',
          _kLineYellow,
        ),
        _glossaryRow(
          'HeroController',
          'Coordinates Hero transitions across route boundaries. '
              'CupertinoApp injects a default one.',
          _kLinePurple,
        ),
        _glossaryRow(
          'willHandlePopInternally',
          'A route hook returning true when the route itself wants to '
              'absorb a pop (e.g. dismiss a nested sheet).',
          _kLineRed,
        ),
        _glossaryRow(
          'popDisposition',
          'Per-pop decision: pop, bubble, or do-nothing — used by '
              'PopScope and onPopInvokedWithResult.',
          _kLineTeal,
        ),
        _glossaryRow(
          'fullscreenDialog',
          'A flag on CupertinoPageRoute / MaterialPageRoute that swaps the '
              'side-slide for a bottom-slide and replaces back with close.',
          _kLineOrange,
        ),
        _glossaryRow(
          'isCurrent / isActive',
          'Live navigation status. Reading them outside a real Navigator '
              'throws — wrap in try/catch in tooling.',
          _kSlate,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 13 — Epilogue
// ---------------------------------------------------------------------------

Widget _summaryItem(String label) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: _kLineYellow,
            shape: BoxShape.circle,
          ),
        ),
        _hgap(10.0),
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: _kCream, fontSize: 12.5),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            'COVERED',
            style: TextStyle(
              color: _kCream,
              fontSize: 9.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _epilogue() {
  return Container(
    margin: EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 20.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [_kInk, _kGraphite, _kIron],
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'End of the line',
          style: TextStyle(
            color: _kCream,
            fontSize: 18.0,
            fontWeight: FontWeight.w900,
          ),
        ),
        _gap(4.0),
        Text(
          'You\'ve toured the Cupertino route family from abstract Route<T> '
          'down to CupertinoSheetRoute<T>. Below: a recap of what this demo '
          'covered.',
          style: TextStyle(
            color: _kFog,
            fontSize: 12.0,
            fontStyle: FontStyle.italic,
          ),
        ),
        _gap(12.0),
        _summaryItem('Route<T> contract & type parameter'),
        _summaryItem('Class hierarchy diagram'),
        _summaryItem('Live specimen with detached-Navigator handling'),
        _summaryItem('RouteSettings name & arguments'),
        _summaryItem('fullscreenDialog vs standard push'),
        _summaryItem('CupertinoPage (declarative) vs imperative route'),
        _summaryItem('Sheet / popup / dialog mockups'),
        _summaryItem('Lifecycle: install → didPush → didPop → dispose'),
        _summaryItem('Recipe cards for common navigation patterns'),
        _summaryItem('Variant comparison table'),
        _summaryItem('Glossary of related types'),
        _gap(14.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Route<T>: ',
                style: TextStyle(color: _kCream, fontSize: 14.0),
              ),
              Text(
                'the navigator\'s contract ✓',
                style: TextStyle(
                  color: _kCream,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        _gap(8.0),
        Center(
          child: Text(
            'Deep Demo • Cupertino Route family • Flutter Navigator 2.0',
            style: TextStyle(
              fontSize: 11.5,
              color: _kFog,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// build — assemble the full demo as one CupertinoApp tree
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('Cupertino Route deep demo executing');

  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Route<T> — Deep Demo',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        backgroundColor: _kInk,
        brightness: Brightness.dark,
      ),
      backgroundColor: _kCream,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Section 1
              _heroHeader(),
              _bannerSection(
                1,
                'HERO',
                'A subway map of Cupertino navigation',
                _kLinePurple,
              ),
              _explainerCard(
                'The Cupertino route family is a tree. The root is the '
                'abstract Route<T> contract; each child layer adds a single '
                'responsibility — overlay management, transitions, modality, '
                'page semantics — until you reach the iOS-flavoured concrete '
                'classes near the leaves.',
                tint: _kLinePurple,
              ),

              // Section 2
              _bannerSection(
                2,
                'CONCEPT',
                'What is a Route — and what is T?',
                _kLineBlue,
              ),
              _conceptOverview(),

              // Section 3
              _bannerSection(
                3,
                'HIERARCHY',
                'Class tree from Route<T> down to leaves',
                _kLineGreen,
              ),
              _hierarchyDiagram(),

              // Section 4
              _bannerSection(
                4,
                'LIVE SPECIMENS',
                'Real route instances with property readout',
                _kLineOrange,
              ),
              _liveSpecimenSection(),

              // Section 5
              _bannerSection(
                5,
                'ROUTE SETTINGS',
                'Identity & arguments per route',
                _kLineYellow,
              ),
              _routeSettingsShowcase(),

              // Section 6
              _bannerSection(
                6,
                'TRANSITIONS',
                'fullscreenDialog vs standard push',
                _kLineRed,
              ),
              _fullscreenVsPush(),

              // Section 7
              _bannerSection(
                7,
                'DECLARATIVE',
                'CupertinoPage vs CupertinoPageRoute',
                _kLineTeal,
              ),
              _compareDeclarative(),

              // Section 8
              _bannerSection(
                8,
                'POPUPS',
                'Sheet / Popup / Dialog routes',
                _kLineYellow,
              ),
              _popupGallery(),

              // Section 9
              _bannerSection(
                9,
                'LIFECYCLE',
                'install → didPush → didPop → dispose',
                _kLineGreen,
              ),
              _lifecycleDiagram(),

              // Section 10
              _bannerSection(
                10,
                'RECIPES',
                'Common navigation patterns',
                _kLineBlue,
              ),
              _recipeGrid(),

              // Section 11
              _bannerSection(
                11,
                'COMPARISON',
                'Route variants side-by-side',
                _kLineOrange,
              ),
              _comparisonTable(),

              // Section 12
              _bannerSection(
                12,
                'GLOSSARY',
                'Terms in and around the Route family',
                _kLinePurple,
              ),
              _glossarySection(),

              // Section 13
              _bannerSection(
                13,
                'EPILOGUE',
                'Recap & end of the line',
                _kLineRed,
              ),
              _epilogue(),
            ],
          ),
        ),
      ),
    ),
  );
}
