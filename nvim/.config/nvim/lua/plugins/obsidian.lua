return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = "vault",
        path = "~/vault",
      },
    },
    frontmatter = {
      enabled = true,
      func = function(note)
        local out = {}
        -- conserva las propiedades que ya tenga la nota
        if note.metadata ~= nil then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end
        out.id = note.id
        out.aliases = note.aliases
        out.tags = note.tags
        -- solo pone la fecha si no existía, para no pisarla al guardar
        if out.creado == nil then
          out.creado = os.date("%Y-%m-%d")
        end
        return out
      end,
    },
  },
}
