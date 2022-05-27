package main

import (
	"strconv"

	"github.com/hrk091/openconfig-cue/templates/openconfig:interface"
	"github.com/hrk091/openconfig-cue/templates/openconfig:vlaninterface"
//	ocdemo "github.com/hrk091/openconfig-go-structure/pkg/ocdemo"
)

// Input Syntax
services: {
	interfaces: [device=string]: [port=string]: interface.#Input & {
		"device": device
		"port":   strconv.Atoi(port)
	}
	vlans: [device=string]: [port=string]: [vlanID=string]: vlaninterface.#Input & {
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
		(interface.#Template & {
			input: i
		}).output
	}
}

for _, v in services.vlans {
	for _, vv in v {
		for _, i in vv {
			(vlaninterface.#Template & {
				input: i
			}).output
		}
	}
}
