local fs = require "nixio.fs"
local sys = require "luci.sys"
local m, s

m = Map("dae", translate("DAE"))
m.description = translate("A Linux high-performance transparent proxy solution based on eBPF.")

m:section(SimpleSection).template = "dae/dae_status"

s = m:section(TypedSection, "dae")
s.addremove = false
s.anonymous = true

o = s:option(Flag, "enabled", translate("Enabled"))
o.rmempty = false

o = s:option(Button, "_reload", translate("Reload Service"), translate("Reload the service effective configuration file."))
o.write = function()
	sys.exec("/etc/init.d/dae reload")
end

-- cbid
o = s:option(TextValue, "daeconf", translate("Configuration Editor"))
o.rows = 25
o.rmempty = true
o.wrap = "off"

-- readfile
function o.cfgvalue(self, section)
	return fs.readfile("/etc/dae/config.dae")
end

-- writefile
function o.write(self, section, value)
	value = value:gsub("\r\n?", "\n")
	fs.writefile("/etc/dae/config.dae", value)
end

-- html codemirror-5.65.13
o = s:option(DummyValue, "")
o.template = "dae/dae_editor"

return m
