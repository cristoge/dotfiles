return {
  {
    "rcarriga/nvim-notify",
    opts = {
      stages = "fade_in_slide_out",
      render = "compact",
      timeout = 5000,
      background_colour = "#000000",
      icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "✎",
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    enabled = false,
    -- esto es para ocultar los tabs
  },

  {
    "chrisgrieser/nvim-rip-substitute",
    cmd = "RipSubstitute",
    opts = {},
    keys = {
      {
        "<leader>fs",
        function()
          require("rip-substitute").sub()
        end,
        mode = { "n", "x" },
        desc = " rip substitute",
      },
    },
  },
  {
    "folke/noice.nvim",
    config = function()
      require("noice").setup({
        -- cmdline = {
        --   view = "cmdline", -- Use the cmdline view for the command-line
        -- },
        presets = {
          bottom_search = true, -- Enable bottom search view
          command_palette = true, -- Enable command palette view
          lsp_doc_border = true, -- Enable LSP documentation border
        },
        -- Uncomment the following lines to customize the cmdline popup view
        -- views = {
        --   cmdline_popup = {
        --     filter_options = {},
        --     win_options = {
        --       winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
        --     },
        --   },
        -- },
      })
    end,
  },

  {
    "b0o/incline.nvim",
    event = "BufReadPre", -- Load this plugin before reading a buffer

    priority = 1200, -- Set the priority for loading this plugin
    config = function()
      -- Configurar resaltado inicial
      vim.cmd([[
      highlight InclineNormal guibg=NONE guifg=White
      highlight InclineNormalNC guibg=NONE guifg=White
    ]])

      -- -- Asegurar transparencia en eventos de foco (Command+Tab)
      -- vim.api.nvim_create_autocmd({ "FocusGained", "FocusLost" }, {
      --   callback = function()
      --     vim.cmd([[
      --     highlight InclineNormal guibg=NONE guifg=White
      --     highlight InclineNormalNC guibg=NONE guifg=White
      --   ]])
      --   end,
      -- })

      -- Configurar incline.nvim
      require("incline").setup({
        window = { margin = { vertical = 0, horizontal = 1 } }, -- Set the window margin
        hide = {
          cursorline = true, -- Hide the incline window when the cursorline is active
        },
        highlight = {
          groups = {
            InclineNormal = { guibg = "NONE", guifg = "White" },
            InclineNormalNC = { guibg = "NONE", guifg = "White" },
          },
        },
        render = function(props)
          -- Obtener el nombre del archivo
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename -- Indicar si el archivo está modificado
          end

          -- Obtener el ícono y el color
          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } } -- Renderizar contenido
        end,
      })
    end,
  },

  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        sections = {
          { section = "header" },
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { section = "startup" },
        },
        preset = {
          header = [[




                                                                     
       ████ ██████           █████      ██                     
      ███████████             █████                             
      █████████ ███████████████████ ███   ███████████   
     █████████  ███    █████████████ █████ ██████████████   
    █████████ ██████████ █████████ █████ █████ ████ █████   
  ███████████ ███    ███ █████████ █████ █████ ████ █████  
 ██████  █████████████████████ ████ █████ █████ ████ ██████ 
]],
--
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡾⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣤⡾⠛⠀⠈⢻⣦⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⡾⠛⠉⠁⠀⠀⠀⠀⠀⠉⠉⠛⠛⠳⢶⣤⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⣠⣾⡾⣷⣦⣠⡾⣟⠑⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⢶⣤⡀⠀⢀⣠⣼⡄⠀⠀⠀⠀
-- ⠀⠀⠀⠀⢰⣿⠉⢗⢦⠈⣿⡶⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⠿⠋⠉⢸⣷⠀⠀⠀⠀
-- ⢀⠀⠀⠀⢼⣿⡉⠻⠇⠀⠀⠀⠀⠀⠀⣾⣷⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⠇⡀⠀⠀⠀
-- ⠺⠷⠦⢤⣼⣿⣆⡀⠀⠀⠀⠀⠀⠀⠀⠈⠁⠀⠘⠛⢿⡶⠆⠀⠀⠀⢀⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡟⠀⠀⠀⠀⠀
-- ⠀⠀⠀⢀⣤⡽⠿⠟⠛⠲⠶⣤⣤⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢺⣿⠘⠀⠀⠀⠀⠀⠀⠀⠀⠺⣧⠀⠀⠀⠀⠀
-- ⠀⠀⣴⠋⠁⠀⠀⠀⠀⠀⠀⠀⠈⠙⢯⠉⠛⠳⠶⠦⣤⣄⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣧⠀⠀⠀⠀
-- ⠀⠀⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣇⣴⠶⠛⠛⠛⠛⠛⣿⠓⠀⠀⠀⠀⠀⠀⣀⡀⠀⠀⠀⠀⠀⠀⣿⡆⠀⠀⠀
-- ⠀⠀⢳⡛⠷⣤⣀⣀⣀⣀⣀⣀⣤⠶⣿⡟⠁⠀⠀⠀⠀⠀⣰⠻⢦⣄⣠⣤⡤⠴⣾⡋⠙⠛⠲⠦⠤⣤⣀⣸⣇⠀⠀⠀
-- ⠀⠀⠈⣿⠲⣤⣭⣉⣉⣙⣹⣭⣶⣾⢿⡇⠀⠀⠀⠀⠀⠚⠁⣴⠃⢹⠀⠀⠀⠀⠈⢳⡀⠀⠀⠀⠀⠀⠈⠉⠉⠛⠲⠆
-- ⠀⠀⠀⢹⡆⠸⡆⠈⠉⢹⠁⠀⣼⠇⢸⡿⣆⠀⠀⠀⠀⠀⠀⠁⠀⠘⠀⠀⠀⠀⠀⢈⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⣷⠀⡇⠀⠀⢸⠀⠀⣿⠀⠘⣷⣌⠓⢦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠸⣧⢻⡀⠀⢸⠀⢰⣇⡀⠀⡇⢿⠳⢦⣀⣉⠛⠓⠲⠶⠶⠶⡚⣛⣽⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠙⠿⣷⣶⣾⣿⠿⠋⠙⠻⡇⣿⠀⠀⠀⢹⠛⠛⠛⠛⢛⡟⠋⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⠀⠀⠀⣾⠀⠀⠀⢀⡼⠀⣼⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣷⣄⣠⡇⠀⠀⠀⡾⢁⡾⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠛⠿⠿⠿⠿⠿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ]],
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          -- { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        },
      },
    },
  },
}
