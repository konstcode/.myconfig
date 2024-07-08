local servers = {
  -- See `:help lspconfig-all` for a list of all the pre-configured LSPs
  tsserver = {},
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities =
  vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities =
              vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    init = function()
      -- Configure rustaceanvim here
      vim.g.rustaceanvim = {}
    end,
    lazy = false,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      --
      -- Useful status updates for LSP.
      { "j-hui/fidget.nvim", opts = {} },

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { "folke/lazydev.nvim", opts = {} },
    },
    config = function()
      local lspconfig = require("lspconfig")

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "stylua", -- Used to format Lua code
      })
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
      lspconfig.lua_ls.setup({})

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end
          local builtin = require("telescope.builtin")
          map("K", vim.lsp.buf.hover, "Hover Documentation")

          -- Jump to the definition of the word under your cursor.
          -- This is where a variable was first declared, or where a function is defined, etc.
          -- To jump back, press <C-t>.
          map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

          -- Find references for the word under your cursor.
          map("gr", builtin.lsp_references, "[G]oto [R]eferences")

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup =
              vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
              end,
            })
          end
        end,
      })
    end,
  },
}
