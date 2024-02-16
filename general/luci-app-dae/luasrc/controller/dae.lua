local sys  = require "luci.sys"
local http = require "luci.http"

module("luci.controller.dae", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/dae") then
		return
	end

	local page = entry({"admin", "services", "dae"}, cbi("dae"), _("DAE"), -1)
	page.dependent = true
	page.acl_depends = { "luci-app-dae" }

	entry({"admin", "services", "dae", "status"}, call("act_status")).leaf = true
end

function act_status()
	local e = {}
	e.running = sys.call("pgrep -x /usr/bin/dae >/dev/null") == 0
	http.prepare_content("application/json")
	http.write_json(e)
end
