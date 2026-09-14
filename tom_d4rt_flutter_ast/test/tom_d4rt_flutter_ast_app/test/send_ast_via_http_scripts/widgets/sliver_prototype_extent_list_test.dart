// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SliverPrototypeExtentList
// Demonstrates SliverPrototypeExtentList — a sliver list that determines each
// item's extent from a single prototype widget rather than a fixed pixel value
// or measuring every child. More efficient than SliverList (which measures each
// child individually) and more flexible than SliverFixedExtentList (which
// requires a hardcoded pixel value). The prototype is laid out once; its extent
// is then used for every child in the list.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverPrototypeExtentList Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.straighten,
      'title': 'What Is SliverPrototypeExtentList?',
      'body': 'SliverPrototypeExtentList is a sliver that displays a list '
          'of children, all constrained to have the same extent in the main '
          'axis. That extent is determined by laying out a single "prototype" '
          'widget — you provide one representative child and the framework '
          'uses its measured extent for all items in the list.',
      'accent': Colors.deepOrange,
    },
    {
      'icon': Icons.speed,
      'title': 'Performance Advantage',
      'body': 'Because every child has the same extent, the sliver can '
          'calculate which children are visible without measuring each one. '
          'This is the same optimization as SliverFixedExtentList, but '
          'instead of guessing a pixel value, you provide a real widget '
          'that is measured once.',
      'accent': Colors.green,
    },
    {
      'icon': Icons.compare_arrows,
      'title': 'Prototype vs Fixed Extent',
      'body': 'SliverFixedExtentList(itemExtent: 72) hardcodes the height. '
          'If your items have dynamic content (fonts, padding, themes), '
          'a hardcoded value may be wrong. SliverPrototypeExtentList lets '
          'the framework measure a representative widget to get the '
          'exact right value automatically.',
      'accent': Colors.indigo,
    },
    {
      'icon': Icons.widgets,
      'title': 'When To Use',
      'body': 'Use SliverPrototypeExtentList when all items should have '
          'the same height (or width in a horizontal list), but that height '
          'depends on theme, text scale, or other runtime factors. If the '
          'height is truly constant, SliverFixedExtentList is slightly '
          'faster. If items have varying heights, use SliverList.',
      'accent': Colors.purple,
    },
  ];

  final conceptCards = <Widget>[];
  for (var idx = 0; idx < conceptItems.length; idx++) {
    final e = conceptItems[idx];
    final accent = e['accent'] as Color;
    print('Concept ${idx + 1}: ${e['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accent.withOpacity(0.12), accent.withOpacity(0.04)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: accent.withOpacity(0.3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(e['icon'] as IconData, color: accent, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      e['body'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade800,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 2: Constructor
  // ============================================================
  print('=== Section 2: Constructor ===');

  final constructorRows = <Map<String, String>>[
    {
      'param': 'prototypeItem',
      'type': 'Widget',
      'desc': 'Required. A widget that will be laid out once to determine '
          'the extent (height in a vertical list, width in a horizontal list) '
          'of every child. It is not visible in the list — it is measured '
          'offscreen.',
    },
    {
      'param': 'delegate',
      'type': 'SliverChildDelegate',
      'desc': 'Required. Provides the actual children for the list. '
          'Typically a SliverChildBuilderDelegate or SliverChildListDelegate. '
          'Each child is constrained to the prototype extent.',
    },
    {
      'param': 'key',
      'type': 'Key?',
      'desc': 'Optional widget key for identification.',
    },
  ];

  final constructorWidgets = <Widget>[];
  for (var i = 0; i < constructorRows.length; i++) {
    final row = constructorRows[i];
    print('Constructor ${i + 1}: ${row['param']}');
    constructorWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.deepOrange.withOpacity(0.06)
              : Colors.grey.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.deepOrange.withOpacity(0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    row['param']!,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    row['type']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              row['desc']!,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: Basic prototype list
  // ============================================================
  print('=== Section 3: Basic prototype ===');

  // Simple list with a ListTile prototype
  final basicProto = SizedBox(
    height: 420,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: const Text('Basic Prototype'),
          backgroundColor: Colors.deepOrange.shade600,
          pinned: true,
        ),
        SliverPrototypeExtentList(
          prototypeItem: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepOrange.shade100,
              child: const Icon(Icons.person, color: Colors.deepOrange),
            ),
            title: const Text('Prototype Contact'),
            subtitle: const Text('This measures the height'),
            trailing: const Icon(Icons.chevron_right),
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext ctx, int index) {
              final names = [
                'Alice',
                'Bob',
                'Charlie',
                'Diana',
                'Eve',
                'Frank',
                'Grace',
                'Hector',
                'Ivy',
                'Jack',
                'Karen',
                'Leo',
                'Mona',
                'Nick',
                'Olivia',
              ];
              final departments = [
                'Engineering',
                'Design',
                'Marketing',
                'Sales',
                'Support',
              ];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.deepOrange.shade100,
                  child: Text(
                    names[index % names.length][0],
                    style: const TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(names[index % names.length]),
                subtitle: Text(departments[index % departments.length]),
                trailing: const Icon(Icons.chevron_right),
              );
            },
            childCount: 30,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Card-style prototype
  // ============================================================
  print('=== Section 4: Card prototype ===');

  // Prototype: a card with icon, title, subtitle and action
  final cardPrototype = Card(
    margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
    elevation: 1,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.deepOrange.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.music_note, color: Colors.deepOrange),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Prototype Song Title',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(height: 3),
                Text(
                  'Prototype Artist — Prototype Album',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          const Icon(Icons.play_arrow, color: Colors.deepOrange),
        ],
      ),
    ),
  );

  final songs = <Map<String, String>>[
    {'title': 'Bohemian Rhapsody', 'artist': 'Queen', 'album': 'A Night at the Opera'},
    {'title': 'Hotel California', 'artist': 'Eagles', 'album': 'Hotel California'},
    {'title': 'Stairway to Heaven', 'artist': 'Led Zeppelin', 'album': 'Led Zeppelin IV'},
    {'title': 'Imagine', 'artist': 'John Lennon', 'album': 'Imagine'},
    {'title': 'Purple Rain', 'artist': 'Prince', 'album': 'Purple Rain'},
    {'title': 'Smells Like Teen Spirit', 'artist': 'Nirvana', 'album': 'Nevermind'},
    {'title': 'Like a Rolling Stone', 'artist': 'Bob Dylan', 'album': 'Highway 61'},
    {'title': 'Respect', 'artist': 'Aretha Franklin', 'album': 'I Never Loved a Man'},
    {'title': 'What\'s Going On', 'artist': 'Marvin Gaye', 'album': 'What\'s Going On'},
    {'title': 'Billie Jean', 'artist': 'Michael Jackson', 'album': 'Thriller'},
    {'title': 'Hey Jude', 'artist': 'The Beatles', 'album': 'Single'},
    {'title': 'Born to Run', 'artist': 'Bruce Springsteen', 'album': 'Born to Run'},
    {'title': 'Kashmir', 'artist': 'Led Zeppelin', 'album': 'Physical Graffiti'},
    {'title': 'Superstition', 'artist': 'Stevie Wonder', 'album': 'Talking Book'},
    {'title': 'Waterloo Sunset', 'artist': 'The Kinks', 'album': 'Something Else'},
  ];

  final songIcons = [
    Icons.music_note,
    Icons.album,
    Icons.headphones,
    Icons.queue_music,
    Icons.audiotrack,
  ];

  final cardProtoDemo = SizedBox(
    height: 460,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: const Text('Music Library'),
          backgroundColor: Colors.deepOrange.shade700,
          pinned: true,
          expandedHeight: 100,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepOrange.shade900, Colors.orange.shade600],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        ),
        SliverPrototypeExtentList(
          prototypeItem: cardPrototype,
          delegate: SliverChildBuilderDelegate(
            (BuildContext ctx, int index) {
              final song = songs[index % songs.length];
              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 5,
                ),
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.deepOrange.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          songIcons[index % songIcons.length],
                          color: Colors.deepOrange,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              song['title']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '${song['artist']} — ${song['album']}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.play_arrow,
                        color: Colors.deepOrange,
                      ),
                    ],
                  ),
                ),
              );
            },
            childCount: 30,
          ),
        ),
      ],
    ),
  );

  print('Card prototype demo built with ${songs.length} songs');

  // ============================================================
  // SECTION 5: Variable content, same extent
  // ============================================================
  print('=== Section 5: Variable content ===');

  // Even though content differs, all items get the same height
  final variableItems = <Map<String, dynamic>>[
    {
      'title': 'Short name',
      'icon': Icons.text_fields,
      'color': Colors.blue,
    },
    {
      'title': 'A much longer product name that wraps',
      'icon': Icons.text_increase,
      'color': Colors.green,
    },
    {
      'title': 'Medium text',
      'icon': Icons.text_format,
      'color': Colors.orange,
    },
    {
      'title': 'A very verbose item name designed to test truncation limits',
      'icon': Icons.text_snippet,
      'color': Colors.purple,
    },
    {
      'title': 'Tiny',
      'icon': Icons.short_text,
      'color': Colors.red,
    },
  ];

  final variableContentNote = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.amber.withOpacity(0.08),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.amber.withOpacity(0.25)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.info_outline, color: Colors.amber.shade700, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            'All items below have the same height determined by the '
            'prototype, even though their text content varies in length. '
            'Longer text may be clipped or truncated but the item height '
            'remains constant — this is the whole point of prototype extent.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  // Prototype for variable-content demo
  final variableProto = Container(
    margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.widgets, color: Colors.grey),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Prototype Product Name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2),
              Text(
                'Category label',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  final variableDemo = SizedBox(
    height: 380,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: const Text('Variable Content'),
          backgroundColor: Colors.amber.shade700,
          pinned: true,
        ),
        SliverPrototypeExtentList(
          prototypeItem: variableProto,
          delegate: SliverChildBuilderDelegate(
            (BuildContext ctx, int index) {
              final item = variableItems[index % variableItems.length];
              final iColor = item['color'] as Color;
              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 4,
                ),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: iColor.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: iColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        item['icon'] as IconData,
                        color: iColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'All items same height from prototype',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            childCount: 20,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Comparison — Prototype vs Fixed vs List
  // ============================================================
  print('=== Section 6: Comparison ===');

  final comparisons = <Map<String, dynamic>>[
    {
      'name': 'SliverList',
      'icon': Icons.view_list,
      'color': Colors.blue,
      'extent': 'Each child measured individually',
      'perf': 'Slower — measures N children',
      'flex': 'Full — each child can vary in height',
      'use': 'Items with different heights',
    },
    {
      'name': 'SliverFixedExtentList',
      'icon': Icons.straighten,
      'color': Colors.green,
      'extent': 'Hardcoded pixel value (e.g. 56.0)',
      'perf': 'Fastest — no measurement at all',
      'flex': 'None — extent is a literal number',
      'use': 'Known, constant item height',
    },
    {
      'name': 'SliverPrototypeExtentList',
      'icon': Icons.widgets,
      'color': Colors.deepOrange,
      'extent': 'Measured from a prototype widget',
      'perf': 'Fast — measures 1 widget only',
      'flex': 'Medium — adapts to theme/text scale',
      'use': 'Uniform height but theme-dependent',
    },
  ];

  final comparisonCards = <Widget>[];
  for (var i = 0; i < comparisons.length; i++) {
    final comp = comparisons[i];
    final cColor = comp['color'] as Color;
    print('Comparison ${i + 1}: ${comp['name']}');
    comparisonCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: cColor.withOpacity(0.3),
            width: comp['name'] == 'SliverPrototypeExtentList' ? 2 : 1,
          ),
          color: cColor.withOpacity(0.03),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: cColor.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(11),
                  topRight: Radius.circular(11),
                ),
              ),
              child: Row(
                children: [
                  Icon(comp['icon'] as IconData, color: cColor, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    comp['name'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: cColor,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  _spelRefRow('Extent', comp['extent'] as String, cColor),
                  _spelRefRow('Performance', comp['perf'] as String, cColor),
                  _spelRefRow('Flexibility', comp['flex'] as String, cColor),
                  _spelRefRow('Use when', comp['use'] as String, cColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 7: Performance notes
  // ============================================================
  print('=== Section 7: Performance ===');

  final perfNotes = <Map<String, dynamic>>[
    {
      'title': 'O(1) Child Lookup',
      'body': 'Because every child has the same extent, the sliver can '
          'calculate which child is at a given scroll offset using simple '
          'division: index = offset / prototypeExtent. No need to measure '
          'or iterate through children.',
      'icon': Icons.flash_on,
      'color': Colors.amber,
    },
    {
      'title': 'Scroll-to-Index Precision',
      'body': 'Jumping to a specific index is exact: '
          'scrollOffset = index * prototypeExtent. There is no accumulation '
          'error from varying child heights.',
      'icon': Icons.gps_fixed,
      'color': Colors.blue,
    },
    {
      'title': 'Single Measurement Cost',
      'body': 'The prototype widget is laid out exactly once during the '
          'first build. Its extent is cached and reused. Changing the '
          'prototype triggers a single re-measurement.',
      'icon': Icons.looks_one,
      'color': Colors.green,
    },
    {
      'title': 'Responsive to Text Scale',
      'body': 'If the user changes the system text scale, the prototype '
          'is measured at the new scale and all items adjust automatically. '
          'A hardcoded itemExtent would not adapt.',
      'icon': Icons.text_increase,
      'color': Colors.purple,
    },
    {
      'title': 'Memory Efficiency',
      'body': 'Like SliverFixedExtentList, children outside the viewport '
          'are not built. The sliver knows exactly which indices are visible '
          'without building off-screen children.',
      'icon': Icons.memory,
      'color': Colors.teal,
    },
  ];

  final perfWidgets = <Widget>[];
  for (var i = 0; i < perfNotes.length; i++) {
    final note = perfNotes[i];
    final nColor = note['color'] as Color;
    print('Performance ${i + 1}: ${note['title']}');
    perfWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: nColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: nColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: nColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(note['icon'] as IconData, color: nColor, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note['title'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: nColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    note['body'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                      height: 1.4,
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
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.straighten,
      'text': 'SliverPrototypeExtentList uses a single prototype widget '
          'to determine the extent of every child in the list.',
    },
    {
      'icon': Icons.speed,
      'text': 'Same O(1) child lookup performance as SliverFixedExtentList, '
          'but the extent adapts to theme, text scale, and padding.',
    },
    {
      'icon': Icons.widgets,
      'text': 'The prototype is measured once and cached. It is not visible '
          'in the list — it only serves as a measurement reference.',
    },
    {
      'icon': Icons.compare,
      'text': 'Choose SliverList for varying heights, SliverFixedExtentList '
          'for known constant heights, prototype for uniform but dynamic.',
    },
    {
      'icon': Icons.text_increase,
      'text': 'Automatically adapts when system text scale changes, unlike '
          'a hardcoded itemExtent value.',
    },
    {
      'icon': Icons.flash_on,
      'text': 'Enables precise scroll-to-index and efficient viewport '
          'culling because every child has identical extent.',
    },
  ];

  final summaryWidgets = <Widget>[];
  for (var i = 0; i < summaryPoints.length; i++) {
    final sp = summaryPoints[i];
    print('Summary ${i + 1}: ${(sp['text'] as String).substring(0, 40)}...');
    summaryWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.deepOrange.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.deepOrange.withOpacity(0.12)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.deepOrange.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.deepOrange.shade700,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                sp['text'] as String,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade800,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ASSEMBLE TABBED LAYOUT
  // ============================================================
  print('Assembling tabbed layout');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('SliverPrototypeExtentList'),
        backgroundColor: Colors.deepOrange.shade700,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.construction), text: 'Constructor'),
            Tab(icon: Icon(Icons.list), text: 'Basic'),
            Tab(icon: Icon(Icons.album), text: 'Card Proto'),
            Tab(icon: Icon(Icons.text_fields), text: 'Variable'),
            Tab(icon: Icon(Icons.compare), text: 'Comparison'),
            Tab(icon: Icon(Icons.speed), text: 'Performance'),
            Tab(icon: Icon(Icons.summarize), text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1: Concept
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'SliverPrototypeExtentList determines item extent by '
                  'measuring a prototype widget once, then applying that '
                  'extent to every child. A middle ground between the '
                  'flexibility of SliverList and the speed of '
                  'SliverFixedExtentList.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),

          // Tab 2: Constructor
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Two required parameters: prototypeItem (the widget to '
                  'measure) and delegate (the children provider).',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...constructorWidgets,
            ],
          ),

          // Tab 3: Basic prototype
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'A contacts list where a ListTile prototype determines '
                  'the height of every item. Each contact gets the same '
                  'height regardless of name length.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: basicProto,
                ),
              ),
            ],
          ),

          // Tab 4: Card prototype
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'A music library with card-styled items. The prototype '
                  'is a Card with icon, title, subtitle, and play icon — '
                  'matching the structure of each real item.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: cardProtoDemo,
                ),
              ),
            ],
          ),

          // Tab 5: Variable content
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Items with different text lengths all get the same '
                  'height from the prototype. Content overflow is handled '
                  'with ellipsis.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              variableContentNote,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: variableDemo,
                ),
              ),
            ],
          ),

          // Tab 6: Comparison
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'How SliverPrototypeExtentList compares to SliverList '
                  'and SliverFixedExtentList:',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...comparisonCards,
            ],
          ),

          // Tab 7: Performance
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'The performance benefits of prototype-based extent '
                  'determination over per-child measurement.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...perfWidgets,
            ],
          ),

          // Tab 8: Summary
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.deepOrange.withOpacity(0.12),
                      Colors.orange.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key points about SliverPrototypeExtentList.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ...summaryWidgets,
            ],
          ),
        ],
      ),
    ),
  );
}

// ============================================================
// HELPER: Reference row for comparison table
// ============================================================
Widget _spelRefRow(String label, String value, Color accent) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: accent,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}
