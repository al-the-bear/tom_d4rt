// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// CircleAvatar — Deep Visual Demo
// ---------------------------------------------------------------------------
// This file is intentionally long and explicit. It walks through almost every
// presentational use of the Material CircleAvatar widget. The interpreter
// only calls `build(BuildContext)`, so we keep the surface to a single entry
// point and a flat set of helper functions.
//
// Each helper produces one fully composed section of the demo screen. The
// sections do not share helpers between themselves beyond a few colour and
// text utilities at the bottom of the file. This is on purpose: copy/paste
// is avoided so every section has its own voice.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('CircleAvatar deep demo: building');

  final sections = <Widget>[
    _buildHeaderCard(),
    const SizedBox(height: 28),
    _buildRadiusFamily(),
    const SizedBox(height: 28),
    _buildInitialsGallery(),
    const SizedBox(height: 28),
    _buildStatusOverlays(),
    const SizedBox(height: 28),
    _buildGroupCallGrid(),
    const SizedBox(height: 28),
    _buildCommentThread(),
    const SizedBox(height: 28),
    _buildGradientFrames(),
    const SizedBox(height: 28),
    _buildStackedOverlap(),
    const SizedBox(height: 28),
    _buildForegroundIcons(),
    const SizedBox(height: 28),
    _buildEdgeCases(),
    const SizedBox(height: 28),
    _buildFooterNote(),
  ];

  return Container(
    color: const Color(0xFFF5F5F5),
    padding: const EdgeInsets.all(24),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: sections,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 1 — Header card: intro + anatomy diagram
// ---------------------------------------------------------------------------
// The header introduces the widget and renders a stylised anatomy diagram of
// a CircleAvatar drawn with concentric Containers/BoxDecorations. The goal
// is to call out the parts of the API (background, foreground, child) before
// the reader scrolls into the demos.
// ---------------------------------------------------------------------------

Widget _buildHeaderCard() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 18,
          offset: Offset(0, 6),
        ),
      ],
      border: Border.all(color: const Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'CircleAvatar — visual reference',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'CircleAvatar is a flat, circular Material widget intended to represent '
          'a person, a place or a piece of content. It exposes three primary knobs: '
          'backgroundColor (the disc), foregroundColor (text/icon tint), and a '
          'child widget that is centred inside the circle. Size is controlled via '
          'a single radius or a (minRadius, maxRadius) constraint pair.',
          style: TextStyle(
            fontSize: 14,
            height: 1.45,
            color: Color(0xFF424242),
          ),
        ),
        const SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _anatomyDiagram(),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _anatomyRow(
                    const Color(0xFFEDE7F6),
                    'Outer halo',
                    'optional shadow/ring drawn by parent',
                  ),
                  const SizedBox(height: 8),
                  _anatomyRow(
                    const Color(0xFF7E57C2),
                    'Background disc',
                    'backgroundColor or backgroundImage',
                  ),
                  const SizedBox(height: 8),
                  _anatomyRow(
                    const Color(0xFFD1C4E9),
                    'Foreground tint',
                    'foregroundColor — applies to child',
                  ),
                  const SizedBox(height: 8),
                  _anatomyRow(
                    const Color(0xFF311B92),
                    'Child',
                    'usually Text initials or an Icon',
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        const Text(
          'The diagram on the left is hand-drawn using nested Containers with '
          'BoxDecoration; the real CircleAvatar widget is rendered later. Both '
          'flavours appear side-by-side in the radius family section below.',
          style: TextStyle(
            fontSize: 12,
            fontStyle: FontStyle.italic,
            color: Color(0xFF616161),
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyDiagram() {
  return Container(
    width: 140,
    height: 140,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: const Color(0xFFEDE7F6),
      shape: BoxShape.circle,
    ),
    child: Container(
      width: 116,
      height: 116,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color(0xFF7E57C2),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Container(
        width: 86,
        height: 86,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Color(0xFFD1C4E9),
          shape: BoxShape.circle,
        ),
        child: Container(
          width: 56,
          height: 56,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color(0xFF311B92),
            shape: BoxShape.circle,
          ),
          child: const Text(
            'CA',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _anatomyRow(Color swatch, String label, String note) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 14,
        height: 14,
        margin: const EdgeInsets.only(top: 3, right: 10),
        decoration: BoxDecoration(
          color: swatch,
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF9E9E9E)),
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A1A),
              ),
            ),
            Text(
              note,
              style: const TextStyle(fontSize: 12, color: Color(0xFF616161)),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 2 — Radius family
// ---------------------------------------------------------------------------
// CircleAvatar exposes a single radius parameter in logical pixels. The
// diameter on screen is therefore 2 * radius. Material defaults to 20.
// This section lines up six avatars in a row and labels each with its
// declared radius value so the relative scale is obvious at a glance.
// ---------------------------------------------------------------------------

Widget _buildRadiusFamily() {
  final radii = <double>[12, 18, 24, 32, 44, 60];
  final palette = <Color>[
    Color(0xFFEF5350),
    Color(0xFFFF9800),
    Color(0xFFFFC107),
    Color(0xFF66BB6A),
    Color(0xFF26C6DA),
    Color(0xFF5C6BC0),
  ];

  final items = <Widget>[];
  for (int i = 0; i < radii.length; i++) {
    items.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: radii[i],
              backgroundColor: palette[i],
              child: Text(
                'R${radii[i].toInt()}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: radii[i] * 0.35,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'radius: ${radii[i].toInt()}',
              style: const TextStyle(fontSize: 11, color: Color(0xFF424242)),
            ),
            Text(
              'Ø ${(radii[i] * 2).toInt()} px',
              style: const TextStyle(fontSize: 10, color: Color(0xFF9E9E9E)),
            ),
          ],
        ),
      ),
    );
  }

  return _sectionShell(
    title: 'Radius family',
    blurb:
        'The same CircleAvatar at six discrete radius values. Notice how the '
        'child text scales proportionally — we set the fontSize to a fraction '
        'of the radius so initials remain legible regardless of the disc size. '
        'Material list tiles default to roughly radius 20.',
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: items,
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 3 — Initials gallery with deterministic colour-from-hash
// ---------------------------------------------------------------------------
// A common product pattern: derive a stable background colour for a user
// based on a hash of their name. This guarantees a given user always renders
// with the same colour without needing server state. We use a tiny hash and
// modulo into a curated palette of pleasant material 500-level swatches.
// ---------------------------------------------------------------------------

Widget _buildInitialsGallery() {
  final names = <String>[
    'Ada Lovelace',
    'Grace Hopper',
    'Alan Turing',
    'Linus Torvalds',
    'Margaret Hamilton',
    'Brian Kernighan',
    'Dennis Ritchie',
    'Barbara Liskov',
    'Edsger Dijkstra',
    'Donald Knuth',
    'John von Neumann',
    'Tim Berners-Lee',
    'Vint Cerf',
    'Ken Thompson',
    'Bjarne Stroustrup',
    'Guido van Rossum',
    'Anders Hejlsberg',
    'James Gosling',
    'Yukihiro Matsumoto',
    'Rasmus Lerdorf',
    'Joe Armstrong',
    'Rich Hickey',
  ];

  final palette = <Color>[
    Color(0xFFE53935),
    Color(0xFFD81B60),
    Color(0xFF8E24AA),
    Color(0xFF5E35B1),
    Color(0xFF3949AB),
    Color(0xFF1E88E5),
    Color(0xFF039BE5),
    Color(0xFF00ACC1),
    Color(0xFF00897B),
    Color(0xFF43A047),
    Color(0xFF7CB342),
    Color(0xFFC0CA33),
    Color(0xFFFDD835),
    Color(0xFFFFB300),
    Color(0xFFFB8C00),
    Color(0xFFF4511E),
    Color(0xFF6D4C41),
    Color(0xFF546E7A),
  ];

  final chips = <Widget>[];
  for (int i = 0; i < names.length; i++) {
    final name = names[i];
    final initials = _initialsOf(name);
    final color = palette[_stableHash(name) % palette.length];
    chips.add(
      Container(
        width: 130,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFEEEEEE)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: color,
              child: Text(
                initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name.split(' ').first,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF212121),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'hash ${_stableHash(name)}',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF9E9E9E),
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

  return _sectionShell(
    title: 'Initials gallery — deterministic colour-from-hash',
    blurb:
        'Each chip shows a CircleAvatar whose background colour is derived '
        'from a small stable hash of the user name modulo a curated palette. '
        'Because the function is pure, the same user always renders with the '
        'same colour across sessions and devices — useful for recognisability '
        'when avatar imagery is not available.',
    child: Wrap(spacing: 10, runSpacing: 10, children: chips),
  );
}

// ---------------------------------------------------------------------------
// SECTION 4 — Status overlays
// ---------------------------------------------------------------------------
// Presence badges (online/away/busy/offline) are conventionally drawn as a
// small disc anchored to the bottom-right of the avatar. We compose them as
// a Stack with the badge positioned via the Positioned widget. The badge has
// a white ring so it visually separates from the avatar background.
// ---------------------------------------------------------------------------

Widget _buildStatusOverlays() {
  final entries = <Map<String, Object>>[
    {
      'name': 'Lina',
      'initials': 'LK',
      'avatarColor': const Color(0xFF1E88E5),
      'status': 'online',
      'statusColor': const Color(0xFF43A047),
      'desc': 'green dot — actively connected',
    },
    {
      'name': 'Mateo',
      'initials': 'MR',
      'avatarColor': const Color(0xFF8E24AA),
      'status': 'away',
      'statusColor': const Color(0xFFFFB300),
      'desc': 'amber dot — idle for >5 min',
    },
    {
      'name': 'Priya',
      'initials': 'PS',
      'avatarColor': const Color(0xFFD81B60),
      'status': 'busy',
      'statusColor': const Color(0xFFE53935),
      'desc': 'red dot — do-not-disturb',
    },
    {
      'name': 'Hugo',
      'initials': 'HV',
      'avatarColor': const Color(0xFF546E7A),
      'status': 'offline',
      'statusColor': const Color(0xFFBDBDBD),
      'desc': 'grey ring — not currently signed in',
    },
    {
      'name': 'Eun',
      'initials': 'EJ',
      'avatarColor': const Color(0xFF00897B),
      'status': 'in call',
      'statusColor': const Color(0xFF7E57C2),
      'desc': 'purple dot — on a live voice call',
    },
  ];

  final tiles = <Widget>[];
  for (final entry in entries) {
    final statusColor = entry['statusColor'] as Color;
    final isOffline = entry['status'] == 'offline';
    tiles.add(
      Container(
        width: 150,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFEEEEEE)),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: entry['avatarColor'] as Color,
                  child: Text(
                    entry['initials'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: isOffline ? Colors.transparent : statusColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.5),
                      boxShadow: isOffline
                          ? null
                          : const [
                              BoxShadow(
                                color: Color(0x33000000),
                                blurRadius: 2,
                                offset: Offset(0, 1),
                              ),
                            ],
                    ),
                    child: isOffline
                        ? Container(
                            margin: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: statusColor,
                                width: 1.5,
                              ),
                              shape: BoxShape.circle,
                            ),
                          )
                        : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              entry['name'] as String,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF212121),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              entry['status'] as String,
              style: TextStyle(
                fontSize: 11,
                color: statusColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              entry['desc'] as String,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, color: Color(0xFF757575)),
            ),
          ],
        ),
      ),
    );
  }

  return _sectionShell(
    title: 'Status overlays (presence dots)',
    blurb:
        'A CircleAvatar wrapped in a Stack with a Positioned presence dot in '
        'the bottom-right corner. The 2.5-px white border on the dot prevents '
        'it from visually merging with the avatar background; the offline '
        'variant uses a hollow ring instead of a filled disc to read as "inactive" '
        'without screaming for attention.',
    child: Wrap(spacing: 12, runSpacing: 12, children: tiles),
  );
}

