#!/bin/bash -e
# SPDX-License-Identifier: MPL-2.0

date=$(git log -1 --date=short --pretty=format:%cd || date -u)

rm -rf node_modules

if [ -z "${ADDON_ARCH}" ]; then
  TARFILE_SUFFIX=
else
  NODE_VERSION="$(node --version)"
  TARFILE_SUFFIX="-${ADDON_ARCH}-${NODE_VERSION/\.*/}"
fi

npm install --production

shasum --algorithm 256 manifest.json package.json *.js LICENSE README.md > SHA256SUMS

find node_modules \( -type f -o -type l \) -exec shasum --algorithm 256 {} \; >> SHA256SUMS

TARFILE="$(npm pack)"

tar xzf ${TARFILE}
rm ${TARFILE}
TARFILE_ARCH="${TARFILE/.tgz/${TARFILE_SUFFIX}.tgz}"
cp -r node_modules ./package
GZIP="-n" tar czf "${TARFILE_ARCH}" --mtime="${date}" package

shasum --algorithm 256 ${TARFILE_ARCH} > ${TARFILE_ARCH}.sha256sum

rm -rf SHA256SUMS package
