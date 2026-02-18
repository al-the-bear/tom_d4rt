# UAM Analyzer Results

Analysis of `tom_uam_server` and all `tom_*` dependencies using `EntryPointAnalyzer`.

## Configuration

**Entry Points Analyzed:**
- `tom_uam_server/bin/aa_server_start.dart`
- `tom_uam_codespec/lib/tom_uam_codespec.dart`
- `tom_core_kernel/lib/tom_core_kernel.dart`
- `tom_reflection/lib/tom_reflection.dart`
- `tom_basics/lib/tom_basics.dart`
- `tom_crypto/lib/tom_crypto.dart`

**Dependency Configuration:**
- Type annotations: enabled, transitive, external, include argument types
- Marker annotations: `tomReflection`, `TomReflectionInfo`

## Summary

| Category | Count |
|----------|-------|
| Classes | 599 |
| Enums | 3 |
| Mixins | 0 |
| Extensions | 0 |
| Global Functions | 40 |
| Global Variables | 46 |

## Key Global Variables

Notable reflection-related variables found:
- `tomReflector` (const)
- `tomReflectionInfo`
- `tomComponent` (const)
- `tomExecutionContext`
- `tomRemoteApis`
- `tomShutdownCleanup`
- `tomNull`
- `tomLog`

## Files

- **Tabular output**: [uam_analyzer.txt](uam_analyzer.txt)
