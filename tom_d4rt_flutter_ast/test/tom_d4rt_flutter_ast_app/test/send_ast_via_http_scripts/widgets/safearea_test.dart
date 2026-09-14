// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: hand-authored deep visual demo for SafeArea, SliverSafeArea
// and the MediaQuery padding/inset family
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

Widget _sectionTitle(String title, String subtitle) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF1B3A57), Color(0xFF2E5F89)],
      ),
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x66000000),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          subtitle,
          style: TextStyle(
            color: Color(0xFFCCE0F2),
            fontSize: 12.5,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget _explainerCard(String body, {Color? tint}) {
  final Color accent = tint ?? Color(0xFF4A90E2);
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F8FB),
      border: Border(left: BorderSide(color: accent, width: 4.0)),
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(8.0),
        bottomRight: Radius.circular(8.0),
      ),
    ),
    child: Text(
      body,
      style: TextStyle(
        color: Color(0xFF1F2A36),
        fontSize: 13.0,
        height: 1.35,
      ),
    ),
  );
}

Widget _legendDot(Color color, String label) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12.0,
          height: 12.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3.0),
            border: Border.all(color: Color(0xFF333333), width: 0.6),
          ),
        ),
        SizedBox(width: 5.0),
        Text(
          label,
          style: TextStyle(fontSize: 11.5, color: Color(0xFF333333)),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 1: SafeArea edge-flag matrix (4-edge on/off table)
// ---------------------------------------------------------------------------

Widget _buildEdgeFlagCell({
  required String label,
  required bool left,
  required bool top,
  required bool right,
  required bool bottom,
  required Color color,
}) {
  // Simulate device padding via nested MediaQuery so SafeArea has insets to
  // consume. Without this, SafeArea is a no-op in many test environments.
  final MediaQueryData simulated = MediaQueryData(
    padding: EdgeInsets.fromLTRB(18.0, 28.0, 18.0, 22.0),
  );
  return Container(
    margin: EdgeInsets.all(6.0),
    width: 150.0,
    height: 140.0,
    decoration: BoxDecoration(
      color: Color(0xFFEDEDED),
      border: Border.all(color: Color(0xFF888888), width: 1.0),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(6.0),
      child: MediaQuery(
        data: simulated,
        child: SafeArea(
          left: left,
          top: top,
          right: right,
          bottom: bottom,
          child: Container(
            color: color,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _buildEdgeFlagMatrix() {
  // Sixteen combinations would overflow; we showcase 8 representative ones.
  final List<Widget> cells = [];
  cells.add(_buildEdgeFlagCell(
    label: 'ALL on\n(default)',
    left: true,
    top: true,
    right: true,
    bottom: true,
    color: Color(0xFF2E7D32),
  ));
  cells.add(_buildEdgeFlagCell(
    label: 'top: false',
    left: true,
    top: false,
    right: true,
    bottom: true,
    color: Color(0xFF1976D2),
  ));
  cells.add(_buildEdgeFlagCell(
    label: 'bottom: false',
    left: true,
    top: true,
    right: true,
    bottom: false,
    color: Color(0xFFE65100),
  ));
  cells.add(_buildEdgeFlagCell(
    label: 'left: false',
    left: false,
    top: true,
    right: true,
    bottom: true,
    color: Color(0xFF6A1B9A),
  ));
  cells.add(_buildEdgeFlagCell(
    label: 'right: false',
    left: true,
    top: true,
    right: false,
    bottom: true,
    color: Color(0xFFAD1457),
  ));
  cells.add(_buildEdgeFlagCell(
    label: 'horizontal\nonly',
    left: true,
    top: false,
    right: true,
    bottom: false,
    color: Color(0xFF00838F),
  ));
  cells.add(_buildEdgeFlagCell(
    label: 'vertical\nonly',
    left: false,
    top: true,
    right: false,
    bottom: true,
    color: Color(0xFF5D4037),
  ));
  cells.add(_buildEdgeFlagCell(
    label: 'ALL off\n(no-op)',
    left: false,
    top: false,
    right: false,
    bottom: false,
    color: Color(0xFF424242),
  ));

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      border: Border.all(color: Color(0xFFCCCCCC)),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Wrap(
      alignment: WrapAlignment.center,
      children: cells,
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 2: minimum padding gallery
// ---------------------------------------------------------------------------

Widget _buildMinimumPaddingTile({
  required String label,
  required EdgeInsets minimum,
  required EdgeInsets simulatedPadding,
  required Color barColor,
}) {
  return Container(
    margin: EdgeInsets.all(6.0),
    width: 200.0,
    height: 170.0,
    decoration: BoxDecoration(
      color: Color(0xFFF0F0F0),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(0xFFB0B0B0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          color: Color(0xFF263238),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
            child: MediaQuery(
              data: MediaQueryData(padding: simulatedPadding),
              child: SafeArea(
                minimum: minimum,
                child: Container(
                  color: barColor,
                  alignment: Alignment.center,
                  child: Text(
                    'min=${minimum.left.toInt()},'
                    '${minimum.top.toInt()},'
                    '${minimum.right.toInt()},'
                    '${minimum.bottom.toInt()}\n'
                    'pad=${simulatedPadding.top.toInt()}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.0,
                      height: 1.3,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildMinimumPaddingGallery() {
  final List<Widget> tiles = [];
  tiles.add(_buildMinimumPaddingTile(
    label: 'minimum=zero, big sim pad',
    minimum: EdgeInsets.zero,
    simulatedPadding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 30.0),
    barColor: Color(0xFF388E3C),
  ));
  tiles.add(_buildMinimumPaddingTile(
    label: 'minimum=24 all, zero sim',
    minimum: EdgeInsets.all(24.0),
    simulatedPadding: EdgeInsets.zero,
    barColor: Color(0xFF1565C0),
  ));
  tiles.add(_buildMinimumPaddingTile(
    label: 'minimum>sim => min wins',
    minimum: EdgeInsets.all(60.0),
    simulatedPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
    barColor: Color(0xFFEF6C00),
  ));
  tiles.add(_buildMinimumPaddingTile(
    label: 'minimum<sim => sim wins',
    minimum: EdgeInsets.all(4.0),
    simulatedPadding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 30.0),
    barColor: Color(0xFF6A1B9A),
  ));
  tiles.add(_buildMinimumPaddingTile(
    label: 'asymmetric minimum',
    minimum: EdgeInsets.fromLTRB(2.0, 32.0, 2.0, 12.0),
    simulatedPadding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
    barColor: Color(0xFFC2185B),
  ));
  tiles.add(_buildMinimumPaddingTile(
    label: 'minimum only top',
    minimum: EdgeInsets.only(top: 48.0),
    simulatedPadding: EdgeInsets.zero,
    barColor: Color(0xFF00695C),
  ));
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0),
    padding: EdgeInsets.all(6.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      border: Border.all(color: Color(0xFFDDDDDD)),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Wrap(alignment: WrapAlignment.center, children: tiles),
  );
}

// ---------------------------------------------------------------------------
// Section 3: SliverSafeArea inside CustomScrollView
// ---------------------------------------------------------------------------

Widget _sliverEntry(int i, Color color) {
  return Container(
    height: 56.0,
    margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 2.0,
          offset: Offset(0.0, 1.0),
        ),
      ],
    ),
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.symmetric(horizontal: 14.0),
    child: Text(
      'Sliver child #$i  (item inside SliverSafeArea)',
      style: TextStyle(
        color: Colors.white,
        fontSize: 13.0,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget _buildSliverSafeAreaSection() {
  final List<Color> palette = [
    Color(0xFF1E88E5),
    Color(0xFF43A047),
    Color(0xFFFB8C00),
    Color(0xFF8E24AA),
    Color(0xFFD81B60),
    Color(0xFF00838F),
    Color(0xFF6D4C41),
    Color(0xFF3949AB),
  ];
  final List<Widget> rows = [];
  for (int i = 0; i < 14; i = i + 1) {
    rows.add(_sliverEntry(i + 1, palette[i % palette.length]));
  }

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0),
    height: 320.0,
    decoration: BoxDecoration(
      color: Color(0xFFECEFF1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFB0BEC5), width: 1.0),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: MediaQuery(
        data: MediaQueryData(
          padding: EdgeInsets.fromLTRB(12.0, 30.0, 12.0, 24.0),
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                color: Color(0xFF263238),
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 14.0,
                ),
                child: Text(
                  'CustomScrollView header (outside SliverSafeArea)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SliverSafeArea(
              left: true,
              top: true,
              right: true,
              bottom: true,
              minimum: EdgeInsets.symmetric(horizontal: 4.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(rows),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Color(0xFF37474F),
                padding: EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 14.0,
                ),
                child: Text(
                  'Footer sliver — also outside SliverSafeArea',
                  style: TextStyle(color: Colors.white, fontSize: 12.5),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 4: MediaQuery override + nested SafeArea recipe
// ---------------------------------------------------------------------------

Widget _nestedRecipeStep(String title, String body, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
    decoration: BoxDecoration(
      color: color.withOpacity(0.10),
      border: Border(left: BorderSide(color: color, width: 3.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          body,
          style: TextStyle(fontSize: 11.5, color: Color(0xFF263238)),
        ),
      ],
    ),
  );
}

Widget _buildNestedSafeAreaRecipe() {
  // Outer SafeArea consumes top padding. The inner SafeArea is wrapped in a
  // MediaQuery.removePadding(removeTop:true) so it cannot double-consume.
  // Use Builder to obtain a real BuildContext under the outer MediaQuery —
  // MediaQuery.removePadding calls MediaQuery.of(context) internally, so a
  // synthetic "null" context cannot satisfy the call.
  final Widget inner = Builder(
    builder: (BuildContext ctx) => MediaQuery.removePadding(
      context: ctx,
      removeTop: true,
      child: SafeArea(
        child: Container(
          height: 70.0,
          color: Color(0xFF5C6BC0),
          alignment: Alignment.center,
          child: Text(
            'inner SafeArea (top already removed)',
            style: TextStyle(color: Colors.white, fontSize: 12.0),
          ),
        ),
      ),
    ),
  );

  final Widget outerStack = MediaQuery(
    data: MediaQueryData(
      padding: EdgeInsets.fromLTRB(14.0, 36.0, 14.0, 22.0),
    ),
    child: SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 70.0,
            color: Color(0xFF26A69A),
            alignment: Alignment.center,
            child: Text(
              'outer SafeArea (consumes top)',
              style: TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          ),
          SizedBox(height: 6.0),
          inner,
        ],
      ),
    ),
  );

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFDE7),
      border: Border.all(color: Color(0xFFFFCA28)),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _nestedRecipeStep(
          '1. Outer MediaQuery',
          'Simulates a device with top=36, bottom=22, sides=14.',
          Color(0xFF00897B),
        ),
        _nestedRecipeStep(
          '2. Outer SafeArea',
          'Consumes the 36px top padding, exposing zero remaining top.',
          Color(0xFF1E88E5),
        ),
        _nestedRecipeStep(
          '3. MediaQuery.removePadding(removeTop: true)',
          'Strips top from MediaQueryData before the inner SafeArea sees it.',
          Color(0xFFFB8C00),
        ),
        _nestedRecipeStep(
          '4. Inner SafeArea',
          'No top to consume; behaves like an identity wrapper here.',
          Color(0xFF8E24AA),
        ),
        SizedBox(height: 10.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(6.0),
          child: outerStack,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 5: padding vs viewPadding vs viewInsets — CustomPaint diagram
// ---------------------------------------------------------------------------

class _InsetDiagramPainter extends CustomPainter {
  _InsetDiagramPainter({
    required this.padding,
    required this.viewPadding,
    required this.viewInsets,
  });

  final EdgeInsets padding;
  final EdgeInsets viewPadding;
  final EdgeInsets viewInsets;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint screen = Paint()..color = Color(0xFFCFD8DC);
    canvas.drawRect(Offset.zero & size, screen);

    // viewPadding band (outermost) — slate
    final Paint vpPaint = Paint()..color = Color(0xFF455A64);
    if (viewPadding.top > 0.0) {
      canvas.drawRect(
        Rect.fromLTWH(0.0, 0.0, size.width, viewPadding.top),
        vpPaint,
      );
    }
    if (viewPadding.bottom > 0.0) {
      canvas.drawRect(
        Rect.fromLTWH(
          0.0,
          size.height - viewPadding.bottom,
          size.width,
          viewPadding.bottom,
        ),
        vpPaint,
      );
    }
    if (viewPadding.left > 0.0) {
      canvas.drawRect(
        Rect.fromLTWH(0.0, 0.0, viewPadding.left, size.height),
        vpPaint,
      );
    }
    if (viewPadding.right > 0.0) {
      canvas.drawRect(
        Rect.fromLTWH(
          size.width - viewPadding.right,
          0.0,
          viewPadding.right,
          size.height,
        ),
        vpPaint,
      );
    }

    // padding band — green (subset of viewPadding visible above keyboard)
    final Paint pPaint = Paint()..color = Color(0xFF66BB6A);
    if (padding.top > 0.0) {
      canvas.drawRect(
        Rect.fromLTWH(0.0, 0.0, size.width, padding.top),
        pPaint,
      );
    }
    if (padding.bottom > 0.0) {
      canvas.drawRect(
        Rect.fromLTWH(
          0.0,
          size.height - viewInsets.bottom - padding.bottom,
          size.width,
          padding.bottom,
        ),
        pPaint,
      );
    }

    // viewInsets band — red (e.g., keyboard)
    final Paint viPaint = Paint()..color = Color(0xFFEF5350);
    if (viewInsets.bottom > 0.0) {
      canvas.drawRect(
        Rect.fromLTWH(
          0.0,
          size.height - viewInsets.bottom,
          size.width,
          viewInsets.bottom,
        ),
        viPaint,
      );
    }

    // Content rectangle — white
    final double left = viewPadding.left;
    final double top = padding.top;
    final double right = size.width - viewPadding.right;
    final double bottom = size.height - viewInsets.bottom - padding.bottom;
    final Paint contentPaint = Paint()..color = Color(0xFFFFFDE7);
    if (right > left && bottom > top) {
      canvas.drawRect(Rect.fromLTRB(left, top, right, bottom), contentPaint);
    }

    // Border outline
    final Paint border = Paint()
      ..color = Color(0xFF212121)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawRect(Offset.zero & size, border);
  }

  @override
  bool shouldRepaint(_InsetDiagramPainter oldDelegate) {
    return oldDelegate.padding != padding ||
        oldDelegate.viewPadding != viewPadding ||
        oldDelegate.viewInsets != viewInsets;
  }
}

Widget _diagramTile({
  required String title,
  required EdgeInsets padding,
  required EdgeInsets viewPadding,
  required EdgeInsets viewInsets,
}) {
  return Container(
    margin: EdgeInsets.all(6.0),
    width: 200.0,
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(0xFFCCCCCC)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
          color: Color(0xFF1F2A36),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          width: 200.0,
          height: 150.0,
          child: CustomPaint(
            painter: _InsetDiagramPainter(
              padding: padding,
              viewPadding: viewPadding,
              viewInsets: viewInsets,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          color: Color(0xFFF5F5F5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'padding.bottom=${padding.bottom.toInt()}',
                style: TextStyle(fontSize: 10.5),
              ),
              Text(
                'viewPadding.bottom=${viewPadding.bottom.toInt()}',
                style: TextStyle(fontSize: 10.5),
              ),
              Text(
                'viewInsets.bottom=${viewInsets.bottom.toInt()}',
                style: TextStyle(fontSize: 10.5),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildInsetDiagramSection() {
  // Three scenarios:
  //  (a) keyboard hidden — padding == viewPadding, viewInsets zero
  //  (b) keyboard visible — viewInsets.bottom > 0, padding.bottom collapses
  //  (c) full-screen overlay — viewPadding zero everywhere
  final List<Widget> tiles = [];
  tiles.add(_diagramTile(
    title: '(a) keyboard hidden',
    padding: EdgeInsets.fromLTRB(8.0, 24.0, 8.0, 16.0),
    viewPadding: EdgeInsets.fromLTRB(8.0, 24.0, 8.0, 16.0),
    viewInsets: EdgeInsets.zero,
  ));
  tiles.add(_diagramTile(
    title: '(b) keyboard up',
    padding: EdgeInsets.fromLTRB(8.0, 24.0, 8.0, 0.0),
    viewPadding: EdgeInsets.fromLTRB(8.0, 24.0, 8.0, 16.0),
    viewInsets: EdgeInsets.only(bottom: 38.0),
  ));
  tiles.add(_diagramTile(
    title: '(c) fullscreen',
    padding: EdgeInsets.zero,
    viewPadding: EdgeInsets.zero,
    viewInsets: EdgeInsets.zero,
  ));

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Color(0xFFEEEEEE),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(0xFFBDBDBD)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
          child: Wrap(
            children: [
              _legendDot(Color(0xFF455A64), 'viewPadding'),
              _legendDot(Color(0xFF66BB6A), 'padding'),
              _legendDot(Color(0xFFEF5350), 'viewInsets'),
              _legendDot(Color(0xFFFFFDE7), 'content'),
            ],
          ),
        ),
        Wrap(alignment: WrapAlignment.center, children: tiles),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 6: maintainBottomViewPadding explainer
// ---------------------------------------------------------------------------

Widget _maintainTile({
  required String label,
  required bool maintain,
}) {
  // Simulate a viewPadding.bottom of 24 (e.g., home indicator) with the
  // keyboard up so viewInsets.bottom=30 and padding.bottom collapses to zero.
  final MediaQueryData simulated = MediaQueryData(
    padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),
    viewPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 24.0),
    viewInsets: EdgeInsets.only(bottom: 30.0),
  );

  return Container(
    margin: EdgeInsets.all(6.0),
    width: 220.0,
    height: 180.0,
    decoration: BoxDecoration(
      color: Color(0xFFF7F7F7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(0xFFAAAAAA)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
          color: maintain ? Color(0xFF2E7D32) : Color(0xFFC62828),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
            child: MediaQuery(
              data: simulated,
              child: SafeArea(
                maintainBottomViewPadding: maintain,
                child: Container(
                  color: Color(0xFF1E88E5),
                  alignment: Alignment.center,
                  child: Text(
                    maintain
                        ? 'Bottom inset kept (=24)\nfor swipe-up gesture'
                        : 'Bottom inset collapsed (=0)\nbecause keyboard up',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.5,
                      height: 1.3,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildMaintainBottomViewPaddingSection() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(0xFFFFB300)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
          child: Text(
            'maintainBottomViewPadding controls whether SafeArea continues to '
            'reserve bottom viewPadding (e.g., the home-indicator strip on '
            'iOS) even when viewInsets.bottom (the soft keyboard) is non-zero.',
            style: TextStyle(fontSize: 12.0, color: Color(0xFF6D4C00)),
          ),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            _maintainTile(label: 'maintainBottomViewPadding: true', maintain: true),
            _maintainTile(label: 'maintainBottomViewPadding: false', maintain: false),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 7: EdgeInsets vs EdgeInsetsDirectional vs Padding
// ---------------------------------------------------------------------------

Widget _edgeInsetsRow({
  required String label,
  required EdgeInsetsGeometry insets,
  required Color color,
  required TextDirection direction,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
    decoration: BoxDecoration(
      color: Color(0xFFEFEBE9),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: Color(0xFFBCAAA4)),
    ),
    child: Directionality(
      textDirection: direction,
      child: Padding(
        padding: insets,
        child: Container(
          height: 36.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4.0),
          ),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _buildEdgeInsetsSection() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(0xFFCCCCCC)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _edgeInsetsRow(
          label: 'EdgeInsets.all(8)',
          insets: EdgeInsets.all(8.0),
          color: Color(0xFF1E88E5),
          direction: TextDirection.ltr,
        ),
        _edgeInsetsRow(
          label: 'EdgeInsets.symmetric(h:20, v:4)',
          insets: EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
          color: Color(0xFF43A047),
          direction: TextDirection.ltr,
        ),
        _edgeInsetsRow(
          label: 'EdgeInsets.fromLTRB(2,8,32,8)',
          insets: EdgeInsets.fromLTRB(2.0, 8.0, 32.0, 8.0),
          color: Color(0xFFE65100),
          direction: TextDirection.ltr,
        ),
        _edgeInsetsRow(
          label: 'EdgeInsets.only(left:30)',
          insets: EdgeInsets.only(left: 30.0),
          color: Color(0xFF6A1B9A),
          direction: TextDirection.ltr,
        ),
        _edgeInsetsRow(
          label: 'EdgeInsetsDirectional.only(start:30) LTR',
          insets: EdgeInsetsDirectional.only(start: 30.0),
          color: Color(0xFF00838F),
          direction: TextDirection.ltr,
        ),
        _edgeInsetsRow(
          label: 'EdgeInsetsDirectional.only(start:30) RTL',
          insets: EdgeInsetsDirectional.only(start: 30.0),
          color: Color(0xFF00838F),
          direction: TextDirection.rtl,
        ),
        _edgeInsetsRow(
          label: 'EdgeInsetsDirectional.fromSTEB(4,6,28,6) LTR',
          insets: EdgeInsetsDirectional.fromSTEB(4.0, 6.0, 28.0, 6.0),
          color: Color(0xFFAD1457),
          direction: TextDirection.ltr,
        ),
        _edgeInsetsRow(
          label: 'EdgeInsetsDirectional.fromSTEB(4,6,28,6) RTL',
          insets: EdgeInsetsDirectional.fromSTEB(4.0, 6.0, 28.0, 6.0),
          color: Color(0xFFAD1457),
          direction: TextDirection.rtl,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 8: MediaQuery.removePadding / removeViewPadding / removeViewInsets
// ---------------------------------------------------------------------------

Widget _removerTile({
  required String label,
  required Widget child,
  required Color stripe,
}) {
  return Container(
    margin: EdgeInsets.all(6.0),
    width: 230.0,
    height: 150.0,
    decoration: BoxDecoration(
      color: Color(0xFFF1F8E9),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(0xFFAED581)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          color: stripe,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(child: child),
      ],
    ),
  );
}

Widget _buildRemovePaddingSection() {
  final MediaQueryData base = MediaQueryData(
    padding: EdgeInsets.fromLTRB(14.0, 30.0, 14.0, 20.0),
    viewPadding: EdgeInsets.fromLTRB(14.0, 30.0, 14.0, 20.0),
  );

  Widget interior(String tag) {
    return Container(
      color: Color(0xFF42A5F5),
      alignment: Alignment.center,
      child: Text(
        tag,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 11.5),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(0xFFCCCCCC)),
    ),
    child: Wrap(
      alignment: WrapAlignment.center,
      children: [
        _removerTile(
          label: 'base MediaQuery',
          stripe: Color(0xFF424242),
          child: MediaQuery(
            data: base,
            child: SafeArea(child: interior('SafeArea consumes\nall four sides')),
          ),
        ),
        _removerTile(
          label: 'removePadding(removeTop: true)',
          stripe: Color(0xFF1565C0),
          child: MediaQuery(
            data: base,
            child: Builder(
              builder: (BuildContext ctx) {
                return MediaQuery.removePadding(
                  context: ctx,
                  removeTop: true,
                  child: SafeArea(
                    child: interior('top consumed by outer\nremover; SafeArea\nadds left/right/bottom'),
                  ),
                );
              },
            ),
          ),
        ),
        _removerTile(
          label: 'removePadding(removeBottom: true)',
          stripe: Color(0xFFEF6C00),
          child: MediaQuery(
            data: base,
            child: Builder(
              builder: (BuildContext ctx) {
                return MediaQuery.removePadding(
                  context: ctx,
                  removeBottom: true,
                  child: SafeArea(
                    child: interior('bottom stripped\nbefore SafeArea sees it'),
                  ),
                );
              },
            ),
          ),
        ),
        _removerTile(
          label: 'removePadding(all)',
          stripe: Color(0xFF8E24AA),
          child: MediaQuery(
            data: base,
            child: Builder(
              builder: (BuildContext ctx) {
                return MediaQuery.removePadding(
                  context: ctx,
                  removeLeft: true,
                  removeTop: true,
                  removeRight: true,
                  removeBottom: true,
                  child: SafeArea(
                    child: interior('every side stripped\nSafeArea becomes\nan identity wrapper'),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 9: Padding manual vs SafeArea
// ---------------------------------------------------------------------------

Widget _manualVsSafeAreaSection() {
  final MediaQueryData mq = MediaQueryData(
    padding: EdgeInsets.fromLTRB(14.0, 30.0, 14.0, 24.0),
  );

  Widget cell(String title, Widget body, Color color) {
    return Container(
      margin: EdgeInsets.all(6.0),
      width: 220.0,
      height: 170.0,
      decoration: BoxDecoration(
        color: Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Color(0xFFBDBDBD)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: color,
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(child: body),
        ],
      ),
    );
  }

  final Widget manual = MediaQuery(
    data: mq,
    child: Padding(
      padding: EdgeInsets.fromLTRB(14.0, 30.0, 14.0, 24.0),
      child: Container(
        color: Color(0xFF7E57C2),
        alignment: Alignment.center,
        child: Text(
          'Manual Padding — hard-coded\nvalues, no reaction to MediaQuery',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 11.5),
        ),
      ),
    ),
  );

  final Widget safe = MediaQuery(
    data: mq,
    child: SafeArea(
      child: Container(
        color: Color(0xFF26A69A),
        alignment: Alignment.center,
        child: Text(
          'SafeArea — pulls padding from\nMediaQuery; survives orientation/\ndevice changes',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 11.5),
        ),
      ),
    ),
  );

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(0xFFCCCCCC)),
    ),
    child: Wrap(
      alignment: WrapAlignment.center,
      children: [
        cell('Padding (manual)', manual, Color(0xFF512DA8)),
        cell('SafeArea (reactive)', safe, Color(0xFF00796B)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 10: parameter cheat-sheet table
// ---------------------------------------------------------------------------

TableRow _cheatRow(String name, String type, String desc, {bool header = false}) {
  final TextStyle style = TextStyle(
    fontSize: 11.5,
    color: header ? Colors.white : Color(0xFF263238),
    fontWeight: header ? FontWeight.w700 : FontWeight.w500,
  );
  final Color bg = header ? Color(0xFF263238) : Color(0xFFFFFFFF);
  return TableRow(
    decoration: BoxDecoration(color: bg),
    children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        child: Text(name, style: style),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        child: Text(type, style: style),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        child: Text(desc, style: style),
      ),
    ],
  );
}

Widget _buildCheatSheet() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(0xFF263238)),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(7.0),
      child: Table(
        columnWidths: {
          0: FlexColumnWidth(2.2),
          1: FlexColumnWidth(1.4),
          2: FlexColumnWidth(4.6),
        },
        border: TableBorder.symmetric(
          inside: BorderSide(color: Color(0xFFE0E0E0), width: 0.6),
        ),
        children: [
          _cheatRow('parameter', 'type', 'meaning', header: true),
          _cheatRow('left', 'bool',
              'When true, consume MediaQuery.padding.left.'),
          _cheatRow('top', 'bool',
              'When true, consume MediaQuery.padding.top (status bar, notch).'),
          _cheatRow('right', 'bool',
              'When true, consume MediaQuery.padding.right.'),
          _cheatRow('bottom', 'bool',
              'When true, consume MediaQuery.padding.bottom (home indicator).'),
          _cheatRow('minimum', 'EdgeInsets',
              'Floor — SafeArea will pad by at least these values per edge.'),
          _cheatRow('maintainBottomViewPadding', 'bool',
              'If true, keep bottom viewPadding even when viewInsets.bottom>0.'),
          _cheatRow('child / sliver', 'Widget / Widget',
              'Wrapped subtree (SafeArea.child or SliverSafeArea.sliver).'),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 11: Padding-only variations (no SafeArea) for contrast
// ---------------------------------------------------------------------------

Widget _paddingOnlyVariant(String label, EdgeInsetsGeometry padding, Color color) {
  return Container(
    margin: EdgeInsets.all(4.0),
    width: 160.0,
    height: 90.0,
    decoration: BoxDecoration(
      color: Color(0xFFECEFF1),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: Color(0xFFB0BEC5)),
    ),
    child: Padding(
      padding: padding,
      child: Container(
        color: color,
        alignment: Alignment.center,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 10.5),
        ),
      ),
    ),
  );
}

Widget _buildPaddingOnlySection() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0),
    padding: EdgeInsets.all(6.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      border: Border.all(color: Color(0xFFCCCCCC)),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Wrap(
      alignment: WrapAlignment.center,
      children: [
        _paddingOnlyVariant(
          'all(0)',
          EdgeInsets.all(0.0),
          Color(0xFF1E88E5),
        ),
        _paddingOnlyVariant(
          'all(4)',
          EdgeInsets.all(4.0),
          Color(0xFF1E88E5),
        ),
        _paddingOnlyVariant(
          'all(8)',
          EdgeInsets.all(8.0),
          Color(0xFF1E88E5),
        ),
        _paddingOnlyVariant(
          'all(16)',
          EdgeInsets.all(16.0),
          Color(0xFF1E88E5),
        ),
        _paddingOnlyVariant(
          'symmetric h:24',
          EdgeInsets.symmetric(horizontal: 24.0),
          Color(0xFF8E24AA),
        ),
        _paddingOnlyVariant(
          'symmetric v:18',
          EdgeInsets.symmetric(vertical: 18.0),
          Color(0xFF8E24AA),
        ),
        _paddingOnlyVariant(
          'fromLTRB(4,16,4,4)',
          EdgeInsets.fromLTRB(4.0, 16.0, 4.0, 4.0),
          Color(0xFFE53935),
        ),
        _paddingOnlyVariant(
          'only(left:24)',
          EdgeInsets.only(left: 24.0),
          Color(0xFFE53935),
        ),
        _paddingOnlyVariant(
          'directional start:24 LTR',
          EdgeInsetsDirectional.only(start: 24.0),
          Color(0xFF00897B),
        ),
        _paddingOnlyVariant(
          'directional end:24 LTR',
          EdgeInsetsDirectional.only(end: 24.0),
          Color(0xFF00897B),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Top-level build
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('safearea_test build() entered');

  // Section 1 ------------------------------------------------------------
  final Widget section1 = _sectionTitle(
    '1. SafeArea edge-flag matrix',
    'left / top / right / bottom — every flag turned on and off in a grid',
  );
  print('Section 1: building SafeArea edge-flag matrix');
  final Widget matrix = _buildEdgeFlagMatrix();
  final Widget section1Explainer = _explainerCard(
    'SafeArea has four boolean parameters — left, top, right, bottom — each '
    'defaulting to true. Setting one to false lets content slide under the '
    'corresponding system inset on that edge.',
    tint: Color(0xFF1E88E5),
  );

  // Section 2 ------------------------------------------------------------
  final Widget section2 = _sectionTitle(
    '2. minimum padding floors',
    'How SafeArea(minimum:) interacts with simulated MediaQuery.padding',
  );
  print('Section 2: building minimum-padding gallery');
  final Widget minimumGallery = _buildMinimumPaddingGallery();
  final Widget section2Explainer = _explainerCard(
    'The minimum parameter is an EdgeInsets floor. For each edge the consumed '
    'padding becomes max(MediaQuery.padding.<edge>, minimum.<edge>). This is '
    'useful when you want at least N pixels of breathing room even on devices '
    'without a notch.',
    tint: Color(0xFF43A047),
  );

  // Section 3 ------------------------------------------------------------
  final Widget section3 = _sectionTitle(
    '3. SliverSafeArea inside CustomScrollView',
    'Wrapping slivers — analogous parameters, sliver child instead of widget',
  );
  print('Section 3: building SliverSafeArea section');
  final Widget sliverDemo = _buildSliverSafeAreaSection();
  final Widget section3Explainer = _explainerCard(
    'SliverSafeArea works identically to SafeArea but is sliver-aware: instead '
    'of a single child it takes a single sliver. The same left/top/right/'
    'bottom/minimum/maintainBottomViewPadding parameters apply.',
    tint: Color(0xFFEF6C00),
  );

  // Section 4 ------------------------------------------------------------
  final Widget section4 = _sectionTitle(
    '4. Nested SafeArea recipe',
    'Outer SafeArea → MediaQuery.removePadding → inner SafeArea',
  );
  print('Section 4: building nested SafeArea recipe');
  final Widget nestedDemo = _buildNestedSafeAreaRecipe();
  final Widget section4Explainer = _explainerCard(
    'Wrapping a subtree in MediaQuery.removePadding(removeTop: true) before a '
    'second SafeArea prevents double-consumption of the top inset. This is '
    'the standard recipe for layouts where a portion of the page should pin '
    'to the status bar while a portion below should not re-add the status-bar '
    'space.',
    tint: Color(0xFF8E24AA),
  );

  // Section 5 ------------------------------------------------------------
  final Widget section5 = _sectionTitle(
    '5. padding vs viewPadding vs viewInsets',
    'CustomPaint diagram contrasting the three EdgeInsets on MediaQueryData',
  );
  print('Section 5: building inset diagram');
  final Widget diagrams = _buildInsetDiagramSection();
  final Widget section5Explainer = _explainerCard(
    'MediaQueryData exposes three EdgeInsets. viewPadding is the device-'
    'imposed inset (notch, status bar, gesture bar). padding is viewPadding '
    'minus the part currently covered by something the OS draws on top of '
    'the app (typically the keyboard). viewInsets is that overlap.',
    tint: Color(0xFFD81B60),
  );

  // Section 6 ------------------------------------------------------------
  final Widget section6 = _sectionTitle(
    '6. maintainBottomViewPadding',
    'Keep bottom viewPadding visible even when the keyboard is up',
  );
  print('Section 6: building maintainBottomViewPadding tiles');
  final Widget maintain = _buildMaintainBottomViewPaddingSection();
  final Widget section6Explainer = _explainerCard(
    'maintainBottomViewPadding is a small but specific knob: when true and '
    'viewInsets.bottom is non-zero, the bottom inset reserved by SafeArea is '
    'taken from viewPadding.bottom instead of padding.bottom. Useful when a '
    'scrollable resizes around the keyboard but a bottom action bar must '
    'still clear the home-indicator strip.',
    tint: Color(0xFFFB8C00),
  );

  // Section 7 ------------------------------------------------------------
  final Widget section7 = _sectionTitle(
    '7. EdgeInsets vs EdgeInsetsDirectional',
    'How directional insets respond to TextDirection.ltr vs rtl',
  );
  print('Section 7: building EdgeInsets section');
  final Widget edgeInsets = _buildEdgeInsetsSection();
  final Widget section7Explainer = _explainerCard(
    'EdgeInsets is direction-agnostic (left/top/right/bottom). '
    'EdgeInsetsDirectional uses start/end and resolves against the ambient '
    'Directionality. Compare the LTR and RTL rows to see start/end flip.',
    tint: Color(0xFF00838F),
  );

  // Section 8 ------------------------------------------------------------
  final Widget section8 = _sectionTitle(
    '8. MediaQuery.removePadding family',
    'removeTop / removeBottom / removeLeft / removeRight in action',
  );
  print('Section 8: building MediaQuery.removePadding section');
  final Widget removers = _buildRemovePaddingSection();
  final Widget section8Explainer = _explainerCard(
    'MediaQuery.removePadding(...) returns a new MediaQuery whose padding '
    'has the chosen edges zeroed out. Combined with SafeArea this is how you '
    'compose precise per-edge consumption rules.',
    tint: Color(0xFF1565C0),
  );

  // Section 9 ------------------------------------------------------------
  final Widget section9 = _sectionTitle(
    '9. Manual Padding vs SafeArea',
    'Hand-tuned EdgeInsets vs. SafeArea reading MediaQuery',
  );
  print('Section 9: building manual padding vs SafeArea comparison');
  final Widget manualVs = _manualVsSafeAreaSection();
  final Widget section9Explainer = _explainerCard(
    'Manual Padding is a constant — it does not adapt when the device, '
    'orientation, or keyboard changes. SafeArea reads MediaQuery and reacts. '
    'Prefer SafeArea wherever the padding should track system insets.',
    tint: Color(0xFF7E57C2),
  );

  // Section 10 -----------------------------------------------------------
  final Widget section10 = _sectionTitle(
    '10. Parameter cheat-sheet',
    'Every parameter of SafeArea / SliverSafeArea, with type and meaning',
  );
  print('Section 10: building cheat-sheet table');
  final Widget cheat = _buildCheatSheet();

  // Section 11 -----------------------------------------------------------
  final Widget section11 = _sectionTitle(
    '11. Padding variants gallery',
    'EdgeInsets constructors at a glance, no SafeArea involved',
  );
  print('Section 11: building Padding-only gallery');
  final Widget paddingGallery = _buildPaddingOnlySection();
  final Widget section11Explainer = _explainerCard(
    'For contrast, this section shows the same kind of layout space carved '
    'out by hard-coded Padding only. Useful for fine-tuned typography and '
    'card spacing where you do not want to track device insets.',
    tint: Color(0xFF455A64),
  );

  print('safearea_test: assembling final ListView');

  final ListView body = ListView(
    padding: EdgeInsets.symmetric(vertical: 16.0),
    children: [
      // header banner
      Container(
        margin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF102A43), Color(0xFF2E5F89), Color(0xFF4A90E2)],
          ),
          borderRadius: BorderRadius.circular(14.0),
          boxShadow: [
            BoxShadow(
              color: Color(0x66000000),
              blurRadius: 10.0,
              offset: Offset(0.0, 5.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SafeArea Deep-Dive',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              'SafeArea • SliverSafeArea • MediaQuery padding/viewPadding/'
              'viewInsets • EdgeInsets • EdgeInsetsDirectional • Padding',
              style: TextStyle(
                color: Color(0xFFCCE0F2),
                fontSize: 12.5,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),

      section1,
      section1Explainer,
      matrix,

      section2,
      section2Explainer,
      minimumGallery,

      section3,
      section3Explainer,
      sliverDemo,

      section4,
      section4Explainer,
      nestedDemo,

      section5,
      section5Explainer,
      diagrams,

      section6,
      section6Explainer,
      maintain,

      section7,
      section7Explainer,
      edgeInsets,

      section8,
      section8Explainer,
      removers,

      section9,
      section9Explainer,
      manualVs,

      section10,
      cheat,

      section11,
      section11Explainer,
      paddingGallery,

      // footer
      Container(
        margin: EdgeInsets.fromLTRB(16.0, 22.0, 16.0, 10.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Color(0xFF263238),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'End of SafeArea visual demo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'Eleven sections covering every parameter of SafeArea and '
              'SliverSafeArea plus the surrounding MediaQuery inset family.',
              style: TextStyle(color: Color(0xFFB0BEC5), fontSize: 11.5),
            ),
          ],
        ),
      ),
    ],
  );

  print('safearea_test: build() returning Scaffold');

  return Scaffold(
    backgroundColor: Color(0xFFEFF3F7),
    appBar: AppBar(
      backgroundColor: Color(0xFF102A43),
      title: Text(
        'SafeArea & MediaQuery Family',
        style: TextStyle(color: Colors.white),
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    body: body,
  );
}
