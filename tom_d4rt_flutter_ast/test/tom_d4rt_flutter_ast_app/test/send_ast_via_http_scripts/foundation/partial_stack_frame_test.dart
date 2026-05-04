// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable
// D4rt test script: Tests PartialStackFrame from package:flutter/foundation.dart
// Deep Demo: Visual demonstration of PartialStackFrame fields, matching semantics,
// platform-specific behavior, and integration with StackFrame & FlutterError filters.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PartialStackFrame Deep Demo executing');

  // ============================================================
  // SECTION 1: Class Overview Header
  // ============================================================
  print('=== Section 1: Class Overview ===');

  final headerCard = Container(
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade700, Colors.indigo.shade500],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.4),
          blurRadius: 20.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: Icon(
                Icons.layers_outlined,
                size: 40.0,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PartialStackFrame',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/foundation.dart',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white70,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'A partial description of a stack frame used for filtering / '
            'identifying frames. Three fields: package (Pattern), className '
            '(String), method (String). Used by FlutterError.defaultStackFilter '
            'and RepetitiveStackFrameFilter.',
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
  print('Built header card');

  // ============================================================
  // SECTION 2: Field Map - Three Fields of PartialStackFrame
  // ============================================================
  print('=== Section 2: Field Map ===');

  final fieldsBlock = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade50, Colors.blue.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blueGrey.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree_outlined,
                color: Colors.blueGrey.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Three Fields',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildFieldRow(
          'package',
          'Pattern',
          'Pattern matched against "<scheme>:<package>/<packagePath>" of a '
              'StackFrame. Can be a String (substring) or RegExp.',
          Icons.inventory_2_outlined,
          Colors.indigo,
        ),
        SizedBox(height: 10.0),
        _buildFieldRow(
          'className',
          'String',
          'Exact match for StackFrame.className. Empty string for top-level '
              'functions. Ignored on web (kIsWeb).',
          Icons.class_outlined,
          Colors.teal,
        ),
        SizedBox(height: 10.0),
        _buildFieldRow(
          'method',
          'String',
          'Exact match for StackFrame.method. On web, private methods are '
              'wrapped in [brackets].',
          Icons.functions,
          Colors.deepOrange,
        ),
      ],
    ),
  );
  print('Built fields block');

  // ============================================================
  // SECTION 3: Constructor Sample Cards
  // ============================================================
  print('=== Section 3: Constructor Samples ===');

  final samples = <Map<String, dynamic>>[
    {
      'label': 'Element.rebuild',
      'package': 'package:flutter/src/widgets/framework.dart',
      'className': 'Element',
      'method': 'rebuild',
      'color': Colors.blue,
      'icon': Icons.widgets_outlined,
    },
    {
      'label': 'StatefulElement.performRebuild',
      'package': 'package:flutter/src/widgets/framework.dart',
      'className': 'StatefulElement',
      'method': 'performRebuild',
      'color': Colors.green,
      'icon': Icons.refresh,
    },
    {
      'label': 'main (top-level)',
      'package': 'package:my_app/main.dart',
      'className': '',
      'method': 'main',
      'color': Colors.deepOrange,
      'icon': Icons.play_arrow_outlined,
    },
    {
      'label': 'AssertionError.throwNew',
      'package': 'dart:core/errors_patch.dart',
      'className': '_AssertionError',
      'method': '_doThrowNew',
      'color': Colors.red,
      'icon': Icons.error_outline,
    },
  ];

  final sampleFrames = <PartialStackFrame>[];
  final sampleCards = <Widget>[];
  for (final s in samples) {
    final f = PartialStackFrame(
      package: s['package'] as String,
      className: s['className'] as String,
      method: s['method'] as String,
    );
    sampleFrames.add(f);
    print('Sample ${s['label']}: package=${f.package} '
        'className=${f.className} method=${f.method}');
    sampleCards.add(_buildSampleCard(s, f));
  }
  print('Built ${sampleCards.length} constructor sample cards');

  // ============================================================
  // SECTION 4: The Special asynchronousSuspension Constant
  // ============================================================
  print('=== Section 4: asynchronousSuspension Constant ===');

  final asyncFrame = PartialStackFrame.asynchronousSuspension;
  print('asynchronousSuspension package="${asyncFrame.package}" '
      'className="${asyncFrame.className}" method="${asyncFrame.method}"');

  final asyncBlock = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.purple.shade50, Colors.deepPurple.shade100],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.purple.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.purple.withValues(alpha: 0.2),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.hourglass_empty,
                color: Colors.purple.shade700, size: 26.0),
            SizedBox(width: 10.0),
            Text(
              'PartialStackFrame.asynchronousSuspension',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
                color: Colors.purple.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Static const sentinel matching an "<asynchronous suspension>" '
          'line in a stack trace. All three fields are special:',
          style: TextStyle(fontSize: 13.0, color: Colors.purple.shade900),
        ),
        SizedBox(height: 12.0),
        _buildKeyValue('package', '""', Colors.purple),
        _buildKeyValue('className', '""', Colors.purple),
        _buildKeyValue('method', '"asynchronous suspension"', Colors.purple),
      ],
    ),
  );
  print('Built asynchronousSuspension block');

  // ============================================================
  // SECTION 5: matches() Truth Table - String Pattern
  // ============================================================
  print('=== Section 5: matches() Truth Table (String) ===');

  // Build a real StackFrame: Element.rebuild, framework.dart
  final elementRebuildFrame = StackFrame(
    number: 0,
    column: 1,
    line: 100,
    packageScheme: 'package',
    package: 'flutter',
    packagePath: 'src/widgets/framework.dart',
    className: 'Element',
    method: 'rebuild',
    source:
        '#0      Element.rebuild (package:flutter/src/widgets/framework.dart:100:1)',
  );
  print('Target frame: ${elementRebuildFrame.toString()}');

  final stringPatternRows = <Map<String, dynamic>>[
    {
      'package': 'package:flutter/src/widgets/framework.dart',
      'className': 'Element',
      'method': 'rebuild',
      'expected': true,
      'note': 'Exact match — full package path + class + method',
    },
    {
      'package': 'package:flutter',
      'className': 'Element',
      'method': 'rebuild',
      'expected': true,
      'note': 'Substring match on package — Pattern.allMatches finds it',
    },
    {
      'package': 'framework.dart',
      'className': 'Element',
      'method': 'rebuild',
      'expected': true,
      'note': 'Substring match on file name only',
    },
    {
      'package': 'package:flutter/src/widgets/framework.dart',
      'className': 'Widget',
      'method': 'rebuild',
      'expected': false,
      'note': 'className mismatch (Element vs Widget)',
    },
    {
      'package': 'package:flutter/src/widgets/framework.dart',
      'className': 'Element',
      'method': 'build',
      'expected': false,
      'note': 'method mismatch (rebuild vs build)',
    },
    {
      'package': 'package:flutter/src/painting/box_decoration.dart',
      'className': 'Element',
      'method': 'rebuild',
      'expected': false,
      'note': 'package pattern not found in target frame package',
    },
  ];

  final stringPatternCards = <Widget>[];
  for (final row in stringPatternRows) {
    final psf = PartialStackFrame(
      package: row['package'] as String,
      className: row['className'] as String,
      method: row['method'] as String,
    );
    final actual = psf.matches(elementRebuildFrame);
    print('matches[$psf] => $actual (expected ${row['expected']})');
    stringPatternCards.add(_buildMatchRow(psf, actual, row));
  }
  print('Built ${stringPatternCards.length} string pattern rows');

  // ============================================================
  // SECTION 6: matches() Truth Table - RegExp Pattern
  // ============================================================
  print('=== Section 6: matches() Truth Table (RegExp) ===');

  final regexpRows = <Map<String, dynamic>>[
    {
      'pattern': RegExp(r'flutter/src/widgets/.*\.dart'),
      'displayPattern': r'RegExp(r"flutter/src/widgets/.*\.dart")',
      'className': 'Element',
      'method': 'rebuild',
      'expected': true,
      'note': 'RegExp matches widgets path with any file',
    },
    {
      'pattern': RegExp(r'^package:flutter/'),
      'displayPattern': r'RegExp(r"^package:flutter/")',
      'className': 'Element',
      'method': 'rebuild',
      'expected': true,
      'note': 'Anchored pattern matches start of frame package',
    },
    {
      'pattern': RegExp(r'^dart:'),
      'displayPattern': r'RegExp(r"^dart:")',
      'className': 'Element',
      'method': 'rebuild',
      'expected': false,
      'note': 'Anchored at dart: scheme — not found',
    },
    {
      'pattern': RegExp(r'rendering|painting'),
      'displayPattern': r'RegExp(r"rendering|painting")',
      'className': 'Element',
      'method': 'rebuild',
      'expected': false,
      'note': 'Alternation matches neither part of frame package',
    },
    {
      'pattern': RegExp(r'\.dart$'),
      'displayPattern': r'RegExp(r"\.dart$")',
      'className': 'Element',
      'method': 'rebuild',
      'expected': true,
      'note': 'End-anchored .dart found in target package',
    },
  ];

  final regexpCards = <Widget>[];
  for (final row in regexpRows) {
    final psf = PartialStackFrame(
      package: row['pattern'] as Pattern,
      className: row['className'] as String,
      method: row['method'] as String,
    );
    final actual = psf.matches(elementRebuildFrame);
    print('regexp[${row['displayPattern']}] => $actual '
        '(expected ${row['expected']})');
    regexpCards.add(_buildRegexpRow(row, actual));
  }
  print('Built ${regexpCards.length} regexp pattern rows');

  // ============================================================
  // SECTION 7: Pattern.allMatches Visualization
  // ============================================================
  print('=== Section 7: Pattern allMatches Visualization ===');

  final stackFramePackageString =
      '${elementRebuildFrame.packageScheme}:${elementRebuildFrame.package}/${elementRebuildFrame.packagePath}';
  print('stackFramePackage = "$stackFramePackageString"');

  final allMatchesBlock = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade50, Colors.lightBlue.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.cyan.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.cyan.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.search, color: Colors.cyan.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Internally: package.allMatches(target).isNotEmpty',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade900,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.cyan.shade200, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Target string built from StackFrame:',
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.cyan.shade700,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                stackFramePackageString,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Composed as:',
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.cyan.shade700,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'stackFrame.packageScheme + ":" + stackFrame.package + "/" + '
                'stackFrame.packagePath',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: Colors.deepPurple.shade700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        _buildAllMatchesRow(
          'package:flutter',
          stackFramePackageString,
          Colors.green,
        ),
        SizedBox(height: 6.0),
        _buildAllMatchesRow(
          'widgets/framework',
          stackFramePackageString,
          Colors.green,
        ),
        SizedBox(height: 6.0),
        _buildAllMatchesRow(
          'dart:core',
          stackFramePackageString,
          Colors.red,
        ),
        SizedBox(height: 6.0),
        _buildAllMatchesRow(
          'painting',
          stackFramePackageString,
          Colors.red,
        ),
      ],
    ),
  );
  print('Built allMatches visualization');

  // ============================================================
  // SECTION 8: Platform-Specific Behavior (kIsWeb)
  // ============================================================
  print('=== Section 8: Platform Behavior ===');
  print('current kIsWeb=$kIsWeb');

  final platformBlock = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.orange.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.orange.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.devices_other,
                color: Colors.orange.shade800, size: 24.0),
            SizedBox(width: 10.0),
            Text(
              'Platform-Specific Behavior',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade900,
              ),
            ),
            SizedBox(width: 12.0),
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: kIsWeb
                    ? Colors.lightBlue.shade100
                    : Colors.green.shade100,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(
                  color: kIsWeb
                      ? Colors.lightBlue.shade400
                      : Colors.green.shade400,
                  width: 1.0,
                ),
              ),
              child: Text(
                'kIsWeb=$kIsWeb',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: kIsWeb
                      ? Colors.lightBlue.shade900
                      : Colors.green.shade900,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildPlatformCard(
                'VM (mobile / desktop)',
                Icons.phone_android,
                Colors.green,
                [
                  'package.allMatches(framePackage).isNotEmpty',
                  'AND stackFrame.method == method',
                  'AND stackFrame.className == className',
                ],
                'Three-way exact match — className DOES participate.',
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _buildPlatformCard(
                'Web (kIsWeb)',
                Icons.web,
                Colors.lightBlue,
                [
                  'package.allMatches(framePackage).isNotEmpty',
                  'AND stackFrame.method == (method.startsWith("_")',
                  '    ? "[\$method]" : method)',
                ],
                'className is IGNORED on web — class names are not '
                    'available. Private methods get wrapped in [brackets].',
              ),
            ),
          ],
        ),
      ],
    ),
  );
  print('Built platform behavior block');

  // ============================================================
  // SECTION 9: Web-only Private Method Wrapping Examples
  // ============================================================
  print('=== Section 9: Private Method Wrapping ===');

  final privateMethodRows = <Map<String, dynamic>>[
    {
      'declared': '_doThrowNew',
      'webExpected': '[_doThrowNew]',
      'note': 'Private method — wrapped in brackets on web',
    },
    {
      'declared': '_rebuild',
      'webExpected': '[_rebuild]',
      'note': 'Leading underscore triggers wrapping',
    },
    {
      'declared': 'rebuild',
      'webExpected': 'rebuild',
      'note': 'Public method — no wrapping',
    },
    {
      'declared': 'build',
      'webExpected': 'build',
      'note': 'Public method — no wrapping',
    },
    {
      'declared': '_internalBuild',
      'webExpected': '[_internalBuild]',
      'note': 'Any underscore prefix triggers wrap',
    },
  ];

  final privateMethodCards = <Widget>[];
  for (final row in privateMethodRows) {
    print('private[${row['declared']}] -> webMethod=${row['webExpected']}');
    privateMethodCards.add(_buildPrivateMethodRow(row));
  }
  print('Built ${privateMethodCards.length} private method rows');

  // ============================================================
  // SECTION 10: Real-World Filtering Use Case
  // ============================================================
  print('=== Section 10: Real-World Use Case ===');

  // Build a synthetic stack trace (sequence of frames).
  final stackFrames = <StackFrame>[
    StackFrame(
      number: 0,
      column: 9,
      line: 5,
      packageScheme: 'dart',
      package: 'core',
      packagePath: 'errors_patch.dart',
      className: '_AssertionError',
      method: '_doThrowNew',
      source: '#0      _AssertionError._doThrowNew '
          '(dart:core-patch/errors_patch.dart:5:9)',
    ),
    StackFrame(
      number: 1,
      column: 7,
      line: 18,
      packageScheme: 'dart',
      package: 'core',
      packagePath: 'errors_patch.dart',
      className: '_AssertionError',
      method: '_throwNew',
      source: '#1      _AssertionError._throwNew '
          '(dart:core-patch/errors_patch.dart:18:7)',
    ),
    StackFrame(
      number: 2,
      column: 1,
      line: 100,
      packageScheme: 'package',
      package: 'flutter',
      packagePath: 'src/widgets/framework.dart',
      className: 'Element',
      method: 'rebuild',
      source: '#2      Element.rebuild '
          '(package:flutter/src/widgets/framework.dart:100:1)',
    ),
    StackFrame(
      number: 3,
      column: 1,
      line: 250,
      packageScheme: 'package',
      package: 'flutter',
      packagePath: 'src/widgets/framework.dart',
      className: 'StatefulElement',
      method: 'performRebuild',
      source: '#3      StatefulElement.performRebuild '
          '(package:flutter/src/widgets/framework.dart:250:1)',
    ),
    StackFrame(
      number: 4,
      column: 7,
      line: 42,
      packageScheme: 'package',
      package: 'my_app',
      packagePath: 'main.dart',
      className: 'MyApp',
      method: 'build',
      source: '#4      MyApp.build '
          '(package:my_app/main.dart:42:7)',
    ),
  ];
  print('Synthetic trace has ${stackFrames.length} frames');

  // Filter set: PartialStackFrames that target the framework internals.
  final filterPatterns = <PartialStackFrame>[
    PartialStackFrame(
      package: 'dart:core',
      className: '_AssertionError',
      method: '_doThrowNew',
    ),
    PartialStackFrame(
      package: 'dart:core',
      className: '_AssertionError',
      method: '_throwNew',
    ),
    PartialStackFrame(
      package: 'package:flutter',
      className: 'Element',
      method: 'rebuild',
    ),
  ];
  print('Filter patterns: ${filterPatterns.length}');

  // Compute matches matrix.
  final matchMatrix = <List<bool>>[];
  for (final frame in stackFrames) {
    final row = <bool>[];
    for (final p in filterPatterns) {
      row.add(p.matches(frame));
    }
    matchMatrix.add(row);
    print('Frame#${frame.number} ${frame.className}.${frame.method} '
        '-> ${row.join(",")}');
  }

  final useCaseBlock = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade50, Colors.green.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.teal.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.2),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.filter_alt_outlined,
                color: Colors.teal.shade800, size: 24.0),
            SizedBox(width: 10.0),
            Text(
              'Filtering a Synthetic Stack Trace',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Text(
          'Five frames, three PartialStackFrame filters. Each cell shows '
          'whether the filter would match that frame.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.teal.shade900,
            height: 1.4,
          ),
        ),
        SizedBox(height: 16.0),
        // Header
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
          decoration: BoxDecoration(
            color: Colors.teal.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 220.0,
                child: Text(
                  'Frame',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade900,
                  ),
                ),
              ),
              for (int i = 0; i < filterPatterns.length; i++)
                Expanded(
                  child: Text(
                    'Filter ${i + 1}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade900,
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        for (int r = 0; r < stackFrames.length; r++)
          Container(
            padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
            decoration: BoxDecoration(
              border: Border(
                bottom:
                    BorderSide(color: Colors.teal.shade200, width: 1.0),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 220.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '#${stackFrames[r].number} '
                        '${stackFrames[r].className}.'
                        '${stackFrames[r].method}',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11.0,
                          color: Colors.teal.shade900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${stackFrames[r].packageScheme}:'
                        '${stackFrames[r].package}/'
                        '${stackFrames[r].packagePath}',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 9.0,
                          color: Colors.teal.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
                for (int c = 0; c < filterPatterns.length; c++)
                  Expanded(
                    child: Center(
                      child: Icon(
                        matchMatrix[r][c]
                            ? Icons.check_circle
                            : Icons.cancel_outlined,
                        color: matchMatrix[r][c]
                            ? Colors.green.shade700
                            : Colors.grey.shade400,
                        size: 20.0,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        SizedBox(height: 12.0),
        // Filter legend
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            for (int i = 0; i < filterPatterns.length; i++)
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border:
                      Border.all(color: Colors.teal.shade300, width: 1.0),
                ),
                child: Text(
                  'F${i + 1}: ${filterPatterns[i].package} '
                  '/ ${filterPatterns[i].className}.'
                  '${filterPatterns[i].method}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.0,
                    color: Colors.teal.shade900,
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );
  print('Built use case filtering block');

  // ============================================================
  // SECTION 11: Code Examples
  // ============================================================
  print('=== Section 11: Code Examples ===');

  final codeBlock = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.blueGrey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade300, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Usage Examples',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade300,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildCodeBlock(
          '// 1. Basic construction with a String pattern\n'
          'const PartialStackFrame elementRebuild = PartialStackFrame(\n'
          '  package: \'package:flutter/src/widgets/framework.dart\',\n'
          '  className: \'Element\',\n'
          '  method: \'rebuild\',\n'
          ');',
          Colors.lightGreenAccent,
        ),
        SizedBox(height: 10.0),
        _buildCodeBlock(
          '// 2. RegExp pattern for broader package matching\n'
          'final asserts = PartialStackFrame(\n'
          '  package: RegExp(r\'^dart:core\'),\n'
          '  className: \'_AssertionError\',\n'
          '  method: \'_doThrowNew\',\n'
          ');',
          Colors.amberAccent,
        ),
        SizedBox(height: 10.0),
        _buildCodeBlock(
          '// 3. The asynchronous suspension sentinel\n'
          'const sentinel = PartialStackFrame.asynchronousSuspension;\n'
          'assert(sentinel.method == \'asynchronous suspension\');',
          Colors.pinkAccent,
        ),
        SizedBox(height: 10.0),
        _buildCodeBlock(
          '// 4. Top-level function (no class)\n'
          'const topLevelMain = PartialStackFrame(\n'
          '  package: \'package:my_app/main.dart\',\n'
          '  className: \'\', // empty for top-level\n'
          '  method: \'main\',\n'
          ');',
          Colors.lightBlueAccent,
        ),
        SizedBox(height: 10.0),
        _buildCodeBlock(
          '// 5. Match against a real StackFrame\n'
          'final frames = StackFrame.fromStackTrace(StackTrace.current);\n'
          'final matched = frames.where(elementRebuild.matches).toList();',
          Colors.tealAccent,
        ),
        SizedBox(height: 10.0),
        _buildCodeBlock(
          '// 6. Used inside RepetitiveStackFrameFilter\n'
          'class _MyFilter extends RepetitiveStackFrameFilter {\n'
          '  _MyFilter() : super(\n'
          '    frames: const [\n'
          '      PartialStackFrame(\n'
          '        package: \'package:flutter\',\n'
          '        className: \'Element\',\n'
          '        method: \'rebuild\'),\n'
          '    ],\n'
          '    replacement: \'... framework rebuild ...\',\n'
          '  );\n'
          '}',
          Colors.purpleAccent,
        ),
      ],
    ),
  );
  print('Built code examples block');

  // ============================================================
  // SECTION 12: Summary Stats
  // ============================================================
  print('=== Section 12: Summary Stats ===');

  // Compute simple stats.
  int trueCount = 0;
  int falseCount = 0;
  for (final row in matchMatrix) {
    for (final c in row) {
      if (c) {
        trueCount++;
      } else {
        falseCount++;
      }
    }
  }
  print('Matrix totals: matched=$trueCount, unmatched=$falseCount');

  final summaryBlock = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade900, Colors.deepPurple.shade800],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.4),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize_outlined,
                color: Colors.white, size: 24.0),
            SizedBox(width: 10.0),
            Text(
              'Demo Stats',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            Expanded(
              child: _buildStatTile(
                  'Constructors', '${sampleFrames.length}', Icons.build),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _buildStatTile(
                  'String Rows', '${stringPatternRows.length}',
                  Icons.text_format),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _buildStatTile(
                  'Regexp Rows', '${regexpRows.length}',
                  Icons.find_in_page_outlined),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(
              child: _buildStatTile(
                  'Trace Frames', '${stackFrames.length}',
                  Icons.list_alt_outlined),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _buildStatTile(
                  'Filter Hits', '$trueCount', Icons.check_circle_outline),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _buildStatTile(
                  'Misses', '$falseCount', Icons.cancel_outlined),
            ),
          ],
        ),
      ],
    ),
  );
  print('Built summary stats block');

  print('PartialStackFrame Deep Demo completed successfully');

  // ============================================================
  // Final assembly
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            headerCard,
            SizedBox(height: 24.0),
            Text(
              '1. Field Map',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 8.0),
            fieldsBlock,
            SizedBox(height: 24.0),
            Text(
              '2. Constructor Samples',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 8.0),
            Wrap(
              alignment: WrapAlignment.start,
              children: sampleCards,
            ),
            SizedBox(height: 24.0),
            Text(
              '3. asynchronousSuspension',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 8.0),
            asyncBlock,
            SizedBox(height: 24.0),
            Text(
              '4. matches() — String Patterns',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 8.0),
            ...stringPatternCards,
            SizedBox(height: 24.0),
            Text(
              '5. matches() — RegExp Patterns',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 8.0),
            ...regexpCards,
            SizedBox(height: 24.0),
            Text(
              '6. Pattern.allMatches Internals',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 8.0),
            allMatchesBlock,
            SizedBox(height: 24.0),
            Text(
              '7. Platform-Specific Behavior',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 8.0),
            platformBlock,
            SizedBox(height: 24.0),
            Text(
              '8. Web Private Method Wrapping',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 8.0),
            ...privateMethodCards,
            SizedBox(height: 24.0),
            Text(
              '9. Real-World Filtering',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 8.0),
            useCaseBlock,
            SizedBox(height: 24.0),
            Text(
              '10. Code Examples',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 8.0),
            codeBlock,
            SizedBox(height: 24.0),
            Text(
              '11. Summary',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 8.0),
            summaryBlock,
            SizedBox(height: 32.0),
          ],
        ),
      ),
    ),
  );
}

