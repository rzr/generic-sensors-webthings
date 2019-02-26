/**
 * Copyright 2018-present Samsung Electronics Co., Ltd. and other contributors
 * index.js - Loads the Generic Sensors adapter.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.*
 */

'use strict';

const fs = require('fs');

function maybeLoadGenericSensorsAdapter(addonManager, manifest, errorCallback) {
  try {
    fs.accessSync('/dev/i2c-1', fs.constants.W_OK);
  } catch (err) {
    errorCallback(manifest.name, 'No permissions for I2C resources');
    return;
  }

  const loadGenericSensorsAdapter = require('./generic-sensors-adapter');
  return loadGenericSensorsAdapter(addonManager, manifest, errorCallback);
}

module.exports = maybeLoadGenericSensorsAdapter;
