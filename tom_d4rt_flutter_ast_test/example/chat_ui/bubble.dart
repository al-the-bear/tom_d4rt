// One chat bubble.
//
// Bubbles slide in from the side they belong to (left for the bot,
// right for the user) and fade up while sliding. The animation is
// driven by the parent `AnimatedList`'s `itemBuilder`, which passes
// in an `Animation<double>` running 0 → 1 as the item appears.
import 'package:flutter/material.dart';

import 'message.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final Animation<double> animation;

  const MessageBubble({
    super.key,
    required this.message,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final bool fromUser = message.fromUser;
    final Offset begin = fromUser
        ? const Offset(0.4, 0.0)
        : const Offset(-0.4, 0.0);
    final Color bg = fromUser
        ? const Color(0xFF1976D2)
        : const Color(0xFFE0E0E0);
    final Color fg = fromUser ? Colors.white : Colors.black87;
    final Alignment align =
        fromUser ? Alignment.centerRight : Alignment.centerLeft;

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: begin,
          end: Offset.zero,
        ).animate(animation),
        child: Align(
          alignment: align,
          child: Container(
            key: Key('bubble-${message.id}'),
            margin: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 4.0,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 10.0,
            ),
            constraints: const BoxConstraints(maxWidth: 280.0),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: Text(
              message.text,
              key: Key('bubble-text-${message.id}'),
              style: TextStyle(color: fg, fontSize: 14.0),
            ),
          ),
        ),
      ),
    );
  }
}

/// A simple "typing…" pill displayed at the end of the list while
/// the bot is composing its reply.
class TypingIndicator extends StatelessWidget {
  const TypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        key: const Key('typing-indicator'),
        margin: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 4.0,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 14.0,
          vertical: 10.0,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFEEEEEE),
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: const Text(
          'typing…',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 13.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
