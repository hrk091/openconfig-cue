package main

import (
	"list"
	"strconv"

	ocif "github.com/hrk091/openconfig-cue/services/openconfig:interface"
	ocvif "github.com/hrk091/openconfig-cue/services/openconfig:vlaninterface"
)

// Input Syntax
services: {
	ocInterfaces: [device=_]: [port=_]: ocif.#Input & {
		"device": device
		"port":   strconv.Atoi(port)
	}
	ocVlans: [device=_]: [port=_]: [vlanID=_]: ocvif.#Input & {
		"device": device
		"port":   strconv.Atoi(port)
		"vlanID": strconv.Atoi(vlanID)
	}
}

// Input
services: {
	ocInterfaces: {
		"oc01": {
			for i, v in list.Repeat([0], 5) {
				"\(i+1)": {
					noShut: true
					desc:   "foo"
				}
			}
		}
		"oc02": {
			for i, v in list.Repeat([0], 5) {
				"\(i+1)": {
					noShut: false
					mtu:    9216
				}
			}
		}
	}
	ocVlans: {
		"oc01": {
			for i, v in list.Repeat([0], 2) {
				"\(i+1)": {
					for j, v in list.Repeat([0], 3) {
						"\(j+1000)": _
					}
				}
			}
		}
		"oc02": {
			for i, v in list.Repeat([0], 3) {
				"\(i+1)": {
					for j, v in list.Repeat([0], 2) {
						"\(j+1000)": _
					}
				}
			}
		}
	}
}

// TODO implement in core
for _, v in services.ocInterfaces {
	for _, i in v {
		(ocif.#Template & {
			input: i
		}).output
	}
}

for _, v in services.ocVlans {
	for _, vv in v {
		for _, i in vv {
			(ocvif.#Template & {
				input: i
			}).output
		}
	}
}
