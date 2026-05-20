// D4rt test script: Tests AnimatedGrid from widgets
// Deep Demo: Photo & Inventory management dashboard exercising AnimatedGrid,
// SliverAnimatedGrid, AnimatedGridState, GlobalKey<AnimatedGridState>,
// insertItem / insertAllItems / removeItem / removeAllItems, the
// itemBuilder, the removedItemBuilder, both SliverGridDelegate variants,
// initialItemCount and scrollDirection.
import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

// ===========================================================================
// ENTRY POINT
// ===========================================================================
dynamic build(BuildContext context) {
  debugPrint('AnimatedGrid Deep Demo executing');

  return Scaffold(
    backgroundColor: const Color(0xFFF6F4FB),
    appBar: AppBar(
      backgroundColor: const Color(0xFF2C2046),
      foregroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        'AnimatedGrid Dashboard',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _DashboardHeader(),
          SizedBox(height: 24.0),
          _SectionTitle(
            number: 1,
            title: 'What AnimatedGrid solves',
            accent: Color(0xFF6B4DBA),
          ),
          SizedBox(height: 12.0),
          _ExplanationCard(),
          SizedBox(height: 32.0),
          _SectionTitle(
            number: 2,
            title: 'Photo gallery — auto-cycling insert',
            accent: Color(0xFFE26D5C),
          ),
          SizedBox(height: 12.0),
          _PhotoGallerySection(),
          SizedBox(height: 32.0),
          _SectionTitle(
            number: 3,
            title: 'Inventory tiles — remove with fade + scale',
            accent: Color(0xFF2E8B79),
          ),
          SizedBox(height: 12.0),
          _InventorySection(),
          SizedBox(height: 32.0),
          _SectionTitle(
            number: 4,
            title: 'Card flip insert — RotationTransition',
            accent: Color(0xFFCB7B16),
          ),
          SizedBox(height: 12.0),
          _CardFlipSection(),
          SizedBox(height: 32.0),
          _SectionTitle(
            number: 5,
            title: 'Horizontal carousel — scrollDirection',
            accent: Color(0xFFC0356A),
          ),
          SizedBox(height: 12.0),
          _CarouselSection(),
          SizedBox(height: 32.0),
          _SectionTitle(
            number: 6,
            title: 'Two SliverGridDelegate flavors compared',
            accent: Color(0xFF3A6EA5),
          ),
          SizedBox(height: 12.0),
          _DelegateComparisonSection(),
          SizedBox(height: 32.0),
          _SectionTitle(
            number: 7,
            title: 'Why removedItemBuilder must capture data',
            accent: Color(0xFF7A5C61),
          ),
          SizedBox(height: 12.0),
          _RemovedItemBuilderSection(),
          SizedBox(height: 32.0),
          _SectionTitle(
            number: 8,
            title: 'AnimatedGrid API cheat-sheet',
            accent: Color(0xFF2C2046),
          ),
          SizedBox(height: 12.0),
          _CheatSheetCard(),
          SizedBox(height: 32.0),
        ],
      ),
    ),
  );
}

// ===========================================================================
// HEADER
// ===========================================================================
class _DashboardHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFF6B4DBA), Color(0xFF2C2046)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF6B4DBA).withValues(alpha: 0.35),
            blurRadius: 16.0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 64.0,
            height: 64.0,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: const Icon(
              Icons.grid_view_rounded,
              color: Colors.white,
              size: 36.0,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'Photo & Inventory Studio',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Driven entirely by AnimatedGrid mutations',
                  style: TextStyle(fontSize: 13.0, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// COMMON SECTION TITLE
// ===========================================================================
class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.number,
    required this.title,
    required this.accent,
  });

  final int number;
  final String title;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: accent.withValues(alpha: 0.35),
                blurRadius: 8.0,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '$number',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
              color: accent,
            ),
          ),
        ),
      ],
    );
  }
}

