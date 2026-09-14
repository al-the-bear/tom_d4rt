// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo of StackFrame from foundation.
//
// StackFrame is a parsed representation of a single line of a Dart stack
// trace. It carries the frame number, line/column, the package scheme
// (package:, dart:, file:), the package name, the path inside that package,
// the class name (possibly empty), the method name, an isConstructor flag
// and the original source line. This script renders 10 themed sections that
// build, parse, classify and explain StackFrame instances visually.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('StackFrame Deep Demo executing');
  print('=== Boot: importing foundation.StackFrame ===');

  // ============ SECTION 1: Title banner & one-liner ============
  print('--- Section 1: Title banner ---');
  final titleBanner = Container(
    width: double.infinity,
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.layers, color: Colors.cyanAccent, size: 32.0),
            SizedBox(width: 12.0),
            Text(
              'StackFrame',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(width: 12.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: Colors.cyanAccent.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.cyanAccent, width: 1.0),
              ),
              child: Text(
                'package:flutter/foundation.dart',
                style: TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'A single parsed line of a Dart stack trace.',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16.0,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Use it for error reporting, FlutterErrorDetails introspection,'
          ' custom error overlays and source-location attribution.',
          style: TextStyle(color: Colors.white54, fontSize: 13.0),
        ),
      ],
    ),
  );

  // ============ SECTION 2: Anatomy diagram ============
  print('--- Section 2: Anatomy diagram ---');
  final anatomyLines = <_AnatomyRow>[
    _AnatomyRow('number', '0', 'Position in the stack (0 = top frame)'),
    _AnatomyRow('packageScheme', 'package', '"package", "dart" or "file"'),
    _AnatomyRow('package', 'myapp', 'Package name (after the scheme)'),
    _AnatomyRow('packagePath', 'src/main.dart', 'Path inside the package'),
    _AnatomyRow('line', '42', 'Source line number'),
    _AnatomyRow('column', '12', 'Source column number'),
    _AnatomyRow('className', 'App', 'Class owning the method (may be empty)'),
    _AnatomyRow('method', 'build', 'Top-level fn or method name'),
    _AnatomyRow('isConstructor', 'false', 'true if the frame is in a ctor'),
    _AnatomyRow('source', '#0 App.build (...)', 'Original raw line text'),
  ];
  final anatomyChildren = <Widget>[];
  anatomyChildren.add(
    Text(
      'Anatomy of a StackFrame',
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    ),
  );
  anatomyChildren.add(SizedBox(height: 8.0));
  anatomyChildren.add(
    Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        '#0      App.build (package:myapp/src/main.dart:42:12)\n'
        ' ^       ^   ^      ^       ^   ^             ^  ^\n'
        ' |       |   |      |       |   |             |  +-- column\n'
        ' |       |   |      |       |   |             +----- line\n'
        ' |       |   |      |       |   +------------------- packagePath\n'
        ' |       |   |      |       +----------------------- package\n'
        ' |       |   |      +------------------------------- packageScheme\n'
        ' |       |   +-------------------------------------- method\n'
        ' |       +------------------------------------------ className\n'
        ' +-------------------------------------------------- number',
        style: TextStyle(
          color: Colors.greenAccent,
          fontFamily: 'monospace',
          fontSize: 11.0,
        ),
      ),
    ),
  );
  anatomyChildren.add(SizedBox(height: 12.0));
  for (final row in anatomyLines) {
    anatomyChildren.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 3.0),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.indigo.shade50,
          borderRadius: BorderRadius.circular(6.0),
          border: Border(
            left: BorderSide(color: Colors.indigo, width: 4.0),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 130.0,
              child: Text(
                row.field,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade800,
                  fontSize: 13.0,
                ),
              ),
            ),
            SizedBox(
              width: 140.0,
              child: Text(
                row.example,
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: Colors.deepPurple,
                  fontSize: 12.0,
                ),
              ),
            ),
            Expanded(
              child: Text(
                row.description,
                style: TextStyle(fontSize: 12.0, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
  final anatomySection = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.indigo.shade100],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.indigo.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: anatomyChildren,
    ),
  );

  // ============ SECTION 3: Hand-built StackFrame instances ============
  print('--- Section 3: Hand-built instances ---');
  final demoFrames = <StackFrame>[
    StackFrame(
      number: 0,
      column: 12,
      line: 42,
      packageScheme: 'package',
      package: 'myapp',
      packagePath: 'src/main.dart',
      className: 'App',
      method: 'build',
      source: '#0      App.build (package:myapp/src/main.dart:42:12)',
    ),
    StackFrame(
      number: 1,
      column: 5,
      line: 10,
      packageScheme: 'package',
      package: 'myapp',
      packagePath: 'widgets/home.dart',
      className: 'HomeWidget',
      method: 'build',
      source: '#1      HomeWidget.build (package:myapp/widgets/home.dart:10:5)',
    ),
    StackFrame(
      number: 2,
      column: 7,
      line: 88,
      packageScheme: 'package',
      package: 'flutter',
      packagePath: 'src/widgets/framework.dart',
      className: 'StatelessElement',
      method: 'build',
      source:
          '#2      StatelessElement.build '
          '(package:flutter/src/widgets/framework.dart:88:7)',
    ),
    StackFrame(
      number: 3,
      column: 0,
      line: 0,
      packageScheme: 'dart',
      package: 'core',
      packagePath: 'errors_patch.dart',
      className: '_AssertionError',
      method: '_doThrowNew',
      source: '#3      _AssertionError._doThrowNew (dart:core-patch)',
    ),
    StackFrame(
      number: 4,
      column: 3,
      line: 1,
      packageScheme: 'package',
      package: 'myapp',
      packagePath: 'src/models/user.dart',
      className: 'User',
      method: 'User',
      isConstructor: true,
      source: '#4      new User (package:myapp/src/models/user.dart:1:3)',
    ),
  ];

  print('Hand-built ${demoFrames.length} demo frames');
  final handBuiltCards = <Widget>[];
  for (var i = 0; i < demoFrames.length; i++) {
    final f = demoFrames[i];
    print('  frame #${f.number}: ${f.className}.${f.method} '
        '(${f.packageScheme}:${f.package}/${f.packagePath}:${f.line}:${f.column})');
    handBuiltCards.add(_buildFrameCard(f, _schemeColor(f.packageScheme)));
  }

  final handBuiltSection = _section(
    title: 'Hand-built StackFrame instances',
    subtitle:
        'Constructed directly via the StackFrame() constructor. Useful for'
        ' synthetic traces, tests and golden error reports.',
    accent: Colors.teal,
    icon: Icons.construction,
    children: handBuiltCards,
  );

  // ============ SECTION 4: Parsing single trace lines ============
  print('--- Section 4: Parsing single lines ---');
  final rawLines = <String>[
    '#0      Foo.bar (package:example/foo.dart:5:7)',
    '#1      Baz.qux (package:example/src/baz.dart:120:9)',
    '#2      _AssertionError._doThrowNew (dart:core-patch:42:11)',
    '#3      main (file:///home/user/project/bin/main.dart:3:14)',
    '#4      new MyClass (package:demo/my_class.dart:8:5)',
  ];

  final parsedSingles = <StackFrame>[];
  for (final raw in rawLines) {
    final parsed = StackFrame.fromStackTraceLine(raw);
    if (parsed != null) {
      parsedSingles.add(parsed);
      print('parsed -> #${parsed.number} ${parsed.method} '
          '@ ${parsed.packageScheme}:${parsed.package}/${parsed.packagePath}'
          ':${parsed.line}:${parsed.column}');
    } else {
      print('parse failed for: $raw');
    }
  }

  final parsingChildren = <Widget>[];
  for (var i = 0; i < rawLines.length; i++) {
    final raw = rawLines[i];
    final parsed = i < parsedSingles.length ? parsedSingles[i] : null;
    parsingChildren.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey.shade300, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 6.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.subject, color: Colors.amberAccent, size: 16.0),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      raw,
                      style: TextStyle(
                        color: Colors.amberAccent,
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: parsed == null
                  ? Text(
                      '(failed to parse)',
                      style: TextStyle(
                        color: Colors.red,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  : Wrap(
                      spacing: 8.0,
                      runSpacing: 6.0,
                      children: [
                        _chip('number', '${parsed.number}', Colors.blueGrey),
                        _chip('scheme', parsed.packageScheme, Colors.indigo),
                        _chip('pkg', parsed.package, Colors.teal),
                        _chip('path', parsed.packagePath, Colors.purple),
                        _chip('class', parsed.className, Colors.deepOrange),
                        _chip('method', parsed.method, Colors.green),
                        _chip('line', '${parsed.line}', Colors.brown),
                        _chip('col', '${parsed.column}', Colors.cyan),
                        _chip('ctor', '${parsed.isConstructor}', Colors.pink),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  final parsingSection = _section(
    title: 'StackFrame.fromStackTraceLine',
    subtitle:
        'Each raw line above is fed through fromStackTraceLine, returning'
        ' a fully populated StackFrame (or null if it cannot be parsed).',
    accent: Colors.amber.shade700,
    icon: Icons.text_snippet,
    children: parsingChildren,
  );

  // ============ SECTION 5: Parsing a full StackTrace ============
  print('--- Section 5: Parsing StackTrace.current ---');
  List<StackFrame> currentFrames = const <StackFrame>[];
  String currentTraceText = '';
  try {
    final trace = StackTrace.current;
    currentTraceText = trace.toString();
    currentFrames = StackFrame.fromStackTrace(trace);
    print('Captured StackTrace with ${currentFrames.length} frames');
  } catch (e) {
    print('StackTrace.current parsing failed: $e');
  }

  final visibleCurrent = <StackFrame>[];
  for (var i = 0; i < currentFrames.length && i < 8; i++) {
    visibleCurrent.add(currentFrames[i]);
  }

  final stackVizChildren = <Widget>[];
  stackVizChildren.add(
    Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        currentTraceText.length > 600
            ? '${currentTraceText.substring(0, 600)}\n... (truncated)'
            : currentTraceText,
        style: TextStyle(
          color: Colors.lightGreenAccent,
          fontFamily: 'monospace',
          fontSize: 10.5,
        ),
      ),
    ),
  );
  stackVizChildren.add(SizedBox(height: 12.0));
  stackVizChildren.add(
    Text(
      'Parsed (${currentFrames.length} frames, showing first '
      '${visibleCurrent.length}):',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
    ),
  );
  stackVizChildren.add(SizedBox(height: 8.0));
  for (final f in visibleCurrent) {
    stackVizChildren.add(_buildFrameCard(f, _schemeColor(f.packageScheme)));
  }

  final liveStackSection = _section(
    title: 'StackFrame.fromStackTrace(StackTrace.current)',
    subtitle:
        'A live snapshot of the call stack at this very moment, parsed into'
        ' StackFrame objects and color-coded by packageScheme.',
    accent: Colors.deepPurple,
    icon: Icons.stacked_bar_chart,
    children: stackVizChildren,
  );

  // ============ SECTION 6: packageScheme color legend ============
  print('--- Section 6: packageScheme legend ---');
  final schemes = <_SchemeInfo>[
    _SchemeInfo(
      'package',
      Colors.blue,
      Icons.inventory_2,
      'Frames inside a pub package, e.g. package:flutter/widgets.dart',
    ),
    _SchemeInfo(
      'dart',
      Colors.orange,
      Icons.dns,
      'Frames inside the Dart SDK, e.g. dart:core, dart:async',
    ),
    _SchemeInfo(
      'file',
      Colors.purple,
      Icons.insert_drive_file,
      'Frames in a local file path, often during dev / scripts',
    ),
    _SchemeInfo(
      'http',
      Colors.green,
      Icons.public,
      'Frames loaded over http (rare, dart2js / DDC)',
    ),
    _SchemeInfo(
      '<unknown>',
      Colors.grey,
      Icons.help_outline,
      'Empty / unrecognised scheme — treat carefully',
    ),
  ];

  final legendCards = <Widget>[];
  for (final s in schemes) {
    legendCards.add(
      Container(
        width: 220.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              s.color.withValues(alpha: 0.10),
              s.color.withValues(alpha: 0.30),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: s.color, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: s.color.withValues(alpha: 0.25),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(s.icon, color: s.color, size: 22.0),
                SizedBox(width: 8.0),
                Text(
                  s.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: s.color,
                    fontFamily: 'monospace',
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Text(
              s.description,
              style: TextStyle(fontSize: 11.5, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  final legendSection = _section(
    title: 'packageScheme legend',
    subtitle:
        'Each StackFrame.packageScheme tells you where the code lives. The'
        ' color in this legend is reused across the demo cards above.',
    accent: Colors.blueGrey,
    icon: Icons.color_lens,
    children: [Wrap(children: legendCards)],
  );

  // ============ SECTION 7: Sentinel frames ============
  print('--- Section 7: Sentinel frames ---');
  final stackOverflow = StackFrame.stackOverFlowElision;
  final asyncSuspension = StackFrame.asynchronousSuspension;
  print('stackOverFlowElision.method = ${stackOverflow.method}');
  print('asynchronousSuspension.method = ${asyncSuspension.method}');

  final sentinelChildren = <Widget>[
    _sentinelCard(
      name: 'StackFrame.stackOverFlowElision',
      explanation:
          'A canonical sentinel inserted when the stack itself is too deep to'
          ' walk further. Treat it as a marker — line/column may be 0.',
      frame: stackOverflow,
      color: Colors.red,
      icon: Icons.error_outline,
    ),
    SizedBox(height: 10.0),
    _sentinelCard(
      name: 'StackFrame.asynchronousSuspension',
      explanation:
          'Marks a "<asynchronous suspension>" boundary in async traces. It'
          ' separates synchronous frames from frames captured before an'
          ' async gap.',
      frame: asyncSuspension,
      color: Colors.deepPurple,
      icon: Icons.hourglass_bottom,
    ),
  ];

  final sentinelSection = _section(
    title: 'Sentinel frames',
    subtitle:
        'StackFrame ships two predefined instances. They are not real source'
        ' locations — they are markers you must recognise when walking a'
        ' parsed trace.',
    accent: Colors.red.shade700,
    icon: Icons.flag,
    children: sentinelChildren,
  );

  // ============ SECTION 8: Side-by-side raw vs parsed ============
  print('--- Section 8: Raw vs parsed comparison ---');
  final compareRaw = <String>[
    '#0      App.build (package:myapp/src/main.dart:42:12)',
    '#1      HomeWidget.build (package:myapp/widgets/home.dart:10:5)',
    '#2      StatelessElement.build '
        '(package:flutter/src/widgets/framework.dart:88:7)',
  ];
  final compareParsed = <StackFrame>[];
  for (final r in compareRaw) {
    final p = StackFrame.fromStackTraceLine(r);
    if (p != null) compareParsed.add(p);
  }

  final compareLeft = Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Raw stack trace string',
          style: TextStyle(
            color: Colors.amberAccent,
            fontWeight: FontWeight.bold,
            fontSize: 13.0,
          ),
        ),
        SizedBox(height: 6.0),
        for (final l in compareRaw)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: Text(
              l,
              style: TextStyle(
                color: Colors.greenAccent,
                fontFamily: 'monospace',
                fontSize: 11.5,
              ),
            ),
          ),
      ],
    ),
  );

  final compareRightChildren = <Widget>[];
  compareRightChildren.add(
    Text(
      'Parsed StackFrame list',
      style: TextStyle(
        color: Colors.indigo,
        fontWeight: FontWeight.bold,
        fontSize: 13.0,
      ),
    ),
  );
  compareRightChildren.add(SizedBox(height: 6.0));
  for (final p in compareParsed) {
    compareRightChildren.add(_buildFrameCard(p, _schemeColor(p.packageScheme)));
  }
  final compareRight = Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.indigo.shade50,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: compareRightChildren,
    ),
  );

  final comparisonSection = _section(
    title: 'Raw string vs parsed StackFrame',
    subtitle:
        'The same trace, two views: the unstructured string you log to the'
        ' console, and the structured StackFrame list your code can analyse.',
    accent: Colors.cyan.shade700,
    icon: Icons.compare_arrows,
    children: [
      compareLeft,
      SizedBox(height: 12.0),
      Center(
        child: Icon(Icons.arrow_downward, color: Colors.cyan, size: 30.0),
      ),
      SizedBox(height: 12.0),
      compareRight,
    ],
  );

  // ============ SECTION 9: Use cases ============
  print('--- Section 9: Use cases ---');
  final useCases = <_UseCase>[
    _UseCase(
      Icons.bug_report,
      Colors.red,
      'Error reporting',
      'Convert FlutterErrorDetails.stack into StackFrame[] before sending it'
          ' to a crash backend so the payload is structured.',
    ),
    _UseCase(
      Icons.layers,
      Colors.indigo,
      'Custom error overlays',
      'Render the top frame of an unhandled error inline in your UI with'
          ' file/line/method, instead of a blob of text.',
    ),
    _UseCase(
      Icons.filter_alt,
      Colors.green,
      'Trace filtering',
      'Drop dart: and flutter framework frames so users only see frames in'
          ' their own package.',
    ),
    _UseCase(
      Icons.travel_explore,
      Colors.deepOrange,
      'Source attribution',
      'Pair packagePath + line with your source map to deep-link the error'
          ' into the editor.',
    ),
    _UseCase(
      Icons.science,
      Colors.teal,
      'Tests & assertions',
      'Write tests that assert errors originate in a specific class.method'
          ' without matching brittle string formats.',
    ),
    _UseCase(
      Icons.analytics,
      Colors.purple,
      'Telemetry grouping',
      'Aggregate similar crashes by (package, packagePath, method) instead of'
          ' raw strings that vary by line number.',
    ),
  ];

  final useCaseCards = <Widget>[];
  for (final uc in useCases) {
    useCaseCards.add(
      Container(
        width: 260.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, uc.color.withValues(alpha: 0.10)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: uc.color, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: uc.color.withValues(alpha: 0.20),
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(uc.icon, color: uc.color),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    uc.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: uc.color,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              uc.body,
              style: TextStyle(fontSize: 12.0, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  final useCasesSection = _section(
    title: 'Why StackFrame matters',
    subtitle:
        'Concrete situations where parsing a stack trace into StackFrame'
        ' objects is dramatically better than working with raw strings.',
    accent: Colors.deepPurple.shade400,
    icon: Icons.lightbulb,
    children: [Wrap(children: useCaseCards)],
  );

  // ============ SECTION 10: Interpretation tips ============
  print('--- Section 10: Interpretation tips ---');
  final tips = <_Tip>[
    _Tip(
      'package == "" + packageScheme == "package"',
      'Likely a synthetic frame or an unparsed line. Verify with source.',
    ),
    _Tip(
      'packageScheme == "dart"',
      'Frame lives in the SDK; you usually want to skip it for user-facing'
          ' overlays.',
    ),
    _Tip(
      'isConstructor == true',
      'method holds the class name (e.g. "User"). Render as "new User(...)".',
    ),
    _Tip(
      'className == ""',
      'Top-level function (no class). method is the function name.',
    ),
    _Tip(
      'line == 0 && column == 0',
      'No source location available — common for sentinels and patches.',
    ),
    _Tip(
      'packageScheme == "file"',
      'Absolute file path; resolve relative to your dev machine, not the'
          ' user\'s machine.',
    ),
  ];
  final tipChildren = <Widget>[];
  for (final t in tips) {
    tipChildren.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.lightBlue.shade50,
          borderRadius: BorderRadius.circular(8.0),
          border: Border(
            left: BorderSide(color: Colors.lightBlue, width: 4.0),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.tips_and_updates,
                color: Colors.lightBlue.shade700, size: 18.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.condition,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue.shade900,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    t.advice,
                    style: TextStyle(fontSize: 12.0, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  final tipsSection = _section(
    title: 'Interpretation tips',
    subtitle:
        'Quick rules of thumb for reading StackFrame fields without being'
        ' fooled by edge cases.',
    accent: Colors.lightBlue.shade700,
    icon: Icons.menu_book,
    children: tipChildren,
  );

  // ============ SECTION 11: Footguns ============
  print('--- Section 11: Footguns ---');
  final footguns = <_Footgun>[
    _Footgun(
      'Some lines do not parse',
      'fromStackTraceLine returns null for vendor-specific or obfuscated'
          ' lines. Always null-check.',
    ),
    _Footgun(
      'line / column can be 0',
      'Synthetic frames, patches and sentinels often have 0/0 — never assume'
          ' they index into real source.',
    ),
    _Footgun(
      'className may be empty',
      'Top-level functions and closures have no class. Do not assume'
          ' "Class.method" formatting.',
    ),
    _Footgun(
      'packageScheme is a free string',
      'It can be "package", "dart", "file", "http" or something else. Do not'
          ' switch on a closed set.',
    ),
    _Footgun(
      'asynchronousSuspension is not a real frame',
      'It marks a boundary; do not draw it as code. Filter or render it as a'
          ' divider.',
    ),
    _Footgun(
      'Stack format depends on the VM',
      'Release / AOT / web compilations produce different formats. Test with'
          ' real captures from each target.',
    ),
  ];
  final footgunChildren = <Widget>[];
  for (final fg in footguns) {
    footgunChildren.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red.shade50, Colors.orange.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.red.shade200, width: 1.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.warning_amber, color: Colors.red.shade700, size: 20.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fg.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade900,
                      fontSize: 13.0,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    fg.body,
                    style: TextStyle(fontSize: 12.0, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  final footgunsSection = _section(
    title: 'Footguns',
    subtitle:
        'Edge cases that bite when StackFrame is used in real apps. Treat'
        ' every field as optional / weakly typed text.',
    accent: Colors.red,
    icon: Icons.dangerous,
    children: footgunChildren,
  );

  // ============ SECTION 12: Footer recap ============
  print('--- Section 12: Footer recap ---');
  final footer = Container(
    width: double.infinity,
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF232526), Color(0xFF414345)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.check_circle, color: Colors.greenAccent),
            SizedBox(width: 10.0),
            Text(
              'StackFrame demo complete',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'Demonstrated:\n'
          '  - Direct construction with all fields\n'
          '  - StackFrame.fromStackTraceLine on 5 raw lines\n'
          '  - StackFrame.fromStackTrace(StackTrace.current)\n'
          '  - Sentinels: stackOverFlowElement & asynchronousSuspension\n'
          '  - Anatomy diagram, legend, use cases, footguns and tips',
          style: TextStyle(
            color: Colors.white70,
            fontFamily: 'monospace',
            fontSize: 12.0,
          ),
        ),
      ],
    ),
  );

  print('StackFrame Deep Demo build complete');

  return Scaffold(
    backgroundColor: Color(0xFFF6F7FB),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          anatomySection,
          handBuiltSection,
          parsingSection,
          liveStackSection,
          legendSection,
          sentinelSection,
          comparisonSection,
          useCasesSection,
          tipsSection,
          footgunsSection,
          footer,
        ],
      ),
    ),
  );
}

// ----------- helper builders & private value classes -----------

Widget _section({
  required String title,
  required String subtitle,
  required Color accent,
  required IconData icon,
  required List<Widget> children,
}) {
  return Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: accent.withValues(alpha: 0.3), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.15),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [accent, accent.withValues(alpha: 0.7)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 20.0),
              SizedBox(width: 8.0),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 12.5,
            color: Colors.black87,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 12.0),
        ...children,
      ],
    ),
  );
}

