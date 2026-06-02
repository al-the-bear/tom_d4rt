// Home / grid page for the photo_gallery_hero sample.
//
// The page is the entry surface — it owns the AppBar and the
// `GalleryGrid`. On a tap it pushes the `ViewerPage` via a
// `PageRouteBuilder` so the route has a custom fade transition
// in addition to the matched-tag Hero animation.
//
// Using `PageRouteBuilder` (rather than `MaterialPageRoute`) is the
// point of this exercise: it lets the script supply the custom
// `transitionsBuilder` so we can verify the d4rt bridge surfaces
// the function-typed argument correctly.
//
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

import 'gallery_grid.dart';
import 'gradient_tile.dart';
import 'viewer_page.dart';

class GalleryHome extends StatelessWidget {
  const GalleryHome({super.key});

  Route<void> _buildViewerRoute(int index) {
    return PageRouteBuilder<void>(
      transitionDuration: const Duration(milliseconds: 350),
      reverseTransitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondary) {
        return ViewerPage(initialIndex: index);
      },
      transitionsBuilder: (BuildContext context,
          Animation<double> animation,
          Animation<double> secondary,
          Widget child) {
        // FadeTransition pairs cleanly with the Hero flight: the
        // background fades up while the tapped tile expands into the
        // viewer.
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  void _openViewer(BuildContext context, int index) {
    final photo = kPhotos[index];
    print('gallery.open id=${photo.id} index=$index');
    Navigator.of(context).push<void>(_buildViewerRoute(index));
  }

  @override
  Widget build(BuildContext context) {
    print('gallery.init n=${kPhotos.length}');
    return Scaffold(
      appBar: AppBar(
        key: const Key('gallery-appbar'),
        title: const Text('Gallery'),
      ),
      body: GalleryGrid(
        onPhotoTap: (int index) => _openViewer(context, index),
      ),
    );
  }
}
