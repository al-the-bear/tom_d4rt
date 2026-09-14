// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: ErrorSpacer Deep Visual Demo
// Deep Demo: Visual exploration of ErrorSpacer from package:flutter/foundation.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ErrorSpacer Deep Demo executing');

  // ============================================================
  // Construct an ErrorSpacer instance for inspection.
  // ErrorSpacer is a DiagnosticsProperty<void> subclass that
  // renders as an empty line in error dumps.
  // ============================================================
  final spacer = ErrorSpacer();
  print('=== Construction ===');
  print('runtimeType: ${spacer.runtimeType}');
  print('name: ${spacer.name}');
  print('showName: ${spacer.showName}');
  print('showSeparator: ${spacer.showSeparator}');
  print('level: ${spacer.level}');
  print('style: ${spacer.style}');
  print('allowTruncate: ${spacer.allowTruncate}');
  print('toString(): "${spacer.toString()}"');
  print('toDescription(): "${spacer.toDescription()}"');

  // Color theme: amber/orange (diagnostic / warning).
  final amberPrimary = Colors.amber.shade700;
  final amberDeep = Colors.deepOrange.shade700;
  final amberSoftBg = Colors.amber.shade50;
  final amberMidBg = Colors.amber.shade100;
  final orangeBg = Colors.orange.shade50;
  final monoFamily = 'monospace';

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title Banner ===');

  final titleBanner = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.amber.shade600,
          Colors.deepOrange.shade700,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.report_gmailerrorred,
          size: 64.0,
          color: Colors.white,
        ),
        SizedBox(height: 8.0),
        Text(
          'ErrorSpacer',
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'A DiagnosticsProperty<void> that renders a blank line',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white.withValues(alpha: 0.9),
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.5),
              width: 1.0,
            ),
          ),
          child: Text(
            'package:flutter/foundation.dart',
            style: TextStyle(
              fontFamily: monoFamily,
              fontSize: 12.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy of a FlutterError diagnostics tree
  // ============================================================
  print('=== Section 2: Anatomy ===');

  final anatomyRows = <Widget>[
    _anatomyRow(
      'ErrorSummary',
      'One-line summary of the error',
      Colors.red.shade700,
      Icons.summarize,
    ),
    _anatomyRow(
      'ErrorDescription',
      'Long-form description / details',
      Colors.orange.shade700,
      Icons.description,
    ),
    _anatomySpacerRow(),
    _anatomyRow(
      'ErrorHint',
      'Suggestions for the developer',
      Colors.blue.shade600,
      Icons.lightbulb,
    ),
    _anatomySpacerRow(),
    _anatomyRow(
      'DiagnosticsProperty',
      'Context: e.g. RenderObject, owner',
      Colors.purple.shade600,
      Icons.account_tree,
    ),
    _anatomyRow(
      'DiagnosticsBlock',
      'Nested structured block',
      Colors.teal.shade600,
      Icons.view_module,
    ),
  ];

  final anatomyCard = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [amberSoftBg, orangeBg],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: amberPrimary, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: amberPrimary.withValues(alpha: 0.25),
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
            Icon(Icons.account_tree, color: amberDeep, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'FlutterError Diagnostic Tree Anatomy',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: amberDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'ErrorSpacer slots (highlighted) sit between sections.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.brown.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 14.0),
        ...anatomyRows,
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Constructor inspection chips
  // ============================================================
  print('=== Section 3: Constructor inspection ===');

  final inspectionChips = <Widget>[
    _propertyChip('runtimeType', '${spacer.runtimeType}', Colors.indigo),
    _propertyChip('name', '${spacer.name}', Colors.teal),
    _propertyChip('showName', '${spacer.showName}', Colors.blueGrey),
    _propertyChip('showSeparator', '${spacer.showSeparator}', Colors.brown),
    _propertyChip('level', '${spacer.level}', Colors.deepPurple),
    _propertyChip('style', '${spacer.style}', Colors.cyan.shade800),
    _propertyChip('allowTruncate', '${spacer.allowTruncate}', Colors.pink),
    _propertyChip('value', '<void>', Colors.grey.shade700),
  ];

  final constructorCard = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.yellow.shade50],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: amberPrimary, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.3),
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
            Icon(Icons.construction, color: amberDeep, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'final spacer = ErrorSpacer();',
              style: TextStyle(
                fontFamily: monoFamily,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: amberDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'No-arg constructor. Below: live values from the constructed instance.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.brown.shade800,
          ),
        ),
        SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: inspectionChips,
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.brown.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.brown.shade200, width: 1.0),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline,
                  size: 16.0, color: Colors.brown.shade700),
              SizedBox(width: 6.0),
              Expanded(
                child: Text(
                  'toString() → "${spacer.toString()}"   (an empty string – '
                  'that is exactly the point)',
                  style: TextStyle(
                    fontFamily: monoFamily,
                    fontSize: 11.0,
                    color: Colors.brown.shade900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Mock FlutterError dump using ErrorSpacer
  // ============================================================
  print('=== Section 4: Mock dump ===');

  final mockDumpLines = <Widget>[
    _dumpLine(
      '════════ Exception caught by widgets library ════════',
      Colors.red.shade300,
      bold: true,
    ),
    _dumpLine(
      'The following assertion was thrown building MyWidget:',
      Colors.amber.shade300,
    ),
    _dumpLine(
      'Cannot pass null as required parameter \'child\'.',
      Colors.white,
    ),
    _spacerDumpLine('ErrorSpacer #1'),
    _dumpLine(
      'When the exception was thrown, this was the stack:',
      Colors.amber.shade200,
    ),
    _dumpLine('#0   _MyWidgetState.build (file://lib/my_widget.dart:42)',
        Colors.grey.shade400),
    _dumpLine('#1   StatefulElement.build (framework.dart:5198)',
        Colors.grey.shade400),
    _dumpLine('#2   ComponentElement.performRebuild (framework.dart:5089)',
        Colors.grey.shade400),
    _spacerDumpLine('ErrorSpacer #2'),
    _dumpLine(
      'The relevant error-causing widget was:',
      Colors.amber.shade200,
    ),
    _dumpLine('  MyWidget MyWidget:file://lib/main.dart:17:12',
        Colors.cyan.shade300),
    _spacerDumpLine('ErrorSpacer #3'),
    _dumpLine(
      '═══════════════════════════════════════════════════════',
      Colors.red.shade300,
      bold: true,
    ),
  ];

  final mockDumpCard = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.black],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: amberPrimary, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.25),
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
            Icon(Icons.terminal, color: amberPrimary, size: 18.0),
            SizedBox(width: 6.0),
            Text(
              'FlutterError dump (mocked)',
              style: TextStyle(
                color: amberPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        ...mockDumpLines,
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Comparison vs other diagnostic node types
  // ============================================================
  print('=== Section 5: Comparison table ===');

  final comparisonTable = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [orangeBg, amberMidBg],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: amberPrimary, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.3),
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
            Icon(Icons.compare_arrows, color: amberDeep, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Comparison with sibling diagnostic nodes',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: amberDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        // Header row.
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
          decoration: BoxDecoration(
            color: amberDeep.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            children: [
              _tableCell('Class', flex: 3, bold: true),
              _tableCell('Renders', flex: 4, bold: true),
              _tableCell('Purpose', flex: 5, bold: true),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        _tableRow('ErrorSummary',
            'red bold one-liner', 'Headline of the error'),
        _tableRow('ErrorDescription',
            'plain text paragraph', 'Long form details'),
        _tableRow('ErrorHint',
            'italic suggestion', 'Suggested fix or hint'),
        _tableRow('ErrorSpacer',
            '(empty line)', 'Visually separates sections',
            highlight: true),
        _tableRow('DiagnosticsProperty',
            'name: value pair', 'Context object'),
        _tableRow('DiagnosticsNode',
            'base class', 'Generic tree node'),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Real-world mock — RenderFlex overflowed
  // ============================================================
  print('=== Section 6: RenderFlex overflowed mock ===');

  final renderFlexLines = <Widget>[
    _dumpLine(
      '════════ Exception caught by rendering library ════════',
      Colors.red.shade300,
      bold: true,
    ),
    _dumpLine(
      'A RenderFlex overflowed by 27 pixels on the right.',
      Colors.amber.shade200,
    ),
    _spacerDumpLine('ErrorSpacer'),
    _dumpLine(
      'The overflowing RenderFlex has an orientation of Axis.horizontal.',
      Colors.white,
    ),
    _dumpLine(
      'The edge of the RenderFlex that is overflowing has been marked '
      'in the rendering with a yellow and black striped pattern.',
      Colors.white70,
    ),
    _spacerDumpLine('ErrorSpacer'),
    _dumpLine(
      'This is usually caused by the contents being too big for the '
      'RenderFlex.',
      Colors.amber.shade200,
    ),
    _dumpLine(
      'Consider applying a flex factor (e.g. using an Expanded widget) '
      'to force the children of the RenderFlex to fit within the available '
      'space instead of being sized to their natural size.',
      Colors.white70,
    ),
    _spacerDumpLine('ErrorSpacer'),
    _dumpLine('The specific RenderFlex in question is:', Colors.amber.shade200),
    _dumpLine('  RenderFlex#a1b2c relayoutBoundary=up3 OVERFLOWING',
        Colors.cyan.shade300),
    _dumpLine('    creator: Row ← Padding ← ConstrainedBox ← …',
        Colors.cyan.shade200),
    _dumpLine('    parentData: <none> (can use size)', Colors.cyan.shade200),
    _dumpLine('    constraints: BoxConstraints(w=320.0, 0.0<=h<=Infinity)',
        Colors.cyan.shade200),
    _dumpLine('    size: Size(320.0, 56.0)', Colors.cyan.shade200),
    _dumpLine('    direction: horizontal', Colors.cyan.shade200),
    _dumpLine('    mainAxisAlignment: start', Colors.cyan.shade200),
    _dumpLine('    crossAxisAlignment: center', Colors.cyan.shade200),
    _spacerDumpLine('ErrorSpacer'),
    _dumpLine(
      '◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤',
      Colors.amber.shade400,
    ),
    _dumpLine(
      '═══════════════════════════════════════════════════════',
      Colors.red.shade300,
      bold: true,
    ),
  ];

  final renderFlexCard = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.black, Colors.brown.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: amberDeep, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.3),
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
            Icon(Icons.warning_amber, color: amberPrimary, size: 18.0),
            SizedBox(width: 6.0),
            Text(
              'Real-world: RenderFlex overflowed',
              style: TextStyle(
                color: amberPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        ...renderFlexLines,
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Code snippet
  // ============================================================
  print('=== Section 7: Code snippet ===');

  final codeSnippetCard = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.blueGrey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: amberPrimary, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
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
            Icon(Icons.code, color: Colors.cyan.shade300, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'How ErrorSpacer is used in practice',
              style: TextStyle(
                color: Colors.cyan.shade300,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _codeBlock(
          'throw FlutterError.fromParts(<DiagnosticsNode>[\n'
          '  ErrorSummary(\'Cannot pass null as required parameter.\'),\n'
          '  ErrorSpacer(),\n'
          '  ErrorDescription(\n'
          '    \'The widget tried to build with a null child, \'\n'
          '    \'but child is required.\',\n'
          '  ),\n'
          '  ErrorSpacer(),\n'
          '  ErrorHint(\n'
          '    \'Provide a non-null child or wrap in a conditional.\',\n'
          '  ),\n'
          ']);',
          Colors.greenAccent.shade100,
        ),
        SizedBox(height: 12.0),
        _codeBlock(
          '// ErrorSpacer is just sugar for an empty DiagnosticsNode line.\n'
          '// It has no name, no value, no separator – just whitespace.\n'
          'final blank = ErrorSpacer();\n'
          'assert(blank.toString() == \'\');',
          Colors.amberAccent.shade100,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Use cases
  // ============================================================
  print('=== Section 8: Use cases ===');

  final useCases = <Widget>[
    _useCaseCard(
      Icons.segment,
      'Separate logical error parts',
      'Place between summary, description, and hint blocks so the '
          'console output reads as visually distinct paragraphs.',
      Colors.amber.shade300,
    ),
    _useCaseCard(
      Icons.layers,
      'Between context cards',
      'When dumping multiple DiagnosticsProperty nodes (RenderObject, '
          'creator, owner) ErrorSpacer lets each block breathe.',
      Colors.orange.shade300,
    ),
    _useCaseCard(
      Icons.lightbulb_outline,
      'Between hints and references',
      'Useful right before a "See also: …" reference block to keep '
          'links visually separated from the body.',
      Colors.deepOrange.shade300,
    ),
    _useCaseCard(
      Icons.bug_report,
      'Before stack traces',
      'Inserted before a DiagnosticsStackTrace so the stack reads as '
          'its own section in the dump.',
      Colors.red.shade300,
    ),
  ];

  final useCasesCard = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [amberMidBg, orangeBg],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: amberPrimary, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.3),
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
            Icon(Icons.work_outline, color: amberDeep, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Use cases',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: amberDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        ...useCases,
      ],
    ),
  );

  // ============================================================
  // SECTION 9: DiagnosticsNode tree visualization
  // ============================================================
  print('=== Section 9: Tree visualization ===');

  final treeCard = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.deepOrange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: amberPrimary, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.25),
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
            Icon(Icons.account_tree_outlined, color: amberDeep, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'DiagnosticsNode tree (with spacer slots)',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: amberDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _treeNode('FlutterError', 0, Colors.red.shade700, Icons.error_outline),
        _treeNode('ErrorSummary("RenderFlex overflowed by 27px")', 1,
            Colors.red.shade400, Icons.summarize),
        _treeSpacerNode(1, 'ErrorSpacer  ← blank line'),
        _treeNode('ErrorDescription("orientation = horizontal")', 1,
            Colors.orange.shade600, Icons.description),
        _treeSpacerNode(1, 'ErrorSpacer  ← blank line'),
        _treeNode('ErrorHint("apply a flex factor")', 1,
            Colors.blue.shade500, Icons.lightbulb),
        _treeSpacerNode(1, 'ErrorSpacer  ← blank line'),
        _treeNode('DiagnosticsProperty<RenderFlex>', 1,
            Colors.purple.shade600, Icons.account_tree),
        _treeNode('size: Size(320.0, 56.0)', 2,
            Colors.purple.shade400, Icons.straighten),
        _treeNode('direction: horizontal', 2,
            Colors.purple.shade400, Icons.swap_horiz),
        _treeSpacerNode(1, 'ErrorSpacer  ← blank line'),
        _treeNode('DiagnosticsStackTrace', 1, Colors.brown.shade700,
            Icons.layers),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Footguns
  // ============================================================
  print('=== Section 10: Footguns ===');

  final footguns = <Widget>[
    _footgunCard(
      Icons.merge,
      'Forgetting the spacer',
      'Without ErrorSpacer the summary, description, and hint run '
          'together into a single dense paragraph that is hard to scan.',
      Colors.red.shade400,
    ),
    _footgunCard(
      Icons.format_line_spacing,
      'Too many spacers',
      'Stacking multiple ErrorSpacer() calls in a row produces several '
          'consecutive blank lines and wastes vertical screen space.',
      Colors.orange.shade400,
    ),
    _footgunCard(
      Icons.shuffle,
      'Mixing with custom DiagnosticsNode trees',
      'Custom DiagnosticsBlock children may already include their own '
          'whitespace; adding ErrorSpacer on top can produce uneven rhythm.',
      Colors.deepOrange.shade400,
    ),
    _footgunCard(
      Icons.do_not_disturb_on,
      'Using it as a value carrier',
      'ErrorSpacer is DiagnosticsProperty<void>; never try to read .value, '
          'attach a name, or expect it to display anything.',
      Colors.brown.shade500,
    ),
  ];

  final footgunsCard = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, amberSoftBg],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.2),
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
            Icon(Icons.dangerous_outlined,
                color: Colors.red.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Footguns',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade700,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        ...footguns,
      ],
    ),
  );

  // ============================================================
  // SECTION 11: Recap card
  // ============================================================
  print('=== Section 11: Recap ===');

  final recapPoints = <Widget>[
    _recapPoint(
      'It is a DiagnosticsProperty<void>',
      'Subclass that has no value and no name.',
      Icons.token,
    ),
    _recapPoint(
      'It renders as a blank line',
      'toString() and toDescription() return empty strings.',
      Icons.format_line_spacing,
    ),
    _recapPoint(
      'It is used inside FlutterError.fromParts',
      'To group ErrorSummary / ErrorDescription / ErrorHint visually.',
      Icons.layers_outlined,
    ),
    _recapPoint(
      'It has no behaviour',
      'No constructor args, no methods to override – pure separator.',
      Icons.water_drop_outlined,
    ),
    _recapPoint(
      'Use sparingly',
      'One spacer between sections is usually enough.',
      Icons.tune,
    ),
  ];

  final recapCard = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.deepOrange.shade400,
          Colors.amber.shade700,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.45),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.checklist, color: Colors.white, size: 26.0),
            SizedBox(width: 10.0),
            Text(
              'Recap: ErrorSpacer in 5 bullets',
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        ...recapPoints,
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.45),
              width: 1.0,
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.bookmark_border, color: Colors.white, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'TL;DR — ErrorSpacer is the "" of the diagnostics tree.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('ErrorSpacer Deep Demo built all sections');

  // ============================================================
  // Final layout: Scaffold → SingleChildScrollView → Column.
  // ============================================================
  return Scaffold(
    backgroundColor: Colors.amber.shade50.withValues(alpha: 0.4),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 24.0),
          _sectionHeader('1. Anatomy of a FlutterError diagnostics tree',
              Icons.account_tree, amberDeep),
          anatomyCard,
          SizedBox(height: 16.0),
          _sectionHeader('2. Constructor inspection',
              Icons.construction, amberDeep),
          constructorCard,
          SizedBox(height: 16.0),
          _sectionHeader('3. Mock FlutterError dump with spacers',
              Icons.terminal, amberDeep),
          mockDumpCard,
          SizedBox(height: 16.0),
          _sectionHeader('4. Comparison vs sibling diagnostic nodes',
              Icons.compare_arrows, amberDeep),
          comparisonTable,
          SizedBox(height: 16.0),
          _sectionHeader('5. Real-world: RenderFlex overflowed',
              Icons.warning_amber, amberDeep),
          renderFlexCard,
          SizedBox(height: 16.0),
          _sectionHeader('6. Code snippet — FlutterError.fromParts',
              Icons.code, amberDeep),
          codeSnippetCard,
          SizedBox(height: 16.0),
          _sectionHeader('7. Use cases', Icons.work_outline, amberDeep),
          useCasesCard,
          SizedBox(height: 16.0),
          _sectionHeader('8. DiagnosticsNode tree (with spacer slots)',
              Icons.account_tree_outlined, amberDeep),
          treeCard,
          SizedBox(height: 16.0),
          _sectionHeader('9. Footguns', Icons.dangerous_outlined,
              Colors.red.shade700),
          footgunsCard,
          SizedBox(height: 16.0),
          _sectionHeader('10. Recap', Icons.checklist, amberDeep),
          recapCard,
          SizedBox(height: 32.0),
          // Footer
          Container(
            padding: EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.brown.shade50,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.brown.shade200, width: 1.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.flag, color: Colors.brown.shade600, size: 16.0),
                SizedBox(width: 6.0),
                Text(
                  'End of ErrorSpacer Deep Demo',
                  style: TextStyle(
                    color: Colors.brown.shade700,
                    fontStyle: FontStyle.italic,
                    fontSize: 12.0,
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
// Helper builders
// ============================================================

Widget _sectionHeader(String title, IconData icon, Color color) {
  return Padding(
    padding: EdgeInsets.only(top: 8.0, bottom: 4.0, left: 4.0),
    child: Row(
      children: [
        Icon(icon, color: color, size: 22.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyRow(
    String name, String description, Color color, IconData icon) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(
        left: BorderSide(color: color, width: 4.0),
      ),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 18.0),
        SizedBox(width: 10.0),
        SizedBox(
          width: 150.0,
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 12.0, color: Colors.grey.shade800),
          ),
        ),
      ],
    ),
  );
}

