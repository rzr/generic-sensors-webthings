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
addon_name ?= generic-sensors-adapter

addons_url ?= https://github.com/WebThingsIO/addon-list
addons_dir ?= tmp/addon-list
addons_json ?= ${addons_dir}/addons/${addon_name}.json
addons_review_org ?= ${USER}
addons_review_branch ?= sandbox/${USER}/review/master
addons_review_url ?= ssh://github.com/${addons_review_org}/addon-list
addons_review_http_url ?= ${addons_url}/compare/master...${addons_review_org}:${addons_review_branch}?expand=1

lint: node_modules
	npm run $@

help:
	@echo "## Usage:"
	@echo "# make lint"
	@echo "# make rule/version"
	@echo "# make rule/version/X.Y.Z # To update manifest"
	@echo "# make rule/release/X.Y.Z # To update addon-list"

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

rule/addons/push: ${addons_json}
	jq < "$<" > /dev/null
	cd ${<D} \
&& git --no-pager diff \
&& git commit -am "${addon_name}: ${message}"
	@echo "# About to push to ${addons_review_url}"
	@echo "# Stop now with ctrl+c"
	sleep 5
	cd ${<D} \
&& git push ${addons_review_url} -f HEAD:${addons_review_branch}
	@echo "# Request merge at"
	@echo "# ${addons_review_http_url}"

rule/release/%: ${addons_json} # rule/version/%
	sed -e "s|/v[^/]*/|/v${@F}/|g" -i $<
	sed -e "s|\(.*\"version\": \)\"\(.*\)\"\(.*\)|\1\"${@F}\"\3|g" -i $<
	sed -e "s|\(.*/${addon_name}-\)\([0-9.]*\)\(-.*\)|\1${@F}\3|g" -i $<
	${MAKE} rule/checksum/update
	-git diff
	${<D}/../tools/check-list.py ${addon_name}
	${MAKE} rule/addons/push message="Update to ${@F}"

${addons_json}:
	mkdir -p "${addons_dir}"
	git clone ${addons_url} "${addons_dir}"
	jq < "$@"

tmp/urls.lst: ${addons_json}
	jq '.packages[].url' < "$<" | xargs -n1 echo > $@

tmp/checksums.lst: tmp/urls.lst Makefile
	cat $< | while read url ; do \
  curl -L -s -I "$${url}" | grep -r 'HTTP/1.1 {200,302}' > /dev/null \
  && curl -L -s "$${url}" | sha256sum - ; \
done \
| cut -d' ' -f1 | tee $@.tmp
	mv $@.tmp $@

rule/checksum/update: ${addons_json} tmp/checksums.lst
	cp -av "$<" "$<.tmp"
	i=0; \
  cat tmp/checksums.lst | while read sum ; do \
  jq '.packages['$${i}'].checksum |= "'$${sum}'"' < $<.tmp  > $<.out.tmp ; \
  mv "$<.out.tmp" "$<.tmp" ; \
  i=$$(expr 1 + $${i}) ; \
done
	jq < "$<.tmp" > /dev/null
	mv "$<.tmp" "$<"

rule/wait:
	@printf "# Scanning: "
	@while true ; do \
  ${MAKE} rule/urls | grep 'HTTP/1.1 200' && exit 0 \
  || printf "."; \
  sleep 1; \
done

rule/checksum/push: rule/wait rule/checksum/update
	${MAKE} rule/addons/push message="Update checksums from URLs"


