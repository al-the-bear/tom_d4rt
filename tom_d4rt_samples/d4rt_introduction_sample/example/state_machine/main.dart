// state_machine example: a turnstile modelled as a small state machine.
//
// Shows enums, a switch over an event type, and immutable state transitions.
// Single-file, so it also works as a stdin script:
//   cat example/state_machine/main.dart | ./run_example.sh

/// Events that can be applied to the turnstile.
enum Event { coin, push }

/// The two states of a turnstile.
enum TurnstileState { locked, unlocked }

/// The result of applying an event: the new state plus an action message.
class Transition {
  final TurnstileState state;
  final String action;
  Transition(this.state, this.action);
}

/// Pure transition function: given a state and event, return the next state.
Transition step(TurnstileState state, Event event) {
  switch (state) {
    case TurnstileState.locked:
      switch (event) {
        case Event.coin:
          return Transition(TurnstileState.unlocked, 'unlock');
        case Event.push:
          return Transition(TurnstileState.locked, 'no-op (pay first)');
      }
    case TurnstileState.unlocked:
      switch (event) {
        case Event.coin:
          return Transition(TurnstileState.unlocked, 'thank you (already paid)');
        case Event.push:
          return Transition(TurnstileState.locked, 'pass through, lock');
      }
  }
}

void main(List<String> args) {
  final events = [Event.push, Event.coin, Event.push, Event.push, Event.coin, Event.coin];

  var state = TurnstileState.locked;
  print('Turnstile starts: ${state.name}');
  for (final event in events) {
    final t = step(state, event);
    print('  ${event.name.padRight(5)} -> ${t.action.padRight(28)} (now ${t.state.name})');
    state = t.state;
  }
  print('Final state: ${state.name}');
}
