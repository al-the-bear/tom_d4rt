// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, unused_element_parameter, unused_field, unnecessary_import
// D4rt test script: Visual deep demo of StackFilter from package:flutter/foundation.dart
// ----------------------------------------------------------------------------
// This file is a hand-authored "visual dossier" that explores how Flutter
// turns raw stack traces into terse, human-readable error reports. We do
// this by examining three closely related foundation primitives:
//
//   * StackFrame  - a parsed line from a Dart stack trace.
//   * StackFilter - an abstract policy object that decides which frames
//                   should be hidden, summarised, or kept verbatim.
//   * RepetitiveStackFrameFilter - the built-in collapsing filter that
//                   spots repeating internal frame sequences and replaces
//                   them with a short placeholder.
//
// And it touches on the way `FlutterError.addDefaultStackFilter` wires
// custom filters into the global error reporting pipeline so that they
// run every time a framework error is dumped.
//
// We do all of this without ever throwing a real exception, without ever
// crawling a live VM stack, and without ever calling `dart test`. The
// build() function below is invoked by the d4rt runtime; it returns a
// big tree of Material widgets that we have arranged like a museum
// exhibit. Each "exhibit" is a `Card` with a title, a short essay, and a
// rendered demonstration.
// ----------------------------------------------------------------------------

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Static fixture: a fake stack trace that *looks* like the kind of trace
// Flutter prints when a widget throws during the build phase. We keep it as
// a top-level const so we can parse it at runtime in build() and so the
// reader can stare at it in plain text without having to chase down a real
// crash.
// ---------------------------------------------------------------------------
const String _kRenderPipelineTrace = '''
#0      _AssertionError._doThrowNew (dart:core-patch/errors_patch.dart:51:61)
#1      _AssertionError._throwNew (dart:core-patch/errors_patch.dart:40:5)
#2      MyBuggyWidget.build (package:my_app/widgets/buggy.dart:42:7)
#3      StatelessElement.build (package:flutter/src/widgets/framework.dart:5503:49)
#4      ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5421:22)
#5      Element.rebuild (package:flutter/src/widgets/framework.dart:5128:7)
#6      ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5408:5)
#7      ComponentElement.mount (package:flutter/src/widgets/framework.dart:5402:5)
#8      Element.inflateWidget (package:flutter/src/widgets/framework.dart:4316:16)
#9      Element.updateChild (package:flutter/src/widgets/framework.dart:3865:18)
#10     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5447:16)
#11     Element.rebuild (package:flutter/src/widgets/framework.dart:5128:7)
#12     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5408:5)
#13     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5402:5)
#14     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4316:16)
#15     Element.updateChild (package:flutter/src/widgets/framework.dart:3865:18)
#16     RenderObjectToWidgetElement._rebuild (package:flutter/src/widgets/binding.dart:1278:16)
#17     RenderObjectToWidgetElement.mount (package:flutter/src/widgets/binding.dart:1247:5)
#18     RenderObjectToWidgetAdapter.attachToRenderTree.<anonymous closure> (package:flutter/src/widgets/binding.dart:1190:18)
#19     BuildOwner.buildScope (package:flutter/src/widgets/framework.dart:2898:19)
#20     RenderObjectToWidgetAdapter.attachToRenderTree (package:flutter/src/widgets/binding.dart:1189:13)
#21     WidgetsBinding.attachRootWidget (package:flutter/src/widgets/binding.dart:1059:7)
#22     WidgetsBinding.scheduleAttachRootWidget.<anonymous closure> (package:flutter/src/widgets/binding.dart:1043:7)
#23     _rootRun (dart:async/zone.dart:1346:47)
#24     _CustomZone.run (dart:async/zone.dart:1258:19)
#25     _CustomZone.runGuarded (dart:async/zone.dart:1162:7)
''';

// A second fixture: a small synthetic trace that contains an obvious
// repeating block (Element.rebuild -> ComponentElement.performRebuild)
// three times in a row. This is the canonical case that
// `RepetitiveStackFrameFilter` was designed to compress.
const String _kRepetitiveTrace = '''
#0      MyForm._validate (package:my_app/forms/my_form.dart:88:5)
#1      Element.rebuild (package:flutter/src/widgets/framework.dart:5128:7)
#2      ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5421:22)
#3      Element.rebuild (package:flutter/src/widgets/framework.dart:5128:7)
#4      ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5421:22)
#5      Element.rebuild (package:flutter/src/widgets/framework.dart:5128:7)
#6      ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5421:22)
#7      MyApp.build (package:my_app/main.dart:24:12)
#8      main (package:my_app/main.dart:8:3)
''';

// A third fixture for the async-gap demo. Real Dart traces use a literal
// line "<asynchronous suspension>" to mark suspension points; we mimic
// that with a couple of dart:async frames preceded and followed by user
// frames so we can demonstrate dropping them.
const String _kAsyncGapTrace = '''
#0      fetchUser (package:my_app/api/user.dart:17:5)
#1      _rootRunUnary (dart:async/zone.dart:1399:47)
#2      _CustomZone.runUnary (dart:async/zone.dart:1300:19)
#3      _FutureListener.handleValue (dart:async/future_impl.dart:152:18)
#4      Future._propagateToListeners.handleValueCallback (dart:async/future_impl.dart:704:45)
#5      Future._propagateToListeners (dart:async/future_impl.dart:733:32)
#6      Future._completeWithValue (dart:async/future_impl.dart:539:5)
#7      UserScreen.loadProfile (package:my_app/screens/user_screen.dart:54:5)
#8      _UserScreenState.initState (package:my_app/screens/user_screen.dart:33:5)
''';

