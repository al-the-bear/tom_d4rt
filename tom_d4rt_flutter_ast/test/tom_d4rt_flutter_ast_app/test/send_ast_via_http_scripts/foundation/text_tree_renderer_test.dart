// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable
// D4rt test script: Tests TextTreeRenderer from package:flutter/foundation.dart
// Deep Demo: Visual demonstration of the diagnostics tree text renderer,
// covering DiagnosticLevel filtering, wrap-width, descendant truncation, and
// the rendered output of representative widget diagnostic trees.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextTreeRenderer Deep Demo executing');

  // ============================================================
  // SECTION 1: TextTreeRenderer Construction Variants
  // ============================================================
  print('=== Section 1: Renderer Construction Variants ===');

  final defaultRenderer = TextTreeRenderer();
  final debugRenderer = TextTreeRenderer(minLevel: DiagnosticLevel.debug);
  final fineRenderer = TextTreeRenderer(minLevel: DiagnosticLevel.fine);
  final infoRenderer = TextTreeRenderer(minLevel: DiagnosticLevel.info);
  final wideRenderer = TextTreeRenderer(
    minLevel: DiagnosticLevel.debug,
    wrapWidth: 200,
    wrapWidthProperties: 120,
  );
  final narrowRenderer = TextTreeRenderer(
    minLevel: DiagnosticLevel.debug,
    wrapWidth: 60,
    wrapWidthProperties: 30,
  );
  final truncatedRenderer = TextTreeRenderer(
    minLevel: DiagnosticLevel.debug,
    maxDescendentsTruncatableNode: 5,
  );

  print('Created default renderer:    ${defaultRenderer.runtimeType}');
  print('Created debug renderer:      ${debugRenderer.runtimeType}');
  print('Created fine renderer:       ${fineRenderer.runtimeType}');
  print('Created info renderer:       ${infoRenderer.runtimeType}');
  print('Created wide renderer:       ${wideRenderer.runtimeType}');
  print('Created narrow renderer:     ${narrowRenderer.runtimeType}');
  print('Created truncated renderer:  ${truncatedRenderer.runtimeType}');

  final constructionData = <Map<String, dynamic>>[
    {
      'name': 'Default',
      'minLevel': 'debug',
      'wrapWidth': 100,
      'wrapWidthProperties': 65,
      'maxDescendents': -1,
      'color': Colors.indigo,
      'icon': Icons.tune,
    },
    {
      'name': 'Debug',
      'minLevel': 'debug',
      'wrapWidth': 100,
      'wrapWidthProperties': 65,
      'maxDescendents': -1,
      'color': Colors.blueGrey,
      'icon': Icons.bug_report,
    },
    {
      'name': 'Fine',
      'minLevel': 'fine',
      'wrapWidth': 100,
      'wrapWidthProperties': 65,
      'maxDescendents': -1,
      'color': Colors.teal,
      'icon': Icons.filter_alt,
    },
    {
      'name': 'Info',
      'minLevel': 'info',
      'wrapWidth': 100,
      'wrapWidthProperties': 65,
      'maxDescendents': -1,
      'color': Colors.lightBlue,
      'icon': Icons.info,
    },
    {
      'name': 'Wide',
      'minLevel': 'debug',
      'wrapWidth': 200,
      'wrapWidthProperties': 120,
      'maxDescendents': -1,
      'color': Colors.green,
      'icon': Icons.unfold_more,
    },
    {
      'name': 'Narrow',
      'minLevel': 'debug',
      'wrapWidth': 60,
      'wrapWidthProperties': 30,
      'maxDescendents': -1,
      'color': Colors.orange,
      'icon': Icons.unfold_less,
    },
    {
      'name': 'Truncated',
      'minLevel': 'debug',
      'wrapWidth': 100,
      'wrapWidthProperties': 65,
      'maxDescendents': 5,
      'color': Colors.deepPurple,
      'icon': Icons.content_cut,
    },
  ];

  final constructionCards = <Widget>[];
  for (final entry in constructionData) {
    final color = entry['color'] as Color;
    constructionCards.add(
      Container(
        width: 200.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.10),
              color.withValues(alpha: 0.28),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color, width: 2.0),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.30),
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
                Icon(entry['icon'] as IconData, color: color, size: 26.0),
                SizedBox(width: 8.0),
                Text(
                  entry['name'] as String,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            _buildKv('minLevel', entry['minLevel'] as String, color),
            _buildKv('wrapWidth', '${entry['wrapWidth']}', color),
            _buildKv(
              'wrapWidthProperties',
              '${entry['wrapWidthProperties']}',
              color,
            ),
            _buildKv(
              'maxDescendents',
              '${entry['maxDescendents']}',
              color,
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${constructionCards.length} construction cards');

  // ============================================================
  // SECTION 2: DiagnosticLevel Spectrum
  // ============================================================
  print('=== Section 2: DiagnosticLevel Spectrum ===');

  final diagnosticLevels = <Map<String, dynamic>>[
    {
      'level': DiagnosticLevel.hidden,
      'name': 'hidden',
      'color': Colors.grey,
      'desc': 'Should not be shown',
      'icon': Icons.visibility_off,
    },
    {
      'level': DiagnosticLevel.fine,
      'name': 'fine',
      'color': Colors.lightGreen,
      'desc': 'Likely low value',
      'icon': Icons.grain,
    },
    {
      'level': DiagnosticLevel.debug,
      'name': 'debug',
      'color': Colors.blue,
      'desc': 'Fine-grained debugging',
      'icon': Icons.bug_report,
    },
    {
      'level': DiagnosticLevel.info,
      'name': 'info',
      'color': Colors.cyan,
      'desc': 'Typically shown',
      'icon': Icons.info_outline,
    },
    {
      'level': DiagnosticLevel.warning,
      'name': 'warning',
      'color': Colors.amber,
      'desc': 'Indicates a problem',
      'icon': Icons.warning_amber,
    },
    {
      'level': DiagnosticLevel.hint,
      'name': 'hint',
      'color': Colors.purple,
      'desc': 'Provides hints',
      'icon': Icons.tips_and_updates,
    },
    {
      'level': DiagnosticLevel.summary,
      'name': 'summary',
      'color': Colors.indigo,
      'desc': 'Top-level summary',
      'icon': Icons.summarize,
    },
    {
      'level': DiagnosticLevel.error,
      'name': 'error',
      'color': Colors.red,
      'desc': 'Indicates an error',
      'icon': Icons.error,
    },
    {
      'level': DiagnosticLevel.off,
      'name': 'off',
      'color': Colors.black54,
      'desc': 'Off (filter all)',
      'icon': Icons.power_settings_new,
    },
  ];

  final levelTiles = <Widget>[];
  for (final entry in diagnosticLevels) {
    final level = entry['level'] as DiagnosticLevel;
    final color = entry['color'] as Color;
    print('DiagnosticLevel.${entry['name']} -> index ${level.index}');
    levelTiles.add(
      Container(
        width: 160.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.08),
              color.withValues(alpha: 0.24),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.25),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(entry['icon'] as IconData, color: color, size: 32.0),
            SizedBox(height: 6.0),
            Text(
              entry['name'] as String,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: color,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'index ${level.index}',
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 6.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                entry['desc'] as String,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10.0, color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Built ${levelTiles.length} diagnostic level tiles');

  // ============================================================
  // SECTION 3: Render Output of a Simple Container Diagnostics
  // ============================================================
  print('=== Section 3: Render Output of a Simple Container ===');

  final smallContainer = Container(
    width: 100.0,
    height: 50.0,
    color: Colors.amber,
  );
  final smallNode = smallContainer.toDiagnosticsNode();
  final smallOutput = debugRenderer.render(smallNode);
  final smallOutputFine = fineRenderer.render(smallNode);
  final smallOutputInfo = infoRenderer.render(smallNode);
  print('Small render: ${_preview(smallOutput, 80)}');
  print('Small fine length: ${smallOutputFine.length}');
  print('Small info length: ${smallOutputInfo.length}');

  final smallRenderCard = _buildRenderCard(
    title: 'Container(100x50, amber)',
    subtitle: 'minLevel: debug',
    output: smallOutput,
    color: Colors.amber.shade800,
    icon: Icons.crop_square,
  );

  final smallRenderCardFine = _buildRenderCard(
    title: 'Container(100x50, amber)',
    subtitle: 'minLevel: fine',
    output: smallOutputFine,
    color: Colors.lightGreen.shade700,
    icon: Icons.crop_square,
  );

  final smallRenderCardInfo = _buildRenderCard(
    title: 'Container(100x50, amber)',
    subtitle: 'minLevel: info',
    output: smallOutputInfo,
    color: Colors.cyan.shade700,
    icon: Icons.crop_square,
  );

  // ============================================================
  // SECTION 4: Render Output of a Padded Decorated Container
  // ============================================================
  print('=== Section 4: Render Output of a Decorated Container ===');

  final decoratedContainer = Container(
    width: 200.0,
    height: 120.0,
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue, Colors.purple],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
  );

  final decoratedNode = decoratedContainer.toDiagnosticsNode();
  final decoratedOutput = debugRenderer.render(decoratedNode);
  final decoratedOutputWide = wideRenderer.render(decoratedNode);
  final decoratedOutputNarrow = narrowRenderer.render(decoratedNode);
  print('Decorated default len: ${decoratedOutput.length}');
  print('Decorated wide len:    ${decoratedOutputWide.length}');
  print('Decorated narrow len:  ${decoratedOutputNarrow.length}');

  final decoratedDefaultCard = _buildRenderCard(
    title: 'Decorated Container',
    subtitle: 'wrapWidth: 100',
    output: decoratedOutput,
    color: Colors.indigo,
    icon: Icons.gradient,
  );
  final decoratedWideCard = _buildRenderCard(
    title: 'Decorated Container',
    subtitle: 'wrapWidth: 200',
    output: decoratedOutputWide,
    color: Colors.green.shade700,
    icon: Icons.unfold_more,
  );
  final decoratedNarrowCard = _buildRenderCard(
    title: 'Decorated Container',
    subtitle: 'wrapWidth: 60',
    output: decoratedOutputNarrow,
    color: Colors.orange.shade800,
    icon: Icons.unfold_less,
  );

  // ============================================================
  // SECTION 5: Render Output of a Multi-Child Column
  // ============================================================
  print('=== Section 5: Render Output of a Multi-Child Column ===');

  final multiChild = Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text('first'),
      Text('second'),
      Text('third'),
      Container(width: 10.0, height: 10.0, color: Colors.red),
      Container(width: 12.0, height: 12.0, color: Colors.green),
      Container(width: 14.0, height: 14.0, color: Colors.blue),
      Container(width: 16.0, height: 16.0, color: Colors.purple),
      Container(width: 18.0, height: 18.0, color: Colors.orange),
    ],
  );
  final multiChildNode = multiChild.toDiagnosticsNode();
  final multiChildOutput = debugRenderer.render(multiChildNode);
  final multiChildOutputTrunc = truncatedRenderer.render(multiChildNode);
  print('Multi-child default len: ${multiChildOutput.length}');
  print('Multi-child trunc len:   ${multiChildOutputTrunc.length}');

  final multiDefaultCard = _buildRenderCard(
    title: 'Column with 8 children',
    subtitle: 'maxDescendents: -1 (no truncate)',
    output: multiChildOutput,
    color: Colors.deepPurple,
    icon: Icons.view_column,
  );

  final multiTruncCard = _buildRenderCard(
    title: 'Column with 8 children',
    subtitle: 'maxDescendents: 5 (truncate)',
    output: multiChildOutputTrunc,
    color: Colors.pink.shade700,
    icon: Icons.content_cut,
  );

  // ============================================================
  // SECTION 6: Wrap-Width Visual Comparison
  // ============================================================
  print('=== Section 6: Wrap-Width Comparison ===');

  final wrapWidths = <int>[40, 60, 80, 100, 140, 200];
  final wrapStats = <Widget>[];
  for (final ww in wrapWidths) {
    final r = TextTreeRenderer(
      minLevel: DiagnosticLevel.debug,
      wrapWidth: ww,
      wrapWidthProperties: (ww * 0.65).round(),
    );
    final out = r.render(decoratedNode);
    final lineCount = out.split('\n').length;
    print('wrapWidth=$ww -> length ${out.length}, lines $lineCount');

    wrapStats.add(
      Container(
        width: 130.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.cyan.shade50,
              Colors.cyan.shade200,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.cyan.shade400, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.cyan.withValues(alpha: 0.25),
              blurRadius: 5.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              Icons.view_agenda,
              color: Colors.cyan.shade800,
              size: 24.0,
            ),
            SizedBox(height: 4.0),
            Text(
              'wrap=$ww',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade900,
              ),
            ),
            SizedBox(height: 6.0),
            _buildKv('chars', '${out.length}', Colors.cyan.shade900),
            _buildKv('lines', '$lineCount', Colors.cyan.shade900),
          ],
        ),
      ),
    );
  }
  print('Built ${wrapStats.length} wrap-width stat cards');

  // ============================================================
  // SECTION 7: maxDescendentsTruncatableNode Comparison
  // ============================================================
  print('=== Section 7: maxDescendentsTruncatableNode Comparison ===');

  final descLimits = <int>[-1, 1, 2, 3, 4, 5, 8];
  final descCards = <Widget>[];
  for (final lim in descLimits) {
    final r = TextTreeRenderer(
      minLevel: DiagnosticLevel.debug,
      maxDescendentsTruncatableNode: lim,
    );
    final out = r.render(multiChildNode);
    final containsEllipsis = out.contains('...');
    final lines = out.split('\n').length;
    print('maxDesc=$lim -> length ${out.length}, ellipsis $containsEllipsis');

    descCards.add(
      Container(
        width: 150.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepOrange.shade50,
              Colors.deepOrange.shade200,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.deepOrange.shade400,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.deepOrange.withValues(alpha: 0.25),
              blurRadius: 6.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              containsEllipsis ? Icons.more_horiz : Icons.list,
              color: Colors.deepOrange.shade800,
              size: 26.0,
            ),
            SizedBox(height: 4.0),
            Text(
              'maxDesc=$lim',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade900,
              ),
            ),
            SizedBox(height: 6.0),
            _buildKv('chars', '${out.length}', Colors.deepOrange.shade900),
            _buildKv('lines', '$lines', Colors.deepOrange.shade900),
            _buildKv(
              'ellipsis',
              containsEllipsis ? 'yes' : 'no',
              Colors.deepOrange.shade900,
            ),
          ],
        ),
      ),
    );
  }
  print('Built ${descCards.length} descendant-limit cards');

  // ============================================================
  // SECTION 8: Level-Filter Output Comparison Table
  // ============================================================
  print('=== Section 8: Level-Filter Output Comparison Table ===');

  final filterNode = Container(
    width: 80.0,
    height: 40.0,
    padding: EdgeInsets.all(4.0),
    margin: EdgeInsets.all(2.0),
    color: Colors.lightBlue,
  ).toDiagnosticsNode();

  final levelFilterRows = <Widget>[];
  final filterLevels = <DiagnosticLevel>[
    DiagnosticLevel.fine,
    DiagnosticLevel.debug,
    DiagnosticLevel.info,
    DiagnosticLevel.warning,
    DiagnosticLevel.hint,
    DiagnosticLevel.summary,
    DiagnosticLevel.error,
  ];
  for (final lvl in filterLevels) {
    final r = TextTreeRenderer(minLevel: lvl);
    final out = r.render(filterNode);
    final lines = out.split('\n').length;
    print('minLevel=${lvl.name} length=${out.length} lines=$lines');
    levelFilterRows.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
          ),
        ),
        child: Row(
          children: [
            _buildHeaderCell(lvl.name, 100.0),
            _buildDataCell('${out.length}', 80.0, Colors.black87),
            _buildDataCell('$lines', 80.0, Colors.black87),
            Expanded(
              child: Container(
                height: 14.0,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: (out.length / 600).clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.lightBlue, Colors.indigo],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
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

  final levelFilterTable = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade400, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'render(node) by minLevel',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.indigo.shade100,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            children: [
              _buildHeaderCell('minLevel', 100.0),
              _buildHeaderCell('chars', 80.0),
              _buildHeaderCell('lines', 80.0),
              Expanded(
                child: Text(
                  'output size',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade900,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        ...levelFilterRows,
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Diagnostic Tree Pipeline Diagram
  // ============================================================
  print('=== Section 9: Diagnostic Tree Pipeline Diagram ===');

  final pipelineDiagram = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.blueGrey.shade50,
          Colors.blueGrey.shade200,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blueGrey.shade400, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.withValues(alpha: 0.30),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'TextTreeRenderer Pipeline',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey.shade900,
          ),
        ),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildPipelineNode(
              'Widget',
              Colors.green,
              Icons.widgets,
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.blueGrey.shade700,
              size: 26.0,
            ),
            _buildPipelineNode(
              'DiagnosticsNode',
              Colors.blue,
              Icons.account_tree,
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.blueGrey.shade700,
              size: 26.0,
            ),
            _buildPipelineNode(
              'TextTreeRenderer',
              Colors.indigo,
              Icons.build,
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.blueGrey.shade700,
              size: 26.0,
            ),
            _buildPipelineNode(
              'String',
              Colors.deepPurple,
              Icons.text_snippet,
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Widget.toDiagnosticsNode() builds a DiagnosticsNode tree.\n'
            'TextTreeRenderer.render(node) walks the tree, applies '
            'minLevel filtering, wrapWidth wrapping, and '
            'maxDescendentsTruncatableNode truncation, then emits a '
            'String.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.blueGrey.shade900,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: API Reference Code Block
  // ============================================================
  print('=== Section 10: API Reference Code Block ===');

  final apiCodeBlock = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.black],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.40),
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
            Icon(Icons.code, color: Colors.cyanAccent, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'TextTreeRenderer API',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyanAccent,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildCodeBlock(
          '// Construct with defaults\n'
          'final renderer = TextTreeRenderer();\n\n'
          '// Custom configuration\n'
          'final r = TextTreeRenderer(\n'
          '  minLevel: DiagnosticLevel.debug,\n'
          '  wrapWidth: 100,\n'
          '  wrapWidthProperties: 65,\n'
          '  maxDescendentsTruncatableNode: -1,\n'
          ');',
          Colors.cyan.shade200,
        ),
        SizedBox(height: 12.0),
        _buildCodeBlock(
          '// Render a diagnostics node to text\n'
          'final node = widget.toDiagnosticsNode();\n'
          'final text = renderer.render(\n'
          '  node,\n'
          '  prefixLineOne: \'\',\n'
          '  prefixOtherLines: null,\n'
          '  parentConfiguration: null,\n'
          ');',
          Colors.greenAccent.shade100,
        ),
        SizedBox(height: 12.0),
        _buildCodeBlock(
          '// Filter by diagnostic level\n'
          'final fineRenderer = TextTreeRenderer(\n'
          '  minLevel: DiagnosticLevel.fine,\n'
          ');\n'
          'final infoRenderer = TextTreeRenderer(\n'
          '  minLevel: DiagnosticLevel.info,\n'
          ');',
          Colors.amberAccent.shade100,
        ),
        SizedBox(height: 12.0),
        _buildCodeBlock(
          '// Truncate large trees\n'
          'final truncated = TextTreeRenderer(\n'
          '  maxDescendentsTruncatableNode: 5,\n'
          ');\n'
          'final out = truncated.render(node);',
          Colors.pinkAccent.shade100,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 11: Property Detail Panel
  // ============================================================
  print('=== Section 11: Property Detail Panel ===');

  final propertyPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.amber.shade50,
          Colors.amber.shade200,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.amber.shade600, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.30),
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
            Icon(Icons.settings, color: Colors.amber.shade900, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Constructor Parameters',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        _buildPropertyRow(
          'minLevel',
          'DiagnosticLevel',
          'Filter properties below this level. Default: debug.',
          Icons.filter_list,
        ),
        _buildPropertyRow(
          'wrapWidth',
          'int',
          'Maximum line width before wrapping. Default: 100.',
          Icons.wrap_text,
        ),
        _buildPropertyRow(
          'wrapWidthProperties',
          'int',
          'Wrap width specifically for properties. Default: 65.',
          Icons.format_indent_increase,
        ),
        _buildPropertyRow(
          'maxDescendentsTruncatableNode',
          'int',
          'Truncate descendants of allowTruncate nodes. Default: -1.',
          Icons.content_cut,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 12: Summary Stats Strip
  // ============================================================
  print('=== Section 12: Summary Stats Strip ===');

  final summaryStrip = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade400, Colors.cyan.shade700],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.35),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStat('Levels', '${diagnosticLevels.length}', Icons.layers),
        _buildStat('Wraps', '${wrapWidths.length}', Icons.wrap_text),
        _buildStat('Limits', '${descLimits.length}', Icons.content_cut),
        _buildStat(
          'Renderers',
          '${constructionData.length}',
          Icons.build_circle,
        ),
      ],
    ),
  );

  print('TextTreeRenderer Deep Demo completed successfully');

  // ============================================================
  // Final visual layout
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Header banner
            Container(
              padding: EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.indigo.shade700,
                    Colors.deepPurple.shade500,
                    Colors.purple.shade400,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withValues(alpha: 0.40),
                    blurRadius: 14.0,
                    offset: Offset(0.0, 6.0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.account_tree,
                    color: Colors.white,
                    size: 56.0,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'TextTreeRenderer',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/foundation.dart',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'monospace',
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'Diagnostic tree text rendering pipeline',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            summaryStrip,
            SizedBox(height: 24.0),

            // Section 1
            _buildSectionHeading(
              '1. Renderer Construction Variants',
              Icons.tune,
              Colors.indigo,
            ),
            Wrap(
              alignment: WrapAlignment.center,
              children: constructionCards,
            ),
            SizedBox(height: 24.0),

            // Section 2
            _buildSectionHeading(
              '2. DiagnosticLevel Spectrum',
              Icons.layers,
              Colors.cyan,
            ),
            Wrap(alignment: WrapAlignment.center, children: levelTiles),
            SizedBox(height: 24.0),

            // Section 3
            _buildSectionHeading(
              '3. Simple Container Render',
              Icons.crop_square,
              Colors.amber,
            ),
            smallRenderCard,
            smallRenderCardFine,
            smallRenderCardInfo,
            SizedBox(height: 24.0),

            // Section 4
            _buildSectionHeading(
              '4. Decorated Container - Wrap Widths',
              Icons.gradient,
              Colors.indigo,
            ),
            decoratedDefaultCard,
            decoratedWideCard,
            decoratedNarrowCard,
            SizedBox(height: 24.0),

            // Section 5
            _buildSectionHeading(
              '5. Multi-Child Column Render',
              Icons.view_column,
              Colors.deepPurple,
            ),
            multiDefaultCard,
            multiTruncCard,
            SizedBox(height: 24.0),

            // Section 6
            _buildSectionHeading(
              '6. Wrap-Width Comparison',
              Icons.wrap_text,
              Colors.cyan,
            ),
            Wrap(alignment: WrapAlignment.center, children: wrapStats),
            SizedBox(height: 24.0),

            // Section 7
            _buildSectionHeading(
              '7. maxDescendentsTruncatableNode',
              Icons.content_cut,
              Colors.deepOrange,
            ),
            Wrap(alignment: WrapAlignment.center, children: descCards),
            SizedBox(height: 24.0),

            // Section 8
            _buildSectionHeading(
              '8. Level-Filter Comparison Table',
              Icons.table_chart,
              Colors.indigo,
            ),
            levelFilterTable,
            SizedBox(height: 24.0),

            // Section 9
            _buildSectionHeading(
              '9. Pipeline Diagram',
              Icons.timeline,
              Colors.blueGrey,
            ),
            pipelineDiagram,
            SizedBox(height: 24.0),

            // Section 10
            _buildSectionHeading(
              '10. API Reference',
              Icons.code,
              Colors.grey,
            ),
            apiCodeBlock,
            SizedBox(height: 24.0),

            // Section 11
            _buildSectionHeading(
              '11. Constructor Parameters',
              Icons.settings,
              Colors.amber,
            ),
            propertyPanel,
            SizedBox(height: 24.0),

            // Footer
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.grey.shade300,
                    Colors.grey.shade500,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.10),
                    blurRadius: 4.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green.shade800,
                    size: 36.0,
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'Demo Complete',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade900,
                    ),
                  ),
                  Text(
                    'TextTreeRenderer rendered ${defaultRenderer.runtimeType} '
                    'across ${diagnosticLevels.length} levels',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),
          ],
        ),
      ),
    ),
  );
}