// ===========================================================================
// SECTION 1: Explanation
// ===========================================================================
class _ExplanationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: const Color(0xFFE4DEF5), width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF6B4DBA).withValues(alpha: 0.08),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.info_outline, color: Color(0xFF6B4DBA)),
              SizedBox(width: 8.0),
              Text(
                'Why AnimatedGrid?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Color(0xFF2C2046),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          const Text(
            'AnimatedGrid is the grid-shaped sibling of AnimatedList. Like GridView it '
            'paints a SliverGrid using a SliverGridDelegate, but unlike GridView it '
            'remembers per-index insertion and removal animations. Mutating its '
            'AnimatedGridState — obtained through a GlobalKey<AnimatedGridState> — '
            'drives those animations rather than rebuilding the entire grid.',
            style: TextStyle(
              fontSize: 13.0,
              height: 1.45,
              color: Color(0xFF3D3257),
            ),
          ),
          const SizedBox(height: 14.0),
          Row(
            children: <Widget>[
              Expanded(
                child: _MiniInfo(
                  icon: Icons.dashboard_customize,
                  label: 'GridView',
                  description: 'Static or scroll-only grid. No mutation animations.',
                  color: const Color(0xFFB0A8C7),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: _MiniInfo(
                  icon: Icons.movie_filter,
                  label: 'AnimatedGrid',
                  description: 'Tracks state; insertItem / removeItem animate.',
                  color: const Color(0xFF6B4DBA),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: const Color(0xFF2C2046),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Text(
              'final GlobalKey<AnimatedGridState> gridKey = GlobalKey<AnimatedGridState>();\n'
              'gridKey.currentState!.insertItem(0);\n'
              'gridKey.currentState!.removeItem(\n'
              '  index,\n'
              '  (ctx, anim) => removedItemBuilder(ctx, removedData, anim),\n'
              ');',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Color(0xFFC8B6FF),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniInfo extends StatelessWidget {
  const _MiniInfo({
    required this.icon,
    required this.label,
    required this.description,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: color, size: 20.0),
              const SizedBox(width: 6.0),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(
            description,
            style: TextStyle(fontSize: 11.0, color: color),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 2: Photo gallery with auto-cycling insert (SizeTransition)
// ===========================================================================
class _PhotoData {
  const _PhotoData(this.title, this.subtitle, this.icon, this.gradient);

  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradient;
}

const List<_PhotoData> _photoCatalogue = <_PhotoData>[
  _PhotoData('Sunset Cliff', 'Algarve · 18:42', Icons.wb_twilight,
      <Color>[Color(0xFFFFB347), Color(0xFFD7263D)]),
  _PhotoData('Ocean Drift', 'Bali · 06:11', Icons.waves,
      <Color>[Color(0xFF36D1DC), Color(0xFF1E3A8A)]),
  _PhotoData('Forest Hush', 'Black Forest · 09:30', Icons.park,
      <Color>[Color(0xFFA8E063), Color(0xFF1B5E20)]),
  _PhotoData('Neon Alley', 'Tokyo · 23:05', Icons.nightlife,
      <Color>[Color(0xFFFF61D8), Color(0xFF4B0082)]),
  _PhotoData('Desert Glow', 'Mojave · 17:55', Icons.brightness_low,
      <Color>[Color(0xFFFFE259), Color(0xFFB76E00)]),
  _PhotoData('Glacier Wind', 'Patagonia · 14:20', Icons.ac_unit,
      <Color>[Color(0xFFB6FBFF), Color(0xFF1D5DC1)]),
];

class _PhotoGallerySection extends StatefulWidget {
  @override
  State<_PhotoGallerySection> createState() => _PhotoGallerySectionState();
}

class _PhotoGallerySectionState extends State<_PhotoGallerySection> {
  final GlobalKey<AnimatedGridState> _gridKey = GlobalKey<AnimatedGridState>();
  final List<_PhotoData> _photos = <_PhotoData>[];
  int _nextIndex = 0;
  Timer? _cycleTimer;

  @override
  void initState() {
    super.initState();
    _photos.add(_photoCatalogue[0]);
    _nextIndex = 1;
    _cycleTimer = Timer.periodic(const Duration(milliseconds: 1600), (_) {
      _appendNext();
    });
  }

  void _appendNext() {
    if (!mounted) {
      return;
    }
    if (_photos.length >= _photoCatalogue.length) {
      // Reset cycle visually: clear all and restart with first photo.
      final AnimatedGridState? state = _gridKey.currentState;
      if (state != null) {
        state.removeAllItems((BuildContext c, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: const SizedBox.shrink(),
          );
        }, duration: const Duration(milliseconds: 250));
      }
      _photos.clear();
      _photos.add(_photoCatalogue[0]);
      _nextIndex = 1;
      state?.insertItem(0, duration: const Duration(milliseconds: 400));
      debugPrint('PhotoGallery reset, count=${_photos.length}');
      return;
    }
    final _PhotoData next = _photoCatalogue[_nextIndex];
    _photos.add(next);
    _nextIndex++;
    _gridKey.currentState
        ?.insertItem(_photos.length - 1, duration: const Duration(milliseconds: 500));
    debugPrint('PhotoGallery inserted ${next.title}, count=${_photos.length}');
  }

  @override
  void dispose() {
    _cycleTimer?.cancel();
    super.dispose();
  }

  Widget _tile(int index, Animation<double> animation) {
    final _PhotoData p = _photos[index];
    return SizeTransition(
      sizeFactor: animation,
      axisAlignment: -1.0,
      child: FadeTransition(
        opacity: animation,
        child: _PhotoTile(data: p, index: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: const Color(0xFFF1D6CF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Every 1.6 s a new gradient "photo" appends. SizeTransition + FadeTransition '
            'animate the entrance. On full set, removeAllItems clears and the cycle restarts.',
            style: TextStyle(fontSize: 12.0, color: Color(0xFF5C463F)),
          ),
          const SizedBox(height: 12.0),
          SizedBox(
            height: 280.0,
            child: AnimatedGrid(
              key: _gridKey,
              initialItemCount: _photos.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (BuildContext ctx, int index, Animation<double> animation) {
                return _tile(index, animation);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PhotoTile extends StatelessWidget {
  const _PhotoTile({required this.data, required this.index});

  final _PhotoData data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: data.gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(data.icon, color: Colors.white, size: 22.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  '#$index',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                data.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                data.subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 10.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 3: Inventory with FadeTransition + ScaleTransition removal
// ===========================================================================
class _InventoryItem {
  const _InventoryItem(this.name, this.sku, this.icon, this.qty, this.accent);

  final String name;
  final String sku;
  final IconData icon;
  final int qty;
  final Color accent;
}

const List<_InventoryItem> _initialInventory = <_InventoryItem>[
  _InventoryItem('Latte', 'CAF-001', Icons.local_cafe, 42, Color(0xFF7B4F2C)),
  _InventoryItem('Cookie', 'BAK-014', Icons.cookie, 18, Color(0xFFC57B57)),
  _InventoryItem('Donut', 'BAK-002', Icons.donut_large, 9, Color(0xFFE91E63)),
  _InventoryItem('Apple', 'FRU-101', Icons.apple, 22, Color(0xFFE53935)),
  _InventoryItem('Salad', 'FRS-021', Icons.eco, 5, Color(0xFF2E7D32)),
  _InventoryItem('Bento', 'JPN-007', Icons.lunch_dining, 11, Color(0xFFFB8C00)),
  _InventoryItem('Soda', 'BEV-300', Icons.local_drink, 30, Color(0xFF1976D2)),
  _InventoryItem('Cheese', 'DRY-099', Icons.kitchen, 14, Color(0xFFFFB300)),
  _InventoryItem('Pizza', 'HOT-202', Icons.local_pizza, 7, Color(0xFFD84315)),
];

class _InventorySection extends StatefulWidget {
  @override
  State<_InventorySection> createState() => _InventorySectionState();
}

class _InventorySectionState extends State<_InventorySection> {
  final GlobalKey<AnimatedGridState> _gridKey = GlobalKey<AnimatedGridState>();
  final List<_InventoryItem> _items = <_InventoryItem>[..._initialInventory];
  final math.Random _rng = math.Random(7);
  Timer? _ticker;
  int _replenishIndex = 0;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(milliseconds: 2500), (_) => _cycle());
  }

  void _cycle() {
    if (!mounted || _items.isEmpty) {
      return;
    }
    final int removeAt = _rng.nextInt(_items.length);
    final _InventoryItem removed = _items.removeAt(removeAt);
    _gridKey.currentState?.removeItem(
      removeAt,
      (BuildContext ctx, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: CurvedAnimation(parent: animation, curve: Curves.easeInBack),
            child: _InventoryTile(item: removed, faded: true),
          ),
        );
      },
      duration: const Duration(milliseconds: 360),
    );
    debugPrint('Inventory removed ${removed.name} count=${_items.length}');

    Future<void>.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) {
        return;
      }
      final _InventoryItem reAdd = _initialInventory[
          _replenishIndex % _initialInventory.length];
      _replenishIndex++;
      final int insertAt = _items.isEmpty ? 0 : _rng.nextInt(_items.length + 1);
      _items.insert(insertAt, reAdd);
      _gridKey.currentState
          ?.insertItem(insertAt, duration: const Duration(milliseconds: 420));
      debugPrint('Inventory inserted ${reAdd.name} at $insertAt count=${_items.length}');
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: const Color(0xFFCDE7DD)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Every 2.5 s a random tile is removed (fade + scale) and a replacement '
            'is inserted at a random position 700 ms later.',
            style: TextStyle(fontSize: 12.0, color: Color(0xFF1F4E45)),
          ),
          const SizedBox(height: 12.0),
          SizedBox(
            height: 320.0,
            child: AnimatedGrid(
              key: _gridKey,
              initialItemCount: _items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 0.95,
              ),
              itemBuilder: (BuildContext ctx, int index, Animation<double> animation) {
                final _InventoryItem item = _items[index];
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutBack,
                    ),
                    child: _InventoryTile(item: item),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _InventoryTile extends StatelessWidget {
  const _InventoryTile({required this.item, this.faded = false});

  final _InventoryItem item;
  final bool faded;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            item.accent.withValues(alpha: faded ? 0.35 : 0.9),
            item.accent.withValues(alpha: faded ? 0.15 : 0.55),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(item.icon, color: Colors.white, size: 24.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                    ),
                  ),
                  Text(
                    item.sku,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 10.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                'x${item.qty}',
                style: TextStyle(
                  color: item.accent,
                  fontWeight: FontWeight.bold,
                  fontSize: 11.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 4: Card-flip insert with RotationTransition
// ===========================================================================
class _FlipCard {
  const _FlipCard(this.label, this.icon, this.color);

  final String label;
  final IconData icon;
  final Color color;
}

const List<_FlipCard> _flipDeck = <_FlipCard>[
  _FlipCard('Hearts', Icons.favorite, Color(0xFFE63946)),
  _FlipCard('Spades', Icons.style, Color(0xFF1D3557)),
  _FlipCard('Crowns', Icons.emoji_events, Color(0xFFFFB703)),
  _FlipCard('Stars', Icons.star, Color(0xFF8338EC)),
  _FlipCard('Bolts', Icons.flash_on, Color(0xFFFB5607)),
  _FlipCard('Moons', Icons.dark_mode, Color(0xFF118AB2)),
  _FlipCard('Suns', Icons.wb_sunny, Color(0xFFFFA62B)),
  _FlipCard('Leafs', Icons.energy_savings_leaf, Color(0xFF06A77D)),
];

class _CardFlipSection extends StatefulWidget {
  @override
  State<_CardFlipSection> createState() => _CardFlipSectionState();
}

class _CardFlipSectionState extends State<_CardFlipSection> {
  final GlobalKey<AnimatedGridState> _gridKey = GlobalKey<AnimatedGridState>();
  final List<_FlipCard> _cards = <_FlipCard>[];
  final List<Timer> _pendingTimers = <Timer>[];
  Timer? _restartTimer;
  bool _disposed = false;

  @override
  void initState() {
    super.initState();
    _scheduleStagger();
  }

  void _scheduleStagger() {
    for (int i = 0; i < _flipDeck.length; i++) {
      final Timer t = Timer(Duration(milliseconds: 350 * i), () {
        if (_disposed || !mounted) {
          return;
        }
        _cards.add(_flipDeck[i]);
        _gridKey.currentState?.insertItem(
          _cards.length - 1,
          duration: const Duration(milliseconds: 600),
        );
        debugPrint('Flip inserted ${_flipDeck[i].label} count=${_cards.length}');
      });
      _pendingTimers.add(t);
    }
    _restartTimer = Timer(
      Duration(milliseconds: 350 * _flipDeck.length + 2400),
      _restart,
    );
  }

  void _restart() {
    if (_disposed || !mounted) {
      return;
    }
    final AnimatedGridState? state = _gridKey.currentState;
    state?.removeAllItems(
      (BuildContext c, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: const SizedBox.shrink(),
        );
      },
      duration: const Duration(milliseconds: 250),
    );
    _cards.clear();
    debugPrint('Flip restart, count=${_cards.length}');
    _scheduleStagger();
  }

  @override
  void dispose() {
    _disposed = true;
    for (final Timer t in _pendingTimers) {
      t.cancel();
    }
    _pendingTimers.clear();
    _restartTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: const Color(0xFFF3E0BC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Cards land one by one with a Y-axis flip. RotationTransition handles the '
            'flat spin; AnimatedBuilder + Matrix4.rotationY drives a 3D flip.',
            style: TextStyle(fontSize: 12.0, color: Color(0xFF6F4E0F)),
          ),
          const SizedBox(height: 12.0),
          SizedBox(
            height: 260.0,
            child: AnimatedGrid(
              key: _gridKey,
              initialItemCount: 0,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (BuildContext ctx, int index, Animation<double> animation) {
                if (index >= _cards.length) {
                  return const SizedBox.shrink();
                }
                final _FlipCard card = _cards[index];
                return _FlipTile(card: card, animation: animation);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FlipTile extends StatelessWidget {
  const _FlipTile({required this.card, required this.animation});

  final _FlipCard card;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext ctx, Widget? child) {
        final double t = animation.value;
        final double angle = (1.0 - t) * math.pi;
        final Matrix4 transform = Matrix4.identity()
          ..setEntry(3, 2, 0.0015)
          ..rotateY(angle);
        return Opacity(
          opacity: t.clamp(0.0, 1.0),
          child: Transform(
            transform: transform,
            alignment: Alignment.center,
            child: child,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              card.color.withValues(alpha: 0.95),
              card.color.withValues(alpha: 0.55),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: card.color.withValues(alpha: 0.35),
              blurRadius: 8.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(card.icon, color: Colors.white, size: 30.0),
            const SizedBox(height: 6.0),
            Text(
              card.label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// SECTION 5: Horizontal carousel with insertAllItems
// ===========================================================================
class _Chip {
  const _Chip(this.label, this.icon, this.color);

  final String label;
  final IconData icon;
  final Color color;
}

const List<_Chip> _carouselChips = <_Chip>[
  _Chip('Featured', Icons.local_fire_department, Color(0xFFC0356A)),
  _Chip('Trending', Icons.trending_up, Color(0xFF3A6EA5)),
  _Chip('New', Icons.fiber_new, Color(0xFF2E8B79)),
  _Chip('Hot', Icons.whatshot, Color(0xFFE26D5C)),
  _Chip('Top', Icons.workspace_premium, Color(0xFFCB7B16)),
  _Chip('Best', Icons.thumb_up, Color(0xFF6B4DBA)),
  _Chip('Sale', Icons.local_offer, Color(0xFF2C2046)),
  _Chip('Plus', Icons.add_circle, Color(0xFF7A5C61)),
];

class _CarouselSection extends StatefulWidget {
  @override
  State<_CarouselSection> createState() => _CarouselSectionState();
}

class _CarouselSectionState extends State<_CarouselSection> {
  final GlobalKey<AnimatedGridState> _gridKey = GlobalKey<AnimatedGridState>();
  final List<_Chip> _chips = <_Chip>[];
  Timer? _kickoffTimer;
  Timer? _cycleTimer;

  @override
  void initState() {
    super.initState();
    _kickoffTimer = Timer(const Duration(milliseconds: 600), () {
      if (!mounted) {
        return;
      }
      _chips.addAll(_carouselChips);
      _gridKey.currentState?.insertAllItems(
        0,
        _carouselChips.length,
        duration: const Duration(milliseconds: 700),
      );
      debugPrint('Carousel insertAllItems ${_chips.length} chips');
    });
    _cycleTimer = Timer.periodic(const Duration(seconds: 6), (_) => _recycle());
  }

  void _recycle() {
    if (!mounted) {
      return;
    }
    final AnimatedGridState? state = _gridKey.currentState;
    if (state == null) {
      return;
    }
    state.removeAllItems(
      (BuildContext c, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: const SizedBox.shrink(),
        );
      },
      duration: const Duration(milliseconds: 250),
    );
    _chips.clear();
    debugPrint('Carousel removeAllItems, count=${_chips.length}');
    Future<void>.delayed(const Duration(milliseconds: 400), () {
      if (!mounted) {
        return;
      }
      _chips.addAll(_carouselChips.reversed);
      _gridKey.currentState?.insertAllItems(
        0,
        _carouselChips.length,
        duration: const Duration(milliseconds: 700),
      );
      debugPrint('Carousel re-inserted ${_chips.length} chips');
    });
  }

  @override
  void dispose() {
    _kickoffTimer?.cancel();
    _cycleTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: const Color(0xFFF1D0DC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'scrollDirection: Axis.horizontal turns AnimatedGrid into a one-row carousel. '
            'insertAllItems / removeAllItems animate the whole batch.',
            style: TextStyle(fontSize: 12.0, color: Color(0xFF6B2440)),
          ),
          const SizedBox(height: 12.0),
          SizedBox(
            height: 110.0,
            child: AnimatedGrid(
              key: _gridKey,
              scrollDirection: Axis.horizontal,
              initialItemCount: 0,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (BuildContext ctx, int index, Animation<double> animation) {
                if (index >= _chips.length) {
                  return const SizedBox.shrink();
                }
                final _Chip chip = _chips[index];
                final Animation<Offset> slide = Tween<Offset>(
                  begin: const Offset(1.2, 0.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
                );
                return SlideTransition(
                  position: slide,
                  child: FadeTransition(
                    opacity: animation,
                    child: _ChipTile(chip: chip),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ChipTile extends StatelessWidget {
  const _ChipTile({required this.chip});

  final _Chip chip;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[chip.color, chip.color.withValues(alpha: 0.55)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(50.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(chip.icon, color: Colors.white, size: 22.0),
          const SizedBox(width: 6.0),
          Flexible(
            child: Text(
              chip.label,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 6: Delegate comparison (fixed count vs max cross-axis extent)
// ===========================================================================
class _DelegateSwatch {
  const _DelegateSwatch(this.code, this.color);

  final String code;
  final Color color;
}

const List<_DelegateSwatch> _swatches = <_DelegateSwatch>[
  _DelegateSwatch('A1', Color(0xFF3A6EA5)),
  _DelegateSwatch('B2', Color(0xFF2E8B79)),
  _DelegateSwatch('C3', Color(0xFFCB7B16)),
  _DelegateSwatch('D4', Color(0xFFC0356A)),
  _DelegateSwatch('E5', Color(0xFF6B4DBA)),
  _DelegateSwatch('F6', Color(0xFFE26D5C)),
  _DelegateSwatch('G7', Color(0xFF7A5C61)),
  _DelegateSwatch('H8', Color(0xFF2C2046)),
];

class _DelegateComparisonSection extends StatefulWidget {
  @override
  State<_DelegateComparisonSection> createState() =>
      _DelegateComparisonSectionState();
}

class _DelegateComparisonSectionState
    extends State<_DelegateComparisonSection> {
  final GlobalKey<AnimatedGridState> _fixedKey = GlobalKey<AnimatedGridState>();
  final GlobalKey<AnimatedGridState> _maxKey = GlobalKey<AnimatedGridState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: const Color(0xFFD3E1F3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Same eight swatches, two delegates. The first uses a fixed cross-axis '
            'count (always 4 columns); the second uses a max cross-axis extent (each '
            'tile up to 120px wide), letting Flutter pick the column count.',
            style: TextStyle(fontSize: 12.0, color: Color(0xFF1A3556)),
          ),
          const SizedBox(height: 14.0),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _DelegateCaption(
                      title: 'FixedCrossAxisCount(4)',
                      detail: 'crossAxisCount fixed; tile width = (w - gaps) / 4',
                      color: const Color(0xFF3A6EA5),
                    ),
                    const SizedBox(height: 8.0),
                    SizedBox(
                      height: 210.0,
                      child: AnimatedGrid(
                        key: _fixedKey,
                        initialItemCount: _swatches.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 6.0,
                          crossAxisSpacing: 6.0,
                        ),
                        itemBuilder: _buildSwatch,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _DelegateCaption(
                      title: 'MaxCrossAxisExtent(120)',
                      detail: 'tile width capped at 120; columns auto-fit',
                      color: const Color(0xFF6B4DBA),
                    ),
                    const SizedBox(height: 8.0),
                    SizedBox(
                      height: 210.0,
                      child: AnimatedGrid(
                        key: _maxKey,
                        initialItemCount: _swatches.length,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 120.0,
                          mainAxisSpacing: 6.0,
                          crossAxisSpacing: 6.0,
                        ),
                        itemBuilder: _buildSwatch,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSwatch(BuildContext ctx, int index, Animation<double> animation) {
    final _DelegateSwatch s = _swatches[index];
    return FadeTransition(
      opacity: animation,
      child: Container(
        decoration: BoxDecoration(
          color: s.color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            s.code,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
        ),
      ),
    );
  }
}

class _DelegateCaption extends StatelessWidget {
  const _DelegateCaption({
    required this.title,
    required this.detail,
    required this.color,
  });

  final String title;
  final String detail;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 12.0,
            ),
          ),
          Text(
            detail,
            style: TextStyle(color: color, fontSize: 10.0),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 7: removedItemBuilder must capture data at removal time
// ===========================================================================
class _RemovedItemBuilderSection extends StatefulWidget {
  @override
  State<_RemovedItemBuilderSection> createState() =>
      _RemovedItemBuilderSectionState();
}

class _RemovedItemBuilderSectionState
    extends State<_RemovedItemBuilderSection> {
  final GlobalKey<AnimatedGridState> _gridKey = GlobalKey<AnimatedGridState>();
  final List<Color> _colors = <Color>[
    const Color(0xFFEF476F),
    const Color(0xFFFFD166),
    const Color(0xFF06D6A0),
    const Color(0xFF118AB2),
    const Color(0xFF8338EC),
    const Color(0xFFFB5607),
  ];
  Timer? _ticker;
  int _opCounter = 0;
  String _lastEvent = 'Idle';

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(milliseconds: 1800), (_) {
      _toggle();
    });
  }

  void _toggle() {
    if (!mounted || _colors.isEmpty) {
      return;
    }
    _opCounter++;
    final bool doRemove = _opCounter.isEven;
    if (doRemove && _colors.length > 2) {
      final int idx = _colors.length - 1;
      // CRITICAL: capture color BEFORE removing it; the closure for
      // removedItemBuilder must not depend on _colors at animation time.
      final Color captured = _colors[idx];
      _colors.removeAt(idx);
      _gridKey.currentState?.removeItem(
        idx,
        (BuildContext ctx, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation,
              child: _AnnotatedSwatch(color: captured, removed: true),
            ),
          );
        },
        duration: const Duration(milliseconds: 350),
      );
      setState(() {
        _lastEvent = 'Removed swatch (captured color #${captured.toARGB32().toRadixString(16)})';
      });
      debugPrint('RemovedBuilder removed at $idx, captured=$captured');
    } else {
      final Color toAdd = Color(
        0xFF000000 | (math.Random().nextInt(0xFFFFFF)),
      );
      _colors.add(toAdd);
      _gridKey.currentState?.insertItem(
        _colors.length - 1,
        duration: const Duration(milliseconds: 350),
      );
      setState(() {
        _lastEvent = 'Inserted swatch (#${toAdd.toARGB32().toRadixString(16)})';
      });
      debugPrint('RemovedBuilder inserted, count=${_colors.length}');
    }
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: const Color(0xFFE0D2D5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF6F2),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: const Color(0xFFEAC6BD)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: const <Widget>[
                          Icon(Icons.lightbulb, color: Color(0xFFC85A3F)),
                          SizedBox(width: 6.0),
                          Expanded(
                            child: Text(
                              'removedItemBuilder rule',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF7A2E15),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6.0),
                      const Text(
                        'When AnimatedGridState.removeItem fires, the item is gone '
                        'from the backing list. Its removedItemBuilder runs the exit '
                        'animation and must therefore CAPTURE whatever it needs from '
                        'the data BEFORE the removal — typically inside the same '
                        'function that calls removeItem.',
                        style: TextStyle(fontSize: 12.0, color: Color(0xFF5A3522)),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2C2046),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          _lastEvent,
                          style: const TextStyle(
                            color: Color(0xFFC8B6FF),
                            fontFamily: 'monospace',
                            fontSize: 11.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                flex: 5,
                child: SizedBox(
                  height: 240.0,
                  child: AnimatedGrid(
                    key: _gridKey,
                    initialItemCount: _colors.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 6.0,
                      crossAxisSpacing: 6.0,
                    ),
                    itemBuilder:
                        (BuildContext ctx, int index, Animation<double> animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(
                          scale: animation,
                          child: _AnnotatedSwatch(color: _colors[index]),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AnnotatedSwatch extends StatelessWidget {
  const _AnnotatedSwatch({required this.color, this.removed = false});

  final Color color;
  final bool removed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            color,
            color.withValues(alpha: removed ? 0.25 : 0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8.0),
        border: removed
            ? Border.all(color: Colors.white.withValues(alpha: 0.7), width: 2.0)
            : null,
      ),
      child: Center(
        child: Icon(
          removed ? Icons.close : Icons.color_lens,
          color: Colors.white,
          size: 22.0,
        ),
      ),
    );
  }
}

// ===========================================================================
// SECTION 8: API cheat-sheet
// ===========================================================================
class _CheatSheetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFF2C2046), Color(0xFF4E3C7A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.menu_book, color: Color(0xFFC8B6FF)),
              SizedBox(width: 8.0),
              Text(
                'AnimatedGrid API surface',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(2.4),
              1: FlexColumnWidth(2.0),
              2: FlexColumnWidth(3.6),
            },
            border: TableBorder.symmetric(
              inside: BorderSide(
                color: Colors.white.withValues(alpha: 0.18),
                width: 1.0,
              ),
            ),
            children: const <TableRow>[
              TableRow(children: <Widget>[
                _ChHead('Member'),
                _ChHead('Effect'),
                _ChHead('Notes'),
              ]),
              TableRow(children: <Widget>[
                _ChCell('initialItemCount', mono: true),
                _ChCell('Sets the count at first build.'),
                _ChCell('Must equal your backing list length on first build.'),
              ]),
              TableRow(children: <Widget>[
                _ChCell('itemBuilder', mono: true),
                _ChCell('Builds visible items.'),
                _ChCell('Receives index and Animation<double> for inserts.'),
              ]),
              TableRow(children: <Widget>[
                _ChCell('GlobalKey<AnimatedGridState>', mono: true),
                _ChCell('Imperative handle.'),
                _ChCell('Required to call insertItem / removeItem from outside.'),
              ]),
              TableRow(children: <Widget>[
                _ChCell('insertItem(index)', mono: true),
                _ChCell('Animates one item in.'),
                _ChCell('Update your backing list FIRST, then call this.'),
              ]),
              TableRow(children: <Widget>[
                _ChCell('insertAllItems(start, count)', mono: true),
                _ChCell('Batches inserts.'),
                _ChCell('Backing list must already contain count entries.'),
              ]),
              TableRow(children: <Widget>[
                _ChCell('removeItem(index, builder)', mono: true),
                _ChCell('Animates one item out.'),
                _ChCell('Remove from list FIRST; builder must capture data.'),
              ]),
              TableRow(children: <Widget>[
                _ChCell('removeAllItems(builder)', mono: true),
                _ChCell('Animates the entire grid out.'),
                _ChCell('Useful when resetting between cycles.'),
              ]),
              TableRow(children: <Widget>[
                _ChCell('gridDelegate', mono: true),
                _ChCell('Controls layout.'),
                _ChCell('FixedCrossAxisCount or MaxCrossAxisExtent.'),
              ]),
              TableRow(children: <Widget>[
                _ChCell('scrollDirection', mono: true),
                _ChCell('Vertical or horizontal.'),
                _ChCell('Combine with crossAxisCount: 1 for a single-row carousel.'),
              ]),
              TableRow(children: <Widget>[
                _ChCell('SliverAnimatedGrid', mono: true),
                _ChCell('Sliver variant.'),
                _ChCell('Embed inside CustomScrollView with other slivers.'),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChHead extends StatelessWidget {
  const _ChHead(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFFC8B6FF),
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
        ),
      ),
    );
  }
}

class _ChCell extends StatelessWidget {
  const _ChCell(this.text, {this.mono = false});

  final String text;
  final bool mono;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 11.0,
          fontFamily: mono ? 'monospace' : null,
          height: 1.35,
        ),
      ),
    );
  }
}
