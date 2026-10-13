#!/usr/bin/env bash
set -euo pipefail

CACHE="${CI_PROJECT_DIR:-$PWD}/.cache"
IPS_PKG="/root/.fhir/packages/fhir.hsi.ips#${IPS_VERSION}"

export JAVA_TOOL_OPTIONS="-XX:MaxRAMPercentage=70.0"

mkdir -p "$CACHE/fhir-packages" "$CACHE/txcache" /root/.fhir
rm -rf /root/.fhir/packages
ln -sfn "$CACHE/fhir-packages" /root/.fhir/packages
rm -rf input-cache/txcache
ln -sfn "$CACHE/txcache" input-cache/txcache

if [ ! -d "$IPS_PKG" ]; then
  rm -rf /root/.fhir/packages/fhir.hsi.ips#*
  mkdir -p "$IPS_PKG"
  curl -sSfL https://ips.ri.hsisalud.org/package.tgz | tar -xz -C "$IPS_PKG"
fi

npm install -g fsh-sushi

bash _genonce.sh

cp package-list.json output/package-list.json
cp package-feed.xml output/package-feed.xml
test -f output/package.tgz
