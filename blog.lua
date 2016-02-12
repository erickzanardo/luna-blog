local Articles = require("models.Articles")

return function(app)
  app:get("/", function(self)
    self.articles = Articles:select("ORDER BY date desc LIMIT 10") 
    return { render = "index" }
  end)
  
  app:get("/article/:article_id", function(self)
    local article = Articles:find(self.params.article_id)

    if article == nil then
      return { render = "notfound" }
    else
      self.article = article
      return { render = "article" }
    end
  end)
end
