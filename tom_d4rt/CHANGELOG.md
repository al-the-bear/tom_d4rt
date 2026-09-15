## 1.126.0

### Fixed - `MapEntry.hashCode` was not readable as a value (scd196)

`hashCode` was registered in `MapEntry`'s `methods` map with no getter beside
it, so `e.hashCode` — the spelling every Dart program uses — returned the bound
callable and only the uncompilable `e.hashCode()` produced an int. Nothing
masked it: `map.entries.first.hashCode` silently was not a hash. That is SCC73's
`Runes.iterator` failure, unmasked. It is a getter now.

`IOSink.toString` was registered as a getter; `toString` is a method, so
`f.toString` yielded a String where Dart yields a tear-off. Deleted.

### Fixed - five members declared in two maps at once (scd196)

`hashCode` appeared in both `methods` and `getters` on `Match`, `Pattern` and
`Sink`; `toString` in both on `IsolateSpawnException` and `RemoteError`. The
interpreter reads getters first so the duplicates were inert on the paths a
script takes, but `BridgedInstance.get` is methods-first and would hand back the
bound callable. The wrong entry is deleted in each case — `hashCode` is a
getter, `toString` is a method.

`scd196_member_map_disjointness_test.dart` (both trees) now fails if any bridge
declares one member in two maps. A getter/setter pair is ordinary Dart and is
not reported.

SCD189's SDK-kind guard also gained the implicit `Object` supertype in its walk.
A class declaring no supertype stopped the walk dead, so every inherited member
read as unspeakable — which is a pass. That gap is what hid both defects above.

