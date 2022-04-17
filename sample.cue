package main

import (
	"github.com/hrk091/openconfig-cue/templates/openconfig:interface"
	"github.com/hrk091/openconfig-cue/templates/openconfig:vlaninterface"
)

(interface.template & {
	port:   1
	noShut: true
	desc:   "hogehoge"
}).output

(interface.template & {
	port:   2
	noShut: false
	mtu:    9216
}).output

(vlaninterface.template & {
	port:   1
	vlanID: 1000
}).output

(vlaninterface.template & {
	port:   1
	vlanID: 1001
}).output

(vlaninterface.template & {
	port:   1
	vlanID: 1002
}).output

(vlaninterface.template & {
	port:   1
	vlanID: 1003
}).output

(vlaninterface.template & {
	port:   2
	vlanID: 1002
}).output

(vlaninterface.template & {
	port:   2
	vlanID: 1003
}).output

(vlaninterface.template & {
	port:   2
	vlanID: 1004
}).output

(vlaninterface.template & {
	port:   2
	vlanID: 1005
}).output
