package interface

import (
	ocdemo "github.com/hrk091/openconfig-go-structure/pkg/ocdemo"
)

template: {
	port:   uint16
	noShut: bool
	desc:   string | *""
	mtu:    uint16 | *9000

	let _portName = "Ethernet\(port)"

	output: ocdemo.#Device & {
		Interface: "\(_portName)": ocdemo.#Interface & {
			Name:        _portName
			Description: desc
			Enabled:     noShut
			AdminStatus: 1
			OperStatus:  1
			Type:        1
			Mtu:         mtu
		}
	}
}