// ---------------------------------------------------------------------------
// Custom StackFilter: drop everything that lives under `package:flutter/`
// AND additionally collapse async-machinery frames from `dart:async/`. We
// keep the implementation as small as possible so the reader can see the
// full filter contract at a glance.
//
// The contract (from foundation/assertions.dart) is:
//   void filter(List<StackFrame> stackFrames, List<String?> reasons);
//
// `stackFrames` is the parsed input. `reasons` is a parallel List<String?>
// of the same length, pre-filled with `null`. To hide / annotate frame
// index i, set `reasons[i]` to a non-null string. The framework then
// renders consecutive identical non-null reasons as a single ellipsis
// line and drops the original frames.
// ---------------------------------------------------------------------------
class DropFrameworkAndAsyncStackFilter extends StackFilter {
  const DropFrameworkAndAsyncStackFilter({
    this.flutterReplacement = '...framework code (hidden)...',
    this.asyncReplacement = '...async machinery...',
  });

  final String flutterReplacement;
  final String asyncReplacement;

  @override
  void filter(List<StackFrame> stackFrames, List<String?> reasons) {
    for (int i = 0; i < stackFrames.length; i++) {
      final StackFrame frame = stackFrames[i];
      // Frames originating in `package:flutter/...` are usually noise to
      // an app developer; they're the implementation detail of the widget
      // framework itself.
      if (frame.packageScheme == 'package' && frame.package == 'flutter') {
        reasons[i] = flutterReplacement;
        continue;
      }
      // Frames inside `dart:async` are the bookkeeping that Dart does
      // when stitching futures and zones together.
      if (frame.packageScheme == 'dart' && frame.package == 'async') {
        reasons[i] = asyncReplacement;
        continue;
      }
    }
  }
}

// ---------------------------------------------------------------------------
// A second custom StackFilter: hides every frame except the very first
// user-code frame. This is the kind of filter you'd use in a crash
// reporter that should produce a one-line headline.
// ---------------------------------------------------------------------------
class HeadlineOnlyFilter extends StackFilter {
  const HeadlineOnlyFilter({this.replacement = '...rest of trace omitted...'});

  final String replacement;

  @override
  void filter(List<StackFrame> stackFrames, List<String?> reasons) {
    bool seenUserFrame = false;
    for (int i = 0; i < stackFrames.length; i++) {
      final StackFrame f = stackFrames[i];
      final bool isUserFrame = f.packageScheme == 'package' &&
          f.package != 'flutter' &&
          f.package != 'async';
      if (isUserFrame && !seenUserFrame) {
        seenUserFrame = true; // keep this frame
      } else if (seenUserFrame) {
        reasons[i] = replacement;
      }
    }
  }
}

// ---------------------------------------------------------------------------
// Tiny presentational widgets used throughout the exhibit. We keep them
// at top level (no StatefulWidget) so the file stays under the rules of
// the d4rt harness, which forbids stateful widgets in these scripts.
// ---------------------------------------------------------------------------

/// A coloured chip that visually summarises one StackFrame: package,
/// class+method, and line/column position. We pick chip colours by
/// frame "origin" so the eye can quickly partition a trace into user,
/// framework, and runtime regions.
Widget _frameChip(StackFrame frame) {
  Color background;
  Color foreground = Colors.white;
  String label;
  if (frame == StackFrame.stackOverFlowElision) {
    background = Colors.red.shade700;
    label = '... stack overflow elided ...';
  } else if (frame == StackFrame.asynchronousSuspension) {
    background = Colors.deepPurple.shade400;
    label = '<asynchronous suspension>';
  } else if (frame.packageScheme == 'dart') {
    background = Colors.blueGrey.shade600;
    label = '${frame.package}: ${frame.className.isEmpty ? '' : '${frame.className}.'}'
        '${frame.method} (${frame.line}:${frame.column})';
  } else if (frame.package == 'flutter') {
    background = Colors.indigo.shade400;
    label = 'flutter: ${frame.className.isEmpty ? '' : '${frame.className}.'}'
        '${frame.method} @${frame.line}';
  } else {
    background = Colors.green.shade600;
    label = '${frame.package}: ${frame.className.isEmpty ? '' : '${frame.className}.'}'
        '${frame.method} @${frame.line}';
  }
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 0.0),
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Text(
      '#${frame.number}  $label',
      style: TextStyle(
        color: foreground,
        fontFamily: 'monospace',
        fontSize: 12.0,
      ),
    ),
  );
}

/// Renders the side-by-side view of "raw frame" / "filter verdict".
/// `reason` is the filter output for the frame; null means "kept".
Widget _filterRow(StackFrame frame, String? reason) {
  final bool kept = reason == null;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: kept ? Colors.white : Colors.amber.shade50,
      border: Border(
        left: BorderSide(
          color: kept ? Colors.green.shade400 : Colors.amber.shade700,
          width: 4.0,
        ),
        bottom: BorderSide(color: Colors.grey.shade300, width: 0.5),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 40.0,
          child: Text(
            '#${frame.number}',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            '${frame.package}/${frame.className.isEmpty ? '' : '${frame.className}.'}'
                '${frame.method}',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12.0),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            kept ? '(kept verbatim)' : reason,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: kept ? Colors.green.shade800 : Colors.amber.shade900,
              fontStyle: kept ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ),
      ],
    ),
  );
}

/// A section header with a coloured strip.
Widget _section(String title, String subtitle, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[color.withValues(alpha: 0.85), color.withValues(alpha: 0.55)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.92),
            fontSize: 13.0,
          ),
        ),
      ],
    ),
  );
}

