# Test Priority: semantics

The hand-maintained tiers of the bridged classes, the input of `tool/testplan_report.dart`. Every row names a class the bridges register (the guard `test/testplan_fresh_test.dart` checks it); a bridged class no priority file names is Hardly Relevant. The counts and coverage are measured in the generated `testplan_*.md` files.

## Essential
Core classes for accessibility.

| Class | Description |
|-------|-------------|
| SemanticsProperties | Accessibility properties |
| SemanticsConfiguration | Semantics config |
| SemanticsNode | Accessibility tree node |
| CustomSemanticsAction | Custom a11y action |

## Important
Commonly used accessibility classes.

| Class | Description |
|-------|-------------|
| SemanticsService | Accessibility services |
| SemanticsOwner | Semantics tree owner |
| SemanticsData | Accessibility data |
| SemanticsHintOverrides | Hint overrides |
| SemanticsTag | Tagging for semantics |
| SemanticsSortKey | Sort ordering |
| OrdinalSortKey | Numeric sort key |
| AttributedString | Attributed text |

## Secondary
Specialized accessibility classes.

| Class | Description |
|-------|-------------|
| SemanticsHandle | Semantics handle |
| SemanticsBinding | Semantics binding |
| SemanticsEvent | Accessibility events |
| SemanticsLabelBuilder | Label building |
| ChildSemanticsConfigurationsResult | Child configs |
| ChildSemanticsConfigurationsResultBuilder | Config builder |

## Hardly Relevant
Internal/shared classes.

| Class | Description |
|-------|-------------|
| AttributedStringProperty | Diagnostics property |
