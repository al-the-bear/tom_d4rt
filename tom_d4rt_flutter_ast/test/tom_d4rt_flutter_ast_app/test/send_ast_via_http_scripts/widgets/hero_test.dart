// ignore_for_file: avoid_print, unused_local_variable
// D4rt deep demo: Hero — the cross-route choreography widget.
// Static visual exposition (no animation controllers, no async, no Navigator).
// Renders 13 themed sections illustrating anatomy, tags, flight frames, and
// the conceptual surface of the Hero widget.
import 'package:flutter/material.dart';

// ============================================================================
// PALETTE — coherent indigo / teal / copper / sand
// ============================================================================
const Color _bgDeep = Color(0xFF0E1730);
const Color _bgPanel = Color(0xFF152042);
const Color _accentTeal = Color(0xFF14B8A6);
const Color _accentIndigo = Color(0xFF6366F1);
const Color _accentCopper = Color(0xFFE08D3C);
const Color _accentSand = Color(0xFFEAD9B3);
const Color _accentRose = Color(0xFFEC4899);
const Color _textPrimary = Color(0xFFF1F5F9);
const Color _textMuted = Color(0xFFAAB4C8);
const Color _flightTrail = Color(0xFFFFD166);

// ============================================================================
// PRIMITIVE: SECTION BANNER
// ============================================================================
Widget _sectionBanner(int n, String title, String subtitle, Color tint) {
  return Container(
    margin: const EdgeInsets.fromLTRB(12.0, 22.0, 12.0, 8.0),
    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [tint.withValues(alpha: 0.85), tint.withValues(alpha: 0.45)],
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.white24, width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 44.0,
          height: 44.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.white24, width: 1.0),
          ),
          child: Text(
            n.toString().padLeft(2, '0'),
            style: const TextStyle(
              color: _accentSand,
              fontSize: 18.0,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.4,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12.0,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
        ),
        const Icon(Icons.flight_takeoff, color: Colors.white70, size: 28.0),
      ],
    ),
  );
}

// ============================================================================
// PRIMITIVE: PANEL CARD
// ============================================================================
Widget _panel({required Widget child, EdgeInsets? padding, Color? tint}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    padding: padding ?? const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          (tint ?? _bgPanel).withValues(alpha: 0.95),
          (tint ?? _bgPanel).withValues(alpha: 0.78),
        ],
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.white12, width: 1.0),
      boxShadow: const [
        BoxShadow(color: Colors.black45, blurRadius: 6.0, offset: Offset(0.0, 3.0)),
      ],
    ),
    child: child,
  );
}

// ============================================================================
// PRIMITIVE: CAPTION TEXT
// ============================================================================
Widget _caption(String text, {Color? color, double size = 12.0}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Text(
      text,
      style: TextStyle(
        color: color ?? _textMuted,
        fontSize: size,
        height: 1.4,
        letterSpacing: 0.2,
      ),
    ),
  );
}

// ============================================================================
// PRIMITIVE: BULLET ROW
// ============================================================================
Widget _bullet(IconData icon, Color color, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 18.0),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: _textPrimary,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// PRIMITIVE: TAG BADGE
// ============================================================================
Widget _tagBadge(String tag, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.white, width: 1.0),
    ),
    child: Text(
      'tag: $tag',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 10.5,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.6,
      ),
    ),
  );
}

// ============================================================================
// PRIMITIVE: SMALL CHIP
// ============================================================================
Widget _chip(String label, Color bg, {Color fg = Colors.white}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: fg,
        fontSize: 10.0,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.4,
      ),
    ),
  );
}

