// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep visual test: Animation utility classes — wrappers, mixers and the curves catalog.
// Theme: Orchestra conductor / animation podium — midnight blue, gold leaf, cream.
import 'package:flutter/material.dart';
import 'dart:math' as math;

// ============================================================================
// PALETTE — Orchestra conductor / midnight + gold + cream
// ============================================================================
const Color _midnight = Color(0xFF0B1733);
const Color _midnightDeep = Color(0xFF050B1F);
const Color _ink = Color(0xFF1A2347);
const Color _navy = Color(0xFF243064);
const Color _gold = Color(0xFFE3B864);
const Color _goldDeep = Color(0xFFB78A3A);
const Color _goldLight = Color(0xFFF3D78E);
const Color _cream = Color(0xFFF7F1E1);
const Color _creamSoft = Color(0xFFEFE4C5);
const Color _parchment = Color(0xFFFAF5E5);
const Color _wine = Color(0xFF7B2434);
const Color _wineLight = Color(0xFFB95566);
const Color _moss = Color(0xFF38573C);
const Color _mossLight = Color(0xFF6F9577);
const Color _slate = Color(0xFF455066);
const Color _slateSoft = Color(0xFF7F8AA3);

// ============================================================================
// SMALL HELPERS — staff lines, value rules, badges, dots
// ============================================================================
Widget _staffLine({double opacity = 0.18}) {
  return Container(
    height: 1.0,
    color: _midnight.withOpacity(opacity),
  );
}

Widget _staff({int lines = 5, double gap = 8.0, double opacity = 0.16}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      for (int i = 0; i < lines; i++) ...<Widget>[
        _staffLine(opacity: opacity),
        if (i != lines - 1) SizedBox(height: gap),
      ],
    ],
  );
}

Widget _goldRule({double height = 1.5, double opacity = 0.9}) {
  return Container(
    height: height,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          _gold.withOpacity(0.0),
          _gold.withOpacity(opacity),
          _gold.withOpacity(0.0),
        ],
      ),
    ),
  );
}

Widget _pill(String label, {Color? bg, Color? fg, double fontSize = 11.0}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: bg ?? _gold.withOpacity(0.18),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: (fg ?? _gold).withOpacity(0.45), width: 0.6),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: fg ?? _gold,
        letterSpacing: 0.4,
      ),
    ),
  );
}

Widget _sectionTitle(String index, String title, String subtitle) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 44.0,
        height: 44.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _midnight,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: _gold, width: 1.2),
        ),
        child: Text(
          index,
          style: const TextStyle(
            color: _gold,
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      const SizedBox(width: 14.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: _midnight,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(height: 2.0),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12.5,
                color: _slate,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _card({required Widget child, Color? bg, Color? border, EdgeInsets? padding}) {
  return Container(
    width: double.infinity,
    padding: padding ?? const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: bg ?? _parchment,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: border ?? _gold.withOpacity(0.35), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _midnight.withOpacity(0.06),
          blurRadius: 8.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: child,
  );
}

Widget _progressBar(double t, {Color fill = _gold, Color track = _creamSoft, double height = 10.0}) {
  final double clamped = t.clamp(0.0, 1.0);
  return Container(
    height: height,
    decoration: BoxDecoration(
      color: track,
      borderRadius: BorderRadius.circular(height / 2.0),
      border: Border.all(color: _midnight.withOpacity(0.18), width: 0.6),
    ),
    child: FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: clamped,
      child: Container(
        decoration: BoxDecoration(
          color: fill,
          borderRadius: BorderRadius.circular(height / 2.0),
        ),
      ),
    ),
  );
}

Widget _kv(String key, String value, {Color? keyColor, Color? valueColor, double fontSize = 12.0}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 110.0,
          child: Text(
            key,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: keyColor ?? _slate,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: fontSize,
              color: valueColor ?? _midnight,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _bullet(String text, {Color? color, double fontSize = 13.0}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 6.0, right: 8.0),
          width: 6.0,
          height: 6.0,
          decoration: BoxDecoration(
            color: color ?? _gold,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              color: _midnight,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _noteDot(double t, {Color? color, double size = 12.0}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: color ?? _gold,
      shape: BoxShape.circle,
      border: Border.all(color: _midnight, width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _midnight.withOpacity(0.25),
          blurRadius: 3.0,
          offset: const Offset(0.5, 1.0),
        ),
      ],
    ),
  );
}

// ============================================================================
// CURVE PLOTTING — render a curve as a row of value dots & a bar strip
// ============================================================================
Widget _curveStrip(Curve curve, {int steps = 9, Color color = _gold, Color rail = _creamSoft}) {
  final List<double> samples = <double>[];
  for (int i = 0; i < steps; i++) {
    samples.add(curve.transform(i / (steps - 1)));
  }
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: rail,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: _midnight.withOpacity(0.15), width: 0.6),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        for (final double s in samples)
          Container(
            width: 12.0,
            height: 12.0 + (28.0 * s),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3.0),
              border: Border.all(color: _midnight.withOpacity(0.45), width: 0.5),
            ),
          ),
      ],
    ),
  );
}

Widget _curveCard(String name, Curve curve, {Color color = _gold, String? note}) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _cream,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _gold.withOpacity(0.55), width: 0.8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: _midnight,
                ),
              ),
            ),
            Container(
              width: 10.0,
              height: 10.0,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        _curveStrip(curve, color: color),
        const SizedBox(height: 6.0),
        Text(
          'f(0)=${curve.transform(0.0).toStringAsFixed(2)}  '
          'f(.25)=${curve.transform(0.25).toStringAsFixed(2)}  '
          'f(.5)=${curve.transform(0.5).toStringAsFixed(2)}  '
          'f(.75)=${curve.transform(0.75).toStringAsFixed(2)}  '
          'f(1)=${curve.transform(1.0).toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 9.5,
            color: _slate,
            fontFamily: 'monospace',
          ),
        ),
        if (note != null) ...<Widget>[
          const SizedBox(height: 4.0),
          Text(
            note,
            style: const TextStyle(
              fontSize: 10.5,
              color: _slate,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ],
    ),
  );
}

