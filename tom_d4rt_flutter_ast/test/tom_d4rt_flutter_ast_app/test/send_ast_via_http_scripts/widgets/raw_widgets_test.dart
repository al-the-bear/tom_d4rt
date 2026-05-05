// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =====================================================================
//  RAW WIDGETS — VISUAL TOUR
// ---------------------------------------------------------------------
//  A deep tour of the Raw* family in Flutter:
//     RawScrollbar, RawGestureDetector, InheritedNotifier,
//     WillPopScope (and its successor PopScope), DefaultAssetBundle.
//
//  The "Raw" prefix in Flutter means: "the building block, with no
//  Material or Cupertino styling". Polished widgets like Scrollbar
//  and GestureDetector are thin wrappers around their Raw* siblings.
// =====================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';

dynamic build(BuildContext context) {
  // ------------------------------------------------------------------
  //  PALETTE — slate / teal / amber, distinct from sibling demos.
  // ------------------------------------------------------------------
  const Color slateDeep = Color(0xFF0E1F2B);
  const Color slateMid = Color(0xFF18374A);
  const Color slateSoft = Color(0xFF274B62);
  const Color tealBright = Color(0xFF22C5C5);
  const Color tealSoft = Color(0xFF7CE2E2);
  const Color amber = Color(0xFFE8A83C);
  const Color amberSoft = Color(0xFFF5D58A);
  const Color paper = Color(0xFFF4F8FA);
  const Color ink = Color(0xFF0A1620);
  const Color danger = Color(0xFFE05656);

  print('[raw_widgets_test] starting build');

  // ------------------------------------------------------------------
  //  Helper: tiny labelled chip.
  // ------------------------------------------------------------------
  Widget chip(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: fg,
          fontSize: 11.0,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
      ),
    );
  }

  // ------------------------------------------------------------------
  //  Helper: section title.
  // ------------------------------------------------------------------
  Widget sectionTitle(String number, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 24.0, 4.0, 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 36.0,
            height: 36.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tealBright,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              number,
              style: const TextStyle(
                color: slateDeep,
                fontWeight: FontWeight.w800,
                fontSize: 15.0,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: slateDeep,
                    fontSize: 19.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: slateDeep.withValues(alpha: 0.62),
                    fontSize: 12.5,
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

  // ------------------------------------------------------------------
  //  Helper: card frame.
  // ------------------------------------------------------------------
  Widget frame({
    required String title,
    required Widget child,
    Color? accent,
  }) {
    final Color a = accent ?? tealBright;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: a.withValues(alpha: 0.32), width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: slateDeep.withValues(alpha: 0.06),
            blurRadius: 8.0,
            offset: const Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 8.0,
            ),
            decoration: BoxDecoration(
              color: a.withValues(alpha: 0.14),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(13.0),
                topRight: Radius.circular(13.0),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: slateDeep,
                fontWeight: FontWeight.w700,
                fontSize: 13.0,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.all(14.0), child: child),
        ],
      ),
    );
  }

  // ==================================================================
  //  HERO HEADER
  // ==================================================================
  final Widget hero = Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(28.0, 30.0, 28.0, 30.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[slateDeep, slateMid, slateSoft],
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: slateDeep.withValues(alpha: 0.30),
          blurRadius: 18.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            chip('FAMILY', tealBright, slateDeep),
            const SizedBox(width: 8.0),
            chip('5 WIDGETS', amber, slateDeep),
            const SizedBox(width: 8.0),
            chip('LOW LEVEL', Colors.white24, Colors.white),
          ],
        ),
        const SizedBox(height: 16.0),
        const Text(
          'The Raw Widgets',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'building blocks below the polished APIs',
          style: TextStyle(
            color: tealSoft.withValues(alpha: 0.92),
            fontSize: 15.0,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.white24, width: 1.0),
          ),
          child: const Text(
            'Every "polished" widget you use day to day — Scrollbar, '
            'GestureDetector, InheritedWidget — has a "Raw" sibling that '
            'exposes the underlying machinery without imposing Material '
            'or Cupertino styling. This file tours five of them.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );

  // ==================================================================
  //  SECTION 1 — RawScrollbar showcase (six stylings)
  // ==================================================================
  Widget rawScrollbarCell({
    required String label,
    required double thickness,
    required double radiusVal,
    required Color thumb,
    required bool thumbVisible,
    required bool interactive,
    String? note,
  }) {
    final ScrollController c = ScrollController();
    Widget scrollbar;
    try {
      scrollbar = RawScrollbar(
        controller: c,
        thumbVisibility: thumbVisible,
        thickness: thickness,
        radius: Radius.circular(radiusVal),
        thumbColor: thumb,
        fadeDuration: const Duration(milliseconds: 250),
        timeToFade: const Duration(milliseconds: 600),
        mainAxisMargin: 4.0,
        crossAxisMargin: 2.0,
        interactive: interactive,
        padding: const EdgeInsets.all(2.0),
        scrollbarOrientation: ScrollbarOrientation.right,
        child: ListView.builder(
          controller: c,
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 14.0, 8.0),
          itemCount: 18,
          itemBuilder: (BuildContext _, int i) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 3.0),
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: paper,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'row ${i.toString().padLeft(2, '0')}',
                style: const TextStyle(fontSize: 10.5, color: ink),
              ),
            );
          },
        ),
      );
    } catch (e) {
      scrollbar = Container(
        alignment: Alignment.center,
        color: danger.withValues(alpha: 0.10),
        child: Text(
          'RawScrollbar bridge error: $e',
          style: const TextStyle(fontSize: 10.0, color: danger),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: slateSoft.withValues(alpha: 0.22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 6.0,
            ),
            decoration: BoxDecoration(
              color: slateMid,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(9.0),
                topRight: Radius.circular(9.0),
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  width: 10.0,
                  height: 10.0,
                  decoration: BoxDecoration(
                    color: thumb,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 140.0, child: scrollbar),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 6.0,
            ),
            decoration: BoxDecoration(
              color: paper,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(9.0),
                bottomRight: Radius.circular(9.0),
              ),
            ),
            child: Text(
              note ??
                  't=$thickness r=$radiusVal vis=$thumbVisible '
                      'interactive=$interactive',
              style: TextStyle(
                fontSize: 9.5,
                color: ink.withValues(alpha: 0.72),
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  final List<Widget> scrollbarCells = <Widget>[
    rawScrollbarCell(
      label: 'thin / sharp',
      thickness: 3.0,
      radiusVal: 0.0,
      thumb: slateDeep,
      thumbVisible: true,
      interactive: true,
    ),
    rawScrollbarCell(
      label: 'classic',
      thickness: 6.0,
      radiusVal: 3.0,
      thumb: tealBright,
      thumbVisible: true,
      interactive: true,
    ),
    rawScrollbarCell(
      label: 'fat / rounded',
      thickness: 12.0,
      radiusVal: 6.0,
      thumb: amber,
      thumbVisible: true,
      interactive: true,
    ),
    rawScrollbarCell(
      label: 'auto-hide',
      thickness: 5.0,
      radiusVal: 2.0,
      thumb: slateMid,
      thumbVisible: false,
      interactive: true,
      note: 'thumbVisibility=false → fades out after timeToFade',
    ),
    rawScrollbarCell(
      label: 'non-interactive',
      thickness: 4.0,
      radiusVal: 2.0,
      thumb: slateSoft,
      thumbVisible: true,
      interactive: false,
      note: 'interactive=false → indicator only, no drag',
    ),
    rawScrollbarCell(
      label: 'translucent',
      thickness: 8.0,
      radiusVal: 4.0,
      thumb: tealBright.withValues(alpha: 0.45),
      thumbVisible: true,
      interactive: true,
      note: 'alpha=0.45, ghostly',
    ),
  ];

  Widget scrollbarGrid = LayoutBuilder(
    builder: (BuildContext _, BoxConstraints bc) {
      final int cols = bc.maxWidth > 720.0 ? 3 : 2;
      final List<Row> rows = <Row>[];
      for (int i = 0; i < scrollbarCells.length; i += cols) {
        final List<Widget> rowChildren = <Widget>[];
        for (int j = 0; j < cols; j++) {
          final int idx = i + j;
          if (idx < scrollbarCells.length) {
            rowChildren.add(Expanded(child: scrollbarCells[idx]));
          } else {
            rowChildren.add(const Expanded(child: SizedBox.shrink()));
          }
          if (j < cols - 1) {
            rowChildren.add(const SizedBox(width: 12.0));
          }
        }
        rows.add(Row(children: rowChildren));
      }
      final List<Widget> withGaps = <Widget>[];
      for (int i = 0; i < rows.length; i++) {
        withGaps.add(rows[i]);
        if (i < rows.length - 1) {
          withGaps.add(const SizedBox(height: 12.0));
        }
      }
      return Column(children: withGaps);
    },
  );

  // ==================================================================
  //  SECTION 2 — RawGestureDetector anatomy
  // ==================================================================
  Widget arenaDiagram() {
    Widget node(String label, Color bg, Color fg) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: fg,
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }

    Widget arrow() {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.0),
        child: Text(
          '→',
          style: TextStyle(
            color: slateMid,
            fontSize: 18.0,
            fontWeight: FontWeight.w900,
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        node('Pointer Event', amberSoft, ink),
        arrow(),
        node('Recognizer', tealSoft, ink),
        arrow(),
        node('Gesture Arena', slateMid, Colors.white),
        arrow(),
        node('Winner Callback', tealBright, ink),
      ],
    );
  }

  // Wrap RawGestureDetector — its factory map is bridged, so try/catch.
  Widget rawGestureSample;
  try {
    rawGestureSample = RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        TapGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
              () => TapGestureRecognizer(),
              (TapGestureRecognizer r) {
                r.onTap = () {
                  print('[RawGestureDetector] tap recognised');
                };
              },
            ),
        LongPressGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
              () => LongPressGestureRecognizer(),
              (LongPressGestureRecognizer r) {
                r.onLongPress = () {
                  print('[RawGestureDetector] long-press recognised');
                };
              },
            ),
      },
      child: Container(
        height: 60.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: tealBright.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: tealBright, width: 1.4),
        ),
        child: const Text(
          'tap or long-press me  (RawGestureDetector with custom factories)',
          style: TextStyle(
            color: ink,
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  } catch (e) {
    rawGestureSample = Container(
      height: 60.0,
      alignment: Alignment.center,
      color: danger.withValues(alpha: 0.10),
      child: Text(
        'RawGestureDetector bridge error: $e',
        style: const TextStyle(color: danger, fontSize: 11.0),
      ),
    );
  }

  // Edge case: empty gesture map.
  Widget emptyGestureSample;
  try {
    emptyGestureSample = RawGestureDetector(
      gestures: const <Type, GestureRecognizerFactory>{},
      child: Container(
        height: 40.0,
        alignment: Alignment.center,
        color: paper,
        child: const Text(
          'empty gestures map → behaves like a passthrough',
          style: TextStyle(fontSize: 10.5, color: ink),
        ),
      ),
    );
  } catch (e) {
    emptyGestureSample = Text(
      'empty-gesture bridge error: $e',
      style: const TextStyle(color: danger, fontSize: 10.5),
    );
  }

  final Widget rawGestureCard = frame(
    title: 'RawGestureDetector — recognisers and the arena',
    accent: amber,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'A polished GestureDetector hides the recogniser plumbing. '
          'RawGestureDetector exposes it: you supply a '
          'Map<Type, GestureRecognizerFactory> and decide which '
          'recognisers compete in the arena.',
          style: TextStyle(color: ink, fontSize: 12.5, height: 1.45),
        ),
        const SizedBox(height: 12.0),
        arenaDiagram(),
        const SizedBox(height: 14.0),
        rawGestureSample,
        const SizedBox(height: 10.0),
        emptyGestureSample,
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: slateDeep,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: const Text(
            'gestures: <Type, GestureRecognizerFactory>{\n'
            '  TapGestureRecognizer: GestureRecognizerFactoryWithHandlers<\n'
            '    TapGestureRecognizer>(\n'
            '      () => TapGestureRecognizer(),\n'
            '      (r) => r.onTap = () => print("tap"),\n'
            '  ),\n'
            '},',
            style: TextStyle(
              color: tealSoft,
              fontFamily: 'monospace',
              fontSize: 11.0,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  // ==================================================================
  //  SECTION 3 — InheritedNotifier explainer
  // ==================================================================
  // Use ValueNotifier (concrete) instead of subclassing ChangeNotifier.
  final ValueNotifier<int> counterNotifier = ValueNotifier<int>(0);
  counterNotifier.value = 7; // demonstrate value setter
  print('[InheritedNotifier] counter = ${counterNotifier.value}');

  Widget lifecycleStep(String n, String label, Color c) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: c.withValues(alpha: 0.45)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 18.0,
            height: 18.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(9.0),
            ),
            child: Text(
              n,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 6.0),
          Text(
            label,
            style: const TextStyle(
              color: ink,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  final Widget inheritedNotifierCard = frame(
    title: 'InheritedNotifier — Listenable gives you free rebuilds',
    accent: tealBright,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'InheritedNotifier<T extends Listenable> wraps a Listenable and '
          'rebuilds dependents whenever it fires. Combined with '
          'ValueNotifier<T>, you get a tiny reactive primitive without '
          'pulling in a state-management library.',
          style: TextStyle(color: ink, fontSize: 12.5, height: 1.45),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            lifecycleStep('1', 'notifier.value = X', tealBright),
            lifecycleStep('2', 'notifyListeners()', amber),
            lifecycleStep('3', 'didNotify() returns true', slateMid),
            lifecycleStep('4', 'dependents rebuild', danger),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: paper,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: slateSoft.withValues(alpha: 0.22)),
          ),
          child: Row(
            children: <Widget>[
              const Icon(Icons.numbers, color: tealBright, size: 18.0),
              const SizedBox(width: 8.0),
              Text(
                'current ValueNotifier<int>.value = ${counterNotifier.value}',
                style: const TextStyle(
                  color: ink,
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: slateDeep,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: const Text(
            'class CounterScope extends InheritedNotifier<ValueNotifier<int>> {\n'
            '  const CounterScope({\n'
            '    required ValueNotifier<int> notifier,\n'
            '    required Widget child,\n'
            '  }) : super(notifier: notifier, child: child);\n'
            '}',
            style: TextStyle(
              color: tealSoft,
              fontFamily: 'monospace',
              fontSize: 11.0,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  // ==================================================================
  //  SECTION 4 — WillPopScope vs PopScope
  // ==================================================================
  Widget codeCard(String title, String body, Color accent, String tag) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: slateDeep,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: accent, width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              chip(tag, accent, slateDeep),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            body,
            style: TextStyle(
              color: tealSoft.withValues(alpha: 0.92),
              fontFamily: 'monospace',
              fontSize: 11.0,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  final Widget popCompare = frame(
    title: 'WillPopScope (deprecated) → PopScope',
    accent: danger,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'WillPopScope intercepted Navigator.maybePop and asked '
          '"may I pop?" via an async callback. It was deprecated in '
          'Flutter 3.12 in favour of PopScope, which integrates with '
          'predictive-back gestures on Android 14+.',
          style: TextStyle(color: ink, fontSize: 12.5, height: 1.45),
        ),
        const SizedBox(height: 12.0),
        LayoutBuilder(
          builder: (BuildContext _, BoxConstraints bc) {
            final bool wide = bc.maxWidth > 620.0;
            final Widget left = codeCard(
              'WillPopScope (legacy)',
              'WillPopScope(\n'
                  '  onWillPop: () async {\n'
                  '    final go = await confirm();\n'
                  '    return go; // true → pop\n'
                  '  },\n'
                  '  child: ...,\n'
                  ');',
              danger,
              'DEPRECATED',
            );
            final Widget right = codeCard(
              'PopScope (modern)',
              'PopScope(\n'
                  '  canPop: false,\n'
                  '  onPopInvokedWithResult:\n'
                  '    (didPop, result) {\n'
                  '      if (didPop) return;\n'
                  '      confirmThen(context);\n'
                  '    },\n'
                  '  child: ...,\n'
                  ');',
              tealBright,
              'PREFERRED',
            );
            if (wide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(child: left),
                  const SizedBox(width: 12.0),
                  Expanded(child: right),
                ],
              );
            }
            return Column(
              children: <Widget>[
                left,
                const SizedBox(height: 12.0),
                right,
              ],
            );
          },
        ),
      ],
    ),
  );

  // ==================================================================
  //  SECTION 5 — DefaultAssetBundle
  // ==================================================================
  // Look up the inherited bundle (returns rootBundle if no override).
  AssetBundle? lookedUpBundle;
  String bundleType = '<unresolved>';
  try {
    lookedUpBundle = DefaultAssetBundle.of(context);
    bundleType = lookedUpBundle.runtimeType.toString();
  } catch (e) {
    bundleType = 'lookup failed: $e';
  }
  print('[DefaultAssetBundle] resolved: $bundleType');

  Widget bundleRow(String name, String purpose, Color accent) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: paper,
        borderRadius: BorderRadius.circular(8.0),
        border: Border(
          left: BorderSide(color: accent, width: 4.0),
        ),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 180.0,
            child: Text(
              name,
              style: const TextStyle(
                color: ink,
                fontSize: 12.0,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              purpose,
              style: TextStyle(
                color: ink.withValues(alpha: 0.78),
                fontSize: 12.0,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget assetBundleCard = frame(
    title: 'DefaultAssetBundle — the inherited bundle for assets',
    accent: amber,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'DefaultAssetBundle.of(context) is what AssetImage and '
          'rootBundle-aware widgets call when resolving assets. '
          'You can override it with a different AssetBundle in tests '
          '(e.g. an in-memory bundle) or to swap the asset source.',
          style: TextStyle(color: ink, fontSize: 12.5, height: 1.45),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: slateDeep,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'DefaultAssetBundle.of(context)\n  → $bundleType',
            style: TextStyle(
              color: tealSoft.withValues(alpha: 0.92),
              fontFamily: 'monospace',
              fontSize: 11.5,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        bundleRow(
          'PlatformAssetBundle',
          'Loads via the platform messages channel (the default in apps).',
          tealBright,
        ),
        bundleRow(
          'NetworkAssetBundle',
          'Loads assets over HTTP from a base URL (rare, mostly tests).',
          amber,
        ),
        bundleRow(
          'CachingAssetBundle',
          'Abstract base that memoises previously loaded keys.',
          slateMid,
        ),
        bundleRow(
          'rootBundle',
          'Top-level AssetBundle constant — used when context lookup fails.',
          danger,
        ),
      ],
    ),
  );

  // ==================================================================
  //  SECTION 6 — comparison table (Raw → polished)
  // ==================================================================
  Widget compareRow(String raw, String polished, String diff) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: slateSoft.withValues(alpha: 0.18)),
        ),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 170.0,
            child: Text(
              raw,
              style: const TextStyle(
                color: tealBright,
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const Text(
            '→',
            style: TextStyle(color: slateMid, fontWeight: FontWeight.w900),
          ),
          const SizedBox(width: 10.0),
          SizedBox(
            width: 170.0,
            child: Text(
              polished,
              style: const TextStyle(
                color: amber,
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              diff,
              style: const TextStyle(color: ink, fontSize: 11.5),
            ),
          ),
        ],
      ),
    );
  }

  final Widget comparisonCard = frame(
    title: 'Raw → polished sibling cheat-sheet',
    accent: tealBright,
    child: Column(
      children: <Widget>[
        compareRow(
          'RawScrollbar',
          'Scrollbar',
          'Scrollbar adds Material/Cupertino theme styling on top.',
        ),
        compareRow(
          'RawGestureDetector',
          'GestureDetector',
          'GestureDetector exposes named callbacks instead of a factory map.',
        ),
        compareRow(
          'InheritedNotifier',
          'AnimatedBuilder',
          'AnimatedBuilder is one-shot rebuilder; InheritedNotifier scopes it.',
        ),
        compareRow(
          'WillPopScope',
          'PopScope',
          'PopScope integrates with predictive back; replaces async vetoes.',
        ),
        compareRow(
          'DefaultAssetBundle',
          'AssetImage / rootBundle',
          'DefaultAssetBundle is the inherited lookup; AssetImage is the consumer.',
        ),
      ],
    ),
  );

  // ==================================================================
  //  SECTION 7 — field reference cards
  // ==================================================================
  Widget fieldsBlock(String title, List<List<String>> rows, Color accent) {
    final List<Widget> rowWidgets = <Widget>[];
    for (int i = 0; i < rows.length; i++) {
      final List<String> r = rows[i];
      rowWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 140.0,
                child: Text(
                  r[0],
                  style: TextStyle(
                    color: accent,
                    fontSize: 11.5,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  r[1],
                  style: TextStyle(
                    color: ink.withValues(alpha: 0.78),
                    fontSize: 11.5,
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return frame(
      title: title,
      accent: accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: rowWidgets,
      ),
    );
  }

  final Widget rawScrollbarFields = fieldsBlock(
    'RawScrollbar — fields',
    <List<String>>[
      <String>['controller', 'ScrollController to track. Required if multiple scroll views.'],
      <String>['thumbVisibility', 'bool — keep thumb visible always.'],
      <String>['trackVisibility', 'bool — show the track behind the thumb.'],
      <String>['thickness', 'double — width of the thumb in logical px.'],
      <String>['radius', 'Radius — corner radius of the thumb.'],
      <String>['thumbColor', 'Color — thumb fill colour.'],
      <String>['fadeDuration', 'Duration — fade-out animation length.'],
      <String>['timeToFade', 'Duration — idle time before fade starts.'],
      <String>['mainAxisMargin', 'double — inset along scroll axis.'],
      <String>['crossAxisMargin', 'double — inset across scroll axis.'],
      <String>['interactive', 'bool — can the user drag the thumb?'],
      <String>['scrollbarOrientation', 'ScrollbarOrientation — left/right/top/bottom.'],
      <String>['padding', 'EdgeInsets — padding around the scrollbar.'],
    ],
    tealBright,
  );

  final Widget rawGestureFields = fieldsBlock(
    'RawGestureDetector — fields',
    <List<String>>[
      <String>['gestures', 'Map<Type, GestureRecognizerFactory> — recogniser registry.'],
      <String>['behavior', 'HitTestBehavior — opaque / translucent / deferToChild.'],
      <String>['excludeFromSemantics', 'bool — hide the detector from the a11y tree.'],
      <String>['semantics', 'SemanticsGestureDelegate — custom semantics callbacks.'],
      <String>['child', 'Widget — the visual subtree the detector covers.'],
    ],
    amber,
  );

  final Widget popScopeFields = fieldsBlock(
    'PopScope — fields',
    <List<String>>[
      <String>['canPop', 'bool — true → pop normally; false → veto.'],
      <String>['onPopInvokedWithResult', '(bool didPop, T? result) — observer.'],
      <String>['child', 'Widget — the route subtree being protected.'],
    ],
    danger,
  );

  // ==================================================================
  //  SECTION 8 — edge cases
  // ==================================================================
  Widget edgeCase(String title, String body, IconData icon, Color colour) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: colour.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: colour.withValues(alpha: 0.45)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: colour, size: 18.0),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: colour,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3.0),
                Text(
                  body,
                  style: const TextStyle(
                    color: ink,
                    fontSize: 11.5,
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

  final Widget edgeCases = frame(
    title: 'Edge cases & gotchas',
    accent: slateMid,
    child: Column(
      children: <Widget>[
        edgeCase(
          'thumbVisibility: false without thumbColor',
          'The thumb fades out and may be invisible until you scroll. '
          'Always pair with a thumbColor for predictability.',
          Icons.visibility_off,
          danger,
        ),
        edgeCase(
          'RawScrollbar without controller',
          'When the inner scrollable has no controller, you must pass '
          'thumbVisibility: false or supply an explicit controller, '
          'else PrimaryScrollController is used and conflicts arise.',
          Icons.warning_amber,
          amber,
        ),
        edgeCase(
          'RawGestureDetector with empty gestures map',
          'It still hit-tests according to behavior, but no recogniser '
          'wins the arena → callbacks never fire.',
          Icons.gesture,
          tealBright,
        ),
        edgeCase(
          'WillPopScope inside nested Navigator',
          'Only intercepts the route it is attached to. For root pop '
          'on Android, attach at MaterialApp.builder level.',
          Icons.history,
          slateMid,
        ),
        edgeCase(
          'DefaultAssetBundle.of() before MaterialApp',
          'Returns rootBundle. Tests that need a custom bundle must '
          'wrap their widget under test in DefaultAssetBundle.',
          Icons.folder_open,
          amber,
        ),
      ],
    ),
  );

  // ==================================================================
  //  SECTION 9 — recogniser catalogue
  // ==================================================================
  Widget recognizerRow(
    String name,
    String fires,
    String wins,
    Color accent,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: paper,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: accent.withValues(alpha: 0.40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                name,
                style: TextStyle(
                  color: accent,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'fires on: $fires',
                  style: TextStyle(
                    color: ink.withValues(alpha: 0.78),
                    fontSize: 11.5,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  'arena: $wins',
                  style: TextStyle(
                    color: ink.withValues(alpha: 0.62),
                    fontSize: 11.0,
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

  final Widget recognizerCatalogue = frame(
    title: 'Common GestureRecognizer subclasses',
    accent: tealBright,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          'When you build a gesture map for RawGestureDetector you '
          'pick from this catalogue. Each recogniser is its own '
          'state machine that competes for pointer events in the '
          'gesture arena.',
          style: TextStyle(color: ink, fontSize: 12.5, height: 1.45),
        ),
        const SizedBox(height: 10.0),
        recognizerRow(
          'TapGestureRecognizer',
          'pointer up within slop & timeout',
          'wins immediately on confirmed tap',
          tealBright,
        ),
        recognizerRow(
          'DoubleTapGestureRecognizer',
          'two taps within kDoubleTapTimeout',
          'wins after second tap; defers tap to it',
          amber,
        ),
        recognizerRow(
          'LongPressGestureRecognizer',
          'pointer down ≥ kLongPressTimeout (500ms)',
          'wins by elapsed time; cancels tap',
          danger,
        ),
        recognizerRow(
          'PanGestureRecognizer',
          'pointer movement past kTouchSlop (≈18px)',
          'wins once movement exceeds the slop',
          slateMid,
        ),
        recognizerRow(
          'ScaleGestureRecognizer',
          'two-or-more pointers changing distance',
          'wins on pinch / spread above slop',
          slateSoft,
        ),
        recognizerRow(
          'VerticalDragGestureRecognizer',
          'vertical movement past slop',
          'wins on vertical-only drag; loses on diagonal',
          tealSoft,
        ),
        recognizerRow(
          'HorizontalDragGestureRecognizer',
          'horizontal movement past slop',
          'wins on horizontal-only drag; loses on diagonal',
          amberSoft,
        ),
      ],
    ),
  );

  // ==================================================================
  //  SECTION 10 — decision matrix
  // ==================================================================
  Widget decisionRow(
    String situation,
    String pick,
    String why,
    Color tint,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(11.0),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(9.0),
        border: Border(left: BorderSide(color: tint, width: 4.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  situation,
                  style: const TextStyle(
                    color: ink,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: tint,
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Text(
                  pick,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5.0),
          Text(
            why,
            style: TextStyle(
              color: ink.withValues(alpha: 0.74),
              fontSize: 11.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  final Widget decisionMatrix = frame(
    title: 'When to reach for Raw vs polished',
    accent: amber,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        decisionRow(
          'I want a scrollbar that matches my Material theme.',
          'Scrollbar',
          'Theme-aware colours, brightness handling, RTL support.',
          tealBright,
        ),
        decisionRow(
          'I need a scrollbar with custom thumb art / always-on.',
          'RawScrollbar',
          'Direct control of thickness, radius, colour, fade timing.',
          amber,
        ),
        decisionRow(
          'I want simple onTap / onLongPress callbacks.',
          'GestureDetector',
          'Named callbacks, hit-test behaviour, no factory boilerplate.',
          tealBright,
        ),
        decisionRow(
          'I need a custom recogniser or to disable specific ones.',
          'RawGestureDetector',
          'Manual factory map gives you full arena control.',
          amber,
        ),
        decisionRow(
          'I need cross-cutting state with reactive rebuilds.',
          'InheritedNotifier',
          'Pair with ValueNotifier; minimal API, no provider needed.',
          tealBright,
        ),
        decisionRow(
          'I need a nav-veto on Android predictive back.',
          'PopScope',
          'Modern API; integrates with system back gesture.',
          danger,
        ),
        decisionRow(
          'My test needs assets from a custom source.',
          'DefaultAssetBundle',
          'Wrap subject under test with an in-memory AssetBundle.',
          amber,
        ),
      ],
    ),
  );

  // ==================================================================
  //  SECTION 11 — bridge sanity check
  // ==================================================================
  // Touch each Raw widget once to make the bridge exercise the type.
  final List<String> bridgeNotes = <String>[];
  try {
    final ScrollController c = ScrollController();
    final RawScrollbar sb = RawScrollbar(
      controller: c,
      thumbVisibility: false,
      child: const SizedBox.shrink(),
    );
    bridgeNotes.add('RawScrollbar OK: ${sb.runtimeType}');
  } catch (e) {
    bridgeNotes.add('RawScrollbar bridge FAIL: $e');
  }
  try {
    final RawGestureDetector rg = RawGestureDetector(
      gestures: const <Type, GestureRecognizerFactory>{},
      child: const SizedBox.shrink(),
    );
    bridgeNotes.add('RawGestureDetector OK: ${rg.runtimeType}');
  } catch (e) {
    bridgeNotes.add('RawGestureDetector bridge FAIL: $e');
  }
  try {
    final PopScope<dynamic> ps = PopScope<dynamic>(
      canPop: true,
      child: const SizedBox.shrink(),
    );
    bridgeNotes.add('PopScope OK: ${ps.runtimeType}');
  } catch (e) {
    bridgeNotes.add('PopScope bridge FAIL: $e');
  }
  try {
    final DefaultAssetBundle dab = DefaultAssetBundle(
      bundle: lookedUpBundle ?? rootBundle,
      child: const SizedBox.shrink(),
    );
    bridgeNotes.add('DefaultAssetBundle OK: ${dab.runtimeType}');
  } catch (e) {
    bridgeNotes.add('DefaultAssetBundle bridge FAIL: $e');
  }

  final List<Widget> bridgeRows = <Widget>[];
  for (int i = 0; i < bridgeNotes.length; i++) {
    bridgeRows.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: Row(
          children: <Widget>[
            Icon(
              bridgeNotes[i].contains('FAIL')
                  ? Icons.error_outline
                  : Icons.check_circle_outline,
              color: bridgeNotes[i].contains('FAIL') ? danger : tealBright,
              size: 16.0,
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                bridgeNotes[i],
                style: const TextStyle(
                  color: ink,
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget bridgeCheck = frame(
    title: 'Bridge sanity check (live)',
    accent: slateMid,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: bridgeRows,
    ),
  );

  // ==================================================================
  //  FOOTER
  // ==================================================================
  final Widget footer = Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 18.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: slateDeep,
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            chip('END OF TOUR', tealBright, slateDeep),
            const SizedBox(width: 8.0),
            chip('5 RAW WIDGETS', amber, slateDeep),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'Reach for Raw* when you need control the polished version '
          'hides — custom theming, custom recognisers, predictable '
          'asset resolution in tests. Reach for the polished sibling '
          'when you just want it to look right.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 13.0,
            height: 1.55,
          ),
        ),
      ],
    ),
  );

  // ==================================================================
  //  ASSEMBLE
  // ==================================================================
  print('[raw_widgets_test] assembling layout');

  final List<Widget> stack = <Widget>[
    hero,
    sectionTitle('1', 'RawScrollbar', 'six stylings, one widget'),
    frame(
      title: 'Six RawScrollbar configurations',
      accent: tealBright,
      child: scrollbarGrid,
    ),
    sectionTitle('2', 'RawGestureDetector', 'recognisers and the gesture arena'),
    rawGestureCard,
    sectionTitle('3', 'InheritedNotifier', 'reactive scopes from a Listenable'),
    inheritedNotifierCard,
    sectionTitle('4', 'WillPopScope vs PopScope', 'navigation veto, then and now'),
    popCompare,
    sectionTitle('5', 'DefaultAssetBundle', 'inherited asset lookup'),
    assetBundleCard,
    sectionTitle('6', 'Cheat-sheet', 'Raw → polished sibling map'),
    comparisonCard,
    sectionTitle('7', 'Field reference', 'the constructor parameters that matter'),
    rawScrollbarFields,
    rawGestureFields,
    popScopeFields,
    sectionTitle('8', 'Edge cases', 'gotchas you only learn the hard way'),
    edgeCases,
    sectionTitle('9', 'Recogniser catalogue', 'what fits in a gestures map'),
    recognizerCatalogue,
    sectionTitle('10', 'Decision matrix', 'when to choose Raw vs polished'),
    decisionMatrix,
    sectionTitle('11', 'Bridge sanity', 'live constructor smoke test'),
    bridgeCheck,
    footer,
  ];

  return Scaffold(
    backgroundColor: paper,
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: stack,
        ),
      ),
    ),
  );
}