// ============================================================================
// PRIMITIVE: ROUNDED RECT GLYPH (a stand-in for a Hero source/dest box)
// ============================================================================
Widget _glyph({
  required double width,
  required double height,
  required Color color,
  required IconData icon,
  required String label,
  double radius = 10.0,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [color.withValues(alpha: 0.95), color.withValues(alpha: 0.65)],
      ),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: Colors.white70, width: 1.5),
      boxShadow: const [
        BoxShadow(color: Colors.black45, blurRadius: 4.0, offset: Offset(0.0, 2.0)),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white, size: height * 0.35),
        const SizedBox(height: 4.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: width < 70 ? 8.5 : 10.0,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 01 — HEADER
// ============================================================================
Widget _heroHeader() {
  return Container(
    margin: const EdgeInsets.all(12.0),
    padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 26.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF1E1B4B),
          Color(0xFF312E81),
          Color(0xFF0F766E),
        ],
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: const [
        BoxShadow(color: Colors.black54, blurRadius: 14.0, offset: Offset(0.0, 6.0)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.flight_takeoff, color: _flightTrail, size: 34.0),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'HERO',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 6.0,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'cross-route choreography of a shared widget',
                    style: TextStyle(
                      color: _accentSand,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: _accentTeal, width: 1.2),
              ),
              child: const Text(
                'package:flutter/material.dart',
                style: TextStyle(
                  color: _accentTeal,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.white24, width: 1.0),
          ),
          child: Row(
            children: const [
              Icon(Icons.lightbulb_outline, color: _flightTrail, size: 20.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'A Hero pairs a source widget on one route with a destination '
                  'widget on another route via a shared tag, and lets the '
                  'Navigator animate the geometry change as a single visual flight.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.5,
                    height: 1.5,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 6.0,
          children: [
            _chip('shared tag', _accentTeal),
            _chip('flight shuttle', _accentIndigo),
            _chip('rect tween', _accentCopper),
            _chip('placeholder', _accentRose),
            _chip('user gestures', Colors.black54),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 02 — CONCEPT OVERVIEW
// ============================================================================
Widget _conceptOverview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionBanner(
        2,
        'CONCEPT OVERVIEW',
        'what Hero is, what it is not',
        _accentIndigo,
      ),
      _panel(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _caption(
              'A Hero is a widget that participates in a hero transition during a '
              'Navigator push or pop. Two Heroes with the same tag — one on the '
              'origin route, one on the destination route — are matched up and a '
              'single visual representation flies from the source rectangle to '
              'the destination rectangle.',
              color: _textPrimary,
            ),
            const SizedBox(height: 10.0),
            _bullet(Icons.check_circle, _accentTeal,
                'Heroes are matched by tag, not by widget identity.'),
            _bullet(Icons.check_circle, _accentTeal,
                'Each route may contain at most one Hero per tag.'),
            _bullet(Icons.check_circle, _accentTeal,
                'During a flight the Hero is parented to an Overlay above all routes.'),
            _bullet(Icons.check_circle, _accentTeal,
                'Source and destination tiles render placeholders while in flight.'),
            _bullet(Icons.error_outline, _accentRose,
                'Hero is NOT for in-route animation — for that use AnimatedSwitcher or AnimatedContainer.'),
            _bullet(Icons.error_outline, _accentRose,
                'Hero is NOT a hover effect; it requires a Navigator route change.'),
            _bullet(Icons.error_outline, _accentRose,
                'Hero is NOT a fade — its default tween is a rectangle interpolation.'),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 03 — ANATOMY DIAGRAM
// ============================================================================
Widget _anatomyDiagram() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionBanner(
        3,
        'ANATOMY OF A FLIGHT',
        'source rect • destination rect • flight path • tag',
        _accentTeal,
      ),
      _panel(
        child: Column(
          children: [
            SizedBox(
              height: 220.0,
              child: Stack(
                children: [
                  Positioned(
                    left: 16.0,
                    top: 30.0,
                    child: _glyph(
                      width: 70.0,
                      height: 70.0,
                      color: _accentTeal,
                      icon: Icons.image,
                      label: 'SRC',
                    ),
                  ),
                  Positioned(
                    right: 16.0,
                    bottom: 20.0,
                    child: _glyph(
                      width: 130.0,
                      height: 130.0,
                      color: _accentCopper,
                      icon: Icons.image,
                      label: 'DEST',
                    ),
                  ),
                  Positioned(
                    left: 70.0,
                    top: 90.0,
                    child: Container(
                      width: 160.0,
                      height: 4.0,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [_accentTeal, _flightTrail, _accentCopper],
                        ),
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 90.0,
                    top: 60.0,
                    child: _tagBadge('photo-42', _accentIndigo),
                  ),
                  Positioned(
                    right: 12.0,
                    top: 8.0,
                    child: _chip('Overlay', Colors.black54),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white24),
            Row(
              children: [
                Expanded(child: _caption('Source rect — the bounds of the origin Hero at the moment push starts.')),
                Expanded(child: _caption('Destination rect — the bounds of the matching Hero on the new route.')),
              ],
            ),
            Row(
              children: [
                Expanded(child: _caption('Flight path — a Tween<Rect> computed by createRectTween; default is MaterialRectArcTween.')),
                Expanded(child: _caption('Tag — the identity that pairs source and destination.')),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 04 — TAG FAMILY
// ============================================================================
Widget _tagFamily() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionBanner(
        4,
        'THE TAG FAMILY',
        'strings, ValueKeys, records — anything with == and hashCode',
        _accentCopper,
      ),
      _panel(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _caption(
              'Hero.tag accepts any Object. Two Heroes match when their tags '
              'compare equal under operator ==.',
              color: _textPrimary,
            ),
            const SizedBox(height: 10.0),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: [
                _tagBadge('"avatar-alice"', _accentTeal),
                _tagBadge('"avatar-bob"', _accentIndigo),
                _tagBadge('123', _accentCopper),
                _tagBadge('ValueKey(42)', _accentRose),
                _tagBadge('User#7', Colors.black54),
                _tagBadge('(album, 12)', _accentIndigo),
              ],
            ),
            const SizedBox(height: 14.0),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.white24, width: 1.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _bullet(Icons.bolt, _flightTrail,
                      'String tags — the most common; cheap to compare; easy to debug.'),
                  _bullet(Icons.bolt, _flightTrail,
                      'Int / enum tags — fine if values are stable across rebuilds.'),
                  _bullet(Icons.bolt, _flightTrail,
                      'ValueKey wrapping — disambiguates dynamic ids in lists.'),
                  _bullet(Icons.warning_amber, _accentRose,
                      'AVOID tag collisions: two Heroes with the same tag on one route is a runtime error.'),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 05 — SOURCE + DESTINATION PAIRS
// ============================================================================
Widget _sourceDestPair(String label, Color tint, IconData srcIcon, IconData destIcon) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.black38,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.white12, width: 1.0),
    ),
    child: Row(
      children: [
        _glyph(width: 60.0, height: 60.0, color: tint, icon: srcIcon, label: 'A'),
        const SizedBox(width: 10.0),
        const Icon(Icons.arrow_forward, color: _flightTrail, size: 22.0),
        const SizedBox(width: 10.0),
        _glyph(width: 100.0, height: 80.0, color: tint, icon: destIcon, label: 'B'),
        const SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4.0),
              const Text(
                'list tile → detail screen',
                style: TextStyle(
                  color: _textMuted,
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

Widget _sourceDestPairs() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionBanner(
        5,
        'SOURCE + DESTINATION PAIRS',
        'frozen snapshots of the two endpoints',
        _accentRose,
      ),
      _panel(
        child: Column(
          children: [
            _caption(
              'Each row pairs the small "source" Hero (on the origin route) with '
              'the large "destination" Hero (on the pushed route).',
              color: _textPrimary,
            ),
            const SizedBox(height: 8.0),
            _sourceDestPair('Photo card → full screen', _accentTeal, Icons.image, Icons.photo),
            _sourceDestPair('Avatar → profile page', _accentIndigo, Icons.person, Icons.account_circle),
            _sourceDestPair('Product tile → product page', _accentCopper, Icons.shopping_bag, Icons.storefront),
            _sourceDestPair('Album cover → album view', _accentRose, Icons.album, Icons.library_music),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 06 — FLIGHT TIMELINE (six frozen frames)
// ============================================================================
Widget _flightFrame(int i, double size, double dx) {
  return Container(
    width: 96.0,
    height: 130.0,
    margin: const EdgeInsets.symmetric(horizontal: 4.0),
    padding: const EdgeInsets.all(6.0),
    decoration: BoxDecoration(
      color: Colors.black54,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.white24, width: 1.0),
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: _accentIndigo,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            't = ${(i * 0.2).toStringAsFixed(1)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 9.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Expanded(
          child: Stack(
            children: [
              Positioned(
                left: dx,
                top: dx * 0.4,
                child: _glyph(
                  width: size,
                  height: size,
                  color: _accentCopper,
                  icon: Icons.image,
                  label: '',
                ),
              ),
            ],
          ),
        ),
        Text(
          'frame ${i + 1}',
          style: const TextStyle(
            color: _textMuted,
            fontSize: 9.5,
            letterSpacing: 0.4,
          ),
        ),
      ],
    ),
  );
}

Widget _flightTimeline() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionBanner(
        6,
        'FLIGHT TIMELINE',
        'six conceptual interpolation frames',
        _accentTeal,
      ),
      _panel(
        child: Column(
          children: [
            _caption(
              'A Hero flight is conceptually a Tween<Rect> sampled at every '
              'frame of the route-transition animation. Below are six frozen '
              'samples between source and destination.',
              color: _textPrimary,
            ),
            const SizedBox(height: 10.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _flightFrame(0, 18.0, 2.0),
                  _flightFrame(1, 28.0, 8.0),
                  _flightFrame(2, 40.0, 14.0),
                  _flightFrame(3, 52.0, 20.0),
                  _flightFrame(4, 62.0, 14.0),
                  _flightFrame(5, 72.0, 8.0),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            _caption(
              'Note how the rectangle grows AND translates: a 2D rect tween. '
              'The arc tween adds a curved path; the linear tween moves straight.',
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 07 — RECIPE CARDS
// ============================================================================
Widget _recipeCard(String title, String desc, IconData icon, Color tint) {
  return Container(
    width: 170.0,
    margin: const EdgeInsets.all(6.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [tint.withValues(alpha: 0.85), tint.withValues(alpha: 0.55)],
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.white24, width: 1.0),
      boxShadow: const [
        BoxShadow(color: Colors.black45, blurRadius: 5.0, offset: Offset(0.0, 3.0)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white, size: 22.0),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          desc,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10.5,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

Widget _recipes() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionBanner(
        7,
        'COMMON RECIPES',
        'patterns where Hero shines',
        _accentCopper,
      ),
      _panel(
        child: Wrap(
          children: [
            _recipeCard('Thumbnail → Detail',
                'Tap a thumbnail in a grid; it flies to the detail screen.',
                Icons.image, _accentTeal),
            _recipeCard('Avatar → Profile',
                'Avatar in app bar expands into the profile header.',
                Icons.person, _accentIndigo),
            _recipeCard('FAB → Form',
                'The floating action button morphs into the new-item form.',
                Icons.add_circle, _accentCopper),
            _recipeCard('Card → Modal',
                'A list card expands upward into a modal sheet.',
                Icons.credit_card, _accentRose),
            _recipeCard('Icon → Splash',
                'A logo icon expands into the splash screen of a feature.',
                Icons.star, _accentTeal),
            _recipeCard('Badge → Notification',
                'A small badge flies into a notification banner.',
                Icons.notifications, _accentIndigo),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 08 — CODE QUOTE
// ============================================================================
Widget _codeQuote() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionBanner(
        8,
        'CODE QUOTE',
        'the canonical Hero pair',
        _accentIndigo,
      ),
      _panel(
        tint: const Color(0xFF0B0F1E),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '// On the origin route',
              style: TextStyle(
                color: _textMuted,
                fontFamily: 'monospace',
                fontSize: 11.5,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'Hero(\n'
              '  tag: "photo-42",\n'
              '  child: Image.asset("thumb.jpg"),\n'
              ');',
              style: TextStyle(
                color: _accentSand,
                fontFamily: 'monospace',
                fontSize: 12.0,
                height: 1.45,
              ),
            ),
            SizedBox(height: 12.0),
            Text(
              '// On the destination route',
              style: TextStyle(
                color: _textMuted,
                fontFamily: 'monospace',
                fontSize: 11.5,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'Hero(\n'
              '  tag: "photo-42",\n'
              '  child: Image.asset("full.jpg"),\n'
              ');',
              style: TextStyle(
                color: _accentSand,
                fontFamily: 'monospace',
                fontSize: 12.0,
                height: 1.45,
              ),
            ),
            SizedBox(height: 12.0),
            Text(
              '// Trigger the transition with a normal Navigator push.\n'
              'Navigator.push(context, MaterialPageRoute(\n'
              '  builder: (ctx) => DetailScreen(),\n'
              '));',
              style: TextStyle(
                color: Color(0xFFB4E1FF),
                fontFamily: 'monospace',
                fontSize: 12.0,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 09 — SIDE-BY-SIDE COMPARISON
// ============================================================================
Widget _comparisonCol(String title, Color tint, List<String> bullets, IconData icon) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [tint.withValues(alpha: 0.85), tint.withValues(alpha: 0.55)],
        ),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.white24, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 20.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          ...bullets.map(
            (b) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: Text(
                '• $b',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10.5,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _comparison() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionBanner(
        9,
        'HERO vs ALTERNATIVES',
        'three approaches to "moving" a widget',
        _accentRose,
      ),
      _panel(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _comparisonCol(
              'Hero',
              _accentTeal,
              [
                'Cross-route transition',
                'Default arc rect tween',
                'Tag-paired source/dest',
                'Renders in Overlay during flight',
                'Best for: navigation morphs',
              ],
              Icons.flight_takeoff,
            ),
            _comparisonCol(
              'No Hero',
              Colors.black54,
              [
                'Routes change abruptly',
                'No visual continuity',
                'User must re-anchor visually',
                'Cheapest and simplest',
                'Best for: unrelated screens',
              ],
              Icons.cancel,
            ),
            _comparisonCol(
              'FadeTransition',
              _accentCopper,
              [
                'In-route alpha animation',
                'No geometry interpolation',
                'No tag concept',
                'Best for: opacity-only changes',
                'Cannot bridge routes',
              ],
              Icons.opacity,
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 10 — GLOSSARY
// ============================================================================
Widget _glossaryRow(String term, String def, Color tint) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 3.0),
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.black38,
      borderRadius: BorderRadius.circular(6.0),
      border: Border(left: BorderSide(color: tint, width: 3.0)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130.0,
          child: Text(
            term,
            style: TextStyle(
              color: tint,
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Expanded(
          child: Text(
            def,
            style: const TextStyle(
              color: _textPrimary,
              fontSize: 11.5,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _glossary() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionBanner(
        10,
        'GLOSSARY',
        'twelve terms you need to read Hero docs',
        _accentTeal,
      ),
      _panel(
        child: Column(
          children: [
            _glossaryRow('Hero', 'A widget that participates in a cross-route flight.', _accentTeal),
            _glossaryRow('tag', 'The Object that pairs two Heroes across routes.', _accentIndigo),
            _glossaryRow('source rect', 'The bounds of the origin Hero at push start.', _accentCopper),
            _glossaryRow('destination rect', 'The bounds of the destination Hero at push end.', _accentRose),
            _glossaryRow('Overlay', 'The Stack above all routes where the flying Hero lives.', _accentTeal),
            _glossaryRow('createRectTween', 'Callback that builds the Rect interpolation.', _accentIndigo),
            _glossaryRow('RectArcTween', 'Default tween — a curved path between rects.', _accentCopper),
            _glossaryRow('RectTween', 'Linear interpolation — straight-line path.', _accentRose),
            _glossaryRow('flightShuttleBuilder', 'Callback that builds the in-flight widget.', _accentTeal),
            _glossaryRow('placeholderBuilder', 'What the source/dest renders while flying.', _accentIndigo),
            _glossaryRow('transitionOnUserGestures', 'Whether iOS swipe-back also flies.', _accentCopper),
            _glossaryRow('HeroController', 'The NavigatorObserver that drives flights.', _accentRose),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 11 — transitionOnUserGestures
// ============================================================================
Widget _userGestures() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionBanner(
        11,
        'TRANSITION ON USER GESTURES',
        'should the swipe-back also fly?',
        _accentIndigo,
      ),
      _panel(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 120.0,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: _accentTeal.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: const [
                      Icon(Icons.swipe, color: Colors.white, size: 26.0),
                      SizedBox(height: 6.0),
                      Text(
                        'true',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'fly during swipe-back',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: _caption(
                    'When the iOS back-gesture pulls the route partially off, the '
                    'Hero shrinks back continuously with the gesture. Gives a '
                    'responsive feel but costs animation work on every drag frame.',
                    color: _textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 120.0,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: _accentRose.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: const [
                      Icon(Icons.block, color: Colors.white, size: 26.0),
                      SizedBox(height: 6.0),
                      Text(
                        'false',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'default — only on push/pop',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: _caption(
                    'The flight runs only on explicit Navigator.push / pop. A '
                    'partial swipe shows the dest route sliding away while the '
                    'Hero snaps back at gesture release.',
                    color: _textPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 12 — placeholderBuilder + flightShuttleBuilder
// ============================================================================
Widget _builders() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionBanner(
        12,
        'CUSTOM BUILDERS',
        'placeholderBuilder + flightShuttleBuilder',
        _accentCopper,
      ),
      _panel(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 6.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: _accentRose, width: 1.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.crop_square, color: _accentRose, size: 18.0),
                            SizedBox(width: 6.0),
                            Text(
                              'placeholderBuilder',
                              style: TextStyle(
                                color: _accentRose,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        _caption(
                          'Renders inside the source AND destination Hero locations '
                          'while the flight is airborne. Default is an empty '
                          'SizedBox so the spot looks empty.',
                        ),
                        const SizedBox(height: 6.0),
                        Container(
                          width: 80.0,
                          height: 60.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(
                              color: Colors.white38,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: const Text(
                            'EMPTY',
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 10.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 6.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: _accentTeal, width: 1.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.flight, color: _accentTeal, size: 18.0),
                            SizedBox(width: 6.0),
                            Text(
                              'flightShuttleBuilder',
                              style: TextStyle(
                                color: _accentTeal,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        _caption(
                          'Builds the actual airborne widget — defaults to the '
                          'destination child. Custom builders can fade source '
                          'into destination, rotate, scale, or swap shapes.',
                        ),
                        const SizedBox(height: 6.0),
                        Row(
                          children: [
                            _glyph(width: 32.0, height: 32.0, color: _accentTeal, icon: Icons.image, label: ''),
                            const Icon(Icons.arrow_right_alt, color: _accentSand, size: 20.0),
                            _glyph(width: 32.0, height: 32.0, color: _accentCopper, icon: Icons.photo, label: ''),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            _caption(
              'Both callbacks receive a context, the animation, the flight '
              'direction (push or pop), the from-hero context, and the to-hero '
              'context — enough information to produce a custom interpolation.',
              color: _textPrimary,
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// SECTION 13 — EPILOGUE / TAKEAWAYS
// ============================================================================
Widget _epilogue() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionBanner(
        13,
        'TAKEAWAYS',
        'the short list to keep on a sticky note',
        _accentRose,
      ),
      _panel(
        tint: const Color(0xFF1E1B4B),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bullet(Icons.bookmark, _flightTrail,
                'Pair Heroes by tag — same value on both routes; unique within each route.'),
            _bullet(Icons.bookmark, _flightTrail,
                'Hero only animates across Navigator route changes — not within a route.'),
            _bullet(Icons.bookmark, _flightTrail,
                'The default tween is an arc rect; supply createRectTween for a linear path.'),
            _bullet(Icons.bookmark, _flightTrail,
                'Use flightShuttleBuilder for custom airborne content (e.g. fade source → dest).'),
            _bullet(Icons.bookmark, _flightTrail,
                'Use placeholderBuilder if "empty spot" on source/dest looks wrong.'),
            _bullet(Icons.bookmark, _flightTrail,
                'transitionOnUserGestures = true makes iOS swipe-back also fly.'),
            _bullet(Icons.bookmark, _flightTrail,
                'A HeroController on the Navigator is required — MaterialApp wires it for you.'),
            const SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: _accentTeal, width: 1.0),
              ),
              child: Row(
                children: const [
                  Icon(Icons.flight_land, color: _accentTeal, size: 22.0),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      'A good Hero feels invisible: the user does not notice the '
                      'animation, they just feel that "the thing they tapped" '
                      'became "the screen they are now on".',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        height: 1.5,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// ENTRY POINT: build(context) — called directly by the D4rt host.
// ============================================================================
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Hero Deep Demo',
    home: Scaffold(
      backgroundColor: _bgDeep,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _heroHeader(),
              _conceptOverview(),
              _anatomyDiagram(),
              _tagFamily(),
              _sourceDestPairs(),
              _flightTimeline(),
              _recipes(),
              _codeQuote(),
              _comparison(),
              _glossary(),
              _userGestures(),
              _builders(),
              _epilogue(),
              const SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    ),
  );
}
