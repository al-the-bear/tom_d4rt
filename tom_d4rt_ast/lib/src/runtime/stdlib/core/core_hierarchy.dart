import 'package:tom_d4rt_ast/runtime.dart';

/// Supertype edges for the non-error half of `dart:core`.
///
/// The sibling of `ErrorHierarchyCore`, which declares the `Error` /`Exception`
/// chain in the same library. Everything outside that chain had no edges at
/// all, so the type tests a generic-bounded script writes all answered
/// `false` — a `T extends Comparable&lt;T&gt;` bound, an `on Pattern`
/// extension, an `is StringSink` guard.
///
/// **Why the edge is the only mechanism for most of these.** `ComparableCore`,
/// `PatternCore` and `StringSinkCore` declare no `isAssignable` predicate, so
/// the fallback that quietly answered `Uint8List is List` before the
/// typed-data edges existed has nothing to fire on here: a bridge with no
/// predicate is reachable only through a direct `Type` match or a registered
/// edge, and `Comparable` is never the runtime type of anything. That is also
/// why declaring these edges cannot disturb dispatch — a bridge that cannot win
/// the `isAssignable` pass cannot start winning it because the registry learned
/// about it.
///
/// **`int -> num` and `double -> num` are the exception**, and the only edges
/// here that were already `true` before this block existed. `num` does carry a
/// predicate, so those two answers came from the fallback with nothing declared
/// behind them — the same "satisfied anyway" bucket the eleven typed-data
/// `-> List` edges sat in. They are declared for the same two reasons: the
/// hierarchy should read as the SDK writes it, and feeding the registry lets
/// `Environment._filterToMostSpecific` DROP the `num` match in favour of the
/// more specific `int`, which makes dispatch more exact rather than less.
/// `int` and `double` are on every hot path in the interpreter, so that claim
/// is pinned rather than argued: see the `F-SCC56-3x` cases in
/// `test/stdlib/core/core_hierarchy_test.dart`.
///
/// Each edge is declared ONCE, mirroring the SDK's own `implements` /`extends`
/// clause; the transitive closure is computed by the registry walk. `1 is
/// Comparable` is answered by following `int -> num -> Comparable`, not by
/// restating it — spelling closures out by hand is what hid the depth defect
/// SCC19 fixed, and a block written that way passes its own tests without ever
/// exercising the walk.
///
/// The registry keys on NAME, so `register()` must run after the bridges these
/// names refer to are defined.
class CoreHierarchyCore {
  static void register() {
    BridgedClass.registerSupertypes(const {
      // The numeric tower. `abstract class num implements Comparable<num>`,
      // and both primitives extend `num` — so `Comparable` is reached at two
      // hops and is declared on `num` alone.
      'int': ['num'],
      'double': ['num'],
      'num': ['Comparable'],
      // The remaining comparables, each `implements Comparable<Self>`.
      'BigInt': ['Comparable'],
      'DateTime': ['Comparable'],
      'Duration': ['Comparable'],
      // `final class String implements Comparable<String>, Pattern`. The
      // `Pattern` half is the one edge in this block that a member could have
      // depended on — `matchAsPrefix` and `allMatches` come from `Pattern` —
      // but the `String` bridge declares both directly, so this buys type
      // tests only.
      'String': ['Comparable', 'Pattern'],
      'RegExp': ['Pattern'],
      // `abstract class RegExpMatch implements Match`. Already true before
      // this block, via `MatchCore`'s `isAssignable`; declared so the
      // hierarchy is readable from one place rather than inferred from a
      // predicate three files away.
      'RegExpMatch': ['Match'],
      'Runes': ['Iterable'],
      'StringBuffer': ['StringSink'],
    });
  }
}