// ============================================================
// Helper widgets
// ============================================================

Widget _buildFieldRow(
  String name,
  String type,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.10),
          color.withValues(alpha: 0.04),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: color, size: 22.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: color,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10.0,
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade800,
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

Widget _buildSampleCard(Map<String, dynamic> spec, PartialStackFrame f) {
  final color = spec['color'] as Color;
  final icon = spec['icon'] as IconData;
  return Container(
    width: 280.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.10),
          color.withValues(alpha: 0.18),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.24),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 22.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                spec['label'] as String,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        _buildKeyValue('package', '${f.package}', color),
        _buildKeyValue('className',
            f.className.isEmpty ? '"" (top-level)' : f.className, color),
        _buildKeyValue('method', f.method, color),
      ],
    ),
  );
}

Widget _buildKeyValue(String key, String value, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80.0,
          child: Text(
            '$key:',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: Colors.grey.shade900,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildMatchRow(
  PartialStackFrame psf,
  bool actual,
  Map<String, dynamic> row,
) {
  final expected = row['expected'] as bool;
  final correct = actual == expected;
  final statusColor = actual ? Colors.green : Colors.red.shade400;

  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: correct
            ? Colors.green.shade300
            : Colors.red.shade300,
        width: 1.0,
      ),
      boxShadow: [
        BoxShadow(
          color: statusColor.withValues(alpha: 0.18),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.18),
            shape: BoxShape.circle,
            border: Border.all(color: statusColor, width: 1.5),
          ),
          child: Icon(
            actual ? Icons.check : Icons.close,
            color: statusColor,
            size: 20.0,
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'package: "${psf.package}"',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.indigo.shade800,
                ),
              ),
              Text(
                'className: "${psf.className}"   method: "${psf.method}"',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.teal.shade800,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                row['note'] as String,
                style: TextStyle(
                  fontSize: 11.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: statusColor, width: 1.0),
          ),
          child: Text(
            actual ? 'MATCH' : 'NO MATCH',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: statusColor,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildRegexpRow(Map<String, dynamic> row, bool actual) {
  final expected = row['expected'] as bool;
  final correct = actual == expected;
  final statusColor = actual ? Colors.green : Colors.red.shade400;
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.deepPurple.shade50,
          Colors.indigo.shade50,
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: correct ? Colors.green.shade300 : Colors.red.shade300,
        width: 1.0,
      ),
      boxShadow: [
        BoxShadow(
          color: statusColor.withValues(alpha: 0.18),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.20),
            shape: BoxShape.circle,
            border: Border.all(color: statusColor, width: 1.5),
          ),
          child: Icon(
            actual ? Icons.check : Icons.close,
            color: statusColor,
            size: 20.0,
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                row['displayPattern'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  color: Colors.deepPurple.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                'className: "${row['className']}"   '
                'method: "${row['method']}"',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.5,
                  color: Colors.indigo.shade800,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                row['note'] as String,
                style: TextStyle(
                  fontSize: 11.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: statusColor, width: 1.0),
          ),
          child: Text(
            actual ? 'MATCH' : 'NO MATCH',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: statusColor,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildAllMatchesRow(String pattern, String target, Color color) {
  int matchCount = 0;
  for (final _ in pattern.allMatches(target)) {
    matchCount++;
  }
  final isMatch = matchCount > 0;
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: isMatch
            ? Colors.green.shade300
            : Colors.red.shade300,
        width: 1.0,
      ),
    ),
    child: Row(
      children: [
        Icon(
          isMatch ? Icons.check_circle : Icons.cancel,
          color: color,
          size: 18.0,
        ),
        SizedBox(width: 10.0),
        Expanded(
          flex: 2,
          child: Text(
            '"$pattern"',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: Colors.cyan.shade900,
            ),
          ),
        ),
        Text(
          '.allMatches(...)',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(width: 10.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'count: $matchCount',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPlatformCard(
  String title,
  IconData icon,
  Color color,
  List<String> conditions,
  String note,
) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.12),
          color.withValues(alpha: 0.22),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.22),
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
            Icon(icon, color: color, size: 22.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        for (final cond in conditions)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.chevron_right,
                    color: color, size: 16.0),
                SizedBox(width: 4.0),
                Expanded(
                  child: Text(
                    cond,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.5,
                      color: Colors.grey.shade900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            note,
            style: TextStyle(
              fontSize: 11.0,
              fontStyle: FontStyle.italic,
              color: Colors.grey.shade800,
              height: 1.3,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPrivateMethodRow(Map<String, dynamic> row) {
  final declared = row['declared'] as String;
  final webExpected = row['webExpected'] as String;
  final isWrapped = declared.startsWith('_');
  final color = isWrapped ? Colors.purple : Colors.teal;

  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.10),
          color.withValues(alpha: 0.04),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.16),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(
          isWrapped ? Icons.lock_outline : Icons.lock_open,
          color: color,
          size: 22.0,
        ),
        SizedBox(width: 10.0),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'declared: $declared',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'web frame method: $webExpected',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            row['note'] as String,
            style: TextStyle(
              fontSize: 11.0,
              fontStyle: FontStyle.italic,
              color: Colors.grey.shade700,
              height: 1.3,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildStatTile(String label, String value, IconData icon) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0.18),
          Colors.white.withValues(alpha: 0.08),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.30),
        width: 1.0,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.18),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white, size: 18.0),
            SizedBox(width: 6.0),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.0,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          value,
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.45),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: textColor.withValues(alpha: 0.4),
        width: 1.0,
      ),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: textColor,
        height: 1.45,
      ),
    ),
  );
}
