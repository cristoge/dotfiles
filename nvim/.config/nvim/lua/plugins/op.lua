return {
  "nickjvandyke/opencode.nvim",
  version = "*",
  dependencies = {
    {
      "folke/snacks.nvim",
      optional = true,
      opts = {
        input = {},
        picker = {
          actions = {
            opencode_send = function(...)
              return require("opencode").snacks_picker_send(...)
            end,
          },
          win = {
            input = {
              keys = {
                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
              },
            },
          },
        },
      },
    },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      lsp = { enabled = true },
      server = {
        start = function()
          require("snacks.terminal").open("opencode --port", {
            win = {
              position = "right",
              enter = false,
              on_win = function(win)
                require("opencode.terminal").setup(win.win)
              end,
            },
          })
        end,
        stop = function()
          require("snacks.terminal").get("opencode --port", {}):close()
        end,
        toggle = function()
          require("snacks.terminal").toggle("opencode --port", {
            win = {
              position = "right",
              enter = false,
              on_win = function(win)
                require("opencode.terminal").setup(win.win)
              end,
            },
          })
        end,
      },
    }
    vim.o.autoread = true
    vim.keymap.set({ "n", "x" }, "<leader>aa", function()
      require("opencode").ask("@this: ")
    end, { desc = "Ask opencode" })
    vim.keymap.set({ "n", "x" }, "<leader>as", function()
      require("opencode").select()
    end, { desc = "Select opencode action" })
    vim.keymap.set({ "n", "t" }, "<leader>at", function()
      require("opencode").toggle()
    end, { desc = "Toggle opencode" })
    vim.keymap.set("n", "<leader>au", function()
      require("opencode").command("session.half.page.up")
    end, { desc = "Scroll opencode up" })
    vim.keymap.set("n", "<leader>ad", function()
      require("opencode").command("session.half.page.down")
    end, { desc = "Scroll opencode down" })
  end,
}
