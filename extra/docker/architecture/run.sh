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


for run in ${this_dir}/*/run.sh ; do
    $run
done
