// Plain value object for a single chat message.
//
// Each message carries the text, who sent it (the local "user" or the
// scripted "bot"), and a monotonically increasing id so the test
// harness can reference specific bubbles by key.
class ChatMessage {
  final int id;
  final String text;
  final bool fromUser;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.fromUser,
  });

  @override
  String toString() => 'ChatMessage(id=$id, fromUser=$fromUser, text="$text")';
}
