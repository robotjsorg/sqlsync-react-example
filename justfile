SQLSYNC_PROD_URL := "https://sqlsync.orbitinghail.workers.dev"

wasm-reducer:
    #!/usr/bin/env bash
    cd reducer && cargo build --target wasm32-unknown-unknown --package reducer '--release'

upload-reducer target='local':
    #!/usr/bin/env bash
    just wasm-reducer
    set -euo pipefail
    REDUCER_PATH="reducer/target/wasm32-unknown-unknown/release/reducer.wasm"
    if [[ '{{target}}' = 'remote' ]]; then
        curl -X PUT --data-binary @$REDUCER_PATH {{SQLSYNC_PROD_URL}}/reducer
    else
        curl -X PUT --data-binary @$REDUCER_PATH http://localhost:8787/reducer
    fi
