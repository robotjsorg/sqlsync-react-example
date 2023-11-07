# SQLSync Wrapper
These are instructions for wrapping [SQLSync](https://github.com/orbitinghail/sqlsync) by [orbitinghail](https://github.com/orbitinghail).

## Build SQLSync
* Clone SQLSync: `git clone https://github.com/orbitinghail/sqlsync`
* Manually delete ALL node_modules folders in `/demo/frontend`, `/demo/cloudflare_backend`, and `/lib/sqlsync-worker` 
* Run the commands below once at a time:
```
cd sqlsync
rustup target add wasm32-unknown-unknown
just build
just run-with-prefix 'wasm-'
just wasm-demo-reducer --release
just package-sqlsync-worker dev
cd sqlsync/demo/cloudflare_backend
pnpm i
```

## Build SQLSync Wrapper
* Clone this repo alongside SQLSync: `git clone https://github.com/jmcmahon443/sqlsync-wrapper`  

### Local
* Deploy backend using `pnpm dev` from `sqlsync/demo/cloudflare_backend`: `cd path/to/sqlsync/demo/cloudflare_backend && pnpm dev`
* Build reducer using `just wasm-reducer` from `sqlsync-wrapper`: `cd path/to/sqlsync-wrapper && just wasm-reducer` Equivalent of: `cd reducer && cargo build --target wasm32-unknown-unknown --package reducer '--release'`
* Upload reducer to local backend using `just upload-reducer` from `sqlsync-wrapper`: `cd path/to/sqlsync-wrapper && just upload-reducer`
* Deploy frontend using `pnpm i; pnpm dev` from `sqlsync-wrapper/frontend`: `cd path/to/sqlsync-wrapper/frontend && pnpm i; pnpm dev`

### Remote
* Manually update `name` and `bucket_name` in `wrangler.toml` in `sqlsync/demo/cloudflare_backend/` to match the intended Cloudflare Worker name and R2 Bucket name.
* Manually update `SQLSYNC_PROD_URL` in `justfile` in `sqlsync-wrapper/` to intended Cloudflare Worker URL
* Deploy backend using `npx wrangler deploy` from `sqlsync/demo/cloudflare_backend`: `cd path/to/sqlsync/demo/cloudflare_backend && npx wrangler deploy`
* Upload reducer to remote backend using `just upload-reducer remote` from `sqlsync-wrapper`: `cd path/to/sqlsync-wrapper && just upload-reducer remote`
* `cd demo/frontend`
* Update `COORDINATOR_URL` in `main.tsx` in `sqlsync-wrapper/demo/frontend/` to intended Cloudflare Worker URL
* `npx vite build`
* Double check .wasm files are under 25MB (for example, should be 2MB compared to 60MB)
* Manually upload `path/to/sqlsync-wrapper/frontend/dist/` to Cloudflare Pages

### TODO: Test if required
* `cd path/to/sqlsync/lib/sqlsync-worker && pnpm install @rollup/plugin-node-resolve`
* `cd path/to/sqlsync-wrapper/frontend && pnpm add @orbitinghail/sqlsync-react @orbitinghail/sqlsync-worker`
