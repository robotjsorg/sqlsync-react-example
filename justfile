wasm-demo-reducer:
    cd reducer && cargo build --target wasm32-unknown-unknown --package reducer '--release'

upload-demo-reducer:
    #!/usr/bin/env bash
    set -euo pipefail
    cd ../sqlsync/demo/cloudflare-backend
    REDUCER_PATH="../../../fleetmanager/reducer/target/wasm32-unknown-unknown/release/reducer.wasm"
    echo "Uploading $REDUCER_PATH to localhost:8787"
    curl -X PUT --data-binary @$REDUCER_PATH http://localhost:8787/reducer