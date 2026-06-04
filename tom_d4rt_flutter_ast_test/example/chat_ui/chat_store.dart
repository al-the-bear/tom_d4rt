// Scripted chat backend.
//
// `ChatStore` is a `ChangeNotifier`-style holder for the message
// list plus a small "bot" that echoes the user's last line after a
// short delay. The state is intentionally simple so the test
// harness can reason about it deterministically:
//
//   • `messages` — the list shown in the UI, oldest first.
//   • `typing`   — whether the bot is currently composing a reply.
//   • `send()`   — append a user message, start the bot delay, then
//                   append the bot reply.
//
// The bot reply is delivered via `Stream.fromFuture(...)`, exercising
// that bit of dart:async as the plan calls for. The listener
// callbacks fed in by `ChatHome` actually mutate the UI state.
//
// ignore_for_file: avoid_print
import 'dart:async';

import 'message.dart';

class ChatStore {
  final List<ChatMessage> _messages = <ChatMessage>[];
  int _nextId = 1;
  bool _typing = false;

  List<ChatMessage> get messages => _messages;
  bool get typing => _typing;
  int get length => _messages.length;

  /// Sends a user message and queues a bot reply.
  ///
  /// Callbacks fire in this order:
  ///   1. `onUserAppended(userMessage)` — synchronous.
  ///   2. `onTypingChanged(true)`       — synchronous (before delay).
  ///   3. `onBotAppended(botMessage)`   — asynchronous, after
  ///      `replyDelay`. The bot stops typing right before this fires.
  ///
  /// Returns the queued bot's `Future<ChatMessage>` so the caller
  /// can `await` completion in tests if needed.
  Future<ChatMessage> send(
    String text, {
    required void Function(ChatMessage) onUserAppended,
    required void Function(bool) onTypingChanged,
    required void Function(ChatMessage) onBotAppended,
    Duration replyDelay = const Duration(milliseconds: 250),
  }) {
    final String trimmed = text.trim();
    if (trimmed.isEmpty) {
      print('chat.send rejected=empty');
      return Future<ChatMessage>.value(
        const ChatMessage(id: -1, text: '', fromUser: false),
      );
    }

    final ChatMessage user = ChatMessage(
      id: _nextId,
      text: trimmed,
      fromUser: true,
    );
    _nextId = _nextId + 1;
    _messages.add(user);
    onUserAppended(user);
    print('chat.user.append id=${user.id} text="${user.text}"');

    _typing = true;
    onTypingChanged(true);
    print('chat.typing on');

    // Stream.fromFuture exercises dart:async wiring even though we
    // only ever emit a single event — same shape the plan asks for.
    final Stream<ChatMessage> botStream = Stream<ChatMessage>.fromFuture(
      Future<ChatMessage>.delayed(replyDelay, () {
        final ChatMessage bot = ChatMessage(
          id: _nextId,
          text: _reply(trimmed),
          fromUser: false,
        );
        _nextId = _nextId + 1;
        return bot;
      }),
    );

    final Completer<ChatMessage> completer = Completer<ChatMessage>();
    botStream.listen((ChatMessage bot) {
      _typing = false;
      onTypingChanged(false);
      print('chat.typing off');
      _messages.add(bot);
      onBotAppended(bot);
      print('chat.bot.append id=${bot.id} text="${bot.text}"');
      if (!completer.isCompleted) completer.complete(bot);
    });
    return completer.future;
  }

  String _reply(String userText) {
    // Deterministic echo so the test can assert exact bubble text.
    return 'echo: $userText';
  }
}
