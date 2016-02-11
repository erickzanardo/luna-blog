require("models.Article")

local lapis = require("lapis")

local app = lapis.Application()
app:enable("etlua")
app.layout = require "views.layout"

app:get("/", function(self)
  self.articles = Articles:select("ORDER BY date desc LIMIT 10") 
  return { render = "index" }
end)

app:get("/article/:article_id", function(self)
  local article = Articles:find(self.params.article_id)
  self.article = article
  return { render = "article" }
end)

return app
