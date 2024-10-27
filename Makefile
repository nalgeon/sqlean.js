build:
	esbuild --bundle --minify --target=es2021 --format=iife src/sqlean.js --outfile=dist/sqlean.js
	esbuild --bundle --minify --target=es2021 --format=esm src/sqlean.mjs --outfile=dist/sqlean.mjs
	cp src/sqlean.wasm dist/sqlean.wasm
	curl -s -S -L -o "dist/sqlean.d.ts" "https://raw.githubusercontent.com/sqlite/sqlite-wasm/refs/heads/main/index.d.ts"