Widget _anatomySpacerRow() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.amber.withValues(alpha: 0.5),
          Colors.deepOrange.withValues(alpha: 0.4),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: Colors.deepOrange.shade400,
        width: 1.5,
        style: BorderStyle.solid,
      ),
    ),
    child: Row(
      children: [
        Icon(Icons.format_line_spacing,
            color: Colors.deepOrange.shade800, size: 18.0),
        SizedBox(width: 10.0),
        SizedBox(
          width: 150.0,
          child: Text(
            'ErrorSpacer',
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              color: Colors.deepOrange.shade900,
            ),
          ),
        ),
        Expanded(
          child: Text(
            '⟵ blank line slot (visually breaks sections)',
            style: TextStyle(
              fontSize: 12.0,
              fontStyle: FontStyle.italic,
              color: Colors.deepOrange.shade900,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _propertyChip(String name, String value, Color color) {
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #16, U16):
  // Empty-string Text() arguments trip the bridged paragraph painter with
  // "Offset argument contained a NaN value" (dart:ui/painting.dart:41).
  // ErrorSpacer's `name` property is the empty string by design, so the
  // chip for it renders Text('') unless we substitute. Replace empty
  // strings with a single space so the painter sees a non-empty line.
  final String safeName = name.isEmpty ? ' ' : name;
  final String safeValue = value.isEmpty ? ' ' : value;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            safeName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 6.0),
        Text(
          safeValue,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget _dumpLine(String text, Color color, {bool bold = false}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.5),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: color,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      ),
    ),
  );
}

Widget _spacerDumpLine(String label) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 2.0),
    height: 16.0,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.amber.withValues(alpha: 0.25),
          Colors.deepOrange.withValues(alpha: 0.18),
          Colors.amber.withValues(alpha: 0.25),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(
        color: Colors.amber.shade700.withValues(alpha: 0.6),
        width: 1.0,
      ),
    ),
    child: Center(
      child: Text(
        '·  ·  ·  $label  ·  ·  ·',
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 9.0,
          color: Colors.amber.shade300,
          fontStyle: FontStyle.italic,
        ),
      ),
    ),
  );
}

