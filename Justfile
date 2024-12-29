# Justfile

# Variables for directories
frontend_dir := "src"
backend_dir := "src-tauri"
purescript_dir := "src-pure"

# Dev command to auto-reload frontend, backend, and PureScript
dev:
    @echo "Starting development mode..."
    # Watch PureScript changes and compile them, along with frontend/backend
    concurrently --kill-others \
        "cd {{frontend_dir}} && pnpm run dev" \
        "cargo watch -x 'run' -c -w {{backend_dir}}/src -w {{backend_dir}}" \
        "cd {{purescript_dir}} && spago build --watch"

# Bundle command for production builds
bundle:
    @echo "Building the app for production..."
    # Build PureScript
    cd {{purescript_dir}} && spago build
    # Build the backend
    cargo build --release --manifest-path={{backend_dir}}/Cargo.toml
    # Build and bundle with Tauri
    cd {{backend_dir}} && tauri build
    @echo "App has been successfully bundled!"
    
    
