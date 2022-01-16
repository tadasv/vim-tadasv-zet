#!/bin/bash
cd "$(dirname "${0}")"
stamp=$(TZ=UTC date +%Y%m%d%H)
while [ -f "z/${stamp}" ]; do
	stamp=$(printf '%08d' "$[${stamp} + 1]")
done

printf 'z/%s\n' "${stamp}"
