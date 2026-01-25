# ESP8266 Lua/NodeMCU module for TEMT6000 illuminance sensors

This repository provides an ESP8266 NodeMCU Lua module (`temt6000.lua`) as well
as MQTT / HomeAssistant / InfluxDB integration example (`init.lua`) for
**TEMT6000** illuminance sensors connected via analog output.

## Dependencies

temt6000.lua has been tested with Lua 5.1 on NodeMCU firmware 3.0.1 (Release
202112300746, integer build). It requires the following modules.

* adc

Most practical applications (such as the example in init.lua) also need the
following modules.

* gpio
* mqtt
* node
* tmr
* wifi

## Setup

Connect the TEMT6000 sensor to your ESP8266/NodeMCU board as follows.

* TEMT6000 GND → ESP8266/NodeMCU GND
* TEMT6000 VCC → ESP8266/NodeMCU 3V3
* TEMT6000 OUT → ESP8266/NodeMCU A0

Note that the TEMT6000 output will range from 0V to 3V3, whereas ESP8266 A0
only accepts up to 1V. Most NodeMCU boards use a voltage divider to connect
NodeMCU A0 to ESP8266 A0 and are capable of handling up to 3V3 at A0.

## Usage

Copy **temt6000.lua** to your NodeMCU board and set it up as follows.

```lua
temt6000 = require("temt6000")

-- can be called as often as the ADC permits
function some_timer_callback()
	local lx = temt6000.read()
	if lx ~= nil then
		-- lx: estimated illuminance [lx]
		-- Note that lx is limited to a usable range of about 20 to 1000 lx.
		-- Darkness cannot always be detected reliably,
		-- anything brighter than ~1024 lx will be reported as 1024 lx.
	else
		print("TEMT6000 error")
	end
end
```

## Application Example

**init.lua** is an example application with HomeAssistant integration.
To use it, you need to create a **config.lua** file with WiFI and MQTT settings:

```lua
station_cfg = {ssid = "...", pwd = "..."}
mqtt_host = "..."
```

Optionally, it can also publish readings to InfluxDB.
To do so, configure URL and attribute:

```lua
influx_url = "..."
influx_attr = "..."
```

Readings will be published as `temt6000[influx_attr] illuminance_lx=%d,adc_counts=%d`.
So, unless `influx_attr = ''`, it must start with a comma, e.g. `influx_attr = ',device=' .. device_id`.

## References

Mirrors of this repository are maintained at the following locations:

* [Chaosdorf](https://chaosdorf.de/git/derf/esp8266-nodemcu-temt6000)
* [Finalrewind](https://git.finalrewind.org/derf/esp8266-nodemcu-temt6000)
* [GitHub](https://github.com/derf/esp8266-nodemcu-temt6000)