Widget _tableCell(String text, {int flex = 1, bool bold = false}) {
  return Expanded(
    flex: flex,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11.0,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          color: Colors.brown.shade900,
        ),
      ),
    ),
  );
}

Widget _tableRow(String cls, String renders, String purpose,
    {bool highlight = false}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
    margin: EdgeInsets.symmetric(vertical: 2.0),
    decoration: BoxDecoration(
      color: highlight
          ? Colors.deepOrange.withValues(alpha: 0.2)
          : Colors.white.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(6.0),
      border: highlight
          ? Border.all(color: Colors.deepOrange.shade400, width: 1.5)
          : null,
    ),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              cls,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: highlight
                    ? Colors.deepOrange.shade900
                    : Colors.brown.shade800,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              renders,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              purpose,
              style: TextStyle(
                fontSize: 11.0,
                color: Colors.brown.shade900,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _codeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.1),
        width: 1.0,
      ),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: textColor,
        height: 1.4,
      ),
    ),
  );
}

Widget _useCaseCard(
    IconData icon, String title, String body, Color accent) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        left: BorderSide(color: accent, width: 5.0),
      ),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.18),
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
            color: accent.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: accent, size: 22.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Colors.brown.shade900,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 11.5,
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

Widget _treeNode(String label, int indent, Color color, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(
      left: indent * 22.0,
      top: 3.0,
      bottom: 3.0,
    ),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.45), width: 1.0),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16.0),
          SizedBox(width: 8.0),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                color: color,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _treeSpacerNode(int indent, String label) {
  return Padding(
    padding: EdgeInsets.only(
      left: indent * 22.0,
      top: 3.0,
      bottom: 3.0,
    ),
    child: Container(
      height: 22.0,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.amber.withValues(alpha: 0.45),
            Colors.deepOrange.withValues(alpha: 0.35),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.deepOrange.shade400, width: 1.2),
      ),
      child: Row(
        children: [
          Icon(Icons.format_line_spacing,
              color: Colors.deepOrange.shade900, size: 14.0),
          SizedBox(width: 6.0),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              fontStyle: FontStyle.italic,
              color: Colors.deepOrange.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _footgunCard(
    IconData icon, String title, String body, Color accent) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.9),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: accent.withValues(alpha: 0.7),
        width: 1.2,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.15),
            shape: BoxShape.circle,
            border: Border.all(color: accent, width: 1.5),
          ),
          child: Icon(icon, color: accent, size: 18.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Colors.red.shade800,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 11.5,
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

Widget _recapPoint(String title, String body, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.25),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 16.0),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                body,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.92),
                  fontSize: 11.5,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
