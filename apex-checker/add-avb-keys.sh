#!/bin/bash
set -euo pipefail

MYPATH=$(dirname "$0")
source "$MYPATH/common.sh"

if test "$#" -lt 1 ; then
	echo "Usage: $(basename "$0") key.avbpubkey ..." >&2
	exit 1
fi

touch "$PUBLIC_AVB_KEYS"
COUNT_OLD=$(wc -l <"$PUBLIC_AVB_KEYS")

for KEY in "$@" ; do
	if test "$(stat -c'%s' "$KEY")" -ne 1032 ; then
		echo "$KEY doesn't look like an AVB key file; should be 1032 bytes" >&2
		exit 2
	fi

	sha256sum "$KEY" | cut -d' ' -f1 >>"$PUBLIC_AVB_KEYS"
done

# Remove duplicates
sort -u -o "$PUBLIC_AVB_KEYS" "$PUBLIC_AVB_KEYS"

COUNT_NEW=$(wc -l <"$PUBLIC_AVB_KEYS")
echo "Added $((COUNT_NEW - COUNT_OLD)) new keys"