// ---------------------------------------------------------------------------
// SECTION 5 — Group-call grid
// ---------------------------------------------------------------------------
// A 3x3 grid of CircleAvatars overlapping with thick white borders, as you
// might see in a video conferencing thumbnail strip. Borders are drawn on
// the surrounding Container so we can keep the CircleAvatar itself clean.
// ---------------------------------------------------------------------------

Widget _buildGroupCallGrid() {
  final participants = <Map<String, Object>>[
    {'i': 'AB', 'c': const Color(0xFFE53935), 'speaking': true},
    {'i': 'CD', 'c': const Color(0xFFFB8C00), 'speaking': false},
    {'i': 'EF', 'c': const Color(0xFF43A047), 'speaking': false},
    {'i': 'GH', 'c': const Color(0xFF1E88E5), 'speaking': true},
    {'i': 'IJ', 'c': const Color(0xFF8E24AA), 'speaking': false},
    {'i': 'KL', 'c': const Color(0xFF00897B), 'speaking': false},
    {'i': 'MN', 'c': const Color(0xFFD81B60), 'speaking': false},
    {'i': 'OP', 'c': const Color(0xFF3949AB), 'speaking': true},
    {'i': 'QR', 'c': const Color(0xFF6D4C41), 'speaking': false},
  ];

  final rows = <Widget>[];
  for (int r = 0; r < 3; r++) {
    final cols = <Widget>[];
    for (int c = 0; c < 3; c++) {
      final p = participants[r * 3 + c];
      final speaking = p['speaking'] as bool;
      cols.add(
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: speaking ? const Color(0xFF66BB6A) : Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: speaking
                    ? const Color(0x6643A047)
                    : const Color(0x22000000),
                blurRadius: speaking ? 14 : 6,
                spreadRadius: speaking ? 1 : 0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 28,
            backgroundColor: p['c'] as Color,
            child: Text(
              p['i'] as String,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
        ),
      );
      if (c < 2) cols.add(const SizedBox(width: 8));
    }
    rows.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: cols));
    if (r < 2) rows.add(const SizedBox(height: 8));
  }

  return _sectionShell(
    title: 'Group-call thumbnail grid',
    blurb:
        'Nine CircleAvatars arranged 3x3, each wrapped in a Container whose '
        'BoxDecoration paints a ring. The currently-speaking participants get '
        'a saturated green ring with a soft outer glow; everyone else gets a '
        'plain white separator ring. Mixing decoration on the wrapper instead '
        'of on the avatar keeps the avatar widget tree small.',
    child: Column(children: rows),
  );
}

