package vlaninterface

import (
	ocdemo "github.com/hrk091/openconfig-go-structure/pkg/ocdemo"
)

#Input: {
	device: string
	port:   uint16
	vlanID: uint32
}

#Template: {
	input: #Input

	let _portName = "Ethernet\(input.port)"

	output: devices: "\(input.device)": {
		ocdemo.#Device
		Interface: "\(_portName)": Subinterface: "\(input.vlanID)": {
			ocdemo.#Interface_Subinterface
			Ifindex:     input.port
			Index:       input.vlanID
			Name:        "\(_portName).\(input.vlanID)"
			AdminStatus: 1
			OperStatus:  1
			Type: ocdemo.#IETFInterfaces_InterfaceType_l2vlan
			...
		}

		_member: "\(input.vlanID)": "\(_portName)": {
			InterfaceRef: Interface:    "\(_portName)"
			InterfaceRef: Subinterface: input.vlanID
		}

		Vlan: "\(input.vlanID)": {
			ocdemo.#Vlan
			VlanId: input.vlanID
			Name:   "VLAN\(input.vlanID)"
			Status: ocdemo.#Vlan_Status_ACTIVE
			Tpid:   ocdemo.#OpenconfigVlanTypes_TPID_TYPES_UNSET
			Member: [for _, v in _member["\(input.vlanID)"] {v}]
			...
		}
		...
	}
}
