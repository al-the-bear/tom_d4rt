// Thumbnail grid for the photo_gallery_hero sample.
//
// Each cell renders a `GradientTile` wrapped in `Hero` with the tag
// returned by `photoHeroTag`. The Hero is the entire tappable area,
// so `Navigator.push` from `onTap` animates the same painted bounds
// across the route — the matched-tag tag is what makes it work.
//
// The grid emits `gallery.tap id=N` from the GestureDetector so the
// tester can assert "tapping a tile actually fires the navigation
// callback" without having to reach into the navigator stack.
//
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

import 'gradient_tile.dart';

class GalleryGrid extends StatelessWidget {
  /// Called when the user taps a thumbnail. The home page provides a
  /// callback that pushes the viewer route; keeping the navigation
  /// logic out of the grid lets us reuse the grid in a hypothetical
  /// "picker" mode without rewiring it.
  final void Function(int index) onPhotoTap;

  const GalleryGrid({super.key, required this.onPhotoTap});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: const Key('gallery-grid'),
      padding: const EdgeInsets.all(12.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        childAspectRatio: 1.0,
      ),
      itemCount: kPhotos.length,
      itemBuilder: (BuildContext context, int index) {
        final photo = kPhotos[index];
        return GestureDetector(
          key: Key('gallery-tile-${photo.id}'),
          behavior: HitTestBehavior.opaque,
          onTap: () {
            print('gallery.tap id=${photo.id}');
            onPhotoTap(index);
          },
          child: Hero(
            tag: photoHeroTag(photo.id),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: GradientTile(photo: photo),
            ),
          ),
        );
      },
    );
  }
}
