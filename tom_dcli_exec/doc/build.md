# Build Instructions

To build the `tom_d4rt_dcli` (dcli) tool, follow these steps:

1. **Delete generated files**: Delete all `*.g.dart` files in the project to ensure a clean build.
   ```bash
   find . -name "*.g.dart" -delete
   ```
2. **Generate bridges**: Run the build runner to generate the necessary target bridges.
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
3. **Compile**: Compile the tool using the local `compile.sh` script or the workspace build tools.
