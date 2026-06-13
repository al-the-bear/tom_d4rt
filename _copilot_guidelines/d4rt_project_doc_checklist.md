# D4rt Per-Project Documentation Checklist

**Quest:** d4rt
**Status:** Standard — acceptance gate for Phase C of
`_ai/quests/d4rt/documentation_and_sample_consolidation_and_update.md`.

This is the required documentation set every D4rt project must ship
before it is published to pub.dev. A project "passes" Phase C only when
every item required for its category (below) is present, current, and
consistent with the guiding policies P1–P5 of the consolidation plan.

The D4rt repo root is `tom_ai/d4rt/` (git repo `tom_d4rt`). Twelve
projects ship from it; this checklist applies to all of them.

---

## Required doc set (baseline — every published project)

| # | Artifact | Path | Notes |
|---|----------|------|-------|
| D1 | Readme | `README.md` | Title, one-paragraph purpose, install snippet, minimal usage, dependency table, link to `doc/` guide. Version references must match `pubspec.yaml` (P4). |
| D2 | Changelog | `CHANGELOG.md` | Top entry matches current `pubspec.yaml` version (P4). No `0.0.1`/"TODO" placeholders. |
| D3 | User guide | `doc/<project>_user_guide.md` | Full guide, **or** a pointer file that links to the canonical base-project guide (allowed for `*_ast` variants and exec/cli entry points — see categories). |
| D4 | Configuration guide | `doc/<project>_configuration.md` | **Only where the project has a configuration surface** (`tom_d4rt_generator`'s `buildkit.yaml`, runner/engine knobs). Projects with no config surface omit this. |
| D5 | Limitations | `doc/<project>_limitations.md` | Per todo-2 canon: `tom_d4rt` owns the canonical `d4rt_limitations.md`; every other project ships a **delta** file (its own limits only) that backlinks to the canon. A project with genuinely no deltas ships an explicit "no project-specific limitations beyond the base — see `tom_d4rt`" note. |
| D6 | API summary | `doc/api/<project>_api_summary.md` | Generated/curated API surface summary per `_copilot_guidelines/dart/api_summary_creation.md`. Required for library projects; pointer allowed for thin entry-point/test/sample projects. |

**Shipping vs internal (P5).** Everything under `doc/` is user-facing.
Internal development notes, migration plans, quest trackers, and
cleanup logs do **not** belong in `doc/` — keep them under
`_copilot_guidelines/` or the quest folder.

**Naming uniformity.** Use the `<project>_user_guide.md`,
`<project>_configuration.md`, `<project>_limitations.md` pattern for
every project (replacing legacy names like
`interpreter_limits_and_workarounds.md`, `known_issues_macos.md`).

---

## Category rules

Each project belongs to one category. The category decides which of
D1–D6 are full documents vs pointers, and whether the
differences-only policy (P1) applies.

### A. Base / authoritative (full docs, no pointers)

- **tom_d4rt** — base interpreter; owns the canonical
  `doc/d4rt_limitations.md`. Full D1–D6.
- **tom_d4rt_generator** — bridge generator; largest config surface,
  so D4 (configuration guide) is mandatory and must cover the full
  `buildkit.yaml` model plus the new config knobs. Full D1–D6.

### B. AST variants — differences-only (P1)

Applies to **tom_d4rt_ast, tom_d4rt_flutter_ast,
tom_d4rt_flutter_ast_test, tom_ast_generator, tom_ast_model.**

- D3 user guide describes **only what differs** from the non-AST base
  (zero-dependency, mirror-`SAstNode` model, bundle pipeline,
  Flutter/web fit) and links to the base project's guide for shared
  semantics. Do not re-document shared interpreter behavior.
- D5 limitations is a **delta** file linking back to the base
  (`tom_d4rt` for interpreter semantics, `tom_d4rt_flutter` for the
  Flutter variant).
- D6 may be a pointer to the base API summary plus the delta surface.

### C. Entry-point / CLI (thin guides + pointers)

- **tom_d4rt_exec** — exec-specific guide (parse-via-analyzer →
  mirror AST → interpret; `eval`/`execute`; typed-execute API);
  links to tom_d4rt for language semantics. Reconcile D5 against the
  tom_d4rt canon.
- **tom_dcli_exec** — pointer-style guide; link to `tom_d4rt_dcli`
  for CLI/shell usage and to tom_d4rt for semantics.

### D. Flutter runtime

- **tom_d4rt_flutter** — full D3 covering `FlutterD4rt`,
  `buildMultiFile`, extension registration, and the
  performance/GC section. Needs CHANGELOG (D2 currently missing).
- **tom_d4rt_flutter_ast** — category B (differences-only vs
  tom_d4rt_flutter).

### E. Canonical sample homes (P2)

The three projects that own the extended/multi-file samples:

- **tom_d4rt_flutter_test** — raw-source Flutter widget samples.
- **tom_d4rt_flutter_ast_test** — compiled AST-bundle Flutter samples.
- **tom_d4rt_dcli** — CLI/shell samples.

For these, D3 doubles as the sample catalog: the README "Examples"
section / sample index must enumerate every shipped sample and record
any divergence decisions. D2 (CHANGELOG) currently missing for both
flutter sample projects. Every **non-canonical** project keeps at most
a couple of minimal snippets and points here via an
`example/README.md` or README "Examples" section.

### F. Internal harness (not published — reduced set)

- **tom_d4rt_test** — internal conformance harness. Not a published
  user package; ships D1 (README describing how to run the suite)
  only. Excluded from the pub-publish gate.

---

## Current gaps (audit snapshot, 2026-06-13)

Captured to seed Phase B/C work; re-verify at edit time.

| Project | Missing / action |
|---------|------------------|
| tom_d4rt | Ensure canonical `d4rt_limitations.md` + D6 API summary current. |
| tom_d4rt_ast | No user guide → add B-style D3; add `tom_d4rt_ast_limitations.md` delta. |
| tom_d4rt_exec | Trim duplicated `user_guide/`; reconcile D5 vs canon. |
| tom_ast_generator | No user guide → add B-style D3; add limitations delta; move fixtures out of `example/`. |
| tom_ast_model | No user guide → add B-style D3; add limitations delta or explicit "none". |
| tom_d4rt_generator | Complete D4 config guide (new knobs); apply README fixes (todos 4, 6). |
| tom_d4rt_flutter | No user guide → add D3; **add CHANGELOG**. |
| tom_d4rt_flutter_ast | B-style D3; fix broken cross-ref; **replace placeholder CHANGELOG**. |
| tom_d4rt_flutter_test | **Add CHANGELOG**; D3 sample catalog. |
| tom_d4rt_flutter_ast_test | **Add CHANGELOG**; no `doc/` folder yet; D3 sample catalog. |
| tom_d4rt_dcli | Reconcile README dep versions; D3 sample catalog (add extended samples). |
| tom_dcli_exec | No user guide → add pointer-style D3. |

> No project currently ships a `doc/api/` folder — D6 is a net-new
> deliverable across the family.

---

## Acceptance gate (use per project in Phase C)

A project passes when:

1. D1 README present; all version references match `pubspec.yaml` (P4).
2. D2 CHANGELOG present; top entry matches `pubspec.yaml` version.
3. D3 user guide present (full or pointer per category); for B
   projects it is differences-only and links to the base (P1).
4. D4 configuration guide present **iff** the project has a config
   surface.
5. D5 limitations present using the uniform name and the delta+backlink
   model (P5/todo-2 canon).
6. D6 API summary present (full or pointer per category).
7. No internal-only notes remain under `doc/` (P5).
8. `dart analyze` clean and the relevant test suite green (Phase G).
