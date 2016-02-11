local schema = require("lapis.db.schema")
local types = schema.types

return {
  [1] = function()
    schema.create_table("articles", {
      { "id", types.serial },
      { "title", types.text },
      { "content", types.text },
      { "date", types.date },

      "PRIMARY KEY (id)"
    })
  end
}
