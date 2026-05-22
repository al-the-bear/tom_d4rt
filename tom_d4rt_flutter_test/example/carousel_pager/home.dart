// Carousel shell.
//
// Layout (top → bottom):
//   • AppBar with prev/next buttons + an "Auto-play" Switch.
//   • A parallax background gradient that shifts at ~half the speed
//     of the foreground PageView.
//   • A `PageView.builder` of 8 `PageCard`s.
//   • A `PageIndicator` of 8 dots.
//
// State and effects:
//   • `_controller`     — `PageController` driving the PageView. We
//                         subscribe in `initState` and write a
//                         fractional page value to `_page` on every
//                         offset change (drives parallax + indicator).
//   • `_autoplay`       — bool toggled by a `Switch`. When true, a
//                         `Timer.periodic` advances the page every
//                         1500ms; when off we cancel the timer.
//   • `_detailIndex`    — when non-null, an `AnimatedSwitcher` cross-
//                         fades the carousel view for the
//                         `DetailPage`. Tapping back returns to the
//                         carousel.
//
// Trail (one line per significant event so tests can assert):
//
//   pager.boot pages=<n> page=0
//   page.change from=<n> to=<n>
//   parallax bg=<n.nn>
//   autoplay on
//   autoplay off
//   autoplay.tick to=<n>
//   detail.open page=<title> index=<n>
//   detail.close index=<n>
//
// ignore_for_file: avoid_print
import 'dart:async';

import 'package:flutter/material.dart';

import 'detail_page.dart';
import 'indicator.dart';
import 'page_card.dart';
import 'pages.dart';

class CarouselPagerApp extends StatelessWidget {
  const CarouselPagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'carousel_pager',
      theme: ThemeData(useMaterial3: true),
      home: const CarouselHome(),
    );
  }
}

class CarouselHome extends StatefulWidget {
  const CarouselHome({super.key});

  @override
  State<CarouselHome> createState() => _CarouselHomeState();
}

class _CarouselHomeState extends State<CarouselHome> {
  final PageController _controller =
      PageController(initialPage: 0, viewportFraction: 0.85);

  /// Fractional page offset (e.g. 0.42 mid-swipe). Updated on every
  /// PageController scroll callback. Lives in a ValueNotifier (not
  /// a setState-driven field) so the per-scroll-frame rebuild is
  /// scoped to just the parallax + indicator + counter via
  /// AnimatedBuilder, instead of rebuilding the whole carousel
  /// subtree through the d4rt interpreter on every animation frame
  /// (~60 Hz). Without this scoping the listener can't keep up with
  /// the native PageView animation, the animation stalls, and
  /// button taps / mouse swipes appear to do nothing.
  final ValueNotifier<double> _pageNotifier =
      ValueNotifier<double>(0.0);

  /// Integer page index, derived from [_pageNotifier]. Separate
  /// notifier so the page-counter Text only rebuilds when the
  /// integer changes (not on every fractional update).
  final ValueNotifier<int> _indexNotifier = ValueNotifier<int>(0);

