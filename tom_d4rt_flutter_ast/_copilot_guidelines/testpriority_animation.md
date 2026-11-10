# Test Priority: animation

The hand-maintained tiers of the bridged classes, the input of `tool/testplan_report.dart`. Every row names a class the bridges register (the guard `test/testplan_fresh_test.dart` checks it); a bridged class no priority file names is Hardly Relevant. The counts and coverage are measured in the generated `testplan_*.md` files.

## Essential
Core classes used in virtually every Flutter application.

| Class | Description |
|-------|-------------|
| AnimationController | Animation control - fundamental |
| Animation | Base animation class |
| Curve | Easing curves |
| CurvedAnimation | Animation with curve |
| Tween | Value interpolation |

## Important
Commonly used classes for intermediate Flutter development.

| Class | Description |
|-------|-------------|
| AnimationStyle | Animation styling |
| AlwaysStoppedAnimation | Static animation value |
| Animatable | Base animatable |
| CompoundAnimation | Combined animations |
| ProxyAnimation | Animation proxy |
| ReverseAnimation | Reversed animation |
| TrainHoppingAnimation | Animation switching |
| TweenSequence | Sequenced tweens |
| TweenSequenceItem | Sequence item |
| FlippedTweenSequence | Reversed sequence |

## Secondary
Specialized classes for advanced use cases.

| Class | Description |
|-------|-------------|
| AnimationMax | Max of animations |
| AnimationMin | Min of animations |
| AnimationMean | Average of animations |
| AnimationWithParentMixin | Parent animation mixin |

## Hardly Relevant
Internal/low-level classes rarely used directly.

| Class | Description |
|-------|-------------|
| AnimationEagerListenerMixin | Eager listener mixin |
| AnimationLazyListenerMixin | Lazy listener mixin |
| AnimationLocalListenersMixin | Local listeners mixin |
| AnimationLocalStatusListenersMixin | Status listeners mixin |
