# MOZILLA IOT GENERIC SENSORS ADAPTER #

[![GitHub forks](https://img.shields.io/github/forks/rzr/mozilla-iot-gateway-sensors-adapter.svg?style=social&label=Fork&maxAge=2592000)](https://GitHub.com/rzr/mozilla-iot-gateway-sensors-adapter/network/)
[![license](https://img.shields.io/badge/license-Apache-2.0.svg)](LICENSE)
[![Build Status](https://api.travis-ci.org/rzr/mozilla-iot-gateway-sensors-adapter.svg?branch=master)](https://travis-ci.org/rzr/mozilla-iot-gateway-sensors-adapter)
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Frzr%2Fmozilla-iot-generic-sensors-adapter.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Frzr%2Fmozilla-iot-generic-sensors-adapter?ref=badge_shield)


## INTRODUCTION: ##

Addons for Mozilla IoT gateway, built on "generic-sensor-lite" module to abstract I2C driver
by a stable API (W3C generic sensors).

[![webthing-iotjs-tizenrt-cdl2018-20181117rzr](https://image.slidesharecdn.com/webthing-iotjs-tizenrt-cdl2018-20181117rzr-181118110813/95/webthingiotjstizenrtcdl201820181117rzr-23-638.jpg)](https://slideshare.net/slideshow/embed_code/key/GWBOzbFaez5hcJ#webthing-iotjs-tizenrt-cdl2018-20181117rzr "webthing-iotjs-tizenrt-cdl2018-20181117rzr")


## USAGE: ##

* Install mozilla-iot gateway (0.4.0+) on supported system
* Enable I2C if not present (Enable ssh, log in, run raspi-config)
* It was tested on Raspberry PI 3 along 2 I2C sensors supported by "generic-sensors-lite" module

Check following wiki page for more details:

* https://github.com/rzr/webthing-iotjs/wiki/Addons


Default things are using hardware sensors, but simulators can be added explicitly from the UI:
From configure page add device, select sensorType among (ambientlight, temperature or color)
and type as multiLevelSensor (or customSensor eg: ColorSensor) then properties should be added,
First is "on" as boolean, next is "level" as number or "color" as string.


## DEMO: ##

[![mozilla-iot-gateway-sensors-20180406rzr.webm](https://i.vimeocdn.com/video/693119286.jpg)](https://player.vimeo.com/video/263556462#mozilla-iot-gateway-sensors-20180406rzr "Video Demo")

[![mozilla-iot-gateway-sensors-20180406rzr.png](https://i1.wp.com/s-opensource.org/wp-content/uploads/2018/04/mozilla-iot-gateway-sensors-20180406rzr.png)](https://www.slideshare.net/rzrfreefr/webthingiotjs20181022rzr-120959360/12# "Rules")


## RESOURCES: ##

* https://github.com/rzr/mozilla-iot-generic-sensors-adapter
* https://discourse.mozilla.org/t/creating-i2c-add-on/26696/4
* https://www.npmjs.com/package/generic-sensors-lite
* https://github.com/mozilla-iot/addon-list/pull/54
* https://iot.mozilla.org/
* https://iot.mozilla.org/wot/
* https://www.npmjs.com/~rzr
* https://s-opensource.org/author/philcovalsamsungcom/
* irc://irc.mozilla.org/#iot
* https://github.com/mozilla-iot/gateway/issues/1567


## LICENSE: Apache-2.0 ##

[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Frzr%2Fmozilla-iot-generic-sensors-adapter.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Frzr%2Fmozilla-iot-generic-sensors-adapter?ref=badge_large)
