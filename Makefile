#!/bin/make -f
# -*- makefile -*-
# SPDX-License-Identifier: MPL-2.0
#{
# Copyright 2020-present Philippe Coval and other contributors
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/
#}

default: help all

project ?= generic-sensors-webthings

lint: node_modules
	npm run $@

help:
	@echo "## Usage: "
	@echo "# make lint"
	@echo "# make rule/version"
	@echo "# make rule/version/X.Y.Z"

node_modules: package.json
	npm install

rule/version: node_modules
	@echo "# NODE_PATH=$${NODE_PATH}"
	node --version
	npm --version
	npm version

rule/version/%: manifest.json
	-npm version
	-git describe --tags
	sed -e "s|\(\"version\":\) .*|\1 \"${@F}\"|g" -i $<
	-git commit -sm "build: Update version to ${@F}" $<
	npm version patch
