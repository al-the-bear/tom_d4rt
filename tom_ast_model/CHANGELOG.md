## 0.2.0

- **Add `SRecordTypeField`** — the fields of a record type *annotation*
  (`int` and `String label` in `(int, {String label})`) were previously
  unrepresentable, so a converter had nowhere to put them and dropped them into
  an opaque placeholder. The arity survived; the field types and the named-field
  keys did not, which left the interpreter unable to answer
  `(42, label: 'answer') is (int, {String label})`.
- **Breaking:** `SRecordTypeAnnotation.positionalFields` / `.namedFields` are now
  `List<SRecordTypeField>` instead of `List<SAstNode>`, so a consumer cannot
  silently receive a field it can read nothing off. Bundles serialised before
  this version still deserialise — their fields come back typeless and nameless
  rather than being dropped, which preserves the recorded arity.

## 0.1.3

- Housekeeping: test artifacts now live in a gitignored `testlog/` folder; `doc/` no longer ships machine-generated baselines or last_testrun.json. No code changes.

## 0.1.2

- Documentation: limitations and user guide updated; README aligned with the
  source-primary documentation reframe across the D4rt ecosystem.

## 0.1.1

- Add `StaticResolver` and the `resolvedSlot` / `declSlot` node fields that
  back the interpreter's slot-based variable resolution (static name → frame
  slot binding computed once, replacing per-access map lookups).
- Add `ForEachPartsWithPattern` support so pattern-destructuring `for-in`
  loops round-trip through the serializable AST.

## 0.1.0

- Initial release — extracted from `tom_d4rt_ast`
- Pure AST model classes with JSON serialization
- Zero external dependencies