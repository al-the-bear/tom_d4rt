// D4rt test script: Tests BottomAppBar from material
// Deep Demo: The BottomAppBar field guide — every parameter, every shape,
// every shadow tone, rendered as a gallery of phone-screen previews.
import 'package:flutter/material.dart';

// ============================================================
// Helper: a phone-screen frame used by every section preview.
// Renders a fake status bar with three dots, a content area
// the caller fills, and an optional BottomAppBar pinned to the
// bottom. The frame is approximately 360 x 200 logical pixels.
// ============================================================
Widget _phoneFrame({
  required Widget contentArea,
  required Widget bottomBar,
  double width = 360.0,
  double height = 200.0,
  Color background = const Color(0xFFF7F7FA),
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: background,
      borderRadius: const BorderRadius.all(Radius.circular(18.0)),
      border: Border.all(color: const Color(0xFFB8B8C2), width: 1.5),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x1F000000),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Fake status bar with three colored dots.
        Container(
          height: 18.0,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          color: const Color(0xFFEDEDF2),
          child: Row(
            children: const <Widget>[
              _StatusDot(color: Color(0xFFE57373)),
              SizedBox(width: 6.0),
              _StatusDot(color: Color(0xFFFFB74D)),
              SizedBox(width: 6.0),
              _StatusDot(color: Color(0xFF81C784)),
              Spacer(),
              Text(
                '9:41',
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF555566),
                ),
              ),
            ],
          ),
        ),
        Expanded(child: contentArea),
        bottomBar,
      ],
    ),
  );
}