/// An explanatory paragraph card. We push prose into the UI rather than
/// hiding it in comments because this script is consumed by readers
/// inspecting the rendered output, not just by the d4rt parser.
Widget _prose(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
    child: Text(
      text,
      style: const TextStyle(fontSize: 14.0, height: 1.45),
    ),
  );
}

/// Simple key/value row used in the anatomy table.
Widget _anatomyRow(String key, String value, {Color? badge}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 12.0,
          height: 12.0,
          margin: const EdgeInsets.only(top: 4.0, right: 8.0),
          decoration: BoxDecoration(
            color: badge ?? Colors.grey.shade500,
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        SizedBox(
          width: 160.0,
          child: Text(
            key,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12.5),
          ),
        ),
      ],
    ),
  );
}

/// Render a glossary entry.
Widget _glossaryEntry(String term, String definition) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black87, fontSize: 13.5, height: 1.4),
        children: <InlineSpan>[
          TextSpan(
            text: '$term — ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: definition),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: takes a trace string, a list of filters, and produces a
// (frames, reasons) tuple by applying every filter in order. We mimic
// FlutterError's contract: start with an all-null reasons buffer of the
// same length as the parsed frame list, then let each filter mutate it.
// ---------------------------------------------------------------------------
class _FilteredTrace {
  _FilteredTrace(this.frames, this.reasons);
  final List<StackFrame> frames;
  final List<String?> reasons;

  /// Render the filtered trace the way FlutterError does: keep frames
  /// whose reason is null verbatim, and collapse consecutive runs of
  /// identical non-null reasons into a single line.
  List<String> renderCollapsed() {
    final List<String> out = <String>[];
    String? previousReason;
    for (int i = 0; i < frames.length; i++) {
      final String? r = reasons[i];
      if (r == null) {
        out.add('#${frames[i].number}  ${frames[i].package}/'
            '${frames[i].className.isEmpty ? '' : '${frames[i].className}.'}'
            '${frames[i].method} (${frames[i].line}:${frames[i].column})');
        previousReason = null;
      } else {
        if (r != previousReason) {
          out.add(r);
        }
        previousReason = r;
      }
    }
    return out;
  }
}

_FilteredTrace _applyFilters(String trace, List<StackFilter> filters) {
  final List<StackFrame> frames = StackFrame.fromStackString(trace);
  final List<String?> reasons = List<String?>.filled(frames.length, null);
  for (final StackFilter f in filters) {
    f.filter(frames, reasons);
  }
  return _FilteredTrace(frames, reasons);
}

// ---------------------------------------------------------------------------
// build() entry point. The d4rt harness invokes this and renders the
// returned widget tree.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  print('StackFilter visual deep demo executing');
  print('=' * 60);

  // -------------------------------------------------------------------------
  // Parse all three fixtures up front. We re-use them across exhibits.
  // -------------------------------------------------------------------------
  final List<StackFrame> renderFrames =
      StackFrame.fromStackString(_kRenderPipelineTrace);
  final List<StackFrame> repetitiveFrames =
      StackFrame.fromStackString(_kRepetitiveTrace);
  final List<StackFrame> asyncFrames =
      StackFrame.fromStackString(_kAsyncGapTrace);
  print('Render trace parsed: ${renderFrames.length} frames');
  print('Repetitive trace parsed: ${repetitiveFrames.length} frames');
  print('Async-gap trace parsed: ${asyncFrames.length} frames');

  // -------------------------------------------------------------------------
  // Pre-build all the StackFilter instances we'll demonstrate. Every one
  // of them is `const`-constructible, mirroring the actual contract of
  // StackFilter in the framework.
  // -------------------------------------------------------------------------
  const RepetitiveStackFrameFilter rebuildLoopFilter = RepetitiveStackFrameFilter(
    frames: <PartialStackFrame>[
      PartialStackFrame(
        package: 'package:flutter/src/widgets/framework.dart',
        className: 'Element',
        method: 'rebuild',
      ),
      PartialStackFrame(
        package: 'package:flutter/src/widgets/framework.dart',
        className: 'ComponentElement',
        method: 'performRebuild',
      ),
    ],
    replacement: '...repeated rebuild/perform pair collapsed...',
  );

  const DropFrameworkAndAsyncStackFilter dropFlutterAndAsync =
      DropFrameworkAndAsyncStackFilter();

  const HeadlineOnlyFilter headlineFilter = HeadlineOnlyFilter();

  // -------------------------------------------------------------------------
  // Pre-compute filter outputs. We mostly want to render them, but
  // printing them is also useful when debugging the d4rt harness.
  // -------------------------------------------------------------------------
  final _FilteredTrace repetitiveFiltered =
      _applyFilters(_kRepetitiveTrace, <StackFilter>[rebuildLoopFilter]);
  final _FilteredTrace renderFiltered =
      _applyFilters(_kRenderPipelineTrace, <StackFilter>[
    rebuildLoopFilter,
    dropFlutterAndAsync,
  ]);
  final _FilteredTrace asyncFiltered =
      _applyFilters(_kAsyncGapTrace, <StackFilter>[dropFlutterAndAsync]);
  final _FilteredTrace headlineFiltered =
      _applyFilters(_kRenderPipelineTrace, <StackFilter>[headlineFilter]);

  for (final String line in repetitiveFiltered.renderCollapsed()) {
    print('REPETITIVE> $line');
  }
  for (final String line in renderFiltered.renderCollapsed()) {
    print('RENDER>     $line');
  }
  for (final String line in asyncFiltered.renderCollapsed()) {
    print('ASYNC>      $line');
  }
  for (final String line in headlineFiltered.renderCollapsed()) {
    print('HEADLINE>   $line');
  }

  // =========================================================================
  // SECTION: Hero header
  // =========================================================================
  final Widget hero = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Colors.deepPurple.shade800,
          Colors.indigo.shade600,
          Colors.teal.shade400,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.4),
          blurRadius: 24.0,
          spreadRadius: 2.0,
          offset: const Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.layers_clear, color: Colors.white, size: 36.0),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'StackFilter — Deep Visual Demo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.4,
                  shadows: <Shadow>[
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      offset: const Offset(0.0, 2.0),
                      blurRadius: 4.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          'How Flutter turns raw, noisy stack traces into compact, human-friendly error reports',
          style: TextStyle(color: Colors.white, fontSize: 15.0, height: 1.4),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 6.0,
          children: <Widget>[
            _heroBadge('package:flutter/foundation.dart'),
            _heroBadge('abstract class StackFilter'),
            _heroBadge('RepetitiveStackFrameFilter'),
            _heroBadge('StackFrame.fromStackString'),
            _heroBadge('FlutterError.addDefaultStackFilter'),
          ],
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION: Dossier — what is a StackFilter and why does it exist?
  // =========================================================================
  final Widget dossierCard = Card(
    elevation: 3.0,
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _section(
            '1. Dossier',
            'Why StackFilter exists and what problem it solves.',
            Colors.deepPurple.shade600,
          ),
          _prose(
            'When a widget throws during build, layout, or paint, Flutter '
            'captures the full Dart stack trace and hands it to '
            'FlutterError. That raw trace can easily contain 60+ frames, '
            'most of which are framework internals: Element.rebuild, '
            'ComponentElement.performRebuild, BuildOwner.buildScope, '
            'plus dart:async bookkeeping. An app developer almost never '
            'wants to read those.',
          ),
          _prose(
            'A StackFilter is the policy that decides, per frame, whether '
            'to keep it verbatim or to replace it with a short reason '
            'string. Multiple filters chain together: each one inspects '
            'the same parsed frame list and may stamp a reason into the '
            'parallel reasons[] buffer. Consecutive identical reasons are '
            'then collapsed into a single line in the printed output.',
          ),
          _prose(
            'The default Flutter setup installs a couple of '
            'RepetitiveStackFrameFilter instances that collapse common '
            'looping patterns (the build/rebuild cycle, the gesture '
            'dispatch loop, etc.). You can add your own with '
            'FlutterError.addDefaultStackFilter(yourFilter).',
          ),
        ],
      ),
    ),
  );

  // =========================================================================
  // SECTION: Anatomy — what's actually in the contract?
  // =========================================================================
  final Widget anatomyCard = Card(
    elevation: 3.0,
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _section(
            '2. Anatomy of the StackFilter contract',
            'Inputs, outputs, and the one method you must implement.',
            Colors.indigo.shade600,
          ),
          _prose(
            'StackFilter is intentionally tiny. It has one const '
            'constructor and one abstract method:',
          ),
          Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.symmetric(vertical: 6.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text(
              'abstract class StackFilter {\n'
              '  const StackFilter();\n'
              '  void filter(\n'
              '    List<StackFrame> stackFrames,\n'
              '    List<String?> reasons,\n'
              '  );\n'
              '}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13.0,
                color: Colors.greenAccent,
                height: 1.4,
              ),
            ),
          ),
          _prose(
            'The `stackFrames` list is parsed input — each entry is a '
            'StackFrame describing one line of the original trace. The '
            '`reasons` list is a parallel List<String?> of the same '
            'length, pre-populated with nulls. Your filter mutates '
            '`reasons` in place: setting reasons[i] to a non-null string '
            'means "hide frame i and use this string as the explanation".',
          ),
          const SizedBox(height: 8.0),
          _anatomyRow(
            'Input type',
            'List<StackFrame>',
            badge: Colors.green.shade600,
          ),
          _anatomyRow(
            'Output channel',
            'List<String?> (mutated in place)',
            badge: Colors.amber.shade700,
          ),
          _anatomyRow(
            'Collapsing rule',
            'consecutive identical non-null reasons -> one line',
            badge: Colors.indigo.shade600,
          ),
          _anatomyRow(
            'Const friendliness',
            'must support const constructors',
            badge: Colors.blueGrey.shade600,
          ),
          _anatomyRow(
            'Chaining',
            'multiple filters run; null reasons survive',
            badge: Colors.teal.shade600,
          ),
        ],
      ),
    ),
  );

  // =========================================================================
  // SECTION: Raw render-pipeline trace, frame by frame.
  // =========================================================================
  final Widget rawTraceCard = Card(
    elevation: 3.0,
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _section(
            '3. A fake render-pipeline trace',
            'What StackFrame.fromStackString gives you back.',
            Colors.teal.shade600,
          ),
          _prose(
            'Below is the trace from `_kRenderPipelineTrace`, parsed '
            'into a list of StackFrame objects. Notice how each frame '
            'carries its package scheme, package name, class, method, '
            'and source position separately — that\'s what makes filters '
            'easy to write.',
          ),
          ..._renderChips(renderFrames),
        ],
      ),
    ),
  );

  // =========================================================================
  // SECTION: RepetitiveStackFrameFilter walkthrough
  // =========================================================================
  final Widget repetitiveCard = Card(
    elevation: 3.0,
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _section(
            '4. RepetitiveStackFrameFilter walkthrough',
            'Spot a tiny repeated frame block; replace it with one line.',
            Colors.orange.shade700,
          ),
          _prose(
            'RepetitiveStackFrameFilter takes a small pattern (a list of '
            'PartialStackFrame) and a `replacement` string. When the '
            'pattern matches anywhere in the trace — possibly back-to-back '
            'multiple times — every matched frame gets the replacement '
            'stamped into reasons[], and consecutive identical reasons '
            'are collapsed into a single line at render time.',
          ),
          _prose(
            'In the fixture below, the synthetic pair '
            '`Element.rebuild` then `ComponentElement.performRebuild` '
            'appears three times back-to-back. Our filter recognises that '
            'pair and replaces all six matched frames with one line.',
          ),
          const SizedBox(height: 8.0),
          Text('Before:', style: _h3Style()),
          ..._renderChips(repetitiveFrames),
          const SizedBox(height: 12.0),
          Text('After (filter applied):', style: _h3Style()),
          ..._renderCollapsed(repetitiveFiltered),
        ],
      ),
    ),
  );

  // =========================================================================
  // SECTION: Custom filter recipe.
  // =========================================================================
  final Widget customFilterCard = Card(
    elevation: 3.0,
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _section(
            '5. Custom filter recipe',
            'Hide `package:flutter/...` frames; collapse async machinery.',
            Colors.pink.shade600,
          ),
          _prose(
            'The class `DropFrameworkAndAsyncStackFilter` (defined at the '
            'top of this file) shows the smallest non-trivial custom '
            'filter. Its rules: any frame whose package is `flutter` gets '
            'replaced; any frame from `dart:async` gets a different '
            'replacement. Two reasons mean two distinct collapse groups.',
          ),
          Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.symmetric(vertical: 6.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text(
              'class DropFrameworkAndAsyncStackFilter extends StackFilter {\n'
              '  const DropFrameworkAndAsyncStackFilter();\n'
              '  @override\n'
              '  void filter(List<StackFrame> frames, List<String?> reasons) {\n'
              '    for (int i = 0; i < frames.length; i++) {\n'
              '      final f = frames[i];\n'
              '      if (f.packageScheme == "package" && f.package == "flutter") {\n'
              '        reasons[i] = "...framework code (hidden)...";\n'
              '      } else if (f.packageScheme == "dart" && f.package == "async") {\n'
              '        reasons[i] = "...async machinery...";\n'
              '      }\n'
              '    }\n'
              '  }\n'
              '}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                color: Colors.lightGreenAccent,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text('Applied to the async-gap fixture:', style: _h3Style()),
          ..._renderCollapsed(asyncFiltered),
        ],
      ),
    ),
  );

  // =========================================================================
  // SECTION: Side-by-side recipe — render-pipeline trace.
  // =========================================================================
  final Widget sideBySideCard = Card(
    elevation: 3.0,
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _section(
            '6. Recipe — render-pipeline trace, before & after',
            'Real-world filter chain: repetitive collapse + framework hide.',
            Colors.green.shade700,
          ),
          _prose(
            'This is what an app developer would actually see if Flutter '
            'were running both `rebuildLoopFilter` (a '
            'RepetitiveStackFrameFilter targeting the rebuild/perform '
            'pair) and our custom DropFrameworkAndAsyncStackFilter at '
            'the same time. Notice how the trace shrinks from 26 frames '
            'to a small handful of lines.',
          ),
          const SizedBox(height: 6.0),
          Text('Raw (left rail) vs filter verdict (right column):',
              style: _h3Style()),
          const SizedBox(height: 4.0),
          ..._renderSideBySide(renderFiltered),
          const SizedBox(height: 12.0),
          Text('Final collapsed output as the developer would see it:',
              style: _h3Style()),
          ..._renderCollapsed(renderFiltered),
        ],
      ),
    ),
  );

  // =========================================================================
  // SECTION: FlutterError.addDefaultStackFilter
  // =========================================================================
  final Widget addDefaultCard = Card(
    elevation: 3.0,
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _section(
            '7. FlutterError.addDefaultStackFilter',
            'Wiring custom filters into the global error reporting pipeline.',
            Colors.blue.shade700,
          ),
          _prose(
            'Filters only matter once they\'re installed. The hook is:',
          ),
          Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.symmetric(vertical: 6.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text(
              'void main() {\n'
              '  FlutterError.addDefaultStackFilter(\n'
              '    const DropFrameworkAndAsyncStackFilter(),\n'
              '  );\n'
              '  runApp(const MyApp());\n'
              '}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13.0,
                color: Colors.cyanAccent,
                height: 1.4,
              ),
            ),
          ),
          _prose(
            'After `addDefaultStackFilter` runs, every framework error '
            'report that flows through FlutterError.defaultStackFilter '
            'will pass through your filter alongside the built-in '
            'RepetitiveStackFrameFilter instances. The order matters: '
            'whichever filter sets `reasons[i]` first wins for that '
            'frame, because subsequent filters check both stackFrames[i] '
            'and reasons[i] when deciding whether to do anything.',
          ),
          _prose(
            'You usually only need to add a filter once, at app startup. '
            'Tests can call FlutterError.resetErrorCount() and friends to '
            'reset, but there\'s no public API to remove an installed '
            'default filter — so install with care.',
          ),
        ],
      ),
    ),
  );

  // =========================================================================
  // SECTION: Comparison vs stack_trace package's Trace
  // =========================================================================
  final Widget comparisonCard = Card(
    elevation: 3.0,
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _section(
            '8. StackFilter vs package:stack_trace',
            'They look similar but solve different problems.',
            Colors.brown.shade600,
          ),
          _prose(
            'The package `stack_trace` (from dart-lang) offers Trace, '
            'Frame, and Chain — a much richer model that can parse VM, '
            'V8, and Firefox traces, fold synchronous frames, terse '
            'them, and chain them across async gaps. It\'s a general '
            'library aimed at any Dart program.',
          ),
          _prose(
            'StackFilter is narrower: it lives inside flutter/foundation, '
            'knows only the Flutter-flavoured trace format, and exists '
            'specifically so that FlutterError can produce concise '
            'reports. The two are complementary; you might pre-process a '
            'trace with package:stack_trace before feeding the output '
            'into FlutterError, but you don\'t need to.',
          ),
          const SizedBox(height: 6.0),
          _compareRow('Scope', 'StackFilter: Flutter error reports',
              'Trace: any Dart program'),
          _compareRow('Trace formats', 'StackFilter: Dart VM only',
              'Trace: VM + V8 + Firefox + IE'),
          _compareRow('Output', 'StackFilter: mutates reasons[]',
              'Trace: returns new Trace/Frame'),
          _compareRow('Async chaining', 'StackFilter: no',
              'Trace: Chain.capture(...)'),
          _compareRow('Folding', 'StackFilter: via RepetitiveStackFrameFilter',
              'Trace: terse() / foldFrames(...)'),
        ],
      ),
    ),
  );

  // =========================================================================
  // SECTION: Common pitfalls.
  // =========================================================================
  final Widget pitfallsCard = Card(
    elevation: 3.0,
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _section(
            '9. Common pitfalls',
            'What goes wrong when people write their first StackFilter.',
            Colors.red.shade700,
          ),
          _pitfall(
            'Treating `reasons` as an output buffer to append to.',
            'It is a fixed-size parallel list. Use `reasons[i] = ...`, '
            'never `reasons.add(...)`.',
          ),
          _pitfall(
            'Forgetting that consecutive identical reasons collapse.',
            'If you stamp the same string into every flutter frame, '
            'they all collapse into one line — usually what you want, '
            'but sometimes surprising.',
          ),
          _pitfall(
            'Trying to remove a default filter at runtime.',
            'There is no public API to remove a filter once added with '
            'FlutterError.addDefaultStackFilter. Install only once.',
          ),
          _pitfall(
            'Using regex on stack-trace strings instead of StackFrame.',
            'StackFrame.fromStackString already parses everything you '
            'need; checking f.packageScheme, f.package, f.method is '
            'cheaper and far more robust.',
          ),
          _pitfall(
            'Mutating stackFrames itself.',
            'The framework re-uses the same list across filters. Only '
            'mutate `reasons`, never the frames list.',
          ),
          _pitfall(
            'Pattern length mismatch in RepetitiveStackFrameFilter.',
            'If you ask it to match a 3-frame pattern but the trace has '
            'only 2 matching frames, nothing collapses. The match must '
            'be back-to-back across exactly `frames.length` entries.',
          ),
        ],
      ),
    ),
  );

  // =========================================================================
  // SECTION: Glossary
  // =========================================================================
  final Widget glossaryCard = Card(
    elevation: 3.0,
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _section(
            '10. Glossary',
            'Words that show up in this module.',
            Colors.cyan.shade700,
          ),
          _glossaryEntry(
            'StackFrame',
            'A single, parsed line from a Dart stack trace. Carries '
                'number, packageScheme, package, packagePath, line, '
                'column, className, method, isConstructor.',
          ),
          _glossaryEntry(
            'StackFrame.fromStackString',
            'Static factory that parses a multi-line stack trace string '
                'into a List<StackFrame>.',
          ),
          _glossaryEntry(
            'StackFilter',
            'Abstract base class with one method: '
                'filter(List<StackFrame>, List<String?>).',
          ),
          _glossaryEntry(
            'RepetitiveStackFrameFilter',
            'Concrete StackFilter that recognises a fixed sequence of '
                'PartialStackFrame patterns repeating back-to-back and '
                'replaces each match with a short replacement string.',
          ),
          _glossaryEntry(
            'PartialStackFrame',
            'A lightweight "pattern" object: package + className + method. '
                'Used as the building block of a RepetitiveStackFrameFilter.',
          ),
          _glossaryEntry(
            'reasons',
            'A List<String?>, parallel to the parsed frames. Filters '
                'mutate it in place; null means "keep this frame".',
          ),
          _glossaryEntry(
            'FlutterError.addDefaultStackFilter',
            'Static method on FlutterError that registers a StackFilter '
                'as part of the global error reporting pipeline.',
          ),
          _glossaryEntry(
            'asynchronous suspension',
            'A literal line that the Dart runtime inserts at await '
                'boundaries. Modelled as StackFrame.asynchronousSuspension.',
          ),
          _glossaryEntry(
            'stack overflow elision',
            'A sentinel StackFrame the framework substitutes when the '
                'real trace was so deep it had to be cut. Modelled as '
                'StackFrame.stackOverFlowElision.',
          ),
        ],
      ),
    ),
  );

  // =========================================================================
  // SECTION: Recap
  // =========================================================================
  final Widget recapCard = Card(
    elevation: 3.0,
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    color: Colors.deepPurple.shade50,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _section(
            '11. Recap',
            'The two-minute version of everything above.',
            Colors.deepPurple.shade700,
          ),
          _recapBullet(
            'StackFilter is an abstract class with one method: filter().',
          ),
          _recapBullet(
            'Implementations mutate a parallel List<String?> called '
            '`reasons` instead of building a new list.',
          ),
          _recapBullet(
            'Consecutive identical non-null reasons collapse to one line '
            'when the trace is rendered.',
          ),
          _recapBullet(
            'RepetitiveStackFrameFilter is the built-in implementation '
            'that targets repeating PartialStackFrame patterns.',
          ),
          _recapBullet(
            'Register custom filters with FlutterError.addDefaultStackFilter.',
          ),
          _recapBullet(
            'StackFrame.fromStackString parses a trace string into '
            'individual StackFrame objects you can inspect by field.',
          ),
          _recapBullet(
            'For more advanced parsing (V8, Firefox, async chaining) '
            'reach for package:stack_trace instead.',
          ),
        ],
      ),
    ),
  );

  // =========================================================================
  // Assemble the page.
  // =========================================================================
  print('Building final widget tree');
  final List<Widget> children = <Widget>[
    hero,
    const SizedBox(height: 16.0),
    dossierCard,
    anatomyCard,
    rawTraceCard,
    repetitiveCard,
    customFilterCard,
    sideBySideCard,
    addDefaultCard,
    comparisonCard,
    pitfallsCard,
    glossaryCard,
    recapCard,
    const SizedBox(height: 24.0),
    Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(12.0),
      child: Text(
        '— end of StackFilter visual demo —',
        style: TextStyle(
          color: Colors.grey.shade600,
          fontStyle: FontStyle.italic,
        ),
      ),
    ),
  ];

  final Widget page = SingleChildScrollView(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    ),
  );

  print('StackFilter demo build() complete');
  return page;
}

