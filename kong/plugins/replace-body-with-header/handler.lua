-- If you're not sure your plugin is executing, uncomment the line below and restart Kong
-- then it will throw an error which indicates the plugin is being loaded at least.

--assert(ngx.get_phase() == "timer", "The world is coming to an end!")
local cjson = require "cjson.safe"


-- Grab pluginname from module name
local plugin_name = "replace-body-with-header"

-- load the base plugin object and create a subclass
local plugin = require("kong.plugins.base_plugin"):extend()

-- constructor
function plugin:new()
  plugin.super.new(self, plugin_name)
end

function plugin:access(conf)
  plugin.super.access(self)

  local headers = ngx.req.get_headers
  ngx.req.read_body()
  local data = ngx.req.get_body_data()
  cjson.decode_array_with_array_mt(true)
  local json = cjson.decode(data)
  local body_raw = cjson.decode_array_with_array_mt(false)
  json[conf.body] = headers[conf.header]
  ngx.req.set_body_data(body_raw)
  
end 

-- set the plugin priority, which determines plugin execution order
plugin.PRIORITY = 799

-- return our plugin object
return plugin