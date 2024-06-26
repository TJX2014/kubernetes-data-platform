import (
	"vela/ql"
)

parameter: {
	appName:    string
	appNs:      string
	name?:      string
	cluster?:   string
	clusterNs?: string
}
response: ql.#GetApplicationTree & {
	app: {
		name:      parameter.appName
		namespace: parameter.appNs
		filter: {
			if parameter.cluster != _|_ {
				cluster: parameter.cluster
			}
			if parameter.clusterNs != _|_ {
				clusterNamespace: parameter.clusterNs
			}
			if parameter.name != _|_ {
				components: [parameter.name]
			}
		}
	}
}

if response.err == _|_ {
	status: {
		resources: response.list
	}
}
if response.err != _|_ {
	status: {
		error: response.err
	}
}
