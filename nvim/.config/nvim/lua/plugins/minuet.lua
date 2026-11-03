return {
  {
    "milanglacier/minuet-ai.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("minuet").setup({
        provider = "openai_fim_compatible",
        provider_options = {
          openai_fim_compatible = {
            api_key = "DEEPSEEK_API_KEY", -- nombre de la variable de entorno
            name = "deepseek",
            end_point = "https://api.deepseek.com/beta/completions",
            model = "deepseek-flash",
            optional = { max_tokens = 256, top_p = 0.9 },
          },
        },
        virtualtext = {
          auto_trigger_ft = { "*" }, -- sugerencias automáticas en todos los archivos
          keymap = {
            accept = "<A-A>", -- aceptar la sugerencia entera
            accept_line = "<A-a>", -- aceptar solo una línea
            next = "<A-]>", -- siguiente sugerencia (o pedir una)
            prev = "<A-[>", -- anterior
            dismiss = "<A-e>", -- descartar
          },
        },
      })
    end,
  },

  -- <Tab> acepta la sugerencia de minuet, igual que el extra de Copilot de LazyVim
  {
    "milanglacier/minuet-ai.nvim",
    opts = function()
      LazyVim.cmp.actions.ai_accept = function()
        local vt = require("minuet.virtualtext").action
        if vt.is_visible() then
          LazyVim.create_undo()
          vt.accept()
          return true
        end
      end
    end,
  },
}
