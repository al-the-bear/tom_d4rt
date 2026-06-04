import 'dart:math';

enum Suit { spades, hearts, diamonds, clubs }

class PlayingCard {
  final Suit suit;
  final int rank; // 1=A .. 13=K
  bool faceUp;
  PlayingCard(this.suit, this.rank, {this.faceUp = false});

  bool get isRed => suit == Suit.hearts || suit == Suit.diamonds;

  String get rankStr {
    switch (rank) {
      case 1:
        return 'A';
      case 11:
        return 'J';
      case 12:
        return 'Q';
      case 13:
        return 'K';
      default:
        return '$rank';
    }
  }

  String get suitStr {
    switch (suit) {
      case Suit.spades:
        return '\u2660';
      case Suit.hearts:
        return '\u2665';
      case Suit.diamonds:
        return '\u2666';
      case Suit.clubs:
        return '\u2663';
    }
  }

  String get rankName {
    switch (rank) {
      case 1:
        return 'Ace';
      case 11:
        return 'Jack';
      case 12:
        return 'Queen';
      case 13:
        return 'King';
      default:
        return '$rank';
    }
  }

  String get label => '$rankStr$suitStr';
}

/// Cards being dragged plus where they came from.
class DragPayload {
  final List<PlayingCard> cards;
  final String source; // 'waste', 'foundation:i', 'tableau:i:idx'
  const DragPayload(this.cards, this.source);
}

class Solitaire {
  List<PlayingCard> stock = [];
  List<PlayingCard> waste = [];
  List<List<PlayingCard>> foundations =
      List.generate(4, (_) => <PlayingCard>[]);
  List<List<PlayingCard>> tableau =
      List.generate(7, (_) => <PlayingCard>[]);

  final List<_Snapshot> _history = [];

  void newGame([int? seed]) {
    final rng = Random(seed);
    final deck = <PlayingCard>[];
    for (final s in Suit.values) {
      for (var r = 1; r <= 13; r++) {
        deck.add(PlayingCard(s, r));
      }
    }
    deck.shuffle(rng);

    stock = [];
    waste = [];
    foundations = List.generate(4, (_) => <PlayingCard>[]);
    tableau = List.generate(7, (_) => <PlayingCard>[]);

    var idx = 0;
    for (var col = 0; col < 7; col++) {
      for (var row = 0; row <= col; row++) {
        final c = deck[idx];
        idx++;
        c.faceUp = (row == col);
        tableau[col].add(c);
      }
    }
    while (idx < deck.length) {
      final c = deck[idx];
      idx++;
      c.faceUp = false;
      stock.add(c);
    }
    _history.clear();
    print('New game dealt.');
  }

  bool get isWon => foundations.every((f) => f.length == 13);

  void _snapshot() {
    _history.add(_Snapshot.from(this));
    if (_history.length > 200) {
      _history.removeAt(0);
    }
  }

  bool undo() {
    if (_history.isEmpty) return false;
    final s = _history.removeLast();
    s.applyTo(this);
    print('Undo.');
    return true;
  }

  // -------- Stock --------

  String? drawFromStock() {
    if (stock.isEmpty && waste.isEmpty) {
      return 'The stock and waste are both empty — there is nothing left to deal.';
    }
    _snapshot();
    if (stock.isEmpty) {
      // recycle waste back to stock
      while (waste.isNotEmpty) {
        final c = waste.removeLast();
        c.faceUp = false;
        stock.add(c);
      }
      print('Recycled waste back to stock.');
    } else {
      final c = stock.removeLast();
      c.faceUp = true;
      waste.add(c);
      print('Dealt ${c.label} to waste.');
    }
    return null;
  }

  // -------- Moves --------

  String? moveToTableau(DragPayload p, int destIdx) {
    if (p.cards.isEmpty) return 'No card selected.';
    // No-op move to same pile/position.
    if (p.source == 'tableau:$destIdx:${tableau[destIdx].length - p.cards.length}') {
      return null;
    }
    final first = p.cards.first;
    final dest = tableau[destIdx];
    if (dest.isEmpty) {
      if (first.rank != 13) {
        return 'Only a King may start an empty tableau column — '
            '${first.rankName} of ${_suitWord(first.suit)} cannot go there.';
      }
    } else {
      final top = dest.last;
      if (!top.faceUp) {
        return 'You cannot stack onto a face-down card.';
      }
      if (first.isRed == top.isRed) {
        return 'Tableau columns alternate colors — '
            '${first.label} (${first.isRed ? 'red' : 'black'}) cannot sit on '
            '${top.label} (${top.isRed ? 'red' : 'black'}).';
      }
      if (first.rank != top.rank - 1) {
        return 'Tableau columns build DOWN by one — '
            '${first.rankName} cannot follow ${top.rankName}.';
      }
    }
    _snapshot();
    final taken = _takeFromSource(p);
    dest.addAll(taken);
    _flipExposed();
    print('Moved ${taken.length} card(s) from ${p.source} to tableau $destIdx.');
    return null;
  }

