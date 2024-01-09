#!/bin/bash
set -euo pipefail

MYPATH=$(dirname "$0")
source "$MYPATH/common.sh"

if test "$#" -lt 1 ; then
	echo "Usage: $(basename "$0") key.x509.pem ..." >&2
	exit 1
fi

touch "$PUBLIC_APK_KEYS"
COUNT_OLD=$(wc -l <"$PUBLIC_APK_KEYS")

for KEY in "$@" ; do
	openssl x509 -in "$KEY" -noout -fingerprint -sha256 \
		| cut -d'=' -f2 \
		| tr '[:upper:]' '[:lower:]' \
		| tr -d ':' \
		>>"$PUBLIC_APK_KEYS"
done

# Remove duplicates
sort -u -o "$PUBLIC_APK_KEYS" "$PUBLIC_APK_KEYS"

COUNT_NEW=$(wc -l <"$PUBLIC_APK_KEYS")
echo "Added $((COUNT_NEW - COUNT_OLD)) new keys"