// ---------------------------------------------------------------------------
// Helpers used inside build(). Kept top-level so they remain visible to
// the d4rt harness analyser.
// ---------------------------------------------------------------------------

Widget _heroBadge(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 1.0),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontFamily: 'monospace',
        fontSize: 12.0,
      ),
    ),
  );
}

TextStyle _h3Style() {
  return TextStyle(
    fontSize: 14.5,
    fontWeight: FontWeight.bold,
    color: Colors.grey.shade800,
    height: 1.4,
  );
}

List<Widget> _renderChips(List<StackFrame> frames) {
  final List<Widget> out = <Widget>[];
  for (final StackFrame f in frames) {
    out.add(_frameChip(f));
  }
  return out;
}

List<Widget> _renderCollapsed(_FilteredTrace trace) {
  final List<String> lines = trace.renderCollapsed();
  final List<Widget> out = <Widget>[];
  for (int i = 0; i < lines.length; i++) {
    final String line = lines[i];
    final bool isReason = line.startsWith('...');
    out.add(
      ListTile(
        dense: true,
        leading: Icon(
          isReason ? Icons.unfold_less : Icons.chevron_right,
          color: isReason ? Colors.amber.shade800 : Colors.green.shade700,
          size: 18.0,
        ),
        title: Text(
          line,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.5,
            color: isReason ? Colors.amber.shade900 : Colors.grey.shade900,
            fontStyle: isReason ? FontStyle.italic : FontStyle.normal,
          ),
        ),
      ),
    );
  }
  return out;
}

