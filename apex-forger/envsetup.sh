# Path to an AOSP checkout where you've run `m apexer deapexer apksigner`
AOSP=~/local/aosp-upstream

# Path to AOSP host outputs; this is directly used by deapexer
export ANDROID_HOST_OUT="$AOSP/out/host/linux-x86"

# API version of JARs for apexer to use
API_VER=33

# Just for convenience; you shouldn't need to change this
export PATH="$ANDROID_HOST_OUT/bin:$PATH"
