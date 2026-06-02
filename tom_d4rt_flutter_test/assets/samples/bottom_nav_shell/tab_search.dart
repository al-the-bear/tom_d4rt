// Search tab — a text field whose contents must survive switching
// away to another tab and back again. The outer shell uses an
// `IndexedStack` so the tab keeps its `Element` (and therefore its
// `_TabSearchState` and `TextEditingController`) when inactive.
//
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

class TabSearch extends StatefulWidget {
  const TabSearch({super.key});

  @override
  State<TabSearch> createState() => _TabSearchState();
}

class _TabSearchState extends State<TabSearch> {
  final TextEditingController _controller = TextEditingController();
  int _searches = 0;
  List<String> _results = const <String>[];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _runSearch() {
    final String q = _controller.text;
    setState(() {
      _searches = _searches + 1;
      _results = q.isEmpty
          ? const <String>[]
          : <String>[
              '$q · result A',
              '$q · result B',
              '$q · result C',
            ];
    });
    print('search.run q="$q" total=$_searches');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key('search-appbar'),
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    key: const Key('search-field'),
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Query',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (String _) => _runSearch(),
                  ),
                ),
                const SizedBox(width: 8.0),
                FilledButton(
                  key: const Key('search-go'),
                  onPressed: _runSearch,
                  child: const Text('Search'),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Text(
              'Searches run: $_searches',
              key: const Key('search-count'),
            ),
            const SizedBox(height: 12.0),
            Expanded(
              child: ListView.builder(
                key: const Key('search-results'),
                itemCount: _results.length,
                itemBuilder: (BuildContext _, int index) {
                  return ListTile(
                    key: Key('search-result-$index'),
                    title: Text(_results[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