class _StatusDot extends StatelessWidget {
  final Color color;
  const _StatusDot({required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8.0,
      height: 8.0,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

// Helper for section title cards.
Widget _sectionCard({
  required String index,
  required String title,
  required String narrative,
  required Color accent,
  required Widget body,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.12),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 34.0,
              height: 34.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Text(
                index,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          narrative,
          style: const TextStyle(
            fontSize: 13.0,
            color: Color(0xFF44444C),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 14.0),
        body,
      ],
    ),
  );
}

// Builds a fake placeholder content area for the phone frames.
// Wrapped in SingleChildScrollView so the inner Column's natural height
// (~122 px: text block + image row + paddings) can exceed the available
// ~102 px area inside the 200-px phone frame without triggering a
// RenderFlex overflow assertion. The overflow is silently absorbed by
// the scroll viewport — visually identical, but framework-clean.
Widget _placeholderContent({Color tint = const Color(0xFFE3E6F0)}) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
        Container(
          height: 14.0,
          decoration: BoxDecoration(
            color: tint,
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          height: 10.0,
          width: 180.0,
          decoration: BoxDecoration(
            color: tint.withValues(alpha: 0.7),
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
        const SizedBox(height: 14.0),
        Row(
          children: <Widget>[
            Container(
              width: 56.0,
              height: 56.0,
              decoration: BoxDecoration(
                color: tint,
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 10.0,
                    decoration: BoxDecoration(
                      color: tint.withValues(alpha: 0.85),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Container(
                    height: 10.0,
                    width: 120.0,
                    decoration: BoxDecoration(
                      color: tint.withValues(alpha: 0.6),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        ],
      ),
    ),
  );
}

Widget _captionBelow(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.only(top: 6.0),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11.5,
        fontStyle: FontStyle.italic,
        color: color,
      ),
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('BottomAppBar field guide demo executing');

  // ============================================================
  // SECTION 1: Hero header — what BottomAppBar is, when to use it
  // ============================================================
  debugPrint('=== Section 1: Hero header ===');

  final Widget heroHeader = Container(
    margin: const EdgeInsets.all(14.0),
    padding: const EdgeInsets.all(20.0),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Color(0xFF1E3A8A), Color(0xFF4338CA), Color(0xFF7C3AED)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.view_agenda, color: Colors.white, size: 32.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                'The BottomAppBar Field Guide',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'A BottomAppBar is the Material container that pins persistent '
          'actions to the bottom of a Scaffold. It is the home of M3 bottom '
          'bars, the cradle that hosts a docked FloatingActionButton, and the '
          'canvas where contextual icons live in mail, music, and editor apps.',
          style: TextStyle(color: Colors.white, fontSize: 13.5, height: 1.45),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: const <Widget>[
            _HeroChip(label: 'color'),
            _HeroChip(label: 'elevation'),
            _HeroChip(label: 'shape'),
            _HeroChip(label: 'notchMargin'),
            _HeroChip(label: 'clipBehavior'),
            _HeroChip(label: 'padding'),
            _HeroChip(label: 'surfaceTintColor'),
            _HeroChip(label: 'shadowColor'),
            _HeroChip(label: 'height'),
            _HeroChip(label: 'child'),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Plain BottomAppBar — flat, no notch
  // ============================================================
  debugPrint('=== Section 2: Plain BottomAppBar ===');

  final Widget plainBar = BottomAppBar(
    color: Colors.white,
    elevation: 4.0,
    child: Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => debugPrint('Menu pressed'),
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => debugPrint('Search pressed'),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: () => debugPrint('Notifications pressed'),
        ),
        IconButton(
          icon: const Icon(Icons.account_circle_outlined),
          onPressed: () => debugPrint('Profile pressed'),
        ),
      ],
    ),
  );

  final Widget section2 = _sectionCard(
    index: '02',
    title: 'Plain BottomAppBar',
    narrative:
        'No notch, no FAB. Just a flat surface with four IconButtons and a '
        'Spacer that pushes the trailing actions to the right edge. This is '
        'the most common BottomAppBar layout in practice.',
    accent: const Color(0xFF0EA5E9),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _phoneFrame(
          contentArea: _placeholderContent(tint: const Color(0xFFE0F2FE)),
          bottomBar: plainBar,
        ),
        _captionBelow(
          'Two leading icons, a Spacer, then two trailing icons.',
          const Color(0xFF0369A1),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: CircularNotchedRectangle — docked round FAB
  // ============================================================
  debugPrint('=== Section 3: CircularNotchedRectangle ===');

  final Widget notchedBar = BottomAppBar(
    color: Colors.white,
    elevation: 6.0,
    shape: const CircularNotchedRectangle(),
    notchMargin: 6.0,
    child: Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => debugPrint('Notched menu'),
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => debugPrint('Notched search'),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.share_outlined),
          onPressed: () => debugPrint('Notched share'),
        ),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () => debugPrint('Notched overflow'),
        ),
      ],
    ),
  );

  // Stack-based recreation that highlights the notch cutout.
  final Widget notchedStack = SizedBox(
    width: 360.0,
    height: 200.0,
    child: Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        _phoneFrame(
          contentArea: _placeholderContent(tint: const Color(0xFFFDE68A)),
          bottomBar: notchedBar,
        ),
        Positioned(
          bottom: 30.0,
          child: FloatingActionButton(
            backgroundColor: const Color(0xFFF59E0B),
            onPressed: () => debugPrint('Docked FAB tapped'),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    ),
  );

  final Widget section3 = _sectionCard(
    index: '03',
    title: 'CircularNotchedRectangle + Docked FAB',
    narrative:
        'Setting shape to CircularNotchedRectangle and pairing the Scaffold '
        'with a FloatingActionButton at FloatingActionButtonLocation.centerDocked '
        'punches a circular notch in the bar path. notchMargin controls the '
        'breathing room between the FAB and the cut edge.',
    accent: const Color(0xFFF59E0B),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        notchedStack,
        _captionBelow(
          'The Stack recreates how Scaffold composites the FAB above a notched bar.',
          const Color(0xFFB45309),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: AutomaticNotchedShape — rounded-rect FAB
  // ============================================================
  debugPrint('=== Section 4: AutomaticNotchedShape ===');

  const ShapeBorder hostShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(0.0)),
  );
  const ShapeBorder guestShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(14.0)),
  );

