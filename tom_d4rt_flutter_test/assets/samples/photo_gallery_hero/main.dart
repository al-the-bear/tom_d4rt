// Entry point for the photo_gallery_hero sample (example #16).
//
// The in-tester harness (`SourceFlutterD4rt.buildMultiFile`) calls a
// top-level `Widget build(BuildContext)` rather than `main()`, so
// this file exposes that contract directly.
import 'package:flutter/material.dart';

import 'home.dart';

Widget build(BuildContext context) {
  return const MaterialApp(
    title: 'Photo Gallery Hero',
    home: GalleryHome(),
  );
}