Widget _buildFrameCard(StackFrame f, Color accent) {
  final classMethod = f.className.isEmpty
      ? f.method
      : (f.isConstructor ? 'new ${f.method}' : '${f.className}.${f.method}');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          accent.withValues(alpha: 0.08),
          accent.withValues(alpha: 0.18),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: accent, width: 4.0)),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.15),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36.0,
          height: 36.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: accent,
            shape: BoxShape.circle,
          ),
          child: Text(
            '#${f.number}',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11.0,
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                classMethod,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                '${f.packageScheme}:${f.package}/${f.packagePath}'
                ':${f.line}:${f.column}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: accent,
                ),
              ),
              if (f.isConstructor)
                Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade100,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      'isConstructor',
                      style: TextStyle(
                        color: Colors.pink.shade800,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
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

Widget _sentinelCard({
  required String name,
  required String explanation,
  required StackFrame frame,
  required Color color,
  required IconData icon,
}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.10),
          color.withValues(alpha: 0.25),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color),
            SizedBox(width: 8.0),
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 14.0,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          explanation,
          style: TextStyle(fontSize: 12.5, color: Colors.black87),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'number=${frame.number} '
            'method="${frame.method}" '
            'class="${frame.className}" '
            'scheme="${frame.packageScheme}" '
            'pkg="${frame.package}" '
            'path="${frame.packagePath}" '
            'line=${frame.line} col=${frame.column} '
            'isCtor=${frame.isConstructor}',
            style: TextStyle(
              color: Colors.lightGreenAccent,
              fontFamily: 'monospace',
              fontSize: 10.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _chip(String label, String value, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label:',
          style: TextStyle(
            color: color,
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 4.0),
        Text(
          value.isEmpty ? '""' : value,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 11.0,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Color _schemeColor(String scheme) {
  if (scheme == 'package') return Colors.blue;
  if (scheme == 'dart') return Colors.orange;
  if (scheme == 'file') return Colors.purple;
  if (scheme == 'http') return Colors.green;
  return Colors.grey;
}

class _AnatomyRow {
  final String field;
  final String example;
  final String description;
  const _AnatomyRow(this.field, this.example, this.description);
}

class _SchemeInfo {
  final String name;
  final Color color;
  final IconData icon;
  final String description;
  const _SchemeInfo(this.name, this.color, this.icon, this.description);
}

class _UseCase {
  final IconData icon;
  final Color color;
  final String title;
  final String body;
  const _UseCase(this.icon, this.color, this.title, this.body);
}

class _Tip {
  final String condition;
  final String advice;
  const _Tip(this.condition, this.advice);
}

class _Footgun {
  final String title;
  final String body;
  const _Footgun(this.title, this.body);
}
