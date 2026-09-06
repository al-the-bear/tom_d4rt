import 'dart:io';

import 'package:tom_d4rt/d4rt.dart';

/// `abstract class IOException implements Exception` — the root of every
/// `dart:io` error type.
///
/// It lives in its own file rather than beside any one of its subtypes because
/// it belongs to no single part of the library: `FileSystemException`,
/// `SocketException`, `HttpException` and `RedirectException` all sit under it,
/// and each is declared in a different source file.
///
/// **Why bridging it matters more than bridging a leaf.** The supertype edge
/// `IOException -> Exception` was registered long before this bridge existed,
/// so `FileSystemException` could reach `Exception` truthfully. But an edge is
/// not a class: with no bridge under the name, `on IOException catch (e)`
/// could not resolve a type at all, and the sync catch loop reads a failed type
/// lookup as "this clause does not match". The handler was dead code, and the
/// exception travelled past it into whatever came next — while the *less*
/// specific `on Exception catch` caught it. A handler that starts working when
/// you make it broader is the signature of that defect.
///
/// **Why `isAssignable` on a base type is safe here.** The predicate decides
/// which bridge claims a native object, so a root-level one can in principle
/// steal member dispatch from its own subtypes — an `IOException` bridge that
/// won the race would make `path` and `osError` stop resolving on a
/// `FileSystemException`. It does not, because every leaf declares its edge up
/// to `IOException`, and `Environment._filterToMostSpecific` eliminates any
/// match that appears in another match's transitive supertype set. The
/// registry is what keeps the leaf winning; the predicate only widens what can
/// be *caught*.
///
/// The class is abstract in the SDK, so there is no constructor to bridge. A
/// script that wants to raise one throws a concrete subtype.
class IOExceptionIo {
  static BridgedClass get definition => BridgedClass(
    nativeType: IOException,
    name: 'IOException',
    isAssignable: (v) => v is IOException,
    typeParameterCount: 0,
    isAbstract: true,
    methods: {
      'toString': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as IOException).toString(),
    },
  );
}
