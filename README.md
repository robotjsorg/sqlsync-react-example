# SQLSync React
These are instructions for implementing the example React client with [SQLSync](https://github.com/orbitinghail/sqlsync) by [orbitinghail](https://github.com/orbitinghail).

 [YouTube tutorial video](https://www.youtube.com/watch?v=lGgwNot5OEc)

## Build SQLSync
* Clone SQLSync: `git clone https://github.com/orbitinghail/sqlsync`
* Run the commands below one at a time:
```
cd sqlsync
just build
just run-with-prefix 'wasm-'

cd sqlsync/lib/sqlsync-worker
pnpm install @rollup/plugin-node-resolve

cd sqlsync
just package-sqlsync-worker dev

cd sqlsync/demo/cloudflare-backend
pnpm i
```

## Build SQLSync React Example
* Clone this repo alongside SQLSync: `git clone https://github.com/jmcmahon443/sqlsync-react-example`
```
├── sqlsync/
└── sqlsync-react-example/
```

### Local
* Deploy backend using `pnpm dev` from `sqlsync/demo/cloudflare-backend/`
* Build and upload reducer to local backend using `just upload-reducer` from `sqlsync-react-example/`
* Build and deploy frontend using `pnpm i; pnpm dev` from `sqlsync-react-example/frontend/`

### Remote
These are instructions for deploying to Cloudflare.

#### Backend
* Manually update `name` and `bucket_name` in `wrangler.toml` in `sqlsync/demo/cloudflare-backend/` to match the intended Cloudflare Worker name and R2 Bucket name.
* Manually update `SQLSYNC_PROD_URL` in `justfile` in `sqlsync-react-example/` to intended Cloudflare Worker URL
* Deploy backend using `npx wrangler deploy` from `sqlsync/demo/cloudflare-backend/`
* Upload reducer to remote backend using `just upload-reducer remote` from `sqlsync-react-example/`

#### Frontend
* Manually update `COORDINATOR_URL` in `main.tsx` in `sqlsync-react-example/demo/frontend/` to intended Cloudflare Worker URL
* Build the frontend distribution using `npx vite build` from `sqlsync-react-example/frontend/`
* Double check `.wasm` files are under 25MB (for example, should be 2MB compared to 60MB)
* Manually upload `sqlsync-react-example/frontend/dist/` to Cloudflare Pages