// ---------------------------------------------------------------------------
// SECTION 6 — Comment thread row layout
// ---------------------------------------------------------------------------
// A common forum/comment UX: a CircleAvatar acts as the leading element of a
// row, followed by the author name and a timestamp, with the comment body
// wrapping under both. This section demonstrates how the avatar grounds a
// dense block of typography.
// ---------------------------------------------------------------------------

Widget _buildCommentThread() {
  final comments = <Map<String, Object>>[
    {
      'name': 'Ada Lovelace',
      'initials': 'AL',
      'color': const Color(0xFFD81B60),
      'when': '2 minutes ago',
      'body':
          'The CircleAvatar is just a Material disc; you can drop literally '
          'any widget inside the child slot. I usually keep it to short '
          'initials or a single Icon — anything longer and you lose the '
          'glanceability that makes avatars useful in the first place.',
    },
    {
      'name': 'Linus Torvalds',
      'initials': 'LT',
      'color': const Color(0xFF1E88E5),
      'when': '17 minutes ago',
      'body':
          'Worth noting that backgroundImage is the official path for photo '
          'avatars but in tests you usually want to swap it for a flat '
          'colour to keep golden files stable across machines.',
    },
    {
      'name': 'Grace Hopper',
      'initials': 'GH',
      'color': const Color(0xFF00897B),
      'when': '34 minutes ago',
      'body':
          'For very long names where two-letter initials collide (think '
          '"Anders Hejlsberg" and "Alex Hopkins"), salt the hash with a '
          'stable user id so each person still gets a distinct colour.',
    },
    {
      'name': 'Margaret Hamilton',
      'initials': 'MH',
      'color': const Color(0xFF8E24AA),
      'when': '1 hour ago',
      'body':
          'Don\'t forget Semantics — a bare CircleAvatar carries no label, '
          'so screen readers will announce nothing useful. Wrap it in a '
          'Semantics widget or pair it with a text label that the avatar '
          'simply repeats visually.',
    },
  ];

  final rows = <Widget>[];
  for (int i = 0; i < comments.length; i++) {
    final c = comments[i];
    rows.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: c['color'] as Color,
              child: Text(
                c['initials'] as String,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        c['name'] as String,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF212121),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '· ${c['when']}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9E9E9E),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    c['body'] as String,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.45,
                      color: Color(0xFF424242),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    if (i < comments.length - 1) {
      rows.add(Container(height: 1, color: const Color(0xFFEEEEEE)));
    }
  }

  return _sectionShell(
    title: 'Comment thread row layout',
    blurb:
        'Each row pairs a single CircleAvatar with a name, a timestamp and a '
        'multi-line body. The avatar sits at top-left and lets the body wrap '
        'beneath the metadata without indentation — a classic forum / pull '
        'request layout. The radius of 22 is calibrated so the avatar exactly '
        'matches the combined height of the name + timestamp line.',
    child: Column(children: rows),
  );
}

