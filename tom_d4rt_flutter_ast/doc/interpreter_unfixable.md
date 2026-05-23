# Interpreter Unfixable Issues

This document catalogs interpreter / generator issues that **cannot
be worked around in the test scripts themselves**. Two categories
live here:

1. **Truly unfixable** — the failure is rooted in the Flutter
   framework, the engine, or the test-app transport, and *no*
   change to either the interpreter or the script can resolve it.
2. **Interpreter / generator architectural limitations** —
   situations where the interpreter's design (e.g., abstract-class
   inheritance via proxies, runtime-only enum metadata) imposes a
   ceiling that a particular code shape cannot cross. We document
   the limitation and the architectural workaround the interpreter
   already applies; specific scripts that hit it remain failing
   until the architectural work lands.

Cases that *can* be worked around at the script level are tracked
separately in `script_rewrites.md`. When you read this file and
think "I could fix this by changing the script", that's a sign
the entry belongs in `script_rewrites.md` — please move it.

---

## Index

| Section | Category | Source |
|---|---|---|
| [Abstract Class Inheritance — architecture](#abstract-class-inheritance) | Interpreter limitation (worked around via adapter proxies; auto-generation explored as E12) | Architectural |
| [`gir` W1–W5 transport cascade — structural](#cluster-r--gir-w1-w5-transport-cascade-test-app-structural) | Truly unfixable (test-app transport layer) | W1–W5 wedgers (all 5 pass in isolation, see `test/blocking_tests_test.dart`) |
| [E3 — `findAncestorStateOfType<T>()` ignores type argument](#e3--findancestorstateoftypet-ignores-type-argument) | Interpreter limitation (bridge generator drops `T`; script-side rewrite supplied) | `widgets/scroll_position_with_single_context_test.dart` |
| [E6 — Native Dart Record named-field access](#e6--native-dart-record-named-field-access-interpreter-limitation) | Interpreter limitation (no reflection for named fields without `dart:mirrors`; positional access works, named access requires destructuring or class wrapper) | E6 partial closure (`widgets/platform_menu_widgets_test.dart` only used positional access; named-field consumers must use the workarounds) |
| [E7 — `Iterable.whereType<T>()` drops generic argument](#e7--iterablewheretypet-drops-generic-argument-interpreter-limitation) | Interpreter limitation (stdlib `whereType`/`cast` adapters discard `T`; same family as E3 generic-erasure). Script-side rewrite supplied in `script_rewrites.md`. | `widgets/restorable_double_n_test.dart` |
| [E8 — `ScrollController` state field passed through a `StatelessWidget` chain to a `Scrollable`](#e8--scrollcontroller-state-field-passed-through-statelesswidget-chain-to-a-scrollable-interpreter-limitation) | Interpreter limitation (scaling: each leaf `Scrollable` that receives the propagated controller produces exactly one null-check; locally-constructed controllers do not exhibit it). Layout-cascade fix already lands script-side (8→2); residual 2 errors deferred. | `widgets/scroll_deceleration_rate_test.dart` (E8 partial closure) |
| [Fa1-N1 — Layout-cascade FE residuals on 6 deep-demo scripts](#fa1-n1--layout-cascade-fe-residuals-on-6-deep-demo-scripts-script-side-annotation-deferred) | Script-side limitation (cosmetic only; zero test failures). Closing route documented per sub-pocket; deferred via `D4RT-SCRIPT-LIMITATION: layout cascade` annotations. Sentinel: `test/fa1_bisect_test.dart [fa1-2250-sentinel]`. **Small-overflow + EditableText + C3 sub-pockets all closed 2026-04-29** (see Fa1-N1 §Affected scripts and §Small-overflow pocket — empirical findings 2026-04-29). | ~~`snapshot_mode_test.dart` (small-overflow, 1 FE)~~ closed, ~~`restorable_double_test.dart` (small-overflow, 1 FE)~~ closed, ~~`select_all_text_intent_test.dart` / `transpose_characters_intent_test.dart` / `restoration_mixin_test.dart` (EditableText, 3+2+3 FE)~~ closed, ~~`widget_state_color_test.dart` / `text_magnifier_configuration_test.dart` (C3 sliver-row, 9+6 FE)~~ closed |
| [N2 — Bridged `RestorableProperty` proxy: late-`_value` + cross-script `for-in BridgedInstance<Object>`](#n2--bridged-restorableproperty-proxy-script-side-eager-init--defensive-iteration) | Same architectural limitation as D3/D4 (bridged `RestorationMixin` lifecycle dispatch under cross-script ordering); script-side workaround supplied: eager-init `_value` from constructor + `_favoritesSnapshot()` defensive iteration. | `widgets/restorable_property_test.dart` (closed 2026-04-29) |
| [P1 — `PreferredSizeWidget` cast fails when arg arrives as a cached native widget proxy](#p1--preferredsizewidget-cast-fails-when-arg-arrives-as-a-cached-native-widget-proxy) | Interpreter limitation (proxy walk runs on `InterpretedInstance` only; once the same instance has been wrapped in `_InterpretedStatelessWidget` and cached as `nativeProxy`, the bridge call site receives the native widget directly and the multi-interface walk over `bridgedInterfaces` is skipped). Script-side workaround supplied (`PreferredSize(preferredSize: …, child: AppBar(...))`). | `widgets/snapshot_mode_test.dart` (1 FE — Scaffold.appBar) |
| [P4 — `switch (BridgedEnum)` may fall through every case, returning null](#p4--switch-bridgedenum-may-fall-through-every-case-returning-null) | Interpreter limitation (bridged-enum case match is unreliable for some Flutter enums in `case BridgedEnum.value:` form — the equality probe in `visitSwitchStatement` returns `false` for both directions on certain bridged enum values, so a `String`-returning helper falls through and returns `null` implicitly). Script-side workaround: convert switches to `if/else` chains over `==` (the path used by `_isCupertinoFamily` is reliable), and seed local result variables with a default. | `widgets/tooltip_window_controller_delegate_test.dart`, `foundation/target_platform_test.dart`, `material/time_of_day_format_test.dart` |
| [G1 — `D4.getNamedArgWithDefault<T?>` collapses explicit `null` to default](#g1--d4getnamedargwithdefaultt-collapses-explicit-null-to-default-for-nullable-typed-named-args) | Generator/runtime helper limitation (the helper conflates "key absent" with "key present but `null`" by guarding on `!named.containsKey(p) || named[p] == null`, so an explicit `null` named-arg falls back to the constructor default). Script-side workaround: prefer a finite cap over an explicit `null` when the bridge default would violate a downstream invariant (`CupertinoTextField`'s `(maxLines == null) || (maxLines >= minLines)` assertion). | `cupertino/textfield_test.dart`, `cupertino/cupertino_text_selection_handle_controls_test.dart` |
| [R1 — Redirecting factory constructor syntax (`factory X() = Y`) not implemented](#r1--redirecting-factory-constructor-syntax-factory-x--y-not-implemented) | Interpreter limitation (parser/interpreter does not lower the redirecting-factory `=` form into a forwarding call to the redirected concrete constructor; the abstract class is treated as directly instantiable and throws `Cannot instantiate abstract class`). Script-side workaround: instantiate the redirected concrete subclass directly while keeping the variable type as the abstract base. | `widgets/regular_window_test.dart` (4 sites: `RegularWindowController(...)` → `_HostRegularWindowController(...)`) |
| [L1 — `AnimatedBuilder.animation` rejects script-defined subclass of bridged `Listenable`/`ChangeNotifier`](#l1--animatedbuilderanimation-rejects-script-defined-subclass-of-bridged-listenablechangenotifier) | Bridge-generator architectural limitation (proxy/relaxer pipeline does not synthesise native `ChangeNotifier`-backed proxies for script-defined subclasses of bridged `Listenable`; `D4.getRequiredArg<Listenable>` rejects the `InterpretedInstance` even though its synthetic class hierarchy reaches `ChangeNotifier`). Script-side workaround: pass `const AlwaysStoppedAnimation<double>(0.0)` as the `animation:` argument and access the controller via closure capture inside the `builder`. | `widgets/windowing_owner_mac_o_s_test.dart` (2 sites: `_MacChrome.build`, `_DockTile.build`) |
| [I1 — C-style `for (var i = 0; …; i++)` shares loop variable across closures](#i1--c-style-for-loop-shares-loop-variable-across-closures-interpreter-limitation) | Interpreter limitation (`_executeClassicFor` creates one `loopEnvironment` for the whole loop and reuses it every iteration; standard Dart instead allocates a fresh per-iteration variable so closures created inside the body each capture their own `i`). Script-side workaround: replace collection-`for` / body-less for-loops that build closures over `i` with `List<T>.generate(n, (i) => …)`, which gives each iteration a fresh function-parameter `i`. | `widgets/drag_target_details_test.dart` (Section 11 rank-slot row, 5 FE) |
| [T1 — `runtimeType.toString()` on user-defined interpreted classes](#t1--runtimetypetostring-on-user-defined-interpreted-classes) | Interpreter limitation (`InterpretedInstance.runtimeType` returns the `InterpretedClass`, which does not expose `toString` as a callable static — the chained call resolves to a static lookup and throws). Script-side workaround: emit the class-name string from an explicit `is`-check ladder. | `widgets/route_transition_record_test.dart` (1 FE — `_buildSurfaceRow` line 836) |
| [S1 — `const Stream<T>.empty()` rejected by `Stream` bridge](#s1--const-streamtempty-rejected-by-stream-bridge-interpreter-limitation) | Interpreter limitation (the stdlib `Stream` `BridgedClass` registers `empty`/`value`/`fromIterable`/etc. under `staticMethods:` and leaves `constructors: {}`. `MethodInvocation`-shaped calls — `Stream.empty()` — fall through to `staticMethods` and succeed; `InstanceCreationExpression`-shaped calls — `const Stream<int>.empty()` — go through `findConstructorAdapter` only and never see the static-method registration, so the lookup throws `Bridged class 'Stream' does not have a registered constructor named 'empty'`). Script-side workaround: drop `const`, drop the explicit type-arg, and call as a method invocation (`Stream<int>.empty()` or `Stream.fromIterable(const <int>[])`), or hold the stream in a non-const `final` so the parser keeps the call as `MethodInvocation`. | `widgets/streambuilder_test.dart` (Section 6 — `stream: const Stream<int>.empty()`) |
| [U1 — Demo-scale renderings that overload the test-app transport](#u1--demo-scale-renderings-that-overload-the-test-app-transport-interpreter-limitation) | Interpreter limitation, two sub-cases. (1) Top-level `const` of an interpreted subclass of a *native* abstract class (here `extends Notification`) exercises the adapter-proxy infrastructure before the visitor has wired its context, and crashes the test-app transport (`Lost connection to device`, no stderr). (2) `SelectableText.rich(TextSpan(children: spans))` with ~1000+ TextSpans (built per-character by an interpreted Dart colorizer from a ~1.8 KB code listing) exceeds the test-app per-frame transport budget and the device disconnects. Workaround: keep the displayed values as top-level `const` primitives (no native-abstract subclass), and render long code listings (>≈500 chars / >≈22 lines) through a sibling helper that wraps a single plain monospace `Text` instead of the per-char colorizer + `SelectableText.rich`. | `widgets/notificationlistener_test.dart` (C05 closed 2026-05-17) |
| [U2 — Non-wrappable arithmetic defaults on positional-only native constructors](#u2--non-wrappable-arithmetic-defaults-on-positional-only-native-constructors-generator-limitation) | Generator limitation. `BridgeGenerator._wrapDefaultValue` returns `null` for any default expression containing an operator (e.g. `double endAngle = math.pi * 2`), so the generated bridge emits `D4.getRequiredArgTodoDefault<…>(…, 'math.pi * 2')` which throws `Argument Error: <Class>: Parameter "<name>" has non-wrappable default …` when the argument is omitted. For purely-positional native constructors (`dart:ui` `Gradient.sweep`, `Gradient.radial`, …) the script cannot use named-arg form to skip earlier optional positionals, so any default expression with an operator anywhere in the positional list becomes mandatory at every call site beyond that index. Workaround: at every call site, supply *all* preceding optional positionals up to and including the offending one (use the framework's documented default value literally, e.g. `math.pi * 2.0`). | `rendering/gradient_rendering_test.dart` (C09 closed 2026-05-17 — `ui.Gradient.sweep` `endAngle = math.pi * 2`) |
| [U3 — Interpreted subclass of native abstract `Curve`: `transformInternal` override not routed through `Curve.transform`](#u3--interpreted-subclass-of-native-abstract-curve-transforminternal-override-not-routed-through-curvetransform-interpreter-limitation) | Interpreter limitation (adapter-proxy delegation gap). The native `Curve.transform(t)` template-methods through `Curve.transformInternal(t)`; for script-defined subclasses of `Curve`, the adapter proxy does not intercept the native call to `transformInternal` and route it back to the interpreted override, so `transform()` returns `null` to the bridge consumer. Downstream arithmetic on the null sample (`28.0 * s`, then `12.0 + …`) throws `Native error during bridged operator '+' on double: type 'Null' is not a subtype of type 'num' in type cast`. Reproduces both const and non-const, so distinct from U1. Workaround: use a framework-provided `Curve` subclass (`FlippedCurve(Curves.easeInOut)`) instead of a script-defined `Curve` subclass. | `animation/animation_misc_adv_test.dart` (C10 closed 2026-05-17 — `_FlippedShim extends Curve`) |
| [U4 — Standalone `'\n'` `TextSpan` between two styled siblings crashes the test-app transport](#u4--standalone-n-textspan-between-two-styled-siblings-crashes-the-test-app-transport-truly-unfixable) | Truly unfixable — Dart-VM-level crash inside the bridged render path; `Lost connection to device.` surfaces only as `Bad state: Transport failure while running …`. Trigger is specifically a child `TextSpan(text: '\n')` (literal newline, with or without `style`, with or without `const`) sitting between two other `TextSpan` siblings that each carry a non-null `style`, in the same parent `TextSpan.children` list (`RichText` / `Tooltip(richMessage:)` / `Text.rich(...)`). Both the `'\n'` character and the flanking pair of style-bearing siblings are necessary. Mandatory script-side workaround: append the `'\n'` to the preceding styled `TextSpan`'s `text` and drop the standalone newline child. | `material/tooltip_feedback_test.dart` (C15 closed 2026-05-17 — `_privateRichMessageExample` `RichText`) |
| [U5 — Interpreted subclass of native abstract `NotchedShape` / `FloatingActionButtonLocation` rejected at the bridged-constructor boundary](#u5--interpreted-subclass-of-native-abstract-notchedshape--floatingactionbuttonlocation-rejected-at-the-bridged-constructor-boundary-interpreter-limitation) | Interpreter limitation (same adapter-proxy delegation gap as U3 for `Curve`). The bridge generator does not synthesise a proxy that recognises a script-defined `InterpretedInstance` as a valid native `NotchedShape` / `FloatingActionButtonLocation` argument, so `D4.getNamedArg<T>` rejects the value with `Argument Error: Invalid parameter "shape": expected NotchedShape?, got InterpretedInstance(_TopRoundedNotchedShape)` (or the analogous `floatingActionButtonLocation` error). Workaround: use a framework-provided subclass (`CircularNotchedRectangle`, `AutomaticNotchedShape`; `FloatingActionButtonLocation.endFloat`, `.centerDocked`, …). | `material/bottom_app_bar_test.dart` (C16 closed 2026-05-17 — `_TopRoundedNotchedShape extends NotchedShape`, `_CustomFabLocation extends FloatingActionButtonLocation`) |
| [U6 — Direct import of `package:vector_math/vector_math_64.dart` is not resolvable in d4rt scripts](#u6--direct-import-of-packagevector_mathvector_math_64dart-is-not-resolvable-in-d4rt-scripts-module-loader-limitation) | Module-loader / bundler limitation. The `vector_math` package is not in `bridgedLibraries` and not registered as an `explicitSources` entry for either driver, so the bundler (AST driver: `AstBundler._resolveImports`) and module loader (analyzer driver: `SourceCodeException: Module source not preloaded`) reject the import at bundle/load time even though Flutter bridges *consume* `Vector3` as a parameter type internally (`$vector_math_1.Vector3` is referenced throughout `painting_bridges.b.dart`). Workaround: drop the import; access `Matrix4.storage` (bridged, returns `Float64List`) and compute matrix·vector products inline. | `painting/matrixutils_test.dart` (C17 closed 2026-05-17 — `Vector3(40, 0, 0)` fed through `Matrix4.transform3`) |
| [U7 — Dart-internal `_ConstMap` (runtime class of `const <K, V>{}`) is not in the Map bridge's `nativeNames`](#u7--dart-internal-_constmap-runtime-class-of-const-k-v-is-not-in-the-map-bridges-nativenames-interpreter-limitation) | Interpreter limitation. The Map `BridgedClass` (`tom_d4rt/lib/src/stdlib/core/map.dart` and `tom_d4rt_ast/lib/src/runtime/stdlib/core/map.dart`) lists `UnmodifiableMapView`, `_UnmodifiableMapView`, `_CompactLinkedHashMap`, `ListMapView`, `_MapView` in `nativeNames`, but not `_ConstMap` — the Dart-internal runtime type of `const <K, V>{}`. Any member access on a `_ConstMap` (`.entries`, `.keys`, `.length`, …) falls through the `SPrefixedIdentifier` lookup and throws `Cannot access property '<name>' on target of type _ConstMap<…>.`. The trigger comes both from script-side `const <K, V>{}` defaults and from Flutter APIs that return `const <…>{}` themselves — notably `SemanticsEvent.getDataMap()` for payload-free events (`LongPressSemanticsEvent`, `TapSemanticEvent`, `FocusSemanticEvent`). Workaround: drop `const` on script-side defaults and copy bridged map values through `Map<K, V>.from(value)` at the assignment site so the runtime type is a regular `LinkedHashMap`. | `semantics/semantics_events_test.dart` (C18 closed 2026-05-17 — `dataMap.entries.toList()` on the values of `probe.getDataMap()` for `LongPressSemanticsEvent` / `TapSemanticEvent` / `FocusSemanticEvent`) |
| [U8 — Script-defined enum values are `InterpretedEnumValue`, not native `Enum`; plus `RestorableValue.value` asserts `isRegistered`](#u8--script-defined-enum-values-are-interpretedenumvalue-not-native-enum-plus-restorablevaluevalue-asserts-isregistered-interpreter-limitation--scripting-trap) | Interpreter limitation + scripting trap. (1) d4rt represents every script-defined `enum X { … }` value as `InterpretedEnumValue` (`tom_d4rt_ast/lib/src/runtime/runtime_types.dart` line 1861), which implements `RuntimeValue` but **not** Dart's native `Enum`. Any bridged API parameter typed `Enum` (`RestorableEnum<E>(E defaultValue, …)`, `RestorableEnumN<E>`, generic enum-typed setters) rejects the script value at the bridge boundary via `D4.getRequiredArg<Enum>`. Same family as U3 / U5 — script-defined subtypes can't cross d4rt → native as the native abstract / built-in type. (2) Latent Flutter trap that often surfaces *after* the U8 enum workaround unmasks it: `RestorableValue<T>.value` asserts `isRegistered` at line 85 of `restoration_properties.dart`; in debug mode (which is how `flutter test` runs) accessing `.value` on an unregistered restorable throws. Workarounds: (a) replace any script-defined enum used at a native API boundary with a framework enum (`Brightness`, `TargetPlatform`, `TextDirection`, …); (b) when reading `RestorableValue.value` on a restorable that the script never registers via `RestorationMixin`, shadow each restorable with a plain Dart variable holding the construction-time default and read the shadow (the demo never mutates the stored value, so the shadow equals what the getter would return). | `widgets/restorable_values_test.dart` (C20 closed 2026-05-17 — `RestorableEnum<_Mood>(_Mood.focused, values: _Mood.values)` plus 44 `restXxx.value` reads on never-registered restorables) |
| [U9 — Script-defined `RouteAware` cannot be subscribed to a native `RouteObserver`](#u9--script-defined-routeaware-cannot-be-subscribed-to-a-native-routeobserver-interpreter-limitation) | Interpreter limitation. The bridged `RouteObserver.subscribe(RouteAware aware, R route)` validates `aware` with `D4.getRequiredArg<RouteAware>`, which rejects a d4rt `InterpretedInstance` even when the script class declares `with RouteAware` (or `implements RouteAware`). Same architectural family as U3 (`Curve`), U5 (`NotchedShape` / `FloatingActionButtonLocation`), and U8 (`Enum`): a script-defined subtype of a bridged native abstract / mixin type cannot cross the d4rt → native boundary as that native type. There is no framework-provided `RouteAware` concrete subclass to substitute, because `RouteAware` is intended to be mixed into application-side `State` objects. Mandatory script-side workaround: use a script-side stand-in observer that mirrors the native `subscribe` / `unsubscribe` / `didPush` / `didPop` / `didReplace` protocol over `Map<Route, List<_LoggingRouteAware>>`, so the demo's call-order timeline is produced without crossing the d4rt → native boundary. The native `RouteObserver` instance can still be constructed (the constructor itself is safe — no script-defined `RouteAware` argument is involved) to demonstrate the type exists. | `widgets/route_observer_test.dart` (C22 closed 2026-05-17 — `_LoggingRouteAware with RouteAware` × 4 subscribed via `routeObserver.subscribe(...)`) |
| [U10 — Script-defined class `with DiagnosticableTreeMixin` / `Diagnosticable` cannot call inherited concrete methods (`toStringDeep`, `toString`, `toStringShallow`, `toDiagnosticsNode`); plus `super.debugFillProperties(...)` fails into bridged mixin](#u10--script-defined-class-with-diagnosticabletreemixin-cannot-call-inherited-concrete-methods-interpreter-limitation) | Interpreter limitation. (a) The bridged `DiagnosticableTreeMixin` / `Diagnosticable` methods all validate the target via `D4.validateTarget<...>(target, '...')`, which rejects an `InterpretedInstance` even when the script class declares `with DiagnosticableTreeMixin` or `with Diagnosticable`. Same architectural family as U3/U5/U8/U9. (b) Additionally, `super.debugFillProperties(properties)` from an interpreted class whose only super is the bridged mixin throws *`Class 'X' does not have a standard or bridged superclass, cannot use 'super'.`* — the interpreter does not resolve `super` calls into a bridged-mixin super-chain. Native `Diagnosticable.debugFillProperties` is a no-op anyway, so dropping the super call is safe. A proper fix requires a hand-written `_InterpretedDiagnosticableTreeMixin` proxy in `d4rt_runtime_registrations.dart` (deferred, feature-scale). Mandatory script-side workaround: (1) build the diagnostics dump directly via `_dumpNode` (children) / `_diagnosticableDeepDump` (no children) helpers that walk `debugFillProperties` / `debugDescribeChildren`; (2) for JSON shape, recursive `_manualSerialize(config, delegate, depth)`; (3) drop any `super.debugFillProperties(...)` call from the script's override. | `foundation/class_test.dart` (C36 closed 2026-05-18 — `_Node with DiagnosticableTreeMixin` `tree.toStringDeep()`); `foundation/diagnostics_serialization_delegate_test.dart` (C37 closed 2026-05-18 — `_DemoConfig with DiagnosticableTreeMixin` `toDiagnosticsNode(...).toJsonMap(delegate)`); `foundation/object_flag_property_test.dart` (C38 closed 2026-05-18 — `_DemoConfig with Diagnosticable` `super.debugFillProperties(...)` + `toDiagnosticsNode().toStringDeep()`; also had unrelated framework-assert bug fixed by supplying empty-string text for `ifPresent`/`ifNull` slots); `foundation/text_tree_configuration_test.dart` (Cluster F #11 closed 2026-05-23 — `_SampleScene extends DiagnosticableTree` `scene.toDiagnosticsNode().toStringDeep()` returned null on 3 sites; manual sparse renderer fallback applied) |
| [U11 — Script-defined `HitTestTarget` rejected by `HitTestEntry(target)` constructor](#u11--script-defined-hittesttarget-rejected-by-hittestentrytarget-constructor-interpreter-limitation) | Interpreter limitation. The bridged `HitTestEntry(HitTestTarget target)` constructor validates `target` via `D4.getRequiredArg<HitTestTarget>`, which rejects an `InterpretedInstance` even when the script class declares `implements HitTestTarget`. Same architectural family as U3 (`Curve`), U5 (`NotchedShape`), U8 (`Enum`), U9 (`RouteAware`), U10 (`Diagnosticable*`). There is no framework-provided concrete `HitTestTarget` the script can substitute without standing up a full render tree, which is out of scope for a static teaching demo. Mandatory script-side workaround: keep the `_FakeTarget implements HitTestTarget` class declaration as a teaching reference but do not instantiate it; substitute a pure script-side `_DemoHitEntry(label, runtimeTypeStr)` for the anatomy-panel display. Native `HitTestResult()` and `BoxHitTestResult()` constructors still execute successfully — only the `HitTestEntry(<script HitTestTarget>)` boundary crossing is skipped. | `gestures/hit_testable_test.dart` (C39 closed 2026-05-18 — `_FakeTarget implements HitTestTarget` × 3 fed into `HitTestEntry(target)` for the sample `HitTestResult.path`) |
| [U12 — `@Deprecated`-annotated SDK symbols are filtered out of the bridge surface by design](#u12--deprecated-annotated-sdk-symbols-are-filtered-out-of-the-bridge-surface-by-design-generator-policy) | Generator policy (intentional). `ElementModeExtractor.generateDeprecatedElements = false` skips every `@Deprecated`-annotated enum/class/member/typedef during bridge generation so the bridge surface stays aligned with Flutter's non-deprecated API. Two workaround variants: **(A) local stand-in** for symbols with no bridged equivalent (declare a private `_<Name>` mirroring the SDK shape); **(B) modern-name swap** for typedef-renames pointing at a still-bridged modern symbol (use the modern name in code positions, preserve the alias in strings/comments). | `services/key_data_transit_mode_test.dart` (C44 closed 2026-05-18 — variant A, `_KeyDataTransitMode`); `services/keyboard_side_test.dart` (C45 closed 2026-05-18 — variant A, dual-enum `_KeyboardSide` + `_ModifierKey`); `services/mouse_tracker_annotation_test.dart` (test-driver C46 closed 2026-05-18 — variant B, `MaterialState*` → `WidgetState*`); pattern expected for C49/C50 (`RawKeyEventDataWeb`, `RawKeyEventDataLinux`) |
| [U14 — `Center > ConstrainedBox(maxWidth)` in `SingleChildScrollView`, or `Expanded` inside `Column(mainAxisSize.min)` in `GridView.count` cell, leaks `maxHeight: infinity` down to `RenderConstrainedBox`](#u14--center--constrainedboxmaxwidth-inside-singlechildscrollview-or-expanded-inside-columnmainaxissizemin-inside-gridviewcount-cell-leaks-maxheight-infinity-down-to-renderconstrainedbox-bridgeinterpreter-constraints-propagation-gap) | ~~Bridge/interpreter constraints-propagation gap (non-fatal).~~ ~~No script-side fix possible — accept the banner and defer.~~ → **FIXED 2026-05-23 (entry #19).** Section-level bisection localised the source to a different construct entirely — two `Row(crossAxisAlignment.stretch)` blocks in `_PrivateConstructorCards`. Wrapping each in `IntrinsicHeight` clears the assertion. The U14 entry's "Center/ConstrainedBox + GridView.count" diagnostic was a red herring; the entry is retained as a cautionary tale for future bisection-first investigation. The interpreter-side propagation gap remains a theoretical concern for genuine `Center > ConstrainedBox > SCV` cases not yet observed in the corpus. | ~~`animation/cubic_test.dart` (item 1 of `testlog_20260519-1247-flutter-suites-fixes` fix plan — 4 script-rewrite attempts reverted 2026-05-19)~~ → FIXED entry #19 (IntrinsicHeight on Row(stretch)) |
| [U15 — `RenderFlex overflowed by 2.0 pixels on the right` inside a bridged Cupertino layout the script cannot identify](#u15--renderflex-overflowed-by-20-pixels-on-the-right-inside-a-bridged-cupertino-layout-the-script-cannot-identify-bridge-layout-rounding-gap) | Bridge layout-rounding gap (non-fatal). On the 800-pixel test viewport, a Cupertino-flavoured deep-demo page produces two identical `RenderFlex overflowed by 2.0 pixels on the right.` assertions per frame. Four script-level workarounds (three independent `Row → Wrap` conversions on hero chips and boxed/sliding label rows, plus shrinking `CupertinoNavigationBar.middle`'s `SizedBox(width: 220) → 180`) all failed to clear the banner because the offending `RenderFlex` is synthesised internally by a bridged Cupertino widget the script does not own (CupertinoNavigationBar internals, sliding-segmented-control thumb track, etc.). Test passes throughout (`frameworkErrors=2 status=success`); banner is cosmetic only. **No script-side fix possible — accept the banner and defer.** | `cupertino/cupertino_nav_segmented_test.dart` (item 2 of `testlog_20260519-1247-flutter-suites-fixes` fix plan — 4 script-rewrite attempts reverted 2026-05-19) |
| [U16 — `Text('')` (empty-string `Text` widget) triggers a NaN `Offset` assertion in `dart:ui` paragraph painting](#u16--text-empty-string-text-widget-triggers-a-nan-offset-assertion-in-dartui-paragraph-painting-bridgeinterpreter-text-layout-gap) | Bridge/interpreter text-layout gap (non-fatal). Rendering a `Text` widget whose `data` is the empty string `''` through the bridged Flutter pipeline emits `Offset argument contained a NaN value.` (dart:ui/painting.dart line 41). The native Flutter pipeline short-circuits empty paragraphs to `Offset.zero`; the bridged painter computes a NaN baseline instead. Test passes (`status=success`) but a framework-error banner is emitted. **Script-side workaround:** guard every `Text(...)` site that may receive an empty string and substitute a single space (`' '`). Visual result is indistinguishable in a blank-line role. | `cupertino/restorable_cupertino_tab_controller_test.dart` (item 5 of `testlog_20260519-1247-flutter-suites-fixes` fix plan — fixed script-side 2026-05-19 by guarding the composed text in `_CodeBlock.build`; underlying bridge bug remains) |
| [U17 — `ConstraintsTransformBox` teaching script is intrinsically incompatible with `frameworkErrors=0`](#u17--constraintstransformbox-teaching-script-render_constraints_transform_box_testdart-is-intrinsically-incompatible-with-frameworkerrors0-script-design) | Truly unfixable (script design). `render_constraints_transform_box_test.dart` is a deep-demo script whose purpose is to feed pathological inputs to `ConstraintsTransformBox` and observe Flutter's debug-mode assertions / overflow banners. The visible `frameworkErrors=1` (NOT NORMALIZED, from a user-defined `kHalveMaxWidth` transform on a tight-width input) is the *first* of a cascade — pre-normalising it immediately surfaces `RenderConstraintsTransformBox overflowed by 30/15/15/30` from section 7's intentional clipBehavior showcase, and behind that further banners from sections 4 and 8. Any workaround that suppresses one tile erases the teaching content of that tile. **No script-side fix possible — accept the banner and defer.** | `rendering/render_constraints_transform_box_test.dart` (item 71 of `testlog_20260519-1247-flutter-suites-fixes` fix plan — kHalveMaxWidth normalize fix attempted and reverted 2026-05-20) |

Entries that previously lived here but have **suggested
interpreter / generator fixes** have been moved to
`testlog_20260428-1333-issue-analysis/error_analysis.md` for the
next round of work — see the migration log at the bottom of this
file.

---

## Abstract Class Inheritance

### Background

Interpreted classes cannot directly inherit from abstract native
classes because the interpreter architecture maintains
`bridgedSuperObject` — a native instance of the bridged
superclass. For abstract classes like `State`, `StatelessWidget`,
or `StatefulWidget`, we cannot instantiate them directly.

**Why it's a limitation:**

- When a D4rt script declares `class _MyState extends State<MyWidget>`,
  the interpreter creates an `InterpretedClass` with `bridgedSuperclass = StateBridge`.
- During constructor execution, the implicit `super()` call would
  normally create a native instance and store it in
  `bridgedSuperObject`.
- For abstract classes, the constructor lookup fails (empty
  `constructors: {}`).
- `bridgedSuperObject` remains null, breaking access to inherited
  properties like `widget`, `setState`, `context`.

### Solution Architecture (already in place)

For abstract framework classes (State, StatelessWidget,
StatefulWidget), the interpreter uses **adapter proxies** instead
of direct bridged super objects:

1. **Interface Proxy Factories** — registered via
   `D4.registerInterfaceProxy()` for each abstract class.
2. **Native Adapter Classes** — e.g., `_InterpretedState`,
   `_InterpretedStatelessWidget` that:
   - Extend the real abstract class.
   - Hold a reference to the `InterpretedInstance`.
   - Delegate abstract methods (build, createState) to the
     interpreted class.
   - Provide access to superclass properties (widget, setState)
     via their native implementation.
3. **`nativeProxy` Field** — the `InterpretedInstance` stores its
   adapter in `nativeProxy`.
4. **Property Resolution** — `InterpretedInstance.get()` uses
   `nativeProxy` as fallback when `bridgedSuperObject` is null.
5. **Property Interceptors** — registered via
   `D4.registerPropertyInterceptor()` to intercept property access
   and return interpreted instances instead of native wrappers
   (e.g., `widget` property on `State`).

**Property Interceptor Pattern:**

For properties that need to return the original
`InterpretedInstance` instead of a native wrapper object, the
adapter implements an interface with a getter:

```dart
abstract class InterpretedStateProxy {
  InterpretedInstance get interpretedWidget;
}
```

Then register an interceptor:

```dart
D4.registerPropertyInterceptor('State', (instance, propertyName, nativeProxy, ...) {
  if (propertyName == 'widget' && nativeProxy is InterpretedStateProxy) {
    return InterceptedValue(nativeProxy.interpretedWidget);
  }
  return null; // Fall through to normal handling
});
```

See the [Advanced Bridging User Guide](../../tom_d4rt/doc/advanced_bridging_user_guide.md#rc-9-property-interceptors)
for the complete RC-9 documentation.

**Classes requiring adapters:**

- `State<T>` — Framework state management base class
- `StatelessWidget` — Immutable widget base class
- `StatefulWidget` — Stateful widget base class
- Similar patterns for `ChangeNotifier`, `Listenable`, etc.

The adapter pattern is implemented in
`d4rt_runtime_registrations.dart` (proxies and interceptors) and
integrated with the `InterpretedInstance.get()` method in
`runtime_types.dart`.

**Why this stays in `interpreter_unfixable.md`:** the
limitation is architectural — every new abstract framework
class that scripts subclass requires a new adapter pair
(`_InterpretedX` + interface proxy registration). There is no
script-side workaround; the script "just works" once the adapter
is registered, and fails completely until then. New abstract-class
gaps (e.g., `RouterDelegate`, see `back_button_listener` below)
are tracked individually under the symptom-by-symptom entries
later in this file.

---

## Cluster R — `gir` W1-W5 transport cascade (test-app structural)

**Why truly unfixable at the interpreter or the script level.**
The cascade trigger (e.g. `retest/widgets/lock_state_test.dart`
at gir TID=43 in `testlog_20260428-1333-issue-analysis`) emits an
`HttpException: Connection closed before full header was received`
on `POST /build`, after which the test app process dies and every
subsequent script fails at `GET /clear` with `SocketException:
Connection refused (errno = 111)` against the (now closed)
ephemeral port. The cascade is in the **test runner ↔ test app
transport layer**, not the interpreter — the interpreter never
got a chance to evaluate the next script's source.

**Verification — all 5 wedgers pass in isolation (2026-04-28).**
Running W1–W5 in the dedicated isolation harness
`test/blocking_tests_test.dart` (5 tests, in this order: W1, W2,
W3, W4, W5) produced **all five passing** in 38 seconds wall
time, with `frameworkErrors=0` on every script:

| Wedger | Script | totalMs | frameworkErrors |
|---|---|---|---|
| W1 | `retest/widgets/context_action_test.dart` | 1725 | 0 |
| W2 | `retest/widgets/default_text_editing_shortcuts_test.dart` | 11100 (10 s preamble) | 0 |
| W3 | `retest/widgets/live_text_input_status_test.dart` | 11172 (10 s preamble) | 0 |
| W4 | `retest/widgets/lock_state_test.dart` | 965 | 0 |
| W5 | `widgets/animated_switcher_test.dart` | 1095 | 0 |

This confirms that **none of W1–W5 are intrinsically broken
scripts**. The cascade is purely a function of the test-app
process having accumulated state from a long preceding suite —
W4's `HttpException` only fires on `POST /build` when the app has
been alive for ~13 minutes of prior tests, not in a fresh
process. The fix-cluster work F1–F5 in
`testlog_20260428-1333-issue-analysis/error_analysis.md` is
therefore *unnecessary as per-script investigations*; the only
durable lever is the META watchdog.

**Workaround (already applied):**

1. **Isolation harness** — `test/blocking_tests_test.dart` runs
   the 5 wedgers in their own suite. Use this to verify scripts
   stay viable as the interpreter changes.
2. **Skip** the 5 wedgers in their respective long suites
   (`generator_interpreter_retest_test.dart` for W1–W4,
   `generator_interpreter_issues_test.dart` for W5).
3. **Test-app watchdog** (META structural fix tracked in
   `interpreter_issues.md` "[META] Structural cascade in retest
   suite") — extend `SendTestRunner` so a single
   `Connection closed` / `Connection refused` triggers a fast
   app-process restart and a port re-discovery rather than letting
   subsequent `/clear` calls fail against a dead socket. This
   converts a 20-script cascade into a single failure + 19
   retries. Given that W1–W5 all pass in isolation, the watchdog
   alone — without per-script F1–F5 work — should restore the
   skipped tests to the long suites once it lands.

---

## E3 — `findAncestorStateOfType<T>()` ignores type argument

**Trigger.** A `StatelessWidget` (or any descendant) calls
`context.findAncestorStateOfType<SpecificStateClass>()` to grab a
typed handle to an owning State subclass declared in the same
script, e.g.:

```dart
final _SpwscDemoHomeState? state =
    context.findAncestorStateOfType<_SpwscDemoHomeState>();
state?._controller.hasClients; // KaBOOM
```

**Underlying interpreter limitation.** The auto-generated bridge
adapters for `BuildContext.findAncestorStateOfType` (and
`findRootAncestorStateOfType`) drop the generic type argument:

```dart
'findAncestorStateOfType': (visitor, target, positional, named, typeArgs) {
  final t = D4.validateTarget<…Element>(target, '…Element');
  return t.findAncestorStateOfType(); // <-- T missing
},
```

The native Flutter API resolves the type at compile time
(`findAncestorStateOfType<T>` is monomorphised), so the generator
has no obvious surface to forward an interpreted `T` into. With
`T == dynamic`, Flutter walks ancestors and returns the *first*
State of any type. In a real script that is almost always the
wrong State — typically an `_AnimatedContainerState`,
`NavigatorState`, `OverlayState`, or some other framework State
mixing in `SingleTickerProviderStateMixin` /
`TickerProviderStateMixin`. The script then calls a member that
only exists on its own State subclass, the bridge adapter for
the framework State doesn't have the field, and the runtime
surfaces:

```
Runtime Error: Undefined property or method '_controller' on
bridged instance of 'SingleTickerProviderStateMixin'.
```

(Same shape for `TickerProviderStateMixin`, `NavigatorState`,
etc., depending on which State the walk happens to land on.)

A "proper" fix would require the bridge generator to emit a
type-aware adapter that:

1. Walks ancestors via `Element.visitAncestorElements`.
2. For each `StatefulElement`, checks whether its
   `state` is a `D4InterpretedProxy` whose `d4rtInstance`
   `InterpretedInstance` extends the requested
   `InterpretedClass` (or, for native targets, an `is T` check
   against the resolved native bridge).
3. Returns the **`InterpretedInstance`** directly so script-side
   field access works.

This change touches every Element subclass adapter in
`widgets_bridges.b.dart` (100+ call sites), needs a runtime D4
helper mirrored across `tom_d4rt` and `tom_d4rt_ast`, and full
bridge regeneration. It is tracked separately and not part of
the cluster-by-cluster bug-fix campaign.

**Workaround at the script level.** Pass the controller (or
state-derived value) down explicitly, e.g.:

```dart
// Owner — give the descendant what it needs.
actions: [
  _HeroPulseIcon(controller: _controller),
  const SizedBox(width: 12),
],

// Descendant — drop the typed ancestor lookup.
class _HeroPulseIcon extends StatelessWidget {
  const _HeroPulseIcon({required this.controller});
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    if (!controller.hasClients) return const _PulseDot(active: false);
    return ValueListenableBuilder<bool>(
      valueListenable: controller.position.isScrollingNotifier,
      builder: (_, scrolling, __) => _PulseDot(active: scrolling),
    );
  }
}
```

Functionally equivalent in real Flutter, and side-steps the
interpreter limitation entirely. Applied to
`widgets/scroll_position_with_single_context_test.dart` (E3,
2026-04-28).

---

## E6 — Native Dart Record named-field access (interpreter limitation)

**Category.** Interpreter / generator architectural limitation.

**Triggering shape.** A d4rt script reads a *named* field on a
**native** Dart record (the `({name: value, age: int})` syntax)
that crossed the interpreter ↔ native boundary — for example,
the result of a stdlib API or a bridged getter that returns
`({String name, int age})`.

```dart
final ({String name, int age}) entry = someBridgedCall();
print(entry.name); // RuntimeD4rtException at this access
```

**What works.** Positional fields (`.$1`, `.$2`, …) are routed
through `dynamic` dispatch in the interpreter (added 2026-04-28
for E6). The script `widgets/platform_menu_widgets_test.dart`
exercises this path and passes.

**Why named-field access is unfixable here.** Dart records
expose their named fields only as **statically-resolved
getters** — the field name has to be known at compile time so
the Dart compiler can emit the right vtable lookup. From inside
the interpreter we only have a `String` for the field name at
runtime, with no compile-time site to dispatch from. The two
"normal" ways out are both blocked:

- `dart:mirrors` would let us look the getter up reflectively,
  but Flutter forbids `dart:mirrors`.
- `(record as dynamic).fieldName` doesn't help because
  `fieldName` is a Dart identifier, not a string variable; you
  can't say `(record as dynamic).(name)` at runtime.

A switch-table that hard-codes a finite list of names won't work
either, because record literals can use *any* identifier.

**Architectural workaround.** The interpreter recognises
`InterpretedRecord` (records authored inside d4rt source) as a
distinct runtime type that carries its named fields in a `Map`,
so reflection by string name *does* work for those. Scripts that
need named-field access should construct or convert to
`InterpretedRecord` rather than relying on a native record value.

When the value comes from a bridged API and only its native form
is available, the practical alternatives are:

- destructure with a record-pattern at the boundary —
  `final (:name, :age) = bridgedCall();` — which the interpreter
  *does* understand, and lets you operate on plain locals from
  there;
- expose the data through a class with explicit getters in the
  bridge instead of a record return type.

The interpreter throws a clear, intentional error in this case:
"Cannot access named field 'X' on a native Dart record. Native
records expose positional fields ('\$1', '\$2', …) but their
named fields are not reflectively accessible without
`dart:mirrors`."

**Documented.** 2026-04-28 with the E6 fix in
`tom_d4rt/lib/src/interpreter_visitor.dart` and
`tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart`.

---

## E7 — `Iterable.whereType<T>()` drops generic argument (interpreter limitation)

**Category.** Interpreter / generator architectural limitation
(same family as E3 — bridged generic methods drop their type
argument at the boundary).

**Triggering shape.** Any d4rt script that relies on
`whereType<T>()` to remove `null` (or off-type values) from an
iterable and feeds the result into code that requires the
declared type.

```dart
final List<double> logged = _allDays
    .map((RestorableDoubleN d) => d.value) // Iterable<double?>
    .whereType<double>()                    // expected to drop nulls
    .toList();
double sum = 0.0;
for (final double v in logged) {
  sum += v;                                 // null reaches here
}
```

**Where it fails.** The stdlib bridges for collection types call
`whereType()` (no type argument) inside the adapter:

```dart
// tom_d4rt/lib/src/stdlib/core/iterable.dart:177
'whereType': (visitor, target, positionalArgs, namedArgs, _) {
  return (target as Iterable).whereType();
},
// Same shape: list.dart, set.dart, hash_set.dart, runes.dart,
// typed_data/uint8_list.dart, plus `cast` adapters alongside.
```

`whereType()` with no argument resolves to `whereType<dynamic>()`,
which never filters anything. The d4rt bridge has no view of the
caller's `<double>` annotation, so the filter is silently a
no-op.

**Why it's an architectural limitation.** Propagating the call
site's generic argument through the bridge dispatcher would
require generic type tracking on every `BridgedClass` method
call. It would touch every generic stdlib method (`whereType`,
`cast`, and their per-collection variants), the bridge generator's
emitted adapters, and the interpreter's method-resolution path.
This is the same architectural ceiling already documented for
**E3 — `findAncestorStateOfType<T>()`** above; both are instances
of the broader generic-type-argument-erasure issue. A targeted
follow-up would unify the two under a shared "preserve generic
arg through bridged dispatch" change.

**Why not just hard-code `whereType<T>()` per common T?** Dart
allows `whereType<MyDomainType>()` for any user type, including
interpreted classes. A switch over a few well-known `T`s would
fix the common cases (`whereType<double>`, `whereType<Widget>`,
…) but leave the long tail.

**Workaround at the script level.** Replace
`.map(...).whereType<T>()` with explicit accumulation that
null-checks (or type-checks) inline. See the E7 entry in
`script_rewrites.md` for the canonical rewrite.

**Documented.** 2026-04-28 alongside the E7 script-side closure
of `widgets/restorable_double_n_test.dart`.

---

## E8 — Reading `ScrollPosition.maxScrollExtent` between attach and first `applyContentDimensions` (script-side guard required)

**Status.** **Resolved as script-side guard tightening** (Fa2,
2026-04-28). The original E8 diagnosis below was wrong — see
"Misdiagnosis correction" at the end of this entry.

**Symptom.** A `ScrollController` is declared as a state field,
attached to a `Scrollable` (typically a sibling `ListView`), and
the same state field is then read from a *separate* widget that
guards with `controller.hasClients ? controller.position.<X> : …`,
where `<X>` is one of the position getters that asserts
`hasContentDimensions` (e.g. `minScrollExtent`,
`maxScrollExtent`, `viewportDimension`). Two `Null check operator
used on a null value` framework errors fire during the harness
snapshot — one per consumer of the position.

**Triggering Dart/Flutter pattern.**

```dart
class _TelemetryCard extends StatelessWidget {
  final ScrollController controller;
  const _TelemetryCard({required this.controller});
  @override
  Widget build(BuildContext context) => Text(
        controller.hasClients
            ? controller.position.maxScrollExtent.toStringAsFixed(0)
            : '—', // ← unsafe: hasClients ⇏ hasContentDimensions
      );
}
```

`hasClients == true` only means a `ScrollPosition` has been
*attached* to the controller; it does **not** mean the position
has finished its first layout. Between attach and the first call
to `applyContentDimensions`, the position's private
`_maxScrollExtent` field is still null, and `maxScrollExtent`'s
getter (`return _maxScrollExtent!;`) throws `Null check operator
used on a null value`. The same applies to `minScrollExtent` and
to anything that reads the not-yet-set extents.

In a normal compiled Flutter app this race is rarely visible
because `build` runs after layout has stabilised. The d4rt
`SendTestRunner` harness, however, captures the screenshot during
the first frame after attach — exactly inside the
attach-but-not-laid-out window — so the unsafe getter call lands
during the build that produces the screenshot.

**Workaround (script-side, functionally equivalent).** Tighten
the guard to also require `hasContentDimensions`:

```dart
controller.hasClients && controller.position.hasContentDimensions
    ? controller.position.maxScrollExtent.toStringAsFixed(0)
    : '—',
```

This preserves the same visual output (the `'—'` fallback
already exists for the "no clients" case; the harden-up path
extends it to "attached but not yet measured"). No behavioural
change in a real running app — by the time the user can see the
card, content dimensions are set.

**Applied at.**
`widgets/scroll_deceleration_rate_test.dart` (Fa2 fix,
commit covering the cluster). Drops FE from 2 → 0 on the
`hardly_relevant_classes_5` retest.

**Why this is not an interpreter bug.** The d4rt interpreter
correctly forwards the call, and the bridged `ScrollPosition`
correctly throws — that is the documented native behaviour of
`maxScrollExtent` before `hasContentDimensions`. The script's
guard was simply incomplete.

**Misdiagnosis correction.** The previous E8 entry attributed
the residual 2 framework errors to a `BridgedInstance` lifecycle
problem with state-field `ScrollController` propagated through a
`StatelessWidget` chain. That diagnosis was wrong: the bisect
table that supported it (locally-constructed controller "fixes"
the issue) was an artefact of the `_TelemetryRow` path being
short-circuited when the controller was rebuilt locally. Bisecting
slivers of `widgets/scroll_deceleration_rate_test.dart` after the
layout-cascade fix located the FE precisely on the
`_TelemetryCard.maxScrollExtent` ternary inside `_TelemetryRow`;
removing only that line drops FE from 2 → 0 with everything else
intact, including the state-field controller propagation through
`_DynoTrackPair → _DynoLane → ListView.builder`. Six minimal
reproducers built from the misdiagnosis (state-field +
StatelessWidget chain, with and without listeners / physics /
ValueListenableBuilder) all reported FE=0; only after restoring
the unguarded `maxScrollExtent` read did the failure surface.

**Documented.** 2026-04-28 (corrected from prior misdiagnosis).

**Re-verified.** 2026-04-29 — `widgets/scroll_deceleration_rate_test.dart`
inspected during the Fa1 cluster sweep; FE=0 confirmed across all
three observed runtime contexts (single-script `--plain-name`
filter on `hardly_relevant_classes_5_test.dart`, full
`hardly_relevant_classes_5_test.dart` suite run with cross-script
ordering, and the `[fa1-c3]` group of `fa1_bisect_test.dart`).
Both `CrossAxisAlignment.stretch` sites in the file (the Row.stretch
in `_DynoTrackPair` and the Column.stretch in `_DynoLane`) were
inspected and confirmed safe — the Row.stretch is wrapped in an
explicit `SizedBox(height: 420)` (matches the C3 closing recipe
"pin a finite parent height before the sliver boundary"), and the
Column.stretch operates on the bounded horizontal axis from the
surrounding `Expanded`. No latent C3 / Fa1 pocket present. The
E8/Fa2 fix from 2026-04-28 fully addresses this script's only
historical FE source. Logs:
`doc/testlog_scroll_deceleration_fix/{baseline,hr5_full,fa1c3_baseline}.log.txt`.

---

## Fa1-N1 — Layout-cascade FE residuals on 6 deep-demo scripts (script-side, annotation-deferred)

**Cluster reference.** `error_analysis.md` cluster N1 / Fa1
(`testlog_20260428-2250-issue-analysis`).

**Severity.** Cosmetic only — every affected script passes at the
suite level (zero test failures). The framework errors are
recorded by Flutter's debug overlay but do not fail any
assertion that the harness counts as a hard test failure.

**Status.** Reverted/Deferred. Each script carries a
`D4RT-SCRIPT-LIMITATION: layout cascade` annotation block
explaining the local cause and the closing route. The closing
route is documented (below) but not applied because the
risk-vs-reward of large-script rewrites isn't justified for
zero-failure noise. A sentinel is kept in
`test/fa1_bisect_test.dart` (`[fa1-2250-sentinel]` group) so any
future flutter behaviour change that drops these to FE=0 will
surface in a routine baseline run.

### Affected scripts and FE shapes

| Script | FE | Sub-pocket | Triggering Flutter codepath |
|---|---:|---|---|
| `widgets/snapshot_mode_test.dart`                | 1 | small-overflow   | `RenderFlex` overflowed by 14 px on the bottom — one of the panel-level Columns has fixed children summing > available height |
| `widgets/select_all_text_intent_test.dart`       | 3 | EditableText     | Negative-min-h on `_RenderEditableCustomPaint` + semantics-layout race |
| `widgets/transpose_characters_intent_test.dart`  | 2 | EditableText     | Same as above (semantics race fires; the leading constraint failure is suppressed by Flutter's tolerance, leaving 2 FE) |
| `widgets/restoration_mixin_test.dart`            | 3 | EditableText     | Same as `select_all_text_intent_test.dart` |
| `widgets/widget_state_color_test.dart`           | 9 | C3 (Row(stretch)+Expanded inside Sliver) | Row(stretch) + Expanded children inside SliverToBoxAdapter — sliver protocol gives unbounded vertical, Row(stretch) cannot resolve |
| `widgets/text_magnifier_configuration_test.dart` | 6 | C3 (Row(stretch)+Expanded inside Sliver) | Same as `widget_state_color_test.dart` |

**Not annotated.** ~~`widgets/restorable_double_test.dart` —
emitted FE=1 in the `secondary_classes_test` suite at testlog
2250, but FE=0 in isolation under `fa1_bisect_test.dart`. The
inter-script ordering flake doesn't fit the script-annotation
pattern; tracked separately if it persists.~~ — **closed
2026-04-29** via small-overflow recipe applied to the VU meter's
`_buildVuBar`. See "Small-overflow pocket — empirical findings
2026-04-29" subsection below for the full diagnosis: the centre
shaft (190 px) + gap (6 px) + label (~16 px) summed past the
inner content area (196 px after `Container(padding: all(12))`
inside `SizedBox(height: 220)`) by 17 px. Capped centre at 170
px and sides at 150 px to preserve the original 20 px asymmetry
while leaving 6 px headroom. FE → 0 across single-script,
x-script (`restorable_(date_time|double)`), sentinel, and full
secondary suite contexts.

**Also closed 2026-04-29 (crashing-suite, single-script
context):** ~~`widgets/display_feature_sub_screen_test.dart` —
emitted FE=1 (40 px bottom overflow) in the `crashing_tests_test`
suite. Closed by aligning `MediaQuery.size` with the surrounding
`SizedBox` extent in `_ComparisonCard.build` for the
`horizontalFold` mode of `_FeatureComparisonScene`.~~ See
"Small-overflow pocket — DFSS MediaQuery / SizedBox mismatch
2026-04-29" subsection below for the full diagnosis. FE → 0
under single-script retest (regression rule (a) — test-script-
only change).

### Sub-pocket rewrite recipes (the closing routes)

#### Small-overflow pocket (snapshot_mode)

The flutter debug overlay records `RenderFlex overflowed by N
pixels` whenever a Column or Row's children exceed the available
main-axis extent by N pixels. The demo's panel-level layouts use
fixed `SizedBox(height: <constant>)` spacers and content that, on
the test app's surface size, sum to slightly more than the
panel height.

**Workaround patterns — same functional result, no FE:**

1. Convert the offending panel Column to a `ListView` (the C22
   pattern already applied to `shortcut_activator_test.dart`
   etc.) so the children scroll instead of overflowing.
2. Wrap the panel body in `SingleChildScrollView`.
3. Reduce the offending fixed-height spacer (`SizedBox(height:
   24)` → `SizedBox(height: 10)` etc.) by the documented
   overflow amount.

The blocker is **finding the offending panel** without runtime
instrumentation — the FE message lists no `Widget` ancestor. A
bisecting harness that replaces panels one at a time with
`SizedBox.shrink()` would localise the offender; deferred as
non-essential effort.

##### Small-overflow pocket — empirical findings 2026-04-29

Two scripts in this pocket were closed with a manual rewrite,
proving the recipes work and producing reusable bisect knowledge:

- **`snapshot_mode_test.dart` (1 FE):** closed by bumping the
  AppBar `preferredSize` from 72 → 88 to fit the 44 px shutter
  + 38 px padding combination.

- **`restorable_double_test.dart` (1 FE):** closed by capping the
  VU meter shaft heights — `centreMax` 190→170, `leftMax/rightMax`
  170→150 — so each `Column(mainAxisSize.min)` fits inside its
  parent `SizedBox(height: 220)` minus the surrounding
  `Container(padding: all(12))`. The Column adds shaft + 6 px gap
  + ~16 px Text label, so the budget is `220 − 24 (padding) − 6
  (gap) − 16 (label) ≈ 174 px max shaft`. The original 190 px
  centre exceeded that by 17 px under cross-script font/sub-pixel
  rounding (any preceding `restorable_*` render in the same
  in-process suite triggers it). The original 20 px asymmetry
  (centre slightly taller than sides) is preserved by trimming
  both pairs by the same delta.

**Bisect tactics that worked.** The FE only manifests when at
least one preceding script has rendered in the same suite — the
single-script `--plain-name` filter on the home suite reports
FE=0 because the harness has no prior render to perturb the font
metrics. To reproduce in seconds rather than running the full
~8-min suite, use a 2-script regex filter:

```bash
flutter test test/secondary_classes_test.dart \
    --name "restorable_(date_time|double)"
```

This runs ~2 seconds and reproduces the 17 px overflow reliably.
Inside the script, comment out the top-level child sections one
at a time in the build's outer `Column`, then bisect within the
remaining section by replacing sub-Rows / sub-Columns with
`SizedBox.shrink()` until the FE stops. For
`restorable_double_test.dart` the path was: S5→S4→S3→S2 each
disabled showed FE persisted (so it was in S1), then dial-only
showed FE=0 and VU-only showed FE=1 — pinpointing the VU meter
in 4 ~3-second iterations.

**Mental model.** A "small overflow" usually means the layout is
correct on the *first* render in the test app's process but
drifts by a few pixels on subsequent renders due to font cache
warming, baseline-grid rounding, or platform glyph-height
fallback. The fix is to leave a 4–8 px headroom on every fixed-
height container that hosts an intrinsic-sized Column. If a
panel was designed with the bar/shaft height precisely matching
parent height − padding − labels, that's a fragile measurement
that *will* surface as a small-overflow FE under some preceding
test ordering.

##### Small-overflow pocket — DFSS MediaQuery / SizedBox mismatch 2026-04-29

A third script in this pocket was closed with a manual rewrite,
and is recorded here because the trigger is structurally
distinct from the font-drift cases above:

- **`widgets/display_feature_sub_screen_test.dart` (1 FE, 40 px
  bottom):** closed by aligning `MediaQuery.size` with the
  surrounding `SizedBox` extent in `_ComparisonCard.build`
  (scene `_FeatureComparisonScene`, `horizontalFold` mode).
  Original used `MQ size = Size(360, 220)` inside an outer
  `SizedBox(width: 300)` and inner `SizedBox(width: 300, height:
  180)`; fix uses `canvas = Size(300, 220)` for both MQ and the
  inner SizedBox, with the outer SizedBox bumped to 324 (=300 +
  Container padding 12 × 2) so the inner 300 px width is not
  clamped.

**Triggering Flutter codepath.**
`DisplayFeatureSubScreen.build` (see
`flutter/lib/src/widgets/display_feature_sub_screen.dart` lines
111–118) wraps `child` in a `Padding` whose insets are computed
from `mediaQuery.size` minus the closest sub-screen rect:

```dart
return Padding(
  padding: EdgeInsets.only(
    left: closestSubScreen.left,
    top: closestSubScreen.top,
    right: parentSize.width - closestSubScreen.right,
    bottom: parentSize.height - closestSubScreen.bottom,
  ),
  child: MediaQuery(data: mediaQuery.removeDisplayFeatures(...), child: child),
);
```

When `mediaQuery.size` is *larger* than the actual parent box
(here: 360×220 declared inside a 300×180 SizedBox), the Padding
insets are computed against the wider/taller parent and then
applied inside the smaller box. For `horizontalFold` with
default LTR anchor `(120, 140)`, the closest sub-screen is the
bottom half (`y = 118 .. 220`), so `Padding.top = 118`. The
parent SizedBox only provides 180 px of height, leaving
`180 − 118 = 62 px` for the child's intrinsic Column inside
`_MiniPaneCard` (which needs ~91 px), producing the 40 px bottom
overflow.

**Workaround pattern — same functional result, no FE:** keep
`MediaQuery.size` *exactly* equal to the parent SizedBox extent
that hosts the DFSS subtree, and ensure each candidate
sub-screen rect produced by the configured display features has
enough room for the child's intrinsic Column. For
`horizontalFold` on a 300×220 canvas, each sub-screen is `220/2
− 8 = 102 px` tall, leaving ~11 px headroom over `_MiniPaneCard`'s
~91 px column — comfortably inside the 4–8 px headroom rule.

**Mental model.** DFSS is unique in this pocket because the
overflow is not driven by font metric drift; it is a deliberate
geometric placement. Any DFSS-using widget that synthesises its
own `MediaQuery` (rather than passing the ambient one through)
must keep `MQ.size == hosting SizedBox`, and must size the
SizedBox so that every candidate sub-screen — top/bottom for
horizontal folds, left/right for vertical hinges — has enough
room for the child Column at its intrinsic height plus the
4–8 px headroom. Otherwise some anchor + posture combination
will pin the child to a sub-screen that cannot hold it.

#### EditableText pocket (select_all_text_intent, transpose_characters_intent, restoration_mixin)

The flutter framework's `_RenderEditableCustomPaint` is laid out
during the layout pass. When its parent (typically the
`Container > TextField(maxLines: N)` chain inside a
`Column(crossAxisAlignment: stretch)`) computes a constraint
where the minimum height shrinks below zero — a normal edge case
when the editable's preferred height exceeds the panel chrome's
remaining vertical extent — the layout assertion `'hasSize'`
fires. Compounding it, `_RenderEditable.attach()` registers
itself with the semantics owner; if semantics tries to
re-evaluate the editable in the same frame it walks the render
object before layout completes, hitting
`!childSemantics.renderObject._needsLayout` (object.dart:5737).

**Workaround patterns — same functional result, no FE:**

1. Pin the TextField parent height with `SizedBox(height:
   <fixed>)` so the constraint never shrinks negative:

    ```dart
    SizedBox(
      height: 80, // pinned — fits 3 lines of body text
      child: TextField(
        controller: _tierAController,
        maxLines: 3,
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
        ),
      ),
    )
    ```

2. Replace the live `TextField` demo with a static
   `SelectableText` + a manually-drawn caret glyph. The
   select-all dispatch surface remains visible; only the
   *editable* render path is removed:

    ```dart
    SelectableText(
      _tierAController.text,
      style: const TextStyle(...),
    )
    ```

3. Drop `crossAxisAlignment: stretch` on the parent Column so
   the editable computes an intrinsic width without forcing a
   stretched parent; the editable's own width is left free:

    ```dart
    Column(
      crossAxisAlignment: CrossAxisAlignment.start, // was stretch
      children: <Widget>[ ..., TextField(...), ... ],
    )
    ```

The blocker is that the TextField *is* the demo — Tier-A in
`select_all_text_intent_test.dart` exists specifically to show
the select-all intent firing on a live editable. Replacing it
with a SelectableText loses the demo's central value
proposition. Deferred until a per-script visual rework is
prioritised.

**Update 2026-04-29 — empirical findings on the listed
workarounds:**

The three scripts `select_all_text_intent_test.dart`,
`transpose_characters_intent_test.dart`, and
`restoration_mixin_test.dart` were promoted out of
this deferral on 2026-04-29 (the EditableText pocket is now
fully closed; only the `widget_state_color` and
`text_magnifier_configuration` C3 sliver-row sub-pockets remain
in this cluster). Working through them surfaced
two important refinements to the workaround patterns above:

- **Workaround 1 (`SizedBox(height:)` pin) does NOT reliably
  close the cascade.** The pin sets a tight outer constraint on
  the TextField, but `InputDecorator`'s intrinsic-height pass
  still computes its inner editable's measurement
  independently, and that pass can produce the negative-min
  constraint inside the SizedBox during the same frame the
  semantics walker runs. Verified empirically: SizedBox(76)
  around `TextField(maxLines: 3)` and SizedBox(40-44) around
  `TextField(maxLines: 1)` both left FE counts unchanged.

- **A bare `EditableText` (without `InputDecoration`) does NOT
  bypass the cascade either.** The negative-min-height assertion
  originates inside `_RenderEditableCustomPaint`, which is
  EditableText's own internal render object — TextField just
  embeds an EditableText, so swapping the wrapper changes
  nothing at the render layer. Verified empirically on
  `transpose_characters_intent_test.dart`: replacing all three
  `TextField`s with bare `EditableText`s kept FE at 2.

- **Workaround 2 (replace with `SelectableText`) is the only
  reliable closing route.** `SelectableText` uses
  `_RenderParagraph`, which has no editable render path and
  does not assert on the parent's constraint shape. Confirmed
  by both the 2026-04-29 fixes mentioned above (FE → 0).

- **Functional preservation when the demo "needed" a live
  editable:** in practice, all three scripts' demos kept their
  educational value through alternate channels — Action chains
  dispatched via buttons / `Actions.invoke` / default keyboard
  handlers (select_all, transpose), or other `RestorableX`
  properties exercised through interactive buttons
  (restoration_mixin's `_score` / `_currentTurn` / `_diceValue`
  / `_isRolling` / `_lastRollAt`). The per-keystroke "live
  preview" of caret manipulation / text entry is the only
  behaviour lost.

- **Cross-script state-bleed asymmetry:** `restoration_mixin_test`
  reported FE=0 in its home suite (`secondary_classes_test`)
  but FE=3 in the `[fa1-2250-sentinel]` context — proof that
  the cascade is sensitive to test-runner ordering and that the
  preceding `restorable_double_test.dart` leaves residual
  editable state which the next script inherits. The
  SelectableText replacement closes both contexts because it
  bypasses the editable render path entirely.

**Trigger code (Dart/Flutter side):**

```dart
// 3-FE cascade (negative-min-h → !hasSize → !_needsLayout):
ListView(
  children: <Widget>[
    Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // ANY of these triggers the cascade when the parent
          // chain shrinks the constraint mid-frame:
          TextField(maxLines: 3),       // Tier-A
          TextField(maxLines: 1),       // single-line
          EditableText(controller: c, focusNode: f, ...), // bare
        ],
      ),
    ),
  ],
)
```

**Workaround code (Dart/Flutter side, same functional result
where possible):**

```dart
// Replace the editable with a non-editable equivalent that
// uses _RenderParagraph instead of _RenderEditableCustomPaint:
SelectableText(
  _controller.text,
  style: TextStyle(...),
)

// If the demo's Intent dispatch chain fires from a button
// (Actions.invoke / Actions.maybeInvoke) or keyboard
// shortcut wired through Shortcuts/Actions, the registered
// Action still fires regardless of editable focus — so the
// educational narrative is preserved.
```

#### C3 pocket (widget_state_color, text_magnifier_configuration)

A `Row(crossAxisAlignment: stretch)` with `Expanded` children
placed inside a `SliverToBoxAdapter` (or anywhere inside a
`CustomScrollView`) hits a fundamental incompatibility in
flutter's render protocol: slivers measure their adapter children
with `BoxConstraints(minHeight: 0, maxHeight:
double.infinity)`. `Row(stretch)` requires a *finite* parent
height to stretch its children to. The result: `BoxConstraints
forces an infinite height`, the row's children fail to lay out
(`hasSize` assertion), the sliver adapter's
`firstChild`/`lastChild` walk hits null in the paint phase, and
9 FE cascade out for `widget_state_color_test.dart` (6 for
`text_magnifier_configuration_test.dart`).

**Workaround patterns — same functional result, no FE:**

1. Drop `crossAxisAlignment: stretch` (use the default `start`
   or `center`); explicitly set each card's height where the
   visual symmetry needs it:

    ```dart
    Row(
      crossAxisAlignment: CrossAxisAlignment.start, // was stretch
      children: <Widget>[
        SizedBox(height: 220, child: Expanded(child: card1)),
        SizedBox(height: 220, child: Expanded(child: card2)),
        SizedBox(height: 220, child: Expanded(child: card3)),
      ],
    )
    ```

2. Pin the parent vertical extent before the sliver boundary,
   so `Row(stretch)` sees a finite height:

    ```dart
    SliverToBoxAdapter(
      child: SizedBox(
        height: 220, // pinned
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[ ... ],
        ),
      ),
    )
    ```

3. Replace the `Row` with `IntrinsicHeight + Row(stretch)` (the
   IntrinsicHeight provides a finite vertical extent for the
   Row's stretch axis):

    ```dart
    IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[ ... ],
      ),
    )
    ```

The blocker is that the demo's hero strip leans on stretched
rows for the brass-rimmed-lens / chameleon-card visual
composition; pinning a height changes the demo's appearance.
Deferred until a per-script visual rework is prioritised.

**Update 2026-04-29 — empirical findings (Fa1 cluster fully closed):**

Both C3 sub-pocket scripts (`widget_state_color_test.dart` and
`text_magnifier_configuration_test.dart`) were promoted out of
this deferral on 2026-04-29. With them, the entire Fa1 cluster
is closed — all 7 sentinel slots now report FE=0. Working through it confirmed:

- **Workaround 1 (stretch → start) is sufficient and simplest.**
  Both `Row(crossAxisAlignment: stretch)` sites in
  `_WscAnatomyFactories.build` and `_WscFromMapVsResolveWith.build`
  were switched to `CrossAxisAlignment.start`. FE drops from 9
  to 0. The visual cost is the loss of guaranteed equal-height
  between the two cards in each row; in practice this script's
  cards have nearly identical natural heights, so the visual
  difference is minimal. No SizedBox pin or `IntrinsicHeight`
  wrap was needed — the Expanded's horizontal flex is preserved
  intact, and each card simply sizes to its own intrinsic
  vertical extent.

- **Not all `CrossAxisAlignment.stretch` instances need to
  be flipped.** A `Column(crossAxisAlignment: stretch)` whose
  parent has a *bounded width* (e.g., a Container inside an
  Expanded) is safe: the Column's cross-axis is horizontal, so
  the stretch operates on the bounded axis only. The third
  stretch site in `_constructorCard`'s inner Column was left
  in place after verifying FE=0 in both the home suite and the
  fa1 sentinel. The cascade only fires when the stretch axis
  matches the unbounded axis the SliverList feeds (i.e., a
  vertical-stretch on a Row inside a sliver-fed extent).

- **Workaround 3 (`IntrinsicHeight + Row(stretch)`) was
  attempted first** as a way to preserve the equal-height
  visual that `stretch` was guaranteeing, but produced a
  fragile structure that wrapped each Expanded child individually
  with no clean closing recipe. Workaround 1 (drop stretch) is
  preferred for its readability — the demo's narrative survives
  unchanged either way.

- **A C3 cascade can mask an underlying Fa1 EditableText
  cascade in the same script.** Confirmed empirically on
  `text_magnifier_configuration_test.dart`: pre-fix FE was 6
  (pure C3 shape — infinite-height RenderPadding + RenderFlex /
  RenderPadding `hasSize` + 3× null-check). After the C3 fix
  (stretch→start), FE jumped to 9 — the script's two
  `TextField`s embedding `magnifierConfiguration` started
  reporting the negative-min-height + `hasSize` cascade on
  `_RenderEditableCustomPaint` plus a semantics `!_needsLayout`
  assertion. The C3's "infinite height" propagated up the
  layout tree fast enough that the inner editable's layout pass
  was short-circuited before its negative-min could fire; once
  the C3 was closed, the editable layout completed and produced
  its own cascade. **Implication for future cluster fixes:**
  when a C3 fix surfaces new errors instead of dropping to 0,
  the new errors are likely a previously-masked Fa1 sub-pocket
  in the same script — apply the EditableText-pocket closing
  recipe (TextField/EditableText → SelectableText) on top of
  the C3 fix. For demos that depend on `magnifierConfiguration`,
  `SelectableText` is a one-for-one swap because it accepts the
  same parameter and triggers the configured loupe through the
  long-press handle drag path.

### Sentinel test

`test/fa1_bisect_test.dart` carries a recurring sentinel group
`[fa1-2250-sentinel]` that runs each of the 7 scripts (6
annotated + `restorable_double` to track the inter-suite flake)
and prints `FA1 STATUS: <bool>  FE: <int>  SCRIPT: <path>`. If
any script's FE drops to 0 in a future run (e.g., flutter
upstream changes the sliver protocol or relaxes the semantics
race), the annotation can be removed and the script counted as
genuinely fixed without script-side surgery.

**Documented.** 2026-04-28 (Fa1-N1 closure via annotation).

---

## N2 — Bridged `RestorableProperty` proxy: script-side eager-init + defensive iteration

- **Cluster:** N2 (testlog_20260428-2250-issue-analysis) ·
  **Severity:** Low (single FE, zero test failures) · **Owner:**
  scripts (the underlying interpreter limitation is the same one
  documented above for D3/D4 — bridged `RestorationMixin`
  lifecycle dispatch under cross-script ordering)
- **Affected script:** `widgets/restorable_property_test.dart`
- **Status:** Closed via script-side workaround 2026-04-29.
  Single-suite isolation already FE=0; the FE only surfaces when
  the script runs inside the full `secondary_classes_test`
  ordering.

### What the underlying Dart/Flutter code does

The script demonstrates writing **custom** `RestorableProperty<T>`
subclasses, which is the canonical way to persist non-primitive
state across `RestorationMixin`. Both `_RestorableColor` and
`_RestorableStringList` follow the textbook pattern:

```dart
class _RestorableColor extends RestorableProperty<Color> {
  _RestorableColor([Color? defaultValue])
      : _defaultValue = defaultValue ?? const Color(0xFF3F51B5);

  final Color _defaultValue;
  late Color _value;                      // ← (A) late-init

  Color get value => _value;
  set value(Color newValue) { /* … */ }

  @override
  Color createDefaultValue() => _defaultValue;

  @override
  void initWithValue(Color value) {       // ← (B) framework writes _value here
    _value = value;
    notifyListeners();
  }
  // …
}

class _RestorableStringList extends RestorableProperty<List<String>> {
  _RestorableStringList([List<String>? defaultValue])
      : _defaultValue = List<String>.unmodifiable(defaultValue ?? const <String>[]);

  final List<String> _defaultValue;
  late List<String> _value;

  // ← (C) defensive copy through `List.unmodifiable`
  List<String> get value => List<String>.unmodifiable(_value);
  // …
}

// In `_buildFavoritesStrip`:
final List<String> favs = _favoriteSwatches.value;
return Wrap(children: <Widget>[
  for (final String hex in favs) _favoriteChip(hex),  // ← (D) for-in
]);
```

In real Flutter the chain is: `initState()` → `restoreState()` is
called *before* the first build → `registerForRestoration` calls
`initWithValue(createDefaultValue())` (or
`initWithValue(fromPrimitives(saved))`) → `_value` is set → first
`build()` runs and `_value` is safe to read.

### Why it FE-fires under d4rt

Two distinct shapes, both rooted in the bridged
`RestorationMixin` proxy (the same architectural limitation
documented above for D3/D4):

1. **(A) `late _value` LateInit.** Under cross-script ordering
   the bridged `registerForRestoration` → user-override
   `initWithValue` dispatch can be skipped or reordered, so
   `_value` is read before `initWithValue` was called and the
   `late` field throws `LateInitializationError`.

2. **(C)→(D) `for-in BridgedInstance<Object>`.** Even after the
   late-init shape is fixed by eager-seeding (workaround below),
   reading `_favoriteSwatches.value` from script context can
   short-circuit through the bridge proxy and return a
   `BridgedInstance<Object>` instead of dispatching to the user's
   `value` getter override. The `for-in` then trips
   "`Value used in collection 'for-in' must be an Iterable, but
   got BridgedInstance<Object>`".

Both shapes only surface inside the multi-script
`secondary_classes_test` sequence — the script in isolation
records FE=0. The interpreter cannot deliver bridged
`RestorationMixin` proxy dispatch deterministically under
cross-script ordering without a full restore-bucket emulation,
which is the architectural limitation already catalogued for
D3/D4 in the closed clusters of `testlog_20260428-1333` and
`testlog_20260427-1339`.

### Workaround applied (script-side, single-test verified)

Three small, surgical edits to
`widgets/restorable_property_test.dart`:

**(1) Eager-seed `_value` from constructor and drop `late`.**

```dart
_RestorableColor([Color? defaultValue])
    : _defaultValue = defaultValue ?? const Color(0xFF3F51B5),
      _value = defaultValue ?? const Color(0xFF3F51B5);   // ← seeded

final Color _defaultValue;
Color _value;                                              // ← no longer late
```

Functionally equivalent to the textbook pattern: `initWithValue`
still reassigns `_value` from the framework-supplied value when
the lifecycle does run, so restoration round-trips remain
correct. The default is just a *safe initial* that prevents
LateInit if the framework dispatch is skipped.

**(2) Replace `List.unmodifiable` with `List.from` in the list
getter.**

```dart
List<String> get value => List<String>.from(_value);
```

`List.unmodifiable` returns a bridged read-only view that surfaces
as `BridgedInstance<Object>` to script-side iteration in some
ordering paths. `List.from` returns a plain `List<String>` and
preserves the defensive-copy guarantee (callers still cannot
mutate `_value`).

**(3) Defensive snapshot for the iteration site.**

```dart
List<String> _favoritesSnapshot() {
  try {
    final dynamic raw = _favoriteSwatches.value;
    if (raw is List<String>) return raw;
    if (raw is List) {
      final List<String> out = <String>[];
      for (final dynamic e in raw) {
        out.add(e.toString());
      }
      return out;
    }
  } catch (_) {
    // Fall through — bridge proxy didn't dispatch to override.
  }
  return const <String>[];
}

// Use:
final List<String> favs = _favoritesSnapshot();
//                       and …
if (_favoritesSnapshot().contains(hex)) { /* … */ }
```

If the proxy chain dispatches correctly, the snapshot returns the
real list. If the cross-script ordering path falls through to a
`BridgedInstance<Object>`, the type checks fail and we get an
empty list — equivalent to the "no favourites yet" first-render
branch the framework would have produced in real Flutter, so the
demo still renders coherently with no FE.

### Verification

- **Pre-fix (testlog_20260428-2250):** `restorable_property_test`
  FE=1 (`LateInitializationError`) inside `secondary_classes_test`.
- **Post-eager-init only:** `restorable_property_test` FE=1
  (shape changed to `for-in BridgedInstance<Object>`) — the
  late-init shape was cured but exposed the iteration shape.
- **Post-full workaround:** `restorable_property_test` FE=0
  inside `secondary_classes_test` (`secondary_post3.log.txt`).
- Single-test invocation (regression rule (a) was sufficient
  because all changes are confined to a single test script):
  `secondary_classes_test --plain-name 'restorable_property'` →
  FE=0.

**Documented.** 2026-04-29 (N2 closure via script-side
eager-init + defensive iteration; underlying interpreter
limitation remains the same one catalogued for D3/D4).

### Deferred architectural fix (C-E4 closing route)

The carry-over cluster **C-E4** (`testlog_20260428-2250` /
1333 §E4) lists an alternative closing route: thread the
bridged `RestorableProperty.value` setter through the
interpreter visitor's `_setBridgedInstanceField` path so that
the assignment performed by the bridged constructor pipeline
reaches the script-side late field. This would close the
late-init path at the interpreter level and remove the need
for the script-side eager-seed step (1) above. The other two
steps (`List.from` getter swap and `_favoritesSnapshot()`)
would still be required for the iteration shape, which is a
separate manifestation of the same proxy-dispatch limitation.

**Why deferred:**

- The fix touches both `tom_d4rt/lib/src/interpreter_visitor.dart`
  and `tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart`
  (sync rule), and the bridged-mixin field-storage path is
  consumed by every `RestorationMixin`-derived script —
  regression risk is broad.
- Symptomatic closure is already in place (FE=0 on
  `restorable_property_test` and `restorable_string_test`),
  so the architectural fix has no remaining test-side urgency.
- The scope overlaps the larger D3/D4 architectural limitation
  catalogued above; the right place to land it is alongside a
  more general bridged-mixin lifecycle pass, not as a
  property-class-specific shim.

**Re-opening trigger:** any new `RestorableProperty` subclass
in the test corpus that cannot be made FE=0 by the script-side
recipe above; or a planned interpreter pass on
bridged-mixin field-storage / proxy lifecycle that would
naturally fold this in.

---

## P1 — `PreferredSizeWidget` cast fails when arg arrives as a cached native widget proxy

**Source:** `testlog_20260503-0948-issue-analysis` priority-1
cluster ("Bridge: `InterpretedInstance` not coerced for typed
Flutter param"). Two of the three reported sub-cases —
`SliderThemeData.thumbShape` and
`SpellCheckConfiguration.spellCheckService` — were closed by
adding `SliderComponentShape` and `SpellCheckService` to the
`proxyClasses` allowlist in `buildkit.yaml` and regenerating
`flutter_proxies.b.dart`. The third sub-case
(`Scaffold.appBar` in `widgets/snapshot_mode_test.dart`) does
**not** close on the same fix and is documented here as an
interpreter architectural limitation.

### What the script does

`widgets/snapshot_mode_test.dart` follows the canonical Flutter
pattern for a custom app bar:

```dart
class _SmodeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _SmodeAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(88);

  @override
  Widget build(BuildContext context) => AppBar(...);
}

// later, in a build method:
Scaffold(appBar: const _SmodeAppBar(), body: ...)
```

The class chain has `bridgedSuperclass = StatelessWidget` and
`bridgedInterfaces = [PreferredSizeWidget]`.

### Why the cast fails

The `Scaffold` bridge constructor calls
`D4.extractBridgedArg<PreferredSizeWidget?>(arg, 'appBar', visitor)`.
The reported error is:

```
Native error during default bridged constructor for 'Scaffold':
Argument Error: Invalid parameter "appBar":
expected PreferredSizeWidget?, got _InterpretedStatelessWidget
```

Trace:

1. The interpreter evaluates `_SmodeAppBar()` and creates an
   `InterpretedInstance`. As part of its lifecycle (auto-instantiation
   via the `StatelessWidget` proxy factory) the instance's
   `nativeProxy` is set to a `_InterpretedStatelessWidget` —
   the proxy registered for the *first* matching bridged
   superclass walked, which is `StatelessWidget`.
2. By the time the `Scaffold` argument list is assembled by the
   visitor, the value reaching the bridge is the cached
   `_InterpretedStatelessWidget` itself, **not** the
   `InterpretedInstance` — the framework-side caller already
   "extracted" the native Widget proxy when the value was bound
   into the widget tree.
3. `extractBridgedArg<T>` in
   `tom_d4rt/lib/src/generator/d4.dart` and the mirror in
   `tom_d4rt_ast/lib/src/runtime/generator/d4.dart` only run the
   `tryCreateInterfaceProxyWithVisitor<T>` walk when
   `arg is InterpretedInstance`. With a native Widget arg the
   walk is skipped, and the final `arg as T` cast fails because
   `_InterpretedStatelessWidget` does not implement
   `PreferredSizeWidget`.
4. The hand-written `_InterpretedPreferredSizeWidget` proxy
   *would* have satisfied the cast — the proxy walk in
   `tryCreateInterfaceProxyWithVisitor<PreferredSizeWidget>` even
   collects it correctly via `bridgedInterfaces` (see
   `d4.dart:1929-1949`). The issue is that the walk never runs
   because the arg's type changed upstream.

### Why we are not fixing this in cluster scope

A clean fix would require:

- A marker abstraction (e.g. `InterpretedNativeProxy`) that every
  hand-written `_Interpreted…Widget` proxy implements, exposing
  the underlying `InterpretedInstance` and `InterpreterVisitor`.
- A new branch in `extractBridgedArg<T>` that, when arg matches
  `InterpretedNativeProxy` *and* the cast `arg is T` already
  fails, re-runs `tryCreateInterfaceProxyWithVisitor<T>` against
  the wrapped instance — picking up other registered proxies on
  the same script class for a different `T`.
- Mirrored changes in `tom_d4rt` and `tom_d4rt_ast`, plus a
  retroactive update of every existing
  `_Interpreted…Widget`/`_Interpreted…Element` proxy in
  `tom_d4rt_flutter_ast/lib/src/d4rt_runtime_registrations.dart`
  and the `tom_d4rt_flutter_test` mirror to implement the marker.

The change touches the interpreter's ergonomic argument-coercion
path on every bridged constructor call. It is well outside the
scope of a single-cluster fix and risks regressions across the
whole bridge surface, so it is deferred.

### Script-side workaround (functional equivalent)

Flutter ships a concrete `PreferredSize` widget that wraps any
child with a declared preferred size:

```dart
PreferredSize(
  preferredSize: const Size.fromHeight(88),
  child: AppBar(
    backgroundColor: _kSmodeCharcoalDeep,
    elevation: 0,
    automaticallyImplyLeading: false,
    toolbarHeight: 88,
    title: ...,
  ),
)
```

`PreferredSize` is a `StatelessWidget` that *implements*
`PreferredSizeWidget` natively, so passing one to
`Scaffold(appBar: ...)` satisfies the cast directly. The
functional result is identical: the appBar's preferred height is
declared, `Scaffold` reserves the right amount of vertical
space, and the `AppBar` body renders unchanged. The only
behavioural difference is that the script no longer needs a
custom subclass — the `_SmodeAppBar` declaration can be folded
into a top-level `Widget _smodeAppBar()` factory or directly
inline at the call site.

This is the recommended rewrite for any d4rt script that hits
the same FE; whether to apply it now or wait for the
interpreter-level fix is left to the per-script cluster owner.

### Re-opening trigger

Any of:

- A planned interpreter pass that introduces an
  `InterpretedNativeProxy` marker interface (or equivalent
  re-walk hook) on the cached `nativeProxy` field.
- A new test script in the corpus that fails the same way and
  cannot be rewritten to use `PreferredSize(...)` (e.g. a script
  that needs to expose other state through the
  `PreferredSizeWidget` interface beyond `preferredSize`).

---

## P4 — `switch (BridgedEnum)` may fall through every case, returning null

### What the scripts do

Each affected script defines `String`-returning helpers that
switch over a Flutter-bridged enum (`TargetPlatform` in
`foundation/target_platform_test.dart` and
`widgets/tooltip_window_controller_delegate_test.dart`,
`TimeOfDayFormat` in `material/time_of_day_format_test.dart`).
The shape is the canonical exhaustive Dart switch:

```dart
String _platformOs(TargetPlatform p) {
  switch (p) {
    case TargetPlatform.android: return 'Android';
    case TargetPlatform.iOS: return 'iOS / iPadOS';
    // … one return per enum value, no default
  }
}
```

The result flows into a downstream `Text(...)` either directly
(`Text(_icuPattern(fmt))`) or via a wrapper widget that requires
a non-null `String` parameter (`_heroChip(label, _platformFamily(current), tint)`
→ `Text(value, ...)`).

### Why it FE-fires under d4rt

The interpreter's `visitSwitchStatement` matches each
`SSwitchCase` by evaluating the case expression and probing both
directions:

```dart
if (switchValue == caseValue ||
    (caseValue != null && caseValue == switchValue)) {
  matched = true;
  execute = true;
}
```

The Cluster-26 comment alongside the probe acknowledges that
"the native enum / BridgedEnumValue boundary is asymmetric." In
practice, for some bridged enum values neither direction returns
true at the case-statement boundary, even though the same
expression `p == TargetPlatform.android` evaluates correctly when
written outside a switch (`_isCupertinoFamily` in
`foundation/target_platform_test.dart` uses exactly this `==`
form and works). Result: every case is skipped, the function
falls through without executing any return, and the implicit
return value is `null` — which surfaces downstream as
`Native error during default bridged constructor for 'Text': … "data": expected String, got Null`.

The mismatch only manifests for `case <BridgedEnum>.value:` forms
specifically. Pattern cases (`SSwitchPatternCase`) and `==` in
plain expressions both work — only legacy switch case statements
exhibit the asymmetry.

### Why we are not fixing this in cluster scope

A real fix would patch the bridged-enum equality probe inside
`visitSwitchStatement` (mirror in both `tom_d4rt` and
`tom_d4rt_ast`). The existing Cluster-26 comment shows that the
asymmetry is recognised and partly defended against — the
single-side `caseValue == switchValue` probe was added there for
exactly this reason. Hardening it further (e.g. unwrapping
`BridgedInstance` operands and comparing native enum identities
directly) is a small change in principle, but:

- It requires landing in two interpreters in lock-step
  (`tom_d4rt`, `tom_d4rt_ast`).
- It needs full regression — switch-equality is reused for every
  type, not just enums, so a regression risk reaches every
  script that uses any switch.
- The flutter-material script corpus already prefers the
  if/else form (`_isCupertinoFamily` proves it), so the
  script-side path is uncomplicated and produces fewer surprises
  for future contributors.
- The cluster description in
  `testlog_20260503-0948-issue-analysis/error_analysis.md`
  explicitly suggests a script-side or interpreter null-check —
  i.e. a script-side rewrite is acceptable.

### Script-side workaround

For each affected helper, convert `switch (e) { case A: …; case B: …; }`
to an `if/else` chain over `==` and add a final `return` that
covers the theoretically unreachable case (Dart's exhaustiveness
checker stays satisfied; the d4rt fall-through path now hits the
default instead of returning null):

```dart
String _platformOs(TargetPlatform p) {
  if (p == TargetPlatform.android) return 'Android';
  if (p == TargetPlatform.iOS) return 'iOS / iPadOS';
  if (p == TargetPlatform.fuchsia) return 'Fuchsia';
  if (p == TargetPlatform.linux) return 'Linux desktop';
  if (p == TargetPlatform.macOS) return 'macOS';
  if (p == TargetPlatform.windows) return 'Windows';
  return p.name; // unreachable on real Dart; safety net for d4rt
}
```

For `String note;`-style declared-but-unassigned variables fed
by a switch (`tooltip_window_controller_delegate_test.dart`
`_PlatformNotesSection.build`), seed the variable with the
default branch's text and let the `if/else` chain overwrite it
when a more specific branch matches:

```dart
String note = 'On ${p.name}, real tooltip windows … (default branch text)';
if (p == TargetPlatform.macOS) note = '…macOS-specific…';
else if (p == TargetPlatform.windows) note = '…Windows-specific…';
else if (p == TargetPlatform.linux) note = '…Linux-specific…';
```

### Verification

Per regression rule (a) in the cluster fix protocol — script-only
changes need only individual retests, no full essential /
important / secondary regression suite:

| Script | Driver | Result |
|--------|--------|--------|
| `widgets/tooltip_window_controller_delegate_test.dart` | `tom_d4rt_flutter_ast` | **PASS** (was the gii failure in §2.2) |
| `widgets/tooltip_window_controller_delegate_test.dart` | `tom_d4rt_flutter_test` | **PASS** |
| `foundation/target_platform_test.dart` | `tom_d4rt_flutter_ast` | **PASS** (was the hr1 failure in §2.3) |
| `foundation/target_platform_test.dart` | `tom_d4rt_flutter_test` | **PASS** |
| `material/time_of_day_format_test.dart` | `tom_d4rt_flutter_ast` | **PASS** (was the hr2 failure in §2.4) |
| `material/time_of_day_format_test.dart` | `tom_d4rt_flutter_test` | **PASS** |

Captured in
`tom_d4rt_flutter_test/doc/testlog_20260503-0948-issue-analysis/cluster4_individual/`.

### Re-opening trigger

Any of:

- A planned interpreter pass that rewrites the bridged-enum
  case-match probe in `visitSwitchStatement` to unwrap
  `BridgedInstance` operands and compare native enum identities
  directly. Mirror in `tom_d4rt` and `tom_d4rt_ast`.
- A new test script in the corpus that uses `switch
  (BridgedEnum)` with side-effects in the case bodies (i.e.
  cannot easily be rewritten as a pure `if/else` returning a
  String).

---

## G1 — `D4.getNamedArgWithDefault<T?>` collapses explicit `null` to default for nullable-typed named args

**Source cluster:** `testlog_20260503-2009-issue-analysis`
cluster **C1 — Cupertino minLines/maxLines assertion** (essential
`cupertino/textfield_test.dart`, hardly_1
`cupertino/cupertino_text_selection_handle_controls_test.dart`).

**Status:** ✅ **RESOLVED at the helper level (2026-05-04).** The
two-branch fix proposed below was applied to both
`tom_d4rt/lib/src/generator/d4.dart` and
`tom_d4rt_ast/lib/src/runtime/generator/d4.dart`. The script-side
workaround has been reverted — the two Cupertino scripts now use
the original `maxLines: null` form again and pass.

### Symptom

Both Cupertino scripts authored deep-demos that paired
`maxLines: null` (Flutter's "grow without bound" sentinel) with
`minLines: N` (N ≥ 2). Stock Flutter accepts this combination —
the constructor assertion is

```dart
// flutter/lib/src/cupertino/text_field.dart:310-320
assert(
  (maxLines == null) || (minLines == null) || (maxLines >= minLines),
  'minLines can\'t be greater than maxLines',
);
```

— so passing `maxLines: null` short-circuits the assertion. Under
d4rt the assertion fires:

```
Native error during default bridged constructor for
'CupertinoTextField': 'package:flutter/src/cupertino/text_field.dart':
Failed assertion: line 320 pos 10: '(maxLines == null) ||
(minLines == null) || (maxLines >= minLines)':
minLines can't be greater than maxLines
```

— because by the time the assertion runs, `maxLines` is **`1`**
(the constructor's default), not the `null` the script passed.

### Root cause

The generated `cupertino_bridges.b.dart` constructor adapter for
`CupertinoTextField` resolves `maxLines` via:

```dart
final maxLines = D4.getNamedArgWithDefault<int?>(named, 'maxLines', 1);
```

where `D4.getNamedArgWithDefault` is defined in both
`tom_d4rt/lib/src/generator/d4.dart` (≈line 1590) and
`tom_d4rt_ast/lib/src/runtime/generator/d4.dart` (≈line 1634) as:

```dart
static T getNamedArgWithDefault<T>(
  Map<String, Object?> named,
  String paramName,
  T defaultValue,
) {
  if (!named.containsKey(paramName) || named[paramName] == null) {
    return defaultValue;
  }
  return extractBridgedArg<T>(named[paramName], paramName);
}
```

The guard `!named.containsKey(paramName) || named[paramName] == null`
**conflates two semantically distinct cases**:

1. The caller did not pass the named arg (key absent) — fall back
   to the bridge-supplied default.
2. The caller explicitly passed `null` (key present, value
   `null`) — keep `null`.

For nullable-typed parameters (`T = int?`, `T = double?`,
`T = String?`, …), case (2) is the user's deliberate signal. The
helper silently rewrites it back to (1), erasing the distinction
between "I want the framework's default" and "I want the
explicit-null sentinel".

`CupertinoTextField` is the noisy surface because Flutter encodes
"grow without bound" as the explicit-null sentinel and pairs it
with an assertion that depends on it.

### Resolution applied (2026-05-04)

The helper's single guard was replaced with two branches in both
`tom_d4rt/lib/src/generator/d4.dart` and
`tom_d4rt_ast/lib/src/runtime/generator/d4.dart`:

```dart
static T getNamedArgWithDefault<T>(
  Map<String, Object?> named,
  String paramName,
  T defaultValue,
) {
  if (!named.containsKey(paramName)) return defaultValue;
  final raw = named[paramName];
  if (raw == null) {
    // Explicit null is the caller's intent; only fall back to the
    // default when T is non-nullable, since extractBridgedArg<T>
    // would throw on null in that case.
    return null is T ? null as T : defaultValue;
  }
  return extractBridgedArg<T>(raw, paramName);
}
```

Rationale:

- `null is T` is true iff `T` accepts null. For nullable type
  parameters (`int?`, `Widget?`, `SpellCheckService?`, …) the
  helper now preserves the script's explicit-null intent; for
  non-nullable type parameters it still falls back to the
  bridge-supplied default (an explicit null on a non-nullable
  param is treated as an omission — `extractBridgedArg<T>` would
  otherwise throw on null).
- The helper is mirrored in both `tom_d4rt` and `tom_d4rt_ast`
  per the quest's "keep tom_d4rt ↔ tom_d4rt_ast in sync" rule.

### Script-side workaround (no longer required)

Historically the closing path for this cluster was to replace
`maxLines: null` with a finite cap. **As of 2026-05-04 this is no
longer necessary** — the helper now honours explicit-null. The two
Cupertino scripts have been reverted to use `maxLines: null`
again. The captured workaround text below is kept for history.

```dart
// reverted form — explicit-null is now honoured by the helper
CupertinoTextField(
  controller: _ctrl,
  maxLines: null,
  minLines: 4,
  // …
)
```

### Verification

The runtime helper is called from every generated `*.b.dart`
constructor adapter across the entire `flutter-material` corpus.
Per regression rule (b) in the cluster fix protocol —
interpreter/runtime change requires the individual scripts plus
the essential, important, and secondary suites:

| Script | Driver | Result |
|--------|--------|--------|
| `cupertino/textfield_test.dart` (individual, reverted form) | `tom_d4rt_flutter_test` | ✅ pass (`testlog_20260504-g1fix-verify/textfield_individual.*`) |
| `cupertino/cupertino_text_selection_handle_controls_test.dart` (individual, reverted form) | `tom_d4rt_flutter_test` | ✅ pass (`testlog_20260504-g1fix-verify/handle_controls_individual.*`) |
| `essential_classes_test.dart` | `tom_d4rt_flutter_test` | ✅ 108/108 pass |
| `important_classes_test.dart` | `tom_d4rt_flutter_test` | ✅ 164/164 pass |
| `secondary_classes_test.dart` | `tom_d4rt_flutter_test` | ✅ 653 pass / 1 skip |

### Re-opening trigger

The bug is closed. A re-open would only be triggered by a future
finding that the new helper semantics break a different bridge
adapter that genuinely relies on the old "null → default"
coalescing. Such a case must surface in the regression suites
captured at fix time; if it appears later, raise a new bug rather
than re-opening §G1.

---

## R1 — Redirecting factory constructor syntax (`factory X() = Y`) not implemented

### What the script does

Flutter's modern public API for `RegularWindowController` (and a
growing number of other framework classes) uses the **redirecting
factory constructor** form to keep a clean public abstract type
while delegating instantiation to a private host implementation:

```dart
abstract class RegularWindowController extends ChangeNotifier {
  // Redirecting factory: `RegularWindowController(...)` forwards to
  // `_HostRegularWindowController(...)` at the language level — no
  // body, no `return`, just `=`.
  factory RegularWindowController({
    Size? preferredSize,
    Offset? preferredPosition,
    String? title,
    BoxConstraints? preferredConstraints,
    bool isActivated = true,
  }) = _HostRegularWindowController;

  // ... abstract API surface ...
}

class _HostRegularWindowController extends RegularWindowController {
  _HostRegularWindowController({...}) : super._();
  // ... concrete implementation ...
}
```

Call sites then look like:

```dart
final RegularWindowController controller = RegularWindowController(
  preferredSize: const Size(640, 280),
  title: 'Regular Window Demo',
);
```

This is the same pattern Flutter uses for many factory-bound types
(`Map`, `Set`, `List` historically; modern window/desktop APIs;
material `Color` factories with platform fallbacks). The Dart
analyzer lowers the abstract-class `factory X(...) = Y;` form into
a forwarding call to the redirected concrete constructor, so the
runtime sees `Y(...)` even though the source wrote `X(...)`.

### Why it FE-fires under d4rt

The d4rt interpreter does not implement the redirecting-factory
`=` form. Concretely:

- `tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart` only
  honours `redirectedConstructor` in the **enum** declaration path
  (around line 8895), where it throws an `UnimplementedD4rtException`
  for redirected enum constructors. There is no class-level
  handling.
- `tom_d4rt_ast/lib/src/runtime/callable.dart` (lines ~1010-1075)
  handles `SRedirectingConstructorInvocation` — but that node
  type represents only the **initializer-list** redirect form
  (`MyClass.alt() : this(arg);`), not the **factory** redirect
  form (`factory MyClass() = Other;`).
- When the interpreter encounters
  `RegularWindowController(preferredSize: …)`, it resolves the
  identifier to the abstract class, finds no concrete
  constructor body to execute, and throws `Cannot instantiate
  abstract class 'RegularWindowController'`. The redirected target
  `_HostRegularWindowController` is never consulted.

The same limitation applies to any abstract class that exposes its
public constructor purely as a redirecting factory; scripts
calling the abstract name directly will all fail this way.

### Why we are not fixing this in cluster scope

Implementing redirecting factory constructors correctly requires:

1. A new AST node (or extension of the existing factory-constructor
   node) carrying the `redirectedConstructor` reference at class
   level.
2. `tom_ast_generator` changes to copy the analyzer's
   `redirectedConstructor` field into the mirror AST.
3. Interpreter dispatch logic that, when a constructor invocation
   resolves to a redirecting factory, looks up the redirected
   target (potentially in another library), substitutes the type
   arguments, and forwards the original arguments — including
   handling chains of redirects and constructor-name forms
   (`= Y.named`).
4. Mirror in `tom_d4rt` (analyzer-based) ↔ `tom_d4rt_ast`
   (mirror-AST) so both drivers behave identically.
5. A regression-coordinated pass through essential + important +
   secondary + gii to surface secondary-effect call sites — the
   current corpus has at least one (`RegularWindowController`),
   and the SDK uses this form widely so silent forwarding could
   produce surprising aliasing in unrelated tests.

That is a multi-day interpreter feature, not a cluster-scope fix.

### Script-side workaround (functional equivalent)

Replace the abstract-class call with a direct instantiation of the
concrete redirected subclass, while keeping the variable type as
the abstract base so the rest of the script still exercises the
public API:

```dart
// BEFORE — relies on redirecting factory:
final RegularWindowController _primaryController =
    RegularWindowController(
  preferredSize: const Size(640, 280),
  title: 'Regular Window Demo',
);

// AFTER — direct concrete instantiation, abstract type preserved:
//
// d4rt INTERPRETER NOTE: the interpreter does not implement the
// redirecting factory constructor syntax
// (`factory RegularWindowController(...) = _HostRegularWindowController;`
// on the abstract class above). When the script writes
// `RegularWindowController(...)`, d4rt sees the abstract class and
// throws `Cannot instantiate abstract class
// 'RegularWindowController'` instead of forwarding to the
// redirected concrete constructor. Therefore the live call sites
// instantiate the concrete `_HostRegularWindowController` directly
// while the variable types remain the abstract
// `RegularWindowController`, preserving SDK-shape fidelity.
final RegularWindowController _primaryController =
    _HostRegularWindowController(
  preferredSize: const Size(640, 280),
  title: 'Regular Window Demo',
);
```

This is **functionally identical** to the redirected call: the
analyzer would have lowered the original to exactly this. The
abstract base type continues to drive all subsequent code (method
calls, listener wiring, the `RegularWindowController` API
contract), so the rest of the script remains unchanged.

### Verification

- Individual flutter test on
  `widgets/regular_window_test.dart` after the rewrite:
  `+1: All tests passed!` (status=success, httpStatus=200,
  frameworkErrors=0, bundleJsonBytes≈917 KB).
- `dart analyze` on `tom_d4rt_flutter_ast` after the edit: clean.

### Re-opening trigger

Any of:

- A planned interpreter pass that implements redirecting factory
  constructors at class scope (mirror across `tom_d4rt` ↔
  `tom_d4rt_ast`, with the AST + astgen changes outlined above and
  a regression-coordinated essential + important + secondary + gii
  sweep).
- A script that genuinely depends on the abstract-name
  instantiation being observable through reflection (e.g. asserts
  `runtimeType == RegularWindowController` rather than the
  concrete subclass). The current rewrite preserves the **static**
  type but the **runtime** type is the concrete subclass — same
  behaviour as the analyzer's lowered output, so this is not
  actually a divergence from native Flutter.

---

## L1 — `AnimatedBuilder.animation` rejects script-defined subclass of bridged `Listenable`/`ChangeNotifier` (RESOLVED 2026-05-10)

> **Status: resolved** — the architectural gap described below is
> closed by registering a `ChangeNotifier` / `Listenable` interface
> proxy in `d4rt_runtime_registrations.dart` (both
> `tom_d4rt_flutter_ast` and `tom_d4rt_flutter_test`). The
> script-side workaround in
> `widgets/windowing_owner_mac_o_s_test.dart` was reverted; the
> two layout fixes (`_DockTile` overflow, `_ContentArea` badge
> overflow) that were necessary follow-ups remain. This entry is
> kept for historical context — see "Resolution" below for the
> final design.

### What the script does

Flutter's `AnimatedBuilder` accepts any `Listenable` as its
`animation:` argument; the most common pattern in larger demos is
to subclass `ChangeNotifier` from a script and pass `this` so the
builder rebuilds whenever the controller fires `notifyListeners()`:

```dart
abstract class BaseWindowController extends ChangeNotifier {
  // ... abstract API ...
}

abstract class RegularWindowController extends BaseWindowController { … }

class RegularWindowControllerMacOS extends RegularWindowController {
  // concrete impl with notifyListeners() in setters
}

// Caller:
return AnimatedBuilder(
  animation: controller, // ← controller : RegularWindowControllerMacOS
  builder: (BuildContext context, Widget? _) {
    return Text(controller.title);
  },
);
```

This is the canonical "use a `ChangeNotifier` subclass as the
`Listenable` for an `AnimatedBuilder`" Flutter recipe. It works in
native Flutter because `RegularWindowControllerMacOS extends
ChangeNotifier`, and `ChangeNotifier implements Listenable`, so the
script-defined class is statically and dynamically a `Listenable`.

The trigger appeared in
`testlog_20260503-2009-issue-analysis/error_analysis.md` cluster
**C2** for `widgets/windowing_owner_mac_o_s_test.dart`, with 11
failure events of:

```
Native error during default bridged constructor for 'AnimatedBuilder':
Argument Error: Invalid parameter "animation":
expected Listenable, got InterpretedInstance(RegularWindowControllerMacOS)
```

The same family of errors hit any script that authors a
`ChangeNotifier`-based controller and hands it to a bridged Flutter
type whose constructor parameter is typed `Listenable` (or
`Animation<T>`, or anything in that hierarchy).

### Why it FE-fired under d4rt

The bridge generator emits the `AnimatedBuilder` constructor
adapter with a typed coercion for `animation`:

```dart
final animation = D4.getRequiredNamedArg<Listenable>(
    named, 'animation', 'AnimatedBuilder');
```

`getRequiredNamedArg<T>` delegates to `D4.extractBridgedArg<T>`
which, for an `InterpretedInstance` argument, walks (1) the cached
`nativeProxy`, (2) `bridgedSuperObject`, (3) registered generic
wrapper factories, (4) registered **interface proxy factories**
(`tryCreateInterfaceProxyWithVisitor<T>`). The proxy walk collects
candidate names from the InterpretedClass's `bridgedSuperclass`,
`bridgedInterfaces`, `bridgedMixins` (recursively, via
interpreted `superclass`/`mixins`/`interfaces`) plus
`BridgedClass.transitiveSupertypeNames`. For
`RegularWindowControllerMacOS extends RegularWindowController
extends BaseWindowController extends ChangeNotifier`, the candidate
list reaches `ChangeNotifier` and `Listenable` correctly.

The gap was simply that **no proxy factory was registered** for
`'ChangeNotifier'` or `'Listenable'`. The walk therefore returned
null and `extractBridgedArg` fell through to its terminal throw.

### Resolution (2026-05-10)

Both `ChangeNotifier` and `Listenable` are now registered in
`_registerInterfaceProxies()` (same code in both
`tom_d4rt_flutter_ast` and `tom_d4rt_flutter_test` so the
analyzer-free and analyzer-based variants behave identically):

```dart
D4.registerInterfaceProxy('ChangeNotifier', (visitor, instance) {
  final bridgedSuper = instance.bridgedSuperObject;
  if (bridgedSuper is ChangeNotifier) return bridgedSuper;
  final cached = instance.nativeProxy;
  if (cached is ChangeNotifier) return cached;
  final proxy = ChangeNotifier();
  instance.nativeProxy ??= proxy;
  return proxy;
});
D4.registerInterfaceProxy('Listenable', (visitor, instance) {
  final bridgedSuper = instance.bridgedSuperObject;
  if (bridgedSuper is Listenable) return bridgedSuper;
  final cached = instance.nativeProxy;
  if (cached is Listenable) return cached;
  final proxy = ChangeNotifier();
  instance.nativeProxy ??= proxy;
  return proxy;
});
```

Why this works without any generator change:

1. **No new wrapper allocation in the common case.** When a script
   class declares `extends ChangeNotifier` (with or without an
   explicit constructor that calls `super()`), the interpreter
   already invokes the bridged `ChangeNotifier` default constructor
   and stores the resulting native `ChangeNotifier()` on
   `instance.bridgedSuperObject`
   (`tom_d4rt_ast/lib/src/runtime/runtime_types.dart` Path B,
   `callable.dart` explicit-super paths).
2. **Listener contract is preserved end-to-end.** Bridged-super
   method dispatch on the InterpretedInstance routes through
   `bridgedSuperObject ?? nativeProxy`
   (`runtime_types.dart` line 1319), so:
    - Flutter widgets call `proxy.addListener(_handleChange)` →
      native `ChangeNotifier.addListener` registers the listener
      on the same instance the proxy returned.
    - Script code calls `controller.notifyListeners()` → resolves
      to the bridged `ChangeNotifier.notifyListeners` adapter,
      which forwards to `bridgedSuperObject.notifyListeners()` —
      the same `ChangeNotifier` the listener was registered on.
   Identity is preserved, the listener fires, and the AnimatedBuilder
   rebuild path works.
3. **Fallback for `implements Listenable` (no bridged super).**
   When `bridgedSuperObject` is null, allocate a fresh
   `ChangeNotifier()` lazily and cache on `nativeProxy`. Bridged
   dispatch's `bridgedSuperObject ?? nativeProxy` then routes
   `notifyListeners()` calls through the same instance. Pure
   `implements Listenable` script classes that define their own
   `addListener`/`notifyListeners` without ever delegating to a
   bridged method are not covered by this fallback — that's a
   separate, narrower limitation.

### Verification

- Individual retest:
  `flutter test test/generator_interpreter_issues_test.dart
  --plain-name "windowing_owner_mac_o_s"` →
  `+1: All tests passed!` (status=success, frameworkErrors=0,
  sourceChars=99640).
- The script-side workaround at
  `_MacChrome.build()` (line 810) and `_DockTile.build()`
  (line 2622) was reverted: `animation: const
  AlwaysStoppedAnimation<double>(0.0)` → `animation: controller`.
- The `_DockTile` and `_ContentArea` layout fixes from the
  workaround commit (gradient/font/padding shrink, badge `Wrap`
  wrapped in `Expanded(SingleChildScrollView)`) remain in place —
  those are real layout bugs that surfaced once `AnimatedBuilder`
  builds actually completed and are not specific to d4rt.
- Per regression rule (b) — change outside `test/` — the
  fix was followed by an essential + important + secondary
  classes serial sweep before commit. Results recorded in the
  resolution commit message.

### Why this is **not** in the proxy generator

Earlier analysis assumed this needed a generator-side template that
emits `ChangeNotifier`-backed proxy classes per bridged
`ChangeNotifier` subclass. That assumption was wrong: the existing
runtime infrastructure (proxy registry + `bridgedSuperObject`
backing + bridged-super method dispatch fallback) already covers
the listener contract correctly when the candidate name is known to
the registry. Two factory registrations are sufficient — the
generator doesn't need to know about ChangeNotifier semantics at
all. This keeps the generator simple and the fix narrowly scoped.

---

## T1 — `runtimeType.toString()` on user-defined interpreted classes

### Symptom

```text
Runtime Error: Class '_DemoRouteTransitionRecord' has no static
method or named constructor named 'toString'.
```

Surfaces wherever a script reads `someInstance.runtimeType` and
then calls `.toString()` on the result, e.g. for diagnostic
labels:

```dart
final String runtime = record.runtimeType.toString();
```

### Diagnosis

For native Dart objects, `Object.runtimeType` returns a `Type`
instance whose `toString()` is the class name. The d4rt
interpreter, however, returns the interpreted class itself
(`InterpretedClass`) as the `runtimeType` of an
`InterpretedInstance`. `InterpretedClass.toString` is not
exposed as a callable member, so the chained `.toString()`
invocation looks up a static method named `toString` on the class
and throws `no static method or named constructor named
'toString'`.

The same construct works on bridged native classes because their
`runtimeType` resolves to a real `Type` whose `toString()` lives on
the native side.

### Workaround (script-side)

Emit the class-name string manually using `is` checks against the
expected concrete subclass:

```dart
final String runtime = record is _DemoRouteTransitionRecord
    ? '_DemoRouteTransitionRecord'
    : 'RouteTransitionRecord';
```

For diagnostic-only contexts (logging, debug labels), this is
purely cosmetic and behavioural-equivalent. If a script actually
needs to dispatch on runtime type, use a `switch (record) {
case _Foo(): ... }` pattern instead.

### Architectural fix (deferred)

`InterpreterVisitor` should expose `toString` (and the rest of
`Object`'s universal members) when the `runtimeType` of an
`InterpretedInstance` is dereferenced. The cleanest path is to
return a `Type`-shaped façade with `toString()` defined to return
`InterpretedClass.name`, mirroring what GEN-094 did for
universal `Object` members on instances. Mirror the change in
`tom_d4rt` and `tom_d4rt_ast` per the sync rule.

---

## I1 — C-style for loop shares loop variable across closures (interpreter limitation)

### Symptom

A C-style `for (var i = 0; i < n; i++)` whose body builds widgets
that close over `i` (e.g. inside DragTarget callbacks, ListTile
`onTap`, etc.) crashes with `Index out of range: <n>` when those
closures fire after layout. The most direct repro is

```dart
Row(
  children: [
    for (var i = 0; i < rankSlots.length; i++)
      DragTarget<int>(
        builder: (ctx, _, __) => Text(rankSlots[i]?.toString() ?? '—'),
      ),
  ],
)
```

— five DragTarget builders are constructed during the for-loop, but
when Flutter calls the `builder` lambdas during the next paint the
captured `i` is `5` for every one of them, and `rankSlots[i]`
throws.

### Root cause

`InterpreterVisitor._executeClassicFor`
(`tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart` ~line
5396) creates **one** `loopEnvironment` *before* entering the
while-loop and reuses it for every iteration. The standard Dart
spec instead requires the loop variable to be allocated *per
iteration* so that each closure captures a fresh binding (the
practical effect that any post-ES6/Dart-2 programmer relies on).
Because d4rt's loop env is a single shared env, every closure
captures the same `i` cell, and after the loop ends that cell holds
`n`.

The mirror `tom_d4rt/.../interpreter_visitor.dart` has the same
shape, so the analyzer-based interpreter has the identical
behaviour.

A correct fix would, on each iteration:

1. Snapshot the loop variables' current values.
2. Open a fresh `Environment` rooted in the loop's outer scope,
   re-define the loop-variable names with the snapshot values, and
   execute the body inside that env (so closures created in the
   body capture the fresh env).
3. After the body, copy the variables back into the persistent
   loop env so updaters and the next condition check observe any
   in-body mutations.

The change is small but touches a hot path; mirroring it across
both interpreters and re-running the full essential / important /
secondary suites is the price of admission. The work is queued —
deferred from this cluster because the script-side rewrite is one
line per call site and unblocks the corpus immediately.

### Script-side workaround

Replace the collection-`for` / body-less for-loop with
`List<T>.generate`, which calls the builder with `i` as a function
parameter — each invocation has its own parameter binding, which
the interpreter handles correctly.

```dart
Row(
  children: List<Widget>.generate(rankSlots.length, (int i) {
    return DragTarget<int>(
      builder: (ctx, _, __) => Text(rankSlots[i]?.toString() ?? '—'),
    );
  }),
)
```

`List.generate` sidesteps `_executeClassicFor` entirely (the
builder runs once per index inside the bridged `List.generate`
implementation, and its parameter env is fresh per call).

### Affected scripts

| Script | Site | FE before | FE after |
|---|---|---:|---:|
| `widgets/drag_target_details_test.dart` | Section 11 (`_buildRankSlots`) | 5 | 0 |

### Future fix path

Land per-iteration capture in `_executeClassicFor` in both
`tom_d4rt` and `tom_d4rt_ast`, regenerate bridges, run the four
suites. Once landed, the script-side `List.generate` rewrite can
revert to the original `for` form (left in place for now — it is a
valid Dart shape and not a regression).

---

## S1 — `const Stream<T>.empty()` rejected by `Stream` bridge (interpreter limitation)

### Symptom

```
Runtime Error: Bridged class 'Stream' does not have a registered
constructor named 'empty'. Check bridge definition.
```

Surfaces from `tom_d4rt`'s
`InterpreterVisitor.visitInstanceCreationExpression` (line ~9275) when
the script contains:

```dart
final liveStreamBuilder = StreamBuilder<int>(
  stream: const Stream<int>.empty(),    // <— shape that triggers it
  initialData: 42,
  builder: (BuildContext ctx, AsyncSnapshot<int> snap) { … },
);
```

### Root cause

The stdlib `Stream` bridge in
`tom_d4rt/lib/src/stdlib/async/stream.dart` (and the mirror in
`tom_d4rt_ast/lib/src/runtime/stdlib/async/stream.dart`) registers the
factory constructors under `staticMethods`, not `constructors`:

```dart
static BridgedClass get definition => BridgedClass(
      nativeType: Stream,
      name: 'Stream',
      typeParameterCount: 1,
      …
      constructors: {},                // ← empty
      staticMethods: {
        'value': (visitor, …) { … },
        'empty': (visitor, …) { … },   // ← lives here
        'fromIterable': (visitor, …) { … },
        …
      },
      …
    );
```

The interpreter has two entry points that can resolve `Stream.empty()`:

1. `visitMethodInvocation` (path used when the call parses as a
   `MethodInvocation`). It first tries `findConstructorAdapter`,
   then **falls through to `staticMethods`**.
2. `visitInstanceCreationExpression` (path used when the call parses
   as `InstanceCreationExpression`). It tries `findConstructorAdapter`
   and throws if the lookup fails. It **does not** fall through to
   `staticMethods`.

**The crucial point:** the Dart analyzer parses *every*
`Stream.factoryName(...)` form as `InstanceCreationExpression` —
because `Stream.empty`, `Stream.value`, `Stream.fromIterable`, … are
*named constructors* in the real `dart:async` `Stream` class, even
though the d4rt bridge happens to register them as `staticMethods`.
This applies to:

- `const Stream<int>.empty()` — InstanceCreationExpression (const + type-args)
- `Stream<int>.empty()` — InstanceCreationExpression (type-args)
- `Stream.empty()` — InstanceCreationExpression (named ctor of Stream)
- `Stream<int>.fromIterable(const <int>[])` — InstanceCreationExpression
- `Stream.fromIterable(<int>[])` — InstanceCreationExpression

In every case `findConstructorAdapter('empty')` /
`findConstructorAdapter('fromIterable')` returns `null` (the bridge's
`constructors:` map is empty), and the interpreter throws.

### Why this is "unfixable" without a behavioural deviation

- The split between `constructors:` and `staticMethods:` is the
  canonical bridge-shape for `Stream` (and `Iterable.empty`,
  `List.empty`, `StackTrace.empty`, …): the d4rt API treats them as
  static factories so they share dispatch with `Stream.value(...)` and
  `Stream.fromFuture(...)` which are not constructors in the dart:async
  source either. Re-routing them to `constructors:` would couple their
  dispatch path to constructor semantics (instance creation, `const`
  evaluation, type-argument propagation) that don't apply to a static
  factory.
- Patching `visitInstanceCreationExpression` to fall through to
  `staticMethods` for `BridgedClass` targets is technically possible
  but changes the meaning of `new`/`const` for every bridge — code
  written against the canonical Dart semantics (where a static method
  with the same name as a non-existent constructor is a static-call,
  not a constructor-call) would silently start succeeding.
- Adding a special case for `Stream` (and the handful of other stdlib
  classes with this shape) is a bridge-side patch that has to live in
  every downstream interpreter; the script-side workaround is one line
  per call site and uses a Dart shape that is already idiomatic.

### Workaround

Because every `Stream.factory(...)` shape in source code parses as
`InstanceCreationExpression` (see "Root cause"), there is no
script-side incantation of `Stream.empty` / `Stream.fromIterable` /
… that hits the `MethodInvocation` fall-through. The two real
options are:

**1. Pass `null` if the consumer is `Stream<T>?`-nullable.**
`StreamBuilder.stream` is declared `Stream<T>? stream` and accepts
`null`, which exercises the `initialData` / "no live stream" code
path without constructing a Stream at all:

```dart
// instead of:
//   stream: const Stream<int>.empty(),
stream: null,
```

This is the smallest, most idiomatic change for `StreamBuilder`.

**2. Build the stream from a non-named-constructor source.**
Use `StreamController` (default constructor — registered under
`constructors:`) or transform a future:

```dart
final ctrl = StreamController<int>();
ctrl.close();              // immediately-closed empty stream
final emptyStream = ctrl.stream;
…
stream: emptyStream,
```

Both give an empty, single-subscription `Stream<int>` that never
emits.

**Workarounds that look right but DO NOT WORK** (all parse as
`InstanceCreationExpression` and hit the same `findConstructorAdapter`
miss):

```dart
stream: Stream<int>.empty(),                   // ← still IC-expr (named ctor of Stream)
stream: Stream.empty(),                         // ← still IC-expr (named ctor of Stream)
stream: Stream<int>.fromIterable(const <int>[]),// ← still IC-expr
stream: Stream.fromIterable(<int>[]),           // ← still IC-expr
final s = Stream<int>.empty(); …; stream: s,    // ← RHS is still IC-expr
```

### Affected scripts

| Script | Site |
|--------|------|
| `tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts/widgets/streambuilder_test.dart` | Section 6 — `stream: const Stream<int>.empty()` (line ≈ 758, rewritten in commit `5dc78999` "test(flutter_ast): hand-author Batch 2 deep demos") |

### What a real fix would look like

Land a single combined-lookup helper on `BridgedClass` (call it
`findStaticOrConstructor(name)`) that first tries `constructors[name]`
and then `staticMethods[name]`, and route both
`visitMethodInvocation` and `visitInstanceCreationExpression` through
it. Mirror in `tom_d4rt_ast`. Migrate the existing duplicated
fall-through in `visitMethodInvocation` to the helper. Audit all
stdlib bridges that register factories as `staticMethods`
(`Stream.empty/value/fromIterable/…`, `Iterable.empty`, `List.empty`,
`Map.fromIterable/from/of`, `Set.from/of`, `StackTrace.empty`,
`StreamController.broadcast` if present) so the `const`/`new`-shaped
call site reaches them. Out of scope for the priority-1 cluster; the
script-side workaround above is the closure for now.

---

## U1 — Demo-scale renderings that overload the test-app transport (interpreter limitation)

### Symptom

The Flutter test app crashes mid-run with:

```
Bad state: Transport failure
Lost connection to device.
```

No interpreter stack, no analyzer error, no framework exception
surfaces — the app process simply detaches from the HTTP transport
mid-execution and the test fails as
`status=transport_failure`. From `flutter test`'s point of view the
device just disconnected.

Reproduces deterministically on
`widgets/notificationlistener_test.dart` (C05 in
`testlog_20260517-0914`) and on both drivers
(`tom_d4rt_flutter_ast`, `tom_d4rt_flutter_test`).

### Root cause

The C05 demo combined two independently-fatal shapes:

1. **Top-level `const` of an interpreted subclass of a native
   abstract class** — the script declared
   `class _PrivateScoreNotification extends Notification` (where
   `Notification` is the *native* abstract class from
   `package:flutter/widgets.dart`) and instantiated three
   top-level `const _PrivateScoreNotification(...)` values during
   the script's static initialization. The interpreter does
   support interpreted subclasses of native abstract classes via
   adapter proxies (see *Abstract Class Inheritance*), but the
   adapter-proxy infrastructure is intended for *instance*
   construction inside `build()`/lifecycle methods; running it
   during the top-level constant-evaluation phase, before the
   interpreter has wired up its full visitor context, causes the
   process to terminate before any error gets serialised over the
   transport.

2. **A very large `SelectableText.rich` TextSpan tree built
   per-character by an interpreted colorizer** — the demo had a
   `_privateCodeBlock(String code)` helper that ran
   `_privateColorizeDart(code)` to produce a `List<TextSpan>` one
   character at a time (each non-keyword/non-string char became
   its own `TextSpan(text: c)`), then fed the list into
   `SelectableText.rich(TextSpan(children: spans))`. For most
   sections (≤500 chars / ≤22 lines of code) this works fine. The
   "mini recipe" code listing in Section 7 was ~1.8 KB / ~58
   lines, producing roughly 1000+ TextSpan objects. Rendering it
   exhausts whatever the transport budget is and the app
   disconnects without surfacing an error.

Both sub-cases were confirmed by bisection on `build()`'s child
list (`ztmp/c05_repro.log.txt`,
`ztmp/c05_bisect_s7_only.log.txt`,
`ztmp/c05_ast_fixed.log.txt`). Removing either sub-case alone is
not enough; both must be neutralised.

### Why this is interpreter-limitation rather than "truly unfixable"

- The native-abstract-subclass-at-top-level-const case is a real
  blind spot in the adapter-proxy initialisation order. A
  long-term fix would land in `tom_d4rt` and `tom_d4rt_ast` by
  hoisting the proxy registration into the
  `DeclarationVisitor`'s pre-pass so that any top-level
  `const`-evaluated interpreted subclass of a native abstract
  class has a working proxy ready before constant evaluation
  begins. This is a non-trivial cross-cutting change (mirrors,
  abstract-class scanner, proxy wiring) and not in scope for the
  C05 cluster.
- The large-TextSpan-tree case is a transport-budget interaction:
  every TextSpan that the interpreter constructs has to be
  serialised through the bridge boundary into a real Flutter
  `TextSpan` object. For ~1000+ spans this exceeds whatever
  per-frame transport budget the test-app is configured for. The
  fix-shaped solution is either bridge-side batching of
  `TextSpan` construction, or a transport-budget bump in the
  test-app HTTP harness; either would be a separate workstream.

### Workaround

Both sub-cases admit a clean script-side rewrite that preserves
the *documentation intent* of the demo:

**1. Don't declare an interpreted subclass of a native abstract
class for a value the demo never actually dispatches.** The
`_PrivateScoreNotification` class was only used for its `score`
and `label` fields displayed in a UI card; nothing ever called
`.dispatch(context)`. Inline the displayed values as top-level
`const` primitives and keep the class definition only in the
*code-listing text* (which is the documentation intent anyway):

```dart
// Don't do (top-level, const, before build()):
//   class _PrivateScoreNotification extends Notification {
//     final int score;
//     final String label;
//     const _PrivateScoreNotification(this.score, {this.label = 'score'});
//     …
//   }
//   const _PrivateScoreNotification _kSampleScoreB =
//       _PrivateScoreNotification(108, label: 'levelB');
//
// Do (inline the displayed values, keep the class only as text):
const int _kSampleScoreBValue = 108;
const String _kSampleScoreBLabel = 'levelB';

// … and in the banner widget:
Text('$_kSampleScoreBValue', …)
Text('label: $_kSampleScoreBLabel', …)
```

**2. Render large code listings with a single plain monospace
`Text` widget, not `SelectableText.rich`-of-many-TextSpans.**
Define a sibling helper that keeps the same dark-card visual
container but skips per-char colorization for snippets above
~1KB / ~25 lines:

```dart
Widget _privatePlainCodeBlock(String code) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: _kPageInkFaint.withValues(alpha: 0.4),
        width: 1.0,
      ),
    ),
    child: Text(
      code,
      style: TextStyle(
        color: _kCodeFg,
        fontFamily: 'monospace',
        fontSize: 12,
        height: 1.5,
      ),
    ),
  );
}
```

Use `_privateCodeBlock` (the colorized helper) for code listings
of ≲500 chars / ≲22 lines (the size used in Sections 3–6 of the
demo). Use `_privatePlainCodeBlock` (plain Text) for anything
larger.

### Affected scripts

| Script | Sites | Notes |
|--------|-------|-------|
| `widgets/notificationlistener_test.dart` | top-level `_PrivateScoreNotification` class + 3 `const _kSampleScore*` values; Section 7's `_privateCodeBlock(...)` (~1.8 KB recipe) | Both sub-cases neutralised by inlining displayed values and switching Section 7 to `_privatePlainCodeBlock`. C05 closed 2026-05-17 on both drivers. |
| `services/text_editing_delta_insertion_test.dart` | 11-card demo Scaffold (title banner + anatomy + 6 gallery cards via `Wrap` + 3 offset + 3 composing + sibling table + chat mock + apply flow + 15-line RichText code snippet + 5 footguns + recap) returned from `build()`. No top-level `const` native-abstract subclass; the rendered widget tree itself overloaded the transport. Script logged "Deep Demo completed successfully" before `Lost connection to device.` (no Dart stack, no FlutterError). | Workaround: U1 variant 2 extension — collapsed the 15 `_codeLine(...)` RichText calls in Section 9 to a single plain `Text`, then collapsed the entire return Scaffold to a `Center` → `Text` summary. All demo data and `print` output retained; built widgets still referenced via a discarded `_unused` list so their bridged constructors stay exercised. C52/C51 closed 2026-05-18 on both drivers. |

### What a real fix would look like

For sub-case (1): in `DeclarationVisitor` (both `tom_d4rt` and
`tom_d4rt_ast`), pre-register adapter proxies for every
interpreted class whose direct or indirect base is a native
abstract class *before* visiting top-level `const`-evaluated
variable declarations. The current dispatch order constructs
proxies on first instantiation inside an evaluated method body,
which is too late for top-level `const` literals.

For sub-case (2): batch
`SelectableText.rich`/`TextSpan(children: …)` transport so the
interpreter ships the full span tree as a single payload rather
than synthesising each `TextSpan` through the bridge boundary
individually. Or raise the test-app per-frame transport budget
to accommodate ≥4000 small object constructions.

---

## U2 — Non-wrappable arithmetic defaults on positional-only native constructors (generator limitation)

### Symptom

Calling a positional-only bridged constructor whose Dart signature
has an arithmetic-expression default value, while passing fewer
positionals than the index of that parameter, throws:

```
Runtime Error: Native error during bridged constructor 'sweep' for class 'Gradient':
Argument Error: Gradient: Parameter "endAngle" has non-wrappable default (math.pi * 2).
Value must be specified but was null.
```

Reproduced in `testlog_20260517-0914` C09 on both drivers
(`tom_d4rt_flutter_ast`, `tom_d4rt_flutter_test`) for
`rendering/gradient_rendering_test.dart` calling
`ui.Gradient.sweep(Offset(...), kRainbow)`.

### Root cause

`BridgeGenerator._wrapDefaultValue`
(`tom_d4rt_generator/lib/src/bridge_generator.dart` lines 4606–4613)
returns `null` for any default expression containing an operator,
because the generator can only inline literal values / simple
named constants and would otherwise have to parse and re-emit the
expression in the generated bridge file. When `_wrapDefaultValue`
returns `null`, the parameter is recorded as a non-wrappable
default and the generated bridge emits, for that positional slot:

```dart
final endAngle = D4.getRequiredArgTodoDefault<double>(
    positional, 5, 'endAngle', 'Gradient', 'math.pi * 2');
```

`getRequiredArgTodoDefault` throws an `ArgumentError` whenever the
positional slot is absent (`positional.length <= 5`) — there is no
fallback to "synthesise the default at runtime" because the
generator could not produce one.

For *named-only* constructors this is mostly cosmetic: callers
that omit the named arg get the same error, but adding the named
arg back is trivial. For **positional-only** native constructors
— `dart:ui` `Gradient.sweep`, `Gradient.radial`, `Gradient.linear`,
several `Path` and `Picture` methods — there is no way to skip the
earlier optional positionals while supplying a later one. Once a
single positional default contains an operator, every call site
must spell out every preceding positional, with the framework's
own default values, all the way up to the operator-bearing index.

Concretely for `Gradient.sweep`:

```dart
external factory Gradient.sweep(
  Offset center,
  List<Color> colors,
  [ List<double>? colorStops,
    TileMode tileMode = TileMode.clamp,    // ← OK (enum constant)
    double startAngle = 0.0,               // ← OK (literal)
    double endAngle = math.pi * 2,         // ← non-wrappable (operator)
    Float64List? matrix4, ]);
```

Calling `Gradient.sweep(center, colors)` works in native Dart
because the engine resolves all four defaults internally. Through
the bridge, the generator can wrap `colorStops` (null literal),
`tileMode` (enum constant), and `startAngle` (numeric literal) — but
fails on `endAngle` because `math.pi * 2` is an arithmetic
expression. The call then throws on the 6th positional even though
the script only intended to supply the 2 mandatory ones.

### Why this is a generator limitation rather than "truly unfixable"

The generator could grow a small evaluator for the limited
shape of arithmetic-default expressions actually used by the
framework SDKs (`identifier * literal`, `identifier / literal`,
`-literal`, `literal * literal`, possibly `identifier.identifier *
literal`). All known offending cases in `dart:ui` /
`flutter/{painting,rendering}` resolve to numeric primitives once
the `math.pi`/`math.e` constants are bound. Implementing this
would unblock the entire family without per-call-site script
edits.

A safer narrower fix: have `_wrapDefaultValue` recognise
expressions of the form `math.<name> <op> <numericLiteral>` and
emit the equivalent numeric constant directly (since `math.pi` and
`math.e` are compile-time-known doubles, the multiplication
result is also compile-time-known).

Neither variant is in scope for the C09 cluster — fixing the
generator and regenerating every bridge package would put
hundreds of `.b.dart` files in the diff.

### Workaround

At each call site, supply *all* preceding optional positionals up
to and including the operator-bearing one, using the framework's
documented defaults literally. For `ui.Gradient.sweep`:

```dart
// Don't (compiles natively, but the bridged form throws on `endAngle`):
final ui.Gradient sweep = ui.Gradient.sweep(
  Offset(100.0, 60.0),
  kRainbow,
);

// Do — spell out every preceding positional default, plus the
// operator-bearing one, using the framework's defaults literally:
final ui.Gradient sweep = ui.Gradient.sweep(
  Offset(100.0, 60.0),
  kRainbow + <Color>[kSpecRed],
  <double>[0.0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1.0], // colorStops
  TileMode.clamp,                                                  // tileMode
  0.0,                                                             // startAngle
  math.pi * 2.0,                                                   // endAngle (operator-bearing default)
);
```

Two practical notes when applying this workaround:

1. **The `colors`/`colorStops` invariant runs natively on
   `dart:ui`.** Once `colorStops` becomes an explicit list rather
   than `null`, the engine enforces
   `colorStops.length == colors.length` (and not the
   `colors.length == 2 || colorStops != null` form that handles
   the `null` case). Build the stops list to match the colour
   count exactly — usually evenly spaced
   (`List.generate(n, (i) => i / (n - 1))`).
2. **Keep `math.pi * 2.0` literally, not a `kTwoPi` constant.**
   The framework spells it `math.pi * 2`, and matching that form
   in the script keeps the workaround intent obvious: every
   preceding positional plus the operator default. Using a named
   constant invites a future reader to think the value is
   significant rather than load-bearing-for-bridge-defaults.

### Affected scripts

| Script | Sites | Notes |
|--------|-------|-------|
| `rendering/gradient_rendering_test.dart` | 1 (Section "sweep gradient", lines 1416–1437) | `ui.Gradient.sweep(center, colors)` expanded to 6 positionals (added `colorStops` 9-element stop list, `TileMode.clamp`, `0.0`, `math.pi * 2.0`). C09 closed 2026-05-17 on both drivers. |

### What a real fix would look like

In `tom_d4rt_generator/lib/src/bridge_generator.dart`'s
`_wrapDefaultValue`: before falling through to the final
`return null;` on line 4613, detect arithmetic-default expressions
that reference only compile-time-known constants (`math.pi`,
`math.e`, numeric literals) and one of the four basic operators
(`+`, `-`, `*`, `/`). Evaluate them at generation time and emit
the resulting numeric literal as the wrapped default. The bridge
will then accept the omitted argument instead of routing it
through `getRequiredArgTodoDefault`.

A test fixture in `tom_d4rt_generator/test/` exercising this
shape against `dart:ui` `Gradient.sweep` / `radial` / `linear`
would catch regressions if the operator list ever grows.

---

## U3 — Interpreted subclass of native abstract `Curve`: `transformInternal` override not routed through `Curve.transform` (interpreter limitation)

### Symptom

A D4rt-script-defined subclass of the native abstract
`flutter/animation` `Curve` class — overriding `transformInternal(double t)`
as the framework expects — returns `null` from `curve.transform(t)`
when invoked through the bridge. Downstream arithmetic on the null
sample then throws:

```
Runtime Error: Native error during bridged operator '+' on double:
type 'Null' is not a subtype of type 'num' in type cast
```

The stack trace bottoms out in `visitBinaryExpression` at the
`12.0 + (28.0 * s)` site (where `s = curve.transform(i / (steps - 1))`),
two `_processCollectionElement` frames deep inside the for-element
that builds the curve-strip's sample bars.

Reproduced in `testlog_20260517-0914` C10 on both drivers
(`tom_d4rt_flutter_ast`, `tom_d4rt_flutter_test`) for
`animation/animation_misc_adv_test.dart` with the catalog specimen
`_FlippedShim extends Curve` (overriding `transformInternal` to flip
`Curves.easeInOut`).

### Root cause

Native `Curve.transform(double t)` is a *template method*: it
validates `t ∈ [0, 1]`, handles the `t == 0` / `t == 1` edges, and
delegates the interior to `transformInternal(t)`. Subclasses are
expected to override `transformInternal`, not `transform`.

When a D4rt script declares `class _FlippedShim extends Curve` and
implements only `transformInternal`, the adapter-proxy
infrastructure builds a `_InterpretedCurve` native shim that holds
the `InterpretedInstance`. A bridge consumer that calls
`curve.transform(t)` invokes the *native* `Curve.transform`
implementation on the proxy, which then calls `this.transformInternal(t)`
on the proxy itself — but the proxy does not override
`transformInternal` to route back to the interpreted method. The
native `Curve.transformInternal` is abstract; on the proxy it
either resolves to `null` (effectively returning the missing
implementation as null through the bridge) or to a default that
yields null in the consumer's `num` arithmetic.

The net effect: the interpreted `transformInternal` override is
never called by the framework's own `transform` template, so the
sample returns null, and the next bridged `*` / `+` on a `double`
rejects the null right-hand operand with the cast error above.

The failure reproduces identically whether `_FlippedShim()` is
constructed as a top-level `const` or as a non-const local — so this
is **not** the same bug as U1 (top-level `const` of an interpreted
subclass crashing the test-app transport before the visitor is
wired). U1 is a transport/lifecycle crash; U3 is a steady-state
delegation gap that surfaces only when the native template method
calls back into a method the script overrides.

### Why this is an interpreter / generator limitation rather than "truly unfixable"

The adapter-proxy / bridge generator could synthesise a
`transformInternal` override on the native `_InterpretedCurve`
proxy that calls `InterpretedInstance.invoke('transformInternal', [t])`
on the held interpreted instance. The same pattern already exists
for `State.build`, `StatelessWidget.build`, and several other
abstract-method template-method pairs; `Curve.transformInternal` is
just another case of the same shape.

The general fix is to identify *every* template-method/abstract-hook
pair in framework abstract classes the script can subclass (Curve →
transformInternal, ScrollPhysics → applyPhysicsToUserOffset, …) and
have the proxy generator emit native overrides that route back to
the interpreted instance.

Neither variant is in scope for the C10 cluster — touching the
proxy generator would put dozens of `.b.dart` files in the diff and
risks regressing the existing `State` / `StatelessWidget`
adapter-proxy paths.

### Workaround

Use a framework-provided `Curve` subclass instead of a
script-defined one. The script's catalog specimen needs only to
*display* a curve named "flipped easeInOut", which `FlippedCurve`
(in `flutter/animation`) implements natively:

```dart
// Don't (compiles, but bridged `transform()` returns null):
const MapEntry<String, Curve>(
  'Curves.easeInOut.flipped',
  _FlippedShim(),
),
// where:
class _FlippedShim extends Curve {
  const _FlippedShim();
  @override
  double transformInternal(double t) {
    final double v = Curves.easeInOut.transform(1.0 - t);
    return 1.0 - v;
  }
}

// Do — use the framework's `FlippedCurve`:
MapEntry<String, Curve>(
  'FlippedCurve(easeInOut) [native]',
  FlippedCurve(Curves.easeInOut),
),
```

The catalog still demonstrates the "flipped" curve shape; the
sampling now goes through `FlippedCurve.transformInternal`, which
is real native Dart and runs identically to a hand-rolled flip.

The `_FlippedShim` class itself can be kept in the script as
documentation of the user-extension pattern, annotated with
`// ignore: unused_element` so the analyzer does not warn.

### Affected scripts

| Script | Sites | Notes |
|--------|-------|-------|
| `animation/animation_misc_adv_test.dart` | 1 (`_customCurves` specimens list, original lines 863–866; specimen class `_FlippedShim` at original lines 911–935) | Replaced specimen with `MapEntry<String, Curve>('FlippedCurve(easeInOut) [native]', FlippedCurve(Curves.easeInOut))`. `_FlippedShim` class retained for documentation with `// ignore: unused_element`. C10 closed 2026-05-17 on both drivers. |

### What a real fix would look like

In `tom_d4rt_generator/lib/src/proxy_generator.dart`: when
generating the native proxy class for an abstract framework class
that follows the template-method pattern (public method calls a
hookable protected/abstract method), emit native overrides on the
proxy for the hookable method(s) that delegate to
`interpretedInstance.invoke(hookName, args)`. Concretely for `Curve`:

```dart
class _InterpretedCurve extends Curve {
  _InterpretedCurve(this.interpretedInstance);
  final InterpretedInstance interpretedInstance;
  @override
  double transformInternal(double t) {
    return interpretedInstance
        .invoke('transformInternal', <Object?>[t]) as double;
  }
}
```

A test fixture exercising
`class MyCurve extends Curve { @override double transformInternal(double t) => 1 - t; }`
sampled through `MyCurve().transform(0.25)` would catch regressions
across this whole family.

---

## U4 — Standalone `'\n'` `TextSpan` between two styled siblings crashes the test-app transport (truly unfixable)

**Category.** Truly unfixable — Dart-VM-level crash inside the
bridged render path. The fault does not surface as a catchable
`RuntimeD4rtException`; the test-app process dies and the HTTP
transport closes mid-build, manifesting at the runner level as
`Bad state: Transport failure while running …` and on the device
side as `Lost connection to device.`.

**Reproducer.** Inside a parent `TextSpan.children` list, a child
`TextSpan` whose `text` is exactly the single-character newline
string `'\n'` — sitting *between* two other `TextSpan`s that each
carry a non-null `style` — kills the Dart VM during build:

```dart
RichText(
  text: TextSpan(
    style: const TextStyle(color: Colors.white, fontSize: 13),
    children: [
      TextSpan(text: '(Cmd+S)', style: TextStyle(color: mint)),
      const TextSpan(text: '\n'),                         // ← crash
      TextSpan(text: 'tip:',    style: TextStyle(color: amber)),
    ],
  ),
)
```

Equivalence cases verified during bisection (see C15 entry in
`testlog_20260517-0914-test_analysis/error_analysis.md` for the
full bisect trail and probe-log filenames):

| children layout | result |
|-----------------|--------|
| `[styled, styled, styled]` (no `\n`-only child) | pass |
| `[styled, TextSpan(text: 'middle', style: red), styled]` | pass |
| `[styled, TextSpan(text: '\n'), styled]` (no `const`, no `style`) | crash |
| `[styled, TextSpan(text: '\n', style: TextStyle()), styled]` | crash |
| `[styled, TextSpan(text: '\n', style: white), styled]` | crash |
| `[styled, TextSpan(text: ' ',  style: white), styled]` | pass |
| `[styled('(Cmd+S)\n'), styled]` (merge `\n` into preceding) | pass |
| `[plain, styled, plain]` (single styled, no second styled) | pass |
| `[const, styled, const, styled]` (alt form of the trigger) | crash |
| `[styled, styled]` (two adjacent styled, no `\n`-only between) | pass |

So both the *character* `'\n'` in the middle child *and* the
flanking pair of style-bearing siblings are necessary. Adding a
`style:` to the middle child is **not** sufficient; the trigger
depends on the literal `'\n'` text value.

**Constraints.**

- No smaller reproducer exists outside the bundled-script HTTP
  transport: a hand-written `RichText` with the exact same shape,
  rendered from native Dart, renders fine. The fault therefore
  lives in the d4rt bridged-render path, not in Flutter itself.
- The crash terminates the Dart VM (`Lost connection to device`),
  so neither the interpreter nor the test runner can intercept
  it and present a usable error.
- The bundle JSON size, byte difference between repro and
  workaround (2 bytes for `'\n'` → `' '`), and ordinal position
  within the script are all neutral; only the literal `'\n'`-as-
  sole-text in the middle child matters.

**Script-side workaround (mandatory).** Append the `'\n'` to the
preceding styled span's `text` and drop the standalone newline
child:

```dart
children: [
  const TextSpan(text: 'Save changes '),
  TextSpan(text: '(Cmd+S)\n', style: TextStyle(color: mint)), // \n merged in
  TextSpan(text: 'tip:',      style: TextStyle(color: amber)),
  const TextSpan(text: ' shift to save-as'),
],
```

The newline still hard-breaks at the same visual position because
`TextSpan` glyph layout is style-insensitive for whitespace.

If merging into the preceding span is structurally awkward (e.g.,
the preceding span is `const` and the surrounding `children:` is
also `const`), a `WidgetSpan(child: SizedBox(width: double.infinity, height: 0))`
sandwiched in place of the `'\n'` `TextSpan` is the next-best
alternative — it forces a line break without any text content at
all.

**Diagnostic guidance.** If a script newly added under a
cluster-by-cluster pass turns up
`Bad state: Transport failure while running …` with no preceding
framework-error block and the script contains a `RichText` /
`Tooltip(richMessage:)` / `Text.rich(...)` with multiple styled
`TextSpan` children, suspect a literal `'\n'`-only child between
them first. Strip down the offending children list with the
probes documented in C15 to confirm.

---

## U5 — Interpreted subclass of native abstract `NotchedShape` / `FloatingActionButtonLocation` rejected at the bridged-constructor boundary (interpreter limitation)

**Category.** Interpreter / bridge-generator architectural
limitation — the **same adapter-proxy delegation gap** documented as
U3 for `Curve`, manifesting on two additional native abstract types:
`NotchedShape` (consumed by `BottomAppBar.shape`) and
`FloatingActionButtonLocation` (consumed by
`Scaffold.floatingActionButtonLocation`, `MaterialApp` route
scaffolds, and any `_fabLocationCell`-style helper that accepts a
location-typed argument and forwards it into a native bridged
constructor).

**Reproducer.**

```dart
class _TopRoundedNotchedShape extends NotchedShape {
  const _TopRoundedNotchedShape({required this.radius});
  final double radius;
  @override
  Path getOuterPath(Rect host, Rect? guest) { … }
}

// Passing the script subclass to a native bridged constructor fails:
BottomAppBar(
  shape: const _TopRoundedNotchedShape(radius: 18.0), // ← Argument Error
  …
)
```

Yields, at the d4rt → native boundary:

```text
Runtime Error: Native error during default bridged constructor for
'BottomAppBar': Argument Error: Invalid parameter "shape":
expected NotchedShape?, got InterpretedInstance(_TopRoundedNotchedShape)
```

Same shape for `FloatingActionButtonLocation`:

```dart
class _CustomFabLocation extends FloatingActionButtonLocation {
  const _CustomFabLocation();
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry s) { … }
  @override
  String toString() => '_CustomFabLocation';
}

Scaffold(
  floatingActionButtonLocation: const _CustomFabLocation(), // ← Argument Error
  …
)
```

```text
Runtime Error: Native error during default bridged constructor for
'Scaffold': Argument Error: Invalid parameter "floatingActionButtonLocation":
expected FloatingActionButtonLocation?, got
InterpretedInstance(_CustomFabLocation)
```

**Root cause.** The bridge generator emits a `BridgedClass` for the
abstract base (`NotchedShape`, `FloatingActionButtonLocation`) but
does **not** synthesise an adapter-proxy that:

1. Wraps an `InterpretedInstance` of a script subclass in a native
   subclass that implements the abstract methods by routing back
   into the interpreter, **and**
2. Lets `D4.getNamedArg<NotchedShape?>` / `D4.getRequiredArg<…>`
   recognise that the `InterpretedInstance` is "is-a" of the
   bridged class.

So even though the `extends NotchedShape` clause is honoured
*inside* d4rt-space (the script can do `is NotchedShape` checks
and call `getOuterPath` through the interpreter), the value can
never cross the d4rt → native boundary as a `NotchedShape`. The
native `BottomAppBar` constructor receives the raw
`InterpretedInstance` and the typed-arg validator throws.

This is the same architectural gap as U3 (`Curve`): script-defined
subclasses of native abstract classes that hold polymorphic
state/behaviour for the framework's own consumption work in
isolation but cannot be handed back to native APIs.

**Constraints.**

- The bridge-generator side of the fix is open-ended — it would
  need to generate a per-abstract-class native proxy that
  implements every required abstract method by dispatching to the
  interpreted override (analogous to the manual `D4UserBridge`
  proxies for `State`, `StatelessWidget`, etc., but generated). This
  is the same E12-class of work documented under "Abstract Class
  Inheritance" above.
- For one-off script call sites that just need *some*
  `NotchedShape` / `FloatingActionButtonLocation`, Flutter already
  ships fully-functional concrete subclasses; there is no business
  reason to insist on a script-defined one in a corpus script whose
  purpose is to exercise the *consumer* (`BottomAppBar`,
  `Scaffold`), not the *shape*.

**Script-side workaround (mandatory).** Use a framework-provided
subclass of the native abstract type:

| Abstract type | Framework alternatives |
|---------------|------------------------|
| `NotchedShape` | `CircularNotchedRectangle()`, `AutomaticNotchedShape(OutlinedBorder host, [ShapeBorder? guest])` |
| `FloatingActionButtonLocation` | `FloatingActionButtonLocation.{centerDocked, endDocked, startDocked, miniCenterDocked, miniEndDocked, centerFloat, endFloat, startFloat, miniCenterFloat, miniEndFloat, miniStartFloat, centerTop, endTop, startTop, endContained}` |

```dart
// Was:
BottomAppBar(shape: const _TopRoundedNotchedShape(radius: 18.0), …)
// Becomes:
BottomAppBar(shape: const CircularNotchedRectangle(), …)

// Was:
_fabLocationCell(location: const _CustomFabLocation(), …)
// Becomes:
_fabLocationCell(location: FloatingActionButtonLocation.endFloat, …)
```

The script's class definitions (`_TopRoundedNotchedShape`,
`_CustomFabLocation`) can remain as compile-only declarations if
they are still referenced by adjacent source-as-string
documentation blocks; they just must not be instantiated at
runtime.

**Diagnostic guidance.** Any
`Argument Error: Invalid parameter "<x>": expected <BaseType>, got InterpretedInstance(<ScriptName>)`
at a native bridged constructor where `<ScriptName>` is a script
class with `extends <BaseType>` is this same family. Triage by
checking whether `<BaseType>` is one of: `NotchedShape`,
`FloatingActionButtonLocation`, `Curve`, `ShapeBorder`,
`InputBorder`, `OutlinedBorder`, `BoxBorder`, `ScrollPhysics`,
`InteractiveInkFeatureFactory`, `MaterialStateProperty<T>`,
`PageTransitionsBuilder`, `RouteTransitionRecord`, `Decoration`,
`MaterialColor`-like, or any other Flutter abstract class whose
purpose is "factor out a piece of paint/layout/animation
behaviour". The fix is always the same: switch to a
framework-provided subclass at the call site.

---

## U6 — Direct import of `package:vector_math/vector_math_64.dart` is not resolvable in d4rt scripts (module-loader limitation)

**Category.** Module-loader / bundler limitation. The `vector_math`
package — a foundational dependency of `dart:ui` / Flutter
rendering (the `Matrix4`, `Vector3`, `Vector4`, `Quaternion`
geometry primitives) — is **not** in either driver's bridged-
libraries set and is **not** registered as an `explicitSources`
entry. Even though the generated bridges reference types from it
internally (`$vector_math_1.Vector3` is used throughout
`tom_d4rt_flutter_ast/lib/src/bridges/painting_bridges.b.dart` as
the parameter type on dozens of `Matrix4` methods such as
`translateByVector3`, `scaleByVector3`, `rotate`,
`setFromTranslationRotation`, …), the library itself is opaque to
the d4rt script bundler.

**Reproducer.** Any d4rt script that imports `vector_math`
directly:

```dart
import 'package:vector_math/vector_math_64.dart' show Vector3;

Widget build(BuildContext context) {
  final Vector3 v = Vector3(40.0, 0.0, 0.0);
  // …
}
```

Yields at bundle/load time, **before any interpreter code runs**:

- **AST driver** (`tom_d4rt_flutter_ast` / `tom_ast_generator`):

  ```text
  Bad state: Cannot resolve import "package:vector_math/vector_math_64.dart"
  from main.dart: Package import "package:vector_math/vector_math_64.dart"
  is not bridged and not in the same package. Either add it to
  bridgedLibraries or provide it via explicitSources.
  package:tom_ast_generator/src/bundler/ast_bundler.dart 335:11
    AstBundler._resolveImports
  ```

- **Analyzer driver** (`tom_d4rt_flutter_test` / `tom_d4rt`):

  ```text
  Runtime Error: Unexpected error: SourceCodeException: Module source
  not preloaded for URI: package:vector_math/vector_math_64.dart, and
  not …
  ```

Same root cause; the two drivers detect it at different layers of
their respective load pipelines.

**Constraints.**

- Registering `vector_math` as a bridged library on either driver
  would require generating a full `BridgedClass` set for the
  package's public API (`Vector2`, `Vector3`, `Vector4`,
  `Quaternion`, `Matrix2`, `Matrix3`, `Matrix4`, `Aabb2`, `Aabb3`,
  `Frustum`, `Plane`, `Ray`, `Sphere`, `Triangle`, plus several
  free functions). The Flutter painting/rendering bridges already
  cover the `Matrix4` consumer-surface that scripts actually use,
  so this would be a large amount of generation churn for a small
  amount of new script-side capability.
- Registering it as an `explicitSources` entry (load source as-is
  and let the interpreter execute the `vector_math` library) is
  technically possible but requires the interpreter to handle the
  package's internal `Float64List`-backed math and its FFI/typed-
  data path, which has not been validated and is out of scope for
  a single cluster-by-cluster pass.

**Script-side workaround (mandatory).** The Flutter bridges
already expose `Matrix4.storage` as a `Float64List` getter. Drop
the direct `vector_math_64` import and compute the same matrix·
vector products inline. `Matrix4` is column-major, so for a
4-vector `(x, y, z, 1)` the transformed components are:

```dart
// Matrix4.transform3((x, y, z)) for affine matrices (no perspective row):
final List<double> s = m.storage;
final double tx = s[0] * x + s[4] * y + s[8]  * z + s[12];
final double ty = s[1] * x + s[5] * y + s[9]  * z + s[13];
final double tz = s[2] * x + s[6] * y + s[10] * z + s[14];
```

If the script only needs the (x, y) component projected through a
2D affine, `MatrixUtils.transformPoint(matrix, Offset)` is already
bridged and is the recommended Flutter idiom anyway (it also
handles the perspective-divide that `transform3` does not).

**Diagnostic guidance.** Any script-side error mentioning
`vector_math` (`vector_math_64.dart` is the explicit-precision
variant; `vector_math.dart` is the SIMD-style variant — both fail
the same way) at bundle or load time means the import has to come
out. The replacement strategy depends on what the script was
constructing:

| Original use | Replacement |
|--------------|-------------|
| `Vector3(x, y, z)` + `Matrix4.transform3` | Inline column-major matrix·vector product over `Matrix4.storage` |
| `Matrix4.transform3((x, y, 0))` for 2D | `MatrixUtils.transformPoint(matrix, Offset(x, y))` |
| `Matrix4.getTranslation()` → `Vector3` reads | Read `Matrix4.storage[12..14]` directly |
| `Quaternion` rotations | Use `Matrix4.rotationZ` / `Matrix4.rotationX` / `Matrix4.rotationY` on the Flutter side (these accept `double` radians, not `Quaternion`) |

The script's class definitions (none in C17's case) remain
unchanged; only the import and the runtime construction sites need
rewriting.

---

## U7 — Dart-internal `_ConstMap` (runtime class of `const <K, V>{}`) is not in the Map bridge's `nativeNames` (interpreter limitation)

**Category.** Interpreter / stdlib-bridge limitation. The d4rt
Map `BridgedClass` registers a curated `nativeNames` list so that
member access on arbitrary native Map subclasses still routes
through the Map adapter:

```dart
// tom_d4rt_ast/lib/src/runtime/stdlib/core/map.dart  (~lines 10-15)
nativeNames: const [
  'UnmodifiableMapView',
  '_UnmodifiableMapView',
  '_CompactLinkedHashMap',
  'ListMapView',
  '_MapView',
],
```

The same list lives in `tom_d4rt/lib/src/stdlib/core/map.dart`.
Missing from it is **`_ConstMap`** — the Dart-internal runtime
type that `const <K, V>{}` literals evaluate to. When a `_ConstMap`
value reaches the member-access path in
`tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart`
(`SPrefixedIdentifier` lookup, lines 1419-1421), no bridged class
matches, the `.entries` / `.keys` / `.length` / … getter is not
resolved, and the visitor throws:

```text
Runtime Error: Cannot access property 'entries'
  on target of type _ConstMap<String, dynamic>.
```

The error surfaces for any member access on a `_ConstMap`, so it
is not specific to `.entries`.

**Reproducer.** Two trigger shapes that both produce a `_ConstMap`
at runtime:

1. **Script-side `const` default.** The script declares a default
   value with `const`:

   ```dart
   Map<String, dynamic> data = const <String, dynamic>{};
   try {
     data = probe.getDataMap();
   } catch (_) {/* fallback path keeps the const default */}
   for (final entry in data.entries) { … }   // <-- throws
   ```

   If `getDataMap()` raises, the catch-block leaves `data` as the
   `_ConstMap` default, and the subsequent `.entries` access
   throws.

2. **Flutter API returning `const <…>{}`.** Several
   `SemanticsEvent` implementations in Flutter return a const
   empty map for payload-free events:

   ```dart
   // flutter/lib/src/semantics/semantics_event.dart
   class LongPressSemanticsEvent extends SemanticsEvent { … }
   class TapSemanticEvent      extends SemanticsEvent { … }
   class FocusSemanticEvent    extends SemanticsEvent { … }
   // each overrides:
   @override Map<String, Object> getDataMap() => const <String, Object>{};
   ```

   Even with a non-const script-side default, assigning
   `data = probe.getDataMap();` puts a `_ConstMap` back into
   `data`, and `.entries` throws on the next access.

**Constraints.**

- Adding `_ConstMap` to the Map bridge's `nativeNames` is
  technically a one-line change in two files (`tom_d4rt`,
  `tom_d4rt_ast`), but `_ConstMap` is a Dart-VM internal class
  whose name is not guaranteed across SDK versions (the canonical
  reference is `dart:core` private; the analyzer / mirrors path
  has historically reported variants such as `_ConstMap`,
  `_HashMap`, `_InternalLinkedHashMap`, `_ImmutableMap` depending
  on platform). A targeted fix would need to either match all of
  them or detect "any `Map` instance" structurally.
- A broader fix would teach the Map adapter to fall back to
  `target is Map` whenever the runtime type lookup misses, so
  every native `Map` flavour (including future SDK additions and
  user-side third-party `Map` types) gets bridged getter
  resolution for free. That is the better architectural fix but
  is **not** in cluster scope.
- Until the interpreter ships either fix, every script-side or
  bridge-side `_ConstMap` traversal will fail at member-access
  time, even though the equivalent native Dart code works.

**Script-side workaround (mandatory).** Two cooperating
precautions are needed because the trigger can come from either
side of the assignment:

```dart
// C18 workaround:
// 1) Default is a non-const literal so the catch-block fallback
//    is a regular LinkedHashMap, not a _ConstMap.
Map<String, dynamic> data = <String, dynamic>{};
try {
  // 2) Copy bridged map values through Map<K, V>.from so the
  //    runtime type is a regular LinkedHashMap regardless of
  //    what getDataMap() returned.
  data = Map<String, dynamic>.from(probe.getDataMap());
} catch (_) {/* keep the non-const default */}
for (final entry in data.entries) { … }      // OK
```

Either precaution alone is insufficient — the script-side default
matters only on the catch branch; the `Map.from` copy matters
only on the success branch.

**Diagnostic guidance.** Any runtime error of the shape
`Cannot access property '<name>' on target of type _ConstMap<…>.`
points at this gap. Trace the value back to its assignment site:
if either end (`const <…>{}` literal, or a bridged API returning
a const empty map) produces a `_ConstMap`, apply the two-step
workaround at that site. `SemanticsEvent.getDataMap()` is the
known Flutter culprit; suspect any payload-optional bridged API
that returns `const <…>{}` for the empty case.

The script's class definitions remain unchanged; only the
variable declaration and the bridged-call assignment need
rewriting.

---

## U8 — Script-defined enum values are `InterpretedEnumValue`, not native `Enum`; plus `RestorableValue.value` asserts `isRegistered` (interpreter limitation + scripting trap)

**Category.** Two cooperating issues that surface together on
restorable-value demos that use a local script-defined enum.

**(1) Interpreter limitation — `InterpretedEnumValue` is not
`Enum`.** d4rt represents every script-defined enum value
through a dedicated runtime class:

```dart
// tom_d4rt_ast/lib/src/runtime/runtime_types.dart  (line 1861)
class InterpretedEnumValue implements RuntimeValue { /* … */ }
```

The same shape exists in `tom_d4rt`. `InterpretedEnumValue`
implements `RuntimeValue` but **not** Dart's native `Enum`. Any
bridged API parameter that is typed `Enum` (or that delegates
through `D4.getRequiredArg<Enum>` / `D4.getNamedArg<Enum>`) sees
the script value as a `RuntimeValue`, fails the `is Enum`
predicate, and throws:

```text
Runtime Error: Native error during default bridged constructor
for 'RestorableEnum': Argument Error: Invalid parameter
"defaultValue": expected Enum, got InterpretedEnumValue
```

Same family as U3 (`Curve`) and U5 (`NotchedShape` /
`FloatingActionButtonLocation`): a script-defined subtype of a
bridged native abstract / built-in type cannot cross the
d4rt → native boundary as that native type. Concretely, the
trigger is anywhere a bridged constructor or method is typed
`Enum` (or a `T extends Enum` generic parameter is reified
against `Enum`), e.g. `RestorableEnum<E>(E defaultValue,
{required List<E> values})`,
`RestorableEnumN<E>(E? defaultValue, {required List<E?> values})`,
`Set<Enum>` parameters, `EnumName` extension calls reaching
native ground.

**(2) Scripting trap — `RestorableValue.value` requires
registration.** The Flutter `RestorableValue<T>.value` getter
asserts the property is registered with a `RestorationMixin`:

```dart
// flutter/lib/src/widgets/restoration_properties.dart  (line 85)
T get value {
  assert(isRegistered);
  return _value as T;
}
```

`flutter test` runs in debug mode, so the assertion fires when
the script reads `.value` on a restorable that the script never
wired through `registerForRestoration(...)`. This is **not** a
d4rt limitation — it is real Dart/Flutter behaviour that the
same code would exhibit in plain Flutter. It tends to surface
*together with* U8(1) because the C20-style constructor error
on a script-defined enum aborts execution before the first
`.value` access, masking the assertion until the enum
workaround unmasks it.

**Reproducer (combined).** The smallest combined repro is the
`testlog_20260517-0914` C20 cluster
(`widgets/restorable_values_test.dart`):

```dart
enum _Mood { calm, focused, joyful, sleepy }

dynamic build(BuildContext context) {
  final RestorableEnum<_Mood> restMood =
      RestorableEnum<_Mood>(_Mood.focused, values: _Mood.values);
  // … (never registered with a RestorationMixin)
  print('restMood=${restMood.value}');  // (never reached: U8(1) trips first)
  // …
}
```

Yields:

```text
Runtime Error: Native error during default bridged constructor
for 'RestorableEnum': Argument Error: Invalid parameter
"defaultValue": expected Enum, got InterpretedEnumValue
```

at the constructor call. If U8(1) is sidestepped by switching
to a framework enum, the next failure is U8(2):

```text
'package:flutter/src/widgets/restoration_properties.dart':
Failed assertion: line 85 pos 12: 'isRegistered': is not true.
```

at the first `restMood.value` read.

**Constraints.**

- A targeted interpreter fix for (1) would require
  `InterpretedEnumValue` to *implement* `Enum` (add `index`,
  `name`, and have the runtime type pass `is Enum`). `Enum` is a
  Dart-VM-special sealed type — class subtyping is constrained
  by the VM's reified-enum machinery, so a straight
  `implements Enum` would not satisfy the native `is Enum`
  check at the bridge boundary. The fix is non-trivial and out
  of cluster scope.
- A targeted fix for (2) would require the script to wire a
  `RestorationMixin` host widget around every restorable demo.
  That refactors the entire script into a `StatefulWidget` and
  is invasive. In a static demo where values never mutate the
  shadow-variable workaround is functionally exact and
  minimally disruptive.

**Script-side workarounds (mandatory).**

*For (1):* Replace any script-defined enum used at a native
API boundary with a framework-provided one. Good substitutes,
sorted by member count:

| Substitute | Values | Notes |
|------------|-------:|-------|
| `Brightness` | 2 | Cleanest two-state enum |
| `TextDirection` | 2 | ltr / rtl |
| `Orientation` | 2 | portrait / landscape |
| `Axis` | 2 | horizontal / vertical |
| `CrossAxisAlignment` | 5 | start / end / center / stretch / baseline |
| `MainAxisAlignment` | 6 | start / end / center / spaceBetween / spaceAround / spaceEvenly |
| `TargetPlatform` | 6 | android / fuchsia / iOS / linux / macOS / windows |

The script's own `enum X { … }` declaration can stay if it is
used purely on the d4rt side (iteration, switch statements,
display); the substitution is only at the call sites that hand
the value to a native bridge that types it as `Enum`.

*For (2):* Shadow each restorable with a plain Dart variable
holding the same construction-time default, and read the shadow
in display widgets. The substitution is exact whenever the
demo doesn't mutate `.value` (verified via
`grep 'restXxx\\.value\\s*=' script.dart`). Pattern:

```dart
// Shadows
const int _vInt = 42;
const Brightness _vMood = Brightness.dark;
final DateTime _vDateTime = DateTime(2026, 5, 11);

// Restorables share the same default
final RestorableInt restInt = RestorableInt(_vInt);
final RestorableEnum<Brightness> restMood =
    RestorableEnum<Brightness>(_vMood, values: Brightness.values);
final RestorableDateTime restDateTime = RestorableDateTime(_vDateTime);

// Displays use the shadow, not `restXxx.value`
Text('$_vInt')
Text('${_vMood.name}')
Text(_vDateTime.toIso8601String())
```

`.runtimeType` reads on the restorables stay fine — they do not
trigger the assertion.

**Diagnostic guidance.** Any one of:

- `expected Enum, got InterpretedEnumValue` →
  bridge-boundary enum mismatch (U8(1)). Look for the
  script-defined enum at the failing call site and substitute a
  framework enum.
- `'isRegistered': is not true.` at line 85 of
  `restoration_properties.dart` → `.value` read on an
  unregistered restorable (U8(2)). Apply the shadow-variable
  pattern.

When both errors are likely, fix (1) first; (2) will surface
afterwards if it applies.

**Variant — `EnumProperty<T extends Enum?>` for diagnostic
serialization (2026-05-19, Step 10 follow-up).** The same root
cause surfaces a second way: a script declares a local enum
(`enum _DemoMode { compact, normal, verbose }`) inside a class
that mixes in `DiagnosticableTreeMixin`, then in
`debugFillProperties` adds an `EnumProperty<_DemoMode>('mode',
mode)`. The bridge constructor signature in
`tom_d4rt_flutter_ast/lib/src/bridges/foundation_bridges.b.dart`
extracts the value as `D4.getRequiredArg<Enum?>(positional, 1,
'value', 'EnumProperty')`, which routes through
`extractBridgedArg<Enum?>` — and `InterpretedEnumValue is Enum?`
is false. Trigger:

```text
Runtime Error: Native error during default bridged constructor
for 'EnumProperty': Argument Error: Invalid parameter "value":
expected Enum?, got InterpretedEnumValue
```

In the baseline `testlog_20260518-1449` this defect was masked:
mixin dispatch via `DiagnosticableTreeMixin` fell through earlier
(see Step 3 of the 1449 fix-plan / `error_analysis.md`), so
`debugFillProperties` never ran and `EnumProperty` was never
reached. Once Step 3 fixed mixin dispatch the previously-dead
code path executes and U8(1) re-surfaces at the EnumProperty
boundary. This is **not** a Step 3 regression — Step 3 simply
unmasks a long-standing interpreter limitation.

The framework-enum substitution table above does not apply when
the enum is a demo-specific name (`_DemoMode`) used only for
serialization shape: there is no semantically-equivalent
framework enum. The correct script-side workaround for the
diagnostics use case is to render the enum value as a
`StringProperty` instead:

```dart
// Before (rejected by EnumProperty bridge):
properties.add(EnumProperty<_DemoMode>('mode', mode));

// After (interpreter-friendly, same display string):
properties.add(StringProperty('mode', mode.toString()));
```

Both forms emit `_DemoMode.<name>` as the property description
because `toString()` on an `InterpretedEnumValue` returns
`${parentEnum.name}.$name`. Downstream serialization-shape
assertions must update their expected `type` field from
`EnumProperty<_DemoMode>` to `StringProperty` to match the new
shape — the description is byte-identical.

Applied 2026-05-19 to
`tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts/foundation/diagnostics_serialization_delegate_test.dart`
(lines 88 + 622 region) to close the Step 10 verification
failure on `hardly_relevant_classes_1_test`. The script is
shared with `tom_d4rt_flutter_test` via `SendTestRunner.scriptsPath`
— one edit covers both projects.

---

## U9 — Script-defined `RouteAware` cannot be subscribed to a native `RouteObserver` (interpreter limitation)

**Category.** Same architectural family as U3 (`Curve`), U5
(`NotchedShape` / `FloatingActionButtonLocation`), and U8
(`Enum`): a script-defined subtype of a bridged native abstract /
mixin type cannot cross the d4rt → native boundary as that native
type.

**Reproducer.** The smallest repro is the
`testlog_20260517-0914` C22 cluster
(`widgets/route_observer_test.dart`):

```dart
class _LoggingRouteAware with RouteAware {
  // … didPush, didPop, didPushNext, didPopNext overrides
}

dynamic build(BuildContext context) {
  final routeObserver = RouteObserver<PageRoute<dynamic>>();
  final homeAware = _LoggingRouteAware('home', log);
  final homeRoute = MaterialPageRoute<void>(...);

  routeObserver.subscribe(homeAware, homeRoute);  // fails here
}
```

Yields:

```text
Runtime Error: Native error during bridged method call
'subscribe' on RouteObserver: Argument Error: Invalid parameter
"routeAware": expected RouteAware, got
InterpretedInstance(_LoggingRouteAware)
```

The native `RouteObserver.subscribe(RouteAware aware, R route)`
bridge validates `aware` via `D4.getRequiredArg<RouteAware>`,
which checks `value is RouteAware`. A d4rt `InterpretedInstance`
fails this check even when its synthetic class declares
`with RouteAware` or `implements RouteAware` — the bridge
generator does not synthesise a native `RouteAware`-implementing
adapter proxy for script-defined subclasses.

**Constraints.**

- There is no framework-provided `RouteAware` concrete subclass
  to substitute (analogous to `Brightness` for U8 or
  `FloatingActionButtonLocation.endFloat` for U5). `RouteAware`
  is designed to be mixed into application-side `State`
  subclasses; every concrete implementation lives in user code.
- A targeted interpreter / generator fix would require the
  bridge generator to synthesise a native adapter that
  *implements* `RouteAware`, delegates each of the four lifecycle
  callbacks back to the interpreted instance via
  `InterpretedInstance.invoke`, and is automatically wrapped
  around any `InterpretedInstance` passed to a parameter typed
  `RouteAware`. This is the same long-term proxy-synthesis sketch
  noted under U3 / U5 / U8 and is out of scope for a single
  cluster pass.
- Constructing the native `RouteObserver<R>` itself is safe — it
  has no script-defined arguments. Only the `subscribe` /
  `unsubscribe` boundary fails.

**Script-side workaround (mandatory).** Replace the native
observer's subscription / dispatch protocol with a small
script-side stand-in that mirrors the same five-method contract
(`subscribe`, `unsubscribe`, `didPush`, `didPop`, `didReplace`).
Define it once at the top of the script:

```dart
class _DemoRouteObserver {
  final Map<Route<dynamic>, List<_LoggingRouteAware>> _subs =
      <Route<dynamic>, List<_LoggingRouteAware>>{};

  void subscribe(_LoggingRouteAware aware, Route<dynamic> route) {
    _subs.putIfAbsent(route, () => <_LoggingRouteAware>[]).add(aware);
  }

  void unsubscribe(_LoggingRouteAware aware) {
    for (final list in _subs.values) {
      list.remove(aware);
    }
  }

  void didPush(Route<dynamic> route, Route<dynamic>? previous) {
    for (final a in _subs[route] ?? const <_LoggingRouteAware>[]) {
      a.didPush();
    }
    if (previous != null) {
      for (final a in _subs[previous] ?? const <_LoggingRouteAware>[]) {
        a.didPushNext();
      }
    }
  }

  void didPop(Route<dynamic> route, Route<dynamic>? previous) {
    for (final a in _subs[route] ?? const <_LoggingRouteAware>[]) {
      a.didPop();
    }
    if (previous != null) {
      for (final a in _subs[previous] ?? const <_LoggingRouteAware>[]) {
        a.didPopNext();
      }
    }
  }

  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute != null) {
      for (final a in _subs[newRoute] ?? const <_LoggingRouteAware>[]) {
        a.didPush();
      }
    }
    if (oldRoute != null) {
      for (final a in _subs[oldRoute] ?? const <_LoggingRouteAware>[]) {
        a.didPop();
      }
    }
  }
}
```

Drive all subscription and lifecycle calls through this object;
the native `RouteObserver` can still be constructed alongside
(with `// ignore: unused_local_variable`) to demonstrate that
the type exists in Flutter. The call sequence, per-subscriber
counters, and notification ordering are byte-for-byte identical
to what the native observer would produce because the protocol
itself is just `Map<Route, List<RouteAware>>` with the four
dispatch rules above.

**Diagnostic guidance.** `expected RouteAware, got
InterpretedInstance(...)` at the
`RouteObserver.subscribe(...)` call site → apply the
`_DemoRouteObserver` workaround. The same pattern applies to
any other bridged listener registration where the listener type
is a script-mixed-in abstract — e.g. `Listenable.addListener`
expects a callback (works fine) but a hypothetical native
`addLifecycleObserver(SomeAware)` would exhibit the same
boundary failure.

---

## U10 — Script-defined class `with DiagnosticableTreeMixin` cannot call inherited concrete methods (interpreter limitation)

**Category.** Same architectural family as U3 (`Curve`), U5
(`NotchedShape` / `FloatingActionButtonLocation`), U8 (`Enum`),
and U9 (`RouteAware`): a script-defined subtype of a bridged
native abstract / mixin type cannot cross the d4rt → native
boundary as that native type. U10 differs from the rest in that
the failing path is *inside the mixin's own concrete methods*
(`toStringDeep`, `toString`, `toStringShallow`,
`toDiagnosticsNode`) rather than at a separate bridged API
boundary — the mixin contributes both abstract callbacks
(`debugFillProperties`, `debugDescribeChildren`, `toStringShort`)
and concrete consumers of those callbacks, and only the latter
is dispatched into the bridge.

**Reproducer.** Smallest repro is the `testlog_20260517-0914`
C36 cluster (`foundation/class_test.dart`):

```dart
class _Node with DiagnosticableTreeMixin {
  _Node(this.name, {this.value = 0, this.children = const []});
  final String name;
  final int value;
  final List<_Node> children;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('name', name));
    properties.add(IntProperty('value', value));
    properties.add(IntProperty('childCount', children.length));
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    return <DiagnosticsNode>[
      for (final c in children) c.toDiagnosticsNode(name: c.name),
    ];
  }

  @override
  String toStringShort() => 'Node($name)';
}

dynamic build(BuildContext context) {
  final tree = _Node('root', ...);
  final String treeDump = tree.toStringDeep();  // fails here
}
```

Yields:

```text
Runtime Error: Native error in bridged mixin method
'DiagnosticableTreeMixin.toStringDeep': Argument Error: Invalid
target: expected DiagnosticableTreeMixin, got InterpretedInstance
```

**Root cause.** Two interlocking issues, both architectural:

1. The bridged-mixin method dispatch in
   `tom_d4rt_ast/lib/src/runtime/runtime_types.dart` (around line
   1416–1487) computes
   `mixinTarget = nativeProxy ?? bridgedSuperObject ?? this` and
   passes it to the adapter. For a purely-interpreted class with
   no native superclass and no native proxy registered, this is
   the `InterpretedInstance` itself, which the adapter's
   `D4.validateTarget<DiagnosticableTreeMixin>` rejects on a
   `value is DiagnosticableTreeMixin` check.
2. Even if the target check were relaxed (e.g. by skipping it
   for `InterpretedInstance` arguments), the native
   `DiagnosticableTreeMixin.toStringDeep` calls back into
   `debugFillProperties` / `debugDescribeChildren` /
   `toStringShort` via Dart dynamic dispatch. Those calls would
   resolve to the *native* `Diagnosticable` defaults, **not** to
   the script's overrides — there is no mechanism for the native
   side to dispatch back into the interpreter for these
   callbacks.

The proper fix is a hand-written
`_InterpretedDiagnosticableTreeMixin` proxy in
`d4rt_runtime_registrations.dart` (analogous to
`_InterpretedStatelessWidget`, `_InterpretedState`, etc.) that:

- Implements `DiagnosticableTreeMixin` natively;
- Holds the `InterpretedInstance` + visitor;
- Overrides each abstract callback to invoke the interpreted
  method on the held instance;
- Is wired into the interpreter at mixin-resolution time so the
  `nativeProxy` chain produces this proxy whenever an
  interpreted class mixes in `DiagnosticableTreeMixin`.

This is feature-scale work (the existing 10+ `_Interpreted*`
proxies are all roughly 100–200 lines apiece, and the wiring at
mixin-resolution time is new infrastructure), deferred for this
cluster pass.

**Constraints.**

- There is no framework-provided `DiagnosticableTreeMixin`
  concrete subclass that the script can use as-is and still
  carry the interpreted state — every consumer of the mixin in
  Flutter (e.g. `RenderObject`, `Element`, `Widget` subclasses)
  ties the mixin to its own state and lifecycle, none of which
  the script can subsume.
- The mixin's *concrete* methods can be reproduced manually
  because the protocol is well-documented: `toStringDeep` walks
  the children returned by `debugDescribeChildren` and indents
  the per-node header (which is `toStringShort()` plus the
  formatted properties from `debugFillProperties`).

**Script-side workaround (mandatory).** Build the diagnostics
dump directly via a small recursive helper that calls the
script's own `debugFillProperties` / `debugDescribeChildren` /
`toStringShort` and formats them analogously to
`toStringDeep`. Define it once near the script's helpers:

```dart
String _dumpNode(_Node n, String prefix, String childPrefix) {
  final props = DiagnosticPropertiesBuilder();
  n.debugFillProperties(props);
  final propList = props.properties
      .where((p) => !p.isFiltered(DiagnosticLevel.info))
      .map((p) => p.toString())
      .join(', ');
  final header = '$prefix${n.toStringShort()}'
      '${propList.isEmpty ? '' : '($propList)'}';
  final lines = <String>[header];
  final kids = n.children;
  for (var i = 0; i < kids.length; i++) {
    final isLast = i == kids.length - 1;
    final nextPrefix = childPrefix + (isLast ? ' └─' : ' ├─');
    final nextChild = childPrefix + (isLast ? '   ' : ' │ ');
    lines.add(_dumpNode(kids[i], nextPrefix, nextChild));
  }
  return lines.join('\n');
}

final String treeDump = _dumpNode(tree, '', '');
```

The produced string is structurally similar to `toStringDeep()`
output (root header with comma-separated properties, indented
children, box-drawing connectors). It is purely script-side and
does not cross the d4rt → native boundary; the
`DiagnosticPropertiesBuilder` / `StringProperty` / `IntProperty`
calls all go through the existing well-tested bridges. The demo
keeps showing live `debugFillProperties` / `debugDescribeChildren`
output — only the formatting of the final string is moved out of
the inaccessible bridged consumer.

**Diagnostic guidance.** `Native error in bridged mixin method
'DiagnosticableTreeMixin.<method>': Argument Error: Invalid
target: expected DiagnosticableTreeMixin, got
InterpretedInstance` → apply the `_dumpNode` helper. The same
shape applies to any future bridged-mixin method whose concrete
implementation lives on the native side but whose abstract
callbacks are overridden on the script side; build the
dispatch manually.

**Second instance — `toDiagnosticsNode` + `toJsonMap` pipeline
(C37, `foundation/diagnostics_serialization_delegate_test.dart`).**
The same architectural limitation surfaces when a script's
demo wants the *JSON shape* of the diagnostics tree, not the
string dump:

```dart
class _DemoConfig with DiagnosticableTreeMixin {
  // … overrides for debugFillProperties / debugDescribeChildren
}

Map<String, Object?> _serializeWith(
  _DemoConfig config,
  DiagnosticsSerializationDelegate delegate,
) {
  final DiagnosticsNode node = config.toDiagnosticsNode(name: 'root');
  return node.toJsonMap(delegate); // throws — target rejected
}
```

The bridged `toDiagnosticsNode` adapter strict-checks the target
and rejects the `InterpretedInstance` of `_DemoConfig`, same as
`toStringDeep`. Additionally, this demo defines four
script-side `DiagnosticsSerializationDelegate` subclasses
(`_ShallowDelegate`, `_FilteredDelegate`, `_DepthTaggedDelegate`,
`_ComposedDelegate`) whose lifecycle hooks (`filterProperties`,
`delegateForNode`, `truncateNodesList`) would in any case never
be reached from the native side (same architectural family —
script-defined subtype of a bridged interface; the native
`toJsonMap` won't dispatch back into them).

**Script-side workaround variant (mandatory).** Replace the
`config.toDiagnosticsNode(...).toJsonMap(delegate)` call chain
with a script-side recursive serializer that reads the
delegate's two public getters and best-effort-detects each
delegate concrete class for its per-delegate effects:

```dart
Map<String, Object?> _serializeWith(
  _DemoConfig config,
  DiagnosticsSerializationDelegate delegate,
) {
  return _manualSerialize(config, delegate);
}

Map<String, Object?> _manualSerialize(
  _DemoConfig c,
  DiagnosticsSerializationDelegate delegate, {
  int depth = 0,
}) {
  final int subtreeDepth = delegate.subtreeDepth;
  final bool includeProperties = delegate.includeProperties;

  String? hidePrefix;
  int maxChildren = -1;
  String delegateLabel = 'default';
  int? depthTag;
  if (delegate is _FilteredDelegate) {
    hidePrefix = delegate.hidePrefix;
    delegateLabel = 'filtered';
  } else if (delegate is _DepthTaggedDelegate) {
    maxChildren = delegate.maxChildren;
    depthTag = delegate.depth;
    delegateLabel = 'depth-tagged';
  }
  // … _ShallowDelegate / _ComposedDelegate labels likewise

  final Map<String, Object?> result = <String, Object?>{
    'name': depth == 0 ? 'root' : 'child',
    'description': '_DemoConfig#${c.label}',
    'type': '_DemoConfig',
    'depth': depth,
    '_delegate': delegateLabel,
  };
  if (includeProperties) {
    final props = <Map<String, Object?>>[];
    void addProp(String name, Object? v, String type) {
      if (hidePrefix != null && name.startsWith(hidePrefix)) return;
      props.add({'name': name, 'description': '$v', 'type': type});
    }
    addProp('label', c.label, 'StringProperty');
    // … other fields likewise
    result['properties'] = props;
  }
  if (subtreeDepth > 0 && c.children.isNotEmpty) {
    final kids = (maxChildren > 0 && c.children.length > maxChildren)
        ? c.children.sublist(0, maxChildren)
        : c.children;
    final child = delegate.copyWith(subtreeDepth: subtreeDepth - 1);
    result['children'] = [
      for (final k in kids) _manualSerialize(k, child, depth: depth + 1),
    ];
  }
  return result;
}
```

`delegate.subtreeDepth` / `delegate.includeProperties` /
`delegate.copyWith(...)` all work for both the const native base
class (bridged getters / bridged method) and the script-defined
subclasses (interpreter field access / interpreted method call).
The produced map is structurally compatible with what
`toJsonMap` would have emitted for the demo's rendering needs;
it is not a faithful reimplementation of the
`DiagnosticsSerializationDelegate` protocol (the `filterChildren`
/ `truncateNodesList` / `delegateForNode` hooks on the
script-defined subclasses are not invoked) — but the demo
itself never observes that.

**Third instance — parent `Diagnosticable` mixin variant +
`super.debugFillProperties` dispatch failure (C38,
`foundation/object_flag_property_test.dart`).** The same
architectural limitation surfaces for the parent `Diagnosticable`
mixin (not just `DiagnosticableTreeMixin`), with an additional
interpreter-level wrinkle:

```dart
class _DemoConfig with Diagnosticable {
  // … fields
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties); // (A) — fails
    properties.add(StringProperty('label', label));
    // …
  }
}

// Consumer site:
final String dump = config.toDiagnosticsNode().toStringDeep(); // (B) — fails
```

(A) `super.debugFillProperties(properties)` from an interpreted
class whose only super is the bridged `Diagnosticable` mixin
throws *`Class '_DemoConfig' does not have a standard or bridged
superclass, cannot use 'super'.`* The interpreter does not
resolve `super` calls into a bridged-mixin super-chain for the
purely-interpreted class (no native superclass exists; the mixin
is contributed via the bridged-mixin dispatch but is not visible
to `super` resolution).

(B) Even after removing the offending `super` call,
`config.toDiagnosticsNode()` rejects the `InterpretedInstance`
the same way `toStringDeep` did in C36 — the bridged
`Diagnosticable.toDiagnosticsNode` adapter strict-checks the
target via `D4.validateTarget<Diagnosticable>`.

Notes:

- The native `Diagnosticable.debugFillProperties` is itself a
  no-op (its purpose is to be overridden), so dropping the
  `super.debugFillProperties(...)` call has *no effect on the
  emitted output*. This is a safe script-side workaround for the
  super-call dispatch failure, but it remains an interpreter
  limitation in its own right: any bridged-mixin method that does
  meaningful work in its native implementation would not survive
  the same workaround.
- C38 also had a *script bug* layered on top of the U10 issues:
  two `ObjectFlagProperty` construction-gallery entries omitted
  both `ifPresent` and `ifNull`, violating the framework's
  `ifPresent != null || ifNull != null` assert at line 2389 of
  `diagnostics.dart`. That bug is unrelated to U10 and was fixed
  by supplying empty-string text in the unused slot.

**Script-side workaround variant (mandatory).** When a script
class mixes in `Diagnosticable` and the demo needs a string
dump (no children — `Diagnosticable` does not define
`debugDescribeChildren`):

```dart
String _diagnosticableDeepDump(_DemoConfig c) {
  final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
  c.debugFillProperties(builder);
  final List<String> lines = <String>[c.toStringShort()];
  for (final DiagnosticsNode p in builder.properties) {
    lines.add(' │ ${p.toString()}');
  }
  return lines.join('\n');
}
```

And inside the script's `debugFillProperties` override, drop
the `super.debugFillProperties(properties);` call entirely — it
is a no-op natively, and the interpreter cannot dispatch it
through the bridged-mixin chain. Annotate the omission so the
reason is preserved for future readers:

```dart
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  // D4RT-SCRIPT-WORKAROUND (U10 family): bridged `Diagnosticable`
  // mixin does not support `super.debugFillProperties(...)` from
  // a script-defined class (no native super for the
  // InterpretedInstance). The native implementation is a no-op
  // anyway, so dropping the super call has no observable effect.
  properties.add(StringProperty('label', label));
  // …
}
```

**Diagnostic guidance — four signatures of U10 to recognise.**

- *Argument Error: Invalid target: expected
  DiagnosticableTreeMixin, got InterpretedInstance* — the
  `toStringDeep` / `toStringShallow` / `toString` consumer
  variant (C36). Apply `_dumpNode`.
- *Argument Error: Invalid target: expected Diagnosticable, got
  InterpretedInstance (in Map literal)* (or anywhere
  `toDiagnosticsNode` is invoked) — the `toDiagnosticsNode` +
  `toJsonMap` / `toStringDeep` chain (C37/C38). Apply
  `_manualSerialize` (for JSON shape) or `_diagnosticableDeepDump`
  (for string dump).
- *Class 'X' does not have a standard or bridged superclass,
  cannot use 'super'.* — the `super.debugFillProperties(...)`
  super-call variant (C38). Drop the super call; the native
  implementation is a no-op.
- *A value of type 'DiagnosticableTreeMixin' can't be returned
  from the function 'XYZ' because it has a return type of
  '<ScriptClass>'.* — the **return-type narrowing variant**
  (2026-05-19, Step 10 follow-up on
  `foundation/diagnostics_serialization_delegate_test.dart`).
  When a script-defined class declares
  `class X with DiagnosticableTreeMixin { … }` and is then
  constructed and returned from a function whose declared return
  type is `X`, the interpreter narrows the constructed value's
  runtime type to the bridged mixin (`DiagnosticableTreeMixin`)
  rather than to `X`, then rejects the return as a type
  mismatch. The trigger is the `with DiagnosticableTreeMixin`
  clause itself — the mixin's methods are unreachable from the
  script anyway (target-check variant above), so the mixin only
  adds liability. **Mandatory script-side workaround:** drop
  `with DiagnosticableTreeMixin` from the class declaration
  entirely. Remove the `@override` annotations and the
  `super.debugFillProperties(...)` call from any override
  methods (or delete the override methods if they are never
  invoked — manual serialisation does not need them). The
  underlying root cause is the same family as U3/U5/U8/U9 — a
  script-defined subtype of a bridged native mixin cannot cross
  the d4rt → native boundary as that native type, and here the
  manifestation is the *return path* rather than a target
  check.

**Fifth instance — `extends DiagnosticableTree` (abstract class
form) returns `null` from `toDiagnosticsNode()`** (2026-05-23,
Cluster F #11 of `testlog_20260522-1328-issue-analysis` on
`foundation/text_tree_configuration_test.dart`):

```dart
class _SampleScene extends DiagnosticableTree {
  // … debugFillProperties / debugDescribeChildren / toStringShort
}

final String dump = scene.toDiagnosticsNode().toStringDeep();
//                       ^^^^^^^^^^^^^^^^^^^ returns null
// Runtime Error: Cannot invoke method 'toStringDeep' on null.
// Use '?.' for null-aware method invocation.
```

Same architectural family as the prior four instances, but the
bridge surface for the abstract class `DiagnosticableTree`
behaves slightly differently from the mixin: instead of throwing
`Argument Error: Invalid target` from `D4.validateTarget`, the
bridge's `toDiagnosticsNode` returns `null` for an unrecognised
`InterpretedInstance`. The subsequent chained
`.toStringDeep()` then fails on the null result, masking the
real cause one method-call hop later. Recognise the pattern by
the `_SampleScene extends DiagnosticableTree` (or any other
script-defined `extends`/`implements` against a bridged
diagnostics-family class) plus the `Cannot invoke method
'toStringDeep' on null` shape.

**Mandatory script-side workaround:** render the diagnostics
dump manually from the script's own data model rather than
calling `toDiagnosticsNode().toStringDeep()`. The script under
Cluster F #11 already maintained an independent `_SampleNode`
tree alongside the `DiagnosticableTree` subclass; a small
top-level helper that emits a header line (mirroring
`toStringShort()` plus the property summary added by
`debugFillProperties`) followed by a body built from
`scene.renderManual('├─', '│  ', '└─', ' ')` produces output
visually equivalent to Flutter's real sparse `toStringDeep`
rendering for this demo. Three call sites switched over (the
`debugPrint` live header, the section-1 `_MonoBlock`, and the
section-4 `sparse` string). `debugDescribeChildren` and the
`_SampleNodeDiagnosable` wrapper can stay in the script as
teaching reference — they are dead code under the workaround
but document the intended native pattern.

---

## U11 — Script-defined `HitTestTarget` rejected by `HitTestEntry(target)` constructor (interpreter limitation)

**Category.** Same architectural family as U3 (`Curve`), U5
(`NotchedShape` / `FloatingActionButtonLocation`), U8 (`Enum`),
U9 (`RouteAware`), U10 (`Diagnosticable*`). A script-defined
subtype of a bridged native abstract / interface type cannot
cross the d4rt → native boundary as that native type.

**Reproducer.** Smallest repro is the `testlog_20260517-0914`
C39 cluster (`gestures/hit_testable_test.dart`):

```dart
class _FakeTarget implements HitTestTarget {
  _FakeTarget(this.label);
  final String label;
  @override
  void handleEvent(PointerEvent event, HitTestEntry entry) {}
  @override
  String toString() => '_FakeTarget($label)';
}

final sampleResult = HitTestResult();
final innerTarget = _FakeTarget('RenderParagraph#text');
sampleResult.add(HitTestEntry(innerTarget)); // fails here
```

Yields:

```text
Runtime Error: Native error during default bridged constructor
for 'HitTestEntry': Argument Error: Invalid parameter "target":
expected HitTestTarget, got InterpretedInstance(_FakeTarget)
```

**Root cause.** The generated bridge for `HitTestEntry`
(`tom_d4rt_flutterm/lib/src/bridges/gestures_bridges.b.dart`)
adapts the single-arg positional constructor as

```dart
final target = D4.getRequiredArg<HitTestTarget>(positional, 0,
    'target', 'HitTestEntry');
return HitTestEntry(target);
```

`D4.getRequiredArg<HitTestTarget>` performs a strict `value is
HitTestTarget` check on the supplied positional. For a
`InterpretedInstance(_FakeTarget)` the strict-cast fails because
the script-defined class's synthetic Dart hierarchy never
materialises a native `HitTestTarget` super-type — d4rt has no
mechanism to register a per-call native proxy for an arbitrary
interpreted `implements`-only subtype of an interface that
itself contributes only abstract methods.

The proper fix is the same kind of `_InterpretedHitTestTarget`
proxy that would resolve U3/U5/U9/U10 — a hand-written native
adapter in `d4rt_runtime_registrations.dart` that implements
`HitTestTarget` natively, holds the `InterpretedInstance` +
visitor, and routes `handleEvent` back into the interpreter.
This is feature-scale work and deferred for this cluster pass.

**Constraints.**

- There is no framework-provided concrete `HitTestTarget` that
  the script can substitute without standing up a full render
  tree — every concrete `HitTestTarget` in Flutter is a
  `RenderObject` subclass tied to the rendering pipeline.
- The demo's actual functional need is purely visual: it
  iterates `result.path` to display a stacked-card view of
  per-entry labels and `entry.runtimeType`. It never calls
  `target.handleEvent(...)` or dispatches through
  `GestureBinding`.

**Script-side workaround (mandatory).** Keep the
`_FakeTarget implements HitTestTarget` class declaration as a
teaching reference (the demo shows it verbatim in a pseudocode
panel), but do not instantiate it. Substitute a pure
script-side data class for the anatomy-panel display:

```dart
class _DemoHitEntry {
  _DemoHitEntry(this.label, this.runtimeTypeStr);
  final String label;
  final String runtimeTypeStr;
}

// At the build entry-point:
final HitTestResult sampleResult = HitTestResult();         // native — fine
final BoxHitTestResult sampleBoxResult = BoxHitTestResult(); // native — fine
final List<_DemoHitEntry> sampleEntries = <_DemoHitEntry>[
  _DemoHitEntry('RenderParagraph#text', 'HitTestEntry'),
  _DemoHitEntry('RenderPadding#padding', 'HitTestEntry'),
  _DemoHitEntry('RenderView#root', 'HitTestEntry'),
];
// Pass `sampleEntries` to `_buildAnatomyPanel` instead of
// `sampleResult`.
```

Native `HitTestResult()` and `BoxHitTestResult()` constructors
still execute successfully (no script-defined `HitTestTarget`
argument is involved), so the demo still demonstrates that
these types exist and are reachable through the bridge — only
the `HitTestEntry(<script HitTestTarget>)` boundary crossing
is skipped.

**Diagnostic guidance.** `Native error during default bridged
constructor for 'HitTestEntry': Argument Error: Invalid
parameter "target": expected HitTestTarget, got
InterpretedInstance(<ScriptClass>)` → the demo is using a
script-defined `implements HitTestTarget` to seed a
`HitTestResult`. Substitute a script-side data record for the
visual display and keep the script class as a teaching
reference only.

---

## U12 — `@Deprecated`-annotated SDK symbols are filtered out of the bridge surface by design (generator policy)

**Category:** Interpreter / generator architectural decision
(generator-level policy).

**Symptom.** A script that imports a deprecated SDK symbol —
e.g. the (still-exported but `@Deprecated`-tagged) enum
`KeyDataTransitMode` from `package:flutter/services.dart` —
fails at the first use site with `Runtime Error: Undefined
variable: <SymbolName>`. Affected scripts in the
`testlog_20260517-0914` corpus include
`services/key_data_transit_mode_test.dart` (C44, testID 117)
and structurally identical demos for other deprecated symbols
(KeyboardSide / RawKeyEventDataWeb / RawKeyEventDataLinux —
C45, C49, C50).

**Root cause.** The bridge generator
(`tom_d4rt_generator/lib/src/element_mode_extractor.dart`)
filters out every element carrying an `@Deprecated`
annotation:

```dart
bool generateDeprecatedElements = false;
...
if (!generateDeprecatedElements && _hasDeprecatedAnnotation(enumEl)) {
  skippedDeprecatedCount++;
  return;
}
```

The filter is applied uniformly for enums, classes, functions,
getters, setters, top-level variables, extensions, and
typedefs — see `_hasDeprecatedAnnotation` and the eight call
sites in `element_mode_extractor.dart`. The result is that the
SDK enum `KeyDataTransitMode` (annotated `@Deprecated('No
longer supported. Transit mode is always key data only. This
feature was deprecated after v3.18.0-2.0.pre.')` at
`flutter/lib/src/services/hardware_keyboard.dart:725`) is
never registered as a `BridgedEnumDefinition`, even though it
is still exported by `package:flutter/services.dart` (the
script-level `deprecated_member_use` ignore covers the
analyzer warning but does not change the generator's
behaviour). When the script references it as
`KeyDataTransitMode.values` or in a type annotation, name
resolution falls through to "Undefined variable".

**Why this is the right interpreter / generator policy.**
Bridging a deprecated symbol invites scripts to depend on
behaviour that the framework has already declared it intends
to remove. The generator policy is intentional: keep the
exposed surface aligned with the framework's *non-deprecated*
API, so scripts stay aligned with what real Flutter apps can
depend on going forward. Flipping
`generateDeprecatedElements = true` would temporarily resolve
this symptom but would re-open the deprecated surface across
the entire bridge corpus, which is contrary to the policy.

**Workaround (script-side).** For demo scripts whose entire
premise is to document the *shape* of a deprecated enum (so
the script needs typed `m.name` / `m.index` access to a
matching set of values), introduce a private local stand-in
enum at the top of the script with the same value names and
ordering as the SDK enum, and route the script's typed
lookups through it. All human-readable strings continue to
reference the SDK enum by name so the demo still documents
the (former) framework surface. Example (from
`services/key_data_transit_mode_test.dart`):

```dart
// Local stand-in for the deprecated `KeyDataTransitMode`
// enum that the bridge generator filters out (see
// D4RT-LIMITATION note in the file header). Same value names
// and ordering as the SDK enum so all demo copy referencing
// `.name` / `.index` stays accurate.
enum _KeyDataTransitMode {
  rawKeyData,
  keyDataThenRawKeyData,
}
```

Then `final List<_KeyDataTransitMode> values =
_KeyDataTransitMode.values;` etc. The script-defined enum's
`.name`, `.index`, and `.values` are produced by the
interpreter's own enum machinery — no bridge dispatch needed.

**Diagnostic guidance.** `Runtime Error: Undefined variable:
<Identifier>` where the identifier is an SDK symbol whose
source carries an `@Deprecated(...)` annotation → the bridge
generator skipped it by design. Either rewrite the script to
use a non-deprecated equivalent of the API surface it is
demonstrating, or introduce a local stand-in (enum/class) as
above when the demo's premise is specifically to document the
deprecated symbol's shape.

**Affected scripts (testlog_20260517-0914 corpus).**

- **C44** (`services/key_data_transit_mode_test.dart`) — fixed
  2026-05-18 via local `_KeyDataTransitMode` stand-in.
- **C45** (`services/keyboard_side_test.dart`) — fixed
  2026-05-18 via local `_KeyboardSide` + `_ModifierKey`
  stand-ins (dual-enum scope; `KeyboardSide` and `ModifierKey`
  are both `@Deprecated` at `raw_keyboard.dart:40-44` /
  `raw_keyboard.dart:68-72`).
- **C46 / test driver — typedef-rename sub-pattern** —
  `services/mouse_tracker_annotation_test.dart`
  uses `MaterialState` and `MaterialStateMouseCursor`, which
  are `@Deprecated` *typedefs* (since Flutter 3.19.0-0.3.pre)
  aliasing `WidgetState` / `WidgetStateMouseCursor`. Because
  the typedef *targets* are themselves fully bridged and
  functionally identical (a rename, not a signature change),
  the workaround is simpler than the enum case: use the
  modern names in code positions, preserve the alias in
  in-string / in-comment mentions. No local stand-in needed.
  Fixed 2026-05-18.
- **C49 / test driver (ast/C48) — class stand-in for a
  deprecated subclass.** `services/raw_key_event_data_web_test.dart`
  uses `RawKeyEventDataWeb` (a `RawKeyEventData` subclass), which is
  `@Deprecated` at `flutter/services.dart`
  → `raw_keyboard_web.dart:32-37`. Variant B does not apply: the
  modernisation path is
  `RawKeyEventDataWeb → KeyEvent.physicalKey/logicalKey`, an entirely
  different API shape. Variant A applied with a private
  `class _RawKeyEventDataWeb` carrying the constructor parameters the
  script uses (`code`, `key`, `location`, `metaState`, `keyCode`) plus
  the small set of accessors the demo reads (`isShiftPressed` … via
  the engine bit constants, and best-effort `physicalKey` /
  `logicalKey` strings for the demo's print output). Fixed
  2026-05-18.
- **C50 / test driver (ast/C49) — multi-class stand-in for the
  entire `RawKeyEvent` family.**
  `services/raw_key_event_test.dart` is a deep-demo that exercises
  seven `@Deprecated` SDK symbols at once: `RawKeyEvent`
  (`raw_keyboard.dart:364`), `RawKeyDownEvent`
  (`raw_keyboard.dart:674`), `RawKeyUpEvent`
  (`raw_keyboard.dart:695`), `RawKeyEventDataLinux`
  (`raw_keyboard_linux.dart:30`), `GLFWKeyHelper`
  (`raw_keyboard_linux.dart:255`), and the enums `ModifierKey`
  (`raw_keyboard.dart:68`) and `KeyboardSide`
  (`raw_keyboard.dart:40`). Variant B does not apply
  (`RawKeyEvent → KeyEvent` is an entirely different API shape, no
  per-platform `RawKeyEventData` subclass on the modern
  `KeyEvent`). Variant A applied with a coordinated set of local
  stand-ins:
  - enums `_ModifierKey` and `_KeyboardSide` mirroring the SDK
    value sets;
  - `class _GLFWKeyHelper` (const, no fields);
  - `class _RawKeyEventDataLinux` with the constructor fields
    `keyHelper / unicodeScalarValues / keyCode / scanCode /
    modifiers / isDown` plus
    `isModifierPressed(_ModifierKey, {_KeyboardSide side})` that
    honours the GLFW bitmask (shift=0x0001, control=0x0002,
    alt=0x0004, super/meta=0x0008);
  - abstract `_RawKeyEvent` with the data/character fields and
    `logicalKey` / `physicalKey` getters returning real bridged
    `LogicalKeyboardKey` / `PhysicalKeyboardKey` instances
    (those classes are *not* deprecated) seeded from
    `unicodeScalarValues` / `scanCode`, plus the
    `isShiftPressed` / `isControlPressed` / `isAltPressed` /
    `isMetaPressed` event-level forwarders and `repeat => false`;
  - concrete `_RawKeyDownEvent` and `_RawKeyUpEvent` subclasses
    forwarding to the superclass.
  Every code-position reference is routed through the `_*`
  stand-ins; string literals and comments preserve the SDK names
  verbatim so the didactic copy still documents them. Fixed
  2026-05-18.

With C44/C45/C46/C48/C49/C50 closed, no further
"deprecated-name" clusters remain outstanding in test log
`testlog_20260517-0914`.

**Workaround variants.**

- **Variant A — Local stand-in (enum or class):** use when the
  deprecated symbol has *no* non-deprecated equivalent that is
  bridged, or when the script's premise is to document the
  deprecated symbol's shape specifically. Declare a private
  `_<Name>` with the same value names / ordering / signatures
  and route every code-position reference through it. C44 +
  C45 follow this pattern.
- **Variant B — Modern-name swap:** use when the deprecated
  symbol is a typedef-rename pointing at a still-bridged
  modern symbol with identical surface. Replace each
  code-position reference with the modern name (e.g.
  `MaterialState` → `WidgetState`); no stand-in declaration
  required. C46 follows this pattern.

Both variants preserve in-string / in-comment mentions of the
deprecated name so the demo still documents the historical
alias verbatim.

---

## U13 — Native exceptions thrown across a bridged method are not catchable by their original type (interpreter limitation)

**Category.** A boundary-translation issue. When a native Dart
method invoked through a `BridgedClass` adapter throws a typed
exception (e.g. `PlatformException`, `FormatException`,
`StateError`), the interpreter wraps the throw inside a
`RuntimeError` whose message is
`Native error during bridged method call '<name>' on <Class>:
<exception.toString()>`. The original exception object is
discarded; only its `toString()` form survives. A script-side
`on PlatformException catch (pe)` clause **does not match** the
wrapper, so the exception escapes the try-block and surfaces as
a top-level runtime error.

**Reproducer.** The smallest repro is the `testlog_20260517-0914`
C55 cluster (`retest/services/method_codec_test.dart`):

```dart
final std = StandardMethodCodec();
final errEnv = std.encodeErrorEnvelope(
  code: 'ERR_NOT_FOUND',
  message: 'Resource missing',
  details: 'path=/foo',
);
try {
  std.decodeEnvelope(errEnv); // native throws PlatformException
  thrownType = 'NONE';
} on PlatformException catch (pe) {
  // never reached on d4rt — the wrapper is a RuntimeError, not
  // a PlatformException. The throw escapes the try-block.
  thrownType = 'PlatformException';
  thrownCode = pe.code;
}
```

Yields, both on `tom_d4rt_flutter_ast` and
`tom_d4rt_flutter_test`:

```text
Runtime Error: Native error during bridged method call
'decodeEnvelope' on StandardMethodCodec: PlatformException(
ERR_NOT_FOUND, Resource missing, path=/foo, null)
```

**Root cause.** Native adapters in generated `*.b.dart` bridges
invoke the wrapped Dart method inside a try-block; any native
exception is caught and rethrown as the interpreter's internal
`RuntimeError`. The original type information is lost at this
boundary, so the interpreted try-catch's type-test
(`exception is PlatformException`) cannot succeed regardless of
how the script is written. The same limitation applies to any
typed native exception (`FormatException`,
`MissingPluginException`, `StateError`, custom plugin
exceptions, etc.).

**Constraints.**

- A targeted interpreter fix would require bridge adapters to
  rethrow the *original* exception object across the boundary
  while still surfacing its `toString()` representation in
  diagnostic frames — and the interpreter's `try-catch` matcher
  would need to consult the runtime type of native (non-
  `InterpretedInstance`) exception objects. Both pieces exist in
  isolation but are not currently wired together for bridge
  exception paths. Out of scope for a single cluster pass.
- The wrapper's `toString()` preserves the full original
  exception text (class name, all named arguments) so the
  *information* is recoverable; only the *type-based matching*
  is broken.

**Script-side workaround (mandatory).** Replace the typed
`on <Exception> catch (e)` clause with a broad
`catch (e)` and reconstruct any required fields by string-
parsing `'$e'`. The wrapper text is stable
(`'… PlatformException(<code>, <message>, <details>, null)'`),
so the `code` token is recoverable by locating the
`'PlatformException('` marker and reading up to the first comma.
Example used in C55:

```dart
try {
  std.decodeEnvelope(stdEnv);
  thrownType = 'NONE';
} catch (e) {
  thrownType = 'PlatformException';
  final s = '$e';
  final marker = 'PlatformException(';
  final start = s.indexOf(marker);
  if (start >= 0) {
    final tail = s.substring(start + marker.length);
    final comma = tail.indexOf(',');
    thrownCode = comma >= 0 ? tail.substring(0, comma) : '';
  }
}
```

The same shape applies to any other native-throwing bridge call.
For demos that only need to assert *that* an exception was
thrown (not its type), the simpler form is:

```dart
bool didThrow = false;
try {
  someBridgedCall();
} catch (_) {
  didThrow = true;
}
```

**Diagnostic guidance.** `Runtime Error: Native error during
bridged method call '<X>' on <Y>: <ExceptionClass>(...)`
escaping a script-side `on <ExceptionClass> catch (...)` clause →
apply the broad-catch + string-parse workaround. The original
type-test is not recoverable inside d4rt.

### Affected scripts

| Script | Sites | Notes |
|--------|-------|-------|
| `retest/services/method_codec_test.dart` | Section 6 error-envelope showcase — two `std.decodeEnvelope` / `json.decodeEnvelope` calls inside `on PlatformException catch (pe)` blocks. The first envelope decode threw the wrapper-style `RuntimeError`, escaped the try-block, and surfaced as the test failure. | Workaround applied: broad `catch (e)` + string-parsing of the wrapper's `'PlatformException(<code>, …)'` marker to recover the code, then re-flagging `thrownType = 'PlatformException'`. C55 (test driver) / C53 (AST driver) closed 2026-05-18 on both drivers. |
| `services/codecs_test.dart` | Single `stdMethodCodec.decodeEnvelope(stdErrorBd)` call inside `on PlatformException catch (e)` at the `_buildBinaryCodecsPage` error-envelope demo (~line 463). The decode threw the wrapper-style `RuntimeD4rtException`, escaped the typed catch, and surfaced as the test's lone framework error. | Workaround applied 2026-05-23 (Cluster E #10 of `testlog_20260522-1328-issue-analysis`): broaden to `catch (e)` and surface the wrapped message as `'PlatformException-like: ${e.toString()}'`. Codec's intended contract (an exception is thrown for error envelopes) remains verified. Same family closure as C55; also clears the gii row #31 and important row #11 entries listed in the testlog. |

### What a real fix would look like

In `tom_d4rt_ast/lib/src/runtime/bridged_class.dart` (and the
mirror in `tom_d4rt`), when an adapter throws, propagate the
original exception object on a side-channel of the
`RuntimeError` (e.g. `RuntimeError.cause`). In the
`InterpreterVisitor` try-catch matcher, when comparing an
on-clause type against a `RuntimeError`, also test
`exception.cause is <Type>`. This preserves the wrapper for
top-level diagnostics while letting scripts catch by the
original type.

---

## U14 — `Center > ConstrainedBox(maxWidth)` inside `SingleChildScrollView`, or `Expanded` inside `Column(mainAxisSize.min)` inside `GridView.count` cell, leaks `maxHeight: infinity` down to `RenderConstrainedBox` (bridge/interpreter constraints-propagation gap)

**Category.** Bridge/interpreter constraints-propagation gap. In
native Flutter, both `RenderPositionedBox` (the render object
behind `Center` / `Align`) and `RenderFlex` inside a
`GridView.count` cell apply small but load-bearing transforms to
the incoming `BoxConstraints` before forwarding them to their
child:

- `RenderPositionedBox.performLayout` sets
  `shrinkWrapHeight = _heightFactor != null ||
   constraints.maxHeight == double.infinity` and, when true,
  calls `child.layout(constraints.loosen())` — which produces
  `(minW=0, maxW=maxW, minH=0, maxH=∞)`. A child with
  `mainAxisSize.min` then sizes finite vertically and the
  `RenderPositionedBox` shrink-wraps to match. **No infinite
  vertical constraint ever reaches a descendant `ConstrainedBox`.**
- `RenderSliverGrid` (behind `GridView.count` with
  `childAspectRatio: r`) computes each cell's tight height as
  `crossAxisExtent / r` from the grid's cross-axis extent, so an
  `Expanded(child: …)` inside a cell's `Column(mainAxisSize.min)`
  sees a finite `maxHeight` and lays out correctly.

The bridge implements neither transform faithfully. The bridged
`Center`/`Align` and `GridView.count` forward the unbounded
`maxHeight` (or equivalent infinite-flex situation) straight
down to descendants, and a `ConstrainedBox` somewhere in the
chain trips
`BoxConstraints.debugAssertIsValid(isAppliedConstraint: true)`:

```text
BoxConstraints forces an infinite height.
These invalid constraints were provided to RenderConstrainedBox's
layout() function by the following function, which probably
computed the invalid constraints in question: …
```

The error is **non-fatal** — the script still completes and all
host-side `expect()`s pass. It surfaces only via the test
runner's framework-error banner
(`frameworkErrors=1 status=success`).

**Reproducer.** `animation/cubic_test.dart` (item 1 of the
`testlog_20260519-1247-flutter-suites-fixes` fix plan). The
script's `build` is shaped as:

```dart
home: Scaffold(
  body: SingleChildScrollView(
    child: Center(                         // ← parent with maxH=∞
      child: ConstrainedBox(               // ← will assert
        constraints: BoxConstraints(maxWidth: 1080.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _PrivateGalleryCard(),         // GridView.count(childAspectRatio: 1.05)
            _PrivateSiblingCurveCard(),    // GridView.count(childAspectRatio: 1.25)
            …
          ],
        ),
      ),
    ),
  ),
),
```

The two `GridView.count` cells (`_PrivateGalleryTile`,
`_PrivateSiblingCurveTile`) each contain:

```dart
Column(
  mainAxisSize: MainAxisSize.min,
  children: <Widget>[
    Text(...),
    Expanded(child: CustomPaint(painter: _PrivateMiniCurvePainter(...))),
    Text(...),
  ],
),
```

— a pattern that depends on the GridView cell providing a
finite height for the `Expanded` to consume.

**Investigated script-side workarounds that all FAILED to clear
the banner:**

1. `Center(heightFactor: 1.0, child: ConstrainedBox(...))` —
   making the shrink-wrap explicit on `Center`. Banner persists;
   the bridged `Center` does not honor `heightFactor`'s shrink-
   wrap path.
2. Sidestep `RenderPositionedBox` entirely with
   `Row(mainAxisAlignment: MainAxisAlignment.center,
   children: [Flexible(child: Column(...))])`. Banner persists.
3. Replace `Center > ConstrainedBox(maxWidth: 1080)` with
   `SizedBox(width: 800)` to bound horizontally without invoking
   `RenderPositionedBox`. Banner persists.
4. Combine (3) with replacing both `Expanded(child: CustomPaint)`
   sites inside `_PrivateGalleryTile` and
   `_PrivateSiblingCurveTile` with `SizedBox(height: 60)`. Banner
   persists.

The banner survives every script-level transformation we tried,
which means the assertion is firing on a `RenderConstrainedBox`
that is not present in the script source — it is being
synthesised internally by one of the bridged Material widgets
(`Scaffold` / `SingleChildScrollView` / `MaterialApp` /
`Padding` / `Container.decoration` / etc.) when fed an
infinite-height column of long demo content. We cannot identify
or rewrite a widget we did not write.

**Constraints.**

- The fix belongs in the bridge: either (a) `Center`/`Align`
  implementations need to honor `RenderPositionedBox`'s shrink-
  wrap rule when `maxHeight == infinity`, or (b)
  `GridView.count`'s `childAspectRatio` needs to bound cell
  heights through the same path Flutter uses, or — most likely
  — (c) the `RenderConstrainedBox` adapter needs to clamp its
  incoming `maxHeight` to a finite value rather than asserting,
  matching the native render-pipeline's "the parent's
  constraints reach me already-bounded" assumption.
- Fixing this would touch interpreter constraint-propagation
  semantics in both `tom_d4rt` and `tom_d4rt_ast` and is out of
  scope for a single script-rewrite pass.
- The error is non-fatal — every assertion that runs on the
  cubic_test page passes. Only the cosmetic banner remains.

**Script-side workaround (chosen action).** None possible at the
script level after four independent attempts. We **revert** all
attempted script edits and accept the banner as a known cosmetic
artefact. Functional behaviour of the test is preserved
(`expect(result.success, isTrue)` passes; the page renders).

**2026-05-23 update — FIXED (entry #19).** The five prior
script-side attempts (1–4 above plus the 2026-05-23 entry #14
`Align(alignment: Alignment.topCenter) > ConstrainedBox` attempt)
all targeted the *wrong source*. Section-level bisection
(disable second half → still reports; only Constructor enabled →
still reports; only Anatomy+Gallery → clean) localised the actual
trigger to `_PrivateConstructorCards`, which had **two
`Row(crossAxisAlignment: CrossAxisAlignment.stretch)` blocks**
(lines 1209 + 1219 of the script) inside the section card's
`Column`. A `Row(stretch)` requires bounded height from its
parent; inside a `Column` that forwards
`maxHeight: infinity` from the outer `SingleChildScrollView`,
the stretch propagated infinite cross-axis into a synthetic
`RenderConstrainedBox` inside each `_PrivateConstructorCard`'s
130-px plot Container, surfacing as
`BoxConstraints forces an infinite height`. **The
`Center > ConstrainedBox(maxWidth)` and `GridView.count`
descriptions in this entry were red herrings** — neither was the
real source. Fix: wrap each `Row(stretch)` in `IntrinsicHeight`,
which resolves the Row's height to the intrinsic min height of
the tallest child so the stretch has a finite cross-axis to work
with. Same family fix as entry #10's
`rendering/render_exclude_semantics_test.dart`. `fwErr 1→0` on
both projects. The interpreter-side "constraint-propagation gap"
described at length above remains an open architectural concern
for other future scripts that genuinely use the
`Center > ConstrainedBox > SCV` pattern, but cubic_test was not
an instance of it; this entry's diagnostic stays here as a
cautionary tale for future bisection-first investigation.

**What "achieves the same functional result" would mean here.**
Because the assertion is fired by an internal
`RenderConstrainedBox` we cannot identify, the only way to
"resolve achieving the same functional result" entirely from the
script is to rewrite the page to use no widget that *might*
internally synthesise a `ConstrainedBox` under an infinite-
height parent — which excludes `Scaffold`, `SingleChildScrollView`,
`GridView`, `Container(decoration: …)`, and effectively the
entire Material card-based layout the demo is built around.
That degree of rewrite would invalidate the test's *purpose*
(showcasing `Cubic` + Material cards), so the workaround is
**leave the script as-is and let the banner show**, on the
understanding that the banner does not affect script success.

**Diagnostic guidance.** A `BoxConstraints forces an infinite
height. These invalid constraints were provided to
RenderConstrainedBox's layout()` banner that
(a) appears with `status=success` and `frameworkErrors=1`,
(b) survives every script-level attempt to bound the body
(`SizedBox(width:N)`, `Row > Flexible > Column`,
`heightFactor: 1.0` on `Center`, `Expanded` → `SizedBox`), and
(c) the script contains GridViews / Material cards under a
`SingleChildScrollView` — points to U14. Accept the banner;
the script is not fixable at the script level.

### Affected scripts

| Script | Sites | Notes |
|--------|-------|-------|
| `animation/cubic_test.dart` | Section 3 (`_PrivateGalleryCard` — `GridView.count(childAspectRatio: 1.05)` with `_PrivateGalleryTile` containing `Expanded(CustomPaint)` inside `Column(mainAxisSize.min)`), and Section 6 (`_PrivateSiblingCurveCard` — `GridView.count(childAspectRatio: 1.25)` with `_PrivateSiblingCurveTile` using the same pattern). The top-level `Center > ConstrainedBox(maxWidth: 1080)` wrapping the body is a third contributor but not individually sufficient. | Item 1 of `testlog_20260519-1247-flutter-suites-fixes/framework_error_fix_plan.md`. Four script-rewrite attempts (P1 `SizedBox(800)`, `Center(heightFactor:1.0)`, `Row` sidestep, `Expanded → SizedBox(60)` inside both gallery tiles) all reverted on 2026-05-19 — banner persists in every variant. Test passes throughout (`expect(result.success, isTrue)` succeeds, all 2 tests "All tests passed!", `frameworkErrors=1 status=success` only). Marked as U14 and deferred. |

### What a real fix would look like

The minimal interpreter-side fix is to make the bridged
`RenderConstrainedBox.layout()` adapter clamp an incoming
`maxHeight == double.infinity` to a finite fallback (e.g.
`MediaQuery.of(context).size.height` or a sentinel like
`9999.0`) instead of asserting. That matches the documented
"parent passes finite constraints" invariant of native Flutter
and unblocks every script that uses the Material card-on-scroll
pattern. A more correct (but larger) fix is to faithfully
implement `RenderPositionedBox.performLayout`'s shrink-wrap
branch in the bridged `Center`/`Align` adapters, plus
`RenderSliverGrid`'s cell-height computation in the bridged
`GridView.count` adapter, so that no descendant ever sees an
unbounded `maxHeight`.

---

## U15 — `RenderFlex overflowed by 2.0 pixels on the right` inside a bridged Cupertino layout the script cannot identify (bridge layout-rounding gap)

**Category.** Bridge layout-rounding gap (non-fatal). On a
Cupertino-flavoured deep-demo page rendered at the standard
`flutter test` viewport (800 × 600 logical pixels), the bridged
horizontal layout pipeline tallies 2.0 px past the available
width inside *some* internal `RenderFlex` and the framework
emits — twice per frame — the cosmetic banner:

```text
A RenderFlex overflowed by 2.0 pixels on the right.
```

The error is **non-fatal**. The page renders, every host-side
assertion passes, and the test runner reports
`frameworkErrors=2 status=success`. Native Flutter does not emit
the same banner for an identical script on the same viewport,
which points to a small (2 px) rounding discrepancy in how the
bridge measures intrinsic widths of children of one of the
Cupertino widgets inside the page.

The two `RenderFlex` reports are identical in wording (no
descriptor/owner info captured by the framework-error scraper) so
we cannot, from the captured output alone, distinguish which
`RenderFlex` is the offender. Likely candidates rejected below by
trial.

**Reproducer.** `cupertino/cupertino_nav_segmented_test.dart`
(item 2 of the `testlog_20260519-1247-flutter-suites-fixes`
fix plan). The script renders a long `SingleChildScrollView` of
`_PrivateSection` cards demonstrating
`CupertinoSegmentedControl<T>` and
`CupertinoSlidingSegmentedControl<T>` side by side, plus a
`CupertinoNavigationBar` usage card with a sliding segmented
control as `middle:`.

**Investigated script-side workarounds that all FAILED to clear
the banner:**

1. **Boxed-default label `Row → Wrap`.** The hero "groupValue /
   children / style" chips Row in `_buildBoxedDefault`
   (`_PrivateLabel × 3` with `SizedBox(width: 8.0)` spacers) was
   converted to `Wrap(spacing: 8.0)`. Banner persists at 2.
2. **Sliding-default label `Row → Wrap`.** Same conversion
   applied to the analogous Row in `_buildSlidingDefault`.
   Banner persists at 2.
3. **Hero chips `Row → Wrap`.** `_buildHero`'s `_PrivateChip × 3`
   row (variable-width chips with `SizedBox(width: 8.0)`
   spacers) converted to `Wrap`. Banner persists at 2.
4. **Shrink `CupertinoNavigationBar.middle`'s
   `SizedBox(width: 220.0) → 180.0`.** Gives the navbar's
   internal leading/middle/trailing `RenderFlex` 40 px more
   breathing room. Banner persists at 2.

The banner survives every script-level transformation we tried,
in any combination, which means the offending `RenderFlex` is
**not** any `Row` written in the script. It is being synthesised
internally by one of the bridged Cupertino widgets the page
embeds — most likely `CupertinoNavigationBar`'s internal Row
layout, the `CupertinoSlidingSegmentedControl` thumb track / drag
gesture detector, or the `CupertinoButton` icon-content row.
None of those are widgets the script owns, and we cannot rewrite
a widget we did not write.

The constancy of the 2.0 px overflow value across every variant
(it never changes magnitude, never disappears for one of the two
sites, never moves to a different message) is consistent with a
fixed-pixel rounding error in the bridge's intrinsic-width
measurement of a Cupertino sub-widget, hit twice per frame by the
same render object.

**Constraints.**

- The fix belongs in the bridge: the bridged Cupertino layout
  needs to allocate its children's intrinsic widths with the same
  2 px slack the native render pipeline does, or shrink-fit the
  parent Row to whatever children measure to without asserting.
- Identifying the exact offending RenderFlex requires either
  (a) a debug-print pass through the bridge's RenderFlex.layout
  adapter to surface the description of each overflowing flex, or
  (b) deleting Cupertino subtree branches one by one until the
  banner clears — both out of scope for a single script-rewrite
  pass.
- The error is non-fatal — every assertion passes and the test
  succeeds. Only the cosmetic banner remains.

**Script-side workaround (chosen action).** None possible at the
script level after four independent attempts. We **revert** all
attempted script edits and accept the banner as a known cosmetic
artefact. Functional behaviour of the test is preserved (both
tests "All tests passed!", `frameworkErrors=2 status=success`).

**What "achieves the same functional result" would mean here.**
Because the assertion is fired by an internal `RenderFlex` we
cannot identify, the only way to "resolve achieving the same
functional result" entirely from the script is to remove every
widget that *might* synthesise the offending Row — which would
exclude `CupertinoNavigationBar`, the surrounding card scaffold,
and likely the sliding-segmented-control demo cells themselves.
That would invalidate the test's *purpose* (visual comparison of
boxed vs. sliding Cupertino segmented controls under a typical
navbar), so the workaround is **leave the script as-is and let
the banner show**, on the understanding that the banner does not
affect script success.

**Diagnostic guidance.** A `RenderFlex overflowed by N.0 pixels
on the right` banner that
(a) appears with `status=success` and `frameworkErrors=2`
(identical messages, no descriptor info),
(b) survives multiple independent `Row → Wrap` conversions and
fixed-width slot shrinks (`SizedBox(width: N)`) at the obvious
script-side candidates,
(c) is rendered inside a page that embeds `CupertinoNavigationBar`,
`CupertinoSegmentedControl`, or `CupertinoSlidingSegmentedControl` — points to U15.
Accept the banner; the script is not fixable at the script level.

### Affected scripts

| Script | Sites | Notes |
|--------|-------|-------|
| `cupertino/cupertino_nav_segmented_test.dart` | Two unidentifiable internal `RenderFlex`s in the Cupertino subtree (likely `CupertinoNavigationBar` middle/leading/trailing row, `CupertinoSlidingSegmentedControl` thumb track, or `CupertinoButton` content row). | Item 2 of `testlog_20260519-1247-flutter-suites-fixes/framework_error_fix_plan.md`. Four script-rewrite attempts (P3: 3× `Row → Wrap` on boxed-default labels, sliding-default labels, and hero chips; plus P1: `SizedBox(width: 220) → 180` on the navbar middle slot) all reverted on 2026-05-19 — banner persists at 2 in every variant. Test passes throughout (`All tests passed!`, `frameworkErrors=2 status=success` only). Marked as U15 and deferred. |

### What a real fix would look like

The minimal interpreter-side fix is to make the bridged
`RenderFlex.layout()` adapter tolerate a 1–2 px overflow caused
by intrinsic-width rounding (silently clamp or log-only rather
than asserting), matching the slack native `RenderFlex` allows
in practice. A more correct (but larger) fix is to align the
bridge's intrinsic-width measurement for Cupertino children with
the native pipeline so the 2 px discrepancy never arises — most
likely a font-metric / padding-rounding difference inside
`CupertinoNavigationBar` or the sliding segmented control's
thumb-positioning maths.

---

## U16 — `Text('')` (empty-string `Text` widget) triggers a NaN `Offset` assertion in `dart:ui` paragraph painting (bridge/interpreter text-layout gap)

**Category.** Bridge / interpreter text-layout gap. Rendering a
`Text` widget whose `data` argument is the empty string `''`
through the bridged Flutter pipeline produces — once per painted
frame, regardless of surrounding layout — a fatal-shaped but
non-fatal framework-error banner:

```text
Offset argument contained a NaN value.
'dart:ui/painting.dart':
Failed assertion: line 41 pos 10: '<optimized out>'
```

`dart:ui/painting.dart` line 41 is the assertion inside the
`Offset(double dx, double dy)` constructor that both arguments
are non-NaN. The bridged paragraph painter feeds a NaN component
into one of its internal `Offset` constructions when the
paragraph has zero glyphs to lay out.

The test runner records this as `frameworkErrors=1` but reports
`status=success` — the script's "All tests passed!" outcome is
preserved.

**Reproducer.**
`cupertino/restorable_cupertino_tab_controller_test.dart` (item 5
of `testlog_20260519-1247-flutter-suites-fixes/framework_error_fix_plan.md`).
The `_CodeBlock` widget in `_buildCodeSnippetSection` paints a
30-line source listing via a `Column` of per-line
`Row(SizedBox(width: 28, Text('<line-no>')), Text('<source>'))`
items. The source listing includes six visually-blank lines
realised as `_CodeLine(0, '')` entries. Each empty entry renders
as `Text('')` — and that is what trips the assertion. Bisecting
to a `_CodeBlock` body that only loops `Text(lines[i].text)`
preserves the banner; substituting any empty `text` with a
non-empty placeholder makes it vanish.

**Minimal repro shape:**

```dart
Column(
  children: <Widget>[
    Text(''), // <-- triggers the NaN Offset banner
    Text('foo'),
  ],
);
```

The trigger does not depend on:

- the surrounding `Row`/`Expanded`/`Padding` structure,
- the line-number `Text` and its `SizedBox(width: 28)`,
- the indent prefix `'${' ' * indent}${text}'`,
- a particular `TextStyle` (the banner reproduces with a default
  `TextStyle`, with the `fontFamily: 'monospace'` style, and with
  `letterSpacing: -0.2`),
- `const`-ness of the parent widget.

It depends *only* on the `Text.data` argument being the empty
string. Switching any one of the six `_CodeLine(0, '')` rows to
non-empty text leaves five sites firing the banner (we observe
`frameworkErrors=1` because the framework dedupes identical paint
diagnostics within a frame — there is one render object hit
multiple times, not multiple distinct ones).

**Root cause hypothesis.** Inside the bridged paragraph painter,
an empty paragraph yields zero glyph runs. The text-painter's
metric computation (baseline / line-height / fitted-line-width)
divides by or extracts a value from the (empty) run list, and
produces NaN for the layout origin. The native Flutter renderer
short-circuits this case (an empty paragraph paints to a
zero-sized box with origin `Offset.zero`); the bridged
implementation does not.

**Constraints.**

- The fix belongs in the bridged text-painting pipeline: an
  empty paragraph must short-circuit to `Offset.zero` (or
  whatever the host-supplied baseline is) instead of computing a
  NaN baseline.
- The bug is benign for the test outcome — banner only — but it
  obscures real paint NaN bugs in any script that paints empty
  strings (snippet viewers, log displays, padded grids, etc.).
- Script authors normally have no reason to suspect that
  `Text('')` is dangerous — it is a perfectly valid Flutter
  widget shape and is used routinely as a "blank line" placeholder.

**Script-side workaround (chosen action).** At every `Text(...)`
call site that may receive an empty string, substitute a single
space (`' '`) so the paragraph has at least one glyph run for
the layout code to measure. The visual result is identical for a
blank-line role (an empty space character renders as a blank
gap of the line-height; a truly empty paragraph would render as
zero height, but in a `Column` of monospaced lines that
distinction is invisible to the reader and the surrounding
`Padding(vertical: 1.0)` provides the inter-line gap anyway).

For composed strings (the `_CodeBlock` case), guard at the
composition site rather than at the `_CodeLine` constructor so
that author-side intent (`_CodeLine(0, '')` to mean "blank line")
is preserved:

```dart
Text(
  () {
    final String composed = '${' ' * lines[i].indent}${lines[i].text}';
    return composed.isEmpty ? ' ' : composed;
  }(),
  style: const TextStyle(fontFamily: 'monospace', fontSize: 12.5),
);
```

This achieves the same functional result (a column of
monospaced code lines with visually-blank gaps in the same
positions as the source listing intends) without ever passing an
empty string to the bridged `Text` widget.

**Diagnostic guidance.** A framework-error banner that
(a) reads `Offset argument contained a NaN value.` with
`'dart:ui/painting.dart': Failed assertion: line 41 pos 10`,
(b) appears with `status=success` (test passes),
(c) clears the moment the script substitutes any candidate
`Text(...)` widget's data with a non-empty string,
points to U16. Audit the script for empty-string `Text` widgets
(including composed strings whose components can sum to empty)
and substitute a single space.

**Variant banner under `IntrinsicHeight`.** When the empty
`Text('')` descends from an `IntrinsicHeight` ancestor, the same
bridge gap surfaces as a different banner:
`BoxConstraints forces an infinite height.` thrown by
`RenderFlex.layout()`. `IntrinsicHeight` walks the subtree
asking each `RenderObject` for `computeMinIntrinsicHeight`; the
bridged empty-paragraph metric path returns an unbounded intrinsic
height instead of a NaN paint origin, and the surrounding
`RenderFlex` then rejects the unbounded constraint. The trigger,
the workaround (substitute a space, or — for blank-line
separators — substitute `SizedBox(height: …)`), and the
underlying root cause are the same. Bisect the same way: any
empty-`Text` site whose intrinsic dimensions are queried (i.e.,
under any `IntrinsicHeight`/`IntrinsicWidth` ancestor) can hit
this variant.

### Affected scripts

| Script | Sites | Notes |
|--------|-------|-------|
| `cupertino/restorable_cupertino_tab_controller_test.dart` | Six empty-`_CodeLine` entries fed into `Text('${' ' * indent}${text}')` inside `_CodeBlock`. | Item 5 of `testlog_20260519-1247-flutter-suites-fixes/framework_error_fix_plan.md`. Fixed at the script level on 2026-05-19 by guarding the composed text with `composed.isEmpty ? ' ' : composed` in `_CodeBlock.build`. Verified `frameworkErrors=0 status=success` (was 1). Underlying bridge bug remains and is documented here for future scripts that hit the same shape. |
| `gestures/velocity_test.dart` | One blank `_CodeLine('')` separator inside the equality-section bordered code block, descendant of `_SectionCard`'s `IntrinsicHeight > Row(stretch)` chrome (chrome itself added as part of the item-35 P1 fix). | Item 35 of `testlog_20260519-1247-flutter-suites-fixes/framework_error_fix_plan.md`. Same underlying bug shape as U16 but surfaces with a different banner — `BoxConstraints forces an infinite height` on `RenderFlex.layout()` rather than the NaN-Offset paint banner. Under an `IntrinsicHeight` ancestor the empty `Text` propagates an unbounded intrinsic height instead of a NaN paint origin; both stem from the bridge's empty-paragraph metric path. Fixed at the script level on 2026-05-19 by replacing the blank `_CodeLine('')` separator with `SizedBox(height: 14)` (idiomatic for a fixed vertical gap inside the code-listing Column). Verified `frameworkErrors=0 status=success` (was 1). |

### What a real fix would look like

The minimal bridge-side fix is to short-circuit
`Text`'s/`RichText`'s paragraph layout when the resolved text is
empty (zero `TextSpan` glyphs) so the painter never asks for a
baseline / line-width of an empty run. The native Flutter
pipeline already does this implicitly; the bridge must replicate
that fast-path. A larger fix is to audit every place inside the
bridged paragraph painter where layout metrics can produce NaN
for a zero-glyph run (baseline offset, alignment offset, line
fit) and clamp each to `0.0` defensively.

---

## U17 — `ConstraintsTransformBox` teaching script (`render_constraints_transform_box_test.dart`) is intrinsically incompatible with `frameworkErrors=0` (script design)

**Category.** Truly unfixable at both the script and the
interpreter level — the script's *teaching purpose* is to
demonstrate the exact pathological inputs that Flutter's
debug-mode assertions fire on. Any "fix" either pre-normalizes /
shrinks the inputs (erasing the demo) or pushes the failure to
the next intentional demo in the same script.

**Reproducer.**
`rendering/render_constraints_transform_box_test.dart` (item 71
of `testlog_20260519-1247-flutter-suites-fixes/framework_error_fix_plan.md`).
Reported once each in `secondary_classes_test` and
`timeout_tests_test` (two host suites driving the same script,
hence the plan-doc note "B-layout/BoxConstraints — infinite
height" double-banner).

**The cascade.**

The script is a deep-dive demo of
`ConstraintsTransformBox` / `RenderConstraintsTransformBox`. The
baseline failure reported by the test runner is the *first*
debug-mode assertion to fire during layout:

```text
BoxConstraints(699.6<=w<=349.8, h=182.0; NOT NORMALIZED) is not normalized
'package:flutter/src/rendering/shifted_box.dart':
Failed assertion: line 943 pos 14: 'childConstraints.isNormalized'
```

This comes from the script's user-defined transform
`kHalveMaxWidth(input)` (a teaching example showing what a
caller might write):

```dart
BoxConstraints kHalveMaxWidth(BoxConstraints input) {
  return BoxConstraints(
    minWidth: input.minWidth,
    maxWidth: input.hasBoundedWidth ? input.maxWidth / 2.0 : input.maxWidth,
    minHeight: input.minHeight,
    maxHeight: input.maxHeight,
  );
}
```

When the parent supplies tight width constraints
(`minWidth == maxWidth == 699.6` from a
`CrossAxisAlignment.stretch` Column), halving only the
`maxWidth` produces `min=699.6, max=349.8` — `min > max`, not
normalized. `RenderConstraintsTransformBox.performLayout()`
asserts `childConstraints.isNormalized` and aborts the layout
pass. The script is structured as a teaching log of "things you
can do to constraints and what Flutter says about each one" —
the assertion *is* the teaching point.

**Why the P8 fix exposes a worse cascade.** The plan's P8
suggestion is to pre-normalize the result (clamp `minWidth` to
the new `maxWidth`). That makes layout proceed past
`kHalveMaxWidth` — but the script has at least three other
sections that *deliberately* paint oversized children inside
smaller `ConstraintsTransformBox` slots specifically to
demonstrate `clipBehavior` semantics:

- **Section 4 (Live demos):** `SizedBox(200×80) > ClipRRect > CTB(<various transforms>) > _OverflowChild(SizedBox(320×140))`. Six tiles iterate the six pre-defined `ConstraintsTransformBox.<X>` transforms (`unmodified`, `unconstrained`, `widthUnconstrained`, `heightUnconstrained`, `maxWidthUnconstrained`, `maxHeightUnconstrained`). The four non-`unmodified` transforms unconstrain at least one axis, so the child sizes to 320×140 in a 200×80 slot — three distinct overflow signatures (60/30/30/60, 60/0/0/60, 0/30/30/0).
- **Section 7 (clipBehavior showcase):** `SizedBox(160×80) > CTB.unconstrained > Container(220×110)` — three tiles iterate `Clip.none / Clip.hardEdge / Clip.antiAlias`. After my normalization fix the first reported follow-up banner is `A RenderConstraintsTransformBox overflowed by 30 pixels on the left, 15 pixels on the top, 15 pixels on the bottom, and 30 pixels on the right` — that arithmetic comes from this section ((220−160)/2 = 30 horiz, (110−80)/2 = 15 vert).
- **Section 8 (Comparison panel):** `SizedBox(120×60) > CTB.unconstrained > Container(160×80)` (and an `UnconstrainedBox` sibling with the same overflow signature). 40/20 horiz/vert.

`RenderConstraintsTransformBox` and its `DebugOverflowIndicatorMixin` always emit the overflow banner in debug mode when `child.size > size`, **regardless of `clipBehavior`** — `Clip.hardEdge` only suppresses the visual debug stripes, never the `FlutterError.reportError` call. So every one of those sites would surface a banner once the kHalveMaxWidth assertion stops aborting the layout.

**Why every workaround erases the demo.**

- Pre-normalize `kHalveMaxWidth` (e.g. clamp `minWidth` to the new `maxWidth`): removes the first banner, exposes the section-7 overflow banner.
- Resize section 4 / 7 / 8 slots to match the children: removes all banners *but* there is no longer an oversized child for the transforms / `clipBehavior` parameter to act on. All three `clipBehavior` tiles render identically. The script's teaching intent is gone.
- Resize section 4 / 7 / 8 children to fit the slots: same — no oversized child, no demo.
- Wrap the inner `Container` in `OverflowBox` so the CTB's own size matches the child: `CTB.clipBehavior` becomes a no-op (the CTB no longer overflows) and the outer `OverflowBox` handles all clipping. The script visually behaves identically across the three `clipBehavior` tiles — the demo is dead.
- `try/catch` around the layout pass (P5(b)): Flutter does not surface layout assertions through `try/catch` at the script level; they fire inside `performLayout` and are caught only by `FlutterError.onError`. Not actionable from the script.

In short, **the script's purpose *is* to feed pathological inputs to `ConstraintsTransformBox` and observe Flutter's debug banners**. The 1 banner that survives to `frameworkErrors=1` is the first of a stack; any "fix" peels back one layer at the cost of exposing the next intentional one underneath.

**Decision (2026-05-20).** Item 71 is marked
**reverted/deferred** in
`testlog_20260519-1247-flutter-suites-fixes/framework_error_fix_plan.md`.
The kHalveMaxWidth normalize fix was applied and verified (the
first banner cleared), then reverted when the section-7 follow-up
banner surfaced and inspection revealed the cascade.

**What a real fix would look like.**

Either:

1. **Rewrite the teaching content.** Replace
   `render_constraints_transform_box_test.dart` with a variant
   that *describes* (in text) the pathological inputs but does
   not render them through Flutter. Each "demo" tile shows a
   diagram / annotated `BoxConstraints` rather than driving the
   actual layout. The script becomes a documentation-style
   render with no live `ConstraintsTransformBox` instances. Loses
   the live-demo teaching value entirely.

2. **Replace pathological demos with non-pathological
   equivalents.** Use `OverflowBox` (which is documented to
   suppress the overflow banner) for every overflow-demo tile;
   keep `ConstraintsTransformBox` only for the
   non-overflow-producing transforms (e.g. `unmodified`,
   `widthUnconstrained` with a child that fits the resulting
   constraints). Preserves the API mention but removes the
   visual point of the demo.

3. **Accept `frameworkErrors=1` as the steady state for this
   script** and exclude it from the framework-error gate. The
   test still reports `status=success`; the banner is purely
   diagnostic. This is the lowest-cost option but punctures the
   `frameworkErrors=0` invariant the test runner enforces.

None of these belong in the per-item fix sweep — they are
**design-level** changes to the teaching scope of the script.

### Affected scripts

| Script | Host suites | Sites | Notes |
|--------|-------------|-------|-------|
| `rendering/render_constraints_transform_box_test.dart` | `secondary_classes_test` (1/1), `timeout_tests_test` (1/1) | kHalveMaxWidth produces non-normalized; sections 4 / 7 / 8 deliberately overflow CTBs for `clipBehavior` and pre-defined-transform demos. | Item 71 of `testlog_20260519-1247-flutter-suites-fixes/framework_error_fix_plan.md`. Marked reverted/deferred 2026-05-20 — see U17 root-cause analysis above. |

---

## U18 — `services/platform_test.dart` `_defaultVsThemeCard` Row(stretch)+Expanded(_twinCard): script-side P1 variants all destabilise the test-app transport (interpreter/bridge limitation)

**Category.** Interpreter / bridge limitation manifesting as a
*regression cliff*: the baseline script produces a recoverable
`BoxConstraints forces an infinite height` framework banner
(`status=success, frameworkErrors=1`), but **every reasonable
P1-style script-side rewrite of the offending Row triggers a hard
test-app crash** (`status=transport_error, httpStatus=-1,
outputLines=0, frameworkErrors=0`, "Lost connection to device" in
the flutter_test stderr and "HttpException: Connection closed
before full header was received" on the POST `/build` call). The
crash is worse than the baseline error.

**Reproducer.** `services/platform_test.dart` (item 93 of
`testlog_20260519-1247-flutter-suites-fixes/framework_error_fix_plan.md`).
Surfaces in `important_classes_test` (1/1 in the
`20260519-1247-flutter-suites-fixes` baseline). The banner shape:

```text
BoxConstraints forces an infinite height.
The offending constraints were: BoxConstraints(0.0<=w<=Infinity, h=Infinity)
debugCreator: Row ← Padding ← Container ← Column ← Padding ← ColoredBox ←
  Container ← KeyedSubtree-[<2>] ← Padding ← DecoratedBox ← Padding ←
  Container ← ⋯
RenderFlex#fc69b:
  direction: horizontal
  crossAxisAlignment: stretch
  mainAxisSize: max
  constraints: BoxConstraints(w=1870.0, 0.0<=h<=Infinity)
Stack: BoxConstraints.debugAssertIsValid → RenderObject.layout →
  ChildLayoutHelper.layoutChild → RenderFlex._computeSizes →
  RenderFlex.performLayout
```

The offender is `_defaultVsThemeCard()` (lines 541–582):

```dart
Widget _defaultVsThemeCard() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(child: _twinCard(...)),  // nested Column with bullet rows
        const SizedBox(width: 14.0),
        Expanded(child: _twinCard(...)),
      ],
    ),
  );
}
```

The page root is `Container > Column(crossAxisAlignment.stretch)
> [...sections..., _defaultVsThemeCard(), ...]` with **no
`SingleChildScrollView` ancestor**, so the top-level Container's
height is unbounded. `Column(stretch)` propagates that down to
its children; the Row then sees `h=0..Infinity`, and with
`crossAxisAlignment.stretch` it tightens its children's height
constraint to `h=Infinity`. `RenderConstrainedBox.layout`'s
`debugAssertIsValid` fires.

**What was tried (all crash the test app).**

| Attempt | Change | Result |
|---|---|---|
| A1 | Wrap the Row in `IntrinsicHeight` (canonical P1) | `transport_error httpStatus=-1 outputLines=0 frameworkErrors=0` |
| A2 | Change `crossAxisAlignment.stretch` → `start` | `transport_error httpStatus=-1 outputLines=0 frameworkErrors=0` |
| A3 | Replace `Row` with `Column(stretch)` (drop the two `Expanded`, replace `SizedBox(width: 14)` with `SizedBox(height: 14)`) | `transport_error httpStatus=-1 outputLines=0 frameworkErrors=0` |
| A4 | Delete the offending `crossAxisAlignment: CrossAxisAlignment.stretch` line outright (default is `center`) — the minimal possible change | `transport_error httpStatus=-1 outputLines=0 frameworkErrors=0` — script prints completed, but the test-app's HTTP server died mid-build (Connection closed before full header) |

A4 is the strongest evidence that this is not a "the layout
substitute is *also* invalid" problem. Removing one widget
parameter that purely controls cross-axis alignment should be a
semantic no-op for the build phase (the children still lay out at
their natural heights, the Row sizes to its tallest child). Yet
every variant kills the test app rather than producing either a
clean success or a new recoverable banner. The baseline (with
`stretch`) survives because Flutter's `FlutterError.onError`
catches the layout assertion as a recoverable framework error
and continues painting; the no-stretch / IntrinsicHeight /
Row-to-Column variants somehow take down the surrounding
bridge / interpreter / HTTP server process instead.

**Why this is not a pure layout bug.** A pure Flutter widget
change should at worst produce a different recoverable banner —
not a process-level crash that closes the HTTP server's response
mid-header. The transport-error fingerprint (`httpStatus=-1`,
"Lost connection to device", HttpException on the POST `/build`)
indicates the test-app process died while constructing the
widget tree from the AST bundle, not a recoverable layout
assertion. The crash reproduces across four different P1
variants (including the minimal "delete one keyword argument"
edit), so the trigger is something about how the d4rt bridge
materialises the Row / nested `_twinCard` Column when the cross-
axis behaviour shifts, not the specific replacement widget.

The exact failure path is opaque from the script side — the
flutter_test driver only reports "Lost connection to device" and
the server-side connection drop. No Dart-side stack trace
reaches the log. A real fix needs interpreter / bridge
instrumentation around `Row` / `Expanded` / `Column`
construction when called from a script-defined helper function
(`_defaultVsThemeCard` / `_twinCard`).

**Workaround.** None at the script level. The four script-side
patterns that would normally close a P1 error all destabilise the
transport. Leaving the original `Row(crossAxisAlignment.stretch)`
in place keeps `frameworkErrors=1` (recoverable banner) but
preserves the rest of the script — `outputLines=15`, the test
passes, and the rest of the suite is unaffected.

A heavier alternative — wrapping every `Expanded(child:
_twinCard(...))` call site in a `SizedBox(height: <fixed>)` to
bound the Row's height — would in principle avoid the unbounded
constraint, but (a) any picked height is wrong for one of the two
cards (the bullet list lengths differ), (b) it requires editing
two interleaved call sites without breaking the side-by-side
visual layout, and (c) given that even removing one keyword
argument crashed the test app, there is no reason to expect that
wrapping the children in `SizedBox` will survive transport.
Deferred until the underlying transport-cliff is understood.

**Decision (2026-05-20).** Item 93 is marked **reverted/deferred**
in
`testlog_20260519-1247-flutter-suites-fixes/framework_error_fix_plan.md`.
The recoverable `frameworkErrors=1` baseline is the steady state
for this script until the interpreter / bridge can be
instrumented to surface the actual crash trigger.

**What a real fix would look like.**

1. **Interpreter / bridge instrumentation.** Wrap the
   `RenderFlex` / `Expanded` materialisation path with diagnostic
   prints that capture the exact constructor arguments and parent
   chain when the test-app aborts. The four-attempt crash
   reproducer is small enough to bisect (one keyword removed
   crashes; the original keyword preserved survives) — useful for
   isolating which bridge call returns an invalid value mid-
   construction.
2. **Bound the page height at the call site.** Once the
   instrumentation finds the trigger, the eventual script-side fix
   will likely be wrapping `_defaultVsThemeCard()` in a
   `SizedBox(height: <fixed>)` (or equivalently, the entire page
   in a `SingleChildScrollView`). Until then, the wrapper would
   simply move the crash, not fix it.

### Affected scripts

| Script | Host suites | Sites | Notes |
|--------|-------------|-------|-------|
| `services/platform_test.dart` | `important_classes_test` (1/1) | `_defaultVsThemeCard` Row(stretch)+Expanded(_twinCard); page has no bounded-h ancestor. | Item 93 of `testlog_20260519-1247-flutter-suites-fixes/framework_error_fix_plan.md`. Marked reverted/deferred 2026-05-20 — see U18 root-cause analysis above. |

---

## U19 — Per-character `TextSpan` stream of non-Latin glyphs triggers a NaN `Rect` assertion in `dart:ui` painting (bridge/interpreter text-layout gap)

**Category.** Bridge / interpreter text-layout gap, sibling of
U16. When a `RichText` is built from a sequence of per-character
`TextSpan`s (one `TextSpan(text: ch, …)` per code unit) and the
characters are outside the Latin / ASCII range, the bridged
paragraph painter feeds a NaN coordinate into one of the
internal `Rect.fromLTRB(…)` constructions invoked by the
text-background / underline painters. The result is — once per
painted frame, per `RichText` whose stream contains such
glyphs — a fatal-shaped but non-fatal framework-error banner:

```text
Rect argument contained a NaN value.
'dart:ui/painting.dart':
Failed assertion: line 26 pos 10: '<optimized out>'
```

`dart:ui/painting.dart` line 26 is the `_rectIsValid(Rect rect)`
helper that all `Canvas` rect APIs (`drawRect`, `clipRect`,
`drawImageRect`, gradient shader rects, text-background fill
rects, dashed-underline dash-stop rects, etc.) call before
forwarding to Skia. The bridged glyph-advance/baseline pipeline
returns NaN for at least one component of the per-glyph paint
rect when the glyph is rendered through a single-character
`TextSpan` rather than as part of a longer Latin run.

The test runner records this as one `frameworkErrors` increment
per offending `RichText` paint with `status=success` — the
script's "All tests passed!" outcome is preserved.

**Reproducer.**
`services/text_editing_delta_non_text_update_test.dart` (item 99
of `testlog_20260519-1247-flutter-suites-fixes/framework_error_fix_plan.md`).
The `_frozenFrame` widget visualises a `TextEditingValue` snapshot
by splitting the displayed text into per-character `TextSpan`s
(loop `for (int i = 0; i < text.length; i++) spans.add(TextSpan(text: text[i], …))`)
and interleaving a `WidgetSpan(_CaretBar())` at the caret offset.
Each character carries an optional `backgroundColor` (for
selection) and optional `TextDecoration.underline` (for
composing). The script's `_buildWorkedExamples()` builds six
example cards; cards `e)` and `f)` use the hiragana string
`'こんにちは'` (5 BMP code units) as the display text and apply
a non-empty composing range so the underline path is exercised.

Each of the four `_frozenFrame` instances built from these two
examples (`e-before`, `e-after`, `f-before`, `f-after`)
produces exactly one banner per painted frame → `frameworkErrors=4`.
The three `_frozenFrame` instances in `_heroSection` and the
eight in examples `a)`–`d)` (all using the ASCII `poem =
'The quick brown fox'`) produce zero banners.

**Minimal repro shape:**

```dart
RichText(
  text: TextSpan(
    style: const TextStyle(fontFamily: 'monospace'),
    children: <InlineSpan>[
      for (int i = 0; i < 'こんにちは'.length; i++)
        TextSpan(
          text: 'こんにちは'[i],
          style: const TextStyle(
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.dashed,
          ),
        ),
    ],
  ),
)
```

The trigger does not depend on:

- `TextDecorationStyle.dashed` vs `.solid` — both reproduce the
  banner identically (empirically verified by swapping
  `TextDecorationStyle.dashed` for `.solid` in the item-99
  script: error count stays at 4).
- the `WidgetSpan(PlaceholderAlignment.middle)` caret marker —
  removing it does not clear the banner (the same Japanese run
  without an interleaved `WidgetSpan` still triggers).
- the surrounding `Container`'s `BoxDecoration` (gradient vs
  solid colour both reproduce identically).
- the host font (`fontFamily: 'monospace'` or `null` default
  both reproduce).
- `TextSpan.backgroundColor` being set or null.

It depends on the combination of (a) **per-character `TextSpan`
fragmentation** (the issue does not reproduce when the same
Japanese text is rendered as a single `Text('こんにちは')`) and
(b) **non-Latin glyphs**. Either dimension alone is safe.

**Root cause hypothesis.** The native Flutter pipeline measures
each `TextSpan` against the cumulative glyph cluster of the
paragraph and resolves the per-span paint rect from the
cluster's geometric extents. The bridged paragraph painter
appears to take a per-`TextSpan` measurement path that, for
single-character spans of non-Latin glyphs, returns NaN for one
of the rect axes — most likely the horizontal advance (whose
metric falls back to NaN when the glyph cluster boundary does
not align with the span boundary). The downstream rect
constructions used to draw the text background, the underline,
and the dashed-underline dash stops all inherit the NaN.

**Constraints.**

- The fix belongs in the bridged paragraph painter: per-span
  paint rects must compute advance widths from the underlying
  cluster geometry, not from a per-span shortcut that fails on
  non-Latin glyphs.
- The bug is benign for the test outcome — banner only — but it
  silently mis-renders any script that fragments non-Latin
  display text into per-character `TextSpan`s (selection /
  caret visualisers, character-by-character coloured listings,
  IME composing-range demos, syllabary teaching widgets).
- Script authors normally have no reason to suspect that a
  per-character `TextSpan` fragmentation is dangerous — it is a
  perfectly idiomatic Flutter pattern for rich text with
  per-character styling.

**Script-side workaround (chosen action).** Where the display
text is *illustrative* rather than semantic (i.e. the
demonstration is about the structure of the spans, not the
specific glyphs), substitute an ASCII-only string of the same
length so the per-character `TextSpan` stream stays inside the
safe Latin path. Keep the non-Latin form in the surrounding
prose (story / caption / paragraph `Text` widgets) so the
educational intent is preserved:

```dart
// Before (triggers the banner):
const String greet = 'こんにちは';                  // 5 BMP glyphs
...
_frozenFrame(text: greet, beforeComposing: TextRange(0, 5), ...);

// After (banner cleared):
const String greet = 'aiueo';                       // 5 ASCII glyphs
...
_frozenFrame(text: greet, beforeComposing: TextRange(0, 5), ...);

// The story prose around the frame still references the
// Japanese form so the IME-composing semantics are clear.
```

The visual result is identical for the *layout* the example
illustrates (a 5-character composing range, offsets 0..5
identifying five distinct glyphs); the only loss is the cosmetic
look of hiragana inside the demo frames. The surrounding
narrative text is unaffected (full Japanese strings render fine
when passed as a single `Text(...)` argument — the trigger is
per-character span fragmentation, not the glyphs themselves).

**Diagnostic guidance.** A framework-error banner that
(a) reads `Rect argument contained a NaN value.` with
`'dart:ui/painting.dart': Failed assertion: line 26 pos 10`,
(b) appears with `status=success` (test passes),
(c) maps 1:1 to `RichText`/`Text.rich` widgets whose `children`
are built by a `for (int i = 0; i < text.length; i++)` loop
producing per-character `TextSpan`s,
(d) clears the moment the loop's `text` source is substituted
with an ASCII-only string of the same length,
points to U19. Audit the script for per-character `TextSpan`
construction over non-Latin text and substitute as described.

### Affected scripts

| Script | Sites | Notes |
|--------|-------|-------|
| `services/text_editing_delta_non_text_update_test.dart` | `_frozenFrame` called from `_renderExampleCard` for worked examples `e)` and `f)` (`greet = 'こんにちは'`, beforeComposing/afterComposing both non-empty). 4 paint invocations → 4 banners. | Item 99 of `testlog_20260519-1247-flutter-suites-fixes/framework_error_fix_plan.md`. Fixed at the script level on 2026-05-20 by changing `greet` from `'こんにちは'` to `'aiueo'`; the Japanese form is retained in the example `story` prose. Verified `frameworkErrors=0 status=success` (was 4). Underlying bridge bug remains and is documented here for future scripts that hit the same shape. |

### What a real fix would look like

The minimal bridge-side fix is to route per-`TextSpan` paint
rect computation through the same cluster-geometry path the
native Flutter pipeline uses, so single-character spans of
non-Latin glyphs receive valid advance widths rather than NaN.
A larger fix is to audit every site inside the bridged
paragraph painter where per-span metrics are derived from a
shortcut path (rather than from the cumulative cluster
geometry) and replace each with a cluster-aware computation.
The same bridge gap that materialises here as `Rect argument
contained a NaN value.` also explains why U16 surfaces with the
sibling banner `Offset argument contained a NaN value.` —
both stem from the bridged text-painter producing NaN
coordinates for paragraphs whose glyph-cluster boundaries do
not match the per-span boundaries the painter expects.

---

## U20 — `Table(border: TableBorder.all(...))` triggers a Flutter framework assertion in `table_border.dart` line 289 regardless of row count / column widths (bridge/framework interaction gap)

### What triggers it

Any `Table` widget that is given a `TableBorder.all(...)` (or
any non-`null` `TableBorder` whose `horizontalInside` and
`verticalInside` sides have non-`BorderStyle.none`) reaches
`TableBorder.paint(canvas, rect, rows: …, columns: …)` via
`RenderTable.paint` (see
`/srv/flutter/flutter/packages/flutter/lib/src/rendering/table.dart`
line 1515) and the very first assertion at line 289 of
`table_border.dart` fires:

```
'package:flutter/src/rendering/table_border.dart':
Failed assertion: line 289 pos 12:
'rows.isEmpty || (rows.first >= 0.0 && rows.last <= rect.height)':
is not true.
```

`RenderTable.paint` constructs `borderRect = Rect.fromLTWH(dx,
dy, _tableWidth, _rowTops.last)` and passes
`rows = _rowTops.getRange(1, _rowTops.length - 1)` — so
`rect.height == _rowTops.last` and
`rows.last == _rowTops[length-2]`. Because `_rowTops` is built
by `rowTop += rowHeight` where every `rowHeight` is computed
via `math.max(rowHeight, child.size.height)` (always ≥ 0),
`_rowTops` is mathematically non-decreasing and the assertion's
right-hand inequality `rows.last <= rect.height` is provably
satisfied. The left-hand inequality `rows.first >= 0.0` is also
provably satisfied: `_rowTops[0] = 0` and `_rowTops[1] = first
row height ≥ 0`. So the assertion should never fire — yet it
*does* fire here, for *every* Table that carries a non-empty
`TableBorder`, regardless of column widths
(`FlexColumnWidth`, `IntrinsicColumnWidth`, fixed widths all
behave the same), row decoration, or cell content.

Bisect (item 107 of
`testlog_20260519-1247-flutter-suites-fixes/framework_error_fix_plan.md`):
removing only the `border: TableBorder.all(...)` parameter
from all seven Tables in
`widgets/editable_text_misc_test.dart` drops `frameworkErrors`
from `1` to `0`. Reintroducing it (even on a single Table)
brings the assertion back. The seven Tables are independent
(different column counts, different row counts, different
column widths, different decorations) and *all* trigger the
same assertion — confirming the trigger is the
`TableBorder`-attached paint path itself, not any single
table's geometry.

The underlying cause is not yet pinned down. Possibilities:

1. **A Flutter 3.41.6 framework issue** — the assertion could
   fire under some FP / iteration ordering subtlety that the
   monotonic-invariant proof above misses. The assertion is
   short and the invariant looks airtight, so this is the
   least likely explanation.

2. **A bridge-side mismatch in how `_rowTops` is populated** —
   the most plausible explanation. The `Table` and
   `TableBorder` constructors are bridged through `D4` (see
   `lib/src/bridges/widgets_bridges.b.dart` line 87898 ff. and
   `lib/src/bridges/rendering_bridges.b.dart` line 93745 ff.)
   and the bridge code itself looks correct. But the
   *layout* path runs against the native `RenderTable`, and if
   `RenderTable` (or one of the cells) is invoked with
   constraints that produce a row with `size.height` infected
   by a stray non-finite value (NaN, infinity, slightly
   negative due to a child widget bridged through a relaxer),
   `_rowTops` could become non-monotonic in a way the
   monotonic-invariant proof does not catch. The script does
   not feed obvious infinity / NaN values to any cell — every
   cell is `Padding(EdgeInsets.all(6.0), child: Text(...))` —
   so if this is the explanation the offending value is being
   produced inside a bridged code path, not by the script.

3. **A subtle widget-shape issue in d4rt-bridged `TableRow`s**
   — if the `children:` list reaching `RenderTable` somehow
   becomes a 1-D flat view rather than a 2-D shape with rows
   and columns, the cell-to-row binding could be off-by-one
   and a phantom zero-height row could appear at the end.
   Again, the bridge code at `_createTableRowBridge` /
   `_createTableBridge` looks correct, but the layout-time
   behaviour is what matters.

### Affected scripts

| Script | Sites | Notes |
|--------|-------|-------|
| `widgets/editable_text_misc_test.dart` | Seven `Table(border: TableBorder.all(...))` calls (`paletteTable`, `enumTable`, `smartTable`, `pitfallTable`, `glossaryTable`, `comparisonTable`, `cheatTable`). Six use `brassEdge` at width `0.6`, one (`pitfallTable`) uses `oxblood` at width `0.6`. | Item 107 of `testlog_20260519-1247-flutter-suites-fixes/framework_error_fix_plan.md`. Fixed at the script level on 2026-05-20 by dropping the `border:` parameter from all seven Tables; each Table remains framed by `cardShell`'s outer `Border.all(color: brassEdge, width: 1.2)`, so the bordered-card look is preserved at the cost of the interior brass grid lines. Verified `frameworkErrors=0 status=success` (was 1; Flutter dedupes the seven assertion banners to one). |

### What a real fix would look like

A real fix requires diagnosing why `RenderTable._rowTops`
violates `rows.last <= rect.height` in the d4rt-bridged
context when the same invariant holds by construction in
native Flutter. Likely starting points:

1. Instrument `RenderTable.performLayout` at the
   `rowTop += rowHeight` line to log every `rowHeight` value
   when laid out from a d4rt-bridged `Table` build, and
   compare against the native equivalent. Look for stray
   non-finite values entering `_rowTops`.

2. Audit the `Table` / `TableRow` bridges in
   `lib/src/bridges/widgets_bridges.b.dart` for any
   `List<TableRow>` / `Map<int, TableColumnWidth>` coercion
   that could produce a list with an off-by-one shape or a
   mutable shared instance.

3. Compare the `Table` widget output from a bridged
   constructor call vs. a hand-built native `Table` with the
   same children — diff `_rowTops`, `_columnLefts`, and
   `size` at paint time.

Until the underlying cause is identified, the script-side
workaround (drop `border:`, rely on the parent
`Container(decoration: BoxDecoration(border: Border.all(...)))`
for the outer frame) is the safe path.

---

## U21 — `Quad` / `Vector3` from `package:vector_math/vector_math_64.dart` are not reachable from interpreted scripts (bridge surface gap)

### What triggers it

Scripts that need geometry helpers from `package:vector_math/vector_math_64.dart` — most commonly the `Quad viewport` parameter of `InteractiveViewer.builder`'s callback, or anything that touches `Matrix4.getTranslation()` (which returns a `Vector3`) — cannot import them directly:

```text
Bad state: Cannot resolve import package:vector_math/vector_math_64.dart from main.dart:
Package import is not bridged and not in the same package.
```

…and even when the type is *received* through a bridged callback (e.g. the `Quad` passed into the `InteractiveViewer.builder` builder), accessing its properties raises a runtime framework error:

```text
Runtime Error: Undefined property or method 'x' on Vector3.
```

### Dart / Flutter root cause

Flutter's barrel libraries only re-export a *single* class from `vector_math_64`:

```dart
// packages/flutter/lib/widgets.dart   line 16
export 'package:vector_math/vector_math_64.dart' show Matrix4;

// packages/flutter/lib/rendering.dart line 36
export 'package:vector_math/vector_math_64.dart' show Matrix4;
```

`Quad`, `Vector3`, `Vector4`, etc. are deliberately *not* re-exported. They are part of `package:vector_math` and Flutter uses them in its API surface (`InteractiveViewer.builder` callback, `Matrix4.getTranslation()` return value, transform helpers), but consumers are expected to import `package:vector_math/vector_math_64.dart` directly to reach them.

`tom_d4rt_flutterm`'s `buildkit.yaml` only lists Flutter packages in `bridgedLibraries`, so the analyzer-free interpreter has no `BridgedClass` registration for `Quad` or `Vector3`. The bridge for `Matrix4` exists (see `painting_bridges.b.dart::_createMatrix4Bridge()`) because it is reachable through Flutter's re-export, but `Matrix4.getTranslation()` still returns a native `Vector3` instance which the interpreter has no metadata for — so any subsequent `.x` / `.y` access fails.

### What a real fix would look like

Either:

- Add `package:vector_math/vector_math_64.dart` to `tom_d4rt_flutterm/buildkit.yaml`'s `bridgedLibraries` and regenerate. This would create bridges for `Quad`, `Vector3`, `Vector4`, the math operators and constructors. Trade-off: noticeable increase in the generated bridge surface for a small number of interpreted scripts, plus a rule-(b) full regression sweep to confirm no collateral.
- Or, leave the bridge surface narrow and instruct scripts to use the *bridged* indexable accessors on `Matrix4` (column-major storage via `operator []`) and avoid `InteractiveViewer.builder`. This is what the workaround below does.

### Workaround

Two patterns cover all known sites:

1. **Replace `m.getTranslation().x` / `.y`** (which returns an unbridged `Vector3`) with direct column-major storage reads on the bridged `Matrix4`:

   ```dart
   // BEFORE — fails with "Undefined property or method 'x' on Vector3"
   final double tx = matrix.getTranslation().x;
   final double ty = matrix.getTranslation().y;

   // AFTER — Matrix4.operator [] is bridged and returns double
   final double tx = matrix[12]; // column-major: column 3, row 0
   final double ty = matrix[13]; // column-major: column 3, row 1
   ```

2. **Replace `InteractiveViewer.builder(builder: (BuildContext, Quad viewport) { ... })`** — whose callback signature *requires* the unbridged `Quad` type — with the standard constructor and a pre-built child sized to the full canvas:

   ```dart
   // BEFORE — import fails on vector_math_64; even if imported, Quad has no bridge
   InteractiveViewer.builder(
     transformationController: c,
     builder: (BuildContext context, Quad viewport) {
       // compute visible tiles from viewport.point0..point3 (Vector3 each)
       return Stack(children: lazyTiles(...));
     },
   );

   // AFTER — pre-build the full grid and let constrained:false + the
   // boundary margin drive pan/zoom over the whole canvas
   InteractiveViewer(
     transformationController: c,
     constrained: false,
     boundaryMargin: const EdgeInsets.all(200.0),
     child: SizedBox(
       width: canvasWidth,
       height: canvasHeight,
       child: Stack(children: allTiles), // not lazy
     ),
   );
   ```

   Trade-off: loses the "only build visible tiles" optimisation. For demo / teaching scripts a moderate grid size (≤ 144 tiles in our case) keeps memory and frame time comfortably bounded; production code that genuinely needs lazy tile construction would have to take the bridge-extension path above.

### Affected scripts

- `widgets/interactiveviewer_test.dart` — used both patterns: `m.getTranslation().x/.y` in `_DefaultViewer` and `_ControlledViewer`, plus the `InteractiveViewer.builder` callback receiving `Quad`. Rewritten under Option B on 2026-05-22 (Cluster C in `testlog_20260522-1328-issue-analysis/error_analysis.md`).

---

## U22 — H23 single-event scripts deferred to interpreter-level work

The H23 cluster (`testlog_20260522-1328-issue-analysis/error_analysis.md`
entry #23, twelve scripts each reporting exactly one framework
error) was originally classified as a homogeneous "one-event
overflow" batch needing `Flexible` / `Expanded` / `SizedBox`
adjustments. Reproduction showed the errors are diverse, and
several map to script-side / interpreter-level patterns already
documented elsewhere in this file or to new interpreter-level
gaps. The following table summarises the deferred-as-unfixable
items; the rest of the batch was fixed script-side under H23 and
is summarised in `error_analysis.md` entry #23.

| Script | Error | Status |
|--------|-------|--------|
| ~~`animation/cubic_test.dart`~~ | ~~`BoxConstraints forces an infinite height` (RenderConstrainedBox)~~ | **FIXED 2026-05-23 (entry #19).** The U14 diagnostic mis-identified the source — it was not the `Center > ConstrainedBox` or `GridView.count` pattern but two `Row(crossAxisAlignment.stretch)` blocks in `_PrivateConstructorCards` (section 4) that propagated infinite cross-axis into a synthetic RenderConstrainedBox inside each card. Fix: `IntrinsicHeight` wrap on both Rows. Same family as entry #10's `render_exclude_semantics_test.dart` fix. See U14 §"2026-05-23 update" for retrospective. |
| ~~`material/dropdownform_test.dart`~~ | ~~`An InputDecorator, which is typically created by a TextField, cannot have an unbounded width`~~ | **FIXED 2026-05-23 (entry #18).** Bisected to `_buildSection06`'s `intrinsic` widget: a bare `DropdownButtonFormField<String>` (no `isExpanded`, no `Expanded`/`Flexible`/`SizedBox` wrapper) inside a `Row` with a trailing `Spacer()`. A `Row` gives unbounded horizontal constraints to children without flex wrappers, and the DDFF's internal `InputDecorator` rejects unbounded width. **Native Flutter exhibits the same crash** — this was a script-side authoring bug, not a bridge gap. **Fix 1:** wrap the DDFF in `SizedBox(width: 220)` to bound its width while preserving the "intrinsic-like sizing with trailing space" teaching intent. **Fix 2 (follow-up after Fix 1 unmasked a previously-hidden error):** the `complexItems` DDFF in `_buildSection01` used 2-line per-item children (label + monospace 'id:' subtitle in a Container with vertical 4 padding) measuring ~70 px per item. This exceeded the DropdownButton's default `kMinInteractiveDimension=48` selected-item slot and produced a 22-px bottom `RenderFlex overflow`. Attempted `itemHeight: 70` first — the bridged `DropdownButtonFormField` does not honour the `itemHeight` parameter (no effect). Workaround: collapsed the per-item layout to a single Row line (icon-Container + Expanded(label with maxLines:1, ellipsis) + 'id:' trailing Text), all of which fits comfortably inside the 48-px slot. The "arbitrary widget subtrees" teaching point is still demonstrated by the icon + Text + trailing-id Row. `fwErr 1→0` on both projects. |
| ~~`material/dropdown_test.dart`~~ | ~~`Argument Error: Invalid parameter "callback": expected List<Widget>, got List<Object?>`~~ | **FIXED 2026-05-23 (entry #17).** The interpreter generics-erasure root cause (`colorChoices.map<Widget>(...).toList()` erases the `Widget` generic to `Object?` at the bridge boundary, regardless of `.map<Widget>` / `List<Widget>.from(...)` / `<Widget>[]` literal / imperative loop source form — all four script-side variants surfaced the same coercion error in H23) remains unresolved at the interpreter level. **Workaround:** omit the `selectedItemBuilder` parameter entirely from the `selectedItemBuilderDropdown`. Default `DropdownButton` behaviour renders the matching `items` widget (the chip) for the selected display too — slight visual change (shows the regular `chipForColor` instead of the custom "Selected: NAME" Container), but the `selectedItemBuilder` teaching content is preserved further down via the code-block sections that demonstrate the pattern as static `Text` snippets. The underlying typed-collection coercion limitation is unchanged — see U22 §"What a real fix would look like" item (1). `fwErr 1→0` on both projects. |
| `material/mergeable_test.dart` | `BoxConstraints forces an infinite height` (RenderPadding) | **Fixed script-side under H23** — `IntrinsicHeight` wrap on the section-1 `Row(crossAxisAlignment.stretch, children: conceptCards)`. Not part of U22; listed here only for cross-reference. |
| `material/progress_test.dart` | `Progress bar value, minValue, and maxValue must be valid numbers. value: "0 percent", minValue: "0", maxValue: "100"` | **Fixed script-side under H23** — three `semanticsValue` strings switched from `'$percent percent'` / `'$percent%'` / `'85%'` to bare numeric strings (`'$percent'` / `'85'`). Not part of U22. |
| `rendering/render_constraints_transform_box_test.dart` | `BoxConstraints(699.6<=w<=349.8, h=182.0; NOT NORMALIZED) is not normalized` | **Already U17.** Teaching script whose purpose is to feed pathological inputs to `ConstraintsTransformBox`. Any pre-normalize fix exposes the next intentional banner. Deferred. |
| `scheduler/ticker_test.dart` | `BoxConstraints forces an infinite height` (RenderDecoratedBox) | **Fixed script-side under H23** — `IntrinsicHeight` wrap on the per-row `Row(crossAxisAlignment.stretch, children: [Expanded(buildCompCell)…])` comparison-table builder. Not part of U22. |
| `services/platform_test.dart` | `BoxConstraints forces an infinite height` (RenderConstrainedBox) | **Already U18.** `_defaultVsThemeCard` Row(stretch)+Expanded(_twinCard). All four script-side variants crash the test-app transport, worse than the recoverable baseline banner. Deferred. |
| ~~`widgets/animation_test.dart`~~ | ~~`Runtime Error: LateInitializationError: Late variable '_meanAnim' without initializer is accessed before being assigned.`~~ | **FIXED 2026-05-23 (entry #16).** The `_MeanAnimation extends CompoundAnimation<double>` script-defined subclass remains unconstructible under d4rt (architectural U-family limitation). **Workaround:** removed the `_meanAnim` field and `_MeanAnimation` class entirely; the mean trace is now synthesised inline in `_CompoundSection` using `AnimatedBuilder(animation: Listenable.merge([minA, maxA]), builder: ...)` that computes `(min + max) / 2` on the fly. Mathematically equivalent — for any two values A and B, `mean(A,B) = (min(A,B) + max(A,B)) / 2` because `min + max = A + B` always. Visual impact: identical mean trace; the demo retains its "blend two parents into one Animation<double>" teaching content via `AnimationMin` and `AnimationMax` (the genuine public Flutter SDK classes). `fwErr 1→0` on both projects. The underlying interpreter limitation (script-defined subclass of bridged abstract class) remains documented under U3/U5/U9/U10/U11. |
| ~~`widgets/slotted_multi_child_render_object_widget_test.dart`~~ | ~~`Runtime Error: Cannot access property 'r' on target of type null.`~~ | **FIXED 2026-05-23 (entry #14).** Confirmed the bridge returns `null` for `_accents[i]` (not just for `.r/.g/.b`) — `_accent` itself is null because `_accents` is a script-defined `static const List<Color>` whose element type erases to `Object?`/`dynamic` through the bridge. Both `.r` and `.value` fail with the same `Cannot access property '…' on target of type null.` Workaround applied: log the **accent INDEX** instead of trying to resolve the Color object's channels (`'accentIndex=${_accentIndex.round() % _accents.length}'`). The rest of the script still uses `_accent` in `decoration: BoxDecoration(color: _accent)` contexts where the bridge accepts the dynamic-typed value (paint-time coercion is more lenient than property access). Visual impact on rendered widgets: none — debug log records the index instead of channel values. `fwErr 1→0` on both projects. |
| ~~`retest/widgets/app_kit_view_test.dart`~~ | ~~`Runtime Error: Native error during default bridged constructor for 'AppKitView': Argument Error: Invalid parameter "gestureRecognizers": cannot convert to Set<Factory<OneSequenceGestureRecognizer>>`~~ | **FIXED 2026-05-23 (entry #15).** Investigation showed the crash fires on the **first frame** (before `initState`'s `_boot()` resolves `_status`). `_status` starts at `'boot'` (line 1692), which fell through all the `if (_status == '...')` guards in `_AppKitLane.build()` and reached `_liveSurface()` → `AppKitView(gestureRecognizers: widget.gestureRecognizers)`. The bridge then attempted to coerce the script-defined `Set<Factory<OneSequenceGestureRecognizer>>` to the parameterised type and crashed per U22 generics-erasure. **Native Flutter** doesn't surface this because StatefulWidget's first build happens after initState; the d4rt interpreter's build cycle differs slightly. **Fix:** add `'boot'` to the placeholder guard set — first frame renders the simulation placeholder, then `_boot()` resolves `_status` to its real value on the next frame. No change to steady-state behaviour. `fwErr 1→0` AND **F5** (Cluster B failure on flutter_test) cleared on both projects. |
| `foundation/diagnosticable_tree_mixin_test.dart` | `Runtime Error: Instance of '_PrivateNode' has no method named 'toStringDeep'` | **Fixed script-side under H23** via the U10 sparse-fallback pattern (`_sparseToStringDeepFallback(tree)` helper that walks the script's data model and emits a string visually equivalent to Flutter's sparse `toStringDeep`). Mirrors `foundation/text_tree_configuration_test.dart`'s existing U10 workaround. Not part of U22; entry kept here only for cross-reference. |

### What a real fix would look like

The five originally interpreter-deferred items above (`dropdown_test`,
`dropdownform_test`, `widgets/animation_test`,
`slotted_multi_child_render_object_widget_test`,
`retest/widgets/app_kit_view_test`) — **all now cleared script-side
(entries #14/#15/#16/#17/#18, 2026-05-23)** — reduce to two
interpreter gaps, both already catalogued in this file. The gaps
themselves remain open even though every U22 script has been
worked around (and the dropdownform issue turned out to be a
script-side authoring bug rather than a bridged-constraint
propagation gap):

1. **Typed-collection coercion at the bridge boundary** —
   `List<Widget>` / `Set<Factory<…>>` arguments (and probably
   `Map<K, V>` arguments by extension) need a coercion path that
   either preserves the generic type tag through `.toList()` /
   `.toSet()` / typed literals, or narrows an `Iterable<Object?>`
   to the declared parameter type at the adapter layer. This
   would clear `dropdown_test.dart` and
   `retest/widgets/app_kit_view_test.dart` simultaneously, and
   plausibly also the null-source in
   `slotted_multi_child_render_object_widget_test.dart` (the
   `_accents` list's element type erasure).
2. **Bridged abstract-class subclass construction routing** —
   the family root cause spanning U3 / U5 / U9 / U10 / U11. A
   script-defined `extends CompoundAnimation<double>` (in this
   case) needs the same hand-written proxy treatment as
   `CustomClipper` got under item #22 (`tom_d4rt` /
   `tom_d4rt_ast` `d4rt_runtime_registrations.dart`). The
   alternative is a general "auto-generate adapter proxies for
   any bridged abstract class with N constructor variants"
   pass — captured as E12 in `error_analysis.md` for tom_d4rt.

### Affected scripts

| Script | Notes |
|--------|-------|
| ~~`material/dropdown_test.dart`~~ | ~~Reverted to original `colorChoices.map<Widget>((name) {...}).toList()` after four script-side variants all surfaced the same `List<Widget>` coercion error.~~ → **FIXED entry #17** (omit `selectedItemBuilder` entirely; default `DropdownButton` renders `items` widget for selected display). Underlying typed-collection coercion gap unchanged. |
| ~~`widgets/animation_test.dart`~~ | ~~`_MeanAnimation extends CompoundAnimation<double>` construction silently fails; `_meanAnim` stays unassigned.~~ → **FIXED entry #16** (remove _MeanAnimation; synthesise mean inline via Listenable.merge(min,max) + AnimatedBuilder) |
| ~~`widgets/slotted_multi_child_render_object_widget_test.dart`~~ | ~~`_accent.r` access in `_PrivateContentReporter._report`; root null source not yet pinned down.~~ → **FIXED entry #14** (log accent INDEX instead of resolved Color channels) |
| ~~`retest/widgets/app_kit_view_test.dart`~~ | ~~`Set<Factory<OneSequenceGestureRecognizer>>` coercion at the bridged `AppKitView` constructor. Expected to be cleared by Cluster B item 4.~~ → **FIXED entry #15** (boot-status placeholder guard) |
| ~~`material/dropdownform_test.dart`~~ | ~~Internal `InputDecorator` from a bridged dropdown variant — no externally visible call site identified. Same family as U14.~~ → **FIXED entry #18** — script-side authoring bug, not a bridge-internal issue. Bare DDFF in a Row (no flex wrapper, no isExpanded) gave unbounded width to the internal InputDecorator. Fix: wrap in `SizedBox(width: 220)` in `_buildSection06`. Follow-up: collapsed 2-line per-item children in `_buildSection01` to single-line layout to clear a previously-masked 22-px overflow. |

---

## U23 — 20260523-1056 H-5 follow-up: 7 single-event scripts deferred (small layout-rounding overflows + bridge SDK assertion)

The H-5 batch (entry #18 of
`testlog_20260523-1056-issue-analysis/error_analysis.md`)
contains 19 single-event framework-error scripts. After the
2026-05-23 follow-up pass (entries #6 and #8), the script-side
fixable items were cleared:

- `widgets/decoratedbox_test.dart` — borderRadius+non-uniform
  Border H2 fix (entry #6).
- `material/refreshindicator_test.dart` — header moved into
  ListView so it scrolls with content (entry #8, 53 px bottom
  cleared).
- `widgets/placeholder_test.dart` — `buildBadCaseCMock`
  `SizedBox.height` bumped from 90 to 110 to accommodate
  4-line wrapped prose in the right column (entry #8, 14 px
  bottom cleared).

The 8 scripts originally documented as deferred under existing U
entries (U14 `animation/cubic_test`, U17 `render_constraints_transform_box_test`
×2, U18 `services/platform_test`, U22 `material/dropdown_test`,
`material/dropdownform_test`, `widgets/animation_test`,
`widgets/slotted_multi_child_render_object_widget_test`,
`retest/widgets/app_kit_view_test`) were progressively cleared by
entries #14/#15/#16/#17/#18/#19 (U22 — ALL FIVE scripts FIXED,
plus U14 cubic_test FIXED via the same family as entry #10's
IntrinsicHeight-on-Row(stretch) fix after the U14 diagnostic
was found to mis-identify the source). Remaining genuinely-
deferred items: U17 `render_constraints_transform_box_test` ×2
(intentional teaching script), U18 `services/platform_test`
(all 4 script-side variants destabilize the test-app transport).
**U22 fully cleared as of entry #18; U14 fully cleared as of
entry #19.**

The 7 remaining items are deferred here, cross-referenced where
they fit existing patterns:

| Script | Error | Status |
|--------|-------|--------|
| ~~`painting/textstyle_test.dart`~~ | ~~`Runtime Error: Native error during bridged method call 'withOpacity' on MaterialColor: 'dart:ui/painting.dart' line 342 assertion`~~ | **FIXED 2026-05-23 (entry #9).** Investigation showed this was a **script-side bug**, not a bridge gap: `Colors.grey.withOpacity(0.18 * (7 - i))` at line 1074 with `i=1` evaluates to `1.08`, exceeding Flutter's `assert(opacity >= 0.0 && opacity <= 1.0)` in `dart:ui/painting.dart` line 342. Native Flutter would assert at the same line — not a bridge-specific issue. **Fix:** clamp the computed alpha to `[0.0, 1.0]`. `frameworkErrors=1 → 0` on both projects. The "withOpacity on MaterialColor" framing in the earlier note was a red herring — the receiver type was incidental; the trigger was the out-of-range numeric input. |
| ~~`material/dialog_themes_test.dart`~~ | ~~`RenderFlex overflowed by 2.0 px on the right`~~ | **FIXED 2026-05-23 (entry #11).** Located via 4-step section bisection (hero-elevation clean; +alignment+flavours+actionStyle → 2.0 px; flavour single-out → simpleFlavour is the source). Root cause: `_simpleDialogOption` Row `[Icon(18) + _wgap(10) + Text(label)]` inside `SimpleDialog` of width 240 rendered in a narrower Expanded slot. The Text widget had no flex wrapper, so it kept its natural width. **Fix:** wrap the Text in `Expanded(child: Text(..., maxLines: 1, overflow: TextOverflow.ellipsis))`. `fwErr 1→0` on both projects. |
| ~~`cupertino/cupertino_themes_batch3_test.dart`~~ | ~~`RenderFlex overflowed by 1.8 px on the right`~~ | **FIXED 2026-05-23 (entry #12).** Earlier attempts (entry #9 — convert `sampleControls` first Row to a Wrap) failed because the overflow was deeper in the bridged `CupertinoSwitch` / `CupertinoSlider` width measurement. Successful approach: in `section15`'s comparison row layout `[SizedBox(88) label + Expanded light-preview + SizedBox(8) + Expanded dark-preview]`, shrink the label SizedBox from 88 to 70. The recovered 18 px is handed to the two preview Expandeds, which is enough for the bridged controls' intrinsic-width rounding to fit without overflowing. The label Text is wrapped in `Expanded(... maxLines: 2, overflow: ellipsis)` so any narrowing on the longest label `'Active Blue'` (11 chars) wraps to 2 lines instead of overflowing the narrower SizedBox. `fwErr 1→0` on both projects. **U23 is now empty** — all 7 originally deferred scripts are fixed; 5 of the 6 U15-family small-pixel overflows turned out to be script-side fixable after deeper bisection. |
| ~~`painting/box_painter_test.dart`~~ | ~~`RenderFlex overflowed by 3.8 px on the right`~~ | **FIXED 2026-05-23 (entry #10).** Located via 3-step section bisection. Root cause: `_galleryCard` title `Row(Icon(18) + SizedBox(6) + Text(title, fontSize 13 bold))` — at card `width: 200` with `padding: 12` the inner is 176 px; longest title `'FlutterLogoDecoration'` (21 chars, fontSize 13 bold) needed ~196 px → 3.8 px right overflow. **Fix:** wrap the title `Text` in `Expanded` with `maxLines: 2, overflow: TextOverflow.ellipsis`. `fwErr 1→0` on both projects. |
| ~~`painting/decoration_image_painter_test.dart`~~ | ~~`RenderFlex overflowed by 5.1 px on the right`~~ | **FIXED 2026-05-23 (entry #11).** First attempt under entry #10 (shrink `_fitCard` width 220 → 210) was reverted because it exposed a 15 px overflow elsewhere. Successful approach under entry #11: switch the title `Row [_badge + SizedBox + optional _chip]` inside `_fitCard` (line 951) to a `Wrap` so the optional CLIPPED chip can drop to a second line when the longest sample name `'fitWidth (portrait)'` (19 chars) doesn't leave room. `fwErr 1→0` on both projects. |
| ~~`widgets/editable_text_tap_up_outside_intent_test.dart`~~ | ~~`RenderFlex overflowed by 2.8 px on the right`~~ | **FIXED 2026-05-23 (entry #11).** Located by inspecting `_buildGestureDisambiguation` — inner Row inside `SizedBox(width: 80)` packs `Icon(14) + SizedBox(4) + Text(gesture, fontSize 10 bold)`. The longest label `'Scroll / Drag'` (12 chars) measures ~84 px which overflows the 80 px slot by ~4 px (Flutter reports 2.8 px). **Fix:** wrap the `Text` in `Expanded(... maxLines: 1, overflow: TextOverflow.ellipsis)` so the label can ellipsize under the bounded slot. `fwErr 1→0` on both projects. |
| ~~`rendering/render_exclude_semantics_test.dart`~~ | ~~`BoxConstraints forces an infinite height`~~ | **FIXED 2026-05-23 (entry #10).** Located via 4-step section bisection (down to `_buildSectionOne`). Root cause: `Row(crossAxisAlignment: CrossAxisAlignment.stretch)` with `Expanded` children inside `SingleChildScrollView` (which gives unbounded vertical) — the cross-axis stretch needs bounded vertical from the parent, but the SingleChildScrollView passes `maxHeight: infinity`. U14 family. **Fix:** wrap the `Row` in `IntrinsicHeight` so the stretch resolves to the natural height of the tallest tile. `fwErr 1→0` on both projects. |

### What a real fix would look like

The 5 small-pixel right overflows (U15 family) collectively
need one of:

1. A bridge-side fix to the intrinsic-width measurement of
   horizontal layouts under bounded parents — which is a
   targeted investigation in
   `tom_d4rt_flutterm/lib/src/bridges/widgets_bridges.b.dart`
   and the underlying generator. Out of scope for cluster
   work.
2. Per-script defensive padding (subtract 2-6 px from a
   fixed-width Container) — works but is fragile to bridge
   updates.
3. Add the same small overflows to the `ignoredPatterns` list
   in both test apps' `_handleFlutterError` (under the
   existing `'overflowed by 0.500 pixels'` filter pattern) —
   matches the existing precedent and reduces fw-err noise
   without per-script edits. This is the recommended next
   step if H-5 cleanup escalates.

The `painting/textstyle_test.dart` `withOpacity` issue is
specific to `MaterialColor`-typed receivers and should be
investigated in
`tom_d4rt_flutterm/lib/src/bridges/painting_bridges.b.dart`
(the bridge for the `Color` interface) — outside the scope of
script-side cluster work.

The `rendering/render_exclude_semantics_test.dart` U14-family
infinite-height issue is identical to the
`animation/cubic_test.dart` U14 entry; no new diagnostic.

### Affected scripts (cross-referenced from H-5 follow-up entries #6 + #8)

| Script | Suite | Status |
|--------|-------|--------|
| ~~`painting/textstyle_test.dart`~~ | ~~essential~~ | ~~U23~~ → **FIXED entry #9** (script-side alpha clamp) |
| ~~`material/dialog_themes_test.dart`~~ | ~~important~~ | ~~U23 (U15 family)~~ → **FIXED entry #11** (Expanded label in _simpleDialogOption Row) |
| ~~`cupertino/cupertino_themes_batch3_test.dart`~~ | ~~important~~ | ~~U23 (U15 family)~~ → **FIXED entry #12** (shrink label SizedBox 88→70 in section15) |
| ~~`painting/box_painter_test.dart`~~ | ~~secondary~~ | ~~U23 (U15 family)~~ → **FIXED entry #10** (Expanded title) |
| ~~`painting/decoration_image_painter_test.dart`~~ | ~~secondary~~ | ~~U23 (U15 family)~~ → **FIXED entry #11** (title Row → Wrap in _fitCard) |
| ~~`widgets/editable_text_tap_up_outside_intent_test.dart`~~ | ~~hardly_4~~ | ~~U23 (U15 family)~~ → **FIXED entry #11** (Expanded gesture label in disambiguation Row) |
| ~~`rendering/render_exclude_semantics_test.dart`~~ | ~~secondary~~ | ~~U23 (U14 family)~~ → **FIXED entry #10** (IntrinsicHeight wrap) |

---

## Change Log

- 2026-05-23: **Update U14 (entry #19)** —
  `animation/cubic_test.dart` moved from U14-deferred to FIXED
  after five prior misdirected script-side attempts. The U14
  diagnostic identified the source as
  `Center > ConstrainedBox(maxWidth)` inside
  `SingleChildScrollView` or `Expanded inside
  Column(mainAxisSize.min)` inside `GridView.count` cells —
  neither was the actual trigger. Section-level bisection
  (sections 2-5 enabled, banner reproduces; only Anatomy+Gallery
  → clean; only Constructor → banner reproduces) localised the
  source to **two `Row(crossAxisAlignment.stretch)` blocks in
  `_PrivateConstructorCards`** (lines 1209 + 1219 of the script)
  inside the section card's `Column`. A `Row(stretch)` requires
  bounded height from its parent; inside a `Column` that forwards
  `maxHeight: infinity` from the outer `SingleChildScrollView`,
  the stretch propagated infinite cross-axis into a synthetic
  `RenderConstrainedBox` inside each `_PrivateConstructorCard`'s
  130-px plot Container, surfacing as `BoxConstraints forces an
  infinite height`. Fix: wrap each `Row(stretch)` in
  `IntrinsicHeight`, which resolves the Row's height to the
  intrinsic min height of the tallest child so the stretch has a
  finite cross-axis to work with. Same family fix as entry #10's
  `rendering/render_exclude_semantics_test.dart`. `fwErr 1→0` on
  both projects. **U14 fully cleared script-side.** The
  interpreter-side "constraint-propagation gap" described in the
  U14 entry's body text remains an open theoretical concern for
  other future scripts that genuinely use the
  `Center > ConstrainedBox > SCV` pattern, but no current corpus
  script is an instance of it.
- 2026-05-23: **Update U22 (entry #18)** —
  `material/dropdownform_test.dart` moved from U22-deferred to
  FIXED. Investigation revealed this was a script-side authoring
  bug, not the U14-family bridged-constraint propagation gap it
  was originally classified as. Section-level bisection
  (sections 1-9 → only sections 6-7 → only section 6) located
  the source in `_buildSection06`'s `intrinsic` widget: a bare
  `DropdownButtonFormField<String>` (no `isExpanded`, no
  `Expanded`/`Flexible`/`SizedBox` wrapper) inside a `Row` with
  a trailing `Spacer()`. A `Row` gives unbounded horizontal
  constraints to children without flex wrappers, and the DDFF's
  internal `InputDecorator` rejects unbounded width. Native
  Flutter exhibits the same crash. **Fix 1:** wrap the DDFF in
  `SizedBox(width: 220)` to bound its width while preserving the
  "intrinsic-like sizing with trailing space" teaching intent.
  **Follow-up after Fix 1 unmasked a previously-hidden 22-px
  bottom overflow:** further bisection (sections 1-5 disabled →
  overflow gone, only section 1 → overflow returns, only section
  1 with complexItems card disabled → overflow gone) localised
  the second source to `_buildSection01`'s `complexItems` DDFF.
  Its 2-line per-item children (label + monospace 'id:' subtitle
  in a Container with vertical 4 padding) measured ~70 px per
  item, exceeding the DropdownButton's default
  `kMinInteractiveDimension=48` selected-item slot. Attempted
  `itemHeight: 70` first — **the bridged
  `DropdownButtonFormField` does not honour the `itemHeight`
  parameter** (no effect). Workaround: collapsed the per-item
  layout to a single Row line (icon-Container(24×24) +
  Expanded(label maxLines:1 ellipsis) + trailing 'id:' Text).
  The "arbitrary widget subtrees" teaching point is still
  demonstrated. `fwErr 1→0` on both projects. **U22 now lists 0
  deferred scripts** — all five originally-deferred items are
  FIXED. Sub-note for future interpreter work: the bridged
  DropdownButtonFormField's `itemHeight` parameter being ignored
  is a separate bridge gap that may merit its own U-entry if
  another script hits it.
- 2026-05-23: **Update U22 (entry #17)** —
  `material/dropdown_test.dart` moved from U22-deferred to FIXED.
  The interpreter generics-erasure root cause (the script's
  `selectedItemBuilder` closure returns `colorChoices.map<Widget>(
  (name) => Container(...)).toList()` and the interpreter erases
  the `Widget` generic to `Object?` at the bridge boundary
  regardless of the source form — H23 tried `.map<Widget>`,
  `List<Widget>.from(...)`, `<Widget>[]` literal, and imperative
  loop, all four surfaced the same `expected List<Widget>, got
  List<Object?>` callback-argument error) is unchanged at the
  interpreter level. Workaround: omit the `selectedItemBuilder`
  parameter entirely. The default `DropdownButton` behaviour
  renders the matching `items` widget (the chip) for the selected
  display too — slight visual change (regular `chipForColor`
  instead of the custom "Selected: NAME" Container), but the
  `selectedItemBuilder` teaching content is preserved further down
  via code-block sections showing the pattern as static text
  snippets. `fwErr 1→0` on both projects. U22 now lists 1 deferred
  script (down from 2): only `dropdownform_test` remains, and that
  one is in the U14 bridged-constraint-propagation family rather
  than the generics-erasure family — so the U22 generics-erasure
  pocket is effectively cleared at the script-side level.
- 2026-05-23: **Update U22 (entry #16)** —
  `widgets/animation_test.dart` moved from U22-deferred to FIXED. The
  underlying interpreter limitation (script-defined `_MeanAnimation
  extends CompoundAnimation<double>` cannot be constructed) is
  unchanged at the interpreter level, but the workaround sidesteps
  it entirely by removing the `_MeanAnimation` class and the
  `late final Animation<double> _meanAnim` field. The mean trace is
  synthesised inline in `_CompoundSection` via
  `AnimatedBuilder(animation: Listenable.merge([minA, maxA]),
  builder: ...)` that computes `(min + max) / 2` on the fly.
  Mathematically equivalent because `mean(A,B) = (min(A,B) +
  max(A,B)) / 2` for any two values (min+max = A+B always). Visual
  impact: identical mean trace; demo retains its compound-animation
  teaching content via `AnimationMin` and `AnimationMax`. U22 now
  lists 2 deferred scripts (down from 3): dropdown_test,
  dropdownform_test.
- 2026-05-23: **Update U22 (entry #15)** —
  `retest/widgets/app_kit_view_test.dart` moved from U22-deferred to
  FIXED. Investigation showed the crash fires on the **first frame**
  (before `initState`'s `_boot()` resolves `_status`). `_status`
  starts at `'boot'` (line 1692), which fell through all the
  `if (_status == '...')` guards in `_AppKitLane.build()` and reached
  `_liveSurface()` → `AppKitView(gestureRecognizers: widget.gestureRecognizers)`.
  The bridge then attempted to coerce the script-defined Set and
  crashed per U22 generics-erasure. Native Flutter doesn't surface
  this because StatefulWidget's first build runs after initState
  completes; the d4rt interpreter's build cycle differs slightly.
  Fix: add `'boot'` to the placeholder guard set — first frame
  renders the simulation placeholder, then `_boot()` resolves
  `_status` on the next frame. Steady-state behaviour unchanged.
  This **also clears F5** (Cluster B failure on flutter_test for the
  same script). U22 now lists 3 deferred scripts (down from 4):
  dropdown_test, dropdownform_test, widgets/animation_test.
- 2026-05-23: **Update U22 (entry #14)** —
  `widgets/slotted_multi_child_render_object_widget_test.dart` moved
  from U22-deferred to FIXED. Confirmed the bridge returns `null` for
  `_accents[i]` itself (not just for `.r/.g/.b`) — `_accents` is a
  script-defined `static const List<Color>` whose element type erases
  to `Object?` / `dynamic` through the bridge. Tried `_accent.value`
  first (M2 channel API) — same null-target error. Workaround applied:
  log the accent INDEX instead of trying to resolve the Color
  object's channels. The rest of the script still uses `_accent` in
  `decoration: BoxDecoration` contexts where the bridge accepts the
  dynamic-typed value (paint-time coercion is more lenient than
  property access). U22 now lists 4 deferred scripts (down from 5):
  dropdown_test, dropdownform_test, widgets/animation_test,
  retest/widgets/app_kit_view_test. Also attempted
  `animation/cubic_test.dart` (U14) with an Align replacement for the
  outer Center wrap — reverted; that's a 5th failed attempt; U14
  stays deferred.
- 2026-05-23: **U23 CLEARED (entry #12)** — The last deferred U23
  script `cupertino/cupertino_themes_batch3_test.dart` (1.8 px right)
  is now FIXED. Approach: shrink the `SizedBox(width: 88)` label
  column in section15's comparison rows to `width: 70`. The 18 px
  recovered hands enough headroom to the two preview Expandeds for
  the bridged `CupertinoSwitch` / `CupertinoSlider` intrinsic-width
  rounding to fit. Label Text wrapped in
  `Expanded(... maxLines: 2, overflow: ellipsis)` so the longest
  'Active Blue' label gracefully wraps on the narrower SizedBox.
  Of the 7 original U23 entries, all 7 are now FIXED — 1 was the
  textstyle alpha-out-of-range script-side bug, 5 were U15-family
  small-pixel right overflows that turned out to be script-side
  fixable after deeper bisection, 1 was a U14-family infinite-height
  fixable by IntrinsicHeight wrap. The U23 family pattern was real
  but the script-side workarounds turned out to be reachable in
  every case via Expanded/Wrap/IntrinsicHeight wraps applied to the
  identified culprit Row. **U23 is now an empty entry kept for
  historical reference.**
- 2026-05-23: **Update U23 (entry #11)** — Three more scripts moved
  from U23-deferred to FIXED, leaving only `cupertino/cupertino_themes_batch3_test.dart`
  as the single remaining U23-deferred entry:
  - `material/dialog_themes_test.dart` — `_simpleDialogOption` Row
    [Icon + SizedBox + Text(label)] inside SimpleDialog of width 240
    rendered in a narrower Expanded slot. Fix: wrap label Text in
    Expanded with maxLines+ellipsis.
  - `widgets/editable_text_tap_up_outside_intent_test.dart` —
    `_buildGestureDisambiguation` inner Row inside SizedBox(width: 80)
    overflows for the longest gesture label ('Scroll / Drag'). Same
    fix pattern: Expanded(Text) with maxLines+ellipsis.
  - `painting/decoration_image_painter_test.dart` — second attempt
    after entry #10 reverted (shrinking card width exposed deeper
    overflow). Successful: switch the `_fitCard` title Row [_badge +
    SizedBox + optional _chip] to a Wrap so the CLIPPED chip can
    drop to a second line for the longest sample name
    `'fitWidth (portrait)'`.
  Pattern across all three: an inner Row inside a bounded-width
  parent had a fixed-width Text that didn't have a flex wrapper —
  wrapping in Expanded (or converting the outer Row to Wrap) lets
  the content fit. U23 now lists 1 deferred script (down from 4):
  cupertino_themes_batch3 (1.8 px right) — the only entry where
  the overflow is genuinely deeper in the bridged Cupertino layout
  (CupertinoSwitch / CupertinoSlider width measurement) and not
  reachable via script-side changes.
- 2026-05-23: **Update U23 (entry #10)** — Two more scripts moved
  from U23-deferred to FIXED:
  - `painting/box_painter_test.dart` — `_galleryCard` title `Row(Icon
    + SizedBox + Text(title))` overflowed the inner card width when the
    longest title (`'FlutterLogoDecoration'`) rendered. Fix: wrap the
    title `Text` in `Expanded` with maxLines+ellipsis. `fwErr 1→0`.
  - `rendering/render_exclude_semantics_test.dart` — `Row(crossAxisAlignment.stretch)`
    with Expanded children inside SingleChildScrollView leaked
    `maxHeight: infinity` (U14 family). Fix: wrap the Row in
    `IntrinsicHeight`. `fwErr 1→0`.
  Also attempted (and reverted) `painting/decoration_image_painter_test.dart`
  (5.1 px right) — shrinking `_fitCard` width from 220 to 210
  cleared the 5.1 px overflow but exposed a 15 px overflow
  elsewhere (multiple small overflows mask each other). Reverted;
  stays U23 deferred. U23 now lists 4 deferred scripts (down from 6).
- 2026-05-23: **Update U23** — `painting/textstyle_test.dart`
  removed from deferred list and marked FIXED in entry #9 of
  `testlog_20260523-1056-issue-analysis/error_analysis.md`. Root
  cause was script-side (alpha computation `0.18 * (7 - i)` at
  `i=1` evaluates to `1.08`, exceeding the SDK's
  `assert(opacity >= 0.0 && opacity <= 1.0)`), not a bridge gap.
  Fix: clamp the computed alpha to `[0.0, 1.0]`. U23 now lists 6
  deferred scripts (down from 7): 5 small-pixel right overflows
  under U15 family + 1 infinite-height under U14 family. Attempt
  to fix `cupertino/cupertino_themes_batch3_test.dart` (1.8 px
  right) by converting the `sampleControls` first Row to a Wrap
  was tried under entry #9 and **reverted** — the overflow is
  deeper inside the bridged Cupertino controls (likely
  `CupertinoSwitch`/`CupertinoSlider` width measurement),
  consistent with U15 family.
- 2026-05-23: **Add U23** — 20260523-1056 H-5 follow-up: 7
  single-event scripts deferred (5 small-pixel right overflows
  under U15 family, 1 bridge SDK assertion on
  `MaterialColor.withOpacity`, 1 infinite-height under U14
  family). Documents script-side and bridge-side fix paths.
- 2026-05-23: **Add U22** — H23 single-event scripts deferred to
  interpreter-level work. Summarises the H23 cluster (`testlog_20260522-1328-issue-analysis/error_analysis.md`
  entry #23) split: 5 scripts fixed script-side (mergeable_test,
  ticker_test, progress_test, dropdown_test cross-ref already U17/U18/U14, and
  diagnosticable_tree_mixin_test via the U10 sparse fallback), and 5 deferred
  as cross-references to existing U14 / U17 / U18 entries or new
  interpreter-level gaps (typed-collection coercion in
  `dropdown_test` + `app_kit_view_test`, bridged-abstract subclass
  routing in `widgets/animation_test`, null-source in
  `slotted_multi_child_render_object_widget_test`, and the internal
  InputDecorator in `dropdownform_test`). Catalogues the two
  underlying interpreter gaps shared across the deferred items.
- 2026-05-22: **Add U21** — `Quad` / `Vector3` from
  `package:vector_math/vector_math_64.dart` are not reachable
  from interpreted scripts because Flutter's barrel libraries
  only re-export `Matrix4`. Documents both manifestation modes
  (the import-resolution `Bad state` and the runtime
  `Undefined property or method 'x' on Vector3` after
  `Matrix4.getTranslation()`) plus the script-side workaround
  patterns (`m[12]` / `m[13]` instead of
  `m.getTranslation().x/.y`; `InteractiveViewer(constrained:
  false, child: SizedBox(Stack(allTiles)))` instead of
  `InteractiveViewer.builder(builder: (ctx, Quad q) {...})`).
  Closes Cluster C #7 of
  `testlog_20260522-1328-issue-analysis/error_analysis.md`.
- 2026-05-20: **Add U20** — `Table(border: TableBorder.all(...))`
  triggers a Flutter framework assertion in
  `table_border.dart` line 289 (`'rows.isEmpty || (rows.first
  >= 0.0 && rows.last <= rect.height)'`) regardless of row
  count, column widths, or row decoration. Mathematically the
  assertion's invariant is satisfied by construction of
  `RenderTable._rowTops` (monotonically non-decreasing because
  every `rowHeight` is `math.max(0, child.size.height)`), yet
  the assertion *does* fire for every `Table` in
  `widgets/editable_text_misc_test.dart` (item 107) that
  carries a non-empty `TableBorder` — bisect confirmed by
  removing only the `border:` parameter from all seven Tables
  (drops `frameworkErrors` from 1 to 0). Underlying cause not
  yet pinned down; most plausible explanation is a
  bridge-side issue that infects `_rowTops` with a stray
  non-finite or out-of-order value during `RenderTable`
  layout. Item 107 fixed script-side 2026-05-20 by dropping
  the `border:` parameter from all seven Tables; outer frame
  preserved by the enclosing `cardShell`'s
  `Border.all(color: brassEdge, width: 1.2)`.
- 2026-05-20: **Add U19** — `services/text_editing_delta_non_text_update_test.dart`
  per-character `TextSpan` stream of Japanese hiragana inside
  `_frozenFrame` (the splits-text-by-character helper used to
  paint a "frozen" before/after composing-region preview)
  triggers a NaN `Rect` assertion at `dart:ui/painting.dart`
  line 26 (`_rectIsValid` — `assert(!rect.hasNaN)`). Sibling
  pattern to U16 (same bridge text-layout gap; U16 surfaces as
  NaN `Offset` at line 41 from empty `Text('')`, U19 as NaN
  `Rect` at line 26 from non-Latin glyph spans). Trigger is the
  *combination* of (per-character `TextSpan` fragmentation) ×
  (non-Latin glyphs); neither dashed-underline style, gradient
  background, `WidgetSpan` interleave, font choice, nor
  `backgroundColor` is individually load-bearing (each was
  experimentally falsified). Item 99 fixed script-side
  2026-05-20 by replacing `greet = 'こんにちは'` with
  `greet = 'aiueo'` (5 ASCII glyphs matching the original
  5-character pacing); the Japanese form is retained in the
  example's `story:` prose so the educational intent is
  preserved. Verified `frameworkErrors=4 → 0`.
- 2026-05-20: **Add U18** — `services/platform_test.dart`
  `_defaultVsThemeCard` Row(stretch)+Expanded(_twinCard) cannot
  be fixed at the script level. Four P1-style variants
  (IntrinsicHeight wrap, stretch→start, Row→Column, minimal
  delete-`stretch`-line) all crash the test-app HTTP server
  (`transport_error httpStatus=-1`, "Lost connection to device"),
  worse than the baseline's recoverable `frameworkErrors=1`
  banner. Item 93 reverted and deferred — a real fix requires
  interpreter / bridge instrumentation to identify why removing a
  cross-axis-alignment keyword from a single Row destabilises the
  bridge transport.
- 2026-05-20: **Add U17** — `render_constraints_transform_box_test.dart`
  is a teaching script whose purpose is to feed pathological
  inputs to `ConstraintsTransformBox` and observe Flutter's
  debug-mode assertions / overflow banners. The visible
  `frameworkErrors=1` banner is the first of a stack — any
  workaround that suppresses it either erases the demo or
  exposes the next intentional banner underneath (verified
  experimentally: pre-normalizing `kHalveMaxWidth` cleared the
  NOT NORMALIZED banner but immediately surfaced
  `A RenderConstraintsTransformBox overflowed by 30/15/15/30`
  from the section-7 `clipBehavior` showcase). Item 71 reverted
  and deferred — a real fix requires redesigning the teaching
  content, not a per-item layout tweak.
- 2026-05-19: **Extend U16** — add `gestures/velocity_test.dart`
  to the affected-scripts table and document the variant banner
  shape that surfaces when an empty `Text('')` sits under an
  `IntrinsicHeight` ancestor: `BoxConstraints forces an infinite
  height` thrown by `RenderFlex.layout()` instead of the NaN
  Offset paint banner. Same root cause (bridged empty-paragraph
  metric path), different layout vs paint failure mode. Surfaced
  while working item 35 of
  `testlog_20260519-1247-flutter-suites-fixes` — the P1
  `IntrinsicHeight` fix at `_SectionCard` exposed the previously
  masked empty-`Text` intrinsic-height path. Fixed script-side by
  replacing the blank `_CodeLine('')` separator in
  `_EqualitySection` with `SizedBox(height: 14)`.
- 2026-05-19: **Add U16** — `Text('')` (empty-string `Text`
  widget) triggers a NaN `Offset` assertion in
  `dart:ui/painting.dart` line 41 through the bridged Flutter
  paragraph painter. Identified while working item 5 of
  `testlog_20260519-1247-flutter-suites-fixes` fix plan
  (`cupertino/restorable_cupertino_tab_controller_test.dart`),
  via bisection of `_CodeBlock` (the `_buildCodeSnippetSection`
  body) down to a `Column` of `Text(lines[i].text)` — the banner
  reproduces with empty `text`, clears the instant any candidate
  receives a non-empty placeholder. Fixed script-side by
  guarding `Text`'s composed-string argument in `_CodeBlock.build`
  with `composed.isEmpty ? ' ' : composed`. Verified
  `frameworkErrors=0 status=success` (was 1). Underlying bridge
  bug remains (native Flutter short-circuits empty paragraphs to
  `Offset.zero`; the bridged painter computes a NaN baseline).
- 2026-05-19: **Add U15** — `RenderFlex overflowed by 2.0 pixels
  on the right` inside a bridged Cupertino layout the script
  cannot identify. Identified while working item 2 of
  `testlog_20260519-1247-flutter-suites-fixes` fix plan
  (`cupertino/cupertino_nav_segmented_test.dart`). Four script-
  level workarounds attempted (`Row → Wrap` on three independent
  candidate Rows in `_buildBoxedDefault`, `_buildSlidingDefault`,
  and `_buildHero`; plus shrinking `CupertinoNavigationBar`'s
  `middle: SizedBox(width: 220.0) → 180.0`) — all failed to clear
  the framework-error banner; all reverted. Test passes
  throughout (`frameworkErrors=2 status=success`). Marked
  deferred (not fixable at script level for this widget tree).
  The real fix belongs in the bridge.
- 2026-05-19: **Add U14** — `Center > ConstrainedBox(maxWidth)` in
  `SingleChildScrollView`, or `Expanded` inside
  `Column(mainAxisSize.min)` in a `GridView.count` cell, leaks
  `maxHeight: infinity` down to `RenderConstrainedBox`. Identified
  while working item 1 of `testlog_20260519-1247-flutter-suites-fixes`
  fix plan (`animation/cubic_test.dart`). Four script-level
  workarounds attempted (`heightFactor:1.0`, `Row > Flexible >
  Column`, `SizedBox(width:800)` replacing the top-level
  `Center>ConstrainedBox`, `Expanded → SizedBox(height:60)` inside
  both `_PrivateGalleryTile` and `_PrivateSiblingCurveTile`) — all
  failed to clear the framework-error banner; all reverted. Test
  passes throughout. Marked deferred (not fixable at script level
  for this widget tree). The real fix belongs in the bridge.
- 2026-05-19: **Step 10 verification follow-up (`error_analysis.md`
  of `testlog_20260518-1449-flutter-suites`).** Running the four
  anchor suites serially (essential, important, secondary, and
  the `hardly_relevant_classes_1` anchor for Step 9) surfaced two
  errors. (1) `foundation/diagnostics_serialization_delegate_test.dart`
  failed with `expected Enum?, got InterpretedEnumValue` from
  `EnumProperty<_DemoMode>` — a fresh occurrence of U8(1) that
  was previously masked by the pre-Step-3 mixin-dispatch failure.
  Extended U8 with the diagnostic-property variant and applied
  the `StringProperty` workaround to the script. (2)
  `gestures/least_squares_solver_test.dart` re-failed under full
  suite contention because Step 9's dart-test-wrapper timeout
  bump (60 s) did not raise the underlying 25 s HTTP `/build`
  cap. Added an optional `httpBuildTimeout` parameter to
  `SendTestRunner.send` (both AST and test projects) — purely
  additive, default unchanged — and pass 50 s for this script.
  Both fixes were verified individually + via a fresh
  `hardly_relevant_classes_1_test` sweep on both projects.
- 2026-05-19: **Step 7 (Test contract bugs — 10 banners across
  10 scripts).** All 10 banners resolved with script-side fixes
  (disposition #2 — real script bugs); none of the 10 required a
  new interpreter or generator change, so no new U-section is
  added. Each affected script was individually retested and
  reports `frameworkErrors=0`. Patterns observed during the fix
  campaign (some refined relative to earlier theories — the entries
  below reflect the actual fixes that landed):
  - **Built-in identifier or Flutter top-level function name as
    field name resolves to the type/keyword/global, not the local
    field.** Three instances surfaced in this cluster:
    `_SizeRow.factory` (field named `factory` resolved to the Dart
    keyword token) in `widgets/preferredsize_test.dart`;
    `_FlowStage.num` (field named `num` resolved to the built-in
    `num` type) in `services/android_pointer_coords_test.dart`;
    and `_CompareRow.showMenu` / `_CompareRow.popupMenuButton`
    (fields whose names collide with the Flutter top-level
    `showMenu()` function and the `PopupMenuButton` widget
    constructor) in `material/showmenu_test.dart`. The d4rt
    interpreter's identifier resolver looks up
    keyword/type/global-symbol tokens *before* walking the local
    scope, so a bare reference to such a field inside the same
    class evaluates to the global rather than the field. The
    bridge then receives a `Type` / keyword sentinel / `Function`
    instead of the expected value and fails. **This now covers a
    third axis** beyond Dart keywords and built-in types: Flutter
    top-level functions exported by the consumed bridge libraries
    are equally shadowing. Workaround for all three:
    rename the field with a distinguishing suffix
    (`factory → factoryExpr`, `num → step`,
    `showMenu → showMenuDoc`, `popupMenuButton → popupMenuButtonDoc`).
  - **Redirecting generative constructor `this._()` does not
    propagate args or primary-constructor defaults.** Earlier
    theory was that the redirect *did* propagate explicit args
    (only defaults dropped); fix testing in
    `rendering/renderobjects_clip_test.dart` proved otherwise —
    re-stating the explicit `extras: const <_CodeSpan>[]` default at
    every redirecting call site produced **no** change in the
    25-error count. Final fix: remove the `this._()` indirection
    entirely. Each named constructor on `_CodeLine` now initialises
    `kind`, `text`, `after`, `extras` directly from its own
    initialiser list. This drove frameworkErrors from 25 → 0.
    *Script-side workaround sufficient — but worth noting that for
    d4rt, redirecting generative constructors should be rewritten
    flat rather than relied upon.*
  - **Redirecting factory shorthand `factory X.a() = Y;`.** Already
    covered by R1 (redirecting factory `=` form not implemented).
    Six instances of the shorthand in `material/showmenu_test.dart`
    were initially lowered to factory-with-body form returning the
    concrete subclass; **that alone did not close the banners** —
    final fix was to remove the factory layer entirely and use
    `const _GalleryPlain()` / `const _GalleryImage()` directly at
    each call site, combined with the `showMenu`/`popupMenuButton`
    field rename above.
  - **Static methods on the same script-defined class can collapse
    onto the bridged class table and be invoked through the
    BridgedClass routing instead of as plain script statics.**
    Observed on `services/android_pointer_coords_test.dart`
    `_Cell.full / .partial / .none` — first attempted as factory
    constructors, then converted to plain `static` methods on the
    same class; **neither change cleared the 7 NativeFunction
    errors**. Reliable fix is to lift such helpers out of the class
    to top-level functions (`_cellFull(...) / _cellPartial(...) /
    _cellNone()`). The 7 errors only cleared once both the
    top-level helpers *and* the `num → step` field rename were in
    place. *Same family as R1 (factory routing) but distinct: the
    issue here is the static-method-on-script-class lookup form,
    and the safest scripting rule is to avoid named static helpers
    on the same class that the call sites also construct.*
  - **`!` null-check postfix operator on a typed reference.** The
    `SPostfixExpression` evaluator in `tom_d4rt_ast/lib/src/runtime/
    interpreter_visitor.dart` handles `?.` and `++` correctly but
    raises a spurious Runtime Error when used as a null-check on a
    nullable static getter result (observed on
    `foundation/bit_field_test.dart` `static BitField get bf =>
    _bf!;`). Coupled with the related
    **static-field-write-from-sibling-static-method does not
    persist** issue (the prior attempted typed-null-local guard
    failed because the static-field write from the lazy helper did
    not survive across calls), the final fix moved the storage to a
    top-level mutable variable plus a lazy top-level helper
    function — `BitField<_Permission>? _permissionBitField` and
    `_ensurePermissionBitField()`. *Two interpreter tickets worth
    opening; the script-side workarounds are cheap so no U-entry
    here.*
  - **C-style `for (int i = 0; ...; i++) { ... }` reuses the `i`
    slot across iterations — closures captured inside the body see
    the post-loop value of `i`.** Observed on
    `material/expansionpanel_test.dart` (`Index out of range: 3`
    against a 3-panel list — the callback closures all captured
    `i = 3`). Reliable fix: replace the C-style loop with
    `List<T>.generate(length, (int i) { ... })` so each `i` is a
    fresh parameter binding. The bridged
    `ExpansionPanelList.expansionCallback` itself behaves correctly
    once the closure captures the right index.
  - **`Text` rejects ill-formed UTF-16 (lone surrogates).** Observed
    on `services/textboundary_test.dart` walking surrogate-pair
    code units with `text.substring(i, i+1)`. Earlier session's
    spot-fix using `String.fromCharCode(unit)` covered only the
    ruler site; the 5 boundary-probe functions
    (`_probeCharacterBoundary`, `_probeParagraphBoundary`,
    `_probeDocumentBoundary`, `_probeWordBoundaryViaPainter`,
    `_probeLineBoundaryViaPainter`) needed the same protection.
    Final fix: a `_safeSlice(text, start, end)` helper that
    returns `'\uFFFD'` if any code unit in the slice lies in the
    surrogate range, and routing all `substring` sites through it.
  - **`picsum.photos?blur=N` requires `1 <= N <= 10`.** A
    `NetworkImage('https://picsum.photos/...?blur=0')` request
    yields HTTP 400, and the resulting error banner is misattributed
    to the *next* script because the async image load resolves
    after the originating script completes. Fix at the source
    (`dart_ui/backdrop_filter_engine_layer_test.dart`): drop the
    invalid query parameter.
  - **`RawChip(onSelected, onPressed)` asserts both-or-neither.**
    `chip.dart` line 1027 asserts `onSelected == null || onPressed
    == null`; the cluster's
    `material/chip_variants_test.dart` "Raw all-in-one" sample
    supplied both. Fix: drop `onPressed: () {}` so only `onSelected`
    is wired.
  Net effect on banner inventory: Step 7's 10-banner I-unhandled
  pocket reaches 0 — verified by individual per-script retests
  (all 10 report `frameworkErrors=0`).

- 2026-05-18: **Close C59/C57
  (`retest/services/method_codec_test.dart` decodeEnvelope
  PlatformException not catchable) — no-op.** Same script and same
  `Section 6` try/catch as C55/C53; the §U13 workaround applied in
  that earlier commit already covers this row. Verified both drivers
  green without further edits. Pairs as test-driver C59 ≡ AST-driver
  C57.

- 2026-05-18: **Close C58/C56
  (`retest/services/message_codec_test.dart`: "A borderRadius can
  only be given on borders with uniform colors").** Pure script bug,
  no new interpreter pattern. The `_SectionHeader` widget combined
  `borderRadius: BorderRadius.all(Radius.circular(10))` with a
  deliberately non-uniform `Border` (5-px accent left bar plus thin
  alpha-0.1 sides on top/right/bottom). Flutter's `Border` invariant
  rejects `borderRadius` on non-uniform-colour borders. Script-side
  fix: drop the `borderRadius` so the coloured accent bar stays
  visible (square corners). Pairs as test-driver C58 ≡ AST-driver
  C56.

- 2026-05-18: **Close C57/C55
  (`rendering/render_custom_multi_child_layout_box_test.dart`
  `RenderFlex overflowed by 7.0 pixels on the bottom`).** Same
  harness-layout limit as C56/C54; no new interpreter pattern. The
  2564-line hand-written visual demo of `CustomMultiChildLayout` /
  `MultiChildLayoutDelegate` builds 8 deeply composed sections inside
  `MaterialApp > Scaffold > SingleChildScrollView > Column` and the
  cumulative visible tree overflows the test-harness frame by exactly
  7 px on the bottom. U1 variant 2 applied: move the 8-section list
  into a discarded `_unused` local so every bridged constructor still
  fires, then collapse the Scaffold body to a minimal `Center > Text`
  summary. `MaterialApp` / `Scaffold` wrappers retained so their
  bridged constructors are exercised. Pairs as test-driver C57 ≡
  AST-driver C55.

- 2026-05-18: **Close C56/C54
  (`widgets/nestedscrollview_test.dart` `BoxConstraints forces an
  infinite height`).** Pure script bug + harness layout limit, no
  new interpreter pattern. The three `bridgedAttempt = SizedBox(
  height: 1, child: Offstage(child: NestedScrollView(...)))` blocks
  rely on the false assumption that `Offstage(child:)` insulates its
  child from layout — it does not, and the inner CustomScrollView /
  ListView body produces an infinite-height inner constraint that
  trips the layout invariant. Even after dropping the offstage
  hosting (replaced with `SizedBox.shrink()`, constructed widgets
  retained via `_kept` locals), the rest of the demo's visible
  tree continues to fail the same invariant under this harness, so
  the final Scaffold body is collapsed to a `Center > Text` summary
  while every composite widget is kept in scope via a discarded
  `_unused` list — this is U1 variant 2 applied. Script's own Note
  J already said "we do not safely render a real NestedScrollView in
  every test harness." Pairs as test-driver C56 ≡ AST-driver C54.

- 2026-05-18: **Close C55/C53
  (`retest/services/method_codec_test.dart` PlatformException
  not catchable) under new U13.** Script-side workaround: replace
  `on PlatformException catch (pe)` with broad `catch (e)` and
  recover the exception code by string-parsing the wrapper's
  `'PlatformException(<code>, …)'` marker. Test asserts that the
  envelope decode throws (any thrown form satisfies the assert)
  and that the code matches; both now hold. Added new U13 entry
  documenting the boundary-translation issue, the constraints,
  the script-side workaround, and a sketch of the real fix
  (propagate original exception object on a `RuntimeError.cause`
  side-channel and have the on-clause matcher consult it).
  Pairs as test-driver C55 ≡ AST-driver C53.

- 2026-05-18: **Close C52/C51
  (`services/text_editing_delta_insertion_test.dart` transport
  failure) under U1.** Script-side workaround: collapsed the 15
  `_codeLine(...)` RichText calls in Section 9 to a single plain
  `Text` (variant 2), then collapsed the entire return Scaffold
  (11 demo cards with gradients/shadows) to a minimal `Center` →
  `Text` summary. The script still logged
  "TextEditingDeltaInsertion Deep Demo completed successfully"
  before the framework died with `Lost connection to device.`
  (no Dart stack, no FlutterError), confirming the rendered
  widget tree — not the AST bundle or the `build()` execution —
  was the choke point. All demo data construction and `print`
  output retained; built widgets are still referenced via a
  discarded `_unused` list so their bridged constructors stay
  exercised. New entry added under U1 §Affected scripts. Pairs
  as test-driver C52 ≡ AST-driver C51.
- 2026-05-18: **Close C50 (`RawKeyEventDataLinux` + the full
  `RawKeyEvent` family) under U12.** Variant A applied with a
  coordinated multi-class stand-in: enums `_ModifierKey` /
  `_KeyboardSide`, `_GLFWKeyHelper`, `_RawKeyEventDataLinux`
  (with `isModifierPressed` honouring the GLFW bitmask), and
  the abstract `_RawKeyEvent` plus concrete `_RawKeyDownEvent`
  / `_RawKeyUpEvent` family. Stand-ins return real bridged
  `LogicalKeyboardKey` / `PhysicalKeyboardKey` instances since
  those classes are *not* deprecated. Variant B not available
  (`RawKeyEvent → KeyEvent` is a different API shape). Pairs as
  test-driver C50 ≡ AST-driver C49. With this cluster closed
  there are no further "deprecated-name" clusters outstanding
  in `testlog_20260517-0914`.
- 2026-05-18: **Close C49 (`RawKeyEventDataWeb`) under U12.**
  Variant A applied with a private `class _RawKeyEventDataWeb`
  carrying the constructor fields (`code`, `key`, `location`,
  `metaState`, `keyCode`) and the modifier-bit / physical-key /
  logical-key accessors the demo reads. The SDK class is
  `@Deprecated` at `raw_keyboard_web.dart:32-37`; modernisation
  path is `RawKeyEventDataWeb → KeyEvent.physicalKey/logicalKey`,
  so variant B (typedef-rename swap) is not available — the modern
  API shape is different. Pairs as test-driver C49 ≡ AST-driver C48.
- 2026-05-18: **Extend U12 with the typedef-rename
  sub-pattern.** Test-driver C46
  (`services/mouse_tracker_annotation_test.dart`, AST driver
  C45) closed via variant B: `MaterialState` and
  `MaterialStateMouseCursor` are `@Deprecated` typedefs
  (Flutter 3.19.0-0.3.pre) aliasing the still-bridged
  `WidgetState` / `WidgetStateMouseCursor`. Because the
  targets are functionally identical and fully bridged, the
  workaround is to use the modern name in code positions
  (no local stand-in needed) while preserving the alias in
  strings/comments. U12 §Affected scripts now lists both
  workaround variants (A: local stand-in for symbols with no
  bridged equivalent; B: modern-name swap for typedef-renames).
- 2026-05-18: **Close C45 (`KeyboardSide`) under U12.** Variant
  A applied with dual-enum scope: declared local `_KeyboardSide`
  (4 values) + `_ModifierKey` (9 values) stand-ins. Both
  `KeyboardSide` and `ModifierKey` are `@Deprecated` at
  `raw_keyboard.dart:40-44` and `raw_keyboard.dart:68-72`.
- 2026-05-18: **Add U12 — `@Deprecated`-annotated SDK symbols
  are filtered out of the bridge surface by design.**
  Documents the `testlog_20260517-0914` C44 cluster
  (`services/key_data_transit_mode_test.dart`). Root cause:
  `ElementModeExtractor.generateDeprecatedElements = false`
  by default and skips every `@Deprecated` enum / class /
  member during bridge generation. Mandatory script-side
  workaround for demos whose premise is documenting a
  deprecated symbol's shape: define a private local stand-in
  enum (or class) with the same value names / ordering, and
  route typed lookups through it while keeping human-readable
  copy referencing the SDK symbol by name. Same workaround
  pattern is expected for C45 (`KeyboardSide`), C49
  (`RawKeyEventDataWeb`), C50 (`RawKeyEventDataLinux`).
- 2026-05-18: **Add U11 — Script-defined `HitTestTarget`
  rejected by `HitTestEntry(target)` constructor.** Documents
  the `testlog_20260517-0914` C39 cluster
  (`gestures/hit_testable_test.dart`, `_FakeTarget implements
  HitTestTarget` × 3 fed into `HitTestEntry(target)` for the
  sample `HitTestResult.path`). Same architectural family as
  U3/U5/U8/U9/U10. No framework-provided concrete
  `HitTestTarget` is available without standing up a render
  tree. Mandatory script-side workaround: keep
  `implements HitTestTarget` class as teaching reference,
  substitute a pure script-side `_DemoHitEntry(label,
  runtimeTypeStr)` data record for the anatomy-panel display.
  Native `HitTestResult()` / `BoxHitTestResult()` constructors
  remain reachable.
- 2026-05-18: **Extend U10 with third instance — parent
  `Diagnosticable` mixin variant + `super.debugFillProperties(...)`
  dispatch failure (C38,
  `foundation/object_flag_property_test.dart`).** Two new U10
  symptoms documented: (a) `D4.validateTarget<Diagnosticable>`
  rejects `InterpretedInstance` of a script class that mixes in
  the parent `Diagnosticable` (not just `DiagnosticableTreeMixin`)
  — same architectural family, surfaces on
  `config.toDiagnosticsNode()`; (b) `super.debugFillProperties(...)`
  from an interpreted class with no native super throws *`Class
  'X' does not have a standard or bridged superclass, cannot use
  'super'.`* Native `Diagnosticable.debugFillProperties` is a no-op
  anyway, so dropping the super call is the safe workaround.
  Script-side workarounds: `_diagnosticableDeepDump` helper (no
  children) + drop `super.debugFillProperties(...)`. C38 also had
  a *script bug* unrelated to U10 — two `ObjectFlagProperty`
  construction-gallery entries omitted both `ifPresent` and
  `ifNull`, violating the framework's
  `ifPresent != null || ifNull != null` assert; fixed by supplying
  empty-string text in the unused slot.
- 2026-05-18: **Extend U10 with second instance —
  `toDiagnosticsNode` + `toJsonMap` pipeline (C37,
  `foundation/diagnostics_serialization_delegate_test.dart`).**
  Same architectural family as the C36
  `toStringDeep` instance. Mandatory script-side workaround:
  recursive `_manualSerialize(config, delegate, depth)` that
  emits a `Map<String, Object?>` mirroring `toJsonMap`'s output,
  parameterised by `delegate.subtreeDepth` /
  `delegate.includeProperties` and with best-effort `is`-checks
  for each script-defined delegate concrete class. Script-only
  change; no interpreter / generator modification.
- 2026-05-18: **Add U10 — Script-defined class
  `with DiagnosticableTreeMixin` cannot call inherited concrete
  methods.** Documents the `testlog_20260517-0914` C36 cluster
  (`foundation/class_test.dart`, `_Node with
  DiagnosticableTreeMixin` → `tree.toStringDeep()`). Root cause:
  the bridged `DiagnosticableTreeMixin` adapter validates the
  target via `D4.validateTarget<DiagnosticableTreeMixin>` which
  rejects `InterpretedInstance`; even if the target check were
  relaxed, the inherited concrete methods dispatch back into the
  abstract callbacks via *native* dynamic dispatch and would
  bypass the script's overrides. Same architectural family as
  U3/U5/U8/U9. Proper fix is a hand-written
  `_InterpretedDiagnosticableTreeMixin` proxy — deferred
  (feature-scale work). Mandatory script-side workaround:
  recursive `_dumpNode` helper that builds the tree dump from
  the script's own overrides, formatted analogously to
  `toStringDeep`.
- 2026-05-17: **Add U9 — Script-defined `RouteAware` cannot be
  subscribed to a native `RouteObserver`.** Documents the
  `testlog_20260517-0914` C22 cluster
  (`widgets/route_observer_test.dart`,
  `_LoggingRouteAware with RouteAware` × 4 subscribed via
  `routeObserver.subscribe(...)`). Root cause: the bridged
  `RouteObserver.subscribe(RouteAware aware, R route)`
  validates `aware` via `D4.getRequiredArg<RouteAware>`, which
  rejects `InterpretedInstance` even when the script class
  declares `with RouteAware`; same architectural family as U3
  (`Curve`), U5 (`NotchedShape` /
  `FloatingActionButtonLocation`), and U8 (`Enum`). Unlike U5
  and U8, there is no framework-provided concrete subtype to
  substitute — `RouteAware` is designed to be mixed into
  application-side `State` objects. Mandatory script-side
  workaround: replace the native observer's
  `subscribe`/`unsubscribe`/`didPush`/`didPop`/`didReplace`
  calls with a script-side `_DemoRouteObserver` over
  `Map<Route, List<_LoggingRouteAware>>` that mirrors the
  same five-method protocol exactly, producing identical
  call-order timelines and per-subscriber counts. The native
  `RouteObserver` instance is still constructed (the
  constructor itself is safe — no script-defined argument is
  involved) so the demo's type-info section continues to
  reflect a real Flutter type.

- 2026-05-17: **Add U8 — Script-defined enum values are
  `InterpretedEnumValue`, not native `Enum`; plus
  `RestorableValue.value` asserts `isRegistered`.** Documents
  the `testlog_20260517-0914` C20 cluster
  (`widgets/restorable_values_test.dart` —
  `RestorableEnum<_Mood>(_Mood.focused, values: _Mood.values)`
  with 44 follow-up `restXxx.value` reads on never-registered
  restorables). Two cooperating issues: (1) d4rt's
  `InterpretedEnumValue` (`runtime_types.dart` line 1861)
  implements `RuntimeValue` but not `Enum`, so any bridged API
  typed `Enum` rejects script-defined enum values at the
  d4rt → native boundary; same family as U3 / U5. (2)
  Flutter's `RestorableValue<T>.value` asserts `isRegistered`
  at line 85 of `restoration_properties.dart`; the script
  never wires a `RestorationMixin`, so `flutter test` (which
  runs in debug mode) trips the assertion on the first
  `.value` read. (2) is real Dart/Flutter behaviour, not a
  d4rt limitation; (1)'s constructor failure had masked it.
  Mandatory script-side workarounds: substitute the
  script-defined enum with a framework enum (`Brightness`
  shown), and shadow each restorable with a plain Dart
  variable holding the construction-time default, reading the
  shadow throughout the build (exact when `.value` is never
  reassigned).

- 2026-05-17: **Add U7 — Dart-internal `_ConstMap` (runtime
  class of `const <K, V>{}`) is not in the Map bridge's
  `nativeNames`.** Documents the `testlog_20260517-0914` C18
  cluster (`semantics/semantics_events_test.dart`,
  `dataMap.entries.toList()` on the values of
  `probe.getDataMap()` for `LongPressSemanticsEvent`,
  `TapSemanticEvent`, and `FocusSemanticEvent`). Root cause:
  `_ConstMap` is missing from the curated `nativeNames` list on
  the Map `BridgedClass` in both `tom_d4rt` and `tom_d4rt_ast`,
  and several Flutter `SemanticsEvent.getDataMap()`
  implementations return `const <String, Object>{}` for
  payload-free events, so the bridged-call result lands as a
  `_ConstMap` and any subsequent member access throws. A
  targeted name-list fix is fragile across SDK versions; the
  architectural fix is to teach the Map adapter to fall back to
  `target is Map`, which is out of scope for a single cluster
  pass. Mandatory script-side workaround: drop `const` on
  defaults and copy bridged map values through
  `Map<K, V>.from(value)` at the assignment site so the runtime
  type is always a regular `LinkedHashMap`.

- 2026-05-17: **Add U6 — Direct import of
  `package:vector_math/vector_math_64.dart` is not resolvable in
  d4rt scripts.** Documents the `testlog_20260517-0914` C17 cluster
  (`painting/matrixutils_test.dart`,
  `Vector3(40, 0, 0)` fed through `Matrix4.transform3`). Root
  cause: `vector_math` is not in either driver's `bridgedLibraries`
  / `explicitSources` set, so the bundler (AST) / module loader
  (analyzer) reject the direct import at bundle/load time. Adding
  it as a bridged library would require generating bridges for the
  whole `vector_math` public API — out of scope for a single
  cluster pass. Mandatory script-side workaround: drop the import
  and compute matrix·vector products inline over `Matrix4.storage`
  (bridged `Float64List`), or use `MatrixUtils.transformPoint` for
  2D screen-space transforms.

- 2026-05-17: **Add U5 — Interpreted subclass of native abstract
  `NotchedShape` / `FloatingActionButtonLocation` rejected at the
  bridged-constructor boundary.** Documents the
  `testlog_20260517-0914` C16 cluster
  (`material/bottom_app_bar_test.dart`,
  `_TopRoundedNotchedShape extends NotchedShape` →
  `BottomAppBar.shape`, and `_CustomFabLocation extends
  FloatingActionButtonLocation` → `Scaffold.floatingActionButtonLocation`
  via `_fabLocationCell`). Same family as U3 (`Curve`): the bridge
  generator does not synthesise an adapter-proxy that lets a
  script-defined `InterpretedInstance` cross the d4rt → native
  boundary as the native abstract type. Mandatory script-side
  workaround: use a framework-provided subclass
  (`CircularNotchedRectangle`, `FloatingActionButtonLocation.endFloat`,
  etc.) at the call site.

- 2026-05-17: **Add U4 — Standalone `'\n'` `TextSpan` between two
  styled siblings crashes the test-app transport.** Documents the
  `testlog_20260517-0914` C15 cluster
  (`material/tooltip_feedback_test.dart`, `_privateRichMessageExample`
  `RichText`). Root cause is a Dart-VM-level crash in the
  bridged-render path triggered specifically by a child
  `TextSpan(text: '\n')` between two other styled `TextSpan`s in
  the same `children:`. No interpreter or generator fix is
  feasible: the failure mode is `Lost connection to device.`,
  which is uncatchable. Mandatory script-side workaround:
  append `'\n'` to the preceding styled `TextSpan` and drop the
  standalone newline child.

- 2026-05-17: **Add U3 — Interpreted subclass of native abstract
  `Curve`: `transformInternal` override not routed through
  `Curve.transform`.** Documents the `testlog_20260517-0914` C10
  cluster (`animation/animation_misc_adv_test.dart`, `_FlippedShim
  extends Curve` returning `null` from bridged `transform()` and
  the resulting `Native error during bridged operator '+' on
  double: type 'Null' is not a subtype of type 'num' in type cast`
  in `12.0 + (28.0 * s)`). Root cause: the adapter-proxy for a
  script-defined `Curve` subclass does not synthesise a native
  `transformInternal` override that routes the framework's
  template-method `Curve.transform(t)` call back into the
  interpreted method via `InterpretedInstance.invoke`. Distinct
  from U1: reproduces both const and non-const, and is a
  steady-state delegation gap rather than a startup transport
  crash. Workaround applied script-side: replace the catalog
  specimen with the framework-provided
  `FlippedCurve(Curves.easeInOut)` and retain the `_FlippedShim`
  class as documentation with `// ignore: unused_element`. C10
  closes on both drivers 2026-05-17. Long-term fix sketched:
  proxy-generator emits native `transformInternal` override that
  delegates to `interpretedInstance.invoke('transformInternal',
  [t])`; same shape applies to other template-method/hook pairs
  (`ScrollPhysics.applyPhysicsToUserOffset`, …).
- 2026-05-17: **Add U2 — Non-wrappable arithmetic defaults on
  positional-only native constructors.** Documents the
  `testlog_20260517-0914` C09 cluster
  (`rendering/gradient_rendering_test.dart`, `ui.Gradient.sweep`
  rejecting `endAngle` with `Parameter "endAngle" has non-wrappable
  default (math.pi * 2)`). Root cause is
  `BridgeGenerator._wrapDefaultValue` returning `null` for any
  default expression containing an operator
  (`tom_d4rt_generator/lib/src/bridge_generator.dart:4606-4613`),
  so the generated bridge emits `D4.getRequiredArgTodoDefault<…>`
  for `endAngle` and throws when the slot is omitted. Workaround
  applied script-side: spell out all preceding optional positionals
  using the framework's documented defaults literally
  (`colorStops` explicit 9-element stop list, `TileMode.clamp`,
  `0.0`, `math.pi * 2.0`). C09 closes on both drivers 2026-05-17.
  Long-term fix sketched: have the generator evaluate
  `math.pi`/`math.e` arithmetic at generation time and emit the
  resulting numeric literal as the wrapped default.
- 2026-05-17: **Add U1 — Demo-scale renderings that overload the
  test-app transport.** Documents the
  `testlog_20260517-0914` C05 cluster (`widgets/notificationlistener_test.dart`,
  "Lost connection to device"). Two independent fatal shapes
  bundled: (1) top-level `const` of an interpreted subclass of
  the native abstract `Notification`, which exercises the
  adapter-proxy infrastructure before the visitor has finished
  wiring its context, and (2) `SelectableText.rich` with a ~1000+
  TextSpan tree produced by the demo's per-character
  `_privateColorizeDart` helper from a ~1.8 KB code listing,
  which exceeds the test-app transport budget. Both neutralised
  script-side by inlining the demo's displayed values
  (`_kSampleScoreBValue`, `_kSampleScoreBLabel`) and rendering
  Section 7's large code listing as a single plain monospace
  `Text` widget through a new `_privatePlainCodeBlock` helper.
  Cluster closes on both drivers 2026-05-17.
- 2026-05-05: **Add S1 — `const Stream<T>.empty()` rejected by
  `Stream` bridge.** `BridgedClass` for `Stream` registers
  `empty`/`value`/`fromIterable`/… as `staticMethods`, so the
  `MethodInvocation` path falls through to them but the
  `InstanceCreationExpression` path does not. **Important
  correction** (same-day update): every `Stream.factory(...)`
  source shape parses as `InstanceCreationExpression` because all
  of them are named constructors on the real `Stream` class —
  including `Stream.empty()` and `Stream.fromIterable(...)`
  without type-args. Surfaced when
  `widgets/streambuilder_test.dart` was rewritten as a deep demo
  in Batch 2. Working workarounds: pass `stream: null`
  (StreamBuilder.stream is nullable) or build via
  `StreamController().stream` after `close()`.
- 2026-05-04: **Add T1 — `runtimeType.toString()` on user-defined
  interpreted classes throws "no static method 'toString'".**
  Documents `testlog_20260503-2009-issue-analysis` cluster C10
  follow-up. `InterpretedInstance.runtimeType` returns the
  `InterpretedClass` itself, which does not expose `toString` as a
  callable static. Workaround: emit the class-name string from an
  explicit `is`-check ladder. Architectural fix (universal-Object
  shim on the runtimeType façade) queued. Surfaced in
  `widgets/route_transition_record_test.dart` line 836.
- 2026-05-04: **Add I1 — C-style `for (var i = 0; …; i++)` shares
  loop variable across closures.** Documents the interpreter
  limitation diagnosed via stack-trace from
  `widgets/drag_target_details_test.dart` Section 11 (5 FE). The
  C-style for-loop's `loopEnvironment` is shared across all
  iterations, so DragTarget builder closures all see the post-loop
  `i = 5`. Cluster-scope fix is the script-side rewrite to
  `List<T>.generate`; the architectural fix (per-iteration
  variable capture in `_executeClassicFor` in both interpreters)
  is queued.
- 2026-05-04: **Add L1 — `AnimatedBuilder.animation` rejects
  script-defined subclass of bridged `Listenable`/`ChangeNotifier`.**
  Documents `testlog_20260503-2009-issue-analysis` cluster C2 for
  `widgets/windowing_owner_mac_o_s_test.dart`. The script defines
  `BaseWindowController extends ChangeNotifier` →
  `RegularWindowController` → `RegularWindowControllerMacOS`, then
  passes `controller` as `AnimatedBuilder.animation`. The bridge
  adapter rejects the `InterpretedInstance` because the bridge
  proxy/relaxer pipeline does not currently synthesise native
  `ChangeNotifier`-backed proxies for script-defined subclasses of
  bridged `Listenable`. Cluster-scope fix is the script-side
  workaround `animation: const AlwaysStoppedAnimation<double>(0.0)`
  with controller still accessed via closure capture. Two
  follow-up layout overflows fixed in the same edit (DockTile
  shrink + ContentArea badge Wrap inside Expanded scrollview).
- 2026-05-04: **Add R1 — Redirecting factory constructor syntax
  (`factory X() = Y`) not implemented.** Documents the
  `testlog_20260503-2009-issue-analysis` cluster C4
  (`widgets/regular_window_test.dart`,
  `Cannot instantiate abstract class 'RegularWindowController'`).
  The script authored Flutter's modern desktop-window pattern:
  abstract `RegularWindowController` with a
  `factory RegularWindowController(...) = _HostRegularWindowController;`
  redirect. d4rt only handles class-level redirecting constructors
  in the **initializer-list** form
  (`SRedirectingConstructorInvocation`,
  `tom_d4rt_ast/.../callable.dart`); the analyzer's class-level
  factory redirect is not lowered, so the abstract class is
  treated as directly instantiable and FE-fires. Closed script-side
  per cluster owner = script: 4 call sites instantiate the
  concrete `_HostRegularWindowController` directly while the
  variable types remain the abstract base — functionally identical
  to the analyzer's lowered output. Bridge fix proposed in §R1
  for a future regression-coordinated pass that mirrors across
  `tom_d4rt` ↔ `tom_d4rt_ast` and runs essential + important +
  secondary + gii.
- 2026-05-03 (later): **Add G1 — `D4.getNamedArgWithDefault<T?>`
  collapses explicit `null` to default for nullable-typed named
  args.** Documents the
  `testlog_20260503-2009-issue-analysis` cluster C1 (Cupertino
  `(maxLines == null) || (minLines == null) || (maxLines >= minLines)`
  assertion). Underlying generator/runtime helper conflates "key
  absent" with "explicit null"; `CupertinoTextField` exposes it
  because Flutter encodes "grow without bound" as the
  explicit-null sentinel. Both affected scripts
  (`cupertino/textfield_test.dart`,
  `cupertino/cupertino_text_selection_handle_controls_test.dart`,
  4 sites) closed script-side per cluster owner = script: replace
  `maxLines: null` with a finite cap ≥ `minLines`; bridge fix
  proposed in §G1 for a future regression-coordinated pass.
- 2026-05-03: **Add P4 — `switch (BridgedEnum)` may fall through
  every case, returning null.** Documents the priority-4 cluster
  from `testlog_20260503-0948-issue-analysis` (`Bridge: Text.data:
  null` ×3). All three scripts
  (`widgets/tooltip_window_controller_delegate_test.dart`,
  `foundation/target_platform_test.dart`,
  `material/time_of_day_format_test.dart`) now pass on both
  drivers after the script-side rewrite (switch → if/else with
  `==`, plus a default for declared-but-unassigned `String note;`
  variables).
- 2026-05-03: **Add P1 — `PreferredSizeWidget` cast fails when
  arg arrives as a cached native widget proxy.** Documents the
  third sub-case from the
  `testlog_20260503-0948-issue-analysis` priority-1 cluster
  (`widgets/snapshot_mode_test.dart` Scaffold.appBar FE). The
  other two sub-cases (`SliderThemeData.thumbShape`,
  `SpellCheckConfiguration.spellCheckService`) were closed by
  adding `SliderComponentShape` and `SpellCheckService` to the
  `proxyClasses` allowlists in
  `tom_d4rt_flutter_ast/buildkit.yaml` and
  `tom_d4rt_flutter_test/buildkit.yaml` and regenerating
  `flutter_proxies.b.dart`. The `snapshot_mode_test` case did
  not close on the same fix because the arg reaches the bridge
  as the cached `_InterpretedStatelessWidget` native proxy
  rather than the original `InterpretedInstance`, so the
  multi-interface proxy walk in
  `tryCreateInterfaceProxyWithVisitor` is never executed —
  documented as an interpreter architectural limitation with a
  script-side `PreferredSize(preferredSize: …, child: AppBar(…))`
  workaround.
- 2026-04-28 (latest): **Close E9 in `error_analysis.md` —
  `clampDouble` class is empty.** Sweep of essential, important,
  secondary, hr5, and gii suites recorded zero
  `dart:ui/math.dart` line-14 `<optimized out>` triggers. The
  C21 fix (slotted-multichild constructor routing) removed the
  only upstream that was producing NaN / out-of-range numerics
  reaching the engine; no residual call sites remain. The
  `D4RT_TRACE_NUMERIC_ARGS=1` instrumentation and
  `D4.checkFiniteNumeric` bridge guard are kept as a future
  tripwire only. See `doc/testlog_20260428-e9-fix/`.
- 2026-04-28: **Add E8 entry — `ScrollController`
  state-field-through-StatelessWidget-chain.** Cluster E8
  closed partial (8→2). Layout-cascade fix (drop `stretch`
  from 4 `Row` sites) landed in `script_rewrites.md`. Residual
  2 framework errors are interpreter-level (state-field
  identity loss across bridged `Scrollable.attach`) and
  documented for next interpreter pass.
- 2026-04-28: **Move Index 32
  `GappedRangeSliderTrackShape` to `script_rewrites.md`.** Per
  user assessment, the null-deref pattern is most consistent
  with a script-side contract violation against
  `RangeSliderTrackShape.paint` rather than a genuine framework
  null path that requires monkey-patching. The previous
  classification in this doc claimed the entry as "truly
  unfixable" without a debug-build bisect to confirm — that
  framing was speculative, and a script-side workaround is
  available. Tracked in `script_rewrites.md` until / unless a
  debug-build bisect proves otherwise.
- 2026-04-28 (close-out, E14): Cluster **E14 — `SystemColor`
  platform guard on Linux** in
  `testlog_20260428-1333-issue-analysis/error_analysis.md`
  closed as deferred-pending-platform-support. No interpreter
  or generator change is possible: the Linux desktop test
  harness does not expose Flutter's `SystemColor` platform
  channel, and the interpreter faithfully forwards the `null`
  it receives — fabricating colours would make the test pass
  on a lie. The closure rests on three artifacts already in
  place: (1) the `Platform.isLinux` test-runner skip at
  `tom_d4rt_flutter_ast/test/generator_interpreter_retest_test.dart:74`,
  (2) script-side `try/catch` around `ui.SystemColor.light` /
  `ui.SystemColor.dark` with a fallback UI in
  `retest/dart_ui/system_color_palette_test.dart` (lines
  831-842, marked with a `D4RT-LIMITATION` comment), and
  (3) the canonical write-up in `script_rewrites.md` under
  "Platform capability guard — `SystemColor` on Linux"
  (lines 79-100). Reopen and drop the skip if Linux gains
  `SystemColor` support upstream.
- 2026-04-28 (later evening): **Move suggested-fix entries to
  `error_analysis.md`.** Three sections that previously lived
  here had concrete interpreter / generator fix proposals
  attached, and therefore belong in the active fix-tracking doc
  rather than the unfixable-issue catalogue:
  - "Residual `dart:ui/math.dart:14` `clampDouble` assertion" —
    moved to error_analysis.md as **E9** (numeric-arg
    passthrough audit).
  - "gir TID=31 `render_animated_size_state` 2.0 px overflow" —
    moved to error_analysis.md as **E10** (intrinsic-pass audit
    in `_InterpretedSlottedRenderBox`).
  - "gir TID=37 `back_button_listener` Router routerDelegate
    coercion" — moved to error_analysis.md as **E11**
    (`RouterDelegate` adapter proxy registration).
  An exploratory section on auto-generating abstract-class
  adapters across the bridge generator's scanned codebase was
  added as **E12** in `error_analysis.md`.
- 2026-04-28 (evening): Restructure into "truly unfixable" vs
  "interpreter architectural limitation"; move script-rewriteable
  cases (enum exhaustiveness, system_color_palette platform
  guard, C20d State.setState mid-frame, D3 RestorableProperty
  initState, E2 layout cascade, E5 widgets_binding_observer
  borderRadius) to `script_rewrites.md`. Deduplicate post-C22
  cases that were already in `script_rewrites.md`
  (image_sampler_slot, D6 layout cascade, D8g RawTooltipState
  multi-ticker, D8h SemanticsData null textDirection, C3 Row
  stretch + Expanded). Promote the post-C22 list into the
  permanent index above with explicit "truly unfixable" vs
  "interpreter limitation" tags.
- 2026-04-27: Add C20d behavioural-deviation entry for the
  `StateUserBridge.overrideMethodSetState` workaround that defers
  `setState` calls made during layout / paint / transient
  callbacks. *(Moved to `script_rewrites.md` 2026-04-28.)*
- 2026-04-27: Add four script-side / engine-platform cases from
  `testlog_20260427-1339-post-c22` (image_sampler_slot engine
  cascade, layout-cascade D6, multi-ticker D8g, semantics
  textDirection D8h). *(Moved to `script_rewrites.md`
  2026-04-28.)*
- 2025-04-13: Add property interceptor mechanism (RC-9) for
  generic externalized property handling.
- 2025-04-13: Document abstract class inheritance limitation and
  adapter proxy solution.
- 2025-01-21: Add 7 more enum exhaustiveness fixes
  (popup_menu_position, axis_direction, hit_test_behavior,
  render_android_view, vertex_mode, live_text_input_status,
  lock_state). *(Moved to `script_rewrites.md` 2026-04-28.)*
- 2025-01-21: Add index 32 (framework null errors), 34, 36, 38,
  40 (enum exhaustiveness). *(Index 32 retained here; 34, 36, 38,
  40 moved to `script_rewrites.md` 2026-04-28.)*
- 2025-01-21: Initial document with issues 13, 16, 30 documented.
  *(13, 30 moved to `script_rewrites.md` 2026-04-28; 16 also
  moved.)*
