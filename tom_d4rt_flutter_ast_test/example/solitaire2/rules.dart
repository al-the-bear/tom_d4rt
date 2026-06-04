import 'package:flutter/material.dart';

class _RuleItem {
  final IconData icon;
  final String title;
  final String body;
  const _RuleItem(this.icon, this.title, this.body);
}

const List<_RuleItem> _rules = [
  _RuleItem(
    Icons.flag_outlined,
    'Objective',
    'Move all 52 cards onto the four foundation piles, each one built up by '
        'suit from Ace through King.',
  ),
  _RuleItem(
    Icons.style_outlined,
    'Stock & Waste',
    'Tap the face-down stock pile (top-left) to deal the next card to the '
        'waste. When the stock is empty, tap it again to flip the waste back '
        'over and start again.',
  ),
  _RuleItem(
    Icons.view_column_outlined,
    'Tableau Columns',
    'The seven columns at the bottom. Build sequences DOWN by rank with '
        'ALTERNATING colors — e.g. a black 6 on a red 7.',
  ),
  _RuleItem(
    Icons.workspace_premium_outlined,
    'Foundations',
    'Build each foundation UP by rank within a single suit, starting with the '
        'Ace and ending with the King.',
  ),
  _RuleItem(
    Icons.crop_square,
    'Empty Columns',
    'Only a King (alone or carrying a sequence) may be placed on an empty '
        'tableau column.',
  ),
  _RuleItem(
    Icons.drag_indicator,
    'Moving Cards',
    'Drag a single face-up card, or grab anywhere in a face-up run to move '
        'the whole sequence together.',
  ),
  _RuleItem(
    Icons.flip,
    'Auto-Flip',
    'When a face-down card is uncovered at the bottom of a tableau column, '
        'it flips face-up automatically.',
  ),
  _RuleItem(
    Icons.emoji_events_outlined,
    'Winning',
    'You win when all four foundations show a King on top — every card home '
        'and sorted.',
  ),
];

class RulesContent extends StatelessWidget {
  const RulesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(_rules.length, (i) {
        final item = _rules[i];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(item.icon, color: Colors.white.withOpacity(0.85), size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item.body,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 13,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

/// Side-rail rules panel (used on wide layouts).
class RulesSide extends StatelessWidget {
  const RulesSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.25),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Icon(Icons.menu_book, color: Colors.white, size: 22),
                    SizedBox(width: 8),
                    Text(
                      'How to Play',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              RulesContent(),
            ],
          ),
        ),
      ),
    );
  }
}

/// Collapsible rules panel that flips open beneath the game (used on narrow
/// layouts where there isn't room for a side rail).
class RulesFlip extends StatefulWidget {
  const RulesFlip({super.key});

  @override
  State<RulesFlip> createState() => _RulesFlipState();
}

class _RulesFlipState extends State<RulesFlip> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.35),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => setState(() => _open = !_open),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Icon(Icons.menu_book, color: Colors.white, size: 20),
                  const SizedBox(width: 12),
                  const Text(
                    'How to Play',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    _open ? 'Hide' : 'Show',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 6),
                  AnimatedRotation(
                    turns: _open ? 0.5 : 0,
                    duration: const Duration(milliseconds: 220),
                    child: const Icon(Icons.expand_more, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity, height: 0),
            secondChild: SizedBox(
              width: double.infinity,
              height: 240,
              child: const SingleChildScrollView(child: RulesContent()),
            ),
            crossFadeState: _open
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 240),
          ),
        ],
      ),
    );
  }
}