  bool _autoplay = false;
  Timer? _autoplayTimer;
  int? _detailIndex;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
    // Defer the boot line one frame so the framework has finished
    // setUp; otherwise the test that asserts on this line races
    // against the `[host] interpreted` prefix that the harness
    // prints synchronously.
    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      print('pager.boot pages=${kPages.length} page=0');
    });
  }

  @override
  void dispose() {
    _autoplayTimer?.cancel();
    _controller.removeListener(_onScroll);
    _controller.dispose();
    _pageNotifier.dispose();
    _indexNotifier.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_controller.hasClients) return;
    final double next = _controller.page ?? 0.0;
    if ((next - _pageNotifier.value).abs() < 0.001) return;
    final int nextIndex = next.round().clamp(0, kPages.length - 1);
    final int oldIndex = _indexNotifier.value;
    _pageNotifier.value = next;
    if (nextIndex != oldIndex) {
      _indexNotifier.value = nextIndex;
    }
    // Round the parallax offset to two decimals so the assertion
    // can match an exact string regardless of float jitter.
    final double parallax = next * 0.5;
    final double rounded = (parallax * 100.0).roundToDouble() / 100.0;
    print('parallax bg=${rounded.toStringAsFixed(2)}');
    if (nextIndex != oldIndex) {
      print('page.change from=$oldIndex to=$nextIndex');
    }
  }

  void _setAutoplay(bool value) {
    setState(() {
      _autoplay = value;
    });
    if (value) {
      print('autoplay on');
      _autoplayTimer = Timer.periodic(
        const Duration(milliseconds: 1500),
        (Timer _) => _autoplayAdvance(),
      );
    } else {
      print('autoplay off');
      _autoplayTimer?.cancel();
      _autoplayTimer = null;
    }
  }

  void _autoplayAdvance() {
    if (!_controller.hasClients) return;
    final int next = (_indexNotifier.value + 1) % kPages.length;
    print('autoplay.tick to=$next');
    _controller.animateToPage(
      next,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  void _jump(int delta) {
    if (!_controller.hasClients) return;
    final int current = _indexNotifier.value;
    final int next = (current + delta).clamp(0, kPages.length - 1);
    if (next == current) return;
    _controller.animateToPage(
      next,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  void _openDetail(int index) {
    print('detail.open page=${kPages[index].title} index=$index');
    setState(() {
      _detailIndex = index;
    });
  }

  void _closeDetail() {
    setState(() {
      _detailIndex = null;
    });
  }

  Widget _carouselView() {
    return Scaffold(
      key: const Key('carousel-scaffold'),
      appBar: AppBar(
        key: const Key('carousel-appbar'),
        title: const Text('carousel_pager'),
        actions: <Widget>[
          IconButton(
            key: const Key('prev-button'),
            icon: const Icon(Icons.chevron_left),
            tooltip: 'Previous',
            onPressed: () => _jump(-1),
          ),
          IconButton(
            key: const Key('next-button'),
            icon: const Icon(Icons.chevron_right),
            tooltip: 'Next',
            onPressed: () => _jump(1),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: <Widget>[
                const Text('Auto'),
                Switch(
                  key: const Key('autoplay-switch'),
                  value: _autoplay,
                  onChanged: _setAutoplay,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Parallax background — translated half the speed of the
          // foreground page so it reads as a "deep" backdrop. Wrapped
          // in an AnimatedBuilder so the per-scroll-frame rebuild is
          // scoped to just this subtree (see _pageNotifier doc).
          Positioned.fill(
            child: AnimatedBuilder(
              key: const Key('parallax-bg'),
              animation: _pageNotifier,
              builder: (BuildContext _, Widget? _) {
                return _ParallaxBackground(page: _pageNotifier.value);
              },
            ),
          ),
          Column(
            children: <Widget>[
              Expanded(
                child: PageView.builder(
                  key: const Key('pager'),
                  controller: _controller,
                  itemCount: kPages.length,
                  itemBuilder: (BuildContext _, int index) {
                    return PageCard(
                      info: kPages[index],
                      index: index,
                      onTap: () => _openDetail(index),
                    );
                  },
                ),
              ),
              AnimatedBuilder(
                animation: _pageNotifier,
                builder: (BuildContext _, Widget? _) {
                  return PageIndicator(
                    page: _pageNotifier.value,
                    count: kPages.length,
                  );
                },
              ),
              const SizedBox(height: 12.0),
              AnimatedBuilder(
                animation: _indexNotifier,
                builder: (BuildContext _, Widget? _) {
                  return Text(
                    'Page ${_indexNotifier.value + 1} of ${kPages.length}',
                    key: const Key('page-counter'),
                    style: const TextStyle(fontSize: 14.0),
                  );
                },
              ),
              const SizedBox(height: 12.0),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget child;
    if (_detailIndex != null) {
      final int idx = _detailIndex!;
      child = DetailPage(
        key: ValueKey<String>('detail-$idx'),
        info: kPages[idx],
        index: idx,
        onClose: _closeDetail,
      );
    } else {
      child = KeyedSubtree(
        key: const ValueKey<String>('carousel'),
        child: _carouselView(),
      );
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: child,
    );
  }
}

class _ParallaxBackground extends StatelessWidget {
  final double page;

  const _ParallaxBackground({required this.page});

  @override
  Widget build(BuildContext context) {
    // The background blends between consecutive page colours at half
    // the speed of the foreground PageView — that's the parallax.
    final int lo = page.floor().clamp(0, kPages.length - 1);
    final int hi = (lo + 1).clamp(0, kPages.length - 1);
    final double t = (page - lo).clamp(0.0, 1.0);
    final Color a = Color.lerp(kPages[lo].colorA, kPages[hi].colorA, t * 0.5)!;
    final Color b = Color.lerp(kPages[lo].colorB, kPages[hi].colorB, t * 0.5)!;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[a, b],
        ),
      ),
    );
  }
}
