# Instructions
  * Clone SQLSync `git clone https://github.com/orbitinghail/sqlsync` and then this repo next to it.
  * Deploy backend from `sqlsync/demo/cloudflare_backend`: `pnpm dev`. Equivalent of `cd reducer && cargo build --target wasm32-unknown-unknown --package reducer '--release'`.
  * Build reducer from `fleetmanager`: `just wasm-demo-reducer`.
  * Upload reducer to backend from `fleetmanager`: `just upload-demo-reducer`.
  * Deploy frontend from `fleetmanager/frontend`: `pnpm i; pnpm dev`