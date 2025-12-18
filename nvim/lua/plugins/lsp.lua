return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      vim.lsp.config("lua_ls", {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim", "assert" }
            }
          }
        }
      })
      vim.lsp.enable("lua_ls")

      vim.lsp.enable("ts_ls")
      vim.lsp.enable("tailwindcss")
      vim.lsp.enable("eslint")

      -- Format on save
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("my.lsp", {}),
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

          if client.name == "ts_ls" then
            return
          end

          if client.name == "eslint" then
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = vim.api.nvim_create_augroup("my.lsp.eslint", { clear = false }),
              buffer = args.buf,
              callback = function()
                -- Only run if the command exists (prevents errors if plugin/command isn't loaded)
                -- exists function returns 2 for Ex commands, in this case 'LspEslintFixAll'
                if vim.fn.exists(":LspEslintFixAll") == 2 then
                  vim.cmd("LspEslintFixAll")
                end
              end,
            })

            return
          end

          if not client:supports_method("textDocument/willSaveWaitUntil")
              and client:supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
              end,
            })
          end
        end,
      })
    end,
  }
}
