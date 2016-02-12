local blog = require("blog")
local admin = require("admin")

local lapis = require("lapis")

local app = lapis.Application()
app:enable("etlua")
app.layout = require "views.layout"

-- Init blog routes
blog(app)

-- Initi admin routes
admin(app)

return app