// =====================================================================
// Helper widgets and utilities
// =====================================================================

// Helper: Preview the first n chars of a string with newline-safe ellipsis.
String _preview(String s, int n) {
  final clean = s.replaceAll('\n', ' / ');
  if (clean.length <= n) {
    return clean;
  }
  return '${clean.substring(0, n)}...';
}

// Helper: Build a key/value mini-row used inside cards.
Widget _buildKv(String key, String value, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: [
        Text(
          '$key:',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: color.withValues(alpha: 0.85),
          ),
        ),
        SizedBox(width: 4.0),
        Expanded(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper: Build a card that displays a render() output with a title.
Widget _buildRenderCard({
  required String title,
  required String subtitle,
  required String output,
  required Color color,
  required IconData icon,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withValues(alpha: 0.15),
                color.withValues(alpha: 0.30),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(13.0),
              topRight: Radius.circular(13.0),
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 22.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 11.0,
                        fontStyle: FontStyle.italic,
                        color: color.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 6.0,
                  vertical: 2.0,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.20),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  '${output.length} chars',
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
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(13.0),
              bottomRight: Radius.circular(13.0),
            ),
          ),
          child: Text(
            output.isEmpty ? '(empty render output)' : output,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: Colors.greenAccent.shade100,
              height: 1.3,
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper: Build a header cell for the comparison matrix.
Widget _buildHeaderCell(String text, double width) {
  return Container(
    width: width,
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 11.0,
        color: Colors.indigo.shade900,
      ),
    ),
  );
}

