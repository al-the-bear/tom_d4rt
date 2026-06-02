// Log tab — an `AnimatedList` fed by a `Stream.periodic` ticker.
//
// Each tick inserts a new entry at the top with a slide-in
// animation. The "Pause" button flips a flag that short-circuits
// the tick handler so the stream subscription stays alive but no
// new entries appear. The "Clear" button drops the backing list
// and remounts the `AnimatedList` via a fresh `GlobalKey` — this
// avoids the bookkeeping dance of pairing every backing-list
// removal with a `removeItem` animation callback.
//
// ignore_for_file: avoid_print
import 'dart:async';

import 'package:flutter/material.dart';

class LogTab extends StatefulWidget {
  const LogTab({super.key});

  @override
  State<LogTab> createState() => _LogTabState();
}

class _LogTabState extends State<LogTab>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<String> _entries = <String>[];
  StreamSubscription<int>? _sub;
  bool _paused = false;
  int _counter = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _sub = Stream<int>.periodic(
      const Duration(milliseconds: 300),
      (int i) => i,
    ).listen(_onTick);
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  void _onTick(int _) {
    if (_paused) return;
    final int i = _counter;
    final String msg = 'event #$i';
    setState(() {
      _counter = _counter + 1;
      _entries.insert(0, msg);
    });
    final AnimatedListState? st = _listKey.currentState;
    if (st != null) {
      st.insertItem(0, duration: const Duration(milliseconds: 150));
    }
    print('log.tick i=$i msg=$msg');
  }

  void _togglePause() {
    setState(() {
      _paused = !_paused;
    });
    print('log.pause=$_paused');
  }

  void _clear() {
    setState(() {
      _entries.clear();
      // Remount the AnimatedList with a fresh key — the simplest
      // way to drop all items without juggling `removeItem`
      // builders for each entry.
      _listKey = GlobalKey<AnimatedListState>();
    });
    print('log.cleared');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                FilledButton.icon(
                  key: const Key('log-pause-button'),
                  icon: Icon(_paused ? Icons.play_arrow : Icons.pause),
                  label: Text(_paused ? 'Resume' : 'Pause'),
                  onPressed: _togglePause,
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  key: const Key('log-clear-button'),
                  icon: const Icon(Icons.delete_outline),
                  tooltip: 'Clear log',
                  onPressed: _clear,
                ),
                const Spacer(),
                Text(
                  'entries: ${_entries.length}',
                  key: const Key('log-count-label'),
                ),
              ],
            ),
          ),
          Expanded(
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _entries.length,
              itemBuilder:
                  (BuildContext ctx, int index, Animation<double> anim) {
                final String e = _entries[index];
                return SizeTransition(
                  sizeFactor: anim,
                  child: ListTile(
                    key: Key('log-item-$index'),
                    title: Text(e),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
