return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio", -- soporte async para dap-ui
      "rcarriga/nvim-dap-ui", -- UI para depuración (paneles de variables, stack, etc.)
      "mfussenegger/nvim-dap-python", -- integración específica para Python
      "theHamsta/nvim-dap-virtual-text", -- muestra valores en la línea del código
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local dap_python = require("dap-python")

      -- Inicializa la UI de depuración
      dapui.setup({})

      -- Muestra variables directamente en el código mientras debuggeas
      require("nvim-dap-virtual-text").setup({
        commented = true,
      })

      -- Usa el intérprete de Mason si existe, si no usa python3
      local mason_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      if vim.fn.executable(mason_path) == 1 then
        dap_python.setup(mason_path)
      else
        dap_python.setup("python3")
      end

      -- Define iconos para breakpoints y estado de ejecución
      vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticSignWarn", linehl = "Visual" })

      -- Abre/cierra automáticamente la UI cuando empieza o termina el debug
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      local opts = { noremap = true, silent = true }

      -- <leader>db -> pone o quita breakpoint en la línea
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, opts)

      -- <leader>dc -> inicia o continua la ejecución
      vim.keymap.set("n", "<leader>dc", dap.continue, opts)

      -- <leader>do -> step over (salta la función, sigue en la siguiente línea)
      vim.keymap.set("n", "<leader>do", dap.step_over, opts)

      -- <leader>di -> step into (entra a la función que está en la línea actual)
      vim.keymap.set("n", "<leader>di", dap.step_into, opts)

      -- <leader>dO -> step out (sale de la función actual)
      vim.keymap.set("n", "<leader>dO", dap.step_out, opts)

      -- <leader>dq -> termina la sesión de depuración
      vim.keymap.set("n", "<leader>dq", dap.terminate, opts)

      -- <leader>du -> abre/cierra manualmente el panel de UI
      vim.keymap.set("n", "<leader>du", dapui.toggle, opts)

      -- <leader>dh -> muestra valor de la variable bajo el cursor
      vim.keymap.set("n", "<leader>dh", function()
        require("dap.ui.widgets").hover()
      end, opts)
    end,
  },
}
