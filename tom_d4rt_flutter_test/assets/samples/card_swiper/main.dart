// Entry point for the card_swiper sample (example #17).
//
// The in-tester harness (`SourceFlutterD4rt.buildMultiFile`) calls a
// top-level `Widget build(BuildContext)` rather than `main()`, so
// this file exposes that contract directly.
import 'package:flutter/material.dart';

import 'home.dart';

Widget build(BuildContext context) {
  return const MaterialApp(
    title: 'Card Swiper',
    home: SwiperHome(),
  );
}
