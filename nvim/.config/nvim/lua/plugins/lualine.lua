return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      theme = "auto", -- tema automatico para evitar problemas
      section_separators = { left = "", right = "" }, --separadores a elegir
      component_separators = "",
    },
    sections = {
      lualine_a = { "mode" }, -- modo normal, insert o visual
      lualine_b = {
        {
          "branch",
          icon = "", -- icono de git con la rama actual
        },
      },
      lualine_c = {},
      lualine_x = {},
      lualine_y = { "location" }, -- numeros
      lualine_z = { "progress" }, -- porcentaje
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    extensions = {},
  },
}
