return {

  "CRAG666/code_runner.nvim",
  config = function()
    require("code_runner").setup({

      float = {
        close_key = "<ESC>",
        -- Window border (see ':h nvim_open_win')
        border = "none",

        -- Num from `0 - 1` for measurements
        height = 0.8,
        width = 0.8,
        x = 0.5,
        y = 0.5,

        -- Highlight group for floating window/border (see ':h winhl')
        border_hl = "FloatBorder",
        float_hl = "Normal",

        -- Transparency (see ':h winblend')
        blend = 0,
      },
      filetype = {
        java = {
          "cd $dir &&",
          "javac $fileName &&",
          "java $fileNameWithoutExt",
        },
        python = "python3 -u",
        cs = {
          "dotnet run",
        },
        go = {
          "go run",
        },
        typescript = "ts-node",
        javascript = "node",
        rust = {
          "cd $dir &&",
          "rustc $fileName &&",
          "$dir/$fileNameWithoutExt",
        },
        c = function(...)
          c_base = {
            "cd $dir &&",
            "gcc $fileName -o",
            "/tmp/$fileNameWithoutExt",
          }
          local c_exec = {
            "&& /tmp/$fileNameWithoutExt &&",
            "rm /tmp/$fileNameWithoutExt",
          }
          vim.ui.input({ prompt = "Add more args:" }, function(input)
            c_base[4] = input
            vim.print(vim.tbl_extend("force", c_base, c_exec))
            require("code_runner.commands").run_from_fn(vim.list_extend(c_base, c_exec))
          end)
        end,
      },
    })
  end,
}
