import { defineConfig } from 'vite';
import { exec } from 'child_process';

// Function to run a shell command
function runSpagoBuild() {
    return new Promise((resolve, reject) => {
        exec('spago build', (error, stdout, stderr) => {
            if (error) {
                console.error(`Error during Spago build: ${error.message}`);
                reject(error);
            } else {
                console.log(stdout);
                if (stderr) console.error(stderr);
                resolve();
            }
        });
    });
}

export default defineConfig({
    server: {
        watch: {
            // Watch the src directory for changes
            ignored: ['!**/src/**']
        },
    },
    build: {
        rollupOptions: {
            input: 'dist/index.js', // Specify your compiled JS file as the entry point
        },
    },
    plugins: [
        {
            name: 'spago-watch',
            configureServer(server) {
                server.watcher.on('all', async (event, path) => {
                    if (path.endsWith('.purs')) {
                        console.log(`[Spago] File changed: ${path}. Rebuilding...`);
                        try {
                            await runSpagoBuild();
                        } catch (error) {
                            console.error('Spago build failed:', error);
                        }
                    }
                });
            },
        },
    ],
});
