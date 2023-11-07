SQLSYNC_PROD_URL := "https://sqlsync.orbitinghail.workers.dev"

wasm-reducer:
    #!/usr/bin/env bash
    cd reducer && cargo build --target wasm32-unknown-unknown --package reducer '--release'

upload-reducer target='local':
    #!/usr/bin/env bash
    echo "[INFO] Rebuilding reducer"
    just wasm-reducer
    set -euo pipefail
    cd ../sqlsync/demo/cloudflare-backend
    REDUCER_PATH="../../../sqlsync-wrapper/reducer/target/wasm32-unknown-unknown/release/reducer.wasm"
    
    if [[ '{{target}}' = 'remote' ]]; then
        echo "Uploading $REDUCER_PATH to sqlsync prod"
        curl -X PUT --data-binary @$REDUCER_PATH {{SQLSYNC_PROD_URL}}/reducer
    else
        echo "Uploading $REDUCER_PATH to localhost:8787"
        curl -X PUT --data-binary @$REDUCER_PATH http://localhost:8787/reducer
    fi