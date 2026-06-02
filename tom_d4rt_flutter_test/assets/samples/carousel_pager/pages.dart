// Static catalogue of the 8 vibrant carousel pages.
//
// Each entry is a self-describing value object — no behaviour, no
// late initialisation — so the data set can be `const` and referenced
// freely from both the carousel and the detail view.
import 'package:flutter/material.dart';

class PageInfo {
  final String title;
  final String tagline;
  final Color colorA;
  final Color colorB;

  const PageInfo({
    required this.title,
    required this.tagline,
    required this.colorA,
    required this.colorB,
  });
}

const List<PageInfo> kPages = <PageInfo>[
  PageInfo(
    title: 'Aurora',
    tagline: 'Ribbons of green dancing over the arctic.',
    colorA: Color(0xFF0E2148),
    colorB: Color(0xFF40C4AA),
  ),
  PageInfo(
    title: 'Sunset',
    tagline: 'A sky melting from gold into bruised purple.',
    colorA: Color(0xFFFF8A00),
    colorB: Color(0xFF6A1B9A),
  ),
  PageInfo(
    title: 'Ocean',
    tagline: 'Crystal water over a calcite shelf.',
    colorA: Color(0xFF006064),
    colorB: Color(0xFF80DEEA),
  ),
  PageInfo(
    title: 'Forest',
    tagline: 'Cedar columns and a roof of moss.',
    colorA: Color(0xFF1B5E20),
    colorB: Color(0xFFA5D6A7),
  ),
  PageInfo(
    title: 'Desert',
    tagline: 'Dune shadows at the blue hour.',
    colorA: Color(0xFFEF6C00),
    colorB: Color(0xFFFFE082),
  ),
  PageInfo(
    title: 'Galaxy',
    tagline: 'Pinwheel arms scattered with star nurseries.',
    colorA: Color(0xFF1A237E),
    colorB: Color(0xFFE040FB),
  ),
  PageInfo(
    title: 'Tundra',
    tagline: 'Frozen lakes split by snow squalls.',
    colorA: Color(0xFF263238),
    colorB: Color(0xFFB0BEC5),
  ),
  PageInfo(
    title: 'Volcano',
    tagline: 'Lava lacing through a basalt crust.',
    colorA: Color(0xFFB71C1C),
    colorB: Color(0xFFFFAB00),
  ),
];
