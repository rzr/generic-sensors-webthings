#!/bin/sh
# -*- coding: utf-8 -*-
# SPDX-License-Identifier: MPL-2.0
# Copyright 2019-present Samsung Electronics Co., Ltd. and other contributors
#{
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/ .
#}

set -e
set -x

this_dir=$(dirname -- "$0")
this_dir=$(realpath "${this_dir}")
this_name=$(basename -- "$0")
top_dir="${this_dir}/../../.."
archive_name="generic-sensors-adapter"
project="mozilla-iot-${archive_name}"
architecture=$(basename "${this_dir}")
api="v8"
name="${project}-${architecture}-${api}"
dir="/usr/local/src/${project}"
tag=$(git describe --tags || echo v0.0.0)
version=$(echo "${tag}" | cut -dv -f2 | cut -d'-' -f1)
file="${this_dir}/tmp/dist/${archive_name}-${version}-${architecture}-${api}.tgz"

mkdir -p "${this_dir}/local" "${this_dir}/tmp"
time docker build -t "${name}" -f "${this_dir}/Dockerfile" .
docker run "${name}" ls "${dir}"
container=$(docker create "${name}")
docker cp "${container}:$dir/dist" "${this_dir}/tmp"
tmp_file=$(ls "${this_dir}/tmp/dist/${archive_name}"* | head -n1 \
               || echo "/tmp/${USER}/failure.tmp")
mv -v "${tmp_file}" "${file}"
sha256sum "${file}"