  final Widget autoNotchedBar = BottomAppBar(
    color: const Color(0xFFFFFFFF),
    elevation: 8.0,
    shape: const AutomaticNotchedShape(hostShape, guestShape),
    notchMargin: 8.0,
    child: Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.dashboard_outlined),
          onPressed: () => debugPrint('Dashboard tapped'),
        ),
        IconButton(
          icon: const Icon(Icons.bookmark_border),
          onPressed: () => debugPrint('Bookmarks tapped'),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.tune),
          onPressed: () => debugPrint('Tune tapped'),
        ),
        IconButton(
          icon: const Icon(Icons.help_outline),
          onPressed: () => debugPrint('Help tapped'),
        ),
      ],
    ),
  );

  final Widget autoNotchedStack = SizedBox(
    width: 360.0,
    height: 200.0,
    child: Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        _phoneFrame(
          contentArea: _placeholderContent(tint: const Color(0xFFDDD6FE)),
          bottomBar: autoNotchedBar,
        ),
        Positioned(
          bottom: 30.0,
          child: Material(
            color: const Color(0xFF7C3AED),
            elevation: 6.0,
            shape: guestShape,
            child: SizedBox(
              width: 64.0,
              height: 56.0,
              child: IconButton(
                icon: const Icon(Icons.edit, color: Colors.white),
                onPressed: () => debugPrint('Rounded-rect FAB tapped'),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  final Widget section4 = _sectionCard(
    index: '04',
    title: 'AutomaticNotchedShape (non-circular FAB)',
    narrative:
        'AutomaticNotchedShape combines the host bar shape with the guest FAB '
        'shape to compute the cutout path. Here a rounded-rectangle Material '
        'plays the role of the FAB, and the bar carves out a matching pocket.',
    accent: const Color(0xFF7C3AED),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        autoNotchedStack,
        _captionBelow(
          'Compose any guest shape and AutomaticNotchedShape will subtract it.',
          const Color(0xFF6D28D9),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Elevation matrix — 3x3 grid
  // ============================================================
  debugPrint('=== Section 5: Elevation matrix ===');

  Widget elevationCell(double elevation) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 140.0,
            height: 60.0,
            child: BottomAppBar(
              color: Colors.white,
              elevation: elevation,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const <Widget>[
                  Icon(Icons.home, size: 18.0),
                  Icon(Icons.search, size: 18.0),
                  Icon(Icons.person, size: 18.0),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            'e=${elevation.toStringAsFixed(0)}',
            style: const TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w600,
              color: Color(0xFF334155),
            ),
          ),
        ],
      ),
    );
  }

  final List<double> elevations = <double>[0, 2, 4, 6, 8, 12, 16, 20, 24];
  final List<Widget> elevationRows = <Widget>[];
  for (int r = 0; r < 3; r++) {
    final List<Widget> rowCells = <Widget>[];
    for (int c = 0; c < 3; c++) {
      rowCells.add(elevationCell(elevations[r * 3 + c]));
    }
    elevationRows.add(
      Row(mainAxisAlignment: MainAxisAlignment.center, children: rowCells),
    );
  }

  final Widget section5 = _sectionCard(
    index: '05',
    title: 'Elevation matrix (0 to 24)',
    narrative:
        'Elevation drives the Material shadow under the bar. Below ~4 the '
        'shadow is barely visible. Around 6-8 it reads as a clear lift. Above '
        '16 it becomes dramatic and is best reserved for modal or hero bars.',
    accent: const Color(0xFF334155),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ...elevationRows,
        _captionBelow(
          'Tip: most production bars sit between elevation 4 and 8.',
          const Color(0xFF475569),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: surfaceTintColor + shadowColor exploration
  // ============================================================
  debugPrint('=== Section 6: surfaceTintColor + shadowColor ===');

  Widget tintCard({
    required String label,
    required String caption,
    Color? surfaceTint,
    Color? shadow,
    Color accent = const Color(0xFF475569),
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 160.0,
            height: 70.0,
            child: BottomAppBar(
              color: Colors.white,
              elevation: 10.0,
              surfaceTintColor: surfaceTint,
              shadowColor: shadow,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const <Widget>[
                  Icon(Icons.inbox_outlined, size: 20.0),
                  Icon(Icons.send_outlined, size: 20.0),
                  Icon(Icons.archive_outlined, size: 20.0),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              color: accent,
            ),
          ),
          SizedBox(
            width: 160.0,
            child: Text(
              caption,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10.5, color: Color(0xFF64748B)),
            ),
          ),
        ],
      ),
    );
  }

  final Widget section6 = _sectionCard(
    index: '06',
    title: 'surfaceTintColor + shadowColor',
    narrative:
        'surfaceTintColor blends with the background based on elevation, while '
        'shadowColor recolors the drop shadow. Pair them to keep the bar in '
        'sync with the rest of your M3 colorScheme.',
    accent: const Color(0xFFDB2777),
    body: Wrap(
      alignment: WrapAlignment.center,
      children: <Widget>[
        tintCard(
          label: 'Default',
          caption: 'No tint override; theme decides.',
          accent: const Color(0xFF334155),
        ),
        tintCard(
          label: 'Orange tint',
          caption: 'Warm, energetic surface lift.',
          surfaceTint: const Color(0xFFFB923C),
          accent: const Color(0xFFEA580C),
        ),
        tintCard(
          label: 'Blue tint',
          caption: 'Cool, professional mood.',
          surfaceTint: const Color(0xFF3B82F6),
          accent: const Color(0xFF1D4ED8),
        ),
        tintCard(
          label: 'Deep-purple shadow',
          caption: 'Saturated shadow casts a colored glow.',
          shadow: const Color(0xFF6D28D9),
          accent: const Color(0xFF5B21B6),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Padding behavior
  // ============================================================
  debugPrint('=== Section 7: Padding behavior ===');

  Widget paddingFrame({
    required EdgeInsetsGeometry padding,
    required String label,
    required Color accent,
  }) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 170.0,
            height: 90.0,
            child: BottomAppBar(
              color: Colors.white,
              elevation: 4.0,
              padding: padding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const <Widget>[
                  Icon(Icons.home_outlined),
                  Icon(Icons.search),
                  Icon(Icons.settings_outlined),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              color: accent,
            ),
          ),
        ],
      ),
    );
  }

  final Widget section7 = _sectionCard(
    index: '07',
    title: 'Padding behavior',
    narrative:
        'The padding parameter wraps the bar contents and stacks on top of '
        'MediaQuery.padding.bottom (the system gesture inset). Zero padding '
        'puts icons flush; the default leaves comfortable margins; oversized '
        'padding produces an airy, tablet-friendly bar.',
    accent: const Color(0xFF059669),
    body: Wrap(
      alignment: WrapAlignment.center,
      children: <Widget>[
        paddingFrame(
          padding: EdgeInsets.zero,
          label: 'Zero padding',
          accent: const Color(0xFF047857),
        ),
        paddingFrame(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          label: 'Default padding',
          accent: const Color(0xFF065F46),
        ),
        paddingFrame(
          padding: const EdgeInsets.all(24.0),
          label: 'Oversized 24px',
          accent: const Color(0xFF064E3B),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: clipBehavior comparison
  // ============================================================
  debugPrint('=== Section 8: clipBehavior ===');

  Widget clipFrame({
    required Clip clip,
    required String label,
    required Color accent,
  }) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 180.0,
            height: 80.0,
            child: BottomAppBar(
              color: const Color(0xFFFEF3C7),
              elevation: 4.0,
              clipBehavior: clip,
              shape: const CircularNotchedRectangle(),
              notchMargin: 5.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEF4444),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 40.0,
                    height: 40.0,
                    color: const Color(0xFF1D4ED8),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              color: accent,
            ),
          ),
        ],
      ),
    );
  }

  final Widget section8 = _sectionCard(
    index: '08',
    title: 'clipBehavior comparison',
    narrative:
        'When the bar has a notched shape, clipBehavior decides whether '
        'children that overflow the shape are trimmed. antiAlias gives smooth '
        'curves at a small cost; hardEdge is cheaper but pixelated; none lets '
        'children paint past the shape entirely.',
    accent: const Color(0xFFD97706),
    body: Wrap(
      alignment: WrapAlignment.center,
      children: <Widget>[
        clipFrame(
          clip: Clip.antiAlias,
          label: 'Clip.antiAlias',
          accent: const Color(0xFFB45309),
        ),
        clipFrame(
          clip: Clip.hardEdge,
          label: 'Clip.hardEdge',
          accent: const Color(0xFF92400E),
        ),
        clipFrame(
          clip: Clip.none,
          label: 'Clip.none',
          accent: const Color(0xFF78350F),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Real-world micro-app — "Compose Mail"
  // ============================================================
  debugPrint('=== Section 9: Compose Mail micro-app ===');

  // Wrapped in SingleChildScrollView for the same reason as
  // _placeholderContent: the natural height of the inner Column exceeds
  // the available area inside the 220-px composeFrame phone (≈122 px),
  // which would otherwise trigger a RenderFlex overflow assertion.
  final Widget composeInbox = SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.inbox, color: Color(0xFF1D4ED8), size: 18.0),
            SizedBox(width: 6.0),
            Text(
              'Inbox (3 new)',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E3A8A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        _MailRow(
          sender: 'Greta',
          subject: 'Re: deployment window',
          color: Color(0xFFBFDBFE),
        ),
        const SizedBox(height: 6.0),
        _MailRow(
          sender: 'Build bot',
          subject: 'tom_d4rt #421 succeeded',
          color: Color(0xFFA7F3D0),
        ),
        const SizedBox(height: 6.0),
        _MailRow(
          sender: 'Newsletter',
          subject: 'Flutter weekly digest',
          color: Color(0xFFFDE68A),
        ),
        ],
      ),
    ),
  );

  final Widget composeBar = BottomAppBar(
    color: const Color(0xFFEFF6FF),
    elevation: 8.0,
    shape: const CircularNotchedRectangle(),
    notchMargin: 6.0,
    surfaceTintColor: const Color(0xFF3B82F6),
    shadowColor: const Color(0xFF1E3A8A),
    child: Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.attach_file, color: Color(0xFF1D4ED8)),
          onPressed: () => debugPrint('Attach'),
        ),
        IconButton(
          icon: const Icon(Icons.format_paint, color: Color(0xFF1D4ED8)),
          onPressed: () => debugPrint('Format'),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.delete_outline, color: Color(0xFFB91C1C)),
          onPressed: () => debugPrint('Discard'),
        ),
        IconButton(
          icon: const Icon(Icons.more_vert, color: Color(0xFF1D4ED8)),
          onPressed: () => debugPrint('Overflow'),
        ),
      ],
    ),
  );

  final Widget composeFrame = SizedBox(
    width: 360.0,
    height: 220.0,
    child: Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        _phoneFrame(
          height: 220.0,
          contentArea: composeInbox,
          bottomBar: composeBar,
        ),
        Positioned(
          bottom: 40.0,
          child: FloatingActionButton(
            backgroundColor: const Color(0xFF1D4ED8),
            onPressed: () => debugPrint('Send mail'),
            child: const Icon(Icons.send, color: Colors.white),
          ),
        ),
      ],
    ),
  );

  final Widget section9 = _sectionCard(
    index: '09',
    title: 'Micro-app: Compose Mail',
    narrative:
        'A representative composition: an inbox preview, a notched bar tinted '
        'with the brand blue, attach/format/delete/overflow icons, and a '
        'docked send FAB. This is BottomAppBar doing its real job.',
    accent: const Color(0xFF1D4ED8),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        composeFrame,
        _captionBelow(
          'Brand-tinted surface, contextual icons, docked primary action.',
          const Color(0xFF1E3A8A),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Cheat sheet — 2-column key/value table
  // ============================================================
  debugPrint('=== Section 10: Cheat sheet ===');

  Widget cheatRow(String key, String value, {bool alt = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      color: alt ? const Color(0xFFF1F5F9) : Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 130.0,
            child: Text(
              key,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12.5,
                color: Color(0xFF334155),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget cheatSheet = ClipRRect(
    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
    child: Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          color: const Color(0xFF0F172A),
          child: const Text(
            'BottomAppBar at a glance',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
        ),
        cheatRow('color', 'Background color of the bar surface.'),
        cheatRow(
          'elevation',
          'Z-axis lift in logical pixels; drives shadow depth.',
          alt: true,
        ),
        cheatRow(
          'shape',
          'A NotchedShape (Circular or Automatic) that carves out the FAB cradle.',
        ),
        cheatRow(
          'notchMargin',
          'Gap in logical pixels between the FAB and the cut edge.',
          alt: true,
        ),
        cheatRow(
          'clipBehavior',
          'How children that overflow the shape are clipped.',
        ),
        cheatRow(
          'padding',
          'Inset wrapped around the child; stacks with system insets.',
          alt: true,
        ),
        cheatRow(
          'surfaceTintColor',
          'M3 tint blended in based on elevation.',
        ),
        cheatRow(
          'shadowColor',
          'Color of the drop shadow at the given elevation.',
          alt: true,
        ),
        cheatRow('height', 'Fixed height in logical pixels, or null for auto.'),
        cheatRow(
          'child',
          'The Row/Column/etc. that lays out the bar contents.',
          alt: true,
        ),
      ],
    ),
  );

  final Widget section10 = _sectionCard(
    index: '10',
    title: 'Cheat sheet',
    narrative:
        'A condensed reference for every BottomAppBar parameter covered in the '
        'field guide.',
    accent: const Color(0xFF0F172A),
    body: cheatSheet,
  );

  // Final demonstration BottomAppBar with explicit height parameter.
  debugPrint('=== Section 11: Explicit height bar ===');

  final Widget heightBar = BottomAppBar(
    color: Colors.white,
    elevation: 6.0,
    height: 72.0,
    surfaceTintColor: const Color(0xFF22C55E),
    shadowColor: const Color(0xFF15803D),
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    clipBehavior: Clip.antiAlias,
    child: Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.eco_outlined, color: Color(0xFF15803D)),
          onPressed: () => debugPrint('Eco'),
        ),
        const Spacer(),
        Text(
          'height: 72.0',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF15803D).withValues(alpha: 0.9),
          ),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.arrow_forward, color: Color(0xFF15803D)),
          onPressed: () => debugPrint('Forward'),
        ),
      ],
    ),
  );

  final Widget section11 = _sectionCard(
    index: '11',
    title: 'Explicit height',
    narrative:
        'Setting height pins the bar to a fixed vertical size, overriding the '
        'natural sizing from the child. Useful when designing for a precise '
        'baseline grid.',
    accent: const Color(0xFF15803D),
    body: _phoneFrame(
      contentArea: _placeholderContent(tint: const Color(0xFFDCFCE7)),
      bottomBar: heightBar,
    ),
  );

  // ============================================================
  // Final Scaffold composition
  // ============================================================
  debugPrint('Composing final BottomAppBar field guide Scaffold');

  return Scaffold(
    backgroundColor: const Color(0xFFF1F5F9),
    appBar: AppBar(
      backgroundColor: const Color(0xFF1E3A8A),
      foregroundColor: Colors.white,
      title: const Text('BottomAppBar Field Guide'),
      elevation: 4.0,
    ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          heroHeader,
          section2,
          section3,
          section4,
          section5,
          section6,
          section7,
          section8,
          section9,
          section10,
          section11,
          const SizedBox(height: 20.0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0),
            child: Text(
              'End of guide — eleven sections covering every BottomAppBar '
              'parameter with paired phone-screen previews.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0,
                fontStyle: FontStyle.italic,
                color: Color(0xFF475569),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}

class _HeroChip extends StatelessWidget {
  final String label;
  const _HeroChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.45),
          width: 1.0,
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _MailRow extends StatelessWidget {
  final String sender;
  final String subject;
  final Color color;
  const _MailRow({
    required this.sender,
    required this.subject,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 28.0,
          height: 28.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Text(
            sender.substring(0, 1),
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                sender,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              Text(
                subject,
                style: const TextStyle(
                  fontSize: 11.0,
                  color: Color(0xFF475569),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
