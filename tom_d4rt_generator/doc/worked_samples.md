# Worked samples — runnable apps that exercise the generated bridges

The generator's output is only as good as the scripts it lets the interpreter
run. This catalog maps the **multi-file sample apps** under
`tom_d4rt_flutter_test/example/` to the generation mechanisms (categories A–D,
see [index.md](index.md)) and interpreter behaviours they exercise, and points
at the harness that runs them. It is the worked-samples reference for P&R #7 —
the prose half that does not depend on the deferred annotation-driven emission.

> The samples are **interpreted Dart**: the host registers the flutter-material
> bridges (`SourceFlutterD4rt`), then `buildMultiFile` interprets
> `example/<app>/main.dart` (and its part files) and returns a live `Widget`
> tree. No app rebuild, no codegen at run time.

---

## The runner harness

`tom_d4rt_flutter_test/test/sample_apps_in_tester_test.dart` is the executable
harness: it calls `SourceFlutterD4rt.buildMultiFile` **inside a
`WidgetTester`**, so each sample is `tester.tap()`-driven and its interpreted
state is asserted against the rendered UI. Because it loads the
flutter-material bridge corpus and uses the shared HTTP companion app, it runs
under the **serial `flutter test` gate** (parallel runs corrupt results — see
the quest rule).

The drift guard `tom_d4rt_generator/test/worked_samples_doc_test.dart`
(`G-WSD-*`) is the byte-safe complement: a pure-Dart test that parses **this
doc** and asserts every sample it names still exists on disk
(`example/<app>/main.dart`), so a renamed or deleted sample fails CI here long
before the (heavier) flutter harness runs. That keeps the catalog from
silently rotting without depending on the serial gate.

---

## Catalog — sample → mechanism

Each row names the live mechanism the sample exercises (verifiable from its
source and asserted by the harness group named in the last column).

| Sample | Live mechanism exercised | Harness group |
|--------|--------------------------|---------------|
| `counter_app` | User-defined `State.setState` schedules a rebuild (the GEN-112 interpreter fix); multi-file user `State<T>` subclass. | counter_app (multi-file user-defined State) |
| `calculator` | Multi-file user `State`, `LongPressDraggable`/gesture callbacks, list-backed history strip; pure interpreted compute engine. | calculator |
| `clock_face` | `AnimationController` + `Ticker` driving a repainting `CustomPainter` proxy (category **D** `D4rt*` proxy class). | clock_face |
| `stopwatch_laps` | `Timer.periodic` + `AnimationController` + `ListView` lap history; accumulating interpreted state. | stopwatch_laps |
| `tip_calculator` | Multi-file user `State`, `DropdownButton`, locale/currency formatting; reactive recompute on input. | tip_calculator |

These five exercise the **proxy (D)** and **interpreter-runtime** fix paths that
are already live: the `CustomPainter` / `AnimationController` proxy classes the
generator emits, and the user-defined `State.setState` rebuild path. They are
the worked samples for those paths.

---

## What is NOT yet demonstrated here (pending live emission)

P&R #7 b also calls for samples that demonstrate the **missing-relaxer error**
(step 2) and the **type-relaxation / annotation-driven** fix paths (steps 4 and
6). None of the catalogued samples exercise a multi-type-parameter generic or a
wildcard-relaxer variant, because the **annotation-driven proxy/relaxer
emission (P&R #6 c) is not wired into live generation yet** — there is no
generated `TomFormList<TElement, TForm>` relaxer for a sample to call. Authoring
those purpose-built samples, and embedding their scripts as runnable snippets in
the docs, is the deferred tail (see *Status* below). The directive core that
those samples will eventually drive is documented in
[user_proxy_relaxer_annotations.md](user_proxy_relaxer_annotations.md).

---

## Status — shipped reference vs. deferred tail

**Shipped (byte-safe):** this catalog (grounded in the existing runnable
samples + the in-tester harness) and the `G-WSD-*` drift guard that pins the
doc's sample references to real files.

**Deferred (flutter-gated, blocked on P&R #6 c emission — see
`todo_impossible.md` #16):**

- Purpose-built worked samples demonstrating the step-2 missing-relaxer error
  and the step-4 (reduction-config) / step-6 (annotation-driven variant)
  fix paths — they need the emission live so the "fixed" path actually
  generates a relaxer/proxy a sample can call.
- The docs-embedded executable-script check that runs each documented snippet
  through the runner — the in-process runner is `SourceFlutterD4rt`, so the
  check is a `flutter test` under the serial gate.
