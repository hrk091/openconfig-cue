package vlaninterface

import (
	ocdemo "github.com/hrk091/openconfig-go-structure/pkg/ocdemo"
)

template: {
	port:   uint16
	vlanID: uint32

	let _portName = "Ethernet\(port)"

	output: {
		Interface: "\(_portName)": Subinterface: "\(vlanID)": ocdemo.#Interface_Subinterface & {
			Ifindex:     port
			Index:       vlanID
			Name:        "\(_portName).\(vlanID)"
			AdminStatus: 1
			OperStatus:  1
		}
		Vlan: "\(vlanID)": {
			VlanId: vlanID
			Name:   "VLAN\(vlanID)"
			Status: ocdemo.#Vlan_Status_ACTIVE
			Tpid:   ocdemo.#OpenconfigVlanTypes_TPID_TYPES_UNSET
			// Member: [{
			//  InterfaceRef: Interface:    "\(_portName)"
			//  InterfaceRef: Subinterface: vlanID
			// }]
		}
	}
}
