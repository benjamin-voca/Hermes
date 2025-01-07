# Justfile

# Variables for directories
frontend_dir := "src"
backend_dir := "src-tauri"
purescript_dir := "src-pure"

ship:
    pnpm tauri android build --target armv7
