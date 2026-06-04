// Fullscreen photo viewer for the photo_gallery_hero sample.
//
// `PageView.builder` lets the user swipe horizontally between
// adjacent photos; the active page wraps the painted gradient in a
// `Hero` (matching the grid tile's tag) so the entry transition
// animates seamlessly. Each page also wraps its `GradientTile` in
// `InteractiveViewer` to enable pan + pinch-zoom on the photo.
//
// The viewer emits a small trail so the tester can assert:
//   * `viewer.open id=N` — initial photo on push
//   * `viewer.page id=N` — swiped to a new page
//   * `viewer.scale=X.XX` — InteractiveViewer reported a transform
//
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

import 'gradient_tile.dart';

class ViewerPage extends StatefulWidget {
  /// Photo index the user tapped — the PageView starts here.
  final int initialIndex;

  const ViewerPage({super.key, required this.initialIndex});

  @override
  State<ViewerPage> createState() => _ViewerPageState();
}

class _ViewerPageState extends State<ViewerPage> {
  late final PageController _controller;
  late int _currentIndex;
  // One controller per page so pan/zoom state is isolated. We don't
  // try to share a single TransformationController across pages —
  // resetting it on a swipe would still cost a frame, and a per-page
  // controller is the standard pattern.
  final Map<int, TransformationController> _txControllers =
      <int, TransformationController>{};

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _controller = PageController(initialPage: widget.initialIndex);
    final initialId = kPhotos[widget.initialIndex].id;
    print('viewer.open id=$initialId');
  }

  @override
  void dispose() {
    _controller.dispose();
    for (final tc in _txControllers.values) {
      tc.dispose();
    }
    super.dispose();
  }

  TransformationController _txFor(int index) {
    return _txControllers.putIfAbsent(index, () {
      final tc = TransformationController();
      tc.addListener(() {
        // Report the current uniform scale (matrix row 0, col 0) so
        // tests can assert pinch-zoom actually drove the transform.
        // We avoid spamming the log: only print when the scale
        // visibly changes (rounded to 2 decimals).
        final scale = tc.value.getMaxScaleOnAxis();
        final rounded = (scale * 100).round() / 100.0;
        if (rounded != _lastReportedScale) {
          _lastReportedScale = rounded;
          print('viewer.scale=${rounded.toStringAsFixed(2)}');
        }
      });
      return tc;
    });
  }

  double _lastReportedScale = 1.0;

  void _onPageChanged(int newIndex) {
    setState(() => _currentIndex = newIndex);
    final id = kPhotos[newIndex].id;
    print('viewer.page id=$id');
  }

  void _close() {
    final id = kPhotos[_currentIndex].id;
    print('viewer.close id=$id');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        key: const Key('viewer-appbar'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text('Photo ${kPhotos[_currentIndex].id}'),
        leading: IconButton(
          key: const Key('viewer-close'),
          icon: const Icon(Icons.close),
          onPressed: _close,
        ),
      ),
      body: PageView.builder(
        key: const Key('viewer-pageview'),
        controller: _controller,
        itemCount: kPhotos.length,
        onPageChanged: _onPageChanged,
        itemBuilder: (BuildContext context, int index) {
          final photo = kPhotos[index];
          return Center(
            child: Hero(
              // Only the currently-displayed page participates in the
              // matched-tag Hero animation. PageView builds neighbours
              // eagerly, so giving every page the same tag would
              // produce duplicate-tag assertions on push/pop.
              tag: index == _currentIndex
                  ? photoHeroTag(photo.id)
                  : 'photo-${photo.id}-inactive',
              child: InteractiveViewer(
                key: Key('viewer-iv-${photo.id}'),
                transformationController: _txFor(index),
                minScale: 1.0,
                maxScale: 4.0,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: GradientTile(photo: photo, fontSize: 96.0),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
