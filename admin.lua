local Authors = require("models.Authors")
local crypto = require("crypto")

return function(app)
  app:get("/admin", function(self)
    if not self.session.current_author then
      self.errors = self.params.error == "true"
      return { render = "admin.login", layout = "admin.layout" }
    else
      self.current_author = self.session.current_author
      return { render = "admin.home", layout = "admin.layout" }
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
end
