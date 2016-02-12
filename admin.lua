local Authors = require("models.Authors")
local Articles = require("models.Articles")
local crypto = require("crypto")

return function(app)

  local home = function(self)
    self.current_author = self.session.current_author

    local tab = self.params.tab or "articles"
    self.tab = tab

    if tab == "articles" then
      self.articles = Articles:select()
    elseif tab == "authors" then
      self.authors = Authors:select()
    end

    return { render = "admin.home", layout = "admin.layout" }
  end

  app:get("/admin", home)

  app:get("/admin/:tab", function(self)
    if not self.session.current_author then
      self.errors = self.params.error == "true"
      return { render = "admin.login", layout = "admin.layout" }
    else
      return home(self)
    end
  end)

  app:post("/admin/login", function(self)
    local password = crypto.digest("md5", self.params.password)
    local email = self.params.email

    local author = Authors:find({ email = email, password = password})

    if not author then
      return { redirect_to = "/admin?error=true" }
    else
      self.session.current_author = { id = author.id, name = author.name, email = author.email }
      return { redirect_to = "/admin" }
    end
  end)

  app:get("/admin/logout", function(self)
    self.session.current_author = nil
    return { redirect_to = "/admin" }
  end)
end
