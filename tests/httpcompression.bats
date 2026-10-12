#!/usr/bin/env bats

readonly SCRIPT="${BATS_TEST_DIRNAME}/../home/dot_local/bin/executable_httpcompression"

setup() {
    STUB_DIR="$(mktemp -d)"
    export CURL_LOG="${STUB_DIR}/urls"
    export CURL_FIRST_DONE="${STUB_DIR}/first.done"
    : > "${CURL_LOG}"

    cat > "${STUB_DIR}/curl" <<'STUB'
#!/usr/bin/env bash
url="${@: -1}"
printf '%s\n' "$url" | tr -d '\r' >> "${CURL_LOG}"
if [ -e "${CURL_FIRST_DONE}" ]; then
    printf 'HTTP/1.1 200 OK\r\nContent-Encoding: gzip\r\n\r\n'
else
    : > "${CURL_FIRST_DONE}"
    printf 'HTTP/1.1 200 OK\r\nGet-Dictionary: /dict1\r\nGet-Dictionary: http://example.com/dict2\r\nContent-Encoding: gzip\r\n\r\n'
fi
STUB
    chmod +x "${STUB_DIR}/curl"

    printf '#!/usr/bin/env bash\ncat\n' > "${STUB_DIR}/openssl"
    chmod +x "${STUB_DIR}/openssl"

    PATH="${STUB_DIR}:${PATH}"
}

teardown() {
    rm -rf "${STUB_DIR}"
}

@test "relative dictionary does not leak its host prefix into a following absolute entry" {
    run bash "${SCRIPT}" "http://example.com/"

    [ "${status}" -eq 0 ]
    # relative entry is resolved against the requesting host
    grep -qx 'http://example.com/dict1' "${CURL_LOG}"
    # absolute entry must not inherit the previous dictionary's prefix
    ! grep -q 'dict1http' "${CURL_LOG}"
}
