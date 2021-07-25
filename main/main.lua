local json = require("json")
local t = {
	payload = "Foo Bar"
}
E:response():set_header("Content-Type", "application/json")
E:response():write(json.encode(t))
E:response():status(200)
E:response():flush()
