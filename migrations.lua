local schema = require("lapis.db.schema")
local db = require("lapis.db")
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
  end;
  [2] = function()
    schema.create_table("authors", {
      { "id", types.serial },
      { "name", types.text },
      { "email", types.text },
      { "password", types.text },

      "PRIMARY KEY (id)"
    })

    schema.add_column("articles", "author_id", types.foreign_key)
    db.query("ALTER TABLE articles ADD CONSTRAINT author_fk FOREIGN KEY (author_id) REFERENCES authors (id)")
  end
}
