package main

import (
	"strconv"

	ocif "github.com/hrk091/openconfig-cue/services/openconfig:interface"
	ocvif "github.com/hrk091/openconfig-cue/services/openconfig:vlaninterface"
)

// Input Syntax
services: {
	interfaces: [device=_]: [port=_]: ocif.#Input & {
		"device": device
		"port":   strconv.Atoi(port)
	}
	vlans: [device=_]: [port=_]: [vlanID=_]: ocvif.#Input & {
		"device": device
		"port":   strconv.Atoi(port)
		"vlanID": strconv.Atoi(vlanID)
	}
}

// Input
services: {
	interfaces: {
		"oc01": {
			"1": {
				noShut: true
				desc:   "hogehoge"
			}
		}
		"oc02": {
			"2": {
				noShut: false
				mtu:    9216
			}
		}
	}
	vlans: {
		"oc01": {
			"1": {
				"1001": _
				"1002": _
				"1003": _
				"1004": _
			}
		}
		"oc02": {
			"2": {
				"1001": _
				"1002": _
				"1003": _
				"1004": _
			}
		}
	}
}

// TODO implement in core
for _, v in services.interfaces {
	for _, i in v {
		(ocif.#Template & {
			input: i
		}).output
	}
}

for _, v in services.vlans {
	for _, vv in v {
		for _, i in vv {
			(ocvif.#Template & {
				input: i
			}).output
		}
	}
}