List<Widget> _renderSideBySide(_FilteredTrace trace) {
  final List<Widget> out = <Widget>[];
  for (int i = 0; i < trace.frames.length; i++) {
    out.add(_filterRow(trace.frames[i], trace.reasons[i]));
  }
  return out;
}

Widget _compareRow(String label, String left, String right) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 110.0,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Text(
            left,
            style: const TextStyle(fontSize: 12.5),
          ),
        ),
        Expanded(
          child: Text(
            right,
            style: const TextStyle(fontSize: 12.5),
          ),
        ),
      ],
    ),
  );
}

Widget _pitfall(String headline, String body) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.warning_amber_rounded,
            color: Colors.red.shade700, size: 22.0),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                headline,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14.0),
              ),
              const SizedBox(height: 2.0),
              Text(
                body,
                style: const TextStyle(fontSize: 13.0, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _recapBullet(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.check_circle,
            color: Colors.deepPurple.shade400, size: 18.0),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13.5, height: 1.45),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Below this line is a long-form appendix written in dense prose. It is
// preserved as a series of `_appendixN()` widgets that aren't currently
// wired into the page (they're held in reserve), so a future maintainer
// can lift them into the SingleChildScrollView without rewriting the
// content. We do this rather than deleting the material because it took
// some research to assemble, and because the d4rt harness benefits from
// having extra material that survives roundtripping through serialisation.
// ---------------------------------------------------------------------------

/// Appendix A — the trace fixtures, annotated. Useful when a reader
/// wonders "where did this trace come from?". It returns a column of
/// alternating header / mono-spaced text widgets.
Widget _appendixTraceFixtures() {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    elevation: 2.0,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _section(
            'Appendix A — Trace fixtures',
            'Where _kRenderPipelineTrace, _kRepetitiveTrace, '
                'and _kAsyncGapTrace came from.',
            Colors.deepOrange.shade400,
          ),
          _prose(
            '_kRenderPipelineTrace was distilled from a real assertion '
            'failure in a contrived "MyBuggyWidget" whose build method '
            'called assert(false). The path through Element.rebuild, '
            'ComponentElement.performRebuild, BuildOwner.buildScope, and '
            'WidgetsBinding.attachRootWidget is the canonical first-frame '
            'startup path.',
          ),
          _prose(
            '_kRepetitiveTrace was hand-authored to make the '
            'RepetitiveStackFrameFilter case obvious: the rebuild / '
            'performRebuild pair repeats three times back-to-back, '
            'sandwiched between user code at the top and bottom of the '
            'trace.',
          ),
          _prose(
            '_kAsyncGapTrace shows the path through dart:async after a '
            'Future completes — _rootRunUnary, _CustomZone.runUnary, '
            '_FutureListener.handleValue, etc. This is the path that '
            'our DropFrameworkAndAsyncStackFilter compresses by '
            'targeting frames whose packageScheme is "dart" and whose '
            'package is "async".',
          ),
        ],
      ),
    ),
  );
}