  String? moveToFoundation(DragPayload p, int destIdx) {
    if (p.cards.isEmpty) return 'No card selected.';
    if (p.cards.length != 1) {
      return 'Foundations only accept one card at a time — '
          'drop the sequence on a tableau column instead.';
    }
    final card = p.cards.first;
    final dest = foundations[destIdx];
    if (dest.isEmpty) {
      if (card.rank != 1) {
        return 'A foundation must start with an Ace — '
            '${card.rankName} of ${_suitWord(card.suit)} cannot start it.';
      }
    } else {
      final top = dest.last;
      if (top.suit != card.suit) {
        return 'Foundations build by SUIT — '
            '${_suitWord(card.suit)} cannot go on ${_suitWord(top.suit)}.';
      }
      if (card.rank != top.rank + 1) {
        return 'Foundations build UP by one — '
            '${card.rankName} cannot follow ${top.rankName}.';
      }
    }
    _snapshot();
    _takeFromSource(p);
    dest.add(card);
    _flipExposed();
    print('Moved ${card.label} to foundation $destIdx.');
    return null;
  }

  /// Try to auto-send a single card to whichever foundation accepts it.
  String? autoToFoundation(DragPayload p) {
    if (p.cards.length != 1) {
      return 'Only single cards can be auto-collected to foundations.';
    }
    final card = p.cards.first;
    for (var i = 0; i < 4; i++) {
      final f = foundations[i];
      if (f.isEmpty && card.rank == 1) {
        return moveToFoundation(p, i);
      }
      if (f.isNotEmpty &&
          f.last.suit == card.suit &&
          card.rank == f.last.rank + 1) {
        return moveToFoundation(p, i);
      }
    }
    return 'No foundation will accept ${card.label} yet.';
  }

  // -------- Helpers --------

  List<PlayingCard> _takeFromSource(DragPayload p) {
    final src = p.source;
    if (src == 'waste') {
      return [waste.removeLast()];
    }
    if (src.startsWith('foundation:')) {
      final i = int.parse(src.substring('foundation:'.length));
      return [foundations[i].removeLast()];
    }
    if (src.startsWith('tableau:')) {
      final parts = src.split(':');
      final i = int.parse(parts[1]);
      final idx = int.parse(parts[2]);
      final pile = tableau[i];
      final taken = pile.sublist(idx);
      pile.removeRange(idx, pile.length);
      return taken;
    }
    return [];
  }

  void _flipExposed() {
    for (final pile in tableau) {
      if (pile.isNotEmpty && !pile.last.faceUp) {
        pile.last.faceUp = true;
      }
    }
  }

  String _suitWord(Suit s) {
    switch (s) {
      case Suit.spades:
        return 'Spades';
      case Suit.hearts:
        return 'Hearts';
      case Suit.diamonds:
        return 'Diamonds';
      case Suit.clubs:
        return 'Clubs';
    }
  }
}

class _Snapshot {
  final List<PlayingCard> stock;
  final List<PlayingCard> waste;
  final List<List<PlayingCard>> foundations;
  final List<List<PlayingCard>> tableau;

  _Snapshot(this.stock, this.waste, this.foundations, this.tableau);

  factory _Snapshot.from(Solitaire s) {
    List<PlayingCard> cp(List<PlayingCard> l) => l
        .map((c) => PlayingCard(c.suit, c.rank, faceUp: c.faceUp))
        .toList();
    return _Snapshot(
      cp(s.stock),
      cp(s.waste),
      s.foundations.map(cp).toList(),
      s.tableau.map(cp).toList(),
    );
  }

  void applyTo(Solitaire s) {
    List<PlayingCard> cp(List<PlayingCard> l) => l
        .map((c) => PlayingCard(c.suit, c.rank, faceUp: c.faceUp))
        .toList();
    s.stock = cp(stock);
    s.waste = cp(waste);
    s.foundations = foundations.map(cp).toList();
    s.tableau = tableau.map(cp).toList();
  }
}