// ---------------------------------------------------------------------------
// SECTION 7 — Gradient frames (SweepGradient ring)
// ---------------------------------------------------------------------------
// A CircleAvatar surrounded by a SweepGradient halo. Useful for "story" rings
// or to highlight an avatar without changing the avatar itself. The trick is
// to draw the gradient on the outer Container and use padding to leave a tiny
// white gap before the inner avatar — that gap is what makes the ring read.
// ---------------------------------------------------------------------------

Widget _buildGradientFrames() {
  final frames = <Widget>[
    _gradientFrame(
      label: 'Sweep — rainbow',
      initials: 'RA',
      avatarColor: const Color(0xFF263238),
      gradient: const SweepGradient(
        colors: [
          Color(0xFFE53935),
          Color(0xFFFB8C00),
          Color(0xFFFDD835),
          Color(0xFF43A047),
          Color(0xFF1E88E5),
          Color(0xFF8E24AA),
          Color(0xFFE53935),
        ],
      ),
    ),
    _gradientFrame(
      label: 'Sweep — ocean',
      initials: 'OC',
      avatarColor: const Color(0xFF004D40),
      gradient: const SweepGradient(
        colors: [
          Color(0xFF00BCD4),
          Color(0xFF26C6DA),
          Color(0xFF80DEEA),
          Color(0xFF26C6DA),
          Color(0xFF00BCD4),
        ],
      ),
    ),
    _gradientFrame(
      label: 'Linear — sunset',
      initials: 'SU',
      avatarColor: const Color(0xFF4A148C),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFFF6F00),
          Color(0xFFD81B60),
          Color(0xFF6A1B9A),
        ],
      ),
    ),
    _gradientFrame(
      label: 'Radial — focus',
      initials: 'FO',
      avatarColor: const Color(0xFF1A1A1A),
      gradient: const RadialGradient(
        colors: [
          Color(0xFFFFEB3B),
          Color(0xFFFB8C00),
          Color(0xFFE53935),
        ],
        radius: 0.8,
      ),
    ),
  ];

  return _sectionShell(
    title: 'Gradient frames',
    blurb:
        'A CircleAvatar wrapped in a Container whose BoxDecoration paints a '
        'gradient ring. The outer container is a circle, the inner padding is '
        'a thin band of white, and the avatar lives at the centre. SweepGradient '
        'is conventional for "story" indicators; LinearGradient and RadialGradient '
        'are useful for theming and for callouts respectively.',
    child: Wrap(
      spacing: 18,
      runSpacing: 18,
      alignment: WrapAlignment.start,
      children: frames,
    ),
  );
}

