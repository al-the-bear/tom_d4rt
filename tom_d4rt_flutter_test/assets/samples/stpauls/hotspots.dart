import 'package:flutter/material.dart';

/// A clickable region on the basilica plan. Coordinates are in a
/// normalized 1000 x 700 design space — the painter and hit-tester
/// both scale to that.
class Hotspot {
  final String id;
  final String name;
  final String description;
  final Rect rect;
  final IconData icon;

  const Hotspot({
    required this.id,
    required this.name,
    required this.description,
    required this.rect,
    required this.icon,
  });
}

const double kPlanW = 1000;
const double kPlanH = 700;

// Layout (very stylised, looking down from above):
//
//   left (west)                                            right (east)
//   ┌──────────────────────────────────────────────────────────────┐
//   │  gardens                                                     │
//   │   ┌──── Quadriporticus ────┐  ┌─ Narthex ─┐  ┌── Nave ──┐    │
//   │   │   (atrium, statue)     │  │           │  │  +aisles │ T  │
//   │   │                        │  │           │  │          │ R  │ Apse
//   │   └────────────────────────┘  └───────────┘  └──────────┘ ...│
//   │                                                Cloister      │
//   │  Via Ostiense ───→ Tiber                                     │
//   └──────────────────────────────────────────────────────────────┘
//
// The real basilica is entered from the east; the apse faces west.
// We mirror that here so the plan reads left-to-right as you would
// walk through it from the Via Ostiense entrance.

const List<Hotspot> kHotspots = [
  Hotspot(
    id: 'quadriporticus',
    name: 'Quadriporticus (Atrium)',
    description:
        'A vast colonnaded courtyard of 150 granite columns, rebuilt '
        'after the 1823 fire. At its centre stands a 19th-century '
        'statue of St. Paul holding a sword and a book.',
    rect: Rect.fromLTWH(80, 150, 240, 380),
    icon: Icons.account_balance_outlined,
  ),
  Hotspot(
    id: 'statue',
    name: 'Statue of St. Paul',
    description:
        'Marble statue by Giuseppe Obici (1850s) in the centre of the '
        'atrium. Sword in the right hand, scroll of the Epistles in '
        'the left.',
    rect: Rect.fromLTWH(180, 320, 40, 40),
    icon: Icons.person_outline,
  ),
  Hotspot(
    id: 'narthex',
    name: 'Narthex & Holy Door',
    description:
        'Entrance porch. The bronze Holy Door (Porta Santa) is opened '
        'only during Jubilee years. Above the façade, gold mosaics '
        'show Christ between Peter and Paul.',
    rect: Rect.fromLTWH(330, 200, 60, 280),
    icon: Icons.door_front_door_outlined,
  ),
  Hotspot(
    id: 'nave',
    name: 'Nave & Four Aisles',
    description:
        'One of the largest basilical naves in the world — five aisles '
        'in total, separated by 80 monolithic granite columns. The '
        'clerestory carries roundel portraits of every pope from St. '
        'Peter onwards.',
    rect: Rect.fromLTWH(400, 200, 280, 280),
    icon: Icons.view_column_outlined,
  ),
  Hotspot(
    id: 'transept',
    name: 'Transept',
    description:
        'The cross-arm of the church, lined with altars and large '
        '19th-century paintings of scenes from the life of St. Paul.',
    rect: Rect.fromLTWH(690, 150, 70, 380),
    icon: Icons.swap_horiz,
  ),
  Hotspot(
    id: 'baldachin',
    name: 'Papal Altar & Baldachin',
    description:
        'Gothic ciborium by Arnolfo di Cambio (1285) — one of the few '
        'pieces to survive the 1823 fire. Beneath the altar lies the '
        'tomb of St. Paul the Apostle.',
    rect: Rect.fromLTWH(720, 310, 60, 60),
    icon: Icons.star_outline,
  ),
  Hotspot(
    id: 'apse',
    name: 'Apse Mosaic',
    description:
        '13th-century mosaic of Christ enthroned between Peter, Paul, '
        'Andrew and Luke, with Pope Honorius III prostrate at his feet.',
    rect: Rect.fromLTWH(780, 250, 90, 180),
    icon: Icons.brightness_5_outlined,
  ),
  Hotspot(
    id: 'cloister',
    name: 'Cosmatesque Cloister',
    description:
        'Built by the Vassalletto family (c. 1210). A masterpiece of '
        'Cosmati work: pairs of twisted columns inlaid with gold and '
        'coloured glass mosaics. Survived the 1823 fire intact.',
    rect: Rect.fromLTWH(440, 520, 240, 140),
    icon: Icons.grid_4x4,
  ),
  Hotspot(
    id: 'belltower',
    name: 'Bell Tower',
    description:
        'Neoclassical campanile by Luigi Poletti, completed in 1860 '
        'as part of the post-fire reconstruction.',
    rect: Rect.fromLTWH(700, 40, 60, 90),
    icon: Icons.notifications_none,
  ),
  Hotspot(
    id: 'gardens',
    name: 'Monastery Gardens',
    description:
        'The basilica is still served by a Benedictine abbey. Its '
        'gardens and orchards surround the complex on the south side.',
    rect: Rect.fromLTWH(80, 540, 340, 120),
    icon: Icons.park_outlined,
  ),
];
