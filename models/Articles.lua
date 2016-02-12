local Model = require("lapis.db.model").Model

return Model:extend("articles", {
  relations = {
    { "author", belongs_to = "Authors" }
  }
})