// ============================================================================
// HEADER — Hero "Animation utilities" podium
// ============================================================================
Widget _heroHeader() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(26.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_midnightDeep, _midnight, _ink],
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: _gold.withOpacity(0.55), width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _midnight.withOpacity(0.35),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 56.0,
              height: 56.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _gold,
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: _gold.withOpacity(0.45),
                    blurRadius: 14.0,
                  ),
                ],
              ),
              child: const Text(
                'A',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                  color: _midnight,
                ),
              ),
            ),
            const SizedBox(width: 18.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Animation utilities',
                    style: TextStyle(
                      color: _cream,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'wrappers, mixers, and the curves catalog',
                    style: TextStyle(
                      color: _goldLight.withOpacity(0.95),
                      fontSize: 15.0,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        // Sheet music staff motif
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: _midnightDeep.withOpacity(0.55),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _gold.withOpacity(0.3), width: 0.8),
          ),
          child: Column(
            children: <Widget>[
              for (int i = 0; i < 5; i++) ...<Widget>[
                Container(
                  height: 1.0,
                  color: _gold.withOpacity(0.45),
                ),
                if (i != 4) const SizedBox(height: 7.0),
              ],
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _pill('CurvedAnimation', bg: _gold.withOpacity(0.2), fg: _goldLight),
            _pill('ReverseAnimation', bg: _gold.withOpacity(0.2), fg: _goldLight),
            _pill('ProxyAnimation', bg: _gold.withOpacity(0.2), fg: _goldLight),
            _pill('AlwaysStoppedAnimation', bg: _gold.withOpacity(0.2), fg: _goldLight),
            _pill('TrainHoppingAnimation', bg: _gold.withOpacity(0.2), fg: _goldLight),
            _pill('AnimationMin/Max/Mean', bg: _gold.withOpacity(0.2), fg: _goldLight),
            _pill('Curves catalog', bg: _gold.withOpacity(0.2), fg: _goldLight),
            _pill('Interval / Cubic / Threshold', bg: _gold.withOpacity(0.2), fg: _goldLight),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 1 — Concept overview
// ============================================================================
Widget _conceptOverview() {
  return _card(
    bg: _parchment,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('1', 'The Animation as a soloist',
            'Animation<T> emits the line — wrappers re-shape the performance.'),
        const SizedBox(height: 12.0),
        _goldRule(),
        const SizedBox(height: 12.0),
        const Text(
          'In Flutter the basic source is Animation<T> — an object that exposes '
          'a value and a status, and that notifies listeners when either changes. '
          'AnimationController is the one driver that actually advances time, but '
          'a whole family of wrapper classes can re-shape, freeze, mirror, or mix '
          'an existing Animation without ever needing a ticker of their own.',
          style: TextStyle(fontSize: 13.0, color: _midnight, height: 1.55),
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _pill('source', bg: _wine.withOpacity(0.15), fg: _wine),
                  const SizedBox(height: 6.0),
                  _bullet('AnimationController drives time 0→1.'),
                  _bullet('Tween<T> projects 0→1 into a typed range.'),
                  _bullet('Anything Animation<double> is fair game for wrapping.'),
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _pill('shape', bg: _moss.withOpacity(0.15), fg: _moss),
                  const SizedBox(height: 6.0),
                  _bullet('CurvedAnimation bends time through a Curve.'),
                  _bullet('ReverseAnimation flips the line top-to-bottom.'),
                  _bullet('ProxyAnimation lets a parent be swapped in flight.'),
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _pill('mix', bg: _gold.withOpacity(0.18), fg: _goldDeep),
                  const SizedBox(height: 6.0),
                  _bullet('AnimationMin / Max / Mean combine two voices.'),
                  _bullet('TrainHoppingAnimation switches tracks at a crossing.'),
                  _bullet('AlwaysStoppedAnimation freezes a single note.'),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 2 — Wrapper family tree diagram
// ============================================================================
Widget _wrapperTree() {
  Widget node(String label, {Color bg = _midnight, Color fg = _gold, double width = 170.0}) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _gold, width: 0.8),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: fg,
          fontWeight: FontWeight.w700,
          fontSize: 12.5,
        ),
      ),
    );
  }

  Widget arm() => Container(
        width: 1.5,
        height: 22.0,
        color: _gold.withOpacity(0.7),
      );

  return _card(
    bg: _midnight,
    border: _gold.withOpacity(0.6),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('2', 'Wrapper family tree',
            'Animation<double> at the root; every wrapper is a re-voicing.'),
        const SizedBox(height: 14.0),
        Center(child: node('Animation<double>', bg: _gold, fg: _midnight, width: 220.0)),
        Center(child: arm()),
        Container(height: 1.5, color: _gold.withOpacity(0.7)),
        const SizedBox(height: 6.0),
        Wrap(
          alignment: WrapAlignment.spaceEvenly,
          spacing: 14.0,
          runSpacing: 14.0,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                arm(),
                node('CurvedAnimation'),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                arm(),
                node('ReverseAnimation'),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                arm(),
                node('ProxyAnimation'),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                arm(),
                node('AlwaysStoppedAnimation'),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                arm(),
                node('CompoundAnimation'),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                arm(),
                node('TrainHoppingAnimation'),
              ],
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _midnightDeep,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _gold.withOpacity(0.4)),
          ),
          child: const Text(
            'CompoundAnimation has three built-in voicings: AnimationMin, AnimationMax, '
            'and AnimationMean — each takes two parents and produces one combined '
            'Animation<double> without owning a ticker itself.',
            style: TextStyle(
              color: _cream,
              fontSize: 12.0,
              height: 1.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 3 — CurvedAnimation showcase: one parent t through 8 curves
// ============================================================================
Widget _curvedAnimationShowcase() {
  const double parentT = 0.55;
  final List<MapEntry<String, Curve>> entries = <MapEntry<String, Curve>>[
    const MapEntry<String, Curve>('linear', Curves.linear),
    const MapEntry<String, Curve>('easeIn', Curves.easeIn),
    const MapEntry<String, Curve>('easeOut', Curves.easeOut),
    const MapEntry<String, Curve>('easeInOut', Curves.easeInOut),
    const MapEntry<String, Curve>('bounceOut', Curves.bounceOut),
    const MapEntry<String, Curve>('elasticIn', Curves.elasticIn),
    const MapEntry<String, Curve>('decelerate', Curves.decelerate),
    const MapEntry<String, Curve>('fastOutSlowIn', Curves.fastOutSlowIn),
  ];

  Widget row(String name, Curve curve) {
    final AlwaysStoppedAnimation<double> parent = const AlwaysStoppedAnimation<double>(parentT);
    final CurvedAnimation curved = CurvedAnimation(parent: parent, curve: curve);
    final double shaped = curve.transform(parentT);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 120.0,
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                color: _midnight,
              ),
            ),
          ),
          Expanded(child: _progressBar(shaped, fill: _gold)),
          const SizedBox(width: 8.0),
          SizedBox(
            width: 70.0,
            child: Text(
              shaped.toStringAsFixed(3),
              style: const TextStyle(
                fontSize: 11.0,
                color: _slate,
                fontFamily: 'monospace',
              ),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(width: 8.0),
          // Force-touch the wrapper so the type is real in d4rt.
          Container(
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
              color: curved.value == shaped ? _moss : _wine,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('3', 'CurvedAnimation showcase',
            'Same parent t = $parentT, eight different curves.'),
        const SizedBox(height: 12.0),
        _goldRule(),
        const SizedBox(height: 10.0),
        const Text(
          'CurvedAnimation wraps a parent Animation<double> and exposes value '
          'transformed by Curve.transform(parent.value). The parent here is '
          'AlwaysStoppedAnimation<double>(0.55) — every wrapper below shows the '
          'shaped value for that single snapshot.',
          style: TextStyle(fontSize: 12.5, color: _midnight, height: 1.5),
        ),
        const SizedBox(height: 12.0),
        for (final MapEntry<String, Curve> e in entries) row(e.key, e.value),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _cream,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _gold.withOpacity(0.45)),
          ),
          child: const Text(
            'Tip — CurvedAnimation also accepts reverseCurve. When the parent '
            'runs in reverse the wrapper uses that second curve to bend time on '
            'the way back.',
            style: TextStyle(fontSize: 11.5, color: _slate, fontStyle: FontStyle.italic),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 4 — Curves catalog (20+ entries)
// ============================================================================
Widget _curvesCatalog() {
  final List<MapEntry<String, Curve>> catalog = <MapEntry<String, Curve>>[
    const MapEntry<String, Curve>('linear', Curves.linear),
    const MapEntry<String, Curve>('decelerate', Curves.decelerate),
    const MapEntry<String, Curve>('ease', Curves.ease),
    const MapEntry<String, Curve>('easeIn', Curves.easeIn),
    const MapEntry<String, Curve>('easeOut', Curves.easeOut),
    const MapEntry<String, Curve>('easeInOut', Curves.easeInOut),
    const MapEntry<String, Curve>('easeInQuad', Curves.easeInQuad),
    const MapEntry<String, Curve>('easeOutQuad', Curves.easeOutQuad),
    const MapEntry<String, Curve>('easeInCubic', Curves.easeInCubic),
    const MapEntry<String, Curve>('easeOutCubic', Curves.easeOutCubic),
    const MapEntry<String, Curve>('easeInQuart', Curves.easeInQuart),
    const MapEntry<String, Curve>('easeOutQuart', Curves.easeOutQuart),
    const MapEntry<String, Curve>('easeInQuint', Curves.easeInQuint),
    const MapEntry<String, Curve>('easeOutQuint', Curves.easeOutQuint),
    const MapEntry<String, Curve>('easeInSine', Curves.easeInSine),
    const MapEntry<String, Curve>('easeOutSine', Curves.easeOutSine),
    const MapEntry<String, Curve>('easeInCirc', Curves.easeInCirc),
    const MapEntry<String, Curve>('easeOutCirc', Curves.easeOutCirc),
    const MapEntry<String, Curve>('easeInBack', Curves.easeInBack),
    const MapEntry<String, Curve>('easeOutBack', Curves.easeOutBack),
    const MapEntry<String, Curve>('bounceIn', Curves.bounceIn),
    const MapEntry<String, Curve>('bounceOut', Curves.bounceOut),
    const MapEntry<String, Curve>('bounceInOut', Curves.bounceInOut),
    const MapEntry<String, Curve>('elasticIn', Curves.elasticIn),
    const MapEntry<String, Curve>('elasticOut', Curves.elasticOut),
    const MapEntry<String, Curve>('fastOutSlowIn', Curves.fastOutSlowIn),
    const MapEntry<String, Curve>('slowMiddle', Curves.slowMiddle),
    const MapEntry<String, Curve>('fastLinearToSlowEaseIn', Curves.fastLinearToSlowEaseIn),
  ];

  return _card(
    bg: _cream,
    border: _gold.withOpacity(0.5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('4', 'Curves catalog',
            '28 named choreographies from the standard Curves class.'),
        const SizedBox(height: 12.0),
        _goldRule(),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: <Widget>[
            for (final MapEntry<String, Curve> e in catalog)
              SizedBox(
                width: 230.0,
                child: _curveCard(e.key, e.value),
              ),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 5 — Custom curves: Interval, Threshold, Cubic, SawTooth, Elastic, Flipped
// ============================================================================
Widget _customCurves() {
  final List<MapEntry<String, Curve>> specimens = <MapEntry<String, Curve>>[
    const MapEntry<String, Curve>(
      'Interval(0.3, 0.7)',
      Interval(0.3, 0.7),
    ),
    const MapEntry<String, Curve>(
      'Interval(0.0, 0.5, easeOut)',
      Interval(0.0, 0.5, curve: Curves.easeOut),
    ),
    const MapEntry<String, Curve>(
      'Threshold(0.5)',
      Threshold(0.5),
    ),
    const MapEntry<String, Curve>(
      'Cubic(0.42, 0.0, 0.58, 1.0)',
      Cubic(0.42, 0.0, 0.58, 1.0),
    ),
    const MapEntry<String, Curve>(
      'SawTooth(3)',
      SawTooth(3),
    ),
    const MapEntry<String, Curve>(
      'ElasticInCurve(0.6)',
      ElasticInCurve(0.6),
    ),
    const MapEntry<String, Curve>(
      'FlippedCurve(easeIn)',
      FlippedCurve(Curves.easeIn),
    ),
    const MapEntry<String, Curve>(
      'Curves.easeInOut.flipped',
      _FlippedShim(),
    ),
  ];

  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('5', 'Custom curve specimens',
            'Build your own choreography with Interval, Threshold, Cubic, SawTooth, Elastic, Flipped.'),
        const SizedBox(height: 12.0),
        _goldRule(),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            for (final MapEntry<String, Curve> s in specimens)
              SizedBox(width: 260.0, child: _curveCard(s.key, s.value, color: _wineLight)),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _parchment,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _gold.withOpacity(0.35)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _bullet('Interval clips the parent t to a sub-range, optionally re-curving inside.'),
              _bullet('Threshold is a step function — 0 below cutoff, 1 above.'),
              _bullet('Cubic is the cubic bezier you find in CSS easing curves.'),
              _bullet('SawTooth divides 0..1 into n triangular ramps.'),
              _bullet('ElasticInCurve gives configurable oscillation with a period parameter.'),
              _bullet('FlippedCurve wraps c into 1 - c.transform(1 - t) — useful for reverseCurve.'),
            ],
          ),
        ),
      ],
    ),
  );
}

// Light shim so we can reference the catalog item; flipped is a getter on Curves entries.
class _FlippedShim extends Curve {
  const _FlippedShim();
  @override
  double transformInternal(double t) {
    // Mirror of easeInOut about (0.5, 0.5).
    final double v = Curves.easeInOut.transform(1.0 - t);
    return 1.0 - v;
  }
}

// ============================================================================
// SECTION 6 — ReverseAnimation demo
// ============================================================================
Widget _reverseAnimationDemo() {
  final List<double> samples = <double>[0.0, 0.25, 0.5, 0.75, 1.0];
  return _card(
    bg: _parchment,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('6', 'ReverseAnimation',
            'reversed.value == 1.0 - parent.value, status mirrored too.'),
        const SizedBox(height: 12.0),
        _goldRule(),
        const SizedBox(height: 12.0),
        Row(
          children: const <Widget>[
            SizedBox(width: 60.0, child: Text('t', style: TextStyle(fontWeight: FontWeight.w700, color: _midnight, fontSize: 12.0))),
            Expanded(child: Text('parent', style: TextStyle(fontWeight: FontWeight.w700, color: _midnight, fontSize: 12.0))),
            SizedBox(width: 14.0),
            Expanded(child: Text('reversed', style: TextStyle(fontWeight: FontWeight.w700, color: _wine, fontSize: 12.0))),
            SizedBox(width: 70.0, child: Text('sum', style: TextStyle(fontWeight: FontWeight.w700, color: _midnight, fontSize: 12.0), textAlign: TextAlign.right)),
          ],
        ),
        const SizedBox(height: 6.0),
        for (final double t in samples) ...<Widget>[
          Builder(builder: (BuildContext context) {
            final AlwaysStoppedAnimation<double> parent = AlwaysStoppedAnimation<double>(t);
            final ReverseAnimation rev = ReverseAnimation(parent);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 60.0,
                    child: Text(
                      t.toStringAsFixed(2),
                      style: const TextStyle(fontFamily: 'monospace', fontSize: 12.0, color: _midnight),
                    ),
                  ),
                  Expanded(child: _progressBar(parent.value, fill: _gold)),
                  const SizedBox(width: 14.0),
                  Expanded(child: _progressBar(rev.value, fill: _wineLight)),
                  SizedBox(
                    width: 70.0,
                    child: Text(
                      (parent.value + rev.value).toStringAsFixed(2),
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontFamily: 'monospace', fontSize: 11.0, color: _slate),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _cream,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _gold.withOpacity(0.4)),
          ),
          child: const Text(
            'For every row parent + reversed = 1.0 — that\'s the whole identity of '
            'ReverseAnimation. It also swaps AnimationStatus.forward ↔ reverse and '
            'completed ↔ dismissed so a downstream listener sees a consistent picture.',
            style: TextStyle(fontSize: 11.5, color: _slate, height: 1.45),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 7 — ProxyAnimation switchboard
// ============================================================================
Widget _proxyAnimationDemo() {
  final AlwaysStoppedAnimation<double> a = const AlwaysStoppedAnimation<double>(0.2);
  final AlwaysStoppedAnimation<double> b = const AlwaysStoppedAnimation<double>(0.7);
  final ProxyAnimation pNull = ProxyAnimation();
  final ProxyAnimation pa = ProxyAnimation(a);
  final ProxyAnimation pb = ProxyAnimation(b);

  Widget panel(String name, Animation<double> animation, {Color accent = _gold}) {
    return Container(
      width: 220.0,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: _cream,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: accent.withOpacity(0.7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.w700, color: _midnight, fontSize: 12.5),
          ),
          const SizedBox(height: 8.0),
          _progressBar(animation.value, fill: accent),
          const SizedBox(height: 6.0),
          _kv('value', animation.value.toStringAsFixed(3)),
          _kv('status', animation.status.name),
        ],
      ),
    );
  }

  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('7', 'ProxyAnimation switchboard',
            'A proxy can have no parent — value is 0.0, status dismissed — and the parent can be hot-swapped.'),
        const SizedBox(height: 12.0),
        _goldRule(),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            panel('proxy(null)', pNull, accent: _slateSoft),
            panel('proxy(a=0.20)', pa, accent: _moss),
            panel('proxy(b=0.70)', pb, accent: _wine),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _parchment,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _gold.withOpacity(0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _bullet('ProxyAnimation() with no parent yields value 0.0 and status dismissed.'),
              _bullet('Set proxy.parent = otherAnimation to swap, listeners follow automatically.'),
              _bullet('Useful inside reusable widgets that may receive a parent late.'),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 8 — AlwaysStoppedAnimation specimens
// ============================================================================
Widget _alwaysStoppedDemo() {
  final List<double> snapshots = <double>[0.0, 0.25, 0.5, 0.75, 1.0];
  return _card(
    bg: _cream,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('8', 'AlwaysStoppedAnimation specimens',
            'A frozen value with status completed (or dismissed for 0).'),
        const SizedBox(height: 12.0),
        _goldRule(),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            for (final double v in snapshots)
              Container(
                width: 150.0,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: _parchment,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: _gold.withOpacity(0.55)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _pill('t = ${v.toStringAsFixed(2)}', bg: _midnight, fg: _gold),
                    const SizedBox(height: 8.0),
                    _progressBar(v),
                    const SizedBox(height: 8.0),
                    _kv('value', AlwaysStoppedAnimation<double>(v).value.toStringAsFixed(2)),
                    _kv('status', AlwaysStoppedAnimation<double>(v).status.name),
                    _kv('isCompleted', AlwaysStoppedAnimation<double>(v).isCompleted.toString()),
                    _kv('isDismissed', AlwaysStoppedAnimation<double>(v).isDismissed.toString()),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _parchment,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _gold.withOpacity(0.4)),
          ),
          child: const Text(
            'AlwaysStoppedAnimation never calls listeners — addListener is a no-op. '
            'Perfect for cases where an API insists on Animation<T> but you only '
            'have a constant.',
            style: TextStyle(fontSize: 11.5, color: _slate, height: 1.5, fontStyle: FontStyle.italic),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 9 — CompoundAnimation family (Min / Max / Mean)
// ============================================================================
Widget _compoundFamily() {
  final List<List<double>> pairs = <List<double>>[
    <double>[0.2, 0.8],
    <double>[0.5, 0.5],
    <double>[0.1, 0.9],
    <double>[0.6, 0.4],
    <double>[0.0, 1.0],
  ];

  Widget stackedRow(double aVal, double bVal) {
    final AlwaysStoppedAnimation<double> a = AlwaysStoppedAnimation<double>(aVal);
    final AlwaysStoppedAnimation<double> b = AlwaysStoppedAnimation<double>(bVal);
    final AnimationMin<double> min = AnimationMin<double>(a, b);
    final AnimationMax<double> max = AnimationMax<double>(a, b);
    final AnimationMean mean = AnimationMean(left: a, right: b);
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: _parchment,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _gold.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _pill('a=${aVal.toStringAsFixed(2)}', bg: _moss.withOpacity(0.15), fg: _moss),
              const SizedBox(width: 6.0),
              _pill('b=${bVal.toStringAsFixed(2)}', bg: _wine.withOpacity(0.15), fg: _wine),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: <Widget>[
              SizedBox(width: 50.0, child: Text('a', style: const TextStyle(fontSize: 11.0, color: _slate))),
              Expanded(child: _progressBar(a.value, fill: _mossLight)),
            ],
          ),
          const SizedBox(height: 4.0),
          Row(
            children: <Widget>[
              SizedBox(width: 50.0, child: Text('b', style: const TextStyle(fontSize: 11.0, color: _slate))),
              Expanded(child: _progressBar(b.value, fill: _wineLight)),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: <Widget>[
              SizedBox(width: 50.0, child: Text('min', style: const TextStyle(fontSize: 11.0, color: _slate, fontWeight: FontWeight.w700))),
              Expanded(child: _progressBar(min.value, fill: _slate)),
              const SizedBox(width: 6.0),
              SizedBox(
                width: 50.0,
                child: Text(min.value.toStringAsFixed(3),
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: _midnight)),
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Row(
            children: <Widget>[
              SizedBox(width: 50.0, child: Text('max', style: const TextStyle(fontSize: 11.0, color: _slate, fontWeight: FontWeight.w700))),
              Expanded(child: _progressBar(max.value, fill: _gold)),
              const SizedBox(width: 6.0),
              SizedBox(
                width: 50.0,
                child: Text(max.value.toStringAsFixed(3),
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: _midnight)),
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Row(
            children: <Widget>[
              SizedBox(width: 50.0, child: Text('mean', style: const TextStyle(fontSize: 11.0, color: _slate, fontWeight: FontWeight.w700))),
              Expanded(child: _progressBar(mean.value, fill: _goldDeep)),
              const SizedBox(width: 6.0),
              SizedBox(
                width: 50.0,
                child: Text(mean.value.toStringAsFixed(3),
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: _midnight)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  return _card(
    bg: _parchment,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('9', 'CompoundAnimation — Min / Max / Mean',
            'Two voices in, one voice out — no ticker required.'),
        const SizedBox(height: 12.0),
        _goldRule(),
        const SizedBox(height: 12.0),
        for (final List<double> p in pairs) stackedRow(p[0], p[1]),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _cream,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _gold.withOpacity(0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _bullet('AnimationMin emits the smaller of two parents at each tick.'),
              _bullet('AnimationMax emits the larger.'),
              _bullet('AnimationMean emits (left + right) / 2.'),
              _bullet('Subclass CompoundAnimation directly to write your own mixer.'),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 10 — TrainHoppingAnimation diagram
// ============================================================================
Widget _trainHoppingDiagram() {
  Widget track(String label, double t, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: _cream,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withOpacity(0.7)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 14.0,
            height: 14.0,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10.0),
          SizedBox(width: 90.0, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700, color: _midnight, fontSize: 12.0))),
          Expanded(child: _progressBar(t, fill: color)),
          const SizedBox(width: 8.0),
          SizedBox(width: 50.0, child: Text(t.toStringAsFixed(2), textAlign: TextAlign.right, style: const TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: _slate))),
        ],
      ),
    );
  }

  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('10', 'TrainHoppingAnimation',
            'Currently follows Train A, hops to Train B when their values cross.'),
        const SizedBox(height: 12.0),
        _goldRule(),
        const SizedBox(height: 12.0),
        const Text(
          'TrainHoppingAnimation(currentTrain, nextTrain, onSwitchedTrain: ...) starts '
          'reporting currentTrain.value. When the two values cross (currentTrain '
          'overtaken by nextTrain in the direction of motion) it switches and from '
          'then on reports nextTrain.value. Below: a four-step storyboard.',
          style: TextStyle(fontSize: 12.5, color: _midnight, height: 1.5),
        ),
        const SizedBox(height: 12.0),
        // Storyboard
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _parchment,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _gold.withOpacity(0.4)),
          ),
          child: Column(
            children: <Widget>[
              track('Train A', 0.25, _wine),
              const SizedBox(height: 6.0),
              track('Train B', 0.10, _moss),
              const SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  _pill('frame 1', bg: _midnight, fg: _gold),
                  const SizedBox(width: 8.0),
                  const Expanded(child: Text('output = Train A (0.25)', style: TextStyle(fontSize: 12.0, color: _midnight))),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _parchment,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _gold.withOpacity(0.4)),
          ),
          child: Column(
            children: <Widget>[
              track('Train A', 0.50, _wine),
              const SizedBox(height: 6.0),
              track('Train B', 0.50, _moss),
              const SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  _pill('frame 2 — crossing', bg: _goldDeep, fg: _cream),
                  const SizedBox(width: 8.0),
                  const Expanded(child: Text('hop occurs, onSwitchedTrain fires', style: TextStyle(fontSize: 12.0, color: _midnight))),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _parchment,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _gold.withOpacity(0.4)),
          ),
          child: Column(
            children: <Widget>[
              track('Train A', 0.70, _wine),
              const SizedBox(height: 6.0),
              track('Train B', 0.85, _moss),
              const SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  _pill('frame 3', bg: _midnight, fg: _gold),
                  const SizedBox(width: 8.0),
                  const Expanded(child: Text('output = Train B (0.85)', style: TextStyle(fontSize: 12.0, color: _midnight))),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 11 — Recipe cards
// ============================================================================
Widget _recipeCards() {
  Widget recipe(String title, String when, String code, {Color accent = _gold}) {
    return Container(
      width: 320.0,
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: _parchment,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: accent.withOpacity(0.7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28.0,
                height: 28.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Text('R', style: TextStyle(color: _cream, fontWeight: FontWeight.w800)),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(title,
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.0, color: _midnight)),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text('When: $when', style: const TextStyle(fontSize: 12.0, color: _slate, fontStyle: FontStyle.italic)),
          const SizedBox(height: 8.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: _midnight,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(code,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: _goldLight,
                  height: 1.45,
                )),
          ),
        ],
      ),
    );
  }

  return _card(
    bg: _cream,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('11', 'Recipe cards',
            'Six everyday patterns that combine these wrappers.'),
        const SizedBox(height: 12.0),
        _goldRule(),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            recipe(
              'Fade in with easeOut',
              'gentle decelerating opacity ramp',
              'final fade = CurvedAnimation(\n  parent: controller,\n  curve: Curves.easeOut,\n);\nFadeTransition(opacity: fade);',
            ),
            recipe(
              'Bouncy entrance',
              'springy scale on enter',
              'final pop = CurvedAnimation(\n  parent: controller,\n  curve: Curves.elasticOut,\n);\nScaleTransition(scale: pop);',
              accent: _wineLight,
            ),
            recipe(
              'Stagger via Interval',
              'each row joins later in the timeline',
              'final r1 = CurvedAnimation(\n  parent: controller,\n  curve: Interval(0.0, 0.4),\n);\nfinal r2 = CurvedAnimation(\n  parent: controller,\n  curve: Interval(0.4, 1.0),\n);',
              accent: _moss,
            ),
            recipe(
              'Reverse-on-pop',
              'use a wrapper instead of running controller.reverse',
              'final exit = ReverseAnimation(enter);\nFadeTransition(opacity: exit);',
              accent: _wine,
            ),
            recipe(
              'Snapshot at a value',
              'feed a frozen value where Animation<T> is required',
              'final frozen =\n  AlwaysStoppedAnimation<double>(0.6);\nFadeTransition(opacity: frozen);',
              accent: _slate,
            ),
            recipe(
              'Mix two controllers via Min',
              'progress = min(downloadA, downloadB)',
              'final combined = AnimationMin(a, b);\nLinearProgressIndicator(\n  value: combined.value,\n);',
              accent: _goldDeep,
            ),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 12 — Comparison table
// ============================================================================
Widget _comparisonTable() {
  final List<Map<String, String>> rows = <Map<String, String>>[
    <String, String>{
      'name': 'CurvedAnimation',
      'changes': 'bends t through a Curve (and reverseCurve)',
      'cost': 'one function call per tick',
    },
    <String, String>{
      'name': 'ReverseAnimation',
      'changes': 'flips value (1-t) and mirrors status',
      'cost': 'one subtraction per tick',
    },
    <String, String>{
      'name': 'ProxyAnimation',
      'changes': 'delegates to a parent that can be null or swapped',
      'cost': 'one dispatch per tick',
    },
    <String, String>{
      'name': 'AlwaysStoppedAnimation',
      'changes': 'returns a constant; addListener is a no-op',
      'cost': 'zero — listeners never fire',
    },
    <String, String>{
      'name': 'AnimationMin',
      'changes': 'emits min(left, right)',
      'cost': 'one comparison per tick',
    },
    <String, String>{
      'name': 'AnimationMax',
      'changes': 'emits max(left, right)',
      'cost': 'one comparison per tick',
    },
    <String, String>{
      'name': 'AnimationMean',
      'changes': 'emits (left + right) / 2',
      'cost': 'one addition + divide per tick',
    },
    <String, String>{
      'name': 'TrainHoppingAnimation',
      'changes': 'follows one parent, hops to the other on crossing',
      'cost': 'one compare per tick + listener juggle',
    },
  ];

  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('12', 'Comparison table',
            'Each wrapper vs what it changes vs what it costs at runtime.'),
        const SizedBox(height: 12.0),
        _goldRule(),
        const SizedBox(height: 12.0),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: _gold.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                decoration: const BoxDecoration(
                  color: _midnight,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                ),
                child: Row(
                  children: const <Widget>[
                    SizedBox(width: 200.0, child: Text('class', style: TextStyle(color: _gold, fontWeight: FontWeight.w700, fontSize: 12.0))),
                    Expanded(child: Text('what it changes', style: TextStyle(color: _gold, fontWeight: FontWeight.w700, fontSize: 12.0))),
                    SizedBox(width: 180.0, child: Text('cost per tick', style: TextStyle(color: _gold, fontWeight: FontWeight.w700, fontSize: 12.0))),
                  ],
                ),
              ),
              for (int i = 0; i < rows.length; i++)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: i.isEven ? _parchment : _cream,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 200.0,
                        child: Text(rows[i]['name']!,
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0, color: _midnight)),
                      ),
                      Expanded(
                        child: Text(rows[i]['changes']!,
                            style: const TextStyle(fontSize: 12.0, color: _midnight, height: 1.45)),
                      ),
                      SizedBox(
                        width: 180.0,
                        child: Text(rows[i]['cost']!,
                            style: const TextStyle(fontSize: 12.0, color: _slate, fontFamily: 'monospace')),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 13 — Pitfalls
// ============================================================================
Widget _pitfalls() {
  Widget pitfall(String title, String body, {Color accent = _wine}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: _parchment,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: accent.withOpacity(0.7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 22.0,
                height: 22.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: accent, borderRadius: BorderRadius.circular(11.0)),
                child: const Text('!', style: TextStyle(color: _cream, fontWeight: FontWeight.w800)),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.0, color: _midnight)),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(body, style: const TextStyle(fontSize: 12.5, color: _midnight, height: 1.5)),
        ],
      ),
    );
  }

  return _card(
    bg: _cream,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('13', 'Pitfalls and gotchas',
            'Subtle traps when composing wrappers.'),
        const SizedBox(height: 12.0),
        _goldRule(),
        const SizedBox(height: 12.0),
        pitfall(
          'CurvedAnimation needs a parent that travels 0 → 1',
          'Feeding a non-normalized parent (say a Tween<double> that ranges 0 → 200) into '
          'CurvedAnimation gives nonsense values — the curve formula is only defined on [0, 1].',
        ),
        pitfall(
          'reverseCurve only kicks in for reverse motion',
          'If you set both curve: easeOut and reverseCurve: easeIn but the controller never '
          'plays in reverse, reverseCurve is dead weight.',
          accent: _goldDeep,
        ),
        pitfall(
          'ProxyAnimation parent ownership',
          'ProxyAnimation does not dispose its parent — it only listens. Make sure whoever '
          'created the parent AnimationController disposes it.',
          accent: _moss,
        ),
        pitfall(
          'AlwaysStoppedAnimation never notifies',
          'If a widget rebuilds based on listener notifications, it will never rebuild from '
          'an AlwaysStoppedAnimation alone — that\'s by design.',
          accent: _slate,
        ),
        pitfall(
          'TrainHoppingAnimation switches once and is then locked',
          'Once it has hopped to next train it follows that one forever. To rotate again you '
          'need a new TrainHoppingAnimation instance.',
          accent: _wineLight,
        ),
        pitfall(
          'CompoundAnimation listeners are based on both parents',
          'Because both parents must register listeners, disposing only one leaves the '
          'compound in a half-broken state.',
          accent: _wine,
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 14 — Glossary
// ============================================================================
Widget _glossary() {
  final List<List<String>> terms = <List<String>>[
    <String>['Animation<T>', 'A value of type T that changes over time and notifies listeners.'],
    <String>['AnimationStatus', 'Enum: dismissed, forward, reverse, completed.'],
    <String>['AnimationController', 'The one Animation<double> with a vsync ticker that drives time.'],
    <String>['Tween<T>', 'A pair (begin, end) projected by t into a T value.'],
    <String>['Curve', 'A function [0,1] → [0,1] that re-shapes time.'],
    <String>['Curves', 'The catalog of named Curve instances.'],
    <String>['CurvedAnimation', 'Wraps a parent Animation<double>, exposes curve.transform(parent.value).'],
    <String>['ReverseAnimation', 'Exposes 1 - parent.value with status mirrored.'],
    <String>['ProxyAnimation', 'Delegates to a swappable parent, value is 0 with no parent.'],
    <String>['AlwaysStoppedAnimation', 'A frozen value; listeners are never called.'],
    <String>['CompoundAnimation', 'Base class for mixing two parents into one Animation<T>.'],
    <String>['AnimationMin', 'CompoundAnimation that emits the smaller of the two values.'],
    <String>['AnimationMax', 'CompoundAnimation that emits the larger of the two values.'],
    <String>['AnimationMean', 'CompoundAnimation that emits (left + right) / 2.'],
    <String>['Interval', 'Curve that clips to [begin, end] and optionally re-curves inside.'],
    <String>['Threshold', 'Curve that is 0 below cutoff and 1 above — a step function.'],
    <String>['Cubic', 'Curve defined by cubic bezier control points like CSS easings.'],
    <String>['FlippedCurve', 'Wraps a curve c into 1 - c.transform(1 - t).'],
    <String>['SawTooth', 'Curve that produces n triangular ramps over [0,1].'],
    <String>['TrainHoppingAnimation', 'Tracks parent A, hops to parent B when their values cross.'],
  ];

  return _card(
    bg: _parchment,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('14', 'Glossary',
            'Twenty terms from the animation utility vocabulary.'),
        const SizedBox(height: 12.0),
        _goldRule(),
        const SizedBox(height: 12.0),
        for (final List<String> t in terms)
          Container(
            margin: const EdgeInsets.only(bottom: 6.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: _cream,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: _gold.withOpacity(0.35)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 180.0,
                  child: Text(
                    t[0],
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w700,
                      color: _midnight,
                      fontSize: 12.5,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(t[1],
                      style: const TextStyle(fontSize: 12.5, color: _midnight, height: 1.5)),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 15 — Epilogue
// ============================================================================
Widget _epilogue() {
  return Container(
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_midnight, _midnightDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _gold.withOpacity(0.55)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _pill('epilogue', bg: _gold, fg: _midnight),
            const SizedBox(width: 8.0),
            const Text(
              'Curtain call',
              style: TextStyle(color: _cream, fontSize: 20.0, fontWeight: FontWeight.w800),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'You now have a full set of wrappers for re-voicing any Animation<double>. '
          'Use CurvedAnimation to bend time, ReverseAnimation to mirror it, '
          'ProxyAnimation to make the parent late-bound, AlwaysStoppedAnimation when '
          'you only have a value, and the CompoundAnimation family when two voices '
          'need to be combined. None of them owns a ticker — every one of them piggy-backs '
          'on the source. Pair them with the right Curve from the catalog, and the '
          'orchestra plays without ever needing a second conductor.',
          style: TextStyle(
            color: _cream,
            fontSize: 13.0,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: _midnightDeep.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _gold.withOpacity(0.35)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'curve = Curves.fastOutSlowIn',
                style: TextStyle(color: _goldLight, fontFamily: 'monospace', fontSize: 12.0),
              ),
              const SizedBox(height: 4.0),
              Text(
                'parent = AnimationController(...)',
                style: TextStyle(color: _goldLight, fontFamily: 'monospace', fontSize: 12.0),
              ),
              const SizedBox(height: 4.0),
              Text(
                'shaped = CurvedAnimation(parent: parent, curve: curve)',
                style: TextStyle(color: _goldLight, fontFamily: 'monospace', fontSize: 12.0),
              ),
              const SizedBox(height: 4.0),
              Text(
                'reversed = ReverseAnimation(shaped)',
                style: TextStyle(color: _goldLight, fontFamily: 'monospace', fontSize: 12.0),
              ),
              const SizedBox(height: 4.0),
              Text(
                'combined = AnimationMean(left: shaped, right: reversed)',
                style: TextStyle(color: _goldLight, fontFamily: 'monospace', fontSize: 12.0),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// MATH HELPER — exercise the `math` import in a tiny way
// ============================================================================
Widget _mathSanityBar() {
  final double sample = math.sin(math.pi / 4.0); // ~ 0.707
  return Padding(
    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
    child: Row(
      children: <Widget>[
        const SizedBox(
          width: 180.0,
          child: Text('sin(π/4) reference',
              style: TextStyle(fontSize: 11.5, color: _slate)),
        ),
        Expanded(child: _progressBar(sample, fill: _goldDeep)),
        const SizedBox(width: 8.0),
        Text(sample.toStringAsFixed(3),
            style: const TextStyle(
              fontSize: 11.0,
              color: _slate,
              fontFamily: 'monospace',
            )),
      ],
    ),
  );
}

// ============================================================================
// MAIN BUILD
// ============================================================================
dynamic build(BuildContext context) {
  // Pre-instantiate every wrapper kind so the test surface is real even
  // before any widget renders — this is the actual D4rt assertion target.
  const AlwaysStoppedAnimation<double> probeStopped = AlwaysStoppedAnimation<double>(0.5);
  final CurvedAnimation probeCurved = CurvedAnimation(
    parent: probeStopped,
    curve: Curves.easeInOut,
    reverseCurve: Curves.easeIn,
  );
  final ReverseAnimation probeReverse = ReverseAnimation(probeStopped);
  final ProxyAnimation probeProxy = ProxyAnimation(probeStopped);
  final AnimationMin<double> probeMin = AnimationMin<double>(probeStopped, probeStopped);
  final AnimationMax<double> probeMax = AnimationMax<double>(probeStopped, probeStopped);
  final AnimationMean probeMean = AnimationMean(left: probeStopped, right: probeStopped);

  // Touch the values so the analyzer keeps these alive without warnings.
  final List<String> probeReadout = <String>[
    'curved=${probeCurved.value.toStringAsFixed(3)}',
    'reverse=${probeReverse.value.toStringAsFixed(3)}',
    'proxy=${probeProxy.value.toStringAsFixed(3)}',
    'min=${probeMin.value.toStringAsFixed(3)}',
    'max=${probeMax.value.toStringAsFixed(3)}',
    'mean=${probeMean.value.toStringAsFixed(3)}',
    'status=${probeStopped.status.name}',
    'completed=${probeStopped.isCompleted}',
    'dismissed=${probeStopped.isDismissed}',
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Animation utilities — wrappers, mixers, and the curves catalog',
    home: Scaffold(
      backgroundColor: _parchment,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _heroHeader(),
              const SizedBox(height: 22.0),
              _conceptOverview(),
              const SizedBox(height: 18.0),
              _wrapperTree(),
              const SizedBox(height: 18.0),
              _curvedAnimationShowcase(),
              const SizedBox(height: 18.0),
              _curvesCatalog(),
              const SizedBox(height: 18.0),
              _customCurves(),
              const SizedBox(height: 18.0),
              _reverseAnimationDemo(),
              const SizedBox(height: 18.0),
              _proxyAnimationDemo(),
              const SizedBox(height: 18.0),
              _alwaysStoppedDemo(),
              const SizedBox(height: 18.0),
              _compoundFamily(),
              const SizedBox(height: 18.0),
              _trainHoppingDiagram(),
              const SizedBox(height: 18.0),
              _recipeCards(),
              const SizedBox(height: 18.0),
              _comparisonTable(),
              const SizedBox(height: 18.0),
              _pitfalls(),
              const SizedBox(height: 18.0),
              _glossary(),
              const SizedBox(height: 18.0),
              // Footer — staff motif + math sanity + probe readout
              _card(
                bg: _cream,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _sectionTitle('15', 'Engineering footer',
                        'staff motif, math sanity check, live probe readout.'),
                    const SizedBox(height: 12.0),
                    _goldRule(),
                    const SizedBox(height: 12.0),
                    _staff(),
                    const SizedBox(height: 12.0),
                    Row(
                      children: <Widget>[
                        _noteDot(0.0, color: _navy, size: 10.0),
                        const SizedBox(width: 6.0),
                        _noteDot(0.25, color: _gold, size: 10.0),
                        const SizedBox(width: 6.0),
                        _noteDot(0.5, color: _wineLight, size: 10.0),
                        const SizedBox(width: 6.0),
                        _noteDot(0.75, color: _mossLight, size: 10.0),
                        const SizedBox(width: 6.0),
                        _noteDot(1.0, color: _goldDeep, size: 10.0),
                        const SizedBox(width: 10.0),
                        const Text(
                          'five sample notes on the staff',
                          style: TextStyle(
                            fontSize: 11.0,
                            color: _slate,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    _mathSanityBar(),
                    const SizedBox(height: 8.0),
                    for (final String r in probeReadout)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1.0),
                        child: Text(
                          r,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11.5,
                            color: _midnight,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 18.0),
              _epilogue(),
              const SizedBox(height: 30.0),
              Center(
                child: Text(
                  '— fin —',
                  style: TextStyle(
                    color: _slateSoft,
                    fontSize: 13.0,
                    letterSpacing: 4.0,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    ),
  );
}
