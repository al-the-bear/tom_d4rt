/// The SDK error types the interpreter raises for operations that produce them
/// in real Dart.
///
/// Before SCB10 every error the interpreter raised *itself* was a
/// `RuntimeD4rtException`, so `on TypeError` / `on NoSuchMethodError` /
/// `on RangeError` / `on AssertionError` in interpreted code could never match
/// the operation that should have produced it — no matter which bridges were
/// registered. Errors thrown by a *native* callee were already fine; this file
/// covers only the sites where the interpreter is the thrower.
///
/// **These types `implement` rather than `extend`, and that is the point.**
/// `TypeError` and `NoSuchMethodError` offer no constructor that accepts a
/// message (`TypeError()` takes none; `NoSuchMethodError.withInvocation`
/// composes its own from the invocation). Using them directly would have thrown
/// away d4rt's diagnostics — messages that name the receiver, the member and
/// the failed extension-method lookup, which is why the interpreter used its own
/// exception type in the first place. Declaring `implements` keeps
/// `value is TypeError` true, so the SC5 bridges claim these instances and `on`
/// clauses match, while `toString()` still returns the message d4rt composed.
/// The SDK does the same thing for the same reason: `_TypeError` and
/// `_AssertionError` are private subtypes that exist to carry a message.
///
/// Consequence worth knowing: because the messages are preserved verbatim, this
/// change is visible *only* in the type of the thrown value. No existing
/// message assertion needed rewriting, which keeps the diff honest about which
/// contract moved.
///
/// **There is no `isSdkShapedError` here any more, and its absence is the
/// point.** SCB10 needed one: `execute()`'s catch-all relabelled anything it
/// did not recognise as `Unexpected error: …`, so without a carve-out for the
/// four types above, a script whose own `assert` failed reached its host
/// reading `Unexpected error: Assertion failed` — the shape made catchable
/// *inside* a script, destroyed on the way *out* of one. The carve-out was
/// correct and deliberately narrow, but it left a boundary nobody could
/// predict: four types escaped by type, everything else was rewritten. SCC27
/// replaced it with a rule that needs no list — anything that is an `Error` or
/// an `Exception` escapes as itself — which left the predicate with no call
/// site. See `throwAsHostFacingError` in `exceptions.dart`.
library;

/// A `TypeError` carrying d4rt's own diagnostic.
///
/// Raised for a failing `as` cast and for the `!` null-check operator — real
/// Dart raises `TypeError` (`_TypeError`) for both.
class D4rtTypeError extends Error implements TypeError {
  D4rtTypeError(this.message);

  final String message;

  @override
  String toString() => message;
}

/// A `NoSuchMethodError` carrying d4rt's own diagnostic.
///
/// Raised when a member lookup finally fails, *after* extension-method
/// resolution and any user-defined `noSuchMethod` have been given their chance.
///
/// Only the final sites raise this. The interpreter's intermediate
/// member-lookup failures raise `UndefinedMemberD4rtException` instead — the
/// typed signal several call sites read to decide whether to attempt extension
/// lookup. The distinction is the *stage*, not the wording: this type marks a
/// lookup that has run out of answers, that one asks a question the caller is
/// still deciding. Both carry d4rt's message verbatim.
class D4rtNoSuchMethodError extends Error implements NoSuchMethodError {
  D4rtNoSuchMethodError(this.message);

  final String message;

  @override
  String toString() => message;
}

/// The `RangeError` the platform raises for an out-of-range index.
///
/// **A plain `RangeError`, deliberately not an `IndexError`.** `IndexError` is a
/// `RangeError` subtype and looks like the better fit, but the SDK's `List.[]`
/// does not use it: the VM raises a plain `RangeError`, and `on IndexError` does
/// **not** catch an out-of-range list access. Raising `IndexError` here would
/// make d4rt strictly *more* catchable than the platform, so a script written
/// against d4rt with `on IndexError` would break once compiled.
///
/// [length] may be 0, in which case `end` is -1 — below `start`.
/// `RangeError.range` accepts that and reports "Valid value range is empty",
/// matching what the platform says for an empty container.
RangeError indexRangeError(int index, int length) =>
    RangeError.range(index, 0, length - 1, 'index');
