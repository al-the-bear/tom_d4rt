import 'package:flutter/material.dart';

/// A clickable landmark on the plan.
///
/// `hitRect` is in NORMALIZED coordinates of the plan area (0..1 on both
/// axes) — the painter and the hit-test both use the same space so they
/// stay in sync.
class Landmark {
  final String id;
  final String name;
  final String italian;
  final String description;
  final Rect hitRect; // normalized 0..1
  final IconData icon;

  const Landmark({
    required this.id,
    required this.name,
    required this.italian,
    required this.description,
    required this.hitRect,
    required this.icon,
  });
}

/// All landmarks shown on the plan.
///
/// Coordinate system: x grows EAST (right), y grows SOUTH (down).
/// North is up. The basilica faces EAST toward St. Peter's Square.
const List<Landmark> kLandmarks = [
  Landmark(
    id: 'basilica',
    name: "St. Peter's Basilica",
    italian: 'Basilica di San Pietro',
    description:
        'The largest church in the world. Built 1506–1626 over the tomb of '
        'St. Peter. Designed by Bramante, Michelangelo, Maderno and Bernini. '
        'Latin-cross plan, ~220 m long.',
    hitRect: Rect.fromLTWH(0.10, 0.36, 0.28, 0.20),
    icon: Icons.church,
  ),
  Landmark(
    id: 'dome',
    name: "Michelangelo's Dome",
    italian: 'Cupola',
    description:
        'Designed by Michelangelo (1547), completed by Della Porta in 1590. '
        'Inner diameter 41.5 m, top of cross 136.5 m above the floor — the '
        'tallest dome in the world.',
    hitRect: Rect.fromLTWH(0.235, 0.41, 0.09, 0.09),
    icon: Icons.circle,
  ),
  Landmark(
    id: 'square',
    name: "St. Peter's Square",
    italian: 'Piazza San Pietro',
    description:
        "Bernini's masterpiece (1656–1667). The elliptical colonnade of 284 "
        'Doric columns in four rows symbolises the embrace of the Church. '
        '~320 m across at its widest.',
    hitRect: Rect.fromLTWH(0.38, 0.30, 0.30, 0.40),
    icon: Icons.panorama_horizontal,
  ),
  Landmark(
    id: 'obelisk',
    name: 'Vatican Obelisk',
    italian: 'Obelisco Vaticano',
    description:
        'Egyptian obelisk, 25.5 m tall, brought to Rome by Caligula in 37 AD '
        'and re-erected at the centre of the square by Domenico Fontana in '
        '1586 — a feat that required 900 men and 140 horses.',
    hitRect: Rect.fromLTWH(0.515, 0.475, 0.04, 0.04),
    icon: Icons.height,
  ),
  Landmark(
    id: 'fountain_n',
    name: 'Maderno Fountain',
    italian: 'Fontana del Maderno',
    description:
        'North fountain of the square, by Carlo Maderno (1614). Bernini '
        'later built a matching twin to the south to balance the ellipse.',
    hitRect: Rect.fromLTWH(0.455, 0.395, 0.04, 0.04),
    icon: Icons.water_drop,
  ),
  Landmark(
    id: 'fountain_s',
    name: 'Bernini Fountain',
    italian: 'Fontana del Bernini',
    description:
        'South fountain, added by Bernini in 1677 as a twin to Maderno’s, '
        'making the piazza perfectly symmetrical.',
    hitRect: Rect.fromLTWH(0.578, 0.555, 0.04, 0.04),
    icon: Icons.water_drop,
  ),
  Landmark(
    id: 'colonnade',
    name: 'Bernini Colonnade',
    italian: 'Colonnato del Bernini',
    description:
        'The two great semicircular colonnades enclosing the piazza: 284 '
        'columns and 88 pilasters in four rows, topped by 140 statues of '
        'saints. Bernini called it "the arms of the Church".',
    hitRect: Rect.fromLTWH(0.38, 0.30, 0.30, 0.40),
    icon: Icons.view_column,
  ),
  Landmark(
    id: 'conciliazione',
    name: 'Via della Conciliazione',
    italian: 'Via della Conciliazione',
    description:
        'Grand processional avenue from the square to the Tiber, opened in '
        '1936–1950. Named for the 1929 Lateran Treaty between Italy and the '
        'Holy See. Its creation demolished the medieval Spina di Borgo.',
    hitRect: Rect.fromLTWH(0.68, 0.46, 0.20, 0.08),
    icon: Icons.straight,
  ),
  Landmark(
    id: 'tiber',
    name: 'River Tiber',
    italian: 'Fiume Tevere',
    description:
        'Rome’s historic river. The Vatican lies on its west bank. Pilgrims '
        'have crossed it via Ponte Sant’Angelo to reach St. Peter’s for '
        'nearly two millennia.',
    hitRect: Rect.fromLTWH(0.88, 0.05, 0.10, 0.90),
    icon: Icons.waves,
  ),
  Landmark(
    id: 'castel',
    name: "Castel Sant'Angelo",
    italian: "Castel Sant'Angelo",
    description:
        'Originally Hadrian’s Mausoleum (139 AD), later a papal fortress, '
        'prison and treasury, linked to the Vatican by the Passetto di Borgo '
        'escape corridor. Now a museum.',
    hitRect: Rect.fromLTWH(0.83, 0.42, 0.08, 0.10),
    icon: Icons.castle,
  ),
  Landmark(
    id: 'sistine',
    name: 'Sistine Chapel',
    italian: 'Cappella Sistina',
    description:
        'Built 1473–1481 by Sixtus IV. Houses Michelangelo’s ceiling '
        '(1508–1512) and Last Judgment (1536–1541). Site of the papal '
        'conclave.',
    hitRect: Rect.fromLTWH(0.16, 0.20, 0.08, 0.10),
    icon: Icons.brush,
  ),
  Landmark(
    id: 'museums',
    name: 'Vatican Museums',
    italian: 'Musei Vaticani',
    description:
        'One of the world’s greatest art collections, founded by Pope '
        'Julius II in 1506. 7 km of galleries leading up to the Sistine '
        'Chapel.',
    hitRect: Rect.fromLTWH(0.25, 0.13, 0.18, 0.10),
    icon: Icons.museum,
  ),
  Landmark(
    id: 'palace',
    name: 'Apostolic Palace',
    italian: 'Palazzo Apostolico',
    description:
        'Official papal residence (though Francis lived in the Casa Santa '
        'Marta). Contains the Papal Apartments and the Raphael Rooms. The '
        'Pope blesses the crowd from its window every Sunday.',
    hitRect: Rect.fromLTWH(0.30, 0.24, 0.14, 0.10),
    icon: Icons.account_balance,
  ),
  Landmark(
    id: 'gardens',
    name: 'Vatican Gardens',
    italian: 'Giardini Vaticani',
    description:
        'Cover more than half of Vatican City — about 23 hectares of '
        'manicured Italian, French and English gardens, fountains and '
        'grottoes dating to the 13th century.',
    hitRect: Rect.fromLTWH(0.02, 0.05, 0.22, 0.70),
    icon: Icons.park,
  ),
  Landmark(
    id: 'santa_marta',
    name: 'Casa Santa Marta',
    italian: 'Domus Sanctae Marthae',
    description:
        'Guesthouse built in 1996, used to lodge cardinals during the '
        'conclave. Pope Francis chose to live here from 2013 instead of in '
        'the Apostolic Palace.',
    hitRect: Rect.fromLTWH(0.13, 0.60, 0.10, 0.07),
    icon: Icons.home_work,
  ),
];
