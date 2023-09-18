#!/bin/bash
set -euo pipefail

MYPATH=$(dirname "$0")
source "$MYPATH/../envsetup.sh"

if test "$#" -ne 2 ; then
	echo "Usage: $(basename "$0") apex dest-dir" >&2
	exit 1
fi

if test -e "$2" ; then
	echo "\"$2\" should not exist" >&2
	exit 2
fi

mkdir "$2"
deapexer extract "$1" "$2/payload"
mv "$2/payload/apex_manifest.pb" "$2"
unzip "$1" -d "$2" apex_build_info.pb
