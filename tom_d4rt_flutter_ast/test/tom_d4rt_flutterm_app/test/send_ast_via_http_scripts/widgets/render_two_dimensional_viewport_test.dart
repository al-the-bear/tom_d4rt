import 'package:flutter/material.dart';

// Top-level ValueNotifiers (stateless approach)
final ValueNotifier<ChildVicinity?> _selectedCell =
    ValueNotifier<ChildVicinity?>(null);
final ValueNotifier<double> _hOffset = ValueNotifier<double>(0.0);
final ValueNotifier<double> _vOffset = ValueNotifier<double>(0.0);

dynamic build(BuildContext context) {
  final ColorScheme cs = ColorScheme.fromSeed(seedColor: Colors.indigo);
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: cs,
    ),
    home: DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: cs.primary,
          foregroundColor: cs.onPrimary,
          title: const Text(
            'RenderTwoDimensionalViewport Deep Demo',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          bottom: TabBar(
            isScrollable: true,
            labelColor: cs.onPrimary,
            unselectedLabelColor: cs.onPrimary.withAlpha(160),
            indicatorColor: cs.secondary,
            tabs: const [
              Tab(text: 'Hero'),
              Tab(text: 'Live Grid'),
              Tab(text: 'Delegate'),
              Tab(text: 'ChildVicinity'),
              Tab(text: 'Diagonal'),
              Tab(text: 'Pinned'),
              Tab(text: 'Cell Styles'),
              Tab(text: 'Scroll Pos'),
              Tab(text: 'Compare'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _HeroTab(cs: cs),
            _LiveGridTab(cs: cs),
            _DelegateTab(cs: cs),
            _ChildVicinityTab(cs: cs),
            _DiagonalTab(cs: cs),
            _PinnedTab(cs: cs),
            _CellStylesTab(cs: cs),
            _ScrollPosTab(cs: cs),
            _CompareTab(cs: cs),
          ],
        ),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 1: Hero Banner
// ─────────────────────────────────────────────────────────────────────────────

class _HeroTab extends StatelessWidget {
  const _HeroTab({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _GradientBanner(cs: cs),
        const SizedBox(height: 20),
        _SectionCard(
          title: 'What is RenderTwoDimensionalViewport?',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _bodyText(
                'Introduced in Flutter 3.7, RenderTwoDimensionalViewport is '
                'the render object that powers any widget capable of scrolling '
                'simultaneously in both the horizontal and vertical axes. It '
                'manages child layout, culling via cache extent, and the '
                'ChildVicinity addressing model.',
              ),
              const SizedBox(height: 12),
              _bodyText(
                'Unlike the standard single-axis RenderViewport, this render '
                'object tracks each child by a 2-D (xIndex, yIndex) address '
                'called a ChildVicinity, allowing the framework to build, lay '
                'out, and recycle cells across both axes efficiently.',
              ),
              const SizedBox(height: 16),
              _ArchitecturePainterCard(cs: cs),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _SectionCard(
          title: 'Class Hierarchy',
          child: _ClassHierarchyDiagram(cs: cs),
        ),
        const SizedBox(height: 16),
        _SectionCard(
          title: 'When to use which widget?',
          child: _ComparisonTable(cs: cs),
        ),
        const SizedBox(height: 16),
        _SectionCard(
          title: 'Key classes at a glance',
          child: _ApiCheatSheet(cs: cs),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _GradientBanner extends StatelessWidget {
  const _GradientBanner({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [cs.primary, cs.tertiary],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Two-Dimensional\nScrolling in Flutter',
            style: TextStyle(
              color: cs.onPrimary,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'RenderTwoDimensionalViewport · TwoDimensionalScrollable\n'
            'ChildVicinity · TwoDimensionalChildBuilderDelegate',
            style: TextStyle(
              color: cs.onPrimary.withAlpha(210),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _TagChip(label: 'Flutter 3.7+', cs: cs),
              _TagChip(label: 'ChildVicinity', cs: cs),
              _TagChip(label: 'TwoDimensionalScrollable', cs: cs),
              _TagChip(label: 'Pinned rows/cols', cs: cs),
              _TagChip(label: 'RenderTwoDimensionalViewport', cs: cs),
            ],
          ),
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.label, required this.cs});
  final String label;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: cs.onPrimary.withAlpha(38),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cs.onPrimary.withAlpha(80)),
      ),
      child: Text(
        label,
        style: TextStyle(color: cs.onPrimary, fontSize: 11),
      ),
    );
  }
}

class _ClassHierarchyDiagram extends StatelessWidget {
  const _ClassHierarchyDiagram({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    const entries = [
      ('RenderObject', 0),
      ('RenderTwoDimensionalViewport (abstract)', 1),
      ('Your custom viewport render object', 2),
      ('TwoDimensionalViewport (abstract Widget)', 1),
      ('Your TwoDimensionalViewport subclass', 2),
      ('TwoDimensionalScrollView (abstract Widget)', 1),
      ('Your concrete TwoDimensionalScrollView', 2),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: entries.map((entry) {
        final (label, indent) = entry;
        final isAbstract = label.contains('abstract') || label == 'RenderObject';
        return Padding(
          padding: EdgeInsets.only(
              left: 16.0 * indent, top: 3, bottom: 3),
          child: Row(
            children: [
              if (indent > 0) ...[
                Icon(Icons.subdirectory_arrow_right,
                    size: 14, color: cs.outline),
                const SizedBox(width: 4),
              ],
              Flexible(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isAbstract
                        ? cs.errorContainer.withAlpha(120)
                        : cs.primaryContainer,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: isAbstract
                          ? cs.error.withAlpha(100)
                          : cs.primary.withAlpha(80),
                    ),
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'monospace',
                      color: isAbstract
                          ? cs.onErrorContainer
                          : cs.onPrimaryContainer,
                      fontStyle:
                          isAbstract ? FontStyle.italic : FontStyle.normal,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 2: Live Grid (20 cols × 50 rows, true 2D scroll)
// ─────────────────────────────────────────────────────────────────────────────

class _LiveGridTab extends StatelessWidget {
  const _LiveGridTab({required this.cs});
  final ColorScheme cs;

  static const int _cols = 20;
  static const int _rows = 50;
  static const double _cellW = 96.0;
  static const double _cellH = 44.0;
  static const double _headerW = 72.0;
  static const double _headerH = 48.0;

  Color _colColor(int col) {
    final palette = [
      Colors.indigo.shade100,
      Colors.teal.shade100,
      Colors.orange.shade100,
      Colors.purple.shade100,
      Colors.red.shade100,
    ];
    return palette[col % palette.length];
  }

  Widget _buildHeaderRow() {
    return Row(
      children: [
        // Corner cell
        Container(
          width: _headerW,
          height: _headerH,
          color: cs.primary,
          alignment: Alignment.center,
          child: Text('#',
              style: TextStyle(
                  color: cs.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 13)),
        ),
        // Column headers
        for (int col = 1; col < _cols; col++)
          Container(
            width: _cellW,
            height: _headerH,
            color: cs.primaryContainer,
            alignment: Alignment.center,
            child: Text('Col $col',
                style: TextStyle(
                    color: cs.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                    fontSize: 12)),
          ),
      ],
    );
  }

  Widget _buildDataRow(int row) {
    return SizedBox(
      height: _cellH,
      child: Row(
        children: [
          // Row header
          Container(
            width: _headerW,
            height: _cellH,
            color: cs.secondaryContainer,
            alignment: Alignment.center,
            child: Text('R$row',
                style: TextStyle(
                    color: cs.onSecondaryContainer,
                    fontWeight: FontWeight.bold,
                    fontSize: 11)),
          ),
          // Data cells
          for (int col = 1; col < _cols; col++)
            Container(
              width: _cellW,
              height: _cellH,
              color: (row % 2 == 0)
                  ? _colColor(col)
                  : _colColor(col).withAlpha(120),
              alignment: Alignment.center,
              child: Text('($col,$row)',
                  style: const TextStyle(fontSize: 11)),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _InfoBanner(
          cs: cs,
          icon: Icons.table_chart,
          text: '$_cols columns × $_rows rows. Pinned header row + header column. '
              'Scroll freely in both axes. Powered by nested SingleChildScrollViews '
              'with a sticky header implemented via Stack.',
        ),
        Expanded(
          child: _StickyHeaderGrid(
            cs: cs,
            cols: _cols,
            rows: _rows,
            cellW: _cellW,
            cellH: _cellH,
            headerW: _headerW,
            headerH: _headerH,
            buildHeaderRow: _buildHeaderRow,
            buildDataRow: _buildDataRow,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            'Header row (row 0) and header column (col 0) remain pinned. '
            'Data cells scroll freely — analogous to TableView pinnedRowCount:1 '
            'pinnedColumnCount:1.',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 11, color: cs.onSurface.withAlpha(140)),
          ),
        ),
      ],
    );
  }
}

/// A grid widget with a pinned header row built from nested scroll views.
class _StickyHeaderGrid extends StatelessWidget {
  const _StickyHeaderGrid({
    required this.cs,
    required this.cols,
    required this.rows,
    required this.cellW,
    required this.cellH,
    required this.headerW,
    required this.headerH,
    required this.buildHeaderRow,
    required this.buildDataRow,
  });

  final ColorScheme cs;
  final int cols;
  final int rows;
  final double cellW;
  final double cellH;
  final double headerW;
  final double headerH;
  final Widget Function() buildHeaderRow;
  final Widget Function(int row) buildDataRow;

  @override
  Widget build(BuildContext context) {
    final hCtrl = ScrollController();
    final hCtrlHeader = ScrollController();

    void syncHeaders() {
      if (hCtrl.hasClients && hCtrlHeader.hasClients) {
        hCtrlHeader.jumpTo(hCtrl.offset);
      }
    }
    hCtrl.addListener(syncHeaders);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Pinned header row — synced horizontal scroll
        SingleChildScrollView(
          controller: hCtrlHeader,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: buildHeaderRow(),
        ),
        // Data rows — both axes scroll
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: hCtrl,
            child: SizedBox(
              width: headerW + cellW * (cols - 1),
              child: ListView.builder(
                itemCount: rows,
                itemExtent: cellH,
                itemBuilder: (context, row) => buildDataRow(row + 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 3: TwoDimensionalChildBuilderDelegate showcase
// ─────────────────────────────────────────────────────────────────────────────

class _DelegateTab extends StatelessWidget {
  const _DelegateTab({required this.cs});
  final ColorScheme cs;

  static const int _xCount = 10;
  static const int _yCount = 20;
  static const double _cellSize = 90.0;

  Color _cellColor(int x, int y) {
    final hue = (x * 36 + y * 7) % 360;
    return HSLColor.fromAHSL(1.0, hue.toDouble(), 0.5, 0.85).toColor();
  }

  @override
  Widget build(BuildContext context) {
    // Demonstrate actual use of TwoDimensionalChildBuilderDelegate API
    final delegate = TwoDimensionalChildBuilderDelegate(
      maxXIndex: _xCount - 1,
      maxYIndex: _yCount - 1,
      builder: (BuildContext ctx, ChildVicinity vicinity) {
        final x = vicinity.xIndex;
        final y = vicinity.yIndex;
        return Container(
          width: _cellSize,
          height: _cellSize,
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: _cellColor(x, y),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white, width: 1.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('x:$x  y:$y',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              Text('ChildVicinity\n(xIndex:$x, yIndex:$y)',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 8)),
            ],
          ),
        );
      },
    );

    // Verify delegate properties
    final maxX = delegate.maxXIndex;
    final maxY = delegate.maxYIndex;

    return Column(
      children: [
        _InfoBanner(
          cs: cs,
          icon: Icons.grid_on,
          text: 'TwoDimensionalChildBuilderDelegate builds cells on demand via '
              'builder(context, ChildVicinity). maxXIndex=$maxX, maxYIndex=$maxY. '
              'Grid: ${maxX! + 1} cols × ${maxY! + 1} rows.',
        ),
        _DelegateCodeCard(cs: cs),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: (_cellSize + 4) * _xCount,
              child: ListView.builder(
                itemCount: _yCount,
                itemExtent: _cellSize + 4,
                itemBuilder: (ctx, row) {
                  return Row(
                    children: List.generate(_xCount, (col) {
                      final vicinity =
                          ChildVicinity(xIndex: col, yIndex: row);
                      return delegate.builder(ctx, vicinity)!;
                    }),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DelegateCodeCard extends StatelessWidget {
  const _DelegateCodeCard({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cs.outline.withAlpha(60)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Usage',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: cs.primary)),
          const SizedBox(height: 6),
          _CodeLine('final delegate = TwoDimensionalChildBuilderDelegate(', cs),
          _CodeLine('  maxXIndex: 9,  // 10 columns (0–9)', cs),
          _CodeLine('  maxYIndex: 19, // 20 rows    (0–19)', cs),
          _CodeLine(
              '  builder: (BuildContext ctx, ChildVicinity vicinity) {', cs),
          _CodeLine('    final x = vicinity.xIndex; // column', cs),
          _CodeLine('    final y = vicinity.yIndex; // row', cs),
          _CodeLine('    return Container(/* your cell widget */);', cs),
          _CodeLine('  },', cs),
          _CodeLine(');', cs),
        ],
      ),
    );
  }
}

class _CodeLine extends StatelessWidget {
  const _CodeLine(this.text, this.cs);
  final String text;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11,
          color: cs.onSurface,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 4: ChildVicinity showcase
// ─────────────────────────────────────────────────────────────────────────────

class _ChildVicinityTab extends StatelessWidget {
  const _ChildVicinityTab({required this.cs});
  final ColorScheme cs;

  static const int _cols = 8;
  static const int _rows = 8;
  static const double _cellSize = 66.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _InfoBanner(
          cs: cs,
          icon: Icons.touch_app,
          text: 'Tap any cell. ChildVicinity(xIndex: col, yIndex: row) uniquely '
              'identifies each position in 2D scroll space. Selected cell is '
              'highlighted via ValueNotifier<ChildVicinity?>.',
        ),
        ValueListenableBuilder<ChildVicinity?>(
          valueListenable: _selectedCell,
          builder: (context, selected, _) {
            return Container(
              color: cs.secondaryContainer,
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.info_outline,
                      color: cs.onSecondaryContainer, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      selected == null
                          ? 'No cell selected — tap one'
                          : 'ChildVicinity(xIndex: ${selected.xIndex}, '
                              'yIndex: ${selected.yIndex})  •  '
                              'column ${selected.xIndex}, row ${selected.yIndex}',
                      style: TextStyle(
                        color: cs.onSecondaryContainer,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: _cellSize * _cols + 4,
              child: ListView.builder(
                itemCount: _rows,
                itemExtent: _cellSize,
                itemBuilder: (ctx, row) {
                  return Row(
                    children: List.generate(_cols, (col) {
                      final vicinity =
                          ChildVicinity(xIndex: col, yIndex: row);
                      return _TappableCell(
                        vicinity: vicinity,
                        selectedNotifier: _selectedCell,
                        size: _cellSize,
                        cs: cs,
                      );
                    }),
                  );
                },
              ),
            ),
          ),
        ),
        _ChildVicinityDiagram(cs: cs),
      ],
    );
  }
}

class _TappableCell extends StatelessWidget {
  const _TappableCell({
    required this.vicinity,
    required this.selectedNotifier,
    required this.size,
    required this.cs,
  });

  final ChildVicinity vicinity;
  final ValueNotifier<ChildVicinity?> selectedNotifier;
  final double size;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    final x = vicinity.xIndex;
    final y = vicinity.yIndex;
    return ValueListenableBuilder<ChildVicinity?>(
      valueListenable: selectedNotifier,
      builder: (ctx, selected, _) {
        final isSelected = selected != null &&
            selected.xIndex == x &&
            selected.yIndex == y;
        return GestureDetector(
          onTap: () {
            selectedNotifier.value = isSelected ? null : vicinity;
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: size - 4,
            height: size - 4,
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: isSelected
                  ? cs.primary
                  : (x + y) % 2 == 0
                      ? cs.surfaceContainerHighest
                      : cs.surfaceContainerLow,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color:
                    isSelected ? cs.tertiary : cs.outline.withAlpha(80),
                width: isSelected ? 2.5 : 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                          color: cs.primary.withAlpha(100),
                          blurRadius: 6)
                    ]
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '($x,$y)',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? cs.onPrimary : cs.onSurface,
                  ),
                ),
                if (isSelected)
                  Icon(Icons.check_circle,
                      size: 14, color: cs.onPrimary),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ChildVicinityDiagram extends StatelessWidget {
  const _ChildVicinityDiagram({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cs.surfaceContainerLow,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ChildVicinity coordinate model',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: cs.onSurface),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 130,
            child: CustomPaint(
              painter: _VicinityDiagramPainter(cs: cs),
              child: const SizedBox.expand(),
            ),
          ),
        ],
      ),
    );
  }
}

class _VicinityDiagramPainter extends CustomPainter {
  const _VicinityDiagramPainter({required this.cs});
  final ColorScheme cs;

  @override
  void paint(Canvas canvas, Size size) {
    final axisPaint = Paint()
      ..color = cs.outline
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const originX = 50.0;
    const originY = 100.0;
    const axisLen = 180.0;
    const cellW = 64.0;
    const cellH = 36.0;

    canvas.drawLine(const Offset(originX, originY),
        Offset(originX + axisLen, originY), axisPaint);
    canvas.drawLine(const Offset(originX, originY),
        Offset(originX, originY - 90), axisPaint);

    // Axis arrowheads
    final arrowH = Paint()
      ..color = cs.outline
      ..style = PaintingStyle.fill;
    final arrowPath = Path()
      ..moveTo(originX + axisLen - 6, originY - 5)
      ..lineTo(originX + axisLen + 2, originY)
      ..lineTo(originX + axisLen - 6, originY + 5)
      ..close();
    canvas.drawPath(arrowPath, arrowH);
    final arrowPathV = Path()
      ..moveTo(originX - 5, originY - 88)
      ..lineTo(originX, originY - 96)
      ..lineTo(originX + 5, originY - 88)
      ..close();
    canvas.drawPath(arrowPathV, arrowH);

    void drawLabel(String text, Offset offset) {
      final tp = TextPainter(
        text: TextSpan(
            text: text,
            style: TextStyle(color: cs.onSurface, fontSize: 10)),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, offset);
    }

    drawLabel('xIndex →', Offset(originX + axisLen - 40, originY + 8));
    drawLabel('yIndex ↑', Offset(originX + 6, originY - 98));

    final cells = [
      (0, 0, '(0,0)'),
      (1, 0, '(1,0)'),
      (2, 0, '(2,0)'),
      (0, 1, '(0,1)'),
      (1, 1, '(1,1)'),
      (2, 1, '(2,1)'),
    ];
    final cellPaint = Paint()..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (final (xi, yi, label) in cells) {
      final rx = originX + xi * cellW + 2;
      final ry = originY - (yi + 1) * cellH;
      final rect = Rect.fromLTWH(rx, ry, cellW - 4, cellH - 2);
      cellPaint.color = (xi + yi) % 2 == 0
          ? cs.primaryContainer.withAlpha(180)
          : cs.tertiaryContainer.withAlpha(180);
      borderPaint.color = cs.primary.withAlpha(140);
      canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(4)),
          cellPaint);
      canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(4)),
          borderPaint);
      final tp = TextPainter(
        text: TextSpan(
            text: label,
            style: TextStyle(color: cs.onSurface, fontSize: 9)),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas,
          Offset(rx + 4, ry + (cellH - 2) / 2 - tp.height / 2));
    }
  }

  @override
  bool shouldRepaint(_VicinityDiagramPainter old) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 5: Diagonal scrolling
// ─────────────────────────────────────────────────────────────────────────────

class _DiagonalTab extends StatelessWidget {
  const _DiagonalTab({required this.cs});
  final ColorScheme cs;

  static const int _xCount = 6;
  static const int _yCount = 14;
  static const double _cellW = 120.0;
  static const double _cellH = 52.0;
  static const double _diagStep = 80.0;

  Color _cellColor(int x, int y) {
    final palette = [
      Colors.pink.shade200,
      Colors.amber.shade200,
      Colors.lightBlue.shade200,
      Colors.lightGreen.shade200,
      Colors.deepPurple.shade200,
    ];
    return palette[(x + y) % palette.length];
  }

  @override
  Widget build(BuildContext context) {
    // Diagonal layout: each row is offset by yIndex * _diagStep horizontally.
    // This demonstrates creative use of the delegate coordinate system.
    final delegate = TwoDimensionalChildBuilderDelegate(
      maxXIndex: _xCount - 1,
      maxYIndex: _yCount - 1,
      builder: (BuildContext ctx, ChildVicinity vicinity) {
        final x = vicinity.xIndex;
        final y = vicinity.yIndex;
        return Container(
          width: _cellW,
          height: _cellH,
          decoration: BoxDecoration(
            color: _cellColor(x, y),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white, width: 1.5),
          ),
          alignment: Alignment.center,
          child: Text(
            'D(x:$x, y:$y)\nshift: ${(y * _diagStep).toInt()}px',
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 10, fontWeight: FontWeight.w600),
          ),
        );
      },
    );

    // Render the diagonal grid using the delegate
    final totalWidth = _xCount * (_cellW + 4) + _yCount * _diagStep;

    return Column(
      children: [
        _InfoBanner(
          cs: cs,
          icon: Icons.deblur,
          text: 'Diagonal layout: each row is offset by (yIndex × ${_diagStep.toInt()}px). '
              'Demonstrates creative use of ChildVicinity-based layout beyond '
              'regular grids. TwoDimensionalChildBuilderDelegate: '
              'maxXIndex=${delegate.maxXIndex}, maxYIndex=${delegate.maxYIndex}.',
        ),
        _DiagonalLegend(cs: cs, diagStep: _diagStep),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: totalWidth,
              child: ListView.builder(
                itemCount: _yCount,
                itemExtent: _cellH + 6,
                itemBuilder: (ctx, row) {
                  final offset = row * _diagStep;
                  return Padding(
                    padding:
                        EdgeInsets.only(left: offset, top: 3, bottom: 3),
                    child: Row(
                      children: List.generate(_xCount, (col) {
                        final v = ChildVicinity(xIndex: col, yIndex: row);
                        return Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 2),
                          child: delegate.builder(ctx, v),
                        );
                      }),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DiagonalLegend extends StatelessWidget {
  const _DiagonalLegend({required this.cs, required this.diagStep});
  final ColorScheme cs;
  final double diagStep;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cs.tertiaryContainer,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          Icon(Icons.info_outline, size: 16, color: cs.onTertiaryContainer),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Each row shifts right by ${diagStep.toInt()}px. '
              'Horizontal scroll reveals cells that start further right.',
              style:
                  TextStyle(fontSize: 12, color: cs.onTertiaryContainer),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 6: Pinned rows/columns demo
// ─────────────────────────────────────────────────────────────────────────────

class _PinnedTab extends StatelessWidget {
  const _PinnedTab({required this.cs});
  final ColorScheme cs;

  static const int _cols = 14;
  static const int _rows = 30;
  static const double _cellW = 88.0;
  static const double _cellH = 44.0;
  static const double _headerW = 72.0;
  static const double _headerH = 48.0;
  static const double _subHeaderH = 40.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _InfoBanner(
          cs: cs,
          icon: Icons.push_pin,
          text: 'Simulates pinnedRowCount: 2 and pinnedColumnCount: 2. '
              'The first two rows and first two columns remain fixed. '
              'In the real TableView API, these are set directly on TableView.builder.',
        ),
        _PinnedLegendBar(cs: cs),
        Expanded(
          child: _PinnedGrid(
            cs: cs,
            cols: _cols,
            rows: _rows,
            cellW: _cellW,
            cellH: _cellH,
            headerW: _headerW,
            headerH: _headerH,
            subHeaderH: _subHeaderH,
          ),
        ),
        _PinnedApiNote(cs: cs),
      ],
    );
  }
}

class _PinnedGrid extends StatelessWidget {
  const _PinnedGrid({
    required this.cs,
    required this.cols,
    required this.rows,
    required this.cellW,
    required this.cellH,
    required this.headerW,
    required this.headerH,
    required this.subHeaderH,
  });

  final ColorScheme cs;
  final int cols;
  final int rows;
  final double cellW;
  final double cellH;
  final double headerW;
  final double headerH;
  final double subHeaderH;

  Widget _headerCell(String text, Color bg, Color fg, double w, double h) {
    return Container(
      width: w,
      height: h,
      color: bg,
      alignment: Alignment.center,
      child: Text(text,
          style: TextStyle(
              color: fg, fontWeight: FontWeight.bold, fontSize: 11)),
    );
  }

  Widget _buildHeaderRows(ScrollController ctrl) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: ctrl,
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          // Row 0 (pinned header row 1)
          Row(
            children: [
              _headerCell('#', cs.primary, cs.onPrimary, headerW, headerH),
              _headerCell('SEC', cs.primary, cs.onPrimary, headerW, headerH),
              for (int col = 2; col < cols; col++)
                _headerCell('Col$col', cs.primary, cs.onPrimary, cellW, headerH),
            ],
          ),
          // Row 1 (pinned header row 2)
          Row(
            children: [
              _headerCell('ID', cs.secondary, cs.onSecondary, headerW, subHeaderH),
              _headerCell('GRP', cs.secondary, cs.onSecondary, headerW, subHeaderH),
              for (int col = 2; col < cols; col++)
                _headerCell('S$col', cs.secondary, cs.onSecondary, cellW, subHeaderH),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDataRow(int row) {
    return SizedBox(
      height: cellH,
      child: Row(
        children: [
          // Pinned column 0
          Container(
            width: headerW,
            height: cellH,
            color: cs.primaryContainer,
            alignment: Alignment.center,
            child: Text('R$row',
                style: TextStyle(
                    color: cs.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                    fontSize: 11)),
          ),
          // Pinned column 1
          Container(
            width: headerW,
            height: cellH,
            color: cs.secondaryContainer,
            alignment: Alignment.center,
            child: Text('G${row % 5}',
                style: TextStyle(
                    color: cs.onSecondaryContainer,
                    fontWeight: FontWeight.bold,
                    fontSize: 11)),
          ),
          // Data cells
          for (int col = 2; col < cols; col++)
            Container(
              width: cellW,
              height: cellH,
              color: row % 2 == 0
                  ? cs.surfaceContainerHighest
                  : cs.surfaceContainerLow,
              alignment: Alignment.center,
              child: Text('$col×$row',
                  style: TextStyle(fontSize: 11, color: cs.onSurface)),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hCtrl = ScrollController();
    final hCtrlHeaders = ScrollController();

    hCtrl.addListener(() {
      if (hCtrl.hasClients && hCtrlHeaders.hasClients) {
        hCtrlHeaders.jumpTo(hCtrl.offset);
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeaderRows(hCtrlHeaders),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: hCtrl,
            child: SizedBox(
              width: headerW * 2 + cellW * (cols - 2),
              child: ListView.builder(
                itemCount: rows,
                itemExtent: cellH,
                itemBuilder: (ctx, i) => _buildDataRow(i + 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PinnedLegendBar extends StatelessWidget {
  const _PinnedLegendBar({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cs.primaryContainer,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Wrap(
        spacing: 16,
        runSpacing: 4,
        children: [
          _LegendItem(color: cs.primary, label: 'Pinned row 1', cs: cs),
          _LegendItem(color: cs.secondary, label: 'Pinned row 2', cs: cs),
          _LegendItem(color: cs.primaryContainer, label: 'Pinned col 1', cs: cs),
          _LegendItem(color: cs.secondaryContainer, label: 'Pinned col 2', cs: cs),
          _LegendItem(color: cs.surfaceContainerHighest, label: 'Data cells', cs: cs),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label, required this.cs});
  final Color color;
  final String label;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade400)),
        ),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 11, color: cs.onSurface)),
      ],
    );
  }
}

class _PinnedApiNote extends StatelessWidget {
  const _PinnedApiNote({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cs.surfaceContainerLow,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('TableView API equivalent:',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: cs.primary)),
          const SizedBox(height: 4),
          _CodeLine('TableView.builder(', cs),
          _CodeLine('  pinnedRowCount: 2,    // keep rows 0–1 fixed', cs),
          _CodeLine('  pinnedColumnCount: 2, // keep cols 0–1 fixed', cs),
          _CodeLine('  // ...', cs),
          _CodeLine(')', cs),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 7: Cell styling variety
// ─────────────────────────────────────────────────────────────────────────────

class _CellStylesTab extends StatelessWidget {
  const _CellStylesTab({required this.cs});
  final ColorScheme cs;

  static const int _cols = 10;
  static const int _rows = 24;
  static const double _cellW = 82.0;
  static const double _cellH = 46.0;

  Color _bg(int x, int y, ColorScheme cs, bool isSelected) {
    if (isSelected) return cs.tertiary;
    if (y == 0) return cs.primary;
    if (x % 4 == 0) return cs.primaryContainer;
    if (y % 2 == 1) return cs.surfaceContainerHighest;
    return cs.surfaceContainerLow;
  }

  Color _fg(int x, int y, ColorScheme cs, bool isSelected) {
    if (isSelected) return cs.onTertiary;
    if (y == 0) return cs.onPrimary;
    if (x % 4 == 0) return cs.onPrimaryContainer;
    return cs.onSurface;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _InfoBanner(
          cs: cs,
          icon: Icons.palette,
          text: 'Cell styling variety: alternating rows, header row (y=0), '
              'accent columns (x%4==0), tap-to-select highlight via '
              'ValueNotifier<ChildVicinity?>.',
        ),
        ValueListenableBuilder<ChildVicinity?>(
          valueListenable: _selectedCell,
          builder: (ctx, selected, _) => Container(
            color: cs.tertiaryContainer,
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Text(
              selected == null
                  ? 'Tap a cell to highlight it'
                  : 'Selected: ChildVicinity(xIndex: ${selected.xIndex}, '
                      'yIndex: ${selected.yIndex})',
              style: TextStyle(
                  color: cs.onTertiaryContainer,
                  fontWeight: FontWeight.w600,
                  fontSize: 13),
            ),
          ),
        ),
        const SizedBox(height: 4),
        _CellStyleLegend(cs: cs),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: _cellW * _cols,
              child: ListView.builder(
                itemCount: _rows,
                itemExtent: _cellH,
                itemBuilder: (ctx, row) {
                  return Row(
                    children: List.generate(_cols, (col) {
                      return _StyledCell(
                        x: col,
                        y: row,
                        w: _cellW,
                        h: _cellH,
                        cs: cs,
                        selectedNotifier: _selectedCell,
                        bg: _bg,
                        fg: _fg,
                      );
                    }),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StyledCell extends StatelessWidget {
  const _StyledCell({
    required this.x,
    required this.y,
    required this.w,
    required this.h,
    required this.cs,
    required this.selectedNotifier,
    required this.bg,
    required this.fg,
  });

  final int x;
  final int y;
  final double w;
  final double h;
  final ColorScheme cs;
  final ValueNotifier<ChildVicinity?> selectedNotifier;
  final Color Function(int, int, ColorScheme, bool) bg;
  final Color Function(int, int, ColorScheme, bool) fg;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ChildVicinity?>(
      valueListenable: selectedNotifier,
      builder: (ctx, selected, _) {
        final isSelected = selected != null &&
            selected.xIndex == x &&
            selected.yIndex == y;
        return GestureDetector(
          onTap: () {
            selectedNotifier.value =
                isSelected ? null : ChildVicinity(xIndex: x, yIndex: y);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            width: w - 1,
            height: h - 1,
            margin: const EdgeInsets.all(0.5),
            color: bg(x, y, cs, isSelected),
            alignment: Alignment.center,
            child: Text(
              y == 0 ? 'H$x' : '($x,$y)',
              style: TextStyle(
                color: fg(x, y, cs, isSelected),
                fontWeight: y == 0 || isSelected
                    ? FontWeight.bold
                    : FontWeight.normal,
                fontSize: isSelected ? 12 : 11,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CellStyleLegend extends StatelessWidget {
  const _CellStyleLegend({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cs.surfaceContainerLow,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Wrap(
        spacing: 12,
        runSpacing: 4,
        children: [
          _LegendItem(color: cs.primary, label: 'Header (y=0)', cs: cs),
          _LegendItem(color: cs.primaryContainer, label: 'Accent col (x%4==0)', cs: cs),
          _LegendItem(color: cs.surfaceContainerHighest, label: 'Odd rows', cs: cs),
          _LegendItem(color: cs.surfaceContainerLow, label: 'Even rows', cs: cs),
          _LegendItem(color: cs.tertiary, label: 'Selected cell', cs: cs),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 8: Scroll position display
// ─────────────────────────────────────────────────────────────────────────────

class _ScrollPosTab extends StatelessWidget {
  const _ScrollPosTab({required this.cs});
  final ColorScheme cs;

  static const int _cols = 16;
  static const int _rows = 40;
  static const double _cellW = 90.0;
  static const double _cellH = 44.0;
  static const double _headerW = 72.0;
  static const double _headerH = 48.0;

  @override
  Widget build(BuildContext context) {
    final hCtrl = ScrollController();
    final vCtrl = ScrollController();

    hCtrl.addListener(() {
      if (hCtrl.hasClients) {
        _hOffset.value = hCtrl.offset;
      }
    });
    vCtrl.addListener(() {
      if (vCtrl.hasClients) {
        _vOffset.value = vCtrl.offset;
      }
    });

    return Column(
      children: [
        _InfoBanner(
          cs: cs,
          icon: Icons.my_location,
          text: 'Two ScrollControllers track horizontal and vertical scroll '
              'offsets independently. ValueNotifiers feed the HUD card '
              'with real-time position data.',
        ),
        ValueListenableBuilder<double>(
          valueListenable: _hOffset,
          builder: (ctx, hOff, _) {
            return ValueListenableBuilder<double>(
              valueListenable: _vOffset,
              builder: (ctx2, vOff, _) {
                return Container(
                  color: cs.primaryContainer,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  child: Row(
                    children: [
                      _ScrollHUDCard(
                        cs: cs,
                        label: 'Horizontal offset',
                        value: hOff,
                        icon: Icons.swap_horiz,
                        color: cs.primary,
                      ),
                      const SizedBox(width: 12),
                      _ScrollHUDCard(
                        cs: cs,
                        label: 'Vertical offset',
                        value: vOff,
                        icon: Icons.swap_vert,
                        color: cs.tertiary,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        Expanded(
          child: SingleChildScrollView(
            controller: hCtrl,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: _headerW + _cellW * (_cols - 1),
              child: ListView.builder(
                controller: vCtrl,
                itemCount: _rows,
                itemExtent: _cellH,
                itemBuilder: (ctx, row) {
                  final isHeader = row == 0;
                  return Row(
                    children: [
                      Container(
                        width: _headerW,
                        height: isHeader ? _headerH : _cellH,
                        color: isHeader
                            ? cs.primary
                            : cs.secondaryContainer,
                        alignment: Alignment.center,
                        child: Text(
                          isHeader ? '#' : 'R$row',
                          style: TextStyle(
                              color: isHeader
                                  ? cs.onPrimary
                                  : cs.onSecondaryContainer,
                              fontWeight: FontWeight.bold,
                              fontSize: 11),
                        ),
                      ),
                      for (int col = 1; col < _cols; col++)
                        Container(
                          width: _cellW,
                          height: _cellH,
                          color: isHeader
                              ? cs.primaryContainer
                              : (row % 2 == 0
                                  ? cs.surfaceContainerHighest
                                  : cs.surfaceContainerLow),
                          alignment: Alignment.center,
                          child: Text(
                            isHeader ? 'Col $col' : '($col,$row)',
                            style: TextStyle(
                                color: isHeader
                                    ? cs.onPrimaryContainer
                                    : cs.onSurface,
                                fontWeight: isHeader
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 11),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        _ScrollApiNote(cs: cs),
      ],
    );
  }
}

class _ScrollHUDCard extends StatelessWidget {
  const _ScrollHUDCard({
    required this.cs,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });
  final ColorScheme cs;
  final String label;
  final double value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withAlpha(100)),
          boxShadow: [
            BoxShadow(
                color: color.withAlpha(30),
                blurRadius: 4,
                offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyle(
                          fontSize: 10,
                          color: cs.onSurface.withAlpha(140))),
                  Text(
                    '${value.toStringAsFixed(1)} px',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: color),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScrollApiNote extends StatelessWidget {
  const _ScrollApiNote({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cs.surfaceContainerLow,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('TableView / TwoDimensionalScrollView API:',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: cs.primary)),
          const SizedBox(height: 4),
          _CodeLine('TableView.builder(', cs),
          _CodeLine(
              '  horizontalDetails: ScrollableDetails.horizontal(controller: hCtrl),',
              cs),
          _CodeLine(
              '  verticalDetails: ScrollableDetails.vertical(controller: vCtrl),',
              cs),
          _CodeLine('  // ...', cs),
          _CodeLine(')', cs),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 9: Comparison
// ─────────────────────────────────────────────────────────────────────────────

class _CompareTab extends StatelessWidget {
  const _CompareTab({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _SectionCard(
          title: 'TableView vs GridView vs DataTable vs ListView',
          child: _ComparisonTable(cs: cs),
        ),
        const SizedBox(height: 16),
        _SectionCard(
          title: 'Architecture: RenderTwoDimensionalViewport',
          child: SizedBox(
            height: 270,
            child: CustomPaint(
              painter: _ArchDiagramPainter(cs: cs),
              child: const SizedBox.expand(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _SectionCard(
          title: 'API Cheat Sheet',
          child: _ApiCheatSheet(cs: cs),
        ),
        const SizedBox(height: 16),
        _SectionCard(
          title: 'Quick Decision Guide',
          child: _QuickDecisionGuide(cs: cs),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Comparison Table (4-column)
// ─────────────────────────────────────────────────────────────────────────────

class _ComparisonTable extends StatelessWidget {
  const _ComparisonTable({required this.cs});
  final ColorScheme cs;

  static const List<_CompareRow> _rows = [
    _CompareRow(
      widget: 'TableView.builder',
      scrollAxes: 'Both (H + V)',
      pinned: 'Yes',
      cellAddress: 'ChildVicinity\n(xIndex, yIndex)',
      bestFor: 'Spreadsheets, data grids,\nlarge 2D datasets',
    ),
    _CompareRow(
      widget: 'GridView',
      scrollAxes: 'Single axis',
      pinned: 'No',
      cellAddress: 'Linear index',
      bestFor: 'Image galleries,\nequal-size cards',
    ),
    _CompareRow(
      widget: 'DataTable',
      scrollAxes: 'Vertical only',
      pinned: 'No',
      cellAddress: 'DataRow / DataCell',
      bestFor: 'Small static tables\n< 50 rows',
    ),
    _CompareRow(
      widget: 'ListView + crossAxisCount',
      scrollAxes: 'Single axis',
      pinned: 'No',
      cellAddress: 'Linear index',
      bestFor: 'Simple lists,\none-axis scroll',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const headers = ['Widget', 'Scroll Axes', 'Pinned', 'Cell Address', 'Best For'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        border: TableBorder.all(color: cs.outline.withAlpha(80), width: 1),
        defaultColumnWidth: const IntrinsicColumnWidth(),
        children: [
          TableRow(
            decoration: BoxDecoration(color: cs.primaryContainer),
            children: headers
                .map((h) => _TCell(text: h, isHeader: true, cs: cs))
                .toList(),
          ),
          ..._rows.map(
            (r) => TableRow(
              children: [
                _TCell(text: r.widget, cs: cs),
                _TCell(text: r.scrollAxes, cs: cs),
                _TCell(text: r.pinned, cs: cs),
                _TCell(text: r.cellAddress, cs: cs),
                _TCell(text: r.bestFor, cs: cs),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CompareRow {
  const _CompareRow({
    required this.widget,
    required this.scrollAxes,
    required this.pinned,
    required this.cellAddress,
    required this.bestFor,
  });
  final String widget;
  final String scrollAxes;
  final String pinned;
  final String cellAddress;
  final String bestFor;
}

class _TCell extends StatelessWidget {
  const _TCell({required this.text, required this.cs, this.isHeader = false});
  final String text;
  final ColorScheme cs;
  final bool isHeader;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color:
              isHeader ? cs.onPrimaryContainer : cs.onSurface,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Architecture CustomPainter Diagram
// ─────────────────────────────────────────────────────────────────────────────

class _ArchitecturePainterCard extends StatelessWidget {
  const _ArchitecturePainterCard({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Architecture Diagram',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: cs.onSurface),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 260,
          child: CustomPaint(
            painter: _ArchDiagramPainter(cs: cs),
            child: const SizedBox.expand(),
          ),
        ),
      ],
    );
  }
}

class _ArchDiagramPainter extends CustomPainter {
  const _ArchDiagramPainter({required this.cs});
  final ColorScheme cs;

  @override
  void paint(Canvas canvas, Size size) {
    final nodes = [
      _ArchNode(
        label: 'TwoDimensionalScrollView\n(Widget, abstract)',
        x: size.width / 2,
        y: 24,
        w: 220,
        h: 38,
        color: cs.primaryContainer,
        textColor: cs.onPrimaryContainer,
      ),
      _ArchNode(
        label: 'TwoDimensionalScrollable\n(StatefulWidget)',
        x: size.width / 2,
        y: 84,
        w: 220,
        h: 38,
        color: cs.secondaryContainer,
        textColor: cs.onSecondaryContainer,
      ),
      _ArchNode(
        label: 'TwoDimensionalViewport\n(RenderObjectWidget, abstract)',
        x: size.width / 2,
        y: 148,
        w: 240,
        h: 38,
        color: cs.tertiaryContainer,
        textColor: cs.onTertiaryContainer,
      ),
      _ArchNode(
        label: 'RenderTwoDimensionalViewport\n(RenderObject, abstract)',
        x: size.width / 2,
        y: 212,
        w: 250,
        h: 38,
        color: cs.errorContainer,
        textColor: cs.onErrorContainer,
      ),
      _ArchNode(
        label: 'ChildVicinity\n(xIndex, yIndex)',
        x: size.width * 0.15,
        y: 212,
        w: 140,
        h: 38,
        color: cs.primaryContainer,
        textColor: cs.onPrimaryContainer,
      ),
      _ArchNode(
        label: 'TwoDimensionalChildBuilderDelegate',
        x: size.width * 0.85,
        y: 212,
        w: 180,
        h: 38,
        color: cs.secondaryContainer,
        textColor: cs.onSecondaryContainer,
      ),
    ];

    final arrowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = cs.outline;

    void drawArrow(Offset from, Offset to) {
      canvas.drawLine(from, to, arrowPaint);
      final dx = to.dx - from.dx;
      final dy = to.dy - from.dy;
      final len = (dx * dx + dy * dy) != 0
          ? (dx * dx + dy * dy)
          : 1.0;
      final nx = dx / len * 8;
      final ny = dy / len * 8;
      final path = Path()
        ..moveTo(to.dx - nx - ny, to.dy - ny + nx)
        ..lineTo(to.dx, to.dy)
        ..lineTo(to.dx - nx + ny, to.dy - ny - nx);
      canvas.drawPath(path, arrowPaint);
    }

    // Vertical chain
    for (int i = 0; i < 3; i++) {
      final from = nodes[i];
      final to = nodes[i + 1];
      drawArrow(Offset(from.x, from.y + from.h / 2),
          Offset(to.x, to.y - to.h / 2));
    }
    // Side connections to node 3 (RenderTwoDimensionalViewport)
    drawArrow(Offset(nodes[3].x - nodes[3].w / 2, nodes[3].y),
        Offset(nodes[4].x + nodes[4].w / 2, nodes[4].y));
    drawArrow(Offset(nodes[3].x + nodes[3].w / 2, nodes[3].y),
        Offset(nodes[5].x - nodes[5].w / 2, nodes[5].y));

    // Draw boxes
    final boxPaint = Paint()..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    for (final node in nodes) {
      final rect = Rect.fromCenter(
          center: Offset(node.x, node.y), width: node.w, height: node.h);
      boxPaint.color = node.color;
      borderPaint.color = node.textColor.withAlpha(120);
      canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(6)), boxPaint);
      canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(6)),
          borderPaint);
      final tp = TextPainter(
        text: TextSpan(
          text: node.label,
          style: TextStyle(
              color: node.textColor,
              fontSize: 9,
              fontWeight: FontWeight.w600),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(maxWidth: node.w - 8);
      tp.paint(canvas,
          Offset(node.x - tp.width / 2, node.y - tp.height / 2));
    }
  }

  @override
  bool shouldRepaint(_ArchDiagramPainter old) => false;
}

class _ArchNode {
  const _ArchNode({
    required this.label,
    required this.x,
    required this.y,
    required this.w,
    required this.h,
    required this.color,
    required this.textColor,
  });
  final String label;
  final double x;
  final double y;
  final double w;
  final double h;
  final Color color;
  final Color textColor;
}

// ─────────────────────────────────────────────────────────────────────────────
// API Cheat Sheet
// ─────────────────────────────────────────────────────────────────────────────

class _ApiCheatSheet extends StatelessWidget {
  const _ApiCheatSheet({required this.cs});
  final ColorScheme cs;

  static const List<_ApiEntry> _entries = [
    _ApiEntry(
      name: 'RenderTwoDimensionalViewport',
      description:
          'Abstract render object powering 2D scrollable views. Manages '
          'child layout, culling via cache extent, and ChildVicinity '
          'addressing. Subclassed by concrete viewport implementations.',
      properties:
          'cacheExtent, mainAxis, verticalOffset, horizontalOffset, delegate',
    ),
    _ApiEntry(
      name: 'TwoDimensionalScrollView',
      description:
          'Abstract base widget for bidirectional scrollable views. '
          'Accepts a TwoDimensionalChildDelegate. Must be subclassed '
          '(e.g., by your own or the two_dimensional_scrollables package).',
      properties:
          'delegate, mainAxis, verticalDetails, horizontalDetails, diagonalDragBehavior',
    ),
    _ApiEntry(
      name: 'TwoDimensionalScrollable',
      description:
          'Concrete StatefulWidget that manages two Scrollable instances '
          '(one per axis). Created internally by TwoDimensionalScrollView. '
          'Can be used directly for custom 2D scroll setups.',
      properties:
          'horizontalAxisDirection, verticalAxisDirection, viewportBuilder, '
          'diagonalDragBehavior, dragStartBehavior',
    ),
    _ApiEntry(
      name: 'TwoDimensionalChildBuilderDelegate',
      description:
          'Builder-based delegate that creates children via '
          'builder(BuildContext, ChildVicinity). Bounded by maxXIndex '
          'and maxYIndex. Supports repaint boundaries and keep-alives.',
      properties:
          'builder, maxXIndex, maxYIndex, addRepaintBoundaries, addAutomaticKeepAlives',
    ),
    _ApiEntry(
      name: 'ChildVicinity',
      description:
          'Immutable 2-D address (xIndex, yIndex) identifying each child '
          'in a TwoDimensionalScrollView. Implements Comparable. Two '
          'vicinities with the same indices are equal.',
      properties: 'xIndex, yIndex',
    ),
    _ApiEntry(
      name: 'TwoDimensionalViewport',
      description:
          'Abstract RenderObjectWidget that creates and manages a '
          'RenderTwoDimensionalViewport. Subclass this and its render '
          'object to build custom 2D layout engines.',
      properties: 'verticalOffset, horizontalOffset, delegate, mainAxis, cacheExtent',
    ),
    _ApiEntry(
      name: 'DiagonalDragBehavior',
      description:
          'Enum controlling how diagonal drag gestures are resolved. '
          'Useful for preventing unintended axis switching when '
          'scrolling in one direction.',
      properties: 'none, weightedContinuous, weightedEvent, free',
    ),
    _ApiEntry(
      name: 'ScrollableDetails',
      description:
          'Carries a ScrollController and direction to the horizontal '
          'or vertical axis of a TwoDimensionalScrollView.',
      properties: 'controller, direction, decorationClipBehavior, physics',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _entries.map((e) => _ApiCard(entry: e, cs: cs)).toList(),
    );
  }
}

class _ApiEntry {
  const _ApiEntry({
    required this.name,
    required this.description,
    required this.properties,
  });
  final String name;
  final String description;
  final String properties;
}

class _ApiCard extends StatelessWidget {
  const _ApiCard({required this.entry, required this.cs});
  final _ApiEntry entry;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cs.outline.withAlpha(60)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Text(
              entry.name,
              style: TextStyle(
                color: cs.onPrimaryContainer,
                fontWeight: FontWeight.bold,
                fontSize: 13,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.description,
                    style: TextStyle(fontSize: 12, color: cs.onSurface)),
                const SizedBox(height: 6),
                Text(
                  'Key properties: ${entry.properties}',
                  style: TextStyle(
                    fontSize: 11,
                    color: cs.onSurface.withAlpha(160),
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
}

// ─────────────────────────────────────────────────────────────────────────────
// Quick Decision Guide
// ─────────────────────────────────────────────────────────────────────────────

class _QuickDecisionGuide extends StatelessWidget {
  const _QuickDecisionGuide({required this.cs});
  final ColorScheme cs;

  static const List<_DecisionEntry> _entries = [
    _DecisionEntry(
      condition: 'Need to scroll both horizontally AND vertically?',
      recommendation:
          'Use the two_dimensional_scrollables package TableView.builder, '
          'or TwoDimensionalScrollable with a custom viewport.',
    ),
    _DecisionEntry(
      condition: 'Fixed-size equal cells in a grid, single-axis scroll?',
      recommendation: 'Use GridView (simpler, less overhead).',
    ),
    _DecisionEntry(
      condition: 'Need pinned header rows and/or columns?',
      recommendation:
          'Use TableView.builder with pinnedRowCount / pinnedColumnCount.',
    ),
    _DecisionEntry(
      condition: 'Custom 2D layout that is not a regular grid?',
      recommendation:
          'Subclass TwoDimensionalScrollView + RenderTwoDimensionalViewport '
          'with a custom delegate.',
    ),
    _DecisionEntry(
      condition: 'Small static table, < 50 rows, no horizontal scroll?',
      recommendation: 'Use DataTable (no laziness needed, less boilerplate).',
    ),
    _DecisionEntry(
      condition: 'Very large dataset scrolling in one direction only?',
      recommendation:
          'Use ListView.builder or SliverList — more battle-tested.',
    ),
    _DecisionEntry(
      condition: 'Cells need to span multiple rows or columns?',
      recommendation:
          'Use TableViewCell with rowMergeCount / columnMergeCount.',
    ),
    _DecisionEntry(
      condition: 'Need to identify which cell is active or selected?',
      recommendation:
          'Use ChildVicinity for cell identity; pair with ValueNotifier<ChildVicinity?> '
          'for stateless observation.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _entries.indexed.map((pair) {
        final (i, e) = pair;
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: i % 2 == 0
                ? cs.surfaceContainerLow
                : cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cs.outline.withAlpha(50)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.help_outline, size: 16, color: cs.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e.condition,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: cs.onSurface),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.arrow_forward,
                            size: 13, color: cs.secondary),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            e.recommendation,
                            style: TextStyle(
                                fontSize: 12,
                                color: cs.onSurface.withAlpha(180)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _DecisionEntry {
  const _DecisionEntry({
    required this.condition,
    required this.recommendation,
  });
  final String condition;
  final String recommendation;
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared utility widgets
// ─────────────────────────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: cs.primary),
              ),
              const SizedBox(height: 12),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoBanner extends StatelessWidget {
  const _InfoBanner({
    required this.cs,
    required this.icon,
    required this.text,
  });
  final ColorScheme cs;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cs.surfaceContainerHighest,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: cs.primary, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text,
                style: TextStyle(fontSize: 12, color: cs.onSurface)),
          ),
        ],
      ),
    );
  }
}

Text _bodyText(String text) => Text(
      text,
      style: const TextStyle(fontSize: 13, height: 1.5),
    );
