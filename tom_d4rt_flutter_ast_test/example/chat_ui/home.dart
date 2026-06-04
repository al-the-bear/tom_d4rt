// The chat room.
//
// Layout: AppBar + an AnimatedList that scrolls (newest at the
// bottom) + optional "typing…" pill + composer pinned to the
// bottom. New bubbles slide+fade in via the AnimatedList's
// `itemBuilder` animation hooked up by `bubble.dart`.
//
// State:
//   • `_store`           — the data layer (see `chat_store.dart`).
//   • `_listKey`         — handle for `AnimatedList.of(context)` so
//                            the host widget can call `insertItem`.
//   • `_scroll`          — `ScrollController` used to auto-scroll
//                            to the newest message after each insert.
//   • `_typing`          — mirrors the store's typing flag; rendered
//                            as a `TypingIndicator` pill when true.
//
// Trail (one line per significant event) makes the test harness
// able to assert against the captured `_printLog`:
//
//   chat.send rejected=empty
//   chat.user.append id=<n> text="<s>"
//   chat.typing on
//   chat.typing off
//   chat.bot.append id=<n> text="<s>"
//   chat.scroll target=bottom messages=<n>
//
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

import 'bubble.dart';
import 'chat_store.dart';
import 'composer.dart';
import 'message.dart';

class ChatUiApp extends StatelessWidget {
  const ChatUiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chat_ui',
      theme: ThemeData(useMaterial3: true, brightness: Brightness.light),
      home: const ChatHome(),
    );
  }
}

class ChatHome extends StatefulWidget {
  const ChatHome({super.key});

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  final ChatStore _store = ChatStore();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final ScrollController _scroll = ScrollController();
  bool _typing = false;

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    // Defer to the next frame so the freshly inserted item has been
    // laid out before we compute the max scroll extent.
    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      if (!_scroll.hasClients) return;
      final double target = _scroll.position.maxScrollExtent;
      _scroll.animateTo(
        target,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
      );
      print('chat.scroll target=bottom messages=${_store.length}');
    });
  }

  void _appendBubble(ChatMessage _) {
    // Insert at the end — the data list has already been appended by
    // ChatStore, so the new bubble's index is length-1.
    final AnimatedListState? listState = _listKey.currentState;
    if (listState != null) {
      listState.insertItem(
        _store.length - 1,
        duration: const Duration(milliseconds: 250),
      );
    }
    _scrollToBottom();
  }

  void _onSend(String text) {
    _store.send(
      text,
      onUserAppended: _appendBubble,
      onTypingChanged: (bool t) {
        setState(() {
          _typing = t;
        });
      },
      onBotAppended: _appendBubble,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key('chat-appbar'),
        title: const Text('chat_ui'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: AnimatedList(
              key: _listKey,
              controller: _scroll,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              initialItemCount: 0,
              itemBuilder: (
                BuildContext _,
                int index,
                Animation<double> animation,
              ) {
                final ChatMessage m = _store.messages[index];
                return MessageBubble(
                  key: ValueKey<int>(m.id),
                  message: m,
                  animation: animation,
                );
              },
            ),
          ),
          if (_typing) const TypingIndicator(),
          Composer(onSend: _onSend),
        ],
      ),
    );
  }
}
