# Build Instructions

To build the `tom_d4rt_dcli` (dcli) tool, follow these steps:

1. **Generate bridges**: Run `d4rtgen`, which reads the `d4rtgen:` block of
   `buildkit.yaml`.
   ```bash
   dart run tom_d4rt_generator:d4rtgen -p .
   ```
3. **Compile**: Compile the tool using the local `compile.sh` script or the workspace build tools.