// Helper: Build a data cell for the comparison matrix.
Widget _buildDataCell(String text, double width, Color color) {
  return Container(
    width: width,
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: color,
      ),
    ),
  );
}

// Helper: Build a code block.
Widget _buildCodeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
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
        fontSize: 11.0,
        color: textColor,
        height: 1.4,
      ),
    ),
  );
}

// Helper: Build a pipeline node tile.
Widget _buildPipelineNode(String label, Color color, IconData icon) {
  return Container(
    width: 110.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.15),
          color.withValues(alpha: 0.35),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.30),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 28.0),
        SizedBox(height: 4.0),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

// Helper: Build a property row inside the property panel.
Widget _buildPropertyRow(
  String name,
  String type,
  String description,
  IconData icon,
) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.amber.shade900, size: 22.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade100,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      name,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber.shade900,
                      ),
                    ),
                  ),
                  SizedBox(width: 6.0),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade300,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                        color: Colors.amber.shade900,
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
                  color: Colors.amber.shade900,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper: Build a section heading bar.
Widget _buildSectionHeading(String label, IconData icon, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.20),
            color.withValues(alpha: 0.05),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border(
          left: BorderSide(color: color, width: 4.0),
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.20),
            blurRadius: 4.0,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 22.0),
          SizedBox(width: 8.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    ),
  );
}

// Helper: Build a stat tile for the summary strip.
Widget _buildStat(String label, String value, IconData icon) {
  return Column(
    children: [
      Icon(icon, color: Colors.white, size: 26.0),
      SizedBox(height: 4.0),
      Text(
        value,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      Text(
        label,
        style: TextStyle(fontSize: 11.0, color: Colors.white70),
      ),
    ],
  );
}