Widget _gradientFrame({
  required String label,
  required String initials,
  required Color avatarColor,
  required Gradient gradient,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          gradient: gradient,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            radius: 32,
            backgroundColor: avatarColor,
            child: Text(
              initials,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 8),
      Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          color: Color(0xFF424242),
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 8 — Stacked overlap (LinkedIn-style "+N more")
// ---------------------------------------------------------------------------
// Build a horizontal list of avatars that visually overlap by giving each
// successive avatar a negative left margin via Positioned inside a Stack.
// The final element is a neutral grey avatar with a "+N" label representing
// the remaining participants.
// ---------------------------------------------------------------------------

Widget _buildStackedOverlap() {
  final visible = <Map<String, Object>>[
    {'i': 'AL', 'c': const Color(0xFFE53935)},
    {'i': 'GH', 'c': const Color(0xFF00897B)},
    {'i': 'LT', 'c': const Color(0xFF1E88E5)},
    {'i': 'MH', 'c': const Color(0xFF8E24AA)},
    {'i': 'DK', 'c': const Color(0xFFFB8C00)},
  ];

  final stackChildren = <Widget>[];
  const double overlap = 18;
  for (int i = 0; i < visible.length; i++) {
    final p = visible[i];
    stackChildren.add(
      Positioned(
        left: i * (40 - overlap),
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            radius: 18,
            backgroundColor: p['c'] as Color,
            child: Text(
              p['i'] as String,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
  stackChildren.add(
    Positioned(
      left: visible.length * (40 - overlap),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: const CircleAvatar(
          radius: 18,
          backgroundColor: Color(0xFFEEEEEE),
          child: Text(
            '+12',
            style: TextStyle(
              color: Color(0xFF424242),
              fontWeight: FontWeight.w700,
              fontSize: 11,
            ),
          ),
        ),
      ),
    ),
  );

  // A second variant: larger avatars overlapping more aggressively.
  final tightChildren = <Widget>[];
  final tight = <Map<String, Object>>[
    {'i': 'JV', 'c': const Color(0xFF3949AB)},
    {'i': 'KR', 'c': const Color(0xFFD81B60)},
    {'i': 'NO', 'c': const Color(0xFF00ACC1)},
  ];
  for (int i = 0; i < tight.length; i++) {
    final p = tight[i];
    tightChildren.add(
      Positioned(
        left: i * 32.0,
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            radius: 26,
            backgroundColor: p['c'] as Color,
            child: Text(
              p['i'] as String,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  return _sectionShell(
    title: 'Stacked overlap — "+N more"',
    blurb:
        'A horizontal Stack with each avatar positioned at a calculated x '
        'offset so the discs partially overlap. Each avatar is wrapped in a '
        'thin white ring (via padded Container) so the overlap reads cleanly. '
        'The trailing neutral chip shows the count of participants not pictured.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Compact (radius 18, overlap 18)',
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF616161),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 44,
          width: (visible.length + 1) * (40 - overlap) + 40,
          child: Stack(children: stackChildren),
        ),
        const SizedBox(height: 16),
        const Text(
          'Roomy (radius 26, overlap 24)',
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF616161),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 60,
          width: tight.length * 32.0 + 60,
          child: Stack(children: tightChildren),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 9 — Foreground icons
// ---------------------------------------------------------------------------
// Demonstrates eight different Icon children inside a CircleAvatar, each
// labelled with the corresponding semantic role. Iconography is a common
// alternative to initials when the avatar represents a non-human entity:
// a camera shutter, a locked record, a verified badge, etc.
// ---------------------------------------------------------------------------

Widget _buildForegroundIcons() {
  final icons = <Map<String, Object>>[
    {
      'icon': Icons.photo_camera,
      'bg': const Color(0xFF1E88E5),
      'label': 'camera',
      'desc': 'photo upload entry-point',
    },
    {
      'icon': Icons.lock,
      'bg': const Color(0xFF6D4C41),
      'label': 'lock',
      'desc': 'private / restricted record',
    },
    {
      'icon': Icons.verified,
      'bg': const Color(0xFF43A047),
      'label': 'verified',
      'desc': 'identity-confirmed account',
    },
    {
      'icon': Icons.add,
      'bg': const Color(0xFF8E24AA),
      'label': 'add',
      'desc': 'create new contact',
    },
    {
      'icon': Icons.notifications,
      'bg': const Color(0xFFFB8C00),
      'label': 'notify',
      'desc': 'system / app notification',
    },
    {
      'icon': Icons.flag,
      'bg': const Color(0xFFE53935),
      'label': 'flag',
      'desc': 'reported / flagged item',
    },
    {
      'icon': Icons.public,
      'bg': const Color(0xFF00897B),
      'label': 'public',
      'desc': 'globe / shared entity',
    },
    {
      'icon': Icons.bolt,
      'bg': const Color(0xFFFDD835),
      'label': 'spark',
      'desc': 'automation trigger',
    },
  ];

  final tiles = <Widget>[];
  for (final entry in icons) {
    tiles.add(
      Container(
        width: 130,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFEEEEEE)),
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: entry['bg'] as Color,
              foregroundColor: Colors.white,
              child: Icon(
                entry['icon'] as IconData,
                size: 22,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              entry['label'] as String,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF212121),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              entry['desc'] as String,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF757575),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return _sectionShell(
    title: 'Foreground icons inside CircleAvatar',
    blurb:
        'When the avatar represents an action or a non-human entity, an Icon '
        'is a better child than initials. foregroundColor is honoured by '
        'IconTheme inside the avatar, but we also pass color directly for '
        'safety on platforms where ambient theming may not reach the icon.',
    child: Wrap(spacing: 12, runSpacing: 12, children: tiles),
  );
}

// ---------------------------------------------------------------------------
// SECTION 10 — Edge cases
// ---------------------------------------------------------------------------
// The (minRadius, maxRadius) pair allows the avatar to grow within its
// constraints. We show:
//   * minRadius == maxRadius — equivalent to a fixed radius
//   * very small (radius 8) — barely-readable, useful for dense lists
//   * very large (radius 80) — full bleed hero avatar
//   * minRadius with no maxRadius — grows to fit the parent
//   * maxRadius with no minRadius — collapses to a small disc
// ---------------------------------------------------------------------------

Widget _buildEdgeCases() {
  return _sectionShell(
    title: 'Edge cases',
    blurb:
        'CircleAvatar is mostly used with a single radius, but the (minRadius, '
        'maxRadius) pair is useful when the parent imposes constraints. The '
        'examples below probe the boundaries: tiny, huge, fixed via min==max, '
        'and stretchy via min-only / max-only.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              children: [
                const CircleAvatar(
                  radius: 8,
                  backgroundColor: Color(0xFF1E88E5),
                  child: Text(
                    'x',
                    style: TextStyle(color: Colors.white, fontSize: 8),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'radius: 8',
                  style: TextStyle(fontSize: 10, color: Color(0xFF616161)),
                ),
              ],
            ),
            const SizedBox(width: 24),
            Column(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xFF8E24AA),
                  child: Text(
                    'MM',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'min=20 max=20',
                  style: TextStyle(fontSize: 10, color: Color(0xFF616161)),
                ),
              ],
            ),
            const SizedBox(width: 24),
            Column(
              children: [
                CircleAvatar(
                  minRadius: 32,
                  maxRadius: 32,
                  backgroundColor: const Color(0xFF00897B),
                  child: const Text(
                    'min=max',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'min=32 max=32',
                  style: TextStyle(fontSize: 10, color: Color(0xFF616161)),
                ),
              ],
            ),
            const SizedBox(width: 24),
            Column(
              children: [
                const CircleAvatar(
                  radius: 56,
                  backgroundColor: Color(0xFFD81B60),
                  child: Text(
                    'HUGE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'radius: 56',
                  style: TextStyle(fontSize: 10, color: Color(0xFF616161)),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 22),
        const Text(
          'Constrained variants',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF212121),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              children: [
                SizedBox(
                  width: 64,
                  height: 64,
                  child: Center(
                    child: CircleAvatar(
                      minRadius: 8,
                      backgroundColor: const Color(0xFF3949AB),
                      child: const Text(
                        'min',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'min=8 (grows to fit)',
                  style: TextStyle(fontSize: 10, color: Color(0xFF616161)),
                ),
              ],
            ),
            const SizedBox(width: 24),
            Column(
              children: [
                SizedBox(
                  width: 64,
                  height: 64,
                  child: Center(
                    child: CircleAvatar(
                      maxRadius: 18,
                      backgroundColor: const Color(0xFF6D4C41),
                      child: const Text(
                        'max',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'max=18 (capped)',
                  style: TextStyle(fontSize: 10, color: Color(0xFF616161)),
                ),
              ],
            ),
            const SizedBox(width: 24),
            Column(
              children: [
                SizedBox(
                  width: 96,
                  height: 96,
                  child: Center(
                    child: CircleAvatar(
                      minRadius: 24,
                      maxRadius: 48,
                      backgroundColor: const Color(0xFF00ACC1),
                      child: const Text(
                        '24–48',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'min=24 max=48',
                  style: TextStyle(fontSize: 10, color: Color(0xFF616161)),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'When only minRadius is set, the avatar will grow up to the parent '
          'constraint; when only maxRadius is set, it shrinks to fit. When '
          'both are set, the avatar lerps between them and renders at the '
          'largest size the parent permits. Setting radius is shorthand for '
          'min==max.',
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF424242),
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Footer note — concise summary and pointers
// ---------------------------------------------------------------------------

Widget _buildFooterNote() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: const Color(0xFFE8EAF6),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFFC5CAE9)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Summary',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A237E),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'CircleAvatar is small in surface area but dense in idiom. The same '
          'widget reads as a contact chip, a presence indicator, a story ring, '
          'a notification glyph, or a participant tile depending only on its '
          'wrapping. Master the radius, foreground/background pair, and the '
          'Stack-with-Positioned overlay pattern, and almost every avatar UI '
          'you will ever need falls out naturally.',
          style: TextStyle(
            fontSize: 13,
            height: 1.5,
            color: Color(0xFF283593),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Shared shell for each section. Kept minimal on purpose so it does not bleed
// styling decisions into the demos themselves.
// ---------------------------------------------------------------------------

Widget _sectionShell({
  required String title,
  required String blurb,
  required Widget child,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFFE0E0E0)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x0D000000),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          blurb,
          style: const TextStyle(
            fontSize: 13,
            height: 1.45,
            color: Color(0xFF424242),
          ),
        ),
        const SizedBox(height: 18),
        child,
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Pure utility helpers used by the initials gallery.
// ---------------------------------------------------------------------------

String _initialsOf(String fullName) {
  final parts = fullName.split(' ');
  if (parts.isEmpty) return '?';
  if (parts.length == 1) {
    final p = parts.first;
    return p.isEmpty ? '?' : p.substring(0, 1).toUpperCase();
  }
  final first = parts.first;
  final last = parts.last;
  final f = first.isEmpty ? '' : first.substring(0, 1).toUpperCase();
  final l = last.isEmpty ? '' : last.substring(0, 1).toUpperCase();
  return '$f$l';
}

int _stableHash(String s) {
  // A tiny FNV-1a-ish hash. Deterministic across runs, no external deps.
  int hash = 2166136261;
  for (int i = 0; i < s.length; i++) {
    hash = (hash ^ s.codeUnitAt(i)) & 0x7FFFFFFF;
    hash = (hash * 16777619) & 0x7FFFFFFF;
  }
  return hash;
}