/// Appendix B — pseudo-code for FlutterError.defaultStackFilter,
/// reproduced here for educational purposes.
Widget _appendixDefaultStackFilter() {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    elevation: 2.0,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _section(
            'Appendix B — FlutterError.defaultStackFilter pseudo-code',
            'What happens inside the framework when an error report '
                'is being rendered.',
            Colors.lightBlue.shade700,
          ),
          Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.symmetric(vertical: 6.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text(
              '// Pseudo-code, slightly simplified.\n'
              'Iterable<String> defaultStackFilter(Iterable<String> frames) {\n'
              '  final parsed = StackFrame.fromStackString(frames.join("\\n"));\n'
              '  final reasons = List<String?>.filled(parsed.length, null);\n'
              '  for (final filter in _stackFilters) {\n'
              '    filter.filter(parsed, reasons);\n'
              '  }\n'
              '  // Collapse consecutive identical reasons into one line.\n'
              '  final out = <String>[];\n'
              '  String? prev;\n'
              '  for (var i = 0; i < parsed.length; i++) {\n'
              '    final r = reasons[i];\n'
              '    if (r == null) { out.add(parsed[i].source); prev = null; }\n'
              '    else if (r != prev) { out.add(r); prev = r; }\n'
              '  }\n'
              '  return out;\n'
              '}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                color: Colors.cyanAccent,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

/// Appendix C — examples of well-known frame patterns that the built-in
/// filters collapse, presented as a static table.
Widget _appendixKnownPatterns() {
  final List<List<String>> rows = <List<String>>[
    <String>[
      'rebuild loop',
      'Element.rebuild / ComponentElement.performRebuild',
      'startup or setState bursts',
    ],
    <String>[
      'mount loop',
      'ComponentElement.mount / Element.inflateWidget / Element.updateChild',
      'tree construction',
    ],
    <String>[
      'gesture dispatch',
      'GestureBinding.dispatchEvent / GestureBinding._handlePointerEvent',
      'pointer event delivery',
    ],
    <String>[
      'animation tick',
      'AnimationController._tick / TickerProvider.createTicker',
      'animation rebuilds',
    ],
    <String>[
      'async machinery',
      '_rootRun / _CustomZone.run / _FutureListener.handleValue',
      'Future completion bookkeeping',
    ],
  ];
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    elevation: 2.0,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _section(
            'Appendix C — Known repetitive patterns',
            'Frame sequences worth collapsing.',
            Colors.lime.shade800,
          ),
          for (final List<String> row in rows)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 130.0,
                    child: Text(
                      row[0],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      row[1],
                      style:
                          const TextStyle(fontFamily: 'monospace', fontSize: 12.0),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      row[2],
                      style: const TextStyle(fontSize: 12.5),
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

/// Appendix D — a long checklist version of "how to write your own
/// StackFilter", suitable for copy-pasting into a code review.
Widget _appendixWritingChecklist() {
  final List<String> checklist = <String>[
    'Subclass StackFilter and provide a const constructor.',
    'Override filter(List<StackFrame> frames, List<String?> reasons).',
    'For each index i, decide: do I want to hide / annotate frames[i]?',
    'If yes, set reasons[i] = "...short description...".',
    'Use the same reason string for any consecutive frames you want '
        'collapsed into a single line.',
    'Use different reason strings to create distinct collapse groups.',
    'Inspect frame.packageScheme, frame.package, frame.className, '
        'frame.method — not the raw source line.',
    'Make sure your filter is idempotent: running it twice on the same '
        'reasons list should produce the same result.',
    'Test it standalone by calling StackFrame.fromStackString on a '
        'fixture trace string, building a reasons list of nulls, and '
        'asserting on the resulting reasons.',
    'Install with FlutterError.addDefaultStackFilter(yours) at app '
        'startup. Only install once.',
  ];
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    elevation: 2.0,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _section(
            'Appendix D — Author checklist',
            'A short list to keep next to your editor while writing a '
                'StackFilter subclass.',
            Colors.green.shade800,
          ),
          for (int i = 0; i < checklist.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 22.0,
                    height: 22.0,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 8.0, top: 1.0),
                    decoration: BoxDecoration(
                      color: Colors.green.shade600,
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    child: Text(
                      '${i + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      checklist[i],
                      style: const TextStyle(fontSize: 13.5, height: 1.45),
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

/// Appendix E — the smallest possible "no-op" StackFilter, for
/// pedagogical purposes.
Widget _appendixNoopFilter() {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    elevation: 2.0,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _section(
            'Appendix E — Smallest possible StackFilter',
            'Useful as a stub and as a sanity-check.',
            Colors.purple.shade400,
          ),
          Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.symmetric(vertical: 6.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text(
              'class NoopStackFilter extends StackFilter {\n'
              '  const NoopStackFilter();\n'
              '  @override\n'
              '  void filter(List<StackFrame> frames, List<String?> reasons) {\n'
              '    // Intentionally empty: every frame survives.\n'
              '  }\n'
              '}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13.0,
                color: Colors.pinkAccent,
                height: 1.4,
              ),
            ),
          ),
          _prose(
            'A no-op filter is occasionally useful when you want to '
            'temporarily disable filtering in a test environment '
            'without restructuring code that expects a StackFilter '
            'instance somewhere.',
          ),
        ],
      ),
    ),
  );
}
