// Per-tab `Navigator`.
//
// Each tab in the bottom-nav shell hosts its own `Navigator`, so
// pushing a detail route stays inside that tab. Switching tabs in
// the outer shell does not unwind the inner stack (the `IndexedStack`
// keeps the inactive Navigator mounted), and the outer `PopScope`
// intercepts the back gesture to pop the *active* tab's Navigator
// before falling through to the app-level pop.
//
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

class TabNavigator extends StatelessWidget {
  const TabNavigator({
    super.key,
    required this.navKey,
    required this.tabId,
    required this.root,
  });

  final GlobalKey<NavigatorState> navKey;
  final String tabId;
  final Widget root;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navKey,
      onGenerateRoute: (RouteSettings settings) {
        print('route.gen tab=$tabId name=${settings.name}');
        Widget page;
        if (settings.name == null || settings.name == '/') {
          page = root;
        } else if (settings.name == '/detail') {
          final Object? args = settings.arguments;
          final String title = args == null ? 'Detail' : args.toString();
          page = DetailPage(title: title, tabId: tabId);
        } else {
          page = const _UnknownRoute();
        }
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext _) => page,
        );
      },
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.title, required this.tabId});

  final String title;
  final String tabId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: Key('detail-appbar-$tabId'),
        title: Text(title),
        leading: IconButton(
          key: Key('detail-back-$tabId'),
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            print('detail.back tab=$tabId title=$title');
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Detail page: $title',
                key: Key('detail-body-$tabId'),
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 12.0),
              Text('(tab: $tabId)'),
            ],
          ),
        ),
      ),
    );
  }
}

class _UnknownRoute extends StatelessWidget {
  const _UnknownRoute();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Unknown route')),
    );
  }
}
