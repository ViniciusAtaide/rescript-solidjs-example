import { defineConfig } from 'vite';
import solidPlugin from 'vite-plugin-solid';

export default defineConfig({
  plugins: [
    solidPlugin({
      // Enable solid plugin to process .mjs files from ReScript
      extensions: ['.jsx', '.tsx', '.mjs'],
    })
  ],
  build: {
    target: 'esnext',
  },
  esbuild: {
    // Let Solid plugin handle JSX
    jsx: 'preserve',
  }
});
