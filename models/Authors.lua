local Model = require("lapis.db.model").Model

return Model:extend("authors", {
  relations = {
    { "articles", has_many = "Articles" }
  }
})
